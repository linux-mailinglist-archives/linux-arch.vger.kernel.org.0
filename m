Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFCD3BA491
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jul 2021 22:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhGBUQN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jul 2021 16:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231157AbhGBUQM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Jul 2021 16:16:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 46C4961413;
        Fri,  2 Jul 2021 20:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625256820;
        bh=HUOZ+C2wIyg73qzEvZVd6hqiaAxDw34zAvWf1aRunpA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r09QVE0lPh+yu/QTnvUTIh/0JmANf+wMamx6Fl+IXoEfN1NgaKCyGEeun4kOlMYmT
         uhKnSc1cRPhDuKUMRd5Iez9Qwdv1XAXubnprTFjacNJC8U8VSRBaOyWVZko+z7U8ka
         QHZi/D6C+j8xh5eicPbdFeCskQUigNcYO9xxzTklAuAjcugC9NYJ/FUsqmL8RvRafQ
         DOH/1m/ByBONBB/qgYGNHzBAbgIW9Wj3M76Y7OHyZRehgKdDHtLT6nhe9VpiE1Va0R
         a6kwMLY25WMFBJ0ZhBVTFpbzVs/bqKJl88GJoPwV4LfNi/wQLvJuSMQ+kycJKabRRt
         JuwpkY7V8GyOA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3F288609E4;
        Fri,  2 Jul 2021 20:13:40 +0000 (UTC)
Subject: Re: [GIT PULL 2/2] asm-generic: Unify asm/unaligned.h around struct helper
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a3Y1FHaS0yRAeBYmq0Z-yXtvHBRRiO1tNHKf-TaWVrFzQ@mail.gmail.com>
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com> <CAK8P3a3Y1FHaS0yRAeBYmq0Z-yXtvHBRRiO1tNHKf-TaWVrFzQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a3Y1FHaS0yRAeBYmq0Z-yXtvHBRRiO1tNHKf-TaWVrFzQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-unaligned-5.14
X-PR-Tracked-Commit-Id: 803f4e1eab7a8938ba3a3c30dd4eb5e9eeef5e63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4cad67197989c81417810b89f09a3549b75a2441
Message-Id: <162525682025.6172.3953171867366042769.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jul 2021 20:13:40 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Fri, 2 Jul 2021 15:49:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-unaligned-5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4cad67197989c81417810b89f09a3549b75a2441

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
