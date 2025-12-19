Return-Path: <linux-arch+bounces-15509-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 214C1CCE786
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 05:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C50A430109A5
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 04:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED1C27FB2D;
	Fri, 19 Dec 2025 04:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lbYwywo/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sAEdFnrM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F053A21ABC9;
	Fri, 19 Dec 2025 04:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766119524; cv=fail; b=V8VVAfio7kCcGk5NFTebA9Ol0MeQBCcAct0TUhtQqZGMjhEaF0BkyqvGBhEZ2G7HCkL7GNEEwkapX1FoK0sjIutyAe9hTYJH5tbWaLvxo3zqqEZWztOcGGICG1YdlZhWOt9v1M9lX/NrHymknLdXRlP89tWDvcaoxrkM5nkg4+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766119524; c=relaxed/simple;
	bh=cjW+6A44tqyQ95G0+zjuT6kV6aQpmOnE4FJYB6h8wGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oBJVPItxXa2FdJy5KhNE3DZtYhYXUMYeG7mffSDt1cznTeE3+dfMhnLKxMa/3kyTbIOtzif/pIAJncUf+Wqrxm24sDtm8BTUsTNZeeZRK9FwWXzidSxz5GgdPDT2oTtli+o7MU88/PXPb90hoR8cdKoCT9VkMVkjLpszLODyKzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lbYwywo/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sAEdFnrM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ3prgL2992370;
	Fri, 19 Dec 2025 04:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=uPGhbaYwg1/X3AmiO5
	OqglkuLy0B5HiKKqlSC6k/eAQ=; b=lbYwywo/u/kttWE6xWn7z9GaDpQf6kZDhA
	kN66FoW8Ack9IquTS/3TcxEoJSms1N8RakF0DTutS55DdipRg3sdwIuy7abfPhsf
	arJ+LllNUzk5FHLTb54+0zwcr2cHFcyHlh+951oUutIXc29vINBGENr1lys1l9K8
	TeH8XWVqIzPxkBH6jDNC0aZ1hIxPtlW23TBbQrdlkFEswRiBim+n8yGusk6n8JiA
	N2kLws98RSbqLFMl9TLaHGWUCJZNkHiyrOT4GtX/3DWqsXJzN6xXHZObfl/3RJQh
	gOEm2NhOHMY7JkwEW7XA6WirKr71fkNrxqLRqo6MRgOWrQE3zFdg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b4r288fkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 04:44:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJ4QQ8P036710;
	Fri, 19 Dec 2025 04:44:17 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b4qtkwpsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 04:44:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKvz6p9TS4PF7RHfmZQIsqhI4tUoBQwM+zpo4Tkyph/WME3n6G6hYsVIKlhfl4pLkhZ4WxbBa6jPQcvHOa2jEf4diwe/Ic7KN7F6Yl8SQEGLTEwakaDhdVYPfKLB2NEXiEkLoYT9NJUS3HFChzExD6A3efMs0j5miElbxFlDnZjxHlME5U8lvtawAj3aJljUqc23xi6RUeWItvq2RazYMgJcQZ2+KUze+wzDZFmK+A383bXiv/i5QYBT2oiSTR8EmKuBCtSm2QGngB8Ic8AsvxECp/c5+SmlUVtUz1um/0Fg2ArHvjAht6k7lu021Memjk1PEqQe36QvsuxN1ugJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPGhbaYwg1/X3AmiO5OqglkuLy0B5HiKKqlSC6k/eAQ=;
 b=o5XduiUWG2lUwYs7s6A7JfPG8167ROcLv3ox05+L//k1Pnc1GroM+2W8Caxp/qq9yZ8iwKagLBT1miT6OyBxNX0jeahl46Qjx1bMXtEoi1XxGNajtP1HwVKmFG3/2swzySd8Al3RggbXmGXtw3rqj3owY+ANK8HxzlQ5mkl16HVFuVQRfUkra4ADj8kg7lFxihpz7LWDNkmh5DTeqlfPzApbzBHU6EONRZ2PcjtPqDTl4PJCtDspouWqanH16yG6SY7461NWFdgJyg9GO3iGChlIjfO+uSKcjbfBboNM6BdJ3aTgCOe/iAX4qASRG5nTcEZZ5JQ1jCGYODiYxFJKww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPGhbaYwg1/X3AmiO5OqglkuLy0B5HiKKqlSC6k/eAQ=;
 b=sAEdFnrM1Cnmof8PciO0uVgrsKE7hmXk12sKV2PgeSwAbai2HJqcNUTBwh/WZ3W4OOBod1eoYDb+su5Rh0GyBjZpBSuKqTw+ck6Z9kIR7Zy+rTunwU4rCE6cSQOi8gHfqY0iuUDSFXKvOZInjXMcRfiswyKOyr2XPSnfjtqGhM0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7355.namprd10.prod.outlook.com (2603:10b6:610:131::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Fri, 19 Dec
 2025 04:44:14 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 04:44:14 +0000
Date: Fri, 19 Dec 2025 13:44:03 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        Laurence Oberman <loberman@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>, Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v2 2/4] mm/hugetlb: fix two comments related to
 huge_pmd_unshare()
