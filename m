Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035127403C5
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 21:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjF0TEi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 15:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjF0TE0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 15:04:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C467271D
        for <linux-arch@vger.kernel.org>; Tue, 27 Jun 2023 12:04:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C61AD6120F
        for <linux-arch@vger.kernel.org>; Tue, 27 Jun 2023 19:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3960DC433C0;
        Tue, 27 Jun 2023 19:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687892661;
        bh=qAlW7xuMxe8VG0qbTyUE753xrfYNzIbOGFm1U8fGUs4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DeJhYeL87Jlg1sxuA05wmrYovQq9nTKQNgoISXgqgz36ZAwKLRSZ8KsDyIxBCYIS/
         iPpDeUIqOKNC1XaVWoJYAUltO/kL2JqU6Zw3LsjJ2q/58sADA5B2pcROx5s/coCorM
         0PoRePh5dMW+N3yF7vHaArQ4X0S28W4IpcWGy5d6Syx4a588I6AYmJ6VVpzri79W3h
         El2Yv7xSK0i/+XDCh0rwj+Sj1+5VcgW12Z5gTZEISS8Mg4YpmbSBuBc6HrXwCtRuY+
         WcETh8GWBhVW1/mjHFIVNvsyKTfuszkkwPpwTk9O+q3PyaKLDeM1HJEz0vo5/UQBBl
         nsCb+oGOWGKwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 272C8E53807;
        Tue, 27 Jun 2023 19:04:21 +0000 (UTC)
Subject: Re: [GIT PULL] Move Arm documentation under Documentation/arch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <878rc4euln.fsf@meer.lwn.net>
References: <878rc4euln.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <878rc4euln.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-arm-move
X-PR-Tracked-Commit-Id: f8c25662028b38f31f55f9c5d8da45a75dbf094a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04fc8904d5d18a132f5ad67b79ee980b6602c8c6
Message-Id: <168789266115.16132.8218677774553892978.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 19:04:21 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 10:30:12 -0600:

> git://git.lwn.net/linux.git tags/docs-arm-move

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04fc8904d5d18a132f5ad67b79ee980b6602c8c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
