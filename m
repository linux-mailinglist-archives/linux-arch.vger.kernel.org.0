Return-Path: <linux-arch+bounces-10592-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DB6A57630
	for <lists+linux-arch@lfdr.de>; Sat,  8 Mar 2025 00:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37869189B59D
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 23:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FC720CCFD;
	Fri,  7 Mar 2025 23:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hnD9x4aA"
X-Original-To: linux-arch@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012057.outbound.protection.outlook.com [52.103.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE1833DF;
	Fri,  7 Mar 2025 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390626; cv=fail; b=bx1OBTYbuHdXb0BhlgvW/bakyefDZlUk1ygPcO6m5LBh2tBEGmb3+tOcv337o59MHtMpbQW27CB4fjfXPGCSwOFGbhm3b38qA90vUrwb8cKN8zzswcbDQWcEy1xvwIrYw+BsY1j+ottmCyUtU7RcDDTDTmCnGpfKnwhJBB2qVSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390626; c=relaxed/simple;
	bh=/3rxoEmibJ7R6DWfta7nNFLh2mY36BbNX4M4qSDO4xA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ftPXWv6bAJwRwVFd09uWaXWhWMwKzvFx4vWBhO9PWOfCMt1FHShhkm3bkhkNwAdbAz2XyGe8U5OTmBn8akQ9WLOvywiNsCTmpo3Ad0w0LnGawLRzxKICmTVazKffk/ygFdNLQQWdyl1fs1RwIMbvcZdoxgDe0HpReb1FnnxnfwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hnD9x4aA; arc=fail smtp.client-ip=52.103.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTGuNCw67BkENVMTBhh6qF08AH+HsK7bEly3Jd8++YN+OqBgTKBmS0D3BkVjwfQJQv75tMA96tcO42eIN7pgc0ksEO2nLxatwcUDUfinJ6I0JFpaklsa1ArvCrDzi997jYqHGjkxvb12wGgbvDr5VzRI22BOaKHL+m6PfL2dDLvsusO0qkGsws6fo6NeaUDI6tP7D5tt3+5U/5Pb1/sKQgoxX0L8Xeaa8lXF2wI+iiXbGrxtLoy3QSQWH06LPjH5c6Iy959uCEXNfI7J62rnmoyOMk+Iql9EGtvosRl/++I14hNBaFc0mzgzfCrZguSJsYjfkPOViDqbRL+5aGgUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3rxoEmibJ7R6DWfta7nNFLh2mY36BbNX4M4qSDO4xA=;
 b=EJvLt5X7odjNwJZoPyJKOvQGV4yfzNFc9kpj3izFRms5X2VmyyLJ8khaUPNWC3lgvn2a8fGJsw2s2l0wcKHtQLFMhLp4bWHL+UzULH6G3dGnj1PNbpbjckzs5hwYT0dAhOdYAtfeosYN9PEgh1K/fHRwXBSPGDsVm3TPWDexaOhKc0sHv16LrjHnPtqIwKo1D+zwpxj22U3o9Tu6X7IoD+3adQqjSiyd4YRIR23VXHpbfqN1fADJ+t73VvVa9iTcq/8Gx8+n7h9vs3PhFfdI7O2iy9Vpb0xtLmgUFwo3Z5vrFYPFDWMSNGaQ15L/q3bSxoeX0XAB8fyN3LjSdjCqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3rxoEmibJ7R6DWfta7nNFLh2mY36BbNX4M4qSDO4xA=;
 b=hnD9x4aA6e6ghIQ1cGkYFMX0IOgnX2TwMKMP610TvpiCkEmMCgu8fFNqpoiAyj38xTl7PV6UEZc0Ni1n4pA1JcUHodqMBPxlCyAEfB4EYvaH+jA32zlz70FNxcKxQ6wDZScPeUafdptBiinenEEcBmHPds+2KcsZTFZna+zFOYqD/th9MsGGmkPRHPz0h/Q1I9Y1NkGrKyCuKT7Ay/vGWN5cKJmr2de6P1S79pf7ud79jIzYUQ3UGxVqotC8oWelUlojD3gsGs4nCh1piZdnUNIXh3jNa1LGRQ4sQ/BgB0Jn9ml26+5aqRh6O35/emTJ0KI+xOeVAagT81l8Ooz6gg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 23:37:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 23:37:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Kelley <mhklinux@outlook.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"apais@linux.microsoft.com" <apais@linux.microsoft.com>,
	"Tianyu.Lan@microsoft.com" <Tianyu.Lan@microsoft.com>,
	"stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "muislam@microsoft.com"
	<muislam@microsoft.com>, "anrayabh@linux.microsoft.com"
	<anrayabh@linux.microsoft.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v5 07/10] Drivers: hv: Introduce per-cpu event ring tail
