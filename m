Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879173C5BD1
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jul 2021 14:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhGLMAJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jul 2021 08:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234742AbhGLL75 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Jul 2021 07:59:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83A5961004;
        Mon, 12 Jul 2021 11:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626091026;
        bh=HTz3krgKEK3sokcBu26fLZbDuEKvxHCHP7mYIquUumQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k2rbJ6DvNmbm7iUZuAMIT8AoxhwvhfMKQi+tcuaR1zlvFL7JB4VZ0TT9w2CKI4Eoj
         0aAsgNk92HO2go81OBe8erEmltGY3CScKJSx7H/bokCy9aD29oFDZ7oJcfWf/2sSGT
         iCTiqOu9vesib/XVz62ZNfHaFXZID3kVMovsURBDWPPsBpsKBoY4JlJo4eOYZ4gvng
         xeWs2XaKBVuafUceb3rYxrJbVfRy/2og6eSzbUtbK+aqbg9oHuI1psE8QU6s6U3DA4
         P2Z7KFDTDu21SmsV1q0yJn/Zy/IN/r8Rt7tqNSYOtKlYG1hyBSnIIp8qmYA+P8PgoB
         CgBhAv34a0+IQ==
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
Subject: [PATCH v4 4/4] elf: Remove has_interp property from arch_parse_elf_property()
Date:   Mon, 12 Jul 2021 12:52:59 +0100
Message-Id: <20210712115259.29547-5-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210712115259.29547-1-broonie@kernel.org>
References: <20210712115259.29547-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2096; h=from:subject; bh=HTz3krgKEK3sokcBu26fLZbDuEKvxHCHP7mYIquUumQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBg7C0ZI7AUHkf3F2fqzYkpePJDKctDZoneaDiuq6uX SUkWpFqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYOwtGQAKCRAk1otyXVSH0PbNB/ 4uADYxboRbRm4twF9ZWyE6U84qFWFNhkunDdhqmV5sHMOGIfBjDRARKSkfNLBXn4lS90YL0Q8z4SAw 47BmZThdClQ1rENhXe307rAe9GLkroAP71ra86cKnkfaMmDv4o840zURvHOLuy8iJXh9wEPIq015uH lOvPm6EWiLNfXNc69ah6pIavaZxT3GWhKcRR6ifFujYxlXIVAUwiWs51Z65SVMnAS7qZ1c4JDU8d+f 4f2c3kID3uohosUWvwiHCMjNb99oD7C9Tuw/nqamCs3CsoRCW2XARenCDij2oqJ+6rDvqe78w6NTGR cs0/tW7qaFCKSzSZm8eSwE7X1DYIWm
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
---
 arch/arm64/include/asm/elf.h | 2 +-
 fs/binfmt_elf.c              | 2 +-
 include/linux/elf.h          | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 9f86dbce2680..a6e9032b951a 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -262,7 +262,7 @@ struct arch_elf_state {
 
 static inline int arch_parse_elf_property(u32 type, const void *data,
 					  size_t datasz, bool compat,
-					  bool has_interp, bool is_interp,
+					  bool is_interp,
 					  struct arch_elf_state *arch)
 {
 	/* No known properties for AArch32 yet */
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index ae8094d42480..f0b3c24215f6 100644
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

