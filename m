Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37D95316F6
	for <lists+linux-arch@lfdr.de>; Mon, 23 May 2022 22:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiEWTe3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 May 2022 15:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiEWTeW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 May 2022 15:34:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976D5EC308;
        Mon, 23 May 2022 12:20:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E0B1B81263;
        Mon, 23 May 2022 19:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13726C34115;
        Mon, 23 May 2022 19:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653333604;
        bh=5mVcJbtzrU26jA9SfkHvHCPBC2d2si77Kiwaj75QY3c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Nk+J1I5y5JlA4WGwj/OH3/KCAQR7678XQwaHAe+/xFIxwtWvLzt3n2Q2IVbzGBJha
         7/5BY6I8uQJyf6F5ZKc0qNf37XZMSSSVuAvhMQHeKIN6gxqiAyX3aQMojrU9f3BfSk
         09Iza81XLASoYKeEvRasPdv1rJ+tk1SPdaIGaYxEvFv1IDdl0ym7Yl9E+G5YXo+uyj
         Zc0oJ9523Lvhq0Beu3VTFqE/0z+yscDhGF+uwerVWkBH9LxjqQIzRzwAUS1O6i19B9
         PW3alOnLAYpJRRwdDUVYw1LhovnNCoOTwPZPvHMvhF+tPSMEFwKykLkaHD6a6+3FK+
         /i9PNYs6gULqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1232EAC081;
        Mon, 23 May 2022 19:20:03 +0000 (UTC)
Subject: Re: [GIT PULL] LKMM changes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220520183022.GA3791835@paulmck-ThinkPad-P17-Gen-1>
References: <20220520183022.GA3791835@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220520183022.GA3791835@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2022.05.20a
X-PR-Tracked-Commit-Id: 5b759db44195bb779828a188bad6b745c18dcd55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2f02e9cdaade3ce565e6973ac313d2f814447f2
Message-Id: <165333360391.1924.2584190044095336122.pr-tracker-bot@kernel.org>
Date:   Mon, 23 May 2022 19:20:03 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kernel-team@fb.com, akiyks@gmail.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Fri, 20 May 2022 11:30:22 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2022.05.20a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2f02e9cdaade3ce565e6973ac313d2f814447f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
