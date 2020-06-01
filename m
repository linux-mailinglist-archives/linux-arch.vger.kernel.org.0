Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230081EA588
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jun 2020 16:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgFAOGN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jun 2020 10:06:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgFAOGM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Jun 2020 10:06:12 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5CA32077D;
        Mon,  1 Jun 2020 14:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591020371;
        bh=HdEiBnB7+tQ9qOLsBO+VIuGgbzGS+nEOR7e+a6BDJ1k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iPOTMoAQuEhw9rn2x+5jyMCfrGMrX4nn2q9HOAOopbSYbD0dWKBdh98jPKllE++Dw
         ajyHFSW0nxmFLgSuKbb8Mw6ME9mpVBTnZFE1CX6mpzAFybI6ca9hCpyYKb9gbwuTI/
         lSfyt0QQ4XtXfStOdBPAWIi3C1ihyvXpT8xj1HBw=
Received: by mail-ot1-f49.google.com with SMTP id v17so8096436ote.0;
        Mon, 01 Jun 2020 07:06:11 -0700 (PDT)
X-Gm-Message-State: AOAM531IeLsww+t5oP7i6yG+och0wgpMPC99eBDQjc+OTVvDha1DRwTi
        3u5v+J0HLkk5rkS/HkypTM9BL9/kUfaadMpUpA==
X-Google-Smtp-Source: ABdhPJyX88CyvywA3XTgs8DQkY5wx0NzlC3EosrdeTaDozuT1YyKjbMpm5TyNHRfFoPJyPPCubtQ+TfIP6qUFoKcCFQ=
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr17181691ots.192.1591020370946;
 Mon, 01 Jun 2020 07:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1581497860.git.michal.simek@xilinx.com> <CAL_JsqJeXJ6zWvEUi=gyOV0eCcXsvNmkK9EstC9hg9AKfMXnKw@mail.gmail.com>
 <0f8140c1-da6f-ef04-0809-252d6de6a5d7@xilinx.com> <CAL_JsqLf2e3z+m14264WFcsQgiwKR35Rs9Rw0c_MgoFvKwO2Xg@mail.gmail.com>
 <5dfa98df-8955-59fd-1d65-c0a988190acb@xilinx.com> <BYAPR02MB5559708A5A584D05516D77EBA58A0@BYAPR02MB5559.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB5559708A5A584D05516D77EBA58A0@BYAPR02MB5559.namprd02.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 1 Jun 2020 08:05:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKs1AUxVsf=HhYwMY0Met8SFf0ZCfMQuS4EajTPRVcBag@mail.gmail.com>
Message-ID: <CAL_JsqKs1AUxVsf=HhYwMY0Met8SFf0ZCfMQuS4EajTPRVcBag@mail.gmail.com>
Subject: Re: [PATCH 00/10] Hi,
To:     Bharat Kumar Gogada <bharatku@xilinx.com>
Cc:     Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>, git <git@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Cornelia Huck <cohuck@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mubin Usman Sayyed <MUBINUSM@xilinx.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>,
        Stefan Asserhall <stefana@xilinx.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Will Deacon <will@kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, May 31, 2020 at 10:22 PM Bharat Kumar Gogada
<bharatku@xilinx.com> wrote:
>
> > On 25. 02. 20 17:32, Rob Herring wrote:
> > > On Mon, Feb 17, 2020 at 8:28 AM Michal Simek <michal.simek@xilinx.com>
> > wrote:
> > >>
> > >> Hi Rob,
> > >>
> > >> On 14. 02. 20 0:47, Rob Herring wrote:
> > >>> On Wed, Feb 12, 2020 at 2:58 AM Michal Simek
> > <michal.simek@xilinx.com> wrote:
> > >>>>
> > >>>>
> > >>>> I am sending this series as before SMP support.
> > >>>> Most of these patches are clean ups and should be easy to review
> > >>>> them. I expect there will be more discussions about SMP support.
> > >>>
> > >>> While not really related to adding SMP, any chance you or someone
> > >>> could look at moving microblaze PCI support to drivers/pci/? I
> > >>> suspect much of the code should drop out as we have common helpers
> > >>> for much of it now. That would leave only powerpc and mips for DT+PCI
> > platforms.
> > >>
> > >> can you please suggest changes which could be done?
> > >> I have CC Bharat and he could look at it.
> > >
> > > Look at the host controller drivers in drivers/pci/controller/.
> > > pci-host-{generic,common}.c is a good template to start with as that's
> > > a controller with standard config space accesses and no h/w setup
> > > needed. Essentially you need to call devm_pci_alloc_host_bridge(),
> > > pci_parse_request_of_pci_ranges() and pci_host_probe() with whatever
> > > h/w setup you need in between those calls.
> > >
> > > Looking at the microblaze PCI code, looks like you may need custom
> > > config space accessors which is quite common. Probably all the
> > > resource and device scanning can be removed. If you look at arm64, all
> > > the arch PCI code is just for ACPI.
> Hi Rob,
>
> Can you please let us know why we might need custom config space accessors ?
> We tested pci_generic_config_read/write accessors on microblaze, and we
> did not see any issues.

I was thinking maybe the indirect code might have to be custom, but
maybe everything can be handled in .map_bus().

Rob
