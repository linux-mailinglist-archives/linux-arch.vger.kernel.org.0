Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68C50C2828
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2019 23:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbfI3VFy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Sep 2019 17:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbfI3VFy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Sep 2019 17:05:54 -0400
Subject: Re: [GIT PULL] csky changes for v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569864624;
        bh=q2Aw7oxKyuN+TMragPvuqXluuGNeqPOU2QSjQfBGXc8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wpGFPWxQKiim3uMmlV0QbP6OGXmtbhMvvwLJ2LOT6B7+JfnjMhmm+cuQASdCEwjrO
         +YPeMlx4emuXJm33QgwXJzMV9Ot9tm4lPbXb4lyDIXtprJFnYnbCmokkcWOZRXOrON
         Hi0YnTERN6Br7ADE5IVIOINGBl5ZmH34Eh5UXf/c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1569839484-28170-1-git-send-email-guoren@kernel.org>
References: <1569839484-28170-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1569839484-28170-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git
 tags/csky-for-linus-5.4-rc1
X-PR-Tracked-Commit-Id: 9af032a30172e119a5935f802b066631f8ded2d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80b29b6b8cd7479a67f5e338195dbc121b30c879
Message-Id: <156986462410.9141.54549862390206460.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Sep 2019 17:30:24 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Mon, 30 Sep 2019 18:31:24 +0800:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80b29b6b8cd7479a67f5e338195dbc121b30c879

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
