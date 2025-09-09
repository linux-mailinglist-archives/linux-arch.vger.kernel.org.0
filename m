Return-Path: <linux-arch+bounces-13440-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA1FB49FB9
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 05:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3624E3AF2C4
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 03:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB0225A2D1;
	Tue,  9 Sep 2025 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RXA/PeV9"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2052.outbound.protection.outlook.com [40.92.40.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6162E235345;
	Tue,  9 Sep 2025 03:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757387461; cv=fail; b=SviSNq+Ph5QSb3R2CuXEhr/dkAK/x1wqgRsKWkl384fpna0AW6PTxsNEiQ1u0Ne9m5L8iIzm1G0lB7/D5iCA3vn5zq/2gjF0jJPqr+oIzcJ9Pl1yoTvF9xc5Sqrn+a03Bhbdnmwu9GivPSsYu1SuIUyUnEDjpr7onhWqSyVWz9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757387461; c=relaxed/simple;
	bh=kRfTxH7lZhoIJl8ZEpFFn3PS+X5Fl6reo/DdQOQxP0U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AnLRDZfKeHRl6BRcjesH717xQJ3Ig+BBqqp28gRe7IBhIw/fFPlYPi4vNxNdVp4exWHfTt5gicXYjp9CLLbfwChLSvxfp9ipdpoMrXjCDA/bsnZinDQXGQc62M5d1xM1vp6vXKFFcls36UxbRcgtaSixAEel88QmBtUOJM/5K8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RXA/PeV9; arc=fail smtp.client-ip=40.92.40.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGV1PalSbVxYCVEFKZYWnjnc/HJJRIVAqDcvmCYXoKyg2sSphDJ/lTKrlIBTf9/KrrB64zdFWmi2tGyGtP0oPFaaxpS/FzzYUJyEnbAxcw7rIwVxHdynVmH7FN4cnJGxOyc+l3e+Bzl9al0HsKhTQRJGig3aG4wYrO0yXOKIT2Mk5z/weaApgWFlvWik9nvz/IbFbDLv9jMLew0YR3OiClbEa05nPetuJp7/0m++u83P6dyZc1Oxd9rYvU0K+xmfJmC6Cv/1NrICW2YT9D4dJqXqMbkRPkn+kVkGrcQt0MJPeX8XOuqc4v4M5E9KFqB0KOHAc5ArceIBVUyeb3oYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ezsva8t5C7VrxynxJoo963VaYRJEcV95j22AcEQtI0=;
 b=d1lahqKuiFFX7TlwzPbAwART05UaXAnOx25qkpKeFXNXWj7kkxIn6e4egHRtXuTjZUR6brwKEVjFAHPZxhSktMDOys7o47g5it+JqpObF6uTF6m0zKo4iSF8lm2bjr+HihIbaSGpu6kKoaGnjGq6lUDJrc6/kUJGXBOWphjtY9vDhzGxHwcIVX2cBGPq6ySJwVIqB4wQGUYWVh6ouGsQIJlfxgNy+tT+h+1asBzukYxWzLoyt4hS3r4rEPY7Z6I9dXXMZYITuoTObW1xGXwx0py6AH6BQeUEdJPMQIfHu1dtZNkUcv83n+UrA2QXm3zK5svlrG9Opj4FA/s8MLDXWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ezsva8t5C7VrxynxJoo963VaYRJEcV95j22AcEQtI0=;
 b=RXA/PeV9HkbymLBvDF3P906hNswSjTDQ/8ca9DOWRPw2uflmDYfJGnz0Uz2gK2L6mhVYuq+OTlpAviKtsCS1bZlacepYSrkHBwBAr7epUjKX3MBnd+5Dh7TBoSJSLrXjNellBVftjuHNAsul1Ok9upM3vPWaRKM2mg33jzEWK14V0dWPeDpOP+FiNI+4dmmRYuc28fCbLBV1/R51MoOqYQHJzuFBqnbMWareXeLiCLL9hzMpBid95GidN/tOAm39H7PtL5gHZ/li8j/x31IPnWm6Dl/rtaTraSm/5VMbko9ZYiH74V+uIk0o9XhpjSMuwhJtR9yk/c3CK5zdpPAIbw==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by SJ0PR02MB8484.namprd02.prod.outlook.com (2603:10b6:a03:3fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Tue, 9 Sep
 2025 03:10:54 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%4]) with mapi id 15.20.9094.018; Tue, 9 Sep 2025
 03:10:52 +0000
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
Subject: RE: [PATCH hyperv-next v5 03/16] arch: hyperv: Get/set SynIC
 synth.registers via paravisor
