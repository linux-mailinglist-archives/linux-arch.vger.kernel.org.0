Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CC078CD11
	for <lists+linux-arch@lfdr.de>; Tue, 29 Aug 2023 21:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbjH2Thc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Aug 2023 15:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240428AbjH2ThB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Aug 2023 15:37:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7A8109;
        Tue, 29 Aug 2023 12:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AD5E641E7;
        Tue, 29 Aug 2023 19:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD9D8C433C9;
        Tue, 29 Aug 2023 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693337817;
        bh=gCcw7cvd5IuQnv6kV0Ao6adg0/EXaXQ9XzkH4O4gLnA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HNeBnzNaSiU0L3Ie0gzGW58JOARLieCoxLgDDUdvP577mAJHItYJzD8u6sormaUCU
         s9YE+8J9fw7YjdM7WzR+A36aCFtXu7zH8sTYzvd0DHxq+EuZzonciJv2hiorHBtbWV
         b7Ly40YVfajg2PFj5HrJVJKfucQfdbhQ4PoMxuho1zKxW7vqCpt4A75fjMHPb5UlOx
         tPufU+r+uAPe10WviglxzulYSHD32Kfs3VQ1aAIp4ra5vUP3UdHBHIwndQmmbaFZ9C
         3gWOIqLLJYc8ar3Qfft3ASM/PMFAeIS+XrfFMy8dEe0WYMed7qVK5zUx421Ofgipeg
         6OA38zD3t3a6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA941C595D2;
        Tue, 29 Aug 2023 19:36:57 +0000 (UTC)
Subject: Re: [GIT PULL] csky changes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230829150236.2701631-1-guoren@kernel.org>
References: <20230829150236.2701631-1-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230829150236.2701631-1-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.6
X-PR-Tracked-Commit-Id: c8171a86b27401aa1f492dd1f080f3102264f1ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eaf9f4649cf03ba3442712497a30686380ba7c23
Message-Id: <169333781769.25364.3114102057878400161.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 19:36:57 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, guoren@kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Tue, 29 Aug 2023 11:02:36 -0400:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eaf9f4649cf03ba3442712497a30686380ba7c23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
