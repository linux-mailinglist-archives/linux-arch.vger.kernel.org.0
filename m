Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E2A655B1B
	for <lists+linux-arch@lfdr.de>; Sat, 24 Dec 2022 20:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiLXT2S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Dec 2022 14:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLXT2Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Dec 2022 14:28:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBA6114B;
        Sat, 24 Dec 2022 11:28:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 158D7B801BC;
        Sat, 24 Dec 2022 19:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A0CC433EF;
        Sat, 24 Dec 2022 19:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671910092;
        bh=UQnfmGWpjZxvdevhblki0v7ZzFcxxRalPcpyLzVn6JI=;
        h=From:To:Cc:Subject:Date:From;
        b=Z5QB2B9WNLl5VOrzUNo0txpZ6VIJYGVDHCH+nwR9luPwWds2mSlHGNBIJO7lozNhO
         rdFdovyAsB8iRmKcwBjULiwQCbK3avqS0A6tQc7lu4SPb0m0ThZmLLMTjhPQylrGcA
         BbNoZh4CnJ9T6EKJEAENiUfDk8GfMBn6rJWde6vjhr7FWCwAeOw5dQ804F4M/ZDkXR
         65k9Y0tgUoGpzCSK+LlqI2CLA4kXFmBWcPEfmKWnT6hIZxpd77+lxGYLDzIhXW5LYG
         nsxJWyNmGQmKvPj12ADF7gzCtbrkH2gHdznoidrqiuOo+Bc0OnHF48JPsAJa2dgbwR
         rs5qlsrB9UaRw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Dennis Gilmore <dennis@ausil.us>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH] arch: fix broken BuildID for arm64 and riscv
Date:   Sun, 25 Dec 2022 04:27:51 +0900
Message-Id: <20221224192751.810363-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Dennis Gilmore reports that the BuildID is missing in the arm64 vmlinux
since commit 994b7ac1697b ("arm64: remove special treatment for the
link order of head.o").

The issue is that the type of .notes section, which contains the BuildID,
changed from NOTES to PROGBITS.

Ard Biesheuvel figured out that whichever object gets linked first gets
to decide the type of a section, and the PROGBITS type is the result of
the compiler emitting .note.GNU-stack as PROGBITS rather than NOTE.

While Ard provided a fix for arm64, I want to fix this globally because
the same issue is happening on riscv since commit 2348e6bf4421 ("riscv:
remove special treatment for the link order of head.o"). This problem
will happen in general for other architectures if they start to drop
unneeded entries from scripts/head-object-list.txt.

Discard .note.GNU-stack in include/asm-generic/vmlinux.lds.h.

riscv needs to change its linker script so that DISCARDS comes before
the .notes section.

Link: https://lore.kernel.org/lkml/CAABkxwuQoz1CTbyb57n0ZX65eSYiTonFCU8-LCQc=74D=xE=rA@mail.gmail.com/
Fixes: 994b7ac1697b ("arm64: remove special treatment for the link order of head.o")
Fixes: 2348e6bf4421 ("riscv: remove special treatment for the link order of head.o")
Reported-by: Dennis Gilmore <dennis@ausil.us>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/riscv/kernel/vmlinux.lds.S   | 4 ++--
 include/asm-generic/vmlinux.lds.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 4e6c88aa4d87..1865a258e560 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -31,6 +31,8 @@ PECOFF_FILE_ALIGNMENT = 0x200;
 
 SECTIONS
 {
+	DISCARDS
+
 	/* Beginning of code and text segment */
 	. = LOAD_OFFSET;
 	_start = .;
@@ -141,7 +143,5 @@ SECTIONS
 	STABS_DEBUG
 	DWARF_DEBUG
 	ELF_DETAILS
-
-	DISCARDS
 }
 #endif /* CONFIG_XIP_KERNEL */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index a94219e9916f..2993b790fe98 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1007,6 +1007,7 @@
 	*(.modinfo)							\
 	/* ld.bfd warns about .gnu.version* even when not emitted */	\
 	*(.gnu.version*)						\
+	*(.note.GNU-stack)	/* emitted as PROGBITS */
 
 #define DISCARDS							\
 	/DISCARD/ : {							\
-- 
2.34.1

