Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3377414D0A
	for <lists+linux-arch@lfdr.de>; Wed, 22 Sep 2021 17:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbhIVPew (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Sep 2021 11:34:52 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:54015 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhIVPew (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Sep 2021 11:34:52 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MjjGV-1n8Cpn1WPb-00lEIy; Wed, 22 Sep 2021 17:33:20 +0200
Received: by mail-wr1-f42.google.com with SMTP id d6so7967845wrc.11;
        Wed, 22 Sep 2021 08:33:20 -0700 (PDT)
X-Gm-Message-State: AOAM530v2GmQKYCsSGP6oijS2DC1xsDz6zyavVV3CW5uhtxV+gq1IjyV
        ygBV2XVd1aS5HLndmejUxAeVutaoYlzEGK6mQJE=
X-Google-Smtp-Source: ABdhPJwhV4sn6QbfZmtuFNVQ/C8ICqs5ozmWe9OsEUK5Bilrb7V6OfquRyS7totZd68AXJE2K2qjsuaRkmP6Fh4XNro=
X-Received: by 2002:adf:f481:: with SMTP id l1mr147043wro.411.1632324799917;
 Wed, 22 Sep 2021 08:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H5=Ut+rymv1RH+1GVS2oVZogtuwY_Sk-dDosJh6=USr0Q@mail.gmail.com>
 <20210921223615.GA137894@bhelgaas>
In-Reply-To: <20210921223615.GA137894@bhelgaas>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Sep 2021 17:33:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3SaRTJ_a6tJOHjBeCqwyQTe39-1_2bkD71ZzhJQWCM1Q@mail.gmail.com>
Message-ID: <CAK8P3a3SaRTJ_a6tJOHjBeCqwyQTe39-1_2bkD71ZzhJQWCM1Q@mail.gmail.com>
Subject: Re: [PATCH V3 18/22] LoongArch: Add PCI controller support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
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
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:wdgOelx+a64SdpfMN4aZ6qUDa8IDqDSysuSrPJzqu4rnd8bRF5K
 aDMS98KGDkdxtuY4ffTRTby4drzsRuUe8JvHJtU6BSTtdGWVI6O9ivf75fXUW8QzmheO/pD
 5+pHyHmJIt+deDkBAQVIu+Yb9j1NNxyczt81JjPPeE+tjF6fWfKBjcsz06bzE50O2zvQVvx
 SSUqGc0Uw+5dEFId3uT7g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1kZ/sHYy8Ic=:tY8a6z5+zmV8wFXQ0m/igB
 lT9pNTIn7G9oLObifows2Agv8olkdUBnvtX4FAerKMAEFUJYm1E7wScpgye3wSdyX+yHQvN6T
 FpjkIFbndeDdGee2BQYZtwD7bgnIaMctHqxcAYF5pQ65QgjlMkWLNSGh2uEW2kylJ4adrV7EP
 qyPgCPr7GG7GDcMxsjxSvX36hV6nKRJWkYfsGGOFFXLMeYDzWPSsINRg5klKyFEtxNzs4qjZd
 HTMerU3x+f+FHuyGQvAw5Q9ZmmpFENzbH1yunVFkwAzIPoEn9GiiQk/x4q7j+23wCq6R4epi0
 5dFXd0hP+hQ2OTxBG+QrYDBhSm2tJu29rrpmWaruAGjs5OHo3WdtZqW8HHU4uNSDv0h/QusQs
 Y+Frqdd+15pH3IkBhh1/MxjwBHyArJEQqhFAeeASTYu1SCnvZ5/68H3P3bqAQojyMU5fHGdhf
 Ug9IAeqXTINVJmxy2hyFE0cKwlmczhPiKSqqw8wbno/NPo1jWKkiA7gxbY4ZbVrrP2UWhC6+h
 GUMNNz0owsb0oKfi9gNKxnTENVi/VNZDhFJNefAE9TunOhXuDkdapYlE98uY6PivKFV/JTv0T
 j3lJZe49AqutjLzLfIVcEhaf/JhGB3w6jcoQjAtI0bYksARalI7op94cvQP4TjGH0vsqurEeq
 dT/UFms5B92xqfcpIpBvbcyfA58H4wDHHFa5nZZC4rX94S5kOE+z9dMKtQ7BSMfjiAKHu3elY
 /cNYKx2mLCXF8eU8YWw3C7WY0+v5tDdiPq2VI4i2T9OuKLV78+7UYxxQ2Ge/jleUtdzJfg93a
 K8fV7HYl9FvBVolL68U1gxJA7gcLoKqBe2jmzXi3Nwqohe8TFpfKf0XThIOk9ThzawmPoBLb8
 1xvKtJi27CP319FcvAwA==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 22, 2021 at 12:36 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sat, Sep 18, 2021 at 03:36:52PM +0800, Huacai Chen wrote:
> > On Fri, Sep 17, 2021 at 5:02 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Fri, Sep 17, 2021 at 5:57 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > >
> > > > Loongson64 based systems are PC-like systems which use PCI/PCIe as its
> > > > I/O bus, This patch adds the PCI host controller support for LoongArch.
> > > >
> > > > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > >
> > > As discussed before, I think the PCI support should not be part of the
> > > architecture code or this patch series. The headers are ok, but the pci.c
> > > and acpi.c files have nothing loongarch specific in them, and you clearly
> > > just copied most of this from arm64 or x86.
> >
> > In V2 part of the PCI code (pci-loongson.c) has moved to
> > drivers/pci/controllers. For pci.c and acpi.c, I agree that "the thing
> > should be like that", but have some different ideas about "the way to
> > arrive at that". In my opinion, we can let this series be merged at
> > first, and then do another series to "restructure the files and move
> > common parts to the drivers directory". That way looks more natural to
> > me (doing the other series at first may block the whole thing).

It should not hold up the current series, but I think you should be able
to do both sides (architecture code and pci support) independently
at the same time.

> > > What I would suggest you do instead is:
> > >
> > > - start a separate patch series, addressed to the ACPI, PCI host driver
> > >   and ARM64 maintainers.
> > >
> > > - Move all the bits you need from arch/{arm64,ia64,x86} into
> > >   drivers/acpi/pci/pci_root.c, duplicating them with #if/#elif/#else
> > >   where they are too different, making the #else path the
> > >   default that can be shared with loongarch.
> > >
> > > - Move the bits from pci_root_info/acpi_pci_root_info that are
> > >   always needed into struct pci_host_bridge, with an
> > >   #ifdef CONFIG_ACPI where appropriate.
> > >
> > > - Simplify as much as you can easily do.
>
> I would love to see this done.
>
> But we already have this kind of redundant code for arm64/ia64/x86.
> Arguably, we should have refactored it for ia64 or arm64.  It's
> unfortunate to add loongarch to that list, but why should we penalize
> loongarch more than arm64 and ia64?

There is usually something like this that comes up when support for a
new architecture gets posted and it duplicates some code from other
architectures.

When I review the port, I try to come to a reasonable balance asking
the submitters to clean up some aspect of the common code base
so they and everyone afterwards is able to use more shared
infrastructure without duplication. This is clearly a different area
every time, but I think the ACPI PCI code is an obvious thing to
ask for cleaning up this time, as there are only three existing users.

We could probably have done a better job for the arm64 version,
but even getting that working was enough of a mess (initially
you had only ACPI or PCI but not both together), and there
were other problems with the architecture port that needed sorting
out at the time.

I can definitely offer to help plan this part a little bit better, but
I actually hope it's not all that much work.

        Arnd
