Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCCED153D4E
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2020 04:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgBFDKL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 22:10:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727572AbgBFDKK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 22:10:10 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01639AVg027642;
        Wed, 5 Feb 2020 22:09:33 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhpygyty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:09:33 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01639Wm8028517;
        Wed, 5 Feb 2020 22:09:32 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhpygytm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:09:32 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01636Ymi008757;
        Thu, 6 Feb 2020 03:09:31 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 2xykc947p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 03:09:31 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01639TuG41615622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Feb 2020 03:09:29 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0002BE051;
        Thu,  6 Feb 2020 03:09:29 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2DB4BE04F;
        Thu,  6 Feb 2020 03:09:13 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.85.163.250])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  6 Feb 2020 03:09:13 +0000 (GMT)
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Steven Price <steven.price@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v6 00/11] Introduces new functions for tracking lockless pagetable walks
Date:   Thu,  6 Feb 2020 00:08:49 -0300
Message-Id: <20200206030900.147032-1-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=966 clxscore=1011 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060022
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Patches 1-2: Introduces new arch-generic functions to use before
and after lockless pagetable walks, instead of local_irq_*, and
applies them to generic code. It makes lockless pagetable walks
more explicit and improves documentation about it.

Patches 3-9: Introduces a powerpc-specific version of the above
functions with the option to not touch irq config. Then apply them
to all powerpc code that do lockless pagetable walks.

Patches 10-11: Introduces a percpu counting method to keep track of
the lockless page table walks, then uses this info to reduce the
waiting time on serialize_against_pte_lookup().

Use case:

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

Percpu count-based method:

So, by what I could understand, if there is no lockless pagetable walk
running on given cpu, there is no need to call
serialize_against_pte_lookup() there.

To reduce the cost of running serialize_against_pte_lookup(), I
propose a percpu-counter that keeps track of how many
lockless pagetable walks are currently running on each cpu, and if there
is none, just skip smp_call_function_many() for that cpu.

- Every percpu-counter can be changed only by it's own CPU
- It makes use of the original memory barrier in the functions
- Any counter can be read by any CPU

Due to not locking nor using atomic variables, the impact on the
lockless pagetable walk is intended to be minimum.

The related functions are:
begin_lockless_pgtbl_walk()
        Insert before starting any lockless pgtable walk
end_lockless_pgtbl_walk()
        Insert after the end of any lockless pgtable walk
        (Mostly after the ptep is last used)

Results:

On my workload (qemu), I could see munmap's time reduction from 275
seconds to 430ms.

Bonus:

I documented some lockless pagetable walks in which it's not
necessary to keep track, given they work on init_mm or guest pgd.

Also fixed some misplaced local_irq_{restore, enable}.

Changes since v5:
 Changed counting approach from atomic variables to percpu variables
 Counting method only affects powepc, arch-generic only toggle irqs
 Changed commit order, so the counting method is introduced at the end
 Removed config option, always enabled in powerpc
 Rebased on top of v5.5
 Link: http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=133907

Changes since v4:
 Rebased on top of v5.4-rc1
 Declared real generic functions instead of dummies
 start_lockless_pgtbl_walk renamed to begin_lockless_pgtbl_walk
 Interrupt {dis,en}able is now inside of {begin,end}_lockless_pgtbl_walk
 Power implementation has option to not {dis,en}able interrupt
 More documentation inside the funtions.
 Some irq masks variables renamed
 Removed some proxy mm_structs
 Few typos fixed
 Link: http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=133015

Changes since v3:
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

Special thanks for:
Aneesh Kumar, Nick Piggin, Paul Mackerras, Michael Ellerman, Fabiano Rosas,
Dipankar Sarma and Oliver O'Halloran.


Leonardo Bras (11):
  asm-generic/pgtable: Adds generic functions to track lockless pgtable
    walks
  mm/gup: Use functions to track lockless pgtbl walks on gup_pgd_range
  powerpc/mm: Adds arch-specificic functions to track lockless pgtable
    walks
  powerpc/mce_power: Use functions to track lockless pgtbl walks
  powerpc/perf: Use functions to track lockless pgtbl walks
  powerpc/mm/book3s64/hash: Use functions to track lockless pgtbl walks
  powerpc/kvm/e500: Use functions to track lockless pgtbl walks
  powerpc/kvm/book3s_hv: Use functions to track lockless pgtbl walks
  powerpc/kvm/book3s_64: Use functions to track lockless pgtbl walks
  powerpc/mm: Adds counting method to track lockless pagetable walks
  powerpc/mm/book3s64/pgtable: Uses counting method to skip serializing

 arch/powerpc/include/asm/book3s/64/pgtable.h |   6 +
 arch/powerpc/kernel/mce_power.c              |   6 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c          |   6 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c       |  34 +++++-
 arch/powerpc/kvm/book3s_64_vio_hv.c          |   6 +-
 arch/powerpc/kvm/book3s_hv_nested.c          |  22 +++-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c          |  28 +++--
 arch/powerpc/kvm/e500_mmu_host.c             |   9 +-
 arch/powerpc/mm/book3s64/hash_tlb.c          |   6 +-
 arch/powerpc/mm/book3s64/hash_utils.c        |  27 +++--
 arch/powerpc/mm/book3s64/pgtable.c           | 120 ++++++++++++++++++-
 arch/powerpc/perf/callchain.c                |   6 +-
 include/asm-generic/pgtable.h                |  51 ++++++++
 mm/gup.c                                     |  10 +-
 14 files changed, 288 insertions(+), 49 deletions(-)

-- 
2.24.1

