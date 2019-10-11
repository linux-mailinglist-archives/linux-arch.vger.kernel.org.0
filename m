Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFF3BD3ED2
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 13:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfJKLvj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 07:51:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:33440 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728115AbfJKLvj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 07:51:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AB825B499;
        Fri, 11 Oct 2019 11:51:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Juergen Gross <jgross@suse.com>, linux-crypto@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-efi@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [PATCH v9 24/28] x86_64/asm: Change all ENTRY+ENDPROC to SYM_FUNC_*
Date:   Fri, 11 Oct 2019 13:51:04 +0200
Message-Id: <20191011115108.12392-25-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011115108.12392-1-jslaby@suse.cz>
References: <20191011115108.12392-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

These are all functions which are invoked from elsewhere, so annotate
them as global using the new SYM_FUNC_START. And their ENDPROC's by
SYM_FUNC_END.

And make sure ENTRY/ENDPROC is not defined on X86_64, given these were
the last users.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com> [hibernate]
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com> [xen bits]
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-efi@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/boot/compressed/efi_thunk_64.S      |  4 +-
 arch/x86/boot/compressed/head_64.S           | 16 +++---
 arch/x86/boot/compressed/mem_encrypt.S       |  8 +--
 arch/x86/crypto/aegis128-aesni-asm.S         | 28 ++++-----
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S      | 12 ++--
 arch/x86/crypto/aesni-intel_asm.S            | 60 ++++++++++----------
 arch/x86/crypto/aesni-intel_avx-x86_64.S     | 32 +++++------
 arch/x86/crypto/blowfish-x86_64-asm_64.S     | 16 +++---
 arch/x86/crypto/camellia-aesni-avx-asm_64.S  | 24 ++++----
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S | 24 ++++----
 arch/x86/crypto/camellia-x86_64-asm_64.S     | 16 +++---
 arch/x86/crypto/cast5-avx-x86_64-asm_64.S    | 16 +++---
 arch/x86/crypto/cast6-avx-x86_64-asm_64.S    | 24 ++++----
 arch/x86/crypto/chacha-avx2-x86_64.S         | 12 ++--
 arch/x86/crypto/chacha-avx512vl-x86_64.S     | 12 ++--
 arch/x86/crypto/chacha-ssse3-x86_64.S        | 12 ++--
 arch/x86/crypto/crc32-pclmul_asm.S           |  4 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S    |  4 +-
 arch/x86/crypto/crct10dif-pcl-asm_64.S       |  4 +-
 arch/x86/crypto/des3_ede-asm_64.S            |  8 +--
 arch/x86/crypto/ghash-clmulni-intel_asm.S    |  8 +--
 arch/x86/crypto/nh-avx2-x86_64.S             |  4 +-
 arch/x86/crypto/nh-sse2-x86_64.S             |  4 +-
 arch/x86/crypto/poly1305-avx2-x86_64.S       |  4 +-
 arch/x86/crypto/poly1305-sse2-x86_64.S       |  8 +--
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S  | 24 ++++----
 arch/x86/crypto/serpent-avx2-asm_64.S        | 24 ++++----
 arch/x86/crypto/serpent-sse2-x86_64-asm_64.S |  8 +--
 arch/x86/crypto/sha1_avx2_x86_64_asm.S       |  4 +-
 arch/x86/crypto/sha1_ni_asm.S                |  4 +-
 arch/x86/crypto/sha1_ssse3_asm.S             |  4 +-
 arch/x86/crypto/sha256-avx-asm.S             |  4 +-
 arch/x86/crypto/sha256-avx2-asm.S            |  4 +-
 arch/x86/crypto/sha256-ssse3-asm.S           |  4 +-
 arch/x86/crypto/sha256_ni_asm.S              |  4 +-
 arch/x86/crypto/sha512-avx-asm.S             |  4 +-
 arch/x86/crypto/sha512-avx2-asm.S            |  4 +-
 arch/x86/crypto/sha512-ssse3-asm.S           |  4 +-
 arch/x86/crypto/twofish-avx-x86_64-asm_64.S  | 24 ++++----
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S |  8 +--
 arch/x86/crypto/twofish-x86_64-asm_64.S      |  8 +--
 arch/x86/entry/entry_64.S                    | 10 ++--
 arch/x86/entry/entry_64_compat.S             |  4 +-
 arch/x86/kernel/acpi/wakeup_64.S             |  8 +--
 arch/x86/kernel/ftrace_64.S                  | 20 +++----
 arch/x86/kernel/irqflags.S                   |  8 +--
 arch/x86/kvm/vmx/vmenter.S                   | 12 ++--
 arch/x86/lib/checksum_32.S                   |  8 +--
 arch/x86/lib/clear_page_64.S                 | 12 ++--
 arch/x86/lib/cmpxchg16b_emu.S                |  4 +-
 arch/x86/lib/cmpxchg8b_emu.S                 |  4 +-
 arch/x86/lib/copy_page_64.S                  |  4 +-
 arch/x86/lib/copy_user_64.S                  | 16 +++---
 arch/x86/lib/csum-copy_64.S                  |  4 +-
 arch/x86/lib/getuser.S                       | 16 +++---
 arch/x86/lib/hweight.S                       |  8 +--
 arch/x86/lib/iomap_copy_64.S                 |  4 +-
 arch/x86/lib/memcpy_64.S                     |  4 +-
 arch/x86/lib/memmove_64.S                    |  4 +-
 arch/x86/lib/memset_64.S                     |  4 +-
 arch/x86/lib/msr-reg.S                       |  8 +--
 arch/x86/lib/putuser.S                       | 16 +++---
 arch/x86/lib/retpoline.S                     |  4 +-
 arch/x86/mm/mem_encrypt_boot.S               |  8 +--
 arch/x86/platform/efi/efi_stub_64.S          |  4 +-
 arch/x86/platform/efi/efi_thunk_64.S         |  4 +-
 arch/x86/power/hibernate_asm_64.S            |  8 +--
 arch/x86/xen/xen-asm.S                       | 28 ++++-----
 arch/x86/xen/xen-asm_64.S                    | 16 +++---
 include/linux/linkage.h                      |  4 ++
 70 files changed, 379 insertions(+), 375 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
index 31312070db22..593913692d16 100644
--- a/arch/x86/boot/compressed/efi_thunk_64.S
+++ b/arch/x86/boot/compressed/efi_thunk_64.S
@@ -23,7 +23,7 @@
 
 	.code64
 	.text
-ENTRY(efi64_thunk)
+SYM_FUNC_START(efi64_thunk)
 	push	%rbp
 	push	%rbx
 
@@ -97,7 +97,7 @@ ENTRY(efi64_thunk)
 	pop	%rbx
 	pop	%rbp
 	ret
-ENDPROC(efi64_thunk)
+SYM_FUNC_END(efi64_thunk)
 
 SYM_FUNC_START_LOCAL(efi_exit32)
 	movq	func_rt_ptr(%rip), %rax
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 55800467ce5c..58a512e33d8d 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -45,7 +45,7 @@
 
 	__HEAD
 	.code32
-ENTRY(startup_32)
+SYM_FUNC_START(startup_32)
 	/*
 	 * 32bit entry is 0 and it is ABI so immutable!
 	 * If we come here directly from a bootloader,
@@ -222,11 +222,11 @@ ENTRY(startup_32)
 
 	/* Jump from 32bit compatibility mode into 64bit mode. */
 	lret
-ENDPROC(startup_32)
+SYM_FUNC_END(startup_32)
 
 #ifdef CONFIG_EFI_MIXED
 	.org 0x190
-ENTRY(efi32_stub_entry)
+SYM_FUNC_START(efi32_stub_entry)
 	add	$0x4, %esp		/* Discard return address */
 	popl	%ecx
 	popl	%edx
@@ -245,7 +245,7 @@ ENTRY(efi32_stub_entry)
 	movl	%eax, efi_config(%ebp)
 
 	jmp	startup_32
-ENDPROC(efi32_stub_entry)
+SYM_FUNC_END(efi32_stub_entry)
 #endif
 
 	.code64
@@ -447,7 +447,7 @@ SYM_CODE_END(startup_64)
 #ifdef CONFIG_EFI_STUB
 
 /* The entry point for the PE/COFF executable is efi_pe_entry. */
-ENTRY(efi_pe_entry)
+SYM_FUNC_START(efi_pe_entry)
 	movq	%rcx, efi64_config(%rip)	/* Handle */
 	movq	%rdx, efi64_config+8(%rip) /* EFI System table pointer */
 
@@ -496,10 +496,10 @@ fail:
 	movl	BP_code32_start(%esi), %eax
 	leaq	startup_64(%rax), %rax
 	jmp	*%rax
-ENDPROC(efi_pe_entry)
+SYM_FUNC_END(efi_pe_entry)
 
 	.org 0x390
-ENTRY(efi64_stub_entry)
+SYM_FUNC_START(efi64_stub_entry)
 	movq	%rdi, efi64_config(%rip)	/* Handle */
 	movq	%rsi, efi64_config+8(%rip) /* EFI System table pointer */
 
@@ -508,7 +508,7 @@ ENTRY(efi64_stub_entry)
 
 	movq	%rdx, %rsi
 	jmp	handover_entry
-ENDPROC(efi64_stub_entry)
+SYM_FUNC_END(efi64_stub_entry)
 #endif
 
 	.text
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index 28d703cad310..dd07e7b41b11 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -15,7 +15,7 @@
 
 	.text
 	.code32
-ENTRY(get_sev_encryption_bit)
+SYM_FUNC_START(get_sev_encryption_bit)
 	xor	%eax, %eax
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
@@ -65,10 +65,10 @@ ENTRY(get_sev_encryption_bit)
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
 	ret
-ENDPROC(get_sev_encryption_bit)
+SYM_FUNC_END(get_sev_encryption_bit)
 
 	.code64
-ENTRY(set_sev_encryption_mask)
+SYM_FUNC_START(set_sev_encryption_mask)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	push	%rbp
 	push	%rdx
@@ -90,7 +90,7 @@ ENTRY(set_sev_encryption_mask)
 
 	xor	%rax, %rax
 	ret
-ENDPROC(set_sev_encryption_mask)
+SYM_FUNC_END(set_sev_encryption_mask)
 
 	.data
 
diff --git a/arch/x86/crypto/aegis128-aesni-asm.S b/arch/x86/crypto/aegis128-aesni-asm.S
index b7026fdef4ff..51d46d93efbc 100644
--- a/arch/x86/crypto/aegis128-aesni-asm.S
+++ b/arch/x86/crypto/aegis128-aesni-asm.S
@@ -186,7 +186,7 @@ SYM_FUNC_END(__store_partial)
 /*
  * void crypto_aegis128_aesni_init(void *state, const void *key, const void *iv);
  */
-ENTRY(crypto_aegis128_aesni_init)
+SYM_FUNC_START(crypto_aegis128_aesni_init)
 	FRAME_BEGIN
 
 	/* load IV: */
@@ -226,13 +226,13 @@ ENTRY(crypto_aegis128_aesni_init)
 
 	FRAME_END
 	ret
-ENDPROC(crypto_aegis128_aesni_init)
+SYM_FUNC_END(crypto_aegis128_aesni_init)
 
 /*
  * void crypto_aegis128_aesni_ad(void *state, unsigned int length,
  *                               const void *data);
  */
-ENTRY(crypto_aegis128_aesni_ad)
+SYM_FUNC_START(crypto_aegis128_aesni_ad)
 	FRAME_BEGIN
 
 	cmp $0x10, LEN
@@ -378,7 +378,7 @@ ENTRY(crypto_aegis128_aesni_ad)
 .Lad_out:
 	FRAME_END
 	ret
-ENDPROC(crypto_aegis128_aesni_ad)
+SYM_FUNC_END(crypto_aegis128_aesni_ad)
 
 .macro encrypt_block a s0 s1 s2 s3 s4 i
 	movdq\a (\i * 0x10)(SRC), MSG
@@ -402,7 +402,7 @@ ENDPROC(crypto_aegis128_aesni_ad)
  * void crypto_aegis128_aesni_enc(void *state, unsigned int length,
  *                                const void *src, void *dst);
  */
-ENTRY(crypto_aegis128_aesni_enc)
+SYM_FUNC_START(crypto_aegis128_aesni_enc)
 	FRAME_BEGIN
 
 	cmp $0x10, LEN
@@ -493,13 +493,13 @@ ENTRY(crypto_aegis128_aesni_enc)
 .Lenc_out:
 	FRAME_END
 	ret
-ENDPROC(crypto_aegis128_aesni_enc)
+SYM_FUNC_END(crypto_aegis128_aesni_enc)
 
 /*
  * void crypto_aegis128_aesni_enc_tail(void *state, unsigned int length,
  *                                     const void *src, void *dst);
  */
-ENTRY(crypto_aegis128_aesni_enc_tail)
+SYM_FUNC_START(crypto_aegis128_aesni_enc_tail)
 	FRAME_BEGIN
 
 	/* load the state: */
@@ -533,7 +533,7 @@ ENTRY(crypto_aegis128_aesni_enc_tail)
 
 	FRAME_END
 	ret
-ENDPROC(crypto_aegis128_aesni_enc_tail)
+SYM_FUNC_END(crypto_aegis128_aesni_enc_tail)
 
 .macro decrypt_block a s0 s1 s2 s3 s4 i
 	movdq\a (\i * 0x10)(SRC), MSG
@@ -556,7 +556,7 @@ ENDPROC(crypto_aegis128_aesni_enc_tail)
  * void crypto_aegis128_aesni_dec(void *state, unsigned int length,
  *                                const void *src, void *dst);
  */
-ENTRY(crypto_aegis128_aesni_dec)
+SYM_FUNC_START(crypto_aegis128_aesni_dec)
 	FRAME_BEGIN
 
 	cmp $0x10, LEN
@@ -647,13 +647,13 @@ ENTRY(crypto_aegis128_aesni_dec)
 .Ldec_out:
 	FRAME_END
 	ret
-ENDPROC(crypto_aegis128_aesni_dec)
+SYM_FUNC_END(crypto_aegis128_aesni_dec)
 
 /*
  * void crypto_aegis128_aesni_dec_tail(void *state, unsigned int length,
  *                                     const void *src, void *dst);
  */
-ENTRY(crypto_aegis128_aesni_dec_tail)
+SYM_FUNC_START(crypto_aegis128_aesni_dec_tail)
 	FRAME_BEGIN
 
 	/* load the state: */
@@ -697,13 +697,13 @@ ENTRY(crypto_aegis128_aesni_dec_tail)
 
 	FRAME_END
 	ret
-ENDPROC(crypto_aegis128_aesni_dec_tail)
+SYM_FUNC_END(crypto_aegis128_aesni_dec_tail)
 
 /*
  * void crypto_aegis128_aesni_final(void *state, void *tag_xor,
  *                                  u64 assoclen, u64 cryptlen);
  */
-ENTRY(crypto_aegis128_aesni_final)
+SYM_FUNC_START(crypto_aegis128_aesni_final)
 	FRAME_BEGIN
 
 	/* load the state: */
@@ -744,4 +744,4 @@ ENTRY(crypto_aegis128_aesni_final)
 
 	FRAME_END
 	ret
-ENDPROC(crypto_aegis128_aesni_final)
+SYM_FUNC_END(crypto_aegis128_aesni_final)
diff --git a/arch/x86/crypto/aes_ctrby8_avx-x86_64.S b/arch/x86/crypto/aes_ctrby8_avx-x86_64.S
index 5f6a5af9c489..ec437db1fa54 100644
--- a/arch/x86/crypto/aes_ctrby8_avx-x86_64.S
+++ b/arch/x86/crypto/aes_ctrby8_avx-x86_64.S
@@ -544,11 +544,11 @@ ddq_add_8:
  * aes_ctr_enc_128_avx_by8(void *in, void *iv, void *keys, void *out,
  *			unsigned int num_bytes)
  */
