import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class MIDITest extends AnyFlatSpec with ChiselScalatestTester {
  object cfg extends TinySynthConfig {}

  "MIDI" should "pass" in {
    test(new MIDI(cfg)) { dut =>
      dut.io.uartIn.enqueueNow(8.U)
    }
  }
}
