Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C9768819F
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 16:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjBBPUq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 10:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjBBPUp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 10:20:45 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A55CDE;
        Thu,  2 Feb 2023 07:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=52m5mti20bb1OZLxO6wwYxyifJ4LEDbWkK8xz9+LlMw=; b=XOmXz3ouDmVQq9BlQe0AlJaMo2
        A35itIkK0LoLUc1uaM0nEllwe6kNwQNQHnqgxGqCWNeOi1SvdbLmd9XeIAfgVUkTPsSjzQx/k1g2k
        URAeeUBw7RmLahyN9cKwp2mt8QaBYUPjrU6uBTyl6J1yvqSC46ATRGwONG1hkHcb/2xugpNYdUlVY
        mB2NyUAKt99aO4sl2zV51s4g6rdIk7YIYoct6u+k7LrRVViCFqVY50YSNtXjgezivb3/clg3/mSmM
        9u2dkZkZrpJnxPO8Jw7gR0WpTvxI8b/s/505TV+rasykLJa712oLUXlQYyJKVjNRNkf8QKQvzy0aR
        ESySNoYw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pNbO9-005ilY-1z;
        Thu, 02 Feb 2023 15:20:37 +0000
Date:   Thu, 2 Feb 2023 15:20:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Michael Cree <mcree@orcon.net.nz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC][PATCHSET] VM_FAULT_RETRY fixes
Message-ID: <Y9vUxXEHRb07bh3J@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV>
 <CAHk-=whf73Vm2U3jyTva95ihZzefQbThZZxqZuKAF-Xjwq=G4Q@mail.gmail.com>
 <Y9mD1qp/6zm+jOME@ZenIV>
 <CAHk-=wjiwFzEGd_60H3nbgVB=R_8KTcfUJmXy=hSXCvLrXQRFA@mail.gmail.com>
 <Y9te+4n4ajSF++Ex@ZenIV>
 <Y9t6Swqt+A9noVIf@creeky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9t6Swqt+A9noVIf@creeky>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 02, 2023 at 09:54:35PM +1300, Michael Cree wrote:
> On Thu, Feb 02, 2023 at 06:58:03AM +0000, Al Viro wrote:
> > Other bugs in the same area:
> > 	* we ought to compare address with VMALLOC_START,
> > not TASK_SIZE.
> > 	* we ought to do that *before* checking for
> > kernel threads/pagefault_disable() being in effect.
> > 
> > Wait a minute - pgd_present() on alpha has become constant 1
> > since a73c948952cc "alpha: use pgtable-nopud instead of 4level-fixup"
> > 
> > So that thing had been completely broken for 3 years and nobody
> > had noticed.  
> 
> I have never noticed because I haven't been able to run a 5.9 or
> newer kernel on Alpha reliably so have been running a 5.8 kernel
> for quite some time.

Er...  For one thing, commit in question went into 5.5; for another
you would only have noticed if you had CONFIG_ALPHA_LARGE_VMALLOC
in your .config, so I rather doubt it's the same problem.

Normally alpha has one PGDIR_SIZE worth of vmalloc space, and it's shared
between all processes - that one slot in top-level table is filled before
we spawn any threads so all of them end up sharing the reference to
the same middle-level table, which is where vmalloc stuff gets mapped.

So normally we have 8Gb of vmalloc space and, as usual for 64bit
boxen, no need to play with vmalloc handling on page faults.  The trouble
is with a kludge that tries to give more than 8Gb; it gives just under
2Tb (2Tb-8Gb, actually - 255 slots out 1024 in top-level table).  That
does need assistance from #PF handler, and that assistance (ifdefed
under CONFIG_ALPHA_LARGE_VMALLOC) what I'd been refering to.

To quote Kconfig,
====
# LARGE_VMALLOC is racy, if you *really* need it then fix it first
config ALPHA_LARGE_VMALLOC
        bool
        help
          Process creation and other aspects of virtual memory management can
          be streamlined if we restrict the kernel to one PGD for all vmalloc
          allocations.  This equates to about 8GB.

          Under normal circumstances, this is so far and above what is needed
          as to be laughable.  However, there are certain applications (such
          as benchmark-grade in-kernel web serving) that can make use of as
          much vmalloc space as is available.

          Say N unless you know you need gobs and gobs of vmalloc space.
====
"Racy" probably had been about something along the lines of the scenario
I'd mentioned just upthread, but in 5.5 that "racy" escalated to "does not
work at all" - if you ever hit a vmalloc-related fault, you are going
to get an oops.  You still get 8Gb, but beyond that it's broken.

And it's almost certainly not the problem you are seeing...
