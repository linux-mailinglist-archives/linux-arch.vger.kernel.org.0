Return-Path: <linux-arch+bounces-4023-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635AF8B3F3D
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 20:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADC8288EF6
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 18:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB7A16E89C;
	Fri, 26 Apr 2024 18:29:06 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E5168B07;
	Fri, 26 Apr 2024 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714156146; cv=none; b=XlaFalFo3VvxBNQAwqnbSPQkSQ3T0RuxwiikzXzQa4wkbOwCyMJa/M53mVn8APxYhnB4zRwCOskV+QyUHIOEPlfKuRbOqWC9AyMm1G423LiLXPkLIXslOK1LbkqoU2gWUIpwi3zMYgMi/EeaZltxhjHNRjwhsg3LUCjnFUkUnPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714156146; c=relaxed/simple;
	bh=NFuS+MSfq1noDcfC0XJN/a3ASNj0F2Kz43ByXP/YL4s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1ZOqZwU2yrggJTgKsu8OWarjPXHmejxha2YdZLDZuP8eEhpH4w7Pm1r5KmHgKDN91DXxIcgzZrRJxxXoJjWnbZUT67bqnqHoucpEkFyhJi8I8HiZHb5SwaYLATFWBsE+hzcH1ICVJ0goZaeWV2/plO6yZtk4PkZnrl17jFzZg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VR1QL36Mdz6JBGR;
	Sat, 27 Apr 2024 02:26:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 40C2E14011D;
	Sat, 27 Apr 2024 02:29:00 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Apr
 2024 19:28:59 +0100
Date: Fri, 26 Apr 2024 19:28:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Marc Zyngier <maz@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, "James Morse"
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<linuxarm@huawei.com>, <justin.he@arm.com>, <jianyong.wu@arm.com>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 11/16] irqchip/gic-v3: Add support for ACPI's
 disabled but 'online capable' CPUs
Message-ID: <20240426192858.000033d9@huawei.com>
In-Reply-To: <87il04t7j2.wl-maz@kernel.org>
References: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
 <20240426135126.12802-12-Jonathan.Cameron@huawei.com>
 <87il04t7j2.wl-maz@kernel.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> > @@ -2363,11 +2381,24 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_he=
aders *header,
> >  				(struct acpi_madt_generic_interrupt *)header;
> >  	u32 reg =3D readl_relaxed(acpi_data.dist_base + GICD_PIDR2) & GIC_PID=
R2_ARCH_MASK;
> >  	u32 size =3D reg =3D=3D GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64K * =
2;
> > +	int cpu =3D get_cpu_for_acpi_id(gicc->uid);
> >  	void __iomem *redist_base;
> > =20
> >  	if (!acpi_gicc_is_usable(gicc))
> >  		return 0;
> > =20
> > +	/*
> > +	 * Capable but disabled CPUs can be brought online later. What about
> > +	 * the redistributor? ACPI doesn't want to say!
> > +	 * Virtual hotplug systems can use the MADT's "always-on" GICR entrie=
s.
> > +	 * Otherwise, prevent such CPUs from being brought online.
> > +	 */
> > +	if (!(gicc->flags & ACPI_MADT_ENABLED)) { =20
>=20
> Now this makes the above acpi_gicc_is_usable() very odd. It checks for
> MADT_ENABLED *or* GICC_ONLINE_CAPABLE. But we definitely don't want to
> deal with the lack of MADT_ENABLED.
>=20
> So why don't we explicitly check for individual flags and get rid of
> acpi_gicc_is_usable(), as its new definition doesn't tell you anything
> useful?

That does seem to have evolved to something rather odd.

I messed around with various reorganizations of the boolean logic
and ended up with same 2 conditions as here as otherwise
the indent gets deep and the code becomes fiddlier to reason about
(see below for result)

>=20
> > +		return 0;
> > +	}
> > +
> >  	redist_base =3D ioremap(gicc->gicr_base_address, size);
> >  	if (!redist_base)
> >  		return -ENOMEM;
> > @@ -2413,9 +2444,12 @@ static int __init gic_acpi_match_gicc(union acpi=
_subtable_headers *header,
> > =20
> >  	/*
> >  	 * If GICC is enabled and has valid gicr base address, then it means
> > -	 * GICR base is presented via GICC
> > +	 * GICR base is presented via GICC. The redistributor is only known to
> > +	 * be accessible if the GICC is marked as enabled. If this bit is not
> > +	 * set, we'd need to add the redistributor at runtime, which isn't
> > +	 * supported.
> >  	 */
> > -	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address)
> > +	if (gicc->flags & ACPI_MADT_ENABLED && gicc->gicr_base_address)
> >  		acpi_data.enabled_rdists++;
> > =20
> >  	return 0;
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 9844a3f9c4e5..fcfb7bb6789e 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -239,7 +239,8 @@ void acpi_table_print_madt_entry (struct acpi_subta=
ble_header *madt);
> > =20
> >  static inline bool acpi_gicc_is_usable(struct acpi_madt_generic_interr=
upt *gicc)
> >  {
> > -	return gicc->flags & ACPI_MADT_ENABLED;
> > +	return gicc->flags & (ACPI_MADT_ENABLED |
> > +			      ACPI_MADT_GICC_ONLINE_CAPABLE);
> >  }
> > =20
> >  /* the following numa functions are architecture-dependent */ =20
>=20
> Thanks,

