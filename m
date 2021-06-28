Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165DD3B675B
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 19:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhF1RNz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 13:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhF1RNz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 13:13:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A14C061574;
        Mon, 28 Jun 2021 10:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N8xCdH0ayOU0iwwLcN7/GpC9KeGAtQxK6HyluXNHYec=; b=TZBFAh8SnqwcMvQ1YA7uePM/24
        4FoZGKYAv9fHbLCyiVbs296M9LmK3RyZLXN/f5DGYubktGJMN2oZXHqNXjreRXzq7+AiQYN3f/Qod
        eX2jV+OSBUtLh1IUgHkoJDJPyasuCHbaWmqx8JyMvA7Yd2MchD/Pv4bav82L4qcyRgehvzFlTdbbK
        Wp6pQ+RjLJARnJLtDb2RKvuQoVUgQ64Y2DfCMuyPnWcpzuBwwey0wRIJIj9nJQPfSiw2SWVg9QQce
        WYf8l1jjapiqCnMlEFxl7EF+D/1+7D8WfLfa4T9mTun92p7mT/AKQ15gXcE2oPpwEWwS//vono0tj
        YCkydJ4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxumz-00Cc0B-Af; Mon, 28 Jun 2021 17:11:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 395B0982D9E; Mon, 28 Jun 2021 19:11:16 +0200 (CEST)
Date:   Mon, 28 Jun 2021 19:11:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thiago Macieira <thiago.macieira@intel.com>
Cc:     fweimer@redhat.com,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        hjl.tools@gmail.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org
Subject: Re: x86 CPU features detection for applications (and AMX)
Message-ID: <20210628171115.GA13401@worktop.programming.kicks-ass.net>
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1>
 <2379132.fg5cGID6mU@tjmaciei-mobl1>
 <YNnqXCSVUhYhzT6T@hirez.programming.kicks-ass.net>
 <2094802.S4rhTtsRBG@tjmaciei-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2094802.S4rhTtsRBG@tjmaciei-mobl1>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 28, 2021 at 09:13:29AM -0700, Thiago Macieira wrote:
> On Monday, 28 June 2021 08:27:24 PDT Peter Zijlstra wrote:
> > > That's what cpuid is for. With GCC function multi-versioning or equivalent
> > > manually-rolled solutions, you can get exactly what you're asking for.
> > 
> > Right, lots of self-modifying code solutions there, some of which can be
> > linker driven, some not. In the kernel we use alternative() to replace
> > short code sequences depending on CPUID.
> > 
> > Userspace *could* do the same, rewriting code before first execution is
> > fairly straight forward.
> 
> Userspace shouldn't do SMC. It's bad enough that JITs without caching exist, 
> but having pure paged code is better. Pure pages are shared as needed by the 
> kernel.

I don't feel that strongly; if SMC gets you measurable performance
gains, go for it. If you're short on memory, buy more.

> All you need is a simple bit test. You can then either branch to different 
> code paths or write to a function pointer so it'll go there directly the next 
> time. You can also choose to load different plugins depending on what CPU 
> features were found.

Both bit tests and indirect function calls suffer the extra memory load,
which is not free.

> Consequence: CPU feature checking is done *very* early, often before main().

For the linker based ones, yes. IIRC the ifunc() attribute is
particularly useful here.
