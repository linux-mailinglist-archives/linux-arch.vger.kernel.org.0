Return-Path: <linux-arch+bounces-14883-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB4BC6C1CE
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 01:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C2974358442
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 00:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037A51DDA24;
	Wed, 19 Nov 2025 00:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LhWVbvYK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x6Ke/Jtt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E137A13A;
	Wed, 19 Nov 2025 00:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763511699; cv=fail; b=Smn87oOLO4sWewqVRQXqNLqW4MiNMws2rIv/8zKcZHUlxUxvN/hJc6Rmu53j4nehBVmviLpxZUpnkWpqB2Nmwf+zoCJASGlDoOrozOvaVk1qvDX6ri2qxx9J62r7rGb354mFICxRM7Ut5vlKwnSA4r+enJokaRXNmkxoS6aDV4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763511699; c=relaxed/simple;
	bh=JCGDDsPlvZpwt9dguw8UNdHDdux0eragL+fNvok4rc0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ogiWstM1Zrgcv5BQCXTGzsIjzXY+6uBMkm+La9X2RRyYpZb3mOLW8OOBeWs7gNyq4MIX48vDtvg/7YVm5xEaP80+wXguBMj5P/2n82NhQWte/vbybhat/Ii6jLc6VI0egcc9bPIQ/t4Orz9a8sPMVdP7pXRPsB0LL3/YS0bRANo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LhWVbvYK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x6Ke/Jtt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AILNkXQ025659;
	Wed, 19 Nov 2025 00:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JCGDDsPlvZpwt9dguw8UNdHDdux0eragL+fNvok4rc0=; b=
	LhWVbvYKAAV1HrYFuGNSSzVGAHDxxKm7ermQBS8y5CBeMLQa5zWRTfexcOmSDelK
	71awqaAxKIiNWoUFnqywJj+T7ez91ivZwAKDSSv5ThnI1vtcCu1zZL/Q3761cYGk
	AB+4g/GUpbc2hqlRd0MzVbWyNEWAc3gzO9HykjKatxDOb9xLnlGJuBj0D07ZgzF0
	Y1P2BffAGZ6xc3sQInj3RQdv5QtWGyG01xgbprcU5gVo3zYWKxQaCFZJhyKWRJAr
	SrfkSYqrCVynDFWMK6FZBHoHVaXzyyQZlYVtWwYyWEu7jCugV7U8Y4a12rgBaJ3c
	9dW2aaRZ1ZwGOJhuol+x+A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbpx3qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 00:20:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIMDYoo004464;
	Wed, 19 Nov 2025 00:20:37 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011055.outbound.protection.outlook.com [40.93.194.55])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy9mm1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 00:20:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KStKo/yL6dt6nXW+6/7nhbu0eauDXRJiIbMuPLTwVY9jefm6k5KNsjLa8AmEMxel4pyin2wT1DqeTYPiK3VRlV8O3o+X32ir0DeatNp/NaWuNt8rvRLKMK7Q6GwWPB1y8bNaSUwtSnptQ7fiP/Yn9pPJYVZK2xK8MYUinzh2SkfUNMMBUPecy5MjH4z9aPK+/JumA3eNyuutWfBF5+yfxXEx9OCRu9KnQj8SPjGSWvWmktWn594/TvlKou4jp1fA48Or4YVKml/rrOwQhebBTXoFZaCSvXAPf/fpphCtA/YzLzUPLeWeNn2ZPQIBlMaQ2XneAI2SCkBlbzv06hDPPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCGDDsPlvZpwt9dguw8UNdHDdux0eragL+fNvok4rc0=;
 b=iAJY2ORf0RhCSH9P0ik5VV1MVbrNjT09zj8XzZFzhHkJOR3GNGj/uuk+L6P4TTN52B1wuhjiXc82l/qLpU00afDIjVEFcGDLLyGmgm+GseR3fJDC3gbe3m2c66Zg3Wb7qc/PNucHOjW05unWRPmtf4kqDOLo2Cd1I9Su5bkFMw/uMC92AKzbr/g4W8AwVPSF2/pPp+aX6i/9k6pWJMWNJPyJkf/VLd/gbn22oAf4i+V4FG1UQHX6pYCDM0cPtCb72/H7vk4dMNZPKD7x9uLhzoY3lcERZSETPIDZpS8SLStUpCTxvi1du4hm/nInMNb5rsXPY3iC/Kh8EtLH8SE7tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCGDDsPlvZpwt9dguw8UNdHDdux0eragL+fNvok4rc0=;
 b=x6Ke/JttgVu9e6DzAmQcthx+Ue4YfENBBivXOoNuUtv3ioJhvTqXD+4IS5el7kMIEkKcZxz/Oi1WPzRsGZ5R6WrN+W4PPo1ai4T5rD1r1JRqckkm6tC82W3OFPPze1AuklMIE4hol8cnX/UyIPYxtVFRUS3vlxFMAxtvWm/pKww=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 00:20:34 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::5f79:36e9:a632:d010]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::5f79:36e9:a632:d010%6]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 00:20:34 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra
	<peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: Re: [patch V3 07/12] rseq: Implement syscall entry work for time
 slice extensions
