Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8121A7C56
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 15:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502858AbgDNNPz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 09:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502851AbgDNNPr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Apr 2020 09:15:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A287C061A0C;
        Tue, 14 Apr 2020 06:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sqk4/4RGNrTxKoOSS7RknLWZ2Jg+zx2W1hBhdYBDhqA=; b=cCjLoo477T1Klg03t2tfKXZ6TP
        Rdn2mDO6t5iOeSCa1AfO4aTHP3IN2qctyNaKFZxl2d1cQIfa+/PLbG4ErPaNjEGePbfu1+Ghhewic
        RVUEofP/j0NqHlM7ZBzBp7UD0JlGXZu8GMLb/8rFE37JBUp/1MeD1piUEQEjBmMcDli5zHwRuBm/Y
        hKMZz/bL4EsBQhTsumhUmEPbuf9mjUqIV/ohuwyCUuW65KTmUp7pGy9IXXXh2ol7xk61dzF5Rrzhh
        D855ASUTz2SkdP9nYyoy7BFjZUcAlres7GusRcjEviHhpjin9TRhzePlVpKFFfuiXDbMrg3LuGi5E
        guN5Vzdg==;
Received: from [2001:4bb8:180:384b:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOLPU-0001nV-PN; Tue, 14 Apr 2020 13:15:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 28/29] powerpc: use __vmalloc_node in alloc_vm_stack
Date:   Tue, 14 Apr 2020 15:13:47 +0200
Message-Id: <20200414131348.444715-29-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414131348.444715-1-hch@lst.de>
References: <20200414131348.444715-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

alloc_vm_stack can use a slightly higher level vmalloc function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/powerpc/kernel/irq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 1f1169856dc8..112d150354b2 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -748,9 +748,8 @@ void do_IRQ(struct pt_regs *regs)
 
 static void *__init alloc_vm_stack(void)
 {
-	return __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN, VMALLOC_START,
-				    VMALLOC_END, THREADINFO_GFP, PAGE_KERNEL,
-				     0, NUMA_NO_NODE, (void*)_RET_IP_);
+	return __vmalloc_node(THREAD_SIZE, THREAD_ALIGN, THREADINFO_GFP,
+			      NUMA_NO_NODE, (void *)_RET_IP_);
 }
 
 static void __init vmap_irqstack_init(void)
-- 
2.25.1

