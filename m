Return-Path: <linux-arch+bounces-12368-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0CEADF236
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7061BC170B
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55CD2F002A;
	Wed, 18 Jun 2025 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aNMtQUbo"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2016.outbound.protection.outlook.com [40.92.42.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985C428DB62;
	Wed, 18 Jun 2025 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263215; cv=fail; b=I8GNj+SbPQks6bAx3181+WMdyK8nIB8z0j/NXuSTEs4y0iEqoF69+mE//v73CvLWf5bCHzeHdeoSJeJMJ5IiE4Bgu5h5x1iWyADWXhMyp4QednnhsUMaNYo9PjEBEPOpLGTOmprwD4xSW5LW59XHlu4mq+Qg21HR61uEBJma4so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263215; c=relaxed/simple;
	bh=+snG7PtSQCokIFSSVuTmRNwags+Y8hgV7D6sGnqJDk0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d1tGkSTXYsBZEYuiXY60xgO93TMv/ObhZcJdplAeImjPu5/+rO1p0Ff+CMGHab7zTkw5E7vyJXc3uGRbevivXOuxNx9J64AZlqJOLV5gbePB6ySyVPyJjcMNQIxJUEQdlOYY2/kA45poU1/O5lHg60AQSEEsC9W7HJQBm4WfBVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aNMtQUbo; arc=fail smtp.client-ip=40.92.42.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNyOKBaYk6R0Gq+RlTME2RJnIM2hJqO3hN34Ctw4F9Q0U1TbyFn+ScZ2f1mUMmllqmPHFfQyEfvl8cIMnaIADSM/N8gQ5k8M2qsr7PyEhFZBje++gC5hfVzeUIiz88+qgLM6qw2p+2Wst6ldCVjOgqcUvqivIHl0bML6h5O2CK03TIYb4s3g7hYoIXrBJfFj/4/jnqu/r3eD19mNphIqd3yOpcTF3WNvO9rSBMqDdKPk5WpfVwCpABMs3WvDLUI6/DpeNI0wCB9O5ZfwvGm36ajvgsVnC2CpzHnPCO7Wu9xABM3CO2dykcO/gA/e/RikFBC3UkGdaRlZpsZnMI3glg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vcltbn6ij4sAqMgL7g77UF9M9oCJla/Tbn8YVUR3mv4=;
 b=TsX6naDjm/owy3fZl/13qSGjvl1hEi3NaiHDwuZssRfSh57Oo9PRJ2QQRHkj0z33VtuHL1QK11+5ajEeN2dET0V4oSe5b/89L+8YPbbU5p4yHPftLOwg3Hyrcsc27HsKcdAN/fObw2wUSzwCft4kqCxZuCo6V8ivQO5PCHi4CCVIXR676Wji+8mlV1cQF+VVccqqSwwfPFwg7ZPa5sXbjO7GO/HzKJdm6n4AfK9R3s77qGBTafzlVp36RUFqoJN6E/gUyt0JNwVmqsZvHHMrSfn7P3P1gcJKzedJHiTFO26VrteC56VeowyEmsxeGRk+Q4Bfm9caW/xLj2dio7q7MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vcltbn6ij4sAqMgL7g77UF9M9oCJla/Tbn8YVUR3mv4=;
 b=aNMtQUbolGGE7tyinx7lHYr+5aQmPPkH11QVuEgU3KxTSCD7UKBeFZIRGMcgYvOEsYbfoDUSXkGVeYRKR886oxNTkPOnuyQgLrP630FLpeTNOL6bSMhdiTI80k3FGaGaiXN8mZLWs1+wgyiY6lNR+aVIAF0g6OngfuUjG16jA/LqPTY3OF2Rp0IY70D2BvA6Vl28ob1l/CkCo5AAUM36OcWdxsTJHu7fOPYHUdqbD/Kv9vHVZAXtfNurl9+M1rzw17Cdscf1D27sUyUIssIQWzRzX2hrpKL0ZAyeqTngK4qYcasspCeGkpIxwJVv4d8I7uxAntcgfuWnICpH3wPo0w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL3PR02MB7857.namprd02.prod.outlook.com (2603:10b6:208:33c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.18; Wed, 18 Jun
 2025 16:13:30 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 16:13:30 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de"
	<bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v3 00/15] Confidential VMBus
