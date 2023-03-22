Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7266C54AB
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 20:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCVTOZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Mar 2023 15:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCVTOY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2023 15:14:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B695AB44;
        Wed, 22 Mar 2023 12:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B4DFB81D0A;
        Wed, 22 Mar 2023 19:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B913C433D2;
        Wed, 22 Mar 2023 19:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679512451;
        bh=uzXmATZEPvQK8f9M7gKZG4gdRh5J5l4DFQ+I772Ylls=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NgiIC/I0ILm9cJ7GpmZEjpPRR5YNZkhm4lSzZlsHHXseqnE3WLtlRqbI6AK/NHTT7
         rJvyW4rLpMB+Blgp61pgkmVeNfcQSwZfK7JA8rEl+l0ONrCFX7Equsc1gE46bSNvAR
         Km9ynFIjfG4IEFORU/QVPC6KovcYb/Gqc2XPlvVZ2TflpiEQPAx38hswIWodQ0iiH8
         8IAJNRhDNU/kKEh4LghusPcxeK4M8USNe2JmrOJe0Lfu1BE04QN4yezLRPQ2VUfBu1
         h3B3i/SK093GwBmTnIMrMhFTu7PG4NFwvdfLRQ2cX3DWK6xq4/1t/CLZ3tWcI9FQNo
         Y5NhqAAoHnTtw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 85144154033A; Wed, 22 Mar 2023 12:14:10 -0700 (PDT)
Date:   Wed, 22 Mar 2023 12:14:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model scripts 01/31] tools/memory-model:  Document
 locking corner cases
Message-ID: <5a32a825-70b3-49d2-9a17-9e5be38e4b72@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
 <20230321010549.51296-1-paulmck@kernel.org>
 <ZBrDeoCIs1wmNBeF@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBrDeoCIs1wmNBeF@andrea>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 22, 2023 at 09:59:38AM +0100, Andrea Parri wrote:
> >  create mode 100644 Documentation/litmus-tests/locking/DCL-broken.litmus
> >  create mode 100644 Documentation/litmus-tests/locking/DCL-fixed.litmus
> >  create mode 100644 Documentation/litmus-tests/locking/RM-broken.litmus
> >  create mode 100644 Documentation/litmus-tests/locking/RM-fixed.litmus
> 
> Unfortunately none of them were liked by klitmus7/gcc, the diff below
> works for me but please double check.

Applied with attribution, thank you!

I was surprised by the need to change the "locations" clauses, but
applied that change anyway.  Ah, I take it that klitmus prints that,
but doesn't know how to print out a spinlock_t?

Dropping "y" from the "filter" clause also gave me pause, but I eventually
convinced myself that it was OK.  But it would be good for others to
also take a close look.

							Thanx, Paul

