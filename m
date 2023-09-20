Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D2D7A7F72
	for <lists+linux-arch@lfdr.de>; Wed, 20 Sep 2023 14:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbjITM1R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Sep 2023 08:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbjITM1K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Sep 2023 08:27:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8BCC6;
        Wed, 20 Sep 2023 05:26:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB55C433C8;
        Wed, 20 Sep 2023 12:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212818;
        bh=KFGWJpQl4J4z6mh8girfOUZf/dUUh5td6TmshyWaqL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RzYV2FVLZaxvKXDvX2FQTlGvlw9Wyt8P7TMR3gMjIvxxF+OcNM4UDKc+MIBd0Usga
         5c1exxM66iAcvEEiNau3xTsWcSn7KdW0Z4djWZczGOLZzwAYdFjOgh5b2YxLmPhOb6
         7ONu7IQ3ad6oIP0yrXWnaJiloa4t09dprkSeO0v0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiri Slaby <jslaby@suse.cz>,
        Borislav Petkov <bp@suse.de>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Wei Huang <wei@redhat.com>, x86-ml <x86@kernel.org>,
        Xiaoyao Li <xiaoyao.li@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 056/367] x86/boot: Annotate local functions
Date:   Wed, 20 Sep 2023 13:27:13 +0200
Message-ID: <20230920112859.951125884@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Slaby <jslaby@suse.cz>

[ Upstream commit deff8a24e1021fb39dddf5f6bc5832e0e3a632ea ]

.Lrelocated, .Lpaging_enabled, .Lno_longmode, and .Lin_pm32 are
self-standing local functions, annotate them as such and preserve "no
alignment".

The annotations do not generate anything yet.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-arch@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Huang <wei@redhat.com>
Cc: x86-ml <x86@kernel.org>
Cc: Xiaoyao Li <xiaoyao.li@linux.intel.com>
Link: https://lkml.kernel.org/r/20191011115108.12392-8-jslaby@suse.cz
Stable-dep-of: 264b82fdb498 ("x86/decompressor: Don't rely on upper 32 bits of GPRs being preserved")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/boot/compressed/head_32.S | 3 ++-
 arch/x86/boot/compressed/head_64.S | 9 ++++++---
 arch/x86/boot/pmjump.S             | 4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index d7c0fcc1dbf9e..b788b986f3351 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -210,7 +210,7 @@ ENDPROC(efi32_stub_entry)
 #endif
 
 	.text
-.Lrelocated:
+SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 
 /*
  * Clear BSS (stack is currently empty)
@@ -261,6 +261,7 @@ ENDPROC(efi32_stub_entry)
  */
 	xorl	%ebx, %ebx
 	jmp	*%eax
+SYM_FUNC_END(.Lrelocated)
 
 #ifdef CONFIG_EFI_STUB
 	.data
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 50c9eeb36f0d8..95ee795d97964 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -517,7 +517,7 @@ ENDPROC(efi64_stub_entry)
 #endif
 
 	.text
-.Lrelocated:
+SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 
 /*
  * Clear BSS (stack is currently empty)
@@ -546,6 +546,7 @@ ENDPROC(efi64_stub_entry)
  * Jump to the decompressed kernel.
  */
 	jmp	*%rax
+SYM_FUNC_END(.Lrelocated)
 
 /*
  * Adjust the global offset table
@@ -641,9 +642,10 @@ ENTRY(trampoline_32bit_src)
 	lret
 
 	.code64
-.Lpaging_enabled:
+SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
 	/* Return from the trampoline */
 	jmp	*%rdi
+SYM_FUNC_END(.Lpaging_enabled)
 
 	/*
          * The trampoline code has a size limit.
@@ -653,11 +655,12 @@ ENTRY(trampoline_32bit_src)
 	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
 
 	.code32
-.Lno_longmode:
+SYM_FUNC_START_LOCAL_NOALIGN(.Lno_longmode)
 	/* This isn't an x86-64 CPU, so hang intentionally, we cannot continue */
 1:
 	hlt
 	jmp     1b
+SYM_FUNC_END(.Lno_longmode)
 
 #include "../../kernel/verify_cpu.S"
 
diff --git a/arch/x86/boot/pmjump.S b/arch/x86/boot/pmjump.S
index ea88d52eeac70..81658fe353808 100644
--- a/arch/x86/boot/pmjump.S
+++ b/arch/x86/boot/pmjump.S
@@ -46,7 +46,7 @@ ENDPROC(protected_mode_jump)
 
 	.code32
 	.section ".text32","ax"
-.Lin_pm32:
+SYM_FUNC_START_LOCAL_NOALIGN(.Lin_pm32)
 	# Set up data segments for flat 32-bit mode
 	movl	%ecx, %ds
 	movl	%ecx, %es
@@ -72,4 +72,4 @@ ENDPROC(protected_mode_jump)
 	lldt	%cx
 
 	jmpl	*%eax			# Jump to the 32-bit entrypoint
-ENDPROC(.Lin_pm32)
+SYM_FUNC_END(.Lin_pm32)
-- 
2.40.1



