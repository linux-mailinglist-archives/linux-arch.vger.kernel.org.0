Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC17775C532
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 13:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjGULAE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 07:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjGUK7e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 06:59:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC262733;
        Fri, 21 Jul 2023 03:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Url1S2KkTliaPbsKSfxxrI3LXJILvuEJ2CRpOdAeZx4=; b=RjOze5I06m1EPmRzvNMOw4h7zJ
        10p45BmFIxxQzO/qLwTkFJsFTB0PrU576kmq0IyFHIfRA75xAexc2xh4dIaNRLa9Y5LNrafe+Y2HU
        XYyyFWUYwG1XdG7GwrQ8X4aBV8FeMN9VtfhlEzqZaTTa234TXbfT/mP2/kEwc5dwzows9j7EO/zTP
        51+OgjfvYfrt/+bUwB908HZKFKqXxSPH9Bxt5Vx+8/i0uds+40kFe/jiU8oYpZzOG2lVwthSuPRLl
        awEwZyTRVb/2zt01EAaLdTRESfjSw9Qsmle/lZskaj31xN2PyMnVDsz78EP0+awx5ayhv/lILMr2+
        U+nM8rUg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMnqJ-0012OU-K0; Fri, 21 Jul 2023 10:58:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 35687300911;
        Fri, 21 Jul 2023 12:58:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 020DE3157E61D; Fri, 21 Jul 2023 12:58:37 +0200 (CEST)
Message-ID: <20230721105743.954526690@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Jul 2023 12:22:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH v1 04/14] futex: Validate futex value against futex size
References: <20230721102237.268073801@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Ensure the futex value fits in the given futex size. Since this adds a
constraint to an existing syscall, it might possibly change behaviour.

Currently the value would be truncated to a u32 and any high bits
would get silently lost.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/futex/futex.h    |    8 ++++++++
 kernel/futex/syscalls.c |    3 +++
 2 files changed, 11 insertions(+)

--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -86,6 +86,14 @@ static inline unsigned int futex_size(un
 	return 1 << size; /* {0,1,2,3} -> {1,2,4,8} */
 }
 
+static inline bool futex_validate_input(unsigned int flags, u64 val)
+{
+	int bits = 8 * futex_size(flags);
+	if (bits < 64 && (val >> bits))
+		return false;
+	return true;
+}
+
 #ifdef CONFIG_FAIL_FUTEX
 extern bool should_fail_futex(bool fshared);
 #else
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -209,6 +209,9 @@ static int futex_parse_waitv(struct fute
 		if (!futex_flags_valid(flags))
 			return -EINVAL;
 
+		if (!futex_validate_input(flags, aux.val))
+			return -EINVAL;
+
 		futexv[i].w.flags = flags;
 		futexv[i].w.val = aux.val;
 		futexv[i].w.uaddr = aux.uaddr;


