Return-Path: <linux-arch+bounces-5830-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0C59444E1
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 08:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346342811F0
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 06:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E728158556;
	Thu,  1 Aug 2024 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gStPPzx2"
X-Original-To: linux-arch@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2051.outbound.protection.outlook.com [40.107.215.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017A015748F;
	Thu,  1 Aug 2024 06:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495287; cv=fail; b=Q8IsjtNxhdOMkcJHoLJRKCptW5xVc4KsrBbNKFARm+VPJECJwN7+ByQmxTFb4wE1jMjj496eK6I5xL65H9f7AWBqXDmO6TdluJHjY5uuaSs6vn8j0LZ0iFau5Nhe0Vz3A3GGMX/malc8jm4tWo/EVzIYwqa45rV/WD4uo5Ita3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495287; c=relaxed/simple;
	bh=E2hHsjDaFFFwGnVv/bPaXVomk7xeiDb31aF92OYuoXY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XVHAp8DUWyIAaXSAygVdRvlGJYtXQJYs36m3e8+BnmRRwX//XYH88nleJDtSxoPzofzVoov5TQj0BMMDAukXjo6JZHGuZEo8imMMm3kiXMn6CTBpS7vyw4ColZ0q63722+58szLTl88nFnsXAoDvRXaaxWxwuFQK+KSHdTpxHKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gStPPzx2; arc=fail smtp.client-ip=40.107.215.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5K9oOe54qf7ZN7dKwQkGw8nmZuXfaprg07/x87B4ZjbOjcuI1GgMvS2+okiUoxDITedcgsiXrZmBWOI1ZtgKHYHpS3I1HTWVDb1PNCCRCTg+IKKVKxQuL4HP7djqTm9ZmcoakZX4lIcZW/m6aKEeSzX3joNmWLdGEE3l2oKyDDCfT+TaC0CvjvMKaZYZ3jDdyv4B6I0HhHz/bHflPDoAHNvDkDGbu21YjK3X3c01mR/0Kdj+AZDAnDco3AqnaSzRbbeItjgyY4OyMbu2D2woXM7GEXZ7KDWN3JLsBVen5g3SIA674bOiTZCMQwKCCTmor+bmpCsdEaBCtiyCkRo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LM0qvX/De6C5F0IRlJaRFL1CLHiRsa0e8RLNw6uQVIM=;
 b=CXiBBJP2N89hgg9HaTJZj7xGuQmsYjAtyyoQC7QHYeZ1/Ee/cAsNCui5igCjZG0ABO1wS/RXixI7bnYtZG7UzGA6XyyFECwe9545dI79R9htSU9LBDA9hDPMWvqZN38GxFM8axMOoBpA6P8fxRnNEq9H8/JWewf584dXB75ILqEzxcrrjUUn/OTA2XQa7DmWTjSi+AKmdFp1GXjVFFGJz4oiNOyxwH0apDWzyGGd/rgFcntMaUwvJIv2+xiWi+BaR0AjM3Xy5a9PCnnOsQo1B2BAaWNzg0o8IhZBQNnlj3Q7QavhGm5cyLrPlA172wQ/CXvvbJfuENKs9M93bSWlEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LM0qvX/De6C5F0IRlJaRFL1CLHiRsa0e8RLNw6uQVIM=;
 b=gStPPzx2ZmjMrv28bCxuvF+9PuqXSX18d5TLdEAMeDuZvO9DeZTrREYCSdh8VXF+mh+FzIDXG9eDwEAj0hcyHtbnTJM2i4xIq2LJ0uucmo0ftw+8+BiBeAy+pIT474J2dm33Ls0zE2ShhcuBt0yzyqM7cnXn4Q4oLZ7pwxyNLQGjj4KzH8xLEKK52IPO86guiuHwzO5fKXUV5NAiHCh6LjDRP3tw7s7Ofhfb+hIohLwQlY5fVGuauzduTA2NAywT3GzeKeI3M7FBNx1m43NapBBjFst8zZ6+hSaeu3mnYxzEiVvYkcrv5tY/36xoaBNMWhhHhyr7uEhJXZWdgOERJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB7227.apcprd06.prod.outlook.com (2603:1096:101:233::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 06:54:36 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 06:54:36 +0000
Message-ID: <4379c4cb-3b09-4ad7-8859-54949f778c78@vivo.com>
Date: Thu, 1 Aug 2024 14:54:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: tlb: add tlb swap entries batch async release
To: kernel test robot <lkp@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-arch@vger.kernel.org, cgroups@vger.kernel.org,
 Barry Song <21cnbao@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>, opensource.kernel@vivo.com
References: <20240730114426.511-3-justinjiang@vivo.com>
 <202408010150.13yZScv6-lkp@intel.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <202408010150.13yZScv6-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 38de77bb-38bb-490a-aba5-08dcb1f6ce77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|921020|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2svZzhtOHlZbEo1QkplZnBvMGYvSWtJaUFHSHEwRWxXeEZRb2ZlbWowUzI1?=
 =?utf-8?B?TWdwN0g5V2ZLR3l3TWpZR25uOGZjZTYwVEpLd0U4ZXRrT21adGgyZlVXNDFq?=
 =?utf-8?B?TnN1aUNJNzVjS1N1cGQxNXdPVW9vYnI4R2pQMzRsM2l0cnVVR041U3l3aUdY?=
 =?utf-8?B?M05BQThwNnl5M3lDRGlobHZWakhLQ2ViUVlJekFqM1FvYkVpakxTdE5sRFVJ?=
 =?utf-8?B?OWZpYVJrNXdtRUJIWnFCRGZOSzJ1VFVOeTkzeHZPUU56WHo4ZFRSaEJ3Z1NW?=
 =?utf-8?B?VU5aOTM2VHFMZjBqN1VERm5DbFVKQ3BmV3BHV3RVSW1PMEF3bVIxZGFWZ0FV?=
 =?utf-8?B?cldZeXhncXd0ZW1PVEdTY2pvbXFpa2dsME5zMi9rMnRtai9jc0IzNUJzdHVx?=
 =?utf-8?B?Njc5V2tPYUpGZFlxdGlKK0JWdlQvbWsvNWZIUEdqa0E0aG9MMkdBT1E2ME14?=
 =?utf-8?B?bGhsS3l4Qmx1TDJrZSt2K3JXbDc4M2QrUWVuTEROSk0rK3ZZSXBUWVdwSDlC?=
 =?utf-8?B?T3dkVk55M0xLTzg0MlZUZXA4dHNkV3lRME9WWTU0RmlvL0JlVG9MZjlXNXAw?=
 =?utf-8?B?bjlGZlN3U29RZm1DTGdXWWs1RFpPQlhHWTk2U093dTdJbGY5T0NEWkVQVm5F?=
 =?utf-8?B?cEptL3JQalRSOVp2dy91bE9JVXJpVCtKNklINml0cjJmakpLbnIrNmRjL0F0?=
 =?utf-8?B?aG1IeHdwSndBTHJUck14cmtDTWpzT3JHaktUVGtDV2pTdmxmUDZpRmFuYmxQ?=
 =?utf-8?B?VXZLeXZzYlJrZmpZaTZzRS8zc1NtRjB6NHlFT0ZMYjNUdTNpRkx0M0Z1Y29C?=
 =?utf-8?B?MVZtM3FORDk4dEhPL0QyRHNLbHpWc3d6ZWt0NStZYnhNUlJyY2xFSDQzVmJR?=
 =?utf-8?B?a0JyaGNYQnkzbG5ZWndmUFpFOGNtVGFkWVd3SHNFWVU0ZlI4ZEdPNUNzSC9s?=
 =?utf-8?B?SjdBNks4Q0YxM2lUWWtJaVBreGdOdEZiSDVMZExwbS85R1p2QlFXbzNaTThP?=
 =?utf-8?B?c0U3RmJ4OEtDWThzVmdodWNtY1BLL1ZyYmIzZmVla0g4S0tGbUxudk5LWG1U?=
 =?utf-8?B?bUJXTE4vTXprWGp2TlJrRGgyMjBOU2RLZ2NnM053M2RVQnFCMlpna29sMjF4?=
 =?utf-8?B?d3JCZXcvMjZSQXZRalgyTE1zbUY3dThlQlpJMU5VdGJUY1p6NmUwdlJkdjZp?=
 =?utf-8?B?RWVZb21RbTJsaGdkQlZ1aFhObVlEWi9CZ2FJV1BHQ3dFZm9yWEREVWtkZWNH?=
 =?utf-8?B?azQ1dG5LS0E4M0xGUjk2eWwzZEYraHFkOXpEMkQrQVAvME5jQVBJdnZWZWkx?=
 =?utf-8?B?aVpJNzZ4ZkVDNkRMUDlvNWFzcURaWFlhWnQxcS80aWRhU3FRRjczL1p5ckMv?=
 =?utf-8?B?UmluNmxxcHFHK0VhakthZ0R4Q1IxMzBMdTV4cXIyaHY5OUNGZ2VLNktZTTRZ?=
 =?utf-8?B?elc2OGtRR2xMVEp5RXl1ZnNRb0p3SENqbVN6a1Z6U1NJcDNJVllvcXMrVXM4?=
 =?utf-8?B?elNEdVdoTTFQYUk1RHlkT1JYUmpZVW8zN2lYQVVjYjdMSjNhejV2NE5Pc1Jm?=
 =?utf-8?B?NHZlZjlUZXFQKzVjOVE2YzBLNm9ZcXhNL2txN2J6dEswT2lUUDNuSWpteWpU?=
 =?utf-8?B?K1pWdWZtSW9QTEUyRXQxK2k1NFJ1QXZ5TDhyUGNwd0RZeGhXUEFHbjdXbkov?=
 =?utf-8?B?Qit5V2N3bmNxVVpDSFZ6MnZKdEVXZGtkM1lLWlYzN0tTUlIzVmIrNGNmY2dt?=
 =?utf-8?B?L01LS1V0UUxZM3kzT0JnMHp2MEQxYWp6dFdtblRNMFExRWEwQVF3dnVaZkxt?=
 =?utf-8?Q?PZryEUdtXKxQjLewMBs9h4Nk3qcTwnnMyvqKs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(921020)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnZXLzZXVXlUNlRLTHc4RjBrOVRONzhQZUh2Y3VZUVdLdzVMNUZ1ai9ia0NF?=
 =?utf-8?B?dzMrZlFYcjBYQUYzQVRodGFnTFB1N0FIbCtUUVFrcXhJMFptdzZNMVluU0JK?=
 =?utf-8?B?UUVGcVM3WGhhU3RlYXZxNUQ5dWhMdHdua0lJUklBMVN1NmVqS29POWJyTWVU?=
 =?utf-8?B?elNteUIvVkNuTVVXeXJmSDB6ZmhhWVltZjVPeDNCdjlubEg3STkwQ1RBZFlM?=
 =?utf-8?B?NDVIeWJLZTFjMXpVeDdEVGxRaWVOMkgrVEJIZXBXL3FFcS8xbHN3TzBlU1BF?=
 =?utf-8?B?S3BLVkt4TkNEZjNadS9jL3QwVzM5ZWZuNEFZak8vWXJBbTh0OHNVRGVhNjUv?=
 =?utf-8?B?cmlPU2VOaldpSDdibmMzdkJHUTBBalExanFJQzJtV3Avb1FQbm9GbHZUWStR?=
 =?utf-8?B?ODI0Si9LaFl6NG9TajR0REloVVhXN2RMU3ljbnA2UEtIRGNsZ003eU5Dd0pD?=
 =?utf-8?B?RlZQTnllWUh6b01sb0lpeVNwV1k2eEZXdnVSRE1rL0I2MkxuYWhveHVxMUJW?=
 =?utf-8?B?eTQvbXVBUjB5ZjdaTXJyV044WVJGYkZNT25YQ1hSTm1yTkF4aFhMdTlxM3FQ?=
 =?utf-8?B?Zjg5ZExUVXNrQVB3OGhFTWlJa1Y3N290anQ4SkdJYkNFOVZ0Y1pyZldpVzV4?=
 =?utf-8?B?VWo0d3ExMnV3S1ZkcFd0azFKUG00Q0paSFVVTHpydlZTV2lYTzkyTnp3TzRQ?=
 =?utf-8?B?M0s2UGFiSUVQMktQMEVtT3NScUJGVzFOMHdZVzk5aStseVZPSmxoRDlvb2RD?=
 =?utf-8?B?TFlUTFI2ME5sWUZkUXJVdE9yYUFPemF2TE1IZUN4NCs5NFp5R0dIT2krZE1o?=
 =?utf-8?B?UkhLVTNSTWFxVzRwOS92OW1lS3NLRkEyZThaSlcxb0ZRMXdoRktQL2VvdzRk?=
 =?utf-8?B?cERLak9VM3dYcWFGZVZWZW5zbUo2Z0MwQUxWcS9DdC9DQ0k5Z0dIVk9QOTJD?=
 =?utf-8?B?VnU4RmN6RnlxNXRTSUpGeEdvc21NSWdCWFJRdFBUaTR3YVczWjFjRitCbk1S?=
 =?utf-8?B?N2VWcGRDTDl5ZDRwenlnZ2orZ01MMmFlWWp0S3Z4SFg5KzlkYnJlSnh5N0l2?=
 =?utf-8?B?Z1pvR29XakZ2enJOMEI2ckluZTF3T29sYWpuYktCbFdycWMzS3pVeTI5QzUy?=
 =?utf-8?B?ZEhhRkxYTTRUSy9QdGk2MHUyaU1kNUZ1UGRUZXNwN3NlSENEd2g4dVBkQjYy?=
 =?utf-8?B?bmd4Qk54Q1hDMXFaVWRZNHIycEVEVUljc0RMRG9vckpBbXpFaEk1dVdOZnVR?=
 =?utf-8?B?ZmQvUm0wc2lCcTZPcE5nMGNtejhqZ0R3NWtzS08zOE01dWk3R3k1dWZ1SDhp?=
 =?utf-8?B?ZVB1WGk1S1NYdjBlSzNiZmtBTjJUS01TNkVqQ2pjd1luangxVkZWUUtjWWUv?=
 =?utf-8?B?TzNmUU9zNCtLT25EelNqbVQ0djkwNEdkN1BzaFhPejNsTGd2UlZsc0xGRWNI?=
 =?utf-8?B?UkxYVGFrQjlORGpPcVFyME9uN1JvcUdObUJ4WG9UNy93Tk4rOEVvOVZGNW1I?=
 =?utf-8?B?R3VSL0I5RHhyak9YbEl4dlF5N3hvd2dCVkRHQ3Rjc1FXWVpnSWs4Ylk3NlQv?=
 =?utf-8?B?K1lMNVkzSTV6WGFHRkxZd0hCK1JIa3lDYmRvQytnNS9Qck9hbXV6TnBRMXhY?=
 =?utf-8?B?ZDFNK2FIbHJLRzVYOFg1MU9XUkhuWnpHZHJZaHQwWTRibWFzcWgyNkdzdjVa?=
 =?utf-8?B?b0NqL2NTTkY5RjViRnhCQ3FJYzkvYTFVME50U1R5TFQvR0U2OUFwblFWbFYw?=
 =?utf-8?B?eElCZUhUMVUxWDNtbTVocU9Rd0M4cTZVZmo3azdVbWhMVU5CUW1rWUFIcklY?=
 =?utf-8?B?TWVmdTV6SFB0NUhFbCtBcXZ5RE9RVC9vRGNrMlAwVG81WStRNU9Eb01qRTVm?=
 =?utf-8?B?Z1E1VUdJNisrdW5UTGo5WER3d3FIYkNwTVN3NnExYlNtV0RRd3Q4NnZONkFT?=
 =?utf-8?B?Y1pTeXlCWVkyUE1HQ29pRFgzV1IwS1NBZUNCZ2NPbXVKejJUN2g2WXE1bTBH?=
 =?utf-8?B?VWRpNXVCcHkxVUl6YXVsSmFwZWsyNXQrdHh3RzNDM1o3cDMreUVUdmN1ZTVL?=
 =?utf-8?B?dFh0U0JKRGExZWVuUlZYbTR3MTJONUduVWIvUzVHQ1dDQXR0Z2Jia2QzYjBC?=
 =?utf-8?Q?MgwmPH2tZWAPeRJxgkGsYvjyD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38de77bb-38bb-490a-aba5-08dcb1f6ce77
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 06:54:36.4857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0/IVc/W5TcieAlJ7wBHYv1slLjiAKGKw91RbFSZCOrA99gr9ufKwu5F+YNoN0eZPNf2PpiXRw2JX7uBYPQL6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7227



在 2024/8/1 2:19, kernel test robot 写道:
> Hi Zhiguo,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on akpm-mm/mm-everything]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Zhiguo-Jiang/mm-move-task_is_dying-to-h-headfile/20240730-215136
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20240730114426.511-3-justinjiang%40vivo.com
> patch subject: [PATCH 2/2] mm: tlb: add tlb swap entries batch async release
> config: i386-randconfig-061-20240731 (https://download.01.org/0day-ci/archive/20240801/202408010150.13yZScv6-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240801/202408010150.13yZScv6-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408010150.13yZScv6-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
Hi,

I have fix this compilation warning issue in the bellow patch. Please
kindly help to test with this patch.
https://lore.kernel.org/linux-mm/20240801065035.621-1-justinjiang@vivo.com/T/#u

Thanks
Zhiguo
>>> mm/mmu_gather.c:54:10: sparse: sparse: symbol 'nr_exiting_processes' was not declared. Should it be static?
>     mm/mmu_gather.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h):
>     include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
>     include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
>
> vim +/nr_exiting_processes +54 mm/mmu_gather.c
>
>      53	
>    > 54	atomic_t nr_exiting_processes = ATOMIC_INIT(0);
>      55	static struct kmem_cache *swap_gather_cachep;
>      56	static struct workqueue_struct *swapfree_wq;
>      57	static DEFINE_STATIC_KEY_TRUE(tlb_swap_asyncfree_disabled);
>      58	
>


