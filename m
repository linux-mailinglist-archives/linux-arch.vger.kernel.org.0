Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACE632730D
	for <lists+linux-arch@lfdr.de>; Sun, 28 Feb 2021 16:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhB1PjK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Feb 2021 10:39:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229982AbhB1PjG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 28 Feb 2021 10:39:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6714464EB7;
        Sun, 28 Feb 2021 15:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614526705;
        bh=E7HgKVhlosJg15hIUr/EmO0wWkQU1/oxAJWlN6Q9ekM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P/8fQw14UgAojURnnhC1qXm5JxqAzrfnquPYekrFh3NAi4sK8qPbRlZmylRuamaTn
         KfLWltggn3KgBBpTilaItC7vEIrcZ1dBInjGsp5OYSDZSDZ5KqXMTsRvkhnWuJk1zl
         KWgAK2/3qAeitl9qzLmyxnBVdvgHgf98EvD6uuSIAjdHhXj/FsuJ8GVPviW8cCwl1y
         JcmNwBaXDm7ggax1X5Rro8TqH0aBFlyL7qTaMRAipOJg8/VtiA8OGEQKxQhQvLPond
         p/kATJFWq5nYiF+oDCePPfKNjVlAS/2AcUqFUQk9oJCZ9SGx4GNQfAJ8DxKlQ+6E0q
         XWjvlMgcu3ZaA==
Received: by mail-ua1-f44.google.com with SMTP id g24so4226478uaw.0;
        Sun, 28 Feb 2021 07:38:25 -0800 (PST)
X-Gm-Message-State: AOAM531Ma/Ltz5nkEPc6D4l0J8bKm/qU6g/pXksP0FU4Ux/Y+ETcT9qX
        Ibu5lWfdSKF29PRMTsDag/T6311ugxqWSjRR+yM=
X-Google-Smtp-Source: ABdhPJxIQFrXRMPgAQLkjAn4SwEcmufhxK1dfoMeqRrCI4qZ9f8WFoUQND4s8J3n6XGf/JxsJujuXs0YyGVtEJ38ahY=
X-Received: by 2002:a9d:7f11:: with SMTP id j17mr10493539otq.251.1614526704026;
 Sun, 28 Feb 2021 07:38:24 -0800 (PST)
MIME-Version: 1.0
References: <tencent_2CB9BD7D4063DE3F6845F79176B2D29A7E09@qq.com>
In-Reply-To: <tencent_2CB9BD7D4063DE3F6845F79176B2D29A7E09@qq.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 28 Feb 2021 16:38:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2TEc4CzE5Wg7pNy9Oq2p=HKNO7k2y2SmeD1mamqJ3Z9w@mail.gmail.com>
Message-ID: <CAK8P3a2TEc4CzE5Wg7pNy9Oq2p=HKNO7k2y2SmeD1mamqJ3Z9w@mail.gmail.com>
Subject: Re: [PATCH] ipc/msg: add msgsnd_timed and msgrcv_timed syscall for
 system V message queue
To:     Eric Gao <eric.tech@foxmail.com>
Cc:     "catalin.marinas" <catalin.marinas@arm.com>,
        will <will@kernel.org>, geert <geert@linux-m68k.org>,
        monstr <monstr@monstr.eu>, tsbogend <tsbogend@alpha.franken.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        deller <deller@gmx.de>, mpe <mpe@ellerman.id.au>,
        hca <hca@linux.ibm.com>, gor <gor@linux.ibm.com>,
        borntraeger <borntraeger@de.ibm.com>,
        ysato <ysato@users.sourceforge.jp>, dalias <dalias@libc.org>,
        davem <davem@davemloft.net>, luto <luto@kernel.org>,
        tglx <tglx@linutronix.de>, mingo <mingo@redhat.com>,
        bp <bp@alien8.de>, chris <chris@zankel.net>,
        jcmvbkbc <jcmvbkbc@gmail.com>, arnd <arnd@arndb.de>,
        benh <benh@kernel.crashing.org>, paulus <paulus@samba.org>,
        hpa <hpa@zytor.com>, linux-alpha <linux-alpha@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-api <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 28, 2021 at 4:16 PM Eric Gao <eric.tech@foxmail.com> wrote:
>
> Hi Arnd:
>
>             Thanks for your kindly reply.
>
>             I want to prove you and all of others that these syscalls are very useful and necessary. Actually,  I add these syscalls
>
>     when I try to implement the local rpc by system v message queue (some people might think I am crazy to using message
>
>     queue, but it's truly a very efficient method than socket except it don't have a time-controlled msgrcv syscall).

(note: please don't reply in html)

>             In addition,  msgrcv_timed is also necessary in usual bidirection communication.  For example:
> A send a message to B, and try to receive a reply  from B  by msgrcv syscall.  But A need to do
> something else in case of  that B has terminated. So
>
>     we need the msgrcv syscall return after a preset time. The similar syscall can be found in
> posix message queue(mq_timedreceive)  and in z/OS system of
>  IBM(https://www.ibm.com/support/knowledgecenter/en/SSLTBW_2.2.0/com.ibm.zos.v2r2.bpxbd00/msgrcvt.htm).
>
>   And when I search the web, I can find that many people need such like syscall in their
> applications. so I hope this patch can be merged into the mainline, Thanks a lot.

It might help to add some explanation on why you need to add the timeout
to the old sysv message queues, when the more modern posix message
queues already support this.

Is there something that mq_timedsend/mq_timedreceive cannot do that
you need? Would it be possible to add that feature to the posix message
queues instead?

> +COMPAT_SYSCALL_DEFINE5(msgsnd_timed, int, msqid, compat_uptr_t, msgp,
> +                      compat_ssize_t, msgsz, int, msgflg, compat_long_t, timeoutms)
> +{
> +       struct compat_msgbuf __user *up = compat_ptr(msgp);
> +       compat_long_t mtype;
> +
> +       timeoutms = (timeoutms + 9) / 10;
> +
> +       if (get_user(mtype, &up->mtype))
> +               return -EFAULT;
> +
> +       return do_msgsnd(msqid, mtype, up->mtext, (ssize_t)msgsz, msgflg, (long)timeoutms);
> +}
>
> My preference would be to simplify both the timed and non-timed version by
> moving the get_user() into do_msgsnd() and using in_compat_task() to pick
> the right type. Same for the receive side of course. If you do this,
> watch out for x32 support, which uses the 64-bit version.
>
>     Actually, the timed and non-timed version have different number of
>  parameter(timed version have timeoutms), so I don't
> think they can be combine together,  and I don't want to impact the
> applications which  have been using the old style msgrcv syscall.

What I meant was combining the implementation of the native and
compat versions, not combining the timed and non-timed versions,
which you already do to the degree possible.

           Arnd
