Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942A054C7A8
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jun 2022 13:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbiFOLoG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jun 2022 07:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347117AbiFOLno (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jun 2022 07:43:44 -0400
Received: from mailout3.rbg.tum.de (mailout3.rbg.tum.de [131.159.0.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB5927CF6;
        Wed, 15 Jun 2022 04:43:43 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [131.159.254.14])
        by mailout3.rbg.tum.de (Postfix) with ESMTPS id 3D867100241;
        Wed, 15 Jun 2022 13:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1655293421;
        bh=2kjF4oxVy3r0fd0SR9Tiy0/qNbtSE87Bz7BjdDbE1WQ=;
        h=From:To:Cc:Subject:Date:From;
        b=NQ3JEMN2ZHuNO/jk9Av7B/H/0KpYlcVLlKXKDbQyjFUGHSs9eA9lMK8Lb5Slu6MdY
         HcTOP24C86scrmcGGk01sFNf5waZuYfo0K92v+lEx6j2EFBxU6rqq3RmGOzrcfu0m3
         hA/W9Q7JcCktMgWsoA4AP/p4CRaZz1jgznKU8IAd6uN9NTQwaHKiKLXZAoGFXruKg+
         7vbzwsy69l+TbNglfkS+nBbSJPe2tw3NYT13otO1+Ca4Dn6otyByXM0zhnI1rqfS4W
         kWyMb7r4EliCIh4QwQdEJS00rR1dWRg/4hM1staWVoKKc2EAFsRIF1x0aygVIyunKK
         pX9cOhuqMCCtw==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 3D0B1DD; Wed, 15 Jun 2022 13:43:41 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id 198DED6;
        Wed, 15 Jun 2022 13:43:41 +0200 (CEST)
Received: from mail.in.tum.de (vmrbg426.in.tum.de [131.159.0.73])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 14250CE;
        Wed, 15 Jun 2022 13:43:41 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 087424A0220; Wed, 15 Jun 2022 13:43:41 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id A477F4A01E7;
        Wed, 15 Jun 2022 13:43:40 +0200 (CEST)
        (Extended-Queue-bit xtech_ko@fff.in.tum.de)
From:   =?UTF-8?q?Paul=20Heidekr=C3=BCger?= <paul.heidekrueger@in.tum.de>
To:     llvm@lists.linux.dev, linux-toolchains@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?q?Paul=20Heidekr=C3=BCger?= <paul.heidekrueger@in.tum.de>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Subject: [PATCH RFC] tools/memory-model: Adjust ctrl dependency definition
Date:   Wed, 15 Jun 2022 11:43:29 +0000
Message-Id: <20220615114330.2573952-1-paul.heidekrueger@in.tum.de>
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

Hi all,

I have been confused by explanation.txt's definition of control
dependencies:

> Finally, a read event and another memory access event are linked by a
> control dependency if the value obtained by the read affects whether
> the second event is executed at all.

I'll go into the following:

====
1. "At all", to me, is misleading
  1.1 The code which confused me
  1.2 The traditional definition via post-dominance doesn't work either
2. Solution
====

1. "At all", to me, is misleading:

"At all" to me suggests a question for which we require a definitive
"yes" or "no" answer: given a programme and an input, can a certain
piece of code be executed? Can we always answer this this question?
Doesn't this sound similar to the halting problem?

1.1 The Example which confused me:

For the dependency checker project [1], I've been thinking about
tracking dependency chains in code, and I stumbled upon the following
edge case, which made me question the "at all" part of the current
definition. The below C-code is derived from some optimised kernel code
in LLVM intermediate representation (IR) I encountered:

> int *x, *y;
>
> int foo()
> {
> /* More code */
>
> 	 loop:
> 		/* More code */
>
> 	 	if(READ_ONCE(x)) {
> 	 		WRITE_ONCE(y, 42);
> 	 		return 0;
> 	 	}
>
> 		/* More code */
>
> 	 	goto loop;
>
>       /* More code */
> }

Assuming that foo() will return, the READ_ONCE() does not determine
whether the WRITE_ONCE() will be executed __at all__, as it will be
executed exactly when the function returns, instead, it determines
__when__ the WRITE_ONCE() will be executed.

1.2. The definition via post-dominance doesn't work either:

I have seen control dependencies being defined in terms of the first
basic block that post-dominates the basic block of the if-condition,
that is the first basic block control flow must take to reach the
function return regardless of what the if condition returned.

E.g. [2] defines control dependencies as follows:

> A statement y is said to be control dependent on another statement x
> if (1) there exists a nontrivial path from x to y such that every
> statement z != x in the path is post-dominated by y, and (2) x is not
> post-dominated by y.

Again, this definition doesn't work for the example above. As the basic
block of the if branch trivially post-dominates any other basic block,
because it contains the function return.

2. Solution:

The definition I came up with instead is the following:

> A basic block B is control-dependent on a basic block A if
> B is reachable from A, but control flow can take a path through A
> which avoids B. The scope of a control dependency ends at the first
> basic block where all control flow paths running through A meet.

Note that this allows control dependencies to remain "unresolved".

I'm happy to submit a patch which covers more of what I mentioned above
as part of explanation.txt, but figured that in the spirit of keeping
things simple, leaving out "at all" might be enough?

What do you think?

Many thanks,
Paul

[1]: https://lore.kernel.org/all/Yk7%2FT8BJITwz+Og1@Pauls-MacBook-Pro.local/T/#u
[2]: Optimizing Compilers for Modern Architectures: A Dependence-Based
Approach, Randy Allen, Ken Kennedy, 2002, p. 350

Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
Cc: Marco Elver <elver@google.com>
Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
Cc: Martin Fink <martin.fink@in.tum.de>
---
 tools/memory-model/Documentation/explanation.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index ee819a402b69..42af7ed91313 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -466,7 +466,7 @@ pointer.
 
 Finally, a read event and another memory access event are linked by a
 control dependency if the value obtained by the read affects whether
-the second event is executed at all.  Simple example:
+the second event is executed.  Simple example:
 
 	int x, y;
 
-- 
2.35.1

