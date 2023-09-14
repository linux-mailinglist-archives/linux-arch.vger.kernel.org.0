Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08137A06E0
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 16:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbjINOHc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 10:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbjINOHc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 10:07:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DDD1BF8;
        Thu, 14 Sep 2023 07:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GIdT/cJmFA2qx50pgPlJRNzy/bheI4vUqGYQu+a7PMI=; b=raixHrVeNVHHMS+SmMW0fsVxI+
        rZLO2b1FApnkXyJLVlkjBZUzsfFxmDi2JMVVu/R8wleWSzTAHzOFKzQL/zWb/JJhTJQkeyGGl2H3d
        1EsUw8fAPKHCZzu4CyyEqx+rG9yuFwm7T+vos+z7VLqGttytZaDieHznwmb3696A6aPLvSAslWr7a
        thmdyxIrHQUHf4/fW3Cr1tTqOrfips0KHORhG+5wXWbJd9QGypzhjjzPeg+uOfhgIbBdTkF3z9ckY
        NUhze25dfC5TxiZv0q43BsedV3/l/zOQC9B/nOQb7gFNThJ/nZ0J8fzai0g8EC7sBDROC7wVMPZBJ
        p/hgjtbQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37510)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qgn08-0004Jo-2O;
        Thu, 14 Sep 2023 15:07:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qgn06-0004ol-Vs; Thu, 14 Sep 2023 15:07:22 +0100
Date:   Thu, 14 Sep 2023 15:07:22 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: Re: [RFC PATCH v2 06/35] arm64: setup: Switch over to
 GENERIC_CPU_DEVICES using arch_register_cpu()
Message-ID: <ZQMTmi7blj/4FpbI@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-7-james.morse@arm.com>
 <20230914122715.000076be@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914122715.000076be@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 14, 2023 at 12:27:15PM +0100, Jonathan Cameron wrote:
> On Wed, 13 Sep 2023 16:37:54 +0000
> James Morse <james.morse@arm.com> wrote:
> 
> > To allow ACPI's _STA value to hide CPUs that are present, but not
> > available to online right now due to VMM or firmware policy, the
> > register_cpu() call needs to be made by the ACPI machinery when ACPI
> > is in use. This allows it to hide CPUs that are unavailable from sysfs.
> > 
> > Switching to GENERIC_CPU_DEVICES is an intermediate step to allow all
> > five ACPI architectures to be modified at once.
> > 
> > Switch over to GENERIC_CPU_DEVICES, and provide an arch_register_cpu()
> > that populates the hotpluggable flag. arch_register_cpu() is also the
> > interface the ACPI machinery expects.
> > 
> > The struct cpu in struct cpuinfo_arm64 is never used directly, remove
> > it to use the one GENERIC_CPU_DEVICES provides.
> > 
> > This changes the CPUs visible in sysfs from possible to present, but
> > on arm64 smp_prepare_cpus() ensures these are the same.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> 
> After this the earlier question about ordering of cpu_dev_init()
> and node_dev_init() is relevant.   
> 
> Why won't node_dev_init() call
> get_cpu_devce() which queries per_cpu(cpu_sys_devices)
> and get NULL as we haven't yet filled that in?
> 
> Or does it do so but that doesn't matter as well create the
> relevant links later?

node_dev_init() will walk through the nodes calling register_one_node()
on each. This will trickle down to __register_one_node() which walks
all present CPUs, calling register_cpu_under_node() on each.

register_cpu_under_node() will call get_cpu_device(cpu) for each and
will return NULL until the CPU is registered using register_cpu(),
which will now happen _after_ node_dev_init().

So, at this point, CPUs won't get registered, and initially one might
think that's a problem.

However, register_cpu() will itself call register_cpu_under_node(),
where get_cpu_device() will return the now populated entry, and the
sysfs links will be created.

So, I think what you've spotted is a potential chunk of code that
isn't necessary when using GENERIC_CPU_DEVICES after this change!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
