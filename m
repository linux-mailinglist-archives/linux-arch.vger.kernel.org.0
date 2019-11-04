Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2F8FEE504
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2019 17:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfKDQqN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Nov 2019 11:46:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:37568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbfKDQqN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Nov 2019 11:46:13 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [109.144.216.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCB8F2084D;
        Mon,  4 Nov 2019 16:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572885972;
        bh=yRy4ztUfiIp29RF04qDxunmGS4r04xznYOSlx4FBNYg=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=FEhqNsMVeHOHF1/vaESWt8+j8RP/UnxvwJ+BRpvMcZjaXJGVUycj5XyxLm8cE6wNR
         iccWRFiodPXaMlOf1ZeHZ9MXosA4e6MyUIQ/qWo482rPapVV90rUl+Hs1w0cqxBDzq
         WOIv+BS8F2ypHsMivfwQIGDlGgruMOaIiw8CsDxA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C44703520B56; Mon,  4 Nov 2019 08:46:10 -0800 (PST)
Date:   Mon, 4 Nov 2019 08:46:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     michalis@mpi-sws.org, viktor@mpi-sws.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        paulmck@kernel.org, akiyks@gmail.com, dlustig@nvidia.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: LKMM email introduction
Message-ID: <20191104164610.GA5997@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Michalis and Viktor are interested in implementing LKMM (or some
approximation thereof) in their tool, and are therefore interested in
locating the relevant litmus tests.  They already know about these:

1) https://github.com/paulmckrcu/litmus
2)    https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/tree/tools/memory-model/litmus-tests?h=dev
3) http://diy.inria.fr/linux

Are there any additional existing litmus tests that they should be using?

								Thanx, Paul
