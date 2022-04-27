Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AB4511232
	for <lists+linux-arch@lfdr.de>; Wed, 27 Apr 2022 09:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358686AbiD0HSj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Apr 2022 03:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358692AbiD0HSi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2022 03:18:38 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CABB18361;
        Wed, 27 Apr 2022 00:15:17 -0700 (PDT)
Received: from mail-yb1-f180.google.com ([209.85.219.180]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MJVU0-1nPjat3wIS-00JqT6; Wed, 27 Apr 2022 09:15:16 +0200
Received: by mail-yb1-f180.google.com with SMTP id w17so1715863ybh.9;
        Wed, 27 Apr 2022 00:15:15 -0700 (PDT)
X-Gm-Message-State: AOAM533E2K1UKjQFKhxNn/wdImyAEmBaafMaXYWOvCMulOdDVFdC9ijE
        Zm/D+8CvgAwimat2r9gkZmpVLphVqGAuYeO5QqQ=
X-Google-Smtp-Source: ABdhPJwaD1kOWmwPG8YXCJoPZvqoD54e+nnssat4O6xYNRUCaG64TDt/4SOl6wpW8DE+BePexx2QnPchQt4gdqTD0N8=
X-Received: by 2002:a25:c604:0:b0:645:d969:97a7 with SMTP id
 k4-20020a25c604000000b00645d96997a7mr20381066ybf.134.1651043704287; Wed, 27
 Apr 2022 00:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220426164315.625149-1-glider@google.com> <20220426164315.625149-6-glider@google.com>
In-Reply-To: <20220426164315.625149-6-glider@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Apr 2022 09:14:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2eDDAAQ8RiQi0B+Jk4KvGeMk+pe78RB+bB9qwTTyhuag@mail.gmail.com>
Message-ID: <CAK8P3a2eDDAAQ8RiQi0B+Jk4KvGeMk+pe78RB+bB9qwTTyhuag@mail.gmail.com>
Subject: Re: [PATCH v3 05/46] x86: asm: instrument usercopy in get_user() and __put_user_size()
To:     Alexander Potapenko <glider@google.com>
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
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:X825Nodsp/CILpTFtsaUc0WqmlMiOdJWzevNH4xFQGBXKufG+O9
 DShGp8pTm7eRlyTooBJO8zwF/De5Wf7IvyAFn0Gog4gPQ0f+3onWS2ZWVKVgf1sP3OD7cjc
 aaGMv0hF/PZbLWkRZ+lSqMbnh+dJqCqfF2O0Zlas+maOkYQrJJO0FBS8VcUi3fAQEkvtJFo
 jetBEutOri6z3WtTCzMPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:12eyt6cQDXI=:8QIbwNy4LP8WPQWFVHlWHU
 e/YPQYO3s12X/fDA6oxZ3hCKFlp8qR04u+RkK57XAvRjtYAEq517/fuEjA4PCWy1Hwwvl1F6c
 ++XWcZLbnjCh7SXkZ1SJ3iUME/7yBmjptkHCKmJQ+5pepHcGs2eDvI+Cqqaegt2fxRw4XZCHt
 D2vyr62TtToYwOeSUI02/gf859OzVFMs4Az960I4nFiYQrP1DdlePOVR5XFy1QRdRTSU1M7cT
 0db8mDjL1z8ZStXuQOrYp3JXkTDwzXHC6TnyEQR7krnmLXHANvfvncE3TGk8DocG+3dtovCEZ
 cfIj+mcbeDgsqmS3LeW9VX19CBY5QYrZxbEJWIeL+UyizIEGAPjAOcexTrgVP2Z8NBen2JaDs
 A120nq7iJmfagKAeaATAF414EqqkCHiUlIPFaEdyXPN+F4HL13k+iRfkyw4zf0HGYUI0oQuCR
 6nuVEiKFHVgXMH41Gq8711UNohSjWfVr853Csiz6D9HW30zTrqMD4p5cCCGAX2/LnpdJE+rT6
 1ZsVA46LEeQo4k2wIcpvjnkpUqGcxwJLj+Fk+GxkTFrORaFqQJcYes/QsTFO+AcOo3wQBoxEC
 wYGAdehiyGui/UMvXkU5MB55PlzlytpjDsH0XxsRs5me29OsZKqPqxWXOSO7/okvPpiiQtpD+
 b514fgcGooNVehZcW1LGBXB4I+Gz9e4Q8HiunEueeWS72w/ZmmGPLjbiebCsmmDzx+X8Mdz7U
 0DY8Kb1oboqDlOAtOCtqF8b/fELc0/AgA/QjMacS0u8Lp/ZrFQIyhfcE95l0AwVs7octblUmf
 XjfsqZIGo0NeODzJASPK3SVFrhg6R4kjIloqCIVOOzAHHAvGD0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 26, 2022 at 6:42 PM Alexander Potapenko <glider@google.com> wrote:
> @@ -99,11 +100,13 @@ extern int __get_user_bad(void);
>         int __ret_gu;                                                   \
>         register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);            \
>         __chk_user_ptr(ptr);                                            \
> +       instrument_copy_from_user_before((void *)&(x), ptr, sizeof(*(ptr))); \
>         asm volatile("call __" #fn "_%P4"                               \
>                      : "=a" (__ret_gu), "=r" (__val_gu),                \
>                         ASM_CALL_CONSTRAINT                             \
>                      : "0" (ptr), "i" (sizeof(*(ptr))));                \
>         (x) = (__force __typeof__(*(ptr))) __val_gu;                    \
> +       instrument_copy_from_user_after((void *)&(x), ptr, sizeof(*(ptr)), 0); \

Isn't "ptr" the original pointer here? I think what happened with the
reported warning is that you get one output line for every instance this
is used in. There should probably be a

      __auto_type __ptr = (ptr);

at the beginning of the macro to ensure that 'ptr' is only evaluated once.

>>> arch/x86/kernel/signal.c:360:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long long [usertype] * @@

It would also make sense to add the missing __user annotation in this line, but
I suspect there are others like it in drivers.

      Arnd
