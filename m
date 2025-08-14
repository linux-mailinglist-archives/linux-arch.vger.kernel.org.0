Return-Path: <linux-arch+bounces-13165-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131C7B25DAE
	for <lists+linux-arch@lfdr.de>; Thu, 14 Aug 2025 09:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65097B630B8
	for <lists+linux-arch@lfdr.de>; Thu, 14 Aug 2025 07:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F90726AA93;
	Thu, 14 Aug 2025 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qsnru0mX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mh90KrBE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044025E44E;
	Thu, 14 Aug 2025 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156695; cv=fail; b=uNvYlWq2n68uJdJcL+KA1Rsk86At4yHqpXK6BfHu8X8JGdVRbOYuyIo+zLHPw34DRJDBSaXvgb9mYc2MtZKqHEMJtyHV66kW8vye6fHJct8GQHfOnNfBzE1CniA7qXB7t1FX688tezM+h+sZXrp1YCLLllupltqZznSpt8mDb/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156695; c=relaxed/simple;
	bh=e/wzgEat8xn0yf7jT39jCUMgtQvCD2Nwoi4v1dWNucE=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=GLTA8joh1SDf1bz03kWeTznpoIhuAdLeEnsG6O8zZt5Wz6ca8m9iF4X5lYQ8RjMSjVekxoX0a4fae7W5edg8ymFqcnHVxbF7k/WUfV2u7wvwd5Ovgi7NikFfDMLu0w9MxC3mE47uxvtXWUZhLepYcWY4y8rZQgwIp6XDJYBvFUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qsnru0mX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mh90KrBE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DLu1NV022194;
	Thu, 14 Aug 2025 07:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=OkOd6xrmfu5BeiiICE
	xKo6cNSRGmElKIv808PQz04O8=; b=qsnru0mXyoVoPg42ZURSFwFUWXg6TGGgFY
	w3ANJl5DKjVLXMGgcNBzXLWI/ScweP747DdqgSJyXTO+hEDgw4w8V0jUVSCFIDuC
	B/dAiYN99Bv10cqP8pGsLsYQq25offlQFIE13Riq7JZM4ysbNmPFD0WephxiZ7cT
	OSaNcdmb2V1VZx+daueD3c+U8dXng/Ileo58Ib0eN/bWluY1D/Pg2neC5Y69n3ce
	VDb2RNznyB4m8ey/IWI2k8d2UvCNkjaiudfO4B1vG/r2SpadjG089NP+6DJ2Llie
	zv1LJ4207eXOUTxBFEF0sWz6xKkmx6O7NI38kWHZvmEUM6aapTcQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw45193j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 07:30:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57E7HvGv006444;
	Thu, 14 Aug 2025 07:30:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsc7aha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 07:30:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5OJ4T7Uv5v+niPOQ3QIbpdB8w0Ga2NryHzhMI8YwteKsl9ZFujJG+i9DAKt9KJqB0yWAL/ReI9E52+pxp122srZcK3A77z4ChgSVN05wi1y/hKRLJOnsv/7zc1TFn601PIBWUBDJY84EmZUVtGCfdvtnWW0QHd8dtFq0ulEx+3+TA/wgLsqs2ASRNv7Zzn9b61uTk2zZdHddpmkDnfNLmwQUB0i+46j8fnQuK8XiAzHkiRiD0qlruRysG7i/IbvXQRU/H0Lbopg3Yo6EKydPueS8DmPB4wvLpzsnuekGhr4BNG40c5ZgQowYX0aOZs4+KhwAK854Ro4Lx15l4YECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkOd6xrmfu5BeiiICExKo6cNSRGmElKIv808PQz04O8=;
 b=OOid2HQvmTuV1KeBJe7yUBdf95l3EOrRM4NhVQg40Hi13tbRCTG5EBgU7EMFqVTDYk5Mc+L327ng+0+52WNW/KLYd+mZ2J4OrVN8m6q9B9vvwwJ98Bh6S8ZP/9LIcUYEfbhZwBFo7UT7cR/fYcnOTSge3ys5dBhSy/JHSMUEOV7nwuMXH5Y9f7W4qEIJiNdQ/pic1VGp9vASgGeJrTxbgVMIH6mwh6AlM9Ak89wm78Nvdv6CFi8luDwx+tXlHAFlFU2Tzyxnf4NSC3rj2s6QWWx9Uz0K7b2LGFISPGp2lDRJPGTRTd/ZfZbJbm1u1BZnd73entJliUgsza2bCDhFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkOd6xrmfu5BeiiICExKo6cNSRGmElKIv808PQz04O8=;
 b=mh90KrBEfa0wpXNOmy0wX2uFzv9nBYkaPJZW5lciBJheSj+mDNF63G8qXGCaozOa2NInQS04suvZ/I9/lD+b1Ncs4HXHLwFA/XYUOaYNp55ixDetF+u3QsOHl+TmcltV5M+kaLpQrkj6bDBYD4reQIENtbas8lrussvNWM76xQM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH8PR10MB6291.namprd10.prod.outlook.com (2603:10b6:510:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Thu, 14 Aug
 2025 07:30:38 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9009.018; Thu, 14 Aug 2025
 07:30:37 +0000
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
 <20250627044805.945491-2-ankur.a.arora@oracle.com>
 <aJXWyxzkA3x61fKA@arm.com> <877bz98sqb.fsf@oracle.com>
 <aJy414YufthzC1nv@arm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, rafael@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [PATCH v3 1/5] asm-generic: barrier: Add
 smp_cond_load_relaxed_timewait()
In-reply-to: <aJy414YufthzC1nv@arm.com>
Message-ID: <87bjoi2wdf.fsf@oracle.com>
Date: Thu, 14 Aug 2025 00:30:36 -0700
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:303:b9::21) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH8PR10MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 9829636c-f8d2-4c7a-be7c-08dddb047679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/yfkef8GGjWDbaUEon8MxO+Ya3f6ZrnPgH36gJpbh+OZ630CYc+aauSgySjW?=
 =?us-ascii?Q?kgQChVCAakai7f0yQ3bDa80Lt9eTqSY0xDl1IGtqnsznqaEtAvzctNH/ID+W?=
 =?us-ascii?Q?ennMBy9btpEfq91DZkFA9+RoQ4J/2Z5gUHhSAddNp+xAUgp67m7Y5qbg84Tb?=
 =?us-ascii?Q?u556vyBU+hh1kkHW0PLvEKnL8swyL2A3KklVqUmBN8blcD8yGIJ0Lq5f9KjH?=
 =?us-ascii?Q?tw9m05MKzBFy+zSBw+nmiLRwxrms1QM9XfkEtEsc+ZrIvCTG40+ph7OO5oMg?=
 =?us-ascii?Q?/d3dO0TPmLux6mVTMboJb8BG9oO6Chh9/a8o1KRHvdQBvoecbeazWBLOCGhZ?=
 =?us-ascii?Q?5Py7v4T9gkIbU0fLdTyPqIuITac1R/sInAt2NBeaPeZiWZ1OsJWMvhFQxXZY?=
 =?us-ascii?Q?f4iqNNQsJ3q7Hk9rdEZ0FzOVzj/IqYKU/n0izXSjEpvVvmRlCGX7wNO2u6MA?=
 =?us-ascii?Q?1OmYdTCWPpJln7oV87iU00PfZk9d/h6pVFN9EkIh5qyOMb9/glnn5f9zIGxz?=
 =?us-ascii?Q?F4zFzCfyFnDRLwJb3rXsdvjJNmGBPZ7JRK5KFdHJRCd7f3C7+an3MgDkDkeu?=
 =?us-ascii?Q?9LZx/LCl5F9jSbh83yMKqF5iV/7W8iNHoHjqBmm85p3+8aJSCPcQYe21M5Iy?=
 =?us-ascii?Q?qtBNuQV4+QyquGJSVHW0kZJODR8jQQegJn+GWoZVONufgoPKbM9r+z+4zEhf?=
 =?us-ascii?Q?dfKV9jpq6W1yOxr1aPA87C4CFROXfWnskPIbjopcVDdMNo4vUbXeeeJFoIjj?=
 =?us-ascii?Q?GjfwQVd/0+F/peN01UigD4MfhpL8tbCxNzTn7oP5zfUwON4TEHLZE705zNoh?=
 =?us-ascii?Q?6oZKnDLSNRvIQGvU6+lLDr/ZtwovClE42xuUWrKNoXmhKUtpiNIUY2Hh8JZY?=
 =?us-ascii?Q?f2GIJqWEQ3TXJvvmTyQUBU8uK6mbvDl5jSPM1tKbEYhqO8d4PKBWn7TWKV45?=
 =?us-ascii?Q?HmB8y8ZHyEdUApQx7G0E9h7roGT+ykmwzVEQKAIimMQvvX8kNeGn25l6WFwU?=
 =?us-ascii?Q?emeemySYZ7CoRH77tay8toyyMSA8dYQmxFE5rBQDMoqzFhXAX7x0O+TSPTTP?=
 =?us-ascii?Q?um+kr9c03doYylSWzBGt2o8Iqom1PIACUiNjmfJYLTmAGy7n1tGbMda1uhm7?=
 =?us-ascii?Q?jOh6LDp4fS7evepeibF5aKKF5gBLRRjJRHH2ubux12JmRJY4bTvbRJNVo3F+?=
 =?us-ascii?Q?Uw0EOqbN+d7NZaZYLWH1zOikEaw9jqrnb+eSokynKGasECb2UW1PVRZr3x99?=
 =?us-ascii?Q?l28k7rcjxnM9xlB6loj8jBWURz6wi/zJJ1F+wW6vQdfZWHWNVLNdpaky5pdD?=
 =?us-ascii?Q?Qqb2llypofQQF+0VzDUr0cGJbFCTHg3xSPa5z2dX+pSbYpErhYV3NnWVPWq2?=
 =?us-ascii?Q?DQzsKx09SWq0ktN7rrPHJtz4OsA++l1BEwrMcXmbWUcQFVq6ZoQ1UlPDVtCp?=
 =?us-ascii?Q?6pd8oMQLBU0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6W9UdD2xFqhUZRn3PgR1OZZ4kBznEdhJyq86H/sYM88BIHt6RPb/EUNSHUdW?=
 =?us-ascii?Q?J042/9628WcF+Nq4vEMdnwKJ5KOJthwwmjoLTXB2p+uCaVJ9jcn1v3mN2Rtj?=
 =?us-ascii?Q?S/RG7Cheq1ZCC1NTzoCR3zs0uewWlbwqqVqP9XfNsLd5lswwa3npbiRrUsvn?=
 =?us-ascii?Q?+pye+Ox9b2W8eu2DAYhDFJBWZyuZGD6+Lz5LwRNX5j32S4im2Wd6xsJZ+gto?=
 =?us-ascii?Q?oxU9k0uGUsGWYZwRlxcmHsp1cr77iLY3lRrBG9E0jCquPcER0gGXWTYcJZDF?=
 =?us-ascii?Q?yjQ7QAchZju5tjczGoe22h44UPqojlYZ+Y3sEMDOUXiFqxda+doJ24gtjRo9?=
 =?us-ascii?Q?/KZsio6KSRjjrHDHyH+DpaaAOHUV3LuB3VHHHFBgK8qdTQDScT/HxzvvcYu5?=
 =?us-ascii?Q?Elv5b81wVUzIBbYPn6UeSPVvarlM2okGvN+Gp5COvT82PQUqLjA4u0I6HfxH?=
 =?us-ascii?Q?pweRMVquqbF6DSb27wJyIF1m+JupQ5LwL2pFr1t0mHv0YWF73bk6g8HIiyLs?=
 =?us-ascii?Q?22zDXMt8ZLAgxPB0fs3yPj5P8ZqpoQm/P9gG56cs8ivZiFqsMxnXGBSIkTC8?=
 =?us-ascii?Q?AsnUno41pjtmSLZXnxF1Cj1L7Vag8fyJE06AowT7suz8Zy9QN8ec58kPObm1?=
 =?us-ascii?Q?+9KU/p+kzcAiKUJkGSnz5ND18LaAUmcJ+uvwd5nJ/gFiuczWAkjfWW9py9XL?=
 =?us-ascii?Q?PGj7k2b24L/nlYopmROU3b7mPGL6XoGQbPPwEIgPB0A9EdsEShrSmBHt09v5?=
 =?us-ascii?Q?xXfn3kYT9rd+lfR+kGRXvPAbRdZJRd6FSwgeEOL5DKvnxCOAGOXDEU2jec+R?=
 =?us-ascii?Q?gD1Q649rHw4rf6jzzlooG45ThjNwLGGxGK2yFswZ0fpTlJBdDCIumcTFCHlN?=
 =?us-ascii?Q?jSUminbh/5mERHt9YyfOsP7QlU1gByO6J/3x0koh32POyXSMLMVLC9SNh3QS?=
 =?us-ascii?Q?YDOqqATnxgBo0s3W6KlxYvCeFbq/uPyjtDGLhIc/ga6Py/hVTbnT3tm2MI79?=
 =?us-ascii?Q?jtByBmwc57Bhb198BagW9j0k1FWu/z390x2WHHe/BB/fTxoRa0RS4R+pfW68?=
 =?us-ascii?Q?P51uTYoJ1iFRUwwqfhp14lOktCNOMkjSAz4vR5zuC26ASIjvjNBqcqY7WFIi?=
 =?us-ascii?Q?pkTtSoST++QzXCTb9q4z2gdX3yETOh49PwOw091qrSJwOqxk7y7nSbkB/S1r?=
 =?us-ascii?Q?4D9qU20jia7mywl6PA+5YZmDgQgq0AzA90B/M2kvJLUYR7b21kLU/V/q/RCm?=
 =?us-ascii?Q?m/C6LAFOeI/2EFiuSzLerV9nTw24e3DfTjpH9lSXJo6pEC3rPIjyOTQNTJQ3?=
 =?us-ascii?Q?3AdhRxfuUGJxqt3MSlfOwpiMprZHbOCD4ozCRnxIEqVRz+LWKBvLHQsp6rAH?=
 =?us-ascii?Q?FHlP1fS/4cwocuEzSAPfmDxw39BaYkYmZf652i4Jn+Gmg0ait/BKYUO+3986?=
 =?us-ascii?Q?x7vfYQ4XdnE8+1LD09yqrYCLNg9vfTx+QR2l284JYXTfYF1Zv7NmQeO2mP+B?=
 =?us-ascii?Q?oqNkFPFh84vLpW3jBb9AtxiM66FMXQ3bIqaDYnQGCd/YTdyyeIiT/vl9fEvV?=
 =?us-ascii?Q?EJgD2O6DY6oE4y8wa5gi7H3DITSbk6Gm/P6gtAC47D7kfZ0ctR6GISd4P/KO?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	noXVg182wFgUOmM+AOobT/8nxpfD4bW9NbHlSsxqoxHXEujk3asPH19pdmsbuggbJRUgcY6RtFniYCxzH0OohcvuqWy3/ppGpU1Jr+bIRs2J+4C3JTECKEi+ytcmx04x2r0/fErS6FkNZSzJnylvXsWtbk5Il2fppr5NPwjXZ96nsW+l6dM/7m3LTnZy6x/CghZlg1W2Eqg33mP0YAe81/lBmsPilLaKLIQlVzm8mdSFI5OPicjiK8y7LclDmv0R99i56LicI4ZNZvbs0f4Q3EQSa3xjUSYoptJZTRXy9AnkInPzDObf6DUhqSvi0MGeieoSdZv3CmgbcJXNScejJ4hWzku+l7KIHy2QalWazKSaiJH3KDKj6TkPeQNye8LRcs278KHKOXGYR5Puup/8Lds3efR+lDTWKJSRckcl1axAiSF3ew7K/zfJpRpfgFNLyhq4YmTPZvwSdh4pNh1xmC0LYgCG5KSRrSQdVLht8UjE+hQBVschO/jUs6KR+VgSivUkNNp06/DGlQ98j770TzKGsPXOR6lQyVI8fq2JdG/iwR2Vt3ZxWkrHMKP3tKZtErpDa5lIYVpnjcjUft5W60VU1fP3SvAxitUzPsv+mTA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9829636c-f8d2-4c7a-be7c-08dddb047679
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 07:30:37.7615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKpz+dCElpScm4jQxAr8Nfp32Pl6ntqn/g7QMhrcykM+ekds7k3UpjLvXb9r4Jjw/fXHIGx7wGHv6W6dUyITggj4hdQkv1n2eAABPjm6D8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508140060
X-Proofpoint-ORIG-GUID: FtZTOo68bHNVU1y0xZsoqb2vzZDXaeKH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDA1OSBTYWx0ZWRfX32ZggbAo4Gxh
 nWjn3RDpb0fgYWs0mFjVPhu2cuj/yi2nPOfUnJnPZd6vQZZJC7ptXtTG/t9p40vkxWK0oq7ej9w
 p+otxT+WpqNFYcciUu2Oalbmmau4YnNaeIDllcbDlF9++yAYeSiu9UAEsZuCxEZ8i9LBLmWMc2U
 0DcO8VaAUOp0aWe24FM3AixwRTfeBIPXlBe8w2+ADocqSxDeK9NXWetnKpJtHoA7u0+A9fIOXvA
 /4CtodfEmwS+9oGJF/MmBMkgV2K+KtN5YZ1SNRDgorP3ysMTn8ZjD82EkD+jOimmJTJswjnlifG
 pGAIjDH0cgsRYTWunx4QiOknOt6YtYBL7KxH+eC0ojaDVUU91+pejQlKNaReM1oDczaV6RZAHeG
 7ZpawFFnCkq5TBoaqxfs2uC0onEkVeIgGpl0Qf7iyXz2qEzdYNs+Zgs8UK4XyBgN1RUBrtHx
