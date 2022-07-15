Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36D3575DA1
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jul 2022 10:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiGOIjU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jul 2022 04:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiGOIjL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jul 2022 04:39:11 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BFE51416;
        Fri, 15 Jul 2022 01:39:09 -0700 (PDT)
Received: from mail-ot1-f51.google.com ([209.85.210.51]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mhl4Q-1nYpMx1O9A-00dosM; Fri, 15 Jul 2022 10:39:07 +0200
Received: by mail-ot1-f51.google.com with SMTP id k8-20020a9d4b88000000b0061c7f8c4f77so2095004otf.10;
        Fri, 15 Jul 2022 01:39:06 -0700 (PDT)
X-Gm-Message-State: AJIora9ZfrV3bdROid6AD8wQL3PFzt++iQ2xe4ScwhMuGWO2zhZ88xap
        t260M3+xVdEyWttA+X/tktJ88qKp3/feYInthCI=
X-Google-Smtp-Source: AGRyM1tHW75qCujFy97ODmosD9Zq5/ZJz8LFlR+pPafKBIRkIjZ9IOLEvm6nWkFKYL4KxpjirK2nvE70QWAIuDMflXk=
X-Received: by 2002:a25:73d1:0:b0:66e:aee4:feb3 with SMTP id
 o200-20020a2573d1000000b0066eaee4feb3mr13106300ybc.452.1657872578352; Fri, 15
 Jul 2022 01:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220714214657.2402250-1-shorne@gmail.com> <20220714214657.2402250-3-shorne@gmail.com>
In-Reply-To: <20220714214657.2402250-3-shorne@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Jul 2022 10:09:21 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2_HKMf8nMcSkK1_jyCEHEdzz=YiRmPvN+ACbPTafXJzA@mail.gmail.com>
Message-ID: <CAK8P3a2_HKMf8nMcSkK1_jyCEHEdzz=YiRmPvN+ACbPTafXJzA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] asm-generic: Add new pci.h and use it
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Nt52xjsJzLfJbx6bRziB8rKjrlCwthE2G6HtbRBCsNBt/zs2mo2
 R+zxCpzWBn+E9PRIJX9sfMfdZ2jE2MFo0nx40nPnt/KwgS5rY+jNF8OTtCszYlSR+DvY55Q
 N8/Q53v9N0+VyQGEsBoArO6QqUcFEg0pTflRtXN7VtD5MerfYTdmUDGldG1AzUHDwPbTmi3
 2XGtKEqTZPyfR9FDnGlLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rYyucx0ZdqI=:rPmF0o7ogy9z6EtFl7IA7Q
 j/McKn5R/FIJ0+0/sN20bcGfqmONXGRRmTvP7LVDrzKVPveFiTULe2gkPGKzEkIMczsZ5RZvl
 2qYhOPZUmtYqEuJuabNpBpo6Ciykp0/kmTYiAjaYljvlLqGx/sjmDJv6HdULJUAsWMxpjYTEw
 wsLC6xmeEzESPYpluUHhPsnR2XwmvqmcUUAubC9D+3MChqbfdxuHk4O5bTF7Kcoj5dsg3NW3H
 jHhynwT7qRT4p6eF/tfG9aMTSbVtRJp4x+MaVitnAiRiaXFYXPYu+9qPIoPbQy2VMUN3EPipF
 mWqHH6dB3xR1Ae8RZSNT+F0fbyCVM1a2FEHANAUzCa0MnyKl0Q7/hjpXMWrQCwYwc6UjiN89N
 1CEL9hsDTTUS3U1b6iEXEDqL69G6UjtteEhaVhR1FVPXL1PlBJTzbzohRUUE/jOsyfUU37+YX
 ABfFnIC4BlyUxk89Q911u0a7585RD+s8UKrdT8gJRs+UlwDoxRsmY1ZBS5APZHoitpwjKX4II
 GVkpT6RNrvY+dpS5Hk3vxeQKAKEof3tBzwMwECk2HCNk2V/JPZbi0aW/6RMnLo/8VlfcBx8YO
 llwJmiSN2P/fnVe5RAJV7QnjUAHzqoammocfEl+BqQgxSeafNHxGrps7iNU/McitKPXbY+clj
 8Z17D1VcrZK6CvDi/nvZn2Ka/uwr1IAOc5wLsojfRnxu5oagPNk3X8CUVxQCdkbzOxkVa3qbJ
 y2uMIRgmjD8TOC8qLtcSVSXhEyKPZl7XihFDKfea7sRGSYcX/tzvtJAaOBvtOrf5so5j9NZ0B
 Yrnhjjk/dXEqVvWfvTphGhuO9rc1KnZpNW3RqdRW/oxg5dKKzmgd/l40PX0Od75ZSo2X/CTKH
 hS4ccGAbxSsDH/Ehbh4Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 14, 2022 at 11:46 PM Stafford Horne <shorne@gmail.com> wrote:
>
> The asm/pci.h used for many newer architectures share similar
> definitions.  Move the common parts to asm-generic/pci.h to allow for
> sharing code.

This looks very nice, thanks for doing it!

> Two things to note are:
>
>  - isa_dma_bridge_buggy, traditionally this is defined in asm/dma.h but
>    these architectures avoid creating that file and add the definition
>    to asm/pci.h.

I would prefer if we could just kill off this variable for non-x86, as it's
only set to a nonzero value in two implementations that are both
x86-specific and most of the references are gone. That does not have
to be part of this series though, if you don't want to address it here, just
add a comment to the new pci.h file.

>  - ARCH_GENERIC_PCI_MMAP_RESOURCE, csky does not define this so we
>    undefine it after including asm-generic/pci.h.  Why doesn't csky
>    define it?

Adding David Woodhouse to Cc, as he introduced this interface. As I
understand it, this was meant as a replacement for the old
architecture specific pci_mmap_page_range interface, and is ideally
used everywhere.

It's probably something that slipped through the review of csky and
should have been there.

As an aside, it seems the pci_mmap_page_range() cleanup was
left almost complete, with sparc being the only one left after
David Miller found a problem with the generic code. Not sure if
this was ever resolved:
https://lore.kernel.org/lkml/1519887203.622.3.camel@infradead.org/t/#u

> +#ifndef PCIBIOS_MIN_IO
> +#define PCIBIOS_MIN_IO         0
> +#endif
> +
> +#define PCIBIOS_MIN_MEM                0

We should probably #ifdef both of these for consistency.

> +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> +{
> +       /* no legacy ide irq support */
> +       return -ENODEV;
> +}

And this can just go away now, according to what we found.

        Arnd
