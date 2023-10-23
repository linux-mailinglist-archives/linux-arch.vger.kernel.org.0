Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041047D2D4A
	for <lists+linux-arch@lfdr.de>; Mon, 23 Oct 2023 10:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjJWIzQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Oct 2023 04:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjJWIzO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Oct 2023 04:55:14 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02DA110;
        Mon, 23 Oct 2023 01:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DUu7jHK3cwMjrPkO/5tAgZHCLMP/K1QRkga1FP0LTZk=; b=sT9ELYEdhxi5/sCCZwm8mnuqGw
        VC0VEu7ZsZUy6lYyqNo8+IHIW5Y/iaO7TrDl9G8KF1w8JUfUkGYr2EQTwsfqLAyql9o4cWnuRNgpn
        4LUivt9JRLIxws9jStmY8RDdixkJM7hCPbHV6ie2Jf+BfbH9u7+QdJL3z3ytskg9JCnYXLA9WAfe8
        so7r4fOvyPJhn4tAGg1DzR3bInek5wIkLBQCrZpPAL3SPnWZ1ZyBnm1BEqZMzNTBTFxyrGLdWXCoH
        jOm+I2meKbbx24VFvlqBpPWDqK9EhANEYPTUKd1RgfiT6AXUAlYK1cy5eEh3SUIAku6C6owhy7MJW
        WoiDRzpg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43922)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1quqiJ-0002hG-2D;
        Mon, 23 Oct 2023 09:55:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1quqiK-0004gK-F9; Mon, 23 Oct 2023 09:55:08 +0100
Date:   Mon, 23 Oct 2023 09:55:08 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Gavin Shan <gshan@redhat.com>
Cc:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: Re: [RFC PATCH v2 24/35] drivers: base: Implement weak
 arch_unregister_cpu()
Message-ID: <ZTY07FlviAL1DlNz@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-25-james.morse@arm.com>
 <8be3a9dc-8f59-9ef9-3662-95814e177125@redhat.com>
 <ZTYygtKt4w9C0Oxw@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTYygtKt4w9C0Oxw@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 23, 2023 at 09:44:50AM +0100, Russell King (Oracle) wrote:
> On Tue, Sep 19, 2023 at 10:59:23AM +1000, Gavin Shan wrote:
> > On 9/14/23 02:38, James Morse wrote:
> > > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > > index 677f963e02ce..c709747c4a18 100644
> > > --- a/drivers/base/cpu.c
> > > +++ b/drivers/base/cpu.c
> > > @@ -531,7 +531,14 @@ int __weak arch_register_cpu(int cpu)
> > >   {
> > >   	return register_cpu(&per_cpu(cpu_devices, cpu), cpu);
> > >   }
> > > -#endif
> > > +
> > > +#ifdef CONFIG_HOTPLUG_CPU
> > > +void __weak arch_unregister_cpu(int num)
> > > +{
> > > +	unregister_cpu(&per_cpu(cpu_devices, num));
> > > +}
> > > +#endif /* CONFIG_HOTPLUG_CPU */
> > > +#endif /* CONFIG_GENERIC_CPU_DEVICES */
> > 
> > It seems conflicting with its declaration in include/linux/cpu.h.
> 
> How so? The declaration is:
> 
> extern void arch_unregister_cpu(int cpu);
> 
> So:
> 
> void __weak arch_unregister_cpu(int num)
> 
> is compatible.
> 
> > Besides, the function is still needed by
> > drivers/acpi/acpi_processor.c::acpi_processor_make_not_present()
> > even both CONFIG_HOTPLUG_CPU and CONFIG_GENERIC_CPU_DEVICES are disabled?
> 
> Yes, I agree - it needs to be present when ACPI is built, so I'm
> thinking the right solution is to move it out from under at least
> CONFIG_HOTPLUG_CPU.
> 
> It can't be moved out from under CONFIG_GENERIC_CPU_DEVICES because
> then we end up referencing the per-cpu variable cpu_devices which only
> exists when CONFIG_GENERIC_CPU_DEVICES is enabled. Is that a problem
> though, because in the case of !CONFIG_GENERIC_CPU_DEVICES, aren't
> architectures required to provide both arch_.*register_cpu() functions?

I'm also wondering why this patch isn't part of:

"drivers: base: Allow parts of GENERIC_CPU_DEVICES to be overridden"
because it seems to be doing something very similar.

The commit I refer to introduces a weak version of arch_register_cpu(),
and it seems it would also be appropriate to introduce a weak version
of its unregister paired function at the same time.

Any existing definitions of non-weak arch_unregister_cpu() would
override it so it shouldn't cause any issues.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
