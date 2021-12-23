Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262EC47DBC3
	for <lists+linux-arch@lfdr.de>; Thu, 23 Dec 2021 01:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbhLWAXg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Dec 2021 19:23:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:60203 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237798AbhLWAX3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Dec 2021 19:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640219009; x=1671755009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6UlSNvz2mO+iSyCTJ8mLUBDzZs6RfAGb+rtkWWEgTe4=;
  b=cL4qkCysxclo4JvGVRHgefzv7TooyWt66QPO6YNYeAj0WzcoGr3oT7YR
   TjHGsdzjyP7G4NpRo1ArQ+WnmQgbCLuTUfQbPgutamx67Rixpp6W/D0q2
   IQYPE4fWFUWYrpSbcR+wIxeSeH4JzHE2fg1/vrdHX/NFPdXItjwQJmzAI
   mrXJn+hMqSAIojL1iBMK5CYfr/jrCQ64dHcS5fQL1fVgoW54sFep9ZJ82
   +fV9nzK9m604yfFwYhG2EuBwQFvff8mIlYzvkX76BvalRROvxQogWqdEI
   WBunzyyYKlCsc6pye56W/I31LtKiy7pjfObSR/VhW1KYu6d/5h2pnetdr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="228027809"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="228027809"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:23:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="521881942"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga008.jf.intel.com with ESMTP; 22 Dec 2021 16:23:20 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1BN0N79A032467;
        Thu, 23 Dec 2021 00:23:17 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org, x86@kernel.org
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v9 05/15] x86: support ASM function sections
Date:   Thu, 23 Dec 2021 01:21:59 +0100
Message-Id: <20211223002209.1092165-6-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Address places which need special care and enable
CONFIG_ARCH_SUPPORTS_ASM_FUNCTION_SECTIONS.

