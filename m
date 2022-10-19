Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD606053B9
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 01:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiJSXGp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 19:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiJSXGo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 19:06:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A814DF05;
        Wed, 19 Oct 2022 16:06:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD48EB824B7;
        Wed, 19 Oct 2022 23:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4F6C433C1;
        Wed, 19 Oct 2022 23:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220800;
        bh=Xc7Hmsj72dcnXqT1x/62xjR9gpKsix9C18SOrhtJo2I=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=kfMXqVLE9WJ5JjEjfYIiy2RGHwtOBh8M+SAq+CmZND9aDD4v/jVDW/Hfz5dJpv8Bi
         vrsr6Bp2iCXokbBZnFv6/6sZLw1kdbqpR2OXTpacAp1yFh+FW2T5+bj58Kly0AIMRf
         3owqQ6x//6GNEqGNnF+hIZBk77QFkQ2+GEruoQ5/OCDHQnsq8VYflz43pTplVfKjRA
         JygGeDPTJAotTLW9SnkjNym7c22BHNZTEU8mIE1bcPqf/N6ZVZpJzxR7XUNuZx7Ngp
         vRECzQXW3IOgnBxzP4W5HiwkPq2n1yE4wIrc7jLLmolQTW0y1BBN59E7oWyCKC8MZW
         FDiC+efkD4SHw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3123E5C06B4; Wed, 19 Oct 2022 16:06:40 -0700 (PDT)
Date:   Wed, 19 Oct 2022 16:06:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: [PATCH memory-model 0/5] LKMM updates for v6.2
Message-ID: <20221019230640.GA2502305@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

This series provides LKMM updates:

1.	tools/memory-model: Weaken ctrl dependency definition in
	explanation.txt, courtesy of Paul Heidekrüger.

2.	docs/memory-barriers.txt: Add a missed closing parenthesis,
	courtesy of SeongJae Park.

3.	docs/memory-barriers.txt/kokr: introduce io_stop_wc() and add
	implementation for ARM64, courtesy of SeongJae Park.

4.	docs/memory-barriers.txt/kokr: Add memory barrier dma_mb(),
	courtesy of SeongJae Park.

5.	docs/memory-barriers.txt/kokr: Fix confusing name of 'data
	dependency barrier', courtesy of SeongJae Park.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/translations/ko_KR/memory-barriers.txt   |  141 +++++++++--------
 b/Documentation/memory-barriers.txt                    |    2 
 b/Documentation/translations/ko_KR/memory-barriers.txt |    8 
 b/tools/memory-model/Documentation/explanation.txt     |    7 
 4 files changed, 90 insertions(+), 68 deletions(-)
