Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B842A341CE9
	for <lists+linux-arch@lfdr.de>; Fri, 19 Mar 2021 13:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCSM1n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Mar 2021 08:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhCSM12 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Mar 2021 08:27:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CCAC06175F;
        Fri, 19 Mar 2021 05:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HGGyfd8GrXRUYl8t/lIrcBczKW5EZl0r2vGbtH69BjM=; b=adFFxpGZQzg62xh/9Ba4l9lwfu
        F6vR/ZaT6jVOK8XBdN443zktlYfZQFE6KzBnW5MwH3eVqjWSvBEUOKrp/4w94gPSdWAWxhHJ3V1wM
        JHocPFEFyKktLVXuAuzwFOWOp/KNeXMoG9xD4e0pSSw5guUU6iX3zwS+9iJaXvGVtoak9cQUiKXdk
        aaTRO8gzVbVR2DUv+LCZp6q/nOcMAZFn5oDnxPol2/x260iyr/gFYohOT8wUIn7bWOGSaBBFsHhXM
        5W9vjiPOxO3G/F43MluX4VccPO0R+IdphdHCQCiZ5xy5MJJ3Wg5a8xTujshBLU4gCmsDllD60Lvyz
        4nI6ItgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lNEDU-004Ogd-1x; Fri, 19 Mar 2021 12:27:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8E33C307975;
        Fri, 19 Mar 2021 13:26:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7709D21244621; Fri, 19 Mar 2021 13:26:59 +0100 (CET)
Date:   Fri, 19 Mar 2021 13:26:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/17] add support for Clang CFI
Message-ID: <YFSYkyNFb34N8Ile@hirez.programming.kicks-ass.net>
References: <20210318171111.706303-1-samitolvanen@google.com>
 <20210318171111.706303-2-samitolvanen@google.com>
 <YFPUNlOomp173o5B@hirez.programming.kicks-ass.net>
 <CABCJKufkQay5Fk5mZspn4PY2+mBC0CqC5t9QGkKafX4vUQv6Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKufkQay5Fk5mZspn4PY2+mBC0CqC5t9QGkKafX4vUQv6Lg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 18, 2021 at 04:48:43PM -0700, Sami Tolvanen wrote:
> On Thu, Mar 18, 2021 at 3:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Mar 18, 2021 at 10:10:55AM -0700, Sami Tolvanen wrote:
> > > +static void update_shadow(struct module *mod, unsigned long base_addr,
> > > +             update_shadow_fn fn)
> > > +{
> > > +     struct cfi_shadow *prev;
> > > +     struct cfi_shadow *next;
> > > +     unsigned long min_addr, max_addr;
> > > +
> > > +     next = vmalloc(SHADOW_SIZE);
> > > +
> > > +     mutex_lock(&shadow_update_lock);
> > > +     prev = rcu_dereference_protected(cfi_shadow,
> > > +                                      mutex_is_locked(&shadow_update_lock));
> > > +
> > > +     if (next) {
> > > +             next->base = base_addr >> PAGE_SHIFT;
> > > +             prepare_next_shadow(prev, next);
> > > +
> > > +             min_addr = (unsigned long)mod->core_layout.base;
> > > +             max_addr = min_addr + mod->core_layout.text_size;
> > > +             fn(next, mod, min_addr & PAGE_MASK, max_addr & PAGE_MASK);
> > > +
> > > +             set_memory_ro((unsigned long)next, SHADOW_PAGES);
> > > +     }
> > > +
> > > +     rcu_assign_pointer(cfi_shadow, next);
> > > +     mutex_unlock(&shadow_update_lock);
> > > +     synchronize_rcu_expedited();
> >
> > expedited is BAD(tm), why is it required and why doesn't it have a
> > comment?
> 
> Ah, this uses synchronize_rcu_expedited() because we have a case where
> synchronize_rcu() hangs here with a specific SoC family after the
> vendor's cpu_pm driver powers down CPU cores.

Broken vendor drivers seem like an exceedingly poor reason for this.

> Would you say expedited is bad enough that we should avoid it here?
> The function is called only when kernel modules are loaded or
> unloaded, so not very frequently.

Module unload is pretty crap (it has stop_machine), so an expedited
would not really be noticable, but module load isn't nearly as bad.

Also, getting the vendor to fix their driver seems like a good thing :-)

So please consider using regular synchronize_rcu() here.
