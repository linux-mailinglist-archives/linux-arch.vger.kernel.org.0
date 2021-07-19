Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1743CE68E
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jul 2021 19:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349180AbhGSQIG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Jul 2021 12:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343571AbhGSQGC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Jul 2021 12:06:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EFB461245;
        Mon, 19 Jul 2021 16:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626713177;
        bh=Ct5yJFpFuVch2Ey0mQXeG/FiXFyh3RZPLWGYibJt980=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AfflMMWnn2ex5PAa9CVOQaS1BT1hDySvqJToxJpmdp39e3hn9NgVQSv/Np8DRiiCY
         2sq1GiZPBPuCKz+JM0iy1I7L4rqnPWHFOmJMLWIq0XCbbnPA7t0Z20pC7G9+sksZYz
         3WUYm60O4RvW2jeVEDPzOmVRopl5x81/CgEiQSyI0Z1JH0BfJ4k68t+U8XyXbb6qgm
         NZSMk6F/6+zijkRU+P3mixIqmtB2QVX2I63o1gxs1l5FbNsFm+56k22OoXfYhuNACT
         gDxcUM54bGp95HJa5iR/pnjqmVqkcmSRQNvJLB3Gsinx3pSq6CzRwkImBvX9L8hLcS
         BqE4ut7dguHOQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v5 3/4] elf: Remove has_interp property from arch_adjust_elf_prot()
Date:   Mon, 19 Jul 2021 17:45:35 +0100
Message-Id: <20210719164536.19143-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210719164536.19143-1-broonie@kernel.org>
References: <20210719164536.19143-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2253; h=from:subject; bh=Ct5yJFpFuVch2Ey0mQXeG/FiXFyh3RZPLWGYibJt980=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBg9awux0UYSgSoCn8xj5dLcWfxWqQX2Eru7YRJBEh1 3DMw5I+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYPWsLgAKCRAk1otyXVSH0O1ZB/ 96l6r7AMYYfDzNEc+gZqOkAUWQGyzAo7IhbjpMxYpk3PFHt8GNGw+371TGtW814kATkSz2OdLSQAKw QNsIByYWi96HV8Es4j53IBIptN40vg1x2OUrzc7FDTLAvsmedf2pGErGrJZFf3DeYYWliKnpFmvHFn sL1o78pOS2IaiGLCrZO4MXwLu2uE7+s1cgoxNQtwU/8hU2/80tlRu5fRe/txj41xeqy7sHCylYAI3P QY7nxAKk1MdSUmwRVs17EmatlY66Du9Nrytuoebxbm0Jm6sYsx8M7K+DeldgYpBFYDxHd0wg2yVdFJ Au5m7z9OPStNdSNQOAmcgqaGiLXlLZ
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
index 2645bc79b35e..14478c5b52d3 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -684,7 +684,7 @@ core_initcall(tagged_addr_init);
 
 #ifdef CONFIG_BINFMT_ELF
 int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
-			 bool has_interp, bool is_interp)
+			 bool is_interp)
 {
 	if ((prot & PROT_EXEC) &&
 	    (state->flags & arm64_elf_bti_flag(is_interp)))
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 28eaf36f145b..4f3bea1a697c 100644
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

