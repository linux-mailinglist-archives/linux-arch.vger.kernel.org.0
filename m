Return-Path: <linux-arch+bounces-5968-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0205947AE1
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 14:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD6D1C20C79
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9931547E0;
	Mon,  5 Aug 2024 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LJ9FDxQK"
X-Original-To: linux-arch@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2046.outbound.protection.outlook.com [40.107.255.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5207C13634B;
	Mon,  5 Aug 2024 12:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722859849; cv=fail; b=qBlM+i/rmoYdxMKNEJvjlikNmQQ5rVgOJUKyGJ6dPSV7Af68DGuW9Vkod/eZU1eijHphoQywJfQtJt0YdVOjsvozNaWpW4t/EaAdEEUEpmOXlWwSE1k5xpZYxVjLArch1FRC0n83u3epftA//JQlN2s3cxJtqIbZCTp8jTCSQx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722859849; c=relaxed/simple;
	bh=35lVmdwIaWSJwWHJ5kbpqTohvG4AmEjJUhEnDn4Eynw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nlWqOO6jXdQr0jDP40jreDlPQh0AvV2suHkuM/Cq6+DlqwazqVdJ3hA2eQRWfuF6Cv/3qUrIxz6wzCAcTvLuWamS2kfTrW2VhHLzRr0RlvJQx8GPAM4TYUUDrMpcVopBGK02qiwo9yqAZUlfQFNAjgP9lXRmzGc7mokdMRWKzQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LJ9FDxQK; arc=fail smtp.client-ip=40.107.255.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+BYGWd1m9vZPxRH/W88DjuxPuI0K+N2H6qgb0/12L4quDKo47VH9unj4HxSKBp8UNPzxZCT2snQYFm4Ql62d2jBjzAIo+05XkkjLuuGmgi5PiTqTcdJ6U3spINi/cNXBWKBv5Fj7ebfnDz8M68tLaKmko75rdwvmAyl1NdG2pbIfcGQv6SQu/G6pgeTFwlAExVBySUvOQU/+zI1YOEK4bG1OXsAYhyIFfn2WVPlbSE/uroB9NFWPgDq+KJQ6h7tGawpXs0+BCVHxVyEo8vHiuhVV0u0AwD8ZSrclp0oN2+NbaXCr0dbVqp5cZgOZqKkmjv9qkgDoRJMhtS7zaCeaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laKU7pAO7IdwB8vxyt/JUBP9uOZ2aLXA7PiwPLagiy0=;
 b=kUQV2mADd/zL1PqCD+OkWOg5Fbu8OpIK2/5KTx2cm2b6tLmOt+RAyuoKyzXLxBOvzG7PIJw75DsqtqFoVYE7p55HWDSxlsZSNGSffYjcRaqficL/l63e3TMdNkUmKfDsEiVJRd1tjpNk4KtKt+m5kx18+naYC3zunbm7h30F6bGFJP50pikazL1PWxpTj9v6LSpzybs+E5/XiGm8QHlR92kZThZGgdCcqgCI8hvOErJJ1kqzXRGsRiARa/HLifHzOSnqVqVu8Pve+OxCidIWvzLE/DgZx9xTzCUTFlnh9E4HP4Czx3YOvTSkzVUzfKhjMsh4w9GbBADwFc/s+YROvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laKU7pAO7IdwB8vxyt/JUBP9uOZ2aLXA7PiwPLagiy0=;
 b=LJ9FDxQKA5Ob4JSyvPaXGH4yuKRcAhF37EPgJi+Mx42+vDHfSCy1GVGx6E/oKuiaqlwCeRaWc5MywDAzdQaCbGx3w5bt1fL4Khf24U4x9FFU8nTOx2tr8BsY0BTt6VPlUaacvY5lJiJrHYpPjrnpl+4/Q362tubLNvISzkBLZ3IDNpiH/u/8pGXAc8XQh6OV7OQUsWutQ5DDHscGAO75+anfg/fIHVmCKB0YGPVtH76cjCJFr2xLg44JzxkyyxvEuvtWmIIYTlHdxuOIoVlc5YVrYXOCGVAJHo6I/ZR8xvm/NU9lY/PHOnBpTQrP8NNfP3eauojrt+F/+y97GUNvaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR0601MB5680.apcprd06.prod.outlook.com (2603:1096:820:b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 12:10:44 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:10:38 +0000
Message-ID: <75ba47d3-e9e6-47e3-b4e4-8b8ec4104eb5@vivo.com>
Date: Mon, 5 Aug 2024 20:10:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mm: s390: fix compilation warning
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-arch@vger.kernel.org, cgroups@vger.kernel.org,
 Barry Song <21cnbao@gmail.com>, kernel test robot <lkp@intel.com>
Cc: opensource.kernel@vivo.com
References: <20240731133318.527-1-justinjiang@vivo.com>
 <20240731133318.527-4-justinjiang@vivo.com>
 <cf4dbd95-5589-430a-823f-6d76e30d8374@redhat.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <cf4dbd95-5589-430a-823f-6d76e30d8374@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR0601MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: 064abd1d-fbdf-42a6-6408-08dcb5479e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjV3MG41ek1kcFo0SDYvMVFPTStJK1BSeG1aUVV4NkRCTFJTN0Nua3VTUlk0?=
 =?utf-8?B?czAyTGRmZXdRd2xYYis3SlQzM3IwMUpLaEdhM2t4bzlwbW1IQjRFQUhybnFp?=
 =?utf-8?B?T0szYWRnem00cmc2UFh4cXpIRFlsTXVjTzhQaGFHSXY1TWdHTk1ubmo0d090?=
 =?utf-8?B?RWdKRGN3MGRmWDhlWEZmUDlBbmJodUQzZlQzUVBsNzhzMUl6YlRCOUxBNmZr?=
 =?utf-8?B?dXBTODdmTjlrcDFwT0lhOC96NWVSYkllRkxJazdvMll6QTZIbWljdUZQYVp3?=
 =?utf-8?B?RzhubGlNeFdOemFWamtKNC9YNHpoQW1kU3NZcFRpcWN6SUk5eVg2cmx0N0Z6?=
 =?utf-8?B?OVoyT2t3UVZGYkN2ei9xZkdsTUw0TFJXajJnZ1orYUFPRFdGZWNIZGUwNVIr?=
 =?utf-8?B?VDRrRjlnQWRzcW5OR0hqSEhtemRvRXY5YmtqYmRvcEcrbXV6THo2OEo4TlU1?=
 =?utf-8?B?OEJYd2hhMlpCRExlKzJxNGd2OGFsemVGaHhVakpvLzJCM2c4THB4KzBvRjhY?=
 =?utf-8?B?UWdKaE9HempSekM5TnhJUngraEpIM0pnaExleDZmeTlRUkEyWVUzdUt5alRT?=
 =?utf-8?B?VHorbGJob1Z6VWpiZVFTd3J3YS9UQ09iU3RoZlFWSXdobUFNS3RyZVlqZjFY?=
 =?utf-8?B?SW9yRGt6Qi9hYkdQOTBvZ2JIWlhCSDBJU3BmTEJWS0J6RVE4RTZpYlpHOEtw?=
 =?utf-8?B?LzVHeXdPUGk0M0E3NkY1aXMyV2o1b2xWcGZxYzd1NDdtaGZhblA0UGs4RXNm?=
 =?utf-8?B?SEhQVUpEZ2NsQ1JJZUxBdkh0aFQvSzFuQVYrTitKTFVFcGJVVmkrQWFqazE0?=
 =?utf-8?B?R3N4S3ZDaUNlQXdwRSszQ2JpOEtyQ0lNL2RXNDdjR1h5cm5OMHAyblhFUzhx?=
 =?utf-8?B?RGNaamdUZ3VvQ3VKdjUyalZpMnJ0K1ZWM0c2ZmY1eTBWd0NKWHMxOTNoRU84?=
 =?utf-8?B?Vmw4dDRWZFk4a3NwVEJBcloxZ0JiaUQyUkhCV0Z3VXUzSk0yaXRuUXkyZSsw?=
 =?utf-8?B?SmtSYWlSdEVYdG9xOEc5VG5jajc1UmFIYXd3dWpvU1hPY0p6UlE3aEc4QjVK?=
 =?utf-8?B?U2NSQTBacFZWM3FaT2NpRzU4K2tycTdXZ2hleHJraDdrdXpyZlNyMzA3Nlh0?=
 =?utf-8?B?bXRkaFVvVWs4NlR5Rnpuc3dGdFMwejZSNDFuTlpBZGpZNXpMVkpKcForaU5M?=
 =?utf-8?B?RkZIdUFRZG53RWZFOXhyTWxNTnpuTHh3TWZLV2R6R05XSStTZmlDL1ZzSG5X?=
 =?utf-8?B?MmVRb05aUm5HYmVWajdTSDFreWhkNmowQXdDbUdCTDdRdnFaVFltY2tNQ05y?=
 =?utf-8?B?eUprRTV2U1BiZGFZd0lzMnZ4cnYwSFlTWUlRSmFIL29zVVhUTHpSL0ljR0o1?=
 =?utf-8?B?aUFua3V0WUdiTHplaGFjUy9HYk53eVVHQVRlWUZSbU95MThTUVNYbnc2VWs5?=
 =?utf-8?B?a05oNEYzaVYyaWF3Q2JQQ3FpVXJaMFZFZTlBdEZXelF2M094RmJnRmdSb1Rs?=
 =?utf-8?B?a0FETW1MQkR1bnRVRm9jYng1OHlsTnNPdWRPMEp4Nm56VXF2S0liY29FbmZt?=
 =?utf-8?B?RWpWL3JyRHZrbStVNDczWW1tdXkzSUZRWU0xZGFCQ2NnRk1JYWZxUG9ZQ013?=
 =?utf-8?B?M054M0Fkd2tacVU1dlFTYnJ2Zlk0ZGNIdVZ5aEtSVTVOZFkrN3ZkOW8rdVVN?=
 =?utf-8?B?blNoZHU4MzRqWmpmLzRUR1ZiajNzdi95VTN3VFdCMnNCeUlWY1d0bGJ2TzZ6?=
 =?utf-8?B?YitTc0JKMm1QTjhxczZDckN4ZmlhVWN5a0wwRERkVmNOVUlidDRDK1hEcWFZ?=
 =?utf-8?B?OHZhV2Y0TWhKUUlZQkV5RTBDd1BLdzV4TncyTEZFWGdjdkFaeXJWSU5ORjBp?=
 =?utf-8?B?dFFKWTFqeTJKRk5Oc0JDWVFZM21PNnNlQVgyMVp0aUdMU0RrR0p4Q0MwWGJX?=
 =?utf-8?Q?BWFmGpR0kqM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnhGVzJhaGViS1RBeGVGSzBKbnQxTithZDYvSG5iS1U1RFRIVCsvNk9kT1R5?=
 =?utf-8?B?WFpkd0dwd0FrZzNZWUp5eHlhdklhc1dXYnlXeVRrcXNhRjBQSXFyUG04ek5P?=
 =?utf-8?B?Zy9qVkcwVnpidWVZSWhEU0FmZWJPanVESDNhK2RLdDBaRVRUM00zYVQ0ZGY5?=
 =?utf-8?B?UThYc0dKOEhGNU5zYmVjU2t3VWtrd3V3SHF1elFlcGhKMEVyUWJ4VVhwM1Nm?=
 =?utf-8?B?N1MvV0NNbklDeHRTVG1ybENsZDVmVm5WazM0ckZHZUZmQVAydFRLWWpkdHZ1?=
 =?utf-8?B?eHdYRVlhbEp2MXVpbUJUU3RkVHNLSHNKTHo3TDR0T3NPMGNXZ3M0OHJ3Y0w1?=
 =?utf-8?B?MVBLeUl5NTZGUnRSQlAwSjRQcHJFVkhpU2VkWTA1dXJtd2E0bk15aU5aNjFL?=
 =?utf-8?B?YTJQV05Cc1RBSnNnZnVYeTYwc0ZhZlRJRlVMakY4OFUxckpsVjUxVUdRcFBo?=
 =?utf-8?B?cm9Sc3VtUzFmVVA3bHYzeFZWMmhlaGFxN3B5Mkw2ZitKZnVubEpQV1VxTk10?=
 =?utf-8?B?dER6aHlnMmVnNG4xYko2bnM0czhJR1pVNWMyQjN4eVdiS01GUzFUYWdLaUdm?=
 =?utf-8?B?ampZekxoZ3BGQURHSTlCOEsxbjRmeW0xOHh4bXAvMkxQbVlZd0ZoQ01NamxH?=
 =?utf-8?B?cHVFNnc4WGU4Z0crNGxYZzJ6RndBWXN6M3ZaRWR3Y2E3VlR2Yldmam4xbmxP?=
 =?utf-8?B?dGZqVm9XWU5tNlZvK2N3ckRQb0FwQmc1bm92VlRIeXVtOTMvRGlKTitsbGh5?=
 =?utf-8?B?WmlURzFBZldPYmZMOUZuZHZqOXp2clJ0UXZiRy9OWWQ1NWEwWFF3b2lxRi9i?=
 =?utf-8?B?dzlQOXA5Y2FVMmJzL2pDVHVYS21BZjFZUVQvdzBEck1DR0JLZ2djSEFJbkda?=
 =?utf-8?B?aDNiZjBGY0I4Uml5MlFoOG95QUlodG1JVHRaS0tSUXBISllvT2ZKWmZITkFD?=
 =?utf-8?B?VkF0a0dmbXlXRElGSCt3ZHpDSVNjVzYxb1pHaVh2OU9OT0J1NUJXK1VEOTZs?=
 =?utf-8?B?a1AzTDJRckdOWVhpMXNUZlNVa2I2MmFUL2dPWVZHSngwSmNSTmdsRlUzTHRX?=
 =?utf-8?B?Sk5lVGpGTDVDZGUvUHRSMktUaHQ3Z0pwMlZpWUR5M01nS1loVFdoT3FUTDJv?=
 =?utf-8?B?dzdwMlY5c1lGK2Y5K2RRRElPTVpZTGpyQ1N0dzMrQWl2S1JGeEZlTVcrNGt5?=
 =?utf-8?B?U2JISEZIQVlaNGFwSUFDeDhjb0VmQ1Q0Z0JvODFKSlRONkVqb0c1azkwajRn?=
 =?utf-8?B?a3JYd3d0Q0VGSjRVMkRVRTFyWWZ3cm5OZ0RoSVV4bnVZVmR6VFZTZVIrRHRl?=
 =?utf-8?B?bUNDZkV2R2diZzg2QU1MTWNYZ3hLbE93VzYzdkVUV1h1ZS9qQ0lYNnJ6NjNM?=
 =?utf-8?B?QVl3QTNxQlNMZzVVWWgrSnhLYlR2WFNkNjdGeGlCT2xOY1BNaXhJQzYxUFVp?=
 =?utf-8?B?V2ZqNjY0RXJ2WHBiOFRzTnhlS0lUUFhNcUhkaXFEeFoyVUdrRmQxVnhaNmdQ?=
 =?utf-8?B?M29SQWJSSm42Z1hLamZOcXdDU2JqeHhaSko4V3NmV01nNVJBZHZYS3dYcDNL?=
 =?utf-8?B?UWF0Mk00UmxhQi9GYmVqTGgrTjQ5SDAzT1RWdXU3WEFESExGRTdwbmV0R2ph?=
 =?utf-8?B?MWV1MEIyYWFnQ05pZ1JHdXdJR242NWJ4Y2JMalRvOUVHNTN0djhvSlkydUZS?=
 =?utf-8?B?YjF1VXROYXM1ZldvVDd1TnRuTlZBUjdNVmF6aUdRcCs0bkFkUzdQdTlGc3dC?=
 =?utf-8?B?QXcrOU0zTjhucnlLTVpOSkNvdHdvVGFvSTVLbyszSVlnaXZZemczaENOQzZw?=
 =?utf-8?B?YzJqRUV6cEEvZk9FZHhsYWM1SmFMNVRoY3ZSYTd4S2xQQVpob3BoWEUxKzFS?=
 =?utf-8?B?V2VNTnVYNXQ5NWRZdmtDZTVlRlNCRTQ0YnRIbWpBNElxaTRpcDZjWWVndGhM?=
 =?utf-8?B?WmE2NzFSV2dYa1d5eWZVQlpPTCs0TlhzaU5PakNjanVaRVFuRklxOUYrZUw2?=
 =?utf-8?B?T1pzK2drYnJUcVJnMkFKdkN6VU9qZHZLZEVzeFgyVHJObi9HZURNSmFFYURL?=
 =?utf-8?B?b09uYTlmWFZmeGExUGlSbzFjcDcrR1UzbERrOEx4cXJ2NGJIR2RZeW15MGFl?=
 =?utf-8?Q?QZ2bakxJlltdWeMAuId8YSW+W?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064abd1d-fbdf-42a6-6408-08dcb5479e31
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:10:38.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1Gm4quEHIIa0yI3qdeh0CmAOgCBA5wrt68CvKrv8JyFdXWsqvZMHzHFSeU3sUlP4HpiwRgwStCnNYAOl7SwgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5680



在 2024/8/5 20:04, David Hildenbrand 写道:
> On 31.07.24 15:33, Zhiguo Jiang wrote:
>> Define static inline bool __tlb_remove_page_size() to fix arch s390
>> config compilation Warning.
>
> This should be squashed into patch #2, no?
Ok, thank you for your nice guidance, I will squash it into patch #2 in 
next version.

Thanks
Zhiguo


