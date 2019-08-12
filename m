Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4E58A3F8
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2019 19:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfHLRGJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Aug 2019 13:06:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39836 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfHLRGJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Aug 2019 13:06:09 -0400
Received: from zn.tnic (p200300EC2F062700282A196283E22A0A.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:2700:282a:1962:83e2:2a0a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 18ECF1EC0554;
        Mon, 12 Aug 2019 19:06:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565629567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cT0NYAqU7+08mxXX66pYKJNKSpkrmqNv5IFdSC1mdDQ=;
        b=iYyDMxZnmVlaFHG7/6oQyZqtaYiKddiaJmS1fqzci3g/qm1EINn2lXJTBm+yPUnjQjLtML
        0E73p5JkenpLxR6ePxhVFYnb9xD7LwvRB2pn1z+lVDXvig5tjBYNgnzACyMpHJIvF9nsCH
        VMiMi3SoN8NOcfo2BYfE2b7UjXTOrzw=
Date:   Mon, 12 Aug 2019 19:06:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v8 01/28] linkage: new macros for assembler symbols
Message-ID: <20190812170652.GJ23772@zn.tnic>
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-2-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190808103854.6192-2-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

this time a more detailed look. :)

> Subject: Re: [PATCH v8 01/28] linkage: new macros for assembler symbols

Patch subject needs a verb, like, for example:

"linkage: Introduce new macros for assembler symbols"

On Thu, Aug 08, 2019 at 12:38:27PM +0200, Jiri Slaby wrote:
> Introduce new C macros for annotations of functions and data in
> assembly. There is a long-standing mess in macros like ENTRY, END,
> ENDPROC and similar. They are used in different manners and sometimes
> incorrectly.
> 
> So introduce macros with clear use to annotate assembly as follows:
> 
> a) Support macros for the ones below
>    SYM_T_FUNC -- type used by assembler to mark functions
>    SYM_T_OBJECT -- type used by assembler to mark data
>    SYM_T_NONE -- type used by assembler to mark entries of unknown type
> 
>    They are defined as STT_FUNC, STT_OBJECT, and STT_NOTYPE
>    respectively. According to the gas manual, this is the most portable
>    way. I am not sure about other assemblers, so we can switch this back
>    to %function and %object if this turns into a problem. Architectures
>    can also override them by something like ", @function" if they need.
> 
>    SYM_A_ALIGN, SYM_A_NONE -- align the symbol?
>    SYM_L_GLOBAL, SYM_L_WEAK, SYM_L_LOCAL -- linkage of symbols
> 
> b) Mostly internal annotations, used by the ones below
>    SYM_ENTRY -- use only if you have to (for non-paired symbols)
>    SYM_START -- use only if you have to (for paired symbols)
>    SYM_END -- use only if you have to (for paired symbols)
> 
> c) Annotations for code
>    SYM_INNER_LABEL_ALIGN -- only for labels in the middle of code
>    SYM_INNER_LABEL -- only for labels in the middle of code
> 
>    SYM_FUNC_START_LOCAL_ALIAS -- use where there are two local names for
> 	one function
>    SYM_FUNC_START_ALIAS -- use where there are two global names for one
> 	function
>    SYM_FUNC_END_ALIAS -- the end of LOCAL_ALIASed or ALIASed function
> 
>    SYM_FUNC_START -- use for global functions
>    SYM_FUNC_START_NOALIGN -- use for global functions, w/o alignment
>    SYM_FUNC_START_LOCAL -- use for local functions
>    SYM_FUNC_START_LOCAL_NOALIGN -- use for local functions, w/o
> 	alignment
>    SYM_FUNC_START_WEAK -- use for weak functions
>    SYM_FUNC_START_WEAK_NOALIGN -- use for weak functions, w/o alignment
>    SYM_FUNC_END -- the end of SYM_FUNC_START_LOCAL, SYM_FUNC_START,
> 	SYM_FUNC_START_WEAK, ...
> 
>    For functions with special (non-C) calling conventions:
>    SYM_CODE_START -- use for non-C (special) functions
>    SYM_CODE_START_NOALIGN -- use for non-C (special) functions, w/o
> 	alignment
>    SYM_CODE_START_LOCAL -- use for local non-C (special) functions
>    SYM_CODE_START_LOCAL_NOALIGN -- use for local non-C (special)
> 	functions, w/o alignment
>    SYM_CODE_END -- the end of SYM_CODE_START_LOCAL or SYM_CODE_START
> 
> d) For data
>    SYM_DATA_START -- global data symbol
>    SYM_DATA_START_LOCAL -- local data symbol
>    SYM_DATA_END -- the end of the SYM_DATA_START symbol
>    SYM_DATA_END_LABEL -- the labeled end of SYM_DATA_START symbol
>    SYM_DATA -- start+end wrapper around simple global data
>    SYM_DATA_LOCAL -- start+end wrapper around simple local data
> 
> ==========
> 
> The macros allow to pair starts and ends of functions and mark functions
> correctly in the output ELF objects.
> 
> All users of the old macros in x86 are converted to use these in further
> patches.
> 
> [v2]
> * use SYM_ prefix and sane names
> * add SYM_START and SYM_END and parametrize all the macros
> 
> [v3]
> * add SYM_DATA, SYM_DATA_LOCAL, and SYM_DATA_END_LABEL
> 
> [v4]
> * add _NOALIGN versions of some macros
> * add _CODE_ derivates of _FUNC_ macros
> 
> [v5]
> * drop "SIMPLE" from data annotations
> * switch NOALIGN and ALIGN variants of inner labels
> * s/visibility/linkage/; s@SYM_V_@SYM_L_@
> * add Documentation
> 
> [v6]
> * fixed typos found by Randy Dunlap
> * remove doubled INNER_LABEL macros, one pair was unused
> 
> [v8]
> * use lkml.kernel.org for links
> * link the docs from index.rst (by bpetkov)
> * fixed typos on the docs

