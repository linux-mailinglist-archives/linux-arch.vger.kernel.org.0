Return-Path: <linux-arch+bounces-13066-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56975B1B5DA
	for <lists+linux-arch@lfdr.de>; Tue,  5 Aug 2025 16:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47B9185E9D
	for <lists+linux-arch@lfdr.de>; Tue,  5 Aug 2025 14:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DB827510D;
	Tue,  5 Aug 2025 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GJs3UrDE"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F33272E5E;
	Tue,  5 Aug 2025 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754402365; cv=fail; b=iS/3stKf/7Dg0/ishr9ZbZYcPfvGjatv3BVKfqXY+XTsrXQ4EXv0kHBy8uLfLtxongGJIH5tXtSIkKj/scp5DtwAjB5zp0XoVhKhv6ON8AL/do066MhGNiMfRQCuMrWrYnoTOFseVOTNel9QpRflv2LwXRcGTc6jJsPAND1Hnwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754402365; c=relaxed/simple;
	bh=ndQxu3zFGnxwmoHY6z9QnQceJyQXdJRKQXE8wqzfKYA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FXBxXtQgp3GBAocxUHfDidxaavTXHkRjq4u8UV8dorj0gbjOkhY4J3gGlDAE5eLM9kcLmCwB66rqSTd8v9jnoi67IMSP25kuNQdvtw6etcvVRkfPB9wSzmDuiFWGwXEjGgyK+uVwa1tNfkCRI9BEd+K0RnmdDzpZvqXF4Idl+bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GJs3UrDE; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xw13G5G4eKQzBuAZ+SXGIZkVsrURbvMQ5eQG4p6LonU2GnxFyaFsGPey+m9TlIXXouFf8NldWByDZzCaLXtYhMdH1zzW/Nycm0NAsnlxDaNCv86DikImxhdPTi4HJf3yn1AABfz/XVnYKxez0FJTjKTI+d3+ej1uzy1jNqDvEIX1HeDqklwS23es9qR1K7T+6+DA3Q6S8BOcLKrjf1tNJWkr5VXHRUxYECok8cEsxRAq38eRdkSFWavkqfO1ncsalPg28h+7ffLvy4jVfcdjTDPXPGSoEQ0YFXbdaK6uX9V0Kz19IOg1xiPO6SOwBBQU7f+/KxCVhotRBbnbXVl/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMXWY2W7bTG0sP9P8Xs8zKLgvw7gVdjVlpdn2vPX/Fk=;
 b=cxDqhhuzq8isg2YtBZMkQShZJyi3tLJcpaikss9n1efv16uHnn+IWpqMEJbL+CEE9N0KUYmvHaTH2twg67eCWBe5GN+7zQXukKXEqRCcxQCWRyhMbxHghourjkvxiJaLuh4zUQpdLCrC9+YHyN2pohc0g6hjWvt5cr9E8f3+gQRjGeYlISQB6lsyFcf2DR8BCXMblwZjvGDG/U+7Eng8siM7gb8tjQ0JixuwVQ1cBXZOzuTRj765M1CfXoEl+VfkYD7NzLqnyDpN9vGnoF7YcL6T6D4hqhrN2SzeJSor4pqCPVgzxj4pn0Q0yuEITsyMXaJrcsW+dPNyQPa0n28N2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMXWY2W7bTG0sP9P8Xs8zKLgvw7gVdjVlpdn2vPX/Fk=;
 b=GJs3UrDEak1PAtXguYpy+HrdFkMbmW1ux7YKaS4Zfl7DuRQPonlX7teM8TzBvnge3y35zHhsIyQUZPhvwJdMP19GOXeBXMeftJVIhjeezx8uajFMvcmMSmSaZ7bF5ao7bJPjwXfoR3cQttRpVLOUP42bo9pLsBVHyFzoliPkwAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.13; Tue, 5 Aug 2025 13:59:20 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%5]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 13:59:19 +0000
Message-ID: <912536fc-15d4-4a57-91b5-ec902a93e2f4@amd.com>
Date: Tue, 5 Aug 2025 19:29:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V5 2/4] Drivers: hv: Allow vmbus message synic
 interrupt injected from Hyper-V
