Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA36678124C
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 19:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350454AbjHRRtE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 13:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379246AbjHRRsl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 13:48:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8542D79;
        Fri, 18 Aug 2023 10:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C47A062B1B;
        Fri, 18 Aug 2023 17:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 313B4C433C8;
        Fri, 18 Aug 2023 17:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692380919;
        bh=JCUy2JpC0MTdVgTD/+6GMFpHZ0mlZz/SaC5hdxmL44k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AhjrvkUmptQT2JJIJBK8bQQ4H/DSgf3qizKF+H5baQ9hkfMsKNxjGbHgq193SaIhH
         OXWvj8U6jztJRLDExaBqHpKo7NDJc/8G23nvue4JQol0cUte8tGdgoIDrp7Q56gcDj
         vy1swKfEwLN2ufCFkKLqsJ2ppVwmVWsVjKPezNuNFL0vvhdhR0F3Ek3wTWH+/ZiyxE
         xJf02ediZGVndGJqZhLV3nmNClF6YFeNTiDxKyjUxZMJ7Mo6oIL8W3IEDaWIMOz4y4
         I+eVE1EKbi23bySjMw5HwW6YXWHXt4/pmctnM0NcIxJeBBprtjUQZHZ6h7QxNWEJOd
         WIwtdtDDmhgGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1CBFBE93B34;
        Fri, 18 Aug 2023 17:48:39 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic: regression fix for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <35766d47-a38d-4096-b602-887cf3a689e1@app.fastmail.com>
References: <35766d47-a38d-4096-b602-887cf3a689e1@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <35766d47-a38d-4096-b602-887cf3a689e1@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fix-6.5
X-PR-Tracked-Commit-Id: 6e8d96909a23c8078ee965bd48bb31cbef2de943
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eabeef9054fdd317e58387ed0ab1a32fe9eb5909
Message-Id: <169238091911.10816.1300489151751650884.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Aug 2023 17:48:39 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Nathan Chancellor <nathan@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Fri, 18 Aug 2023 07:00:12 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fix-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eabeef9054fdd317e58387ed0ab1a32fe9eb5909

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
