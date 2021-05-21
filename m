Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC9C38CB18
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 18:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhEUQgI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 12:36:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230119AbhEUQgI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 12:36:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1F0E1611ED;
        Fri, 21 May 2021 16:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621614885;
        bh=g0LxsYZ/J31wMqmUI8BZvgjeI7GsPbprSFmVr1EPBag=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kljIal030JaJZusYc4ReQfydA1b1Tm9wgtKNe7Zs3E70wuFapkgUbTQXImluwA2ua
         wLRvh0fG05bPKe9PFL8s83OIxYtWEXu01tSG4QYtMKaYeULvOi/oMpzkrrrLdxhkLP
         8ZWycFXo8y/JcqQZuZiW4j8R/izdxTDxMoSdo4adgFKJKQ4nET8Kz8tzVhMWKAs715
         ZSwnKBnDP+zSR3dzk6PeVrU5ELG3m/Q+xmNoErDB48STdXXRJNb/NXN9mBSesqeIUI
         Ii2JJwfstHr77tDwmmljn6pxHrrZT6MFDPhtju6TS+y6sD4oG3EylZWLcQ3HWqO3zo
         inyC+uqriKu0A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0D6436096D;
        Fri, 21 May 2021 16:34:45 +0000 (UTC)
Subject: Re: [GIT PULL] siginfo: ABI fixes for v5.13-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <m1cztkyvx2.fsf_-_@fess.ebiederm.org>
References: <YIpkvGrBFGlB5vNj@elver.google.com>
        <m11rat9f85.fsf@fess.ebiederm.org>
        <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
        <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
        <m1zgxfs7zq.fsf_-_@fess.ebiederm.org>
        <m1r1irpc5v.fsf@fess.ebiederm.org>
        <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
        <m1czuapjpx.fsf@fess.ebiederm.org>
        <CANpmjNNyifBNdpejc6ofT6+n6FtUw-Cap_z9Z9YCevd7Wf3JYQ@mail.gmail.com>
        <m14kfjh8et.fsf_-_@fess.ebiederm.org>
        <m1tuni8ano.fsf_-_@fess.ebiederm.org>
        <m1a6oxewym.fsf_-_@fess.ebiederm.org> <m1cztkyvx2.fsf_-_@fess.ebiederm.org>
X-PR-Tracked-List-Id: <sparclinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <m1cztkyvx2.fsf_-_@fess.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-v5.13-rc3
X-PR-Tracked-Commit-Id: 922e3013046b79b444c87eda5baf43afae1326a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0e31f3a38e77612ed8967aaad28db6d3ee674b5
Message-Id: <162161488499.28405.110780038136430578.pr-tracker-bot@kernel.org>
Date:   Fri, 21 May 2021 16:34:44 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Marco Elver <elver@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Fri, 21 May 2021 09:59:53 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-v5.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0e31f3a38e77612ed8967aaad28db6d3ee674b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
