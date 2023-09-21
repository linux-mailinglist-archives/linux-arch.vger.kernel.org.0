Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195307A9925
	for <lists+linux-arch@lfdr.de>; Thu, 21 Sep 2023 20:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjIUSLr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Sep 2023 14:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjIUSLP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2023 14:11:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D64580B1;
        Thu, 21 Sep 2023 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=+WIdohk1HL2nzrHveE43px5IkTjGhV/7JBkH2s5C174=; b=ViAEDbVGOlyxSg3ebF8KxwAziD
        ZJXxCIy42X12v4Mep2vVxljFUC4bpie4jrjZc5b7y0aR/AFBwBx8QQf7IyrWb6in0/ZjL0xzIPnSx
        pb6UQGfcsxlZIGeiFtjBChv2JNIQwRXxcHOt6/36MAnZlaHZe1+0fz5A4w/a/h9G+i1YiZoOjLNE4
        OwpOyR+wNSWxm0UFxB37sVSQEBBvFtN6ftl6Pn5yJIMtEP7rAmx4bdY6aw54FXq2amDzF8WCOnnaP
        MIOPlPb7NIN0RqyDlWXr9vkr9PkW1Y4MN8g0z/WF3CPS10TmZ2L6+1wJRYHnIB47xz4TyxFPPPHSd
        HzrBon7A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjHQN-00FJvv-1Z;
        Thu, 21 Sep 2023 11:00:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 15CCD30067A; Thu, 21 Sep 2023 13:00:43 +0200 (CEST)
Message-Id: <20230921105248.683656626@noisy.programming.kicks-ass.net>
User-Agent: quilt/0.65
Date:   Thu, 21 Sep 2023 12:45:16 +0200
From:   peterz@infradead.org
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 11/15] mm: Add vmalloc_huge_node()
References: <20230921104505.717750284@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-vmalloc_huge_node.patch
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Index: linux-2.6/include/linux/vmalloc.h
===================================================================
--- linux-2.6.orig/include/linux/vmalloc.h
+++ linux-2.6/include/linux/vmalloc.h
@@ -152,6 +152,7 @@ extern void *__vmalloc_node_range(unsign
 void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
 		int node, const void *caller) __alloc_size(1);
 void *vmalloc_huge(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
+void *vmalloc_huge_node(unsigned long size, gfp_t gfp_mask, int node) __alloc_size(1);
 
 extern void *__vmalloc_array(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
 extern void *vmalloc_array(size_t n, size_t size) __alloc_size(1, 2);
Index: linux-2.6/mm/vmalloc.c
===================================================================
--- linux-2.6.orig/mm/vmalloc.c
+++ linux-2.6/mm/vmalloc.c
@@ -3420,6 +3420,13 @@ void *vmalloc(unsigned long size)
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


