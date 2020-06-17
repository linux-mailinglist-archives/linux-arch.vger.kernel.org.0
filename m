Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F5E1FC840
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jun 2020 10:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgFQIEM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Jun 2020 04:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgFQIEM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Jun 2020 04:04:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91CE021475;
        Wed, 17 Jun 2020 08:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592381051;
        bh=MjCLvKpmywtlENNu3L8WcjVAZUYXfsV93TDu3ReXKuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JTiufBj0BMszSpkVUzi+gNk/qprMzw2wYVoJRieWtNmkrCUlTJiL+eUPkxjEPJZ7D
         Pl+CdboZUILER+bWki4NgM0L7KE262coRqRGnhsGEroSN9Uf1CdlIdoIHJwTchzbUV
         5UjKXESI9ZrCTGdCfmJKt9pER0l8tsQDgS//NF2k=
Date:   Wed, 17 Jun 2020 09:04:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        openrisc@lists.librecores.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 00/25] mm: Page fault accounting cleanups
Message-ID: <20200617080405.GA3208@willie-the-truck>
References: <20200615221607.7764-1-peterx@redhat.com>
 <CAHk-=wiTjaXHu+uxMi0xCZQOm4KVr0MucECAK=Zm4p4YZZ1XEg@mail.gmail.com>
 <87imfqecjx.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imfqecjx.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 17, 2020 at 10:55:14AM +1000, Michael Ellerman wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> > On Mon, Jun 15, 2020 at 3:16 PM Peter Xu <peterx@redhat.com> wrote:
> >> This series tries to address all of them by introducing mm_fault_accounting()
> >> first, so that we move all the page fault accounting into the common code base,
> >> then call it properly from arch pf handlers just like handle_mm_fault().
> >
> > Hmm.
> >
> > So having looked at this a bit more, I'd actually like to go even
> > further, and just get rid of the per-architecture code _entirely_.
> 
> <snip>
> 
> > One detail worth noting: I do wonder if we should put the
> >
> >     perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
> >
> > just in the arch code at the top of the fault handling, and consider
> > it entirely unrelated to the major/minor fault handling. The
> > major/minor faults fundamnetally are about successes. But the plain
> > PERF_COUNT_SW_PAGE_FAULTS could be about things that fail, including
> > things that never even get to this point at all.
> 
> Yeah I think we should keep it in the arch code at roughly the top.

I agree. It's a nice idea to consolidate the code, but I don't see that
it's really possible for PERF_COUNT_SW_PAGE_FAULTS without significantly
changing the semantics (and a potentially less useful way. Of course,
moving more of do_page_fault() out of the arch code would be great, but
that's a much bigger effort.

> If it's moved to the end you could have a process spinning taking bad
> page faults (and fixing them up), and see no sign of it from the perf
> page fault counters.

The current arm64 behaviour is that we record PERF_COUNT_SW_PAGE_FAULTS
if _all_ of the following are true:

  1. The fault isn't handled by kprobes
  2. The pagefault handler is enabled
  3. We have an mm (current->mm)
  4. The fault isn't an unexpected kernel fault on a user address (we oops
     and kill the task in this case)

Which loosely corresponds to "we took a fault on a user address that it
looks like we can handle".

That said, I'm happy to tweak this if it brings us into line with other
architectures.

Will
