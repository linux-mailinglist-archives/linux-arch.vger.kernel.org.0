Return-Path: <linux-arch+bounces-15784-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A1FD1AA18
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 18:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C58E5304D480
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 17:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4EE3557FF;
	Tue, 13 Jan 2026 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rEhrHDPf"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4C7350A25;
	Tue, 13 Jan 2026 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325384; cv=none; b=eg4hHd/53nH9CC1m+gSs7GOZ0mEVq4bExqdMjH4wqD/9kXhollDhceShyUMqX4qTspmB2eWMcG1pmwWill3hzG5+shq80CcY1VdGqDgzVa/kC8SD08x+Da3qDZRhZdDtcnkqQtU2WUKClsgqX2Ok+pCkRWdc60oSqxBbWJ3MDPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325384; c=relaxed/simple;
	bh=LhFzFpqZCkTlg+4EdN58/iujAtnb8yiY5L+KDY9IGBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtMHVspX3u/RzhpWfja1YUUj3tE9NQjf9NaIsYgXoz9EQC7zw2e/Dqd/jh8QNTOX5E0PhYenksmWr4E7wTkZT+AB5NoG8icO46rG8O/UFV9xJ8XpCAafzTU+iei3H+7KHpqr0RFUbt0LmhjB1i3TEhaZvfJwOBYobSJDHwQkG1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rEhrHDPf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 62AE620B716E;
	Tue, 13 Jan 2026 09:29:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 62AE620B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768325382;
	bh=C4y6lqCer5WCpiCbWDllL4m7vUvxhKlPrlTUCsJaCKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rEhrHDPf0ohClKYxtcWftDMzjclcsu19XUgvYouGFQ0IUPkhtcPJYct2FErUegenL
	 sG2a7uFooNbvJQuyVHs7iEL5saHdANhDSbqSj0Plu8dz6BeoM503I77um3Vn7p2WjD
	 IRV4xWtqXce+W7WPRG5BM1+dzopxxeMxzSo0xO1A=
Date: Tue, 13 Jan 2026 09:29:40 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Yu Zhang <zhangyu1@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
 <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
 <kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>, "joro@8bytes.org"
 <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "easwar.hariharan@linux.microsoft.com"
 <easwar.hariharan@linux.microsoft.com>, "nunodasneves@linux.microsoft.com"
 <nunodasneves@linux.microsoft.com>, "mrathor@linux.microsoft.com"
 <mrathor@linux.microsoft.com>, "peterz@infradead.org"
 <peterz@infradead.org>, "linux-arch@vger.kernel.org"
 <linux-arch@vger.kernel.org>
