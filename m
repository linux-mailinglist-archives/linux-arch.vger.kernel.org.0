Return-Path: <linux-arch+bounces-14688-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC9CC54C9C
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 00:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D2B7234619F
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 23:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9022C159A;
	Wed, 12 Nov 2025 23:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CqoflFi3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lMrETkZw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB06F232395;
	Wed, 12 Nov 2025 23:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762989491; cv=fail; b=Ydl/XJEDb0vFpxQW9i2wjzDw2g5jfP40fbdm6knei1R5l1CnT3PB1XhVE5r/DtvttOdiVhcB2hd6drojevYGhREILMrCj2qZBhzsMFnWNm4FfQJUTXY6VK/MRWixE68fvYAipUAD9MLdUbmhiD8rU4tDW/nYMLT+b8DKoW2IwBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762989491; c=relaxed/simple;
	bh=a2b+L4ANRKZCoJPqWZ5/AD/jhS0i30L+EK3qt9y/U4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V5KM2J2bjSZp4ZdLkZy8RYMWCBYT2RJjjGvIeiSM/zvoCqEJPNahRTNpXnk2JJlDbCkkhYYlJ541TdycvBGCyEFIv1XsyKCiBkugMhTCxFSYVgTbifgY6WHYlm7FcoNbCWt1scuQ8RXcEvEaQCfww0sAtU7QcdMhB28R5Nj/0HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CqoflFi3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lMrETkZw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACLCEDS015994;
	Wed, 12 Nov 2025 23:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=a2b+L4ANRKZCoJPqWZ5/AD/jhS0i30L+EK3qt9y/U4A=; b=
	CqoflFi3ppWJ8cKBQMDYJboLCBAzdJAoEPAAf+0NZQXnVsJn8Vpp6eutVwL0RtCE
	CUq0QNzUyENzzJBt93SvKcL1ZYQzsLhO2+EC+Lh5+JhgHHrnKcjzmWHyLvmMtegc
	2HG6lv8/+f/C+4VqCvNtxkDZ6WZwbkZuiWUzIal17MAbckG74rw+2XuofOFwvrj4
	MA9+XTjtgnz74oZOrzIfEo/B8/EamgBnjUZb9ulW4f8Hl6GtMBKnXWgtqRM7s1hb
	PtOzbMF8aOUJtYHYJgRaJTu/UBMTCC0BGe5NwjaY2jlCmeexdxxPAxbBGwhUIlB8
	SSFLKaA79Khz4XCvUQNkAg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acvsss1sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 23:17:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACM1WZG011384;
	Wed, 12 Nov 2025 23:17:45 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaew93t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 23:17:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMLXc+KqtCzDzHzDUq+W3o4Pw6rBEd0WmYkcHG4MUxAip2yITjtDqFEgCuVPriYW2rbFwaa0A1ZKr3ONzqkGSh7+PuPRpB7wkZ5RqE2DsqcjLNWYGCSNbvzT4xZHF2FRCG9UE3LAdNFxSsp2OzLMVjGR6l5izoNgxOICy1e3NT6Wz/r7vQp60ZcRIcKAjUcYsbTc8rmewNQ+GC0ZhAZHrDQXBPgJF5zi4e3tJxqrhtzdHvRmbrIVE7kseTWjZJc2prs+Mur7L69DgF1qQ/8DyvmpCVueDWymswPgrah6B881hyRTAuvytelD3yq3XE42k8kDdK8bEJPZMaCQJvnt7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2b+L4ANRKZCoJPqWZ5/AD/jhS0i30L+EK3qt9y/U4A=;
 b=bunB7qjIe2dEo2NKf6DVRRts+e9CKRPwaJ6pdIpQkurnvwYsTgYtMUcUx5s1FJka+ALTpNd8DH5xMCEaTpIbvvV7U23HYRqwVyxTZzHi9AeIdGfiww2Mo8cf3siUhA4PkiYJ0IxEXYdBeG71amt598VXQ3/xJBnY1cP1hBzvo7ODnfI7ENvXo7NmCbaOc2EZjWhkxqN0S5TbTqQvDtSmlbwaEj0ecP/LhYcfnf5aP7y86aGNXt5C7rwxMfUYauQHOvX4wtRNzYrOgem+/wt4gT9BEh0QZ1sPe2bOM3GnUt2wd8DnUwstR5ZrXsWPuYW5as8bGJM7aE+Eq9hYbbbXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2b+L4ANRKZCoJPqWZ5/AD/jhS0i30L+EK3qt9y/U4A=;
 b=lMrETkZwg/NITfPRsyZPvXFvtY21KmPPHN76wYt38rw+HaS1zAzrwezE7/Zgsi3oabu/osM/7JH36VASiubiuvXibiLa1aUJVV6hIN5PHN2NpqDDyCWChSozwi+1g1Fh+KeUSTrtptSESWTM0NgRyFAsUbF3uq6dilrLjrLKUCg=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by SJ5PPF842B33876.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7b1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 23:17:41 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 23:17:41 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul
 E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Steven
 Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [patch V3 00/12] rseq: Implement time slice extension mechanism
