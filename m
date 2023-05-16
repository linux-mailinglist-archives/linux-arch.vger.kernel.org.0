Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E463F704D22
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 13:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjEPLzZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 07:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjEPLzX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 07:55:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC10FE6;
        Tue, 16 May 2023 04:55:13 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GAehRE016889;
        Tue, 16 May 2023 11:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UUVFM2HfRHrwN5e+OhtJj7IKmle9eZ6GbG4xEvO1NLM=;
 b=nR5ahaD9VDMOqSPmz8ZploXfPfey+FFMgRFaDLJVNt3Q1gZH5M9Emeyx+YNRDHHKAAOz
 ZgZXcUFouaa5ncRGF9x9ykLiwR9BYhMLDCS/XxDqqgKe7I9U19eB4bjROfSbkGCs3Oun
 MPO7N+iVyC8WiUigAT0ZrRUjRufh4b7Q5NPOMwcBmwn/zVnC8Y3RV741atQEXiyKylBv
 /5LDeLJjGDFR4butLUnRLk1KymQFX1HzTQC/E+ZP5GqYZxkLGUep2VcCryO4POBSj1rA
 N5263iiNJj45nYuVt/rKGeRA4DuveQYnHohkLtOOr7ulkta8BUOI/+jtAgcWj/XGnu/s /A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm82f0v48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:06:28 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34GAfKxF018192;
        Tue, 16 May 2023 11:06:09 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm82f0pqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:06:09 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34FMqI0x023513;
        Tue, 16 May 2023 11:01:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qj1tdsjre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:01:09 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34GB16GY26477258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 11:01:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD11220043;
        Tue, 16 May 2023 11:01:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C94820040;
        Tue, 16 May 2023 11:01:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 16 May 2023 11:01:06 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
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
        alsa-devel@alsa-project.org
Subject: [PATCH v4 30/41] sound: add HAS_IOPORT dependencies
Date:   Tue, 16 May 2023 13:00:26 +0200
Message-Id: <20230516110038.2413224-31-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516110038.2413224-1-schnelle@linux.ibm.com>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CdJv1u4v-4NfbYb5iPbftOFRyComPgFE
X-Proofpoint-ORIG-GUID: CnP0pB2OQOOY9cm3HdR5yebtL2dcSQ--
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_04,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160094
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. We thus need to add HAS_IOPORT as dependency for
those drivers using them.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: The HAS_IOPORT Kconfig option was added in v6.4-rc1 so
      per-subsystem patches may be applied independently

 sound/drivers/Kconfig |  3 +++
 sound/isa/Kconfig     |  1 +
 sound/pci/Kconfig     | 45 ++++++++++++++++++++++++++++++++-----------
 sound/pcmcia/Kconfig  |  1 +
 4 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/sound/drivers/Kconfig b/sound/drivers/Kconfig
index be3009746f3a..864991d8776d 100644
--- a/sound/drivers/Kconfig
+++ b/sound/drivers/Kconfig
@@ -128,6 +128,7 @@ config SND_VIRMIDI
 
 config SND_MTPAV
 	tristate "MOTU MidiTimePiece AV multiport MIDI"
+	depends on HAS_IOPORT
 	select SND_RAWMIDI
 	help
 	  To use a MOTU MidiTimePiece AV multiport MIDI adapter
@@ -152,6 +153,7 @@ config SND_MTS64
 
 config SND_SERIAL_U16550
 	tristate "UART16550 serial MIDI driver"
+	depends on HAS_IOPORT
 	select SND_RAWMIDI
 	help
 	  To include support for MIDI serial port interfaces, say Y here
@@ -185,6 +187,7 @@ config SND_SERIAL_GENERIC
 
 config SND_MPU401
 	tristate "Generic MPU-401 UART driver"
+	depends on HAS_IOPORT
 	select SND_MPU401_UART
 	help
 	  Say Y here to include support for MIDI ports compatible with
diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index 6ffa48dd5983..f8159179e38d 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -23,6 +23,7 @@ menuconfig SND_ISA
 	bool "ISA sound devices"
 	depends on ISA || COMPILE_TEST
 	depends on ISA_DMA_API
+	depends on HAS_IOPORT
 	default y
 	help
 	  Support for sound devices connected via the ISA bus.
diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 861958451ef5..787868c9e91b 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -26,7 +26,7 @@ config SND_ALS300
 	select SND_PCM
 	select SND_AC97_CODEC
 	select SND_OPL3_LIB
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say 'Y' or 'M' to include support for Avance Logic ALS300/ALS300+
 
