Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2180671674
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jan 2023 09:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjARIqR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Jan 2023 03:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjARIpa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Jan 2023 03:45:30 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACEE90869
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 00:00:44 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id q64so34968745pjq.4
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 00:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cadyF8CD/E3oK1yfSJSphX1/cZjS+kj7x9tW6+ar6sc=;
        b=WcdwzEYpRynxGJWgQlKjA9zr5Ugl+tLrV/aeoKmaEyWm5I+eofmuFjC8v+O5CZJC8w
         tOZB+tAJR4+wiFQ1iaQWMCDXko5KxSau59i0CeKJSVmyvX/0i6O5Zr39SstJW0Z3rE1B
         Fyu5ijjz/jR31RZrsNZLyh0clWoOshZNgMIiETyrsUXvb3eq/iyNx1mkClYVLAY7+64k
         zYOIM7lzO4YVQSlFFkESwH80wBohrcEE2EqtboWnWa9tbyNk7GkZ4n+1ZHeUM7FQ71rU
         UAR97RL8R4zHQ490YhXWXkQbBJPh185TldI1Fz1/+yE5zazmCzPESNz0kF9nXmNoebc3
         uPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cadyF8CD/E3oK1yfSJSphX1/cZjS+kj7x9tW6+ar6sc=;
        b=WSLkZtk1qLumWFkdDj/vFiQaUiCKgxmKtpQb4lwWEBVwi+yJbGr+Ost5Ta75f+Lq9T
         f44FjOG6Rsebpl+HINOpMMeIIrHEb7c4swiLNg79P+/dUt+6QaemsFDCLwIaEIkOOrKa
         y2GfJruffbHpp+idiElw+pzqzzUHfIF9eS0cyTsunLft01T89Fj/jb/wiEer+4moJjEf
         lv+39jRec2HWNkldNg6QGOtpstYbU0OQdpX7Eymwzg8P+wiHUag3OxvbL5jpZXN0K4jr
         Z1gCX6bsJPZeSsqcBqTYbS+fJ4eMywQRnv4AvO4zbUb/nTtKr6xMI/0xJ//3gpHETnMj
         qCTA==
X-Gm-Message-State: AFqh2koDKRY3bFvDk7q/yuK/wauLbBEitCN3WZIbsj2Wru1Tww4D+G/I
        4hfhwy9N0eitEQG6m1CGduM=
X-Google-Smtp-Source: AMrXdXvru18rhSMREurCixBPKsRCor9uxoV61Ex5rHoJVQ7gmSRE7YHzcemWD4ARplQOcaVlqvp+VQ==
X-Received: by 2002:a17:90a:3fca:b0:227:161a:6318 with SMTP id u10-20020a17090a3fca00b00227161a6318mr6162197pjm.47.1674028842208;
        Wed, 18 Jan 2023 00:00:42 -0800 (PST)
Received: from bobo.ibm.com (193-116-102-45.tpgi.com.au. [193.116.102.45])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090a16c200b002272616d3e1sm738462pje.40.2023.01.18.00.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 00:00:41 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 5/5] powerpc/64s/radix: combine final TLB flush and lazy tlb mm shootdown IPIs
Date:   Wed, 18 Jan 2023 18:00:11 +1000
Message-Id: <20230118080011.2258375-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230118080011.2258375-1-npiggin@gmail.com>
References: <20230118080011.2258375-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

** Not for merge **

CONFIG_MMU_LAZY_TLB_SHOOTDOWN that requires IPIs to clear the "lazy tlb"
references to an mm that is being freed. With the radix MMU, the final
userspace exit TLB flush can be performed with IPIs, and those IPIs can
also clear lazy tlb mm references, which mostly eliminates the final
IPIs required by MMU_LAZY_TLB_SHOOTDOWN.

This does mean the final TLB flush is not done with TLBIE, which can be
faster than IPI+TLBIEL, but we would have to do those IPIs for lazy
shootdown so using TLBIEL should be a win.

The final cpumask test and possible IPIs are still needed to clean up
some rare race cases. We could prevent those entirely (e.g., prevent new
lazy tlb mm references if userspace has gone away, or move the final
TLB flush later), but I'd have to see actual numbers that matter before
adding any more complexity for it. I can't imagine it would ever be
worthwhile.

This takes lazy tlb mm shootdown IPI interrupts from 314 to 3 on a 144
CPU system doing a kernel compile. It also takes care of the one
potential problem workload which is a short-lived process with multiple
CPU-bound threads that want to be spread to other CPUs, because the mm
exit happens after the process is back to single-threaded.

---
 arch/powerpc/mm/book3s64/radix_tlb.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 282359ab525b..f34b78cb4c7d 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -1303,7 +1303,31 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 	 * See the comment for radix in arch_exit_mmap().
 	 */
 	if (tlb->fullmm || tlb->need_flush_all) {
-		__flush_all_mm(mm, true);
+		if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_SHOOTDOWN)) {
+			/*
+			 * Shootdown based lazy tlb mm refcounting means we
+			 * have to IPI everyone in the mm_cpumask anyway soon
+			 * when the mm goes away, so might as well do it as
+			 * part of the final flush now.
+			 *
+			 * If lazy shootdown was improved to reduce IPIs (e.g.,
+			 * by batching), then it may end up being better to use
+			 * tlbies here instead.
+			 */
+			smp_mb(); /* see radix__flush_tlb_mm */
+			exit_flush_lazy_tlbs(mm);
+			_tlbiel_pid(mm->context.id, RIC_FLUSH_ALL);
+
+			/*
+			 * It should not be possible to have coprocessors still
+			 * attached here.
+			 */
+			if (WARN_ON_ONCE(atomic_read(&mm->context.copros) > 0))
+				__flush_all_mm(mm, true);
+		} else {
+			__flush_all_mm(mm, true);
+		}
+
 	} else if ( (psize = radix_get_mmu_psize(page_size)) == -1) {
 		if (!tlb->freed_tables)
 			radix__flush_tlb_mm(mm);
-- 
2.37.2

