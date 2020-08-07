Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229BC23EFE2
	for <lists+linux-arch@lfdr.de>; Fri,  7 Aug 2020 17:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgHGPTR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Aug 2020 11:19:17 -0400
Received: from foss.arm.com ([217.140.110.172]:58084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgHGPTQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 Aug 2020 11:19:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 194EAD6E;
        Fri,  7 Aug 2020 08:19:15 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7958E3F7D7;
        Fri,  7 Aug 2020 08:19:13 -0700 (PDT)
Date:   Fri, 7 Aug 2020 16:19:07 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org,
        Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, nd@arm.com
Subject: Re: [PATCH v7 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200807151906.GM6750@gaia>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
 <20200715170844.30064-30-catalin.marinas@arm.com>
 <20200727163634.GO7127@arm.com>
 <20200728110758.GA21941@arm.com>
 <20200728145350.GR7127@arm.com>
 <20200728195957.GA31698@gaia>
 <20200803124309.GC14398@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803124309.GC14398@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Szabolcs,

On Mon, Aug 03, 2020 at 01:43:10PM +0100, Szabolcs Nagy wrote:
> The 07/28/2020 20:59, Catalin Marinas wrote:
> > On Tue, Jul 28, 2020 at 03:53:51PM +0100, Szabolcs Nagy wrote:
> > > if linux does not want to add a per process setting then only libc
> > > will be able to opt-in to mte and only at very early in the
> > > startup process (before executing any user code that may start
> > > threads). this is not out of question, but i think it limits the
> > > usage and deployment options.
> > 
> > There is also the risk that we try to be too flexible at this stage
> > without a real use-case.
> 
> i don't know how mte will be turned on in libc.
> 
> if we can always turn sync tag checks on early whenever mte is
> available then i think there is no issue.
> 
> but if we have to make the decision later for compatibility or
> performance reasons then per thread setting is problematic.

At least for libc, I'm not sure how you could even turn MTE on at
run-time. The heap allocations would have to be mapped with PROT_MTE as
we can't easily change them (well, you could mprotect(), assuming the
user doesn't use tagged pointers on them).

There is a case to switch tag checking from asynchronous to synchronous
at run-time based on a signal but that's rather specific to Android
where zygote controls the signal handler. I don't think you can do this
with libc. Even on Android, since the async fault signal is delivered
per thread, it probably does this lazily (alternatively, it could issue
a SIGUSRx to the other threads for synchronisation).

> use of the prctl outside of libc is very limited if it's per thread
> only:

In the non-Android context, I think the prctl() for MTE control should
be restricted to the libc. You can control the mode prior to the process
being started using environment variables. I really don't see how the
libc could handle the changing of the MTE behaviour at run-time without
itself handling signals.

> - application code may use it in a (elf specific) pre-initialization
>   function, but that's a bit obscure (not exposed in c) and it is
>   reasonable for an application to enable mte checks after it
>   registered a signal handler for mte faults. (and at that point it
>   may be multi-threaded).

Since the app can install signal handlers, it can also deal with
notifying other threads with a SIGUSRx, assuming that it decided this
after multiple threads were created. If it does this while
single-threaded, subsequent threads would inherit the first one.

The only use-case I see for doing this in the kernel is if the code
requiring an MTE behaviour change cannot install signal handlers. More
on this below.

> - library code normally initializes per thread state on the first call
>   into the library from a given thread, but with mte, as soon as
>   memory / pointers are tagged in one thread, all threads are
>   affected: not performing checks in other threads is less secure (may
>   be ok) and it means incompatible syscall abi (not ok). so at least
>   PR_TAGGED_ADDR_ENABLE should have process wide setting for this
>   usage.

My assumption with MTE is that the libc will initialise it when the
library is loaded (something __attribute__((constructor))) and it's
still in single-threaded mode. Does it wait until the first malloc()
call? Also, is there such thing as a per-thread initialiser for a
dynamic library (not sure it can be implemented in practice though)?

The PR_TAGGED_ADDR_ENABLE synchronisation at least doesn't require IPIs
to other CPUs to change the hardware state. However, it can still race
with thread creation or a prctl() on another thread, not sure what we
can define here, especially as it depends on the kernel internals: e.g.
thread creation copies some data structures of the calling thread but at
the same time another thread wants to change such structures for all
threads of that process. The ordering of events here looks pretty
fragile.

Maybe with another global status (per process) which takes priority over
the per thread one would be easier. But such priority is not temporal
(i.e. whoever called prctl() last) but pretty strict: once a global
control was requested, it will remain global no matter what subsequent
threads request (or we can do it the other way around).

> but i guess it is fine to design the mechanism for these in a later
> linux version, until then such usage will be unreliable (will depend
> on how early threads are created).

Until we have a real use-case, I'd not complicate the matters further.
For example, I'm still not sure how realistic it is for an application
to load a new heap allocator after some threads were created. Even the
glibc support, I don't think it needs this.

Could an LD_PRELOADED library be initialised after threads were created
(I guess it could if another preloaded library created threads)? Even if
it does, do we have an example or it's rather theoretical.

If this becomes an essential use-case, we can look at adding a new flag
for prctl() which would set the option globally, with the caveats
mentioned above. It doesn't need to be in the initial ABI (and the
PR_TAGGED_ADDR_ENABLE is already upstream).

Thanks.

-- 
Catalin
