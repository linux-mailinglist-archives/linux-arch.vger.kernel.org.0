Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E68D6C8CD0
	for <lists+linux-arch@lfdr.de>; Sat, 25 Mar 2023 09:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjCYIy1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Mar 2023 04:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYIy0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Mar 2023 04:54:26 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FE2FF16;
        Sat, 25 Mar 2023 01:54:21 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x15so3439564pjk.2;
        Sat, 25 Mar 2023 01:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679734461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxzWcmwxfumvw06OzVJ/yMbENPGmTunYQ4gTxXUdKlI=;
        b=idb79Si3cccJizWjii+4DctDPbdgUrjT3Z05o/fCLtH/1thefxr4A4LFzgR2aA88tC
         Ss6X840MB9ySvakMahCKd4E6RATba9CqEbznUdTfgjQYXxh1FMqVJf4xSHjEa2d4k4Zo
         9230FyaWM8dyByzmoLM9NHzG6fIAcINzZ9mzowg4wGKX05xNjg/e1FIkOCQ9VpDwUadS
         9JFT6iOQ70BAlcuCAiOabLnyuCdHwK99vxd1dnLnDDMREpqx/Hjog2QadtL7nuiv4S+l
         KxcgFKwjvA1IK8AssHJSW5np+trW/Ty7y9WNoJLRZLvgSuZ8BYKeMb6toE6XVHa32rQh
         Kh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679734461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxzWcmwxfumvw06OzVJ/yMbENPGmTunYQ4gTxXUdKlI=;
        b=s6vPTJDoinBZUiGqzqP4Jg4oq7YxXr8X6BXh79SE8niW1m529er5zQnVNSH3fvT23U
         DGZ6iayvv5D83zYUIRs9/GjR1mXLR8F4PW+BtrprZZtHSjRUL+pdRfvaYyv0F6I9wfFJ
         zmriP1SLQD+3a3XndEPTcTS32HHwGJdQ425D4v9srDYUsiBQt9fktOBMHI4swfG/C+03
         DAB13LoOwPPzG+wOOYJ8xWVKZiALPWvjh7G7x5aWn6eIbvNbWZXWAeUVgNvi6RFrNrHo
         /qgEgjCC8a++R8qtUKMk+MeKugeGjlJFsyJeMUCiCXguYV4LhpXmTbrOgSY1yxn2k94l
         RMSg==
X-Gm-Message-State: AAQBX9d6UnV9tCwXPgUxoRTpBgNCZC+qomkFdH6Qd0ka3U2Xpx4Uc0vV
        KdsGO57dqoRkYijyOTK6bao=
X-Google-Smtp-Source: AKy350aRz00qMkI64NXn9kQxKNy7q6I4LAkTa9m2YXXfL8yRQhWkrhVJREm/139YrzJdRB3t8WELKw==
X-Received: by 2002:a17:902:e812:b0:19c:e440:9256 with SMTP id u18-20020a170902e81200b0019ce4409256mr7129674plg.35.1679734460720;
        Sat, 25 Mar 2023 01:54:20 -0700 (PDT)
Received: from localhost ([103.152.220.91])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b00198d7b52eefsm15395659plk.257.2023.03.25.01.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Mar 2023 01:54:20 -0700 (PDT)
From:   Dan Li <ashimida.1990@gmail.com>
To:     Aaron Tomlin <atomlin@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Brian Gerst <brgerst@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Changbin Du <changbin.du@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dan Li <ashimida.1990@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        gcc-patches@gcc.gnu.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Marco Elver <elver@google.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Roth <michael.roth@amd.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>, Uros Bizjak <ubizjak@gmail.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Yuntao Wang <ytcoode@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [RFC/RFT,V2] CFI: Add support for gcc CFI in aarch64
Date:   Sat, 25 Mar 2023 01:54:16 -0700
Message-Id: <20230325085416.95191-1-ashimida.1990@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221219061758.23321-1-ashimida.1990@gmail.com>
References: <20221219061758.23321-1-ashimida.1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Based on Sami's patch[1], this patch makes the corresponding kernel
configuration of CFI available when compiling the kernel with the gcc[2].

