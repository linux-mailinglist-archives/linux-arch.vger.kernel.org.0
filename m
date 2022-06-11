Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F89547759
	for <lists+linux-arch@lfdr.de>; Sat, 11 Jun 2022 21:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiFKTli (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Jun 2022 15:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiFKTli (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Jun 2022 15:41:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1994707D;
        Sat, 11 Jun 2022 12:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3ABF7B80B36;
        Sat, 11 Jun 2022 19:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED202C3411F;
        Sat, 11 Jun 2022 19:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654976495;
        bh=CYTk1cVGHJo8vEuDKx78gbrU9zxUXMZ9qWdlYssoeOA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XBq9omBsiXRkXs7eRsP0GKzGcGoOawc+1uv78G6tf0A7snpB2vIZDVYYsnq1F8vQm
         +gQWAbLnrBVgLa/hqIFjMiwLmq+k4MLPrPHBSPPREz/nyOE7R/G+nZCwEsTRlE7Yyt
         ItA2l2T/jIj5RwM3mTJU04RUNz+GeFexrgrJwbmxFhAPL8z47dW+Fl4tZ53X2YtiDm
         3XZqWmAjKtFZEwcR1Uwh5kY2v5s02FiE7Yw5PEzkPxH+AusDVYriBqXh0WRJa5nrBT
         rPwuY0wvG0l0srPe03NBOXO3QXpxvmY2ovFcK6GChgcvkJ1oWNZM7iFBY3OeGYLkVl
         ODMuXBMRB1y9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7680E737F0;
        Sat, 11 Jun 2022 19:41:34 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v5.19-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220611101714.2623823-1-chenhuacai@loongson.cn>
References: <20220611101714.2623823-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220611101714.2623823-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-5.19-1
X-PR-Tracked-Commit-Id: 5c95fe8b02011c3b69173e0d86aff6d4c2798601
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0678afa6055d14799c1dc1eee47c8025eba56cab
Message-Id: <165497649487.5229.5344689535046075507.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jun 2022 19:41:34 +0000
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Sat, 11 Jun 2022 18:17:14 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-5.19-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0678afa6055d14799c1dc1eee47c8025eba56cab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