To: Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 kvijayab@amd.com
Cc: Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Kelley <mhklinux@outlook.com>
References: <20250804180525.32658-1-ltykernel@gmail.com>
 <20250804180525.32658-3-ltykernel@gmail.com>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20250804180525.32658-3-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0115.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::19) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|BY5PR12MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e5f60c-da5f-4ed1-819a-08ddd42845b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWlweElhTWpvWlVhbnJ3T3dGSjNjWm5jV3pzOTFJQmV1S004NDVlTExRMG8y?=
 =?utf-8?B?eDBBelRMTXRzRWVxWm4xN2tyRk5kREVST3RJQ3lvMGxDOHhyMmNDRlRsUUZ2?=
 =?utf-8?B?TktwUXI3RUFUWkdvRU1yR3NCVTNPMjhuSWlUWXpyajNSWk1sdHVORVNCUXhL?=
 =?utf-8?B?ckFtdU9mTnR1UFFZZ1hSMnU1b2Y1SG44Qjk4S3B1QWt0QmRsRFR4YmJIV0Y4?=
 =?utf-8?B?VnJZNGFnU2V1L3FRYXRRRkJqaEcycms2eFVBTnRydTliMnFzb01zU016Q3VB?=
 =?utf-8?B?WWl6V08wM25GU3dYdHhmOHVwQUtkeGZjNjFPK1FLQU1lTE9pbjJQRnRuekdQ?=
 =?utf-8?B?dnlRN1VTMm5yZ1BVQlMzTmtBMWRQaCtiaEwreDVtUTNZZGxpc1FpdzM5bnUw?=
 =?utf-8?B?dm1DOXlhV01RYkJNLzcrd2VqR0xQU2NHVEx1WDdEVExLckdzYUxjU2FpWlls?=
 =?utf-8?B?Y2dJbVdEUDJTVDZTVEd6V3JoODhGK2Mra0l0QnQrVjlDc0xZWkRHQ1ZYVWhW?=
 =?utf-8?B?NlhneXBEVkRGRFdJMmxOMWdHU1pSdzQzVTN5NVZzTUlIYllXSzdZTHB4OHRv?=
 =?utf-8?B?U3E0a01ZOUtUWnBOeVRaTWhXQXpSTlNWOHlVQTJjeExsSEdJOE5lVXk2RTdh?=
 =?utf-8?B?WDEvbkZHc3NHeGhXQjJ1YWR4MmtYbmZiYUhBRVFBMVp5Yi9YNjMzNHJ5YzFm?=
 =?utf-8?B?Qjd0cnFpN09VdWw4bVpuRVlLRmdYY3ZXSFZ1ZVhKeHZhNFI2VS9jaWk4T1NZ?=
 =?utf-8?B?VnU5U3VTb2hJazZQSU9Wby9YVDhBSTNuTTlqVTFMU3BhSkVpVld6YkF3SjdO?=
 =?utf-8?B?K3puQWExRjJNVW5OVGxLNElWV1FDWmw2MXNPYzFRUWJlSHpLTGxvQ2htTW83?=
 =?utf-8?B?akZGMVBGcFlCRHBMbFUrdFNSYUNqVlZVYytuM1YxNFRUTGRTRjVtZk93cUhp?=
 =?utf-8?B?YmhXVGs2MjQ3L3FzOTJaQ3psbXJXMktxaFZhdVRCWlhpSlFsY2VxS2w4V1oz?=
 =?utf-8?B?RG1ycGlzRCtWSXNrcWJiZE9jbW83SXdUZ2poTy9oSE03b1IweVhDbWNMY3h6?=
 =?utf-8?B?TnJRWG5nVjJYdzZNTXlNVmhsZzBFdmZiLy9UcVJ6bWZ6R29IWjFWTVRQMGVC?=
 =?utf-8?B?OHNTRVZ5Y2xEMDRJWk1LY3B1VFVxUmxzSHY3b3VlRTFNRVFDcVlXTkRzM210?=
 =?utf-8?B?Zlo1WjhteGxwanZPMXFjcWZvdE1tWXI2RjY2WFcwSDljai9VYTVQN1lQcFVo?=
 =?utf-8?B?S3BtYlNOaldua1V5bWc0ZktRSGRDK0l1d1lnenBDS0MyNEpUOW9GMEZqMUF5?=
 =?utf-8?B?d0NDSlZ2THZ2VEdrS3JpRzljVU1TM1hRWjdnZ1ZKQVZCZHg3SjIyRDFjNWs2?=
 =?utf-8?B?Qk9hcE5pZVFCSXlIdVZ4bmxXTFFoWSs0WndWYlliTjVlcndHZjhWWmxINmhs?=
 =?utf-8?B?SnJqZkhiOXV4bFJRVUVuNHcwTVZGazB1RnJ2NElhajVUaTgxZWZnZmZoOW4y?=
 =?utf-8?B?WDRTNlF1YUhIZE9weWpNOHJCWnk5SzNTRHd6bnRoenJnTUgrdUYrY25iNFha?=
 =?utf-8?B?cVRxdzZNNldJYjBxdSt6bWVXYUprUE9xWWg1SFJrKzlmNWVOQnkzNFdsWkdr?=
 =?utf-8?B?QXVJYmE5TjhSNVY1TFhmMkFjYTk2R05mQnFIVFFrODVDZ2JUN3JMTWVMMWVT?=
 =?utf-8?B?b0I2YmNBd2lNV0VibE9qVWVGWTZ6WWxiMlJlNHBBcDc5UzRzbUtza04wbVZv?=
 =?utf-8?B?bXI5QzRQbmQ1eWd4bHpLVmZQRzNDZVhIVmtRNjFzdkt0eXplK3NFdHVCYUJO?=
 =?utf-8?B?OGNXZEVRa1d2UjlPVzRJenNuZHRRNGhqNkZxdEZZRnp0RzhXSExja053MVN6?=
 =?utf-8?B?TEh1VUw1YTZlaTJnaFBlaUsrQUNrUGV4SkxlcDg2WWZFcVBmN3FZNzVOQkxE?=
 =?utf-8?Q?NDACjNXGbKb2GOPob98a5msT7cJu0yW8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFZWMWFucFNFSjdaOEFXb1IwYkd6MHM4d1ZEUlNxRjg5bk0yNFFleEYvY3Vp?=
 =?utf-8?B?QVlINjJTSG5zaU9uNHFoN2kxMGs5dVhxeCtyYWQ4Q29SZko2M2pzM1pBbE9w?=
 =?utf-8?B?N1dSais1VGE5ZDh1SWYrRXQvNldlUDlPeVh6c3dBVmcyTVBEMnFqdzNFSmxT?=
 =?utf-8?B?eWJuNXV2cXVrNVVIMUwwOXZ0M1BBdisxcXNEWDRuOEhwMGF0S3laaXcxcWVO?=
 =?utf-8?B?TGpPWjRobmNTSHhoU2FJTmRpbzY2WUs5SmMzVkxnTk9ZYTF3UUhwZVZEU1cr?=
 =?utf-8?B?eU84eS9keG0wbVpmNWhYS24yTlFzWVJBVloxRldKSlRKRGxJcWtpeEJMNTJD?=
 =?utf-8?B?ZEpka09Xbm54aTlvUXlrUmtPYU55ZGFPaEFmNnNwZ3V3UzZMVkcxbHc1cVB6?=
 =?utf-8?B?QTRkajI0WkhCWlhOTW9tTW83NlFnOXZCT29XT21iaEhBbUdmdklyanNub1Ar?=
 =?utf-8?B?VzNFT1IvRjIxSGwwaFcvaG1JM1RoOWUxU1d3MTFJNERLakdORVYydEUwbVd1?=
 =?utf-8?B?TmU3RENpcnM5T2U2V2pibTRabnd2Mm05b20yVVROaDNtL2NvdGE5YWhqSk9W?=
 =?utf-8?B?ZVB6b1JhT0NXQk5JVktVRUl4Rm51Z3hiVmhxdjhOaVRjVmpFU3dLY1JKVXll?=
 =?utf-8?B?R0pscUdmeTliQUc5cTJqbisrYW0yb1IvUC93UGFQc3BockUvS3QrdUp2cDVZ?=
 =?utf-8?B?UE82MTQ3NVN1UHdNTVFBTmFMUXd3Sk1DdjI0cUdjeHZRMXRyeWt5dm9wL3oy?=
 =?utf-8?B?cDc5cStEdlVicG9SWmh5N0c4NlMwZTdMcTdXRE8vL0NSTEtkNWczUlVVaHpl?=
 =?utf-8?B?Ry9FaU11eVI0TE1rSlhnZUp0TlpKZnNpWUk2cXhzSVREbWplRjE5eVM0YnZB?=
 =?utf-8?B?VE4yc0N2cVZ3bmNTKzgxZ3FhRzNNRlZNTHcxTmlEVDFwYUwwUWhmV1h1Y1pK?=
 =?utf-8?B?VUN2ejg3OUdNaG1zb3NIRDc0TDZLUXZKc25ZT3JvK055a0ZjcWc3a3ZKRHp6?=
 =?utf-8?B?YUd3d3cweDdXZW5JZjR0eGQ5SUV6SHpUcWcrYzVMTGNRanZlVWhMcFkzTWYz?=
 =?utf-8?B?a08wMXBUcWs0QlFpK1VpOTRoRU1qa0tPaC9idmluejlLTjUzejRLY0ZRV2Nx?=
 =?utf-8?B?ZEhvTklLOWZQSzdpd0szTm9qUndHaDU0Y0Y3akpVcXZPRWZ5NzJvRzBnMG1a?=
 =?utf-8?B?L3pUQVp2MHVDMFRBU0wvS3VYbklJWG9HRm50bVVXRTFXY0ZCR00rZTdUYnBh?=
 =?utf-8?B?UGpoVzhvZTRBSG44OEJnNnJmUVdHNDBnTUJBbXBsanQ5ZlBDUFNwTTFUUXdj?=
 =?utf-8?B?dFRGS3hxNXJNaTlybzZoZGdvVGRJMGR0T0h3b0t4LzZYV1R6NmkxY3hKQUlL?=
 =?utf-8?B?NzRQQVlOS3B5MHRNZXdwdyttQUh4VFcwN3k4Tm5hbHlhZHFidVBWWHVCV2lw?=
 =?utf-8?B?d2xISHNHRFZBdG5LWTl6WmVIZHA4Rm9aWGhmMTZHWXVtczV2djhVTllOeTJl?=
 =?utf-8?B?VUhRNVJkTFh2U1NqYnVMeDVQbTBDYkR4a0hWS3ZxdEN5eGw2RXVJZldWNnBM?=
 =?utf-8?B?RThEcUZoc3hTUElFZ3ZlY0svZ2UzbWdCSnpHMlQ4eVhYZDVxNmk3YXJuZ2Mr?=
 =?utf-8?B?ZytyQjJxZDdGdHQwSVZjbHZOa1A5ajcrdGNIcURjK2xpL0poMGJtMWsxd0NZ?=
 =?utf-8?B?VTQwMlZQb29DbnZXZHp2MUZaL2orQUdSdGF4cTlqTU5wMTVETnJQbk50N3Bk?=
 =?utf-8?B?WFJvYUNOOUN3RHFHUlFoRk02L2N1TzEwdmlaanQ3K1VLOVI4SnNKQmlvMDZi?=
 =?utf-8?B?RkJhTkRrSWpVNS8vakJrRXZEMGMxRTdaNWx0aGxrdFNENGR6TFlMMzQzakJR?=
 =?utf-8?B?bFZwYzdObExsbWxCa2huWDFaZ2VxUjh3M1EyZ0ZBTmdxczVPdFpCRGJ1RVUz?=
 =?utf-8?B?aVRDOTN0dnNtRUcwcmg2bExoU2NyZHRjcHU4cGVOTkQ4YnBFdkYvaXAvbSt0?=
 =?utf-8?B?TW5HTThIaURRM1ZQMVFuK1NudFNMR2hJVHU5ZUFrbk8xL251ejlFbFVzSTVt?=
 =?utf-8?B?UEJodkVYMkhtS0htMnUrK3REdGROSmRMNFJueW9DdUNaSkJibkFzQmJrV0V1?=
 =?utf-8?Q?VBRCr3Atdl9Q+m/l74vQTLGP0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e5f60c-da5f-4ed1-819a-08ddd42845b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 13:59:19.1974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ci76l1iaFvWoqGdPkDQEl+5cNzHXzQMI6fJq7sYLhhi/jXS+R1+qR42C9vTaTwEeEA0f2F/8Ubvn6vy/iSu54A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178



