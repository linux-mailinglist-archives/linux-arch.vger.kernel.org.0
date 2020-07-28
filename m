Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD94231220
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 21:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgG1TFF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jul 2020 15:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732560AbgG1TFE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Jul 2020 15:05:04 -0400
Subject: Re: [GIT PULL] asm-generic: bugfix for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595963104;
        bh=LP6Qb0A61uzYXr6Q2hb2V7M5hj5KyXAYZXySSlYHyqg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xB7AzsVuvC6MIy2zcDrIfGtdqjV7a03J2CDDYRhkA8YxRk6zjoeT4MFBYBkUBJPWp
         x1WNIBwbN0+IlNvH52FFPrRNjf13GiuXobLBjvvU2XL5fCM77jHiptQ2/e4CaT2ZaI
         LyXHKWIZPBb4aHGcQzGZ56hbnfxeJxOAt7qyB68A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a2Qy0OOcXOO4twf3OKZ66ESTNT60nOR9i-ixcPubeUuVA@mail.gmail.com>
References: <CAK8P3a2Qy0OOcXOO4twf3OKZ66ESTNT60nOR9i-ixcPubeUuVA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a2Qy0OOcXOO4twf3OKZ66ESTNT60nOR9i-ixcPubeUuVA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
 tags/asm-generic-fixes-5.8
X-PR-Tracked-Commit-Id: 214ba3584b2e2c57536fa8aed52521ac59c5b448
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ba1b005ffc388c2aeaddae20da29e4810dea298
Message-Id: <159596310436.13897.18305348006120712821.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jul 2020 19:05:04 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        John Garry <john.garry@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Tue, 28 Jul 2020 14:42:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ba1b005ffc388c2aeaddae20da29e4810dea298

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
