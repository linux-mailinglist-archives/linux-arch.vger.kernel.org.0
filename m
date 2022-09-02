Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5255AB9F4
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 23:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiIBVPE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 17:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiIBVO5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 17:14:57 -0400
Received: from mailout1.rbg.tum.de (mailout1.rbg.tum.de [131.159.0.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FBF402DA;
        Fri,  2 Sep 2022 14:14:54 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [IPv6:2a09:80c0:254::14])
        by mailout1.rbg.tum.de (Postfix) with ESMTPS id 67BAF4D;
        Fri,  2 Sep 2022 23:14:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1662153290;
        bh=u5FjiDtj+sc7V8QJwsamLfaOay7+nXBUtX8OoR4BnUI=;
        h=From:To:Cc:Subject:Date:From;
        b=J+X0M041Rk77l0bKInImGKixCg8ji0nu2ogvrVGKn5jPzyHYSLe5OHITrFOpr9N48
         AMpOZpW7QNxgB7OueLDLVFKn4/dDOiDrMRNdETKxH9S3Eg0Eukp1JDZ9cZ3e0Wtk7U
         SMdm+E9ge9ym+pdH1MzWjE1B0929j1XLJgRNGYEN1j3kNAMaal8DgxRGgKj8fuCCdv
         VpvcgYLAXmi9Xivnnk3GRMDWWACTvHa4OXv8l3yvUmhvKSgm7yOpdXYXxzxMMdwQYe
         OZSByvtwo22CFElr4wlnPdhV34PUGh/5QWYcl9Od6hEZQ+MqKHiyYJhS60IpocUu7N
         O8nJ6I5A/ijbw==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 61BBA1ABC; Fri,  2 Sep 2022 23:14:50 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id 3C1361ABB;
        Fri,  2 Sep 2022 23:14:50 +0200 (CEST)
Received: from mail.in.tum.de (mailproxy.in.tum.de [IPv6:2a09:80c0::78])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 375AD1AB7;
        Fri,  2 Sep 2022 23:14:50 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 33B864A0440; Fri,  2 Sep 2022 23:14:50 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id D77AC4A007E;
        Fri,  2 Sep 2022 23:14:49 +0200 (CEST)
        (Extended-Queue-bit xtech_jl@fff.in.tum.de)
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
Subject: [PATCH v3] tools/memory-model: Weaken ctrl dependency definition in explanation.txt
Date:   Fri,  2 Sep 2022 21:13:40 +0000
Message-Id: <20220902211341.2585133-1-paul.heidekrueger@in.tum.de>
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
Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
---

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

 tools/memory-model/Documentation/explanation.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index ee819a402b69..0b7e1925a673 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -464,9 +464,11 @@ to address dependencies, since the address of a location accessed
 through a pointer will depend on the value read earlier from that
 pointer.

-Finally, a read event and another memory access event are linked by a
-control dependency if the value obtained by the read affects whether
-the second event is executed at all.  Simple example:
+Finally, a read event X and another memory access event Y are linked by
+a control dependency if Y syntactically lies within an arm of an if
+statement and X affects the evaluation of the if condition via a data or
+address dependency (or similarly for a switch statement).  Simple
+example:

 	int x, y;

--
2.35.1

