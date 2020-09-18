Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE28326FF66
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 16:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgIRN7w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 09:59:52 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:45485 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgIRN7w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 09:59:52 -0400
Received: from mail-qv1-f41.google.com ([209.85.219.41]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MlNYj-1kkrOA2cLF-00lmqY; Fri, 18 Sep 2020 15:59:47 +0200
Received: by mail-qv1-f41.google.com with SMTP id db4so2894478qvb.4;
        Fri, 18 Sep 2020 06:59:46 -0700 (PDT)
X-Gm-Message-State: AOAM533TJj5xT1n4e1bGgoqAoKlLC4z2QSZZqgUFd8vCugbyjSOe/IMS
        LVJQfW9Jog9OO5NB/Qqhi5Sm/YLe2Qbzf4Y/Ous=
X-Google-Smtp-Source: ABdhPJyPq7mySMvROlaNxuZFtqLj9tUV6q55niOILmDEkx6ztioH5FRFrOH6npOQU7X7q9Cy/nZY2UELvp9CUKm70dc=
X-Received: by 2002:a0c:b39a:: with SMTP id t26mr2701457qve.19.1600437585347;
 Fri, 18 Sep 2020 06:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200918124533.3487701-1-hch@lst.de> <20200918124533.3487701-2-hch@lst.de>
 <20200918134012.GY3421308@ZenIV.linux.org.uk> <20200918134406.GA17064@lst.de>
In-Reply-To: <20200918134406.GA17064@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Sep 2020 15:59:29 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3_DL0T33e7CAuyRxgpRy8LaJO9h1sER7sebcX26hVVjA@mail.gmail.com>
Message-ID: <CAK8P3a3_DL0T33e7CAuyRxgpRy8LaJO9h1sER7sebcX26hVVjA@mail.gmail.com>
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Howells <dhowells@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>, io-uring@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Networking <netdev@vger.kernel.org>, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5bsXb+NC+lllYzcUOGgsO10SuiSw9kHorG4pcD07lr3QFbCWqJR
 Hd2vOtRjq6zM6dfC422gwtrcI3R5GCUojEo3h2z2kZfRtoDGJYgYE+Le/OiYLQ+AfYeJUc7
 KH3vEAyJZtGCUGYSkFwn1WnE2X3RbGV559CUsPqRgam5BOOvyh/QhpykfzE/YedWzwiNxtY
 wiICue+oltyvAbFBEi/NQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vts7PmwMxSk=:IMvx1hKzNbDXYdyWvbrSQ4
 jLaSwDylFHEDOA8IPoxpYU5cKueImUqIkNFHkuBZNfWWc0NGvvft1Zes0SnfBRhXUXionjozF
 B9nnJcW7efiDHOEd3Q177Hp1WSvU7ckTL98ZDOWcmqO6Yit534ppgWzApN7ucDooK96fe7qcE
 AV6sk/JopCOXXQ3EZFZetpxCBv1ro/Qy2qnh+1judoRnoYHeHiF0npYy9I/6E/SLOkJTSFE8P
 fnf8pQXmOJ27iJ2JoD+rfK8cyLD8kDY90UU36yHWtfGe5OVn9THUViK9NNgBozrztLgL+3XYt
 dn753ya6FwCzzH9RvbESESQsHI+Po48j8OyU9Z+ymEbgK/VUpiSpLbQ1pVmEQBw5xS2NtmePD
 aA+Ver2IdLyuTg0hWd/yx3HoF/oHaGtrzQ3Q+YLE8OTExF8g7xZlL2vD7Ix4HyQm/wKN/oQ1k
 GqnnBeXsn15L9rqlHeWFXXSHfvAfEYrWX3iJg6vIFPArBI8MAE7Uw1aq5btj6ApgIlVyHqM66
 2Xn76Ow3QdZO0ho4m6JFqb5rw1tiTjqgopxaekvvQDkeMVKInl/i/ehUcKxWRVvHMvjy/vOnx
 LCmYnCKJn7N6lg99SBATreDgI7GPoJz9F2OpT/97+Ti/aTh95adpj1hvDoOj6Q9Qeoi8K5sBE
 GU5ACP5dOra7GF2QCAo/nFhzheJXtdc63rfWO0ApGnvZKXo++h+Lu50OnW6e93yCMSwX/cxBw
 RkqjAiAxuy63Jm0Ni9RNDcCQUYsVgny6VJI43TvtI6rFBu219c1/E8ymSAeP73YyIvn3Db2MY
 8SH38FGfjs35fsjJp2RR6CgAMzwGAYUNK1BK8yqHvLJyCw09w6A7Kr9mUB61xC3tFlh7LHOGD
 3y2Pqr/E9pq2fpFKpEPpDqL0ZF6jMRyGFYnx159+1ZrTvBgCxTEbeqv7Qq/qA9NYGfetzPWfQ
 EcfF8egNixSzusL10IX7QlVARDhAlELPRnwMujzRc/Xd0L6NIrWMR
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 18, 2020 at 3:44 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Sep 18, 2020 at 02:40:12PM +0100, Al Viro wrote:
> > >     /* Vector 0x110 is LINUX_32BIT_SYSCALL_TRAP */
> > > -   return pt_regs_trap_type(current_pt_regs()) == 0x110;
> > > +   return pt_regs_trap_type(current_pt_regs()) == 0x110 ||
> > > +           (current->flags & PF_FORCE_COMPAT);
> >
> > Can't say I like that approach ;-/  Reasoning about the behaviour is much
> > harder when it's controlled like that - witness set_fs() shite...
>
> I don't particularly like it either.  But do you have a better idea
> how to deal with io_uring vs compat tasks?

Do we need to worry about something other than the compat_iovec
struct for now? Regarding the code in io_import_iovec(), it would
seem that can easily be handled by exposing an internal helper.
Instead of

#ifdef CONFIG_COMPAT
     if (req->ctx->compat)
            return compat_import_iovec(rw, buf, sqe_len, UIO_FASTIOV,
iovec, iter);
#endif
        return import_iovec(rw, buf, sqe_len, UIO_FASTIOV, iovec, iter);

This could do

    __import_iovec(rw, buf, sqe_len, UIO_FASTIOV, iovec,
                     iter, req->ctx->compat);

With the normal import_iovec() becoming a trivial wrapper around
the same thing:

ssize_t import_iovec(int type, const struct iovec __user * uvector,
                 unsigned nr_segs, unsigned fast_segs,
                 struct iovec **iov, struct iov_iter *i)
{
     return __import_iovec(type, uvector, nr_segs, fast_segs, iov,
              i, in_compat_syscall());
}


         Arnd
