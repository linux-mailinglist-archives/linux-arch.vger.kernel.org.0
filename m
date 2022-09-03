Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A375AC15A
	for <lists+linux-arch@lfdr.de>; Sat,  3 Sep 2022 22:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiICU3N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Sep 2022 16:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiICU3N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Sep 2022 16:29:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AB952098;
        Sat,  3 Sep 2022 13:29:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B263360DE8;
        Sat,  3 Sep 2022 20:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18A39C433D7;
        Sat,  3 Sep 2022 20:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662236951;
        bh=M7QpgVO5KP1FoCxkFsp6o06tH6aumSa+3QenVb6HTYw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cnrBhT5FRJbr8E9anolRMULu9LJIQXdWs12AiiMC3xTz+L253VKd3iEgdj4tE+p5m
         ZhZVoo+0G6y1kbNOtUHLNqzStNhKeIQPiB3vNlUOyMORPEQhbNE6RNCpA/x25rJzUe
         2pYaD2P8CEMaJ1ZutEHsF01PaefhgOJ8KoobgqR5zTsaopmGmeRJDizKw15XZcvEYs
         ObtklQ4beYLPATO1HTFrLRnC0DcV5cpBeogT8accu7A75RkfEQ9WAjUuFKb/v72L92
         VkJU4qy6kWg6N/bzLUx2J7o07j44Zu8UtbcVo+xztwe7FVX6QD+OhQT3JJRVxlcMUM
         v4UDWI+XmMAtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0506FC4166E;
        Sat,  3 Sep 2022 20:29:11 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.0-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220903142823.3436925-1-chenhuacai@loongson.cn>
References: <20220903142823.3436925-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20220903142823.3436925-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.0-2
X-PR-Tracked-Commit-Id: ac9284db6b7b4af150940186b633a233d4ca2bed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0c5f7ea81202e997f321d59bdd0c3f5c12ddea7
Message-Id: <166223695101.8828.14070900267849576734.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Sep 2022 20:29:11 +0000
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Sat,  3 Sep 2022 22:28:23 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0c5f7ea81202e997f321d59bdd0c3f5c12ddea7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
