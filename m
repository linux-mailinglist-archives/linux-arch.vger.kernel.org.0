Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7E31EB26F
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jun 2020 01:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgFAXzW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jun 2020 19:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728947AbgFAXzK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Jun 2020 19:55:10 -0400
Subject: Re: [git pull] uaccess csum
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591055709;
        bh=00kVKA0PECl1saW9fWEqhFCfvJqoDd/z9D9kF7vHFQw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TsJATtgsyVDi/h/JsedToJ6ZiiyHwk2GhNyTqqRDzRDAem3R6W1FRI3SiIms6bzeL
         TvuTAyXQcdZO2g9TA5jIZU1uA8YFqwNgZqpPMByqzm64gUVh7u5hK4DsEZcLizKBTD
         sF3OMRHHtbOV33HTuWno+pK96wDM4NDqlaXLxKIQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601182245.GA23230@ZenIV.linux.org.uk>
References: <20200601182245.GA23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601182245.GA23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.csum
X-PR-Tracked-Commit-Id: 001c1a655f0a4e4ebe5d9beb47466dc5c6ab4871
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b01285e1672ed9342ace952e92eb1e1db7134ae
Message-Id: <159105570941.29263.5629757384058826263.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 23:55:09 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 19:22:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.csum

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b01285e1672ed9342ace952e92eb1e1db7134ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
