Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F83F1EA672
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jun 2020 17:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgFAPEI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jun 2020 11:04:08 -0400
Received: from foss.arm.com ([217.140.110.172]:39244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgFAPEH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Jun 2020 11:04:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A33AE1FB;
        Mon,  1 Jun 2020 08:04:06 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E858B3F305;
        Mon,  1 Jun 2020 08:04:04 -0700 (PDT)
Date:   Mon, 1 Jun 2020 16:04:02 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arch@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>, nd@arm.com,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>
Subject: Re: [PATCH v4 11/26] arm64: mte: Add PROT_MTE support to mmap() and
 mprotect()
Message-ID: <20200601150402.GC5031@arm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-12-catalin.marinas@arm.com>
 <CAMn1gO5ApcHOgQ_oLjiGDdCx9znz7N50w-BbzGPYpAzPQC3OQQ@mail.gmail.com>
 <20200528091445.GA2961@gaia>
 <20200528110509.GA18623@arm.com>
 <20200528163412.GC2961@gaia>
 <20200601085536.GV5031@arm.com>
 <20200601144544.GC23419@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601144544.GC23419@gaia>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 01, 2020 at 03:45:45PM +0100, Catalin Marinas wrote:
> On Mon, Jun 01, 2020 at 09:55:38AM +0100, Dave P Martin wrote:
> > On Thu, May 28, 2020 at 05:34:13PM +0100, Catalin Marinas wrote:
> > > On Thu, May 28, 2020 at 12:05:09PM +0100, Szabolcs Nagy wrote:
> > > > The 05/28/2020 10:14, Catalin Marinas wrote:
> > > > > On Wed, May 27, 2020 at 11:57:39AM -0700, Peter Collingbourne wrote:
> > > > > > Should the userspace stack always be mapped as if with PROT_MTE if the
> > > > > > hardware supports it? Such a change would be invisible to non-MTE
> > > > > > aware userspace since it would already need to opt in to tag checking
> > > > > > via prctl. This would let userspace avoid a complex stack
> > > > > > initialization sequence when running with stack tagging enabled on the
> > > > > > main thread.
> > > > > 
> > > > > I don't think the stack initialisation is that difficult. On program
> > > > > startup (can be the dynamic loader). Something like (untested):
> > > > > 
> > > > > 	register unsigned long stack asm ("sp");
> > > > > 	unsigned long page_sz = sysconf(_SC_PAGESIZE);
> > > > > 
> > > > > 	mprotect((void *)(stack & ~(page_sz - 1)), page_sz,
> > > > > 		 PROT_READ | PROT_WRITE | PROT_MTE | PROT_GROWSDOWN);
> > > > > 
> > > > > (the essential part it PROT_GROWSDOWN so that you don't have to specify
> > > > > a stack lower limit)
> > > > 
> > > > does this work even if the currently mapped stack is more than page_sz?
> > > > determining the mapped main stack area is i think non-trivial to do in
> > > > userspace (requires parsing /proc/self/maps or similar).
> > > 
> > > Because of PROT_GROWSDOWN, the kernel adjusts the start of the range
> > > down automatically. It is potentially problematic if the top of the
> > > stack is more than a page away and you want the whole stack coloured. I
> > > haven't run a test but my reading of the kernel code is that the stack
> > > vma would be split in this scenario, so the range beyond sp+page_sz
> > > won't have PROT_MTE set.
> > > 
> > > My assumption is that if you do this during program start, the stack is
> > > smaller than a page. Alternatively, could we use argv or envp to
> > > determine the top of the user stack (the bottom is taken care of by the
> > > kernel)?
> > 
> > I don't think you can easily know when the stack ends, but perhaps it
> > doesn't matter.
> > 
> > From memory, the initial stack looks like:
> > 
> > 	argv/env strings
> > 	AT_NULL
> > 	auxv
> > 	NULL
> > 	env
> > 	NULL
> > 	argv
> > 	argc	<--- sp
> > 
> > If we don't care about tagging the strings correctly, we could step to
> > the end of auxv and tag down from there.
> > 
> > If we do care about tagging the strings, there's probably no good way
> > to find the end of the string area, other than looking up sp in
> > /proc/self/maps.  I'm not sure we should trust all past and future
> > kernels to spit out the strings in a predictable order.
> 
> I don't think we care about tagging whatever the kernel places on the
> stack since the argv/envp pointers are untagged. An mprotect(PROT_MTE)
> may or may not cover the environment but it shouldn't matter as the
> kernel clears the tags on the corresponding pages anyway.

We have no match-all tag, right?  So we do rely on the tags being
cleared for the initial stack contents so that using untagged pointers
to access it works.

> AFAIK stack tagging works by colouring a stack frame on function entry
> and clearing the tags on return. We would only hit a problem if the
> function issuing mprotect(sp, PROT_MTE) on and its callers already
> assumed a PROT_MTE stack. Without PROT_MTE, an STG would be
> write-ignore, so subsequently turning it on would lead to a mismatch
> between the pointer and the allocation tags.
> 
> So PROT_MTE turning on should happen very early in the user process
> startup code before any code with stack tagging enabled. Whether you
> reach the top of the stack with such mprotect() doesn't really matter
> since up to that point there should not be any use of stack tagging. If
> that's not possible, for example the glibc code setting up the stack was
> compiled to stack tagging itself, the kernel would have to enable it
> when the user process starts. However, I'd only do this based on some
> ELF note.

Sounds fair.

This early on, the process shouldn't be exposed to arbitrary, untrusted
data.  So it's probably not a problem that tagging isn't turned on right
from the start.

Cheers
---Dave
