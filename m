Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30C4626942
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2019 19:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfEVRlD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 13:41:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55906 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbfEVRlD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 May 2019 13:41:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 489EB341;
        Wed, 22 May 2019 10:41:02 -0700 (PDT)
Received: from e111045-lin.cambridge.arm.com (apickardsiphone.cambridge.arm.com [10.1.30.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01C223F5AF;
        Wed, 22 May 2019 10:40:59 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     marc.zyngier@arm.com, james.morse@arm.com, will.deacon@arm.com,
        guillaume.gardet@arm.com, mark.rutland@arm.com, mingo@kernel.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, x86@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@arm.com>
Subject: [PATCH] x86/tools: deal with 64-bit relative relocations for per-CPU symbols
Date:   Wed, 22 May 2019 18:40:57 +0100
Message-Id: <20190522174057.21770-1-ard.biesheuvel@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to fix an issue in the place relative ksymtab code, we
need to switch to 64-bit place relative references, which
require special handling in the x86 'relocs' tool. The reason
is that per-CPU symbols on x86_64 live in a separate link time
section, whose load time address is not reflected in the ELF
metadata, and so relative references emitted by the toolchain
are guaranteed to be wrong.

So fix this by extending the handling of 32-bit relative references
to per-CPU variables to support 64-bit relative references as
well.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
---
This is a follow-up to [0] and a prerequisite to the change it
implements: using 64-bit relative references on x86_64 requires
this handling in the 'relocs' tool and in the decompressor.

[0] https://lore.kernel.org/linux-arm-kernel/20190522150239.19314-1-ard.biesheuvel@arm.com

This patch plus [0] build and boot tested with x86_64_defconfig on QEMU/kvm + OVMF.

 arch/x86/boot/compressed/misc.c | 12 ++++++++++++
 arch/x86/tools/relocs.c         | 15 ++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 5a237e8dbf8d..e089d78bd86a 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -218,6 +218,8 @@ static void handle_relocations(void *output, unsigned long output_len,
 	 * Format is:
 	 *
 	 * kernel bits...
+	 * 0 - zero terminator for inverse 64 bit relocations
+	 * 64 bit inverse relocation repeated
 	 * 0 - zero terminator for 64 bit relocations
 	 * 64 bit relocation repeated
 	 * 0 - zero terminator for inverse 32 bit relocations
@@ -258,6 +260,16 @@ static void handle_relocations(void *output, unsigned long output_len,
 
 		*(uint64_t *)ptr += delta;
 	}
+	while (*--reloc) {
+		long extended = *reloc;
+		extended += map;
+
+		ptr = (unsigned long)extended;
+		if (ptr < min_addr || ptr > max_addr)
+			error("inverse 64-bit relocation outside of kernel!\n");
+
+		*(uint64_t *)ptr -= delta;
+	}
 #endif
 }
 #else
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index ce7188cbdae5..d6a2bb90dfa6 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -26,6 +26,7 @@ static struct relocs relocs32;
 #if ELF_BITS == 64
 static struct relocs relocs32neg;
 static struct relocs relocs64;
+static struct relocs relocs64neg;
 #endif
 
 struct section {
@@ -800,12 +801,8 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		break;
 
 	case R_X86_64_PC64:
-		/*
-		 * Only used by jump labels
-		 */
 		if (is_percpu_sym(sym, symname))
-			die("Invalid R_X86_64_PC64 relocation against per-CPU symbol %s\n",
-			    symname);
+			add_reloc(&relocs64neg, offset);
 		break;
 
 	case R_X86_64_32:
@@ -1027,6 +1024,7 @@ static void emit_relocs(int as_text, int use_real_mode)
 #if ELF_BITS == 64
 	sort_relocs(&relocs32neg);
 	sort_relocs(&relocs64);
+	sort_relocs(&relocs64neg);
 #else
 	sort_relocs(&relocs16);
 #endif
@@ -1054,6 +1052,13 @@ static void emit_relocs(int as_text, int use_real_mode)
 		/* Print a stop */
 		write_reloc(0, stdout);
 
+		/* Now print each inverse 64-bit relocation */
+		for (i = 0; i < relocs64neg.count; i++)
+			write_reloc(relocs64neg.offset[i], stdout);
+
+		/* Print a stop */
+		write_reloc(0, stdout);
+
 		/* Now print each relocation */
 		for (i = 0; i < relocs64.count; i++)
 			write_reloc(relocs64.offset[i], stdout);
-- 
2.17.1

