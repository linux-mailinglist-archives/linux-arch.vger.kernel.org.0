Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6864801F2
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 17:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhL0Qo0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 11:44:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15130 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230007AbhL0QoI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Dec 2021 11:44:08 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BRDkFo0013529;
        Mon, 27 Dec 2021 16:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CnsD7jKlvjoZEnfpLO2N3ECs4TU0U2b/w/vg/v6TwgQ=;
 b=sOt9rjEUO3YCSjFHKFWDTe5Xw1hn+N4G75OkQQA8jgw2XYxidbWEemPra0I6MltAkAVL
 NZzn1c6Dvzwhql2bTCdnMtOiqNcFKdzckJ0M9isIeJHBvy3cG42LUUFAOnSzF7XFP4Nt
 LAiFTH7ngrZV+UQt4IqX5X9P0uyXY4m06Rt/5Jbm5gZ2wgWqscEhWyviShbf9RPBi7IR
 r7W3eGqmoSAxEL9nkPvYSBoFRwdeG8VSz4nmMiWOqRlhQSm39FH6T2MOk//cdLlPGWhS
 lRE6Qe53zLM8dD/wVJZPqWTChwMtz0pLcTyCVJGCWYCnGawpNZsDJyF3Zeog2ZtKj/bi fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d7e5d3j6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:44 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BRGhhqH000315;
        Mon, 27 Dec 2021 16:43:43 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d7e5d3j65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:43 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGgnWT003091;
        Mon, 27 Dec 2021 16:43:41 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3d5tx9bf4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:41 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BRGhdjb42598670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Dec 2021 16:43:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 353D2A4054;
        Mon, 27 Dec 2021 16:43:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC79DA405B;
        Mon, 27 Dec 2021 16:43:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Dec 2021 16:43:38 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sean Young <sean@mess.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-media@vger.kernel.org
Subject: [RFC 15/32] media: Kconfig: add HAS_IOPORT dependencies
Date:   Mon, 27 Dec 2021 17:43:00 +0100
Message-Id: <20211227164317.4146918-16-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227164317.4146918-1-schnelle@linux.ibm.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Eaoc6zXrPajXTw6xLX3SK7J7gmDING9G
X-Proofpoint-GUID: Ta-94pXtMtk1Eum1Odl_LpGrOr6297nE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-27_08,2021-12-24_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112270080
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
 drivers/media/radio/Kconfig | 13 +++++++++++++
 drivers/media/rc/Kconfig    |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/media/radio/Kconfig b/drivers/media/radio/Kconfig
index 32eb73993998..044590b58212 100644
--- a/drivers/media/radio/Kconfig
+++ b/drivers/media/radio/Kconfig
@@ -233,6 +233,7 @@ source "drivers/media/radio/wl128x/Kconfig"
 menuconfig V4L_RADIO_ISA_DRIVERS
 	bool "ISA radio devices"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	help
 	  Say Y here to enable support for these ISA drivers.
 
@@ -240,11 +241,13 @@ if V4L_RADIO_ISA_DRIVERS
 
 config RADIO_ISA
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	tristate
 
 config RADIO_CADET
 	tristate "ADS Cadet AM/FM Tuner"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	depends on VIDEO_V4L2
 	help
 	  Choose Y here if you have one of these AM/FM radio cards, and then
@@ -256,6 +259,7 @@ config RADIO_CADET
 config RADIO_RTRACK
 	tristate "AIMSlab RadioTrack (aka RadioReveal) support"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	depends on VIDEO_V4L2
 	select RADIO_ISA
 	help
@@ -288,6 +292,7 @@ config RADIO_RTRACK_PORT
 config RADIO_RTRACK2
 	tristate "AIMSlab RadioTrack II support"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	depends on VIDEO_V4L2
 	select RADIO_ISA
 	help
@@ -312,6 +317,7 @@ config RADIO_RTRACK2_PORT
 config RADIO_AZTECH
 	tristate "Aztech/Packard Bell Radio"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	depends on VIDEO_V4L2
 	select RADIO_ISA
 	help
@@ -333,6 +339,7 @@ config RADIO_AZTECH_PORT
 config RADIO_GEMTEK
 	tristate "GemTek Radio card (or compatible) support"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	depends on VIDEO_V4L2
 	select RADIO_ISA
 	help
