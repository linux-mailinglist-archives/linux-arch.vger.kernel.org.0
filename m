Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA903C5BD0
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jul 2021 14:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhGLMAJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jul 2021 08:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234734AbhGLL75 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Jul 2021 07:59:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D370D610FA;
        Mon, 12 Jul 2021 11:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626091023;
        bh=0PVRAiIVFXwrk529T6zZio39WXArOzJh/GaiFzszgPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h1gtRy0DbQf7iGMT5hqjBGg5ndaH0lqDYjTHh+MQ3e8BcWAvS8nyO97nhOgLq0UA2
         oCXmsXWfPLRAb4Lq36zSttw9RJs966RlgER+OrdvQpzXZnWz54l0OzCNImWNs/N+++
         TBz7cGZe+WB9dKvWuolSoTAX0/b/9tA106xPjr4W+zYoEMj95SHjZsI1CcCkHxgXO1
         QoYHNXrdCxmgu4H1mLG0/rkthLbVtMsM8R9SLhj+YI+7wlpcBXq1+cZAXZGxVAvpGE
         UYMWmJwH2QukhW96lJGAjibIUr0RcFPrABDh+yZSyxDgf7NSR5tCITNhwI8RvZ9luR
         91G8xmui8ZXUQ==
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
Subject: [PATCH v4 3/4] elf: Remove has_interp property from arch_adjust_elf_prot()
Date:   Mon, 12 Jul 2021 12:52:58 +0100
Message-Id: <20210712115259.29547-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210712115259.29547-1-broonie@kernel.org>
References: <20210712115259.29547-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2201; h=from:subject; bh=0PVRAiIVFXwrk529T6zZio39WXArOzJh/GaiFzszgPk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBg7C0ZJqtyIrQZvfLbNjD1faP5V5P6s+d30mGjMiD4 ZRslk6iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYOwtGQAKCRAk1otyXVSH0HtbB/ 9+NTXF2e4490xsPvXtNvMV3+rjCPaIPEcHFkIpKGj1Lbb/CEu0KDzuLfsG1IkBQLQnmtM4CL2ZQE9j Q9afvJpCR3yL1XMJb9vqFKCtHexb+EZb+6nabKCrq5RMZ5tC74HhOyVSmNeAF+82jP8pQdsKsViYbB jQPXNh1yajyrFudhPG4gChZ+TbNcEOklWL1qE4XOas3QobGa+mhbxmzEDVZsHIYRgqWasDlNM3vwiq isgDntqgumD5QlvMiTN4OmnRGsRij/qUvqOfmP1EHlMV7Pmv20EqsV/55OOo6wsbYVzDNkBShfWi5Z I0W1cJYNZ8spfFYyyIUzyrN6n4C6Wt
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
---
 arch/arm64/kernel/process.c | 2 +-
 fs/binfmt_elf.c             | 2 +-
 include/linux/elf.h         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 5a6c3b198bd3..992d827b37b0 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -693,7 +693,7 @@ static inline int arm64_elf_bti_flag(bool is_interp)
 
 
 int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
-			 bool has_interp, bool is_interp)
+			 bool is_interp)
 {
 	if ((prot & PROT_EXEC) &&
 	    (state->flags & arm64_elf_bti_flag(is_interp)))
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 81e151a57df2..ae8094d42480 100644
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

