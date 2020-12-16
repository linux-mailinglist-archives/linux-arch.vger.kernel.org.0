Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D05B2DBC95
	for <lists+linux-arch@lfdr.de>; Wed, 16 Dec 2020 09:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgLPIW4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Dec 2020 03:22:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgLPIW4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Dec 2020 03:22:56 -0500
Subject: Re: [GIT PULL 2/3] asm-generic: mmu-context cleanup
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608106935;
        bh=Duc98tex2/JpuiMotQWPduwXRhoEW92h+gxlQkporaE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VvJ4jY82pE5+tDnQe2bdMcaOsHLZmDZsNW08nvH59V8MUw3FzXx9w+0omn8/pIb3A
         4TU9nu51P0w7MQViafm1m3wdnjiPFPR9v9x/53e+IFhLBr2hqcZqvwhgADgK/dOXXW
         q/hR0A/JfgTv4GT4Mtr2Hi8Yh3c8f2qfe/u7EY2FSanrLafub/5nRdftfcb51CIJD/
         MhLWtKJnMXAkWgmht0bOi8Atj2Y3rsVgMezEeV7rPTmZp32Vq5rjoUWc9eK10yc0Hr
         Z9aLyroHzXYDI2cy/HW4QCcl2AjSJv5iq/+xqOHzAn6YGDQz+tMYHazefUItuYdrDg
         ARNEXc0jjp4jQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a237baPabD-Z=A46Wo0D0brL7am3cbQO7ot4r+nFt62Vg@mail.gmail.com>
References: <CAK8P3a0b0u9NQ1unjQfwBJovahQYNgNj1ROLGR+TzZWKnzQgzQ@mail.gmail.com> <CAK8P3a237baPabD-Z=A46Wo0D0brL7am3cbQO7ot4r+nFt62Vg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a237baPabD-Z=A46Wo0D0brL7am3cbQO7ot4r+nFt62Vg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-mmu-context-5.11
X-PR-Tracked-Commit-Id: c3634425ff9454510876a26e9e9738788bb88abd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 157807123c94acc8dcddd08a2335bd0173c5d68d
Message-Id: <160810693544.6147.10367280315035763177.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 08:22:15 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 16:45:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-mmu-context-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/157807123c94acc8dcddd08a2335bd0173c5d68d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
