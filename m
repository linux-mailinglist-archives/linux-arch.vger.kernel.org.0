Return-Path: <linux-arch+bounces-9163-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0599D9196
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 06:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4EE289FB4
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 05:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F4A16C850;
	Tue, 26 Nov 2024 05:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dCPI1BYS"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2107.outbound.protection.outlook.com [40.92.18.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA3D8831;
	Tue, 26 Nov 2024 05:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732600737; cv=fail; b=jbgXpa957cTl39QLcZg7shCPV19jN1RumNK26rkrsUlBGpoTAoOM67+lGjFjd2iW6YQfh0xgF4bishctssSyh04afdLEzn5kIjA07iGQlolkaJScs2p9QQNqXfMTyJoBV9ZrxXbQ18F6f1dRNsTuapxR8NZKFvZJI9ocyyabqOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732600737; c=relaxed/simple;
	bh=MQwNUOWdk7FXpf2HR/g3szUXH3P1CM+37pmultGwEXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IYvICZDBd03UA5lSNLGGES6erY23h0K82VJlMSurufTeAd0wVojbNjHPlsz1FdwN+3nLnka4UBsVth/zClxZ7ounqFQY+XHCaeEHHWswBuyf5L3ipu4lFiF5gej4rBJaYuilYjJhPcV95jOqWtqgh4B9ZOXM8/0nQmkUSabrThU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dCPI1BYS; arc=fail smtp.client-ip=40.92.18.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TiXNrPBR4I8lux8XEwPiVTZsaYKDVws1ErfPNxFRqVo9AllOLTGA+GDr+Q68coVqQYLl62xKXCJaJywpdXGJpIp7hWCqrbwpUq9drmOJbUukmOYBHdBVZLwPUF6Y2l4xPm8AZzIa1yuU//qcAZQdsJcJ6LofLbTho8SsNcNftgzuEthXd3ZNCAZmCPpufVUgCCjJXiJuSUmLRqO4aqLPDB7cBiJKOjTKSieaxt90gRQvg7TOxFX7U40mS+OumwTkpi0iNEM33yyRFryXWiRxRsg8Ll6QTHW/VPFIvvlW5ZfqYaV7qWTG20+d1VVVvPZi5dEm6zOPcspwpIFutVf3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQwNUOWdk7FXpf2HR/g3szUXH3P1CM+37pmultGwEXI=;
 b=ACN/qwSgrKSv7U5iPGq9lEj9pPW8xkOvISfKDnz/OoLwd0CACx09+9Ik7H+QqvVC7gnGc8OnuPv7N28iBRy3uZitHzSs4MZQBqwHL0Co4ZEvarp0y300dscToR6TSj+j2aEMhPXT1/oFUnGHSKywoqAPLqFz/YDUBOdKcs7gpYF5xBvsSgfr+J5NPq8OJsBdgfuTgd6EgoJpIrsG68HK64RavlCzI5dJ97q0hWeECcb/tRVcqkDhfFn3PCcN4iZpREUupWOYoC46pVcJct4R0HzBe88tDo6JTo4QRspTrExJslIRbJnvgmv1+hACREqSWeRh/xEFG9EkxDOAHxnMpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQwNUOWdk7FXpf2HR/g3szUXH3P1CM+37pmultGwEXI=;
 b=dCPI1BYStNYRzIUjWeS8wk9Eh6SFnbmSzHraORgdQw8inDhpeMAcUH+Xkg75wvyS43Qk8T0CV/Y4fzjj5SPrmSR5t2zcmsMT9tfKe8uNJdbb1YT7NjXVleeb34F2+56vNOBKgFp1nnUwspqol5gr+S4KofPK9L8V2dabR7xF3VJh+NtZD68moZOwVR6WzwEOSzM+Foikfv7kQVG5fsPhZkdI5TnnCEFFZkmwKolwZJ3cr/qVG5Xr9AwsVWUlekoQ47ZgCXbPRqSVGlGl8GFwvZrWcNtH/FA7Ip7kIsSa8ysiMB99aIUrxXYYRpAjiJpwTATMFLJuTTd4Z8N1uH1MKA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB10038.namprd02.prod.outlook.com (2603:10b6:510:2ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 05:58:51 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%7]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 05:58:51 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"luto@kernel.org" <luto@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mukeshrathor@microsoft.com" <mukeshrathor@microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "apais@linux.microsoft.com"
	<apais@linux.microsoft.com>, "eahariha@linux.microsoft.com"
	<eahariha@linux.microsoft.com>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH v3 4/5] hyperv: Switch from hyperv-tlfs.h to
 hyperv/hvhdk.h
