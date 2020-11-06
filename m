Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D5B2A9D8C
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 20:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgKFTI4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 14:08:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgKFTIz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Nov 2020 14:08:55 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA06120882;
        Fri,  6 Nov 2020 19:08:50 +0000 (UTC)
Date:   Fri, 6 Nov 2020 19:08:48 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Jia He <justin.he@arm.com>, Anup Patel <anup@brainfault.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v4 2/5] arm64, numa: Change the numa init functions name
 to be generic
Message-ID: <20201106190847.GA23792@gaia>
References: <20201006001752.248564-1-atish.patra@wdc.com>
 <20201006001752.248564-3-atish.patra@wdc.com>
 <20201106171403.GK29329@gaia>
 <CAOnJCUJo795yX_7am0hdB_JFio3_ZBRHioHNcydhqEouCUynUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOnJCUJo795yX_7am0hdB_JFio3_ZBRHioHNcydhqEouCUynUg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 06, 2020 at 09:33:14AM -0800, Atish Patra wrote:
> On Fri, Nov 6, 2020 at 9:14 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Mon, Oct 05, 2020 at 05:17:49PM -0700, Atish Patra wrote:
> > > diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> > > index 7ff800045434..96502ff92af5 100644
> > > --- a/arch/arm64/kernel/acpi_numa.c
> > > +++ b/arch/arm64/kernel/acpi_numa.c
> > > @@ -117,16 +117,3 @@ void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
> > >
> > >       node_set(node, numa_nodes_parsed);
> > >  }
> > > -
> > > -int __init arm64_acpi_numa_init(void)
> > > -{
> > > -     int ret;
> > > -
> > > -     ret = acpi_numa_init();
> > > -     if (ret) {
> > > -             pr_info("Failed to initialise from firmware\n");
> > > -             return ret;
> > > -     }
> > > -
> > > -     return srat_disabled() ? -EINVAL : 0;
> > > -}
> >
> > I think it's better if arm64_acpi_numa_init() and arm64_numa_init()
> > remained in the arm64 code. It's not really much code to be shared.
> 
> RISC-V will probably support ACPI one day. The idea is to not to do
> exercise again in future.
> Moreover, there will be arch_numa_init which will be used by RISC-V
> and there will be arm64_numa_init
> used by arm64. However, if you feel strongly about it, I am happy to
> move back those two functions to arm64.

I don't have a strong view on this, only if there's a risk at some point
of the implementations diverging (e.g. quirks). We can revisit it if
that happens.

It may be worth swapping patches 1 and 2 so that you don't have an
arm64_* function in the core code after the first patch (more of a
nitpick). Either way, feel free to add my ack on both patches:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
