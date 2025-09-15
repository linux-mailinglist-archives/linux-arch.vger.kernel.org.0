Return-Path: <linux-arch+bounces-13629-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F42B580BB
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 17:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2C437AAD14
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 15:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9769534DCFD;
	Mon, 15 Sep 2025 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bgSaD7T5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AunqQkeG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9210334DCCE;
	Mon, 15 Sep 2025 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950139; cv=fail; b=HPDR5YtiKrk/ggHVyzvWXGB3p3pJaLBhRrBllMc6CCyqXLMitdQPCDmiytnWf9QmTHDaQJE58T3tv3eoQz6ad6kAxYlGyxcTFQ/mh4OlserGHZcvL2OfLMW2jB57LVPM/KU+z5lgwKnWZg04ntsixZ2ArB1pH8GqZFR9XSP/afM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950139; c=relaxed/simple;
	bh=/qm87DjMh3RSxMlS4eUYbPwCYYKAvAY8QnG7Fgtnp4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m5nNSEfpb96vhrvhvAaxmrDJIQJkLUtRcKdeo55tFLol4kvwUrPSVd06+VtDcOZmz4O+k4L1FzoZ+na4elFxD/8PF0/nTc3tJyavEI5NZxWCd6B0fnnU31Z5pTwOZJGI+UZ4mJPAZ8+aXBDBoN3B9iQBGrfLEJVqcmC4OQusx1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bgSaD7T5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AunqQkeG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FFQFJo014233;
	Mon, 15 Sep 2025 15:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Cx8pWw0OqWnNUyuHk7
	6IwcNaxLKNF89ROhMKzVPbxaM=; b=bgSaD7T5BYT91URVt9fysKHMJbrVu9yfDg
	6S+0jT7l481dacc8H8Tjk8msIaVGGt/WVGeJIoXh/dakNbxkCXi4a2qh4/TwzdGG
	HowI8DpwHYEpO25wGXS8eQFszTR5HUWX1NUM2l9NYvbTHZBAl4h6iROF+TQv6eHN
	UaCm0b13kzycLwCID0+ZH7Net57N8bipxIOWk/E+xGfrIIQKLurVy0L9tlqQ0A4k
	lEjDVHNA6/6d6gq9xFvsRJsChxLLJDZc9+ZPECFLV76P52Axwe/JdoDOo9lgmqZt
	225qthvE1Gb4lpbNOU+ex7dhqpHUne/Q27rHiBJpBlbbJhF+X4jQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494y72tq9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 15:27:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58FEJvrm037410;
	Mon, 15 Sep 2025 15:27:43 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011034.outbound.protection.outlook.com [52.101.57.34])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2hesj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 15:27:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0wpGMWb27+SfJNcd1JIwyeHarcquHxtnhdTczT89mruOwOq7oV9j0SMbOb9BOQR0vz0o3ege7M0HVFv9dsORaqXbjCVnFZeZbkzCjSXluFa6NBEAy6hcl9v0r1Bm4yZbbz5CXqxe2dDVMeVem20QIme9PlpjuIZw5Gm035nQX3dsLkPWQbCwAfxLFlgcOEh+BpQNgC6xAGxpQX/EtMGq5TZM8kO+1yVy7rJahwfaSutvhzC5CLdb0LY507pamaslQF0R/QtJLOsbBqEz+MzVmB6zariQn6kt7/jmb5XtogAMH7WgCZxjYFJC1qyiOj4w19ATiwrX2X0OLKCFqj60A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cx8pWw0OqWnNUyuHk76IwcNaxLKNF89ROhMKzVPbxaM=;
 b=s06wOvhoZuxG+IXrxcBsLhwZJufxI8UHoQALWXze8Hr+dTuThrQFA605wNmHW/5w6yONGXMnFT6JA0cYdLrX0PZ96nHoH2Kis+08iQ0e4qwUzYxNaPYSz6DSmqd0Ib6Vl0+mVYT7faVq9PQUnUFmKbyBLq4EX52/yhY3DJzZ18bf88lqY5U+87XrseISSK1PXdYgCYrSqj0JSgG0X6xDxPJZicR1munV0gqSkVzs+2yeKFE5Y3mJq0g/AmWCp6zOdNLInA3UeTd49XySQPvDUFxzFL7/hN5TKSdqEyfL/4q/vfeHLRJ4IBaChQaGn9VBVo/YtYIIQ0I1CnZ9xDvD1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cx8pWw0OqWnNUyuHk76IwcNaxLKNF89ROhMKzVPbxaM=;
 b=AunqQkeGxdxI6wuMp06hXjZs+R4sQjhT8slIIv2C6XzqXBzMI5YTLAsWh1B6mWzLlCxXvIgoGgj6+oJqfCQv2xzASZ8FHmcAJStvHp2pvkpBAX630zcsvThobFUxbbVySIdbdEIfe5UU9Y978hrztJJIBl4iX9I5CI7ivCPplMs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB6638.namprd10.prod.outlook.com (2603:10b6:806:2b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Mon, 15 Sep
 2025 15:27:40 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 15:27:38 +0000
Date: Mon, 15 Sep 2025 16:27:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, andreyknvl@gmail.com,
        arnd@arndb.de, bp@alien8.de, brauner@kernel.org, bsegall@google.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        dietmar.eggemann@arm.com, ebiederm@xmission.com, hpa@zytor.com,
        jakub.wartak@mailbox.org, jannh@google.com, juri.lelli@redhat.com,
        khalid@kernel.org, liam.howlett@oracle.com, linyongting@bytedance.com,
        luto@kernel.org, markhemm@googlemail.com, maz@kernel.org,
        mhiramat@kernel.org, mgorman@suse.de, mhocko@suse.com,
        mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de,
        osalvador@suse.de, pcc@google.com, peterz@infradead.org,
        pfalcato@suse.de, rostedt@goodmis.org, rppt@kernel.org,
        shakeel.butt@linux.dev, surenb@google.com, tglx@linutronix.de,
        vasily.averin@linux.dev, vbabka@suse.cz, vincent.guittot@linaro.org,
        viro@zeniv.linux.org.uk, vschneid@redhat.com, willy@infradead.org,
        x86@kernel.org, xhao@linux.alibaba.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 13/22] mm/mshare: prepare for page table sharing
 support
