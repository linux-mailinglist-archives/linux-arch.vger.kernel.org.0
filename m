Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3673963C758
	for <lists+linux-arch@lfdr.de>; Tue, 29 Nov 2022 19:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbiK2SqE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Nov 2022 13:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiK2SqD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Nov 2022 13:46:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DB8FD04;
        Tue, 29 Nov 2022 10:46:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1684B818AA;
        Tue, 29 Nov 2022 18:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5264FC433C1;
        Tue, 29 Nov 2022 18:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669747559;
        bh=v3cdkN3WaNLkRIrCH7LJQ2Lcove272P5vi2hRzSJi5A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MGCsbFN4vmR84Idlk3yOKQ7EDhoQuuiZsXy7uyo+78rFqlC1LRJpooX5gRon7jQ8e
         A9YxaE05mU7LmhBYw6tFdlup661rej75iG9jmuOgE0yEnnXLXOEni12bhchXFb5uAb
         ZgJiWXUDlj8Syq/yRdHppgQ4/ONgs1o2UZvz9IqTebglZyvWILFw/wgTgc2AOw27fT
         lrsnTk4bOu7pWw2HTHhhD1/RO/b+leLqaA1gfJPiy6mzVgA+1BLIrkUeSTwmqA2vNg
         nC2giqq+4a80J/mxEFH9NG/ZLo9+kGgJPFiHs0vpcJy9QmeMPNlnguiVWHAmNJsJ+c
         bZws1MnRBYmqg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 068025C0584; Tue, 29 Nov 2022 10:45:59 -0800 (PST)
Date:   Tue, 29 Nov 2022 10:45:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Kushagra Verma <kushagra765@outlook.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: Fixed a typo in atomic_t.txt
Message-ID: <20221129184559.GC4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <SL2PR01MB281219C24708CE54EC1FC610F8129@SL2PR01MB2812.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2PR01MB281219C24708CE54EC1FC610F8129@SL2PR01MB2812.apcprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 29, 2022 at 06:50:59PM +0530, Kushagra Verma wrote:
> Fixed a typo in the word 'architecture'.
> 
> Signed-off-by: Kushagra Verma <kushagra765@outlook.com>

Good eyes!  Queued for further review, thank you!

							Thanx, Paul

> ---
>  Documentation/atomic_t.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> index 0f1ffa03db09..d7adc6d543db 100644
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -324,7 +324,7 @@ atomic operations.
>  
>  Specifically 'simple' cmpxchg() loops are expected to not starve one another
>  indefinitely. However, this is not evident on LL/SC architectures, because
> -while an LL/SC architecure 'can/should/must' provide forward progress
> +while an LL/SC architecture 'can/should/must' provide forward progress
>  guarantees between competing LL/SC sections, such a guarantee does not
>  transfer to cmpxchg() implemented using LL/SC. Consider:
>  
> -- 
> 2.38.1
> 
