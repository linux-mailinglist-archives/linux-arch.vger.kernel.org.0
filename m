Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7561B740AE0
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jun 2023 10:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjF1IMb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jun 2023 04:12:31 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:51718 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjF1IJv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2023 04:09:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A58C8612EC;
        Wed, 28 Jun 2023 05:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 189D7C433C0;
        Wed, 28 Jun 2023 05:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687930816;
        bh=DndRpF+hdE1dFRA04LFJEcmBY3VAr0k7bSTXF94LsmM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=js7jriuJoICr/LKxWUVqR0plwSQASa2WhMv7jBsPTtubL3AnoFVKs3TtEFWfuSEU+
         uIGHFe6Ny6uvRY9TQ8l9I1WwuIj3K+Se+cnR0ABPgJ/0LLj10HwxirCa0oPqHthIWS
         N1/JnmVZxKYjA3U0C9N56aXiNWgIzEG7hzbeBlVOv/cW9ERbREuEyToCiDLNWT5J/Z
         yF2hcmFJ1D9QeJd26f5y5qBfN70avGmBptxDC3Kybp35VPdsVijsegcHP4ckX8+2gP
         /7g6cJ/KtR47U9YAEIkjnizJa0ICq59Qh/XxZKGJQMgEGi9t8bwT0CWKATRRKr9HNl
         glohx0Hw0E2Fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05292C39563;
        Wed, 28 Jun 2023 05:40:16 +0000 (UTC)
Subject: Re: [GIT PULL] Move arm64 documentation under Documentation/arch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <871qhwemuu.fsf@meer.lwn.net>
References: <871qhwemuu.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <871qhwemuu.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-arm64-move
X-PR-Tracked-Commit-Id: f40f97aaf7fa6222f4ec073c24fb14f04ffb6f80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6aeadf7896bff4ca230702daba8788455e6b866e
Message-Id: <168793081600.877.1311315093424436546.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 05:40:16 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 13:17:29 -0600:

> git://git.lwn.net/linux.git tags/docs-arm64-move

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6aeadf7896bff4ca230702daba8788455e6b866e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
