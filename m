Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1870F64762E
	for <lists+linux-arch@lfdr.de>; Thu,  8 Dec 2022 20:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiLHT1E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 14:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiLHT0i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 14:26:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68795750B8;
        Thu,  8 Dec 2022 11:26:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 048EB62025;
        Thu,  8 Dec 2022 19:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61468C433EF;
        Thu,  8 Dec 2022 19:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670527597;
        bh=SHlfv/OZgrUjwfzihuHOXgOGAoYqPNCzLq+K9PJeh/M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p6pvzu6JNbsZClX3nb2V3NJpFiakPCv+7Wqo8i/EXto8NVRyV9Vb8+Y9BAgrCb6KV
         VxY4ISzlBKsbADfkWKStD56i06/klvubr4GFgri/wFIDL3hiM1ZjGzl7j5KfzwijLT
         0iWxiFopLhc7Rp+HXkTxgw56qpDtzPtgJrSz39dstwij2cMlMUgLaV2LCNQFefjhwg
         kgZmsVpuRyH+sNsKE2FMN9ZeYYtgUa2RQydt2xV/sfgHN5G5fOZfMeXt0Y/5MWLwH/
         ir5ZXFOhbxfio81mOqs8hC0Hg3yqAc9DmHyyLKWERqUI/Qt3BhjVoQTOeh1+3EiYS1
         Us3MI7ejWkCKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F4BDE1B4D8;
        Thu,  8 Dec 2022 19:26:37 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.1-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221208130007.336248-1-chenhuacai@loongson.cn>
References: <20221208130007.336248-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221208130007.336248-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.1-3
X-PR-Tracked-Commit-Id: 1385313d8bc112760559f06f64708d936b3f2d7c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f043b7662b6a9cfa981c02199ac939ed1c11372
Message-Id: <167052759732.15249.88213761977579177.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Dec 2022 19:26:37 +0000
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

The pull request you sent on Thu,  8 Dec 2022 21:00:07 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f043b7662b6a9cfa981c02199ac939ed1c11372

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
