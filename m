Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AA6514B52
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376515AbiD2Nz5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376523AbiD2NzQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:55:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3C45E755;
        Fri, 29 Apr 2022 06:51:34 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TDIm3m004257;
        Fri, 29 Apr 2022 13:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NwYCnI58rhQOvI4ztnnRGw2LWsLAqNLHi894VNzquR0=;
 b=qE2riX1h7DEXlbwwUfNog9N4nzitJhHzaSJTlxdyb/+jKAIKvGMaB2g5y4kWXQ5v1Gjg
 NZVmKbH8i7ynSvKKB8vL5MqeYHbL8uBwuMANBdMfbCsTc8E3uI5Cn9lhBKEMnmfXz4xB
 AKfxwO41aPesYhwfrwCKjQBPuPIw8UozhIhOq5vVZRDD/x/hs8mEOeuli3jr5VlIWFfW
 z/AlkbaGwqVNX7DeBsvjb0crdx2gw8mqcg40EsJwz9UD4nlu87Y+CCzncDNcgLdfts+s
 wMPrWahNrsVz3BYGIzwEdjESY9X1Wh137LOIxT/0HAx66tezJy7EyRTXql+ryvlE/kOW 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqtvxmngx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:29 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23TDL8eb008423;
        Fri, 29 Apr 2022 13:51:29 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqtvxmnga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:29 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDS9Zj013821;
        Fri, 29 Apr 2022 13:51:27 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3fm938yat8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:27 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDcGW350201082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:38:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 109144C044;
        Fri, 29 Apr 2022 13:51:25 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF2E34C040;
        Fri, 29 Apr 2022 13:51:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:24 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN)...)
Subject: [RFC v2 15/39] Input: gameport: add ISA and HAS_IOPORT dependencies
Date:   Fri, 29 Apr 2022 15:50:25 +0200
Message-Id: <20220429135108.2781579-28-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _1urUN6R8N1uaUH8TDgsIiPsx5lJUdhW
X-Proofpoint-GUID: gjLBiH9jHt1VeZ3ki4hyA3c9N80qHF8o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 mlxlogscore=964 adultscore=0
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

