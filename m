Return-Path: <linux-arch+bounces-7780-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADCE993547
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 19:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E112283AE2
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 17:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A2E139CFA;
	Mon,  7 Oct 2024 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lq1nvugH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WEeAf/3K"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E7156E4;
	Mon,  7 Oct 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323172; cv=fail; b=Dlu7Vmrersnbn62pRFUvq/zGYjdnLyrVM7E1PLQYYNFgq0k76+s2Mm9mEHoZIcfc3tsXNMSiomzE0F86nh9CqDGkiZTrBvmgvMYBIrfjcAsv6XHEhbfSVESITlfmr8nsRr9kbYe5GR4eEG6lEGhDedbG4Mew+iupmN0cz0TLAPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323172; c=relaxed/simple;
	bh=SLQqK7c+hjpZwRtVGuF91V/0yiM7KbYg/CLUMvE0h1A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hXoWW/a4nTS+/iXked+NBa/4OD20EyENxI0YRdFw1t+772Yyaxd1FbLdrWJwZa5pz0aGwj0PzWmz4qEZpYJbb6Ik03DYJDJTW82zdMfyQ+k0dW97uAGF0XfEk6noFqHLop/j7IjPrIrKMrVm0+t0YaqujDQK/tzUO4XomAjQoTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lq1nvugH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WEeAf/3K; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMbSq022249;
	Mon, 7 Oct 2024 17:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=KwHW8pJ6r/ThJ46fF3R88Itzymx3V3qKrrZD8VTxhF0=; b=
	Lq1nvugHBdyxcIMIud3Dp7YvmkIHedzB2IdQ7XVMyDhTHDuiB0BKz6O1b+B68viO
	aRcuAZTVis3jrLHNGpPKSX9eTF7DZyvFlf6ohCK7C9XwPpbyTOl2t1+MwoEeIhLz
	o93kjTMH7VJj5satyCM1PGvhSUv7VjXLRBSZkgQ46a8QoF4k4ViIQoF39mefkdtL
	J+vozsZbNhABv6EX3nWKkmRrQFGxP93i6NmMQTLyh6x5TH2PP/yQqplZ3dPK0w2/
	QNRRMYIxVFyDyDAgBxDTyvpawz8zjtMRF0x0zh5kOg6socQJP7qFsAUuIzitJkhg
	pBmP1XmOZfXXazwMAtDr5Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034m5ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 17:45:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497GeFKl001166;
	Mon, 7 Oct 2024 17:45:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw64jtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 17:45:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t31SO1c/RvVWfF4VtsBkgWKTNaMcy5OE8FPzYATa0VENDxbFJ3LtAq6BXHVbY8k5vPU5yuPH6YTpj+m76mpSovoTsiAqbztVT84QjdSXcuWmCuGlCrEX4tCWxixYRgvTAO8bN3YVT/h6izusZSqEDMnttDrs9hFEVHMBh0+HRY3ejdFN5scR27z0bpjNSSR23mFhaAhudVYE89qFC2q2zyEgJPzhuVuAToIz8pFZru955beTLIerxChmynMrBy9tK+laWG184QY8oinYgQEXdhS59d+ESvAPuX3zi/0vMUJvlU0dzSd4QDj+Z5JTUFRRaBmmQ8OEZUA1rK23EJ4F6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwHW8pJ6r/ThJ46fF3R88Itzymx3V3qKrrZD8VTxhF0=;
 b=sm3FxbnU64EyTD8fQa2TP2OQSSpOJmpWVOMNsAVXFEOHPIHbWJaefgFg4uwlv54fnR/5KR67GiJFgt3xElfeWeTw8FDyFq4opCc+fPwbELmfuNWM6b2AHL+YWLzupwX7nwek44gGWl/Xd12hyk+nTj9NXz39fyo0SNt1h1/5DP1xDbGuJ4hz7wzyrPfUrI9tzOXhf98NQZmllnLmff9uzbnfdJ+y9HbEQ7huCW+LQI0XgL0q2LXMBRIUzESG/ULcZxuhWn2b1bihE4rVOdq0BZC0lQLdEaM11+Lz9vxDr2qtPKeuOl/m/Uuv0YFyWimim2I9+BS3X6q172J4rXSLlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwHW8pJ6r/ThJ46fF3R88Itzymx3V3qKrrZD8VTxhF0=;
 b=WEeAf/3KvX/M4pRpd3tb5iSg4Rkbj33cVndE/cXvyBIEr3fOwZkI1zWUlsLkAezxFMpRoy4TQ/7xBmOte+ASu1QbmljaoJz6saNIUVVaWtKqC+IZQHLByjQidR6zc6K+4fBTfr8eKsCgMNgOZuDYVPSn7Rolen3nMd1B+KjU/6c=
