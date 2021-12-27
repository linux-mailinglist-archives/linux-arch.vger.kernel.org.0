Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828324801C6
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 17:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhL0QoE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 11:44:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229899AbhL0QoD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Dec 2021 11:44:03 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGfm2s012012;
        Mon, 27 Dec 2021 16:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hN+nhjuXk+cDPR/e2s2Uapzl/xnnujFVcliKK2YvUKQ=;
 b=Trh+i4FVqhNNYrsDCaoUyc34/uUXJBHSDnDSIcy+5S5yAT+rQSevXsESG+0dOVDWUrb4
 yhZ35DKFqSbTnogt6tF9cxMb3lYfsmonh/RIO+fEXw6/yluv1moxmFUMRobmHYg9eM/s
 uU99CGF229fZcjwxBFM2xoUVqIsrLXctNaeNDkjs80V/tLPZcHwzRL7YOGpasRjTrAYs
 tJ2R2thuMUV047FWOM8Q2uKrZwc6SDtMq8Rht36xDcrTDeTo7T//LTxnsqyUqzliynia
 sj7777Y9/ThvPs7qRVhh9dOybwIufVi9jmePJXvlPtTH9gh1+nGjPqkA0RQde1Co2mRY tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d7h7ug0w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:38 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BRGhbRd022283;
        Mon, 27 Dec 2021 16:43:37 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d7h7ug0vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:37 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGgk7j003050;
        Mon, 27 Dec 2021 16:43:36 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3d5tx9bf48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:35 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BRGhXWn37749128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Dec 2021 16:43:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F989A405B;
        Mon, 27 Dec 2021 16:43:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC605A405C;
        Mon, 27 Dec 2021 16:43:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Dec 2021 16:43:32 +0000 (GMT)
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
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org
Subject: [RFC 08/32] comedi: Kconfig: add HAS_IOPORT dependencies
Date:   Mon, 27 Dec 2021 17:42:53 +0100
Message-Id: <20211227164317.4146918-9-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227164317.4146918-1-schnelle@linux.ibm.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TZpfSHJ3JYizsLJwrDsFLrNVUWsWu3kp
X-Proofpoint-ORIG-GUID: wBeUeRtTWDlfhNTWe4PtE9Aen-4hNF3y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-27_08,2021-12-24_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112270080
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
 drivers/comedi/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/comedi/Kconfig b/drivers/comedi/Kconfig
index 1b642716c5d3..f5b8869df781 100644
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
 
@@ -1095,6 +1098,7 @@ config COMEDI_NI_PCIMIO
 	tristate "NI PCI-MIO-E series and M series support"
 	depends on LEGACY_PCI
 	depends on HAS_DMA
+	depends on LEGACY_PCI
 	select COMEDI_NI_TIOCMD
 	select COMEDI_8255
 	help
@@ -1116,6 +1120,7 @@ config COMEDI_NI_PCIMIO
 
 config COMEDI_RTD520
 	tristate "Real Time Devices PCI4520/DM7520 support"
+	depends on LEGACY_PCI
 	select COMEDI_8254
 	help
 	  Enable support for Real Time Devices PCI4520/DM7520
@@ -1184,6 +1189,7 @@ config COMEDI_NI_DAQ_700_CS
 
 config COMEDI_NI_DAQ_DIO24_CS
 	tristate "NI DAQ-Card DIO-24 PCMCIA support"
+	depends on LEGACY_PCI
 	select COMEDI_8255
 	help
 	  Enable support for the National Instruments PCMCIA DAQ-Card DIO-24
@@ -1202,6 +1208,7 @@ config COMEDI_NI_LABPC_CS
 
 config COMEDI_NI_MIO_CS
 	tristate "NI DAQCard E series PCMCIA support"
+	depends on LEGACY_PCI
 	select COMEDI_NI_TIO
 	select COMEDI_8255
 	help
@@ -1296,6 +1303,7 @@ config COMEDI_8255
 
 config COMEDI_8255_SA
 	tristate "Standalone 8255 support"
+	depends on LEGACY_PCI
 	select COMEDI_8255
 	help
 	  Enable support for 8255 digital I/O as a standalone driver.
@@ -1332,10 +1340,12 @@ config COMEDI_AMPLC_DIO200
 
 config COMEDI_AMPLC_PC236
 	tristate
+	depends on HAS_IOPORT
 	select COMEDI_8255
 
 config COMEDI_DAS08
 	tristate
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	select COMEDI_8255
 
@@ -1344,6 +1354,7 @@ config COMEDI_ISADMA
 
 config COMEDI_NI_LABPC
 	tristate
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	select COMEDI_8255
 
-- 
2.32.0

