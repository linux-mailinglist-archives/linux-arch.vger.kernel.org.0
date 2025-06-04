Return-Path: <linux-arch+bounces-12213-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B125ACDF65
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 15:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B30163770
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 13:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B67628FFDE;
	Wed,  4 Jun 2025 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Udgc5+v5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bJ59+Pk3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D79B28FFC5;
	Wed,  4 Jun 2025 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749044363; cv=fail; b=DAHE8cQ7mMSzNvDgUXSgexyyu8TUW8YJ8xKcjP2K7ohdfcE7LJ9j6to6Sz2bFNYiVqW513CmB/AjHpyRnJvG/wObd9uftU0gHreCHvOd9/89WS3UvJHzz3vP5L5Bo3EeWGcF6OmS1K5XOIxeydjXr8WXa4F+eunyIl2EE1MfmbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749044363; c=relaxed/simple;
	bh=JUBFT2hB+wdbq3m67RusJWJN5y5/bwIx/x1qskpxsWc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S+LdOxoT8MPu0wrw6yfq7x3i4ks6xu8Pj9gQSIphD5Z5z2XNxuU1OnsqIiyLsRWcSgSZadcGfJJtEqEQUp6yukqnB/GNZWor8joRUT5tm88CMnTYxoZd9jxedoZ/zX3p8/Akrdx7kRJMAqIzqb3eTi5T4pVTlveaL9T1T9C4aCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Udgc5+v5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bJ59+Pk3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5549NdZl018925;
	Wed, 4 Jun 2025 13:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OS4nuiov2f1CwFLo2xG5JWFdEyt+CwxzpmSC1P4mv4E=; b=
	Udgc5+v5usQus1ow3t6RzBJvNzYMN6hNidANgOwMHfG9AksV2flH+6bylZn//WAC
	fLhGvDtEv4yeT+Em0H8VEqfgnaxaUAVqMCQPL+k8Py3DJAslV1KqhDWv+D13SfYh
	PRaZSBy971gxYpeNBF3gTag42cHBY/fBQkFvuIEDPkdLXbmIeAuvMMkKdDqw33og
	JcGHUeJjLnFzEYoRQnPtR2ra/uqQslZ2V8ZeVS2Y6t7HHfur9kAuVFrTDU4sdRcY
	Oif9apvY8vQcNaXDl05V8oyIlsfrl5YD0d29HME4BUQsi0sGe5dh3duwaPm5hMzb
	68SiG8tN1fN0CBE9taAxXw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gwhbuy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 13:38:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 554DOecG039244;
	Wed, 4 Jun 2025 13:38:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7at5e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 13:38:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAaYMD+QxJ3WXIpl4J1AuEZjXQJjHSNhFibpoOa3SAXq6jjEWIQp/iYRtt10yv7K47hp2CWVBnQqPfyhsVVzGhRKSNZTMUrXKMG8tyIMXwFe8aWHBONZthRgDgJT9ilFcS7MFNVlOsNis2iLd+nj/KYAVDYmG3VeSoo8Y2D/xUdSvPSlRw3m3sRznCHkRw89sZKwV5B/NqCPpu8XIMAYpwQdKSVKQtF0GtugVFSTMNwfjgmuCYok78gP2a+PFtBhAkxsN+KIQMwY69Gwk09tTvd7z7jgDggEPowEEhHtY5GDHBUBAmCY+mHQ1UWdVZW2EOQyw2CMIs+6kubmuXrvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS4nuiov2f1CwFLo2xG5JWFdEyt+CwxzpmSC1P4mv4E=;
 b=ZR1+6RnLf9sjtRu5qqh5tcGknSOh6PFfQEVj1yxQVjfsPcQ8qckto55NLLdd0kBikgbfWT/sM7AKh+0+vaX42e4s343KKzJVk/rZcxyleOsDw1lpxO2+HlDBROVXuDtec1eVvAsDR5h6bzp4Z26A214tfbsvAR1pFaR9u3hPssF8+ChELWIkxndDFb+/Z/D0y27UPmyOXLsPadyPMxk2bvQCy30Gd7E1lrCUbxbFS/adLiXl9+wuqZjyF+5wzHL4WfDCENMrGePjTAfp2ovoxZrT+1EVGZYiXX2MDBTpntDbQ1e37o/xfwuPWCbNGuuogcFRon4/zqLvDSwcbaJy2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS4nuiov2f1CwFLo2xG5JWFdEyt+CwxzpmSC1P4mv4E=;
 b=bJ59+Pk3SdY0iMNRl38oo49WA7SzukN5DSroNCngY1oYMF7E/k7aMEtI0K62MXeHdgXQxoLKA80fSAB85Zsuv3ndno/9GW7gccSaseOR9POm7BWiCNUNZH3Kkvz86lHyfT3Gz0MNw+PI9PDwPkfxm+TSfEqEq9/FD7vzwWfHaTg=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH7PR10MB6987.namprd10.prod.outlook.com (2603:10b6:510:27b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Wed, 4 Jun
 2025 13:38:44 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 13:38:44 +0000
Message-ID: <c495172a-e4a6-4098-bedf-ec43bf3ddd6d@oracle.com>
Date: Wed, 4 Jun 2025 19:08:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v3 04/15] arch/x86: mshyperv: Trap on access
 for some synthetic MSRs
