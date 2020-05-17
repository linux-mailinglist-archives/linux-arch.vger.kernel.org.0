Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7381D65E6
	for <lists+linux-arch@lfdr.de>; Sun, 17 May 2020 06:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgEQEpD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 May 2020 00:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgEQEpD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 17 May 2020 00:45:03 -0400
Subject: Re: [GIT PULL] csky updates for v5.7-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589690703;
        bh=Ev3BarUwLefDnz0vLo0R1BSS7yEmRIKNLX0qV5bHoSc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sJbJdnddUwCfIIBtBqyKYHEXt9Dq9jq7EjQGPa+ZGzbX4+JDqCZLd1KcamkBbF4n7
         Sig6Mcl69buY2uo/WvTBUwePsJ113GeKhoVHJ8mdKWaAEMTezahate16apukvx2BZj
         OIOOKY/tCM3D8qAsxNjJeU6IV3xPNdvre/feOEvw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200516093336.13886-1-guoren@kernel.org>
References: <20200516093336.13886-1-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200516093336.13886-1-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git
 tags/csky-for-linus-5.7-rc6
X-PR-Tracked-Commit-Id: 51bb38cb78363fdad1f89e87357b7bc73e39ba88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26b089a7fc3301d8f53f99dd3607513d7700b505
Message-Id: <158969070298.26561.10106671482752667154.pr-tracker-bot@kernel.org>
Date:   Sun, 17 May 2020 04:45:02 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@kernel.org
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Sat, 16 May 2020 17:33:36 +0800:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26b089a7fc3301d8f53f99dd3607513d7700b505

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
