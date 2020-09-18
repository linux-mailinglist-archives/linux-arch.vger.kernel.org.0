Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2657626F859
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 10:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgIRIa6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 04:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIRIa4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Sep 2020 04:30:56 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15F0920789;
        Fri, 18 Sep 2020 08:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600417854;
        bh=9D0z1SsZugKWncAF917lBUeHUBwT91aCT/doalD+wyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BNsmntR+cmDYMEDxWkYxmQT6mYXU4kyO20XaqYiQpLTe6bUFqjA6XfkgG37fsZVBe
         9IJ+AQborTttM9OEA9zaLlbqTVjGWqgLbtiPcZX0rTilDMcgLl6r7kxnHj1W+DS0xW
         wRw+e06y6HeCNQf3YRxho9RBXW3w7GJFBmWqX7Ks=
Date:   Fri, 18 Sep 2020 09:30:48 +0100
From:   Will Deacon <will@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200918083046.GA30709@willie-the-truck>
References: <20200904103029.32083-1-catalin.marinas@arm.com>
 <20200904103029.32083-30-catalin.marinas@arm.com>
 <20200917081107.GA29031@willie-the-truck>
 <20200917090229.GA10662@gaia>
 <20200917161550.GA6642@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917161550.GA6642@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 17, 2020 at 05:15:53PM +0100, Dave Martin wrote:
> On Thu, Sep 17, 2020 at 10:02:30AM +0100, Catalin Marinas wrote:
> > On Thu, Sep 17, 2020 at 09:11:08AM +0100, Will Deacon wrote:
> > > On Fri, Sep 04, 2020 at 11:30:29AM +0100, Catalin Marinas wrote:
> > > > From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > > > 
> > > > Memory Tagging Extension (part of the ARMv8.5 Extensions) provides
> > > > a mechanism to detect the sources of memory related errors which
> > > > may be vulnerable to exploitation, including bounds violations,
> > > > use-after-free, use-after-return, use-out-of-scope and use before
> > > > initialization errors.
> > > > 
> > > > Add Memory Tagging Extension documentation for the arm64 linux
> > > > kernel support.
> > > > 
> > > > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > > > Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> > > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > > Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
> > > 
> > > I'm taking this to mean that Szabolcs is happy with the proposed ABI --
> > > please shout if that's not the case!
> > 
> > I think Szabolcs is still on holiday. To summarise the past threads,
> > AFAICT he's happy with this per-thread control ABI but the discussion
> > went on whether to expand it in the future (with a new bit) to
> > synchronise the tag checking mode across all threads of a process. This
> > adds some complications for the kernel as it needs an IPI to the other
> > CPUs to set SCTLR_EL1 and it's also racy with multiple threads
> > requesting different modes.
> > 
> > Now, in the glibc land, if the tag check mode is controlled via
> > environment variables, the dynamic loader can set this at process start
> > while still in single-threaded mode and not touch it at run-time. The
> > MTE checking can still be enabled at run-time, per mapped memory range
> > via the PROT_MTE flag. This approach doesn't require any additional
> > changes to the current patches. But it's for Szabolcs to confirm once
> > he's back.
> > 
> > > Wasn't there a man page kicking around too? Would be good to see that
> > > go upstream (to the manpages project, of course).
> > 
> > Dave started writing one for the tagged address ABI, not sure where that
> > is. For the MTE additions, we are waiting for the ABI to be upstreamed.
> 
> The tagged address ABI control stuff is upstream in the man-pages-5.08
> release.
> 
> I don't think anyone drafted anything for MTE yet.  Do we consider the
> MTE ABI to be sufficiently stable now for it to be worth starting
> drafting something?

I think so, yes. I'm hoping to queue it for 5.10, once I have an Ack from
the Android tools side on the per-thread ABI.

Will