To: Roman Kisel <romank@linux.microsoft.com>, arnd@arndb.de, bp@alien8.de,
        corbet@lwn.net, dave.hansen@linux.intel.com, decui@microsoft.com,
        haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
        mingo@redhat.com, mhklinux@outlook.com, tglx@linutronix.de,
        wei.liu@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
        sunilmut@microsoft.com
References: <20250604004341.7194-1-romank@linux.microsoft.com>
 <20250604004341.7194-5-romank@linux.microsoft.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250604004341.7194-5-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH7PR10MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a314be-ba50-4cd5-8f66-08dda36d2019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QllrQ29OdnJZVHArQ2dRT3hwUHhPT1J5SXZIS1FwVzY2V3hLS2FUSVlqU2Rr?=
 =?utf-8?B?dng2ZzlGLzIrUVQ4WEVNaDZwK1JObytwR0JiR0pwN1p0K3dwb2tmeSttakVz?=
 =?utf-8?B?Vjl0d0NBZkNmaUxvQldBaHlBQlF6Y1RuSkJqU2JxUlk5YmNOTmNNT3FrQXRT?=
 =?utf-8?B?ZVFiQ1JQdGZNUlR4OER2OWZ1R25KVmNZMHBlWUFWQjNWQWQ3RWZBSDFITUs2?=
 =?utf-8?B?eERsLzhwMDhaY1JmbGYwSWlNU1ZmYnFLcXliQ1pmTTg0UVRPak1tUnAvZWZX?=
 =?utf-8?B?Y0xISWtVZnRHY001OXJVaWVxTnE5SGxydGJHNjJQSTd1eVlIaGE5VERua0kv?=
 =?utf-8?B?WTBjUmxpTVU4cGxod25mRXFIcDZMbU4wSUxMSGxwcVhoU2tyV0hxRjZyRm5J?=
 =?utf-8?B?MmxaZElDbVJ2TFFmUmltbE9IbUNCbHA3SThaaUNYNTNNaUJlTGhsdWhIR1B4?=
 =?utf-8?B?NHdTeHdJYWM3MjJsT0drV3ZFMC95LzNibUE4TGFTdHcrbVpWTC9aOVg3OFJY?=
 =?utf-8?B?Ly9NL1dUYmFsL1RSMkErdFB4MFgrUHE1Q2RWQ1pBMGRiUDByelZMWC9aWEli?=
 =?utf-8?B?K0tneXVpanQrS1FLenhkSUZBRzUrT0dXUitLbzFIZFArZlM5R3dIVXY4UEY3?=
 =?utf-8?B?RXB6RnZtMHBwVGZ6L2YrdnhSZ0g3aTlEVkNtRWN5REQxMXZOM2NuSHovdGZt?=
 =?utf-8?B?cEwrZElYSlVQaW1KUnRnWVhhVzdONmUycGdleEVNbWJ6M3krRmVTM0NUOFBO?=
 =?utf-8?B?cDZOVTdBTWZHOWlFeTFmeFlRd3BsUFlWclJMdHVWUVhrSEZ3SVVPcFFVKzJ3?=
 =?utf-8?B?SVMvcElwYVhhWG4xc0RGWExmeWNkNk5zNWJiSTdCV1NYMDVrd090aGxTaVg1?=
 =?utf-8?B?STBORkVwUWRidlh0MFhtTm5DUFRTTmlFY3AzNHFmYkRNRVRxVzBhVG1HUmJs?=
 =?utf-8?B?WS9RM2JvSTU4R1JHZWgrUCtNb3BRVFRKTDNDRThvZGx2U1J6TEUrVi8zcnNo?=
 =?utf-8?B?cW9PMy9SUklCMDdtUVVsWkUzYjJScFZwMGhyektLNENTOG00b3YyQUdTdUtD?=
 =?utf-8?B?d1ZucjZybk5aSWpYQ2p0ZlVzK1FlMUpsUW5WczdNdUUzOStFTytmOFVmT2RN?=
 =?utf-8?B?UEw4VkRyR3YvZFViMVNMcFo2Y1p0NEdVQkw1VEdKd2kvV28rdWVmUElnbHdL?=
 =?utf-8?B?aHZZRzFRWUZpYTgxeDdLL0k0TVJ5Unh1RGVmUHZFRVhHUEthYmpMcTQyN2J4?=
 =?utf-8?B?MHdCWHJvT1RyNFZjTTlJSWZGUW92ckhFc2lESW9MWmlUMXZ1ZFgvSVRkMXhS?=
 =?utf-8?B?dFpqZnFlNmF5OXhnSXhRdVAzbEE1dlRVZ2t2a2MrTVhmZkhLem14SzlybjNN?=
 =?utf-8?B?NVQzTTB2YzlnZ2JBVmJNMkkrS3NXMm5YZGlObThabHRiME9aaGl4Yk5mcUly?=
 =?utf-8?B?UlcxNmloRnZVTGZIQlpiZWs4T3k2bDlxRUtnS0hPTnh4VEQxQS9nWWtQeHlk?=
 =?utf-8?B?am5jQk5FWHFrSWtYbzExWTdvVGVSRmJzcDFLQkJtcFUrZkE4YmZnQTBrdXZp?=
 =?utf-8?B?NElLTlp5MjZPdDRubkFZYzhZMGUxUnVFZ3R5MzFURnVNMDZxdnJpdXd3QmVj?=
 =?utf-8?B?UjJXQ1RRYzFKUXRYdEFHREt6ay9ubUdOS3h2aW93Z1hUMGFOWFMzUkdxY0xE?=
 =?utf-8?B?dnFJeG8rdXRPVXgrRVRMd3E2dEF2eGgxaEVENUJJclp4dVB0dGNuMmg5Y2lv?=
 =?utf-8?B?Uys0SWVqMTRZbTYvV280SWxNdko1eVd3VE5US09WK0FVWkJDMjFzbG8vZXZq?=
 =?utf-8?B?ZXBjVWVMZGRXRHVEZ3RkeHU0MU9ZNGhXejZVNW9VcVZKTmdwZTFrMGZEcUg1?=
 =?utf-8?B?WTBFWXBYWDhYUm91dXArcjJ1YXpNTk1nRWhMMVhkbG5DcGdLR3lZZVIwK0dE?=
 =?utf-8?B?Z0FIc0ttMGFmNDdCUTEyalBUYUlvYzE2a1Y1dUowb21HU2pFdFdFM29LUmYv?=
 =?utf-8?B?NlVWcTh4UXhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVo4WFhmZGhHdEJvWHZZbjA3MDRpOTBvaDgxNlh5UlcxU1VTVTVEenduYVhF?=
 =?utf-8?B?ZkFhczB0NlVaWXpoQ2dianMxU1NsOUpFalpMRGZPUlVBYUFsdE5vaW1Bc0VR?=
 =?utf-8?B?K3dmR2ZVNG5GNU53bHJXOU5vcmZya1k5ZDMxM2x2Y2orb2Q2WHYyTnJPbXFX?=
 =?utf-8?B?N2tVc3U0d0Z6bUdHZDlSZjdNRDhLdkpFRjRYK0JSQm9GQ3JmMFVSZmg2RTBm?=
 =?utf-8?B?U01kbk1TWDltK0R2RE5wTG1EWmgvWlpRVi9PYVRqeTFVMnBMa2dVL0FQOFFq?=
 =?utf-8?B?MHpEcEZkblhTQnppT1kwNlJpNWVJUTdQc2VlbHJyRWoxUnpnbWpPa1BIRk5i?=
 =?utf-8?B?eXlZeHdicUQ4RmIyamRUTVVzSnNRSFYrRmNieW5JVW4xRDNmc2RZYUtydFdK?=
 =?utf-8?B?MTZrY1NEZFFIWlU5U25aMW9vcVNPSHFIMzN5SXExcUhVVkhMS1gvTlYvbDVp?=
 =?utf-8?B?bkVjWWY4bU5yYVVzdXZZR3dLVmhEOHRZL0dOMXNEMC9DWGFFQjIvMkhvMzhZ?=
 =?utf-8?B?c1BWNlp2c0RiOTZ6ZThBTDl3WjhPaEV1NmY5eHN1UFZOcGVZOFdmb01UdUVJ?=
 =?utf-8?B?NHdGUTdNVkoyWjVXMEJsWEFzaktmWWx2RWpGMWVMTmVDQnlLUWV6ZEt0ZXE2?=
 =?utf-8?B?WlROK0xjOXJtMEFDZVE5L0RWVSsyMmRZcThjNW9IaEdYOTQ0Uy9GcDF4ckF1?=
 =?utf-8?B?MUhLYS8ycmF6cE9QRUh1WWhCSEU5QlVETjRjeU1vd0lHb25BREV3bndpZUFv?=
 =?utf-8?B?VG1rVEx4TitldUZRQUJnVHhra2I4TjhTOUQ2THFhTUc1TnA3ZXNIQ3RhcFpp?=
 =?utf-8?B?ZGJ4RklLVStURDYxVlorZTRIVEhnT2EySG5XRlltMXB6SFllblRvYUlGSlB6?=
 =?utf-8?B?NXdpaytWY00yRHdzbS9lSEQwTXZ5M2lBc3NqbXNlZklPYU9nSkxGRmJLMi85?=
 =?utf-8?B?Ris1RVVndnR5ei9ML2hHSnMzNitKbWg2akZzMHRDYjVad3RKTVFidEEwUFQ4?=
 =?utf-8?B?c0dMTmVlMFBlOGY4T3dVZVNWNElONjc4Tk81WEVYYnUyVzR5L2pKNEd0ejFi?=
 =?utf-8?B?eHlXeGtDSGpvc0dLZEtmVk43ZjZBWSsxeVM2Zk41M3BQYzVTSXlPQ1dHalQ5?=
 =?utf-8?B?UUJuVHlZejhiSUhJSXh5MEs3Y0pGbStlRjE3bi9CZmdldG40T0NiL2taUVhN?=
 =?utf-8?B?UFc3bHU4c2JEc0VZb3NvK1Rya01ncWQ0UVcweGFyZjhsWHdTNG4rYmtadGpG?=
 =?utf-8?B?L1p6M0c0eHFiRDNkMFYrYU0yYkVENlBBQm1yWk1jQ1lLVUFZNFRvT2Rnbk1n?=
 =?utf-8?B?N1licVVxdTlUaDhHbVozMzhuNHZYOThJeTF4SUlPeHRXVWlMY1RDOUdyTHVx?=
 =?utf-8?B?TFFOcElDV0RvU3Nzdnc4NU5NUUc5TVMxWG1uZlA4dVJURm4vSTI5dVdCVFpQ?=
 =?utf-8?B?aFA3ZCtIeXl2d1dyK2NpdE9vNHhzZFNabS96QjYyYmRkOTJzVG1kbDlDS2Q4?=
 =?utf-8?B?VDZHNGhWVVlGc21OZzFrN2JOM2p0WUovQjdFczFwWmZtWlF4NVFiUitlc0xI?=
 =?utf-8?B?M1ZtR2MzRHBVelMreXZRTi9rb0xYcVFiWHRQcjBFT1RhWVdQb0xMMHFTOE91?=
 =?utf-8?B?d2VsQSsvdzNRL1FJTG5Tb05PUFpwcFhLeHVuSzU1UXZGMS83dElnbWlYRXhU?=
 =?utf-8?B?RmtzcEtCQ3JYSzF2UVFLUlA5Y3dRUUNHWUhodjVVb2JOQVVHb1dhZURtUmVH?=
 =?utf-8?B?MFhvNzNyOWhVWDczNU1TYnFYQnd3T0RqbnlGcXBkM1dwSTh0b0NjUVFLYXhk?=
 =?utf-8?B?KzlIOThRUlNBZ3QyOGJHbUFpbHhRZHZ6cnRPZDYzWFRNS0FUckppWTc5OVpJ?=
 =?utf-8?B?all3bVBsRU52aGt0ZjlyTS9SbFNmeXhUZ1JBQWViMVFINVFqdm9iZys1Vy9Q?=
 =?utf-8?B?elpkV002cFFhTFA3MEo5L01zVG5ZVWl5am1NV0Q3by94YUpZc1V6RWF5Y01V?=
 =?utf-8?B?MjBGZmFTcEprZFRzK0JZQzFoWFRJamxCbUszYXg0NDhXQXFaS0l4ZFFScWUx?=
 =?utf-8?B?VHdUN3pqQnhJQktvTm9OZG5KKzBFUnZtWnRkOW5mWktlSk9SZWN1MlpFNVAw?=
 =?utf-8?B?R2pBMGpMWUJSM1RjREVLQzFxWHlBU1duSExTVzFrRVdsWUVybXhJMEtOTitC?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ktLFO+t4BJ9OWr77l1eETXp6Rw9DUonTPvMMOZl6Mdyz0W9og/X3ZJtdGDmdqJ1GrTpDMKIjHv6sRAommaS+5XYuI5ktGnww2MisFj4l+LKymt3DYQD7P1bUs4Sb6Jx5+kAoUq+daBeYB0UjHL7J+Gef0tvELPA50U46qS4nZO7iviXWS+7WDEwTC2fKEkBswDVfcw/8KQ/TJELdcMx1TqyCXc4glNn++iwDHjKb1oISWp81OZkbDVj+jvdXppbPZUt6afe4cd6Hk8uPrenSKAaEpm0cbd9z7C6s9CxRdzsZR5EQxuUJzcXIZQfSHYuvV64UxcXYB1ZEGrsnHJ/dr+KsjtqXf3P4C1iPaMAva7+mjVjWAzC+kvXjhy+rHOE3tErCpaEBAte7hdHsV0fwYfzrD576nmaNULyM7buRor1WjrdaVx/0o4BrkAYBCDv/KbucDxr0J+esnF+FfO8Jr3LsJKf4h/NCT3hdvE+Z5ToihvFrNBfobFImXLS4V8HCkP1XEYVu1EGxz75V79AlHxLg2b8pWYMBxmKtWI6ZWSN3/m0PGr7cfW17YU8rdrcmdhqppMbUh8xaQiHTlFyt+iiNVy/Azh33j3USZVV9i7E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a314be-ba50-4cd5-8f66-08dda36d2019
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 13:38:44.5514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3s5sqMFjhbLPmBFmdl//Qu2cqr4TazxZKH8FXafBRZP5QivpLuKqBJhkF02ukzHZ5jP5efjtEDTWT5VUU2M2V5M8wg5JKrHnmmGt/WnJih0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6987
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506040104
X-Authority-Analysis: v=2.4 cv=Wu0rMcfv c=1 sm=1 tr=0 ts=68404c69 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=Nim5RqO9NaB9tkb52p0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 71OSz3VO4KeedtL3aLasBToZXJ0IvsIe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEwNCBTYWx0ZWRfXwKgRSwg7jeBF VvaZQdiQ2soOdudcglpc98vxLUGhFL0gVcebFQTEVw46aCCTiAnoIr+qFeHVkcGUeeJATZUcM1V BT6pFD02wZbXCGht1IhHeqTri7WpRKIV+JK9E0WTL+95mAOb5VBpAdTeQck2+HenPe6fib7SOba
 PMh8LF60pHe0ZOlrlcbess7mt+6tL9eIFNZgJ80COUxqpL09xW2KLd/UlbocfS0DXkxQaO0Mnj/ iUeX6eVcRz+Bmc3hLQXLPVE1Jd1VxOC23gthAF+B1Gl3clz2vKClYX4h2gPOEazVCo3qn8YL8SA evrW1fRTZKQF8QTqbwY/dcF8XnXQYsKU7NQEBu+6WB93rqmWPAhwjCNfP8ImmdyBW4RW7U0xUi0
 wptnSnaaN7Wf8KSNWaSLLP4VShyYKAk/XkC716x8/Wj6B2+dwPmaPAdUtTsR4NxVwY9cxyHH
X-Proofpoint-ORIG-GUID: 71OSz3VO4KeedtL3aLasBToZXJ0IvsIe



On 04-06-2025 06:13, Roman Kisel wrote:
> +			/*
> +			 * Write proxy bit in the case of non-confidential VMBus.
> +			 * Using wrmsl instruction so the following goes to the paravisor.

wrmsl -> wrmsrl

> +			 */
> +			u32 proxy = vmbus_is_confidential() ? 0 : 1;
> +
> +			value |= (proxy << 20);
> +			native_wrmsrl(reg, value);
> +		}
>   	} else {


Thanks,
Alok

