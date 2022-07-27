Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512FB58314D
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jul 2022 19:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242003AbiG0R4T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jul 2022 13:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243115AbiG0R4B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jul 2022 13:56:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288708B490;
        Wed, 27 Jul 2022 10:00:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19AD461884;
        Wed, 27 Jul 2022 17:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 793BFC433C1;
        Wed, 27 Jul 2022 17:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658941230;
        bh=rbXQhemBM2OLPzGRQYNjnah19PIzWC0ECugQ8LsL3ig=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bngjNI9K35lmJwM9BluslKPLPogVzrKqQfTXo17dojylJxVqaS6qC3Wx0PfRrMvf5
         sNsS7cgI8oTRNgZb1fQ8xhsQmCnEF23r+DH2Kt4TqVcP6LoVv92arF/X8phZ9ge8B6
         QNzLSDwSyqLuUU7rMmtM8u2yT9xTkbKAO77dUOCmr3DMe5PGp36ruE78rjxRnTPYhv
         ObEZ0RTNXzsRZNxUVvIU6Kev6UC3KM8PGsSqbbUbMNJ2OWmAhiF+m5QYSma+QECmj8
         qQSSXU60dbNUtVABbSyOTbh2fy3QhexLf22jHC8Tt47YEda23fqu94wcWJvYkJyRoq
         FC54qmA4OnL3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67A1EC43140;
        Wed, 27 Jul 2022 17:00:30 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic fixes for 5.19, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a13Z96qf7O=94XkfWsq8yC3QTzFv0by7i180DSn10b-CA@mail.gmail.com>
References: <CAK8P3a13Z96qf7O=94XkfWsq8yC3QTzFv0by7i180DSn10b-CA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a13Z96qf7O=94XkfWsq8yC3QTzFv0by7i180DSn10b-CA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-5.19-2
X-PR-Tracked-Commit-Id: e2a619ca0b38f2114347b7078b8a67d72d457a3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e7765cb477a9753670d4351d14de93f1e9dbbd4
Message-Id: <165894123042.29306.8592359334851153853.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Jul 2022 17:00:30 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Wed, 27 Jul 2022 17:21:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-5.19-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e7765cb477a9753670d4351d14de93f1e9dbbd4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
