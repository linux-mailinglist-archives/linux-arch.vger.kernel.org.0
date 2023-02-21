Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0219269D75F
	for <lists+linux-arch@lfdr.de>; Tue, 21 Feb 2023 01:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjBUAFx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 19:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjBUAFs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 19:05:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397C41A4B8;
        Mon, 20 Feb 2023 16:05:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB5BFB80D3D;
        Tue, 21 Feb 2023 00:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BD60C433D2;
        Tue, 21 Feb 2023 00:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676937940;
        bh=14iid5L1mUTVw6gfuP5dlAKG6hafzPxjgBWiXgP+UjA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hOLIYI/BcxyFVF4UqFcpmuWJfVQXnJiOaaifvj0YGLLieAbkMah1Tfn4z3jTZcFSH
         PFhSVxwLUOsKe5GEoG8MVEH2aEg8Mi9iNd2Ojk5UhWDUR7xxZHznMEiUxqQiTDhl0d
         TIYb2ka5EUzfZcDQPLoalDrIZHCmtSsLzyw2VJb025+gcxUUbVuPMh0Tf92WBaD0XM
         NKVmLb4lh8LfVQ2+oG8IJR7Z6SURkK5/iG1BW2WTuagBF0efkhvhS1iEkjObG2hNfG
         Xi3iit7evTGnGFrWb56F0YZHOl5WN+P4ZZEOcRFQVRYt2UEKybQGgfZSpvNgC59O45
         oeiOBfwhpoW+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67DCEC43161;
        Tue, 21 Feb 2023 00:05:40 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic: cleanups for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ad5a0fc0-cad5-4730-9ddc-68285c6f13fc@app.fastmail.com>
References: <ad5a0fc0-cad5-4730-9ddc-68285c6f13fc@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ad5a0fc0-cad5-4730-9ddc-68285c6f13fc@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.3
X-PR-Tracked-Commit-Id: a13408c205260716e925a734ef399899d69182ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db77b8502a4071a59c9424d95f87fe20bdb52c3a
Message-Id: <167693794040.20221.11907165729569829299.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 00:05:40 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Matt Evans <mev@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Fri, 17 Feb 2023 18:34:19 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db77b8502a4071a59c9424d95f87fe20bdb52c3a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
