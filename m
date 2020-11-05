Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18D42A895E
	for <lists+linux-arch@lfdr.de>; Thu,  5 Nov 2020 22:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbgKEV7z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Nov 2020 16:59:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732465AbgKEV7z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Nov 2020 16:59:55 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D68D20735;
        Thu,  5 Nov 2020 21:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604613594;
        bh=mHwE2Ksv0agaU+4qRkga8mn5jqkPivZPjaS1Pd5JKJs=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=WBHrYhXmdOeqyf/nKrtQVU7mr7yZyXZi+IwWFYHwJLixdZcbchTMCc9kd5gqCN7Mf
         oF0yU2bYE8Gi4vHDE69Im0oBV9xDvVaOa5iMkKP8muTdW3HmVMjuQeDphdlKw8w1YB
         T/nBYwW9CP67T5wEN/im+qDHsDD4xbTHN9mSvnsM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A9B5B3522A76; Thu,  5 Nov 2020 13:59:53 -0800 (PST)
Date:   Thu, 5 Nov 2020 13:59:53 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: [PATCH memory-model 0/8] LKMM updates for v5.11
Message-ID: <20201105215953.GA15309@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

This series provides LKMM updates:

1.	Document that the LKMM can easily miss control dependencies.

2.	Move Documentation description to Documentation/README.

3.	Document categories of ordering primitives.

4.	Fix a typo in CPU MEMORY BARRIERS section.

5.	Add a glossary of LKMM terms.

6.	Add types to litmus tests.

7.	Use "buf" and "flag" for message-passing tests.

8.	Label MP tests' producers and consumers.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/memory-barriers.txt                                                          |    2 
 tools/memory-model/Documentation/README                                                    |   78 +
 tools/memory-model/Documentation/control-dependencies.txt                                  |  258 ++++
 tools/memory-model/Documentation/glossary.txt                                              |  155 ++
 tools/memory-model/Documentation/litmus-tests.txt                                          |   17 
 tools/memory-model/Documentation/ordering.txt                                              |  557 ++++++++++
 tools/memory-model/README                                                                  |   22 
 tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus                                |    4 
 tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus                                |    4 
 tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus                                |    4 
 tools/memory-model/litmus-tests/CoWW+poonceonce.litmus                                     |    4 
 tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus                      |    5 
 tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus                           |    5 
 tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus                 |    7 
 tools/memory-model/litmus-tests/ISA2+poonceonces.litmus                                    |    6 
 tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus   |    6 
 tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus                     |    5 
 tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus                      |    5 
 tools/memory-model/litmus-tests/LB+poonceonces.litmus                                      |    5 
 tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus                |   27 
 tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus                             |   23 
 tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus                     |    8 
 tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus                       |    8 
 tools/memory-model/litmus-tests/MP+polocks.litmus                                          |   28 
 tools/memory-model/litmus-tests/MP+poonceonces.litmus                                      |   27 
 tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus                      |   27 
 tools/memory-model/litmus-tests/MP+porevlocks.litmus                                       |   28 
 tools/memory-model/litmus-tests/R+fencembonceonces.litmus                                  |    5 
 tools/memory-model/litmus-tests/R+poonceonces.litmus                                       |    5 
 tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus                    |    5 
 tools/memory-model/litmus-tests/S+poonceonces.litmus                                       |    5 
 tools/memory-model/litmus-tests/SB+fencembonceonces.litmus                                 |    5 
 tools/memory-model/litmus-tests/SB+poonceonces.litmus                                      |    5 
 tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus                          |    5 
 tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus                                |    5 
 tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus             |    5 
 tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus                 |    7 
 tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus                 |    7 
 tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus |    6 
 39 files changed, 1267 insertions(+), 123 deletions(-)
