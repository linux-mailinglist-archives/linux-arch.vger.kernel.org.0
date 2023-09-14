Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458B07A0202
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 12:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbjINK4X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 06:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjINK4W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 06:56:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B583F1BFE;
        Thu, 14 Sep 2023 03:56:17 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RmZ3v01jqz6K5v5;
        Thu, 14 Sep 2023 18:55:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 11:56:14 +0100
Date:   Thu, 14 Sep 2023 11:56:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     James Morse <james.morse@arm.com>, <linux-pm@vger.kernel.org>,
        <loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <x86@kernel.org>, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <jianyong.wu@arm.com>, <justin.he@arm.com>
Subject: Re: [RFC PATCH v2 02/35] drivers: base: Use present CPUs in
 GENERIC_CPU_DEVICES
Message-ID: <20230914115613.0000778e@Huawei.com>
In-Reply-To: <ZQLCZsw+ZGbTM8oK@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-3-james.morse@arm.com>
        <ZQLCZsw+ZGbTM8oK@shell.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 14 Sep 2023 09:20:54 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Sep 13, 2023 at 04:37:50PM +0000, James Morse wrote:
> > Three of the five ACPI architectures create sysfs entries using
> > register_cpu() for present CPUs, whereas arm64, riscv and all
> > GENERIC_CPU_DEVICES do this for possible CPUs.
> > 
> > Registering a CPU is what causes them to show up in sysfs.
> > 
> > It makes very little sense to register all possible CPUs. Registering
> > a CPU is what triggers the udev notifications allowing user-space to
> > react to newly added CPUs.
> > 
> > To allow all five ACPI architectures to use GENERIC_CPU_DEVICES, change
> > it to use for_each_present_cpu(). Making the ACPI architectures use
> > GENERIC_CPU_DEVICES is a pre-requisite step to centralise their
> > cpu_register() logic, before moving it into the ACPI processor driver.
> > When ACPI is disabled this work would be done by
> > cpu_dev_register_generic().
> > 
> > Of the ACPI architectures that register possible CPUs, arm64 and riscv
> > do not support making possible CPUs present as they use the weak 'always
> > fails' version of arch_register_cpu().
> > 
> > Only two of the eight architectures that use GENERIC_CPU_DEVICES have a
> > distinction between present and possible CPUs.
> > 
> > The following architectures use GENERIC_CPU_DEVICES but are not SMP,
> > so possible == present:
> >  * m68k
> >  * microblaze
> >  * nios2
> > 
> > The following architectures use GENERIC_CPU_DEVICES and consider
> > possible == present:
> >  * csky: setup_smp()
> >  * parisc: smp_prepare_boot_cpu() marks the boot cpu as present,
> >    processor_probe() sets possible for all CPUs and present for all CPUs
> >    except the boot cpu.  
> 
> However, init/main.c::start_kernel() calls boot_cpu_init() which sets
> the boot CPU in the online, active, present and possible masks. So,
> _every_ architecture gets the boot CPU in all these masks no matter
> what.
> 
> Only of something then clears the boot CPU from these masks (which
> would be silly) would the boot CPU not be in all of these masks.
Hi Russel,

Upshot is that the code in parisc smp_prepare_boot_cpu() can be dropped?
Seems like another useful simplification to add to front of this series.
The function will end up with just a print then. 
Seems there are lots of other empty implementations of smp_prepare_boot_cpu()
maybe worth making that optional whilst here and dropping all the empty ones?

There seem to be some other architectures setting at least some of the cpu masks
that could perhaps be tidied up a little via same logic?

Jonathan

> 