X-Authority-Analysis: v=2.4 cv=X9FSKHTe c=1 sm=1 tr=0 ts=689d90a3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=a5z2BK_YLcNKshTZ9u0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:13600
X-Proofpoint-GUID: FtZTOo68bHNVU1y0xZsoqb2vzZDXaeKH


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Mon, Aug 11, 2025 at 02:15:56PM -0700, Ankur Arora wrote:
>> Catalin Marinas <catalin.marinas@arm.com> writes:
>> > On Thu, Jun 26, 2025 at 09:48:01PM -0700, Ankur Arora wrote:
>> >> +#ifndef __smp_cond_load_relaxed_timewait
>> >> +#define __smp_cond_load_relaxed_timewait(ptr, cond_expr, policy,	\
>> >> +					 time_expr, time_end,		\
>> >> +					 slack) ({			\
>> >> +	typeof(ptr) __PTR = (ptr);					\
>> >> +	__unqual_scalar_typeof(*ptr) VAL;				\
>> >> +	u32 __n = 0, __spin = SMP_TIMEWAIT_SPIN_BASE;			\
>> >> +	u64 __prev = 0, __end = (time_end);				\
>> >> +	u64 __slack = slack;						\
>> >> +	bool __wait = false;						\
>> >> +									\
>> >> +	for (;;) {							\
>> >> +		VAL = READ_ONCE(*__PTR);				\
>> >> +		if (cond_expr)						\
>> >> +			break;						\
>> >> +		cpu_relax();						\
>> >> +		if (++__n < __spin)					\
>> >> +			continue;					\
>> >> +		if (!(__prev = policy((time_expr), __prev, __end,	\
>> >> +					  &__spin, &__wait, __slack)))	\
>> >> +			break;						\
>> >> +		if (__wait)						\
>> >> +			__smp_timewait_store(__PTR, VAL);		\
>> >> +		__n = 0;						\
>> >> +	}								\
>> >> +	(typeof(*ptr))VAL;						\
>> >> +})
>> >> +#endif
>> >
>> > TBH, this still looks over-engineered to me, especially with the second
>> > patch trying to reduce the spin loops based on the remaining time. Does
>> > any of the current users of this interface need it to get more precise?
>>
>> No, neither of rqspinlock nor poll_idle() really care about precision.
>> And, the slack even in this series is only useful for the waiting
>> implementation.
>
> I pretty much came to the same conclusion. I guess it depends on how we
> implement it. With WFET, the precision depends on the hardware clock.
> For WFE, we could use the 100us event stream only or we could do like
> __delay() and fall back to busy spinning for smaller (or end of)
> intervals.
>
> The spinning variant may have some random slack depending on how long it
> loops before checking the clock.

