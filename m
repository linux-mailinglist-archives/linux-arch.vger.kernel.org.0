Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5063D72F9
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 12:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbhG0KVE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 06:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbhG0KVE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 06:21:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86869C061757
        for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021 03:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+cz+ZGIGpI+ULBkENkV6Hxa8KyCVnNyX+qVfsvDPN/I=; b=MDQA4JU6v1t2gn1BPTp+pIFYO5
        OgbfWf0W5m2Ti0KWD0M9C8DD+/Wsek1Zdy3UsnB+BGR/xTEU/UdwQefeTwGDaBqWUaZRrfVbDnb3K
        JkAQBJW6qNLI4HdIoiinBx39NGfGfV+FIa11z7EniWkmC8Syj78UodQg47BRy+eMgQ0Tm8vaXzoQQ
        bENYvCN6lVegITKKP6ZUVgdTc8ZaRJ/GcJ+el3HPmWjF8xTncfPYrUjseGF1SwGSWMtUfBzWjVILJ
        Ng9m9CJWzs87laTAIANxIO14pijQD/y6HuFm8RBOGBpLYDnGN+Hm33zjbMRdAJgVbjQFEpvgXCQDN
        sRxueyfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8K93-00EuLQ-5X; Tue, 27 Jul 2021 10:17:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C8BBA300233;
        Tue, 27 Jul 2021 12:17:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B29C32018A4F0; Tue, 27 Jul 2021 12:17:04 +0200 (CEST)
Date:   Tue, 27 Jul 2021 12:17:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <llong@redhat.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        Huacai Chen <chenhuacai@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Rui Wang <wangrui@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH RFC 1/2] arch: Introduce ARCH_HAS_HW_XCHG_SMALL
Message-ID: <YP/dIK/xu1w/x/vL@hirez.programming.kicks-ass.net>
References: <20210724123617.3525377-1-chenhuacai@loongson.cn>
 <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
 <CAAhV-H4aNr2BuG1imx6RcfEQtarjbrUU+-_PbGRg4jX5ygr_iA@mail.gmail.com>
 <YP6Q3s5Kpg2A1NRZ@boqun-archlinux>
 <CAJF2gTQ98v8H3SYt8K0Mnq73xXtZ-2Ja7jOaP2Uo-fX+ZqYZBw@mail.gmail.com>
 <YP7q5GBweaeWgvcs@boqun-archlinux>
 <77e83baf-030c-1332-609c-6d3f01bd422a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77e83baf-030c-1332-609c-6d3f01bd422a@redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 26, 2021 at 05:20:55PM -0400, Waiman Long wrote:

> Agreed. The xchg_tail() for the "_Q_PENDING_BITS == 1" case is a software
> emulation of xchg16(). Pure software emulation like that does not provide
> forward progress guarantee. This is usually not a big problem for non-RT
> kernel for which occasional long latency is acceptable, but it is not good
> for RT kernel.

Even !RT doesn't like lock starvation. We've had quite a number of truly
terrible performance problems due to lock starvation over the years.

Please don't categorize this as an RT issue. It is true that RT
absolutely must not have unfair locks, but you can't turn that around
and say that only RT requires fair locks.
