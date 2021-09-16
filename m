Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD8440DDFF
	for <lists+linux-arch@lfdr.de>; Thu, 16 Sep 2021 17:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbhIPPcE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Sep 2021 11:32:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239052AbhIPPcC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Sep 2021 11:32:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54B4D60D07;
        Thu, 16 Sep 2021 15:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631806241;
        bh=0WiuvBGy0FCv218eBSBDpuWa1NLjyOxD+O0a/KAdG7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=az1HCBsXc5Eogu1ETb3Au4Ec38bQ/pvkKlVDIlquMDuGEX8P1/uwL1wH0UzitnV1m
         MF8NMD+lIbs/746CCZkNn9B0Wr4ry64No8ILseva6ArUIh4H+aXgGQHowrM9slNqe4
         Enur0T295swxPj/DpTVxUaJS3JhkOnJ2WdUTLPcow485M588C5XXBdpi1v6R90f9IP
         L801h0xTws64mB3R4yqwbfUJkD3oITtTicIEM4a9Gj4tBczM1ILpLwE6Xhfy/Oa0MW
         Tv2vnFVzfp5eDENo6WbcQrpIEYZTm+Wm22PoAOG1jF+ugQhnBGWiVPK/9je0TJpI9T
         hyfRRfnxV0MWw==
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
Subject: [PATCH v6 3/4] elf: Remove has_interp property from arch_adjust_elf_prot()
Date:   Thu, 16 Sep 2021 16:28:20 +0100
Message-Id: <20210916152821.1153-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916152821.1153-1-broonie@kernel.org>
References: <20210916152821.1153-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2253; h=from:subject; bh=0WiuvBGy0FCv218eBSBDpuWa1NLjyOxD+O0a/KAdG7E=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhQ2KTYNVM86Sg0NXiXwfrxqYJhVUYPNrNtqnriA2v OgaW2VWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUNikwAKCRAk1otyXVSH0O1kB/ sGPz/TBzZF9L2fCrxBX8dxeRo/2cUGMXYXGK/paNGbiBTPcnxxpdbaQNDocCfKbI6kqA/BFzHVNBxz BYapgKar6qFTWyYqFA6vz5UO+q8W5GlAIzz+gz/sV5838w5AYkFz3muKA6VacswCIq6LTN4G8StPAC GAnf8Pci0kvnrJBjf6F3b1PjZEUlx51BUiRG5qMwc3yR/iMMQzNfqtCF8zb8yl6JEofRgnxHfT8MpC D7om/zh3IHWWduHIdnq5Tpy/0S36dctxGYPUJJsXfpCqkyiAZHJEDJiV+LykTs4vYZytdagn/CNls3 KbR+1fjCuDB6qK+aXX/inmsnP4sKB6
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
index 1aecb20facd5..28b1742c625a 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -703,7 +703,7 @@ core_initcall(tagged_addr_init);
 
 #ifdef CONFIG_BINFMT_ELF
 int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
-			 bool has_interp, bool is_interp)
+			 bool is_interp)
 {
 	if ((prot & PROT_EXEC) &&
 	    (state->flags & arm64_elf_bti_flag(is_interp)))
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 1b2d0fc87ad4..5d24aa203b61 100644
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

