Return-Path: <linux-arch+bounces-5978-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE68947E4A
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 17:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922EF282BC9
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 15:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBE715B155;
	Mon,  5 Aug 2024 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="op0hYqwb"
X-Original-To: linux-arch@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011032.outbound.protection.outlook.com [52.101.129.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70D015853E;
	Mon,  5 Aug 2024 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872219; cv=fail; b=ErnUvOFnMHIXZ3r0N4q8+j63TXsR7fGsZYLAEJlzcqAtn3jPTPp5gRzYPpArK6YtHtNtD6yUz59yLxmfW27aVAOCjqWCP55aX6T1U5Pw63EVeVsa/wEPOwFagnNKWSU5xPTkJXRMWumM8tL4LIqODS4il5PyEVdnenUq1zBIH0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872219; c=relaxed/simple;
	bh=yiE8mX5jkXSs7AMl6vTlgP3iwVUSgGpU3O9iFAqqO9o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oaGoN3gYI7YoACDNgEP23PTCC6ypzpLeGG3HjmbINOY+ttYnRJDrhZTQ2N2XZxqn6n8Q3feaKXtWzVmjZnImeUGhauBxeVaPCR1ilyp2lrVTUTti53iBdt7lkiMiGAsV5fG7Rg9Ejm3rV3OVLfz1AvD0NehUzaVcw24XW4L/1f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=op0hYqwb; arc=fail smtp.client-ip=52.101.129.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euEbiSFCAPGT6y3GZrVMLC/NFr9DJcgCfDA24lfkQjKT3YVWUTSCFXlJBePBS6GzD3wq9EmzEd5iUvhsni6wqyxpI7HAirD6iC2vfDS4EKZmQOYCPV2emHeQIIRhWv87xu8VBVUmehSbTvpOTp1QIc8SCBm/mhhRwhiFsLzLWG3JuMX89TlXRHUzK9q+MBkB7P0jJaCmAi83fDqYsdgGq/h+n4kEcvv8HYQ2JYcvSPSUoi34Fv3hOdxFZ8f8EpFeZVurpGgcKUP5GCY3xQB3ZGW6KhSGfvuLFpPK8U8YS6h/an6tXgkPB3BAhHwZ71f39S+YWuYtujg7LI8GlAcc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Uu5NeI0WJGCTOfaRki6wj8M1ykIoUTpYHqzeNxRsbQ=;
 b=CyPjoQQcQu2vbo9qW+6bz9FFnSAXddE9caie/iGb+db0B5bSTjrS0RtFPkYSQGXp7AcsUMT1rxCqkniNgMhdVDnRTz7Z9e0lYdpvLRkgDM0VxOgPTt5uaUA9CnP/yC3V/qeFj8/da/PfoD9koqxXhTEXlBeVoYKb/1wl5EKqMdkvTeisa2YnXCYMyC40MZyaaRet/KTkNi68M0wa4W7mhphn6SlUcXhHMDNqG1h2ndOPEQNgrEI2VpyEptJ4PSDrN/XRzJB425wBgF48aRY0n2iZIguxzoqaYqyj9G/htxcD8jiI5Cm2pX5VoQKLybeJaFy7Q9OMuqwvMr0u89gpbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Uu5NeI0WJGCTOfaRki6wj8M1ykIoUTpYHqzeNxRsbQ=;
 b=op0hYqwbACV/4ZPLzhMnfgd06EuP7e6q/bUSCyrH5VeAVdNutzO66708UiNF7W4MfMX8rXmZm+gUpBzmD+Q/f0MsmE5jHUSIQk/3fIiXbLd+Aa0PJGTq7LMfIKL6hTElPtwT+wR7mbAdfTqOyqrNP5Jpk7U0fru+pNanOQ531QuY/RmhZv923bXkxccsadAVrdXu5vBLC2wX33KQowuJEFoP9yJ3kxKcUHPhjoaDerhCLwEHOQTdeFPfutKPPsaDmUdDzVZGwzTr2NkiPxVP3pCTedSbiwmSgVDAVWPYi33YcqOm48GWALWyNzF4/l/bTRdjNiXw48Mi8nC4Xab2Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by OS8PR06MB7322.apcprd06.prod.outlook.com (2603:1096:604:28c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 15:36:48 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 15:36:48 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-arch@vger.kernel.org,
	cgroups@vger.kernel.org,
	Barry Song <21cnbao@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Zhiguo Jiang <justinjiang@vivo.com>
Cc: opensource.kernel@vivo.com
Subject: [PATCH v3 0/2] mm: tlb swap entries batch async release
Date: Mon,  5 Aug 2024 23:36:36 +0800
Message-ID: <20240805153639.1057-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|OS8PR06MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 40fb6d77-633c-4edc-b61f-08dcb5646b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rejj9ID/vXDz2UAhxUqtd/xdhgkiYkcwN2JUAgqV50eomFMjbc6zmOgIglRF?=
 =?us-ascii?Q?7+TZIBIscxGTLdbzSmkYPy4Ezn77OnMmA6s7BZoVdRhc7LIlpXRuoiE/Om32?=
 =?us-ascii?Q?TwL1SvZqQ5TesN0iQdPRmXM7SzzoZtEGLbViHqa+V1mW4R4yu2lWNDKVpfoT?=
 =?us-ascii?Q?jQo3xwbA+aXKiLt7Zj8qC118r8RVZv6HNVVWXL47jSpgQUs2UMgsW4bjq8vc?=
 =?us-ascii?Q?L7mX8ta0DHprG8ldFe+6p+awvZO4MKAQo7v6Xaac7v5yqEfWFqkpALCDUGE5?=
 =?us-ascii?Q?i1AV2OZ+t1NCbZzuwObexPt49XSF2awDHBteQkTS7NUk19wmH1oe2UxJYjiS?=
 =?us-ascii?Q?YDTTPHESq8yiNyTlZE/NsJScl5wZjqsG3Vnyr0XLL9QN1U0eO8a/KM7lH8Ng?=
 =?us-ascii?Q?neGnTBnG08AN4OWcv7uZQZepyK/4wT4LgVTCmHqv72FTEpD0B4Pn+ghT8OxL?=
 =?us-ascii?Q?RttYiCbEXcs8Gp20bGSZFC+IptoDrR5Uvzql9lZw8hRYIKZPG+LFyVlY9Ok8?=
 =?us-ascii?Q?BP6+mZOo41xQjJ7cbB/CdN5XzHVcUSxuOuxKGkW2EYOx69oUfdplLFlz+Jmq?=
 =?us-ascii?Q?89jwEmlj/qDRz+6ZlqOgSyJ8VHs4BU3d17k6OoqZa6TyOZnIJUV8OhP0MygA?=
 =?us-ascii?Q?mm4xjXx7uIvLJxPnPi4cUsD06UwmMlce57WReuIcOwlmrAW9xAlrPNMUzikv?=
 =?us-ascii?Q?8m6/ueENA3Dfu9scwZHI8k0sXgr/tXBlqcmjbZr9IRdqS9jkHxB9s+A0TqeI?=
 =?us-ascii?Q?WldWbPo20GFu1KM8R7FVAJ5VWFK/NuqgtymXyG3OHzPQBWUhHWTANgBb8c3Y?=
 =?us-ascii?Q?m/IW6naQTjQ6toIrOjc8xrfL7TKNTfk/WZamkxK9uzi5wFxaIHTEiIfYlaSb?=
 =?us-ascii?Q?D2ZzCmaCPRIGUNSL22HRWcCGxfHN6trCb0X1bfVx+4Wz6RreuMxhDs3oboHv?=
 =?us-ascii?Q?c+yAsk5qmGENiXiLrTTLJX/Mlp5O6KMVqV1USPMuJDXj4jZFFL3F+dCZ7pk/?=
 =?us-ascii?Q?Jf2nmNyZUqiWolL2BmGNoSfrRRvv21MOCXe2+nKNbvkdqYRODlC5shY12Grv?=
 =?us-ascii?Q?t7ukwueTdaiEySeS32Uc7YuDyQ+YXrLsvDGGEpn3u8VKU3BIcBUupl4R4LOu?=
 =?us-ascii?Q?/UUcD0JLuQq9Cm7hop/wPFlu5TspmkKNXwxXiAEhd+gA7Pgbo6XTjciNt3Ye?=
 =?us-ascii?Q?4AdfQwOuh1dAlOFHnMEAZIPd1pfov01NXUntSzDJOxS/OG7V4iqyhMeS/DHz?=
 =?us-ascii?Q?OWfrIdFb65r7GzISQDEh5ToX+fcVokJBJhT24Wgk8/VH6Ss/lre3qKF2yFIf?=
 =?us-ascii?Q?p1YeWCICRIOx/27tpspVQOPNMS8fnlnpDDutTvn70VnEWjdMI3T/2OiEpJof?=
 =?us-ascii?Q?xHMF8FI1nQTQxCxzv/SoF5SNNiy/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jgkFISWvx/42SygYtPczI9HRq8VkaKdVtQ0tlD96ON+OplYNbth49DPc8Y6W?=
 =?us-ascii?Q?TwA1GygJdM6F9+fc3GlYVSLqbEEKby+Z266cC4HpzQq5C8nu+X4ZZLhVSY3k?=
 =?us-ascii?Q?ZSJFV5VK8PD6XLVOhxc1JWOohG4vlAuYRpxRier50soZtEiReoXkEZrz627u?=
 =?us-ascii?Q?51FvzKyzrQw0wWjeuKZXLT7qBCuAEO59Hhxy9WSNz1a7W3ZWmJ4hcNwLURVW?=
 =?us-ascii?Q?Cv7hJASYnG3+BjK1Fkl82woI2kMpiakeDYmcfhCLwLhJm0M9F/q+7cYwGyh5?=
 =?us-ascii?Q?KWsnk7t30OKhI5FfH+gIG1k0H3tDjMJiHB2Z7eis7hytCC442lAK08vp6nLi?=
 =?us-ascii?Q?O0UV6PQB5nvyqueQHwBSD47DsY+RHjoOFbmzrnJz7pTPhZA8bWU3GWOU0hnZ?=
 =?us-ascii?Q?c0yvge6lZLA6gp74Y9jMD3EoMQg66RsACe4eX0LX5Ed5WD0ZrOMVTWatWL7W?=
 =?us-ascii?Q?4XLcCdgPxVlJktdEP2qPq+9LDIaYFJAoTsZUUbHGZPbTbncRBFsGBxTEBj53?=
 =?us-ascii?Q?/AOGvsb3zcUyXK8bLkSNAzrvRFolcDlidcvJJbPUyQEUqeEguo3JhiHgZivP?=
 =?us-ascii?Q?CIP49NMmZYx+7mId3+3GUz+7Hr86q5Ayr9Q+Yd1DUpvQLsRCBaUhTybnZJqN?=
 =?us-ascii?Q?5m3UZ+cBUOUJs3S3RRcVd7ons+mwyfnfwwrJx+BnJZp+jdZ8svB0LFZPy8ds?=
 =?us-ascii?Q?ihRxq3+MjAHJqY3/uXL1Kz5S+5mBO3Um2qI+NwwGmUI6MJWrkzZ49UEoy295?=
 =?us-ascii?Q?XoXpKidRfGNT6gZ76kDSG2wBgEEn7Ur44iQuz7AuLqBhq1RbwnK3i3UAsIy8?=
 =?us-ascii?Q?FJP83nkUC9jqXBqT/hmmKOkdWIdX3ZhcJh22sTVC6DeVmyCzE4EDx2YXyrsU?=
 =?us-ascii?Q?yNEWWHC+jYXs7v3uHdzyHlgWwnDwIexycAZPfz83SgowtkqQbmlV0ZExyUVZ?=
 =?us-ascii?Q?UCYJ8seI7mqlnbzuWoogVzt06Vj0FG0v2m6D0y01ydHAUx7AL2J3x8c2iNzT?=
 =?us-ascii?Q?w7yEeG3gJObvdluk5qHad+dJQ5avNqgbpZXp/OXa6SmueaTPJSzAACOgffPd?=
 =?us-ascii?Q?btZ2uSt7IsUr6+q7jBmeRS+OZvCdo7JAtXMrJNWHNLWuMGZwFu45qSzQTDhr?=
 =?us-ascii?Q?DBdb/E/FDZyqI6ec+FtvLFDCR5XTK16U8zeieBnq9o2Gz8i7HczIWkfn+ICL?=
 =?us-ascii?Q?4A6tggsF3etpV4DykYPfpldCfwe37Ac4rCwb9ZbaG5hBcDJ4WEn3xZ+9rqeR?=
 =?us-ascii?Q?aomoB1u31dlF4qzDcy8sEd2u5cGZNM7ttDqw6CH+zR63jXNj1cABIEZihvZu?=
 =?us-ascii?Q?UjrfHJws2lb9/P1xRrhn8HSKwbsPoMXgyafFFnUTYCFBK3qIkFbad3gV9eBv?=
 =?us-ascii?Q?42v3XKtrGRAZKYE3GjC8oDZYYef+zU3TiJiQCumq6Ss5aBUQotoBqPD3kUkN?=
 =?us-ascii?Q?6mDmz6dNNm1D4ecSkQWyoFfxcYYiR5cIxx95Nor/eWm0XDOkzKO1Z1GJve7n?=
 =?us-ascii?Q?crHBFQvcWlZUzo1OE+WaqxmbTTGfSKoBYg0/ZAk0rWzEdGRhIvCytxVy0jCu?=
 =?us-ascii?Q?62+cNLX+zoX8LGFWcAruuoUz9I9pHBEt4GTbWDIY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fb6d77-633c-4edc-b61f-08dcb5646b3c
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:36:48.1445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKsDcDURgp+WE/ykW7vJFoPfksBfGYC1ANLpNMePxWTDbKyrbwwKiM6cMUIDf8E8Iq8+ianaouXwTIgJ+vG0mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR06MB7322

One of the main reasons for the prolonged exit of the process with
independent mm is the time-consuming release of its swap entries.
The proportion of swap memory occupied by the process increases over
time due to high memory pressure triggering to reclaim anonymous folio
into swapspace, e.g., in Android devices, we found this proportion can
reach 60% or more after a period of time. Additionally, the relatively
lengthy path for releasing swap entries further contributes to the
longer time required to release swap entries.

Testing Platform: 8GB RAM
Testing procedure:
After booting up, start 15 processes first, and then observe the
physical memory size occupied by the last launched process at different
time points.
Example: The process launched last: com.qiyi.video
|  memory type  |  0min  |  1min  |   5min  |   10min  |   15min  |
-------------------------------------------------------------------
|     VmRSS(KB) | 453832 | 252300 |  204364 |   199944 |  199748  |
|   RssAnon(KB) | 247348 |  99296 |   71268 |    67808 |   67660  |
|   RssFile(KB) | 205536 | 152020 |  132144 |   131184 |  131136  |
|  RssShmem(KB) |   1048 |    984 |     952 |     952  |     952  |
|    VmSwap(KB) | 202692 | 334852 |  362880 |   366340 |  366488  |
| Swap ratio(%) | 30.87% | 57.03% |  63.97% |   64.69% |  64.72%  |
Note: min - minute.

When there are multiple processes with independent mm and the high
memory pressure in system, if the large memory required process is
launched at this time, system will is likely to trigger the instantaneous
killing of many processes with independent mm. Due to multiple exiting
processes occupying multiple CPU core resources for concurrent execution,
leading to some issues such as the current non-exiting and important
processes lagging.

To solve this problem, we have introduced the multiple exiting process
asynchronous swap entries release mechanism, which isolates and caches
swap entries occupied by multiple exiting processes, and hands them over
to an asynchronous kworker to complete the release. This allows the
exiting processes to complete quickly and release CPU resources. We have
validated this modification on the Android products and achieved the
expected benefits.

Testing Platform: 8GB RAM
Testing procedure:
After restarting the machine, start 15 app processes first, and then
start the camera app processes, we monitor the cold start and preview
time datas of the camera app processes.

Test datas of camera processes cold start time (unit: millisecond):
|  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
| before | 1498 | 1476 | 1741 | 1337 | 1367 | 1655 |   1512  |
| after  | 1396 | 1107 | 1136 | 1178 | 1071 | 1339 |   1204  |

Test datas of camera processes preview time (unit: millisecond):
|  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
| before |  267 |  402 |  504 |  513 |  161 |  265 |   352   |
| after  |  188 |  223 |  301 |  203 |  162 |  154 |   205   |

Base on the average of the six sets of test datas above, we can see that
the benefit datas of the modified patch:
1. The cold start time of camera app processes has reduced by about 20%.
2. The preview time of camera app processes has reduced by about 42%.

It offers several benefits:
1. Alleviate the high system cpu loading caused by multiple exiting
   processes running simultaneously.
2. Reduce lock competition in swap entry free path by an asynchronous
   kworker instead of multiple exiting processes parallel execution.
3. Release pte_present memory occupied by exiting processes more
   efficiently.

-v3:
1. Fix compilation warning and squash them into patch #2 according to
 David Hildenbrand's suggestion.
 Reported-by: kernel test robot <lkp@intel.com>
 Closes: https://lore.kernel.org/oe-kbuild-all/202408010150.13yZScv6-lkp@intel.com/
2. Update comments according to Andrew Morton and Barry Song.

-v2:
1. fix arch s390 config compilation warning.
 Reported-by: kernel test robot <lkp@intel.com>
 Closes: https://lore.kernel.org/oe-kbuild-all/202407311703.8q8sDQ2p-lkp@intel.com/
 Closes: https://lore.kernel.org/oe-kbuild-all/202407311947.VPJNRqad-lkp@intel.com/

-v1:
 https://lore.kernel.org/linux-mm/20240730114426.511-1-justinjiang@vivo.com/

Zhiguo Jiang (2):
  mm: move task_is_dying to h headfile
  mm: tlb: add tlb swap entries batch async release

 arch/s390/include/asm/tlb.h |   8 +
 include/asm-generic/tlb.h   |  44 ++++++
 include/linux/mm_types.h    |  58 +++++++
 include/linux/oom.h         |   6 +
 mm/memcontrol.c             |   6 -
 mm/memory.c                 |   3 +-
 mm/mmu_gather.c             | 296 ++++++++++++++++++++++++++++++++++++
 7 files changed, 414 insertions(+), 7 deletions(-)

-- 
2.39.0


