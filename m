Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E2B70BA74
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 12:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjEVKvW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 06:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjEVKvS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 06:51:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B748CE9;
        Mon, 22 May 2023 03:51:16 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M9qQsF011213;
        Mon, 22 May 2023 10:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LCZpttFP7it/oKXC6KsxjpMD0Hpk7HAwgjpPku0EOAg=;
 b=n1FRBpFXg634PXpiSSSVkWhg7+u9jfZRG8m7rC97PvmY61chuGQlXOeA9a0JX8JlHXSz
 wXUFslc7U4WBgBUzmYAda3Y0j0ef+1rcCr6kD9qgbNO9ZcGcD09RijExD5cuYluEL5qi
 +nVi0bUAPqdUvSPZIDXXrPWDl1b+eESaUSG7ZEvAcOFIaOTRLCc0771butKiExXb+TG+
 bACmFNxN6ZU8+qMcY8yLE5eAyGaBF6aac25QJNDruAqJ1/8rCnqBCLVrcXkbkOmCttEQ
 09fdkZKGlze7klvm3vjPg8qNnU2S972pp1kpbhkcg1KJm65P69wmsks7mqT4nTM9QIFu qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qq78bh2d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:01 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MAlNtk016977;
        Mon, 22 May 2023 10:51:00 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qq78bh2cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:00 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34M2nk1X024768;
        Mon, 22 May 2023 10:50:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qppc3gw7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:50:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34MAotcD18875078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 10:50:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3814C2004D;
        Mon, 22 May 2023 10:50:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF2EE20040;
        Mon, 22 May 2023 10:50:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 22 May 2023 10:50:54 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
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
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v5 06/44] comedi: add HAS_IOPORT dependencies
Date:   Mon, 22 May 2023 12:50:11 +0200
Message-Id: <20230522105049.1467313-7-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522105049.1467313-1-schnelle@linux.ibm.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JUixpXUYldhlslxcmq3M4rI78MXrjLSs
X-Proofpoint-GUID: LsMbRNMWy-61CaR42Cnkj21K8_tvxP3N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_06,2023-05-22_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=908 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220089
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
 drivers/comedi/Kconfig | 103 +++++++++++++++++++++++++++--------------
 1 file changed, 68 insertions(+), 35 deletions(-)

diff --git a/drivers/comedi/Kconfig b/drivers/comedi/Kconfig
index 9af280735cba..7a8d402f05be 100644
--- a/drivers/comedi/Kconfig
+++ b/drivers/comedi/Kconfig
@@ -67,6 +67,7 @@ config COMEDI_TEST
 
 config COMEDI_PARPORT
 	tristate "Parallel port support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for the standard parallel port.
 	  A cheap and easy way to get a few more digital I/O lines. Steal
@@ -79,6 +80,7 @@ config COMEDI_PARPORT
 config COMEDI_SSV_DNP
 	tristate "SSV Embedded Systems DIL/Net-PC support"
 	depends on X86_32 || COMPILE_TEST
+	depends on HAS_IOPORT
 	help
 	  Enable support for SSV Embedded Systems DIL/Net-PC
 
@@ -89,6 +91,7 @@ endif # COMEDI_MISC_DRIVERS
 
 menuconfig COMEDI_ISA_DRIVERS
 	bool "Comedi ISA and PC/104 drivers"
+	depends on ISA
 	help
 	  Enable comedi ISA and PC/104 drivers to be built
 
@@ -100,7 +103,8 @@ if COMEDI_ISA_DRIVERS
 
 config COMEDI_PCL711
 	tristate "Advantech PCL-711/711b and ADlink ACL-8112 ISA card support"
-	select COMEDI_8254
+	depends on HAS_IOPORT
+	depends on COMEDI_8254
 	help
 	  Enable support for Advantech PCL-711 and 711b, ADlink ACL-8112
 
@@ -161,8 +165,9 @@ config COMEDI_PCL730
 
 config COMEDI_PCL812
 	tristate "Advantech PCL-812/813 and ADlink ACL-8112/8113/8113/8216"
+	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
-	select COMEDI_8254
+	depends on COMEDI_8254
 	help
 	  Enable support for Advantech PCL-812/PG, PCL-813/B, ADLink
 	  ACL-8112DG/HG/PG, ACL-8113, ACL-8216, ICP DAS A-821PGH/PGL/PGL-NDA,
@@ -173,8 +178,9 @@ config COMEDI_PCL812
 
 config COMEDI_PCL816
 	tristate "Advantech PCL-814 and PCL-816 ISA card support"
+	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
-	select COMEDI_8254
+	depends on COMEDI_8254
 	help
 	  Enable support for Advantech PCL-814 and PCL-816 ISA cards
 
