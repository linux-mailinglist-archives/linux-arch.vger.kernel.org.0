Return-Path: <linux-arch+bounces-11851-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7194AA9A26
	for <lists+linux-arch@lfdr.de>; Mon,  5 May 2025 19:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220A63B9C75
	for <lists+linux-arch@lfdr.de>; Mon,  5 May 2025 17:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5633C25DCF0;
	Mon,  5 May 2025 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TRj5RRVb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lCqJRbC1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E6419DF9A;
	Mon,  5 May 2025 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464949; cv=fail; b=a1ZaBX0XbR2js9fHAUazXTqKsiBNMhpxOJTxy1Cc0rL8fpPkAnbEgKkGT5MJIt5vl07uT0QQOkYLrKUAbt1TkFX2i2j0XHNFsuJfGdAo5ekhrP+9tR2nBllvc1zw+XQ/xz9RHFA6i08YhzE2IA9cxymmMJH6r6KQA+rpmJPeo38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464949; c=relaxed/simple;
	bh=WY2Cx5LjMd0R0fipQ0joqu0WZq2MQIZhOdhzpa3c3+A=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=ju2/JGimaPYMR+Idl+Odnzh9ptK9H1ku03KF1tJfa6+32JryGaFOEQezGSnLK9JOtClIKx8lpLnJJEb0VSqLeoeG6GjjukMYt96wjIGufUh+uUhGnfVwrLnzs4sGpEmsyldzfXfz9OwYVj5Um6cHohyRPC1cuWvj9EEM2bhfmuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TRj5RRVb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lCqJRbC1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545H2vjw031927;
	Mon, 5 May 2025 17:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=WY2Cx5LjMd0R0fipQ0
	joqu0WZq2MQIZhOdhzpa3c3+A=; b=TRj5RRVbRVcPMY6l6IovQ+Be2aQ7mI0leH
	3l8nLAio64VRsnZUjzDtISLDbj+61S1DE1o6vSg2rC9J2cfvsJ2R6WHIFg1+ANuF
	hl4rxwsQprvtMZR3TJ2JTK+a6VbWKeA6e5LxGfVPlNUC8HV3jKa66FJQIsMvIz+X
	T3WseUOMiaWiE4wPS4GAlDpWbeneWsiPCRCBLiRKjZgQQYmsG2tfNQppp4RS9KkF
	4m6veSPbzOZUHjBc8a19GDxzdYaZur9BxTilO10/ONKzJY0GnWddXBaIoA4qvxZg
	9hugXQtIWptdHmBlECvQEq9MXLxWm8Z5QhoNGj1SLYeSoRFMMN+g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46f1ccg0hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 17:08:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 545FWIJP025117;
	Mon, 5 May 2025 17:08:36 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010003.outbound.protection.outlook.com [40.93.10.3])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9ke6mjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 17:08:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjaPbI0bPkprF2boSQPMk5oh/Ks/FVHpljo35QYsmlGq3DhMEP1FQjtZURs0ikUVj1KuD4Tc9zCYeXfpC4aR2zBuqGy++7be0VFPFPZqcnqDYSSXun8cUUPkByY1bHnxkm9FV4222SyWqVLLllqq4C6qGii4WpVy0YDw5ibePBrDTw7X9mMSdzD4Pk6EuhCGCVKCR1ALG4dzUpG9d5+EjQCvpoiOrYY/E8+3z8U1oS/tnDXuf8t4VHWHZ0UsWgGt8kR7+Tl7SoWijrmM1L8NiATdAv9ZtHaUkUu3HlNkSlKTD1iuY2ICstdbjloFSIUIjQDJKPJHFdOA54FYv44e8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WY2Cx5LjMd0R0fipQ0joqu0WZq2MQIZhOdhzpa3c3+A=;
 b=QpqejFx7ZtEc15ZAJ54+jiyCLj6ikJ0I2plx5hdQ2yMq6lQojrrnJOSfQWJMuxR04ChZyZdMGE5vqw58PRGdeMHWiTm2H2MqyC9Rtam91WDMuJ08TOQe3UZQhoCeNIRReh8XRnRJbB2uI7uaFw/iaWmH8j1if4jsIaeUJTxTWHP4wlTiZ7sZUyGqukw1+JftJJrI3hXwcT8u0511Pb70AWQxdpXtEv1juek+End89opHDCRpE0R7DrhEzRt8MiQoPJ9EE857lTR6u0EQvzHlOYXRRFaorLb6H/4lrcifQfFyeZNtI07CongmMuLCq6cILQGX/DduYhZc28iT3EnTZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WY2Cx5LjMd0R0fipQ0joqu0WZq2MQIZhOdhzpa3c3+A=;
 b=lCqJRbC1G4XaIPE7kjrEDAVCVeo+svrwDTC3bmCo350/HBGpbvE5Gde8stPoxWEK6xp0BprX14a/fpUySODHNFaBgvQxj3MqXwRVxgkNAK0bva5qJkG6pXO0Sg0hIvmksc+pgMaZDvIelGMbKT9Xc7JzA16/LtDmNwKIh5WpXgc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MN6PR10MB8117.namprd10.prod.outlook.com (2603:10b6:208:4f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 17:08:27 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%6]) with mapi id 15.20.8678.028; Mon, 5 May 2025
 17:08:27 +0000
