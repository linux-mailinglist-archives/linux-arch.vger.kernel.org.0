Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B47166AF7
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 00:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgBTX3c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Feb 2020 18:29:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41814 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTX3c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Feb 2020 18:29:32 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4vG5-00G2iY-L0; Thu, 20 Feb 2020 23:29:29 +0000
Date:   Thu, 20 Feb 2020 23:29:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] regset ->get() API
Message-ID: <20200220232929.GU23230@ZenIV.linux.org.uk>
References: <20200217183340.GI23230@ZenIV.linux.org.uk>
 <CAHk-=wivKU1eP8ir4q5xEwOV0hsomFz7DMtiAot__X2zU-yGog@mail.gmail.com>
 <20200220224707.GQ23230@ZenIV.linux.org.uk>
 <CAHk-=wiKs7Q2DbP6kk8JQksb0nhUvAs2wO5cNdWirNEc3CM-YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiKs7Q2DbP6kk8JQksb0nhUvAs2wO5cNdWirNEc3CM-YQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 20, 2020 at 02:56:28PM -0800, Linus Torvalds wrote:
> On Thu, Feb 20, 2020 at 2:47 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Wed, Feb 19, 2020 at 12:01:54PM -0800, Linus Torvalds wrote:
> >
> > > I don't mind it, but some of those buffers are big, and the generic
> > > code generally doesn't know how big.
> >
> > That's what regset_size() returns...
> 
> Yes, but the code ends up being disgusting. You first have to call
> that indirect function just to get the size, then do a kmalloc, and
> then call another indirect function to actually fill it.

Umm...  You do realize that this indirect function is a pathological
case, right?  It has exactly one user - REGSET_SVE on arm64.  Everything
else uses regset->n * regset->size.

> Don't do that. Not since we know how retpoline is a bad thing.
> 
> And since the size isn't always some trivial constant (ie for x86 PFU
> it depends on the register state!), I think the only sane model is to
> change the interface even more, and just have the "get()" function not
> only get the data, but allocate the backing store too.
> 
> So you'd never pass in the result pointer - you'd get a result area
> that you can then free.
> 
> Hmm?

Do you want such allocations done in each ->get() instance?  We have
a plenty of those instances...

> > FWIW, what I have in mind is to start with making copy_regset_to_user() do
> >         buf = kmalloc(size, GFP_KERNEL);
> >         if (!buf)
> >                 return -ENOMEM;
> >         err = regset->get(target, regset, offset, size, buf, NULL);
> 
> See above. This doesn't work. You don't know the size. And we don't
> have a known maximum size either.

We do know that caller does not want more than the value it has passed in
'size' argument, though.  For existing ptrace requests it's either
min(iov->iov_len, regset->n * regset->size) (in ptrace_regset())
or an explicit constant (usually in arch_ptrace()).  Note, BTW, that
regset_size() is used only by coredump - that's how much we allocate
there.  Everybody else either looks like
        case PTRACE_GETFPREGS:  /* Get the child FPU state. */
                return copy_regset_to_user(child,
                                           task_user_regset_view(current),
                                           REGSET_FP,
                                           0, sizeof(struct user_i387_struct),
                                           datap);
or does regset->n * regset->size.

FWIW, the real need to know the size is not in "how much do we allocated" -
it's "how much do we copy"; I _think_ everyone except that arm64 thing
fills exactly regset->n * regset->size (or we have a nasty infoleak in
coredumps) and we can switch coredump to "allocate regset->n * regset->size,
call ->get(), copy all of that into coredump unless ->get_size is there,
copy ->get_size() bytes to coredump if ->get_size exists" as the first
step.

Longer term I would have ->get() tell how much has it filled and killed
->get_size().  Again, there's only one user.  But I'd prefer to do that
in the end of series, when the bodies of ->get() instances are cleaned
up...
