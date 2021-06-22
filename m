Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C44A3B0F9C
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jun 2021 23:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFVVvH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Jun 2021 17:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVVvG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jun 2021 17:51:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8EAC061574;
        Tue, 22 Jun 2021 14:48:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id o21so253pll.6;
        Tue, 22 Jun 2021 14:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/a89jzJmhEpzXyHwVhCcKZ9uKv9DiUWiMoXSo4IAqPE=;
        b=Fj7WoX0NrdmFtDXSPbtKbFgnFmECG0CoEZ4apdWVK9HbJGRvJ+ZBhc5XMlidFXofUP
         RWjfmZvk+mM6RhZumcg0dSaV1oUyKYulB5H/nEg0lJ3cvPqePy77b0IcPVxSDSISJnIJ
         dcpLcgeGt3kO1NwuKcgE8BzaK4Y1D7n4IalQxNKpU5rzjl/3eO9988IoJHBxOWH99sio
         dlNfD9HjdJ+dm7+L/b4tD3GXwtXFTQ3R6hStNTzps39P1kALUFKhlDTgPPlxApk+m7OQ
         VpgUUKRGveGFPy/XEon+N+/Hos5/Mvs0VE2YkMq1h73qmm76/kJqcqRlEt8oA52XTgfJ
         01bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/a89jzJmhEpzXyHwVhCcKZ9uKv9DiUWiMoXSo4IAqPE=;
        b=OY7nl6c2C8p16cZX4GpaApJy6oNDJ9a0D3LZmehRIiCDaiMB4lHjboIab61F8Plh5X
         STx9RJkSRlIrCfpX/8L2dnwdo6hsG2+fKcH+Os7eE/9BfvmPCf5cGzJWrdxjA+xsufPw
         Uku1tRIj0R3v03xr34RUglyaNKLaQErUfdR5bqTxVq1J/bVrdDgy/z0IOoY+02LOPNAJ
         qMKJKb7kpptjrrykSI0EMXJLOWYXMiRBXF7URaNhwUNWLEPNjxHeeTmGdre60YpalTOv
         F9XA5/9GU5vRA4Spv3tOp0dKRhXXfDWa0EJcYEbddNxqSyBeiQ/Jm05e85JxM6l0ftNI
         EKkg==
X-Gm-Message-State: AOAM530PmI98/4nFM6P7Y28V/xKufVmuUoMEuAN75bZFJIX2jvA4fax9
        o0G/OP4UmfJbT8MROp/BQM0=
X-Google-Smtp-Source: ABdhPJw+gMEGSzEnPbcnU3MiJb3IdawpSAN47vBFTQm/yTkfUTWC0p+OyLrxu2Ea+wAxyHlWayJTZg==
X-Received: by 2002:a17:90a:f211:: with SMTP id bs17mr1473026pjb.74.1624398530003;
        Tue, 22 Jun 2021 14:48:50 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:9491:40e4:164d:6ab3? ([2001:df0:0:200c:9491:40e4:164d:6ab3])
        by smtp.gmail.com with ESMTPSA id 195sm250960pfw.133.2021.06.22.14.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 14:48:49 -0700 (PDT)
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
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
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133> <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133>
 <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
 <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
 <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
 <YNDsYk6kbisbNy3I@zeniv-ca.linux.org.uk>
 <CAHk-=wh82uJ5Poqby3brn-D7xWbCMnGv-JnwfO0tuRfCvsVgXA@mail.gmail.com>
 <YNEfXhi80e/VXgc9@zeniv-ca.linux.org.uk>
 <CAHk-=wjtagi3g5thA-T8ooM8AXcy3brdHzugCPU0itdbpDYH_A@mail.gmail.com>
 <87h7hpbojt.fsf@disp2133>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <20c787ec-4a3c-061c-c649-5bc3e7ef0464@gmail.com>
Date:   Wed, 23 Jun 2021 09:48:40 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87h7hpbojt.fsf@disp2133>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Eric,

On 23/06/21 9:02 am, Eric W. Biederman wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> So I was more thinking of the debug patch for m68k to catch all the
> _regular_ cases, and all the other random cases of ptrace_event() or
> ptrace_notify().
>
> Although maybe we've really caught them all. The exit case was clearly
> missing, and the thread fork case was scrogged. There are patches for
> the known problems. The patches I really don't like are the
> verification ones to find any unknown ones..
> We still have nios2 which copied the m68k logic at some point.  I think
> that is a processor that is still ``shipping'' and that people might
> still be using in new designs.
>
> I haven't looked closely enough to see what the other architectures with
> caller saved registers are doing.
>
> The challenging ones are /proc/pid/syscall and seccomp which want to see
> all of the system call arguments.  I think every architecture always
> saves the system call arguments unconditionally, so those cases are
> probably not as interesting.  But they certain look like they could be
> trouble.

Seccomp hasn't yet been implemented on m68k, though I'm working on that 
with Adrian. The sole secure_computing() call will happen in 
syscall_trace_enter(), so all system call arguments have been saved on 
the stack.

Haven't looked at /proc/pid/syscall yet ...

Cheers,

     Michael

> Eric
>
