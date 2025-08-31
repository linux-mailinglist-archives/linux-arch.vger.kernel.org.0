Return-Path: <linux-arch+bounces-13342-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2CFB3D411
	for <lists+linux-arch@lfdr.de>; Sun, 31 Aug 2025 17:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC36D16F66F
	for <lists+linux-arch@lfdr.de>; Sun, 31 Aug 2025 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FB9269CE6;
	Sun, 31 Aug 2025 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="I+NpHRxY"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2023.outbound.protection.outlook.com [40.92.42.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308112475E3;
	Sun, 31 Aug 2025 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756653182; cv=fail; b=uY4+IX7ZOfD4DW16ilgX2v3xWRkfCWmpVb/avuJh8waO8Hd9aKz55rpgE8LHMhTY6pJalzOs6D9h17tPNMcpxJFmB3ixsbr//m9zSb2XWkSxckf7x+UzJvdPesVS0FbUHtMt/yjGJ1Ssauj0Gb8ke2kIzkc+1eHgTpvZ9g1txs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756653182; c=relaxed/simple;
	bh=2B3BQJ3+CyErRY6eemQpabeYf4NU/qXovNVX6lWis7o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MMfu64uHftdODFwdIQw1/mQIXcNq/irKSsc+OqeWrO2BQzgdE0Po1aHteXxevyf1qe5HQ3MhbbyfnSL5M/UuwRAeLWTeiK7dJXME47CnCKBMcnAB6gY2LxRUHNWrU5pF4ymWJzulPfpNw3hDO+cqooe5RSyzXJapuuurX9N5lkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=I+NpHRxY; arc=fail smtp.client-ip=40.92.42.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S281X6P+3KFWQVQsB9EgvrQxgoNy51M3XzWXKASapCsnLySjOysjdI2Qs069KbRtEsWPSXP5TodbLQ4FHhIzw/n7FCQZlOZmUSh1qt7GMmMvHBJSKIuuQNb2z2/Vqf0iAe8SPFfOsO/L2lo8+yx1MErATkIkwDYKArUtp9CT8Lzhtm5HawDWUgi4Z925WEGh2JXhnMT8mJIhlSn19OrWDFdbxRK9TFWQl8N+HKY8T46jAS3uD0NJxe/RrDxHTL/sMChX+zLWq79sjDTskm5tkoAQdtW7wtkMbpGx68r/gAlVT4vVVY9hoPoUWNZIEadYnojIIrWfFeNuUQCJJ77R5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcdzxLJ0DMpSocShLc2GYOKFHLxUPaWCKkbw198clNY=;
 b=nVe1Fl46OHvSMgL+11J8oreTao6Y3WM0lK2Jawp6wuYjxhF9HHpXJshKaz9EUB8U4UJjrMepOI/DfMlloAs1zcZ2NxI5a/51mrAGSuXaMdIdo1hoLO90rH4rsBRQgkupW9AS3f/qcrGUjSTt5DOdmqiCfqApQEsBfCE/GK4vzqtD1mqln4BaApa+bBG7qCD5uqOSe6vJp7bzVaq2g24F4U5AITypbJdgDH76jMQ63rQAI3TsiN1QzZiva7M3GloWtYwYbnjfgzgID0y+pH5BmFiaXGDc+x8vBMsBjr2R6bi8r262njJlthrAaQ7ZPv6dEWA3a881pDRXQczC9W5lOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcdzxLJ0DMpSocShLc2GYOKFHLxUPaWCKkbw198clNY=;
 b=I+NpHRxYnL6uQ1BLWuZ245mqAPk8kp9QE5jiXXIqffnCOezUfwR6/MrBfOi+ph0932dWpKpVgeaKVqqkSoJB6L5MRiiHOMoEvq3UOUP29RVAWH2I4rDi40O/CvhXJdK6BnttbYGf2Z1O8su1myUZYDTcugjv/ZRgTXypKgPUl0xepyOCR2gQvz1VaoFJkKBYmWZID88xUDTgmQAIStDBF6xMzG8YVkhOkr9rBsx76hSKTxFZr69u3MzbrekYNalQyFlDNgMo0kr/4O2CUv+A9WiO3LBl1kdGhDe3KyKxfU69RnnHdA9V8fWcKjDoOl3wq7rdJ+KvhiS4TJTw0vyc+Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM3PR02MB10273.namprd02.prod.outlook.com (2603:10b6:0:46::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.27; Sun, 31 Aug
 2025 15:12:58 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9052.019; Sun, 31 Aug 2025
 15:12:58 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH] mshv: Add support for a new parent partition
 configuration
Thread-Topic: [PATCH] mshv: Add support for a new parent partition
 configuration
Thread-Index: AQHcENr8Fd5MLCIhVEC8kLUNqDb1wrR86h4A
Date: Sun, 31 Aug 2025 15:12:57 +0000
Message-ID:
 <SN6PR02MB4157FE1A347214085549E72CD404A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1755588559-29629-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1755588559-29629-1-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM3PR02MB10273:EE_
x-ms-office365-filtering-correlation-id: e61f575a-9572-452c-1f2f-08dde8a0de92
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|8060799015|19110799012|13091999003|461199028|31061999003|41001999006|15080799012|3412199025|40105399003|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VeTpRqt/urczy4D0BjHHP+9Z5IryW/SgQA1xwPw+JRtVlpJuS6Nj9SaIpewa?=
 =?us-ascii?Q?YEiNWtVzXkN1g20tRJCrVKwhgJUW3WOa/nkd8JgwmIPJzHWwjqKJgUno02Xf?=
 =?us-ascii?Q?tObSFs3xZtAKvTogQVV4TByqDlljzzC4MjEQJoJQKGk/UR6iRi5RxxgTSW9o?=
 =?us-ascii?Q?q5N9o1rCzn/oPgAJcKg7AW/XCm6IXSn8/x7lsFVCITSTc3vnntazz5AMdhEI?=
 =?us-ascii?Q?J+mE6vQhzBMLLlfEIZeZf9Sv0tIns1rCDgW845DdMR/K8rSWCFXK+oLmPeUg?=
 =?us-ascii?Q?tf400Ssj438S8r4i/7cF00BYaQIns3MBkkqAzpy+5S6VgoDTkjgUnUAhPF9A?=
 =?us-ascii?Q?S+Eb77obScHf5fezfPL7q1s8C3AuyJd0RzhLnpjWgS4bA3jm+F7isXSfafpY?=
 =?us-ascii?Q?C4r6rFYWuazxc5g1qc9NuUxiAxrDWS8I62I2zPR99rCh58z8/adUlGTLTfd3?=
 =?us-ascii?Q?JwvUugKKULA8utghTYSfOhVXQiRY4vZrbv2Mv7hqxblhfeHpinZaTr79AZ03?=
 =?us-ascii?Q?UMM/wgw3v6hMPip6CATTEatrw5YTzRd3RCoQMSSDRG821S8A4OGJrafqfypf?=
 =?us-ascii?Q?ycH5nS4YX82htolDIJfx1hixm/11zK12N0zV9j+5DXvuuwEW7WOQZYpssLlq?=
 =?us-ascii?Q?D4aeVBctvUyYY+83DLo5SFQotUMOLk8XGoBUAl5Hl3Qat8jTSTeAjTiP/szd?=
 =?us-ascii?Q?bUGT6B9ZjlQ/YXDY60Z8R6fKwLMFpSC8bAvwzAVBI9embqgidOPWqre1E2Qw?=
 =?us-ascii?Q?2SdzUNFChQLqVWMUfh5I2Z908tucvjMpQyXGnPl/pvNUm8ghUswyuTVEYiZo?=
 =?us-ascii?Q?KCg+sOmbfW0Kom/eK4Ig2e+O6VSchOOzxTNPLjwf8n9SKEJeP/oxd33EWpNo?=
 =?us-ascii?Q?qFYTvLaHqGcR3gMaq3vfnt3d0R8R0q8PrF0F3Fl05Ps52v7TDsEWfhJ+FCho?=
 =?us-ascii?Q?U2XsJXGipnQwHmkqP09qnJ7he3DH2ILur6fwh/Cmvzlh91cZA+AoLYfpZeaV?=
 =?us-ascii?Q?BkVBVABCO4bkoiwCvA+Y5wUUNV4zGQHrAc+0fF+4uCKA5TaWEQz6bcxmCFBo?=
 =?us-ascii?Q?ARvzbCslKJb/JH97BnAypjIjdTuycKnKGEW+A0xlfMXXteyp5EzBb+pZsFo6?=
 =?us-ascii?Q?F18KITK9kn2VY1GTsR/HrsRUINkSQNWcw8DaXVNvVdzWTM1gcNjvzn71Jru1?=
 =?us-ascii?Q?/ahOIT/NUC5CJbCnKokaBWWTajhOw/mB/3rdnQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YD5hBoumqmobIlRtb/9gXQej21UMcby4D5wx5j/ATdBLUkipT9Y8xQssuQsW?=
 =?us-ascii?Q?RSFaGwpVdZC5zyf4Zo4h0H0rINv/pLGLXaEMk9jARWOCXZPMUakpEO8Ww1lw?=
 =?us-ascii?Q?yN08FU2B/SAUqk+3hmTdQrsrmRjOYQT6rDnS2HQSovCSPQlUpb7tLQgQdhdV?=
 =?us-ascii?Q?zwPqZZIMUxpj6zSvCCWmlL+slJn30uFalh0NzHnvTp7dOeaJ/Jvjn/z1bfMp?=
 =?us-ascii?Q?HLcZh7wdmIN7t9GflhMoYtkfXAZRuRwPjb22NH+ahZpb0C+6DTnqZxszlLXJ?=
 =?us-ascii?Q?dPCmmOCK+R2gIO2xLi7Aerc7xMVk2CXp1hixEsu50IfTFLsA3x1b2vyBPPYj?=
 =?us-ascii?Q?Y0wawPOKQwcFbPFcvgkDVy6VLcZ72oHRJfCkm7iLXbeDJyPeZ8DD0T4hUJbD?=
 =?us-ascii?Q?0G/b1axZVE540+sjsMb74L7oPRDR2xwgI0Xc/TYoxdvhCfQvmMBRBQYEXg3H?=
 =?us-ascii?Q?lTHTcYQwNgs7iP3D+NNMQe5f5xK75ddaU4vUIUSTjoZqOcX1VNKFl9KvqDPO?=
 =?us-ascii?Q?jUxki9C7t4WSNv9Xazzq96KF6/GSYLZOGVh6qRreoL5nBhcwICJwfbN4si02?=
 =?us-ascii?Q?2hSkY84E/R0n7LKhEXn3ymtWLxs1TB491IWQfCp3XyngsUH6Loov0dpijAO6?=
 =?us-ascii?Q?338U9IkdigowxgRENPfHnREreUYLwhsLp7C59o2nSiVR+YLxjIOX/i915aQm?=
 =?us-ascii?Q?w8VI1J1ohM3k93KJXNZWql1bXWxJEtXQMHaN8ZDZmAYt5vTyGW1GjuGvaB/4?=
 =?us-ascii?Q?IpDSVeqgBP1Esny3/eIxSIsFqhMz/EOAiAqAYasSiuOP03eVl2+pOa6dQjd2?=
 =?us-ascii?Q?34UvNEuIZf4VG0gw7vKbwRd86fkih0ANwBLwUfL/FZ5DKXZchv6ofaO/RzID?=
 =?us-ascii?Q?/v3jbQRh+wuqPhoV7mvGIMfEpgyPxWOPw/JB8tsC1xWSGfPqcdEKv0iKqyky?=
 =?us-ascii?Q?Je4Z0iC7aVEdZb5YBk9cfz80kv28+AyUwuLtJ9crVI2W49AV2vwseuersuje?=
 =?us-ascii?Q?yeXD82EcLqPfKlyXdc5R3McagbGDvr5CaNU/ZH7Oi+GICAmNs055CZeG9t1a?=
 =?us-ascii?Q?ZKr4PmVng29tNqjeylXV9QLrLaziX9m829344AsHJS2+nFkfw5D9MjDeFJu+?=
 =?us-ascii?Q?z0peBq9BOPSGVKAYoby+15S7F98wQ0u7NtXg0BBfUsNK9YR0ytwgV0UHOifv?=
 =?us-ascii?Q?lKLSye4hKPU8psXhC7hBXnN8VDE6jt5c60xgf3oeQsgc5nhMi7echjbLPnw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e61f575a-9572-452c-1f2f-08dde8a0de92
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2025 15:12:58.2779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR02MB10273

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, Augu=
st 19, 2025 12:29 AM
>=20
> Detect booting as an "L1VH" partition. This is a new scenario very
> similar to root partition where the mshv_root driver can be used to
> create and manage guest partitions.
>=20
> It mostly works the same as root partition, but there are some
> differences in how various features are handled. hv_l1vh_partition()
> is introduced to handle these cases. Add hv_parent_partition()
> which returns true for either case, replacing some hv_root_partition()
> checks.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/hv_common.c         | 20 ++++++++++++--------
>  drivers/hv/mshv_root_main.c    | 22 ++++++++++++++--------
>  include/asm-generic/mshyperv.h | 11 +++++++++++
>  3 files changed, 37 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index cbe4a954ad46..a6839593ca31 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -357,7 +357,7 @@ int __init hv_common_init(void)
>  	hyperv_pcpu_arg =3D alloc_percpu(void  *);
>  	BUG_ON(!hyperv_pcpu_arg);
>=20
> -	if (hv_root_partition()) {
> +	if (hv_parent_partition()) {
>  		hv_synic_eventring_tail =3D alloc_percpu(u8 *);
>  		BUG_ON(!hv_synic_eventring_tail);
>  	}
> @@ -506,7 +506,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	if (msr_vp_index > hv_max_vp_index)
>  		hv_max_vp_index =3D msr_vp_index;
>=20
> -	if (hv_root_partition()) {
> +	if (hv_parent_partition()) {
>  		synic_eventring_tail =3D (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
>  		*synic_eventring_tail =3D kcalloc(HV_SYNIC_SINT_COUNT,
>  						sizeof(u8), flags);
> @@ -532,7 +532,7 @@ int hv_common_cpu_die(unsigned int cpu)
>  	 * originally allocated memory is reused in hv_common_cpu_init().
>  	 */
>=20
> -	if (hv_root_partition()) {
> +	if (hv_parent_partition()) {
>  		synic_eventring_tail =3D this_cpu_ptr(hv_synic_eventring_tail);
>  		kfree(*synic_eventring_tail);
>  		*synic_eventring_tail =3D NULL;
> @@ -703,13 +703,17 @@ void hv_identify_partition_type(void)
>  	 * the root partition setting if also a Confidential VM.
>  	 */
>  	if ((ms_hyperv.priv_high & HV_CREATE_PARTITIONS) &&
> -	    (ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
>  	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
> -		pr_info("Hyper-V: running as root partition\n");
> -		if (IS_ENABLED(CONFIG_MSHV_ROOT))
> -			hv_curr_partition_type =3D HV_PARTITION_TYPE_ROOT;
> -		else
> +
> +		if (!IS_ENABLED(CONFIG_MSHV_ROOT)) {
>  			pr_crit("Hyper-V: CONFIG_MSHV_ROOT not enabled!\n");
> +		} else if (ms_hyperv.priv_high & HV_CPU_MANAGEMENT) {
> +			pr_info("Hyper-V: running as root partition\n");
> +			hv_curr_partition_type =3D HV_PARTITION_TYPE_ROOT;
> +		} else {
> +			pr_info("Hyper-V: running as L1VH partition\n");
> +			hv_curr_partition_type =3D HV_PARTITION_TYPE_L1VH;
> +		}
>  	}
>  }
>=20
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index aca3331ad516..7c710703cd96 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -37,12 +37,6 @@ MODULE_AUTHOR("Microsoft");
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface /dev/=
mshv");
>=20
> -/* TODO move this to mshyperv.h when needed outside driver */
> -static inline bool hv_parent_partition(void)
> -{
> -	return hv_root_partition();
> -}
> -
>  /* TODO move this to another file when debugfs code is added */
>  enum hv_stats_vp_counters {			/* HV_THREAD_COUNTER */
>  #if defined(CONFIG_X86)
> @@ -2190,6 +2184,15 @@ struct notifier_block mshv_reboot_nb =3D {
>  	.notifier_call =3D mshv_reboot_notify,
>  };
>=20
> +static int __init mshv_l1vh_partition_init(struct device *dev)
> +{
> +	hv_scheduler_type =3D HV_SCHEDULER_TYPE_CORE_SMT;
> +	dev_info(dev, "Hypervisor using %s\n",
> +		 scheduler_type_to_string(hv_scheduler_type));
> +
> +	return 0;
> +}

I'm a bit late reviewing this patch, but I have a suggestion. With this
function added, setting hv_scheduler_type and outputting the message
is now in two places:  here and in mshv_retrieve_scheduler_type().

Instead, check for root vs. L1VH in mshv_retrieve_scheduler_type(),
and either call hv_retrieve_scheduler_type(), or force to
HV_SCHEDULER_TYPE_CORE_SMT.  Then the rest of the code in
mshv_retrieve_scheduler_type(), including outputting the message,
just works. That puts all the logic about the scheduler type in one
place.

Then move the call to mshv_retrieve_scheduler_type() directly
into mshv_parent_partition_init() just before

	if (hv_root_partition())
		ret =3D mshv_root_partition_init(dev);

mshv_l1vh_partition_init() is no longer needed.

Independent of the suggestion, everything else looks good.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> +
>  static void mshv_root_partition_exit(void)
>  {
>  	unregister_reboot_notifier(&mshv_reboot_nb);
> @@ -2224,7 +2227,7 @@ static int __init mshv_parent_partition_init(void)
>  	struct device *dev;
>  	union hv_hypervisor_version_info version_info;
>=20
> -	if (!hv_root_partition() || is_kdump_kernel())
> +	if (!hv_parent_partition() || is_kdump_kernel())
>  		return -ENODEV;
>=20
>  	if (hv_get_hypervisor_version(&version_info))
> @@ -2261,7 +2264,10 @@ static int __init mshv_parent_partition_init(void)
>=20
>  	mshv_cpuhp_online =3D ret;
>=20
> -	ret =3D mshv_root_partition_init(dev);
> +	if (hv_root_partition())
> +		ret =3D mshv_root_partition_init(dev);
> +	else
> +		ret =3D mshv_l1vh_partition_init(dev);
>  	if (ret)
>  		goto remove_cpu_state;
>=20
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index dbbacd47ca35..f0f0eacb2eef 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -31,6 +31,7 @@
>  enum hv_partition_type {
>  	HV_PARTITION_TYPE_GUEST,
>  	HV_PARTITION_TYPE_ROOT,
> +	HV_PARTITION_TYPE_L1VH,
>  };
>=20
>  struct ms_hyperv_info {
> @@ -457,12 +458,22 @@ static inline bool hv_root_partition(void)
>  {
>  	return hv_curr_partition_type =3D=3D HV_PARTITION_TYPE_ROOT;
>  }
> +static inline bool hv_l1vh_partition(void)
> +{
> +	return hv_curr_partition_type =3D=3D HV_PARTITION_TYPE_L1VH;
> +}
> +static inline bool hv_parent_partition(void)
> +{
> +	return hv_root_partition() || hv_l1vh_partition();
> +}
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>  int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flag=
s);
>=20
>  #else /* CONFIG_MSHV_ROOT */
>  static inline bool hv_root_partition(void) { return false; }
> +static inline bool hv_l1vh_partition(void) { return false; }
> +static inline bool hv_parent_partition(void) { return false; }
>  static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 =
num_pages)
>  {
>  	return -EOPNOTSUPP;
> --
> 2.34.1


