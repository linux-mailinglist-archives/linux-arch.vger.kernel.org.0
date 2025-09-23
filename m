Return-Path: <linux-arch+bounces-13719-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07BEB93C74
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 03:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61702E1511
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 01:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5370915530C;
	Tue, 23 Sep 2025 01:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XL36GpK/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CDQ6Wqby"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C0E15ECCC;
	Tue, 23 Sep 2025 01:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758589373; cv=fail; b=qpFu3dFafUtHnCzizakB4mQEbQ8jFRcVU8EuvVif+FlEjq43/Y5TgwJqydwLCIj/RO0GMsnH6plrxoc0QdJ/0nhlf7+R1gxJsOMmJ635nmDo4Lw+V1ul4qxyD6quhm4uzFTVObQERhDD4C76q2qj+a1gLhznfWLRTfCQ21gIACk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758589373; c=relaxed/simple;
	bh=r4aI4OACxYe4MKGTTeWQCfaRDhOGYPyDVCYBfulFkOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=boafBuLyWDQa3QMmrL+IB0yO73r8MdZSYUaFhGE8kp/cL/jE0ILlGyRWN4YD0gJ3lSJ27AoxYUFCBV4Wlkyg+McdgKl4YB1uk0F5ELP6fVU9JHC4z5DwcDp5bECSLXJo9vu/Seg3VX020O37kwmXL6IrhlpiS3pAMJCM8FYUZjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XL36GpK/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CDQ6Wqby; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MNBvgs013583;
	Tue, 23 Sep 2025 01:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=r4aI4OACxYe4MKGTTeWQCfaRDhOGYPyDVCYBfulFkOA=; b=
	XL36GpK/4RcaESd3TvZAYqHsL+ctfSNYmz+zrURxGlCfyi4QHgXhKeSCcyKgyRp9
	seb6Fm0nnQ0LCaAacYhjw+GqSewC15BMvcSVZgX7RTfwDylxJi0Is5YbVhdOezK5
	bKYFpR816yEOVGwtWqwZuvpoeYAUX5X43EY4gj6+0bmlqGAMIXAlhzCIMwEhEDSO
	yUYg9zbOHos4cco4FnAjI9ZYHKhTdwsm29GQS2ppmOtPxeo6KM7UMejI9Qus12G7
	z0JYLjs0U8EDzjBKW8M6b69uPW+3xR3Zqno1V/0+9l8Axd+P3TmlFFaHo1ZxsQcY
	3hh7z1dYFlFzIgEbmMu4iw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jv13kw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 01:02:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58MMoZju025268;
	Tue, 23 Sep 2025 01:02:08 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq7s0j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 01:02:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgzOJ5RweLHyRXUm8XZTQJyDxke0HW+yP78FLFu0ti/OrVnZLyzcYT0vMpmz3BhO3f4IveFhvDNvJflcMyHE3iojHodFpirBjnj8CnatczZBWZTM8Fv1ZN9sSD9ONZuTGh+TRfHjX256udwaoLjm7s1tMIYANYMwOlRR1kYgCchmyxSlUCPfDp1mICKSm5OzWm0yENfeISheISa3LiPHIcGMskaLbNj7+lshrY26CMfTpcG9cSJibMAyj7dZTEDo/5AUVvcbMBrAc1UUkj9kWN0VWHkjFKD3DBwPsLr8tFege0TSAUE90+6+ZzpYedRCZ+P62VAgzuLC93J4l43Ncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4aI4OACxYe4MKGTTeWQCfaRDhOGYPyDVCYBfulFkOA=;
 b=Tu3lNXS1S1gG94ZErFjklUERoXEksR2nXLAetLjROqPdrazSLVeXiw6Qaq+mUKUlRbbq0kXXks2AGwM3cZh+5oM35mT6m1P73HisotWabBtnryeknrF1unPZaVcJEBD+ocn6sBwmB6PKdh22VVN/0+V8dHD5N54oGjYl7ljK/uWej66KRuHFKjkSztmGeJnOCHxesrK981YEy5lGkFuXf45niIp84cTPif7ISNsVZg3PTWa4VMzyc9rFpgPFSyq+olpALfrYKQjPbJESd91oviKIPlVp8GgGrbUwrg5zNzU+zPyrnIDvGPyilInM6oW4WrJmqKLsunSWAlJj1vToyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4aI4OACxYe4MKGTTeWQCfaRDhOGYPyDVCYBfulFkOA=;
 b=CDQ6WqbyUsOXKBMGth/FCJIHTiVovU+clTk8j0vJxhONOvMcpb74OhTp5YHx+gtT+jb1hl7efvrTLbKQv+oVbTkDOsCwL+wDpnmrLj+wE7lNLDJTCVPPvTRHIQahPhhMEzK5Er1HcL0BO+9U60TSVb+EIYk+ypC1ZJHvovvxfAM=
