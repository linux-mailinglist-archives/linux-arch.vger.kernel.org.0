Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF316EE871
	for <lists+linux-arch@lfdr.de>; Tue, 25 Apr 2023 21:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbjDYTpC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Apr 2023 15:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjDYTpB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Apr 2023 15:45:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8110F7EFA;
        Tue, 25 Apr 2023 12:45:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 225CD6288E;
        Tue, 25 Apr 2023 19:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85D55C433D2;
        Tue, 25 Apr 2023 19:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682451899;
        bh=PD67UMImLz4lGxSi3PnA06FkqRcHKEZ+9GLzGsI4mYI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=o8ADevF4lFkcFbwvLvwQPO9CjB6vQuSGY+4vLCACbglIngykLW6oabJh3Sk2V9PAD
         zupUjZi4M3CdLuJlqtJ2QXLxECNSLRAn191Zbu3/84caCPUOmPdMV3UcMkr26LtJo5
         LXI3qOoI3JNgAN01DQQYOcUzINE5eLCCfE1MJgSDeh/XEbsmBOwX8tqMaL5eWRJac9
         UbVmxWmBgbhnkUZSKA91CLBZzpOvTqULcJsIAKaUvHbobMWx091m60dw5e36ZmdG1j
         jmnCONTQfK3gm6svk1+CrYGePJYElgQKRBuyU7FKgA2I8DcMqGUReOpI1dmeKf3M+9
         7m4PczQKH/4yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 746A0E5FFC5;
        Tue, 25 Apr 2023 19:44:59 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic updates for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <66184958-d99a-4f64-bc67-50a703f51019@app.fastmail.com>
References: <66184958-d99a-4f64-bc67-50a703f51019@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <66184958-d99a-4f64-bc67-50a703f51019@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.4
X-PR-Tracked-Commit-Id: 73afb20716e163cdaf662af30d3597aeaacc6a0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53b5e72b9d89853b7e622239676163ede52acffe
Message-Id: <168245189946.15168.4655383679711669802.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 19:44:59 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Thomas Huth <thuth@redhat.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 23:15:59 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53b5e72b9d89853b7e622239676163ede52acffe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
