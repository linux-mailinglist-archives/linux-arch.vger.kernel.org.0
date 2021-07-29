Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91193DA1E6
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 13:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbhG2LPm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jul 2021 07:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbhG2LPm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jul 2021 07:15:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF2EC061765;
        Thu, 29 Jul 2021 04:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CblAv96mX27DFrx3HyL6ij0ry5T9+5Rkz5lF7iXCAhs=; b=DlJZj6ih94zYBLueYF1oakpGwr
        /emKwBozMSJYrxlmQEyYJMzpbI5ykbi+rTagIH4Oif2aOeFQ3cHY8h4J3wcJldZXBExLL1UaRqGWL
        QEKGUdwLQTIOpzlRqtj5PeeNyCDBBVqyFg0R3Fe5nZctyAf/OR+lBNBrvExucYhFPGbVJcoy09wV5
        7gE9q8eTcE+2vuGBE7+jUssC0NhxwS8WAJiVQthaegm2UxNpEf0UYQ8RjkslGBr/8rtWd9XuHvlEV
        Fp+CYakW8L/VL9lEYcKJb9z6RMiT2WKZ4UelgK+3OZdQWpFPzMKDIaQ3do7oOXiuy1tcE81iAZEWz
        ZEcCyQIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m940M-003x8x-V5; Thu, 29 Jul 2021 11:15:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 35AB130005A;
        Thu, 29 Jul 2021 13:15:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D8172023ADBD; Thu, 29 Jul 2021 13:15:07 +0200 (CEST)
Date:   Thu, 29 Jul 2021 13:15:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Rui Wang <wangrui@loongson.cn>, Ingo Molnar <mingo@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rui Wang <r@hev.cc>, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        kernel test robot <lkp@intel.com>
Subject: Re: [RFC PATCH v3] locking/atomic: Implement
 atomic{,64,_long}_{fetch_,}{andnot_or}{,_relaxed,_acquire,_release}()
Message-ID: <YQKNu3WeMA/eJrLj@hirez.programming.kicks-ass.net>
References: <20210729093003.146166-1-wangrui@loongson.cn>
 <20210729095551.GE21151@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729095551.GE21151@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 29, 2021 at 10:55:52AM +0100, Will Deacon wrote:

> Overall, I'm not thrilled to bits by extending the atomics API with
> operations that cannot be implemented efficiently on any (?) architectures
> and are only used by the qspinlock slowpath on machines with more than 16K
> CPUs.

My rationale for proposing this primitive is similar to the existence of
other composite atomic ops from the Misc (and refcount) class (as per
atomic_t.txt). They're common/performance sensitive operations that, on
LL/SC platforms, can be better implemented than a cmpxchg() loop.

Specifically here, it can be used to implement short xchg() in an
architecturally neutral way, but more importantly it provides fwd
progress on LL/SC, while most LL/SC based cmpxchg() implementations are
arguably broken there.

People seem to really struggle to implement that sanely.

It's such a shame we can't have the compiler generate sane composite
atomics for us..

> I also think we're lacking documentation justifying when you would use this
> new primitive over e.g. a sub-word WRITE_ONCE() on architectures that
> support those, especially for the non-returning variants.

Given the sub-word ordering 'fun', this might come in handy somewhere
:-) But yes, it's existence is more of a completeness/symmetry argument
than anything else.
