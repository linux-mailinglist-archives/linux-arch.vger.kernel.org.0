Return-Path: <linux-arch+bounces-13436-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3509BB49FAB
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 05:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E6D4469BC
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 03:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0422594BE;
	Tue,  9 Sep 2025 03:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="L9fDzuI7"
X-Original-To: linux-arch@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012011.outbound.protection.outlook.com [52.103.23.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C5D2459C8;
	Tue,  9 Sep 2025 03:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757387351; cv=fail; b=mc+iQC3hZATR/+M/Ir2AD77uFBwkQ1vD1A2jEJR5I6zElDx8xFoPSc55LoxT/5FYycSBvof+gdjCv/yDA8l0cRiH2cI33kQ3ixZp+FjjSr1Cr8BhMHQYXFxKth+7zkB4+F2/7K2WYb9g3fpmOGbCLzu95MNjQB6wibkYvqCE21U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757387351; c=relaxed/simple;
	bh=5Asgca6ff0D0ntKCQBP+Nozq+J9cSZkf9xdlK8LQySE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E693fZIAHPzlyPfg76LzMb9GX7GOyIMR86oj5FgIYCcJJZj6A78aA2kE3UCxNLE/HsJ3tuSj1Vn+J69nXyzr7NPB9zxugEiwCsDusoEh9uxyLDFqvokDoPYwmBbPriyDDaDl06KxpUVhU6hYDOZqh0qUI60NgMEbw1vodZo55r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=L9fDzuI7; arc=fail smtp.client-ip=52.103.23.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4kukQ481mavGJuYRXmkhB5tn0yL+Rq70srEQZa66qUKrUFWVlD8eZ3W4vidw6JHhUClRxB6e4WEJCMxvxYFfl8hsaWE82yHvDP2vE5hYH9GGZf7bZnq5nO0ZdYgiJBH9Le7IIpNa1quKr/M4ljdTbUglTlf6jpKf+vuOmVldltJanutJ77O3kzKfS3CIW+uRBJ40BDxXBGvYYP19izCliElQBGjV1YLEFsFeQynnpCoMqPUyEJ3CEAerHsHhnsbGg7mzoSuBbnLf3PMgfGjcKmCVJn7kORS1xZhIhSaM7Wyuu816BGq5zGPFQTYikXVFJ4t3NY2PJaZmJXw16TjFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1i37IsLaIbXYjNVLrUYIlmWuBy3+uOelM6OEK65a3w=;
 b=r56Sg8qBjePrRNiFJVxhO1pDluXdEJIyUZNYpUNwJahpGes2C6rV3hYpNHqzR3w9zRGW5XbAqCuzGzLDIVRkD30Tt+kJz0cDw4d0tIY1sRkb3tDrCahQ8UTC05NEsYl15XKVkj0LdgCfqd9pqiA+AuVSekrsIKCPXNrA7LkntTeFm5Eb6aLmXNohnSQ1WoygB9amEca1bxGnADptJNbViY6BGeagZbVZsDYcYybCpSbJBr/ysWYw9CpuaxZt69fd5eYpH2r8IbMbw+QxqDCp7ZZ5Fps7Ji6/PwKrbuHycrmMkxDiIOL2a3AhiVt4WTEExgLXbuuoH7A155wg4RogGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1i37IsLaIbXYjNVLrUYIlmWuBy3+uOelM6OEK65a3w=;
 b=L9fDzuI78jFJlE6Mi7EHgsuA9HXMoqGSeiSkyyb7nPiIDjlyQoldyUgpZ4oaxZx+LDJ37yYU3sSb1bARaa7OTvbw3wkvgvvcCUk8PluyNC+pJTKM0zAiJU1D6zwpEnSD4rb2Gt/DAx6vcvCK33/tQa6YEwN8vooe7QMQi/5ntMGPhe/KfDWMpM6HLf/SCsdKFV3vbCzfqLN7oCRAAS6gROHfkdc019NNzP7aDAD63qNJjdpBRYKrr0A3ebUe66fLKaKh6ypC1w34/fennhEslG/1sNl/eXp1ERZ8BRHHttubQVVxlW+ZkGZ1c0mMTSp35LGqVit4nTnR30xjyYw9PQ==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by DM8PR02MB8055.namprd02.prod.outlook.com (2603:10b6:8:18::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Tue, 9 Sep
 2025 03:09:05 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%4]) with mapi id 15.20.9094.018; Tue, 9 Sep 2025
 03:09:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mikelley@microsoft.com"
	<mikelley@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Tianyu.Lan@microsoft.com"
	<Tianyu.Lan@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "benhill@microsoft.com" <benhill@microsoft.com>, "bperkins@microsoft.com"
	<bperkins@microsoft.com>, "sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v5 00/16] Confidential VMBus
