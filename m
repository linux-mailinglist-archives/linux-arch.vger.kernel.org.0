Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE546B9354
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 13:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjCNMPn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 08:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjCNMOq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 08:14:46 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418DB94F5B;
        Tue, 14 Mar 2023 05:13:33 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EBSdWu011544;
        Tue, 14 Mar 2023 12:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=ZmT/mFL5JQ5/mvCbrOpAoQn3FZbtHEliZEw1GJshmhs=;
 b=I2zxpeqet/9aeV4VhPw/iablRgxumtj+RSAoFu/zzfTx/cqtUZ+jT4sHV21D6EgXshCt
 mFG/m294VKbpGS612Em8LjuD9bW3iKzDljRYv31+XFUZImH182CVnPTyotvDRtFPnu4x
 LxkUtW7Sc/IsAS3zfqHRCrsaOeKC/L2P6LvfMSEMLPPRLhAWc1CBv6ssLdeI9/U94RU4
 DCnByAx4PguF2tUuRC6Ix0yoL3EitDoMceclFJtHIXAAsPR477A4WXr6neJWCFzRztbI
 VThY61CRF9xJE3TgmAs+otJb/sSxyVtMm0JD4OmrQq/0O1cMjsmmDgiGHsVt/8oTi7H1 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pap9ecb0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:53 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32EAjQBK017076;
        Tue, 14 Mar 2023 12:12:52 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pap9ecayb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:52 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32E7jOGX001023;
        Tue, 14 Mar 2023 12:12:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3p8h96mrw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ECClur35258912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 12:12:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A35362007A;
        Tue, 14 Mar 2023 12:12:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08D852007D;
        Tue, 14 Mar 2023 12:12:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Mar 2023 12:12:46 +0000 (GMT)
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
Subject: [PATCH v3 29/38] scsi: add HAS_IOPORT dependencies
Date:   Tue, 14 Mar 2023 13:12:07 +0100
Message-Id: <20230314121216.413434-30-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314121216.413434-1-schnelle@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kcr1nimqfScav668mJlXBIGkIAdBizWV
X-Proofpoint-ORIG-GUID: 5MSMYgdjgj5y_bTZbJ1vy0QoJNSgyBQ_
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_04,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=972 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303140103
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
index 03e71e3d5e5b..4ff96d8f6455 100644
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
@@ -1176,7 +1177,7 @@ config SCSI_SIM710
 
 config SCSI_DC395x
 	tristate "Tekram DC395(U/UW/F) and DC315(U) SCSI support"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	select SCSI_SPI_ATTRS
 	help
 	  This driver supports PCI SCSI host adapters based on the ASIC
@@ -1208,7 +1209,7 @@ config SCSI_AM53C974
 
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
2.37.2