Yeah. My conclusion too. v2 was taking the slack into account while
spinning. For v3 I got rid of that. And, for v4 the slack goes away
entirely :).

>> > Also I feel the spinning added to poll_idle() is more of an architecture
>> > choice as some CPUs could not cope with local_clock() being called too
>> > frequently.
>>
>> Just on the frequency point -- I think it might be a more general
>> problem that just on specific architectures.
>>
>> Architectures with GENERIC_SCHED_CLOCK could use a multitude of
>> clocksources and from a quick look some of them do iomem reads.
>> (AFAICT GENERIC_SCHED_CLOCK could also be selected by the clocksource
>> itself, so an architecture header might not need to be an arch choice
>> at  all.)
>>
>> Even for something like x86 which doesn't use GENERIC_SCHED_CLOCK,
>> we might be using tsc or jiffies or paravirt-clock all of which would
>> have very different performance characteristics. Or, just using a
>> clock more expensive than local_clock(); rqspinlock uses
>> ktime_get_mono_fast_ns().
>>
>> So, I feel we do need a generic rate limiter.
>
> That's a good point but the rate limiting is highly dependent on the
> architecture, what a CPU does in the loop, how fast a loop iteration is.
>
> That's why I'd keep it hidden in the arch code.

Yeah, this makes sense. However, I would like to keep as much of the
code that does this common.

