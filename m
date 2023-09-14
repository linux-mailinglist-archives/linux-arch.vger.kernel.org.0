Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774CE7A07FE
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 16:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbjINOzH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 10:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240347AbjINOzH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 10:55:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F362DF9;
        Thu, 14 Sep 2023 07:55:02 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RmgMM5jtxz6FGPS;
        Thu, 14 Sep 2023 22:54:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 15:54:59 +0100
Date:   Thu, 14 Sep 2023 15:54:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     James Morse <james.morse@arm.com>, <linux-pm@vger.kernel.org>,
        <loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <x86@kernel.org>, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <jianyong.wu@arm.com>, <justin.he@arm.com>
Subject: Re: [RFC PATCH v2 27/35] ACPICA: Add new MADT GICC flags fields
 [code first?]
Message-ID: <20230914155459.00002dba@Huawei.com>
In-Reply-To: <CAMj1kXHRAt7ecB9p_dm3MjDL5wZkAsVh30hMY2SV_XUe=bm6Vg@mail.gmail.com>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-28-james.morse@arm.com>
        <CAMj1kXHRAt7ecB9p_dm3MjDL5wZkAsVh30hMY2SV_XUe=bm6Vg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 14 Sep 2023 09:57:44 +0200
Ard Biesheuvel <ardb@kernel.org> wrote:

> Hello James,
> 
> On Wed, 13 Sept 2023 at 18:41, James Morse <james.morse@arm.com> wrote:
> >
> > Add the new flag field to the MADT's GICC structure.
> >
> > 'Online Capable' indicates a disabled CPU can be enabled later.
> >  
> 
> Why do we need a bit for this? What would be the point of describing
> disabled CPUs that cannot be enabled (and are you are aware of
> firmware doing this?).

Enabled being not set is common at some similar ACPI tables at least.

This is available in most ACPI tables to allow firmware to use 'nearly'
static tables and just tweak the 'enabled' bit to say if the record should
be ignored or not. Also _STA not present which is for same trick.
If you are doing clever dynamic tables, then you can just not present 
the entry.

With that existing use case in mind, need another bit to say this
one might one day turn up.  Note this is copied from x86 though no
one seems to have implemented the kernel support for them yet.

Note as per my other reply - this isn't a code first proposal. It's in the
spec already (via a code first proposal last year I think).

> 
> So why are we not able to assume that this new bit can always be treated as '1'?

Given above, need the extra bit to size stuff to allow for the CPU showing up
late.


> 
> 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> > This patch probably needs to go via the upstream acpica project,
> > but is included here so the feature can be testd.
> > ---
> >  include/acpi/actbl2.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> > index 3751ae69432f..c433a079d8e1 100644
> > --- a/include/acpi/actbl2.h
> > +++ b/include/acpi/actbl2.h
> > @@ -1046,6 +1046,7 @@ struct acpi_madt_generic_interrupt {
> >  /* ACPI_MADT_ENABLED                    (1)      Processor is usable if set */
> >  #define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1) /* 01: Performance Interrupt Mode */
> >  #define ACPI_MADT_VGIC_IRQ_MODE         (1<<2) /* 02: VGIC Maintenance Interrupt mode */
> > +#define ACPI_MADT_GICC_CPU_CAPABLE      (1<<3) /* 03: CPU is online capable */
> >
> >  /* 12: Generic Distributor (ACPI 5.0 + ACPI 6.0 changes) */
> >
> > --
> > 2.39.2
> >  
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

