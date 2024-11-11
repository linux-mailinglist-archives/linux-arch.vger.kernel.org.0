Return-Path: <linux-arch+bounces-8979-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8539C45E0
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 20:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9EC01F22AA9
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 19:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4606F15699D;
	Mon, 11 Nov 2024 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MsYh8dgM"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2010.outbound.protection.outlook.com [40.92.22.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8451BC4E;
	Mon, 11 Nov 2024 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731353471; cv=fail; b=RYmpxmsjl2KdbEL1qXmRsDuGOfnfq04opNDbwwBHFH8/esv9h1cg9wrJK8yBERnpS/EP0JB7M/u9IswmTKvalReL5EjQ0Dc/cLUFyhK55g/DjCJONrR5X0jPkA3XebZ9wpMfmhbuemFsCIunVQy8YTlQ0h97/Xy3F2lJGdcbMyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731353471; c=relaxed/simple;
	bh=0NzNy1TVVoDo9XZ7fhRN08QkkpcWh2vpeS5XhFFXuT4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kC/NRwfT9jXjEwe94YV1juh67bt+g+HiF905UV+J1z117XUL1/0Utaaj+sAY69m7+KZEG5d7+H6AVwrKhjFII6sk5AkqoK1Tk5SQ3BGvLXraGul8VCYviaWFz20DlCNbFrgh8lsPHLLYgIsOGjlj2ZGv6C3bhW2ljdTDXfh62Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MsYh8dgM; arc=fail smtp.client-ip=40.92.22.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2oMDexs9oBusudqRseyufQIoLhJdrj4cmFLW0LEii5p2OF1MdTB6DRpUNjoaph+AZgIFgpUNkMrxizqs2LkuzKh5owNzkbI31uAzQX8B6RmR3C2xbHBT8gEgWfmKOwtE6RUydNU7M/ECfzvp84Ln5iQpEsJXPGcG4QHXFpY5UTrr+RqcSN3WXZnp4O5bZT32Wey/yGlPaxfj2amBBbdURgdGBjU+ezduUPBlBOhI+k0lYh9kJbxmQc5+gTDP2PpNyjncJILSp5ZThmJvxJa4/FplpHI160MGPn7dxeofCQbpo/5EVP2uvgyNoNW6pI85xE/scbWrn0EzvyAds+qIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NzNy1TVVoDo9XZ7fhRN08QkkpcWh2vpeS5XhFFXuT4=;
 b=qqnmexo5O+MsftnBPcGr1I4yNxBYM+eRB/QJQ6yl06vDj72nrsI6Q8yl8U0w/8OETeT4biWr3ZtRaXwg/WbYSVbhvbfStqzPJBNtnRa+mrjib/hQhNLqguckr+nr8aDWd7WwcB7oup5AUEQ/u36/VXDpu1HnfPzAm3b6Y3lZyKr/QwaHTVwFUYOD6dgVRhpSLGVvV9Ugl+SACUJkE5blDHuiO/R7qDxPH+mcwsKrs6vXbKZSbrgjnqpiHYdyza9kAOe3J5RLFmoQjrLc8HNcjQA81oDR6NS9sWJ8b0wtEbHRZK1XOq8A7vrosZbYYQFE04Iccb2GQQvvl4EhCCEyew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NzNy1TVVoDo9XZ7fhRN08QkkpcWh2vpeS5XhFFXuT4=;
 b=MsYh8dgMcHQhC+d11G6qAaIitgMOsAzJ8yw1lZM4ah8QetfglxQEOT3oi6B9eRJhBi7a6OKyuUhpiEResSjDslIPpRlGXe++i14TvMv8G387bDq411GIhLDAWopfitYCUMQjf7MGmeMq0sh27SP4e5/MXhSbb9o5u7uABZ8HVwh/wnA3xV5MkBUXR3HUUflKtkzhNpZrwq0X5Ux2zrMjTZReWXbFa4SaAIfY2IYXaXfBcbvlS89gvHvspQddW3zR3rvGR8lZLIBFJbtO9GGXKab5XpJoG458AONysoYmdC+uaVH8HKBxGSl1MRAqddj0Nwt2+VMkoc68cKrb1R1WDA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7272.namprd02.prod.outlook.com (2603:10b6:510:9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Mon, 11 Nov
 2024 19:31:04 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 19:31:04 +0000
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
	<apais@linux.microsoft.com>
Subject: RE: [PATCH v2 3/4] hyperv: Add new Hyper-V headers in include/hyperv
Thread-Topic: [PATCH v2 3/4] hyperv: Add new Hyper-V headers in include/hyperv
Thread-Index: AQHbMWTz51b/qQ1OyEGQBgbf6nEfW7KvrjVwgALCugCAAAhu4A==
Date: Mon, 11 Nov 2024 19:31:04 +0000
Message-ID:
 <SN6PR02MB4157AA30A9F27ECCAE202BC2D4582@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1731018746-25914-4-git-send-email-nunodasneves@linux.microsoft.com>
 <BN7PR02MB4148025D8757B917013297E0D4582@BN7PR02MB4148.namprd02.prod.outlook.com>
 <b8ef1f71-9f13-48c3-adab-aa52b68d2e33@linux.microsoft.com>
In-Reply-To: <b8ef1f71-9f13-48c3-adab-aa52b68d2e33@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7272:EE_
x-ms-office365-filtering-correlation-id: 5487bce5-52d8-4187-2a0f-08dd02876218
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|8062599003|461199028|19110799003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1JzZHJxMXpqU2krbGdFNXBBaS9FK2FwZTZJR3BCckwyWitucG9hMGNGMFFS?=
 =?utf-8?B?VWJPd3pXWGFlSFQweGphaXVPSklVeTZtdmJBYXJ2aHphYTEvY0c5RWJ2UzI2?=
 =?utf-8?B?Y2M4dG1hWHJLTFpVQjVFNnVJUHdlemlyRHpTY3JEUTF6Q0x6VUltM2RrSzhL?=
 =?utf-8?B?SHpYdEVnWnQ0dUpqYkt1Y1B6cFdRUkN5cXNaNFc2dmNPcVJDaWc5M2hmdXUr?=
 =?utf-8?B?YTEvczZmVzE4VExCTmQyUjAwbS9RMkhSM1RGMUxiS3h5MkhGSkFxK2tCdWRS?=
 =?utf-8?B?bEVjaWZSN2tiaVQ5eUo0NDFTcy9KQ3ZJQ3BCanJ3U1JhcFdURlA1NnZOMHlZ?=
 =?utf-8?B?OU5OY1FzOTdKTklBVWp3Wjk4eTdOajVxSzhUbTJWNUlsUjhwYkwxUkpZZVdN?=
 =?utf-8?B?eDA5VWlxN2NBa1BPNkNVTnBjc1hIL2pSUFNWcnNvbGJPT0VlaXdJMkNETVVr?=
 =?utf-8?B?TzNGZ0pNeS9HSDZRSFNNTk5pUUhYbjNLNkZ5dFRRY2RaeGpaa2JCRlpGTjFx?=
 =?utf-8?B?QUQ3RHJuUTFlMzNEM2c5QzRBZ3Z0aDJRaTJnQTM4RUR4L0ZqeDlhY2x2d0ZF?=
 =?utf-8?B?c1V1U283ZFRBdzhiMFZuZks0S0tIT29mckwycUdHZy9Lc3J2L0NCVE5pd0lF?=
 =?utf-8?B?bm5PZ3JsV2ZrZ1NwVXdWRDNQMmUvMldLUGU3bnUwL3FJOEN6TFZjRld4a0RB?=
 =?utf-8?B?cUt6dlNGbjM1SjdoNHFVQVR6SVpIZ3JvODNEVDA2NW1xcVRqejZ5cHlMVk5i?=
 =?utf-8?B?OEhEZURTOWFxSEYrd1dNdk1jT2ozSldpVlkzb3BqR2xBcWxHZkloOGRiNkVs?=
 =?utf-8?B?MDBjcGFjZ0lpU2FmRmZJaG9hSXVZZnhyY1hFa1p5Y0llVXF1cUNSWmpoSXdT?=
 =?utf-8?B?M2xyTUZVbjFRVDc5TjE2OW0xNGxqUUY1S0orMDNHU1Z5aUVLdmdBalR6N213?=
 =?utf-8?B?WEtmTUxsZ2pjaGFuNVhqSkEyQmQ3VWUweVVGcVE0V0gzVlRhTllFLzR0VEdk?=
 =?utf-8?B?U0t5ZTlTVzdNa3ptaVpOZmFqai81M3Z6WXNlZ1NaRldtRHBjanc0a1diWEVa?=
 =?utf-8?B?MGJlaGhWei9Sa3NOcnpiaTJjOFd5UjBqN3pBcDZXYkovN0oyZ1FtakMxRC9t?=
 =?utf-8?B?dm1lSndQMTJuU2J0cURhMmRoNXlTREhlSjlNYXo5SGJONGNRN09GVXV4cFlG?=
 =?utf-8?B?b0xDMWpFTmZreSs5ODlwQzVOMTRPbWZLV0Y5SWN2Z0RadHFBZk1CSjFzSVZF?=
 =?utf-8?B?QlEzZnYvYTR3c2xjdXl1MmFYVmdZSzBzYm1wcDA4TmNnUjVoZU4xbk8xRFNV?=
 =?utf-8?B?eVNuWHVEaXEzOE9lMlhUc0x2bGlUMmV0YmxwVXNIQldFODVjbDJxK29hL1Rl?=
 =?utf-8?B?Z1lvWFJ5UnBFcXc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2Q2K3RZVmZFOWx3c3c1WmFDVkdta25lMmJTcWxPcE02eGI4Q2NNeXV2ZHBI?=
 =?utf-8?B?b1Y3MFF2MEZsZDcxNHdpSkpjRUFsdTBzMmpPNWtSbDdGRk5wMGN0WUZoakpH?=
 =?utf-8?B?V2xuWUFZZU0vQjZCZjJMQ1dxZlNLUnVPTklMc29zZllyMXloYmpaak4xekNY?=
 =?utf-8?B?UTFSa1dvcVAwQjB2M0NaYlB0bjRmT2xwQmNMN1Vqcjl1d0oxMVdDcUp5ZEd3?=
 =?utf-8?B?bkZzcHJrOHNwTFVXR0tldDNkS1pTOGRocnRyWGdIR2FtWTdiMzMrRnFvalNN?=
 =?utf-8?B?UTFDYmRnVHhqc0hGdndqb1lGd3BreUxCb2p4VUZsbmhFaGViOXppVjMzUG8z?=
 =?utf-8?B?VDRLR3ZvZnZ5VkgrdXlIMndneFkzOENkQ3JpT2NDK0ppMk02U3U0NFVHL2tO?=
 =?utf-8?B?Z1Q2RnYvYjJ3bGYwOVpCZml4YmJDMEhJdDR2dGYrVEJxQmgva0hGcGlaamxP?=
 =?utf-8?B?MEZiSGk4U1RDbHpGaWxpYlRNSFVMK3p6bzA3NkZTd3cyeGxVVGR3eDkxeW5E?=
 =?utf-8?B?d2Q0eEZSNzhUZ0Q4SmQ0RzhzMjA0VHh3MmxIQmJVTW1oQXZVK2hFRGJrclNV?=
 =?utf-8?B?M21CNktTVGVSQ1F1ZHVGVXpmTGNCQjBUNnl5QjRZdTdmVXJUeEhrUWVGTGha?=
 =?utf-8?B?VUIzK2FxMTUvZVVPZHJFL1V0YVUzOUtSUHBSMk5MWkNyeFNZdmVxYnZXK2VE?=
 =?utf-8?B?OWkyTjJ3OThSRVJhVGpQMS9sZnBIaFhwQlJGN29MVWNiMnZBeWpkTVhqalkz?=
 =?utf-8?B?TnRBMUVsZTA4RWxUaExrcWRDdjE5bUlKOGJDZmVaV0MxS1FnaGovQjJpUmpo?=
 =?utf-8?B?M09sbGNmOWdrenV4bVhCTGRoZmZIUVl3bEtUMC9kQzBrM2J4Y1dRRVlEUHR0?=
 =?utf-8?B?WjVubDJuVmVQZTEzS3RtOXNOVUxscm8yemNLcmFocXp4SmNsamFvblhBVVZq?=
 =?utf-8?B?cERGMGNyWWk1YkJnN3dnRlNoeEs3Zy92bUM1ZVB4WURPVzJIVCtBY2tDQ0g0?=
 =?utf-8?B?dVlyUFdnMmUrdEU4bUVkZXlNcUZDblpFa2NkTkR5QzlXRTRXc0FNUWdJY2Zi?=
 =?utf-8?B?VHlHaWZRVzE3Sm5FZFVBSDczeGJDQjFZWUNjWUpGVk9RMVN1VW5qQlJiQzk3?=
 =?utf-8?B?cnFYZHBRWHBLbmR2UlBNY2p3aTA4a3VnVzhycXVYdXpSMGJlUjRhWXV2SXJa?=
 =?utf-8?B?TDRkSkdreU1QQ0hSMWlBd2trSU5qT0N3YVhaV3B4Vkp1Qmp5NjhNZkFlbmN0?=
 =?utf-8?B?SFMxNlVDRUN2cHBHWHg3YVdNcy9rYzk5QWpXMlMxRklCYlNqbXY2dldraXZL?=
 =?utf-8?B?WURaRXZJR2FOQWlNc0hwZ0F5aXVaWlRpeUVva3YvVENuUFZMdSt0R2pya3Q3?=
 =?utf-8?B?QTU1K2twemVUbldja3BPSGR5aEJFZ0VacHNta1JITVBFUGpmMnhHczJNR01I?=
 =?utf-8?B?eGZMUndzYkZpaG5telUrOUdISnlISDZNVVB2S1hjOHpTVFZUUXpqczFiV3pH?=
 =?utf-8?B?QVRmSkZGRmJXNnA1dmpIWlJuL2crSGNoUHlJQkVVd1NiYlZ2bjlWY281WWV2?=
 =?utf-8?B?WVNPOHpDb3lnN014alNnckg2VHZZcFVVbG1lbngyZ3FsT0JXTlZlU2FXNmpI?=
 =?utf-8?Q?VUBYxPmtYAFwgrSQ9yhRKZpBuiky7Ux4cYGrJWK6qIng=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5487bce5-52d8-4187-2a0f-08dd02876218
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 19:31:04.5942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7272

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBNb25kYXksIE5vdmVtYmVyIDExLCAyMDI0IDEwOjQ1IEFNDQo+IA0KPiBPbiAxMS8xMC8y
MDI0IDg6MTMgUE0sIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+IEZyb206IE51bm8gRGFzIE5l
dmVzIDxudW5vZGFzbmV2ZXNAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogVGh1cnNkYXksDQo+
IE5vdmVtYmVyIDcsIDIwMjQgMjozMiBQTQ0KPiA+Pg0KPiA+PiBUaGVzZSBoZWFkZXJzIGNvbnRh
aW4gZGVmaW5pdGlvbnMgZm9yIHJlZ3VsYXIgSHlwZXItViBndWVzdHMgKGFzIGluDQo+ID4+IGh5
cGVydi10bGZzLmgpLCBhcyB3ZWxsIGFzIGludGVyZmFjZXMgZm9yIG1vcmUgcHJpdmlsZWdlZCBn
dWVzdHMgbGlrZQ0KPiA+PiBEb20wLg0KPiA+DQo+ID4gU2VlIG15IGNvbW1lbnQgb24gUGF0Y2gg
MC80IGFib3V0IHVzZSBvZiAiZG9tMCIgdGVybWlub2xvZ3kuDQo+ID4NCj4gDQo+IFRoYW5rcywg
bm90ZWQuDQo+IA0KPiA+Pg0KPiA+PiBUaGVzZSBmaWxlcyBhcmUgZGVyaXZlZCBmcm9tIGhlYWRl
cnMgZXhwb3J0ZWQgZnJvbSBIeXBlci1WLCByYXRoZXIgdGhhbg0KPiA+PiBiZWluZyBkZXJpdmVk
IGZyb20gdGhlIFRMRlMgZG9jdW1lbnQuIChBbHRob3VnaCwgdG8gcHJlc2VydmUNCj4gPj4gY29t
cGF0aWJpbGl0eSB3aXRoIGV4aXN0aW5nIExpbnV4IGNvZGUsIHNvbWUgZGVmaW5pdGlvbnMgYXJl
IGNvcGllZA0KPiA+PiBkaXJlY3RseSBmcm9tIGh5cGVydi10bGZzLmggdG9vKS4NCj4gPj4NCj4g
Pj4gVGhlIG5ldyBmaWxlcyBmb2xsb3cgYSBuYW1pbmcgY29udmVudGlvbiBhY2NvcmRpbmcgdG8g
dGhlaXIgb3JpZ2luYWwNCj4gPj4gdXNlOg0KPiA+PiAtIGhkayAiaG9zdCBkZXZlbG9wbWVudCBr
aXQiDQo+ID4+IC0gZ2RrICJndWVzdCBkZXZlbG9wbWVudCBraXQiDQo+ID4+IFdpdGggcG9zdGZp
eCAiX21pbmkiIGltcGx5aW5nIHVzZXJzcGFjZS1vbmx5IGhlYWRlcnMsIGFuZCAiX2V4dCIgZm9y
DQo+ID4+IGV4dGVuZGVkIGh5cGVyY2FsbHMuDQo+ID4+DQo+ID4+IFRoZXNlIG5hbWVzIHNob3Vs
ZCBiZSBjb25zaWRlcmVkIGEgcm91Z2ggZ3VpZGUgb25seSAtIHNpbmNlIHRoZXJlIGFyZQ0KPiA+
PiBtYW55IHBsYWNlcyBhbHJlYWR5IHdoZXJlIGJvdGggaG9zdCBhbmQgZ3Vlc3QgY29kZSBhcmUg
aW4gdGhlIHNhbWUNCj4gPj4gcGxhY2UsIGh2aGRrLmggKHdoaWNoIGluY2x1ZGVzIGV2ZXJ5dGhp
bmcpIGNhbiBiZSB1c2VkIG1vc3Qgb2YgdGhlIHRpbWUuDQo+ID4NCj4gPiBKdXN0IGN1cmlvdXMg
LS0gYXJlIHRoZXJlIHJlYWxseSBjYXNlcyB3aGVyZSBodmhkay5oIGNhbid0IGJlIHVzZWQ/DQo+
ID4gSWYgc28sIGNvdWxkIHlvdSBzdW1tYXJpemUgd2h5Pw0KPiA+DQo+IA0KPiBObywgdGhlcmUg
YXJlbid0IGNhc2VzIHdoZXJlIGl0ICJjYW4ndCIgYmUgdXNlZC4gSSBzdXBwb3NlIGlmIHNvbWVv
bmUNCj4gZG9lc24ndCB3YW50IHRvIGluY2x1ZGUgZXZlcnl0aGluZywgcGVyaGFwcyB0aGV5IGNv
dWxkIGp1c3QgaW5jbHVkZQ0KPiBodmdkay5oLCBmb3IgZXhhbXBsZS4gSXQgZG9lc24ndCByZWFs
bHkgbWF0dGVyIHRob3VnaC4NCj4gDQo+ID4gSSBhc2sgYmVjYXVzZSBpdCB3b3VsZCBiZSBuaWNl
IHRvIGV4cGFuZCBzbGlnaHRseSBvbiB5b3VyIHBhcmFncmFwaA0KPiA+IGJlbG93LCBhcyBmb2xs
b3dzOiAgKGlmIGluZGVlZCB3aGF0IEkndmUgYWRkZWQgaXMgY29ycmVjdCkNCj4gPg0KPiA+IFRo
ZSB1c2Ugb2YgbXVsdGlwbGUgZmlsZXMgYW5kIHRoZWlyIG9yaWdpbmFsIG5hbWVzIGlzIHByaW1h
cmlseSB0bw0KPiA+IGtlZXAgdGhlIHByb3ZlbmFuY2Ugb2YgZXhhY3RseSB3aGVyZSB0aGV5IGNh
bWUgZnJvbSBpbiBIeXBlci1WDQo+ID4gY29kZSwgd2hpY2ggaXMgaGVscGZ1bCBmb3IgbWFudWFs
IG1haW50ZW5hbmNlIGFuZCBleHRlbnNpb24NCj4gPiBvZiB0aGVzZSBkZWZpbml0aW9ucy4gTWlj
cm9zb2Z0IG1haW50YWluZXJzIGltcG9ydGluZyBuZXcgZGVmaW5pdGlvbnMNCj4gPiBzaG91bGQg
dGFrZSBjYXJlIHRvIHB1dCB0aGVtIGluIHRoZSByaWdodCBmaWxlLiBIb3dldmVyLCBMaW51eCBr
ZXJuZWwgY29kZQ0KPiA+IHRoYXQgdXNlcyBhbnkgb2YgdGhlIGRlZmluaXRpb25zIG5lZWQgbm90
IGJlIGF3YXJlIG9mIHRoZSBtdWx0aXBsZSBmaWxlcw0KPiA+IG9yIGFzc2lnbiBhbnkgbWVhbmlu
ZyB0byB0aGUgbmV3IG5hbWVzLiBMaW51eCBrZXJuZWwgdXNlcyBzaG91bGQNCj4gPiBhbHdheXMg
anVzdCBpbmNsdWRlIGh2aGRrLmgNCj4gPg0KPiANCj4gVGhhbmtzLCBJIHRoaW5rIHRoYXQgYWRk
aXRpb25hbCBzZW50ZW5jZSBoZWxwcyBjbGFyaWZ5IHRoaW5ncy4gSSdsbA0KPiBpbmNsdWRlIGl0
IGluIHRoZSBuZXh0IHZlcnNpb24sIGFuZCBJIHRoaW5rIEkgY2FuIHByb2JhYmx5IG9taXQgdGhl
IHByaW9yDQo+IHBhcmFncmFwaDogIlRoZXNlIG5hbWVzIHNob3VsZCBiZSBjb25zaWRlcmVkIGEg
cm91Z2ggZ3VpZGUgb25seS4uLiIuDQo+IA0KDQpPbWl0dGluZyB0aGF0IHByaW9yIHBhcmFncmFw
aCBpcyBPSyB3aXRoIG1lLiAgVGhlIGtleSB0aG91Z2h0cyBmcm9tIG15DQpzdGFuZHBvaW50IGFy
ZToNCiogVGhlIHNlcGFyYXRpb24gaW50byBtdWx0aXBsZSBmaWxlcyBhbmQgdGhlIGZpbGUgbmFt
ZXMgY29tZSBmcm9tDQogICB0aGUgV2luZG93cyBIeXBlci1WIHdvcmxkIGFuZCBhcmUgbWFpbnRh
aW5lZCB0byBlYXNlIGJyaW5naW5nDQogICB0aGUgZGVmaW5pdGlvbnMgb3ZlciBmcm9tIHRoYXQg
d29ybGQNCiAgIA0KKiBMaW51eCBjb2RlIGNhbiBpZ25vcmUgdGhlIG11bHRpcGxlIGZpbGVzIGFu
ZCB0aGVpciBuYW1lcy4gSnVzdA0KICAgI2luY2x1ZGUgaHZoZGsuaC4NCg0KPiA+Pg0KPiA+PiBU
aGUgb3JpZ2luYWwgbmFtZXMgYXJlIGtlcHQgaW50YWN0IHByaW1hcmlseSB0byBrZWVwIHRoZSBw
cm92ZW5hbmNlIG9mDQo+ID4+IGV4YWN0bHkgd2hlcmUgdGhleSBjYW1lIGZyb20gaW4gSHlwZXIt
ViBjb2RlLCB3aGljaCBpcyBoZWxwZnVsIGZvcg0KPiA+PiBtYW51YWwgbWFpbnRlbmFuY2UgYW5k
IGV4dGVuc2lvbiBvZiB0aGVzZSBkZWZpbml0aW9ucy4gTWljcm9zb2Z0DQo+ID4+IG1haW50YWlu
ZXJzIGltcG9ydGluZyBuZXcgZGVmaW5pdGlvbnMgc2hvdWxkIHRha2UgY2FyZSB0byBwdXQgdGhl
bSBpbg0KPiA+PiB0aGUgcmlnaHQgZmlsZS4NCj4gPj4NCj4gPj4gTm90ZSBhbHNvIHRoYXQgdGhl
IGZpbGVzIGNvbnRhaW4gYm90aCBhcm02NCBhbmQgeDg2XzY0IGNvZGUgZ3VhcmRlZCBieQ0KPiA+
PiBcI2lmZGVmcywgd2hpY2ggaXMgaG93IHRoZSBkZWZpbml0aW9ucyBvcmlnaW5hbGx5IGFwcGVh
ciBpbiBIeXBlci1WLg0KPiA+DQo+ID4gU3B1cmlvdXMgYmFja3NsYXNoPw0KPiA+DQo+IA0KPiBJ
bmRlZWQsIHRoYW5rcy4NCj4gDQo+ID4gSSB3b3VsZCBzdWdnZXN0IHNvbWUgYWRkaXRpb25hbCBj
bGFyaWZpY2F0aW9uOiAgVGhlICNpZmRlZiBndWFyZHMgYXJlDQo+ID4gZW1wbG95ZWQgbWluaW1h
bGx5IHdoZXJlIG5lY2Vzc2FyeSB0byBwcmV2ZW50IGNvbmZsaWN0cyBkdWUgdG8NCj4gPiBkaWZm
ZXJlbnQgZGVmaW5pdGlvbnMgZm9yIHRoZSBzYW1lIHRoaW5nIG9uIHg4Nl82NCBhbmQgYXJtNjQu
IFdoZXJlDQo+ID4gdGhlcmUgYXJlIG5vIGNvbmZsaWN0cywgdGhlIHVuaW9uIG9mIHg4Nl82NCBk
ZWZpbml0aW9ucyBhbmQgYXJtNjQNCj4gPiBkZWZpbml0aW9ucyBpcyB2aXNpYmxlIHdoZW4gYnVp
bGRpbmcgZm9yIGVpdGhlciBhcmNoaXRlY3R1cmUuIEluIG90aGVyDQo+ID4gd29yZHMsIG5vdCBh
bGwgZGVmaW5pdGlvbnMgc3BlY2lmaWMgdG8geDg2XzY0IGFyZSBwcm90ZWN0ZWQgYnkgI2lmZGVm
DQo+ID4geDg2XzY0LiBTdWNoIHVucHJvdGVjdGVkIGRlZmluaXRpb25zIG1heSBiZSB2aXNpYmxl
IHdoZW4gYnVpbGRpbmcNCj4gPiBmb3IgYXJtNjQuIEFuZCB2aWNlIHZlcnNhLg0KPiA+DQo+IA0K
PiBJcyB0aGVyZSBhIHJlYXNvbiB5b3Ugc3BlY2lmaWNhbGx5IHdhbnQgdG8gcG9pbnQgb3V0IHRo
YXQgIlN1Y2gNCj4gdW5wcm90ZWN0ZWQgZGVmaW5pdGlvbnMgbWF5IGJlIHZpc2libGUgd2hlbiBi
dWlsZGluZyBmb3IgYXJtNjQuIEFuZCB2aWNlDQo+IHZlcnNhLiI/IEkgdGhpbmssIGluIGFsbCB0
aGUgY2FzZXMgd2hlcmUgI2lmZGVmcyBhcmUgbm90IHVzZWQsIGFuDQo+IGFyY2gtc3BlY2lmaWMg
cHJlZml4IGlzIHVzZWQgLSBodl94NjRfIG9yIGh2X2FybTY0Xy4NCj4gDQo+IFRoZSBtYWluIHRo
aW5nIEkgd2FudGVkIHRvIGNhbGwgb3V0IGhlcmUgd2FzIHRoZSByZWFzb25pbmcgZm9yIG5vdA0K
PiBzcGxpdHRpbmcgYXJjaC1zcGVjaWZpYyBkZWZpbml0aW9ucyBpbnRvIHNlcGFyYXRlIGZpbGVz
IGluIGFyY2gveDg2Lw0KPiBhbmQgYXJjaC9hcm02NC8gYXMgaXMgdHlwaWNhbCBpbiBMaW51eC4N
Cj4gDQo+IE1heWJlIHRoaXMgaXMgYSBiaXQgY2xlYXJlcjoNCj4gIg0KPiBOb3RlIHRoZSBuZXcg
aGVhZGVycyBjb250YWluIGJvdGggYXJtNjQgYW5kIHg4Nl82NCBkZWZpbml0aW9ucy4gU29tZSBh
cmUNCj4gZ3VhcmRlZCBieSAjaWZkZWZzLCBhbmQgc29tZSBhcmUgaW5zdGVhZCBwcmVmaXhlZCB3
aXRoIHRoZSBhcmNoaXRlY3R1cmUsDQo+IGUuZy4gaHZfeDY0XyouIFRoZXNlIGNvbnZlbnRpb25z
IGFyZSBrZXB0IGZyb20gSHlwZXItViBjb2RlIGFzIGFub3RoZXINCj4gdGFjdGljIHRvIHNpbXBs
aWZ5IHRoZSBwcm9jZXNzIG9mIGltcG9ydGluZyBhbmQgbWFpbnRhaW5pbmcgdGhlDQo+IGRlZmlu
aXRpb25zLCByYXRoZXIgdGhhbiBzcGxpdHRpbmcgdGhlbSB1cCBpbnRvIHRoZWlyIG93biBmaWxl
cyBpbg0KPiBhcmNoL3g4Ni8gYW5kIGFyY2gvYXJtNjQvLg0KPiAiDQoNClllcywgeW91ciBuZXcg
cGFyYWdyYXBoIHdvcmtzIGZvciBtZS4gWW91ciBvcmlnaW5hbCBzdGF0ZW1lbnQgd2FzDQoidGhl
IGZpbGVzIGNvbnRhaW4gYm90aCBhcm02NCBhbmQgeDg2XzY0IGNvZGUgZ3VhcmRlZCBieSAjaWZk
ZWZzIiwNCndoaWNoIHNvdW5kcyBsaWtlIHRoZSBtb3JlIHR5cGljYWwgTGludXggYXBwcm9hY2gg
b2YgdXNpbmcgI2lmZGVmcw0KdG8gc2VncmVnYXRlIGludG8geDg2LXNwZWNpZmljLCBhcm02NC1z
cGVjaWZpYywgYW5kIGNvbW1vbi4gSSB3YXMNCmp1c3QgdHJ5aW5nIHRvIGJlIGV4cGxpY2l0IHRo
YXQgZnVsbCBzZWdyZWdhdGlvbiBpc24ndCBkb25lLCBhbmQgaXNuJ3QgYQ0KZ29hbCwgYmVjYXVz
ZSBvZiB3YW50aW5nIHRvIG1haW50YWluIGFsaWdubWVudCB3aXRoIHRoZSBvcmlnaW5hbA0KSHlw
ZXItViBkZWZpbml0aW9ucy4NCg0KSXQncyAiSGV5LCB3ZSBrbm93IHdlJ3JlIG5vdCBoYW5kbGlu
ZyB0aGlzIGluIHRoZSB0eXBpY2FsIExpbnV4IHdheSwNCmFuZCBoZXJlJ3Mgd2h5Ii4gWW91ciBy
ZXZpc2VkIHBhcmFncmFwaCBjb3ZlcnMgdGhhdCBpbiBhIGxlc3MNCmhlYXZ5d2VpZ2h0IHdheSB0
aGFuIHdoYXQgSSB3cm90ZS4gOi0pDQoNCk1pY2hhZWwNCg0KPiANCj4gSSBob3BlIGl0J3MgcmVh
c29uYWJseSBjbGVhciB0aGF0IGl0J3MgYSBnb29kIHRyYWRlb2ZmIHRvIGdvIGFnYWluc3QNCj4g
TGludXggY29udmVudGlvbiBpbiB0aGlzIGNhc2UsIHRvIG1ha2UgaXQgZWFzeSB0byBpbXBvcnQg
YW5kIG1haW50YWluDQo+IEh5cGVyLVYgZGVmaW5pdGlvbnMuDQo+IA0KPiBUaGFua3MNCj4gTnVu
bw0KPiANCg==

