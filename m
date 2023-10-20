Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D4F7D0E44
	for <lists+linux-arch@lfdr.de>; Fri, 20 Oct 2023 13:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377028AbjJTLQl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Oct 2023 07:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376927AbjJTLQk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Oct 2023 07:16:40 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759A6CA;
        Fri, 20 Oct 2023 04:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=H2KpfR5v8S4cDdfvm+k1Bez67vNujA5KyI4fx/Kz1ps=; b=YgzekWfuW0ZViZvyoL/HkzAklX
        5nNW5eMYQMXCcU1QdSAFp2AF9Q1KXT5sTeSAtHnZQ/m8i4B1L6Ep823thvglTw3UyUImbkgwmhyDu
        MWPWCuvm+LO5NStcvSOzrl1wG8pWuXD90e/dP8XNx6EIoA8ioI/CtepzCL35KbgwdacIxoz7mGI0F
        aAGqzFHJ+LL7bswWK1eApS9KxsLw/kGe4s0eICUD05jcwZeCgM6IuF5ubji454/lne12SDBrPNFFP
        ENRAcGT1B4VSpRgHHWxzJeLbxeXoi6OVeMDVOCfQ9ss1HnYNq3wNODcnMv5WKQEWbebV+eeFzrEiE
        Y3Xx91tQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50880)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qtnUT-0000Id-1M;
        Fri, 20 Oct 2023 12:16:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qtnUS-0001UG-19; Fri, 20 Oct 2023 12:16:28 +0100
Date:   Fri, 20 Oct 2023 12:16:27 +0100
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
Subject: Re: [RFC PATCH v2 05/35] drivers: base: Print a warning instead of
 panic() when register_cpu() fails
Message-ID: <ZTJhi6OVaTSEdvvf@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-6-james.morse@arm.com>
 <2c23ab17-7516-e310-8b79-b8c5fc02984a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c23ab17-7516-e310-8b79-b8c5fc02984a@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 18, 2023 at 01:33:37PM +1000, Gavin Shan wrote:
> 
> 
> On 9/14/23 02:37, James Morse wrote:
> > loongarch, mips, parisc, riscv and sh all print a warning if
> > register_cpu() returns an error. Architectures that use
> > GENERIC_CPU_DEVICES call panic() instead.
> > 
> > Errors in this path indicate something is wrong with the firmware
> > description of the platform, but the kernel is able to keep running.
> > 
> > Downgrade this to a warning to make it easier to debug this issue.
> > 
> > This will allow architectures that switching over to GENERIC_CPU_DEVICES
> > to drop their warning, but keep the existing behaviour.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >   drivers/base/cpu.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > index 579064fda97b..d31c936f0955 100644
> > --- a/drivers/base/cpu.c
> > +++ b/drivers/base/cpu.c
> > @@ -535,14 +535,15 @@ int __weak arch_register_cpu(int cpu)
> >   static void __init cpu_dev_register_generic(void)
> >   {
> > -	int i;
> > +	int i, ret;
> >   	if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
> >   		return;
> >   	for_each_present_cpu(i) {
> > -		if (arch_register_cpu(i))
> > -			panic("Failed to register CPU device");
> > +		ret = arch_register_cpu(i);
> > +		if (ret)
> > +			pr_warn("register_cpu %d failed (%d)\n", i, ret);
> >   	}
> >   }
> 
> The same warning message has been printed by arch/loongarch/kernel/topology.c::arch_register_cpu().
> In order to avoid the duplication, I think the warning message in arch/loongarch needs to be dropped?

No it doesn't, as far as Loongarch is concerned. Given where this change
occurs in the series, it is correct as far as this is concerned.

The reason is that this code path can only be reached when
CONFIG_GENERIC_CPU_DEVICES is set, which is something the arch has to
select. Loongarch doesn't select that until patch 9 in the series,
"LoongArch: Switch over to GENERIC_CPU_DEVICES", and that patch is
where the warning message in arch/loongarch is removed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
