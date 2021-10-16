Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0224303AA
	for <lists+linux-arch@lfdr.de>; Sat, 16 Oct 2021 18:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240704AbhJPQZa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 16 Oct 2021 12:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240694AbhJPQZ3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 16 Oct 2021 12:25:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 583F2610D1;
        Sat, 16 Oct 2021 16:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634401401;
        bh=yRtHn1w9re0Zp9x/HnI3ySgmCs4w8DDs0ogGgg+lhGg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O44rlF/X/Re9dNYuBQ/BewazF2+442d0yMq4GmhAMMgVgdqw7p8aXe5+WWhV3nqVJ
         4Acv5lPaiUQBnKgwFfrCj1rFsC3kW/yDupi6+zjSx1+lYESnKyj/qSYv1MFXkTs/va
         oHxILBYTHT0KumyrqP868k9rrX8PjAdE8TTKl15BEw2B9R7pnyNnMhvSjmCuWCxCMG
         mGws7ioOCxhBkyB4AkGHWY2ZAR2bfGOxkrCuGye795Qivu+eXEeZ5fqmkrr8MxkIwH
         85S/OHozeoknvW+OhIXHaImnPEG52DK1egiB0ZJ8KNib2pr0sPo9eLTVtvg5yzxvCb
         AvyfzesvK4V8Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4CDA860A47;
        Sat, 16 Oct 2021 16:23:21 +0000 (UTC)
Subject: Re: [GIT PULL] csky fixes for v5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211016010635.2860644-1-guoren@kernel.org>
References: <20211016010635.2860644-1-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211016010635.2860644-1-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.15-rc6
X-PR-Tracked-Commit-Id: e21e52ad1e0126e2a5e2013084ac3f47cf1e887a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c13f946bf1ef0eef49748b1824a0bdfb3487fe8c
Message-Id: <163440140130.26929.4641296646306632379.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Oct 2021 16:23:21 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Sat, 16 Oct 2021 09:06:35 +0800:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.15-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c13f946bf1ef0eef49748b1824a0bdfb3487fe8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
