Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864FD4EAD42
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiC2MmZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbiC2MmY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:42:24 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42EB204CB3
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:40:37 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id mm20-20020a170906cc5400b006dfec7725f3so8112732ejb.15
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hetjka8F+4smAU2DbrfLtuY9Keg4VAYWsS2h7SzTHpM=;
        b=cHcpM//qa8SvJJrjPOG9wtT4Hj5D6kD8ib68SB0Mqb0q0PO5BtYL9X9Qere7Y8XjxC
         bOM2jC9VPziu2bY4mbcytTILLbSgpj6V9GVCh6WxioXetMKQTjrwkM8t/un72VJ5Mtgo
         iN8edkLwGflJ0otqfb1a7ajaVSPA/j+RPaBGepgVwwsEbS3i0p4LMpfh/BW0+mkCnvMU
         Dy9dZon78osDnNaQChTznTJymR927G4ea5V6szrz6kTy1ZvwLWbYPa/cpH3vDDIjeqkx
         FCLP31BQXYYVkPw5/Wg74buUelJiPy1QB+ObNDqL4zRzTdeyCzo8GYIkh1l7+0BmBJHW
         d2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hetjka8F+4smAU2DbrfLtuY9Keg4VAYWsS2h7SzTHpM=;
        b=x1GXTmfDWU81dq1qwdwH8ApNNELrzT7SOa31BAKQ3FWYOY7AMhX/GhaYoRho3RDm47
         H6b0JptDOv748Ok6jAEtSTKQE8qPkAJ2aV7RW7dxPQuHXNhztsX2bPmE7prhgF5xBHWu
         khb7u2yXU0rIHbjxtvUqIKvo9s3pff0r5A+V/1NXTkcnxPQEjFJB/v7Vh3bfGsN0Juyf
         tPF8B3C/wiBFqbeqI+sSnYtHWTbAN7a1xesadPnHidA47MWFyrg0WukJclNdP/XUxHTi
         5kzYiBH+SBvM66ToXLW3mOp/9mRISLYVTro4UTfOCQR/tcwj5s5f1xa90kqjWEBMnE42
         e/tg==
X-Gm-Message-State: AOAM530ajrGg2EIqZciuZSCLpepUzrifGCHNatZl9HZXZe1zAmN/U9J2
        vfLMjU/JBC61trFJOL3Nu9oAP1X+5xQ=
X-Google-Smtp-Source: ABdhPJyG5Cqqhqcj/H0YOQo5c9+FB/qfdcBot+5TAfkkvUFt0c3NMnQ9bJxFD4PL2W5gYj33TH1h8vNqlJU=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:aa7:c3d6:0:b0:419:2370:4856 with SMTP id
 l22-20020aa7c3d6000000b0041923704856mr4374152edr.180.1648557635703; Tue, 29
 Mar 2022 05:40:35 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:39:32 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-4-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 03/48] kasan: common: adapt to the new prototype of __stack_depot_save()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Pass extra_bits=0, as KASAN does not intend to store additional
information in the stack handle. No functional change.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I932d8f4f11a41b7483e0d57078744cc94697607a
---
 mm/kasan/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 92196562687b6..1182388ed3e0e 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -36,7 +36,7 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
 	unsigned int nr_entries;
 
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
-	return __stack_depot_save(entries, nr_entries, flags, can_alloc);
+	return __stack_depot_save(entries, nr_entries, 0, flags, can_alloc);
 }
 
 void kasan_set_track(struct kasan_track *track, gfp_t flags)
-- 
2.35.1.1021.g381101b075-goog

