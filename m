Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22BD3CD46A
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jul 2021 14:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbhGSLbT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Jul 2021 07:31:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1380 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236829AbhGSLbT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Jul 2021 07:31:19 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16JC4ST6194535;
        Mon, 19 Jul 2021 08:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=IbwvhhQ3m/v8Z9ZwaQawHv93yzco477LrN3X2MVHuBs=;
 b=XiJJr3Oqa9mcw4Zgu79/s54sACNwPIVi5WEZMiWHT1PRfgELHkjq9o1ZOg2lJGpoghHP
 W36sQoEe7HYxiTdA1Z4KsLysjCkAgXo29Eqmr12JD4HivQ83QNzCcwB53tik8mgsoh02
 4BHm9+Yexc0b4PaJfSJA4X4mhn9fmDfaU7fTpr/Q9R3PXs0+vToyeJZUwq/1J9GCjDCx
 LZSZdjzNbMzzsJco38PCsFeTlaH9gd1k+ka4CqSV8ClV0YxF2grYaUk+8+qBFeNw9C3Y
 dazBvwCi5fFpXBhBeam/nEfTisPp1dfkhaLbB3+oGUXB7phQAp8HRq+aaMS6zuHqEJrq JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39w91hgdk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 08:11:53 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16JC4chc195676;
        Mon, 19 Jul 2021 08:11:53 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39w91hgdjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 08:11:52 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16JC2Vtu016802;
        Mon, 19 Jul 2021 12:11:51 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 39upu88prp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 12:11:51 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16JCBmx924904012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 12:11:48 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C303C11C0E1;
        Mon, 19 Jul 2021 12:11:48 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77BF311C0D9;
        Mon, 19 Jul 2021 12:11:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Jul 2021 12:11:48 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] PCI: Move pci_dev_is/assign_added() to pci.h
Date:   Mon, 19 Jul 2021 14:11:48 +0200
Message-Id: <20210719121148.2403239-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iVz62Q30GlTNsZVqNUE9lREkTHvZX6iA
X-Proofpoint-GUID: jiSA7etyPQeuxkqsjh2oPwDQkktdY5vB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-19_05:2021-07-16,2021-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107190069
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The helper function pci_dev_is_added() from drivers/pci/pci.h is used in
PCI arch code of both s390 and powerpc leading to awkward relative
includes. Move it to the global include/linux/pci.h and get rid of these
includes just for that one function.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-sriov.c |  3 ---
 arch/powerpc/platforms/pseries/setup.c     |  1 -
 arch/s390/pci/pci_sysfs.c                  |  2 --
 drivers/pci/hotplug/acpiphp_glue.c         |  1 -
 drivers/pci/pci.h                          | 15 ---------------
 include/linux/pci.h                        | 13 +++++++++++++
 6 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
index 28aac933a439..2e0ca5451e85 100644
--- a/arch/powerpc/platforms/powernv/pci-sriov.c
+++ b/arch/powerpc/platforms/powernv/pci-sriov.c
@@ -9,9 +9,6 @@
 
 #include "pci.h"
 
-/* for pci_dev_is_added() */
-#include "../../../../drivers/pci/pci.h"
-
 /*
  * The majority of the complexity in supporting SR-IOV on PowerNV comes from
  * the need to put the MMIO space for each VF into a separate PE. Internally
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 631a0d57b6cd..17585ec9f955 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -74,7 +74,6 @@
 #include <asm/hvconsole.h>
 
 #include "pseries.h"
-#include "../../../../drivers/pci/pci.h"
 
 DEFINE_STATIC_KEY_FALSE(shared_processor);
 EXPORT_SYMBOL_GPL(shared_processor);
diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
index 6e2450c2b9c1..8dbe54ef8f8e 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -13,8 +13,6 @@
 #include <linux/stat.h>
 #include <linux/pci.h>
 
-#include "../../../drivers/pci/pci.h"
-
 #include <asm/sclp.h>
 
 #define zpci_attr(name, fmt, member)					\
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index f031302ad401..4cb963f88183 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -38,7 +38,6 @@
 #include <linux/slab.h>
 #include <linux/acpi.h>
 
-#include "../pci.h"
 #include "acpiphp.h"
 
 static LIST_HEAD(bridge_list);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 93dcdd431072..a159cd0f6f05 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -383,21 +383,6 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
 	return dev->error_state == pci_channel_io_perm_failure;
 }
 
-/* pci_dev priv_flags */
-#define PCI_DEV_ADDED 0
-#define PCI_DPC_RECOVERED 1
-#define PCI_DPC_RECOVERING 2
-
-static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
-{
-	assign_bit(PCI_DEV_ADDED, &dev->priv_flags, added);
-}
-
-static inline bool pci_dev_is_added(const struct pci_dev *dev)
-{
-	return test_bit(PCI_DEV_ADDED, &dev->priv_flags);
-}
-
 #ifdef CONFIG_PCIEAER
 #include <linux/aer.h>
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 540b377ca8f6..b3b7bafa17e5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -507,6 +507,19 @@ struct pci_dev {
 	unsigned long	priv_flags;	/* Private flags for the PCI driver */
 };
 
+/* pci_dev priv_flags */
+#define PCI_DEV_ADDED 0
+
+static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
+{
+	assign_bit(PCI_DEV_ADDED, &dev->priv_flags, added);
+}
+
+static inline bool pci_dev_is_added(const struct pci_dev *dev)
+{
+	return test_bit(PCI_DEV_ADDED, &dev->priv_flags);
+}
+
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
 {
 #ifdef CONFIG_PCI_IOV
-- 
2.25.1

