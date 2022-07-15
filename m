Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F44576461
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jul 2022 17:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbiGOPVv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jul 2022 11:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiGOPVt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jul 2022 11:21:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E631135;
        Fri, 15 Jul 2022 08:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDF44B82B3F;
        Fri, 15 Jul 2022 15:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8698DC34115;
        Fri, 15 Jul 2022 15:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657898505;
        bh=SeHL3z+KjgQcyJvmNfCBj4QdNfWU9NNlzqSnGnX/s2E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FFYnxh8vDFpJxObyCx3iqWeu/wktIdHAG1ftuu9mAg7rWsFz+tc5h+J93PTT2+15z
         6nkiG1NzWNmfOvOrWXl11D0KolzzxYMtA5EzfEJypjK4i0xYt1tRSwWnb2lQmz80Jz
         F2FQ7SGUt37b7w9pBg1Uq5j93jhxgrBxlFgN0o5yI8ludEeSyQMyDkMn7c2ObbD1+1
         sdRHcDsoi7QQiArr48uJHtttPRLAwYb0bgn4i5wQXNXQBVBCBRmzGGWLITD6eUQx6U
         uNDiMda04+9taFjnGjkaGjP9Q3G1ZpxAWFaOHnCiS3qu4j2C46SL6mpRX2it92jOUt
         xIs2FC4xPq/3A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 246F25C015D; Fri, 15 Jul 2022 08:21:45 -0700 (PDT)
Date:   Fri, 15 Jul 2022 08:21:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <Paul.Heidekrueger@in.tum.de>,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-toolchains@vger.kernel.org,
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Subject: Re: [PATCH RFC] tools/memory-model: Adjust ctrl dependency definition
Message-ID: <20220715152145.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220615114330.2573952-1-paul.heidekrueger@in.tum.de>
 <YqnpshlsAHg7Uf9G@rowland.harvard.edu>
 <50B9D7C1-B11D-4583-9814-BFFF2C80D8CA@in.tum.de>
 <YrHUkfDWsexHRUKj@rowland.harvard.edu>
 <04B4DBD6-1262-4905-9E85-9466FC104895@in.tum.de>
 <YrnFCSjESpeQdciv@rowland.harvard.edu>
 <20F4C097-24B4-416B-95EE-AC11F5952B44@in.tum.de>
 <YtFrPoOARrL/etBu@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YtFrPoOARrL/etBu@rowland.harvard.edu>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 15, 2022 at 09:27:26AM -0400, Alan Stern wrote:
> On Fri, Jul 15, 2022 at 02:27:28PM +0200, Paul Heidekrüger wrote:
> > I have just been thinking about how to word this patch; am I correct in
> > assuming that the LKMM does not deal with loop conditions? Or in other
> > words, there is no way for a loop condition to impose a ctrl dependency on
> > any WRITE_ONCE's in the loop body? It are only if and switch statements the
> > LKMM is concerned with in the case of ctrl dependencies?
> 
> In theory, the LKMM does say that a loop condition imposes a control 
> dependency on any memory accesses within the loop body.  However, the 
> herd7 tool has only very limited support for looping constructs, so in 
> practice it's not possible to create suitable litmus tests with loops.

And Alan isn't joking.  The closest simulation that I know of is to
combine limited loop unrolling with the "filter" clause.  The point of
the filter clause is to eliminate from consideration executions that
need the more iterations of the loop to be unrolled.

And that means that as far as LKMM is concerned, loop-based control
dependencies are similar to those for nested "if" statements.

							Thanx, Paul
