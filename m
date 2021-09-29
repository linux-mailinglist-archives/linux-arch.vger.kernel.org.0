Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFB041CCE4
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 21:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345554AbhI2Tv4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 15:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345549AbhI2Tvz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Sep 2021 15:51:55 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139E1C061765
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 12:50:14 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id u11so2435745uaw.3
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 12:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBnrGvzpOalQc1rPribEAYXuOJwtyiiHK62RY8KenlQ=;
        b=FPpe9Q2b5DHrn+WU3m/hxinNK1e2liJ1oeJrapwYERV0E/AYiaPqvZbfZ6cCY9iyVJ
         pSBU1F5N4Sk12cZGG1pVPmwTcujDy2cdrRKvtB96L57xvYeDqkBaBbXjlnGKdW7L/oPb
         ZacTI5cC1E9LHyQC5hE6MAi4ciTqztlBodzgRmmYG2npIlCV7gEVJdxyqPyEqFe537zs
         KV7Kr14rOvqwaB44iBwRD4IlLKofhntmC8zmidYWlF6FOv3jnpro2aLENCkfyKlVDlzQ
         R1t+zWQKQMupARPaCow97jyA8pg/1azfyGCCQyBeCvMqRKbV6jj0efl79zwCL82ncNqH
         YOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBnrGvzpOalQc1rPribEAYXuOJwtyiiHK62RY8KenlQ=;
        b=WrI+2a7BrxUeTFdVcTD4grJIgPqT2rs5SDeA/sEDMS4PYQm41elpQXlFLcmgJZPa0F
         Lmugw94eGf9oxpBfWj8jsUJLp346Hyc+oiHO4Jb3DYzupvQtXywdUuZCVkQzfAhq3A/l
         5KZFDlUfktZQQMzd4xChlTADDBERFi9VGrWoM3unpx51mMA6DAGxamvON8QkkE4ve5vX
         cDSZeSAlTvJH3WkvExQWkIBRslBuewOSiQqhZQE7nVzNe6cyyZkju30okN+PMxtSLI3Q
         NcMihci1KM7h+Bvy+mQ8zkzwV1sq/Dy9kViSbCu7ZxcDzWNydAwvJiAqd5U1VliiWl0a
         dA6g==
X-Gm-Message-State: AOAM532IWHtoSkeyl8M+ZckKxLqSIg8rJv3BrXfBKc56YxWoZzwSaq59
        RCQ6X7gWws5Wl0kDFMWhuDYlOcR0kjxts5stVZ9Ixg==
X-Google-Smtp-Source: ABdhPJxvKbLjTzwtXdtwANfFqJi0bFsVEXnzUaJ+/sJGfQYpol+wq4iDhalq4ZNwFCygTZNPtiS6r0YiyiUBwNVGYQA=
X-Received: by 2002:a9f:301c:: with SMTP id h28mr2249241uab.58.1632945012871;
 Wed, 29 Sep 2021 12:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210913183753.563103-1-ramjiyani@google.com> <x494ka39rc7.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x494ka39rc7.fsf@segfault.boston.devel.redhat.com>
From:   Ramji Jiyani <ramjiyani@google.com>
Date:   Wed, 29 Sep 2021 12:50:01 -0700
Message-ID: <CAKUd0B_TCXRY4h1hTztfwWbNSFQqsudDLn2S_28csgWZmZAG3Q@mail.gmail.com>
Subject: Re: [PATCH] aio: Add support for the POLLFREE
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        oleg@redhat.com, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Jeff:

Thanks for the response.

On Wed, Sep 29, 2021 at 11:18 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Adding Oleg and Christoph.
>
> Ramji Jiyani <ramjiyani@google.com> writes:
>
> > Commit f5cb779ba163 ("ANDROID: binder: remove waitqueue when thread
> > exits.") fixed the use-after-free in eventpoll but aio still has the
> > same issue because it doesn't honor the POLLFREE flag.
> >
> > Add support for the POLLFREE flag to force complete iocb inline in
> > aio_poll_wake(). A thread may use it to signal it's exit and/or request
> > to cleanup while pending poll request. In this case, aio_poll_wake()
> > needs to make sure it doesn't keep any reference to the queue entry
> > before returning from wake to avoid possible use after free via
> > poll_cancel() path.
>
> Is this an in-kernel user?

Yes, an in-kernel user here is android binder.

> Can you explain more about how or when this
> happens?  Do you have a stack trace that shows the problem?

This is to fix a use after free issue between binder thread and aio
interactions.

Suppose we poll a binder file through aio. The poll inserts a wait_queue_entry
into the wait_queue_head list associated with the file. And it takes a
reference on the binder file, so it can't go away. The poll then returns to
userspace while poll operation remains pending (async io).

So after starting the poll, we can run BINDER_THREAD_EXIT to free the wait
queue head.The aio poll is still queued though, so aio will UAF the queue head.

Here are the simplified codes to sequence of events in which case UAF occurs.

static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
                void *key)
{
         if (mask && !(mask & req->events))    // (1)
                return 0;

        list_del_init(&req->wait.entry);      // (2)

        if (mask && spin_trylock_irqsave(&iocb->ki_ctx->ctx_lock, flags)) {
                // complete request now
                list_del(&iocb->ki_list);     // (3)
                ...
        } else {
                // complete later
                schedule_work(&req->work);    // (4)
        }
        return 1;
}

In check (1), mask has EPOLLHUP from binder and actually req->events will
always have EPOLLHUP as well (this is set unconditionally in aio_poll()).
So we proceed to (2), which unlinks the wait queue entry. Next, we complete
the request either right now (3) or later with scheduled work (4), depending
on whether the trylock of ctx_lock succeeds.

