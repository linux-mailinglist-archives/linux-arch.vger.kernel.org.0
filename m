Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C09D607D64
	for <lists+linux-arch@lfdr.de>; Fri, 21 Oct 2022 19:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJURV3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Oct 2022 13:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJURVR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Oct 2022 13:21:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B721E43ADB;
        Fri, 21 Oct 2022 10:21:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 530A5B82C97;
        Fri, 21 Oct 2022 17:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031EDC433D6;
        Fri, 21 Oct 2022 17:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666372873;
        bh=OPwlLlEXlUzE6SL4e+b2hevX5SKArYC0yWnxgjj7sus=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=sbc+CEwFVrdgV+3XX2gN5R7aeuG3yA9k2SFXrB8q1bEjcXoN9v9gOFU3SgcOCK8QX
         j+TzFP0Lfvmc6iQU2s81SsujeSt/Ib8TdzIvi0tG2zMXq21Q5LSCWUxTFc7iO5PQ/u
         gTcvkEJNDIEtjpzWUB+FmgqdSPdW0Ti1pWm1t3F0aE73wfIz43jN+2NoRzm6eJb3rB
         TEVl5NRncUIBHYHuxYWKe97bT9DHp4whnjKVnGkiwBwXqGqmu54/rLkfeP5TCZV9xP
         GQywwtek77jbiJ+ruHzyNcZYPIdozGCvOgdVjk4NilRO78fRqBPD91FSq3nl77p7zf
         s0Oe1XIahIygQ==
Date:   Fri, 21 Oct 2022 10:21:12 -0700
From:   Kees Cook <kees@kernel.org>
To:     Alexander Potapenko <glider@google.com>,
        youling 257 <youling257@gmail.com>
CC:     Marco Elver <elver@google.com>,
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
Subject: Re: [PATCH v7 18/43] instrumented.h: add KMSAN support
User-Agent: K-9 Mail for Android
In-Reply-To: <CAG_fn=VE4qrXhLzEkNR_8PcO9N4AYYhNaXYvZNffvVEo7AHr-A@mail.gmail.com>
References: <20220915150417.722975-19-glider@google.com> <20221019173620.10167-1-youling257@gmail.com> <CAOzgRda_CToTVicwxx86E7YcuhDTcayJR=iQtWQ3jECLLhHzcg@mail.gmail.com> <CANpmjNMPKokoJVFr9==-0-+O1ypXmaZnQT3hs4Ys0Y4+o86OVA@mail.gmail.com> <CAOzgRdbbVWTWR0r4y8u5nLUeANA7bU-o5JxGCHQ3r7Ht+TCg1Q@mail.gmail.com> <Y1BXQlu+JOoJi6Yk@elver.google.com> <CAOzgRdY6KSxDMRJ+q2BWHs4hRQc5y-PZ2NYG++-AMcUrO8YOgA@mail.gmail.com> <Y1Bt+Ia93mVV/lT3@elver.google.com> <CAG_fn=WLRN=C1rKrpq4=d=AO9dBaGxoa6YsG7+KrqAck5Bty0Q@mail.gmail.com> <CAOzgRdb+W3_FuOB+P_HkeinDiJdgpQSsXMC4GArOSixL9K5avg@mail.gmail.com> <CANpmjNMUCsRm9qmi5eydHUHP2f5Y+Bt_thA97j8ZrEa5PN3sQg@mail.gmail.com> <CAOzgRdZsNWRHOUUksiOhGfC7XDc+Qs2TNKtXQyzm2xj4to+Y=Q@mail.gmail.com> <CANpmjNPUqVwHLVg5weN3+m7RJ7pCfDjBqJ2fBKueeMzKn=R=jA@mail.gmail.com> <CAOzgRdYr82TztbX4j7SDjJFiTd8b1B60QZ7jPkNOebB-jO9Ocg@mail.gmail.com> <CAG_fn=VE4qrXhLzEkNR_8PcO9N4AYYhNaXYvZNffvVEo7AHr-A@mail.gmail.com>
Message-ID: <EC4E1360-080B-4754-9A95-79B7246C5605@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On October 21, 2022 10:02:05 AM PDT, Alexander Potapenko <glider@google=2Ec=
om> wrote:
>On Fri, Oct 21, 2022 at 8:19 AM youling 257 <youling257@gmail=2Ecom> wrot=
e:
>
>> CONFIG_DEBUG_INFO=3Dy
>> CONFIG_AS_HAS_NON_CONST_LEB128=3Dy
>> # CONFIG_DEBUG_INFO_NONE is not set
>> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy
>> # CONFIG_DEBUG_INFO_DWARF4 is not set
>> # CONFIG_DEBUG_INFO_DWARF5 is not set
>> # CONFIG_DEBUG_INFO_REDUCED is not set
>> # CONFIG_DEBUG_INFO_COMPRESSED is not set
>> # CONFIG_DEBUG_INFO_SPLIT is not set
>> # CONFIG_DEBUG_INFO_BTF is not set
>> # CONFIG_GDB_SCRIPTS is not set
>>
>> perf top still no function name=2E
>>
>Will it help if you disable CONFIG_RANDOMIZE_BASE?
>(if it doesn't show the symbols, at least we'll be able to figure out the
>offending function by running nm)

Is KALLSYMS needed?

>
>
>>
>> 12=2E90%  [kernel]              [k] 0xffffffff833dfa64
>>      3=2E78%  [kernel]              [k] 0xffffffff8285b439
>>      3=2E61%  [kernel]              [k] 0xffffffff83370254
>>      2=2E32%  [kernel]              [k] 0xffffffff8337025b
>>      1=2E88%  bluetooth=2Edefault=2Eso  [=2E] 0x000000000000d09d
>>
>> 2022-10-21 15:37 GMT+08:00, Marco Elver <elver@google=2Ecom>:
>> > On Thu, 20 Oct 2022 at 23:39, youling 257 <youling257@gmail=2Ecom> wr=
ote:
>> >>
>> >> PerfTop:    8253 irqs/sec  kernel:75=2E3%  exact: 100=2E0% lost: 0/0=
 drop:
>> >> 0/17899 [4000Hz cycles],  (all, 8 CPUs)
>> >>
>> -----------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------------------------------------------------------------
>> >>
>> >>     14=2E87%  [kernel]              [k] 0xffffffff941d1f37
>> >>      6=2E71%  [kernel]              [k] 0xffffffff942016cf
>> >>
>> >> what is 0xffffffff941d1f37?
>> >
>> > You need to build with debug symbols:
>> > CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy
>> >
>> > Then it'll show function names=2E
>> >
>> >> 2022-10-21 14:16 GMT+08:00, Marco Elver <elver@google=2Ecom>:
>> >> > On Thu, 20 Oct 2022 at 22:55, youling 257 <youling257@gmail=2Ecom>
>> wrote:
>> >> >>
>> >> >> How to use perf tool?
>> >> >
>> >> > The simplest would be to try just "perf top" - and see which kerne=
l
>> >> > functions consume most CPU cycles=2E I would suggest you compare b=
oth
>> >> > kernels, and see if you can spot a function which uses more cycles=
% in
>> >> > the problematic kernel=2E
>> >> >
>> >
>>
>
>


--=20
Kees Cook
