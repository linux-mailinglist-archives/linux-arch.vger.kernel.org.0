Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F593C5BCF
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jul 2021 14:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhGLMAI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jul 2021 08:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234730AbhGLL7s (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Jul 2021 07:59:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43353610E6;
        Mon, 12 Jul 2021 11:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626091020;
        bh=ljZ0Ar2vQIoqNXA7Uu8g3LQE3bTDHREWhpRUBkTTMGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LcYMQ7mZ1J/XlODNfy5t0bm1r4/u+6TnGXQERVe9ZSmj6dlPQjhPSc9InBurWpff+
         +gxN0DYe7erD/R1++QyX9vV7KvMzSKA85WWI+0gwGW+cHlUPWPCxwim3bYlqT4chpl
         MoAhdNGir6a8hnvTrz6pTf4ZmV8aF785cQf8h8JYN8Z1I8//A4zaBe6SY+2gWrsXte
         uS/xpAXe8V7q89IjWoLkqybxicNWDBsBpjwAGpAL42hLZ5nkIbaksROpbx4D4fONVt
         /r0NAHEc+9LoQv+wSJ/YQ8lg1ajFqqQFAwxT7GCDQpDmAq54CCnGFyn1Oos0GS34YM
         UawHovWmUvSGw==
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
Subject: [PATCH v4 2/4] arm64: Enable BTI for main executable as well as the interpreter
Date:   Mon, 12 Jul 2021 12:52:57 +0100
Message-Id: <20210712115259.29547-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210712115259.29547-1-broonie@kernel.org>
References: <20210712115259.29547-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3439; h=from:subject; bh=ljZ0Ar2vQIoqNXA7Uu8g3LQE3bTDHREWhpRUBkTTMGg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBg7C0YxbctBBxOVXO1gju9IJD3nnsiskpsDgry/8qL T29c1jyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYOwtGAAKCRAk1otyXVSH0NIkB/ 9n5vaAL44C15qVYFgOjjvf719q5n45OMOlh1nk74wIXKSibe+6LIW1wFhO6YzeREAflnsZuSk1JlEC iWSFi9qYRPtVWZgiGeAYkHoDZb+3TNOqNXn41CqOJhRJQkOrymep3MluBuP4vZxT2m0MERBAIgeSOP j7La7EJrzm/7HI54AAHz0nOMaPxhU7yCRZJ3jYFGXgLih+w/4c8FmAt23IJhiFDmwqtA404f78GqZz RhqRo5haCq4sOqzhlMkIGQXvjzJT6wiXE7hYi9Tcv9P5JWsnUOU+ugJ6Zh8lPQiaok7jwwWTQvoFm/ +eceAnAajaB+Wi1TDE2CzobBQj05zO
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently for dynamically linked ELF executables we only enable BTI for
the interpreter, expecting the interpreter to do this for the main
executable. This is a bit inconsistent since we do map main executable and
is causing issues with systemd's MemoryDenyWriteExecute feature which is
implemented using a seccomp filter which prevents setting PROT_EXEC on
already mapped memory and lacks the context to be able to detect that
memory is already mapped with PROT_EXEC.

Resolve this by checking the BTI property for the main executable and
enabling BTI if it is present when doing the initial mapping. This does
mean that we may get more code with BTI enabled if running on a system
without BTI support in the dynamic linker, this is expected to be a safe
configuration and testing seems to confirm that. It also reduces the
flexibility userspace has to disable BTI but it is expected that for cases
where there are problems which require BTI to be disabled it is more likely
that it will need to be disabled on a system level.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/elf.h | 14 ++++++++++----
 arch/arm64/kernel/process.c  | 23 +++++++++++------------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index a488a1329b16..9f86dbce2680 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -253,7 +253,8 @@ struct arch_elf_state {
 	int flags;
 };
 
-#define ARM64_ELF_BTI		(1 << 0)
+#define ARM64_ELF_INTERP_BTI		(1 << 0)
+#define ARM64_ELF_EXEC_BTI		(1 << 1)
 
 #define INIT_ARCH_ELF_STATE {			\
 	.flags = 0,				\
@@ -274,9 +275,14 @@ static inline int arch_parse_elf_property(u32 type, const void *data,
 		if (datasz != sizeof(*p))
 			return -ENOEXEC;
 
-		if (system_supports_bti() && has_interp == is_interp &&
-		    (*p & GNU_PROPERTY_AARCH64_FEATURE_1_BTI))
-			arch->flags |= ARM64_ELF_BTI;
+		if (system_supports_bti() &&
+		    (*p & GNU_PROPERTY_AARCH64_FEATURE_1_BTI)) {
+			if (is_interp) {
+				arch->flags |= ARM64_ELF_INTERP_BTI;
+			} else {
+				arch->flags |= ARM64_ELF_EXEC_BTI;
+			}
+		}
 	}
 
 	return 0;
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index c8989b999250..5a6c3b198bd3 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -683,21 +683,20 @@ core_initcall(tagged_addr_init);
 #endif	/* CONFIG_ARM64_TAGGED_ADDR_ABI */
 
 #ifdef CONFIG_BINFMT_ELF
-int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
-			 bool has_interp, bool is_interp)
+static inline int arm64_elf_bti_flag(bool is_interp)
 {
-	/*
-	 * For dynamically linked executables the interpreter is
-	 * responsible for setting PROT_BTI on everything except
-	 * itself.
-	 */
-	if (is_interp != has_interp)
-		return prot;
+	if (is_interp)
+		return ARM64_ELF_INTERP_BTI;
+	else
+		return ARM64_ELF_EXEC_BTI;
+}
 
-	if (!(state->flags & ARM64_ELF_BTI))
-		return prot;
 
-	if (prot & PROT_EXEC)
+int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
+			 bool has_interp, bool is_interp)
+{
+	if ((prot & PROT_EXEC) &&
+	    (state->flags & arm64_elf_bti_flag(is_interp)))
 		prot |= PROT_BTI;
 
 	return prot;
-- 
2.20.1

