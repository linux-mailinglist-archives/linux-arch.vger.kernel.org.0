Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6844A39C336
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jun 2021 00:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhFDWHv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 18:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhFDWHs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 18:07:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F16C061766;
        Fri,  4 Jun 2021 15:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C6vKHA3xVyPVc71h+aqVjU0kS8fj+tvFZ8wJ00ZjTjU=; b=uinDlZpqBviYk1MDGUnitgDfDo
        irMekxr8ru5A1xDgBy6cZ28d41IvJbf75SoG3uHEiY1W1kwq3IUpadmjAF5Wd+Woaoh/GDsPvEBi/
        J9l6yt0dJ+XKKkfM+irkF/a2ZsCpO7tlOroxXdw8S50HKPCTDml76jCCAV1lYRIBNKpc6FYbfne3t
        pgxWOY/Fmve7TM3kTp4fcL84JcEPJAMr8MOjdF074/bIp3rWBbaboMaUf5FNyJH/1kXac3LyKX4pH
        1SEfQsMWQHGyVIFdp6Hj/fWYMiElPYB8cGQeEJNoRouOpfwu1fLQasDASeGEgCRrhIqQmlQRimtBX
        hfTK58Sg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lpHwM-00DdL3-6H; Fri, 04 Jun 2021 22:05:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ACD64300223;
        Sat,  5 Jun 2021 00:05:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 918412BC0001B; Sat,  5 Jun 2021 00:05:16 +0200 (CEST)
Date:   Sat, 5 Jun 2021 00:05:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <YLqjnNBGhd320Ix9@hirez.programming.kicks-ass.net>
References: <20210604151356.GC2793@willie-the-truck>
 <YLpFHE5Cr45rWTUV@hirez.programming.kicks-ass.net>
 <YLpJ5K6O52o1cAVT@hirez.programming.kicks-ass.net>
 <20210604155154.GG1676809@rowland.harvard.edu>
 <YLpSEM7sxSmsuc5t@hirez.programming.kicks-ass.net>
 <20210604182708.GB1688170@rowland.harvard.edu>
 <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
 <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 02:27:49PM -0700, Linus Torvalds wrote:
> On Fri, Jun 4, 2021 at 1:56 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > The usual way to prevent it is to use WRITE_ONCE().
> 
> The very *documentation example* for "volatile_if()" uses that WRITE_ONCE().
> 
> IOW, the patch that started this discussion has this comment in it:
> 
> +/**
> + * volatile_if() - Provide a control-dependency
> + *
> + * volatile_if(READ_ONCE(A))
> + *     WRITE_ONCE(B, 1);
> + *
> + * will ensure that the STORE to B happens after the LOAD of A.

We do actually have uses what use a 'regular' store, and not a
WRITE_ONCE(). And I think for those the added barrier() might make a
difference.

At the very least the perf ring-buffer case uses memcpy().

On my part I'm deeply distrusting some of the C language committee
proposals I've seen regarding this stuff, and I'm maybe worrying too
much, but I'd rather not have to debug anything like this when they do
manage to make it go bad.

On top of that, I think having the construct is good for documenting
intent and possibly some of the concurrency analyzers can make use of
it.
