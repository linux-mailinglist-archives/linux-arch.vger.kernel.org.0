Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A38E450844
	for <lists+linux-arch@lfdr.de>; Mon, 15 Nov 2021 16:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbhKOPae (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Nov 2021 10:30:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232140AbhKOPa3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Nov 2021 10:30:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1632161501;
        Mon, 15 Nov 2021 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636990054;
        bh=JvHm96Bwc3ZIt2gRYk+nYHq6lARloHLCepI/y4PjMto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZAxfF1pMhrwhr1mwPzsjZEeapfKLMVMowEkLY/zp0+fPZ3kOp511XlxVgpl+/ZDRp
         RqsCIgpl89WER2S4HunlRvqJ9YrDtUh/q0SUudEJJaEntmg15gr4uBHIDQvyYCUjjC
         sh+Q2Ty3VikhcFAQoFvO21ZlYA9S69grVgQUmtHzgl2Afsoo+TOSJUxmNDJB6IXpJt
         8SgOr9SwGOA6c88wdx7EO3N69mqrgnYn2c6OJPDPrYJqvJr6kIv9CqMA+5ZOreHrn9
         WbnK+81jmPnCh00IKTJcwFOHhd5HU8X+puiUqkmCpBu49aQGG/rzmevgMRZo+nfYZ8
         T4Busnc8YbmFw==
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
Subject: [PATCH v7 4/4] elf: Remove has_interp property from arch_parse_elf_property()
Date:   Mon, 15 Nov 2021 15:27:14 +0000
Message-Id: <20211115152714.3205552-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115152714.3205552-1-broonie@kernel.org>
References: <20211115152714.3205552-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2173; h=from:subject; bh=JvHm96Bwc3ZIt2gRYk+nYHq6lARloHLCepI/y4PjMto=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhknxOITIuBvpKgQvNCcXX3JJFXb41Z8PEQBoMT4ox iY8VsVGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYZJ8TgAKCRAk1otyXVSH0Gm3B/ 4/MdWpEYP0I+y+FPTd3rRJ7KbMCZtGGQttx8J+Jk1uP0dI8aax5cchiMCGWjlJRA0OYsYBuWFK79zg 9Fbn9TuODLQ1AMYjr7c8EJtoCvAwUuyuv9G3I+QrGR/e5idKvFOGYrzQcRwX3LdypWNrc40XHg86fN LtTFBmD97EClEW3wJp34dYmWMrhfTQSXizL8SxciiOuN6HLb48tuJlUIsElzxMFaPqTbRAzYf9n71T ApHGKA07YhFAwBeeEV89Hvg0yFPYECFi0nGPMilEUyDgfEvGZ4EyzEkLVSyPQXf2bbJp99O0/jVGnM VvTEBvVGpKz26thsvWoI6I3PSfCDeC
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since all current users of arch_parse_elf_property() are able to treat the
interpreter and main executable orthogonaly the has_interp argument is now
redundant so remove it.

Signed-off-by: Mark Brown <broonie@kernel.org>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-By: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/elf.h | 2 +-
 fs/binfmt_elf.c              | 2 +-
 include/linux/elf.h          | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index c4aa60db76a4..8009e8f07f1e 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -268,7 +268,7 @@ static inline int arm64_elf_bti_flag(bool is_interp)
 
 static inline int arch_parse_elf_property(u32 type, const void *data,
 					  size_t datasz, bool compat,
-					  bool has_interp, bool is_interp,
+					  bool is_interp,
 					  struct arch_elf_state *arch)
 {
 	/* No known properties for AArch32 yet */
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 50f04e19a714..e3bfebfc2a99 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -753,7 +753,7 @@ static int parse_elf_property(const char *data, size_t *off, size_t datasz,
 
 	ret = arch_parse_elf_property(pr->pr_type, data + o,
 				      pr->pr_datasz, ELF_COMPAT,
-				      has_interp, is_interp, arch);
+				      is_interp, arch);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/elf.h b/include/linux/elf.h
index d8392531899d..cdb080d4b34a 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -88,14 +88,14 @@ struct arch_elf_state;
 #ifndef CONFIG_ARCH_USE_GNU_PROPERTY
 static inline int arch_parse_elf_property(u32 type, const void *data,
 					  size_t datasz, bool compat,
-					  bool has_interp, bool is_interp,
+					  bool is_interp,
 					  struct arch_elf_state *arch)
 {
 	return 0;
 }
 #else
 extern int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
-				   bool compat, bool has_interp, bool is_interp,
+				   bool compat, bool is_interp,
 				   struct arch_elf_state *arch);
 #endif
 
-- 
2.30.2

