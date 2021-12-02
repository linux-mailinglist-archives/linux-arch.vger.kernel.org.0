Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFE2465B65
	for <lists+linux-arch@lfdr.de>; Thu,  2 Dec 2021 01:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhLBAxx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Dec 2021 19:53:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43586 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbhLBAxv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Dec 2021 19:53:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E1D0B80DAC;
        Thu,  2 Dec 2021 00:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA097C00446;
        Thu,  2 Dec 2021 00:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638406227;
        bh=MMgsoq9/0/HVmpKPtq5En3YiaceVuZgx/9XCLc5cXSU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=OmNX4thOxqzJPC6JLh+0urpVobPGXu4Yc+AEBceUUvXC537wz/EyT21Xa8FE3HNgL
         nGeZzsI8npu371NSGOsxXz8A1Ad8nbZxzKwZ5zCB+1DVd8bdRMpdjBYQ6bxV15+MaO
         9Q/UcYqOUBXPu5ueew+4MWHWFcezFBRQnY2GmjBONugj1ar59FVp3wFeJ/w1SK4pA4
         aQNBa8GMl5XnUTxO8x8wqAZrnxoHPyPS8lNcXVClAOIZiZe4setF9cri+iZQHVTNah
         faL223BAE+Gmt3qw529X5AYpOaSsa7X5KHc2J2qkP3atfr6gCIdE64iSML36RZ0FGG
         nF6XqpySt4vTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8D0A25C0FCD; Wed,  1 Dec 2021 16:50:27 -0800 (PST)
Date:   Wed, 1 Dec 2021 16:50:27 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: [PATCH memory-model 0/3] LKMM updates for v5.17
Message-ID: <20211202005027.GA3130970@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

This series provides additional documentation and examples for the
Linux-kernel memory model (LKMM):

1.	Provide extra ordering for unlock+lock pair on the same CPU,
	courtesy of Boqun Feng.

2.	Describe the requirement of the litmus-tests directory, courtesy
	of Boqun Feng.

3.	Add two tests for unlock(A)+lock(B) ordering, courtesy of
	Boqun Feng.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/explanation.txt                              |   44 +++++++------
 README                                                     |   12 +++
 linux-kernel.cat                                           |    6 -
 litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus    |   35 ++++++++++
 litmus-tests/MP+unlocklockonceonce+fencermbonceonce.litmus |   33 +++++++++
 litmus-tests/README                                        |    8 ++
 6 files changed, 116 insertions(+), 22 deletions(-)
