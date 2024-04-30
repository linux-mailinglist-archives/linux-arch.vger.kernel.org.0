Return-Path: <linux-arch+bounces-4093-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEA88B7E71
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 19:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4581C20E6F
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 17:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA5F1802D9;
	Tue, 30 Apr 2024 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l7B9CQQD"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166CF1802C3;
	Tue, 30 Apr 2024 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498126; cv=fail; b=WKLFlArvYe9lPpg4vABuywtTbWUesSmlcl4pbwIjY4xU9vK0/dnOhB0Y0iZGuOS6sPGXmI4TohBFNZ7V9sszYYAvlzRLkid7c/yP+FWpn0UkDKd8te+REhbbczdv9a862lgEwBY0pzBFUunFnQP7xV9cePcuwWAqNILV9sxICeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498126; c=relaxed/simple;
	bh=YWHRHSfs5pp3XI0wXjxwXLP2pCGWdJhM5+ZM8ZMdRF4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NZx8a3VVZX/Gbe/MPHpzkpHUXW21/ZUT5OJprcNl9q6sbMpLAb8lx0TWQBsdUZDo7jLH6YzW2b+krm94+OwjojaQrr/BZtubw5BbYhuAoz+wZZmy+EuyL/z3cCGyfi8GxownlhQJCHmZkcsBs5IrK/cZRruzEefVsphd8m1gqjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l7B9CQQD; arc=fail smtp.client-ip=40.107.102.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tx6+FjKZ14dRjUZeT4AJzyqny+5gc+RfYMC+93lRu+KG/WC0S5ynXxB/itPnGm+/gPQ9r7Ua/6/+k86o/Qo7zHw3egNmwKpR3h9616A+p0FnjysVAWgf0A8Ko2Lo0Wnd9M4Rwkg3chGEDyOEIbrCwXB70aBmf7Ey1w70bSxXfEutOtX9Amj63h8cyXM33lXgCFFELkdw7PTR81wlwHYsjgBs1kFsBdC9pLmyqRebUJmQYhUjiM4GpPYsJdXZTtNYavnplyUlOw5PHp+5uStIgjHX+Op7umv/OfjZ+ub6OvgUPCtZjb/2gisVM0EVViGpeV7dDBzbCnlR8cWMn1P6+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfavkL6RkCYPJ8lsY9luhtMg6E7mYWfiuLtc/fLztT0=;
 b=NkxT8/WtFlKSYH+pmls701SB8LT6PXJH72mqQksSD/0M2l5aa1tNX/BimEIRBXwMNLgR8AfwtZT/pHZulk746Gfa6bvY5YEBajfKkvFz8Ne1g9qDzuLk4HxBB1TWwfPTKNBfi9eoAvQiUIuXftee3BhkDYdxPAaV0yCbs60t7BFK/wLoosqHDv+3i4gLSkOYrc7+dbGDynOFkTuQezgcM1F6eA6Ru2b0dZvKo+zXHfRqh/WdFlbc0eWLlqEgifsUVveh6mB9tVSi7maHEBJCql4RSE3aNUg7nKzpmAPhOSfvzrgKIoEFV/fT6v4bddNjLJSTOLx+CqjKXNyUoa28+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfavkL6RkCYPJ8lsY9luhtMg6E7mYWfiuLtc/fLztT0=;
 b=l7B9CQQDWYQ5n6HuxQ7FgqLYcLudznfdk9ev+e2i6cqsAUNJBB9tJLDU6APpJy6gNPj0LV/n8qPTIIdUKRjmOO1/ennNbGG9RX4Gnk0yu5HNZR3FYxAbNYbcMo9/im+Mo+wBgJSZcN5WKhJgr2IIb83CCyWz9M1kEOKYB6sQj0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MW6PR12MB8999.namprd12.prod.outlook.com (2603:10b6:303:247::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 17:28:42 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 17:28:42 +0000
Message-ID: <c2fd505a-1d4e-411a-80d4-c088843313d6@amd.com>
Date: Tue, 30 Apr 2024 13:28:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] drm/amd/display: Only use hard-float, not
 altivec on powerpc
