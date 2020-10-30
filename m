Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5232A0F7E
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 21:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgJ3Ua7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 16:30:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbgJ3U3x (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Oct 2020 16:29:53 -0400
Subject: Re: [GIT PULL] asm-generic: bugfix for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604089793;
        bh=Jy8kjdkuXflD0v68wbWxJZm1LR3w/6MVT94H43JwDKo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eZIulvIcaX0ZWVlAwGxxUfoN+aa0lamvXtQN4xGNuCqGhBPOKVzhKYJ/QQdsPyIpx
         uUfUGN3fMjsjtwDq3Llnwqxyj3K21Whv1PlhPbSzWHPXtmS+jQ9R3Onhqy+nmJYZrV
         IRVwp0q6Zhidx1AjMfiLT5rHFUa6RGQkevUGJ6yk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a37eA8s68pkHcmR_wtvPaDBouqRF7S2T+t3=YUh9HuCOg@mail.gmail.com>
References: <CAK8P3a37eA8s68pkHcmR_wtvPaDBouqRF7S2T+t3=YUh9HuCOg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <CAK8P3a37eA8s68pkHcmR_wtvPaDBouqRF7S2T+t3=YUh9HuCOg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-5.10
X-PR-Tracked-Commit-Id: 0bcd0a2be8c9ef39d84d167ff85359a49f7be175
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11ad2a73de10bbebb71199f29abdfc1c2e70d231
Message-Id: <160408979308.26569.13334300238219377572.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Oct 2020 20:29:53 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Fri, 30 Oct 2020 17:29:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11ad2a73de10bbebb71199f29abdfc1c2e70d231

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
