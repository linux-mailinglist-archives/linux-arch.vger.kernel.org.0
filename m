Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC89E53D34F
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 23:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347638AbiFCVtY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 17:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348886AbiFCVtX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 17:49:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E5B580C4;
        Fri,  3 Jun 2022 14:49:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D6BA61B44;
        Fri,  3 Jun 2022 21:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72744C385B8;
        Fri,  3 Jun 2022 21:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654292961;
        bh=t7OyryA6VvX2LD29Pc6X1ZXopKhxjMlxDvAV+eRTz7g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hhAcJTeC693DdSw8iUCbuKm9DISiMWEpMdXlhGcEZEQ/mldDmL9hCJ3rSbzOm6vGu
         oLDufKBBYue7uL1r1M4OsGiM+M1+OgQ9dXfEJFSEh/ARMnCy/al5ncfLm9hKx69lLe
         WIrRG1qwV1fiz+5Bc4C6e6/XeurkU9lctrJX/S2Oq2ho3IHStIWxGrJTFn8q1GV8ki
         exe6jGZcMO2HmcfaxrtwfgiSGvo30Hb40cOmlsNq4OPCBx7xm79TNK3HP5btiOOnzW
         AURj9LhBDmEoPQ5SdHBtWQih7eSA7eYr5fIr0nEcCJAKddguVqVonTAZOs4Gd2gHex
         mT/jgoPumtdgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59F6EF03950;
        Fri,  3 Jun 2022 21:49:21 +0000 (UTC)
Subject: Re: [GIT PULL] Add partial Loongarch architecture code
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a3LTdjqNRuqdWg126Ndmh11FDn6yo5DpR5nYZpZbxtg7w@mail.gmail.com>
References: <CAK8P3a3LTdjqNRuqdWg126Ndmh11FDn6yo5DpR5nYZpZbxtg7w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a3LTdjqNRuqdWg126Ndmh11FDn6yo5DpR5nYZpZbxtg7w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/loongarch-5.19
X-PR-Tracked-Commit-Id: 8be4493119b0aedf7dd61e1ca520fb398537b53e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6f2f3e2c80e975804360665d973211e4d9390cb
Message-Id: <165429296136.7657.4734745624252599522.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 21:49:21 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Fri, 3 Jun 2022 20:26:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/loongarch-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6f2f3e2c80e975804360665d973211e4d9390cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
