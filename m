Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84276F76F9
	for <lists+linux-arch@lfdr.de>; Thu,  4 May 2023 22:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjEDU1p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 16:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjEDU13 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 16:27:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D702E070;
        Thu,  4 May 2023 13:13:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB06563847;
        Thu,  4 May 2023 19:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 083FEC4331D;
        Thu,  4 May 2023 19:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229787;
        bh=5is9BJh48Sh8OU1to9aD+FXYypeVd0rC97qk9+V8flg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GiKQ8WQhQyreZNSuV6lU2qOEkmaMczFIZbgBXAgYNyCYokNKFYaFop6OAsF+QjcGq
         oJNQ9mSBUk9yfq8AyYigY30hP8UTyiEgeM6w1T/gqNwVNmwhnp87zMJkfuJOniKaGU
         elHRP+KAAt8WFRuqZ2twTyZdFDqxcFUdsNgbyASEJRIfl86JlKFgmr0aT2+3UKI/0O
         LB1S8crTgcrMOLadeIijt1P58ajq55WYVOkSfb/xbSJtga8hchf98W7yNHcD9XEN36
         2cicX5cffd+vSKKkd7oJooFbigSr+7lJHkloGRKeGf8lOtDbMS1P1GQjSSbxJzahNx
         QQjP81478Hrww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5C82E5FFC4;
        Thu,  4 May 2023 19:49:46 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230504125409.2444851-1-chenhuacai@loongson.cn>
References: <20230504125409.2444851-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230504125409.2444851-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.4
X-PR-Tracked-Commit-Id: 2fa5ebe3bc4e31e07a99196455498472417842f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 611c9d88302cb9ac3b0f58f4a06c0ffb98345bd2
Message-Id: <168322978693.14542.16341768166165628811.pr-tracker-bot@kernel.org>
Date:   Thu, 04 May 2023 19:49:46 +0000
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Thu,  4 May 2023 20:54:09 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/611c9d88302cb9ac3b0f58f4a06c0ffb98345bd2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
