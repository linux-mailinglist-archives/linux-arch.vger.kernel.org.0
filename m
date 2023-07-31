Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D87769F4D
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 19:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjGaRUl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 13:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjGaRU1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 13:20:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1C4188;
        Mon, 31 Jul 2023 10:19:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690823957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3WycB7deeH4N77XCxYSpDoyHgigBfOsfA/l1DUt3Iq4=;
        b=CbnDJQkP/pRhO94W3xehr4PIUumrBKh2h6k85o7yyZ5qis1q4WPoliddjQPJG5g8/N23Zr
        y6MSYqVeDkn8CB8FAlMKJUTzjaXBWYqhYsqodZDZ1bn7pZ5bzvfUbjsfUt4Iy6HUXcbG8/
        CJx34EEd8ZpGhFg4wUmRhysaNTIK/4k+jzbmC99MPG7tdPZVWnoi0rIQph+XDhfkNODwLb
        rGuuHIQsV9/BiPLQbmjrHgecHwKXe05bD/Qfxg6qGVZk4g5x/6aiaisSfJim1PwIT8zXF8
        MzS9KyZPGMfHmVODWj+WSagf4wuzhAXh2kZy8SZFMO/FcsPIdhDRRJWQBfvRjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690823957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3WycB7deeH4N77XCxYSpDoyHgigBfOsfA/l1DUt3Iq4=;
        b=9I5o68k9/KxZ19MCx1ZzRCsGVutxiHRYG6O9NIimZJuwyP42OYwcF9OKIaljbBRwdxSFgy
        /pBIstsXYJxooQAw==
To:     Peter Zijlstra <peterz@infradead.org>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 09/14] futex: Add sys_futex_requeue()
In-Reply-To: <20230721105744.298661259@infradead.org>
References: <20230721102237.268073801@infradead.org>
 <20230721105744.298661259@infradead.org>
Date:   Mon, 31 Jul 2023 19:19:17 +0200
Message-ID: <87sf94m222.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 21 2023 at 12:22, Peter Zijlstra wrote:
> +/*
> + * sys_futex_requeue - Requeue a waiter from one futex to another
> + * @waiters:	array describing the source and destination futex
> + * @flags:	unused
> + * @nr_wake:	number of futexes to wake
> + * @nr_requeue:	number of futexes to requeue
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

So this is explictely u32. I'm completely confused vs. the 64 bit futex
size variant enablement earlier in the series by now.

