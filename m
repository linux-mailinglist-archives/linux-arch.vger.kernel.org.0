Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF25C612C3D
	for <lists+linux-arch@lfdr.de>; Sun, 30 Oct 2022 19:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJ3Seu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Oct 2022 14:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJ3Set (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 30 Oct 2022 14:34:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371E96167;
        Sun, 30 Oct 2022 11:34:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5BC960F24;
        Sun, 30 Oct 2022 18:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14375C433D6;
        Sun, 30 Oct 2022 18:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667154887;
        bh=cc71OaFw+A9BTCDPRol6dG3BLxYSQczj+DJjfznqgUs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oV8H0zEiuyTezp8HiXf5FVGKbTVtLgo6TiT80kWirz1AUrWptiITcOYOiGQAR0vq2
         2a3/3XrTLcrMCLG9uvofppSabTS+gTDsSyxFrMHnisawhel6uk6tNXormYR3tcGaJF
         WU7jUzHf0ntxyUohiVDQNiPqnVPQbRX219NS6WyHXrSA1QGFqRmdICOUDnzhVpo73E
         0zRZdHCA9YCN0+mFoomVa0CIROQjE9tycfMR1nQNvn3z8ZApI+adnJgOzd/LHa0ufj
         jrT2WTYAdX0KKuizP4vv4/20+pYOlRv6Kfs8123CACLmLNN8NfQaUWSr8zVSXkrt6h
         xQj4v76IkXhZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECF5DC4166D;
        Sun, 30 Oct 2022 18:34:46 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221030091658.1843946-1-chenhuacai@loongson.cn>
References: <20221030091658.1843946-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221030091658.1843946-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.1-1
X-PR-Tracked-Commit-Id: d81916910f7498fe7a768697e0101d488f9fe665
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c96bb958fb13fe2e0d16da86f6a21d9171a6db06
Message-Id: <166715488696.31922.779857326579249823.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Oct 2022 18:34:46 +0000
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Sun, 30 Oct 2022 17:16:58 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c96bb958fb13fe2e0d16da86f6a21d9171a6db06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
