List<Player> players = Stream.generate(Player::generateRandom).distinct().limit
			(10).collect(Collectors.toList());	 
List<Match> matches = Stream.generate(() -> generateRandomMatch(players))
    			.filter(m -> m.getOponents().getPlayer1() != m.getOponents()
			.getPlayer2())
    			.limit(30)
    			.collect(Collectors.toList());
highScores.clear();
		try (Scanner scanner = new Scanner(new File("scoreFile.txt")).useDelimiter("[;\\n]")) {
			while(scanner.hasNext()) {
				String name = scanner.next();
				int value = scanner.nextInt();
				System.out.println(name+value);
				highScores.add(new Score(name, value));
			}
			tableScoreT.setItems((ObservableList<Score>) highScores);
		} catch (IOException e) {
			e.printStackTrace();
		}

try(PrintWriter pw = new PrintWriter(new FileWriter("scoreFile.txt"))) {
			for (Score score: highScores) {
				pw.printf("%s;%d\n", score.getName(), score.getScore());
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

Serializace
try (
FileOutputStream fileOut =
new FileOutputStream("/tmp/employee.ser");
ObjectOutputStream out = new ObjectOutputStream(fileOut);
out.writeObject(e);
out.close();
fileOut.close();
System.out.printf("Serialized data saved in /tmp/employee.ser");
) catch (IOException i) (
i.printStackTrace();
)
