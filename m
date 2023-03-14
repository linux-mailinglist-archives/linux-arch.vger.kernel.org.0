Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C486B930D
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 13:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjCNMPE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 08:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjCNMNs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 08:13:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAF610B;
        Tue, 14 Mar 2023 05:12:58 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EBwYNF021438;
        Tue, 14 Mar 2023 12:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Omi8oBzwEccZNdCFm/mFWVeBras082CKX80qYkcW2CQ=;
 b=KZUl25b5v/pHezmrheMJHNrORzQCsPMaSJkPHe1dYuFX+mlofBIM6ApxfVjohr7khss5
 1CjeESexoqGRotfaZA5ltOigCecFK0/rneitYzL54RghtdvKfrjK1Tez2eYOGEl9i/JP
 JIGQqcIt2zYg6CcLiTTWy8/yIPuescT8uMkP30aXo8Xbu/PHQ8xe+rgNPkWdqJlxnQOZ
 dyr4REE+w8IIxkElforFR3U/myjF3AFsKgM2XNAR7sO+NRnHBO55k7MfKZVVhzZXRnUV
 cN4VR1p4OqB00TagxJS+0Zoo+wmpNk6UXH1M8Xbo6sLyW6BioXWc/NiAFEVnkVA44k6r 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3papenbxne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:39 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32ECBcEi002075;
        Tue, 14 Mar 2023 12:12:38 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3papenbxmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:38 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32E7n3Nx001030;
        Tue, 14 Mar 2023 12:12:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3p8h96mrvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:36 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ECCYeH46858520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 12:12:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D2F72007A;
        Tue, 14 Mar 2023 12:12:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B57732007C;
        Tue, 14 Mar 2023 12:12:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Mar 2023 12:12:33 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sean Young <sean@mess.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH v3 16/38] media: add HAS_IOPORT dependencies
Date:   Tue, 14 Mar 2023 13:11:54 +0100
Message-Id: <20230314121216.413434-17-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314121216.413434-1-schnelle@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6QnXel7AicAdsq5FDUb8g7DE4Km_uORb
X-Proofpoint-GUID: dXg0tQzXX2oPp3zZM0ZzWLPT22EruzTk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_06,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=984 mlxscore=0 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. We thus need to add HAS_IOPORT as dependency for
those drivers using them.

Reviewed-by: Sean Young <sean@mess.org> # media/rc
Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/media/pci/dm1105/Kconfig |  2 +-
 drivers/media/radio/Kconfig      | 14 +++++++++++++-
 drivers/media/rc/Kconfig         |  6 ++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/dm1105/Kconfig b/drivers/media/pci/dm1105/Kconfig
index e0e3af67c99c..4498c37f4990 100644
--- a/drivers/media/pci/dm1105/Kconfig
+++ b/drivers/media/pci/dm1105/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DVB_DM1105
 	tristate "SDMC DM1105 based PCI cards"
-	depends on DVB_CORE && PCI && I2C && I2C_ALGOBIT
+	depends on DVB_CORE && PCI && I2C && I2C_ALGOBIT && HAS_IOPORT
 	select DVB_PLL if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_STV0299 if MEDIA_SUBDRV_AUTOSELECT
 	select DVB_STV0288 if MEDIA_SUBDRV_AUTOSELECT
diff --git a/drivers/media/radio/Kconfig b/drivers/media/radio/Kconfig
index 616a38feb641..d52eccdc7eb9 100644
--- a/drivers/media/radio/Kconfig
+++ b/drivers/media/radio/Kconfig
@@ -15,7 +15,7 @@ if RADIO_ADAPTERS
 
 config RADIO_MAXIRADIO
 	tristate "Guillemot MAXI Radio FM 2000 radio"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select RADIO_TEA575X
 	help
 	  Choose Y here if you have this radio card.  This card may also be
@@ -232,6 +232,7 @@ source "drivers/media/radio/wl128x/Kconfig"
 menuconfig V4L_RADIO_ISA_DRIVERS
 	bool "ISA radio devices"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	help
 	  Say Y here to enable support for these ISA drivers.
 
@@ -240,6 +241,7 @@ if V4L_RADIO_ISA_DRIVERS
 config RADIO_AZTECH
 	tristate "Aztech/Packard Bell Radio"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	select RADIO_ISA
 	help
 	  Choose Y here if you have one of these FM radio cards, and then fill
@@ -260,6 +262,7 @@ config RADIO_AZTECH_PORT
 config RADIO_CADET
 	tristate "ADS Cadet AM/FM Tuner"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	help
 	  Choose Y here if you have one of these AM/FM radio cards, and then
 	  fill in the port address below.
