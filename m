Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40043485B22
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 22:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244641AbiAEVxk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 16:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244590AbiAEVxc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jan 2022 16:53:32 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69F7C061245;
        Wed,  5 Jan 2022 13:53:31 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n5EDn-00HZ0G-Pl; Wed, 05 Jan 2022 21:53:27 +0000
Date:   Wed, 5 Jan 2022 21:53:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 02/10] exit: Add and use make_task_dead.
Message-ID: <YdYTV9gQEPxssuZe@zeniv-ca.linux.org.uk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-2-ebiederm@xmission.com>
 <YdUmN7n4W5YETUhW@zeniv-ca.linux.org.uk>
 <871r1l9ai5.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r1l9ai5.fsf@email.froward.int.ebiederm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 05, 2022 at 02:46:10PM -0600, Eric W. Biederman wrote:
> Al Viro <viro@zeniv.linux.org.uk> writes:
> 
> > On Wed, Dec 08, 2021 at 02:25:24PM -0600, Eric W. Biederman wrote:
> >> There are two big uses of do_exit.  The first is it's design use to be
> >> the guts of the exit(2) system call.  The second use is to terminate
> >> a task after something catastrophic has happened like a NULL pointer
> >> in kernel code.
> >> 
> >> Add a function make_task_dead that is initialy exactly the same as
> >> do_exit to cover the cases where do_exit is called to handle
> >> catastrophic failure.  In time this can probably be reduced to just a
> >> light wrapper around do_task_dead. For now keep it exactly the same so
> >> that there will be no behavioral differences introducing this new
> >> concept.
> >> 
> >> Replace all of the uses of do_exit that use it for catastraphic
> >> task cleanup with make_task_dead to make it clear what the code
> >> is doing.
> >> 
> >> As part of this rename rewind_stack_do_exit
> >> rewind_stack_and_make_dead.
> >
> > Umm...   What about .Linvalid_mask: in arch/xtensa/kernel/entry.S?
> > That's an obvious case for your make_task_dead().
> 
> Good catch.
> 
> Being in assembly it did not have anything after the name do_exit so it
> hid from my regex "[^A-Za-z0-9_]do_exit[^A-Za-z0-9]".  Thank you for
> finding that.

Umm...  What's wrong with '\<do_exit\>'?  Difference in catch:

missed 6
Documentation/trace/kprobes.rst:596:do_exit() case covered. do_execve() and do_fork() are not an issue.
arch/x86/entry/entry_32.S:1258: call    do_exit
arch/x86/entry/entry_64.S:1440: call    do_exit
arch/xtensa/kernel/entry.S:1436:        abi_call        do_exit
samples/bpf/test_cgrp2_tc.sh:114:do_exit() {
tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc:8:SYM2=do_exit

extra 3
arch/powerpc/mm/book3s64/radix_tlb.c:815:static void do_exit_flush_lazy_tlb(void *arg)
arch/powerpc/mm/book3s64/radix_tlb.c:830:       smp_call_function_many(mm_cpumask(mm), do_exit_flush_lazy_tlb,
tools/perf/ui/browsers/hists.c:2847:    act->fn = do_exit_browser;

Extra catch clearly contains nothing of interest (assuming it's not a result of a typo
in your regex in the first place - you seem to have omitted _ from the second set, and if
you add that back, these 3 hits go away).  And missed 6...  3 are outside of the kernel
source proper, and the rest are all genuine.  You've caught x86 ones (inside the
rewind_stack_do_exit variants) and missed the xtensa one...

\< and \> are GNUisms, but both git grep and grep (both on Linux and FreeBSD, at least)
handle them...  Or use \bdo_exit\b, for that matter (Perlism instead of GNUism, matching
both the beginnings and ends of words)...
