Return-Path: <linux-arch+bounces-11984-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64588ABA77F
	for <lists+linux-arch@lfdr.de>; Sat, 17 May 2025 03:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7981893A3C
	for <lists+linux-arch@lfdr.de>; Sat, 17 May 2025 01:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD0028E3F;
	Sat, 17 May 2025 01:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RV6wrBuv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HOfifccC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA515680;
	Sat, 17 May 2025 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747444630; cv=fail; b=AbrmdPLZKTlmIZPQ3wFKZ1fHzgq9ONiBAr9ROfSy2rKhwTzLEw4XYx9diwF4W3zEZR1Th/+9r/ux4BHJK5zGeln7ddDA/5Q0KPecJJkVmupMbrudWmk39TCemXm0YH2wZi9ioOLidB7i8qeD0KepMr7VnALTTxgdGjhAFSC/x9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747444630; c=relaxed/simple;
	bh=3be2n7pd/0FxRwVNB1W+vc4AvFMQ6I1uPCHDyQFJgG4=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=ob/temAAykMgD9jid+gLzP2WdmpnbvS7Pucp4Y/QpswS7b8IavfztlxbFXR9tzK0J9TAIPGFD8/TiXr31e4uHM8nbtp/eBGX7QZG2EQ5z/CmdbxZ9RJuzBdGTFnFOb00DNxh45pY4ekhPSgmKJKBT9OdmJpuZ5Yjtm2mW5gjoAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RV6wrBuv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HOfifccC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GLfuVm009626;
	Sat, 17 May 2025 01:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9jby0OT4ssS5OWVOOG
	aoBjc/DOg1fStN66C5OBSFYc8=; b=RV6wrBuvQayn5DGhGH/nKDMpCQlzFS/U0e
	j5d+czIpSR7fa+qzODs2ynoTK0hSl6E4ELAyVPvlP/zumL2FypuN9HSiSCwUjX4m
	UNnk6NQdm4i/mm5Da8VEHcxH67sGPzOVy1M1SZPKpdqe2J7xFi5SaDlUY5u9ZwJI
	7J/g65Zo9gAR8T/PFHRSe/jfoH8bAAyb/yay7MaKHlNvueeWktjig1Q2sq/fOvjo
	U7IqAux+P8tOFd/cH9JgDU7V5KHuP+2wiW7V472osrmL7NC6g/AyNRykmvEQZ9Ze
	GR1WWigMQPqMXA3s6xq85ECcvHqxGduhvm8B0DaYberNd4ksGwRw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nre02erh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 May 2025 01:16:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54GN0ClX004339;
	Sat, 17 May 2025 01:16:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mrmfy6w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 May 2025 01:16:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GT07sbhrZXn+ewbUgiWXPFvLQyBzcpXnbmxc2AqSfdQMoh99dsuUDWnUfJYQilORwrVsbC3Iwy0edjb+L1AFOTta4tV8RCCBBOpy9WIRkjXNJ9lT829Iux2AXF57OaqT6zoNBMvWKqAZXV06DEaOBckvTOWhmoQLrpYNpSwT6B7to1BZLrVXi81Bf836b8HZAEX+UaKuNvBCbpkOnf8br5et1LFM5Jrxf6b8W6kvFli0UJOGUgmu2VyGH2VXbq/ZS/9QTQtYWiDMIt6w0/fS2uuRl2CwgmToAjHhJoyEtTJnkuyB8yx3bG/nz4AyZINAgaeIodiPeOAPii3Uo9u7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jby0OT4ssS5OWVOOGaoBjc/DOg1fStN66C5OBSFYc8=;
 b=BcSlFVbZpE8JpCEnab8L5W4XHCfPi7KOFOt8ty9nAoFhmmusurhu3v5wg2WgTB4pD8eHq8I396G142dgWfM9CyezlOFEMYqQzgETkQixM9o7YbEC+c4DwitD+tMu4nJoU3N7VOpeJfxhntywwgJW/bDBL83jv3nfBwNtcIXg+rZBBw9Md00kQK2C96376eiPlrYxhZEJ9D5/rnnXhINV2RGzZfigweYwyHmzHokTYWUW3UJ4UKnsiw/jHK6a1JcuPiY35Nri0rGufy22odBbopWgJop0hX+XgD4qDdYNmOosyXr/Z96jcKg6SGLG+YAwPhjmErluELCcypjFpvrFQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jby0OT4ssS5OWVOOGaoBjc/DOg1fStN66C5OBSFYc8=;
 b=HOfifccCr9pMPjZb3FO4yNCS6TT45tjXA7JJOhrLfX+YzISfb2AyRo4j6LkrZisrIRUb8/n1eJWqlofvf/ATlDr0B8o5OG7EeL8t7ABccDJiFDPsruWjb1vGoq9epf7Muwx5XMfJTD4MXUYSHct5uYuZi5e6V1MaiMdVWwhwuFA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ0PR10MB5645.namprd10.prod.outlook.com (2603:10b6:a03:3e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Sat, 17 May
 2025 01:16:27 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%6]) with mapi id 15.20.8678.028; Sat, 17 May 2025
 01:16:27 +0000
