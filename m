Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B85F68C8C8
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 22:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBFVaU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 16:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjBFVaP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 16:30:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321C722A2E;
        Mon,  6 Feb 2023 13:29:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32433B81624;
        Mon,  6 Feb 2023 21:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2480C433EF;
        Mon,  6 Feb 2023 21:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675718989;
        bh=A4kvVdPJamkhM4/xW6SLW6LfAIVjhxXcEW3FpuOysBw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pzx7T0MAQyFyP4G//Gp1AKr6s0QEQ/6z628N6iwSCuAz5NUcxMZqtUjKVrP2bMIlk
         t7YfAU1vaHTr/LrcQfxb2Trio/uIJ3kL+NZBUl4nDPPGu6V3U9WCjhYAxWNsQLA8sB
         cvMcSJtHtWJaSHguHoPidzN7POAYvHgXsqejzUYldoAxh8Cpd2PVCtFIv3D0TF3Uvj
         assfJX7nwvQYPb5VgwsPHVBxiBmRk0hpV2zOvuxMGqWhk33xlx/bslWsUP/COcdwo8
         hiLomSSkB65Clb09xwyV41tq7C8OFKp/nvkdyv/FsxjHr4UCfith+7ArB7zTqa7Ry+
         a+m8JtkqrwRxg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7369D5C0993; Mon,  6 Feb 2023 13:29:48 -0800 (PST)
Date:   Mon, 6 Feb 2023 13:29:48 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: Current LKMM patch disposition
Message-ID: <20230206212948.GT2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230204004843.GA2677518@paulmck-ThinkPad-P17-Gen-1>
 <3e55c8ec-1b02-fa7c-0215-1dbaf3462f94@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e55c8ec-1b02-fa7c-0215-1dbaf3462f94@huaweicloud.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 06, 2023 at 09:20:59PM +0100, Jonas Oberhauser wrote:
> On 2/4/2023 1:48 AM, Paul E. McKenney wrote:
> > [...]
> > https://lore.kernel.org/lkml/20230203201913.2555494-1-joel@joelfernandes.org/
> > 5d871b280e7f ("tools/memory-model: Add smp_mb__after_srcu_read_unlock()")
> > 
> > 	These need review and perhaps further adjustment.
> > 
> > So, am I missing any?  Are there any that need to be redirected?
> 
> Didn't you schedule joel's patch for 6.4?

Agreed, and Alan's patch as well.  The scoreboard now stands as shown
below.

							Thanx, Paul

------------------------------------------------------------------------

289e1c89217d4 ("locking/memory-barriers.txt: Improve documentation for writel() example")
ebd50e2947de9 ("tools: memory-model: Add rmw-sequences to the LKMM")
aae0c8a50d6d3 ("Documentation: Fixed a typo in atomic_t.txt")
9ba7d3b3b826e ("tools: memory-model: Make plain accesses carry dependencies")

	Queued for the upcoming (v6.3) merge window.

c7637e2a8a27 ("tools/memory-model: Update some warning labels")
7862199d4df2 ("tools/memory-model: Unify UNLOCK+LOCK pairings to po-unlock-lock-")
2e9fc6060678 ("tools/memory-model: Restrict to-r to read-read address dependency")
7e46006a97c9 ("tools/memory-model: Provide exact SRCU semantics")

	Are ready for the next (v6.4) merge window.  If there is some
	reason that they should instead go into v6.3, please let us
	all know.

a6cd5214b5ba ("tools/memory-model: Document LKMM test procedure")

	This goes onto the lkmm-dev pile because it is documenting how
	to use those scripts.

https://lore.kernel.org/lkml/20230126134604.2160-3-jonas.oberhauser@huaweicloud.com
5d871b280e7f ("tools/memory-model: Add smp_mb__after_srcu_read_unlock()")

	These need review and perhaps further adjustment.
