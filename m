Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375776DA034
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 20:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbjDFSqS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 14:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240384AbjDFSqP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 14:46:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393D87A8F;
        Thu,  6 Apr 2023 11:46:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7185649E1;
        Thu,  6 Apr 2023 18:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33328C433A4;
        Thu,  6 Apr 2023 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680806773;
        bh=pbaxl94uVyt1x6X5qXUQ7sKoLrwg06+LG1CkPCywz6s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XbioyBc3gn02aoWY9GrGUChlSNTdTtf0oIjII3VUPNzQyhjjd4DCqHB3KyATouq3j
         HO3KFXJL52NWxvRLR1Zq+UQEUVrPjxPqo2M2zQ5Rw93igi1wRm3+61VnCh5XpZHnG6
         5vT0SEiKaCILyEIzI5Zf7oNrLUwEvlP7Yv1TfbxGMfEL5uz5UHISsfqQOavQRK6ecY
         1exeIOG/muQY/Elw3PpWOtgPYYmZFplpk28GOY1yHUBB1cLY/UQFM4i+5IHwbHrWbU
         DB11HKwKIJ/uE4S7N/2bdd/HuWvCoHMCCjQbcXEjBurco4v6hxUmYanOmbLbgRrDER
         E96bMSp48za1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16DCDE4F14C;
        Thu,  6 Apr 2023 18:46:13 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic fixes for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f44680f5-df08-4034-9ed7-6d43ee4c4c2a@app.fastmail.com>
References: <f44680f5-df08-4034-9ed7-6d43ee4c4c2a@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f44680f5-df08-4034-9ed7-6d43ee4c4c2a@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-6.3
X-PR-Tracked-Commit-Id: 656e9007ef5862746cdf7ac16267c8e06e7b0989
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcff5f99eaf06ff6818e14751ffeeb677a325127
Message-Id: <168080677308.24406.5479155199238255018.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Apr 2023 18:46:13 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Matt Evans <mev@rivosinc.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Thu, 06 Apr 2023 10:12:53 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcff5f99eaf06ff6818e14751ffeeb677a325127

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
