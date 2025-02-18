Return-Path: <linux-arch+bounces-10200-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 495D6A3AB4C
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 22:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279E0188DF12
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 21:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BF71B87CF;
	Tue, 18 Feb 2025 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XyQX35Xa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i1YzWGs3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C012749A;
	Tue, 18 Feb 2025 21:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739915124; cv=fail; b=Y3Unm41uyWlfVauxfk8OgNvbdBYgWJpkhnWmg2khFsksgJR35q9B818/dCyLfoC2NaKEwMaRaJ2Fl+ew/oy975VWO7/D/gXopMYSD/agk32SFMGM4flrnWYUnqUQD9ELtyPFpvcC05Ukbz/xnuxEBMP3CK/WhRmu1DfLCfUJ9yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739915124; c=relaxed/simple;
	bh=lrCclu9UaL/cq/PqvKlKlDlr/xo3gZId2isAbjCIVIs=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=sm/Ba4j/eXKxcaGN+cwrfK++NuINOyVIpAKJ1tCNxKznJGDjMX0jboIEQtjitVU5bPv4RBziH2b8I0mqda/ueNpMMRD9A+XIUd9/PBAsk9p4N1V5yHMUFMfa01c+iMjcPVoaizZ1Re9G5XLHr7jFQt3ZVfb8MVBnAMN6AOxqpyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XyQX35Xa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i1YzWGs3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ILMbGH005254;
	Tue, 18 Feb 2025 21:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=dPgI/vAKQUlWDnxmVp
	ZvX69I3d0gqUjU2lF7okk5oR4=; b=XyQX35Xa8/PnWUS3Fj6wI8U02TwakNsk6a
	38ccO45M6NkyJd8OqxvofFtg1vPojvyIOd6CUy9wcg2gnXUmxBUvO/WIkcYPhLbM
	c5LopIM5CPDL7nUeyEfjOUwGRL75//IiWEknKSH3shXbo2k1mx+blsmR6uQiu82Q
	ePjoUo7mqocNXcQvPi3c7K08XMoNpjNqlHj17ajwo2DV83Seprt4f+pqLxBo9jQz
	NGsEcGGvwUKpdCSiO7fmDyAPhDGGBZBROAK5UH2L8xYJIyCFFduSoVvGmRKFFqGG
	56lirRMoDpRNLCz9pNJlvUPWjoVNVAgIwYsh8G1EtzcUwn2QogNQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00ngb8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 21:45:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IL223K010465;
	Tue, 18 Feb 2025 21:45:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w07cnf0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 21:45:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5BxatRGMY5gFFYqMp+g5yV042W63kt26ZWoFZQi5eXYU8Jhbbgpy2UkfnFBxlVacsmSIebnFsc+y7JBXSIcJOji6xyGXM0MtY4WlD7WWo6Orthmp7swtxpWllyrSKzwuvpI6DsUt4dgzoUAvnS3UhDtBPBUfgKSNh4dvudi2hUzxuEaFWK1OZPzIKTA0My4SSPaOiIveSeL6N5AMBeqX1t3KSezdaAaErw50qsIMqYIaxYAhBDMruUy5OyxLYwRdyTq7NzPFKIEhs7uoiIsFQPbY2gguk/lz15EmpxoWbP6BSRy/Ap6gZ9sxzPO/aeu1WhDT5TFoUfVpZdaYzYeTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPgI/vAKQUlWDnxmVpZvX69I3d0gqUjU2lF7okk5oR4=;
 b=bG6PpSxQ9QWr430OZtqm9lggTqmaH5c1RLCS0za9PpLO0VZjVpO/kYWg3EUVTdxsQQ2SCBSA38efsC+nJCKQKV/F7o4/RSsTlXA8cr3o69kiETxf21x9CziHbLcUxydhrumsj9RLsUBM5z1Xhr+t7nSI6ufjV3HkotACGFGHi40jc8qa7NHrAcMpNiDtRro8RkFOdqYLMYTLa4vxspA6e1+VXFRtVHMcx4Cf03ktLBvi0XCLz9EMgJu3LfrWCd1IdX/IhPFFg7BX5INK+4dvwkipslbmB7tGUEDi/JkaX1MnwGmLOM+b5mHq9+JbC/nlNYXQiixk07WZadIGk8AuPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPgI/vAKQUlWDnxmVpZvX69I3d0gqUjU2lF7okk5oR4=;
 b=i1YzWGs3v6WpuPitddw6gNXwvvPHVzaf3tk+Ux5ErY0pOwghr9yoE0Nlo2UzsU3CkseIfUqFLQQ7EPvQPwYavpqgAXsyLfmfJMmkDUXdS4umn7x/QOBcCV3Tlzv+a8TqsWSHm+FvxgDm+NMcU18HXW0rIbhNktpUdWaVZEYuEIs=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5111.namprd10.prod.outlook.com (2603:10b6:408:123::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 21:44:59 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%2]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 21:44:59 +0000
