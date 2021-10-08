Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D68427236
	for <lists+linux-arch@lfdr.de>; Fri,  8 Oct 2021 22:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242416AbhJHU2R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 16:28:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231997AbhJHU2R (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Oct 2021 16:28:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8535261100;
        Fri,  8 Oct 2021 20:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633724781;
        bh=j7rM4Iw6mJuF4E2cZfVRGjPVl3DiZBsLq7c65mgIOJA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JOOmRKUyNyCP+BAnonPY0qGWIO/IqNnXLpqRe35CybkikaLOfW9u1xFuz2kEd16QU
         qAjhpHGtOMI3yy2nd2iuE13DNyJMEToDHFDfgWjeijJOSC6hNSt2fZEsBFuJpk6ird
         0HMdbW6dJJcolRZtdGA2PNaFg1pf9j604iTESb0P19ReGZqp2I/BhnsDrU6++HpQLS
         DzDdO8RCR5sn4L2eOcw/WZW2uTTiR+3Df0pFa1T3bSvppfffVqwnkV9bilapWRz3iE
         YJ3EA2J/dbh30XDEGXBLxH0lp80YhagyW/PIw2ONFV7d9OfwKyjfYLxFRMq/PGDkyZ
         m6ZXWa2pek1ZA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7E89A609EF;
        Fri,  8 Oct 2021 20:26:21 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic: build fixes for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a0WCfiZ=WeezCCATSoxGmaDtL=pAWKzRu3wuLaT9qs6gA@mail.gmail.com>
References: <CAK8P3a0WCfiZ=WeezCCATSoxGmaDtL=pAWKzRu3wuLaT9qs6gA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a0WCfiZ=WeezCCATSoxGmaDtL=pAWKzRu3wuLaT9qs6gA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-5.15
X-PR-Tracked-Commit-Id: 2fbc349911e45d4ea5187b608c8d58db66496260
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0dcf60d0014001a2dcae61169c8f72b775c2e48a
Message-Id: <163372478151.4543.2031563575464198419.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Oct 2021 20:26:21 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Fri, 8 Oct 2021 16:36:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0dcf60d0014001a2dcae61169c8f72b775c2e48a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
