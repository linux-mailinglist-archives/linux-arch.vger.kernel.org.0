Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93337732625
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jun 2023 06:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242794AbjFPEQv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Jun 2023 00:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242731AbjFPEQr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jun 2023 00:16:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB152945;
        Thu, 15 Jun 2023 21:16:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4C5B61B75;
        Fri, 16 Jun 2023 04:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 208C8C433C0;
        Fri, 16 Jun 2023 04:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686889005;
        bh=yLWxc3xMe5p1sSJEtqjnvtcWn40iQCwZMSOVlK2T3o8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XkAr3W+Gf3b52rS2mYV5HbHdF69/avxgHFYgmx1H62ef2MJ5OGqwEB1jQ7wYrLeOG
         enw4gfgy0bLg5FQ53UIy0DRxJBzg5kkc5d5edNLHCPw1STzxdEAiMMnscL5x93pwqh
         ocfsWXaNEag56PktYMyEVrGl6Mos0kM7EM3dxqRd6jHcMykUoHSy8EOEU9VHmobymP
         /foxg+547MSrtOlcemG+fyq1YJp/o+R6PaMYtydPUCUUVhERox9814xqej9egSTG4v
         1MnN3wXgXyxm+1uKd1IA314V/C3Ob624qycBXazKMu62LG13YgFlk8y3xWt1PtrGNY
         78cRzv7dUaR8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DCA7C00446;
        Fri, 16 Jun 2023 04:16:45 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.4-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230615122311.3754870-1-chenhuacai@loongson.cn>
References: <20230615122311.3754870-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230615122311.3754870-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.4-1
X-PR-Tracked-Commit-Id: 41efbb682de1231c3f6361039f46ad149e3ff5b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 627d858674f54f585b5dc82529f629fb8d0f85b4
Message-Id: <168688900505.32380.4601668679010613893.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jun 2023 04:16:45 +0000
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

The pull request you sent on Thu, 15 Jun 2023 20:23:11 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/627d858674f54f585b5dc82529f629fb8d0f85b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
