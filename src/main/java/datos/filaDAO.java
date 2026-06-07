
package datos;

/**
 *
 * @author luise
 */
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
public class filaDAO {
    private static final JedisPool pool = new JedisPool("localhost", 6379);
    private static final int MAX_COMPRADORES_SIM = 1;
    
    public void unirseFila(int idConcierto, int idUsuario) {
        try (Jedis redis = pool.getResource()) {
            String key = "fila:concierto:" + idConcierto;
            
            if (redis.zrank(key, String.valueOf(idUsuario)) == null) {
                double score = System.currentTimeMillis();
                redis.zadd(key, score, String.valueOf(idUsuario));
            }
        }
    }

    public long obtenerPosicion(int idConcierto, int idUsuario) {
        try (Jedis redis = pool.getResource()) {
            String key = "fila:concierto:" + idConcierto;
            Long rank = redis.zrank(key, String.valueOf(idUsuario));
            
            if (rank == null) return -1;// No está en la fila
            
            return rank + 1; 
        }
    }

    public boolean puedeComprar(int idConcierto, int idUsuario) {
        try (Jedis redis = pool.getResource()) {
            String key = "fila:concierto:" + idConcierto;
            Long rank = redis.zrank(key, String.valueOf(idUsuario));
            
            if (rank == null) return false;

            return rank < MAX_COMPRADORES_SIM;
        }
    }

    public void salirDeFila(int idConcierto, int idUsuario) {
        try (Jedis redis = pool.getResource()) {
            String key = "fila:concierto:" + idConcierto;
            redis.zrem(key, String.valueOf(idUsuario));
        }
    }
}
