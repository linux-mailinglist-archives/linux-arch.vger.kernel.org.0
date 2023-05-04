Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598786F75C1
	for <lists+linux-arch@lfdr.de>; Thu,  4 May 2023 22:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjEDUB0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 16:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjEDUA4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 16:00:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503122077C;
        Thu,  4 May 2023 12:51:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D2486383F;
        Thu,  4 May 2023 19:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA356C433EF;
        Thu,  4 May 2023 19:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229786;
        bh=mvzyHTHy0Oe8TCHN/n9gVN4NY8Z5hIl80Fstuj7dArY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d9WioBEeN++Hhw/SsePi2pv3WePUcRnV+XCcJmzgQdHCbdybiaNwZdNbVHljxqLUj
         lTwzHoo5IybVcJ4fl/Zpx86TypSNwGpkIEEaxZGCyXAX9ZQMNWZUd8XHAvEMS72xWk
         oDrxlnb94jFspxLHcIvJ09z6C2FxYuMe7lrn7UYMidKmPfcYV7p8hZhUjPGsRXuUCn
         LPU9twsl/LoMf9UHtuq6asUfG2FifL9WWLvIBC7RTMjwrWX/mw9+Ywua6nqGaXR4kx
         kVDy7zk8Wpt4MAotCbAkGihP1O3W8GEzMP8OZyt2HMr/Nge1LQx+3xN1iDMvOUBLNZ
         MLc/6N6MKwn9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3518C41677;
        Thu,  4 May 2023 19:49:46 +0000 (UTC)
Subject: Re: [GIT PULL] csky changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230504121815.1537054-1-guoren@kernel.org>
References: <20230504121815.1537054-1-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230504121815.1537054-1-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.4
X-PR-Tracked-Commit-Id: 1f62ed00a56bf01becaccd81bf30f2fcb0322fd2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1f749de8a610096ca0dd9a40d89c8fa4098c8eb
Message-Id: <168322978679.14542.8821899286005778428.pr-tracker-bot@kernel.org>
Date:   Thu, 04 May 2023 19:49:46 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Thu,  4 May 2023 08:18:15 -0400:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1f749de8a610096ca0dd9a40d89c8fa4098c8eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
