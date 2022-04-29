Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58C0514C22
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243277AbiD2ODF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 10:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357407AbiD2OCu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 10:02:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEF66E4E8;
        Fri, 29 Apr 2022 06:53:26 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TCc7RS017233;
        Fri, 29 Apr 2022 13:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=daVhxiWTuS9B4P2cA2D0EYmsyoD90srap5wOQUbBuB8=;
 b=L8H2Yu9yMeE3gslDZ2wQ+Ms3dv0/1xnYkroe1i5YPDADLLWcFc06NyzLyXlXO0CISFr3
 FoMy70lgy+Ds+zwDWhyQnVbOFJXKqalOp6WD+GsoecTA797hW+2vrUEFbtxZ2u+pWvHq
 pVcMYUwAuKEJZjctUJBP7Ha8DVn4ZDxHALoD4t1/3E/oRLarIZou6y0i5uUq7ZEdJi1Q
 NMvQR2u9+9oWNgtoPKEKIMB0CxJ2bXjg2yWZLtYjtSks5koAjWdIceG/EIWqhJ4imxae
 Qf+5cR8F38PJp+JIQ2eSYs9OPsWlFZzNwufuMM/W9OndkChNWJLrMrc5xM+ejzwlEMxO mg== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqqtnsutw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:47 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDSeaH024602;
        Fri, 29 Apr 2022 13:51:46 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3fm938yac8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:45 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpgOb42205508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB38A4C044;
        Fri, 29 Apr 2022 13:51:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5194A4C040;
        Fri, 29 Apr 2022 13:51:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:42 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND)
Subject: [RFC v2 31/39] sound: add HAS_IOPORT dependencies
Date:   Fri, 29 Apr 2022 15:50:54 +0200
Message-Id: <20220429135108.2781579-57-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T2FI9TXjGGjp7GrM_qrYXBpDvXdCJh_C
X-Proofpoint-GUID: T2FI9TXjGGjp7GrM_qrYXBpDvXdCJh_C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 mlxlogscore=747
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
not being declared. We thus need to add HAS_IOPORT as dependency for
those drivers using them. For SND_OPL3_LIB this adds its first
dependency so drivers currently selecting it unconditionally need to
depend on it instead.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 sound/drivers/Kconfig |  5 ++++
 sound/isa/Kconfig     | 44 ++++++++++++++---------------
 sound/pci/Kconfig     | 64 +++++++++++++++++++++++++++++--------------
 3 files changed, 70 insertions(+), 43 deletions(-)

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
diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index 570b88e0b201..072265429f39 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -31,7 +31,7 @@ if SND_ISA
 
 config SND_ADLIB
 	tristate "AdLib FM card"
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	help
 	  Say Y here to include support for AdLib FM cards.
 
@@ -42,7 +42,7 @@ config SND_AD1816A
 	tristate "Analog Devices SoundPort AD1816A"
 	depends on PNP
 	select ISAPNP
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_PCM
 	select SND_TIMER
@@ -70,7 +70,7 @@ config SND_ALS100
 	tristate "Diamond Tech. DT-019x and Avance Logic ALSxxx"
 	depends on PNP
 	select ISAPNP
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_SB16_DSP
 	help
@@ -86,7 +86,7 @@ config SND_AZT1605
 	depends on SND
 	select SND_WSS_LIB
 	select SND_MPU401_UART
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	help
 	  Say Y here to include support for Aztech Sound Galaxy cards
 	  based on the AZT1605 chipset.
@@ -99,7 +99,7 @@ config SND_AZT2316
 	depends on SND
 	select SND_WSS_LIB
 	select SND_MPU401_UART
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	help
 	  Say Y here to include support for Aztech Sound Galaxy cards
 	  based on the AZT2316 chipset.
@@ -111,7 +111,7 @@ config SND_AZT2320
 	tristate "Aztech Systems AZT2320"
 	depends on PNP
 	select ISAPNP
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_WSS_LIB
 	help
@@ -124,7 +124,7 @@ config SND_AZT2320
 config SND_CMI8328
 	tristate "C-Media CMI8328"
 	select SND_WSS_LIB
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	help
 	  Say Y here to include support for soundcards based on the
@@ -137,7 +137,7 @@ config SND_CMI8330
 	tristate "C-Media CMI8330"
 	select SND_WSS_LIB
 	select SND_SB16_DSP
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	help
 	  Say Y here to include support for soundcards based on the
@@ -159,7 +159,7 @@ config SND_CS4231
 
 config SND_CS4236
 	tristate "Generic Cirrus Logic CS4232/CS4236+ driver"
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_WSS_LIB
 	help
@@ -172,7 +172,7 @@ config SND_CS4236
 
 config SND_ES1688
 	tristate "Generic ESS ES688/ES1688 and ES968 PnP driver"
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_PCM
 	help
@@ -184,7 +184,7 @@ config SND_ES1688
 
 config SND_ES18XX
 	tristate "Generic ESS ES18xx driver"
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_PCM
 	help
