Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DD34759B7
	for <lists+linux-arch@lfdr.de>; Wed, 15 Dec 2021 14:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbhLONdt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Dec 2021 08:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242899AbhLONds (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Dec 2021 08:33:48 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6421BC061574
        for <linux-arch@vger.kernel.org>; Wed, 15 Dec 2021 05:33:48 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id bj13so31673540oib.4
        for <linux-arch@vger.kernel.org>; Wed, 15 Dec 2021 05:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+UPZ8+IiM8moYke3aTaWDfXyTBb8QigFqjdfGzKzRHI=;
        b=PaPRw7IBxZHKc5ILCJ29MsY7mY986DE2gwQY8C3fRUR+MaYQQkXCggtY5Lh2Y5M0AL
         R7j/A5oBHl8jikEzl5nda+ERST+L5Pu2gI4rODC3JETMEf11N59UdfwaQ4NOJpm7Z0nU
         Zl5HZxFumLn9fN6nX7eak8f9s+l5tbgng4JkbO2sXzVRvCSHip68N1nJt2gK5nSNJHLu
         5sWmyyhbV6nzN52T2/a9YQZeRTuyc3174FC/AS0aCGx9J6rkMtNpgXKQQ8Rmd1r2EJlY
         ZkeneAaXms3GBifMdXWQLIu7jFzQ/w+tZ6stLtJ9DXkrszofMhMvWP4Zp4eJE3qbM/50
         TEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+UPZ8+IiM8moYke3aTaWDfXyTBb8QigFqjdfGzKzRHI=;
        b=HThBbUQEIrg+v0o0Xkbm3j7MEkbrQoars6lbqTChys0DvyzYPC62dbS4iZJHyxzxuw
         gDqurTWjmugjOp+TDNH98McFD8Uvg11xD33vs/rZfrsLxsCnheTEvxCUWddgb7zyohOS
         q5A2aEPg74SOk4Hq2a2c6/BunNqWxb6B7j8ZjpuY8ivpbA2chierNWh5WVLtXvasuhPx
         B5Y1c8Gb6R06TZXgRuH3zQ+WahRnUgNm+UKqBP+kRMEc0h0RFjVzyHFfDvgYCAdAMwvH
         rNp0FXsODLSWNBZjISP+1dkjLOlZ3svM7CX9RlCY3hv8jB3lreg6lV1j/Ux4NSgZTMIV
         tasA==
X-Gm-Message-State: AOAM5325nF8BZrRHtZo+52ZIki+KPeESeA6AbMJ4AkokD2IFP51b0rtp
        3gHnzimNfzLUVKNP3UBIi9Hjf6kkJBDD6hWn61ls8g==
X-Google-Smtp-Source: ABdhPJwls0NdSP7Nakul5Uh/+/AETU5z3undj37BDbMiS8w/mD1/nppX+S6J6Jr9AmyO2qoNBZij6JO0uWm8eoPZFN0=
X-Received: by 2002:aca:af50:: with SMTP id y77mr8591431oie.134.1639575227493;
 Wed, 15 Dec 2021 05:33:47 -0800 (PST)
MIME-Version: 1.0
References: <20211214162050.660953-1-glider@google.com> <20211214162050.660953-8-glider@google.com>
 <YbnsdDUCwX+Mem0s@FVFF77S0Q05N>
In-Reply-To: <YbnsdDUCwX+Mem0s@FVFF77S0Q05N>
From:   Marco Elver <elver@google.com>
Date:   Wed, 15 Dec 2021 14:33:34 +0100
Message-ID: <CANpmjNPbEw_c2KduwkXwT5+iZVRQa1n5vWX2F_bjGdPynraC6g@mail.gmail.com>
Subject: Re: [PATCH 07/43] compiler_attributes.h: add __disable_sanitizer_instrumentation
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A

On Wed, 15 Dec 2021 at 14:24, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Dec 14, 2021 at 05:20:14PM +0100, Alexander Potapenko wrote:
> > The new attribute maps to
> > __attribute__((disable_sanitizer_instrumentation)), which will be
> > supported by Clang >= 14.0. Future support in GCC is also possible.
> >
> > This attribute disables compiler instrumentation for kernel sanitizer
> > tools, making it easier to implement noinstr. It is different from the
> > existing __no_sanitize* attributes, which may still allow certain types
> > of instrumentation to prevent false positives.
>
> When you say the __no_sanitize* attributes allow some instrumentation, does
> that apply to any of the existing KASAN/KCSAN/KCOV support, or just for KMSAN?
>
> The documentation just says the same as the commit message:
>
> | This is not the same as __attribute__((no_sanitize(...))), which depending on
> | the tool may still insert instrumentation to prevent false positive reports.
>
> ... which implies the other instrumentation might not be suprressed.
>
> I ask because architectures which select ARCH_WANTS_NO_INSTR *need* to be able
> to suppress all instrumentation. It's fine if that means they need a new
> version of clang for KMSAN, but if there's latent instrumentation we have more
> bugs to fix first...

Thus far, none of the existing K*SANs added other instrumentation.
Apart from KMSAN here, this will change with KCSAN's barrier
instrumentation, which is why this patch is also part of KCSAN's
upcoming changes -- recall I said I fixed barrier instrumentation for
arm64 as well, this is how :-)

See https://lore.kernel.org/all/20211130114433.2580590-26-elver@google.com/
how I resolved it for KCSAN on architectures that don't have objtool.

I expect this patch will be dropped from the KMSAN series once it
reaches mainline through the KCSAN changes.

Also note, this applies only for bug-detection tools, that may want to
avoid false positives. So by definition, it is irrelevant for KCOV
(which had its own attribute woes a while back though). Yeah, it's
been a long road to get the compilers to play along ... :-/

Thanks,
-- Marco