Notably:
 - propagate --sectname-subst to aflags in x86/boot/Makefile and
   x86/boot/compressed/Makefile as both override aflags;
 - symbols starting with a dot (like ".Lbad_gs") should be handled
   manually with SYM_*_START_SECT(.Lbad_gs, bad_gs) as "two dots"
   is a special (and CPP doesn't want to concatenate two dots in
   general);
 - some symbols explicitly need to reside in one section (like
   kexec control code, hibernation page etc.);
 - macros creating aliases for functions (like __memcpy() for
   memcpy() etc.) should go after the main declaration (as
   aliases should be declared in the same section and they
   don't have SYM_PUSH_SECTION() inside);
 - things like ".org", ".align" should be manually pushed to
   the same section the next symbol goes to;
 - expand indirect_thunk and .fixup wildcards in vmlinux.lds.S
   to catch symbols back into the "main" section;
 - inline ASM functions like __raw_callee*() should be pushed
   manually as well.

With these changes and `-ffunction-sections enabled`, "plain"
".text" section is empty which means that everything works
right as expected.

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 arch/x86/Kconfig                              |  1 +
 arch/x86/boot/Makefile                        |  1 +
 arch/x86/boot/compressed/Makefile             |  1 +
 arch/x86/boot/compressed/head_32.S            |  2 +-
 arch/x86/boot/compressed/head_64.S            | 32 ++++++++++++-------
 arch/x86/boot/pmjump.S                        |  2 +-
 arch/x86/crypto/aesni-intel_asm.S             |  4 +--
 arch/x86/crypto/poly1305-x86_64-cryptogams.pl |  4 +++
 arch/x86/entry/entry_64.S                     |  2 +-
 arch/x86/include/asm/paravirt.h               |  2 ++
 arch/x86/include/asm/qspinlock_paravirt.h     |  2 ++
 arch/x86/kernel/head_32.S                     |  4 +--
 arch/x86/kernel/head_64.S                     |  4 +--
 arch/x86/kernel/kprobes/core.c                |  2 ++
 arch/x86/kernel/kvm.c                         |  2 ++
 arch/x86/kernel/relocate_kernel_32.S          | 10 +++---
 arch/x86/kernel/relocate_kernel_64.S          | 12 ++++---
 arch/x86/kernel/vmlinux.lds.S                 |  4 +--
 arch/x86/kvm/emulate.c                        |  7 +++-
 arch/x86/lib/copy_user_64.S                   |  2 +-
 arch/x86/lib/error-inject.c                   |  2 ++
 arch/x86/lib/getuser.S                        |  5 ++-
 arch/x86/lib/memcpy_64.S                      |  4 +--
 arch/x86/lib/memmove_64.S                     |  5 ++-
 arch/x86/lib/memset_64.S                      |  5 +--
 arch/x86/lib/putuser.S                        |  2 +-
 arch/x86/power/hibernate_asm_32.S             | 10 +++---
 arch/x86/power/hibernate_asm_64.S             | 10 +++---
 28 files changed, 91 insertions(+), 52 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5c2ccb85f2ef..3e4ea355147b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -102,6 +102,7 @@ config X86
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ACPI
+	select ARCH_SUPPORTS_ASM_FUNCTION_SECTIONS
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index b5aecb524a8a..080990b09f06 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -68,6 +68,7 @@ targets += cpustr.h
 
 KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP
 KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
+KBUILD_AFLAGS	+= $(SECSUBST_AFLAGS)
 KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 GCOV_PROFILE := n
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 431bf7f846c3..4bf32db56010 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -55,6 +55,7 @@ KBUILD_CFLAGS += $(CLANG_FLAGS)
 CFLAGS_sev.o += -I$(objtree)/arch/x86/lib/
 
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
+KBUILD_AFLAGS += $(SECSUBST_AFLAGS)
 GCOV_PROFILE := n
 UBSAN_SANITIZE :=n
 
diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 659fad53ca82..a3a667f5e5cd 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -158,8 +158,8 @@ SYM_FUNC_START_ALIAS(efi_stub_entry)
 	call	efi_main
 	/* efi_main returns the possibly relocated address of startup_32 */
 	jmp	*%eax
-SYM_FUNC_END(efi32_stub_entry)
 SYM_FUNC_END_ALIAS(efi_stub_entry)
+SYM_FUNC_END(efi32_stub_entry)
 #endif
 
 	.text
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 572c535cf45b..c496dab184ef 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -72,7 +72,7 @@
 #define rva(X) ((X) - startup_32)
 
 	.code32
-SYM_FUNC_START(startup_32)
+SYM_FUNC_START_SECT(startup_32, startup)
 	/*
 	 * 32bit entry is 0 and it is ABI so immutable!
 	 * If we come here directly from a bootloader,
@@ -297,8 +297,10 @@ SYM_FUNC_START(startup_32)
 SYM_FUNC_END(startup_32)
 
 #ifdef CONFIG_EFI_MIXED
+SYM_PUSH_SECTION(startup)
 	.org 0x190
-SYM_FUNC_START(efi32_stub_entry)
+SYM_POP_SECTION()
+SYM_FUNC_START_SECT(efi32_stub_entry, startup)
 	add	$0x4, %esp		/* Discard return address */
 	popl	%ecx
 	popl	%edx
@@ -332,8 +334,10 @@ SYM_FUNC_END(efi32_stub_entry)
 #endif
 
 	.code64
+SYM_PUSH_SECTION(startup)
 	.org 0x200
-SYM_CODE_START(startup_64)
+SYM_POP_SECTION()
+SYM_CODE_START_SECT(startup_64, startup)
 	/*
 	 * 64bit entry is 0x200 and it is ABI so immutable!
 	 * We come here either from startup_32 or directly from a
@@ -533,8 +537,10 @@ trampoline_return:
 SYM_CODE_END(startup_64)
 
 #ifdef CONFIG_EFI_STUB
+SYM_PUSH_SECTION(startup)
 	.org 0x390
-SYM_FUNC_START(efi64_stub_entry)
+SYM_POP_SECTION()
+SYM_FUNC_START_SECT(efi64_stub_entry, startup)
 SYM_FUNC_START_ALIAS(efi_stub_entry)
 	and	$~0xf, %rsp			/* realign the stack */
 	movq	%rdx, %rbx			/* save boot_params pointer */
@@ -542,12 +548,12 @@ SYM_FUNC_START_ALIAS(efi_stub_entry)
 	movq	%rbx,%rsi
 	leaq	rva(startup_64)(%rax), %rax
 	jmp	*%rax
-SYM_FUNC_END(efi64_stub_entry)
 SYM_FUNC_END_ALIAS(efi_stub_entry)
+SYM_FUNC_END(efi64_stub_entry)
 #endif
 
 	.text
-SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
+SYM_FUNC_START_LOCAL_NOALIGN_SECT(.Lrelocated, relocated)
 
 /*
  * Clear BSS (stack is currently empty)
@@ -670,20 +676,22 @@ SYM_CODE_START(trampoline_32bit_src)
 SYM_CODE_END(trampoline_32bit_src)
 
 	.code64
-SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
+SYM_FUNC_START_LOCAL_NOALIGN_SECT(.Lpaging_enabled, trampoline_32bit_src)
 	/* Return from the trampoline */
 	jmp	*%rdi
 SYM_FUNC_END(.Lpaging_enabled)
 
+SYM_PUSH_SECTION(trampoline_32bit_src)
 	/*
          * The trampoline code has a size limit.
          * Make sure we fail to compile if the trampoline code grows
          * beyond TRAMPOLINE_32BIT_CODE_SIZE bytes.
 	 */
 	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
+SYM_POP_SECTION()
 
 	.code32
-SYM_FUNC_START_LOCAL_NOALIGN(.Lno_longmode)
+SYM_FUNC_START_LOCAL_NOALIGN_SECT(.Lno_longmode, no_longmode)
 	/* This isn't an x86-64 CPU, so hang intentionally, we cannot continue */
 1:
 	hlt
@@ -747,7 +755,7 @@ SYM_DATA(efi_is64, .byte 1)
 
 	__HEAD
 	.code32
-SYM_FUNC_START(efi32_pe_entry)
+SYM_FUNC_START_SECT(efi32_pe_entry, startup)
 /*
  * efi_status_t efi32_pe_entry(efi_handle_t image_handle,
  *			       efi_system_table_32_t *sys_table)
@@ -839,7 +847,7 @@ SYM_DATA_END(loaded_image_proto)
  *
  * Physical offset is expected in %ebp
  */
-SYM_FUNC_START(startup32_set_idt_entry)
+SYM_FUNC_START_SECT(startup32_set_idt_entry, startup)
 	push    %ebx
 	push    %ecx
 
@@ -872,7 +880,7 @@ SYM_FUNC_START(startup32_set_idt_entry)
 SYM_FUNC_END(startup32_set_idt_entry)
 #endif
 
-SYM_FUNC_START(startup32_load_idt)
+SYM_FUNC_START_SECT(startup32_load_idt, startup)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	/* #VC handler */
 	leal    rva(startup32_vc_handler)(%ebp), %eax
@@ -904,7 +912,7 @@ SYM_FUNC_END(startup32_load_idt)
  * succeed. An incorrect C-bit position will map all memory unencrypted, so that
  * the compare will use the encrypted random data and fail.
  */
-SYM_FUNC_START(startup32_check_sev_cbit)
+SYM_FUNC_START_SECT(startup32_check_sev_cbit, startup)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	pushl	%eax
 	pushl	%ebx
diff --git a/arch/x86/boot/pmjump.S b/arch/x86/boot/pmjump.S
index cbec8bd0841f..e647c17000a9 100644
--- a/arch/x86/boot/pmjump.S
+++ b/arch/x86/boot/pmjump.S
@@ -46,7 +46,7 @@ SYM_FUNC_END(protected_mode_jump)
 
 	.code32
 	.section ".text32","ax"
-SYM_FUNC_START_LOCAL_NOALIGN(.Lin_pm32)
+SYM_FUNC_START_LOCAL_NOALIGN_SECT(.Lin_pm32, in_pm32)
 	# Set up data segments for flat 32-bit mode
 	movl	%ecx, %ds
 	movl	%ecx, %es
diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 4e3972570916..d3d511058520 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -1752,8 +1752,8 @@ SYM_FUNC_END(aesni_gcm_finalize)
 #endif
 
 
-SYM_FUNC_START_LOCAL_ALIAS(_key_expansion_128)
 SYM_FUNC_START_LOCAL(_key_expansion_256a)
+SYM_FUNC_START_LOCAL_ALIAS(_key_expansion_128)
 	pshufd $0b11111111, %xmm1, %xmm1
 	shufps $0b00010000, %xmm0, %xmm4
 	pxor %xmm4, %xmm0
@@ -1763,8 +1763,8 @@ SYM_FUNC_START_LOCAL(_key_expansion_256a)
 	movaps %xmm0, (TKEYP)
 	add $0x10, TKEYP
 	ret
-SYM_FUNC_END(_key_expansion_256a)
 SYM_FUNC_END_ALIAS(_key_expansion_128)
+SYM_FUNC_END(_key_expansion_256a)
 
 SYM_FUNC_START_LOCAL(_key_expansion_192a)
 	pshufd $0b01010101, %xmm1, %xmm1
diff --git a/arch/x86/crypto/poly1305-x86_64-cryptogams.pl b/arch/x86/crypto/poly1305-x86_64-cryptogams.pl
index 71fae5a09e56..221a4596f390 100644
--- a/arch/x86/crypto/poly1305-x86_64-cryptogams.pl
+++ b/arch/x86/crypto/poly1305-x86_64-cryptogams.pl
@@ -421,6 +421,7 @@ my ($H0,$H1,$H2,$H3,$H4, $T0,$T1,$T2,$T3,$T4, $D0,$D1,$D2,$D3,$D4, $MASK) =
     map("%xmm$_",(0..15));
 
 $code.=<<___;
+SYM_PUSH_SECTION(__poly1305_block)
 .type	__poly1305_block,\@abi-omnipotent
 .align	32
 __poly1305_block:
@@ -431,7 +432,9 @@ $code.=<<___;
 	pop $ctx
 	ret
 .size	__poly1305_block,.-__poly1305_block
+SYM_POP_SECTION()
 
+SYM_PUSH_SECTION(__poly1305_init_avx)
 .type	__poly1305_init_avx,\@abi-omnipotent
 .align	32
 __poly1305_init_avx:
@@ -596,6 +599,7 @@ __poly1305_init_avx:
 	pop %rbp
 	ret
 .size	__poly1305_init_avx,.-__poly1305_init_avx
+SYM_POP_SECTION()
 ___
 
 &declare_function("poly1305_blocks_avx", 32, 4);
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 97b1f84bb53f..15eae25753fb 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -745,7 +745,7 @@ EXPORT_SYMBOL(asm_load_gs_index)
 	_ASM_EXTABLE(.Lgs_change, .Lbad_gs)
 	.section .fixup, "ax"
 	/* running with kernelgs */
-SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
+SYM_CODE_START_LOCAL_NOALIGN_SECT(.Lbad_gs, bad_gs)
 	swapgs					/* switch back to user gs */
 .macro ZAP_GS
 	/* This can't be a string because the preprocessor needs to see it. */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 21c4a694ca11..f045af533161 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -663,6 +663,7 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 	extern typeof(func) __raw_callee_save_##func;			\
 									\
 	asm(".pushsection " section ", \"ax\";"				\
+	    ASM_PUSH_SECTION(__raw_callee_save_##func) ";"		\
 	    ".globl " PV_THUNK_NAME(func) ";"				\
 	    ".type " PV_THUNK_NAME(func) ", @function;"			\
 	    PV_THUNK_NAME(func) ":"					\
@@ -673,6 +674,7 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 	    FRAME_END							\
 	    "ret;"							\
 	    ".size " PV_THUNK_NAME(func) ", .-" PV_THUNK_NAME(func) ";"	\
+	    ASM_POP_SECTION() ";"					\
 	    ".popsection")
 
 #define PV_CALLEE_SAVE_REGS_THUNK(func)			\
diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 159622ee0674..209f610dda18 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -35,6 +35,7 @@ PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
  *   rdx = internal variable (set to 0)
  */
 asm    (".pushsection .text;"
+	ASM_PUSH_SECTION(__raw_callee_save___pv_queued_spin_unlock) ";"
 	".globl " PV_UNLOCK ";"
 	".type " PV_UNLOCK ", @function;"
 	".align 4,0x90;"
@@ -58,6 +59,7 @@ asm    (".pushsection .text;"
 	FRAME_END
 	"ret;"
 	".size " PV_UNLOCK ", .-" PV_UNLOCK ";"
+	ASM_POP_SECTION() ";"
 	".popsection");
 
 #else /* CONFIG_64BIT */
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index d8c64dab0efe..aa7a99876397 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -342,7 +342,7 @@ setup_once:
 	andl $0,setup_once_ref	/* Once is enough, thanks */
 	ret
 
-SYM_FUNC_START(early_idt_handler_array)
+SYM_FUNC_START_SECT(early_idt_handler_array, early_idt_handler)
 	# 36(%esp) %eflags
 	# 32(%esp) %cs
 	# 28(%esp) %eip
@@ -359,7 +359,7 @@ SYM_FUNC_START(early_idt_handler_array)
 	.endr
 SYM_FUNC_END(early_idt_handler_array)
 	
-SYM_CODE_START_LOCAL(early_idt_handler_common)
+SYM_CODE_START_LOCAL_SECT(early_idt_handler_common, early_idt_handler)
 	/*
 	 * The stack is the hardware frame, an error code or zero, and the
 	 * vector number.
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d8b3ebd2bb85..1bc081c92775 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -350,7 +350,7 @@ SYM_DATA(initial_stack, .quad init_thread_union + THREAD_SIZE - FRAME_SIZE)
 	__FINITDATA
 
 	__INIT
-SYM_CODE_START(early_idt_handler_array)
+SYM_CODE_START_SECT(early_idt_handler_array, early_idt_handler)
 	i = 0
 	.rept NUM_EXCEPTION_VECTORS
 	.if ((EXCEPTION_ERRCODE_MASK >> i) & 1) == 0
@@ -368,7 +368,7 @@ SYM_CODE_START(early_idt_handler_array)
 	UNWIND_HINT_IRET_REGS offset=16
 SYM_CODE_END(early_idt_handler_array)
 
-SYM_CODE_START_LOCAL(early_idt_handler_common)
+SYM_CODE_START_LOCAL_SECT(early_idt_handler_common, early_idt_handler)
 	/*
 	 * The stack is the hardware frame, an error code or zero, and the
 	 * vector number.
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index fce99e249d61..6938dccfa4a7 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1019,6 +1019,7 @@ NOKPROBE_SYMBOL(kprobe_int3_handler);
  */
 asm(
 	".text\n"
+	ASM_PUSH_SECTION(__kretprobe_trampoline) "\n"
 	".global __kretprobe_trampoline\n"
 	".type __kretprobe_trampoline, @function\n"
 	"__kretprobe_trampoline:\n"
@@ -1053,6 +1054,7 @@ asm(
 #endif
 	"	ret\n"
 	".size __kretprobe_trampoline, .-__kretprobe_trampoline\n"
+	ASM_POP_SECTION() "\n"
 );
 NOKPROBE_SYMBOL(__kretprobe_trampoline);
 /*
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 59abbdad7729..25a08ba473a0 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -1021,6 +1021,7 @@ extern bool __raw_callee_save___kvm_vcpu_is_preempted(long);
  */
 asm(
 ".pushsection .text;"
+ASM_PUSH_SECTION(__raw_callee_save___kvm_vcpu_is_preempted) ";"
 ".global __raw_callee_save___kvm_vcpu_is_preempted;"
 ".type __raw_callee_save___kvm_vcpu_is_preempted, @function;"
 "__raw_callee_save___kvm_vcpu_is_preempted:"
@@ -1029,6 +1030,7 @@ asm(
 "setne	%al;"
 "ret;"
 ".size __raw_callee_save___kvm_vcpu_is_preempted, .-__raw_callee_save___kvm_vcpu_is_preempted;"
+ASM_POP_SECTION() ";"
 ".popsection");
 
 #endif
diff --git a/arch/x86/kernel/relocate_kernel_32.S b/arch/x86/kernel/relocate_kernel_32.S
index f469153eca8a..9077aa9367ca 100644
--- a/arch/x86/kernel/relocate_kernel_32.S
+++ b/arch/x86/kernel/relocate_kernel_32.S
@@ -35,7 +35,7 @@
 #define CP_PA_BACKUP_PAGES_MAP	DATA(0x1c)
 
 	.text
-SYM_CODE_START_NOALIGN(relocate_kernel)
+SYM_CODE_START_NOALIGN_SECT(relocate_kernel, kexec_control_code)
 	/* Save the CPU context, used for jumping back */
 
 	pushl	%ebx
@@ -94,7 +94,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	ret
 SYM_CODE_END(relocate_kernel)
 
-SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
+SYM_CODE_START_LOCAL_NOALIGN_SECT(identity_mapped, kexec_control_code)
 	/* set return address to 0 if not preserving context */
 	pushl	$0
 	/* store the start address on the stack */
@@ -193,7 +193,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	ret
 SYM_CODE_END(identity_mapped)
 
-SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
+SYM_CODE_START_LOCAL_NOALIGN_SECT(virtual_mapped, kexec_control_code)
 	movl	CR4(%edi), %eax
 	movl	%eax, %cr4
 	movl	CR3(%edi), %eax
@@ -212,7 +212,7 @@ SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 SYM_CODE_END(virtual_mapped)
 
 	/* Do the copies */
-SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
+SYM_CODE_START_LOCAL_NOALIGN_SECT(swap_pages, kexec_control_code)
 	movl	8(%esp), %edx
 	movl	4(%esp), %ecx
 	pushl	%ebp
@@ -274,5 +274,7 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	ret
 SYM_CODE_END(swap_pages)
 
+SYM_PUSH_SECTION(kexec_control_code)
 	.globl kexec_control_code_size
 .set kexec_control_code_size, . - relocate_kernel
+SYM_POP_SECTION()
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index c8fe74a28143..91336d71dd2d 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -38,9 +38,11 @@
 #define CP_PA_BACKUP_PAGES_MAP	DATA(0x30)
 
 	.text
+SYM_PUSH_SECTION(kexec_control_code)
 	.align PAGE_SIZE
 	.code64
-SYM_CODE_START_NOALIGN(relocate_kernel)
+SYM_POP_SECTION()
+SYM_CODE_START_NOALIGN_SECT(relocate_kernel, kexec_control_code)
 	UNWIND_HINT_EMPTY
 	/*
 	 * %rdi indirection_page
@@ -107,7 +109,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	ret
 SYM_CODE_END(relocate_kernel)
 
-SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
+SYM_CODE_START_LOCAL_NOALIGN_SECT(identity_mapped, kexec_control_code)
 	UNWIND_HINT_EMPTY
 	/* set return address to 0 if not preserving context */
 	pushq	$0
@@ -213,7 +215,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	ret
 SYM_CODE_END(identity_mapped)
 
-SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
+SYM_CODE_START_LOCAL_NOALIGN_SECT(virtual_mapped, kexec_control_code)
 	UNWIND_HINT_EMPTY
 	movq	RSP(%r8), %rsp
 	movq	CR4(%r8), %rax
@@ -235,7 +237,7 @@ SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 SYM_CODE_END(virtual_mapped)
 
 	/* Do the copies */
-SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
+SYM_CODE_START_LOCAL_NOALIGN_SECT(swap_pages, kexec_control_code)
 	UNWIND_HINT_EMPTY
 	movq	%rdi, %rcx 	/* Put the page_list in %rcx */
 	xorl	%edi, %edi
@@ -291,5 +293,7 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	ret
 SYM_CODE_END(swap_pages)
 
+SYM_PUSH_SECTION(kexec_control_code)
 	.globl kexec_control_code_size
 .set kexec_control_code_size, . - relocate_kernel
+SYM_POP_SECTION()
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3d6dc12d198f..6f026400261e 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -137,12 +137,12 @@ SECTIONS
 		ALIGN_ENTRY_TEXT_END
 		SOFTIRQENTRY_TEXT
 		STATIC_CALL_TEXT
-		*(.fixup)
+		*(SECT_WILDCARD(.fixup))
 		*(.gnu.warning)
 
 #ifdef CONFIG_RETPOLINE
 		__indirect_thunk_start = .;
-		*(.text.__x86.indirect_thunk)
+		*(SECT_WILDCARD(.text.__x86.indirect_thunk))
 		__indirect_thunk_end = .;
 #endif
 	} :text =0xcccc
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 28b1a4e57827..00466f15c4ed 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -307,6 +307,7 @@ static void invalidate_registers(struct x86_emulate_ctxt *ctxt)
 static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 
 #define __FOP_FUNC(name) \
+	__ASM_PUSH_SECTION(name) "\n\t" \
 	".align " __stringify(FASTOP_SIZE) " \n\t" \
 	".type " name ", @function \n\t" \
 	name ":\n\t"
@@ -316,7 +317,8 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 
 #define __FOP_RET(name) \
 	"ret \n\t" \
-	".size " name ", .-" name "\n\t"
+	".size " name ", .-" name "\n\t" \
+	ASM_POP_SECTION() "\n\t"
 
 #define FOP_RET(name) \
 	__FOP_RET(#name)
@@ -324,11 +326,13 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 #define FOP_START(op) \
 	extern void em_##op(struct fastop *fake); \
 	asm(".pushsection .text, \"ax\" \n\t" \
+	    ASM_PUSH_SECTION(em_##op) "\n\t" \
 	    ".global em_" #op " \n\t" \
 	    ".align " __stringify(FASTOP_SIZE) " \n\t" \
 	    "em_" #op ":\n\t"
 
 #define FOP_END \
+	    ASM_POP_SECTION() "\n\t" \
 	    ".popsection")
 
 #define __FOPNOP(name) \
@@ -428,6 +432,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 
 /* Special case for SETcc - 1 instruction per cc */
 #define FOP_SETCC(op) \
+	ASM_PUSH_SECTION(op) "\n\t" \
 	".align 4 \n\t" \
 	".type " #op ", @function \n\t" \
 	#op ": \n\t" \
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 2797e630b9b1..d351e1288a23 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -232,7 +232,7 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  * Output:
  * eax uncopied bytes or 0 if successful.
  */
-SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
+SYM_CODE_START_LOCAL_SECT(.Lcopy_user_handle_tail, copy_user_handle_tail)
 	movl %edx,%ecx
 1:	rep movsb
 2:	mov %ecx,%eax
diff --git a/arch/x86/lib/error-inject.c b/arch/x86/lib/error-inject.c
index be5b5fb1598b..e3ecab588a4c 100644
--- a/arch/x86/lib/error-inject.c
+++ b/arch/x86/lib/error-inject.c
@@ -7,11 +7,13 @@ asmlinkage void just_return_func(void);
 
 asm(
 	".text\n"
+	ASM_PUSH_SECTION(just_return_func) "\n"
 	".type just_return_func, @function\n"
 	".globl just_return_func\n"
 	"just_return_func:\n"
 	"	ret\n"
 	".size just_return_func, .-just_return_func\n"
+	ASM_POP_SECTION() "\n"
 );
 
 void override_function_with_return(struct pt_regs *regs)
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index fa1bc2104b32..35d93412605a 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -163,8 +163,7 @@ SYM_FUNC_START(__get_user_nocheck_8)
 SYM_FUNC_END(__get_user_nocheck_8)
 EXPORT_SYMBOL(__get_user_nocheck_8)
 
-
-SYM_CODE_START_LOCAL(.Lbad_get_user_clac)
+SYM_CODE_START_LOCAL_SECT(.Lbad_get_user_clac, bad_get_user_clac)
 	ASM_CLAC
 bad_get_user:
 	xor %edx,%edx
@@ -173,7 +172,7 @@ bad_get_user:
 SYM_CODE_END(.Lbad_get_user_clac)
 
 #ifdef CONFIG_X86_32
-SYM_CODE_START_LOCAL(.Lbad_get_user_8_clac)
+SYM_CODE_START_LOCAL_SECT(.Lbad_get_user_8_clac, bad_get_user_8_clac)
 	ASM_CLAC
 bad_get_user_8:
 	xor %edx,%edx
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 1cc9da6e29c7..1414c62f7c32 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -27,8 +27,8 @@
  * Output:
  * rax original destination
  */
-SYM_FUNC_START_ALIAS(__memcpy)
 SYM_FUNC_START_WEAK(memcpy)
+SYM_FUNC_START_ALIAS(__memcpy)
 	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
 		      "jmp memcpy_erms", X86_FEATURE_ERMS
 
@@ -40,8 +40,8 @@ SYM_FUNC_START_WEAK(memcpy)
 	movl %edx, %ecx
 	rep movsb
 	ret
-SYM_FUNC_END(memcpy)
 SYM_FUNC_END_ALIAS(__memcpy)
+SYM_FUNC_END(memcpy)
 EXPORT_SYMBOL(memcpy)
 EXPORT_SYMBOL(__memcpy)
 
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 64801010d312..e397791ec067 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -24,9 +24,8 @@
  * Output:
  * rax: dest
  */
-SYM_FUNC_START_WEAK(memmove)
 SYM_FUNC_START(__memmove)
-
+SYM_FUNC_START_WEAK_ALIAS(memmove)
 	mov %rdi, %rax
 
 	/* Decide forward/backward copy mode */
@@ -206,7 +205,7 @@ SYM_FUNC_START(__memmove)
 	movb %r11b, (%rdi)
 13:
 	retq
-SYM_FUNC_END(__memmove)
 SYM_FUNC_END_ALIAS(memmove)
+SYM_FUNC_END(__memmove)
 EXPORT_SYMBOL(__memmove)
 EXPORT_SYMBOL(memmove)
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 9827ae267f96..5fa7f64edc9c 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -17,8 +17,9 @@
  *
  * rax   original destination
  */
-SYM_FUNC_START_WEAK(memset)
+
 SYM_FUNC_START(__memset)
+SYM_FUNC_START_WEAK_ALIAS(memset)
 	/*
 	 * Some CPUs support enhanced REP MOVSB/STOSB feature. It is recommended
 	 * to use it when possible. If not available, use fast string instructions.
@@ -41,8 +42,8 @@ SYM_FUNC_START(__memset)
 	rep stosb
 	movq %r9,%rax
 	ret
-SYM_FUNC_END(__memset)
 SYM_FUNC_END_ALIAS(memset)
+SYM_FUNC_END(__memset)
 EXPORT_SYMBOL(memset)
 EXPORT_SYMBOL(__memset)
 
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 0ea344c5ea43..a7e1be50841a 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -102,7 +102,7 @@ SYM_FUNC_END(__put_user_8)
 EXPORT_SYMBOL(__put_user_8)
 EXPORT_SYMBOL(__put_user_nocheck_8)
 
-SYM_CODE_START_LOCAL(.Lbad_put_user_clac)
+SYM_CODE_START_LOCAL_SECT(.Lbad_put_user_clac, bad_put_user_clac)
 	ASM_CLAC
 .Lbad_put_user:
 	movl $-EFAULT,%ecx
diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index 8786653ad3c0..492dd2bcce4b 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -16,7 +16,7 @@
 
 .text
 
-SYM_FUNC_START(swsusp_arch_suspend)
+SYM_FUNC_START_SECT(swsusp_arch_suspend, hibernate_page)
 	movl %esp, saved_context_esp
 	movl %ebx, saved_context_ebx
 	movl %ebp, saved_context_ebp
@@ -35,7 +35,7 @@ SYM_FUNC_START(swsusp_arch_suspend)
 	ret
 SYM_FUNC_END(swsusp_arch_suspend)
 
-SYM_CODE_START(restore_image)
+SYM_CODE_START_SECT(restore_image, hibernate_page)
 	/* prepare to jump to the image kernel */
 	movl	restore_jump_address, %ebx
 	movl	restore_cr3, %ebp
@@ -48,7 +48,7 @@ SYM_CODE_START(restore_image)
 SYM_CODE_END(restore_image)
 
 /* code below has been relocated to a safe page */
-SYM_CODE_START(core_restore_code)
+SYM_CODE_START_SECT(core_restore_code, hibernate_page)
 	movl	temp_pgt, %eax
 	movl	%eax, %cr3
 
@@ -81,8 +81,10 @@ done:
 SYM_CODE_END(core_restore_code)
 
 	/* code below belongs to the image kernel */
+SYM_PUSH_SECTION(hibernate_page)
 	.align PAGE_SIZE
-SYM_FUNC_START(restore_registers)
+SYM_POP_SECTION()
+SYM_FUNC_START_SECT(restore_registers, hibernate_page)
 	/* go back to the original page tables */
 	movl	%ebp, %cr3
 	movl	mmu_cr4_features, %ecx
diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index d9bed596d849..225be7a985d5 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -24,8 +24,10 @@
 #include <asm/nospec-branch.h>
 
 	 /* code below belongs to the image kernel */
+SYM_PUSH_SECTION(hibernate_page)
 	.align PAGE_SIZE
-SYM_FUNC_START(restore_registers)
+SYM_POP_SECTION()
+SYM_FUNC_START_SECT(restore_registers, hibernate_page)
 	/* go back to the original page tables */
 	movq    %r9, %cr3
 
@@ -69,7 +71,7 @@ SYM_FUNC_START(restore_registers)
 	ret
 SYM_FUNC_END(restore_registers)
 
-SYM_FUNC_START(swsusp_arch_suspend)
+SYM_FUNC_START_SECT(swsusp_arch_suspend, hibernate_page)
 	movq	$saved_context, %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
@@ -99,7 +101,7 @@ SYM_FUNC_START(swsusp_arch_suspend)
 	ret
 SYM_FUNC_END(swsusp_arch_suspend)
 
-SYM_FUNC_START(restore_image)
+SYM_FUNC_START_SECT(restore_image, hibernate_page)
 	/* prepare to jump to the image kernel */
 	movq	restore_jump_address(%rip), %r8
 	movq	restore_cr3(%rip), %r9
@@ -118,7 +120,7 @@ SYM_FUNC_START(restore_image)
 SYM_FUNC_END(restore_image)
 
 	/* code below has been relocated to a safe page */
-SYM_FUNC_START(core_restore_code)
+SYM_FUNC_START_SECT(core_restore_code, hibernate_page)
 	/* switch to temporary page tables */
 	movq	%rax, %cr3
 	/* flush TLB */
-- 
2.33.1

