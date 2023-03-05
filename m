Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768546AB1E6
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 20:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjCETh0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 14:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCEThX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 14:37:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66E910270;
        Sun,  5 Mar 2023 11:37:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71EDD60AF9;
        Sun,  5 Mar 2023 19:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1378C433D2;
        Sun,  5 Mar 2023 19:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678045041;
        bh=gu4SRTD/SC+m/XuEgo5RPPjxEIyU4Yz60uvmiW/iiNk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hjx9k9jU9JkL1fa3XACbpml5ypXIWbyLBvg875DZcYRv8CjccvyDUg1jEGyAsTRYb
         9GasV7xkRCMytnvdobh3Vk2Srb3GJrSL9B/weUd2L+j9K/f1WrRr8xAUrEMgwCxkx0
         GdmTDjDHjoQbGwkK439ns4I7XsvB6vV68kVbv0tdFQDfoThFY3A8r891sp4C/6k074
         9eSe75IBn5wrS/nozQTqF5njN8fVhovFpQnfL6g5XXuNuK6kk1LO2nr+0dSD8ZjBLV
         moaJDLNCp5PWzor0RahsN16rrrfNJO6fonWH5B1mB20W8urOAR0HsBKqMnszCOMa6P
         GaP0ZzITOpN+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C02A8C41679;
        Sun,  5 Mar 2023 19:37:21 +0000 (UTC)
Subject: Re: [git pull] VM_FAULT_RETRY fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZAP6IvbWaNjPthCq@ZenIV>
References: <ZAP6IvbWaNjPthCq@ZenIV>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZAP6IvbWaNjPthCq@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: caa82ae7ef52b7cf5f80a2b2fbcbdbcfd16426cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a8d05a726dc5b82e608f0962511e15fcbcab1ab
Message-Id: <167804504178.1860.13031058916643663964.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Mar 2023 19:37:21 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Sun, 5 Mar 2023 02:10:42 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a8d05a726dc5b82e608f0962511e15fcbcab1ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
