Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66412580D6
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 20:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgHaSUP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 14:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbgHaSUN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Aug 2020 14:20:13 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB3162071B;
        Mon, 31 Aug 2020 18:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598898012;
        bh=ir5FAiud93uwo1OKIFQqrEWn5+D6Fa+w/RKXoKxVk9w=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=mADWsSBHfd0wwrDhed0VExYB2tn4u6wQ9Tevd3NH8ua+Sm1kWqrfnnvBX7OsLXF+m
         wXsppRzAPAqBKadjWikurCtNroyfA0khT+3m1pRAo21dFYcbc4kS8wPIXmjFcokO2I
         S4i5HRgVyS+a+6Qqm7mMaDbzcm2+q2V4srdHRnXs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 908BA35230F1; Mon, 31 Aug 2020 11:20:12 -0700 (PDT)
Date:   Mon, 31 Aug 2020 11:20:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: [PATCH memory-model 0/9] LKMM updates for v5.10
Message-ID: <20200831182012.GA1965@paulmck-ThinkPad-P72>
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

This series provides LKMM updates:

1.	fix references for DMA*.txt files.

2.	Replace HTTP links with HTTPS ones: LKMM.

3.	tools/memory-model: Update recipes.txt prime_numbers.c path.

4.	tools/memory-model: Improve litmus-test documentation.

5.	tools/memory-model: Add a simple entry point document.

6.	tools/memory-model: Expand the cheatsheet.txt notion of relaxed.

7.	tools/memory-model: Move Documentation description to
	Documentation/README.

8.	tools/memory-model: Document categories of ordering primitives.

9.	tools/memory-model:  Document locking corner cases.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/litmus-tests/locking/DCL-broken.litmus |   55 
 Documentation/litmus-tests/locking/DCL-fixed.litmus  |   56 
 Documentation/litmus-tests/locking/RM-broken.litmus  |   42 
 Documentation/litmus-tests/locking/RM-fixed.litmus   |   42 
 Documentation/memory-barriers.txt                    |    6 
 tools/memory-model/Documentation/README              |   86 +
 tools/memory-model/Documentation/cheatsheet.txt      |   27 
 tools/memory-model/Documentation/litmus-tests.txt    | 1078 ++++++++++++++++++-
 tools/memory-model/Documentation/locking.txt         |  320 +++++
 tools/memory-model/Documentation/ordering.txt        |  462 ++++++++
 tools/memory-model/Documentation/recipes.txt         |    4 
 tools/memory-model/Documentation/references.txt      |    2 
 tools/memory-model/Documentation/simple.txt          |  271 ++++
 tools/memory-model/README                            |  182 ---
 tools/memory-model/control-dependencies.txt          |  256 ++++
 15 files changed, 2730 insertions(+), 159 deletions(-)
