Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5AC44CA2F
	for <lists+linux-arch@lfdr.de>; Wed, 10 Nov 2021 21:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhKJUMm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Nov 2021 15:12:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhKJUMl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Nov 2021 15:12:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 7E83361213;
        Wed, 10 Nov 2021 20:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636574993;
        bh=rZJhFt7lPLfV7meCUYPF3KS6yLx8PSoIJ8rOiVwQRa8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rlQzYoOnjw87AYmzJIQNy1tT/IW7zacwa90y/0YGeDQWj/triPN8NJs1BYvvngeiz
         YrPtCvOP2fw4COvmFj7rv14R4QzK0gmXiz61sH/amUf4PcJf0/hxMZczVqq8UJj6Kh
         VWMB4B/NP/XL9HdgHn+baRGKaXwOA8dQxS1wfZEV5pmNyqMGkI0Rc1XyF9I3LtEfkT
         wZXgZcqtot4ZEPWccBcPwYnuCAOOtLjkECFrW/SX09pH0COxL86d4Cb+RPwijc39jk
         zxzc0D9x60HuKaDuSzZVjZsR6vietKZEQpkSDJxFoUVlXjCpkRPnTnO3tePkWqWZCl
         bHy2FaIbOAkvA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 78A2C6008E;
        Wed, 10 Nov 2021 20:09:53 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic: asm/syscall.h cleanup
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a0G2BoQ5fa29SASLcYbY9Znwq9wCp4vXbcsZCX+Tios4w@mail.gmail.com>
References: <CAK8P3a0G2BoQ5fa29SASLcYbY9Znwq9wCp4vXbcsZCX+Tios4w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a0G2BoQ5fa29SASLcYbY9Znwq9wCp4vXbcsZCX+Tios4w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-5.16
X-PR-Tracked-Commit-Id: 7962c2eddbfe7cce879acb06f9b4f205789e57b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8f023caee6b03b796dea65ac379f895be9719ac
Message-Id: <163657499348.19350.339054321514681433.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Nov 2021 20:09:53 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Collingbourne <pcc@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Tue, 9 Nov 2021 23:50:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8f023caee6b03b796dea65ac379f895be9719ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
