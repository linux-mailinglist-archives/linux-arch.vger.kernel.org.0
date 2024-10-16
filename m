Return-Path: <linux-arch+bounces-8211-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A56399FDAA
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 03:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584FC286D98
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 01:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4385817C98C;
	Wed, 16 Oct 2024 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P37PxnJF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Oxc69X0M"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7822016EB55;
	Wed, 16 Oct 2024 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040426; cv=fail; b=ID8peHnXMTBAl7TETh0jLBZtsKOxAzcgSDlmoLtL9r83Qr+GaUs+sHmVJ9k7qQ2BQmyJ+SnbW/jyTmfJSiZvAgoTgJf1pS5f4maIlSfIMY8lFIuhWaEBJyKQvTR+/vo0PkIRsphWSDyN4ot5IrJTIw9dmp37swSVWSOCp5lcsF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040426; c=relaxed/simple;
	bh=aBkry9026JAsl73Pr1vxWPtzQ5P6IKxioRIZiXFTRu8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BTX80a7WSyaapIukFHYF7gxehgi7wYQzoyvc1M77I7vQuMzW9pnPmbdCxieEKLSvQnxMFoCa9HsTC4O2bElpcw1+yru+v4/mXn2OqYBAQ/SVDW1ae4aNJA7ubQ+KgVY8q6iuEFn6Zl976f1s3uuKxzPFMcuCRshXaMK+u+nlQHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P37PxnJF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Oxc69X0M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHthxI001619;
	Wed, 16 Oct 2024 00:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QcF3yaHZfVR6ITZn3h8Bnp1hluYhduYNK1NshevMBtM=; b=
	P37PxnJFviDFcXeWVZt7dxhe0+gSV4H0pHHuD31dNDe4anS0ysHE1YHBAUKi6TdF
	DfufJSlM0PASurLk1l4BV5uUfJPjQBGK3Mh8bELoC1+0N9oihWPREryiG+wDJdMn
	ND77LSbFURFNlAn4oVuUQe7AEUW2+s8TBLmIJMrVzx8Xeq9JzYEA1NlQROO4QJE3
	Uq9vYiD5jO75HmQSo6nOh93uMKNsBlY3fiN5Tq/mSGnJU8o05jGZWVT0Tkj016ZR
	STRTAXxRFLZYe1wK2O+pYMc7u8Jq32qF6ps4js30Ou1fMoXzXH0/iUTkicElXC8y
	MBiNsbUkeHVizeJjZEkpJw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1ajcww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 00:59:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FNM4MW026272;
	Wed, 16 Oct 2024 00:59:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj866yw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 00:59:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luw9vu07F2tFgrT9NDcT3C9fvwQwc9MCC+teIX/gX2vevJ1tJg6E4j31fad8CVIBDpjk6uSMrFKqhl1r5M+h/+UKofPWJ8UdkqKrhjQHjLRlpxg19LZsZUfLly00TStr+JXmvBUEfE7MllWTHtLHSNi06YBDuRTxSzt3IVz73eNtV+HowoVKi3MWKxuDDhZz6xvo27/DSevt00pC6odAusT1GGozuNP+jP5sRiX6csQPgoks3Vb5NzP5EMALTo3BTG6/luNFZd9QWdGunS4LHt6srDlZD3CCs+2UXcca+tZ9le5qVPzHRod/Ep2te5J19Mb86UpbdMlu59oXDz061g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcF3yaHZfVR6ITZn3h8Bnp1hluYhduYNK1NshevMBtM=;
 b=sXAVmZ/3KmDjkG9Ww2BXXgMclvaTMjA63VNY9Z0LRzLLmSmGgafZtVE/RxWirFQZ7VG9kjeRYiTv7ccoKTzv01d1G6kXkkL//rzyfkzcKfPWNMsL7a6YadqWcpNUZo4re5iCwt6lgqJv2xKTn3h9tboSUr9xjhkTLHc3o+RSpJxpnhtD2QKUwMq7vdEvOvYnVRxHW418BQGwQ/BIlA4TVdO/SOd4LTtpMzfVnnNQX3gb8dGa3k2jHEajl1/9yg25+mQkm80HwmOqhZs+uPRrAptxLQrHrNB8XatqZu3Stq+mhXuKHqmdnOUjGOGZ5hxZqG/1fmxI1Jq3YO1npq7UZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcF3yaHZfVR6ITZn3h8Bnp1hluYhduYNK1NshevMBtM=;
 b=Oxc69X0MvIf2s41Lxw+UiAVoaWTwLIK3dd+xMZP7mKfYJDgZcELntnXZUJQ0xRSzaDEem/AtVh4/I9s9twtewF3zeXvvJr0bavqlkqNV4BeyFt731iV3jYBkWtqvXp1NFe1nGmdEjCuH5MJp2tx1VTl8qkOYSXz9VpMRHd96lXE=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by DM6PR10MB4185.namprd10.prod.outlook.com (2603:10b6:5:217::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 00:59:45 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 00:59:45 +0000
Message-ID: <a185df19-c8a5-4b2f-8bed-19770744a944@oracle.com>
Date: Tue, 15 Oct 2024 17:59:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/10] Add support for shared PTEs across processes
To: Jann Horn <jannh@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com,
        viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org,
        andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org,
        brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
        rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
        pcc@google.com, neilb@suse.de, maz@kernel.org
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
 <CAG48ez0=9O-V0V6v_LUgRcF46BooJdk3eqb6xgDpKpNZuW1L2A@mail.gmail.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <CAG48ez0=9O-V0V6v_LUgRcF46BooJdk3eqb6xgDpKpNZuW1L2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::35) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|DM6PR10MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: a061e894-fdaa-4cc4-9b6d-08dced7dd38f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enFrUU4xMXF3N2d6dUNIa01ieTdqUUo3NkhrRmVtdVVtRmRVNVhVelRlVEpk?=
 =?utf-8?B?a2xxY2NiczlBQXFJbmlLR0owaE1wdXFGcUg1anNIcXhRbE1GZ29lOWIwc1U3?=
 =?utf-8?B?WndIQlhRTHQxYURqR2ZrSmdFSVYySVVZUGVsRGNRSjFuN3hoY25KY1VqMWJn?=
 =?utf-8?B?dzN2Tm1zY3Y1dzlqS3FYQjBMSkloU3ZURHhHd01qMVBFLzRpNzJ5WVp0NVpm?=
 =?utf-8?B?am1Pd3ZiMmF4WHFZcHcrWFZueG9KR3BlaFQyVEdEWDZ3cCthcCttbnpYN3NV?=
 =?utf-8?B?ZGRTeTVRUXB2T0tPcldWL1BZZGRCaWpIZGhNaURwUnF5RTZzUkdLMWMvWGVL?=
 =?utf-8?B?a1FnZ29qVzBSemdXZkZ3WDN2b0tWSGtlVDliOVoxS0FvaXFWUU1FWFZpRnFK?=
 =?utf-8?B?Qk1OV0VLbHNtVUp4Ui9vVXd5Y3BtU3pUUXVWM2JBcVpMd2J0b1ZjRXlpaCtZ?=
 =?utf-8?B?ZlBkaU1nb0I0czRaWkJzWjhIbmE3SFlld0dPZU0xQW5vWTd0UEVvbUhuaGY1?=
 =?utf-8?B?Q0R6THRTbmYwaktpN3FUNjkrRjJnemc0NkZEVEw5OHg0ZVlDUUdzWmRrN1VL?=
 =?utf-8?B?aitaTTFwSFlrNVJ5L3R6TDhBWjR0dFZKSFFKYjQzYzl4bU53Wk1XUUNUM0NL?=
 =?utf-8?B?L1MrckdmZXZWdlJ6dXJtT3VhWi9Ec2NYd25vODhmbnNyU2REZk55YmcyOXRx?=
 =?utf-8?B?RE93a0F5V1hycDRmMGpGRDFrWjBBeE56ajAyNW9FbFh5OUdtQjVtMmlqNEZK?=
 =?utf-8?B?VzIzbFRyV2RESmc5aUpSWGJPUXVGU1o2dTZvSHFDV2pzZHhzbDNJYm1hSXh3?=
 =?utf-8?B?SGlZS2NEb2l4UndDNHF1WkU1Y1RGcmJnVlRsN3RUNkU2Q01GaUdXbzVBcFh1?=
 =?utf-8?B?Q1FueHVEUFJ3Z2JVNlY3NWQxQ2hwekErZmVtSmg5NVY1RFpSUEFFYmx2L09J?=
 =?utf-8?B?eFZqT20xbjRnNVlkbFdleGZJTW50NTlzNHFvMzdnM1NtZ2tpNmJXc3dBT29Q?=
 =?utf-8?B?NlhMaEc5amtQVklIemhKMUNWTjNQZW81bmJzQytVMHlkUHlyRXFRaG43eVlK?=
 =?utf-8?B?U3h1TWlqMHh6SVRCbTZMZUtFOUFlSGF0Q0Zvc2RxMForZStrWVdYMXhwbGtV?=
 =?utf-8?B?VkxaVHN6NWUyVUthZ3RvdGpnRzVsTEordFlaMmJ4d0loSk5OWFBqekpSMk1T?=
 =?utf-8?B?ekR3SWxBT3V0UmlaNHZXTjhRTFhmZEJwSVFyUU5EbnlDR1BWaWQwOHNVWktK?=
 =?utf-8?B?QndkbXY5RXlWVlZ2blp2Q2d6OXpHRzZxYXBLMUZyMS8wbVJVdUJUY1JRY3NX?=
 =?utf-8?B?ZVlSNExvNlRFUk45V1YrTHRsdVZHRmFQS0FxclNZY3Y5RGVUTzNlYUN4bFlN?=
 =?utf-8?B?ekVZb0t1ZnAyUFk4dGM4Z0doaFRCcmEzeWVwUlVYRk5GY09aaTdacWlsRlJh?=
 =?utf-8?B?RWZ0YXFjQ2kvQ2lCTHFIM2hSV2dzTEpPblhMeFAyT1pmRmtDSlNvZU5oOVdw?=
 =?utf-8?B?Wnk2OUd2andrajJRSEwrYzBlSittblZ5cmxlRDZpNWM1OXFBQ1owYW1LZS9Z?=
 =?utf-8?B?RW1ucmRkOFM1UWtITFVrcURNRncvaTdwK1VGVDY5d1N5VHA0TXN6bVNaL1c3?=
 =?utf-8?B?cWx4ZFA1SS9nb3dsT3RvNy9GcDNMS0UwL0NyRU1RYkRFT1BtWW1Rb0lrNlhC?=
 =?utf-8?B?VDVWTzFsYUt4VWJpcnFQbC9TZkdCUzVLbWhuY1NMbUVadnR3czY5ZEtRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3BZLzJVdzdyNEVoakFaWnZSR2hNeTBlVS9TOVRtb2hvdEc1QS9JYTRoVnZE?=
 =?utf-8?B?bGxiRWdNNS8xNHE1VW1kNmE2eGFNc3l0L054aEVyQlNiVFFqaDViTlozRStx?=
 =?utf-8?B?T256UmtObnNKRTlQUHV0VFQwL1hxanNTMzBWZTQ3ZWdOTEJpYUg5WkhwRlhB?=
 =?utf-8?B?Tk9Rb29OTXNpTWJCVk81ZWtZQlc2ZS8xdEVrY2FidU5hdmQ4U3NNZWhQRjda?=
 =?utf-8?B?ekFCZDFqVURpQlg3RFF0QitnRjlmZi9MbHRlaGpUNEQ4SG1tZVhNbWVqeEYy?=
 =?utf-8?B?YVkvSm5CaWNBd1RTUFRTUzkzcit5SlFZNlE1NFZHOVNOdHJMZjQrSVhQTjVL?=
 =?utf-8?B?TUVEcitobGxPaDJocjVuMlZCdm1ESS9DQnFqazZlVDNvaFl3M2ZUZHJLT2ZJ?=
 =?utf-8?B?S2xYVG9jdkd2R3JwcUFkM1RQUTlscytQU20wMXdESWI3VlZLbW5rSk1rRVFs?=
 =?utf-8?B?MWRHZ0sycW8xcEpGQXhWOUxiaHF6UkpBS2dVYWhCZm81cis5cEVRMmZ2bGN2?=
 =?utf-8?B?MDRFNGZJK1ZOUkxRNENEN0I3bFVjb3dCYmhnemN2c0d4aUNaTFVLakY3SUNO?=
 =?utf-8?B?dlFHbkNHc1E2UHlXQU1KeVA4MU9jMGJPTmQvVHZ5bnhaeDNFMXlvcHNPcjhx?=
 =?utf-8?B?Rm9zaGlPdVZ5WFc3MGN4ck1pVXJOd0F6NVNvOTNVUkVYWWR2cG4wUWUzcTRl?=
 =?utf-8?B?R2pnS0RUZTF6OG01a3pZNXQzc0I4bEVsK05CUEFhQWZGS0Rqdkowek5nWG1I?=
 =?utf-8?B?TDh1Uis2TGtBMml3cjhoM0s0KzEyMGFYRkRUZUR3U3VEWjBRVHNTZTVEUHlM?=
 =?utf-8?B?bnI2bnY2ejdpOWFoc0syZU5FZHJ4TFc2TXVJOFFZbTd4WHo0RHoyMmcvb0Jj?=
 =?utf-8?B?cE8yM0VTSWNIbGlrWDhLbkd0dzY5LytJUGhOc1Y4TUljMlFCMERlZkFNYUVz?=
 =?utf-8?B?Rk44WWpCc09adXZ0dUo0Y3ZjUFlSNmovdlY2U0Z1d1UzYlBFdzRnaVp0NnZo?=
 =?utf-8?B?eHhEU3F0cUYxeWFLZW1PaXJrbGhodDgvSWVmeFJuUUFiMmJSc293cVFiQTMv?=
 =?utf-8?B?K2JrbU8yTXlRd2F1dTF0K0ovYVpWa0J0SG5VRHZGTjZaUnVuUmVQWXhJVjIr?=
 =?utf-8?B?RFJsOGQzT1dhVmluWHpGa1RoUjRXMnFra3M2N0VuSGtjbXBGNzBvNTEyTHFI?=
 =?utf-8?B?VnlVRkpMcS9FVW9JM2V5aFBHemN0L1Rrck1DNDRHWW5TRlVsL0p3bWpNMnRD?=
 =?utf-8?B?Vm5nSUJxcmVBOW9RQW41b2Z4T0ZpQ3EyWkhXZTFFQUZjMWNwdUR5RnJKckh3?=
 =?utf-8?B?VGlKeVZnblgxZHg3Y3phNGtwaERpSFRyQ3dWZVhyUUVJQy9SN1grUGE3UFNM?=
 =?utf-8?B?RTFGVE5qeVExeE9BN1RPY25jNlJsbENoNVlOakNJY1NyOWZUV24vTC9OVjEz?=
 =?utf-8?B?NGZTcjVMRTd5cXVlSHBad3FXTGhPYlJMd2k0cDZFNkdudEtBd1NLbWhUcXJY?=
 =?utf-8?B?TnJYTTFHanVtSE5GUGRHM3IzQ2xYdE9xZW5IWEloeDU2SDRlRGl6WHVjOW1j?=
 =?utf-8?B?WmFsRmFUYVlyU0szUUhpRm5KOXNkSmdDUGtqRWJOekZnR3lCZEdvUHhVa3d1?=
 =?utf-8?B?aHVzbVd6dkxra2kzYUdjK01DYUlQMXBVYnJjMkdhQUJ2Q2tpTFU1ckt0enN1?=
 =?utf-8?B?bGZ6VlRXTTltRzdicUJBQ2hBTmhzMHBJZUdJUitWaHhFT3RzSW1iZ3NJa0pa?=
 =?utf-8?B?ekt5M0NqMDVTQS9GZFZKb2dYaUlFMWEySlpQeC9iRmIra0o5MFdnb1d1RFdE?=
 =?utf-8?B?V2NrK0I1c1RzSFBkZ0JFYjY0OUdISVVJSUF4Q1FtTm83TENaeVJvNGpBWEp0?=
 =?utf-8?B?UitHMjRnUjV5T05LWkxwYThDNHlrN0k5UnBmU0xjYll0dlVaWjIwb3pRcTBV?=
 =?utf-8?B?MGhRUmszc1pQNDZlT1ZMSmUrZUprcWxMeVlwR0R1S3h0MDZWN2d0eU9RUXB1?=
 =?utf-8?B?K29MUUs0L3YwdTFxaEoxcWZHTTVueHdIVFBLRkVMWUFWMTRNMHNWakFuTE9y?=
 =?utf-8?B?djI5SXFNQ3NHVTRtZlZiK3FiU1FMSE9BQmdXeWpYVkk4NUg0aDRpTkJrQnJw?=
 =?utf-8?B?SGRIbGUxR2xRRm9yWENZY3o1Ri8wM3ZOY1dMMTVhVlR0aHkrN0s0RWZ1ZWZ4?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sCmqiCXnDeK7HSQdnBlgr+vQY2YED0PzQfEcqX+hrH7rRbD7adDyfpzXwY6kSN/fqWq/aT5WbVjYr5mTcgmETrTUvAAggreN7fe16HK3Bxu8HcCGPmM7VAz2s8LOlpdZoDuFo1KduNNAnolId1Lm2hVWz/YNOnC8LcVoWedlT/TemYuGpc+kg792f4wG2Zdm1pJte5MFvJC7QiWuQfPIHIAZMT/W9DvOwUSCLOvNKbkNnN0h7QeP2s14WeXdmpBqr3G/8RS2g6G3gwwlqxi1HdywabcC0btTjGFSh/XovHR380sHe+c/AAMX35hrdYUz+qXcg1tioTH54uzRB0NMcIwqhebRhuumePKkUMdDTZ/tI3jsKelhymOCmfxHgpc2pQVG1krOh1zuygg5IQM1NaRaQeJajZbrQl6Nat22bYeL8ZptbpKlu5ScYVaNRlkR640nIdl+hVBU8VMHfp+3JLCg4Ca87WSwtWIasRxSXFBO64FqMEzVAxNCEKLEfnvPFtVv3HlJMqENGEDqGMHMJ+/rc7BYKyzilgHA0hX9dpbxQHRpA/k2NdVOz2mgQTqL2SSki70GwNJnJRBf03aKIqdN0J/tNdUrJTHaFFdNz9k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a061e894-fdaa-4cc4-9b6d-08dced7dd38f
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 00:59:45.6974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3WyteuXB6Snk44CfeKpbFSeVKNo1ZEZw+Pu4WreNX/dFg/vMWYvUUPmacDmQNX6n6XLAyKtIqAT8BXitYmDmOJFvY2JdNRaAwuPOkadxA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_20,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160005
X-Proofpoint-GUID: pSWLBENMeI-h4rqFWbesLE2SBkJI4Om0
X-Proofpoint-ORIG-GUID: pSWLBENMeI-h4rqFWbesLE2SBkJI4Om0


