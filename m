Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AC5471C7C
	for <lists+linux-arch@lfdr.de>; Sun, 12 Dec 2021 20:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhLLTQw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Dec 2021 14:16:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40040 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhLLTQv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Dec 2021 14:16:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F02AB80D63;
        Sun, 12 Dec 2021 19:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FC0CC341C6;
        Sun, 12 Dec 2021 19:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639336609;
        bh=pSpyqRIm1XRtinaEeUqdyGDkr973ddqeF3xvtsAXzMw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IE+aL40Zh9SCXHX/Nk5p4snpaY+/yKur69A1yq2hP3xvHUwRcb0oQUHJDwdc7xqCW
         9GsghFoF8o1mmrxCwQeJQVjlhPlCA6vBae4MfsXRvTEY44XrncrO0sQSzSz+NB6yxZ
         3YTWCQm1x70v/3Aq8EQqa3JZgcV0JHF4RO8UuEQc07UNNPCWCHGVcapNmtujfaZrX7
         u7aBGbCdn6oOrwGsonZQC/rmlkmGYwceqr2mnG5Vk+0d/sSnaIWcOMERPnnERqSi+3
         4BN/Le1BgZb17S4czRKO/nh63Dme3ty7FqFjt2peKFObBujujp82is6qhfYPWwoOS9
         oqQWEHk3RvkxQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E91AB60A4D;
        Sun, 12 Dec 2021 19:16:48 +0000 (UTC)
Subject: Re: [GIT PULL] csky fixes for v5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211212021753.3541366-1-guoren@kernel.org>
References: <20211212021753.3541366-1-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-csky.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211212021753.3541366-1-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.16-rc5
X-PR-Tracked-Commit-Id: a0793fdad9a11a32bc6d21317c93c83f4aa82ebc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f3d41e82d78bf521dfee4d6db1d247628dcf399
Message-Id: <163933660889.938.9065494604784665966.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Dec 2021 19:16:48 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Sun, 12 Dec 2021 10:17:53 +0800:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.16-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f3d41e82d78bf521dfee4d6db1d247628dcf399

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
