
package datos;

/**
 *
 * @author luise
 */
import config.conexionRedis;
import redis.clients.jedis.Jedis;
public class filaDAO {
    public void entrarFila(int eventoId,int usuarioId){
        try (Jedis jedis=conexionRedis.getConnection()){
            String key= "fila:evento" + eventoId;
            double score=System.currentTimeMillis();//EL tiempo actual en mili
            jedis.zadd(key, score,String.valueOf(usuarioId));
        }
    }
    public Long posicion(int eventoId,int usuarioId){
        try(Jedis jedis=conexionRedis.getConnection()){
            String key="fila:evento:" + eventoId;
            return jedis.zrank(key, String.valueOf(usuarioId));
        }
    }
    public void salirFila(int eventoId,int usuarioId){
        try (Jedis jedis=conexionRedis.getConnection()){
            String key= "fila:evento:"+ eventoId;
            jedis.zrem(key, String.valueOf(usuarioId));
        }
    }
}
