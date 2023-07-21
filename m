Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3933075C538
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 13:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjGULAF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 07:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjGUK7f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 06:59:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7DF272D;
        Fri, 21 Jul 2023 03:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=60hbAcuR558zERq3nmTHmGZxZzuSde/KCKqPvfvDN0A=; b=tGS8FVZVVED29+j6zj5HEaAOxI
        SRQRgFzFoSu6P04KeweOXTANw3a3x3jrYY4ys1Yzf9d4Ze6qmx2YYCypunggIFUg1HeXufmpQBzxS
        V/ldVoPSOQXOO0yg/aTBWAbreEC5bvBZ6CHMEkaKT9g5zpYPSSQ59osGECCXJ6t6FDoUrXYKhY2LA
        m2VONQr27kHBHr41Xis4HXsWrHdZH9K0eHK2UAOW82fwq1o6Mm1hd2k9G4QNYGa6WgbPlhl9b3uEQ
        wkv9AhQJWztan5osPkJb5qMdFvdObWwYdH68icSIwW2KMjbCl5Yz3bNkk8G5X+M7yMLoLd7nQL41p
        65Vf054A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMnqK-0012Oe-90; Fri, 21 Jul 2023 10:58:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3486F300C65;
        Fri, 21 Jul 2023 12:58:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1CC153157E624; Fri, 21 Jul 2023 12:58:38 +0200 (CEST)
Message-ID: <20230721105744.367616679@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Jul 2023 12:22:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH v1 10/14] mm: Add vmalloc_huge_node()
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

To enable node specific hash-tables.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/vmalloc.h |    1 +
 mm/vmalloc.c            |    7 +++++++
 2 files changed, 8 insertions(+)

--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -152,6 +152,7 @@ extern void *__vmalloc_node_range(unsign
 void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
 		int node, const void *caller) __alloc_size(1);
 void *vmalloc_huge(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
+void *vmalloc_huge_node(unsigned long size, gfp_t gfp_mask, int node) __alloc_size(1);
 
 extern void *__vmalloc_array(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
 extern void *vmalloc_array(size_t n, size_t size) __alloc_size(1, 2);
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3416,6 +3416,13 @@ void *vmalloc(unsigned long size)
 }
 EXPORT_SYMBOL(vmalloc);
 
+void *vmalloc_huge_node(unsigned long size, gfp_t gfp_mask, int node)
+{
+	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
+				    gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
+				    node, __builtin_return_address(0));
+}
+
 /**
  * vmalloc_huge - allocate virtually contiguous memory, allow huge pages
  * @size:      allocation size