@@ -36,6 +36,7 @@ config SND_ALS300
 config SND_ALS4000
 	tristate "Avance Logic ALS4000"
 	depends on ISA_DMA_API
+	depends on HAS_IOPORT
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_PCM
@@ -51,7 +52,7 @@ config SND_ALI5451
 	tristate "ALi M5451 PCI Audio Controller"
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y here to include support for the integrated AC97 sound
 	  device on motherboards using the ALi M5451 Audio Controller
@@ -96,6 +97,7 @@ config SND_ATIIXP_MODEM
 
 config SND_AU8810
 	tristate "Aureal Advantage"
+	depends on HAS_IOPORT
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
 	help
@@ -110,6 +112,7 @@ config SND_AU8810
 
 config SND_AU8820
 	tristate "Aureal Vortex"
+	depends on HAS_IOPORT
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
 	help
@@ -123,6 +126,7 @@ config SND_AU8820
 
 config SND_AU8830
 	tristate "Aureal Vortex 2"
+	depends on HAS_IOPORT
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
 	help
@@ -157,7 +161,7 @@ config SND_AZT3328
 	select SND_RAWMIDI
 	select SND_AC97_CODEC
 	select SND_TIMER
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y here to include support for Aztech AZF3328 (PCI168)
 	  soundcards.
@@ -193,6 +197,7 @@ config SND_BT87X_OVERCLOCK
 
 config SND_CA0106
 	tristate "SB Audigy LS / Live 24bit"
+	depends on HAS_IOPORT
 	select SND_AC97_CODEC
 	select SND_RAWMIDI
 	select SND_VMASTER
@@ -205,6 +210,7 @@ config SND_CA0106
 
 config SND_CMIPCI
 	tristate "C-Media 8338, 8738, 8768, 8770"
+	depends on HAS_IOPORT
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_PCM
@@ -221,6 +227,7 @@ config SND_OXYGEN_LIB
 
 config SND_OXYGEN
 	tristate "C-Media 8786, 8787, 8788 (Oxygen)"
+	depends on HAS_IOPORT
 	select SND_OXYGEN_LIB
 	select SND_PCM
 	select SND_MPU401_UART
@@ -246,6 +253,7 @@ config SND_OXYGEN
 
 config SND_CS4281
 	tristate "Cirrus Logic (Sound Fusion) CS4281"
+	depends on HAS_IOPORT
 	select SND_OPL3_LIB
 	select SND_RAWMIDI
 	select SND_AC97_CODEC
@@ -257,6 +265,7 @@ config SND_CS4281
 
 config SND_CS46XX
 	tristate "Cirrus Logic (Sound Fusion) CS4280/CS461x/CS462x/CS463x"
+	depends on HAS_IOPORT
 	select SND_RAWMIDI
 	select SND_AC97_CODEC
 	select FW_LOADER
@@ -290,6 +299,7 @@ config SND_CS5530
 config SND_CS5535AUDIO
 	tristate "CS5535/CS5536 Audio"
 	depends on X86_32 || MIPS || COMPILE_TEST
+	depends on HAS_IOPORT
 	select SND_PCM
 	select SND_AC97_CODEC
 	help
@@ -307,6 +317,7 @@ config SND_CS5535AUDIO
 
 config SND_CTXFI
 	tristate "Creative Sound Blaster X-Fi"
+	depends on HAS_IOPORT
 	select SND_PCM
 	help
 	  If you want to use soundcards based on Creative Sound Blastr X-Fi
@@ -468,7 +479,7 @@ config SND_EMU10K1
 	select SND_AC97_CODEC
 	select SND_TIMER
 	select SND_SEQ_DEVICE if SND_SEQUENCER != n
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y to include support for Sound Blaster PCI 512, Live!,
 	  Audigy and E-MU APS/0404/1010/1212/1616/1820 soundcards.
@@ -491,7 +502,7 @@ config SND_EMU10K1X
 	tristate "Emu10k1X (Dell OEM Version)"
 	select SND_AC97_CODEC
 	select SND_RAWMIDI
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y here to include support for the Dell OEM version of the
 	  Sound Blaster Live!.
@@ -501,6 +512,7 @@ config SND_EMU10K1X
 
 config SND_ENS1370
 	tristate "(Creative) Ensoniq AudioPCI 1370"
+	depends on HAS_IOPORT
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -511,6 +523,7 @@ config SND_ENS1370
 
 config SND_ENS1371
 	tristate "(Creative) Ensoniq AudioPCI 1371/1373"
+	depends on HAS_IOPORT
 	select SND_RAWMIDI
 	select SND_AC97_CODEC
 	help
