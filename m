Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE6953C0D7
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 00:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbiFBWgO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jun 2022 18:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239791AbiFBWgL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jun 2022 18:36:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D2F37A2A;
        Thu,  2 Jun 2022 15:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D63F617A8;
        Thu,  2 Jun 2022 22:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 032FEC34115;
        Thu,  2 Jun 2022 22:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654209370;
        bh=/5/cOs4/S70/niib/AJipEbO+5hR1Tn1b6J/+Xte87g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lBoYNKkS2IboQzSaX3jmL0So6qSkTXRJg6rWngcEpdHHBo8n5MA6PFETbvSBHRO6L
         v3ShFfRdIh9fYn6ocCzT+TNN0CPAYngKxNo3OxVgsmyIkVYcuOaWAUFMQnKFnWWYfo
         9d/urjnj6GWsSc/EPDvWhT4sg6Yh+xAFSXRL9kWgKy/MLMiV9HPIlNgAgn0BhgRoxb
         jM35iIa4arAo+KbiDFRiURfloxijeptxiYOS1kL9M9rHZok4C6xbN8LumZEKTkWphe
         nxc6yQnQD+a2kMHIMhV5K5GUSlnm8QKS/IW70dYml3mQIavEkbPMLUcWcOWg2OE4Xx
         tSFpu6ZmrOxAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E437FEAC09C;
        Thu,  2 Jun 2022 22:36:09 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic fixes for 5.19, part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a1Pi6qjx=7=363DvCCqMb-b=b9BtD+FMByopAwymC+2fA@mail.gmail.com>
References: <CAK8P3a1Pi6qjx=7=363DvCCqMb-b=b9BtD+FMByopAwymC+2fA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a1Pi6qjx=7=363DvCCqMb-b=b9BtD+FMByopAwymC+2fA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-5.19
X-PR-Tracked-Commit-Id: 8cc5b032240ae5220b62c689c20459d3e1825b2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: baf86ac1c9ccbde281df55a4daeefadec6d2e581
Message-Id: <165420936993.5886.5546642545837216429.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Jun 2022 22:36:09 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Thu, 2 Jun 2022 23:38:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-fixes-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/baf86ac1c9ccbde281df55a4daeefadec6d2e581

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
