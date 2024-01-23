Return-Path: <linux-arch+bounces-1439-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF11838B61
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 11:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B594E1F27071
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 10:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00B65A0FC;
	Tue, 23 Jan 2024 10:08:28 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9E459B70;
	Tue, 23 Jan 2024 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706004508; cv=none; b=ddyGWwV1gA66SLrcGloWwMwQeDOuEATuRf4dleLc3Dc787bzaAsj2G1LN8pDHvF3HS+dc+gB3v4PCcTsIBeQjnQ/L2Su/sNnQZYtALboU9v5e48vMFZO9MQn9ANW/2jnnNJAIljGoELt/wu+oAgSseSnr0O9PE91fL3pugtnnWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706004508; c=relaxed/simple;
	bh=kxaW1bi7sX+liEnGkuJfF9UhGpIIxLkLIuBsEeev57w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LxkpexyNEOwdz1v7GOdXfEfLH3VA3mO6Y1cMmY/9ehQBG8DiWa3ackABLHxbYUczDA4hwYBA69n29zNHaAsrCPfZ6Ds0ESGMSHvaCPyUgkvqTbp8n7ovPoNBP8UCldrxj+JIoE4bPwfVWjqcF0euBTNDvneRRS8R/yBUlJ1oKaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TK2lV0mHxz67hqY;
	Tue, 23 Jan 2024 18:05:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DCC251404F5;
	Tue, 23 Jan 2024 18:08:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Jan
 2024 10:08:22 +0000
Date: Tue, 23 Jan 2024 10:08:21 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, <acpica-devel@lists.linuxfoundation.org>,
	<linux-csky@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-ia64@vger.kernel.org>, <linux-parisc@vger.kernel.org>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	<jianyong.wu@arm.com>, <justin.he@arm.com>, James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 14/21] irqchip/gic-v3: Don't return errors from
 gic_acpi_match_gicc()
Message-ID: <20240123100821.00000064@Huawei.com>
In-Reply-To: <ZZ2eGLwlkqZrh0In@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOgx-00Dvkv-Bb@rmk-PC.armlinux.org.uk>
	<20231215163301.0000183a@Huawei.com>
	<ZZ2eGLwlkqZrh0In@shell.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 9 Jan 2024 19:27:20 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Fri, Dec 15, 2023 at 04:33:01PM +0000, Jonathan Cameron wrote:
