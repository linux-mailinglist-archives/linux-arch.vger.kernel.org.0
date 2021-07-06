Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46CA3BD7A8
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 15:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhGFNXj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 09:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhGFNXi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 09:23:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4CBC061574
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K0706JRNDzoQiZZIh9q5Y4phH0/9XsqLzB5w3baWLPI=; b=hJoyy0HauuwJbwOhsTSL0jQQD+
        kNJG47OB8zEJ0xBpYErUK8EcvXPLInXyb/eeUEzaM98HxsdkXl31Tp+KvI/JqYfOQ8PbmB5qapsKL
        KA7dE4wNOUrHEs7f0Tk1qHhMuZkSFHdiGuXfN4nzO11EiWP14KTJF54POdjF1hXjKkBqBGrYlx6Z/
        5KPELaMtx9umgQqOBnsS1EuBDwbJbuW8VHPLJCMEUfYpgO6bnnJ8SsyQpA9hiLsh4OC5lt5XoQd4Y
        B0geaxmqXy4d5kn6taCpW3F8C4834PvjZDKf64Xq681oiaarks6hB+/NGMAeVjkXiU55PlRzl0Plx
        LjO5W3lw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0l0F-00F39D-Bk; Tue, 06 Jul 2021 13:20:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D9728300233;
        Tue,  6 Jul 2021 15:20:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C352F201C57F9; Tue,  6 Jul 2021 15:20:41 +0200 (CEST)
Date:   Tue, 6 Jul 2021 15:20:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 04/19] LoongArch: Add common headers
Message-ID: <YORYqZOrL94aEzLY@hirez.programming.kicks-ass.net>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-5-chenhuacai@loongson.cn>
 <YOQ9MGbTrPKWl1N/@hirez.programming.kicks-ass.net>
 <CAK8P3a1wCYB6KgHP_ZbmEyPcoNkEzXD_RbNuuy13nA1pVP+Tqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1wCYB6KgHP_ZbmEyPcoNkEzXD_RbNuuy13nA1pVP+Tqg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 06, 2021 at 02:59:22PM +0200, Arnd Bergmann wrote:
> On Tue, Jul 6, 2021 at 1:23 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Jul 06, 2021 at 12:18:05PM +0800, Huacai Chen wrote:
> 
> > > +
> > > +static inline u32 csr_xchgl(u32 val, u32 mask, u32 reg)
> > > +{
> > > +     return __csrxchg(val, mask, reg);
> > > +}
> > > +
> > > +static inline u64 csr_xchgq(u64 val, u64 mask, u32 reg)
> > > +{
> > > +     return __dcsrxchg(val, mask, reg);
> > > +}
> >
> > What are these __csrfoo() things, I cannot seem to find a definition of
> > them anywhere..
> 
> It seems that those are provided as compiler intrinsics in <larchintrin.h>,
> based on an architecture specific __builtin_loongarch_csrxchg() etc.

Thanks, I couldn't find them.

> The specific registers are documented at
> https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN#control-and-status-registers

Bah, that's terrible naming. CSRWR really is CSRXCHG and CSRXCHG is more
like CSRXCHGMASK or something :/

