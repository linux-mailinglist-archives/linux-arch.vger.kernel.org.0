Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C56344CE4B
	for <lists+linux-arch@lfdr.de>; Thu, 11 Nov 2021 01:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhKKA2r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Nov 2021 19:28:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230344AbhKKA2r (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Nov 2021 19:28:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E214961284;
        Thu, 11 Nov 2021 00:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636590358;
        bh=JOBWZ1tOn5xpncxnIYQM8FwnmK2kxDafUHmdw3h7/SY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A8iYglbfJzMcp3NKQDNy3rngMd7+Zx+gf3RIFzs3+kxv6dcQ2mAl5uY57BKLJECTg
         iMpe9H6XrQqzoTvXiy8jLMAH3PvLGMzU2nvSKEX7aKsl57zPltGR0X9L695EN7Oj1A
         nvQA9G58RZtIHa00Yz/U95fXzQ1yyEiy6PwTfblh/D1EiFToa9L2M4sXwkYs8ZhrSI
         2Xf9vkU2fOH4PrB1lCWYt/5SOQcHEioz6j9nqFSzeeoPzaMrU5Zb7F8kwuj3XEWIpL
         JauYPnatdewlltboAEcOLNLMcOW8H8323TDI8DpKbPyprP5KCL3fRok6KhdDzYq+BR
         AQxoI8yHxYSpw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D7DB26008E;
        Thu, 11 Nov 2021 00:25:58 +0000 (UTC)
Subject: Re: [GIT PULL] exit cleanups for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87tugkm3gc.fsf@disp2133>
References: <87tugkm3gc.fsf@disp2133>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87tugkm3gc.fsf@disp2133>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exit-cleanups-for-v5.16
X-PR-Tracked-Commit-Id: f91140e4553408cacd326624cd50fc367725e04a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5147da902e0dd162c6254a61e4c57f21b60a9b1c
Message-Id: <163659035887.13025.9502538828058656038.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Nov 2021 00:25:58 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Wed, 10 Nov 2021 09:32:19 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exit-cleanups-for-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5147da902e0dd162c6254a61e4c57f21b60a9b1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
