Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3679E498316
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jan 2022 16:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbiAXPH7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jan 2022 10:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237584AbiAXPH5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jan 2022 10:07:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9D6C06173B
        for <linux-arch@vger.kernel.org>; Mon, 24 Jan 2022 07:07:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F48D61460
        for <linux-arch@vger.kernel.org>; Mon, 24 Jan 2022 15:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD940C340EC;
        Mon, 24 Jan 2022 15:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643036876;
        bh=AgvHJ05mKlanHTKPxlvF3HP9xWj1bFujzXnIQtNs0qQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l02j+vlYqO61Bd6S0IaSsfTGDwHDY2cHjOrjyjczxTlej/cgXYkzWwIkThqPjHFDU
         e0PxYRJPAsvvXV3zmHG6gTfXDYymbuGsrnWl+u+7SEm7kaAkwu0hrIuojyCPps+dl1
         4gAhlG/PqNZ4dRAzHa0BvRBERGKjoRTll2LqQ3m228P9V/T9hJ7T5AvPwIq44N/cO6
         WDhnrwyX2MTIIhWz7H+czuBwiaz9L7O+OmZbBQPbvb7tgGqFsXJ1+4YeOtlQ2AIkcP
         pHlHp4jxcWk8me/WiQy0VGRvoZXmxc4FB5VO9c+1QU+aQtnTLAGywQ35soFSUoBfu3
         hQkZFXBv6evUA==
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
Subject: [PATCH v8 4/4] elf: Remove has_interp property from arch_parse_elf_property()
Date:   Mon, 24 Jan 2022 15:07:04 +0000
Message-Id: <20220124150704.2559523-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124150704.2559523-1-broonie@kernel.org>
References: <20220124150704.2559523-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2173; h=from:subject; bh=AgvHJ05mKlanHTKPxlvF3HP9xWj1bFujzXnIQtNs0qQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh7sCV5pbroCzNdrQI6WswDIxBtw80BpnySXQ1Hojz LOHZoKGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe7AlQAKCRAk1otyXVSH0O0vB/ 9KE5CJ10Jv+de4lujwv4rzrdy9amy41Qfx8+qwkEdVL9RKrSl/lcHJMf1bWD2ooFU4UguhiR/NK3Dy dDvb5tPAjR+pfY4mV+ChjNX33tpGLDOX4/uMkZcen4ZisJLbdcDOKRFELofpmd43nWNvrQTc3gu6mW P3todCZycJiwdtQS1KvRXviiR4YCLgMtyaljjjG1wKRoXlykvd3//rvdHuDoBhWgF9stBaaeW/yHnf 97oMXIc6EYAFTMbkvtpIauGQTwV2YHe7Kgtcl/Ve7icYEoqv44lLSP2K0SWOZ4HVzZ8AP5L/wG666b ja8EwxE9GcmgqnTQXv5G3ogbtCrLjB
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
index c1620358ab77..caedfdcead61 100644
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

