Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A098D6870E5
	for <lists+linux-arch@lfdr.de>; Wed,  1 Feb 2023 23:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjBAWST (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Feb 2023 17:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjBAWSS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2023 17:18:18 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E746B46E;
        Wed,  1 Feb 2023 14:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HeRJm8KctCrX0oOm/Y7Yhl6b2oWkUrXelanwq9cuW04=; b=s3yDBojwIW+WM0sj9TfKGsKeVt
        1zdWY36xsTGCDIJSSRer+NXnDlrlVZbUebN/+LRLQk0M3+EJVyJsoALTrbiZEImwAHs0f45oS9z8g
        /PWZ7U63m3EKmuohEA5H9VFevg7AkoNZrIpQxD/4CjdnbvXiVL5HxesWGUsCEKCOfg1d+HfE4U1fp
        pfI2jNiCFcdefEoV5mv1vReIcXZMrCnLgX7EJycvGntMjZEpBHZxtfL74GlqXuIjVmiZNck9lLThr
        blwe/5yHxKuLVnP3D+qY95y5ndViv4oUnFbMBYnPQyeOFAIAKAt4HzRtn3naJhxRZZDhKMo5yMEsr
        3beybxdg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pNLQh-005XXV-0t;
        Wed, 01 Feb 2023 22:18:11 +0000
Date:   Wed, 1 Feb 2023 22:18:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Peter Xu <peterx@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org
Subject: Re: [RFC][PATCHSET] VM_FAULT_RETRY fixes
Message-ID: <Y9rlI6d5J2Y/YNQ+@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV>
 <CAHk-=whf73Vm2U3jyTva95ihZzefQbThZZxqZuKAF-Xjwq=G4Q@mail.gmail.com>
 <Y9mD1qp/6zm+jOME@ZenIV>
 <CAHk-=wjiwFzEGd_60H3nbgVB=R_8KTcfUJmXy=hSXCvLrXQRFA@mail.gmail.com>
 <Y9mM5wiEhepjJcN0@ZenIV>
 <CAHk-=wjNwwnBckTo8HLSdsd1ndoAR=5RBoZhdOyzhsnDAYWL9g@mail.gmail.com>
 <Y9rCBqwbLlLf1fHe@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9rCBqwbLlLf1fHe@x1n>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 01, 2023 at 02:48:22PM -0500, Peter Xu wrote:

> I do also see a common pattern of the possibility to have a generic fault
> handler like generic_page_fault().
> 
> It probably should start with taking the mmap_sem until providing some
> retval that is much easier to digest further by the arch-dependent code, so
> it can directly do something rather than parsing the bitmask in a
> duplicated way (hence the new retval should hopefully not a bitmask anymore
> but a "what to do").
> 
> Maybe it can be something like:
> 
> /**
>  * enum page_fault_retval - Higher level fault retval, generalized from
>  * vm_fault_reason above that is only used by hardware page fault handlers.
>  * It generalizes the bitmask-versioned retval into something that the arch
>  * dependent code should react upon.
>  *
>  * @PF_RET_COMPLETED:		The page fault is completed successfully
>  * @PF_RET_BAD_AREA:		The page fault address falls in a bad area
>  *				(e.g., vma not found, expand_stack() fails..)

FWIW, there's a fun discrepancy - VM_FAULT_SIGSEGV may yield SEGV_MAPERR
or SEGV_ACCERR; depends upon the architecture.  Not that there'd been
many places that return VM_FAULT_SIGSEGV these days...  Good thing, too,
since otherwise e.g. csky would oops...

>  * @PF_RET_ACCESS_ERR:		The page fault has access errors
>  *				(e.g., write fault on !VM_WRITE vmas)
>  * @PF_RET_KERN_FIXUP:		The page fault requires kernel fixups
>  *				(e.g., during copy_to_user() but fault failed?)
>  * @PF_RET_HWPOISON:		The page fault encountered poisoned pages
>  * @PF_RET_SIGNAL:		The page fault encountered poisoned pages

??

>  * ...
>  */
> enum page_fault_retval {
> 	PF_RET_DONE = 0,
> 	PF_RET_BAD_AREA,
> 	PF_RET_ACCESS_ERR,
> 	PF_RET_KERN_FIXUP,
>         PF_RET_HWPOISON,
>         PF_RET_SIGNAL,
> 	...
> };
> 
> As a start we may still want to return some more information (perhaps still
> the vm_fault_t alongside?  Or another union that will provide different
> information based on different PF_RET_*).  One major thing is I see how we
> handle VM_FAULT_HWPOISON and also the fact that we encode something more
> into the bitmask on page sizes (VM_FAULT_HINDEX_MASK).
> 
> So the generic helper could, hopefully, hide the complexity of:
> 
>   - Taking and releasing of mmap lock
>   - find_vma(), and also relevant checks on access or stack handling

Umm...  arm is a bit special here:
                if (addr < FIRST_USER_ADDRESS)
			return VM_FAULT_BADMAP;
with no counterparts elsewhere.

>   - handle_mm_fault() itself (of course...)
>   - detect signals
>   - handle page fault retries (so, in the new layer of retval there should
>     have nothing telling it to retry; it should always be the ultimate result)

agreed.

    - unlock mmap; don't leave that to caller.

>   - parse different errors into "what the arch code should do", and
>     generalize the common ones, e.g.
>     - OOM, do pagefault_out_of_memory() for user-mode
>     - VM_FAULT_SIGSEGV, which should be able to merge into PF_RET_BAD_AREA?
>     - ...

AFAICS, all errors in kernel mode => no_context.

> It'll simplify things if we can unify some small details like whether the
> -EFAULT above should contain a sigbus.
> 
> A trivial detail I found when I was looking at this is, x86_64 passes in
> different signals to kernelmode_fixup_or_oops() - in do_user_addr_fault()
> there're three call sites and each of them pass over a differerent signal.
> IIUC that will only make a difference if there's a nested page fault during
> the vsyscall emulation (but I may be wrong too because I'm new to this
> code), and I have no idea when it'll happen and whether that needs to be
> strictly followed.

From my (very incomplete so far) dig through that pile:
	Q: do we still have the cases when handle_mm_fault() does
not return any of VM_FAULT_COMPLETED | VM_FAULT_RETRY | VM_FAULT_ERROR?
That gets treated as unlock + VM_FAULT_COMPLETED, but do we still need
that?
	Q: can VM_FAULT_RETRY be mixed with anything in VM_FAULT_ERROR?
What locking, if that happens?
	* details of storing the fault details (for ptrace, mostly)
vary a lot; no chance to unify, AFAICS.
	* requirements for vma flags also differ; e.g. read fault on
alpha is explicitly OK with absence of VM_READ if VM_WRITE is there.
Probably should go by way of arm and pass the mask that must
have non-empty intersection with vma->vm_flags?  Because *that*
is very likely to be a part of ABI - mmap(2) callers that rely
upon the flags being OK for given architecture are quite possible.
	* mmap lock is also quite variable in how it's taken;
x86 and arm have fun dance with trylock/search for exception handler/etc.
Other architectures do not; OTOH, there's a prefetch stuck in itanic
variant, with comment about mmap_sem being performance-critical...
	* logics for stack expansion includes this twist:
        if (!(vma->vm_flags & VM_GROWSDOWN))
                goto map_err;
        if (user_mode(regs)) {
                /* Accessing the stack below usp is always a bug.  The
                   "+ 256" is there due to some instructions doing
                   pre-decrement on the stack and that doesn't show up
                   until later.  */
                if (address + 256 < rdusp())
                        goto map_err;
        }
        if (expand_stack(vma, address))
                goto map_err;
That's m68k; ISTR similar considerations elsewhere, but I could be
wrong.