Patch version history which doesn't belong in the commit message goes...

> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: hpa@zytor.com
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: jpoimboe@redhat.com
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: mingo@redhat.com
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: xen-devel@lists.xenproject.org
> Cc: x86@kernel.org
> ---

... here, under the "---" so that git can ignore it when applying.

>  Documentation/asm-annotations.rst | 217 ++++++++++++++++++++++++++
>  Documentation/index.rst           |   8 +
>  arch/x86/include/asm/linkage.h    |  10 +-
>  include/linux/linkage.h           | 245 +++++++++++++++++++++++++++++-
>  4 files changed, 469 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/asm-annotations.rst
> 
> diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
> new file mode 100644
> index 000000000000..a967648e4325
> --- /dev/null
> +++ b/Documentation/asm-annotations.rst
> @@ -0,0 +1,217 @@
> +Assembler Annotations
> +=====================
> +
> +Copyright (c) 2017-2019 Jiri Slaby
> +
> +This document describes the new macros for annotation of data and code in
> +assembly. In particular, it contains information about ``SYM_FUNC_START``,
> +``SYM_FUNC_END``, ``SYM_CODE_START``, and similar.
> +
> +Rationale
> +---------
> +Some code like entries, trampolines, or boot code needs to be written in
> +assembly. The same as in C, we group such code into functions and accompany

"we" is? Make this passive: "... such code is grouped into... "

> +them with data. Standard assemblers do not force users into precisely marking
> +these pieces as code, data, or even specifying their length. Nevertheless,
> +assemblers provide developers with such marks to aid debuggers throughout

s/marks/annotations/

> +assembly. On the top of that, developers also want to stamp some functions as

On top of that, ...

s/stamp/mark/

> +*global* to be visible outside of their translation units.

s/to be visible/in order to be visible/

> +
> +Over time, the Linux kernel took over macros from various projects (like

s/took over/has adopted/

> +``binutils``) to ease these markings.

s/ease these markings/facilitate such annotations/

> So for historic reasons, we have been

s/we have been/people have been/

> +using ``ENTRY``, ``END``, ``ENDPROC``, and other annotations in assembly. Due
> +to the lack of their documentation, the macros are used in rather wrong
> +contexts at some locations. Clearly, ``ENTRY`` was intended for starts of
> +global symbols (be it data or code).

s/for starts of global symbols/to denote the beginning of global symbols/

> ``END`` used to be the end of data or end

s/used to be/used to mark/

> +of special functions with *non-standard* calling convention. In contrast,
> +``ENDPROC`` should annotate only ends of *standard* functions.
> +
> +When these macros are used correctly, they help assemblers to generate a nice

s/to //

> +object with both sizes and types set correctly. For example the result of

comma: For example, the result of...

> +``arch/x86/lib/putuser.S``::
> +
> +   Num:    Value          Size Type    Bind   Vis      Ndx Name
> +    25: 0000000000000000    33 FUNC    GLOBAL DEFAULT    1 __put_user_1
> +    29: 0000000000000030    37 FUNC    GLOBAL DEFAULT    1 __put_user_2
> +    32: 0000000000000060    36 FUNC    GLOBAL DEFAULT    1 __put_user_4
> +    35: 0000000000000090    37 FUNC    GLOBAL DEFAULT    1 __put_user_8
> +
> +This is not only important for debugging purposes. When we have properly
> +marked objects like this, we can run tools on them and let the tools generate
> +more useful information. In particular, on properly marked objects, we can run
> +``objtool`` and let it check and fix the object if needed.

