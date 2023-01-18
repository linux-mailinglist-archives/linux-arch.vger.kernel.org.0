Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE07672B8C
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jan 2023 23:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjARWrI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Jan 2023 17:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjARWrH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Jan 2023 17:47:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0720392B2;
        Wed, 18 Jan 2023 14:47:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B3D561A8E;
        Wed, 18 Jan 2023 22:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFE46C433F0;
        Wed, 18 Jan 2023 22:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674082025;
        bh=IXzqkYp637f9FFHz3IM9yM1xNvc8W5Lh4WiOPUudzTU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lxxT/2KPyHjJMFnhlLqT6k3rVwnJ4Hwit1s9PFPCmso0qjY70DFXJCargEkC5G/CO
         w14CUcbY8PkOwVzyMm/RGckaJO1ZksSA/8sM4Bn7/9m9/tH6j+SlwGeV3CXquqHhou
         KeMkndPzvOM3WE02NFY+EXH+IDMGxd8ZOLWoyC0QXp7Mf7TcMrMoDQhyIOaFgMr7NH
         Vuyg7EVybhDNGVp/+vGZl9QTgA5J0MhZrIn9PMLvOpzGCK5JEOjFPpCEKHI9KYK9US
         DJ7cmy9KaZ3N1Yt6F4Ifl1vO6rHjyjBswpgmq+OEO4zCnTl+34+Pkn3zwPIZNO8ALu
         5gsJGLDsMPtJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98249E54D2B;
        Wed, 18 Jan 2023 22:47:05 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230118092651.2452402-1-chenhuacai@loongson.cn>
References: <20230118092651.2452402-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20230118092651.2452402-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.2-1
X-PR-Tracked-Commit-Id: dc74a9e8a8c57966a563ab078ba91c8b2c0d0a72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84bd7e08a79a5d3153c3a5805a1347a8dc979f35
Message-Id: <167408202561.14684.15699936419070494644.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Jan 2023 22:47:05 +0000
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Wed, 18 Jan 2023 17:26:51 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84bd7e08a79a5d3153c3a5805a1347a8dc979f35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
