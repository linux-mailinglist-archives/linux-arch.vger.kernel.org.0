Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E677B514BCF
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376852AbiD2N5b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376757AbiD2N4p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:56:45 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA3BCABB9;
        Fri, 29 Apr 2022 06:51:56 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TDHuUR025924;
        Fri, 29 Apr 2022 13:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=frSzV1NpVSEsFoh+Hw9rzs/0qMO790AINgmXl+xAV1E=;
 b=oTc2P7kLNVT58EFgHkvcQdMONsTTD+I6VSEllvQLM7bJZbWUFDxXV41EoOZXD+fNOUSC
 wrgzfwPcOcqn1DP4+VIzjFm8dq1yHyz8vZDqs2ZlGBgJvQt23bkHQBIXtdATL9T616LN
 3JQmtno5V8nuYCRE0JTwpO+RIDwXlWpqYtMSOqNucWWRsTIkMwqXrs9UKWcXYH7Jtmoh
 wGPyqxuPi91WxB7Q2KvrCapXAC4ydxrAHpaMRkz5IwqPzB9kFma6InLIztj3ela5UuGE
 Qd2fsijxdPjsO6ONZurVKybTsduj/3SL8+u0XduFLZXMGmcwHcyMh+yK6QPZWC2zxyJR Zw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqtqvwt5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:45 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDQpFn021544;
        Fri, 29 Apr 2022 13:51:43 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm93917rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDpepm39256570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:51:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C67E34C040;
        Fri, 29 Apr 2022 13:51:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4807A4C044;
        Fri, 29 Apr 2022 13:51:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:40 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com (supporter:QLOGIC QLA2XXX
        FC-SCSI DRIVER),
        linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
        megaraidlinux.pdl@broadcom.com (open list:MEGARAID SCSI/SAS DRIVERS)
Subject: [RFC v2 30/39] scsi: add HAS_IOPORT dependencies
Date:   Fri, 29 Apr 2022 15:50:51 +0200
Message-Id: <20220429135108.2781579-54-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4yhBAvXsF23sdlSj_wOWSro-AFbvz1l1
X-Proofpoint-ORIG-GUID: 4yhBAvXsF23sdlSj_wOWSro-AFbvz1l1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 mlxlogscore=886 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
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
those drivers using them.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/scsi/Kconfig                   | 19 ++++++++++---------
 drivers/scsi/aic7xxx/Kconfig.aic79xx   |  2 +-
 drivers/scsi/aic7xxx/Kconfig.aic7xxx   |  2 +-
 drivers/scsi/aic94xx/Kconfig           |  2 +-
 drivers/scsi/megaraid/Kconfig.megaraid |  6 +++---
 drivers/scsi/mvsas/Kconfig             |  2 +-
 drivers/scsi/qla2xxx/Kconfig           |  2 +-
 7 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 6e3a04107bb6..40430aa8569b 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -333,7 +333,7 @@ config SGIWD93_SCSI
 
 config BLK_DEV_3W_XXXX_RAID
 	tristate "3ware 5/6/7/8xxx ATA-RAID support"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	help
 	  3ware is the only hardware ATA-Raid product in Linux to date.
 	  This card is 2,4, or 8 channel master mode support only.
@@ -380,7 +380,7 @@ config SCSI_3W_SAS
 
 config SCSI_ACARD
 	tristate "ACARD SCSI support"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	help
 	  This driver supports the ACARD SCSI host adapter.
 	  Support Chip <ATP870 ATP876 ATP880 ATP885>
@@ -472,7 +472,7 @@ config SCSI_DPT_I2O
 config SCSI_ADVANSYS
 	tristate "AdvanSys SCSI support"
 	depends on SCSI
-	depends on ISA || EISA || PCI
+	depends on (ISA || EISA || PCI) && HAS_IOPORT
 	depends on ISA_DMA_API || !ISA
 	help
 	  This is a driver for all SCSI host adapters manufactured by
@@ -643,7 +643,7 @@ config SCSI_SNIC_DEBUG_FS
 
 config SCSI_DMX3191D
 	tristate "DMX3191D SCSI support"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	select SCSI_SPI_ATTRS
 	help
 	  This is support for Domex DMX3191D SCSI Host Adapters.
@@ -657,7 +657,7 @@ config SCSI_FDOMAIN
 
 config SCSI_FDOMAIN_PCI
 	tristate "Future Domain TMC-3260/AHA-2920A PCI SCSI support"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	select SCSI_FDOMAIN
 	help
 	  This is support for Future Domain's PCI SCSI host adapters (TMC-3260)
@@ -710,7 +710,7 @@ config SCSI_GENERIC_NCR5380
 
 config SCSI_IPS
 	tristate "IBM ServeRAID support"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	help
 	  This is support for the IBM ServeRAID hardware RAID controllers.
 	  See <http://www.developer.ibm.com/welcome/netfinity/serveraid.html>
@@ -770,7 +770,7 @@ config SCSI_IBMVFC_TRACE
 
 config SCSI_INITIO
 	tristate "Initio 9100U(W) support"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	help
 	  This is support for the Initio 91XXU(W) SCSI host adapter.  Please
 	  read the SCSI-HOWTO, available from
@@ -781,7 +781,7 @@ config SCSI_INITIO
 
 config SCSI_INIA100
 	tristate "Initio INI-A100U2W support"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	help
 	  This is support for the Initio INI-A100U2W SCSI host adapter.
 	  Please read the SCSI-HOWTO, available from
@@ -793,6 +793,7 @@ config SCSI_INIA100
 config SCSI_PPA
 	tristate "IOMEGA parallel port (ppa - older drives)"
 	depends on SCSI && PARPORT_PC
+	depends on HAS_IOPORT
 	help
 	  This driver supports older versions of IOMEGA's parallel port ZIP
 	  drive (a 100 MB removable media device).
@@ -1187,7 +1188,7 @@ config SCSI_SIM710
 
 config SCSI_DC395x
 	tristate "Tekram DC395(U/UW/F) and DC315(U) SCSI support"
-	depends on PCI && SCSI
+	depends on PCI && HAS_IOPORT && SCSI
 	select SCSI_SPI_ATTRS
 	help
 	  This driver supports PCI SCSI host adapters based on the ASIC
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
2.32.0

