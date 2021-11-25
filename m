Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33C345E0A5
	for <lists+linux-arch@lfdr.de>; Thu, 25 Nov 2021 19:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242568AbhKYStP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Nov 2021 13:49:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242665AbhKYSrN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Nov 2021 13:47:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4C8C0610CA;
        Thu, 25 Nov 2021 18:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637865842;
        bh=RMyMRjbvG2n75tpdHny3DubP33sskUbHGgBU5+Ru884=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HfTJoDxOqf+ctIlgxvzvdeI2+IjzS303cDz5Yu1Afzds6eWrwpTo0xJmfIWxgggA7
         hvetwER2A0wQkfd6CuQQAPt08vT4ZRnc5P6Bf+veFHNrB0v+E7wckPuTNNTmnJwBMq
         hzCf39lVBH85EGw0b4KWVoBxejPklByTlrpywmuOKmKyh+x+DLU4AG5X7LItyZM/gR
         m4AAoOzBclXkDpivXn+IK5Dotikbu4NpInjpppJSYg8yaFfg2PyzA/mBB9JyLQRixd
         aqNXISJX8NdZ50dfg3HMGMZEBYVOeVO9UZvCDbu9nt8gUUmer7EagPrPRMSv3ICAIY
         QgQTmcQGEvQPA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 46DAB609D5;
        Thu, 25 Nov 2021 18:44:02 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic: syscall table updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a1JPS=3Zz3H9ptaAnqonnPUo546BP0rAAWT5KOcZEj55g@mail.gmail.com>
References: <CAK8P3a1JPS=3Zz3H9ptaAnqonnPUo546BP0rAAWT5KOcZEj55g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a1JPS=3Zz3H9ptaAnqonnPUo546BP0rAAWT5KOcZEj55g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-5.16-2
X-PR-Tracked-Commit-Id: a0eb2da92b715d0c97b96b09979689ea09faefe6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b501b85957deb17f1fe0a861fee820255519d526
Message-Id: <163786584228.16379.1846651949947500762.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Nov 2021 18:44:02 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Thu, 25 Nov 2021 16:48:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-5.16-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b501b85957deb17f1fe0a861fee820255519d526

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
