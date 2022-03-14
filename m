Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46B74D79A5
	for <lists+linux-arch@lfdr.de>; Mon, 14 Mar 2022 04:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiCNDcv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Mar 2022 23:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiCNDcv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Mar 2022 23:32:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CB565E9;
        Sun, 13 Mar 2022 20:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29A2860F79;
        Mon, 14 Mar 2022 03:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1A2C340E9;
        Mon, 14 Mar 2022 03:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647228701;
        bh=9lv71GxeVZNDHbm/CSl+pzvHGP16YZgnpphJBKi7cZs=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=G2LzKzorwdmZq+cBBTnD/mnUEHirV4tSIjMLoWKGe7IvcKpEwWcxYMczeh43OsoI2
         kt0CfFqkmfa1eTWHjGjjujnbvoy3UEnGGwQf2l9Duom0cFp4/yXZAmb4lQMlfGcifW
         wxfKEajdfuxQNpdo0vdITFJO4mJx4Vb1CwCYRVQPjSvf1LqG9bY0dt/3xi+9C46KJg
         oWo8xDckffM4YGSzQ7RxPrnilcmrPKvSNPZ9Q/1ew0AQcxVN4fcFEg2jJ26iguVtVK
         l0jRLoSVa0gAZK5FQd5NKGwNHFij8TRe7gR5jVOna5/4fJLbLIEm9dPaAzWR9ZjIWo
         Fj5AgazHNh+5w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2B6A55C4167; Sun, 13 Mar 2022 20:31:41 -0700 (PDT)
Date:   Sun, 13 Mar 2022 20:31:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kernel-team@fb.com,
        stern@rowland.harvard.edu
Subject: [GIT PULL] LKMM changes for v5.18
Message-ID: <20220314033141.GA2594098@paulmck-ThinkPad-P17-Gen-1>
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

Please pull the latest LKMM git tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2022.03.13a
  # HEAD: e2b665f612ca2ddc61c3d54817a3a780aee6b251: tools/memory-model: Explain syntactic and semantic dependencies (2022-02-01 17:32:30 -0800)

This series contains an improved explanation of syntactic and semantic
dependencies from Alan Stern.

----------------------------------------------------------------
Alan Stern (1):
      tools/memory-model: Explain syntactic and semantic dependencies

 tools/memory-model/Documentation/explanation.txt | 51 ++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
