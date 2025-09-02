Return-Path: <linux-arch+bounces-13359-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD52B40F68
	for <lists+linux-arch@lfdr.de>; Tue,  2 Sep 2025 23:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 031BE7A9F88
	for <lists+linux-arch@lfdr.de>; Tue,  2 Sep 2025 21:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356742FD1CF;
	Tue,  2 Sep 2025 21:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qdsTS7/t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fOuWSRMl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A9F2E6CA1;
	Tue,  2 Sep 2025 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756848699; cv=fail; b=WLFVsjVFw7pphj9G0b7jxGaPtZD3j8Plpt/Kte4z7MPvZpwuksUJImlrXFVWqS4MMQd75P1c1F5S2T7DWJvSZcpBK4zBAb0sM+4pDCgcikiO0Ezm5c1q27/RvA9kI/Ow3AtxP1hhCLi5QwytRENiks86KveZxSJYljf926GpulE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756848699; c=relaxed/simple;
	bh=d67cE6LnUkkaCnmbWIdXdzePvYq2/y75tvmb0a7L7BQ=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=Cice/x0oXBbevZPMfPpO9oOmqOVTONZwZHpN2uwYbD7DjG2DahBQHlM4NvAD+XmXctZaFJLU8c+j22uC2mwL0/Zo+giH1O3oDzmCwiY3INYDn/zUJe5hjVEQuBq1VGY1uKFJeQwrFapA1Nd4/uEZ6LWbps4ayZv7uv9a1tPZ2VA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qdsTS7/t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fOuWSRMl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Ki2j5022919;
	Tue, 2 Sep 2025 21:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FWD5iNqtm9RyOWxK76UXaY76EVzJOGCmebp18Z5yABM=; b=
	qdsTS7/trbmLN99QzUTdzCnmZquuBlyEFYeY/Vf2U/WeDC6l3uEWuHPjr0OOcWmB
	fKxQ7GLG4QJOihWscRJfz2i+heNvVvSlOcY1s6rThh+T05FVlKJ2SCLDXRUEHWdE
	+EWqKXoF1QWgYSWHySLyEA6p8Wj8L6ebkGPZ4obPSySGUN2/eJWdk16LxWQbqzC1
	/k1khtBKHoCOeFw4V5yTonBYE9CWn7uhzznxueMd+S/BUspW+5i6m0sKMtRGM+9X
	JBA/kiV1VkFEcB4fplKEncEK0KP+9UfII24MgI0w3/bm24/FcNDvJqU40fj/DXov
	URB+NqcbJDe3tGw4LwziEw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usm9n57x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 21:31:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582K6rYw015744;
	Tue, 2 Sep 2025 21:31:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01nvtaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 21:31:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qr0J+SFQLhx8mVWVWO41snZyUXFVfEYJKr09nkpjqQCAs7Hl8tSRyJP/x94OyfrafAT8oQmHsV2Ha3feQWIRtz0exphV7zunBGWG7c0+O3afcYWqYvUECp0MqTyiOhUPbczMbYKlGMTRtYwjEWc8BirouR/lnkDY2yGsW9+4DPi0YmmLafjuH9i3PV4WStMsPu2amrY1AAZfc21bDFCvNzuoXq1nAqxn/mS17M+ZwA3mTYKorxwoILHr3Cw2bXA17k+70j3o0DVuxusJRpEHEtyHqDYSAJK89yOa7lYYqU+VWDOqmsIJ9SuxneIq3v9693NxOaio6i6ngdCSh0Wj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWD5iNqtm9RyOWxK76UXaY76EVzJOGCmebp18Z5yABM=;
 b=iJrDAxXACkaB3wB6Z5B36Y1XZdnPPEi9EZxL+IZSqDyhreeyjfo30Y8wHPdwvwH6VsAfR7QHNQ9hjE1XMjcKMPhJuBOJXawDXiovf+2WqvXY0ZsqOewwsctg4XRTMITodnfzypPBjPGOYICds4OzHnkOCC3u8bnaCN4O5YArvTym6iIiQePV31kUK3ydTe1xEnUght1XwuMYCenqAK1bw/jF3zRE3001/+yk7dJlbGyMv3piT+pfPqB6VROmMa0X8C4tSPfAHEq+qVw+kF7B9d6YGUmWZvTdJdSwuk0uvg2S1mFe/uslpcerzVMwkFgxxgxnz0XgnQg7wewbwQerFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWD5iNqtm9RyOWxK76UXaY76EVzJOGCmebp18Z5yABM=;
 b=fOuWSRMlAbELwSla0A+UY9KAwSP9b5HRfoVo3tDrhsQgKdhXkjMVSbrEV27nVwHfOd4c5kjCHmoonj701FzVRAN3YtuOC/hw6US6Ejyb8o18vhDsqgkBLtOrLVY1FDIQIpEGCGNd63j9GcZ3AMKyx/+8AsQ45g3QsxUcHUvc0mE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 21:31:00 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Tue, 2 Sep 2025
 21:31:00 +0000
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
 <20250829080735.3598416-6-ankur.a.arora@oracle.com>
 <aLWDcJiZWD7g8-4S@arm.com>
 <CAADnVQJf317mXSDLs=K0pzTDGqMA8vqSDoNm5=LvEst6kdAi6w@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Ankur Arora
 <ankur.a.arora@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>,
        bpf <bpf@vger.kernel.org>, Arnd
 Bergmann <arnd@arndb.de>,
        Will Deacon <will@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark
 Rutland <mark.rutland@arm.com>, harisokn@amazon.com,
        cl@gentwo.org, Alexei
 Starovoitov <ast@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, konrad.wilk@oracle.com
