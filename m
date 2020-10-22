Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237C9295572
	for <lists+linux-arch@lfdr.de>; Thu, 22 Oct 2020 02:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507407AbgJVAXM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 20:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507222AbgJVAXM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Oct 2020 20:23:12 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467FBC0613D4
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2020 17:23:12 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o26so5783444ejc.8
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2020 17:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p8Hwn4AXDi9NRjlCE0oMq1jAIKpEQWx4gCW/kuHDlnE=;
        b=CNB4qwF8XdN3RdM9KJnNC7kYAWqE3MUa239/vjNlnFSdgbAxXNDSsHdvaAwxfoPYCf
         9I5uTsOXqOSvDFVdPGNB9kuPiLcCYP+jICpfkw/SnOdN0UwneoOuRjcJRVYvzghyOZgY
         XvPIaPv94GmuiwvhuOy99hxIOxFWyWcpXlhs/vEB8KesGnOR/boJ2sI/4woeV6i/72q/
         p2uHWfix+2KfdBMVPBrl7fsMQncBxq0mhjoTIYiPInfd1v8q11VRdJI0fils5s9SxrwC
         md6xgXZxNLh51IWZJpdkb57XW+oG+EDxRaAKOL98VAQ3pysJjVwuexGYN8bLRDJoVH0/
         WSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8Hwn4AXDi9NRjlCE0oMq1jAIKpEQWx4gCW/kuHDlnE=;
        b=gw8dPUNjZ5QeLt+9SZ2NCVHULSs8L0aV68A4D6hox1ARtUZgDbLIeh40mjzueGNa4u
         EE7XcphrQBuIxLm2lvH43gKbssSuzWKOGUgIeZA5Wefy9UYKaI0MtunYHB1myXdmGbkA
         nJ/ws6pgTIcF37E4aKjWCPeitUEThv5w0MYeBfOvutiYrvXGunz7sp4oag+yewlWb/dz
         BM41eAiyn7gNMGyZgSApDkkeNSmTIss6oiz9VwIvgNnfR9EQ309GbUZ8uePQOl2NY/Xb
         5tyrRZqJkSUKGn3yX5DzYgxfMwrxE2QXbWlNYh7/eWN595puTaZgdpvRnbL/INiF2ed2
         5Dxw==
X-Gm-Message-State: AOAM5322Ed4W+HQew9tmup/VyE6A2Q/Ulb251JHwnUTpYk26jrwUJZXx
        WxNOn/Ww5gndZuByrGTNEvo5enghxiHl4SzOQw1U1A==
X-Google-Smtp-Source: ABdhPJzLM1aM6spRLX8pXe/S9QIy6/o0GCiMeSkYufHnU7EzHfprw/1bO/qSLNeYe+3BVe+LcpDtiqX5V8eEHvsaeCo=
X-Received: by 2002:a17:906:490d:: with SMTP id b13mr5925764ejq.122.1603326190426;
 Wed, 21 Oct 2020 17:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-23-samitolvanen@google.com> <CAG48ez2baAvKDA0wfYLKy-KnM_1CdOwjU873VJGDM=CErjsv_A@mail.gmail.com>
 <20201015102216.GB2611@hirez.programming.kicks-ass.net> <20201015203942.f3kwcohcwwa6lagd@treble>
 <CABCJKufDLmBCwmgGnfLcBw_B_4U8VY-R-dSNNp86TFfuMobPMw@mail.gmail.com>
 <20201020185217.ilg6w5l7ujau2246@treble> <CABCJKucVjFtrOsw58kn4OnW5kdkUh8G7Zs4s6QU9s6O7soRiAA@mail.gmail.com>
 <20201021085606.GZ2628@hirez.programming.kicks-ass.net>
In-Reply-To: <20201021085606.GZ2628@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 21 Oct 2020 17:22:59 -0700
Message-ID: <CABCJKufL6=FiaeD8T0P+mK4JeR9J80hhjvJ6Z9S-m9UnCESxVA@mail.gmail.com>
Subject: Re: [PATCH v6 22/25] x86/asm: annotate indirect jumps
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 1:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 20, 2020 at 12:24:37PM -0700, Sami Tolvanen wrote:
> > > > Building allyesconfig with this series and LTO enabled, I still see
> > > > the following objtool warnings for vmlinux.o, grouped by source file:
> > > >
> > > > arch/x86/entry/entry_64.S:
> > > > __switch_to_asm()+0x0: undefined stack state
> > > > .entry.text+0xffd: sibling call from callable instruction with
> > > > modified stack frame
> > > > .entry.text+0x48: stack state mismatch: cfa1=7-8 cfa2=-1+0
> > >
> > > Not sure what this one's about, there's no OBJECT_FILES_NON_STANDARD?
> >
> > Correct, because with LTO, we won't have an ELF binary to process
> > until we compile everything into vmlinux.o, and at that point we can
> > no longer skip individual object files.
>
> I think what Josh was trying to say is; this file is subject to objtool
> on a normal build and does not generate warnings. So why would it
> generate warnings when subject to objtool as result of a vmlinux run
> (due to LTO or otherwise).
>
> In fact, when I build a x86_64-defconfig and then run:
>
>   $ objtool check -barf defconfig-build/vmlinux.o

Note that I'm passing also --vmlinux and --duplicate to objtool when
processing vmlinux.o, and this series has a patch to split noinstr
validation from --vmlinux, so that's skipped.

