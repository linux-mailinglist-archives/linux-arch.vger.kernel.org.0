Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDF1514B28
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376466AbiD2Ny5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376427AbiD2Nyq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:54:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78024583B0;
        Fri, 29 Apr 2022 06:51:27 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TDKJ4r005926;
        Fri, 29 Apr 2022 13:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NwYCnI58rhQOvI4ztnnRGw2LWsLAqNLHi894VNzquR0=;
 b=adXjZUEkPcN1IfOq1AkHcM3UfqHhnmmjazrIvVgP/OzvcKu8J8+kY6OAE3KwbqkeuxSY
 8sUixQDy4E3X+RPebXrlwB5Z48ETNz3NFo6SxNH5vgYTfUbSO7YztPFatBFaJtARxm5d
 +wVwrprezxGctQEWgNHuGDhdQfbqzMUPae++KKtd0UntxGDaE5Fie0BLJMJPq6AbhA7Y
 +F7kiAvYyn4eL/wXABmPPLnTN2zePuIYGTI7PGFZhEKJ/GLwOqlVjc0UrKwYWrzRwp4a
 MCw/hgiotnZ+Uq5KJrZTxB2T1HON9FykdFxBzZV54yTg+UVzG5Da4Oy5pH66mKcLWTzo 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqtvxmndp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:22 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23TDmX3J019603;
        Fri, 29 Apr 2022 13:51:22 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqtvxmncv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:22 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDS5hh011971;
        Fri, 29 Apr 2022 13:51:20 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3fm8qhqavs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:20 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpQnv23855428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D512C4C046;
        Fri, 29 Apr 2022 13:51:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FB984C040;
        Fri, 29 Apr 2022 13:51:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:17 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN)...)
Subject: [PATCH 07/37] Input: gameport: add ISA and HAS_IOPORT dependencies
Date:   Fri, 29 Apr 2022 15:50:11 +0200
Message-Id: <20220429135108.2781579-14-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: renjD5P0Cu-WniTjBUQv4kNtoXsuo82u
X-Proofpoint-GUID: onxuuYsLp_JNjLw16h_Npj4AINEIEs6o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290078
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
index 69081d899492..9e55ac748a86 100644
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
2.32.0

