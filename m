Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0504A169932
	for <lists+linux-arch@lfdr.de>; Sun, 23 Feb 2020 18:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgBWRuP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 23 Feb 2020 12:50:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbgBWRuN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 23 Feb 2020 12:50:13 -0500
Subject: Re: [GIT PULL] csky updates for 5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582480213;
        bh=SflshuwIeGKsfRvAgspCjuFtPZtqq3/PoDLKco82kFI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=A+q+qAXNZfJBH2vwNlFI3gsGabtt0FuhvdY04n6XwiB/kYbIZmnhSlGI8a/ecXm8z
         8En6sFADiFgUQ37Rl8vq+B/avcvt8u5rxixo9XCzqcjPcQnNXwD78WqVWImhXFt4qb
         odh5zF1av1BVUAXJs/zdWJKxYT1ayLr7HG3hMdFM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200223162332.16495-1-guoren@kernel.org>
References: <20200223162332.16495-1-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200223162332.16495-1-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git
 tags/csky-for-linus-5.6-rc3
X-PR-Tracked-Commit-Id: 99db590b083fa2bc60adfcb5c839a62db4ef1d79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6188dff33fba320826e87e387ae6efffab0525d
Message-Id: <158248021325.10261.12221204167090455190.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Feb 2020 17:50:13 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Mon, 24 Feb 2020 00:23:32 +0800:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6188dff33fba320826e87e387ae6efffab0525d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
