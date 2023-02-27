Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29B06A4971
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 19:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjB0SSP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 13:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjB0SSO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 13:18:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9524661BE;
        Mon, 27 Feb 2023 10:18:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 338E360EEB;
        Mon, 27 Feb 2023 18:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94BE3C433D2;
        Mon, 27 Feb 2023 18:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677521892;
        bh=wifxpFg+9ozzKuhkGHECcIJvJjaWeKNAZ80glMB2Y04=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TwtoF6PMT56ZIyIz3rLZWlSJ0TPIUEBK8o32VTTHRkD+lA4TOUOLtvWP/HbvTvIDc
         lyHvffXCYlPolKy3OYYOoNAGT5duCVzegza/cYEcMSO2UbihUObrIZ8Pcys1RygsHz
         yymg5cYnFshvVKhcq6VofXt8h6GUGxspwZMws7wI4Nt8XSNEYIPcGI2ck26x/ge+HP
         wci4x5pHoRLTT1GCTJi8IA5p/+5AOcLA3sD+K8BmLEsB7CFdG8IjBrNRNhpyneHjaE
         Btf6IKqZQQOXuAD0ui4BJ1s2xXCB9KQ4JJTkUWPn189QcvR2ppFuHUwkjdMCQeTEOd
         0mbnsokC1A7pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8493AE68D2D;
        Mon, 27 Feb 2023 18:18:12 +0000 (UTC)
Subject: Re: [GIT PULL] csky changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230227070122.1840809-1-guoren@kernel.org>
References: <20230227070122.1840809-1-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-csky.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230227070122.1840809-1-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.3
X-PR-Tracked-Commit-Id: 4a3ec00957fdf182be705d46e77acacc430f7d65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6cc7a0436906b18f51c3e6b1f41d648bf645bd7
Message-Id: <167752189253.27343.6537069672314212266.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Feb 2023 18:18:12 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Mon, 27 Feb 2023 02:01:22 -0500:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6cc7a0436906b18f51c3e6b1f41d648bf645bd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
