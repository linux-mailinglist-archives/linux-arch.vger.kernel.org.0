Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E096DCB76
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 18:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392259AbfJRQc4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 12:32:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57774 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439985AbfJRQa6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 12:30:58 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iLV9A-0002wl-Cw; Fri, 18 Oct 2019 18:30:36 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3EF201C04CF;
        Fri, 18 Oct 2019 18:30:32 +0200 (CEST)
Date:   Fri, 18 Oct 2019 16:30:32 -0000
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Annotate aliases
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, xen-devel@lists.xenproject.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191011115108.12392-10-jslaby@suse.cz>
References: <20191011115108.12392-10-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157141623204.29376.8488182129639228430.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     e9b9d020c4873d5e90d9986cfd137afbafbc5bfa
Gitweb:        https://git.kernel.org/tip/e9b9d020c4873d5e90d9986cfd137afbafbc5bfa
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Fri, 11 Oct 2019 13:50:49 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Oct 2019 10:38:23 +02:00

x86/asm: Annotate aliases

_key_expansion_128 is an alias to _key_expansion_256a, __memcpy to
memcpy, xen_syscall32_target to xen_sysenter_target, and so on. Annotate
them all using the new SYM_FUNC_START_ALIAS, SYM_FUNC_START_LOCAL_ALIAS,
and SYM_FUNC_END_ALIAS. This will make the tools generating the
debuginfo happy as it avoids nesting and double symbols.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Juergen Gross <jgross@suse.com> [xen parts]
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: xen-devel@lists.xenproject.org
Link: https://lkml.kernel.org/r/20191011115108.12392-10-jslaby@suse.cz
---
 arch/x86/crypto/aesni-intel_asm.S | 5 ++---
 arch/x86/lib/memcpy_64.S          | 4 ++--
 arch/x86/lib/memmove_64.S         | 4 ++--
 arch/x86/lib/memset_64.S          | 4 ++--
 arch/x86/xen/xen-asm_64.S         | 4 ++--
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index e0a5fb4..9d8d5f2 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -1757,8 +1757,7 @@ ENDPROC(aesni_gcm_finalize)
 #endif
 
 
-.align 4
-_key_expansion_128:
+SYM_FUNC_START_LOCAL_ALIAS(_key_expansion_128)
 SYM_FUNC_START_LOCAL(_key_expansion_256a)
 	pshufd $0b11111111, %xmm1, %xmm1
 	shufps $0b00010000, %xmm0, %xmm4
@@ -1769,8 +1768,8 @@ SYM_FUNC_START_LOCAL(_key_expansion_256a)
 	movaps %xmm0, (TKEYP)
 	add $0x10, TKEYP
 	ret
-ENDPROC(_key_expansion_128)
 SYM_FUNC_END(_key_expansion_256a)
+SYM_FUNC_END_ALIAS(_key_expansion_128)
 
 SYM_FUNC_START_LOCAL(_key_expansion_192a)
 	pshufd $0b01010101, %xmm1, %xmm1
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 9274866..57a6426 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -28,7 +28,7 @@
  * Output:
  * rax original destination
  */
-ENTRY(__memcpy)
+SYM_FUNC_START_ALIAS(__memcpy)
 ENTRY(memcpy)
 	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
 		      "jmp memcpy_erms", X86_FEATURE_ERMS
@@ -42,7 +42,7 @@ ENTRY(memcpy)
 	rep movsb
 	ret
 ENDPROC(memcpy)
-ENDPROC(__memcpy)
+SYM_FUNC_END_ALIAS(__memcpy)
 EXPORT_SYMBOL(memcpy)
 EXPORT_SYMBOL(__memcpy)
 
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index bbec69d..50c1648 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -26,7 +26,7 @@
  */
 .weak memmove
 
-ENTRY(memmove)
+SYM_FUNC_START_ALIAS(memmove)
 ENTRY(__memmove)
 
 	/* Handle more 32 bytes in loop */
@@ -208,6 +208,6 @@ ENTRY(__memmove)
 13:
 	retq
 ENDPROC(__memmove)
-ENDPROC(memmove)
+SYM_FUNC_END_ALIAS(memmove)
 EXPORT_SYMBOL(__memmove)
 EXPORT_SYMBOL(memmove)
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 9bc861c..927ac44 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -19,7 +19,7 @@
  *
  * rax   original destination
  */
-ENTRY(memset)
+SYM_FUNC_START_ALIAS(memset)
 ENTRY(__memset)
 	/*
 	 * Some CPUs support enhanced REP MOVSB/STOSB feature. It is recommended
@@ -43,8 +43,8 @@ ENTRY(__memset)
 	rep stosb
 	movq %r9,%rax
 	ret
-ENDPROC(memset)
 ENDPROC(__memset)
+SYM_FUNC_END_ALIAS(memset)
 EXPORT_SYMBOL(memset)
 EXPORT_SYMBOL(__memset)
 
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index ebf610b..45c1249 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -167,13 +167,13 @@ ENDPROC(xen_sysenter_target)
 
 #else /* !CONFIG_IA32_EMULATION */
 
-ENTRY(xen_syscall32_target)
+SYM_FUNC_START_ALIAS(xen_syscall32_target)
 ENTRY(xen_sysenter_target)
 	lea 16(%rsp), %rsp	/* strip %rcx, %r11 */
 	mov $-ENOSYS, %rax
 	pushq $0
 	jmp hypercall_iret
-ENDPROC(xen_syscall32_target)
 ENDPROC(xen_sysenter_target)
+SYM_FUNC_END_ALIAS(xen_syscall32_target)
 
 #endif	/* CONFIG_IA32_EMULATION */
