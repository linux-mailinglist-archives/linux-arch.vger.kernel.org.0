Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FDA204148
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jun 2020 22:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgFVUJI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 16:09:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:60195 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728530AbgFVUJH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jun 2020 16:09:07 -0400
IronPort-SDR: LFVSAjT7u+N5vZPa59QDReV12rIKpjnkbs0ZPYtCAaByNwjoV647sWDA9DyO2iqQvLylDTOiKB
 iudShdzF19fg==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="123527692"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="123527692"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 13:09:05 -0700
IronPort-SDR: ACiGxnvdRH5yHzKRcBqEkHkrUW0Xmd5fP+wZakk5PUawdwmWwHSjFB8CI8ofv1H3JKPtVSPmv8
 o5YF/XigfYJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="318877033"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2020 13:09:05 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Christoffer Dall <christoffer.dall@arm.com>
Subject: [PATCH v2 00/21] KVM: Cleanup and unify kvm_mmu_memory_cache usage
Date:   Mon, 22 Jun 2020 13:08:01 -0700
Message-Id: <20200622200822.4426-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Note, patch 18 will conflict with the p4d rework in 5.8.  I originally
stated I would send v2 only after that got pulled into Paolo's tree, but
I got my timing wrong, i.e. I was thinking that would have already
happened.  I'll send v3 if necessary.  I wanted to get v2 out there now
that I actually compile tested other architectures.

Marc, I interpreted your "nothing caught fire" as Tested-by for the arm64
patches, let me know if that's not what you intended.


This series resurrects Christoffer Dall's series[1] to provide a common
MMU memory cache implementation that can be shared by x86, arm64 and MIPS.

It also picks up a suggested change from Ben Gardon[2] to clear shadow
page tables during initial allocation so as to avoid clearing entire
pages while holding mmu_lock.

The front half of the patches do house cleaning on x86's memory cache
implementation in preparation for moving it to common code, along with a
fair bit of cleanup on the usage.  The middle chunk moves the patches to
common KVM, and the last two chunks convert arm64 and MIPS to the common
implementation.

Fully tested on x86 only.  Compile tested patches 14-21 on arm64, MIPS,
s390 and PowerPC.

v2:
  - Rebase to kvm-5.8-2, commit 49b3deaad345 ("Merge tag ...").
  - Use an asm-generic kvm_types.h for s390 and PowerPC instead of an
    empty arch-specific file. [Marc]
  - Explicit document "GFP_PGTABLE_USER == GFP_KERNEL_ACCOUNT | GFP_ZERO"
    in the arm64 conversion patch. [Marc]
  - Collect review tags. [Ben]

[1] https://lkml.kernel.org/r/20191105110357.8607-1-christoffer.dall@arm
[2] https://lkml.kernel.org/r/20190926231824.149014-4-bgardon@google.com

Sean Christopherson (21):
  KVM: x86/mmu: Track the associated kmem_cache in the MMU caches
  KVM: x86/mmu: Consolidate "page" variant of memory cache helpers
  KVM: x86/mmu: Use consistent "mc" name for kvm_mmu_memory_cache locals
  KVM: x86/mmu: Remove superfluous gotos from mmu_topup_memory_caches()
  KVM: x86/mmu: Try to avoid crashing KVM if a MMU memory cache is empty
  KVM: x86/mmu: Move fast_page_fault() call above
    mmu_topup_memory_caches()
  KVM: x86/mmu: Topup memory caches after walking GVA->GPA
  KVM: x86/mmu: Clean up the gorilla math in mmu_topup_memory_caches()
  KVM: x86/mmu: Separate the memory caches for shadow pages and gfn
    arrays
  KVM: x86/mmu: Make __GFP_ZERO a property of the memory cache
  KVM: x86/mmu: Zero allocate shadow pages (outside of mmu_lock)
  KVM: x86/mmu: Skip filling the gfn cache for guaranteed direct MMU
    topups
  KVM: x86/mmu: Prepend "kvm_" to memory cache helpers that will be
    global
  KVM: Move x86's version of struct kvm_mmu_memory_cache to common code
  KVM: Move x86's MMU memory cache helpers to common KVM code
  KVM: arm64: Drop @max param from mmu_topup_memory_cache()
  KVM: arm64: Use common code's approach for __GFP_ZERO with memory
    caches
  KVM: arm64: Use common KVM implementation of MMU memory caches
  KVM: MIPS: Drop @max param from mmu_topup_memory_cache()
  KVM: MIPS: Account pages used for GPA page tables
  KVM: MIPS: Use common KVM implementation of MMU memory caches

 arch/arm64/include/asm/kvm_host.h  |  11 ---
 arch/arm64/include/asm/kvm_types.h |   8 ++
 arch/arm64/kvm/arm.c               |   2 +
 arch/arm64/kvm/mmu.c               |  54 +++---------
 arch/mips/include/asm/kvm_host.h   |  11 ---
 arch/mips/include/asm/kvm_types.h  |   7 ++
 arch/mips/kvm/mmu.c                |  44 ++--------
 arch/powerpc/include/asm/Kbuild    |   1 +
 arch/s390/include/asm/Kbuild       |   1 +
 arch/x86/include/asm/kvm_host.h    |  14 +---
 arch/x86/include/asm/kvm_types.h   |   7 ++
 arch/x86/kvm/mmu/mmu.c             | 129 +++++++++--------------------
 arch/x86/kvm/mmu/paging_tmpl.h     |  10 +--
 include/asm-generic/kvm_types.h    |   5 ++
 include/linux/kvm_host.h           |   7 ++
 include/linux/kvm_types.h          |  19 +++++
 virt/kvm/kvm_main.c                |  55 ++++++++++++
 17 files changed, 175 insertions(+), 210 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_types.h
 create mode 100644 arch/mips/include/asm/kvm_types.h
 create mode 100644 arch/x86/include/asm/kvm_types.h
 create mode 100644 include/asm-generic/kvm_types.h

-- 
2.26.0

