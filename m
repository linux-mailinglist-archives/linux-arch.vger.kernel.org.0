Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D4F5BAECA
	for <lists+linux-arch@lfdr.de>; Fri, 16 Sep 2022 16:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiIPOC1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Sep 2022 10:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiIPOCQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2022 10:02:16 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFDAAF0C3
        for <linux-arch@vger.kernel.org>; Fri, 16 Sep 2022 07:02:01 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y136so21358652pfb.3
        for <linux-arch@vger.kernel.org>; Fri, 16 Sep 2022 07:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=m4dgh/mxnUSEPj3HfQNUBb5nsgYsEWdLYyqOM0O6Vpg=;
        b=jI1TBoHWK7INYvXXCvlGHB3MZlBO14PcpeillYZKgYjgbsEt606qO+fSOI6Fml4RMR
         oX0N/4bEKvlQblCR4Ff83CVuQnrm1mUSNafLG4I+SvO1ZKzjcWx2TGHTJlj0VNf1U4hn
         utwv4NmQdiJMsYb3StFL0V6D7PE1YBv1gfboI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=m4dgh/mxnUSEPj3HfQNUBb5nsgYsEWdLYyqOM0O6Vpg=;
        b=GG24nr+yBG0wtCj3dzemZhBwzpi7aeIfllINzBwrwEIGX2R2fAIxpQyYdPmnIKyxBu
         dfSiU2pWoyXfCDlHwNPdwT3zz6t9pxR2TZfFldvAbkUQYA3GtmXMTO3Gsg4EGnvXpu3l
         lFWiG6We8rVEmmvEbGIhHq8lTcF6C1JE70i3coy6l6qOJ2esqkxlBEkA78N+HXS3tq++
         pI50Om+Yd56TCRqGfL0XMcHTPjDBbEN5wYnVI0unLqUavpkOe6sbJ2gjm9ryv5/4WkjG
         ddMf+ww1LCjH2VUQoJ6WOS3RJh+DXYBqw8j6BRua2Fezv2tUiSH/NynwxL+kXqkx29SX
         iwgA==
X-Gm-Message-State: ACrzQf1BjV23/kS2xlzWUL/1qKKfi4cB3vBlBqoBpdZfqJuJWLlV1Gt4
        gJAnHdZOoEHt8iM3Qr48h+VDkA==
X-Google-Smtp-Source: AMsMyM5ruebRsvODVR+Z/MGmOdF0Yq6HP2tQiwWDNCKT5n+gY73mAViYZmQmRLDXngcku4Y2YMW4sw==
X-Received: by 2002:a63:5620:0:b0:429:9ad7:b4f2 with SMTP id k32-20020a635620000000b004299ad7b4f2mr4652001pgb.162.1663336921065;
        Fri, 16 Sep 2022 07:02:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h16-20020a17090adb9000b001f5513f6fb9sm1575447pjv.14.2022.09.16.07.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 07:01:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, dev@der-flo.net,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 3/3] usercopy: Add find_vmap_area_try() to avoid deadlocks
Date:   Fri, 16 Sep 2022 06:59:57 -0700
Message-Id: <20220916135953.1320601-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220916135953.1320601-1-keescook@chromium.org>
References: <20220916135953.1320601-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2412; h=from:subject; bh=QZ6Z8NUryO+WXs11aot8e62UrW7zXJzgNjf9RA+g260=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjJIFZPv4/7ywbrNNcCVWPzvTkr6HcSFspF17/+HNL KUwNf5SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYySBWQAKCRCJcvTf3G3AJreQEA CZOZ/BXt+5KgNX9VpTzYbr5l4Hxnm2HUfC9ouhb1vIQvd4GSBXv3YLWuN5JWTlnt8SLltG5TzQ64XT JEALXvYOE51UQlH9TVsscdQ3ed9BiHQDIwWmJzzb8FupJHdUxocPiKLXEOpny4QxCjZXqZR2QUT1KF DTpNiY57v/Pz0iYpqNmDaFW+w1DudEMX1EqIfAmBD5p7XvEzsCFup+suxrh7eK4e2e8g2uTAJR0h7u WP9ccsTCfqqYqwqFsP17hREGzgqIE+nOsnmROYXhji0C9r4zHVOECoU50SxlLx8ik1AnMvzL8j33K9 6ltpwFCWNfMC1OQuzaLA2VDK3Y7OTnO+wlfsC6SAl841m22iP54H3+oLBATH4pRw2zNDa4ONYSiZLt YeW8xd/Bi+7Zr6gh8awsBpUuwAJVK7JhrgxrW5qYMRh69Nm/Njoh7h2EGjpauv1+wRFh90ku7vksTu K4AsS0mwIvNqjgjXribZKXFdBWP92MljiXksXsWwJbV0rzAceFU17Luum+I8PVS5lbpkvG+wV0pKmH CPIZ5l7zEv8gc2aCt6sCCnn5XRcLR8kKdKsCgWSm3Dm7tYvK1JeVDZBHDNXYt4Yc8Rng1UaNDO8oZd YpM/VgautWGgX3BmxCNGNqgX8LQJh/gH0mqQssJCDW6F9B6dOUHtX9OyCbcQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The check_object_size() checks under CONFIG_HARDENED_USERCOPY need to be
more defensive against running from interrupt context. Use a best-effort
check for VMAP areas when running in interrupt context

Suggested-by: Matthew Wilcox <willy@infradead.org>
Link: https://lore.kernel.org/linux-mm/YyQ2CSdIJdvQPSPO@casper.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: dev@der-flo.net
Cc: linux-mm@kvack.org
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/vmalloc.h |  1 +
 mm/usercopy.c           | 11 ++++++++++-
 mm/vmalloc.c            | 11 +++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 096d48aa3437..c8a00f181a11 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -216,6 +216,7 @@ void free_vm_area(struct vm_struct *area);
 extern struct vm_struct *remove_vm_area(const void *addr);
 extern struct vm_struct *find_vm_area(const void *addr);
 struct vmap_area *find_vmap_area(unsigned long addr);
+struct vmap_area *find_vmap_area_try(unsigned long addr);
 
 static inline bool is_vm_area_hugepages(const void *addr)
 {
diff --git a/mm/usercopy.c b/mm/usercopy.c
index c1ee15a98633..4a371099ac64 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -173,7 +173,16 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 	}
 
 	if (is_vmalloc_addr(ptr)) {
-		struct vmap_area *area = find_vmap_area(addr);
+		struct vmap_area *area;
+
+		if (unlikely(in_interrupt())) {
+			area = find_vmap_area_try(addr);
+			/* Give up under interrupt to avoid deadlocks. */
+			if (!area)
+				return;
+		} else {
+			area = find_vmap_area(addr);
+		}
 
 		if (!area)
 			usercopy_abort("vmalloc", "no area", to_user, 0, n);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index dd6cdb201195..f14f1902c2f6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1840,6 +1840,17 @@ struct vmap_area *find_vmap_area(unsigned long addr)
 	return va;
 }
 
+struct vmap_area *find_vmap_area_try(unsigned long addr)
+{
+	struct vmap_area *va = NULL;
+
+	if (spin_trylock(&vmap_area_lock)) {
+		va = __find_vmap_area(addr, &vmap_area_root);
+		spin_unlock(&vmap_area_lock);
+	}
+	return va;
+}
+
 /*** Per cpu kva allocator ***/
 
 /*
-- 
2.34.1

