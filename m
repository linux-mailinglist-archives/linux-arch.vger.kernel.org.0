Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4343646A31B
	for <lists+linux-arch@lfdr.de>; Mon,  6 Dec 2021 18:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhLFRmd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Dec 2021 12:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243543AbhLFRmc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Dec 2021 12:42:32 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECFFC061746;
        Mon,  6 Dec 2021 09:39:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 447E6CE173F;
        Mon,  6 Dec 2021 17:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688CDC341C1;
        Mon,  6 Dec 2021 17:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638812339;
        bh=viapyMP+uWweUhUtSebtUlHGJOGRA2C6UPmzpvE8xJY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=exsO6t4pmiT/cTp0u+pjPqE2UN77Jro5Fa9COX2N1ZWb5cLUIQHyaonWb2YHaUkQu
         1bA2XzSw4H1B1VxZOurxRqwc5+4KTsDs5LQtkUNMcPGgn2FMA3JAVInXRk5uKCLRPo
         rRTiujw8hJbNGZATgGz+kXFphXeIMwwKypjMNl1T8kt+Xk7BNPl0b/9Mu4bCipNW9k
         Lj1kjG4FUPLlyI7APSFAJws73AxTJso7IojAvMwkNIDbvDReClUBa7lMXW1HOCDLlk
         vQzpGwcEfOnxmpktFdHzdfyqkXnd6zS6316nAt3u64ct23hVJHO6HUSbz4FsjJIsk8
         2Mz4O9w4n3ICQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0AB175C1461; Mon,  6 Dec 2021 09:38:59 -0800 (PST)
Date:   Mon, 6 Dec 2021 09:38:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH v3 08/25] kcsan: Show location access was reordered to
Message-ID: <20211206173859.GA641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211130114433.2580590-1-elver@google.com>
 <20211130114433.2580590-9-elver@google.com>
 <Ya2Zpf8qpgDYiGqM@boqun-archlinux>
 <CANpmjNMirKGSBW2m+bWRM9_FnjK3_HjnJC=dhyMktx50mwh1GQ@mail.gmail.com>
 <Ya4evHE7uQ9eXpax@boqun-archlinux>
 <Ya40hEQv5SEu7ZeL@elver.google.com>
 <Ya5FaU9e6XY8vHJR@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya5FaU9e6XY8vHJR@boqun-archlinux>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 07, 2021 at 01:16:25AM +0800, Boqun Feng wrote:
