Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102C32940BD
	for <lists+linux-arch@lfdr.de>; Tue, 20 Oct 2020 18:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394807AbgJTQpY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Oct 2020 12:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394795AbgJTQpU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Oct 2020 12:45:20 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9914C0613D1
        for <linux-arch@vger.kernel.org>; Tue, 20 Oct 2020 09:45:18 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id x1so2569553eds.1
        for <linux-arch@vger.kernel.org>; Tue, 20 Oct 2020 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqizJSkHLOLzXDwR4VjspCggxCD/0uuJQy5O12nu08k=;
        b=BmIYSpKF/wewx0pVBHz6bZcXrLxTE2fKY4HLv9yuHgYyrVaSOjigVXmPBzjrL7xlIJ
         VTgmWossfUJOX/R5TaQ+ThmgHs7V088hEugn6EEuVzD/i0Mli23AsWnNcCV6nPAvruje
         F8zSJL9OrB+vYfUPJGshGRDYZZbQ5xmn8vNXZK+D5zD9Q/CK0ctQOc6Rs0mEBFP5o0/d
         PhSgjDfQUGBz1DmDrMJIxw5Y5kbLSJR7dfiosoYWpS+q6Eak6PkMWQcdf6VwrukRYC3o
         1O0qQK+rwTBeroItujJc/douFayUtk7GHO/94F4IrPakPrGcHx9YrIEAWapdv0fMl6Wa
         bVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqizJSkHLOLzXDwR4VjspCggxCD/0uuJQy5O12nu08k=;
        b=nwBIAcxvSNZkgDa63VrGaOvZ2NS4DfbWnyn9FibKG417Bj8+hi0sN2DYdMWbAOnmnc
         VmxCt00s2wGy+QXRxGQhaAGe3FLgdLJpWEx2xTABaXFiFEVu8rbGjtjQMwP6GDeI54vN
         xty6P7JJk80VYnrOHO3kYTnUgMwWzoxW91QAaEsQcFV/46KJoJ+a0cIV946EznE+zy4h
         ocb0ehX0ORVjqW7ksfRXntUG7yimqsNVZYzvVPN6PNhvBtIKRfp9HHf1wYfC4X0j7a3B
         5C6Mfus9Ati3C+JDYv1K42LKqLtkrjYmFqkid2524ZHVgauA/17VTRWVIDL9/PrSPgKD
         q1Ww==
X-Gm-Message-State: AOAM532NYP8p6cGnsqPTGHuOZbOXK90BrVOm+8uxOUS7w4GQoiOQatuR
        7R3iNYNIbxUV3ppQ1YoKjanhgaWQkNUZJBCMuMZeRg==
X-Google-Smtp-Source: ABdhPJxJASQSBwjhvefIlXIgCa/J5q/z9s2/DT+6DEol2B5uWOlQJq+h4CQt7XBa7XYqaVTkAW7wHOWBvDNOrEZfs2I=
X-Received: by 2002:aa7:c7d9:: with SMTP id o25mr3843066eds.318.1603212317220;
 Tue, 20 Oct 2020 09:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-23-samitolvanen@google.com> <CAG48ez2baAvKDA0wfYLKy-KnM_1CdOwjU873VJGDM=CErjsv_A@mail.gmail.com>
 <20201015102216.GB2611@hirez.programming.kicks-ass.net> <20201015203942.f3kwcohcwwa6lagd@treble>
In-Reply-To: <20201015203942.f3kwcohcwwa6lagd@treble>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 20 Oct 2020 09:45:06 -0700
Message-ID: <CABCJKufDLmBCwmgGnfLcBw_B_4U8VY-R-dSNNp86TFfuMobPMw@mail.gmail.com>
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

