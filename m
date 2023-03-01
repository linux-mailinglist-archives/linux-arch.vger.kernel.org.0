Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B1F6A727B
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 19:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCASCN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 13:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjCASCM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 13:02:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBFB4A1C8;
        Wed,  1 Mar 2023 10:02:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E5E16144D;
        Wed,  1 Mar 2023 18:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6B98C433EF;
        Wed,  1 Mar 2023 18:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677693730;
        bh=6CJRBHA277V3kLrkBNymTFw9TO8pK4D3YmzpDMXy4Qo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j8sbljADDFepkxaA+KIzQPYHvZclL16XU+dwL3+mGHiGqh+AwlwidRn5Pg7bSDCDD
         BPpDaLjSGRp+uzghhRV/oHUpBno1n+g2Os6dBrjWWSraYs/sK88Unmg500drqYpDnt
         qPaWex+MptKfAD5gOro1MgYXIam1TBSA0uVXK/RPIb3/SmnziyJd2xqbikHYabuDwh
         valJM01ZkYGlZy6tMrdOohdYbxoTgMnKtqM17k5q8zGFnErGJM0aPWyiDD3BEA4tVt
         s0WnFP+5Vvrvgol8XptBgokzCvcp8jJHOJI7ai6H11gWLZ1rrsaWY/Kx+r/UrWuV0h
         jvml02GwP87Kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C510FC395EC;
        Wed,  1 Mar 2023 18:02:10 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230301065808.2259768-1-chenhuacai@loongson.cn>
References: <20230301065808.2259768-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230301065808.2259768-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.3
X-PR-Tracked-Commit-Id: 8883bf83127d533abb415b204eabc064863ae6c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8356cdb5bd5abc74f814d76bd37900997fad35d
Message-Id: <167769373080.10213.15096531799564836346.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Mar 2023 18:02:10 +0000
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

The pull request you sent on Wed,  1 Mar 2023 14:58:08 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8356cdb5bd5abc74f814d76bd37900997fad35d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
