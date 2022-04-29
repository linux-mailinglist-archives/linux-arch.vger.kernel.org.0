Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFEC514C1B
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376980AbiD2OAh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 10:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377003AbiD2N7o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:59:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C5C66F8E;
        Fri, 29 Apr 2022 06:52:39 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TCIZP4017183;
        Fri, 29 Apr 2022 13:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=guokt4FbMDcd1YD63kQpNvjBkqWs3ASuDvzqtKPgZTA=;
 b=AL7AV1tb89O7lacBdYITD2toZh2npI1pt54wsre5O7sq0NNCzmSJuL/CL5MUJ1KUYI9H
 pEtS2efVPpeXb3QhF8G27mcvaXrWzgzZUkCsgDT4VW8JUGsc+Kc1hXRnF/WbkL9Kc6jU
 9sYGZuRVZUZIbrUC8yXZh35GFBJZ5ZHk7OCLTdRBCtWEBoa1lMbVxL8ZxbAYokryJKxp
 TDHitNgRWX+vHi8Ebc2CGgEA8asxBJ9y7HdyApgUELu1uVJXdSjdj1AEPRUBECxXtarJ
 qVQC9fx+0MjU6vtIfRgeBVN9PM4Z4xB4nHNo8Xx1ZFHFrdmsTXJUnvPo9yWoyLOCDzty 2w== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqs3npudh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:26 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDS7M2025989;
        Fri, 29 Apr 2022 13:51:24 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3fm938yag1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:24 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpLME38535646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A2804C040;
        Fri, 29 Apr 2022 13:51:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49E9D4C044;
        Fri, 29 Apr 2022 13:51:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:21 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND)
Subject: [PATCH 11/37] sound: add HAS_IOPORT dependencies
Date:   Fri, 29 Apr 2022 15:50:18 +0200
Message-Id: <20220429135108.2781579-21-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lYH5SECAjqYpRjr9AsWH2Sm6oW35Nj_n
X-Proofpoint-ORIG-GUID: lYH5SECAjqYpRjr9AsWH2Sm6oW35Nj_n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290078
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

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 sound/drivers/Kconfig |  5 +++++
 sound/pci/Kconfig     | 45 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/sound/drivers/Kconfig b/sound/drivers/Kconfig
index ca4cdf666f82..4d250e619786 100644
--- a/sound/drivers/Kconfig
+++ b/sound/drivers/Kconfig
@@ -1,10 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config SND_MPU401_UART
 	tristate
+	depends on HAS_IOPORT
 	select SND_RAWMIDI
 
 config SND_OPL3_LIB
 	tristate
+	depends on HAS_IOPPORT
 	select SND_TIMER
 	select SND_HWDEP
 	select SND_SEQ_DEVICE if SND_SEQUENCER != n
@@ -128,6 +130,7 @@ config SND_VIRMIDI
 
 config SND_MTPAV
 	tristate "MOTU MidiTimePiece AV multiport MIDI"
+	depends on HAS_IOPORT
 	select SND_RAWMIDI
 	help
 	  To use a MOTU MidiTimePiece AV multiport MIDI adapter
@@ -152,6 +155,7 @@ config SND_MTS64
 
 config SND_SERIAL_U16550
 	tristate "UART16550 serial MIDI driver"
+	depends on HAS_IOPORT
 	select SND_RAWMIDI
 	help
 	  To include support for MIDI serial port interfaces, say Y here
@@ -167,6 +171,7 @@ config SND_SERIAL_U16550
 
 config SND_MPU401
 	tristate "Generic MPU-401 UART driver"
+	depends on HAS_IOPORT
 	select SND_MPU401_UART
 	help
 	  Say Y here to include support for MIDI ports compatible with
diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index a55836225401..51c1f38530f6 100644
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
 
@@ -51,7 +51,7 @@ config SND_ALI5451
 	tristate "ALi M5451 PCI Audio Controller"
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y here to include support for the integrated AC97 sound
 	  device on motherboards using the ALi M5451 Audio Controller
@@ -96,6 +96,7 @@ config SND_ATIIXP_MODEM
 
 config SND_AU8810
 	tristate "Aureal Advantage"
+	depends on HAS_IOPORT
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
 	help
@@ -110,6 +111,7 @@ config SND_AU8810
 
 config SND_AU8820
 	tristate "Aureal Vortex"
+	depends on HAS_IOPORT
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
 	help
@@ -123,6 +125,7 @@ config SND_AU8820
 
 config SND_AU8830
 	tristate "Aureal Vortex 2"
+	depends on HAS_IOPORT
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
 	help
@@ -157,7 +160,7 @@ config SND_AZT3328
 	select SND_RAWMIDI
 	select SND_AC97_CODEC
 	select SND_TIMER
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y here to include support for Aztech AZF3328 (PCI168)
 	  soundcards.
@@ -193,6 +196,7 @@ config SND_BT87X_OVERCLOCK
 
 config SND_CA0106
 	tristate "SB Audigy LS / Live 24bit"
+	depends on HAS_IOPORT
 	select SND_AC97_CODEC
 	select SND_RAWMIDI
 	select SND_VMASTER
@@ -205,6 +209,7 @@ config SND_CA0106
 
 config SND_CMIPCI
 	tristate "C-Media 8338, 8738, 8768, 8770"
+	depends on HAS_IOPORT
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_PCM
@@ -221,6 +226,7 @@ config SND_OXYGEN_LIB
 
 config SND_OXYGEN
 	tristate "C-Media 8786, 8787, 8788 (Oxygen)"
+	depends on HAS_IOPORT
 	select SND_OXYGEN_LIB
 	select SND_PCM
 	select SND_MPU401_UART
@@ -246,6 +252,7 @@ config SND_OXYGEN
 
 config SND_CS4281
 	tristate "Cirrus Logic (Sound Fusion) CS4281"
+	depends on HAS_IOPORT
 	select SND_OPL3_LIB
 	select SND_RAWMIDI
 	select SND_AC97_CODEC
@@ -257,6 +264,7 @@ config SND_CS4281
 
 config SND_CS46XX
 	tristate "Cirrus Logic (Sound Fusion) CS4280/CS461x/CS462x/CS463x"
+	depends on HAS_IOPORT
 	select SND_RAWMIDI
 	select SND_AC97_CODEC
 	select FW_LOADER
@@ -290,6 +298,7 @@ config SND_CS5530
 config SND_CS5535AUDIO
 	tristate "CS5535/CS5536 Audio"
 	depends on X86_32 || MIPS || COMPILE_TEST
+	depends on HAS_IOPORT
 	select SND_PCM
 	select SND_AC97_CODEC
 	help
@@ -307,6 +316,7 @@ config SND_CS5535AUDIO
 
 config SND_CTXFI
 	tristate "Creative Sound Blaster X-Fi"
+	depends on HAS_IOPORT
 	select SND_PCM
 	help
 	  If you want to use soundcards based on Creative Sound Blastr X-Fi
@@ -462,13 +472,14 @@ config SND_INDIGODJX
 
 config SND_EMU10K1
 	tristate "Emu10k1 (SB Live!, Audigy, E-mu APS)"
+	depends on HAS_IOPORT
 	select FW_LOADER
 	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_AC97_CODEC
 	select SND_TIMER
 	select SND_SEQ_DEVICE if SND_SEQUENCER != n
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y to include support for Sound Blaster PCI 512, Live!,
 	  Audigy and E-mu APS (partially supported) soundcards.
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
-- 
2.32.0

