Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E03139B489
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2019 18:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436767AbfHWQcx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Aug 2019 12:32:53 -0400
Received: from foss.arm.com ([217.140.110.172]:36952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390061AbfHWQcx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Aug 2019 12:32:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2435328;
        Fri, 23 Aug 2019 09:32:53 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7280E3F246;
        Fri, 23 Aug 2019 09:32:51 -0700 (PDT)
Date:   Fri, 23 Aug 2019 17:32:49 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 3/3] arm64: Relax
 Documentation/arm64/tagged-pointers.rst
Message-ID: <20190823163247.GG27757@arm.com>
References: <20190821164730.47450-1-catalin.marinas@arm.com>
 <20190821164730.47450-4-catalin.marinas@arm.com>
 <20190821173352.yqfgaozi7nfhcofg@willie-the-truck>
 <20190821184649.GD27757@arm.com>
 <20190822155531.GB55798@arrakis.emea.arm.com>
 <20190822163723.GF27757@arm.com>
 <20190823161912.GJ29387@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823161912.GJ29387@arrakis.emea.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 23, 2019 at 05:19:13PM +0100, Catalin Marinas wrote:
> On Thu, Aug 22, 2019 at 05:37:23PM +0100, Dave P Martin wrote:
> > On Thu, Aug 22, 2019 at 04:55:32PM +0100, Catalin Marinas wrote:
> > > On Wed, Aug 21, 2019 at 07:46:51PM +0100, Dave P Martin wrote:

[...]

> > > > sigaltstack() is interesting, since we don't support tagged stacks.
> > > 
> > > We should support tagged SP with the new ABI as they'll be required for
> > > MTE. sigaltstack() and clone() are the two syscalls that come to mind
> > > here.
> > > 
> > > > Do we keep the ss_sp tag in the kernel, but squash it when delivering
> > > > a signal to the alternate stack?
> > > 
> > > We don't seem to be doing any untagging, so we just just use whatever
> > > the caller asked for. We may need a small test to confirm.
> > 
> > If we want to support tagged SP, then I guess we shouldn't be squashing
> > the tag anywhere.  A test for that would be sensible to have.
> 
> I hacked the sas.c kselftest to use a tagged stack and works fine, the
> SP register has a tagged address on the signal handler.

Cool...

[...]

> > > > There is no foolproof rule, unless we can rewrite history...
> > > 
> > > I would expect the norm to be the preservation of tags with a few
> > > exceptions. The only ones I think where we won't preserve the tags are
> > > mmap, mremap, brk (apart from the signal stuff already mentioned in the
> > > current tagged-pointers.rst doc).
> > > 
> > > So I can remove this paragraph altogether and add a note in part 3 of
> > > the tagged-address-abi.rst document that mmap/mremap/brk do not preserve
> > > the tag information.
> > 
> > Deleting text is always a good idea ;)
> 
> I'm going this route ;).

[reply deleted]

Cheers
---Dave
