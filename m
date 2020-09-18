Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E801A2705DC
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 21:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgIRT7L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 15:59:11 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:59551 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgIRT7K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 15:59:10 -0400
Received: from mail-qv1-f53.google.com ([209.85.219.53]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M7aqD-1kOa8H2TiH-0081tZ; Fri, 18 Sep 2020 21:59:08 +0200
Received: by mail-qv1-f53.google.com with SMTP id j3so3588296qvi.7;
        Fri, 18 Sep 2020 12:59:08 -0700 (PDT)
X-Gm-Message-State: AOAM530ZeA+inWt9/NUkL62YrpIHKAwi+jcnZKhF3N9L3B/PbdVnsya/
        oi0z+HavLMw4yRHXwDKid3mKo/SHozliPNXw794=
X-Google-Smtp-Source: ABdhPJytBHBh/fQMXo7+68dbrxEABzvlGs5A0AsCoE1YgJGiTA+FdkuyePsZid8ag08tntnusNEq5NJL9EnWegFjyH8=
X-Received: by 2002:a0c:b902:: with SMTP id u2mr33843869qvf.7.1600459147303;
 Fri, 18 Sep 2020 12:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200915093203.16934-1-lorenzo.pieralisi@arm.com>
 <cover.1600254147.git.lorenzo.pieralisi@arm.com> <20200918114508.GA20110@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200918114508.GA20110@e121166-lin.cambridge.arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Sep 2020 21:58:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1f9Qj+yhMB4QaAu36ZUQ1p6oKHm2MZQ3zU31q6xmymGA@mail.gmail.com>
Message-ID: <CAK8P3a1f9Qj+yhMB4QaAu36ZUQ1p6oKHm2MZQ3zU31q6xmymGA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fix pci_iounmap() on !CONFIG_GENERIC_IOMAP
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        George Cherian <george.cherian@marvell.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:VRIHA3kLYuVnqBOmVjZxDHpU5iuxIlHABaeAykjpWRJG87XIlvQ
 nzm3sJNPdfFThXmkqyLysreEc+3FT/n9/9a3iFPzE1VldoYL3pSVbI7xm1N5t0Ntdj2H3E5
 0wns+4uby2aVC8sMbV7XixaW/OoRhu52L49WST1aoWuqFsS75RJmLdKhgUHKZ4FxiCNF5oG
 IDiSkaNIyG8J5Sglb2QTQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sGyc9ZK48K0=:MgR91tZDwpTRSSaUl5QwuW
 w7NJlzbSeEqaw1gKql7IuPwyNTolfpxmJnzLD+kD6jG27ciar1zrqhU4B+qMayu7h82FWbZuj
 qyy4qh9fJdjSGWQYIJmFZUDhi0LiZafpDYE0uSQH3iUfVrfoSyTj4QZUZ2ixbSlQxe46nBKl1
 YwSiLMC6CxU1SQFzNLaXZpV3vX0u8aa1JaACYzKyY8jX40J9RSb34ZvKcb4/XwwA2McF12O25
 vBoSilcB0ynE8LGYTPu5yvGmZ2ettPn152/sEwjIHLrqwB5G99W3tM/ZV9Y7f/eetDjUTn1WM
 MjnE0qyfvsWJ99AKefuOpqhtTrnxmdVFUEzGnif2H2FBGhem//UViQhLaEmzkakIxp5M5KWB8
 LwvoRSg4lwxc5lx6yP7FZoGfb9OPPVvEvCCr1b02mWiqo99uRTIqfatDXoL33U3eZZHYNXWQa
 q6ApbB2LOjGq2vXAHjaRdR+vA4frdNzk1nLikZvpKxDPqRs8UY87kRmzxojd+KCqHznclxjmq
 iEdOKYfQWHJsjDDLWMqnWX1ezXcNtmqNiDVPjCm80J++O8c5PfWsCFz15S8CT2Tof28M5VeZh
 Wtn4DYEEi0aKbE2WU6t+jkg5idcgqz10aSPCnvwUq5i8/rrexesjJ8Kjh32C/Z9LMFAeV3t1n
 mEDPp/ucOB6kGTGY4boICZpP2ghp4lqOrj63nrmqYLUQ6jR4zz4ff9Z8WyubjGtlA+IUR2Pjq
 yvpC9n8swLV2z+lVd0A/hlN6cpp/qaBs3Ez0ccHvClombF27bt2yVQQpb6ePRaQFG+V5HMYnA
 gc+Zj337DEaXH0oShl2TKT/dZYbSoqjylcy8HzbE5SaJEWS+lyFc7rdYrzbytwIto5oL/pF
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 18, 2020 at 1:45 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> >
> > Lorenzo Pieralisi (3):
> >   sparc32: Remove useless io_32.h __KERNEL__ preprocessor guard
> >   sparc32: Move ioremap/iounmap declaration before asm-generic/io.h
> >     include
> >   asm-generic/io.h: Fix !CONFIG_GENERIC_IOMAP pci_iounmap()
> >     implementation
> >
> >  arch/sparc/include/asm/io_32.h | 17 ++++++---------
> >  include/asm-generic/io.h       | 39 +++++++++++++++++++++++-----------
> >  2 files changed, 34 insertions(+), 22 deletions(-)
>
> Arnd, David, Bjorn,
>
> I have got review/test tags, is it OK if we merge this series please ?
>
> Can we pull it in the PCI tree or you want it to go via a different
> route upstream ?
>
> Please let me know.

Going through the PCI tree sounds good to me, but I can
take it through the asm-generic tree if Bjorn doesn't want to
pick it up there.

       Arnd
