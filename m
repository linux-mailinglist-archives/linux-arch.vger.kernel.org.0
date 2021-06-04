Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D0D39B7D7
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 13:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhFDL06 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 07:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhFDL05 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 07:26:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41339613FF;
        Fri,  4 Jun 2021 11:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622805911;
        bh=UxOvTvzvIffM4aLRyIgntP4GHd3vzv87L8DyM4UTxII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DLfAh/bKBWSBc3lE0JPsgqDiusChS0QEcLZjUQskbtnav2JxKnaHnupO9qDqUVAOz
         yq19b8/ZAxB/7M9K1JBPxEyc4VfU5G3MSSahl+fElTEhpkfic59sQlfFBK1wBRTe0i
         TSLdJE56gob+klDrLIZICJGUPxMoG1r9NJRVKSat/T1qBcwZBtetP79UnO1Br2pGtF
         Woo/PQiXYEe7yUs3PWE5PbFcgcqCXlKGXIEN+nluI2CP1ahBkjlSbi0HQk0MODN/va
         kE4Us7E0z+yvtKxDV0MVGncSsDoWSvLsv9Mwi/6BCVo1IYT1dCEQCxSxN+ox6ccHVR
         ieihG/xuqABVg==
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
Subject: [PATCH v2 3/3] elf: Remove has_interp property from arch_adjust_elf_prot()
Date:   Fri,  4 Jun 2021 12:24:50 +0100
Message-Id: <20210604112450.13344-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210604112450.13344-1-broonie@kernel.org>
References: <20210604112450.13344-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2180; h=from:subject; bh=UxOvTvzvIffM4aLRyIgntP4GHd3vzv87L8DyM4UTxII=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBgug2BgxS2Ievr7XanpFMsUXQrjmHCG+84nNMfLRYx Xh+d8u+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYLoNgQAKCRAk1otyXVSH0JOgB/ 9gSX3h4L1rbeHyMEUIx4FuJJP10LmDvtqTHlDa3ok6dufuQOig5tXRKx0+8cd0QPGpm2pm9JMRRsMP fLgtTEGwRCa10ayjCI2r3AKeR/CxOzabq0CvvC0Ca9+CBv+MosvW+1MpcATlQeHtQTV64jhQos6I7i rmXnzQQNYKN1P2PbpedLGfW+Id8HmK6Pt1PlBlHcT/TS22JQdG8inhvsnpRczixuFPhWQgY9DTHqSz 7hYkD4f7zR50FqLzwMFsjTmjwNTvxjjkKv1Kxbmk3aUqDI4KU/VTSXzBraK7XtmY5nsq/GYzBcAiKm rk2kpCN7+mZQ/2ZPxRtP+f3QW2iwq6
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

