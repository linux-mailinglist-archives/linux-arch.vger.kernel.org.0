Return-Path: <linux-arch+bounces-8847-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306FF9BC299
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2024 02:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA021C21631
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2024 01:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88001CD02;
	Tue,  5 Nov 2024 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dHJB/fNk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rqwZKjrC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFDDA94A;
	Tue,  5 Nov 2024 01:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730770461; cv=fail; b=jWaqgiZamlSZga3hNsAYHMWrdV8roZHk8bkLkeUivCt4QW+PctFKTmZQmn8mlYA2qcsTOCaPiL4Qd0Se+DcKvnkN1bgCGhLPIGd7bnFHFW/RHsWWyUzrnWieSRSOrZFzYNPpXHqLYjBI/r0WSksM14XfZq0Blokj+dWvfgrjVsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730770461; c=relaxed/simple;
	bh=Kq+/AQFH39rrJY9ezj2wRY8L4a7LXTBxsZ985XNHysQ=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=fa3psEuniMCc9r4g1pOYftNOp7Fd2m1u8cwTnDynGjxDcmAWgjUT1tmQnUjVbkGSmwiweT0alVCADbAkzVttANeaHfXgrVzEiXBBXP+ce6/+Bid2oNE7qVHFqJ08cEknt99s6EerwW51M/JM6bEVAYZOy6ubhX6VBQtPcybPNRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dHJB/fNk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rqwZKjrC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A50fZfJ023927;
	Tue, 5 Nov 2024 01:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=7IB8CNdfnFOF4TldQu
	t5IiwiWExW0itzIaBYWtKlLvk=; b=dHJB/fNkW7WQ7Bdqd1XxWyj3sPuIV/2cEv
	0+JuwLTqIoDE3HwFeIR6snYsInpUpERifTLCVdDeZeLGGkV8TuAd26PPE4p1LvaS
	g9UEmUpsRQBEmi6C6GGzeNMcA44IhzgyYpUHU4HcmoNKW3t/II/U3UQY7DE1mLIR
	pWo7wBQs2hJQW2NDzF4Woxa+en9zXj3dEPh6O0CDZOjTgSgxss/qrodcSt8OlFiI
	9iHlGF5kniFq/8bM9arjI/PwY+iT7qYKSyFiJsHpuIVoFNtMXbizXPE4sFqwleKn
	AmkFhnuPRNjQX6+LGGJ/GI8SxMG4g5OVmndk6PAVgGYl4HyLglLA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nc4bv7ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 01:33:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A50ggKd005034;
	Tue, 5 Nov 2024 01:33:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42p879xepe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 01:33:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQZ1ML04cFMXEWsudQbBc3qVUebzp2TRlCsDspgP2LopXlF5BeZbTp2Tkfzs++QfNxi2gWhmtG9opATf6Z7bBv+IQF135XZg1W0jJJlFBm0n8wyigQBGwnAauHp/G0ghAP7ijRq1LZ7drUde820YN0hQEGCYWCIYOsLveKjbd3gG9/uLvyaisSXKCx/vnf4qeltLmArqBgFhv8I3CWoFWVDNVw3HRYLn9Y+NZSLQXfJWE8zWtUIJsU3vF+5ixx3DXM9fR+L8g8dDePvCBVahjJCFkFyaMhRQ2jXZZGMeTOc1ycr78gSf6BRcT9gYYFjUHnutsNkJP0g9aZNjxDFc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IB8CNdfnFOF4TldQut5IiwiWExW0itzIaBYWtKlLvk=;
 b=AHvDPLukAj65MCoNNa5Ush2S6u/yRNjH2iBYb6M5bVfWHN2AAFE9nZw1sq/kLwIoJ/I4W+cwE4yNWcvaWB80yyFCVsfn1PlT9YXs3AP9DooA7olLXJH5a+Rxo0YC7584TSZLhpRgAC07/DN2kOABe7vYWeIdnp6IR2CnYu/nIwdfm7CXrnHEomReDAyJoc31aTdKzhhvSl+NrHjFNjU4DvjR0OLcqzBpBJth6A59HhYDf59KC+Qhk4f0kBuEkVUVMO0V2vWMMAnyoI6zeDEikwQBLuCSIdxx+FQHMqVNxehcec7laRwg53heZPjJoyQTWhRAhxzqLYIXglE8R0O7Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IB8CNdfnFOF4TldQut5IiwiWExW0itzIaBYWtKlLvk=;
 b=rqwZKjrCN0ldhFCy/X5MkVSCzCqCCPlZbaFWVs2R+FWIh4tdmVsOUQo1T2rMpXGNWF0dbauVA1qevCedS+UrRYBOdYRkB5Pcv/FpzwcYjPSEvli7AEBPNDKLXJIUQ6PUdEfxAkwTtLwmDckX0Roj8SeBrgwecNbDuBW9OuO9850=
