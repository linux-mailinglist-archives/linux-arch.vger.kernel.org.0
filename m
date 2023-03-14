Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A796B931D
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 13:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjCNMPJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 08:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjCNMN6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 08:13:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B0C149B0;
        Tue, 14 Mar 2023 05:13:08 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EC0hJH016904;
        Tue, 14 Mar 2023 12:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9ctcUx5LZI/mg0TO+YXc+fY3QgO4PfYu+vXzePpmDDA=;
 b=RJxZuGJMIEvdVwAnfQluh7iLTAQsy4hewAzyoIua8j9W529nlN62PD5BMfzJ8FeGvdyK
 QFkqfLkpWNeK0Z/PM2H3NzgfKDKffPl6gVp3zqNCJlBxDSafmHqu2+Ub84lcRO+c3DST
 ealIljO2e2LzsVCaZX9gA+mH/uuQaTh0Yl3bFcThOTMBZhnwIwgLtVaovkTathuuHN5W
 eZgdWoKz15hOdJ6IFkesEI6Pf2j2OMdbAy1MxGo565BYDtAOroVPNGUOYguToGq5ywn/
 NkJRFLLB0hy2uRoOpUljwnJsU60PJJvNsTz3lMzAvcu5A/JLS8a56g3U7nZiO61FwUJo gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3paph23ua2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:38 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32E9gSMR019210;
        Tue, 14 Mar 2023 12:12:37 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3paph23u92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:37 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32E7uGPX001011;
        Tue, 14 Mar 2023 12:12:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3p8h96mrvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ECCW3m53281030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 12:12:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 579362007B;
        Tue, 14 Mar 2023 12:12:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E06AC2007A;
        Tue, 14 Mar 2023 12:12:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Mar 2023 12:12:31 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH v3 14/38] Input: gameport: add ISA and HAS_IOPORT dependencies
Date:   Tue, 14 Mar 2023 13:11:52 +0100
Message-Id: <20230314121216.413434-15-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314121216.413434-1-schnelle@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jpwPOrAaD_62i7b-0Mmc2U-MuxknLPtb
X-Proofpoint-GUID: ECloxw04p-P-7aJw5nMxgM5nMruHWqjf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_06,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. As ISA already implies HAS_IOPORT we can simply add
this dependency and guard sections of code using inb()/outb() as
alternative access methods.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/input/gameport/Kconfig | 4 +++-
 include/linux/gameport.h       | 9 +++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/input/gameport/Kconfig b/drivers/input/gameport/Kconfig
index 5a2c2fb3217d..fe73b26e647a 100644
--- a/drivers/input/gameport/Kconfig
+++ b/drivers/input/gameport/Kconfig
@@ -25,6 +25,7 @@ if GAMEPORT
 
 config GAMEPORT_NS558
 	tristate "Classic ISA and PnP gameport support"
+	depends on ISA
 	help
 	  Say Y here if you have an ISA or PnP gameport.
 
@@ -35,6 +36,7 @@ config GAMEPORT_NS558
 
 config GAMEPORT_L4
 	tristate "PDPI Lightning 4 gamecard support"
+	depends on ISA
 	help
 	  Say Y here if you have a PDPI Lightning 4 gamecard.
 
@@ -53,7 +55,7 @@ config GAMEPORT_EMU10K1
 
 config GAMEPORT_FM801
 	tristate "ForteMedia FM801 gameport support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  Say Y here if you have ForteMedia FM801 PCI audio controller
 	  (Abit AU10, Genius Sound Maker, HP Workstation zx2000,
diff --git a/include/linux/gameport.h b/include/linux/gameport.h
index 8c2f00018e89..4d5720022b63 100644
--- a/include/linux/gameport.h
+++ b/include/linux/gameport.h
@@ -167,16 +167,21 @@ static inline void gameport_trigger(struct gameport *gameport)
 {
 	if (gameport->trigger)
 		gameport->trigger(gameport);
+#ifdef CONFIG_HAS_IOPORT
 	else
 		outb(0xff, gameport->io);
+#endif
 }
 
 static inline unsigned char gameport_read(struct gameport *gameport)
 {
 	if (gameport->read)
 		return gameport->read(gameport);
-	else
-		return inb(gameport->io);
+#ifdef CONFIG_HAS_IOPORT
+	return inb(gameport->io);
+#else
+	return 0xff;
+#endif
 }
 
 static inline int gameport_cooked_read(struct gameport *gameport, int *axes, int *buttons)
-- 
2.37.2

