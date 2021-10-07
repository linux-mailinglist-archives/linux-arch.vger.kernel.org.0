Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFEB425E3F
	for <lists+linux-arch@lfdr.de>; Thu,  7 Oct 2021 22:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhJGU6b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Oct 2021 16:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240908AbhJGU6P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Oct 2021 16:58:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 651BE61139;
        Thu,  7 Oct 2021 20:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633640181;
        bh=9FNZrKq30872pEDbd+LmCF+e5UiKVkB/V2/y4Gje5C8=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=a+4cBZwvbbMpbLewDRHgu+P+sB6s7SfTAwj5lR1jSc/shud0uQQZQmOzArAKHRrqj
         fv3g9JqWAWdNdlRsCJjHA0zSTK2KfDciuXj4fFPJ0ZboMCmhNrCCTG+8lJjPEOChiL
         m37IDepGFeztdWZKIoxVcXflZSdsTdWmUdzki3QUpilIYKYBrdSQy8MUe0NTVc7p8R
         HwWq0kqnO2D3UzHDlF8laZyyUEO4/x3TPpuDh/epzG84Dy1JWYsQmFcgWbu9OOs1JR
         J4gfX13bNb2KddOEUEfFJLi70kUbuOuyHSjVq/cl1u2ANPO74B3oHOGdDe14yU2sd3
         pvU2hZbQrinfQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 335225C0870; Thu,  7 Oct 2021 13:56:21 -0700 (PDT)
Date:   Thu, 7 Oct 2021 13:56:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Another possible use for LKMM, or a subset (strengthening) thereof
Message-ID: <20211007205621.GA584182@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

On the perhaps unlikely chance that this is new news of interest...

I have finally prototyped the full "So You Want to Rust the Linux
Kernel?" series (as in marked "under construction").

https://paulmck.livejournal.com/62436.html

							Thanx, Paul
