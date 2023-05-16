Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC34704B74
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 13:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjEPLC3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 07:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjEPLBv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 07:01:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072E35BA3;
        Tue, 16 May 2023 04:01:14 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GAuVlu006556;
        Tue, 16 May 2023 11:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PlsPRCPB3qDYnzyYB5z+JqtZWB2fcxu7jIHwSiaFtss=;
 b=o50ApwcpeY9lKHf1TGlXXNt7YPLvtSBKOmSY3a7obL2xs7w57MgK5dnq00vPQDRbQCHd
 +pCIU2qQAQZ4j04Jqca8b+1M+5fAuVTRVMGMhUT6Sw8mhaLYfSrxoR85wDeQy2IN9FYj
 QgeBPHOwlERz++D3wsRCrr/RvLGvCpM2NN7p3EteRm16mybEEUfyVXtwjE46HjxCd/QV
 f1JsrPH4W+yscY57zurTpmU5y27lmcyWxYPFcONkQJ3lH8DLTIq2QD1ZTk1iQqPbOd7+
 OxWCn2xIHjr1yDniOqQ/SyiDfqoaw8TrGbX7B0XZcwIkJYTQrD90GxEDCVOnd8HavK7O sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm8h604d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:00:46 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34GAwA7W012480;
        Tue, 16 May 2023 11:00:46 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm8h604ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:00:46 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34G7MswP011883;
        Tue, 16 May 2023 11:00:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3qj264san8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:00:43 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34GB0em233751510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 11:00:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C7FB20040;
        Tue, 16 May 2023 11:00:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EE2D20043;
        Tue, 16 May 2023 11:00:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 16 May 2023 11:00:40 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
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
Subject: [PATCH v4 02/41] ata: add HAS_IOPORT dependencies
Date:   Tue, 16 May 2023 12:59:58 +0200
Message-Id: <20230516110038.2413224-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516110038.2413224-1-schnelle@linux.ibm.com>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4O-h99vREYljBoiv-VObOU7deLGswAi2
X-Proofpoint-ORIG-GUID: BpI0mYhh52WXlYM7Ip1htuyKnFHtbhO9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_04,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1011 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160089
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
Note: The HAS_IOPORT Kconfig option was added in v6.4-rc1 so
      per-subsystem patches may be applied independently

 drivers/ata/Kconfig       | 28 ++++++++++++++--------------
 drivers/ata/ata_generic.c |  2 ++
 drivers/ata/libata-sff.c  |  2 ++
 include/linux/libata.h    |  2 ++
 4 files changed, 20 insertions(+), 14 deletions(-)

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
diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 2f57ec00ab82..2d391d117f74 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -197,8 +197,10 @@ static int ata_generic_init_one(struct pci_dev *dev, const struct pci_device_id
 	if (!(command & PCI_COMMAND_IO))
 		return -ENODEV;
 
+#ifdef CONFIG_PATA_ALI
 	if (dev->vendor == PCI_VENDOR_ID_AL)
 		ata_pci_bmdma_clear_simplex(dev);
+#endif /* CONFIG_PATA_ALI */
 
 	if (dev->vendor == PCI_VENDOR_ID_ATI) {
 		int rc = pcim_enable_device(dev);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 9d28badfe41d..80137edb7ebf 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -3031,6 +3031,7 @@ EXPORT_SYMBOL_GPL(ata_bmdma_port_start32);
 
 #ifdef CONFIG_PCI
 
+#ifdef CONFIG_HAS_IOPORT
 /**
  *	ata_pci_bmdma_clear_simplex -	attempt to kick device out of simplex
  *	@pdev: PCI device
@@ -3056,6 +3057,7 @@ int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ata_pci_bmdma_clear_simplex);
+#endif /* CONFIG_HAS_IOPORT */
 
 static void ata_bmdma_nodma(struct ata_host *host, const char *reason)
 {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 311cd93377c7..90002d4a785b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -2012,7 +2012,9 @@ extern int ata_bmdma_port_start(struct ata_port *ap);
 extern int ata_bmdma_port_start32(struct ata_port *ap);
 
 #ifdef CONFIG_PCI
+#ifdef CONFIG_HAS_IOPORT
 extern int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev);
+#endif /* CONFIG_HAS_IOPORT */
 extern void ata_pci_bmdma_init(struct ata_host *host);
 extern int ata_pci_bmdma_prepare_host(struct pci_dev *pdev,
 				      const struct ata_port_info * const * ppi,
-- 
2.39.2

