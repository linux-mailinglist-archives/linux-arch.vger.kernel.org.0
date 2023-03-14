Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9256B9363
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 13:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjCNMPq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 08:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjCNMPA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 08:15:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9188A17E0;
        Tue, 14 Mar 2023 05:13:53 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EBS93Z005430;
        Tue, 14 Mar 2023 12:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jotHich1ubK7CMDILZvcLciJC2uym4TF8D7ILOPPytc=;
 b=QelFLwzae5JHosQcPv0ZS4eNCbTTW7l8NGgWyBv9GhdbmPwfMzmkoVNbCNKDpjTr4DAT
 QO3XZ2DuZXGzvzafpUB+s7qC6IQ77hZtsI0MzQLTFaX67yFm36r4Zzf/RjWxPN3jDQiB
 kwYr6+GEaYXyPeezq7aBboGq9AzSZA+s+wlRt2OUC1yGn6TDFkog0k8O+PKh+9OA99sj
 qjFyto41okLZMeFuAdiLEKSUxEJFg10YeQxe3U/KCoVQLDseg9V45gdwdYTw7J4aUht1
 ZETK2OcRMkQzs8mS4sYRuJ6m6jxmMaEf4vNKZ2658X1PNLSPZ9m87gluNubG/9FxGk+3 ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pap49cmrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:55 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32EBY8FK014972;
        Tue, 14 Mar 2023 12:12:54 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pap49cmqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:54 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32E8ibsU006605;
        Tue, 14 Mar 2023 12:12:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3p8h96krsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ECCn1X44892648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 12:12:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 142382007C;
        Tue, 14 Mar 2023 12:12:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 869782007A;
        Tue, 14 Mar 2023 12:12:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Mar 2023 12:12:48 +0000 (GMT)
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
Subject: [PATCH v3 30/38] sound: add HAS_IOPORT dependencies
Date:   Tue, 14 Mar 2023 13:12:08 +0100
Message-Id: <20230314121216.413434-31-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314121216.413434-1-schnelle@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yvjhkJVsfV2Yzl2Z7yAnLz1ihTsxecGL
X-Proofpoint-ORIG-GUID: fl_Nmtvxw2xmHTvgst7GWNyxgK7eLorG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_06,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
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
not being declared. We thus need to add HAS_IOPORT as dependency for
those drivers using them.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 sound/drivers/Kconfig |  3 +++
 sound/isa/Kconfig     | 31 ++++++++++++++++++++++++++---
 sound/pci/Kconfig     | 45 ++++++++++++++++++++++++++++++++-----------
 sound/pcmcia/Kconfig  |  2 ++
 4 files changed, 67 insertions(+), 14 deletions(-)

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
index 6ffa48dd5983..c7cef1e656fa 100644
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
@@ -31,6 +32,7 @@ if SND_ISA
 
 config SND_ADLIB
 	tristate "AdLib FM card"
+	depends on HAS_IOPORT
 	select SND_OPL3_LIB
 	help
 	  Say Y here to include support for AdLib FM cards.
@@ -41,6 +43,7 @@ config SND_ADLIB
 config SND_AD1816A
 	tristate "Analog Devices SoundPort AD1816A"
 	depends on PNP
+	depends on HAS_IOPORT
 	select ISAPNP
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
@@ -69,6 +72,7 @@ config SND_AD1848
 config SND_ALS100
 	tristate "Diamond Tech. DT-019x and Avance Logic ALSxxx"
 	depends on PNP
+	depends on HAS_IOPORT
 	select ISAPNP
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
@@ -84,6 +88,7 @@ config SND_ALS100
 config SND_AZT1605
 	tristate "Aztech AZT1605 Driver"
 	depends on SND
+	depends on HAS_IOPORT
 	select SND_WSS_LIB
 	select SND_MPU401_UART
 	select SND_OPL3_LIB
@@ -97,6 +102,7 @@ config SND_AZT1605
 config SND_AZT2316
 	tristate "Aztech AZT2316 Driver"
 	depends on SND
+	depends on HAS_IOPORT
 	select SND_WSS_LIB
 	select SND_MPU401_UART
 	select SND_OPL3_LIB
@@ -110,6 +116,7 @@ config SND_AZT2316
 config SND_AZT2320
 	tristate "Aztech Systems AZT2320"
 	depends on PNP
+	depends on HAS_IOPORT
 	select ISAPNP
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
@@ -123,6 +130,7 @@ config SND_AZT2320
 
 config SND_CMI8328
 	tristate "C-Media CMI8328"
+	depends on HAS_IOPORT
 	select SND_WSS_LIB
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
@@ -135,6 +143,7 @@ config SND_CMI8328
 
 config SND_CMI8330
 	tristate "C-Media CMI8330"
+	depends on HAS_IOPORT
 	select SND_WSS_LIB
 	select SND_SB16_DSP
 	select SND_OPL3_LIB
@@ -148,6 +157,7 @@ config SND_CMI8330
 
 config SND_CS4231
 	tristate "Generic Cirrus Logic CS4231 driver"
+	depends on HAS_IOPORT
 	select SND_MPU401_UART
 	select SND_WSS_LIB
 	help
@@ -159,6 +169,7 @@ config SND_CS4231
 
 config SND_CS4236
 	tristate "Generic Cirrus Logic CS4232/CS4236+ driver"
+	depends on HAS_IOPORT
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_WSS_LIB
@@ -172,6 +183,7 @@ config SND_CS4236
 
 config SND_ES1688
 	tristate "Generic ESS ES688/ES1688 and ES968 PnP driver"