Thread-Topic: [PATCH hyperv-next v5 00/16] Confidential VMBus
Thread-Index: AQHcF7f+XPdlxfCyL0CN1MV9SyqDBLSJ5aVA
Date: Tue, 9 Sep 2025 03:09:05 +0000
Message-ID:
 <BN7PR02MB41489330C83724F1DC3E8427D40FA@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20250828010557.123869-1-romank@linux.microsoft.com>
In-Reply-To: <20250828010557.123869-1-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|DM8PR02MB8055:EE_
x-ms-office365-filtering-correlation-id: f9df587b-1efa-4ae1-020d-08ddef4e3c4b
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|19110799012|8062599012|13091999003|461199028|31061999003|15080799012|52005399003|10035399007|4302099013|3412199025|440099028|40105399003|12091999003|102099032|1602099012|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/O8zGP4x1QoPE9tbvI0AuIDsMhAlD9g8KIVBcd2js2i8OftPato0np0BlZzO?=
 =?us-ascii?Q?M26gumJG9d24SI05C2Hpe6NZHQcP3rwJLju/U1tF0D5iACttE+pQYx8TLSaM?=
 =?us-ascii?Q?Qhaa/o3R+xHNTnWT0Q49qXuTrznI41fFl2wO/LkkDcGGcOjdErEKissgfMsm?=
 =?us-ascii?Q?fF/foK2qOPWBGR8vDrCjVp92bbl85OpIvs/JdpVYkhweJd4WjumIZnB2JNDT?=
 =?us-ascii?Q?nzYHlk4LAhj9u1FpPsuamPtU0TqhS8ytCHUIZP7FRF8IowHFNm2FujdcADU9?=
 =?us-ascii?Q?lqWbcXZrSJhL3K88hqHM+5iyNQ3uKAezXczd72ZgAGfXuSYOEZbfPebgcgnU?=
 =?us-ascii?Q?zETbgAaZSDYWbkOJcYonxKj/QYI/9TF7E5tNNbAcV+l9uYqLgqnuFR0SStU3?=
 =?us-ascii?Q?qnPEzAx3r5MDxoWnGkx8bdvlt8VXvE5hwO5YE7Ig83iz/qmRUnA1m0MFZgtO?=
 =?us-ascii?Q?P0AUVcVRGEaOjZaGSUxcn7je6APQGyUzs9ZRBcDewmwNgkdEv/iHUCxmxxwo?=
 =?us-ascii?Q?Jsje07LQC4F/qQEFdIuH+cG4C8d6u4aE/TLkeRoJ/0cztAqmHPX2hqwu+3X6?=
 =?us-ascii?Q?OdGXPTy7DhVoRf3xP6l39IuZEDm490X3FuRjl0uYwb4uky6yDDRRx/Na8phl?=
 =?us-ascii?Q?epD1PmY/fNcCTD5d5lCSnGZZbR0+2mAhOzYCoCPT/Icj/ue6+iL96CnCMZzz?=
 =?us-ascii?Q?9rq6C8yBxwC3Q5tngi1zV0iBvSYyz12na836Ljt0lFhaANJrYM9qpmfEBst1?=
 =?us-ascii?Q?4nnAMpIZoNNNOswcCPdQs1jtPlf85TqQLFbXcFA8RzHfXSUL1EPYlEQZGCDl?=
 =?us-ascii?Q?UnWHQqJ8EtAxbZXmHxmuRK8HwPKSDFJPSm0Pjel3p6hFPQJOIrVlWZAyEicz?=
 =?us-ascii?Q?6w0GMeoYaj9qqewO7rGbQbXXT2ujG089H18wRHh9GOr+BdaU8Z2PemnGpRL+?=
 =?us-ascii?Q?QoNmZdsOLhDTjz/C70ukIvOc1yqVWb3d05lI1zXz3PRWqcgaR/p71878Mt2e?=
 =?us-ascii?Q?p7XXkCxkD2JELzAhaVVDbf5i+Hpcjp6HIvIYHnpRhW2syGkPx8kT2G2Q55KQ?=
 =?us-ascii?Q?VHTruRtOgr7dkzSuPg3+BFS7xnFMGDDyjV2AZa4LULuCs/nkUkBhFDSZs7GI?=
 =?us-ascii?Q?sVq4n/3Uf/J9IC5o2mRFhbpYOzM1eB62H4v3lxULZJ3gxq1uNbK0eYw205qH?=
 =?us-ascii?Q?rOjQ2BdCZ6RFSL4cqfltEfpdkIjpdxDBM67jX0alypo044tiISauwIOEDOsr?=
 =?us-ascii?Q?w3gx2ZkKOyMnOhtoQXlFRwFa3+sXjuDGLIc6TcIMcMUkuKhsw/RjuKdJNJla?=
 =?us-ascii?Q?BhfwG1dBMv7hC3ATLZSOhUuz?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Us28SZSEim9j3iXY7ccihMy1f7n6hiKEfOaepRFqAdmVo5BHvei93SgijoNb?=
 =?us-ascii?Q?QLK9s+7Vt7Flcwj+JyynmCHxx0ahfLm183O3ACQYlcgfLPYX3gDJId9XNQAA?=
 =?us-ascii?Q?KFOLf8/HOp8f57kARMoaCdB9//uzcpnajxqrhoqyj651Z7RL7QmntEfAdehx?=
 =?us-ascii?Q?QqP1ip/tMiijijPpA5Pxzt4malZKrqNItHOEZ/57620sis6/7YCc1d5RnS43?=
 =?us-ascii?Q?wWxLaS+gtVeGBgb2MRsen5nuX8C0SIhzaZqQdiS/19sD4BKwtRoekvK8k9pU?=
 =?us-ascii?Q?eRTbAQLvFEMcKSyieY0jU68DLrVAN5IkLU5w6hbBz5ApRKVml5cDJHfSTdrA?=
 =?us-ascii?Q?Vqw2cnW2aYZQHvTFtgkmUJn55aHsLyDnnQVbryIyml6rzy/swnCFrNzNuxk/?=
 =?us-ascii?Q?N/0YnoyX8NpQb1djO+Qz47379tP6o+EL3zOkSUt1ElXC4jYPmzPJ3PKZK4iN?=
 =?us-ascii?Q?6NZMWef/1hd7gnBxLEBJwSiDOZJDXoymr+Sb+svW5OTp6ztD3lMYfpAme0Dc?=
 =?us-ascii?Q?Eh5XyYCu9tWVimJYlGvc8foQCVZmZiiTiAuxbhq+mHrw1St8mbbH/TdzcswF?=
 =?us-ascii?Q?SQKf56z0NYP7NIXKfdTavxcW6LNJTqc5jjKCKkFOEit25Skoob2SopLMr6GQ?=
 =?us-ascii?Q?srGlo+uvVUl5qqGgCTPuqOaRMIYmOb3I1K69kY3T/kXeLmRC5nwbRuau4c3g?=
 =?us-ascii?Q?ApBSWgEh3UT+OfOEtNVrbM5rI2fvn3COeJfFOnEMvO2Q99Cdk3NVgLf8n7sF?=
 =?us-ascii?Q?olklKW5FfCtpa+MveEIbFJ0UZNYZUoYAhZ+DPQ1DF3XcDOKRuSUSwv72KYjj?=
 =?us-ascii?Q?mN73ieLf8/xFy3ZdBL/pESjO/aPJzhDV2Ox2WqRMZ4+m9i0r3ALGfxq5H6A/?=
 =?us-ascii?Q?KiCgoxeJhqX6qgLGq80kn6Z7DjlcI1CldF5Z9WvvwhZYm1Sa3/XyhNUoL8Xj?=
 =?us-ascii?Q?isSYgXaf+eEJKLz4z7qZnP4weLlW5NXELFEjIv3iCxrulTtQBh9Evh9DOwgi?=
 =?us-ascii?Q?Mbb1VsByHvCZwd7lByIko6bdCa3QKWANzRtymriGSmRjU+iqUkAhDs25f9a6?=
 =?us-ascii?Q?WVG222eWv9BPxu5btiNsYPAoLVdkAhLHiryhHgPQAbpKD8zEttAWAvlQaUm0?=
 =?us-ascii?Q?xp2a2qx9Rpy4Vl57umBNuxev0PRbgDiuZj/ZSFepjkonD2mJtcuMP6pt+Kho?=
 =?us-ascii?Q?jLaIHzEO4LfwHJofc6Tfc861bh/AfI0lpsCU/ecC2a2RLlCjwvh8a38ML5A?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f9df587b-1efa-4ae1-020d-08ddef4e3c4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 03:09:05.4126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8055

