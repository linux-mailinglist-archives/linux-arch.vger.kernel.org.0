Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC1B65E242
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 02:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjAEBKH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Jan 2023 20:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjAEBJs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2023 20:09:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E633054E;
        Wed,  4 Jan 2023 17:09:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D872FB81980;
        Thu,  5 Jan 2023 01:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D65C433EF;
        Thu,  5 Jan 2023 01:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672880984;
        bh=gDgshQJctcr95mia7xQGmZ+KqafdYUTW62LyBGyc6HI=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=uncQfUcLCTyB3PA+sfpSZQMUo/9nktDpAE+nUymfmvQ3GPyTxkI0ZGEbdQnu/gmPK
         3am14J9HZ6l5vwwquuMpg/Sh00Z3O7ipdu/z1LDDhe6xaIxbIxZl+HY2qha6Q+rNB4
         zoSbW+hr/aPHzDNn7sleEu+DrrQRjknfgJoiR+wb+KRPQI645qEm56P4oqBlORh9pC
         IlikHni4UmRsFAgF1fmmB8F8c+myQhli8tYlBgtlO5zXgjhf5cywl7JejmcnZPeqLy
         8KGQ+3M0IHZO+dAu+lCn+PT7zax+YBoccREi6TSfJETIJXxrSBkL9sZbEpJISgJVcw
         udFFO7doEME7A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 14FCB5C05CA; Wed,  4 Jan 2023 17:09:44 -0800 (PST)
Date:   Wed, 4 Jan 2023 17:09:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: [PATCH memory-model 0/4] LKMM updates for v6.3
Message-ID: <20230105010944.GA1774169@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

This series provides LKMM updates:

1.	locking/memory-barriers.txt: Improve documentation for writel()
	example, courtesy of Parav Pandit.

2.	memory-model: Add rmw-sequences to the LKMM, courtesy of Alan
	Stern.

3.	Documentation: Fixed a typo in atomic_t.txt, courtesy of
	Kushagra Verma.

4.	memory-model: Make plain accesses carry dependencies, courtesy
	of Jonas Oberhauser.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/atomic_t.txt                       |    2 -
 b/Documentation/memory-barriers.txt                |   22 +++++++-------
 b/tools/memory-model/Documentation/explanation.txt |   30 ++++++++++++++++++++
 b/tools/memory-model/linux-kernel.bell             |    6 ++++
 b/tools/memory-model/linux-kernel.cat              |    5 ++-
 b/tools/memory-model/litmus-tests/dep+plain.litmus |   31 +++++++++++++++++++++
 tools/memory-model/Documentation/explanation.txt   |    9 +++++-
 7 files changed, 90 insertions(+), 15 deletions(-)
