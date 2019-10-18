Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E307DCB35
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 18:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443040AbfJRQbR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 12:31:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57840 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443015AbfJRQbQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 12:31:16 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iLV9G-00033g-4R; Fri, 18 Oct 2019 18:30:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CA5CC1C03AB;
        Fri, 18 Oct 2019 18:30:34 +0200 (CEST)
Date:   Fri, 18 Oct 2019 16:30:34 -0000
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] linkage: Introduce new macros for assembler symbols
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Len Brown <len.brown@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, "x86-ml" <x86@kernel.org>,
        xen-devel@lists.xenproject.org, Borislav Petkov <bp@alien8.de>
In-Reply-To: <20191011115108.12392-2-jslaby@suse.cz>
References: <20191011115108.12392-2-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157141623459.29376.12545407561193574329.tip-bot2@tip-bot2>
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

Commit-ID:     ffedeeb780dc554eff3d3b16e6a462a26a41d7ec
Gitweb:        https://git.kernel.org/tip/ffedeeb780dc554eff3d3b16e6a462a26a41d7ec
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Fri, 11 Oct 2019 13:50:41 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Oct 2019 09:48:11 +02:00

linkage: Introduce new macros for assembler symbols

Introduce new C macros for annotations of functions and data in
assembly. There is a long-standing mess in macros like ENTRY, END,
ENDPROC and similar. They are used in different manners and sometimes
incorrectly.

So introduce macros with clear use to annotate assembly as follows:

a) Support macros for the ones below
   SYM_T_FUNC -- type used by assembler to mark functions
   SYM_T_OBJECT -- type used by assembler to mark data
   SYM_T_NONE -- type used by assembler to mark entries of unknown type

   They are defined as STT_FUNC, STT_OBJECT, and STT_NOTYPE
   respectively. According to the gas manual, this is the most portable
   way. I am not sure about other assemblers, so this can be switched
   back to %function and %object if this turns into a problem.
   Architectures can also override them by something like ", @function"
   if they need.

   SYM_A_ALIGN, SYM_A_NONE -- align the symbol?
   SYM_L_GLOBAL, SYM_L_WEAK, SYM_L_LOCAL -- linkage of symbols

b) Mostly internal annotations, used by the ones below
   SYM_ENTRY -- use only if you have to (for non-paired symbols)
   SYM_START -- use only if you have to (for paired symbols)
   SYM_END -- use only if you have to (for paired symbols)

c) Annotations for code
   SYM_INNER_LABEL_ALIGN -- only for labels in the middle of code
   SYM_INNER_LABEL -- only for labels in the middle of code

   SYM_FUNC_START_LOCAL_ALIAS -- use where there are two local names for
	one function
   SYM_FUNC_START_ALIAS -- use where there are two global names for one
	function
   SYM_FUNC_END_ALIAS -- the end of LOCAL_ALIASed or ALIASed function

   SYM_FUNC_START -- use for global functions
   SYM_FUNC_START_NOALIGN -- use for global functions, w/o alignment
   SYM_FUNC_START_LOCAL -- use for local functions
   SYM_FUNC_START_LOCAL_NOALIGN -- use for local functions, w/o
	alignment
   SYM_FUNC_START_WEAK -- use for weak functions
   SYM_FUNC_START_WEAK_NOALIGN -- use for weak functions, w/o alignment
   SYM_FUNC_END -- the end of SYM_FUNC_START_LOCAL, SYM_FUNC_START,
	SYM_FUNC_START_WEAK, ...

   For functions with special (non-C) calling conventions:
   SYM_CODE_START -- use for non-C (special) functions
   SYM_CODE_START_NOALIGN -- use for non-C (special) functions, w/o
	alignment
   SYM_CODE_START_LOCAL -- use for local non-C (special) functions
   SYM_CODE_START_LOCAL_NOALIGN -- use for local non-C (special)
	functions, w/o alignment
   SYM_CODE_END -- the end of SYM_CODE_START_LOCAL or SYM_CODE_START

d) For data
   SYM_DATA_START -- global data symbol
   SYM_DATA_START_LOCAL -- local data symbol
   SYM_DATA_END -- the end of the SYM_DATA_START symbol
   SYM_DATA_END_LABEL -- the labeled end of SYM_DATA_START symbol
   SYM_DATA -- start+end wrapper around simple global data
   SYM_DATA_LOCAL -- start+end wrapper around simple local data

==========

