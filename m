Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B1A744129
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jun 2023 19:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjF3RZV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jun 2023 13:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjF3RYn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jun 2023 13:24:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0EE1BCA;
        Fri, 30 Jun 2023 10:24:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95002617CF;
        Fri, 30 Jun 2023 17:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0948CC433C0;
        Fri, 30 Jun 2023 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688145845;
        bh=D663SZs7+77H1PI/uOLEkN8C97q8SMbZjrGtIskEKBk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hsxVN1MAOPc+T355FMxNJwiMjiS/OMSRAEcJJQdX/ydr2bhLZ58lHVjNc6hjl6hql
         3CupqN+KvKJ3QwGlZuwQFqfe0GbivnVO3SN3ZWDhcasKk/BpRBSkus9+bLhL6J3o0v
         LFiIqHFc7ncm5O9oBFbmFzUYfogSIqXUB/0PhlKBO0Ok18RUDVmCzcSue2wYt99mnd
         HQgBD1uJ4l1cKoJm2AsZPEOWIXzeg8s5VpH9FM58wx+WbFZgCU2fxNx09X9SmMtvuP
         uXFgh7Nn1gx/jfLfz7GGNI9/UwnYvo2DIl8puEB4ud6hWJIvcbKdX7tIC0epJKsZGG
         6qZ3540ApfXWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EBE5CC43158;
        Fri, 30 Jun 2023 17:24:04 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch changes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230630100037.1071320-1-chenhuacai@loongson.cn>
References: <20230630100037.1071320-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230630100037.1071320-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.5
X-PR-Tracked-Commit-Id: 5ee35c769663cb1c5f26e12cad84904dc3002de8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 112e7e21519422b6f2bb0fa8061f5685e9757170
Message-Id: <168814584495.9404.13332741026535742055.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jun 2023 17:24:04 +0000
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Fri, 30 Jun 2023 18:00:37 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/112e7e21519422b6f2bb0fa8061f5685e9757170

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
