Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5766560702E
	for <lists+linux-arch@lfdr.de>; Fri, 21 Oct 2022 08:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJUGjw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Oct 2022 02:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJUGju (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Oct 2022 02:39:50 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5AB4D14F;
        Thu, 20 Oct 2022 23:39:48 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a6so2422634ljq.5;
        Thu, 20 Oct 2022 23:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FFzVqav4ytL2f0CsiBF+eInTfMA8Iy0X1Q8WlCib4/Q=;
        b=EeuUWgJRyRVkPZSaJYbew7R1hyU+bTUqCMY7+N+xsileGZvgqQhRjJwIFKuO7HmDrb
         bQHMgelR1wfFrvqjoMmlaGOLdTRP9gMDOWOXbUg2AJYoFDXMNqi+SKBmAq6zGoeREQNz
         Y4WFohrE7QxGDnjHl2VqAyMJ/gTHDLhC8MhuyDd/nj+RAjS1ZAG1gml6XdBRPTdSkVCs
         2/N+X0Qyxim7k5rXj4vRb9R1jRMgCaOPyyLGjC39SUnku+JYkTaArB0q2xT0LPxg7B7v
         +G7VV7ut0/i2IDbQF6qohLPQelmq4jhw2U846FOs07YLHodWw5gXtquQeY3o0P1/5jwm
         LSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FFzVqav4ytL2f0CsiBF+eInTfMA8Iy0X1Q8WlCib4/Q=;
        b=C4Xy+JnWOrzz2M0JeiIZyk8nSfdoYnX1q9SiufvGEYw2mLA9nk44zoyggJxuJjSZkn
         Y6cLRJsyqTjNckRGP0iTvAbzLJgJ1VlzKvaKLepR4/iuvUsOFQK2Kft+Dot03ODQWNuc
         kvfH6njuiwK+AKjm28z7uJOl0Hbi1KHrdM8Kvjz43RY2DzmS7UkHS6kJ1rxknicZrB6Z
         D18oSKT/6FoL8+eghWV95rOdDKeYCgrhiTD0BjNEuD+qIIoq27fvI79OTLBdnQgs0GYI
         KLWP6Ls/RbvVlUhkVkx6DpJp+GKA7Bg/jAMdm4viskVYOzcTdLY11f78VilN/LHazvgv
         QQ5Q==
X-Gm-Message-State: ACrzQf2G0M77hCmtzoZPtPIExLSp1T/BaY1adu2OkhLL7gXwlq5yIJ5J
        QNU0JxlpDYceOOvCNqKNB2nb7htssBXtYOcfcv0=
X-Google-Smtp-Source: AMsMyM4sbtX82B5mKKEHXGcxQPQfO0Xlq0H1c39lDL8xvOXWXw5Gb+e0I9Rx/xGyhKm+X9hJsrod4+dymJAVsZtidxk=
X-Received: by 2002:a2e:9652:0:b0:276:34ad:75c0 with SMTP id
 z18-20020a2e9652000000b0027634ad75c0mr398362ljh.59.1666334386089; Thu, 20 Oct
 2022 23:39:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:5411:0:b0:1f6:575a:5fb7 with HTTP; Thu, 20 Oct 2022
 23:39:44 -0700 (PDT)
In-Reply-To: <CANpmjNMUCsRm9qmi5eydHUHP2f5Y+Bt_thA97j8ZrEa5PN3sQg@mail.gmail.com>
References: <20220915150417.722975-19-glider@google.com> <20221019173620.10167-1-youling257@gmail.com>
 <CAOzgRda_CToTVicwxx86E7YcuhDTcayJR=iQtWQ3jECLLhHzcg@mail.gmail.com>
 <CANpmjNMPKokoJVFr9==-0-+O1ypXmaZnQT3hs4Ys0Y4+o86OVA@mail.gmail.com>
 <CAOzgRdbbVWTWR0r4y8u5nLUeANA7bU-o5JxGCHQ3r7Ht+TCg1Q@mail.gmail.com>
 <Y1BXQlu+JOoJi6Yk@elver.google.com> <CAOzgRdY6KSxDMRJ+q2BWHs4hRQc5y-PZ2NYG++-AMcUrO8YOgA@mail.gmail.com>
 <Y1Bt+Ia93mVV/lT3@elver.google.com> <CAG_fn=WLRN=C1rKrpq4=d=AO9dBaGxoa6YsG7+KrqAck5Bty0Q@mail.gmail.com>
 <CAOzgRdb+W3_FuOB+P_HkeinDiJdgpQSsXMC4GArOSixL9K5avg@mail.gmail.com> <CANpmjNMUCsRm9qmi5eydHUHP2f5Y+Bt_thA97j8ZrEa5PN3sQg@mail.gmail.com>
From:   youling 257 <youling257@gmail.com>
Date:   Fri, 21 Oct 2022 14:39:44 +0800
Message-ID: <CAOzgRdZsNWRHOUUksiOhGfC7XDc+Qs2TNKtXQyzm2xj4to+Y=Q@mail.gmail.com>
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PerfTop:    8253 irqs/sec  kernel:75.3%  exact: 100.0% lost: 0/0 drop:
0/17899 [4000Hz cycles],  (all, 8 CPUs)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    14.87%  [kernel]              [k] 0xffffffff941d1f37
     6.71%  [kernel]              [k] 0xffffffff942016cf

what is 0xffffffff941d1f37?

2022-10-21 14:16 GMT+08:00, Marco Elver <elver@google.com>:
> On Thu, 20 Oct 2022 at 22:55, youling 257 <youling257@gmail.com> wrote:
>>
>> How to use perf tool?
>
> The simplest would be to try just "perf top" - and see which kernel
> functions consume most CPU cycles. I would suggest you compare both
> kernels, and see if you can spot a function which uses more cycles% in
> the problematic kernel.
>
