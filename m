Return-Path: <linux-arch+bounces-10272-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3917FA3E7DB
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 23:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA2817F8DB
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 22:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D92F264F86;
	Thu, 20 Feb 2025 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OSYy7nNS"
X-Original-To: linux-arch@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020138.outbound.protection.outlook.com [52.101.56.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991A01EE006;
	Thu, 20 Feb 2025 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740092386; cv=fail; b=Um0LU74roPjySnFDjs9Dv71vPU1t8oAJPiLhgKTeJTJeO7v96O60mUBGD5bzAfFyulteWKsPG0sY4iwRCpscCVPQ2p/xayDZR1rEIFUOphy7e9zOyMdxQSpDWCxXREYVyYjD7KI38m6dRiYLv1zmGfAnzkFPYpvSgE3Js9Wh5N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740092386; c=relaxed/simple;
	bh=0Bn8xfeD410KX5zNV7zF1gEoPqfK7fSFMX0q1DsjjYY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qjmRiVHPjr1BfMoptijYF6jyOXKnECiX183jhnzCHUHhXo/X+eTJN3/EehehG0nNs7tETjTcIOVuivVGJWTxwnYmzmRoi44v7yFtLq8t1paqPrj13OpGqoq70DRInB6czTOu0mmd+KJ5VwENEV7U+Czh/rH5gs0AT3PP3+xwBp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=OSYy7nNS; arc=fail smtp.client-ip=52.101.56.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTAQkQUYSs2exIc7oeGUSc2eIMWSfe7qPXsna/aVzTCr/7k8jeQw/UuW0UEiMjYr/zaOE7y/dfl1T+eKcXPXOBBRym1CxUPcVBnim3S76cstb2e9tssUWBwGyN2AYRBHVnfKDvj/Y6pOjebh+NMLkgmcBYePtrRcFajzT0bpJ6ZRWoWEvwMpvT+VgJbTCWRDkJj8sHNbMz7aqkCaY7UPIqHuhhHpgiBCmJj3o8MK3295bOQSsiUTu7mEAirFDtpZbPiuoHXgBe/Vz+o3aeTTcmSn6yHvgHT0iD6DqLDkreNuhiex42/Ffi/dTU0Iy+l+d5wsWkRpTceVqv7qsI99Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Bn8xfeD410KX5zNV7zF1gEoPqfK7fSFMX0q1DsjjYY=;
 b=ht4W+9AOkW1IZTVgkzeFamEjJXL2aJUo0a/lg464OAMQztEZxI54zJ9AUuq3S0hFzQMwr3QKH9NQZxUCP6+pIn2zBBRdbezxrFTeYbPIA0KmN5BkDe0Tzo1+BfGEFeAvponP6DLOYJY9YRTnxbnstBGLffFNFq/D4CX0Z05JAzlCJRmeA55QUztUWrsmvVVVWc+FqOQ78LE87wamGbfbR7eHYn2Sj6cmNQ6JoxTfpr87VfBY5LWWcFri6hQGiBdu5X45zm0m33q4By2cjLFf4D7SrjNMYbnUsOz8xwcFP/+4ZiJomA7Sl9KeD/QnN2D9Rv3K6siPd7aS/hYH+dC3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Bn8xfeD410KX5zNV7zF1gEoPqfK7fSFMX0q1DsjjYY=;
 b=OSYy7nNSBvUp9T1YmSSrq9mL/s8aFr43ZwE/w2Fxr2wdiD4ktGWHWEIK5VXDL+OXv651a9I30DFAg/LCGHshyCWwDHdDDC+7X+9M7aBHQBCIobdcPw1n4MHfrOTXh7slQIgWNLLR0qdlez0Dr7waqj9nku4dCxDHVXxfgUfZd8o=
Received: from DM6PR21MB1434.namprd21.prod.outlook.com (2603:10b6:5:25a::10)
 by DS7PR21MB3268.namprd21.prod.outlook.com (2603:10b6:8:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.10; Thu, 20 Feb
 2025 22:59:41 +0000
Received: from DM6PR21MB1434.namprd21.prod.outlook.com
 ([fe80::790a:4e07:a440:55cd]) by DM6PR21MB1434.namprd21.prod.outlook.com
 ([fe80::790a:4e07:a440:55cd%4]) with mapi id 15.20.8489.009; Thu, 20 Feb 2025
 22:59:41 +0000
From: MUKESH RATHOR <mukeshrathor@microsoft.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
CC: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "mhklinux@outlook.com" <mhklinux@outlook.com>, KY
 Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "jinankjain@linux.microsoft.com"
	<jinankjain@linux.microsoft.com>, "muminulrussell@gmail.com"
	<muminulrussell@gmail.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>
Subject: Re: [PATCH v2 2/3] hyperv: Change hv_root_partition into a function
Thread-Topic: [PATCH v2 2/3] hyperv: Change hv_root_partition into a function
Thread-Index: AQHbg8X7D+BhCLhaE0W3GmwFogL1arNQvd4AgAAQDYCAAADHAA==
Date: Thu, 20 Feb 2025 22:59:40 +0000
Message-ID: <f5366d52-1714-87bc-5fa5-94230f2acca1@microsoft.com>
References:
 <1740076396-15086-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740076396-15086-3-git-send-email-nunodasneves@linux.microsoft.com>
 <5980eaf9-2e77-d0ec-e39b-b48913c8b72f@microsoft.com>
 <a29af204-e4a9-4ef2-b5b8-f99f2ac0a836@linux.microsoft.com>
In-Reply-To: <a29af204-e4a9-4ef2-b5b8-f99f2ac0a836@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1434:EE_|DS7PR21MB3268:EE_
x-ms-office365-filtering-correlation-id: 31544a76-5c69-4cbb-01d3-08dd5202422d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MEU1YXN5RFladG9UNkZXa3FWL3JWMUp6cnArRE5mMnRJQ0dWSXRzUzVnNDhy?=
 =?utf-8?B?ZUlJNHljL2pUaENXdzRoNW5RUlhEZitPZmtqZXVVaHozQlNiaCttbEo0TDhV?=
 =?utf-8?B?TTRwT3o3RkVGeW8vM3lTQlpiNnlzdW1Xc0VmOE1FSDM5ayt4SUpFR2x4eUNr?=
 =?utf-8?B?d0FVZEpWdVlGVDVBb0oxWWpob2FRaU1abGFpWnBjaFArM0tGU3ZiRzNtNlB0?=
 =?utf-8?B?YytuazNEbWkrdVR0UU5xU24yWHk5OXQ4dnNmbEkvQ1dYOXdMakZZbWFHN1FZ?=
 =?utf-8?B?SG55MWlvUm5wZVhuTVIra3ZzNFQybDgvbklhN0c1T0lqVGNwSTM3SG1GVXEz?=
 =?utf-8?B?Q0F2NVhBNExkRmtXT1lQKzZaeDArS3o4YjdtRU5jL3hRbGw4NEc3Tnc3bFE3?=
 =?utf-8?B?UkJGeXdONlIrR0VWdG9xZGJKMG5oNCtCVHBJeGN2aFYyOEZkVWxiT3pvQzBC?=
 =?utf-8?B?TjMrZ3ZrVUo1eFp2NCtEL0RNdkEwemRwK1ZRV0U2bmoxZDZ4aWQ2NUpkeW1o?=
 =?utf-8?B?SDU2MXFRbUxSdEhRQnNBRUxrM21rU204UCtIRDhob09UV1dpMmdBOEpVRUZ5?=
 =?utf-8?B?U3lFMUFMdmFvVUxEUkpidWQzNnQ3YmJHdEkzMy9QMktJZlNMTzRkZnIxd1Ix?=
 =?utf-8?B?VzMzdWVzZE4zd3BlcWlCMGNXTzlpeUl1dFBjejRlcGxVYkdkNndXTFRZaG9K?=
 =?utf-8?B?V0RtSnFsVHNRTjRhbVppeHdLWlA0amMwbUIvT0U5VldOdTlNU0dhNDRZT2dl?=
 =?utf-8?B?MFQzdFFzRTZqOXdxeEdCY0gzRTM4N1haQm1IM05uSERmcEtkbVU2dGJpMXB5?=
 =?utf-8?B?NHEvREo1TkhYVXROdndNWUZoYXd6NjE4allUSFJYM3VyakI5RHVHdkFPblNU?=
 =?utf-8?B?WEcvSVJVdVRubThuVEE3eTYraWdVc0k2OUJKcGdEbGs3c05rUTZScnFCWjhC?=
 =?utf-8?B?bEg3eFN2VW5EUXpoZlliNVlQUFJmTCtxSDIzSXR3WFhuNWtMUnRoTXoycWl5?=
 =?utf-8?B?Y0FrRTN1eXB1YXd0amhtRXJFYUtqYjR5bnIrN1hRLzhQUkttYWV0R01FRnZ4?=
 =?utf-8?B?dWUwMkxXU2xQbjZiZVlleVk5YWZFRnhwbW03TE5TR2JiMTkzK3BLcFVVQ01h?=
 =?utf-8?B?N1Y1K1NHNUhQR1IrcDFMb2JJeGlaK3RycWdkT1JGMUJFTmlWYS9GbkFiVEJ6?=
 =?utf-8?B?dEgwMkFhN1N1aEQ5SDk5eUJKTHBJT1MzbWt1WFF1UmsxQUN2VFV1TThtYy9S?=
 =?utf-8?B?MUExQ0ZqZkM4VTF4L0YzWWl2NHo3TW81YnVxYkprdEkwRzlMcEhLVzdCVUNi?=
 =?utf-8?B?WWhyVnFZSEFaUkxwWkR6eDhrOW1XekFteFlPZXFYUC9JZnZXcHBtaFdmU1Mz?=
 =?utf-8?B?c1p2dFN3TnA5UW9rcElxQjNVYWZjd2doRW5rV28wRUxBOTR0dDdEWWhXeXdt?=
 =?utf-8?B?bFRkQlBBczlGWTdvc2pJY3ZFYkRINEZmcUJsUUpoNlNhTktIaWNhQTRzenJP?=
 =?utf-8?B?OGxHNU5CNUJkYitYZU9jMDVRYnB5SldjWW8yS1pYbTFWVkF1ZWlQYkF1SkFy?=
 =?utf-8?B?eE9NN0dSbTYxUjZITGhkcUIybW1TbHhQQW8xd0RUQjY5SkJ6ZjZjMlF1MzQz?=
 =?utf-8?B?ZlljWkorSWo0UnNGYXp0MmF0VmI0ODVyRWs1RU5kZlArTThBY1lJKzlzNVVO?=
 =?utf-8?B?RmFWa3V5Z082VDhRYXp6Mm1qUG05YjN5azFoRkFjT2lsdXhENVNTaE5FaW51?=
 =?utf-8?B?c2dFQXhSWkJ2RGtvblMrS3g4cFM1VEZXRmRDR0F4Z0tXaEE1MXgyWGtiK0Rx?=
 =?utf-8?B?QldXbWgwVzVMT2RqRWZxY2JSTU9MakhVVlJBTEo2ZSsvTWFGLytGWmRudjZB?=
 =?utf-8?Q?B14aTAg533cj3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1434.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXBkcmlOd0JDVmx4WVl3dTFtbDdpdHdHTmxtVVQxTlppVitqS3ZBV2t3blQz?=
 =?utf-8?B?d3g1SG1udnJlMGtuR3ZUWWllMTVjdk4vYnNIR1VSODdtblFzN1E5WXdaeEth?=
 =?utf-8?B?N1hka25YM1p3MndTdkJoWjZnQzdseW5MbDhHWVJlb1MzOHQ4ZVdIK3YxMFo0?=
 =?utf-8?B?Y1Z4QVloUXZWU0YxUk13TGFnemJORkxhd251Q1hqbDVjTHZXVFJHamJESm1H?=
 =?utf-8?B?K1dnM2JpOWxDU28xMjdpQUliZjFWMUo3TmR4T3VPdnVVYXlOa1lQeldjd3Nr?=
 =?utf-8?B?UURUK09ncTI4ZTcvam1tOHlwcUZNK1NXa21sVk13T2lUS3J1aDNZbkRJbW9o?=
 =?utf-8?B?ZGM4cDFQazR5WHJmOTFQRWhLWG1uanVpV2dpTHBldkJaSTZDOStVQ1c0bzJs?=
 =?utf-8?B?SU50RXRrZGh1UWV3MlRiTFNiQ3l5WW5GdE9TOUNiYVBkdGxuOVRFVi9BUUFZ?=
 =?utf-8?B?L2M0KzkzVi9wcjZGdmFoUzZZT2hlMlhnT2tsY0F1bmk3d2o5UXgxVy9sTlYx?=
 =?utf-8?B?Y0Q0N3FiWklReGxqMW4vTUQ3ZE1QdHFSY3FJejhXMThRR0FGbFhieEhieW1x?=
 =?utf-8?B?MTlIQlBjVDVNMjZva1RlaXVBc05VVzRUTlV0aHJHTnNRM2dDTjdLZ05UaXZq?=
 =?utf-8?B?NEpCbGJMUmp4NzdRSnN4akJBQVFCbDRnMklNMHNuNzRBVWM5K1lJUjM4c3p6?=
 =?utf-8?B?OEFnczlpNTdNWGNuWStHbHFsRGM0bGxuLzJjZmlOVjZwN0NpY3Z4T1h6UzQ4?=
 =?utf-8?B?MTlqNDZ2cm9CSDBoeTdKbVVLazM4L25YMFA0cnREdHdPSG5rSll0aG5CWHJB?=
 =?utf-8?B?TitGM0VTRTROVUswRS9vUWUrRmtJMEhmVGpFQXNLM0xvU3BGMGdUWjZWaUhI?=
 =?utf-8?B?cy9yWnczcTBhUXdPQXhPOXNscUdBYXVrd2k3dDRiQUhvc0ZSWDVRTmN4N0Ra?=
 =?utf-8?B?K3Vsa0Z1NVcvdEdsUFErL2QwRmt5UXp4Ym1vcjJFY2UzUXFyRW4vYzNib09F?=
 =?utf-8?B?VkFoYlJhak5EK2hnR0FYcDFBUkthV1FabHJiajQzZS9EL0FHQmtFb2lwZDhs?=
 =?utf-8?B?VzgrME1NbS9EK0IxL0RKbEpvVWh3TFUyQUcrWEljbGJmTUQ2QlNVOVN5dzZJ?=
 =?utf-8?B?UUJMKzkxcUgvdGZ2UnN1ZkJ5YzBQcHB0OXhzU3V5L0N1NGFQUENKSWkyVWRR?=
 =?utf-8?B?blZrN2xMQ0w2SEFvcFZxYm5sZmN2aGxGYWlrYWxpYWFXdFRtUUZtMHRMd0pk?=
 =?utf-8?B?U1drYlFUVmdHUjlHNWlpMUZ5aUVKd1UxTlZvYW52Q3VmYXVTWEdUa2oxZFlW?=
 =?utf-8?B?Rng4SzBHc21Tc1RHM3ZwN2FkYmxXVGZMNEpxbklSbUx2ZVJaL1diT3Q0TVZV?=
 =?utf-8?B?V3JrZ2UyTkkvSnBMcVlGK1lyOTV4UVo0dnBqYzFHK0RNaVJOVXZPZHVXdlBT?=
 =?utf-8?B?Y0FBQWV6cXVhWEErUUxrbGdJYWhDVkk5RlFKd0FXUjNyQkFucEJDSDdQMUN5?=
 =?utf-8?B?UFR6VHFVTFJXSkU3bXBibWMzZWpPbmpPMWZLY21ybXhKTENUb1lMMklaM0FY?=
 =?utf-8?B?OFR6eVlzdnVzbkdaUTBlSHhnd2N3VkErYlVvTmJvSEhRNmdXYk5JcjhKSDZo?=
 =?utf-8?B?NlNrWmQrdTlWU1VPQU9Tb1RCWG5IekRpTlhsT0IrY0w2Z2crbEh6RnhJMUpQ?=
 =?utf-8?B?TXFobTY2dW1UeVI1K2VnUDgvOGRTbHlOWXdGOGd3ajF5cjBOSmFwS3BwcmJX?=
 =?utf-8?B?Mk9VbW1YcTZvaE1EL3dwbXNUQWl5WmdKUXZnUGFQSDFzWWdLY1lWWEd4alpx?=
 =?utf-8?B?ZnNlcS9TNmdHUGRubnNhcHl3alFsVytzbHZrZGMwNUtLL2ZReXlVV1RZOUkr?=
 =?utf-8?B?VDZlVlVJbS9yNVdjald5akFVYVRGQUtVODk1Sk1YRjN0a3JkMnpzUFVmTnNF?=
 =?utf-8?B?V29RVStnbXAxZFhNT01VeE9zbE5PTjJ4RUVkL0w1YVFURUtnd3g0SDMwRmRM?=
 =?utf-8?B?TjFzNzJET3VzWjlYYTZ2czluazVRRTZEblZ0SVpQMFlsZU92bFBlcTU1clVv?=
 =?utf-8?Q?I8wzVp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C159BB038FFC84BA33A587780B7D1B3@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1434.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31544a76-5c69-4cbb-01d3-08dd5202422d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 22:59:40.9946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ssrO9rtcUjC8sTZKa1ZaWEiwMXJ37N1qScf04vlaZH49lufKC91D+u11iqrgPr6MQSPoMWt0znUuEpY3WKGMsLnInywEkW6inmATM1lq9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3268

DQoNCk9uIDIvMjAvMjUgMTQ6NTYsIEVhc3dhciBIYXJpaGFyYW4gd3JvdGU6DQogPiBPbiAyLzIw
LzIwMjUgMTo1OSBQTSwgTVVLRVNIIFJBVEhPUiB3cm90ZToNCiA+Pg0KID4+DQogPj4gT24gMi8y
MC8yNSAxMDozMywgTnVubyBEYXMgTmV2ZXMgd3JvdGU6DQogPj4gICA+IEludHJvZHVjZSBodl9j
dXJyZW50X3BhcnRpdGlvbl90eXBlIHRvIHN0b3JlIHRoZSBwYXJ0aXRpb24gdHlwZQ0KID4+ICAg
PiBhcyBhbiBlbnVtLg0KID4+ICAgPg0KID4+ICAgPiBSaWdodCBub3cgdGhpcyBpcyBsaW1pdGVk
IHRvIGd1ZXN0IG9yIHJvb3QgcGFydGl0aW9uLCBidXQgdGhlcmUgd2lsbA0KID4+ICAgPiBiZSBv
dGhlciBraW5kcyBpbiBmdXR1cmUgYW5kIHRoZSBlbnVtIGlzIGVhc2lseSBleHRlbnNpYmxlLg0K
ID4+ICAgPg0KID4+ICAgPiBTZXQgdXAgaHZfY3VycmVudF9wYXJ0aXRpb25fdHlwZSBlYXJseSBp
biBIeXBlci1WIGluaXRpYWxpemF0aW9uDQp3aXRoDQogPj4gICA+IGh2X2lkZW50aWZ5X3BhcnRp
dGlvbl90eXBlKCkuIGh2X3Jvb3RfcGFydGl0aW9uKCkganVzdCBxdWVyaWVzIHRoaXMNCiA+PiAg
ID4gdmFsdWUsIGFuZCBzaG91bGRuJ3QgYmUgY2FsbGVkIGJlZm9yZSB0aGF0Lg0KID4+ICAgPg0K
ID4+ICAgPiBNYWtpbmcgdGhpcyBjaGVjayBpbnRvIGEgZnVuY3Rpb24gc2V0cyB0aGUgc3RhZ2Ug
Zm9yIGFkZGluZyBhIGNvbmZpZw0KID4+ICAgPiBvcHRpb24gdG8gZ2F0ZSB0aGUgY29tcGlsYXRp
b24gb2Ygcm9vdCBwYXJ0aXRpb24gY29kZS4gSW4NCnBhcnRpY3VsYXIsDQogPj4gICA+IGh2X3Jv
b3RfcGFydGl0aW9uKCkgY2FuIGJlIHN0dWJiZWQgb3V0IGFsd2F5cyBiZSBmYWxzZSBpZiByb290
DQogPj4gICA+IHBhcnRpdGlvbiBzdXBwb3J0IGlzbid0IGRlc2lyZWQuDQogPj4gICA+DQogPj4g
ICA+IFNpZ25lZC1vZmYtYnk6IE51bm8gRGFzIE5ldmVzIDxudW5vZGFzbmV2ZXNAbGludXgubWlj
cm9zb2Z0LmNvbT4NCiA+PiAgID4gLS0tDQogPj4gICA+ICAgYXJjaC9hcm02NC9oeXBlcnYvbXNo
eXBlcnYuYyAgICAgICB8ICAyICsrDQogPj4gICA+ICAgYXJjaC94ODYvaHlwZXJ2L2h2X2luaXQu
YyAgICAgICAgICB8IDEwICsrKystLS0tLQ0KID4+ICAgPiAgIGFyY2gveDg2L2tlcm5lbC9jcHUv
bXNoeXBlcnYuYyAgICAgfCAyNCArKy0tLS0tLS0tLS0tLS0tLS0tLQ0KID4+ICAgPiAgIGRyaXZl
cnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMgfCAgNCArKy0tDQogPj4gICA+ICAgZHJpdmVy
cy9odi9odi5jICAgICAgICAgICAgICAgICAgICB8IDEwICsrKystLS0tLQ0KID4+ICAgPiAgIGRy
aXZlcnMvaHYvaHZfY29tbW9uLmMgICAgICAgICAgICAgfCAzNQ0KKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tDQogPj4gICA+ICAgZHJpdmVycy9odi92bWJ1c19kcnYuYyAgICAgICAgICAg
ICB8ICAyICstDQogPj4gICA+ICAgZHJpdmVycy9pb21tdS9oeXBlcnYtaW9tbXUuYyAgICAgICB8
ICA0ICsrLS0NCiA+PiAgID4gICBpbmNsdWRlL2FzbS1nZW5lcmljL21zaHlwZXJ2LmggICAgIHwg
MTUgKysrKysrKysrKystLQ0KID4+ICAgPiAgIDkgZmlsZXMgY2hhbmdlZCwgNjEgaW5zZXJ0aW9u
cygrKSwgNDUgZGVsZXRpb25zKC0pDQogPj4gICA+DQogPg0KID4gPHNuaXA+DQogPg0KID4+ICAg
PiBAQCAtMzQsOCArMzQsMTEgQEANCiA+PiAgID4gICB1NjQgaHZfY3VycmVudF9wYXJ0aXRpb25f
aWQgPSBIVl9QQVJUSVRJT05fSURfU0VMRjsNCiA+PiAgID4gICBFWFBPUlRfU1lNQk9MX0dQTCho
dl9jdXJyZW50X3BhcnRpdGlvbl9pZCk7DQogPj4gICA+DQogPj4gICA+ICtlbnVtIGh2X3BhcnRp
dGlvbl90eXBlIGh2X2N1cnJlbnRfcGFydGl0aW9uX3R5cGU7DQogPj4gICA+ICtFWFBPUlRfU1lN
Qk9MX0dQTChodl9jdXJyZW50X3BhcnRpdGlvbl90eXBlKTsNCiA+PiAgID4gKw0KID4+DQogPj4g
bml0OiBpZiBwb3NzaWJsZSBhbmQgbm90IHRvbyBsYXRlLCBjYW4gd2UgcGxlYXNlIHVzZSBtb3Jl
IFVuaXgNCiA+PiBzdHlsZSBuYW1pbmcsIGVnLCBodl9jdXJyX3B0aWQgYW5kIGh2X2N1cnJfcHRf
dHlwZSByYXRoZXIgdGhhbiB0aGlzDQogPj4gbG9uZyB3aW5kb3dzIHN0eWxlIG5hbWVzIHRoYXQg
Y2F1c2VzIHVubmVjZXNzYXJ5IGxpbmUgd3JhcHMvc3BsaXRzLg0KID4+DQogPj4gVGhhbmtzLA0K
ID4+IC1NdWtlc2gNCiA+Pg0KID4NCiA+IFBlcg0KaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvcHJv
Y2Vzcy9jb2Rpbmctc3R5bGUuaHRtbCNuYW1pbmcNCiA+DQogPiBHTE9CQUwgdmFyaWFibGVzICh0
byBiZSB1c2VkIG9ubHkgaWYgeW91IHJlYWxseSBuZWVkIHRoZW0pIG5lZWQgdG8NCmhhdmUgZGVz
Y3JpcHRpdmUgbmFtZXMsDQogPiBhcyBkbyBnbG9iYWwgZnVuY3Rpb25zLiBJZiB5b3UgaGF2ZSBh
IGZ1bmN0aW9uIHRoYXQgY291bnRzIHRoZSBudW1iZXINCm9mIGFjdGl2ZSB1c2VycywNCiA+IHlv
dSBzaG91bGQgY2FsbCB0aGF0IGNvdW50X2FjdGl2ZV91c2VycygpIG9yIHNpbWlsYXIsIHlvdSBz
aG91bGQgbm90DQpjYWxsIGl0IGNudHVzcigpLg0KDQpUaGFudCdzIGhhcmRseSBhIGZhaXIgY29t
cGFyaXNvbi4gU3VnZ2VzdGlvbiB3YXMgTk9UIGh2cHRpZC4NCg0KVGhhbmtzLA0KLU11a2VzaA0K
DQo=