Received: from SJ2PR10MB7653.namprd10.prod.outlook.com (2603:10b6:a03:542::22)
 by LV3PR10MB7964.namprd10.prod.outlook.com (2603:10b6:408:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 17:45:28 +0000
Received: from SJ2PR10MB7653.namprd10.prod.outlook.com
 ([fe80::47d7:5812:ea42:38bb]) by SJ2PR10MB7653.namprd10.prod.outlook.com
 ([fe80::47d7:5812:ea42:38bb%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 17:45:28 +0000
Message-ID: <e7055187-812d-4626-9967-ecced27ecbfa@oracle.com>
Date: Mon, 7 Oct 2024 10:45:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 08/10] mm/mshare: Add basic page table sharing
 support
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com,
        viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org,
        andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org,
        brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
        rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
        pcc@google.com, neilb@suse.de, maz@kernel.org
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
 <20240903232241.43995-9-anthony.yznaga@oracle.com>
 <crakkuynbh373evxs5tbqp2jeq4h3rmvuprjq73sc3gjex6w5q@tnzempendkz7>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <crakkuynbh373evxs5tbqp2jeq4h3rmvuprjq73sc3gjex6w5q@tnzempendkz7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:408:e1::35) To SJ2PR10MB7653.namprd10.prod.outlook.com
 (2603:10b6:a03:542::22)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR10MB7653:EE_|LV3PR10MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1830f5-8aa5-4ceb-6b67-08dce6f7d4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTlYMWhLYldYeXVDNUNCK3ZQTDBtNzZ1T0pJSkdOOVRxNnNEMmlYeHU1QUFN?=
 =?utf-8?B?S3JkN3A0a1ZPbTRySllZRGkvVmZTZ1NHcWF3UUFlNm9yV09pSUZwMUxWVlBZ?=
 =?utf-8?B?aXNrNDNUOXk4UGl4NE5hNUVuUEJTYjJueU9sWEE2bzUrdVB6YXM4RnFiTGFG?=
 =?utf-8?B?bUI0OVZrYmtrV1dFL21EOGFweTVaRFgwUC8wTUw2SkRVM3hFNUZNQnQyT2ds?=
 =?utf-8?B?TVJRb0NJQWZFU1FDNFcxamZDZ25PZ3pUeVA5YndHL2ZtTlNYRGlDczVhTmFX?=
 =?utf-8?B?Y1VIRU45N01NVVo1Q2l2azdUZDZrT05TMDBRTHVFQTRtWVJGMGxlSVNYN3Rq?=
 =?utf-8?B?UHpvMWxvaXNua0dHTmNab1ZlUUVpVkVOc1Fyc29UK2pDRHlkcnZaenl2T3c1?=
 =?utf-8?B?cjRNU2kwZ3pQVzlQV2tsb1l6bkdwd2ZENVFDMzFJQXpVcm8wVHpia2lodXFh?=
 =?utf-8?B?cTZtTnJjK1dQMzlUK1dnYXVlOFhiVjJlWG9sNkIzenNuU2FKdmRSaS9pNU00?=
 =?utf-8?B?cU5RRHV6Vi8wY29nNkZuRXJ4cnJ3c2Z6emVZOEdFS1ZuNXBzWCtsdXdkMWdE?=
 =?utf-8?B?KzhkQkpJUGlDWkYvU3MwUEY0TWIySG5uNC9LQ0VoUW5NaWZJVyszN3BTaVNs?=
 =?utf-8?B?UmQyRGdxVjJ1Ti9ob3BQU0VwMG83YzZGaE9lT1ozWC84LzJ3cUJZbndDdWFM?=
 =?utf-8?B?QmNwSzFVZU1qeDFXdlQ5QTdrV3IweHNLcW5GZE44YVJxR2VsWmxrRGVVaSts?=
 =?utf-8?B?enBUam9LZFh3VHFpMGp4UGpxM2c3SjNuVHRZUUo1enJxM2I0SmlPVGZsNnly?=
 =?utf-8?B?cHJFV29EbzJRVTBFY2lNRkpKcklWSUZrVmVsQ09jVlVybG9RWEx3VTN5Z3F4?=
 =?utf-8?B?Zmd1Um9hdmJnaWtRRFNEbWhqazYxcnAxSHY5NWl5RGcyTXVmc2tWT1NCM3pE?=
 =?utf-8?B?Z0dzbTcxL0QyYmdVaTA0cGZDOGt1bXJhUjZ5cWNndDh0WkIrWXRaU0dLRG1Z?=
 =?utf-8?B?UE01YytzN1V0R0JIZ1M0VUhrSEdXL0l0U2RySm5oNHFjdTl0bGlIZ3lKclJU?=
 =?utf-8?B?NGduV3FpaDVPNXFZckM1WkhGU1hMK1ZPV2t3bjNjOGdJaEFTZzhKMkRPeHpP?=
 =?utf-8?B?UHFDSVpwZXd0dDBVR29rQ1dnazZzMVA1aTBXaS9QSkhqaTk0YjJRTXRySnZJ?=
 =?utf-8?B?K3paZWo1alVTL1pVcGpIK0xaTUcyamtpcXFaMHJ6UExpb2paVm1lcGdDVXBq?=
 =?utf-8?B?YUlTT1NwUnNsZU43bEx3NGs0cnZ3ek1Zd0lUVDBPOGt6cHNWWHVBR0xJRGIv?=
 =?utf-8?B?M2lwV2dFbEJySzhVazdKdExqWVBOU0RJUU5GbU52T1lKY0JmK29yMlcrWSs0?=
 =?utf-8?B?dVd1Wk5yTE5qbzZqVXV5SnptZStuWWFMSEZxOEc5b3FGVXprUVRkQWx4VGhm?=
 =?utf-8?B?VE9LRjd1cmlEVkZWeXFybzIwYjd0SVhTbGV1dDJucnpKa2Y2MTJNYXdsYkMy?=
 =?utf-8?B?Rm9IMWtPbEhMTGRWM21kZHh1R0NnSGN4c0Y5aDRuaXJjcWZ3WHhBWlZ5Q1ZD?=
 =?utf-8?B?aFpTSmluT1JrS2xsU2pYejlBVWRsVjN2VzFORko2NVNFMmVIbVVUVzJCMTdM?=
 =?utf-8?B?bE4xMmEvbHdZbnhsU1o0OHBzRmJOZEo4Y1ArK2JuY0QzeGJmRGRnc2wvelgv?=
 =?utf-8?B?cHgvbmhjSDRadlJubUJPTUJxZXU1c3MwN2crZXpWZ0FwMVhVTENlMFdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7653.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUxlcHhDL1dadWxtU2xvUm9vVFFkOXVhN1lFUDVHVys4bWJzQUhkMnFPaHB6?=
 =?utf-8?B?OENoVElHSVdLbloyeEpyVHN0bGVFeFZDcVBML0xNMlFQZENtUzFNbncwOGZJ?=
 =?utf-8?B?bHl2Yk5ja2xDMkJNY2g0WjZSZTNBcnM2RlZOb24yZHZOVWJ2UlF3MHFGbXB0?=
 =?utf-8?B?cVJwY0FpUnJySjFuRkhobDBCQWdGYlorclhRam41QVpiZGU2a2NGMDRwaDFL?=
 =?utf-8?B?VmI5d0R3QlZUVFo4dk5lQ2xZNGtRaTJXR1VFYzF6TXFBVzZiZ050R3k0dXhY?=
 =?utf-8?B?dmwvMTZiTW55ZGIyMURlU1pXQmFQNmYzNFBJaHcyZmJQYnFnL3lLQkNsOG83?=
 =?utf-8?B?eUl6M2JnYXU5WmVDcUtVRDU3a0hHbHYyRmhKanBaR3FXZlVMOTVRMThzQ0tU?=
 =?utf-8?B?RGxRVnNxMER1L1o1Rlh2Vnd1dVM4L3EvU1YyTWpkNlIrRTh6ZHpuM2lhTU9j?=
 =?utf-8?B?MkpKUWgzclZsSWRjU1kxYThrZTEyRCtyb01pZTVCVkdvai84bnArUUF2VWRV?=
 =?utf-8?B?a0NrZWdLaWhVdmljL3hkeENML29EYTlpZTMrWmc3U1ZsT3NOS29ZZnE3MjJm?=
 =?utf-8?B?V3Z1MVVnMVE3RCtYbTY5QzNJektlQXhmd0RTU21HOGk1ZWZRd1NjNzBBMHIy?=
 =?utf-8?B?d1ZHVXFjd0hOc0xQNURONjMyTnIyN0V6V0NQODUxbDcxbVhLOG95aFFCY0pj?=
 =?utf-8?B?T05tU2tBK0ZxcnNmdWtzajdsMHF4OVZBT1BoNGh6SHNQUUJtWWo5NG5veG9G?=
 =?utf-8?B?L3FnVVNJR3ZYWmoyTEpOT0VSQjc3L3RwVkVyOFlBNitHdlRycWpqWDY4dWRo?=
 =?utf-8?B?YkY4bEdveDA0aW5UV1hTK1UxWXo4MmI2c3d2S3FKMHV2Vk1OMG9iWWRJUURq?=
 =?utf-8?B?bzdtNXVGb0VIVFg0MTFFd0Y4VnAwOVIwZ3VrY3lYckJVSjNoaGZIRFFLMElD?=
 =?utf-8?B?ZCtXT1VMM0FPYnV5SkdpN1pmODVRbXljdWtIRWVNK0ZhVG5CSU1GZmhhSm9D?=
 =?utf-8?B?S3ZPdk1lVUttd09ZaXgyR1lLQVZxK3pjRFZBN0pnb3V6R0VwZ1NzWkFBL2FO?=
 =?utf-8?B?ajR3b255d3hxQ0FaSUU1SDBGTWgyRXFHYWtCVVVGblhqZHl5cUFpaXhEYVJT?=
 =?utf-8?B?d2dpdHZTclVNWDk1SkZCQ3Y4a25aNDlyT1RXQURTNkdDblFkOGdLeW9udHpO?=
 =?utf-8?B?WWN5eGY1UUNlS2p1RzZYQzBaWU1yWVhPdHFST3hwYUJ2TXNPL0tUcjFHQ0hS?=
 =?utf-8?B?UU00WnVXcHNXU0szTzl4QTkxNDliWDFhc2lKT1BjcDc4WlBncEpFVG90cEF6?=
 =?utf-8?B?SUJpWHA4eFQxaklHdGd1SDM2S2VteFg1d1NDcTlISlV4TWM3Z0VMajhQZ2RP?=
 =?utf-8?B?WnlWWC9aQ0RIYzZFekJNektuVnhZOU5OK1pVSHYrcVowU1RjdnVVVDBZSWVO?=
 =?utf-8?B?U2NUczBqaytrbzJhcUt4R2RYWTVoeWRJbDFObEpQZ056WWNtZ05QQ09UbkhJ?=
 =?utf-8?B?aUZpME9Vam5walVxL3ZKTFRzcHBRdktyZXh6V1QwdzdncFJza1BFSk5JRjBP?=
 =?utf-8?B?cGl2WnhGOFZ0VjM5R1NJUExFaXRHdFNTRGdrUVg0TW1ERkU0ZU5KSnFVZFN3?=
 =?utf-8?B?WTh6a0FUU2FVbmVNMkwydGdodU5Ib2YxY0t1K0JhQ3h3OXNZL3I2N1NiZWo1?=
 =?utf-8?B?M3F1UU9nMThQYmM2emVNZzcyVFlVclpObmtDT3RVRUdKNFNQOGxkaHh2YzVj?=
 =?utf-8?B?MXAyUVp5eStUQlVTVFV4LzlhNzBUMTZuVWFDamVyQTBIbFB6S0VOcjYrRDNl?=
 =?utf-8?B?MktwOHVYZ0hoeXB0bXpMMDFkTzQ1ejRSNGtVZVdYR0pVUk9IVWUwY0htZEhC?=
 =?utf-8?B?UWkxSjRadHBDcmplVGhiVS9PQytoVDRvWUNkRzFuVE5sVXVFUG10ejVUV1pT?=
 =?utf-8?B?aWxpTVprODVFU09VeHBBd253S2JIcGRzRm92b2VkTWpGaWhvOWQyb1lscWlp?=
 =?utf-8?B?cjRrVytvU1pqSWtMM3Q5N3hDcmdzV1U2OTdHQnE3RUVReUQzMk5wMHA5SG9C?=
 =?utf-8?B?WGI5SGpCN01uQm9NNXFZWHFmSnhoWnA5Yk1RRlBjSTZnTVExN2czZW9rcU5M?=
 =?utf-8?B?cVJXTnFyb1RiWmxlampxdm14cW5oMkF4RDVNMWxKL2FsNTZ4NGNlbWQ3WCtQ?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b9ujjEZ0rwn0hxKhMn+il3WuzgYKSprsthS5xvOPL4/2zTI4kpHix1M5Ee47C47xMgfjQN2kNnFdL8K3ZGOPlR8qJGIuRtMQaL/5IneRKwUcXDlDSzC4AJvAP5oWWyUos2yVr67ZELoCjSAxNMBskxitLbQdTP15TSz70LCD95wytQDKy59VAfeRO3puyrvxjWKLqWhThkogro/erJ9mBiZCmLmyomiQD0y2puh9qvjws9V10aW+AmxFK0ktahIOG9HO0eBAoFSki/jqApmWNskNVq7DSbEwAuGTmlTfJbMCuUZBG/a5YR53IfFFqL7u5r4CRLp/0ktelF1/Pe5qJlFqhpwmmC6+EIh/tNHLMlifHzWeCZBq/ax+fqnMwRT0jnlAc0CLdMaDiXj+LDg4m8l69wOtq9xnFlCU6ujaygSDsZe69Xr4pE+PdoqoZj7uQ2wUvOft7SmjuYebkJQgs858BY98DH1xidw3HKSLyrp7yricBI7mI7wuD1DGdR+n+bMmTn9nUX2uvsDCBuq3N5Ib3VH1uJA36SIIzVZRnNcIW9Ev4G6pZO9qagNvWSZh+wOlJU2V6yltJILsFo7l1bbHyHitMgn+NBpCHjBBIcM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1830f5-8aa5-4ceb-6b67-08dce6f7d4c6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7653.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 17:45:28.2643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SivdN8gNo3T0KxNmTOYTH9ed/gKgGUhgNsOJ7Sn7MBecug1URAV6j7Jd40laCHx82J3tCqw1XichvJDo6i+xh49heI14DMjTUARKKTrw8hQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_10,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070123
X-Proofpoint-GUID: hYbF6AVnBVmE58-inyC0YuXDJG1yf26f
X-Proofpoint-ORIG-GUID: hYbF6AVnBVmE58-inyC0YuXDJG1yf26f


On 10/7/24 1:41 AM, Kirill A. Shutemov wrote:
> On Tue, Sep 03, 2024 at 04:22:39PM -0700, Anthony Yznaga wrote:
>> From: Khalid Aziz <khalid@kernel.org>
>>
>> Add support for handling page faults in an mshare region by
>> redirecting the faults to operate on the mshare mm_struct and
>> vmas contained in it and to link the page tables of the faulting
>> process with the shared page tables in the mshare mm.
>> Modify the unmap path to ensure that page tables in mshare regions
>> are kept intact when a process exits. Note that they are also
>> kept intact and not unlinked from a process when an mshare region
>> is explicitly unmapped which is bug to be addressed.
>>
>> Signed-off-by: Khalid Aziz <khalid@kernel.org>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>> ---
>>   mm/internal.h |  1 +
>>   mm/memory.c   | 62 ++++++++++++++++++++++++++++++++++++++++++++++++---
>>   mm/mshare.c   | 38 +++++++++++++++++++++++++++++++
>>   3 files changed, 98 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 8005d5956b6e..8ac224d96806 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -1578,6 +1578,7 @@ void unlink_file_vma_batch_init(struct unlink_vma_file_batch *);
>>   void unlink_file_vma_batch_add(struct unlink_vma_file_batch *, struct vm_area_struct *);
>>   void unlink_file_vma_batch_final(struct unlink_vma_file_batch *);
>>   
>> +extern vm_fault_t find_shared_vma(struct vm_area_struct **vma, unsigned long *addrp);
>>   static inline bool vma_is_shared(const struct vm_area_struct *vma)
>>   {
>>   	return VM_SHARED_PT && (vma->vm_flags & VM_SHARED_PT);
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 3c01d68065be..f526aef71a61 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -387,11 +387,15 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>>   			vma_start_write(vma);
>>   		unlink_anon_vmas(vma);
>>   
>> +		/*
>> +		 * There is no page table to be freed for vmas that
>> +		 * are mapped in mshare regions
>> +		 */
>>   		if (is_vm_hugetlb_page(vma)) {
>>   			unlink_file_vma(vma);
>>   			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
>>   				floor, next ? next->vm_start : ceiling);
>> -		} else {
>> +		} else if (!vma_is_shared(vma)) {
>>   			unlink_file_vma_batch_init(&vb);
>>   			unlink_file_vma_batch_add(&vb, vma);
>>   
>> @@ -399,7 +403,8 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>>   			 * Optimization: gather nearby vmas into one call down
>>   			 */
>>   			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
>> -			       && !is_vm_hugetlb_page(next)) {
>> +			       && !is_vm_hugetlb_page(next)
>> +			       && !vma_is_shared(next)) {
>>   				vma = next;
>>   				next = mas_find(mas, ceiling - 1);
>>   				if (unlikely(xa_is_zero(next)))
>> @@ -412,7 +417,9 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>>   			unlink_file_vma_batch_final(&vb);
>>   			free_pgd_range(tlb, addr, vma->vm_end,
>>   				floor, next ? next->vm_start : ceiling);
>> -		}
>> +		} else
>> +			unlink_file_vma(vma);
>> +
>>   		vma = next;
> I would rather have vma->vm_ops->free_pgtables() hook that would be defined
> to non-NULL for mshared and hugetlb VMAs

