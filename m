Return-Path: <linux-arch+bounces-9137-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A35489D1D5D
	for <lists+linux-arch@lfdr.de>; Tue, 19 Nov 2024 02:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649822813ED
	for <lists+linux-arch@lfdr.de>; Tue, 19 Nov 2024 01:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0B4450F2;
	Tue, 19 Nov 2024 01:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VkCFkHkE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X5R8+lH5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E01D54648;
	Tue, 19 Nov 2024 01:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731980023; cv=fail; b=Xcb+RfVgl6hq5PHjPI+gMH7LGCX8u1Zx7fVvoIhDwU9rPCp/YhgVtWpPmaRLduPIXgEvjha9aFjZRS+kwizGrQISnnVLifjOmwURiPCV743dX8+fmotqhDvRLHQ9YtBvVVYNYAlyz/igkFVpg1/UnOikFPl3q5JQkccbmMzsKBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731980023; c=relaxed/simple;
	bh=zseJEHT88Hig9/IE7s6nmTZsh/YG4wDlzSmEo8FlutM=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=YwgFQsFiSzcj8MzcG8BowzqL3Xe/dllQOyTRRdkjtYhmhdK/wKIe+THKI5/rruLnkEQYtb2SXtxY6vrfUswduZn44/wb2MooLbWdBGcHFat8QLVZwn/P/rltoDcIVcC8nnHoqGfFQoBdebwFz5wQoRKPK252Uh9Sl4CcSpsIR1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VkCFkHkE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X5R8+lH5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ1Ml6m019728;
	Tue, 19 Nov 2024 01:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=2V7IUFZpaiUZTcFlT+
	FvASk52kV3GL8mFvu0iCN6Gq4=; b=VkCFkHkE6EVZ3LB15mZFyDWBm8dILJP/GS
	8mhmyxFOIrrUM0pTxqd4jqHQMlHmVCyvod9HAleI0vq0Ki9RXAbngXEu3ybpG/hq
	ahRxoaU82Sfzxq87g0SYUWpcWQuU3vojL1POvixQhr6eZ7ciYAwtoZSMlNCQjshK
	iHsqFtg3UWlFfxuPY1miIS3ZyYzlBq+WASsU4b07QhdZ+5ZA38yxRxR4tz9th1DD
	7JKW6QPCULxD7u5BhR4JDFZs3o16cWUqlgBFvpX0d+DqbO507fbzUXJVXjJ0YpQg
	X4xQC5w2AyTRGdgYyxNEgLLtU4g2/k/88dS3vJzSLIdgTCwMgfmA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaa40t1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 01:33:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIMrca7023316;
	Tue, 19 Nov 2024 01:33:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8946b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 01:33:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJRsdQdXRIyJvjGf3imyYkWct6UhER7TN2KacYhwVJEOZS/aVHuy1EA8BaUdbL/Q9L3H5EpJhxRg4Gbez8XPRV9I164MBwTxFiqoIE+pYHXeatWzt+sTVF3dmyYOwTtEpdeCchrnZcd0nXCjVPDGljTJG1v5QXKcZJNya1GvRJVwytAACXTUJqdy0AAZgsyTNDLPQ/mnVsocbzDAG/ESjMpyBYwj9lrUY1/6P/7JHEN1P/53Nt0iRcQTeANjs/QftFmGBTExI6tif0Av7Hs8sMwuhCQylvkh6rYYXjLPlEaQvgupqqxMeXYhCCpVk1WTMJQ6UWWXpPCUjRX3eaMsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2V7IUFZpaiUZTcFlT+FvASk52kV3GL8mFvu0iCN6Gq4=;
 b=HhZzuTR4YN4KSDVDl/Wz3MwAIOllsRdE8lYfgYl3W6GpualX8XEopHwTqk1kWcLq69l31dlqNFT6Svp0KCkJ7o5lLeU3B9e5bShPhPtj0xCyHZWNP62U65M+6BpN9GOVTkN4H5Yj+j/pgIfOeoEKqxHGtAWquhcoAwLTABN5Fm4CjbYC5yFL3UHVPs/coljQrzWhIXZ72yFD1lUPhBCNqsPXQULQ9V4BJqcGihIkN/gYjhuEqhiNHF0qz9mZp7e6lKlg0fAAzH2jS3kacTkjFedRgs8V1Dw6SFEdzj/GGttrfrLpasZRkNZuLDdb0Zir2ImhB2KdRnJEeoHdPa77jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V7IUFZpaiUZTcFlT+FvASk52kV3GL8mFvu0iCN6Gq4=;
 b=X5R8+lH5Ufy5R/VwA6fG1h0H1YRFy7ZtzQfQBzhAAxqudP/CaZrYDWzj2pJVxEWtpVxvIs1YINvccujgI1BhAF8Dr6seblvt0XeNopyYdnjUIKrCRor7Ag245SKc4//I2h9iQtZdbA0VZ15WR9svU+GWsI+4X852Kgxo55nIBSo=
