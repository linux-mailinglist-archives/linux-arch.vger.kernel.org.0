Return-Path: <linux-arch+bounces-14420-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2B9C1D55F
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 22:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7E973474E0
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 21:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FBC315D43;
	Wed, 29 Oct 2025 21:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rn6ljm5A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lU86XwHd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE3330F927;
	Wed, 29 Oct 2025 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771714; cv=fail; b=J34HwNdGyZppCnu09medFfxt+lgD5zvVuhtbFiRvR307vWeLiJsbld4BsNzhlZN+B03eZF0+ZRLLXCWhur8a2B0tQ6k5aG6zuMrgArqMSWG0u5mfn2wevFE4M2eLuUiwVRP4jsyzXOpu0ZtKLsTruMK3Ejew4/4fVs4b4ktQegU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771714; c=relaxed/simple;
	bh=wJ4DiaRxkojOe2j4RkHUCLpDRwmjwgg1/+WhfieV/jE=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=EE5AHKgWW3zeHACwcSC6+ArPs+dfyXtyTqqB1UVnrJOs5wtAVC3zUncj5tyj5th8xj2e0UTCaitm+8J100ovULdeage2EryvG4n2Ir+/1TMB2J4TlBZ4M2sWjOjd+Ost3YJ/YzoaEoTnX0YhPx4KM5V+Le8caeTxXzPF89Li9+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rn6ljm5A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lU86XwHd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TKKwKJ016059;
	Wed, 29 Oct 2025 21:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=928d9Jcd/2D3K7btesbCJ67UpixpF0yq7s9kc52+0yY=; b=
	Rn6ljm5A14iXaU1E7L48U2CevFZ/6OOZveYdR2kyjmSZQgT1RMH02dr835qorwHi
	yZYuE5kxiFBBuuB//GP/e53Y87ivZRKguHukUYYzS8qFxHjPaO5PgoJfNZCQr7PW
	k0P44pJc68gNFM1jspUrJzrkL4/efwkj1GMwSdk5xao7ENUO6TMe96dcND3p5mAX
	GVeEuhAlp1enmThV1gS5bwj3FyUUSysLRATGQA0MoM8a16GDg8a+4xLlnM20/TtB
	WsIl1Xk1b+YVE4q8B+qMQAB6qKdVn6NmgLiAsioN7Pb8TaryCbThqjw5P3KgNv7G
	9A4YfW/YnMYTWiaqArwvZw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a33vxk0mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 21:01:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59TInw5x007704;
	Wed, 29 Oct 2025 21:01:24 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33wkrjr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 21:01:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z43QEIAUQ37qNyshsOUkGssyM6YhJYYjqkJt+8lHsl93xa3Ocy193Da11ThCCdl0mXdK+w+FbaAYQ2/0uoEj3Y5caOMJ8+l2TPtbGrVdIIQlTq/cyUcGa4GCQgXhLgCTF3oiMExBBKIrQDp3XuMvJTXWiTUfoFUxyVWcwdznhf86NYRQD45aciKpFHP/mIQpgy6toNHdiWwrZVDg9HMFW3IYCnqYSZ5KPwsNpxqi5Kn36mygPu5KI7//cnNddzAGw0iEmRz2Pk9FuPY2QKmechCpXqmqzxd/TuQB/gXijVVGDXJOcK2t5EMGjAtKEWgIVOiq+DD2s81hXbunfRiuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=928d9Jcd/2D3K7btesbCJ67UpixpF0yq7s9kc52+0yY=;
 b=FSeCdwCVTiGFJoKulNk70OF0F2q6sBjqoK0IBrz/bqXNx1roGBzfrbilj7uG0avK0C2TZ8j73hR1GjRIiHDUldZ4frgHP7tYhVak4lTwd0AgFTWhI5Yea+x1xdi0puPLSDfRfdQUd1E/CaeF6yrheh2Ru7H/yy1KY7YvKM2JfbCa9yT+u7sSRniqm5FA87WuXwWHZ9b2MrI0/P3TX4wHLYwGnd5BS5Ci5WsYxIq0WKtOUGPKkBxdk0ulDmlHvwkditmZmsINjrMZx5REzaUcBhQChYnSDiX60M2qxohrRfZwBbLsTk8Gw9si8aZl76d7D6IB/aygK90XMRThyxlPjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=928d9Jcd/2D3K7btesbCJ67UpixpF0yq7s9kc52+0yY=;
 b=lU86XwHdnhJSbfcrybHUl3FO13dmudvJ4fGsbfJLZyK8/2ok1+Ik+/ot0P8RVXalQMiMcBtzfTuNIjjYHWMWcPCvZE1OfZSyJTZO0bRE0zQCOUWmVwCcLdZeX9z4rd+Q5EW6IAH6v7mKu5YPNXGQvDXLccM2zhXF4dW4PyjjaTU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6507.namprd10.prod.outlook.com (2603:10b6:510:202::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 21:01:20 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 21:01:20 +0000
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
 <20251028053136.692462-8-ankur.a.arora@oracle.com>
 <CAJZ5v0hSvzHfsE4nrEW-Ey0dnJ+m=dSU-f1RywGNU0Xyi3jXtQ@mail.gmail.com>
 <87ms5ajp4c.fsf@oracle.com>
 <CAJZ5v0hQ7G9jvOv9VtRmsCKahBpUcPJMMOe07k_2mqsvggWcWg@mail.gmail.com>
 <874irhjzcf.fsf@oracle.com>
 <CAJZ5v0i5-8eO6T_-Sr-K=3Up89+_qtJW7NSjDknJSkk3Nhu8BQ@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, ast@kernel.org, daniel.lezcano@linaro.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [RESEND PATCH v7 7/7] cpuidle/poll_state: Poll via
 smp_cond_load_relaxed_timeout()
In-reply-to: <CAJZ5v0i5-8eO6T_-Sr-K=3Up89+_qtJW7NSjDknJSkk3Nhu8BQ@mail.gmail.com>
Date: Wed, 29 Oct 2025 14:01:19 -0700
Message-ID: <875xbxifs0.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:303:8c::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: a8dce0d5-acc1-48af-4686-08de172e4f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXJnR3IrM1lqaDZ3SVRUQnZqMHhnZjBDSHhKR0NUQVlicXFIeHUwZ01Cc1E1?=
 =?utf-8?B?bFV1MTNhK1oyUHc2WDRaOGN6dFJydnVwbVpBdjFBZW45Mld6YTZEYWhUYVYv?=
 =?utf-8?B?cUdqRXZLK0h1THFXckxTRDR0cXprSzVDZU1zUUkrSklnTmt1S1lyOEUzVUpo?=
 =?utf-8?B?RGxkRkI0c1V2eFRJR3o1T2ZXR3Y2ZjltMFd4QVZMSlhXcHZJWE5heCtlUHdp?=
 =?utf-8?B?REg4Q3pJaEVTVWlVVU53NUxrYmJ4ZUNvOVI0dDBBMklySWxOZFVEUEZNVDB3?=
 =?utf-8?B?cEx6VTNVeU93ajdVRmJJODFKZ0FQaDR3cno4V0U1QWhrSmtyRnVMLzN6UVBS?=
 =?utf-8?B?S082eSt2YWdEY2ZBMXJJTGNEaTNHek5jVFdTN09WZEVXdFJRbDRBYjFzaUI2?=
 =?utf-8?B?NzlXcVA4S0ZvMjBDN0FuanZPSG9SenZBSjdubHdtTHpTUkYyc013OXpNN0xK?=
 =?utf-8?B?WjNONnFmZkhIRjl3VFFNUnFaZjI3OHZyTzNCUzVDVzN2ZFNZOWFFZEdHUExC?=
 =?utf-8?B?VFZDZnlaZmNOVEJzK2p0NHo5VTFHenRvcU9UdnpneTJsTVpzNFRpNDNXNjZ4?=
 =?utf-8?B?YXEzRXg2QUNob0xubEhNTXNEWHhpM29BZ2xsa2RZQnRVM3g1Z014bHlna2w3?=
 =?utf-8?B?M0FZVG1iSUZ2enZsODdrUWdsbXBadmhYMFMwckFxS1MrNUtvSFZ1S3dhRW5H?=
 =?utf-8?B?NWtvZDJIVFNEY1pQd3J1N2R1L2pOek1aclhTcFg0ZGpjUUozRDkwMTdnT1lo?=
 =?utf-8?B?YzNaaUxGNnJSVTNyV0dOODU0NGNXMldEbFRiT0hnQ1phaU5wMnVsRkRmNkcw?=
 =?utf-8?B?SlRiWklBV2F2UW5BUisvM1RHZnJtMVJ0bjdua2lsMTZ1M1JVTVhBand3S1Rq?=
 =?utf-8?B?eTZIbC9QcVIvbG55RDFGU05WUDh3aERxREZnSVlGbmdIQ2hkLzRDV2Nqd3o4?=
 =?utf-8?B?NGx1K3VJWnkrVU5sV0lMUkM1QXovbDJ4YkZHMWV6NmRzQzdVckMwSlBReWQy?=
 =?utf-8?B?U1ZSU0FxUFZhMWxLWnNRdWdtbUZEbjhydS9ySWFYL1J4dWtpaHJmSE0wU2t3?=
 =?utf-8?B?OUZ2dU5IMWk1OWFsVFVDQmZwSk5WS29ic2JTRDJPRTJPMWRjRlBGZ0MzUzNI?=
 =?utf-8?B?aTFhNEdBRzZIVjFOVnFHOTZRNFNFR2hGbkN5N3hKTzMxMUVRM1FiUzVYZ2pP?=
 =?utf-8?B?WFdNSXpMbkh6T0FoQXNTQ2pwbjYxenMyNkZyd1djMllBYm80bE51aUw5RjNw?=
 =?utf-8?B?eG1EU0dhVjRxNmdUVEZYWmxRT2hKQkxyVjdLd0lRMVFud1lmT2NxSHIzV2xC?=
 =?utf-8?B?eGs0Mms4dEk2ZWNpZGxabWkyVEhWTDU4Z1lUcHl3NXo4TW1pVktxWlpZL1VI?=
 =?utf-8?B?ZE5jSnNrbXJqYnpXdjg5RFd5YjlOeG1iakwyS2dlUWY0bDZnNFhFZXNrL09L?=
 =?utf-8?B?M3dIckZPMGx2cXY5M2FNS01DWWtqUGY4RHFIOU5XbE1xNitaUU94ZWZMYWpM?=
 =?utf-8?B?R2Q2dDJ1NFFnS1hCK1dNa3M4UzFzNDVGY1JMWWVhYlk2S2pva1BDYWprcXdP?=
 =?utf-8?B?VVBySDhMcFlzZ1JVSlVjVUNTWDN6MlROSnZlNHlnaGZGUytqYWxOVXhqcW9F?=
 =?utf-8?B?QnNiakNjTDJJM0dtQWRDRC8yNDZpL2NuSTQxdkFuelp6c29MOUxWZU1oam0w?=
 =?utf-8?B?S0RIaC9FR1AyRVgrYk43QUMrazZzQ1Q3bkdhWmxTd0tFZmM4dUNIZ1JBekNF?=
 =?utf-8?B?ZEJGWnE2cFlWMUVJNHErS1hjR1IyTG84cWI3Y05XUERMMVNBNWs0N0cxN2hH?=
 =?utf-8?B?a3laMmc0RTUyNEtUWmdZOTRsQWZVdWhKM0E1alRYNnVONFVZeUpaSEZvaDlF?=
 =?utf-8?B?VExHU1gzcWdPKzZ6R3FTMGtyWElMN0FlenhMWFZUS1VJVytzMFhOSXJDZTF0?=
 =?utf-8?B?UHRjV1JDaUV5WVhUeWhwd2pKR3NHOUhMY0JUbTNZREhXM2VENXJtRVdLVCtJ?=
 =?utf-8?B?dW1mbURZM0pBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXhVM2MvZnZHaUd0VTBpMFplV3lkQjBOWXVFc0JiRmhGZUdmRjRWS3hwbDUx?=
 =?utf-8?B?Y2tzTkZkYjhpN2ZLRkVEM1FxSC9rZlM4MEc2MFJyNWh3NUs1NHExOWw0YitP?=
 =?utf-8?B?ZGMrTVBtb1hrQzVvYWdDWG5qS1UwSTJ6OVpHNFhGNm9pYVlDVjNSMkx5ZEl1?=
 =?utf-8?B?STJYaExzS3ZNVXhtcjFqazY1Z0NMM1Nqc2RMemtqUWNicWVJTDhDS1B2QnAz?=
 =?utf-8?B?aHpZc3IwUUh5Z2tIVmJoa1ZqS2RFdDVEUHRaa05rSXY2dWJNb1dXTzRFbjVT?=
 =?utf-8?B?cCtIUldybXhjR3R0S3pheE4xY2o4RmpYMG5FU2N1WHJmVDdYdDZhbVNOaDZp?=
 =?utf-8?B?VzlZNmZCQUF3UkVPRFRaYXZqa3UwZVdhMVZXUmFtSTkrcUk5QXlCUGdQNUs3?=
 =?utf-8?B?aGY2QXE5RXN3Z3hQZDNoN0ppMUlyQlVEb1MxOGEzNHFHRFFZUmJheHRPOGEx?=
 =?utf-8?B?SGNHSVlwVndlbGdiM3Ixakh1S1JpZ1d3Z2NvdDltTHJBbmFmSEpjUGRjQUdY?=
 =?utf-8?B?M2VHQVA5cVZaNm15cUhxTDliTW1Cd3BuMHpHNzJ4eWdCTFRRbHJpRDdQNVVi?=
 =?utf-8?B?UW9rNUZiRUVCTzM2Qmk0REE3M2hIYy9MSVJNZmYwc0xUVXFsK0xUWWhBd1Jp?=
 =?utf-8?B?dStCNEpkNGVmVHRrZnJGdmNKVTNJNm9NdE94MC8vcCtPRnFaYnkyMnZxWUk1?=
 =?utf-8?B?Y2N5MTFyWi9jckJFdW9rZVdRKzlBVjNwZmdRU2ZZUy8vNHEyY0NwcXB6SWtt?=
 =?utf-8?B?dmxFWkRqTTVqT1VpVCtuTjFvQzZKS2Nuc2lqVW9Ga1E0R2hhNVBBc2V6WlVO?=
 =?utf-8?B?Z1gzeTNwemY1WFJYajhNaGNiNk9oR0VQRExIZllWZUVpeWxUQmZhelJjVkhB?=
 =?utf-8?B?QnFLdVJvM0VGQXFkblpESU5SbmpUTDN5ZVk3RVpvckprUDBWUnM0VlUyRDl3?=
 =?utf-8?B?SmpJbXBFQno1ZXN0K3NDMTFVMkpsU0tFcjk3c3dXTDBzMGFnMkZyUUo1clRP?=
 =?utf-8?B?emJrM2FWUTUvanRYL1YxU3RGNTZ6U0xtdmZQaXcyZk1lR05yRmR6Skk2TzJO?=
 =?utf-8?B?SnhDTS93WXl6bStSU05pUkVtblR4cVdyUjRtNklMRWlzMFMxcVVGeEt4WHBF?=
 =?utf-8?B?TFluVG5KWEp5dW94UEw1K3BxS3NRRTFTWElzRnZTZXloSVB2MlhWYW02RXZq?=
 =?utf-8?B?TkM2aW1YYUlVVFhZYitJMzRzS0kzb3hzeDNtTS9xNlFYUktrZ1doU1hmWmpI?=
 =?utf-8?B?RllCeGRnZS8weXdmdnU3eVNhaHppYk1aTjVOMVBmYkxxUXAxWTh1c2M1M2FE?=
 =?utf-8?B?cDJ0WmphK3JjcTV4bmNKTzJpek1XaVBOOU5wR3NpSFJETmVta2Y4cWExSWhF?=
 =?utf-8?B?a0x2MVRZL2psenV0RHdZUUgvamkycVdzM1hYWnhhOW9XOGFhUVRZc0p3Y2Zq?=
 =?utf-8?B?ajAxZml3NzV6TWdhc08rY004OEhCUTdVYTkxelord041emR2cUx2dkFHVm1K?=
 =?utf-8?B?T1d6b0lsVlF1Skd1Q0ZmdFNJbld5MUp2RDI2MUp6aFpuRURMQWpPd002S2U3?=
 =?utf-8?B?RWpTWkYwc2lleGY0dGxMa2RIOUNVd1VUWVFmT010Qy9vekFhZGNwd0I2RnhS?=
 =?utf-8?B?TXdiQnd4UTVqc3RpK0ZxVzNneXRRSHE2NUliMWRvd25IZ01URjJhdTRNMHho?=
 =?utf-8?B?Z05lZHZqYU5DcmlEYm85aVRQYXZuYlMzN3dMWFNjZE1xdjY3NGJTZzhqQkRS?=
 =?utf-8?B?SFZLYWNnNi9QOWVEYUs0WlJhRmNPQmJ4YkJLUVpuSGtnS0R4eFlqNGVmTTIy?=
 =?utf-8?B?cGxtSEZKY0R4aDRlZXBRc3V3SkduVy9iRElUUU5yancvYUV1ZEplY0dQTGJC?=
 =?utf-8?B?bVNIcmwvN0E1bjcwcjlTeXE0Rys5dU54bGNtWWV5bUdEL1h0blFvV05vODdv?=
 =?utf-8?B?OUx5WExWbHVFNzRUZGFFL2RwcUs5WDFRTVFaMmNrVHBoN0NWeHJvelMwMDlN?=
 =?utf-8?B?TURnZ1pKMzJPcDJGNEM0K1ZFQ3FaS3lNVUZRR3ZMenp0RGJTMGVObUxMVzFl?=
 =?utf-8?B?TXBMZHRFMUpJSW91b0NjUG9RVG0yTUc1MUJxUENwZDRBczRBdjkrVEZ2OXBD?=
 =?utf-8?B?Q3JOUExnOFlSUVVUMVZjbU1uVStaYUZaTEhsYkh6TXgrQnZFUzg4UnlEUm1W?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QyWJN2B8P9mGL1RdFE21s9KjHYP5UtbzjmqVpfluxdpqpkxHnAK85IbBwkX4jAqYXLrLcraFNm1LmREgsHRLgqPNpPG6qf8HLcTHFRXcR+RzoSJIZtmfVzI3/wq/0CWkyLHQBWxg/C8CphCXRz5iPibxyeQRqWdFWhFBnOHElgpKoG9bWLmcC/6qlwJOQxT1cPj24qkUwxbvC9kAzvDQyUK6DwNAwK8dzxVjD4kFLXVKrQEtrMCDwOeaXkET1trzZ9SxDX3MQY+IcQgVL0Ue+EohZ184+/r/m+14iH2URpT2uqeXpnHf658L0Sh56ipxXLrc7UWK20G/qX9tZSuSREU5FhEdGcROxqvonWJKEt/LovY48KA2og3Ig+oNaOR5qJEMkEAqivCR02lq75APF0hemwcOT/MN2RuY+NX9aG9+Rb6G9wkGgvHdjxQ3IK59tfKkT0kk1nrDM1jDhVTf88HvXxuoVBuJe+bXlWf570jKo+w6jONUoKqeQzd1tYXIjxQfAy6AjTNXqiEAnKFllYXOAgIXWKGYRO/JKhsXfjsO5//iSGURw+lzHJnnEPTUWqec9cZdglesI2vTvbuS+9VldJwWYiHvZW5mz0GCgKs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8dce0d5-acc1-48af-4686-08de172e4f68
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 21:01:20.3621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEwNI2/k6TENNK8ZYuPvG8wIIUbjz+UaJCVNxpV41VbOHLN8rjInjPakf4EPky+yN2n7KusPR5XeaaB2y/MQK62a/ZxGqNFld9ZnqsNAYpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290168
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2MiBTYWx0ZWRfXy6UXgOWfxhwI
 pjVs5DHYWDNJH5v5Q0W0M65enVYfNburL0uoNllSCYk049vnSdUrWXYuDwpGtRK2u9cUBPkKZwu
 Nz1URCkf3rJKmTg+ZeVzfA0j5ledN4Ee/0zs8UgzeGTTDTwjX8/8JS/YMcxpdqlvAmUtBUjsn/w
 w4yTxwpnCVBewqETLyUs/SWY1JHgfT0Iak1WcSfs7jc4SICvS1HZap0vD/ZgAINpXEx1BfQo9cg
 V4/1yoO620KXKKZxchHFvzr8TkRcJssEsJ7IDJ7FsOoRo9o4vli61rO7h39YC2JPJCaqRu7G7zw
 wGKJzEaF9fwZHAG3ckIFpQc0HVeyeOqqJsddDP5/U1qtEvQm8t9y34Ko8Azk/lcM9RAWRmBFvtm
 Ek6uQLpEm6qYckMgnJOxOQ0OBZhydQ==
X-Authority-Analysis: v=2.4 cv=M/9A6iws c=1 sm=1 tr=0 ts=690280a5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=KKAkSRfTAAAA:8 a=eYBpZcj7JWe93EdAm2EA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: MhiuZn1p_HKgppU0JuTjSMRQVAXouJ0N
X-Proofpoint-GUID: MhiuZn1p_HKgppU0JuTjSMRQVAXouJ0N


Rafael J. Wysocki <rafael@kernel.org> writes:

> On Wed, Oct 29, 2025 at 8:13=E2=80=AFPM Ankur Arora <ankur.a.arora@oracle=
.com> wrote:
>>
>>
>> Rafael J. Wysocki <rafael@kernel.org> writes:
>>
>> > On Wed, Oct 29, 2025 at 5:42=E2=80=AFAM Ankur Arora <ankur.a.arora@ora=
cle.com> wrote:
>> >>
>> >>
>> >> Rafael J. Wysocki <rafael@kernel.org> writes:
>> >>
>> >> > On Tue, Oct 28, 2025 at 6:32=E2=80=AFAM Ankur Arora <ankur.a.arora@=
oracle.com> wrote:
>> >> >>
>> >> >> The inner loop in poll_idle() polls over the thread_info flags,
>> >> >> waiting to see if the thread has TIF_NEED_RESCHED set. The loop
>> >> >> exits once the condition is met, or if the poll time limit has
>> >> >> been exceeded.
>> >> >>
>> >> >> To minimize the number of instructions executed in each iteration,
>> >> >> the time check is done only intermittently (once every
>> >> >> POLL_IDLE_RELAX_COUNT iterations). In addition, each loop iteratio=
n
>> >> >> executes cpu_relax() which on certain platforms provides a hint to
>> >> >> the pipeline that the loop busy-waits, allowing the processor to
>> >> >> reduce power consumption.
>> >> >>
>> >> >> This is close to what smp_cond_load_relaxed_timeout() provides. So=
,
>> >> >> restructure the loop and fold the loop condition and the timeout c=
heck
>> >> >> in smp_cond_load_relaxed_timeout().
>> >> >
>> >> > Well, it is close, but is it close enough?
>> >>
>> >> I guess that's the question.
>> >>
>> >> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> >> >> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> >> >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> >> >> ---
>> >> >>  drivers/cpuidle/poll_state.c | 29 ++++++++---------------------
>> >> >>  1 file changed, 8 insertions(+), 21 deletions(-)
>> >> >>
>> >> >> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_s=
tate.c
>> >> >> index 9b6d90a72601..dc7f4b424fec 100644
>> >> >> --- a/drivers/cpuidle/poll_state.c
>> >> >> +++ b/drivers/cpuidle/poll_state.c
>> >> >> @@ -8,35 +8,22 @@
>> >> >>  #include <linux/sched/clock.h>
>> >> >>  #include <linux/sched/idle.h>
>> >> >>
>> >> >> -#define POLL_IDLE_RELAX_COUNT  200
>> >> >> -
>> >> >>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>> >> >>                                struct cpuidle_driver *drv, int ind=
ex)
>> >> >>  {
>> >> >> -       u64 time_start;
>> >> >> -
>> >> >> -       time_start =3D local_clock_noinstr();
>> >> >> +       u64 time_end;
>> >> >> +       u32 flags =3D 0;
>> >> >>
>> >> >>         dev->poll_time_limit =3D false;
>> >> >>
>> >> >> +       time_end =3D local_clock_noinstr() + cpuidle_poll_time(drv=
, dev);
>> >> >
>> >> > Is there any particular reason for doing this unconditionally?  If
>> >> > not, then it looks like an arbitrary unrelated change to me.
>> >>
>> >> Agreed. Will fix.
>> >>
>> >> >> +
>> >> >>         raw_local_irq_enable();
>> >> >>         if (!current_set_polling_and_test()) {
>> >> >> -               unsigned int loop_count =3D 0;
>> >> >> -               u64 limit;
>> >> >> -
>> >> >> -               limit =3D cpuidle_poll_time(drv, dev);
>> >> >> -
>> >> >> -               while (!need_resched()) {
>> >> >> -                       cpu_relax();
>> >> >> -                       if (loop_count++ < POLL_IDLE_RELAX_COUNT)
>> >> >> -                               continue;
>> >> >> -
>> >> >> -                       loop_count =3D 0;
>> >> >> -                       if (local_clock_noinstr() - time_start > l=
imit) {
>> >> >> -                               dev->poll_time_limit =3D true;
>> >> >> -                               break;
>> >> >> -                       }
>> >> >> -               }
>> >> >> +               flags =3D smp_cond_load_relaxed_timeout(&current_t=
hread_info()->flags,
>> >> >> +                                                     (VAL & _TIF_=
NEED_RESCHED),
>> >> >> +                                                     (local_clock=
_noinstr() >=3D time_end));
>> >> >
>> >> > So my understanding of this is that it reduces duplication with som=
e
>> >> > other places doing similar things.  Fair enough.
>> >> >
>> >> > However, since there is "timeout" in the name, I'd expect it to tak=
e
>> >> > the timeout as an argument.
>> >>
>> >> The early versions did have a timeout but that complicated the
>> >> implementation significantly. And the current users poll_idle(),
>> >> rqspinlock don't need a precise timeout.
>> >>
>> >> smp_cond_load_relaxed_timed(), smp_cond_load_relaxed_timecheck()?
>> >>
>> >> The problem with all suffixes I can think of is that it makes the
>> >> interface itself nonobvious.
>> >>
>> >> Possibly something with the sense of bail out might work.
>> >
>> > It basically has two conditions, one of which is checked in every step
>> > of the internal loop and the other one is checked every
>> > SMP_TIMEOUT_POLL_COUNT steps of it.  That isn't particularly
>> > straightforward IMV.
>>
>> Right. And that's similar to what poll_idle().
>
> My point is that the macro in its current form is not particularly
> straightforward.
>
> The code in poll_idle() does what it needs to do.
>
>> > Honestly, I prefer the existing code.  It is much easier to follow and
>> > I don't see why the new code would be better.  Sorry.
>>
>> I don't think there's any problem with the current code. However, I'd li=
ke
>> to add support for poll_idle() on arm64 (and maybe other platforms) wher=
e
>> instead of spinning in a cpu_relax() loop, you wait on a cacheline.
>
> Well, there is MWAIT on x86, but it is not used here.  It just takes
> too much time to wake up from.  There are "fast" variants of that too,
> but they have been designed with user space in mind, so somewhat
> cumbersome for kernel use.
>
>> And that's what using something like smp_cond_load_relaxed_timeout()
>> would enable.
>>
>> Something like the series here:
>>   https://lore.kernel.org/lkml/87wmaljd81.fsf@oracle.com/
>>
>> (Sorry, should have mentioned this in the commit message.)
>
> I'm not sure how you can combine that with a proper timeout.

Would taking the timeout as a separate argument work?

  flags =3D smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
                                         (VAL & _TIF_NEED_RESCHED),
                                         local_clock_noinstr(), time_end);

Or you are thinking of something on different lines from the smp_cond_load
kind of interface?

> The
> timeout is needed because you want to break out of this when it starts
> to take too much time, so you can go back to the idle loop and maybe
> select a better idle state.

Agreed. And that will happen with the version in the patch:

     flags =3D smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
                                            (VAL & _TIF_NEED_RESCHED),
                                            (local_clock_noinstr() >=3D tim=
e_end));

Just that with waited mode on arm64 the timeout might be delayed depending
on granularity of the event stream.


Thanks
--
ankur