-ENTRY(aes_ctr_enc_128_avx_by8)
+SYM_FUNC_START(aes_ctr_enc_128_avx_by8)
 	/* call the aes main loop */
 	do_aes_ctrmain KEY_128
 
-ENDPROC(aes_ctr_enc_128_avx_by8)
+SYM_FUNC_END(aes_ctr_enc_128_avx_by8)
 
 /*
  * routine to do AES192 CTR enc/decrypt "by8"
@@ -557,11 +557,11 @@ ENDPROC(aes_ctr_enc_128_avx_by8)
  * aes_ctr_enc_192_avx_by8(void *in, void *iv, void *keys, void *out,
  *			unsigned int num_bytes)
  */
-ENTRY(aes_ctr_enc_192_avx_by8)
+SYM_FUNC_START(aes_ctr_enc_192_avx_by8)
 	/* call the aes main loop */
 	do_aes_ctrmain KEY_192
 
-ENDPROC(aes_ctr_enc_192_avx_by8)
+SYM_FUNC_END(aes_ctr_enc_192_avx_by8)
 
 /*
  * routine to do AES256 CTR enc/decrypt "by8"
@@ -570,8 +570,8 @@ ENDPROC(aes_ctr_enc_192_avx_by8)
  * aes_ctr_enc_256_avx_by8(void *in, void *iv, void *keys, void *out,
  *			unsigned int num_bytes)
  */
-ENTRY(aes_ctr_enc_256_avx_by8)
+SYM_FUNC_START(aes_ctr_enc_256_avx_by8)
 	/* call the aes main loop */
 	do_aes_ctrmain KEY_256
 
-ENDPROC(aes_ctr_enc_256_avx_by8)
+SYM_FUNC_END(aes_ctr_enc_256_avx_by8)
diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 9d8d5f2296e1..d28503f99f58 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -1592,7 +1592,7 @@ _esb_loop_\@:
 * poly = x^128 + x^127 + x^126 + x^121 + 1
 *
 *****************************************************************************/
-ENTRY(aesni_gcm_dec)
+SYM_FUNC_START(aesni_gcm_dec)
 	FUNC_SAVE
 
 	GCM_INIT %arg6, arg7, arg8, arg9
@@ -1600,7 +1600,7 @@ ENTRY(aesni_gcm_dec)
 	GCM_COMPLETE arg10, arg11
 	FUNC_RESTORE
 	ret
-ENDPROC(aesni_gcm_dec)
+SYM_FUNC_END(aesni_gcm_dec)
 
 
 /*****************************************************************************
@@ -1680,7 +1680,7 @@ ENDPROC(aesni_gcm_dec)
 *
 * poly = x^128 + x^127 + x^126 + x^121 + 1
 ***************************************************************************/
-ENTRY(aesni_gcm_enc)
+SYM_FUNC_START(aesni_gcm_enc)
 	FUNC_SAVE
 
 	GCM_INIT %arg6, arg7, arg8, arg9
@@ -1689,7 +1689,7 @@ ENTRY(aesni_gcm_enc)
 	GCM_COMPLETE arg10, arg11
 	FUNC_RESTORE
 	ret
-ENDPROC(aesni_gcm_enc)
+SYM_FUNC_END(aesni_gcm_enc)
 
 /*****************************************************************************
 * void aesni_gcm_init(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
@@ -1702,12 +1702,12 @@ ENDPROC(aesni_gcm_enc)
 *                     const u8 *aad,      // Additional Authentication Data (AAD)
 *                     u64 aad_len)        // Length of AAD in bytes.
 */
-ENTRY(aesni_gcm_init)
+SYM_FUNC_START(aesni_gcm_init)
 	FUNC_SAVE
 	GCM_INIT %arg3, %arg4,%arg5, %arg6
 	FUNC_RESTORE
 	ret
-ENDPROC(aesni_gcm_init)
+SYM_FUNC_END(aesni_gcm_init)
 
 /*****************************************************************************
 * void aesni_gcm_enc_update(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
@@ -1717,12 +1717,12 @@ ENDPROC(aesni_gcm_init)
 *                    const u8 *in,       // Plaintext input
 *                    u64 plaintext_len,  // Length of data in bytes for encryption.
 */
-ENTRY(aesni_gcm_enc_update)
+SYM_FUNC_START(aesni_gcm_enc_update)
 	FUNC_SAVE
 	GCM_ENC_DEC enc
 	FUNC_RESTORE
 	ret
-ENDPROC(aesni_gcm_enc_update)
+SYM_FUNC_END(aesni_gcm_enc_update)
 
 /*****************************************************************************
 * void aesni_gcm_dec_update(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
@@ -1732,12 +1732,12 @@ ENDPROC(aesni_gcm_enc_update)
 *                    const u8 *in,       // Plaintext input
 *                    u64 plaintext_len,  // Length of data in bytes for encryption.
 */
-ENTRY(aesni_gcm_dec_update)
+SYM_FUNC_START(aesni_gcm_dec_update)
 	FUNC_SAVE
 	GCM_ENC_DEC dec
 	FUNC_RESTORE
 	ret
-ENDPROC(aesni_gcm_dec_update)
+SYM_FUNC_END(aesni_gcm_dec_update)
 
 /*****************************************************************************
 * void aesni_gcm_finalize(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
@@ -1747,12 +1747,12 @@ ENDPROC(aesni_gcm_dec_update)
 *                    u64 auth_tag_len);  // Authenticated Tag Length in bytes. Valid values are 16 (most likely),
 *                                        // 12 or 8.
 */
-ENTRY(aesni_gcm_finalize)
+SYM_FUNC_START(aesni_gcm_finalize)
 	FUNC_SAVE
 	GCM_COMPLETE %arg3 %arg4
 	FUNC_RESTORE
 	ret
-ENDPROC(aesni_gcm_finalize)
+SYM_FUNC_END(aesni_gcm_finalize)
 
 #endif
 
@@ -1830,7 +1830,7 @@ SYM_FUNC_END(_key_expansion_256b)
  * int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
  *                   unsigned int key_len)
  */
-ENTRY(aesni_set_key)
+SYM_FUNC_START(aesni_set_key)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl KEYP
@@ -1939,12 +1939,12 @@ ENTRY(aesni_set_key)
 #endif
 	FRAME_END
 	ret
-ENDPROC(aesni_set_key)
+SYM_FUNC_END(aesni_set_key)
 
 /*
  * void aesni_enc(struct crypto_aes_ctx *ctx, u8 *dst, const u8 *src)
  */
-ENTRY(aesni_enc)
+SYM_FUNC_START(aesni_enc)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl KEYP
@@ -1963,7 +1963,7 @@ ENTRY(aesni_enc)
 #endif
 	FRAME_END
 	ret
-ENDPROC(aesni_enc)
+SYM_FUNC_END(aesni_enc)
 
 /*
  * _aesni_enc1:		internal ABI
@@ -2133,7 +2133,7 @@ SYM_FUNC_END(_aesni_enc4)
 /*
  * void aesni_dec (struct crypto_aes_ctx *ctx, u8 *dst, const u8 *src)
  */
-ENTRY(aesni_dec)
+SYM_FUNC_START(aesni_dec)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl KEYP
@@ -2153,7 +2153,7 @@ ENTRY(aesni_dec)
 #endif
 	FRAME_END
 	ret
-ENDPROC(aesni_dec)
+SYM_FUNC_END(aesni_dec)
 
 /*
  * _aesni_dec1:		internal ABI
@@ -2324,7 +2324,7 @@ SYM_FUNC_END(_aesni_dec4)
  * void aesni_ecb_enc(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
  *		      size_t len)
  */
-ENTRY(aesni_ecb_enc)
+SYM_FUNC_START(aesni_ecb_enc)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl LEN
@@ -2378,13 +2378,13 @@ ENTRY(aesni_ecb_enc)
 #endif
 	FRAME_END
 	ret
-ENDPROC(aesni_ecb_enc)
+SYM_FUNC_END(aesni_ecb_enc)
 
 /*
  * void aesni_ecb_dec(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
  *		      size_t len);
  */
-ENTRY(aesni_ecb_dec)
+SYM_FUNC_START(aesni_ecb_dec)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl LEN
@@ -2439,13 +2439,13 @@ ENTRY(aesni_ecb_dec)
 #endif
 	FRAME_END
 	ret
-ENDPROC(aesni_ecb_dec)
+SYM_FUNC_END(aesni_ecb_dec)
 
 /*
  * void aesni_cbc_enc(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
  *		      size_t len, u8 *iv)
  */
-ENTRY(aesni_cbc_enc)
+SYM_FUNC_START(aesni_cbc_enc)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl IVP
@@ -2483,13 +2483,13 @@ ENTRY(aesni_cbc_enc)
 #endif
 	FRAME_END
 	ret
-ENDPROC(aesni_cbc_enc)
+SYM_FUNC_END(aesni_cbc_enc)
 
 /*
  * void aesni_cbc_dec(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
  *		      size_t len, u8 *iv)
  */
-ENTRY(aesni_cbc_dec)
+SYM_FUNC_START(aesni_cbc_dec)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl IVP
@@ -2576,7 +2576,7 @@ ENTRY(aesni_cbc_dec)
 #endif
 	FRAME_END
 	ret
-ENDPROC(aesni_cbc_dec)
+SYM_FUNC_END(aesni_cbc_dec)
 
 #ifdef __x86_64__
 .pushsection .rodata
@@ -2638,7 +2638,7 @@ SYM_FUNC_END(_aesni_inc)
  * void aesni_ctr_enc(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
  *		      size_t len, u8 *iv)
  */
-ENTRY(aesni_ctr_enc)
+SYM_FUNC_START(aesni_ctr_enc)
 	FRAME_BEGIN
 	cmp $16, LEN
 	jb .Lctr_enc_just_ret
@@ -2695,7 +2695,7 @@ ENTRY(aesni_ctr_enc)
 .Lctr_enc_just_ret:
 	FRAME_END
 	ret
-ENDPROC(aesni_ctr_enc)
+SYM_FUNC_END(aesni_ctr_enc)
 
 /*
  * _aesni_gf128mul_x_ble:		internal ABI
@@ -2719,7 +2719,7 @@ ENDPROC(aesni_ctr_enc)
  * void aesni_xts_crypt8(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
  *			 bool enc, u8 *iv)
  */
-ENTRY(aesni_xts_crypt8)
+SYM_FUNC_START(aesni_xts_crypt8)
 	FRAME_BEGIN
 	cmpb $0, %cl
 	movl $0, %ecx
@@ -2823,6 +2823,6 @@ ENTRY(aesni_xts_crypt8)
 
 	FRAME_END
 	ret
-ENDPROC(aesni_xts_crypt8)
+SYM_FUNC_END(aesni_xts_crypt8)
 
 #endif
diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aesni-intel_avx-x86_64.S
index 91c039ab5699..bfa1c0b3e5b4 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -1775,12 +1775,12 @@ _initial_blocks_done\@:
 #        const   u8 *aad, /* Additional Authentication Data (AAD)*/
 #        u64     aad_len) /* Length of AAD in bytes. With RFC4106 this is going to be 8 or 12 Bytes */
 #############################################################
-ENTRY(aesni_gcm_init_avx_gen2)
+SYM_FUNC_START(aesni_gcm_init_avx_gen2)
         FUNC_SAVE
         INIT GHASH_MUL_AVX, PRECOMPUTE_AVX
         FUNC_RESTORE
         ret
-ENDPROC(aesni_gcm_init_avx_gen2)
+SYM_FUNC_END(aesni_gcm_init_avx_gen2)
 
 ###############################################################################
 #void   aesni_gcm_enc_update_avx_gen2(
@@ -1790,7 +1790,7 @@ ENDPROC(aesni_gcm_init_avx_gen2)
 #        const   u8 *in, /* Plaintext input */
 #        u64     plaintext_len) /* Length of data in Bytes for encryption. */
 ###############################################################################
-ENTRY(aesni_gcm_enc_update_avx_gen2)
+SYM_FUNC_START(aesni_gcm_enc_update_avx_gen2)
         FUNC_SAVE
         mov     keysize, %eax
         cmp     $32, %eax
@@ -1809,7 +1809,7 @@ key_256_enc_update:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GHASH_LAST_8_AVX, GHASH_MUL_AVX, ENC, 13
         FUNC_RESTORE
         ret
-ENDPROC(aesni_gcm_enc_update_avx_gen2)
+SYM_FUNC_END(aesni_gcm_enc_update_avx_gen2)
 
 ###############################################################################
 #void   aesni_gcm_dec_update_avx_gen2(
@@ -1819,7 +1819,7 @@ ENDPROC(aesni_gcm_enc_update_avx_gen2)
 #        const   u8 *in, /* Ciphertext input */
 #        u64     plaintext_len) /* Length of data in Bytes for encryption. */
 ###############################################################################
-ENTRY(aesni_gcm_dec_update_avx_gen2)
+SYM_FUNC_START(aesni_gcm_dec_update_avx_gen2)
         FUNC_SAVE
         mov     keysize,%eax
         cmp     $32, %eax
@@ -1838,7 +1838,7 @@ key_256_dec_update:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GHASH_LAST_8_AVX, GHASH_MUL_AVX, DEC, 13
         FUNC_RESTORE
         ret
-ENDPROC(aesni_gcm_dec_update_avx_gen2)
+SYM_FUNC_END(aesni_gcm_dec_update_avx_gen2)
 
 ###############################################################################
 #void   aesni_gcm_finalize_avx_gen2(
@@ -1848,7 +1848,7 @@ ENDPROC(aesni_gcm_dec_update_avx_gen2)
 #        u64     auth_tag_len)# /* Authenticated Tag Length in bytes.
 #				Valid values are 16 (most likely), 12 or 8. */
 ###############################################################################
-ENTRY(aesni_gcm_finalize_avx_gen2)
+SYM_FUNC_START(aesni_gcm_finalize_avx_gen2)
         FUNC_SAVE
         mov	keysize,%eax
         cmp     $32, %eax
@@ -1867,7 +1867,7 @@ key_256_finalize:
         GCM_COMPLETE GHASH_MUL_AVX, 13, arg3, arg4
         FUNC_RESTORE
         ret
-ENDPROC(aesni_gcm_finalize_avx_gen2)
+SYM_FUNC_END(aesni_gcm_finalize_avx_gen2)
 
 #endif /* CONFIG_AS_AVX */
 
@@ -2746,12 +2746,12 @@ _initial_blocks_done\@:
 #        const   u8 *aad, /* Additional Authentication Data (AAD)*/
 #        u64     aad_len) /* Length of AAD in bytes. With RFC4106 this is going to be 8 or 12 Bytes */
 #############################################################
-ENTRY(aesni_gcm_init_avx_gen4)
+SYM_FUNC_START(aesni_gcm_init_avx_gen4)
         FUNC_SAVE
         INIT GHASH_MUL_AVX2, PRECOMPUTE_AVX2
         FUNC_RESTORE
         ret
-ENDPROC(aesni_gcm_init_avx_gen4)
+SYM_FUNC_END(aesni_gcm_init_avx_gen4)
 
 ###############################################################################
 #void   aesni_gcm_enc_avx_gen4(
@@ -2761,7 +2761,7 @@ ENDPROC(aesni_gcm_init_avx_gen4)
 #        const   u8 *in, /* Plaintext input */
 #        u64     plaintext_len) /* Length of data in Bytes for encryption. */
 ###############################################################################
-ENTRY(aesni_gcm_enc_update_avx_gen4)
+SYM_FUNC_START(aesni_gcm_enc_update_avx_gen4)
         FUNC_SAVE
         mov     keysize,%eax
         cmp     $32, %eax
@@ -2780,7 +2780,7 @@ key_256_enc_update4:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, ENC, 13
         FUNC_RESTORE
 	ret
-ENDPROC(aesni_gcm_enc_update_avx_gen4)
+SYM_FUNC_END(aesni_gcm_enc_update_avx_gen4)
 
 ###############################################################################
 #void   aesni_gcm_dec_update_avx_gen4(
