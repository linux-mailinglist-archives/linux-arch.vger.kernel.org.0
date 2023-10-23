Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247647D4097
	for <lists+linux-arch@lfdr.de>; Mon, 23 Oct 2023 22:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjJWUCC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Oct 2023 16:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJWUCC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Oct 2023 16:02:02 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65115F9;
        Mon, 23 Oct 2023 13:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aZyGRwEv0iUdzK429NjcYATM8WFVnBChclCibm7Si3A=; b=pSY/eaDRzPVfujJtREsnNZj+LO
        /p+NuKMtQPf/2JkoIfPYg79SLzNYeYhtWZOSComP7w9bgywGy/wzZZDFl0NLnmNFNXPESP0sWalS9
        VG3DqEOlkmMikGXbr0VhQPXE/lyU5S+xhxhb/vfc+PGsidk3Nk97sdgk+qe1RSt/EC2X16PuOnbZM
        0QhdrMpGn9tBUegcvYZl/6LVBSQyqABNIhnYDfZxZuPOLOAAHO85JkzyovjAAkuQkGTVpTiKd0imm
        TqCx3RsW2GCf1fA/3dfVWzIsA6ghyq96uryRM+fe2equbXYHHK4tYinS3xHwE6EMpwOK1NpiUVdNB
        mHe3Br5A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56976)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qv17W-0003Si-0l;
        Mon, 23 Oct 2023 21:01:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qv17S-0005AN-Pc; Mon, 23 Oct 2023 21:01:46 +0100
Date:   Mon, 23 Oct 2023 21:01:46 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Gavin Shan <gshan@redhat.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: Re: [RFC PATCH v2 20/35] ACPI: Rename acpi_processor_hotadd_init and
 remove pre-processor guards
Message-ID: <ZTbRKgxtiq9XQKBr@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-21-james.morse@arm.com>
 <20230914151720.00007105@Huawei.com>
 <b8f430c1-c30f-191f-18c6-f750fa6ba476@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8f430c1-c30f-191f-18c6-f750fa6ba476@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 18, 2023 at 03:50:09PM +1000, Gavin Shan wrote:
> 
> On 9/15/23 00:17, Jonathan Cameron wrote:
> > On Wed, 13 Sep 2023 16:38:08 +0000
> > James Morse <james.morse@arm.com> wrote:
> > 
> > > acpi_processor_hotadd_init() will make a CPU present by mapping it
> > > based on its hardware id.
> > > 
> > > 'hotadd_init' is ambiguous once there are two different behaviours
> > > for cpu hotplug. This is for toggling the _STA present bit. Subsequent
> > > patches will add support for toggling the _STA enabled bit, named
> > > acpi_processor_make_enabled().
> > > 
> > > Rename it acpi_processor_make_present() to make it clear this is
> > > for CPUs that were not previously present.
> > > 
> > > Expose the function prototypes it uses to allow the preprocessor
> > > guards to be removed. The IS_ENABLED() check will let the compiler
> > > dead-code elimination pass remove this if it isn't going to be
> > > used.
> > > 
> > > Signed-off-by: James Morse <james.morse@arm.com>
> > > ---
> > >   drivers/acpi/acpi_processor.c | 14 +++++---------
> > >   include/linux/acpi.h          |  2 --
> > >   2 files changed, 5 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> > > index 75257fae10e7..22a15a614f95 100644
> > > --- a/drivers/acpi/acpi_processor.c
> > > +++ b/drivers/acpi/acpi_processor.c
> > > @@ -182,13 +182,15 @@ static void __init acpi_pcc_cpufreq_init(void) {}
> > >   #endif /* CONFIG_X86 */
> > >   /* Initialization */
> > > -#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
> > > -static int acpi_processor_hotadd_init(struct acpi_processor *pr)
> > > +static int acpi_processor_make_present(struct acpi_processor *pr)
> > >   {
> > >   	unsigned long long sta;
> > >   	acpi_status status;
> > >   	int ret;
> > > +	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
> > > +		return -ENODEV;
> > > +
> > >   	if (invalid_phys_cpuid(pr->phys_id))
> > >   		return -ENODEV;
> > > @@ -222,12 +224,6 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
> > >   	cpu_maps_update_done();
> > >   	return ret;
> > >   }
> > > -#else
> > > -static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
> > > -{
> > > -	return -ENODEV;
> > > -}
> > > -#endif /* CONFIG_ACPI_HOTPLUG_PRESENT_CPU */
> > >   static int acpi_processor_get_info(struct acpi_device *device)
> > >   {
> > > @@ -335,7 +331,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
> > >   	 *  because cpuid <-> apicid mapping is persistent now.
> > >   	 */
> > >   	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> > > -		int ret = acpi_processor_hotadd_init(pr);
> > > +		int ret = acpi_processor_make_present(pr);
> > >   		if (ret)
> > >   			return ret;
> > > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > > index 651dd43976a9..b7ab85857bb7 100644
> > > --- a/include/linux/acpi.h
> > > +++ b/include/linux/acpi.h
> > > @@ -316,12 +316,10 @@ static inline int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
> > >   }
> > >   #endif
> > > -#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
> > >   /* Arch dependent functions for cpu hotplug support */
> > >   int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
> > >   		 int *pcpu);
> > >   int acpi_unmap_cpu(int cpu);
> > 
> > I've lost track somewhat but I think the definitions of these are still under ifdefs
> > which is messy if nothing else and might cause build issues.
> > 
> 
> Yup, it's not safe to use 'if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))' in
> acpi_processor_make_present() until the ifdefs are removed for those two functions
> in individual architectures.

The same thing appears in a final patch that James seems to have added
to the repository:

ACPI: processor: Only call arch_unregister_cpu() if HOTPLUG_CPU is selected

in which acpi_processor_post_eject() has this change:

-       if (!device)
+       if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) || !device)

I'm wondering if that's caused by a previous patch making the weak
definition of arch_unregister_cpu() dependent on HOTPLUG_CPU, and
whether dropping that ifdef around the function would be better. I
think I already asked that question, but this final patch seems to be
the confirmation that we need to provide a definition of it.

I think the reason James did it like that is because unregister_cpu()
is dependent upon CONFIG_HOTPLUG_CPU, but it's probably better to do:

#ifdef CONFIG_HOTPLUG_CPU
void __weak arch_unregister_cpu(int num)
{
	unregister_cpu(&per_cpu(cpu_devices, num));
}
#else
void __weak arch_unregister_cpu(int num)
{
}
#endif

Agreed?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
