Return-Path: <linux-arch+bounces-11890-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC5AAB2EFD
	for <lists+linux-arch@lfdr.de>; Mon, 12 May 2025 07:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49051789FA
	for <lists+linux-arch@lfdr.de>; Mon, 12 May 2025 05:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4534C254B1B;
	Mon, 12 May 2025 05:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NiRjOJN2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SJomADX1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ACF25485B;
	Mon, 12 May 2025 05:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747027430; cv=fail; b=lv0mB7c/CK8YPsnz4mcv+stJU5KBIXnZf29n5piGuIALToEF7AC1hcvmc9TYY0tbk6tTuVNC3bKZkeEXjKCS0E0+Zuhc2CX4lydGj39lqpOTvpwIpf0/JvEr0JaRKZjAa9OWGA9c/4NaFYOv5uqih5SJ8AJXlwo7WZfxa5tMw3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747027430; c=relaxed/simple;
	bh=pz6ruolDNqZR153MUk4uC10o4/DGz5HHQDX8TglSEAY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fjF4BGQ9wqC/vw+XKNl41Ymslzj2n8o85W+11IYY1kngQsGrLGWccBPkRfpnmU8DCwodp2hCwungfa+8FG9KJ2Jsbokbqfz4U/UtV8dnZ10BndcwSgsYe/POt13Shmgye5v1gNX05wfO4reeqcChHSHv8Rl1tIYPnv4b5TO7dns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NiRjOJN2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SJomADX1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BJwO2Q019270;
	Mon, 12 May 2025 05:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xeW9YEf/1NWlIfHMiXXDhTogJy1hHME4DVJ+sL8XAgw=; b=
	NiRjOJN2OVYKQMFzjcYbOFqOGDTU62up72wtKWQ1Sl0Tab70KFYliUY2Vskpb132
	UgvSdJmVZ4ykxTn1bFglvslD9G6JCx5HcoHUymsB47TerPPeFsOD3qzyI0YCo+Pv
	BKIGaI6DIiAAMN8pU/ReM9dMf61OAf0KjGDZnP5mdMeZmp34mzsO6WLmNWyCYH8r
	Ndol5UwHTajt5jhqhkz+JGpmAeiI1i2o46+FsTUAm1Go0MkREHT61xl69DGNz/EG
	DAc52JB24sDJLI7yQD3blX2jvBIaTVic6Jm8y6LWCknjORoPDTUSbYuxTy9UQV8P
	kdE8+JSqc5353d8Y3gjALg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1661s1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 05:22:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54C4o7ko015449;
	Mon, 12 May 2025 05:22:53 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012038.outbound.protection.outlook.com [40.93.1.38])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw86y48a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 05:22:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G553Xxfi9P5ce+FrMjN0M2M1lTznGiJxLCnoK6GZDJAQMfRXpXWs6XCBoQMsQyK4CAxSo0dlqm9e3HZRffti4tNS3ckuAPHdiyS3y3RVrZg+sQ6uQ5IQJzqRYuhZFCUH0YOz2JrNt7riEMC+D41nE07H0be8Wr+jgBlxYUq+GFVQkiv79SkQPqU/yirdHwpWv4z+VwUne0V1meRvLYIP8hIsDB/mb2zTqCThsXydrG/liTffjO+OQU1mZW3vauJNI29Eds59XwGcslgOX7+1vWGiwauJw25GwpUDE84ugHFHS42F8A5UEWBCm6W+KerVMTO5bRF4NT7nP6AHIiYa/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeW9YEf/1NWlIfHMiXXDhTogJy1hHME4DVJ+sL8XAgw=;
 b=rxS1rZD9sQCZqGVcA9OA3ImuVz2y64+UtbC1IpbNyQU6ojv6ZBH4ANZlJcYsINRn2NWzH+Gxu2FvhGl901RhKBLorSZopls1yvwdbWH8C/QbcwE1C9+cps/5neGtAzZ4fQzaxHBO/OhEfC+2q8L2HeL+ZDdkYuu1XzXD7AA5M46SkaHMO0vAtA5neoZs90416gfNMsyjtDzOE7e7px+S6l5/Bg9Ozmz4pL1oYQnpp0SneGKAHlOLF7w4ACXazbUbYNP+jdgu+75G7q6Bt88ss8UlVhB1Q02TWkRMVXIgk8KZv5eeCKAkLIxoeXyrs2TCAwJboj1q6GL8jrdIBuIhTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeW9YEf/1NWlIfHMiXXDhTogJy1hHME4DVJ+sL8XAgw=;
 b=SJomADX1azTw8+iiMnpATNbD7ThUnjr+IH8EBmBKgA8uMpaLxjCawqriG3Kds+hgYmWY+0sWr+FBCrVrxAT7rgUFTP8XYWL7hyf+LVU+DBWcdhrCEy6+9MEsFZRH2idlyrH39h2+EcHfZ7YDKNSorh/D8raXXq+i3/phu4MbXjg=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by MW4PR10MB5882.namprd10.prod.outlook.com (2603:10b6:303:18f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 12 May
 2025 05:22:51 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Mon, 12 May 2025
 05:22:51 +0000
Message-ID: <5d21de5c-2da2-4a33-8d30-0475bc0edf4b@oracle.com>
Date: Mon, 12 May 2025 10:52:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v2 1/4] Documentation: hyperv: Confidential
 VMBus
