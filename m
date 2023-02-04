Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A2A68A74F
	for <lists+linux-arch@lfdr.de>; Sat,  4 Feb 2023 01:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjBDAsv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 19:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjBDAss (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 19:48:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE595A6C12;
        Fri,  3 Feb 2023 16:48:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42EBBB82B67;
        Sat,  4 Feb 2023 00:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAF3C433D2;
        Sat,  4 Feb 2023 00:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675471723;
        bh=kLZT0ktDIqHrvbR1Q4leufjyhZrsbBm0llBRKZGRRu8=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=GH87hbn9/uT6AMKgTWTt+V+3TBPeEik2srqTaasdIuCAlXuu98eAKIrCuAhJKPAWQ
         91XUJO99BtQO6B0/53bmhgZ/1+yNnomX0/6/xokoCsquSNttLJ5aGg9EhwTpbHCv6t
         G6JG3hESqWS5DTARkSKK18fzg4zC18J4H9dIJXbTK0SSKMLOgkxbaA5NcRhOYjCVm1
         TjxzyI7B21VxXZBTPL1YtF16KXCsMc9FQO4kHNAyWWi95q1w5h2YphXe58vZ+rYqNt
         6E2nHGMvYDCfde3YjsQINGkv4QKOHrqdyRdOKw6rT75o/QNmYM8XypRDKIj2N0PMPX
         IO3U+1NL4LrRQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 804BF5C08EB; Fri,  3 Feb 2023 16:48:43 -0800 (PST)
Date:   Fri, 3 Feb 2023 16:48:43 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: Current LKMM patch disposition
Message-ID: <20230204004843.GA2677518@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

Here is what I currently have for LKMM patches:

289e1c89217d4 ("locking/memory-barriers.txt: Improve documentation for writel() example")
ebd50e2947de9 ("tools: memory-model: Add rmw-sequences to the LKMM")
aae0c8a50d6d3 ("Documentation: Fixed a typo in atomic_t.txt")
9ba7d3b3b826e ("tools: memory-model: Make plain accesses carry dependencies")

	Queued for the upcoming (v6.3) merge window.

c7637e2a8a27 ("tools/memory-model: Update some warning labels")
7862199d4df2 ("tools/memory-model: Unify UNLOCK+LOCK pairings to po-unlock-lock-")

	Are ready for the next (v6.4) merge window.  If there is some
	reason that they should instead go into v6.3, please let us
	all know.

a6cd5214b5ba ("tools/memory-model: Document LKMM test procedure")

	This goes onto the lkmm-dev pile because it is documenting how
	to use those scripts.

https://lore.kernel.org/lkml/Y9GPVnK6lQbY6vCK@rowland.harvard.edu/
https://lore.kernel.org/lkml/20230126134604.2160-3-jonas.oberhauser@huaweicloud.com
https://lore.kernel.org/lkml/20230203201913.2555494-1-joel@joelfernandes.org/
5d871b280e7f ("tools/memory-model: Add smp_mb__after_srcu_read_unlock()")

	These need review and perhaps further adjustment.

So, am I missing any?  Are there any that need to be redirected?

						Thanx, Paul
