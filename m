Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8299E17B7CA
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 08:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgCFHyq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 02:54:46 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:39107 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgCFHyq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 02:54:46 -0500
Received: from mail-qv1-f41.google.com ([209.85.219.41]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MLzeb-1isrun12HZ-00HyJt; Fri, 06 Mar 2020 08:54:44 +0100
Received: by mail-qv1-f41.google.com with SMTP id bt20so181873qvb.11;
        Thu, 05 Mar 2020 23:54:43 -0800 (PST)
X-Gm-Message-State: ANhLgQ2qjxMh/WOobhAZWDuBDhr8I/ZFHvsL/Xyl0n1g/mOYxQk9DVup
        7XWx3PTwvMvf9fbGRv1VyebA5d3HTL5zJ2yDWjY=
X-Google-Smtp-Source: ADFU+vtX3UTxvnJXm8eRDDZwtBAu5SswLmAGFT8PgY29/Kcq+WtP9jyt2rMuXfYWDab9OIu69nS0xfEq9MXBkaSYcIE=
X-Received: by 2002:a0c:f647:: with SMTP id s7mr1872718qvm.4.1583481283080;
 Thu, 05 Mar 2020 23:54:43 -0800 (PST)
MIME-Version: 1.0
References: <2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com>
 <c1489f55-369d-2cff-ff36-b10fb5d3ee79@kernel.org> <8207cd51-5b94-2f15-de9f-d85c9c385bca@huawei.com>
 <6115fa56-a471-1e9f-edbb-e643fa4e7e11@kernel.org> <7c955142-1fcb-d99e-69e4-1e0d3d9eb8c3@huawei.com>
 <CAK8P3a0f9hnKGd6GJ8qFZSu+J-n4fY23TCGxQkmgJaxbpre50Q@mail.gmail.com> <90af535f-00ef-c1e3-ec20-aae2bd2a0d88@kernel.org>
In-Reply-To: <90af535f-00ef-c1e3-ec20-aae2bd2a0d88@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Mar 2020 08:54:26 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2Grd0JsBNsB19oAxrAFtOdpvjrpGcfeArKe7zD_jrUZw@mail.gmail.com>
Message-ID: <CAK8P3a2Grd0JsBNsB19oAxrAFtOdpvjrpGcfeArKe7zD_jrUZw@mail.gmail.com>
Subject: Re: About commit "io: change inX() to have their own IO barrier overrides"
To:     Sinan Kaya <okaya@kernel.org>
Cc:     John Garry <john.garry@huawei.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+A3rp4qQtfrdC0dezqXsfCCSQQ2OJwclBL68ncXNk4EPT6S5z6K
 Hs8w9U1JGtmsGJnvMC67/IFSHD/WL517VXqLV9T6JqEHugqQFbRTdT8WAt4GDunBRpsPk8E
 kTtB9lVFFytT1cW/cygmzMiccD7dFaDWx6rMosPw77RTJm4K/z+ALbpTMWyJYV6UWB2eOt0
 5Z/C2O+z7phlHHsDmgPBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PtQ3ce/u0GU=:ycSp4WE47538v1sIUi0QfD
 Ljfl7EQoUN5s/Yd/9n6lcAL06eRelfR81PEYjJJpexX4OFQd1n45OSi6VLsZVvuAOkWDh0YEi
 VKczFR9WZDUJLA1oUJyDoGUaWQdp8c72K5iI8ndI9z6TtXWAO5jzjzUu+g8AMW+TQgv+Eq6Jt
 by0JWgKPAGoOP6OxUQX5rA0b8jkDjrpDbugzl80Y5xqciui5vlj+9wADYco2mEnca7mLcplnX
 dXQNmfxxIa5qR6yxFUR1HnToDONjOxAvlq95NvDUQMtixBlVYC6pw+TaadsYabDGskQj+LDjH
 pBmHnKaK85ZllLsoREhINpPedPUfvqRPyd+6vcW9P1m1sOlBRR65zZjbrtzNahVe6XAh48Kha
 9pxQmqSOFw7+W/wefqTzlu20ftqZ7c038wuZtjZc4wWukP3zvuiw7t/5rZ/P7beThbL6bOmV2
 25jzwuLE183nlY6g/QB2W2q695gVNHnp6x45IDcWBVFoEo0e1u1Uzz++J8rACEZOMLtpepuoL
 82wK1ByzZgldR+wQhK6d/bXwzonLp9GEzEZDNiP1NA5XMa6dqycwlkSqlRVUMpYSPVuZmZusG
 bbcuetF0/NO6Q+6rSAvx/lM0Kk3nl32EqxuioTqQBR/1Ti1vZ7ZwOeYAcbUdpHRdjML/RfDYA
 djE1m7jBFeorXTMktwGyJCrnzH34cLlEqd7YHSXJm81QlwFthuSKiakCC2c4P2WOSJ89gxR5T
 jwq40qSp1Lg2v4JPeWLMG+//mJLusy6nY5r4OTEcB9B8IvX7BToCYewG2k3FPHOb2mJss5j4+
 r9bGIzXdd1W0V5Hka7RmtUY+Jj4jTQvZSNwwO4EIc5QlJquUd4=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 6, 2020 at 4:44 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 3/3/2020 11:40 AM, Arnd Bergmann wrote:
> >> -          ret = read##bw(PCI_IOBASE + addr);
> >> +          __io_pbr();
> >> +          ret = __raw_read##bw(PCI_IOBASE + addr);
> >> +          __io_pbr();
> > __io_par();
> >
>
> Why do we need to change read##bw above?
>
> read##bw already provides strong ordering guarantees across multiple
> architectures.

The exact semantics of inl() and readl() are slightly different, so they
have distinct sets of barriers in the asm-generic/io.h implementation.

For instance, the arm64 architectures defines in_par() as '__iormb(v)',
but defines __io_ar() as a  '__rmb()'. Similarly, riscv defines them
as "fence i,ior" and "fence i,r".

You could argue that the definitions are wrong (I have not checked the
history of the definitions), but as long as the inb() in asm-generic/io.h
uses those, the implementation in lib/logic_pio.c uses the same ones
to make the two behave the same way.

       Arnd