To: Roman Kisel <romank@linux.microsoft.com>, arnd@arndb.de, bp@alien8.de,
        catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com,
        decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
        kys@microsoft.com, mingo@redhat.com, tglx@linutronix.de,
        wei.liu@kernel.org, will@kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
        sunilmut@microsoft.com
References: <20250511230758.160674-1-romank@linux.microsoft.com>
 <20250511230758.160674-2-romank@linux.microsoft.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250511230758.160674-2-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a03:505::9) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|MW4PR10MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 1141b3f2-9b89-4dd4-e8c7-08dd9115071f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enRtZ1BpRVlUeWRtcEg0WmlLQ2ZDakd1aTFZQW1Ed3lpem5RL0M5WFJTZUdM?=
 =?utf-8?B?bmtJTHFOV3M0ZjFHSkNiN1N3aVV0ZXBGMU9UMEFETVpONGE4aFBDd1dNaG1J?=
 =?utf-8?B?OTVYbXNTL3hLNER4Qnk0T2NDbFR1MWd6Z1Q5aExycVRualdlSzZreVU5a3Rq?=
 =?utf-8?B?SlRnTHZ2eGVJYjVMQUZ3ZnVxK2lMSzFvN01vdFYrcEw3YUI1eVJSSk1NSHFi?=
 =?utf-8?B?blpQNHVYWWNHdm94Y2wzd29reTR5UVJmaUExRjg3QTZ4em1TSS8xTWw2QzBV?=
 =?utf-8?B?L2tEZER3WlRucXN2alp5b1lTamRNSm4xbVBPODlKSnVnOGdaT29rVlZMNFpz?=
 =?utf-8?B?MGJYTHNFbHlLZy9GMThvcUVxYkgra2ZPVjdhY2dnR0pBMm9FeW0yUEtaL2tr?=
 =?utf-8?B?WTdndmRWNm9LS0pnWGF5UWFnUEVuMHRzUURTZ0dIU05yYmlzeGgzUTBhbkRT?=
 =?utf-8?B?QUNHKzFwUUlONi9QTG12aXVrdlFxdU0zYUdBcjJYQVlTdjZXVUtjNWpKNXE3?=
 =?utf-8?B?ckxOZlVOWTM4Y0MvUlkwOVMyOEdlakFieTBWeTUzcTJtUzFuZ1UrK3ZveUMw?=
 =?utf-8?B?QlBZK1hmSUhTR24zd2FublJFWEdEY1M3eVlGT2V1TnpDQ3NUM0oyUlAwY2lj?=
 =?utf-8?B?cWIxcmJHeEkvTUptRDBnSFFuL3NhZXZmSXBZMWc3dS8zNE1SZG44Z0NMN0cr?=
 =?utf-8?B?MUtaYWRFT0pSK0JnUng5ZHloektHZkJzenBmWHo3NklVcUJoZWdrNXA2Qno1?=
 =?utf-8?B?N21yTVd1RGlwMFpVMWQyR00yUE5mbkJqcE13bzFxb3ArRXlac3NSSnV1WFkx?=
 =?utf-8?B?czV4VWtyMEJ1OEFVZ05hSFpxZ292eGR3UThxeWpIYWlUZ3JBTmNwSjl4ZGhS?=
 =?utf-8?B?RkF6NWpCT0kzSG1aUk82TGxsMGU2T2tDQkRuZ21nQmptV0RONHB1dG9EQnhN?=
 =?utf-8?B?OWdaMjNQS0EyazlkWWlYNmdzWnNqYVlVT0ZBR2k2RnpuTWI0M1VVbmNlemN6?=
 =?utf-8?B?WjdSbXhoWG9vdVIrdVd0N0NJOUtkODBITXN1LzRBTjF5dHl5bldoODdCejYx?=
 =?utf-8?B?anpaOEFUVnd6b1JEa3h1REFGMnFiUjhnZXdnTzRML2NpSkhBR09HZGFReGVX?=
 =?utf-8?B?NHJTbHRzbGxoQWo3RDZGcUJUL0VuYjNFb0JDSmhqb2M1bGhXdTZDZktWRGJr?=
 =?utf-8?B?Wkh3d2Q2U2NHWUpVTk00aXNRVTZnTVk1bW5zRTdEMTdCekNmKzBiZUs3QnFn?=
 =?utf-8?B?ZHFxQWdnNzJKRXppcjRNYno2RnRGcWYxdFd1UVNvVVBqRHZ5UTl2aENDcFhz?=
 =?utf-8?B?eTZ4YXNkUUxaZkpDL2pFbTlEbi84WkdpdERQR3JZdUYwMEpEdDNYdEVXRjcx?=
 =?utf-8?B?am9RU0pvS2lnQkl3TGtPanNoSXI2a1l2WXJSc1FKL0tNcFpBUFVjeUNqSExI?=
 =?utf-8?B?V1pKZ2V3bUY2M3BmV1ZmUUpVYzFZWnA5aXRWMFZHVkR2Mi9OSVprYkx0V3hW?=
 =?utf-8?B?UDNUWXBnTkJROEJaNnRsUFF0djRrZWtTOU9iWmRmMjNSUCtMUy9FUTNPMmll?=
 =?utf-8?B?SEhuMyt0OXJBUXhWQ3hwSkRPOEFzK0hGKzFTS1liTEs5QXhPa3VtL3RVRkR2?=
 =?utf-8?B?Vit4UFRxSzk2NnIvVHZOTEhabi9IcnVmYjJQOVk0RjZxamE4c3RYRENOaDEy?=
 =?utf-8?B?ZjdiM0s2eVJ2Vm5jK0dBc1NOdEx2VmRaZVBudUwrUmJtQVlaNmNQdUFicVVW?=
 =?utf-8?B?aG5ZV253cjRKMzgrUGxwLzhPWEdqOHNXK2ZGVkEvOENQMG01K0ZOVm9adnly?=
 =?utf-8?B?dDc5MnQ3Q1RFaityVFZDQVJYZGxaN3loTktka0JjNXZRYVJtai9RMFZIcE1i?=
 =?utf-8?B?QkEyUHFLcExOZGk5Y1p1NU9heEZ4K0JMTUlnbWN6NWMwUDREV0J4cndBQzZI?=
 =?utf-8?B?OFZCamNLMjlDUzRGTkVjT0htdmFwSGoxZnYwd0krQ0NQWXdhZ2lzT01VYlJJ?=
 =?utf-8?B?R2pGU0FJaWhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3N4Z3Vtd0NOWXJSNEhZZ3Rvbmh1NTVCZXllenFOemZLcGxwTkw2MFcwSFhz?=
 =?utf-8?B?Zk9Jc2FVY1lDMVB6anhreGNiaTNOK2hsY1VmZTNEcGc3WUROU2dldWRMbktP?=
 =?utf-8?B?ZVNwSUlscnRaclo3bDZ4Y2RuM1NSMU9aaExjSkNXR3h1aTdjcE1yLzRrWW9t?=
 =?utf-8?B?SVZlczhZS0kxcVNRd2IzaTR1SHlpbVhrZTlCTkdOYzFCL1hKa0w4Mk1iRjYz?=
 =?utf-8?B?bmlvNjBOM0svWXI3VEh0WTYzQk5nYkxSK2VyMjVOWC84Q0gxVnV5SEVDVFpB?=
 =?utf-8?B?UHE1T2ZWL1RqSUdkY3pyOFJpN1MyTUFiYlpQVUxUVkZCOE5ZYy8wZ0hNbWJa?=
 =?utf-8?B?RDM4SENKb3psSlNBMmtod0xPV1JVbUxjTmpoWElZRktWT0JCSlJEZ0ZYUkl5?=
 =?utf-8?B?OG8vbFRSa0tvZUJJb0duZ0tGVGpzdjlzamN5STljMXQ2L0VHU1RwUFlTVXls?=
 =?utf-8?B?OHpBWEFRVXVGSDdqK3hkV1JOMGd4akUwNm5uOTZhbmQxR21BbEY3UElaVEta?=
 =?utf-8?B?Yks3S3Q4YlRTaEcveThSZi9BWUZKUGs0R2xuY1YxZGlWcHd6Y0lKTFd5MjJP?=
 =?utf-8?B?V2QweGREQTc1UzNVdjd2dTZtVzE5bnY3QTkwdHFRM3B1NXNBYzdVRmJaWEtK?=
 =?utf-8?B?SGlVWGJGcFVWUEVQaDJ1NTQ3RWV1QkV2U0pHaTdLNmIvR0hGNU5ZZXZlSUt0?=
 =?utf-8?B?bTNhcktmZHhrQ0ZqaWNNak1IQ0piNDBLdXRBUG02TXBlRW5RTm1TQUdXN0RN?=
 =?utf-8?B?RnFqdjBWV05DNEs4VHpKaWtCOWJKWndLMDZpNUtqZ1dieGtpVzFSL2FnakZC?=
 =?utf-8?B?Z3o3NDBqKzN4VjErL3p5eVRRcW1UdnQ2eFpxMnpKZi9vN1d3cjFlRzdZS2U5?=
 =?utf-8?B?dW83TkxZN0FsNkFSSUdsWU5paUk2amlTRklCWml2M0IwVmlxZzV1T1JZemNT?=
 =?utf-8?B?VVZKV1JxUmpzeEpxWitCWmM4Q2I0TkdCRVl3OXdTWTllZ3pUTXFIMFJqSWE2?=
 =?utf-8?B?Yk42a243TmhyeSt4ZlF3UzlLS0JDWGE4VXF0YjVtKzlvSk5hUHF4NVNHOHhR?=
 =?utf-8?B?cEpybnM1elB2TjJhSFY3RlpLK2x4QzdqK2JIQkRteW1mZzVmZncvVUMrOGgz?=
 =?utf-8?B?dkZrMXlPbXAyN0dTKzNhT2lLQTJmaldvNmhYN2ZZYjFUcDAzQUJ2N0dHQlZI?=
 =?utf-8?B?aTltOTh2YnVQYVVzTTNJUzQyNi9qQmZMWm9wNjA3V254NTZ3ajRSa093L1RT?=
 =?utf-8?B?Ym1Ec3JFN2pGRXpVelc0WnRET2RkbHNKdTNSZ0VxK2d3T0U0YWt4WDdiQ05K?=
 =?utf-8?B?U1krc2NDanc2bDlHWDgyc3lXaU5YUzQ1dTU2eU8zdVQzRWRtaWtqRmtQTmVQ?=
 =?utf-8?B?ZzFqWFZkVVhrS3g3LzlucElGbVJGNHZ5SGlNMVh5NTAzNnNUWnBURjZwQU5x?=
 =?utf-8?B?R0JrTHk4cjhLOFhmeUV6UkVSVXNPb25CTnBUYlROSEF3QnNWSWZoNzJibUJa?=
 =?utf-8?B?MkErY3hSdHBpNGZPaWtvaXdJZ1JlTXlTTTBqY1dlTS9yZE9GMWVDUUIxYnRm?=
 =?utf-8?B?SW1JNHJwRXV4SVRySDNGQmxpNzJvVFN1T3ExOXhUeVN5QlpqUjV0L3ZWbFlj?=
 =?utf-8?B?WEdrNXlxTGwrRUY2N1Q0M1FSRlczVVFYME4zTUJLWUtTVzBuVm5hTkpGNlVi?=
 =?utf-8?B?YVh0UHBHZG1WRWVCdnN0aXZLS0R1dTZSQll3NndBL0xiT3VOT2E5RGJNY2c1?=
 =?utf-8?B?S1JrYVljYUlkeFl5TFR6alRac2gvZ3lycWY2cy85VFhkVzBqZWV3QXR1VHJY?=
 =?utf-8?B?WTJHYkVTWkdTVDBBWFhyS3czcFE2YmtybE1PejdqZ1dPUEE4d2I3Qy91bHpj?=
 =?utf-8?B?Z2todUIwSUdrdW1Bc01JWC9HV0RocjZsN1ZsdDJjbUI0aTJsZEgxTi9WTk1K?=
 =?utf-8?B?NlY5elQrbVF6NDIwWnluWUk1bEZaaUpkS3B6RkxLWHNpdTByajQvdGpPdTF4?=
 =?utf-8?B?UnI3ZWhNU3dXM0poajhPS1lXbms4SnptUmZWRnlTMnFudDZYdUoyMXJDMGhD?=
 =?utf-8?B?UzVNY1d6cHJid1NmZE1PejJLUFFkVWt5UXM2c1RWaEJDYTlMK3NnYmFDZjk4?=
 =?utf-8?B?YTJocnYyaFU4aXlwWjVmQmgvYjJRZklpNkZmTHVET1dCWStDRStibW1BY3lh?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hMc3XwOFZtNOwe1H9UN5xnS5Wk3v1/Yhih/EJ1OxT1GE3JNJsbDRMefS1JimqB0+pyKm/UdbnSlAr5sdtGaEp8t0bhuPtMVUTSE0OjwXIeBoGfTt1Yqj5OFTxzjcaVW21BAzwzsWYAB+iOM3eK0bGGsCZo+MXfhxwWjAb8YG1QRqE6xlHZ70Oi3mlL0Al7KCkI+Kd8JoInPafF08nEjOC6alQQrd1cJDJxcEfnGKTZ8GCdb0rqSfTvBpzYnoaZ0Lr3V1H6bD6zf2CmNbH4b5r8L8AufnWjUp2mRbWb36DNytjWkbJ8kQB4UKz0LFZ3bd8hlHwzX10y919o1OOoFvnfnZar/Yz5/R+0KATMQHv5a9FCXVN1h8vzj/pOQGNVe6EaqLtB7YjkkwPcGnTy5JI/UqkbseacogkspbPsHSe1RHh5ZZuaS5VBTjfOAI5Kz+Wplb2TmH8EEVbi7CeFgfRT+7KfzDERB7EH3hpCJeNjIffR3amODrskh3OaPHdSyiRSU4b/FP0wsCipLEYBqGiUDXD0O1kN5YWJAB4Mfy7wU8UgEYteTMpq5qLfdDL2JiD/e9jI5tvGj/wGon4TvG8OaDaDM3uoAx5V3cX154QyE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1141b3f2-9b89-4dd4-e8c7-08dd9115071f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 05:22:51.1547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FcmIT1cW+3mgAJy3Ras1LHmNGnF6w8Iv66G8TvMPzViKsBSwVMLIgitPH0RT44rCJrAKrLmVrlK8RKrk4TeCLRGL4vKOirDtS7PCDQIB/pE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5882
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120054
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA1NSBTYWx0ZWRfXzgORMyh9tofq JwIurCDfGmMTAh9sMXVV+jPJpInEmOo6gvJvGa2eXdbJdT/b44lt49CHuRgfLHo7mI130uUSroD 3AvTH+nzCLKS8UUEIH0784v6GEoaZ8zr0NCogf4RQ8QXAmwNqiyEJRls6y3Bws02dAnxSjM9G1j
 z8MUwtjWm0oPdeNBk53nHIf+kUzwxm2mMa+i93gDsf5P4mgyhE3o4mcah1ZBKberg9NNZFRL0yx F+duTnee2jY14q5Wo+Y8imgFdwKbM5cXgy37x+t/Ktmyo/IoBHh4yceODgzzIL8FNzz7iBl/b/n mY1P0+E8zQUI7KnuwHq5EeLSJFudukRJndrnf9E8YC3vsAjVWmRA0c/nScIDSuGJSwKeejKDBJA
 mClvtMfiaV8ux47J3XAMpAt7Q0T/8j4Pr4XossvkNj5K+zDgREsLaonOR8KA9EOnsyQXT/kF
