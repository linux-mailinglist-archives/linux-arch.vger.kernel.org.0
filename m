Return-Path: <linux-arch+bounces-13169-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0A9B26F4E
	for <lists+linux-arch@lfdr.de>; Thu, 14 Aug 2025 20:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0D1602E69
	for <lists+linux-arch@lfdr.de>; Thu, 14 Aug 2025 18:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BFD223DD0;
	Thu, 14 Aug 2025 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LRfEf9zJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2019.outbound.protection.outlook.com [40.92.41.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8B222541C;
	Thu, 14 Aug 2025 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197305; cv=fail; b=SjOZDfiaFd51NitFPyNv/6sCUUFbnrttisdGbSkU+nvfcFkjKCx7KIgcKwWxvhC1SBuPnVL97qjs+UNL/9EEZw4s+nEIxNyPKClDe4nj+CtaPjrTEiMgHw7y7Kgweds1iKeKcvRbFu2hHR+RGDH8pdPmRsVfQL2Jf1/K5XeV9iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197305; c=relaxed/simple;
	bh=sNxeDdY6J0qS0R7WW1ieKm1FEbuuSKdJt+N+8Z72bJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EYCdaAGnxVuGP1Olm+1ZwkJFUKGWD1FpWCYY7t739OSAZa0HCxWLpSHx7cK0Pw4NTjb8t/yXqMsR73KVD/mADckuExEq4ee/+TCH1zwDo5SnGG6t0XMKwPU4L3HUusAG7PG4aCfUVx1dGV6jyRda2Rdy6Q/JP6nB45mf8gKgEIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LRfEf9zJ; arc=fail smtp.client-ip=40.92.41.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMliG3pBiUI/EkPklyXKk3aS0fzULSO2xrjTdmIHUeH3Jiu7F6Ej/GPoF7dbWZOGVqQL1J8SE0vLtN0AbbWBZKmmV5yFlL4DVT8AZ7nzVMGr/bkyREU1kToCIZ2Aar/QsrC0tnlikt37VEyqc4YIe+XnSyrJdVZQrdz8jvqxvjHqSiYYNjYncNLJA4qCVo1GntJjqaf2VI1nuKYQVU09FeFaCjsooGAds9XYvXD4aMw5krqXag7GmvSDlRqtsASsKM3eIOy1aC/9jw3bgp6Nt0K8QClymPN0sqinB/mH7lo7JnbnkM9bQDoFNAWmpLS910AfuZlLznISXUyJ8QMFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNxeDdY6J0qS0R7WW1ieKm1FEbuuSKdJt+N+8Z72bJk=;
 b=AvFysrFv+h2abzK/3j1XrEulTUTqDG3eszwsFcEaMK/U2mYnnmVb2yRVNB+H0brcB2lNzkeep9803oWj4t32UemATOiMwFViaP91qkccKy5VZjLdYgSyy9RF4i4UNLR7YGQrP3n+zmqKbyDG3NrSPNuFE7Ik2SNsFktlOfBocwgKfz3ide7+CLFx4p9EeaNs9ErkaZESxnnRk41p/TVPc12q2dOrG9m+EafclkG0hMZGoipyRKf68J1ncZej3LIhYBIXjvDb95qNKrD+kKPJ1R/Ngh0VaAj52aw0NwcTJYjW/3s0rAFKXk4eoYtTPWyZdF9RIveXLUpmoSkEYDfcxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNxeDdY6J0qS0R7WW1ieKm1FEbuuSKdJt+N+8Z72bJk=;
 b=LRfEf9zJLU3yLhnSJpK7mUEDoC80ol0e5iwBeDO0ukoBP31UUSga41qvloD6UBpsmboP4rcPXYXZUgawiQCOj4xIlfckDMqxmcgQ892FIJgfWJOyjLfwYmi1rj1WJtPOo0ZOB8W5RknqP4JBoBlsIwRATKY6aaWifdfo7n7CAeD68a/nmg2KS19sXIuEQUClAwKPlFX5TdEmQqRHVHb/x6PMoWlmeEEsKAGVA+LnHLcNhCt/Q7q+4yrzmboh24ZHRWqSZScxN6UjyXGBKSCVwPQRqbNZrTn4oc4ps5IgfCyEoQZKJq7INpXn0AfOAALhxjR61kKz7/1aMAEJjzYM2g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM8PR02MB8038.namprd02.prod.outlook.com (2603:10b6:8:17::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Thu, 14 Aug
 2025 18:48:22 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 18:48:21 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: RE: [PATCH v4 2/7] x86/hyperv: Use hv_setup_*() to set up hypercall
 arguments -- part 1
Thread-Topic: [PATCH v4 2/7] x86/hyperv: Use hv_setup_*() to set up hypercall
 arguments -- part 1
Thread-Index: AQHb96BapKxn1tvuRkq0WjcBk6xrDLRf4XOAgALG7nA=
Date: Thu, 14 Aug 2025 18:48:21 +0000
Message-ID:
 <SN6PR02MB4157299B843731B1A03F4194D435A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250718045545.517620-1-mhklinux@outlook.com>
 <20250718045545.517620-3-mhklinux@outlook.com>
 <252e58be-4377-49b7-a572-0d40f54993d1@linux.microsoft.com>
In-Reply-To: <252e58be-4377-49b7-a572-0d40f54993d1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM8PR02MB8038:EE_
x-ms-office365-filtering-correlation-id: 35b393ac-a9d2-4990-3564-08dddb63249a
x-ms-exchange-slblob-mailprops:
 dx7TrgQSB6fOgpu0AmRux6KMzGkolm4j/uCbZvHdFONh4PcgyQqswafUcU3jX8QE9TELqsKJMFBZJhs+1C1Uk8MvhgmjvrazM6pqCz9fPBAfqMgvmLMyPxKhQ4xISoqETq8qdcGe6UvZ0nUDXS8L8si8b96GW1y7D+xLg9GygtJ5Ri0t+bRXak+gCyWO+rU/RIggu5Q+dXz1qRXHIfdHwSr9LckqwFhIpoin4wh20UyTPQbqsiB1FqoMB35/poVDNvU9S4Hmo8cwCbTDpIaLhWQX7h0rkQLSK1JThYqI6f79kM/LP3diUTdg/7juBL3cOGAFkCa/95Oy+CCDVrr78B/rX40YNy32B/AWNhDLsS8zdy++kK8wtixeDJLSjUA/bO/d8sXydrvSc4DM/eQ5CpSGqL+xhbVJ/StKr+C5KFV8IsbI/7xY0672ufZUW6wAdIlHLSHVjjmNU7M3pHG1JeHTVx1+lWhVYKr/VnEThQbss8zn+M/zOQ74ZoQ1qZAy2CMMej4eXOweCyr7+7/19agLYlvtknoCh9DdatiqPTI9hDfO38Mwp3kcxrkORfJWej0o3XJDsHM+WzKQ17gU0VVGAYUXUoDUPqZQQOp8ih+BLsBpUEWfMAx5ZyYztL03fuXBAsEyKWrRaavzstCECHjCJGDpyNJs1yqtCVjoMg0M26fj9Nv5gb2mrZHgFb3t9uoO7BUJSbnF18ZgUv+CoqVT3c3uIvJembJgof68zSsjwqyKNmLNquYPWzKO++dipTm++up4ZN0=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|31061999003|41001999006|13091999003|15080799012|19110799012|8060799015|8062599012|3412199025|40105399003|51005399003|440099028|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?OUNiUUs3dTMvVklwZ0l5YUcxNVFzUWcwbTg3M01QaTgrMFdUMGR2TUtZRnVv?=
 =?utf-8?B?bHFCMjJtUU54ckxmbldTbXBkVmdXZFJZU0VtMkdmWkQra0NxOWJ0MU8rNURq?=
 =?utf-8?B?RTF3RW5ERDYxWnVSdWVtakN3TDMvMDRYZVl3L3dORVFJVHVvNHZjQmZiVkFB?=
 =?utf-8?B?ZGlPbFNvdFBjUkQwdHZTOHFsMXVnY3RMSmpYaVRZQ1RzSk5zWHg3NTVpcHl6?=
 =?utf-8?B?SlR6SkNqem01a0g0R0hmMXhsOGpXdUhwdy9LL0NSVktJR3I3NGUwSGtybHcr?=
 =?utf-8?B?WDBOMVB2RjNLck1aeUx3UXBqMk0ramp0N3B5L3BKSmhrV1R2U2U5ZFl6aDhP?=
 =?utf-8?B?bkNjZDlGQW1sVDVXRmk3OVdwNzVlcXlCWEMxU3p4NE9ZUDZXSEw0dVUxQ2NS?=
 =?utf-8?B?RDdmYndQeUNJUnZBN1BSenZjL1NJM1RJZkZ4d29zVGpkaDYvbmlCcUhybzJK?=
 =?utf-8?B?b3Bib2tRWllraytKM2FSckFybkZWNEJLWjZIbjNuLy9hS2Q5ajZCWTh5Q0x6?=
 =?utf-8?B?MHFuQmlPWVEvN3pVb1lJUUtwZTF6eXVQQjBCV3U1Rlpoell3T0pORis4VmVK?=
 =?utf-8?B?NTlndC9ZT3RSUnVoTW5wTmRNVnN1Z0Ftd29mTndycWxSdWVLeUNWZXB6dHV3?=
 =?utf-8?B?Vk5yR3MrZlNMdXJDN1drUjMwTzRqODhLWjBFUVFtZks0T2NteExucmhQTTV6?=
 =?utf-8?B?Z0FFdTRxNjNSL0RRSVFRNXJLUG5QRkFuUVkyM1FHQzdBSHl3ZU1kdHd0SWxL?=
 =?utf-8?B?cWptT2RNdnBkYnFiSDVHRzQwOE5zeExJbXdYOU9BTGpNOG5kOStaek5pcU1M?=
 =?utf-8?B?bk5nZWVpRWFFVFI3Qi91ajYweUVPSnVJT0VSTnRoajVnL1ZFTGcvYUtRNE4z?=
 =?utf-8?B?Y1hOc3BnK0dkNDY0T3BRcHlud0dFcWVOMEFPcEFDdFJLSDlNMndIazgvYThJ?=
 =?utf-8?B?ei9DeFlSdENYaUk3NUNWYktoTWdBdEU0NGRNZlBrc3ZkS0RMbzk3MnJ6aTVt?=
 =?utf-8?B?b3U5Q3lzYnFkRUc4cXhGUFdPZjJUTkhlcnpzYUR4cEVXWlVUVm54bVBGM0Rh?=
 =?utf-8?B?ZzlTMUlIbG9rYVV6TXNRTUxNOUlSUi9wTDVxOUxtcDBlL0xvSlRGMVF5UG1D?=
 =?utf-8?B?WUFKaEtxVENPTmkxSEdHN25vU2VmZzBHN3FXTzBxQXh3d096STFwMFRBS1ps?=
 =?utf-8?B?bThyaEx3aUpHMmxwOHk5bzJBMGZaRjlVZEh0NjcwS2NzRWY3dnA0aWhzeFcw?=
 =?utf-8?B?YXkrS2w2cm9ZWm5ETmpNQStSTUdHK0dDbUV3R2xjSExSdE5mamxNSXFXOVNN?=
 =?utf-8?B?dVJKeVJtVnJXUS93ajhBZWRPOUFKWmJZTHVWL0lvZEFEWTBRT1FxMVpxMHpk?=
 =?utf-8?B?V1NPa1V0VVREUXNNNXU5a3haZHEza3BqRVRjWTVQUVBEOXNVY3NtaUVUMFJN?=
 =?utf-8?B?akJzTmVsMXh5UFdNVzRsWlIvMGNvRktQeEVObWduYjdNN0ZEcGtDb2lUQjFQ?=
 =?utf-8?B?dXpFSG1EdTZXdm92VHJ4Q2FDU2xJWGV2KzV6bk1Rb3czYWJzbmtpQVhKTVV6?=
 =?utf-8?B?K3VoNjdqT1FrSzRRWDRvQVNRVFl5OWlVczBxSVg1SlQyaHVhMkZSakFBRDQz?=
 =?utf-8?B?WitxR3RaUUdTcEs5UFZhSXMxVVJtM1YydmE1TndqSklNakRqRngvWlh6UmUr?=
 =?utf-8?B?SEk3emJ2Q2tWb3ZGOGwyL2xxOU8xTFYwTktFTkJ5RTRCVmh5eVd4UHZ3PT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q3U0YmRBTXptQXkzcHRXdS9SQXVUYjJNV2hDOVhXbFNVVmlqYWhUQlpvL1V6?=
 =?utf-8?B?SlRsODBNSW5aVEJ6U2ZUekFCVHEycGJUOEQwN0IxWkFGWk5YWmZkVElsbUds?=
 =?utf-8?B?WmRNS3RrY001U3JKYU1zSVhuSTcyRXEwWXQzbjQrNGRGbEFtbWJFajFva3lP?=
 =?utf-8?B?bWE2endpS0V6b0lVNGpNZk5udFlZUFFGUGpYVDg4WmdvTUR6emJTVHNjVklR?=
 =?utf-8?B?SjZoY3lYNWhhd0hIWEh3ZUl4OGEzbHNmb0wyTmg2bVVNdTh3SjV1bS9OOXVZ?=
 =?utf-8?B?MEh6MTZHdXVRY3dQTzFTaFNxbk5rRmc4Uzd5ZzZhbk1ZR2J0VWc0d3crQWR4?=
 =?utf-8?B?THJGTHRwd2gwVEhzcEUyU3R2YVA4VTNjRGtSYzc4TFRYMEhmT3pocXNvT3pG?=
 =?utf-8?B?M2RBN1ZlZG4yclN3czFZM3ZpQXYwZ2FLQnRjTFVQUk9oQkNWUmFsdWhGaXYw?=
 =?utf-8?B?c3lFQzJBK2Q2cGZseTRXZ1FuNzZBNUhmWEdSVGtDTGlsblpvMG9zRjdUMmlv?=
 =?utf-8?B?N29DYXA2bFNWcElFakFFWms4TkVzY3ZJNDVhUlVwelJvaHgwTXo4WU9CblFq?=
 =?utf-8?B?aDBGS0ZSYzB5b3A3Y0hkVXdtM2lVcm5XVXlMNHdMMytEaTgxaVhtb0VPQ1kv?=
 =?utf-8?B?bWFMRmFzMHExVFlyMHBuYXI5Uk5LOC85VEVFeXhSWkJ3MVFPOHlWS1ZRSUtN?=
 =?utf-8?B?YnM4K3VDSHoyZVJTZ2JUaFk1ZXoxWW15QU5ybFBsVmI1NDVsbkMybUM2VWNT?=
 =?utf-8?B?WkwvekQ0cW8xbmZmWHh4eDZsVGNpS3MwQXRNM2FyV1Z0S3MyeDdWYld2S0Z1?=
 =?utf-8?B?YWJ5bE8wZE1CN1JnZXJFUzZxc3pXWnh4SHdaS3VYRmlzTDB2R0h6Um0xb3pD?=
 =?utf-8?B?aUZoR1ZNT3kzTVNONW14Y1RUOFljYWRKUUJNenlwZGViYjQ3V0FnL2dYZVpP?=
 =?utf-8?B?WGdRL2dhakowdHBtMVUvbTYxRUNsODU1a2h2STl4N2cxRHJZMUlhYmcyenJw?=
 =?utf-8?B?aGYrRStna1ljNklMRW5FZ1ZSWDhDbXJIWlNydWFWZVRRSG9RYlIrcGhpeTM3?=
 =?utf-8?B?TkYvUkZPbEtXa0hHeWlKOEI1Q0RwMWM3SWNtZENRRnhRaU13Z1hLV1E4Q251?=
 =?utf-8?B?Y1JubDl3b1JQcVAxSHF4MlQ5dGwwZ0srcnBtcnRMdkd1TzFCWGhVc0VTN2Y5?=
 =?utf-8?B?eWZpcVZXMk9SM2FnUlJBdUpBZkJ1WkJSeUJQOCtOKzBxaEJ3VnVpc0Y5bFov?=
 =?utf-8?B?amFveDhBZzVqTlJETDFhWDkwcVkzZ0ZiUWkzQ2lrVXcyaGNCY2htSk41WFRG?=
 =?utf-8?B?eWs0OHoydWpyMGluamJwaWhVZHJLMytENVNkUCtYWmMxanNSbWpiUlhaUW9q?=
 =?utf-8?B?a053Qkd0T2RrRnNMR29IemdEaGk5ZzFuWU1tWW5QRlBleE5Fd3BGYkdRSE9i?=
 =?utf-8?B?L2c1RFhqQjBRUEgrL29wR0FjQ0Q3NlpCcFl4WXRzK3BEcm9xTXpZaUVEalE5?=
 =?utf-8?B?amNpSjhicmVYZFRHM0RKZmdCOXhhNFNQdmUrc3FCWTFTMEtETW12eXBPUUhk?=
 =?utf-8?B?NVczemhPWnR0elJhWmxZTWpJSzhjSStxMktUS2tFeEl1cm1Ody9vRUk1c05G?=
 =?utf-8?Q?P+1vLxUdpXQGbaooNaBXuhXM97tPi0HAamBGUGBrDGjI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b393ac-a9d2-4990-3564-08dddb63249a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 18:48:21.8289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8038

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBUdWVzZGF5LCBBdWd1c3QgMTIsIDIwMjUgNToyMiBQTQ0KPiANCj4gT24gNy8xNy8yMDI1
IDExOjU1IFBNLCBtaGtlbGxleTU4QGdtYWlsLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBNaWNoYWVs
IEtlbGxleSA8bWhrbGludXhAb3V0bG9vay5jb20+DQo+ID4NCj4gPiBVcGRhdGUgaHlwZXJjYWxs
IGNhbGwgc2l0ZXMgdG8gdXNlIHRoZSBuZXcgaHZfc2V0dXBfKigpIGZ1bmN0aW9ucw0KPiA+IHRv
IHNldCB1cCBoeXBlcmNhbGwgYXJndW1lbnRzLiBTaW5jZSB0aGVzZSBmdW5jdGlvbnMgemVybyB0
aGUNCj4gPiBmaXhlZCBwb3J0aW9uIG9mIGlucHV0IG1lbW9yeSwgcmVtb3ZlIG5vdyByZWR1bmRh
bnQgY2FsbHMgdG8gbWVtc2V0KCkNCj4gPiBhbmQgZXhwbGljaXQgemVybydpbmcgb2YgaW5wdXQg
ZmllbGRzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4
QG91dGxvb2suY29tPg0KPiA+IFJldmlld2VkLWJ5OiBOdW5vIERhcyBOZXZlcyA8bnVub2Rhc25l
dmVzQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+ID4gLS0tDQo+ID4NCj4gPiBOb3RlczoNCj4gPiAg
ICAgQ2hhbmdlcyBpbiB2NDoNCj4gPiAgICAgKiBSZW5hbWUgaHZfaHZjYWxsXyooKSBmdW5jdGlv
bnMgdG8gaHZfc2V0dXBfKigpIFtFYXN3YXIgSGFyaWhhcmFuXQ0KPiA+ICAgICAqIFJlbmFtZSBo
dl9odmNhbGxfaW5fYmF0Y2hfc2l6ZSgpIHRvIGh2X2dldF9pbnB1dF9iYXRjaF9zaXplKCkNCj4g
PiAgICAgICBbRWFzd2FyIEhhcmloYXJhbl0NCj4gPg0KPiA+ICAgICBDaGFuZ2VzIGluIHYyOg0K
PiA+ICAgICAqIEZpeGVkIGdldF92dGwoKSBhbmQgaHZfdnRsX2FwaWNpZF90b192cF9pZCgpIHRv
IHByb3Blcmx5IHRyZWF0IHRoZSBpbnB1dA0KPiA+ICAgICAgIGFuZCBvdXRwdXQgYXJndW1lbnRz
IGFzIGFycmF5cyBbTnVubyBEYXMgTmV2ZXNdDQo+ID4gICAgICogRW5oYW5jZWQgX19zZW5kX2lw
aV9tYXNrX2V4KCkgYW5kIGh2X21hcF9pbnRlcnJ1cHQoKSB0byBjaGVjayB0aGUgbnVtYmVyDQo+
ID4gICAgICAgb2YgY29tcHV0ZWQgYmFua3MgaW4gdGhlIGh2X3Zwc2V0IGFnYWluc3QgdGhlIGJh
dGNoX3NpemUuIFNpbmNlIGFuDQo+ID4gICAgICAgaHZfdnBzZXQgY3VycmVudGx5IHJlcHJlc2Vu
dHMgYSBtYXhpbXVtIG9mIDQwOTYgQ1BVcywgdGhlIGh2X3Zwc2V0IHNpemUNCj4gPiAgICAgICBk
b2VzIG5vdCBleGNlZWQgNTEyIGJ5dGVzIGFuZCB0aGVyZSBzaG91bGQgYWx3YXlzIGJlIHN1ZmZp
Y2VudCBzcGFjZS4gQnV0DQo+ID4gICAgICAgZG8gdGhlIGNoZWNrIGp1c3QgaW4gY2FzZSBzb21l
dGhpbmcgY2hhbmdlcy4gW051bm8gRGFzIE5ldmVzXQ0KPiA+DQo+IA0KPiA8c25pcD4NCj4gDQo+
ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2h5cGVydi9pcnFkb21haW4uYyBiL2FyY2gveDg2L2h5
cGVydi9pcnFkb21haW4uYw0KPiA+IGluZGV4IDA5MGY1YWM5ZjQ5Mi4uODdlYmU0M2Y1OGNmIDEw
MDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2h5cGVydi9pcnFkb21haW4uYw0KPiA+ICsrKyBiL2Fy
Y2gveDg2L2h5cGVydi9pcnFkb21haW4uYw0KPiA+IEBAIC0yMSwxNSArMjEsMTUgQEAgc3RhdGlj
IGludCBodl9tYXBfaW50ZXJydXB0KHVuaW9uIGh2X2RldmljZV9pZCBkZXZpY2VfaWQsDQo+IGJv
b2wgbGV2ZWwsDQo+ID4gIAlzdHJ1Y3QgaHZfZGV2aWNlX2ludGVycnVwdF9kZXNjcmlwdG9yICpp
bnRyX2Rlc2M7DQo+ID4gIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+ICAJdTY0IHN0YXR1czsN
Cj4gPiAtCWludCBucl9iYW5rLCB2YXJfc2l6ZTsNCj4gPiArCWludCBiYXRjaF9zaXplLCBucl9i
YW5rLCB2YXJfc2l6ZTsNCj4gPg0KPiA+ICAJbG9jYWxfaXJxX3NhdmUoZmxhZ3MpOw0KPiA+DQo+
ID4gLQlpbnB1dCA9ICp0aGlzX2NwdV9wdHIoaHlwZXJ2X3BjcHVfaW5wdXRfYXJnKTsNCj4gPiAt
CW91dHB1dCA9ICp0aGlzX2NwdV9wdHIoaHlwZXJ2X3BjcHVfb3V0cHV0X2FyZyk7DQo+ID4gKwli
YXRjaF9zaXplID0gaHZfc2V0dXBfaW5vdXRfYXJyYXkoJmlucHV0LCBzaXplb2YoKmlucHV0KSwN
Cj4gPiArCQkJc2l6ZW9mKGlucHV0LQ0KPiA+aW50ZXJydXB0X2Rlc2NyaXB0b3IudGFyZ2V0LnZw
X3NldC5iYW5rX2NvbnRlbnRzWzBdKSwNCj4gPiArCQkJJm91dHB1dCwgc2l6ZW9mKCpvdXRwdXQp
LCAwKTsNCj4gPg0KPiANCj4gSGkgTWljaGFlbCwgSSBmaW5hbGx5IG1hbmFnZWQgdG8gdGVzdCB0
aGlzIHNlcmllcyBvbiAobmVzdGVkKSByb290DQo+IHBhcnRpdGlvbiBhbmQgZW5jb3VudGVyZWQg
YW4gaXNzdWUgd2hlbiBJIGFwcGxpZWQgdGhpcyBwYXRjaC4NCj4gDQo+IFdpdGggdGhlIGFib3Zl
IGNoYW5nZSwgSSBzYXcgSFZfU1RBVFVTX0lOVkFMSURfQUxJR05NRU5UIGZyb20gdGhpcw0KPiBo
eXBlcmNhbGwuIEkgcHJpbnRlZCBvdXQgdGhlIGFkZHJlc3NlcyBhbmQgc2l6ZXMgYW5kIGV2ZXJ5
dGhpbmcgbG9va2VkDQo+IGNvcnJlY3QuIFRoZSBvdXRwdXQgc2VlbWVkIHRvIGJlIGNvcnJlY3Rs
eSBwbGFjZWQgYXQgdGhlIGVuZCBvZiB0aGUNCj4gcGVyY3B1IHBhZ2UuIEUuZy4gaWYgaW5wdXQg
d2FzIGFsbG9jYXRlZCBhdCBhbiBhZGRyZXNzIGVuZGluZyBpbiAweDMwMDAsDQo+IG91dHB1dCB3
b3VsZCBiZSBhdCAweDNmZjAsIGJlY2F1c2UgaHZfb3V0cHV0X21hcF9kZXZpY2VfaW50ZXJydXB0
IGlzDQo+IDB4MTAgYnl0ZXMgaW4gc2l6ZS4NCj4gDQo+IEJ1dCBpdCB0dXJucyBvdXQsIHRoZSBk
ZWZpbml0aW9uIGZvciBodl9vdXRwdXRfbWFwX2RldmljZV9pbnRlcnJ1cHQNCj4gaXMgb3V0IG9m
IGRhdGUgKG9yIHdhcyBuZXZlciBjb3JyZWN0KSEgSXQgc2hvdWxkIGJlOg0KPiANCj4gc3RydWN0
IGh2X291dHB1dF9tYXBfZGV2aWNlX2ludGVycnVwdCB7DQo+IAlzdHJ1Y3QgaHZfaW50ZXJydXB0
X2VudHJ5IGludGVycnVwdF9lbnRyeTsNCj4gCXU2NCBleHRlbmRlZF9zdGF0dXNfZGVwcmVjYXRl
ZFs1XTsNCj4gfSBfX3BhY2tlZDsNCj4gDQo+IChUaGUgImV4dGVuZGVkX3N0YXR1c19kZXByZWNh
dGVkIiBmaWVsZCBpcyBtaXNzaW5nIGluIHRoZSBjdXJyZW50IGNvZGUuKQ0KPiANCj4gRHVlIHRv
IHRoaXMsIHdoZW4gdGhlIGh5cGVydmlzb3IgdmFsaWRhdGVzIHRoZSBoeXBlcmNhbGwgaW5wdXQv
b3V0cHV0LA0KPiBpdCBzZWVzIHRoYXQgb3V0cHV0IGlzIGdvaW5nIGFjcm9zcyBhIHBhZ2UgYm91
bmRhcnksIGJlY2F1c2UgaXQga25vd3MNCj4gc2l6ZW9mKGh2X291dHB1dF9tYXBfZGV2aWNlX2lu
dGVycnVwdCkgaXMgYWN0dWFsbHkgMHg1OC4NCg0KQSB2ZXJ5IGludGVyZXN0aW5nIHByb2JsZW0h
IE5vdCBzb21ldGhpbmcgSSB3b3VsZCBoYXZlIGV4cGVjdGVkDQp0byByZXN1bHQgZnJvbSB0aGlz
IHBhdGNoIHNldCwgYnV0IHRoYXQncyB3aHkgd2UgdGVzdC4gOi0pDQoNClRoYW5rcyBmb3IgdGhl
IGZpeCAuLi4uDQoNCk1pY2hhZWwNCg0KPiANCj4gSSBjb25maXJtZWQgdGhhdCBhZGRpbmcgdGhl
ICJleHRlbmRlZF9zdGF0dXNfZGVwcmVjYXRlZCIgZmllbGQgZml4ZXMgdGhlDQo+IGlzc3VlLiBU
aGF0IHNob3VsZCBiZSBmaXhlZCBlaXRoZXIgYXMgcGFydCBvZiB0aGlzIHBhdGNoIG9yIGFuIGFk
ZGl0aW9uYWwNCj4gb25lLg0KPiANCj4gTnVubw0KPiANCj4gUFMuIEkgaGF2ZSB5ZXQgdG8gdGVz
dCB0aGUgbXNodiBkcml2ZXIgY2hhbmdlcyBpbiBwYXRjaCA2LCBJJ2xsIHRyeSB0bw0KPiBkbyBz
byB0aGlzIHdlZWsuDQo+IA0KPiA+ICAJaW50cl9kZXNjID0gJmlucHV0LT5pbnRlcnJ1cHRfZGVz
Y3JpcHRvcjsNCj4gPiAtCW1lbXNldChpbnB1dCwgMCwgc2l6ZW9mKCppbnB1dCkpOw0KPiA+ICAJ
aW5wdXQtPnBhcnRpdGlvbl9pZCA9IGh2X2N1cnJlbnRfcGFydGl0aW9uX2lkOw0KPiA+ICAJaW5w
dXQtPmRldmljZV9pZCA9IGRldmljZV9pZC5hc191aW50NjQ7DQo+ID4gIAlpbnRyX2Rlc2MtPmlu
dGVycnVwdF90eXBlID0gSFZfWDY0X0lOVEVSUlVQVF9UWVBFX0ZJWEVEOw0KPiA+IEBAIC00MSw3
ICs0MSw2IEBAIHN0YXRpYyBpbnQgaHZfbWFwX2ludGVycnVwdCh1bmlvbiBodl9kZXZpY2VfaWQg
ZGV2aWNlX2lkLCBib29sDQo+IGxldmVsLA0KPiA+ICAJZWxzZQ0KPiA+ICAJCWludHJfZGVzYy0+
dHJpZ2dlcl9tb2RlID0gSFZfSU5URVJSVVBUX1RSSUdHRVJfTU9ERV9FREdFOw0KPiA+DQo+ID4g
LQlpbnRyX2Rlc2MtPnRhcmdldC52cF9zZXQudmFsaWRfYmFua19tYXNrID0gMDsNCj4gPiAgCWlu
dHJfZGVzYy0+dGFyZ2V0LnZwX3NldC5mb3JtYXQgPSBIVl9HRU5FUklDX1NFVF9TUEFSU0VfNEs7
DQo+ID4gIAlucl9iYW5rID0gY3B1bWFza190b192cHNldCgmKGludHJfZGVzYy0+dGFyZ2V0LnZw
X3NldCksIGNwdW1hc2tfb2YoY3B1KSk7DQo+ID4gIAlpZiAobnJfYmFuayA8IDApIHsNCj4gPiBA
QCAtNDksNiArNDgsMTEgQEAgc3RhdGljIGludCBodl9tYXBfaW50ZXJydXB0KHVuaW9uIGh2X2Rl
dmljZV9pZCBkZXZpY2VfaWQsDQo+IGJvb2wgbGV2ZWwsDQo+ID4gIAkJcHJfZXJyKCIlczogdW5h
YmxlIHRvIGdlbmVyYXRlIFZQIHNldFxuIiwgX19mdW5jX18pOw0KPiA+ICAJCXJldHVybiAtRUlO
VkFMOw0KPiA+ICAJfQ0KPiA+ICsJaWYgKG5yX2JhbmsgPiBiYXRjaF9zaXplKSB7DQo+ID4gKwkJ
bG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOw0KPiA+ICsJCXByX2VycigiJXM6IG5yX2JhbmsgdG9v
IGxhcmdlXG4iLCBfX2Z1bmNfXyk7DQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwl9DQo+
ID4gIAlpbnRyX2Rlc2MtPnRhcmdldC5mbGFncyA9IEhWX0RFVklDRV9JTlRFUlJVUFRfVEFSR0VU
X1BST0NFU1NPUl9TRVQ7DQo+ID4NCj4gPiAgCS8qDQo+ID4gQEAgLTc4LDkgKzgyLDggQEAgc3Rh
dGljIGludCBodl91bm1hcF9pbnRlcnJ1cHQodTY0IGlkLCBzdHJ1Y3QgaHZfaW50ZXJydXB0X2Vu
dHJ5DQo+ICpvbGRfZW50cnkpDQo+ID4gIAl1NjQgc3RhdHVzOw0KPiA+DQo+ID4gIAlsb2NhbF9p
cnFfc2F2ZShmbGFncyk7DQo+ID4gLQlpbnB1dCA9ICp0aGlzX2NwdV9wdHIoaHlwZXJ2X3BjcHVf
aW5wdXRfYXJnKTsNCj4gPg0KPiA+IC0JbWVtc2V0KGlucHV0LCAwLCBzaXplb2YoKmlucHV0KSk7
DQo+ID4gKwlodl9zZXR1cF9pbigmaW5wdXQsIHNpemVvZigqaW5wdXQpKTsNCj4gPiAgCWludHJf
ZW50cnkgPSAmaW5wdXQtPmludGVycnVwdF9lbnRyeTsNCj4gPiAgCWlucHV0LT5wYXJ0aXRpb25f
aWQgPSBodl9jdXJyZW50X3BhcnRpdGlvbl9pZDsNCj4gPiAgCWlucHV0LT5kZXZpY2VfaWQgPSBp
ZDsNCg0K