@@ -183,8 +189,9 @@ config COMEDI_PCL816
 
 config COMEDI_PCL818
 	tristate "Advantech PCL-718 and PCL-818 ISA card support"
+	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
-	select COMEDI_8254
+	depends on COMEDI_8254
 	help
 	  Enable support for Advantech PCL-818 ISA cards
 	  PCL-818L, PCL-818H, PCL-818HD, PCL-818HG, PCL-818 and PCL-718
@@ -203,7 +210,7 @@ config COMEDI_PCM3724
 
 config COMEDI_AMPLC_DIO200_ISA
 	tristate "Amplicon PC212E/PC214E/PC215E/PC218E/PC272E"
-	select COMEDI_AMPLC_DIO200
+	depends on COMEDI_AMPLC_DIO200
 	help
 	  Enable support for Amplicon PC212E, PC214E, PC215E, PC218E and
 	  PC272E ISA DIO boards
@@ -255,7 +262,8 @@ config COMEDI_DAC02
 
 config COMEDI_DAS16M1
 	tristate "MeasurementComputing CIO-DAS16/M1DAS-16 ISA card support"
-	select COMEDI_8254
+	depends on HAS_IOPORT
+	depends on COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for Measurement Computing CIO-DAS16/M1 ISA cards.
@@ -265,7 +273,7 @@ config COMEDI_DAS16M1
 
 config COMEDI_DAS08_ISA
 	tristate "DAS-08 compatible ISA and PC/104 card support"
-	select COMEDI_DAS08
+	depends on COMEDI_DAS08
 	help
 	  Enable support for Keithley Metrabyte/ComputerBoards DAS08
 	  and compatible ISA and PC/104 cards:
@@ -278,8 +286,9 @@ config COMEDI_DAS08_ISA
 
 config COMEDI_DAS16
 	tristate "DAS-16 compatible ISA and PC/104 card support"
+	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
-	select COMEDI_8254
+	depends on COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for Keithley Metrabyte/ComputerBoards DAS16
@@ -296,7 +305,8 @@ config COMEDI_DAS16
 
 config COMEDI_DAS800
 	tristate "DAS800 and compatible ISA card support"
-	select COMEDI_8254
+	depends on HAS_IOPORT
+	depends on COMEDI_8254
 	help
 	  Enable support for Keithley Metrabyte DAS800 and compatible ISA cards
 	  Keithley Metrabyte DAS-800, DAS-801, DAS-802
@@ -308,8 +318,9 @@ config COMEDI_DAS800
 
 config COMEDI_DAS1800
 	tristate "DAS1800 and compatible ISA card support"
+	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
-	select COMEDI_8254
+	depends on COMEDI_8254
 	help
 	  Enable support for DAS1800 and compatible ISA cards
 	  Keithley Metrabyte DAS-1701ST, DAS-1701ST-DA, DAS-1701/AO,
@@ -323,7 +334,8 @@ config COMEDI_DAS1800
 
 config COMEDI_DAS6402
 	tristate "DAS6402 and compatible ISA card support"
-	select COMEDI_8254
+	depends on HAS_IOPORT
+	depends on COMEDI_8254
 	help
 	  Enable support for DAS6402 and compatible ISA cards
 	  Computerboards, Keithley Metrabyte DAS6402 and compatibles
@@ -402,7 +414,8 @@ config COMEDI_FL512
 
 config COMEDI_AIO_AIO12_8
 	tristate "I/O Products PC/104 AIO12-8 Analog I/O Board support"
-	select COMEDI_8254
+	depends on HAS_IOPORT
+	depends on COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for I/O Products PC/104 AIO12-8 Analog I/O Board
@@ -456,8 +469,9 @@ config COMEDI_ADQ12B
 
 config COMEDI_NI_AT_A2150
 	tristate "NI AT-A2150 ISA card support"
+	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
-	select COMEDI_8254
+	depends on COMEDI_8254
 	help
 	  Enable support for National Instruments AT-A2150 cards
 
@@ -466,7 +480,8 @@ config COMEDI_NI_AT_A2150
 
 config COMEDI_NI_AT_AO
 	tristate "NI AT-AO-6/10 EISA card support"
-	select COMEDI_8254
+	depends on HAS_IOPORT
+	depends on COMEDI_8254
 	help
 	  Enable support for National Instruments AT-AO-6/10 cards
 
@@ -497,7 +512,7 @@ config COMEDI_NI_ATMIO16D
 
 config COMEDI_NI_LABPC_ISA
 	tristate "NI Lab-PC and compatibles ISA support"
-	select COMEDI_NI_LABPC
+	depends on COMEDI_NI_LABPC
 	help
 	  Enable support for National Instruments Lab-PC and compatibles
 	  Lab-PC-1200, Lab-PC-1200AI, Lab-PC+.
