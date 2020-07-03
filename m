Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5522C2131A0
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 04:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgGCChG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 22:37:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:33754 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgGCCgM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Jul 2020 22:36:12 -0400
IronPort-SDR: KwljBXzyFdfysrvl/vjJMHl0Tw4DuSrBsdJ20uONn0Ae5vwMwgQGiXuhN7LATtsQ7aUgJaDkVG
 1r4sCoDgx7QA==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="231938503"
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="231938503"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 19:36:06 -0700
IronPort-SDR: QGbjKkt+bOJe+qHbBpZ9whObSpvMd7Xamga0DRoq9+25x4ZtCSY5isivjtlyYDjcc8+1CT5yqM
 8vZpoJuYjv6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="278295789"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by orsmga003.jf.intel.com with ESMTP; 02 Jul 2020 19:36:06 -0700
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
Subject: [PATCH v3 20/21] KVM: MIPS: Account pages used for GPA page tables
Date:   Thu,  2 Jul 2020 19:35:44 -0700
Message-Id: <20200703023545.8771-21-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200703023545.8771-1-sean.j.christopherson@intel.com>
References: <20200703023545.8771-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use GFP_KERNEL_ACCOUNT instead of GFP_KERNEL when allocating pages for
the the GPA page tables.  The primary motivation for accounting the
allocations is to align with the common KVM memory cache helpers in
preparation for moving to the common implementation in a future patch.
The actual accounting is a bonus side effect.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/mips/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index d1f148db2449..9d3c8c025624 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -32,7 +32,7 @@ static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache, int min)
 	if (cache->nobjs >= min)
 		return 0;
 	while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
-		page = (void *)__get_free_page(GFP_KERNEL);
+		page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
 		if (!page)
 			return -ENOMEM;
 		cache->objects[cache->nobjs++] = page;
-- 
2.26.0

