Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3418769C34
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 18:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjGaQWH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 12:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjGaQWG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 12:22:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07FE10CA;
        Mon, 31 Jul 2023 09:21:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690820517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KqkYv1GwuT7wrNuSLgatJf7BkiAxad+peRj/ArOIh1c=;
        b=sckhwr7Uz+RKelUdW5qGzRpZ0c2pnzHYh9SQc/bMxR/eHv1AO/vTg+Csa/ihN/ODxcgf6o
        2YwoG9bk8lB/ubmmQhurUo88OHIbluDwa3lcxsUSRZJu4YJaeq6hgEqe5FwdOh8Piqb3p4
        9AkoTuN+MdUHKQ4tUHsV5Zim9XLegbsO27TLbqVjOcCEwwZ7HlZDWmAzvvMF4mb/FAPcqp
        Td0awpldp1PzAbRfqSRPPsLiM/iteufMUncIwMEaNsTRQLbiyTxHnVYIuh7yNORUzPZqrV
        p+CeymM4TjbcYQf4L2qS7CfIlurt1KqK6m4+6cIa8bfyTdNSy4SI90DmU6YEow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690820517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KqkYv1GwuT7wrNuSLgatJf7BkiAxad+peRj/ArOIh1c=;
        b=NX+OtYFcIBDOl4WbWlYOcOEiLzOWm76tHMyXWS4bgnvGOMXbvRouoiH2ep1IWP2Zxmbl9R
        qua8oOIpFoYwoxAQ==
To:     Peter Zijlstra <peterz@infradead.org>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 03/14] futex: Flag conversion
In-Reply-To: <20230721105743.887106899@infradead.org>
References: <20230721102237.268073801@infradead.org>
 <20230721105743.887106899@infradead.org>
Date:   Mon, 31 Jul 2023 18:21:56 +0200
Message-ID: <87bkfsnja3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 21 2023 at 12:22, Peter Zijlstra wrote:
> +
> +static inline bool futex_flags_valid(unsigned int flags)
> +{
> +	/* Only 64bit futexes for 64bit code */
> +	if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()) {
> +		if ((flags & FLAGS_SIZE_MASK) == FLAGS_SIZE_64)
> +			return false;
> +	}
> +
> +	/* Only 32bit futexes are implemented -- for now */
> +	if ((flags & FLAGS_SIZE_MASK) != FLAGS_SIZE_32)
> +		return false;
> +
> +	return true;
> +}
> +
> +static inline unsigned int futex_size(unsigned int flags)
> +{
> +	unsigned int size = flags & FLAGS_SIZE_MASK;
> +	return 1 << size; /* {0,1,2,3} -> {1,2,4,8} */

Lacks a new line and the comment is both misplaced and kinda obvious, no?

Other than that, this looks abour right.
