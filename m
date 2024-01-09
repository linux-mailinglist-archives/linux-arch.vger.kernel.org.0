Return-Path: <linux-arch+bounces-1319-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E0C828D5E
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 20:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969441C24898
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 19:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A038E3D387;
	Tue,  9 Jan 2024 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MU44z6ma"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937293D541;
	Tue,  9 Jan 2024 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=L5q9G4EH+GvNtL+Wb8XKMCOl8tTep7D40VZuegMyoOA=; b=MU44z6maYlvs7GL6v/GT26fHEs
	JywflQgaRGHzndkpt+lSurBg+ao2mQxU+/oGRSPRiPNkKcdcrWFvi+6rItnyaLc7f+FPAYo7I83W5
	d2s5ZugUXxshlJZGVGdrzrlIPCvqO/paJ1S3aBQEm5m9WcY0LPaxU5tR2kGwmEZzaY4deEjqCqu4u
	DArVZFITrAPbLhv9xLhr/UgPtS73DxSn0SkJEK4PDTSMy+YZBXGTEYK/DtGROgF9J5QMkTF/3HvTA
	umaXB+rcdQQpV3GgnIh74H38yrte9HF9bmmSsTVhQfTau7kl/lzJA4JTLkbtSQEyuHbASkLLoClqJ
	gOO/RXgQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56366)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rNHkv-0004Ud-0B;
	Tue, 09 Jan 2024 19:27:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rNHku-0004Wn-DT; Tue, 09 Jan 2024 19:27:20 +0000
Date: Tue, 9 Jan 2024 19:27:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 14/21] irqchip/gic-v3: Don't return errors from
 gic_acpi_match_gicc()
Message-ID: <ZZ2eGLwlkqZrh0In@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOgx-00Dvkv-Bb@rmk-PC.armlinux.org.uk>
 <20231215163301.0000183a@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215163301.0000183a@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 15, 2023 at 04:33:01PM +0000, Jonathan Cameron wrote:
> On Wed, 13 Dec 2023 12:50:23 +0000
> Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:
> 
> > From: James Morse <james.morse@arm.com>
> > 
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
> > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/irqchip/irq-gic-v3.c | 18 ++++++------------
> >  1 file changed, 6 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index 98b0329b7154..ebecd4546830 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -2420,21 +2420,15 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
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
> I was very vague in previous review.  I think the reasons you are switching
> from acpi_gicc_is_useable(gicc) to the gicc->flags & ACPI_MADT_ENABLED
> needs calling out as I'm fairly sure that this point in the series at least
> acpi_gicc_is_usable is same as current upstream:
> 
> static inline bool acpi_gicc_is_usable(struct acpi_madt_generic_interrupt *gicc)
> {
> 	return gicc->flags & ACPI_MADT_ENABLED;
> }

In a previous patch adding acpi_gicc_is_usable() c54e52f84d7a ("arm64,
irqchip/gic-v3, ACPI: Move MADT GICC enabled check into a helper") this
was:

-       if ((gicc->flags & ACPI_MADT_ENABLED) && gicc->gicr_base_address) {
+       if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address) {

so effectively this is undoing that particular change, which raises in
my mind why the change was made in the first place if it's just going
to be reverted in a later patch (because in a following patch,
acpi_gicc_is_usable() has an additional condition added to it that
isn't applicable here.) which effectively makes acpi_gicc_is_usable()
return true if either ACPI_MADT_ENABLED _or_
ACPI_MADT_GICC_ONLINE_CAPABLE (as it is now known) are set.

However, if ACPI_MADT_GICC_ONLINE_CAPABLE is set, does that actually
mean that the GICC is usable? I'm not sure it does. ACPI v6.5 says that
this bit indicates that the system supports enabling this processor
later. Is the GICC of a currently disabled processor "usable"...

Clearly, the intention of this change is not to count this GICC entry
if it is marked ACPI_MADT_GICC_ONLINE_CAPABLE, but I feel that isn't
described in the commit message.

Moreover, I am getting the feeling that there are _two_ changes going
on here - there's the change that's talked about in the commit message
(the complex validation that seems unnecessary) and then there's the
preparation for the change to acpi_gicc_is_usable() - which maybe
should be in the following patch where it would be less confusing.

Would you agree?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

