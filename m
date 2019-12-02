Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53F9210E409
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2019 01:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfLBAKS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 Dec 2019 19:10:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbfLBAKR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 1 Dec 2019 19:10:17 -0500
Subject: Re: [GIT PULL] sysctl: Remove the sysctl system call
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575245417;
        bh=T824FKpQHWTg8DZRREvcyNfKbCubI3JbDFFF6Zpka6k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NRa2zLR1BwhkitzPZe0RkYghWOFK1xx5x6hZ/HESpEMpkcra5OIhwWFNrajkj74BA
         KS6J6b1OHkiO3cvs25gbmGM5qjyt62n+xbgoH/vdDyhi8rB74VmWpxYVyMoyXoNhx4
         vMuLqsBsXfe9RVZpB1HF9aDhqx3X9m6qz+zcFRaw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87r21tuulj.fsf@x220.int.ebiederm.org>
References: <87r21tuulj.fsf@x220.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87r21tuulj.fsf@x220.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
 for-linus
X-PR-Tracked-Commit-Id: 61a47c1ad3a4dc6882f01ebdc88138ac62d0df03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad0b314e003049292a23dd248d3c3ca4a3d75f55
Message-Id: <157524541716.21884.4690547403694723874.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 00:10:17 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Wed, 27 Nov 2019 10:55:52 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad0b314e003049292a23dd248d3c3ca4a3d75f55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
