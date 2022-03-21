Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659EF4E335F
	for <lists+linux-arch@lfdr.de>; Mon, 21 Mar 2022 23:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiCUWxX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 18:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiCUWxQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 18:53:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765CA3CCCCB;
        Mon, 21 Mar 2022 15:32:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12FD4B81A7C;
        Mon, 21 Mar 2022 21:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8856C36AE3;
        Mon, 21 Mar 2022 21:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647899630;
        bh=mJpMKx/LEhyI2AArneD5Jiu/AsgrskpH6ERyGHkAU0U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RzhQIwGRGKX+OHIGebdFrab7fYja8mfMmn/bajtfTzXlsxgF/CdMw0d29wVnFNCWg
         S+dHv/brHpPc0+CpsIFnqvDi53IYjyAIp//mYedfX8VkHfwC0CMXLMUINuVR6fxVrT
         ouAq46s87LRzNjOjEQzeKagzppqbRPsf2Mx9hr78t/4caQVGW0Gf5jrzLoXvKaky1g
         GnHOLaEThSjznCLQbnQxjtnn9tb+2bHhzBPUB0s5d0CqnncaeqIHxMUe+KCtlf0F/0
         QHVg7rvw+jWAQtkvxhJBYsVIZDUZxlkI8qVPzvToyTTKSUjyoFv86vH/p6Eeq+/lbx
         RymdTdXzx6P2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5A5DEAC096;
        Mon, 21 Mar 2022 21:53:50 +0000 (UTC)
Subject: Re: [GIT PULL] LKMM changes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220314033141.GA2594098@paulmck-ThinkPad-P17-Gen-1>
References: <20220314033141.GA2594098@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220314033141.GA2594098@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2022.03.13a
X-PR-Tracked-Commit-Id: e2b665f612ca2ddc61c3d54817a3a780aee6b251
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2eb5500f1d916c9b0815cdc63c48a6d615532cc
Message-Id: <164789963067.9856.11123238377689030524.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 21:53:50 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, stern@rowland.harvard.edu
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Sun, 13 Mar 2022 20:31:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2022.03.13a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2eb5500f1d916c9b0815cdc63c48a6d615532cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
