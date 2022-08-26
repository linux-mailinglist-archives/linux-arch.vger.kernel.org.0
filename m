Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C923E5A2FB2
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 21:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345193AbiHZTJ2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 15:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345172AbiHZTJ0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 15:09:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A2BDD4F4;
        Fri, 26 Aug 2022 12:09:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6C6E61E61;
        Fri, 26 Aug 2022 19:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14AFFC433D6;
        Fri, 26 Aug 2022 19:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661540965;
        bh=rSRkJR8vUcVOHBkUuZj2hk/lqrI/ViP1vA36D61q4bQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nzEKHal1i+p7Kyz0uI09W7qqzI6awKmPhR/fCjvFvZGY/akTq/GCsluW0xci23eFp
         bPUzqspnSSO9oCVfn1u/Rf/4QoLmPtF3dKCqu2MK25xYdf1ZDrwq+zfredAZzUNxnK
         XCl9DrZbJkREKNF1QC9pklqLD9fPXT+eAn3MXq5J4HUAFx+OJTnX35oxUAdkwr4XlR
         OL99DOzONgCEG3FQ91qgTjq3fSkg3dlEssVVFLE2U0knujjdUhCibS9gw73LG+hW2j
         GhYGZ1kOTfIU1pfK50lJTLx6hQvAP/zgNbeZiFkxXFb7d9eaxflX+S66DHnS1slEiD
         2yQikG5KFs8Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02A8BE2A03B;
        Fri, 26 Aug 2022 19:09:25 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220825131021.3671756-1-chenhuacai@loongson.cn>
References: <20220825131021.3671756-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220825131021.3671756-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.0-1
X-PR-Tracked-Commit-Id: b83699ea1e62951857c2d8648bd93a4744899eb7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c23f864dc7ef37655021c43beae98321436cbd9a
Message-Id: <166154096500.10698.14010956901883427856.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Aug 2022 19:09:25 +0000
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

The pull request you sent on Thu, 25 Aug 2022 21:10:21 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.0-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c23f864dc7ef37655021c43beae98321436cbd9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