> I do not see these in particular, although I do see a lot of:
>
>   "sibling call from callable instruction with modified stack frame"
>   "falls through to next function"
>
> that did not show up in the individual objtool runs during the build.

I'm able to reproduce these warnings with gcc 9.3 + allyesconfig, with
KASAN and GCOV_KERNEL disabled, as they are not enabled in LTO builds
either. This is without the LTO series applied, so we also have the
retpoline warnings:

$ ./tools/objtool/objtool check -arfld vmlinux.o 2>&1 | grep -vE
'(sibling|instr)'
vmlinux.o: warning: objtool: wakeup_long64()+0x61: indirect jump found
in RETPOLINE build
vmlinux.o: warning: objtool: .text+0x826308a: indirect jump found in
RETPOLINE build
vmlinux.o: warning: objtool: .text+0x82630c5: indirect jump found in
RETPOLINE build
vmlinux.o: warning: objtool: .head.text+0x748: indirect jump found in
RETPOLINE build
vmlinux.o: warning: objtool:
set_bringup_idt_handler.constprop.0()+0x0: undefined stack state
vmlinux.o: warning: objtool: .entry.text+0x1634: redundant CLD
vmlinux.o: warning: objtool: camellia_cbc_dec_32way()+0xb3: stack
state mismatch: cfa1=7+520 cfa2=7+8
vmlinux.o: warning: objtool: camellia_ctr_32way()+0x1a: stack state
mismatch: cfa1=7+520 cfa2=7+8
vmlinux.o: warning: objtool: aesni_gcm_init_avx_gen2()+0x12:
unsupported stack pointer realignment
vmlinux.o: warning: objtool: aesni_gcm_enc_update_avx_gen2()+0x12:
unsupported stack pointer realignment
vmlinux.o: warning: objtool: aesni_gcm_dec_update_avx_gen2()+0x12:
unsupported stack pointer realignment
vmlinux.o: warning: objtool: aesni_gcm_finalize_avx_gen2()+0x12:
unsupported stack pointer realignment
vmlinux.o: warning: objtool: aesni_gcm_init_avx_gen4()+0x12:
unsupported stack pointer realignment
vmlinux.o: warning: objtool: aesni_gcm_enc_update_avx_gen4()+0x12:
unsupported stack pointer realignment
vmlinux.o: warning: objtool: aesni_gcm_dec_update_avx_gen4()+0x12:
unsupported stack pointer realignment
vmlinux.o: warning: objtool: aesni_gcm_finalize_avx_gen4()+0x12:
unsupported stack pointer realignment
vmlinux.o: warning: objtool: sha1_transform_avx2()+0xc: unsupported
stack pointer realignment
vmlinux.o: warning: objtool: sha1_ni_transform()+0x7: unsupported
stack pointer realignment
vmlinux.o: warning: objtool: sha256_transform_rorx()+0x13: unsupported
stack pointer realignment
vmlinux.o: warning: objtool: sha512_transform_ssse3()+0x14:
unsupported stack pointer realignment
vmlinux.o: warning: objtool: sha512_transform_avx()+0x14: unsupported
stack pointer realignment
vmlinux.o: warning: objtool: sha512_transform_rorx()+0x7: unsupported
stack pointer realignment
vmlinux.o: warning: objtool: __x86_retpoline_rdi()+0x10: return with
modified stack frame
vmlinux.o: warning: objtool: __x86_retpoline_rdi()+0x0: stack state
mismatch: cfa1=7+32 cfa2=7+8
vmlinux.o: warning: objtool: __x86_retpoline_rdi()+0x0: stack state
mismatch: cfa1=7+32 cfa2=-1+0
vmlinux.o: warning: objtool: reset_early_page_tables()+0x0: stack
state mismatch: cfa1=7+8 cfa2=-1+0
vmlinux.o: warning: objtool: .entry.text+0x48: stack state mismatch:
cfa1=7-8 cfa2=-1+0
vmlinux.o: warning: objtool: .entry.text+0x15fd: stack state mismatch:
cfa1=7-8 cfa2=-1+0
vmlinux.o: warning: objtool: .entry.text+0x168c: stack state mismatch:
cfa1=7-8 cfa2=-1+0

There are a couple of differences, like the first "undefined stack
state" warning pointing to set_bringup_idt_handler.constprop.0()
instead of __switch_to_asm(). I tried running this with --backtrace,
but objtool segfaults at the first .entry.text warning:

$ ./tools/objtool/objtool check -barfld vmlinux.o
...
vmlinux.o: warning: objtool:
set_bringup_idt_handler.constprop.0()+0x0: undefined stack state
vmlinux.o: warning: objtool:   xen_hypercall_set_trap_table()+0x0: <=== (sym)
...
vmlinux.o: warning: objtool: .entry.text+0xffd: sibling call from
callable instruction with modified stack frame
vmlinux.o: warning: objtool:   .entry.text+0xfcb: (branch)
Segmentation fault

Going back to the allyesconfig+LTO vmlinux.o, the "undefined stack
state" warning looks quite similar:

$ ./tools/objtool/objtool check -barlfd vmlinux.o
vmlinux.o: warning: objtool: __switch_to_asm()+0x0: undefined stack state
vmlinux.o: warning: objtool:   xen_hypercall_set_trap_table()+0x0: <=== (sym)
vmlinux.o: warning: objtool: .entry.text+0xffd: sibling call from
callable instruction with modified stack frame
vmlinux.o: warning: objtool:   .entry.text+0xfcb: (branch)
Segmentation fault

Sami
