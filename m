Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8428F2F0471
	for <lists+linux-arch@lfdr.de>; Sun, 10 Jan 2021 00:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbhAIXpt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Jan 2021 18:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbhAIXps (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Jan 2021 18:45:48 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9D3C061786;
        Sat,  9 Jan 2021 15:45:08 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id x15so14456278ilq.1;
        Sat, 09 Jan 2021 15:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=+RrrtQj8SC/rvlP5LlORUe5YEU0RLqpKs9/GxE+Y/3s=;
        b=UOX+83msyY0c9zbWi3lYQYT+DWm3pxfGQCmxDKZPWRz9aNa0fJmFuyJAoTAa/G4p7p
         SfNMBUVFInFsSss6Hai+8E7R2dRPkeMJSuuqPKYrSgxVvPznCQuX0c2x7pK0ziYUnGZu
         C/dqYRW3yn3mK0faEKPwVBExadp8Kgslh3Ifx3qEtRAOxZYLp3wJrsmwNVogv2Xvn8YT
         DVM8yO3ktn4mQBz3CJwUaGYDKRVh9+pk89SZhcMQUvemteqhM0YjjcAszrwEuZ3YQsOL
         +z0ZOj3P4MtB6Y0w3VDW2nsmUA/2XYGMxtK5IxtSgUVZaBmlLr3bxkan/kkyZN9N4cu3
         RmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=+RrrtQj8SC/rvlP5LlORUe5YEU0RLqpKs9/GxE+Y/3s=;
        b=OFV3OyOAg0obWFCwp1sLAbrE3ECZLl7SYTUr9dG1BC5+7xUOx8FUmAnOJVqpw7wjln
         fx/WghkwXJ9sccqLfbkB5noz/dhA0FpcH+u3RW1lENnxUzZPl81YPObewNMz6Vs64k+B
         QGuxfQ4yqnA2GFIAxGlbK5se0MxGb14SuuvhSPgMpIrJ4JR4svSYUsWka6M25UzsDkbR
         t1JtDy28MVFnzhiBLibuxLTKYZZVzfWSVjMpw6pO/CVrpiILDIEw4OUVN6H+Xg+nkbqf
         A/rJzp49EJADtT92uU3ps6w35TzEwixVaCMF3MCmqpKzs7iALazrMgT7468OIQSmQVR5
         SS6w==
X-Gm-Message-State: AOAM531hDmgOBC55VZ1fryac+uvCL9zdon+yBJ7z9M/cv5/wx+yO+Ne7
        EMJcuxl4UmeQhqs7u1HmPdgFA8LwkYEky6AQyog=
X-Google-Smtp-Source: ABdhPJzWsen+1bFKw+cuUM+1jT3nRAdUJAbnO8/1z/3RJ3vKQKxWxm92cFnz6xMw+Un/kDcSMfb/nu/s13W2lsXa7/g=
X-Received: by 2002:a92:c002:: with SMTP id q2mr10229657ild.186.1610235907552;
 Sat, 09 Jan 2021 15:45:07 -0800 (PST)
MIME-Version: 1.0
References: <20201211184633.3213045-1-samitolvanen@google.com>
 <CA+icZUWYxO1hHW-_vrJid7EstqQRYQphjO3Xn6pj6qfEYEONbA@mail.gmail.com>
 <20210109153646.zrmglpvr27f5zd7m@treble> <CA+icZUUiucbsQZtJKYdD7Y7Cq8hJZdBwsF0U0BFbaBtnLY3Nsw@mail.gmail.com>
 <20210109160709.kqqpf64klflajarl@treble> <CA+icZUU=sS2xfzo9qTUTPQ0prbbQcj29tpDt1qK5cYZxarXuxg@mail.gmail.com>
 <20210109163256.3sv3wbgrshbj72ik@treble> <CA+icZUUszOHkJ8Acx2mDowg3StZw9EureDQ7YYkJkcAnpLBA+g@mail.gmail.com>
 <20210109170353.litivfvc4zotnimv@treble> <20210109170558.meufvgwrjtqo5v3i@treble>
In-Reply-To: <20210109170558.meufvgwrjtqo5v3i@treble>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 10 Jan 2021 00:44:54 +0100
Message-ID: <CA+icZUVS_CbbxG-V0RZxqxcY7E__QUrVxgC1VRmTLN4wrz=E5w@mail.gmail.com>
Subject: Re: [PATCH v9 00/16] Add support for Clang LTO
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 9, 2021 at 6:06 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Sat, Jan 09, 2021 at 11:03:57AM -0600, Josh Poimboeuf wrote:
> > On Sat, Jan 09, 2021 at 05:45:47PM +0100, Sedat Dilek wrote:
> > > I tried merging with clang-cfi Git which is based on Linux v5.11-rc2+
> > > with a lot of merge conflicts.
> > >
> > > Did you try on top of cfi-10 Git tag which is based on Linux v5.10?
> > >
> > > Whatever you successfully did... Can you give me a step-by-step instruction?
> >
> > Oops, my bad.  My last three commits (which I just added) do conflict.
> > Sorry for the confusion.
> >
> > Just drop my last three commits:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-vmlinux
> > git checkout -B tmp FETCH_HEAD
> > git reset --hard HEAD~~~
> > git fetch https://github.com/samitolvanen/linux clang-lto
> > git rebase --onto FETCH_HEAD 79881bfc57be
>
> Last one should be:
>
> git rebase --onto FETCH_HEAD 2c85ebc57b3e
>

Hi Josh,

as said I tried your latest changes on top of Linux v5.10.6 + cfi-5.10.
This reduces the objtool-warnings in vmlinux.o from 15 down to 2.

Without your latest changes:

$ grep 'vmlinux.o: warning: objtool:'
build-log_5.10.4-3-amd64-clang11-cfi.txt | wc -l
15

$ grep 'vmlinux.o: warning: objtool:'
build-log_5.10.4-3-amd64-clang11-cfi.txt
vmlinux.o: warning: objtool: wakeup_long64()+0x61: indirect jump found
in RETPOLINE build
vmlinux.o: warning: objtool: .text+0x408a: indirect jump found in
RETPOLINE build
vmlinux.o: warning: objtool: .text+0x40c5: indirect jump found in
RETPOLINE build
vmlinux.o: warning: objtool: .head.text+0x298: indirect jump found in
RETPOLINE build
vmlinux.o: warning: objtool: __switch_to_asm()+0x0: undefined stack state
vmlinux.o: warning: objtool: .entry.text+0xf91: sibling call from
callable instruction with modified stack frame
vmlinux.o: warning: objtool: .entry.text+0x16c4: unsupported
instruction in callable function
vmlinux.o: warning: objtool: .entry.text+0x15a4: redundant CLD
vmlinux.o: warning: objtool: do_suspend_lowlevel()+0x116: sibling call
from callable instruction with modified stack frame
vmlinux.o: warning: objtool: kretprobe_trampoline()+0x49: return with
modified stack frame
vmlinux.o: warning: objtool: machine_real_restart()+0x85: unsupported
instruction in callable function
vmlinux.o: warning: objtool: __x86_retpoline_rdi()+0x0: stack state
mismatch: cfa1=7+8 cfa2=-1+0
vmlinux.o: warning: objtool: .entry.text+0x48: stack state mismatch:
cfa1=7-8 cfa2=-1+0
vmlinux.o: warning: objtool: .entry.text+0x156d: stack state mismatch:
cfa1=7-8 cfa2=-1+0
vmlinux.o: warning: objtool: .entry.text+0x15fc: stack state mismatch:
cfa1=7-8 cfa2=-1+0

With your latest changes in <jpoimboe.git#objtool-vmlinux>:

$ grep 'vmlinux.o: warning: objtool:'
build-log_5.10.6-1-amd64-clang11-cfi.txt | wc -l
2

$ grep 'vmlinux.o: warning: objtool:' build-log_5.10.6-1-amd64-clang11-cfi.txt
vmlinux.o: warning: objtool: kretprobe_trampoline()+0x49: return with
modified stack frame
vmlinux.o: warning: objtool: machine_real_restart()+0x85: unsupported
instruction in callable function

Awesome.

If you need further information, please let me know.

Regards,
- Sedat -
