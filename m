Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8197D1F53
	for <lists+linux-arch@lfdr.de>; Sat, 21 Oct 2023 22:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjJUUH2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Oct 2023 16:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJUUH2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Oct 2023 16:07:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD56B0;
        Sat, 21 Oct 2023 13:07:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F003EC433C7;
        Sat, 21 Oct 2023 20:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697918846;
        bh=AqDrIYx3jTh6N+utjmLqaiBGL9aD5YIrtP9aGEGHFHs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=irpOU3OA/aMBdiwH/b0h4NYiMxZSS0OfiDe7tsfmKqCM8ZpFonh6Nt2hgLnfTORJK
         6oIPQ7C9WJq+eQlruhQVbgC2rKXcR6z7aVuq7otEdQLhI0AbbnJ/eyR9CIq/xN/hVn
         SvcNX6hvpLHdSNcUhB8Beyg4MYetiWFswV9HHhsunAvh8rG5pj64YOUBrHTxd65pgH
         3y4PP4sBuMlP2AEIAk7OhxxyEkWUssevo+uY+RVhPuTlVia24guUiZX2VBXwdZx0d/
         GQO7YOp3ATV95+yag75UpzfHiZBRDZmhUwkLYGfZ/b+0fSjMiUNrF+oGwrHEBgm6rF
         3ORepqLvEkxoQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 89849CE1071; Sat, 21 Oct 2023 13:07:25 -0700 (PDT)
Date:   Sat, 21 Oct 2023 13:07:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>,
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
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH memory-model] docs: memory-barriers: Add note on compiler
 transformation and address deps
Message-ID: <f8d82079-bd45-428f-ab3b-593fd3757baf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <4110a58a-8db5-57c4-2f5a-e09ee054baaa@huaweicloud.com>
 <1c731fdc-9383-21f2-b2d0-2c879b382687@huaweicloud.com>
 <f363d6e0-5682-43e7-9a3f-6b896c3cd920@paulmck-laptop>
 <b96cfbc1-f6b0-2fa6-b72d-d57c34bbf14b@huaweicloud.com>
 <2694e6e1-3282-4a69-b955-06afd7d7f87f@paulmck-laptop>
 <0bf4cda3-cc43-0e77-e47b-43e1402ed276@huaweicloud.com>
 <79233008-4be2-4442-9600-f9ac1a654312@paulmck-laptop>
 <591279ff-3316-d64b-8b25-6baefcecaad1@huaweicloud.com>
 <8f2ed577-424a-4114-8c90-90ba657e08db@paulmck-laptop>
 <e9aa4f00-1db8-44a7-aa1f-122cdeeecc23@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9aa4f00-1db8-44a7-aa1f-122cdeeecc23@rowland.harvard.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 21, 2023 at 12:03:30PM -0400, Alan Stern wrote:
> On Sat, Oct 21, 2023 at 08:10:27AM -0700, Paul E. McKenney wrote:
> > On Sat, Oct 21, 2023 at 03:36:21PM +0200, Jonas Oberhauser wrote:
> > > 
> > > Am 10/20/2023 um 8:13 PM schrieb Paul E. McKenney:
> > > > Fair enough in general, but I cannot promise to never confuse people.
> > > > This is after all memory ordering.  And different people will be confused
> > > > by different things.
> > > 
> > > You can say that twice. In fact I suspect this is not the first time you say
> > > that :))
> > 
> > Easy for me to say, "that that that that that that that that that that"!
> 
> This reminds me of a sentence I once heard as an example of 
> inscrutability.  Written without punctuation, it goes:
> 
> 	Jack when Joe had had had had had had had had had had
> 	the teachers approval.
> 
> Properly punctuated, it says:
> 
> 	Jack, when Joe had had "had", had had "had had"; "had had" had 
> 	the teacher's approval.
> 
> The context is supposed to be a comparison of the words two students 
> used in their essays and how their teacher reacted.  It actually 
> makes sense when read carefully.

Cute!

In contrast, any sensible interpretationof my string of "that"s is
pure coincidence.  ;-)

							Thanx, Paul
