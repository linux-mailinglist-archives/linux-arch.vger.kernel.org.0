Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA5A5ADC0
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jun 2019 01:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfF2Xnc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Jun 2019 19:43:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfF2Xnc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Jun 2019 19:43:32 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3F1B217F9
        for <linux-arch@vger.kernel.org>; Sat, 29 Jun 2019 23:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561851810;
        bh=6Ls1mmfTCbzFx4Rzb3UhYmFEV6me19aFFOMlTGuTuMY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ItDaQR+YFwM+zUWyq0SEZyW3Pn6dapJHuivHM4jw8jYIYATlvNCFgUOVSyHA15NNw
         AEZK10pv6CFtIGXjIbUG7AXyDMsOmLHnHbBJ/EnoIw6y8yuhITck+ydss7eXTQlmm2
         HPBufIxfXjHuzQKQSM+5jkAcCFZ77DOpPDDnzdOY=
Received: by mail-wr1-f51.google.com with SMTP id n4so9930140wrs.3
        for <linux-arch@vger.kernel.org>; Sat, 29 Jun 2019 16:43:30 -0700 (PDT)
X-Gm-Message-State: APjAAAXT3W+Zxm742focPVd4Xyq80bibPZLbyK8mefUm3pEHClW7reb4
        wZxWZpna8UqbAPHXot+0zM7l0uRBAb8w3xpZhZ96lw==
X-Google-Smtp-Source: APXvYqy1lccm+W/+pWlsgMcG6L5G1lNH4IFhUO6vjgvEXUaNIhYR7BWWHlgDd5MOsBd1OpDkbJ+gIKmRECPoUjBLpFU=
X-Received: by 2002:adf:dd0f:: with SMTP id a15mr10561378wrm.265.1561851809106;
 Sat, 29 Jun 2019 16:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190628194158.2431-1-yu-cheng.yu@intel.com> <20190628194158.2431-2-yu-cheng.yu@intel.com>
In-Reply-To: <20190628194158.2431-2-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 29 Jun 2019 16:43:18 -0700
X-Gmail-Original-Message-ID: <CALCETrVvbbCWMPo7v5eYgTocaxRQPHerJ=CRjWscGxgb6QjOFA@mail.gmail.com>
Message-ID: <CALCETrVvbbCWMPo7v5eYgTocaxRQPHerJ=CRjWscGxgb6QjOFA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] Introduce arch_prctl(ARCH_X86_CET_MARK_LEGACY_CODE)
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> On Jun 28, 2019, at 12:41 PM, Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> The CET legacy code bitmap covers the whole user-mode address space and i=
s
> located at the top of the user-mode address space.  It is allocated only
> when the first time arch_prctl(ARCH_X86_MARK_LEGACY_CODE) is called from
> an application.
>
> Introduce:
>
> arch_prctl(ARCH_X86_MARK_LEGACY_CODE, unsigned long *buf)
>    Mark an address range as IBT legacy code.

How about defining a struct for this?

The change log should discuss where the bitmap goes and how it=E2=80=99s al=
located.

> +static int alloc_bitmap(void)
> +{
> +    unsigned long addr;
> +    u64 msr_ia32_u_cet;
> +
> +    addr =3D do_mmap_locked(NULL, IBT_BITMAP_ADDR, IBT_BITMAP_SIZE,
> +                  PROT_READ | PROT_WRITE,
> +                  MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED_NOREPLACE,
> +                  VM_IBT | VM_NORESERVE, NULL);
> +
> +    if (IS_ERR((void *)addr))
> +        return addr;
> +
> +    current->thread.cet.ibt_bitmap_addr =3D addr;

addr is a constant. Why are you storing it?  If it ends up not being
constant, you should wire up mremap like the vDSO does.


> +static int set_user_bits(unsigned long __user *buf, unsigned long buf_si=
ze,
> +             unsigned long start_bit, unsigned long end_bit, unsigned lo=
ng set)
> +{
> +    unsigned long start_ul, end_ul, total_ul;
> +    int i, j, r;
> +
> +    if (round_up(end_bit, BITS_PER_BYTE) / BITS_PER_BYTE > buf_size)
> +        end_bit =3D buf_size * BITS_PER_BYTE - 1;
> +
> +    start_ul =3D start_bit / BITS_PER_LONG;
> +    end_ul =3D end_bit / BITS_PER_LONG;
> +    total_ul =3D (end_ul - start_ul + 1);
> +
> +    i =3D start_bit % BITS_PER_LONG;
> +    j =3D end_bit % BITS_PER_LONG;
> +
> +    r =3D 0;
> +    put_user_try {

put_user_try is obsolete.  Just use get_user(), etc.

Also, I must be missing something fundamental, because this series
claims that user code can't write directly to the bitmap.  This means
that this entire function shouldn't work at all.
