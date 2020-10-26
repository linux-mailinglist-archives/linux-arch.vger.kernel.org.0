Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5412299442
	for <lists+linux-arch@lfdr.de>; Mon, 26 Oct 2020 18:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788380AbgJZRsj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Oct 2020 13:48:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35270 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775447AbgJZRsi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Oct 2020 13:48:38 -0400
X-Greylist: delayed 2257 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 13:48:38 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3A9q2IhbrbbgCoZBVLOX5wUlF9BQu6Y6eHOrbw86Mcc=; b=BQxuNr6voGvi5oh8K7c+jdPvn8
        fwncWQ5lOSomWpTsu15ATlZGZcMmGBNaB5gElLpMYM/f26jqlVqG5WRsEFBh///pMNMn9h0KfCbnW
        p4G6OZ8XMtmxt07GK7Lz/xAjUJ3cIU4bSK51WVepY3p3q+rPnUUXkXtfEp53J6qph+vFCP4oRkc73
        Tatb6wD665L3jvldjF+3xO1zGzeJwqCMT5pxrEk8h5ABUbn9DD+dsfl4g3rDP+kZslOuk2zUXgciX
        o8jsaonQ1WFVIQWD9NS9GiAttlt5LTWbDUjkBBlE4/tXfrv14MQSlghB17MNU61G+O9tNN+GqLadJ
        UP+marPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX61A-0000AK-NS; Mon, 26 Oct 2020 17:10:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 34608301179;
        Mon, 26 Oct 2020 18:10:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EEAC8203BE3CA; Mon, 26 Oct 2020 18:10:45 +0100 (CET)
Date:   Mon, 26 Oct 2020 18:10:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qspinlock: use signed temporaries for cmpxchg
Message-ID: <20201026171045.GU2611@hirez.programming.kicks-ass.net>
References: <20201026165807.3724647-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026165807.3724647-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 26, 2020 at 05:57:51PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When building with W=2, the build log is flooded with
> 
> include/asm-generic/qrwlock.h:65:56: warning: pointer targets in passing argument 2 of 'atomic_try_cmpxchg_acquire' differ in signedness [-Wpointer-sign]
> include/asm-generic/qrwlock.h:92:53: warning: pointer targets in passing argument 2 of 'atomic_try_cmpxchg_acquire' differ in signedness [-Wpointer-sign]
> include/asm-generic/qspinlock.h:68:55: warning: pointer targets in passing argument 2 of 'atomic_try_cmpxchg_acquire' differ in signedness [-Wpointer-sign]
> include/asm-generic/qspinlock.h:82:52: warning: pointer targets in passing argument 2 of 'atomic_try_cmpxchg_acquire' differ in signedness [-Wpointer-sign]
> 
> The atomics are built on top of signed integers, but the caller
> doesn't actually care. Just use signed types as well.
> 

Yuck, no. This is actively wrong. All that code very much wants u32.
