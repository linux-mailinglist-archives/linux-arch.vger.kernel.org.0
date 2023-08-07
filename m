Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5092772435
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 14:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjHGMhW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 08:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjHGMhU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 08:37:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D29170A;
        Mon,  7 Aug 2023 05:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=yhuAOwd3npGJeiWmKJXyciafSAGyeTkzn0KP+zTqoEU=; b=DIfNmxEY7NkuxRZGvTBNvETWLd
        ddtah769bA3DgEscE0yGOSe5I39fPDiu5Mjvo17Y567v9fB2s7UX2zdEL/95eWCfI3b3Q1PhxBfaY
        LYDstXbDtVxb/OurZOWFFWwWlAgq3BKqt2A4y2gFBkoO5WtEh/Pn60AQf1xOMd9mA8wonY7weYkEp
        Bx9EOyLBwrEFqUCS0it9omaKgOhmDSlZW0dv+uiZc5hKDPEZXaJU2140Vc2QBw/ncEUVuJibJQxVw
        lTJr2P9b8KYQTkBIXzNM11ot2CJ4W9zOw6AmQWhQLaNvpx7A5KkfFbaocB0ejMdjiL0f3fMIPCfTt
        T0c0m83Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qSzTl-003oSl-1d;
        Mon, 07 Aug 2023 12:36:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2DAA73033B1;
        Mon,  7 Aug 2023 14:36:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B72A22021C3DB; Mon,  7 Aug 2023 14:36:54 +0200 (CEST)
Message-ID: <20230807123323.434708155@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 07 Aug 2023 14:18:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de, Christoph Hellwig <hch@lst.de>
Subject: [PATCH  v2 10/14] mm: Add vmalloc_huge_node()
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

To enable node specific hash-tables.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