On 8/4/2025 11:35 PM, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 

...

> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 308c8f279df8..2ff433cb5cc2 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -314,8 +314,11 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	shared_sint.vector = vmbus_interrupt;
>  	shared_sint.masked = false;
>  	shared_sint.auto_eoi = hv_recommend_using_aeoi();
> +

Nit: extra newline.

>  	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
>  
> +	hv_enable_coco_interrupt(cpu, vmbus_interrupt, true);
> +
>  	/* Enable the global synic bit */
>  	sctrl.as_uint64 = hv_get_msr(HV_MSR_SCONTROL);
>  	sctrl.enable = 1;
> @@ -342,7 +345,6 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	union hv_synic_scontrol sctrl;
>  
>  	shared_sint.as_uint64 = hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT);
> -

Nit: extra newline.


>  	shared_sint.masked = 1;
>  
>  	/* Need to correctly cleanup in the case of SMP!!! */
> @@ -350,6 +352,9 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
>  
>  	simp.as_uint64 = hv_get_msr(HV_MSR_SIMP);
> +
> +	hv_enable_coco_interrupt(cpu, vmbus_interrupt, false);
> +

Nit: Maybe this should be above "simp.as_uint64 = hv_get_msr(HV_MSR_SIMP)" ?

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>


- Neeraj