Thread-Topic: [PATCH hyperv-next v3 00/15] Confidential VMBus
Thread-Index: AQHb1Om6QJi/kFn19Eq8jGDBqF0S/LQJKkiw
Date: Wed, 18 Jun 2025 16:13:29 +0000
Message-ID:
 <SN6PR02MB4157DB33D3D36E2F3CFFC5B1D472A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
In-Reply-To: <20250604004341.7194-1-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL3PR02MB7857:EE_
x-ms-office365-filtering-correlation-id: 11f39407-ea69-435b-6c07-08ddae8310bc
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799006|15080799009|41001999006|8062599006|8060799009|440099028|51005399003|3412199025|40105399003|4302099013|10035399007|102099032|56899033|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FwOGkS3c19cbmS+15mxy52VYIhhtou4hTlqrfj4KzpedbE9jG8PjgpOOH8BK?=
 =?us-ascii?Q?2h2p3PFuhXJNM9jfTTCJJf3EE3jRUmJlBUhAGZAkicMS13X+iHH3kL07BmSu?=
 =?us-ascii?Q?6GG0JVD+45/WTO8K1LLe/b2eMic/Bb/zmwAXBW2zs0r6FEkP3xBqFVPk+wfV?=
 =?us-ascii?Q?C3aT9V7JwEUdTZJ9BqgcNAAo3Lb00VXRB8X+yGYR8rxHjCo4vQPrv4Yt68EQ?=
 =?us-ascii?Q?KEPqbvz8JdLPHBpO4Y4GDGOXf3fJKO3g8lOo3bW6YCNudzqHdycBZfvsyRG4?=
 =?us-ascii?Q?lTJPq878h7mbnFKlgj1dfY7WAleZ78YSgLGPg5QE3diRsdbUZvFyshWBiyzd?=
 =?us-ascii?Q?hKCQsB+mkAAIjQKBENWZNRuFMBKhGTQYnEXtlSX4fIMLOMh0quP1yCblgupv?=
 =?us-ascii?Q?IxyNCKaZjdfh1eh4j9mQVeykG0ef0O4utshGypEFwboCOXgzrSD0K3NFKgeP?=
 =?us-ascii?Q?qkPZc+quj03lV8M08pvq5Tig6XDOjzViGM+29UpSquJT5IlwRydLt1XQ3iF+?=
 =?us-ascii?Q?xSIZ2ZLR6dP3AHCHImLIJTv+qMW5CsDxrXDELark0zTQ6wbqBKbxqta2MiZX?=
 =?us-ascii?Q?uB2nagYc0woLzRUOXqJzLVAbUBEbsMBn4xhgOPSbOpu9SHifdpqkxp1UTipz?=
 =?us-ascii?Q?APGeyYCzh+tGUPsgHvFMrvuvSGMYN6y3cq52kRTPdhu9Nk86lf9K6Ux6LHy3?=
 =?us-ascii?Q?9M+JYCF5IppGpuTQw14fh8tYHvyWjR+wigdViCRy65O8jTWwm/8Z34x61Pfw?=
 =?us-ascii?Q?Ip5VPfz4aGHyqOV57PdWWcIXXAufXm9rzrf/9qsCvHk0on+VqT5P4K4zz3o4?=
 =?us-ascii?Q?wz61autghYBAsYbXMfVoE1+P9W3ghvCrpQLyYw9fOAt81AMxqT5d4qeNy+Iy?=
 =?us-ascii?Q?IMclNRwy4QrQBHXbIehr8W/0efPISEbWWHvKHBTiMgQ2Z2RXAj8hBottB58p?=
 =?us-ascii?Q?VGn6v/6egQhA8fnN52xGYfQmRGT5uP9O8+VbpolYTZSNfmkdFjjw9g63Ai03?=
 =?us-ascii?Q?dXh+R4HonzjpU1BlJ0XTjQl6X1ye+jcD5PRirowSxHA7ItCbui30UEmSU383?=
 =?us-ascii?Q?O15+hgELQmuiF4st3aVHBRdM6Wi4B544nG+bsGH5+QlieVnAKl+cLPg+wGKK?=
 =?us-ascii?Q?z2rpp4A1fycCM6UmbErgvnxaf9IJFNPvCEusT1wMk1E/xzDqZArh/kniTZUM?=
 =?us-ascii?Q?hCHHqbCsCGDnfdb7CppR88F05Jzs7rWiwSrTtTZEcnGo5vgJhpmEm4WEf7Bp?=
 =?us-ascii?Q?Qs+qCQPOib+62mZdDIGVFJRX6+lBlyZy2NhHbABIYhSm2ERRAJhYlqvQYBhh?=
 =?us-ascii?Q?mAk=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/FU6/k8YEinZwfRfXPcodP7tIP2xo0jIA0hEFxzdCj/v+cI7lyRCTDVwIAfJ?=
 =?us-ascii?Q?Pw1QzVyjxukmV5jGIWPT+EXWn5oGw4r1hZX4qLJdxkgepUGWBFjurzulrNM5?=
 =?us-ascii?Q?4VnYqvkw199pn5+nuCZlk+QapUVbJyTmWO9gCa44ysZwSSOsTMIdNP8WShTr?=
 =?us-ascii?Q?ssb/r4irMz9tLw3J6pIvArcV/vpHcj58tL/Yk/vX6jthwamIDSgpXrMH3gyM?=
 =?us-ascii?Q?oFvzu9HROMGlzwMt3x09IggiaUAqV/rfX8KqGfwo/xK8+EAJZFRu4UtW8kQW?=
 =?us-ascii?Q?qga4EbDz9CBYXyNTaSBMME2kThdOsszfFNL8/wIRsTeLEb7Yqx0yM06AogMW?=
 =?us-ascii?Q?P0dfd9Ybv2UdRwRIZhuFB4jioGJ2p6XbssRgTnuF0X0WXfUwwzfygkAn2ZkI?=
 =?us-ascii?Q?DJPXvMs7Th+xNWqhosb18DRRX1MlVMoOTc5XoIqP2LWP920NX02+E8wuIhJR?=
 =?us-ascii?Q?4AJLFvlcGbvvTBcTCdImx0mj8X6jflHXqCsdjVwHKewMjAOIFsvUY+VLeYr3?=
 =?us-ascii?Q?gAxbq1hjdh0qYGGh/eIdUgUaq6Zf6cGObiLyvjQP/Wu/SNB0y0h0xQLr8z5z?=
 =?us-ascii?Q?CSYHPuOdQXNhRXGNKr9zaP0iA+9xFi5Ppoci8+nGFHOTR8MVs2voOcjSwMWM?=
 =?us-ascii?Q?xQ1rSUlTsDIh18HhWleHJIKhOillA72ctCm4Kzxyv/3XX8/FJpM/dcNioXnh?=
 =?us-ascii?Q?TDJmdcn5gZlTjMpfRbv53xicFwRcl/4p6f2cSezmbMvkEyj2uD0nzqSzb8ZC?=
 =?us-ascii?Q?CLHRllBUuPlAi3kQ2QuKumeQ5VcYJvn62gCz6L5y1jygEMs2DazvgWYpXcuH?=
 =?us-ascii?Q?FuPncsXQ3V8r4RPatxGkjKUXxBr7X1r1SMF9ZA1LJ7YAmGKY5d8nH+A/bvgL?=
 =?us-ascii?Q?9if65SCtWWXdord8tTDm76eIEy5STFgrFbjujO9sC7W+5Fo7+XcDImPyK0Wi?=
 =?us-ascii?Q?7i64v75YbX9N+Ocr1WLlG06k1wReQ6b9NRBnPgNLosCFTBC/6tRn7t9335Jx?=
 =?us-ascii?Q?MsAH8U3nED6S0i4A1qMOlIKwxYQ+0OtUPTYMwbOKx2n2miTbjIUZTAlMyD0G?=
 =?us-ascii?Q?YSGXxmQhydvVAYHRW/0oa6zG1JijEtmff1UCAHXlyN6BZSSUFcd68WbBx3yD?=
 =?us-ascii?Q?WOyafebDg7uK3aYQf2tsM0sFcSPlJ+X9H3K2B7Bsvoa4cF2i6766nouWCWFk?=
 =?us-ascii?Q?Ghd8LsPIJptZSObfUWijGp9tc4KDYFj/Ws+GZ2YE59KAX+UmQ24YHnjV4rE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f39407-ea69-435b-6c07-08ddae8310bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 16:13:30.1003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7857

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, June 3, 2025 =
5:43 PM
>=20
> The guests running on Hyper-V can be confidential where the memory and th=
e
> register content are encrypted, provided that the hardware supports that
> (currently support AMD SEV-SNP and Intel TDX is implemented) and the gues=
t
> is capable of using these features. The confidential guests cannot be
> introspected by the host nor the hypervisor without the guest sharing the
> memory contents upon doing which the memory is decrypted.
>=20
> In the confidential guests, neither the host nor the hypervisor need to b=
e
> trusted, and the guests processing sensitive data can take advantage of t=
hat.
>=20
> Not trusting the host and the hypervisor (removing them from the Trusted
> Computing Base aka TCB) ncessitates that the method of communication
> between the host and the guest be changed. Below there is the breakdown o=
f
> the options used in the both cases (in the diagrams below the server is
> marked as S, the client is marked as C):
>=20
> 1. Without the paravisoor the devices are connected to the host, and the
> host provides the device emulation or translation to the guest:
>=20
> +---- GUEST ----+       +----- DEVICE ----+        +----- HOST -----+
> |               |       |                 |        |                |
> |               |       |                 |        |                |
> |               |       |                 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
               |