@@ -270,6 +273,7 @@ config RADIO_CADET
 config RADIO_GEMTEK
 	tristate "GemTek Radio card (or compatible) support"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	select RADIO_ISA
 	help
 	  Choose Y here if you have this FM radio card, and then fill in the
@@ -309,6 +313,7 @@ config RADIO_GEMTEK_PROBE
 
 config RADIO_ISA
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	tristate
 
 config RADIO_MIROPCM20
@@ -329,6 +334,7 @@ config RADIO_MIROPCM20
 config RADIO_RTRACK
 	tristate "AIMSlab RadioTrack (aka RadioReveal) support"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	select RADIO_ISA
 	help
 	  Choose Y here if you have one of these FM radio cards, and then fill
@@ -383,6 +389,7 @@ config RADIO_RTRACK_PORT
 config RADIO_SF16FMI
 	tristate "SF16-FMI/SF16-FMP/SF16-FMD Radio"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	help
 	  Choose Y here if you have one of these FM radio cards.
 
@@ -392,6 +399,7 @@ config RADIO_SF16FMI
 config RADIO_SF16FMR2
 	tristate "SF16-FMR2/SF16-FMD2 Radio"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	select RADIO_TEA575X
 	help
 	  Choose Y here if you have one of these FM radio cards.
@@ -402,6 +410,7 @@ config RADIO_SF16FMR2
 config RADIO_TERRATEC
 	tristate "TerraTec ActiveRadio ISA Standalone"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	select RADIO_ISA
 	help
 	  Choose Y here if you have this FM radio card.
@@ -416,6 +425,7 @@ config RADIO_TERRATEC
 config RADIO_TRUST
 	tristate "Trust FM radio card"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	select RADIO_ISA
 	help
 	  This is a driver for the Trust FM radio cards. Say Y if you have
@@ -439,6 +449,7 @@ config RADIO_TRUST_PORT
 config RADIO_TYPHOON
 	tristate "Typhoon Radio (a.k.a. EcoRadio)"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	select RADIO_ISA
 	help
 	  Choose Y here if you have one of these FM radio cards, and then fill
@@ -473,6 +484,7 @@ config RADIO_TYPHOON_PORT
 config RADIO_ZOLTRIX
 	tristate "Zoltrix Radio"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	select RADIO_ISA
 	help
 	  Choose Y here if you have one of these FM radio cards, and then fill
diff --git a/drivers/media/rc/Kconfig b/drivers/media/rc/Kconfig
index ac4172feb6f9..922c790b577e 100644
--- a/drivers/media/rc/Kconfig
+++ b/drivers/media/rc/Kconfig
@@ -148,6 +148,7 @@ if RC_DEVICES
 config IR_ENE
 	tristate "ENE eHome Receiver/Transceiver (pnp id: ENE0100/ENE02xxx)"
 	depends on PNP || COMPILE_TEST
+	depends on HAS_IOPORT
 	help
 	   Say Y here to enable support for integrated infrared receiver
 	   /transceiver made by ENE.
@@ -161,6 +162,7 @@ config IR_ENE
 config IR_FINTEK
 	tristate "Fintek Consumer Infrared Transceiver"
 	depends on PNP || COMPILE_TEST
+	depends on HAS_IOPORT
 	help
 	   Say Y here to enable support for integrated infrared receiver
 	   /transceiver made by Fintek. This chip is found on assorted
@@ -249,6 +251,7 @@ config IR_IMON_RAW
 config IR_ITE_CIR
 	tristate "ITE Tech Inc. IT8712/IT8512 Consumer Infrared Transceiver"
 	depends on PNP || COMPILE_TEST
+	depends on HAS_IOPORT
 	help
 	   Say Y here to enable support for integrated infrared receivers
 	   /transceivers made by ITE Tech Inc. These are found in
@@ -301,6 +304,7 @@ config IR_MTK
 config IR_NUVOTON
 	tristate "Nuvoton w836x7hg Consumer Infrared Transceiver"
 	depends on PNP || COMPILE_TEST
+	depends on HAS_IOPORT
 	help
 	   Say Y here to enable support for integrated infrared receiver
 	   /transceiver made by Nuvoton (formerly Winbond). This chip is
@@ -345,6 +349,7 @@ config IR_RX51
 
 config IR_SERIAL
 	tristate "Homebrew Serial Port Receiver"
+	depends on HAS_IOPORT
 	help
 	   Say Y if you want to use Homebrew Serial Port Receivers and
 	   Transceivers.
@@ -412,6 +417,7 @@ config IR_TTUSBIR
 config IR_WINBOND_CIR
 	tristate "Winbond IR remote control"
 	depends on (X86 && PNP) || COMPILE_TEST
+	depends on HAS_IOPORT
 	select NEW_LEDS
 	select LEDS_CLASS
 	select BITREVERSE
-- 
2.37.2

