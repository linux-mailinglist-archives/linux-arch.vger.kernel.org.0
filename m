Return-Path: <linux-arch+bounces-5961-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B969473AC
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 05:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C73B2126F
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 03:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62221448D9;
	Mon,  5 Aug 2024 03:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aSe6OWBO"
X-Original-To: linux-arch@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010007.outbound.protection.outlook.com [52.103.13.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB6D13CFB7;
	Mon,  5 Aug 2024 03:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722827004; cv=fail; b=R5QgueCrDJK0U5Bb3oe/4NUVS5/b/w+kFElJueVoZMgZXomLkKUOksX6Cbvsn1Hy34ar5M+MrKJiQjGHdhHpdtBlzHD54VFSMiCBKQVruoLBCLUuyKZitlvlGXrqKgsP/kKxwGBoomd93PvC3fXeykhA+MGzqc4IQfM2p3x203U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722827004; c=relaxed/simple;
	bh=Bg2KchTu9I+NMkgn7t2lFaMmzzA1cnv8Z7v9L+xw+WE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MxngjSM0alZ94cSJ7FKX83VZtPJ2KQEEitvaYBn0xnXBN3Sz4nHEvOMYDi6KVY6ryKaC/MQK8yWmBK1yYuJcxKU5gEYc9xTBEZD2viIteMxmzLwwYm6Jg6triM/h1KTnUvORx73uF2z8sM69C5qU4HCjSjUrJmJqG3ded53lEdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aSe6OWBO; arc=fail smtp.client-ip=52.103.13.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTVpXOB5QPV1GKSAnsbe2GG0A2d7B+T7qMLn6n/y2GosN5uvYGXjIMuxVmSSVrMFsU2r/Tmm9EHODf3i9+UIIwkXjwim25e52eYRd3zTdrXsR5GkeOIcE6rol7TMzY41LvhQLz8rXn2GCMJiN8/k+oN1DHZifezQ7Eci9a0FxpGcd6n9KcH2qEvVGXdUPdm87FYmLzg0AIZEiXz+MBAVGrkihdDI8JUE4IVhOjqWwJ+6IQ+wFKAc6pVnXjauyExNlLsoK9qAKAaPt1lLKh1W/HpVd8MlzDEBxkLlXiHfM05AGs2vj+FO0UsYqTo0VRzYI8NClQhWHilsDIYMUjkH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38Fru6njonOy+Wr18XTQqdX9S63F+IbRt7F2luOEVsY=;
 b=gx3FhI69H8D/hHezZyz1Bmk0HGU51L8fn3ikI9fpTFXsvAMLbkZqehcviEaRYjr2ls3LTaUBSfF9uLjbs3gbMy1dcxnkQHJhCCzeW+B+us8hPPdZJ+AgMNfJ1Dwe1aPSkUEOwo5ofsbUiITNf50OBM+pSs8D6ONOweMXOntBuJhksfFT32EGbHDrzmQrV8w46TSH4OsKL9unRjRpk5XmWYaOE/ORGIvrlulWUv5b13Xd+tLgWb53+cbQhewzFxqmohf6M2MJdA81xSBfAk/1asFA8CkBulw5GVLAGoXyvSmbAPOuaYIuOGiEzEOO9Hw1XQmoh80jItSBuQSPDf2afg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38Fru6njonOy+Wr18XTQqdX9S63F+IbRt7F2luOEVsY=;
 b=aSe6OWBOrQD4dHsbEARwZkaAptwgKPuYvKhszdLlB2PBlHwGsI6DmpPFzA0rfrb9ix9/Lydov10/w9WY02kLrtf02/XdoDPE+HE2VAwVSmbta7FHxpCrehgK9IxWbvdpVpC5P1rAGvscyAOryEYuhntowUgbezXUyVtVh+rbs1udvfjKLbidWhzdJ67iI9t7WAD9crFmr6JDcID3pjTgfR80z5vCkwhDPYzzKfLzR82GW6RILuDUZSBfceUK2Bgu6BuTBr9OBce0W/0oglMGYzt+476NZMpvDKwCpYdaZOuq6OOBDmSoAz9CfjwRAxiaJnHTkW6CZJ/xuQ3H+VIlPA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10738.namprd02.prod.outlook.com (2603:10b6:408:28b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 03:03:19 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7807.026; Mon, 5 Aug 2024
 03:03:19 +0000
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
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "ssengar@microsoft.com" <ssengar@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>, "vdso@hexbites.dev"
	<vdso@hexbites.dev>
Subject: RE: [PATCH v3 7/7] PCI: hv: Get vPCI MSI IRQ domain from DT
Thread-Topic: [PATCH v3 7/7] PCI: hv: Get vPCI MSI IRQ domain from DT
Thread-Index: AQHa36/CalEutWTYNUKLLP/VpfBp8rIX/jtg
Date: Mon, 5 Aug 2024 03:03:19 +0000
Message-ID:
 <SN6PR02MB4157D5A2DA10658D506EA1B1D4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-8-romank@linux.microsoft.com>
In-Reply-To: <20240726225910.1912537-8-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [ygEcJixfN/IXp4zyUODM/mOVqWtv9DBW]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10738:EE_
x-ms-office365-filtering-correlation-id: 94dec24c-251b-4118-46bb-08dcb4fb28eb
x-ms-exchange-slblob-mailprops:
 ZILSnhm0P3lDkJH5G1p2lgJ3jVl70zcdO/1Z1ycHr0XvJOm3UDpjb0D5pRAd8gJ2EPN2+aPwcYl+/mhg1LyzVluMau3RbP63di4J+OySA520JHnaXvvyGMdOZIs73GVfcQKP2BG/mpb4I1HQe68BUS2OTP42WoXdxHx6ypcZARgnoKAIgOnuotxe0dI+XxYQPHDjaFU1qXQfCES+mGWc8lDEfnYMcQbxgk1HfB2VRrehoSZUtEaOXs7t98s7cwiLPM/IfJT58701wJlLEVt0PrAzxQUNotS9ih7CZanYFAxdMBB895MvolLs2cLi8in9ljklwF/X3FYMIaF5ghPnykX9Tj6gv4FBmnMT3dhUYqwGtaPnANQIiyye8FBbwHs7DhdilMCnunNNT7SMbNVvbRXvfi/O5x/MMsYNibsTL7/XAxWPtc+zOdki77WWBd6qFAiszrW6HnqAgb1ugoNT6HePpHBjtJ2zQ1wQwwTu6zPS6MtvqF0ZABXCF7A6rPeusZn53lA0Rc9S1KeijAi1G5f4GlDmP6c+fPPf5n8fYwWNNM5PY3owhbcNbYIYQ4jsBl/vH8sJ/C+EaFr4vY78tswdqa5P85pzIOBJRgDX0gl2KfTuRZzbZVTqDrL7VtZFhKPUpoG0Zf9nEIWUfwg75rvsUZqW8xRy1Cg66YF5w49GRfBIOyD3vpRCQRm/AOB+cdeQ57uty3SysP4BbkIM4wO3DS4OPQnR83hcRiMLuti476rP1GHsWqk1U8jm1o42i+t/ijx0dDgTcbk3hXcE/EoYgiImimVd
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|461199028|3412199025|440099028|102099032|56899033;
x-microsoft-antispam-message-info:
 LSTr+xwXi2HDpv0Gdp0sDg4B6oZJeebVgT5NwD10DMKZCRjRA56utT7Clb+bCkZiWTODpWucegN6ku89tuAJsHHmq0E5C0Cx7OiEx2HEvw5Np8unshTeD8b1vW3Thu9wo9v3DSXq+vsRfDK0R99zA5RTnH65frWRlLM/RxDtL22stWLnkV998NM22Ndu5w3U2H8qPh+4oES8k1CuTtWfx/BpWrv0f+DYeG1yVh4FY9lY6Q+oUPDneWkfr5qG8EfxyPd1XFjfckHakYnc4UWC3wyLoIS75PjUl/t9pBfyHPt0OzWzRGO+WVbNqsHMyRnFe4+AIwvDpszgDwl6vdeEZrNi0CFztSMjt1fKR+BnYD8p5MiTyVKRyNO8LrfAgu0r1FQGLfH0yWXCrt1VFa6NARcZrjJjtoYiNoyDF6iWpp0sAMDm1PJXg9mF5/v0JPeRNHGTbMK/Bww73vIbG5O97FAmpznsg+A4JtbDfnTzAhLsHScByayg8371QG4C52ds6G2BeIvyF7qqCNx+XW59zFNU49Z/jh2koS9Xr4TwiLoUGEWZkJZ0d9CLTUZ4ODJB5V675ceBbWvyl6rQmlh2WCoQmgREagW0CBoM/2b5sxuabj+POcQVDTJH+nKACQ4yNs1i9S9jyCSWYOhPDvbHgw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?S9tok+Wf0LraUV8Z/t9u4tfv6lRegAhkTNRmo1cYvs2uby36jFg7ZtTgV2HA?=
 =?us-ascii?Q?I+Z3kJu1l5FcyfuEIAHDPG4gFOuaD80wieHGFvEkbTp849Jan0ai+wZKTLOc?=
 =?us-ascii?Q?oG2cgAdQWAQoK99+H7yJFQmVX+PULNZzREC9bbSNybKYK6mSodg/wQzTtvsU?=
 =?us-ascii?Q?noQQ3fBRzeNoK4CjMrWEkkDr9Qk3ReSNJv0l5UMD3AMXB16rMM+SU3HmRAkU?=
 =?us-ascii?Q?tWo/85TB98JDLEDpV76ni/wE92xk0EW/v6hfXEqoVnG1ZeFn3wAsvYuu/mzW?=
 =?us-ascii?Q?8Yz2tG+PUj02i77gDW7XmpHYV9WAEakxc09beOCFuVucMD/tDrgdD2E3prrz?=
 =?us-ascii?Q?MisJ3HIE7C5DON8k+sgaKSBPw/0JzIvP0ZKUbXI6JfsJBJrHimhtbc4FXXfJ?=
 =?us-ascii?Q?icH4C/F3z0/zOwIyXma4hFO5VPG55ikVRQyLsKhctgGu5nkD8Cuz3/Tox/fL?=
 =?us-ascii?Q?JmY6aZvmlLTm8UE2pySq/+3ucj0szqi4vIY/5Ii/p2/7E1SnZIr1qF1z46zd?=
 =?us-ascii?Q?H1jrHVKEyMeTi73WlvG/7T7laRRjjZjzm3n4Vj2VmRhL8OxpNPKVFf9v+8ZQ?=
 =?us-ascii?Q?j7g8CQ93ZVOKnZ1ACiAunbLQs8ByNjY0Z8+Tt4RZtQLEH3tAtfrrR0m6+aKC?=
 =?us-ascii?Q?Te5dETP9gvVJsUbW4NdOGnwyZhiNgTczfHtesKP2VrzhDoCFDtqZyUOp5QXo?=
 =?us-ascii?Q?qvNt/FeCb4xaBbOVB3OFW6M3Kzx4sj8c6oU9ocIb0sPLRonuvd4y+zqqR2yy?=
 =?us-ascii?Q?J7JUBTKWWJpvcFU0WTUiWaTIeIzzuyNzA8HrclW1G2Amn41esl6fYTlMI+oK?=
 =?us-ascii?Q?kwXYUkpEy6WK2od5YQ8zqT79a0Q9YQ5adFYrIaY1aKCZvEiH+jT8eNNQFSVx?=
 =?us-ascii?Q?/1M2CaJC3PElOF0m1WgUZahHHk5M47juq9VE5wSo/Noft49n+ucO64uL3jMm?=
 =?us-ascii?Q?VjoPG3R3WCGWAiSY6ivGUjiq5M7aZmyUBGVV9Pz1oMe5mO1QWA59pAzkUR6y?=
 =?us-ascii?Q?OBlaUFBvapZxrUDXSTu40ovOVAn6FHyq5pMj1iubeXyo0t98RTb82dVikyQQ?=
 =?us-ascii?Q?iogdSh42SGGYWV2qc9OsAk+qRw5WLmubxpp459U7QZk7sqnYdNAXIZTn1n/s?=
 =?us-ascii?Q?xKu3twmsBrUjKoEppNmEi53Uz9FeAqWxRdyaziSdmL8dwqzCP5MsWvO33Iu0?=
 =?us-ascii?Q?gXlA4isppJXshIjHooyGgBaoQN3jWuPKHsLAYp3E5mNFq/UBCuppoqd+itA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 94dec24c-251b-4118-46bb-08dcb4fb28eb
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 03:03:19.6015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10738

From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, July 26, 2024 =
3:59 PM
>=20
> The hyperv-pci driver uses ACPI for MSI IRQ domain configuration on
> arm64. It won't be able to do that in the VTL mode where only DeviceTree
> can be used.
>=20
> Update the hyperv-pci driver to get vPCI MSI IRQ domain in the DeviceTree
> case, too.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

Overall, this makes sense to me, and I think it works. As you noted in the =
cover
letter for the patch series, it's a bit messy.  But see my two comments bel=
ow.

> ---
>  drivers/hv/vmbus_drv.c              | 23 +++++++-----
>  drivers/pci/controller/pci-hyperv.c | 55 +++++++++++++++++++++++++++--
>  include/linux/hyperv.h              |  2 ++
>  3 files changed, 69 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 7eee7caff5f6..038bd9be64b7 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -45,7 +45,8 @@ struct vmbus_dynid {
>  	struct hv_vmbus_device_id id;
>  };
>=20
> -static struct device  *hv_dev;
> +/* VMBus Root Device */
> +static struct device  *vmbus_root_device;
>=20
>  static int hyperv_cpuhp_online;
>=20
> @@ -80,9 +81,15 @@ static struct resource *fb_mmio;
>  static struct resource *hyperv_mmio;
>  static DEFINE_MUTEX(hyperv_mmio_lock);
>=20
> +struct device *get_vmbus_root_device(void)
> +{
> +	return vmbus_root_device;
> +}
> +EXPORT_SYMBOL_GPL(get_vmbus_root_device);
> +
>  static int vmbus_exists(void)
>  {
> -	if (hv_dev =3D=3D NULL)
> +	if (vmbus_root_device =3D=3D NULL)
>  		return -ENODEV;
>=20
>  	return 0;
> @@ -861,7 +868,7 @@ static int vmbus_dma_configure(struct device *child_d=
evice)
>  	 * On x86/x64 coherence is assumed and these calls have no effect.
>  	 */
>  	hv_setup_dma_ops(child_device,
> -		device_get_dma_attr(hv_dev) =3D=3D DEV_DMA_COHERENT);
> +		device_get_dma_attr(vmbus_root_device) =3D=3D DEV_DMA_COHERENT);
>  	return 0;
>  }
>=20
> @@ -1892,7 +1899,7 @@ int vmbus_device_register(struct hv_device *child_d=
evice_obj)
>  		     &child_device_obj->channel->offermsg.offer.if_instance);
>=20
>  	child_device_obj->device.bus =3D &hv_bus;
> -	child_device_obj->device.parent =3D hv_dev;
> +	child_device_obj->device.parent =3D vmbus_root_device;
>  	child_device_obj->device.release =3D vmbus_device_release;
>=20
>  	child_device_obj->device.dma_parms =3D &child_device_obj->dma_parms;
> @@ -2253,7 +2260,7 @@ static int vmbus_acpi_add(struct platform_device *p=
dev)
>  	struct acpi_device *ancestor;
>  	struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
>=20
> -	hv_dev =3D &device->dev;
> +	vmbus_root_device =3D &device->dev;
>=20
>  	/*
>  	 * Older versions of Hyper-V for ARM64 fail to include the _CCA
> @@ -2342,7 +2349,7 @@ static int vmbus_device_add(struct platform_device =
*pdev)
>  	struct device_node *np =3D pdev->dev.of_node;
>  	int ret;
>=20
> -	hv_dev =3D &pdev->dev;
> +	vmbus_root_device =3D &pdev->dev;
>=20
>  	ret =3D of_range_parser_init(&parser, np);
>  	if (ret)
> @@ -2675,7 +2682,7 @@ static int __init hv_acpi_init(void)
>  	if (ret)
>  		return ret;
>=20
> -	if (!hv_dev) {
> +	if (!vmbus_root_device) {
>  		ret =3D -ENODEV;
>  		goto cleanup;
>  	}
> @@ -2706,7 +2713,7 @@ static int __init hv_acpi_init(void)
>=20
>  cleanup:
>  	platform_driver_unregister(&vmbus_platform_driver);
> -	hv_dev =3D NULL;
> +	vmbus_root_device =3D NULL;
>  	return ret;
>  }
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 5992280e8110..cdecefd1f9bd 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -50,6 +50,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/acpi.h>
>  #include <linux/sizes.h>
> +#include <linux/of_irq.h>
>  #include <asm/mshyperv.h>
>=20
>  /*
> @@ -887,6 +888,35 @@ static const struct irq_domain_ops hv_pci_domain_ops=
 =3D {
>  	.activate =3D hv_pci_vec_irq_domain_activate,
>  };
>=20
> +#ifdef CONFIG_OF
> +
> +static struct irq_domain *hv_pci_of_irq_domain_parent(void)
> +{
> +	struct device_node *parent;
> +	struct irq_domain *domain;
> +
> +	parent =3D of_irq_find_parent(to_platform_device(get_vmbus_root_device(=
))->dev.of_node);

I think the above can be simplified to:

	parent =3D of_irq_find_parent(get_vmbus_root_device()->of_node);

Converting the vmbus_root_device to the platform device, and then accessing
the "dev" field of the platform device puts you back where you started with
the vmbus_root_device.  See the code in vmbus_device_add() where the
vmbus_root_device is set to the dev field of the platform device.

> +	domain =3D NULL;
> +	if (parent) {
> +		domain =3D irq_find_host(parent);
> +		of_node_put(parent);
> +	}
> +
> +	/*
> +	 * `domain =3D=3D NULL` shouldn't happen.
> +	 *
> +	 * If somehow the code does end up in that state, treat this as a confi=
guration
> +	 * issue rather than a hard error, emit a warning, and let the code pro=
ceed.
> +	 * The NULL parent domain is an acceptable option for the `irq_domain_c=
reate_hierarchy`
> +	 * function called later.
> +	 */
> +	if (!domain)
> +		WARN_ONCE(1, "No interrupt-parent found, check the DeviceTree data.\n"=
);
> +	return domain;
> +}

