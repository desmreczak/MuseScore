import QtQuick 2.0
import MuseScore 1.0

MuseScore {
      version:  "1.0"
      description: "Create random score."
      menuPath: "Plugins.createscore"

      onRun: {
            var measures    = 18;
            var numerator   = 3;
            var denominator = 4;
            var octaves     = 2;
            var key         = 3;

            var score = newScore("Random.mscz", "Piano", measures);

            score.addText("title", "==Random==");
            score.addText("subtitle", "subtitle");

            var cursor = score.newCursor();
            cursor.track = 0;

            cursor.rewind(0);

            var ts = newElement(Element.TIMESIG);
            ts.setSig(numerator, denominator);
            cursor.add(ts);

            if (key != 0) {
                var sig = newElement(Element.KEYSIG);
                sig.setSig(0, key);
                cursor.add(sig);
                }

            cursor.rewind(0);
            cursor.setDuration(1, denominator);

            var cdur = [ 0, 2, 4, 5, 7, 9, 11 ];
            //           c  g  d  e
            var keyo = [ 0, 7, 2, 4 ];

            var notes = measures * numerator;

            for (var i = 0; i < notes; ++i) {
                var idx    = Math.random() * 6;
                var octave = Math.floor(Math.random() * 2);
                var pitch  = cdur[Math.floor(idx)] + octave * 12 + 60;
                var pitch  = pitch + keyo[key];

                var note   = cursor.addNote(pitch);
                cursor.next();
                }
            Qt.quit();
            }
      }

