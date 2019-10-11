Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40CD9D3EF6
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 13:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfJKLwo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 07:52:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:33348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727969AbfJKLvT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 07:51:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79C62B48C;
        Fri, 11 Oct 2019 11:51:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-crypto@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [PATCH v9 09/28] x86/asm: Annotate aliases
Date:   Fri, 11 Oct 2019 13:50:49 +0200
Message-Id: <20191011115108.12392-10-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011115108.12392-1-jslaby@suse.cz>
References: <20191011115108.12392-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

_key_expansion_128 is an alias to _key_expansion_256a, __memcpy to
memcpy, xen_syscall32_target to xen_sysenter_target, and so on. Annotate
them all using the new SYM_FUNC_START_ALIAS, SYM_FUNC_START_LOCAL_ALIAS,
and SYM_FUNC_END_ALIAS. This will make the tools generating the
debuginfo happy as it avoid nesting and double symbols.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com> [xen parts]
Cc: <linux-crypto@vger.kernel.org>
Cc: <xen-devel@lists.xenproject.org>
---
 arch/x86/crypto/aesni-intel_asm.S | 5 ++---
 arch/x86/lib/memcpy_64.S          | 4 ++--
 arch/x86/lib/memmove_64.S         | 4 ++--
 arch/x86/lib/memset_64.S          | 4 ++--
 arch/x86/xen/xen-asm_64.S         | 4 ++--
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index e0a5fb462a0a..9d8d5f2296e1 100644
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
index 92748660ba51..57a64266ba69 100644
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
index bbec69d8223b..50c1648311b3 100644
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
index 9bc861c71e75..927ac44d34aa 100644
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
index ebf610b49c06..45c1249f370d 100644
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
-- 
2.23.0