Thread-Topic: [PATCH v3 4/5] hyperv: Switch from hyperv-tlfs.h to
 hyperv/hvhdk.h
Thread-Index: AQHbP5FAxvvP/hc/n06D/2+ZRIztHbLJESOA
Date: Tue, 26 Nov 2024 05:58:51 +0000
Message-ID:
 <SN6PR02MB4157EC0D6D671905A911AB94D42F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1732577084-2122-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1732577084-2122-5-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1732577084-2122-5-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB10038:EE_
x-ms-office365-filtering-correlation-id: ef1f3629-d765-4a41-cec8-08dd0ddf66f6
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|19110799003|8060799006|461199028|15080799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?x3v9E8uEl3jTXqsR5aFbpIUmjnNnTaqZJh6AzqN9p08rBGiGuEB9yFUEe0jN?=
 =?us-ascii?Q?UjtPSlFQxh4tggpFtSjmti6wU8xxSE1MCahwOsnsCUmMAfpqldwstozWe+9R?=
 =?us-ascii?Q?zgwrQiXqrGwStDM/ijFreS2VGqy9C4mSV8tNkLL38nQh9OAUSsR0NjSbiFdg?=
 =?us-ascii?Q?UQTX1xb981MelvN5ftbO/5pzGetPyK2qP6hznvVCiiYao9Q5t9qUJYkgq3gI?=
 =?us-ascii?Q?iejRlkCxp6WlJdhfG3C92OafZM1h7LH+2Rx1HrL9n6hDOhK94456EGZNDspz?=
 =?us-ascii?Q?QwhjqNt1iaRKRrGwJhxtcTjg5wk9vDFsJCNjVLYP7m1f71kBStXlqkrpxCog?=
 =?us-ascii?Q?BoouUxxT8+qDwx/tiF/HQGCKB86ha3NpmM/BkfugFrRx2IJ+7qVX7/azyF0G?=
 =?us-ascii?Q?CRg2E5rD5HY8zqn4+uoA2jsucbK/8Qb2xJW0OGffjB9O/Au+wd+G6GOnJLDb?=
 =?us-ascii?Q?fqa0V+pwjdzKj4QHIfdXhxzmSfx6D+uc5+iVXhNZmLikHqcIkl6LKLoHQKdC?=
 =?us-ascii?Q?BVFzmpUiBtqcCvELy1jqqTFoKROYTXGM/P3DJbooZ2/hTQaQdK4768JcJZML?=
 =?us-ascii?Q?ulHT5xBg9SQFMfBzy4WpLgLQewdNwz8O6oFQemY1tmIxoykX2EUVY8tvVljS?=
 =?us-ascii?Q?b1bTU9/XiEfzOHP0LZ4qFNIDPLiWRRoZM/q9daigGIL7VRivflwrVQZLj/p9?=
 =?us-ascii?Q?ByBdVoUZKG0fZ4edm6II9W6IpJ6Ul64xt6uM3o6OPUDP1e9+520f+5Z1cpln?=
 =?us-ascii?Q?PBBA+Km79qGr+aiB0uCdUJDn6OlmhQryM6Qe3YdTYCp9mNmQiS/UOjm5EFbb?=
 =?us-ascii?Q?9rnkkdNJuh+lVLshXRfPtT0dUacJ2Gm2p4oYEIWYMBvrMT1DTFiCjc9hdHNL?=
 =?us-ascii?Q?XZl6dAXjheAhIj/H9/QC3G5Rp6T0hyx7efx3h8XkQAjUKC/UVbrnXwWqvNKP?=
 =?us-ascii?Q?LmAkkJ3YldTe4KjP8Kv5Ia+3e/PlZRIU8grxyTbuCXAo+J13oU/rk5NCo+D6?=
 =?us-ascii?Q?832BRQXH4vyfe8gzZ7e/Y0uNEw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?52u1NuIVBkeeXtJBbKAtVwL1KNcz9PfSjC5SSAajyk2DT1tMNduQlU3JbR7G?=
 =?us-ascii?Q?Fz3pKYO1YeUZxuUTt0tKBhLg/HctCU3ByEBSrSwt2JTTBoQ7mzkDYX5+GmNb?=
 =?us-ascii?Q?UPGT/bi7DeeYH2qhi76F/4d5TkDpNQK4axWnCUnqYvKdEtv/842yhC+QMnLE?=
 =?us-ascii?Q?/rNhMIT2vtZ8OJWeS0RqESQqQYrFWQoAMRPguaEDFboEzp6e3DTlbFjQQ3dM?=
 =?us-ascii?Q?0qpcpwgp/6F768ZHwqB24oDRW3g/MWSZpSZlvm0wRg5fYtq5UaBYUjepv3nf?=
 =?us-ascii?Q?kO8Ula8ctM0hG6Nvpq5/P1z9QTm42DpZh5p3oudVhwg8A+GSBMTfeW8jyfE+?=
 =?us-ascii?Q?XH81coxdgjX6Vdidb/N8ogPYM2lwHhIdwoHI8tAZHXjE3iky21cs/6InSfAD?=
 =?us-ascii?Q?jxhREzs7FFC+uPOvn8NNOEuoe57IuYPwOsYQQh6Q9PQNavTMnc692758hZ7y?=
 =?us-ascii?Q?Ograz1mRrXW2Bc2ytWDrLQb7yrrWokgQCOG0Nsd0GYniht5iaUo1+NqqYdes?=
 =?us-ascii?Q?jDMakWaPtGGZRSjT4qCal632UQ83de7a8OfU5vgrnqZMGInHkAf3tAEzpxZR?=
 =?us-ascii?Q?q8Jb2nSZIWz64sDq0HySvtN2rVU9cs9DOV35P68hWknTAoIEFZGeZhfw8dDo?=
 =?us-ascii?Q?gAZZ+xFvifcuLo5ILKcX4nHFL/HneyrHO/2w6H+pfjs8QzJeW/ufmiTjh/dj?=
 =?us-ascii?Q?8VAfNEHd3R8cG4WQ4rs39HHiG7rqR98VXxNr8pwf95X4vZTadIeYTzgZKXQZ?=
 =?us-ascii?Q?alytuLYg+Gyr089eYf6hC4yeBGyAJTrcX9KcUioXmCLBIK/bfjsdB5zXsjXE?=
 =?us-ascii?Q?DGQwU5uCG7207aQiI2tU1aXFGgMtjjpIb3qqXE4ABFWTI13DDwidRMtM5YaT?=
 =?us-ascii?Q?XgADkK13VPbdtOG68Uvt3+ZlnJh/V0EdXnWLx4DS6POzFxkQD+xzX4KslCg2?=
 =?us-ascii?Q?mPlRugltAtQJql2cSI+aEfTIvn9z4iITHwps+O1iSvRNh4mxMeonRhG+9PP4?=
 =?us-ascii?Q?gccni/6AUPG1uIai53GZ4y8OIsC9YO9PjsVrNpWZywr7/IuTXwc4E/Okxb/+?=
 =?us-ascii?Q?Z+vhF6vQp0lmY3fWOQd2bWVnjOi2fesLuaZyj+hFff0yZreaf4EYwgSkvZad?=
 =?us-ascii?Q?ECec0dvtfngEJuIG6cxm+vmYWXiNC7ZHH+bfwugHD37H8hMtD5RWsSutavif?=
 =?us-ascii?Q?+5Npyg3Ao4N5PCtfktUFtWfhNh6vrhIc6+XNxmWFR7raONkFiZLj7KbBClA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1f3629-d765-4a41-cec8-08dd0ddf66f6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 05:58:51.2422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10038

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Monday, Novem=
ber 25, 2024 3:25 PM
>=20
> Switch to using hvhdk.h everywhere in the kernel. This header
> includes all the new Hyper-V headers in include/hyperv, which form a
> superset of the definitions found in hyperv-tlfs.h.
>=20
> This makes it easier to add new Hyper-V interfaces without being
> restricted to those in the TLFS doc (reflected in hyperv-tlfs.h).
>=20
> To be more consistent with the original Hyper-V code, the names of
> some definitions are changed slightly. Update those where needed.
>=20
> Update comments in mshyperv.h files to point to include/hyperv for
> adding new definitions.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

