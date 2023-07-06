Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DFD74A314
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jul 2023 19:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjGFR3B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jul 2023 13:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjGFR2x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2023 13:28:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0071BE8;
        Thu,  6 Jul 2023 10:28:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D109161035;
        Thu,  6 Jul 2023 17:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D602C433C8;
        Thu,  6 Jul 2023 17:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688664530;
        bh=1QdtHxuKAWPYJL+T/tzAL9imbe1UGGHSJopddDxBzMM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uriLib9SZFns83r8K+C9mTZTBBOVwAUkRXs4kRFf0NNQfQLUmZTEL8STCyhPqy4O2
         YvhmGiXgGQypy2sG+AbkWQLBdCBIdK5OmCZhTMjhlIoxkxpXr9aZtVd6ZltKA0sRps
         1iNm2GoVHMcATnvNUAeAF8J/rZRHvFM9Ciaq9Ufwij4Hwpbag9C6QN0ceTMwAymHpW
         aR8uLcwwD93v6lCHWgu4Dl2CcPYYSYCVobms8TDxsITtmtq1FYdpzcBNvYqjVucj4l
         OckReAFpv3HN4tBcKCkGNZ0zLMMBiWgKUSVb4JKFvYsS6RRKCdgoF9Z0YmL4f7yvUq
         Ohjhh1gQ+iBxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A0CCE53801;
        Thu,  6 Jul 2023 17:28:50 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic updates for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9a23db59-1f53-4a24-87d7-a59293972a29@app.fastmail.com>
References: <9a23db59-1f53-4a24-87d7-a59293972a29@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <9a23db59-1f53-4a24-87d7-a59293972a29@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.5
X-PR-Tracked-Commit-Id: 4dd595c34c4bb22c16a76206a18c13e4e194335d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b82e90411826deee07c180ec35f64d31051d154
Message-Id: <168866453016.8259.14910935277253336289.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Jul 2023 17:28:50 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Thu, 06 Jul 2023 10:20:39 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b82e90411826deee07c180ec35f64d31051d154

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
