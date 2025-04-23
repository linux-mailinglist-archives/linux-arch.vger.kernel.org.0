Return-Path: <linux-arch+bounces-11512-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B99C0A9855C
	for <lists+linux-arch@lfdr.de>; Wed, 23 Apr 2025 11:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF686189FD50
	for <lists+linux-arch@lfdr.de>; Wed, 23 Apr 2025 09:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3752D244691;
	Wed, 23 Apr 2025 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BDIwR+7Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57916242D61;
	Wed, 23 Apr 2025 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745400285; cv=fail; b=e27LrDOrH9YsEUcLvbtsN04AusEA/N2vt+Sb1Toe9b/1Df+pmNHOxiZa3aH+FaZCyVLR1v5o3V54ETwuU9/FIMfPYwYyHXUcXaLL0Ng7Mj9ddAv3SlPrvkO+bX+/2EGipeJNr7qoIBit/Uttz+8LYC0BZ6trS/fWwDwbPCPpxDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745400285; c=relaxed/simple;
	bh=fYD/W56FAaQgV2Mww9uCt2J4vIh1yunWPA8WdBbZpeI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CXvts/gTpzxnyPOWEPTB8nfq+H5A6HPN3449FGyN0Fuqp5RXn8CSmjysnyyq6CyehfqcyCGiGRfqjQg9ESFio314oL63zKaF+IqDTljAOlWBXidwShaLhIerzfhaZA+nJ639vPL89cYsvGGwK2uskGz+73AkOMg+hcZWzPcNdAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BDIwR+7Z; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgQiN8MNNhq2Ib6DqOkzWgOFK4OoBtZODIYTx7r/3/yS9suB8cSMWGt6cWkep5b82oluBftyMDOZAKw239wbcOwzX+QXuuMf2LYsTBQwabpnsb5R6/3b8/wVzWgdbf/iuMzHzmycdBS/YaLc1T5dM4X/cO/OyLw3azU4+xwekGeLrWe3MGqOuavL6I/cUZxBAtRRRFPtbIfyaIW+psXKpIhlYcisUPTgMNJORMYvbFEicMY3gjvc5P9X8KcdR8oNkLdWjf2WhqtIL/vJzB4PNRrlauO73KVyCyFuzUWIaz8dD6/fa68K2SeivW1F7q6qS8u0JKNnP4All0CCZuFpVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tmGFsEmGmJAQhjtPvqljcyknNTln9JiphJdsRi9Oj8=;
 b=So5hDVU3UAenMvuqhbBvBVPMeJBFRZAj/dJVgvs8NQr4st25bNUHRzAo5tFA9X+JOr+kMftvt0/SW6aUaoM95jMQ/0DysHjWjEwjwnxh+LzuUsS42tGR3DMxAVb9Sss1tEenR7136WaXpIvUBpM9QMsyzZ3zP1+xk6eFLmAhX247iaLv18woxnNyoVQYCqbb6ITALjaN8qS6IgsLfVOoEdZST9Jr/ENIKBszAZfRY9pgIlIb4cQTjcM69mwNBRdMjD6ESR9GIxSi/1slLvRIo+ZxMc7EBidB8Xg9C1pex87w7B6aMJfU9BOZk2nQZgscPMfSEhEtYomReHCoTz1lNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tmGFsEmGmJAQhjtPvqljcyknNTln9JiphJdsRi9Oj8=;
 b=BDIwR+7ZSaHtXegcvuG595X5A2iIyKcz/UAUQBaukhICDatTtaI07OpkstBRk+bJSu4cFE2fC8Q8qvMooVOjp9iP0Pf8xjiVqrw7Sbguc+g5k3FlbbuGcffN1E8b+h9ALtqkdO+aaM1GvC6h7hFHK0V7A0o0y5LVbnyRa8zsjMIiEVq2SOS70NYf8W8yj4qCodZEgGQ08w5QSQmvDVJl7+x2NI+BD5051YAGnfuhBJYw9RB2VShYTRa5j8+f6Vdv+IZI4a5wqhhAvLzKuDR2Tqr0/OIa4GTI39hvgbLvmuw1NQ2+Y/9CGLLnaEVMKOSX4GMQt9earu+V2LpLmEHBpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SJ2PR12MB8808.namprd12.prod.outlook.com (2603:10b6:a03:4d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 09:24:40 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 09:24:40 +0000
Message-ID: <4c042dd9-50d6-401a-bce7-d22213b07bca@nvidia.com>
Date: Wed, 23 Apr 2025 10:24:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] tools headers: Update the syscall table with the
 kernel sources