> On Mon, Dec 06, 2021 at 05:04:20PM +0100, Marco Elver wrote:
> > On Mon, Dec 06, 2021 at 10:31PM +0800, Boqun Feng wrote:
> > [...]
> > > Thanks for the explanation, I was missing the swap here. However...
> > > 
> > > > So in your above example you need to swap "reordered to" and the top
> > > > frame of the stack trace.
> > > > 
> > 
> > Apologies, I wasn't entirely precise ... what you say below is correct.
> > 
> > > IIUC, the report for my above example will be:
> > > 
> > >          | write (reordered) to 0xaaaa of ...:
> > >          | foo+0x... // address of the write to A
> > >          | ...
> > >          |  |
> > >          |  +-> reordered to: foo+0x... // address of the callsite to bar() in foo()
> > > 
> > > , right? Because in replace_stack_entry(), it's not the top frame where
> > > the race occurred that gets swapped, it's the frame which belongs to the
> > > same function as the original access that gets swapped. In other words,
> > > when KCSAN finds the problem, top entries of the calling stack are:
> > > 
> > > 	[0] bar+0x.. // address of the write to B
> > > 	[1] foo+0x.. // address of the callsite to bar() in foo()
> > > 
> > > after replace_stack_entry(), they changes to:
> > > 
> > > 	[0] bar+0x.. // address of the write to B
> > > skip  ->[1] foo+0x.. // address of the write to A
> > > 
> > > , as a result the report won't mention bar() at all.
> > 
> > Correct.
> > 
> > > And I think a better report will be:
> > > 
> > >          | write (reordered) to 0xaaaa of ...:
> > >          | foo+0x... // address of the write to A
> > >          | ...
> > >          |  |
> > >          |  +-> reordered to: bar+0x... // address of the write to B in bar()
> > > 
> > > because it tells users the exact place the accesses get reordered. That
> > > means maybe we want something as below? Not completely tested, but I
> > > play with scope checking a bit, seems it gives what I want. Thoughts?
> > 
> > This is problematic because it makes it much harder to actually figure
> > out what's going on, given "reordered to" isn't a full stack trace. So
> > if you're deep in some call hierarchy, seeing a random "reordered to"
> > line is quite useless. What I want to see, at the very least, is the ip
> > to the same function where the original access happened.
> > 
> > We could of course try and generate a full stack trace at "reordered
> > to", but this would entail
> > 
> > 	a) allocating 2x unsigned long[64] on the stack (or moving to
> > 	   static storage),
> > 	b) further increasing the report length,
> > 	c) an even larger number of possibly distinct reports for the
> > 	   same issue; this makes deduplication even harder.
> > 
> > The reason I couldn't justify all that is that when I looked through
> > several dozen "reordered to" reports, I never found anything other than
> > the ip in the function frame of the original access useful. That, and in
> > most cases the "reordered to" location was in the same function or in an
> > inlined function.
> > 
> > The below patch would do what you'd want I think.
> > 
> > My opinion is to err on the side of simplicity until there is evidence
> > we need it. Of course, if you have a compelling reason that we need it
> > from the beginning, happy to send it as a separate patch on top.
> > 
> > What do you think?
> > 
> 
> Totally agreed. It's better to keep it simple until people report that
> they want to see more information to resolve the issues. And thanks for
> looking into the "double stack traces", that looks good to me too.
> 
> For the original patch, feel free to add:
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Thank you both!  I will add Boqun's Reviewed-by on the next rebase.

							Thanx, Paul

