Return-Path: <linux-arch+bounces-10930-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B56A67B47
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 18:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245FA19C655F
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 17:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC56F211A1E;
	Tue, 18 Mar 2025 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PLP/MBxs"
X-Original-To: linux-arch@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010002.outbound.protection.outlook.com [52.103.11.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A9320D4F4;
	Tue, 18 Mar 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319951; cv=fail; b=Dq3TqGG9vejBg6P6PhL3vjRaJ5I3+FMgfRVAwxE4HYE0F3MC7om61Y4DpMnQhZwX2cp5m7ncEkejQjvqYH4LExqzGPqjZk5Mx9gSSxdDoI9t/vsnmmx4em/48bQDr/IQ948GMtWNvqSCP9pCwI0tupXF7yc+UOFF1mv6kBtZAcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319951; c=relaxed/simple;
	bh=+Ua50Yx9cUt6GmAilXGA/cyA3Pu1Cyq18ZNMl4aLGXQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Feq41xPeirBMSEZssD7ALeYtPOA/sD3bw4tXCAS14i2l1WtD6ev5+SwJxkty20SRBxE/ZqPCUkP884zqwC6NoHlT9sysdl/GFIHBH8uCVlHhJB9dfRh3WFddSEa5DKxMuNVIewkhkchZlVZAMrSkz/YhPfT98+rKILliWiHW48E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PLP/MBxs; arc=fail smtp.client-ip=52.103.11.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSOom1CXszD02lykJtMupV03SxVP+gb0hnEPKM+GHZQfFOpG+Lojw+/uDsm5qj9lyvuES+J0zcxuO7VrmGPGhNppzHJhXQuHfAOykRocpfVrG5YAd0EhVZqomai/iounumM2Z0izYJicihGLFV9MrTWvpkzN8UxWOZilJMv846dARZm/rWFb2bIwwuJ6VWzcNY5SlAmbFZWg6TZKHxsux5kj9yHnwM9+nZbNxdmcP5E6jiNeDan8MEmkQbW6R8p6LMYonNRE1J/8FNJxCAdDQMo1Oo4sLUj+9ThIkrcxHfLT6zesg5Zc/By7I8X9qRTADnPG4C6JIcZbCeYtaL+CzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhwToxbE7ZgQn/o4lhk9jD+KvWLi1PpziAwUS7m12nw=;
 b=xI4mj4MbWn0ggurzOzcXEHQwL9L0roUFCwEY9zE6o1DIRkbmSbWBHK3eNcNx1AtlQ9BOQpt+gaz/QFZIdjjTMOo3Ze+I+HEp19qQ/YaW2xsZRpkB3lKgkId37DnjXnyVqnK/2B51eQyBcOOBzk4+WTeSjER3V+XmJZupBPBpSCk3uP/rBy7aUnyZnNI2uVtoxcSqZs7tNuxqPTgC8X6HInVuS2bAjG4tBdipn1SPQHVHfbTwBBqj3m40AuDPXiLkIXUosTMcQ5lGte4DuVyImvPqlBtoUoKBZX3B9d9n1JmQni310q9rLY2oHJAueW0rxWUin7JvY30fDZA+VJ0t2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhwToxbE7ZgQn/o4lhk9jD+KvWLi1PpziAwUS7m12nw=;
 b=PLP/MBxs9YVTZ4fxWLtvX0NlfL5atlLKVuWUBEbzFXnRF1lwAWeZqm8r+Q842le9jw/MIeCs9qOOHWFEH6oPud1RaoWSeJDfhSQ0CD6ld7zt41wFx813ALosmOOxoMDdG/ISKX/wTwCLZVAYaqcpeIsDUqyLsBsk5MEbNrbsCxQltuwB3O7VKKAMLGnClm2ZJimPQ5D/+5bAwNQ/RcdlArw4YyVX3CRfip/um0SRs0cOh7ZaFz+p1sV6WqVJYDoQ5+UcYUX5vn51qGLcsbwaUXfpa/2GEuOEhaOWGKAq03jDfSzq5jjgiuNazsIlK9u2kLkxxfQxEbFEB7Mv+CthDQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH2PR02MB6582.namprd02.prod.outlook.com (2603:10b6:610:78::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 17:45:46 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 17:45:46 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Wei Liu <wei.liu@kernel.org>
CC: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "decui@microsoft.com"
	<decui@microsoft.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "arnd@arndb.de"
	<arnd@arndb.de>, "jinankjain@linux.microsoft.com"
	<jinankjain@linux.microsoft.com>, "muminulrussell@gmail.com"
	<muminulrussell@gmail.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "apais@linux.microsoft.com"
	<apais@linux.microsoft.com>, "Tianyu.Lan@microsoft.com"
	<Tianyu.Lan@microsoft.com>, "stanislav.kinsburskiy@gmail.com"
	<stanislav.kinsburskiy@gmail.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
	"muislam@microsoft.com" <muislam@microsoft.com>,
	"anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
Thread-Topic: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
Thread-Index: AQHbiKNt140GtdgK20KtRyAXlJwH1rNxYTIggAfizgCAAAK9wA==
Date: Tue, 18 Mar 2025 17:45:46 +0000
Message-ID:
 <SN6PR02MB415725C0B70BBBE541D6F87DD4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-11-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157BE8AF5A1CDD39CF31124D4DF2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z9msXAClr-vGn3GR@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
In-Reply-To:
 <Z9msXAClr-vGn3GR@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH2PR02MB6582:EE_
x-ms-office365-filtering-correlation-id: 6e16ab9e-8e25-4089-36fb-08dd6644b691
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999004|8062599003|461199028|19110799003|8060799006|15080799006|10035399004|440099028|4302099013|3412199025|41001999003|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AL1Ib801r1fBeWD0LiNAvPNpQL8HdWiTD9o0ZjVNVgKxvhQ3pvCFIIwLGjUo?=
 =?us-ascii?Q?eDU/6fKKvbzi1HSjlJqhHnEKSQ2K3TqS8ZlpRg/4YyVmzi3kokXVDroHflcy?=
 =?us-ascii?Q?r6OH7Ud8+rYcNP/n+YcB0dA7FZgLAVNinVK0pxQ8uC8KndL64N30tHUi1dhf?=
 =?us-ascii?Q?CKvXdh+4ol93u+nBPsOvTICVB22w9amtgLxCkQ+6NWOFaEnlhdyUo0nVtPxN?=
 =?us-ascii?Q?LCiqZrga2DMPsjlx6bZzNBobEj2SwsEKMAx2z8uOI4tanY/TClcBD/IYdfAb?=
 =?us-ascii?Q?aY2j5A+3bQMuWPNTWhMOw3oNDfRvxrzRcguk53EL8NuafFyzJ+I3DMYWq4/7?=
 =?us-ascii?Q?5BRBPTGGX96ne/fVMqMI+vAnt/E6Bs8zPh3vHGqQfr6tAjo+hAjJ7vaCgGL3?=
 =?us-ascii?Q?5WGbdmz8eOWMIoV9+yyAWGFi2AoSgWLotKwgbGiIEfTEPSYMiR+UCCFpwEbc?=
 =?us-ascii?Q?Tzr05HY14pt5y5zIW1LhNQEDsSNbVvoYqgxxZ4iCkAm3HgDr5tKHhqOlnd4z?=
 =?us-ascii?Q?LK7tD29EsA6bwTHQQbMQ6WoVUosmLh8FDlQYbn8oNOyXsFDe1iYBqvjg4ftK?=
 =?us-ascii?Q?0B3kkWDQn4K/m22bMfR/nM7/RmhXGl/3vtpwFNJy36mZOBrno0IgB6CQurTn?=
 =?us-ascii?Q?VPnEOLXckHRGn17L56ahZpms5wQY6urjQVhn+HJRPrUdOGKVc8MoUM5LtXLE?=
 =?us-ascii?Q?MeltCaQe1ecxM20pjH7tluL8Ui1ekoiBPIfztSuq4MOhwuqcCGLTDQ8GkPn+?=
 =?us-ascii?Q?mnV36ICJklHMIUHegaTbVk2o+IbOAXfRwbCxwq8zm/HUJu+9EgJa1o93rUSy?=
 =?us-ascii?Q?inc8O/EFTNNfR8RQb017/i+eAM4EzpmYY5kq/ehrARj0DDn0CIOUY3fdC9jt?=
 =?us-ascii?Q?TM1dlpOCEZY6suhtFWHaCLM9Nk4mXqfkgG75KAOxQvNur0Z0yp0sJGle2lCM?=
 =?us-ascii?Q?cr2++aJzYIlkUuFn3Y+55IyBwsDJZhU/ZOFU64x3HOg/FdFGL2X2Gnp0r/wd?=
 =?us-ascii?Q?59/FP0n3hk9vYHidpJDp8ebmHR2z/egnvH0rvIlzWeU2FwsmrjZ1/8fDrRln?=
 =?us-ascii?Q?Y5BIMgZ5m1wth33L29uQeD1ecXbvN3bEQuhGcK7anIwa4MnPJWZH8oYpnKV+?=
 =?us-ascii?Q?vpi2Tev75n/GhkdqFz+ZQ7z9DipsdfZ6cV1Y8YDtp6jq1YAIsh57GTnAtX9d?=
 =?us-ascii?Q?yLs5CKt2pgnUHtZcOTOyCyzzugyffJcCXfEuFihTHALs5jhW1APxDJDd/+j5?=
 =?us-ascii?Q?n6uQbXdOT7vBwml5G3DF?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bBVsoQLnFy3r9Y+OweQh6TxfE7f5hsQ52E1lFnIDXpe1PuAOAfS+CbWI+r4T?=
 =?us-ascii?Q?iwKk6gZ+y8iai1pW9sVtWz3ynd0jQAycZ6iMFzNh08eAkUAZn4W+ZlaTKcsU?=
 =?us-ascii?Q?mcCfv0TyLdt+qvKHjiMtnQs55LzD6AU/v10oja0sAkRrJTTFyMZIL8cyxJBB?=
 =?us-ascii?Q?IOFJKpwweorAXkWNy4whmWN9QBY8HzQSzGXbxOY+leBQVPZ+2aBiDyqm8AoS?=
 =?us-ascii?Q?OBVhVpd4djr+/mEn9VHCTrfk9BZ3K03eg6ccHETB19VZ/cY6K6dXvZdhQqCW?=
 =?us-ascii?Q?0LlBKeYuHiFQMNp7c424JYOiije9HRjP0yBGYZ4OSg4GCB8v/ls9FMQdYB41?=
 =?us-ascii?Q?B+odzTBV2adej6yY9tvEMArFtx5bM7OFmwhb870cViF+z3Yfal1imxQAZPVB?=
 =?us-ascii?Q?Z4o/O1vNOEVjMWGXkBCXy0CFEi+3hQdDMn2JS2bhspefV819aSAQkLqN32k0?=
 =?us-ascii?Q?VH4wOqO0ozNWO3N5O/ZSmWxl4fnzqUUN6zUHfAibOqNJsPFOijji+aHsZxun?=
 =?us-ascii?Q?/mYzsbWMjNjLYlhKhCL4HFM2WfRgzUVQwxiTCSoEj1ES1eN7/C13G6on4sad?=
 =?us-ascii?Q?B78OkO5fuO6iB2sUUNG72Ybg3cD7Onl52kNnfigVDhX0kEgQt7YWCQjrT3VW?=
 =?us-ascii?Q?j2qkNagdr88tG8lyuQ0dIDU1BBojThemllrX+u7gWtdfd9J0p3TpLPnt4nu/?=
 =?us-ascii?Q?WpiEgnj41O5hzDwKCSP/dTT54t4rhs9j/IiQ1rwbo5WwsWJLpS7CSNpBB65u?=
 =?us-ascii?Q?0OqSrp/alyxtNj+o+ItNe9+TE39sOaxMc5exQCqFypKqEPTdnEf8KzDdQ1ep?=
 =?us-ascii?Q?eEv03vHxdQxuc3EIJuwy07RG8QrfnDFtr8/vNEWrwlvq2McrkRGN1/TYqt9Q?=
 =?us-ascii?Q?SPDPpB/TRfq0BeQONn0zcFaIupBnQFxhRCb+wIpapaD1zZ3OYqnITPPRkI5u?=
 =?us-ascii?Q?0RXW3VXxcTxyEIIUSbef+7tJgNAaDWxE0g/tYwOvp8tw0Ob2/sv2QQjltaYq?=
 =?us-ascii?Q?vSYi3Ie36qyHFggLSU0Pj5c8aKUWKSLAxQcbosCQToj8Z76+e1KXpcn5OixF?=
 =?us-ascii?Q?WyuhU4EP63zCxaSBpj9KKnBcxaigdLrIpDapl3M8twHVrsJoucA3mXYWz1wZ?=
 =?us-ascii?Q?Ap5mRZhJ628rttjAKTeOQHBm47oRqmfo5TV+NexGtKghWcJMgGVe2NjZQvFr?=
 =?us-ascii?Q?s7LoFhFIcg8iW0ue4x83sDAQW1kFkFpk/tr6ivKgwUIHJ9pjXkXPXKfZkQU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e16ab9e-8e25-4089-36fb-08dd6644b691
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 17:45:46.2721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6582

From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, March 18, 2025 10:25 AM
>=20
> On Mon, Mar 17, 2025 at 11:51:52PM +0000, Michael Kelley wrote:
> > From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday=
,
> February 26, 2025 3:08 PM
> [...]
> > > +static long
> > > +mshv_vp_ioctl_get_set_state(struct mshv_vp *vp,
> > > +			    struct mshv_get_set_vp_state __user *user_args,
> > > +			    bool is_set)
> > > +{
> > > +	struct mshv_get_set_vp_state args;
> > > +	long ret =3D 0;
> > > +	union hv_output_get_vp_state vp_state;
> > > +	u32 data_sz;
> > > +	struct hv_vp_state_data state_data =3D {};
> > > +
> > > +	if (copy_from_user(&args, user_args, sizeof(args)))
> > > +		return -EFAULT;
> > > +
> > > +	if (args.type >=3D MSHV_VP_STATE_COUNT || mshv_field_nonzero(args, =
rsvd) ||
> > > +	    !args.buf_sz || !PAGE_ALIGNED(args.buf_sz) ||
> > > +	    !PAGE_ALIGNED(args.buf_ptr))
> > > +		return -EINVAL;
> > > +
> > > +	if (!access_ok((void __user *)args.buf_ptr, args.buf_sz))
> > > +		return -EFAULT;
> > > +
> > > +	switch (args.type) {
> > > +	case MSHV_VP_STATE_LAPIC:
> > > +		state_data.type =3D HV_GET_SET_VP_STATE_LAPIC_STATE;
> > > +		data_sz =3D HV_HYP_PAGE_SIZE;
> > > +		break;
> > > +	case MSHV_VP_STATE_XSAVE:
> >
> > Just FYI, you can put a semicolon after the colon on the above line, wh=
ich
> > adds a null statement, and then the C compiler will accept the definiti=
on
> > of local variable data_sz_64 without needing the odd-looking braces.
> >
> > See https://stackoverflow.com/questions/92396/why-cant-variables-be-dec=
lared-in-a-switch-statement/19830820
> >
>=20
> This is a rarely seen pattern in the kernel, so I would prefer to keep
> the braces for clarity.
>=20
>  $ git grep -A5 -P 'case\s+\w+:;$'
>=20
> This shows a few places are using this pattern. But they are not
> declaring variables afterwards.
>=20

The braces just looked a little odd, particularly the way they are indented=
. Another
alternative is to move the variable to function scope, and avoid the issue =
altogether.
But I'm fine regardless of which approach you take, including keeping it li=
ke it is.

> > I learn something new every day! :-)
> >
>=20
> Yep, me too.
>=20
> Thanks for reviewing the code. Nuno will address the comments. I can fix
> them up.

FYI, I may submit a few more comments on the v6 version of the patches.
If there are changes you want to make based on my comments, I don't care
if you fix up the existing patches, or take them later as follow up patches=
.
And of course, you may choose to not make changes.

Michael

