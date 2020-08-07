Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B454A23F3D6
	for <lists+linux-arch@lfdr.de>; Fri,  7 Aug 2020 22:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgHGUjH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Aug 2020 16:39:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:32800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgHGUjH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 Aug 2020 16:39:07 -0400
Subject: Re: [git pull] fdpic coredump stuff
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596832746;
        bh=Ley/0gw/K1qBh70fPBv1EkuHLNjGy2q9xu462f7RqtY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=04mRcQ3GAA+yntGZo+H0Haik9laT6ogZz8Z21VgStvW5oLGfOi5sdW+zg5DPrv/SN
         OK6JYXmJiAu7bPzRauT40WtNyhj47g1guOYhjQZ40Ln7ZS6F33iqeRErstMI2JlpN5
         NQQWXNS3VSmNSnD/hkxrhv4jxIzjT6l7mBpIPknY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200807193657.GV1236603@ZenIV.linux.org.uk>
References: <20200807193657.GV1236603@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200807193657.GV1236603@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.fdpic
X-PR-Tracked-Commit-Id: 1697a322e28ba96d35953c5d824540d172546d36
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f43283be7fec4a76cd4ed50dc37db30719bde05
Message-Id: <159683274687.2860.8837375700801145198.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 20:39:06 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Fri, 7 Aug 2020 20:36:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.fdpic

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f43283be7fec4a76cd4ed50dc37db30719bde05

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