@@ -561,7 +576,7 @@ endif # COMEDI_ISA_DRIVERS
 
 menuconfig COMEDI_PCI_DRIVERS
 	tristate "Comedi PCI drivers"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  Enable support for comedi PCI drivers.
 
@@ -710,7 +725,8 @@ config COMEDI_ADL_PCI8164
 
 config COMEDI_ADL_PCI9111
 	tristate "ADLink PCI-9111HR support"
-	select COMEDI_8254
+	depends on HAS_IOPORT
+	depends on COMEDI_8254
 	help
 	  Enable support for ADlink PCI9111 cards
 
@@ -720,7 +736,7 @@ config COMEDI_ADL_PCI9111
 config COMEDI_ADL_PCI9118
 	tristate "ADLink PCI-9118DG, PCI-9118HG, PCI-9118HR support"
 	depends on HAS_DMA
-	select COMEDI_8254
+	depends on COMEDI_8254
 	help
 	  Enable support for ADlink PCI-9118DG, PCI-9118HG, PCI-9118HR cards
 
@@ -729,7 +745,8 @@ config COMEDI_ADL_PCI9118
 
 config COMEDI_ADV_PCI1710
 	tristate "Advantech PCI-171x and PCI-1731 support"
-	select COMEDI_8254
+	depends on HAS_IOPORT
+	depends on COMEDI_8254
 	help
 	  Enable support for Advantech PCI-1710, PCI-1710HG, PCI-1711,
 	  PCI-1713 and PCI-1731
@@ -773,7 +790,8 @@ config COMEDI_ADV_PCI1760
 
 config COMEDI_ADV_PCI_DIO
 	tristate "Advantech PCI DIO card support"
-	select COMEDI_8254
+	depends on HAS_IOPORT
+	depends on COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for Advantech PCI DIO cards
@@ -786,7 +804,7 @@ config COMEDI_ADV_PCI_DIO
 
 config COMEDI_AMPLC_DIO200_PCI
 	tristate "Amplicon PCI215/PCI272/PCIe215/PCIe236/PCIe296 DIO support"
-	select COMEDI_AMPLC_DIO200
+	depends on COMEDI_AMPLC_DIO200
 	help
 	  Enable support for Amplicon PCI215, PCI272, PCIe215, PCIe236
 	  and PCIe296 DIO boards.
@@ -814,7 +832,8 @@ config COMEDI_AMPLC_PC263_PCI
 
 config COMEDI_AMPLC_PCI224
 	tristate "Amplicon PCI224 and PCI234 support"
-	select COMEDI_8254
+	depends on HAS_IOPORT
+	depends on COMEDI_8254
 	help
 	  Enable support for Amplicon PCI224 and PCI234 AO boards
 
@@ -823,7 +842,8 @@ config COMEDI_AMPLC_PCI224
 
 config COMEDI_AMPLC_PCI230
 	tristate "Amplicon PCI230 and PCI260 support"
-	select COMEDI_8254
+	depends on HAS_IOPORT
+	depends on COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for Amplicon PCI230 and PCI260 Multifunction I/O
@@ -842,7 +862,7 @@ config COMEDI_CONTEC_PCI_DIO
 
 config COMEDI_DAS08_PCI
 	tristate "DAS-08 PCI support"
-	select COMEDI_DAS08
+	depends on COMEDI_DAS08
 	help
 	  Enable support for PCI DAS-08 cards.
 
@@ -929,7 +949,8 @@ config COMEDI_CB_PCIDAS64
 
 config COMEDI_CB_PCIDAS
 	tristate "MeasurementComputing PCI-DAS support"
-	select COMEDI_8254
+	depends on HAS_IOPORT
+	depends on COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for ComputerBoards/MeasurementComputing PCI-DAS with
@@ -953,7 +974,8 @@ config COMEDI_CB_PCIDDA
 
 config COMEDI_CB_PCIMDAS
 	tristate "MeasurementComputing PCIM-DAS1602/16, PCIe-DAS1602/16 support"
-	select COMEDI_8254
+	depends on HAS_IOPORT
+	depends on COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for ComputerBoards/MeasurementComputing PCI Migration
@@ -973,7 +995,8 @@ config COMEDI_CB_PCIMDDA
 
 config COMEDI_ME4000
 	tristate "Meilhaus ME-4000 support"
-	select COMEDI_8254
+	depends on HAS_IOPORT
+	depends on COMEDI_8254
 	help
 	  Enable support for Meilhaus PCI data acquisition cards
 	  ME-4650, ME-4670i, ME-4680, ME-4680i and ME-4680is
@@ -1031,7 +1054,7 @@ config COMEDI_NI_670X
 
 config COMEDI_NI_LABPC_PCI
 	tristate "NI Lab-PC PCI-1200 support"
