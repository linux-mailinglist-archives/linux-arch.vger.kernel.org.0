Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A055D406D83
	for <lists+linux-arch@lfdr.de>; Fri, 10 Sep 2021 16:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhIJOVG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Sep 2021 10:21:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233837AbhIJOVG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Sep 2021 10:21:06 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18AE4dT0003764;
        Fri, 10 Sep 2021 10:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tRUcJmxZI06bgFTd2YoWwdkI1EIf07riiKhsAJZnDaQ=;
 b=ZrjhJ1IuAdWNBJqiskGsC8nlcEPv2s1p+8+Z2NVAeJzdMN7tF1ohextJz5ctdeZ1WNRX
 Mz/Gt2nmzq4JLvifwugJKJlHp9YhYxJPsA6iM9ww2a0YQ7Id3zypWL44V9zaex7rLrK1
 ZYLCP//kh+qz0aLcmSs982ehIrdsHC/St4FUg9MEv4CxnjKCE5XfudqJfS+WuxG1mbFN
 ZEi5dWH3+5JR2Sp7Wn1VwhU6qzmNYqEgH0w0ZA2Sieg23npxhE6n7WQVAqxWoX76ec70
 OXwOR+VNT4bIjt8uhJ/oOfJSy0NtC0wnKdgOzbS2Mzppoll1dNbFbg5TKCQzQqgNpzd8 wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ayu41hdew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Sep 2021 10:19:47 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18AE53FG004823;
        Fri, 10 Sep 2021 10:19:46 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ayu41hde0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Sep 2021 10:19:46 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18AEHawv025614;
        Fri, 10 Sep 2021 14:19:44 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3axcnq23d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Sep 2021 14:19:43 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18AEFIxU58655226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Sep 2021 14:15:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3045C42041;
        Fri, 10 Sep 2021 14:19:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE31142042;
        Fri, 10 Sep 2021 14:19:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Sep 2021 14:19:40 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] powerpc: Drop superfluous pci_dev_is_added() calls
Date:   Fri, 10 Sep 2021 16:19:40 +0200
Message-Id: <20210910141940.2598035-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210910141940.2598035-1-schnelle@linux.ibm.com>
References: <20210910141940.2598035-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: za8VTNRr0shtqDgsPfee0Ni4ctKNrmje
X-Proofpoint-ORIG-GUID: LucwXuB3CGUb9u06TqyoDzboh2KLAZa7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_04:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109100081
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On powerpc, pci_dev_is_added() is called as part of SR-IOV fixups
that are done under pcibios_add_device() which in turn is only called in
pci_device_add() whih is called when a PCI device is scanned.

Now pci_dev_assign_added() is called in pci_bus_add_device() which is
only called after scanning the device. Thus pci_dev_is_added() is always
false and can be dropped.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-sriov.c | 6 ------
 arch/powerpc/platforms/pseries/setup.c     | 3 +--
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
index 28aac933a439..deddbb233fde 100644
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
@@ -228,9 +225,6 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 
 void pnv_pci_ioda_fixup_iov(struct pci_dev *pdev)
 {
-	if (WARN_ON(pci_dev_is_added(pdev)))
-		return;
-
 	if (pdev->is_virtfn) {
 		struct pnv_ioda_pe *pe = pnv_ioda_get_pe(pdev);
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index f79126f16258..2188054470c1 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -74,7 +74,6 @@
 #include <asm/hvconsole.h>
 
 #include "pseries.h"
-#include "../../../../drivers/pci/pci.h"
 
 DEFINE_STATIC_KEY_FALSE(shared_processor);
 EXPORT_SYMBOL(shared_processor);
@@ -750,7 +749,7 @@ static void pseries_pci_fixup_iov_resources(struct pci_dev *pdev)
 	const int *indexes;
 	struct device_node *dn = pci_device_to_OF_node(pdev);
 
-	if (!pdev->is_physfn || pci_dev_is_added(pdev))
+	if (!pdev->is_physfn)
 		return;
 	/*Firmware must support open sriov otherwise dont configure*/
 	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
-- 
2.25.1

