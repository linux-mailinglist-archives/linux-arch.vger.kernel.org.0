Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B477A39B7CC
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 13:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhFDLVg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 07:21:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230185AbhFDLVf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 07:21:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E0C661369;
        Fri,  4 Jun 2021 11:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622805589;
        bh=UxOvTvzvIffM4aLRyIgntP4GHd3vzv87L8DyM4UTxII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P8vLqTwzrd2KfXDJNK1Kw4j0FrG7X7R1ILz84XvMUgYJS2V/EZpS9JAHFjxWTxEg4
         OSwOd5+/u7xJZqAdUBDFMCLPMIfsaZ0cgTjy3IjgB9tvSCFdnA/Sh/8XTF32UfZjrA
         m0ABT2Cs3PcI06tB5kzkiaXg+0J2IUitlNjvSjkkJ3qhI5K9Dan3i1OnyzFdgGSPTm
         ZpE9jK7QDNFTIAcVvqtNjDEhsy8VAlxPKw+Z46y31kxftrl5KMxGSxqNl8gQ9JgcuN
         viM1RZnQ8DSZSCeLYjsumrdPDGSyoeBPV7BVwOcddCnRjKED1BrUWwm1EGYzS+xI1h
         6R7YK9GYjGvhw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/3] elf: Remove has_interp property from arch_adjust_elf_prot()
Date:   Fri,  4 Jun 2021 12:17:28 +0100
Message-Id: <20210604111728.12052-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210604111728.12052-1-broonie@kernel.org>
References: <20210604111728.12052-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2180; h=from:subject; bh=UxOvTvzvIffM4aLRyIgntP4GHd3vzv87L8DyM4UTxII=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBgugvGgxS2Ievr7XanpFMsUXQrjmHCG+84nNMfLRYx Xh+d8u+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYLoLxgAKCRAk1otyXVSH0EvGB/ 0SiN3dB15TvJjFGpyBYQOl4uvmqL4yoqy5xVxvly1OeoKESMck3T9qgBRQjj7Jl2a59iC1HY/ZUofS AHUFsO7ig4+IWBmVOPoaQ5C9+k4QTpHMTOEDp0t+KconcL4gH5Et08MGvAKu0QfUYUYfXYFNcS5EFp 33wzB5/bH7X2doVm/EkhzRjXn43Lm0PZtgly5DrD0yb/BsAWzgWnphhoTbqlkH691fC46ROH2wBKwG zDQ7HmEa3Zh7S22JUpIEIht0wEWvKGXTwMteJXNBLfvy03Ipj0ZciRere40AdDdcknzZ0hyQ4gGjU8 h0FzzQMAWnEm6vIG03qNmvx/pHTdSl
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since we have added an is_interp flag to arch_parse_elf_property() we can
drop the has_interp flag from arch_elf_adjust_prot(), the only user was
the arm64 code which no longer needs it and any future users will be able
to use arch_parse_elf_properties() to determine if an interpreter is in
use.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/process.c | 2 +-
 fs/binfmt_elf.c             | 2 +-
 include/linux/elf.h         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index f7fff4a4c99f..e51c4aa7e048 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -742,7 +742,7 @@ asmlinkage void __sched arm64_preempt_schedule_irq(void)
 
 #ifdef CONFIG_BINFMT_ELF
 int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
-			 bool has_interp, bool is_interp)
+			 bool is_interp)
 {
 	if (prot & PROT_EXEC) {
 		if (state->flags & ARM64_ELF_INTERP_BTI && is_interp)
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 253ca9969345..1aba4e50e651 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -580,7 +580,7 @@ static inline int make_prot(u32 p_flags, struct arch_elf_state *arch_state,
 	if (p_flags & PF_X)
 		prot |= PROT_EXEC;
 
-	return arch_elf_adjust_prot(prot, arch_state, has_interp, is_interp);
+	return arch_elf_adjust_prot(prot, arch_state, is_interp);
 }
 
 /* This is much more generalized than the library routine read function,
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 1c45ecf29147..d8392531899d 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -101,11 +101,11 @@ extern int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
 
 #ifdef CONFIG_ARCH_HAVE_ELF_PROT
 int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
-			 bool has_interp, bool is_interp);
+			 bool is_interp);
 #else
 static inline int arch_elf_adjust_prot(int prot,
 				       const struct arch_elf_state *state,
-				       bool has_interp, bool is_interp)
+				       bool is_interp)
 {
 	return prot;
 }
-- 
2.20.1

