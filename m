Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11CD744C2E
	for <lists+linux-arch@lfdr.de>; Sun,  2 Jul 2023 06:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjGBEOm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 2 Jul 2023 00:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGBEOm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 2 Jul 2023 00:14:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6DFE68;
        Sat,  1 Jul 2023 21:14:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFDA960B46;
        Sun,  2 Jul 2023 04:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16174C433C7;
        Sun,  2 Jul 2023 04:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688271278;
        bh=g7rvHZBY+PUxvTiJ6n8LkVMrjI0HJPjQFLKoOPprkJ0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fgIcXzubxA7QgJdaacrOqUf7J7wD9zCfLQ8an5gs3Kk2SFp3GYvRDrb41vGsf8bKu
         TKt3hi5i1RQ/RQ1m5nkgyFuHifnosGFEQx2MJCaXN4Cms3d7WwnLrlA09ugMjU6OdI
         yJ2FPGrRmhR/8WhN0ipn7IvNmhei3r5ufMV5w9pJZTPrGbUN20ix8bluoVaV+X+wzT
         pkdaf5OyQyXlaYmNDymXIuGdPcD2wFLltLvFa7aq/865V9xCfgHjIElAsVxvwVO2F+
         4ZQupZsIppXpbWg++X5fn+jpf0SmEb44C9teUYG2/8Wle3MoxX5NDpmxm8vASJzci7
         bxL6uegZQa8+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01A68C43158;
        Sun,  2 Jul 2023 04:14:38 +0000 (UTC)
Subject: Re: [GIT PULL] csky changes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230702031904.792594-1-guoren@kernel.org>
References: <20230702031904.792594-1-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230702031904.792594-1-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.5
X-PR-Tracked-Commit-Id: dd64621a2a97798d5df40028238a703d4324036b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 995b406c7e972fab181a4bb57f3b95e59b8e5bf3
Message-Id: <168827127799.10339.3739127046848044057.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Jul 2023 04:14:37 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, guoren@kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Sat,  1 Jul 2023 23:19:04 -0400:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/995b406c7e972fab181a4bb57f3b95e59b8e5bf3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
