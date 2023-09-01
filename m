Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AB878FFE8
	for <lists+linux-arch@lfdr.de>; Fri,  1 Sep 2023 17:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350258AbjIAPXx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Sep 2023 11:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344743AbjIAPXx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Sep 2023 11:23:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1321989;
        Fri,  1 Sep 2023 08:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D567AB825B6;
        Fri,  1 Sep 2023 15:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DF19C433C8;
        Fri,  1 Sep 2023 15:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693581782;
        bh=gGqbDIMBz9FbG0U2QaJi2tGmbVdi+w66WMgNKE0R8Tc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Tn6iuLmZYD+zdJJZwTZW2l1yTAw9rnjZ9Qo60EaTHd+lYybpxgdCEb6JvMhwjGrSl
         CltSmdlymAcJUnqevyu7OSAueUfPhb4CRWAhK5sF5V0mYS1O8QWfVqgnHPdJPq4swe
         k0LMjbRACw05fQ+pZMiETdqKEfJJTRhx57o4yF+X4HemvQULvxXYKlISX2NYsREKwA
         pNiXglybrjsSDswfwynEmoZOm6zftZr4FBa8GDyjdoxVt5VP1qDYCc99O3BezHw3iz
         dlAQSUgWGQylHsuP8/PI6qb8+ApRCmqOzExdNJQVldZOTO2Cklbu6tfOuJBo4stgT5
         ospZaE1Ei0RrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A759C64457;
        Fri,  1 Sep 2023 15:23:02 +0000 (UTC)
Subject: Re: [GIT PULL] csky 2nd changes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230901014548.2885411-1-guoren@kernel.org>
References: <20230901014548.2885411-1-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230901014548.2885411-1-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.6-2
X-PR-Tracked-Commit-Id: 5195c35ac4f09bc45bde23b98d74c4f5d62bea65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a031eba2956863457b2680453ca45515a1605a47
Message-Id: <169358178242.20073.11700166183232359350.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Sep 2023 15:23:02 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, guoren@kernel.org,
        sudipm.mukherjee@gmail.com, linux@roeck-us.net, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Thu, 31 Aug 2023 21:45:48 -0400:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a031eba2956863457b2680453ca45515a1605a47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
