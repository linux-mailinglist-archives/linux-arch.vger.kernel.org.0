Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12E67A09B1
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 17:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbjINPtd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 11:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241180AbjINPtc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 11:49:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0A799;
        Thu, 14 Sep 2023 08:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BFzL5nWshjNO+gGzPLGG7amQwxVIEQcjvrpBXODERXE=; b=wBPyigZMdRRZ3FXnl6RoYQXGjF
        VRP5jKgtu36nH1BjozS+X/R2uzgBOPgsRSEc2ShIVGwPkKbRxm4Bqjx66JdoJgTrR/CJNmFYV9LoF
        hoJE/323mTiQKR82F1Q4U1vkykPjmoHwFO11IW3ysV61Qcir1S3dy3qizF78dFjSPyiwBOpLF6/AG
        IFO0oFYtDAFvjeJcbduBErHv3c+M30DMs2gpuUtLxRemFVY54dGfSj1gsLtO2xf/+S7HlLF5HabEX
        Q7qZ7xylJbB7H42D4VnHzq9esWEv8QsAv2bDPYNqVCvhwxo4YMfzLcA8Dfvd3iWkeVxCiunF9+goK
        rTP4niwA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40270)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qgoap-0004Ye-1b;
        Thu, 14 Sep 2023 16:49:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qgoap-0004tx-4A; Thu, 14 Sep 2023 16:49:23 +0100
Date:   Thu, 14 Sep 2023 16:49:23 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: Re: [RFC PATCH v2 27/35] ACPICA: Add new MADT GICC flags fields
 [code first?]
Message-ID: <ZQMrg5he3OIsqKsD@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-28-james.morse@arm.com>
 <CAMj1kXHRAt7ecB9p_dm3MjDL5wZkAsVh30hMY2SV_XUe=bm6Vg@mail.gmail.com>
 <20230914155459.00002dba@Huawei.com>
 <CAMj1kXFquiLGCMow3iujHUU4GBZx2t9KfKy1R9iqjBFjY+acaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFquiLGCMow3iujHUU4GBZx2t9KfKy1R9iqjBFjY+acaA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 14, 2023 at 05:34:25PM +0200, Ard Biesheuvel wrote:
> On Thu, 14 Sept 2023 at 16:55, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Thu, 14 Sep 2023 09:57:44 +0200
> > Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > > Hello James,
> > >
> > > On Wed, 13 Sept 2023 at 18:41, James Morse <james.morse@arm.com> wrote:
> > > >
> > > > Add the new flag field to the MADT's GICC structure.
> > > >
> > > > 'Online Capable' indicates a disabled CPU can be enabled later.
> > > >
> > >
> > > Why do we need a bit for this? What would be the point of describing
> > > disabled CPUs that cannot be enabled (and are you are aware of
> > > firmware doing this?).
> >
> > Enabled being not set is common at some similar ACPI tables at least.
> >
> > This is available in most ACPI tables to allow firmware to use 'nearly'
> > static tables and just tweak the 'enabled' bit to say if the record should
> > be ignored or not. Also _STA not present which is for same trick.
> > If you are doing clever dynamic tables, then you can just not present
> > the entry.
> >
> > With that existing use case in mind, need another bit to say this
> > one might one day turn up.  Note this is copied from x86 though no
> > one seems to have implemented the kernel support for them yet.
> >
> > Note as per my other reply - this isn't a code first proposal. It's in the
> > spec already (via a code first proposal last year I think).
> >
> > >
> > > So why are we not able to assume that this new bit can always be treated as '1'?
> >
> > Given above, need the extra bit to size stuff to allow for the CPU showing up
> > late.
> >
> 
> So does this mean that on x86, the CPU object is instantiated only
> when the hardware level hotplug occurs? And before that, the object
> does not exist at all?
> 
> Because it seems to me that _STA, having both enabled and present
> bits, could already describe what we need here, and arguably, a CPU
> that is not both present and enabled should not be used by the OS.
> This would leave room for representing off-line CPUs as present but
> not enabled.
> 
> Apologies if I am missing something obvious here - the whole rationale
> behind this thing is rather confusing to me.

Note that the bit is in the ACPI spec:

https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gicc-cpu-interface-flags

The new bit has the same description as per the local-APIC equivalent:

https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#local-apic-flags

for a popular architecture that does have hot-pluggable physical CPUs ;)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
