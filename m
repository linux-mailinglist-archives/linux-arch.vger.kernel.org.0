Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C214B56358B
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiGAOaK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiGAO3I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:29:08 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2176B82A
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:25:20 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id 7-20020a170906310700b007263068d531so846565ejx.15
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NuZxaTt6SuBtelFew5LXxi86pENufXvsmy2qQXyoE6c=;
        b=tgfjQq+iQ/ysonFckb3Z2u6TJ9CEvDDKEzA5gkb+C4EKFnWD9TLdpPFWxQRtHD88Jg
         RYLB2Yb0k9id72G7IVJ8H91BQ7wXcKdXZ0Azu48hd+fSPpcrnVbABx59b2la2dgB1ZDR
         AAPr3HcC1/Yh4R+BkF5CNapSwZyhy3/pHIFwHkw79AVAJZ22Y8th2w7xgwft5pumnLsD
         2R5Dmthk3JjdCZyOh+gBs/AieCejbEIH0zIdbihuM0GsaPffCE/o0zvm99bCYmyOaQgR
         TMh+X88DvOG6cOtWBuy2Dm2xKw9NnmVgVGZuSBeVLfUcMKHQAVfKgpF+8OdRVLd3hmjI
         vXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NuZxaTt6SuBtelFew5LXxi86pENufXvsmy2qQXyoE6c=;
        b=BbI/p0JHM07K1EsBM2KvYtXfYgGpSzNIVlxOA8TjyKEJPwO/BHQzeVq9mLBM2xoUJm
         pi0NlZyYaQf+OCl7EWY0yB2RSsdQ3DUCMcOOKXkXGAoJx0J0fivwHBFvPeeLMUfYC+i2
         Txyt0X956Hjpeqp7mUCdv5ZAZktv+h4XklhILNa6rWcRZOFKy2pruOg/+flrRGTBm+eJ
         3ikOwo3EvSgc7/tXO/Rm9QakQKvVLKKOZ4PHNBhe9uv1nnGwjtqBZuJouzFRjuE1Fnk9
         gf4RXpbrylZYE4s3SVD+7hixq3tyG3R1DihiQndteE3tPlL68NAVZGB2NsPfoMpYOAcw
         moVw==
X-Gm-Message-State: AJIora9mp5/wy1ilYuIfr/qQyZU00CMxDpzS9NmzD+MZpQSkSNzMqcuG
        UtpdGWBqFhF9ZZ8uAyFq2sHaViOTUfA=
X-Google-Smtp-Source: AGRyM1spcb+a3miQij6KHvEFDixhz2AvZj0AcfEskbi1pdPvcSJdu4nWWmlOh1NQQeaAeMBr5KVjUAW0uyU=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a17:907:2704:b0:72a:596f:8b9f with SMTP id
 w4-20020a170907270400b0072a596f8b9fmr9611410ejk.761.1656685512839; Fri, 01
 Jul 2022 07:25:12 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:23:07 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-43-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 42/45] bpf: kmsan: initialize BPF registers with zeroes
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When executing BPF programs, certain registers may get passed
uninitialized to helper functions. E.g. when performing a JMP_CALL,
registers BPF_R1-BPF_R5 are always passed to the helper, no matter how
many of them are actually used.

Passing uninitialized values as function parameters is technically
undefined behavior, so we work around it by always initializing the
registers.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I40f39d26232b14816c14ba64a0ea4a8f336f2675
---
 kernel/bpf/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5f6f3f829b368..0ba7dd90a2ab3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2039,7 +2039,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 static unsigned int PROG_NAME(stack_size)(const void *ctx, const struct bpf_insn *insn) \
 { \
 	u64 stack[stack_size / sizeof(u64)]; \
-	u64 regs[MAX_BPF_EXT_REG]; \
+	u64 regs[MAX_BPF_EXT_REG] = {}; \
 \
 	FP = (u64) (unsigned long) &stack[ARRAY_SIZE(stack)]; \
 	ARG1 = (u64) (unsigned long) ctx; \
-- 
2.37.0.rc0.161.g10f37bed90-goog