@@ -197,7 +197,7 @@ config SND_SC6000
 	tristate "Gallant SC-6000/6600/7000 and Audio Excel DSP 16"
 	depends on HAS_IOPORT_MAP
 	select SND_WSS_LIB
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	help
 	  Say Y here to include support for Gallant SC-6000, SC-6600, SC-7000
@@ -223,7 +223,7 @@ config SND_GUSCLASSIC
 
 config SND_GUSEXTREME
 	tristate "Gravis UltraSound Extreme"
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_PCM
 	select SND_TIMER
@@ -273,7 +273,7 @@ config SND_INTERWAVE_STB
 
 config SND_JAZZ16
 	tristate "Media Vision Jazz16 card and compatibles"
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_SB8_DSP
 	help
@@ -289,7 +289,7 @@ config SND_JAZZ16
 
 config SND_OPL3SA2
 	tristate "Yamaha OPL3-SA2/SA3"
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_WSS_LIB
 	help
@@ -301,7 +301,7 @@ config SND_OPL3SA2
 
 config SND_OPTI92X_AD1848
 	tristate "OPTi 82C92x - AD1848"
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_OPL4_LIB
 	select SND_MPU401_UART
 	select SND_WSS_LIB
@@ -314,7 +314,7 @@ config SND_OPTI92X_AD1848
 
 config SND_OPTI92X_CS4231
 	tristate "OPTi 82C92x - CS4231"
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_OPL4_LIB
 	select SND_MPU401_UART
 	select SND_WSS_LIB
@@ -327,7 +327,7 @@ config SND_OPTI92X_CS4231
 
 config SND_OPTI93X
 	tristate "OPTi 82C93x"
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_WSS_LIB
 	help
@@ -352,7 +352,7 @@ config SND_MIRO
 
 config SND_SB8
 	tristate "Sound Blaster 1.0/2.0/Pro (8-bit)"
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_RAWMIDI
 	select SND_SB8_DSP
 	help
@@ -364,7 +364,7 @@ config SND_SB8
 
 config SND_SB16
 	tristate "Sound Blaster 16 (PnP)"
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_SB16_DSP
 	help
@@ -376,7 +376,7 @@ config SND_SB16
 
 config SND_SBAWE
 	tristate "Sound Blaster AWE (32,64) (PnP)"
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_SB16_DSP
 	select SND_SEQ_DEVICE if SND_SEQUENCER != n
@@ -427,7 +427,7 @@ config SND_SSCAPE
 config SND_WAVEFRONT
 	tristate "Turtle Beach Maui,Tropez,Tropez+ (Wavefront)"
 	select FW_LOADER
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_WSS_LIB
 	help
diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index a55836225401..c9fd973a7893 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -25,8 +25,8 @@ config SND_ALS300
 	tristate "Avance Logic ALS300/ALS300+"
 	select SND_PCM
 	select SND_AC97_CODEC
-	select SND_OPL3_LIB
-	depends on ZONE_DMA
+	depends on SND_OPL3_LIB
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say 'Y' or 'M' to include support for Avance Logic ALS300/ALS300+
 
@@ -36,7 +36,7 @@ config SND_ALS300
 config SND_ALS4000
 	tristate "Avance Logic ALS4000"
 	depends on ISA_DMA_API
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_PCM
 	select SND_SB_COMMON
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
@@ -151,13 +154,13 @@ config SND_AW2
 
 config SND_AZT3328
 	tristate "Aztech AZF3328 / PCI168"
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_PCM
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
@@ -205,7 +209,8 @@ config SND_CA0106
 
 config SND_CMIPCI
 	tristate "C-Media 8338, 8738, 8768, 8770"
-	select SND_OPL3_LIB
+	depends on HAS_IOPORT
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_PCM
 	help
@@ -221,6 +226,7 @@ config SND_OXYGEN_LIB
 
 config SND_OXYGEN
 	tristate "C-Media 8786, 8787, 8788 (Oxygen)"
+	depends on HAS_IOPORT
 	select SND_OXYGEN_LIB
 	select SND_PCM
 	select SND_MPU401_UART
@@ -246,7 +252,8 @@ config SND_OXYGEN
 
 config SND_CS4281
 	tristate "Cirrus Logic (Sound Fusion) CS4281"
-	select SND_OPL3_LIB
+	depends on HAS_IOPORT
+	depends on SND_OPL3_LIB
 	select SND_RAWMIDI
 	select SND_AC97_CODEC
 	help
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
@@ -468,7 +478,7 @@ config SND_EMU10K1
 	select SND_AC97_CODEC
 	select SND_TIMER
 	select SND_SEQ_DEVICE if SND_SEQUENCER != n
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y to include support for Sound Blaster PCI 512, Live!,
 	  Audigy and E-mu APS (partially supported) soundcards.
@@ -491,7 +501,7 @@ config SND_EMU10K1X
 	tristate "Emu10k1X (Dell OEM Version)"
 	select SND_AC97_CODEC
 	select SND_RAWMIDI
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y here to include support for the Dell OEM version of the
 	  Sound Blaster Live!.
