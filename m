Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8225AC152
	for <lists+linux-arch@lfdr.de>; Sat,  3 Sep 2022 22:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiICUTK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Sep 2022 16:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiICUTJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Sep 2022 16:19:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C1952DCE;
        Sat,  3 Sep 2022 13:19:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5056A60DD4;
        Sat,  3 Sep 2022 20:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3528C433D6;
        Sat,  3 Sep 2022 20:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662236347;
        bh=N+tzKRKy5OSrGZK3pRZnx8YYMCeZr6XwsLbPVosnyHs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=L/97tlKPfm/76KQx9SzepPjsWKbdtVtjGXhwA0h+oWzylPsniuAGJsqVbCD8gqcLw
         VZkoz5q1CpYXBUhbtfOqhA3XEs6Flhmy+rlVOWMTn/8RlViT4ySPno5061J6BbwqsL
         SQAH26eBUjsDJUm/13Fk+oms/eejqpakpAWWVSqxVph+hV1CVEquyInOgVyDD7EAQe
         rfHmlVwyIoGoHJImho8JJNbk+TLdm6D+JkT01MvuY9bZfcm+mofuguIs6QJiOOqAFO
         GkGFTf3BuRMyOfWC8Uux0cAUsu6DzQXLiWI/eL9i2v4TzmH9xDSrO/d8B7Or7OqxVG
         5QE/K4uIFD1EQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 489E05C086C; Sat,  3 Sep 2022 13:19:07 -0700 (PDT)
Date:   Sat, 3 Sep 2022 13:19:07 -0700
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
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Subject: Re: [PATCH v4] tools/memory-model: Weaken ctrl dependency definition
 in explanation.txt
Message-ID: <20220903201907.GA6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220903165718.4186763-1-paul.heidekrueger@in.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220903165718.4186763-1-paul.heidekrueger@in.tum.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 03, 2022 at 04:57:17PM +0000, Paul Heidekrüger wrote:
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
> The read event determines whether the write event will be executed "at all"
> - as per the current definition - but the formal LKMM does not recognize
> this as a control dependency.
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
> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>

I have pulled this one in, thank you both!

It can still be updated if need be.  ;-)

							Thanx, Paul

> ---
> 
> v4:
> - Replace "a memory access event" with "a write event"
> 
> v3:
> - Address Alan and Joel's feedback re: the wording around switch statements
> and the use of "guarding"
> 
> v2:
> - Fix typos
> - Fix indentation of code snippet
> 
> v1:
> @Alan, since I got it wrong the last time, I'm adding you as a co-developer
> after my SOB. I'm sorry if this creates extra work on your side due to you
> having to resubmit the patch now with your SOB if I understand correctly,
> but since it's based on your wording from the other thread, I definitely
> wanted to give you credit.
> 
>  tools/memory-model/Documentation/explanation.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index ee819a402b69..11a1d2d4f681 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -464,9 +464,10 @@ to address dependencies, since the address of a location accessed
>  through a pointer will depend on the value read earlier from that
>  pointer.
> 
> -Finally, a read event and another memory access event are linked by a
> -control dependency if the value obtained by the read affects whether
> -the second event is executed at all.  Simple example:
> +Finally, a read event X and a write event Y are linked by a control
> +dependency if Y syntactically lies within an arm of an if statement and
> +X affects the evaluation of the if condition via a data or address
> +dependency (or similarly for a switch statement).  Simple example:
> 
>  	int x, y;
> 
> --
> 2.35.1
> 