Subject: Re: [RFC v1 5/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260113092940.000050b8@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41571D67D866538138D06585D481A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
	<20251209051128.76913-6-zhangyu1@linux.microsoft.com>
	<SN6PR02MB41572D46CF6C1DE68974EAA1D485A@SN6PR02MB4157.namprd02.prod.outlook.com>
	<dws34g6znmam7eabwetg722b4wgf2wxufcqxqphhbqlryx23mb@we5utwanawe2>
	<SN6PR02MB41571D67D866538138D06585D481A@SN6PR02MB4157.namprd02.prod.outlook.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Mon, 12 Jan 2026 17:48:30 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Michael Kelley <mhklinux@outlook.com>
> To: Yu Zhang <zhangyu1@linux.microsoft.com>
> CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
> "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
> "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
> "linux-pci@vger.kernel.org"  <linux-pci@vger.kernel.org>,
> "kys@microsoft.com" <kys@microsoft.com>,  "haiyangz@microsoft.com"
> <haiyangz@microsoft.com>, "wei.liu@kernel.org"  <wei.liu@kernel.org>,
> "decui@microsoft.com" <decui@microsoft.com>,  "lpieralisi@kernel.org"
> <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
> <kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
> "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
> <bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>,
> "joro@8bytes.org"  <joro@8bytes.org>, "will@kernel.org"
> <will@kernel.org>,  "robin.murphy@arm.com" <robin.murphy@arm.com>,
> "easwar.hariharan@linux.microsoft.com"
> <easwar.hariharan@linux.microsoft.com>,
> "jacob.pan@linux.microsoft.com"  <jacob.pan@linux.microsoft.com>,
> "nunodasneves@linux.microsoft.com"
> <nunodasneves@linux.microsoft.com>, "mrathor@linux.microsoft.com"
> <mrathor@linux.microsoft.com>, "peterz@infradead.org"
> <peterz@infradead.org>,  "linux-arch@vger.kernel.org"
> <linux-arch@vger.kernel.org> Subject: RE: [RFC v1 5/5] iommu/hyperv:
> Add para-virtualized IOMMU support for  Hyper-V guest Date: Mon, 12
> Jan 2026 17:48:30 +0000
>=20
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, January
> 12, 2026 8:56 AM
> >=20
> > On Thu, Jan 08, 2026 at 06:48:59PM +0000, Michael Kelley wrote: =20
> > > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday,
> > > December 8, 2025 9:11 PM =20
> >=20
> > <snip>
> > Thank you so much, Michael, for the thorough review!
> >=20
> > I've snipped some comments I fully agree with and will address in
> > next version. Actually, I have to admit I agree with your remaining
> > comments below as well. :)
> >  =20
> > > > +struct hv_iommu_dev *hv_iommu_device;
> > > > +static struct hv_iommu_domain hv_identity_domain;
> > > > +static struct hv_iommu_domain hv_blocking_domain; =20
> > >
> > > Why is hv_iommu_device allocated dynamically while the two
> > > domains are allocated statically? Seems like the approach could
> > > be consistent, though maybe there's some reason I'm missing.
> > > =20
> >=20
> > On second thought, `hv_identity_domain` and `hv_blocking_domain`
> > should likely be allocated dynamically as well, consistent with
> > `hv_iommu_device`. =20
>=20
> I don't know if there's a strong rationale either way (static
> allocation vs. dynamic). If the long-term expectation is that there
> is never more than one PV IOMMU in a guest, then static would be OK.
> If future direction allows that there could be multiple PV IOMMUs in
> a guest, then doing dynamic from the start is justifiable (though the
> current PV IOMMU hypercalls seem to assume only one PV IOMMU). But
> either way, being consistent is desirable.
>=20
I believe we only need a single global static identity domain here
regardless how many vIOMMUs there may be. From the guest=E2=80=99s perspect=
ive,
the hvIOMMU only supports hardware=E2=80=91passthrough identity domains, wh=
ich
do not maintain any per=E2=80=91IOMMU state, i.e., there is no S1 IO page t=
able
based identity domain.

The expectation of physical IOMMU settings for guest identity
domain should be as follows:
- Intel vtd PASID entry PGTT =3D 010b (Second-stage Translation only)
- AMD DTE TV=3D1; GV=3D0

> >=20
> > <snip>
> >  =20
> > > > +static void hv_iommu_shutdown(void)
> > > > +{
> > > > +	iommu_device_sysfs_remove(&hv_iommu_device->iommu);
> > > > +
> > > > +	kfree(hv_iommu_device);
> > > > +}
> > > > +
> > > > +static struct syscore_ops hv_iommu_syscore_ops =3D {
> > > > +	.shutdown =3D hv_iommu_shutdown,
> > > > +}; =20
>  [...] =20
> >=20
> > For iommu_device_sysfs_remove(), I guess they are not necessary, and
> > I will need to do some homework to better understand the sysfs. :)
> > Originally, we wanted a shutdown routine to trigger some hypercall,
> > so that Hyper-V will disable the DMA translation, e.g., during the
> > VM reboot process. =20
>=20
> I would presume that if Hyper-V reboots the VM, Hyper-V automatically
> resets the PV IOMMU and prevents any further DMA operations. But
> consider kexec(), where a new kernel gets loaded without going through
> the hypervisor "reboot-this-VM" path. There have been problems in the
> past with kexec() where parts of Hyper-V state for the guest didn't
> get reset, and the PV IOMMU is likely something in that category. So
> there may indeed be a need to tell the hypervisor to reset everything
> related to the PV IOMMU. There are already functions to do Hyper-V
> cleanup: see vmbus_initiate_unload() and hyperv_cleanup(). These
> existing functions may be a better place to do PV IOMMU cleanup/reset
> if needed.
That would be my vote also.