From: Roman Kisel <romank@linux.microsoft.com> Sent: Wednesday, August 27, =
2025 6:06 PM
>=20
> Hello all,
>=20
> This is the 5th version of the patch series, and the full changelog
> is at the end of the cover letter. The most notable change is that
> now there is a CPUID bit set under the virtualization leaf to indicate
> that the Confidential VMBus is available. The fallback approach used
> in the first versions received some criticism, and that has been addresse=
d
> in this version.
>=20
> The COUID bit is obviously an x86_64 specific technique. On ARM64, the

s/COUID/CPUID/

> Confidential VMBus is expected to be required once support for ARM CC is
> implemented. Despite that change, the functions for getting and setting
> registers via paravisor remain fallible. That provides a clearer root cau=
se
> for failures instead of printing messages about unchecked MSR accesses.
> That might seem as not needed with the paravisors run in Azure (OpenHCL
> and the TrustedLauch aka HCL paravisor). However, if someone decides to
> implement their own or tweak the exisiting one, this will help with debug=
ging.
>=20
> TLDR; is that these patches are for the Hyper-V guests, and the patches
> allow to keep data flowing from physical devices into the guests encrypte=
d
> at the CPU level so that neither the root/host partition nor the hypervis=
or
> can access the data being processed (they only "see" the encrypted/garble=
d
> data) unless the guest decides to share it. The changes are backward comp=
atible
> with older systems, and their full potential is realized on hardware that
> supports memory encryption.
>=20
> These features also require running a paravisor, such as
> OpenHCL (https://github.com/microsoft/openvmm) used in Azure. Another
> implementation of the functionality available in this patch set is
> available in the Hyper-V UEFI: https://github.com/microsoft/mu_msvm.
>=20
> A more detailed description of the patches follows.
>=20
> The guests running on Hyper-V can be confidential where the memory and th=
e
> register content are encrypted, provided that the hardware supports that
> (currently support AMD SEV-SNP and Intel TDX is implemented) and the gues=
t

s/support/support for/

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
> Computing Base aka TCB) necessitates that the method of communication
> between the host and the guest be changed. Here is the data flow for a
> conventional and the confidential VMBus connections (`C` stands for the
> client or VSC, `S` for the server or VSP, the `DEVICE` is a physical one,
> might be with multiple virtual functions):
>=20
> 1. Without the paravisor the devices are connected to the host, and the
> host provides the device emulation or translation to the guest:
>=20
>   +---- GUEST ----+       +----- DEVICE ----+        +----- HOST -----+
>   |               |       |                 |        |                |
>   |               |       |                 |        |                |
>   |               |       |                 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D                |
>   |               |       |                 |        |                |
>   |               |       |                 |        |                |
>   |               |       |                 |        |                |
>   +----- C -------+       +-----------------+        +------- S ------+
>          ||                                                   ||
>          ||                                                   ||
>   +------||------------------ VMBus --------------------------||------+
>   |                     Interrupts, MMIO                              |
>   +-------------------------------------------------------------------+
>=20
> 2. With the paravisor, the devices are connected to the paravisor, and
> the paravisor provides the device emulation or translation to the guest.
> The guest doesn't communicate with the host directly, and the guest
> communicates with the paravisor via the VMBus. The host is not trusted
> in this model, and the paravisor is trusted:
>=20
>   +---- GUEST --------------- VTL0 ------+               +-- DEVICE --+
>   |                                      |               |            |
>   | +- PARAVISOR --------- VTL2 -----+   |               |            |
>   | |     +-- VMBus Relay ------+    =3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D            |
>   | |     |   Interrupts, MMIO  |    |   |               |            |
>   | |     +-------- S ----------+    |   |               +------------+
>   | |               ||               |   |
>   | +---------+     ||               |   |
>   | |  Linux  |     ||    OpenHCL    |   |
>   | |  kernel |     ||               |   |
>   | +---- C --+-----||---------------+   |
>   |       ||        ||                   |
>   +-------++------- C -------------------+               +------------+
>           ||                                             |    HOST    |
>           ||                                             +---- S -----+
>   +-------||----------------- VMBus ---------------------------||-----+
>   |                     Interrupts, MMIO                              |
>   +-------------------------------------------------------------------+
>=20
> Note that in the second case the guest doesn't need to share the memory
> with the host as it communicates only with the paravisor within their
> partition boundary. That is precisely the raison d'etre and the value
> proposition of this patch series: equip the confidential guest to use
> private (encrypted) memory and rely on the paravisor when this is
> available to be more secure.
>=20
> An implementation of the VMBus relay that offers the Confidential VMBus
> channels is available in the OpenVMM project as a part of the OpenHCL
> paravisor. Please refer to
>=20
>   * https://openvmm.dev/guide/, and
>   * https://github.com/microsoft/openvmm
>=20
> for more information about the OpenHCL paravisor. A VMBus client
> that can work with the Confidential VMBus is available in the
> open-source Hyper-V UEFI: https://github.com/microsoft/mu_msvm.
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
> [V5]
>     - Rebased onto the latest hyperv-next tree.
>=20
>     - Fixed build issues with the configs provided by the kernel robot.
>       **Thank you, kernel robot!**
>=20
>     - Fixed the potential NULL deref in a failure path.
>       **Thank you, Michael!**
>=20
>     - Removed the added blurb from the vmbus_drv.c with taxonomy of Hyper=
-V VMs
>       that was providing reasons for the trade-offs in the fallback code.=
 That
