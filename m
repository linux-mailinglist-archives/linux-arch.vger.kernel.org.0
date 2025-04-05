Return-Path: <linux-arch+bounces-11291-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E7EA7CA72
	for <lists+linux-arch@lfdr.de>; Sat,  5 Apr 2025 19:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA752176927
	for <lists+linux-arch@lfdr.de>; Sat,  5 Apr 2025 17:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824CA1547FF;
	Sat,  5 Apr 2025 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="suEnifYS"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDA6366
	for <linux-arch@vger.kernel.org>; Sat,  5 Apr 2025 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743872850; cv=fail; b=CnbKcU6tjfEy0q13+Ljh3Rl1PJfxyH4KnEEIdx56Prx3Q15Oy4+1O1hN9RIUATor62b9orJADFiBXGq8AKEg0QYN55n82fviZxsGJprj81YxIxIjrNCRAARgBYDl7+kQp95fsv5LAjgfYYfM4F0NcnvRzD8dpD3KPjJEEI9VYGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743872850; c=relaxed/simple;
	bh=s9hpDPE1XnlsChmYiZ6tcG1CJim6hhxZ7Km0ETE1NQg=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=UFfEQwFVp/P5WaBuMqkP0kFbHXmxySIf63qHDQzq/1wRRBMtwRyJ36XDqUKTr5zbd5yALYyL66vPEpXw9evHX+00jAYw0YQkj+JFCx59T/Mxe+hSfoRWQppn5VxNP5Duw4IvEA8tSW1S5H7d3dViuaXVhb5A+yM3EEXuLHgjxkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=suEnifYS; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYAoLLbvp7ZuHCAWa24AjBlXxIVVRchMrPDRrgi/UFIgCJ1VAEnLRQPtufsyO2P1pY+MBergqPpaZl1g9V/ZKwAwXYUKTT51MlTvjKTbZgp8KBE/tvLBTPv1ca2SrNBaOHdL/HxXIWo5lhz+61uSMdrnRsuuk0lE9KvgGfNIN5LYBH2mciaoS7Lsgw81Q2GpC3TrFLc6B94pDMupToS7v2kLclQdmMTHfEKS8P5lvXgRZ3Zhgwqecm7ujySmkVAZqFcBA9zdyoCK2YWDXRjhwbd10AWHohYZfwPNoTDEYukiQhEbrVHbivvhEtVmrHLiRn7tmLGjdx4dftREoRJsCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzsTDa+OGBdaHtax3JYSwkYXGtf3EBLebkxfbDubjng=;
 b=HDpJQV3JuJNHTBUL4ML/RYT5P58Y04pTTk6DKRUOypB7IMGxV78rlYNcpgZfYIzRsIb7vrv2SdzW8o+nAKRq/Hn9KH4wei73EqGwVlaOGae2GxEKYreyWLT8NtpefH+7qFisanBwL3fE8YjwrvMmmUoI/pMLN8ABUUibCm33Glq1IWZP4sHqaaJf1jb6loRj5LFSBe7iUmPBhT5aZcwpVQmj+gmDxEOTpQnwp4RsYrw5Uc4ynge72WiWUpdGZ7jiqmqFMQ0Yd9dVcUqoMUS8elnG2T7+nTh4G1v/BRwu1ADyOB1jVIUae9eB1k9u6+rwiJtugBeqiDYGX8zjYsd3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzsTDa+OGBdaHtax3JYSwkYXGtf3EBLebkxfbDubjng=;
 b=suEnifYSPdGkQq9yu1C9+IrYtVwBOmVUF+gtGvLJHX7Iw1N55A3dMpexC0V9pHZcZLkDopAp+/p3nFr1J2Y+jjtfzbu5fZWH+vENSwHZK6TsYDndnDINj7SUX71GCINcduVxiGb54D9bZBo9SY+KzD4wjXpWVlf86RoS3eDfuQ4IQJS/KUjXqPjqTbfcajYEdWiNHrgE4CW2nc+ByeVE+E5TNrsz1hsB8oHuwHa4dsh//67EpdHZH0JHF0xhLWXWJA7rUeiJ7xcgVbl/kiAJES+qIA3JK1f2kioLrMTtD1YbAocJ/bDiVd9yItpqQEe05RFHAy+FHj5jgSqebBVEhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Sat, 5 Apr 2025 17:07:24 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8583.041; Sat, 5 Apr 2025
 17:07:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Apr 2025 13:07:22 -0400