Message-ID: <aUTYE9fHf5Fq3eHa@hyeyoo>
References: <20251212071019.471146-1-david@kernel.org>
 <20251212071019.471146-3-david@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212071019.471146-3-david@kernel.org>
X-ClientProxiedBy: SL2P216CA0147.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c97fba-9212-4d9f-aee7-08de3eb94299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LyvPt3bqBdvpX66HVsUeEu1DHKKdGKuP65KDXWe1jyCEClBLrD9/2S+urgyl?=
 =?us-ascii?Q?UQUYDoQ/75dhJedAKQ0iLyb3a0avfvthiGY/z39QSpMpUEMaX8hisodLdPOJ?=
 =?us-ascii?Q?Z5mEGXL4ux23VXaV88kz/6LJ7MsxWW73zInHIEpXUSdE2wGSVTDYgzKyTYOo?=
 =?us-ascii?Q?fLpA1T0ofAEj+SwU2TmZYHJCRSV1V8zeP8tXPI7HRbkHww//Ip+rD9fGLmLd?=
 =?us-ascii?Q?jNddt53sfypanQGHnhD8ICh5WkHuPm0fh8cX2Eobc5/yHK2qHmGQ/dFqp1Xe?=
 =?us-ascii?Q?3wlq1uImVC/goYFJShlfJY3W47kBuY9aqOsF3Qmv3OdC2GfyA1Wr4PsNmDnn?=
 =?us-ascii?Q?kwVf4ZNIw7uG1OWIk3vJX8xRA3fxzS9Xhv4KJXU2hTieLLogldxksmITQ1YI?=
 =?us-ascii?Q?IFq/nKF91fOod5/y+jkzFwjPWn5nnVe7AhHBTIG6thOT+jtUHgKN143C/xwG?=
 =?us-ascii?Q?HKYUMY0f8noT/RxHc03Ryy/W5Aa5+PhhUKT7NN7/EvXPWw6+eG7PC39txH0J?=
 =?us-ascii?Q?BhxBXHUTR0R9gy9NF+s9yxdTvGXiAqcjJSnhUyXA8lJMNm3NVjLaUAQXHyMt?=
 =?us-ascii?Q?vEpke/7gicwk+5tNo5M4FXJ7O4cIOG7Ibfkd/zLKvjsJPL1b0puXd99Cj+pB?=
 =?us-ascii?Q?Avd/qtR3JAdegRwLyPexPRx4QO40dL4GS/tLZpipYCNwwliCer2x4+q6uWg5?=
 =?us-ascii?Q?s7v5vRY2y+rofEhQMDO2h+7X7csio1c6ySdmh58TR3E5X+ioZ+2R5vNI9kiu?=
 =?us-ascii?Q?FEGiHWKAFugVXYBNA6jNhkdyfYsrob7gMke5Kar2BhjaYA4nqhnNmQ06UVSX?=
 =?us-ascii?Q?f5bOCtQL7mzPNCgAUi7BUabi1UQwH63jUggnfHF1vdJccYNftEtjmlke9tNW?=
 =?us-ascii?Q?WqfId04C1DhPoET8tZb9QONDt3iV8adR8nzmpppRvcpHwqvLWfMQH9R18ZqT?=
 =?us-ascii?Q?7ehMNalCWRHkeGs3G8Gy0FhgHOxunIFV5HBILLy/j9tkGHzo4jQRjIrKPbrf?=
 =?us-ascii?Q?MakZ8zt6RczHRXDNiF2lpYL/e1eQxqJIUFkHJxzHupz7DvWiwexP2qyeaLSR?=
 =?us-ascii?Q?oqbwlTZ355NQ1PVaUJYSHUx3WtlPI+vtXvP/O6M9valIEVkSfTFBiHUzNDt4?=
 =?us-ascii?Q?2AX/efptyeLYHPM5l2ZQM8eMCLRz8Pk8DajUdGi7EcsZRhK3QDOqsOokgWLr?=
 =?us-ascii?Q?ONsXZTqYbp2PhHUub0On5huxp+UtVdEHLaIDOqQUhY6KjFPw4jjb5TKKkS4l?=
 =?us-ascii?Q?6r8QQ4JVGFzg0EYQqCr6J1I8gDXLUYkS5lOkKOcanSCO+j9JfMST39D0KEXi?=
 =?us-ascii?Q?mDmwannlhq0VRBdJwl+7Q8XdkX6NxwfLwFHtpEAKPddll6UA4TeWlOPHTe+R?=
 =?us-ascii?Q?NGDAP75h6UJmxxxJx+/2mk7Ssv4oL7vFtW5XOrhWp+zte23CQd/wz1IWgu8y?=
 =?us-ascii?Q?ofM6F5kc6ukryH72+Blpp0Ml+KUQe3Pv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8SVsHShSVPMAmOQpZkAQCBDS8BvKicbfQ+AWElnA4EO51owCe4hKjdgZXs/b?=
 =?us-ascii?Q?CuaAMR5XaLvj0lNzV4MO8qyfX0pCNNjJQzr5ry2d5ahQY50tLVUbEqwsOqko?=
 =?us-ascii?Q?xTQ/kK+UrowiH5CVtZg8LCExqaUjOIznZ0l4CYVSWbZJIwPHjgiBv65/Cc3u?=
 =?us-ascii?Q?NegkBddNSlj3efkkRFRZH45MXxRagcrgwHxVyUrIQcqNKjZg2UOjbmWojAfC?=
 =?us-ascii?Q?mdsVOvN3T3sE/TKJB672PmczcOrOcDAH0dIhuduxFa7HHlJBIqEq180ObQ3W?=
 =?us-ascii?Q?iv8G9qb57YQM3YASQnmEtLspqMJJLhe7hPuPWUGWUg+RWaayRhWVXZbZAruc?=
 =?us-ascii?Q?38zq6X03jDZ/ogNUVa7RvQ+B0p6bxGXGnsI4MIEr1GZO1uyEt/BJ9oXm3qyU?=
 =?us-ascii?Q?pNcI7MzAGfaYIPI6gNicF1aqVJiN3UlKMWC8ezrJSI+A4jK/SxIrC3qMFe5f?=
 =?us-ascii?Q?klxBRB1hEFcsK1sIJZmHgcCHcbSUEQKhpz4Jkn2he+a8aVyXGPZp50TCJ5/b?=
 =?us-ascii?Q?3vnHlMUso6mqRROxxxTv4d8RxOxa6BXo68UT4czSMuSiAtVF8lCz/77lsGWb?=
 =?us-ascii?Q?ImmjnWqm1jU+vIyotBWNJXbIRcgtPWWPJXkVlMNK0UvZP63v0UiOJgJY4f5U?=
 =?us-ascii?Q?k8ycaLPkER1GxdrxHzArqWMUkBpBDGyIEJmMedMvBqIddFp6MSArKF/IVxJG?=
 =?us-ascii?Q?PnbzvYSyUzpNqwTgzRPNixrzNI3KCnwqGydjUwup3O9pdxL6dsHoRheb9gmV?=
 =?us-ascii?Q?/hNbJsXQzBumt5Gtp9FOG2zZmjE2rA0rEP2caBRZtczGXU9ZX11K942CwX/+?=
 =?us-ascii?Q?UCitsHVAhPwKUTpljRHTXrYVYiCH6uCZWuQ8sURUpaqH/IR50I0KinjLAxz4?=
 =?us-ascii?Q?n+wVtCGcCQKIcmT1wZ/+JiJg+523pL8y+s2PrFUFCMZk7mv06nZCT7wWtkLY?=
 =?us-ascii?Q?SzT0QhaNzSqjXNedScHIl50meTsGU+jw4LE9+5MmzZlxxoc+GEM6zyD2L7qF?=
 =?us-ascii?Q?mabvcUG0lDrN+hcIQPoiJXpSfNA4vi76K97pJsxSdK/RPHhje4gNsq+RaKi9?=
 =?us-ascii?Q?y118UMGop9NLmMpldbdltRgbR/uPrP8NsPPB/n9w+AYVpHGj4eaXpxTtByv5?=
 =?us-ascii?Q?D1q8McxxgLgU8h3J5GlZcA/bcva1exTUvih7CQQXYO15sH7s8GUrwSIljHFw?=
 =?us-ascii?Q?pUAjeeuRSwqG8xb0mf5BJAyqW9UWF/cOMYbBoCOsRHaDvkOKsXgMnW4ZXmf/?=
 =?us-ascii?Q?fk6I0BE+zM6wOhhZ+GNqwI8BF9KnZxqZ2L8LiF2g7dejgyQGi2T3Vp2PFmS1?=
 =?us-ascii?Q?0IzcC11GuMuPhOTueBZnngSwZjU+LPRIUd0v8/IRfzJftLW5cuJg9DYX1MAH?=
 =?us-ascii?Q?mAkGu2oICaT9vWZ75KHnQ/siWuEtiJLnvKburc8E9b0fqmu58I/HHezFVip2?=
 =?us-ascii?Q?HHIMHAq3CqgB7Gs3kP0GKzgj+89Aa5lWY94t5IqCPCxDgdVx0bKdPmO8kWl+?=
 =?us-ascii?Q?knaBjTqAiycOsSuw6FVXsoQfUdgX9Wgp1/AYeQbLFfV/yIsRrKOAdfFhTgVT?=
 =?us-ascii?Q?F2Q5E6I74suUBub9Dzw6tfjjX8ts7hrm0W5nK4J9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vs0Zsp7qusWWW8ezb+r26lM6PfH2gyGQjdsTWSxNZf+KJQVm1YQc4hEpVKsegwqP5CSMU7BTuCPzQK55hJ/k6c0ffmGfw+p4Zb13Dlbc6p5cIph9WX4by6wP6yAuNlK4Dxahk9p1sJeV4IiBUIPdOC8Uh0TvWwJw7shLkVwA2v0KLGNlcaax5QyKpEsqWrJ2dhYHeFPpCEnCmM4AqeFJc0+50MQLrsjlG/SZKJiKfBZMp7O5MaVIZ24RXR05WszVazRRmYPd8zVP0+AEL8k6n8GLPBae5jyHeAixS4unkHNPML+ivtDka63Qx3EF/Uiwg1ubJIKa5CGhDepDslHisei8zBmmcwZYwjhWRmyMqxNHkpxcCDaIFP6NwKEzYJCjmHM9cO0KNeSbqH4575uFKzqOJHimnFbDTzTpW8sOSGwBqHIe+UuNXGAbJdEQFAxkV5ZQ0bZvLNXNkWn3RS9jtLTyJdg+59qRtNz+IpsNtbRRXZVh2EXJkgkff+rT7NRHtKPTEjB76qCMWXkFqZ4GwiJyvT83pEeKU9G7ocZYc0o6NVSzVqlDCVjlIRHcNAvn4KB8Ou6k0YD2Am+NcPH+9rZIcwE9EzqIM+ig1EMaCIQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c97fba-9212-4d9f-aee7-08de3eb94299
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 04:44:14.2325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUTgoKXuS37PyB12N1mSQYc1STXix+d3QutEAtNeet1tiNoFrqGEdGbo6Q5TwkKFA/kCtEeCSTC50qsp1/Ef9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7355
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512190037
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDAzNiBTYWx0ZWRfX3Qg3h80qLBtt
 Q6yCMMTFjPODt/CjWs/GYzFVw6J71QNZmZgIIWnKQh3hNn5mrXiJhGljtMG5Y+S/dSGG/eV824h
 eGqA4G/9NehPlUG0uHuAy9/SQxIjqoaAQ0KvDlT58kqMPRBKYicL4FxODl88dxFk3DeVS9HgWVZ
 5LF2WtfrIvRh8Y4jqS0DfLiuMCoTwepg8NJC5Rdz/Hj6uBImk+nfY2DCZYWoKCJFZwV3IXaEUqr
 ueu20KqS16IFrrFirsJnCPHVRwZ1vC3Yj8tCTtfM+pLglWvPwkPRXAf4AB/w9L5Mie8Qnk0KkaJ
 u+MK9mbzbHVcxynAU92j1SU5Jh+Sx1RXFu/i/RHN2iucPF5QZ7cn9C/tWk6bOhJca7T+zviCE2J
 MKNhaVZ7YKp28P4rmQZCjfNo+nCEH2i4/305ErgkgUsle6apglSxnA3t4IMD6nkt1HZ8e4KA3Tz
 JflqOk38a0cCsfUgLGHdoN8+3gpJgyYXMAQoITBA=