References: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
 <f2f5d09e79539754ced085ed89865787fa668695.camel@amazon.com>
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
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "cl@gentwo.org" <cl@gentwo.org>,
        "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>,
        "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>,
        "peterz@infradead.org"
 <peterz@infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "memxor@gmail.com" <memxor@gmail.com>,
        "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "will@kernel.org" <will@kernel.org>,
        "zhenglifeng1@huawei.com"
 <zhenglifeng1@huawei.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v2 0/7] barrier: introduce smp_cond_load_*_timewait()
In-reply-to: <f2f5d09e79539754ced085ed89865787fa668695.camel@amazon.com>
Date: Fri, 16 May 2025 18:16:26 -0700
Message-ID: <87tt5khw9h.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::30) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ0PR10MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7c4d8a-3753-4140-bd7f-08dd94e07297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?koXEAamlZpmVvYUECJtmo6sbRestFl0ogictScVZZDTmXgEgIUjwPk42C7+l?=
 =?us-ascii?Q?V7i81NH4gz8/0q/fW+EcORah4Y9VyDaqAt+F8yIRoMM4n6b2Cf364y3SZ9PL?=
 =?us-ascii?Q?PbuRhQ4K9+tZTo66PXdJpLGSfd5FSir2RQTBWQan9m8/5zcIr/usI0xx1XZf?=
 =?us-ascii?Q?YGTDK9O6o5B3WIUkIjVwYzkd9GDmW3lTUvHkidBzz0rEhFjBhf5w+b0Y/syo?=
 =?us-ascii?Q?rO2J4KPCFxJl9+Nlc95rtiDc4Yl8PGtc1IS2h0Cwrbbs5KZ4oSl8bNFBG66w?=
 =?us-ascii?Q?D8bmYTj4HhTKacSNntGWXOoEEZlpVpNz2fTmagaBTZXopQH7YeQkrmwT3KiT?=
 =?us-ascii?Q?+RGqABJNrI4ZhazF+h4NVszUjXuLpHB/IKHDmn7oUNWcm1I8vEML3EyerhvY?=
 =?us-ascii?Q?L8vSsLithszYTIoJDBtUFEI0tQsOdHDXNEgvcegkxcN2HthofNbNOM75ec/T?=
 =?us-ascii?Q?iYG2jCZE83a8PVDD1T9a4sryjB5h5BsZ5VA+vkuI2HRZZ6V0f1EsqhQiJKgL?=
 =?us-ascii?Q?ymnGuytFqQTd5EOyeyD5jdolM4Z/lYnLNLRx4CPQyRQ2Oam81w83Q25RVq+d?=
 =?us-ascii?Q?PfgmRciQ68DMVqrRW88bTi2fu65AVq4HUb0415ZDfXURHG976OP1DT/v691d?=
 =?us-ascii?Q?dS+OZbZvDQjeMXnZ2HZfMc225JUqf01oa0AH0IElktqXDwOBnR2mqfba0DeX?=
 =?us-ascii?Q?/4D15h6S5uYmZZUIPb5YYxGec37pKOPWsTf4UDHxCjIkYF4nn4mKWpzBDrkI?=
 =?us-ascii?Q?Z+JmWdksPX5LBA4fxFaU1Qo+F9J8hcCDaXsvsUB56/EGux2XneYN8f1oDOeX?=
 =?us-ascii?Q?+flyhHsjUzkpFjxvDUh9+NUqmIrxIUghAeGpfKZ4Cb+Z7ygE+rJwOEY7s+/p?=
 =?us-ascii?Q?XSV0ZM6Uro32copFl8G+SLDRz9cE4Dy6dJROogETzNZ1vtkW3WkYacj+1MNr?=
 =?us-ascii?Q?Ufq9jl0ohZX3dOEaCd/roSa7cooeKwf9ULIsyYnaHHFKBYutYOlxeFkHleGb?=
 =?us-ascii?Q?l8HbXbnHKOmZqd/ycOGwfAi2cq0odZfc9E3qWXdVcoGfL4MiSjtjCgwa1ml1?=
 =?us-ascii?Q?DzugPHsLZVQ7MtSecpGMSj2lN+TtrxYbtbubg+ozGvn6HKNKXF5mm3P6ZETg?=
 =?us-ascii?Q?yx4NVrv7BnNfmWWhY39ZUYTjHi3frcYf2QZINV6yogOpOCIhFiYsrvMxNd4X?=
 =?us-ascii?Q?I53v6xXS5na03v8fBnXeluaF9PInreV3jor5r3n7bIrI1LfD0p+cRwv+PQK8?=
 =?us-ascii?Q?gSDFg+eqi6PEo9jkxrbE3jwEAH/GyKah8dyrLCCeUSsmgH2M60dl8+eFZrrz?=
 =?us-ascii?Q?gHZ0sbesUKYAxYGudZVXF3hWAJrg/ZPtypGLlDizfVDVIWJVF5S3wsGitLPh?=
 =?us-ascii?Q?gmEt+/A3MzTWGCWli1i5J5JM9CXD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m05ilOqz+pNJSflCiK6kuCFRs5df1yAMkhrxtSAZGpr0TVj7qpxBs4MbQPh7?=
 =?us-ascii?Q?FJzqRJQXR4XLVfRakFlWiuafjJiAuvasDD0mu82KUT6bKMJDL1YS6OXHxGLC?=
 =?us-ascii?Q?LJibd4oWdJ6mCjvmx8qIMmCl1UeWhtUrG8Pyym/oaIniEyu3AE2iq5PphKYW?=
 =?us-ascii?Q?r6YarV9g0nQwNO2iEzZxE7sJk9rwbYUa2BILOXTIRKS6D//OQYkE8NCvV8Wo?=
 =?us-ascii?Q?svNXgDaWAINyaj5FYWB1LzFFEoT8LOtkNQpEBrrY5elgKA1x5LQHJcRnH6LS?=
 =?us-ascii?Q?c3ggxGB1QENxaNOVehPn2PTwVVIbM5/55xocj0Niy+KYiedB328Xulw+Jnku?=
 =?us-ascii?Q?bYflwAJ32Ch0qrBR0SA4KJCF1kaA2Xf7/OEwLY/AM1CFKGqwK75Oiyu0A5i3?=
 =?us-ascii?Q?koRjyX2PkawK2RICSbJXt+WV56jM5GIZhlRTdNf09gaxpfmdE1jIsrWYlVUq?=
 =?us-ascii?Q?kEXKVoV7WHY3AVKQh/fKn04Zpm19+DRguC4vp0IlyL+rr6PhIRUmcncENvm/?=
 =?us-ascii?Q?uspXMNgtd1YOIYiGAra6xxN2rEHJ9BM67IB0fD/29eslcBkyIBIYk8Hy28is?=
 =?us-ascii?Q?2INgurWA79lHp02f4yooaVbYMP3ZXUUBc8nuvTTebd8gLiXNyT968pD6J3Rs?=
 =?us-ascii?Q?V9OBqqKThQkT8GVPzezoMZrKtUU327mMOcgQDoYh0jo7hX7SxELbFsf5e2Os?=
 =?us-ascii?Q?C1ywVSoXCHxP4dZtKHDX4NUUwjSRMUtaHe2W8omnD5HfIOCSSvCIQziKcXDN?=
 =?us-ascii?Q?W6DTmheVdZGnA5oPfO8XhDvZLQDxPaelaednhflUugBLlwG9Je4tYgR7DICy?=
 =?us-ascii?Q?s/uHSPN/2q30OjTAHeUOXba66KPWvAr9x6etzCZ1r2/fzkMXE9J0tRryQ26e?=
 =?us-ascii?Q?pgL8Z/kTiEF+XYk7iJMjItSS7Hri4HkDtgBIn3eeHS2HNFgtpI0NDzCXbHKI?=
 =?us-ascii?Q?a3/9z6TTV/93ePzvwZrK07FkoZu4HZwciCBChMd9ToSv4REv1gxTLqCKRSKN?=
 =?us-ascii?Q?Hi11QXQ6xzQI08o9sZ7fcxzoULtbGAMawaYt6OyPNYnB6tg6vbofuqNB88d1?=
 =?us-ascii?Q?iKgwqPU85cQeiWDQgYKR8KeZyM7gMHQ508BXCjz+NDCxMDYXyOH1cbN8Lai0?=
 =?us-ascii?Q?GB+QuNCFjdJcSAnWFbvmLcodti8pfNXcu2znIZnDL9Km0hp6V0CwRBaDhaAR?=
 =?us-ascii?Q?N2Sm2k7jjcPrGfbql7xTvHnlSddnX4p2qroaFZrx3v+bS/tzDuCKfDvS3QaI?=
 =?us-ascii?Q?2uDBm2hOwMWVwDgUHKxXwhrpAGwGY5yQzMmxyUVk9MWQ/WWg05iwb7sJz2D2?=
 =?us-ascii?Q?ZNcxWOQvKA21QzEjOam1P8HAZvNqk2j4AkpFffPJV7qtWiBLJfbCXaQALCho?=
 =?us-ascii?Q?OpiB+NXihUqRTNSUVyf+dKjiuCil+FkitUJlr3mAiypF9p/HFwOghFnyNGEA?=
 =?us-ascii?Q?CyOGsNgxZwSi6LQS6xc2G0LwWT4ujprhaGeilGu7f4t+Bm/Bh/rljL+1XtBt?=
 =?us-ascii?Q?O41REYTL5vPBVk2p6l1nvM8gPfBmHYEMhM/28knBncvl9BkKEU6E5dkmsQRW?=
 =?us-ascii?Q?6uHkOSgmuYMOmqZ5N9HjZNqQ/SBlJH6oEeMiKy0glM4YDQnaHT19X0gxAUjI?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B726qHlhFxfYqPNdO6ScdfDuQMhIm4TEPOt8KlZ9fIbAGDlWu+MCkOzuDvayhd+iCI3fheABc0+NiEn9ivv7fXVa9dD8Jqpjkd8n4DVT+A/Wko2VhSZM2q51P0FdD7id6VPuooKc2/LYDK3hvySAisI+52pSSWUP4ddVR7t1he1TpNxv6FBlWM1wqW0QFFtjYo0AoFIruRocDUVEx8z6sO6VtSAQUFY9NFPj3vod13xfQFZ7pPX8S+22RVDkCNxEKnYYaHGpBpHl7sHW1y+M9NCxua7na60IyeyDC75evi73xb6TAS71/XsS85tqHlD+6vTKA+u0KboJxiCggAPOjiJHqGBb8hMJz+pcaxWh8Lokt9pJIy1VvijWSE7O8FuWX9DI+ANvnokoxf+FrtvYEEyLp0ucWfVs11rFJi+gc9vDOs3zvodUqNMjMZTY2KgxNi72ekHHo07Kkel56GNPcA54DZs4+/2JIUGdxeMD/hBI9bqjLBFdZDuzBsk+yYAVOAgpUhvffHgfGQmSlNpzWb8NnXmyeshnUeMFEbasVEIJ0FEyY7Vy4eUfEPBTek+6n0fVETn5v7lIw2FsSzA3m9W9SVPGifhTw/ubgid4J7Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7c4d8a-3753-4140-bd7f-08dd94e07297
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2025 01:16:27.6159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjpngyFTA69LMSRGRt9B88orZ2yjatQokpEniz6MrHyG9ljt5pz2aA3Z6Tsa2zk4F9FLj8/vfS1oHtYHG96eG55TkK/p5rxbjMbN3upsQl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-17_01,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505170009
X-Proofpoint-GUID: s2ajQHZlBSb1rj-D8HyR4wjc4azuGIO6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE3MDAxMCBTYWx0ZWRfX8SzrpjOJkZXa 64ZJcqtu7IpOzb7mGj1B/3BP0LG41ODa9pGwTa+ARSxAYIB9Mien31gb5t5vXBjIBTEnF9DIC0H ZAxRR9ctWtLOE/4pdrsk8qEcVzmz7UIN/CHkoY4pRBvei+L6k5Tpeo9zwaS9v/pwEo3P2kGAbuM
 ABR+lO6svsaKxz/yPJkkyU4IEDrz7/k3i4OTxhOJaTEzfmXVRsoRBkDnBHjwg+W77XFCNaLNoJX 5Kfx4IXpOXhXWddxG3xB66D1ZKTPynkZ45pk/J0z2AGm2KBoCPq/DQkkn1HUqY9dBU2S4CbCO12 MBOraf08hJ4KDIRuHa1uCLskEoWJlzSgJ3wiHeOFBB2gapIsCD7r3GRxJR5mQNTibFye1wgt9pb
 rtMrHomwJmh0LMFEvCCFqaUPdUY65cRHxoej3EWfgvPU5ItYpnLw2ojcauN5HSld/NtrPCXd
