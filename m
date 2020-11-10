Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373E42ACB17
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 03:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbgKJC3s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Nov 2020 21:29:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52665 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730330AbgKJC3r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Nov 2020 21:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604975385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l6N9kLJEZw00t4oEwyOJU5MOUcho0W3yc7yyLi6tWGo=;
        b=gHoHuVOcUL1RV3SAcLh2OR2oaxIP80efv43jQKwkvXgf5vk2imUZ4OAEuj+c74lYhiJdMr
        XfodFukhrJqmkFz9ar8IuMXOt/a+sg/HzOmAnyMvCZXs18PK5CqU4Hv293sNJcTjNRg7hR
        cB2ko1TFFYE9On6J3eGFlp7KIvBun5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-czCRQyAWP7G68EG9XekIZA-1; Mon, 09 Nov 2020 21:29:41 -0500
X-MC-Unique: czCRQyAWP7G68EG9XekIZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 480E7186841D;
        Tue, 10 Nov 2020 02:29:38 +0000 (UTC)
Received: from treble (ovpn-112-15.rdu2.redhat.com [10.10.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02D1A3C04;
        Tue, 10 Nov 2020 02:29:32 +0000 (UTC)
Date:   Mon, 9 Nov 2020 20:29:24 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 22/25] x86/asm: annotate indirect jumps
Message-ID: <20201110022924.tekltjo25wtrao7z@treble>
References: <CAG48ez2baAvKDA0wfYLKy-KnM_1CdOwjU873VJGDM=CErjsv_A@mail.gmail.com>
 <20201015102216.GB2611@hirez.programming.kicks-ass.net>
 <20201015203942.f3kwcohcwwa6lagd@treble>
 <CABCJKufDLmBCwmgGnfLcBw_B_4U8VY-R-dSNNp86TFfuMobPMw@mail.gmail.com>
 <20201020185217.ilg6w5l7ujau2246@treble>
 <CABCJKucVjFtrOsw58kn4OnW5kdkUh8G7Zs4s6QU9s6O7soRiAA@mail.gmail.com>
 <20201021085606.GZ2628@hirez.programming.kicks-ass.net>
 <CABCJKufL6=FiaeD8T0P+mK4JeR9J80hhjvJ6Z9S-m9UnCESxVA@mail.gmail.com>
 <20201023173617.GA3021099@google.com>
 <CABCJKuee7hUQSiksdRMYNNx05bW7pWaDm4fQ__znGQ99z9-dEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCJKuee7hUQSiksdRMYNNx05bW7pWaDm4fQ__znGQ99z9-dEw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 09, 2020 at 03:11:41PM -0800, Sami Tolvanen wrote:
> On Fri, Oct 23, 2020 at 10:36 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > On Wed, Oct 21, 2020 at 05:22:59PM -0700, Sami Tolvanen wrote:
> > > There are a couple of differences, like the first "undefined stack
> > > state" warning pointing to set_bringup_idt_handler.constprop.0()
> > > instead of __switch_to_asm(). I tried running this with --backtrace,
> > > but objtool segfaults at the first .entry.text warning:
> >
> > Looks like it segfaults when calling BT_FUNC() for an instruction that
> > doesn't have a section (?). Applying this patch allows objtool to finish
> > with --backtrace:
> >
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index c216dd4d662c..618b0c4f2890 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -2604,7 +2604,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
> >                                 ret = validate_branch(file, func,
> >                                                       insn->jump_dest, state);
> >                                 if (ret) {
> > -                                       if (backtrace)
> > +                                       if (backtrace && insn->sec)
> >                                                 BT_FUNC("(branch)", insn);
> >                                         return ret;
> >                                 }
> >
> >
> > Running objtool -barfld on an allyesconfig+LTO vmlinux.o prints out the
> > following, ignoring the crypto warnings for now:
> 
> OK, I spent some time looking at these warnings and the configs needed
> to reproduce them without building allyesconfig:
> 
> CONFIG_XEN
> 
> __switch_to_asm()+0x0: undefined stack state
>   xen_hypercall_set_trap_table()+0x0: <=== (sym)
> 
> CONFIG_XEN_PV
> 
> .entry.text+0xffd: sibling call from callable instruction with
> modified stack frame
>   .entry.text+0xfcb: (branch)
>   .entry.text+0xfb5: (alt)
>   .entry.text+0xfb0: (alt)
>   .entry.text+0xf78: (branch)
>   .entry.text+0x9c: (branch)
>   xen_syscall_target()+0x15: (branch)
>   xen_syscall_target()+0x0: <=== (sym)
> .entry.text+0x1754: unsupported instruction in callable function
>   .entry.text+0x171d: (branch)
>   .entry.text+0x1707: (alt)
>   .entry.text+0x1701: (alt)
>   xen_syscall32_target()+0x15: (branch)
>   xen_syscall32_target()+0x0: <=== (sym)
> .entry.text+0x1634: redundant CLD
> 
> Backtrace doesn’t print out anything useful for the “redundant CLD”
> error, but it occurs when validate_branch is looking at
> xen_sysenter_target.
> 
> do_suspend_lowlevel()+0x116: sibling call from callable instruction
> with modified stack frame
>   do_suspend_lowlevel()+0x9a: (branch)
>   do_suspend_lowlevel()+0x0: <=== (sym)
> 
> .entry.text+0x48: stack state mismatch: cfa1=7-8 cfa2=-1+0
>   .altinstr_replacement+0xffffffffffffffff: (branch)
>   .entry.text+0x21: (alt)
>   .entry.text+0x1c: (alt)
>   .entry.text+0x10: <=== (hint)
> .entry.text+0x15fd: stack state mismatch: cfa1=7-8 cfa2=-1+0
>   .altinstr_replacement+0xffffffffffffffff: (branch)
>   .entry.text+0x15dc: (alt)
>   .entry.text+0x15d7: (alt)
>   .entry.text+0x15d0: <=== (hint)
> .entry.text+0x168c: stack state mismatch: cfa1=7-8 cfa2=-1+0
>   .altinstr_replacement+0xffffffffffffffff: (branch)
>   .entry.text+0x166b: (alt)
>   .entry.text+0x1666: (alt)
>   .entry.text+0x1660: <=== (hint)

I can't make much sense of most of these warnings.  Disassembly would
help.

(Also, something like the patch below should help objtool show more
symbol names.)

> It looks like the stack state mismatch warnings can be fixed by adding
> unwind hints also to entry_SYSCALL_64_after_hwframe,
> entry_SYSENTER_compat_after_hwframe, and
> entry_SYSCALL_compat_after_hwframe. Does that sound correct?

No, those code paths should already have the hints they need, unless I'm
missing something.

> CONFIG_AMD_MEM_ENCRYPT
> 
> .head.text+0xfb: unsupported instruction in callable function
>   .head.text+0x207: (branch)
>   sev_es_play_dead()+0xff: (branch)
>   sev_es_play_dead()+0xd2: (branch)
>   sev_es_play_dead()+0xa8: (alt)
>   sev_es_play_dead()+0x144: (branch)
>   sev_es_play_dead()+0x10b: (branch)
>   sev_es_play_dead()+0x1f: (branch)
>   sev_es_play_dead()+0x0: <=== (sym)
> 
> This happens because sev_es_play_dead calls start_cpu0. It always has,
> but objtool hasn’t been able to follow the call when processing only
> sev-es.o. Any thoughts on the preferred way to fix this one?

Objtool isn't supposed to traverse through call instructions like that.
Is LTO inlining the call or something?

> CONFIG_CRYPTO_CRC32C_INTEL
> 
> __x86_retpoline_rdi()+0x10: return with modified stack frame
>   __x86_retpoline_rdi()+0x0: (branch)
>   .altinstr_replacement+0x147: (branch)
>   .text+0xaf4c7: (alt)
>   .text+0xb03b0: (branch)
>   .text+0xaf482: (branch)
>   crc_pcl()+0x10: (branch)
>   crc_pcl()+0x0: <=== (sym)
> 
> __x86_retpoline_rdi()+0x0: stack state mismatch: cfa1=7+32 cfa2=7+8
>   .altinstr_replacement+0x265: (branch)
>   __x86_indirect_thunk_rdi()+0x0: (alt)
>   __x86_indirect_thunk_rdi()+0x0: <=== (sym)
> 
> This is different from the warnings in the rest of the arch/x86/crypto
> code. Do we need some kind of a hint before the JMP_NOSPEC in crc_pcl?

I'll need to look more into that one.

> CONFIG_FUNCTION_TRACER
> 
> __x86_retpoline_rdi()+0x0: stack state mismatch: cfa1=7+32 cfa2=-1+0
>   .altinstr_replacement+0x111: (branch)
>   .text+0x28a5: (alt)
>   .text+0x2880: <=== (hint)
> 
> This unwind hint is in return_to_handler. Removing it obviously stops
> the warning and doesn’t seem to result in any other complaints from
> objtool. Is this hint correct?

The hint is supposed to be there.  I don't understand this one either.
Did it inline the call to ftrace_return_to_handler()?

> The remaining warnings are all “unsupported stack pointer realignment”
> issues in the crypto code and can be reproduced with the following
> configs:
> 
> CONFIG_CRYPTO_AES_NI_INTEL
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64
> CONFIG_CRYPTO_SHA1_SSSE3
> CONFIG_CRYPTO_SHA256_SSSE3
> CONFIG_CRYPTO_SHA512_SSSE3
> 
> Josh, have you had a chance to look at the crypto patches you mentioned earlier?

I've been traveling for several weeks, but now my work schedule is
getting more normal, so I'll hopefully be able to spend time on this.

How would I recreate all these warnings?

Is it

  https://github.com/samitolvanen/linux.git lto-v6

plus a certain version of clang?

Also, any details on how to build clang would be appreciated, it's been
a while since I tried.


Here's the patch for hopefully making the warnings more helpful:


diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c6ab44543c92..e5f5cb107664 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2432,6 +2432,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 	sec = insn->sec;
 
 	while (1) {
+
+		if (insn->offset == 0x48)
+			WARN_FUNC("yo", sec, insn->offset);
 		next_insn = next_insn_same_sec(file, insn);
 
 		if (file->c_file && func && insn->func && func != insn->func->pfunc) {
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 4e1d7460574b..ced7e4754cba 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -217,6 +217,21 @@ struct symbol *find_func_containing(struct section *sec, unsigned long offset)
 	return NULL;
 }
 
+struct symbol *find_symbol_preceding(struct section *sec, unsigned long offset)
+{
+	struct symbol *sym;
+
+	/*
+	 * This is slow, but used for warning messages.
+	 */
+	while (1) {
+		sym = find_symbol_by_offset(sec, offset);
+		if (sym || !offset)
+			return sym;
+		offset--;
+	}
+}
+
 struct symbol *find_symbol_by_name(const struct elf *elf, const char *name)
 {
 	struct symbol *sym;
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 807f8c670097..841902ed381e 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -136,10 +136,11 @@ struct symbol *find_func_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_name(const struct elf *elf, const char *name);
 struct symbol *find_symbol_containing(const struct section *sec, unsigned long offset);
+struct symbol *find_func_containing(struct section *sec, unsigned long offset);
+struct symbol *find_symbol_preceding(struct section *sec, unsigned long offset);
 struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, unsigned long offset);
 struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len);
-struct symbol *find_func_containing(struct section *sec, unsigned long offset);
 int elf_rebuild_reloc_section(struct elf *elf, struct section *sec);
 
 #define for_each_sec(file, sec)						\
diff --git a/tools/objtool/warn.h b/tools/objtool/warn.h
index 7799f60de80a..33da0f2ed9d5 100644
--- a/tools/objtool/warn.h
+++ b/tools/objtool/warn.h
@@ -22,6 +22,8 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 	unsigned long name_off;
 
 	func = find_func_containing(sec, offset);
+	if (!func)
+		func = find_symbol_preceding(sec, offset);
 	if (func) {
 		name = func->name;
 		name_off = offset - func->offset;

