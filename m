Return-Path: <linux-arch+bounces-1084-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E064814CBD
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 17:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91291C23A8F
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 16:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96DD3A8F9;
	Fri, 15 Dec 2023 16:15:45 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E5B37163;
	Fri, 15 Dec 2023 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SsDmQ6g1zz6K8tP;
	Sat, 16 Dec 2023 00:13:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C2B1C140133;
	Sat, 16 Dec 2023 00:15:41 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Dec
 2023 16:15:41 +0000
Date: Fri, 15 Dec 2023 16:15:39 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <x86@kernel.org>,
	<acpica-devel@lists.linuxfoundation.org>, <linux-csky@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, <jianyong.wu@arm.com>,
	<justin.he@arm.com>, James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 01/21] ACPI: Only enumerate enabled (or
 functional) devices
Message-ID: <20231215161539.00000940@Huawei.com>
In-Reply-To: <ZXxxa+XZjPZtNfJ+@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOfs-00DvjY-HQ@rmk-PC.armlinux.org.uk>
	<20231214173241.0000260f@Huawei.com>
	<CAJZ5v0jymOtZ0y65K9wE8FJk+ZKwP+FoGm4AKHXcYVfQJL9MVw@mail.gmail.com>
	<ZXtFBYJEX2RrFrwj@shell.armlinux.org.uk>
	<CAJZ5v0h2Keyb-gFWFuPsKtwqjXvM2snyGpo6MMfFzaXKbfEpgw@mail.gmail.com>
	<CAJZ5v0h3WWtvrbxRpaGfq6c756k+L1SzZ1Gv3A14JxXHNcUMKA@mail.gmail.com>
	<ZXxxa+XZjPZtNfJ+@shell.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 15 Dec 2023 15:31:55 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Thu, Dec 14, 2023 at 07:37:10PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Dec 14, 2023 at 7:16=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote: =20
> > >
> > > On Thu, Dec 14, 2023 at 7:10=E2=80=AFPM Russell King (Oracle)
> > > <linux@armlinux.org.uk> wrote: =20
> > > > I guess we need something like:
> > > >
> > > >         if (device->status.present)
> > > >                 return device->device_type !=3D ACPI_BUS_TYPE_PROCE=
SSOR ||
> > > >                        device->status.enabled;
> > > >         else
> > > >                 return device->status.functional;
> > > >
> > > > so we only check device->status.enabled for processor-type devices?=
 =20
> > >
> > > Yes, something like this. =20
> >=20
> > However, that is not sufficient, because there are
> > ACPI_BUS_TYPE_DEVICE devices representing processors.
> >=20
> > I'm not sure about a clean way to do it ATM. =20
>=20
> Ok, how about:
>=20
> static bool acpi_dev_is_processor(const struct acpi_device *device)
> {
> 	struct acpi_hardware_id *hwid;
>=20
> 	if (device->device_type =3D=3D ACPI_BUS_TYPE_PROCESSOR)
> 		return true;
>=20
> 	if (device->device_type !=3D ACPI_BUS_TYPE_DEVICE)
> 		return false;
>=20
> 	list_for_each_entry(hwid, &device->pnp.ids, list)
> 		if (!strcmp(ACPI_PROCESSOR_OBJECT_HID, hwid->id) ||
> 		    !strcmp(ACPI_PROCESSOR_DEVICE_HID, hwid->id))
> 			return true;
>=20
> 	return false;
> }
>=20
> and then:
>=20
> 	if (device->status.present)
> 		return !acpi_dev_is_processor(device) || device->status.enabled;
> 	else
> 		return device->status.functional;
>=20
> ?
>=20
Changing it to CPU only for now makes sense to me and I think this code sni=
ppet should do the
job.  Nice and simple.

