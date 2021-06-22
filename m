Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745BE3B0E09
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jun 2021 22:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhFVUGj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Jun 2021 16:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbhFVUGi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jun 2021 16:06:38 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA5CC061574;
        Tue, 22 Jun 2021 13:04:21 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id k5so96816pjj.1;
        Tue, 22 Jun 2021 13:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZyR4TXm77nANYqbVBDwy8Wfz5J20cBwm1usM536K6vs=;
        b=mBEteQj3F8IFf8Y9oFzLoQwva9C8qN+Tq0M24DOgBrpQVWsIxIBjGxpZ+bfBWreU3w
         erlOaj+HQui4iKtBo632TfzaS3UwHwVslx97C0as4JoBlSYhlr/Ss2EZ2hJaWaJi8pmn
         kBCl+5PGJG1ZX+hRFcBi/cVkYmJJ81WEeA9tWJYbOewvR4u8ET86lHCLlRNe63mpzFk6
         vgj9LrPI45QRWdFhCWB0yYZmUAnL/0q/PZSoyPv3i2eGpyNuVRE7A+24M9gyiE9FJoob
         0HvKON8z1C9IKVt7UbEjXM0g6oMuPh+LZJFx2ynBoF1wQkAqyhbdU2pXNJBZ4fcYg4qy
         eQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZyR4TXm77nANYqbVBDwy8Wfz5J20cBwm1usM536K6vs=;
        b=nC2uk6/NIh6ADAtBVMEhVx9HetBJ28lQnNgzaapqOc360CkvkmchJ7TgtOyh8BqoDC
         NEhWN4GDPPtnY6ICYgIl/PDhnEDvLe8LJYeaBveRhU4r3lyPuPswF67s9PNka3ODtqyL
         N1+zm50DjVtJSIlXcvqTJI/QC75rbhclM17AOVatqGzOhkou67qk9ZDXcncey7/bPX4y
         +vqncjJdNc/bJ7C2ZiNWCQ8gqs8DSN1WYapbEZnzwkT3p50gZwMwHidYFC/pDwyPvVO3
         zPkXcxC41lrY/TVDE6yD10U6OUw5Yk6cq2pI890FkMEW9p0WBytIZ6nrthW57xEfReIr
         mt6w==
X-Gm-Message-State: AOAM531TJ4jH5U9BiWQWkfGvt1xe0LTDII/Dd7HFzyIWJu/B1VLaQwce
        6VecgwvgZFEu42efS/iz1a0=
X-Google-Smtp-Source: ABdhPJy5hc18y+Hy9LXy7j4cx0E8eEAvZ4FlwKRRiXI7JToFYysyVqtb+6zg0LljVa4CBdFCQ0U41w==
X-Received: by 2002:a17:90b:ecf:: with SMTP id gz15mr5359086pjb.131.1624392261368;
        Tue, 22 Jun 2021 13:04:21 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:9491:40e4:164d:6ab3? ([2001:df0:0:200c:9491:40e4:164d:6ab3])
        by smtp.gmail.com with ESMTPSA id h19sm138462pfh.155.2021.06.22.13.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 13:04:20 -0700 (PDT)
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andreas Schwab <schwab@linux-m68k.org>
References: <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
 <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com> <87eed4v2dc.fsf@disp2133>
 <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com> <87fsxjorgs.fsf@disp2133>
 <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
 <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
 <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
 <YNDsYk6kbisbNy3I@zeniv-ca.linux.org.uk>
 <CAHk-=wh82uJ5Poqby3brn-D7xWbCMnGv-JnwfO0tuRfCvsVgXA@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <de5f0132-eed4-f1d0-ddd2-f65a62de6b81@gmail.com>
Date:   Wed, 23 Jun 2021 08:04:11 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wh82uJ5Poqby3brn-D7xWbCMnGv-JnwfO0tuRfCvsVgXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

On 22/06/21 11:14 am, Linus Torvalds wrote:
> On Mon, Jun 21, 2021 at 12:45 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>> Looks like sys_exit() and do_group_exit() would be the two places to
>>> do it (do_group_exit() would handle the signal case and
>>> sys_group_exit()).
>> Maybe...  I'm digging through that pile right now, will follow up when
>> I get a reasonably complete picture
> We might have another possible way to solve this:
>
>   (a) make it the rule that everybody always saves the full (integer)
> register set in pt_regs
>
>   (b) make m68k just always create that switch-stack for all system
> calls (it's really not that big, I think it's like six words or
> something)

Turns out that is harder than it looked at first glance (at least for me).

All syscalls that _do_ save the switch stack are currently called 
through wrappers which pull the syscall arguments out of the saved 
pt_regs on the stack (pushing the switch stack after the SAVE_ALL saved 
stuff buries the syscall arguments on the stack, see comment about 
m68k_clone(). We'd have to push the switch stack _first_ when entering 
system_call to leave the syscall arguments in place, but that will 
require further changes to the syscall exit path (currently shared with 
the interrupt exit path). Not to mention the register offset 
calculations in arch/m68k/kernel/ptrace.c, and perhaps a few other 
dependencies that don't come to mind immediately.

We have both pt_regs and switch_stack in uapi/asm/ptrace.h, but the 
ordering of the two is only mentioned in a comment. Can we reorder them 
on the stack, as long as we don't change the struct definitions proper?

This will take a little more time to work out and test - certainly not 
before the weekend. I'll send a corrected version of my debug patch 
before that.

Cheers,

     Michael


>
>   (c) admit that alpha is broken, but nobody really cares
>
>> In the meanwhile, do kernel/kthread.c uses look even remotely sane?
>> Intentional - sure, but it really looks wrong to use thread exit code
>> as communication channel there...
> I really doubt that it is even "intentional".
>
> I think it's "use some errno as a random exit code" and nobody ever
> really thought about it, or thought about how that doesn't really
> work. People are used to the error numbers, not thinking about how
> do_exit() doesn't take an error number, but a signal number (and an
> 8-bit positive error code in bits 8-15).
>
> Because no, it's not even remotely sane.
>
> I think the do_exit(-EINTR) could be do_exit(SIGINT) and it would make
> more sense. And the -ENOMEM might be SIGBUS, perhaps.
>
> It does look like the usermode-helper code does save the exit code
> with things like
>
>                  kernel_wait(pid, &sub_info->retval);
>
> and I see call_usermodehelper_exec() doing
>
>          retval = sub_info->retval;
>
> and treating it as an error code. But I think those have never been
> tested with that (bogus) exit code thing from kernel_wait(), because
> it wouldn't have worked.  It has only ever been tested with the (real)
> exit code things like
>
>                  if (pid < 0) {
>                          sub_info->retval = pid;
>
> which does actually assign a negative error code to it.
>
> So I think that
>
>                  kernel_wait(pid, &sub_info->retval);
>
> line is buggy, and should be something like
>
>                  int wstatus;
>                  kernel_wait(pid, &wstatus);
>                  sub_info->retval = WEXITSTATUS(wstatus) ? -EINVAL : 0;
>
> or something.
>
>              Linus
