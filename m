Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37495F348F
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 19:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiJCRdE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 13:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJCRcS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 13:32:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555043D59E;
        Mon,  3 Oct 2022 10:32:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0300C61192;
        Mon,  3 Oct 2022 17:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62B6BC43140;
        Mon,  3 Oct 2022 17:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664818324;
        bh=tZsJ9+Vi9pGd4vTNYqpsJX2DHSCQM7DqgZ7k5ek1xfE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iLZJ4B/m5JvZUFe+AXxwIvwVKttbnTR8PaoBtRo8ICPq5rQaRzSiPRGpjW5bu+vnP
         HF07ahGDuB/q3VyXwJhvleytN4uYif3hPyOXPyS6Ycouivg8aqn/wetJH+M85P7xe2
         Dxu9qhEYUEqDbUmY3DJdjo0fEzL/6dwhCVSpsbkhd4hrLXptHtoZNTEcbIfG963FBl
         mjnfAxydui0TEI+CTZroPCnzQgU5+4mSs6R/a0J8xBoKwnK4CB5wdGJJLeTT9wdCc/
         GXfwGLrNL9xtZKXotpiDqyzgTlx6XQm1B54kHe92m+wNDjgOsf+F7HqEOKX+7ZGBWg
         I50A5N96bFVBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4BCC4E49FA7;
        Mon,  3 Oct 2022 17:32:04 +0000 (UTC)
Subject: Re: [GIT PULL] LKMM changes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221002033116.GA3513193@paulmck-ThinkPad-P17-Gen-1>
References: <20221002033116.GA3513193@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221002033116.GA3513193@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2022.09.30a
X-PR-Tracked-Commit-Id: be94ecf7608cc11ff46442012e710bb8fb139b99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8fb65e1d33206f78ad62e10ceb93095ecac24a6
Message-Id: <166481832430.20277.11033503811235636162.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Oct 2022 17:32:04 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kernel-team@fb.com, akiyks@gmail.com,
        paul.heidekrueger@in.tum.de
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Sat, 1 Oct 2022 20:31:16 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2022.09.30a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8fb65e1d33206f78ad62e10ceb93095ecac24a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