On Thu, Oct 15, 2020 at 1:39 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, Oct 15, 2020 at 12:22:16PM +0200, Peter Zijlstra wrote:
> > On Thu, Oct 15, 2020 at 01:23:41AM +0200, Jann Horn wrote:
> >
> > > It would probably be good to keep LTO and non-LTO builds in sync about
> > > which files are subjected to objtool checks. So either you should be
> > > removing the OBJECT_FILES_NON_STANDARD annotations for anything that
> > > is linked into the main kernel (which would be a nice cleanup, if that
> > > is possible),
> >
> > This, I've had to do that for a number of files already for the limited
> > vmlinux.o passes we needed for noinstr validation.
>
> Getting rid of OBJECT_FILES_NON_STANDARD is indeed the end goal, though
> I'm not sure how practical that will be for some of the weirder edge
> case.
>
> On a related note, I have some old crypto cleanups which need dusting
> off.

Building allyesconfig with this series and LTO enabled, I still see
the following objtool warnings for vmlinux.o, grouped by source file:

arch/x86/entry/entry_64.S:
__switch_to_asm()+0x0: undefined stack state
.entry.text+0xffd: sibling call from callable instruction with
modified stack frame
.entry.text+0x48: stack state mismatch: cfa1=7-8 cfa2=-1+0

arch/x86/entry/entry_64_compat.S:
.entry.text+0x1754: unsupported instruction in callable function
.entry.text+0x1634: redundant CLD
.entry.text+0x15fd: stack state mismatch: cfa1=7-8 cfa2=-1+0
.entry.text+0x168c: stack state mismatch: cfa1=7-8 cfa2=-1+0

arch/x86/kernel/head_64.S:
.head.text+0xfb: unsupported instruction in callable function

arch/x86/kernel/acpi/wakeup_64.S:
do_suspend_lowlevel()+0x116: sibling call from callable instruction
with modified stack frame

arch/x86/crypto/camellia-aesni-avx2-asm_64.S:
camellia_cbc_dec_32way()+0xb3: stack state mismatch: cfa1=7+520 cfa2=7+8
camellia_ctr_32way()+0x1a: stack state mismatch: cfa1=7+520 cfa2=7+8

arch/x86/crypto/aesni-intel_avx-x86_64.S:
aesni_gcm_init_avx_gen2()+0x12: unsupported stack pointer realignment
aesni_gcm_enc_update_avx_gen2()+0x12: unsupported stack pointer realignment
aesni_gcm_dec_update_avx_gen2()+0x12: unsupported stack pointer realignment
aesni_gcm_finalize_avx_gen2()+0x12: unsupported stack pointer realignment
aesni_gcm_init_avx_gen4()+0x12: unsupported stack pointer realignment
aesni_gcm_enc_update_avx_gen4()+0x12: unsupported stack pointer realignment
aesni_gcm_dec_update_avx_gen4()+0x12: unsupported stack pointer realignment
aesni_gcm_finalize_avx_gen4()+0x12: unsupported stack pointer realignment

arch/x86/crypto/sha1_avx2_x86_64_asm.S:
sha1_transform_avx2()+0xc: unsupported stack pointer realignment

arch/x86/crypto/sha1_ni_asm.S:
sha1_ni_transform()+0x7: unsupported stack pointer realignment

arch/x86/crypto/sha256-avx2-asm.S:
sha256_transform_rorx()+0x13: unsupported stack pointer realignment

arch/x86/crypto/sha512-ssse3-asm.S:
sha512_transform_ssse3()+0x14: unsupported stack pointer realignment

arch/x86/crypto/sha512-avx-asm.S:
sha512_transform_avx()+0x14: unsupported stack pointer realignment

arch/x86/crypto/sha512-avx2-asm.S:
sha512_transform_rorx()+0x7: unsupported stack pointer realignment

arch/x86/lib/retpoline.S:
__x86_retpoline_rdi()+0x10: return with modified stack frame
__x86_retpoline_rdi()+0x0: stack state mismatch: cfa1=7+32 cfa2=7+8
__x86_retpoline_rdi()+0x0: stack state mismatch: cfa1=7+32 cfa2=-1+0

Josh, Peter, any thoughts on what would be the preferred way to fix
these, or how to tell objtool to ignore this code?

Sami