The macros allow to pair starts and ends of functions and mark functions
correctly in the output ELF objects.

All users of the old macros in x86 are converted to use these in further
patches.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: x86-ml <x86@kernel.org>
Cc: xen-devel@lists.xenproject.org
Link: https://lkml.kernel.org/r/20191011115108.12392-2-jslaby@suse.cz
---
 Documentation/asm-annotations.rst | 216 ++++++++++++++++++++++++++-
 Documentation/index.rst           |   8 +-
 arch/x86/include/asm/linkage.h    |  10 +-
 include/linux/linkage.h           | 245 ++++++++++++++++++++++++++++-
 4 files changed, 468 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/asm-annotations.rst

diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
new file mode 100644
index 0000000..29ccd6e
--- /dev/null
+++ b/Documentation/asm-annotations.rst
@@ -0,0 +1,216 @@
+Assembler Annotations
+=====================
+
+Copyright (c) 2017-2019 Jiri Slaby
+
+This document describes the new macros for annotation of data and code in
+assembly. In particular, it contains information about ``SYM_FUNC_START``,
+``SYM_FUNC_END``, ``SYM_CODE_START``, and similar.
+
+Rationale
+---------
+Some code like entries, trampolines, or boot code needs to be written in
+assembly. The same as in C, such code is grouped into functions and
+accompanied with data. Standard assemblers do not force users into precisely
+marking these pieces as code, data, or even specifying their length.
+Nevertheless, assemblers provide developers with such annotations to aid
+debuggers throughout assembly. On top of that, developers also want to mark
+some functions as *global* in order to be visible outside of their translation
+units.
+
+Over time, the Linux kernel has adopted macros from various projects (like
+``binutils``) to facilitate such annotations. So for historic reasons,
+developers have been using ``ENTRY``, ``END``, ``ENDPROC``, and other
+annotations in assembly.  Due to the lack of their documentation, the macros
+are used in rather wrong contexts at some locations. Clearly, ``ENTRY`` was
+intended to denote the beginning of global symbols (be it data or code).
+``END`` used to mark the end of data or end of special functions with
+*non-standard* calling convention. In contrast, ``ENDPROC`` should annotate
+only ends of *standard* functions.
+
+When these macros are used correctly, they help assemblers generate a nice
+object with both sizes and types set correctly. For example, the result of
+``arch/x86/lib/putuser.S``::
+
+   Num:    Value          Size Type    Bind   Vis      Ndx Name
+    25: 0000000000000000    33 FUNC    GLOBAL DEFAULT    1 __put_user_1
+    29: 0000000000000030    37 FUNC    GLOBAL DEFAULT    1 __put_user_2
+    32: 0000000000000060    36 FUNC    GLOBAL DEFAULT    1 __put_user_4
+    35: 0000000000000090    37 FUNC    GLOBAL DEFAULT    1 __put_user_8
+
+This is not only important for debugging purposes. When there are properly
+annotated objects like this, tools can be run on them to generate more useful
+information. In particular, on properly annotated objects, ``objtool`` can be
+run to check and fix the object if needed. Currently, ``objtool`` can report
+missing frame pointer setup/destruction in functions. It can also
+automatically generate annotations for :doc:`ORC unwinder <x86/orc-unwinder>`
+for most code. Both of these are especially important to support reliable
+stack traces which are in turn necessary for :doc:`Kernel live patching
+<livepatch/livepatch>`.
+
+Caveat and Discussion
+---------------------
+As one might realize, there were only three macros previously. That is indeed
+insufficient to cover all the combinations of cases:
+
+* standard/non-standard function
+* code/data
+* global/local symbol
+
+There was a discussion_ and instead of extending the current ``ENTRY/END*``
+macros, it was decided that brand new macros should be introduced instead::
+
+    So how about using macro names that actually show the purpose, instead
+    of importing all the crappy, historic, essentially randomly chosen
+    debug symbol macro names from the binutils and older kernels?
+
+.. _discussion: https://lkml.kernel.org/r/20170217104757.28588-1-jslaby@suse.cz
+
+Macros Description
+------------------
+
+The new macros are prefixed with the ``SYM_`` prefix and can be divided into
+three main groups:
+
+1. ``SYM_FUNC_*`` -- to annotate C-like functions. This means functions with
+   standard C calling conventions, i.e. the stack contains a return address at
+   the predefined place and a return from the function can happen in a
+   standard way. When frame pointers are enabled, save/restore of frame
+   pointer shall happen at the start/end of a function, respectively, too.
+
+   Checking tools like ``objtool`` should ensure such marked functions conform
+   to these rules. The tools can also easily annotate these functions with
+   debugging information (like *ORC data*) automatically.
+
+2. ``SYM_CODE_*`` -- special functions called with special stack. Be it
+   interrupt handlers with special stack content, trampolines, or startup
+   functions.
+
+   Checking tools mostly ignore checking of these functions. But some debug
+   information still can be generated automatically. For correct debug data,
+   this code needs hints like ``UNWIND_HINT_REGS`` provided by developers.
+
+3. ``SYM_DATA*`` -- obviously data belonging to ``.data`` sections and not to
+   ``.text``. Data do not contain instructions, so they have to be treated
+   specially by the tools: they should not treat the bytes as instructions,
+   nor assign any debug information to them.
+
+Instruction Macros
+~~~~~~~~~~~~~~~~~~
+This section covers ``SYM_FUNC_*`` and ``SYM_CODE_*`` enumerated above.
+
+* ``SYM_FUNC_START`` and ``SYM_FUNC_START_LOCAL`` are supposed to be **the
+  most frequent markings**. They are used for functions with standard calling
+  conventions -- global and local. Like in C, they both align the functions to
+  architecture specific ``__ALIGN`` bytes. There are also ``_NOALIGN`` variants
+  for special cases where developers do not want this implicit alignment.
+
+  ``SYM_FUNC_START_WEAK`` and ``SYM_FUNC_START_WEAK_NOALIGN`` markings are
+  also offered as an assembler counterpart to the *weak* attribute known from
+  C.
+
+  All of these **shall** be coupled with ``SYM_FUNC_END``. First, it marks
+  the sequence of instructions as a function and computes its size to the
+  generated object file. Second, it also eases checking and processing such
+  object files as the tools can trivially find exact function boundaries.
+
+  So in most cases, developers should write something like in the following
+  example, having some asm instructions in between the macros, of course::
+
+    SYM_FUNC_START(function_hook)
+        ... asm insns ...
+    SYM_FUNC_END(function_hook)
+
+  In fact, this kind of annotation corresponds to the now deprecated ``ENTRY``
+  and ``ENDPROC`` macros.
+
+* ``SYM_FUNC_START_ALIAS`` and ``SYM_FUNC_START_LOCAL_ALIAS`` serve for those
+  who decided to have two or more names for one function. The typical use is::
+
+    SYM_FUNC_START_ALIAS(__memset)
+    SYM_FUNC_START(memset)
+        ... asm insns ...
+    SYM_FUNC_END(memset)
+    SYM_FUNC_END_ALIAS(__memset)
+
+  In this example, one can call ``__memset`` or ``memset`` with the same
+  result, except the debug information for the instructions is generated to
+  the object file only once -- for the non-``ALIAS`` case.
+
+* ``SYM_CODE_START`` and ``SYM_CODE_START_LOCAL`` should be used only in
+  special cases -- if you know what you are doing. This is used exclusively
+  for interrupt handlers and similar where the calling convention is not the C
+  one. ``_NOALIGN`` variants exist too. The use is the same as for the ``FUNC``
+  category above::
+
+    SYM_CODE_START_LOCAL(bad_put_user)
+        ... asm insns ...
+    SYM_CODE_END(bad_put_user)
+
+  Again, every ``SYM_CODE_START*`` **shall** be coupled by ``SYM_CODE_END``.
+
+  To some extent, this category corresponds to deprecated ``ENTRY`` and
+  ``END``. Except ``END`` had several other meanings too.
+
+* ``SYM_INNER_LABEL*`` is used to denote a label inside some
+  ``SYM_{CODE,FUNC}_START`` and ``SYM_{CODE,FUNC}_END``.  They are very similar
+  to C labels, except they can be made global. An example of use::
+
+    SYM_CODE_START(ftrace_caller)
+        /* save_mcount_regs fills in first two parameters */
+        ...
+
+    SYM_INNER_LABEL(ftrace_caller_op_ptr, SYM_L_GLOBAL)
+        /* Load the ftrace_ops into the 3rd parameter */
+        ...
+
+    SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
+        call ftrace_stub
+        ...
+        retq
+    SYM_CODE_END(ftrace_caller)
+
+Data Macros
+~~~~~~~~~~~
+Similar to instructions, there is a couple of macros to describe data in the
+assembly.
+
+* ``SYM_DATA_START`` and ``SYM_DATA_START_LOCAL`` mark the start of some data
+  and shall be used in conjunction with either ``SYM_DATA_END``, or
+  ``SYM_DATA_END_LABEL``. The latter adds also a label to the end, so that
+  people can use ``lstack`` and (local) ``lstack_end`` in the following
+  example::
+
+    SYM_DATA_START_LOCAL(lstack)
+        .skip 4096
+    SYM_DATA_END_LABEL(lstack, SYM_L_LOCAL, lstack_end)
+
+* ``SYM_DATA`` and ``SYM_DATA_LOCAL`` are variants for simple, mostly one-line
+  data::
+
+    SYM_DATA(HEAP,     .long rm_heap)
+    SYM_DATA(heap_end, .long rm_stack)
+
+  In the end, they expand to ``SYM_DATA_START`` with ``SYM_DATA_END``
+  internally.
+
+Support Macros
+~~~~~~~~~~~~~~
+All the above reduce themselves to some invocation of ``SYM_START``,
+``SYM_END``, or ``SYM_ENTRY`` at last. Normally, developers should avoid using
+these.
+
+Further, in the above examples, one could see ``SYM_L_LOCAL``. There are also
+``SYM_L_GLOBAL`` and ``SYM_L_WEAK``. All are intended to denote linkage of a
+symbol marked by them. They are used either in ``_LABEL`` variants of the
+earlier macros, or in ``SYM_START``.
+
+
+Overriding Macros
+~~~~~~~~~~~~~~~~~
+Architecture can also override any of the macros in their own
+``asm/linkage.h``, including macros specifying the type of a symbol
+(``SYM_T_FUNC``, ``SYM_T_OBJECT``, and ``SYM_T_NONE``).  As every macro
+described in this file is surrounded by ``#ifdef`` + ``#endif``, it is enough
+to define the macros differently in the aforementioned architecture-dependent
+header.
diff --git a/Documentation/index.rst b/Documentation/index.rst
index b843e31..2ceab19 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -135,6 +135,14 @@ needed).
    mic/index
    scheduler/index
 
