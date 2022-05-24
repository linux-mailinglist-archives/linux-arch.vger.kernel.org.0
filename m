Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAC4532222
	for <lists+linux-arch@lfdr.de>; Tue, 24 May 2022 06:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiEXE13 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 May 2022 00:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbiEXE12 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 May 2022 00:27:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E9067D1E;
        Mon, 23 May 2022 21:27:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D54E61403;
        Tue, 24 May 2022 04:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76148C34117;
        Tue, 24 May 2022 04:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653366443;
        bh=4zLOAFfbiAxhbDahp8ye+sl/idxG12bo4dC4hk3tisY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jlcsMGoE2nXCiB8/7f3GwvlYwvYkaHXxBXaTl9ZLKS6DaDCZYB+kSbrKNI9IIGYvX
         X7OTCiLNqiXzyJVjSCl9HUdaRoW17uWd8bnISu9PAq9rBq8AhLtVgCbhYmSr5+98aC
         c6WVNtP+pCij/Ifz0ZBXi7WRNGmZsuXAaM+Jp/euMTU4KzZ6it2c+b0/P8tzw8oQOj
         00qGGm7oKUgKmY/kltgfiYRepL+ziX1Vn0aqcq0XjUChg9xPtXRldWxTYwETKJ2jxh
         vcWS7WoOiKxaxW8m/eSDRbzHNI991xAvQezxeIV8zMRuE1TTDW2xjdWUhqeGSUYxzx
         3K84PU/lzkGKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63CC7E8DD61;
        Tue, 24 May 2022 04:27:23 +0000 (UTC)
Subject: Re: [GIT PULL] csky changes for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220523160347.172358-1-guoren@kernel.org>
References: <20220523160347.172358-1-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220523160347.172358-1-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.19-rc1
X-PR-Tracked-Commit-Id: 64d83f06774668081258bd7f3241267239bb9ab2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67c642e0d9aa927c1340638e472f2467fefd1dbf
Message-Id: <165336644340.29742.5932504374948415164.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 04:27:23 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 12:03:47 -0400:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67c642e0d9aa927c1340638e472f2467fefd1dbf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
