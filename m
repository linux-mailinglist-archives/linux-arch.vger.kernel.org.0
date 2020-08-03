Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622A923AFA0
	for <lists+linux-arch@lfdr.de>; Mon,  3 Aug 2020 23:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgHCVZF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Aug 2020 17:25:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729079AbgHCVZF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 3 Aug 2020 17:25:05 -0400
Subject: Re: [GIT PULL] arm64 and cross-arch updates for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596489904;
        bh=fAVyjeUgL3NSO49K5+SGMRNtb0Par096qpxi5HNRtII=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nM0kUN7+qdXcOMQPfuax33BlTmD4bTHfPj+0lYA9hIJU8/bIzwAcxr+YQUZGykSVf
         aDmKeSvXGnoym2+5w8Cz6y0mZ7zcDlM2mmHshRIyoooesuP7+szx/E4oHgn0jWQRHn
         msN+bAOosfvbYGyRcqFpX9vC+VmrnfY2kmvCjg7c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803185347.21925-1-catalin.marinas@arm.com>
References: <20200803185347.21925-1-catalin.marinas@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803185347.21925-1-catalin.marinas@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
X-PR-Tracked-Commit-Id: 0e4cd9f2654915be8d09a1bd1b405ce5426e64c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 145ff1ec090dce9beb5a9590b5dc288e7bb2e65d
Message-Id: <159648990477.7765.17056915504307617619.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Aug 2020 21:25:04 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Mon,  3 Aug 2020 19:53:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/145ff1ec090dce9beb5a9590b5dc288e7bb2e65d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
