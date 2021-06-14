Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847E13A71F7
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 00:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhFNWfT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 18:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229939AbhFNWfS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Jun 2021 18:35:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B398461350;
        Mon, 14 Jun 2021 22:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623709995;
        bh=dADxCcnOfO3ZUnZ9a2fEumgqIOKICC14vf9CSy6vgv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qGypQ71abbJTgI5upU7DehXGtS18qXrDm8e3xLXfvJCuSXYn9ycfqT3/IccI/P/iN
         yK/DVQBPar7K+e9A1ymKzj/WRcyQ9irrZK5K0F/fYH5UR2MVnfzBcx8vwDv+PUs+a+
         Z25DdgtJnGDpnGM6d5EKYMB4pQ+dIhWn9fuTSCNBgxWgfKWHJLyMXAQVsudUqK8Rr5
         82eLcyDmAkbmAfnPI/0SORZGv83zLoWXZingxp7eoyaTazvME6LRnZB3wydeSKrfDp
         BpvNP1Dg3WdQGKAD15DBDjz9+z4u0OK11NC4YVZmtxEuLFhYaPbRrNVDitdXtkmXxp
         zeS2HQ0/ytKDA==
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
Subject: [PATCH v3 4/4] elf: Remove has_interp property from arch_parse_elf_property()
Date:   Mon, 14 Jun 2021 23:32:14 +0100
Message-Id: <20210614223214.39011-5-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210614223214.39011-1-broonie@kernel.org>
References: <20210614223214.39011-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2046; h=from:subject; bh=dADxCcnOfO3ZUnZ9a2fEumgqIOKICC14vf9CSy6vgv0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBgx9jthwgmlfRA1jM91GkX7mG7mC714J/VsA8WtqyN FwHJzzqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYMfY7QAKCRAk1otyXVSH0Px6B/ 9ZQmIoNj/Fsbx5yBcfBfa7aW1jNFB1wAIMpAythc7L3lyflO+/Uo83KH38OzRCi72aZPXNs89O8hk/ z5KFmFFHmgUhxh++V1Uv6+JML3VbsAk4QeaW6LNwE1JlfMB6WPk4lKdlqRW1V0jo8Wl5zL2CbzsKlq skmLKgudOy6QdcUTdZ62XOROXUIDtYl9HIBqx0295UpAcHTYH7XnrUWz571gJH1RozGZPoz0/gQcRJ rQvOGo3ncDf6amtTmrO4k7JyO0rtQ5op4tXC6y6fyJ9rr8se4lVLKkDWs1rPvewsDj42iVEY86NJoT cj0wVnj4CIRpZ8Mn2W4lcJTDzZl4Nb
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since all current users of arch_parse_elf_property() are able to treat the
interpreter and main executable orthogonaly the has_interp argument is now
redundant so remove it.

Signed-off-by: Mark Brown <broonie@kernel.org>
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
index ffe38d54308b..5509ae63c2e1 100644
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

