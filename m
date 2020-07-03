Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F6B21316E
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 04:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgGCCgM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 22:36:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:52028 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgGCCgK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Jul 2020 22:36:10 -0400
IronPort-SDR: S4C4ajm53aivNhhqhaScrjtzcrci02coWEbP5DD50mRg/dRt5sz3/ER09sWXucFWSFPy03yyYG
 PMTVwrK1oXsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="145213962"
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="145213962"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 19:36:05 -0700
IronPort-SDR: zcdMgz+OQMN1fZ0A3Ilh+aLb+Krky0UcRQFm4RjWau3Sh5LiP1g6ExtO2oDrmOwqPaGA7yK/wE
 zh08EsIFSNOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="278295728"
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
Subject: [PATCH v3 04/21] KVM: x86/mmu: Remove superfluous gotos from mmu_topup_memory_caches()
Date:   Thu,  2 Jul 2020 19:35:28 -0700
Message-Id: <20200703023545.8771-5-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200703023545.8771-1-sean.j.christopherson@intel.com>
References: <20200703023545.8771-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Return errors directly from mmu_topup_memory_caches() instead of
branching to a label that does the same.

No functional change intended.

Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b6df4525e86c..94b27adab6ba 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1100,13 +1100,11 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
 	r = mmu_topup_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache,
 				   8 + PTE_PREFETCH_NUM);
 	if (r)
-		goto out;
+		return r;
 	r = mmu_topup_memory_cache(&vcpu->arch.mmu_page_cache, 8);
 	if (r)
-		goto out;
-	r = mmu_topup_memory_cache(&vcpu->arch.mmu_page_header_cache, 4);
-out:
-	return r;
+		return r;
+	return mmu_topup_memory_cache(&vcpu->arch.mmu_page_header_cache, 4);
 }
 
 static void mmu_free_memory_caches(struct kvm_vcpu *vcpu)
-- 
2.26.0

