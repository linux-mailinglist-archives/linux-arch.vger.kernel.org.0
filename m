Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAB87E0464
	for <lists+linux-arch@lfdr.de>; Fri,  3 Nov 2023 15:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjKCOJQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Nov 2023 10:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjKCOJP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Nov 2023 10:09:15 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179A41BD;
        Fri,  3 Nov 2023 07:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BFRj35KrFXvb8dOU4qKYIZykCYryvGHUV2gtHG32BRc=; b=N7IAMLo8B8O672s8M7tRvaa4vK
        DGmi9axnE8hQbJFc2awa2avk/xkDbNbAesNI8bOCGQMeNHTgd5uaSG/MxrOyUrOzM/bTjGbPz7BAf
        fKI5aHNokx2hjf9s8+LgyqcuezHU6GHfnHU59ulY6EIwPOE8Bsz1lEPZnyD2K35gp/S/D/QqVB8uR
        h/v8UICVLbZ2Q9/zCAc00Ts6T6a5STzH4Vo+4PZMK/THvyto6roi7Oy5ElRGk5C5yPz8dAKE4FjkI
        lxYEMem3w8reGnxHatoVy9sP+4VxDz/xb9X0ztnFkj6yGNL3ki1Qzrz4XU3My8Ih7lJ8XXzk47bBQ
        y63qvj1A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52238)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qyur8-0005as-2z;
        Fri, 03 Nov 2023 14:09:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qyur8-0008Si-5S; Fri, 03 Nov 2023 14:09:02 +0000
Date:   Fri, 3 Nov 2023 14:09:02 +0000
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
Subject: Re: [RFC PATCH v2 22/35] ACPI: Check _STA present bit before making
 CPUs not present
Message-ID: <ZUT+/rpSrMMH12mu@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-23-james.morse@arm.com>
 <20230914153110.00003e38@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914153110.00003e38@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 14, 2023 at 03:31:10PM +0100, Jonathan Cameron wrote:
> On Wed, 13 Sep 2023 16:38:10 +0000
> James Morse <james.morse@arm.com> wrote:
> > -#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
> >  /* Removal */
> > -static void acpi_processor_post_eject(struct acpi_device *device)
> > +static void acpi_processor_make_not_present(struct acpi_device *device)
> >  {
> >  	struct acpi_processor *pr;
> >  
> > -	if (!device || !acpi_driver_data(device))
> > +	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
> 
> Would it be possible to do all the ifdef to IS_ENABLED changes in a separate
> patch?  I haven't figure out if any of them have dependencies on the other
> changes, but they do create a bunch of noise I'd rather not see in the more
> complex corners of this.

I'm also wondering why we want to do this check here, rather than...

> > +static void acpi_processor_post_eject(struct acpi_device *device)
> > +{
> > +	struct acpi_processor *pr;
> > +	unsigned long long sta;
> > +	acpi_status status;

... here, because none of the code below has any effect if
acpi_processor_make_not_present() merely returns. So the below seems
like a waste of code space when CONFIG_ACPI_HOTPLUG_PRESENT_CPU is
disabled.

> > +
> > +	if (!device)
> > +		return;
> > +
> > +	pr = acpi_driver_data(device);
> > +	if (!pr || pr->id >= nr_cpu_ids || invalid_phys_cpuid(pr->phys_id))
> > +		return;
> > +
> > +	status = acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
> > +	if (ACPI_FAILURE(status))
> > +		return;
> > +
> > +	if (cpu_present(pr->id) && !(sta & ACPI_STA_DEVICE_PRESENT)) {
> > +		acpi_processor_make_not_present(device);
> > +		return;
> > +	}
> > +}

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
