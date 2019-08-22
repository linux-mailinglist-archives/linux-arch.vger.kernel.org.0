Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94F499995A
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2019 18:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfHVQh2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Aug 2019 12:37:28 -0400
Received: from foss.arm.com ([217.140.110.172]:48862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730760AbfHVQh1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Aug 2019 12:37:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F16E28;
        Thu, 22 Aug 2019 09:37:27 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B9283F718;
        Thu, 22 Aug 2019 09:37:25 -0700 (PDT)
Date:   Thu, 22 Aug 2019 17:37:23 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 3/3] arm64: Relax
 Documentation/arm64/tagged-pointers.rst
Message-ID: <20190822163723.GF27757@arm.com>
References: <20190821164730.47450-1-catalin.marinas@arm.com>
 <20190821164730.47450-4-catalin.marinas@arm.com>
 <20190821173352.yqfgaozi7nfhcofg@willie-the-truck>
 <20190821184649.GD27757@arm.com>
 <20190822155531.GB55798@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822155531.GB55798@arrakis.emea.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 22, 2019 at 04:55:32PM +0100, Catalin Marinas wrote:
> On Wed, Aug 21, 2019 at 07:46:51PM +0100, Dave P Martin wrote:
> > On Wed, Aug 21, 2019 at 06:33:53PM +0100, Will Deacon wrote:
> > > On Wed, Aug 21, 2019 at 05:47:30PM +0100, Catalin Marinas wrote:
> > > > @@ -59,6 +63,11 @@ be preserved.
> > > >  The architecture prevents the use of a tagged PC, so the upper byte will
> > > >  be set to a sign-extension of bit 55 on exception return.
> > > >  
> > > > +This behaviour is maintained when the AArch64 Tagged Address ABI is
> > > > +enabled. In addition, with the exceptions above, the kernel will
> > > > +preserve any non-zero tags passed by the user via syscalls and stored in
> > > > +kernel data structures (e.g. ``set_robust_list()``, ``sigaltstack()``).
> > 
> > sigaltstack() is interesting, since we don't support tagged stacks.
> 
> We should support tagged SP with the new ABI as they'll be required for
> MTE. sigaltstack() and clone() are the two syscalls that come to mind
> here.
> 
> > Do we keep the ss_sp tag in the kernel, but squash it when delivering
> > a signal to the alternate stack?
> 
> We don't seem to be doing any untagging, so we just just use whatever
> the caller asked for. We may need a small test to confirm.

If we want to support tagged SP, then I guess we shouldn't be squashing
the tag anywhere.  A test for that would be sensible to have.

> That said, on_sig_stack() probably needs some untagging as it does user
> pointer arithmetics with potentially different tags.

Good point.

> > > Hmm. I can see the need to provide this guarantee for things like
> > > set_robust_list(), but the problem is that the statement above is too broad
> > > and isn't strictly true: for example, mmap() doesn't propagate the tag of
> > > its address parameter into the VMA.
> > > 
> > > So I think we need to nail this down a bit more, but I'm having a really
> > > hard time coming up with some wording :(
> > 
> > Time for some creative vagueness?
> > 
> > We can write a statement of our overall intent, along with examples of
> > a few cases where the tag should and should not be expected to emerge
> > intact.
> > 
> > There is no foolproof rule, unless we can rewrite history...
> 
> I would expect the norm to be the preservation of tags with a few
> exceptions. The only ones I think where we won't preserve the tags are
> mmap, mremap, brk (apart from the signal stuff already mentioned in the
> current tagged-pointers.rst doc).
> 
> So I can remove this paragraph altogether and add a note in part 3 of
> the tagged-address-abi.rst document that mmap/mremap/brk do not preserve
> the tag information.

Deleting text is always a good idea ;)

There are other cases like (non-)propagation of the tag to si_addr
when a fault is reported via a signal, but I think we already have
appropriate wording to cover that.

Cheers
---Dave