I'll not send a formal v9 until early next week, so here is the current sta=
te
if you have time to take another look before then.

=46rom a8a54cfbadccf1782b7cc04b93eb875dedbee7a9 Mon Sep 17 00:00:00 2001
From: James Morse <james.morse@arm.com>
Date: Thu, 18 Apr 2024 14:54:07 +0100
Subject: [PATCH] irqchip/gic-v3: Add support for ACPI's disabled but 'online
 capable' CPUs

To support virtual CPU hotplug, ACPI has added an 'online capable' bit
to the MADT GICC entries. This indicates a disabled CPU entry may not
be possible to online via PSCI until firmware has set enabled bit in
_STA.

This means that a "usable" GIC redistributor is one that is marked as
either enabled, or online capable. The meaning of the
acpi_gicc_is_usable() would become less clear than just checking the
pair of flags at call sites. As such, drop that helper function.
The test in gic_acpi_match_gicc() remains as testing just the
enabled bit so the count of enabled distributors is correct.

What about the redistributor in the GICC entry? ACPI doesn't want to say.
Assume the worst: When a redistributor is described in the GICC entry,
but the entry is marked as disabled at boot, assume the redistributor
is inaccessible.

The GICv3 driver doesn't support late online of redistributors, so this
means the corresponding CPU can't be brought online either.
Rather than modifying cpu masks that may already have been used,
register a new cpuhp callback to fail this case. This must run earlier
than the main gic_starting_cpu() so that this case can be rejected
before the section of cpuhp that runs on the CPU that is coming up as
that is not allowed to fail. This solution keeps the handling of this
broken firmware corner case local to the GIC driver. As precise ordering
of this callback doesn't need to be controlled as long as it is
in that initial prepare phase, use CPUHP_BP_PREPARE_DYN.

Systems that want CPU hotplug in a VM can ensure their redistributors
are always-on, and describe them that way with a GICR entry in the MADT.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v9: Thanks to Marc for quick follow up.
Fix up description and drop the acpi_gicc_is_usable() check given that
now doesn't actually mean they are usable.

Thanks to Marc for review and suggestions!
v8: Change the handling of broken rdists to fail cpuhp rather than
    modifying the cpu_present and cpu_possible masks.
    Updated commit text to reflect that.
    Added a sb tag for Marc given this is more or less what he put
    in his review comment.
---
 arch/arm64/kernel/smp.c       |  3 ++-
 drivers/acpi/processor_core.c |  3 ++-
 drivers/irqchip/irq-gic-v3.c  | 44 +++++++++++++++++++++++++++++++----
 include/linux/acpi.h          |  5 ----
 4 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 4ced34f62dab..afe835c1cbe2 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -523,7 +523,8 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_int=
