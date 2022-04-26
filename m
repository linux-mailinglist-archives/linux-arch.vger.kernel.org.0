Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40935103E6
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353158AbiDZQrt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353124AbiDZQrs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:47:48 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D72191456
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:29 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id o8-20020a170906974800b006f3a8be7502so2042678ejy.8
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nOhCPOtwmNXODLijzTSO8M7zxl8h4T8Tb26PN26Qq0M=;
        b=LZKEFbB8TPQO7kgBdpU2j4eYblKuzaR2Gi1xLMal4r01UVgMm32iuP23KamR8oVwXU
         A0Q2g9OquWtPZUG20Kv+3FzPplKg/UvdC5tL/zaE1RpHoBAA4uWQSRvxSviAcVNValYR
         atgp44CzDP4JuJCWMVAOztuYyp83xVUCTOdMgjPZtZT/I1G2Uvo4gRCy0vOJEAK515qh
         z6CoYJ90tMK9fDUC0vXsGNpavg5yM2TgwZG7Lr5lZNNSi4LNKj1E9yf0Md2SkqX4WdS2
         da8nli8jJ9UvooA1jnZ8RZWFp4syKCdzroiMyC5ygmwL4OY2QmTJ4Viu/eSQqGFOkxbA
         m6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nOhCPOtwmNXODLijzTSO8M7zxl8h4T8Tb26PN26Qq0M=;
        b=BSy2CQz4DX8xxqE1AOYPi/+4uN261UmcAwCC8XBu6j0sntzBA7s7BfYp+F3Rg0AkqB
         ljWbBAzQpl6Vd4HGe7IZLYubaGMhksssPsEJjZ1vhfLIv9Q+ib1FlEjEkcoqwYOPg6J7
         QRw9r7yJYFI7RNBgcSsLECjtAQnoliJtTKEVh5VDJczf6xQwmGqblg7unZ30WtCUjvfa
         K2Zco59+zB/pFcF8oU9E28cu4m1TCt5mmfZ8ID27khIZhV5cB94DVWyCCuhNno/g7VCu
         Yhc7t1bTF1GX7Do277or/jNkUqyanaB4rnEor6krk7JRXjgsIDNgpQ1VaO5IBvMlSw56
         nojA==
X-Gm-Message-State: AOAM531eUWr5YaktklKUUXdXvEKuDjMAzDZUMOLC48DYbHeKeTR/SsRH
        HEFfMP1RTdcN+LRqM4/jrwKwY5Vi2Lg=
X-Google-Smtp-Source: ABdhPJwSu8anY6YzOERS1Ux22TtxUqNV58xGV4qRNVaMI4J71hTHmmbMpjG+iLMULK2X+phM8pbqjHM5UG4=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a17:907:7815:b0:6ce:5242:1280 with SMTP id
 la21-20020a170907781500b006ce52421280mr22103960ejc.217.1650991468011; Tue, 26
 Apr 2022 09:44:28 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:32 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-4-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 03/46] kasan: common: adapt to the new prototype of __stack_depot_save()
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
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
index d9079ec11f313..5d244746ac4fe 100644
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
2.36.0.rc2.479.g8af0fa9b8e-goog