@@ -525,7 +538,7 @@ config SND_ES1938
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y here to include support for soundcards based on ESS Solo-1
 	  (ES1938, ES1946, ES1969) chips.
@@ -537,7 +550,7 @@ config SND_ES1968
 	tristate "ESS ES1968/1978 (Maestro-1/2/2E)"
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y here to include support for soundcards based on ESS Maestro
 	  1/2/2E chips.
@@ -569,6 +582,7 @@ config SND_ES1968_RADIO
 
 config SND_FM801
 	tristate "ForteMedia FM801"
+	depends on HAS_IOPORT
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
@@ -624,7 +638,7 @@ config SND_ICE1712
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
 	select BITREVERSE
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y here to include support for soundcards based on the
 	  ICE1712 (Envy24) chip.
@@ -640,6 +654,7 @@ config SND_ICE1712
 
 config SND_ICE1724
 	tristate "ICE/VT1724/1720 (Envy24HT/PT)"
+	depends on HAS_IOPORT
 	select SND_RAWMIDI
 	select SND_AC97_CODEC
 	select SND_VMASTER
@@ -712,7 +727,7 @@ config SND_LX6464ES
 config SND_MAESTRO3
 	tristate "ESS Allegro/Maestro3"
 	select SND_AC97_CODEC
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y here to include support for soundcards based on ESS Maestro 3
 	  (Allegro) chips.
@@ -753,6 +768,7 @@ config SND_NM256
 
 config SND_PCXHR
 	tristate "Digigram PCXHR"
+	depends on HAS_IOPORT
 	select FW_LOADER
 	select SND_PCM
 	select SND_HWDEP
@@ -764,6 +780,7 @@ config SND_PCXHR
 
 config SND_RIPTIDE
 	tristate "Conexant Riptide"
+	depends on HAS_IOPORT
 	select FW_LOADER
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
@@ -808,6 +825,7 @@ config SND_RME9652
 config SND_SE6X
 	tristate "Studio Evolution SE6X"
 	depends on SND_OXYGEN=n && SND_VIRTUOSO=n  # PCI ID conflict
+	depends on HAS_IOPORT
 	select SND_OXYGEN_LIB
 	select SND_PCM
 	select SND_MPU401_UART
@@ -830,7 +848,7 @@ config SND_SONICVIBES
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y here to include support for soundcards based on the S3
 	  SonicVibes chip.
@@ -842,7 +860,7 @@ config SND_TRIDENT
 	tristate "Trident 4D-Wave DX/NX; SiS 7018"
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y here to include support for soundcards based on Trident
 	  4D-Wave DX/NX or SiS 7018 chips.
@@ -852,6 +870,7 @@ config SND_TRIDENT
 
 config SND_VIA82XX
 	tristate "VIA 82C686A/B, 8233/8235 AC97 Controller"
+	depends on HAS_IOPORT
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
 	help
@@ -863,6 +882,7 @@ config SND_VIA82XX
 
 config SND_VIA82XX_MODEM
 	tristate "VIA 82C686A/B, 8233 based Modems"
+	depends on HAS_IOPORT
 	select SND_AC97_CODEC
 	help
 	  Say Y here to include support for the integrated MC97 modem on
@@ -873,6 +893,7 @@ config SND_VIA82XX_MODEM
 
 config SND_VIRTUOSO
 	tristate "Asus Virtuoso 66/100/200 (Xonar)"
+	depends on HAS_IOPORT
 	select SND_OXYGEN_LIB
 	select SND_PCM
 	select SND_MPU401_UART
@@ -889,6 +910,7 @@ config SND_VIRTUOSO
 
 config SND_VX222
 	tristate "Digigram VX222"
+	depends on HAS_IOPORT
 	select SND_VX_LIB
 	help
 	  Say Y here to include support for Digigram VX222 soundcards.
@@ -898,6 +920,7 @@ config SND_VX222
 
 config SND_YMFPCI
 	tristate "Yamaha YMF724/740/744/754"
+	depends on HAS_IOPORT
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
diff --git a/sound/pcmcia/Kconfig b/sound/pcmcia/Kconfig
index 10291c43cb18..2e3dfc1ff540 100644
--- a/sound/pcmcia/Kconfig
+++ b/sound/pcmcia/Kconfig
@@ -4,6 +4,7 @@
 menuconfig SND_PCMCIA
 	bool "PCMCIA sound devices"
 	depends on PCMCIA
+	depends on HAS_IOPORT
 	default y
 	help
 	  Support for sound devices connected via the PCMCIA bus.
-- 
2.39.2

