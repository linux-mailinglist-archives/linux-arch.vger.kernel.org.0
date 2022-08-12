Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EE159147C
	for <lists+linux-arch@lfdr.de>; Fri, 12 Aug 2022 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbiHLQ7d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Aug 2022 12:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239501AbiHLQ7c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Aug 2022 12:59:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEC0B14CE;
        Fri, 12 Aug 2022 09:59:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80087B824BC;
        Fri, 12 Aug 2022 16:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2707CC433C1;
        Fri, 12 Aug 2022 16:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660323568;
        bh=/NbibNSjBiaNNE/GRC4vNh2B7UucCEwDLgHVEeyPnk0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rREFGGC59XPoE602SOSfiudmVGO2DVBY1fKEOW642+pP9e72DzmWxETPrH2JRgbTr
         R5efR+ftQxaZ5pAosUrcIgZqEQODKo6YAG03YQSYuingeX9h//T3itH9o99W8qTDUX
         RoMwkXjLIt3SANRuAb8/nnhTsOsFc+/4bSCm+Tq2t6ezBFqL+9FEw+bZbPJn2zzWTi
         MHxrnWfjviOXmWfYKrNrmi/RQHUvJF/FQLNVnImENjpGk7FbuW/74iOgPGf96dzoj2
         dshj4hyYNZOuVtyzi/uuSPK9AudJyzvbLwIWLxiQVK+ukbypwDiJcCtDr18Zlops55
         LUY908bIqCQpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14A4AC43141;
        Fri, 12 Aug 2022 16:59:28 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch changes for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220812072403.3075518-1-chenhuacai@loongson.cn>
References: <20220812072403.3075518-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220812072403.3075518-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-5.20
X-PR-Tracked-Commit-Id: 715355922212a3be8bfe5a94b5707a045ac6bf00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 999324f58c41262f5b64d04b7ac54e8f79b019fd
Message-Id: <166032356807.14629.13071109960950383291.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Aug 2022 16:59:28 +0000
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Fri, 12 Aug 2022 15:24:03 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/999324f58c41262f5b64d04b7ac54e8f79b019fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
