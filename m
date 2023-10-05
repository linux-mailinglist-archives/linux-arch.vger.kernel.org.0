Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655017BA753
	for <lists+linux-arch@lfdr.de>; Thu,  5 Oct 2023 19:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjJERIt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Oct 2023 13:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjJERHw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Oct 2023 13:07:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB7B1FC2;
        Thu,  5 Oct 2023 09:53:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04C4C433C7;
        Thu,  5 Oct 2023 16:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696524792;
        bh=QqFYej4zszOQ9dZXHQnUKqXBkmPZfqU3JS9WYFmKdmQ=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=jLxs7RQUwT/7fGOj6cQriRmgkLmIlXWgZAFYKosF74F9NyB3UNvErb1T/7nI/6Si9
         rOa2rY9VSOZHefnUmUNYKPJIdU4kUjwP0ovsyGfGN8ujImCgY4H4nfkAV9si2htizu
         Z2et/xgbnU3WOpSEPrnLeRW8WlHQ2iv998MuPOq9E03EBangBojAbKvsd96brKRVh9
         dMTTYS1YvFm7K721l139E0t65bYIaud8Cy5VC2gnAlCSFoJlzK8jZztudgCZM5hiF5
         P5BopJk+Zu62aXB7B2waSVrYNZwTl6mml8nl6FpmncMjY4JsSjAmruuQDOiY8OTHEJ
         qMJKOrKBZyGqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8157ACE0869; Thu,  5 Oct 2023 09:53:12 -0700 (PDT)
Date:   Thu, 5 Oct 2023 09:53:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH memory-model] docs: memory-barriers: Add note on compiler
 transformation and address deps
Message-ID: <ceaeba0a-fc30-4635-802a-668c859a58b2@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The compiler has the ability to cause misordering by destroying
address-dependency barriers if comparison operations are used. Add a
note about this to memory-barriers.txt in the beginning of both the
historical address-dependency sections and point to rcu-dereference.rst
for more information.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 06e14efd8662..d414e145f912 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -396,6 +396,10 @@ Memory barriers come in four basic varieties:
 
 
  (2) Address-dependency barriers (historical).
+     [!] This section is marked as HISTORICAL: For more up-to-date
+     information, including how compiler transformations related to pointer
+     comparisons can sometimes cause problems, see
+     Documentation/RCU/rcu_dereference.rst.
 
      An address-dependency barrier is a weaker form of read barrier.  In the
      case where two loads are performed such that the second depends on the
@@ -556,6 +560,9 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
 
 ADDRESS-DEPENDENCY BARRIERS (HISTORICAL)
 ----------------------------------------
+[!] This section is marked as HISTORICAL: For more up-to-date information,
+including how compiler transformations related to pointer comparisons can
+sometimes cause problems, see Documentation/RCU/rcu_dereference.rst.
 
 As of v4.15 of the Linux kernel, an smp_mb() was added to READ_ONCE() for
 DEC Alpha, which means that about the only people who need to pay attention