To: James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>,
 Arnd Bergmann <arnd@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 linux-arch@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250410001125.391820-1-namhyung@kernel.org>
 <20250410001125.391820-6-namhyung@kernel.org>
 <f950fe96-34d3-4631-b04d-4a1584f4c2f1@linaro.org>
 <95c9bd53-ccef-4a34-b6d2-7203df84db01@linaro.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <95c9bd53-ccef-4a34-b6d2-7203df84db01@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0667.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::20) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SJ2PR12MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b825247-12a8-4708-4dfe-08dd8248ac8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1NiSjRDVTFpdkllb2RMdVVQelp3VlJwRk40d05JUVhqNXI3WExxNlVQOUFU?=
 =?utf-8?B?VjYwQkUyVzA2cGN0djNZNHdPNVpJVXZhNUNuWFZkN2FtODV0TERBYkRIRks1?=
 =?utf-8?B?aG1uVnVFMDdIU0NiRG9OL0lGbXFZY3hERzlWc1FvV0hzMGdlbXNmeFpkUklw?=
 =?utf-8?B?dTJFN01ic2h1dDA2TzA0Z0xHUEFRV2xSSi8vK1VaQmdvVWhHYmlYM0c1K3BL?=
 =?utf-8?B?RDFXU1haSmtnNlQ4ekE3NEN3QS9IOUJMSEU3YzhONzF0dzdkb1hWWnJSOCto?=
 =?utf-8?B?dHhBV24xeHU2cFpUREdRUmlkVUJSVFpXOXp0ZFBnbHljc1h3bDhRUlJPWFRV?=
 =?utf-8?B?Z09oYlBSV2NlVi9HcU1JZklxSnpncmtBOGMvaXRBL3JjOUR0cGhEbjk0ZDJi?=
 =?utf-8?B?ekpNL3V4ZVlOVWtqdFF3NEVUTm1kOVFLTDBDeXJzU29RTi9nTVJydXQ1cUFq?=
 =?utf-8?B?cCtYSDgxZWE2NDhhWEZDdVkycE5IWjZsOVIzSldjRlRwcVQ4QXRqajFRaEQv?=
 =?utf-8?B?eUZ5cDBTU3R3eUt5SHlFSk5qaUZNNzlDcURUY1h5Zk1HQ1JxMk1wQVJaRmt2?=
 =?utf-8?B?bm5tQ3o5ekQxUDIvVE1kVEFjdmNYNXljc3N3THk3NWpNKzNURGdVOEFDNk9Y?=
 =?utf-8?B?TEVzMGl2Tmd2MkRvbndEYndFaExBWHJ2TmVheHA2dC9UbzZEc3hIdm0xQnZT?=
 =?utf-8?B?R0xlSTNlTWdsZVIvdWd6NDEycEJORkxIVW41eTQyMUlqSzhLeFJDOXcybng1?=
 =?utf-8?B?K3pNVUdYNjF6amRNOU5YazR2VG4yb0VYcVY3bmNxRGdMZE1GYk9jWGQyZCtJ?=
 =?utf-8?B?YTk3ZFVKOWVoZ0RRdk5KNFJoNXBoNHN2SThLaGMvWFhYK082dVhJYWZrUTIz?=
 =?utf-8?B?NXJINHBydjdKY2h4ZEQzNURQOG5OUkpQcXV4eUVyMktaL3N0OU1BRGhNZEF4?=
 =?utf-8?B?SU1MRm0rUzh5WjZvZWp2RkdvN1RZMVVEcHBkSFE0emR2aHRodUJMQkxaNENQ?=
 =?utf-8?B?RUJNUVNXdDJBRmhwSDFJNUdodWpvbUtuRVJZSnRPWlkwUUd2SVl1dUo0dzFo?=
 =?utf-8?B?dm1MZFRMZ2tyLzUvOEVBc3RqT2FLeW1hMEVNRnIrUmRXV2Urdy9DTWFsUDFC?=
 =?utf-8?B?RWM0ek56bE5wTTAzMkVRQ28vOFB6ZnpXMFQxZnRYQ2lwLzJqQ0IzQWZDUEpi?=
 =?utf-8?B?TmRab2tSYml0cFVtb0IzYytkNVVYcTNrZ0RSd3ovalVTeVYveStiYU1rUjBI?=
 =?utf-8?B?b2JRam02RWQzcEh3TDF2RzduY3BnbllNUGNvS1V6TUpBR3JVRXhvYnhwS3Ex?=
 =?utf-8?B?V0MrcWJMOUNMYUdNS2ljZmYxY1d2S3I5bmxFeW82ZlhRbWZNREJrNU9pN2Rl?=
 =?utf-8?B?QXB0Zy9YNDRSRmRUS2I1eUFwN1JZMys3SlJlbmRyY3FkY1MzMklzNThXNkkv?=
 =?utf-8?B?SDZCVUFKNVB6aFllbXNxcFBWZUplTkkvZW1qcWRwMVpxY2tPaFM0TWdFd0wr?=
 =?utf-8?B?RFF2K2lLL0lxcGVxOG1mVWtqci9NSlhOUzdMbzd3bHRTN1c3eUJUeFpFblRi?=
 =?utf-8?B?NkY5cStPTFhjNkZOOWk3U2t6YThYSlNEZXBXUktVMlhDWGhQVUZiSjNEWkhx?=
 =?utf-8?B?d1F3SnA4L05rNmxQUmdDTVlEVmVKNXNwWUlubDRLREVXQUZBUFdUSTJuOVJu?=
 =?utf-8?B?OW11SDJmajhoWWZiTzR2Z0VXNFo2T1N6VWRDSXJKaWlhMEx3Snl3WVBJc0lw?=
 =?utf-8?B?NllXQzhabDdaeDRZMEpZZnljWCtrWVYwMmc4TnAwaFI1Rm5XMUxkM0lISTRE?=
 =?utf-8?B?a2ZOU05Xalk0eldqQ2ExSmp1RlNKK1VFRTlSbWJ5bTZGaHlva3NnRkkrNkV2?=
 =?utf-8?B?TWtQenpmcjVqbFdwMlE2MDRGQTF3dGZ0bTBreXE4RXdkdlcvM2gvWm03aFpZ?=
 =?utf-8?Q?05YtVacbI5U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWU0bnNxd3R0MFNvd2VFVWw2SVVYSU5SYVVPeDlZVW56WDdhbHpQQ3ZUQUpL?=
 =?utf-8?B?UTRvVWI2UTVhM0dyV2JYNmRyelBxUWpUUGNjQStEZVhoRllIRms5eXBvT01U?=
 =?utf-8?B?L2Q4Q3MyUksrc3ZVMFBMbzZhVW1SdFl5NHB4a3N6d1o5OUgvK2V6bzlMalNi?=
 =?utf-8?B?ZVMvQytqYlpTTkc4ZzMwcU1NQUQ5cUxsTHZzRzlIRzczamtMdVZsNGFld2No?=
 =?utf-8?B?MEkwV3NDR1hGeWY0LzZIL3cydnN3YktKNXFkOCs2NE1pdGJadnNxOU43S1R1?=
 =?utf-8?B?VHlzL1B5dFp1RkkrSHhMSUVmV0FzaCszNDNuYmd3b0dHem5keElzcUNPQ1pC?=
 =?utf-8?B?SStWV2FCNnhRQmNENklOVGNmVDhWaXB5ZTA4YjNMWXNVYmpsYmVOT0FBMUVL?=
 =?utf-8?B?VkVjWjZUbHBhWVhhSkJBMFFNK0ZjUk15dDBzeno5QlZhUEE5bVZUa2ZXSlRG?=
 =?utf-8?B?M0t2VEdaZmYrdWRrbFpja2wvQXdOWUhpdkNtb3FnYTFxU0p4MGwzRlZsRmhV?=
 =?utf-8?B?WWhBNm1HeEZEeUxWbHlSczlEaTJaZ01EZTBMU2tZUkRWbmpUQ3o3eXI0Rm5x?=
 =?utf-8?B?OGxxTkJkNm1TKzJieGJtcEgwU0RZNXdnL29aZHJoSERNaFhCYXRuS1R1QXRp?=
 =?utf-8?B?OC9tMS8wdFZRdGd6dm9RLzROTVVFMThITi9LVjFYYlducE9iSHNmNXdyY1BK?=
 =?utf-8?B?Q3F0S21lZU9WMzJrMTUyQ005MVY4b3liUDMzT0E0RHB6TG5GZFFBWFF2c3FY?=
 =?utf-8?B?Wnh0YXMyMW9KKzVHcHBGSG9aWExRUHlEc25HU2ZNSnRXK1lka0JFR2xVZHNn?=
 =?utf-8?B?QzB3MXBvRFdzZ2NvdzBMMjIrRnQveUo5MGN1YjhyY29nZU5PQTEveldLb1Bj?=
 =?utf-8?B?TGpURGcyWXV1T0ZTSVhSaDJQMm5kWW5NUGlETEV0YThsYXg4SFBYamlvZll3?=
 =?utf-8?B?YU1sakRxOXQyM1l3SGRnMkhjSFBYQmh6Y0NZcmFnRjJuSVBNN0h5aTBMbTZC?=
 =?utf-8?B?WWNuN09Dc0haQzA1WWVtUFl2K016SUliYlRIaWp0MVFVR0w3aWQ2TWNwWmlI?=
 =?utf-8?B?RllpVTlPaHFRVVdVRVQwZ3BRaXJ3U0hZOFgyczFsUmpLbXJzNGtrZ0ZEUm5z?=
 =?utf-8?B?ZFNBeUQzaFpEamtJTnZnVWptcTNmcUQyVkZjdUdDUDVuTHlKeG13RkRIdzNj?=
 =?utf-8?B?UkRXWWd3ZzVlWVRYTEYwK1hjWEMrUmgxd254Zjhic2Zkak4yZ0x0OEpaa2dD?=
 =?utf-8?B?aFV6KzNvaDcyVUVRTXdDTXdqZGR0NDEzeXVsNWlKSHg3MmJyWG9xTVUybDBZ?=
 =?utf-8?B?bmdZb0llOEtEaVl6MVBLNXhhYlhYRXBhK05NcU9lS1FmbFVYR01MSC83TXJl?=
 =?utf-8?B?QmowZEJMUTRLQlJuY0FISk5ldlM2djR2Qi81ZkZud1lWU3Nnd0Y3enR6cFdt?=
 =?utf-8?B?bXFldHBjSENoMTRydW1veUMwclFOUkxPcGlDRUIxdDdZM1A0TmhxZlFHUjBT?=
 =?utf-8?B?ZmYwN0FKd1ZnSTROUE0wY1hXMHRVWFBkOFpTYlowa0RXbGo4Sy9oc05seUN4?=
 =?utf-8?B?WmFvUlZwOGdJcmdST1E4dVZqNjJPK3hoc01hdFBvbkMzZmVwVHVCeG5xc3lH?=
 =?utf-8?B?S2RSR3lwWUtjbmY5VWY0WVRuOFBtSXZ2cmtaaHlkbWV5MFE1YWRSZWR6K1B3?=
 =?utf-8?B?dzh0TjhxeGdkSjV1VDg2a3I1dm01eDhPOEMyeFZ4NEZYYXJCWVJKcUxJSUF5?=
 =?utf-8?B?SStNS2R6SmcxTVVxMy80ZXhEaFMzZURzeGluYzdYSy9aVFhIVXdCbXpMYTdG?=
 =?utf-8?B?VVc3WXlrRlJ4K21RdW1KSkl4S2JTRDFFYmNucVlkS25meFNBcjFLNTFEcnJs?=
 =?utf-8?B?YUhsYzg5Yi9kY21LeVA4WHFESVBRaVR1cEFSZHNXcFZaclVWajdKY2JXRmNv?=
 =?utf-8?B?MzFhQUdyZnBTUGgzem4zV2FPMW1OZHFHVkxlL3cwMnNmS1I5ZDdUVHdaRTFh?=
 =?utf-8?B?OU1ScTdpQmRpSHdZdkV3ZG0zdTBjdzlvOGRCb29xbFZ1UEs2aS9PQ0ZFcExP?=
 =?utf-8?B?cXJkRytpMi9FUWxTYTAxc3F4azJYc0ErN0JuVG5QeFpUNVVwWVZ3N3VyaXRn?=
 =?utf-8?B?b1VQeWo3MVlNL09OeWFFS1pZdUxSRGp6K2tMME9ZMXloQmtxdFQ3VmkzSGNi?=
 =?utf-8?B?QUQvVVphZ1Q3R2hucEhiZmJpNDNmYUFYMWxZK0ZYMW9lbVBUb1hLbUlkT0xl?=
 =?utf-8?B?dXQ0R3hSb25iZkQ5d3dGcTdnNERnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b825247-12a8-4708-4dfe-08dd8248ac8d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 09:24:40.2316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBVyUFLX1DV7kSvE/SIe47BCqNGUs0PTjHgloMsuAtDX3UB5o6+DRg79Sv1WyyT2dEegkySOXTVXEJ44M+E3FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8808


