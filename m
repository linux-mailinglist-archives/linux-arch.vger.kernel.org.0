Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A2D6050FF
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 22:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJSUHP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 16:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiJSUHO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 16:07:14 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2737E190E68;
        Wed, 19 Oct 2022 13:07:13 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id c20so23606822ljj.7;
        Wed, 19 Oct 2022 13:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7CNOQx77jxJkr8fo3A8KqRmFLYVGew+7knPtLNO80g=;
        b=awEFpEhcqOyuVVRGI60VVcsY5M+7n3ldfd1Do6gZB1LMVB3KIviAIQVoo0kYWTOHT8
         XM1MHj97CJzRipIruN5JqNCyKjUeAGAXbhnVmtZadyZlm7K0obdKSz1nbZdSRur3DoiH
         WpM0+oRZ17FZSFdsb0BHFWIRMTSgulfz/o0MFuuo3sKFZvdXVpgc1Z4QW6TK+DhHBE9/
         8VNXsPpSviKl/qU0YqAEakVFHyvMzyztSAOEde/r0NLVMzhuD+Ni1F2qG/zPZruDeEFL
         m5TGE/5ApV7g8brCcqclP/YXzChpw8AOm4ewYdXBFs/i/pe8Uw/3y84IWfdoPmZ3poQ0
         480Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7CNOQx77jxJkr8fo3A8KqRmFLYVGew+7knPtLNO80g=;
        b=PayZpNq2ycENY9bUxVfSVAwasNJQt0K4LjohFgKzsZjim0lFoEeQN1sKiZ8ZodkdRR
         UNlxzEK+W9Mp/ZFiiJ5b/RNnBASaD/TvM3+dhp0F4/zY5GkuHkvk215/tEYAJ8LvojuA
         CHuofo5ZuT1PJv8Eeq2wdOglOYz6NrLjM+v+0IjiZZhtHDLRMeI6+vCYxqg+2VNlz/uT
         wzAUSqvL7rNMVUwuk6/3W2Af2ZFgJwFQbUWhz9eASsI8ozfDVRghI9Yy5acns+ivjjx9
         pkSg0gFib5ETT2bWCISqVYElm4ZSnjK5TnKXpdxOr4KXo9GkymwH07bI7YndEWr1uB30
         Q15g==
X-Gm-Message-State: ACrzQf0AiqgujliC3byscTf3l7TSQvx/KVPSApIli4r/9OC6mo05mlyv
        7kcj6eMcwOA92dSvNp4kqDsDIz6DlDA6uCkAa9w=
X-Google-Smtp-Source: AMsMyM6sYCtQ57vM1AQbbV3fxrVxnMWB0NyC+Rv9m+1OQN0e2gDL0yS2/jvhhkzrg5lQMHkx2CWA73bYz/FN+wz9pwU=
X-Received: by 2002:a2e:2a03:0:b0:26d:ff37:f731 with SMTP id
 q3-20020a2e2a03000000b0026dff37f731mr3316534ljq.25.1666210031367; Wed, 19 Oct
 2022 13:07:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:5411:0:b0:1f6:575a:5fb7 with HTTP; Wed, 19 Oct 2022
 13:07:10 -0700 (PDT)
In-Reply-To: <Y1BXQlu+JOoJi6Yk@elver.google.com>
References: <20220915150417.722975-19-glider@google.com> <20221019173620.10167-1-youling257@gmail.com>
 <CAOzgRda_CToTVicwxx86E7YcuhDTcayJR=iQtWQ3jECLLhHzcg@mail.gmail.com>
 <CANpmjNMPKokoJVFr9==-0-+O1ypXmaZnQT3hs4Ys0Y4+o86OVA@mail.gmail.com>
 <CAOzgRdbbVWTWR0r4y8u5nLUeANA7bU-o5JxGCHQ3r7Ht+TCg1Q@mail.gmail.com> <Y1BXQlu+JOoJi6Yk@elver.google.com>
From:   youling 257 <youling257@gmail.com>
Date:   Thu, 20 Oct 2022 04:07:10 +0800
Message-ID: <CAOzgRdY6KSxDMRJ+q2BWHs4hRQc5y-PZ2NYG++-AMcUrO8YOgA@mail.gmail.com>
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

That is i did,i already test, remove "u64 __tmp=E2=80=A6kmsan_unpoison_memo=
ry", no help.
i only remove kmsan_copy_to_user, fix my issue.

2022-10-20 4:00 GMT+08:00, Marco Elver <elver@google.com>:
> On Thu, Oct 20, 2022 at 03:29AM +0800, youling 257 wrote:
> [...]
>> > What arch?
>> > If x86, can you try to revert only the change to
>> > instrument_get_user()? (I wonder if the u64 conversion is causing
>> > issues.)
>> >
>> arch x86, this's my revert,
>> https://github.com/youling257/android-mainline/commit/401cbfa61cbfc20c87=
a5be8e2dda68ac5702389f
>> i tried different revert, have to remove kmsan_copy_to_user.
>
> There you reverted only instrument_put_user() - does it fix the issue?
>
> If not, can you try only something like this (only revert
> instrument_get_user()):
>
> diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> index 501fa8486749..dbe3ec38d0e6 100644
> --- a/include/linux/instrumented.h
> +++ b/include/linux/instrumented.h
> @@ -167,9 +167,6 @@ instrument_copy_from_user_after(const void *to, const
> void __user *from,
>   */
>  #define instrument_get_user(to)				\
>  ({							\
> -	u64 __tmp =3D (u64)(to);				\
> -	kmsan_unpoison_memory(&__tmp, sizeof(__tmp));	\
> -	to =3D __tmp;					\
>  })
>
>
> Once we know which one of these is the issue, we can figure out a proper
> fix.
>
> Thanks,
>
> -- Marco
>