+Architecture-agnostic documentation
+-----------------------------------
+
+.. toctree::
+   :maxdepth: 2
+
+   asm-annotations
+
 Architecture-specific documentation
 -----------------------------------
 
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 14caa9d..e07188e 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -13,9 +13,13 @@
 
 #ifdef __ASSEMBLY__
 
-#define GLOBAL(name)	\
-	.globl name;	\
-	name:
+/*
+ * GLOBAL is DEPRECATED
+ *
+ * use SYM_DATA_START, SYM_FUNC_START, SYM_INNER_LABEL, SYM_CODE_START, or
+ * similar
+ */
+#define GLOBAL(name)	SYM_ENTRY(name, SYM_L_GLOBAL, SYM_A_NONE)
 
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_ALIGNMENT_16)
 #define __ALIGN		.p2align 4, 0x90
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 7e02078..f3ae8f3 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -75,32 +75,58 @@
 
 #ifdef __ASSEMBLY__
 
+/* SYM_T_FUNC -- type used by assembler to mark functions */
+#ifndef SYM_T_FUNC
+#define SYM_T_FUNC				STT_FUNC
+#endif
+
+/* SYM_T_OBJECT -- type used by assembler to mark data */
+#ifndef SYM_T_OBJECT
+#define SYM_T_OBJECT				STT_OBJECT
+#endif
+
+/* SYM_T_NONE -- type used by assembler to mark entries of unknown type */
+#ifndef SYM_T_NONE
+#define SYM_T_NONE				STT_NOTYPE
+#endif
+
+/* SYM_A_* -- align the symbol? */
+#define SYM_A_ALIGN				ALIGN
+#define SYM_A_NONE				/* nothing */
+
+/* SYM_L_* -- linkage of symbols */
+#define SYM_L_GLOBAL(name)			.globl name
+#define SYM_L_WEAK(name)			.weak name
+#define SYM_L_LOCAL(name)			/* nothing */
+
 #ifndef LINKER_SCRIPT
 #define ALIGN __ALIGN
 #define ALIGN_STR __ALIGN_STR
 