Currently the spin rate limit is scaled up or down based on the current
spin (or SMP_TIMEWAIT_SPIN_BASE) in the common __smp_cond_spinwait()
which implements a default policy.
SMP_TIMEWAIT_SPIN_BASE can already be chosen by the architecture but
that doesn't allow it any runtime say in the spinning.

I think a good way to handle this might be the same way that the wait
policy is handled. When the architecture handler (__smp_cond_timewait()
on arm64) is used, it should be able to choose both spin and wait and
can feed those back into __smp_cond_spinwait() which can do the scaling
based on that.

>> > The above generic implementation takes a spin into
>> > consideration even if an arch implementation doesn't need it (e.g. WFET
>> > or WFE). Yes, the arch policy could set a spin of 0 but it feels overly
>> > complicated for the generic implementation.
>>
>> Agree with the last point. My thought was that it might be okay to always
>> optimistically spin a little, just because WFE*/MWAITX etc might (?)
>> have a entry/exit cost even when the wakeup is immediate.
>
> They key is whether the cost is more expensive than some spinning. On
> arm64, cpu_relax() doesn't do anything, so WFE is not any worse even if
> it exits immediately (e.g. a SEVL+WFE loop). The only benefit would be
> if the cost of local_clock() is more expensive than some busy spinning.
> The arch code is better placed to know what kind of spinning is best.