Received: from CH3PR10MB7308.namprd10.prod.outlook.com (2603:10b6:610:131::11)
 by MW4PR10MB6369.namprd10.prod.outlook.com (2603:10b6:303:1ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 01:02:05 +0000
Received: from CH3PR10MB7308.namprd10.prod.outlook.com
 ([fe80::b5ca:360f:30bd:83f5]) by CH3PR10MB7308.namprd10.prod.outlook.com
 ([fe80::b5ca:360f:30bd:83f5%4]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 01:01:59 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        "Paul E. McKenney"
	<paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet
	<corbet@lwn.net>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
        K Prateek
 Nayak <kprateek.nayak@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann
	<arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "carlos@redhat.com" <carlos@redhat.com>,
        "libc-coord@lists.openwall.com" <libc-coord@lists.openwall.com>
Subject: Re: [patch 00/12] rseq: Implement time slice extension mechanism
Thread-Topic: [patch 00/12] rseq: Implement time slice extension mechanism
Thread-Index:
 AQHcIRRQ6F4MTToGYU+vkRiA2yaxVbSOHuQAgABRXQCAARCIAIAAQm4AgAAw3gCAAScugIAJuMUAgAR+5gCAALYwAA==
Date: Tue, 23 Sep 2025 01:01:59 +0000
Message-ID: <82BDDCE0-1611-4A03-A46C-62EE844A8E70@oracle.com>
References: <20250908225709.144709889@linutronix.de>
 <159c984d-37fc-4b63-acf3-d0409c9b57cd@efficios.com> <87plbwrbef.ffs@tglx>
 <3d16490f-e4d3-4e91-af17-62018e789da9@efficios.com> <87a52zr5sv.ffs@tglx>
 <a65dfd2c-b435-4d83-89d0-abc8002db7c7@efficios.com> <874it6qzd0.ffs@tglx>
 <0BF9AF0D-EA88-4504-99E4-BB3674FA588F@oracle.com>
 <827c26cd-3924-4556-a36d-da42b23a9a17@efficios.com>
In-Reply-To: <827c26cd-3924-4556-a36d-da42b23a9a17@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7308:EE_|MW4PR10MB6369:EE_
x-ms-office365-filtering-correlation-id: 9eb3ce3a-4bea-4e47-c583-08ddfa3ccc68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?L1oyaTNRQkdSV0lLR2wwdEEwWE8yTkdpRE10S3JvaHZTZ3VvbTNueEdsVDBP?=
 =?utf-8?B?eklNOXhBbVZsUEd0NG1TZXdqaktTcHg5b3YyOXlscTl2SUZFbWZRbkE3a011?=
 =?utf-8?B?TUZWdit1N3FDNmVHQ2pWZDVwNE9RSHB0MWs4d1lONWlDYTJBTFlRbStsSCti?=
 =?utf-8?B?L255MmVDYXVqZGs0aUpXcUMwRkxPbkdmcEZBUlQ2Z3cyUGN4ZElEdGNKZUVT?=
 =?utf-8?B?aU1wRW1CZEJYSFlaQVJrM3pWdC94VXNJc3djaFdING9YcE1YRHBpWDJVRlA0?=
 =?utf-8?B?K3MzRklGWEt3cDJKOGJuZzY1T29VeFdXWmpmanMzUG10cjl4UEp3OXZheFZO?=
 =?utf-8?B?SUswY0RvR3NGYTNmd1dsUG1IMFVGRWIrZGdlNE9HaEs5VWlyOTdsTDZQMEtr?=
 =?utf-8?B?M1VTYlBEakRVRjJHdGU5OHE0MTYwTkJwV1QxSTVSS2pNN3YveXhXeHNHRExR?=
 =?utf-8?B?TWJEQ0Q3aHd1bEx6MWZDdGU2VWFnd0NFdEMrb2JiaVQ1WXZ5SElYWlgxeHZz?=
 =?utf-8?B?QUJVWTlDOGMxWlU1Q3BLby9PUlRpN3piNVVhU2pWandxU3h2bUtzZzVVWSs0?=
 =?utf-8?B?NHlKbkRLMTdKck1GMjJ5MFBMWXhyK1pTQXd5c3NYTVNqQmQyTnFwS1A0SWU4?=
 =?utf-8?B?dGlVRHFZaEpqWTF2U1JNYTg5QzVpanJldEtoclVBaG9mTGFnWDZpMHR5Z2Zw?=
 =?utf-8?B?WEZqM1FScy9NMXVPRWEzWm5pQk5KTFpjd0ZCZmJtcXNZNFM4RHFBNERqbVlu?=
 =?utf-8?B?bmZ5Y1lxeExWbkFpSmpiOUpIYjhJeGw3T3hxMkVDRjgxbmpKbS9Beko2NllR?=
 =?utf-8?B?YVczTTI4ZGxRQVUxSXQvc2JsczlldG1pZ1g4M0lVeUpMaWVhQmNLaEE0dm1I?=
 =?utf-8?B?RmhudXNDOUdwaTV4RWNoWHhzcXpqSGozK1ZzK2ZqNEV4cURuUXdGelRGWDRX?=
 =?utf-8?B?ZnlOVzBxUzRVTDMxb2E0NWxEUzZzNlBodU5yQkFuR05CaFRCZ2ZkN3lGbm5Y?=
 =?utf-8?B?UkVDaGxkd2F1N21wNVNsVWFCR1dXRmhrRlFhZnAvRURFUjlSRTdpeklxWjJr?=
 =?utf-8?B?THc0N3dzVDJHbHlXc09TUDVBWHRKMERwNFNqUzBTQXNwclE2dXlqM09xTWJp?=
 =?utf-8?B?b3VScDAwVTU2UFQ4UzJQdG5LV0owR1VWSjBnQTN6SW9tL2NrNWU0aUFSRU5S?=
 =?utf-8?B?RWs3NHNwcUtMZ1JpYXVKYzcvc2NvcE90Rm5ocWVxRWZKLzhCRTY2emw2VVE4?=
 =?utf-8?B?S05LUlp6aFJVejhDQXMwVUg3SkJTaHBIWmtUZ2dTQUYxMWlJK3ZLem1FOGpH?=
 =?utf-8?B?MDJrM1Z5aXpVUndVeEo3QTNlNFd1SWFNYUpISXhLazZvT2Y2YTJiRG1BWm1m?=
 =?utf-8?B?d3dublVXV0ozMEx3djhkZUlGUXEzVmg2UFltdFNscThuQjFGQVRuQzFtS0ho?=
 =?utf-8?B?SlAxK2VhSDYwaGJTVFJlVU54anpya2Q1VUQ0WmdNdWxHTHF6R3ZnMHFMcTNO?=
 =?utf-8?B?cEpwSW9UR2NpN25KaWs3UlVZRVJOeFRydVJKak0yUm1jMlNCVkRtUnBnRFZX?=
 =?utf-8?B?ajZCZkMyWUZhY1hVTklYWjZoMTFTcGEvNUpHQWhHbHVrU3FvekJIVHZsWWpw?=
 =?utf-8?B?QUMrQjRRZzQyUEZZN0xHdHBtRU1EWGdlSjBKRElocUo5SXNJcFV3Y3ZXL1Za?=
 =?utf-8?B?R2VCL1FOMEY1NFF1UysvNkVvaGEyc3FxbU9hSi9LMnBjQ21yM3g0aUE3ZHhu?=
 =?utf-8?B?dFJ2blo4TnJJbU9WMkU5cEw5Vkd3YlkvNzVGL1dia0FXKzJEc0ZjQksvZlcx?=
 =?utf-8?B?RHRHbXQvNGRYTndPR3BLQXUyanhFRTIweHZkeDV5S1k1UFQ2NVJGOHRxMzdO?=
 =?utf-8?B?UDRWb3V2TmRHWHJ0aDM0SUREZWpOOStOUFVQZ0N4TVFrb1FITGdNZzBxcWl6?=
 =?utf-8?Q?DV5aIxEqvdg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7308.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXVZMkdVN28rT3I3NXR2VTd1Y1VNY3VadzMybm1tK2JXQUxUTHYvOFhZTzVC?=
 =?utf-8?B?eDBpWXM2ZXgzejRVSG5zTnpqMUlMTUJ5LzEwNVc3R0pBMmVzb3lwV0RPVUcw?=
 =?utf-8?B?SFl1d2FkQUEwRDF4YVd0ZTErL2RQcWVUeTF0dUh5bWREbXVzZHZydkN1ZDFu?=
 =?utf-8?B?Mk45QzltOXVOdTgwYU5VWG1PcUtLUW1TdWJtMmhVSjNPVXRpMzJ2SCtLUWh6?=
 =?utf-8?B?dHdYZFlMdEdLWE8ySUthdDg0c1JGL2FqNy9FR0grYkZoREswQ09vWSt0Qjl1?=
 =?utf-8?B?ZUpvZ3ZZN1BMUDY4dGJsYXdTeDNLMWFibmU4K0N1QTZWZTdRMHpXd2YvU3J6?=
 =?utf-8?B?TVZMcG8rSTlvN3RUZWt1M2dsaW1xSW1QWVN6RzFZRmdaVTV2UFV4K0M2bEZl?=
 =?utf-8?B?dVR3RkRraVB5elhQNyttVWp1WTlVU2xkZzFKeUR5Z1JjRFVYUDVsei9TRjdj?=
 =?utf-8?B?c0dSV0I3OGNPK1loQ2Q1V2hnYUlWREI3dk93SnpmdnZWcE5DZW03RmM0UWhD?=
 =?utf-8?B?RkhqZmdRTlNoYTcyc1VUUWtOVWhJazVIMytYd1JxUVRPcFlkazJvczlNbmRV?=
 =?utf-8?B?dHB1S2l4dWorWk1ZZHg5VVVXSWxxREN6cXd6YzhOQVdKcWY3TDlXbTNUSWla?=
 =?utf-8?B?WmhjL0NGdjREaHdxWTlnWDFIRkY4d25BMXN0d0VYZ3JVNmxHeDJEK1hCbVo4?=
 =?utf-8?B?VHYrZGVxTE5aa0syekYvR08rbGhwV1JOdHV6WWJxZEJ5dERtTTBXMmU4ekJR?=
 =?utf-8?B?RUFXMUI4NS9DWERpOS90MXcrSnUxZU5KUFFqZm1sMkFVc0hIanh0NzVCbzVS?=
 =?utf-8?B?NENzTkl3VE1ud0hvRGtMVmpDUUsrZzZRUjhpWEZVNWx2dC9PMFhuRExENFhn?=
 =?utf-8?B?UmFNOHJRSkIrN01DVFg1b0swWkQrN1RIeDVFMjQ4OUtJcnNDRlNpdlhlTHFi?=
 =?utf-8?B?WUdLRlZ0bDk0RkZONUx5emZSQjVrWUhSVkpOQWk0MUZxNEwwdHVWMld2ZFV4?=
 =?utf-8?B?Njd1WncvR09HajJQRit6SXhnK3JKN1BKSFprcm9xUjZoeXdESzdYT0Nzbk52?=
 =?utf-8?B?WmFOczMxazJSODE2MUZZMHY4UXp2eGVadSs5bDc2c0g5ajhMYlcvQUhqRFZ5?=
 =?utf-8?B?TnhUTE9leTRNVXJDWE1TTDdrSTl6OEhvdHV2MFJKZzZOVzdoT0FQSFpDM0Ri?=
 =?utf-8?B?UkNHYUZ2YW1Iblc4VkMvYmI2WnM0SUNVQ0dRUy8rV3ZzcTlZL3RoZ1VxTWkw?=
 =?utf-8?B?WERoNW8ybnZHK1pBUHI1bG1qNGQ1QnpHclZTUDI0N1VSUkcxYWFmbXNzbElj?=
 =?utf-8?B?Y05qa2duek1nZGJtR3B2UlhaOE1LNDhFeWNFRHFCekVyOEhSeGU3RzI5MmtE?=
 =?utf-8?B?cS9iN2ozYjViWWRHNGNDcmRqVFNueDRsVkNvTVFSSFdtUnBKQ0EzU3oxWFRO?=
 =?utf-8?B?V3hKQ3BZeXJyUG0rYjdJNEJVekltUTVtT1Z1YVBrNm5PK1c2YTZnaFhjK2Jo?=
 =?utf-8?B?b0Vsb1NVc1d2a1J0RmhxNUZDRENRczlUZG1xVWtlV3NoUW1ROWF3MFJJTkVQ?=
 =?utf-8?B?d3h3ajBoZHdaY1NJdWlnMDlwZGJoRHEwbmg1R0JHVmwybFBpRVlCUXQwT3ND?=
 =?utf-8?B?WUswNUFleVFrbDhLSkZrOGlZWnlvQ1VDMEpLcnhDTFQ1alg1VlJsWk9reHRw?=
 =?utf-8?B?b3dQaWpnbVg4SzVkL3EvM3MxaTBWdXZ5Sk5uR0M1Ri82VUtQeTRKcE05T0Np?=
 =?utf-8?B?ck5NQ2p0L3I1YjRuRWhPbWFyb2RRdFFVVHprNGIyTC84bHJUeHllZGhXZlBi?=
 =?utf-8?B?OU1pZVV2U1NRb1lMb21GcSsybXhQK3gwNUhaZnJ5a2tkWlhUSDBCQVFhUHZD?=
 =?utf-8?B?TkRmb24zazV0eUlCSzBhWTNIM0tRcXF6MDFNL0hKM1ZRVThnWGRyeG1wL0Fq?=
 =?utf-8?B?YW1CQUFZbDB5ajhJMlJzV2dHNVNkenhQcjdKQWFiOEFOOWNQQTMzajBVY1Zq?=
 =?utf-8?B?UUdrcVg1WW5oVmphSGk0WEJjWk9NbjNlMXBBMnZKbUlDWnFTZi81cGJIejF0?=
 =?utf-8?B?RzROamFnU2tNZTZZVmlSc0pDZ1VSNXFUcmZ1VUlBcXFPZEI3V3g4aUg2akt0?=
 =?utf-8?B?S1UyVk8xdi81QzkyM2xUUFl6dTNRR2crMEdXUTNBamdGTXJZdUQ1RVJWL3Vl?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFEE9D25C9635541ADA859DDEFA0B925@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jPgmkBOrHUeqmIduUSGZgl9HbTmZ5rswG8Pk5aCupfZexoG+WHhQXLLiVcvrzOb41w8rNNDY0wnpIl2A0pLNYwrw1ntOw2hppr7OZLgk3XbSGm4B8ZwkX7AJUlUIzZQXxKP8al2x22RU5pYGB/GEhshM0othViHqZIvEXcEOW1kknBThk3inbgTyH1evgsP/gCLvUe3Dx+T/R4D9+Xvd++4TX5Ga+49pAeseRI5TqIXDTNzyvLbk0N6LktWwISXevAwqXasmU/z3g/eWObGUcGBuqMEb5B+PlU0/Cbj50Cy0eJfvqaiPaPwBkzih6JG8bFAtxGq004HIDf0e77JxWYM1KaWnnReerEqMkA78B386VN3s2mmK1TZEI4gv9YxT7E1AFVVOoxR6loa5rOm0Cc6mDEspt86Z6e5mWrE94D1J0LpTJgGep1XEJ2WZUrCcEkbxZyUHjhTa4sz2wvpw3c+7WzoZs/MbYe8ydfFWddiujoKgJNglmnXvLTEtLTWAIRUC3UGNw6KXRX3mhB3Fg5qQN3YxrExeeigqzFGtwWeb/gw6oj8GGBDDwKk5T9InKM9mItR0xx+Cb8iP+b9T4nodBrj6umQGpgonLwwmoo8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7308.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb3ce3a-4bea-4e47-c583-08ddfa3ccc68
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 01:01:59.0401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5F7CQx5W3bVvxqaJe9ZbarkcS78PTsHFB0L21TdYtabIWmu15fOnZghapgvzYQaAYGWSFZA8xv1gKqdkN+6WZGK109He39eOd2u71yyakU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=670
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509230006
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMyBTYWx0ZWRfX9pyXXNf8VUGo
 ycNB1fNQLuT5u7pCtM6uU5L7elSjFV4zbtnuuVD+w0vsOHJLUbTFcQV+oH7YL5JlBkqws7KG7P6
 +uschNDykoPUAgRFg5NwV9JahUhK7v97qR3/xQJyRSzz1Wepn8+QK9NHtDdw5/dVrlx5mQUAmA6
 ZM7qEX5O6cm0NjUVPIZwaKNdm9D78U4BAKjW2R5nLK5J8Yw3Uah1mvCFGq4Gb0Mxb/YM5k5iS0j
 xUcrdcR72bMZiTV7oFMDm8aEmYwIj8YCepTN844jR/oVEoeiTFI5e64R9yE+pQAw/Dv9eSGZkH7
 4PrP+gqywDdP0H3x4NXYis9mcQw4KohvJcUB0jSLgPiMKqAipXRsG6YH+e24prg8VjE7t6h2nTN
 /Vu7G08+
X-Proofpoint-GUID: dkNfwAywGT9rsyfoTggqtk5N6Y86_Vj6
X-Authority-Analysis: v=2.4 cv=YrMPR5YX c=1 sm=1 tr=0 ts=68d1f191 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=7d_E57ReAAAA:8 a=PUld7rwj18GrDJckznkA:9 a=QEXdDO2ut3YA:10
 a=jhqOcbufqs7Y1TYCrUUU:22
X-Proofpoint-ORIG-GUID: dkNfwAywGT9rsyfoTggqtk5N6Y86_Vj6

DQoNCj4gT24gU2VwIDIyLCAyMDI1LCBhdCA3OjA54oCvQU0sIE1hdGhpZXUgRGVzbm95ZXJzIDxt
YXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOg0KPiANCj4gT24gMjAyNS0wOS0x
OSAxMzozMCwgUHJha2FzaCBTYW5nYXBwYSB3cm90ZToNCj4+PiBPbiBTZXAgMTMsIDIwMjUsIGF0
IDY6MDLigK9BTSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+IHdyb3RlOg0K
Pj4+IA0KPj4+IE9uIEZyaSwgU2VwIDEyIDIwMjUgYXQgMTU6MjYsIE1hdGhpZXUgRGVzbm95ZXJz
IHdyb3RlOg0KPj4+PiBPbiAyMDI1LTA5LTEyIDEyOjMxLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+Pj4+Pj4gMikgU2xpY2UgcmVxdWVzdHMgYXJlIGEgZ29vZCBmaXQgZm9yIGxvY2tpbmcuIExv
Y2tpbmcgdHlwaWNhbGx5DQo+Pj4+Pj4gICAgIGhhcyBuZXN0aW5nIGFiaWxpdHkuDQo+Pj4+Pj4g
DQo+Pj4+Pj4gICAgIFdlIHNob3VsZCBjb25zaWRlciBtYWtpbmcgdGhlIHNsaWNlIHJlcXVlc3Qg
QUJJIGEgOC1iaXQNCj4+Pj4+PiAgICAgb3IgMTYtYml0IG5lc3RpbmcgY291bnRlciB0byBhbGxv
dyBuZXN0aW5nIG9mIGl0cyB1c2Vycy4NCj4+Pj4+IA0KPj4+Pj4gTWFraW5nIHJlcXVlc3QgYSBj
b3VudGVyIHJlcXVpcmVzIHRvIGtlZXAgcmVxdWVzdCBzZXQgd2hlbiB0aGUNCj4+Pj4+IGV4dGVu
c2lvbiBpcyBncmFudGVkLiBTbyB0aGUgc3RhdGVzIHdvdWxkIGJlOg0KPj4+Pj4gDQo+Pj4+PiAg
ICAgIHJlcXVlc3QgICAgZ3JhbnRlZA0KPj4+Pj4gICAgICAwICAgICAgICAgIDAgICAgICAgICAg
ICAgICBOZXV0cmFsDQo+Pj4+Pj4gMCAgICAgICAgIDAgICAgICAgICAgICAgICBSZXF1ZXN0ZWQN
Cj4+Pj4+PiA9MCAgICAgICAgMSAgICAgICAgICAgICAgIEdyYW50ZWQNCj4+Pj4gDQo+Pj4gDQo+
Pj4gU2Vjb25kIHRob3VnaHRzIG9uIHRoaXMuDQo+Pj4gDQo+IFsuLi5dDQo+Pj4gDQo+Pj4gSWYg
dXNlciBzcGFjZSB3YW50cyBuZXN0aW5nLCB0aGVuIGl0IGNhbiBkbyBzbyBvbiBpdHMgb3duIHdp
dGhvdXQNCj4+PiBjcmVhdGluZyBhbiBpbGwgZGVmaW5lZCBhbmQgZnJhZ2lsZSBrZXJuZWwvdXNl
ciBBQkkuIFdlIGNyZWF0ZWQgZW5vdWdoDQo+Pj4gb2YgdGhlbSBpbiB0aGUgcGFzdCBhbmQgYWxs
IG9mIHRoZW0gcmVzdWx0ZWQgaW4gbG9uZyB0ZXJtIGhlYWRhY2hlcy4NCj4+IEd1ZXNzIHVzZXIg
c3BhY2Ugc2hvdWxkIGJlIGFibGUgdG8gaGFuZGxlIG5lc3RpbmcsIHBvc3NpYmx5IHdpdGhvdXQg
dGhlIG5lZWQgb2YgYSBjb3VudGVyPw0KPj4gQUZBSUNTIGNhbuKAmXQgdGhlIG5lc3RlZCByZXF1
ZXN0LCB0byBleHRlbmQgdGhlIHNsaWNlLCBiZSBoYW5kbGVkIGJ5IGNoZWNraW5nDQo+PiBpZiBi
b3RoIOKAmFJFUVVFU1TigJkgJiDigJhHUkFOVEVE4oCZIGJpdHMgYXJlIHplcm8/ICBJZiBzbywg
IGF0dGVtcHQgdG8gcmVxdWVzdA0KPj4gc2xpY2UgZXh0ZW5zaW9uLiAgT3RoZXJ3aXNlIElmIGVp
dGhlciBSRVFVRVNUIG9yIEdSQU5URUQgYml0IElzIHNldCwgdGhlbiBhIHNsaWNlDQo+PiBleHRl
bnNpb24gaGFzIGJlZW4gYWxyZWFkeSByZXF1ZXN0ZWQgb3IgZ3JhbnRlZC4NCj4gDQo+IEkgdGhp
bmsgeW91IGFyZSBvbnRvIHNvbWV0aGluZyBoZXJlLiBJZiB3ZSB3YW50IGluZGVwZW5kZW50IHBp
ZWNlcyBvZg0KPiBzb2Z0d2FyZSAoZS5nLiBsaWJjIGFuZCBhcHBsaWNhdGlvbikgdG8gYWxsb3cg
bmVzdGluZyBvZiB0aW1lIHNsaWNlDQo+IGV4dGVuc2lvbiByZXF1ZXN0cywgd2l0aG91dCBoYXZp
bmcgdG8gZGVhbCB3aXRoIGEgY291bnRlciBhbmQgdGhlDQo+IGluZXZpdGFibGUgdW5iYWxhbmNl
IGJ1Z3MgKGxlYWsgYW5kIHVuZGVyZmxvdyksIHdlIGNvdWxkIHJlcXVpcmUNCj4gdXNlcnNwYWNl
IHRvIGNoZWNrIHRoZSB2YWx1ZSBvZiB0aGUgcmVxdWVzdCBhbmQgZ3JhbnRlZCBmbGFncy4gSWYg
Ym90aA0KPiBhcmUgemVybywgdGhlbiBpdCBjYW4gc2V0IHRoZSByZXF1ZXN0Lg0KPiANCj4gVGhl
biB3aGVuIHVzZXJzcGFjZSBleGl0cyBpdHMgY3JpdGljYWwgc2VjdGlvbiwgaXQgbmVlZHMgdG8g
cmVtZW1iZXINCj4gd2hldGhlciBpdCBoYXMgc2V0IGEgcmVxdWVzdCBvciBub3QsIHNvIGl0IGRv
ZXMgbm90IGNsZWFyIGEgcmVxdWVzdA0KPiB0b28gZWFybHkgaWYgdGhlIHJlcXVlc3Qgd2FzIHNl
dCBieSBhbiBvdXRlciBjb250ZXh0LiBUaGlzIHJlcXVpcmVzDQo+IGhhbmRpbmcgb3ZlciBhZGRp
dGlvbmFsIHN0YXRlIChvbmUgYml0KSBmcm9tICJsb2NrIiB0byAidW5sb2NrIiB0aG91Z2guDQoN
ClllcyB0aGF0IGlzIGNvcnJlY3QuIEFkZGl0aW9uYWwgc3RhdGUgd2lsbCBiZSByZXF1aXJlZCB0
byB0cmFjayBpZiBzbGljZSBleHRlbnNpb24NCndhcyByZXF1ZXN0ZWQgaW4gdGhhdCBjb250ZXh0
LiANCg0KLVByYWthc2gNCg0KPiANCj4gVGhvdWdodHMgPw0KPiANCj4gVGhhbmtzLA0KPiANCj4g
TWF0aGlldQ0KPiANCj4gLS0gDQo+IE1hdGhpZXUgRGVzbm95ZXJzDQo+IEVmZmljaU9TIEluYy4N
Cj4gaHR0cHM6Ly93d3cuZWZmaWNpb3MuY29tDQoNCg==