X-Authority-Analysis: v=2.4 cv=VMDdn8PX c=1 sm=1 tr=0 ts=682185ae cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yMhMjlubAAAA:8 a=HKyj-Qf7lpH4eksrqv8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hnjLic7ttcuIH6lA_kr3-e23Xz2WfiHm
X-Proofpoint-GUID: hnjLic7ttcuIH6lA_kr3-e23Xz2WfiHm



On 12-05-2025 04:37, Roman Kisel wrote:
> Define what the confidential VMBus is and describe what advantages
> it offers on the capable hardware.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>   Documentation/virt/hyperv/vmbus.rst | 41 +++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/virt/hyperv/vmbus.rst b/Documentation/virt/hyperv/vmbus.rst
> index 1dcef6a7fda3..ca2b948e5070 100644
> --- a/Documentation/virt/hyperv/vmbus.rst
> +++ b/Documentation/virt/hyperv/vmbus.rst
> @@ -324,3 +324,44 @@ rescinded, neither Hyper-V nor Linux retains any state about
>   its previous existence. Such a device might be re-added later,
>   in which case it is treated as an entirely new device. See
>   vmbus_onoffer_rescind().
> +
> +Confidential VMBus
> +------------------
> +

The purpose and benefits of the Confidential VMBus are not clearly stated.
for example:
"Confidential VMBus provides a secure communication channel between 
guest and paravisor, ensuring that sensitive data is protected from 
hypervisor-level access through memory encryption and register state 
isolation."

