Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A300D605061
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 21:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiJST3H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 15:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJST3F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 15:29:05 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA611960A3;
        Wed, 19 Oct 2022 12:29:04 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a6so23493634ljq.5;
        Wed, 19 Oct 2022 12:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1J+LkGJJsG58CkJ3Qd9XTdOjWMcQXIZDNg+2efZ9DT8=;
        b=Zs3D8ie/O78VXdUFRbswnnVyMUFKQTi+weY/1rbfp0bq2vH4HC+4WLyeQVMXHPYCAi
         2ECkR/KLht8Hyqa3u2Z0PQC1zsqs1nr5elWU/6lftN85gXuL4+vQ+fwZns1FtCnp5Jxw
         qSopG89Arj3LY54xjxvkbBdgMT/cgvL2QvQjYNBrWIDlqcHiJZ8wVIUNe5/p2yafobMH
         DnICUEblvNYeI69wK3h6gx1Kzy8oiKELAPgzmBmz7GTs97IH9q6ahlbKctexF3JZYQuW
         rwtwT7TvHoAVzG1+nXmvdN5ZyW5yDdOt/Y0LeejRX9gtyUXq0FHVQIDXv5ysgrta+ri0
         1nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1J+LkGJJsG58CkJ3Qd9XTdOjWMcQXIZDNg+2efZ9DT8=;
        b=6zWQSWgwRVFlroCS9neZlVrn446RpV3NSJfRwwUvWPr8R8s/4K/vRhh4980qGzTenG
         U077zQE8XbYzHVvxQsggbFikZuIGi49EdFZ4BnhQ5QpGvCjUKCP/pQS3CuxQOLza4PSq
         SFgBnyTptyZ1IXIDTbvkQHOSZWLsuB4lemrF07cLW1hEFabKQV5lWldRfrsbtSlgvZ/M
         YDYFPZapsBHDf0ckNj2zJ3q+/IvLt6J184Mgg8O4AsfxWph87bJeda3eL6+WYcIpRCAv
         YFx1Enhj8b8mBTPSBDHLIT3ytKELTwKfLnwtPQu+gpdW0ItEwBSrlI8w5P6qWljuKD1e
         teJg==
X-Gm-Message-State: ACrzQf11WoNgN8SdrcVNBLc+yF223TL5a1XW6nlclJxIbGuYbPnBTUwq
        73DWg8wVPkzQSNV/MqDj44AfBfQb+J4XIwk8jE0=
X-Google-Smtp-Source: AMsMyM4/a8mro7O35SGkjXAGwMZz8FGjEXZwFrLyoLo7XaOhAeR+5e35yobKB5fffcFn7Qi0JTM+jG1hgh5hA0qfPsg=
X-Received: by 2002:a2e:8796:0:b0:26e:8b13:a29c with SMTP id
 n22-20020a2e8796000000b0026e8b13a29cmr3457109lji.210.1666207742198; Wed, 19
 Oct 2022 12:29:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:5411:0:b0:1f6:575a:5fb7 with HTTP; Wed, 19 Oct 2022
 12:29:01 -0700 (PDT)
In-Reply-To: <CANpmjNMPKokoJVFr9==-0-+O1ypXmaZnQT3hs4Ys0Y4+o86OVA@mail.gmail.com>
References: <20220915150417.722975-19-glider@google.com> <20221019173620.10167-1-youling257@gmail.com>
 <CAOzgRda_CToTVicwxx86E7YcuhDTcayJR=iQtWQ3jECLLhHzcg@mail.gmail.com> <CANpmjNMPKokoJVFr9==-0-+O1ypXmaZnQT3hs4Ys0Y4+o86OVA@mail.gmail.com>
From:   youling 257 <youling257@gmail.com>
Date:   Thu, 20 Oct 2022 03:29:01 +0800
Message-ID: <CAOzgRdbbVWTWR0r4y8u5nLUeANA7bU-o5JxGCHQ3r7Ht+TCg1Q@mail.gmail.com>
Subject: Re: [PATCH v7 18/43] instrumented.h: add KMSAN support
To:     Marco Elver <elver@google.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

arch x86, this's my revert,
https://github.com/youling257/android-mainline/commit/401cbfa61cbfc20c87a5b=
e8e2dda68ac5702389f
i tried different revert, have to remove kmsan_copy_to_user.

2022-10-20 1:58 GMT+08:00, Marco Elver <elver@google.com>:
> On Wed, 19 Oct 2022 at 10:37, youling 257 <youling257@gmail.com> wrote:
>>
>>
>>
>> ---------- Forwarded message ---------
>> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A youling257 <youling257@gmail.com>
>> Date: 2022=E5=B9=B410=E6=9C=8820=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=
=8D=881:36
>> Subject: Re: [PATCH v7 18/43] instrumented.h: add KMSAN support
>> To: <glider@google.com>
>> Cc: <youling257@gmail.com>
>>
>>
>> i using linux kernel 6.1rc1 on android, i use gcc12 build kernel 6.1 for
>> android, CONFIG_KMSAN is not set.
>> "instrumented.h: add KMSAN support" cause android bluetooth high CPU
>> usage.
>> git bisect linux kernel 6.1rc1, "instrumented.h: add KMSAN support" is a
>> bad commit for my android.
>>
>> this is my kernel 6.1,  revert include/linux/instrumented.h fix high cpu
>> usage problem.
>> https://github.com/youling257/android-mainline/commits/6.1
>
> What arch?
> If x86, can you try to revert only the change to
> instrument_get_user()? (I wonder if the u64 conversion is causing
> issues.)
>
