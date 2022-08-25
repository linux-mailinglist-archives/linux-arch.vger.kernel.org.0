Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DDE5A1BB9
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 23:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244116AbiHYVy2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 17:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244118AbiHYVy0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 17:54:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2846B1BAA
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 14:54:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b44so7538541edf.9
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 14:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=LL7WsDHbFm5E+eXFntbV7YAH3fSJ/uBWE2CxgYTPVj4=;
        b=H+RsnqVaIXkUild8vuZkOvOlcglKNftG6coYigDxEsYP6mD1FHEmQt2p9v1se5g6CW
         gID96igO0YRsUG8XVCnS34RTQZMRCdVbyKVDiGFMRH8RuQzY6APzQ5Ik7akW9J9n7x5r
         HxZokq5AaOzjYNLYiCVZjX9P/x7xEX5JYiaYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LL7WsDHbFm5E+eXFntbV7YAH3fSJ/uBWE2CxgYTPVj4=;
        b=eomZVNM3onhdAoYBlW7BmwyviEkRJXWkxlX2mpVP2Fw2kDC02mhcx8Nq0ayHUqb1m7
         QYNmCf9r2gxvZSyK9eyeMTd5Al7ivH9+ktH6jBTDCG1asrGNHbKvmn9H5LGhsQeKbSLO
         zY0E0PseSDEs32+6ck0yb9Nmii523OxXiBpSQUMfrYbKV0v5haJnzSd5c+c7PwEYLPUF
         UO2xr6m24MxnUtvCj4QWM2niPULcDIbSu+UFGIihTRJ4Spcf2tV60zPPJFlob5KS4lIg
         0zFl+hbY0mXOT8ajQSmO9B0E/0u3Khq9DJyQ8xhpUSHvWkvJYJpegm43pHZSIN4Lw5Hq
         nI9A==
X-Gm-Message-State: ACgBeo0uJi+EhPMKQPScSkBKdg5eWl7B2nmshmzO6jVQnCmAWZwiz3+B
        qD6+P8dbj9xquQf/dzgaDGfzVqrT4z8nTs6crHY=
X-Google-Smtp-Source: AA6agR6vU+pKQ8v3o1yuouCBgtMZdRSErYXUpRFui2hoHG1sIEcC1vMMcqRipaduhxWkfun+f5Oqjw==
X-Received: by 2002:aa7:d6c8:0:b0:447:b278:5ba5 with SMTP id x8-20020aa7d6c8000000b00447b2785ba5mr3879403edr.217.1661464459390;
        Thu, 25 Aug 2022 14:54:19 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906125000b0073d6093ac93sm144442eja.16.2022.08.25.14.54.17
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 14:54:18 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso3182873wmr.3
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 14:54:17 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:3a6:28:bc59 with SMTP id
 g14-20020a05600c4ece00b003a60028bc59mr9253819wmq.154.1661464457383; Thu, 25
 Aug 2022 14:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
 <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com> <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Aug 2022 14:54:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com>
Message-ID: <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com>
Subject: Re: [PATCH] wait_on_bit: add an acquire memory barrier
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 25, 2022 at 2:03 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> Here I reworked your patch, so that test_bit_acquire is defined just like
> test_bit. There's some code duplication (in
> include/asm-generic/bitops/generic-non-atomic.h and in
> arch/x86/include/asm/bitops.h), but that duplication exists in the
> test_bit function too.

This looks fine to me, and I like how you fixed up buffer_uptodate()
while at it.

> I tested it on x86-64 and arm64. On x86-64 it generates the "bt"
> instruction for variable-bit test and "shr; and $1" for constant bit test.

That shr/and is almost certainly pessimal for small constant values at
least, and it's better done as "movq %rax" followed by "test %rax".
But I guess it depends on the bit value (and thus the constant size).

Doing a "testb $imm8" would likely be optimal, but you'll never get
that with smp_load_acquire() on x86 unless you use inline asm, because
of how we're doing it with a volatile pointer.

Anyway, you could try something like this:

  static __always_inline bool constant_test_bit(long nr, const
volatile unsigned long *addr)
  {
        bool oldbit;

        asm volatile("testb %2,%1"
                     CC_SET(nz)
                     : CC_OUT(nz) (oldbit)
                     : "m" (((unsigned char *)addr)[nr >> 3]),
                       "Ir" (1 << (nr & 7))
                      :"memory");
        return oldbit;
  }

for both the regular test_bit() and for the acquire (since all loads
are acquires on x86, and using an asm basically forces a memory load
so it just does that "volatile" part.

But that's a separate optimization and independent of the acquire thing.

> For me, the kernel 6.0-rc2 doesn't boot in an arm64 virtual machine at all
> (with or without this patch), so I only compile-tested it on arm64. I have
> to bisect it.

Hmm. I'm running it on real arm64 hardware (rc2+ - not your patch), so
I wonder what's up..

               Linus
