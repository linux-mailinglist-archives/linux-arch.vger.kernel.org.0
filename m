Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180F96E7297
	for <lists+linux-arch@lfdr.de>; Wed, 19 Apr 2023 07:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjDSFWW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Apr 2023 01:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjDSFWV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Apr 2023 01:22:21 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32C759E8
        for <linux-arch@vger.kernel.org>; Tue, 18 Apr 2023 22:22:20 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id l5so10156878ybe.7
        for <linux-arch@vger.kernel.org>; Tue, 18 Apr 2023 22:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681881740; x=1684473740;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vsilJRm3n3f0oPJ2h9sspFYqHtbv7ku0fM9SdrcDCj8=;
        b=hj4EKxmQkVBjeHFrYiX7OIFcERVkkm20q7aY8LG40YNwmqdoPSyqvOdb0/0VfE1HZF
         1wxaXil9DYJpM9FfY+3v1j5YdDlMBhRqjOSQqV4mR/oeTrfbP3jWVWO06L2fYMwHFG/W
         GYfKckQve5I0/GA5Mr0muOMEUQb1Kii27Lg526hjbrkSn0+XQUDEzq92zWBS/wJDbdyb
         0l+ZllTmJe+ZeMEplq6HV9LkRdyiO60luNh5CdjNGdHXp6TauzpYRbpE1Ce6e/jbxGQt
         vhIT6k8BIJJzk6DLkWkrjPkLyIyAnPJx+fHf7SaAjCwZqbdA7ZpgSPBHDfZh5Z0fVBUJ
         /4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681881740; x=1684473740;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vsilJRm3n3f0oPJ2h9sspFYqHtbv7ku0fM9SdrcDCj8=;
        b=a8T72QXu5WgXLmB930q+ze8iQy2By+KFiK2XHt5rxOf4C5ZtR+4Ky9t8BBXW5fOQkX
         GHhESYca4jg3llaCCce/kLFwjudL3BFstf1hgG5RKWP8BOIq+/hmfrQppjfKKOfagnLa
         2DVD0NGdAn5MNYD3YJmldBM9pVTUNTn2yVqm3VhLHvSBKjT2OGyylcaGGKW+NLONjhA7
         6DFCj771vqNyqUm/IRZGI0nxK7a9hrw9QZBwUwHXCm7Cff607NUjSiZ7xm/FxqUdMMaV
         SNpDdewkYa3CkgTCpyvgeaTtjv0bE1JKShCoUdqKtrlXV3li169ARRZyAB8hbqZd6pYE
         qkTA==
X-Gm-Message-State: AAQBX9cnfd6TwrTSaR/pJcmxExbOCcFyCIWUtcm/IXcXJNxb1I7UMU7M
        OutFTRUto+/UQcm8gVJ+X9ie+w==
X-Google-Smtp-Source: AKy350Z4PF4zy3c1rTsiOTRbkNvu2a0h9Py9+yH8dop+BTUO2eEpHa0CbiPxrZt0Z7LgGEs/pHl/wA==
X-Received: by 2002:a25:4987:0:b0:b8f:2d6f:1f0b with SMTP id w129-20020a254987000000b00b8f2d6f1f0bmr21036178yba.49.1681881739920;
        Tue, 18 Apr 2023 22:22:19 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j185-20020a8155c2000000b00545a08184fdsm4238243ywb.141.2023.04.18.22.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 22:22:19 -0700 (PDT)
Date:   Tue, 18 Apr 2023 22:22:02 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH next] hugetlb: pte_alloc_huge() to replace huge
 pte_alloc_map()
Message-ID: <ae9e7d98-8a3a-cfd9-4762-bcddffdf96cf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some architectures can have their hugetlb pages down at the lowest PTE
level: their huge_pte_alloc() using pte_alloc_map(), but without any
following pte_unmap().  Since none of these arches uses CONFIG_HIGHPTE,
this is not seen as a problem at present; but would become a problem if
forthcoming changes were to add an rcu_read_lock() into pte_offset_map(),
with the rcu_read_unlock() expected in pte_unmap().

Similarly in their huge_pte_offset(): pte_offset_kernel() is good enough
for that, but it's probably less confusing if we define pte_offset_huge()
along with pte_alloc_huge().  Only define them without CONFIG_HIGHPTE:
so there would be a build error to signal if ever more work is needed.

For ease of development, define these now for 6.4-rc1, ahead of any use:
then architectures can integrate patches using them, independent from mm.

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 include/linux/hugetlb.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -183,6 +183,23 @@ extern struct list_head huge_boot_pages;
 
 /* arch callbacks */
 
+#ifndef CONFIG_HIGHPTE
+/*
+ * pte_offset_huge() and pte_alloc_huge() are helpers for those architectures
+ * which may go down to the lowest PTE level in their huge_pte_offset() and
+ * huge_pte_alloc(): to avoid reliance on pte_offset_map() without pte_unmap().
+ */
+static inline pte_t *pte_offset_huge(pmd_t *pmd, unsigned long address)
+{
+	return pte_offset_kernel(pmd, address);
+}
+static inline pte_t *pte_alloc_huge(struct mm_struct *mm, pmd_t *pmd,
+				    unsigned long address)
+{
+	return pte_alloc(mm, pmd) ? NULL : pte_offset_huge(pmd, address);
+}
+#endif
+
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz);
 /*