@@ -2790,7 +2790,7 @@ ENDPROC(aesni_gcm_enc_update_avx_gen4)
 #        const   u8 *in, /* Ciphertext input */
 #        u64     plaintext_len) /* Length of data in Bytes for encryption. */
 ###############################################################################
-ENTRY(aesni_gcm_dec_update_avx_gen4)
+SYM_FUNC_START(aesni_gcm_dec_update_avx_gen4)
         FUNC_SAVE
         mov     keysize,%eax
         cmp     $32, %eax
@@ -2809,7 +2809,7 @@ key_256_dec_update4:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, DEC, 13
         FUNC_RESTORE
         ret
-ENDPROC(aesni_gcm_dec_update_avx_gen4)
+SYM_FUNC_END(aesni_gcm_dec_update_avx_gen4)
 
 ###############################################################################
 #void   aesni_gcm_finalize_avx_gen4(
@@ -2819,7 +2819,7 @@ ENDPROC(aesni_gcm_dec_update_avx_gen4)
 #        u64     auth_tag_len)# /* Authenticated Tag Length in bytes.
 #                              Valid values are 16 (most likely), 12 or 8. */
 ###############################################################################
-ENTRY(aesni_gcm_finalize_avx_gen4)
+SYM_FUNC_START(aesni_gcm_finalize_avx_gen4)
         FUNC_SAVE
         mov	keysize,%eax
         cmp     $32, %eax
@@ -2838,6 +2838,6 @@ key_256_finalize4:
         GCM_COMPLETE GHASH_MUL_AVX2, 13, arg3, arg4
         FUNC_RESTORE
         ret
-ENDPROC(aesni_gcm_finalize_avx_gen4)
+SYM_FUNC_END(aesni_gcm_finalize_avx_gen4)
 
 #endif /* CONFIG_AS_AVX2 */
diff --git a/arch/x86/crypto/blowfish-x86_64-asm_64.S b/arch/x86/crypto/blowfish-x86_64-asm_64.S
index 330db7a48af8..4222ac6d6584 100644
--- a/arch/x86/crypto/blowfish-x86_64-asm_64.S
+++ b/arch/x86/crypto/blowfish-x86_64-asm_64.S
@@ -103,7 +103,7 @@
 	bswapq 			RX0; \
 	xorq RX0, 		(RIO);
 
-ENTRY(__blowfish_enc_blk)
+SYM_FUNC_START(__blowfish_enc_blk)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -139,9 +139,9 @@ ENTRY(__blowfish_enc_blk)
 .L__enc_xor:
 	xor_block();
 	ret;
-ENDPROC(__blowfish_enc_blk)
+SYM_FUNC_END(__blowfish_enc_blk)
 
-ENTRY(blowfish_dec_blk)
+SYM_FUNC_START(blowfish_dec_blk)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -171,7 +171,7 @@ ENTRY(blowfish_dec_blk)
 	movq %r11, %r12;
 
 	ret;
-ENDPROC(blowfish_dec_blk)
+SYM_FUNC_END(blowfish_dec_blk)
 
 /**********************************************************************
   4-way blowfish, four blocks parallel
@@ -283,7 +283,7 @@ ENDPROC(blowfish_dec_blk)
 	bswapq 			RX3; \
 	xorq RX3,		24(RIO);
 
-ENTRY(__blowfish_enc_blk_4way)
+SYM_FUNC_START(__blowfish_enc_blk_4way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -330,9 +330,9 @@ ENTRY(__blowfish_enc_blk_4way)
 	popq %rbx;
 	popq %r12;
 	ret;
-ENDPROC(__blowfish_enc_blk_4way)
+SYM_FUNC_END(__blowfish_enc_blk_4way)
 
-ENTRY(blowfish_dec_blk_4way)
+SYM_FUNC_START(blowfish_dec_blk_4way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -365,4 +365,4 @@ ENTRY(blowfish_dec_blk_4way)
 	popq %r12;
 
 	ret;
-ENDPROC(blowfish_dec_blk_4way)
+SYM_FUNC_END(blowfish_dec_blk_4way)
diff --git a/arch/x86/crypto/camellia-aesni-avx-asm_64.S b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
index f4408ca55fdb..d01ddd73de65 100644
--- a/arch/x86/crypto/camellia-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
@@ -893,7 +893,7 @@ SYM_FUNC_START_LOCAL(__camellia_dec_blk16)
 	jmp .Ldec_max24;
 SYM_FUNC_END(__camellia_dec_blk16)
 
-ENTRY(camellia_ecb_enc_16way)
+SYM_FUNC_START(camellia_ecb_enc_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (16 blocks)
@@ -916,9 +916,9 @@ ENTRY(camellia_ecb_enc_16way)
 
 	FRAME_END
 	ret;
-ENDPROC(camellia_ecb_enc_16way)
+SYM_FUNC_END(camellia_ecb_enc_16way)
 
-ENTRY(camellia_ecb_dec_16way)
+SYM_FUNC_START(camellia_ecb_dec_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (16 blocks)
@@ -946,9 +946,9 @@ ENTRY(camellia_ecb_dec_16way)
 
 	FRAME_END
 	ret;
-ENDPROC(camellia_ecb_dec_16way)
+SYM_FUNC_END(camellia_ecb_dec_16way)
 
-ENTRY(camellia_cbc_dec_16way)
+SYM_FUNC_START(camellia_cbc_dec_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (16 blocks)
@@ -997,7 +997,7 @@ ENTRY(camellia_cbc_dec_16way)
 
 	FRAME_END
 	ret;
-ENDPROC(camellia_cbc_dec_16way)
+SYM_FUNC_END(camellia_cbc_dec_16way)
 
 #define inc_le128(x, minus_one, tmp) \
 	vpcmpeqq minus_one, x, tmp; \
@@ -1005,7 +1005,7 @@ ENDPROC(camellia_cbc_dec_16way)
 	vpslldq $8, tmp, tmp; \
 	vpsubq tmp, x, x;
 
-ENTRY(camellia_ctr_16way)
+SYM_FUNC_START(camellia_ctr_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (16 blocks)
@@ -1110,7 +1110,7 @@ ENTRY(camellia_ctr_16way)
 
 	FRAME_END
 	ret;
-ENDPROC(camellia_ctr_16way)
+SYM_FUNC_END(camellia_ctr_16way)
 
 #define gf128mul_x_ble(iv, mask, tmp) \
 	vpsrad $31, iv, tmp; \
@@ -1256,7 +1256,7 @@ SYM_FUNC_START_LOCAL(camellia_xts_crypt_16way)
 	ret;
 SYM_FUNC_END(camellia_xts_crypt_16way)
 
-ENTRY(camellia_xts_enc_16way)
+SYM_FUNC_START(camellia_xts_enc_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (16 blocks)
@@ -1268,9 +1268,9 @@ ENTRY(camellia_xts_enc_16way)
 	leaq __camellia_enc_blk16, %r9;
 
 	jmp camellia_xts_crypt_16way;
-ENDPROC(camellia_xts_enc_16way)
+SYM_FUNC_END(camellia_xts_enc_16way)
 
-ENTRY(camellia_xts_dec_16way)
+SYM_FUNC_START(camellia_xts_dec_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (16 blocks)
@@ -1286,4 +1286,4 @@ ENTRY(camellia_xts_dec_16way)
 	leaq __camellia_dec_blk16, %r9;
 
 	jmp camellia_xts_crypt_16way;
-ENDPROC(camellia_xts_dec_16way)
+SYM_FUNC_END(camellia_xts_dec_16way)
diff --git a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
index 72ae3edd0997..563ef6e83cdd 100644
--- a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
@@ -931,7 +931,7 @@ SYM_FUNC_START_LOCAL(__camellia_dec_blk32)
 	jmp .Ldec_max24;
 SYM_FUNC_END(__camellia_dec_blk32)
 
-ENTRY(camellia_ecb_enc_32way)
+SYM_FUNC_START(camellia_ecb_enc_32way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (32 blocks)
@@ -958,9 +958,9 @@ ENTRY(camellia_ecb_enc_32way)
 
 	FRAME_END
 	ret;
-ENDPROC(camellia_ecb_enc_32way)
+SYM_FUNC_END(camellia_ecb_enc_32way)
 
-ENTRY(camellia_ecb_dec_32way)
+SYM_FUNC_START(camellia_ecb_dec_32way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (32 blocks)
@@ -992,9 +992,9 @@ ENTRY(camellia_ecb_dec_32way)
 
 	FRAME_END
 	ret;
-ENDPROC(camellia_ecb_dec_32way)
+SYM_FUNC_END(camellia_ecb_dec_32way)
 
-ENTRY(camellia_cbc_dec_32way)
+SYM_FUNC_START(camellia_cbc_dec_32way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (32 blocks)
@@ -1060,7 +1060,7 @@ ENTRY(camellia_cbc_dec_32way)
 
 	FRAME_END
 	ret;
-ENDPROC(camellia_cbc_dec_32way)
+SYM_FUNC_END(camellia_cbc_dec_32way)
 
 #define inc_le128(x, minus_one, tmp) \
 	vpcmpeqq minus_one, x, tmp; \
@@ -1076,7 +1076,7 @@ ENDPROC(camellia_cbc_dec_32way)
 	vpslldq $8, tmp1, tmp1; \
 	vpsubq tmp1, x, x;
 
-ENTRY(camellia_ctr_32way)
+SYM_FUNC_START(camellia_ctr_32way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (32 blocks)
@@ -1200,7 +1200,7 @@ ENTRY(camellia_ctr_32way)
 
 	FRAME_END
 	ret;
-ENDPROC(camellia_ctr_32way)
+SYM_FUNC_END(camellia_ctr_32way)
 
 #define gf128mul_x_ble(iv, mask, tmp) \
 	vpsrad $31, iv, tmp; \
@@ -1369,7 +1369,7 @@ SYM_FUNC_START_LOCAL(camellia_xts_crypt_32way)
 	ret;
 SYM_FUNC_END(camellia_xts_crypt_32way)
 
-ENTRY(camellia_xts_enc_32way)
+SYM_FUNC_START(camellia_xts_enc_32way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (32 blocks)
@@ -1382,9 +1382,9 @@ ENTRY(camellia_xts_enc_32way)
 	leaq __camellia_enc_blk32, %r9;
 
 	jmp camellia_xts_crypt_32way;
-ENDPROC(camellia_xts_enc_32way)
+SYM_FUNC_END(camellia_xts_enc_32way)
 
-ENTRY(camellia_xts_dec_32way)
+SYM_FUNC_START(camellia_xts_dec_32way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (32 blocks)
@@ -1400,4 +1400,4 @@ ENTRY(camellia_xts_dec_32way)
 	leaq __camellia_dec_blk32, %r9;
 
 	jmp camellia_xts_crypt_32way;
-ENDPROC(camellia_xts_dec_32way)
+SYM_FUNC_END(camellia_xts_dec_32way)
diff --git a/arch/x86/crypto/camellia-x86_64-asm_64.S b/arch/x86/crypto/camellia-x86_64-asm_64.S
index 23528bc18fc6..1372e6408850 100644
--- a/arch/x86/crypto/camellia-x86_64-asm_64.S
+++ b/arch/x86/crypto/camellia-x86_64-asm_64.S
@@ -175,7 +175,7 @@
 	bswapq				RAB0; \
 	movq RAB0,			4*2(RIO);
 
-ENTRY(__camellia_enc_blk)
+SYM_FUNC_START(__camellia_enc_blk)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -220,9 +220,9 @@ ENTRY(__camellia_enc_blk)
 
 	movq RR12, %r12;
 	ret;
-ENDPROC(__camellia_enc_blk)
+SYM_FUNC_END(__camellia_enc_blk)
 
-ENTRY(camellia_dec_blk)
+SYM_FUNC_START(camellia_dec_blk)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -258,7 +258,7 @@ ENTRY(camellia_dec_blk)
 
 	movq RR12, %r12;
 	ret;
-ENDPROC(camellia_dec_blk)
+SYM_FUNC_END(camellia_dec_blk)
 
 /**********************************************************************
   2-way camellia
@@ -409,7 +409,7 @@ ENDPROC(camellia_dec_blk)
 		bswapq				RAB1; \
 		movq RAB1,			12*2(RIO);
 
-ENTRY(__camellia_enc_blk_2way)
+SYM_FUNC_START(__camellia_enc_blk_2way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -456,9 +456,9 @@ ENTRY(__camellia_enc_blk_2way)
 	movq RR12, %r12;
 	popq %rbx;
 	ret;
-ENDPROC(__camellia_enc_blk_2way)
+SYM_FUNC_END(__camellia_enc_blk_2way)
 
-ENTRY(camellia_dec_blk_2way)
+SYM_FUNC_START(camellia_dec_blk_2way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -496,4 +496,4 @@ ENTRY(camellia_dec_blk_2way)
 	movq RR12, %r12;
 	movq RXOR, %rbx;
 	ret;
-ENDPROC(camellia_dec_blk_2way)
+SYM_FUNC_END(camellia_dec_blk_2way)
diff --git a/arch/x86/crypto/cast5-avx-x86_64-asm_64.S b/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
index ef86c6a966de..8a6181b08b59 100644
--- a/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
@@ -359,7 +359,7 @@ SYM_FUNC_START_LOCAL(__cast5_dec_blk16)
 	jmp .L__dec_tail;
 SYM_FUNC_END(__cast5_dec_blk16)
 
-ENTRY(cast5_ecb_enc_16way)
+SYM_FUNC_START(cast5_ecb_enc_16way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -394,9 +394,9 @@ ENTRY(cast5_ecb_enc_16way)
 	popq %r15;
 	FRAME_END
 	ret;
-ENDPROC(cast5_ecb_enc_16way)
+SYM_FUNC_END(cast5_ecb_enc_16way)
 
-ENTRY(cast5_ecb_dec_16way)
+SYM_FUNC_START(cast5_ecb_dec_16way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -432,9 +432,9 @@ ENTRY(cast5_ecb_dec_16way)
 	popq %r15;
 	FRAME_END
 	ret;
-ENDPROC(cast5_ecb_dec_16way)
+SYM_FUNC_END(cast5_ecb_dec_16way)
 
-ENTRY(cast5_cbc_dec_16way)
+SYM_FUNC_START(cast5_cbc_dec_16way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -484,9 +484,9 @@ ENTRY(cast5_cbc_dec_16way)
 	popq %r12;
 	FRAME_END
 	ret;
-ENDPROC(cast5_cbc_dec_16way)
+SYM_FUNC_END(cast5_cbc_dec_16way)
 
-ENTRY(cast5_ctr_16way)
+SYM_FUNC_START(cast5_ctr_16way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -560,4 +560,4 @@ ENTRY(cast5_ctr_16way)
 	popq %r12;
 	FRAME_END
 	ret;
-ENDPROC(cast5_ctr_16way)
+SYM_FUNC_END(cast5_ctr_16way)
diff --git a/arch/x86/crypto/cast6-avx-x86_64-asm_64.S b/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
index b080a7454e70..932a3ce32a88 100644
--- a/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
@@ -341,7 +341,7 @@ SYM_FUNC_START_LOCAL(__cast6_dec_blk8)
 	ret;
 SYM_FUNC_END(__cast6_dec_blk8)
 
-ENTRY(cast6_ecb_enc_8way)
+SYM_FUNC_START(cast6_ecb_enc_8way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -362,9 +362,9 @@ ENTRY(cast6_ecb_enc_8way)
 	popq %r15;
 	FRAME_END
 	ret;
-ENDPROC(cast6_ecb_enc_8way)
+SYM_FUNC_END(cast6_ecb_enc_8way)
 
-ENTRY(cast6_ecb_dec_8way)
+SYM_FUNC_START(cast6_ecb_dec_8way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -385,9 +385,9 @@ ENTRY(cast6_ecb_dec_8way)
 	popq %r15;
 	FRAME_END
 	ret;
-ENDPROC(cast6_ecb_dec_8way)
+SYM_FUNC_END(cast6_ecb_dec_8way)
 
-ENTRY(cast6_cbc_dec_8way)
+SYM_FUNC_START(cast6_cbc_dec_8way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -411,9 +411,9 @@ ENTRY(cast6_cbc_dec_8way)
 	popq %r12;
 	FRAME_END
 	ret;
-ENDPROC(cast6_cbc_dec_8way)
+SYM_FUNC_END(cast6_cbc_dec_8way)
 
-ENTRY(cast6_ctr_8way)
+SYM_FUNC_START(cast6_ctr_8way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -439,9 +439,9 @@ ENTRY(cast6_ctr_8way)
 	popq %r12;
 	FRAME_END
 	ret;
-ENDPROC(cast6_ctr_8way)
+SYM_FUNC_END(cast6_ctr_8way)
 
-ENTRY(cast6_xts_enc_8way)
+SYM_FUNC_START(cast6_xts_enc_8way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -466,9 +466,9 @@ ENTRY(cast6_xts_enc_8way)
 	popq %r15;
 	FRAME_END
 	ret;
-ENDPROC(cast6_xts_enc_8way)
+SYM_FUNC_END(cast6_xts_enc_8way)
 
-ENTRY(cast6_xts_dec_8way)
+SYM_FUNC_START(cast6_xts_dec_8way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -493,4 +493,4 @@ ENTRY(cast6_xts_dec_8way)
 	popq %r15;
 	FRAME_END
 	ret;
-ENDPROC(cast6_xts_dec_8way)
+SYM_FUNC_END(cast6_xts_dec_8way)
diff --git a/arch/x86/crypto/chacha-avx2-x86_64.S b/arch/x86/crypto/chacha-avx2-x86_64.S
index 831e4434fc20..ee9a40ab4109 100644
--- a/arch/x86/crypto/chacha-avx2-x86_64.S
+++ b/arch/x86/crypto/chacha-avx2-x86_64.S
@@ -34,7 +34,7 @@ CTR4BL:	.octa 0x00000000000000000000000000000002
 
 .text
 
-ENTRY(chacha_2block_xor_avx2)
+SYM_FUNC_START(chacha_2block_xor_avx2)
 	# %rdi: Input state matrix, s
 	# %rsi: up to 2 data blocks output, o
 	# %rdx: up to 2 data blocks input, i
@@ -224,9 +224,9 @@ ENTRY(chacha_2block_xor_avx2)
 	lea		-8(%r10),%rsp
 	jmp		.Ldone2
 
-ENDPROC(chacha_2block_xor_avx2)
+SYM_FUNC_END(chacha_2block_xor_avx2)
 
-ENTRY(chacha_4block_xor_avx2)
+SYM_FUNC_START(chacha_4block_xor_avx2)
 	# %rdi: Input state matrix, s
 	# %rsi: up to 4 data blocks output, o
 	# %rdx: up to 4 data blocks input, i
@@ -529,9 +529,9 @@ ENTRY(chacha_4block_xor_avx2)
 	lea		-8(%r10),%rsp
 	jmp		.Ldone4
 
-ENDPROC(chacha_4block_xor_avx2)
+SYM_FUNC_END(chacha_4block_xor_avx2)
 
-ENTRY(chacha_8block_xor_avx2)
+SYM_FUNC_START(chacha_8block_xor_avx2)
 	# %rdi: Input state matrix, s
 	# %rsi: up to 8 data blocks output, o
 	# %rdx: up to 8 data blocks input, i
@@ -1018,4 +1018,4 @@ ENTRY(chacha_8block_xor_avx2)
 
 	jmp		.Ldone8
 
-ENDPROC(chacha_8block_xor_avx2)
+SYM_FUNC_END(chacha_8block_xor_avx2)
diff --git a/arch/x86/crypto/chacha-avx512vl-x86_64.S b/arch/x86/crypto/chacha-avx512vl-x86_64.S
index 848f9c75fd4f..bb193fde123a 100644
--- a/arch/x86/crypto/chacha-avx512vl-x86_64.S
+++ b/arch/x86/crypto/chacha-avx512vl-x86_64.S
@@ -24,7 +24,7 @@ CTR8BL:	.octa 0x00000003000000020000000100000000
 
 .text
 
-ENTRY(chacha_2block_xor_avx512vl)
+SYM_FUNC_START(chacha_2block_xor_avx512vl)
 	# %rdi: Input state matrix, s
 	# %rsi: up to 2 data blocks output, o
 	# %rdx: up to 2 data blocks input, i
@@ -187,9 +187,9 @@ ENTRY(chacha_2block_xor_avx512vl)
 
 	jmp		.Ldone2
 
-ENDPROC(chacha_2block_xor_avx512vl)
+SYM_FUNC_END(chacha_2block_xor_avx512vl)
 
-ENTRY(chacha_4block_xor_avx512vl)
+SYM_FUNC_START(chacha_4block_xor_avx512vl)
 	# %rdi: Input state matrix, s
 	# %rsi: up to 4 data blocks output, o
 	# %rdx: up to 4 data blocks input, i
@@ -453,9 +453,9 @@ ENTRY(chacha_4block_xor_avx512vl)
 
 	jmp		.Ldone4
 
-ENDPROC(chacha_4block_xor_avx512vl)
+SYM_FUNC_END(chacha_4block_xor_avx512vl)
 
-ENTRY(chacha_8block_xor_avx512vl)
+SYM_FUNC_START(chacha_8block_xor_avx512vl)
 	# %rdi: Input state matrix, s
 	# %rsi: up to 8 data blocks output, o
 	# %rdx: up to 8 data blocks input, i
@@ -833,4 +833,4 @@ ENTRY(chacha_8block_xor_avx512vl)
 
 	jmp		.Ldone8
 
-ENDPROC(chacha_8block_xor_avx512vl)
+SYM_FUNC_END(chacha_8block_xor_avx512vl)
diff --git a/arch/x86/crypto/chacha-ssse3-x86_64.S b/arch/x86/crypto/chacha-ssse3-x86_64.S
index 361d2bfc253c..a38ab2512a6f 100644
--- a/arch/x86/crypto/chacha-ssse3-x86_64.S
+++ b/arch/x86/crypto/chacha-ssse3-x86_64.S
@@ -111,7 +111,7 @@ SYM_FUNC_START_LOCAL(chacha_permute)
 	ret
 SYM_FUNC_END(chacha_permute)
 
-ENTRY(chacha_block_xor_ssse3)
+SYM_FUNC_START(chacha_block_xor_ssse3)
 	# %rdi: Input state matrix, s
 	# %rsi: up to 1 data block output, o
 	# %rdx: up to 1 data block input, i
@@ -197,9 +197,9 @@ ENTRY(chacha_block_xor_ssse3)
 	lea		-8(%r10),%rsp
 	jmp		.Ldone
 
-ENDPROC(chacha_block_xor_ssse3)
+SYM_FUNC_END(chacha_block_xor_ssse3)
 
-ENTRY(hchacha_block_ssse3)
+SYM_FUNC_START(hchacha_block_ssse3)
 	# %rdi: Input state matrix, s
 	# %rsi: output (8 32-bit words)
 	# %edx: nrounds
@@ -218,9 +218,9 @@ ENTRY(hchacha_block_ssse3)
 
 	FRAME_END
 	ret
-ENDPROC(hchacha_block_ssse3)
+SYM_FUNC_END(hchacha_block_ssse3)
 
-ENTRY(chacha_4block_xor_ssse3)
+SYM_FUNC_START(chacha_4block_xor_ssse3)
 	# %rdi: Input state matrix, s
 	# %rsi: up to 4 data blocks output, o
 	# %rdx: up to 4 data blocks input, i
@@ -788,4 +788,4 @@ ENTRY(chacha_4block_xor_ssse3)
 
 	jmp		.Ldone4
 
-ENDPROC(chacha_4block_xor_ssse3)
+SYM_FUNC_END(chacha_4block_xor_ssse3)
diff --git a/arch/x86/crypto/crc32-pclmul_asm.S b/arch/x86/crypto/crc32-pclmul_asm.S
index 1c099dc08cc3..9fd28ff65bc2 100644
--- a/arch/x86/crypto/crc32-pclmul_asm.S
+++ b/arch/x86/crypto/crc32-pclmul_asm.S
@@ -103,7 +103,7 @@
  *	                     size_t len, uint crc32)
  */
 
