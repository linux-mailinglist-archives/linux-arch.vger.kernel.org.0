Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8354650D43
	for <lists+linux-arch@lfdr.de>; Mon, 19 Dec 2022 15:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiLSOaT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Dec 2022 09:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiLSOaH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Dec 2022 09:30:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F72C3B;
        Mon, 19 Dec 2022 06:30:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7631B80D25;
        Mon, 19 Dec 2022 14:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EDC9C433F0;
        Mon, 19 Dec 2022 14:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671460203;
        bh=eRMSGKZ17Vvg9Cpx3kg7ABmn+nrapUSMgHog2rQO8w4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Jnddha4M4pvlzMlVBn7BKKx2oSBqM7WuR6TpGYvkn5SRe35OmCSP2iHdmvZ8xE0UM
         jiFPQiXfdNNGp2yMR0dE/cRPb39Mua52Z1RpbDaW5oI4tniorVYdVH7WzsK05DMXt1
         sp7Z9edv6O432tYp9alPpMkEg/NXkbWedRjiFtyVZyESxdyKJJsAqc1Sw0FQK8IBA6
         YmhimpqrxPeHnxY8NMVnrwL+RiSiQDhwbIYlmfGCPWx2sZji58y83FDGZ6iw7H0wk7
         YVp78oeMUiVD2K5FQQ2xsYzNUhY/jESaATWUEVl2L6puLEoX7oTdeMb3VZm9Co17Z4
         91cN1WR3NjZbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D202E21EEE;
        Mon, 19 Dec 2022 14:30:03 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch changes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221219120612.1637267-1-chenhuacai@loongson.cn>
References: <20221219120612.1637267-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20221219120612.1637267-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.2
X-PR-Tracked-Commit-Id: 5535f4f70cfc15ef55b6ea7c7e17337b17337cb6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f26e424552efd50722f4cf61f7f080373adbb1e
Message-Id: <167146020334.28969.2711278774891814084.pr-tracker-bot@kernel.org>
Date:   Mon, 19 Dec 2022 14:30:03 +0000
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Mon, 19 Dec 2022 20:06:12 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f26e424552efd50722f4cf61f7f080373adbb1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
