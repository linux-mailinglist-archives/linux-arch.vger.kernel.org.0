Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AD8213195
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 04:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgGCCgN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 22:36:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:3196 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgGCCgM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Jul 2020 22:36:12 -0400
IronPort-SDR: VnRI7GFa1XZ7ODJ2lTtfaKnwyB5BpqI3c1L/vTAi4PWIdAt7KtuwYyPqzpjDxvvRCg7mrnmezp
 HSa/tFJTgQNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="148599912"
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="148599912"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 19:36:05 -0700
IronPort-SDR: XdIN9NQJFVZj4Lj0Z3aHp73v90PyX3wNLf3ZoJ+SNtRZmC0glZKt5ckUj0gZCY179Ot8dOSmgp
 V9uPDaKGYrGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="278295751"
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
Subject: [PATCH v3 11/21] KVM: x86/mmu: Zero allocate shadow pages (outside of mmu_lock)
Date:   Thu,  2 Jul 2020 19:35:35 -0700
Message-Id: <20200703023545.8771-12-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200703023545.8771-1-sean.j.christopherson@intel.com>
References: <20200703023545.8771-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Set __GFP_ZERO for the shadow page memory cache and drop the explicit
clear_page() from kvm_mmu_get_page().  This moves the cost of zeroing a
page to the allocation time of the physical page, i.e. when topping up
the memory caches, and thus avoids having to zero out an entire page
while holding mmu_lock.

Cc: Peter Feiner <pfeiner@google.com>
Cc: Peter Shier <pshier@google.com>
Cc: Junaid Shahid <junaids@google.com>
Cc: Jim Mattson <jmattson@google.com>
Suggested-by: Ben Gardon <bgardon@google.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ed36f5e63863..60b0d460bbf5 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2545,7 +2545,6 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 		if (level > PG_LEVEL_4K && need_sync)
 			flush |= kvm_sync_pages(vcpu, gfn, &invalid_list);
 	}
-	clear_page(sp->spt);
 	trace_kvm_mmu_get_page(sp, true);
 
 	kvm_mmu_flush_or_zap(vcpu, &invalid_list, false, flush);
@@ -5682,6 +5681,8 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmu_page_header_cache.kmem_cache = mmu_page_header_cache;
 	vcpu->arch.mmu_page_header_cache.gfp_zero = __GFP_ZERO;
 
+	vcpu->arch.mmu_shadow_page_cache.gfp_zero = __GFP_ZERO;
+
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
 	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
 
-- 
2.26.0