X-Proofpoint-GUID: Xn4hd7xgKKHU7zf3tOIDRrWrmbvqoHLq
X-Authority-Analysis: v=2.4 cv=H/nWAuYi c=1 sm=1 tr=0 ts=6944d822 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=fwyzoN0nAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=i0EeH86SAAAA:8
 a=VwQbUJbxAAAA:8 a=Ofkd9XiPHu_652w-M50A:9 a=CjuIK1q_8ugA:10
 a=Sc3RvPAMVtkGz6dGeUiH:22 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: Xn4hd7xgKKHU7zf3tOIDRrWrmbvqoHLq

On Fri, Dec 12, 2025 at 08:10:17AM +0100, David Hildenbrand (Red Hat) wrote:
> Ever since we stopped using the page count to detect shared PMD
> page tables, these comments are outdated.
> 
> The only reason we have to flush the TLB early is because once we drop
> the i_mmap_rwsem, the previously shared page table could get freed (to
> then get reallocated and used for other purpose). So we really have to
> flush the TLB before that could happen.
> 
> So let's simplify the comments a bit.
> 
> The "If we unshared PMDs, the TLB flush was not recorded in mmu_gather."
> part introduced as in commit a4a118f2eead ("hugetlbfs: flush TLBs
> correctly after huge_pmd_unshare") was confusing: sure it is recorded
> in the mmu_gather, otherwise tlb_flush_mmu_tlbonly() wouldn't do
> anything. So let's drop that comment while at it as well.
> 
> We'll centralize these comments in a single helper as we rework the code
> next.
> 
> Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Tested-by: Laurence Oberman <loberman@redhat.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Oscar Salvador <osalvador@suse.de>
> Cc: Liu Shixin <liushixin2@huawei.com>
> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

with a question below.

>  mm/hugetlb.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 51273baec9e5d..3c77cdef12a32 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5304,17 +5304,10 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  	tlb_end_vma(tlb, vma);
>  
>  	/*
> -	 * If we unshared PMDs, the TLB flush was not recorded in mmu_gather. We
> -	 * could defer the flush until now, since by holding i_mmap_rwsem we
> -	 * guaranteed that the last reference would not be dropped. But we must
> -	 * do the flushing before we return, as otherwise i_mmap_rwsem will be
> -	 * dropped and the last reference to the shared PMDs page might be
> -	 * dropped as well.
> -	 *
> -	 * In theory we could defer the freeing of the PMD pages as well, but
> -	 * huge_pmd_unshare() relies on the exact page_count for the PMD page to
> -	 * detect sharing, so we cannot defer the release of the page either.
> -	 * Instead, do flush now.

Does this mean we can now try defer-freeing of these page tables,
and if so, would it be worth it?

> +	 * There is nothing protecting a previously-shared page table that we
> +	 * unshared through huge_pmd_unshare() from getting freed after we
> +	 * release i_mmap_rwsem, so flush the TLB now. If huge_pmd_unshare()
> +	 * succeeded, flush the range corresponding to the pud.
>  	 */
>  	if (force_flush)
>  		tlb_flush_mmu_tlbonly(tlb);
> @@ -6536,11 +6529,10 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  		cond_resched();
>  	}
>  	/*
> -	 * Must flush TLB before releasing i_mmap_rwsem: x86's huge_pmd_unshare
> -	 * may have cleared our pud entry and done put_page on the page table:
> -	 * once we release i_mmap_rwsem, another task can do the final put_page
> -	 * and that page table be reused and filled with junk.  If we actually
> -	 * did unshare a page of pmds, flush the range corresponding to the pud.
> +	 * There is nothing protecting a previously-shared page table that we
> +	 * unshared through huge_pmd_unshare() from getting freed after we
> +	 * release i_mmap_rwsem, so flush the TLB now. If huge_pmd_unshare()
> +	 * succeeded, flush the range corresponding to the pud.
>  	 */
>  	if (shared_pmd)
>  		flush_hugetlb_tlb_range(vma, range.start, range.end);
> -- 
> 2.52.0

-- 
Cheers,
Harry / Hyeonggon

