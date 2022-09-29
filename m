Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677535EF93F
	for <lists+linux-arch@lfdr.de>; Thu, 29 Sep 2022 17:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbiI2Pk6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 11:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbiI2Pk3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 11:40:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D522637F81;
        Thu, 29 Sep 2022 08:38:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F9136124B;
        Thu, 29 Sep 2022 15:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC6CEC433C1;
        Thu, 29 Sep 2022 15:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465919;
        bh=acgyhNSys2is9NlFNTNVZ0K6XqURLdltY6ge9xvy5ao=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YY67izfAGqoU/bM6OQdwHjIM99T0Gno+/+KWo8U5pyVle2oeK3C0c1Z/52W6TCIMt
         3NX2sebH7SNAwMdIDAfVmZBaQqyMnu5WY7wU2vaj4K0j4CFkIoemRwbP1495Hc/G5M
         CRykoUFXcIFisyB5/veXjoRbZl14OKFZIyGOILXtwMyU0quy4CIYvfXmIuVcs5Gbdy
         q1mhHhBDjl1deN0oPo4tQf9RwrtsyCL7h+SnlEjffOS/2QAZsGxKyme44HaXwmiCbr
         0K5CSS4S4GNYU9kY8V9sp156aSA+spLnsuIvUDlytUzEKns2I8VYvIQdCZl3loIVUv
         dZ0IDDD4GwEyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99233C070C8;
        Thu, 29 Sep 2022 15:38:39 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.0-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220929024256.319721-1-chenhuacai@loongson.cn>
References: <20220929024256.319721-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220929024256.319721-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.0-3
X-PR-Tracked-Commit-Id: 4f196cb64b693c64f8f981432b1ff326b7ea1c28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81bcd4b522cf1dc312385b79b144153aff0cf0c6
Message-Id: <166446591962.14842.7614636797930881077.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Sep 2022 15:38:39 +0000
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Thu, 29 Sep 2022 10:42:56 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.0-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81bcd4b522cf1dc312385b79b144153aff0cf0c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