Yeah, that's a good point.

>> Though the code is wrong in that it always waits right after evaluating
>> the policy. I should have done something like this instead:
>>
>> +#define __smp_cond_load_relaxed_timewait(ptr, cond_expr, policy,       \
>> +                                        time_expr, time_end,           \
>> +                                        slack) ({                      \
>> +       typeof(ptr) __PTR = (ptr);                                      \
>> +       __unqual_scalar_typeof(*ptr) VAL;                               \
>> +       u32 __n = 0, __spin = SMP_TIMEWAIT_SPIN_BASE;                   \
>> +       u64 __prev = 0, __end = (time_end);                             \
>> +       u64 __slack = slack;                                            \
>> +       bool __wait = false;                                            \
>> +                                                                       \
>> +       for (;;) {                                                      \
>> +               VAL = READ_ONCE(*__PTR);                                \
>> +               if (cond_expr)                                          \
>> +                       break;                                          \
>> +               cpu_relax();                                            \
>> +               if (++__n < __spin)                                     \
>> +                       continue;                                       \
>> +               if (__wait)                                             \
>> +                       __smp_timewait_store(__PTR, VAL);               \
>> +               if (!(__prev = policy((time_expr), __prev, __end,       \
>> +                                         &__spin, &__wait, __slack)))  \
>> +                       break;                                          \
>> +               __n = 0;                                                \
>> +       }                                                               \
>> +       (typeof(*ptr))VAL;                                              \
>> +})
>
> I think both variants work just fine. The original one made more sense
> with waiting immediately after the policy decided that it is needed.
> With the above, you go through the loop one more time before detecting
> __wait == true.

