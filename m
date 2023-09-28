Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DB97B253B
	for <lists+linux-arch@lfdr.de>; Thu, 28 Sep 2023 20:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjI1S2C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Sep 2023 14:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjI1S2C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Sep 2023 14:28:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01854BF;
        Thu, 28 Sep 2023 11:27:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9301EC433C8;
        Thu, 28 Sep 2023 18:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695925679;
        bh=03pNwnsCu9bvSuYC2KV0dtSHOC68MXCTopKVfQi2CxY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HXf5v7gQmNzS6tpxaxCtDguAE6WwDJCRVRsa/8zbYbwqQO6zf9UVvmqeRzPAmI4ky
         m5kcj7BQqfFaOfMTj60A3pnSgEYTorVtkTLl4uAMf8PHqOTGbkDUeyARU98//uKOrX
         CYL0143gSq4w7pkLDS+g1McwaDN/ZtBNHEHZg4TK0jRPUc6e0PdFa2aWjQhBGiES5Y
         a3DZ+CqBUW4RUdLvlzZA5kneG0PBigG1XPBNxoSDf1F60zSGs3qhtBvep+KlUcUI0W
         Xrhjr7jaaYoiKPsjR885FL/RUO5rMSO3JBXSDuS81KG09aDklBdIYz6MGFac2C7LyP
         RFbpquITeJHcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F2A1C395E0;
        Thu, 28 Sep 2023 18:27:59 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230928152535.2617047-1-chenhuacai@loongson.cn>
References: <20230928152535.2617047-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230928152535.2617047-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.6-2
X-PR-Tracked-Commit-Id: b1dc55a3d6a86cc2c1ae664ad7280bff4c0fc28f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d959343ae487157a2ef2993794e1359a82a5b15
Message-Id: <169592567951.30580.5452438448631717449.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Sep 2023 18:27:59 +0000
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Thu, 28 Sep 2023 23:25:35 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d959343ae487157a2ef2993794e1359a82a5b15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
