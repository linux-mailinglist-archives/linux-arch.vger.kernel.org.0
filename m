Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B370660850A
	for <lists+linux-arch@lfdr.de>; Sat, 22 Oct 2022 08:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJVGYK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 22 Oct 2022 02:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJVGYJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 22 Oct 2022 02:24:09 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB2224471B;
        Fri, 21 Oct 2022 23:24:08 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bu25so8686948lfb.3;
        Fri, 21 Oct 2022 23:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3DG5ojxl17Jx3b6LFi8HNNnUkTD/weGMM5iXG8GMb4=;
        b=ArxARJFVuoVE+iD/fesTfpO7v2JXNqmiVwncYu/T8Yaha4e9Xkptb8xqtYmz6hHqRS
         nyijsu7bQEeezQWccJe/eHXXfOrRdxJmUBWNusYlwDcaDl1tWUzonuhmrWpOliF06EIJ
         GwpQBfH5D4g8x96tYZOPNHKh2yBpF1o6VErmIW7Wwua9B55oBfgzCrG+YJbtqhg7Lqjl
         hjVcThyFzimOv16DDLWjJ0xL9ks4tJDzEXBf4V97s47S0DXm4QtTHVYyLNouZAJRmikw
         U7gyFYxdxcqKWs7EY7z9UBHuIpgIgG5+t1M5b01WXqs9i+KdXIKDD9p/T0gRtZT4Qykb
         +JOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3DG5ojxl17Jx3b6LFi8HNNnUkTD/weGMM5iXG8GMb4=;
        b=65ys93m2N9EBwaeINswp3HOIQiWCfIJ+9ytuvazBNQagfz+9re+iVyqM9HszXCD3iL
         I7S2nCtWwe9Wyc8HAU2WR3KqOK9Wsqmw60Z0LbqgjtGWoGqJhSUNr4/hZRZnsGHUwnNI
         zItQ4si4a+Try/JXpw77TZ6jRri+xWtrwpStxRLf/rF3qIL8noW0Dj9cS2Z6lVBzhQU4
         tCUoqQtMOjkR/0XDaFo/WitSIEvtHkSBLEETCTQxiyNH7RafBUNKvEaoTP/facsAE0qq
         1t0ClHQlv4j8KPl9z2EhuToEj5Z4d9YS/DaEre8WlaoiRNKUnHx19OdEmOn2cWOipWJA
         8Ueg==
X-Gm-Message-State: ACrzQf0zivJQO9dic+Kg5XXg02Ton+YTs6/lzeEHBzsshYBY88j7qphg
        gTPvw64OneHBjmS5IgoUYBTKxiaw0NOOP1qF9wc=
X-Google-Smtp-Source: AMsMyM4SGLSVHu74dsMs8vTf3aI2BSTZ4xR6qP3Ex7SHc9C12m6OkOlrqv5yJI0OUGGcpgKXM4QEJf0eqtUxhQnmqqY=
X-Received: by 2002:a19:7414:0:b0:4a2:260e:6408 with SMTP id
 v20-20020a197414000000b004a2260e6408mr7905720lfe.366.1666419846130; Fri, 21
 Oct 2022 23:24:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:5411:0:b0:1f6:575a:5fb7 with HTTP; Fri, 21 Oct 2022
 23:24:05 -0700 (PDT)
In-Reply-To: <CAG_fn=UVARRueXn4mU51TkzLTpZ=2fKNL7NAB3YH7mGP71ZhUQ@mail.gmail.com>
References: <20220915150417.722975-19-glider@google.com> <20221019173620.10167-1-youling257@gmail.com>
 <CAOzgRda_CToTVicwxx86E7YcuhDTcayJR=iQtWQ3jECLLhHzcg@mail.gmail.com>
 <CANpmjNMPKokoJVFr9==-0-+O1ypXmaZnQT3hs4Ys0Y4+o86OVA@mail.gmail.com>
 <CAOzgRdbbVWTWR0r4y8u5nLUeANA7bU-o5JxGCHQ3r7Ht+TCg1Q@mail.gmail.com>
 <Y1BXQlu+JOoJi6Yk@elver.google.com> <CAOzgRdY6KSxDMRJ+q2BWHs4hRQc5y-PZ2NYG++-AMcUrO8YOgA@mail.gmail.com>
 <Y1Bt+Ia93mVV/lT3@elver.google.com> <CAG_fn=WLRN=C1rKrpq4=d=AO9dBaGxoa6YsG7+KrqAck5Bty0Q@mail.gmail.com>
 <CAOzgRdb+W3_FuOB+P_HkeinDiJdgpQSsXMC4GArOSixL9K5avg@mail.gmail.com>
 <CANpmjNMUCsRm9qmi5eydHUHP2f5Y+Bt_thA97j8ZrEa5PN3sQg@mail.gmail.com>
 <CAOzgRdZsNWRHOUUksiOhGfC7XDc+Qs2TNKtXQyzm2xj4to+Y=Q@mail.gmail.com>
 <CANpmjNPUqVwHLVg5weN3+m7RJ7pCfDjBqJ2fBKueeMzKn=R=jA@mail.gmail.com>
 <CAOzgRdYr82TztbX4j7SDjJFiTd8b1B60QZ7jPkNOebB-jO9Ocg@mail.gmail.com> <CAG_fn=UVARRueXn4mU51TkzLTpZ=2fKNL7NAB3YH7mGP71ZhUQ@mail.gmail.com>