Thread-Topic: [patch V3 07/12] rseq: Implement syscall entry work for time
 slice extensions
Thread-Index: AQHcSNcVPmZlcazHA0W81AHywt8/IbT5QumA
Date: Wed, 19 Nov 2025 00:20:34 +0000
Message-ID: <261A8604-DA8D-468A-83BB-F530D5639A43@oracle.com>
References: <20251029125514.496134233@linutronix.de>
 <20251029130403.860155882@linutronix.de>
In-Reply-To: <20251029130403.860155882@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81.1.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|MW4PR10MB6510:EE_
x-ms-office365-filtering-correlation-id: 3c87ac25-ecdc-4995-b408-08de270174ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?N0VYbmVnTlBseGYrUHo5ZWVWSm5yejZ6TTlUbUFCcTN6bDYyQTRDZG5wYThP?=
 =?utf-8?B?ejQ4RHFNQW95emZjYjQ2Q1YvcXE3Ujcwa1FnU2FJUTNuWlczbEl0ak5Uai9E?=
 =?utf-8?B?dzVhWm9NaGc5ZDNhUEpKSlJvYTBwOHJCSWtoOTAvelVCUWxudGVkbDNZYmto?=
 =?utf-8?B?UlhUWmpsUlNsTUtSaWthZGZwc09XTFVRMlBiT0hHd1Y5NERjdmlVRDB6eStP?=
 =?utf-8?B?QzFleFZnOHNMTWJCRjZ3RmNpcGZCVFNPM2dFTE1TNHFUZWNLcm91czBSSC9r?=
 =?utf-8?B?K05oYmZ4WGU5V2IzK2pYdzlBblBPUmc5cnJKcHdHa1ovMEVJdnZFUXdrQzlL?=
 =?utf-8?B?OG00U0RvV09kK3ZQTkZxc2cyQlhFYTZJODhEVzBQVGNUZ0Y0VE93Y1V0Skw2?=
 =?utf-8?B?OHFYcnZmSFdKWktybUxnVmlscU51UmtyWXNVMFBELzFVamNXYVhuRWFhMVMx?=
 =?utf-8?B?STVseWF5bmV0ZFVOTzFzYzUwc2J5NnBNbHQwbUp0eUxiMjRTZDJpK2pHOExS?=
 =?utf-8?B?RXlNcE5JSklyZzhVNmk1Y0d1VTJRN0JXVEZnSllhblU3UEhMOE9Hd0Y2QVhB?=
 =?utf-8?B?NVROOEpGQjllWWZ2cE5lY2hQdzB1Q0p4QTB2QmlmemM4VjM1bDVOSVFoTUFD?=
 =?utf-8?B?dWtzM2ExRE4xY1VTQS9YcE1BMmNDZU5mNEw5a1hNNHZoWUdWS1l2RHVzemg4?=
 =?utf-8?B?b0Nic1NRZms5YjdsRzA2WU1lNFhaL2dKZHlVTzBFS2RreVRPVVdkSFhNd05h?=
 =?utf-8?B?NnkzMXIwMjVQcVlsdmFKRTI4K1JXQ1dFaXdQaU5CRWIrSG5CaXFKRXRaTFZW?=
 =?utf-8?B?RzZYN2JRSU04T3VlL002b1g2Q2ZGWUZLTnMyMDF4dFJPbFYwMTVpQ1dNSUtv?=
 =?utf-8?B?cEVHbm54aEl6ZzdYYnl2emwzanR4eWhXWHVRRStZYWxVNzBrQWJ6VTBtOXpX?=
 =?utf-8?B?czNNcnJOM1R1d0V5bnB6VS91dEVabzBCbXZjcXdOUnVnTzhDdktVNndWSWRK?=
 =?utf-8?B?RFYxUmorYjBFZldlT255clRGbFNVcXhiYVhqYmRHbmpOcXl5SkZobU9Dbjkz?=
 =?utf-8?B?SzdDbysrN3dlNExVN3lwekZpWmlORDM5WXc3N0VXNUNBSXBxNUpnMllMVm0r?=
 =?utf-8?B?bmVmODdyK0ppQnRtRHY3VXArUVI1cG9yVnlJT01iS1IxRitWRXVleGNqaDZN?=
 =?utf-8?B?cmRLeDN3R1NUTmlTdTM2SnYyT3kxNSsrRElEZDJyYTBadXVETzl5ZHhhbmxW?=
 =?utf-8?B?emdMVnVidENIR05xNWo2aEVBVER5QnV5bmswT2ppOW5BbE5KQkx1a2VNb3px?=
 =?utf-8?B?SzFrekZibThQamwzRGZac1FPUkY5NS83VWJpOFQ4amlIMEZ0eHBZZkhiWVdy?=
 =?utf-8?B?b01ZSWI4eGFDVUxRSExXQ1MyS0ZiQlNRd0hKRXpJNTNmL0oxK3hOZTJSeUxT?=
 =?utf-8?B?QnBaVXpLU1lZTmV5U1ZsdnFLYmovcHJONmE2bS9MY2ZnWXlWZmxMU1RjOGFQ?=
 =?utf-8?B?TXE5Rk8zQkFXZElDNXYvMVp5Qml3Vi91cURPU3RKNWsxUGN4U3F4T2tYMFRB?=
 =?utf-8?B?R3A1MVJkQjRhdERsZFpzTGZzTnd5eSttQytXdFF4YXl6OGxSR2MzL1N3LzE0?=
 =?utf-8?B?eUFodXJVQVpZK2paVFFEbzBZdGw3UGtHSWRrS3RteU1KRksvelV4TFF0Z1dj?=
 =?utf-8?B?SmdFamNTeDRTandqVWc0a0xXYkxxbExpeDhWVURZUHNpNUwxRXJYNFhkNVQx?=
 =?utf-8?B?a0dXSmJwc1M3TkpWbmNLcDNJTENvbkFDVDBIWURQTHRqelZUeldIc0ZFVXB2?=
 =?utf-8?B?NlFhazdVNE1LQnNnS2dXTFZsSCtmOCtaVUdBOVNWT0pPVjBMMXUzV2dQNFNo?=
 =?utf-8?B?bnVqV3B6V0dnOWhXZ3Rtd1BLZmpvbUdSdnQ3VG1lMFlNU1NwbVVKS3VWNUJN?=
 =?utf-8?B?WUtCSUZPY0Z0VFVCRW54a2hGT0N0Q25zU093MmM5b2VCNTZySTJHc1VtbExo?=
 =?utf-8?B?THhycVZldXlIeXNoR0tUelladlB6TDBxSklnTEZwUXg0KzNaeGhSTUtSek9V?=
 =?utf-8?Q?LGf6wo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTF4WkZpVGVBWVJ1VFJPTVFEMlE5QzN0ZXBkMmcvNkR1SzFXd1ZzY0l4cUVI?=
 =?utf-8?B?SWFEYzBYeUE4ZUh6Q281dUFQQXBmM0xyV0NVUFIzMWdZS1RYUHMzZjBYemhV?=
 =?utf-8?B?bjVtd04vRVVCWVJzRGZ1SlVQeHhSR3FlNE9SM0lIRzlZU0xNSkVxM1AzdEs1?=
 =?utf-8?B?dGxSdXRNNFRkS09jTEdNMzFmMWlhRWxvUlNvditSTzVUOHlabll6aW1KTVVz?=
 =?utf-8?B?bXRCTDg2cmN3NFU5dVM0UXFHOHpFTmNJeHlaQWx1L2dOQSt6Z2N1cmwwNUgv?=
 =?utf-8?B?QUNJRkhkWjRtSCs0ZWI3bVkwQWRqUGdJNWVob2tPanpqWkxIWm5FUGxwdDdz?=
 =?utf-8?B?eUhCbkhtV3dFdVF2OTF3WlVOOVBMVWYyMFZNeEtmV0tqdzVML0ZDYlJkSXc4?=
 =?utf-8?B?dkFhc1BlR1dBOCtFQThLVUVuM0lyRzJ5TWFrUTNUVnEweEFCTzBJKy80Kzhx?=
 =?utf-8?B?V1VJbWYvNmJrZzNrMUZzN1VnMjFsVDVRTzF6czV5WVdzUHBIRFVRNHErYUJ1?=
 =?utf-8?B?YjFSZW5PejRKeDdRYm9LTlVkeGkrTG53WlNlblByVkZjbndtT1JUMDl3SHlw?=
 =?utf-8?B?dFMwclptb2M3Z3g5SDVrT051QXYxcW9CeHd0Y1RmYVJsQUFTNVN2SUxqZXpG?=
 =?utf-8?B?U2NTYlVlT3dhbjI3dXVKeFJIQi9rU0ZSbzNXczY1ek5JTW9VeGVLNytLS3hs?=
 =?utf-8?B?Q0FDRWpsWmZKRU56aVBQR2VmN0FzYnVCMkc3d1ZIMUxQNjNVTWVLaDFzZFJx?=
 =?utf-8?B?MS9LV1FQaVVGNzhIUDE1eVVUdnhyVmhMd3JHS3J5bjY2TU9WWWZ4dUpMS0Na?=
 =?utf-8?B?NDh6d0t5TE84QjYrWE94eS9NOVJXaWJXemJRcGMyQ3dBRVRiV2Z2N29LVzU4?=
 =?utf-8?B?S0RNUEdpVWlNNDY3WlBIYlpPLzhkdDZCbWJ0VjA2cU1yYUNQUUlPT0VsM0hU?=
 =?utf-8?B?Lzc5UVJYZkE0YWlEdlNoU214dTYwc0N3bWlyWUlmTVNzbmFXTiswdFVJbE92?=
 =?utf-8?B?dTQ4UERmejJyTVJOaGhHeTlNVmEzcThMeXA1VFBTWWQwQTl3V3UrbURVWG91?=
 =?utf-8?B?UndNcWFxUDI0YWV3bTRVZnprV25IVm02UXJyaTNudlYyN0Z0cWIxVWxmL0Jp?=
 =?utf-8?B?SHkrL3NRbittdVJMcXdzWGpIOVZ3cU9MTE51ZUdiRlFyRk1kaXB5VmRkK21P?=
 =?utf-8?B?V3plRXQzTFcyMm1xWlJJNUFoRVFIaXRVUzEwMHZiL1k4ZWhhZVl0U1hGQ1Az?=
 =?utf-8?B?WGVlWWxQUWJKdTZ5a081bENRTmI1K1N1TzEralBRWkxPVGRiNXVleG5sODB4?=
 =?utf-8?B?bkJwOTgzTHN5UUpwb0VlUVVDbFphTkJDZXdWZlRONGl4NVlxNWRvZUszRlI5?=
 =?utf-8?B?YldJN1pHMkpQQlBjN1BJYUFsbVp6WXJhNEVBcUVKVXJUUFdTVVRVMzVxdlFG?=
 =?utf-8?B?V3FUc0lKQW44UDFnUG5nUWphWXFaa1VUN0JyZ1BYcFVHUTdQQ2dzRE9JeW13?=
 =?utf-8?B?dnhlb0lPL1dUK1h4bmJCYTFjZHN2TDlVZTVONmpoNTdyTmNiT2wyM3VYMjJL?=
 =?utf-8?B?UmZSdmo4WStBeFFRMDlhS0pCWlhmU3VwS1VnTGlkTXRoYmZhblBjTUliY0Fm?=
 =?utf-8?B?dWZyU0pjNFJiZzczR1ZyZmxKTTlBcHVKZXpPODZ2N3dTcnZuMUNPRmtSclZ5?=
 =?utf-8?B?Z3FYR3FqSnR2RDg3TkFBNXFzcm5GVmkvTlV1ZEtJMEdNakpzQnNlNU9URFJI?=
 =?utf-8?B?VFZKcktLWXRzM29IMkhHUkVVNW5jUzQ4NXJvVDdkZkIrR0dob0Mxb1FmdkQx?=
 =?utf-8?B?TkR1SWx3WGhMQ3pRQVZPU3VUVytNZGt2QkJYY3BFR2xRenVwMk1iQ3dFdVQ0?=
 =?utf-8?B?TkFzV0lmVzZXRGc0U3RYbEgrTzk4Mk5Pb20ya1BvQ1M5SVdLYVcyV0dkK1FB?=
 =?utf-8?B?K0F2aTRWSXVXTnpYR3YxYktXUWRGRnNGWGZ3aVZhckZuV0tsRUxjNjJ6QzQz?=
 =?utf-8?B?c1JtSFZLZnhPSmxMcmhVTVAzT0hObDhSMVhPN0tKVUdacVNYTDExOGh5WTlP?=
 =?utf-8?B?UE5kbGxpTzRvWEdsREwxb2ordFdPaXFrKytFYkdibTl6ZDJLazhZNmxrc0Y3?=
 =?utf-8?B?OVhPWEhxNU5pblhIN1lkMmgxdnJqOThyQnhZdE1EVTRyZnZFekd5R0N5K2di?=
 =?utf-8?Q?mQ10xk8k6mnaUEQrwFBdAvw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCEFC96D7676224C810BEE4B54726041@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZUey9FihSTC4WWouCcYdXvjgGOl+WUdXn+E0tnuj+hxpJUF752tPl2sFMVkqWn/juJfRgky5OSGXKNj5HVKCe9Dk8pi7I5dqF7f/711Qh6cdq45rzyawK/9t8cfrYVgKkYjL0k6VobBuC9uVQ9naZ3CZEbkB2HFcGiP6uHSOUzQuiq5QSi6WwV5mf7zxiL5NEFRZqhlwUW4l4uy5lpRP/BtVxpDj2kKQNMVctxT/guRMfCafjaOQaan5FAEROh7YsYXTrs+W9SInoobno8Z+r2pn9aFIbAjyqGsZrTIiQ2aCtAekFzDe7838+Zmv037ww9IFuRAI/sk7D+C9sbQyc5Ew+//YRNsDlMSfjF/HvifKysY0dOU7jqE8oqO0ec8Qi+fYzMkwjjpYGbfvNCnmKx1Ut3TgWRCmilCwuvuEnqvjnCyb9PooZ17q7tqb5lYSVCbXRcDDs/uYKzuz+yIexjjytzm6p3m51oIftcQ5sOBTrSBMnxxTn8bs6s8Fy+gGeJFphCk/Hrx4OJ5V+JrBiFCQwAd3cv9x/xeOipe0pKfy74sutvZpWt1B8PajDNfzNKzIo0wbIrxtCODPvP0Rn0oa8NvRQe+DGx2wVifcj6I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c87ac25-ecdc-4995-b408-08de270174ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 00:20:34.0904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8bZzdKZsDK24yPHHKxh5wQB7e+4K51yt3YPV3SIJ+/nSwsOCm2wuYAY8V41QqU97SuBwc3LNU7rKIjPlSX+8yHLDeWyfYR9I0tqxtM28eJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511190000
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX+o1WbUJfJI+M
 tCYc99WYQQ7amhWVxod2nY7g1DOUHbAySMJ2mhSx8kPZJwvb96yDwJodUTxxJvgpMQ7Bn0X8Obc
 zV/AMqUGg8d2ArIDggbyTc4yYeLEnORzm0JzYihZAkQq+EywnBA1gjy2/h/tCarkKKpvnXQ8tmV
 zt8OJ4Yze1RW5t3E2xKm+5jTbeZhe3U5oMMEovOYUhy0RVztabvTu416jrPS03ZmjWXkFCMROr7
 KdSdQ5FwJ3MkHhGH5j32p/fr0+rRwxSxgwB7lom8Ua9kcQ/53PdDBgi0E82Gx+rJQHhPtPaqxFS
 S0Px5yOeAkX+no8COgbaO7fHWCvJURtZlT7jcg4EiXQNDw9HUrFuMHGjpvI27u67wIUvMj4Ab5T
 9fIKhwJVaWya/6YN4tnUZ/JcO1twXA==
