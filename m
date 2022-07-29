Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FC558550B
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jul 2022 20:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbiG2Sfy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jul 2022 14:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238489AbiG2Sfx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jul 2022 14:35:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA5265678;
        Fri, 29 Jul 2022 11:35:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C90D1B8291B;
        Fri, 29 Jul 2022 18:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92229C433D6;
        Fri, 29 Jul 2022 18:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659119749;
        bh=7F1PDpeRGQFgkhTwqADv6QxlfNJDub32cinES52/dgI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rNl8uTr+MXxtlXM8als0SsguzzPHzzih6UrPP54gcclbwA+wJ2g67BR4Ll4JbpTfo
         s6REJeycwqBmVGTDBRuRSBaNFi4qHjF6xg2FOB1sHqEwlfDZ6KJYTwcp2GQlsbBp1z
         aewkcO9UauBGgw0gi9xzXHwC3JNm+Mnt41RfwrT14fs+LmudErQ6kDHr2BGTdFfQqM
         WJV8x/YKmw8uElbVTaJTzHNp6O4m5xgfFZSVEisziysgTk0+MQfDY7x4dzzzfhWIW9
         lfiSXKPTM4PlVxElwYUFaD33UOmhbp1Uq5RKc6ULaGGzCTqN+eL8t2COjHWQvn0Eyz
         4mWtwP/NYDt9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7EA58C43142;
        Fri, 29 Jul 2022 18:35:49 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v5.19-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220729144205.3412161-1-chenhuacai@loongson.cn>
References: <20220729144205.3412161-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220729144205.3412161-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-5.19-5
X-PR-Tracked-Commit-Id: 45b53c9051770c0d9145083a328548745ee2e75b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a95eb1d086dcc579d52ca4c34742516f6434d1f2
Message-Id: <165911974951.994.1693047203751898890.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Jul 2022 18:35:49 +0000
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Fri, 29 Jul 2022 22:42:05 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-5.19-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a95eb1d086dcc579d52ca4c34742516f6434d1f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
