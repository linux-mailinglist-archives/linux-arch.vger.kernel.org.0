Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E093BCB6B
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 13:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhGFLM1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 07:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhGFLM0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 07:12:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AF4C061574
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 04:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BSHS6F3wvtOuYIjqUXgu407Qc57oWUO1LePitIyGwuQ=; b=g35Tk8fsz6Uyn7UEMXTxREw+uj
        cEWgmHhtaZ/qeXdQarqiDNe9qIz1C8AkBvA5jmNzd2rxZK9PnChN50IDefG6inm4OoiT+eZ6fMSNY
        oDuuSrjcwpQKnsDp5lgbe3QcVQQYlF1LelVJdWKYQgBsp0WllAnuCS3PedgCiC/xnra02gQonl+Ck
        TnXaZyzi+z1aK4yJhaMnPW5g3I4t5XpAilifQXk1XDt+hWr/RTIEb1nH3wrdwzOd74SCK+oknCLtk
        kzfrKfV7t5R3UROUrhox3I6Ai1PWwxwCVfE2x/UoWy/+V9bhgWuMdNAe8adVJRwkH9/uqcPU4FtWN
        7ASzm6UA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0iwv-00BAXZ-2J; Tue, 06 Jul 2021 11:09:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC70E300056;
        Tue,  6 Jul 2021 13:09:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C6F50200843AD; Tue,  6 Jul 2021 13:09:04 +0200 (CEST)
Date:   Tue, 6 Jul 2021 13:09:04 +0200
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
Subject: Re: [PATCH 07/19] LoongArch: Add process management
Message-ID: <YOQ50HDzj0+y00sR@hirez.programming.kicks-ass.net>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-8-chenhuacai@loongson.cn>
 <CAK8P3a3FJSX6U9i0KYDKGVgPxi=OnrJJg73d74=KOkbEBoVa+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3FJSX6U9i0KYDKGVgPxi=OnrJJg73d74=KOkbEBoVa+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 06, 2021 at 12:16:37PM +0200, Arnd Bergmann wrote:
> On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> 
> > +void arch_cpu_idle(void)
> > +{
> > +       local_irq_enable();
> > +       __arch_cpu_idle();
> > +}
> 
> This looks racy: What happens if an interrupt is pending and hits before
> entering __arch_cpu_idle()?

They fix it up in their interrupt handler by moving the IP over the
actual IDLE instruction..

Still the above is broken in that local_irq_enable() will have all sorts
of tracing, but RCU is disabled at this point, so it is still very much
broken.