> +The confidential VMBus provides the control and data planes where
> +the guest doesn't talk to either the hypervisor or the host. Instead,
> +it relies on the trusted paravisor. The hardware (SNP or TDX) encrypts
> +the guest memory and the register state also measuring the paravisor

s/alos/while and s/via using/using
"register state while measuring the paravisor image using the platform 
security"

> +image via using the platform security processor to ensure trusted and
> +confidential computing.
> +
> +To support confidential communication with the paravisor, a VMBus client
> +will first attempt to use regular, non-isolated mechanisms for communication.
> +To do this, it must:
> +
> +* Configure the paravisor SIMP with an encrypted page. The paravisor SIMP is
> +  configured by setting the relevant MSR directly, without using GHCB or tdcall.
> +
> +* Enable SINT 2 on both the paravisor and hypervisor, without setting the proxy
> +  flag on the paravisor SINT. Enable interrupts on the paravisor SynIC.
> +
> +* Configure both the paravisor and hypervisor event flags page.
> +  Both pages will need to be scanned when VMBus receives a channel interrupt.
> +
> +* Send messages to the paravisor by calling HvPostMessage directly, without using
> +  GHCB or tdcall.
> +
> +* Set the EOM MSR directly in the paravisor, without using GHCB or tdcall.
> +
> +If sending the InitiateContact message using non-isolated HvPostMessage fails,
> +the client must fall back to using the hypervisor synic, by using the GHCB/tdcall
> +as appropriate.
> +
> +To fall back, the client will have to reconfigure the following:
> +
> +* Configure the hypervisor SIMP with a host-visible page.
> +  Since the hypervisor SIMP is not used when in confidential mode,
> +  this can be done up front, or only when needed, whichever makes sense for
> +  the particular implementation.

"SIMP is not used in confidential mode,
this can be done either upfront or only when needed, depending on the 
specific implementation."

> +
> +* Set the proxy flag on SINT 2 for the paravisor.


Thanks,
Alok


