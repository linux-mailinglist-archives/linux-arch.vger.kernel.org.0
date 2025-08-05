Return-Path: <linux-arch+bounces-13065-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11689B1B524
	for <lists+linux-arch@lfdr.de>; Tue,  5 Aug 2025 15:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB07182FAF
	for <lists+linux-arch@lfdr.de>; Tue,  5 Aug 2025 13:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E8722F74D;
	Tue,  5 Aug 2025 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3DJLailj"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE4A27586C;
	Tue,  5 Aug 2025 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401345; cv=fail; b=UTrfn1+4La70UVLcgEnKbe0DH7iC9n3B+j51enZ4ROg4NoceDGTohD0Miv8ARiLo42njpzi128zY8MXRLNkE6vV+VqQV+b7/dlJbjFUh2mpTKozVZFmIBNPEZadwg+3OuJh8QuYbKsxL7MI3OrCy2jfSgsDaX2VsUnEKqyg/fHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401345; c=relaxed/simple;
	bh=fkiVyF+h+mMS4GGWjdah9O3mqVr3uxyzjef4sNAOaok=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HlqYQjHcVhNMIkooCI0O+Vg41eoZ6eYyKH9Q10VoEqJWr6PcFB7GV81jefZ9b6rZC0wUdJVvWINZIPEuxAFUKfe2ap/UznoVfdzQNQzpPdNUt85G29pLi8tzi+LsEIEMGi2/J0KDppQFk1S5GEyBQUaMO9iYaRxUQkCTw43jXdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3DJLailj; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8jKYckcaSj9fhCkFqRqd3bfujK/R+RSJMIhBvjkYMXM7EzKjPyiSkovy+iMdTpcxPa/V0FrYsBIaH6V8W1+1uRDOT1k4bKo/kLYqu7wNE8p2wba58Ba7kxn1rawykKEqWEQ5uZ+wpxRS8f3u+UebOavBoxjxS6Eg05ik5LmjjN5Gmpkb0ySYxDEM5ckKoeq00qFnRfPdBXB4d/aIHDN0XHmusDCjA3t8R7e/cJ9FTPLeLzKDI/LlBN1koT6vxeF0Ik674uDiaXr8sBzwQ+ZGS74EDpEmHkdaz01QO19UvwuNHCDKTonhXTvZ49PHzI5VQlVFYBXVsMgdUa+cHsc0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L73SDsNmaSbCdMwVX0mGGaY1g7ZBOJnDo4cwo7lKz9Y=;
 b=U44SGo0K5asTKVzy4y0lCYtQZoYTZAfqb5rtwVEIyc8v9bDTfcpOpIsEjjpXs4fnZE8KoqMz1taDG5JiQJFRqtme3k+/SxtiM9H2GXcw+S4EIVsprgL0O7PU0Pogpv7KnYo1chUHI+u6SjyTslXKoUZ6nA088oWcfeP4PEg/Gv2+8xCXsSoSJ5hF4S499Dpp7YKqBRJlXFAcyNYymDnZ4vj25A7dk2jenHXYk75p3GUmWZPo9sifgmS/qT1VJpz+CN8Ez0SdHshwGof2+MJAWD7AMMeOe8puW5tQMmnR/nbk9lDCspLQJnwwMpYKn3IDDMYzjXBiBmbLDfo5OS8iwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L73SDsNmaSbCdMwVX0mGGaY1g7ZBOJnDo4cwo7lKz9Y=;
 b=3DJLailjMEWV1WNxUsCEqSv0+7llpPV3+gA/eqfPW/r29i1mtwMMAwGiLLOqrVI+VQs4Jv35YXqVFis0qoNL2wCqW92JRhhGjhvHEx9MKFsb8ouC54RtF7crcv5OHaBrvn20lGs3WFJ9dY6JXcgvIiuRwu/w1lijTlB0Rhl6ips=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Tue, 5 Aug 2025 13:42:21 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%5]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 13:42:21 +0000
Message-ID: <f243416a-6c6a-4fe6-95a2-8bd1db326023@amd.com>
Date: Tue, 5 Aug 2025 19:12:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V5 1/4] x86/hyperv: Don't use hv apic driver when
 Secure AVIC is available
