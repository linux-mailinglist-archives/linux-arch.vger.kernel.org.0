Return-Path: <linux-arch+bounces-4425-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE22F8C67B7
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 15:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7671F22578
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124F613EFE4;
	Wed, 15 May 2024 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="vHqoF9xu"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2105.outbound.protection.outlook.com [40.92.23.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F361126F1B;
	Wed, 15 May 2024 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715780848; cv=fail; b=UY+plpBPR4banojh6oJ9wu6vLWSCdhxdeNGRhHB1AslUdNTgFIjKTeYZH7AjzyXr3WitGetByQKEvCNUcBi5GSZhnJqWvnMjhFqtYOH1MvtOtzXDU/+jWTIh/bqWz071n45EZpSeaf5/lt7gCU6Vuy/XoMdegO4vkS6O0E9JnBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715780848; c=relaxed/simple;
	bh=nYD1lzIbIsifOW0uPU6Ho3D2i+lNK1TBkfmtgVwNPRA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HC85PtGgITHE4/7L6wG5LIv4FFx+k1kFHe31g8xbZKGp7zgjTYtg4qExKKDTkwN5EMVQHgr0g9v0TyoYJCJJ153pW835pxhkUeDExCYjCnfPLGDvu2P3pcbNKI7W9zETgIjygJloCA2bLwCzQ34Y6L0v1c0vwYO1uV214jmH0Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=vHqoF9xu; arc=fail smtp.client-ip=40.92.23.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6PDe0CXxKBP4MCMSGuyG1ySA+vEiwhU/NIvNs7YATXlSukBYDhC8x+hWtdMy7hUqpdOrD5CaStcmCppxmZR9SJrtuUJGJsm7ye+Z6pz/KkOAYg1v97Y31HCKWsBKtd/BJvEE0tqB4qvNhj90C9q0ulAwqCgsbhwz9Yu9K7KiWL+f+YMQIITBOB9eLL0dsFhNiQ+WGoyc2cVevU0eWM03yFPnTMTCM7kZVVFgIomDd3stJeWxIFfJFH1+PsTpfGnwD7YMCikr7SdhUte8JTGus8jhWJWCw9ZXbm1z4H5SIrUgjoIjpd+bp0r6T4p9RX5ziRWYNv5kJuEBwIFKq7bSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Xv/WQjszcCraQQdSLeVH8aJUJs5+6BJ0/oTKpQubjo=;
 b=J9gq5Q1uhvderhPOzXVDGyeJ7i7Y/iek+NvGF4HRQ12ri4l/BD1KH6btSeSAYva7pjRxOvJ0menxmdY9OWQ6jskN/T7YsRyJTpr4aj31Lsu/a4bmM4nFfsn5sfK8w50/3iSh+5li7rWPoteB030atMlMXSDBtCe6ZJHpHG0s4fK5hnzv3Z/0tcSZxijZIjYo9aqOGUCboMFVeyaagxd4Xd1lPJ1FJuaL/FMiDEUKrMn2NqYweHYAkv2B+PinaTq5TIDdTgkTl6fAeS7Wq7ATQwiZHIMqGLmkaJF8mDS2MPp9lIVB4vh+T6rXBrOIcwfbbPHK41M2PqsaNBC+2XE19Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Xv/WQjszcCraQQdSLeVH8aJUJs5+6BJ0/oTKpQubjo=;
 b=vHqoF9xuojFzM8a8Iap0hh9AsGsvuTjUWIJ46yutedm1Zh51PUbbQemtP4mDzhmoKFo2u5E2pidC6E5uGdBtkPVL18U23pXEwaCdiswixrwArZCkaDN4Ue6OeEegw/cdwnzocEQUyjKMdFbHtDIJ+5JRG9GhJS9LQ3RBpp72V2THRxOwV3nf1nGtsWFjayI+QFkn77sw4Mx9Nm5XYpKAamUWye5nnCMXADO+kOg4l3SSeZimrUICDlH0lAp3E13g5Yjz0weqO6mWLLad5WgfShIX6Xi1VjMNnAigneMIyit/ncAvIvG5339KizMWEblI1PUaKawX0oMdo0apyxv1Tg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8465.namprd02.prod.outlook.com (2603:10b6:a03:3f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Wed, 15 May
 2024 13:47:21 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 13:47:21 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, "kw@linux.com"
	<kw@linux.com>, "kys@microsoft.com" <kys@microsoft.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "ssengar@microsoft.com" <ssengar@microsoft.com>, "sunilmut@microsoft.com"
	<sunilmut@microsoft.com>, "vdso@hexbites.dev" <vdso@hexbites.dev>
Subject: RE: [PATCH v2 6/6] drivers/pci/hyperv/arm64: vPCI MSI IRQ domain from
 DT
Thread-Topic: [PATCH v2 6/6] drivers/pci/hyperv/arm64: vPCI MSI IRQ domain
 from DT
Thread-Index: AQHaplCn/pK/ICTk8kqIqdHWmdC00bGXmjMg
Date: Wed, 15 May 2024 13:47:21 +0000
Message-ID:
 <SN6PR02MB4157EDCF4C5989F155EA8DA1D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240514224508.212318-1-romank@linux.microsoft.com>
 <20240514224508.212318-7-romank@linux.microsoft.com>
In-Reply-To: <20240514224508.212318-7-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [xBEIyCGHO3wKhLVyNG3Zz4SsCefiYz9P]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8465:EE_
x-ms-office365-filtering-correlation-id: 04f80d9c-111a-4ba0-02dd-08dc74e58b95
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|3412199016|440099019;
x-microsoft-antispam-message-info:
 mOFFKy6Ie1RNVh88EX6oXiTap7QuGlN3De5rPNdFcy+SoVEjiptnId7SavSmiWeaUlxBHA5UZ2q4C4o6529+Mxo3zd+yYBJ63YITlaU1RrTCA/s7JSBfMFsXQdCDWoL9+gIopGhFlUO860Ezp7w2GxBOV6FpVxfF0lsgHVib3ZB3kGhlimaS2yskwyFEICIRI1GHFDogUhcGcbI5yPl9iGFcUKNXL5GTKBajH7kUoCGxdqKE8MunpbdIj0Gl4uwb6IZp9f6ToYL2ZcGuLQy4QQYn9Dt6OJRmemozIPz+PmB80H7bEFEc5iyyH1HdOClXQHY1OA+Y4iP2Qa5VSXVHhaar17gOp8mkNjbwuq8+TSzkz3K9GMdVohxZyJo5jNxZ+OMRaY3szDt7Z4hOnZGICjgKtOkzBnRSCCHsdlcgkdHDhlmzqUz5T2DK4N3GgpZZfIh7ibBpT+W7GbpaGU841L1HlHhU+xCL7+vICmSZmAu8QrkFpjYmILZBxaks+i/8ROe+yVwx1n6Md0DicfOkla6WfDqQLM0lz9c97YcONbXjkjb6jMi6f5UZJLXqmWUa
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kGthYuHDhSi8YusQbYei8GbC6svyl9ipxprB37BIQmt8m/pyYGeHPRTdbE5K?=
 =?us-ascii?Q?x6BeyYPubh9nDEVUWQUgWDTUf0Oi9RQtG1DBRVQ0WC9ZnbIpw6Jex0K2BFgJ?=
 =?us-ascii?Q?4C6vNvbfrat2HUmEfF7U744pd7FXHEmlJ08aNfgbHgkhbvcRs5dEaIJi3nLs?=
 =?us-ascii?Q?rcO0KIO/MXOSAzBRQHKeeV2utSED4oWO0+J7UiehB5F2XR0Vys66gjVRRk9B?=
 =?us-ascii?Q?vMjPoIlo/F9LXSO7Ql+684E9b15wW0Oqmow0RYBoW6DkWZdVQf3SmkDGv5SH?=
 =?us-ascii?Q?binQPArU6N9c9CH+Ga6Zj4Wvt7akAC1I5OYrBYoFlUJW4scqFBWMEOP0L7kW?=
 =?us-ascii?Q?5EtHucoYBPAoczVwhmK46RwuDpSj4r9e27xlFOIyp0Q33EoUDp+BwXTUntzl?=
 =?us-ascii?Q?ISG+FbYxb9zmlyGDhhipTmSmY449R7ApbMJvh1/gOtkoR8SzQn6ov02wKXfZ?=
 =?us-ascii?Q?i6YMYjkBIcBbfgrx7vMDK2S3cA+9PBi1raXQx7o0d5qK1UHQDFKt4yWyyEqh?=
 =?us-ascii?Q?6ui8DQzvWZSM03MjPVhKzoTu5pVuNpamg9SukP3JdzW09GcF+xTGum9cuqR3?=
 =?us-ascii?Q?K0xf5k/Z7uXZHE15YzcBSHDDTYSVogDQHIlbjSIe+XRMOpCe0wsrHpn5LbRx?=
 =?us-ascii?Q?u4h6zeSbrs3ApF7VLDz5Yl3j+GYgZ3bEAuywRBx3wW24zrg+nj+ih+u7l7OO?=
 =?us-ascii?Q?0ufUVnLTM5Ltg6A4DA5Xl4UD1IAIEUclQyQK7MGOK9izPlMyBGj2cnQk5VWe?=
 =?us-ascii?Q?aftbbhT6uRfKOo9RM1blndp58zqCMqjV5pxKcZEONvLP5DEwa/OVZQ2bHxMf?=
 =?us-ascii?Q?NSBMPtDJZpL8NsMJs/Ps4D32Gs67u7/lr8cWjAdaf87NMkjSH7Czp5x+1dEO?=
 =?us-ascii?Q?M/bmL/FPjb5Ls2ikyMtZPtDu+3QpFybCo0NJZlSMvPh1X80NgxurLsPML0U/?=
 =?us-ascii?Q?heiYQCJ6ya1W6TItXnNUyUpCBjQBS39WE2wC9K+kTjFdL1J0PmGaxc7FrFMp?=
 =?us-ascii?Q?gic7S8nagiCaO4xjEoDh4nfU8pa13sHSI58Y/cmtXLbGwbDhS+D1CcuB36Ce?=
 =?us-ascii?Q?QDFS7/i7BgH9BAf58cmzLSXLQ12lExm6ziPCFHoV77cPR0Z/+zUNg63+CiDJ?=
 =?us-ascii?Q?RvL89K7MkSfru3BW2ENeo252En288PiOUDtxfUywvdUIjc8YWJhwFjmBvar8?=
 =?us-ascii?Q?607ybi6wc0AYT2mmaTqqNoX1YWOt31nDT/CmgBBdI0s6rlcGZ14OLIX6Z54?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f80d9c-111a-4ba0-02dd-08dc74e58b95
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 13:47:21.7509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8465

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, May 14, 2024 =
3:44 PM
>=20
> The hyperv-pci driver uses ACPI for MSI IRQ domain configuration
> on arm64 thereby it won't be able to do that in the VTL mode where
> only DeviceTree can be used.

That sentence seems a bit weird.  How about:

   The hyperv-pci driver uses ACPI for MSI IRQ domain configuration on arm6=
4.
   It won't be able to do that in the VTL mode where only DeviceTree can be=
 used.

>=20
> Update the hyperv-pci driver to discover interrupt configuration
> via DeviceTree.

"discover interrupt configuration"?   I think that's a cut-and-paste error
from the previous patch.

>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 13 ++++++++++---
>  include/linux/acpi.h                |  9 +++++++++
>  2 files changed, 19 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 1eaffff40b8d..ccc2b54206f4 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -906,9 +906,16 @@ static int hv_pci_irqchip_init(void)
>  	 * way to ensure that all the corresponding devices are also gone and
>  	 * no interrupts will be generated.
>  	 */
> -	hv_msi_gic_irq_domain =3D acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_N=
R,
> -							  fn, &hv_pci_domain_ops,
> -							  chip_data);
> +	if (acpi_disabled)
> +		hv_msi_gic_irq_domain =3D irq_domain_create_hierarchy(
> +			irq_find_matching_fwnode(fn, DOMAIN_BUS_ANY),
> +			0, HV_PCI_MSI_SPI_NR,
> +			fn, &hv_pci_domain_ops,
> +			chip_data);

Does the above really work?  It seems doubtful to me that irq_find_matching=
_fwnode()
always finds the parent domain that you want.  But I don't have a deep unde=
rstanding
of how this works or is supposed to work, so I don't know for sure.

If the above *does* actually work for all cases, then should it also work f=
or the ACPI
case?  Then you could avoid the messiness when acpi_irq_create_hierarchy() =
doesn't
exist.

> +	else
> +		hv_msi_gic_irq_domain =3D acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_=
NR,
> +			fn, &hv_pci_domain_ops,
> +			chip_data);
>=20
>  	if (!hv_msi_gic_irq_domain) {
>  		pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");

I'm wondering if these are the only changes needed to make vPCI work on
arm64 with DeviceTree.  The DMA coherence issue I mentioned in the previous=
 patch
definitely affects vPCI devices, so it needs to be fully understood and ver=
ified to work
correctly.

> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index b7165e52b3c6..498cbb2c40a1 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1077,6 +1077,15 @@ static inline bool acpi_sleep_state_supported(u8 s=
leep_state)
>  	return false;
>  }
>=20
> +static inline struct irq_domain *acpi_irq_create_hierarchy(unsigned int =
flags,
> +					     unsigned int size,
> +					     struct fwnode_handle *fwnode,
> +					     const struct irq_domain_ops *ops,
> +					     void *host_data)
> +{
> +	return NULL;
> +}
> +
>  #endif	/* !CONFIG_ACPI */
>=20
>  extern void arch_post_acpi_subsys_init(void);
> --
> 2.45.0
>=20


