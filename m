Return-Path: <linux-arch+bounces-13633-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 037DCB58409
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 19:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4351AA6C94
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 17:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796C8299923;
	Mon, 15 Sep 2025 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rM3/AI0Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012058.outbound.protection.outlook.com [52.103.2.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E7A5C96;
	Mon, 15 Sep 2025 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958873; cv=fail; b=Qn7YHOrwZi4glXhwYtzPdGxtrXP/SiPFC09tHEs1fJW4OT+s4I3FUtIZeglRCV5FKBg5fIQhKIG0abEhJzBl1Y2+Zy7BlYKaYPyLb+CNNnTSuqQcEe4fh1nRcokXkJ0u98WWiZO8pxI3HhR76VrzVML5Ov54iR6CDHn+JR520kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958873; c=relaxed/simple;
	bh=FJmQOhgKJ0vhlGNCUbAW7GrSuMkvszsLX0eu38ORwFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TGaCGt/y3SwJ9zF0TcNYl9x2qMbqhHqe5VFSslyHa7U7h6SivJ6Tk7U2utNwidFKn6nLDX1YfQWFNeWLUWKPVioL9QdIvl9kGSYtucTGerhLaROYdO7TSOP2NUb2HVtPVyR7jGt2g5lO/peK8P98UqxDkgOV5uuGgz5bGCAu97U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rM3/AI0Q; arc=fail smtp.client-ip=52.103.2.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWZG/z1aNG28oZ7AWELeUw8w/XcdOYoc0XN401vNBa/zIQgiMjRjKcJq3YL9pGxcK3cV5ayHAyvARzmBxiRgB4jqKRS3YLgasU4YcLBOwa9htwr+dVf2Whq3EU7ymrHxS033jircPdo485SseMvX7AcQZ+p42ZBs7zg8ZFrcvtdXcn3Asb9c9zN3J4Y9UG7LpmhHPA0agyJ+BKs4otY9cyn2wz73bHua3NBtOg44fpBF1Zxam2FNSyGLHibpdACZFmpYXghWm83ouOwzgz8K7GyPl1XLN6zzRcT78xmWmmH3Dcjw8dbu6RnSxSvPnzAAE0h5FgJ+XkZzmphFcR7F1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1m9xNZQTA7gfVUifKCmT9rjSe2I9HJDK5/NzpaW1Yx4=;
 b=pJpwsiVtPaz00P1VJAZA2m5C4iRexm3LQsLRXX83+VQ0i7cSFN2yRUUwURwpca9YaykCNyV4MdCWPcoH1f6FhlhZo9wE55tAaEhI1EpaQ+NUYUzvpfA1RaHXbaqep74YJApoJsK58x92fLGM3El72rwrhvTVh/saaaK1bbjqrR2hP2+gL+hpdPIP/f+yv41AP53QEvDueOQuW0Rb+WWwccjcWJxcxIGDZHr/XJvXSFS54BUX+fpJu8UYXOVLxF5lU4AfYU45BG7twCxhMEzvAUdGzgpmRNWcBwzi8+5TwVOkj+n0ScG5YRGwfPH+lyPsnkxw2BVRp2+XBP9bKesOaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m9xNZQTA7gfVUifKCmT9rjSe2I9HJDK5/NzpaW1Yx4=;
 b=rM3/AI0QghFl+seE+niVb73GePYynomw6ZcYzo4BDbcMA2oRIzJCyNkMR/JIe/oQbgArTkjUgro4qtuTJlrVAs0R84Up1l2Y0v5UOQUHMsB0dBlMaoek0OrtEPGecvZSf/3o+DLCC02QBZ/Fbh2nE3mccaS+ddQS0QIqSFPnOR2Igu+d9Rt09CB3dZ6wFew6E5whQNG39kSvUiBKgrdcAoRTXimnSHh7bdfxcF/5xI3Ivy0p8/4mVsdUpjSpsOVrcHVCIpcT++W/OhlH9wkdu703U5SNKF0gMen8cLXPAckMKo1RcANoGQkfmbvo/hm/KZOqp8fmlQWlWdg6n5pVTQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10056.namprd02.prod.outlook.com (2603:10b6:408:19a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 17:54:22 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 17:54:22 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh Rathor <mrathor@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH v1 3/6] hyperv: Add definitions for hypervisor crash dump
 support
Thread-Topic: [PATCH v1 3/6] hyperv: Add definitions for hypervisor crash dump
 support
Thread-Index: AQHcIed8M0Zuk7Pq9UqlkAFRSftZ8LSSw9+w
Date: Mon, 15 Sep 2025 17:54:22 +0000
Message-ID:
 <SN6PR02MB41577F7E862976DE192DB9C0D415A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-4-mrathor@linux.microsoft.com>
In-Reply-To: <20250910001009.2651481-4-mrathor@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10056:EE_
x-ms-office365-filtering-correlation-id: b600b8ab-26e4-4d76-9e3e-08ddf480e707
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|8062599012|8060799015|461199028|19110799012|13091999003|31061999003|3412199025|440099028|40105399003|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YmiSXC5FbWlmJe23b7gB4MyQLwckxwpJHvD+txzOeeaKCC2BJJVR3Ge+nT42?=
 =?us-ascii?Q?l/LGxG9fTsd6MyypIHZ5kYoAZ2HOR1orGE6x8wLHP+xnR18Hum3vU1F9zfwE?=
 =?us-ascii?Q?sz1qJDG+/iYUFQpJqWBuQ9MpLAa2iV9jJSEHuaOaldTHrEGHj5IAD654wMIm?=
 =?us-ascii?Q?OXLUOb6FZodNoTjvzyZ5wGg+0YyVySbfPxkT3JkA/Jy07RfAFXRuzxn7EmXC?=
 =?us-ascii?Q?y9dBq/Hm9SPEOsycs5rDCx0fUe8CpbOtRLSzDkUSRlUrb6XeyrwErte1FJxL?=
 =?us-ascii?Q?2JDBlK2vx6Tf/j5gwM8s2EadbYQKxP0/fIeWC07yrlpxr1XN5RU3DnHWMvMc?=
 =?us-ascii?Q?I9ndLR9XHJ8mrcj4eAhrGr9NiQ1i0aKScWTdMMO/CAZOcbNSzQBkZC6ofWrL?=
 =?us-ascii?Q?cmR7m9/MLuI8wynS4WpRDSVaR+3CvqIG/AE44M/Ek+akqs6VoWptscNbveUM?=
 =?us-ascii?Q?VwU8InwX5homhbpTdsYQrBgjYoUWRXiOhjE9vsv+0/4zy1NLB7B5SP+R19vV?=
 =?us-ascii?Q?TTnar8chUbAeVZpJeHvQmzk0Y1Q8k10Ed/xJ42Ht278tfobtV1tmc5SXctA4?=
 =?us-ascii?Q?Oa6XG6vJa8G6i1nWYuVXYblGwk+d1x/B4IKwV66cldCRB0aM8UEOmPRgXGKC?=
 =?us-ascii?Q?fLYaKg2vvt3hOZzl9Y5FGQvCC+N9A8j41ftx1yMuY+pw/43WtUtnm/XpCQUL?=
 =?us-ascii?Q?R3gIpa3wvqr6WGXrLmnOCaYgkFQVsuclyp96ujQkdptJ2WnP29vmerLgnsuP?=
 =?us-ascii?Q?SUNsiEGBc04HWsx7MFUsl1RC0FLqaLqM2BrzyzJrLoBneBdq47M8A9kwvxgE?=
 =?us-ascii?Q?ofNhQuwEgqAsjQzrNxae5Va+VQfWr7B5IkfnO7Y79JrgV2WUTLi1tC6G6nJl?=
 =?us-ascii?Q?N06iTfBOtLSfP3ZcB9lfSyNasphpnyb7VawsGNB1GhbV/oyLeIz42z9krN1h?=
 =?us-ascii?Q?VFrOhR2WiwA2l3Bmm6bSEQPWEV+4Wuo4RZIPXcI19iatLrJDU31d/6EH6ZZ9?=
 =?us-ascii?Q?o58iyq2O5XFK9NwirtCjCfQamlAoEAmcw0R9uDU0C5ImffJ/hpuhNg9OjWTZ?=
 =?us-ascii?Q?+kG+uRv1Lv+cAbol+KRTCKV6+AlHmLqCO6lyffKK+xDaTi3trrmXmpK+A9CP?=
 =?us-ascii?Q?SM8YdDa0TJSVwFcXRdxbn6Dy5tdTrQ7zvX++AncTbK/dTqcbJ3NHUKk6VAa+?=
 =?us-ascii?Q?tvmQwPY5BZOkVli54ESHKPCkbuABArLHqufTqw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KruHmrAlbFoJwQKN3rwfCvGimGlc7yIQNGGqXs/csI6iIp9O2ZyeLqUBJyYG?=
 =?us-ascii?Q?TcnGYYezyD1srRMYDLceF70yJyf9Bhqu2BUfmYmHo4jXGQVyuzwhl2gbq9WP?=
 =?us-ascii?Q?2wDuelz+jnwV13+vo3LLq+4bZDrFgrwCZpoWuvkXqviMxSuVq/QyIayiNFeM?=
 =?us-ascii?Q?FUXaBV1+OBOZngcKPhv0rh2Bd+TmlnIOfUlc8cnpuKEi4NNjM9C7Fzt0hoYw?=
 =?us-ascii?Q?FL4VyLHtaDhZ+SQjwpA7ekJuW4PgJ5b4rtQiIfMpKrIZO1jrDVrCme1nCX/W?=
 =?us-ascii?Q?W37slK/gDRZLtLv5RyABlnoyliuUTw1p8A+O4qVvZshqVwoY1ylWYrTSOift?=
 =?us-ascii?Q?vYMVruUir0DdkXnJsaUD0UvhGFPg5x2vgCO8lWnipXA1BnaLec/rlrCUUeho?=
 =?us-ascii?Q?V4zQ8z39t1tiB+JKMRMZ+J/ILz/4pkDhdSuIV3ajdRTdd/H1evIOvr6hn/Ov?=
 =?us-ascii?Q?f00UvyqqNaQ9nSVuOtymxQwECTEmSwQi3IXtyzDv66HujQjRQoTtKX1Wsa3A?=
 =?us-ascii?Q?kfPyEruYyqPitmxtId2nADWqoX82LDtYAeRi3tqg6OEeD3TNuIRTIM1oVfJA?=
 =?us-ascii?Q?Kgh8ynxgocI2cPmu8arNlDlW7aElqstcL6T7TYsCeakWKcZXNwmHwez7L59m?=
 =?us-ascii?Q?VMJNp1/wPe1jywS31g2SJuJ8yYMeA+npLyiLdWMAevTyKHmoyXqeJn5P1IWZ?=
 =?us-ascii?Q?ZSvbROnuv/SB6/y++Hb9378IfqykLXzxrPo4A9Qu1JO5qA6lHtGFu9lGIEAd?=
 =?us-ascii?Q?caktXs1S53yuHE7Mbp8wJkhGnMaHWfxSb/2ezpUR9dh628ZyUmPsv0M1vpvL?=
 =?us-ascii?Q?H5rVxFwfBMuFDQ9Ol8aV52K90ZEgmlFd0sbG1lHATeMRlQnZ9aiWcNcrmv4T?=
 =?us-ascii?Q?SlqJ1ZA9LUJd25UES6H+z0+C/KDZL2MegZHtrJN19Fb8/ZNbnfjY4qokanyY?=
 =?us-ascii?Q?ahw2Baxv9ix8g5KAH4h1MmFF3hauTbsGF+sWxdqI1g5MTR66xLIbLJl5Txo8?=
 =?us-ascii?Q?ZJ9V2l9zFDmDHeq2UJSIQdbVoiH8OCJh9mTX1TkrTppQZT2blyWMoXbh6T8m?=
 =?us-ascii?Q?NGh/wzgZi+Ol2BJJKW1kB/Wa6J7cH/5wMckGGSSGnVDiCTD7KFRcDcNyWTbu?=
 =?us-ascii?Q?1wBEIJ/DMd848DRYY12+sO2EoY2y2wPfRvpshjuzpusZ18u70gMll1nuqkWk?=
 =?us-ascii?Q?9P/DddyoJmxf+o8rc0j3T4n8Egbn4x5+q2wYL2oYMF4+6Uf2W+mLa2Qb4JI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b600b8ab-26e4-4d76-9e3e-08ddf480e707
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 17:54:22.5201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10056

From: Mukesh Rathor <mrathor@linux.microsoft.com> Sent: Tuesday, September =
9, 2025 5:10 PM
>=20
> Add data structures for hypervisor crash dump support to the hypervisor
> host ABI header file. Details of their usages are in subsequent commits.
>=20
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  include/hyperv/hvhdk_mini.h | 55 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>=20
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 858f6a3925b3..ad9a8048fb4e 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -116,6 +116,17 @@ enum hv_system_property {
>  	/* Add more values when needed */
>  	HV_SYSTEM_PROPERTY_SCHEDULER_TYPE =3D 15,
>  	HV_DYNAMIC_PROCESSOR_FEATURE_PROPERTY =3D 21,
> +	HV_SYSTEM_PROPERTY_CRASHDUMPAREA =3D 47,
> +};
> +
> +#define HV_PFN_RANGE_PGBITS 24  /* HV_SPA_PAGE_RANGE_ADDITIONAL_PAGES_BI=
TS */
> +union hv_pfn_range {            /* HV_SPA_PAGE_RANGE */
> +	u64 as_uint64;
> +	struct {
> +		/* 39:0: base pfn.  63:40: additional pages */
> +		u64 base_pfn : 64 - HV_PFN_RANGE_PGBITS;
> +		u64 add_pfns : HV_PFN_RANGE_PGBITS;
> +	} __packed;
>  };
>=20
>  enum hv_dynamic_processor_feature_property {
> @@ -142,6 +153,8 @@ struct hv_output_get_system_property {
>  #if IS_ENABLED(CONFIG_X86)
>  		u64 hv_processor_feature_value;
>  #endif
> +		union hv_pfn_range hv_cda_info; /* CrashdumpAreaAddress */
> +		u64 hv_tramp_pa;                /* CrashdumpTrampolineAddress */
>  	};
>  } __packed;
>=20
> @@ -234,6 +247,48 @@ union hv_gpa_page_access_state {
>  	u8 as_uint8;
>  } __packed;
>=20
> +enum hv_crashdump_action {
> +	HV_CRASHDUMP_NONE =3D 0,
> +	HV_CRASHDUMP_SUSPEND_ALL_VPS,
> +	HV_CRASHDUMP_PREPARE_FOR_STATE_SAVE,
> +	HV_CRASHDUMP_STATE_SAVED,
> +	HV_CRASHDUMP_ENTRY,
> +};

Nit: Since these values are part of the ABI, it's probably better
to assign explicit values to each enum member in order to
ward off any mistaken reordering or additions in the middle
of the list.

> +
> +struct hv_partition_event_root_crashdump_input {
> +	u32 crashdump_action; /* enum hv_crashdump_action */
> +} __packed;
> +
> +struct hv_input_disable_hyp_ex {   /* HV_X64_INPUT_DISABLE_HYPERVISOR_EX=
 */
> +	u64 rip;
> +	u64 arg;
> +} __packed;
> +
> +struct hv_crashdump_area {	   /* HV_CRASHDUMP_AREA */
> +	u32 version;
> +	union {
> +		u32 flags_as_uint32;
> +		struct {
> +			u32 cda_valid : 1;
> +			u32 cda_unused : 31;
> +		} __packed;
> +	};
> +	/* more unused fields */
> +} __packed;
> +
> +union hv_partition_event_input {
> +	struct hv_partition_event_root_crashdump_input crashdump_input;
> +};
> +
> +enum hv_partition_event {
> +	HV_PARTITION_EVENT_ROOT_CRASHDUMP =3D 2,
> +};
> +
> +struct hv_input_notify_partition_event {
> +	u32 event;      /* enum hv_partition_event */
> +	union hv_partition_event_input input;
> +} __packed;
> +
>  struct hv_lp_startup_status {
>  	u64 hv_status;
>  	u64 substatus1;
> --
> 2.36.1.vfs.0.0
>=20


