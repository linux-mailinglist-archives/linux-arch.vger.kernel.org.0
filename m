Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15873E29A2
	for <lists+linux-arch@lfdr.de>; Fri,  6 Aug 2021 13:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242905AbhHFLbq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Aug 2021 07:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242813AbhHFLbp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Aug 2021 07:31:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 593FB61058;
        Fri,  6 Aug 2021 11:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628249489;
        bh=5NQN7uGLAAQxZwXl2h2sRA+r5PlFi6czNdWb7Ldo0CU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nj2fwVLS/etY4Lsdgf4m0PUn2NfmLHD0YQ6fnapugiyDw3izp6RC4KBDavpoenBG/
         Gw9RkCNqMcN9WFc7i/KQie2pPZiC7qO84ipye39uURApw4od+viZTk4z6ysGMlDCvk
         UVUWv5L/0MuYVO5+6SFSPxt6msfyVhDa/Wr1YhINJMx6eVB3tQIYNyVZmemZcwQUvF
         wRGjK6RpHpVseLfWwTvgeq0u/Lg00YwcQ3ObwlBf50Ku2We7tey3LkEUkJ9X0CXKrK
         rRdeTjcA0uf949aDf0Jw/S5xhtqxJ5HGCi6iPKh24QE7+C/xbavxo0d1p8W1+9STlC
         TLUlq9O3ut5eQ==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Jade Alglave <jade.alglave@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org
Subject: [PATCH 3/4] KVM: arm64: Convert the host S2 over to __load_guest_stage2()
Date:   Fri,  6 Aug 2021 12:31:07 +0100
Message-Id: <20210806113109.2475-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210806113109.2475-1-will@kernel.org>
References: <20210806113109.2475-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

The protected mode relies on a separate helper to load the
S2 context. Move over to the __load_guest_stage2() helper
instead.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jade Alglave <jade.alglave@arm.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kvm_mmu.h              | 11 +++--------
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         |  2 +-
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 05e089653a1a..934ef0deff9f 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -267,9 +267,10 @@ static __always_inline u64 kvm_get_vttbr(struct kvm_s2_mmu *mmu)
  * Must be called from hyp code running at EL2 with an updated VTTBR
  * and interrupts disabled.
  */
-static __always_inline void __load_stage2(struct kvm_s2_mmu *mmu, unsigned long vtcr)
+static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu,
+						struct kvm_arch *arch)
 {
-	write_sysreg(vtcr, vtcr_el2);
+	write_sysreg(arch->vtcr, vtcr_el2);
 	write_sysreg(kvm_get_vttbr(mmu), vttbr_el2);
 
 	/*
@@ -280,12 +281,6 @@ static __always_inline void __load_stage2(struct kvm_s2_mmu *mmu, unsigned long
 	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
 }
 
-static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu,
-						struct kvm_arch *arch)
-{
-	__load_stage2(mmu, arch->vtcr);
-}
-
 static inline struct kvm *kvm_s2_mmu_to_kvm(struct kvm_s2_mmu *mmu)
 {
 	return container_of(mmu->arch, struct kvm, arch);
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 9c227d87c36d..a910648bc71b 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -29,7 +29,7 @@ void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt);
 static __always_inline void __load_host_stage2(void)
 {
 	if (static_branch_likely(&kvm_protected_mode_initialized))
-		__load_stage2(&host_kvm.arch.mmu, host_kvm.arch.vtcr);
+		__load_guest_stage2(&host_kvm.arch.mmu, &host_kvm.arch);
 	else
 		write_sysreg(0, vttbr_el2);
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index d938ce95d3bd..d4e74ca7f876 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -126,7 +126,7 @@ int __pkvm_prot_finalize(void)
 	kvm_flush_dcache_to_poc(params, sizeof(*params));
 
 	write_sysreg(params->hcr_el2, hcr_el2);
-	__load_stage2(&host_kvm.arch.mmu, host_kvm.arch.vtcr);
+	__load_guest_stage2(&host_kvm.arch.mmu, &host_kvm.arch);
 
 	/*
 	 * Make sure to have an ISB before the TLB maintenance below but only
-- 
2.32.0.605.g8dce9f2422-goog