Thread-Topic: [PATCH hyperv-next v5 03/16] arch: hyperv: Get/set SynIC
 synth.registers via paravisor
Thread-Index: AQHcF7gUdM/I3hp5GEuZENh6isnpsLSKPxHw
Date: Tue, 9 Sep 2025 03:10:52 +0000
Message-ID:
 <BN7PR02MB4148C0731E96EC3A4D451ED6D40FA@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20250828010557.123869-1-romank@linux.microsoft.com>
 <20250828010557.123869-4-romank@linux.microsoft.com>
In-Reply-To: <20250828010557.123869-4-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|SJ0PR02MB8484:EE_
x-ms-office365-filtering-correlation-id: 4113c2e6-ab7f-441c-93b8-08ddef4e7c55
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBtg1x3yx1r6QKZAk6LGeuzaAYXs27+46mEmGMCanF/rnZz1ZmlSX1pqqGbXAaXpjsrx+XJYrbPcTMqihY+6a5qQN0zFt8BXFHkuvO7e9HcUaCOJQj8hhPJPu6f2V6oLebHdVS8NJMJAyWoSxnkd/pHNhFBikpgmBhcjq5bRQxRMceGKsGmYpXHkQyCaCEL9o6gwlJsufklciK642/AtJRu8ZrmnTeXQTMaILzyBPrCmYWZj/5HgMuOOy+y1+Gw3e5j0T1gwrHPLFlK6H/vg6SNPXueu7yk6OwnUhjPcKGlfYVi+IXrefuyX9LoUySp4Tlgpmv+lT8KP/pQFbc49oEewJdjh8SkMK2m2qZYfNGJKAXia8NT0YRzOL7MLcPXuXVJcF3e6ASdz8kANHjgW0adbKZ/z6VyLAaUe+0NQ582kxoGIXLPZTosZD5Fo6K835pmqpvIs/IVmYYesjJkN4Oxaa3/HBn0evfbWukcl2KwjWnzyCv/8GHVOw89V+zRwg5Gs3UPWqeRDGD7SpZ2equ9PG9gxCIdAcAZ/tsWvDZOLy8hzK6dgZaLNOPoLmYCNOqdWtbg6I+G6PA54WaahxP2eamF+KqpLeUqsHYwAz+CoX59IvLrQrA0O/grTBLvZFInqV96taBQMcKB2XWrQNE2yHtv778ER2s5QnYV+WhrH+ry/WpQXgRPpKSbeHLHmm55R6mHGapnxgZGct5I/6sOaz4z1TKQ7HKSb0buWyUj2dcwL7bz9SNolhVDxCLYJR+ttP/NT8D5fLLfaVRGsPGxm
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|8060799015|8062599012|31061999003|461199028|15080799012|41001999006|19110799012|440099028|40105399003|3412199025|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gRKMAbDmZ7LvcaxaLxkllIM+bDHVUG/Rn/r6v/RCdZPowAmy8WQT7YrB+Lmf?=
 =?us-ascii?Q?17IOtJmZkOjStcw1uJEJ7vSzuYs8QTjIJz6AjfFqrxEEEvL662cL7U7FNGWe?=
 =?us-ascii?Q?rtfYarhUDwV8vdSz3NklvLGNWfvMuRrrLumarHQigEUvLYvpTNTJnOLn01C0?=
 =?us-ascii?Q?knPfEuRzXs/rq/TCHNyU7cJUCxfVq2hDbkuuxJhFNmYQGF8X+YzWyQ7IZtGa?=
 =?us-ascii?Q?PpJfrFnA3UrHfuULHvxBCc9B/zOq5irsKXFgjE3uD8RRKlyjbeXT01NtKqdE?=
 =?us-ascii?Q?aUzBYmmLdWDtegRjWgehWSOCuB5vYuh3fqaHfVZ5gyHJ0AZc2qYMCKwA2Ccw?=
 =?us-ascii?Q?SiYoJ4cNfkU6ZwWFXNMvfo8KS7MaUMh/uS+cvCqTG/bf9gaBSFoVtDvrq9UY?=
 =?us-ascii?Q?BME2SNwit0vgBBGw8eYcfVdCWUjaQAduT0UsxwPtBST+OBXUfZbMnWllnqPL?=
 =?us-ascii?Q?q6ovYpz9RPzdnOweHrdk+4Z7HAZD6EAOmi5l/lAwiCFoPedVoLrWz/F6zuox?=
 =?us-ascii?Q?UrT7ddkdXWV/EOS1gNK4FAUB7HxhgaqAMkusxsELjwtp3D8N+KvRmdxwC+OD?=
 =?us-ascii?Q?oziRd9wMdWG91+SUnogqq7vWpFnG8ua3rNwn6TGNRfRdU/EsCFAcu485NuSw?=
 =?us-ascii?Q?q7IT9s6uqu9vJJZvULqE+n8t/ZeXTNF4iOKs4lX34GKXhyD2WCzuRHQ/thwZ?=
 =?us-ascii?Q?JUju6APFTKcKhi8uy0qA/jTYdaYqXlv18eouUmSVjHC0lEX4ixA8k8EhU2X2?=
 =?us-ascii?Q?htUq45gbRzMpJZOtWW+KgOLVPIxwSAF2J6W3xyefO140izyLwJbh14iCAeI8?=
 =?us-ascii?Q?OqxLFGbqa3360ZwMK0auzxlnTDvDvTAqII2GfLPbjW4j+ivbw2LZ7P8VA/gC?=
 =?us-ascii?Q?8Ja0n9gAmz83I/T9yBLVCoa/1ZiVrhuhA33vjdnhOosQu5aeitV636TXsW2b?=
 =?us-ascii?Q?ODSG2+zBSAOTk+5PuUI3ICa9SX6aLea9gaPHJyqW7qGHiSDkrMxIobRPWqpu?=
 =?us-ascii?Q?pEUpRcMdnp2I0YOUyoQ9GVYOp8Dzhx4pYc9IA+NtYYwRhbU6v29u5N9lf7KP?=
 =?us-ascii?Q?/3P7X4a+5tmgaxt6DSoi4ad9Rr19QBZPC7L+GkvA3qRt5ptjbWZzAlusx60Z?=
 =?us-ascii?Q?QEoHj+N2UhQo1xyQSBKdakSVQzjpeFYr+VbRKSlz6x6hBaEk7lrcBFQiumRE?=
 =?us-ascii?Q?TJb8gWC/FPttr3mrwirnwklichG4/LpnSVSbrmbOW1I4xiOVZgAgjIIGyXE?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?E4wahU0XiAJsoMmAFU/i2VDYHuiXIg2ecGk+TjFwQx3BjBiXiwR6+FH/ux0w?=
 =?us-ascii?Q?0c5B0DQwjucSEOOUYhHerwQdvQcyWCN5hkaYoKAQElNPInPMiQpxkG8vwmTw?=
 =?us-ascii?Q?VMrxebeWTk7hUWVigQg+u3UFOjc0H3c+BF+Tm/fMAp/vHHnzij3PhMoE1e9N?=
 =?us-ascii?Q?1q0l549NBysIgqUDmUewEfpEMFEhSoqXaRufKVc01WwfpSdKvr0X8YgMmO1L?=
 =?us-ascii?Q?Mn99LbB07D+Bhu4eDlWVHa4Io1TIuXpuNegy6s6MzIb7pz2Eesqa+/xC3sUm?=
 =?us-ascii?Q?zB93Hm2AP86p3EYVBGuRfs+gLr1HVuhulHWRzOmgY5YcF2pEpLAZkEbcVl/0?=
 =?us-ascii?Q?aQZSuvqE/YqSE43eenglZ4kHYjHrmcED4x5bHffESg08pSRaOXxLeZUXmGPz?=
 =?us-ascii?Q?o84+07nYiGtA8+HN3MR/L6/QTu1SaN6BEC6/aRjyQRgpOUMBKOR2UQ9WNN3j?=
 =?us-ascii?Q?ng7CmW2JsDGkI6wS8GtyMHh9xCSSPu/B+EUopfsRKgymNuQeYd2GG5LvEuxK?=
 =?us-ascii?Q?8psCLG2EEtavdIWRdz8jXHtioMDmmX6T6GaCgrZQ4no64Pg9E5vkG8vLHK2s?=
 =?us-ascii?Q?hlkHCLK/nqB3E8QiCaMGaNQraW/rLP0iyjcsyfn+NvcZJZ6WOdmE/ddr0crB?=
 =?us-ascii?Q?USTxmsna0kDoUsWMRNR2Wa+STMne/XkX+YAU/MlHLWJmm+xZI3PgldNQGgng?=
 =?us-ascii?Q?60pgljAkBrBmur1UFFE5rj5t7A06Fg4r+NLSBmoULgqPOsCSGyz6SrJdPgtB?=
 =?us-ascii?Q?wPZCpOVJbRTepkk7OVoSWgMVmGtKCp48JOc7MoaaoSofnAOPHIfstGtOaxRq?=
 =?us-ascii?Q?6W6QvRABUOBMrOx2gHd4WsjENpGyzDnr8acUrwV+XNDDR2zKGYzmZ9i27esH?=
 =?us-ascii?Q?hzw4dDEj3S4BRf+UYmgu9WbTDMgXO5sLTQkLvR4DQbmRPmKso3VjJmnsdSv1?=
 =?us-ascii?Q?GYfn9dOaNwTPHyMG9QZDSsKVHAbjiPNkwNns4KpUlxoHxYZ4qHStEMk1+VYu?=
 =?us-ascii?Q?fhxd1TUeXB1jy3j6ubOpI3+5vjQ0rclHNYRVgTftzmC/gr9OyVrZsjQLinKm?=
 =?us-ascii?Q?zR7t1XrH4TBF1ZF+NX9eQjsXm5ulHe4qty1Ds9Pr/mM1KFAoy18w6za8vexa?=
 =?us-ascii?Q?nKqVM12NVwTSA8xR/830Den72fjgMCyFvSSWxm6kBTmgdN2zmbI8Mj599Vdt?=
 =?us-ascii?Q?8uidx2pAtW4JVHXFIteT3c0+V6JXZuW9fbJpfnA1wh6VXZglVR1b7ONcc8o?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4113c2e6-ab7f-441c-93b8-08ddef4e7c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 03:10:52.8381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8484

