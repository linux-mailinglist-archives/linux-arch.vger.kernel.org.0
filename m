Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F30352F2A1
	for <lists+linux-arch@lfdr.de>; Fri, 20 May 2022 20:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352639AbiETSae (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 May 2022 14:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352643AbiETSaY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 May 2022 14:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E7C170F28;
        Fri, 20 May 2022 11:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CB5560EE7;
        Fri, 20 May 2022 18:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47FEC385A9;
        Fri, 20 May 2022 18:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653071422;
        bh=91Hb6r7TlTyesuzfEVgXuDP7hmNfgJCZmnhpKOzOnhE=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ZOTq2OP4OFI1Bhsv1YOXyRHAlQxFhxm77XHIzgS+nriHpNNL1ppxIKtrX8UFUJUQf
         hZ8PsrJUYqOaz8TdBMddv3HlST2sROTCsX9oKjsE83gK5wLDsPLkpCZ2w68bJHA2Sc
         5jJO1++avFi5m1sXhkFRJQ5Qf0j+/0MVGoaRs4dZWW/J7/0swRdefPq6vyaE0Bt2ot
         E8hmfi6Hu00cPicgC8vaKILMKnspJOPh2M84dSR5PoDDcyFolmGUeazf+JHVExst3E
         uEz5xYSZzpag8RKC//7NzKfJTgOQcZtaS46t1/qRbQ7bcm1Z5OITk4L2rUoC8aELSt
         Mu6jMfSTwA4vg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7C7CF5C05F8; Fri, 20 May 2022 11:30:22 -0700 (PDT)
Date:   Fri, 20 May 2022 11:30:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, akiyks@gmail.com
Subject: [GIT PULL] LKMM changes for v5.19
Message-ID: <20220520183022.GA3791835@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello, Linus,

Once the merge window opens, please pull the latest LKMM change from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2022.05.20a
  # HEAD 5b759db44195bb779828a188bad6b745c18dcd55 tools/memory-model/README: Update klitmus7 compat table (2022-05-03 10:12:48 -0700)

----------------------------------------------------------------
LKMM pull request for v5.18

This pull request updates the klitmus7 compatibility table to indicate
that herdtools7 7.56.1 or better is required for Linux kernel v5.17
or later.

----------------------------------------------------------------
Akira Yokosawa (1):
      tools/memory-model/README: Update klitmus7 compat table

 tools/memory-model/README | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
