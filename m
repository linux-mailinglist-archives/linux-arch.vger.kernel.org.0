Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7633F5A26CB
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 13:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242864AbiHZLXi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 07:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiHZLXh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 07:23:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D96DAEE5;
        Fri, 26 Aug 2022 04:23:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC41461AE3;
        Fri, 26 Aug 2022 11:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C16C433D6;
        Fri, 26 Aug 2022 11:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661513015;
        bh=er20jhWQ9UV2GuS7npYd+p88t+RCOQWdFUwdklG856c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mXag9Tz3eD7yaq5k7rB7FvRteKYvPihN8KETnpwvU062+E9V6LLPPA1SvgtUFS8ZW
         tgHO/0+BSgg5zG5iiKts9P69XvRzSA12ZWMBgVnI4VXf8r8yluzgWAb+HfxdYXk0E9
         yJpq2/Z8wzxGiWkIXFzfYSbhx7dYYMCh7mM1wcB+JwtFbUs5cEZbNBW1cGLIcSzYgf
         ZiX4ug7LyHyADE6zgTQJBCI9yt+cZBQWh2HmsDkQ8KJf7ZC9pHC6nE1FuNE7SXVB8c
         aJnnLOXmsGVVkt5p+W1GRcK7meXQkAEUnlKnO2KxnPSZZ5uDhTpW3RYFWah+2C2ECj
         Amvl/F+njaYEg==
Date:   Fri, 26 Aug 2022 12:23:28 +0100
From:   Will Deacon <will@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] wait_on_bit: add an acquire memory barrier
Message-ID: <20220826112327.GA19774@willie-the-truck>
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
 <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 25, 2022 at 05:03:40PM -0400, Mikulas Patocka wrote:
> Here I reworked your patch, so that test_bit_acquire is defined just like 
> test_bit. There's some code duplication (in 
> include/asm-generic/bitops/generic-non-atomic.h and in 
> arch/x86/include/asm/bitops.h), but that duplication exists in the 
> test_bit function too.
> 
> I tested it on x86-64 and arm64. On x86-64 it generates the "bt" 
> instruction for variable-bit test and "shr; and $1" for constant bit test. 
> On arm64 it generates the "ldar" instruction for both constant and 
> variable bit test.
> 
> For me, the kernel 6.0-rc2 doesn't boot in an arm64 virtual machine at all 
> (with or without this patch), so I only compile-tested it on arm64. I have 
> to bisect it.

It's working fine for me and I haven't had any other reports that it's not
booting. Please could you share some more details about your setup so we
can try to reproduce the problem?

> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> There are several places in the kernel where wait_on_bit is not followed
> by a memory barrier (for example, in drivers/md/dm-bufio.c:new_read). On
> architectures with weak memory ordering, it may happen that memory
> accesses that follow wait_on_bit are reordered before wait_on_bit and they
> may return invalid data.
> 
> Fix this class of bugs by introducing a new function "test_bit_acquire"
> that works like test_bit, but has acquire memory ordering semantics.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
> 
>  arch/x86/include/asm/bitops.h                            |   13 +++++++++++++
>  include/asm-generic/bitops/generic-non-atomic.h          |   14 ++++++++++++++
>  include/asm-generic/bitops/instrumented-non-atomic.h     |   12 ++++++++++++
>  include/asm-generic/bitops/non-atomic.h                  |    1 +
>  include/asm-generic/bitops/non-instrumented-non-atomic.h |    1 +
>  include/linux/bitops.h                                   |    1 +
>  include/linux/buffer_head.h                              |    2 +-
>  include/linux/wait_bit.h                                 |    8 ++++----
>  kernel/sched/wait_bit.c                                  |    2 +-
>  9 files changed, 48 insertions(+), 6 deletions(-)

This looks good to me, thanks for doing it! Just one thing that jumped out
at me:

> Index: linux-2.6/include/linux/buffer_head.h
> ===================================================================
> --- linux-2.6.orig/include/linux/buffer_head.h
> +++ linux-2.6/include/linux/buffer_head.h
> @@ -156,7 +156,7 @@ static __always_inline int buffer_uptoda
>  	 * make it consistent with folio_test_uptodate
>  	 * pairs with smp_mb__before_atomic in set_buffer_uptodate
>  	 */
> -	return (smp_load_acquire(&bh->b_state) & (1UL << BH_Uptodate)) != 0;
> +	return test_bit_acquire(BH_Uptodate, &bh->b_state);

Do you think it would be worth adding set_bit_release() and then relaxing
set_buffer_uptodate() to use that rather than the smp_mb__before_atomic()?

Will
