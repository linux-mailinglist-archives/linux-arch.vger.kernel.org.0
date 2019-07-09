Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96A7B62FDA
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jul 2019 07:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfGIFKG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Jul 2019 01:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfGIFKG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Jul 2019 01:10:06 -0400
Subject: Re: [GIT PULL] signal: Removing the task parameter from force_sig
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562649005;
        bh=h857G2V0q08LCd9TKij8AxC/JpJ+aFt+qlG6na3WW/E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Tx/ObFeehPzYGeSaOxoCbFg5LgQ0UPvL4bzXz8jmy8Id0oieQRfrQXgBk4amBvfoL
         ciliHiORMtMM+0LloJwK2S7C8CJh2Nf5/PFfE5dDlOVRZVK+QFhuDoBMuvifzAY0nk
         rlTvfSiado5wPSiVYFfyxq/uAgbGUQ6aWROb6ZQs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87v9wcl91m.fsf@xmission.com>
References: <87v9wcl91m.fsf@xmission.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87v9wcl91m.fsf@xmission.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
 siginfo-linus
X-PR-Tracked-Commit-Id: 318759b4737c3b3789e2fd64d539f437d52386f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ad18b2e60b75c7297a998dea702451d33a052ed
Message-Id: <156264900556.9660.5303797705259453222.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 05:10:05 +0000
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        <linux-arch@vger.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Mon, 08 Jul 2019 12:40:05 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ad18b2e60b75c7297a998dea702451d33a052ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
