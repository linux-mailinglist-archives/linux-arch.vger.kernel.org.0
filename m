Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8FF68A7AF
	for <lists+linux-arch@lfdr.de>; Sat,  4 Feb 2023 02:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjBDBvt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 20:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjBDBvs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 20:51:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCD31A4B3;
        Fri,  3 Feb 2023 17:51:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EF1062046;
        Sat,  4 Feb 2023 01:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBA1C433D2;
        Sat,  4 Feb 2023 01:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675475505;
        bh=uUrptZclc72gGiGJfLue5ojGtcX27ISDiKf2A2O2hpk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JbahGlVeHshsaM4Lda6Y6mETpDI/N8R46jpWgZbqgtyplo0WmNlTCUG5pwk1mDccP
         kovjm8rUM5+bfi7jg9F9ioM2w7APuaEooZQpYZPzggS3SxoFvXE6bJ5Xq1BqR2qs7Z
         ZiSTjah4v2hVd1uSvZQ/ShROWsEfa27kylkOcFqWd8hPKV76z0UShGsTW+IY/XLZ0/
         vyiLlND5pO174NvXmUFmAp8CJRWU4BbYbpLFOxeRVIxR84c4hhaL6z76VwOoxvWjSm
         9/OWbaaqE1epQie0xvkubNuQJWjVp5s69g06adnWa5fwdsmeFY9WhgrCB6a53bH94I
         W1OXXieqU60sw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 940D95C18FC; Fri,  3 Feb 2023 17:51:44 -0800 (PST)
Date:   Fri, 3 Feb 2023 17:51:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH RFC] tools/memory-model: Restrict to-r to read-read
 address dependency
Message-ID: <20230204015144.GT2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230203201913.2555494-1-joel@joelfernandes.org>
 <Y921EeGatjTZbWt6@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y921EeGatjTZbWt6@rowland.harvard.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 03, 2023 at 08:29:53PM -0500, Alan Stern wrote:
> On Fri, Feb 03, 2023 at 08:19:13PM +0000, Joel Fernandes (Google) wrote:
> > During a code-reading exercise of linux-kernel.cat CAT file, I generated
> > a graph to show the to-r relations. While likely not problematic for the
> > model, I found it confusing that a read-write address dependency would
> > show as a to-r edge on the graph.
> > 
> > This patch therefore restricts the to-r links derived from addr to only
> > read-read address dependencies, so that read-write address dependencies don't
> > show as to-r in the graphs. This should also prevent future users of to-r from
> > deriving incorrect relations. Note that a read-write address dep, obviously,
> > still ends up in the ppo relation via the to-w relation.
> > 
> > I verified that a read-read address dependency still shows up as a to-r
> > link in the graph, as it did before.
> > 
> > For reference, the problematic graph was generated with the following
> > command:
> > herd7 -conf linux-kernel.cfg \
> >    -doshow dep -doshow to-r -doshow to-w ./foo.litmus -show all -o OUT/
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  tools/memory-model/linux-kernel.cat | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> > index d70315fddef6..26e6f0968143 100644
> > --- a/tools/memory-model/linux-kernel.cat
> > +++ b/tools/memory-model/linux-kernel.cat
> > @@ -69,7 +69,7 @@ let dep = addr | data
> >  let rwdep = (dep | ctrl) ; [W]
> >  let overwrite = co | fr
> >  let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
> > -let to-r = addr | (dep ; [Marked] ; rfi)
> > +let to-r = (addr ; [R]) | (dep ; [Marked] ; rfi)
> >  let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
> >  
> >  (* Propagation: Ordering from release operations and strong fences. *)
> > -- 
> > 2.39.1.519.gcb327c4b5f-goog
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thank you both, queued for v6.4.

							Thanx, Paul
