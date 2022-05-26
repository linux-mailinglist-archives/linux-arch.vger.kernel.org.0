Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA011535343
	for <lists+linux-arch@lfdr.de>; Thu, 26 May 2022 20:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348510AbiEZSUO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 May 2022 14:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349334AbiEZSUO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 May 2022 14:20:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B7BB82C9;
        Thu, 26 May 2022 11:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BCB161668;
        Thu, 26 May 2022 18:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 150AEC34116;
        Thu, 26 May 2022 18:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653589213;
        bh=39Y3sv5nWEbgAeRC/3J+ZbpJcaVWD5lTK0uQH430+W4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J+a5HT+gAX43jgQe1TWdDIgYRYBoe3VArS/Wny6M8ia3OPtCBbnyymtQoCLDsDaGQ
         nNiyCMYbCIdCHqqkn/wePq5Uj2I05DiTRyS++pk66oTtjxxrSvjctNIELwMaiUhcYQ
         32Wazppbo7EsKFJPj3iu5Wc4ojSRRoK7Gu1C26TP92MNfShJyUESJ0CQX0G2TFcIVJ
         lxyA9cwA4bywet5akMLzRacD9iw2MOo1M7Lba8oE4YDuFXc5UzcN/atA/c1lNRBbYB
         Sj8V81rOhu4SKhhVOYI0jfKGyvRaEQ7ZLzZQggoTx1n/L/I9lM6UflDXHxxQg1jp6w
         Y6hQM1Uo6KUlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02655F03938;
        Thu, 26 May 2022 18:20:13 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic changes for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
References: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-5.19
X-PR-Tracked-Commit-Id: b2441b3bdce6c02cb96278d98c620d7ba1d41b7b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16477cdfefdb494235a675cc80563d736991d833
Message-Id: <165358921300.17369.14070091108956545607.pr-tracker-bot@kernel.org>
Date:   Thu, 26 May 2022 18:20:13 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Thu, 26 May 2022 17:00:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16477cdfefdb494235a675cc80563d736991d833

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
