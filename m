Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B833BAEAD
	for <lists+linux-arch@lfdr.de>; Sun,  4 Jul 2021 22:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhGDUMW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Jul 2021 16:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229874AbhGDUMV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 4 Jul 2021 16:12:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E0C9E613F3;
        Sun,  4 Jul 2021 20:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625429385;
        bh=fk/pRVVFRm1ZB46JXCjJehDy/PCH9P0qyJUvF/CWCaQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=i27VcSFAPWJOnLfn/RSvHXzeOvmh+DTnPIsieHJp1O1TRGb3cCGVwtGppYhf6CaS1
         cXTEHPTBV1RL4HcNXlJpCJCXTKortREJF/SCK0yr/9lkEUF9mk3Fc+8hJR4TFT9Kgd
         5iJE1NdiOFX+x3NBrrlkLzKGdLtr4PjO96glkHUjsjT6egq/wwuj198Q8nRaxuorlJ
         BUXHK5Y+ScXaV8YW6FQF/uXoo7aGmqE0Emd+yOBTeNkFCIb5SwTGIpuScHROY6Bm7a
         NrfaoPz+X+vBzh1GEfBqahCzziajiaV6Qp4HviGUsj2XHyrExB20FAAf9usxz82Lum
         MZNs01EkyL7ZQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DB05A60A27;
        Sun,  4 Jul 2021 20:09:45 +0000 (UTC)
Subject: Re: [GIT PULL] csky changes for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210704101120.104842-1-guoren@kernel.org>
References: <20210704101120.104842-1-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210704101120.104842-1-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.14-rc1
X-PR-Tracked-Commit-Id: 90dc8c0e664efcb14e2f133309d84bfdcb0b3d24
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d4d4c6ff6debde4c44a418c59b304d4b514541c
Message-Id: <162542938589.15409.6406821157697805083.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Jul 2021 20:09:45 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Sun,  4 Jul 2021 18:11:20 +0800:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d4d4c6ff6debde4c44a418c59b304d4b514541c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