Subject: Re: [PATCH v4 5/5] rqspinlock: use smp_cond_load_acquire_timewait()
In-reply-to: <CAADnVQJf317mXSDLs=K0pzTDGqMA8vqSDoNm5=LvEst6kdAi6w@mail.gmail.com>
Date: Tue, 02 Sep 2025 14:30:58 -0700
Message-ID: <87plc8r17x.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:303:6a::25) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: 4226aeb6-efdc-499d-bfe3-08ddea6802be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnpsbkhheS9FNFRzYkxUSU9idHlhTGVHSllTNDFEUnozZWk0K3RBTjEwdW1Y?=
 =?utf-8?B?ajJWcVFNZmR4MmRlQTlObEtvQUJrSnhueGFWZllUeFBpYlJ1TXhCS3A4V04w?=
 =?utf-8?B?NXJrNFc0RjFhSUQzOXc5Z0M4S0xLS2ZBVmdKMnlLV1BacnoyYzBMMGJIZXc2?=
 =?utf-8?B?Mk5DNHVrV1VCSHk4Vk9yUEsvVUR3c21TcjQ0ei80aHRQSCt5YU00MG5ybVdm?=
 =?utf-8?B?MWZoNi9pem40Mk5PMkFQbk5DZkVIc2N6THdsUXRmQmN0NTF1SEVMWk9mbE82?=
 =?utf-8?B?M3hxNk9ucDZ0N1p5VkFTd1lZcmVSVm9jWVpQV2lvUDk2N1pOcERWWmllR2xH?=
 =?utf-8?B?ZEo1TGFvZ3ROQ1lPVXRBM2hpV0haMW9haFY3WFRHeHNWRFdtcHFpNXJDcmQ2?=
 =?utf-8?B?a0d1d25qWjR0UWhHY0tOMHNjVnFjMmdveWljd0RVc1kwV1dxVVhkOVU1UU83?=
 =?utf-8?B?WVNPWjFZZStqYkRFY0xJRUJyOVB4VTROU2svSlUvMUpNZk96N1J5VjY0c0Y2?=
 =?utf-8?B?ZzJ3Mlh1YUhBTHZOeWZYYVdCd1krQTlSREpkZ09ickt1MHQxY3lkUmVNT1hW?=
 =?utf-8?B?QmIyWFdXRy9PSWlnQjhoRkpqMEpDQ25TWDVPcy9OUWcrYTRzRFZQL2MzaE9B?=
 =?utf-8?B?dVV2bitWajE1M0R2cHMvcFJlMWg2SkFKNEZncWNhREs4S096RUNrYXR5alNB?=
 =?utf-8?B?bEwxbFZNUGlJMUlCOWlwaGZOTGVkYThFUXdONGZWMnlzRWRKNHd2TmZkcEY1?=
 =?utf-8?B?TjRWbzY0VjFKZ0JDZ0Zac2JtZUZqYTVERjJhYzhXMUhJRmxKeU02Ykl1YW5Q?=
 =?utf-8?B?V1hlaUxpWndDZFFVTkU3V2k4V25LbUh6Zmlud2tRUDJwOHZ1NWFScFdjTTBn?=
 =?utf-8?B?SzdZQlk1NzlON0UzcEp5a2ZmL1RBKzk2SS83OFhLVFJudXk2ZXB3RnRVaHVU?=
 =?utf-8?B?REx5ZllldUZPNEtXbmxXZG56cWpMZzBTNmczRndHdnUvendhT3h1V05PUHR0?=
 =?utf-8?B?Q1FIdWtBTzJ4WFFBcmlpUTk1aitnTzRxYnFMTnNvWFJSekQwc0s0aVhzQ0lE?=
 =?utf-8?B?dkt3RGlxbElmYUFnSzh6NENZTVgrdVlqWmVDZHFFbGJTdW5QbUxRaUNIQ0N1?=
 =?utf-8?B?WGdiRnltMGtpN3lHamtmb0lSTjFkV3FjTFZtOGdZVWh0WGNUTldvWHd3K1ND?=
 =?utf-8?B?TDFtbFRsT05VTUo3WnowQ2MxVHE2cEFHZ0IrdlV4L1pKYWJwVjRoczZQNnk3?=
 =?utf-8?B?aDJ1ZDYwQ1lvS1RmNlJrUk1vS3piZXpremp4bkFQVFFiQ25zcUtFc09JRFpB?=
 =?utf-8?B?QWJlVDFVM0pwYU1UNmZIU05CeWp6ZFp0K3NqaVN6R1Z2djhBQ0swVTNOT2JU?=
 =?utf-8?B?TDVVa3A2Ulc2Sk5pbHl5dFVvSVc3MWFLYklGQzNVbDdaUWZ5WnpkWjAzUUhv?=
 =?utf-8?B?a0lTeW90NjdvVEJyMHdDWUVqS0JKZDVzMDA0dXVqREkzdk5oRDltOU1QNk9G?=
 =?utf-8?B?d3JGeXpkcEMzQk1jZlR2S21qYWV5bk5HQmVBbWlNNGFWNkx2S3lBZyt1YTdr?=
 =?utf-8?B?R2o3blkyUy8rZGFoRSthMUtoaVdmVUUvVDNQVEVzcDFPRXdvcUhoOW5KL0xS?=
 =?utf-8?B?aW9vQ1dHdFcvS25QdWg3NkxhZnJjOWpFUENFN0Nsb1c2NUNCcmpNYzBYV1Fv?=
 =?utf-8?B?dDdpeEJYOGhYNzdCZUVMNG0rQktOdlB3UFRQOVdEYVBUVWFRbGtpdWlXSXV6?=
 =?utf-8?B?VVVFc2Z6Z3BaOTU4ZGtHRjJHRDlCcFc2T1lacjBEMGVaV1Zha093SDRtcXQ4?=
 =?utf-8?B?czlaR2thdlJmQmp4VTBDODhsVkVENjRNSjFQbXk2VkxtSjNMc1U1RWJrbmRI?=
 =?utf-8?B?MWRKcDdKakRleU5pVXhQRklVWDFaK0tWaEE3Z0ZsdGpKenBSMXlKaEQxVDBy?=
 =?utf-8?Q?qjBVtZPEFrQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXVhMDJlMFNhTWN6azZ2bmFobFcyZDZqUjljU0xINXhXa0w5ZWkzcmdEcUti?=
 =?utf-8?B?dDFOalkva21qWE95bUZSc2I2WWJ2eDl1a1c2TlNnM0VWczFmS0c2WVYrTDN1?=
 =?utf-8?B?S1RzYWdaQ3JjaFZ4S3h6QTVtTmNST2NGRFBpbGp3TTQ5TEFCWkZKVm1waXBB?=
 =?utf-8?B?RUgzckh5RU55eUxMLzZPNVpqZVArb3U3LzUwd1kycFhUOTF0M015T3poQVNQ?=
 =?utf-8?B?cTBpb3JPSmd6eHY4aFh1WVl0c1JiVFNPejBuclpNMXM2QWtEZ01tTndlc0pG?=
 =?utf-8?B?RTdsbFNhMS9pQTUyaFd0TmVMbGJkbkQ1a3RUdVFxZkl0d3Y5dVJqanVSMit5?=
 =?utf-8?B?S0Y4UVJPYzBwSDdSQ2xBb2Uvbjg2bEhjRS8xUU1NanVIVXdyZlNMazBIUnZP?=
 =?utf-8?B?T1ZPZ1FnandFYi90RkorN1dvdWtlbVVrUXZhTW9odlpTRkxUNHRHYnJRTWpO?=
 =?utf-8?B?MnBDS2sydVV5cmlZNy9kQnJnbEtLWGk0NlpXaTNHMWE5Z05FbDZmNllhcmdp?=
 =?utf-8?B?TUhyM09kclZTWCtlUitTZFEwRnV3NGtGdDUxQ1RnQ2VTb2JlbENOM3FLbkZJ?=
 =?utf-8?B?bjNYUHl3amdFVE9mYStkU2hzTDBlajEvU2lSaHlla2dPRm1ZbjR4RElySkpj?=
 =?utf-8?B?YzBid1N6cnZsY0d4SDBvMTY2UmJtUlVUbGJYZmR3c0c5Wk1DRXpwSk1OdmE4?=
 =?utf-8?B?Rk1zcDA1Y3QxbTBkdmhjU2U2eHpreForeFByS2pENWtINGtCckRXRzR5TDhp?=
 =?utf-8?B?a3gxRUlEVHFmWStkbGZlNi9qNVEraS9nUGE3RGxPWEV4THQwSXdOV0h5UUc1?=
 =?utf-8?B?TEFySFVBcTVNdlR0M2habGorQi9SUlgzYmc0M3ZpQUlZdTI5MFl4dzkxekw1?=
 =?utf-8?B?RWJhMVNycStQSXZIL1BwQ2dNU2VLRjAvSTBHc3ZJSDJEdFlCL1prRFhBK1J6?=
 =?utf-8?B?RWhzeDA3RytPdGhqVVJaeHY5WS8xRW9YdHVEQ3hjNTFZekpXeFNMdXhRMWhC?=
 =?utf-8?B?cGJyenFQak1ZMEdkek9BZ1ZNTVVsU0tIVWpKeXpHbHRFQjNjeG9OR1FsVW84?=
 =?utf-8?B?K2xXMjgvNjlMNWk1V09LRlFSNWY2Z1BPODJQOStDNkpKbitiZkhKTGtlVWsy?=
 =?utf-8?B?c0NRaldVMk9jRVU0K3pTa0R3Z3dFWUJVaTBYaTlkWmYwSHRlc3hwWHE3ajJt?=
 =?utf-8?B?SEJmQnBpVzBoY2xVRzZtZytqdWxKZmdNMDNEZDhvS2RuclJJbHhQeUZsTkJj?=
 =?utf-8?B?d3d0dHlrM0o3VXVTUnhYN2xCU1JuYUZPc0N1M0FSaGZiSHpuT0pvWTZkN01M?=
 =?utf-8?B?L2E3L0dtYlFIWHViazdmcEJZM0YrRUVzaEU0U0xoVWN3WTRYc0hKSWV5MUtG?=
 =?utf-8?B?eGNrUXZocGducTRWV0Q5NCtPZDhReE8rS29HdDViWWdjNU9YOEtOZmFVcTNW?=
 =?utf-8?B?MEU3OTlTc2NPVTZVd0xINUZ2RUlzd1BFRFM2bFVvVlVkcjA4NXByWWVmZWhr?=
 =?utf-8?B?S0w5VmpTZU1GMW5hK0gzamd4N1l6ZlhjcjdXRnUzby9BQ3A3c05IUkFvT1di?=
 =?utf-8?B?b0wyc3dLU05hcDljQXpTWUw1LzRNVjFOSVBwMzdCQWZEa1FzSmE5MnBFYk1Q?=
 =?utf-8?B?WWVpM0dySTNvWXlKRTE3YzE1Z3pObDkzOG1nckpMbWN2QVJOWDRKTnAvNWV0?=
 =?utf-8?B?Z3VlMEN4QlRJaHdvNVRLSlZpdk5Sd21DeUJaYnNLRGpmNWo0N0szTUZ0aEpK?=
 =?utf-8?B?OUlFT2dGZWJWaVZGQlRFZ2p5RmhmS3RlNmZDMTFxK3JlVnovdXRxSXpFMFE0?=
 =?utf-8?B?RHRJSndoQkJVWXVtd2F3WndXKzd6L2ltbVZwcUx0OU1tTURGZTVtY2d6WkdH?=
 =?utf-8?B?S0JaYmR1SWxBc0ttbmNpU2t0cmpWemdvclRTNGU0SEcySXBsdGt4c0xDZXJS?=
 =?utf-8?B?RjF0S2FLNmRaQVlKUnc1bC9od0Q2ckZoc3JmZlhJMlZvNzNEaFRpN0V3b3BR?=
 =?utf-8?B?clJZd3lYL1M0N0VqeVhTd1JlN2Jja29wNzYreXU2aUtGcU04RHM2SWN0RE16?=
 =?utf-8?B?SFBUeWVqcCt5RkZQRnNMbjFIdG40YVBFYVZkNjJSeTF5NHFpL29oWm1iMzdm?=
 =?utf-8?B?ZmFCRXpPNmI4UkF2cmJ5WkdFYWFzTFZQcTVNcGYvNXl4ZUw0ckJBeG5TaDVu?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4lJuz1/A7PyrqMrbbrhYS2y1H6AQUopi9S/MG3EcrOB41jExnKV2SjuRVjQv2FoOJx1xvAMJlQgFPXz/QTX5f6d6/23HN8MnA7VjEct2xVOs7mIETyElo7h9jSCRwOqoPlYVIXIwsgKtKjn1unaLv6hLyuF6DEqMKHQhjKS/a3z7mF3LjpUGwDg+olGFBmkoE7Hcn/FuGeRCNPxXIWThQec9ese0RWGjB0+SaTYkHAhTzChnkbC+5I7CglzQOwHg1z/Wi2fFbg0f38bzzBDW1gzsmL0JQDtUorArzZHHwn7wYatUt0uARxt41xu8N66qUyO1svej/7nEjhyxpm4V0rf1cTF9AefytQD3bRgjsGaJsU5UFV0TtDYZWFoiMMYP+LfwqFfcov2XI7eSjJlJfG1XWlVhOYRRvvXFWoyf59Fn6XOzw7/zqQVMJ+v8dF0HCqoHAbZOfKb5k2MuMwhH5uQ7163+ymPs0mOZyGcRpIScmJvD1idhG0qmn648j5rq4yOXPqA7uIKHFxYytF/jCrfykoIKk19M39onQLdxJarpFMvRCBJ5VDn9W+eCZT/JU7byaR9cewFHviD68Re2EAz7t9nEHFbPtuHPruNkx4g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4226aeb6-efdc-499d-bfe3-08ddea6802be
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 21:31:00.1871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aV2DKuZPR0L/GBdsgrMewei76JWYj0NDGl4s9X+7y/3a7AVjT48851ww0oRrWb5W2eGSOZPzAbmN4E3d8OTEGwBzv+4llKKcFv442jdQBE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020213
X-Proofpoint-GUID: TNGyFZdxBHz5M04Ey6iEc2vspD4PBIOH
X-Authority-Analysis: v=2.4 cv=I7xlRMgg c=1 sm=1 tr=0 ts=68b76218 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=7CQSdrXTAAAA:8
 a=DLYMtL6nnpTSNLbWkJwA:9 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX4uupuX1Is4xL
 XlJ+bcSoJX0DscwN3tu9+x0eWyq1Vp0BCLDuwv7NtDNfUIgee4h4O10OWyenXXIUJPcjJpPX1A5
 ulQNaPYRXRt0yihrHADw6+R46s+zNqZIJmI+0uVDdl2j4cP1JCPd3BeUX1jSJixyPBa5QhA73Kj
 WrjTxeXW/B2q8bh049aY3/JEkzblRuBf0yFlVERrX/wBab+Jp7WhwkP+vGkY4J9yDM+MhruyLW5
 b/epCVIc8hsBZRHrAtiT0OkwYKSkIzWWcb+orkr1ndlCU0Gtl2QDuR9gMd01BGbISLAdmnFdboO
 IlZkNK+cXF8IS4Hwjne1uzom5JUpPc5uM25gYg1o1blum3DpbGpZRITGPlO8FGQX30p5XmN+GWs
 GHBzjoIg
