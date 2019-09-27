Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB1EC0E83
	for <lists+linux-arch@lfdr.de>; Sat, 28 Sep 2019 01:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfI0XlN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Sep 2019 19:41:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728487AbfI0XlN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Sep 2019 19:41:13 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8RNbYVi009095;
        Fri, 27 Sep 2019 19:40:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v9rd7nu1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 19:40:34 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8RNeYsa035751;
        Fri, 27 Sep 2019 19:40:34 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v9rd7nu17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 19:40:34 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8RNeOgR007457;
        Fri, 27 Sep 2019 23:40:32 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04dal.us.ibm.com with ESMTP id 2v5bg8k6je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 23:40:32 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8RNeWA647251832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 23:40:32 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D962112064;
        Fri, 27 Sep 2019 23:40:32 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59DB0112065;
        Fri, 27 Sep 2019 23:40:28 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.18.235.58])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 Sep 2019 23:40:28 +0000 (GMT)
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ganesh Goudar <ganeshgr@linux.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v4 02/11] asm-generic/pgtable: Adds dummy functions to monitor lockless pgtable walks
Date:   Fri, 27 Sep 2019 20:39:59 -0300
Message-Id: <20190927234008.11513-3-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927234008.11513-1-leonardo@linux.ibm.com>
References: <20190927234008.11513-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=961 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909270205
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There is a need to monitor lockless pagetable walks, in order to avoid
doing THP splitting/collapsing during them.

Some methods rely on local_irq_{save,restore}, but that can be slow on
cases with a lot of cpus are used for the process.

In order to speedup these cases, I propose a refcount-based approach, that
counts the number of lockless pagetable	walks happening on the process.

Given that there are lockless pagetable walks on generic code, it's
necessary to create dummy functions for archs that won't use the approach.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 include/asm-generic/pgtable.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 75d9d68a6de7..0831475e72d3 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1172,6 +1172,21 @@ static inline bool arch_has_pfn_modify_check(void)
 #endif
 #endif
 
+#ifndef __HAVE_ARCH_LOCKLESS_PGTBL_WALK_COUNTER
+static inline void start_lockless_pgtbl_walk(struct mm_struct *mm)
+{
+}
+
+static inline void end_lockless_pgtbl_walk(struct mm_struct *mm)
+{
+}
+
+static inline int running_lockless_pgtbl_walk(struct mm_struct *mm)
+{
+	return 0;
+}
+#endif
+
 /*
  * On some architectures it depends on the mm if the p4d/pud or pmd
  * layer of the page table hierarchy is folded or not.
-- 
2.20.1

