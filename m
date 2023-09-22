Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADA07ABABD
	for <lists+linux-arch@lfdr.de>; Fri, 22 Sep 2023 22:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjIVU7x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Sep 2023 16:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjIVU7w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Sep 2023 16:59:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46471A2;
        Fri, 22 Sep 2023 13:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=zWIQ6Yi556U65myk2PzRkq/DHdsIiBTxeyqBKDx6r2g=; b=hktQlK3IZ5z27ejm1FLGbbL1mo
        mzMcjkhwk3cOL9uWlaupMqvTCXnVZAoT6CJRQ0M29Q5yLP4ldsnxOmGjX4q6rjSEI64QiOYmhDBl1
        P34q0qimycD9b/kQhEEKct+8KTKDGbkWMwSTmS278soTtIfi9R+SqnOIrE5sNsyZz3ma+fTYPc4zF
        1bnVko5qUEoPXj7iOJw+xXKE+NPyQD41xo32nxvuoljsm3NlHTZLfVHISoB7SITHfEz+0mYyjkOq8
        DkRxp0jw7F5ICVHtOBTQtELeVEyWis3tl7y1KZ2CkP3ihqlF98Q0ECbL3/aloKy0AEDNlzdBY/hIg
        FSIpHA6A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjnEs-00GXzC-2v;
        Fri, 22 Sep 2023 20:59:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id F0DDE3008D6; Fri, 22 Sep 2023 22:59:03 +0200 (CEST)
Message-Id: <20230922205450.033535181@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 22 Sep 2023 22:01:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de, steve.shaw@intel.com,
        marko.makela@mariadb.com, andrei.artemev@intel.com
Subject: [PATCH 17/15] [HACK] futex: Force futex hash collision
References: <20230921104505.717750284@noisy.programming.kicks-ass.net>
 <20230921104505.717750284@noisy.programming.kicks-ass.net>
 <20230922200120.011184118@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If you hate performance -- use this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/futex/core.c     |    6 ++++++
 kernel/sched/features.h |    2 ++
 2 files changed, 8 insertions(+)

--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -128,6 +128,9 @@ static int futex_put_value(u32 val, u32
 	}
 }
 
+#include <linux/sched/cputime.h>
+#include "../sched/sched.h"
+
 /**
  * futex_hash - Return the hash bucket in the global hash
  * @key:	Pointer to the futex key for which the hash is calculated
@@ -159,6 +162,9 @@ struct futex_hash_bucket *futex_hash(uni
 		}
 	}
 
+	if (sched_feat(FUTEX_SQUASH))
+		hash = 0;
+
 	return &futex_queues[node][hash & (futex_hashsize - 1)];
 }
 
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -89,3 +89,5 @@ SCHED_FEAT(UTIL_EST_FASTUP, true)
 SCHED_FEAT(LATENCY_WARN, false)
 
 SCHED_FEAT(HZ_BW, true)
+
+SCHED_FEAT(FUTEX_SQUASH, false)