-ENTRY(crc32_pclmul_le_16) /* buffer and buffer size are 16 bytes aligned */
+SYM_FUNC_START(crc32_pclmul_le_16) /* buffer and buffer size are 16 bytes aligned */
 	movdqa  (BUF), %xmm1
 	movdqa  0x10(BUF), %xmm2
 	movdqa  0x20(BUF), %xmm3
@@ -238,4 +238,4 @@ fold_64:
 	PEXTRD  0x01, %xmm1, %eax
 
 	ret
-ENDPROC(crc32_pclmul_le_16)
+SYM_FUNC_END(crc32_pclmul_le_16)
diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
index d9b734d0c8cc..0e6690e3618c 100644
--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -74,7 +74,7 @@
 # unsigned int crc_pcl(u8 *buffer, int len, unsigned int crc_init);
 
 .text
-ENTRY(crc_pcl)
+SYM_FUNC_START(crc_pcl)
 #define    bufp		%rdi
 #define    bufp_dw	%edi
 #define    bufp_w	%di
@@ -311,7 +311,7 @@ do_return:
 	popq    %rdi
 	popq    %rbx
         ret
-ENDPROC(crc_pcl)
+SYM_FUNC_END(crc_pcl)
 
 .section	.rodata, "a", @progbits
         ################################################################
diff --git a/arch/x86/crypto/crct10dif-pcl-asm_64.S b/arch/x86/crypto/crct10dif-pcl-asm_64.S
index 3d873e67749d..b2533d63030e 100644
--- a/arch/x86/crypto/crct10dif-pcl-asm_64.S
+++ b/arch/x86/crypto/crct10dif-pcl-asm_64.S
@@ -95,7 +95,7 @@
 # Assumes len >= 16.
 #
 .align 16
-ENTRY(crc_t10dif_pcl)
+SYM_FUNC_START(crc_t10dif_pcl)
 
 	movdqa	.Lbswap_mask(%rip), BSWAP_MASK
 
@@ -280,7 +280,7 @@ ENTRY(crc_t10dif_pcl)
 	jge	.Lfold_16_bytes_loop		# 32 <= len <= 255
 	add	$16, len
 	jmp	.Lhandle_partial_segment	# 17 <= len <= 31
-ENDPROC(crc_t10dif_pcl)
+SYM_FUNC_END(crc_t10dif_pcl)
 
 .section	.rodata, "a", @progbits
 .align 16
diff --git a/arch/x86/crypto/des3_ede-asm_64.S b/arch/x86/crypto/des3_ede-asm_64.S
index 7fca43099a5f..fac0fdc3f25d 100644
--- a/arch/x86/crypto/des3_ede-asm_64.S
+++ b/arch/x86/crypto/des3_ede-asm_64.S
@@ -162,7 +162,7 @@
 	movl   left##d,   (io); \
 	movl   right##d, 4(io);
 
-ENTRY(des3_ede_x86_64_crypt_blk)
+SYM_FUNC_START(des3_ede_x86_64_crypt_blk)
 	/* input:
 	 *	%rdi: round keys, CTX
 	 *	%rsi: dst
@@ -244,7 +244,7 @@ ENTRY(des3_ede_x86_64_crypt_blk)
 	popq %rbx;
 
 	ret;
-ENDPROC(des3_ede_x86_64_crypt_blk)
+SYM_FUNC_END(des3_ede_x86_64_crypt_blk)
 
 /***********************************************************************
  * 3-way 3DES
@@ -418,7 +418,7 @@ ENDPROC(des3_ede_x86_64_crypt_blk)
 #define __movq(src, dst) \
 	movq src, dst;
 
-ENTRY(des3_ede_x86_64_crypt_blk_3way)
+SYM_FUNC_START(des3_ede_x86_64_crypt_blk_3way)
 	/* input:
 	 *	%rdi: ctx, round keys
 	 *	%rsi: dst (3 blocks)
@@ -529,7 +529,7 @@ ENTRY(des3_ede_x86_64_crypt_blk_3way)
 	popq %rbx;
 
 	ret;
-ENDPROC(des3_ede_x86_64_crypt_blk_3way)
+SYM_FUNC_END(des3_ede_x86_64_crypt_blk_3way)
 
 .section	.rodata, "a", @progbits
 .align 16
diff --git a/arch/x86/crypto/ghash-clmulni-intel_asm.S b/arch/x86/crypto/ghash-clmulni-intel_asm.S
index e81da25a33ca..bb9735fbb865 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_asm.S
+++ b/arch/x86/crypto/ghash-clmulni-intel_asm.S
@@ -90,7 +90,7 @@ SYM_FUNC_START_LOCAL(__clmul_gf128mul_ble)
 SYM_FUNC_END(__clmul_gf128mul_ble)
 
 /* void clmul_ghash_mul(char *dst, const u128 *shash) */
-ENTRY(clmul_ghash_mul)
+SYM_FUNC_START(clmul_ghash_mul)
 	FRAME_BEGIN
 	movups (%rdi), DATA
 	movups (%rsi), SHASH
@@ -101,13 +101,13 @@ ENTRY(clmul_ghash_mul)
 	movups DATA, (%rdi)
 	FRAME_END
 	ret
-ENDPROC(clmul_ghash_mul)
+SYM_FUNC_END(clmul_ghash_mul)
 
 /*
  * void clmul_ghash_update(char *dst, const char *src, unsigned int srclen,
  *			   const u128 *shash);
  */
-ENTRY(clmul_ghash_update)
+SYM_FUNC_START(clmul_ghash_update)
 	FRAME_BEGIN
 	cmp $16, %rdx
 	jb .Lupdate_just_ret	# check length
@@ -130,4 +130,4 @@ ENTRY(clmul_ghash_update)
 .Lupdate_just_ret:
 	FRAME_END
 	ret
-ENDPROC(clmul_ghash_update)
+SYM_FUNC_END(clmul_ghash_update)
diff --git a/arch/x86/crypto/nh-avx2-x86_64.S b/arch/x86/crypto/nh-avx2-x86_64.S
index f7946ea1b704..b22c7b936272 100644
--- a/arch/x86/crypto/nh-avx2-x86_64.S
+++ b/arch/x86/crypto/nh-avx2-x86_64.S
@@ -69,7 +69,7 @@
  *
  * It's guaranteed that message_len % 16 == 0.
  */
-ENTRY(nh_avx2)
+SYM_FUNC_START(nh_avx2)
 
 	vmovdqu		0x00(KEY), K0
 	vmovdqu		0x10(KEY), K1
@@ -154,4 +154,4 @@ ENTRY(nh_avx2)
 	vpaddq		T4, T0, T0
 	vmovdqu		T0, (HASH)
 	ret
-ENDPROC(nh_avx2)
+SYM_FUNC_END(nh_avx2)
diff --git a/arch/x86/crypto/nh-sse2-x86_64.S b/arch/x86/crypto/nh-sse2-x86_64.S
index 51f52d4ab4bb..d7ae22dd6683 100644
--- a/arch/x86/crypto/nh-sse2-x86_64.S
+++ b/arch/x86/crypto/nh-sse2-x86_64.S
@@ -71,7 +71,7 @@
  *
  * It's guaranteed that message_len % 16 == 0.
  */
-ENTRY(nh_sse2)
+SYM_FUNC_START(nh_sse2)
 
 	movdqu		0x00(KEY), K0
 	movdqu		0x10(KEY), K1
@@ -120,4 +120,4 @@ ENTRY(nh_sse2)
 	movdqu		T0, 0x00(HASH)
 	movdqu		T1, 0x10(HASH)
 	ret
-ENDPROC(nh_sse2)
+SYM_FUNC_END(nh_sse2)
diff --git a/arch/x86/crypto/poly1305-avx2-x86_64.S b/arch/x86/crypto/poly1305-avx2-x86_64.S
index 8b341bc29d41..d6063feda9da 100644
--- a/arch/x86/crypto/poly1305-avx2-x86_64.S
+++ b/arch/x86/crypto/poly1305-avx2-x86_64.S
@@ -79,7 +79,7 @@ ORMASK:	.octa 0x00000000010000000000000001000000
 #define d3 %r12
 #define d4 %r13
 