References: <20250203214911.898276-1-ankur.a.arora@oracle.com>
 <20250203214911.898276-5-ankur.a.arora@oracle.com>
 <3b0de6589cb4f1b8bdc87b53fc7ff61a35659941.camel@amazon.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: "Okanovic, Haris" <harisokn@amazon.com>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org"
 <linux-arch@vger.kernel.org>,
        "ankur.a.arora@oracle.com"
 <ankur.a.arora@oracle.com>,
        "cl@gentwo.org" <cl@gentwo.org>,
        "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "memxor@gmail.com"
 <memxor@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "konrad.wilk@oracle.com"
 <konrad.wilk@oracle.com>,
        "zhenglifeng1@huawei.com"
 <zhenglifeng1@huawei.com>,
        "boris.ostrovsky@oracle.com"
 <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 4/4] arm64: barrier: Add smp_cond_load_acquire_timewait()
In-reply-to: <3b0de6589cb4f1b8bdc87b53fc7ff61a35659941.camel@amazon.com>
Date: Tue, 18 Feb 2025 13:44:57 -0800
Message-ID: <87frkb2ahy.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0307.namprd03.prod.outlook.com
 (2603:10b6:303:dd::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b3cf66-ef2c-4988-0610-08dd50657dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TwPis3kQptwyfishq9T/CZUT15GR6ibbRIiVl2dGRfdM79oWDyuYs1SdKxoU?=
 =?us-ascii?Q?eU4LC7PH7B0DMKGIzU9ptiQrixsuIkAZnJIhQMUYh82bx8I0CVeAsIhYCxHk?=
 =?us-ascii?Q?z/NOsp3r1310yfDs3aGAV2Vvf9w744hOe+ls7JP/CklfHnjKq8mhZlf0CKhu?=
 =?us-ascii?Q?d9aLkdlM0sGh7HCpyPgA9ZofrS8E8vn8zftGxmq/iVFaXupeQ2/o24P52qrY?=
 =?us-ascii?Q?SWTH+FM2xYoSu3nkxF5nTXzS5UvXbePdUL73clyM+QvPfRZwknG7ozKyhN/T?=
 =?us-ascii?Q?cqQ/JI0lNDyoigz2hbUPnbj7pI/h0JLx+GNr5NCP+gCIiRIsoxTmpMqBNjzy?=
 =?us-ascii?Q?SkJGyAH6rC/yFCrwZpFwIIBDkPfIdtCxNZkm0lI8acCojZW/dg+IV8ASUGwA?=
 =?us-ascii?Q?b0vJgVY25+V+w4mymMC4cuUQeKhwqlf29ioraOfuttGaO/O/3GUohwUertno?=
 =?us-ascii?Q?Ei2vkZfQJUP0Mp7Rb9O/MAdfN5HXrqSabFGfLHgGxstE61Ukn1skmzCfbg0h?=
 =?us-ascii?Q?qfyai3rV50HDlFiu0++ftIjTcebx9VKsDIl9ofcZa2byHU0elPPsLTDVYJDA?=
 =?us-ascii?Q?vOWWFTULKCr2U0p8dsR3pgz2M0JeZ+ASSenFG5SFFo/eecDjyQLoAtH1yR/k?=
 =?us-ascii?Q?283ijsuLl6Pie3ywE7nIUpde/qMm2T6+iY7XpPnDCiG6gtVxZT/MHCIfBoFk?=
 =?us-ascii?Q?VeynLo9pLoHQ0ZcARH9US0cfKjKbs2OEtAd3ikztZsvjyfjRO9EmEuRbHOAb?=
 =?us-ascii?Q?6Htk09Z4a1ak+5M7Uxur9TvfQFHPuRV7HJLTRcdqcVTYVrN6eKwJg6IUuQra?=
 =?us-ascii?Q?afZ8LXA1o4AYz3f/4Z5g8Wvfl1MizcucpMRNOxg+tHmVes/UoYNJp5NDaDzx?=
 =?us-ascii?Q?ZatoYsGpVlClm8XfQW/9+4IlTBwGkTFwlchV80CgsaflSjj0N4tfUK8zyuj6?=
 =?us-ascii?Q?i3okOx8W4zFLUNI6/hXvg+KTtFfLMV5xbm3T8uTk3kBbCgluS+6LIQJeGahc?=
 =?us-ascii?Q?mVbY92DQzdCTEVj/aUcrYnBLmelQey+OdDmxIF1YvCUbvDPhfHd+Cr9AwTb0?=
 =?us-ascii?Q?6IZAUzXphytTBga6akHZpRVx6t5UGHiyFBsxhYJQZWqk5mX3bLmBvv0DIb4+?=
 =?us-ascii?Q?hcwCDNqSxTItmTVpF7SwVaBeXB865Zutx57BZrJP3hfD9EcVuR2c7j9FmUTF?=
 =?us-ascii?Q?G9q9IR2NBYhyj+l4bVofrG0RDjvpSAXYNnHYA+iOAffRwiYIoarb5ZX/i5P8?=
 =?us-ascii?Q?7f9HPQwerkEBV6XmkoK3zeOIdQ0V6pfe5lt/xzAcSyVt0ycjv0ehqhoG5cgd?=
 =?us-ascii?Q?igJX5ndUaB3+/IML/XDZm39rRMafFNx5YUOOS9Z7//CBIVwUXKijsFITzxed?=
 =?us-ascii?Q?ZMG+splnhp0W2UqsUXNPLqzGbqcE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TeURbuF8698tMg304w8HsokPFeBnoBgMRF6WmWlTUEDndZlYcJoZWQZ1/9Qm?=
 =?us-ascii?Q?coZv1vAdTescY6W3JK5kMT7RHq9Y6R/391DsehYE9PF/1muvYJrt9EYiaFYk?=
 =?us-ascii?Q?fbQYns1xyCytvjXkqyztLzuV1EYvDVXlxon7iO5BgQAS83RSaMpW9DOwPCl6?=
 =?us-ascii?Q?VOJYjJ+GdgKQ68ZMQiCjOOvThUwn959INDWUED4yXF6zkcgZsjwf9o9aUh5U?=
 =?us-ascii?Q?X2r+i9PELoSZ0US7U3yQ9i0At0FUZgHioAo1q0a7EzNXyREOv3naVQfN1ChQ?=
 =?us-ascii?Q?0jb6sFKmjNGUOXlzzAR3wklJH69pjXxZfS4LCgm/j8qJ0boatFxcZysWVCBh?=
 =?us-ascii?Q?ANbo+wADX+CvRRNKj2PgIs5BfRjmVUvQ3xtlctWJ19lZh8zrkjOYm9wBOilg?=
 =?us-ascii?Q?lvZ9ar5W7dr9HtDDGx6wqCNZWuAbXUgoJNzpptTybIVYmxGkkeJQV2C6m4cB?=
 =?us-ascii?Q?q9wIQ/vTO5kta5Us2wh1J0WReCrFukaa0gdpNXTJVQ+8xHRVaBZjW0WUHCb5?=
 =?us-ascii?Q?7o22GQT9NofR7SpCwBb/YvoOnv4+aizymFUyUzIzAITqPyVvoweNdjLJ7X/G?=
 =?us-ascii?Q?O09JdB7uZsmOYdgj9r7ayuJHXj6zemI25mHprDUf0xOPUauSBc2Bp+mVnBFO?=
 =?us-ascii?Q?q0eA7tI3LimMn8ecd3paF6zQl9OXolA5Gjt92zk0O7HVX0Tn4iYZkLplzvqf?=
 =?us-ascii?Q?OsSTg7/JkEPaUroLhY3nVl3eY42UF0uatsIm0kebwXmHNiwd7I6thMxplcmn?=
 =?us-ascii?Q?/GegjxJ94x5bpER/Wt0xh1o7oW9M8mLuauaVbhheS0WfeLrJAquzsAt35E/k?=
 =?us-ascii?Q?Z//75oK25VBEDiYMHilFKHWlZ8zYu6U+9Wds0Xoj7ljFo8VNT53s48wTFNcZ?=
 =?us-ascii?Q?V6RGMxXJBi9dFTpQt+0GauEdu2oR6dVxkgj+1CUSnSmkaXS4CFqRBaoDUn8J?=
 =?us-ascii?Q?XqM6DuJttm6Lvqq7k5fXK2YP0QEV3soA9SNisnC0gR5REFLB2d61B3AGiuIk?=
 =?us-ascii?Q?orOg4AzqzT4vz2Sp/IhoudDfrv6P4lgJVmsPHnIMM2DruVQmsQ4QOM3CWwvL?=
 =?us-ascii?Q?pAFcRowicnxy9rRv2QU1a5sRHHUHcPU029W6/rU+dY/Ser4sx924GwOA9L89?=
 =?us-ascii?Q?C/NV/y490VJRcMsKiwWNEDAzUJpd69/W+PSYYxy/yMu9cE0/MsdGE1/aqExM?=
 =?us-ascii?Q?Pei7TR1Y6xVpXKovI6pIjRvh6fnTFmZADrjDKInrG2j41m5IeLI+mIxZgTK3?=
 =?us-ascii?Q?3zsTI223SK+luJHRGnBZdv7xJXoqzMXZa4uES0sTy0AfEPt0FupeIGz4Lmwb?=
 =?us-ascii?Q?IGBCM2B3Vs1tDaUPpvpswasjfArMkMxRbaj/xnSPo+2hZwTLGtCfb2LlvM2g?=
 =?us-ascii?Q?VXkIDviqJLa/jAbUDtzAtoc2+hP6MyJH2kEEwKazFHsSIS6Q5dplIjxYCGxb?=
 =?us-ascii?Q?KJ6uZbsOsRWK49fuJLEMNc/mxk1N2OkSquiyXEwRylUJXDUgLySr3Vy2uPeT?=
 =?us-ascii?Q?tCU5XToVihKHRP2qHWYTzRK03LprrlV1kZ7JCULOAfVj7JxrcS2slooExTWp?=
 =?us-ascii?Q?TSRZLpLHTv0tEnIJiUtvk/EuuuyEUEDZTmw/FdPHw6i6Guct7+kKTjSX+Xoh?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2hEtOafwSjqi8x1l85jbXGu1lwcjoQqdyBiQGXi+ziFiNMwCoyD7V6fZDt9fx5XdGbHxf6ldCNOVvw7wOLlpAJp+uesPJGW5fHz3WCTCiEa93yLHU3M81gHWYhLY0m1cAr1sIfjwyQm8Su76fSyP56T26fDpIpSb9vzA+lgTL+zYCMHVgPTOIS2hQFAuoqyI4tFcS1wbGVfrUh5bzI9X6+5N2itDuYwF3UIdCYZsudOIsVvxV5Bc4A54eSr2X1OJqDjuKV3fzwdrHDasGaYS0b6qOkXcm9JBmOaLHKi3O96XMpnL46Xw8j8Y32qf1m/aQHKfw9tpcPW0jfUvfPVV3NJKf7PgITcauNN5iihChUn2ToPtILz1TjHFkwXiWtfyAdzQx4VOwZBY/jV/ESAIg+hV2x/1m9+eSEZ3u9KkG7+BAqfVQm4nRj8tcDQOdWV16OvURMZKrJQ5BtkRUgkRhYAZQggbc9Ot5Djwl5T38h/2YqnDNomD2zDzIng1g0ETu64v/dGCL+iYhs6BDFeqFlsCrHLuE2ggcnNZHiohbG5Q0qugRqiFwLjoL9a2OAmkTfvk8xhfO1zqZgobR1VyYOZ3U0uLaC9Y3Z/3RXnksjM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b3cf66-ef2c-4988-0610-08dd50657dc4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 21:44:58.9534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 172dEk4rEi0wq85+ydxBkMGp+Hh75XFcfSA3G+VqroedHEB1tfk4pBiv3oISXEQnDQseT7vOCLYIA1sfPUQ01zrEqD8+svyAfI7eU502JcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5111
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_10,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502180140
X-Proofpoint-ORIG-GUID: FMctXvD0CEz9Xv_GTta-IqY2hkp6p3G5
X-Proofpoint-GUID: FMctXvD0CEz9Xv_GTta-IqY2hkp6p3G5


Okanovic, Haris <harisokn@amazon.com> writes:

> On Mon, 2025-02-03 at 13:49 -0800, Ankur Arora wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>
>>
>>
>> Add smp_cond_load_acquire_timewait(). This is substantially similar
>> to smp_cond_load_acquire() where we use a load-acquire in the loop
>> and avoid an smp_rmb() later.
>>
>> To handle the unlikely case of the event-stream being unavailable,
>> keep the implementation simple by falling back to the generic
>> __smp_cond_load_relaxed_spinwait() with an smp_rmb() to follow
>> (via smp_acquire__after_ctrl_dep().)
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  arch/arm64/include/asm/barrier.h | 36 ++++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
>> index 25721275a5a2..22d9291aee8d 100644
>> --- a/arch/arm64/include/asm/barrier.h
>> +++ b/arch/arm64/include/asm/barrier.h
>> @@ -232,6 +232,22 @@ do {                                                                       \
>>         (typeof(*ptr))VAL;                                              \
>>  })
>>
>> +#define __smp_cond_load_acquire_timewait(ptr, cond_expr,               \
>> +                                        time_expr_ns, time_limit_ns)   \
>> +({                                                                     \
>> +       typeof(ptr) __PTR = (ptr);                                      \
>> +       __unqual_scalar_typeof(*ptr) VAL;                               \
>> +       for (;;) {                                                      \
>> +               VAL = smp_load_acquire(__PTR);                          \
>> +               if (cond_expr)                                          \
>> +                       break;                                          \
>> +               __cmpwait_relaxed(__PTR, VAL);                          \
>> +               if ((time_expr_ns) >= (time_limit_ns))                  \
>> +                       break;                                          \
>> +       }                                                               \
>> +       (typeof(*ptr))VAL;                                              \
>> +})
>> +
>>  /*
>>   * For the unlikely case that the event-stream is unavailable,
>>   * ward off the possibility of waiting forever by falling back
>> @@ -254,6 +270,26 @@ do {                                                                       \
>>         (typeof(*ptr))_val;                                             \
>>  })
>>
>> +#define smp_cond_load_acquire_timewait(ptr, cond_expr,                 \
>> +                                     time_expr_ns, time_limit_ns)      \
>> +({                                                                     \
>> +       __unqual_scalar_typeof(*ptr) _val;                              \
>> +       int __wfe = arch_timer_evtstrm_available();                     \
>> +                                                                       \
>> +       if (likely(__wfe)) {                                            \
>> +               _val = __smp_cond_load_acquire_timewait(ptr, cond_expr, \
>> +                                                       time_expr_ns,   \
>> +                                                       time_limit_ns); \
>> +       } else {                                                        \
>> +               _val = __smp_cond_load_relaxed_spinwait(ptr, cond_expr, \
>> +                                                       time_expr_ns,   \
>> +                                                       time_limit_ns); \
>> +               smp_acquire__after_ctrl_dep();                          \
>> +       }                                                               \
>> +       (typeof(*ptr))_val;                                             \
>> +})
>> +
>> +
>>  #include <asm-generic/barrier.h>
>>
>>  #endif /* __ASSEMBLY__ */
>> --
>> 2.43.5
>
> Tested both relaxed and acquire variants on AWS Graviton (ARM64
> Neoverse V1) with your V9 haltpoll changes, atop master 128c8f96eb.
>
> Reviewed-by: Haris Okanovic <harisokn@amazon.com>
> Tested-by: Haris Okanovic <harisokn@amazon.com>

That's great. Thanks Haris.

--
ankur

