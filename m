Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD88789882
	for <lists+linux-arch@lfdr.de>; Sat, 26 Aug 2023 19:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjHZRr1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Aug 2023 13:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjHZRrW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Aug 2023 13:47:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6732EB6;
        Sat, 26 Aug 2023 10:47:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4CD960FB5;
        Sat, 26 Aug 2023 17:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 397A4C433C8;
        Sat, 26 Aug 2023 17:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693072039;
        bh=Vk/QybRG7sDvLhmb2DrEFPqd1gLupxqm/qaNQai4U7E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kt0NV4MdO3QwOcZn77m5WndNhCxmTthN8T1YFSJPDBueLYM4EcryyL3RXut97XFUS
         epkAU1xMvYD+hzeyGh5n+Y8a8DRvNVLWCLUYkx/Ip1zvMFNEVzfm4IqZSjnwE690RK
         3bpxmu/ZTlks3sanEsEW3gArns99etxhJ7eFHsxZBqLqzBR57BH89+b0vHJT+poZ3S
         vc8EqmageT0KoK2f+OYvwfGbMxnw5/PInoPBvScfdu7dBlTqfaGhV/iLDNTJnLxjRZ
         qHTmdax+FwtDuSCV2oxsAq6Ed67xO+MPWE4Ka4Y8UdZB6QxCq4lZZcaAOycTy0qhg/
         leAXIxfbFpkvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16CB6C595C5;
        Sat, 26 Aug 2023 17:47:19 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.5-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230826163427.4193691-1-chenhuacai@loongson.cn>
References: <20230826163427.4193691-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230826163427.4193691-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.5-2
X-PR-Tracked-Commit-Id: 9730870b484e9de852b51df08a8b357b1129489e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c313761337fb8fa7fc44296f0e10844505916208
Message-Id: <169307203902.18628.8102755158821564804.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Aug 2023 17:47:19 +0000
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Sun, 27 Aug 2023 00:34:27 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c313761337fb8fa7fc44296f0e10844505916208

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
