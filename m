Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34BD585FFF
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 12:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403790AbfHHKjC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 06:39:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:47422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403771AbfHHKjC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 06:39:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79C97AFE1;
        Thu,  8 Aug 2019 10:39:01 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v8 07/28] x86/boot/compressed: annotate local functions
Date:   Thu,  8 Aug 2019 12:38:33 +0200
Message-Id: <20190808103854.6192-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808103854.6192-1-jslaby@suse.cz>
References: <20190808103854.6192-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

relocated, paging_enabled, and no_longmode are self-standing local
functions, annotate them as such. paging_enabled is annotated as
NOALIGN, since the trampoline code has to be compact.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
---
 arch/x86/boot/compressed/head_32.S | 3 ++-
 arch/x86/boot/compressed/head_64.S | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 37380c0d5999..7e8ab0bb6968 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -209,7 +209,7 @@ ENDPROC(efi32_stub_entry)
 #endif
 
 	.text
-relocated:
+SYM_FUNC_START_LOCAL(relocated)
 
 /*
  * Clear BSS (stack is currently empty)
@@ -260,6 +260,7 @@ relocated:
  */
 	xorl	%ebx, %ebx
 	jmp	*%eax
+SYM_FUNC_END(relocated)
 
 #ifdef CONFIG_EFI_STUB
 	.data
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 6233ae35d0d9..c8ce6ffc9fe5 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -511,7 +511,7 @@ ENDPROC(efi64_stub_entry)
 #endif
 
 	.text
-relocated:
+SYM_FUNC_START_LOCAL(relocated)
 
 /*
  * Clear BSS (stack is currently empty)
@@ -540,6 +540,7 @@ relocated:
  * Jump to the decompressed kernel.
  */
 	jmp	*%rax
+SYM_FUNC_END(relocated)
 
 /*
  * Adjust the global offset table
@@ -635,9 +636,10 @@ ENTRY(trampoline_32bit_src)
 	lret
 
 	.code64
-paging_enabled:
+SYM_FUNC_START_LOCAL_NOALIGN(paging_enabled)
 	/* Return from the trampoline */
 	jmp	*%rdi
+SYM_FUNC_END(paging_enabled)
 
 	/*
          * The trampoline code has a size limit.
@@ -647,11 +649,12 @@ paging_enabled:
 	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
 
 	.code32
-no_longmode:
+SYM_FUNC_START_LOCAL(no_longmode)
 	/* This isn't an x86-64 CPU, so hang intentionally, we cannot continue */
 1:
 	hlt
 	jmp     1b
+SYM_FUNC_END(no_longmode)
 
 #include "../../kernel/verify_cpu.S"
 
-- 
2.22.0