Thread-Topic: [patch V3 00/12] rseq: Implement time slice extension mechanism
Thread-Index:
 AQHcSNcOglHsgNF4y0S/q4HcTckeK7Tl8+kAgAYViQCAAbkyAIAA53EAgAEC54CAABZfgA==
Date: Wed, 12 Nov 2025 23:17:41 +0000
Message-ID: <368CA4A7-3640-45F7-810F-2E2A073FE27C@oracle.com>
References: <20251029125514.496134233@linutronix.de>
 <03687B00-0194-4707-ABCB-FB3CD5340F11@oracle.com>
 <2eee5e37-e541-4ac7-9479-cef3e62f234d@efficios.com>
 <b28c9f26-7a79-473c-a390-f502b74b02ac@efficios.com>
 <F940B2E6-2B76-4008-98B9-B29C27512A60@oracle.com> <87cy5mewxk.ffs@tglx>
In-Reply-To: <87cy5mewxk.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|SJ5PPF842B33876:EE_
x-ms-office365-filtering-correlation-id: 50303262-2973-4529-6f8f-08de2241adab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TkprdExXUDhrSUFYV01wZXB5Q2JWT00yYjB1Q2pZOXR4YzdsaHQyYXVTOFBn?=
 =?utf-8?B?MWFYVmFwSHRCUWpQNzZBbWpOTDBXVnFFanQ4NWVrTHVCSWZhTFkvZXU4TGo4?=
 =?utf-8?B?Njh5Q2hHSnpzQnpPQ0htYmdJK1d5WXg0d1MvSUhZaDVOQ3pITExPd080MmRS?=
 =?utf-8?B?a0c4TlQ5L0VsUWprT1FXTjR2dktSUzZHTzJjTTJlZEkrZmdRTWhpSVVCNEtR?=
 =?utf-8?B?T3JTWkIvYVl5Sk9lNTlmUForWkozZms4RHdaOUxTN0pZWm5PRGxsT0dDSkYy?=
 =?utf-8?B?aHNRUVk4MjlQUG16VmJoWGJEUldDcElhUUk3b1h6eEJuNjh2eU8vR0g2QWMx?=
 =?utf-8?B?KzJ6Q2ljSkJnY0FxQjRZajMwUnRvanowaFBCWUNpeXEwTU5OV0Erb3RQWTdM?=
 =?utf-8?B?YXBDVzladmMyMk10elA0OHIwTVZHcmpqNE5KNDRQby81ekJYQkZJRGRLcFZx?=
 =?utf-8?B?V2Rvd21UM3lhNW5aMzJpU3VYOE1DYjNFR2xsUnNUdm02S3UwL3RwQlM3RVlU?=
 =?utf-8?B?OHNLeHhNWmJ0aTBTbDI1cXA5dld5RjNKZ1RrdTJwVCtPdHZldXViRzRGUGMr?=
 =?utf-8?B?amNQcm9ORWJaa3pGRXhjL1pCKzRaRmV3Y2x6L2sxZEVxNWU0ckw3NExQbEdW?=
 =?utf-8?B?TU15S3ZzTmx0cWFTb2VNVURDV2hicTFEUUViWjczZjVNU0hHYms3THQxWkcx?=
 =?utf-8?B?Nng1Qzcxd0lUZXFiTEVkTllRcFpmM2lWVGVqMUJORVp4am44V1djdnd3QWZx?=
 =?utf-8?B?VVF3R3QyQU5JUFdMek1PMTkwK21oamJXOWhIbHlMaHZUQVlsUXgweW1uS2lY?=
 =?utf-8?B?WDVTSXhqYWQ2M2tPaXVET1Y1QXJXMkNGYndoeENBYTRWaUtxQll5WTE3Qkly?=
 =?utf-8?B?NTBmcks1d2twb1JEMnRSZXk3b21JZ2o0U3BGbU13QzIxeWxBZ3RTZUd1WDBm?=
 =?utf-8?B?U0ROTWFPQ3NKeUZpWkl0VDN3ckhmZ24rQzAyQmV3dkptTmRITzBjR0lISUlr?=
 =?utf-8?B?azlKWjB6UVNCUkR2QXMxNDRrWG9vKzFRUWl1UkJvUWdCZWwvRzJYRVFOYjZZ?=
 =?utf-8?B?MGNnNUdhbXVEUlBmZ2xOY3VsN0k1YXNDK1Qwb2hCaFFCcmlTS3ZsVGc2dU4y?=
 =?utf-8?B?emFZTGlUTi9lWHF0OTlQWDlqdnZnMW0rNWk3WkYzblVHeDJiamRJUXJMZ2Rm?=
 =?utf-8?B?V3hIMndUamVoVVBnckVUQjk2M01uYnNlVVZMQlBRd0ozZjBlVWU5V3VEaXJT?=
 =?utf-8?B?S0d6TnV4Q1cwdHpra3JMWjFMS21kWGZWTmx5dS9kR3lxUGNKSGZCQ3c0S1J2?=
 =?utf-8?B?UFI0WW16akU0aFZZS1BnYzNmSktaNVpLK2hKa3g5blM0RVJDVVNMd0pXckJp?=
 =?utf-8?B?WVlBZWhoWi9rcU9VRU1ZbHZtZjR4Mi85LzlmK0J5allMSVlMeEhwL3JkYkVF?=
 =?utf-8?B?U1JUUy9xSktyeFpiUEVOMitvNStrVnlRcmNXeXI3aE1DSU1IajRBV3FjN01i?=
 =?utf-8?B?MS84eXQ2bjNzY2JtZ3QrTXVUclVJSTRVR1lvbFoxMU56RUR2TGF0cEVRODl3?=
 =?utf-8?B?T09mUnVCR3d5bzdOSVNWd2pQSmoveTlGbXNvWkU3N2hQMmxPaWUrbFFFWGZ3?=
 =?utf-8?B?QmttQnQ0MFZVMEViclRwZFJ3cU53dHBjVVlqSUxrSTc4eXJ4cWtFNnJ1OS9F?=
 =?utf-8?B?NExiM1U2MjZCVnNNeGRLcTkxTmVJNHUwL0tnNDZuNTI1TFU1aE1iR2JJZlh6?=
 =?utf-8?B?NmpEMGF3dm1LNFIyNHgwWVZ4aWRtMUQ3bFk5YVl4ZmlYdmxJSVhQNHVya2tm?=
 =?utf-8?B?eWpHMXozL3pzRjAySlVHMWhBWnFrZmt2MFJRcUxRL2dqQTVuSEU3U0hUc0Jn?=
 =?utf-8?B?SGFCWjBlTjNhdGc0T2dBNlk2RFRnNjVsTXNSbE5NeUpFclhmSFIwRlQwSUJK?=
 =?utf-8?B?cC93anNISDNBL3VWR3Vlc0ZSRjdiYzNvK0p0eW04VVJ5bFNlckxEbTlRUzJq?=
 =?utf-8?B?eGdWMThacEI3TzNMVDU3eXdRL0FpcnY4YnpFVmFaNmpQTmsvVHdhUXBmR3pE?=
 =?utf-8?Q?IcslqK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFdtSEtkZHlHR1J2cGErRFpQSXBINDhYNC9oajJ0Um96dWRONHlRZHkwTGgx?=
 =?utf-8?B?ditXQ1RtT2RHZGhUSEJ5biszcTh5K3ZNTmZsbnd4Z3orVTUxS2k2eEV4RnZi?=
 =?utf-8?B?b3VqOVEyUHhEd1hMSlFBcGk1YzIxczdPaThXVmtidUl3M2RiMDFNL3gxbCtk?=
 =?utf-8?B?Mk9RTHJqMlhydEE5WmxiVEpqN1pURGFUMUVNVSs1Um5uS1ErTE5hcWllZEtJ?=
 =?utf-8?B?WEtCTzNqT25YbENxdEp4WlFvL2o2ekFLUExESHlVdzN3bThJUVo3OVlCK0py?=
 =?utf-8?B?d0dJTVdCMHhqVkIrYWhQdElNZnpES2kvNDZSVzFOT2hzdjRsRnRIT084YmMr?=
 =?utf-8?B?YkJkUEFUN09haVVJMllWL2tjOTZQaW1tYlFXTWN2enhaQWRxOTBZWjFjdzN5?=
 =?utf-8?B?RFR5MDdHY3UyWEx6YldURW1hRE16MVJsZmo3TTVBOVd4NUd3RDZVU0pYbDlx?=
 =?utf-8?B?T0x0c21jbGlTN3hmN0hVSVl5Nkl0ajZ3V0ZOTFBkbmdqblplQ0UzdUlWcDJZ?=
 =?utf-8?B?NnFsb3ZFL0VrYVl2TlBxYTM1b0tUNkpJdHk1TzBUMUYvRTROd0tBK1ExeVBB?=
 =?utf-8?B?SnNrSWpqVkJOVVBtRDdaN1JuN0FLZ2FIOUM4a0g1N3hUOXROTHllVjZvYTQr?=
 =?utf-8?B?ZHEwL1YwSlJSSEdySkJ2N1dFbTNseWczditlNHVRSEltaXZiSkkzaEFvUHNa?=
 =?utf-8?B?aGtQRUgxT29YWjdqUDBITUJVaVM1OFhVblpPcDQ3VnBEOExiLzFWM1hpMTlI?=
 =?utf-8?B?VHl1dTBFQkJtVG94MnRtVG5jU3VGQnVLelJWNWxybWYwNURkV2xCVmtNZnhp?=
 =?utf-8?B?ZFg5OVBGaS9Cb3VnUVRVZHYweHZJTGdqZUNJTjB1OFFJMnFqNnFkNjdHWklE?=
 =?utf-8?B?VGMwbDdiQnNBMmlpSWM4T2JVNWRxTy9mN2RPcnpJQS9ZaFhETGp0ZmhHN3BX?=
 =?utf-8?B?ck1MMDZsZnhhNTVIRy9vdTErQkxCUG1hK1FhQXJDYWZXa2ZrMi9wSHc1dnhn?=
 =?utf-8?B?cVJjYXV5MDZvZjczZ0o3YmxUUi9uTUhFQ1BuUURteG9lWHMyOUxla2J3bld6?=
 =?utf-8?B?S050WWdFdlFlbTBoQnc5QUJYYkJFQk40WWtIWDhtUHA5OGFLS2ZqZWRmdll4?=
 =?utf-8?B?RXkxOXk1YmE2ekhKQkRLQVpab2Q3M0ZZdUpQSEd3VVFmS2pjQjUrVzBCUjl4?=
 =?utf-8?B?THpQQUdCVkhNeFpXdUxRMHVadlJLY1Z5ZHhPZ0l1b1lzbFhSK0xQcE41K2RM?=
 =?utf-8?B?UGhmWmM3NmxERGN3RUprakRyQjhWa3EvdzJiTDJhaU9YUWRSc2tnV3NrVFFv?=
 =?utf-8?B?alNndFFmMXRpUVZsMGRQM0dhd01GNWdBc3NiMWU1UHMxOVA3dTZTV000RkVo?=
 =?utf-8?B?VVB5b1pTeDNJRWhqWGZUaUdZd1pMTXE2ekh2cVl0N2hVNUVnRGxIOWF5OGFY?=
 =?utf-8?B?V3F0d3BvcUF4UGcrZmdUeEQvQUNkSmdQbjJFdlRINFNQR3Q4UjRzMDFzOFBh?=
 =?utf-8?B?VWhjaVROT3dDZ3JUUTdlWEFyWTRMUDR1WUJPaFoyS1FveHFIV3dPSVVXZzBz?=
 =?utf-8?B?QTBuYjJ1YVVXaXFPOVAwMURCTGxEMEVDV0hEb2g1aVdiN0krQjlMQllIMzZW?=
 =?utf-8?B?dzAxdk1lMDZ3SXNOdS9md3B3eVhESFF5b3YwVlpoejFLdmxUeE5GN1AwTjBT?=
 =?utf-8?B?MFRMQ25YRk5jQTZjeTJDbjIyY1F1NmZBVEJXODVsNGVIY1RGRVRpcWRVSjVX?=
 =?utf-8?B?aEt0Q2Z4NjcvTm1KZXVhUzBPUjY1Nmd4b3hVRjlpa1RQSmd0MVpoaVM4ekRB?=
 =?utf-8?B?cUhzcEJJTDU0eW5Mdjg1ZHFvVytZQUhudjBkV0ExVTJiUDlVeDIySHRobjgv?=
 =?utf-8?B?NmFVaDJCUFYxU2RWN0Q4RkpqMmdpNGxob2IySVRpM0JBRUY0ckh3aEFKV1BP?=
 =?utf-8?B?am03Z2RjN2pLSThJMWFzQlRRb1pnUWdWRnlzd282TkhmUTNIZUkvUjltOThW?=
 =?utf-8?B?Q2wyZVQ2NWJjUlRscnloSERxL3pTelJFS2NMMXFNZ0FabVZ5S01PbXpna3Zm?=
 =?utf-8?B?eG5JSVlCMTFUcnZUS3ZZbDhZT0F2bzZHTlZkZmJmNmxSclZBbE1kQ292a090?=
 =?utf-8?B?c0dmeWpkeTE3UXhFdy9EcTYzRHdUQ2s4cTg4TzJLVTBPYkJCdkNXbDkrMFpj?=
 =?utf-8?Q?jVDjQ/qliLPZeAc24j1nw8E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC05F88BE0DE74418B2F3067A1C01BCC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c61QKt0jMOMElt7Xa1cA6n3TjUT0rAMyTMZc9JM0tZkaD5yCXSyM2GkzmoawyBAe3LlIVewJ2RtQR+a8KZEtl4qTx5kyUwnB4AVeNwCn0o4VHVCDyiPqgHc0qiyggVQ/S6PP9TzL8pKp3EtH1Q5CbX+t0OLoeb3Svae2hY+Up0CQ6KTsFL8ILgYacmlSYtwjVD5FSVf+2lDcB0sc3atL9MdYnMeUq6KO3J3e5UEnc0t6QgWiAbOS2vE7J70TeMWUJAB2w4gSDIPuAJ386AvdTqWu7nQs5NQRmFq2XvWzwYyClkt2fU9mxcPVseUOiudPxxu0UecAvnsne7Tnm9bpEA96b4hntCV8wtk873CZv/LNHWCfYbxvD68icoR0CwyzbCRL+HIyuru6qu19s0tuJ+ZCZx7zICPSgzgZnIJV3jW9vzVMcGa4oyUTWHKZBI1/03NZtMnX+vdRugK4jqa4NKQoNwTA5Am5BfRqfveJuqRMKSiEnpESlQViGsLIH0c/TsnSD3DXVlqYonq4cQUh9Ten2SDUf649L6SuIO2vVIkZrTOTYFWJEloa74YnOVmpcnPsLYX2d7PlrApSNyZGCpeuUIkBhLWhuCwz8iORfq4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50303262-2973-4529-6f8f-08de2241adab
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 23:17:41.4750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3EBdnjogmQcqBIBzYGabbRJfYNgpR4NGgEL0QzLfG18sW4FlSm4cbMMWhDc6+dMUg59f+9EyUdl2CTt/o0XY4Zz1z4U8MX0g8M6RzBFw07c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF842B33876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511120188
X-Authority-Analysis: v=2.4 cv=bJUb4f+Z c=1 sm=1 tr=0 ts=6915159a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kMQrEuGfWgGXno6k4pgA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 cc=ntf awl=host:12099
X-Proofpoint-GUID: _SByc5YKfK1UhG9SIGVHjNQYidT3fZh9
X-Proofpoint-ORIG-GUID: _SByc5YKfK1UhG9SIGVHjNQYidT3fZh9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyMyBTYWx0ZWRfXxTHqxoXq1YNh
 MVempes8MjM7JAPcIbEV0NLKqZQeer+ERq14Er74qe6VTShTS2LGCx7E5B+ftBfwsqzInZCf/ip
 g7trreSGV2+cocs91G3QBfOWw/IYBJ+SG2SrRMqgG3E6DTdN6uBxsGxfpWTCj4ATi9iQg60GSsc
 cSc3iGqJmWOgOgKfqaXdNL1Z3aneMUYOeSg5oePfmaVxweHzlYIyJCPQ3zTPOYMhayiIdbiyIGC
 WQp7FdvphYUmNbaV6x2tyTNQcCWadPE+czYbVU+ubyy2AY2PeSUSuvYD0wPs51I85DkiaAEAWKO
 HFbjKjGJmGsfEPTNxt6NHYZLBPuW5epxFg6szo1fEE9+n7r6djNpOKxOfxIovG2BrHqjhsHUwr2
 ZeqMVm+koCIC6vL+Oe4Yblc6tcs+obyok3aWL09+maT9yU1BFCI=

