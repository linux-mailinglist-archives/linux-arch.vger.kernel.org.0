Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635FF85FF6
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 12:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbfHHKi7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 06:38:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:47366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732107AbfHHKi7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 06:38:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65BDFAE48;
        Thu,  8 Aug 2019 10:38:57 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@kernel.org>, jpoimboe@redhat.com,
        Juergen Gross <jgross@suse.com>,
        Len Brown <len.brown@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        xen-devel@lists.xenproject.org
Subject: [PATCH v8 01/28] linkage: new macros for assembler symbols
Date:   Thu,  8 Aug 2019 12:38:27 +0200
Message-Id: <20190808103854.6192-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808103854.6192-1-jslaby@suse.cz>
References: <20190808103854.6192-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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
   way. I am not sure about other assemblers, so we can switch this back
   to %function and %object if this turns into a problem. Architectures
   can also override them by something like ", @function" if they need.

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

[v2]
* use SYM_ prefix and sane names
* add SYM_START and SYM_END and parametrize all the macros

[v3]
* add SYM_DATA, SYM_DATA_LOCAL, and SYM_DATA_END_LABEL

[v4]
* add _NOALIGN versions of some macros
* add _CODE_ derivates of _FUNC_ macros

[v5]
* drop "SIMPLE" from data annotations
* switch NOALIGN and ALIGN variants of inner labels
* s/visibility/linkage/; s@SYM_V_@SYM_L_@
* add Documentation

[v6]
* fixed typos found by Randy Dunlap
* remove doubled INNER_LABEL macros, one pair was unused

[v8]
* use lkml.kernel.org for links
* link the docs from index.rst (by bpetkov)
* fixed typos on the docs

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: hpa@zytor.com
Cc: Ingo Molnar <mingo@kernel.org>
Cc: jpoimboe@redhat.com
Cc: Juergen Gross <jgross@suse.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: mingo@redhat.com
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org
Cc: x86@kernel.org
---
 Documentation/asm-annotations.rst | 217 ++++++++++++++++++++++++++
 Documentation/index.rst           |   8 +
 arch/x86/include/asm/linkage.h    |  10 +-
 include/linux/linkage.h           | 245 +++++++++++++++++++++++++++++-
 4 files changed, 469 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/asm-annotations.rst

diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
new file mode 100644
index 000000000000..a967648e4325
--- /dev/null
+++ b/Documentation/asm-annotations.rst
@@ -0,0 +1,217 @@
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
+assembly. The same as in C, we group such code into functions and accompany
+them with data. Standard assemblers do not force users into precisely marking
+these pieces as code, data, or even specifying their length. Nevertheless,
+assemblers provide developers with such marks to aid debuggers throughout
+assembly. On the top of that, developers also want to stamp some functions as
+*global* to be visible outside of their translation units.
+
+Over time, the Linux kernel took over macros from various projects (like
+``binutils``) to ease these markings. So for historic reasons, we have been
+using ``ENTRY``, ``END``, ``ENDPROC``, and other annotations in assembly. Due
+to the lack of their documentation, the macros are used in rather wrong
+contexts at some locations. Clearly, ``ENTRY`` was intended for starts of
+global symbols (be it data or code). ``END`` used to be the end of data or end
+of special functions with *non-standard* calling convention. In contrast,
+``ENDPROC`` should annotate only ends of *standard* functions.
+
+When these macros are used correctly, they help assemblers to generate a nice
+object with both sizes and types set correctly. For example the result of
+``arch/x86/lib/putuser.S``::
+
+   Num:    Value          Size Type    Bind   Vis      Ndx Name
+    25: 0000000000000000    33 FUNC    GLOBAL DEFAULT    1 __put_user_1
+    29: 0000000000000030    37 FUNC    GLOBAL DEFAULT    1 __put_user_2
+    32: 0000000000000060    36 FUNC    GLOBAL DEFAULT    1 __put_user_4
+    35: 0000000000000090    37 FUNC    GLOBAL DEFAULT    1 __put_user_8
+
+This is not only important for debugging purposes. When we have properly
+marked objects like this, we can run tools on them and let the tools generate
+more useful information. In particular, on properly marked objects, we can run
+``objtool`` and let it check and fix the object if needed. Currently, it can
+report missing frame pointer setup/destruction in functions. It can also
+automatically generate annotations for *ORC unwinder* (cf.
+<Documentation/x86/orc-unwinder.txt>) for most code. Both of these are
+especially important to support reliable stack traces which are in turn
+necessary for *Kernel live patching* (see
+<Documentation/livepatch/livepatch.txt>).
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
+We had a discussion_ and instead of extending the current ``ENTRY/END*``
+macros, it was decided that we should introduce brand new macros instead::
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
+  We offer also ``SYM_FUNC_START_WEAK`` and ``SYM_FUNC_START_WEAK_NOALIGN``
+  marks as an assembler counterpart of the *weak* attribute known from C.
+
+  All of these **shall** be coupled with ``SYM_FUNC_END``. First, it marks
+  the sequence of instructions as a function and computes its size to the
+  generated object file. Second, it also eases checking and processing such
+  object files as the tools can trivially find exact start and end of a
+  function.
+
+  So in most cases, developers should write something like in the following
+  example, having more instructions in between the macros, of course::
+
+    SYM_FUNC_START(function_hook)
+        retq
+    SYM_FUNC_END(function_hook)
+
+  In fact, this kind of annotation corresponds to now deprecated ``ENTRY`` and
+  ``ENDPROC``.
+
+* ``SYM_FUNC_START_ALIAS`` and ``SYM_FUNC_START_LOCAL_ALIAS`` serve for those
+  who decided to have two or more names for one function. The typical use is::
+
+    SYM_FUNC_START_ALIAS(__memset)
+    SYM_FUNC_START(memset)
+        ...
+    SYM_FUNC_END(memset)
+    SYM_FUNC_END_ALIAS(__memset)
+
+  In this example, one can call ``__memset`` or ``memset`` with the same
+  result. Except the debug information for the instructions is generated to
+  the object file only once -- for the non-``ALIAS`` case.
+
+* ``SYM_CODE_START`` and ``SYM_CODE_START_LOCAL`` should be used only in
+  special cases -- if you know what you are doing. This is used exclusively
+  for interrupt handlers and similar where the calling convention is not the C
+  one. ``_NOALIGN`` variants exist too. The use is the same as for the ``FUNC``
+  category above::
+
+    SYM_CODE_START_LOCAL(bad_put_user)
+        movl $-EFAULT,%eax
+        EXIT
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
+Similar to instructions, we have a couple of macros to describe data in the
+assembly. Again, they help debuggers to understand the layout of the resulting
+object files.
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
index 0a564f3c336e..40962000f915 100644
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
index 14caa9d9fb7f..e07188e8d763 100644
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
index 7e020782ade2..f3ae8f3dea2c 100644
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
-- 
2.22.0

