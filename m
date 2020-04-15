Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1C11AB131
	for <lists+linux-arch@lfdr.de>; Wed, 15 Apr 2020 21:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411753AbgDOTHu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Apr 2020 15:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416856AbgDOStT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 14:49:19 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40D7E206D9;
        Wed, 15 Apr 2020 18:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586976559;
        bh=S98H4OZ9/YsrWEVe/IIENSlY26f1OB+qSia2vPJuvjs=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ebTlzzEHyQYHpHkf75D1edXDhmOSOJVix5WtArVMqhdhdIknQ0v6FmtwqBlJnifWF
         DFCbsxtelq9w+iVA+2oQQLvzY5JJHKS6k6EfpFWrj6AoULYAsujuS7Ej3rJVPlETQt
         MvYAkhH83mqQK7g2NM9uZWA3vzT7b/HoZNZF0EzM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0A2D93522AD1; Wed, 15 Apr 2020 11:49:19 -0700 (PDT)
Date:   Wed, 15 Apr 2020 11:49:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: [PATCH memory-model 0/10] LKMM updates for v5.8
Message-ID: <20200415184918.GA16301@paulmck-ThinkPad-P72>
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

This series contains LKMM updates:

1.	Add recent references.

2.	Fix "conflict" definition, courtesy of Marco Elver.

3.	Move MP+onceassign+derefonce to new litmus-tests/rcu/, courtesy
	of Joel Fernandes.

4.	Add litmus test for RCU GP guarantee where updater frees object,
	courtesy of Joel Fernandes.

5.	Add litmus test for RCU GP guarantee where reader stores, courtesy
	of Joel Fernandes.

6.	Update maintainers for new Documentaion/litmus-tests/, courtesy of
	Joel Fernandes.

7.	Add an exception for limitations on _unless() family, courtesy of
	Boqun Feng.

8.	Introduce an atomic directory in Documentation, courtesy of Boqun
	Feng.

9.	Add a test for atomic_set(), courtesy of Boqun Feng.

10.	Add a test for smp_mb__after_atomic(), courtesy of Boqun Feng.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/atomic_t.txt                                                                    |   24 +-
 Documentation/litmus-tests/README                                                             |   14 +
 Documentation/litmus-tests/atomic/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus |   32 +++
 Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus             |   24 ++
 Documentation/litmus-tests/atomic/README                                                      |   16 +
 Documentation/litmus-tests/rcu/RCU+sync+free.litmus                                           |   42 +++++
 Documentation/litmus-tests/rcu/RCU+sync+read.litmus                                           |   37 ++++
 MAINTAINERS                                                                                   |    2 
 tools/memory-model/Documentation/explanation.txt                                              |   83 +++++-----
 tools/memory-model/Documentation/references.txt                                               |   21 ++
 tools/memory-model/README                                                                     |   10 -
 tools/memory-model/litmus-tests/README                                                        |    3 
 12 files changed, 250 insertions(+), 58 deletions(-)
