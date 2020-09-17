Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA6726E0A6
	for <lists+linux-arch@lfdr.de>; Thu, 17 Sep 2020 18:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgIQQ0B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Sep 2020 12:26:01 -0400
Received: from foss.arm.com ([217.140.110.172]:48810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728496AbgIQQZZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Sep 2020 12:25:25 -0400
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 12:25:25 EDT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76B0D11D4;
        Thu, 17 Sep 2020 09:15:57 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAA243F68F;
        Thu, 17 Sep 2020 09:15:55 -0700 (PDT)
Date:   Thu, 17 Sep 2020 17:15:53 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        libc-alpha@sourceware.org, Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200917161550.GA6642@arm.com>
References: <20200904103029.32083-1-catalin.marinas@arm.com>
 <20200904103029.32083-30-catalin.marinas@arm.com>
 <20200917081107.GA29031@willie-the-truck>
 <20200917090229.GA10662@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917090229.GA10662@gaia>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 17, 2020 at 10:02:30AM +0100, Catalin Marinas wrote:
> On Thu, Sep 17, 2020 at 09:11:08AM +0100, Will Deacon wrote:
> > On Fri, Sep 04, 2020 at 11:30:29AM +0100, Catalin Marinas wrote:
> > > From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > > 
> > > Memory Tagging Extension (part of the ARMv8.5 Extensions) provides
> > > a mechanism to detect the sources of memory related errors which
> > > may be vulnerable to exploitation, including bounds violations,
> > > use-after-free, use-after-return, use-out-of-scope and use before
> > > initialization errors.
> > > 
> > > Add Memory Tagging Extension documentation for the arm64 linux
> > > kernel support.
> > > 
> > > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > > Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
> > 
> > I'm taking this to mean that Szabolcs is happy with the proposed ABI --
> > please shout if that's not the case!
> 
> I think Szabolcs is still on holiday. To summarise the past threads,
> AFAICT he's happy with this per-thread control ABI but the discussion
> went on whether to expand it in the future (with a new bit) to
> synchronise the tag checking mode across all threads of a process. This
> adds some complications for the kernel as it needs an IPI to the other
> CPUs to set SCTLR_EL1 and it's also racy with multiple threads
> requesting different modes.
> 
> Now, in the glibc land, if the tag check mode is controlled via
> environment variables, the dynamic loader can set this at process start
> while still in single-threaded mode and not touch it at run-time. The
> MTE checking can still be enabled at run-time, per mapped memory range
> via the PROT_MTE flag. This approach doesn't require any additional
> changes to the current patches. But it's for Szabolcs to confirm once
> he's back.
> 
> > Wasn't there a man page kicking around too? Would be good to see that
> > go upstream (to the manpages project, of course).
> 
> Dave started writing one for the tagged address ABI, not sure where that
> is. For the MTE additions, we are waiting for the ABI to be upstreamed.

The tagged address ABI control stuff is upstream in the man-pages-5.08
release.

I don't think anyone drafted anything for MTE yet.  Do we consider the
MTE ABI to be sufficiently stable now for it to be worth starting
drafting something?

Cheers
---Dave