On 10/14/24 1:07 PM, Jann Horn wrote:
> On Wed, Sep 4, 2024 at 1:22 AM Anthony Yznaga <anthony.yznaga@oracle.com> wrote:
>> One major issue to address for this series to function correctly
>> is how to ensure proper TLB flushing when a page in a shared
>> region is unmapped. For example, since the rmaps for pages in a
>> shared region map back to host vmas which point to a host mm, TLB
>> flushes won't be directed to the CPUs the sharing processes have
>> run on. I am by no means an expert in this area. One idea is to
>> install a mmu_notifier on the host mm that can gather the necessary
>> data and do flushes similar to the batch flushing.
> The mmu_notifier API has two ways you can use it:
>
> First, there is the classic mode, where before you start modifying
> PTEs in some range, you remove mirrored PTEs from some other context,
> and until you're done with your PTE modification, you don't allow
> creation of new mirrored PTEs. This is intended for cases where
> individual PTE entries are copied over to some other context (such as
> EPT tables for virtualization). When I last looked at that code, it
> looked fine, and this is what KVM uses. But it probably doesn't match
> your usecase, since you wouldn't want removal of a single page to
> cause the entire page table containing it to be temporarily unmapped
> from the processes that use it?

No, definitely don't want to do that. :-)


>
> Second, there is a newer mode for IOMMUv2 stuff (using the
> mmu_notifier_ops::invalidate_range callback), where the idea is that
> you have secondary MMUs that share the normal page tables, and so you
> basically send them invalidations at the same time you invalidate the
> primary MMU for the process. I think that's the right fit for this
> usecase; however, last I looked, this code was extremely broken (see
> https://lore.kernel.org/lkml/CAG48ez2NQKVbv=yG_fq_jtZjf8Q=+Wy54FxcFrK_OujFg5BwSQ@mail.gmail.com/
> for context). Unless that's changed in the meantime, I think someone
> would have to fix that code before it can be relied on for new
> usecases.

Thank you for this background! Looks like there have since been some 
changes to the mmu notifiers, and the invalidate_range callback became 
arch_invalidate_secondary_tlbs. I'm currently looking into using it to 
flush all TLBs.


Anthony


