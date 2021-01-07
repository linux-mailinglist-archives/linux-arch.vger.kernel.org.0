Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFE92ED010
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jan 2021 13:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbhAGMlt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jan 2021 07:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbhAGMlq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jan 2021 07:41:46 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE11C0612F5;
        Thu,  7 Jan 2021 04:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kwFuTJhYBR+fxH5ScaaJzgDdFXb0D1CjKuU2YjEc374=; b=ewSrLo2doe3I6S647Y+SKonMAl
        z68g4MbYcvlg6Qaj0Sgx1J3IfEV39kt97JNw1O9DaiY365fdraX7RGLF9wDJPD/r6KU80HBe+1snh
        RKQFjpnwJCfIRCkuwwNTSxxsRPuCRTzTk8+pYu1ch90Ukl9KY8uMsaXPd04smceSX9dvqCnULSly1
        L3ogCWXgfJ8HIBBq62IOEhEOm34IitiHs4AUwjo13bDgIVYwPvIZmZcygApLP4IsZqllkbd+RQP4t
        elJF0uu9PDl7Kq4Q3+f63YVKZUcR8qxuF1+YkkGzp8UVBY5jgNrdloFS2HqlF3SaxlfgvB+2tPU+x
        Ix5jDW8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxUb3-00071v-69; Thu, 07 Jan 2021 12:40:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2B0113003E1;
        Thu,  7 Jan 2021 13:40:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1909C20164735; Thu,  7 Jan 2021 13:40:55 +0100 (CET)
Date:   Thu, 7 Jan 2021 13:40:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 4/5] csky: Fixup asm/cmpxchg.h with correct ordering
 barrier
Message-ID: <X/cBV8Bll0K2PwTx@hirez.programming.kicks-ass.net>
References: <1608478763-60148-1-git-send-email-guoren@kernel.org>
 <1608478763-60148-4-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608478763-60148-4-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Dec 20, 2020 at 03:39:22PM +0000, guoren@kernel.org wrote:


> +#define cmpxchg(ptr, o, n) 					\
> +({								\
> +	__typeof__(*(ptr)) __ret;				\
> +	__smp_release_fence();					\
> +	__ret = cmpxchg_relaxed(ptr, o, n);			\
> +	__smp_acquire_fence();					\
> +	__ret;							\
> +})

So you failed to Cc me on patch #2 that introduces these barriers. I've
dug it out, but I'm still terribly confused on all that.

On first reading the above looks wrong.

Could you also clarify the difference (if any) between your bar.brwarw
and sync instruction?

Specifically, about transitiviry, or whatever we seem to be calling that
today.