X-Proofpoint-ORIG-GUID: qkqj_j0PGMGT73D1Ul1tLHbtfOuSJAmO
X-Proofpoint-GUID: qkqj_j0PGMGT73D1Ul1tLHbtfOuSJAmO
X-Authority-Analysis: v=2.4 cv=a+o9NESF c=1 sm=1 tr=0 ts=691d0d56 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=dk4CF1Z5tObTqdU1rO8A:9 a=QEXdDO2ut3YA:10

DQoNCj4gT24gT2N0IDI5LCAyMDI1LCBhdCA2OjIy4oCvQU0sIFRob21hcyBHbGVpeG5lciA8dGds
eEBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4gDQo+IFRoZSBrZXJuZWwgc2V0cyBTWVNDQUxMX1dP
UktfUlNFUV9TTElDRSB3aGVuIGl0IGdyYW50cyBhIHRpbWUgc2xpY2UNCj4gZXh0ZW5zaW9uLiBU
aGlzIGFsbG93cyB0byBoYW5kbGUgdGhlIHJzZXFfc2xpY2VfeWllbGQoKSBzeXNjYWxsLCB3aGlj
aCBpcw0KPiB1c2VkIGJ5IHVzZXIgc3BhY2UgdG8gcmVsaW5xdWlzaCB0aGUgQ1BVIGFmdGVyIGZp
bmlzaGluZyB0aGUgY3JpdGljYWwNCj4gc2VjdGlvbiBmb3Igd2hpY2ggaXQgcmVxdWVzdGVkIGFu
IGV4dGVuc2lvbi4NCj4gDQo+IEluIGNhc2UgdGhlIGtlcm5lbCBzdGF0ZSBpcyBzdGlsbCBHUkFO
VEVELCB0aGUga2VybmVsIHJlc2V0cyBib3RoIGtlcm5lbA0KPiBhbmQgdXNlciBzcGFjZSBzdGF0
ZSB3aXRoIGEgc2V0IG9mIHNhbml0eSBjaGVja3MuIElmIHRoZSBrZXJuZWwgc3RhdGUgaXMNCj4g
YWxyZWFkeSBjbGVhcmVkLCB0aGVuIHRoaXMgcmFjZWQgYWdhaW5zdCB0aGUgdGltZXIgb3Igc29t
ZSBvdGhlciBpbnRlcnJ1cHQNCj4gYW5kIGp1c3QgY2xlYXJzIHRoZSB3b3JrIGJpdC4NCj4gDQo+
IERvaW5nIGl0IGluIHN5c2NhbGwgZW50cnkgd29yayBhbGxvd3MgdG8gY2F0Y2ggbWlzYmVoYXZp
bmcgdXNlciBzcGFjZSwNCj4gd2hpY2ggaXNzdWVzIGEgc3lzY2FsbCBmcm9tIHRoZSBjcml0aWNh
bCBzZWN0aW9uLiBXcm9uZyBzeXNjYWxsIGFuZA0KPiBpbmNvbnNpc3RlbnQgdXNlciBzcGFjZSBy
ZXN1bHQgaW4gYSBTSUdTRUdWLg0KPiANCj4gDQoNClvigKZdDQoNCj4gKy8qDQo+ICsgKiBJbnZv
a2VkIGZyb20gc3lzY2FsbCBlbnRyeSBpZiBhIHRpbWUgc2xpY2UgZXh0ZW5zaW9uIHdhcyBncmFu
dGVkIGFuZCB0aGUNCj4gKyAqIGtlcm5lbCBkaWQgbm90IGNsZWFyIGl0IGJlZm9yZSB1c2VyIHNw
YWNlIGxlZnQgdGhlIGNyaXRpY2FsIHNlY3Rpb24uDQo+ICsgKi8NCj4gK3ZvaWQgcnNlcV9zeXNj
YWxsX2VudGVyX3dvcmsobG9uZyBzeXNjYWxsKQ0KPiArew0KDQpb4oCmXQ0KDQo+IA0KPiArIGN1
cnItPnJzZXEuc2xpY2Uuc3RhdGUuZ3JhbnRlZCA9IGZhbHNlOw0KPiArIC8qDQo+ICsgKiBDbGVh
ciB0aGUgZ3JhbnQgaW4gdXNlciBzcGFjZSBhbmQgY2hlY2sgd2hldGhlciB0aGlzIHdhcyB0aGUN
Cj4gKyAqIGNvcnJlY3Qgc3lzY2FsbCB0byB5aWVsZC4gSWYgdGhlIHVzZXIgYWNjZXNzIGZhaWxz
IG9yIHRoZSB0YXNrDQo+ICsgKiB1c2VkIGFuIGFyYml0cmFyeSBzeXNjYWxsLCB0ZXJtaW5hdGUg
aXQuDQo+ICsgKi8NCj4gKyBpZiAocHV0X3VzZXIoMFUsICZjdXJyLT5yc2VxLnVzcnB0ci0+c2xp
Y2VfY3RybC5hbGwpIHx8IHN5c2NhbGwgIT0gX19OUl9yc2VxX3NsaWNlX3lpZWxkKQ0KPiArIGZv
cmNlX3NpZyhTSUdTRUdWKTsNCj4gK30NCg0KSSBoYXZlIGJlZW4gdHJ5aW5nIHRvIGdldCBvdXIg
RGF0YWJhc2UgdGVhbSB0byBpbXBsZW1lbnQgY2hhbmdlcyB0byB1c2UgdGhlIHNsaWNlIGV4dGVu
c2lvbiBBUEkuDQpUaGV5IGVuY291bnRlciB0aGUgaXNzdWUgd2l0aCBhIHN5c3RlbSBjYWxsIGJl
aW5nIG1hZGUgd2l0aGluIHRoZSBzbGljZSBleHRlbnNpb24gd2luZG93IGFuZCB0aGUNCnByb2Nl
c3MgZGllcyB3aXRoIFNFR1YuIA0KDQpBcHBhcmVudGx5IGl0IHdpbGwgYmUgaGFyZCB0byBlbmZv
cmNlIG5vdCBjYWxsaW5nIGEgc3lzdGVtIGNhbGwgaW4gdGhlIHNsaWNlIGV4dGVuc2lvbiB3aW5k
b3cgZHVlIHRvIGxheWVyaW5nLg0KRm9yIHRoZSBEQiB1c2UgY2FzZSwgSXQgaXMgZmluZSB0byB0
ZXJtaW5hdGUgdGhlIHNsaWNlIGV4dGVuc2lvbiBpZiBhIHN5c3RlbSBjYWxsIGlzIG1hZGUsIGJ1
dCB0aGUgcHJvY2Vzcw0KZ2V0dGluZyBraWxsZWQgd2lsbCBub3Qgd29yay4NCg0KVGhhbmtzLA0K
LVByYWthc2g=

