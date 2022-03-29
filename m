Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EB34EAD4C
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbiC2Mm5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbiC2Mmr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:42:47 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16A621547C
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:40:53 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id b71-20020a509f4d000000b00418d658e9d1so10842687edf.19
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O7QheLFrb7/gpanG0WgUH3CDvOfcWzGQKyw+meqIa2c=;
        b=nwdrOPNgrlRK/p217vtYWLPWJHANewfRLQpav+XSHbkAVHEnW3oP60FbQ/XxJx5Wey
         8DRycD6Z8aEu0MC/3X0fisGnjf5imwmv/pW9pycKVeSdzaHTJ5Rg895wxW0ZrqOGPo10
         IfXG+qAD/A/UF9Bi9etjM3pLZn0NbG7nPno2kSpwLlV8g6SDRLw6y8Wk3qoccWfMZ8be
         drDAk5gciM2kZ8tcU4aiCTs8FvlgiztSYF5pfb76GBFYTSFhMc7u/3/M4f77WEnkaJxj
         KHDu5r2kXFtX3OnAiGQmLBocYjFXf2eOhSXJmKa/Qj5ogXrOHpI3AL+qNsyyhKmK9AoV
         8PsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O7QheLFrb7/gpanG0WgUH3CDvOfcWzGQKyw+meqIa2c=;
        b=qAvv8HeI3KKl04gxgFnQkV5lQ2HpkHS6TTuYUGL+wrD5np+mJ3Zo4bHC//votaKfpJ
         ESW37FE5raowdB4OCdeBxAYTrpl0Ewlv2iSinFK0vxsLIgQ5L38oApoXevlR5RNDL31S
         51hfyjOWFvc1/3MX4WlRIy+t55GuMA0+hD//vx9nbnDoOUGRPV7oOWEq75on8UKChgDo
         jJK7VqXC2e6FmS6ueoHZfZbD01ufsSbBXENll037cBNnB7j0lO8jNPIkP7fxDPNo/3P+
         tebtMduc8JUbUcilY4ukN6ss+VCqy5/PlLvSvmhba/YIQPjd7bF31fT4WE+Td9AuB8X6
         rd2w==
X-Gm-Message-State: AOAM532I93ngXqs0a9giljPZvPwsuzd+/n2pKrQg3t/AfWSJLx9qJNd3
        klQJuZCBTxyekOVakY7ETa43WGiVOhc=
X-Google-Smtp-Source: ABdhPJw72M5zTQlc12l/JxfWqejUITTKjW22Nisg7zg2gWpioCaXSJXtz0/OVqyNYeeR7potvImif+IfrBc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:907:60cc:b0:6e0:dab3:ca76 with SMTP id
 hv12-20020a17090760cc00b006e0dab3ca76mr19088650ejc.154.1648557652185; Tue, 29
 Mar 2022 05:40:52 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:39:38 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-10-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 09/48] kmsan: mark noinstr as __no_sanitize_memory
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

noinstr functions should never be instrumented, so make KMSAN skip them
by applying the __no_sanitize_memory attribute.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 -- moved this patch earlier in the series per Mark Rutland's request

Link: https://linux-review.googlesource.com/id/I3c9abe860b97b49bc0c8026918b17a50448dec0d
---
 include/linux/compiler_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 3c1795fdb5686..286675559cbba 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -221,7 +221,8 @@ struct ftrace_likely_data {
 /* Section for code which can't be instrumented at all */
 #define noinstr								\
 	noinline notrace __attribute((__section__(".noinstr.text")))	\
-	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
+	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
+	__no_sanitize_memory
 
 #endif /* __KERNEL__ */
 
-- 
2.35.1.1021.g381101b075-goog

