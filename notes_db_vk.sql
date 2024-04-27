-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql_db
-- Generation Time: Apr 27, 2024 at 05:14 PM
-- Server version: 8.3.0
-- PHP Version: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `notes_db_vk`
--

-- --------------------------------------------------------

--
-- Table structure for table `note`
--

CREATE TABLE `note` (
  `noteId` int NOT NULL,
  `noteTitle` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `noteText` text COLLATE utf8mb4_general_ci NOT NULL,
  `authorId` int NOT NULL,
  `timeAdded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `note`
--

INSERT INTO `note` (`noteId`, `noteTitle`, `noteText`, `authorId`, `timeAdded`) VALUES
(1, 'test-title', 'text text text text', 1, '2024-04-25 07:15:41'),
(2, 'New Title', 'Old Time (20:50)', 2, '2024-04-25 06:50:28'),
(6, 'Note from Swagger', 'From Swagger with love', 5, '2024-04-26 18:33:52'),
(8, 'Swagger User', 'Last Test', 6, '2024-04-26 19:44:16'),
(9, 'New Token System', 'Last Test', 1, '2024-04-26 19:59:56'),
(10, 'Docker Note', 'Test', 7, '2024-04-27 15:34:50'),
(11, 'Time test', '18:55', 1, '2024-04-27 15:59:18'),
(12, 'Time test', '19:00', 1, '2024-04-27 19:00:37');

-- --------------------------------------------------------

--
-- Table structure for table `token`
--

CREATE TABLE `token` (
  `tokenId` int NOT NULL,
  `token` varchar(2048) COLLATE utf8mb4_general_ci NOT NULL,
  `userId` int NOT NULL,
  `validTill` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `token`
--

INSERT INTO `token` (`tokenId`, `token`, `userId`, `validTill`) VALUES
(1, 'b93f081708f26e67d062dd6525836032e0361305327968c2bdd73d8c5d73666dc7f167b32c88428be38363ef7065a7d2e8e153d219f06781ee11560dcf86345daf3704a1c5defd8e8f24c3ab0def7e3f2286609e43b334aaf81ea259ee4a463a6248a2123f5e720c61897d300c453cf54cedc1b227bdb23b13e5348a356989dd8c89fe9036d87eedbf3ff3650f12257134d23cd890e475da26bfe386eb7336c6fe9bb156d40a5536c34c5b37117d232d3ec76f6657ecca4daef4976fb317585488f087a3b9b7a3a264977124808dff5231948f4e4c7d99eb48b1c9ddd13fb35999a62e675a6a5eed88313b02f2f6abb5f5b12fc0d9a43a6525f4cba0166658e6a30fe405734b0bbc9b1d6f3ccba94001992d147990c7807648a9848faffda1ed771ac779a7a9be551ed2df867118beed1bb6c8f08396fde0983ef8dbf2a50bf952067590f3384b202240aa543346e82b239e1c08ed84fd813216582bcf1461373c6b0a281470d68cd6137b641c1793b0ce8a7911d49842cff2b2907892195a001509e3a2621d031b2aaf262d44e6aea9b6b6a3709f1d54f1012fc9656fed111ad435e1b7ffc5c897a3d09c9b016a4651a39e5292367beeb0073c0abe76f0bf200ebb9c1495cb82ca6cec90b940a4c5fe6e0d2475633907e02b4ec48a830f0759659f1e8f8eefb5f68622932186d8cbf72279567f064c6270580f8b2f095c9704', 2, '2024-04-26 20:58:16'),
(2, 'ab184f9b9c02982ec4cfedd46211093d25110ab5a34f22148dcc50b3162fd4b89f33660e48c0aaed11e77478e5b8d05bc899296d1b8090854a16a1cde5e1dbfbfcaee0ad5bcb3eb819c6973a93d0513c6c4a619f5f0707fadad82b60160566b473230d4b4d2acb3d31ec5d3199de1ddc661e866623301e95e242fe883957e0f69b3c942f648ddd52d5e56dc602ed5370b1339ec46876591f1c7b5e4f76d074f5acf2b16678ea7cdc50fc3c106bd8eb00e515c5fbfed0974a64c9900cbcfa67593e50b20d9d576722cb371bd545c6b77b7c2541f1fdf8f13470f91cc31c8790bcc533a313faaad6bb9f01be65157d7717ea7ab45dfa2042dc0be9f5dc68e56eefad60e15f361785823fcbb48e119daab1da83892a183870e6edc10432af46f3a4ed2a32366bde8d90b282541e030c538420e825c145346f912917f57392a7e7306d20890ca8d9b36367230f2d96b8ba8f932a906bc08b5fe37c09434bed92cdeea83a95eab95fc144584508f6b2a89168b53db1bf66dc7ffe259dfd36313448064fc6e590ef3f3b181116f499933d026f22d67d5a2252d85aacb16e7d047cc77a032fad857914d360af408e3cb4337bb1b386956120663f12c21ac487c6b45350c7dc103f0c1c32d9ecb8dd86ec8008a0d303cb3a21a4833e3e4769b96ee1a715673a663dd67ead3ce3967cab10d4b704828b5a5b2cf04077515bd2b3f055117b', 1, '2024-04-26 20:58:54'),
(3, '0f5cbbe70f9151e5c252ed28c10b1f43e01baaf6b122f07fb0c9e9ff04ee1fdaebbdd2dfa4ea3574509c5c918fcc504cd9f122f6a030454e8cfeeeeb6e6cad81e077f317af491bb224f09797e3fa2031eb83df132707d63d9138d18386ac5c88712cb2381ccc1e372c30be6f1b76b3e17780b5e6788b38a4c66aa9d455ba3b3f6c34aed8e04911352980212ce90d157d97b3c9e1aaf6f809599f6faf72d19233840c69b5b9061280ea465df0967a2ca1eed242b088528562e9d6109f2c4079d4498a461dfef5fcb70fc99703c9481ab1bd21ca3b223eac2f4fa6c52a6caee92a55c3bc4130da06de9abdac4e30b3a79412c96529c79fd158e2b525413be4f34c4ec72786765cb7c0592f5a1aed69e4ae9584a614a2a8e11c0ecce3b97322de420cbc750a325540f30373f892f436edbea690f792f05b01f07d47188f2720ab30e930dba0c20dfec40162a57453a8686e0f58a96661ab3ffad4ee3905bfb824580450804339f19b047f2316d1135b1a0ab7453389c04daef4141497307218eae522f19f254e2323aa644904201931be2d8e0838a97d589a306c9c64b5f9d008da7dd21c5c15c66b8508f5a0c3e99dbe164a31de953d5a5ad9396017780bc6093626bb88ba1d793bb7aacd1507b1c9d1f7bfc434d0ef3e6322d1abbceec7c093f5ba04cd3ab9c8d95982147e7b68b7c617d17cedbb5bc02c24d75cf72d186e8a55', 1, '2024-04-26 20:59:18'),
(4, '1cd67f23757e67167cc31215642cda02406f7ad6025e3ccee54f874a22607b39f056e88c432d0bfb26c92adcb5809205cbc7180a291a5b777b5f29fb0eca46d1051e3bf0aff3a6ae36e262e627b95472bd614ef4e99705821b7a589ba01aba644483cb1209c552e17191a1b0ca166989e421d086b224c6f662a26ed5c6df687b38f0fc68946d69d6a41bcf7554ba8f5dbcbb24b52377208400f243ba1a3f06edf3b56eb88c641396abd90a0bf4262fd1bc8977f8fe06f46834d3c3726552c0d225ad521bb62c059c9d1a482e29e2bcec4702c634c6106cb95b796b4b3e8d36627bad66815d7c18f5b9f3f40f330b2d3f9fe9c1bc035896e50716b0c65b8d957d4ef080c8c684d462ee6268cb65820c2a08a3aaf4934715b26fac02fe7dfa5eae7c782e8e4abdc28b53e61dc508ca6f7b0a4b855d897f08c13571f1c911bb4b830e471d5f9d4a59c129e8b578858058414b5b412464b4600f4cbac5600030648c66183b5862d906d223fa9341843ce672aebe6057d6c99877c5eaa8e7d1fefb771a1875f8ca3eedf1da153e2ac801c540eaff9ab59d275bec87daf19ed669c6cf91713cbafad09e9d73897dfdcdcf2b0412cee06750b865cb08c0139991835da835fd784c8dd38452e06cb025e34d7d8ee2791b8095012fe58a868e2d3efee5697a0719ae449696fa4efaa50155c0768b9e309088ae526ac8c99dd4559368d188', 2, '2024-04-27 10:06:12'),
(5, 'e2ccc47c85a29d1408cd50f24cf35c7b99b9d3aad5ea06c67c35f45a7c746a6dfe349e9e8beeb7705933ba1796c570937ab391a2e00f6ec647ecf6096bf04f127bee33d03ddc1edfefada9759f939883df69afea92e1d966fd2fc06d7ebbcdc5a54fff5b53727a3f78f442e3abeb3a5c61f5a8b4af1b99d48a26ae1b962209010578725e229d83baa0232323ecd5796bf03474e2f1e6bd83083026e98d90ded589e6fc9fa3c55421f994408878f562b510d6ac35d2bbd158e7dbbb1ec5719d2f9a93293e02a5be5bb58143ffb4d44ed53abf25ac5bffb3cbb233b22ac28deec63270fc7810f398c858cd141d9bc5f93fd87338ce73dfcbf9cb2089b97169b026e3226aaf91fe8c500600a908fd7636da4ffa1f7a4ea315e3b1f0fcfb95a729fb35d6f8f5f5e2943462dda8977f158f7e5d8002b710553034fe0abfc21ae307c1cad9a0bd9febc6160429a0ab710f43f83895ea2f88d921486b2c4658249c5451e82387072823d521c191588e7e97e0e4b310a5cd94261541644270760354a61346e1b85a37ca743dd66b2479831673fcb7138bd505c31a832dcbed31200d004fa89df273d94a0fb3e565f535d40faae11a6c224641dc227cc553612b5cf6b26b4c601c3066a86d8900fb031b7cf2d42ff3ea5aa7300189cd718e37483079ec4800cde70e8236eb57decfa1866c215c3fd2a0600bb41861a31e725e249450c076', 7, '2024-04-27 17:32:42'),
(6, '6256fc2b79669bbb696eeb8e90fb39d6959dd8003ecf7f52e4730831231703d26d8536cffd2a51930038a4eb122de71fa6061acb4f8410e87ca6ffc06b698e4a4f823b790af4d1f6d4b750f0bb887fe84653370b1f65dc736a8e486fc2024799461153020cf4879f30fe6ce5ac132cd6b355f675bf477a4b97d676e6fcc3684ea3a8af4936e6d21fe1363850f04ddb92f4a679caf0c28c6245d7b1daf549590c3d48e67941c19e939ee2861ba59c0ded6b813fca03f15c32e3eb41c20c511d889290ddec90b2623a74730ebf4d4f5536f72570217749b1b721db4254be51ca78bdf829c14e25c4bd05bdb29accb047ed256960d35ee7559479c6f0654f13f4a8eca4dfe7876ad85c50ed88022d1ace197713a20ee741316338283e0d8a04b27c63ae81663251befdca9222a19ff541ac9fae257e1f27797c42fbb12b934f6eebd41686ca79f5f836e986f80cf200c9d71813c8e3dbed626451fc8dca9a997b4148bbe4876d9b94b1e97c5574f07a771c71d3f49378a3f53ebc9efba4b5406cb13bb61eb8aa077fe0a28252e3060726a0d3e307a0f1a18f8bc47e62ad840e648fab69157ebdbc346094402c833c4b1650275dbc1ad37f37ddf5954caa334a395248665032001df10c9253e712319d63155ff37e566ee2e608d10b5acd8820c974bb9517ae91b454f4e4aec71a2b97f232e9b585ab18a54e0dd09190cbd0ef7de7', 1, '2024-04-27 16:43:44'),
(7, 'e1aaa37dcb11d42481726a622d942688eeb151f4a05c082eba294e24af6117777965ff4337bf62b4342cf8dadff991ffac6207be9e7626332794325d4eb307d095d1097e7490082c5573cd8b2716ed14fdf2adfd7ca180a343924269706a5e73a63f48fd918526564cf9875ba32e37c53b06c17031781ea23943de4f90f8d92c1940a9f36fdccd496cac18683b5670710808f4f54689f05a6694c8dbf6a81db714bc42c97acbc71dcb4ace86989583e56c3c4d7c564e9d9595bbc20d3c7510b45766d222575f4c649d52f89111ec5c7742c89ca783c47563228291b96ba9752daabdb5d5c3ff34e9d026d6997cc4bfa42a3d4f803997d368d8d7992e56084dd37fc96f33110e539838cac1707fdb2367da19755cfa2df7a3593c289a65040aa333f407ef62850fdcc574ffc02fa661e1ecfb5a8843e422f496c42e69ced9ddbc8d8dd3b1b9fe8bac419038b89eec7bf031368a52442dc43434c1d2004da1037650805116c7f88a0f9408081efe02881580e4203101cc5d73f3f13e9bad762536738527e37eec3857d40cdf1476e0d5c92688b288ec0a6bba6e05439cc8ade95f7323ab36bb831bdb987f33eecb4d19655a5c3194989cee720e29b14f629320889179e7ecb77fb90d46ff2f68e1709c553c1895e7212624daf75a82c791b8e4cdebc8f4986288b88d62290f73fb07ad8b98667b6fbf1748139e058cebcd0cee5e', 1, '2024-04-27 16:48:36'),
(8, '9c241e37d7cc889c600528264b177c4426635d81a159e4610229f429ee9ecae60a131a0ea22bc1a0d222cac66e923eb9eff2445f43e7fd06d12002192ff54148040c3ac527602413d76718eb3131a0e3c1bf17ec7c44e20f09e01df81c42538dd1e4565d0555ff89fb5ff2f370bd7f3c0358f2083e98b46a96cce1849462cd2268fc5820447b252f56d0975da98d56ad2f59a58a0642ff0dac827a77ebbc7c9ab9bcaa942de1478ee8e60363fa7b78aa757a92bf1a3dd4d7a00bc8e79095486cd3e4bb696afc7b9086eb366d8c6115c7d3a6ef758b36ef79212d1b6adabb1b653e4c88331f5fbfa245824d834f5524ee3fc5d2a2566efd69dffbb7f7e496a36652cccc78e8315433fb5de297a74d3a894b2485451b627c93134fd618c0bf7ecc8e444382ad67649cfdb4b1a527b2de95cb2c54cb23d234bd6202944df9c84d5bc865aecef64ab77ddfe42d7c17346da5705d62c0f4aaf28469b6a3914e9e1feff9b543b54a7aad524829587d4c55da6879c8e9ef3e4c4fd8b082afc91ac55d7e9677e86f2804f1c2e191e23afaea4ce5336583034c6ee5619053412c6bb405b3e679005aaa1a1839c7e4e9ad5de6ca5759aa34c2febc8cc104196249b95843b0605f38f0528a2150d95930f604f270a6bf595e824c6530718df1df1778dd5874c9403a3b54cfd470671c56d5423379d36e03787c9e8222bbad5309de80188ef3', 1, '2024-04-27 16:51:14'),
(9, '25fa4e8ef62c52c45484283beacf824f14cf3b6f493cb356b1f4b457963215aa7c63da60cff36536f8aa85bb73fa408542480784f52fd35afa01e8c7fb857a73e8c71f0bb608ab9dbb5a3c69e8e8b3af9628512c7a782669a50136073c6dec7cb02f71cefa4953b6d29f9bc2df853517731adebd0da0aead388dee6fa93b90f108cf1e3ae35b0983ef055dc890cadb4cba8afad71f8d8f190b82faee0eef334630f71e25b046a9fffae45da7fbbccd030ebcd267545da44b6616ff7654973a85c8cac021136dd503f87f6b0835c29ee8ed52f23b39d987bc849a51951f053bb3713342947339ecb12a0dd52de0f653da53f7eba640de885a0ba3cb40a5897e204c9443b6ecad8d934213842bb9e01a88fbd3945a1d7564b62ffffb8fa8031066c334dd48d85d5b583f7e42eafbe848ca051739a7712bb8d1893664fb1f72a1d1e9a2da745fd42ef08d267a4d843843d26fc3419fcf836c68121db91e37881689ae02460e43553329f7e94a2391c1873edd041b97306179482113ec4927c09db5ded3aaf46df937692134f4236cae295a15c6585b4c07d854acf629fd89b63788772e8f365d4acf1a75ef90090bebf0dbed596309b6eb40fa2701cc0503077bf4c18271535f98d2c0861d5e28a0360bed63ab415fc0a3e9cc21ad84967794ac74d5bb3a5ee2217e3ea2e3e62c07078f08968eb3a137267ce9f2228eac02eb7690', 1, '2024-04-27 16:51:40'),
(10, '8f27951cef299a4b3c71aa7ebaf447aa74389ebb7cca3cff2e7219abb9d3432d5e29e7e2327060759ec69f99016bb242834c0271f33e4681c0ec2f30fd81204388d72d013e203425663dd2813b4ee55caec7ae4945612a04ba2226ebbe0b9770874e91ffedef9f7f8e6e1b6a3c5b30d033d64562a4d5e2bd9063dbf6b884e21e41b4109068dd529ea10a3e0adf68182a9ec4e07e9b9ee4d5b7e7fb5a8f3fb45e33b80f8d8801f69b896a5f902210024d4255f38e5d1c50a6ab919eebca2d79860a1b1e6c4124614a2f2d37f715707d08afb5c0f238667644d8d3530562e9fa73367a55505a33e64339b1155557538ae8359b8db751408d63478a262dbd424c6cbcebe1b3e906e8bb23b154acb1cb2956a477b3e2c2e290f870f5345008f692ab0483a9d96de60a3e73f9ac610b7a3325bb4debc0a178ce5589ffd68d35cd4b1652181d4415bb34b87192f1833163cee0ab677080b28fca08dc6d756ed9579120a0230315bd2fb174f8a140da769fee6756dcd746cabdc65a0aabe98b29ac31594eb4175a10ee5142f8f52e359d346514a05f126b556c911185067a8436f16754f547eb5716b4bfbbb21290cbba4cf82268699c27353ecb014c389a9f65fa77455fbda57fe1002c4e3a4a58f22f23f8f6bc2434dadd383e782a869c04ad93363f53f7c7758dea74c059ab661db808f0203d227d23702dd173faad9d3b2e118377', 1, '2024-04-27 19:55:00');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userId` int NOT NULL,
  `username` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `passwordHash` varchar(1024) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userId`, `username`, `passwordHash`) VALUES
(1, 'Gosya', '$2y$10$5fk6BcGMggBnLYhu53bXIeDaprs8ZO8860l4i7xKYXl/aPiZfHHTi'),
(2, 'Gleb', '$2y$10$KRyEAsy.AfRaLVDADVE0d.ShXx/hHDAEfnO/l31IcwpgkvfPWMMiO'),
(5, 'AdBelsh', '$2y$10$9u2Dpw//oEElLwbN2cFdIeC3ozooa8CaZmHI4GaJqYXrIO5s8oct6'),
(6, 'Swagger', '$2y$10$iUOgBvj2X9rhbtjaWO2PQe2yDbCYLaMhzM724P0S8NuL3tXl68o9.'),
(7, 'Docker', '$2y$10$T1E2YB.Cc54uMMmhZqJoOeQZqyt79BUWDi6yf0m2DLYa8jjaEh0Oa');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `note`
--
ALTER TABLE `note`
  ADD PRIMARY KEY (`noteId`),
  ADD KEY `user-note` (`authorId`);

--
-- Indexes for table `token`
--
ALTER TABLE `token`
  ADD PRIMARY KEY (`tokenId`),
  ADD KEY `token-user` (`userId`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `note`
--
ALTER TABLE `note`
  MODIFY `noteId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `token`
--
ALTER TABLE `token`
  MODIFY `tokenId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `userId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `note`
--
ALTER TABLE `note`
  ADD CONSTRAINT `note-user` FOREIGN KEY (`authorId`) REFERENCES `user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `token`
--
ALTER TABLE `token`
  ADD CONSTRAINT `token-user` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;