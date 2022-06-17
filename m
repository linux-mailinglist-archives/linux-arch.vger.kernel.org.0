Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B7154FD78
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jun 2022 21:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiFQTWY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 15:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiFQTWW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 15:22:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8505047A;
        Fri, 17 Jun 2022 12:22:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 884CEB82B49;
        Fri, 17 Jun 2022 19:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38CF6C3411B;
        Fri, 17 Jun 2022 19:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655493739;
        bh=Lz0ieny+u/I7cAPkDDl5yZ/SbgiN90K1CuHA7DQocXQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Oy0BNom3D4ksp1nFINUAZnXFBlevLGfROJ4rN2OUMu1lBgA5LdMXDfn4/R/jEz+H4
         5/FIGVI/JeQESg1eWC3wYvvX5dGcD1yaSzbSaS4WvaJC9lTF1b9IMEhKyeYzw1wyB7
         9qEWTkbNn9l7ji6Gmx8G7jWWYo5RHbDvOQN06JX3rILsV/wDDh2dSeUgqV0gDwU/KX
         UW6oPjhsYLZzvxa0PqfHVRoB0L/5k+RSqaiMUAWfqln2t6cWhYZ6jrVCYkZrjU+lYa
         MfV9mZZkn50JuvnRV2pJhDs14r237AgUxc9QQIrDerutqjoFXQnMpy6SUl3TAcjTs9
         WEYiJ7RLdElgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25D3AE6D466;
        Fri, 17 Jun 2022 19:22:19 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220617144428.569247-1-chenhuacai@loongson.cn>
References: <20220617144428.569247-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20220617144428.569247-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-5.19-2
X-PR-Tracked-Commit-Id: 03dfb4a3abc4cc497850e6968b59005485592369
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc2fb31d49f8956283e7cd25face1327dcfa4c16
Message-Id: <165549373914.16480.10476201775866298316.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jun 2022 19:22:19 +0000
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Fri, 17 Jun 2022 22:44:28 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-5.19-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc2fb31d49f8956283e7cd25face1327dcfa4c16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