To: Samuel Holland <samuel.holland@sifive.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Michael Ellerman <mpe@ellerman.id.au>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-13-samuel.holland@sifive.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240329072441.591471-13-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::16) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MW6PR12MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c8bf1f-1a6f-45fe-58ff-08dc693afb2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVU1ZEZmbzJ4SkJhZ0lXV0c1RFFreTFESkEwWWlsaUZWVW1TUjZQelVrS0Fm?=
 =?utf-8?B?M1NnQUlZdEo5TVhON1NvZVFDaXZmV3QvQVhQT0lwTmJuU2lNQ0hWTFRyQkhh?=
 =?utf-8?B?aSt5S2EzK205VDc2QU15d0d5d1ZBbnh5KzB2SkRMeGs2VW1HUGlsTWFBdUxO?=
 =?utf-8?B?N0pTQnpwK1lSR3J1TFFTMVlLZzNDT1VSaGdaQ3UvMWRRbkx4c0plSWFmSTRX?=
 =?utf-8?B?dlQrS3BIZW4rUXNTY0FQVC8yYS81TXYxZE5RUndwanJ3M2VmYzhmWFpBR0k5?=
 =?utf-8?B?MGt6ajFEcUY1MEJ5VFlQZGpGYzJFSmRXUEtnSEJjbFA4Y0s4cHh6MmtNTFRq?=
 =?utf-8?B?bFZNVDZPNmZTck55MFFvd3lnKzFHQmlLalAxeUZ3Q21LSWVJaGtFQjNvenZK?=
 =?utf-8?B?T2ZKZHZQM1RRWkJuL2tCNHZOaTNoNHZSOHgrd0JveXQ4d0F1T3B3MEJrK0wr?=
 =?utf-8?B?enIwSnpnZGtuOHArSnZzTldtdUMwWnRVNzh1UktVd1Q0aTNTNFo3cHZxNU1P?=
 =?utf-8?B?RXFFRUZtNTdzaThjTXZSS2FnQmNLZ3FiY3Mwd0xBQzBmcitYbUZjWnpJb0hq?=
 =?utf-8?B?N0RnMVV5TjVOWUt3TERudWpPcGduQ3hVdksweXZtWjJldzZuZXRMeFNxTkpS?=
 =?utf-8?B?T3F5TGV5R3hRR1h3Qjc0SGQwcytqcTVtdVBoTE15bkZnU0VpOVJRdXphcjNY?=
 =?utf-8?B?cU5PWjNqKzl6ZTM0MnFCYkVMMUhTVTVqaVppN1B0bjZJczhYejYyQUNSUU9U?=
 =?utf-8?B?Z3dPT1AvRWY5MHJEdElueTQwMXErSThINEN5a09Dd2szckkzZE1Lc04rVlBU?=
 =?utf-8?B?Umg5dlMrNkRTUGpORUNUSEhMSkozMjdSR0dyTGdhZzhmTUliazdmRU1HWWVw?=
 =?utf-8?B?SjZJeEwwclhJeVFDOVdFMHFyZEZjVThENHB2eVBRWHI4Qm9yM0lYOVpLSTZa?=
 =?utf-8?B?S0NhTjhFMzVTL0greXJqVFljWkEzZW5IZ1FNY0pmV3JOU2xpempFeG1hUDdK?=
 =?utf-8?B?aFh2QlFqVUgxcUxrM3dDQjE1YkF1L09BTkFybXRHOU1SNGp4ZVFaSTZNYWVa?=
 =?utf-8?B?SVZIZ3N6WVY0T3JSd285RDRPUHRWTUFMT0oyVy94enNDWHpnQm0yTlhmNCsw?=
 =?utf-8?B?TUg2S2xLVVJlalhvNUtVWDN4M2lyRTFaZUNadERrVkdnWmxESVRsWStQREd1?=
 =?utf-8?B?UEFhNHBycEpmdEhBKzdBTk5qZGMxRy9oS0ltNEc4UThHR2xiVjJDeDQ3N1VV?=
 =?utf-8?B?R3RRcVQ2M2lvUmFkQTZtYytBS1ZHVTV6bkxGVkFSakhoYm1UZjF5Sys0R3pw?=
 =?utf-8?B?bjNUR0o0Q3paTFJZUTIvbjgrR0lqZm1jSXM2Uno4cTlMMHRpNGlHSnUvR1hp?=
 =?utf-8?B?ZVNzNDdUV09haUFOWEEvTDh4Nkk5NFVYMHZuaTl5TzFUYmVlbXVtSU5HRkFD?=
 =?utf-8?B?V0tGY1VuM1Flai9yUWRuT3NkSG83SFozcXJrYTdmTC9GTmd3N0UzNUI0cVAw?=
 =?utf-8?B?cTdtcS9VR1pWZjUvM0MyVWN2TkR4alNXSFRRVm5hbUszRUw2d0pYbUlNM05u?=
 =?utf-8?B?TTc0VytHbWV3YXI0d0F1WGQveDNuV2dnb0tuOTZCa2orM2dLSjJYbW5WbEdP?=
 =?utf-8?B?Y2dFVkhyL0krWENMVkZNZldONTlmUjlsQjMrZE5RRmpyMWZ3THJwUTB3VDlE?=
 =?utf-8?B?emw5eXdWa05iWkV1RUxGQXE0Vk5DQlQybDBFYlRkbE1MZUlMendhRDdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVR0emlKdE9ZaDJwOE1EL1gwZFNudHhvNzRxU3ZLSWIwNThyRlQwY3BtcDZw?=
 =?utf-8?B?c0loTFhKYXJtNitxWG0veWtsUkQ1WHNaYUNKZlF3TjZmWEdzazdncXhmazds?=
 =?utf-8?B?QjlSZkJScXlTVHovNjRsQXJ6ZFBCZEExY2VtZmpkMDFGNmVZV0ZvU1VwVnFC?=
 =?utf-8?B?cnFNcTNvMFBUaHJlZy9Dakg0Y3dKdWliZ2cydG5LVVI2WklrNWdDZjczYWF3?=
 =?utf-8?B?TU96MC9iVk5oQTBGUEllTUlaMTRienRXRUk3RUZDbDByYytFTmMxM2pDV1Fr?=
 =?utf-8?B?MUFuMk0vOVd3OUg2dXgrbnNpb0FhdE1zMFp2MTYzWk5FR1pFSiszWWl4bG9w?=
 =?utf-8?B?ZFFtTHpvWTdlMUpaUDdMaTlkem5pbVJXcnhIRTdKT3JDOWsreGo0MnI4dUNq?=
 =?utf-8?B?QjFxdjhGRWxKeEVkQlozYjR0RzdPSXlTTGdPZnRzRDI1RW41SHhaZWx0dUU4?=
 =?utf-8?B?Snd2cDVlb3ZXMkJFQTNXanNzMDdXVy9nWGR0dk40ZFJWTUFhSTFUMkNnWG1H?=
 =?utf-8?B?eEZqNmVsdmxxU2pwVHhaR0VEK2tRMGFaWUY2SkFhTmtaNHF3SjcyUlE1bmJ0?=
 =?utf-8?B?cnF3OGYycldnRFZpRHM2TmsxeG1wM010Wjc1R1lFZ05KenY0dGQ1aVk2MVRr?=
 =?utf-8?B?cHN2ekduS2NMalMyMEdyZnlMUXBLQnJjelhvKzdGSGVCQVQra2ovM25ONkhN?=
 =?utf-8?B?U3NjNzNxWHptWVFuL0FsMURZaFFZYXc1VVVsVGdsQ2RTWVpkME1hdTlWcCt1?=
 =?utf-8?B?cVFwY003ZSt4c2ZNbnQvalRONUhrUXpvdFNuT1VDc2wyMWwvemtMOEhkYUJQ?=
 =?utf-8?B?QlBNY3dPOGpDK3c4ZXNjVmt0Y2Z1cG5uL0hmcC92Qzl3cHViRTE3K0ZrUEg5?=
 =?utf-8?B?Ym8yMlZhTVJPbDF2MVNCRm5GZ2tBc1MwSUwza3pkTTVsbkcyeGI2YzVHODJI?=
 =?utf-8?B?ekx0RTNyT09qT0UzNnRzbEw4dmxhWURwN3JhdHVpUDkwSGVIRGMvcFFyMUI1?=
 =?utf-8?B?TWlHQU11RG4rTlQ4UUVhMmVGMkt6T2cxbGMrRjBBUFB1QzZxWkZsSGp0ZFlk?=
 =?utf-8?B?TnNGODdjZmtnM0pvcFJYWTFtd0habCszMFAzV09Ra3VUWXlEaWI4WWRuMDBk?=
 =?utf-8?B?SmJOd2dIek4vNElWbU5PQklLdlBUQS96azR5bWliN1g4OTBKSHVUTmNabmlq?=
 =?utf-8?B?WHQ4ZVM0Q1M2MFJrbVdmSnNMWStsQ1FvaWNPUHZ5Q21UdFVmVzNqVWx4cHF6?=
 =?utf-8?B?TmlkZHhBZUxnbzh5WnNsK1hLdVlEMFJzUllzM0xCUnYxYVllanVXaEszd0J2?=
 =?utf-8?B?V3pxaVlvT0RBSGR6L1hSc2dncnVSNnNPS05vZjQ1RytZWDFkZXNxVTU4MG5Z?=
 =?utf-8?B?NU1sNjBabGVIRE0yOTQzWCttVVprTkxleGxvRXYxTW9IQUFwK0tnSFdRYW9F?=
 =?utf-8?B?RHRaMEQ5ZHRKSllWeHdkaGl0a3ozWGRpL1gyOFNQUDVKTnlIbWlpNVZTODE1?=
 =?utf-8?B?eHBiblNybys1c05BUllVRGNlTFU0cDI0cjZiVGtiMnoycUp5cTRna0dRcTBi?=
 =?utf-8?B?bVBoSHhNSHlFa1p4Y1lNU3Z4SjI5bjQ2N09ITnhTUHlXOGhYdlZtRnQ0cXND?=
 =?utf-8?B?Y3ZScTNuL3YzMVFYYUtWaGZsQW4wYlRTaW55QWh6dkF6eUorbmtvVTFJU0xx?=
 =?utf-8?B?RTRiVVhMa0o0cWZrUDZ5YzFYNzJ4WjNuU0c2U3F6VU82dkI2T1pJaXlIb1hW?=
 =?utf-8?B?TEQyUjdhaHlUYWRVVGdwaE83QUsyUjZXbWZ0VEphVE5zem9Zc0RMQXIwdml1?=
 =?utf-8?B?TW5sL2N4M3BWeDNhN1diV21YZzljN0V2RVo0Q2xIVFBEMGUxeFh4MzlZc1BJ?=
 =?utf-8?B?THpjbE01RnNwMTdiUk10SmRNSnZRSG83QXhkMGs2QUROQjVqTlcvaUJ0Z3N2?=
 =?utf-8?B?SEFCY3dXemxBRWVWU0NyTGdCQmJFM1IxK1BPUHRoZE0xeGI5VW0xcHJOS2pw?=
 =?utf-8?B?NG5QalVtQVBnQ0tHTTZRWkhOYjBVN0dlUUNmRkRMa3c5NnRDUTdJa2JKR2VH?=
 =?utf-8?B?K2Z2MHRkMk5ZWXRRRWV6ZktyY09aRHVTakVFRFJXMDYwai83aWYzWWk1ZUh3?=
 =?utf-8?Q?q6EcKyauALuVzmBBi3FlxMZD8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c8bf1f-1a6f-45fe-58ff-08dc693afb2f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 17:28:42.5166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxAdDidFwh+KWt+TifQA8t8UOoHX29w/cwELUQ8CipUgYA67W/e0wpIaoCi12S0FGGvxAgoSklnbwnlqbaOydw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8999

