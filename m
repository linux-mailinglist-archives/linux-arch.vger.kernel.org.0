Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCB8489F31
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 19:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241529AbiAJS14 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 13:27:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39166 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239428AbiAJS1z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 13:27:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89522610E8;
        Mon, 10 Jan 2022 18:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC43DC36AE3;
        Mon, 10 Jan 2022 18:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641839275;
        bh=3VCVFY7pSgMNcLaS7wMDlD5Sg8KvJvo6gebnZeoDTZI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=upL+FYW7HRb5sEl5drMnNZiq9K7X3GE78j9IMp8mjtpn4vONtptKWinqW5VIEG5Pl
         5CZTAJVAP0JhnuGXhGAUz5ajXG4Ods/XcWXPxoglxnmZq+h2OEbIaQKScFy6xNFreD
         eOUEOmOO3vMrPr0Zpcv6gWG8WYlJVlSNnPiup53xDDliJ+JQXa51sQcO3L5a30NpYu
         KxB8omZ7i0vXbMjBpshxuU4Vec9ynIB7Cql9QXnZjA4h2teQa+SG/+2U73GTqr+yGB
         chvz88M0dbu+t2RyPOQ2gG1DMGLTU6rnmajZ/gZ9Jbot0ONKDLQz4SD6drA9x6hA+V
         8q0+iFihTCQyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC5C9F6078C;
        Mon, 10 Jan 2022 18:27:54 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic: cleanups for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a2ajcXkh4OAfJseUSiCsfU7gOXbDwiWHNGKgByzDwcycg@mail.gmail.com>
References: <CAK8P3a2ajcXkh4OAfJseUSiCsfU7gOXbDwiWHNGKgByzDwcycg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a2ajcXkh4OAfJseUSiCsfU7gOXbDwiWHNGKgByzDwcycg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-5.17
X-PR-Tracked-Commit-Id: 733e417518a69b71061c3bafc2bf106109565eee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7ac314061375c7805e0d3a26aad6eb0c41100df
Message-Id: <164183927489.9673.10073244646455634867.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 18:27:54 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>, wasin@wasin.io
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Thu, 23 Dec 2021 22:42:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7ac314061375c7805e0d3a26aad6eb0c41100df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