+/* === DEPRECATED annotations === */
+
 #ifndef GLOBAL
+/* deprecated, use SYM_DATA*, SYM_ENTRY, or similar */
 #define GLOBAL(name) \
 	.globl name ASM_NL \
 	name:
 #endif
 
 #ifndef ENTRY
+/* deprecated, use SYM_FUNC_START */
 #define ENTRY(name) \
-	.globl name ASM_NL \
-	ALIGN ASM_NL \
-	name:
+	SYM_FUNC_START(name)
 #endif
 #endif /* LINKER_SCRIPT */
 
 #ifndef WEAK
+/* deprecated, use SYM_FUNC_START_WEAK* */
 #define WEAK(name)	   \
-	.weak name ASM_NL   \
-	ALIGN ASM_NL \
-	name:
+	SYM_FUNC_START_WEAK(name)
 #endif
 
 #ifndef END
+/* deprecated, use SYM_FUNC_END, SYM_DATA_END, or SYM_END */
 #define END(name) \
 	.size name, .-name
 #endif
@@ -110,11 +136,214 @@
  * static analysis tools such as stack depth analyzer.
  */
 #ifndef ENDPROC
+/* deprecated, use SYM_FUNC_END */
 #define ENDPROC(name) \
-	.type name, @function ASM_NL \
-	END(name)
+	SYM_FUNC_END(name)
+#endif
+
+/* === generic annotations === */
+
+/* SYM_ENTRY -- use only if you have to for non-paired symbols */
+#ifndef SYM_ENTRY
+#define SYM_ENTRY(name, linkage, align...)		\
+	linkage(name) ASM_NL				\
+	align ASM_NL					\
+	name:
+#endif
+
+/* SYM_START -- use only if you have to */
+#ifndef SYM_START
+#define SYM_START(name, linkage, align...)		\
+	SYM_ENTRY(name, linkage, align)
+#endif
+
+/* SYM_END -- use only if you have to */
+#ifndef SYM_END
+#define SYM_END(name, sym_type)				\
+	.type name sym_type ASM_NL			\
+	.size name, .-name
+#endif
+
+/* === code annotations === */
+
+/*
+ * FUNC -- C-like functions (proper stack frame etc.)
+ * CODE -- non-C code (e.g. irq handlers with different, special stack etc.)
+ *
+ * Objtool validates stack for FUNC, but not for CODE.
+ * Objtool generates debug info for both FUNC & CODE, but needs special
+ * annotations for each CODE's start (to describe the actual stack frame).
+ *
+ * ALIAS -- does not generate debug info -- the aliased function will
+ */
+
+/* SYM_INNER_LABEL_ALIGN -- only for labels in the middle of code */
+#ifndef SYM_INNER_LABEL_ALIGN
+#define SYM_INNER_LABEL_ALIGN(name, linkage)	\
+	.type name SYM_T_NONE ASM_NL			\
+	SYM_ENTRY(name, linkage, SYM_A_ALIGN)
+#endif
+
+/* SYM_INNER_LABEL -- only for labels in the middle of code */
+#ifndef SYM_INNER_LABEL
+#define SYM_INNER_LABEL(name, linkage)		\
+	.type name SYM_T_NONE ASM_NL			\
+	SYM_ENTRY(name, linkage, SYM_A_NONE)
+#endif
+
+/*
+ * SYM_FUNC_START_LOCAL_ALIAS -- use where there are two local names for one
+ * function
+ */
+#ifndef SYM_FUNC_START_LOCAL_ALIAS
+#define SYM_FUNC_START_LOCAL_ALIAS(name)		\
+	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
+#endif
+
+/*
+ * SYM_FUNC_START_ALIAS -- use where there are two global names for one
+ * function
+ */
+#ifndef SYM_FUNC_START_ALIAS
+#define SYM_FUNC_START_ALIAS(name)			\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
+#endif
+
+/* SYM_FUNC_START -- use for global functions */
+#ifndef SYM_FUNC_START
+/*
+ * The same as SYM_FUNC_START_ALIAS, but we will need to distinguish these two
+ * later.
+ */
+#define SYM_FUNC_START(name)				\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
+#endif
+
+/* SYM_FUNC_START_NOALIGN -- use for global functions, w/o alignment */
+#ifndef SYM_FUNC_START_NOALIGN
+#define SYM_FUNC_START_NOALIGN(name)			\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)
+#endif
+
+/* SYM_FUNC_START_LOCAL -- use for local functions */
+#ifndef SYM_FUNC_START_LOCAL
+/* the same as SYM_FUNC_START_LOCAL_ALIAS, see comment near SYM_FUNC_START */
+#define SYM_FUNC_START_LOCAL(name)			\
+	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
 #endif
 
