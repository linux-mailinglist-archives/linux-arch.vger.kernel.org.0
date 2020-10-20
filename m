Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821A72942F4
	for <lists+linux-arch@lfdr.de>; Tue, 20 Oct 2020 21:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438089AbgJTTYv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Oct 2020 15:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438087AbgJTTYu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Oct 2020 15:24:50 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47115C0613CE
        for <linux-arch@vger.kernel.org>; Tue, 20 Oct 2020 12:24:50 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id o18so3040326edq.4
        for <linux-arch@vger.kernel.org>; Tue, 20 Oct 2020 12:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0aSlO1W7vXD8wpvCCG7wGbAKM67BTQt/FrRx6zZmumc=;
        b=MD9d7uz3cpra2FJBi9y1hEvF1r4hdy805N/H3qRtjanKJvvmB1oAnplnX1pvJFGw3p
         u2TpNcRLfU2Z2DTbjohMDHA66MV8G90XBOBS8mILuZVE2Tl1fio+VP73xYJigeFrlIeI
         thKNSd2wLZ0ZiU7v9+mZ7gKsBuhfO3C5IZPR0QUG037jFS7rG71K9DGNZPifpYw5Zb3j
         jS/9m7X8sU7ej/VKCctxs5ZOZrMHQSjQz9JjI68haEWvlWCeAR9lPPGbS1DsHCzFD131
         9coer59bAU/KEvj4fQv6K3nmuab06BfEXpdrDvwZLwzkJFQzfVDZxEo6uSKYeFUMVvag
         pqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0aSlO1W7vXD8wpvCCG7wGbAKM67BTQt/FrRx6zZmumc=;
        b=IYpB65N5Ki6iJLImvVDyZyTpS0/cgO1o808S0kqEWNEWbY1jjay0Moj36HDuUTHRMm
         5wdpplEf71uJJBP+18UVjEtt4YGwOGcGF1zHOws1nr6qISmaP4OAmNsCA0MJwd2yzR/y
         +IexJXF+OTpmh+QkplGzzxaPd2U/VNEWghQ/4yJCaGOlVauG6DVls5dP2LsB887Pj7kX
         hslIVhhsIQFQXR/H5c9c3BDXMBOt47/QiwuvCwpu4dnOW5UtMZ4ftirUpjJWgJfPO2wx
         N6rLDFHxaX7BSCNQVVCXdMWchAFH8fohjL/Zxa4I10tgn0oPi9gX/NPqw0yyALIIzDna
         UwTA==
X-Gm-Message-State: AOAM530Jmz283DPi5JuLG1NF8kf85ngXFbWOpV/G+FachReqcq7cl7W7
        szvDqo8cVr3jTaJV8Xm/yQg68YRGxAgWet5oJc+C/g==
X-Google-Smtp-Source: ABdhPJyMOA23NnvKtSjkOLGiry9VkOkNifOIW4sa6w2YiQX+XkJh8M/nVDkTK78UH1bOaHTG4GNJ1uOJcZ3dDNt12gE=
X-Received: by 2002:a50:88e5:: with SMTP id d92mr4494054edd.145.1603221888446;
 Tue, 20 Oct 2020 12:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-23-samitolvanen@google.com> <CAG48ez2baAvKDA0wfYLKy-KnM_1CdOwjU873VJGDM=CErjsv_A@mail.gmail.com>
 <20201015102216.GB2611@hirez.programming.kicks-ass.net> <20201015203942.f3kwcohcwwa6lagd@treble>
 <CABCJKufDLmBCwmgGnfLcBw_B_4U8VY-R-dSNNp86TFfuMobPMw@mail.gmail.com> <20201020185217.ilg6w5l7ujau2246@treble>
In-Reply-To: <20201020185217.ilg6w5l7ujau2246@treble>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 20 Oct 2020 12:24:37 -0700
Message-ID: <CABCJKucVjFtrOsw58kn4OnW5kdkUh8G7Zs4s6QU9s6O7soRiAA@mail.gmail.com>
Subject: Re: [PATCH v6 22/25] x86/asm: annotate indirect jumps
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
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

