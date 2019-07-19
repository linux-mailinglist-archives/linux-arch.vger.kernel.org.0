Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31BD76EB45
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2019 21:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbfGSTpl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Jul 2019 15:45:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387549AbfGSTpY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Jul 2019 15:45:24 -0400
Subject: Re: [GIT PULL] csky changes for v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563565523;
        bh=aP1uajN4RkEc62uSVyX2/7IxF58EZ73oI5bmRCpheGU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hMH4VkYHzLirEMCx7ZDnbMPAqIhcgMmO+trANNRDc35AoT7hcRGQhQiu64EBMXpX9
         0EipM+BZcLdYREGzUiLnK8/Py7cxV4xxpI7Bzze/TzK4OjLW6RRLbTOLtFF+BR7b6E
         HLicpBOc+BwDKS816L6ubJ0goZMYaMJRNhEw256w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1563522380-9180-1-git-send-email-guoren@kernel.org>
References: <1563522380-9180-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1563522380-9180-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git
 tags/csky-for-linus-5.3-rc1
X-PR-Tracked-Commit-Id: bdfeb0ccea1a12b58299b95eb0f28e2aa26de4c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a84d2d2906f983fb80f5dcc3e8e7c3ad70aa9f0d
Message-Id: <156356552349.25668.2927095785166445669.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Jul 2019 19:45:23 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Fri, 19 Jul 2019 15:46:20 +0800:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a84d2d2906f983fb80f5dcc3e8e7c3ad70aa9f0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