-ENTRY(poly1305_4block_avx2)
+SYM_FUNC_START(poly1305_4block_avx2)
 	# %rdi: Accumulator h[5]
 	# %rsi: 64 byte input block m
 	# %rdx: Poly1305 key r[5]
@@ -387,4 +387,4 @@ ENTRY(poly1305_4block_avx2)
 	pop		%r12
 	pop		%rbx
 	ret
-ENDPROC(poly1305_4block_avx2)
+SYM_FUNC_END(poly1305_4block_avx2)
diff --git a/arch/x86/crypto/poly1305-sse2-x86_64.S b/arch/x86/crypto/poly1305-sse2-x86_64.S
index 5578f846e622..d8ea29b96640 100644
--- a/arch/x86/crypto/poly1305-sse2-x86_64.S
+++ b/arch/x86/crypto/poly1305-sse2-x86_64.S
@@ -46,7 +46,7 @@ ORMASK:	.octa 0x00000000010000000000000001000000
 #define d3 %r11
 #define d4 %r12
 
-ENTRY(poly1305_block_sse2)
+SYM_FUNC_START(poly1305_block_sse2)
 	# %rdi: Accumulator h[5]
 	# %rsi: 16 byte input block m
 	# %rdx: Poly1305 key r[5]
@@ -276,7 +276,7 @@ ENTRY(poly1305_block_sse2)
 	pop		%r12
 	pop		%rbx
 	ret
-ENDPROC(poly1305_block_sse2)
+SYM_FUNC_END(poly1305_block_sse2)
 
 
 #define u0 0x00(%r8)
@@ -301,7 +301,7 @@ ENDPROC(poly1305_block_sse2)
 #undef d0
 #define d0 %r13
 
-ENTRY(poly1305_2block_sse2)
+SYM_FUNC_START(poly1305_2block_sse2)
 	# %rdi: Accumulator h[5]
 	# %rsi: 16 byte input block m
 	# %rdx: Poly1305 key r[5]
@@ -587,4 +587,4 @@ ENTRY(poly1305_2block_sse2)
 	pop		%r12
 	pop		%rbx
 	ret
-ENDPROC(poly1305_2block_sse2)
+SYM_FUNC_END(poly1305_2block_sse2)
diff --git a/arch/x86/crypto/serpent-avx-x86_64-asm_64.S b/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
index a098aa015784..ba9e4c1e7f5c 100644
--- a/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
@@ -662,7 +662,7 @@ SYM_FUNC_START_LOCAL(__serpent_dec_blk8_avx)
 	ret;
 SYM_FUNC_END(__serpent_dec_blk8_avx)
 
