Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4905A5B5965
	for <lists+linux-arch@lfdr.de>; Mon, 12 Sep 2022 13:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiILLiq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Sep 2022 07:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiILLip (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Sep 2022 07:38:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EF931229;
        Mon, 12 Sep 2022 04:38:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3551B80CAE;
        Mon, 12 Sep 2022 11:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27ED3C433D6;
        Mon, 12 Sep 2022 11:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662982721;
        bh=FCU5SG7ZmSO/FS2aU+IZV41v+cSuNOTyiZzV1RmxhrY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SriU/tn/FGS8ENFHrlNrHCfTolGzRQNr00Nr2ti9OSsjvKXgCPHo2HD19rzggV5l5
         TR26T6Pbv10N5cJCg6ffoltp08U8heXl/cI7xr5EzRdPshro2GCXlEerHn5rAQuCNv
         kzP5osFCseQAKibKNhxkrMd75B+Tm5/JlxjvpDsC+2H8yfpQ3HKcD266phUUeV/MLx
         iIKs3FjkvkLyDXlphEehBO0n1mmiD01lqnPlax64FRhv1n/34sQEdQtYuuE3uSE13a
         2t/aDi0OnbNK+GrDxfbvdH2yZTnqpKBDG4RaiA0ong43mlx9nYxIz8Fky0E2ddj0nr
         zrCTYSqkrQzjQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2D7805C0DF1; Mon, 12 Sep 2022 04:38:38 -0700 (PDT)
Date:   Mon, 12 Sep 2022 04:38:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Subject: Re: [PATCH v2] tools/memory-model: Weaken ctrl dependency definition
 in explanation.txt
Message-ID: <20220912113838.GG246308@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220830210821.3763660-1-paul.heidekrueger@in.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220830210821.3763660-1-paul.heidekrueger@in.tum.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 30, 2022 at 09:08:20PM +0000, Paul Heidekrüger wrote:
> The current informal control dependency definition in explanation.txt is
> too broad and, as discussed, needs to be updated.
> 
> Consider the following example:
> 
> > if(READ_ONCE(x))
> >   return 42;
> >
> > WRITE_ONCE(y, 42);
> >
> > return 21;
> 
> The read event determines whether the write event will be executed "at
> all" - as per the current definition - but the formal LKMM does not
> recognize this as a control dependency.
> 
> Introduce a new definition which includes the requirement for the second
> memory access event to syntactically lie within the arm of a non-loop
> conditional.
> 
> Link: https://lore.kernel.org/all/20220615114330.2573952-1-paul.heidekrueger@in.tum.de/
> Cc: Marco Elver <elver@google.com>
> Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
> Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
> Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
> Cc: Martin Fink <martin.fink@in.tum.de>
> Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>

Hearing no objections, I reverted the old version and replaced it
with this version.  Thank you both!

							Thanx, Paul

> ---
> 
> v2:
> - Fix typos
> - Fix indentation of code snippet
> 
> v1:
> @Alan, since I got it wrong the last time, I'm adding you as a co-developer after my
> SOB. I'm sorry if this creates extra work on your side due to you having to
> resubmit the patch now with your SOB if I understand correctly, but since it's
> based on your wording from the other thread, I definitely wanted to give you
> credit.
> 
>  tools/memory-model/Documentation/explanation.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index ee819a402b69..0bca50cac5f4 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -464,9 +464,10 @@ to address dependencies, since the address of a location accessed
>  through a pointer will depend on the value read earlier from that
>  pointer.
> 
> -Finally, a read event and another memory access event are linked by a
> -control dependency if the value obtained by the read affects whether
> -the second event is executed at all.  Simple example:
> +Finally, a read event X and another memory access event Y are linked by
> +a control dependency if Y syntactically lies within an arm of an if,
> +else or switch statement and the condition guarding Y is either data or
> +address-dependent on X.  Simple example:
> 
>  	int x, y;
> 
> --
> 2.35.1
> 
