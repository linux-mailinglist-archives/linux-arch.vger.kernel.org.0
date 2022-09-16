Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412B95BAF94
	for <lists+linux-arch@lfdr.de>; Fri, 16 Sep 2022 16:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiIPOqO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Sep 2022 10:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiIPOqN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2022 10:46:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E05A0631;
        Fri, 16 Sep 2022 07:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=59xaeeSnQHcY+3RA+T0HPunpoN4EGbyW+imfmiP5ukU=; b=QY7ks+FCtzUGLIAOIRCBGs9Kph
        ns2ivjk1NKYvhbAyO0uT+7YiSglm/Jy9Nl5nKZpUvmou6rxnTO71zRMODh3E5GLlEeqCBCR1WqFaq
        r+aOFdqPXcN1fA/Hgmxr352j6Uf3ERgKNdAb90AdMKu6awfJtnwbzRPlTOLHrQgybZWJSXRXHaLVy
        h21nHAynsNuipU9ibOtst3QGn4CyGq8ecCSBVFvgpkrvt4RfVsrhvnbpx91VN+KhZ1peoG9kSE/S6
        abfIWFT5dG7axVdTvMaLUox9FGLivdb5c2bcQxzuox1EYiYCD0MPRAh2Y2BWl+aHDgyOOnom4Xku5
        k5NCQUrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oZCbX-002ILG-1V; Fri, 16 Sep 2022 14:46:07 +0000
Date:   Fri, 16 Sep 2022 15:46:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, dev@der-flo.net,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] usercopy: Add find_vmap_area_try() to avoid deadlocks
Message-ID: <YySML2HfqaE/wXBU@casper.infradead.org>
References: <20220916135953.1320601-1-keescook@chromium.org>
 <20220916135953.1320601-4-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916135953.1320601-4-keescook@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 16, 2022 at 06:59:57AM -0700, Kees Cook wrote:
> The check_object_size() checks under CONFIG_HARDENED_USERCOPY need to be
> more defensive against running from interrupt context. Use a best-effort
> check for VMAP areas when running in interrupt context

I had something more like this in mind:

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 096d48aa3437..2b7c52e76856 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -215,7 +215,7 @@ extern struct vm_struct *__get_vm_area_caller(unsigned long size,
 void free_vm_area(struct vm_struct *area);
 extern struct vm_struct *remove_vm_area(const void *addr);
 extern struct vm_struct *find_vm_area(const void *addr);
-struct vmap_area *find_vmap_area(unsigned long addr);
+struct vmap_area *find_vmap_area_try(unsigned long addr);
 
 static inline bool is_vm_area_hugepages(const void *addr)
 {
diff --git a/mm/usercopy.c b/mm/usercopy.c
index c1ee15a98633..e0fb605c1b38 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -173,7 +173,11 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 	}
 
 	if (is_vmalloc_addr(ptr)) {
-		struct vmap_area *area = find_vmap_area(addr);
+		struct vmap_area *area = find_vmap_area_try(addr);
+
+		/* We may be in NMI context */
+		if (area == ERR_PTR(-EAGAIN))
+			return;
 
 		if (!area)
 			usercopy_abort("vmalloc", "no area", to_user, 0, n);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index dd6cdb201195..2ea76cb56d4b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1829,7 +1829,7 @@ static void free_unmap_vmap_area(struct vmap_area *va)
 	free_vmap_area_noflush(va);
 }
 
-struct vmap_area *find_vmap_area(unsigned long addr)
+static struct vmap_area *find_vmap_area(unsigned long addr)
 {
 	struct vmap_area *va;
 
@@ -1840,6 +1840,18 @@ struct vmap_area *find_vmap_area(unsigned long addr)
 	return va;
 }
 
+struct vmap_area *find_vmap_area_try(unsigned long addr)
+{
+	struct vmap_area *va;
+
+	if (!spin_lock(&vmap_area_lock))
+		return ERR_PTR(-EAGAIN);
+	va = __find_vmap_area(addr, &vmap_area_root);
+	spin_unlock(&vmap_area_lock);
+
+	return va;
+}
+
 /*** Per cpu kva allocator ***/
 
 /*
