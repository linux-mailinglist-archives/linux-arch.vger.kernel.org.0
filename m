Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA366C5C34
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 02:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCWBig (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Mar 2023 21:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCWBig (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2023 21:38:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B959D199D4;
        Wed, 22 Mar 2023 18:38:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y4so80531320edo.2;
        Wed, 22 Mar 2023 18:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679535513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hx83mLYB0uVsFbGY6Wby96cUKHTfd8VZ8vjQKL5Nn6g=;
        b=qG3vNbDgD+fNHoY8I10At78xdGtDKt921ZSahtqen4y+9p+Vgm8sPLgB5YTiRbX4/r
         IRG/yFAKzD6e0rRBS4IZJk4zxiV6WR1tduYYzUy56TBJRKPdEFAvoTDvcbehsGNM8WL7
         QNECmv0wDJuSTYQtTD6GSd54cnXx2oJNNNaha3OJkQn4ZMZwI1dtEhll/J76TW0dy/Cv
         PI7qkbJSu+os/RwVBYL6ZeqAOCCKp61QEJ9811XqPE6hvKismsyuU9aDM2xQ77RssEG0
         QIUXhL1cs4EMsdyZjpcixCXh3TaYCUE/4g+peLcyWfIYSFW7Ff/NrVP7G4/zzhfiiVa8
         yz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679535513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hx83mLYB0uVsFbGY6Wby96cUKHTfd8VZ8vjQKL5Nn6g=;
        b=pc0AhsnZE+Cyue1/mux+TpmFTKkcC9PjeQF1kyPAjFELpbzc8Si27JA1oMf/FSeKFQ
         ydIhvx7WY+kuOl7cHp/j4sWgILsRVe13fmCXLgQKIviEC69hZ5Ji7ZRfT8zGgZI8rwke
         Iskppy9OIjqCWVGBWDTegPfya0L7JYefo+erPipIuX+xQO6PrtC18lVcagulSRqMfjlM
         feeKNwbSxwCtR1+0G0cHZm8wYQB/ffwOGTLn6blu2MrbTAduyoa45IqPiOeXnufFpR8M
         su4bUK5cOm+MtDUuMIdWU3t/oyYa0Xy+LWMpX1UmBtCp4RIsq2tAxk1iy78lC+RlA/AN
         qXtQ==
X-Gm-Message-State: AO0yUKUVKLxtenUueiiXZMpwbytRfa9ZOdac3HmXGcgZIk9KQJ8IBGrG
        ba93htdqvkHlhMkjAe6ComvXq4ZhnDWJb1dR
X-Google-Smtp-Source: AK7set/8qj1kmWFF3FjAIuYuQc4B4FMLi+FE4KplGJCPUGRWhWbmh+sI7F+mq6DI86Uxv/iMwD4ziA==
X-Received: by 2002:a50:e619:0:b0:4fd:298a:62cb with SMTP id y25-20020a50e619000000b004fd298a62cbmr3952932edm.21.1679535513052;
        Wed, 22 Mar 2023 18:38:33 -0700 (PDT)
Received: from andrea.. (93-41-0-79.ip79.fastwebnet.it. [93.41.0.79])
        by smtp.gmail.com with ESMTPSA id v18-20020a50a452000000b004c3e3a6136dsm8404626edb.21.2023.03.22.18.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 18:38:32 -0700 (PDT)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH] tools/memory-model: Remove out-of-date SRCU documentation
Date:   Thu, 23 Mar 2023 02:37:51 +0100
Message-Id: <20230323013751.77588-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit 6cd244c87428 ("tools/memory-model: Provide exact SRCU semantics")
changed the semantics of partially overlapping SRCU read-side critical
sections (among other things), making such documentation out-of-date.
The new, semantic changes are discussed in explanation.txt.  Remove the
out-of-date documentation.

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 .../Documentation/litmus-tests.txt            | 27 +------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/tools/memory-model/Documentation/litmus-tests.txt b/tools/memory-model/Documentation/litmus-tests.txt
index 26554b1c5575e..acac527328a1f 100644
--- a/tools/memory-model/Documentation/litmus-tests.txt
+++ b/tools/memory-model/Documentation/litmus-tests.txt
@@ -1028,32 +1028,7 @@ Limitations of the Linux-kernel memory model (LKMM) include:
 		additional call_rcu() process to the site of the
 		emulated rcu-barrier().
 
-	e.	Although sleepable RCU (SRCU) is now modeled, there
-		are some subtle differences between its semantics and
-		those in the Linux kernel.  For example, the kernel
-		might interpret the following sequence as two partially
-		overlapping SRCU read-side critical sections:
-
-			 1  r1 = srcu_read_lock(&my_srcu);
-			 2  do_something_1();
-			 3  r2 = srcu_read_lock(&my_srcu);
-			 4  do_something_2();
-			 5  srcu_read_unlock(&my_srcu, r1);
-			 6  do_something_3();
-			 7  srcu_read_unlock(&my_srcu, r2);
-
-		In contrast, LKMM will interpret this as a nested pair of
-		SRCU read-side critical sections, with the outer critical
-		section spanning lines 1-7 and the inner critical section
-		spanning lines 3-5.
-
-		This difference would be more of a concern had anyone
-		identified a reasonable use case for partially overlapping
-		SRCU read-side critical sections.  For more information
-		on the trickiness of such overlapping, please see:
-		https://paulmck.livejournal.com/40593.html
-
-	f.	Reader-writer locking is not modeled.  It can be
+	e.	Reader-writer locking is not modeled.  It can be
 		emulated in litmus tests using atomic read-modify-write
 		operations.
 
-- 
2.34.1

