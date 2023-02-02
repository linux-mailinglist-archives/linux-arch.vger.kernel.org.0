Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFDC68825F
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 16:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjBBPb1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 10:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjBBPbY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 10:31:24 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F346C5B8A;
        Thu,  2 Feb 2023 07:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4C3XvlEzMOWDLYDQ8XunR/mwzv7K56/vPk2XJ/CM7ag=; b=ZUZ1EWs+4c6vvynJYe49Tmql6x
        E9Hwyf28DeRTT6vZ+IaEtJqSkdzqvVmas2ZpgoVLuZkqPEKd3ve/jHYhAKkHBhSE1Vruzdjv9NFAg
        sg0Ucbnq82V8ZGLKw74u4lh5Andr5WgxZ+l7vsftcEhZsa0tiiLRuIwKokYbHWpFDD3Z0bMsXQi5a
        BiZifR9/6fYGl3k8uVPVTlhK5cuHqpARfsBWDyuaKd9ptgf8fyagi0kS64lLeh/PurgpcMdHjY7n7
        mIXERrd2lrAuy5AeTjEMyW8XGqNrNKGWJEjt3SIwCVKjHIcXLjpiPYUY2tz2OrZsdsVzHgkt9cEsl
        USOkEkfQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pNbVT-005CFg-1p;
        Thu, 02 Feb 2023 15:28:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0552A300ECD;
        Thu,  2 Feb 2023 16:28:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8796E23F305BD; Thu,  2 Feb 2023 16:28:40 +0100 (CET)
Message-ID: <20230202152655.313053173@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Feb 2023 15:50:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org
Cc:     corbet@lwn.net, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v2 02/10] types: Introduce [us]128
References: <20230202145030.223740842@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce [us]128 (when available). Unlike [us]64, ensure they are
always naturally aligned.

This also enables 128bit wide atomics (which require natural
alignment) such as cmpxchg128().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/types.h      |    5 +++++
 include/uapi/linux/types.h |    4 ++++
 2 files changed, 9 insertions(+)

--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -10,6 +10,11 @@
 #define DECLARE_BITMAP(name,bits) \
 	unsigned long name[BITS_TO_LONGS(bits)]
 
+#ifdef __SIZEOF_INT128__
+typedef __s128 s128;
+typedef __u128 u128;
+#endif
+
 typedef u32 __kernel_dev_t;
 
 typedef __kernel_fd_set		fd_set;
--- a/include/uapi/linux/types.h
+++ b/include/uapi/linux/types.h
@@ -13,6 +13,10 @@
 
 #include <linux/posix_types.h>
 
+#ifdef __SIZEOF_INT128__
+typedef __signed__ __int128 __s128 __attribute__((aligned(16)));
+typedef unsigned __int128 __u128 __attribute__((aligned(16)));
+#endif
 
 /*
  * Below are truly Linux-specific types that should never collide with
--- a/lib/crypto/curve25519-hacl64.c
+++ b/lib/crypto/curve25519-hacl64.c
@@ -14,8 +14,6 @@
 #include <crypto/curve25519.h>
 #include <linux/string.h>
 
-typedef __uint128_t u128;
-
 static __always_inline u64 u64_eq_mask(u64 a, u64 b)
 {
 	u64 x = a ^ b;
--- a/lib/crypto/poly1305-donna64.c
+++ b/lib/crypto/poly1305-donna64.c
@@ -10,8 +10,6 @@
 #include <asm/unaligned.h>
 #include <crypto/internal/poly1305.h>
 
-typedef __uint128_t u128;
-
 void poly1305_core_setkey(struct poly1305_core_key *key,
 			  const u8 raw_key[POLY1305_BLOCK_SIZE])
 {


