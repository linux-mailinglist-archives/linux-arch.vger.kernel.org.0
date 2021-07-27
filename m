Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C463D7407
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 13:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbhG0LH7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 07:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbhG0LH7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 07:07:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711A6C061757
        for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021 04:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PhbOwBwNR5XOCpPJxGyh5dDn91Y6k5Rc4nF3bvIbDQg=; b=I2WYJ1T2et3CIjHYQlJQIzd+6+
        68KIyTZajr8zSpjA6yE2ohuTI0wTeqs+VHnRLna9qkgme42Jj+jilm53Txo9vxfNBHnZSRwPkMVDy
        MkdUBGd8vGpmHbYS1ZCPGJ2dbmwFd0U01cQoapOwM2AgW5l5uaHGlM4Zl40eYjpRCE3NoZEiiZNDa
        nMFAoZ7pWl624sCPxzuaQtVK3tJQgL508iStulhIXFxXOXDwdRGT5b25YLrlNvZEyv1ezpnZYYXnN
        WIPgpjYoPQcvjWwv6n6T+QRlniULt+8SFvvMKWNcNfa5m8DdodGYxWF0uwxdx1lsGpFF8DfxWNZN1
        ZV5fqbUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8KtV-00EwcV-OF; Tue, 27 Jul 2021 11:05:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5F65C300233;
        Tue, 27 Jul 2021 13:05:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 490702018A4F0; Tue, 27 Jul 2021 13:05:05 +0200 (CEST)
Date:   Tue, 27 Jul 2021 13:05:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Guo Ren <guoren@kernel.org>, Waiman Long <llong@redhat.com>,
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
Message-ID: <YP/oYc1A39bMS87H@hirez.programming.kicks-ass.net>
References: <20210724123617.3525377-1-chenhuacai@loongson.cn>
 <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
 <CAAhV-H4aNr2BuG1imx6RcfEQtarjbrUU+-_PbGRg4jX5ygr_iA@mail.gmail.com>
 <YP6Q3s5Kpg2A1NRZ@boqun-archlinux>
 <CAJF2gTQ98v8H3SYt8K0Mnq73xXtZ-2Ja7jOaP2Uo-fX+ZqYZBw@mail.gmail.com>
 <YP7q5GBweaeWgvcs@boqun-archlinux>
 <77e83baf-030c-1332-609c-6d3f01bd422a@redhat.com>
 <CAJF2gTQcmN0TdX2dMT5mqKBp2HJ15_7KzDnaM5VyHaCArrnfGA@mail.gmail.com>
 <YP9vp8/acj9TpwyZ@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP9vp8/acj9TpwyZ@boqun-archlinux>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 27, 2021 at 10:29:59AM +0800, Boqun Feng wrote:

> > "How to implement xchg_tail" shouldn't force with _Q_PENDING_BITS, but
> > the arch could choose.
> 
> I actually agree with this part, but this patchset failed to provide
> enough evidences on why we should choose xchg_tail() implementation
> based on whether hardware has xchg16, more precisely, for an archtecture
> which doesn't have a hardware xchg16, why cmpxchg emulated xchg16() is
> worse than a "load+cmpxchg) implemeneted xchg_tail()? If it's a
> performance reason, please show some numbers.

Right. Their problem is their broken xchg16() implementation.
