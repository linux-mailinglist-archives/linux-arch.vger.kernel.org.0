Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926545A8591
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 20:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiHaS2f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Aug 2022 14:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiHaS2N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Aug 2022 14:28:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4571898CA2;
        Wed, 31 Aug 2022 11:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D51F7B82221;
        Wed, 31 Aug 2022 18:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F301C433D7;
        Wed, 31 Aug 2022 18:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970230;
        bh=fYCQfnEwpOVlVfS6btj2u1SLUquTKDlCgujlhLw9hfw=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=qSMznd5Gn4hO+P4O38SY7qplTUw2JZT81sSR78p2mP2AjcJVXdxIEyfDiSTc+5SjK
         SNxYnM4bjQx53UhoDIXMrUV3zVDZ91R1RzC5p7Vom5QWQ/JL6M7KucXPXsrQkiMMEt
         v1dkbbglno7CplMM/QvQ4hBXTwLTQZ63D16TbMmGV9YNPIpL0S9uDwr7eEyIsARj47
         IiCLsU1mTKqHyaZIbAH9u/mk/ZgyutiDO9kF/VtxGiyZrYRKaq6x8r34VAM94z8c+k
         aqGnE2Gh7xGXGA73Kbyq28qNCrPc0QSTH0SQipO0Hxo/QWyGCACKmEE30st4Vb8bOn
         MSvulrQWIG1vA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2491F5C015D; Wed, 31 Aug 2022 11:23:50 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:23:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: [PATCH memory-model 0/3] Linux-kernel memory model updates for v6.1
Message-ID: <20220831182350.GA2698943@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

This series provides a few updates and fixes for LKMM documentation:

1.	docs/memory-barriers.txt: Fix confusing name of 'data dependency
	barrier', courtesy of Akira Yokosawa.

2.	docs/memory-barriers.txt: Fixup long lines, courtesy of Akira
	Yokosawa.

3.	tools/memory-model: Clarify LKMM's limitations in
	litmus-tests.txt, courtesy of =?UTF-8?q?Paul=20Heidekr=C3=BCger?=.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/memory-barriers.txt                   |   93 ++++++++--------
 b/Documentation/memory-barriers.txt                 |  116 +++++++++++---------
 b/tools/memory-model/Documentation/litmus-tests.txt |   37 ++++--
 3 files changed, 138 insertions(+), 108 deletions(-)
