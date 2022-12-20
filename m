Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C0565230A
	for <lists+linux-arch@lfdr.de>; Tue, 20 Dec 2022 15:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbiLTOtJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 09:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiLTOsO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 09:48:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8C81C936;
        Tue, 20 Dec 2022 06:48:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36CC3614A6;
        Tue, 20 Dec 2022 14:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96C36C433D2;
        Tue, 20 Dec 2022 14:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671547692;
        bh=6ADkkhbSKH/EGx8fmAdcjOH8H1OTTWsXgM1YpC18knI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=t7pBBgVs/lIU6pNuAYssrGONaPRcBoa70uri1zza63D32Jp4mTochH33fUTCbjRKO
         paxHia2TrsJtao7+R+dilBaglPwe5nnD0pupLplIf1t2eUpz5tAZKn5JE6BLgYn5+d
         lflzwnkdiW9s1PDsHFJR5sFSK+OYCF59itNpxDBpJsm98vrXgBiox+GO3yGRE+0qW/
         g5DLCb3fae3o+dv+bTqour1fUc3Gdqv81FrniSV1e8iqHzMis72VrDJt78gsXyul6C
         lFXtDT31AcwKhMuE837hewG1BDCv5NiqqThky+D0S5eK1i2ZruLam4qDxqjeDEGOqq
         FZoh60xhy0PjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86799C43141;
        Tue, 20 Dec 2022 14:48:12 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic bits for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0b37729c-535f-4864-aa2e-4f6088f8e63e@app.fastmail.com>
References: <0b37729c-535f-4864-aa2e-4f6088f8e63e@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0b37729c-535f-4864-aa2e-4f6088f8e63e@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git asm-generic-6.2-1
X-PR-Tracked-Commit-Id: 32975c491ee410598b33201344c123fcc81a7c33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70b07bec95b6d369f68fb85bc3fe60c423d8b91b
Message-Id: <167154769254.15660.17251251631475367475.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Dec 2022 14:48:12 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Mon, 19 Dec 2022 21:28:54 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git asm-generic-6.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70b07bec95b6d369f68fb85bc3fe60c423d8b91b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