To: Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 kvijayab@amd.com
Cc: Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Kelley <mhklinux@outlook.com>
References: <20250804180525.32658-1-ltykernel@gmail.com>
 <20250804180525.32658-2-ltykernel@gmail.com>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20250804180525.32658-2-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: a9cf7418-2275-4165-e697-08ddd425e6b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnR4RUphd1l6dDZHUXlQOUxDK1E3cWR1MkVhZkVzYTZzeUVWazRnc0NwQXVz?=
 =?utf-8?B?NUpZZEYySitnU0JYbGNabkFEbElxWm9Uakl2NHNXMnZJdzh1eEFrcWx2cUJS?=
 =?utf-8?B?dXlzQmkyR1hHRHpZdmtEWGdiaDE0bm1xbnZ3THFGd3cyUC9BSTdjTlF3L0Y4?=
 =?utf-8?B?bmt0ekJQTFVMYzZDTUVwNHZHdDZLUEZhV3ZXZGdLMFNNaHNidHdhQ3k0RUpY?=
 =?utf-8?B?U0htTnBCditjRndBT0FjSlZxV3NRejFPT04zdVpkN3ZjMzdQR2VNcVBiWmwv?=
 =?utf-8?B?cXVRRGlQaDlNUEZoSjE1RFBPOGhrcVo2elJpbU9VUDJrOTl4SWtLTStML3dq?=
 =?utf-8?B?aWFVeWoyU0VDOUJqMENEYXVXL1dpTlVGV3FmRTFqQlR4RzUzTGpLdU5WRGhl?=
 =?utf-8?B?Ui9ScXZpbC94MitJZlM0NjZ0RHJUS2hDSktvUUFvdERodHB5U25qQ1o1RTlO?=
 =?utf-8?B?QjJ1cllWSnEvamhiQmg4Y01lZDl4ajFSVk1VcVIvclZVc0hNNEdLYnpsZlRZ?=
 =?utf-8?B?RDMzM3psQXBsRnFuQ25Ka0JaeWNhQWVWYWZWZy93WUVYMXIxYjV6U2MzVlc1?=
 =?utf-8?B?TU1XMEtPdjNucnVPU2lnM1JIUE9WRnQ4UTBWLzJ4WTl3N0RGQUxwTTZpL2s1?=
 =?utf-8?B?UXRsVmRCNFNhVnBZSVprdUFaWE1Nczd3UEM5QTFkaUN6c2QrTXlOY3Ntb3hu?=
 =?utf-8?B?bHpPYlYrS2dVRFdmNXZVQVJrNXZvdUl3TkxoM1NLZzhVaEp3dnZxTmNYRGVu?=
 =?utf-8?B?TXNtczNIYXYyakhXOWZkdTZiM0gvSnNOLzlaMldXWjRXZkJTT3lQZVd1UXJr?=
 =?utf-8?B?MjVJMFF4VkxuaGYvZ08vdHdxZDYyQUI0dFNXTVczM2M3NmxCck5jdTR2VGUw?=
 =?utf-8?B?SFV0OERsNUlRVGVhTC9HczBuS1pHRGRZY2k5M3lORVc2dCtFVHl0RW43SCty?=
 =?utf-8?B?T3JuSUtIMDR3VmtYSDc1SmxQUWtVNjBpemJmR3MzcFphdjF1ZmdWOXBsZVBW?=
 =?utf-8?B?eUlHYXk2MHZiakRhZlR5alg4RzNuYVRJVkVGc0ZFYnVQWTM4dmhaU25CZEZw?=
 =?utf-8?B?RGdJc2dma0FwMktjbDN0MnBiVnFsNENmcSsyOFEyT0ljVjFraEFST0dkRVo5?=
 =?utf-8?B?MkRSRHJGc1BleHhtYTlwOWFrOXltMHFOejViOUNLWXIyeCszUkxMbDYvRElL?=
 =?utf-8?B?eWhwVXdsNUJnYUF2N3BsT3JUMDdZRyszYVRVTDBHZmJtbkRMZVMzaWovcjRG?=
 =?utf-8?B?eHhHbVBwblVVczVRSXdqZ2hBMkp6NE1wQ3haVDZjU3lSTTJvdGx0WmhjVDRq?=
 =?utf-8?B?VThrOEx4SElzdEFOajJpb3dERnFNWWFvTVI2WERoMEhjODJ2cHBiaE9WWVNB?=
 =?utf-8?B?UVd1cVg2VlltWUJ1K3pTS1BzMythM1RZOXFXU2ppM0UreEs0Tmh1NW4zY0k4?=
 =?utf-8?B?eW9EUHVqRUFWbVhZZWRSM29wcUNmeW5KZDY0ME9EVE94TzZXZmltazJDYUJW?=
 =?utf-8?B?N0RhZkY3NnVsQk9SaDYvTDIrZ0lkK3NzZ3NCOWNDcDNKRGttKzdqTDQrQ3pX?=
 =?utf-8?B?d0xKTWcrTUhEK1B1ZFZRU09sWWc1b0UzMFFKUjM1SFJndXZZMmtpNHlBb0do?=
 =?utf-8?B?dWQrdzk2V0l0NEUvVFZXUXF3elNBc0tqUTV4UUduVUhkWElhVk5sRWkwTVha?=
 =?utf-8?B?OE95NWgxNFRqWEhHVlJ1alF0VllnV3RZWjAvVi8yZklJSzJxUUdsazhZUnFJ?=
 =?utf-8?B?Wlp6Z3dpb0xJb3hQWGJDb3FCT3ZCWUM2Ty82dkg4N3RLM0VDTkdsR3dBV09Z?=
 =?utf-8?B?dVBraStCOWp6Si9RY0wyTmlYREpzWjhvelZMN09iZW1aYlJkWWd1emZJZUc2?=
 =?utf-8?B?KzJPMnY1WXRwS2huSjdEWGxaODc2NmhDcXFpWnZ0aU5qQ2M5bGlkaDZLbmYv?=
 =?utf-8?B?Rzg1eVFCL0NHTXl5OUV3WnAxaDZnK1BXTU5qNDZWeExIejY5ZCtXMHVZQ3Zv?=
 =?utf-8?B?RG1VbmE2ay9BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzJvY0d4MkdHcmpHSzhhSVhST0V3SUZGdmljenJaTFhhM29RaGdYWXladEJq?=
 =?utf-8?B?ZG9zZnlTTXZzRFhEVmVhNmFvcFIzWDcvcXIyL0ZNcUExRGt3Y0V4VTUxSzIx?=
 =?utf-8?B?MGRiQ3MycGVTQ0VNZTEzYVBLNUpkeWN5Nm5Fbm9qVlpHL3dxT25talpQTFIz?=
 =?utf-8?B?Nm1taTRYUmg5V1U2STl6N1gzWHQyTGFJQ0w1aVh2QzRFNC9ML3BZSHdZajJB?=
 =?utf-8?B?R01iMnlkcmVhU0V6S0JyWEFJSWtEcmZZbzF5T3FkVkh2YkNnemk3YS9PVGlK?=
 =?utf-8?B?bnpscDRFRVdBTnN0SkxTcHNUbTBvYlJTWWJvc2VNVDkwZFpvZGdIVkY2eGhr?=
 =?utf-8?B?eUx3OVdmelU0UkdLaXdPeVQ2VC8xNVlHYnkzNnZySC9GRUc0cm1DRklqM0lE?=
 =?utf-8?B?T05WQjhDN3ZBT2lDVGo5U0ZaSGc3Mkt3SGNsRHluMmhiczhHUkZtRVpaUGtq?=
 =?utf-8?B?OXR2QnRjanlNK29Eb0d4V0VxRGozVzJNb3I1NHRQcHVZN0w4d2NoSzhiN1px?=
 =?utf-8?B?RzJOMUNFenRlbUJvbnJKOEd3dVZFU21USmdFdkUxdWo3MnhiOVdzUUxMWFBu?=
 =?utf-8?B?UjJ5MDNyamE3MmltWTJxZFREQkhET0Z4RlV2c2J5RWJhS1VxRlg3TGx6aG93?=
 =?utf-8?B?dGdtbGhTdHoxTDZLTW1EMmxkS3JGSlozTy9XL2RTR3prMEd5SUZ5WnlEWE1D?=
 =?utf-8?B?aFZmMVU1RDQ5RmIwRWc5cTd4c000NEcxbk5sZFFmQnhGcE00d3poV1Z1SEZD?=
 =?utf-8?B?TzJVUXJtbjZLS3J1M1ArL1pGTDhOQlZJeG41MGxEWldzZmRYTEpsZ0s5S2xW?=
 =?utf-8?B?cEd5N0hLMnJSOS81eit1dW5rME84OEV4ckQ1czhWK2VYblJac2hEZ0FsVDE1?=
 =?utf-8?B?M1pNelpXTWIzSUhPSDFFcXI2NE9PSVgrVU96UitxbHVEZXlOMVh0Q0RkdGdO?=
 =?utf-8?B?R2MwU2JwY2FMOG9USFhkSnhPOHAxeFZwVFQ0TTNFODVYTTRVUFdMUHlrZ1I5?=
 =?utf-8?B?cXhXM1hQSUZEcWVJV2h0Vk1qSGVyYUhxTjQ3WXREbXJSTlY5M3dTeDZsR3hu?=
 =?utf-8?B?cGplVkFuaWpTWVNSekdLNGY4VjI5OW1HcXZ2QWMySHc3TmFDNW11NU5nNXpB?=
 =?utf-8?B?WjVIY2VSemVMM2Q5bngva0ZRR24ybWhMRW9NUjF1TTdpY3pOUVlxRCsydkV6?=
 =?utf-8?B?TFlaT3diMGdETkttZllOTTBNdmNCREYxKzQxR1hrRDJCd1Q5UWZDeVhLbCtC?=
 =?utf-8?B?cEMxMEFnMHFHWDBZVGZjZEY3b25PdmdMR1dLd1B0TjRxM1BTVFN4UmVCVWVs?=
 =?utf-8?B?WHFQZStwRXhxWkJJbXdwTkUxTDcxRDNHTzNpODNoZFBlQ1RaV0lZS0VqQzdp?=
 =?utf-8?B?c2hzKzVRK2RCSHhQWmtGWkkzRFN2UU5GWXBFWG1SS2NDT0xkMW1RMmZMWmdL?=
 =?utf-8?B?dTByYmswZnBOUFhyZFpQL0ZTcGQwY3Q5S2diWVNWemVsaWFzTkZISjFPUnVD?=
 =?utf-8?B?VGFDRFRmRU9OWDNBa1dnUm52ekJZaERQVWNzZUN2cjZiWm8vRkl6cE5RbWlK?=
 =?utf-8?B?dGVpcGdFa2swdExsVU55UFpwUHRNK01NRmdrWXZ4OEplWDA3emRkTHJIdGNF?=
 =?utf-8?B?Tjh4WkpFbEhrTnFhSFhpc3dycGNhOFpPYWRxWUNUMndDTmlXeEZHOWg0Zzc1?=
 =?utf-8?B?elJYTjhpdUFwczJVWWFPcUdkMmZVZ0R1SGJPSHphY0M4TFZac3hwOWszdlFU?=
 =?utf-8?B?V3NKZXdBRzBUdURHeklvOW1NdFhBcXlwU3pCY2k4Mi8zMldla3RHQnhlRTda?=
 =?utf-8?B?WVdNYmQwRVYyd2VONXVFNnF3UjAxQUF0RlJhbFhkL2ttdjZZWVA1czNlcFdx?=
 =?utf-8?B?eHNnTnMxRnRTNXB0OTk2UWxnZXZkWnhqNDRBdllDYS8wL0p3Sit0Z2RoeU42?=
 =?utf-8?B?ek91b2k3SHN0NWN4VlZEa0hvYmJDUW04VjkrSEZlMzY5SGhUMUtkMjNDWUps?=
 =?utf-8?B?S3hGNTB3b0hvNTNmM09mODBZR2R3U1ZxeFlzbXlEMjRkMDg4OXdDb2ZySTNO?=
 =?utf-8?B?RGRMYUpIdW5YNGhEN2drdld5TUc3eVY5VWlnMjdLY0huQ2tvWElpZEFNYmRw?=
 =?utf-8?Q?OKqIOJ5LA/+aRRNFRULFcxJjh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9cf7418-2275-4165-e697-08ddd425e6b9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 13:42:21.2517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZv1XouVAho8K5RcsvzaxrduB7WZIW7XQt8wtZ4CgcD6TOh+7zBm1TgPTI+bF3JUk5SoxCDuka4Z9zvYLSVCnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229



On 8/4/2025 11:35 PM, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> When Secure AVIC is available, the AMD x2apic Secure
> AVIC driver will be selected. In that case, have hv_apic_init()
> return immediately without doing anything.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---


Do you need to include linux/cc_platform.h ?

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>


- Neeraj


