Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542DD43AC94
	for <lists+linux-arch@lfdr.de>; Tue, 26 Oct 2021 09:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbhJZHFc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Oct 2021 03:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbhJZHFc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Oct 2021 03:05:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB13DC061745;
        Tue, 26 Oct 2021 00:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yOVnpOO/5xsqTdBpo8mL+Ltjo2bLl6z6mBz9wfQs/DU=; b=ks6XJRXZ5y+5VZcS3b5DVFHuqj
        R9oUANLsSYe37eQrtvDX126RQYf+lPZEPWmvuhGQ4o356l9iBFF8829wsy8egyeDwSlvnKtazLWAa
        mCnwksJ2D17DCw8nZDGUolL1V3Q0NGVaY5a7DH0Ydl1Yfyksisj36ZT6ZJkAUI+Dgz11z8HvHK0Ch
        CqQFlapn7fuBIgJ8k9v0WwRZofbEIP/zn/q0Kj/cAaEMAAwCOmCRopc4wdJA+eMitPQf99ZXJcwWI
        NnX4/cewNHYkbaDUhtT+Pi8gZPkfljpCLmW+ez/EuIuYXH1FyNa9VRw+k7Vo4H+UO+idBmtkfdTNA
        Zi8WWM0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfGQK-00GfiF-3E; Tue, 26 Oct 2021 06:59:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5BB443001BF;
        Tue, 26 Oct 2021 08:59:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 388392D80369E; Tue, 26 Oct 2021 08:59:01 +0200 (CEST)
Date:   Tue, 26 Oct 2021 08:59:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E . McKenney " <paulmck@kernel.org>,
        Dan Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephane Eranian <eranian@google.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mpe@ellerman.id.au,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC v2 0/3] memory model: Make unlock(A)+lock(B) on the same
 CPU RCtso
Message-ID: <YXenNR6SX5Jot5Dt@hirez.programming.kicks-ass.net>
References: <20211025145416.698183-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025145416.698183-1-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 25, 2021 at 10:54:13PM +0800, Boqun Feng wrote:
> Boqun Feng (3):
>   tools/memory-model: Provide extra ordering for unlock+lock pair on the
>     same CPU
>   tools/memory-model: doc: Describe the requirement of the litmus-tests
>     directory
>   tools/memory-model: litmus: Add two tests for unlock(A)+lock(B)
>     ordering

I'm obviously all in favour of this :-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