Here's a thought, which may or may not be a good one:  Push some or all
the functionality of hv_pci_of_irq_domain_parent() into vmbus_device_add().
In the simplest case, have vmbus_device_add() store the of_node (which is
already the "np" local variable) in a global static variable, and provide
hv_get_vmbus_of_node() instead of get_vmbus_root_device().

The next step to consider would be to compute the parent in
vmbus_device_add(), and provide hv_get_vmbus_parent_of_node() instead
of hv_get_vmbus_of_node(). One difference is that vmbus_device_add()
runs for both x86 and arm64, while hv_pci_of_irq_domain_parent() is for
arm64 only.  The parent node may not exist on x86, but maybe that isn't
really a problem.

Pushing everything into vmbus_device_add() would entail doing the
irq_find_host(parent) as well, and the accessor function would just
return the IRQ domain. In that case, hv_pci_of_irq_domain_parent()
can go away. The domain might be NULL on x86, but that's OK
because the accessor function won't be called on x86.

Maybe there's a snag that prevents this idea from working well,
particularly on x86 where the domain will be NULL. But if it works,
it seems slightly less messy to me, though that is a judgment call.
I'll leave it to you to decide, and I'm OK either way. :-)

Michael

> +
> +#endif
> +
>  static int hv_pci_irqchip_init(void)
>  {
>  	static struct hv_pci_chip_data *chip_data;
> @@ -906,10 +936,29 @@ static int hv_pci_irqchip_init(void)
>  	 * IRQ domain once enabled, should not be removed since there is no
>  	 * way to ensure that all the corresponding devices are also gone and
>  	 * no interrupts will be generated.
> +	 *
> +	 * In the ACPI case, the parent IRQ domain is supplied by the ACPI
> +	 * subsystem, and it is the default GSI domain pointing to the GIC.
> +	 * Neither is available outside of the ACPI subsystem, cannot avoid
> +	 * the messy ifdef below.
> +	 * There is apparently no such default in the OF subsystem, and
> +	 * `hv_pci_of_irq_domain_parent` finds the parent IRQ domain that
> +	 * points to the GIC as well.
> +	 * None of these two cases reaches for the MSI parent domain.
>  	 */
> -	hv_msi_gic_irq_domain =3D acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_N=
R,
> -							  fn, &hv_pci_domain_ops,
> -							  chip_data);
> +#ifdef CONFIG_ACPI
> +	if (!acpi_disabled)
> +		hv_msi_gic_irq_domain =3D acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_=
NR,
> +			fn, &hv_pci_domain_ops,
> +			chip_data);
> +#endif
> +#if defined(CONFIG_OF)
> +	if (!hv_msi_gic_irq_domain)
> +		hv_msi_gic_irq_domain =3D irq_domain_create_hierarchy(
> +			hv_pci_of_irq_domain_parent(), 0, HV_PCI_MSI_SPI_NR,
> +			fn, &hv_pci_domain_ops,
> +			chip_data);
> +#endif
>=20
>  	if (!hv_msi_gic_irq_domain) {
>  		pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 5e39baa7f6cb..b4aa1f579a97 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1346,6 +1346,8 @@ static inline void *hv_get_drvdata(struct hv_device=
 *dev)
>  	return dev_get_drvdata(&dev->device);
>  }
>=20
> +struct device *get_vmbus_root_device(void);
> +
>  struct hv_ring_buffer_debug_info {
>  	u32 current_interrupt_mask;
>  	u32 current_read_index;
> --
> 2.34.1
>=20


