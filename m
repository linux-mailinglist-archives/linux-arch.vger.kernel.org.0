Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0046F606FEC
	for <lists+linux-arch@lfdr.de>; Fri, 21 Oct 2022 08:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiJUGR0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Oct 2022 02:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJUGRZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Oct 2022 02:17:25 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121DC237949
        for <linux-arch@vger.kernel.org>; Thu, 20 Oct 2022 23:17:25 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-369c2f83697so7225627b3.3
        for <linux-arch@vger.kernel.org>; Thu, 20 Oct 2022 23:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zIf8ZNnAW78yhJlmbsbMxnLGL5lK8A9xrLkSuvVZ5vY=;
        b=SkzcDLX4HCkfZeJ9ffrRFeR1h5/bxkAsdXmLb5xZZmI03lb+SNf+d4CJAr80URmmy0
         VR5Di0JZnz+kr3tals3VVIh3jR2iWhSZI/NM5+uOl5cKJIRiARAj20NYRdK/pq2DsehB
         ftLO6oIhs1qZ+0gh/jwgpJXcIAhFxuKoHcih6iyh8wkmy3epW/EeJamTH/OgoRUKgxzV
         T6HWPkAnzVQdg206eX9SlmLMsow6Tw234D7CwkIlwxvQVbEcbRtlwmVWYANJOjYAVQKD
         YCCFizqNNPoPYI1thXrJENlejclBt0Zn8gxFlPWCCBlC3wvG6Gp6FIIYGziDgBDs/3N+
         3MMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIf8ZNnAW78yhJlmbsbMxnLGL5lK8A9xrLkSuvVZ5vY=;
        b=t1xXae6I7LEh3josDgy+DhVIBE6VJoeI8CvUmIDMMQR59JKfC/H4WQQ+Qc6a2EKqkM
         pwf8UxMi5lUss1tgLLZzis72wuCltvPITeIF1HsZzr3Sfvn7wwBd4NcaPJZkDLfJfSDR
         zhTLBmbL75FkjQrTNayJG0FIuuLG4NUkBcwTGltPgXJKf/RMxnsfc/4SeXYA+/HsRV6J
         RF4t2GHIZe0TWGJPP0JLLmgBdadCu3UvvdrS2T5KCj9HNXayOPVb2h6orMPXeVHQTZjH
         bB8uNo/NZDlKTFAntH2U6ROrDII90nShEunEB/ncOCtnnxCevlcrr887az+F/bgI9mci
         aqXw==
X-Gm-Message-State: ACrzQf0dfoPgCr58GQuusVHwFUQwr2cYfORZq32IQDN/6+n69AHEstQw
        NM3iNH2mDzTnhJWK9xUILRQJD+xUsZywNCN80qMqWw==
X-Google-Smtp-Source: AMsMyM7wJTOUnM+n70HWlfhBUHKFGcN4iKPxR8GF36jf5eJRQLjoB9h8ZtenONZtSS8A8XeX5r7Z9kot0IMW+IJOSFQ=
X-Received: by 2002:a81:1c07:0:b0:358:6e7d:5118 with SMTP id
 c7-20020a811c07000000b003586e7d5118mr16062156ywc.255.1666333044032; Thu, 20
 Oct 2022 23:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220915150417.722975-19-glider@google.com> <20221019173620.10167-1-youling257@gmail.com>
 <CAOzgRda_CToTVicwxx86E7YcuhDTcayJR=iQtWQ3jECLLhHzcg@mail.gmail.com>
 <CANpmjNMPKokoJVFr9==-0-+O1ypXmaZnQT3hs4Ys0Y4+o86OVA@mail.gmail.com>
 <CAOzgRdbbVWTWR0r4y8u5nLUeANA7bU-o5JxGCHQ3r7Ht+TCg1Q@mail.gmail.com>
 <Y1BXQlu+JOoJi6Yk@elver.google.com> <CAOzgRdY6KSxDMRJ+q2BWHs4hRQc5y-PZ2NYG++-AMcUrO8YOgA@mail.gmail.com>
 <Y1Bt+Ia93mVV/lT3@elver.google.com> <CAG_fn=WLRN=C1rKrpq4=d=AO9dBaGxoa6YsG7+KrqAck5Bty0Q@mail.gmail.com>
 <CAOzgRdb+W3_FuOB+P_HkeinDiJdgpQSsXMC4GArOSixL9K5avg@mail.gmail.com>
In-Reply-To: <CAOzgRdb+W3_FuOB+P_HkeinDiJdgpQSsXMC4GArOSixL9K5avg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 20 Oct 2022 23:16:47 -0700
Message-ID: <CANpmjNMUCsRm9qmi5eydHUHP2f5Y+Bt_thA97j8ZrEa5PN3sQg@mail.gmail.com>
Subject: Re: [PATCH v7 18/43] instrumented.h: add KMSAN support
To:     youling 257 <youling257@gmail.com>
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

On Thu, 20 Oct 2022 at 22:55, youling 257 <youling257@gmail.com> wrote:
>
> How to use perf tool?

The simplest would be to try just "perf top" - and see which kernel
functions consume most CPU cycles. I would suggest you compare both
kernels, and see if you can spot a function which uses more cycles% in
the problematic kernel.
