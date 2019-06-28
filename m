Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2AF458F1F
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jun 2019 02:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfF1ApG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jun 2019 20:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfF1ApF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Jun 2019 20:45:05 -0400
Subject: Re: [GIT PULL] csky fixup gcc unwind for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561682704;
        bh=mkQ8RibRw6gwWJhsHFhTnCmSfeTNicYA7fdSh0sooUk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sPFr68fkzqA2AQpQx4iZ50Gki2u/52yaOy05BXg/Cvv3tJuJo9kOfCMdIf2/gayx7
         DnoKnAz2CRtOvtuQvoJMMEnnjYjFJOyG+Kp4sIFaQbYSCTG8xzt6KfIDbZkqwma2tY
         KVslwiY6pLi5GRC0DEO+KmNYwOCyvZhJTPDiINo4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1561529663-29852-1-git-send-email-guoren@kernel.org>
References: <1561529663-29852-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1561529663-29852-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git
 tags/csky-for-linus-5.2-fixup-gcc-unwind
X-PR-Tracked-Commit-Id: 19e5e2ae9c883f5651eaaeab2f258e2c4b78fda3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 139ca258055057e64d59ec92b6fd1ad3ca3a9fbc
Message-Id: <156168270492.1895.4552295813118856621.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jun 2019 00:45:04 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Wed, 26 Jun 2019 14:14:23 +0800:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.2-fixup-gcc-unwind

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/139ca258055057e64d59ec92b6fd1ad3ca3a9fbc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
