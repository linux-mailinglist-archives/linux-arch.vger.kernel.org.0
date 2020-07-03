Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8932131B9
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 04:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgGCChk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 22:37:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:3198 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgGCCgL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Jul 2020 22:36:11 -0400
IronPort-SDR: ch9vpaOA7tFSHpw3KvZ68/aiR52yDthVYqiCCMe1k7oXdFzdaIvwiTSBE1/GeeWptQZtWIq/Gn
 qCpmzwEJqHVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="148599909"
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="148599909"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 19:36:05 -0700
IronPort-SDR: E3vypcr1UHRJqakxDgoBr58jDpcQmlRMfb1U5DuUgEAlMoYf7lMkUilhIuaj1egVk5+UO1AqEb
 bTYFXGcw0SBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="278295741"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by orsmga003.jf.intel.com with ESMTP; 02 Jul 2020 19:36:05 -0700
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
Subject: [PATCH v3 08/21] KVM: x86/mmu: Clean up the gorilla math in mmu_topup_memory_caches()
Date:   Thu,  2 Jul 2020 19:35:32 -0700
Message-Id: <20200703023545.8771-9-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200703023545.8771-1-sean.j.christopherson@intel.com>
References: <20200703023545.8771-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Clean up the minimums in mmu_topup_memory_caches() to document the
driving mechanisms behind the minimums.  Now that encountering an empty
cache is unlikely to trigger BUG_ON(), it is less dangerous to be more
precise when defining the minimums.

For rmaps, the logic is 1 parent PTE per level, plus a single rmap, and
prefetched rmaps.  The extra objects in the current '8 + PREFETCH'
minimum came about due to an abundance of paranoia in commit
c41ef344de212 ("KVM: MMU: increase per-vcpu rmap cache alloc size"),
i.e. it could have increased the minimum to 2 rmaps.  Furthermore, the
unexpected extra rmap case was killed off entirely by commits
f759e2b4c728c ("KVM: MMU: avoid pte_list_desc running out in
kvm_mmu_pte_write") and f5a1e9f89504f ("KVM: MMU: remove call to
kvm_mmu_pte_write from walk_addr").

For the so called page cache, replace '8' with 2*PT64_ROOT_MAX_LEVEL.
The 2x multiplier is needed because the cache is used for both shadow
pages and gfn arrays for indirect MMUs.

And finally, for page headers, replace '4' with PT64_ROOT_MAX_LEVEL.

Note, KVM now supports 5-level paging, i.e. the old minimums that used a
baseline derived from 4-level paging were technically wrong.  But, KVM
always allocates roots in a separate flow, e.g. it's impossible in the
current implementation to actually need 5 new shadow pages in a single
flow.  Use PT64_ROOT_MAX_LEVEL unmodified instead of subtracting 1, as
the direct usage is likely more intuitive to uninformed readers, and the
inflated minimum is unlikely to affect functionality in practice.

Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 3d0768e16463..cf02ad93c249 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1103,14 +1103,17 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
 {
 	int r;
 
+	/* 1 rmap, 1 parent PTE per level, and the prefetched rmaps. */
 	r = mmu_topup_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache,
-				   8 + PTE_PREFETCH_NUM);
+				   1 + PT64_ROOT_MAX_LEVEL + PTE_PREFETCH_NUM);
 	if (r)
 		return r;
-	r = mmu_topup_memory_cache(&vcpu->arch.mmu_page_cache, 8);
+	r = mmu_topup_memory_cache(&vcpu->arch.mmu_page_cache,
+				   2 * PT64_ROOT_MAX_LEVEL);
 	if (r)
 		return r;
-	return mmu_topup_memory_cache(&vcpu->arch.mmu_page_header_cache, 4);
+	return mmu_topup_memory_cache(&vcpu->arch.mmu_page_header_cache,
+				      PT64_ROOT_MAX_LEVEL);
 }
 
 static void mmu_free_memory_caches(struct kvm_vcpu *vcpu)
-- 
2.26.0

