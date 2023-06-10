Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E6E72AF6A
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jun 2023 00:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjFJWP4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Jun 2023 18:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjFJWPz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Jun 2023 18:15:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3791435A9;
        Sat, 10 Jun 2023 15:15:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686435352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ejqz0m9VjFELy9cEgnoQTo9qjHEOQ+IrkiWMVEjBzhc=;
        b=gh6v9LMhGIqwDHTwxIyyBxfZPk5v6QiuvVyiGb08d1x9hWXgm7HPz5whju/xKJ9wlOI7Hq
        AzRsW6Up0FcpiPVswqWqd0ZvefaVra9lEbuRn3Q6lYOOnX9Hs3CZL6UrswZqbat0AjKBMS
        cZVRgh93L6Lm/nHBYVjh/yJIfRVgScNHfbBVKqMrnTJQdELnE/K7bFQjNtLyUVtE+3pnEZ
        y6VvF3ogaAKwBQ0DuYu1V0Ld/3qws2+yTCS4X7g8oldBo9bJUqNoHqTfKEgX+gSNAmEvk6
        mkD/mGIT4hBH7kqVTF2cAk7HWanYRLocwsKJkCEq8s9Jz4/U1o0cfzhjCXChOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686435352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ejqz0m9VjFELy9cEgnoQTo9qjHEOQ+IrkiWMVEjBzhc=;
        b=Q3sVALgdzN2U6GI78CLlYcdM+zv5eNsJJ01lzIOMRh7Kc1acgqpvUkHg8utt2KZSKqktdj
        u7FmSJOEYiidbhDA==
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        ldufour@linux.ibm.com, bp@alien8.de, dave.hansen@linux.intel.com,
        mingo@redhat.com, x86@kernel.org
Subject: Re: [PATCH 4/9] cpu/SMT: Create topology_smt_threads_supported()
In-Reply-To: <20230524155630.794584-4-mpe@ellerman.id.au>
References: <20230524155630.794584-1-mpe@ellerman.id.au>
 <20230524155630.794584-4-mpe@ellerman.id.au>
Date:   Sun, 11 Jun 2023 00:15:52 +0200
Message-ID: <878rcr7ylj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 25 2023 at 01:56, Michael Ellerman wrote:
> +/**
> + * topology_smt_threads_supported - Check if the given number of SMT threads
> + *				    is supported.
> + *
> + * @threads:	The number of SMT threads.
> + */
> +bool topology_smt_threads_supported(unsigned int threads)
> +{
> +	// Only support a single thread or all threads.
> +	return threads == 1 || threads == smp_num_siblings;
> +}

You can make that a simple core function when cpu_smt_*_threads is
consistent along the lines of my previous reply.

static bool cpu_smt_num_threads_valid(unsigned int threads)
{
        if (IS_ENABLED(CONFIG_SMT_NUM_THREADS_DYNAMIC))
		return threads >= 1 && threads <= cpu_smt_max_threads;
        return threads == 1 || threads == cpu_smt_max_threads;
}

Or something like that.

Thanks,

        tglx
