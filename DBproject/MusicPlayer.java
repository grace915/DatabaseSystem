import javax.xml.transform.Result;
import java.sql.*;
import java.util.ArrayList;
import java.util.Scanner;

public class MusicPlayer {

    private static Scanner sc = new Scanner(System.in);
    private static Statement stmt;
    private static int userId;

    public static void main(String[] args) {

        try {

            // mariadb jconnect driver q
            Class.forName("org.mariadb.jdbc.Driver");

            // DBMS
            String url = "jdbc:mariadb://127.0.0.1:3306/musicplayer";
            String user = "root";
            String pw = "170807";
            Connection con = DriverManager.getConnection(url, user, pw);
            stmt = con.createStatement();

            start();

            // after app finished
            stmt.close();
            con.close();

            System.out.println("\nThank you, Bye.");


        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void line() {

        System.out.println("------------------------------");

    }

    private static void start() throws SQLException {

        while (true) {
            line();
            System.out.println("Music Player");
            System.out.println("1. Login");
            System.out.println("2. Sign Up");
            System.out.println("0. Exit");
            line();

            System.out.print("* Enter number : ");
            String input = sc.nextLine();

            if (Integer.parseInt(input) == 0) break;
            else if (Integer.parseInt(input) == 1) {
                login();
            } else if (Integer.parseInt(input) == 2) {
                signUp();
            } else {
                System.out.println("Wrong number!");
                continue;

            }
            menu();

        }


    }

    private static void login() throws SQLException {


        int result;

        line();
        System.out.println("[ LOGIN ]");


        while (true) {

            System.out.print(" * Enter email : ");
            String email = sc.nextLine();
            System.out.print(" * Enter password : ");
            String pw = sc.nextLine();

            ResultSet rs = stmt.executeQuery(String.format("SELECT * FROM user WHERE email = '%s' AND pw = '%s'", email, pw));

            rs.last();
            int resultNum = rs.getRow();

            if (resultNum != 0) {

                String name = rs.getString("name");
                line();
                System.out.println(String.format("Hello, %s.", name));

                result = rs.getInt("id");

                rs.close();

                break;

            } else {

                rs.close();

                System.out.println("\nWrong information! Please try again.");

            }

        }
        userId = result;


    }

    private static void signUp() throws SQLException {


        line();
        System.out.println("[ SIGN UP ]");

        while (true) {

            System.out.print(" * Enter email : ");
            String email = sc.nextLine();
            ResultSet rs = stmt.executeQuery("SELECT email FROM user");
            rs.beforeFirst();
            int check = 0;
            //email duplicate


            while (rs.next()) {
                if (rs.getString("email").equals(email)) {
                    System.out.println("Same email exists!");
                    check = 1;
                    break;
                }
            }

            rs.close();


            if (check == 0) {
                System.out.print(" * Enter password : ");
                String pw = sc.nextLine();
                System.out.print(" * Enter name : ");
                String name = sc.nextLine();
                System.out.print(" * Enter registration number : ");
                String registration = sc.nextLine();
                System.out.println("* Do you have Administrator rights?");
                int manage = sc.nextInt();
                sc.nextLine();


                //not null
                if (pw.equals("") || name.equals("") || registration.equals("") || (manage != 0 && manage != 1)) {
                    System.out.println("wrong write");
                    continue;
                }
                ResultSet rs1 = stmt.executeQuery(String.format("SELECT registration FROM user"));
                rs1.first();
                //registration duplicate
                while (rs1.next()) {
                    if (rs1.getString("registration").equals(registration)) {
                        System.out.println("Duplicated registration");
                        check = 1;
                        break;
                    }
                }


                if (check == 0) {
                    ResultSet rs2 = stmt.executeQuery(String.format("INSERT INTO user VALUES (NULL, '%s', '%s', '%s', '%s', %s)", email, pw, name, registration, manage));

                    rs2.close();
                    System.out.println("Success!");
                    break;

                }
            }

        }
        login();

    }


    private static void menu() throws SQLException {
        while (true) {

            line();
            System.out.println("[ MAIN MENU ]");
            System.out.println("1. Show all");
            System.out.println("2. Playlist");
            System.out.println("3. Music chart");
            System.out.println("4. Search");
            System.out.println("5. Manage");
            System.out.println("0. Exit");
            line();

            System.out.print(" * Enter number : ");
            int input = sc.nextInt();
            sc.nextLine();

            if (input == 0) break;
            else if (input == 1) showAll();
            else if (input == 2) playList();
            else if (input == 3) musicChart();
            else if (input == 4) search();
            else if (input == 5) manage();
            else {
                System.out.println("Wrong number!");
                continue;
            }

        }

    }

    private static void showAll() throws SQLException {
        while (true) {

            line();
            System.out.println("[ Show All ]");
            System.out.println("1. Show all Musics");
            System.out.println("2. Show all albums");
            System.out.println("3. Show all artists");
            System.out.println("0. Go Back");
            line();

            System.out.print(" * Enter number : ");
            int input = sc.nextInt();
            sc.nextLine();

            if (input == 0) break;
            else if (input == 1) showMusics();
            else if (input == 2) showAlbums();
            else if (input == 3) showArtists();
            else {
                System.out.println("Wrong number!");
                continue;
            }

        }


    }


    private static void showMusics() throws SQLException {

        while (true) {

            line();
            System.out.println("[ MUSIC LIST ]");
            System.out.println("Click on the music to see the details.");

            ResultSet rs = stmt.executeQuery("SELECT * FROM music");


            while (rs.next()) {


                int musicId = rs.getInt("id");
                ResultSet rs1 = stmt.executeQuery(String.format("SELECT * FROM music_release as mr, artist " +
                        "WHERE mr.artist = artist.id and mr.music = %s ", musicId));

                String musicName = rs.getString("name");
                rs1.first();
                String artist = rs1.getString("artist.name");

                System.out.println(musicId + ". " + musicName + " - " + artist);
                rs1.close();

            }


            System.out.println("\n0. Go Back");
            System.out.print(" * Enter number : ");
            int input = sc.nextInt();
            sc.nextLine();

            rs.close();

            if (input == 0) {
                break;
            } else {
                musicDetails(input);
            }

        }

    }

    private static void musicDetails(int musicId) throws SQLException {

        while (true) {

            //music detail
            line();
            System.out.println("[ MUSIC DETAIL ]");

            ResultSet rs1 = stmt.executeQuery(String.format("SELECT * FROM music WHERE id = %s", musicId));

            rs1.first();

            String name = rs1.getString("name");
            String genre = rs1.getString("genre");
            String lyrics = rs1.getString("lyrics");
            String release_date = rs1.getString("release_date");
            int album = rs1.getInt("album");
            String shortenLyrics = rs1.getString("shortenLyrics");
            rs1.close();

            ResultSet rs2 = stmt.executeQuery(String.format("SELECT COUNT(*) as count FROM user_recommend WHERE music = %s", musicId));
            rs2.first();
            String count = rs2.getString("count");
            rs2.close();

            ResultSet rs10 = stmt.executeQuery(String.format("SELECT * FROM user_play, music WHERE user_play.user = %s AND user_play.music = music.id and music.id = %s", userId, musicId));
            rs10.first();
            int play = 0;
            if(rs10.next()){
                play = rs10.getInt("user_play.count");
            }



            System.out.println(String.format("Name : %s", name));


            ResultSet rs3 = stmt.executeQuery(String.format("SELECT name FROM album WHERE id = %s", album));

            rs3.first();

            String albumName = rs3.getString("name");

            rs3.close();

            System.out.println(String.format("album : %s", albumName));


            System.out.println(String.format("Genre : %s", genre));
            System.out.println(String.format("Release Date : %s", release_date));
            System.out.println(String.format("Recommend : %s", count));
            System.out.println(String.format("Lyrics : %s", shortenLyrics));
            System.out.println(String.format("My Play : %s", play));
            line();

            //recommend

            ResultSet rs4 = stmt.executeQuery(String.format("SELECT COUNT(*) as count FROM user_recommend WHERE music = %s AND user = %s", musicId, userId));

            rs4.first();

            String recommend = rs4.getString("count");

            rs4.close();

            //menu
            if (Integer.parseInt(recommend) == 1) {
                System.out.println("1. Cancel Recommendation");
            } else {
                System.out.println("1. Recommendation");
            }


            System.out.println("2. Show comments");
            System.out.println("3. Write comment");
            System.out.println("4. Add to playlist");
            System.out.println("5. Show full lyrics");
            System.out.println("0. Go Back");
            line();

            System.out.print(" * Enter number : ");
            int input = sc.nextInt();
            sc.nextLine(); // solve newline

            if (input == 0) break;

                //recommend
            else if (input == 1) {

                if (Integer.parseInt(recommend) == 1) {

                    ResultSet rs5 = stmt.executeQuery(String.format("DELETE FROM user_recommend WHERE user = %s AND music = %s", userId, musicId));
                    rs5.close();

                } else {

                    ResultSet rs5 = stmt.executeQuery(String.format("INSERT INTO user_recommend VALUES (%s, %s)", userId, musicId));
                    rs5.close();

                }

            }
            // comment list
            else if (input == 2) {

                line();
                System.out.println("[ COMMENTS ]");

                ResultSet rs5 = stmt.executeQuery(String.format("SELECT uc.text, user.name FROM user_comment as uc, user WHERE music = %s AND uc.user = user.id", musicId));

                while (rs5.next()) {

                    String commentText = rs5.getString("user_comment.text");
                    String userName = rs5.getString("user.name");

                    System.out.println(commentText + " - " + userName);

                }

                rs5.close();

                // wait
                line();
                System.out.println("\n0. Go Back");
                System.out.print(" * Enter number : ");
                sc.nextLine();

            }
            //write comment
            else if (input == 3) {

                System.out.print(" Comment : ");
                String inputComment = sc.nextLine();

                ResultSet rs6 = stmt.executeQuery(String.format("SELECT * FROM user_comment WHERE user = %s AND music = %s", userId, musicId));
                rs6.last();
                if (rs6.getRow() != 0) {
                    System.out.println("Exist!");
                    break;
                }
                ResultSet rs5 = stmt.executeQuery(String.format("INSERT INTO user_comment VALUES (%s, %s, '%s')", userId, musicId, inputComment));
                rs5.close();

            }
            //add to playlist
            else if (input == 4) {

                line();
                System.out.println("[ ADD TO PLAYLIST ]");

                System.out.println("Select playlist to add music.");

                ResultSet rs5 = stmt.executeQuery(String.format("SELECT * FROM playlist WHERE user = %s", userId));

                int cnt = 1;
                ArrayList<String> playlist = new ArrayList<>();

                while (rs5.next()) {

                    String playlistName = rs5.getString("name");

                    playlist.add(playlistName);

                    System.out.println(cnt + ". " + playlistName);

                    cnt++;

                }
                rs5.close();

                if (playlist.size() == 0) {
                    System.out.println("No Playlist");
                    continue;
                }


                System.out.print(" * Enter number : ");
                int input2 = sc.nextInt();
                sc.nextLine();

                if (input2 > playlist.size()) {
                    System.out.println("Wrong number!");
                    continue;
                }

                String targetName = playlist.get(input2 - 1);
                ResultSet rs = stmt.executeQuery(String.format("SELECT * FROM playlist_registered"));

                int check = 0;

                while (rs.next()) {

                    if (rs.getInt("user") == userId && rs.getString("name").equals(targetName) && rs.getInt("music") == musicId) {
                        System.out.println("music Duplicate!");
                        check = 1;
                        break;
                    }


                }
                if (check == 0) {

                    ResultSet rs6 = stmt.executeQuery(String.format("INSERT INTO playlist_registered VALUES (%s, '%s', %s)", userId, targetName, musicId));
                    rs6.close();

                }
                rs.close();


            } else if (input == 5) {
                line();
                System.out.println(lyrics);

                System.out.println("\n0. Go Back");
                System.out.print("* Enter number : ");
                sc.nextLine();

            } else {
                System.out.println("Wrong number!");
                continue;
            }
        }


    }

    private static void showAlbums() throws SQLException {


        while (true) {


            line();
            System.out.println("[ ALBUM LIST ]");
            System.out.println("Enter number to see the details.");


            ResultSet rs = stmt.executeQuery("SELECT * FROM album, album_produce, artist WHERE album_produce.artist = artist.id AND album_produce.album = album.id");

            while (rs.next()) {

                int albumNum = rs.getInt("album.id");
                String albumName = rs.getString("album.name");
                String albumDate = rs.getString("album.release_date");
                String artistName = rs.getString("artist.name");

                System.out.println(albumNum + ". " + albumName + " - " + artistName + " - " + albumDate);

            }


            System.out.println("\n0. Go Back");
            System.out.print(" * Enter number : ");
            int album = sc.nextInt();
            sc.nextLine();

            if (album == 0) break;
            else albumDetails(album);
        }

    }

    private static void albumDetails(int album) throws SQLException {
        while (true) {

            //album detail
            line();
            System.out.println("[ ALBUM DETAIL ]");

            ResultSet rs1 = stmt.executeQuery(String.format("SELECT * FROM album WHERE id = %s", album));

            rs1.first();

            String name = rs1.getString("name");
            String genre = rs1.getString("genre");
            String release_date = rs1.getString("release_date");

            rs1.close();

            ResultSet rs2 = stmt.executeQuery(String.format("SELECT COUNT(*) as count FROM user_like WHERE album = %s", album));

            rs2.first();

            String count = rs2.getString("count");

            rs2.close();

            System.out.println(String.format("Name : %s", name));
            System.out.println(String.format("Release Date : %s", release_date));
            System.out.println(String.format("Genre : %s", genre));
            System.out.println(String.format("like : %s", count));


            ResultSet rs3 = stmt.executeQuery(String.format("SELECT * FROM music WHERE album = %s", album));
            while (rs3.next()) {
                System.out.println(rs3.getString("name"));
            }


            //like

            ResultSet rs4 = stmt.executeQuery(String.format("SELECT COUNT(*) as count FROM user_like WHERE album = %s AND user = %s", album, userId));

            rs4.first();

            String like = rs4.getString("count");

            rs4.close();
            line();

            //menu
            if (Integer.parseInt(like) == 1) {
                System.out.println("1. Cancel like");
            } else {
                System.out.println("1. like");
            }
            System.out.println("2. Play album");
            System.out.println("\n0. Go Back");
            System.out.print(" * Enter number : ");
            int input = sc.nextInt();
            sc.nextLine();

            if (input == 0) break;

                //like
            else if (input == 1) {

                if (Integer.parseInt(like) == 1) {

                    ResultSet rs6 = stmt.executeQuery(String.format("DELETE FROM user_like WHERE user = %s AND album = %s", userId, album));
                    rs6.close();

                } else {
                    ResultSet rs6 = stmt.executeQuery(String.format("INSERT INTO user_like VALUES (%s, %s)", userId, album));
                    rs6.close();
                }

            } else if (input == 2) {
                rs3.beforeFirst();
                while (rs3.next()) {
                    System.out.println("[ Play Album ]");
                    playMusic(rs3.getInt("id"));
                }

            }

        }
    }

    private static void showArtists() throws SQLException {

        while (true) {


            line();
            System.out.println("[ ARTIST LIST ]");
            System.out.println("Enter number to see the artist's musics");


            ResultSet rs = stmt.executeQuery("SELECT * FROM artist");

            while (rs.next()) {

                int artistNum = rs.getInt("artist.id");
                String artistName = rs.getString("artist.name");
                String artistDebut = rs.getString("artist.debut");
                System.out.println(artistNum + "." + artistName + " ( " + artistDebut + " ) ");

            }


            System.out.println("\n0. Go Back");
            System.out.print(" * Enter number : ");
            int artist = sc.nextInt();
            sc.nextLine();

            if (artist == 0) break;
            else {

                //artist music
                line();
                System.out.println("[ ARTIST'S MUSICS ]");


                ResultSet rs3 = stmt.executeQuery(String.format("SELECT * FROM music, music_release, artist WHERE artist.id = %s AND music_release.artist = artist.id AND music_release.music = music.id", artist));
                while (rs3.next()) {
                    System.out.println(rs3.getString("name"));
                }

                System.out.println("\n0. Go back");
                System.out.print(" * Enter number : ");
                sc.nextLine();


            }
        }


    }

    private static void playList() throws SQLException {

        while (true) {

            line();
            System.out.println("[ PLAYLISTS ]");
            System.out.println("1. My playlists");
            System.out.println("2. Add playlist");
            System.out.println("3. Delete playlist");
            System.out.println("4. Show all playlists");
            System.out.println("0. Go Back");

            System.out.print(" * Enter number : ");
            int input = sc.nextInt();
            sc.nextLine();

            if (input == 0) break;
                //myplaylist
            else if (input == 1) showPlaylist();
                //add playlist
            else if (input == 2) {

                line();
                System.out.println("[ ADD PLAYLIST ]");
                System.out.print(" * Enter playlist name : ");
                String name = sc.nextLine();

                System.out.print(" * Is this playlist public? (Y or N) : ");
                String publicYN = sc.nextLine();

                int publicNum = 0;
                if (publicYN.equals("Y") || publicYN.equals("y")) publicNum = 1;


                ResultSet rs = stmt.executeQuery(String.format("INSERT INTO playlist VALUES (%s, '%s', %s)", userId, name, publicNum));
                System.out.println("Success!");
                rs.close();

            }
            //delete playlist
            else if (input == 3) {

                line();
                System.out.println("[ DELETE PLAYLIST ]");
                System.out.println("Select playlist to delete.");

                ResultSet rs = stmt.executeQuery(String.format("SELECT * FROM playlist WHERE user = %s", userId));

                int cnt = 1;
                ArrayList<String> playlist = new ArrayList<>();

                while (rs.next()) {

                    String playlistName = rs.getString("name");

                    playlist.add(playlistName);

                    System.out.println(cnt + ". " + playlistName);

                    cnt++;

                }
                System.out.println("\n0. Go Back");

                if (playlist.size() == 0) {
                    System.out.println("No Playlist");
                    continue;
                }

                System.out.print(" * Enter number : ");
                int input2 = sc.nextInt();
                sc.nextLine(); // solve newline

                if (input2 == 0) {
                    continue;
                }

                if (input2 > playlist.size()) {
                    System.out.println("Wrong number!");
                    continue;
                }

                rs.close();

                ResultSet rs2 = stmt.executeQuery(String.format("DELETE FROM playlist WHERE user = %s AND name = '%s'", userId, playlist.get(input2 - 1)));
                System.out.println("Success!");

                rs2.close();

            }
            // all playlist
            else if (input == 4) {

                line();
                ResultSet rs = stmt.executeQuery("SELECT  * FROM playlist WHERE public = 1 ");
                int cnt = 1;

                ArrayList<String> playlist = new ArrayList<>();
                ArrayList<Integer> user = new ArrayList<>();
                while (rs.next()) {

                    int userId = rs.getInt("user");
                    user.add(userId);
                    String playlistName = rs.getString("name");

                    playlist.add(playlistName);

                    System.out.println(cnt + ". " + playlistName);

                    cnt++;

                }

                rs.close();

                System.out.println("\n0. Go Back");
                System.out.print(" * Enter a number if you want to play a playlist : ");
                int input2 = sc.nextInt();
                sc.nextLine();

                line();
                if (input2 == 0) {
                    continue;
                }
                if (input2 > playlist.size()) {
                    System.out.println("Wrong number!");
                    continue;
                }
                playPlaylist(user.get(input2 - 1), playlist.get(input2 - 1));

            } else {
                System.out.println("Wrong number!");
                break;
            }

        }

    }

    private static void showPlaylist() throws SQLException {
        while (true) {

            line();
            System.out.println("[ MY PLAYLIST ]");

            ResultSet rs = stmt.executeQuery(String.format("SELECT * FROM playlist WHERE user = %s", userId));

            int cnt = 1;
            ArrayList<String> playlist = new ArrayList<>();

            while (rs.next()) {


                String playlistName = rs.getString("name");

                playlist.add(playlistName);

                System.out.println(cnt + ". " + playlistName);

                cnt++;

            }
            rs.close();
            System.out.println("\n0. Go Back");

            if (playlist.size() == 0) {
                System.out.println("No Playlist");
                break;
            }

            System.out.print(" * Enter number if you want to Play : ");
            int input2 = sc.nextInt();
            sc.nextLine(); // solve newline


            if (input2 == 0) {
                break;
            }

            line();
            if (input2 > playlist.size()) {
                System.out.println("Wrong number!");
                break;
            }

            ResultSet rs1 = stmt.executeQuery(String.format("SELECT * FROM playlist_registered, music WHERE playlist_registered.music = music.id AND user = %s AND playlist_registered.name = '%s'", userId, playlist.get(input2 - 1)));
            rs1.last();
            if (rs1.getRow() == 0) {

                System.out.println("No musics");

                break;

            }
            rs1.beforeFirst();
            while (rs1.next()) {
                System.out.println(rs1.getInt("music.id") + ". " + rs1.getString("music.name"));
            }
            rs1.close();
            System.out.println("\n1. Play");
            System.out.println("2. Delete music");
            System.out.println("0. Go Back");
            System.out.print("* Enter number : ");
            int input3 = sc.nextInt();
            sc.nextLine();
            line();
            if (input3 == 0) break;
            else if (input3 == 1) playPlaylist(userId, playlist.get(input2 - 1));
            else if (input3 == 2) {
                System.out.print("* Enter number : ");
                int input4 = sc.nextInt();
                sc.nextLine();
                ResultSet rs2 = stmt.executeQuery(String.format("DELETE FROM playlist_registered WHERE user = %s AND name = '%s' AND music = %s", userId, playlist.get(input2 - 1), input4));
                rs2.close();
            } else {
                System.out.println("Wrong number!");
                break;
            }


            rs.close();
        }


    }

    private static void playPlaylist(int userId, String name) throws SQLException {
        while (true) {
            System.out.println("[Play list - " + name + " ]");
            System.out.println("1. Play");
            System.out.println("0. Go Back");


            ResultSet rs = stmt.executeQuery(String.format("SELECT * FROM playlist_registered WHERE user = %s AND name = '%s'", userId, name));
            rs.last();
            if (rs.getRow() == 0) {
                System.out.println("No musics");
                break;
            }
            rs.close();
            ResultSet rs1 = stmt.executeQuery(String.format("SELECT * FROM playlist_registered As ps, music  WHERE ps.music = music.id  AND ps.name = '%s' AND ps.user = %s", name, userId));

            int cnt = 1;
            ArrayList<String> musics = new ArrayList<>();

            line();
            while (rs1.next()) {

                String musicName = rs1.getString("music.name");

                musics.add(musicName);

                System.out.println("(" + cnt + ") " + musicName);

                cnt++;

            }

            System.out.print(" * Enter number : ");
            int input = sc.nextInt();
            sc.nextLine();
            if (input == 0) break;
            else if (input == 1) {

                ResultSet rs2 = stmt.executeQuery(String.format("SELECT * FROM playlist_registered WHERE user = %s AND name = '%s'", userId, name));
                while (rs2.next()) {
                    playMusic(rs2.getInt("music"));
                }
                line();
            }

        }


    }

    private static void playMusic(int musicId) throws SQLException {
        ResultSet rs = stmt.executeQuery(String.format("SELECT * FROM user_play WHERE user = %s AND music = %s", userId, musicId));
        ResultSet rs1 = stmt.executeQuery(String.format("SELECT * FROM music WHERE id = %s", musicId));
        rs1.first();
        System.out.println("< " + rs1.getString("name") + " >");
        System.out.println(rs1.getString("shortenLyrics"));

        rs.last();
        if (rs.getRow() == 0) {
            ResultSet rs2 = stmt.executeQuery(String.format("INSERT INTO user_play VALUES (%s, %s, %s)", userId, musicId, 1));
            rs2.close();
        } else {
            ResultSet rs2 = stmt.executeQuery(String.format("UPDATE user_play SET count = count+1"));
            rs2.close();
        }
        rs.close();


    }

    private static void musicChart() throws SQLException {

        line();
        System.out.println("[ MUSIC Chart ]");

        ResultSet rs = stmt.executeQuery("SELECT count, music, SUM(count) FROM user_play GROUP BY music ORDER BY count DESC");

        int cnt = 1;

        while (rs.next()) {

            if (cnt > 100) break;

            String musicId = rs.getString("music");

            ResultSet rs2 = stmt.executeQuery(String.format("SELECT * FROM music WHERE id = %s", musicId));

            rs2.first();

            String musicName = rs2.getString("name");

            rs2.close();

            String count = rs.getString("count");

            System.out.println("(" + cnt + ") " + musicName + " : " + count);

            cnt++;

        }

        rs.close();


        System.out.println("\n0. Go Back");
        System.out.print(" * Enter number : ");
        sc.nextLine();


    }

    private static void search() throws SQLException {
        line();
        System.out.println("[ SEARCH ]");

        System.out.print(" * Enter word to search : ");
        String query = sc.nextLine();


        ResultSet rs = stmt.executeQuery(String.format("SELECT * FROM music WHERE name LIKE '%%%s%%'", query));

        System.out.println("< Music >");
        while (rs.next()) {

            String name = rs.getString("name");
            System.out.println(name);

        }

        rs.close();

        ResultSet rs2 = stmt.executeQuery(String.format("SELECT * FROM artist WHERE name LIKE '%%%s%%'", query));

        System.out.println("< Artist >");
        while (rs2.next()) {

            String name = rs2.getString("name");
            System.out.println(name);

        }

        rs2.close();

        ResultSet rs3 = stmt.executeQuery(String.format("SELECT * FROM album WHERE name LIKE '%%%s%%'", query));

        System.out.println("< Album >");
        while (rs3.next()) {

            String name = rs3.getString("name");
            System.out.println(name);

        }

        rs3.close();


        System.out.println("\n0. Go Back");
        System.out.print(" * Enter number : ");
        sc.nextLine();

    }


    private static void manage() throws SQLException {
        ResultSet rs = stmt.executeQuery(String.format("SELECT manage FROM user WHERE id = %s ", userId));
        rs.first();
        if (rs.getInt("manage") == 0) {
            System.out.println("You have no authority!");
            return;
        }

        while (true) {
            line();
            System.out.println("[ MANAGE ]");
            System.out.println("1. Manage Music");
            System.out.println("2. Manage User");
            System.out.println("3. Manage album");
            System.out.println("4. Manage artist");
            System.out.println("0. Go Back");

            System.out.print(" * Enter number : ");
            int input = sc.nextInt();
            sc.nextLine();

            if (input == 0) break;
                //add music
            else if (input == 1) {
                manageMusic();
            } else if (input == 2) {
                manageUsers();
            } else if (input == 3) {
                manageAlbum();
            } else if (input == 4) {
                manageArtist();
            } else {
                System.out.println("Wrong number!");
                break;
            }


        }
    }

    private static void manageMusic() throws SQLException {
        while (true) {
            line();
            System.out.println("[ Manage Music ]");
            System.out.println("1. Add Music");
            System.out.println("2. Delete Music");
            System.out.println("3. Update Music");
            System.out.println("0. Go Back");


            System.out.print(" * Enter number : ");
            int input = sc.nextInt();
            sc.nextLine();

            if (input == 0) break;
            else if (input == 1) {
                line();
                System.out.println("[ ADD MUSIC ]");
                System.out.print(" * Enter name : ");
                String name = sc.nextLine();
                System.out.print(" * Enter genre : ");
                String genre = sc.nextLine();

                System.out.print(" * Enter lyrics : ");
                StringBuilder lyrics = new StringBuilder();
                while (sc.hasNextLine()) {
                    String s = sc.nextLine();
                    if (!s.equals("-end")) {
                        lyrics.append(s).append("\n");
                    } else break;
                }

                System.out.print(" * Enter shortenLyrics : ");
                String shortenLyrics = sc.nextLine() + "...";

                System.out.print(" * Enter release date : ");
                String date = sc.nextLine();


                ResultSet rs = stmt.executeQuery(String.format("SELECT id, name FROM album "));
                while (rs.next()) {
                    System.out.println(rs.getInt("id") + "." + rs.getString("name"));
                }
                System.out.print(" * Select album ID : ");
                int album = sc.nextInt();
                sc.nextLine();

                ResultSet rs1 = stmt.executeQuery(String.format("SELECT id, name FROM artist "));
                while (rs1.next()) {
                    System.out.println(rs1.getInt("id") + "." + rs1.getString("name"));
                }
                System.out.print(" * Select artist ID : ");
                int artist = sc.nextInt();
                sc.nextLine();
                rs.close();
                rs1.close();

                System.out.print(" * Enter Writers : ");
                StringBuilder writers = new StringBuilder();
                while (sc.hasNextLine()) {
                    String s = sc.nextLine();
                    if (!s.equals("-end")) {
                        writers.append(s).append(",");
                    } else break;
                }

                System.out.print(" * Enter Composers : ");
                StringBuilder composers = new StringBuilder();
                while (sc.hasNextLine()) {
                    String s = sc.nextLine();
                    if (!s.equals("-end")) {
                        composers.append(s).append(",");
                    } else break;
                }


                //add music
                ResultSet rs2 = stmt.executeQuery(String.format("INSERT INTO music VALUES (NULL, '%s', '%s', '%s', '%s', %s, '%s')", name, genre, lyrics, date, album, shortenLyrics));
                rs2.close();

                ResultSet rs3 = stmt.executeQuery(String.format("SELECT id FROM music order by id desc"));
                rs3.first();

                // add artist
                ResultSet rs4 = stmt.executeQuery(String.format("INSERT INTO music_release VALUES(%s, %s)", artist, rs3.getInt("id")));
                rs4.close();

                //add writers
                String[] wr = writers.toString().split(",");
                for (String s : wr) {

                    ResultSet rs5 = stmt.executeQuery(String.format("INSERT INTO music_writer VALUES ('%s', %s)", s, rs3.getInt("id")));


                    rs5.close();
                }

                //add composer
                String[] cp = composers.toString().split(",");
                for (String s : cp) {
                    ResultSet rs5 = stmt.executeQuery(String.format("INSERT INTO music_composer VALUES ('%s', %s)", s, rs3.getInt("id")));

                    rs3.close();
                    rs5.close();
                }

                rs3.close();


                System.out.println("Success!");


            }
            //delete music
            else if (input == 2) {
                line();
                System.out.println("[ DELETE MUSIC ]");
                System.out.println("Select music to delete.");

                ResultSet rs = stmt.executeQuery(String.format("SELECT * FROM music"));

                while (rs.next()) {

                    int musicId = rs.getInt("id");
                    String musicName = rs.getString("name");

                    System.out.println(musicId + ". " + musicName);

                }


                System.out.println("\n0. Go Back");

                System.out.print(" * Enter number : ");
                int input_ = sc.nextInt();
                sc.nextLine(); // solve newline

                if (input_ == 0) continue;
                else {

                    ResultSet rs2 = stmt.executeQuery(String.format("DELETE FROM music WHERE id = %s", input_));
                    rs2.close();


                }
                System.out.println("Success!");

            } else if (input == 3) {

                line();
                System.out.println("[ EDIT MUSIC ]");

                ResultSet rs = stmt.executeQuery(String.format("SELECT * FROM music"));


                ArrayList<String> musicName = new ArrayList<>();
                while (rs.next()) {
                    String musicN = rs.getString("name");

                    musicName.add(musicN);

                    System.out.println(rs.getInt("id") + ". " + musicN);


                }
                System.out.println("\n0. Go Back");
                System.out.print("* Select Number : ");
                int input2 = sc.nextInt();
                sc.nextLine();
                if(input2 == 0) break;
                if (input2 > musicName.size()) {
                    System.out.println("Wrong number!");
                    break;
                }

                ResultSet rs2 = stmt.executeQuery(String.format("SELECT * FROM music WHERE id = %s", input2));

                rs2.first();
                System.out.println(String.format("Original name : %s", rs2.getString("name")));
                System.out.print(" * Enter new name : ");
                String newName = sc.nextLine();

                System.out.println(String.format("Original Lyrics : %s", rs2.getString("lyrics")));
                System.out.print(" * Enter new lyrics : ");
                StringBuilder newLyrics = new StringBuilder();

                while (sc.hasNextLine()) {
                    String s = sc.nextLine();
                    if (!s.equals("-end")) {
                        newLyrics.append(s).append("\n");
                    } else break;
                }

                System.out.print(" * Enter shortenLyrics : ");
                String shortenLyrics = sc.nextLine();


                ResultSet rs4 = stmt.executeQuery(String.format("UPDATE music SET name = '%s', lyrics = '%s' , shortenLyrics = '%s' WHERE id = %s", newName, newLyrics, shortenLyrics, input2));
                rs4.close();

                System.out.println("Success!");

            } else {
                System.out.println("Wrong number!");
                break;
            }

        }
    }

    private static void manageUsers() throws SQLException {
        while (true) {
            line();
            System.out.println("[ MANAGE USER ]");
            ResultSet rs = stmt.executeQuery("SELECT * FROM user WHERE manage = 0");

            ArrayList<String> users = new ArrayList<>();
            while (rs.next()) {
                String userN = rs.getString("name");

                users.add(userN);

                System.out.println(rs.getInt("id") + ". " + userN);


            }

            System.out.println("\n0. Go Back");

            System.out.print("* Select user to edit : ");
            int input = sc.nextInt();
            sc.nextLine();


            if (input == 0) break;
            else {
                ResultSet rs1 = stmt.executeQuery(String.format("SELECT * FROM user WHERE id = %s", input));
                rs1.first();
                System.out.println(String.format("Original name : %s", rs1.getString("name")));
                System.out.print(" * Enter new name : ");
                String newName = sc.nextLine();

                System.out.println(String.format("Original pw : %s", rs1.getString("pw")));
                System.out.print(" * Enter new pw : ");
                String newPw = sc.nextLine();


                ResultSet rs2 = stmt.executeQuery(String.format("UPDATE user SET name = '%s', pw = '%s' WHERE id = %s", newName, newPw, input));
                rs1.close();
                rs2.close();

            }
        }


    }

    private static void manageAlbum() throws SQLException {


        while (true) {

            line();
            System.out.println("[ MANAGE ALBUMS ]");
            System.out.println("1. Show albums");
            System.out.println("2. Add album");
            System.out.println("0. Go Back");

            System.out.print(" * Enter number : ");
            int input = sc.nextInt();
            sc.nextLine(); // solve newline

            if (input == 0) break;
            else if (input == 1) {

                line();
                System.out.println("[ ALBUM LIST ]");

                ResultSet rs = stmt.executeQuery("SELECT * FROM album, album_produce, artist WHERE album_produce.artist = artist.id AND album_produce.album = album.id");

                while (rs.next()) {

                    int albumNum = rs.getInt("album.id");
                    String albumName = rs.getString("album.name");
                    String albumDate = rs.getString("album.release_date");
                    String artistName = rs.getString("artist.name");

                    System.out.println("(" + albumNum + ") " + albumName + " - " + artistName + " - " + albumDate);

                }

                // wait
                System.out.println("\n0. Go Back");
                System.out.print(" * Enter number : ");
                sc.nextLine();

            } else if (input == 2) {

                line();
                System.out.println("[ ADD ALBUM ]");
                System.out.print(" * Enter name : ");
                String name = sc.nextLine();
                System.out.print(" * Enter genre : ");
                String genre = sc.nextLine();
                System.out.print(" * Enter release date : ");
                String date = sc.nextLine();

                ResultSet rs1 = stmt.executeQuery(String.format("SELECT id, name FROM artist "));
                while (rs1.next()) {
                    System.out.println(rs1.getInt("id") + "." + rs1.getString("name"));
                }
                System.out.print(" * Select artist ID : ");
                int artist = sc.nextInt();
                sc.nextLine();
                rs1.close();



                ResultSet rs3 = stmt.executeQuery(String.format("INSERT INTO album VALUES(null, '%s', '%s', '%s' )", name, date, genre));
                ResultSet rs2 = stmt.executeQuery(String.format("SELECT id FROM album order by id desc"));
                rs2.first();
                ResultSet rs4 = stmt.executeQuery(String.format("INSERT INTO album_produce VALUES(%s, %s)", rs2.getInt("id"), artist));

                rs2.close();
                rs3.close();
                rs4.close();
                System.out.println("Success!");

            } else {
                System.out.println("Wrong number!");
                break;
            }

        }


    }

    private static void manageArtist() throws SQLException {
        while (true) {

            line();
            System.out.println("[ MANAGE ARTISTS ]");
            System.out.println("1. Show artists");
            System.out.println("2. Add artist");
            System.out.println("3. Manage group");
            System.out.println("0. Go Back");

            System.out.print(" * Enter number : ");
            int input = sc.nextInt();
            sc.nextLine(); // solve newline

            if (input == 0) break;
            else if (input == 1) {

                while (true) {

                    line();
                    System.out.println("[ ARTIST LIST ]");

                    ResultSet rs = stmt.executeQuery("SELECT * FROM artist");

                    while (rs.next()) {

                        int artistId = rs.getInt("id");
                        String artistName = rs.getString("name");

                        System.out.println(artistId + ". " + artistName);

                    }

                    rs.close();

                    System.out.println("\n0. Go Back");

                    System.out.print(" * Select artist to see details: ");
                    int input2 = sc.nextInt();
                    sc.nextLine(); // solve newline

                    if (input2 == 0) break;
                    else showArtistDetails(input2);

                }
            } else if (input == 2) {

                line();
                System.out.println("[ ADD ARTIST ]");
                System.out.print(" * Enter name : ");
                String name = sc.nextLine();
                System.out.print(" * Enter debut date : ");
                String date = sc.nextLine();

                ResultSet rs = stmt.executeQuery(String.format("INSERT INTO artist VALUES (NULL, '%s', '%s')", name, date));
                rs.close();


                ResultSet rs1 = stmt.executeQuery(String.format("SELECT * FROM artist"));
                while (rs1.next()) {
                    System.out.println(rs1.getInt("id") + ". " + rs1.getString("name") + "(" + rs1.getString("debut") + ")");
                }

                System.out.println("\n0. Go Back");
                System.out.print(" * Enter group number if the artist belongs to a group :");
                int group = sc.nextInt();
                sc.nextLine();

                if (group != 0) {
                    rs1.last();
                    ResultSet rs2 = stmt.executeQuery(String.format("INSERT INTO artist_affiliated VALUES(%s, %s)", rs1.getInt("id"), group));
                    rs1.close();
                    rs2.close();
                }


            } else if (input == 3) {

                line();
                System.out.println("[ MANAGE GROUP ]");

                ResultSet rs = stmt.executeQuery(String.format("SELECT * FROM artist"));
                while (rs.next()) {
                    System.out.println(rs.getInt("id") + ". " + rs.getString("name") + "(" + rs.getString("debut") + ")");
                }

                System.out.println("\n0. Go Back");
                System.out.print("* Select group to see members :");
                int group = sc.nextInt();
                sc.nextLine();
                if (group == 0) continue;

                ResultSet rs1 = stmt.executeQuery(String.format("SELECT * FROM artist_affiliated as aa, artist WHERE team = %s AND aa.artist = artist.id", group));
                ResultSet rs5 = stmt.executeQuery(String.format("SELECT * FROM artist WHERE id = %s", group));
                rs5.first();
                System.out.println("<" + rs5.getString("name") + ">");
                while (rs1.next()) {
                    System.out.println(rs1.getString("artist.name"));
                }
                line();
                System.out.println("1. Insert member");
                System.out.println("2. Delete member");
                System.out.println("0. Go Back");
                System.out.print(" * Enter number : ");
                int input2 = sc.nextInt();
                sc.nextLine();
                if (input2 == 0) continue;
                else if (input2 == 1) {
                    rs.beforeFirst();
                    while (rs.next()) {
                        System.out.println(rs.getInt("id") + ". " + rs.getString("name") + "(" + rs.getString("debut") + ")");
                    }
                    System.out.print(" * Enter number : ");
                    int artist = sc.nextInt();
                    sc.nextLine();
                    ResultSet rs2 = stmt.executeQuery(String.format("INSERT INTO artist_affiliated VALUES(%s, %s)", artist, group));
                    rs2.close();
                    System.out.println("Success!");
                } else if (input2 == 2) {
                    ResultSet rs3 = stmt.executeQuery(String.format("SELECT * FROM artist_affiliated WHERE team = %s", group));

                    while (rs3.next()) {
                        System.out.println(rs3.getString("name"));
                    }
                    System.out.print(" * Enter number : ");
                    int artist = sc.nextInt();
                    sc.nextLine();
                    ResultSet rs4 = stmt.executeQuery(String.format("DELETE FROM artist_affiliated WHERE artist = %s AND team = %s ", artist, group));
                    rs3.close();
                    rs4.close();
                    System.out.println("Success!");
                }


            }

        }
    }

    private static void showArtistDetails(int artistId) throws SQLException {
        while (true) {

            line();
            System.out.println("[ ARTIST DETAIL ]");
            ResultSet rs = stmt.executeQuery(String.format("SELECT * FROM artist WHERE id = %s", artistId));

            rs.first();

            String name = rs.getString("name");
            String date = rs.getString("debut");

            rs.close();

            System.out.println(String.format("Name : %s", name));
            System.out.println(String.format("Debut Date : %s", date));

            ResultSet rs1 = stmt.executeQuery(String.format("SELECT * FROM artist_affiliated WHERE team = %s", artistId));
            rs1.last();
            line();
            if (rs1.getRow() != 0) {

                System.out.println("1. Show members");
                System.out.println("2. Show albums");
                System.out.println("3. Show musics");
                System.out.println("0. Go Back");

                System.out.print(" * Enter number : ");
                int input = sc.nextInt();
                sc.nextLine(); // solve newline

                if (input == 0) break;
                else if (input == 1) showArtistMembers(artistId);
                else if (input == 2) showArtistAlbums(artistId);
                else if (input == 3) showArtistMusics(artistId);

            } else {
                System.out.println("1. Show albums");
                System.out.println("2. Show musics");
                System.out.println("0. Go Back");

                System.out.print(" * Enter number : ");
                int input = sc.nextInt();
                sc.nextLine(); // solve newline

                if (input == 0) break;
                else if (input == 1) showArtistAlbums(artistId);
                else if (input == 2) showArtistMusics(artistId);

            }

        }

    }

    private static void showArtistMembers(int team) throws SQLException {

        while (true) {

            line();
            System.out.println("[ ARTIST MEMBERS ]");

            ResultSet rs = stmt.executeQuery(String.format("SELECT artist.name FROM artist_affiliated as aa, artist WHERE team = %s AND aa.artist = artist.id", team));

            while (rs.next()) {

                String artistName = rs.getString("name");

                System.out.println(artistName);

            }

            rs.close();

            System.out.println("\n1. Add member");
            System.out.println("0. Go Back");

            System.out.print(" * Enter number : ");
            int input = sc.nextInt();
            sc.nextLine(); // solve newline

            if (input == 0) break;
            else if (input == 1) {

                line();
                System.out.print("[ ADD MEMBER ]");
                ResultSet rs1 = stmt.executeQuery(String.format("SELECT * FROM artist"));
                while (rs1.next()) {
                    System.out.println(rs1.getInt("id") + "." + rs1.getString("name"));
                }
                System.out.println("\n0.Go Back");
                System.out.print(" * Enter number : ");
                int artist = sc.nextInt();
                sc.nextLine();
                if (artist == 0) break;
                ResultSet rs2 = stmt.executeQuery(String.format("INSERT INTO artist_affiliated VALUES (%s, %s)", artist, team));
                rs2.close();

            }

        }

    }

    private static void showArtistAlbums(int artist) throws SQLException {

        while (true) {

            line();
            System.out.println("[ ARTIST ALBUMS ]");


            ResultSet rs = stmt.executeQuery(String.format("SELECT * FROM album_produce, album WHERE artist = %s AND album_produce.album = album.id", artist));

            while (rs.next()) {


                String albumName = rs.getString("album.name");

                System.out.println(albumName);

            }

            rs.close();

            System.out.println("\n1. Add album");
            System.out.println("0. Go Back");

            System.out.print(" * Enter number : ");
            int input = sc.nextInt();
            sc.nextLine(); // solve newline

            if (input == 0) break;
            else if (input == 1) {

                line();
                System.out.println("[ ADD ALBUM ]");
                System.out.print(" * Enter album ID : ");
                int album = sc.nextInt();
                sc.nextLine();

                ResultSet rs2 = stmt.executeQuery(String.format("INSERT INTO album_produce VALUES (%s, %s)", artist, album));
                rs2.close();

            }

        }

    }

    private static void showArtistMusics(int artist) throws SQLException {

        while (true) {

            line();
            System.out.println("[ ARTIST MUSICS ]");

            ResultSet rs = stmt.executeQuery(String.format("SELECT * FROM music_release, music WHERE artist = %s AND music_release.music = music.id", artist));

            while (rs.next()) {

                String musicName = rs.getString("music.name");

                System.out.println(musicName);

            }

            rs.close();

            System.out.println("\n1. Add music");
            System.out.println("0. Go Back");

            System.out.print(" * Enter number : ");
            int input = sc.nextInt();
            sc.nextLine(); // solve newline

            if (input == 0) break;
            else if (input == 1) {

                line();
                System.out.println("[ ADD MUSIC ]");
                System.out.print(" * Enter music ID : ");
                String music = sc.nextLine();

                ResultSet rs2 = stmt.executeQuery(String.format("INSERT INTO music_release VALUES (%s, %s)", artist, music));
                rs2.close();

            }

        }


    }


}
