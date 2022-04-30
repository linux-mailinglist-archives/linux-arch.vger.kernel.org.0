Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B32515C1C
	for <lists+linux-arch@lfdr.de>; Sat, 30 Apr 2022 12:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382565AbiD3KJH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Apr 2022 06:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382556AbiD3KIm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Apr 2022 06:08:42 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82D15FFE;
        Sat, 30 Apr 2022 03:05:19 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id t85so9684120vst.4;
        Sat, 30 Apr 2022 03:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDlJEsYHsH5/u4hrMRhfUbsT0qjmPw77962C19d54XE=;
        b=MOdZAyOylVEF9SHL6setlZ43OIx9F+W6/c/NrJKf7DW4FGIlMHhfB4tzN3SQZf11Z3
         QQo6L95/ja4fa+5ds9gJXdSVto5O+awjhKs5JNu9cJLhZpThas37pc1ca2HnnWbqEJCb
         WNkPGP5Okq7/BIj1ltz5ZIj9gLkOperYtSygRb4wIqLgzoxc66Y7/ZEqjxSmjgkAaQ+m
         OQI8VNL5flG4E0GjNWyaCeKAwojjPfvjS2J9AeAm9dMA9mky9me3ivk4j4H57L3xuH+V
         KBSJQSheDl/1GK6K9/MmxQ+AV8KwqGlvUTj4xXPt/rKg08Ce73gwj1qkvhF6HBUovwst
         sdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDlJEsYHsH5/u4hrMRhfUbsT0qjmPw77962C19d54XE=;
        b=COZMT6xdEzfS+y9NlTNrKIubUyuGL/gzItxALGkt3EjSgONqn5VLNdwsqx7/Xqn033
         FdfuJZA3gKvivfDNJZlWBSSiDNeRXzQwPGxWiubGYzEk4NexVp2okd7FhYPf9LKz6oQs
         NiMAPHL276U/AN5sEcgo280bTv2nQGQYP+8pNPkPqPXg+11HiD4d05wih/t15wK6hQU8
         uAIhl5BUOHZtpr4oREn7it/MN9QG+AT3IMjH5yRzJkallYrqBKhRRyXZGbZqR355tGH5
         xj86eLmbzLg5E3kFxFQJoNMgJ3ZVH6S/byi2hhSXpFtnYFHEC7LOZif92pSLJBzyl9q1
         wRLA==
X-Gm-Message-State: AOAM5301A3QU1fFJ1FAPdMMhk6wwvJDDiMJAyXntbzfGUrKeeqKgV2Om
        tqB+MCIN0qNtlnBZDm80GTBR9HyN4xFQ6RjkY8E=
X-Google-Smtp-Source: ABdhPJwmXkH2wMcWDejlFEFo295A9u0t4tWrF0aD1JhDKO4YeoP5fZQjceWB6sG7nt9k1EK5IAldqHoVV38AJo2pwHk=
X-Received: by 2002:a67:ea4f:0:b0:328:1db4:d85c with SMTP id
 r15-20020a67ea4f000000b003281db4d85cmr963977vso.20.1651313118631; Sat, 30 Apr
 2022 03:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-14-chenhuacai@loongson.cn> <CAK8P3a0A9dW4mwJ6JHDiJxizL7vWfr4r4c5KhbjtAY0sWbZJVA@mail.gmail.com>
In-Reply-To: <CAK8P3a0A9dW4mwJ6JHDiJxizL7vWfr4r4c5KhbjtAY0sWbZJVA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 30 Apr 2022 18:05:07 +0800
Message-ID: <CAAhV-H4te_+AS69viO4eBz=abBUm5oQ6AfoY1Cb+nOCZyyeMdA@mail.gmail.com>
Subject: Re: [PATCH V9 13/24] LoongArch: Add system call support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Sat, Apr 30, 2022 at 5:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Apr 30, 2022 at 11:05 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > This patch adds system call support and related uaccess.h for LoongArch.
> >
> > Q: Why keep __ARCH_WANT_NEW_STAT definition while there is statx:
> > A: Until the latest glibc release (2.34), statx is only used for 32-bit
> >    platforms, or 64-bit platforms with 32-bit timestamp. I.e., Most 64-
> >    bit platforms still use newstat now.
> >
> > Q: Why keep _ARCH_WANT_SYS_CLONE definition while there is clone3:
> > A: The latest glibc release (2.34) has some basic support for clone3 but
> >    it isn't complete. E.g., pthread_create() and spawni() have converted
> >    to use clone3 but fork() will still use clone. Moreover, some seccomp
> >    related applications can still not work perfectly with clone3. E.g.,
> >    Chromium sandbox cannot work at all and there is no solution for it,
> >    which is more terrible than the fork() story [1].
> >
> > [1] https://chromium-review.googlesource.com/c/chromium/src/+/2936184
>
> I still think these have to be removed. There is no mainline glibc or musl
> port yet, and neither of them should actually be required. Please remove
> them here, and modify your libc patches accordingly when you send those
> upstream.
If this is just a problem that can be resolved by upgrading
glibc/musl, I will remove them. But the Chromium problem (or sandbox
problem in general) seems to have no solution now.

Huacai
>
>        Arnd
