Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DEC3CE68C
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jul 2021 19:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbhGSQIF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Jul 2021 12:08:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345681AbhGSQGC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Jul 2021 12:06:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4093F611F2;
        Mon, 19 Jul 2021 16:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626713180;
        bh=xgmswHaaDjiYO/29SYz5Q16qNtOA0Zo6sNUvA4c37C0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPgb1K6dPb4C1U0YSile0taNEhdwG2Kr3Kin0SP+GrgNVukHS1wh7E9k/PpW527Cd
         pviOSWsxW7nvsTRYh0dM8bKW3sHiwmzMIrhER4hmXm0jL8tACzJIkq63Y9m/+ahYZG
         34cFnX9/ObV159ePIJgh6Y/q1oE5A08jOzXO2/Wvm35WOJ69ENO4+WaR721Kp+3c3J
         FcCcSCqxG0wGAzNV4HacMQSQe5zkFAFKv5iSHDZnDKoUEQbXKn5GnBiX1DQZtiPAMY
         hcdmkPa6MdDcyuZrCY3HPl7jn3K7lbTl32VPDb+rlw3JrODyOw4T3LG9FshC7z3IjJ
         IRPi5s9oSqJmA==
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
Subject: [PATCH v5 4/4] elf: Remove has_interp property from arch_parse_elf_property()
Date:   Mon, 19 Jul 2021 17:45:36 +0100
Message-Id: <20210719164536.19143-5-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210719164536.19143-1-broonie@kernel.org>
References: <20210719164536.19143-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2173; h=from:subject; bh=xgmswHaaDjiYO/29SYz5Q16qNtOA0Zo6sNUvA4c37C0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBg9awvXgY1VJFTWSLZBweaBcwQZvplDUfcRo5H5J4P dD9gaUeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYPWsLwAKCRAk1otyXVSH0L33B/ 9sTaTyQ0Kq64HnBsreB3L+Ff2x5ejY8EVL8ag/r9aMetT9RN0pFj6Ycj9gjcvqkeam7xFEMwUNJVNA E/zhf33RyxZl7mii2RDH/DLP9XvH6z2j49Kj20wjz3W4AAnM50rL1ikioqcqPdMtzJvyiSabdkk7vc rC8QVf5lOnWfe96Z5X2IY6UhIdWg3MiPIwJC591sc8i5UrHcWZirZ8myLd+J5aoSldsA4mb533x4v3 wrLPw8NBfD1CtXPvcWvebwFoap0HSdaf5QMOUdnY1iaDQB/Ru1gThJgjeiEnIQDNn5ExPHTFMIoNOl 1JnPwU1iWk+goBqL3MB0sXgk9lsXtj
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
index 43b10fd04467..43f2ee69a7de 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -270,7 +270,7 @@ static inline int arm64_elf_bti_flag(bool is_interp)
 
 static inline int arch_parse_elf_property(u32 type, const void *data,
 					  size_t datasz, bool compat,
-					  bool has_interp, bool is_interp,
+					  bool is_interp,
 					  struct arch_elf_state *arch)
 {
 	/* No known properties for AArch32 yet */
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 4f3bea1a697c..e3beaf4345cd 100644
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
2.20.1

