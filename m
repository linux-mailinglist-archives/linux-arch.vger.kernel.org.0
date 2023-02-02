Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5119688A14
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 23:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjBBW5Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 17:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjBBW5P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 17:57:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C1E2DE56
        for <linux-arch@vger.kernel.org>; Thu,  2 Feb 2023 14:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675378587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XMJSsnUmUwDCBuOmcITqEg5FKDzJKTZTwWrtPHX2Mzk=;
        b=GmToqAq7xdqxUKlEy3kXF8evXkmP1iurk8S1T+DCQWAbIVEdQSgk57dB6nrzaQntXbisC6
        DLJGEcvofaScDnMO0xlN+8IQLkwD6UL+eLp13Q3UVKnKRf8VJaw58Irne6FpLXZNSIozgc
        RZpuZcsRu1+28/ijnZTEh23zpW/DQbA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-387-oLfqv04YPha_tFhN0qDFXg-1; Thu, 02 Feb 2023 17:56:25 -0500
X-MC-Unique: oLfqv04YPha_tFhN0qDFXg-1
Received: by mail-qt1-f198.google.com with SMTP id f14-20020ac86ece000000b003b816f57232so1753887qtv.10
        for <linux-arch@vger.kernel.org>; Thu, 02 Feb 2023 14:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMJSsnUmUwDCBuOmcITqEg5FKDzJKTZTwWrtPHX2Mzk=;
        b=LI7F4gGc3wkLv8KsGez3Q2vNhALDnIq04eaerzLLZSsMdewv/BvlGdNN8+fAneYXA3
         AdCohwxbHr1znpTFd+1HHmZu9+YR9M7lIhkjP2ckt4dVH42GVU9GzermdxpJ6evT3fHS
         oQqWpci8gPXcFW4i85HjsdNfosXsDRSVX2F+C0jbqck5O/x1rM0wqCwdXbKkjK2HPCJP
         L7do3PKMZ7syknudvauKxgt+iXQYluaMkmRAUzZVuEt+rot4UUcPHTCnOteiewP9v9VP
         9FrlRW1W9fWmLkh3jI//nUGtWzuhn2hnh7rb/Jy1S41fQTeRjoNIB7XipnE1/zZVwSQi
         2mAw==
X-Gm-Message-State: AO0yUKWOyVNyeUKUlKWXu272VWJ0TD/n8i1da072pui73PbSQuwnGTIK
        a6VPhGRJ1TV+1rW2T0/d4HB1Q29/P3L53tIQC/fCO44SFbZTgn5By5RZALK6uQvxPHExH3TfIVp
        IXTQn9PpGl3sJ4wNdTi8n1Q==
X-Received: by 2002:a05:622a:1e10:b0:3b8:68df:fc72 with SMTP id br16-20020a05622a1e1000b003b868dffc72mr12702101qtb.2.1675378585237;
        Thu, 02 Feb 2023 14:56:25 -0800 (PST)
X-Google-Smtp-Source: AK7set98ufe9BnObmCyLO5vL17bxJ3WNbuFwrxLR6rxAVU1vknl5Zn7Dx1QXwCn46sOWBGmNV32apQ==
X-Received: by 2002:a05:622a:1e10:b0:3b8:68df:fc72 with SMTP id br16-20020a05622a1e1000b003b868dffc72mr12702061qtb.2.1675378584842;
        Thu, 02 Feb 2023 14:56:24 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id j9-20020a05620a410900b00729b7d71ac7sm661766qko.33.2023.02.02.14.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 14:56:24 -0800 (PST)
