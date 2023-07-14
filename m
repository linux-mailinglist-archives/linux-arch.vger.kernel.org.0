Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A45B753CEB
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jul 2023 16:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbjGNOQs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jul 2023 10:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbjGNOQn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jul 2023 10:16:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAF71989;
        Fri, 14 Jul 2023 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=vd7IZ5Q9sG2aEX5C+B5mpNsAgNCXrsR4bE5i4Du1qnc=; b=X9gijMCmfaPrSsayyWL0NuHiOe
        pGOhwRRTPBsZ40IXNFRORyzItcRWv4X+M3D/uQhswBiY0asbLlff6VJbJ0JHPEZfFMXjzmVs0I3h2
        zIKqL8xHXO1+pjyWMBoxtpmq/8rxGe7cTHGeZ59jD2gdh/RhQ1gSNvuGbpNqbMkv4kEbOqjxxt/Bk
        BXDNnfyaPMAZRHuxBHH6Wfgfjrb5LqQ6zKpgZIsXsl9TYZBQrbC9LXYFJBv8YGZQfOAumvP+LAfQH
        DKKaLDkbVrzm/PSaPiAwV1U7mLa+G0455XJv/+IXRtYsqpaPxRb6KOlKfb+F71dSxkGZZpqg+7ydQ
        MafKW0bA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKJah-006Iiz-2D;
        Fri, 14 Jul 2023 14:16:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B2786300C88;
        Fri, 14 Jul 2023 16:16:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 72FA0213728B8; Fri, 14 Jul 2023 16:16:13 +0200 (CEST)
Message-ID: <20230714141218.947137012@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 14 Jul 2023 15:39:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [RFC][PATCH 05/10] mm: Add vmalloc_huge_node()
References: <20230714133859.305719029@infradead.org>
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
 mm/vmalloc.c            |   11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

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
@@ -3430,9 +3437,7 @@ EXPORT_SYMBOL(vmalloc);
  */
 void *vmalloc_huge(unsigned long size, gfp_t gfp_mask)
 {
-	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
-				    gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
-				    NUMA_NO_NODE, __builtin_return_address(0));
+	return vmalloc_huge_node(size, gfp_mask, NUMA_NO_NODE);
 }
 EXPORT_SYMBOL_GPL(vmalloc_huge);
 


