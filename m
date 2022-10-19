Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E736050EF
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 22:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiJSUAS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 16:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiJSUAO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 16:00:14 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4041213C5
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 13:00:12 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so831937wms.0
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 13:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2N+V1uC9FDjbZcJb9aKbA76091h0TpDZZKWHaAmAek=;
        b=Lw4jVYTIUktL0VD/hUyxuK2pdB+TLLlMZirRYUqhs2U98/w8T/30PXKiSQ70UgVAq6
         +grAdpBFztsHMbqs06MBtqGFYggBuQ8eB5hLxlopjVREuCd6GoyGxs5nbQQMkDUAsspT
         YhQ9IztsM9nZHCvOhL03IV/fnoWIqaxZ0utZhXJVoblGjV2OUVXW5EiT9sjDw6u7+lUt
         9ZQvxCuqtpyMDdIxf6qk3fgrd6wCkkmmNjf4LKAopOmbVPc/vI+MkblfYwX6EnXL/YVt
         U5YgOhvlpQ8y6+A+Fx25TgNIreQUA+4XldEr3KiLCwcLqj9JsYgRtuPqCqw88ukO8vGV
         0fMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2N+V1uC9FDjbZcJb9aKbA76091h0TpDZZKWHaAmAek=;
        b=pplnIQxsJUVOO4Zzpgb+WQBn+VmE95mPF2U7kVBYJQ+D5Ui6fMNbrYv9nyYpwaE8bk
         jvo8REmMS5iDIzJTClGGW2RDAJZMKiLShJKOWtZ7OkLOjcNT7p2O15DOjVUqEFm0jg3P
         yu5Hkbnl8C3uZv37/4zEyihvyW/3JNiLMvrIOwnk3e29850eJnBKzCWQ+7i8qFeDK45X
         /KXU2PM6QtM0bnlSUEkpbu2Wg++miOo2bvgT9+YXo67U3PmUmfB0AOAgihV4E1xtxJx4
         E5N0tWKvXrOhAF3ZL7426iQJVZ50pA0568G5CSHJvw9mBmOAFzjf06LgQed6WIJZjWiZ
         RKBQ==
X-Gm-Message-State: ACrzQf35BS8dQVADDJ5gRZXsOYlBkWrdOyDjPm4v20dx03AnoqtYiAmT
        U9F3ycilQ2VD5c2Fi4U7GaScrQ==
X-Google-Smtp-Source: AMsMyM6B3pwfghBShw4QCFh8wsWBS8bi/WgiLJm5OdtkiIadPOi40t5IpnUu2dUWkrkhhaqvsZnpVw==
X-Received: by 2002:a05:600c:a45:b0:3bc:c676:a573 with SMTP id c5-20020a05600c0a4500b003bcc676a573mr28289654wmq.118.1666209610271;
        Wed, 19 Oct 2022 13:00:10 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:b751:df72:2e0f:684c])
        by smtp.gmail.com with ESMTPSA id ay18-20020a5d6f12000000b0022e62529888sm945871wrb.67.2022.10.19.13.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 13:00:09 -0700 (PDT)
Date:   Wed, 19 Oct 2022 22:00:02 +0200
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
Message-ID: <Y1BXQlu+JOoJi6Yk@elver.google.com>
References: <20220915150417.722975-19-glider@google.com>
 <20221019173620.10167-1-youling257@gmail.com>
 <CAOzgRda_CToTVicwxx86E7YcuhDTcayJR=iQtWQ3jECLLhHzcg@mail.gmail.com>
 <CANpmjNMPKokoJVFr9==-0-+O1ypXmaZnQT3hs4Ys0Y4+o86OVA@mail.gmail.com>
 <CAOzgRdbbVWTWR0r4y8u5nLUeANA7bU-o5JxGCHQ3r7Ht+TCg1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOzgRdbbVWTWR0r4y8u5nLUeANA7bU-o5JxGCHQ3r7Ht+TCg1Q@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 20, 2022 at 03:29AM +0800, youling 257 wrote:
[...]
> > What arch?
> > If x86, can you try to revert only the change to
> > instrument_get_user()? (I wonder if the u64 conversion is causing
> > issues.)
> >
> arch x86, this's my revert,
> https://github.com/youling257/android-mainline/commit/401cbfa61cbfc20c87a5be8e2dda68ac5702389f
> i tried different revert, have to remove kmsan_copy_to_user.

There you reverted only instrument_put_user() - does it fix the issue?

If not, can you try only something like this (only revert
instrument_get_user()):

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 501fa8486749..dbe3ec38d0e6 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -167,9 +167,6 @@ instrument_copy_from_user_after(const void *to, const void __user *from,
  */
 #define instrument_get_user(to)				\
 ({							\
-	u64 __tmp = (u64)(to);				\
-	kmsan_unpoison_memory(&__tmp, sizeof(__tmp));	\
-	to = __tmp;					\
 })
 

Once we know which one of these is the issue, we can figure out a proper
fix.

Thanks,

-- Marco
