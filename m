Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC90320CB1
	for <lists+linux-arch@lfdr.de>; Sun, 21 Feb 2021 19:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhBUSkR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Feb 2021 13:40:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230107AbhBUSkQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 21 Feb 2021 13:40:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 648E06148E;
        Sun, 21 Feb 2021 18:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613932776;
        bh=5GoWN4pGByWaKK+ZMToa01cR0SV78JG9i1Ai2sqmyII=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EG+OGadZvQFeksMrwXCsy5aIER5t956wyLhLL+tv8xlBXjfC9vbEFNsg/Jz3kT5dV
         LLiA3KSYZN5/ZWI9SCrkOPtHn5lyKIFiDDrhoysvGGHpxfzzBE3pWb4ZaQvYZWkHHB
         EkmST4mNVpsN9AEvi6IQia0ksr/Apoy336wY/8RKX8rYAaa9w6eE7KLwQx8RIrMtK4
         AHIiZ5ggMoVyXxiCezGny8yrn2eEhHNyVB5B37h/WpgWQNDjSuBlHKoCECIo+u0nPG
         fR9wiJzqIku1qO8zcr2I3eV72BCpM8WT6HTqQ7AOMPXy7SDaDrTvnChsgTqLv0F7aX
         jA1+Jel/XK/eg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 605A860967;
        Sun, 21 Feb 2021 18:39:36 +0000 (UTC)
Subject: Re: [git pull] saner ELF compat handling
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YCqpJZxNrb7+O8Ns@zeniv-ca.linux.org.uk>
References: <YCqpJZxNrb7+O8Ns@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <YCqpJZxNrb7+O8Ns@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.elf-compat
X-PR-Tracked-Commit-Id: e565d89e4aa07e3f20ac5e8757b1da24b5878e69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 591fd30eee47ed75d1296d619dd467414d0894e3
Message-Id: <161393277638.20435.1673939815325390026.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 18:39:36 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 17:02:29 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.elf-compat

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/591fd30eee47ed75d1296d619dd467414d0894e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