It turns out that UAF is possible in case (4), where the request remains linked
through ki_list. This allows io_cancel() to find and cancel the request:

static int aio_poll_cancel(struct kiocb *iocb)
{
        ...

        spin_lock(&req->head->lock);                // (5)
        WRITE_ONCE(req->cancelled, true);
        if (!list_empty(&req->wait.entry)) {
                list_del_init(&req->wait.entry);    // (6)
                schedule_work(&aiocb->poll.work);
        }
        spin_unlock(&req->head->lock);

        return 0;
}

The list_del_init() at (6) would UAF, but the wait queue entry was already
unlinked, so this is unreachable. But req->head in (5) also points to the
freed queue head, so spin_lock() will still UAF.

There was a similar issue with eventpoll. Unlike aio's aio_poll_wake()
eventpoll's
ep_poll_callback() honors the POLLFREE flag. It makes sure that both the queue
entry is unlinked and the queue head pointer is cleared in case of POLLFREE.

The patch is introducing the POLLFREE in which case the request needs to be
honored inline as the reference may not be valid in future time when the worker
thread gets to it.

> I'm not sure this use of POLLFREE exactly follows with the initial intention of
> the flag, but hopefully Oleg can comment on that.
>
> Thanks,
> Jeff

Thanks,
Ram

>
> > The POLLFREE flag is no more exclusive to the epoll and is being
> > shared with the aio. Remove comment from poll.h to avoid confusion.
> > Also enclosed the POLLFREE macro definition in parentheses to fix
> > checkpatch error.
> >
> > Signed-off-by: Ramji Jiyani <ramjiyani@google.com>
> > ---
> >  fs/aio.c                        | 45 ++++++++++++++++++---------------
> >  include/uapi/asm-generic/poll.h |  2 +-
> >  2 files changed, 26 insertions(+), 21 deletions(-)
> >
> > diff --git a/fs/aio.c b/fs/aio.c
> > index 51b08ab01dff..5d539c05df42 100644
> > --- a/fs/aio.c
> > +++ b/fs/aio.c
> > @@ -1674,6 +1674,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
> >  {
> >       struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
> >       struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
> > +     struct kioctx *ctx = iocb->ki_ctx;
> >       __poll_t mask = key_to_poll(key);
> >       unsigned long flags;
> >
> > @@ -1683,29 +1684,33 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
> >
> >       list_del_init(&req->wait.entry);
> >
> > -     if (mask && spin_trylock_irqsave(&iocb->ki_ctx->ctx_lock, flags)) {
> > -             struct kioctx *ctx = iocb->ki_ctx;
> > +     /*
> > +      * Use irqsave/irqrestore because not all filesystems (e.g. fuse)
> > +      * call this function with IRQs disabled and because IRQs have to
> > +      * be disabled before ctx_lock is obtained.
> > +      */
> > +     if (mask & POLLFREE) {
> > +             /* Force complete iocb inline to remove refs to deleted entry */
> > +             spin_lock_irqsave(&ctx->ctx_lock, flags);
> > +     } else if (!(mask && spin_trylock_irqsave(&ctx->ctx_lock, flags))) {
> > +             /* Can't complete iocb inline; schedule for later */
> > +             schedule_work(&req->work);
> > +             return 1;
> > +     }
> >
> > -             /*
> > -              * Try to complete the iocb inline if we can. Use
> > -              * irqsave/irqrestore because not all filesystems (e.g. fuse)
> > -              * call this function with IRQs disabled and because IRQs
> > -              * have to be disabled before ctx_lock is obtained.
> > -              */
> > -             list_del(&iocb->ki_list);
> > -             iocb->ki_res.res = mangle_poll(mask);
> > -             req->done = true;
> > -             if (iocb->ki_eventfd && eventfd_signal_allowed()) {
> > -                     iocb = NULL;
> > -                     INIT_WORK(&req->work, aio_poll_put_work);
> > -                     schedule_work(&req->work);
> > -             }
> > -             spin_unlock_irqrestore(&ctx->ctx_lock, flags);
> > -             if (iocb)
> > -                     iocb_put(iocb);
> > -     } else {
> > +     /* complete iocb inline */
> > +     list_del(&iocb->ki_list);
> > +     iocb->ki_res.res = mangle_poll(mask);
> > +     req->done = true;
> > +     if (iocb->ki_eventfd && eventfd_signal_allowed()) {
> > +             iocb = NULL;
> > +             INIT_WORK(&req->work, aio_poll_put_work);
> >               schedule_work(&req->work);
> >       }
> > +     spin_unlock_irqrestore(&ctx->ctx_lock, flags);
> > +     if (iocb)
> > +             iocb_put(iocb);
> > +
> >       return 1;
> >  }
> >
> > diff --git a/include/uapi/asm-generic/poll.h b/include/uapi/asm-generic/poll.h
> > index 41b509f410bf..35b1b69af729 100644
> > --- a/include/uapi/asm-generic/poll.h
> > +++ b/include/uapi/asm-generic/poll.h
> > @@ -29,7 +29,7 @@
> >  #define POLLRDHUP       0x2000
> >  #endif
> >
> > -#define POLLFREE     (__force __poll_t)0x4000        /* currently only for epoll */
> > +#define POLLFREE     ((__force __poll_t)0x4000)
> >
> >  #define POLL_BUSY_LOOP       (__force __poll_t)0x8000
>
