Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A21670BC3F
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 13:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjEVLu4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 07:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjEVLud (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 07:50:33 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619A799;
        Mon, 22 May 2023 04:50:26 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MAlcMi028821;
        Mon, 22 May 2023 10:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=917PnRVT8vP1wsO6btjKtDfaMRlNQCEz+EQNu2Kh6F8=;
 b=onSDkcGHn7BCEto7khxv+J1wbziOeig45AIAXwLLXpBp4cgWkzr0ifa7Vm22TolhPapP
 nYNTcRQaJoHNz6SBYlKyfsANPG3lwuFLHG/JprrmKl0uYU0QfO4rbcdfq03HByWhELfx
 0VHgXLevFZ059gH2oETCD9Y6EPWq21vmhYjklmYIKHJvSnXfBF76Ybgvud8EEU5JcwhX
 x+pj2w3l6agzAaWR3C8Ilw4O5VWRY4KWpP8ebDtsovkDFaU6rF4ifWGDdK1MjaIQ0RJ6
 1ZHQExrPFkLjY+wt69D+qu6ywJ4Gvtob+61aa/C8WyXtpTZNBAOlqouU8cpxoK1f+Mc8 mA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqfq39rck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:59 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MARDWI021237;
        Mon, 22 May 2023 10:51:58 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqfq39r10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:58 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34M5xB5I007770;
        Mon, 22 May 2023 10:51:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qppcu8wf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34MApIAW17760806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 10:51:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED24E20040;
        Mon, 22 May 2023 10:51:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E4D420043;
        Mon, 22 May 2023 10:51:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 22 May 2023 10:51:17 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com
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
        linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com
Subject: [PATCH v5 31/44] scsi: add HAS_IOPORT dependencies
Date:   Mon, 22 May 2023 12:50:36 +0200
Message-Id: <20230522105049.1467313-32-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522105049.1467313-1-schnelle@linux.ibm.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XENUFwbsOgrO0v-rx39ukbaTzSGZLI-A
X-Proofpoint-GUID: sNSBIT0WJWBOCnsUQzJpu81RYeFMsrqY
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_06,2023-05-22_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220089
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
 drivers/scsi/Kconfig                   | 25 +++++++++++++------------
 drivers/scsi/aic7xxx/Kconfig.aic79xx   |  2 +-
 drivers/scsi/aic7xxx/Kconfig.aic7xxx   |  2 +-
 drivers/scsi/aic94xx/Kconfig           |  2 +-
 drivers/scsi/megaraid/Kconfig.megaraid |  6 +++---
 drivers/scsi/mvsas/Kconfig             |  2 +-
 drivers/scsi/pcmcia/Kconfig            |  6 +++++-
 drivers/scsi/qla2xxx/Kconfig           |  2 +-
 8 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 0704809d9d99..4962ce989113 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -334,7 +334,7 @@ config SGIWD93_SCSI
 
 config BLK_DEV_3W_XXXX_RAID
 	tristate "3ware 5/6/7/8xxx ATA-RAID support"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	help
 	  3ware is the only hardware ATA-Raid product in Linux to date.
 	  This card is 2,4, or 8 channel master mode support only.
@@ -381,7 +381,7 @@ config SCSI_3W_SAS
 
 config SCSI_ACARD
 	tristate "ACARD SCSI support"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	help
 	  This driver supports the ACARD SCSI host adapter.
 	  Support Chip <ATP870 ATP876 ATP880 ATP885>
@@ -462,7 +462,7 @@ config SCSI_MVUMI
 config SCSI_ADVANSYS
 	tristate "AdvanSys SCSI support"
 	depends on SCSI
-	depends on ISA || EISA || PCI
+	depends on (ISA || EISA || PCI) && HAS_IOPORT
 	depends on ISA_DMA_API || !ISA
 	help
 	  This is a driver for all SCSI host adapters manufactured by
@@ -503,7 +503,7 @@ config SCSI_HPTIOP
 
 config SCSI_BUSLOGIC
 	tristate "BusLogic SCSI support"
-	depends on PCI && SCSI
+	depends on SCSI && PCI && HAS_IOPORT
 	help
 	  This is support for BusLogic MultiMaster and FlashPoint SCSI Host
 	  Adapters. Consult the SCSI-HOWTO, available from
@@ -518,7 +518,7 @@ config SCSI_BUSLOGIC
 
 config SCSI_FLASHPOINT
 	bool "FlashPoint support"
-	depends on SCSI_BUSLOGIC && PCI
+	depends on SCSI_BUSLOGIC && PCI && HAS_IOPORT
 	help
 	  This option allows you to add FlashPoint support to the
 	  BusLogic SCSI driver. The FlashPoint SCCB Manager code is
@@ -632,7 +632,7 @@ config SCSI_SNIC_DEBUG_FS
 
 config SCSI_DMX3191D
 	tristate "DMX3191D SCSI support"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	select SCSI_SPI_ATTRS
 	help
 	  This is support for Domex DMX3191D SCSI Host Adapters.
@@ -646,7 +646,7 @@ config SCSI_FDOMAIN
 
 config SCSI_FDOMAIN_PCI
 	tristate "Future Domain TMC-3260/AHA-2920A PCI SCSI support"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	select SCSI_FDOMAIN
 	help
 	  This is support for Future Domain's PCI SCSI host adapters (TMC-3260)
@@ -699,7 +699,7 @@ config SCSI_GENERIC_NCR5380
 
 config SCSI_IPS
 	tristate "IBM ServeRAID support"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	help
 	  This is support for the IBM ServeRAID hardware RAID controllers.
 	  See <http://www.developer.ibm.com/welcome/netfinity/serveraid.html>
@@ -759,7 +759,7 @@ config SCSI_IBMVFC_TRACE
 
 config SCSI_INITIO
 	tristate "Initio 9100U(W) support"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	help
 	  This is support for the Initio 91XXU(W) SCSI host adapter.  Please
 	  read the SCSI-HOWTO, available from
@@ -770,7 +770,7 @@ config SCSI_INITIO
 
 config SCSI_INIA100
 	tristate "Initio INI-A100U2W support"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	help
 	  This is support for the Initio INI-A100U2W SCSI host adapter.
 	  Please read the SCSI-HOWTO, available from
@@ -782,6 +782,7 @@ config SCSI_INIA100
 config SCSI_PPA
 	tristate "IOMEGA parallel port (ppa - older drives)"
 	depends on SCSI && PARPORT_PC
+	depends on HAS_IOPORT
 	help
 	  This driver supports older versions of IOMEGA's parallel port ZIP
 	  drive (a 100 MB removable media device).
@@ -1175,7 +1176,7 @@ config SCSI_SIM710
 
 config SCSI_DC395x
 	tristate "Tekram DC395(U/UW/F) and DC315(U) SCSI support"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	select SCSI_SPI_ATTRS
 	help
 	  This driver supports PCI SCSI host adapters based on the ASIC
@@ -1207,7 +1208,7 @@ config SCSI_AM53C974
 
 config SCSI_NSP32
 	tristate "Workbit NinjaSCSI-32Bi/UDE support"
-	depends on PCI && SCSI && !64BIT
+	depends on PCI && SCSI && !64BIT && HAS_IOPORT
 	help
 	  This is support for the Workbit NinjaSCSI-32Bi/UDE PCI/Cardbus
 	  SCSI host adapter. Please read the SCSI-HOWTO, available from
diff --git a/drivers/scsi/aic7xxx/Kconfig.aic79xx b/drivers/scsi/aic7xxx/Kconfig.aic79xx
index a47dbd500e9a..4bc53eec4c83 100644
--- a/drivers/scsi/aic7xxx/Kconfig.aic79xx
+++ b/drivers/scsi/aic7xxx/Kconfig.aic79xx
@@ -5,7 +5,7 @@
 #
 config SCSI_AIC79XX
 	tristate "Adaptec AIC79xx U320 support"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	select SCSI_SPI_ATTRS
 	help
 	This driver supports all of Adaptec's Ultra 320 PCI-X
diff --git a/drivers/scsi/aic7xxx/Kconfig.aic7xxx b/drivers/scsi/aic7xxx/Kconfig.aic7xxx
index 0cfd92ce750a..f0425145a5f4 100644
--- a/drivers/scsi/aic7xxx/Kconfig.aic7xxx
+++ b/drivers/scsi/aic7xxx/Kconfig.aic7xxx
@@ -5,7 +5,7 @@
 #
 config SCSI_AIC7XXX
 	tristate "Adaptec AIC7xxx Fast -> U160 support"
-	depends on (PCI || EISA) && SCSI
+	depends on (PCI || EISA) && HAS_IOPORT && SCSI
 	select SCSI_SPI_ATTRS
 	help
 	This driver supports all of Adaptec's Fast through Ultra 160 PCI
diff --git a/drivers/scsi/aic94xx/Kconfig b/drivers/scsi/aic94xx/Kconfig
index 71931c371b1c..aaa8dadc6e1c 100644
--- a/drivers/scsi/aic94xx/Kconfig
+++ b/drivers/scsi/aic94xx/Kconfig
@@ -8,7 +8,7 @@
 
 config SCSI_AIC94XX
 	tristate "Adaptec AIC94xx SAS/SATA support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select SCSI_SAS_LIBSAS
 	select FW_LOADER
 	help
diff --git a/drivers/scsi/megaraid/Kconfig.megaraid b/drivers/scsi/megaraid/Kconfig.megaraid
index 2adc2afd9f91..3f2ce1eb081c 100644
--- a/drivers/scsi/megaraid/Kconfig.megaraid
+++ b/drivers/scsi/megaraid/Kconfig.megaraid
@@ -1,13 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config MEGARAID_NEWGEN
 	bool "LSI Logic New Generation RAID Device Drivers"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	help
 	LSI Logic RAID Device Drivers
 
 config MEGARAID_MM
 	tristate "LSI Logic Management Module (New Driver)"
-	depends on PCI && SCSI && MEGARAID_NEWGEN
+	depends on PCI && HAS_IOPORT && SCSI && MEGARAID_NEWGEN
 	help
 	Management Module provides ioctl, sysfs support for LSI Logic
 	RAID controllers.
@@ -67,7 +67,7 @@ config MEGARAID_MAILBOX
 
 config MEGARAID_LEGACY
 	tristate "LSI Logic Legacy MegaRAID Driver"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	help
 	This driver supports the LSI MegaRAID 418, 428, 438, 466, 762, 490
 	and 467 SCSI host adapters. This driver also support the all U320
diff --git a/drivers/scsi/mvsas/Kconfig b/drivers/scsi/mvsas/Kconfig
index 79812b80743b..5ac7fd593b17 100644
--- a/drivers/scsi/mvsas/Kconfig
+++ b/drivers/scsi/mvsas/Kconfig
@@ -9,7 +9,7 @@
 
 config SCSI_MVSAS
 	tristate "Marvell 88SE64XX/88SE94XX SAS/SATA support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select SCSI_SAS_LIBSAS
 	select FW_LOADER
 	help
diff --git a/drivers/scsi/pcmcia/Kconfig b/drivers/scsi/pcmcia/Kconfig
index 9696b6b5591f..449bd85db7bb 100644
--- a/drivers/scsi/pcmcia/Kconfig
+++ b/drivers/scsi/pcmcia/Kconfig
@@ -12,6 +12,7 @@ if SCSI_LOWLEVEL_PCMCIA && SCSI && PCMCIA && m
 
 config PCMCIA_AHA152X
 	tristate "Adaptec AHA152X PCMCIA support"
+	depends on HAS_IOPORT
 	select SCSI_SPI_ATTRS
 	help
 	  Say Y here if you intend to attach this type of PCMCIA SCSI host
@@ -22,6 +23,7 @@ config PCMCIA_AHA152X
 
 config PCMCIA_FDOMAIN
 	tristate "Future Domain PCMCIA support"
+	depends on HAS_IOPORT
 	select SCSI_FDOMAIN
 	help
 	  Say Y here if you intend to attach this type of PCMCIA SCSI host
@@ -32,7 +34,7 @@ config PCMCIA_FDOMAIN
 
 config PCMCIA_NINJA_SCSI
 	tristate "NinjaSCSI-3 / NinjaSCSI-32Bi (16bit) PCMCIA support"
-	depends on !64BIT || COMPILE_TEST
+	depends on (!64BIT || COMPILE_TEST) && HAS_IOPORT
 	help
 	  If you intend to attach this type of PCMCIA SCSI host adapter to
 	  your computer, say Y here and read
@@ -66,6 +68,7 @@ config PCMCIA_NINJA_SCSI
 
 config PCMCIA_QLOGIC
 	tristate "Qlogic PCMCIA support"
+	depends on HAS_IOPORT
 	help
 	  Say Y here if you intend to attach this type of PCMCIA SCSI host
 	  adapter to your computer.
@@ -75,6 +78,7 @@ config PCMCIA_QLOGIC
 
 config PCMCIA_SYM53C500
 	tristate "Symbios 53c500 PCMCIA support"
+	depends on HAS_IOPORT
 	help
 	  Say Y here if you have a New Media Bus Toaster or other PCMCIA
 	  SCSI adapter based on the Symbios 53c500 controller.
diff --git a/drivers/scsi/qla2xxx/Kconfig b/drivers/scsi/qla2xxx/Kconfig
index 802c373fd6d9..a584708d3056 100644
--- a/drivers/scsi/qla2xxx/Kconfig
+++ b/drivers/scsi/qla2xxx/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config SCSI_QLA_FC
 	tristate "QLogic QLA2XXX Fibre Channel Support"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	depends on SCSI_FC_ATTRS
 	depends on NVME_FC || !NVME_FC
 	select FW_LOADER
-- 
2.39.2

