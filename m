Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC140341ED0
	for <lists+linux-arch@lfdr.de>; Fri, 19 Mar 2021 14:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhCSNws (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Mar 2021 09:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhCSNwa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Mar 2021 09:52:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 471DA64F11;
        Fri, 19 Mar 2021 13:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616161950;
        bh=eXYRVG8V5cFHhvvCxRCR6CpklONXTFOtZAF1rugeN1k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aaSzKBB6WrtY0zuvqawgEQnvaHKWbIGyDSanjQm7iV2Hcw4DpxMYu7Sd7V6odgg36
         4H80Ac4DMy3kMqPBNzLlh89krAyZacKoDjKmYE8NpYvm5LtiY/OZxsp4yKwJsKtZBP
         wlr5FlyjFQwaObt+oYxx9QHXq3wsDA1DiIwPyyzan6HPv7x/PA04UWLXNtPrdHD3R4
         PdvbSoE+EV7KI+YhGn9fwJLQfUPLf9wx6R4vniJavbHlIcpxtdnRLj3zRh5QBV7qH6
         Ixfc08P6a7WhWsOYuphp4RNLt25LV7Cws1jcVyVLFxW//GX7LfY43IUZaas4Zx7nSq
         t7ZgtZaxjhaIQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 00923352261C; Fri, 19 Mar 2021 06:52:29 -0700 (PDT)
Date:   Fri, 19 Mar 2021 06:52:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/17] add support for Clang CFI
Message-ID: <20210319135229.GJ2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210318171111.706303-1-samitolvanen@google.com>
 <20210318171111.706303-2-samitolvanen@google.com>
 <YFPUNlOomp173o5B@hirez.programming.kicks-ass.net>
 <CABCJKufkQay5Fk5mZspn4PY2+mBC0CqC5t9QGkKafX4vUQv6Lg@mail.gmail.com>
 <YFSYkyNFb34N8Ile@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFSYkyNFb34N8Ile@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 19, 2021 at 01:26:59PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 18, 2021 at 04:48:43PM -0700, Sami Tolvanen wrote:
> > On Thu, Mar 18, 2021 at 3:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Mar 18, 2021 at 10:10:55AM -0700, Sami Tolvanen wrote:
> > > > +static void update_shadow(struct module *mod, unsigned long base_addr,
> > > > +             update_shadow_fn fn)
> > > > +{
> > > > +     struct cfi_shadow *prev;
> > > > +     struct cfi_shadow *next;
> > > > +     unsigned long min_addr, max_addr;
> > > > +
> > > > +     next = vmalloc(SHADOW_SIZE);
> > > > +
> > > > +     mutex_lock(&shadow_update_lock);
> > > > +     prev = rcu_dereference_protected(cfi_shadow,
> > > > +                                      mutex_is_locked(&shadow_update_lock));
> > > > +
> > > > +     if (next) {
> > > > +             next->base = base_addr >> PAGE_SHIFT;
> > > > +             prepare_next_shadow(prev, next);
> > > > +
> > > > +             min_addr = (unsigned long)mod->core_layout.base;
> > > > +             max_addr = min_addr + mod->core_layout.text_size;
> > > > +             fn(next, mod, min_addr & PAGE_MASK, max_addr & PAGE_MASK);
> > > > +
> > > > +             set_memory_ro((unsigned long)next, SHADOW_PAGES);
> > > > +     }
> > > > +
> > > > +     rcu_assign_pointer(cfi_shadow, next);
> > > > +     mutex_unlock(&shadow_update_lock);
> > > > +     synchronize_rcu_expedited();
> > >
> > > expedited is BAD(tm), why is it required and why doesn't it have a
> > > comment?
> > 
> > Ah, this uses synchronize_rcu_expedited() because we have a case where
> > synchronize_rcu() hangs here with a specific SoC family after the
> > vendor's cpu_pm driver powers down CPU cores.
> 
> Broken vendor drivers seem like an exceedingly poor reason for this.

The vendor is supposed to make sure that RCU sees the CPU cores as either
deep idle or offline before powering them down.  My guess is that the
CPU is powered down, but RCU (and probably much else in the system)
thinks that the CPU is still up and running.  So I bet that you are
seeing other issues as well.

I take it that the IPIs from synchronize_rcu_expedited() have the effect
of momentarily powering up those CPUs?

							Thanx, Paul