X-Proofpoint-ORIG-GUID: s2ajQHZlBSb1rj-D8HyR4wjc4azuGIO6
X-Authority-Analysis: v=2.4 cv=O9s5vA9W c=1 sm=1 tr=0 ts=6827e375 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=7CQSdrXTAAAA:8 a=vggBfdFIAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=tmjikwb4cnOYSeYaDCgA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22


Okanovic, Haris <harisokn@amazon.com> writes:

> On Fri, 2025-05-02 at 01:52 -0700, Ankur Arora wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>
>>
>>
>> Hi,
>>
>> This series adds waited variants of the smp_cond_load() primitives:
>> smp_cond_load_relaxed_timewait(), and smp_cond_load_acquire_timewait().
>>
>> There are two known users for these interfaces:
>>
>>  - poll_idle() [1]
>>  - resilient queued spinlocks [2]
>>
>> For both of these cases we want to wait on a condition but also want
>> to terminate the wait based on a timeout.
>>
>> Before describing how v2 implements these interfaces, let me recap the
>> problems in v1 (Catalin outlined most of these in [3]):
>>
>> smp_cond_load_relaxed_spinwait(ptr, cond_expr, time_expr_ns, time_limit_ns)
>> took four arguments, with ptr and cond_expr doing the usual smp_cond_load()
>> things and time_expr_ns and time_limit_ns being used to decide the
>> terminating condition.
>>
>> There were some problems in the timekeeping:
>>
>> 1. How often do we do the (relatively expensive) time-check?
>>
>>    The choice made was once very 200 spin-wait iterations, with each
>>    iteration trying to idle the pipeline by executing cpu_relax().
>>
>>    The choice of 200 was, of course, arbitrary and somewhat meaningless
>>    across architectures. On recent x86, cpu_relax()/PAUSE takes ~20-30
>>    cycles, but on (non-SMT) arm64 cpu_relax()/YIELD is effectively
>>    just a NOP.
>>
>>    Even if each architecture had its own limit, this will also vary
>>    across microarchitectures.
>>
>> 2. On arm64, which can do better than just cpu_relax(), for instance,
>>    by waiting for a store on an address (WFE), the implementation
>>    exclusively used WFE, with the spin-wait only used as a fallback
>>    for when the event-stream was disabled.
>>
>>    One problem with this was that the worst case timeout overshoot
>>    with WFE is ARCH_TIMER_EVT_STREAM_PERIOD_US (100us) and so there's
>>    a vast gulf between that and a potentially much smaller granularity
>>    with the spin-wait versions. In addition the interface provided
>>    no way for the caller to specify or limit the oveshoot.
>>
>> Non-timekeeping issues:
>>
>> 3. The interface was useful for poll_idle() like users but was not
>>    usable if the caller needed to do any work. For instance,
>>    rqspinlock uses it thus:
>>
>>      smp_cond_load_acquire_timewait(v, c, 0, 1)
>>
>>    Here the time-check always evaluates to false and all of the logic
>>    (ex. deadlock checking) is folded into the conditional.
>>
>>
>> With that foundation, the new interface is:
>>
>>    smp_cond_load_relaxed_timewait(ptr, cond_expr, wait_policy,
>>                                          time_expr, time_end)
>>
>> The added parameter, wait_policy provides a mechanism for the caller
>> to apportion time spent spinning or, where supported, in a wait.
>> This is somewhat inspired from the queue_poll() mechanism used
>> with smp_cond_load() in arm-smmu-v3 [4].
>>
>> It addresses (1) by deciding the time-check granularity based on a
>> time interval instead of spinning for a fixed number of iterations.
>>
>> (2) is addressed by the wait_policy allowing for different slack
>> values. The implemented versions of wait_policy allow for a coarse
>> or a fine grained slack. A user defined wait_policy could choose
>> its own wait parameter. This would also address (3).
>>
>>
>> With that, patches 1-5, add the generic and arm64 logic:
>>
>>   "asm-generic: barrier: add smp_cond_load_relaxed_timewait()",
>>   "asm-generic: barrier: add wait_policy handlers"
>>
>>   "arm64: barrier: enable waiting in smp_cond_load_relaxed_timewait()"
>>   "arm64: barrier: add coarse wait for smp_cond_load_relaxed_timewait()"
>>   "arm64: barrier: add fine wait for smp_cond_load_relaxed_timewait()".
>>
>> And, patch 6, adds the acquire variant:
>>
>>   "asm-generic: barrier: add smp_cond_load_acquire_timewait()"
>>
>> And, finally patch 7 lays out how this could be used for rqspinlock:
>>
>>   "bpf: rqspinlock: add rqspinlock policy handler for arm64".
>>
>> Any comments appreciated!
>>
>> Ankur
>>
>>
>> [1] https://lore.kernel.org/lkml/20241107190818.522639-3-ankur.a.arora@oracle.com/
>> [2] Uses the smp_cond_load_acquire_timewait() from v1
>>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/include/asm/rqspinlock.h
>> [3] https://lore.kernel.org/lkml/Z8dRalfxYcJIcLGj@arm.com/
>> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c#n223
>>
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> Cc: linux-arch@vger.kernel.org
>>
>>
>> Ankur Arora (7):
>>   asm-generic: barrier: add smp_cond_load_relaxed_timewait()
>>   asm-generic: barrier: add wait_policy handlers
>>   arm64: barrier: enable waiting in smp_cond_load_relaxed_timewait()
>>   arm64: barrier: add coarse wait for smp_cond_load_relaxed_timewait()
>>   arm64: barrier: add fine wait for smp_cond_load_relaxed_timewait()
>>   asm-generic: barrier: add smp_cond_load_acquire_timewait()
>>   bpf: rqspinlock: add rqspinlock policy handler for arm64
>>
>>  arch/arm64/include/asm/barrier.h    |  82 +++++++++++++++
>>  arch/arm64/include/asm/rqspinlock.h |  96 ++++--------------
>>  include/asm-generic/barrier.h       | 150 ++++++++++++++++++++++++++++
>>  3 files changed, 251 insertions(+), 77 deletions(-)
>>
>> --
>> 2.43.5
>>
>
> Tested on AWS Graviton (ARM64 Neoverse V1) with your V10 haltpoll
> changes, atop master 83a896549f.
>
> Reviewed-by: Haris Okanovic <harisokn@amazon.com>
> Tested-by: Haris Okanovic <harisokn@amazon.com>

Thanks for the review (and the testing)!

--
ankur

