Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14439C0E73
	for <lists+linux-arch@lfdr.de>; Sat, 28 Sep 2019 01:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbfI0XlJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Sep 2019 19:41:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725990AbfI0XlJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Sep 2019 19:41:09 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8RNbRmo073228;
        Fri, 27 Sep 2019 19:40:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v8y3bhk8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 19:40:26 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8RNbUuN073303;
        Fri, 27 Sep 2019 19:40:25 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v8y3bhk8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 19:40:25 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8RNePZq023858;
        Fri, 27 Sep 2019 23:40:25 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 2v5bg8b6xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 23:40:25 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8RNeOHR46072232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 23:40:24 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18177112065;
        Fri, 27 Sep 2019 23:40:24 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 618E9112061;
        Fri, 27 Sep 2019 23:40:20 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.18.235.58])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 Sep 2019 23:40:20 +0000 (GMT)
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
Subject: [PATCH v4 00/11] Introduces new count-based method for monitoring lockless pagetable walks
Date:   Fri, 27 Sep 2019 20:39:57 -0300
Message-Id: <20190927234008.11513-1-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=848 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909270205
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If a process (qemu) with a lot of CPUs (128) try to munmap() a large
chunk of memory (496GB) mapped with THP, it takes an average of 275
seconds, which can cause a lot of problems to the load (in qemu case,
the guest will lock for this time).

Trying to find the source of this bug, I found out most of this time is
spent on serialize_against_pte_lookup(). This function will take a lot
of time in smp_call_function_many() if there is more than a couple CPUs
running the user process. Since it has to happen to all THP mapped, it
will take a very long time for large amounts of memory.

By the docs, serialize_against_pte_lookup() is needed in order to avoid
pmd_t to pte_t casting inside find_current_mm_pte(), or any lockless
pagetable walk, to happen concurrently with THP splitting/collapsing.

It does so by calling a do_nothing() on each CPU in mm->cpu_bitmap[],
after interrupts are re-enabled.
Since, interrupts are (usually) disabled during lockless pagetable
walk, and serialize_against_pte_lookup will only return after
interrupts are enabled, it is protected.

So, by what I could understand, if there is no lockless pagetable walk
running, there is no need to call serialize_against_pte_lookup().

So, to avoid the cost of running serialize_against_pte_lookup(), I
propose a counter that keeps track of how many find_current_mm_pte()
are currently running, and if there is none, just skip
smp_call_function_many().

The related functions are:
start_lockless_pgtbl_walk(mm)
        Insert before starting any lockless pgtable walk
end_lockless_pgtbl_walk(mm)
        Insert after the end of any lockless pgtable walk
        (Mostly after the ptep is last used)
running_lockless_pgtbl_walk(mm)
        Returns the number of lockless pgtable walks running

On my workload (qemu), I could see munmap's time reduction from 275
seconds to 418ms.

Also, I documented some lockless pagetable walks in which it's not
necessary to keep track, given they work on init_mm or guest pgd.

Changes since v3:
 Adds memory barrier to {start,end}_lockless_pgtbl_walk()
 Explain (comments) why some lockless pgtbl walks don't need
	local_irq_disable (real mode + MSR_EE=0)
 Explain (comments) places where counting method is not needed (guest pgd,
	which is not touched by THP)
 Fixes some misplaced local_irq_restore()
 Link: http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=132417

Changes since v2:
 Rebased to v5.3
 Adds support on __get_user_pages_fast
 Adds usage decription to *_lockless_pgtbl_walk()
 Better style to dummy functions
 Link: http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=131839

Changes since v1:
 Isolated atomic operations in functions *_lockless_pgtbl_walk()
 Fixed behavior of decrementing before last ptep was used
 Link: http://patchwork.ozlabs.org/patch/1163093/


Leonardo Bras (11):
  powerpc/mm: Adds counting method to monitor lockless pgtable walks
  asm-generic/pgtable: Adds dummy functions to monitor lockless pgtable
    walks
  mm/gup: Applies counting method to monitor gup_pgd_range
  powerpc/mce_power: Applies counting method to monitor lockless pgtbl
    walks
  powerpc/perf: Applies counting method to monitor lockless pgtbl walks
  powerpc/mm/book3s64/hash: Applies counting method to monitor lockless
    pgtbl walks
  powerpc/kvm/e500: Applies counting method to monitor lockless pgtbl
    walks
  powerpc/kvm/book3s_hv: Applies counting method to monitor lockless
    pgtbl walks
  powerpc/kvm/book3s_64: Applies counting method to monitor lockless
    pgtbl walks
  powerpc/book3s_64: Enables counting method to monitor lockless pgtbl
    walk
  powerpc/mm/book3s64/pgtable: Uses counting method to skip serializing

 arch/powerpc/include/asm/book3s/64/mmu.h     |  3 ++
 arch/powerpc/include/asm/book3s/64/pgtable.h |  5 ++
 arch/powerpc/kernel/mce_power.c              | 13 ++++--
 arch/powerpc/kvm/book3s_64_mmu_hv.c          |  2 +
 arch/powerpc/kvm/book3s_64_mmu_radix.c       | 30 ++++++++++++
 arch/powerpc/kvm/book3s_64_vio_hv.c          |  3 ++
 arch/powerpc/kvm/book3s_hv_nested.c          | 22 ++++++++-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c          | 18 ++++++--
 arch/powerpc/kvm/e500_mmu_host.c             |  6 ++-
 arch/powerpc/mm/book3s64/hash_tlb.c          |  2 +
 arch/powerpc/mm/book3s64/hash_utils.c        | 12 ++++-
 arch/powerpc/mm/book3s64/mmu_context.c       |  1 +
 arch/powerpc/mm/book3s64/pgtable.c           | 48 +++++++++++++++++++-
 arch/powerpc/perf/callchain.c                |  5 +-
 include/asm-generic/pgtable.h                | 15 ++++++
 mm/gup.c                                     |  8 ++++
 16 files changed, 180 insertions(+), 13 deletions(-)

-- 
2.20.1

