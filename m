Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0414B7D01BD
	for <lists+linux-arch@lfdr.de>; Thu, 19 Oct 2023 20:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346412AbjJSSgT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Oct 2023 14:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345214AbjJSSgS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Oct 2023 14:36:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A6D12F;
        Thu, 19 Oct 2023 11:36:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5A4AC433C8;
        Thu, 19 Oct 2023 18:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697740576;
        bh=v2W9P4t8t3zNYgO1q1TE+P02uqNlmhYpi0lDTNyHrJU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iSTa+LUSbvdfbSkeXN+w/pZrSGXxLXC2n0WiztmEm6m3OGIGZGuEwGDgDBm57flXr
         cBBFNjMit/JsBLaq33nHSZcU9GK0KCsc886MkqXGoW8TnGKIbM+8ZehZYbWScmyVDs
         CvGdeRyxXQtg6a8wErMZyHkV2iUM+miJ+iWRPZtInkKaONy9ED6S+mdwU1XG3d8pGV
         0srH3A5UKl81Y052B78fhB28gB67rXFUa9Qut2FhDxckPTghH2ea9/tynlYEDw59oT
         HrR0jImjU4L7iyIpAwBGcTHwVmEVYLERBCDkSbGUGp9xBjuHr35XtvcsZTihmFs/aY
         ZTu857JmABb9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 971B5C04DD9;
        Thu, 19 Oct 2023 18:36:16 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.6-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231019084227.4111684-1-chenhuacai@loongson.cn>
References: <20231019084227.4111684-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231019084227.4111684-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.6-3
X-PR-Tracked-Commit-Id: 278be83601dd1725d4732241f066d528e160a39d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74e9347ebc5be452935fe4f3eddb150aa5a6f4fe
Message-Id: <169774057661.20290.11492595041951746156.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Oct 2023 18:36:16 +0000
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Thu, 19 Oct 2023 16:42:27 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.6-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74e9347ebc5be452935fe4f3eddb150aa5a6f4fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
