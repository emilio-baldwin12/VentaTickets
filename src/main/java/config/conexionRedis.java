
package config;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class conexionRedis {
    private static JedisPool pool;
    
    public static JedisPool getPool(){
        if(pool==null){
            JedisPoolConfig poolConfig=new JedisPoolConfig();
            poolConfig.setMaxTotal(20);
            
            pool=new JedisPool(poolConfig,"localhost",6379);
                }
        return pool;
}
    public static Jedis getConnection(){//Para obtener una conexión limpia
        return getPool().getResource();
    }
    
    public static void closePool(){//Para cerrar el pool cuando se apague el servidor
        if(pool !=null){
            pool.destroy();
        }
    }
}
