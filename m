Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93922ED02F
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jan 2021 13:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbhAGMqZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jan 2021 07:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbhAGMqZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jan 2021 07:46:25 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75397C0612F5;
        Thu,  7 Jan 2021 04:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DWW1LEFK63XItEvu4mOGMM8qQzgwQTYERoYCjLDAlxY=; b=yxYgd/Tn0UHwRDRnySbE9flYKt
        36kvb4PZDVuB3+CsavRLHYj8xh35vd/98qYzRSLRSV6ztJLveY/3rfJjQwucAqdINQ3YgePrs6WaJ
        AwphbYKnu+wx2M2jvVbsNmaUetj/xk+18BLRGcIsX4CQwi51VI7qMKkFKbYi8eHZSCfy0NvQjBICf
        /zVTAA8tSKgK4areraHdcDZ4+pnjYaIV5LRzkA1ZNu9mJUWzW3TI2Rd+uLTHY/NhYhFxkl4apc+Dw
        IMQc7GBwPfoEjsIcjMM7hoBqgVoEO6+wRwNP0iTEMlsHav9AFOPWNbklYjA/Y1C49LibUGxVQCOci
        5wKjQO3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxUfW-0001Kw-8C; Thu, 07 Jan 2021 12:45:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 982413003E1;
        Thu,  7 Jan 2021 13:45:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D9BE20164735; Thu,  7 Jan 2021 13:45:32 +0100 (CET)
Date:   Thu, 7 Jan 2021 13:45:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 5/5] csky: Cleanup asm/spinlock.h
Message-ID: <X/cCbByLzLI12xYZ@hirez.programming.kicks-ass.net>
References: <1608478763-60148-1-git-send-email-guoren@kernel.org>
 <1608478763-60148-5-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608478763-60148-5-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Dec 20, 2020 at 03:39:23PM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> There are two implementation of spinlock in arch/csky:
>  - simple one (NR_CPU = 1,2)
>  - tick's one (NR_CPU = 3,4)
> Remove the simple one.
> 
> There is already smp_mb in spinlock, so remove the definition of
> smp_mb__after_spinlock.

Where ? Note that with qspinlock the fast path is
atomic_try_cmpxchg_acquire(), which does not imply anything of the sort.