> |               |       |                 |        |                |
> |               |       |                 |        |                |
> |               |       |                 |        |                |
> +----- C -------+       +-----------------+        +------- S ------+
>        ||                                                   ||
>        ||                                                   ||
> +------||------------------ VMBus --------------------------||------+
> |                     Interrupts, MMIO                              |
> +-------------------------------------------------------------------+
>=20
> 2. With the paravisor, the devices are connected to the paravisor, and
> the paravisor provides the device emulation or translation to the guest.
> The guest doesn't communicate with the host directly, and the guest
> communicates with the paravisor via the VMBus. The host is not trusted
> in this model, and the paravisor is trusted:
>=20
> +---- GUEST --------------- VTL0 ------+               +-- DEVICE --+
> |                                      |               |            |
> | +- PARAVISOR --------- VTL2 -----+   |               |            |
> | |     +-- VMBus Relay ------+    =3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D            |
> | |     |   Interrupts, MMIO  |    |   |               |            |
> | |     +-------- S ----------+    |   |               +------------+
> | |               ||               |   |
> | +---------+     ||               |   |
> | |  Linux  |     ||    OpenHCL    |   |
> | |  kernel |     ||               |   |
> | +---- C --+-----||---------------+   |
> |       ||        ||                   |
> +-------++------- C -------------------+               +------------+
>         ||                                             |    HOST    |
>         ||                                             +---- S -----+
> +-------||----------------- VMBus ---------------------------||-----+
> |                     Interrupts, MMIO                              |
> +-------------------------------------------------------------------+
>=20
> Note that in the second case the guest doesn't need to share the memory
> with the host as it communicates only with the paravisor within their
> partition boundary. That is precisely the raison d'etre and the value
> proposition of this patch series: equip the confidential guest to use
> private (encrypted) memory and rely on the paravisor when this is
> available to be more secure.