On Tue, Oct 20, 2020 at 11:52 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Tue, Oct 20, 2020 at 09:45:06AM -0700, Sami Tolvanen wrote:
> > On Thu, Oct 15, 2020 at 1:39 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Thu, Oct 15, 2020 at 12:22:16PM +0200, Peter Zijlstra wrote:
> > > > On Thu, Oct 15, 2020 at 01:23:41AM +0200, Jann Horn wrote:
> > > >
> > > > > It would probably be good to keep LTO and non-LTO builds in sync about
> > > > > which files are subjected to objtool checks. So either you should be
> > > > > removing the OBJECT_FILES_NON_STANDARD annotations for anything that
> > > > > is linked into the main kernel (which would be a nice cleanup, if that
> > > > > is possible),
> > > >
> > > > This, I've had to do that for a number of files already for the limited
> > > > vmlinux.o passes we needed for noinstr validation.
> > >
> > > Getting rid of OBJECT_FILES_NON_STANDARD is indeed the end goal, though
> > > I'm not sure how practical that will be for some of the weirder edge
> > > case.
> > >
> > > On a related note, I have some old crypto cleanups which need dusting
> > > off.
> >
> > Building allyesconfig with this series and LTO enabled, I still see
> > the following objtool warnings for vmlinux.o, grouped by source file:
> >
> > arch/x86/entry/entry_64.S:
> > __switch_to_asm()+0x0: undefined stack state
> > .entry.text+0xffd: sibling call from callable instruction with
> > modified stack frame
> > .entry.text+0x48: stack state mismatch: cfa1=7-8 cfa2=-1+0
>
> Not sure what this one's about, there's no OBJECT_FILES_NON_STANDARD?

Correct, because with LTO, we won't have an ELF binary to process
until we compile everything into vmlinux.o, and at that point we can
no longer skip individual object files.

The sibling call warning is in
swapgs_restore_regs_and_return_to_usermode and the stack state
mismatch in entry_SYSCALL_64_after_hwframe.

> > arch/x86/entry/entry_64_compat.S:
> > .entry.text+0x1754: unsupported instruction in callable function

This comes from a sysretl instruction in entry_SYSCALL_compat.

> > .entry.text+0x1634: redundant CLD
> > .entry.text+0x15fd: stack state mismatch: cfa1=7-8 cfa2=-1+0
> > .entry.text+0x168c: stack state mismatch: cfa1=7-8 cfa2=-1+0
>
> Ditto.

These are all from entry_SYSENTER_compat_after_hwframe.

> > arch/x86/kernel/head_64.S:
> > .head.text+0xfb: unsupported instruction in callable function
>
> Ditto.

This is lretq in secondary_startup_64_no_verify.

> > arch/x86/crypto/camellia-aesni-avx2-asm_64.S:
> > camellia_cbc_dec_32way()+0xb3: stack state mismatch: cfa1=7+520 cfa2=7+8
> > camellia_ctr_32way()+0x1a: stack state mismatch: cfa1=7+520 cfa2=7+8
>
> I can clean off my patches for all the crypto warnings.

Great, sounds good.

> > arch/x86/lib/retpoline.S:
> > __x86_retpoline_rdi()+0x10: return with modified stack frame
> > __x86_retpoline_rdi()+0x0: stack state mismatch: cfa1=7+32 cfa2=7+8
> > __x86_retpoline_rdi()+0x0: stack state mismatch: cfa1=7+32 cfa2=-1+0
>
> Is this with upstream?  I thought we fixed that with
> UNWIND_HINT_RET_OFFSET.

Yes, and the UNWIND_HINT_RET_OFFSET is there.

> > Josh, Peter, any thoughts on what would be the preferred way to fix
> > these, or how to tell objtool to ignore this code?
>
> One way or another, the patches need to be free of warnings before
> getting merged.  I can help, though I'm traveling and only have limited
> bandwidth for at least the rest of the month.
>
> Ideally we'd want to have objtool understand everything, with no
> whitelisting, but some cases (e.g. suspend code) can be tricky.
>
> I wouldn't be opposed to embedding the whitelist in the binary, in a
> discardable section.  It should be relatively easy, but as I mentioned I
> may or may not have time to work on it for a bit.  I'm working half
> days, and now the ocean beckons from the window of my camper.

Something similar to STACK_FRAME_NON_STANDARD()? Using that seems to
result in "BUG: why am I validating an ignored function?" warnings, so
I suspect some additional changes are needed.

Sami