Date:   Thu, 2 Feb 2023 17:56:22 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org
Subject: Re: [RFC][PATCHSET] VM_FAULT_RETRY fixes
Message-ID: <Y9w/lrL6g4yauXz4@x1n>
References: <Y9lz6yk113LmC9SI@ZenIV>
 <CAHk-=whf73Vm2U3jyTva95ihZzefQbThZZxqZuKAF-Xjwq=G4Q@mail.gmail.com>
 <Y9mD1qp/6zm+jOME@ZenIV>
 <CAHk-=wjiwFzEGd_60H3nbgVB=R_8KTcfUJmXy=hSXCvLrXQRFA@mail.gmail.com>
 <Y9mM5wiEhepjJcN0@ZenIV>
 <CAHk-=wjNwwnBckTo8HLSdsd1ndoAR=5RBoZhdOyzhsnDAYWL9g@mail.gmail.com>
 <Y9rCBqwbLlLf1fHe@x1n>
 <Y9rlI6d5J2Y/YNQ+@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y9rlI6d5J2Y/YNQ+@ZenIV>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 01, 2023 at 10:18:11PM +0000, Al Viro wrote:
> On Wed, Feb 01, 2023 at 02:48:22PM -0500, Peter Xu wrote:
> 
> > I do also see a common pattern of the possibility to have a generic fault
> > handler like generic_page_fault().
> > 
> > It probably should start with taking the mmap_sem until providing some
> > retval that is much easier to digest further by the arch-dependent code, so
> > it can directly do something rather than parsing the bitmask in a
> > duplicated way (hence the new retval should hopefully not a bitmask anymore
> > but a "what to do").
> > 
> > Maybe it can be something like:
> > 
> > /**
> >  * enum page_fault_retval - Higher level fault retval, generalized from
> >  * vm_fault_reason above that is only used by hardware page fault handlers.
> >  * It generalizes the bitmask-versioned retval into something that the arch
> >  * dependent code should react upon.
> >  *
> >  * @PF_RET_COMPLETED:		The page fault is completed successfully
> >  * @PF_RET_BAD_AREA:		The page fault address falls in a bad area
> >  *				(e.g., vma not found, expand_stack() fails..)
> 
> FWIW, there's a fun discrepancy - VM_FAULT_SIGSEGV may yield SEGV_MAPERR
> or SEGV_ACCERR; depends upon the architecture.  Not that there'd been
> many places that return VM_FAULT_SIGSEGV these days...  Good thing, too,
> since otherwise e.g. csky would oops...
> 
> >  * @PF_RET_ACCESS_ERR:		The page fault has access errors
> >  *				(e.g., write fault on !VM_WRITE vmas)
> >  * @PF_RET_KERN_FIXUP:		The page fault requires kernel fixups
> >  *				(e.g., during copy_to_user() but fault failed?)
> >  * @PF_RET_HWPOISON:		The page fault encountered poisoned pages
> >  * @PF_RET_SIGNAL:		The page fault encountered poisoned pages
> 
> ??
> 
> >  * ...
> >  */
> > enum page_fault_retval {
> > 	PF_RET_DONE = 0,
> > 	PF_RET_BAD_AREA,
> > 	PF_RET_ACCESS_ERR,
> > 	PF_RET_KERN_FIXUP,
> >         PF_RET_HWPOISON,
> >         PF_RET_SIGNAL,
> > 	...
> > };
> > 
> > As a start we may still want to return some more information (perhaps still
> > the vm_fault_t alongside?  Or another union that will provide different
> > information based on different PF_RET_*).  One major thing is I see how we
> > handle VM_FAULT_HWPOISON and also the fact that we encode something more
> > into the bitmask on page sizes (VM_FAULT_HINDEX_MASK).
> > 
> > So the generic helper could, hopefully, hide the complexity of:
> > 
> >   - Taking and releasing of mmap lock
> >   - find_vma(), and also relevant checks on access or stack handling
> 
> Umm...  arm is a bit special here:
>                 if (addr < FIRST_USER_ADDRESS)
> 			return VM_FAULT_BADMAP;
> with no counterparts elsewhere.

For this specific case IIUC it's the same as bad_area.  VM_FAULT_BADMAP is
further handled later in do_page_fault() there for either arm/arm64.

This reminded me this, on how arm defines the private retvals, while the
generic ones grows and probably no one noticed they can collapse already..

#define VM_FAULT_BADMAP		0x010000
#define VM_FAULT_BADACCESS	0x020000

enum vm_fault_reason {
        ...
	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
};

