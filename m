Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798095ABC07
	for <lists+linux-arch@lfdr.de>; Sat,  3 Sep 2022 03:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiICB15 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 21:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiICB14 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 21:27:56 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 28E2AEF9C7
        for <linux-arch@vger.kernel.org>; Fri,  2 Sep 2022 18:27:55 -0700 (PDT)
Received: (qmail 289817 invoked by uid 1000); 2 Sep 2022 21:27:54 -0400
Date:   Fri, 2 Sep 2022 21:27:54 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
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
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Subject: Re: [PATCH v3] tools/memory-model: Weaken ctrl dependency definition
 in explanation.txt
Message-ID: <YxKtmk2q8Uzb+Qk9@rowland.harvard.edu>
References: <20220902211341.2585133-1-paul.heidekrueger@in.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220902211341.2585133-1-paul.heidekrueger@in.tum.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 02, 2022 at 09:13:40PM +0000, Paul Heidekrüger wrote:
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
> Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

> ---
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
>  tools/memory-model/Documentation/explanation.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index ee819a402b69..0b7e1925a673 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -464,9 +464,11 @@ to address dependencies, since the address of a location accessed
>  through a pointer will depend on the value read earlier from that
>  pointer.
> 
> -Finally, a read event and another memory access event are linked by a
> -control dependency if the value obtained by the read affects whether
> -the second event is executed at all.  Simple example:
> +Finally, a read event X and another memory access event Y are linked by
> +a control dependency if Y syntactically lies within an arm of an if
> +statement and X affects the evaluation of the if condition via a data or
> +address dependency (or similarly for a switch statement).  Simple
> +example:
> 
>  	int x, y;
> 
