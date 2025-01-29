Return-Path: <linux-arch+bounces-9947-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CEBA2159C
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jan 2025 01:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 848BF7A27E6
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jan 2025 00:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43DA15666D;
	Wed, 29 Jan 2025 00:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DVg1kktT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XPKuOSBP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECAA15534E;
	Wed, 29 Jan 2025 00:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738110382; cv=fail; b=ABohvOb4I656sSh1XqbpibAugUudmnuBMsom3E4B5PdrrQZ2eC1b9tBMStR8zPzXb6oqAt2GjXDT0pfzS49Ai2ywxE5TWL+JF00lN8AZB/JD5KNxGLzZUe2NwYe/VuMsg/OsIfLx3EQrh89w271x15ifp35Hc5XFUGoBExPCP9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738110382; c=relaxed/simple;
	bh=le8ntNCnvkHYuvtHvMiDfr0LAy7EiKFJPcaSEcHeCzU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nIIvYPz82Yj6WvHu/cLzXN9XSoBbAnjFCf2uWVOCERTlx2IWOzSmEMjA1cxpsl1cbZYup//krzGhbXf2P4AkElcTWCDK42nLjqAA+1v8/vWgalaiYz7kHFpTGxa6awZQCn4vPN5rNuM/48Occ3grnbfn4hgz15x8smnRyHWRGtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DVg1kktT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XPKuOSBP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T0LjYU004454;
	Wed, 29 Jan 2025 00:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/GMZn0Iw6nGNs98AGVYoinS7avOpiSnBrB/2ox6yHfA=; b=
	DVg1kktTszrOtL5lZoT+dD2tkDVHldWvly/OoH6TOza3CNHbaAe9/1KfuPX8mU/S
	178lAPdvSOyat51JH8r1MI0o2AqjNJ8DfRz2QFmlFujrHkYNdbrdMe5hCI5LlyT1
	YH4NKatVlHAFJEUUXenqr7y+Jy3znRmT7XbjA6Fod+vGnNHdDC/J/wWXCIMXujWK
	igyOgPzvQAy5yKHnE9vzs8qdAtQ02OMG8jB0flrOHyTFLV9Mth9OssAj67jM4G2I
	CNR+AAQo5q76y1bmXOa732n0RLPMYouYks8uix0vM9R2KHFlZ5Kl9ol0K3L6viJQ
	mkIOH+O/tj5eyRBG1CqEBw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44f9qmg04q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 00:25:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50SN0bbH036375;
	Wed, 29 Jan 2025 00:25:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd91uvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 00:25:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMYNxRRMuRHltXwqXmqY/SQ0DPg1UuyOgVudsRsqyNJXaEycF/H+70Ph8nC5YM7Wx/OqivT+InNbP0KEZemrUaMsoyUnxSnCIuxr8JreQe7q4e34cXu3MIVJYNM59AwHqgXb5q+QD2tAustfAZO8e2xw9jwPQnIUCQR3rrV+rPDhfhgYH4EDSuvkjfOZmXZTtHDcbw8hdnlxjLklrMdm1u5/DOck5bE7nAoyE/czuKLvuH6DSv7EgikWWsnBxyVEeRL9NPaco7nre/8Ug1LOPHQvUILdzaExIJhlweV+WGDTxh1Hhyn1ZoRoSoiObW69+SQj1IcVjTTZ8GZw7XHX4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GMZn0Iw6nGNs98AGVYoinS7avOpiSnBrB/2ox6yHfA=;
 b=q1Ls2Ui+ieLzeXIJAoFTAR3WdiN+i2HUzog3rXmV80/FZpamUWhDPGvNXaH5eWSE6ELRMEd2wKsu0Ic0kpg5tw2bKTCh5raB0Ip/b5pSZF4jC4xtRp3X0cV73rYmvvjSOaaEgxx3GsSAdXE02oZk41psmNaEjAh3lF7R8ZAahYxBj3yaIXAT8ZYgR1UYXPs4AJyXoGGfvEMwhknI6cD0UePmBbyNmlE6WwpRtg/ylm94IS/63JPI+gQuD86TJnsha58meYqrksLgKIxbsvOpLt3GK8byAtL8823HPlqXE1km2QWtLE5ulTA+/RKOYPBYPIOWidqCmZrwsodRhOytcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GMZn0Iw6nGNs98AGVYoinS7avOpiSnBrB/2ox6yHfA=;
 b=XPKuOSBPrbm6siaY9zy3i1lfbrDjAfP7CweDZKrb9dOgUCZ12hu67SK0sfBIa/APJbH+zAmmv640gmuKuUESTSr6xTvv8TM5mwKn6heyvkpOJlUZM25KGOcbqN8g+FbWQULa0hOIwsX/EiLkkgwrTW3+izBR5CDAs1r2hyY8n7Q=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by SA6PR10MB8087.namprd10.prod.outlook.com (2603:10b6:806:434::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Wed, 29 Jan
 2025 00:25:27 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%5]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 00:25:27 +0000