>   Andrea
> 
> 
> diff --git a/Documentation/litmus-tests/locking/DCL-broken.litmus b/Documentation/litmus-tests/locking/DCL-broken.litmus
> index cfaa25ff82b1e..bfb7ba4316d69 100644
> --- a/Documentation/litmus-tests/locking/DCL-broken.litmus
> +++ b/Documentation/litmus-tests/locking/DCL-broken.litmus
> @@ -10,10 +10,9 @@ C DCL-broken
>  {
>  	int flag;
>  	int data;
> -	int lck;
>  }
>  
> -P0(int *flag, int *data, int *lck)
> +P0(int *flag, int *data, spinlock_t *lck)
>  {
>  	int r0;
>  	int r1;
> @@ -32,7 +31,7 @@ P0(int *flag, int *data, int *lck)
>  	r2 = READ_ONCE(*data);
>  }
>  
> -P1(int *flag, int *data, int *lck)
> +P1(int *flag, int *data, spinlock_t *lck)
>  {
>  	int r0;
>  	int r1;
> @@ -51,5 +50,5 @@ P1(int *flag, int *data, int *lck)
>  	r2 = READ_ONCE(*data);
>  }
>  
> -locations [flag;data;lck;0:r0;0:r1;1:r0;1:r1]
> +locations [flag;data;0:r0;0:r1;1:r0;1:r1]
>  exists (0:r2=0 \/ 1:r2=0)
> diff --git a/Documentation/litmus-tests/locking/DCL-fixed.litmus b/Documentation/litmus-tests/locking/DCL-fixed.litmus
> index 579d6c246f167..d1b60bcb0c8f3 100644
> --- a/Documentation/litmus-tests/locking/DCL-fixed.litmus
> +++ b/Documentation/litmus-tests/locking/DCL-fixed.litmus
> @@ -11,10 +11,9 @@ C DCL-fixed
>  {
>  	int flag;
>  	int data;
> -	int lck;
>  }
>  
> -P0(int *flag, int *data, int *lck)
> +P0(int *flag, int *data, spinlock_t *lck)
>  {
>  	int r0;
>  	int r1;
> @@ -33,7 +32,7 @@ P0(int *flag, int *data, int *lck)
>  	r2 = READ_ONCE(*data);
>  }
>  
> -P1(int *flag, int *data, int *lck)
> +P1(int *flag, int *data, spinlock_t *lck)
>  {
>  	int r0;
>  	int r1;
> @@ -52,5 +51,5 @@ P1(int *flag, int *data, int *lck)
>  	r2 = READ_ONCE(*data);
>  }
>  
> -locations [flag;data;lck;0:r0;0:r1;1:r0;1:r1]
> +locations [flag;data;0:r0;0:r1;1:r0;1:r1]
>  exists (0:r2=0 \/ 1:r2=0)
> diff --git a/Documentation/litmus-tests/locking/RM-broken.litmus b/Documentation/litmus-tests/locking/RM-broken.litmus
> index c586ae4b547de..b7ef30cedfe51 100644
> --- a/Documentation/litmus-tests/locking/RM-broken.litmus
> +++ b/Documentation/litmus-tests/locking/RM-broken.litmus
> @@ -9,12 +9,11 @@ C RM-broken
>   *)
>  
>  {
> -	int lck;
>  	int x;
> -	int y;
> +	atomic_t y;
>  }
>  
> -P0(int *x, int *y, int *lck)
> +P0(int *x, atomic_t *y, spinlock_t *lck)
>  {
>  	int r2;
>  
> @@ -24,7 +23,7 @@ P0(int *x, int *y, int *lck)
>  	spin_unlock(lck);
>  }
>  
> -P1(int *x, int *y, int *lck)
> +P1(int *x, atomic_t *y, spinlock_t *lck)
>  {
>  	int r0;
>  	int r1;
> @@ -37,6 +36,6 @@ P1(int *x, int *y, int *lck)
>  	spin_unlock(lck);
>  }
>  
> -locations [x;lck;0:r2;1:r0;1:r1;1:r2]
> -filter (y=2 /\ 1:r0=0 /\ 1:r1=1)
> +locations [x;0:r2;1:r0;1:r1;1:r2]
> +filter (1:r0=0 /\ 1:r1=1)
>  exists (1:r2=1)
> diff --git a/Documentation/litmus-tests/locking/RM-fixed.litmus b/Documentation/litmus-tests/locking/RM-fixed.litmus
> index 672856736b42e..b628175596160 100644
> --- a/Documentation/litmus-tests/locking/RM-fixed.litmus
> +++ b/Documentation/litmus-tests/locking/RM-fixed.litmus
> @@ -9,12 +9,11 @@ C RM-fixed
>   *)
>  
>  {
> -	int lck;
>  	int x;
> -	int y;
> +	atomic_t y;
>  }
>  
> -P0(int *x, int *y, int *lck)
> +P0(int *x, atomic_t *y, spinlock_t *lck)
>  {
>  	int r2;
>  
> @@ -24,7 +23,7 @@ P0(int *x, int *y, int *lck)
>  	spin_unlock(lck);
>  }
>  
> -P1(int *x, int *y, int *lck)
> +P1(int *x, atomic_t *y, spinlock_t *lck)
>  {
>  	int r0;
>  	int r1;
> @@ -37,6 +36,6 @@ P1(int *x, int *y, int *lck)
>  	spin_unlock(lck);
>  }
>  
> -locations [x;lck;0:r2;1:r0;1:r1;1:r2]
> -filter (y=2 /\ 1:r0=0 /\ 1:r1=1)
> +locations [x;0:r2;1:r0;1:r1;1:r2]
> +filter (1:r0=0 /\ 1:r1=1)
>  exists (1:r2=1)
