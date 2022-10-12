Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A653A5FCA1F
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 19:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJLR6Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 13:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJLR6O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 13:58:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE9ED7E3D;
        Wed, 12 Oct 2022 10:58:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4560B81BA0;
        Wed, 12 Oct 2022 17:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81243C433D6;
        Wed, 12 Oct 2022 17:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665597488;
        bh=SwKpCBahfSJnN0XUzb13FyH0Ae6UKHlly7aHXxqQhnQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WNj1PvK3tV3zlCAooCwY4DeLoDk9R8X58g2NTxoXpQ1bTPrp1oKph08qu2KgDCwe5
         S/FmV12GvOhlr5x5wOkDDs6JUDWCEaP94GCtZT3qaD7IihduyKmvoTPVkgS80msMpu
         ahCUF3bIDYIgoPbWY9zVp2LIJ0xGk/sTQ9ZyVc/JUebIt/jF5DlTyQJjsnnUSW3fh7
         L3uIJ0jPJR9L8M9UU0Uny6IxuddC+k0v/nYGfP00rriTYWZ+QFnQe3hapVdtmQHggx
         /+ea9XvwfDVFp7Fb1ynj5SjaCVs67s+LSK2gAwQwtSHXRurj2EELXuzLlXs86AmQLR
         pm170qtv+Pf+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F2D5E29F35;
        Wed, 12 Oct 2022 17:58:08 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch changes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221012144846.2963749-1-chenhuacai@loongson.cn>
References: <20221012144846.2963749-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20221012144846.2963749-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.1
X-PR-Tracked-Commit-Id: 2c8577f5e455b149f3ecb24e9a9f48f372a5d71a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95b8b5953a315081eadbadf49200e57d7e05aae7
Message-Id: <166559748844.25532.2588994164402935329.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Oct 2022 17:58:08 +0000
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

The pull request you sent on Wed, 12 Oct 2022 22:48:46 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95b8b5953a315081eadbadf49200e57d7e05aae7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
