Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61752514B23
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376437AbiD2Nyu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376417AbiD2Nyo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:54:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE8D58E5F;
        Fri, 29 Apr 2022 06:51:26 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TC2oir027249;
        Fri, 29 Apr 2022 13:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hDBTp+Ab95rlAvb6PsAe9ILbxoMftiNA4Vpzb9S7p2Y=;
 b=V1JJobhqei29qT5CEzv2Oxh/XG3dJVdFEp8f4kBGtq0GEqlMPbpkl0pRcy35UtFYN7fU
 hDn9SrC0HwGXt4GAZlJ1OzCdVFYqx9UVG304B8diVgnJPpMbacZUeF1Pn92NR2djWNw1
 PsY4JvOb6NjuDIy1Q8opxPpNxrw4JD66V+xryYKD/qDPaG57yc372uq5Kt/lt8zf5Zst
 piNejZWw8EBO+eSml8hFBJWtwSN2vxdIVJ5Fk2IZkzWhoYqfp13SI+t86h3j01RebA3Y
 d3F2xtEA1eOpLrTv26zwUGz7MqB67h3RjAFfn9Aiepn5ZaBAaLchq0PPfV+OtVgGR1VI 0g== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqundujh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:20 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDRlrs027470;
        Fri, 29 Apr 2022 13:51:18 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3fm938yamu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:18 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpFKs56230220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD0784C046;
        Fri, 29 Apr 2022 13:51:15 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DA5D4C040;
        Fri, 29 Apr 2022 13:51:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:15 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [RFC v2 05/39] comedi: add HAS_IOPORT dependencies
Date:   Fri, 29 Apr 2022 15:50:07 +0200
Message-Id: <20220429135108.2781579-10-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pW81BaaedF7Rl8gPDpV9C93zD6qEfvv1
X-Proofpoint-GUID: pW81BaaedF7Rl8gPDpV9C93zD6qEfvv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 mlxlogscore=547 impostorscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
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
 drivers/comedi/Kconfig | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/comedi/Kconfig b/drivers/comedi/Kconfig
index 3cb61fa2c5c3..e2f6b34315b2 100644
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
 
@@ -100,6 +103,7 @@ if COMEDI_ISA_DRIVERS
 
 config COMEDI_PCL711
 	tristate "Advantech PCL-711/711b and ADlink ACL-8112 ISA card support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	help
 	  Enable support for Advantech PCL-711 and 711b, ADlink ACL-8112
@@ -161,6 +165,7 @@ config COMEDI_PCL730
 
 config COMEDI_PCL812
 	tristate "Advantech PCL-812/813 and ADlink ACL-8112/8113/8113/8216"
+	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
 	select COMEDI_8254
 	help
@@ -173,6 +178,7 @@ config COMEDI_PCL812
 
 config COMEDI_PCL816
 	tristate "Advantech PCL-814 and PCL-816 ISA card support"
+	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
 	select COMEDI_8254
 	help
@@ -183,6 +189,7 @@ config COMEDI_PCL816
 
 config COMEDI_PCL818
 	tristate "Advantech PCL-718 and PCL-818 ISA card support"
+	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
 	select COMEDI_8254
 	help
@@ -255,6 +262,7 @@ config COMEDI_DAC02
 
 config COMEDI_DAS16M1
 	tristate "MeasurementComputing CIO-DAS16/M1DAS-16 ISA card support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	select COMEDI_8255
 	help
@@ -278,6 +286,7 @@ config COMEDI_DAS08_ISA
 
 config COMEDI_DAS16
 	tristate "DAS-16 compatible ISA and PC/104 card support"
+	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
 	select COMEDI_8254
 	select COMEDI_8255
@@ -296,6 +305,7 @@ config COMEDI_DAS16
 
 config COMEDI_DAS800
 	tristate "DAS800 and compatible ISA card support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	help
 	  Enable support for Keithley Metrabyte DAS800 and compatible ISA cards
@@ -308,6 +318,7 @@ config COMEDI_DAS800
 
 config COMEDI_DAS1800
 	tristate "DAS1800 and compatible ISA card support"
+	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
 	select COMEDI_8254
 	help
@@ -323,6 +334,7 @@ config COMEDI_DAS1800
 
 config COMEDI_DAS6402
 	tristate "DAS6402 and compatible ISA card support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	help
 	  Enable support for DAS6402 and compatible ISA cards
@@ -402,6 +414,7 @@ config COMEDI_FL512
 
 config COMEDI_AIO_AIO12_8
 	tristate "I/O Products PC/104 AIO12-8 Analog I/O Board support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	select COMEDI_8255
 	help