I still have a fairly fundamental question about the value proposition.
The paravisor runs as part of the VM context and so is outside the host.
It should not trust the host any more than the guest does. For operations
that require the host, such as doing disk I/O, does the paravisor provide
any security benefit over the guest just talking directly to the host? Rely=
ing
on the paravisor is great, but doesn't that just push the problem from the
guest to the paravisor, which is no better equipped to solve it than the gu=
est?
That's what I'm trying to get clear on.

>=20
> An implementation of the VMBus relay that offers the Confidential VMBus c=
hannels
> is available in the OpenVMM project as a part of the OpenHCL paravisor. P=
lease
> refer to https://openvmm.dev/guide/ for more
> information about the OpenHCL paravisor.
>=20
> I'd like to thank the following people for their help with this
> patch series:
>=20
> * Dexuan for help with validation and the fruitful discussions,
> * Easwar for reviewing the refactoring of the page allocating and
>   freeing in `hv.c`,
> * John and Sven for the design,
> * Mike for helping to avoid pitfalls when dealing with the GFP flags,
> * Sven for blazing the trail and implementing the design in few
>   codebases.
>=20
> I made sure to validate the patch series on
>=20
>     {TrustedLaunch(x86_64), OpenHCL} x
>     {SNP(x86_64), TDX(x86_64), No hardware isolation, No paravisor} x
>     {VMBus 5.0, VMBus 6.0} x
>     {arm64, x86_64}.
>=20
> [V3]
>     - The patch series is rebased on top of the latest hyperv-next branch=
.
>     - Reworked the "wiring" diagram in the cover letter, added links to t=
he
>       OpenVMM project and the OpenHCL paravisor.
>=20
>     - More precise wording in the comments and clearer code.
>     **Thank you, Alok!**
>=20
>     - Reworked the documentation patch.
>     - Split the patchset into much more granular patches.
>     - Various fixes and improvements throughout the patch series.
>     **Thank you, Michael!**

