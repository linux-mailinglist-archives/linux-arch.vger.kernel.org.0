Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084EE2ADEF2
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 20:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgKJTAJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Nov 2020 14:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJTAI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Nov 2020 14:00:08 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44286C0613D1
        for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2020 11:00:08 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id y78so7680353vsy.6
        for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2020 11:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HQMWJ4qrTrrDaVP4fR8AYbnLL+HhbqUgRWbw+YSQ1PU=;
        b=UAf9RqBB0qr82AsqOtHV2sesZ3cFzDvVPrFOFo9wUuuHJXryVnBngDsIrGvKaE6X19
         0SqjoI+qK8F47wcovy/kBeCPJ4lIKLolgnCYTTAinI6LM/5ys2dh6HlhdigZSrVkC/rn
         ShAlUOfI+vdr9rptwftYPxBYiTijHNtuYVGc3mYzd/3mrO/nNNPGBPmWtes0yy3EJX3R
         sHQB4adTCc34sogEGEr66NVJxa45ZnJ2DpryOQ0DhgNiqen71LLeDBvfUdLT3d4QP0EK
         CCvE4ObR4otzBFPgR6yeCqhZTLFHqyDs2Tr4Y5R18i3xk72lbdkEjxSGufRjUQd0yCL8
         Ojbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HQMWJ4qrTrrDaVP4fR8AYbnLL+HhbqUgRWbw+YSQ1PU=;
        b=tuYJ/f5hsgLzxwl0zlS4sof7abIMzBljEuMdJBKNpewPMhEgDOjjjOam7z352S1yWV
         /VaGPM301ftINxRkcaHsZBS7v8VLdltcJpoRboxoppZFI3FwUdeFXH3gv6hVh8qFAxUv
         OfyDbuyD5pvHLKBa2WQoBrtOdivVxb00NZNk7pVFGNEgZqgePyCKPKZs4kw8i9/nbSBI
         8MYVSUcvct4B411WT2m5rmPt9LkMFif3yoRo37WgAtF8Z2BkL1MIqpSDOr2/40KVvtF4
         MfrFWuWI+kggn7DpQoeK2D5dwlK8v/uysymVrH001HADvBpN7CCKIade4ISSyu/te+5P
         VDjw==
X-Gm-Message-State: AOAM530Z/A1ccnWbfIYVzPZUiScpA7MNlxIeZBljwySwIqrFqLgY3R0F
        fOjciXpl12AUeEId3iinj2OE7cQcUsuc9Gof9cHbFA==
X-Google-Smtp-Source: ABdhPJw/xQbpb4nm+Nf8IkeXZp9mvPOXpptK1b90vfr96ZwBHQ1ynLFLCpnmKb8sXq4PoJSCYGgPJD2CoGITJLPmHok=
X-Received: by 2002:a67:ee93:: with SMTP id n19mr12787183vsp.36.1605034807022;
 Tue, 10 Nov 2020 11:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20201015102216.GB2611@hirez.programming.kicks-ass.net>
 <20201015203942.f3kwcohcwwa6lagd@treble> <CABCJKufDLmBCwmgGnfLcBw_B_4U8VY-R-dSNNp86TFfuMobPMw@mail.gmail.com>
 <20201020185217.ilg6w5l7ujau2246@treble> <CABCJKucVjFtrOsw58kn4OnW5kdkUh8G7Zs4s6QU9s6O7soRiAA@mail.gmail.com>
 <20201021085606.GZ2628@hirez.programming.kicks-ass.net> <CABCJKufL6=FiaeD8T0P+mK4JeR9J80hhjvJ6Z9S-m9UnCESxVA@mail.gmail.com>
 <20201023173617.GA3021099@google.com> <CABCJKuee7hUQSiksdRMYNNx05bW7pWaDm4fQ__znGQ99z9-dEw@mail.gmail.com>
 <20201110022924.tekltjo25wtrao7z@treble> <20201110174606.mp5m33lgqksks4mt@treble>
In-Reply-To: <20201110174606.mp5m33lgqksks4mt@treble>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 10 Nov 2020 10:59:55 -0800
Message-ID: <CABCJKuf+Ev=hpCUfDpCFR_wBACr-539opJsSFrDcpDA9Ctp7rg@mail.gmail.com>
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

On Tue, Nov 10, 2020 at 9:46 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Mon, Nov 09, 2020 at 08:29:24PM -0600, Josh Poimboeuf wrote:
> > On Mon, Nov 09, 2020 at 03:11:41PM -0800, Sami Tolvanen wrote:
> > > CONFIG_XEN
> > >
> > > __switch_to_asm()+0x0: undefined stack state
> > >   xen_hypercall_set_trap_table()+0x0: <=== (sym)
>
> With your branch + GCC 9 I can recreate all the warnings except this
> one.

In a gcc build this warning is replaced with a different one:

vmlinux.o: warning: objtool: __startup_secondary_64()+0x7: return with
modified stack frame

This just seems to depend on which function is placed right after the
code in xen-head.S. With gcc, the disassembly looks like this:

0000000000000000 <asm_cpu_bringup_and_idle>:
       0:       e8 00 00 00 00          callq  5 <asm_cpu_bringup_and_idle+0x5>
                        1: R_X86_64_PLT32       cpu_bringup_and_idle-0x4
       5:       e9 f6 0f 00 00          jmpq   1000
<xen_hypercall_set_trap_table>
...
0000000000001000 <xen_hypercall_set_trap_table>:
        ...
...
0000000000002000 <__startup_secondary_64>:

With Clang+LTO, we end up with __switch_to_asm here instead of
__startup_secondary_64.

> Will do some digging on the others...

Thanks!

Sami
