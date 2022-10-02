Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A345F212F
	for <lists+linux-arch@lfdr.de>; Sun,  2 Oct 2022 05:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJBDbZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 Oct 2022 23:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJBDbU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Oct 2022 23:31:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFDF25C46;
        Sat,  1 Oct 2022 20:31:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6989960DE4;
        Sun,  2 Oct 2022 03:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6124C43470;
        Sun,  2 Oct 2022 03:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664681476;
        bh=f9EOJxKz0wZj1+DaP9C9ACnZJodE42XulhzKBB3usoA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=LVfJkaEYlbOU5Mvy5QuKRXtl+smdiOWLPP5WOP5z8bZu/Ot82XDJVsiE6RDyS2Hse
         N3myaC2LkwyH9qiJJQNg4X3Gu/LZ/MJlTVmdfrfQ5grJXQAtVsojfuQKCw/h8EbCKA
         srlWZb0gCzjbzhzWH2i9YDGstkKWsrAzjTmGDRY53roxDUHnMa3Rohoj/YWYGcpluQ
         ocsTGScBa9C/zpY3S93ofX0a4vb4TQUKoitO5OGN4efAFjBay/FhaqbLQY2z9zPlUf
         HKaLComnSxJ+Aus9UC3vG7j403yuTrdKfIommi2btUK+mRRTsS40TQVAPli+cYSpe7
         gG86TO3rOXc8g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 655265C05B1; Sat,  1 Oct 2022 20:31:16 -0700 (PDT)
Date:   Sat, 1 Oct 2022 20:31:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, akiyks@gmail.com, paul.heidekrueger@in.tum.de
Subject: [GIT PULL] LKMM changes for v6.1
Message-ID: <20221002033116.GA3513193@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello, Linus,

Once the merge window opens, please pull the latest LKMM changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2022.09.30a
  HEAD: be94ecf7608cc11ff46442012e710bb8fb139b99: tools/memory-model: Clarify LKMM's limitations in litmus-tests.txt (2022-08-31 05:15:31 -0700)

----------------------------------------------------------------
LKMM pull request for v6.1

This pull request includes several documentation updates.

----------------------------------------------------------------
Akira Yokosawa (2):
      docs/memory-barriers.txt: Fix confusing name of 'data dependency barrier'
      docs/memory-barriers.txt: Fixup long lines

Paul Heidekrüger (1):
      tools/memory-model: Clarify LKMM's limitations in litmus-tests.txt

 Documentation/memory-barriers.txt                 | 177 ++++++++++++----------
 tools/memory-model/Documentation/litmus-tests.txt |  37 +++--
 2 files changed, 122 insertions(+), 92 deletions(-)