X-Proofpoint-ORIG-GUID: TNGyFZdxBHz5M04Ey6iEc2vspD4PBIOH


Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Sep 1, 2025 at 4:28=E2=80=AFAM Catalin Marinas <catalin.marinas@a=
rm.com> wrote:
>>
>> On Fri, Aug 29, 2025 at 01:07:35AM -0700, Ankur Arora wrote:
>> > diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/=
asm/rqspinlock.h
>> > index a385603436e9..ce8feadeb9a9 100644
>> > --- a/arch/arm64/include/asm/rqspinlock.h
>> > +++ b/arch/arm64/include/asm/rqspinlock.h
>> > @@ -3,6 +3,9 @@
>> >  #define _ASM_RQSPINLOCK_H
>> >
>> >  #include <asm/barrier.h>
>> > +
>> > +#define res_smp_cond_load_acquire_waiting() arch_timer_evtstrm_availa=
ble()
>>
>> More on this below, I don't think we should define it.
>>
>> > diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
>> > index 5ab354d55d82..8de1395422e8 100644
>> > --- a/kernel/bpf/rqspinlock.c
>> > +++ b/kernel/bpf/rqspinlock.c
>> > @@ -82,6 +82,7 @@ struct rqspinlock_timeout {
>> >       u64 duration;
>> >       u64 cur;
>> >       u16 spin;
>> > +     u8  wait;
>> >  };
>> >
>> >  #define RES_TIMEOUT_VAL      2
>> > @@ -241,26 +242,20 @@ static noinline int check_timeout(rqspinlock_t *=
lock, u32 mask,
>> >  }
>> >
>> >  /*
>> > - * Do not amortize with spins when res_smp_cond_load_acquire is defin=
ed,
>> > - * as the macro does internal amortization for us.
>> > + * Only amortize with spins when we don't have a waiting implementati=
on.
>> >   */
>> > -#ifndef res_smp_cond_load_acquire
>> >  #define RES_CHECK_TIMEOUT(ts, ret, mask)                             =
 \
