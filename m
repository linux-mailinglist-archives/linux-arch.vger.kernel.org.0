Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB51D498311
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jan 2022 16:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbiAXPHy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jan 2022 10:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiAXPHy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jan 2022 10:07:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD7FC06173B
        for <linux-arch@vger.kernel.org>; Mon, 24 Jan 2022 07:07:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8FDE6142F
        for <linux-arch@vger.kernel.org>; Mon, 24 Jan 2022 15:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEE6C340E8;
        Mon, 24 Jan 2022 15:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643036873;
        bh=YA5l6u38ExryfzHfc5h/QMU/OpPRy+FobM8+N0ungpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eZao3Awa/ozGsOyjgGRCtz492fQ8c4mldJs7EIqE/ZXpFSkK9/Mv+4POTj98zyTXH
         EMDEwb9B+69+L/yUNMpThBH/naMr0YQQkFlLYjeJ8JVOOh6FDqU9KgBxox2QP0dWQY
         O0KyG/8OXlhrk86zux3PEepL/UIuVsQ9tqEx9IMA5aZjNVdiIMoEclbRps+2UK3z6Z
         R3tqZY7hgjpKtUTHnp9ZCHYDvyk8ij7Ixq4jEGFrmerbgiS4ul8wjehQ5Coe5LyqRH
         rSVe9eJ8IerF/+J+Qotkusv4X3xXojkWk8cSYCO9bRXOBWtKwLW5KVVlqRRRgH1/Pt
         a+LOZf+XhNMNg==
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
Subject: [PATCH v8 3/4] elf: Remove has_interp property from arch_adjust_elf_prot()
Date:   Mon, 24 Jan 2022 15:07:03 +0000
Message-Id: <20220124150704.2559523-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124150704.2559523-1-broonie@kernel.org>
References: <20220124150704.2559523-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2253; h=from:subject; bh=YA5l6u38ExryfzHfc5h/QMU/OpPRy+FobM8+N0ungpY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh7sCUOqkUTeo82THcDMOZVBoJskCjZN+WN6WxIzcZ cA12zuiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe7AlAAKCRAk1otyXVSH0C9AB/ 9gus9c92QLI/yd4uHYwgicz4W5ABnMrcFKqY1/hgM3b9VZ+esX9NOeaoMwbMjoVMzgC1SAOgPExITP 8860Jk7o5q8Du6vpVNfOhX9GBvKu2lspryjlbTaf6EsKza8nqL11M/2BkEP+Whdarxwn84vnIQADKq nySZ4v8sFfkFX+W/UGjX0zjqysl4ER3qHtS5KYfGx/ATW+7r57QXOGr5k4NjgUBDS2i8eKJDCBUiQc kH5XJ8xKCZIQg33U3+TeuL/TOVAWBy/QHYAe4kYA2YwAWZdIbN97/QpvzAXGNyJWrsYspd9hUD6h8Y 5PK6Lyxfne76QfEXfuOBmSv8CkkLt0
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
index 8157910a4181..8017d963be3f 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -702,7 +702,7 @@ core_initcall(tagged_addr_init);
 
 #ifdef CONFIG_BINFMT_ELF
 int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
-			 bool has_interp, bool is_interp)
+			 bool is_interp)
 {
 	if ((prot & PROT_EXEC) &&
 	    (state->flags & arm64_elf_bti_flag(is_interp)))
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index eabd7e0f6592..c1620358ab77 100644
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