-	select COMEDI_NI_LABPC
+	depends on COMEDI_NI_LABPC
 	help
 	  Enable support for National Instruments Lab-PC PCI-1200.
 
@@ -1053,6 +1076,7 @@ config COMEDI_NI_PCIDIO
 config COMEDI_NI_PCIMIO
 	tristate "NI PCI-MIO-E series and M series support"
 	depends on HAS_DMA
+	depends on HAS_IOPORT
 	select COMEDI_NI_TIOCMD
 	select COMEDI_8255
 	help
@@ -1074,7 +1098,8 @@ config COMEDI_NI_PCIMIO
 
 config COMEDI_RTD520
 	tristate "Real Time Devices PCI4520/DM7520 support"
-	select COMEDI_8254
+	depends on HAS_IOPORT
+	depends on COMEDI_8254
 	help
 	  Enable support for Real Time Devices PCI4520/DM7520
 
@@ -1114,7 +1139,8 @@ if COMEDI_PCMCIA_DRIVERS
 
 config COMEDI_CB_DAS16_CS
 	tristate "CB DAS16 series PCMCIA support"
-	select COMEDI_8254
+	depends on HAS_IOPORT
+	depends on COMEDI_8254
 	help
 	  Enable support for the ComputerBoards/MeasurementComputing PCMCIA
 	  cards DAS16/16, PCM-DAS16D/12 and PCM-DAS16s/16
@@ -1124,7 +1150,7 @@ config COMEDI_CB_DAS16_CS
 
 config COMEDI_DAS08_CS
 	tristate "CB DAS08 PCMCIA support"
-	select COMEDI_DAS08
+	depends on COMEDI_DAS08
 	help
 	  Enable support for the ComputerBoards/MeasurementComputing DAS-08
 	  PCMCIA card
@@ -1134,6 +1160,7 @@ config COMEDI_DAS08_CS
 
 config COMEDI_NI_DAQ_700_CS
 	tristate "NI DAQCard-700 PCMCIA support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for the National Instruments PCMCIA DAQCard-700 DIO
 
@@ -1142,6 +1169,7 @@ config COMEDI_NI_DAQ_700_CS
 
 config COMEDI_NI_DAQ_DIO24_CS
 	tristate "NI DAQ-Card DIO-24 PCMCIA support"
+	depends on HAS_IOPORT
 	select COMEDI_8255
 	help
 	  Enable support for the National Instruments PCMCIA DAQ-Card DIO-24
@@ -1151,7 +1179,7 @@ config COMEDI_NI_DAQ_DIO24_CS
 
 config COMEDI_NI_LABPC_CS
 	tristate "NI DAQCard-1200 PCMCIA support"
-	select COMEDI_NI_LABPC
+	depends on COMEDI_NI_LABPC
 	help
 	  Enable support for the National Instruments PCMCIA DAQCard-1200
 
@@ -1160,6 +1188,7 @@ config COMEDI_NI_LABPC_CS
 
 config COMEDI_NI_MIO_CS
 	tristate "NI DAQCard E series PCMCIA support"
+	depends on HAS_IOPORT
 	select COMEDI_NI_TIO
 	select COMEDI_8255
 	help
@@ -1172,6 +1201,7 @@ config COMEDI_NI_MIO_CS
 
 config COMEDI_QUATECH_DAQP_CS
 	tristate "Quatech DAQP PCMCIA data capture card support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for the Quatech DAQP PCMCIA data capture cards
 	  DAQP-208 and DAQP-308
@@ -1248,12 +1278,14 @@ endif # COMEDI_USB_DRIVERS
 
 config COMEDI_8254
 	tristate
+	depends on HAS_IOPORT
 
 config COMEDI_8255
 	tristate
 
 config COMEDI_8255_SA
 	tristate "Standalone 8255 support"
+	depends on HAS_IOPORT
 	select COMEDI_8255
 	help
 	  Enable support for 8255 digital I/O as a standalone driver.
@@ -1285,7 +1317,7 @@ config COMEDI_KCOMEDILIB
 	  called kcomedilib.
 
 config COMEDI_AMPLC_DIO200
-	select COMEDI_8254
+	depends on COMEDI_8254
 	tristate
 
 config COMEDI_AMPLC_PC236
@@ -1294,7 +1326,7 @@ config COMEDI_AMPLC_PC236
 
 config COMEDI_DAS08
 	tristate
-	select COMEDI_8254
+	depends on COMEDI_8254
 	select COMEDI_8255
 
 config COMEDI_ISADMA
@@ -1302,7 +1334,8 @@ config COMEDI_ISADMA
 
 config COMEDI_NI_LABPC
 	tristate
-	select COMEDI_8254
+	depends on HAS_IOPORT
+	depends on COMEDI_8254
 	select COMEDI_8255
 
 config COMEDI_NI_LABPC_ISADMA
-- 
2.39.2

