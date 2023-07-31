Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D05769CCF
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 18:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjGaQgY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 12:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjGaQgH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 12:36:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B0C2123;
        Mon, 31 Jul 2023 09:35:41 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690821339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w/WJW32x1qpjSrgwv/AAuxytdw2s82fSnUhy8yQ0iVg=;
        b=gG5PHgDz/pQLCINjkJVxFk/Lmh2saQ0xr/dYg023WFuBOb1tuHcIdKlev6rU1fcajxhC/c
        7J5Y34yCUxvqjzX13AjHUsHc3DDkt3qf926ZoFklrlwQCCg9Elv/PElmmz3DMqQiyhdNLW
        cFqKlRSPA4J1/9ExUUROa/ipSEg0ZXDqWk79TtUG3XAGPfEps6z7LHLNPcNmFZ/jRUXjhB
        piF9VV20VhoNGtPHm3X3zNO6YqOzhJh40VZIeZNCCiML5NnSkzA/fRwNwm77hoizMTQJqV
        bAGuGGLkOiLos2y3j13EyHXL3rZWl5u4JKqY//nNoO+POnu+Zqe5rhvQMHluRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690821339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w/WJW32x1qpjSrgwv/AAuxytdw2s82fSnUhy8yQ0iVg=;
        b=7DpKt2xKwu1n51Wog9rodhsvt2OqNWsi2Lrx9ASOJTOogoqgG3Z5zg8QLxSQD/eOs0Rg8p
        9y47YPsNlwDzdnBg==
To:     Peter Zijlstra <peterz@infradead.org>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 06/14] futex: Add sys_futex_wait()
In-Reply-To: <20230721105744.090372309@infradead.org>
References: <20230721102237.268073801@infradead.org>
 <20230721105744.090372309@infradead.org>
Date:   Mon, 31 Jul 2023 18:35:38 +0200
Message-ID: <878rawnin9.ffs@tglx>
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
> +int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val, ktime_t *abs_time, u32 bitset)
> +{
> +	struct hrtimer_sleeper timeout, *to;
> +	struct restart_block *restart;
> +	int ret;
> +
> +	to = futex_setup_timer(abs_time, &timeout, flags,
> +			       current->timer_slack_ns);
> +
> +	ret = __futex_wait(uaddr, flags, val, to, bitset);
> +	if (!to)
> +		return ret;

Can you please put an empty new line and a comment between the __futex_wait()
and the if (!to) check? The original code was less obfuscated.

Other than that: Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