Thread-Topic: [PATCH v5 07/10] Drivers: hv: Introduce per-cpu event ring tail
Thread-Index: AQHbiKNvTQlMQtRMy0ySwjthERjeILNn7PMQgABcNQCAAA2QMIAACGGg
Date: Fri, 7 Mar 2025 23:37:00 +0000
Message-ID:
 <SN6PR02MB415798FCF9548B5CA596E625D4D52@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-8-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157107676CF415A464C2C25D4D52@SN6PR02MB4157.namprd02.prod.outlook.com>
 <63437aa6-d45a-4b7a-b222-5901c03c48e0@linux.microsoft.com>
 <SN6PR02MB415710BED37BDD375B0D769AD4D52@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB415710BED37BDD375B0D769AD4D52@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB7009:EE_
x-ms-office365-filtering-correlation-id: 60d89504-83d0-4273-7b4c-08dd5dd0f4fb
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|19110799003|15080799006|8062599003|102099032|440099028|3412199025|41001999003|12091999003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?MHhpVmJmUVR0M2FUT053RDMxNW82L0ZLaFpnbEJISTB6WjJRNkd4eFpZb1J6?=
 =?utf-8?B?U1hIbU0yK2J1VXpkM3NjY3FTUTdoWi9KWTNaWjNUSFRCYzNpbEl5UVdLVG9w?=
 =?utf-8?B?WldjQjA3UHVhcUdOUzlBcGtrU1ppcEN5YkdYTlNQaWF2NFlZQTl4UjV4elhy?=
 =?utf-8?B?NDJrQlRjSVZjVU1QcGs5L291aUMwVjJmNzNrcjFZNDRVNm9lc0xoT0RpenpS?=
 =?utf-8?B?a2g4K3Fqa2xDVjd5M0ZKY0dnQjJYUlRJY21zN29ZY2o0Z0FlcllHeXZ2dEpl?=
 =?utf-8?B?T0t6ZnRYN3o5eGgveGdhRlhhbmFrcVR5QVNVUkFzVTBqYlNEM1VBUlErdmtG?=
 =?utf-8?B?UkZ0MytxSjlabE03NnJhOFdnYXVWT1JGR3lSS1pKbCtKbkV0dko4aVlvbUhn?=
 =?utf-8?B?UHpIbmFFOUh0SUxiRTdyaGw0QVdOQ0h2Wlp4bDhiUVlxV0FKeVA2dGRtLzJh?=
 =?utf-8?B?UUdscTV5a0VrdnhES25SanpmVGEwSkNDMER2YzBpTU92d0xGd2dGdVpLUWlM?=
 =?utf-8?B?NGVBWkp5K0FGaEV2UkF0aGJGNFA3cFdUcU84ZStjNURaSTR4NStZYmVJVy9x?=
 =?utf-8?B?U2ZGWXBoZ20wZnBoY1NyU3VhWG5zSmFCM3FhQWpEVC9RUEhpR1RBWjUwWWhI?=
 =?utf-8?B?K0ZTakc3dnN2TnhLUkxCMkJNTklFb0MxdENYTHhqVnpmK1JlUGhDa3BlSnFT?=
 =?utf-8?B?bzNuc21SRkU0QkM5QUdrcDY1Q09sZzIvdU8wdG51NjRjdnJ6cHJna2xLaDVK?=
 =?utf-8?B?bENpQXdReFRBdVhNVHVGWGVzSCtRSjFhZnVvWThCU1k5UTh5U2xUZFVmQWZj?=
 =?utf-8?B?TFIzdTA3UEUxTVYyTmEraEt4MUF3TkI1aEhEQUpzZEtPeU9Ic2M0Sy9wbmVW?=
 =?utf-8?B?Z0VJS0dsN3l4SUVlUmJSL0N6L252c09kUkQzbEVTUTlqTTYyWVBXS0MxbTJB?=
 =?utf-8?B?QTNtVWFSZEpBeVJwTTJXSmc5ZGhCRGx6elhNalVvbnNvQmsyWVF0QllWYUNi?=
 =?utf-8?B?VklPV3ZtclFCUnJkTnNBMGY5KzUwSklWb3ZsNWpzZDlVYWttZkcyalQ4L0lt?=
 =?utf-8?B?c2NCK0NyMnNqT1ZQVlUybk4rb2w4RWVOcWgvOTVONW1md1RlaGRZMlV6QzY0?=
 =?utf-8?B?WmxwZ3JiRXZaczJFeHJWQ1BnSGl0QWF2NDBiYjROZmR0MCtNOC8veEppczkz?=
 =?utf-8?B?Q3NnQVBXZm44ZitJSXlVV0dpNFE2a1JjQlJVVzFoSUYxWjFia2hFWi9SQmpl?=
 =?utf-8?B?UG5jWGF4WG9kL2ZaS1VEUUNiVWdGeVBzWWRoTmQvNVJON0VBYitXRHFyMENE?=
 =?utf-8?B?bUVTbEtYNmJFelJTZy96VmRGU2JRTXRvWlNPZDYxZzB4c3o0SlYzN3pTMHhJ?=
 =?utf-8?B?VWpBS1pIOTNUYWlQbTlpbXM0TFhvYWlKcmZGcU5uQmRGcXp2V3hsYVV2TDRF?=
 =?utf-8?B?V0U3ZVlaTDBEdXZiQUhyYzVia2IwdmN2MWU2YjRzOGxlSnRHckp3NUhiU0c0?=
 =?utf-8?B?MGF0anR3aGNxclZQRTlsNkpFL25oT3pScC91YU45ejcvYWZPNkpVUmxyd0I1?=
 =?utf-8?B?NkxpZz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RnUyZjhQb3B0bTYwWitIZHJTTWVDc09Bd1M0SUZ0dFJSNk9hRkhGS24rcjVX?=
 =?utf-8?B?V2kvR2JvU3MwMVJreWR3aHEwdlYwSW9FNjBSdW9laHJVRjlRM1hKZmY2Z0kz?=
 =?utf-8?B?WXlTUHhGUGVxMU1RdmdnTmhYUE9jdzlzWkovbXVmWFNDaXpTemxvRVFEZE4r?=
 =?utf-8?B?c0w4TkVhVXJjQXJIQ3piMkFtc0ZyUnlEUEl0MzNQV1lReTBCWTkxc0VrdlN2?=
 =?utf-8?B?TDZDVVJBanJmZEJPVlJVN3ZtdlFLZUxJWFJicE1OTGVhRFhrRHJIZUFQS1N2?=
 =?utf-8?B?SGRIQjVhUE9id1phV0lxaldmVzZ2RnA3TVZlLzJYeUdFb1RsclBLQ1F6UU10?=
 =?utf-8?B?anB2dE9oQWRBTnZwODNRek4ybGNhbVErSnhTUG90bzdaV2xtWDJLVEQvN2hL?=
 =?utf-8?B?Q2FsS3lIS0h2SFdTYTBlNk42L0R1REZtVTAvOWl5ZzhJSWRzb3lZbVlIY3Jj?=
 =?utf-8?B?SElGZVhXRmNEYjRnOVVxZ2Z5WTNnc1FDdnlxdWZPYXdRVkFheG5VSDdra0hP?=
 =?utf-8?B?bEs4czdlOEdkanRnUGwzMk14Y1c5aytDQk5nZ3BJZXNwQ0FyT2lZSDltdzBY?=
 =?utf-8?B?amJWUHNKejk2SDI4QWhBRDdsbTdTaUZ5M0JRSXBRRk9YTlk5andKRGtJWndB?=
 =?utf-8?B?dFFjRGk0ZjRoVDlmZC9ORWpQTlNQSGtHWktvWkpXVXJIa2xyRUp4NmNSUXhX?=
 =?utf-8?B?M0tBUU1USkY1TDB6alRBOUJvcW5wb3hMNk1kazIrd0pmU0lCUWRHa0RKdEJp?=
 =?utf-8?B?RGtzSTN6OUVNVHRFZDdNQlZrVHZvSUp0V05sUFJQMXBvZGhPTjlzbVBHc3Jr?=
 =?utf-8?B?MHkyNUlrcEl6V1ZwTlNZcWlEakltS0E2ajdpcERTRTFUc3pHSXhUZUphSFZi?=
 =?utf-8?B?a2szdE14VFR2MFJpT3NySFFYemJRRzdJY3JSbG9oWitqRExOMUprMTVBUFFp?=
 =?utf-8?B?RHNkNHhyaDZoN0cxVGE2WElRdWJRczZXdGxLNWdqdDNYSmRTME41ZmRKSzFY?=
 =?utf-8?B?MGNISFMwbExHVWsvZ0x6Z2lTaE01WTNIR29XeHBuYTNpQTNBODBXUHNPdDBj?=
 =?utf-8?B?K2JYbGY1a1JkOXlyQXErbVd6Z2RBYXF6aFMydjN2SG9Ba1RJN2gwbWNEMEZt?=
 =?utf-8?B?VXVzeWdVK25ta0pwa3EwRUZNSWJFVHFtMW9aeVlsQ1ZPUkNrZlc1YTdwTFFC?=
 =?utf-8?B?NmErcHJYellOZTBFUmNvTU4xb3NsZVZBeHp5ZWpVb3lCRFlOemU1NUFaMWxt?=
 =?utf-8?B?dlMwNGhSRlZrOWdBTVRSamYrdXhzUFFzU3Vpcm00dGkzMklmcVpCa1N0NnR2?=
 =?utf-8?B?M2dzL2NubWRBdlc1Z1BRSXRrVjE0TUVlU25EYXFiYyttMDNXQUM1RGZxQ2dS?=
 =?utf-8?B?WEZwbllvUk53c3U5dkhsZFFnckhZWVlheEl3dk5IZlB4dG9ibXBZUzB3MHJQ?=
 =?utf-8?B?cDl2Z3UzM0hQcmlHWVBaZGlWK2laUmNmZnJXcHdaNitweVFhNVlCaHV1Q2dQ?=
 =?utf-8?B?dDIyVVY4WGdLU2lDaTJTV1ByMGMyMzFxZkh4WlR6UWdxK0RWWEppN3JIZDFr?=
 =?utf-8?B?RDVyK25qU2M1RHNuYkc5MFRNcTJtOFZUdkdCNWZJTm1jd0RCV1gva0NvTGhH?=
 =?utf-8?Q?aCHI1UkLSFo8Fyo2pKw730t8LPF3Np/an/NF5ueZXc2Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d89504-83d0-4273-7b4c-08dd5dd0f4fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 23:37:00.1090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7009

RnJvbTogTWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91dGxvb2suY29tPiBTZW50OiBGcmlkYXks
IE1hcmNoIDcsIDIwMjUgMzoyMSBQTQ0KPiANCj4gRnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9k
YXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBGcmlkYXksIE1hcmNoIDcsIDIwMjUN
Cj4gMjowNyBQTQ0KPiA+DQoNCltzbmlwXQ0KDQo+ID4gPj4gQEAgLTQ4NSw2ICs1MDQsMTcgQEAg
aW50IGh2X2NvbW1vbl9jcHVfaW5pdCh1bnNpZ25lZCBpbnQgY3B1KQ0KPiA+ID4+ICAJCQkqb3V0
cHV0YXJnID0gKGNoYXIgKiltZW0gKyBIVl9IWVBfUEFHRV9TSVpFOw0KPiA+ID4+ICAJCX0NCj4g
PiA+Pg0KPiA+ID4+ICsJCWlmIChodl9yb290X3BhcnRpdGlvbigpKSB7DQo+ID4gPj4gKwkJCXN5
bmljX2V2ZW50cmluZ190YWlsID0gKHU4ICoqKXRoaXNfY3B1X3B0cihodl9zeW5pY19ldmVudHJp
bmdfdGFpbCk7DQo+ID4gPj4gKwkJCSpzeW5pY19ldmVudHJpbmdfdGFpbCA9IGtjYWxsb2MoSFZf
U1lOSUNfU0lOVF9DT1VOVCwNCj4gPiA+PiArCQkJCQkJCXNpemVvZih1OCksIGZsYWdzKTsNCj4g
PiA+PiArDQo+ID4gPj4gKwkJCWlmICh1bmxpa2VseSghKnN5bmljX2V2ZW50cmluZ190YWlsKSkg
ew0KPiA+ID4+ICsJCQkJa2ZyZWUobWVtKTsNCj4gPiA+PiArCQkJCXJldHVybiAtRU5PTUVNOw0K
PiA+ID4+ICsJCQl9DQo+ID4gPj4gKwkJfQ0KPiA+ID4+ICsNCj4gPiA+DQo+ID4gPiBBZGRpbmcg
dGhpcyBjb2RlIHVuZGVyIHRoZSAiaWYoISppbnB1dGFyZykiIGltcGxpY2l0bHkgdGllcyB0aGUg
bGlmZWN5Y2xlIG9mDQo+ID4gPiBzeW5pY19ldmVudHJpbmdfdGFpbCB0byB0aGUgbGlmZWN5Y2xl
IG9mIGh5cGVydl9wY3B1X2lucHV0X2FyZyBhbmQNCj4gPiA+IGh5cGVydl9wY3B1X291dHB1dF9h
cmcuIElzIHRoZXJlIHNvbWUgbG9naWNhbCByZWxhdGlvbnNoaXAgYmV0d2VlbiB0aGUNCj4gPiA+
IHR3byB0aGF0IHdhcnJhbnRzIHR5aW5nIHRoZSBsaWZlY3ljbGVzIHRvZ2V0aGVyIChvdGhlciB0
aGFuIGp1c3QgYm90aCBiZWluZw0KPiA+ID4gcGVyLWNwdSk/ICBoeXBlcnZfcGNwdV9pbnB1dF9h
cmcgYW5kIGh5cGVydl9wY3B1X291dHB1dF9hcmcgaGF2ZSBhbg0KPiA+ID4gdW51c3VhbCBsaWZl
Y3ljbGUgbWFuYWdlbWVudCBpbiB0aGF0IHRoZXkgYXJlbid0IGZyZWVkIHdoZW4gYSBDUFUgZ29l
cw0KPiA+ID4gb2ZmbGluZSwgYXMgZGVzY3JpYmVkIGluIHRoZSBjb21tZW50IGluIGh2X2NvbW1v
bl9jcHVfZGllKCkuIERvZXMNCj4gPiA+IHN5bmljX2V2ZW50cmluZ190YWlsIGFsc28gbmVlZCB0
aGF0IHNhbWUgdW51c3VhbCBsaWZlY3ljbGU/DQo+ID4gPg0KPiA+IEkgdGhvdWdodCBhYm91dCBp
dCwgYW5kIG5vIEkgZG9uJ3QgdGhpbmsgaXQgc2hhcmVzIHRoZSBzYW1lIGV4YWN0IGxpZmVjeWNs
ZS4NCj4gPiBJdCdzIG9ubHkgdXNlZCBieSB0aGUgbXNodl9yb290IGRyaXZlciAtIGl0IGp1c3Qg
bmVlZHMgdG8gcmVtYWluIHByZXNlbnQNCj4gPiB3aGVuZXZlciB0aGVyZSdzIGEgY2hhbmNlIHRo
ZSBtb2R1bGUgY291bGQgYmUgcmUtaW5zZXJ0ZWQgYW5kIGV4cGVjdCBpdCB0bw0KPiA+IGJlIHRo
ZXJlLg0KPiA+DQo+ID4gPiBBc3N1bWluZyB0aGVyZSdzIG5vIGxvZ2ljYWwgcmVsYXRpb25zaGlw
LCBJJ20gdGhpbmtpbmcgc3luaWNfZXZlbnRyaW5nX3RhaWwNCj4gPiA+IHNob3VsZCBiZSBtYW5h
Z2VkIGluZGVwZW5kZW50IG9mIHRoZSBvdGhlciB0d28uIElmIGl0IGRvZXMgbmVlZCB0aGUNCj4g
PiA+IHVudXN1YWwgbGlmZWN5Y2xlLCBtYWtlIHN1cmUgdG8gYWRkIGEgY29tbWVudCBpbiBodl9j
b21tb25fY3B1X2RpZSgpDQo+ID4gPiBleHBsYWluaW5nIHdoeS4gSWYgaXQgZG9lc24ndCBuZWVk
IHRoZSB1bnVzdWFsIGxpZmVjeWNsZSwgbWF5YmUganVzdCBkbw0KPiA+ID4gdGhlIG5vcm1hbCB0
aGluZyBvZiBhbGxvY2F0aW5nIGl0IGluIGh2X2NvbW1vbl9jcHVfaW5pdCgpIGFuZCBmcmVlaW5n
DQo+ID4gPiBpdCBpbiBodl9jb21tb25fY3B1X2RpZSgpLg0KPiA+ID4NCj4gPiBZZXAsIEkgc3Vw
cG9zZSBpdCBzaG91bGQganVzdCBiZSBmcmVlZCBub3JtYWxseSB0aGVuLCBhc3N1bWluZw0KPiA+
IGh2X2NvbW1vbl9jcHVfZGllKCkgaXMgb25seSBjYWxsZWQgd2hlbiB0aGUgaHlwZXJ2aXNvciBp
cyBnb2luZyB0byByZXNldA0KPiA+IChvciByZW1vdmUpIHRoZSBzeW5pYyBwYWdlcyBmb3IgdGhp
cyBwYXJ0aXRpb24uIElzIHRoYXQgdGhlIGNhc2UgaGVyZT8NCj4gPg0KPiANCj4gWWVzLCBpdCBp
cyB0aGUgY2FzZSBoZXJlLiBBIHBhcnRpY3VsYXIgdkNQVSBjYW4gYmUgdGFrZW4gb2ZmbGluZQ0K
PiBpbmRlcGVuZGVudCBvZiBvdGhlciB2Q1BVcyBpbiB0aGUgVk0gKHN1Y2ggYXMgYnkgd3JpdGlu
ZyAiMCINCj4gdG8gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1PG5uPi9vbmxpbmUpLiBXaGVu
IHRoYXQgaGFwcGVucw0KPiB0aGUgdkNQVSBnb2luZyBvZmZsaW5lIHJ1bnMgaHZfc3luaWNfY2xl
YW51cCgpIGZpcnN0LCBhbmQgdGhlbiBpdA0KPiBydW5zIGh2X2NwdV9kaWUoKSwgd2hpY2ggY2Fs
bHMgaHZfY29tbW9uX2NwdV9kaWUoKS4gU28gYnkgdGhlDQo+IHRpbWUgaHZfY29tbW9uX2NwdV9k
aWUoKSBydW5zLCB0aGUgc3luaWNfbWVzc2FnZV9wYWdlIGFuZA0KPiBzeW5pY19ldmVudF9wYWdl
IHdpbGwgaGF2ZSBiZWVuIHVubWFwcGVkIGFuZCB0aGUgcG9pbnRlcnMgc2V0DQo+IHRvIE5VTEwu
DQo+IA0KPiBPbiBhcm02NCwgdGhlcmUgaXMgbm8gaHZfY3B1X2luaXQoKS9kaWUoKSwgYW5kIHRo
ZSAiY29tbW9uIg0KPiB2ZXJzaW9ucyBhcmUgY2FsbGVkIGRpcmVjdGx5LiBQZXJoYXBzIGF0IHNv
bWUgcG9pbnQgaW4gdGhlIGZ1dHVyZSB0aGVyZQ0KPiB3aWxsIGJlIGFybTY0IHNwZWNpZmljIHRo
aW5ncyB0byBiZSBkb25lLCBhbmQgaHZfY3B1X2luaXQoKS9kaWUoKQ0KPiB3aWxsIG5lZWQgdG8g
YmUgYWRkZWQuIEJ1dCB0aGUgb3JkZXJpbmcgaXMgdGhlIHNhbWUgYW5kDQo+IGh2X3N5bmljX2Ns
ZWFudXAoKSBydW5zIGZpcnN0Lg0KPiANCj4gU28sIHllcywgc2luY2Ugc3luaWNfZXZlbnRyaW5n
X3RhaWwgaXMgdGllZCB0byB0aGUgc3luaWMsIGl0IHNvdW5kcyBsaWtlDQo+IHRoZSBub3JtYWwg
bGlmZWN5Y2xlIGNvdWxkIGJlIHVzZWQsIGxpa2Ugd2l0aCB0aGUgVlAgYXNzaXN0IHBhZ2UgdGhh
dA0KPiBpcyBoYW5kbGVkIGluIGh2X2NwdV9pbml0KCkvZGllKCkgb24geDg2Lg0KPiANCg0KT25l
IG1vcmUgdGhvdWdodDoNCg0KUGVyaGFwcyB0aGVyZSdzIG1vcmUgYWZmaW5pdHkgd2l0aCBzeW5p
YyBjb2RlIHRoYW4gd2l0aCBnZW5lcmljDQpwZXItY3B1IG1lbW9yeSwgYW5kIGl0IHdvdWxkIGJl
IGV2ZW4gYmV0dGVyIHRvIGFsbG9jYXRlIGFuZA0KZnJlZSB0aGUgc3luaWNfZXZlbnRyaW5nX3Rh
aWwgbWVtb3J5IGZvciBlYWNoIHZDUFUgaW4NCmh2X3N5bmljX2luaXQoKS9jbGVhbnVwKCksIG9y
IGh2X3N5bmljX2VuYWJsZS9kaXNhYmxlX3JlZ3MoKS4NClRoZXJlJ3MgcG90ZW50aWFsbHkgc29t
ZSBpbnRlcmFjdGlvbiB3aXRoIGhpYmVybmF0ZSBzdXNwZW5kL3Jlc3VtZSwNCndoaWNoIEkgYXNz
dW1lIGlzbid0IGEgdmFsaWQgc2NlbmFyaW8gZm9yIHRoZSByb290IHBhcnRpdGlvbi4gQnV0IEkN
CmhhdmVuJ3QgdGhvdWdodCB0aHJvdWdoIGFsbCB0aGUgZGV0YWlscy4NCg0KTWljaGFlbA0K