On 16/04/2025 14:26, James Clark wrote:
> 
> 
> On 14/04/2025 5:28 pm, James Clark wrote:
>>
>>
>> On 10/04/2025 1:11 am, Namhyung Kim wrote:
>>> To pick up the changes in:
>>>
>>>    c4a16820d9019940 fs: add open_tree_attr()
>>>    2df1ad0d25803399 x86/arch_prctl: Simplify sys_arch_prctl()
>>>    e632bca07c8eef1d arm64: generate 64-bit syscall.tbl
>>>
>>> This is basically to support the new open_tree_attr syscall.  But it
>>> also needs to update asm-generic unistd.h header to get the new syscall
>>> number.  And arm64 unistd.h header was converted to use the generic
>>> 64-bit header.
>>>
>>> Addressing this perf tools build warning:
>>>
>>>    Warning: Kernel ABI header differences:
>>>      diff -u tools/scripts/syscall.tbl scripts/syscall.tbl
>>>      diff -u tools/perf/arch/x86/entry/syscalls/syscall_32.tbl arch/ 
>>> x86/entry/syscalls/syscall_32.tbl
>>>      diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/ 
>>> x86/entry/syscalls/syscall_64.tbl
>>>      diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/ 
>>> powerpc/kernel/syscalls/syscall.tbl
>>>      diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/ 
>>> s390/kernel/syscalls/syscall.tbl
>>>      diff -u tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl 
>>> arch/ mips/kernel/syscalls/syscall_n64.tbl
>>>      diff -u tools/perf/arch/arm/entry/syscalls/syscall.tbl arch/arm/ 
>>> tools/syscall.tbl
>>>      diff -u tools/perf/arch/sh/entry/syscalls/syscall.tbl arch/sh/ 
>>> kernel/syscalls/syscall.tbl
>>>      diff -u tools/perf/arch/sparc/entry/syscalls/syscall.tbl arch/ 
>>> sparc/kernel/syscalls/syscall.tbl
>>>      diff -u tools/perf/arch/xtensa/entry/syscalls/syscall.tbl arch/ 
>>> xtensa/kernel/syscalls/syscall.tbl
>>>      diff -u tools/arch/arm64/include/uapi/asm/unistd.h arch/arm64/ 
>>> include/uapi/asm/unistd.h
>>>      diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/ 
>>> asm- generic/unistd.h
>>>
>>> Please see tools/include/uapi/README for further details.
>>>
>>> Cc: linux-arch@vger.kernel.org
>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>> ---
>>>   tools/arch/arm64/include/uapi/asm/unistd.h    | 24 +------------------
>>>   tools/include/uapi/asm-generic/unistd.h       |  4 +++-
>>>   .../perf/arch/arm/entry/syscalls/syscall.tbl  |  1 +
>>>   .../arch/mips/entry/syscalls/syscall_n64.tbl  |  1 +
>>>   .../arch/powerpc/entry/syscalls/syscall.tbl   |  1 +
>>>   .../perf/arch/s390/entry/syscalls/syscall.tbl |  1 +
>>>   tools/perf/arch/sh/entry/syscalls/syscall.tbl |  1 +
>>>   .../arch/sparc/entry/syscalls/syscall.tbl     |  1 +
>>>   .../arch/x86/entry/syscalls/syscall_32.tbl    |  3 ++-
>>>   .../arch/x86/entry/syscalls/syscall_64.tbl    |  1 +
>>>   .../arch/xtensa/entry/syscalls/syscall.tbl    |  1 +
>>>   tools/scripts/syscall.tbl                     |  1 +
>>>   12 files changed, 15 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/tools/arch/arm64/include/uapi/asm/unistd.h b/tools/arch/ 
>>> arm64/include/uapi/asm/unistd.h
>>> index 9306726337fe005e..df36f23876e863ff 100644
>>> --- a/tools/arch/arm64/include/uapi/asm/unistd.h
>>> +++ b/tools/arch/arm64/include/uapi/asm/unistd.h
>>> @@ -1,24 +1,2 @@
>>>   /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>>> -/*
>>> - * Copyright (C) 2012 ARM Ltd.
>>> - *
>>> - * This program is free software; you can redistribute it and/or modify
>>> - * it under the terms of the GNU General Public License version 2 as
>>> - * published by the Free Software Foundation.
>>> - *
>>> - * This program is distributed in the hope that it will be useful,
>>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> - * GNU General Public License for more details.
>>> - *
>>> - * You should have received a copy of the GNU General Public License
>>> - * along with this program.  If not, see <http://www.gnu.org/ 
>>> licenses/>.
>>> - */
>>> -
>>> -#define __ARCH_WANT_RENAMEAT
>>> -#define __ARCH_WANT_NEW_STAT
>>> -#define __ARCH_WANT_SET_GET_RLIMIT
>>> -#define __ARCH_WANT_TIME32_SYSCALLS
>>> -#define __ARCH_WANT_MEMFD_SECRET
>>> -
>>> -#include <asm-generic/unistd.h>
>>> +#include <asm/unistd_64.h>
>>
>> Hi Namhyung,
>>
>> Since we're not including the generic syscalls here anymore we now 
>> need to generate the syscall header file for the Perf build to work 
>> (build error pasted at the end for reference).
>>
>> I had a go at adding the rule for it, but I saw that we'd need to pull 
>> in quite a bit from the kernel so it was blurring the lines about the 
>> separation of the tools/ folder. For example this file has the arm64 
>> defs:
>>
>>   arch/arm64/kernel/Makefile.syscalls
>>
>> To make this common part of the makefile work:
>>
>>   scripts/Makefile.asm-headers
>>
>> Maybe we can just copy or reimplement Makefile.syscalls, but I'm not 
>> even sure if Makefile.asm-headers will work with the tools/ build 
>> structure so maybe that has to be re-implemented too. Adding Arnd to 
>> see what he thinks.
>>
>> As far as I can tell this is a separate issue to the work that Charlie 
>> and Ian did recently to build all arch's syscall numbers into Perf to 
>> use for reporting, as this is requires a single header for the build.
>>
>> Thanks
>> James
>>
>> ---
>>
>> In file included from /usr/include/aarch64-linux-gnu/sys/syscall.h:24,
>>                   from evsel.c:4:
>> /home/jamcla02/workspace/linux/linux/tools/arch/arm64/include/uapi/ 
>> asm/ unistd.h:2:10: fatal error: asm/unistd_64.h: No such file or 
>> directory
>>      2 | #include <asm/unistd_64.h>
>>        |          ^~~~~~~~~~~~~~~~~
>>
>>
>>
> 
> Hmmm I see this was also mentioned a while ago here [1]. Maybe I can 
> have another go at adding the makerule to generate the file. I'll 
> probably start by including as much as possible from the existing make 
> rules from the kernel side. I think something similar was already done 
> for generating the sysreg defs in commit 02e85f74668e ("tools: arm64: 
> Add a Makefile for generating sysreg-defs.h")
> 
> 
> [1]: https://lore.kernel.org/lkml/ZrO5HR9x2xyPKttx@google.com/T/ 
> #m269c1d3c64e3e0c96f45102d358d9583c69b722f


FWIW I am seeing this build issue too on ARM64 and these changes have 
now landed in the mainline :-(

So would be great to get this fixed or reverted.

Jon

-- 
nvpublic


