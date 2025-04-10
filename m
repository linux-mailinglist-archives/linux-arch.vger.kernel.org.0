Return-Path: <linux-arch+bounces-11381-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7337CA84A88
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 18:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 760277AFE3D
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 16:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FD61EF376;
	Thu, 10 Apr 2025 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mb1I+cWD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xiCoTNEB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C5C1EE7DA;
	Thu, 10 Apr 2025 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304169; cv=fail; b=lsMATcRMSf9QEOSk43/6bQIL7RTdXLXV0Dwf/9wMdw4nf82DY562OGzSHv6/9pNM2ZapS0iM22oVV95JIXaygApDIiHqBsY4fPVbwtu3BhyHRjmhVKxkrPpqhcMpouEsIUNS19/SZsFGmopMa+Dvod7olDbeffs0+jBlu+brwEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304169; c=relaxed/simple;
	bh=UvR7o6JCHET1vHRuUmgziq1qjws2f3imjiuX0KYEAPI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N5OaLqV0W4qfBqVQlppoo7fqv3mibHgvmJzH48wvTB9hJs1V5UbkOlCdghbXfBaT3R1dZ4eIW1eNyqDcSC2uEzGxcKruTSUbyqpVp0mq9b2IXU1Uf61T8SMQ4pX5YVi68aDyJ08MzMHqcJIV+MXb8FQSRRwDKizH8eyWDL9iBR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mb1I+cWD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xiCoTNEB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AGg2iK022453;
	Thu, 10 Apr 2025 16:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=L/7hsLoyrS2fuFVWbZz7yPhxc4tdyanyC90fWp6729A=; b=
	mb1I+cWDv3RwG5Pp2lwMQ3a2RoWvZ9mvgPeyEYxqESMqoPzOlOr+Yawso0WMY8G3
	t5e9mlOjh1AwEV3IBR7g5Ss545gy31z6BXCBQT1/qYZ3kgCyC3NRIjF02j9kZcTe
	h3QDiXsf4nU3Abmm9TocpNUjJnZq9Ve50HtiEMC/WNs7Ca7vwv6TQWynGIBgkwoP
	KzvBZnO54n+qnQ/VTPQ8Ylm/Kslue463JUfMDGLryVdWuLYfvXTIMw7ucrBPvNkm
	UGo3xyd6/EeNUk2zwknaFk+yTQHCiwZfxIg0YDYJ5mZJZjp2vB7ucSGW+c8Tbo3K
	Twwc3gisF1WbWBjiw/6Y/Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xhr28110-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 16:55:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53AGP66D022146;
	Thu, 10 Apr 2025 16:55:13 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010003.outbound.protection.outlook.com [40.93.11.3])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyd89vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 16:55:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITD3hj7dv3pQ6EYoKmR6p/m6vu90wNdDcSo2+8RtLLNfQTKbVxYHnUt/TfiS7qfsB4IJDUE+hgmqLBEJO10kiPbKj4KMgQx6JgCx2B9udMQP3567ai/ZKv6eagMjfR8QK0lwF83paOcZF+c8/0fe+Jnat1kKTnobeHQlaaHdBqbrTVhqt9+cZLP9Opq5QvhVB9jKzrzR3zQ3UyV27Kx7OcefUW8ycp1Nh+vz/corpCKKZKhqNxYHJUBnEdy6CqaC6zY1ORnJMGt4LLLkBxA57YRlFG1ChloSZ1P0JK9DbboL5x83ZdkG7nRMXF1Ts/AfqBO4n6z3J089VRPh8hPDUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/7hsLoyrS2fuFVWbZz7yPhxc4tdyanyC90fWp6729A=;
 b=rbPU9oUq6b6JZWzPzxLhS4CDf/nHB6euU4vfjt3dbDcQwHdp7kokjSk5oY7St8tuLOIUCPq3Jp9xej6/p7qPHfiq+9BzDg7GllK0b+vzfdJoz8am4yaPIRdMtYL+Cb67AAcDCKT/O33zp46ASzxS8Vfw8FTgUPv74Kj3eIVcNJEbWkt2SB6D8oIS2LyCtP70C2emUaFPKm1MSqFuBRTqethMSdF1cqgg9s7G38TboIIMPiMHW8vsOnZuwr0DwUhCjom+LGKQM8tMHwSdbOQ8Z+ED96LnCKobBRqGutIkYXMTTlTknS8dHU1Sh4cW4lnVkGF+YEyOqYwoxzYDPTR8Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/7hsLoyrS2fuFVWbZz7yPhxc4tdyanyC90fWp6729A=;
 b=xiCoTNEBH2jWuopKO/cx1cxetGKJXpBzHhkf3n9q8TDTfftGo2Q2JVaAQjBK2z93kHTW8D0E21JNqE+1W7G5k9Dqhh1/82tVWK1wYnrFB+W6351noDDTEHfkjd7CnUX0ZyodLtEWnfplbHO1zvvdX5fHAJEYaUti/8bNUXylUuU=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CY8PR10MB6755.namprd10.prod.outlook.com (2603:10b6:930:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 16:55:10 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 16:55:10 +0000
Message-ID: <724f9f7d-137b-4cf5-aff5-bbb9727c23c1@oracle.com>
Date: Thu, 10 Apr 2025 22:24:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next 1/6] Documentation: hyperv: Confidential VMBus
To: Roman Kisel <romank@linux.microsoft.com>, aleksander.lobakin@intel.com,
        andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        catalin.marinas@arm.com, corbet@lwn.net, dakr@kernel.org,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        decui@microsoft.com, gregkh@linuxfoundation.org,
        haiyangz@microsoft.com, hch@lst.de, hpa@zytor.com,
        James.Bottomley@HansenPartnership.com, Jonathan.Cameron@huawei.com,
        kys@microsoft.com, leon@kernel.org, lukas@wunner.de, luto@kernel.org,
        m.szyprowski@samsung.com, martin.petersen@oracle.com, mingo@redhat.com,
        peterz@infradead.org, quic_zijuhu@quicinc.com, robin.murphy@arm.com,
        tglx@linutronix.de, wei.liu@kernel.org, will@kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
        sunilmut@microsoft.com
