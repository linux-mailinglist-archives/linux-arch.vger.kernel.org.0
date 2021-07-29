Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29E23D9F7F
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 10:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhG2IZo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jul 2021 04:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbhG2IZo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jul 2021 04:25:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862DEC061757
        for <linux-arch@vger.kernel.org>; Thu, 29 Jul 2021 01:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pVhr7FGv/KVWDE9CUy8/SrPaJWr9SXesJ8dnccwOHB4=; b=p+GoH660uVuZYkJPhp9/5iIU+W
        rNepabxkjLhSXDBcUmCW7OSpMfqkfQ7n5oXPEX4zi3P9HUq3pypD7JjKD01kYb+xDrv5ruK2IQEAe
        LFZW2jb2vNb6MpoOf0iaXfKV0Sc7K+1S3VuFV14Caif62XY5oxSuqMrtT9lLpJQyS0D974EaJHdJE
        hFHOm4MUrQB7E/Xo4pCfw6ZEF6j1T6VWXDuDiH7yAufD9OECMaJ1On9y9nYzeM3fXJJlH9iNIA2ko
        NGfFogvdn/Dtqv7w2ZxoZCqxGnQcLjXQrMNQgk4pi+VE7KP5k0wODrvHBPeUvI+tToBEs7dUSayL/
        6RaDcDzA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m91KB-00Gsvd-1P; Thu, 29 Jul 2021 08:23:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 342D530005A;
        Thu, 29 Jul 2021 10:23:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0F32D2028E9B4; Thu, 29 Jul 2021 10:23:23 +0200 (CEST)
Date:   Thu, 29 Jul 2021 10:23:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     hev <r@hev.cc>
Cc:     Rui Wang <wangrui@loongson.cn>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH v1 1/5] locking/atomic: Implement atomic_fetch_and_or
Message-ID: <YQJle+vqR4i1wJal@hirez.programming.kicks-ass.net>
References: <20210728114822.1243-1-wangrui@loongson.cn>
 <YQFUe+QsHfBIgQev@hirez.programming.kicks-ass.net>
 <YQFYxr/2Zr7UclaN@hirez.programming.kicks-ass.net>
 <YQFZxuwQGiuWHxJL@hirez.programming.kicks-ass.net>
 <CAHirt9hBeLq8jejZZDLQkbc1rb6hDRD9w0QpFGJastrOsYe5vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHirt9hBeLq8jejZZDLQkbc1rb6hDRD9w0QpFGJastrOsYe5vg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 29, 2021 at 09:58:02AM +0800, hev wrote:
> Hi, Peter,
> 
> On Wed, Jul 28, 2021 at 9:21 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Jul 28, 2021 at 03:16:54PM +0200, Peter Zijlstra wrote:
> > > On Wed, Jul 28, 2021 at 02:58:35PM +0200, Peter Zijlstra wrote:
> > > > The below isn't quite right, because it'll use try_cmpxchg() for
> > > > atomic_andnot_or(), which by being a void atomic should be _relaxed. I'm
> > > > not entirely sure how to make that happen in a hurry.
> > > >
> > > > ---
> > >
> > > This seems to do the trick.
> > >
> >
> > Mark suggested this, which is probably nicer still.
> Wow, Amazing! so the architecture dependent can be implemented one by one.

Nah, this is just the fallback, you still need individual arch code to
optimize this and get proper LL/SC primitives.
