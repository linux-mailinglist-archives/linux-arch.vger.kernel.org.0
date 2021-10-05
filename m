Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D884225DF
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 14:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhJEMF5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 08:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbhJEMF4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 08:05:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6233EC06174E;
        Tue,  5 Oct 2021 05:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ssIz8dxHAZ6IED8P8Bx3CPoq2/dqQqF2DGl8wwvM3UU=; b=ugZGH/+jwI8TlL3iHvlwL6thJV
        LBKF0ZKvz9k7Pc22sM90mPiDJfgEV3XpkyRZJeATMt9AbXFhq5MRfjCxu8lDVzXdET+XdAUjHVTXF
        hVy99snz4XjdpFWzoLwKub+8tJSzNPQ91qbFgEe+8MI6bjHiF51C0bQCybqlIS57h6taO4QRFyrMi
        mCMgTZhhaWewxelrfkJhutOrsrK8y/5rHSYrPHf075uEkdmlNm6xmQ5pAzMuIPWWpyqDpCJ7mYUU3
        wu1bbrsU6dH9yNYEwMgfSigG0uDuEiCyqTQR/y3cJFgrZ1gAIk2tJFazwxQ9V8RGOnpE+x9+KNCS9
        XX6RRR4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXj9c-000PjY-SI; Tue, 05 Oct 2021 12:02:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4732430026F;
        Tue,  5 Oct 2021 14:02:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27D732026A8AF; Tue,  5 Oct 2021 14:02:40 +0200 (CEST)
Date:   Tue, 5 Oct 2021 14:02:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH -rcu/kcsan 16/23] locking/atomics, kcsan: Add
 instrumentation for barriers
Message-ID: <YVw+4McyFdvU7ZED@hirez.programming.kicks-ass.net>
References: <20211005105905.1994700-1-elver@google.com>
 <20211005105905.1994700-17-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005105905.1994700-17-elver@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 05, 2021 at 12:58:58PM +0200, Marco Elver wrote:
> @@ -59,6 +60,7 @@ atomic_add(int i, atomic_t *v)
>  static __always_inline int
>  atomic_add_return(int i, atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_add_return(i, v);
>  }

This and others,.. is this actually correct? Should that not be
something like:

	kscan_mb();
	instrument_atomic_read_write(...);
	ret = arch_atomic_add_return(i, v);
	kcsan_mb();
	return ret;

?