-ENTRY(serpent_ecb_enc_8way_avx)
+SYM_FUNC_START(serpent_ecb_enc_8way_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -678,9 +678,9 @@ ENTRY(serpent_ecb_enc_8way_avx)
 
 	FRAME_END
 	ret;
-ENDPROC(serpent_ecb_enc_8way_avx)
+SYM_FUNC_END(serpent_ecb_enc_8way_avx)
 
-ENTRY(serpent_ecb_dec_8way_avx)
+SYM_FUNC_START(serpent_ecb_dec_8way_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -696,9 +696,9 @@ ENTRY(serpent_ecb_dec_8way_avx)
 
 	FRAME_END
 	ret;
-ENDPROC(serpent_ecb_dec_8way_avx)
+SYM_FUNC_END(serpent_ecb_dec_8way_avx)
 
-ENTRY(serpent_cbc_dec_8way_avx)
+SYM_FUNC_START(serpent_cbc_dec_8way_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -714,9 +714,9 @@ ENTRY(serpent_cbc_dec_8way_avx)
 
 	FRAME_END
 	ret;
-ENDPROC(serpent_cbc_dec_8way_avx)
+SYM_FUNC_END(serpent_cbc_dec_8way_avx)
 
-ENTRY(serpent_ctr_8way_avx)
+SYM_FUNC_START(serpent_ctr_8way_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -734,9 +734,9 @@ ENTRY(serpent_ctr_8way_avx)
 
 	FRAME_END
 	ret;
-ENDPROC(serpent_ctr_8way_avx)
+SYM_FUNC_END(serpent_ctr_8way_avx)
 
-ENTRY(serpent_xts_enc_8way_avx)
+SYM_FUNC_START(serpent_xts_enc_8way_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -756,9 +756,9 @@ ENTRY(serpent_xts_enc_8way_avx)
 
 	FRAME_END
 	ret;
-ENDPROC(serpent_xts_enc_8way_avx)
+SYM_FUNC_END(serpent_xts_enc_8way_avx)
 
-ENTRY(serpent_xts_dec_8way_avx)
+SYM_FUNC_START(serpent_xts_dec_8way_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -778,4 +778,4 @@ ENTRY(serpent_xts_dec_8way_avx)
 
 	FRAME_END
 	ret;
-ENDPROC(serpent_xts_dec_8way_avx)
+SYM_FUNC_END(serpent_xts_dec_8way_avx)
diff --git a/arch/x86/crypto/serpent-avx2-asm_64.S b/arch/x86/crypto/serpent-avx2-asm_64.S
index 6149ba80b4d1..c9648aeae705 100644
--- a/arch/x86/crypto/serpent-avx2-asm_64.S
+++ b/arch/x86/crypto/serpent-avx2-asm_64.S
@@ -668,7 +668,7 @@ SYM_FUNC_START_LOCAL(__serpent_dec_blk16)
 	ret;
 SYM_FUNC_END(__serpent_dec_blk16)
 
-ENTRY(serpent_ecb_enc_16way)
+SYM_FUNC_START(serpent_ecb_enc_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -688,9 +688,9 @@ ENTRY(serpent_ecb_enc_16way)
 
 	FRAME_END
 	ret;
-ENDPROC(serpent_ecb_enc_16way)
+SYM_FUNC_END(serpent_ecb_enc_16way)
 
-ENTRY(serpent_ecb_dec_16way)
+SYM_FUNC_START(serpent_ecb_dec_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -710,9 +710,9 @@ ENTRY(serpent_ecb_dec_16way)
 
 	FRAME_END
 	ret;
-ENDPROC(serpent_ecb_dec_16way)
+SYM_FUNC_END(serpent_ecb_dec_16way)
 
-ENTRY(serpent_cbc_dec_16way)
+SYM_FUNC_START(serpent_cbc_dec_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -733,9 +733,9 @@ ENTRY(serpent_cbc_dec_16way)
 
 	FRAME_END
 	ret;
-ENDPROC(serpent_cbc_dec_16way)
+SYM_FUNC_END(serpent_cbc_dec_16way)
 
-ENTRY(serpent_ctr_16way)
+SYM_FUNC_START(serpent_ctr_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (16 blocks)
@@ -758,9 +758,9 @@ ENTRY(serpent_ctr_16way)
 
 	FRAME_END
 	ret;
-ENDPROC(serpent_ctr_16way)
+SYM_FUNC_END(serpent_ctr_16way)
 
-ENTRY(serpent_xts_enc_16way)
+SYM_FUNC_START(serpent_xts_enc_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (16 blocks)
@@ -784,9 +784,9 @@ ENTRY(serpent_xts_enc_16way)
 
 	FRAME_END
 	ret;
-ENDPROC(serpent_xts_enc_16way)
+SYM_FUNC_END(serpent_xts_enc_16way)
 
-ENTRY(serpent_xts_dec_16way)
+SYM_FUNC_START(serpent_xts_dec_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (16 blocks)
@@ -810,4 +810,4 @@ ENTRY(serpent_xts_dec_16way)
 
 	FRAME_END
 	ret;
-ENDPROC(serpent_xts_dec_16way)
+SYM_FUNC_END(serpent_xts_dec_16way)
diff --git a/arch/x86/crypto/serpent-sse2-x86_64-asm_64.S b/arch/x86/crypto/serpent-sse2-x86_64-asm_64.S
index 5e0b3a3e97af..efb6dc17dc90 100644
--- a/arch/x86/crypto/serpent-sse2-x86_64-asm_64.S
+++ b/arch/x86/crypto/serpent-sse2-x86_64-asm_64.S
@@ -619,7 +619,7 @@
 	pxor t0,		x3; \
 	movdqu x3,		(3*4*4)(out);
 
-ENTRY(__serpent_enc_blk_8way)
+SYM_FUNC_START(__serpent_enc_blk_8way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -682,9 +682,9 @@ ENTRY(__serpent_enc_blk_8way)
 	xor_blocks(%rax, RA2, RB2, RC2, RD2, RK0, RK1, RK2);
 
 	ret;
-ENDPROC(__serpent_enc_blk_8way)
+SYM_FUNC_END(__serpent_enc_blk_8way)
 
-ENTRY(serpent_dec_blk_8way)
+SYM_FUNC_START(serpent_dec_blk_8way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -736,4 +736,4 @@ ENTRY(serpent_dec_blk_8way)
 	write_blocks(%rax, RC2, RD2, RB2, RE2, RK0, RK1, RK2);
 
 	ret;
-ENDPROC(serpent_dec_blk_8way)
+SYM_FUNC_END(serpent_dec_blk_8way)
diff --git a/arch/x86/crypto/sha1_avx2_x86_64_asm.S b/arch/x86/crypto/sha1_avx2_x86_64_asm.S
index 9f712a7dfd79..6decc85ef7b7 100644
--- a/arch/x86/crypto/sha1_avx2_x86_64_asm.S
+++ b/arch/x86/crypto/sha1_avx2_x86_64_asm.S
@@ -634,7 +634,7 @@ _loop3:
  * param: function's name
  */
 .macro SHA1_VECTOR_ASM  name
-	ENTRY(\name)
+	SYM_FUNC_START(\name)
 
 	push	%rbx
 	push	%r12
@@ -676,7 +676,7 @@ _loop3:
 
 	ret
 
-	ENDPROC(\name)
+	SYM_FUNC_END(\name)
 .endm
 
 .section .rodata
diff --git a/arch/x86/crypto/sha1_ni_asm.S b/arch/x86/crypto/sha1_ni_asm.S
index ebbdba72ae07..11efe3a45a1f 100644
--- a/arch/x86/crypto/sha1_ni_asm.S
+++ b/arch/x86/crypto/sha1_ni_asm.S
@@ -95,7 +95,7 @@
  */
 .text
 .align 32
-ENTRY(sha1_ni_transform)
+SYM_FUNC_START(sha1_ni_transform)
 	mov		%rsp, RSPSAVE
 	sub		$FRAME_SIZE, %rsp
 	and		$~0xF, %rsp
@@ -291,7 +291,7 @@ ENTRY(sha1_ni_transform)
 	mov		RSPSAVE, %rsp
 
 	ret
-ENDPROC(sha1_ni_transform)
+SYM_FUNC_END(sha1_ni_transform)
 
 .section	.rodata.cst16.PSHUFFLE_BYTE_FLIP_MASK, "aM", @progbits, 16
 .align 16
diff --git a/arch/x86/crypto/sha1_ssse3_asm.S b/arch/x86/crypto/sha1_ssse3_asm.S
index 99c5b8c4dc38..5d03c1173690 100644
--- a/arch/x86/crypto/sha1_ssse3_asm.S
+++ b/arch/x86/crypto/sha1_ssse3_asm.S
@@ -67,7 +67,7 @@
  * param: function's name
  */
 .macro SHA1_VECTOR_ASM  name
-	ENTRY(\name)
+	SYM_FUNC_START(\name)
 
 	push	%rbx
 	push	%r12
@@ -101,7 +101,7 @@
 	pop	%rbx
 	ret
 
-	ENDPROC(\name)
+	SYM_FUNC_END(\name)
 .endm
 
 /*
diff --git a/arch/x86/crypto/sha256-avx-asm.S b/arch/x86/crypto/sha256-avx-asm.S
index 001bbcf93c79..22e14c8dd2e4 100644
--- a/arch/x86/crypto/sha256-avx-asm.S
+++ b/arch/x86/crypto/sha256-avx-asm.S
@@ -347,7 +347,7 @@ a = TMP_
 ## arg 3 : Num blocks
 ########################################################################
 .text
-ENTRY(sha256_transform_avx)
+SYM_FUNC_START(sha256_transform_avx)
 .align 32
 	pushq   %rbx
 	pushq   %r12
@@ -460,7 +460,7 @@ done_hash:
 	popq	%r12
 	popq    %rbx
 	ret
-ENDPROC(sha256_transform_avx)
+SYM_FUNC_END(sha256_transform_avx)
 
 .section	.rodata.cst256.K256, "aM", @progbits, 256
 .align 64
diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/crypto/sha256-avx2-asm.S
index 1420db15dcdd..519b551ad576 100644
--- a/arch/x86/crypto/sha256-avx2-asm.S
+++ b/arch/x86/crypto/sha256-avx2-asm.S
@@ -526,7 +526,7 @@ STACK_SIZE	= _RSP      + _RSP_SIZE
 ## arg 3 : Num blocks
 ########################################################################
 .text
-ENTRY(sha256_transform_rorx)
+SYM_FUNC_START(sha256_transform_rorx)
 .align 32
 	pushq	%rbx
 	pushq	%r12
@@ -713,7 +713,7 @@ done_hash:
 	popq	%r12
 	popq	%rbx
 	ret
-ENDPROC(sha256_transform_rorx)
+SYM_FUNC_END(sha256_transform_rorx)
 
 .section	.rodata.cst512.K256, "aM", @progbits, 512
 .align 64
diff --git a/arch/x86/crypto/sha256-ssse3-asm.S b/arch/x86/crypto/sha256-ssse3-asm.S
index c6c05ed2c16a..69cc2f91dc4c 100644
--- a/arch/x86/crypto/sha256-ssse3-asm.S
+++ b/arch/x86/crypto/sha256-ssse3-asm.S
@@ -353,7 +353,7 @@ a = TMP_
 ## arg 3 : Num blocks
 ########################################################################
 .text
-ENTRY(sha256_transform_ssse3)
+SYM_FUNC_START(sha256_transform_ssse3)
 .align 32
 	pushq   %rbx
 	pushq   %r12
@@ -471,7 +471,7 @@ done_hash:
 	popq    %rbx
 
 	ret
-ENDPROC(sha256_transform_ssse3)
+SYM_FUNC_END(sha256_transform_ssse3)
 
 .section	.rodata.cst256.K256, "aM", @progbits, 256
 .align 64
diff --git a/arch/x86/crypto/sha256_ni_asm.S b/arch/x86/crypto/sha256_ni_asm.S
index fb58f58ecfbc..7abade04a3a3 100644
--- a/arch/x86/crypto/sha256_ni_asm.S
+++ b/arch/x86/crypto/sha256_ni_asm.S
@@ -97,7 +97,7 @@
 
 .text
 .align 32
-ENTRY(sha256_ni_transform)
+SYM_FUNC_START(sha256_ni_transform)
 
 	shl		$6, NUM_BLKS		/*  convert to bytes */
 	jz		.Ldone_hash
@@ -327,7 +327,7 @@ ENTRY(sha256_ni_transform)
 .Ldone_hash:
 
 	ret
-ENDPROC(sha256_ni_transform)
+SYM_FUNC_END(sha256_ni_transform)
 
 .section	.rodata.cst256.K256, "aM", @progbits, 256
 .align 64
diff --git a/arch/x86/crypto/sha512-avx-asm.S b/arch/x86/crypto/sha512-avx-asm.S
index 39235fefe6f7..3704ddd7e5d5 100644
--- a/arch/x86/crypto/sha512-avx-asm.S
+++ b/arch/x86/crypto/sha512-avx-asm.S
@@ -277,7 +277,7 @@ frame_size = frame_GPRSAVE + GPRSAVE_SIZE
 # message blocks.
 # L is the message length in SHA512 blocks
 ########################################################################
-ENTRY(sha512_transform_avx)
+SYM_FUNC_START(sha512_transform_avx)
 	cmp $0, msglen
 	je nowork
 
@@ -365,7 +365,7 @@ updateblock:
 
 nowork:
 	ret
-ENDPROC(sha512_transform_avx)
+SYM_FUNC_END(sha512_transform_avx)
 
 ########################################################################
 ### Binary Data
diff --git a/arch/x86/crypto/sha512-avx2-asm.S b/arch/x86/crypto/sha512-avx2-asm.S
index b16d56005162..80d830e7ee09 100644
--- a/arch/x86/crypto/sha512-avx2-asm.S
+++ b/arch/x86/crypto/sha512-avx2-asm.S
@@ -569,7 +569,7 @@ frame_size = frame_GPRSAVE + GPRSAVE_SIZE
 #   message blocks.
 # L is the message length in SHA512 blocks
 ########################################################################
-ENTRY(sha512_transform_rorx)
+SYM_FUNC_START(sha512_transform_rorx)
 	# Allocate Stack Space
 	mov	%rsp, %rax
 	sub	$frame_size, %rsp
@@ -682,7 +682,7 @@ done_hash:
 	# Restore Stack Pointer
 	mov	frame_RSPSAVE(%rsp), %rsp
 	ret
-ENDPROC(sha512_transform_rorx)
+SYM_FUNC_END(sha512_transform_rorx)
 
 ########################################################################
 ### Binary Data
diff --git a/arch/x86/crypto/sha512-ssse3-asm.S b/arch/x86/crypto/sha512-ssse3-asm.S
index 66bbd9058a90..838f984e95d9 100644
--- a/arch/x86/crypto/sha512-ssse3-asm.S
+++ b/arch/x86/crypto/sha512-ssse3-asm.S
@@ -275,7 +275,7 @@ frame_size = frame_GPRSAVE + GPRSAVE_SIZE
 #   message blocks.
 # L is the message length in SHA512 blocks.
 ########################################################################
-ENTRY(sha512_transform_ssse3)
+SYM_FUNC_START(sha512_transform_ssse3)
 
 	cmp $0, msglen
 	je nowork
@@ -364,7 +364,7 @@ updateblock:
 
 nowork:
 	ret
-ENDPROC(sha512_transform_ssse3)
+SYM_FUNC_END(sha512_transform_ssse3)
 
 ########################################################################
 ### Binary Data
diff --git a/arch/x86/crypto/twofish-avx-x86_64-asm_64.S b/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
index 588f0a2f63ab..a5151393bb2f 100644
--- a/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
@@ -315,7 +315,7 @@ SYM_FUNC_START_LOCAL(__twofish_dec_blk8)
 	ret;
 SYM_FUNC_END(__twofish_dec_blk8)
 
-ENTRY(twofish_ecb_enc_8way)
+SYM_FUNC_START(twofish_ecb_enc_8way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -333,9 +333,9 @@ ENTRY(twofish_ecb_enc_8way)
 
 	FRAME_END
 	ret;
-ENDPROC(twofish_ecb_enc_8way)
+SYM_FUNC_END(twofish_ecb_enc_8way)
 
-ENTRY(twofish_ecb_dec_8way)
+SYM_FUNC_START(twofish_ecb_dec_8way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -353,9 +353,9 @@ ENTRY(twofish_ecb_dec_8way)
 
 	FRAME_END
 	ret;
-ENDPROC(twofish_ecb_dec_8way)
+SYM_FUNC_END(twofish_ecb_dec_8way)
 
-ENTRY(twofish_cbc_dec_8way)
+SYM_FUNC_START(twofish_cbc_dec_8way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -378,9 +378,9 @@ ENTRY(twofish_cbc_dec_8way)
 
 	FRAME_END
 	ret;
-ENDPROC(twofish_cbc_dec_8way)
+SYM_FUNC_END(twofish_cbc_dec_8way)
 
-ENTRY(twofish_ctr_8way)
+SYM_FUNC_START(twofish_ctr_8way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -405,9 +405,9 @@ ENTRY(twofish_ctr_8way)
 
 	FRAME_END
 	ret;
-ENDPROC(twofish_ctr_8way)
+SYM_FUNC_END(twofish_ctr_8way)
 
-ENTRY(twofish_xts_enc_8way)
+SYM_FUNC_START(twofish_xts_enc_8way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -429,9 +429,9 @@ ENTRY(twofish_xts_enc_8way)
 
 	FRAME_END
 	ret;
-ENDPROC(twofish_xts_enc_8way)
+SYM_FUNC_END(twofish_xts_enc_8way)
 
-ENTRY(twofish_xts_dec_8way)
+SYM_FUNC_START(twofish_xts_dec_8way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -453,4 +453,4 @@ ENTRY(twofish_xts_dec_8way)
 
 	FRAME_END
 	ret;
-ENDPROC(twofish_xts_dec_8way)
+SYM_FUNC_END(twofish_xts_dec_8way)
diff --git a/arch/x86/crypto/twofish-x86_64-asm_64-3way.S b/arch/x86/crypto/twofish-x86_64-asm_64-3way.S
index e495e07c7f1b..fc23552afe37 100644
--- a/arch/x86/crypto/twofish-x86_64-asm_64-3way.S
+++ b/arch/x86/crypto/twofish-x86_64-asm_64-3way.S
@@ -220,7 +220,7 @@
 	rorq $32,			RAB2; \
 	outunpack3(mov, RIO, 2, RAB, 2);
 
-ENTRY(__twofish_enc_blk_3way)
+SYM_FUNC_START(__twofish_enc_blk_3way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -267,9 +267,9 @@ ENTRY(__twofish_enc_blk_3way)
 	popq %r12;
 	popq %r13;
 	ret;
-ENDPROC(__twofish_enc_blk_3way)
+SYM_FUNC_END(__twofish_enc_blk_3way)
 
-ENTRY(twofish_dec_blk_3way)
+SYM_FUNC_START(twofish_dec_blk_3way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst
@@ -302,4 +302,4 @@ ENTRY(twofish_dec_blk_3way)
 	popq %r12;
 	popq %r13;
 	ret;
-ENDPROC(twofish_dec_blk_3way)
+SYM_FUNC_END(twofish_dec_blk_3way)
diff --git a/arch/x86/crypto/twofish-x86_64-asm_64.S b/arch/x86/crypto/twofish-x86_64-asm_64.S
index ecef2cb9f43f..d2e56232494a 100644
--- a/arch/x86/crypto/twofish-x86_64-asm_64.S
+++ b/arch/x86/crypto/twofish-x86_64-asm_64.S
@@ -202,7 +202,7 @@
 	xor	%r8d,		d ## D;\
 	ror	$1,		d ## D;
 
-ENTRY(twofish_enc_blk)
+SYM_FUNC_START(twofish_enc_blk)
 	pushq    R1
 
 	/* %rdi contains the ctx address */
@@ -253,9 +253,9 @@ ENTRY(twofish_enc_blk)
 	popq	R1
 	movl	$1,%eax
 	ret
-ENDPROC(twofish_enc_blk)
+SYM_FUNC_END(twofish_enc_blk)
 
-ENTRY(twofish_dec_blk)
+SYM_FUNC_START(twofish_dec_blk)
 	pushq    R1
 
 	/* %rdi contains the ctx address */
@@ -305,4 +305,4 @@ ENTRY(twofish_dec_blk)
 	popq	R1
 	movl	$1,%eax
 	ret
-ENDPROC(twofish_dec_blk)
+SYM_FUNC_END(twofish_dec_blk)
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 13e4fe378e5a..d58c01239457 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -15,7 +15,7 @@
  *			at the top of the kernel process stack.
  *
  * Some macro usage:
- * - ENTRY/END:		Define functions in the symbol table.
+ * - SYM_FUNC_START/END:Define functions in the symbol table.
  * - TRACE_IRQ_*:	Trace hardirq state for lock debugging.
  * - idtentry:		Define exception entry points.
  */
@@ -1040,7 +1040,7 @@ idtentry simd_coprocessor_error		do_simd_coprocessor_error	has_error_code=0
 	 * Reload gs selector with exception handling
 	 * edi:  new selector
 	 */
-ENTRY(native_load_gs_index)
+SYM_FUNC_START(native_load_gs_index)
 	FRAME_BEGIN
 	pushfq
 	DISABLE_INTERRUPTS(CLBR_ANY & ~CLBR_RDI)
@@ -1054,7 +1054,7 @@ ENTRY(native_load_gs_index)
 	popfq
 	FRAME_END
 	ret
-ENDPROC(native_load_gs_index)
+SYM_FUNC_END(native_load_gs_index)
 EXPORT_SYMBOL(native_load_gs_index)
 
 	_ASM_EXTABLE(.Lgs_change, .Lbad_gs)
@@ -1075,7 +1075,7 @@ SYM_CODE_END(.Lbad_gs)
 	.previous
 
 /* Call softirq on interrupt stack. Interrupts are off. */
-ENTRY(do_softirq_own_stack)
+SYM_FUNC_START(do_softirq_own_stack)
 	pushq	%rbp
 	mov	%rsp, %rbp
 	ENTER_IRQ_STACK regs=0 old_rsp=%r11
@@ -1083,7 +1083,7 @@ ENTRY(do_softirq_own_stack)
 	LEAVE_IRQ_STACK regs=0
 	leaveq
 	ret
-ENDPROC(do_softirq_own_stack)
+SYM_FUNC_END(do_softirq_own_stack)
 
 #ifdef CONFIG_XEN_PV
 idtentry hypervisor_callback xen_do_hypervisor_callback has_error_code=0
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index da296435676e..f1d3ccae5dd5 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -46,7 +46,7 @@
  * ebp  user stack
  * 0(%ebp) arg6
  */
-ENTRY(entry_SYSENTER_compat)
+SYM_FUNC_START(entry_SYSENTER_compat)
 	/* Interrupts are off on entry. */
 	SWAPGS
 
@@ -147,7 +147,7 @@ ENTRY(entry_SYSENTER_compat)
 	popfq
 	jmp	.Lsysenter_flags_fixed
 SYM_INNER_LABEL(__end_entry_SYSENTER_compat, SYM_L_GLOBAL)
-ENDPROC(entry_SYSENTER_compat)
+SYM_FUNC_END(entry_SYSENTER_compat)
 
 /*
  * 32-bit SYSCALL entry.
diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 462a20f386e0..c8daa92f38dc 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -14,7 +14,7 @@
 	/*
 	 * Hooray, we are in Long 64-bit mode (but still running in low memory)
 	 */
-ENTRY(wakeup_long64)
+SYM_FUNC_START(wakeup_long64)
 	movq	saved_magic, %rax
 	movq	$0x123456789abcdef0, %rdx
 	cmpq	%rdx, %rax
@@ -40,9 +40,9 @@ ENTRY(wakeup_long64)
 
 	movq	saved_rip, %rax
 	jmp	*%rax
-ENDPROC(wakeup_long64)
+SYM_FUNC_END(wakeup_long64)
 
-ENTRY(do_suspend_lowlevel)
+SYM_FUNC_START(do_suspend_lowlevel)
 	FRAME_BEGIN
 	subq	$8, %rsp
 	xorl	%eax, %eax
@@ -125,7 +125,7 @@ ENTRY(do_suspend_lowlevel)
 	addq	$8, %rsp
 	FRAME_END
 	jmp	restore_processor_state
-ENDPROC(do_suspend_lowlevel)
+SYM_FUNC_END(do_suspend_lowlevel)
 
 .data
 saved_rbp:		.quad	0
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 60f894b018e0..16deae706950 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -132,11 +132,11 @@ EXPORT_SYMBOL(__fentry__)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
-ENTRY(function_hook)
+SYM_FUNC_START(function_hook)
 	retq
-ENDPROC(function_hook)
+SYM_FUNC_END(function_hook)
 
-ENTRY(ftrace_caller)
+SYM_FUNC_START(ftrace_caller)
 	/* save_mcount_regs fills in first two parameters */
 	save_mcount_regs
 
@@ -170,9 +170,9 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
  */
 WEAK(ftrace_stub)
 	retq
-ENDPROC(ftrace_caller)
+SYM_FUNC_END(ftrace_caller)
 
-ENTRY(ftrace_regs_caller)
+SYM_FUNC_START(ftrace_regs_caller)
 	/* Save the current flags before any operations that can change them */
 	pushfq
 
@@ -243,12 +243,12 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 
 	jmp ftrace_epilogue
 
-ENDPROC(ftrace_regs_caller)
+SYM_FUNC_END(ftrace_regs_caller)
 
 
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
-ENTRY(function_hook)
+SYM_FUNC_START(function_hook)
 	cmpq $ftrace_stub, ftrace_trace_function
 	jnz trace
 
@@ -279,11 +279,11 @@ trace:
 	restore_mcount_regs
 
 	jmp fgraph_trace
-ENDPROC(function_hook)
+SYM_FUNC_END(function_hook)
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-ENTRY(ftrace_graph_caller)
+SYM_FUNC_START(ftrace_graph_caller)
 	/* Saves rbp into %rdx and fills first parameter  */
 	save_mcount_regs
 
@@ -294,7 +294,7 @@ ENTRY(ftrace_graph_caller)
 	restore_mcount_regs
 
 	retq
-ENDPROC(ftrace_graph_caller)
+SYM_FUNC_END(ftrace_graph_caller)
 
 SYM_CODE_START(return_to_handler)
 	UNWIND_HINT_EMPTY
diff --git a/arch/x86/kernel/irqflags.S b/arch/x86/kernel/irqflags.S
index ddeeaac8adda..0db0375235b4 100644
--- a/arch/x86/kernel/irqflags.S
+++ b/arch/x86/kernel/irqflags.S
@@ -7,20 +7,20 @@
 /*
  * unsigned long native_save_fl(void)
  */
-ENTRY(native_save_fl)
+SYM_FUNC_START(native_save_fl)
 	pushf
 	pop %_ASM_AX
 	ret
-ENDPROC(native_save_fl)
+SYM_FUNC_END(native_save_fl)
 EXPORT_SYMBOL(native_save_fl)
 
 /*
  * void native_restore_fl(unsigned long flags)
  * %eax/%rdi: flags
  */
-ENTRY(native_restore_fl)
+SYM_FUNC_START(native_restore_fl)
 	push %_ASM_ARG1
 	popf
 	ret
-ENDPROC(native_restore_fl)
+SYM_FUNC_END(native_restore_fl)
 EXPORT_SYMBOL(native_restore_fl)
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 751a384c2eb0..81ada2ce99e7 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -43,7 +43,7 @@
  * they VM-Fail, whereas a successful VM-Enter + VM-Exit will jump
  * to vmx_vmexit.
  */
-ENTRY(vmx_vmenter)
+SYM_FUNC_START(vmx_vmenter)
 	/* EFLAGS.ZF is set if VMCS.LAUNCHED == 0 */
 	je 2f
 
@@ -65,7 +65,7 @@ ENTRY(vmx_vmenter)
 	_ASM_EXTABLE(1b, 5b)
 	_ASM_EXTABLE(2b, 5b)
 
-ENDPROC(vmx_vmenter)
+SYM_FUNC_END(vmx_vmenter)
 
 /**
  * vmx_vmexit - Handle a VMX VM-Exit
@@ -77,7 +77,7 @@ ENDPROC(vmx_vmenter)
  * here after hardware loads the host's state, i.e. this is the destination
  * referred to by VMCS.HOST_RIP.
  */
-ENTRY(vmx_vmexit)
+SYM_FUNC_START(vmx_vmexit)
 #ifdef CONFIG_RETPOLINE
 	ALTERNATIVE "jmp .Lvmexit_skip_rsb", "", X86_FEATURE_RETPOLINE
 	/* Preserve guest's RAX, it's used to stuff the RSB. */
@@ -90,7 +90,7 @@ ENTRY(vmx_vmexit)
 .Lvmexit_skip_rsb:
 #endif
 	ret
-ENDPROC(vmx_vmexit)
+SYM_FUNC_END(vmx_vmexit)
 
 /**
  * __vmx_vcpu_run - Run a vCPU via a transition to VMX guest mode
@@ -101,7 +101,7 @@ ENDPROC(vmx_vmexit)
  * Returns:
  *	0 on VM-Exit, 1 on VM-Fail
  */
-ENTRY(__vmx_vcpu_run)
+SYM_FUNC_START(__vmx_vcpu_run)
 	push %_ASM_BP
 	mov  %_ASM_SP, %_ASM_BP
 #ifdef CONFIG_X86_64
@@ -233,4 +233,4 @@ ENTRY(__vmx_vcpu_run)
 	/* VM-Fail.  Out-of-line to avoid a taken Jcc after VM-Exit. */
 2:	mov $1, %eax
 	jmp 1b
-ENDPROC(__vmx_vcpu_run)
+SYM_FUNC_END(__vmx_vcpu_run)
diff --git a/arch/x86/lib/checksum_32.S b/arch/x86/lib/checksum_32.S
index 4df90c9ea383..74256bd193da 100644
--- a/arch/x86/lib/checksum_32.S
+++ b/arch/x86/lib/checksum_32.S
@@ -280,7 +280,7 @@ unsigned int csum_partial_copy_generic (const char *src, char *dst,
 #define ARGBASE 16		
 #define FP		12
 		
-ENTRY(csum_partial_copy_generic)
+SYM_FUNC_START(csum_partial_copy_generic)
 	subl  $4,%esp	
 	pushl %edi
 	pushl %esi
@@ -398,7 +398,7 @@ DST(	movb %cl, (%edi)	)
 	popl %edi
 	popl %ecx			# equivalent to addl $4,%esp
 	ret	
-ENDPROC(csum_partial_copy_generic)
+SYM_FUNC_END(csum_partial_copy_generic)
 
 #else
 
@@ -416,7 +416,7 @@ ENDPROC(csum_partial_copy_generic)
 
 #define ARGBASE 12
 		
-ENTRY(csum_partial_copy_generic)
+SYM_FUNC_START(csum_partial_copy_generic)
 	pushl %ebx
 	pushl %edi
 	pushl %esi
@@ -483,7 +483,7 @@ DST(	movb %dl, (%edi)         )
 	popl %edi
 	popl %ebx
 	ret
-ENDPROC(csum_partial_copy_generic)
+SYM_FUNC_END(csum_partial_copy_generic)
 				
 #undef ROUND
 #undef ROUND1		
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index 75a5a4515fa7..c4c7dd115953 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -13,15 +13,15 @@
  * Zero a page.
  * %rdi	- page
  */
-ENTRY(clear_page_rep)
+SYM_FUNC_START(clear_page_rep)
 	movl $4096/8,%ecx
 	xorl %eax,%eax
 	rep stosq
 	ret
-ENDPROC(clear_page_rep)
+SYM_FUNC_END(clear_page_rep)
 EXPORT_SYMBOL_GPL(clear_page_rep)
 
-ENTRY(clear_page_orig)
+SYM_FUNC_START(clear_page_orig)
 	xorl   %eax,%eax
 	movl   $4096/64,%ecx
 	.p2align 4
@@ -40,13 +40,13 @@ ENTRY(clear_page_orig)
 	jnz	.Lloop
 	nop
 	ret
-ENDPROC(clear_page_orig)
+SYM_FUNC_END(clear_page_orig)
 EXPORT_SYMBOL_GPL(clear_page_orig)
 
-ENTRY(clear_page_erms)
+SYM_FUNC_START(clear_page_erms)
 	movl $4096,%ecx
 	xorl %eax,%eax
 	rep stosb
 	ret
-ENDPROC(clear_page_erms)
+SYM_FUNC_END(clear_page_erms)
 EXPORT_SYMBOL_GPL(clear_page_erms)
diff --git a/arch/x86/lib/cmpxchg16b_emu.S b/arch/x86/lib/cmpxchg16b_emu.S
index d63185698a23..3542502faa3b 100644
--- a/arch/x86/lib/cmpxchg16b_emu.S
+++ b/arch/x86/lib/cmpxchg16b_emu.S
@@ -13,7 +13,7 @@
  * %rcx : high 64 bits of new value
  * %al  : Operation successful
  */
-ENTRY(this_cpu_cmpxchg16b_emu)
+SYM_FUNC_START(this_cpu_cmpxchg16b_emu)
 
 #
 # Emulate 'cmpxchg16b %gs:(%rsi)' except we return the result in %al not
@@ -44,4 +44,4 @@ ENTRY(this_cpu_cmpxchg16b_emu)
 	xor %al,%al
 	ret
 
-ENDPROC(this_cpu_cmpxchg16b_emu)
+SYM_FUNC_END(this_cpu_cmpxchg16b_emu)
diff --git a/arch/x86/lib/cmpxchg8b_emu.S b/arch/x86/lib/cmpxchg8b_emu.S
index 691d80e97488..ca01ed6029f4 100644
--- a/arch/x86/lib/cmpxchg8b_emu.S
+++ b/arch/x86/lib/cmpxchg8b_emu.S
@@ -13,7 +13,7 @@
  * %ebx : low 32 bits of new value
  * %ecx : high 32 bits of new value
  */
-ENTRY(cmpxchg8b_emu)
+SYM_FUNC_START(cmpxchg8b_emu)
 
 #
 # Emulate 'cmpxchg8b (%esi)' on UP except we don't
@@ -42,5 +42,5 @@ ENTRY(cmpxchg8b_emu)
 	popfl
 	ret
 
-ENDPROC(cmpxchg8b_emu)
+SYM_FUNC_END(cmpxchg8b_emu)
 EXPORT_SYMBOL(cmpxchg8b_emu)
diff --git a/arch/x86/lib/copy_page_64.S b/arch/x86/lib/copy_page_64.S
index f505870bd93b..2402d4c489d2 100644
--- a/arch/x86/lib/copy_page_64.S
+++ b/arch/x86/lib/copy_page_64.S
@@ -13,12 +13,12 @@
  * prefetch distance based on SMP/UP.
  */
 	ALIGN
-ENTRY(copy_page)
+SYM_FUNC_START(copy_page)
 	ALTERNATIVE "jmp copy_page_regs", "", X86_FEATURE_REP_GOOD
 	movl	$4096/8, %ecx
 	rep	movsq
 	ret
-ENDPROC(copy_page)
+SYM_FUNC_END(copy_page)
 EXPORT_SYMBOL(copy_page)
 
 SYM_FUNC_START_LOCAL(copy_page_regs)
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 4a12b3c120bf..816f128a6d52 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -53,7 +53,7 @@
  * Output:
  * eax uncopied bytes or 0 if successful.
  */
-ENTRY(copy_user_generic_unrolled)
+SYM_FUNC_START(copy_user_generic_unrolled)
 	ASM_STAC
 	cmpl $8,%edx
 	jb 20f		/* less then 8 bytes, go to byte copy loop */
@@ -136,7 +136,7 @@ ENTRY(copy_user_generic_unrolled)
 	_ASM_EXTABLE_UA(19b, 40b)
 	_ASM_EXTABLE_UA(21b, 50b)
 	_ASM_EXTABLE_UA(22b, 50b)
-ENDPROC(copy_user_generic_unrolled)
+SYM_FUNC_END(copy_user_generic_unrolled)
 EXPORT_SYMBOL(copy_user_generic_unrolled)
 
 /* Some CPUs run faster using the string copy instructions.
@@ -157,7 +157,7 @@ EXPORT_SYMBOL(copy_user_generic_unrolled)
  * Output:
  * eax uncopied bytes or 0 if successful.
  */
-ENTRY(copy_user_generic_string)
+SYM_FUNC_START(copy_user_generic_string)
 	ASM_STAC
 	cmpl $8,%edx
 	jb 2f		/* less than 8 bytes, go to byte copy loop */
@@ -182,7 +182,7 @@ ENTRY(copy_user_generic_string)
 
 	_ASM_EXTABLE_UA(1b, 11b)
 	_ASM_EXTABLE_UA(3b, 12b)
-ENDPROC(copy_user_generic_string)
+SYM_FUNC_END(copy_user_generic_string)
 EXPORT_SYMBOL(copy_user_generic_string)
 
 /*
@@ -197,7 +197,7 @@ EXPORT_SYMBOL(copy_user_generic_string)
  * Output:
  * eax uncopied bytes or 0 if successful.
  */
-ENTRY(copy_user_enhanced_fast_string)
+SYM_FUNC_START(copy_user_enhanced_fast_string)
 	ASM_STAC
 	cmpl $64,%edx
 	jb .L_copy_short_string	/* less then 64 bytes, avoid the costly 'rep' */
@@ -214,7 +214,7 @@ ENTRY(copy_user_enhanced_fast_string)
 	.previous
 
 	_ASM_EXTABLE_UA(1b, 12b)
-ENDPROC(copy_user_enhanced_fast_string)
+SYM_FUNC_END(copy_user_enhanced_fast_string)
 EXPORT_SYMBOL(copy_user_enhanced_fast_string)
 
 /*
@@ -249,7 +249,7 @@ SYM_CODE_END(.Lcopy_user_handle_tail)
  *  - Require 8-byte alignment when size is 8 bytes or larger.
  *  - Require 4-byte alignment when size is 4 bytes.
  */
-ENTRY(__copy_user_nocache)
+SYM_FUNC_START(__copy_user_nocache)
 	ASM_STAC
 
 	/* If size is less than 8 bytes, go to 4-byte copy */
@@ -388,5 +388,5 @@ ENTRY(__copy_user_nocache)
 	_ASM_EXTABLE_UA(31b, .L_fixup_4b_copy)
 	_ASM_EXTABLE_UA(40b, .L_fixup_1b_copy)
 	_ASM_EXTABLE_UA(41b, .L_fixup_1b_copy)
-ENDPROC(__copy_user_nocache)
+SYM_FUNC_END(__copy_user_nocache)
 EXPORT_SYMBOL(__copy_user_nocache)
diff --git a/arch/x86/lib/csum-copy_64.S b/arch/x86/lib/csum-copy_64.S
index a4a379e79259..3394a8ff7fd0 100644
--- a/arch/x86/lib/csum-copy_64.S
+++ b/arch/x86/lib/csum-copy_64.S
@@ -49,7 +49,7 @@
 	.endm
 
 
-ENTRY(csum_partial_copy_generic)
+SYM_FUNC_START(csum_partial_copy_generic)
 	cmpl	$3*64, %edx
 	jle	.Lignore
 
@@ -225,4 +225,4 @@ ENTRY(csum_partial_copy_generic)
 	jz   .Lende
 	movl $-EFAULT, (%rax)
 	jmp .Lende
-ENDPROC(csum_partial_copy_generic)
+SYM_FUNC_END(csum_partial_copy_generic)
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index f9f59eb85635..c8a85b512796 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -36,7 +36,7 @@
 #include <asm/export.h>
 
 	.text
-ENTRY(__get_user_1)
+SYM_FUNC_START(__get_user_1)
 	mov PER_CPU_VAR(current_task), %_ASM_DX
 	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
 	jae bad_get_user
@@ -47,10 +47,10 @@ ENTRY(__get_user_1)
 	xor %eax,%eax
 	ASM_CLAC
 	ret
-ENDPROC(__get_user_1)
+SYM_FUNC_END(__get_user_1)
 EXPORT_SYMBOL(__get_user_1)
 
-ENTRY(__get_user_2)
+SYM_FUNC_START(__get_user_2)
 	add $1,%_ASM_AX
 	jc bad_get_user
 	mov PER_CPU_VAR(current_task), %_ASM_DX
@@ -63,10 +63,10 @@ ENTRY(__get_user_2)
 	xor %eax,%eax
 	ASM_CLAC
 	ret
-ENDPROC(__get_user_2)
+SYM_FUNC_END(__get_user_2)
 EXPORT_SYMBOL(__get_user_2)
 
-ENTRY(__get_user_4)
+SYM_FUNC_START(__get_user_4)
 	add $3,%_ASM_AX
 	jc bad_get_user
 	mov PER_CPU_VAR(current_task), %_ASM_DX
@@ -79,10 +79,10 @@ ENTRY(__get_user_4)
 	xor %eax,%eax
 	ASM_CLAC
 	ret
-ENDPROC(__get_user_4)
+SYM_FUNC_END(__get_user_4)
 EXPORT_SYMBOL(__get_user_4)
 
-ENTRY(__get_user_8)
+SYM_FUNC_START(__get_user_8)
 #ifdef CONFIG_X86_64
 	add $7,%_ASM_AX
 	jc bad_get_user
@@ -111,7 +111,7 @@ ENTRY(__get_user_8)
 	ASM_CLAC
 	ret
 #endif
-ENDPROC(__get_user_8)
+SYM_FUNC_END(__get_user_8)
 EXPORT_SYMBOL(__get_user_8)
 
 
diff --git a/arch/x86/lib/hweight.S b/arch/x86/lib/hweight.S
index a14f9939c365..dbf8cc97b7f5 100644
--- a/arch/x86/lib/hweight.S
+++ b/arch/x86/lib/hweight.S
@@ -8,7 +8,7 @@
  * unsigned int __sw_hweight32(unsigned int w)
  * %rdi: w
  */
-ENTRY(__sw_hweight32)
+SYM_FUNC_START(__sw_hweight32)
 
 #ifdef CONFIG_X86_64
 	movl %edi, %eax				# w
@@ -33,10 +33,10 @@ ENTRY(__sw_hweight32)
 	shrl $24, %eax				# w = w_tmp >> 24
 	__ASM_SIZE(pop,) %__ASM_REG(dx)
 	ret
-ENDPROC(__sw_hweight32)
+SYM_FUNC_END(__sw_hweight32)
 EXPORT_SYMBOL(__sw_hweight32)
 
-ENTRY(__sw_hweight64)
+SYM_FUNC_START(__sw_hweight64)
 #ifdef CONFIG_X86_64
 	pushq   %rdi
 	pushq   %rdx
@@ -79,5 +79,5 @@ ENTRY(__sw_hweight64)
 	popl    %ecx
 	ret
 #endif
-ENDPROC(__sw_hweight64)
+SYM_FUNC_END(__sw_hweight64)
 EXPORT_SYMBOL(__sw_hweight64)
diff --git a/arch/x86/lib/iomap_copy_64.S b/arch/x86/lib/iomap_copy_64.S
index a9bdf0805be0..cb5a1964506b 100644
--- a/arch/x86/lib/iomap_copy_64.S
+++ b/arch/x86/lib/iomap_copy_64.S
@@ -8,8 +8,8 @@
 /*
  * override generic version in lib/iomap_copy.c
  */
-ENTRY(__iowrite32_copy)
+SYM_FUNC_START(__iowrite32_copy)
 	movl %edx,%ecx
 	rep movsd
 	ret
-ENDPROC(__iowrite32_copy)
+SYM_FUNC_END(__iowrite32_copy)
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 3265b21e86c0..56b243b14c3a 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -193,7 +193,7 @@ MCSAFE_TEST_CTL
  * Note that we only catch machine checks when reading the source addresses.
  * Writes to target are posted and don't generate machine checks.
  */
-ENTRY(__memcpy_mcsafe)
+SYM_FUNC_START(__memcpy_mcsafe)
 	cmpl $8, %edx
 	/* Less than 8 bytes? Go to byte copy loop */
 	jb .L_no_whole_words
@@ -260,7 +260,7 @@ ENTRY(__memcpy_mcsafe)
 	xorl %eax, %eax
 .L_done:
 	ret
-ENDPROC(__memcpy_mcsafe)
+SYM_FUNC_END(__memcpy_mcsafe)
 EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
 
 	.section .fixup, "ax"
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 50c1648311b3..337830d7a59c 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -27,7 +27,7 @@
 .weak memmove
 
 SYM_FUNC_START_ALIAS(memmove)
-ENTRY(__memmove)
+SYM_FUNC_START(__memmove)
 
 	/* Handle more 32 bytes in loop */
 	mov %rdi, %rax
@@ -207,7 +207,7 @@ ENTRY(__memmove)
 	movb %r11b, (%rdi)
 13:
 	retq
-ENDPROC(__memmove)
+SYM_FUNC_END(__memmove)
 SYM_FUNC_END_ALIAS(memmove)
 EXPORT_SYMBOL(__memmove)
 EXPORT_SYMBOL(memmove)
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 564abf9ecedb..9ff15ee404a4 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -20,7 +20,7 @@
  * rax   original destination
  */
 SYM_FUNC_START_ALIAS(memset)
-ENTRY(__memset)
+SYM_FUNC_START(__memset)
 	/*
 	 * Some CPUs support enhanced REP MOVSB/STOSB feature. It is recommended
 	 * to use it when possible. If not available, use fast string instructions.
@@ -43,7 +43,7 @@ ENTRY(__memset)
 	rep stosb
 	movq %r9,%rax
 	ret
-ENDPROC(__memset)
+SYM_FUNC_END(__memset)
 SYM_FUNC_END_ALIAS(memset)
 EXPORT_SYMBOL(memset)
 EXPORT_SYMBOL(__memset)
diff --git a/arch/x86/lib/msr-reg.S b/arch/x86/lib/msr-reg.S
index ed33cbab3958..a2b9caa5274c 100644
--- a/arch/x86/lib/msr-reg.S
+++ b/arch/x86/lib/msr-reg.S
@@ -12,7 +12,7 @@
  *
  */
 .macro op_safe_regs op
-ENTRY(\op\()_safe_regs)
+SYM_FUNC_START(\op\()_safe_regs)
 	pushq %rbx
 	pushq %r12
 	movq	%rdi, %r10	/* Save pointer */
@@ -41,13 +41,13 @@ ENTRY(\op\()_safe_regs)
 	jmp     2b
 
 	_ASM_EXTABLE(1b, 3b)
-ENDPROC(\op\()_safe_regs)
+SYM_FUNC_END(\op\()_safe_regs)
 .endm
 
 #else /* X86_32 */
 
 .macro op_safe_regs op
-ENTRY(\op\()_safe_regs)
+SYM_FUNC_START(\op\()_safe_regs)
 	pushl %ebx
 	pushl %ebp
 	pushl %esi
@@ -83,7 +83,7 @@ ENTRY(\op\()_safe_regs)
 	jmp     2b
 
 	_ASM_EXTABLE(1b, 3b)
-ENDPROC(\op\()_safe_regs)
+SYM_FUNC_END(\op\()_safe_regs)
 .endm
 
 #endif
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index a9391d772c81..7c7c92db8497 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -34,7 +34,7 @@
 #define ENTER	mov PER_CPU_VAR(current_task), %_ASM_BX
 
 .text
-ENTRY(__put_user_1)
+SYM_FUNC_START(__put_user_1)
 	ENTER
 	cmp TASK_addr_limit(%_ASM_BX),%_ASM_CX
 	jae .Lbad_put_user
@@ -43,10 +43,10 @@ ENTRY(__put_user_1)
 	xor %eax,%eax
 	ASM_CLAC
 	ret
-ENDPROC(__put_user_1)
+SYM_FUNC_END(__put_user_1)
 EXPORT_SYMBOL(__put_user_1)
 
-ENTRY(__put_user_2)
+SYM_FUNC_START(__put_user_2)
 	ENTER
 	mov TASK_addr_limit(%_ASM_BX),%_ASM_BX
 	sub $1,%_ASM_BX
@@ -57,10 +57,10 @@ ENTRY(__put_user_2)
 	xor %eax,%eax
 	ASM_CLAC
 	ret
-ENDPROC(__put_user_2)
+SYM_FUNC_END(__put_user_2)
 EXPORT_SYMBOL(__put_user_2)
 
-ENTRY(__put_user_4)
+SYM_FUNC_START(__put_user_4)
 	ENTER
 	mov TASK_addr_limit(%_ASM_BX),%_ASM_BX
 	sub $3,%_ASM_BX
@@ -71,10 +71,10 @@ ENTRY(__put_user_4)
 	xor %eax,%eax
 	ASM_CLAC
 	ret
-ENDPROC(__put_user_4)
+SYM_FUNC_END(__put_user_4)
 EXPORT_SYMBOL(__put_user_4)
 
-ENTRY(__put_user_8)
+SYM_FUNC_START(__put_user_8)
 	ENTER
 	mov TASK_addr_limit(%_ASM_BX),%_ASM_BX
 	sub $7,%_ASM_BX
@@ -88,7 +88,7 @@ ENTRY(__put_user_8)
 	xor %eax,%eax
 	ASM_CLAC
 	RET
-ENDPROC(__put_user_8)
+SYM_FUNC_END(__put_user_8)
 EXPORT_SYMBOL(__put_user_8)
 
 SYM_CODE_START_LOCAL(.Lbad_put_user_clac)
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index c909961e678a..363ec132df7e 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -11,11 +11,11 @@
 .macro THUNK reg
 	.section .text.__x86.indirect_thunk
 
-ENTRY(__x86_indirect_thunk_\reg)
+SYM_FUNC_START(__x86_indirect_thunk_\reg)
 	CFI_STARTPROC
 	JMP_NOSPEC %\reg
 	CFI_ENDPROC
-ENDPROC(__x86_indirect_thunk_\reg)
+SYM_FUNC_END(__x86_indirect_thunk_\reg)
 .endm
 
 /*
diff --git a/arch/x86/mm/mem_encrypt_boot.S b/arch/x86/mm/mem_encrypt_boot.S
index 6d71481a1e70..106ead05bbe3 100644
--- a/arch/x86/mm/mem_encrypt_boot.S
+++ b/arch/x86/mm/mem_encrypt_boot.S
@@ -16,7 +16,7 @@
 
 	.text
 	.code64
-ENTRY(sme_encrypt_execute)
+SYM_FUNC_START(sme_encrypt_execute)
 
 	/*
 	 * Entry parameters:
@@ -66,9 +66,9 @@ ENTRY(sme_encrypt_execute)
 	pop	%rbp
 
 	ret
-ENDPROC(sme_encrypt_execute)
+SYM_FUNC_END(sme_encrypt_execute)
 
-ENTRY(__enc_copy)
+SYM_FUNC_START(__enc_copy)
 /*
  * Routine used to encrypt memory in place.
  *   This routine must be run outside of the kernel proper since
@@ -153,4 +153,4 @@ ENTRY(__enc_copy)
 
 	ret
 .L__enc_copy_end:
-ENDPROC(__enc_copy)
+SYM_FUNC_END(__enc_copy)
diff --git a/arch/x86/platform/efi/efi_stub_64.S b/arch/x86/platform/efi/efi_stub_64.S
index 74628ec78f29..b1d2313fe3bf 100644
--- a/arch/x86/platform/efi/efi_stub_64.S
+++ b/arch/x86/platform/efi/efi_stub_64.S
@@ -39,7 +39,7 @@
 	mov %rsi, %cr0;			\
 	mov (%rsp), %rsp
 
-ENTRY(efi_call)
+SYM_FUNC_START(efi_call)
 	pushq %rbp
 	movq %rsp, %rbp
 	SAVE_XMM
@@ -55,4 +55,4 @@ ENTRY(efi_call)
 	RESTORE_XMM
 	popq %rbp
 	ret
-ENDPROC(efi_call)
+SYM_FUNC_END(efi_call)
diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
index d677a7eb2d0a..3189f1394701 100644
--- a/arch/x86/platform/efi/efi_thunk_64.S
+++ b/arch/x86/platform/efi/efi_thunk_64.S
@@ -25,7 +25,7 @@
 
 	.text
 	.code64
-ENTRY(efi64_thunk)
+SYM_FUNC_START(efi64_thunk)
 	push	%rbp
 	push	%rbx
 
@@ -60,7 +60,7 @@ ENTRY(efi64_thunk)
 	pop	%rbx
 	pop	%rbp
 	retq
-ENDPROC(efi64_thunk)
+SYM_FUNC_END(efi64_thunk)
 
 /*
  * We run this function from the 1:1 mapping.
diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index 4057cd5af7e2..7918b8415f13 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -22,7 +22,7 @@
 #include <asm/processor-flags.h>
 #include <asm/frame.h>
 
-ENTRY(swsusp_arch_suspend)
+SYM_FUNC_START(swsusp_arch_suspend)
 	movq	$saved_context, %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
@@ -50,7 +50,7 @@ ENTRY(swsusp_arch_suspend)
 	call swsusp_save
 	FRAME_END
 	ret
-ENDPROC(swsusp_arch_suspend)
+SYM_FUNC_END(swsusp_arch_suspend)
 
 SYM_CODE_START(restore_image)
 	/* prepare to jump to the image kernel */
@@ -102,7 +102,7 @@ SYM_CODE_END(core_restore_code)
 
 	 /* code below belongs to the image kernel */
 	.align PAGE_SIZE
-ENTRY(restore_registers)
+SYM_FUNC_START(restore_registers)
 	/* go back to the original page tables */
 	movq    %r9, %cr3
 
@@ -144,4 +144,4 @@ ENTRY(restore_registers)
 	movq	%rax, in_suspend(%rip)
 
 	ret
-ENDPROC(restore_registers)
+SYM_FUNC_END(restore_registers)
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index be104eef80be..508fe204520b 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -19,7 +19,7 @@
  * event status with one and operation.  If there are pending events,
  * then enter the hypervisor to get them handled.
  */
-ENTRY(xen_irq_enable_direct)
+SYM_FUNC_START(xen_irq_enable_direct)
 	FRAME_BEGIN
 	/* Unmask events */
 	movb $0, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
@@ -38,17 +38,17 @@ ENTRY(xen_irq_enable_direct)
 1:
 	FRAME_END
 	ret
-	ENDPROC(xen_irq_enable_direct)
+SYM_FUNC_END(xen_irq_enable_direct)
 
 
 /*
  * Disabling events is simply a matter of making the event mask
  * non-zero.
  */
-ENTRY(xen_irq_disable_direct)
+SYM_FUNC_START(xen_irq_disable_direct)
 	movb $1, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
 	ret
-ENDPROC(xen_irq_disable_direct)
+SYM_FUNC_END(xen_irq_disable_direct)
 
 /*
  * (xen_)save_fl is used to get the current interrupt enable status.
@@ -59,12 +59,12 @@ ENDPROC(xen_irq_disable_direct)
  * undefined.  We need to toggle the state of the bit, because Xen and
  * x86 use opposite senses (mask vs enable).
  */
-ENTRY(xen_save_fl_direct)
+SYM_FUNC_START(xen_save_fl_direct)
 	testb $0xff, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
 	setz %ah
 	addb %ah, %ah
 	ret
-	ENDPROC(xen_save_fl_direct)
+SYM_FUNC_END(xen_save_fl_direct)
 
 
 /*
@@ -74,7 +74,7 @@ ENTRY(xen_save_fl_direct)
  * interrupt mask state, it checks for unmasked pending events and
  * enters the hypervisor to get them delivered if so.
  */
-ENTRY(xen_restore_fl_direct)
+SYM_FUNC_START(xen_restore_fl_direct)
 	FRAME_BEGIN
 #ifdef CONFIG_X86_64
 	testw $X86_EFLAGS_IF, %di
@@ -95,14 +95,14 @@ ENTRY(xen_restore_fl_direct)
 1:
 	FRAME_END
 	ret
-	ENDPROC(xen_restore_fl_direct)
+SYM_FUNC_END(xen_restore_fl_direct)
 
 
 /*
  * Force an event check by making a hypercall, but preserve regs
  * before making the call.
  */
-ENTRY(check_events)
+SYM_FUNC_START(check_events)
 	FRAME_BEGIN
 #ifdef CONFIG_X86_32
 	push %eax
@@ -135,19 +135,19 @@ ENTRY(check_events)
 #endif
 	FRAME_END
 	ret
-ENDPROC(check_events)
+SYM_FUNC_END(check_events)
 
-ENTRY(xen_read_cr2)
+SYM_FUNC_START(xen_read_cr2)
 	FRAME_BEGIN
 	_ASM_MOV PER_CPU_VAR(xen_vcpu), %_ASM_AX
 	_ASM_MOV XEN_vcpu_info_arch_cr2(%_ASM_AX), %_ASM_AX
 	FRAME_END
 	ret
-	ENDPROC(xen_read_cr2);
+SYM_FUNC_END(xen_read_cr2);
 
-ENTRY(xen_read_cr2_direct)
+SYM_FUNC_START(xen_read_cr2_direct)
 	FRAME_BEGIN
 	_ASM_MOV PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_arch_cr2, %_ASM_AX
 	FRAME_END
 	ret
-	ENDPROC(xen_read_cr2_direct);
+SYM_FUNC_END(xen_read_cr2_direct);
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 0060120f51dd..0a0fd168683a 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -126,7 +126,7 @@ SYM_CODE_END(xen_sysret64)
  */
 
 /* Normal 64-bit system call target */
-ENTRY(xen_syscall_target)
+SYM_FUNC_START(xen_syscall_target)
 	popq %rcx
 	popq %r11
 
@@ -139,12 +139,12 @@ ENTRY(xen_syscall_target)
 	movq $__USER_CS, 1*8(%rsp)
 
 	jmp entry_SYSCALL_64_after_hwframe
-ENDPROC(xen_syscall_target)
+SYM_FUNC_END(xen_syscall_target)
 
 #ifdef CONFIG_IA32_EMULATION
 
 /* 32-bit compat syscall target */
-ENTRY(xen_syscall32_target)
+SYM_FUNC_START(xen_syscall32_target)
 	popq %rcx
 	popq %r11
 
@@ -157,25 +157,25 @@ ENTRY(xen_syscall32_target)
 	movq $__USER32_CS, 1*8(%rsp)
 
 	jmp entry_SYSCALL_compat_after_hwframe
-ENDPROC(xen_syscall32_target)
+SYM_FUNC_END(xen_syscall32_target)
 
 /* 32-bit compat sysenter target */
-ENTRY(xen_sysenter_target)
+SYM_FUNC_START(xen_sysenter_target)
 	mov 0*8(%rsp), %rcx
 	mov 1*8(%rsp), %r11
 	mov 5*8(%rsp), %rsp
 	jmp entry_SYSENTER_compat
-ENDPROC(xen_sysenter_target)
+SYM_FUNC_END(xen_sysenter_target)
 
 #else /* !CONFIG_IA32_EMULATION */
 
 SYM_FUNC_START_ALIAS(xen_syscall32_target)
-ENTRY(xen_sysenter_target)
+SYM_FUNC_START(xen_sysenter_target)
 	lea 16(%rsp), %rsp	/* strip %rcx, %r11 */
 	mov $-ENOSYS, %rax
 	pushq $0
 	jmp hypercall_iret
-ENDPROC(xen_sysenter_target)
+SYM_FUNC_END(xen_sysenter_target)
 SYM_FUNC_END_ALIAS(xen_syscall32_target)
 
 #endif	/* CONFIG_IA32_EMULATION */
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index cb1108dde385..19f3d796ab5b 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -114,11 +114,13 @@
 #endif
 #endif
 
+#ifndef CONFIG_X86_64
 #ifndef ENTRY
 /* deprecated, use SYM_FUNC_START */
 #define ENTRY(name) \
 	SYM_FUNC_START(name)
 #endif
+#endif /* CONFIG_X86_64 */
 #endif /* LINKER_SCRIPT */
 
 #ifndef WEAK
@@ -133,6 +135,7 @@
 	.size name, .-name
 #endif
 
+#ifndef CONFIG_X86_64
 /* If symbol 'name' is treated as a subroutine (gets called, and returns)
  * then please use ENDPROC to mark 'name' as STT_FUNC for the benefit of
  * static analysis tools such as stack depth analyzer.
@@ -142,6 +145,7 @@
 #define ENDPROC(name) \
 	SYM_FUNC_END(name)
 #endif
+#endif /* CONFIG_X86_64 */
 
 /* === generic annotations === */
 
-- 
2.23.0

