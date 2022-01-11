Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB29248B4CB
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 19:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345157AbiAKSDe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jan 2022 13:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345156AbiAKSDa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jan 2022 13:03:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551AFC061751;
        Tue, 11 Jan 2022 10:03:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11D4DB81CB6;
        Tue, 11 Jan 2022 18:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D25B0C36AE3;
        Tue, 11 Jan 2022 18:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641924207;
        bh=05lhGuQ61qjKfc4Ul1uwx6BDCffTNP4xWGZ86fqYfB8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tvXrT0y0nKGnOcCqOITtjA6YKc4KQTch07cGdSn5U+zcJ6Mf5A2sSpqarhIA9mIDD
         S1RwPtx0b6ZU3EyLyO0gZefIHUxsr5qIyLLwPlVI4QsNWTEZ0Bfkuy6NelVKqRGLvb
         /nK/aNRln0QNvnb71CWMyD1iRe74sxqfhckd2spi9k3oeutXEC4kDISbFXeakN56dn
         pI2T9IrIul8bUANOumMqZbO4CJkKRiH1n8XGEDrpWd4aNg2g3pzBEstCF3cVoniuLv
         sreuNoZSbJaTJS85DooIM+6l6qiCNpt0eeUkVRflWj7V97uyrcGd56WETK4NPL9KNx
         JNOViCF9eWrPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B825DF6078E;
        Tue, 11 Jan 2022 18:03:27 +0000 (UTC)
Subject: Re: [GIT PULL] LKMM changes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220110184748.GA1012883@paulmck-ThinkPad-P17-Gen-1>
References: <20220110184748.GA1012883@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220110184748.GA1012883@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2022.01.09a
X-PR-Tracked-Commit-Id: c438b7d860b4c1acb4ebff6d8d946d593ca5fe1e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c824bf768d69fce36de748c60c7197a2b838944
Message-Id: <164192420767.4972.2339136732603982789.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 18:03:27 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, boqun.feng@gmail.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 10:47:48 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2022.01.09a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c824bf768d69fce36de748c60c7197a2b838944

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
