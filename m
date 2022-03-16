Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720944DB96E
	for <lists+linux-arch@lfdr.de>; Wed, 16 Mar 2022 21:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbiCPUgg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Mar 2022 16:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiCPUgf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Mar 2022 16:36:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F1D3ED0D;
        Wed, 16 Mar 2022 13:35:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC680611D4;
        Wed, 16 Mar 2022 20:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E876C340E9;
        Wed, 16 Mar 2022 20:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647462919;
        bh=1iG6w36oiUSTdqZbextUaBRlpmz6PKUoiryJzJ8AFVo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ZGDqhrVYJVU0mXIlcwz6dq7G5WI4KqJWoYd+U01AGwzVr2yslBesqtGC2dqG6j+K1
         aoQ0mYtFpyoNqOhRVL7El6lyImzSIPGXGu14IAvjR3oUasIGtXBdnnMnR+V9aQ8z+t
         2IrnXuNBRQYdXGlFDf9594CITPk15xT032TWmnhdXXS6M/fY9rWLZv7ycgL3v9WJCv
         k/P22J6GWnyx/+Rm8shEhEAWXL8NvNvUq+/qYhU0MHbM7zVaVjMBkDW1J+WMBvFg2V
         jTPDvzf4/Qa3ZAtmPwrfPVi3BVF72MWT+lvDe7V/AJvrMPQ8WUF7fuLlWoGuXKEGkI
         ZDbEmFOaVrK1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B69595C0387; Wed, 16 Mar 2022 13:35:18 -0700 (PDT)
Date:   Wed, 16 Mar 2022 13:35:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kernel-team@fb.com,
        stern@rowland.harvard.edu
Subject: [GIT PULL] LKMM changes for v5.18 (take two)
Message-ID: <20220316203518.GA1945431@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello, Linus,

Once the merge window opens, please pull the latest LKMM git tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2022.03.13a
  # HEAD: e2b665f612ca2ddc61c3d54817a3a780aee6b251: tools/memory-model: Explain syntactic and semantic dependencies (2022-02-01 17:32:30 -0800)

This series contains an improved explanation of syntactic and semantic
dependencies from Alan Stern.

----------------------------------------------------------------
Alan Stern (1):
      tools/memory-model: Explain syntactic and semantic dependencies

 tools/memory-model/Documentation/explanation.txt | 51 ++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