Yeah you are right. This version evaluates the time-check unnecessarily
even in the exit path.

> I thought the current __smp_cond_load_acquire_timewait() is not doing
> the right thing but it does check cond_expr immediately after exiting
> __cmpwait_relaxed() (if no timeout), so no unnecessary waiting.
>
>> >> +#define __check_time_types(type, a, b)			\
>> >> +		(__same_type(typeof(a), type) &&	\
>> >> +		 __same_type(typeof(b), type))
>> >> +
>> >> +/**
>> >> + * smp_cond_load_relaxed_timewait() - (Spin) wait for cond with no ordering
>> >> + * guarantees until a timeout expires.
>> >> + * @ptr: pointer to the variable to wait on
>> >> + * @cond: boolean expression to wait for
>> >> + * @time_expr: monotonic expression that evaluates to the current time
>> >> + * @time_end: end time, compared against time_expr
>> >> + * @slack: how much timer overshoot can the caller tolerate?
>> >> + * Useful for when we go into wait states. A value of 0 indicates a high
>> >> + * tolerance.
>> >> + *
>> >> + * Note that all times (time_expr, time_end, and slack) are in microseconds,
>> >> + * with no mandated precision.
>> >> + *
>> >> + * Equivalent to using READ_ONCE() on the condition variable.
>> >> + */
>> >> +#define smp_cond_load_relaxed_timewait(ptr, cond_expr, time_expr,	\
>> >> +				       time_end, slack) ({		\
>> >> +	__unqual_scalar_typeof(*ptr) _val;				\
>> >> +	BUILD_BUG_ON_MSG(!__check_time_types(u64, time_expr, time_end),	\
>> >> +			 "incompatible time units");			\
>> >> +	_val = __smp_cond_load_relaxed_timewait(ptr, cond_expr,		\
>> >> +						__smp_cond_policy,	\
>> >> +						time_expr, time_end,	\
>> >> +						slack);			\
>> >> +	(typeof(*ptr))_val;						\
>> >> +})
>> >
>> > Looking at the current user of the acquire variant - rqspinlock, it does
>> > not even bother with a time_expr but rather added the time condition to
>> > cond_expr. I don't think it has any "slack" requirements, only that
>> > there's no deadlock eventually.
>>
>> So, that code only uses smp_cond_load_*_timewait() on arm64. Everywhere
>> else it just uses smp_cond_load_acquire() and because it jams both
>> of these interfaces together, it doesn't really use time_expr.
>>
>> But, it needs more extensive rework so all platforms can use
>> __smp_cond_load_acquire_timewait with the deadlock check folded
>> inside its own policy handler.
>
> We can have a generic:
>
> #define smp_cond_load_acquire_timewait(ptr, cond_expr, time_expr) \
> 	smp_cond_load_acquire(ptr, (cond_expr) || (time_expr))
>
> with some big comment that it may deadlock if an architecture does not
> regularly check timer_expr in the absence of a *ptr update.
>
> Alternatively, just define res_smp_cond_load_acquire() in the bpf code
> to take separate cond_expr and time_expr and do an 'or' between them in
> the default implementation.