Received: from SN6PR10MB2957.namprd10.prod.outlook.com (2603:10b6:805:cb::19)
 by SA1PR10MB5821.namprd10.prod.outlook.com (2603:10b6:806:232::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 01:33:14 +0000
Received: from SN6PR10MB2957.namprd10.prod.outlook.com
 ([fe80::72ff:b8f4:e34b:18c]) by SN6PR10MB2957.namprd10.prod.outlook.com
 ([fe80::72ff:b8f4:e34b:18c%5]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 01:33:14 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        Zhihang Shao
 <zhihang.shao.iscas@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 00/11] Wire up CRC-T10DIF library functions to
 arch-optimized code
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20241117002244.105200-1-ebiggers@kernel.org> (Eric Biggers's
	message of "Sat, 16 Nov 2024 16:22:33 -0800")
Organization: Oracle Corporation
Message-ID: <yq1r078rp3y.fsf@ca-mkp.ca.oracle.com>
References: <20241117002244.105200-1-ebiggers@kernel.org>
Date: Mon, 18 Nov 2024 20:33:12 -0500
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0288.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::23) To SN6PR10MB2957.namprd10.prod.outlook.com
 (2603:10b6:805:cb::19)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2957:EE_|SA1PR10MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b84e1c-1fce-4c2a-283d-08dd083a22f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UjsiD43kqOmYfSytzdX1G4t5Hljq790ld6Sn/q8FaqXagBYRv080iLn1k6pY?=
 =?us-ascii?Q?fSZgS/uZ8Fa4bMccIYAgPRIKTsnW9gPxSg4ERQtRNmZvtr1HXrY7GxuIGAgP?=
 =?us-ascii?Q?ngcjSjzc8TFAA22dvu5cnwa+pGgfqJRJAUizlTn+knAJ/c9O1JNrxCSgVJND?=
 =?us-ascii?Q?xQfDGs5nADoV+KnvyQ9XEEQOm/svtbxviRyGPQwMk4NvUJ5+1Y4KvfUdCNeg?=
 =?us-ascii?Q?upxixhg0qhmLs6ZPFoAk8C4oTgSnO4nZ5moGKNzf5CQc0HWCKKMsfFc2CRXk?=
 =?us-ascii?Q?oSp1sJzZwUZz3exFJhGzrNhfNpAmsErn6qt24NbOxZ6rXl1jBXU2hJ0or2vf?=
 =?us-ascii?Q?N/bO4Mo9wg98JH94ApqCtM00viZjRIfFrnJkzhyzazgz8npZ6M1nhvJ4rS4d?=
 =?us-ascii?Q?yW36mA3OfWqG72uLPL8o3AXHL/dVY+BllzlxBhVm5UvlxOHR8aHlJ2RUalWA?=
 =?us-ascii?Q?lnc1+JP7dLLYqoI2j53rU4YGzFNB6YLrFwwVw+F2S6gtRWFc303sj7p4+IT5?=
 =?us-ascii?Q?MXpAfRS5wpXpG1XkNbFkVdHC1JPVxcKsvF4/wXoNzyE/O64zL8aW5WcbGbdO?=
 =?us-ascii?Q?dPtob1uCrpWdCv1YL2zmD4tE3tWOGvsDHB9s9AZzSMEvK5RULXYnOjN1ahz1?=
 =?us-ascii?Q?UZ1NjhFDfzCxVrWAk+TT6+z5bmnJivfjr/5H8Iq8f4D9H9DPAkxIqnNJnWX2?=
 =?us-ascii?Q?+Xg7Gvy7tpucnG1gbDCEpLoi8O2PbuQmZY+wJ21Sd9qCoL8WgtU+n4uXKhjX?=
 =?us-ascii?Q?Y+V+SmwuxXyeEgkiBtJquikq9EvmjrEyhvOW60edExdtwkyit/JwFhEbPpdY?=
 =?us-ascii?Q?aq1tZShe6dMjF9cvsJTHLaKhhc+pa/OXsUXKxiRHSqgHjuE201uEjMw3yD5e?=
 =?us-ascii?Q?a7j4g3wtGTNxEuZEC3Ws9ErhqSWtA0NfuSY7Mvbe6q/GmqKXwP1xZ7Hq7jPl?=
 =?us-ascii?Q?SHrjhblM0MlH7r5/XQOoij5RbL9ezC7SyfRRDmJHAqUeiSbacqAmUSjZeARX?=
 =?us-ascii?Q?BirY1H8giOGWmVivoj1HsY710BQRq9aaCj1tNLoXRrZVRM8MHS4XEWch9NlS?=
 =?us-ascii?Q?sEJPPsah0PIf3spZs6osvm6FFDJJ7jbJ2E27YasOV0epau5KDRZRzV6bSj3l?=
 =?us-ascii?Q?POGv2q4owK9yEaYPe59ZL26ExKmsoVLEy9i9m3c66iszqMKpAmsJKvwwEmfV?=
 =?us-ascii?Q?8afU6eMM4YmKNJxCkaVquVfJB1VO5mhbpVJZNmowy172trmxdeQ0c4Fu+HZf?=
 =?us-ascii?Q?Cs319aIGhGGGf9KT4tCja4AOT39ci397+Rmkk4vw8l55RLJcuZNURlhyPq/O?=
 =?us-ascii?Q?OM1bl/SNRpzBEvfZrrZk0lZ7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2957.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NCITHxryZFZ+FNKKRgQIIdnvE1s2hMYklmB5FheTtZxXxuYKnVfc6ckJT42j?=
 =?us-ascii?Q?s2Mo0DApQJbKGAoFKIzBE804Tot1J/O3bM481UfipySOJE+Dz+TTzWE28QI/?=
 =?us-ascii?Q?IhFLNVU0v2NHe1jMfn3kLkyn9UhQtJkxxBp9zLGdTeC0LKFa4lzwN9ZlIdHJ?=
 =?us-ascii?Q?HdWWNEOIvoe9e47lkO93Uu4jX4c8bu517IOFB17avOGjkhijAUFcZmV42Itj?=
 =?us-ascii?Q?cGMhBznGB07mNM7JtLjWC6xRyCpSeya8Geud6TgkTo5blN60XSxeafd/RSgJ?=
 =?us-ascii?Q?hmGzIZsG+2hL9p7GJylGF5WN2fooZ1epECvynTXoC5LUK3TWmmGi3tQFu5qK?=
 =?us-ascii?Q?VAOxQ5BIYEQ/WnnsVCOAngw3mVedp8Y0o7V0wBANPSCXRHZgwyuBbMeB1Da6?=
 =?us-ascii?Q?dHUysDD3mWujt92SGBQM9gkntMvI7Jbm6P208WDT9Vu+k/ueqVi6W8ofrTEd?=
 =?us-ascii?Q?qsJ6BkbUJua+4C4KCaeLHdHLDOSqTjpiyWSqvEZtPG3/jdBqaAsLXgWpRwYY?=
 =?us-ascii?Q?EctjrPGAVZhxsovuXdIOoRSNkIOANRJvOF8lFegxTKZWEt+lrNHAGk9Z+y4B?=
 =?us-ascii?Q?LR8ET/xITcOoMa+FtyEhddz0gaSjZLtR47q/pcHOaxAM1M6KPN3/IkC6Dqoc?=
 =?us-ascii?Q?+OitCV0hNXQpD+1tGg1+JGGsVI68soidFt0/SJLd7u5+Ynw36QerkXtKARMl?=
 =?us-ascii?Q?1ue0Oe7j6wc60J3aVvt4b4RFtfSzJo6qIS1FWGq/6W0ZOwswU2nFKO6KKS/n?=
 =?us-ascii?Q?ljDESLGrO9CBorldQEBLFn+q9ny+Xsh1kKCIExecP7dSF8xAiJvRf6PP1Wb3?=
 =?us-ascii?Q?6wMRcsjTjNo9rudE+ckEa3rheu2yvDymrbrJtBOUp6D+8wQVGrmQuFnErgln?=
 =?us-ascii?Q?1UH/VTASSqOPObstod5xSs2DIUDOnUMlYdMZOnKk+r+9xm1rcsWMBSUGgJzD?=
 =?us-ascii?Q?se/TC+k5btYnNNDsTDdJ+e3Qr6Wi2jgJhzYiXNKbFiPW4FhQCXwPzRNgRE+g?=
 =?us-ascii?Q?YapNSNs9YjEAE7FxXD5BGHeXvJb9oi5W/4dVOvBQCuxU+sLflys6NlpWxz3G?=
 =?us-ascii?Q?UqDmb6SX8sPP366cP2Vpz7WvRtwOmqh+hyZpxV+Xnztw0x1WG6a4B1AAWgs8?=
 =?us-ascii?Q?uy3oo0Gb/oMxFOCxYXh3G0scGlPz4XuopCMkhsBu2M0L32Z9CJcidZh+NMzh?=
 =?us-ascii?Q?v/VISbQiesyKej6tSisA2tdAW0nMUo7KBSyncsBFJVP7a7rDlaNZvxDcjhIM?=
 =?us-ascii?Q?7ILvuV6r7cBrx62IHs/8Di5Kr7bAgMRfrwuCYDUtLrd9dDlcB8hAXb1DGYHh?=
 =?us-ascii?Q?FFCWY97Yg5J1tnDAJVHSIl0xoYNf3Wycu2adHRUBBN63judaGJrHuIjYIR4Y?=
 =?us-ascii?Q?2PmKDfmHk1OCVhnKomGabUMILqIyJn265cBea1nAAzLO7iT0EG+NaCUHqJmJ?=
 =?us-ascii?Q?RA0dxatlJs5lYaOEEH1RVUR1IMHGvm2WEoYBQZT6RMzA2a1qt6T0yCRibf0r?=
 =?us-ascii?Q?ID4ukSzhJ/t3ozBDgvjJkmCBRNyW2bJx/R6Uece15hQihlKzBe+tcFlQ/r4t?=
 =?us-ascii?Q?sRN+oa/biXQ8PVLy7DHtUvKhtUZZoANSbsUQfb3iquHVBnyZnxGo2H7a58st?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QfXEjr/HtVn5aWjwApFJfgCE36UPEk64mtq1Q+JXqSvmj2PJQID/OyKXOqYyeN+gtSj+eV/EYu6OhXXzOa0qS7i7KpPXzQZw5GZJTIIqoNEkZqKbMuMChJAm1D9Gif0QTLgkN9QOkzNsAnVD4Bw93XISWP/UokhcIQ5UJDax0MU5YHvALYgy0hgJpKi6Ct6r2ytxyWctjWinCGyZPtw4ojtzeAZVpSd4SRL4gVqsSPWE5X0MtpTArfZ8WW+7C00E6EAzqXqjyAsBMxVLetfIxiS405wUiE+35MegKJjxntqIdvCFqPyvVHmYKBDL1vCGrMhTxGG5Biq0AwWHznCMu3J1lN3/WlJ50MNsr2hiunxsrL7azLBVcUwoIOhVpvLPaDMhiPTLVwlpdbygRJB/rYt5umKaj6yIcshOzSDH8mwFg9Tdcm4h5YrfA4UhrKRxLEXhl2NRFXw85HlcbGNI5dbb2yq7lRbiM0+euCJFbmmLBJiUu+PXnxh/Y1OfX73wL6Q4kNp0wpOKMXQXXbwa2oX72D+bHvzQl1dK0zSI5FjSWf8keO4T6JUDPPFtHj+sY+Mz02wT00HHDeCkXUKjXdwIRg6kY6m0q5P2p2S0Edo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b84e1c-1fce-4c2a-283d-08dd083a22f8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2957.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 01:33:14.5385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QR5WndWZ7luv2qMtt55VbKmiyjs+2sj3FP6r6240XlV7yxyRyWDQPz4LyrTHQn8jHKCaHyKAiBEi+UviIM1FrV+YRdYT15WbC2uq0YGr9pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5821
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190012
X-Proofpoint-ORIG-GUID: _6TPkSuXpUjTxD93D4-zAxofItC39OqX
X-Proofpoint-GUID: _6TPkSuXpUjTxD93D4-zAxofItC39OqX


Eric,

> This patchset updates the kernel's CRC-T10DIF library functions to be
> directly optimized for x86, arm, arm64, and powerpc without taking an
> unnecessary and inefficient detour through the crypto API.

LGTM. Always found it odd to have to use the crypto API for this.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

