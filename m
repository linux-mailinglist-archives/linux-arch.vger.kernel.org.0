Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69CF6053C4
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 01:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiJSXHW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 19:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiJSXHH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 19:07:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CFB1B2BB9;
        Wed, 19 Oct 2022 16:06:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82754B8261B;
        Wed, 19 Oct 2022 23:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9D6C433C1;
        Wed, 19 Oct 2022 23:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220813;
        bh=wirS8AQfcl3lz2i46diN/RWkNI9yLfEaD2Y4Z3N2uHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MHItS7s6ZV5PK2XmaDQmmecxnoS4mqBzyvNXFe2LC4vUFE9BKQjxWL+pkn8Pr5IDd
         mFkyN9rI+LVFa8L533gXv18Dj/lxWBK+PULufa+S5XsQXA98HmBAz/WshBabylJN5v
         wnRU4EEhq6pLKacISc/S86gPSCjr/Q+tIqYb7l9XaRv0J5uk3JgMQmk3dijIb/QGnv
         SveE5AC4CTXGr7v4+Ai82qYzV54ohRyFL5ei6OF59zFHlaYHLE1ixgp3dPm48YMFm5
         rwxpC4WYYUed1oudhyFqCgoOaxw+QVfLS6qd2Lsmgc4MCUiCjkPDI/j84hbmHVEBOO
         OfVLYDUEMIqAQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F188D5C06B4; Wed, 19 Oct 2022 16:06:52 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com,
        =?UTF-8?q?Paul=20Heidekr=C3=BCger?= <paul.heidekrueger@in.tum.de>,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 1/5] tools/memory-model: Weaken ctrl dependency definition in explanation.txt
Date:   Wed, 19 Oct 2022 16:06:47 -0700
Message-Id: <20221019230651.2502538-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019230640.GA2502305@paulmck-ThinkPad-P17-Gen-1>
References: <20221019230640.GA2502305@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Paul Heidekrüger <paul.heidekrueger@in.tum.de>

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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/explanation.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index ee819a402b698..11a1d2d4f681c 100644
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
2.31.1.189.g2e36527f23

