Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5724320EE5
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2019 20:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfEPSpU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 May 2019 14:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbfEPSpU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 May 2019 14:45:20 -0400
Subject: Re: [GIT PULL] asm-generic: kill <asm/segment.h> and improve nommu
 generic uaccess helpers
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558032319;
        bh=SgtY/JlSUlVVPncUe4OJ6/DSHqGDEWfDNv/bzTAKQzs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NW/zXGx5s+CfJAXbSUXvzCViBb4G4ivXR9fkrYDmPDUNEdOgHLnvBmlHZrXAWMxwE
         /cHK5bfj3UbCbG5ooYhHzAx1BmjIUv95L+VPLSGz0estvjRROtUUukzgiRwMHstmuo
         qJ2ETKjL6j+eS2gR040W5UT+sjIb5mpn6YrnCAoE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
References: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
 tags/asm-generic-nommu
X-PR-Tracked-Commit-Id: 6edd1dbace0e8529ed167e8a5f9da63c0cc763cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27ebbf9d5bc0ab0a8ca875119e0ce4cd267fa2fc
Message-Id: <155803231962.24051.5619683992341077407.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 18:45:19 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Thu, 16 May 2019 14:09:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-nommu

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27ebbf9d5bc0ab0a8ca875119e0ce4cd267fa2fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
