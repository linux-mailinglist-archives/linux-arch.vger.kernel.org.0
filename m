Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327943BC960
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhGFKUC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:20:02 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:45371 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhGFKUB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 06:20:01 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MYN7M-1lfJf129cg-00VOGH for <linux-arch@vger.kernel.org>; Tue, 06 Jul
 2021 12:17:21 +0200
Received: by mail-wr1-f54.google.com with SMTP id l5so8671340wrv.7
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:17:21 -0700 (PDT)
X-Gm-Message-State: AOAM532hPDNkiVdZvHlPefM0EUsX4zD4M0jRtrGQulb9BLuKQJpocJOx
        jvXakmoKAhqeQCAa2W5K4Cv2FZB+s5Pz4rG8hFg=
X-Google-Smtp-Source: ABdhPJxQzbgavwYELdgoe8eQfw9ugekTjXeay2rD7sYBJUJGICVbToMqeZuSSOCELBlk4fXT8MQPmW00O5ik8D8v0uA=
X-Received: by 2002:adf:fd8e:: with SMTP id d14mr21699896wrr.361.1625566641147;
 Tue, 06 Jul 2021 03:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn> <20210706041820.1536502-10-chenhuacai@loongson.cn>
In-Reply-To: <20210706041820.1536502-10-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jul 2021 12:17:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0n+HcPhevh4ifNMmsv+MUtGn1wky-HWZpyNT1GVSq4+Q@mail.gmail.com>
Message-ID: <CAK8P3a0n+HcPhevh4ifNMmsv+MUtGn1wky-HWZpyNT1GVSq4+Q@mail.gmail.com>
Subject: Re: [PATCH 09/19] LoongArch: Add system call support
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:aATH8LKLD5DxlKm09OI0i9AwA3YgE1/i1MbNzn0Kcx4P8mMnp6e
 e1V7O9Pw8RAWNc+9/G+aqPZenZd0acPa2fdr+vzlVbD5JiZWhP7/F2ugK4wQIU+ygbeRLUC
 ky5gMlxjj6Xr4r+DCv+WVTL+tIAhpVnVbSUGrt0iHvurqqj0hNLQxxYkfDwAD+S2UuVTW6C
 spTbf3VszenKcwJ/ZkgHQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:f+f0Bo5ZjYc=:VTz/9Oq+sViSlAJcj3LFRx
 vNFtwMH6jikzY/H/IDvtu1SmA6oJlmMHeRJ8ezEDpDkSEqknXPJgfX+U16LqfMqUyiFyXPfI5
 JANUlE7g/cs1Wy945gtvZbspjCDd7sR7zUtcmN7FJcB45+Es3rxybd+CxQu0tVfIDnFmdE97+
 ptrkEHb83nO1QuCLNHUcbigVhuunAxoBtrM5660v0poiDDAaQyF3haoepXwegZrutQ0Ok0RFp
 gHNwfgLWqNzujzI3G+rXgCpBGpenhU+fuwCECQqOmZTWbFf9wf64bXeXl8Yp7GzMZCRPwJ6E1
 9t/29sL2ZW7bCNDcJO4P+moOccwFkM9fxhi6gWgSqkCkC3gLD/rE0KXDSTTPNE06FYGtdKx5U
 QIKVMdWuNgmIfEtZrba5B6fSQIqFpSnlbnl4r81m729S1NGG5PiWkt1Yi7N7PyjF6/fTsNZNp
 R9hkboSDqi5rDDgEGlO5ooGN/xYSzyqO724y+33I3zUhJji5c+xv6G4GtndDthYlU5v+Ekujh
 M9PAHCPWMuWVn7kWjlKcVe2x4YD4pb+4KDM73+RhZLD1cB9acFPS9eFsUy8AG5yP6/MTtJtZ/
 uGgULAw0SZU/It06Xg6hGlobyH7y1FuMYdZJkYt06ep2zogXChcYqXOl6r+BHpPUeOvpIQAwV
 qYNYiwLsDhi728Rii3ZGQRVfqF0yzlC31acNS2oIA8/7ZGioPvPMrdoO0RxaTOETkkWTWluhp
 PpsvRBnLN2Wm6wnfC55orceUB+VhjfRqkzJatPyniC4sIG7dNENI4pPZ32ihBP8m/JIFiyBZq
 F5P+94HtqTJZG/PzsX/XXJE9G9o5ZQ+N8lOJYZIHtpGPD201Dq3trZerQ4FTe6vBwpboSKxJL
 iFQQ0IJIMYafYhMiU1UWVXuCUnzjw0RnYDYYNXLRBXdQ4I95c5b7JChjeVebJsECgjlO0WPd/
 VDl9NuQH6Q/dZjQ/Mg6+m7ZodxnBQW+6g2TQTZSy7R9rDA1VLH2ba
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:

> diff --git a/arch/loongarch/include/asm/seccomp.h b/arch/loongarch/include/asm/seccomp.h
> new file mode 100644
> index 000000000000..220c885f5478
> --- /dev/null
> +++ b/arch/loongarch/include/asm/seccomp.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_SECCOMP_H
> +#define __ASM_SECCOMP_H
> +
> +#include <linux/unistd.h>
> +
> +#include <asm-generic/seccomp.h>
> +
> +#endif /* __ASM_SECCOMP_H */

I would expect this file to not be needed.

> diff --git a/arch/loongarch/include/asm/uaccess.h b/arch/loongarch/include/asm/uaccess.h
> new file mode 100644
> index 000000000000..b760aa0a3bc6
> --- /dev/null
> +++ b/arch/loongarch/include/asm/uaccess.h
> @@ -0,0 +1,453 @@
> + * The fs value determines whether argument validity checking should be
> + * performed or not.  If get_fs() == USER_DS, checking is performed, with
> + * get_fs() == KERNEL_DS, checking is bypassed.
> + *
> + * For historical reasons, these macros are grossly misnamed.
> + */

You removed set_fs()/get_fs(), which is good, but you forgot to remove
the comment.

> diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
> new file mode 100644
> index 000000000000..6c194d740ed0
> --- /dev/null
> +++ b/arch/loongarch/include/uapi/asm/unistd.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#define __ARCH_WANT_NEW_STAT

Why do you need newstat? I think now that we have statx and the libc
emulation code on top of it, there is probably no need to support both
on the kernel side.

> +#define __ARCH_WANT_SYS_CLONE
> +#define __ARCH_WANT_SYS_CLONE3

Similarly, if you have clone3, you should not need clone.

> +#define __ARCH_WANT_SET_GET_RLIMIT

And here for prlimit64


> +void *sys_call_table[__NR_syscalls] = {
> +       [0 ... __NR_syscalls - 1] = sys_ni_syscall,
> +#include <asm/unistd.h>
> +       __SYSCALL(__NR_clone, __sys_clone)
> +       __SYSCALL(__NR_clone3, __sys_clone3)
> +};

I would suggest expressing this as

#defined sys_clone3 __sys_clone3

instead of overriding the other entries.

          Arnd