@@ -389,6 +396,7 @@ config RADIO_MIROPCM20
 config RADIO_SF16FMI
 	tristate "SF16-FMI/SF16-FMP/SF16-FMD Radio"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	depends on VIDEO_V4L2
 	help
 	  Choose Y here if you have one of these FM radio cards.
@@ -399,6 +407,7 @@ config RADIO_SF16FMI
 config RADIO_SF16FMR2
 	tristate "SF16-FMR2/SF16-FMD2 Radio"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	depends on VIDEO_V4L2
 	select RADIO_TEA575X
 	help
@@ -410,6 +419,7 @@ config RADIO_SF16FMR2
 config RADIO_TERRATEC
 	tristate "TerraTec ActiveRadio ISA Standalone"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	depends on VIDEO_V4L2
 	select RADIO_ISA
 	help
@@ -425,6 +435,7 @@ config RADIO_TERRATEC
 config RADIO_TRUST
 	tristate "Trust FM radio card"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	depends on VIDEO_V4L2
 	select RADIO_ISA
 	help
@@ -449,6 +460,7 @@ config RADIO_TRUST_PORT
 config RADIO_TYPHOON
 	tristate "Typhoon Radio (a.k.a. EcoRadio)"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	depends on VIDEO_V4L2
 	select RADIO_ISA
 	help
@@ -484,6 +496,7 @@ config RADIO_TYPHOON_MUTEFREQ
 config RADIO_ZOLTRIX
 	tristate "Zoltrix Radio"
 	depends on ISA || COMPILE_TEST
+	depends on HAS_IOPORT
 	depends on VIDEO_V4L2
 	select RADIO_ISA
 	help
diff --git a/drivers/media/rc/Kconfig b/drivers/media/rc/Kconfig
index 9506baf3c4c1..d0947296f935 100644
--- a/drivers/media/rc/Kconfig
+++ b/drivers/media/rc/Kconfig
@@ -163,6 +163,7 @@ config RC_ATI_REMOTE
 config IR_ENE
 	tristate "ENE eHome Receiver/Transceiver (pnp id: ENE0100/ENE02xxx)"
 	depends on PNP || COMPILE_TEST
+	depends on HAS_IOPORT
 	help
 	   Say Y here to enable support for integrated infrared receiver
 	   /transceiver made by ENE.
@@ -216,6 +217,7 @@ config IR_MCEUSB
 config IR_ITE_CIR
 	tristate "ITE Tech Inc. IT8712/IT8512 Consumer Infrared Transceiver"
 	depends on PNP || COMPILE_TEST
+	depends on HAS_IOPORT
 	help
 	   Say Y here to enable support for integrated infrared receivers
 	   /transceivers made by ITE Tech Inc. These are found in
@@ -228,6 +230,7 @@ config IR_ITE_CIR
 config IR_FINTEK
 	tristate "Fintek Consumer Infrared Transceiver"
 	depends on PNP || COMPILE_TEST
+	depends on HAS_IOPORT
 	help
 	   Say Y here to enable support for integrated infrared receiver
 	   /transceiver made by Fintek. This chip is found on assorted
@@ -269,6 +272,7 @@ config IR_MTK
 config IR_NUVOTON
 	tristate "Nuvoton w836x7hg Consumer Infrared Transceiver"
 	depends on PNP || COMPILE_TEST
+	depends on HAS_IOPORT
 	help
 	   Say Y here to enable support for integrated infrared receiver
 	   /transceiver made by Nuvoton (formerly Winbond). This chip is
@@ -312,6 +316,7 @@ config IR_STREAMZAP
 config IR_WINBOND_CIR
 	tristate "Winbond IR remote control"
 	depends on (X86 && PNP) || COMPILE_TEST
+	depends on HAS_IOPORT
 	select NEW_LEDS
 	select LEDS_CLASS
 	select BITREVERSE
@@ -440,6 +445,7 @@ config IR_SUNXI
 
 config IR_SERIAL
 	tristate "Homebrew Serial Port Receiver"
+	depends on HAS_IOPORT
 	help
 	   Say Y if you want to use Homebrew Serial Port Receivers and
 	   Transceivers.
-- 
2.32.0

