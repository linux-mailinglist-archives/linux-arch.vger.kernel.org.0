Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF260571C2A
	for <lists+linux-arch@lfdr.de>; Tue, 12 Jul 2022 16:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiGLOSG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Jul 2022 10:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiGLORn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jul 2022 10:17:43 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3D3B419E
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2022 07:17:42 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-31c8bb90d09so82335377b3.8
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2022 07:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Buzecpksdj/ppXJ2ucKEbyUfR5ZsYfyO7TYuavzyvD0=;
        b=sQLMjweS32iCJFRlAoNOwdDK8hnBFO21q9/QR3QMg+i6jTMQ0w5pdtuSrvaKE3yi1V
         OENAnF+nSsSdc8ihCvsjb0GrX8iBDz0tilJIYC098s3na4ze2AwlI7ZXPJuZWBZimbPa
         zc6VD+EG5cnRr7pN0NFncsyRnk7xvvcAJUzQVgXEpkMvlCbSNGhzBey0ah2rAG7JEeXa
         zKxam8P3oasK+CS9Z5A7Zgy04dV+iFfm10EG9KvV0M4B4K8hGOijSVFbtyjWIngqOlCG
         o9DhTuPPVrwBZrP43BRgcahv5z27In46n7Ln6OyxARYJeytEEIwCEvWNt3MsP0FHLEK2
         rZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Buzecpksdj/ppXJ2ucKEbyUfR5ZsYfyO7TYuavzyvD0=;
        b=qSNnC1oMMPSpKa+JDTGl1vjqRUJZbyfMVVUbpGk6opRfi403wU3ErUF08RBvMYaYaV
         A7+ylI1hjXwXDLgT3IJ1Fykszyz7x0g5Ve75Djq9gq6A20dZdSgQHa7cBzoFe8pYSOz6
         T0+BqP49eMqHjwWjjayeMIWstIaWA+YbmJ8/UGa0SEuaIHpDsKrdHMgJmUl9Viaeog1v
         NMt3l4969wsYPrNX77XqVGEDe6ewFKmh8Xo06+k/CD7g9eMP28OhbqmT8BeNlvDXZWfe
         xQwCHNSilbAVssMxACC4ZJj7G7dFszv3w9A9hDn8M4Za/A8NDaSKkjn3Yh/ly5JjBxb/
         RqlA==
X-Gm-Message-State: AJIora+4kxhJjjN+a9qLxfKdVT+ea9XMPOQsHxpo24WHfInpsDj09//4
        Al9ynMw2YSwYOrabuwKIyUxlVZm+2/LK3ITCHX0FCw==
X-Google-Smtp-Source: AGRyM1uVdHTmrl1drLvEWnkm4a6NFJwTacxtO7sfLPad/DWZB0qnGKYB1DMBXiaHNCHTl4HGLySz7YkxPWuIFc4sl7A=
X-Received: by 2002:a0d:e60d:0:b0:31c:8046:8ff with SMTP id
 p13-20020a0de60d000000b0031c804608ffmr25882367ywe.412.1657635461215; Tue, 12
 Jul 2022 07:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-4-glider@google.com>
In-Reply-To: <20220701142310.2188015-4-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Jul 2022 16:17:05 +0200
Message-ID: <CANpmjNM9RkiXnqqdVSmpBJ0aw2hjZfmXGPQLgxAwWw+UfRHd7Q@mail.gmail.com>
Subject: Re: [PATCH v4 03/45] instrumented.h: allow instrumenting both sides
 of copy_from_user()
