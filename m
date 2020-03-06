Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF9C217C184
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 16:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgCFPRM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 10:17:12 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:45207 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFPRL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 10:17:11 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N4yyQ-1jKAt80fDQ-010w81; Fri, 06 Mar 2020 16:17:10 +0100
Received: by mail-qk1-f177.google.com with SMTP id p62so2636013qkb.0;
        Fri, 06 Mar 2020 07:17:09 -0800 (PST)
X-Gm-Message-State: ANhLgQ00yfbGOesMzKNnbaH0MXPu/RtTKkKNCnV6066uX0yesRPUH10a
        Ga+99LkW2YwTYXG/yZR5ziCa3P8szyXefGORtQw=
X-Google-Smtp-Source: ADFU+vuDaJsUN+5WX4+LLP5sq0sAGqnYo6p0nd7YbrvGU0xXwmka3Olj+EhE6qSwp8BgobIoBAs6cm1HFLnsNlxHW68=
X-Received: by 2002:a37:b984:: with SMTP id j126mr3197034qkf.3.1583507828957;
 Fri, 06 Mar 2020 07:17:08 -0800 (PST)
MIME-Version: 1.0
References: <2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com>
 <c1489f55-369d-2cff-ff36-b10fb5d3ee79@kernel.org> <8207cd51-5b94-2f15-de9f-d85c9c385bca@huawei.com>
 <6115fa56-a471-1e9f-edbb-e643fa4e7e11@kernel.org> <7c955142-1fcb-d99e-69e4-1e0d3d9eb8c3@huawei.com>
 <CAK8P3a0f9hnKGd6GJ8qFZSu+J-n4fY23TCGxQkmgJaxbpre50Q@mail.gmail.com>
 <90af535f-00ef-c1e3-ec20-aae2bd2a0d88@kernel.org> <CAK8P3a2Grd0JsBNsB19oAxrAFtOdpvjrpGcfeArKe7zD_jrUZw@mail.gmail.com>
 <ae0a1bf1-948f-7df0-9efb-cd1e94e27d2d@huawei.com>
In-Reply-To: <ae0a1bf1-948f-7df0-9efb-cd1e94e27d2d@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Mar 2020 16:16:52 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2wdCrBP=a8ZypWoC=HyCU3oYYNeCddWM7oT+xM9gTPhw@mail.gmail.com>
Message-ID: <CAK8P3a2wdCrBP=a8ZypWoC=HyCU3oYYNeCddWM7oT+xM9gTPhw@mail.gmail.com>
Subject: Re: About commit "io: change inX() to have their own IO barrier overrides"
To:     John Garry <john.garry@huawei.com>
Cc:     Sinan Kaya <okaya@kernel.org>, "xuwei (O)" <xuwei5@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:t8A1ODL76LW33V6LCb+zM2r5JjoIA9oWfVI78q4zdx4cVlyh6yI
 JtEbiAZrTIz9PloGfwy84Ht/RQBohv88T5bWOJe7n+m2aoWr4HXZHs2CjVHmpfSo00zBOEg
 sLcMzR1eFsg/gSKC5HhvA/USrOtSKDu8SpUoX3wHa9rlZwCFVG4JMTfAecLXV4N6LITKWtH
 iSy70wmAhsbdOaNvRMn+A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4SGZ1MhXyWw=:3q7Sp8G5686Anlxa7G+Rlr
 ZAEOcww3mF21E7pNuaaCwQ9PRexwUWE/ExmANEpRbcEVAQGLIKzspDDX52VRinK2nYQIQYTtS
 Ioa70YYVauO93RZ3qRUH6U5p2ewptmfuDp/1OS2H1tkfWUfvnmfFImh6ZmKS4YjqsPCmoGpHY
 r+9GNhpg0jiCuf5N+3c+WaGVKoFEsEu4OeOMRfsBcmit1GCBWp8TcNeEfl7frL4APKTyBgCol
 rOWE/QVebaOu9cqhlN6f178N5qw2VFp/W3ty0/gPYqHvQdTQxut286rS7/wfApLxiBD+LeHsi
 THEpDSiTOU+ESRgXQdWeGe5ugCXuKCae+K+5nbwKwjnpTfPgXCWklQxdbj/iGS5nMc/GSpKMp
 ROTSpHBqdE9rxiYjYTuGOk00R+dGQRxApbt0vXZIcbGBLpOwcdakv/9zM2gdit24T1vURDNbq
 Tb/oRXf7TWE8HCUe8ZEhoVMO2cZvJWDjx85Yyxvoeu0qv7vqDCPFNiqftzM6/52ajhNbo7rLf
 dv1s9jtEg9F0u59UwSHK3cROkFypGdxaRE84aKL2fQHnoNWFuUJcZNfse5gmUsve//pRkW8Ib
 nHTLkWTTwWqvg/w0NcaXNwh7l3qHxIONxJ7zvkwNXDDNdMR128kDiitKsIZKvP38fH1EtKYtr
 3w1/p6icXPyp4/iJ337v7mYsjY8ovrdUWA8KwKH+6sma8HDrraI+7ftHH5r9/QGu9WrWT/25X
 oUeBFWEfoysq8hdIw50sxDSsfND0oGKKciPENfYsRGpa7fazOnZ+o7r1b9siuKf02413eZJdB
 e/mDOa4xMl/BJxymO4G3aSDtzI1rdiMApuGNEF7V/q5CRs9+NQ=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 6, 2020 at 11:40 AM John Garry <john.garry@huawei.com> wrote:
> On 06/03/2020 07:54, Arnd Bergmann wrote:
> > On Fri, Mar 6, 2020 at 4:44 AM Sinan Kaya <okaya@kernel.org> wrote:
> -- a/lib/logic_pio.c
> +++ b/lib/logic_pio.c
> @@ -229,13 +229,21 @@ unsigned long
> logic_pio_trans_cpuaddr(resource_size_t addr)
>   }
>
>   #if defined(CONFIG_INDIRECT_PIO) && defined(PCI_IOBASE)
> +
> +#define logic_in_to_cpu_b(x) (x)
> +#define logic_in_to_cpu_w(x) __le16_to_cpu(x)
> +#define logic_in_to_cpu_l(x) __le32_to_cpu(x)
> +
>   #define BUILD_LOGIC_IO(bw, type)                                      \
>   type logic_in##bw(unsigned long addr)                                 \
>   {                                                                     \
>          type ret = (type)~0;                                           \
>                                                                         \
>          if (addr < MMIO_UPPER_LIMIT) {                                 \
> -               ret = read##bw(PCI_IOBASE + addr);                     \
> +               void __iomem *_addr = PCI_IOBASE + addr;               \
> +               __io_pbr();                                            \
> +               ret = logic_in_to_cpu_##bw(__raw_read##bw(_addr));     \
> +               __io_par(ret);                                         \
>          } else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {\
>                  struct logic_pio_hwaddr *entry = find_io_rang
>
> We could prob combine the le_to_cpu and __raw_read into a single macro.

What is the purpose of splitting out the byteswap rather than leaving the
open-coded rather than __le16_to_cpu(__raw_readw(PCI_IOBASE + addr))?

If this is needed to work across architectures, how about adding
an intermediate __raw_inw() etc in asm-generic/io.h like

#ifndef __raw_inw
#define __raw_inw(a) __raw_readw(PCI_IOBASE + addr));
#endif

#include <linux/logic_pio.h>

#ifndef inw
static inline u16 inw(unsigned long addr)
{
        u16 val;

        __io_pbr();
        val = __le16_to_cpu(__raw_inw(addr));
        __io_par(val);
        return val;
}
#endif

       Arnd
