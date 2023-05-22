Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55B870BA73
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 12:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjEVKvW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 06:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjEVKvR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 06:51:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B06DE6;
        Mon, 22 May 2023 03:51:14 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M8lXpu031205;
        Mon, 22 May 2023 10:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6YpN3k6Nyxob70TVYCYJ6D+qKJCsGVUpucKpj8fHJtY=;
 b=Sw4IoaQX5TQ2ia5rjJ/dApgUaj8Wq1EqYui94TWXT/kyZkJ2IgG9mxVIMnAzo5ISl+Z8
 FP0RIxIkAqd1ORkNuHkuOY6/Gct4bgRV2/fu3mjf5zdbfwpJjeXj+CmwHho7ijgdC2da
 tvt/6H+gFXyUEq3qKxG6Lk00z2xL0BPWU68ur4UaHG328itTdjVoD6xB//Rz+lcFsDLa
 wPQoGzZJ+gvkkKOjsr3PJ+eaMk/p9ibaPXqjCY9obZEiEP1/0JfXXyVQv01r8SbVWrWK
 NzJL/vJ/8vn5voMBslSyTkyRQHXjMax3CUXxprNDGyD2Fr6si9YmNsLoZJEClr26QS7S VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qq7qjgn2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:50:57 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MAJeZ6014457;
        Mon, 22 May 2023 10:50:56 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qq7qjgn1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:50:56 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34M2nk1W024768;
        Mon, 22 May 2023 10:50:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qppc3gw7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:50:54 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34MAopV732833994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 10:50:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D75E20043;
        Mon, 22 May 2023 10:50:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42C6D2004B;
        Mon, 22 May 2023 10:50:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 22 May 2023 10:50:51 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>
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
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH v5 02/44] ata: add HAS_IOPORT dependencies
Date:   Mon, 22 May 2023 12:50:07 +0200
Message-Id: <20230522105049.1467313-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522105049.1467313-1-schnelle@linux.ibm.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gr1UQ8xUCX7rQxeM6luW7QmU98LjnwCG
X-Proofpoint-GUID: p2hwgiYmarMOYUH41Iha2Lh9Dgd7OR5W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_06,2023-05-22_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 impostorscore=0
 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/ata/Kconfig      | 28 ++++++++++++++--------------
 drivers/ata/libata-sff.c |  4 ++++
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 42b51c9812a0..c521cdc51f8c 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -557,7 +557,7 @@ comment "PATA SFF controllers with BMDMA"
 
 config PATA_ALI
 	tristate "ALi PATA support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select PATA_TIMINGS
 	help
 	  This option enables support for the ALi ATA interfaces
@@ -567,7 +567,7 @@ config PATA_ALI
 
 config PATA_AMD
 	tristate "AMD/NVidia PATA support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select PATA_TIMINGS
 	help
 	  This option enables support for the AMD and NVidia PATA
@@ -585,7 +585,7 @@ config PATA_ARASAN_CF
 
 config PATA_ARTOP
 	tristate "ARTOP 6210/6260 PATA support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  This option enables support for ARTOP PATA controllers.
 
@@ -612,7 +612,7 @@ config PATA_ATP867X
 
 config PATA_CMD64X
 	tristate "CMD64x PATA support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select PATA_TIMINGS
 	help
 	  This option enables support for the CMD64x series chips
@@ -659,7 +659,7 @@ config PATA_CS5536
 
 config PATA_CYPRESS
 	tristate "Cypress CY82C693 PATA support (Very Experimental)"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select PATA_TIMINGS
 	help
 	  This option enables support for the Cypress/Contaq CY82C693
@@ -707,7 +707,7 @@ config PATA_HPT366
 
 config PATA_HPT37X
 	tristate "HPT 370/370A/371/372/374/302 PATA support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  This option enables support for the majority of the later HPT
 	  PATA controllers via the new ATA layer.
@@ -716,7 +716,7 @@ config PATA_HPT37X
 
 config PATA_HPT3X2N
 	tristate "HPT 371N/372N/302N PATA support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  This option enables support for the N variant HPT PATA
 	  controllers via the new ATA layer.
@@ -819,7 +819,7 @@ config PATA_MPC52xx
 
 config PATA_NETCELL
 	tristate "NETCELL Revolution RAID support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  This option enables support for the Netcell Revolution RAID
 	  PATA controller.
@@ -855,7 +855,7 @@ config PATA_OLDPIIX
 
 config PATA_OPTIDMA
 	tristate "OPTI FireStar PATA support (Very Experimental)"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  This option enables DMA/PIO support for the later OPTi
 	  controllers found on some old motherboards and in some
@@ -865,7 +865,7 @@ config PATA_OPTIDMA
 
 config PATA_PDC2027X
 	tristate "Promise PATA 2027x support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  This option enables support for Promise PATA pdc20268 to pdc20277 host adapters.
 
@@ -873,7 +873,7 @@ config PATA_PDC2027X
 
 config PATA_PDC_OLD
 	tristate "Older Promise PATA controller support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  This option enables support for the Promise 20246, 20262, 20263,
 	  20265 and 20267 adapters.
@@ -901,7 +901,7 @@ config PATA_RDC
 
 config PATA_SC1200
 	tristate "SC1200 PATA support"
-	depends on PCI && (X86_32 || COMPILE_TEST)
+	depends on PCI && (X86_32 || COMPILE_TEST) && HAS_IOPORT
 	help
 	  This option enables support for the NatSemi/AMD SC1200 SoC
 	  companion chip used with the Geode processor family.
@@ -919,7 +919,7 @@ config PATA_SCH
 
 config PATA_SERVERWORKS
 	tristate "SERVERWORKS OSB4/CSB5/CSB6/HT1000 PATA support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  This option enables support for the Serverworks OSB4/CSB5/CSB6 and
 	  HT1000 PATA controllers, via the new ATA layer.
@@ -1183,7 +1183,7 @@ config ATA_GENERIC
 
 config PATA_LEGACY
 	tristate "Legacy ISA PATA support (Experimental)"
-	depends on (ISA || PCI)
+	depends on (ISA || PCI) && HAS_IOPORT
 	select PATA_TIMINGS
 	help
 	  This option enables support for ISA/VLB/PCI bus legacy PATA
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 9d28badfe41d..c8cb7ed28f83 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -3042,6 +3042,7 @@ EXPORT_SYMBOL_GPL(ata_bmdma_port_start32);
  */
 int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev)
 {
+#ifdef CONFIG_HAS_IOPORT
 	unsigned long bmdma = pci_resource_start(pdev, 4);
 	u8 simplex;
 
@@ -3054,6 +3055,9 @@ int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev)
 	if (simplex & 0x80)
 		return -EOPNOTSUPP;
 	return 0;
+#else
+	return -ENOENT;
+#endif /* CONFIG_HAS_IOPORT */
 }
 EXPORT_SYMBOL_GPL(ata_pci_bmdma_clear_simplex);
 
-- 
2.39.2

