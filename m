Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0877868A790
	for <lists+linux-arch@lfdr.de>; Sat,  4 Feb 2023 02:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjBDB34 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 20:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjBDB3z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 20:29:55 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 85B338B7FA
        for <linux-arch@vger.kernel.org>; Fri,  3 Feb 2023 17:29:54 -0800 (PST)
Received: (qmail 581754 invoked by uid 1000); 3 Feb 2023 20:29:53 -0500
Date:   Fri, 3 Feb 2023 20:29:53 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Joel Fernandes \(Google\)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH RFC] tools/memory-model: Restrict to-r to read-read
 address dependency
Message-ID: <Y921EeGatjTZbWt6@rowland.harvard.edu>
References: <20230203201913.2555494-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203201913.2555494-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 03, 2023 at 08:19:13PM +0000, Joel Fernandes (Google) wrote:
> During a code-reading exercise of linux-kernel.cat CAT file, I generated
> a graph to show the to-r relations. While likely not problematic for the
> model, I found it confusing that a read-write address dependency would
> show as a to-r edge on the graph.
> 
> This patch therefore restricts the to-r links derived from addr to only
> read-read address dependencies, so that read-write address dependencies don't
> show as to-r in the graphs. This should also prevent future users of to-r from
> deriving incorrect relations. Note that a read-write address dep, obviously,
> still ends up in the ppo relation via the to-w relation.
> 
> I verified that a read-read address dependency still shows up as a to-r
> link in the graph, as it did before.
> 
> For reference, the problematic graph was generated with the following
> command:
> herd7 -conf linux-kernel.cfg \
>    -doshow dep -doshow to-r -doshow to-w ./foo.litmus -show all -o OUT/
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  tools/memory-model/linux-kernel.cat | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index d70315fddef6..26e6f0968143 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -69,7 +69,7 @@ let dep = addr | data
>  let rwdep = (dep | ctrl) ; [W]
>  let overwrite = co | fr
>  let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
> -let to-r = addr | (dep ; [Marked] ; rfi)
> +let to-r = (addr ; [R]) | (dep ; [Marked] ; rfi)
>  let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
>  
>  (* Propagation: Ordering from release operations and strong fences. *)
> -- 
> 2.39.1.519.gcb327c4b5f-goog

Acked-by: Alan Stern <stern@rowland.harvard.edu>