References: <20250409000835.285105-1-romank@linux.microsoft.com>
 <20250409000835.285105-2-romank@linux.microsoft.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250409000835.285105-2-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::19) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CY8PR10MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da2bde6-97d3-4d04-6c72-08dd78507438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXhsTnU4ZTNHdGxmVUEwTjZPdjJwTW91dkJuQTNDRmdLeHJTR0p4aUZUSVdz?=
 =?utf-8?B?TXZNMFAzbkpxSVIvSGViVW1jMHdLQ0hQVHdSTVQrNTBFTVpKMkRSNjJEZDNH?=
 =?utf-8?B?TmwvOG95U1Bhd01JTkhaVlBLRDMvWUVOWkVnc1FEYmtaK0pubkJLV0RzejAw?=
 =?utf-8?B?cFNTSmVkNHlSeUdQeE5UODVXNUFDQlZsbEVEakI5ZE9SMlB3OVFtQ0w4RFhq?=
 =?utf-8?B?bjRqM2toOUUvZDJjVDVtaDRFdTcxejVMNGM0MlRRNmdUQUxSWVVNckovRDhl?=
 =?utf-8?B?UmovVHorQkMxeTJvTE51VmNQL2MyNFVmK1dnNjNuc0pUNkRUTjlJSDNHbTdu?=
 =?utf-8?B?eU1qYnQvbEFGaHZGbkIwWXFabG1ldVJxMEk1b3JaRmNLVFdtejU0U04wdGQv?=
 =?utf-8?B?aEd6L3lScWdrUGJSaFM5d2haeUFiSDdtb2FqSElmVU1SSzdudk81VnMwSHdi?=
 =?utf-8?B?S1hYVGE5TDBBWDBHMzh5MEVDNFVzcEJzQS9yYURuL3RJODJBcXVlQWtpUjRH?=
 =?utf-8?B?NGlwNWVNNU9SbVFNRnJZbWZDdTI1Nm43SE93a1U2TG5idWdRUVF4MjRHMjUr?=
 =?utf-8?B?OEZXd1M3L1I5eGE5UFFtdG4vOXNXeVJYTjk1Um5NQ2pKWUNlSXZ6RUYwb1VX?=
 =?utf-8?B?cVdoamdKZGVrb2VscDI5b3c4QTRtdlVZQ240SFV6Q1BCMUl0dGxJVmc0SDlK?=
 =?utf-8?B?SUNXRlcyNWlwNHhzMUxlZVcwQ2dOazErYnIrZGZGdTEvSUVDQjdDMXZxNjdp?=
 =?utf-8?B?MDJUZkVsVWFVcXJ1MElnNWp0MjZ1VFVnZ1kzUjVMdW9LMS9vU2hpOUJpb0Jw?=
 =?utf-8?B?bzZpVkhoQjJmYm9tT3FwdUpPRWN3SHJIc0NPMHN2Tlo5K3pMRTdOck9Ka0Rq?=
 =?utf-8?B?NEJBMkU5d1kyYmxpN01YTDkxNjhlZXlWdWZlV0ZaTUNMT2tvT2pLTG1IWStD?=
 =?utf-8?B?NUQwdzY3STBmc1RVNk9NSjFtVWxCRnRERTJYRzZjeXFsM1c0Q0RSdmt6NE5k?=
 =?utf-8?B?R0x5ZjlncmR1T25NRktRMDJNcjMreHBpUEppZWphbmZ0aWJUZWVPY1MvSkRH?=
 =?utf-8?B?RUQxRGswaTZjcStsSXhhTUIyRFh5UDcvbzRtdUZxMXRQcUlZQSt0RTBFaUF5?=
 =?utf-8?B?bUFhTmZzYkt3ZHRiOFdKTmovbGZGZHEvVXBiSTNIZHlQbGVQbmt4TlVZNlY0?=
 =?utf-8?B?UzFrcXpBMC9DNDZ6Z3JLUWZXU3hWZ3pRK0JITjUyS3hvMHRUOVdjTHRkUDg4?=
 =?utf-8?B?T2M2aklNdEdXR3NaMDluMmZIQ3d4MjBOSzcwaFY3WXFjMktHQWt3RzVNb0s5?=
 =?utf-8?B?UWZCNWFhQXRJeFpYMlNhZFk1bWhpWGNtNnc5WlRzK0lrem5Ddmw4MUlOZ3dt?=
 =?utf-8?B?b3k1Y2Q5TnYxdGdvRFpKMTBZb2t6T3JsZ0U5Wm8rS1Mzd3hPdHk0Y0E3Q1Ey?=
 =?utf-8?B?bVRuK0FFTFZJR1pjNW5yUDJoYnBGZXBJYWZXVGhGL1djVTRFWWt3UldxZ0t3?=
 =?utf-8?B?QkhiazIyNFFxTS9laUk5UkZTTk5nR2tEWkdyRTlWUTVtVjAyWnpra1Q1VnFP?=
 =?utf-8?B?Z2ZmcWlteUNLbmZvKzQxTUVGSmVhQzhncFFSK2QvMjhBYjFYTWdzaGw3dDcz?=
 =?utf-8?B?dFAvT2xuUnFkY0ZkR3JYN1I5TkNEVHVXcjA5NGFLUmc3ckg2S1lKTWRBQmxX?=
 =?utf-8?B?akRHdkJmTGZiUk1iOXc4d0s2VHcwMjVmZnJsakZHanFrejlINitEUHhjRUdO?=
 =?utf-8?B?c2xocG5hOXNYMTFYNHFIWnNxd2xLK3o5Q244TlRsV0pvUitvLytGbldtTmhR?=
 =?utf-8?B?VHlDRVlDSW8zb25VZU1iSFhDWjdjRzVjQS91ek1GV05Wa092SHJCTjlpbDFv?=
 =?utf-8?B?Q1VDSThwNHdrbm5oVWFmaGNuVGk4eG5oTllQemtka0dLQkpadThuY1h1U0tI?=
 =?utf-8?Q?ctguLZSNWg4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnFxRUtQNWJIZ01SQmFVNWxvbWE2VDhNU3VCWU4vVnZZcXZmeFlZUGNHRlpJ?=
 =?utf-8?B?alJNVzQrMjZ0bTBPOVBpK21STTNFUjg3cjl4b2VqTG16eTJ6RFJVZUU1Q04w?=
 =?utf-8?B?VmxpZ1UvZTBWQjgxV1N5ZTJHdHJCRytoaTJsc2lsUzEvNWYzUUZsOGY1MDBR?=
 =?utf-8?B?UVpLWEROUUc0SVUvTWhEV2d5U3FjSmxxVVdvSk5WZTNDSEFnTElaeXpiVlcx?=
 =?utf-8?B?L2FhdmJvZklFUkgvSEUrcE9ZcmV0N1BrTGxEOWJsNHBaNThWMGFlMzVjSmpQ?=
 =?utf-8?B?TWxvbU9JWWtVL011Y0hIT0MxYlRVSURoUHhCS2RkNElzVy9ycCtWa1ZMNEpP?=
 =?utf-8?B?TWVtZjduTUxObzBhWVhRVXJhVmVSUzJZT0JtZDFXR3N3TVRsRm1UYjBWNVhP?=
 =?utf-8?B?YkpEWldlQnJvOUY3NElJWGxFd09Eb0NTV0FGOFkxbUlFUXUzQXVNRW1zd09s?=
 =?utf-8?B?QTUwdUw1TGsrK1Fwc3V4MTd3RFlrMisvS3ZaSWlVMUZNSHYydFZleFBHeCtK?=
 =?utf-8?B?eENEK01nR1F4b25OZ1ZYVTNrRlN5ZDVVVXlFQStCS3NFeHlkK1lzVlZmL09v?=
 =?utf-8?B?N2hPVmg5V0dNVWJJa3VLc0kycFhJL0RScEZKWG9BUlRON2RUTzF1dy9Lc1BT?=
 =?utf-8?B?Qk5Bb0Z5RCtEc2czU0Z3Y2dOZHR6YTlLbGVEZ094MnlkSlhnenJvRWswZHpl?=
 =?utf-8?B?N2pNdzVQT2MwWFNUUjlEanVaT2pUY1RUOFBRUWRmcWFwMC9NUDFqUGVPK1Jo?=
 =?utf-8?B?Rk91NDlXQTlrQ3EzTTU5em12UEd0RE94d2RHTG9WNjE3OU44dUNGMjB1alN4?=
 =?utf-8?B?Z1UzSldkMXBiV0xQaVd5UWZUaW41TjhCU280LzVaNGRQUnVPSFpYVUtnd0VV?=
 =?utf-8?B?ZVRzSUZoRlJjTXdzVWw2VVpxQUwrQndwM0lGeE9XYUkwcHE4aHlEZnFQbDdM?=
 =?utf-8?B?RHFvenIvODBxVEVyMFJDRStBcXFyZWFlUitiOGlxeEdmYU0zaEJsdVc3b21B?=
 =?utf-8?B?clUxYVFITjR0ZTRXa0JBMytIVjdJa0JhRzM0UVNPMDhjUEtaYlRCREZneDJm?=
 =?utf-8?B?RG1KUzBsd0prdkNaUWV1cWptbkFiSi96OWZRMFJmaDF0M2hnRlFJa3lIRWYz?=
 =?utf-8?B?cHBPVkZDSkx2WEdLc0c5MHJ6M0JOczJlbXRhbUtlYnJDb3hpUU5HVFVQdFM5?=
 =?utf-8?B?RDNUSHpWSmpqY2FGRzZhaXM2OW9aRTRieCtoY1NUY1d3MlNDNnlUMmdpNG1E?=
 =?utf-8?B?STYydUM1N1J1VUpIMldzZ25kM3JYTVJxUXIwaXlqWDhMcE1tQWMxbndKeHJq?=
 =?utf-8?B?a3BGTDdVcGo1Y05EVnNzMjV1UHlWUXNjOFJHWm1GSzhQMmVNTlF6SzVHb0FL?=
 =?utf-8?B?SEUxMWxTVE50NGxJLzcwNUplek5XYjY5Rmo4d1kyWkdMRHJJeElVbjE4L3Rx?=
 =?utf-8?B?K2trT05rbjkvZjdDYnlzbUtqN2VNMjU2QXV4ZUJMb2FmS08vRVREeEpmenY0?=
 =?utf-8?B?NXFNZm1iS0g0L08yTVVjdkUrUHhQZWRqaWY2NGFwZ3p6WjFoOThKTTJKVXd2?=
 =?utf-8?B?bnlRek9rSlRJNmorbEJKbWdxRGJRNFJpYjM2ZDlGUEpaTDYyeDkvZ2JUSDFW?=
 =?utf-8?B?c01uSGxwWHJQT3RrQW5sanE2a2tvRk4yZEdKYUxHMlFYNnZVOVNueTNmYSs0?=
 =?utf-8?B?R3cwaGZJVTFkMFFpYkJxQ2dEaXBNNG1DTUUzU1p6dVZNa3NIUEo0c1hHamxF?=
 =?utf-8?B?L2tmSVVmZ2RYMTJIZUJaVWEvbDJmMU9BY0hrQjk2MjZkYjZET0ZDd3lEcWpU?=
 =?utf-8?B?Y096SFM2ME9VeEVTRmtLRjZlT3FBOHpIYlVHdU5mVFpZczJvWU1Idk9qM05T?=
 =?utf-8?B?OVRRTzRhR2JnaDdWVldrUmdYUlV4NUV5RnZLU01TeUFvYnNMRlJPOUc0MElN?=
 =?utf-8?B?MFhoZE83UEhKUXRxYnBtYzZmVUt5U3E1Ujd2OEZURE02VlJDYm0zNGxGT0J5?=
 =?utf-8?B?V3ErMGtkOUM3enpBcnZmUjBmK051K0RPd0V3aDJ1YndhcWlVYmorU3lqWGJ4?=
 =?utf-8?B?VzZJRFdRY3RzNk1lZUlTU3NOY25WRHdlZkxTdFR1YXVDN0FReEsyaGxwOUFu?=
 =?utf-8?B?bi9MNmx6TXk0YkVYQTd2cUIzK2R2VVBNcUlneFU2eVlXMW9xcGdIOE9ZM3ho?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jbXmEnSIhfCaO+5dOKP74/1AtP5xdeEXxZvsiK/xEXXggsvKXDqNYO3WVMVe+xpNmrtNbYZm6CHzQjNy0qWSCdU6rVWyIBqqNtYUHBfFH/M13XeOwrn1F2iCL05dzEfoXdit+kfsTS5JdYckjF72aRKTWxXeqU5MrQtOJdwLSFXfea40CSzWxtSdBBmKU/62J3lUP00dCYeCi3ex5fi4O2Rsd3j1FGzyR+TaTohN/hpQQ1bZLi6ASkfH8lVWW3zBLmjvqr/a3fLDMl6UxDIJzqgBfBGmcZB9MR2as/frrBc1KmLVS6X72AuI2EqnJohVTAYFwXKTjrP5lv2jh7JpFyoljYIJAMphMu+QdP3rh6ZfInnP2O639DlKRLnVAIRlTI+VGMeEPoN55sPMctEuHWn22zgPJX3UCOtfvnXQZ7M7MZ/Vol0Hq7qjWJiWDp8cUExPb8NEVJrMtThBAuG8aE6B3MIq42JnTl+i7PvgnolzG1Cw6CB4OemPwbElZDHEGL7DDaYXo9NDz3wL8QlJ+5nnIIIWxfBiAQs8tgiQK6DRcAaUIcV7glikuGCSyb0Qb0UAYpwZH3T8UqpnL7Fu8qS/zekzxME9Lea0vGhBbc8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da2bde6-97d3-4d04-6c72-08dd78507438
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 16:55:10.2997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NVEu123s+9Lbj7nX7rYpESL/4rPcLjDizFCcLRGboeMzKAoMEpI/+RdVao7RNkTqMYgMWTOkfpIzCcoiyx+EGWPTkYf311AzUyH6a4zzkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=991
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504100122
X-Proofpoint-ORIG-GUID: r2sqD9jXbLbHEZvRY_N21qLb4ZyU16L9
X-Proofpoint-GUID: r2sqD9jXbLbHEZvRY_N21qLb4ZyU16L9



On 09-04-2025 05:38, Roman Kisel wrote:
>   in which case it is treated as an entirely new device. See
>   vmbus_onoffer_rescind().
> +
> +Confidential VMBus
> +------------------
> +
> +The confidential VMBus provides the control and data planes where
> +the guest doesn't talk to either the hypervisor or the host. Instead,
> +it relies on the trusted paravisor. The hardware (SNP or TDX) encrypts
> +the guest memory and the register state also measuring the paravisor
> +image via using the platform security processor to ensure trsuted and
> +confidential computing.
> +

typo trsuted  -> trusted

> +To support confidential communication with the paravisor, a VmBus client
> +will first attempt to use regular, non-isolated mechanisms for communication.
> +To do this, it must:


Thanks,
Alok

