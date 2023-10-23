Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5297D3FAC
	for <lists+linux-arch@lfdr.de>; Mon, 23 Oct 2023 20:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjJWS6t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Oct 2023 14:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjJWS6t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Oct 2023 14:58:49 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C09BA;
        Mon, 23 Oct 2023 11:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7A0pd5ea/mWj9XmmTvRG6wtE18VpprIFdxTUBKRhNM0=; b=gtirJysCoPrK4qOy7mI9wMUvVz
        P33fMEnvCKyA74eRCvoEqjBQtXgT+ZfZaYwQdCj+oxzxDcBug/ZRYPHaMwfrVDsRg+SeYQ4ERiw3e
        maPZCTvvgkS2b147zcO7rUOaomZAQ0kPL5PTN6DNCaANEnB1lTAFW0ykLuziDuf+Dy8K+AE8O2k19
        PvdUnlkuD7/LMRkrQnfpX5g/p4kiD3Mj609pBiwd4YrNm3Zrc0ezR23xIBfNb1xScxybdK96le6aG
        0NeJcWgxNT5jq7CPNUlJH/PqpwF9p1KbFSX+6WabCSjxQo+VlGAEyfwtwC06L6xyK1qMiXK41UoIG
        5ILYltUQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45546)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qv08O-0003OY-1Z;
        Mon, 23 Oct 2023 19:58:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qv08N-00052v-CV; Mon, 23 Oct 2023 19:58:39 +0100
Date:   Mon, 23 Oct 2023 19:58:39 +0100
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
Subject: Re: [RFC PATCH v2 29/35] irqchip/gic-v3: Don't return errors from
 gic_acpi_match_gicc()
Message-ID: <ZTbCX0n2SrhUBESf@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-30-james.morse@arm.com>
 <20230914160223.0000782f@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914160223.0000782f@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 14, 2023 at 04:02:23PM +0100, Jonathan Cameron wrote:
> On Wed, 13 Sep 2023 16:38:17 +0000
> James Morse <james.morse@arm.com> wrote:
> 
> > gic_acpi_match_gicc() is only called via gic_acpi_count_gicr_regions().
> > It should only count the number of enabled redistributors, but it
> > also tries to sanity check the GICC entry, currently returning an
> > error if the Enabled bit is set, but the gicr_base_address is zero.
> > 
> > Adding support for the online-capable bit to the sanity check
> > complicates it, for no benefit. The existing check implicitly
> > depends on gic_acpi_count_gicr_regions() previous failing to find
> > any GICR regions (as it is valid to have gicr_base_address of zero if
> > the redistributors are described via a GICR entry).
> > 
> > Instead of complicating the check, remove it. Failures that happen
> > at this point cause the irqchip not to register, meaning no irqs
> > can be requested. The kernel grinds to a panic() pretty quickly.
> > 
> > Without the check, MADT tables that exhibit this problem are still
> > caught by gic_populate_rdist(), which helpfully also prints what
> > went wrong:
> > | CPU4: mpidr 100 has no re-distributor!
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >  drivers/irqchip/irq-gic-v3.c | 18 ++++++------------
> >  1 file changed, 6 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index 72d3cdebdad1..0f54811262eb 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -2415,21 +2415,15 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
> >  
> >  	/*
> >  	 * If GICC is enabled and has valid gicr base address, then it means
> > -	 * GICR base is presented via GICC
> > +	 * GICR base is presented via GICC. The redistributor is only known to
> > +	 * be accessible if the GICC is marked as enabled. If this bit is not
> > +	 * set, we'd need to add the redistributor at runtime, which isn't
> > +	 * supported.
> >  	 */
> > -	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address) {
> > +	if (gicc->flags & ACPI_MADT_ENABLED && gicc->gicr_base_address)
> 
> Going in circles...

It does seem that way. Are you suggesting something should change here?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
