Return-Path: <linux-arch+bounces-1372-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDAE82D814
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jan 2024 12:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAA528230E
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jan 2024 11:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F402C69F;
	Mon, 15 Jan 2024 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="If4u5sBw"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C43628DD1;
	Mon, 15 Jan 2024 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B8snCTk6m/S/IySGz0MUr7RGvF9ztHAy1wNv3isU/8A=; b=If4u5sBwSs6B37nBXDgiTbTUGN
	lDo8qxPOFMMLR9tdUyLFo9NhxhiAei6ak3C/e+2MynMriUcITyfJLZRCR7Ly9EwLVRyTpXgvcUB3V
	dwGg8WGAGKz7K/mPA9CiHN8UfYztvfbPPXOI0b0S+WLTsoNs8EV0O1R9IOUUphih0SDSGEtoXqkyc
	uB4sWSh8b+qMXC/2xsfM+PilLtcS9vlGpghLJvk9GXVZXiWY3hrSNwUQ65+M5e30MzDBuRHWV1QU/
	jXo3DcbVxcVsJSrnfHOPq2fWintWikuBFLjvQHJE8GaX60F8EKAbY9S+jDwY+ZggmQThypOLb+Xcb
	DtnjfwcQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60190)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rPKnW-0002Kh-1U;
	Mon, 15 Jan 2024 11:06:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rPKnV-0002tb-9h; Mon, 15 Jan 2024 11:06:29 +0000
Date: Mon, 15 Jan 2024 11:06:29 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Rafael J. Wysocki" <rafael@kernel.org>
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
Subject: Re: [PATCH RFC v3 03/21] ACPI: processor: Register CPUs that are
 online, but not described in the DSDT
Message-ID: <ZaURtUvWQyjYfiiO@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOg2-00Dvjk-RI@rmk-PC.armlinux.org.uk>
 <CAJZ5v0ju1JHgpjuFLHZVs4NZiARG6iBZN_wza6c2e0kDhZjK0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ju1JHgpjuFLHZVs4NZiARG6iBZN_wza6c2e0kDhZjK0w@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 18, 2023 at 09:22:03PM +0100, Rafael J. Wysocki wrote:
> On Wed, Dec 13, 2023 at 1:49 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> >
> > From: James Morse <james.morse@arm.com>
> >
> > ACPI has two descriptions of CPUs, one in the MADT/APIC table, the other
> > in the DSDT. Both are required. (ACPI 6.5's 8.4 "Declaring Processors"
> > says "Each processor in the system must be declared in the ACPI
> > namespace"). Having two descriptions allows firmware authors to get
> > this wrong.
> >
> > If CPUs are described in the MADT/APIC, they will be brought online
> > early during boot. Once the register_cpu() calls are moved to ACPI,
> > they will be based on the DSDT description of the CPUs. When CPUs are
> > missing from the DSDT description, they will end up online, but not
> > registered.
> >
> > Add a helper that runs after acpi_init() has completed to register
> > CPUs that are online, but weren't found in the DSDT. Any CPU that
> > is registered by this code triggers a firmware-bug warning and kernel
> > taint.
> >
> > Qemu TCG only describes the first CPU in the DSDT, unless cpu-hotplug
> > is configured.
> 
> So why is this a kernel problem?

So what are you proposing should be the behaviour here? What this
statement seems to be saying is that QEMU as it exists today only
describes the first CPU in DSDT.

As this patch series changes when arch_register_cpu() gets called (as
described in the paragraph above) we obviously need to preserve the
_existing_ behaviour to avoid causing regressions. So, if changing the
kernel causes user visible regressions (e.g. sysfs entries to
disappear) then it obviously _is_ a kernel problem that needs to be
solved.

We can't say "well fix QEMU then" without invoking the wrath of Linus.

> > Signed-off-by: James Morse <james.morse@arm.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/acpi/acpi_processor.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> > index 6a542e0ce396..0511f2bc10bc 100644
> > --- a/drivers/acpi/acpi_processor.c
> > +++ b/drivers/acpi/acpi_processor.c
> > @@ -791,6 +791,25 @@ void __init acpi_processor_init(void)
> >         acpi_pcc_cpufreq_init();
> >  }
> >
> > +static int __init acpi_processor_register_missing_cpus(void)
> > +{
> > +       int cpu;
> > +
> > +       if (acpi_disabled)
> > +               return 0;
> > +
> > +       for_each_online_cpu(cpu) {
> > +               if (!get_cpu_device(cpu)) {
> > +                       pr_err_once(FW_BUG "CPU %u has no ACPI namespace description!\n", cpu);
> > +                       add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
> > +                       arch_register_cpu(cpu);
> 
> Which part of this code is related to ACPI?

That's a good question, and I suspect it would be more suited to being
placed in drivers/base/cpu.c except for the problem that the error
message refers to ACPI.

As long as we keep the acpi_disabled test, I guess that's fine.
cpu_dev_register_generic() there already tests acpi_disabled.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

