Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0879F2C6DF0
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 01:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgK0Xad (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Nov 2020 18:30:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728790AbgK0X3x (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Nov 2020 18:29:53 -0500
Subject: Re: [GIT PULL] asm-generic: add correct MAX_POSSIBLE_PHYSMEM_BITS setting
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606519792;
        bh=Pm8QM5uOxr7zFCVrEdjYCdNWAyDxH5FBVu2CRm3k3Wc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hslpCcWGZWw+wy/omyWQKmSPaOgWgZ1yqLAHNPM87Oki5SbBwQUA48fW7n+zxsPrK
         6KCcD1jtrlh6+7LcQUwQ2ERb5/rn4+e+GX+/agaOF7KZfEL9EP4lwnAFM7KIs/iPk/
         H8bE2uCyvrG/k19p154JQkFkbqlws2GLHRdAM/h0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a3eLXunBbxa=i4Z-tXnPwAt==xTg1_hs4TZq7w1LH2dng@mail.gmail.com>
References: <CAK8P3a3eLXunBbxa=i4Z-tXnPwAt==xTg1_hs4TZq7w1LH2dng@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a3eLXunBbxa=i4Z-tXnPwAt==xTg1_hs4TZq7w1LH2dng@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-5.10-2
X-PR-Tracked-Commit-Id: cef397038167ac15d085914493d6c86385773709
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c84e1efae022071a4fcf9f1899bf71777c49943a
Message-Id: <160651979281.32137.14163803965999226530.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Nov 2020 23:29:52 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stefan Agner <stefan@agner.ch>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Fri, 27 Nov 2020 21:55:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-5.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c84e1efae022071a4fcf9f1899bf71777c49943a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
