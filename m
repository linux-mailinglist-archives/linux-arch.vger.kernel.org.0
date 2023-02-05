Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DC568AE64
	for <lists+linux-arch@lfdr.de>; Sun,  5 Feb 2023 06:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjBEFKc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Feb 2023 00:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBEFKb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Feb 2023 00:10:31 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E548111153;
        Sat,  4 Feb 2023 21:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tr6hHp8aMuyix7W8MPsJcy4qd0T+bfV4ku4SlFkeikM=; b=IPFSEa3/kiVAIcszhJNII+WRya
        neT68DS6Txm3V+3RoFqVcUT8ACqt2krppBrR0nE0MhgP5v5mx5J+FkCtxLK4NuL44MCdybBXJ3tiE
        BCK8F3NrQgjudmCQN5DOg8ilOhP8rpQA4KGJCr/zYnDwePVNc7hXeYxhSu01Hl/Whg14RPN+t+Qjn
        FFeEglPsiR3VQu2OUXAVKINJi5E1JXxnZ627BUZs2iReC5LcTJ5xUmA3LYosBCGyMtMSiIolQQlFF
        qmHMDBAt2OmyN2m/y5BLyEfjGG8PEi8Syc5yKEtFHYC8gaQDfjK0zoT96DVm80gtbJv84vXLTwm54
        +Fpb4OAg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pOXID-006IcI-2c;
        Sun, 05 Feb 2023 05:10:21 +0000
Date:   Sun, 5 Feb 2023 05:10:21 +0000
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
Message-ID: <Y986PWjDy9YbHBEw@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV>
 <CAHk-=whf73Vm2U3jyTva95ihZzefQbThZZxqZuKAF-Xjwq=G4Q@mail.gmail.com>
 <Y9mD1qp/6zm+jOME@ZenIV>
 <CAHk-=wjiwFzEGd_60H3nbgVB=R_8KTcfUJmXy=hSXCvLrXQRFA@mail.gmail.com>
 <Y9mM5wiEhepjJcN0@ZenIV>
 <CAHk-=wjNwwnBckTo8HLSdsd1ndoAR=5RBoZhdOyzhsnDAYWL9g@mail.gmail.com>
 <Y9rCBqwbLlLf1fHe@x1n>
 <Y9rlI6d5J2Y/YNQ+@ZenIV>
 <Y9w/lrL6g4yauXz4@x1n>
 <Y92mP1GT28KfnPEQ@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y92mP1GT28KfnPEQ@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 04, 2023 at 12:26:39AM +0000, Al Viro wrote:
> On Thu, Feb 02, 2023 at 05:56:22PM -0500, Peter Xu wrote:
> 
> > IMHO it'll be merely impossible to merge things across most (if not to say,
> > all) archs.  It will need to be start from one or at least a few that still
> > shares a major common base - I would still rely on x86 as a start - then we
> > try to use the helper in as much archs as possible.
> > 
> > Even on x86, I do also see challenges so I'm not sure whether a common
> > enough routine can be abstracted indeed.  But I believe there's a way to do
> > this because obviously we still see tons of duplicated logics falling
> > around.  It may definitely need time to think out where's the best spot to
> > start, and how to gradually move towards covering more archs starting from
> > one.
> 
> FWIW, after going through everything from alpha to loongarch (in alphabetic
> order, skipping the itanic) the following seems to be suitable for all of
> them:
> 
> generic_fault(address, flags, vm_flags, regs)
[snip]

After looking through other architectures: that needs changes.

AFAICS, the right approach would be to add a pointer to (uninitialized)
kernel_siginfo.  And let it pass the signal number, etc. through that.
That way all "we want to raise a signal" return values fold together.
*IF* the page fault wants to do something extra on SIGSEGV, but not on
SIGBUS (we have several such), it can key that upon info.si_signo.

Speaking of SIGSEGV, there's a fun situation with VM_FAULT_SIGSEGV:

1) Only x86 and ppc generate VM_FAULT_SIGSEGV in handle_mm_fault()
without hitting WARN_ON_ONCE().  And neither actually returns it
to page fault handler - the conditions that would've led to that
return value (pkey stuff) are checked in the page fault handler
and handle_mm_fault() is not called in such cases.

2) on alpha, hexagon, itanic, loongarch, microblaze, mips, nios2,
openrisc, sparc, um and xtensa #PF handler would end up with SEGV_ACCERR
if it saw VM_FAULT_SIGNAL.

3) on arm, arm64, arc, m68k, powerpc, s390, sh and x86 - SEGV_MAPERR
(except that neither x86 nor powerpc #PF ever see it)

4) on csky and riscv it would end up with BUG()

5) on parisc it's complicated^Wbroken - it tries to decide which
one to use after having unlocked mmap and looking at vma in process.

As it is, VM_FAULT_SIGSEGV had ended up as "we need to report some
error to get_user_pages() and similar callers in cases when
page fault handler would've detected pkey problem and refused
to call handle_mm_fault()", with several places where it's
"we had been called with bogus arguments; printk and return
something to indicate the things had gone wrong".  It used to
have other uses, but this is what it had become now - grep and
you'll see.

AFAICS, all checks for it in page fault handlers are pretty much
dead code...
