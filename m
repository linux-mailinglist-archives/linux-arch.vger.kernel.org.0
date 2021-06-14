Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F3C3A71F6
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 00:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhFNWfQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 18:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229781AbhFNWfP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Jun 2021 18:35:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02B52611CE;
        Mon, 14 Jun 2021 22:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623709992;
        bh=fCxAxBsrdCysAQR8O0YHtW9cXxwUrKw65hU1mQ0qWk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MJA72SOIQ01jNlRC27EKVdasYKprLJOrD1tzu4aQ6r4GenG2ayV26NYRWeyKdkzKe
         DYHyYHRcXFQBZSNZ3bs18397h3Hy3pl9+Gt+3gYmxmGlRrwze+ou7PWEFrT9Qu2kLV
         QaMkl8lPvnsFxlizQtPtpuF9MnIVEp/Lp6GWNjnvND9x2ZmHmD74trzwRt4TMD9fb5
         cHcosRyz8CIogWD/6CeGOyx6g33s77dCLMfHvc/B5DI+TgfgZZ7rrwkjj2bHVWUAik
         2ZHsx7zZ9RyS60tBHW68HKOWxelcmMNHs/RdvNrWvlxUkPjVXCin7UDtcWds1wDV34
         4utHSLiqHKukg==
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
Subject: [PATCH v3 3/4] elf: Remove has_interp property from arch_adjust_elf_prot()
Date:   Mon, 14 Jun 2021 23:32:13 +0100
Message-Id: <20210614223214.39011-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210614223214.39011-1-broonie@kernel.org>
References: <20210614223214.39011-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2151; h=from:subject; bh=fCxAxBsrdCysAQR8O0YHtW9cXxwUrKw65hU1mQ0qWk0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBgx9jscT/tjOsyDA4fqAk63t8+zhdRqo/okAQGtBab 6GkwKRSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYMfY7AAKCRAk1otyXVSH0Fv8B/ 9n4MxOkwE08+s1KuYDbXW8HmGkcSrRsnbokMnx4O6yqCfYunlNP76yiYDisbWcziywvhtxfnNfd3pG MYFI38kzyTwwFnUI+avkO91uGTO1ywrvkZ67dJ+h+cfIK/FJDWy5v3ZGvmeAIZPwqUgtZ16HDp75PD ckdcB5aWS9v8nFz5mMJYUPBcpX7ZqmkNSqJlwoJ3qc4gx4jqYMKuh6PDucY6ZsCa7Qnu/8Qfig+4jL DYu83xz4morL6efeTNRbXvgPcD+gECGDAck4Ty62ZNxVeqK7yKCoilNmzgWQh3cKmFaW/tE9e3ED08 05qalJGq9fFljHagQoBM6gIFC4qGSB
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
index 21f1f0997c43..2b952593534a 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -751,7 +751,7 @@ static inline int arm64_elf_bti_flag(bool is_interp)
 
 
 int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
-			 bool has_interp, bool is_interp)
+			 bool is_interp)
 {
 	if ((prot & PROT_EXEC) &&
 	    (state->flags & arm64_elf_bti_flag(is_interp)))
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index c0d4f35c80f6..ffe38d54308b 100644
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

