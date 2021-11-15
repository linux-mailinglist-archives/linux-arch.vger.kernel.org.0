Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE2D450843
	for <lists+linux-arch@lfdr.de>; Mon, 15 Nov 2021 16:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbhKOPad (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Nov 2021 10:30:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236406AbhKOPa1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Nov 2021 10:30:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DC62611BF;
        Mon, 15 Nov 2021 15:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636990051;
        bh=GkbSUMJynz7Bx8HL2TE9a1peCJ/6Qo6Zhpd4AQYMJXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KxAG6e7FAqrLgrANb7snYr4mOncJ2lkNcqKCfo6efIkuLTomO04a3G4ZLVJTuDNRI
         7ezT0IKoXiAdRivM6aCkYA5zyCiFiIACrwzBfMfIJTiSlRRvYs837AjOH3GANz9/EZ
         HExF+rR4L7I7DXufAe85xQGLJSslsqAI3KCVDuEbLVqQSP8XNQ3DfWGpkl3vYzF1Se
         NhCq4CkoSjpd4XduGlQJLv/UDz2tf4eKgqt7HXsPC68Z5tL8kushliBL+CXUQlbu6G
         PPJz5Qg7vwEpcWyQsyMDE2ONr/dyukLg+OA3sjOAgBQhwPSPF8Te7c2uVWi1vjgLa5
         z5+kRLd48TwLw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v7 3/4] elf: Remove has_interp property from arch_adjust_elf_prot()
Date:   Mon, 15 Nov 2021 15:27:13 +0000
Message-Id: <20211115152714.3205552-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115152714.3205552-1-broonie@kernel.org>
References: <20211115152714.3205552-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2253; h=from:subject; bh=GkbSUMJynz7Bx8HL2TE9a1peCJ/6Qo6Zhpd4AQYMJXk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhknxNqYR5Ysewq6ZAI+mEpzaWcN1DlHnUbQ2oum5I 3+0HdzaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYZJ8TQAKCRAk1otyXVSH0PyTB/ 9fl96mKXkBId+KI5F5xqTb4BAshxRUjLuSNU4ohURefbNSvFlbfVofDYH8tLVegZTBjtpxvV6OdH01 gzY94cpEKCgqcQ1j0a9nq2Ph/3qVF/J83fUYzyZbSApMhBmKe3rgFFkxwTejkgs2y5LDWZWrhBIAH+ MI/99VTlPjxqzuT8wzf7Uk1tltomzv01rQD98l4wtQgcUqte/LzUTMOSAix5+I3hmqz9vC/ICdJSUj QpbtS5sOl6iFJuCy67wadcPz6NaG4SL3XdA56L+P8vdsYS7BjhcERCs30W+FZtkbt6WL6HxBY/HnXW GA2sD34FK5DTG3RT1Eui8CMDzo0gm1
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
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-By: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/process.c | 2 +-
 fs/binfmt_elf.c             | 2 +-
 include/linux/elf.h         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index a6b6b587cab9..4e42ccc9ae6d 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -700,7 +700,7 @@ core_initcall(tagged_addr_init);
 
 #ifdef CONFIG_BINFMT_ELF
 int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
-			 bool has_interp, bool is_interp)
+			 bool is_interp)
 {
 	if ((prot & PROT_EXEC) &&
 	    (state->flags & arm64_elf_bti_flag(is_interp)))
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index fb9c24a63c62..50f04e19a714 100644
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
2.30.2