@@ -456,6 +469,7 @@ config COMEDI_ADQ12B
 
 config COMEDI_NI_AT_A2150
 	tristate "NI AT-A2150 ISA card support"
+	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
 	select COMEDI_8254
 	help
@@ -466,6 +480,7 @@ config COMEDI_NI_AT_A2150
 
 config COMEDI_NI_AT_AO
 	tristate "NI AT-AO-6/10 EISA card support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	help
 	  Enable support for National Instruments AT-AO-6/10 cards
@@ -561,7 +576,7 @@ endif # COMEDI_ISA_DRIVERS
 
 menuconfig COMEDI_PCI_DRIVERS
 	tristate "Comedi PCI drivers"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  Enable support for comedi PCI drivers.
 
@@ -710,6 +725,7 @@ config COMEDI_ADL_PCI8164
 
 config COMEDI_ADL_PCI9111
 	tristate "ADLink PCI-9111HR support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	help
 	  Enable support for ADlink PCI9111 cards
@@ -729,6 +745,7 @@ config COMEDI_ADL_PCI9118
 
 config COMEDI_ADV_PCI1710
 	tristate "Advantech PCI-171x and PCI-1731 support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	help
 	  Enable support for Advantech PCI-1710, PCI-1710HG, PCI-1711,
@@ -773,6 +790,7 @@ config COMEDI_ADV_PCI1760
 
 config COMEDI_ADV_PCI_DIO
 	tristate "Advantech PCI DIO card support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	select COMEDI_8255
 	help
@@ -814,6 +832,7 @@ config COMEDI_AMPLC_PC263_PCI
 
 config COMEDI_AMPLC_PCI224
 	tristate "Amplicon PCI224 and PCI234 support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	help
 	  Enable support for Amplicon PCI224 and PCI234 AO boards
@@ -823,6 +842,7 @@ config COMEDI_AMPLC_PCI224
 
 config COMEDI_AMPLC_PCI230
 	tristate "Amplicon PCI230 and PCI260 support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	select COMEDI_8255
 	help
@@ -929,6 +949,7 @@ config COMEDI_CB_PCIDAS64
 
 config COMEDI_CB_PCIDAS
 	tristate "MeasurementComputing PCI-DAS support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	select COMEDI_8255
 	help
@@ -953,6 +974,7 @@ config COMEDI_CB_PCIDDA
 
 config COMEDI_CB_PCIMDAS
 	tristate "MeasurementComputing PCIM-DAS1602/16, PCIe-DAS1602/16 support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	select COMEDI_8255
 	help
@@ -973,6 +995,7 @@ config COMEDI_CB_PCIMDDA
 
 config COMEDI_ME4000
 	tristate "Meilhaus ME-4000 support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	help
 	  Enable support for Meilhaus PCI data acquisition cards
@@ -1053,6 +1076,7 @@ config COMEDI_NI_PCIDIO
 config COMEDI_NI_PCIMIO
 	tristate "NI PCI-MIO-E series and M series support"
 	depends on HAS_DMA
+	depends on HAS_IOPORT
 	select COMEDI_NI_TIOCMD
 	select COMEDI_8255
 	help
@@ -1074,6 +1098,7 @@ config COMEDI_NI_PCIMIO
 
 config COMEDI_RTD520
 	tristate "Real Time Devices PCI4520/DM7520 support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	help
 	  Enable support for Real Time Devices PCI4520/DM7520
@@ -1114,6 +1139,7 @@ if COMEDI_PCMCIA_DRIVERS
 
 config COMEDI_CB_DAS16_CS
 	tristate "CB DAS16 series PCMCIA support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	help
 	  Enable support for the ComputerBoards/MeasurementComputing PCMCIA
@@ -1142,6 +1168,7 @@ config COMEDI_NI_DAQ_700_CS
 
 config COMEDI_NI_DAQ_DIO24_CS
 	tristate "NI DAQ-Card DIO-24 PCMCIA support"
+	depends on HAS_IOPORT
 	select COMEDI_8255
 	help
 	  Enable support for the National Instruments PCMCIA DAQ-Card DIO-24
@@ -1160,6 +1187,7 @@ config COMEDI_NI_LABPC_CS
 
 config COMEDI_NI_MIO_CS
 	tristate "NI DAQCard E series PCMCIA support"
+	depends on HAS_IOPORT
 	select COMEDI_NI_TIO
 	select COMEDI_8255
 	help
@@ -1248,12 +1276,14 @@ endif # COMEDI_USB_DRIVERS
 
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
@@ -1302,6 +1332,7 @@ config COMEDI_ISADMA
 
 config COMEDI_NI_LABPC
 	tristate
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	select COMEDI_8255
 
-- 
2.32.0

