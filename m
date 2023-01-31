Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42416838E4
	for <lists+linux-arch@lfdr.de>; Tue, 31 Jan 2023 22:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjAaVtc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Jan 2023 16:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjAaVtb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 16:49:31 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A32B7680;
        Tue, 31 Jan 2023 13:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JJ44pVL3mpUwlUxxk25RF88dX6Vi82gssdvbi+j7w98=; b=L4fmKwMl034+kqBEbRIOil/Yzh
        hebphUxkSNBGPEKW8g2u5c7rAgqQSyyL13EJ+82NtRrNyTAhJvd+2dstA9BL7A1SQQIzJ9BejthDC
        mqlgtru3NuMP/KoLrfN0k0J5jRH+PdM2lcPU8uz/PZMFIj9F70MnMs6PGAjArLgKtPLwiKRooRb6k
        +TgRc0rgODdYO8q9/UPV7OHaNeiLl087a/TS7Z6P1YXJT6EbnikFdEJU12GDbE8H0Ka6TrH/jUxyT
        4iM7PQjXxJEAqoDKDAqsBulJEQRFXxqbtquBcyq1qPjb9aeKshaeeQQ17otlNuZ0SkHU49148N9sG
        Mi7bsbKA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pMyVL-005Jej-28;
        Tue, 31 Jan 2023 21:49:27 +0000
Date:   Tue, 31 Jan 2023 21:49:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org
Subject: Re: [RFC][PATCHSET] VM_FAULT_RETRY fixes
Message-ID: <Y9mM5wiEhepjJcN0@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV>
 <CAHk-=whf73Vm2U3jyTva95ihZzefQbThZZxqZuKAF-Xjwq=G4Q@mail.gmail.com>
 <Y9mD1qp/6zm+jOME@ZenIV>
 <CAHk-=wjiwFzEGd_60H3nbgVB=R_8KTcfUJmXy=hSXCvLrXQRFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjiwFzEGd_60H3nbgVB=R_8KTcfUJmXy=hSXCvLrXQRFA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 31, 2023 at 01:19:59PM -0800, Linus Torvalds wrote:
> On Tue, Jan 31, 2023 at 1:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Umm...  What about the semantics of get_user() of unmapped address?
> > Some architectures do quiet EFAULT; some (including alpha) hit
> > the sucker with SIGBUS, no matter what.
> 
> I think we should strive to just make this all common.
> 
> The reason alpha is different is almost certainly not intentional, but
> a combination of "pure accident" and "nobody actually cares".
> 
> > Are we free to modify that behaviour, or is that part of arch-specific
> > ABI?
> 
> I'd just unify this all, probably with a preference for existing
> semantics on x86 (because of "biggest and most varied user base").
> 
> That whole "send SIGBUS even for kernel faults" is certainly bogus and
> against the usual rules. And I may well be to blame for it (I have
> this memory of disliking how EFAULT as a return code didn't actually
> return the faulting address). And realistically, it's also just not
> something that any normal application will ever hit.  Giving invalid
> addresses to system calls is basically always a bug, although there
> are always special software that do all the crazy corner cases (ie
> things like emulators tend to do odd things).
> 
> I doubt such special software exists on Linux/alpha, though.
> 
> So I wouldn't worry about those kinds of oddities overmuch.
> 
> *If* somebody then finds a load that cares, we can always fix it
> later, and I'll go "mea culpa, I didn't think it would matter, and I
> was wrong".

FWIW, from digging through the current tree:

alpha, openrisc, sparc and xtensa send SIGBUS.
m68k: not sure, do_page_fault() callers there are delicate.
mips: really interesting -
        /* Kernel mode? Handle exceptions or die */
        if (!user_mode(regs))
                goto no_context;

        /*
         * Send a sigbus, regardless of whether we were in kernel
         * or user mode.
... which is obviously a rudiment of SIGBUS variant, but nowadays
it's EFAULT.

Everything else seems to be going with EFAULT.

PS: mips used to be SIGBUS, until this
commit 1d50e5e7a6e0325b1a652c4be296a71dc54a6e96
Author: Andrew Morton <akpm@osdl.org>
Date:   Fri Feb 20 01:33:18 2004 -0800

    [PATCH] MIPS mega-patch
    
    From: Ralf Baechle <ralf@linux-mips.org>
    
    Below following 125547 lines of patches, all to arch/mips and
    include/asm-mips.  I'm going to send the remaining stuff of which the one
    or other bit may need to be discussed in smaller bits.

IOW, details are buried somewhere in historical mips tree, assuming
it survives...