> > On Wed, 13 Dec 2023 12:50:23 +0000
> > Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:
> >   
> > > From: James Morse <james.morse@arm.com>
> > > 
> > > gic_acpi_match_gicc() is only called via gic_acpi_count_gicr_regions().
> > > It should only count the number of enabled redistributors, but it
> > > also tries to sanity check the GICC entry, currently returning an
> > > error if the Enabled bit is set, but the gicr_base_address is zero.
> > > 
> > > Adding support for the online-capable bit to the sanity check
> > > complicates it, for no benefit. The existing check implicitly
> > > depends on gic_acpi_count_gicr_regions() previous failing to find
> > > any GICR regions (as it is valid to have gicr_base_address of zero if
> > > the redistributors are described via a GICR entry).
> > > 
> > > Instead of complicating the check, remove it. Failures that happen
> > > at this point cause the irqchip not to register, meaning no irqs
> > > can be requested. The kernel grinds to a panic() pretty quickly.
> > > 
> > > Without the check, MADT tables that exhibit this problem are still
> > > caught by gic_populate_rdist(), which helpfully also prints what
> > > went wrong:
> > > | CPU4: mpidr 100 has no re-distributor!
> > > 
> > > Signed-off-by: James Morse <james.morse@arm.com>
> > > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> > >  drivers/irqchip/irq-gic-v3.c | 18 ++++++------------
> > >  1 file changed, 6 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > > index 98b0329b7154..ebecd4546830 100644
> > > --- a/drivers/irqchip/irq-gic-v3.c
> > > +++ b/drivers/irqchip/irq-gic-v3.c
> > > @@ -2420,21 +2420,15 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
> > >  
> > >  	/*
> > >  	 * If GICC is enabled and has valid gicr base address, then it means
> > > -	 * GICR base is presented via GICC
> > > +	 * GICR base is presented via GICC. The redistributor is only known to
> > > +	 * be accessible if the GICC is marked as enabled. If this bit is not
> > > +	 * set, we'd need to add the redistributor at runtime, which isn't
> > > +	 * supported.
> > >  	 */
> > > -	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address) {
> > > +	if (gicc->flags & ACPI_MADT_ENABLED && gicc->gicr_base_address)  
> > 
> > I was very vague in previous review.  I think the reasons you are switching
> > from acpi_gicc_is_useable(gicc) to the gicc->flags & ACPI_MADT_ENABLED
> > needs calling out as I'm fairly sure that this point in the series at least
> > acpi_gicc_is_usable is same as current upstream:
> > 
> > static inline bool acpi_gicc_is_usable(struct acpi_madt_generic_interrupt *gicc)
> > {
> > 	return gicc->flags & ACPI_MADT_ENABLED;
> > }  
> 
> In a previous patch adding acpi_gicc_is_usable() c54e52f84d7a ("arm64,
> irqchip/gic-v3, ACPI: Move MADT GICC enabled check into a helper") this
> was:
> 
> -       if ((gicc->flags & ACPI_MADT_ENABLED) && gicc->gicr_base_address) {
> +       if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address) {
> 
> so effectively this is undoing that particular change, which raises in
> my mind why the change was made in the first place if it's just going
> to be reverted in a later patch (because in a following patch,
> acpi_gicc_is_usable() has an additional condition added to it that
> isn't applicable here.) which effectively makes acpi_gicc_is_usable()
> return true if either ACPI_MADT_ENABLED _or_
> ACPI_MADT_GICC_ONLINE_CAPABLE (as it is now known) are set.

Ok. So maybe just calling out that we are about to change the meaning
of acpi_gicc_is_usable() so need to partly revert that earlier patch
to make use of it everywhere.

Or perhaps introduce
acpi_gicc_is_enabled() which is called by acpi_gicc_is_usable()
along with the new conditions when they are added though as you
say later, what does usable mean?

> 
> However, if ACPI_MADT_GICC_ONLINE_CAPABLE is set, does that actually
> mean that the GICC is usable? I'm not sure it does. ACPI v6.5 says that
> this bit indicates that the system supports enabling this processor
> later. Is the GICC of a currently disabled processor "usable"...

I agree, this is confusing.

acpi_gicc_may_be_usable()?

Or invert it in all places to give a cleaner meaning
!acpi_gicc_never_usable()

Bit of a pain to change this throughout again, but maybe necessary
to avoid confusion in future.

> 
> Clearly, the intention of this change is not to count this GICC entry
> if it is marked ACPI_MADT_GICC_ONLINE_CAPABLE, but I feel that isn't
> described in the commit message.

Agreed, though that only happens in the next patch so easier to describe
there or via a patch adding initially identical multiple helper functions
that then diverge in following patch?

Whilst a helper for this one location seems silly it would let us put
the two helpers next to each other where the distinction is obvious.

> 
> Moreover, I am getting the feeling that there are _two_ changes going
> on here - there's the change that's talked about in the commit message
> (the complex validation that seems unnecessary) and then there's the
> preparation for the change to acpi_gicc_is_usable() - which maybe
> should be in the following patch where it would be less confusing.

Agreed.

> 
> Would you agree?
> 
Yes, the move would help as then it's obvious why this needs to change
and that is separate from the naming question.

So in conclusion, I agree with everything you've called out on this one,
up to you to pick which solution cleans this up. I think options are.
1) Just move the change to the next patch where it's easier to describe.
   Leaves the odd 'usable' behind.
2) Rename the useable() to something else, maybe inverting logic as
   !never is easier than now_or_maybe_later.
3) Possibly add another helper for this new case which starts as matching
   the existing one, but diverges in a later patch (Should still not be
   in this patch which as you observer is doing something else and I think
   is actually a bug fix anyway, be it one that has never mattered for
   any shipping firmware).

Jonathan