The code after enabling cfi (with -fsanitize=kcfi,
-fpatchable-function-entry=3,1) is as follows:

int (*p)(void);
int func (int)
{
  	p();
}

__kcfi_func:
        .4byte 0x439d3502
        .global func
        .text
.LPFE1:
        nop
        .type   func, %function
func:
        nop
        nop
.LFB0:
        ......
        adrp    x0, p
        add     x0, x0, :lo12:p
        ldr     x0, [x0]
        ldur    w16, [x0, #-8]
        movk    w17, #23592
        movk    w17, #17921, lsl #16
        cmp     w16, w17
        b.eq    .Lkcfi2
        brk     #0x8220
.Lkcfi2:
        blr     x0
        ......

In the compiler part[4], most of the content is the same as Sami's
implementation[3], except for some minor differences, mainly including:

1. The function typeid is calculated differently and it is difficult
to be consistent.

2. A reserved typeid (such as 0x0U on the aarch64 platform) is always
inserted in front of functions that should not be called indirectly.
Functions that can be called indirectly will not use this hash value,
which prevents instructions/data before the function from being used
as a typeid by an attacker.

3. Some bits are ignored in the typeid to avoid conflicts between the
typeid and the instruction set of a specific platform, thereby preventing
an attacker from bypassing the CFI check by using the instruction as a
typeid, such as on the aarch64 platform:
* If the following instruction sequence exists:
	400620:       a9be7bfd        stp     x29, x30, [sp, #-32]!
	400624:       910003fd        mov     x29, sp
	400628:       f9000bf3        str     x19, [sp, #16]
* If the expected typeid of the indirect call is exactly 0x910003fd,
  the attacker can jump to the next instruction position of any
  "mov x29,sp" instruction (such as 0x400628 here).

4. Insert a symbol __kcfi_<function> before each function's typeid,
which may be helpful for fine-grained KASLR implementations.

I'm not sure if these distinctions need to be removed, they're kept
in this version for now, and I'm happy to remove them in the next
version if necessary (except for the first one).

The current implementation of gcc only supports the aarch64 platform，
the x86 version is still in progress.

This produces the following oops on CFI failure (generated using lkdtm):

/ # echo CFI_FORWARD_PROTO > /sys/kernel/debug/provoke-crash/DIRECT
[   17.153364] lkdtm: Performing direct entry CFI_FORWARD_PROTO
[   17.153675] lkdtm: Calling matched prototype ...
[   17.154188] lkdtm: Calling mismatched prototype ...
[   17.154553] CFI failure at lkdtm_indirect_call+0x38/0x54 (target: lkdtm_increment_int+0x0/0x2c; expected type: 0xc59c68f1)
[   17.155627] Internal error: Oops - CFI: 0000000000000000 [#1] PREEMPT SMP
[   17.156025] Modules linked in:
[   17.156580] CPU: 1 PID: 110 Comm: sh Not tainted 6.1.0-00001-g7ead10685f57-dirty #2
[   17.156975] Hardware name: linux,dummy-virt (DT)
[   17.157290] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   17.157621] pc : lkdtm_indirect_call+0x38/0x54
[   17.157902] lr : lkdtm_CFI_FORWARD_PROTO+0x48/0x7c
[   17.158142] sp : ffff80000b083c80
[   17.158316] x29: ffff80000b083c80 x28: ffff0000068ccc40 x27: 0000000000000000
[   17.158820] x26: 0000000000000000 x25: 0000000000000000 x24: 000000000bd069a0
[   17.159239] x23: ffff0000053493c0 x22: ffff80000b083df0 x21: 0000000000000012
[   17.159673] x20: ffff80000aa29150 x19: ffff000006909000 x18: ffff80000b035068
[   17.160110] x17: 00000000c59c68f1 x16: 00000000a2d40772 x15: 0000000000000006
[   17.160530] x14: 0000000000000000 x13: 2e2e2e2065707974 x12: 6f746f7270206465
[   17.160947] x11: 686374616d73696d x10: ffff80000a7254b8 x9 : ffff800009268330
[   17.161376] x8 : 00000000ffffefff x7 : ffff80000a7254b8 x6 : 80000000fffff000
[   17.161789] x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000000
[   17.162264] x2 : 0000000000000000 x1 : ffff800008a4e248 x0 : ffff80000abca500
[   17.162865] Call trace:
[   17.163099]  lkdtm_indirect_call+0x38/0x54
[   17.163411]  lkdtm_CFI_FORWARD_PROTO+0x48/0x7c
[   17.163663]  lkdtm_do_action+0x48/0x5c
[   17.163876]  direct_entry+0x144/0x160
[   17.164084]  full_proxy_write+0x84/0xe4
[   17.164298]  vfs_write+0xe8/0x32c

The gcc-related patches[4] are based on tag: releases/gcc-12.2.0.
This patch is based on tag: v6.2.

Sorry for the long delay, the next version should not be that slow.
Any suggestion please let me know :).

Thanks,
Dan.

[1] https://lore.kernel.org/all/20220908215504.3686827-1-samitolvanen@google.com/
[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107048
[3] https://reviews.llvm.org/D119296
[4] https://lore.kernel.org/all/20230325081117.93245-1-ashimida.1990@gmail.com/

Signed-off-by: Dan Li <ashimida.1990@gmail.com>

---
RFC/RFT V2:
- The CFI typeid check is changed from the form of calling the callback
function to the calling of the brk instruction.
- Add support for -fpatchable-function-entry=M,N
---
 Makefile                                |  2 +-
 arch/Kconfig                            | 21 +++++++++++----------
 arch/arm64/Kconfig                      |  2 +-
 arch/arm64/kernel/traps.c               |  8 ++++----
 arch/x86/Kconfig                        | 12 ++++++------
 arch/x86/include/asm/cfi.h              |  4 ++--
 arch/x86/kernel/Makefile                |  2 +-
 arch/x86/purgatory/Makefile             |  2 +-
 drivers/misc/lkdtm/cfi.c                |  2 +-
 include/asm-generic/vmlinux.lds.h       |  2 +-
 include/linux/cfi.h                     |  4 ++--
 include/linux/cfi_types.h               |  6 +++---
 include/linux/compiler-gcc.h            |  4 ++++
 kernel/Makefile                         |  2 +-
 kernel/module/Kconfig                   |  2 +-
 scripts/kallsyms.c                      |  3 ++-
 tools/perf/util/include/linux/linkage.h |  2 +-
 17 files changed, 43 insertions(+), 37 deletions(-)

diff --git a/Makefile b/Makefile
index 3f6628780eb2..0dd22c76c39e 100644
--- a/Makefile
+++ b/Makefile
@@ -1014,7 +1014,7 @@ KBUILD_AFLAGS	+= -fno-lto
 export CC_FLAGS_LTO
 endif
 
-ifdef CONFIG_CFI_CLANG
+ifdef CONFIG_CFI
 CC_FLAGS_CFI	:= -fsanitize=kcfi
 KBUILD_CFLAGS	+= $(CC_FLAGS_CFI)
 export CC_FLAGS_CFI
diff --git a/arch/Kconfig b/arch/Kconfig
index 12e3ddabac9d..ff015a611091 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -748,33 +748,34 @@ config LTO_CLANG_THIN
 	  If unsure, say Y.
 endchoice
 
-config ARCH_SUPPORTS_CFI_CLANG
+config ARCH_SUPPORTS_CFI
 	bool
 	help
-	  An architecture should select this option if it can support Clang's
-	  Control-Flow Integrity (CFI) checking.
+	  An architecture should select this option if it can support the
+	  compiler's Control-Flow Integrity (CFI) checking.
 
 config ARCH_USES_CFI_TRAPS
 	bool
 
-config CFI_CLANG
-	bool "Use Clang's Control Flow Integrity (CFI)"
-	depends on ARCH_SUPPORTS_CFI_CLANG
+config CFI
+	bool "Use Control Flow Integrity (CFI)"
+	depends on ARCH_SUPPORTS_CFI
 	depends on $(cc-option,-fsanitize=kcfi)
 	help
-	  This option enables Clang’s forward-edge Control Flow Integrity
+	  This option enables the compiler’s forward-edge Control Flow Integrity
 	  (CFI) checking, where the compiler injects a runtime check to each
 	  indirect function call to ensure the target is a valid function with
 	  the correct static type. This restricts possible call targets and
 	  makes it more difficult for an attacker to exploit bugs that allow
 	  the modification of stored function pointers. More information can be
-	  found from Clang's documentation:
+	  found from the compiler's documentation:
 
-	    https://clang.llvm.org/docs/ControlFlowIntegrity.html
+	  - Clang: https://clang.llvm.org/docs/ControlFlowIntegrity.html
+	  - GCC: https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html#Instrumentation-Options
 
 config CFI_PERMISSIVE
 	bool "Use CFI in permissive mode"
-	depends on CFI_CLANG
+	depends on CFI
 	help
 	  When selected, Control Flow Integrity (CFI) violations result in a
 	  warning instead of a kernel panic. This option should only be used
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c5ccca26a408..8795d4f68420 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -90,7 +90,7 @@ config ARM64
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
 	select ARCH_SUPPORTS_LTO_CLANG if CPU_LITTLE_ENDIAN
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
-	select ARCH_SUPPORTS_CFI_CLANG
+	select ARCH_SUPPORTS_CFI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_NUMA_BALANCING
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 4c0caa589e12..26d29dfdf3eb 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -981,7 +981,7 @@ static struct break_hook bug_break_hook = {
 	.imm = BUG_BRK_IMM,
 };
 
-#ifdef CONFIG_CFI_CLANG
+#ifdef CONFIG_CFI
 static int cfi_handler(struct pt_regs *regs, unsigned long esr)
 {
 	unsigned long target;
@@ -1011,7 +1011,7 @@ static struct break_hook cfi_break_hook = {
 	.imm = CFI_BRK_IMM_BASE,
 	.mask = CFI_BRK_IMM_MASK,
 };
-#endif /* CONFIG_CFI_CLANG */
+#endif /* CONFIG_CFI*/
 
 static int reserved_fault_handler(struct pt_regs *regs, unsigned long esr)
 {
@@ -1084,7 +1084,7 @@ static struct break_hook kasan_break_hook = {
 int __init early_brk64(unsigned long addr, unsigned long esr,
 		struct pt_regs *regs)
 {
-#ifdef CONFIG_CFI_CLANG
+#ifdef CONFIG_CFI
 	if ((esr_comment(esr) & ~CFI_BRK_IMM_MASK) == CFI_BRK_IMM_BASE)
 		return cfi_handler(regs, esr) != DBG_HOOK_HANDLED;
 #endif
@@ -1098,7 +1098,7 @@ int __init early_brk64(unsigned long addr, unsigned long esr,
 void __init trap_init(void)
 {
 	register_kernel_break_hook(&bug_break_hook);
-#ifdef CONFIG_CFI_CLANG
+#ifdef CONFIG_CFI
 	register_kernel_break_hook(&cfi_break_hook);
 #endif
 	register_kernel_break_hook(&fault_break_hook);
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3604074a878b..f014c58ef8a3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -110,8 +110,8 @@ config X86
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK	if X86_64
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
-	select ARCH_SUPPORTS_CFI_CLANG		if X86_64
-	select ARCH_USES_CFI_TRAPS		if X86_64 && CFI_CLANG
+	select ARCH_SUPPORTS_CFI		if X86_64
+	select ARCH_USES_CFI_TRAPS		if X86_64 && CFI
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_USE_BUILTIN_BSWAP
@@ -2501,11 +2501,11 @@ config FUNCTION_PADDING_CFI
 	default  3 if FUNCTION_ALIGNMENT_8B
 	default  0
 
-# Basically: FUNCTION_ALIGNMENT - 5*CFI_CLANG
+# Basically: FUNCTION_ALIGNMENT - 5*CFI
 # except Kconfig can't do arithmetic :/
 config FUNCTION_PADDING_BYTES
 	int
-	default FUNCTION_PADDING_CFI if CFI_CLANG
+	default FUNCTION_PADDING_CFI if CFI
 	default FUNCTION_ALIGNMENT
 
 config CALL_PADDING
@@ -2515,7 +2515,7 @@ config CALL_PADDING
 
 config FINEIBT
 	def_bool y
-	depends on X86_KERNEL_IBT && CFI_CLANG && RETPOLINE
+	depends on X86_KERNEL_IBT && CFI && RETPOLINE
 	select CALL_PADDING
 
 config HAVE_CALL_THUNKS
@@ -2528,7 +2528,7 @@ config CALL_THUNKS
 
 config PREFIX_SYMBOLS
 	def_bool y
-	depends on CALL_PADDING && !CFI_CLANG
+	depends on CALL_PADDING && !CFI
 
 menuconfig SPECULATION_MITIGATIONS
 	bool "Mitigations for speculative execution vulnerabilities"
diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 58dacd90daef..dad029608ac2 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -10,13 +10,13 @@
 
 #include <linux/cfi.h>
 
-#ifdef CONFIG_CFI_CLANG
+#ifdef CONFIG_CFI
 enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
 #else
 static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 {
 	return BUG_TRAP_TYPE_NONE;
 }
-#endif /* CONFIG_CFI_CLANG */
+#endif /* CONFIG_CFI */
 
 #endif /* _ASM_X86_CFI_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 96d51bbc2bd4..2e756e8f5bc1 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -141,7 +141,7 @@ obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
 
-obj-$(CONFIG_CFI_CLANG)			+= cfi.o
+obj-$(CONFIG_CFI)			+= cfi.o
 
 obj-$(CONFIG_CALL_THUNKS)		+= callthunks.o
 
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 17f09dc26381..a88b7212d39e 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -56,7 +56,7 @@ ifdef CONFIG_RETPOLINE
 PURGATORY_CFLAGS_REMOVE		+= $(RETPOLINE_CFLAGS)
 endif
 
-ifdef CONFIG_CFI_CLANG
+ifdef CONFIG_CFI
 PURGATORY_CFLAGS_REMOVE		+= $(CC_FLAGS_CFI)
 endif
 
diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
index fc28714ae3a6..2720fe4c57a6 100644
--- a/drivers/misc/lkdtm/cfi.c
+++ b/drivers/misc/lkdtm/cfi.c
@@ -43,7 +43,7 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
 	lkdtm_indirect_call((void *)lkdtm_increment_int);
 
 	pr_err("FAIL: survived mismatched prototype function call!\n");
-	pr_expected_config(CONFIG_CFI_CLANG);
+	pr_expected_config(CONFIG_CFI);
 }
 
 /*
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 659bf3b31c91..1276722fdf95 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -162,7 +162,7 @@
 #define PATCHABLE_DISCARDS	*(__patchable_function_entries)
 #endif
 
-#ifndef CONFIG_ARCH_SUPPORTS_CFI_CLANG
+#ifndef CONFIG_ARCH_SUPPORTS_CFI
 /*
  * Simply points to ftrace_stub, but with the proper protocol.
  * Defined by the linker script in linux/vmlinux.lds.h
diff --git a/include/linux/cfi.h b/include/linux/cfi.h
index 5e134f4ce8b7..d15cfc3c748b 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -10,7 +10,7 @@
 #include <linux/bug.h>
 #include <linux/module.h>
 
-#ifdef CONFIG_CFI_CLANG
+#ifdef CONFIG_CFI
 enum bug_trap_type report_cfi_failure(struct pt_regs *regs, unsigned long addr,
 				      unsigned long *target, u32 type);
 
@@ -23,7 +23,7 @@ static inline enum bug_trap_type report_cfi_failure_noaddr(struct pt_regs *regs,
 #ifdef CONFIG_ARCH_USES_CFI_TRAPS
 bool is_cfi_trap(unsigned long addr);
 #endif
-#endif /* CONFIG_CFI_CLANG */
+#endif /* CONFIG_CFI */
 
 #ifdef CONFIG_MODULES
 #ifdef CONFIG_ARCH_USES_CFI_TRAPS
diff --git a/include/linux/cfi_types.h b/include/linux/cfi_types.h
index 6b8713675765..2e098274e45c 100644
--- a/include/linux/cfi_types.h
+++ b/include/linux/cfi_types.h
@@ -8,7 +8,7 @@
 #ifdef __ASSEMBLY__
 #include <linux/linkage.h>
 
-#ifdef CONFIG_CFI_CLANG
+#ifdef CONFIG_CFI
 /*
  * Use the __kcfi_typeid_<function> type identifier symbol to
  * annotate indirectly called assembly functions. The compiler emits
@@ -29,12 +29,12 @@
 #define SYM_TYPED_START(name, linkage, align...)	\
 	SYM_TYPED_ENTRY(name, linkage, align)
 
-#else /* CONFIG_CFI_CLANG */
+#else /* CONFIG_CFI */
 
 #define SYM_TYPED_START(name, linkage, align...)	\
 	SYM_START(name, linkage, align)
 
-#endif /* CONFIG_CFI_CLANG */
+#endif /* CONFIG_CFI */
 
 #ifndef SYM_TYPED_FUNC_START
 #define SYM_TYPED_FUNC_START(name) 			\
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 7af9e34ec261..4838081392e2 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -82,6 +82,10 @@
 #define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
 
+#ifdef CONFIG_CFI
+#define __nocfi __attribute__((no_sanitize("kcfi")))
+#endif
+
 #define __no_sanitize_address __attribute__((__no_sanitize_address__))
 
 #if defined(__SANITIZE_THREAD__)
diff --git a/kernel/Makefile b/kernel/Makefile
index 10ef068f598d..756abc34140e 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -112,7 +112,7 @@ obj-$(CONFIG_KCSAN) += kcsan/
 obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
 obj-$(CONFIG_HAVE_STATIC_CALL) += static_call.o
 obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call_inline.o
-obj-$(CONFIG_CFI_CLANG) += cfi.o
+obj-$(CONFIG_CFI) += cfi.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 424b3bc58f3f..e40de2aaea87 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -289,6 +289,6 @@ config UNUSED_KSYMS_WHITELIST
 
 config MODULES_TREE_LOOKUP
 	def_bool y
-	depends on PERF_EVENTS || TRACING || CFI_CLANG
+	depends on PERF_EVENTS || TRACING || CFI
 
 endif # MODULES
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 8a68179a98a3..bbb6d3a91089 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -136,7 +136,8 @@ static bool is_ignored_symbol(const char *name, char type)
 		"__ThumbV7PILongThunk_",
 		"__LA25Thunk_",		/* mips lld */
 		"__microLA25Thunk_",
-		"__kcfi_typeid_",	/* CFI type identifiers */
+		"__kcfi_",		/* CFI type identifiers */
+		"__pi___kcfi",		/* CFI type identifiers */
 		NULL
 	};
 
diff --git a/tools/perf/util/include/linux/linkage.h b/tools/perf/util/include/linux/linkage.h
index 75e2248416f5..20d87771f6ac 100644
--- a/tools/perf/util/include/linux/linkage.h
+++ b/tools/perf/util/include/linux/linkage.h
@@ -116,7 +116,7 @@
 #endif
 
 // In the kernel sources (include/linux/cfi_types.h), this has a different
-// definition when CONFIG_CFI_CLANG is used, for tools/ just use the !clang
+// definition when CONFIG_CFI is used, for tools/ just use the !clang
 // definition:
 #ifndef SYM_TYPED_START
 #define SYM_TYPED_START(name, linkage, align...)        \
-- 
2.17.1