I have fully reviewed v3 and am sending comments on most of the
individual patches. The split into more granular patches works really
well and was a big help in doing the review. I did not have comments
on a couple of the patches, but I have not given my Reviewed-by yet,
pending resolution of the other issues I've pointed out.

Michael

>=20
> [V2] https://lore.kernel.org/linux-hyperv/20250511230758.160674-1-romank@=
linux.microsoft.com/
>     - The patch series is rebased on top of the latest hyperv-next branch=
.
>=20
>     - Better wording in the commit messages and the Documentation.
>     **Thank you, Alok and Wei!**
>=20
>     - Removed the patches 5 and 6 concerning turning bounce buffering off=
 from
>       the previous version of the patch series as they were found to be
>       architecturally unsound. The value proposition of the patch series =
is not
>       diminished by this removal: these patches were an optimization and =
only for
>       the storage (for the simplicity sake) but not for the network. Thes=
e changes
>       might be proposed in the future again after revolving the issues.
>     ** Thanks you, Christoph, Dexuan, Dan, Michael, James, Robin! **
>=20
> [V1] https://lore.kernel.org/linux-hyperv/20250409000835.285105-1-romank@=
linux.microsoft.com/
>=20
> Roman Kisel (15):
>   Documentation: hyperv: Confidential VMBus
>   drivers: hv: VMBus protocol version 6.0
>   arch: hyperv: Get/set SynIC synth.registers via paravisor
>   arch/x86: mshyperv: Trap on access for some synthetic MSRs
>   Drivers: hv: Rename fields for SynIC message and event pages
>   Drivers: hv: Allocate the paravisor SynIC pages when required
>   Drivers: hv: Post messages via the confidential VMBus if available
>   Drivers: hv: remove stale comment
>   Drivers: hv: Use memunmap() to check if the address is in IO map
>   Drivers: hv: Rename the SynIC enable and disable routines
>   Drivers: hv: Functions for setting up and tearing down the paravisor
>     SynIC
>   Drivers: hv: Allocate encrypted buffers when requested
>   Drivers: hv: Support confidential VMBus channels
>   Drivers: hv: Support establishing the confidential VMBus connection
>   Drivers: hv: Set the default VMBus version to 6.0
>=20
>  Documentation/virt/hyperv/coco.rst | 125 ++++++++-
>  arch/x86/kernel/cpu/mshyperv.c     |  67 ++++-
>  drivers/hv/channel.c               |  43 ++--
>  drivers/hv/channel_mgmt.c          |  27 +-
>  drivers/hv/connection.c            |   6 +-
>  drivers/hv/hv.c                    | 399 ++++++++++++++++++++---------
>  drivers/hv/hv_common.c             |  13 +
>  drivers/hv/hyperv_vmbus.h          |  28 +-
>  drivers/hv/mshv_root.h             |   2 +-
>  drivers/hv/mshv_synic.c            |   6 +-
>  drivers/hv/ring_buffer.c           |   5 +-
>  drivers/hv/vmbus_drv.c             | 187 +++++++++-----
>  include/asm-generic/mshyperv.h     |   3 +
>  include/linux/hyperv.h             |  69 +++--
>  14 files changed, 740 insertions(+), 240 deletions(-)
>=20
>=20
> base-commit: 96959283a58d91ae20d025546f00e16f0a555208
> --
> 2.43.0


