Return-Path: <linux-arch+bounces-10556-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A55A6A55629
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 20:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2CB73ADCA2
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 19:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EDD263F5F;
	Thu,  6 Mar 2025 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NScQPZ6H"
X-Original-To: linux-arch@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012013.outbound.protection.outlook.com [52.103.14.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B743C25A652;
	Thu,  6 Mar 2025 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287951; cv=fail; b=cOEq3BnWhjJziLZfckadTMmaiMeYhiKamV7XqYpFdCA8clg+CjWjkw+ZArjSnKIp2iTh7ISYrIaYYRp3QRRoAj4rlpgyXqOiMzugyrnRrtFKLwa3drGIoCpwmyUL9PYHkHpHdJcucRZlWrsqp5PvnGpNRjmPzsPLmlsONM+Dby0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287951; c=relaxed/simple;
	bh=NLojAM2mWVjNCjD9QILFVj9AngNtZSu3Ei5DTUloqk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fSWl2NMJVf4HkaLgU3oqgJUF6huWn4/T4SjuY5J9IBKJkJ7UDzaOHlM9Zy6p6qF88+tKojuVe9jwTMuqvKPpn/7BNyWGS0Inks6BrutjFmAdiHq3iRzKE7iglzv3mskayjKwAWFU2FBRKJzs8FUxj/81Dm6l8PiUAkhWYkxjv3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NScQPZ6H; arc=fail smtp.client-ip=52.103.14.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yt4uuDNxhHPOVfUO+s+qnPzFXCt+wGhwIjS0VfTzqPUyl9RpQWhZ2tcOA71sP15ViVS9veubOzvjoLMdMAED90ihZlAsA2fKOS+DUEtSdr18DQSkoQptKil3BKXLeLBUJnYAcoDMmp45rJWQn1e0aYg0sZAgqoNiWu5vNTZ7OJSlEP/1iSws02qMYmcumf3cEBA5MNQESYR/e7qJIg8S0PY+XeAmQgWrg96N2Ev/PhlQJA9jtOM0GHQ8Gw3z1fTnxOQbSKGydz5e5g2XPCkU0AjNUdWeclPz7jnlrURN3DTHkVMaw6jKOdfY9AWf5Uz1lI6ljo7MNl0S91A1gbW8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLojAM2mWVjNCjD9QILFVj9AngNtZSu3Ei5DTUloqk4=;
 b=LE4WyZ8tYz8MGDsqDEMs/HOGZJBXdc9JCh7j7jxr652YLFhOnMsZJjpZn+OwFbgnBc/ezU7WBYHyJydNhdFSrDfezxjja1xLUmo3wj0MtH0vrI7mcpqD/okjkbsf1joDBzPDt8s+UsZe9X1Xwx9fikREjakr7AWDJIZJhC5FkT3xbJ03osa+ZPOoPnzeAofMxBk1zQDOatz9iW3DnNT3Ou6TVjZhmvVNW5zdiyEx0VkAF8hgTaAATOAKSMAvDcA5xzNhbgCT47MgZkdszIJOq7D+Q0Ol/M2f0GSiWjCPnh3mkuZ0SaSDnZXopegLlYuCxGNdvtTSm+Ipkqivz+9D7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLojAM2mWVjNCjD9QILFVj9AngNtZSu3Ei5DTUloqk4=;
 b=NScQPZ6HM3be+2nBlkxRkxRB6Z/9+bTqwq8XKrxLGODpCRz09Mdxs45cEtmjxQnwG0ZTyzySSj6ve1qKcNvc5dNEfgXLcye7PEVPaHROeXp0m8KzaaAt1HHvV9doe8Urn6sbRyq1oJhMR9jclQCR/AK2GZieYJ4uY9RlyR3KQonzQSlyKX8c18t4uf2BmCLwxh5QAuPvKVukUz01pYlcC3JXcS6HYbu8RI8SYTV299mgqqvQ++t059AtXB/CC7hXEmRJQABINJ8msbryXtfgaUbz3Y+ud5KNoT64NENHW16lpaviyhn45D28noNuKVyiJ5IXDT5r3c0vRF9/K5l+Ww==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA6PR02MB10695.namprd02.prod.outlook.com (2603:10b6:806:43c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 19:05:43 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 19:05:42 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>, Easwar Hariharan
	<eahariha@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
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
Subject: RE: [PATCH v5 03/10] arm64/hyperv: Add some missing functions to
 arm64
Thread-Topic: [PATCH v5 03/10] arm64/hyperv: Add some missing functions to
 arm64
Thread-Index: AQHbiKNspuYqM3nYbUGc8QDYUvj7rrNap4kAgAE0igCACqXJQA==
Date: Thu, 6 Mar 2025 19:05:42 +0000
Message-ID:
 <SN6PR02MB41579F4147561B96A2C1C057D4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-4-git-send-email-nunodasneves@linux.microsoft.com>
 <5f3d660d-fe2e-4ac1-94a7-66d6c8ffe579@linux.microsoft.com>
 <2fee888a-4f81-40aa-9545-617a49a7fb30@linux.microsoft.com>
In-Reply-To: <2fee888a-4f81-40aa-9545-617a49a7fb30@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA6PR02MB10695:EE_
x-ms-office365-filtering-correlation-id: 6f624635-7778-4452-88c3-08dd5ce1e478
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|19110799003|8060799006|461199028|15080799006|440099028|3412199025|41001999003|21061999003|12071999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0t1QUgzVkZObXJZM1M1bnVsNVR4d2t2TzBhWnFISC9hWlpMSDIwV0dxQzBG?=
 =?utf-8?B?blI1d2FSZWtCSHVsR3o0RHFGWWRRR0FyVWNpNkQycEpFMmxPeDdBSXU3L2c4?=
 =?utf-8?B?ZHVqZzZPOEFFT1AzL0xZdm1wRjZOT3lEcVJNUDFrRE9qUGxmNERwRlFxREdH?=
 =?utf-8?B?anBtYmFvMk5hdC9qZmFjbThPUk1UdXR6YzJTNDBiVzhHUnR1SlM5dmVMQWdQ?=
 =?utf-8?B?b2p6cnczc0M1b3dGM1pvVnYvTDRKS3BCWnA2Mm5lYmN5MmRYUlVvKzZ3cStx?=
 =?utf-8?B?MzkxNGx2ZHM1d3BPaXdROHE0UHk5QXdVQ2tWcmQ2czYveUFHUWdmeVNrZDlK?=
 =?utf-8?B?cWI4MlN2MUlGOU5nQ21VbkgyZ2dCWEttRnh1Y2s1bXlBd2lkT20weTVNL21k?=
 =?utf-8?B?bkM3b2haMTZhaVFiNWZYd0xUQnY3alZEYnY4L2tndWJqS0xWcEZENW9SN09D?=
 =?utf-8?B?OEh6dDNRWU4rL0p2azZvQUFCVFBUQkFWNU5BdTJpejJhcDNkaUVFdlliSmk0?=
 =?utf-8?B?emRlNUt3VGJFNTZHVkpVbmo5Qk1Qc250UUZDdnFvM3NxTXJsRjJOQjJkcVhE?=
 =?utf-8?B?RElzSXVNRW85OEE0dFZ3Wm43N1dOaUlndGtIS3U2WWthS1BFZG9ZV0VOOXBB?=
 =?utf-8?B?ZkFjY0tGSEo1SVlac3JvMzNkQU1kbGNMM3RTS096YzZIRVFKK0Nla0k2ckVm?=
 =?utf-8?B?THgwaUVyRDFHUm8wZXJuejlWQ2ZxYy9qOTRUMXhPazI1eldTS3ZMY3ltVVdx?=
 =?utf-8?B?dVhUM0V1VjB4bHZtT0t5M2t4cmtzbGpHa2tNY0dSUjk0RXU2QzRQNVVWb3lE?=
 =?utf-8?B?Ujd4SGlNOTNWNmFuZEpZeFJKMDNGeHRHSHpVTnNLTjUxZ0RKN20xeG9uVVE2?=
 =?utf-8?B?Z25zOVp5QURKdHgyK3NEMDdBaWVRTmhDV0JxempBMEFGY1pBeTJ3a2VJUnhJ?=
 =?utf-8?B?QjBtOEQ5SFBvKzZzMGpUZ1Q0aGl3UVNvMllrNU9ESis1REQycTRGeHdDWlU2?=
 =?utf-8?B?ZHhJeEtGTkNDS2FvelVidjArajlPOFFWc01mcFlWOU9idE4wZzFVMWpOTlNy?=
 =?utf-8?B?QnhoVjd6Rkg4RDc3emFqY2VVK29ac0FOVUtiK0xSTTFLSzJUVG1kUzQvMGM0?=
 =?utf-8?B?RlgxY1h4L0ZDM0U1OTdYdFBtNm9ZWWlzVXF0ZVdyMW81S0ZiKy9FMElsdmRn?=
 =?utf-8?B?Q285LzFFRlRFYzFQa3NseUJrNHlLS096ZWl0Q1M4S3drTHpidmpDM2V3cUpy?=
 =?utf-8?B?VGNyYTRMN254Qk92bGwxSllySUN2TzREOUZFRjVzclhrc1R2MC83TjA5aFl2?=
 =?utf-8?B?S2x0MTJqcndSbVpYYzFEYnVaRTdFdFhPRlpZenNXVVVQam5KV24wbkpmajZI?=
 =?utf-8?B?THJiUlFSK08zRS9ubFdIcmgwNkltNzNuZ2wvQTIrUTJuVEcrTmZ2RkgzYWpM?=
 =?utf-8?B?dHNrMXVHbVduSmhLbE14VXF4VG9tVkpudjZ3KzI2ei9NaEYrbHZ3K00xM1Zm?=
 =?utf-8?B?dTNkVnBJMXRRbllvRVdKbXpEU2MyREJrWGRUYkU2R2VqUWNuQ3BibUJvTGtt?=
 =?utf-8?B?c2l4Zz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YnhFN1oyUDZ1R0VuUTZ3RUFQaVZNbjVxUW9LK0VsV1RwVERDN3ZGU24zVjBH?=
 =?utf-8?B?ZUNJWFZVL01KNlB4K0FranhobDZJNHFad2lnQlN0UVBCWWxPWHBSRXd0Zk90?=
 =?utf-8?B?UlZhM21CdEVqbVcwZjlGYnRiSVJpcnRpeUFHL1BKUTVCbG10ckNIMzdBTENM?=
 =?utf-8?B?NGh1WFFHQjN2UkZUOVA4ZEcrM2NodFZZaFF3SlRzejBqdlFDU2xVdWFQOTk0?=
 =?utf-8?B?SW1aa085a0R3bVRjZDg0VEtxMzd4aC9DSGtWUkhPbzB5NHpUM29wVnltRUpM?=
 =?utf-8?B?TmVoOGdJVjFQM3FQL1hjZ3FEbUxBRi82aUpFeHBQWG1LYkVyakw0elY0ellk?=
 =?utf-8?B?TFF4Lzc5b2ZjeWVXSElqazREdEVRK2dOb001ZWEwdHhVSTR4d3QrRkZrM2FE?=
 =?utf-8?B?bk1XZXp4QWUxRXU2MFovdmM2T2FQSGpSaDBPNkk2ODBEcGpWb1IwNWJkTDN2?=
 =?utf-8?B?aGlTZmxqU0RzeEF2MWVvUEJNV0FKemNXeHdzYkJIdTRuU3lMMWZqeGNHZ2RP?=
 =?utf-8?B?eHJMS0dScjR2MXVEZzR6eGtqeUh0d0pheTVQbVFvZ09jVFNROGxZeGVLdkha?=
 =?utf-8?B?MHZWTHppZURKV0Npc1puajBNc0dPSVpHak5NOXdZZk5UbmVzZWFWNUJ1Y0Nh?=
 =?utf-8?B?SFlQaDZlenlxcVdnMmtwWDN1aXlNODhNclIxK2dVQzVvNTdZdHdNZDlWZlYy?=
 =?utf-8?B?L3dYRnQ1cC9Lb1lXd2w4ZjlicDdPa1c2eE1zeHRhU2kvSnBCdkFRMkZpSmdE?=
 =?utf-8?B?RjBnTXJtUkxENWZtejJad1FBbkNvaUoyTFdFU3Q4NnNORUJQeEllNk5UanAz?=
 =?utf-8?B?emxpZGxEWGRkNWxIUU1CeHkvc29WYUhTZTFVV3F0a2pNbi9QY0lpV3BTN1NM?=
 =?utf-8?B?SGhQakJwUGxjTit6dWRhcUpDdFA1dklnYys0WWVsbWt0TlRHSzNHb2ZBdlRM?=
 =?utf-8?B?Q2ppcVo3UmZ0VGMyb3RSWUpEb0pEb0ptSTl2SjRKY3YwVllLQUhnc0dpd0o5?=
 =?utf-8?B?dUFOa05xN3VRV1ZlQ0dQaFJaWVRVVHA3dkZxaGRObk1NTW55Z2xLbFd5dFlU?=
 =?utf-8?B?T21MTVBwTUlMeGt0aTJ0cEYzUjhBVEJldHhZWnFhdDJNVytUS3o1dlhnbmZB?=
 =?utf-8?B?UnRzb1NlMk5xbTZSNHRyK3AxWVF0bTcwN0svclNzYUNMSC9zQ0toSVVQTkJG?=
 =?utf-8?B?OHdSQ1V0aS9aUjdiVjJtN0ZjUHkyR2s0YXhjZTdYQmxSV1pPSTJMWmd0NDM3?=
 =?utf-8?B?eC9yRGZndllEN1JFdVNtN2d0QjAwUTdYTjVURE5EazNDNHNDK2RXZzRQUTJ2?=
 =?utf-8?B?WUxqQ0F1VnNiYlcwWnFyTWwwT0hETW9VZ05UQURES3FqOHc2OVBWd2ZDcG1R?=
 =?utf-8?B?UXBwWG1TcW12RVV2VnB6ZnVEUDh5S0ZCRTFjSldmNDZJWFZBNkRqNlB5MFZi?=
 =?utf-8?B?NHIydkxTbk5WUUEvM1hNbkNUSEdja1dscHpjcG1STHBOQ2RUN0hSZ3R4VGcy?=
 =?utf-8?B?a0I5MjcvWVZoYTZBenVkK2ZFVDVVbmFKaFpJV2VmQ1BuTXhqMzlMTTZQcWdw?=
 =?utf-8?B?eFk4NzRvZ0RhcXpSbFNjWWExNHRqZG81Q0xZTDhBUUJic0tGRzNRdDdaQW1K?=
 =?utf-8?Q?gZOB4U3J/1GkR+xuNKAMU4MQj9cR8lE3JVrVIMXk9pBI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f624635-7778-4452-88c3-08dd5ce1e478
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 19:05:42.6443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10695

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMjcsIDIwMjUgNDoyMSBQTQ0KPiANCj4gT24gMi8yNi8y
MDI1IDk6NTYgUE0sIEVhc3dhciBIYXJpaGFyYW4gd3JvdGU6DQo+ID4gT24gMi8yNi8yMDI1IDM6
MDcgUE0sIE51bm8gRGFzIE5ldmVzIHdyb3RlOg0KPiA+PiBUaGVzZSBub24tbmVzdGVkIG1zciBh
bmQgZmFzdCBoeXBlcmNhbGwgZnVuY3Rpb25zIGFyZSBwcmVzZW50IGluIHg4NiwNCj4gPj4gYnV0
IHRoZXkgbXVzdCBiZSBhdmFpbGFibGUgaW4gYm90aCBhcmNoaXRldHVyZXMgZm9yIHRoZSByb290
IHBhcnRpdGlvbg0KPiA+DQo+ID4gbml0OiAqYXJjaGl0ZWN0dXJlcyoNCj4gPg0KPiA+DQo+IFRo
YW5rcyENCj4gDQo+ID4+IGRyaXZlciBjb2RlLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBO
dW5vIERhcyBOZXZlcyA8bnVub2Rhc25ldmVzQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+ID4+IC0t
LQ0KPiA+PiAgYXJjaC9hcm02NC9oeXBlcnYvaHZfY29yZS5jICAgICAgIHwgMTcgKysrKysrKysr
KysrKysrKysNCj4gPj4gIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vbXNoeXBlcnYuaCB8IDEyICsr
KysrKysrKysrKw0KPiA+PiAgaW5jbHVkZS9hc20tZ2VuZXJpYy9tc2h5cGVydi5oICAgIHwgIDIg
KysNCj4gPj4gIDMgZmlsZXMgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+PiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9oeXBlcnYvaHZfY29yZS5jIGIvYXJjaC9hcm02NC9oeXBl
cnYvaHZfY29yZS5jDQo+ID4+IGluZGV4IDY5MDA0ZjYxOWM1Ny4uZTMzYTllM2MzNjZhIDEwMDY0
NA0KPiA+PiAtLS0gYS9hcmNoL2FybTY0L2h5cGVydi9odl9jb3JlLmMNCj4gPj4gKysrIGIvYXJj
aC9hcm02NC9oeXBlcnYvaHZfY29yZS5jDQo+ID4+IEBAIC01Myw2ICs1MywyMyBAQCB1NjQgaHZf
ZG9fZmFzdF9oeXBlcmNhbGw4KHUxNiBjb2RlLCB1NjQgaW5wdXQpDQo+ID4+ICB9DQo+ID4+ICBF
WFBPUlRfU1lNQk9MX0dQTChodl9kb19mYXN0X2h5cGVyY2FsbDgpOw0KPiA+Pg0KPiA+PiArLyoN
Cj4gPj4gKyAqIGh2X2RvX2Zhc3RfaHlwZXJjYWxsMTYgLS0gSW52b2tlIHRoZSBzcGVjaWZpZWQg
aHlwZXJjYWxsDQo+ID4+ICsgKiB3aXRoIGFyZ3VtZW50cyBpbiByZWdpc3RlcnMgaW5zdGVhZCBv
ZiBwaHlzaWNhbCBtZW1vcnkuDQo+ID4+ICsgKiBBdm9pZHMgdGhlIG92ZXJoZWFkIG9mIHZpcnRf
dG9fcGh5cyBmb3Igc2ltcGxlIGh5cGVyY2FsbHMuDQo+ID4+ICsgKi8NCj4gPj4gK3U2NCBodl9k
b19mYXN0X2h5cGVyY2FsbDE2KHUxNiBjb2RlLCB1NjQgaW5wdXQxLCB1NjQgaW5wdXQyKQ0KPiA+
PiArew0KPiA+PiArCXN0cnVjdCBhcm1fc21jY2NfcmVzCXJlczsNCj4gPj4gKwl1NjQJCQljb250
cm9sOw0KPiA+PiArDQo+ID4+ICsJY29udHJvbCA9ICh1NjQpY29kZSB8IEhWX0hZUEVSQ0FMTF9G
QVNUX0JJVDsNCj4gPj4gKw0KPiA+PiArCWFybV9zbWNjY18xXzFfaHZjKEhWX0ZVTkNfSUQsIGNv
bnRyb2wsIGlucHV0MSwgaW5wdXQyLCAmcmVzKTsNCj4gPj4gKwlyZXR1cm4gcmVzLmEwOw0KPiA+
PiArfQ0KPiA+PiArRVhQT1JUX1NZTUJPTF9HUEwoaHZfZG9fZmFzdF9oeXBlcmNhbGwxNik7DQo+
ID4+ICsNCj4gPg0KPiA+IEknZCBsaWtlIHRoaXMgdG8gaGF2ZSBiZWVuIGluIGFyY2gvYXJtNjQv
aW5jbHVkZS9hc20vbXNoeXBlcnYuaCBsaWtlIGl0cyB4ODYNCj4gPiBjb3VudGVycGFydCwgYnV0
IHRoYXQncyBqdXN0IG15IHBlcnNvbmFsIGxpa2luZyBvZiBzeW1tZXRyeS4gSSBzZWUgd2h5IGl0
J3MgaGVyZQ0KPiA+IHdpdGggaXRzIHNsb3cgYW5kIDgtYnl0ZSBicmV0aHJlbi4NCj4gPg0KPiBH
b29kIHBvaW50LCBJIGRvbid0IHNlZSBhIGdvb2QgcmVhc29uIHRoaXMgY2FuJ3QgYmUgaW4gdGhl
IGhlYWRlci4NCg0KSSB3YXMgdHJ5aW5nIHRvIHJlbWVtYmVyIGlmIHRoZXJlIHdhcyBzb21lIHJl
YXNvbiBJIG9yaWdpbmFsbHkgcHV0DQpodl9kb19oeXBlcmNhbGwoKSBhbmQgaHZfZG9fZmFzdF9o
eXBlcmNhbGw4KCkgaW4gdGhlIC5jIGZpbGUgaW5zdGVhZCBvZg0KdGhlIGhlYWRlciBsaWtlIG9u
IHg4Ni4gQnV0IEkgZG9uJ3QgcmVtZW1iZXIgYSByZWFzb24uIER1cmluZw0KZGV2ZWxvcG1lbnQs
IHRoZSBjb2RlIGNoYW5nZWQgc2V2ZXJhbCB0aW1lcywgYW5kIHRoZXJlIG1pZ2h0IGhhdmUNCmJl
ZW4gYSByZWFzb24gdGhhdCBkaWRuJ3QgcGVyc2lzdGVudCBpbiB0aGUgdmVyc2lvbiB0aGF0IHdh
cyBmaW5hbGx5DQphY2NlcHRlZCB1cHN0cmVhbS4NCg0KTXkgb25seSBjb21tZW50IGlzIHRoYXQg
aHZfZG9faHlwZXJjYWxsKCkgYW5kIHRoZSA4IGFuZCAxNiAiZmFzdCINCnZlcnNpb25zIHNob3Vs
ZCBwcm9iYWJseSBzdGF5IHRvZ2V0aGVyIG9uZSBwbGFjZSBvbiB0aGUgYXJtNjQgc2lkZSwNCmV2
ZW4gaWYgaXQgZG9lc24ndCBtYXRjaCB4ODYuDQoNCj4gDQo+ID4+ICAvKg0KPiA+PiAgICogU2V0
IGEgc2luZ2xlIFZQIHJlZ2lzdGVyIHRvIGEgNjQtYml0IHZhbHVlLg0KPiA+PiAgICovDQo+ID4+
IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL21zaHlwZXJ2LmgNCj4gYi9hcmNo
L2FybTY0L2luY2x1ZGUvYXNtL21zaHlwZXJ2LmgNCj4gPj4gaW5kZXggMmUyZjgzYmFmY2ZiLi4y
YTkwMGJhMDA2MjIgMTAwNjQ0DQo+ID4+IC0tLSBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vbXNo
eXBlcnYuaA0KPiA+PiArKysgYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL21zaHlwZXJ2LmgNCj4g
Pj4gQEAgLTQwLDYgKzQwLDE4IEBAIHN0YXRpYyBpbmxpbmUgdTY0IGh2X2dldF9tc3IodW5zaWdu
ZWQgaW50IHJlZykNCj4gPj4gIAlyZXR1cm4gaHZfZ2V0X3ZwcmVnKHJlZyk7DQo+ID4+ICB9DQo+
ID4+DQo+ID4+ICsvKg0KPiA+PiArICogTmVzdGVkIGlzIG5vdCBzdXBwb3J0ZWQgb24gYXJtNjQN
Cj4gPj4gKyAqLw0KPiA+PiArc3RhdGljIGlubGluZSB2b2lkIGh2X3NldF9ub25fbmVzdGVkX21z
cih1bnNpZ25lZCBpbnQgcmVnLCB1NjQgdmFsdWUpDQo+ID4+ICt7DQo+ID4+ICsJaHZfc2V0X21z
cihyZWcsIHZhbHVlKTsNCj4gPj4gK30NCj4gPg0KPiA+IGVtcHR5IGxpbmUgcHJlZmVycmVkIGhl
cmUsIGFsc28gcmVwb3J0ZWQgYnkgY2hlY2twYXRjaA0KPiA+DQo+IEdvb2QgcG9pbnQsIG1pc3Nl
ZCB0aGF0IG9uZS4uLg0KPiANCj4gPj4gK3N0YXRpYyBpbmxpbmUgdTY0IGh2X2dldF9ub25fbmVz
dGVkX21zcih1bnNpZ25lZCBpbnQgcmVnKQ0KPiA+PiArew0KPiA+PiArCXJldHVybiBodl9nZXRf
bXNyKHJlZyk7DQo+ID4+ICt9DQo+ID4+ICsNCj4gPj4gIC8qIFNNQ0NDIGh5cGVyY2FsbCBwYXJh
bWV0ZXJzICovDQo+ID4+ICAjZGVmaW5lIEhWX1NNQ0NDX0ZVTkNfTlVNQkVSCTENCj4gPj4gICNk
ZWZpbmUgSFZfRlVOQ19JRAlBUk1fU01DQ0NfQ0FMTF9WQUwoCQkJXA0KPiA+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9hc20tZ2VuZXJpYy9tc2h5cGVydi5oIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9t
c2h5cGVydi5oDQo+ID4+IGluZGV4IGMwMjBkNWQwZWMyYS4uMjU4MDM0ZGZkODI5IDEwMDY0NA0K
PiA+PiAtLS0gYS9pbmNsdWRlL2FzbS1nZW5lcmljL21zaHlwZXJ2LmgNCj4gPj4gKysrIGIvaW5j
bHVkZS9hc20tZ2VuZXJpYy9tc2h5cGVydi5oDQo+ID4+IEBAIC03Miw2ICs3Miw4IEBAIGV4dGVy
biB2b2lkICogX19wZXJjcHUgKmh5cGVydl9wY3B1X291dHB1dF9hcmc7DQo+ID4+DQo+ID4+ICBl
eHRlcm4gdTY0IGh2X2RvX2h5cGVyY2FsbCh1NjQgY29udHJvbCwgdm9pZCAqaW5wdXRhZGRyLCB2
b2lkICpvdXRwdXRhZGRyKTsNCj4gPj4gIGV4dGVybiB1NjQgaHZfZG9fZmFzdF9oeXBlcmNhbGw4
KHUxNiBjb250cm9sLCB1NjQgaW5wdXQ4KTsNCj4gPj4gK2V4dGVybiB1NjQgaHZfZG9fZmFzdF9o
eXBlcmNhbGwxNih1MTYgY29udHJvbCwgdTY0IGlucHV0MSwgdTY0IGlucHV0Mik7DQo+ID4+ICsN
Cj4gPg0KPiA+IGNoZWNrcGF0Y2ggd2FybnMgYWdhaW5zdCBwdXR0aW5nIGV4dGVybnMgaW4gaGVh
ZGVyIGZpbGVzLCBhbmQgRldJVywgaWYNCj4gaHZfZG9fZmFzdF9oeXBlcmNhbGwxNigpDQo+ID4g
Zm9yIGFybTY0IHdlcmUgaW4gYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9tc2h5cGVydi5oIGxpa2Ug
aXRzIHg4NiBjb3VudGVycGFydCwgeW91DQo+IHByb2JhYmx5DQo+ID4gd291bGRuJ3QgbmVlZCB0
aGlzPw0KPiA+DQo+IFllcyBJIHdvbmRlcmVkIGFib3V0IHRoYXQgd2FybmluZy4gVGhhdCdzIHRy
dWUsIGlmIEkganVzdCBwdXQgaXQgaW4gdGhlIGFybTY0IGhlYWRlcg0KPiB0aGVuIHRoaXMgd29u
J3QgYmUgbmVlZGVkIGF0IGFsbCwgc28gSSBtaWdodCBqdXN0IGRvIHRoYXQhDQoNCkkgYWx3YXlz
IHRob3VnaHQgdGhlIGNoZWNrcGF0Y2ggd2FybmluZyB3YXMgc2ltcGx5IHRoYXQgImV4dGVybiIg
b24gYSBmdW5jdGlvbg0KZGVjbGFyYXRpb24gaXMgc3VwZXJmbHVvdXMuIFlvdSBjYW4gb21pdCAi
ZXh0ZXJuIiBhbmQgbm90aGluZyBjaGFuZ2VzLiBPZg0KY291cnNlLCB0aGUgc2FtZSBpcyBub3Qg
dHJ1ZSBmb3IgZGF0YSBpdGVtcy4NCg0KTWljaGFlbA0KDQo+IA0KPiA+PiAgYm9vbCBodl9pc29s
YXRpb25fdHlwZV9zbnAodm9pZCk7DQo+ID4+ICBib29sIGh2X2lzb2xhdGlvbl90eXBlX3RkeCh2
b2lkKTsNCj4gPj4NCg0K

