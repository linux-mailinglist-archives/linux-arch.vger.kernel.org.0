Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDFD3FE5CC
	for <lists+linux-arch@lfdr.de>; Thu,  2 Sep 2021 02:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbhIAWpJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Sep 2021 18:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237109AbhIAWpI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 1 Sep 2021 18:45:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 89FEE610CC;
        Wed,  1 Sep 2021 22:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630536250;
        bh=5cTMzqnw9yf52gtqpbEJSVyU1/D0eiohoxnJNUEHjSM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O/HhtZLXhMOV6J4j2cIFbQtdubd9qDw4SUI22hMV8zZtQJXXfhBO0COZYiNNRFO2b
         xfbyNFSAi/4lf1QOX3keP4+feTUn7Vzk+znuneBm/XxVGlUJrQt5Vwle2KTgt7L7Qo
         5IdjY+Wfu++dJiSVzCZa/KB7M8ijsAd6sExKYVhq0erWNqBUAt2vurnvLrkgY73Qsm
         A0dgjQnL0cVQ3hTE2VQtIIwvYHYsoqi+mIwjmN9XtMCS+dQwJHPCtl0yunFXvwLLQP
         X9Ha919b1Htme8s0UQdPXrARDVELbjIgs/qn2Ed/jgWW7D1OaV/uAV/NpY6Xjwn4we
         QPA3I07kIASZw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 837B0600AB;
        Wed,  1 Sep 2021 22:44:10 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic changes for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a0cc_d-NTemhNJzeSHgAwLcc31JB1AF61VDUH7FCTVDRg@mail.gmail.com>
References: <CAK8P3a0cc_d-NTemhNJzeSHgAwLcc31JB1AF61VDUH7FCTVDRg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a0cc_d-NTemhNJzeSHgAwLcc31JB1AF61VDUH7FCTVDRg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-5.15
X-PR-Tracked-Commit-Id: 8f76f9c46952659dd925c21c3f62a0d05a3f3e71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4cdc4cc2ad35f92338497d53d3e8b7876cf2a51d
Message-Id: <163053625053.31944.1109644293922872894.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Sep 2021 22:44:10 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Wed, 1 Sep 2021 19:53:34 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4cdc4cc2ad35f92338497d53d3e8b7876cf2a51d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
