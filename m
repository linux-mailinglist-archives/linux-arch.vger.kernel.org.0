Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23183CFDF9
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jul 2021 17:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhGTPAs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jul 2021 11:00:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239972AbhGTOWd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Jul 2021 10:22:33 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16KEpGqs050858;
        Tue, 20 Jul 2021 11:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=4yJPyWET6+73QDcQFyJd/Bc3kxhxcfiUQwUkrG1J3a0=;
 b=efu1XCVbXaUaZpr0ZRQgTmYxOS54uIaAkS7tfrX87l5TqH/oXP8r8kvpzV/rxyXwrDpX
 LAr2T63O7IBfbaakEoh61CnphxQ3kqRI5d0BAKZlbFOa02zfXTc2NXosZpZF8cQwwhHd
 eKj0KLVtVZs2v1VNTsKNY4Vx1ojm+wLurL4uZfwVqAyNG7gcNnrKIo1xCm2+wwyADFKO
 nrTF20OlCH6nrld1iTFTb5ecPIIhrStEX9niI0sXFTQv6XWgUiFVPX8iaI5+TWRU58JJ
 ty+H7gHF1Bjt/sLTtLm7+ZJQ5LSK3ufwz+QYtCtVE0tqQyhEPWkOyS1b3chLne9jU7Vl mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39wwg677ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 11:01:59 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16KEpPkp051587;
        Tue, 20 Jul 2021 11:01:59 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39wwg677ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 11:01:56 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16KEsOB3004898;
        Tue, 20 Jul 2021 15:01:48 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 39upu88t5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 15:01:48 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16KF1kFR34079210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jul 2021 15:01:46 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E67CC52059;
        Tue, 20 Jul 2021 15:01:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 88F9D52050;
        Tue, 20 Jul 2021 15:01:45 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] PCI: Move pci_dev_is/assign_added() to pci.h
Date:   Tue, 20 Jul 2021 17:01:45 +0200
Message-Id: <20210720150145.640727-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _DcHbTAJjqF8GuaMyqVq3aSFzMnPY462
X-Proofpoint-ORIG-GUID: _ecq_PxMqpK76NqtWINHCvv1PWBUdX3r
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-20_09:2021-07-19,2021-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107200091
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The helper function pci_dev_is_added() from drivers/pci/pci.h is used in
PCI arch code of both s390 and powerpc leading to awkward relative
includes. Move it to the global include/linux/pci.h and get rid of these
includes just for that one function.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Since v1 (and bad v2):
- Fixed accidental removal of PCI_DPC_RECOVERED, PCI_DPC_RECOVERING
  defines and also move these to include/linux/pci.h

 arch/powerpc/platforms/powernv/pci-sriov.c |  3 ---
 arch/powerpc/platforms/pseries/setup.c     |  1 -
 arch/s390/pci/pci_sysfs.c                  |  2 --
 drivers/pci/hotplug/acpiphp_glue.c         |  1 -
 drivers/pci/pci.h                          | 15 ---------------
 include/linux/pci.h                        | 15 +++++++++++++++
 6 files changed, 15 insertions(+), 22 deletions(-)

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
index 540b377ca8f6..ea0e23dbc8ec 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -507,6 +507,21 @@ struct pci_dev {
 	unsigned long	priv_flags;	/* Private flags for the PCI driver */
 };
 
+/* pci_dev priv_flags */
+#define PCI_DEV_ADDED 0
+#define PCI_DPC_RECOVERED 1
+#define PCI_DPC_RECOVERING 2
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