@@ -501,6 +511,7 @@ config SND_EMU10K1X
 
 config SND_ENS1370
 	tristate "(Creative) Ensoniq AudioPCI 1370"
+	depends on HAS_IOPORT
 	select SND_RAWMIDI
 	select SND_PCM
 	help
@@ -511,6 +522,7 @@ config SND_ENS1370
 
 config SND_ENS1371
 	tristate "(Creative) Ensoniq AudioPCI 1371/1373"
+	depends on HAS_IOPORT
 	select SND_RAWMIDI
 	select SND_AC97_CODEC
 	help
@@ -522,10 +534,10 @@ config SND_ENS1371
 
 config SND_ES1938
 	tristate "ESS ES1938/1946/1969 (Solo-1)"
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y here to include support for soundcards based on ESS Solo-1
 	  (ES1938, ES1946, ES1969) chips.
@@ -537,7 +549,7 @@ config SND_ES1968
 	tristate "ESS ES1968/1978 (Maestro-1/2/2E)"
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y here to include support for soundcards based on ESS Maestro
 	  1/2/2E chips.
@@ -569,7 +581,8 @@ config SND_ES1968_RADIO
 
 config SND_FM801
 	tristate "ForteMedia FM801"
-	select SND_OPL3_LIB
+	depends on HAS_IOPORT
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
 	help
@@ -624,7 +637,7 @@ config SND_ICE1712
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
 	select BITREVERSE
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y here to include support for soundcards based on the
 	  ICE1712 (Envy24) chip.
@@ -640,6 +653,7 @@ config SND_ICE1712
 
 config SND_ICE1724
 	tristate "ICE/VT1724/1720 (Envy24HT/PT)"
+	depends on HAS_IOPORT
 	select SND_RAWMIDI
 	select SND_AC97_CODEC
 	select SND_VMASTER
@@ -712,7 +726,7 @@ config SND_LX6464ES
 config SND_MAESTRO3
 	tristate "ESS Allegro/Maestro3"
 	select SND_AC97_CODEC
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y here to include support for soundcards based on ESS Maestro 3
 	  (Allegro) chips.
@@ -753,6 +767,7 @@ config SND_NM256
 
 config SND_PCXHR
 	tristate "Digigram PCXHR"
+	depends on HAS_IOPORT
 	select FW_LOADER
 	select SND_PCM
 	select SND_HWDEP
@@ -764,8 +779,9 @@ config SND_PCXHR
 
 config SND_RIPTIDE
 	tristate "Conexant Riptide"
+	depends on HAS_IOPORT
 	select FW_LOADER
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
 	help
@@ -808,6 +824,7 @@ config SND_RME9652
 config SND_SE6X
 	tristate "Studio Evolution SE6X"
 	depends on SND_OXYGEN=n && SND_VIRTUOSO=n  # PCI ID conflict
+	depends on HAS_IOPORT
 	select SND_OXYGEN_LIB
 	select SND_PCM
 	select SND_MPU401_UART
@@ -827,10 +844,10 @@ config SND_SIS7019
 
 config SND_SONICVIBES
 	tristate "S3 SonicVibes"
-	select SND_OPL3_LIB
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y here to include support for soundcards based on the S3
 	  SonicVibes chip.
@@ -842,7 +859,7 @@ config SND_TRIDENT
 	tristate "Trident 4D-Wave DX/NX; SiS 7018"
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
-	depends on ZONE_DMA
+	depends on ZONE_DMA && HAS_IOPORT
 	help
 	  Say Y here to include support for soundcards based on Trident
 	  4D-Wave DX/NX or SiS 7018 chips.
@@ -852,6 +869,7 @@ config SND_TRIDENT
 
 config SND_VIA82XX
 	tristate "VIA 82C686A/B, 8233/8235 AC97 Controller"
+	depends on HAS_IOPORT
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
 	help
@@ -863,6 +881,7 @@ config SND_VIA82XX
 
 config SND_VIA82XX_MODEM
 	tristate "VIA 82C686A/B, 8233 based Modems"
+	depends on HAS_IOPORT
 	select SND_AC97_CODEC
 	help
 	  Say Y here to include support for the integrated MC97 modem on
@@ -873,6 +892,7 @@ config SND_VIA82XX_MODEM
 
 config SND_VIRTUOSO
 	tristate "Asus Virtuoso 66/100/200 (Xonar)"
+	depends on HAS_IOPORT
 	select SND_OXYGEN_LIB
 	select SND_PCM
 	select SND_MPU401_UART
@@ -889,6 +909,7 @@ config SND_VIRTUOSO
 
 config SND_VX222
 	tristate "Digigram VX222"
+	depends on HAS_IOPORT
 	select SND_VX_LIB
 	help
 	  Say Y here to include support for Digigram VX222 soundcards.
@@ -898,7 +919,8 @@ config SND_VX222
 
 config SND_YMFPCI
 	tristate "Yamaha YMF724/740/744/754"
-	select SND_OPL3_LIB
+	depends on HAS_IOPORT
+	depends on SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
 	select SND_TIMER
-- 
2.32.0

