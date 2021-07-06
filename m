Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD743BD7E7
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 15:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhGFNlS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 09:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhGFNlS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 09:41:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFD1C061574
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WyUN3WjTwtguxoOsNeOjyV8R5q/61vt5UcBCdQn0DOk=; b=U1lZuUYgZl67UD/ilk8wT4wrGQ
        De9sdtxCnJLV4s+BgM95TwJKHdeyVMJVUGN+qUlwvJU0W2AiyK4qTSzKFBA7fT3/1pHu98oVHw+lD
        5vDQIhL+vI50DAJ9nrQ7Dn48u3BqCc12Zs973IOoljFXfr1gl3J+KloNqyhMt/8OpzolSvP7wRIeT
        cvBO5iVR8WbJ/vf8DIVDeVu6zM/ZYA0snFE76HoPhMi1Z4R6kqDKK7/JOkMv9EsE9sGMeCbuwU1WK
        YnL+aU8hTO+539umDWTqc4cYH5OzlPCopdych0ep62i1bmdvbvws8ziqvHqxqL6GB7tkb+NXELv9G
        Bwk3j7tw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0lGv-00BQal-T7; Tue, 06 Jul 2021 13:38:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3D2A300233;
        Tue,  6 Jul 2021 15:37:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE963200E6658; Tue,  6 Jul 2021 15:37:55 +0200 (CEST)
Date:   Tue, 6 Jul 2021 15:37:55 +0200
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
Message-ID: <YORcs7Ifz+B7a8VS@hirez.programming.kicks-ass.net>
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
> The specific registers are documented at
> https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN#control-and-status-registers

Urrrgghhh.... the AMOs are not only fully sequentially consistent,
they're specified to be completion barriers. That seems horrifically
expensive.

Also, AFAICT there is no forward progress specified for LL/SC :/