Message-ID: <1211d74c-4f1a-4129-aedf-a6d3d53b0089@lucifer.local>
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
 <20250820010415.699353-14-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820010415.699353-14-anthony.yznaga@oracle.com>
X-ClientProxiedBy: LO4P265CA0246.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: fee3eca8-f887-4253-a922-08ddf46c6761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M5cJIb7GRoLjoB0olLkOKHIcAceBhBHl8pldfqpWwhGKu+KucflYjil4vpTo?=
 =?us-ascii?Q?z6LIi1SJ/aKBE2NfSlK1gKyYxGzc8tfSa2Z3oSzgmGmffEGifWqrEvqceHR7?=
 =?us-ascii?Q?3G4QTLc2jgRHOSqkJVuqx26/lCfxRfKCgkllYAS0D0/mkZ1bvA/UJotpdU/8?=
 =?us-ascii?Q?08I4GYtkxQamlHnb8HvutxB4J+GCdHWTsnDD5ev80cr0EXBe2/QBTg7ZIBtg?=
 =?us-ascii?Q?lgBha6bLkAMUZjEkZeYRKrQNe93bHmiWB/+uihYEELkBZHEQPB4YKJ5FKzfr?=
 =?us-ascii?Q?25Hbhvk7Nlic69mrwBBmZFjar+/JgjfaOaKtx6draCiYZqCWCvzCB7m1J3fj?=
 =?us-ascii?Q?t0GCKwR4Os3C+n3ZyHvyWMcOn5wFFUb9DuG6CgfmDGmOdJFmRKS1M5+ZjeMH?=
 =?us-ascii?Q?U85ivD8jwxtOg0FLU4IQ+Fkje714P/iku6aSruYjpn9lfUjN5KudggfdE5EP?=
 =?us-ascii?Q?3+EReehtYc4/S35HqIHdpUp6kQxX151yYzsbRUtWdne8FSqn+uMc3oMh1qLz?=
 =?us-ascii?Q?8+JH2pnlDXPQHeT4/N/g2d4knxUJ12RwQyMerO+lWRfsUVz3InLvDnXH9Ikj?=
 =?us-ascii?Q?bRcq4/f7UtOVijvh2sMOJ10XI+G6doqpUU2bX/L5bFLYSr8wqEnGm0ev3KyN?=
 =?us-ascii?Q?h2tgc3xD4fcRAo2eVld924TWLluQd5LAa1s38DmDI3sXN3U7M66AYUTIQZV7?=
 =?us-ascii?Q?mKdWSyk98aKM4u3E55o7K5vLlmFQLZyIytc6/R+alQPiw02/yaOR3UtwKc5a?=
 =?us-ascii?Q?uCsVCJesLzFOUz3Ipn3cSKuPYdqDfj60TF28vuK4TLvVmnj3WHY1PZCNAcdC?=
 =?us-ascii?Q?9DFZWpAZuy+ccB26vcETtS/WiFcESdKpFAHE/I8EymFpb4yR1nYVr8PMBGxh?=
 =?us-ascii?Q?NRtHVE6K+c018VV0iDpWiIcqKctgE+78pzMe5nmAFC9jbzuufHrBbv7jEQqb?=
 =?us-ascii?Q?MSqSP2WjcWZBMMm9g6g8vYAIy+HCQg6jKB3khZR/pQ5qUvmsvk1D3MlANOvM?=
 =?us-ascii?Q?sN5iZjiX6Y6dUzcASTpX/wtDNxV/YoH175F8yClZ0Nnup7JVMF7I/BaN56pO?=
 =?us-ascii?Q?2DohARqpK5s40mpeNcsQPpwXW+MShhdCTMYbWUq56TVOpEyNlXN/2fbCa/gi?=
 =?us-ascii?Q?nbAvnJy+JdQCxNBNylCa+oMQBDO6BuMP91ahU6v/eerlRXcQjdMvoao2S4SQ?=
 =?us-ascii?Q?+DCordMclN/OtmxBz8ZI8qp9L6UqS5yTidRmZrU6TWbzfOEYZ3wl/xQ/YrGJ?=
 =?us-ascii?Q?sVse6oAWsudDc8ObTyFWWknq3CT3HRtH9MqmMUjMHFVura4/US03XpJu1d8u?=
 =?us-ascii?Q?4qwxWsNZ2UCiX8Pi6wav8rK+6DNwDZq06p+JIItirysr7ensNz/QJidmvtIK?=
 =?us-ascii?Q?LJrfpPF8tzU/lj9pyJD6wKPu8FVtt4rMm+3jrm2Ipdg29sdG8yeC84tNDzLt?=
 =?us-ascii?Q?wmWBPe2po1M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KbCrzo+1FygpQE0+trcDs9tEBS1MPA5mOVHZB9ZrPzX0kPeazCVR0TxXVZUc?=
 =?us-ascii?Q?EDV0S9Onk3hImIzsBag3BuYc9qZgb4tpgbV7pSIVmfTUeY5+gFeyKnUjEbBX?=
 =?us-ascii?Q?wdntbue5LGDfuhduRUbze2eUjUF3ivmgoioY50hpo5sMXhRXwDInhnLdUMgA?=
 =?us-ascii?Q?twh8KplUEqIlBeTsER3eX8NQzfXdbvpKleGITcMw9SsoJ9HJ1DlbzvoZ5sHh?=
 =?us-ascii?Q?GryivkJObvzTyLxJnhKs+n7P6m+FiMedBOviEnB7Qk9/9LRX5kqVRM+uLhTX?=
 =?us-ascii?Q?qalWCqjsGLqiKFT4BG42reVczUc5NlkhVLLARhjp5b8qa/K5WqjML8wA71XQ?=
 =?us-ascii?Q?W+gyu8hUEzj+5pQTgmTTKRt9LcBRJkr0y4D3iVGmwXSKp1TvDTz/YX2SHfhn?=
 =?us-ascii?Q?lkkliVMBt4ymseOFlbWFFY8HfVtX/nOeHnPbkOTd9kYgj1lBq4TmOKJZSo4z?=
 =?us-ascii?Q?rMLPfG/gS6BaS5YZfYJxNgDyMBYBh5OlPpvbAUYEJddNxrvErAZV9b34MzLj?=
 =?us-ascii?Q?9y73Q00if0HCgl4ACyJDveSdAgRWiOwq+KEYdFl9FG+KPcsi+BU2B8i7WdEj?=
 =?us-ascii?Q?U/JgiPs/HRvb/Y8pWsGnbzJRvzSL98WrqhHm0s3IldXRv/oGZjpGtQbvLG7b?=
 =?us-ascii?Q?mYcbbDnwOjPLlsQ+y4bWVniOl2UYzTu1TD/0PI7g2SGVb9WH3Xmunac8aELx?=
 =?us-ascii?Q?elAWMY+6Elru6J9lGIyzAn4F76CX7se8bJXP17dtbbSBVBwdIy7maiJH4Nbm?=
 =?us-ascii?Q?wq/LzONasXg0Q+1DqYAaG6coj1iabViC2WvaL7R2rYDlZY1dnp6ceXLPB2iF?=
 =?us-ascii?Q?UGDfRvk/La2Y1xzH7tHwnx6dFTy9B9SOBnrvfU3bW+tFLA5uDJhe+Masf8ZU?=
 =?us-ascii?Q?V+Iw3a6Y0Nz3h2nCvb1GQCkHOdjgGrtUO0IiS4NOUx+BfxLTW//tTcuMLlGO?=
 =?us-ascii?Q?KZH3yzDY6LE3dfUOf08OGZoCBCsxVx8RwM7H1kCk/oUK4z4LfN72oAAKcBoH?=
 =?us-ascii?Q?j2A1NTnN12s3GvaysPkxcvat70vI5jj7/ZlwXVdFeReVCoehAq5gB6j6BOr9?=
 =?us-ascii?Q?hYcn48L5MdunyzoW/1i+R5zci7Jo9ynWB7KtQqoA7PB76m9UroMqFNQBMSNY?=
 =?us-ascii?Q?XmsQ1NdDXVZxIiycWlSxlrmRLi7e54pNcWBUYt4NqiuwPnbtFxY/u0Z5qe31?=
 =?us-ascii?Q?OeVv+rjPLSDA5Gg0ICD6E7ViMgDoUHp5e/IWd5mlMx5KryOQcjGchk6ZrCNJ?=
 =?us-ascii?Q?hOPIXfzk4GdIqy2fLJ3/zXpa4dRxbt95k54dJlkqcAwWxPvtQStXTtxlz0mo?=
 =?us-ascii?Q?dM/3KQY2PVipl3noqsY6bT7KsxI1/HaV/dc7Laa8hlSsYQxI0nJMEpBiQGwF?=
 =?us-ascii?Q?wPpbU921Iul5g4rs32QS2XOK6ab0jeijTUQFWj3lzlDw0AMiZwqs+Wqihf1A?=
 =?us-ascii?Q?cSJE7yzEuWrxrfnr1Ggy5gJblmcVjOVB0n5foSKHAlv7HHeGmBTJRdbtKjWA?=
 =?us-ascii?Q?llzhqsmn9cWSbcAS+bmzzLVu6bTt7DDdwYTKyW3i+g5Z0vBoKV3TblVHJ1cI?=
 =?us-ascii?Q?u8DPaWEYsS1dwf+hLp/XaceFTFDuTSy9uZdCGYSONu68R/UFDZ49xqnFpTjT?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LlAkWaxqk6mSlfqkjpZWmazq6bAzYFc1QRnn6xl0yIZ2HAfdMcN1i1+nkbGfqDjBsTnvxhz3Sg1IAOD60PN06ViV3upynmALs8gdUYDiJlj1G3Rulks0ISkJYY7iFbb+ueVacOCvZcwxgRg6bIu6MoQoiHoYzXpPdU2xcPYAFrAGE3r3XwtL6PF7QiPfyS98iBuBuJXo/tZAZb3e/zkNmZYO2QkfGy/yXeUHG9OvzhbtsLzj3GVG1Gn1F7WzmuyEAzFQoMr7t3XV+eRUl2gl8wjwls78uQrgnhq3+mY8TK6K595axBs2NYjkRFJ4vsyarWGqV7bGp6UjvBRLEvTh2WCbVKtbfa72XeKYc1reTnQJGir3RJPhXw7QUdjpp2rxP/weNpmDg7cJGmSm9DVmUdtYN9A73yW5TFsWdbc6oEdADfyOGK67iNR8Ey2cohcMIBXQtgD6ST6GNd1aiEEmIN1fa+PH6NOrCRTRrj2Gk/cBAKwm3BpNMKziVLkOWM+QZhu37hFWlfRWG40irqCZZnY1WTxSwNSX6uVBfpQT1bBT2NGYOoD0Rh6Ip8LKeIlzD+8uoSG69evm4I6uYjNxjh35WCr+kkUUgDgow/7tJ68=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee3eca8-f887-4253-a922-08ddf46c6761
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 15:27:38.5468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wf7yMRlHCtMSA5lWp2aMXRjodhlUK2BrR8tPgG/5EfnYz3+jpqZ0UHhdJ+8LsHicqpWI02G1jcBuvENMReacbF7hJEQFmXpur+KqlQmYzvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6638
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509150146
X-Authority-Analysis: v=2.4 cv=F9lXdrhN c=1 sm=1 tr=0 ts=68c83071 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=8yVM5d_fee57hvELVi4A:9 a=CjuIK1q_8ugA:10
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12083
X-Proofpoint-ORIG-GUID: K6ahI1Q7RhPBbRT-0D3xofkG-hO2efeO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxMyBTYWx0ZWRfX9C1AgyCKM1JP
 ZWhmV3jkJqXljS4ySu8rrG1N35cYMg+gsogG8+ZNHObjsy+JvAD7Fi9Sp5Lrg2UOBz5HNMicl+V
 +cTMnho1J1yQgjnGuBGP0ygzCf+M5fP43mhRYjM6zU4jWRDgUILHlFUsBnt1ambwXvpSyrTh9mT
 g5VzS/0B3DwUhXKRjM+xjxJRv/9B6GxYRg1Fo8JFVRuFPDexKzzVBzLqQkJ2DnfQ8VGWaE+0VZy
 ZTrIy/j6kLvEHL3tGbN0Ng9Sa6wH1AxB1EiJvbFNtwBJQI840F5IeVqQUXgdlA90vHsbfOlENAV
 pJ4k2Cg7qL1Ch2XFU4tjLyxCkVU0PcoIN4sz0cxTtwwEjVEkCAdzbxSjzBwDlpLYdCXQ9QhY+c1
 95s9RYpT338eZuyuSjmPp5mSmpCscw==