+/* SYM_FUNC_START_LOCAL_NOALIGN -- use for local functions, w/o alignment */
+#ifndef SYM_FUNC_START_LOCAL_NOALIGN
+#define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
+	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)
 #endif
 
+/* SYM_FUNC_START_WEAK -- use for weak functions */
+#ifndef SYM_FUNC_START_WEAK
+#define SYM_FUNC_START_WEAK(name)			\
+	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)
 #endif
+
+/* SYM_FUNC_START_WEAK_NOALIGN -- use for weak functions, w/o alignment */
+#ifndef SYM_FUNC_START_WEAK_NOALIGN
+#define SYM_FUNC_START_WEAK_NOALIGN(name)		\
+	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)
+#endif
+
+/* SYM_FUNC_END_ALIAS -- the end of LOCAL_ALIASed or ALIASed function */
+#ifndef SYM_FUNC_END_ALIAS
+#define SYM_FUNC_END_ALIAS(name)			\
+	SYM_END(name, SYM_T_FUNC)
+#endif
+
+/*
+ * SYM_FUNC_END -- the end of SYM_FUNC_START_LOCAL, SYM_FUNC_START,
+ * SYM_FUNC_START_WEAK, ...
+ */
+#ifndef SYM_FUNC_END
+/* the same as SYM_FUNC_END_ALIAS, see comment near SYM_FUNC_START */
+#define SYM_FUNC_END(name)				\
+	SYM_END(name, SYM_T_FUNC)
+#endif
+
+/* SYM_CODE_START -- use for non-C (special) functions */
+#ifndef SYM_CODE_START
+#define SYM_CODE_START(name)				\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
+#endif
+
+/* SYM_CODE_START_NOALIGN -- use for non-C (special) functions, w/o alignment */
+#ifndef SYM_CODE_START_NOALIGN
+#define SYM_CODE_START_NOALIGN(name)			\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)
+#endif
+
+/* SYM_CODE_START_LOCAL -- use for local non-C (special) functions */
+#ifndef SYM_CODE_START_LOCAL
+#define SYM_CODE_START_LOCAL(name)			\
+	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
+#endif
+
+/*
+ * SYM_CODE_START_LOCAL_NOALIGN -- use for local non-C (special) functions,
+ * w/o alignment
+ */
+#ifndef SYM_CODE_START_LOCAL_NOALIGN
+#define SYM_CODE_START_LOCAL_NOALIGN(name)		\
+	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)
+#endif
+
+/* SYM_CODE_END -- the end of SYM_CODE_START_LOCAL, SYM_CODE_START, ... */
+#ifndef SYM_CODE_END
+#define SYM_CODE_END(name)				\
+	SYM_END(name, SYM_T_NONE)
+#endif
+
+/* === data annotations === */
+
+/* SYM_DATA_START -- global data symbol */
+#ifndef SYM_DATA_START
+#define SYM_DATA_START(name)				\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)
+#endif
+
+/* SYM_DATA_START -- local data symbol */
+#ifndef SYM_DATA_START_LOCAL
+#define SYM_DATA_START_LOCAL(name)			\
+	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)
+#endif
+
+/* SYM_DATA_END -- the end of SYM_DATA_START symbol */
+#ifndef SYM_DATA_END
+#define SYM_DATA_END(name)				\
+	SYM_END(name, SYM_T_OBJECT)
+#endif
+
+/* SYM_DATA_END_LABEL -- the labeled end of SYM_DATA_START symbol */
+#ifndef SYM_DATA_END_LABEL
+#define SYM_DATA_END_LABEL(name, linkage, label)	\
+	linkage(label) ASM_NL				\
+	.type label SYM_T_OBJECT ASM_NL			\
+	label:						\
+	SYM_END(name, SYM_T_OBJECT)
+#endif
+
+/* SYM_DATA -- start+end wrapper around simple global data */
+#ifndef SYM_DATA
+#define SYM_DATA(name, data...)				\
+	SYM_DATA_START(name) ASM_NL				\
+	data ASM_NL						\
+	SYM_DATA_END(name)
+#endif
+
+/* SYM_DATA_LOCAL -- start+end wrapper around simple local data */
+#ifndef SYM_DATA_LOCAL
+#define SYM_DATA_LOCAL(name, data...)			\
+	SYM_DATA_START_LOCAL(name) ASM_NL			\
+	data ASM_NL						\
+	SYM_DATA_END(name)
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _LINUX_LINKAGE_H */
