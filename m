Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0665650D45
	for <lists+linux-arch@lfdr.de>; Mon, 19 Dec 2022 15:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiLSOaW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Dec 2022 09:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbiLSOaI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Dec 2022 09:30:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DE8D69;
        Mon, 19 Dec 2022 06:30:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71D1560FC0;
        Mon, 19 Dec 2022 14:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAC54C433EF;
        Mon, 19 Dec 2022 14:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671460206;
        bh=gjP6aIuedBoZUIpNXYOWVdccmxrx4lMpM2o7U6E+q5c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FGLSJn1N+RdNTv0B+qDExOcVdo1FUDdU60Z38IOXrkaah1wzP77vqVOFZjg0b6DW3
         LIqf2GIIHKGIX5vnPBej/eqmodDLCd6lePMlUXjsMSqHOBOKapJiLGySFbDjyuh5k2
         jVWRT9yf9STS+WlTIIfy09FJV/OMe+g3PZmdxOxdRY/aOwtLfazhAWQhNpaimMBNEq
         SImXHSa1FFhW/m9HQwJO2hrCcWLnyxIf9jeEh2WE5fxDk9qw2MCBmIX7R7mqSBZrR6
         4yPAlrJxhHY9kwsI3AFD7Y/NxmaE+QQxtsE1Z/M+ho4mgeEaq5YQ1t9JlAqBVoOEuV
         c3HjR75TOG6rA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9D84C00445;
        Mon, 19 Dec 2022 14:30:06 +0000 (UTC)
Subject: Re: [GIT PULL] csky changes for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221219042622.2621881-1-guoren@kernel.org>
References: <20221219042622.2621881-1-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221219042622.2621881-1-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.2-rc1
X-PR-Tracked-Commit-Id: 7e2004906fb52257772be0ef262fba2d5eb1653b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96bab5b926e4c2d970f70495f4554f905babd09d
Message-Id: <167146020675.28969.13535307199675455403.pr-tracker-bot@kernel.org>
Date:   Mon, 19 Dec 2022 14:30:06 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Sun, 18 Dec 2022 23:26:22 -0500:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96bab5b926e4c2d970f70495f4554f905babd09d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
