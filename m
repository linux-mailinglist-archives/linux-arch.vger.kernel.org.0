Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3CA4E5D0A
	for <lists+linux-arch@lfdr.de>; Thu, 24 Mar 2022 03:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347321AbiCXCGT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Mar 2022 22:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347320AbiCXCGS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Mar 2022 22:06:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4010617A;
        Wed, 23 Mar 2022 19:04:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB27AB8222B;
        Thu, 24 Mar 2022 02:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 579A3C340E9;
        Thu, 24 Mar 2022 02:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648087485;
        bh=IFRutNU1lkCePfgXJd6XlNR47ykJexvq6up1JVbyNJU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=c2Cf00F9TAt3KnzBBrbrEuV0XQlQZVeMfOd9t4eBKQgBH7KuUh06BKxJ23yCSxi0v
         4AFdjIjhduWYOvG2LzRKEopGCnuYK45MKp8ro49+C5opTJ/kdgNgnyDYLcz805zyVM
         WxHAcxOHOxS0PDNoE6+CCOauurgQyrcOaEIdjcHSY32TGPwVW3r5ZxFDJeM4ZAExc5
         rPOkWKSfxQwP+Qyffu/3cfIZdsCFYrM6gZeUWGUsludBvxfe2vbu18i4r7Fha9bXBz
         AvAt1hqZt30bpqJaBddjZzwzZJgUHinrhJJ/KgbthMmcU+r59mdqgA7RYxTbjY+inl
         T9m0GWxnniZsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43986E6D402;
        Thu, 24 Mar 2022 02:04:45 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic updates for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a0DeZ4Gx6fOqLkjmA7kNYW5ZHq8BUpWTXXdqdtxcHRNLg@mail.gmail.com>
References: <CAK8P3a0DeZ4Gx6fOqLkjmA7kNYW5ZHq8BUpWTXXdqdtxcHRNLg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a0DeZ4Gx6fOqLkjmA7kNYW5ZHq8BUpWTXXdqdtxcHRNLg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-5.18
X-PR-Tracked-Commit-Id: aec499c75cf8e0b599be4d559e6922b613085f8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 194dfe88d62ed12d0cf30f6f20734c2d0d111533
Message-Id: <164808748526.29083.266360253368378374.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Mar 2022 02:04:45 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Alan Kao <alankao@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Wed, 23 Mar 2022 23:15:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/194dfe88d62ed12d0cf30f6f20734c2d0d111533

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
