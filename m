Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFEB7680AE
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jul 2023 19:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjG2REi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Jul 2023 13:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjG2REg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Jul 2023 13:04:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D03129;
        Sat, 29 Jul 2023 10:04:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAC6F60917;
        Sat, 29 Jul 2023 17:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AB47C433C8;
        Sat, 29 Jul 2023 17:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690650275;
        bh=a8AgcCcRD45MqMrA0ShR610p4UCbpkmD952pgL1ofb4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZnpQ/avbGW7zt73h82czRQr4dD3GubVhffSqbE2zpw4AaI+2ZQ0ID4IfFwv0vrbl5
         uVmwZrAc3zblP42KXpmrucLy7UomCyd83rZ67OnyM4DtS4+TlRLs7VPEOqvdPY7bqt
         sMQQfgznw4zM9eH9QMdB428QQwbuNdHsCmZNURfiWCFIXUOy9A0LSE6Z3CR/zz2efk
         j0POBEIq4j30FV0LZmUBkrf0BAQZxoPNXJyC7SionjHbMsVwuygqek0lvnAjAOLQob
         QrvBGhMkvVrj1bYEsrJDhxwmwC/kMvIxHZPPcDmglr6ajdSHRqEhNFTHlQAwPjr4px
         /7o4nZzEknjvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 445DBC43169;
        Sat, 29 Jul 2023 17:04:35 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230729031648.539276-1-chenhuacai@loongson.cn>
References: <20230729031648.539276-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20230729031648.539276-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.5-1
X-PR-Tracked-Commit-Id: 1e74ae32805b6630c78bd7fb746fbfe936fb8f86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12214540ad87ce824a8a791a3f063e6121ec5b66
Message-Id: <169065027526.12635.13494935973363519311.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jul 2023 17:04:35 +0000
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

The pull request you sent on Sat, 29 Jul 2023 11:16:48 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.5-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12214540ad87ce824a8a791a3f063e6121ec5b66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
