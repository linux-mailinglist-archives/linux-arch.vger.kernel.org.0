Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE2656A9E7
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jul 2022 19:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbiGGRoi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jul 2022 13:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbiGGRof (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jul 2022 13:44:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA2259262;
        Thu,  7 Jul 2022 10:44:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CFD2B822B1;
        Thu,  7 Jul 2022 17:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7073C385A5;
        Thu,  7 Jul 2022 17:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657215872;
        bh=U1VCIrQewkNZAM2m8EDq2BrG/uIYuRmlgn+CNmOPKlM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MVbnbtoiF1B3iIwdJ5l+vPtZVBAvKd9D7jlUH3gfGt5DCYtsQIT6sjG9oFQe8BLKt
         q3GDFmSQirVd4el2lPaVI9cbU9lPO9kcXPZCZ7SOVE5pNYD0PyQNrRXIS2It2V3hNE
         zH9Nrx4Vw0jnf3pwipgaas3qKk8ztMrOMAnS4gC8h0bmi2Cw24vReZ8OScZ/GOODfr
         glW51NynbgSMHkN6YL/R6QQs6WvQJHkSYAWmdN7VU1Bqvgk0hxjedy+aEYOSpKpfKY
         i4TXnEXaKVx7nK6jiQljp+uFPmvrq6dBdhCazX8KfypyJtZH+ff3vbDLfUSR5YJbik
         r1S4309M8UcbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90A4FE45BDD;
        Thu,  7 Jul 2022 17:44:32 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v5.19-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220707130525.1434272-1-chenhuacai@loongson.cn>
References: <20220707130525.1434272-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20220707130525.1434272-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-5.19-4
X-PR-Tracked-Commit-Id: f0fbe652e8529a180630617a17cd5922298c4f13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8a4e1c1bb697b1d9fc48f0e56dc0f50bc024bee
Message-Id: <165721587258.16533.14034112280835206934.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Jul 2022 17:44:32 +0000
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Thu,  7 Jul 2022 21:05:25 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-5.19-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8a4e1c1bb697b1d9fc48f0e56dc0f50bc024bee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