errupt *processor)
 {
 	u64 hwid =3D processor->arm_mpidr;
=20
-	if (!acpi_gicc_is_usable(processor)) {
+	if (!(processor->flags &
+	      (ACPI_MADT_ENABLED | ACPI_MADT_GICC_ONLINE_CAPABLE))) {
 		pr_debug("skipping disabled CPU entry with 0x%llx MPIDR\n", hwid);
 		return;
 	}
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index b203cfe28550..b04b684f3190 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -90,7 +90,8 @@ static int map_gicc_mpidr(struct acpi_subtable_header *en=
try,
 	struct acpi_madt_generic_interrupt *gicc =3D
 	    container_of(entry, struct acpi_madt_generic_interrupt, header);
=20
-	if (!acpi_gicc_is_usable(gicc))
+	if (!(gicc->flags &
+	      (ACPI_MADT_ENABLED | ACPI_MADT_GICC_ONLINE_CAPABLE)))
 		return -ENODEV;
=20
 	/* device_declaration means Device object in DSDT, in the
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 10af15f93d4d..45272316d155 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -44,6 +44,8 @@
=20
 #define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
=20
+static struct cpumask broken_rdists __read_mostly;
+
 struct redist_region {
 	void __iomem		*redist_base;
 	phys_addr_t		phys_base;
@@ -1293,6 +1295,18 @@ static void gic_cpu_init(void)
 #define MPIDR_TO_SGI_RS(mpidr)	(MPIDR_RS(mpidr) << ICC_SGI1R_RS_SHIFT)
 #define MPIDR_TO_SGI_CLUSTER_ID(mpidr)	((mpidr) & ~0xFUL)
=20
+/*
+ * gic_starting_cpu() is called after the last point where cpuhp is allowed
+ * to fail. So pre check for problems earlier.
+ */
+static int gic_check_rdist(unsigned int cpu)
+{
+	if (cpumask_test_cpu(cpu, &broken_rdists))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int gic_starting_cpu(unsigned int cpu)
 {
 	gic_cpu_init();
@@ -1384,6 +1398,10 @@ static void __init gic_smp_init(void)
 	};
 	int base_sgi;
=20
+	cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
+				  "irqchip/arm/gicv3:checkrdist",
+				  gic_check_rdist, NULL);
+
 	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
 				  "irqchip/arm/gicv3:starting",
 				  gic_starting_cpu, NULL);
@@ -2363,11 +2381,25 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_header=
s *header,
 				(struct acpi_madt_generic_interrupt *)header;
 	u32 reg =3D readl_relaxed(acpi_data.dist_base + GICD_PIDR2) & GIC_PIDR2_A=
RCH_MASK;
 	u32 size =3D reg =3D=3D GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64K * 2;
+	int cpu =3D get_cpu_for_acpi_id(gicc->uid);
 	void __iomem *redist_base;
=20
-	if (!acpi_gicc_is_usable(gicc))
+	/* Neither enabled or online capable means it doesn't exist, skip it */
+	if (!(gicc->flags & (ACPI_MADT_ENABLED | ACPI_MADT_GICC_ONLINE_CAPABLE)))
 		return 0;
=20
+	/*
+	 * Capable but disabled CPUs can be brought online later. What about
+	 * the redistributor? ACPI doesn't want to say!
+	 * Virtual hotplug systems can use the MADT's "always-on" GICR entries.
+	 * Otherwise, prevent such CPUs from being brought online.
+	 */
+	if (!(gicc->flags & ACPI_MADT_ENABLED)) {
+		pr_warn("CPU %u's redistributor is inaccessible: this CPU can't be broug=
ht online\n", cpu);
+		cpumask_set_cpu(cpu, &broken_rdists);
+		return 0;
+	}
+
 	redist_base =3D ioremap(gicc->gicr_base_address, size);
 	if (!redist_base)
 		return -ENOMEM;
@@ -2413,9 +2445,12 @@ static int __init gic_acpi_match_gicc(union acpi_sub=
table_headers *header,
=20
 	/*
 	 * If GICC is enabled and has valid gicr base address, then it means
-	 * GICR base is presented via GICC
+	 * GICR base is presented via GICC. The redistributor is only known to
+	 * be accessible if the GICC is marked as enabled. If this bit is not
+	 * set, we'd need to add the redistributor at runtime, which isn't
+	 * supported.
 	 */
-	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address)
+	if (gicc->flags & ACPI_MADT_ENABLED && gicc->gicr_base_address)
 		acpi_data.enabled_rdists++;
=20
 	return 0;
@@ -2474,7 +2509,8 @@ static int __init gic_acpi_parse_virt_madt_gicc(union=
 acpi_subtable_headers *hea
 	int maint_irq_mode;
 	static int first_madt =3D true;
=20
-	if (!acpi_gicc_is_usable(gicc))
+	if (!(gicc->flags &
+	      (ACPI_MADT_ENABLED | ACPI_MADT_GICC_ONLINE_CAPABLE)))
 		return 0;
=20
 	maint_irq_mode =3D (gicc->flags & ACPI_MADT_VGIC_IRQ_MODE) ?
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9844a3f9c4e5..cf5d2a6950ec 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -237,11 +237,6 @@ acpi_table_parse_cedt(enum acpi_cedt_type id,
 int acpi_parse_mcfg (struct acpi_table_header *header);
 void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
=20
-static inline bool acpi_gicc_is_usable(struct acpi_madt_generic_interrupt =
*gicc)
-{
-	return gicc->flags & ACPI_MADT_ENABLED;
-}
-
 /* the following numa functions are architecture-dependent */
 void acpi_numa_slit_init (struct acpi_table_slit *slit);
=20
--=20
2.39.2



>=20
> 	M.
>=20


