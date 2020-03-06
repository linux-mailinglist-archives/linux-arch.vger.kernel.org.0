Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74D2117C2F5
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 17:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgCFQ3q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 11:29:46 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:37703 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgCFQ3q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 11:29:46 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N9Mh8-1jOZjg0o4q-015LyN; Fri, 06 Mar 2020 17:29:44 +0100
Received: by mail-qk1-f169.google.com with SMTP id y126so2855061qke.4;
        Fri, 06 Mar 2020 08:29:43 -0800 (PST)
X-Gm-Message-State: ANhLgQ0N/ZaQ4t2ckk3wFHp+PDheCnUZQmJiZRcGRP8ZzsfF0SCy+o88
        DTADuhc04YL7i4WmREFGG3IUKhf3LsdJvUEs+xc=
X-Google-Smtp-Source: ADFU+vvnPPzWc82fmv/qXihNwht3xjXJb3gM2lnV/Y1UhSl2Ac8ZqobyQCVDZURx7n5GqWu/8pYUNGkVExuBSGen+gQ=
X-Received: by 2002:a37:4f8d:: with SMTP id d135mr3716874qkb.394.1583512182964;
 Fri, 06 Mar 2020 08:29:42 -0800 (PST)
MIME-Version: 1.0
References: <2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com>
 <c1489f55-369d-2cff-ff36-b10fb5d3ee79@kernel.org> <8207cd51-5b94-2f15-de9f-d85c9c385bca@huawei.com>
 <6115fa56-a471-1e9f-edbb-e643fa4e7e11@kernel.org> <7c955142-1fcb-d99e-69e4-1e0d3d9eb8c3@huawei.com>
 <CAK8P3a0f9hnKGd6GJ8qFZSu+J-n4fY23TCGxQkmgJaxbpre50Q@mail.gmail.com>
 <90af535f-00ef-c1e3-ec20-aae2bd2a0d88@kernel.org> <CAK8P3a2Grd0JsBNsB19oAxrAFtOdpvjrpGcfeArKe7zD_jrUZw@mail.gmail.com>
 <ae0a1bf1-948f-7df0-9efb-cd1e94e27d2d@huawei.com> <CAK8P3a2wdCrBP=a8ZypWoC=HyCU3oYYNeCddWM7oT+xM9gTPhw@mail.gmail.com>
 <182a37c2-7437-b1bd-8b86-5c9ce2e29f00@huawei.com>
In-Reply-To: <182a37c2-7437-b1bd-8b86-5c9ce2e29f00@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Mar 2020 17:29:26 +0100
X-Gmail-Original-Message-ID: <CAK8P3a22fEGdVKVVs_40Rc_vs9SQ2ikejwMtFpyR_o+74utWaA@mail.gmail.com>
Message-ID: <CAK8P3a22fEGdVKVVs_40Rc_vs9SQ2ikejwMtFpyR_o+74utWaA@mail.gmail.com>
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
X-Provags-ID: V03:K1:HxNrfgizwilzuaEfId2WyjkjMWUD7n9oZHcRz0+eo6fPGukg5XV
 0bdNkylKcnXn0RUfLEWfjMJZcU4NSkX8OXweksi6R5dvw1nD4MXaNbYH1fSeDMVuT2fjQd3
 6w7hV0NcbSAl0yX77/DcYUSdMgmFc4qZjYsfILewSs+SYsVk00/lwyeH7tWWzhRQ4AgmseQ
 c3P1/2mNEB8q1h71kUCEw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:g0hqxFEAWIE=:0eeRMHbAnBqjB1y4GK5K/I
 lkNuuzv8mkRHdGNQo052dgFIBLRkrws1nZSEJv7XJPUz60OnH1l8KLT/NtV7ViKlaBZUyjr3/
 Va/rscPkp1N2kbbxBc+eA1XVM8MQ0FDbKYcG15UX2hjwYkqJMLt/UH3zuq11qALOBnJuo4i4U
 WjdY4hxZCogkr0p1+8SBbcbhBIE3enjtal2YwQ9Bl3LmWU3XalM0OvwOoAFIrtbHiAE2d8+3F
 ArWztBBBJKa6TiFcYJrdHI0DDl0305SZ318hCOi6TTcrsN/rv3BOuyMobj36CMguAR9FuJqrS
 hhhDyzpFa6X7vSEu3oxClgLIrvs7pJaOCf7SgKu1xZ8xIjUTkORym7QSLT3g36iF6tlv7FnGg
 tdC8pMozA69iOGh6jn4e9/xAO3R2B4kOzYQ1ree6VmH2NPiAkE0JKhcKxHytmcwfzHmMis7PP
 g6+3Q8IV0eZx2eVQq1cHWzS2MltYxwuZvUZ0rN0QWqFqjktcycdGgwiBvCONEiQLF0vQ2Zuol
 OKttx7vK2mBDsexo8cVg2pXxs7qg97ybGB/zVmbvksMz9IWsPhP3bWFVo1BYV58+gs/H29w7e
 gKKH4yf9QX+fySDaSTwuc6vpG5COjexi2e1m0YRftyyPTOTBDevUxVKkW+MGBx4Sq9ANgYNU1
 VPSTpai41awUGcn4m8euXKFblbMkndq5V2fcZM5WwnTLHHv3RoJ9L1Wmx6B56e76Jx+oX+OhG
 aIPnrepWITqcPtA1SOXB8qXEEVqy86lWKmiJBLAJ3LMYkRNMXRSa2xK4uZlN67fq3p3go2csT
 bTX2a5Jmqvb+tTOV3e0iOlrsd88q2jBlUlpDw1x+lStYzaxCnA=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 6, 2020 at 5:18 PM John Garry <john.garry@huawei.com> wrote:
> On 06/03/2020 15:16, Arnd Bergmann wrote:
> > On Fri, Mar 6, 2020 at 11:40 AM John Garry <john.garry@huawei.com> wrote:
> >> On 06/03/2020 07:54, Arnd Bergmann wrote:
> >>> On Fri, Mar 6, 2020 at 4:44 AM Sinan Kaya <okaya@kernel.org> wrote:
> >> -- a/lib/logic_pio.c
> >> +++ b/lib/logic_pio.c
> >> @@ -229,13 +229,21 @@ unsigned long
> >> logic_pio_trans_cpuaddr(resource_size_t addr)
> >>    }
> >>
> >>    #if defined(CONFIG_INDIRECT_PIO) && defined(PCI_IOBASE)
> >> +
> >> +#define logic_in_to_cpu_b(x) (x)
> >> +#define logic_in_to_cpu_w(x) __le16_to_cpu(x)
> >> +#define logic_in_to_cpu_l(x) __le32_to_cpu(x)
> >> +
> >>    #define BUILD_LOGIC_IO(bw, type)                                      \
>
> Note: The "bw" argument name could be improved to "bwl", since this
> macro is used for building inl() also.
>
> >>    type logic_in##bw(unsigned long addr)                                 \
> >>    {                                                                     \
> >>           type ret = (type)~0;                                           \
> >>                                                                          \
> >>           if (addr < MMIO_UPPER_LIMIT) {                                 \
> >> -               ret = read##bw(PCI_IOBASE + addr);                     \
> >> +               void __iomem *_addr = PCI_IOBASE + addr;               \
> >> +               __io_pbr();                                            \
> >> +               ret = logic_in_to_cpu_##bw(__raw_read##bw(_addr));     \
> >> +               __io_par(ret);                                         \
> >>           } else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {\
> >>                   struct logic_pio_hwaddr *entry = find_io_rang
> >>
> >> We could prob combine the le_to_cpu and __raw_read into a single macro.
> >
> > What is the purpose of splitting out the byteswap rather than leaving the
> > open-coded rather than __le16_to_cpu(__raw_readw(PCI_IOBASE + addr))?
>
> I'm just copying what is in asm-generic io.h, which uses the 16b and 32b
> byteswaps in the w and l variants, respectively.

Sure, but I don't think that needs another macro.

>
> The idea is good, but it would be nice if we just somehow use a common
> asm-generic io.h definition directly in logic_pio.c, like:
>
> asm-generic io.h:
>
> #ifndef __raw_inw // name?
> #define __raw_inw __raw_inw
> static inline u16 __raw_inw(unsigned long addr)
> {
>         u16 val;
>
>         __io_pbr();
>         val = __le16_to_cpu(__raw_readw(addr));
>         __io_par(val);
>         return val;
> }
> #endif
>
> #include <linux/logic_pio.h>
>
> #ifndef inw
> #define inw __raw_inw
> #endif

Yes, makes sense. Maybe __arch_inw() then? Not great either, but I think
that's better than __raw_inw() because __raw_* would sound like it
mirrors __raw_readl() that lacks the barriers and byteswaps.

      Arnd
