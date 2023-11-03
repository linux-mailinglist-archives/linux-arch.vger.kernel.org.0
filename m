Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA8A7E04CF
	for <lists+linux-arch@lfdr.de>; Fri,  3 Nov 2023 15:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjKCOhd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Nov 2023 10:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjKCOhd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Nov 2023 10:37:33 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E798CA;
        Fri,  3 Nov 2023 07:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=72hxmQCBkLT/0leJQbNO6c+d3oMFYZOQGMSD17s25rI=; b=q8smHBP7DkeRlLmtBpuVNpbR3l
        Xsq9Jg+jETRWE9W6AuGqCDDiqxwTUQfqg0tFog/sx8M46baq9d88THW80uQlFB4fqAYCq/DzxQVtR
        g+/2VpoltDLb+HANTiWd7cpJg0mw85W6TI5UDDVSr2mh9gorJBllB4eQsCGu1APZJcTsAOhGxLMOF
        rSERDI7IL5O8ysT9mss7VBj65MH8WJWsPtnKokF1trUFWaDHPGx5/Vd1P9pA1ypJccnB9lslaWTOy
        kAjrpoOnuaYuqlvim1kLdN33vhWIuNl3wQW0SUOYQZtw8JeMgy8G8ndUDUjLI2wchB2QT/eSQVcIQ
        Y4XdND7w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54582)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qyvIX-0005cb-1Y;
        Fri, 03 Nov 2023 14:37:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qyvIY-0008Tw-8D; Fri, 03 Nov 2023 14:37:22 +0000
Date:   Fri, 3 Nov 2023 14:37:22 +0000
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
Subject: Re: [RFC PATCH v2 22/35] ACPI: Check _STA present bit before making
 CPUs not present
Message-ID: <ZUUFovp4x9TkWBYn@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-23-james.morse@arm.com>
 <518859b1-64a9-d723-963c-56c7f6fc2da1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <518859b1-64a9-d723-963c-56c7f6fc2da1@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 19, 2023 at 10:45:39AM +1000, Gavin Shan wrote:
> On 9/14/23 02:38, James Morse wrote:
> > When called acpi_processor_post_eject() unconditionally make a CPU
> > not-present and unregisters it.
> > 
> > To add support for AML events where the CPU has become disabled, but
> > remains present, the _STA method should be checked before calling
> > acpi_processor_remove().
> > 
> > Rename acpi_processor_post_eject() acpi_processor_remove_possible(), and
> > check the _STA before calling.
> > 
> > Adding the function prototype for arch_unregister_cpu() allows the
> > preprocessor guards to be removed.
> > 
> > After this change CPUs will remain registered and visible to
> > user-space as offline if buggy firmware triggers an eject-request,
> > but doesn't clear the corresponding _STA bits after _EJ0 has been
> > called.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >   drivers/acpi/acpi_processor.c | 31 +++++++++++++++++++++++++------
> >   include/linux/cpu.h           |  1 +
> >   2 files changed, 26 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> > index 00dcc23d49a8..2cafea1edc24 100644
> > --- a/drivers/acpi/acpi_processor.c
> > +++ b/drivers/acpi/acpi_processor.c
> > @@ -457,13 +457,12 @@ static int acpi_processor_add(struct acpi_device *device,
> >   	return result;
> >   }
> > -#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
> >   /* Removal */
> > -static void acpi_processor_post_eject(struct acpi_device *device)
> > +static void acpi_processor_make_not_present(struct acpi_device *device)
> >   {
> >   	struct acpi_processor *pr;
> > -	if (!device || !acpi_driver_data(device))
> > +	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
> >   		return;
> 
> In order to use IS_ENABLED(),

And the rest of this statement is where?

> >   	pr = acpi_driver_data(device);
> > @@ -501,7 +500,29 @@ static void acpi_processor_post_eject(struct acpi_device *device)
> >   	free_cpumask_var(pr->throttling.shared_cpu_map);
> >   	kfree(pr);
> >   }
> > -#endif /* CONFIG_ACPI_HOTPLUG_PRESENT_CPU */
> > +
> > +static void acpi_processor_post_eject(struct acpi_device *device)
> > +{
> > +	struct acpi_processor *pr;
> > +	unsigned long long sta;
> > +	acpi_status status;
> > +
> > +	if (!device)
> > +		return;
> > +
> > +	pr = acpi_driver_data(device);
> > +	if (!pr || pr->id >= nr_cpu_ids || invalid_phys_cpuid(pr->phys_id))
> > +		return;
> > +
> 
> Do we really need to validate the logic and hardware CPU IDs here? I think
> the ACPI processor device can't be added successfully if one of them is
> invalid.
> 
> > +	status = acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
> > +	if (ACPI_FAILURE(status))
> > +		return;
> > +
> > +	if (cpu_present(pr->id) && !(sta & ACPI_STA_DEVICE_PRESENT)) {
> > +		acpi_processor_make_not_present(device);
> > +		return;
> > +	}
> > +}
> >   #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
> >   bool __init processor_physically_present(acpi_handle handle)
> > @@ -626,9 +647,7 @@ static const struct acpi_device_id processor_device_ids[] = {
> >   static struct acpi_scan_handler processor_handler = {
> >   	.ids = processor_device_ids,
> >   	.attach = acpi_processor_add,
> > -#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
> >   	.post_eject = acpi_processor_post_eject,
> > -#endif
> >   	.hotplug = {
> >   		.enabled = true,
> >   	},
> > diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> > index a71691d7c2ca..e117c06e0c6b 100644
> > --- a/include/linux/cpu.h
> > +++ b/include/linux/cpu.h
> > @@ -81,6 +81,7 @@ struct device *cpu_device_create(struct device *parent, void *drvdata,
> >   				 const struct attribute_group **groups,
> >   				 const char *fmt, ...);
> >   extern int arch_register_cpu(int cpu);
> > +extern void arch_unregister_cpu(int cpu);
> 
> arch_unregister_cpu() is protected by CONFIG_HOTPLUG_CPU in the individual architectures,
> for example arch/ia64/kernel/topology.c

Yes, I agree, there _may_ be a reference to arch_unregister_cpu() if
the compiler doesn't optimise the "if(0) return".

As things stand in my "head" tree (which I'll be posting once 6.7-rc1
is out) at the point that this patch exists in the series, there are
no architectures which provide arch_unregister_cpu(), and the only
implementation of it is the __weak one in drivers/base/cpu.c

That implementation is also ifdef'd with CONFIG_HOTPLUG_CPU and also
CONFIG_GENERIC_CPU_DEVICES.

Meanwhile, acpi_processor.c is always built with ACPI, and while we
have IS_ENABLED() clauses with James' patches for both of these
symbols, if the compiler doesn't optimise the code away, we will end
up with a reference and a link-time error. That being said, the 0-day
bot has not reported anything as yet (and it builds my tree.)

So, is this a problem that needs to be solved or not?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