>       code is no longer needed.
>=20
> [V4] https://lore.kernel.org/linux-hyperv/20250714221545.5615-1-romank@li=
nux.microsoft.com/
>     - Rebased the patch series on top of the latest hyperv-next branch,
>       applying changes as needed.
>=20
>     - Fixed typos and clarifications all around the patch series.
>     - Added clarifications in the patch 7 for `ms_hyperv.paravisor_presen=
t && !vmbus_is_confidential()`
>       and using hypercalls vs SNP or TDX specific protocols.
>       **Thank you, Alok!**
>=20
>     - Trim the Documentation changes to 80 columns.
>       **Thank you, Randy!**
>=20
>     - Make sure adhere to the RST format, actually built the PDF docs
>       and made sure the layout was correct.
>     **Thank you, Jon!**
>=20
>     - Better section order in Documentation.
>     - Fixed the commit descriptions where suggested.
>     - Moved EOI/EOM signaling for the confidential VMBus to the specializ=
ed function.
>     - Removed the unused `cpu` parameters.
>     - Clarified comments in the `hv_per_cpu_context` struct
>     - Explicitly test for NULL and only call `iounmap()` if non-NULL inst=
ead of
>       using `munmap()`.
>     - Don't deallocate SynIC pages in the CPU online and offline paths.
>     - Made sure the post page needs to be allocated for the future.
>     - Added comments to describe trade-offs.
>     **Thank you, Michael!**
>=20
> [V3] https://lore.kernel.org/linux-hyperv/20250604004341.7194-1-romank@li=
nux.microsoft.com/
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
> Roman Kisel (16):
>   Documentation: hyperv: Confidential VMBus
>   drivers: hv: VMBus protocol version 6.0
>   arch: hyperv: Get/set SynIC synth.registers via paravisor
>   arch/x86: mshyperv: Trap on access for some synthetic MSRs
>   Drivers: hv: Rename fields for SynIC message and event pages
>   Drivers: hv: Allocate the paravisor SynIC pages when required
>   Drivers: hv: Post messages through the confidential VMBus if available
>   Drivers: hv: remove stale comment
>   Drivers: hv: Check message and event pages for non-NULL before iounmap(=
)
>   Drivers: hv: Rename the SynIC enable and disable routines
>   Drivers: hv: Functions for setting up and tearing down the paravisor Sy=
nIC
>   Drivers: hv: Allocate encrypted buffers when requested
>   Drivers: hv: Free msginfo when the buffer fails to decrypt
>   Drivers: hv: Support confidential VMBus channels
>   Drivers: hv: Set the default VMBus version to 6.0
>   Drivers: hv: Support establishing the confidential VMBus connection
>=20
>  Documentation/virt/hyperv/coco.rst | 143 +++++++++-
>  arch/x86/include/asm/mshyperv.h    |   2 +
>  arch/x86/kernel/cpu/mshyperv.c     |  86 +++++-
>  drivers/hv/channel.c               |  73 +++--
>  drivers/hv/channel_mgmt.c          |  27 +-
>  drivers/hv/connection.c            |   6 +-
>  drivers/hv/hv.c                    | 426 ++++++++++++++++++++---------
>  drivers/hv/hv_common.c             |  24 ++
>  drivers/hv/hyperv_vmbus.h          |  70 ++++-
>  drivers/hv/mshv_root.h             |   2 +-
>  drivers/hv/mshv_synic.c            |   6 +-
>  drivers/hv/ring_buffer.c           |   5 +-
>  drivers/hv/vmbus_drv.c             | 186 ++++++++-----
>  include/asm-generic/mshyperv.h     |  39 +--
>  include/hyperv/hvgdk_mini.h        |   1 +
>  include/linux/hyperv.h             |  69 +++--
>  16 files changed, 878 insertions(+), 287 deletions(-)
>=20
>=20
> base-commit: 03ac62a578566730ab3c320f289f7320798ee2e1
> --
> 2.43.0
>=20