On 2024-03-29 03:18, Samuel Holland wrote:
> From: Michael Ellerman <mpe@ellerman.id.au>
> 
> The compiler flags enable altivec, but that is not required; hard-float
> is sufficient for the code to build and function.
> 
> Drop altivec from the compiler flags and adjust the enable/disable code
> to only enable FPU use.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
> 
> (no changes since v2)
> 
> Changes in v2:
>  - New patch for v2
> 
>  drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c | 12 ++----------
>  drivers/gpu/drm/amd/display/dc/dml/Makefile    |  2 +-
>  drivers/gpu/drm/amd/display/dc/dml2/Makefile   |  2 +-
>  3 files changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> index 4ae4720535a5..0de16796466b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> @@ -92,11 +92,7 @@ void dc_fpu_begin(const char *function_name, const int line)
>  #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
>  		kernel_fpu_begin();
>  #elif defined(CONFIG_PPC64)
> -		if (cpu_has_feature(CPU_FTR_VSX_COMP))
> -			enable_kernel_vsx();
> -		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
> -			enable_kernel_altivec();
> -		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
> +		if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
>  			enable_kernel_fp();
>  #elif defined(CONFIG_ARM64)
>  		kernel_neon_begin();
> @@ -125,11 +121,7 @@ void dc_fpu_end(const char *function_name, const int line)
>  #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
>  		kernel_fpu_end();
>  #elif defined(CONFIG_PPC64)
> -		if (cpu_has_feature(CPU_FTR_VSX_COMP))
> -			disable_kernel_vsx();
> -		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
> -			disable_kernel_altivec();
> -		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
> +		if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
>  			disable_kernel_fp();
>  #elif defined(CONFIG_ARM64)
>  		kernel_neon_end();
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index c4a5efd2dda5..59d3972341d2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -31,7 +31,7 @@ dml_ccflags := $(dml_ccflags-y) -msse
>  endif
>  
>  ifdef CONFIG_PPC64
> -dml_ccflags := -mhard-float -maltivec
> +dml_ccflags := -mhard-float
>  endif
>  
>  ifdef CONFIG_ARM64
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/Makefile b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
> index acff3449b8d7..7b51364084b5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
> @@ -30,7 +30,7 @@ dml2_ccflags := $(dml2_ccflags-y) -msse
>  endif
>  
>  ifdef CONFIG_PPC64
> -dml2_ccflags := -mhard-float -maltivec
> +dml2_ccflags := -mhard-float
>  endif
>  
>  ifdef CONFIG_ARM64