References: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
 <a85fbebe-aa44-5ca0-f8ad-f997ea7e6622@gentwo.org>
 <87selmok1y.fsf@oracle.com>
 <6181ff8b-bb81-4dd0-f8ec-0f9d0944885e@gentwo.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        mark.rutland@arm.com, harisokn@amazon.com, ast@kernel.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v2 0/7] barrier: introduce smp_cond_load_*_timewait()
In-reply-to: <6181ff8b-bb81-4dd0-f8ec-0f9d0944885e@gentwo.org>
Date: Mon, 05 May 2025 10:08:25 -0700
Message-ID: <87o6w7nfxy.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0033.namprd16.prod.outlook.com (2603:10b6:907::46)
 To CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MN6PR10MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: 687f3a8e-8aff-4b98-462d-08dd8bf773ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eUtFOgqz3qXu7cPEF5wo9FNh0Z4wetpM0RUjnDx9wRYeyswCYwh6OTR2gb1r?=
 =?us-ascii?Q?M+ppDdVhGXNl/FgKeltd156mNUQoQ4tJ7fY2P2jiOkhsSp7AbC+YuhVtKD5a?=
 =?us-ascii?Q?qpdK1CSKUdy5G+6YWrhgoaXGbZZyiTl/T1jufVlBgix5gV7mz/dLCyfGOnBF?=
 =?us-ascii?Q?/8EhzBz1wfvpVbX7LS9TFMlbRPTK83MTMHpoO4zS59gW/Mt7FRa6kbZ9fJ8V?=
 =?us-ascii?Q?oI4nOq9OV8dW2bJaGVG9kcRCGTa2MbeN6vSfK3RzTCJJmgmiid4J3DWHUVGh?=
 =?us-ascii?Q?cyOtjAqK05mkXp8GCD17G/rGbNZDULirmo8n04uKnXDBSPgHMTEz5/Xk3OHs?=
 =?us-ascii?Q?6TxWKheNX4MSq42KA/QzmeWlqke7buIztEptrjeHCbxL9psFhQvEBS+sPSiT?=
 =?us-ascii?Q?AtWX/n2DBdmkMfZf7CIRRTonGOQcqk9kI803wUb0ub40N1YtZyGXG4R19CLO?=
 =?us-ascii?Q?BTWWO3GFSVUyboMy0QTpd522/GxZo7Ln4XamfZzWb4yB+a900iZByp9GVHcQ?=
 =?us-ascii?Q?9ddJ2G7UuYsu5rvRjqG+JULiZFwpqPjXbRTti7pZyvDYFkRwY/cqcB4cdMQO?=
 =?us-ascii?Q?DySSGkjJqr78Bgg+G3XBHs4/kUeGvLY8tjb5pvoWHtuzc6avb5tYo6nhD0kC?=
 =?us-ascii?Q?Me4sC5Nt9r0WUhIh/kycknJoQGmwZz6y7p8/x13M6jEhUYtgJ8oFE+LUAqVO?=
 =?us-ascii?Q?jnGbnlgPPsFRpBiZzJ46eRam8c7Fv7ig0b7mj3HPpa/PfFPW+3AS+BSjtguM?=
 =?us-ascii?Q?Mf1+ttdG1k8bbAvCtu3O4yKyrpY0Ax+4ZQnw17mqTnpjM8OyPC6FZFKnBNVx?=
 =?us-ascii?Q?zbzDEvwz4YhIpNv2KFreAqtANXaEYGz6vtpXlgXVb3MHHXO5fCjhz8ZNNTpt?=
 =?us-ascii?Q?1ishRz8SWpBvXJIdR8Ow7qqvyJH+32GWQYZ3oW7zw0F7Vuc0qC4m3kWHhutr?=
 =?us-ascii?Q?GshCBsd28oh+96B0Twg2ngf7xSOYjE3VXTPtvcmSbkPKS/x1NgTCQKwii0lQ?=
 =?us-ascii?Q?bBoj5ebSsV6+qBk5FwJPtnH8J2Sb3FXQ6HTZYLfHDS7YfsfH38gfK3QLFZBH?=
 =?us-ascii?Q?dy1IDndRD0vQ0YO5j8eOzO93hTyehfxO6iz06xtyjg4dyO9XKwzOyDobdOuB?=
 =?us-ascii?Q?dFN20jEEDIhpMsMIZ8mz32UWV9sBL8UQmXe6elME7zEWou/Zi/oUT1pvg4t6?=
 =?us-ascii?Q?yjpQKft19yJfjwQaRIrhfyplARVUN0G1YSK6DRntUVYeDMAlZHwop1cH3bGY?=
 =?us-ascii?Q?mRe6QeCWokwQT1BtkfHUyNGUmUBd5EhbRs4dfjSs+omZp/GO+9YlyeSnBhxZ?=
 =?us-ascii?Q?V6sNUJnnYntHtRnAzLWd2GZNIM6vAKWtAK3pYrT2byTnqvdUb8q3HX5udkXa?=
 =?us-ascii?Q?6xlVzR4uO5oR3O30sZ8nTutbnjk3r23ZjvraKObvHk/q4zcxc7gcd5vpR4hh?=
 =?us-ascii?Q?9oe0tkNLno0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1GeO89a4jFTww3Sg2GQJa4X0OBgw2r5r1YPZlNulUz9jod3s2U/BsxTDYX7/?=
 =?us-ascii?Q?NDgENJu0WEUaDHbe3FAy4txBCpTXuxlQkW87T9cLI4VEhQASU0NWNWL5gxK4?=
 =?us-ascii?Q?7pJ6lvvZeDmtVDXrkdzbidzq8KRH8KToQRmk8kHk/cRS2t33M/VwjtBLO4N+?=
 =?us-ascii?Q?sc7juGziq9SI7pkG+LVcUihEdXBahDh+PVmn9rvqdXcjzIUD1RVGv0rHZJfF?=
 =?us-ascii?Q?QP+NLcrR9PDX0ebHm4iIvjrFGPhY2OWKsUGygtqOns+6GTQGo/BRw/MgLzgg?=
 =?us-ascii?Q?TqQJf1diJkQVA/+wctKN+cpyal7ROpyHwPgt+VsXKdR+854ZJOg55IOQzdbj?=
 =?us-ascii?Q?wYHC8FCXPaacj7f+bH6XvbZptgcGqZIY3yIwO/jBgGPbPmhZAOr+WrtYu/SU?=
 =?us-ascii?Q?Bw097ZKDnYYUC+PvRfiw+IOlW4SUMg3XvSlC7HHSOI1y3JRv+ZA31u9Grp0H?=
 =?us-ascii?Q?lvJphN0Wml9BmODGNEhsePPSY6OglqEWugWY7TuuKAo+419y9xckk/sxNXoA?=
 =?us-ascii?Q?Ofq3r4Zy2SYrv40rWoXPp/OT/NgW1awPIAFjbpiKaX92FoG99V3hdwJytsNQ?=
 =?us-ascii?Q?ARt16BaDdfe/V+0rcf19TXAcLMHJmtsNJuzb1dPrBmTSsv5oj9XjBkJ/Y5Cm?=
 =?us-ascii?Q?npuYNXlko08nhMASUH4I2zd7DPY9XJ4ffiAVg2P/Hs4lt7FGUd+0TYSQukxV?=
 =?us-ascii?Q?XTT6QuYbvFpS/lCvDzokPc1zmDFBQMlCw1h21o6V5auhCV9klEBUyXanaPSo?=
 =?us-ascii?Q?8UyfEpdApDFidaV6rfHEVo9gz33jgUKfj/IRmBfb9dms0U0HxDB2obh59QdI?=
 =?us-ascii?Q?yf41kcOoATGzgGqjT4VXBd4T5+sSByhH4phL2YkNRiGn9E/ltrTrr4qybxij?=
 =?us-ascii?Q?ugft0HrF5um7tSrXqwauCCRM6Np+dHHu1cxaXT8ClimAni47AxeI50tgSF+C?=
 =?us-ascii?Q?VO3UWtev/xT3x3pAZv1iDGQnCDSJpGzdc79Lovet0Dkj//rlmyIU19aRT0fD?=
 =?us-ascii?Q?SR+KY2RrJsmfjQuIzeDik13aF7ZSuma1JNiK9msz60Lm9U5CeKAaJguBq0oL?=
 =?us-ascii?Q?Dsef2mVFYhnswXT+4izX1xyCYsY9ZTPBd225xOHDbfaFFbYTxdeb8k4txIaC?=
 =?us-ascii?Q?ZD67XWVSAzOOD4B8d28qf119D9sXoVQh1qBzWag4tbyMcL3+R59AltRDFs69?=
 =?us-ascii?Q?sWyKfmRiXCRgFRARq61dawxw+iQdp0NXD7kxpgKW5jxNLKtFpD2hKz0aPPDU?=
 =?us-ascii?Q?KK/aoVpsUodVEyOLV661U6DzpcXc6tEiC3Uiou1eAA+8sfgX0Xih2VTPm3PS?=
 =?us-ascii?Q?ULhwAR9l/HJLZfznA1SrYNrhxmi/BghrFpcnd8Ha5zsxmdCfcB2BYd8RahZm?=
 =?us-ascii?Q?hdQty3LckCArqlb30Tt8Bp6nlMOjBFlMJjw22Lo1ICXIFymfR3m+UrfVf7f0?=
 =?us-ascii?Q?9dw2jISZH7bBcvf5lg5w6ysOrWGX26uXS5FQvic3S/+POxhgINs6e2fyBCjD?=
 =?us-ascii?Q?2eNl98snMfH7wVbUvbqf5Ti1un4IleUTH7EheDY8mECu7ngcOMIDhzIFdXGs?=
 =?us-ascii?Q?O7I9WjCUSmEHGJIo/qcOhtIltCDc+4Y4XcrK6GPtzELNg+G2j28nEVibOpuY?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FRFvEdidlJZrAsLc2x2R/brnMXEi8FuvwW59mnsG2gEzaSBH3ICf2jC0QqfvPW8O09kGhkCL3G+xg+6h8LkIYq6D8aDWtwc24nQ0Ou37yrkgjhzDSB3S3YhwykAmzib4eaR3VbwPLtN8QrUk4g8uEJleoL2+e6ja0ZTK/iy7V9+lNCchqtnKUUj+lbqFw3v9itS35fwlzgWbT1b2TQdoCiOqljo5I5YoRAWIEq0GDFQYWxuA1A40XhE6iCEpMjpJ4iSPjqBab4wu/vAb8wWJZxJXiGx9qRPDmMTYrHMtGlwjaraW1nBc48w+B1fSNBqmRSclZvK3j1jBnohb2CJr3lkWJ8ngTruOtD+iXp3t1DN3BiKTOiMLSG6vsNs/LYVGy/XG4QuVtHxobvtlEaxOTzkH4XCXHZS6c23ijVjJidcshNeVuW/9eYSRVGCC13esK48v1XId4KHZb1mEFlr0NmlXS/ZA1+D7A4O0zx8qBQN4iSNKgVAI1Hi0J3CXp07pjeFKQsLocVRJMzUOISKvOaLRJmwWoizb/8lI+ylFpJHGLXO1fTkukLnl+pgytzqusYLKIYij051TLc0DP19g/LmeE9VDyZJF11TW+spBe6I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687f3a8e-8aff-4b98-462d-08dd8bf773ac
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 17:08:27.1954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jv27ypDnWMxuN141c2Xib5SAk1uLzOGPaJ+TMoBmBCfE2hEWkGKNz/wKj76wU4YbSF8hXfqw476K1ZZ59xLbULJMWhWfH1HdsKTzyR8+yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_07,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=636 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505050162
X-Proofpoint-GUID: NSv48o77LeMeSZ_0q9zTAbqPz7893onl
X-Authority-Analysis: v=2.4 cv=F79XdrhN c=1 sm=1 tr=0 ts=6818f095 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=PuvxfXWCAAAA:8 a=MlrTIZBMXMT8pGsMYdkA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=uAr15Ul7AJ1q7o2wzYQp:22 cc=ntf awl=host:13129
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDE2MSBTYWx0ZWRfX/+o1MBTC0N+l xK3wZgzFD0ENPOFkQoimsv8ck1LGXfpgmzb+5KrTM+LA8Q1nVCZgV7XxYs/k61MvD04sWPD1xp+ CQs5OjMeM5xK8aUlnyIcq7Y7P54p6LA7RqVTky3TagFMw+dtj+lNz+Rq/V3U0KcAf6XMqlS6AnN
 Ed7426KQSZY88dXjVrAF2tDl23actUTReZQv8RCMHHYjOEJjTDNbLUGf03iefLim2VFY6bqvpfa bMpIoybEgPefl3GDlAODiAW3+bpy+XqEroD+qMfNfzXoIYKDBEmaWy3e5P6g0mp2fWkxjcGVEIk ez3s/H4qjMvk3jacuzXeSLREv7ShxS58q+NjO8usYk/2Gqs5RzloRqhDxkawnbRtIDHOFalg6hg
 Ayr+S5lNfkafaqHkb7Hc0xVd++AVoW7NnsYb7qveBF/4aYmLlbPoceVZCS4SDgNoCOTrvBXz
X-Proofpoint-ORIG-GUID: NSv48o77LeMeSZ_0q9zTAbqPz7893onl


Christoph Lameter (Ampere) <cl@gentwo.org> writes:

> On Fri, 2 May 2025, Ankur Arora wrote:
>
>> AFAICT the vast majority of arm64 processors in the wild don't yet
>> support WFET. For instance I haven't been able to find a single one
>> to test my WFET changes with ;).
>
> Ok then for patch 1-6:
>
> Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>

Great. Thanks Christoph!

--
ankur