Received: from SN6PR10MB2957.namprd10.prod.outlook.com (2603:10b6:805:cb::19)
 by SN7PR10MB6476.namprd10.prod.outlook.com (2603:10b6:806:2a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 5 Nov
 2024 01:33:49 +0000
Received: from SN6PR10MB2957.namprd10.prod.outlook.com
 ([fe80::72ff:b8f4:e34b:18c]) by SN6PR10MB2957.namprd10.prod.outlook.com
 ([fe80::72ff:b8f4:e34b:18c%4]) with mapi id 15.20.8114.015; Tue, 5 Nov 2024
 01:33:49 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        sparclinux@vger.kernel.org, x86@kernel.org,
        Ard Biesheuvel
 <ardb@kernel.org>
Subject: Re: [PATCH v3 18/18] scsi: target: iscsi: switch to using the
 crc32c library
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20241103223154.136127-19-ebiggers@kernel.org> (Eric Biggers's
	message of "Sun, 3 Nov 2024 14:31:54 -0800")
Organization: Oracle Corporation
Message-ID: <yq1bjyu5usb.fsf@ca-mkp.ca.oracle.com>
References: <20241103223154.136127-1-ebiggers@kernel.org>
	<20241103223154.136127-19-ebiggers@kernel.org>
Date: Mon, 04 Nov 2024 20:33:47 -0500
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0228.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::23) To SN6PR10MB2957.namprd10.prod.outlook.com
 (2603:10b6:805:cb::19)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2957:EE_|SN7PR10MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: e68e28b2-0908-4426-9f41-08dcfd39e62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FRuDr7RU5g2q0ZO7udvXvR7Txt0VFvkeuaUfV0aQR5Y109qNr0UMeCVoe2n+?=
 =?us-ascii?Q?aJSI/QiCD7yea1X3Qan+I5NQDjvLVgPz4NZlVCW2Z0n6pLWs5pfgWj7u32mN?=
 =?us-ascii?Q?dMRCM8ojRmn9G7E/pOtw6gXqTyTyxSoUkMsp8mAqvlPGab/P3MLG2rBNvjnB?=
 =?us-ascii?Q?DTcyr+AVIqvlKRuy9g1S9Mo0Fkkkr9P0uRuPMtXnTluuP8uZ53ALYbQauY1b?=
 =?us-ascii?Q?XmnozBjounBm+PWff0TwRYseYO/Nlnmo2zcO26pqNhm0y1COq6UMKtwoSPWd?=
 =?us-ascii?Q?BNP7wQogcJhv2d1oYfUWpGqKihpb/M0bg6KdtINtatAU3n7STh7bF6lNMQkg?=
 =?us-ascii?Q?oQCKFUkQl1tnwxbbe5xRyC6TZPNAtOuEMWPAyHXt6MHsh25yNsh9OUM9e5fK?=
 =?us-ascii?Q?HuOuR5TjKjgn8vG95kVDC+1d6Ii4HR0icAerJ9mO5toBWZUvl2CmHh3yw686?=
 =?us-ascii?Q?BrSRr8brImQ4tdQG9eYD3lzBc3qCA9RmeNRPl69lFtceooffQidqtrqSNEER?=
 =?us-ascii?Q?ok3ryYed2OrQdg9pTxKjV+ewj/Xg0EnAtFwfw9foBZ+Kt7Q9GDyR/Sdp8JRe?=
 =?us-ascii?Q?/2rz0NKBAXr0OuG7scXjV8gTwZhCTMtsfJrxizDeXY1lpKNEtr2xA8yiM4in?=
 =?us-ascii?Q?Fgx/JRomgutOUlvmYj4WZC3MXtGA4YpbBaEB/7UJMtMOgwtb2riw6qg9CuIe?=
 =?us-ascii?Q?uJuYh9ntavbFmH2At7nJuLSZ+OGZnrluOPRVTrSNDhfCfURa+oiXDAXS8HO5?=
 =?us-ascii?Q?X8zcHFQxzWQwKii+BS+hYK9sBjh1Vlsx+Y5Sod4ApODp9FvlJedoihp2oKpW?=
 =?us-ascii?Q?xKgmPatVNuSrikVkY+JV6fRIg5QG1rMQEPqgaSk45WXuL/gP4Y7Udatq1e+O?=
 =?us-ascii?Q?vMnX7TekC5Bkj/Bkg9kjgyWCgykzeYIhcWsmMs4/mXAQAsyRPGiz34lVWe+Y?=
 =?us-ascii?Q?VP4zeQRfG3IYHl7ebWwMu707FqVwbwqZ8qjd9NCYxmsptV3vVwSKKPpfr/Cz?=
 =?us-ascii?Q?eO8KYUz2KYzffutA1Tu4i9f9Y9Tm5fdpBUW5bobYtJyNRYsOVMIeVCh8dGFt?=
 =?us-ascii?Q?NtcZ74gTTWk9YydW17/Julye3RyaHQgYS3+dDmMZ9G+fCO26N2RY/WhqgbtM?=
 =?us-ascii?Q?iGiu9HvKvTCZJtc18eTcywNfEgKPF/uelyK6sJ1ffEVpl+YV/yxJQwtCJUVD?=
 =?us-ascii?Q?tEdqab3clbdAcSm7ydfHsoWIdjevrtJYcz98TMCf/Hj0/+mIindGvy2p7ilZ?=
 =?us-ascii?Q?KmJSW5cC3ZySqNhu8nIjhjBwgKg23Yyrhl2xDt4kTLFxaaCBrpHWp8z3VwQL?=
 =?us-ascii?Q?/ltkM9If1g2aoI6AF93n8bTt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2957.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5QkpAVc8Oo46ovNy4ljkzzM/A1dvIRdPxlWsTFo0JpNxmNCEI1qXqDsooKLV?=
 =?us-ascii?Q?ttlXCpwbg/KDQX2n14mCLSpKJ8bnS8EGexmoY//uNuZ16Aavb5AjsHb2EF26?=
 =?us-ascii?Q?THbkBergFB0nP4kIBSQYPlLkKXT4lMyfgnWkdrl+nfBPwpPeYPaGnFFOld6w?=
 =?us-ascii?Q?mB9RRXG7D1t3W7fzsrY3i3reCJLN3mx5N27RSl8liKfzxpLeZ7Gn7Hl4zwgb?=
 =?us-ascii?Q?moRNLscOxBr/sAMkx3IHm2tQOy53QaXN+JS0ixYMfS4pyKKbX+amIL5yajc9?=
 =?us-ascii?Q?0B+6zyhNSJ3jhMJrqrW0+GAcscYKmfnyNWp3PLMvoOoHNlYyJ5Vqt6E9wJem?=
 =?us-ascii?Q?RLoJOr4b+CjVaCGiOo+MCCbyOqRzK6IhTIL1bTMSUvA4gLSXhjwi/s5xOK1e?=
 =?us-ascii?Q?l4i9LIn9EwD2x/hoRio+Chi4kfPKIAbnjn8e2KkIcpg98i8r7BPP6FLIZBKf?=
 =?us-ascii?Q?vsx9sJFFXBA3BfaWo8aAGcz14HtoukYsk+tF7iy6Rs+1g8mXdxC53EC8pBow?=
 =?us-ascii?Q?ThPxUc+VAOSdoaOc0ksndCCZ+Bw4AQqiGLsQXIH3RWMiv87/iNrLVooTsddB?=
 =?us-ascii?Q?20fNew3qgHihJLbeyCOwtPvrOeoqTzd1A7BqvKt21/DXWmTkj8Ay+qi8uYlc?=
 =?us-ascii?Q?SivrbTvW7NOy0wO8AdoHa/gs0hiqNxVvWgY4MK0+mYVrqP6ZQtkDCp/nGsrV?=
 =?us-ascii?Q?SmKt4Bk6ds/SfBcY3Smqbo8id7vWrZ5Ap6MsRlac21MMeRLsI3q3A1LG82Vn?=
 =?us-ascii?Q?FKs4giY4/RiOyyGRlZrH4h0tjPfsSS1zm22ss33p677I6SgEUEV/MMWOKRmb?=
 =?us-ascii?Q?1tvhMUq2LSpU+52MpvShbU6CNMuIHa/YwAp2sx3xnwHBFl74zR182LLS5ZlV?=
 =?us-ascii?Q?Y6BgifOwxz6eofCYfXTST6lLNhzw/o9DJec7IpSTe1k0WUZb/jyNesuBtwJs?=
 =?us-ascii?Q?JF4UTbYdaKIfjwdwwKkD2A1/5jPfLZmGQDI7etUu2v1Hf2sQopk6vezE8KS3?=
 =?us-ascii?Q?gsR4dd1PZLUBxBGjm/wDwNSob61ujUooPzvaOj5E/i+AyZO/KgSph4qOcHsh?=
 =?us-ascii?Q?J5iMmbaJTZdGZWQeSpnmKChY3gOKBGmkR5Qn93UgzNm7ycxCxAbFL/opHFxz?=
 =?us-ascii?Q?zWoKftsp6ybzFNTiXKjV4HIwe+h611lmo7krCpsQiezTiWQZAmR1c0PjcJ98?=
 =?us-ascii?Q?uTFJ7MHBIuD/VmxqEbXjf2hvZo74pqui64tYqz9PBA7gds3LmsaDnhHTcR30?=
 =?us-ascii?Q?9LNIhvjKe/9oeaY9OQezh6J0Hd3LOTjz5XXPTtYD1n9m75SoDPG5RB3CxV30?=
 =?us-ascii?Q?xAhOwJ8qiTjJ9TAl1fQdH4opQ1ZzpcmCui1h7wvl8tKjSV7ywVFxvKML3wRh?=
 =?us-ascii?Q?tH5CCmlQdjJdUWbw1SvJBMpR/TDi3KSQl5aLF/9kP1Gxul3D/kx3+liROkV1?=
 =?us-ascii?Q?Kr/wMPXm0DdH8Oo4/ab0F9r6v4oa3zKiaX+URxXhIZFaSP6QSQ9eF+R0ja5L?=
 =?us-ascii?Q?F/WaMjAGsjEFppG8P1irA8NlXxdfRaQCXHC9rgTYzF1tb++EMhraAYEgXske?=
 =?us-ascii?Q?alOz3TZtctec8yn7uT2H/Zqt89laFgMiHt11sf4h+jZ5O0hTpubl9Fzv1qeb?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qOTAdrk+VxxIS9XP8QJcNTaoD6J7wG6733BATC9QZ+yN8gSaVxYJ3Zh87IkXNFFfXvm/sXZHytS9LWru7uN+ME7JQA3Fhl9xCcDmQieE/N9W31Et1ndfdUpegzOfMfMRVF5zhJiHm3kPrbGIq9ytGTrmEzUuK9fsNJTAqwAPVhSB33AHWK1ecGeu9Afzg7gNUivjxSYPGMvf4/QZR0qqpX4YVwF2YdyBjMO17O1qmpVaS8FFARyyB6pmWAJilTLwCRw+qqw+fjKCbaKXTEe9HNLWfb3J4XX4vyVnMKYlACpTtfqRVXkMBOoelOivq52tryXineEx6HhQwqupMWwqJHYLavhQZQypXXcJtxu2x2f5PtbCVOOrXE3Tbhz7CP3Q0KD533RDb2YHrBhqXinP0aQXmbMvl4uYWpvWsK6TKslJ2mQfXgRif+eUn/rxI8/w7sv9tll+khZQ+Y3J6F5xyz/YsnyNpJNXRe6xrFAJbcaGzVkGcC4KkY9j4J2TE3A++4gStGrAydrg9V0fD6rMje2A3pTl4pJzWBmGHg/4Dt+iuif6sGG6xGnYvEvm+EM6rTg2p45Kfy1WuJOZBV3oV9zgSrSbxrYoXtni7y08I8E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68e28b2-0908-4426-9f41-08dcfd39e62f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2957.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 01:33:49.7656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yEi59SUlAfl2Lu/OVWOOlm/x2ZrMyY2iMQxhWsKNKv8KgDEGfNFJ+eG2otCSwc6eJrd3817hfu/ia/mEf77ZopzACNPDwmipxcOS3hrmd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6476
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_22,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411050011
X-Proofpoint-ORIG-GUID: zs8GZAjkthqksiW3uwoFJcptg6625-0g
X-Proofpoint-GUID: zs8GZAjkthqksiW3uwoFJcptg6625-0g


Eric,

> Now that the crc32c() library function directly takes advantage of
> architecture-specific optimizations, it is unnecessary to go through
> the crypto API. Just use crc32c(). This is much simpler, and it
> improves performance due to eliminating the crypto API overhead.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

