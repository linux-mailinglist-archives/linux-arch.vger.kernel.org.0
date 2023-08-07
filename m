Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B0A772439
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 14:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjHGMhY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 08:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbjHGMhT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 08:37:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA4C10FE;
        Mon,  7 Aug 2023 05:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=1Epi3uPitQ1on7D3YBD3uiLy0TLxJfWf5bL2Vyq95Dw=; b=Co5btgZE3bcLd6z8lfAD2yNF2L
        ng1KYKs/j+LRyQXyEVivIfQ47vWvqix6Wv8uRYB11Zf6YAPWQ2Kzx6ArCzkOTTWGT+8XCPQ7uXuEW
        vDAkp51vggTuX10agZQ0yg3W576dARN+M8hwxlyoPwRGjE1XOB0MhUIjhFWN9aJ7vL1eea62cfgP6
        NvnVZop5Z9+vAD7rvcXJhH1RecuHIqRh/u8NJKUmTnog33pDpfH/OHUZ4xTe7JYu2pvydxZvXodvi
        2IHrCULJhmfjc6eogA90H7UhlDF3UynqeHLBuojaS/A/nCPh7Z4kvOMBaOLWLDVm17tOL1bQyvxXM
        L0ZUXWwQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qSzTk-003oSd-1J;
        Mon, 07 Aug 2023 12:36:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D1BF4300473;
        Mon,  7 Aug 2023 14:36:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 986A62021C3D7; Mon,  7 Aug 2023 14:36:54 +0200 (CEST)
Message-ID: <20230807123323.020870574@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 07 Aug 2023 14:18:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH  v2 04/14] futex: Validate futex value against futex size
References: <20230807121843.710612856@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex/futex.h    |   10 ++++++++++
 kernel/futex/syscalls.c |    3 +++
 2 files changed, 13 insertions(+)

--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -85,6 +85,16 @@ static inline unsigned int futex_size(un
 	return 1 << (flags & FLAGS_SIZE_MASK);
 }
 
+static inline bool futex_validate_input(unsigned int flags, u64 val)
+{
+	int bits = 8 * futex_size(flags);
+
+	if (bits < 64 && (val >> bits))
+		return false;
+
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


