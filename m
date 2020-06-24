Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4BE207BCE
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 20:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406194AbgFXSyB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 14:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406033AbgFXSyB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 14:54:01 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E6CB20702;
        Wed, 24 Jun 2020 18:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593024841;
        bh=9aeM0ykXHtgDA3GqA6iQnzG2q1WxV6iB9AZlbM12N6M=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=JgPpHaUeHThKOfHkHRFEq65iiz9rOqFlI99toCVLZkSWYlptPGeiueQhQtQ+H3Wa0
         jekyxpju13HRaN6diayh7I9sMp3ZdiMbxC/GwFddNL+jVVmD0xAsm7v7+lYb7qqcE4
         45MoABjJ4gHkbjZEWmMrzz0QkC3k9nFsn4itbUTQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id ED4B135228BC; Wed, 24 Jun 2020 11:54:00 -0700 (PDT)
Date:   Wed, 24 Jun 2020 11:54:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: LKMM patches for next merge window
Message-ID: <20200624185400.GA13594@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

Here is the list of LKMM patches I am considering for the next merge
window and the status of each.  Any I am missing or any that need to
wait or be modified?

						Thanx, Paul

------------------------------------------------------------------------

3ce5d69 docs: fix references for DMA*.txt files
	Could someone please provide an ack?

ac1a749 tools/memory-model: Add recent references
be1ce3e tools/memory-model: Fix "conflict" definition
24dca63 Documentation: LKMM: Add litmus test for RCU GP guarantee where updater frees object
47ec95b Documentation: LKMM: Add litmus test for RCU GP guarantee where reader stores
bb2c938 MAINTAINERS: Update maintainers for new Documentation/litmus-tests
05bee9a tools/memory-model: Add an exception for limitations on _unless() family
dc76257 Documentation/litmus-tests: Introduce atomic directory
d059e50 Documentation/litmus-tests/atomic: Add a test for atomic_set()
7eecf76 Documentation/litmus-tests/atomic: Add a test for smp_mb__after_atomic()
116f054 tools/memory-model: Fix reference to litmus test in recipes.txt
ffd32d4 Documentation/litmus-tests: Merge atomic's README into top-level one
a08ae99 Documentation/litmus-tests: Cite an RCU litmus test
843285eb tools/memory-model/README: Expand dependency of klitmus7
0296c57 tools/memory-model/README: Mention herdtools7 7.56 in compatibility table
47e4f0a Documentation/litmus-tests: Add note on herd7 7.56 in atomic litmus test
	All ready to go.