From:   youling 257 <youling257@gmail.com>
Date:   Sat, 22 Oct 2022 14:24:05 +0800
Message-ID: <CAOzgRdYhgu3v_e02RFHi3+vCjYc1kmLMgy61zEX8P=RZQ4bi_w@mail.gmail.com>
Subject: Re: [PATCH v7 18/43] instrumented.h: add KMSAN support
To:     Alexander Potapenko <glider@google.com>
Cc:     Marco Elver <elver@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I test this patch fix my problem.

2022-10-22 4:37 GMT+08:00, Alexander Potapenko <glider@google.com>:
> On Fri, Oct 21, 2022 at 8:19 AM youling 257 <youling257@gmail.com> wrote:
>
>> CONFIG_DEBUG_INFO=y
>> CONFIG_AS_HAS_NON_CONST_LEB128=y
>> # CONFIG_DEBUG_INFO_NONE is not set
>> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
>> # CONFIG_DEBUG_INFO_DWARF4 is not set
>> # CONFIG_DEBUG_INFO_DWARF5 is not set
>> # CONFIG_DEBUG_INFO_REDUCED is not set
>> # CONFIG_DEBUG_INFO_COMPRESSED is not set
>> # CONFIG_DEBUG_INFO_SPLIT is not set
>> # CONFIG_DEBUG_INFO_BTF is not set
>> # CONFIG_GDB_SCRIPTS is not set
>>
>> perf top still no function name.
>>
>> 12.90%  [kernel]              [k] 0xffffffff833dfa64
>>
>
> I think I know what's going on. The two functions that differ with and
> without the patch were passing an incremented pointer to unsafe_put_user(),
> which is a macro, e.g.:
>
>    unsafe_put_user((compat_ulong_t)m, umask++, Efault);
>
> Because that macro didn't evaluate its second parameter, "umask++" was
> passed to a call to kmsan_copy_to_user(), which resulted in an extra
> increment of umask.
> This probably violated some expectations of the userspace app, which in
> turn led to repetitive kernel calls.
>
> Could you please check if the patch below fixes the problem for you?
>
> diff --git a/arch/x86/include/asm/uaccess.h
> b/arch/x86/include/asm/uaccess.h
> index 8bc614cfe21b9..1cc756eafa447 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -254,24 +254,25 @@ extern void __put_user_nocheck_8(void);
>  #define __put_user_size(x, ptr, size, label)                           \
>  do {                                                                   \
>         __typeof__(*(ptr)) __x = (x); /* eval x once */                 \
> -       __chk_user_ptr(ptr);                                            \
> +       __typeof__(ptr) __ptr = (ptr); /* eval ptr once */              \
> +       __chk_user_ptr(__ptr);                                          \
>         switch (size) {                                                 \
>         case 1:                                                         \
> -               __put_user_goto(__x, ptr, "b", "iq", label);            \
> +               __put_user_goto(__x, __ptr, "b", "iq", label);          \
>                 break;                                                  \
>         case 2:                                                         \
> -               __put_user_goto(__x, ptr, "w", "ir", label);            \
> +               __put_user_goto(__x, __ptr, "w", "ir", label);          \
>                 break;                                                  \
>         case 4:                                                         \
> -               __put_user_goto(__x, ptr, "l", "ir", label);            \
> +               __put_user_goto(__x, __ptr, "l", "ir", label);          \
>                 break;                                                  \
>         case 8:                                                         \
> -               __put_user_goto_u64(__x, ptr, label);                   \
> +               __put_user_goto_u64(__x, __ptr, label);                 \
>                 break;                                                  \
>         default:                                                        \
>                 __put_user_bad();                                       \
>         }                                                               \
> -       instrument_put_user(__x, ptr, size);                            \
> +       instrument_put_user(__x, __ptr, size);                          \
>  } while (0)
>
>  #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
>
