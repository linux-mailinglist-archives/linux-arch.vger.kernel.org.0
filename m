Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2753E5F6E01
	for <lists+linux-arch@lfdr.de>; Thu,  6 Oct 2022 21:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiJFTP3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Oct 2022 15:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiJFTNq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Oct 2022 15:13:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59563A6C34;
        Thu,  6 Oct 2022 12:13:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA75361A85;
        Thu,  6 Oct 2022 19:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5934AC433D6;
        Thu,  6 Oct 2022 19:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665083624;
        bh=Ujbqbea8lMfhrQ16+Ky00kJ8zwYAk9S5tqzfldLIWEA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bb1MCIEhCWFSwJDEv/HMN54UEWGnW6OCuqLFSrDbsDjfHQHrjLITN8bVfQ+kdQRx+
         tzYZiGey5NwgyYnk+1hFBquc54FJC8KEHg4UBMbL6PFY5R9v+6g5a52kcgGfPyvr0r
         Azkpbl0alqGRFOI0dIqWXP0WuIPaUXOIK55xMjop6WRbaAep+YmDfud9VCSgYALGLh
         hHp8WvoqhcR2g4BSbZDJ/Paa5Oh8b6EMWIwtDOrk0E3Wyld2SMhGyCwpNVH3jKSZay
         ZXlq+wt+ZqksUlD8UjlpDDASrRO7yNwsEXmZeSOcbrIf3tTRnLisO8bH73HjhEb9bZ
         slHS3WPK5Hpww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47007E2A05E;
        Thu,  6 Oct 2022 19:13:44 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic updates for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5c3aa67f-bc78-4abe-aba2-e5679cb66994@app.fastmail.com>
References: <5c3aa67f-bc78-4abe-aba2-e5679cb66994@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5c3aa67f-bc78-4abe-aba2-e5679cb66994@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.1
X-PR-Tracked-Commit-Id: e19d4ebc536dadb607fe305fdaf48218d3e32d7c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93ed07a23fd08b8613f64cf0a15d7fbdaca010fd
Message-Id: <166508362427.672.3088824568748451813.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Oct 2022 19:13:44 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Thu, 06 Oct 2022 11:30:38 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93ed07a23fd08b8613f64cf0a15d7fbdaca010fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
