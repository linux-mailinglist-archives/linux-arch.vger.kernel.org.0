Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF68365B36
	for <lists+linux-arch@lfdr.de>; Tue, 20 Apr 2021 16:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhDTOdX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Apr 2021 10:33:23 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:48509 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhDTOdX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Apr 2021 10:33:23 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MfHUx-1m14VV2I1b-00gtTc; Tue, 20 Apr 2021 16:32:50 +0200
Received: by mail-wr1-f49.google.com with SMTP id g9so21818755wrx.0;
        Tue, 20 Apr 2021 07:32:50 -0700 (PDT)
X-Gm-Message-State: AOAM531l6p1bx2AuzWfLJ+YHixKGTLIvE0uYmFNBYEMuLpWpS0nPHWCw
        /mioWGa90qeuaAZZH1qt3b3NxQIZSMYmKzZ9wOM=
X-Google-Smtp-Source: ABdhPJx9jCblaoPk1DZ/dDmC1vuUbz/Q0EccVnjqd/GOO86aSxcff75LZUey862d3CFtrmxEPKH5z/JxdSICQeP55A0=
X-Received: by 2002:adf:e483:: with SMTP id i3mr21737991wrm.286.1618929170116;
 Tue, 20 Apr 2021 07:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <1618925829-90071-1-git-send-email-guoren@kernel.org> <1618925829-90071-2-git-send-email-guoren@kernel.org>
In-Reply-To: <1618925829-90071-2-git-send-email-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 20 Apr 2021 16:32:33 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1aNDomNiX7W1USWnmdw1VR21ALX7NvJYGW9LBO+jvA4A@mail.gmail.com>
Message-ID: <CAK8P3a1aNDomNiX7W1USWnmdw1VR21ALX7NvJYGW9LBO+jvA4A@mail.gmail.com>
Subject: Re: [PATCH 2/3] nios2: Cleanup deprecated function strlen_user
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:lqvcbbgDyrkm3OAb+MFZOfHRrUOr3/tVk7wOi+VJSnZM6e1z0UL
 laXHvAitfihF2W4V9Bt6/nZc1iGjaMnKSefbPDWRSFJqwoMSjbF4BCbJb8Y7PrPPvU9QGo2
 BU2nS4ITULtaX63G0qcp2cPHZ63mi5Z1FoprJ4YuGH8Sa88aeInC61llWs3P3K5u6idCnoU
 i1/Dy6saOJKQbw7yAE1Wg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XkbHRZbCywI=:Svhcd1f+8MuKuQp9aMUC5o
 LKmOgmHCjvY/xQ2PF+/OE68OZjRiJ8kuSx3L+BwbA2ezodPjC4eRh5AM7y+CxyuV1IucW0SgO
 /wlWELdvBcrUDrK0CA08XC1QlveihzuI4d4ZlkxLDGofoSYPiVhF+n1T2rDezz52KaFbInjoz
 50VmogAmmDURsmMt1l1V8niRIztrQfFdFYwF+bVLEPTNUC0R8j/WbxBt9ZzrV1YwmTmEpqPcv
 150sCjTCQYluFHxdixAT1GBqBe9mCJLxVKYn6nxs6YYvqihu0l5zAtkKez/Q1E2bCPI/xrrt8
 HuRFTCgCPKdukwjczL8UtlCjbGRXA2ukVf0v1ORvIdELavWNDakrDvP6cLWQwtdRHxHjJdzto
 Ajc0u6XCtWPNbJRh2s0mitlEjCUnAwr3Z46MbBU13DLa/X5g54TWpzyAbJK783gbXhqFypaSQ
 iJ//qkpENTwDa8DuE6WW4MYM8Y2ZZI1SlFyLj667o85zlsB/OqHnOFZNfbnKD+bPpnlbmpvJX
 YmRHgUuo5nrnPyJdCvpf8g=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 20, 2021 at 3:37 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> $ grep strlen_user * -r
> arch/csky/include/asm/uaccess.h:#define strlen_user(str) strnlen_user(str, 32767)
> arch/csky/lib/usercopy.c: * strlen_user: - Get the size of a string in user space.
> arch/ia64/lib/strlen.S: // Please note that in the case of strlen() as opposed to strlen_user()
> arch/mips/lib/strnlen_user.S: *  make strlen_user and strnlen_user access the first few KSEG0
> arch/nds32/include/asm/uaccess.h:extern __must_check long strlen_user(const char __user * str);
> arch/nios2/include/asm/uaccess.h:extern __must_check long strlen_user(const char __user *str);
> arch/riscv/include/asm/uaccess.h:extern long __must_check strlen_user(const char __user *str);
> kernel/trace/trace_probe_tmpl.h:static nokprobe_inline int fetch_store_strlen_user(unsigned long addr);
> kernel/trace/trace_probe_tmpl.h:                        ret += fetch_store_strlen_user(val + code->offset);
> kernel/trace/trace_uprobe.c:fetch_store_strlen_user(unsigned long addr)
> kernel/trace/trace_kprobe.c:fetch_store_strlen_user(unsigned long addr)
> kernel/trace/trace_kprobe.c:            return fetch_store_strlen_user(addr);

I would suggest using "grep strlen_user * -rw", to let the whole-word match
filter out the irrelevant ones for the changelog.

> See grep result, nobody uses it.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

All three patches

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Do you want me to pick them up in the asm-generic tree?
