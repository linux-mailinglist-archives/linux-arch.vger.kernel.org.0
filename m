Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A13324E70B
	for <lists+linux-arch@lfdr.de>; Sat, 22 Aug 2020 13:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgHVL2j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 22 Aug 2020 07:28:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbgHVL2i (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 22 Aug 2020 07:28:38 -0400
Received: from gaia (unknown [95.146.230.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D91CB2072D;
        Sat, 22 Aug 2020 11:28:34 +0000 (UTC)
Date:   Sat, 22 Aug 2020 12:28:32 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org,
        Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, nd@arm.com,
        libc-alpha@sourceware.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Matthew Malcomson <Matthew.Malcomson@arm.com>
Subject: Re: [PATCH v7 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200822112831.GB16635@gaia>
References: <20200728110758.GA21941@arm.com>
 <20200728145350.GR7127@arm.com>
 <20200728195957.GA31698@gaia>
 <20200803124309.GC14398@arm.com>
 <20200807151906.GM6750@gaia>
 <20200810141309.GK14398@arm.com>
 <20200811172038.GB1429@gaia>
 <20200812124520.GP14398@arm.com>
 <20200819095453.GA86@DESKTOP-O1885NU.localdomain>
 <20200820164313.GL29343@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820164313.GL29343@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 20, 2020 at 05:43:15PM +0100, Szabolcs Nagy wrote:
> The 08/19/2020 10:54, Catalin Marinas wrote:
> > On Wed, Aug 12, 2020 at 01:45:21PM +0100, Szabolcs Nagy wrote:
> > > On 08/11/2020 18:20, Catalin Marinas wrote:
> > > turning sync tag checks on early would enable the most of the
> > > interesting usecases (only PROT_MTE has to be handled at runtime not
> > > the prctls. however i don't yet know how userspace will deal with
> > > compat issues, i.e. it may not be valid to unconditionally turn tag
> > > checks on early).
> > 
> > If we change the defaults so that no prctl() is required for the
> > standard use-case, it would solve most of the common deployment issues:
> > 
> > 1. Tagged address ABI default on when HWCAP2_MTE is present
> > 2. Synchronous TCF by default
> > 3. GCR_EL1.Excl allows all tags except 0 by default
> > 
> > Any other configuration diverging from the above is considered
> > specialist deployment and will have to issue the prctl() on a per-thread
> > basis.
> > 
> > Compat issues in user-space will be dealt with via environment
> > variables but pretty much on/off rather than fine-grained tag checking
> > mode. So for glibc, you'd have only _MTAG=0 or 1 and the only effect is
> > using PROT_MTE + tagged pointers or no-PROT_MTE + tag 0.
> 
> enabling mte checks by default would be nice and simple (a libc can
> support tagging allocators without any change assuming its code is mte
> safe which is true e.g. for the latest glibc release and for musl
> libc).

While talking to the Android folk, it occurred to me that the default
tag checking mode doesn't even need to be decided by the kernel. The
dynamic loader can set the desired tag check mode and the tagged address
ABI based on environment variables (_MTAG_ENABLE=x) and do a prctl()
before any threads have been created. Subsequent malloc() calls or
dlopen() can mmap/mprotect different memory regions to PROT_MTE and all
threads will be affected equally.

The only configuration a heap allocator may want to change is the tag
exclude mask (GCR_EL1.Excl) but even this can, by convention, be
configured by the dynamic loader.

> the compat issue with this is existing code using pointer top bits
> which i assume faults when dereferenced with the mte checks enabled.
> (although this should be very rare since top byte ignore on deref is
> aarch64 specific.)

They'd fault only if they dereference PROT_MTE memory and the tag check
mode is async or sync.

> i see two options:
> 
> - don't care about top bit compat issues:
>   change the default in the kernel as you described (so checks are
>   enabled and users only need PROT_MTE mapping if they want to use
>   taggging).

As I said above, suggested by the Google guys, this default choice can
be left with the dynamic loader before any threads are started.

> - care about top bit issues:
>   leave the kernel abi as in the patch set and do the mte setup early
>   in the libc. add elf markings to new binaries that they are mte
>   compatible and libc can use that marking for the mte setup.
>   dlopening incompatible libraries will fail. the issue with this is
>   that we have no idea how to add the marking and the marking prevents
>   mte use with existing binaries (and eg. ldpreload malloc would
>   require an updated libc).

Maybe a third option (which leaves the kernel ABI as is):

If the ELF markings only control the PROT_MTE regions (stack or heap),
we can configure the tag checking mode and tagged address ABI early
through environment variables (_MTAG_ENABLE). If you have a problematic
binary, just set _MTAG_ENABLE=0 and a dlopen, even if loading an
MTE-capable object, would not map the stack with PROT_MTE. Heap
allocators could also ignore _MTAG_ENABLE since PROT_MTE doesn't have an
effect if no tag checking is in place. This way we can probably mix
objects as long as we have a control.

So, in summary, I think we can get away with only issuing the prctl() in
the dynamic loader before any threads start and using PROT_MTE later at
run-time, multi-threaded, as needed by malloc(), dlopen etc.

-- 
Catalin
