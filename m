Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D727A080E
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 16:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbjINO4k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 10:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjINO4j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 10:56:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81E11FC4;
        Thu, 14 Sep 2023 07:56:35 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RmgP90gY1z67Q1Y;
        Thu, 14 Sep 2023 22:55:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 15:56:33 +0100
Date:   Thu, 14 Sep 2023 15:56:32 +0100
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
Subject: Re: [RFC PATCH v2 06/35] arm64: setup: Switch over to
 GENERIC_CPU_DEVICES using arch_register_cpu()
Message-ID: <20230914155632.00003ca9@Huawei.com>
In-Reply-To: <ZQMTmi7blj/4FpbI@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-7-james.morse@arm.com>
        <20230914122715.000076be@Huawei.com>
        <ZQMTmi7blj/4FpbI@shell.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 14 Sep 2023 15:07:22 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Thu, Sep 14, 2023 at 12:27:15PM +0100, Jonathan Cameron wrote:
> > On Wed, 13 Sep 2023 16:37:54 +0000
> > James Morse <james.morse@arm.com> wrote:
> >   
> > > To allow ACPI's _STA value to hide CPUs that are present, but not
> > > available to online right now due to VMM or firmware policy, the
> > > register_cpu() call needs to be made by the ACPI machinery when ACPI
> > > is in use. This allows it to hide CPUs that are unavailable from sysfs.
> > > 
> > > Switching to GENERIC_CPU_DEVICES is an intermediate step to allow all
> > > five ACPI architectures to be modified at once.
> > > 
> > > Switch over to GENERIC_CPU_DEVICES, and provide an arch_register_cpu()
> > > that populates the hotpluggable flag. arch_register_cpu() is also the
> > > interface the ACPI machinery expects.
> > > 
> > > The struct cpu in struct cpuinfo_arm64 is never used directly, remove
> > > it to use the one GENERIC_CPU_DEVICES provides.
> > > 
> > > This changes the CPUs visible in sysfs from possible to present, but
> > > on arm64 smp_prepare_cpus() ensures these are the same.
> > > 
> > > Signed-off-by: James Morse <james.morse@arm.com>  
> > 
> > After this the earlier question about ordering of cpu_dev_init()
> > and node_dev_init() is relevant.   
> > 
> > Why won't node_dev_init() call
> > get_cpu_devce() which queries per_cpu(cpu_sys_devices)
> > and get NULL as we haven't yet filled that in?
> > 
> > Or does it do so but that doesn't matter as well create the
> > relevant links later?  
> 
> node_dev_init() will walk through the nodes calling register_one_node()
> on each. This will trickle down to __register_one_node() which walks
> all present CPUs, calling register_cpu_under_node() on each.
> 
> register_cpu_under_node() will call get_cpu_device(cpu) for each and
> will return NULL until the CPU is registered using register_cpu(),
> which will now happen _after_ node_dev_init().
> 
> So, at this point, CPUs won't get registered, and initially one might
> think that's a problem.
> 
> However, register_cpu() will itself call register_cpu_under_node(),
> where get_cpu_device() will return the now populated entry, and the
> sysfs links will be created.
> 
> So, I think what you've spotted is a potential chunk of code that
> isn't necessary when using GENERIC_CPU_DEVICES after this change!
> 

Makes sense thanks. I was just being too lazy to check and bouncing it back
at James! *looks guilty*

Jonathan
