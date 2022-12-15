use flutter_rust_bridge::SyncReturn;


pub fn count_plus(count: i32) -> SyncReturn<i32> {
    SyncReturn(count + 1)
}