Yeah, this seems like the way to go. Any cleanups can follow in a separate
series.

>> > About poll_idle(), are there any slack requirement or we get away
>> > without?
>>
>> I don't believe there are any slack requirements. Definitely not for
>> rqspinlock (given that it has a large timeout) and I believe also
>> not for poll_idle() since a timeout delay only leads to a slightly
>> delayed deeper sleep.
>>
>> Question for Rafael, Daniel: With smp_cond_load_relaxed_timewait(), when
>> used in waiting mode instead of via the usual cpu_relax() spin, we
>> could overshoot by an architecturally defined granularity.
>> On arm64, that could be ~100us in the worst case. Do we have hard
>> requirements about timer overshoot in poll_idle()?
>
> I can see a CPUIDLE_POLL_MIN and MAX defined as 10us and 250us
> respectively (for a HZ of 250). Not sure it matters if we overshoot by
> 100us. If it does, we should do like the __delay() implementation with a
> fall-back to a busy loop.

Sounds good to me.

>> > I think we have two ways forward (well, at least):
>> >
>> > 1. Clearly define what time_end is and we won't need a time_expr at all.
>> >    This may work for poll_idle(), not sure about rqspinlock. The
>> >    advantage is that we can drop the 'slack' argument since none of the
>> >    current users seem to need it. The downside is that we need to know
>> >    exactly what this time_end is to convert it to timer cycles for a
>> >    WFET implementation on arm64.
>> >
>> > 2. Drop time_end and only leave time_expr as a bool (we don't care
>> >    whether it uses ns, jiffies or whatever underneath, it's just a
>> >    bool). In this case, we could use a 'slack' argument mostly to make a
>> >    decision on whether we use WFET, WFE or just polling with
>> >    cpu_relax(). For WFET, the wait time would be based on the slack
>> >    value rather than some absolute end time which we won't have.
>> >
>> > I'd go with (2), it looks simpler. Maybe even drop the 'slack' argument
>> > for the time being until we have a clear user. The fallback on arm64
>> > would be from wfe (if event streaming available), wfet with the same
>> > period as the event stream (in the absence of a slack argument) or
>> > cpu_relax().
>>
>> So I like the approach with (2) quite a bit. It'll simplify the time
>> handling quite nicely. And, I think it is also good to drop slack
>> unless there's a use for it.
>>
>> There's just one problem, which is that a notion of time-remaining
>> still seems quite important to me. Without it, it's difficult to know
>> how often to do the time-check etc. I could use an arbitrary
>> parameter, say evaluate time_expr once every N cpu_relax() loops etc
>> but that seems worse than the current approach.
>>
>> So, how about replacing the bool time_expr, with a time_remaining_expr
>> (s32) which evaluates to a fixed time unit (ns).
>
> I'd use ktime_t instead of s32. It is already signed and can represent
> (negative) time deltas. The downside is that we need to use
> ns_to_ktime() etc. for conversion.

Apart from that aspect of it, ktime_t seems ideal.

> However, in the absence of some precision requirement for the potential
> two users of this interface, I think we complicate things unnecessarily.
> The only advantage is if you want to make it future proof, in case we
> ever need more precision.

There's the future proofing aspect but also having time-remaining
simplifies the rate limiting of the time-check because now it can
rate-limit depending on how often the policy handler is called and
the remaining time.

>> This also gives the WFET a clear end time (though it would still need
>> to be converted to timer cycles) but the WFE path could stay simple
>> by allowing an overshoot instead of falling back to polling.
>
> For arm64, both WFE and WFET would be woken up by the event stream
> (which is enabled on all production systems). The only reason to use
> WFET is if you need smaller granularity than the event stream period
> (100us). In this case, we should probably also add a fallback from WFE
> to a busy loop.

What do you think would be a good boundary for transitioning to a busy loop?

Say, we have < 100us left and the event-stream is 100us. We could do
what __delay() does and spin for the remaining time. But given that we
dont' care about precision at least until there's need for it, it seems
to be better to err on the side of saving power.

So, how about switching to busy-looping when we get to event-stream-period/4?
(and note that in a comment block.)

--
ankur