From: Roman Kisel <romank@linux.microsoft.com> Sent: Wednesday, August 27, =
2025 6:06 PM
>=20
> The existing Hyper-V wrappers for getting and setting MSRs are
> hv_get/set_msr(). Via hv_get/set_non_nested_msr(), they detect
> when running in a CoCo VM with a paravisor, and use the TDX or
> SNP guest-host communication protocol to bypass the paravisor
> and go directly to the host hypervisor for SynIC MSRs. The "set"
> function also implements the required special handling for the
> SINT MSRs.
>=20
> Provide functions that allow manipulating the SynIC registers
> through the paravisor. Move vmbus_signal_eom() to a more
> appropriate location (which also avoids breaking KVM).
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  arch/x86/kernel/cpu/mshyperv.c | 39 ++++++++++++++++++++++++++++++++++
>  drivers/hv/hv_common.c         | 13 ++++++++++++
>  drivers/hv/hyperv_vmbus.h      | 39 ++++++++++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h | 37 ++------------------------------
>  4 files changed, 93 insertions(+), 35 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 95cd78004b11..a619b661275b 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -109,6 +109,45 @@ bool hv_confidential_vmbus_available(void)
>  	return eax &
> HYPERV_VS_PROPERTIES_EAX_CONFIDENTIAL_VMBUS_AVAILABLE;
>  }
>=20
> +/*
> + * Attempt to get the SynIC register value from the paravisor.
> + *
> + * Not all paravisors support reading SynIC registers, so this function
> + * may fail. The register for the SynIC of the running CPU is accessed.
> + *
> + * Writes the SynIC register value into the memory pointed by val,
> + * and ~0ULL is on failure.
> + *
> + * Returns -ENODEV if the MSR is not a SynIC register, or another error
> + * code if getting the MSR fails (meaning the paravisor doesn't support
> + * relaying VMBus communucations).
> + */
> +int hv_para_get_synic_register(unsigned int reg, u64 *val)
> +{
> +	if (!ms_hyperv.paravisor_present || !hv_is_synic_msr(reg))
> +		return -ENODEV;
> +	return native_read_msr_safe(reg, val);
> +}
> +
> +/*
> + * Attempt to set the SynIC register value with the paravisor.
> + *
> + * Not all paravisors support setting SynIC registers, so this function
> + * may fail. The register for the SynIC of the running CPU is accessed.
> + *
> + * Sets the register to the value supplied.
> + *
> + * Returns: -ENODEV if the MSR is not a SynIC register, or another error
> + * code if writing to the MSR fails (meaning the paravisor doesn't suppo=
rt
> + * relaying VMBus communucations).
> + */
> +int hv_para_set_synic_register(unsigned int reg, u64 val)
> +{
> +	if (!ms_hyperv.paravisor_present || !hv_is_synic_msr(reg))
> +		return -ENODEV;
> +	return native_write_msr_safe(reg, val);
> +}
> +
>  u64 hv_get_msr(unsigned int reg)
>  {
>  	if (hv_nested)
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index fae63c54e531..8285ba005a71 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -722,6 +722,19 @@ bool __weak hv_confidential_vmbus_available(void)
>  }
>  EXPORT_SYMBOL_GPL(hv_confidential_vmbus_available);
>=20
> +int __weak hv_para_get_synic_register(unsigned int reg, u64 *val)
> +{
> +	*val =3D ~0ULL;
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(hv_para_get_synic_register);
> +
> +int __weak hv_para_set_synic_register(unsigned int reg, u64 val)
> +{
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(hv_para_set_synic_register);
> +
>  void hv_identify_partition_type(void)
>  {
>  	/* Assume guest role */
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 6e4c3acc1169..e8b87fbb88cb 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -15,6 +15,7 @@
>  #include <linux/list.h>
>  #include <linux/bitops.h>
>  #include <asm/sync_bitops.h>
> +#include <asm/mshyperv.h>
>  #include <linux/atomic.h>
>  #include <linux/hyperv.h>
>  #include <linux/interrupt.h>
> @@ -336,6 +337,44 @@ extern const struct vmbus_channel_message_table_entr=
y
>=20
>  bool vmbus_is_confidential(void);
>=20
> +/* Free the message slot and signal end-of-message if required */
> +static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_=
type)
> +{
> +	/*
> +	 * On crash we're reading some other CPU's message page and we need
> +	 * to be careful: this other CPU may already had cleared the header
> +	 * and the host may already had delivered some other message there.
> +	 * In case we blindly write msg->header.message_type we're going
> +	 * to lose it. We can still lose a message of the same type but
> +	 * we count on the fact that there can only be one
> +	 * CHANNELMSG_UNLOAD_RESPONSE and we don't care about other messages
> +	 * on crash.
> +	 */
> +	if (cmpxchg(&msg->header.message_type, old_msg_type,
> +		    HVMSG_NONE) !=3D old_msg_type)
> +		return;
> +
> +	/*
> +	 * The cmxchg() above does an implicit memory barrier to
> +	 * ensure the write to MessageType (ie set to
> +	 * HVMSG_NONE) happens before we read the
> +	 * MessagePending and EOMing. Otherwise, the EOMing
> +	 * will not deliver any more messages since there is
> +	 * no empty slot
> +	 */
> +	if (msg->header.message_flags.msg_pending) {
> +		/*
> +		 * This will cause message queue rescan to
> +		 * possibly deliver another msg from the
> +		 * hypervisor
> +		 */
> +		if (vmbus_is_confidential())
> +			hv_para_set_synic_register(HV_MSR_EOM, 0);
> +		else
> +			hv_set_msr(HV_MSR_EOM, 0);
> +	}
> +}
> +
>  struct hv_device *vmbus_device_create(const guid_t *type,
>  				      const guid_t *instance,
>  				      struct vmbus_channel *channel);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index acb017f6c423..4b0b05faef70 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -163,41 +163,6 @@ static inline u64 hv_generate_guest_id(u64 kernel_ve=
rsion)
>  	return guest_id;
>  }
>=20
> -/* Free the message slot and signal end-of-message if required */
> -static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_=
type)
> -{
> -	/*
> -	 * On crash we're reading some other CPU's message page and we need
> -	 * to be careful: this other CPU may already had cleared the header
> -	 * and the host may already had delivered some other message there.
> -	 * In case we blindly write msg->header.message_type we're going
> -	 * to lose it. We can still lose a message of the same type but
> -	 * we count on the fact that there can only be one
> -	 * CHANNELMSG_UNLOAD_RESPONSE and we don't care about other messages
> -	 * on crash.
> -	 */
> -	if (cmpxchg(&msg->header.message_type, old_msg_type,
> -		    HVMSG_NONE) !=3D old_msg_type)
> -		return;
> -
> -	/*
> -	 * The cmxchg() above does an implicit memory barrier to
> -	 * ensure the write to MessageType (ie set to
> -	 * HVMSG_NONE) happens before we read the
> -	 * MessagePending and EOMing. Otherwise, the EOMing
> -	 * will not deliver any more messages since there is
> -	 * no empty slot
> -	 */
> -	if (msg->header.message_flags.msg_pending) {
> -		/*
> -		 * This will cause message queue rescan to
> -		 * possibly deliver another msg from the
> -		 * hypervisor
> -		 */
> -		hv_set_msr(HV_MSR_EOM, 0);
> -	}
> -}
> -
>  int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
>=20
>  void hv_setup_vmbus_handler(void (*handler)(void));
> @@ -335,6 +300,8 @@ bool hv_isolation_type_snp(void);
>  bool hv_confidential_vmbus_available(void);
>  u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_=
size);
>  u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> +int hv_para_get_synic_register(unsigned int reg, u64 *val);
> +int hv_para_set_synic_register(unsigned int reg, u64 val);
>  void hyperv_cleanup(void);
>  bool hv_query_ext_cap(u64 cap_query);
>  void hv_setup_dma_ops(struct device *dev, bool coherent);
> --
> 2.43.0
>=20


