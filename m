Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4196226D752
	for <lists+linux-arch@lfdr.de>; Thu, 17 Sep 2020 11:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgIQJCi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Sep 2020 05:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgIQJCf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Sep 2020 05:02:35 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B24B820770;
        Thu, 17 Sep 2020 09:02:32 +0000 (UTC)
Date:   Thu, 17 Sep 2020 10:02:30 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v9 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200917090229.GA10662@gaia>
References: <20200904103029.32083-1-catalin.marinas@arm.com>
 <20200904103029.32083-30-catalin.marinas@arm.com>
 <20200917081107.GA29031@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917081107.GA29031@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 17, 2020 at 09:11:08AM +0100, Will Deacon wrote:
> On Fri, Sep 04, 2020 at 11:30:29AM +0100, Catalin Marinas wrote:
> > From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > 
> > Memory Tagging Extension (part of the ARMv8.5 Extensions) provides
> > a mechanism to detect the sources of memory related errors which
> > may be vulnerable to exploitation, including bounds violations,
> > use-after-free, use-after-return, use-out-of-scope and use before
> > initialization errors.
> > 
> > Add Memory Tagging Extension documentation for the arm64 linux
> > kernel support.
> > 
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
> 
> I'm taking this to mean that Szabolcs is happy with the proposed ABI --
> please shout if that's not the case!

I think Szabolcs is still on holiday. To summarise the past threads,
AFAICT he's happy with this per-thread control ABI but the discussion
went on whether to expand it in the future (with a new bit) to
synchronise the tag checking mode across all threads of a process. This
adds some complications for the kernel as it needs an IPI to the other
CPUs to set SCTLR_EL1 and it's also racy with multiple threads
requesting different modes.

Now, in the glibc land, if the tag check mode is controlled via
environment variables, the dynamic loader can set this at process start
while still in single-threaded mode and not touch it at run-time. The
MTE checking can still be enabled at run-time, per mapped memory range
via the PROT_MTE flag. This approach doesn't require any additional
changes to the current patches. But it's for Szabolcs to confirm once
he's back.

> Wasn't there a man page kicking around too? Would be good to see that
> go upstream (to the manpages project, of course).

Dave started writing one for the tagged address ABI, not sure where that
is. For the MTE additions, we are waiting for the ABI to be upstreamed.

-- 
Catalin