+	depends on HAS_IOPORT
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_PCM
@@ -184,6 +196,7 @@ config SND_ES1688
 
 config SND_ES18XX
 	tristate "Generic ESS ES18xx driver"
+	depends on HAS_IOPORT
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_PCM
@@ -195,7 +208,7 @@ config SND_ES18XX
 
 config SND_SC6000
 	tristate "Gallant SC-6000/6600/7000 and Audio Excel DSP 16"
-	depends on HAS_IOPORT_MAP
+	depends on HAS_IOPORT_MAP && HAS_IOPORT
 	select SND_WSS_LIB
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
@@ -223,6 +236,7 @@ config SND_GUSCLASSIC
 
 config SND_GUSEXTREME
 	tristate "Gravis UltraSound Extreme"
+	depends on HAS_IOPORT
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_PCM
@@ -273,6 +287,7 @@ config SND_INTERWAVE_STB
 
 config SND_JAZZ16
 	tristate "Media Vision Jazz16 card and compatibles"
+	depends on HAS_IOPORT
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_SB8_DSP
@@ -289,6 +304,7 @@ config SND_JAZZ16
 
 config SND_OPL3SA2
 	tristate "Yamaha OPL3-SA2/SA3"
+	depends on HAS_IOPORT
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_WSS_LIB
@@ -301,6 +317,7 @@ config SND_OPL3SA2
 
 config SND_OPTI92X_AD1848
 	tristate "OPTi 82C92x - AD1848"
+	depends on HAS_IOPORT
 	select SND_OPL3_LIB
 	select SND_OPL4_LIB
 	select SND_MPU401_UART
@@ -314,6 +331,7 @@ config SND_OPTI92X_AD1848
 
 config SND_OPTI92X_CS4231
 	tristate "OPTi 82C92x - CS4231"
+	depends on HAS_IOPORT
 	select SND_OPL3_LIB
 	select SND_OPL4_LIB
 	select SND_MPU401_UART
@@ -327,6 +345,7 @@ config SND_OPTI92X_CS4231
 
 config SND_OPTI93X
 	tristate "OPTi 82C93x"
+	depends on HAS_IOPORT
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_WSS_LIB
@@ -339,6 +358,7 @@ config SND_OPTI93X
 
 config SND_MIRO
 	tristate "Miro miroSOUND PCM1pro/PCM12/PCM20radio driver"
+	depends on HAS_IOPORT
 	select SND_OPL4_LIB
 	select SND_WSS_LIB
 	select SND_MPU401_UART
@@ -352,6 +372,7 @@ config SND_MIRO
 
 config SND_SB8
 	tristate "Sound Blaster 1.0/2.0/Pro (8-bit)"
+	depends on HAS_IOPORT
 	select SND_OPL3_LIB
 	select SND_RAWMIDI
 	select SND_SB8_DSP
@@ -364,6 +385,7 @@ config SND_SB8
 
 config SND_SB16
 	tristate "Sound Blaster 16 (PnP)"
+	depends on HAS_IOPORT
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_SB16_DSP
@@ -376,6 +398,7 @@ config SND_SB16
 
 config SND_SBAWE
 	tristate "Sound Blaster AWE (32,64) (PnP)"
+	depends on HAS_IOPORT
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_SB16_DSP
@@ -405,6 +428,7 @@ config SND_SB16_CSP
 
 config SND_SSCAPE
 	tristate "Ensoniq SoundScape driver"
+	depends on HAS_IOPORT
 	select SND_MPU401_UART
 	select SND_WSS_LIB
 	select FW_LOADER
@@ -426,6 +450,7 @@ config SND_SSCAPE
 
 config SND_WAVEFRONT
 	tristate "Turtle Beach Maui,Tropez,Tropez+ (Wavefront)"
+	depends on HAS_IOPORT
 	select FW_LOADER
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
@@ -439,7 +464,7 @@ config SND_WAVEFRONT
 
 config SND_MSND_PINNACLE
 	tristate "Turtle Beach MultiSound Pinnacle/Fiji driver"
-	depends on X86
+	depends on X86 && HAS_IOPORT
 	select FW_LOADER
 	select SND_MPU401_UART
 	select SND_PCM
@@ -452,7 +477,7 @@ config SND_MSND_PINNACLE
 
 config SND_MSND_CLASSIC
 	tristate "Support for Turtle Beach MultiSound Classic, Tahiti, Monterey"
-	depends on X86
+	depends on X86 && HAS_IOPORT
 	select FW_LOADER
 	select SND_MPU401_UART
 	select SND_PCM
diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index a55836225401..e8780bade58f 100644
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
diff --git a/sound/pcmcia/Kconfig b/sound/pcmcia/Kconfig
index 10291c43cb18..b133ad423f84 100644
--- a/sound/pcmcia/Kconfig
+++ b/sound/pcmcia/Kconfig
@@ -13,6 +13,7 @@ if SND_PCMCIA && PCMCIA
 config SND_VXPOCKET
 	tristate "Digigram VXpocket"
 	select SND_VX_LIB
+	depends on HAS_IOPORT
 	help
 	  Say Y here to include support for Digigram VXpocket and
 	  VXpocket 440 soundcards.
@@ -22,6 +23,7 @@ config SND_VXPOCKET
 
 config SND_PDAUDIOCF
 	tristate "Sound Core PDAudioCF"
+	depends on HAS_IOPORT
 	select SND_PCM
 	help
 	  Say Y here to include support for Sound Core PDAudioCF
-- 
2.37.2

