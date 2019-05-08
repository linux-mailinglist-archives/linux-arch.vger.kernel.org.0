Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B996180C2
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2019 22:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfEHUAK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 May 2019 16:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfEHUAK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 May 2019 16:00:10 -0400
Subject: Re: [GIT PULL] csky fixes for v5.1-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557345609;
        bh=+RbsCVc0D1Vp7kPBcoQ7WWuR9heN09HLyUNJwzQyv84=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=d8moxosP8NBek18dTydTkVX3VU5pCp5oCRcneipYd4mFVMSTKbpfF68Euhn5MKmUF
         By1JpNIMvG/ZnQw9uNg299GZ+ttJ0RlYFSkmTJzUNoaNyNJMZh9t03MC4eYejU7335
         4jXMrnemPsCSFjShPqqhTX+PO4jJkDUkpoZuQ0LY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1556181403-3881-1-git-send-email-guoren@kernel.org>
References: <1556181403-3881-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1556181403-3881-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git
 tags/csky-for-linus-5.1-rc7
X-PR-Tracked-Commit-Id: a691f3334d58b833e41d56de1b9820e687edcd78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce45327ca044415a5832dacfb76cdcfb747e3240
Message-Id: <155734560963.27473.1371616025731122852.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 20:00:09 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        ren_guo@c-sky.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Thu, 25 Apr 2019 16:36:43 +0800:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.1-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce45327ca044415a5832dacfb76cdcfb747e3240

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
