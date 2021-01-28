Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50181307DE0
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jan 2021 19:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhA1SZz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Jan 2021 13:25:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231862AbhA1SUT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 28 Jan 2021 13:20:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id CA90B64E28;
        Thu, 28 Jan 2021 18:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611857815;
        bh=EdUwL/QDhFhONKjS8Ixd/ah7+ex2+S6R0CxzmeI3nis=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RqLZT9MSQ5F9QJHn3EGf0dwq8hOxg5YF/NyPJ9pjd8HhPLK6JKeU0WZ8iyGoUDZ7v
         wDRnaBe38PTGY3TWGO58QCqwNiJpIboD4bNCKeLE44gnxtN7tjFoTYppELZXSp3Fz6
         FJiY6yw32xgEl/3Tqerz3p/pNhwn76xTyaMzQqX8KnnsIxibBtx0o71djWzHRPMA64
         No0PdCCAKwe22aZ5L6NWbf4+DeJuhhB1Xy2I7hIazyPamtE3w3jOM7B/uXQQur1dLe
         F9ItytYZheqLvM0NK6ks88iZo1vYAH7671S194PVl5FRSAOmsp1nxkHn3o8TwxiqZF
         KqP9V8JBUUsmg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C32E965307;
        Thu, 28 Jan 2021 18:16:55 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic/ia64 fixes, mark as orphaned
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a2+tvr6O7LxF8M6sJ-e-NmbijAmXt13FPEvOXtY_PSgPQ@mail.gmail.com>
References: <CAK8P3a2+tvr6O7LxF8M6sJ-e-NmbijAmXt13FPEvOXtY_PSgPQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a2+tvr6O7LxF8M6sJ-e-NmbijAmXt13FPEvOXtY_PSgPQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-v5.11
X-PR-Tracked-Commit-Id: 96ec72a3425d1515b69b7f9dc34a4a6ce5862a37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 228345bf98cd78f91d007478a51f9a471489e44a
Message-Id: <161185781579.19532.14632163617295027701.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Jan 2021 18:16:55 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-arch <linux-arch@vger.kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Thu, 28 Jan 2021 16:35:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/228345bf98cd78f91d007478a51f9a471489e44a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