VM_FAULT_HINDEX_MASK is only used by VM_FAULT_HWPOISON_LARGE, so I think
arm[64] could expect some surprise when it hit hugetlb hwpoison pages...
maybe I should prepare a patch for arm.

> 
> >   - handle_mm_fault() itself (of course...)
> >   - detect signals
> >   - handle page fault retries (so, in the new layer of retval there should
> >     have nothing telling it to retry; it should always be the ultimate result)
> 
> agreed.
> 
>     - unlock mmap; don't leave that to caller.
> 
> >   - parse different errors into "what the arch code should do", and
> >     generalize the common ones, e.g.
> >     - OOM, do pagefault_out_of_memory() for user-mode
> >     - VM_FAULT_SIGSEGV, which should be able to merge into PF_RET_BAD_AREA?
> >     - ...
> 
> AFAICS, all errors in kernel mode => no_context.
> 
> > It'll simplify things if we can unify some small details like whether the
> > -EFAULT above should contain a sigbus.
> > 
> > A trivial detail I found when I was looking at this is, x86_64 passes in
> > different signals to kernelmode_fixup_or_oops() - in do_user_addr_fault()
> > there're three call sites and each of them pass over a differerent signal.
> > IIUC that will only make a difference if there's a nested page fault during
> > the vsyscall emulation (but I may be wrong too because I'm new to this
> > code), and I have no idea when it'll happen and whether that needs to be
> > strictly followed.
> 
> From my (very incomplete so far) dig through that pile:
> 	Q: do we still have the cases when handle_mm_fault() does
> not return any of VM_FAULT_COMPLETED | VM_FAULT_RETRY | VM_FAULT_ERROR?
> That gets treated as unlock + VM_FAULT_COMPLETED, but do we still need
> that?
> 	Q: can VM_FAULT_RETRY be mixed with anything in VM_FAULT_ERROR?
> What locking, if that happens?

For this one, I don't think they can be mixed.  IMHO RETRY only binds with
a wait, so if we didn't wait and found issue, we return ERROR; if we
decided to wait, we will try nothing more besides return after wait with
the RETRY.  We should just never check any error at all if the wait
happened.  Otherwise there's a bug of potential deadlock.

I'll skip some details in this email either above or below; I agree
there're so many trivial details to take care of to not break a thing.

IMHO it'll be merely impossible to merge things across most (if not to say,
all) archs.  It will need to be start from one or at least a few that still
shares a major common base - I would still rely on x86 as a start - then we
try to use the helper in as much archs as possible.

Even on x86, I do also see challenges so I'm not sure whether a common
enough routine can be abstracted indeed.  But I believe there's a way to do
this because obviously we still see tons of duplicated logics falling
around.  It may definitely need time to think out where's the best spot to
start, and how to gradually move towards covering more archs starting from
one.

Thanks,

> 	* details of storing the fault details (for ptrace, mostly)
> vary a lot; no chance to unify, AFAICS.
> 	* requirements for vma flags also differ; e.g. read fault on
> alpha is explicitly OK with absence of VM_READ if VM_WRITE is there.
> Probably should go by way of arm and pass the mask that must
> have non-empty intersection with vma->vm_flags?  Because *that*
> is very likely to be a part of ABI - mmap(2) callers that rely
> upon the flags being OK for given architecture are quite possible.
> 	* mmap lock is also quite variable in how it's taken;
> x86 and arm have fun dance with trylock/search for exception handler/etc.
> Other architectures do not; OTOH, there's a prefetch stuck in itanic
> variant, with comment about mmap_sem being performance-critical...
> 	* logics for stack expansion includes this twist:
>         if (!(vma->vm_flags & VM_GROWSDOWN))
>                 goto map_err;
>         if (user_mode(regs)) {
>                 /* Accessing the stack below usp is always a bug.  The
>                    "+ 256" is there due to some instructions doing
>                    pre-decrement on the stack and that doesn't show up
>                    until later.  */
>                 if (address + 256 < rdusp())
>                         goto map_err;
>         }
>         if (expand_stack(vma, address))
>                 goto map_err;
> That's m68k; ISTR similar considerations elsewhere, but I could be
> wrong.
> 

-- 
Peter Xu

