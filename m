Return-Path: <linux-arch+bounces-10265-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CF9A3E4E7
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 20:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8EEE3B9C65
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 19:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAED24BD10;
	Thu, 20 Feb 2025 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TBDZQGk0"
X-Original-To: linux-arch@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19011026.outbound.protection.outlook.com [52.103.14.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A92B1D5AA9;
	Thu, 20 Feb 2025 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079056; cv=fail; b=cJgmSVULNYfKVPePLoItkkG+P0CJzu0a51pAOSTBAL6yYvTM1b57k7k9MuyWMcac3HNNDyqqzDDG0ukwLNDYNzChiTmTc7c39mhQkE0c7DUJqkGNxW+mSxfq3lBRFYJO1d4O6sokwXPd4A58Kzkmh7Q1TpORrmhUE9dHEcjdD3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079056; c=relaxed/simple;
	bh=sLnYMfPLx+fVppvJGE0TsNyF/xldkQtzZVO21To2IcU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WJ3KUT98kNed6l8vB7vZb9x0BPW1Hvsv4ST9xQ8nzBOcbQJIwZcnef+QPkccmljKWUpm0P2037YMP5LxfLFYLDVuIAMtsQapnGPivp21KVgCWJcGQSL6AkIHSR+YQMBg6XtGApOtc+Zd6WD4p1PaKelzewSWUrcY7dshRAGWjBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TBDZQGk0; arc=fail smtp.client-ip=52.103.14.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lq0xwQHdszb1j7kLcMmlOToLh6Erp0PEFdQAZDPD6zyzmVH6mkctLM2dMoOqZYva1p3vqsoK0wyyuZFzhF1GmiPfCDOfDsjw+c/AzypgfTuHLdLA16d6PU58b3SQVqkF9C0cShmbJzKRKovUZZBVLhtNWhg1TaNk3e16YzsKyfsXsWwLYzkb/Dmi/BS0jP8TzTRrBGTEpjxXqWHCa+oEoxPKRLn0nj+HkLQOutEhJFgnW74sG7chCbOWrRhQJEeSflBnirM+xK0nrGeid6qpSlY2NSGE+fztH9lukIPNCrRCHi3wL9KDgJgWI3gL+DUa4xtdT4Ip3GiO6zH/ZU1Jng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCtd507hDoBNZgSvuLhknUfVv9YoAFAynQ26aDpHvYA=;
 b=DBOWYfPmWonH15Xve8G0BLe7lg5MTxcfTAaBcMzXYCbwt8OQU2Yvbjm3vKez31iaYXDXzm/VSjHdymwL5IpWH1pZuzsnPfAgo7XFCeIU0lmT5olYkeYINZoSZqYR8M9lQhDChsRYoqDJ10cbM0kePNPFre6ZVzBr43aS7Nio/URpEfV8Yuf1Iu6vfjXCLhIGsOVLLFiVO4NMzBf5k0zvYkMyblMwVNWpLkVhy6XovXqgOpprHWes1smOyO9kw1/g20EZxG7Bmszczhw/pXlG71NTBId5FroxlQzm4LifktxN6IHVb197bF3PqHhgCqcTG96zMcpaEJ0MKNPnCByndQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCtd507hDoBNZgSvuLhknUfVv9YoAFAynQ26aDpHvYA=;
 b=TBDZQGk0T5CfUyvx8RGNKNVy8cfI0iqom+4UgRFA/RzvTDQfJ4LK3fqfLO3TgsgdL9qtKgLvx2bpV63DGyMIjxPjvj5GLIcQU9Jqgu0I95PoFmgzrXOllLy2hN/Mgkk735F4BfuZdDVjvH31MZOPJZo3ZKaS1dQzOA0AEiEdET7sOMAlQfLyuADkTjwfWx1U7bcV4CkTm66oOJm2+UpqaRXgCKRGORx8qJcbE7RfyPFy2HrKL3/Ch008M+Oas8T8DBnzNgqu6sGcLkd98ylAljoDvMOqDeCznp1qoKcMt5HlAQAIrbsFL40GTDyTrvJaDZbcycuzqlQw4cWrPw8srg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ2PR02MB10074.namprd02.prod.outlook.com (2603:10b6:a03:556::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Thu, 20 Feb
 2025 19:17:30 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 19:17:30 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "eahariha@linux.microsoft.com"
	<eahariha@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "jinankjain@linux.microsoft.com"
	<jinankjain@linux.microsoft.com>, "muminulrussell@gmail.com"
	<muminulrussell@gmail.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>, "mukeshrathor@microsoft.com"
	<mukeshrathor@microsoft.com>
Subject: RE: [PATCH v2 2/3] hyperv: Change hv_root_partition into a function
Thread-Topic: [PATCH v2 2/3] hyperv: Change hv_root_partition into a function
Thread-Index: AQHbg8X2g5fV4Yu1ukCIC60YHbLA6bNQjmoQ
Date: Thu, 20 Feb 2025 19:17:30 +0000
Message-ID:
 <SN6PR02MB415703DF0CD1EB3523E3C79AD4C42@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740076396-15086-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740076396-15086-3-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1740076396-15086-3-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ2PR02MB10074:EE_
x-ms-office365-filtering-correlation-id: e8958fc8-30b3-426b-6813-08dd51e3387e
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|461199028|8062599003|19110799003|8060799006|102099032|3412199025|440099028|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zNqfils1DyoCfafpuqVJFrje43JoyOWkilVmWYtzkzE7x/zBTF8K7gVGYZ/2?=
 =?us-ascii?Q?8Q95pQ6fbLSuHJO1hYD/Q+Zr+pRYijO316pfxMt3xI0k+RDxnZCkCtOnonG+?=
 =?us-ascii?Q?MyVzM9+9/twkEExAaSyqXXMPxrFpB+I1fN8lxzh5Lh92Zqt/MzjWslfju4KR?=
 =?us-ascii?Q?I1SBUhsG4YnZazeMo+W9T/2Ci7I7PmhALoK6OJVyTGSOxqc/Y0j38Gwvcqnb?=
 =?us-ascii?Q?0dE4mmvYHRcG4N1CRlfAVI8RMnvulTSHVe0YDaueGTkmaYiC29m15Tge8gDD?=
 =?us-ascii?Q?FFfM3fzRe2W7SFOVW9TX0TWBgI0/y9LRmIP6lfM+TztOLf1dfRU81CXo+VP8?=
 =?us-ascii?Q?1VkjKV4zqlUzGTwc4fm2VNhawoM40atLxPhGAV564riKomkEZ7RwI71oGqch?=
 =?us-ascii?Q?SWxHw1mt47s7uYcjwywrNKW+OcFvA3PbEXCAOr1R1BD+99s5q6pA+8VGc/4P?=
 =?us-ascii?Q?MFicvZ2d0/JQ9PX9rAt+ygBO+Uhuu8f6aVd8F8tx2FpbNOEqO3M6qoa4n370?=
 =?us-ascii?Q?jU3RcI9tMYBxb4ipUCZW2+XjyR7REHgJyXsAcvPfl9iz0BqyYDErJQhj6ypZ?=
 =?us-ascii?Q?IwYzmPw38ViHndWI33Q8yNDznCQD5U1Xef4KDk/yXQNXcu6/w513U1Q/j3nD?=
 =?us-ascii?Q?PArvUo2M9kJPxRigrRDxbPOHg7keaasaklm1bN+gxRxXncY9Un+O8w6oPv7R?=
 =?us-ascii?Q?OffajJCRbfaKYh8mTs6MkQmR8fIPOSWAiTnNLiVquWWJBpikYpE61aDPFxii?=
 =?us-ascii?Q?xMhd3WjXT0RaVvaLVQUsYuEqKkHr11lwS1G3hKxFFvS3l+FFUCuaNUNUBJJm?=
 =?us-ascii?Q?F6X5Slilo1QcI0ytdcwzXE0ANdkxss3L4EP6vzeWUSblcrBLVGixtUxWlX01?=
 =?us-ascii?Q?xjYyxhjK8jOzVNW5g6flmUm4GfgECfrMsl/W13uVJyXQmUXxiFeVKvcgSFr9?=
 =?us-ascii?Q?Vwa8t/18Dwg6Bu3p+wt+5KeddSf1DZmffwtWIqZI20+F7TPQ3brte49p8ej5?=
 =?us-ascii?Q?+zzxDysJ5jG78AOJdQtqqg5IQFWoYYf6UvkFYptS82wVz8z+vS/Ox+oywenC?=
 =?us-ascii?Q?HeYsc8uXIlzxQRP4SXEAufEFN1iJOA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oeN7jIVc4DYpdqi2JPtfnIPkNClRwovYUIwJyv/e8vGQ7uFiei2hi4B1wY93?=
 =?us-ascii?Q?FxvuogEmlilmNB1klLi6i92tzRCUkYWoppHF/OvcwhO1VjMJ963XCYyo3/Vb?=
 =?us-ascii?Q?1pDO6CYwfEnO9onz65v0pSVt9FIRFghU28eTZMWjpnXzU6hzTxk+7faVlJDW?=
 =?us-ascii?Q?Jke01MzGiYWrPdWrja/yQUkLZkfw1+rAduveAmMhPRKCkJtoVXgT/gK+WFxk?=
 =?us-ascii?Q?ZnzfkuDfTjtQhbLAWmBtmR5eDq/o3IPfj68HsRhU7SKEHzoDG4aKPBTEoyTU?=
 =?us-ascii?Q?htEt2LfeLoj0MrHwwe0KI88atwWvWe82vgQ/Ma5r4cKI6W13gGIlcU5VZhBC?=
 =?us-ascii?Q?0tuWATALeImmgW5Ih4wS1ZbQSNwm0ADpDyw0r81Y184YAk4sQax1MnnQ08+w?=
 =?us-ascii?Q?KZC/0jigSUBvZjrTbGhb0Ri/4j3kd/YOERDsVsfeunl1FsGuu/q9txrk44Y6?=
 =?us-ascii?Q?Iz7IreIh6sWy7zW2S1w8uzQWHC0USDtjnxGDTYH0TlC1+LXdtPCyJ2WjMiLj?=
 =?us-ascii?Q?Ql+CK2OGW7J9IxNnyPnOU2WApdz4X3fH++WHfAoFfkZ1KVMI3+/pw7FYUwH1?=
 =?us-ascii?Q?qNIL8EAbeWwrO8flkm9BKv7Qd4Q5KWvbxqFAJjrkDTtzZAuNIPCxctbmZnZP?=
 =?us-ascii?Q?xS23NlRsCxsYj737e9yBRfW/qtDiY+i0ssNXA8ihaumDJIqgb9B68rIBHIiI?=
 =?us-ascii?Q?g5XdKbVnkL9gIVp2/VXOfMui/5WUNhu0KYrjQWJb/dVT+myhM6sxqVqblp1y?=
 =?us-ascii?Q?fizMosDOeWI64ON33Bz/FWXJT1Wjgn82OcY57eLtU6Nux21792HhB5QMvRW9?=
 =?us-ascii?Q?8BfzPylnJ8CUuZQzPekEYQc62Cz3jwuLXadrZvRjkMVelRzE9kZjwmn8TqnN?=
 =?us-ascii?Q?bln0Zr/aH+6eUGJMHbm/zWMC6DhFUbzv3OxwiSCtwCdFchpsJzGis9DdVwY+?=
 =?us-ascii?Q?cLCfioj6cmVg4S354DdBR6iUznn6Pl+hnPF7R7+76/Kagl+J13it4tBRubbT?=
 =?us-ascii?Q?TH2KYGAuVN3QcrRreZo5B0l8oCcBPhrSDiJy8fAxt2JkMvsqFDP3f2ybBZrZ?=
 =?us-ascii?Q?bWwykKdlfjV6s5++UfqbYhf9cvkToTYm+YWKK/iK43xnWPzMDER2dEB7j168?=
 =?us-ascii?Q?QR0fUR7ttwl7ntr0ZvkypYRV4Da3IeLtbGys/Om9jkBTzCfYbMuTicSXsA+8?=
 =?us-ascii?Q?pL9F4qFShZfjDuyT1iEHaxZ6cyydelpBoxDMKzDP6HoLVEOPDbrsRgldeJE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8958fc8-30b3-426b-6813-08dd51e3387e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 19:17:30.3267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB10074

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Feb=
ruary 20, 2025 10:33 AM
>=20
> Introduce hv_current_partition_type to store the partition type
> as an enum.
>=20
> Right now this is limited to guest or root partition, but there will
> be other kinds in future and the enum is easily extensible.
>=20
> Set up hv_current_partition_type early in Hyper-V initialization with
> hv_identify_partition_type(). hv_root_partition() just queries this
> value, and shouldn't be called before that.
>=20
> Making this check into a function sets the stage for adding a config
> option to gate the compilation of root partition code. In particular,
> hv_root_partition() can be stubbed out always be false if root
> partition support isn't desired.
>=20
>

[snip]
=20
> +void hv_identify_partition_type(void)
> +{
> +	/* Assume guest role */
> +	hv_current_partition_type =3D HV_PARTITION_TYPE_GUEST;
> +	/*
> +	 * Check partition creation and cpu management privileges
> +	 *
> +	 * Hyper-V should never specify running as root and as a Confidential
> +	 * VM. But to protect against a compromised/malicious Hyper-V trying
> +	 * to exploit root behavior to expose Confidential VM memory, ignore
> +	 * the root partition setting if also a Confidential VM.
> +	 */
> +	if ((ms_hyperv.priv_high & HV_CREATE_PARTITIONS) &&
> +	    (ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
> +	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
> +		pr_info("Hyper-V: running as root partition\n");
> +		if (IS_ENABLED(CONFIG_MSHV_ROOT))

I'll have to rescind the "Reviewed-by:" that I just gave. There's a patch
sequencing problem in that CONFIG_MSHV_ROOT doesn't exist yet.
It's added in Patch 3 of the series.  Because it doesn't exist, the
IS_ENABLED() will always return 'false', which isn't fatal in the sense
of causing a compile error.  But the code won't run in the root partition
because hv_current_partition_type isn't set.

Michael

> +			hv_current_partition_type =3D HV_PARTITION_TYPE_ROOT;
> +		else
> +			pr_crit("Hyper-V: CONFIG_MSHV_ROOT not enabled!\n");
> +	}
> +}