Message-ID: <92f188ed-4f47-427b-b8fd-2c0f76ef129b@oracle.com>
Date: Tue, 28 Jan 2025 16:25:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] Add support for shared PTEs across processes
To: Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, markhemm@googlemail.com, viro@zeniv.linux.org.uk,
        david@redhat.com, khalid@kernel.org, jthoughton@google.com,
        corbet@lwn.net, dave.hansen@intel.com, kirill@shutemov.name,
        luto@kernel.org, brauner@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, catalin.marinas@arm.com, mingo@redhat.com,
        peterz@infradead.org, liam.howlett@oracle.com,
        lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeel.butt@linux.dev, muchun.song@linux.dev, tglx@linutronix.de,
        cgroups@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
        vasily.averin@linux.dev, xhao@linux.alibaba.com, pcc@google.com,
        neilb@suse.de, maz@kernel.org
References: <20250124235454.84587-1-anthony.yznaga@oracle.com>
 <20250128161138.066f6c27d0d941609ba1c1c9@linux-foundation.org>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <20250128161138.066f6c27d0d941609ba1c1c9@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::30) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|SA6PR10MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: d7fa5e6b-48ca-4836-8088-08dd3ffb6e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wk9ZRktEazYrNlp3eDlwS0hNMjFuQ1JUSDg2Wkc2anVSeGxsOHFqSVplUWE2?=
 =?utf-8?B?cmhIZ2hCNFdyOUJjcHBYOUlJc3lkZkVHTGNCVXZMT0JITldPMWVIdC9OOXdn?=
 =?utf-8?B?MHEzbUFRTUYyYzQ3c3lFUDJVOGtkbktJdGlOWkVXcDZ0OHorTXZZSmY4eTBa?=
 =?utf-8?B?TEZsY0J1d1pidHZsWjZTdm13akZUZ3J6YnNWNnJxSzQvbVNMM3ptWkNYd0U5?=
 =?utf-8?B?SXRaTVhPbDN3ZHFQdVp4eGJLZFAzYks2NkJJa0VlYmhoeThHd3g5T1RsQ2FE?=
 =?utf-8?B?WjZXTlZmb2ZIaEFYSlZhNytMdjdYYnRwMEpvbUc0MmxYS2RKSG9ZMlExT1o4?=
 =?utf-8?B?Q1F5Smtvb1VRYjFhb0tCNmNoWDlDZ2hjTnEvb0lGR1NZWEJSSGEzUzVjUDJJ?=
 =?utf-8?B?TTN0elNwc2I4WDJkTVFkRTRUTGtDYXR4aWxVYU1NV2lkamNicHRmTmxiWVdv?=
 =?utf-8?B?ZFRUM2ZKakZFOFdwUzZvd3l0VU9saWJMeFg4VnU2aU5hOG5rajk2Y2h6MXZF?=
 =?utf-8?B?OTl1MnZGMDVRemZtNDJkK1pYYzQ3UjBPWlNqRUErS0EvUUZ5cHZkOGQ4WXI1?=
 =?utf-8?B?ekNSVzA5LzNGR2VwdHBlOGRiMDVSYTI5cTM1Q1ZhdGRieUJpa01wUzBadk9h?=
 =?utf-8?B?UnpiMlNuOWdVczQxREtCZnQrM2hLY2xNaWJOTkdzeVZmWW85bFhWWHg4Uk9s?=
 =?utf-8?B?MUJtUUQwMnM1WjBXdEl3NEtETEdvamQ0YnNwbXZ0akpBbjd2dHY2dzVyZHFK?=
 =?utf-8?B?L0NCeGdDRmRpSkFoWHRXTEh1Y2hZZHhRQUk0SW1qUlNtR2R2NzI5ZFJ4T0hn?=
 =?utf-8?B?KzZtWGdxWjVOSDZlckt6cjdWc1h3bTFvUDJFVW5vK3FnTlBNMjJMVVlIeUFp?=
 =?utf-8?B?MVdUdyswcUVUYVpkQnp6ZWRHN2g1MzdTTGFRRytKVWpKS2RkNXlhSENtL2hh?=
 =?utf-8?B?eVAxTG9aUE4yd0IrN2R2aCtrRVRnclkwM0hxOU9HYmk5WVZ6a0dsUVBUSERS?=
 =?utf-8?B?SWwxKzk5MzdrTGY2a2JHdnBSbUlCakRaRXF6VE9LS0JiODRMektCVkJJVTV3?=
 =?utf-8?B?cWxjQVhRY29Za3RUd2hpMnFLSDM5eEJBY3dZVjFrQjZBaHhMa2lOaGtKR09V?=
 =?utf-8?B?eVNtSjBwcEdPbVVrbXViZUJheXZzMEpnYVRiQ0hFRDNRczVHVlE2R2RqVHVz?=
 =?utf-8?B?RWM5Vmw1N3Zia1ptTGZtcnBlM1RnMTgyaE1LWEl2TUhxYmZiYzN3NnVBR1BI?=
 =?utf-8?B?TStTc1V4SUYva1VUeWhERjJqdUg0TWM0OW1DRWx4b200SkEwT3UzSk5rcmFG?=
 =?utf-8?B?WUptRWl2TGJQSlpXTlRXMzk0SHYreEhOa3ljenliMFlTWEx5LzNVQWVDZzRB?=
 =?utf-8?B?WklGUHk4eXJtSHhTR3Q0cmNkS0dITER0ZHk3dzBtRzJuamw4dGxOMDZJcWpS?=
 =?utf-8?B?Q0lvbVprWU4wbnluQm1lR1NQR1JFZHNVWGhKaVNac05DYnRHQzd3STQzSFlw?=
 =?utf-8?B?T3F0TGpCWFd0SHo0YXUvdWhkcFg3eklzOEZHRlN6S001ZTlGcHVUZ1FZWkpi?=
 =?utf-8?B?VjRobXlmVUkrVG5NVkMwU1BmQXdUYS9meUt0ZWUrRzFUWWE4QUpEalVvVzln?=
 =?utf-8?B?RytEOEh3ME54SC9JTnJlOHJ3M01UNTNINm5RUXFrL1Q0aGFoV1NodmdwMGxM?=
 =?utf-8?B?dmNHNGlxcTlIbEM4bTJmMWtzRXNtSGljS3NCVVcrYnRXY0NLRVJMN1BqM3VK?=
 =?utf-8?B?Kzl2OUpYQUpsMGRnZUx1TzZ4dm9jZkJtdVphMTFtSXNibjhOVnlrcVpCdWxH?=
 =?utf-8?B?KzYzZ3dTM2ZYakdQNzVNOWlIUWpiT0VQMC9lZFNWdnRhMWxjMmwxeDdsZ1cr?=
 =?utf-8?Q?hv1v2n3HM28wr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGlxTURZMklLczZzQTVUWkQxbmdzaStKcGZVV2FFOGZPdFlKdFBiWjFZMUhF?=
 =?utf-8?B?MDBESG5qTHZZVWtaeG9hWGZZMXpkM0xnaDNLT1h4Vm5UNU96TnRBL1dyOFV2?=
 =?utf-8?B?akYzbS9nUmEyeklzVHVSWHpSUWh0R1JBZUZHTUV3MnRVd1c0VHZZZ0Uyem5Y?=
 =?utf-8?B?YzJhUFdPQWt3YkJZV1U5RTNrRVIyWWk5cFd1SDVoMk1jM2Jqb1FyU1k5c2No?=
 =?utf-8?B?SjlsSndYNTk5RVdFMStwRTFid1lmMER3SjdJTTRsVEZzY252d0hZSFBFUnVK?=
 =?utf-8?B?OE1Oc0FvcWxvMlpvU2J6bCtlK1UrRit5dVpkdjNWR0EwWGs1elFZcTBoMENt?=
 =?utf-8?B?R1ZJZmcyY29uWTRXUndON21sZWhSQzdZT1N0WHFPaGVyMXlzWndwMG5hd3VF?=
 =?utf-8?B?amcvSmpaU2xnRHh6bWdHVlhIWnpjUzdQRWlUa0drckU4akh3enMvSlZYeW5q?=
 =?utf-8?B?a1MxN29kWXljYWVqR0x6NHI2MUMvTTRCbmUrTllwdzNua091WjRzU2RhOG9R?=
 =?utf-8?B?NVlDcTM1NHptZkEyRDFkTXpicnVOeSs0YUVSdkp3WnhmSE9LakpwVG1GQjVY?=
 =?utf-8?B?S2tNdnpmWlRIYitqNGZBNDZhYzJ4czE2ZDBFVjFQUTR0dXFmYUlSeXJNVEVj?=
 =?utf-8?B?R2FkQ1dJdEtKM0FaNFlORjgwdEhFSzdjV255WTlOVTk3eng1dG91bHZraEZV?=
 =?utf-8?B?WlBLQXB4NThWbW5JaHdIZFJmS2taWnZJay9XdFVzWTQxa3p0UnAyY2hYM3pW?=
 =?utf-8?B?OWlVU3BLb051Z1Awb1c1T2UvamlIVWkwZVBPc2pUdElFbU1ab3Y3OTFCcWtx?=
 =?utf-8?B?NEZZSkhhek9KRUhBOFoyNytyU2VSSnhHdHVrSVRsbGVydzNvSVBlc1B5QmM1?=
 =?utf-8?B?TUs1cVluZEg4Y1gxTXIraDNrajNPOXZ5TGl6WFE1aDc0WFZvOEZ3SVlVS2RW?=
 =?utf-8?B?VzNpWndNRTlUTkZrVlo0d2x2VW1ZVEZLVGtaanh6bzZCNjZ1dXNxaFU1MTRZ?=
 =?utf-8?B?bEE0N045ZEl4YVBzdHJVb053TC85Z2hBeTNSWmN0TzQxa0xnWXpjRnNhWGdT?=
 =?utf-8?B?TXB6RDlYRnFDeDdpbUV6ZlBzQUNCb2ZLdVZWNCthZnZ3ZTdWYzIyVGwxd1RZ?=
 =?utf-8?B?V1lrZk4zTHR5c1p0L2wweGlaQlZGWjloRnY1c2tGZ2J2SFNwZDlDZ0tSMUhw?=
 =?utf-8?B?OHNSSklRYXkvRkVVQkJBUEo0ZWs5QWJiMytIUkFaSTZXVmFUejhUMVkxa1pP?=
 =?utf-8?B?SUpXYndGWGdTUHBQY2d4UFZWSUpHdkFkMkI4VzlyMEFUckwwZWRpNkpnY0NM?=
 =?utf-8?B?UXExT3l2RGwyYTJVaDFlY2tCd2RUeDFmWlNkeFVRMS9tL1hSa0I0eGZlSVhx?=
 =?utf-8?B?d0FGZ2JZMWpnR2ZkMnNhU2RSdCtMNGd2ODRHRVhJMm1BMVNUaDNRMG5IaHpI?=
 =?utf-8?B?N2hkc1FibnpvQlpOVWl1b0JPLzRYZnlzazUxVkdIaVpsWS9wbEhwSEx3Tm5i?=
 =?utf-8?B?ajF5N1ZWeU5ROEs0UTFIa2RWVHhVWnN4UDJRNC82OGtHUzJqamJrcGhZTXFh?=
 =?utf-8?B?UFMzYU1ydi9mS3E2SWlCRFBvV0FCaCtvSUowSGNmdWlpdXVEdDNxRU8ySFdB?=
 =?utf-8?B?VVdPeEJEc2FnU2xyaktRYjdLdFVjUHpKa3FWRTlON3RONTRwczFTNnVVbFBL?=
 =?utf-8?B?ejhvSVVSNXlDOFd5eTRIQy9KcklWTzVzVTRFWTExSUVEUmZmNE5iREpGNFUz?=
 =?utf-8?B?NXJTMnB3Q1Q4NjdwbW5FVThZYXNTT3QrMTAwa1F4NUJuUWNOaUdhYUY4b3c2?=
 =?utf-8?B?NEZ5dU5TYWNCeUZWaUFGZ3Y2ZmJaK3d4VHNoTG9NTzRvc3BjNnduMzlYcm5R?=
 =?utf-8?B?S3cybjY3MEo2VUpRL0krQXNzM1BiYm5LYU9UNDgvckkxVkJ6QjJ0QU12Mjdh?=
 =?utf-8?B?UzRyNi91aXg1VURWdFljWTR3Ui9MeVFMM2h1N0RwWTd6M0RCZWlKYTJEQ0JB?=
 =?utf-8?B?VkZjRkZhQjhwMkVaNFczUDA3OHBudDI0Y01CVmVPWmNrZVB4UldIRmRhblNJ?=
 =?utf-8?B?Z2UxT3lpZWZRYmp4aThJK1VJaUpzRVEyTGlGaXIrcWlpRGdDeXdiekR2RXdp?=
 =?utf-8?B?Y29IcFB2MzlCU0ZtL3pQLzYzS3NZQnBCQWZwNDlQS1FnWFROa0RLZUpEeXhj?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FSw3eYai7uUxhZPjaJh9iJme2eu0g+yYtvjFJoEcfMia2JBmIVfdbZoft6+mk/3R5y47G8so6LJ9y3hf4o6k4z0HY7lzXvdTXzbPNJhSLVebxgfVtvYXjlr8kbcYLfgPdMPPBIA+gqkox51gbiClEeg1r3Ig7gWcoJaIktlL9CHVesSR+JHRdlcn60+XWVHZBES2wSXqOab7cdRjiHP2DDWlM8nSyDck6Y8brL96YppDxu4J8Md7CE+G3DzEIReg7UjqYF1jwoXcx/zgrF2pfUkusCW3bdfC7yfimzSirAyc0TnolVGhNnv/X6VehzGaA7FMkPzRMRtij2ry6OpAyL5AfjiJMe3NrD2ipMX0VX5F2b3s7C+sfrxLasOEoldnQJYgh8giFsOahHjalPFLhi54yD5SCx+m01a+cnaMIr4NxDcnGd75us+fi3ZvytXsR5lK6ExeKpfXpjLLxFa5Tf7xmdjfogjnypM+kWlsep7uZC2H530q9Hfsl4A0fCAvctc+0b7zUu3QznarkvoeAnYnGXoAITUCBdWmcJa31pEq252xZIZGLKap4rJ4+G/UDjvLK1QWyi+maV/Xc7aqOYEry8mXQBrhy+zOmtREzNA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fa5e6b-48ca-4836-8088-08dd3ffb6e00
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 00:25:27.5829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZbRqr6kuIamuucLM1A+EBmdY4OPf/4lM8jt2BrSsRb+/k2/FjhX+JoT6K/2tbe1FREPRcFmFqU9XA0EAXXGiaIMgfhZIZ+uFTmMLd4ixP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290001
X-Proofpoint-ORIG-GUID: bDqHsfSfbQGqUFG9zfUvhqUbqWnA_liD
X-Proofpoint-GUID: bDqHsfSfbQGqUFG9zfUvhqUbqWnA_liD


On 1/28/25 4:11 PM, Andrew Morton wrote:
> On Fri, 24 Jan 2025 15:54:34 -0800 Anthony Yznaga <anthony.yznaga@oracle.com> wrote:
>
>> Some of the field deployments commonly see memory pages shared
>> across 1000s of processes. On x86_64, each page requires a PTE that
>> is 8 bytes long which is very small compared to the 4K page
>> size.
> Dumb question: why aren't these applications using huge pages?
>
They often are using hugetlbfs but would also benefit from having page 
tables shared for other kinds of memory such as shmem, tmpfs or dax.

