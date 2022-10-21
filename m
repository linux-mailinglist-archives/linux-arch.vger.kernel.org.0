Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3CB607A5C
	for <lists+linux-arch@lfdr.de>; Fri, 21 Oct 2022 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiJUPTg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Oct 2022 11:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiJUPTd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Oct 2022 11:19:33 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A361ADB0;
        Fri, 21 Oct 2022 08:19:28 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g1so5622071lfu.12;
        Fri, 21 Oct 2022 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nLPDviM40EFa/Qu4CMFk6R9DVn/gn4Pe+x/zBYpv/KU=;
        b=XhEIMtohA6qebiZAOtvEzdbblBUp4RmVtoikpz0bOemQeKrz0hx6m5VW+QD50hW3h0
         2RjU721QaaqALbbUVPsNBdm5kJsuy33gZ1Fiyegf207NHPa3Km3EuydthPTsiTlxTlsV
         ttaj4LAfz+EEBtV0n5Ww6F/Ddgj0t6OilnUkR81XaimlbW5yfwKdFBeL870iMKzwNFwu
         EBDv+8HkoEW5pYtcWRSQMoRg84NPkjxDzsABW0MxlZJZBcU0pYgMogFmyJJsm54tDjeC
         j209GxYlVoKNiLpIA6jJThvQ5HmQjnRYcPennaza+uId3mgauL88T4TuWEMJ4sLx9EcM
         jQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLPDviM40EFa/Qu4CMFk6R9DVn/gn4Pe+x/zBYpv/KU=;
        b=GMN2kHuQ/J3tHP0feDpb0LPhHVPeTec5QMh2YGoJ6OVRLS8Y7eNEKqedFk2Ptp0fx3
         Nkg72mg0hJfjG4CoJcKlRWBJwTNMZGW5cC6NcpGPVXtuLtrHC3KVJQ3Jdn7fU2S4RvqZ
         XjI71TLXEDPYQ9+srhohSTZx126iB3PD/LNYpOkvaN2aqsoZJxMR8ZK19/HqLS6Rf1wY
         nZEKRdpgvE+wvrtGFTv+agei+KRtCwY1XGZEmg9Ari9XNCWfkW3gvIkI0wAPXe4Zw+KT
         NgzHomYGRiQy7c+FFUsVPL03B6Z2LTtBOJfwOry8LB6CJkIeopnU8AXlKmmztF2ArAtp
         4XvQ==
X-Gm-Message-State: ACrzQf0o4w2lcX2xBSwfimiI7iXGbwh7fRCj3coOPJlKBJbLwtwkY7ak
        ghnDMwVaa3eeYmUgNeeaGeEZmeB/zJqNSQkUjC0=
X-Google-Smtp-Source: AMsMyM512XVtiUKIJWXuDsQvik0/Z3SsK9ULwn0I2JQT+zvcMZWojkirDhRouC7SL5La3bSLv7lS2lxj1KygSodjF80=
X-Received: by 2002:a05:6512:4002:b0:4a2:6243:8384 with SMTP id
 br2-20020a056512400200b004a262438384mr6716302lfb.29.1666365566622; Fri, 21
 Oct 2022 08:19:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:5411:0:b0:1f6:575a:5fb7 with HTTP; Fri, 21 Oct 2022
 08:19:25 -0700 (PDT)
In-Reply-To: <CANpmjNPUqVwHLVg5weN3+m7RJ7pCfDjBqJ2fBKueeMzKn=R=jA@mail.gmail.com>
References: <20220915150417.722975-19-glider@google.com> <20221019173620.10167-1-youling257@gmail.com>
 <CAOzgRda_CToTVicwxx86E7YcuhDTcayJR=iQtWQ3jECLLhHzcg@mail.gmail.com>
 <CANpmjNMPKokoJVFr9==-0-+O1ypXmaZnQT3hs4Ys0Y4+o86OVA@mail.gmail.com>
 <CAOzgRdbbVWTWR0r4y8u5nLUeANA7bU-o5JxGCHQ3r7Ht+TCg1Q@mail.gmail.com>
 <Y1BXQlu+JOoJi6Yk@elver.google.com> <CAOzgRdY6KSxDMRJ+q2BWHs4hRQc5y-PZ2NYG++-AMcUrO8YOgA@mail.gmail.com>
 <Y1Bt+Ia93mVV/lT3@elver.google.com> <CAG_fn=WLRN=C1rKrpq4=d=AO9dBaGxoa6YsG7+KrqAck5Bty0Q@mail.gmail.com>
 <CAOzgRdb+W3_FuOB+P_HkeinDiJdgpQSsXMC4GArOSixL9K5avg@mail.gmail.com>
 <CANpmjNMUCsRm9qmi5eydHUHP2f5Y+Bt_thA97j8ZrEa5PN3sQg@mail.gmail.com>
 <CAOzgRdZsNWRHOUUksiOhGfC7XDc+Qs2TNKtXQyzm2xj4to+Y=Q@mail.gmail.com> <CANpmjNPUqVwHLVg5weN3+m7RJ7pCfDjBqJ2fBKueeMzKn=R=jA@mail.gmail.com>
From:   youling 257 <youling257@gmail.com>
Date:   Fri, 21 Oct 2022 23:19:25 +0800
Message-ID: <CAOzgRdYr82TztbX4j7SDjJFiTd8b1B60QZ7jPkNOebB-jO9Ocg@mail.gmail.com>
Subject: Re: [PATCH v7 18/43] instrumented.h: add KMSAN support
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set

perf top still no function name.

12.90%  [kernel]              [k] 0xffffffff833dfa64
     3.78%  [kernel]              [k] 0xffffffff8285b439
     3.61%  [kernel]              [k] 0xffffffff83370254
     2.32%  [kernel]              [k] 0xffffffff8337025b
     1.88%  bluetooth.default.so  [.] 0x000000000000d09d

2022-10-21 15:37 GMT+08:00, Marco Elver <elver@google.com>:
> On Thu, 20 Oct 2022 at 23:39, youling 257 <youling257@gmail.com> wrote:
>>
>> PerfTop:    8253 irqs/sec  kernel:75.3%  exact: 100.0% lost: 0/0 drop:
>> 0/17899 [4000Hz cycles],  (all, 8 CPUs)
>> ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>>
>>     14.87%  [kernel]              [k] 0xffffffff941d1f37
>>      6.71%  [kernel]              [k] 0xffffffff942016cf
>>
>> what is 0xffffffff941d1f37?
>
> You need to build with debug symbols:
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
>
> Then it'll show function names.
>
>> 2022-10-21 14:16 GMT+08:00, Marco Elver <elver@google.com>:
>> > On Thu, 20 Oct 2022 at 22:55, youling 257 <youling257@gmail.com> wrote:
>> >>
>> >> How to use perf tool?
>> >
>> > The simplest would be to try just "perf top" - and see which kernel
>> > functions consume most CPU cycles. I would suggest you compare both
>> > kernels, and see if you can spot a function which uses more cycles% in
>> > the problematic kernel.
>> >
>