DQoNCj4gT24gTm92IDEyLCAyMDI1LCBhdCAxOjU34oCvUE0sIFRob21hcyBHbGVpeG5lciA8dGds
eEBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgTm92IDEyIDIwMjUgYXQgMDY6
MzAsIFByYWthc2ggU2FuZ2FwcGEgd3JvdGU6DQo+PiBUaGUgcHJvYmxlbSByZXByb2R1Y2VzIG9u
IGEgMiBzb2NrZXQgQU1EKDM4NCBjcHVzKSBiYXJlIG1ldGFsIHN5c3RlbS4NCj4+IEl0IG9jY3Vy
cyBzb29uIGFmdGVyIHN5c3RlbSBib290IHVwLiAgRG9lcyBub3QgcmVwcm9kdWNlIG9uIGEgNjRj
cHUgVk0uDQo+IA0KPiBDYW4geW91IHZlcmlmeSB0aGF0IHRoZSB0b3AgbW9zdCBjb21taXQgb2Yg
dGhlIHJzZXEvc2xpY2UgYnJhbmNoIGlzOg0KPiANCj4gICAgZDJlYjVjOWMwNjkzICgic2VsZnRl
c3RzL3JzZXE6IEltcGxlbWVudCB0aW1lIHNsaWNlIGV4dGVuc2lvbiB0ZXN0IikNCg0KTm8gaXQg
aXMNCg0KYzQ2ZjEyYTExNjYwNTg3NjRkYThlODRhMjE1YTZiNjZjYWUyZmUwYQ0KICAgIHNlbGZ0
ZXN0cy9yc2VxOiBJbXBsZW1lbnQgdGltZSBzbGljZSBleHRlbnNpb24gdGVzdA0KDQpJIGNhbiBy
ZWZyZXNoIGFuZCB0cnkuDQotUHJha2FzaA0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiAgICAgICAg
dGdseA0KDQo=

