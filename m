Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B873674E219
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 01:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjGJXNq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 19:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjGJXNp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 19:13:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77CF9E;
        Mon, 10 Jul 2023 16:13:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 667766125D;
        Mon, 10 Jul 2023 23:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48FAC433C7;
        Mon, 10 Jul 2023 23:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1689030823;
        bh=fHPnsvbmHoDax2JcKJLoPjo5k2CknkN7L6jw/9rSA4w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O0dtsCUqqxh2E48pOsfcrz2eZeXmdjOp00Zk6jVReJI5GrDZqLL7FjY7BrEshu/p5
         slD/g3Fa5uEiXtcnwB5ZlNreYjQhnGvzG/CqvGSc0lZYOHtsjbY9pElz4CGWNHdo/Z
         rAW9MKjVNY1aI+QBeJq05SUOTjzWNkFPmIQS21pE=
Date:   Mon, 10 Jul 2023 16:13:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/38] minmax: Add in_range() macro
Message-Id: <20230710161341.c8d6a8b2cbf57013bf6e0140@linux-foundation.org>
In-Reply-To: <20230710204339.3554919-2-willy@infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
        <20230710204339.3554919-2-willy@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 10 Jul 2023 21:43:02 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> Determine if a value lies within a range more efficiently (subtraction +
> comparison vs two comparisons and an AND).  It also has useful (under
> some circumstances) behaviour if the range exceeds the maximum value of
> the type.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> --- a/include/linux/minmax.h
> +++ b/include/linux/minmax.h
> @@ -158,6 +158,32 @@
>   */
>  #define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
>  
> +static inline bool in_range64(u64 val, u64 start, u64 len)
> +{
> +	return (val - start) < len;
> +}
> +
> +static inline bool in_range32(u32 val, u32 start, u32 len)
> +{
> +	return (val - start) < len;
> +}
> +
> +/**
> + * in_range - Determine if a value lies within a range.
> + * @val: Value to test.
> + * @start: First value in range.
> + * @len: Number of values in range.
> + *
> + * This is more efficient than "if (start <= val && val < (start + len))".
> + * It also gives a different answer if @start + @len overflows the size of
> + * the type by a sufficient amount to encompass @val.  Decide for yourself
> + * which behaviour you want, or prove that start + len never overflow.
> + * Do not blindly replace one form with the other.
> + */
> +#define in_range(val, start, len)					\
> +	sizeof(start) <= sizeof(u32) ? in_range32(val, start, len) :	\
> +		in_range64(val, start, len)

There's nothing here to prevent callers from passing a mixture of
32-bit and 64-bit values, possibly resulting in truncation of `val' or
`len'.

Obviously caller is being dumb, but I think it's cost-free to check all
three of the arguments for 64-bitness?

Or do a min()/max()-style check for consistently typed arguments?