Message-Id: <D8YVBW7T6TIE.1R6MI5ZELS113@nvidia.com>
Subject: Re: [PATCH v2 10/11] mm: Add folio_mk_pmd()
Cc: <linux-mm@kvack.org>, <linux-arch@vger.kernel.org>,
 <owner-linux-mm@kvack.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Andrew Morton"
 <akpm@linux-foundation.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.20.0
References: <20250402181709.2386022-1-willy@infradead.org>
 <20250402181709.2386022-11-willy@infradead.org>
In-Reply-To: <20250402181709.2386022-11-willy@infradead.org>
X-ClientProxiedBy: BN9PR03CA0767.namprd03.prod.outlook.com
 (2603:10b6:408:13a::22) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN2PR12MB4191:EE_
X-MS-Office365-Filtering-Correlation-Id: 04bb6b88-fb45-49ec-e782-08dd746455a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkdaOHVUeUg1akFKdjcrSUloR1RBUzlLS0FuRWdwaVBySzBVRWdqbVh6MEdN?=
 =?utf-8?B?a3d4VGZNYXhLa1pOS2p2SWhiZ3VZaG83U2hwVVlzWWNZRjFJNS9TdnIweGwy?=
 =?utf-8?B?LzhhL2p1aVBxcGgyeEJsOUc4cWJna1dRYjVpcGJFSXVoeWhWaFNXK3lsRGVC?=
 =?utf-8?B?a0g3VDJlaTJlcXJpa3ppb1V2TVZ4M3hkVTB2S0Z1MC9CRjJpcW1tbVhWK1Rh?=
 =?utf-8?B?N1MxcFVwSUZ4R3I2MDBIbUdyOGc3R2RtaVNNYjB1MEhsSEg5Z3ZxLzYzbmZJ?=
 =?utf-8?B?NHZNbTQveStBdmhBUHA5OFg4TnJJQXdXajZPTmwvRDN0c3ZnaXhlRXVIbExt?=
 =?utf-8?B?R25RZWhDVnpaMU0rYUhpb2VONElPL2NyN0JKWGJRdmpVeDdmTFZXWFB2eTVq?=
 =?utf-8?B?L2k0M2ZGQVZoSy8zYmZqdkRFWjhvTkg1U0VpZ2FNREpEZnNFWDlHa1NmN1Ja?=
 =?utf-8?B?bkhtb05sSUdjeTZSeE55T1FXTmcxeEI2NTdZcmd1MVk3VUJMaTV5eEFhR2s0?=
 =?utf-8?B?bXQ1L1cvUEZJTVJmZ09QNnpTZDF2S1lhVS9BRlBqa0hTTnpaNHFQdmxTOTlU?=
 =?utf-8?B?NzNybkQvNzZNeDZ1RUNBZVZObENOSlhnbGpTcXhMRGNyTENYeTYyTXFjaGow?=
 =?utf-8?B?dFBJRkhhaUxOQ1lFM0dZZS85azZscEttWStXdFFLblZ3NHl3eTJBNmdQUVNK?=
 =?utf-8?B?QWd3Uyt6N2l0OWdOcnY0NFlCV2F4RzRvUFJ2dE4wTWw3eVFrVDJuanM4SnB5?=
 =?utf-8?B?Sm13UC9yQ29UelNycHVSeWRQREJ1MFdZa0tTM2U1MC9jU1p3L0hkelgzbXJR?=
 =?utf-8?B?K05uc0RiTUlEQU1aRDZpOWR2cEZIN2tiNFF5eWppRHJ0enlieTN6UjB2ZUZa?=
 =?utf-8?B?cGp0dUM3RjFxNnFiV0xkY2F5QnJLWGxveUJSNmJPYk45U056K2NQVXo1UVlv?=
 =?utf-8?B?VEZWTDY3Tkw1alVWVkZWMVRrZmt5RlJlRGVvaWhIOGorWkRJdFhSbWpEb2dW?=
 =?utf-8?B?RTRMTFkxdUEvaHJPNWs1Y3RvMW5rTDZtTFJiT1draE80TlNWczdiY1E5T3NM?=
 =?utf-8?B?ZjgrZlN5NzN0WE1ZbjBJcjUrdGM5eWFxMnA2K3djUjhIOURYNUFpK3QwSGZ4?=
 =?utf-8?B?LzZTZ1lWaFdKMklESi83Mk9tWmRoNERwZ29CaVVGOVowNENyZFkxa2dPNG91?=
 =?utf-8?B?ZjhiU1p6V1QxMzY4bHovdDlKNGpVU1FkMXpieXZRR3dVOThVNlRzbXNRaFZn?=
 =?utf-8?B?eXpOK1pSc20raDlSaXJtejdRdmxseGpkZEJZWE5MeGhFNTRwV1ZUak8zRmNQ?=
 =?utf-8?B?Q2lSZURxNmxRMXBSem1CdStLNlg2QWlHcU8ybm9UUzB0ejRSZmtwbzZUR1Bv?=
 =?utf-8?B?ekxaUkQvbUpOQjdTcmoyRjNNUUdBM05ZNjFXRG1wam80ekJLMktNZXZRU2NM?=
 =?utf-8?B?Q1VpQlJwcUR4S0hCT1FEaXN0bWp0Y1NjT2w0eEgwK09CdG44NTgrVlBjSmc0?=
 =?utf-8?B?MWJ6L3pwRlBQekdKeDJCS094TUtkRVo3eE5lR1BuYm16cC9ZYTliNUNuTXJt?=
 =?utf-8?B?RHV6VVR4MXhYcGpMS0VSc1JRQkdwc1JBc0pVT3ZsdGwvS210T3AyV3ErRGcy?=
 =?utf-8?B?R0s0NEdiaS9sYU9WN0pmUHVzaEwyTm9kRGI3cFgvQ1VnRTMrNkc0TTh0UDJC?=
 =?utf-8?B?dllBdnJhdmIzTzMxb2JBYkE0RjF0THBYK2ZCRlBqb0R0K0N0NS9zaEo0akRG?=
 =?utf-8?B?STFFcHI1bEhqK3JId1NyaVpXZUdRZHRVZ2h3Ymk4VENDV05kUXliSytKTFhC?=
 =?utf-8?B?dVR1cXdQYWU4enpuMENMc09FTi9YbUNzZDNyRXRVdEcxbXNxcWtCakFReE5j?=
 =?utf-8?Q?SA7ngCIBExo+V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFZZaG04b2dBUUVSZ0Q2Wlo0MTlOcHEyVXplY3hmakN2OXlTYzdPTW84N2Fr?=
 =?utf-8?B?bmNBb0NHcUtGSmpXZHpIY3dYL0Rzay8yRzBSSHpEM2d4b3NZYUgwZ0xTZFlN?=
 =?utf-8?B?OTNPdUNpcnAyMFovWTgwNXZLREJ3R3YyUnJTY0RnaVlYRS9JRmRTZHp1dHBj?=
 =?utf-8?B?ejdrZGdTVlhrTEFXU1YwSzBOSXNGTGFQaDArdUMrMVJNQWNFVmlKb0RyWkRx?=
 =?utf-8?B?ZVpRd1Q4Tm9oZFV0THB5cXpCVzF5ai9qYTdIVmx2NlFmNXZKS0wwZ1QwWVNx?=
 =?utf-8?B?TUlzaGZGeG40aHIxYkMwZXViS054SjQrVjhlRUE2Rm40TzJXWXU5SWd0ZG1Z?=
 =?utf-8?B?NzMyMTFnWEZHNTBHbGV6UkUyS0hzYmdGRlZMdHN1Vit4OEF2NGlRbVY4eVRq?=
 =?utf-8?B?cGpMbUFITElYZEF2L2h3dTNQYWl3WkJmbXdZNDQ2WVJ5d2txMG5MSjdnRnBX?=
 =?utf-8?B?MEh5ejc1ck1UQmt3SWdmTE4xV3o3cDNzMzdxek1qOHA3MGxaYVJIUEY5c0hF?=
 =?utf-8?B?U25rKytkRUNPK0ZkWjhQQVRCZXV1bDAzSUtSd25VMEVuS3dVRjdncWc5ZUFh?=
 =?utf-8?B?aGc2UnRCYTdXZWpyTnhmRHNVWlVTRy9kQnRYeHE0WTZOVkdaZjQ1WFpvc3Fh?=
 =?utf-8?B?SGhrSEpSS2V5K2t6aElPZy9BNGVIRVJrWW83NjlGRnFqRW5tS0FDMFRIZFBT?=
 =?utf-8?B?bnlyWTczUk9VczdrMG5xVkFCQ09TT2xUY3lsenhnd2dqWUJGNm9NT3MwQXFx?=
 =?utf-8?B?MWQ0NSt1SEJSWmMzNG1uOVd1NGtvVXkrTHVoMkpyQkJoc0MvUmMvL0E4VkZL?=
 =?utf-8?B?YjRkclptNXo1UHh6TVR5RDVwUVNSN1ZjWnN3aEF0VzUxV2V4d1pNb3drMHAy?=
 =?utf-8?B?OVBScjJaZSsyenllU3VvWW02eTJ2Tjc0N1ZmR1dWbkN5b3kyV1h1ODVIQzhH?=
 =?utf-8?B?WXgzUnM5NXJobVhFTk93WlV1K0VFQytFTzIxeVRRdGNKODFXYXpCWnNNWEdn?=
 =?utf-8?B?ZE1TVndpZmV5ZlZUY3J4QWdheSsrcCsxa2dtdTRuK0xBVUtJUzMxUlBqcDh4?=
 =?utf-8?B?eUdYMTJkT1JWNjhOb0gyMWszeUtwd1J5ckpQWUpNdkFCdkMvQ0xmUXBsbGVh?=
 =?utf-8?B?ZHRCK28wMVptU2ljb1k2Q3FFWWZERkdib3cyRWtpWklTUHBnN2N6Vy9UZWl5?=
 =?utf-8?B?ODlZQ2l4eE5Ka3ZCUDM1b2I3OFlQNEFNcExZWGNLS3h0NWFlZUs2ajkyODYw?=
 =?utf-8?B?c1VtZ3Q0bFBpV2VydUpJU0NxUmQwZmt2eTlVbGU1dzJNQ2szRStkblRuYWRo?=
 =?utf-8?B?QjIvUlJ4aHVLMHdOZnhpNWEvYjZNVEdFWlgzTjM1d0NxYUlhaEUzeHBXSFFR?=
 =?utf-8?B?SXMzRkxvSXQvU3FUWlErRkRWZmFyQXd3MFlYUFkvQVJJWldYZFY1dlU3R0dp?=
 =?utf-8?B?bG91NklNZTRWaS82R2tyRlJBcndtZDZraVR1RnFOK1hQbDdHNUovdE9SeVZT?=
 =?utf-8?B?VEl4LzMvQ0pNZTUzVHNzSUhiU1N6NEJCcWEzSmF4UkxoQ2VtVUN2M2hHYjZQ?=
 =?utf-8?B?eEdrVnZ5dERidW9YdUVZWS95WkJ3MVpiR29ueVpuRVNVVDVzZEpBbTdoVTZ3?=
 =?utf-8?B?WmxlZFdzSVJSV1NVSkRxalpvc0ljNUFzSzJGZ2FKa2RKTWZMOG5RTGt6b05J?=
 =?utf-8?B?Nm1KTVZjcGpmN2kyZWVKbU8rTlFuWWt6OHF4Wk1KOWRPUjRSdDY4V1UzWEZR?=
 =?utf-8?B?ZE9yb1BMVHZYc1lpVE5VU0dOZGY3djBEZnhIVzhHSHgwZ2oxOFhTS0hOU1RF?=
 =?utf-8?B?ZzZnU000ODdzOFZrTmkyd0JSNmgyTEVsM2xtck9JMlJOblZLQUdua2NCeVFt?=
 =?utf-8?B?VWhCR1RWek5jV0xuc2duSGhzTFRzVFpwMStmQ095eG5TenVQK21QWFRPMHdU?=
 =?utf-8?B?Q3J6L1BNN2ZHbytLd0NYVDVvWk9aQUgzSTZrYWhrdDN0NDVxUHBONnFMNmw2?=
 =?utf-8?B?Kzl5VDE0eVBMR3RiRVIrckNMQmFNaFQ4RjYwTksvcnlXUXBuU2RXN24zQll0?=
 =?utf-8?B?U3NDUGd3M01ya1NjMWk4MFBlUjkyZU02ZjJxSUV0ZFZjSmphejdKZXNreE1M?=
 =?utf-8?Q?TfClX9ei+eMbIbNIYNzbY/eIM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bb6b88-fb45-49ec-e782-08dd746455a4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2025 17:07:23.9853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tNAUV9Pwt9erqm7XaNAq3NEg0tIUKtEoCNm9SoBrxCjXo2sMtLv6Wwnj1Ep853f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191

On Wed Apr 2, 2025 at 2:17 PM EDT, Matthew Wilcox (Oracle) wrote:
> Removes five conversions from folio to page.  Also removes both callers
> of mk_pmd() that aren't part of mk_huge_pmd(), getting us a step closer t=
o
> removing the confusion between mk_pmd(), mk_huge_pmd() and pmd_mkhuge().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/dax.c           |  3 +--
>  include/linux/mm.h | 17 +++++++++++++++++
>  mm/huge_memory.c   | 11 +++++------
>  mm/khugepaged.c    |  2 +-
>  mm/memory.c        |  2 +-
>  5 files changed, 25 insertions(+), 10 deletions(-)
>

The changes look good to me. Reviewed-by: Zi Yan <ziy@nvidia.com>



--=20
Best Regards,
Yan, Zi