To:     Alexander Potapenko <glider@google.com>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 1 Jul 2022 at 16:23, Alexander Potapenko <glider@google.com> wrote:
>
> Introduce instrument_copy_from_user_before() and
> instrument_copy_from_user_after() hooks to be invoked before and after
> the call to copy_from_user().
>
> KASAN and KCSAN will be only using instrument_copy_from_user_before(),
> but for KMSAN we'll need to insert code after copy_from_user().
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
> v4:
>  -- fix _copy_from_user_key() in arch/s390/lib/uaccess.c (Reported-by:
>     kernel test robot <lkp@intel.com>)
>
> Link: https://linux-review.googlesource.com/id/I855034578f0b0f126734cbd734fb4ae1d3a6af99
> ---
>  arch/s390/lib/uaccess.c      |  3 ++-
>  include/linux/instrumented.h | 21 +++++++++++++++++++--
>  include/linux/uaccess.h      | 19 ++++++++++++++-----
>  lib/iov_iter.c               |  9 ++++++---
>  lib/usercopy.c               |  3 ++-
>  5 files changed, 43 insertions(+), 12 deletions(-)
>
> diff --git a/arch/s390/lib/uaccess.c b/arch/s390/lib/uaccess.c
> index d7b3b193d1088..58033dfcb6d45 100644
> --- a/arch/s390/lib/uaccess.c
> +++ b/arch/s390/lib/uaccess.c
> @@ -81,8 +81,9 @@ unsigned long _copy_from_user_key(void *to, const void __user *from,
>
>         might_fault();
>         if (!should_fail_usercopy()) {
> -               instrument_copy_from_user(to, from, n);
> +               instrument_copy_from_user_before(to, from, n);
>                 res = raw_copy_from_user_key(to, from, n, key);
> +               instrument_copy_from_user_after(to, from, n, res);
>         }
>         if (unlikely(res))
>                 memset(to + (n - res), 0, res);
> diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> index 42faebbaa202a..ee8f7d17d34f5 100644
> --- a/include/linux/instrumented.h
> +++ b/include/linux/instrumented.h
> @@ -120,7 +120,7 @@ instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
>  }
>
>  /**
> - * instrument_copy_from_user - instrument writes of copy_from_user
> + * instrument_copy_from_user_before - add instrumentation before copy_from_user
>   *
>   * Instrument writes to kernel memory, that are due to copy_from_user (and
>   * variants). The instrumentation should be inserted before the accesses.
> @@ -130,10 +130,27 @@ instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
>   * @n number of bytes to copy
>   */
>  static __always_inline void
> -instrument_copy_from_user(const void *to, const void __user *from, unsigned long n)
> +instrument_copy_from_user_before(const void *to, const void __user *from, unsigned long n)
>  {
>         kasan_check_write(to, n);
>         kcsan_check_write(to, n);
>  }
>
> +/**
> + * instrument_copy_from_user_after - add instrumentation after copy_from_user
> + *
> + * Instrument writes to kernel memory, that are due to copy_from_user (and
> + * variants). The instrumentation should be inserted after the accesses.
> + *
> + * @to destination address
> + * @from source address
> + * @n number of bytes to copy
> + * @left number of bytes not copied (as returned by copy_from_user)
> + */
> +static __always_inline void
> +instrument_copy_from_user_after(const void *to, const void __user *from,
> +                               unsigned long n, unsigned long left)
> +{
> +}
> +
>  #endif /* _LINUX_INSTRUMENTED_H */
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 5a328cf02b75e..da16e96680cf1 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -58,20 +58,28 @@
>  static __always_inline __must_check unsigned long
>  __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
>  {
> -       instrument_copy_from_user(to, from, n);
> +       unsigned long res;
> +
> +       instrument_copy_from_user_before(to, from, n);
>         check_object_size(to, n, false);
> -       return raw_copy_from_user(to, from, n);
> +       res = raw_copy_from_user(to, from, n);
> +       instrument_copy_from_user_after(to, from, n, res);
> +       return res;
>  }
>
>  static __always_inline __must_check unsigned long
>  __copy_from_user(void *to, const void __user *from, unsigned long n)
>  {
> +       unsigned long res;
> +
>         might_fault();
> +       instrument_copy_from_user_before(to, from, n);
>         if (should_fail_usercopy())
>                 return n;
> -       instrument_copy_from_user(to, from, n);
>         check_object_size(to, n, false);
> -       return raw_copy_from_user(to, from, n);
> +       res = raw_copy_from_user(to, from, n);
> +       instrument_copy_from_user_after(to, from, n, res);
> +       return res;
>  }
>
>  /**
> @@ -115,8 +123,9 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
>         unsigned long res = n;
>         might_fault();
>         if (!should_fail_usercopy() && likely(access_ok(from, n))) {
> -               instrument_copy_from_user(to, from, n);
> +               instrument_copy_from_user_before(to, from, n);
>                 res = raw_copy_from_user(to, from, n);
> +               instrument_copy_from_user_after(to, from, n, res);
>         }
>         if (unlikely(res))
>                 memset(to + (n - res), 0, res);
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 0b64695ab632f..fe5d169314dbf 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -159,13 +159,16 @@ static int copyout(void __user *to, const void *from, size_t n)
>
>  static int copyin(void *to, const void __user *from, size_t n)
>  {
> +       size_t res = n;
> +
>         if (should_fail_usercopy())
>                 return n;
>         if (access_ok(from, n)) {
> -               instrument_copy_from_user(to, from, n);
> -               n = raw_copy_from_user(to, from, n);
> +               instrument_copy_from_user_before(to, from, n);
> +               res = raw_copy_from_user(to, from, n);
> +               instrument_copy_from_user_after(to, from, n, res);
>         }
> -       return n;
> +       return res;
>  }
>
>  static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, size_t bytes,
> diff --git a/lib/usercopy.c b/lib/usercopy.c
> index 7413dd300516e..1505a52f23a01 100644
> --- a/lib/usercopy.c
> +++ b/lib/usercopy.c
> @@ -12,8 +12,9 @@ unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n
>         unsigned long res = n;
>         might_fault();
>         if (!should_fail_usercopy() && likely(access_ok(from, n))) {
> -               instrument_copy_from_user(to, from, n);
> +               instrument_copy_from_user_before(to, from, n);
>                 res = raw_copy_from_user(to, from, n);
> +               instrument_copy_from_user_after(to, from, n, res);
>         }
>         if (unlikely(res))
>                 memset(to + (n - res), 0, res);
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