That's a good idea. I'll do that.


>
>>   	} while (vma);
>>   }
>> @@ -1797,6 +1804,13 @@ void unmap_page_range(struct mmu_gather *tlb,
>>   	pgd_t *pgd;
>>   	unsigned long next;
>>   
>> +	/*
>> +	 * No need to unmap vmas that share page table through
>> +	 * mshare region
>> +	 */
>> +	 if (vma_is_shared(vma))
>> +		return;
>> +
> Ditto. vma->vm_ops->unmap_page_range().

Okay, I can do that here, too.


>
>>   	BUG_ON(addr >= end);
>>   	tlb_start_vma(tlb, vma);
>>   	pgd = pgd_offset(vma->vm_mm, addr);
>> @@ -5801,6 +5815,7 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>>   	struct mm_struct *mm = vma->vm_mm;
>>   	vm_fault_t ret;
>>   	bool is_droppable;
>> +	bool shared = false;
>>   
>>   	__set_current_state(TASK_RUNNING);
>>   
>> @@ -5808,6 +5823,21 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>>   	if (ret)
>>   		goto out;
>>   
>> +	if (unlikely(vma_is_shared(vma))) {
>> +		/* XXX mshare does not support per-VMA locks yet so fallback to mm lock */
>> +		if (flags & FAULT_FLAG_VMA_LOCK) {
>> +			vma_end_read(vma);
>> +			return VM_FAULT_RETRY;
>> +		}
>> +
>> +		ret = find_shared_vma(&vma, &address);
>> +		if (ret)
>> +			return ret;
>> +		if (!vma)
>> +			return VM_FAULT_SIGSEGV;
>> +		shared = true;
> Do we need to update 'mm' variable here?
>
> It is going to be used to account the fault below. Not sure which mm has
> to account such faults.

The accounting won't work right for memcg accounting, and there's a bug 
here. The mshare mm is allocated via mm_alloc() which will initialize 
mm->owner to current. As long as that task is around, 
count_memcg_event_mm() will go through it to get a memcg to account to. 
But if the task has exited, the mshare mm owner is no longer valid but 
will still be used. I will just clear the owner for now.


And a quick note on calling find_shared_vma() here. I found I needed to 
move the call earlier to do_user_addr_fault() because there are 
permission checks there that check vma flags, and they need to be done 
against the vmas in the mshare mm.


>
>> +	}
>> +
>>   	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
>>   					    flags & FAULT_FLAG_INSTRUCTION,
>>   					    flags & FAULT_FLAG_REMOTE)) {
>> @@ -5843,6 +5873,32 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>>   	if (is_droppable)
>>   		ret &= ~VM_FAULT_OOM;
>>   
>> +	/*
>> +	 * Release the read lock on the shared mm of a shared VMA unless
>> +	 * unless the lock has already been released.
>> +	 * The mmap lock will already have been released if __handle_mm_fault
>> +	 * returns VM_FAULT_COMPLETED or if it returns VM_FAULT_RETRY and
>> +	 * the flags FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT are
>> +	 * _not_ both set.
>> +	 * If the lock was released earlier, release the lock on the task's
>> +	 * mm now to keep lock state consistent.
>> +	 */
>> +	if (shared) {
>> +		int release_mmlock = 1;
>> +
>> +		if ((ret & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)) == 0) {
>> +			mmap_read_unlock(vma->vm_mm);
>> +			release_mmlock = 0;
>> +		} else if ((flags & FAULT_FLAG_ALLOW_RETRY) &&
>> +				(flags & FAULT_FLAG_RETRY_NOWAIT)) {
>> +			mmap_read_unlock(vma->vm_mm);
>> +			release_mmlock = 0;
>> +		}
>> +
>> +		if (release_mmlock)
>> +			mmap_read_unlock(mm);
>> +	}
>> +
>>   	if (flags & FAULT_FLAG_USER) {
>>   		mem_cgroup_exit_user_fault();
>>   		/*
>> diff --git a/mm/mshare.c b/mm/mshare.c
>> index f3f6ed9c3761..8f47c8d6e6a4 100644
>> --- a/mm/mshare.c
>> +++ b/mm/mshare.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/spinlock_types.h>
>>   #include <uapi/linux/magic.h>
>>   #include <uapi/linux/msharefs.h>
>> +#include "internal.h"
>>   
>>   struct mshare_data {
>>   	struct mm_struct *mm;
>> @@ -33,6 +34,43 @@ struct msharefs_info {
>>   static const struct inode_operations msharefs_dir_inode_ops;
>>   static const struct inode_operations msharefs_file_inode_ops;
>>   
>> +/* Returns holding the host mm's lock for read.  Caller must release. */
>> +vm_fault_t
>> +find_shared_vma(struct vm_area_struct **vmap, unsigned long *addrp)
>> +{
>> +	struct vm_area_struct *vma, *guest = *vmap;
>> +	struct mshare_data *m_data = guest->vm_private_data;
>> +	struct mm_struct *host_mm = m_data->mm;
>> +	unsigned long host_addr;
>> +	pgd_t *pgd, *guest_pgd;
>> +
>> +	mmap_read_lock(host_mm);
> Hm. So we have current->mm locked here, right? So this is nested mmap
> lock. Have you tested it under lockdep? I expected it to complain.

Yes, it complains. I have patches to introduce and use 
mmap_read_lock_nested().


Thanks you for the feedback.


Anthony


>
>> +	host_addr = *addrp - guest->vm_start + host_mm->mmap_base;
>> +	pgd = pgd_offset(host_mm, host_addr);
>> +	guest_pgd = pgd_offset(guest->vm_mm, *addrp);
>> +	if (!pgd_same(*guest_pgd, *pgd)) {
>> +		set_pgd(guest_pgd, *pgd);
>> +		mmap_read_unlock(host_mm);
>> +		return VM_FAULT_NOPAGE;
>> +	}
>> +
>> +	*addrp = host_addr;
>> +	vma = find_vma(host_mm, host_addr);
>> +
>> +	/* XXX: expand stack? */
>> +	if (vma && vma->vm_start > host_addr)
>> +		vma = NULL;
>> +
>> +	*vmap = vma;
>> +
>> +	/*
>> +	 * release host mm lock unless a matching vma is found
>> +	 */
>> +	if (!vma)
>> +		mmap_read_unlock(host_mm);
>> +	return 0;
>> +}
>> +
>>   /*
>>    * Disallow partial unmaps of an mshare region for now. Unmapping at
>>    * boundaries aligned to the level page tables are shared at could
>> -- 
>> 2.43.5
>>