> Regards,
> Boqun
> 
> > Thanks,
> > -- Marco
> > 
> > ------ >8 ------
> > 
> > From: Marco Elver <elver@google.com>
> > Date: Mon, 6 Dec 2021 16:35:02 +0100
> > Subject: [PATCH] kcsan: Show full stack trace of reordered-to accesses
> > 
> > Change reports involving reordered accesses to show the full stack trace
> > of "reordered to" accesses. For example:
> > 
> >  | ==================================================================
> >  | BUG: KCSAN: data-race in test_kernel_wrong_memorder / test_kernel_wrong_memorder
> >  |
> >  | read-write to 0xffffffffc02d01e8 of 8 bytes by task 2481 on cpu 2:
> >  |  test_kernel_wrong_memorder+0x57/0x90
> >  |  access_thread+0xb7/0x100
> >  |  kthread+0x2ed/0x320
> >  |  ret_from_fork+0x22/0x30
> >  |
> >  | read-write (reordered) to 0xffffffffc02d01e8 of 8 bytes by task 2480 on cpu 0:
> >  |  test_kernel_wrong_memorder+0x57/0x90
> >  |  access_thread+0xb7/0x100
> >  |  kthread+0x2ed/0x320
> >  |  ret_from_fork+0x22/0x30
> >  |   |
> >  |   +-> reordered to: test_delay+0x31/0x110
> >  |                     test_kernel_wrong_memorder+0x80/0x90
> >  |
> >  | Reported by Kernel Concurrency Sanitizer on:
> >  | CPU: 0 PID: 2480 Comm: access_thread Not tainted 5.16.0-rc1+ #2
> >  | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> >  | ==================================================================
> > 
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  kernel/kcsan/report.c | 33 +++++++++++++++++++++++----------
> >  1 file changed, 23 insertions(+), 10 deletions(-)
> > 
> > diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> > index 67794404042a..a8317d5f5123 100644
> > --- a/kernel/kcsan/report.c
> > +++ b/kernel/kcsan/report.c
> > @@ -317,22 +317,29 @@ replace_stack_entry(unsigned long stack_entries[], int num_entries, unsigned lon
> >  {
> >  	unsigned long symbolsize, offset;
> >  	unsigned long target_func;
> > -	int skip;
> > +	int skip, i;
> >  
> >  	if (kallsyms_lookup_size_offset(ip, &symbolsize, &offset))
> >  		target_func = ip - offset;
> >  	else
> >  		goto fallback;
> >  
> > -	for (skip = 0; skip < num_entries; ++skip) {
> > +	skip = get_stack_skipnr(stack_entries, num_entries);
> > +	for (i = 0; skip < num_entries; ++skip, ++i) {
> >  		unsigned long func = stack_entries[skip];
> >  
> >  		if (!kallsyms_lookup_size_offset(func, &symbolsize, &offset))
> >  			goto fallback;
> >  		func -= offset;
> >  
> > +		replaced[i] = stack_entries[skip];
> >  		if (func == target_func) {
> > -			*replaced = stack_entries[skip];
> > +			/*
> > +			 * There must be at least 1 entry left in the original
> > +			 * @stack_entries, so we know that we will never occupy
> > +			 * more than @num_entries - 1 of @replaced.
> > +			 */
> > +			replaced[i + 1] = 0;
> >  			stack_entries[skip] = ip;
> >  			return skip;
> >  		}
> > @@ -341,6 +348,7 @@ replace_stack_entry(unsigned long stack_entries[], int num_entries, unsigned lon
> >  fallback:
> >  	/* Should not happen; the resulting stack trace is likely misleading. */
> >  	WARN_ONCE(1, "Cannot find frame for %pS in stack trace", (void *)ip);
> > +	replaced[0] = 0;
> >  	return get_stack_skipnr(stack_entries, num_entries);
> >  }
> >  
> > @@ -365,11 +373,16 @@ static int sym_strcmp(void *addr1, void *addr2)
> >  }
> >  
> >  static void
> > -print_stack_trace(unsigned long stack_entries[], int num_entries, unsigned long reordered_to)
> > +print_stack_trace(unsigned long stack_entries[], int num_entries, unsigned long *reordered_to)
> >  {
> >  	stack_trace_print(stack_entries, num_entries, 0);
> > -	if (reordered_to)
> > -		pr_err("  |\n  +-> reordered to: %pS\n", (void *)reordered_to);
> > +	if (reordered_to[0]) {
> > +		int i;
> > +
> > +		pr_err("  |\n  +-> reordered to: %pS\n", (void *)reordered_to[0]);
> > +		for (i = 1; i < NUM_STACK_ENTRIES && reordered_to[i]; ++i)
> > +			pr_err("                    %pS\n", (void *)reordered_to[i]);
> > +	}
> >  }
> >  
> >  static void print_verbose_info(struct task_struct *task)
> > @@ -390,12 +403,12 @@ static void print_report(enum kcsan_value_change value_change,
> >  			 struct other_info *other_info,
> >  			 u64 old, u64 new, u64 mask)
> >  {
> > -	unsigned long reordered_to = 0;
> > +	unsigned long reordered_to[NUM_STACK_ENTRIES] = { 0 };
> >  	unsigned long stack_entries[NUM_STACK_ENTRIES] = { 0 };
> >  	int num_stack_entries = stack_trace_save(stack_entries, NUM_STACK_ENTRIES, 1);
> > -	int skipnr = sanitize_stack_entries(stack_entries, num_stack_entries, ai->ip, &reordered_to);
> > +	int skipnr = sanitize_stack_entries(stack_entries, num_stack_entries, ai->ip, reordered_to);
> >  	unsigned long this_frame = stack_entries[skipnr];
> > -	unsigned long other_reordered_to = 0;
> > +	unsigned long other_reordered_to[NUM_STACK_ENTRIES] = { 0 };
> >  	unsigned long other_frame = 0;
> >  	int other_skipnr = 0; /* silence uninit warnings */
> >  
> > @@ -408,7 +421,7 @@ static void print_report(enum kcsan_value_change value_change,
> >  	if (other_info) {
> >  		other_skipnr = sanitize_stack_entries(other_info->stack_entries,
> >  						      other_info->num_stack_entries,
> > -						      other_info->ai.ip, &other_reordered_to);
> > +						      other_info->ai.ip, other_reordered_to);
> >  		other_frame = other_info->stack_entries[other_skipnr];
> >  
> >  		/* @value_change is only known for the other thread */
> > -- 
> > 2.34.1.400.ga245620fadb-goog
> > 
