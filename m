Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE294605213
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 23:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiJSVhH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 17:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiJSVhG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 17:37:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FC91956F0
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 14:37:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b4so31173311wrs.1
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 14:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQVk2CI7gUTucSPsYsRuO+Xgt/DLnqyh0SKi8lL+BxQ=;
        b=kEVsf5yva6tPgrJ28OEjDXh5az9gBpktNnS2hvVjuDF+md4bSzDCTm+yLSoP1QbyCF
         nmvNyXfObeOLojWLCz86IsZhxLuBaicxiZndWHvw9g8EeVbOQMDwRPb40itjjAn8SR60
         nETxvBCs7XCrBF7ofuSBIcD8XDwUg25BGJeeyC5neQwRiSrK8XjG/og8YoSeibMcNzI4
         cCTvbda7YB4O3z4MsBZokpHXnboje0jgXWsJ9OvWDu7xGKth403zmdIXNWN0mtOmqzln
         +KYYaS5K402ENk8RVDvJZG3VhziKJuQt0TNA7vm0tPoHTF1iLlFjc3Yzj4q6WncoJYWS
         9GmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQVk2CI7gUTucSPsYsRuO+Xgt/DLnqyh0SKi8lL+BxQ=;
        b=oPFHYEKGP5aawHoo93hdt3obpiMrcyZmgjPfokEh9eGsi2OUT72U9PGFkrMjgon8SQ
         L86zOX8mlZhJOu8fp7XsqLjNh7O6k/Yf6uFEIlR9ivGpBN77wDUOb77/uJ0eQA4TL372
         re/XlVb9qk22Q9xv5iRAleg/XwSvPvZqK3HccCTPbvyF+U5xEsjX6V0MTpQm0dvXtYAt
         PtJYX+8JyxaHFxcbRP9/PtF7PyKleaifsbPli2cYupcR/s7NZIy+WrsuvEIQjFVdTRNI
         RXJLEEdX5hMYbAB5R7mawehLa5jG2kUb1je0/UkOLJfzWRaBotQ+YNK+G7QAVR7zRujA
         wmkQ==
X-Gm-Message-State: ACrzQf1h7g7yCjvOD/sMaNPhB6aobIkwqiFD3PlgpsNQj4DMUYNowMIu
        JYkL3SVcRjawTsPszjbmcdD00A==
X-Google-Smtp-Source: AMsMyM7qopHlpx/0st3r1u+WJ8I0s2s8sNijf+qUWSM5iyTi/IS/3JDBYAUI/Wlvu3L9ZDi6G/UWsw==
X-Received: by 2002:a05:6000:1843:b0:22e:77b0:2e5 with SMTP id c3-20020a056000184300b0022e77b002e5mr6255132wri.215.1666215423700;
        Wed, 19 Oct 2022 14:37:03 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:b751:df72:2e0f:684c])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c4ec700b003c409244bb0sm1236729wmq.6.2022.10.19.14.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 14:37:02 -0700 (PDT)
Date:   Wed, 19 Oct 2022 23:36:56 +0200
From:   Marco Elver <elver@google.com>
To:     youling 257 <youling257@gmail.com>
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
        Eric Biggers <ebiggers@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 18/43] instrumented.h: add KMSAN support
Message-ID: <Y1Bt+Ia93mVV/lT3@elver.google.com>
References: <20220915150417.722975-19-glider@google.com>
 <20221019173620.10167-1-youling257@gmail.com>
 <CAOzgRda_CToTVicwxx86E7YcuhDTcayJR=iQtWQ3jECLLhHzcg@mail.gmail.com>
 <CANpmjNMPKokoJVFr9==-0-+O1ypXmaZnQT3hs4Ys0Y4+o86OVA@mail.gmail.com>
 <CAOzgRdbbVWTWR0r4y8u5nLUeANA7bU-o5JxGCHQ3r7Ht+TCg1Q@mail.gmail.com>
 <Y1BXQlu+JOoJi6Yk@elver.google.com>
 <CAOzgRdY6KSxDMRJ+q2BWHs4hRQc5y-PZ2NYG++-AMcUrO8YOgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOzgRdY6KSxDMRJ+q2BWHs4hRQc5y-PZ2NYG++-AMcUrO8YOgA@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 20, 2022 at 04:07AM +0800, youling 257 wrote:
> That is i did,i already test, remove "u64 __tmp…kmsan_unpoison_memory", no help.
> i only remove kmsan_copy_to_user, fix my issue.

Ok - does only the below work (without the reverts)?

diff --git a/include/linux/kmsan-checks.h b/include/linux/kmsan-checks.h
index c4cae333deec..eb05caa8f523 100644
--- a/include/linux/kmsan-checks.h
+++ b/include/linux/kmsan-checks.h
@@ -73,8 +73,8 @@ static inline void kmsan_unpoison_memory(const void *address, size_t size)
 static inline void kmsan_check_memory(const void *address, size_t size)
 {
 }
-static inline void kmsan_copy_to_user(void __user *to, const void *from,
-				      size_t to_copy, size_t left)
+static __always_inline void kmsan_copy_to_user(void __user *to, const void *from,
+					       size_t to_copy, size_t left)
 {
 }
 

... because when you say only removing kmsan_copy_to_user() (from
instrument_put_user()) works, it really doesn't make any sense. The only
explanation would be if the compiler inlining is broken.
