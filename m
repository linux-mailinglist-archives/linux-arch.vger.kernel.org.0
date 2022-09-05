Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCFF5AD27E
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 14:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbiIEMZy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 08:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237604AbiIEMZY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 08:25:24 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80387186FE
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 05:25:19 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id q18-20020a056402519200b0043dd2ff50feso5694147edd.9
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2022 05:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=eIK0S734s+WuMuzHGxUrnoQabUzsOPxTYvMm/ke78tI=;
        b=SLwXQbzPHQT2lx3CmDALMMsEHTfh2C5fRJjzD2NlQVdV1yZDtABiy9mOeHVVuGOF9M
         m+WfedhfS8OqwiHcSKlOk6gYgctS/yniai+qVNtBv5itHrKEx2UUKP7JuUqvWGoiUZ4p
         7UKv1IjobR+tSAj44q8qK4JrQfYF0y6m7kSyZsm4AYQa+8vlkP8GyIWNlUOWl7r0oTxr
         pBGpVAhHvoR7nzE9+LR6V3BmAQ4A38y6A4NEtxM3wQYP7pY788MI3NEB1eRmB+H0zfeL
         mXGxy3ik2fCQk/7rDv6yt5ahyqOIzF0oPNuxvRUmCGjRKzXXFL9mefRo74jNp3st4QcE
         +LBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=eIK0S734s+WuMuzHGxUrnoQabUzsOPxTYvMm/ke78tI=;
        b=yAuwwML2JSW2nb2mAczZVSKIXcfdc9xYDmX6N/Sf1/4sqQiaVfYSPEIcPno+lNoMLk
         iIb/A5gI6o+i+PHYPutGq4ebr3AVQIWv2GHZ1l9XHPTKTKwwNLgBKagVFLX0hvrVV0mW
         5giyMuSll9T+eCWLfpqDoRm3Kt1BwxZbRBdXZaiFpPG9IYVPn6OvPG+uhq7U4XRmByE1
         hw0Dr7X1XxsPHNGEDnuj6AsfcGbX3BVD/gDqsjIcGxWDuLPo5CG3yfSw0TORrShvqd7z
         xpGkLWwAJ+32amWgvxwWUk2GRlKCRNfmLxGGzz9MysqZ9O5J1E35QJuIgcAacDOFqqOL
         3QaQ==
X-Gm-Message-State: ACgBeo3HnLS+Wze85kXE7ACBmOcRzDhuqgmhgBBiwxOy7VSQLUv/RZbH
        Six6yQ10y2/qeLvtgCRLIP6GtAl9YEg=
X-Google-Smtp-Source: AA6agR7bXvSnVNQUJmYARonFyFhbVF2eDdfDU/CHIrufPEs62rsTK65KVDoWR72fO1/TGY+y+ld4j+iRz5E=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a05:6402:2937:b0:44e:b578:6fdd with SMTP id
 ee55-20020a056402293700b0044eb5786fddmr722840edb.159.1662380719065; Mon, 05
 Sep 2022 05:25:19 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:16 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-9-glider@google.com>
Subject: [PATCH v6 08/44] kmsan: mark noinstr as __no_sanitize_memory
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

noinstr functions should never be instrumented, so make KMSAN skip them
by applying the __no_sanitize_memory attribute.

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>

---
v2:
 -- moved this patch earlier in the series per Mark Rutland's request

Link: https://linux-review.googlesource.com/id/I3c9abe860b97b49bc0c8026918b17a50448dec0d
---
 include/linux/compiler_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 4f2a819fd60a3..015207a6e2bf5 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -229,7 +229,8 @@ struct ftrace_likely_data {
 /* Section for code which can't be instrumented at all */
 #define noinstr								\
 	noinline notrace __attribute((__section__(".noinstr.text")))	\
-	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
+	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
+	__no_sanitize_memory
 
 #endif /* __KERNEL__ */
 
-- 
2.37.2.789.g6183377224-goog

