Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD85E6DBEA0
	for <lists+linux-arch@lfdr.de>; Sun,  9 Apr 2023 06:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDIEsm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Apr 2023 00:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjDIEsl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Apr 2023 00:48:41 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6BB59E5
        for <linux-arch@vger.kernel.org>; Sat,  8 Apr 2023 21:48:40 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id p2so38647703qtw.13
        for <linux-arch@vger.kernel.org>; Sat, 08 Apr 2023 21:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1681015719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V3qp54zofXL6HqwANXHbIqSJAW5oTYcp+phuNdRg/30=;
        b=bZk6ef5UuG6O3E/Y8htUsoTwirOIIPyvE7GJK7dBhiVc2Wxdz9zT60P4FDnGVygzX9
         6W9X3MRxRnIx8wMNXcclZFzD9tH7eV6WGw/iVl70zu1nw+Mhiq90AjhykyoltjOopMEG
         7xEjbLbJlBN/UfGF0BxxORT3GeioWuyuEnp2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681015719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3qp54zofXL6HqwANXHbIqSJAW5oTYcp+phuNdRg/30=;
        b=gYNZ7eCFRCWNe8X15GKn3mG1SJxLeJabFr88fJV+adEDGRV/A1Dhq8lZ5DE51tJ2/n
         zqA040MAsGEQZ/9ZF0kraWGtQ72L/VKmXam/VQ6mxqxGLTDNy0C98lSMfl3adyHcJLHx
         71SCg+b8tukBjMgRqjqLAyrcQJZxipENfB//QlVn1/txUuZWJz3oQ05DQaA/mzJ0tTmS
         tBTe1tDYXDYqRVXdJA8HPv6YyOIrHkfNLYZEXYywTQZyMKeTBZeIedcsh5Moub2sYpvF
         fD6E5XWT5E/GjgIlTldDLtPririvjWREcz58RRv0eZvzfA6R+79tQlyIdvV3yS1jwA1T
         GJug==
X-Gm-Message-State: AAQBX9caUVikKu6w0TmqWO77BXze5YUBMYrb7wCmYbMwI/FLkuw9jkaf
        wFwoisLgpaxb48wOE1kmXd1zCA==
X-Google-Smtp-Source: AKy350ZKwQ2XEp/crMH+ihARzNWWaNa99vwdIYw+uuZwiSY9SYfDcvIJ1Kn10flzhIvD4yJPPCW+Bw==
X-Received: by 2002:ac8:5f8b:0:b0:3d9:307e:8b with SMTP id j11-20020ac85f8b000000b003d9307e008bmr5937947qta.35.1681015719372;
        Sat, 08 Apr 2023 21:48:39 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id z63-20020a376542000000b007417e60f621sm2421270qkb.126.2023.04.08.21.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 21:48:38 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
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
        Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-arch@vger.kernel.org
Subject: [PATCH] tools: memory-model: Rename litmus test to avoid confusion with similar-named test
Date:   Sun,  9 Apr 2023 04:48:22 +0000
Message-Id: <20230409044823.775760-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to differentiate the test
Z6.0+pooncelock+poonceLock+pombonce.litmus from another test that only
differs by a capital L, the following file has been renamed:

renamed: litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus ->
litmus-tests/Z6.0+pooncelock+pooncelockmb+pombonce.litmus

This change should help avoid confusion between the two tests.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 ...mbonce.litmus => Z6.0+pooncelock+pooncelockmb+pombonce.litmus} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename tools/memory-model/litmus-tests/{Z6.0+pooncelock+poonceLock+pombonce.litmus => Z6.0+pooncelock+pooncelockmb+pombonce.litmus} (100%)

diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelockmb+pombonce.litmus
similarity index 100%
rename from tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
rename to tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelockmb+pombonce.litmus
-- 
2.40.0.577.gac1e443424-goog