Passive formulation pls, i.e., get rid of the "we". Pls check and fix
the whole text.

> Currently, it can
> +report missing frame pointer setup/destruction in functions. It can also
> +automatically generate annotations for *ORC unwinder* (cf.
> +<Documentation/x86/orc-unwinder.txt>) for most code. Both of these are
> +especially important to support reliable stack traces which are in turn
> +necessary for *Kernel live patching* (see
> +<Documentation/livepatch/livepatch.txt>).
> +
> +Caveat and Discussion
> +---------------------
> +As one might realize, there were only three macros previously. That is indeed
> +insufficient to cover all the combinations of cases:
> +
> +* standard/non-standard function
> +* code/data
> +* global/local symbol
> +
> +We had a discussion_ and instead of extending the current ``ENTRY/END*``
> +macros, it was decided that we should introduce brand new macros instead::
> +
> +    So how about using macro names that actually show the purpose, instead
> +    of importing all the crappy, historic, essentially randomly chosen
> +    debug symbol macro names from the binutils and older kernels?
> +
> +.. _discussion: https://lkml.kernel.org/r/20170217104757.28588-1-jslaby@suse.cz
> +
> +Macros Description
> +------------------
> +
> +The new macros are prefixed with the ``SYM_`` prefix and can be divided into
> +three main groups:
> +
> +1. ``SYM_FUNC_*`` -- to annotate C-like functions. This means functions with
> +   standard C calling conventions, i.e. the stack contains a return address at
> +   the predefined place and a return from the function can happen in a
> +   standard way. When frame pointers are enabled, save/restore of frame
> +   pointer shall happen at the start/end of a function, respectively, too.
> +
> +   Checking tools like ``objtool`` should ensure such marked functions conform
> +   to these rules. The tools can also easily annotate these functions with
> +   debugging information (like *ORC data*) automatically.
> +
> +2. ``SYM_CODE_*`` -- special functions called with special stack. Be it
> +   interrupt handlers with special stack content, trampolines, or startup
> +   functions.
> +
> +   Checking tools mostly ignore checking of these functions. But some debug
> +   information still can be generated automatically. For correct debug data,
> +   this code needs hints like ``UNWIND_HINT_REGS`` provided by developers.
> +
> +3. ``SYM_DATA*`` -- obviously data belonging to ``.data`` sections and not to
> +   ``.text``. Data do not contain instructions, so they have to be treated
> +   specially by the tools: they should not treat the bytes as instructions,
> +   nor assign any debug information to them.
> +
> +Instruction Macros
> +~~~~~~~~~~~~~~~~~~
> +This section covers ``SYM_FUNC_*`` and ``SYM_CODE_*`` enumerated above.
> +
> +* ``SYM_FUNC_START`` and ``SYM_FUNC_START_LOCAL`` are supposed to be **the
> +  most frequent markings**. They are used for functions with standard calling
> +  conventions -- global and local. Like in C, they both align the functions to
> +  architecture specific ``__ALIGN`` bytes. There are also ``_NOALIGN`` variants
> +  for special cases where developers do not want this implicit alignment.
> +
> +  We offer also ``SYM_FUNC_START_WEAK`` and ``SYM_FUNC_START_WEAK_NOALIGN``
> +  marks as an assembler counterpart of the *weak* attribute known from C.

s/marks/markings/

			... counterpart to the *weak*...

> +
> +  All of these **shall** be coupled with ``SYM_FUNC_END``. First, it marks
> +  the sequence of instructions as a function and computes its size to the
> +  generated object file. Second, it also eases checking and processing such
> +  object files as the tools can trivially find exact start and end of a
> +  function.

I'd change that to "... find exact function boundaries."

> +
> +  So in most cases, developers should write something like in the following
> +  example, having more instructions in between the macros, of course::
> +
> +    SYM_FUNC_START(function_hook)
> +        retq
> +    SYM_FUNC_END(function_hook)

Just use "...asm insns ..." in there so that you don't have to say
"having more instructions in between the macros, of course":

	SYM_FUNC_START(function_hook)
		... asm insns ...
	SYM_FUNC_END(function_hook)


> +  In fact, this kind of annotation corresponds to now deprecated ``ENTRY`` and
> +  ``ENDPROC``.

"... corresponds to the now deprecated ``ENTRY`` and ``ENDPROC`` macros."

