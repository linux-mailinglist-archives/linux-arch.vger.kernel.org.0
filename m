Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC03368ACDA
	for <lists+linux-arch@lfdr.de>; Sat,  4 Feb 2023 23:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjBDWYQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 4 Feb 2023 17:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDWYP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 4 Feb 2023 17:24:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12F61EFE6;
        Sat,  4 Feb 2023 14:24:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81C8FB80B69;
        Sat,  4 Feb 2023 22:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B8BC433D2;
        Sat,  4 Feb 2023 22:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675549452;
        bh=Sm2d8k9RPZVo8JdWBw80YfFCn+If9x6+NZFYNIfLeM0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IBOjNPdhP2dyX5fKdIBLJitAyqa9AMQHi4g+eDC5O5mfcxedWxOgS0ijLx1RRSQAI
         Fn6pR5/w4P30wbvdNAPjCLtdxly0DuETY0TIW4yWQsMYmfQTX0H8LWcYWgxtl/mpht
         LOawar/1wpaRVG8WaKOgfi6aWvdKKEEyymxCjV7V2Kj8uPHDLGAtqyW1mq+JArsjDe
         QidmaKMN9XBNS6IfYtrvPhAHIAuQixf8S75nrbEW9wojaHzrmpbdnHR/LuQ4dlNttD
         5UeJKXDG7b4yQRSDTsiUqUx3fRI0M9cvNE4WJegu73kLv9X3MYSFivEUKEiEWlc25J
         LMHlV2jBzHFpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A699C5C06AB; Sat,  4 Feb 2023 14:24:11 -0800 (PST)
Date:   Sat, 4 Feb 2023 14:24:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: Current LKMM patch disposition
Message-ID: <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230204004843.GA2677518@paulmck-ThinkPad-P17-Gen-1>
 <Y920w4QRLtC6kd+x@rowland.harvard.edu>
 <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y95yhJgNq8lMXPdF@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y95yhJgNq8lMXPdF@rowland.harvard.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 04, 2023 at 09:58:12AM -0500, Alan Stern wrote:
> On Fri, Feb 03, 2023 at 05:49:41PM -0800, Paul E. McKenney wrote:
> > On Fri, Feb 03, 2023 at 08:28:35PM -0500, Alan Stern wrote:
> > > On Fri, Feb 03, 2023 at 04:48:43PM -0800, Paul E. McKenney wrote:
> > > > Hello!
> > > > 
> > > > Here is what I currently have for LKMM patches:
> > > > 
> > > > 289e1c89217d4 ("locking/memory-barriers.txt: Improve documentation for writel() example")
> > > > ebd50e2947de9 ("tools: memory-model: Add rmw-sequences to the LKMM")
> > > > aae0c8a50d6d3 ("Documentation: Fixed a typo in atomic_t.txt")
> > > > 9ba7d3b3b826e ("tools: memory-model: Make plain accesses carry dependencies")
> > > > 
> > > > 	Queued for the upcoming (v6.3) merge window.
> > > > 
> > > > c7637e2a8a27 ("tools/memory-model: Update some warning labels")
> > > > 7862199d4df2 ("tools/memory-model: Unify UNLOCK+LOCK pairings to po-unlock-lock-")
> > > > 
> > > > 	Are ready for the next (v6.4) merge window.  If there is some
> > > > 	reason that they should instead go into v6.3, please let us
> > > > 	all know.
> > > > 
> > > > a6cd5214b5ba ("tools/memory-model: Document LKMM test procedure")
> > > > 
> > > > 	This goes onto the lkmm-dev pile because it is documenting how
> > > > 	to use those scripts.
> > > > 
> > > > https://lore.kernel.org/lkml/Y9GPVnK6lQbY6vCK@rowland.harvard.edu/
> > > > https://lore.kernel.org/lkml/20230126134604.2160-3-jonas.oberhauser@huaweicloud.com
> > > > https://lore.kernel.org/lkml/20230203201913.2555494-1-joel@joelfernandes.org/
> > > > 5d871b280e7f ("tools/memory-model: Add smp_mb__after_srcu_read_unlock()")
> > > > 
> > > > 	These need review and perhaps further adjustment.
> > > > 
> > > > So, am I missing any?  Are there any that need to be redirected?
> > > 
> > > The "Provide exact semantics for SRCU" patch should have:
> > > 
> > > 	Portions suggested by Boqun Feng and Jonas Oberhauser.
> > > 
> > > added at the end, together with your Reported-by: tag.  With that, I 
> > > think it can be queued for 6.4.
> > 
> > Thank you!  Does the patch shown below work for you?
> > 
> > (I have tentatively queued this, but can easily adjust or replace it.)
> 
> It looks fine.

Very good, thank you for looking it over!  I pushed it out on branch
stern.2023.02.04a.

Would anyone like to ack/review/whatever this one?

							Thanx, Paul
