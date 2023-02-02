Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729F8687619
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 07:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjBBG6K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 01:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjBBG6J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 01:58:09 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8C92E830;
        Wed,  1 Feb 2023 22:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=xHDCflHvP6Vsb8iQkaJ1+V05YDZQb/GMrDePu4s4/fs=; b=YP4y5oSBqhQxpIk890Tn5B0XiU
        906vtqTdJtPgbKrfl6tyf7pCNYE6w7elg9JiRc/EzltxKPc3hIaKJgUSTQziC7VO1Lx9+154wpYW0
        x/KUM4lXK0nNU9yx80bWF8bSJ1cfmZfX1sFYYeOKvNeGD4Qrqu6/KLGm+ZL2FFiyYsDtfE5yv+LFY
        /a46D6x7m2ZpTwwsBFHxzvwo/Q++Tas9h8ms1dm8pT6E4i9ZS/QOnmwYZ3LMcFysVm1LGJa7Yh2yd
        FariQY4GNHfM7v2bRqm59uMu7mrNwBfZ0ran3nECU2LxSdE1R9lnKqc6bR1q/1S3ZGCept7QaBTPE
        IoIlnT6g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pNTXn-005cyS-2G;
        Thu, 02 Feb 2023 06:58:03 +0000
Date:   Thu, 2 Feb 2023 06:58:03 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC][PATCHSET] VM_FAULT_RETRY fixes
Message-ID: <Y9te+4n4ajSF++Ex@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV>
 <CAHk-=whf73Vm2U3jyTva95ihZzefQbThZZxqZuKAF-Xjwq=G4Q@mail.gmail.com>
 <Y9mD1qp/6zm+jOME@ZenIV>
 <CAHk-=wjiwFzEGd_60H3nbgVB=R_8KTcfUJmXy=hSXCvLrXQRFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

BTW, speaking of alpha page faults - maybe I'm misreading the manual,
but it seems to imply that interrupts are *not* disabled when entering
page fault handler:

Table 24–2 Entry Point Address Registers
Entry Point Value in a0             Value in a1   Value in a2         PS<IPL>
entArith    Exception summary       Register mask UNPREDICTABLE       Unchanged
entIF       Fault or trap type code UNPREDICTABLE UNPREDICTABLE       Unchanged
entInt      Interrupt type          Vector        Interrupt parameter Priority of interrupt
entMM       VA                      MMCSR         Cause               Unchanged
entSys      p0                      p1            p2                  Unchanged
entUna      VA                      Opcode        Src/Dst             Unchanged

So there's nothing to prevent an interrupt hitting just as we reach
entMM, with interrupt handler stepping on a vmalloc'ed area and
triggering another page fault.

If that is correct, this
                /* Synchronize this task's top level page-table
                   with the "reference" page table from init.  */
                long index = pgd_index(address);
                pgd_t *pgd, *pgd_k;

                pgd = current->active_mm->pgd + index;
                pgd_k = swapper_pg_dir + index;
                if (!pgd_present(*pgd) && pgd_present(*pgd_k)) {
                        pgd_val(*pgd) = pgd_val(*pgd_k);
                        return;
                }
                goto no_context;
is not just missing local_irq_save()/local_irq_restore() around that
fragment - if it finds pgd already present, it needs to check pte
before deciding to proceed to no_context.

Suppose we access vmalloc area and corresponding pgd is not
present in current->active_mm.  Just as we get to entMM,
an interrupt arrives and proceeds to access something
covered by the same pgd.  OK, current->active_mm is still
not present, we get another page fault and do_page_fault()
gets to the quoted code.  pgd is copied from the swapper_pg_dir,
do_page_fault() returns and we get back to the instruction in
interrupt handler that had triggered the second #PF.  This
time around it succeeds.  Once the interrupt handler completes
we are back to entMM.  Once *that* gets to do_page_fault()
we hit the quoted code again.  Only this time around pgd
*is* present and instead of returning we get to no_context.
And since it's been a normal access to vmalloc'ed memory,
there's nothing to be found in exception table.  Oops...

	AFAICS, one way to deal with that is to treat
(unlikely) pgd_present(*pgd) as "get to pte, return if
it looks legitimate, proceed to no_context if it isn't".

Other bugs in the same area:
	* we ought to compare address with VMALLOC_START,
not TASK_SIZE.
	* we ought to do that *before* checking for
kernel threads/pagefault_disable() being in effect.

Wait a minute - pgd_present() on alpha has become constant 1
since a73c948952cc "alpha: use pgtable-nopud instead of 4level-fixup"

So that thing had been completely broken for 3 years and nobody
had noticed.  And that's really completely broken - it stopped
copying top-level entries since that commit.

That's also not hard to fix, but...
	* CONFIG_ALPHA_LARGE_VMALLOC had been racy all along
	* it had very limited use (need for >8Gb of vmalloc
space)
	* it had stopped working in late 2019 and nobody cared.

How about removing that kludge?  Richard?