>> >       ({                                                            \
>> > -             if (!(ts).spin++)                                     \
>> > +             if ((ts).wait || !(ts).spin++)                \
>> >                       (ret) =3D check_timeout((lock), (mask), &(ts)); =
\
>> >               (ret);                                                \
>> >       })
>> > -#else
>> > -#define RES_CHECK_TIMEOUT(ts, ret, mask)                           \
>> > -     ({ (ret) =3D check_timeout((lock), (mask), &(ts)); })
>> > -#endif
>>
>> IIUC, RES_CHECK_TIMEOUT in the current res_smp_cond_load_acquire() usage
>> doesn't amortise the spins, as the comment suggests, but rather the
>> calls to check_timeout(). This is fine, it matches the behaviour of
>> smp_cond_load_relaxed_timewait() you introduced in the first patch. The
>> only difference is the number of spins - 200 (matching poll_idle) vs 64K
>> above. Does 200 work for the above?
>>
>> >  /*
>> >   * Initialize the 'spin' member.
>> >   * Set spin member to 0 to trigger AA/ABBA checks immediately.
>> >   */
>> > -#define RES_INIT_TIMEOUT(ts) ({ (ts).spin =3D 0; })
>> > +#define RES_INIT_TIMEOUT(ts) ({ (ts).spin =3D 0; (ts).wait =3D res_sm=
p_cond_load_acquire_waiting(); })
>>
>> First of all, I don't really like the smp_cond_load_acquire_waiting(),
>> that's an implementation detail of smp_cond_load_*_timewait() that
>> shouldn't leak outside. But more importantly, RES_CHECK_TIMEOUT() is
>> also used outside the smp_cond_load_acquire_timewait() condition. The
>> (ts).wait check only makes sense when used together with the WFE
>> waiting.
>
> +1 to the above.

Ack.

> Penalizing all other architectures with pointless runtime check:
>
>> -             if (!(ts).spin++)                                     \
>> +             if ((ts).wait || !(ts).spin++)                \
>
> is not acceptable.

Is it still a penalty if the context is a busy wait loop.

Oddly enough the compiler does not eliminate this check on x86 (given
that it is statically defined to be 0 and ts does not escape the
function.)

--
ankur

