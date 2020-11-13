Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8B12B2550
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 21:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgKMUYq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 15:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKMUYp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Nov 2020 15:24:45 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940BFC0613D1
        for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2020 12:24:45 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id w3so3413007uau.2
        for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2020 12:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mU6UeGOfRQMRJwnHmGX5EKrd3fAZtibGBHai3RFBnJQ=;
        b=SBgav/T3VzzEtf+XcGk0y2urSrYRSMZdZ/BSprOQYF07imi1ADQ6+bP8NVgkFIS13j
         c29etEZPIosU9Ccq+aDvjNmW4gtV+RXjaLR5/iYKTteik7fkjmDnPZ3rLCzlNv2EYSEP
         /f9Rq5iUQR0o7S1G9L2SZCAv7mAGSkXEUI5hN3rLrtsdHgPlxnpAG0v3MFSAKPbkQrae
         WLoVYBLPEP79v4Y7OA8gXbcs08GtIihODPoDAmO+6mtoQqiccreuY2GcpYzaDeYkNLlF
         n1WMuVFyGng50eB9Mmqa/6aQz5eygw2tOZp8M/jD01KJFVb5k1ymIpwXFEcj8xVZxzyy
         nZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mU6UeGOfRQMRJwnHmGX5EKrd3fAZtibGBHai3RFBnJQ=;
        b=Em9/J5Sfvv+w8OAO+vLLwPzJM1EbdGYAediww/ZR7soqCRIZ72itdyEGoWcRqIYz0q
         DECBxkn6sz9L8CpmdjIIL8WWR9YwJ1OIUhc0SoLn4U5fexJ8bfY4fLfUJVLJUhKm02RZ
         AB+TyQEejdzXUS+RT3RSCBJ4LYO0MhG7+jImZnQIVDLkJmsFd2rDpVZ2Md+ACjWOnt5j
         GFIGVOCq2s0OgQlsEMHe/cxh6Oje4dxbKu7qwUReF8PiUtXLBvrwy4LD91VZT4HTEDie
         9zXWjKSI2lhidVFHPAUGuI4D1V1olBb7O6vxMIlp3LiHLJGPPBftGVQwr+DhfAA5yqMg
         LbpA==
X-Gm-Message-State: AOAM533c22J4EVXRaH276niveL4vF3oHDH7XXwoQetS+3N0BSeVfjN+G
        XbCvIichE3WYhOER0PDJ4vuNKPYOcQsODTA9b6AocA==
X-Google-Smtp-Source: ABdhPJxQo6DF9jUnA2YJFoBq8ll7fJYetoimM/TRDoFpxZhBeNyAnbeYafJONZ4hmtReCz/v9xa11p0ayWmu2zwdpXo=
X-Received: by 2002:ab0:6156:: with SMTP id w22mr2653091uan.122.1605299084290;
 Fri, 13 Nov 2020 12:24:44 -0800 (PST)
MIME-Version: 1.0
References: <CABCJKufDLmBCwmgGnfLcBw_B_4U8VY-R-dSNNp86TFfuMobPMw@mail.gmail.com>
 <20201020185217.ilg6w5l7ujau2246@treble> <CABCJKucVjFtrOsw58kn4OnW5kdkUh8G7Zs4s6QU9s6O7soRiAA@mail.gmail.com>
 <20201021085606.GZ2628@hirez.programming.kicks-ass.net> <CABCJKufL6=FiaeD8T0P+mK4JeR9J80hhjvJ6Z9S-m9UnCESxVA@mail.gmail.com>
 <20201023173617.GA3021099@google.com> <CABCJKuee7hUQSiksdRMYNNx05bW7pWaDm4fQ__znGQ99z9-dEw@mail.gmail.com>
 <20201110022924.tekltjo25wtrao7z@treble> <20201110174606.mp5m33lgqksks4mt@treble>
 <CABCJKuf+Ev=hpCUfDpCFR_wBACr-539opJsSFrDcpDA9Ctp7rg@mail.gmail.com> <20201113195408.atbpjizijnhuinzy@treble>
In-Reply-To: <20201113195408.atbpjizijnhuinzy@treble>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 13 Nov 2020 12:24:32 -0800
Message-ID: <CABCJKufA-aOcsOqb1NiMQeBGm9Q-JxjoPjsuNpHh0kL4LzfO0w@mail.gmail.com>
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

On Fri, Nov 13, 2020 at 11:54 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Tue, Nov 10, 2020 at 10:59:55AM -0800, Sami Tolvanen wrote:
> > On Tue, Nov 10, 2020 at 9:46 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Mon, Nov 09, 2020 at 08:29:24PM -0600, Josh Poimboeuf wrote:
> > > > On Mon, Nov 09, 2020 at 03:11:41PM -0800, Sami Tolvanen wrote:
> > > > > CONFIG_XEN
> > > > >
> > > > > __switch_to_asm()+0x0: undefined stack state
> > > > >   xen_hypercall_set_trap_table()+0x0: <=== (sym)
> > >
> > > With your branch + GCC 9 I can recreate all the warnings except this
> > > one.
> >
> > In a gcc build this warning is replaced with a different one:
> >
> > vmlinux.o: warning: objtool: __startup_secondary_64()+0x7: return with
> > modified stack frame
> >
> > This just seems to depend on which function is placed right after the
> > code in xen-head.S. With gcc, the disassembly looks like this:
> >
> > 0000000000000000 <asm_cpu_bringup_and_idle>:
> >        0:       e8 00 00 00 00          callq  5 <asm_cpu_bringup_and_idle+0x5>
> >                         1: R_X86_64_PLT32       cpu_bringup_and_idle-0x4
> >        5:       e9 f6 0f 00 00          jmpq   1000
> > <xen_hypercall_set_trap_table>
> > ...
> > 0000000000001000 <xen_hypercall_set_trap_table>:
> >         ...
> > ...
> > 0000000000002000 <__startup_secondary_64>:
> >
> > With Clang+LTO, we end up with __switch_to_asm here instead of
> > __startup_secondary_64.
>
> I still don't see this warning for some reason.

Do you have CONFIG_XEN enabled? I can reproduce this on ToT master as follows:

$ git rev-parse HEAD
585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba
$ make defconfig && \
./scripts/config -e HYPERVISOR_GUEST -e PARAVIRT -e XEN && \
make olddefconfig && \
make -j110
...
$ ./tools/objtool/objtool check -arfld vmlinux.o 2>&1 | grep secondary
vmlinux.o: warning: objtool: __startup_secondary_64()+0x2: return with
modified stack frame

> Is it fixed by adding cpu_bringup_and_idle() to global_noreturns[] in
> tools/objtool/check.c?

No, that didn't fix the warning. Here's what I tested:

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c6ab44543c92..f1f65f5688cf 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -156,6 +156,7 @@ static bool __dead_end_function(struct
objtool_file *file, struct symbol *func,
                "machine_real_restart",
                "rewind_stack_do_exit",
                "kunit_try_catch_throw",
+               "cpu_bringup_and_idle",
        };

        if (!func)

Sami
