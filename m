Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2812258A35F
	for <lists+linux-arch@lfdr.de>; Fri,  5 Aug 2022 00:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbiHDWqS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Aug 2022 18:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240109AbiHDWqR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Aug 2022 18:46:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBCC1F62E;
        Thu,  4 Aug 2022 15:46:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ADC861877;
        Thu,  4 Aug 2022 22:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71A8EC433B5;
        Thu,  4 Aug 2022 22:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659653175;
        bh=Zms+t/GNzF9Q4EIhtfY1d4Qf5yAH6x9QRKZIHppwGsU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u2gsg67ht0MR/frWuufby1MnJ+y7p159X/zdTSmbJDU926mJvzFNF2ZNmFkqAn4eB
         OnYyAsvHM0f2EZy7Y8yUsioCfeGiNVWlltVyB856HQ/XJ1EbxQCIBqmsCDE/mt9bDD
         NJD6RmbkT8EQ9qI9+A4vLPdZFOO7BU+67KpV25OKN3RMeeEPV8XvFKT4cOar0pnSeW
         xuJ2nWNH3tJ7503MyX85CUoczZIAtYdQhTYB7OEwO93R0fY+Y4D8kG5mfCtcqC+UXN
         /qrg/kqeBgsZnPK4Zdq3aJISkJuBZUMC5r/TC0gNiteDFDhCA2oD2w8s3ksGsUs5xy
         vXea5+dXUynCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5DDDDC43140;
        Thu,  4 Aug 2022 22:46:15 +0000 (UTC)
Subject: Re: [GIT PULL] csky changes for v6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220804033446.1250001-1-guoren@kernel.org>
References: <20220804033446.1250001-1-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220804033446.1250001-1-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.0-rc1
X-PR-Tracked-Commit-Id: 45fef4c4b9c94e86d9c13f0b2e7e71bb32254509
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7df9075e232e09d99cf23b657b6cb04c9506e618
Message-Id: <165965317538.20279.13602377672979795981.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Aug 2022 22:46:15 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Wed,  3 Aug 2022 23:34:46 -0400:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7df9075e232e09d99cf23b657b6cb04c9506e618

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
