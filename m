Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB6A5B36DE
	for <lists+linux-arch@lfdr.de>; Fri,  9 Sep 2022 14:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiIIL75 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Sep 2022 07:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiIIL7z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Sep 2022 07:59:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8673A178;
        Fri,  9 Sep 2022 04:59:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F234C61D04;
        Fri,  9 Sep 2022 11:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61723C43470;
        Fri,  9 Sep 2022 11:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662724793;
        bh=moPR6ezP5l+WLCA18lrBWMVOQSYizOeTyNhUNn26jEg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OBB7xrDlLQLArGtu02OB7Fp6UCvY5w8nnBqSuHu3tjpxYRFWaB9SrmDF42DDBoZl/
         eX6irVqktdRRUmtGYpJZpb20U0gp2Y1cvkQiPonUpEd5IJk9w1dX+pGfC0YA/GI3IG
         e/wfsLxUJNe5YlEOS0Q2UCzmd8HCS3TiJY5J059ycYlE/X+nOxfeBIjyqqcOuGhDoM
         C0z51xK73/BGUbnlt4mSwgDzVUgUtXkLpCIHnNM4VDNbTRQtFszKz1rTnT/9jE1a3+
         Rw3BBGaiIW9PtLQfmLLcW8R718k9UI0fKbYPNgkTUqEusthE7JQqjQKjUw2WFSBJLa
         OD59JpTiiZ/3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 504DDC4166E;
        Fri,  9 Sep 2022 11:59:53 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic: SOFTIRQ_ON_OWN_STACK rework
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6ba5a3a9-93b0-49a9-ab49-7b6006e23067@www.fastmail.com>
References: <6ba5a3a9-93b0-49a9-ab49-7b6006e23067@www.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6ba5a3a9-93b0-49a9-ab49-7b6006e23067@www.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-6.0-rc4
X-PR-Tracked-Commit-Id: 8cbb2b50ee2dcb082675237eaaa48fe8479f8aa5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f448dda895edcee1bd92a3ec6c4d9d210523b853
Message-Id: <166272479332.31182.15648610936277066333.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Sep 2022 11:59:53 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Thu, 08 Sep 2022 16:44:34 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-6.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f448dda895edcee1bd92a3ec6c4d9d210523b853

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