> +
> +* ``SYM_FUNC_START_ALIAS`` and ``SYM_FUNC_START_LOCAL_ALIAS`` serve for those
> +  who decided to have two or more names for one function. The typical use is::
> +
> +    SYM_FUNC_START_ALIAS(__memset)
> +    SYM_FUNC_START(memset)
> +        ...
> +    SYM_FUNC_END(memset)
> +    SYM_FUNC_END_ALIAS(__memset)
> +
> +  In this example, one can call ``__memset`` or ``memset`` with the same
> +  result. Except the debug information for the instructions is generated to
> +  the object file only once -- for the non-``ALIAS`` case.

One sentence:

"... with the same result, except for the debugging information which is
generated in the object file only once - for the non-aliasing function."

> +
> +* ``SYM_CODE_START`` and ``SYM_CODE_START_LOCAL`` should be used only in
> +  special cases -- if you know what you are doing. This is used exclusively
> +  for interrupt handlers and similar where the calling convention is not the C
> +  one. ``_NOALIGN`` variants exist too. The use is the same as for the ``FUNC``
> +  category above::
> +
> +    SYM_CODE_START_LOCAL(bad_put_user)
> +        movl $-EFAULT,%eax
> +        EXIT

	... asm insns ...

> +    SYM_CODE_END(bad_put_user)
> +
> +  Again, every ``SYM_CODE_START*`` **shall** be coupled by ``SYM_CODE_END``.

Btw, this coupling: I haven't gone through the whole patchset but do we
have automatic checking which makes sure a starting macro is coupled
with the correct ending macro?

> +
> +  To some extent, this category corresponds to deprecated ``ENTRY`` and
> +  ``END``. Except ``END`` had several other meanings too.
> +
> +* ``SYM_INNER_LABEL*`` is used to denote a label inside some
> +  ``SYM_{CODE,FUNC}_START`` and ``SYM_{CODE,FUNC}_END``.  They are very similar
> +  to C labels, except they can be made global. An example of use::
> +
> +    SYM_CODE_START(ftrace_caller)
> +        /* save_mcount_regs fills in first two parameters */
> +        ...
> +
> +    SYM_INNER_LABEL(ftrace_caller_op_ptr, SYM_L_GLOBAL)
> +        /* Load the ftrace_ops into the 3rd parameter */
> +        ...
> +
> +    SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
> +        call ftrace_stub
> +        ...
> +        retq
> +    SYM_CODE_END(ftrace_caller)
> +
> +Data Macros
> +~~~~~~~~~~~
> +Similar to instructions, we have a couple of macros to describe data in the
> +assembly.

> Again, they help debuggers to understand the layout of the resulting
> +object files.

No need for that sentence - I think it is clear by now what they're for.
:-)

> +
> +* ``SYM_DATA_START`` and ``SYM_DATA_START_LOCAL`` mark the start of some data
> +  and shall be used in conjunction with either ``SYM_DATA_END``, or
> +  ``SYM_DATA_END_LABEL``. The latter adds also a label to the end, so that
> +  people can use ``lstack`` and (local) ``lstack_end`` in the following
> +  example::
> +
> +    SYM_DATA_START_LOCAL(lstack)
> +        .skip 4096
> +    SYM_DATA_END_LABEL(lstack, SYM_L_LOCAL, lstack_end)
> +
> +* ``SYM_DATA`` and ``SYM_DATA_LOCAL`` are variants for simple, mostly one-line
> +  data::
> +
> +    SYM_DATA(HEAP,     .long rm_heap)
> +    SYM_DATA(heap_end, .long rm_stack)
> +
> +  In the end, they expand to ``SYM_DATA_START`` with ``SYM_DATA_END``
> +  internally.
> +
> +Support Macros
> +~~~~~~~~~~~~~~
> +All the above reduce themselves to some invocation of ``SYM_START``,
> +``SYM_END``, or ``SYM_ENTRY`` at last. Normally, developers should avoid using
> +these.
> +
> +Further, in the above examples, one could see ``SYM_L_LOCAL``. There are also
> +``SYM_L_GLOBAL`` and ``SYM_L_WEAK``. All are intended to denote linkage of a
> +symbol marked by them. They are used either in ``_LABEL`` variants of the
> +earlier macros, or in ``SYM_START``.
> +
> +
> +Overriding Macros
> +~~~~~~~~~~~~~~~~~
> +Architecture can also override any of the macros in their own

"Other architectures... "

> +``asm/linkage.h``, including macros specifying the type of a symbol
> +(``SYM_T_FUNC``, ``SYM_T_OBJECT``, and ``SYM_T_NONE``).  As every macro
> +described in this file is surrounded by ``#ifdef`` + ``#endif``, it is enough
> +to define the macros differently in the aforementioned architecture-dependent
> +header.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
