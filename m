Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF745489F81
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 19:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242259AbiAJSru (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 13:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242257AbiAJSrt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 13:47:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6776CC06173F;
        Mon, 10 Jan 2022 10:47:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0298F61365;
        Mon, 10 Jan 2022 18:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9E4C36AF2;
        Mon, 10 Jan 2022 18:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641840468;
        bh=DDpzvqSF4GiMvUTNLx677u+GyarbmV64J5fRPJ4wpF0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=b957gY2L58crVRSNcmGOMFbbUjhZx6muIjxj5Yz5LgPNLy1oet0FvNix/8CETmG3r
         k/5WT+qcs1bh3YCgytte+VAFqCxPdrV394h6zCMeP8i/uEMhlYVpwkb9098EQuX9Zy
         +LCN/5qD6FI1i7at48ZtPfpY/T0wE4t5417CXQSvdUIUFoC7H7JQJu9Lyd4AqTir/+
         AsDqdhERxOf7C2GuERsXViilC13pReRueVfEBpuYB2cHftcRufqzv4NqExD/fQOSJb
         Fq0IEuR3yU4fKZlf1tfiEir4oLs4BI8y+y2aFNrI03WwGTmmKzczVnG071KeKu6bfw
         JEsbxri50Ug2g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0FDA75C0388; Mon, 10 Jan 2022 10:47:48 -0800 (PST)
Date:   Mon, 10 Jan 2022 10:47:48 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kernel-team@fb.com,
        boqun.feng@gmail.com
Subject: [GIT PULL] LKMM changes for v5.17
Message-ID: <20220110184748.GA1012883@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello, Linus,

Please pull the latest LKMM git tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2022.01.09a
  # HEAD: c438b7d860b4c1acb4ebff6d8d946d593ca5fe1e tools/memory-model: litmus: Add two tests for unlock(A)+lock(B) ordering

LKMM changes for this cycle were documentation and litmus tests for
locking.

----------------------------------------------------------------
Boqun Feng (3):
      tools/memory-model: Provide extra ordering for unlock+lock pair on the same CPU
      tools/memory-model: doc: Describe the requirement of the litmus-tests directory
      tools/memory-model: litmus: Add two tests for unlock(A)+lock(B) ordering

 tools/memory-model/Documentation/explanation.txt   | 44 ++++++++++++----------
 tools/memory-model/README                          | 12 ++++++
 tools/memory-model/linux-kernel.cat                |  6 +--
 .../LB+unlocklockonceonce+poacquireonce.litmus     | 35 +++++++++++++++++
 .../MP+unlocklockonceonce+fencermbonceonce.litmus  | 33 ++++++++++++++++
 tools/memory-model/litmus-tests/README             |  8 ++++
 6 files changed, 116 insertions(+), 22 deletions(-)
 create mode 100644 tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/MP+unlocklockonceonce+fencermbonceonce.litmus
