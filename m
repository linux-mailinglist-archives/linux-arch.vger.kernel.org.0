Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292E45A6EE0
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 23:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiH3VJJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 17:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiH3VJI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 17:09:08 -0400
Received: from mailout3.rbg.tum.de (mailout3.rbg.tum.de [131.159.0.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3968673C;
        Tue, 30 Aug 2022 14:09:06 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [131.159.254.14])
        by mailout3.rbg.tum.de (Postfix) with ESMTPS id 156C710120F;
        Tue, 30 Aug 2022 23:09:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1661893745;
        bh=YAJ7fj0G0bS7GRv2z/MS0hK+fJW+C4CoPmHf8Fqd6D0=;
        h=From:To:Cc:Subject:Date:From;
        b=RCknEi4jgzq4feRg0OerKgsOnd1y0RfLAVauCALzE9Y42bulA5nLXGEyfHEMiPjJZ
         5ptNnYp2mbhqt8KBwebgVnzCN+flncnOOD+6K049gc07qle/0fPST/gPnQNTDsj1p4
         rDlJX7VfuN/IYJULtEd4LQIQw+RK/xYfLN0v9bI203T3ZtQ2lCq0edPuDGO1RRXmvH
         AxoQpX2k5lCa29PgSfv/oWxMpQzWPlzeGF3LDCIANBIYowFG/sxyfPaSCNNMSutxi2
         G4y5O6s1fJxP+ovKUxl2yLcI99FZq8m4JXH0/ww+xZwIn01FdK0d7tMVybRqirsV+A
         oL3BmkNQsAX2Q==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 11161544; Tue, 30 Aug 2022 23:09:05 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id E237D542;
        Tue, 30 Aug 2022 23:09:04 +0200 (CEST)
Received: from mail.in.tum.de (vmrbg426.in.tum.de [131.159.0.73])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id DDD6822;
        Tue, 30 Aug 2022 23:09:04 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id DA8424A05EF; Tue, 30 Aug 2022 23:09:04 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id 8015D4A0549;
        Tue, 30 Aug 2022 23:09:04 +0200 (CEST)
        (Extended-Queue-bit xtech_dt@fff.in.tum.de)
From:   =?UTF-8?q?Paul=20Heidekr=C3=BCger?= <paul.heidekrueger@in.tum.de>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        =?UTF-8?q?Paul=20Heidekr=C3=BCger?= <paul.heidekrueger@in.tum.de>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Subject: [PATCH v2] tools/memory-model: Weaken ctrl dependency definition in explanation.txt
Date:   Tue, 30 Aug 2022 21:08:20 +0000
Message-Id: <20220830210821.3763660-1-paul.heidekrueger@in.tum.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The current informal control dependency definition in explanation.txt is
too broad and, as discussed, needs to be updated.

Consider the following example:

> if(READ_ONCE(x))
>   return 42;
>
> WRITE_ONCE(y, 42);
>
> return 21;

The read event determines whether the write event will be executed "at
all" - as per the current definition - but the formal LKMM does not
recognize this as a control dependency.

Introduce a new definition which includes the requirement for the second
memory access event to syntactically lie within the arm of a non-loop
conditional.

Link: https://lore.kernel.org/all/20220615114330.2573952-1-paul.heidekrueger@in.tum.de/
Cc: Marco Elver <elver@google.com>
Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
Cc: Martin Fink <martin.fink@in.tum.de>
Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
---

v2:
- Fix typos
- Fix indentation of code snippet

v1:
@Alan, since I got it wrong the last time, I'm adding you as a co-developer after my
SOB. I'm sorry if this creates extra work on your side due to you having to
resubmit the patch now with your SOB if I understand correctly, but since it's
based on your wording from the other thread, I definitely wanted to give you
credit.

 tools/memory-model/Documentation/explanation.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index ee819a402b69..0bca50cac5f4 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -464,9 +464,10 @@ to address dependencies, since the address of a location accessed
 through a pointer will depend on the value read earlier from that
 pointer.

-Finally, a read event and another memory access event are linked by a
-control dependency if the value obtained by the read affects whether
-the second event is executed at all.  Simple example:
+Finally, a read event X and another memory access event Y are linked by
+a control dependency if Y syntactically lies within an arm of an if,
+else or switch statement and the condition guarding Y is either data or
+address-dependent on X.  Simple example:

 	int x, y;

--
2.35.1

