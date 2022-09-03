Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5E25ABFEB
	for <lists+linux-arch@lfdr.de>; Sat,  3 Sep 2022 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiICQ6J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Sep 2022 12:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiICQ6D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Sep 2022 12:58:03 -0400
X-Greylist: delayed 70989 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 03 Sep 2022 09:58:01 PDT
Received: from mailout1.rbg.tum.de (mailout1.rbg.tum.de [IPv6:2a09:80c0::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08A74BA7C
        for <linux-arch@vger.kernel.org>; Sat,  3 Sep 2022 09:58:01 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [131.159.254.14])
        by mailout1.rbg.tum.de (Postfix) with ESMTPS id 8AD954D;
        Sat,  3 Sep 2022 18:57:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1662224276;
        bh=6I03lOClv+/v9svh2z7blvYK/DBCx5y3LoldsviBRfQ=;
        h=From:To:Cc:Subject:Date:From;
        b=um4qAaNpopVN7LGRtI22YD4kYTzAAZOFJpT/gM8qfn1+IEYQXR3Pb/bEr+F+FBOrq
         c2Zn5YURBHUWvt87RgquuLvxGOW+jCHm0N9JrgroYYdIITOhz87gi9eibdCHxgZcfD
         KuO1xTwnRyDLzXHzFeUt4mV1wj+pbD7LV/Wes3t61hBitkKlwh2PL+wWS6wlG9nCGG
         Hs3qlUqfdhHKGy4rINydMUwDv79rJvShU6SZLYjn5vDCn/GL19BBVCWzrqKDVYl2By
         xMXmxwvD7wpiWbWU4d6xwS+OF5NcbPeh4nU+SXcaZAIsB3Frx6ZVyOLQZ67m5Njz60
         NSBP4UeQcnhIA==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 847001AE8; Sat,  3 Sep 2022 18:57:56 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id 60C581AE7;
        Sat,  3 Sep 2022 18:57:56 +0200 (CEST)
Received: from mail.in.tum.de (vmrbg426.in.tum.de [131.159.0.73])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 5B80D1AE6;
        Sat,  3 Sep 2022 18:57:56 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 567944A01DB; Sat,  3 Sep 2022 18:57:56 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id 05C294A0023;
        Sat,  3 Sep 2022 18:57:55 +0200 (CEST)
        (Extended-Queue-bit xtech_vn@fff.in.tum.de)
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
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Subject: [PATCH v4] tools/memory-model: Weaken ctrl dependency definition in explanation.txt
Date:   Sat,  3 Sep 2022 16:57:17 +0000
Message-Id: <20220903165718.4186763-1-paul.heidekrueger@in.tum.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

The read event determines whether the write event will be executed "at all"
- as per the current definition - but the formal LKMM does not recognize
this as a control dependency.

Introduce a new definition which includes the requirement for the second
memory access event to syntactically lie within the arm of a non-loop
conditional.

Link: https://lore.kernel.org/all/20220615114330.2573952-1-paul.heidekrueger@in.tum.de/
Cc: Marco Elver <elver@google.com>
Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
Cc: Martin Fink <martin.fink@in.tum.de>
Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
---

v4:
- Replace "a memory access event" with "a write event"

v3:
- Address Alan and Joel's feedback re: the wording around switch statements
and the use of "guarding"

v2:
- Fix typos
- Fix indentation of code snippet

v1:
@Alan, since I got it wrong the last time, I'm adding you as a co-developer
after my SOB. I'm sorry if this creates extra work on your side due to you
having to resubmit the patch now with your SOB if I understand correctly,
but since it's based on your wording from the other thread, I definitely
wanted to give you credit.

 tools/memory-model/Documentation/explanation.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index ee819a402b69..11a1d2d4f681 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -464,9 +464,10 @@ to address dependencies, since the address of a location accessed
 through a pointer will depend on the value read earlier from that
 pointer.

-Finally, a read event and another memory access event are linked by a
-control dependency if the value obtained by the read affects whether
-the second event is executed at all.  Simple example:
+Finally, a read event X and a write event Y are linked by a control
+dependency if Y syntactically lies within an arm of an if statement and
+X affects the evaluation of the if condition via a data or address
+dependency (or similarly for a switch statement).  Simple example:

 	int x, y;

--
2.35.1

