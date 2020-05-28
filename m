Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3377F1E5B91
	for <lists+linux-arch@lfdr.de>; Thu, 28 May 2020 11:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgE1JOu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 May 2020 05:14:50 -0400
Received: from foss.arm.com ([217.140.110.172]:49708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbgE1JOu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 28 May 2020 05:14:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 710DF31B;
        Thu, 28 May 2020 02:14:49 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E25D23F6C4;
        Thu, 28 May 2020 02:14:47 -0700 (PDT)
Date:   Thu, 28 May 2020 10:14:45 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Evgenii Stepanov <eugenis@google.com>
Subject: Re: [PATCH v4 11/26] arm64: mte: Add PROT_MTE support to mmap() and
 mprotect()
Message-ID: <20200528091445.GA2961@gaia>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-12-catalin.marinas@arm.com>
 <CAMn1gO5ApcHOgQ_oLjiGDdCx9znz7N50w-BbzGPYpAzPQC3OQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO5ApcHOgQ_oLjiGDdCx9znz7N50w-BbzGPYpAzPQC3OQQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 27, 2020 at 11:57:39AM -0700, Peter Collingbourne wrote:
> On Fri, May 15, 2020 at 10:16 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > To enable tagging on a memory range, the user must explicitly opt in via
> > a new PROT_MTE flag passed to mmap() or mprotect(). Since this is a new
> > memory type in the AttrIndx field of a pte, simplify the or'ing of these
> > bits over the protection_map[] attributes by making MT_NORMAL index 0.
> 
> Should the userspace stack always be mapped as if with PROT_MTE if the
> hardware supports it? Such a change would be invisible to non-MTE
> aware userspace since it would already need to opt in to tag checking
> via prctl. This would let userspace avoid a complex stack
> initialization sequence when running with stack tagging enabled on the
> main thread.

I don't think the stack initialisation is that difficult. On program
startup (can be the dynamic loader). Something like (untested):

	register unsigned long stack asm ("sp");
	unsigned long page_sz = sysconf(_SC_PAGESIZE);

	mprotect((void *)(stack & ~(page_sz - 1)), page_sz,
		 PROT_READ | PROT_WRITE | PROT_MTE | PROT_GROWSDOWN);

(the essential part it PROT_GROWSDOWN so that you don't have to specify
a stack lower limit)

I don't like enabling this by default since it will have a small cost
even if the application doesn't enable tag checking. The kernel would
still have to zero the tags when mapping the stack and preserve them
when swapping out.

Another case where this could go wrong is if we want enable some
quiet monitoring of user programs: the libc enables PROT_MTE on heap
allocations but keeps tag checking disabled as it doesn't want any
SIGSEGV; the kernel could enable async TCF and log any faults
(rate-limited). Default PROT_MTE stack would get in the way. Anyway,
this use-case is something for the future, so far these patches rely on
the user solely driving the tag checking mode.

I'm fine, however, with enabling PROT_MTE on the main stack based on
some ELF note.

-- 
Catalin
