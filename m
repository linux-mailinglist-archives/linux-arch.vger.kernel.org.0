Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E6C7990AD
	for <lists+linux-arch@lfdr.de>; Fri,  8 Sep 2023 22:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344195AbjIHUAx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Sep 2023 16:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344400AbjIHUAw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Sep 2023 16:00:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CE719E;
        Fri,  8 Sep 2023 13:00:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77E20C433C8;
        Fri,  8 Sep 2023 20:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694203248;
        bh=0vF/X3Kmxk7/aj4kXVSzGS3bk6LKEcBkSL/evpzKV6A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Dr+h+zqapPq8JkotK1uYBlV/dy9dNrA8jp5J47U98PMPJckm4N2x37nI5M2Gw6cCR
         8+SBDglB7yFMJItvpvVTArgqNMFdNaUB/u4+uaoF6C3bx1r411I/ubniODD7VfblLG
         hidRsL+1u8yb5AWu12l0kZ8DROr4I3bDMTMLBw2HD6iBNe/K9uDW520jvLCXyXBFMJ
         lUvkcNxMFjA+DjIzIyav5nX8pvEoMVWh4i0vug7zHaTiYdj6JIrr5SeqtI1PkJZoCS
         PkNCK5smlRRn+Bnb+GtWmQv/03rwSDng3GGEyWBi3djE09MSDI5MDsb88Y3yljEPyY
         mN24D822VjhBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64A91E29F36;
        Fri,  8 Sep 2023 20:00:48 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch changes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230908111053.1660033-1-chenhuacai@loongson.cn>
References: <20230908111053.1660033-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20230908111053.1660033-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.6
X-PR-Tracked-Commit-Id: 671eae93ae2090d2df01d810d354cab05f6bed8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12952b6bbd36b372345f179f1a85576c5924d425
Message-Id: <169420324840.9132.7799052693511343279.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Sep 2023 20:00:48 +0000
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

The pull request you sent on Fri,  8 Sep 2023 19:10:53 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12952b6bbd36b372345f179f1a85576c5924d425

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