X-Proofpoint-GUID: K6ahI1Q7RhPBbRT-0D3xofkG-hO2efeO

Note there's some issue with this being applied to either mm-new or mm-unstable.

On Tue, Aug 19, 2025 at 06:04:06PM -0700, Anthony Yznaga wrote:
> From: Khalid Aziz <khalid@kernel.org>
>
> In preparation for enabling the handling of page faults in an mshare
> region provide a way to link an mshare shared page table to a process
> page table and otherwise find the actual vma in order to handle a page
> fault. Implement an unmap_page_range vm_ops function for msharefs VMAs
> to unlink shared page tables when a process exits or an mshare region
> is explicitly unmapped.
>
> Signed-off-by: Khalid Aziz <khalid@kernel.org>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
>  include/linux/mm.h |   6 +++
>  mm/memory.c        |   6 +++
>  mm/mshare.c        | 107 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 119 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c8dfa5c6e7d4..3a8dddb5925a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1009,11 +1009,17 @@ static inline bool vma_is_anon_shmem(struct vm_area_struct *vma) { return false;
>  int vma_is_stack_for_current(struct vm_area_struct *vma);
>
>  #ifdef CONFIG_MSHARE
> +vm_fault_t find_shared_vma(struct vm_area_struct **vma, unsigned long *addrp);
>  static inline bool vma_is_mshare(const struct vm_area_struct *vma)
>  {
>  	return vma->vm_flags & VM_MSHARE;
>  }
>  #else
> +static inline vm_fault_t find_shared_vma(struct vm_area_struct **vma, unsigned long *addrp)
> +{
> +	WARN_ON_ONCE(1);
> +	return VM_FAULT_SIGBUS;
> +}
>  static inline bool vma_is_mshare(const struct vm_area_struct *vma)
>  {
>  	return false;
> diff --git a/mm/memory.c b/mm/memory.c
> index 4e3bb49b95e2..177eb53475cb 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6475,6 +6475,12 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  	if (ret)
>  		goto out;
>
> +	if (unlikely(vma_is_mshare(vma))) {
> +		WARN_ON_ONCE(1);
> +		ret = VM_FAULT_SIGBUS;
> +		goto out;
> +	}
> +
>  	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
>  					    flags & FAULT_FLAG_INSTRUCTION,
>  					    flags & FAULT_FLAG_REMOTE)) {
> diff --git a/mm/mshare.c b/mm/mshare.c
> index be7cae739225..f7b7904f0405 100644
> --- a/mm/mshare.c
> +++ b/mm/mshare.c
> @@ -21,6 +21,8 @@
>  #include <linux/falloc.h>
>  #include <asm/tlbflush.h>
>
> +#include <asm/tlb.h>
> +
>  const unsigned long mshare_align = P4D_SIZE;
>  const unsigned long mshare_base = mshare_align;
>
> @@ -50,6 +52,66 @@ static const struct mmu_notifier_ops mshare_mmu_ops = {
>  	.arch_invalidate_secondary_tlbs = mshare_invalidate_tlbs,
>  };
>
> +static p4d_t *walk_to_p4d(struct mm_struct *mm, unsigned long addr)
> +{
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +
> +	pgd = pgd_offset(mm, addr);
> +	p4d = p4d_alloc(mm, pgd, addr);
> +	if (!p4d)
> +		return NULL;
> +
> +	return p4d;
> +}
> +
> +/* Returns holding the host mm's lock for read.  Caller must release. */
> +vm_fault_t
> +find_shared_vma(struct vm_area_struct **vmap, unsigned long *addrp)
> +{
> +	struct vm_area_struct *vma, *guest = *vmap;
> +	struct mshare_data *m_data = guest->vm_private_data;
> +	struct mm_struct *host_mm = m_data->mm;
> +	unsigned long host_addr;
> +	p4d_t *p4d, *guest_p4d;
> +
> +	mmap_read_lock_nested(host_mm, SINGLE_DEPTH_NESTING);
> +	host_addr = *addrp - guest->vm_start + host_mm->mmap_base;
> +	p4d = walk_to_p4d(host_mm, host_addr);
> +	guest_p4d = walk_to_p4d(guest->vm_mm, *addrp);
> +	if (!p4d_same(*guest_p4d, *p4d)) {
> +		spinlock_t *guest_ptl = &guest->vm_mm->page_table_lock;
> +
> +		spin_lock(guest_ptl);
> +		if (!p4d_same(*guest_p4d, *p4d)) {
> +			pud_t *pud = p4d_pgtable(*p4d);
> +
> +			ptdesc_pud_pts_inc(virt_to_ptdesc(pud));
> +			set_p4d(guest_p4d, *p4d);
> +			spin_unlock(guest_ptl);
> +			mmap_read_unlock(host_mm);
> +			return VM_FAULT_NOPAGE;
> +		}
> +		spin_unlock(guest_ptl);
> +	}
> +
> +	*addrp = host_addr;
> +	vma = find_vma(host_mm, host_addr);
> +
> +	/* XXX: expand stack? */
> +	if (vma && vma->vm_start > host_addr)
> +		vma = NULL;
> +
> +	*vmap = vma;
> +
> +	/*
> +	 * release host mm lock unless a matching vma is found
> +	 */
> +	if (!vma)
> +		mmap_read_unlock(host_mm);
> +	return 0;
> +}
> +
>  static int mshare_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
>  {
>  	return -EINVAL;
> @@ -61,9 +123,54 @@ static int mshare_vm_op_mprotect(struct vm_area_struct *vma, unsigned long start
>  	return -EINVAL;
>  }
>
> +/*
> + * Unlink any shared page tables in the range and ensure TLBs are flushed.
> + * Pages in the mshare region itself are not unmapped.
> + */
> +static void mshare_vm_op_unshare_page_range(struct mmu_gather *tlb,
> +				struct vm_area_struct *vma,
> +				unsigned long addr, unsigned long end,
> +				struct zap_details *details)
> +{
> +	struct mm_struct *mm = vma->vm_mm;
> +	spinlock_t *ptl = &mm->page_table_lock;
> +	unsigned long sz = mshare_align;
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +
> +	WARN_ON(!vma_is_mshare(vma));
> +
> +	tlb_start_vma(tlb, vma);
> +
> +	for (; addr < end ; addr += sz) {
> +		spin_lock(ptl);
> +
> +		pgd = pgd_offset(mm, addr);
> +		if (!pgd_present(*pgd)) {
> +			spin_unlock(ptl);
> +			continue;
> +		}
> +		p4d = p4d_offset(pgd, addr);
> +		if (!p4d_present(*p4d)) {
> +			spin_unlock(ptl);
> +			continue;
> +		}
> +		pud = p4d_pgtable(*p4d);
> +		ptdesc_pud_pts_dec(virt_to_ptdesc(pud));
> +
> +		p4d_clear(p4d);
> +		spin_unlock(ptl);
> +		tlb_flush_p4d_range(tlb, addr, sz);
> +	}
> +
> +	tlb_end_vma(tlb, vma);
> +}
> +
>  static const struct vm_operations_struct msharefs_vm_ops = {
>  	.may_split = mshare_vm_op_split,
>  	.mprotect = mshare_vm_op_mprotect,
> +	.unmap_page_range = mshare_vm_op_unshare_page_range,
>  };
>
>  /*
> --
> 2.47.1
>

