Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A623640BF
	for <lists+linux-arch@lfdr.de>; Mon, 19 Apr 2021 13:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbhDSLq1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Apr 2021 07:46:27 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:37137 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238744AbhDSLq0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Apr 2021 07:46:26 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MOQyE-1l9e4F06Pu-00Prg5; Mon, 19 Apr 2021 13:45:53 +0200
Received: by mail-wr1-f49.google.com with SMTP id j5so32720883wrn.4;
        Mon, 19 Apr 2021 04:45:52 -0700 (PDT)
X-Gm-Message-State: AOAM530QKBOUUSndPbMfEemTC1qgG6pY9ZIATFppttSdjjs3iLfa7qq8
        mrnsztQMMJnegneShc7YtiTpKp+nE+LRRLpYS/E=
X-Google-Smtp-Source: ABdhPJwEqpvEXhMjLLqp97csmcwNcY1rK/VijtLf0UEkkA3KI3NlkzigrzsU6Qsva0ZTIp6OfFYbsu+GilDGIMNVtJQ=
X-Received: by 2002:adf:db4f:: with SMTP id f15mr14108786wrj.99.1618832752710;
 Mon, 19 Apr 2021 04:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <1618634729-88821-1-git-send-email-guoren@kernel.org> <1618634729-88821-2-git-send-email-guoren@kernel.org>
In-Reply-To: <1618634729-88821-2-git-send-email-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 19 Apr 2021 13:45:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1ygwS7jTXqYXCfppEEonCASqG_5GM9O_AtE9YgdgNqVQ@mail.gmail.com>
Message-ID: <CAK8P3a1ygwS7jTXqYXCfppEEonCASqG_5GM9O_AtE9YgdgNqVQ@mail.gmail.com>
Subject: Re: [PATCH v2 (RESEND) 2/2] riscv: atomic: Using ARCH_ATOMIC in asm/atomic.h
To:     Guo Ren <guoren@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:/v+Ntzuu+oEx7mXJs+9U83ipuch3R+HU1Mc5V4Vwtb3/cDrBTM5
 MVydlzM2hUQ0SLrNEW0zWMNtxHILFpROn6evPse6X3VSR2wuvlnDWjjEPJwMouh6P4VbiQ0
 sUltmWKc8GhWWBG4XXIUwffYcsGPMKyj6kBbGfhzqxegwbRvYVHHRijB0BD3ohmKNUkQGGM
 /oJ/772ZMfAZD2At0kygQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:r+QeLt5zhcY=:vxainJgUAu4xe+666gbgYF
 a+Bs/fCihEyKI8xCSBB6K7EAyGbZUr21GmmoxLAtjpfyOUdZHsQJJB4CogRTlEPzcV543z9L7
 gX8q29c84D70h5AK+nPfaTCXlCG+OntQWvh6Vv7D0cRyiuno6HzEczpEkcY7rjG2GW/trz+8h
 kA2l3tUsBk7mPOlW3+MYx8bM33PcktiCXvpTWsqMdLjmtucqVRaRZ8ro7VDTFJcA1irDj4io7
 gevh1CZXRf49ZKc1+ZuQB7Kas3rKmydJErysVP6V3uJzh0U1vAEbStrFyCeXJtGgpVuBc/wfV
 x+jh/PxxgFwOS9l8Wdx53bHKlAJ/MujhFWlY+6ZXhZt9sa0TrE0e7QcLUw71loXlTTZnkomaT
 /ZDzFztDO0BbIcRq59fw28hm7+EMghyAhRPRfVLL1kHcEk9W50eRC4vK9OObpWo7UqrNljXFk
 EbntW6FAF6QcDRuCOsEIKxQKwKL+M0Qvf4QIX/jAOCfIzd4b8zzbb5DEHqKgLwB9gbveKLTLs
 dYBwG2CFEjXAYjspmVkf6I=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Apr 17, 2021 at 6:45 AM <guoren@kernel.org> wrote:
> +#define arch_atomic_read(v)                    __READ_ONCE((v)->counter)
> +#define arch_atomic_set(v, i)                  __WRITE_ONCE(((v)->counter), (i))

> +#define ATOMIC64_INIT                          ATOMIC_INIT
> +#define arch_atomic64_read                     arch_atomic_read
> +#define arch_atomic64_set                      arch_atomic_set
>  #endif

I think it's a bit confusing to define arch_atomic64_read() etc in terms
of arch_atomic_read(), given that they operate on different types.

IMHO the clearest would be to define both in terms of the open-coded
version you have for the 32-bit atomics.

Also, given that all three architectures (x86, arm64, riscv) use the same
definitions for the six macros above, maybe those can just get moved
into a common file with a possible override?

x86 uses an inline function here instead of the macro. This would also
be my preference, but it may add complexity to avoid circular header
dependencies.

The rest of this patch looks good to me.

        Arnd
