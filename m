Return-Path: <linux-arch+bounces-15330-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD20ECB4168
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 22:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A78193040664
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 21:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A724F30EF6F;
	Wed, 10 Dec 2025 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKbAmi+D"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E042FE05B;
	Wed, 10 Dec 2025 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765403211; cv=none; b=gp1szL8B7MOEo8xph9lOzNlY/VplJ8kgiJue54TsBuTc6jyrPza1iNdRM5+kioVXepuGBRkOwkG4cSBopbBJ2pDLco5t1jak7YK2cH6r6iMKrUWb3qcYGJwI7nKslWBZuz08kiDfrCkRGtgpRF3xJlhdRYykhyzMmac5rcTvs+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765403211; c=relaxed/simple;
	bh=hwGvxkycgInnBcfmnido91xGEq1JUTq30fabuC6haYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qBnrRnRGHt1dXD3BAD2PpBHo2sYF4dQciiVh87X8gPjQbDDlesyCpd6lvkZvT4h+5KDDeoZww1mEShZ15jFcMnMFl35CveE5Ns/IRpcx1hnE1n/Syj4sEFVlhOMJIh5c2+sZOdNJLea++CjCwPn/TaYckzftwvHZnrZ1HMvDW68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKbAmi+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7C7C4CEF1;
	Wed, 10 Dec 2025 21:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765403210;
	bh=hwGvxkycgInnBcfmnido91xGEq1JUTq30fabuC6haYk=;
	h=From:To:Cc:Subject:Date:From;
	b=tKbAmi+D4XWCB7H/IEgS1ZYujggqzxF/AGh4bOIsS1fEkYHuJr0BOap5sWFxU0YBM
	 JpPK/LeSdi0p1a2cnBVXEDqnSH0E4DhszlNCDNyMjbutBsO/gZ8Q2EJGGzCxxWa3kZ
	 ijzvK9FlNnvpdKkQaG08II8tK0xKnxYcTa+nGVNyOrQqCVeVdFfd35mVnuNhlWhVgE
	 SzqnNPgodfyRaK4itv02yqWK/F0ffEQUs5u4O10ezhOpvvJBwRNZYNvhIVu4oFoOLD
	 tVYw7K0OuL3TbtXJ8s2U0PYedSqQ9F8XKcjc+8ANCyXcZtPR+UxF7NaUvxLoEDlnfD
	 vPF5A3ks99Ztw==
From: wei.liu@kernel.org
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Anatol Belski <anbelski@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH] mshv: Move function prototypes to the generic header
Date: Wed, 10 Dec 2025 21:46:24 +0000
Message-ID: <20251210214625.3114545-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Liu <wei.liu@kernel.org>

The same code is built on both x86 and ARM64 architectures. This fixes
two missing prototype warnings when building on ARM64.

This only eliminates the warnings. Making things work on ARM64 requires
more work.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Fixes: 615a6e7d83f9 ("mshv: Cleanly shutdown root partition with MSHV")
Fixes: f0be2600ac55 ("mshv: Use reboot notifier to configure sleep state")
Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/include/asm/mshyperv.h | 2 --
 include/asm-generic/mshyperv.h  | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index eef4c3a5ba28..10037125099a 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -177,8 +177,6 @@ int hyperv_flush_guest_mapping_range(u64 as,
 int hyperv_fill_flush_guest_mapping_list(
 		struct hv_guest_mapping_flush_list *flush,
 		u64 start_gfn, u64 end_gfn);
-void hv_sleep_notifiers_register(void);
-void hv_machine_power_off(void);
 
 #ifdef CONFIG_X86_64
 void hv_apic_init(void);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index ecedab554c80..d4eded472db7 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -316,6 +316,8 @@ void hv_para_set_synic_register(unsigned int reg, u64 val);
 void hyperv_cleanup(void);
 bool hv_query_ext_cap(u64 cap_query);
 void hv_setup_dma_ops(struct device *dev, bool coherent);
+void hv_sleep_notifiers_register(void);
+void hv_machine_power_off(void);
 #else /* CONFIG_HYPERV */
 static inline void hv_identify_partition_type(void) {}
 static inline bool hv_is_hyperv_initialized(void) { return false; }
-- 
2.43.0


