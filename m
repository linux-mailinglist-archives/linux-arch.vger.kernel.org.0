Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C22772E77
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 21:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjHGTGF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 15:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjHGTGD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 15:06:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3D81980;
        Mon,  7 Aug 2023 12:06:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691435158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XE+xkxc7MqAeqi2WNOczKsEjs+HO24cEE9rzWwhJY/8=;
        b=gj3nH2fkJD6ThcHJcDddPqLTvYM1VNgj+38jw6QezNf5fAMN0NFjxgAHtzrQNntzafmhmc
        I2QsY2aQXRPaqMaHrb2M0hq9YH/yPkXNJM0RqFzCUYNAHIet4/d7J68eUgFzomIbaAxK/S
        vlv1d/K4ltnEhP4JF7vzKbEeWWCpxFqravmbbnDqCL/KwcGk9Kc69duc8x5F+2Xul5Cp4u
        hbOOM2lCEjvMTAIz95+yAOoPgD3U/Vc99ufeWbGroyogSsqgRWwaxoc+gMSMbuc6gEhfUT
        gmFRHvEgsTE1/f5vzO+8wBfbnwL7lkTYHydFZ4KsTMamtwVNykfdOrOTlqk1Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691435158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XE+xkxc7MqAeqi2WNOczKsEjs+HO24cEE9rzWwhJY/8=;
        b=cg24wm8ZuaKLMq6RUWNishxoPbqAtoBygzwGgzFZhlfN1ARCNFRh+/OhvpXAx2aTohFIlT
        /gDANCgZO6ir/PBg==
To:     Peter Zijlstra <peterz@infradead.org>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH  v2 09/14] futex: Add sys_futex_requeue()
In-Reply-To: <20230807123323.366498604@infradead.org>
References: <20230807121843.710612856@infradead.org>
 <20230807123323.366498604@infradead.org>
Date:   Mon, 07 Aug 2023 21:05:58 +0200
Message-ID: <87il9qu0yx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 07 2023 at 14:18, Peter Zijlstra wrote:

> Finish of the 'simple' futex2 syscall group by adding

s/of/off/

> sys_futex_requeue(). Unlike sys_futex_{wait,wake}() its arguments are
> too numerous to fit into a regular syscall. As such, use struct
> futex_waitv to pass the 'source' and 'destination' futexes to the
> syscall.

...

> +/*
> + * sys_futex_requeue - Requeue a waiter from one futex to another
> + * @waiters:	array describing the source and destination futex
> + * @flags:	unused
> + * @nr_wake:	number of futexes to wake
> + * @nr_requeue:	number of futexes to requeue

Tabular format please

> + *
> + * Identical to the traditional FUTEX_CMP_REQUEUE op, except it is part of the
> + * futex2 family of calls.
> + */
> +
> +SYSCALL_DEFINE4(futex_requeue,
> +		struct futex_waitv __user *, waiters,
> +		unsigned int, flags,
> +		int, nr_wake,
> +		int, nr_requeue)
> +{
> +	struct futex_vector futexes[2];
> +	u32 cmpval;
> +	int ret;
> +
> +	if (flags)
> +		return -EINVAL;
> +
> +	if (!waiters)
> +		return -EINVAL;
> +
> +	ret = futex_parse_waitv(futexes, waiters, 2);
> +	if (ret)
> +		return ret;
> +
> +	cmpval = futexes[0].w.val;
> +
> +	return futex_requeue(u64_to_user_ptr(futexes[0].w.uaddr), futexes[0].w.flags,
> +			     u64_to_user_ptr(futexes[1].w.uaddr), futexes[1].w.flags,
> +			     nr_wake, nr_requeue, &cmpval, 0);
> +}

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
