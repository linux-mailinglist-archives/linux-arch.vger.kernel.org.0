Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA21340DE02
	for <lists+linux-arch@lfdr.de>; Thu, 16 Sep 2021 17:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbhIPPcG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Sep 2021 11:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239172AbhIPPcF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Sep 2021 11:32:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE28661251;
        Thu, 16 Sep 2021 15:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631806244;
        bh=QN82akZbpMYFOZOMKttZiJvTLL0GDrhcaRfJwQFBvTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUtX56/9bvpBCQ+/geSv0+cf/xqfimCpy7nawedQJ2Oz5Q6uPPDrjn1Vr+7P2ZK7R
         F1nAzlhDC9FcLmT3Ked6olWCHkD1+6jGPPH6xWoaDUXz04FCH31Vgpr3otP6HoOKSo
         SbZAsiJZOP5LP4hFMMTmGAf9Ai6k6wFz0DNwRxowx/ZkNBAKRFVVW7VIPLXTPF3zjs
         pIuQj2+Dbtkq4vZ/5TUAbPQ/oF8UHoOm9w0C+0bwZadBatly6sZX0AU1sJ+CEnn6al
         FQzXU+X3dpXJ0j04EWJE+sVuU9P07EFO6XVv3Ze+HEwHy2VEv36lNkxDFfTjq+v0Ev
         rJyh75aO4FhNQ==
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
Subject: [PATCH v6 4/4] elf: Remove has_interp property from arch_parse_elf_property()
Date:   Thu, 16 Sep 2021 16:28:21 +0100
Message-Id: <20210916152821.1153-5-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916152821.1153-1-broonie@kernel.org>
References: <20210916152821.1153-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2173; h=from:subject; bh=QN82akZbpMYFOZOMKttZiJvTLL0GDrhcaRfJwQFBvTA=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhQ2KUW/nPnyrDEhNX5FH04JxPL8ONZRrXb0eU1hpM 3s4tB9qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUNilAAKCRAk1otyXVSH0ApeB/ 9tg/tmtfoQLh0avnWOKSyisVmd1eMmYKwfBcrUR1FhHNlrLd7D9bccpOkUT7VckCTaIjMKXJIQ2GBp CrPUL1CefR1KspWgBeEbiq07NgiMHGBZmmCMO5E/j4R8GbYakWzfWd/e7dcac7VujX/c3OV7s/V7cO +SP/S2bVf+QPI+eys9fitIinml2oUWLiLveKsNGfyM/RChwwNsfQeJOGF15Ke2rry/4QcffHWhOM8C HCYBlNhyQMABDz/B8wKbsdhHOi+FdBBde7kAWZh5GApmj6GuSF8eFtifsUkpsaO1vI2NLvd53e4bNO FoS1VWVLDFCS7u4JFcvJKfy9ZhCAun
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
index 5d24aa203b61..495436fd4559 100644
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

