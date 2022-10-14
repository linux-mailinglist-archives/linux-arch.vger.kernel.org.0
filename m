Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820285FF4D8
	for <lists+linux-arch@lfdr.de>; Fri, 14 Oct 2022 22:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiJNUuk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Oct 2022 16:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiJNUuj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2022 16:50:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BF9A8361;
        Fri, 14 Oct 2022 13:50:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 140B961C0D;
        Fri, 14 Oct 2022 20:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7537AC433D6;
        Fri, 14 Oct 2022 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665780632;
        bh=UtG27lxqruNpU17YlUrA97cjNDxRFMq2DHB+k82IAPM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Rz1Ub1pt6LPmXF+wmmmkUqZc+pavUepYqP95fOSymvOuJSFwGb9HX/QeO9jPgWad2
         JyMq1eofgLDfjJuTb/J2f2/YbtGb2qGLXQ20Pq8ejfVaEHHlEEL+7Otb4G+303xLJF
         LDVBRPkjJ4bE/q1ftEUQosvfRHdpzsOURQgtHl2CrsFahwo51xvBWS/Uh1x7tOya7Q
         SuZADRBBKdZ8xbrf+E7V0mTyjfWoXf01QqBtMWqD8k2W0KANfWQMEDu52Lxqu/ea26
         x6qACkdcAfkMyBcW6+IWbw7taCfLZSzAVmZ+TpHJV1BDDVYkH3zhvqRLn1OWib9yON
         4D9py0siyYAug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62F43E270EF;
        Fri, 14 Oct 2022 20:50:32 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic: arch/alpha regression fix for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <796854e9-ccbb-4dc1-aec6-bf3461d9d813@app.fastmail.com>
References: <796854e9-ccbb-4dc1-aec6-bf3461d9d813@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <796854e9-ccbb-4dc1-aec6-bf3461d9d813@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-fixes-6.1-1
X-PR-Tracked-Commit-Id: 2e21c1575208786f667cb66d8cf87a52160b81db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73344a3f6793d6b5384077be1e5ce6b90bbcaeb4
Message-Id: <166578063239.25591.6601511984817088258.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Oct 2022 20:50:32 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Fri, 14 Oct 2022 22:35:44 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-fixes-6.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73344a3f6793d6b5384077be1e5ce6b90bbcaeb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
