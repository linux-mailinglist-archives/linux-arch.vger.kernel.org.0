Return-Path: <linux-arch+bounces-12887-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3081EB0E305
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 19:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69AE97B596C
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 17:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D6928153D;
	Tue, 22 Jul 2025 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="flqAuhMH"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2089.outbound.protection.outlook.com [40.92.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7141281529;
	Tue, 22 Jul 2025 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206237; cv=fail; b=Xp4FPJRKFuPSA8PChFJMB4xIE6asqfJGLR5GJH384X8/fuC/1n/DIXCt3Xih22gbMfDir+ggPxrRwN7UJSDjD4AsuMUPv7hWYeTzwSOl+k1ZTHyenp7NQxTq1jostYl+JCSEyDb8UxF3JsNueROFsEyzGJXktXmuKb2R6dkBDJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206237; c=relaxed/simple;
	bh=/eWKUmjWSgc/mS01sJL9Ao2ib3lj/0dYbtTSrWiX3Lk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AMBY1Aw24e0rUxHp6yBIRxq9UyX148YVvA5Pb0ONsqMuyz4dYwhfhWNPPX/Lt7eaK3xwJUDhzzuRvi5UIx0bNNLgG2B1/KHhz/eUsm6V+jOomCexUYrj2Io/SlJoA//7LYGmOoJuMRfUJ50c9IWzuR/cuXle3eyOAG/3TP8MneY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=flqAuhMH; arc=fail smtp.client-ip=40.92.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyYBe63+wP1JbmyRF8FXutcJMYKp6N+11fMhT7bDLkK2k61IYRQCPnmjP7FeDDJF9RWX/YZVuEGfPZjKyjwdqWu9cYC+TmbeMxzpWDyDnbhIsZIBPE91CItwuVJRa8kvR7idKQx9ZT/mN4O3hqeSi6FhX66WlB2bW/JOHAKtxL7AAXwpBJLpPxGAHwCUbrD/eyyNW9hd7savhnOs3PbdykBn/pxo8GRo3vJE/QoTgmVfkcdqy/K3qqAczyoguDB+uf4oeu6vMUqTJJMQIsAXQeQ8QvZ7ahtc9ES/41FG0cOsnWPIjdJzCor0zvmGDnfQC8KGX6JxN71yxd9692RcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbsXlk+3xPumGswojMXFRbb3cyRZzKrguiAnCG23An8=;
 b=kYs5Hl/kgEnqqrsZbgbHq4D9txoomEfUWZhdnbSSX829j/cOdUaMzIFAUqi+7OuANwu4ISpfKQTY9aMMdiqJDAn3cSk3BuzDzfyfG4w6ML6YHz/XCUTkuOCMKB7JeuKuiUzY60bPyuD910o7HIDzmFzUua9S/aV//7/V0y9qUK0IGACvGO2VIzZ/jzI/bQpTw70RBIlbZhypFmbzu81amq905mvAe3qI0iUvq8PQbcY/QFOe+IZR0rAxEsNLFajUN8IxEn16IlGrv7WFqQC0n8BtFhujvTpm8k0T0g28BWFvHNMsdR033LYxhUq1hc2CjdTQ2yZXAA4l8T/bU3Scow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbsXlk+3xPumGswojMXFRbb3cyRZzKrguiAnCG23An8=;
 b=flqAuhMHuGIpNUCsTgoquK9bkrAIEqPNB5AjEUubNrWJEOjryKX9zM90ArqNNgObcDuhPkfpD446E9hhZuZjOq6hCR1u/K3ST1raigz/xmifhg+OkRSq0dx1KX6sXMDoCabBO+XcG2JxAlBoQiBTjdl4dfEMzwS493UpeWPyHJHfmNDvYldIOxGvQqnOpAKjHW7SflioBBc7Y+HZuE3v4bXLNu+4XRxP3tU5MAj9pzCTwx48hGlm1WQgOYuhzS0/Eyc4xuFmAojfID/WyZU+JIgnFrzywqPVl0qvuF3lhpXKftnlz3QKnvVXDwqug+pUzb8EnBKAkh8P76o1uL97RA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9201.namprd02.prod.outlook.com (2603:10b6:930:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 17:43:51 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:43:51 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de"
	<bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Tianyu.Lan@microsoft.com"
	<Tianyu.Lan@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v4 04/16] arch/x86: mshyperv: Trap on access
 for some synthetic MSRs
Thread-Topic: [PATCH hyperv-next v4 04/16] arch/x86: mshyperv: Trap on access
 for some synthetic MSRs
Thread-Index: AQHb9QzbgDZuQlmqvEmwgkWydxyKUbQ4Wruw
Date: Tue, 22 Jul 2025 17:43:51 +0000
Message-ID:
 <SN6PR02MB4157EF1BCE3B44C43B4A8354D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
 <20250714221545.5615-5-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-5-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9201:EE_
x-ms-office365-filtering-correlation-id: 28939c5b-736f-4eaf-d2f4-08ddc947520d
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|56899033|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JkXeRBb2EFi7zkgRzAtLGlFrlDqudiykJyRjAsoYuD5QKAJiVehkxY85ZGad?=
 =?us-ascii?Q?HrEC6zVTMwVWxKKrkRUWQnSDWo8mbW11onDuZBqpJvfUfkn67PfBKh3jluEj?=
 =?us-ascii?Q?reZCAPT9GE8tRoDKjAMJmj9FL3EyEKLgTJ6vGik6RRsxdE/meojrxxsc1TKq?=
 =?us-ascii?Q?L1fiPxJz/qd1gyDDQUCJ51E1Ji4H2kmMtGbAXVOYn67NULklhGaaY9eETvnu?=
 =?us-ascii?Q?aysVawC+JJ2ui5xOpNZ3VN/c3jx2nKtKXyzP3C6oE0XqV1ySzFrQUmN1ebsn?=
 =?us-ascii?Q?+oVxm9B1e9NrS+4UMX8U+BTSnRL2gtMdAiXFaAZS30RBGhuVHNcWDp3o/2+E?=
 =?us-ascii?Q?gCS7+umS/a3BaHy670b+6w3jVhpNfT8GXbeKHr7rkSOc17sl7ZXNolSLee/S?=
 =?us-ascii?Q?ExGE7EctUCsWDK5+TXJ1A+f6HHXvpa+i89Nrep6m9dS8s2jA3OjkPtnLfzbc?=
 =?us-ascii?Q?S/wNYHCyAINpHWGkj96BrcFHNIkGwWZ0XDCFhSMVEZnoAutjbf3aV1o6vMCY?=
 =?us-ascii?Q?s+6JnWsgdiuRxR/yRD/UtbWPESqyj6WaK3ZjIEXxl5JmGa0R5FXjE0j+MtLg?=
 =?us-ascii?Q?4SQrS6ps8ZMUhR5iQ92Cgcik9KoXSuVvdiawUUEVYKWTLppZqXB+PNOH4vaE?=
 =?us-ascii?Q?5S2ylBPh8m1P8GcXTGSUOFUPCGmv6PUetBmNfYV/Za7OWVn7viLdjmWFRGA7?=
 =?us-ascii?Q?Ch4XtgmYy1cXjXN1S7LPiw3UmuTtj2cZ9eNg6liaF3gNXwl4veUnhIKbF+FW?=
 =?us-ascii?Q?rPzOibwmE3iK+W5sc5NkWFxh9stMTZCoMoywdzIa0p2GyQhQLdxSMYxbjVPK?=
 =?us-ascii?Q?GVR0uX4oebNsQPAYaraJUKGX5FdLv04C5zRf2Yf/qc9we7irI6m/uoAvWSi5?=
 =?us-ascii?Q?gJJm5kh31OAcgzUfayZuTeY5DiDRUnO9dKL/cZyh2x8yJygmNpHUplWFgN1Z?=
 =?us-ascii?Q?uJAgDxq7/oXf05XL4F4C1LahpRK1L7sTyiSrfRsPRunZxp/iWYD2UWobHB2g?=
 =?us-ascii?Q?ibIP+P/ZhPb/qMD2uAR/L3oCPw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Sbunq/N7f9nHwqrtEE9X1NxRyN55EY5CJarWNWNrAkhV3b0KxwCjUsWSSkHE?=
 =?us-ascii?Q?lzU8PVzgP2d5athKnLLtRo0fz4kF54y1inUUbBj/8QwIdkDvWSNNEOWsPfM3?=
 =?us-ascii?Q?od52v8SwLLHAXATezdqWbaCbTr+Ba2kcVZ8VCGfnu+VCV2IQUCZsewSUkI7x?=
 =?us-ascii?Q?KtA313PJOigaSw8MuzqlFTmWFSsJkSVk3RxxpZ++ceS87BOMPa4SvXDzHyyI?=
 =?us-ascii?Q?Pb+RBT3l/xKvpMOfGSbLMx5G0IuQqPoy4ZYEvjdI+hxjivTR6QOI9mRSSsVX?=
 =?us-ascii?Q?LRmoR4E18L2IKs5NAQ/C1iXfb1pzulqtkctiIaIvC0fRt/xxCORvqIMbDdCb?=
 =?us-ascii?Q?Y0V1ZcL4wiYMHFnyOMR4k5ZwP6GGhNPZrpcnsFdhd/Gk0xY7TDLHG5VXma2w?=
 =?us-ascii?Q?tLQ+1uxSjf03TUG5AIhD0QGQMPvYWOuR7z80pAAvcxMr6HQqtDDDiYKhftPx?=
 =?us-ascii?Q?JyYbzRVUv9uTRE/AMRyUus06Q0j37ni9qe4wPYnQ1jU3s3u5jJUlK11tGiyd?=
 =?us-ascii?Q?ZSjToGZanZuo3ZsKUckSnNeo3ZqFAZWO5ZInOWugEQwJdO5QhsbsBsjBqgw9?=
 =?us-ascii?Q?btoj970W6YXpACKKdMOuberNOYFN4CbV5dQ7HuM47+X5z+8/0mQQ4iyMlFrO?=
 =?us-ascii?Q?KHHemYNm1IS4EZnOFehkiDf9R9jVS8Emqp1W0W81ubJXJWgmpc1YLHkGxueJ?=
 =?us-ascii?Q?PYyQvDoODePhpF9aUAjHczSNRB6ijGAKJcHZOgphu3Qcyxx676cfIMGAjD+K?=
 =?us-ascii?Q?VL3udB5xN85zNlSWnd4pftuSvej5N4RTHC5PNXLJFU9NNcxPrbVfH4T7qyJO?=
 =?us-ascii?Q?hDKjw7E03CU3tCDUpB1nmVrxp0pwITWnucZaxnaaO5ewgCKWwxJE3u35+8Z5?=
 =?us-ascii?Q?4YpT9zzuz2O2i4nrhLCx+1FoXD+ZMqYH1q89YnccoFnBOh8jPnHxVhVBelVb?=
 =?us-ascii?Q?JuPr3jMvqoajuAQgOL35VYVLfaphzxOMDYPUYvv4GUvyIbXRDTcHNFj4sw2E?=
 =?us-ascii?Q?GNPmLwJS+nTIwcGzgAo3cFrLc3JrpHZHr9mvJtbCyE+peZVYOnvomqMgBMYc?=
 =?us-ascii?Q?NDO8UqBLnlEGli41MvVEUiFQ0ceSJJmA+Msk7D/MXBE7YQcDWfDk4P8VPIMZ?=
 =?us-ascii?Q?nc2NzrOSYpAxz3iXhi9S76kBSAfsT7b2R/2uyZVWDliEuw0D2T7tvP16dHHI?=
 =?us-ascii?Q?LeG9V7sjrsvuZaKnMuVtkOsj7GH+oXBkWMwgETdACM7i+bHenepI5ZNLSmo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 28939c5b-736f-4eaf-d2f4-08ddc947520d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 17:43:51.2462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9201

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, July 14, 2025 =
3:16 PM
>=20
> hv_set_non_nested_msr() has special handling for SINT MSRs
> when a paravisor is present. In addition to updating the MSR on the
> host, the mirror MSR in the paravisor is updated, including with the
> proxy bit. But with Confidential VMBus, the proxy bit must not be
> used, so add a special case to skip it.
>=20
> Update the hv_set_non_nested_msr() function as well as
> vmbus_signal_eom() to trap on access for some synthetic MSRs.

This paragraph looks like a leftover from the previous version of
the commit message.  vmbus_signal_eom() is not touched in this
patch.

>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 07c60231d0d8..6c5a0a779c02 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -28,6 +28,7 @@
>  #include <asm/apic.h>
>  #include <asm/timer.h>
>  #include <asm/reboot.h>
> +#include <asm/msr.h>
>  #include <asm/nmi.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/msr.h>
> @@ -79,13 +80,21 @@ EXPORT_SYMBOL_GPL(hv_get_non_nested_msr);
>  void hv_set_non_nested_msr(unsigned int reg, u64 value)
>  {
>  	if (hv_is_synic_msr(reg) && ms_hyperv.paravisor_present) {
> +		/* The hypervisor will get the intercept. */
>  		hv_ivm_msr_write(reg, value);
>=20
> -		/* Write proxy bit via wrmsl instruction */
> -		if (hv_is_sint_msr(reg))
> -			wrmsrq(reg, value | 1 << 20);
> +		if (hv_is_sint_msr(reg)) {
> +			/*
> +			 * Write proxy bit in the case of non-confidential VMBus.
> +			 * Using wrmsrq instruction so the following goes to the paravisor.
> +			 */
> +			u32 proxy =3D vmbus_is_confidential() ? 0 : 1;

The kernel test robot is rightly complaining about vmbus_is_confidential()
being used here. vmbus_is_confidential() comes from vmbus_drv.c, which
is built as a module when CONFIG_HYPERV=3Dm. But this code is always
built-in, and built-in code can't directly refer to functions in a module.
Logically, the layering is wrong because vmbus_is_confidential() is
obviously a VMBus concept, while mshyperv.c only deals with Hyper-V
and knows nothing about VMBus. Your v3 patch series has the same
problem, but evidently the kernel test robot didn't notice the issue,
and I didn't notice it either my v3 review.

The best solution is probably to define a 32-bit "proxy bit" value here
in mshyperv.c. hv_set_non_nested_msr() would always OR in that
value before the call to native_wrmsrq() below. Wherever VMBus code
changes the value of is_confidential, it must also call an EXPORTed
function here in mshyperv.c to set or clear the value of "proxy bit".
Overall, it's a bit messy, but I don't see a better solution.

> +
> +			value |=3D (proxy << 20);
> +			native_wrmsrq(reg, value);
> +		}
>  	} else {
> -		wrmsrq(reg, value);
> +		native_wrmsrq(reg, value);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
> --
> 2.43.0


