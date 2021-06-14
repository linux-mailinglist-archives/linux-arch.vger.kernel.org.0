Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462C03A5C56
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jun 2021 07:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhFNFHA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 01:07:00 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:43520 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhFNFHA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jun 2021 01:07:00 -0400
Received: by mail-pj1-f47.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso9410543pjp.2;
        Sun, 13 Jun 2021 22:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=/Shcl0CcwcVQvnqm4kjruvfteHB5V70Bgq+EW67+hVs=;
        b=B5SBMSbjT8JJZ0clP7225Gi2clR3Q4OchlvIiY/CVvOS/s3gFjPf0ybYVRqwbIG/dZ
         Y8fJHjfu8wY1guNyM/wNNFbHK+cMl/eMbnj3TVjh8v7tBKbjRrt5ivQORq0NjueN9QXa
         x6x0nPCYp+HfTubRj1wmV4idu6a/kvc2wnsRx5LyQ7CLvBsu7qQIu6s5MRo+cSTHs51z
         FJRDLeLVosLvWgeGb5rV8piHUEoVvgaZ8PYvVHCrSOExft7bgqRESMuQ+KAxHiCu22A+
         lSmXN9GdGs/9vgPpg0Md5tu3/RxBd29BWkXJYO1MPH6PcllXlp8hVlnIvMHJQm5foksZ
         Ue2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=/Shcl0CcwcVQvnqm4kjruvfteHB5V70Bgq+EW67+hVs=;
        b=nYlaa/HjpO0M/neBiKxWue1+wsMdMK072kksKmmnOZA/KzqXvuIDK7AO/HbuAK5r4y
         g4kamt+x37eIKCptFnACQlfA9V8yzkMcG2kAgdlws8IcqbNx50vRl8u9jszq7H1jt+Oa
         gaUaXpnVrlodd9Q7B3DZ3EfZrlBSVAHmHD2rJed2WOhdB7Xxso+cQWgX3uhRASnWpkid
         ajFIerMwBzfKa6ph2K06+jL82cLVwBU9KznzX6M2HK0OeWDOfi0kxPTI1c+qEe0Lgtzz
         dlsHQVYs30gKzLBdBMmnj+uFEYhOCpRWER16UTZc0+kdx9X81uRM9e317XjJtC2LLk+U
         JNTg==
X-Gm-Message-State: AOAM532UOoaAm9meOUGld+gwnZv8j1coeBKn3hJePpGvgiyXoLLywLda
        6ilf53UIXSpBEJzF9nWjqH0=
X-Google-Smtp-Source: ABdhPJwkPl8QjSwHR1OhgiNQGW21SvV1YCn2jXTQrmZjnukE9TtSBBVhBqVhbHYh9Co4wob1faZfnQ==
X-Received: by 2002:a17:902:8307:b029:103:c733:e5e0 with SMTP id bd7-20020a1709028307b0290103c733e5e0mr15280288plb.8.1623647023369;
        Sun, 13 Jun 2021 22:03:43 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id b5sm5251727pfp.102.2021.06.13.22.03.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jun 2021 22:03:42 -0700 (PDT)
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <87sg1p30a1.fsf@disp2133>
 <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
 <87pmwsytb3.fsf@disp2133>
 <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133>
 <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
Date:   Mon, 14 Jun 2021 17:03:32 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On second thought, I'm not certain what adding another empty stack frame 
would achieve here.

On m68k, 'frame' already is a new stack frame, for running the new 
thread in. This new frame does not have any user context at all, and 
it's explicitly wiped anyway.

Unless we save all user context on the stack, then push that context to 
a new save frame, and somehow point get_signal to look there for IO 
threads (essentially what Eric suggested), I don't see how this could work?

I must be missing something.

Cheers,

	Michael Schmitz

Am 14.06.2021 um 14:05 schrieb Michael Schmitz:
>>
>> I wouldn't be surprised if m68k has the exact same thing for the exact
>> same reason, but I didn't check..
>
> m68k is indeed similar, it has:
>
>        if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
>                 /* kernel thread */
>                 memset(frame, 0, sizeof(struct fork_frame));
>                 frame->regs.sr = PS_S;
>                 frame->sw.a3 = usp; /* function */
>                 frame->sw.d7 = arg;
>                 frame->sw.retpc = (unsigned long)ret_from_kernel_thread;
>                 p->thread.usp = 0;
>                 return 0;
>         }
>
> so a similar patch should be possible.
>
> Cheers,
>
>     Michael
>
>
>
>>
>>                    Linus
