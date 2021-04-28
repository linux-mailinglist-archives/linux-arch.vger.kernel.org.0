Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A31736D3F5
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 10:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbhD1Iag (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 04:30:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231635AbhD1Iag (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Apr 2021 04:30:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9840D61004;
        Wed, 28 Apr 2021 08:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619598591;
        bh=Tm1uVNQ67mbZJApKzKgumPT2UQKkVy566R+vx8NdHow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kfJxTjEx6qLjN5q3rofMNmg+8qiPg5vVxBZlegK8koo06urJSSQEb9+0m2HA75sCQ
         uDD69Xwl3tVZoKFPQcthBPgjrFjUyKCST9LUZ7TzJQHl+bjy919/UoyvZnF1pw3cKC
         gUtr6eo+8Iv/Vq7B+KcT+8D1Hn3nnEerr3z/rIyrp89dSdsc4CubymDceJcg9XKZNw
         axWWsAPWXGHL+OfTSeRxmNTcxdCD26rA8GaepAeDIcPLqGdnz/H9qAQlNcgEkYuEnd
         I4GP/Fx2z737e/Ax66xA8Rc8y8Lwm58j+AuEiLGKTr2FC8pvddzs850qUL8yUpltVS
         b+lNHJp095FOA==
Received: by mail-lj1-f173.google.com with SMTP id a5so34330225ljk.0;
        Wed, 28 Apr 2021 01:29:51 -0700 (PDT)
X-Gm-Message-State: AOAM531PusRHU1GeckmqH/0T74v6phWh2/Whg3m1J6R8Kzw0JEJLDhYx
        KonMJ8EHWzx5RvjHzQMn7GDOXenEeTzRJoV6Fm0=
X-Google-Smtp-Source: ABdhPJz4vpA4DzKSSeqScfy8/oLabj9HnGSXolbcycO1Oz+q28y3kW2onnpEN6jXwTRTEk2IRRbZuWh265zFeDLsc64=
X-Received: by 2002:a2e:9f57:: with SMTP id v23mr19298434ljk.498.1619598589840;
 Wed, 28 Apr 2021 01:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <1618995255-91499-1-git-send-email-guoren@kernel.org> <20210428031807.GA27619@roeck-us.net>
In-Reply-To: <20210428031807.GA27619@roeck-us.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 28 Apr 2021 16:29:38 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTSMC947zisNs+j_2rMoBqoOy-j1jvVBk2DNrf0Xt6sWA@mail.gmail.com>
Message-ID: <CAJF2gTTSMC947zisNs+j_2rMoBqoOy-j1jvVBk2DNrf0Xt6sWA@mail.gmail.com>
Subject: Re: [PATCH] csky: uaccess.h: Coding convention with asm generic
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thx, Guenter

On Wed, Apr 28, 2021 at 11:18 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Apr 21, 2021 at 08:54:15AM +0000, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Using asm-generic/uaccess.h to prevent duplicated code:
> >  - Add user_addr_max which mentioned in generic uaccess.h
> >  - Remove custom definitions of KERNEL/USER_DS, get/set_fs,
> >    uaccess_kerenl
> >  - Using generic extable.h instead of custom definitions in
> >    uaccess.h
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
>
> Building csky:tinyconfig ... failed
> --------------
> Error log:
> csky-linux-ld: fs/readdir.o: in function `__put_user_fn':
> readdir.c:(.text+0x7c): undefined reference to `__put_user_bad'
> csky-linux-ld: fs/readdir.o: in function `$d':
> readdir.c:(.text+0x1bc): undefined reference to `__put_user_bad'
> make[1]: *** [Makefile:1277: vmlinux] Error 1
> make: *** [Makefile:222: __sub-make] Error 2
It's a bug, I can't put __put_user_bad in __put_user_fn, and
__put_user has done that:

/*
 * These are the main single-value transfer routines.  They automatically
 * use the right size if we just have the right pointer type.
 * This version just falls back to copy_{from,to}_user, which should
 * provide a fast-path for small values.
 */
#define __put_user(x, ptr) \
({                                                              \
        __typeof__(*(ptr)) __x = (x);                           \
        int __pu_err = -EFAULT;                                 \
        __chk_user_ptr(ptr);                                    \
        switch (sizeof (*(ptr))) {                              \
        case 1:                                                 \
        case 2:                                                 \
        case 4:                                                 \
        case 8:                                                 \
                __pu_err = __put_user_fn(sizeof (*(ptr)),       \
                                         ptr, &__x);            \
                break;                                          \
        default:                                                \
                __put_user_bad();                               \
                break;                                          \
         }                                                      \
        __pu_err;                                               \
})

Also, the same problem in __get_user, and I didn't implement "case 8:".

I'll fix up it in another patch and implement __get_user_case_8
(similar with arch/arc.)

>
> Bisect log attached.
>
> Guenter
>
> ---
> # bad: [3f1fee3e7237347f09a2c7fa538119e6d9ea4b84] Add linux-next specific files for 20210426
> # good: [9f4ad9e425a1d3b6a34617b8ea226d56a119a717] Linux 5.12
> git bisect start 'HEAD' 'v5.12'
> # bad: [bb8f486776983897309645c98705670c3d2a16e5] Merge remote-tracking branch 'crypto/master'
> git bisect bad bb8f486776983897309645c98705670c3d2a16e5
> # bad: [6ab4f4364c450991a476eef5bc57bef3586354ed] Merge remote-tracking branch 'jc_docs/docs-next'
> git bisect bad 6ab4f4364c450991a476eef5bc57bef3586354ed
> # bad: [fd73cab0b2a046136842b23f027dae3686588ba5] Merge remote-tracking branch 'parisc-hd/for-next'
> git bisect bad fd73cab0b2a046136842b23f027dae3686588ba5
> # good: [f0e6103e023e0ede67848ddcd6b07044574f4fd3] soc: document merges
> git bisect good f0e6103e023e0ede67848ddcd6b07044574f4fd3
> # good: [70361dc0add47d3818acf9c33718ce7395f8aaa5] Merge remote-tracking branch 'arm-soc/for-next'
> git bisect good 70361dc0add47d3818acf9c33718ce7395f8aaa5
> # good: [f62ad9f6e1100e3a1b6ca7a004fd5a972ff768df] Merge remote-tracking branch 'ti-k3/ti-k3-next'
> git bisect good f62ad9f6e1100e3a1b6ca7a004fd5a972ff768df
> # bad: [b3b33dda4fd25e201c77f0ce9277dd34f31e86ce] Merge remote-tracking branch 'h8300/h8300-next'
> git bisect bad b3b33dda4fd25e201c77f0ce9277dd34f31e86ce
> # good: [6a861bd8cf3c96f5825d031732e365b7721a84a5] Merge branch 'clk-qcom' into clk-next
> git bisect good 6a861bd8cf3c96f5825d031732e365b7721a84a5
> # good: [1dd129f1deec0606fb70992521a7e5bcd2f85c69] Merge branch 'clk-qcom' into clk-next
> git bisect good 1dd129f1deec0606fb70992521a7e5bcd2f85c69
> # good: [8808515be0ed4e33de9bfdc65f4c1b547ee11065] h8300: Replace <linux/clk-provider.h> by <linux/of_clk.h>
> git bisect good 8808515be0ed4e33de9bfdc65f4c1b547ee11065
> # good: [e27d3ecdeb8923f35cb856fd20be14256aaa7575] Merge remote-tracking branch 'clk/clk-next'
> git bisect good e27d3ecdeb8923f35cb856fd20be14256aaa7575
> # bad: [d3900e8d918f8fbd1366b9c2998e2830e66a0081] csky: uaccess.h: Coding convention with asm generic
> git bisect bad d3900e8d918f8fbd1366b9c2998e2830e66a0081
> # good: [0b1f557a1fa02174a982f557581e348d91987ec6] csky: Fixup typos
> git bisect good 0b1f557a1fa02174a982f557581e348d91987ec6
> # good: [8bfe70e696584deeed1de1bcbfcde405aa1a1344] csky: fix syscache.c fallthrough warning
> git bisect good 8bfe70e696584deeed1de1bcbfcde405aa1a1344
> # first bad commit: [d3900e8d918f8fbd1366b9c2998e2830e66a0081] csky: uaccess.h: Coding convention with asm generic



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
