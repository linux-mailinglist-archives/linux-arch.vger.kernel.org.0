Return-Path: <linux-arch+bounces-12479-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13DFAEAE1D
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 06:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820C356854C
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 04:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB831E766F;
	Fri, 27 Jun 2025 04:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mvJtzdaW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BEjoMbmW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7961D5ADE;
	Fri, 27 Jun 2025 04:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750999755; cv=fail; b=QFnIQ84EDrz8CK5IwbqkAVPtnUpILr56eSh4paHpM15M38fmbQhviwaxQfmY/UzBwuVOO3TWT/HuVcoVYiXRt8LmVsFtxCdEOHdHkALqwDgbPzONnkTrLe/Uq3FVOXoYmZdw5l9uwSnV8qLbPIhDrZb2lBmVY14QwgP9jNdxWL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750999755; c=relaxed/simple;
	bh=pb9cRm/6N8yxWXY2ZELrfAKEXbw/inHKtwZZ33xgzGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G8XaIUXgRcajV3V94ewk2m7519bm1lVSWlABBOtv7FmXeHoFr1AUEFF/XEuU6v6+Fsely+i9CpZOlCHkI41VAo/TlQB1fZ32nwJdWAroyPvga+O0UT6m7a/2ofXM6nrTCl4g7GuM20rl2G638xNQJ7W3VpHhcmlLDKKYtCAr5wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mvJtzdaW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BEjoMbmW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R4MgBG021044;
	Fri, 27 Jun 2025 04:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PIpO2pSryzZzsKv/V49Auip2rc2IAs+jLqNbmVHUypM=; b=
	mvJtzdaWfYZIP0ZLkjQNhDvvgIPsKx7F0vWvylaJNfYJP81q0eumubrbdd8DdpAg
	uU0DiKCnhXOiQaz2Q/hrIWMsrDXSfYFzfqCXznEwABK1LtN7YsBUjynsf6DLydkO
	GWHT1QpqR2AGSBm23CpDTooW5va0BLw1hNbPikO+oPURRB2n2EO+MNVOnVamhpfn
	8IkNldthgRvMSS9POHMqS45W9/m/bBUHDC9ZfB+ULjHHlcbpo/CQ5XVCRtIGxUDb
	3InlOQKgmCWu17YdkpHhokuSHe3YxQYxtqopox0mp3jxOdOU4YmgzyBoKUwnMBVx
	iOQP0DObF6KTHUGba7tWKw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egumt5th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 04:48:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55R3tESd002527;
	Fri, 27 Jun 2025 04:48:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47h0gvt5dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 04:48:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glRf14y1YbARRodIeZ+f2YIuu47Bup3IEMGs2bx/GwmxjmU3ZTBUvh+lZamLy4Lix7GPGM+vdb2XdCnuPeF4r8KTPuNlg9d0isOtorDIjYJ1NDemgiKKjFqnAghPRLVBBDgrsWbD7YlGZdHWT2V+v9jUz7heVypr5v/um2DXzN5ZRiKj1xi5e3kDPT2GKjzC/T6pIyqDZuyEPDYElyXXVk+aQUY7DlsLODOO1jyoGeFNB9tA8FzYALNR22UmHwjStH9xD6PMxStqp6JaYiM3PxSgGvbCG2aO9Ub6wKwpz+RN8sGqHNRFxuc6/d6qB4KIOZadkv6qt4AaZ/QgSErI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIpO2pSryzZzsKv/V49Auip2rc2IAs+jLqNbmVHUypM=;
 b=oZpHD+DqYZ7OVzPahODLk67e9nxnkHVwMCJ6EMZDQBedH2DiejpJZllz425eVEzevmLY9B18SoV0vum8njTtjF4rhvisNQaF16pQ+6jxYJjokyLTjU1eKHQqaO2J0CG+xEV2+bJsjDPGaqUbHDZhneJOOnbGd/S+D13qkkG9k96kU7PodJNcstuj9NHaSiJlSXJUCJtbhNdRFGdum4dkQ4REsAlh+k/HYnE4A9H6q+1OzkbMx5rpPm8SdJuRf+hHaHE264eRNO3YLWrJ7gAZITVbc+W3gie6Grr+7H06vuciANu2eZ0bqUiy1/JwBh+UyvYuBd7BDxlzyBbIeU0Uxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIpO2pSryzZzsKv/V49Auip2rc2IAs+jLqNbmVHUypM=;
 b=BEjoMbmWiGS75HA+0sD8v2kfh1Tlo7l746KBZrkgBOy1X0xL9/kXNT6wYR1ZhPo1c4ZFQvoToMF+3oHEZzaARp+VWiWjzG5F0L5HPJe8+klhrQWUqtaEfqM78r/5yor4dJioK8WyJMG0ef/4M8DvfSwOcEjQ21VfgS1l5xHd+WE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6335.namprd10.prod.outlook.com (2603:10b6:510:1b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Fri, 27 Jun
 2025 04:48:08 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 04:48:08 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v3 1/5] asm-generic: barrier: Add smp_cond_load_relaxed_timewait()
Date: Thu, 26 Jun 2025 21:48:01 -0700
Message-Id: <20250627044805.945491-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250627044805.945491-1-ankur.a.arora@oracle.com>
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: c621102a-4767-4fea-afde-08ddb535cfd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fq03rPrl9cH+PuBUHSBvzU7Hf3qY6GqPMCowrhtCIJPVGcp3crJw/OBGiWxu?=
 =?us-ascii?Q?5HPbB5lUJRHqFuGlElQXVSNngJ3/9RazlVZrUaulYbVcfYI6LXokm72UjBam?=
 =?us-ascii?Q?74lmkzXTdoSQ1LaZ1AJ3v64fkLKiEMVN1+lmWP4oLi9ClTGXDv08Nx0H9qUG?=
 =?us-ascii?Q?e9J8hQ3oKNL6xpvu0FNEjws0YIxNuFY1t96KALHjQ26G9lRw0/VI3YBDpdGl?=
 =?us-ascii?Q?v78k4ghVW3CNBpmRalrDX7THAuIQPkrSOqDSwqezv22WebdXb4XokLTqYWhN?=
 =?us-ascii?Q?1ENhS/wSetg3P1ZjRQmysz6jnTr7lv7kY7EFaN3pA40k4Yu0TI0CsnbmRYgi?=
 =?us-ascii?Q?4NSjsmNbAaSCcOFhLubhWwSkYr06CaBqjOUSulBl1C6Vf7ezkJgj6qiuZhyd?=
 =?us-ascii?Q?iXAPZgByLlyFOImsp4g/6qFnSDX5reNWSO+JMBlrrRfeyYVfrbXelw9z55Cd?=
 =?us-ascii?Q?0Vm9EZo0re/ht6C7Zb9mQE1zZwZ0P1016KAYP+CUEPPaG6ZaZuFVLchbJyvW?=
 =?us-ascii?Q?v76ysnqRBeHpOUSZzfEHo3371x0lLdw1ATaj5yGIh47CwAK7/YYNGH+yb+lG?=
 =?us-ascii?Q?JJY5SCuKeqxETbZfMTdlgaq/SzXTH6loTXx1BAb98utTIyNQwixxRumPpca0?=
 =?us-ascii?Q?RhqHL3oNGwYAojpyExuiwmXU5LY8K0mso7SLMVXWOfqVc+Egj9NbQoB9WSsv?=
 =?us-ascii?Q?dw9zSmsAzuMv4O64dPPaNDWTX144tD/x8MgWiE6h+XUMPbpJtfCfPUIEwzel?=
 =?us-ascii?Q?SW/TdgbPFnWP9RGFQwPO+n1RhPoR4+QKfYgGulh2gZkAiR6KZGjFRoZ9Deq4?=
 =?us-ascii?Q?zOGJVfTGlpsyCP+otm1wKgwb18CuKDg1pYxuwrGPXhQvi5+mHxhCGKlehZbC?=
 =?us-ascii?Q?GzvOPGJuk6IVbx7Qyh1h5+czC6JV/mzbtwSTxpz3VwxOBndnHsVIIoou3KtJ?=
 =?us-ascii?Q?skmwY0t/cdv5ogcu+/O//HavQSFSLDn/ylpNuSrv/fW1FKRj9Ma22zy0Ytwy?=
 =?us-ascii?Q?ogr2vZuWsW6C/LVgQJHGINRN7hdaJ0bUbxIioBrhQGryUC2+0BM6gWj95Qzh?=
 =?us-ascii?Q?UuDSKVY34JDpuygZHONCXYXVg/RA9Fiz+0BVWXQRq0MPt4pPYYYMeWBndkIC?=
 =?us-ascii?Q?9N5tXupwo0BQ59ONi9gTVR9L9V+/0OpQ+S+Cq7U2hT+vt9rky18JMN77G5fN?=
 =?us-ascii?Q?Z79qvT+fOQuggw/G9S6MSOHlw0pAMz5we5bT2QBc9L1YAncATdnFq8rMf1hy?=
 =?us-ascii?Q?BwasvVAwfpRV/mRrGTfvHor04GYcFtHXlgfmyXbx4EXA+fZhOqOjt31wOHU8?=
 =?us-ascii?Q?P067MtcG5uCcrTCjEn80NuRvC/wSyuI8DfJSlWN8mA1eSU6483rmZLX3ZAZu?=
 =?us-ascii?Q?ObgDFzvjAQhsfFCkRG8D7ElstkecMwKJFVqTphmQAKlE+cCX/zBqFEs99+qq?=
 =?us-ascii?Q?OUC6qP2c26M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uSPz0TkCzZaVH+ywl/rccjg2222dQBxB6qHyRQMz8AqqK/rWC6l94lMAt93y?=
 =?us-ascii?Q?o/1tuJzsJ5DhpRVyN0EbrqYw4li9MnAMsafTEaBVIR/dC5puGYV189GahLdv?=
 =?us-ascii?Q?T3rdZiZQaybC2TCHMtzUN+43TEMV8ch9NiJmDzwquXQoP+LBB8P2UJRL9ZiQ?=
 =?us-ascii?Q?QISz1vA4IUTWpF4SVfvnGH+S2Kz04XYwsXmybSdCQHbh+e4g0Our28vwzDRR?=
 =?us-ascii?Q?0JLsS+Q8eEfBbwnp22uN16yOoBm/HcVO4B2zD2jCPyZerosoD+pznts7mtkW?=
 =?us-ascii?Q?n/kKwQc9o22l0WFo1nv7sOd/OSQ3ZZ+OJboiBOxX5khA2I7j4vTs6VdclAnr?=
 =?us-ascii?Q?kRI6hPL1k9GbrNfNOd3yWZU3l0PzlejqKZ7aaMdlBMorodXAa1gjlqdt/GR9?=
 =?us-ascii?Q?m4/M+Pr5bQ2WouHDFr542GeeSLXQxJo/g+/A4uAk2vu7DncU00T3YMAuWCSB?=
 =?us-ascii?Q?+NnazKPR/3x9MpL4QdKJ5Hi2QpPlz75vYoLF8w8ejEOjHTPHWXwyl0w6JdXI?=
 =?us-ascii?Q?7wfbLgfL+7XSGu4UQ+qboFA0W9MgsjMdfE0JgIjzZgHj0ksQo/8oZ56isnjk?=
 =?us-ascii?Q?CRtjTootjgDvUJUYHUcyu8mhkw9tPIqd/RVM7OdWx32sYcuGjsKSJRtNCDLM?=
 =?us-ascii?Q?/T1qehGvf1rlti8RHlIAWpYElLUlwoFZ94J/yFHA/1CvbXeNJ8b3kRg0huKy?=
 =?us-ascii?Q?JzPGmmQdRUfeKrv5AAEGR+rOFyQS0H3VnRirWWSU1yq4+sjflvItvystPkBX?=
 =?us-ascii?Q?kUBSzvLAP6FxMqFgmg2VMwbn3UpP7Lf6ACxvZ1KMkq6i5jrVDJAMIkMTgGSx?=
 =?us-ascii?Q?kqHM9Kv14a5TgEAE6lufPu0EOpwQ0swB0/l3AkWMdUlH3mZX4DQP3EPhaeW3?=
 =?us-ascii?Q?VDeEwTqbrxvwrGN7hRRCS7EB2iTKXp9lJmHX6VOeveuQTGOJ2YgTS5NSdxKU?=
 =?us-ascii?Q?UUpBjONiGGS5qDksahtfJsIzuVMfzfe6Q6rR11VQ5EyUhyBeStW0glppAo/H?=
 =?us-ascii?Q?2RI3Q5k82Pxqr8zqhVnND9UTQXZcXqAxt+iYFt1XDTERX2+nms6t9sbRcD/S?=
 =?us-ascii?Q?CMbM77Z/V0/ehRH3aauMAoqjs/PkdP2qgiUyPa0YF/T6jHjD+e3hU87P0XyB?=
 =?us-ascii?Q?UG6Q+8LGbBUc9AmA0Krv9xZJgj27mKN4x20tLQr87qCsEGwxqLoZZIRGSXBk?=
 =?us-ascii?Q?CpJebJTIHnnEfZEFoSsgtFlYH+hBeI8jjE65Mb9F8n3kkk6PmfDDGSlS9cFU?=
 =?us-ascii?Q?CNztng/J3OwdzipV6b6bN8A0pdFH2IhG8f0pRtQAg3cv4XPWq1RS2liH1G+/?=
 =?us-ascii?Q?ZxGgG+/9tB7uqYDoOsoMFFzUC1jdki8lsYF8UuLT3QgMjq04L0Jp9v5XrIVh?=
 =?us-ascii?Q?kgrQS46o3F+tBPVvzr/iI1Nm2vg2VhS9KQDzIsgjXVq2rd7khacLlt9UyJNz?=
 =?us-ascii?Q?FaC9kWMkqgAY3hbtzUKGwJG51A2Dy6lf6dnE3Ok00WyVedb0dKVrEqVl4RQL?=
 =?us-ascii?Q?uXTLmnHnty9cJyy6zFQbVfVqkFMcY5q/6X2RCrgre6wIEHDRM//aZYbHDglB?=
 =?us-ascii?Q?x5LS6W6wx59FhFFrnDqvnNXAraa3Y6EvxXqxzUVaiExaiZnFtnJrdU8yp8Py?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ITYWs9Ymmej4aU4PfLI0gWqc29XrcREgpr7gjoCWZmgyQZaUGEJ+hRCXpbbkmA58DbyIPePSHPVM2EJ7CuIJ6dXO9jRup635vHCq1mQ1+RJkDu6Y1KJ/m/GxxQG1Iw6Z35vtXt8grZQZ7MbcxA+X3RXZmJG4lK5/fkpRRUyCIp5flp9zrhl4Xw9g4hGgewwgOuEXYgG6Ss72hOC26UwlIbo6DH1oIM7XHJGo3UDdEwtWi1eGAeBvOXXcmKEwAJsVs9c3tRdrf+rFC105+7pOszQm7QUO8lyGRMtjeKdP/fMIJKUkYXHWnUdCJ5aHgWkvB2W0QE4aw8WTn/uIgSifNYf49LpRZlgz5LrWwFZOrfYqvChqTpL33jregziNRaqOTsMYCM5eqCIPzl1mTQ7PRTISs3ntYqptUqJj7JdcEH4Z/yAAHZ4VG0AjYCe5tAbJ2UKLKi91xJk8+Cicxuwllxwh9t8tXXSNtgyk5OOn7lE1MIMhTXCdZPRBq+NOlIfvd+P4FFiNhnlQlKNR0sJgCDLAxqKjT6h8wsgrI5STjhi1LikXGAIMuwjhArI8NTQFlwWn/rAmamoDpONBD0ogah8Ez9C92RJnhBmi0WdDCB8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c621102a-4767-4fea-afde-08ddb535cfd6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 04:48:08.3561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9b+Fh1jDSymJZ+sSUL1pxzBSUNujlH/5rvLxHtRW43aB3ZjV4RoWWyt+cOUeBbDnDVIsRBTaP8so66Onz+iBD59lL9mzhDnznwMFq/Hcfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6335
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_01,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506270036
X-Proofpoint-ORIG-GUID: V00hLxSKZySS3p2NZOdCL4qnObNRfrC8
X-Proofpoint-GUID: V00hLxSKZySS3p2NZOdCL4qnObNRfrC8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDAzNiBTYWx0ZWRfX5ydrWpwz2jwy WX5qpRLJ+nM6xEFV1sq7vpsrfLVIiQFG+I/ZP8xpzBMOP9Q+15+myebDE7hnurdnSPyXlG7Jev0 IY5lBppDOzbHktRBHXoTOcADGl5LYVTftUuvx47gRbIG/r+v7RCUkPQSleNNvdDY/N9PK9H+Fc0
 abTKPvbNk5sqL/NxpB0RkdR17HBP7xs673XdXMvrqOEdBhc45MLRuWH4IpVOavFW78KYdSYVuNj zqY9KZdBlo9maz1+YmDiVIJoMTkmUrkk8W2L2PSVLb4rSSB8SURDKinqq4+EdFSmJTcarwpY0Va oNWrkt2vMavneDatCQgNeDsWUpta2WZZwkYWB4TqJnuCi5z0lXOt0YsVUyICgK8bRHVeuxo3MTq
 oKzqq6jJtc/U79aDDwTeR8eZv4lD6aXRgxZfc3af//+tG5EgVvhnlQkw+iFc4rfjXXiym+wv
X-Authority-Analysis: v=2.4 cv=S5rZwJsP c=1 sm=1 tr=0 ts=685e2296 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=u0DmsER8SBkY_eRhmPgA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22

Add smp_cond_load_relaxed_timewait(), which extends
smp_cond_load_relaxed() to allow waiting for a finite duration.

Additional parameters allow for timeout checks and a measure of
how much slack the caller can tolerate in the timeout.

The waiting is done via the usual cpu_relax() spin-wait around the
condition variable with periodic evaluation of the time-check.
And, optionally with architectural primitives that allow for
cheaper mechanisms such as waiting on a cacheline with out-of-band
timeout.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/barrier.h | 95 +++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index d4f581c1e21d..d33c2701c9ee 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -273,6 +273,101 @@ do {									\
 })
 #endif
 
+#ifndef SMP_TIMEWAIT_SPIN_BASE
+#define SMP_TIMEWAIT_SPIN_BASE		16
+#endif
+
+/*
+ * Policy handler that adjusts the number of times we spin or
+ * wait for cacheline to change before evaluating the time-expr.
+ *
+ * The generic version only supports spinning.
+ */
+static inline u64 ___smp_cond_spinwait(u64 now, u64 prev, u64 end,
+				       u32 *spin, bool *wait, u64 slack)
+{
+	if (now >= end)
+		return 0;
+
+	*spin = SMP_TIMEWAIT_SPIN_BASE;
+	*wait = false;
+	return now;
+}
+
+#ifndef __smp_cond_policy
+#define __smp_cond_policy ___smp_cond_spinwait
+#endif
+
+/*
+ * Non-spin primitive that allows waiting for stores to an address,
+ * with support for a timeout. This works in conjunction with an
+ * architecturally defined policy.
+ */
+#ifndef __smp_timewait_store
+#define __smp_timewait_store(ptr, val)	do { } while (0)
+#endif
+
+#ifndef __smp_cond_load_relaxed_timewait
+#define __smp_cond_load_relaxed_timewait(ptr, cond_expr, policy,	\
+					 time_expr, time_end,		\
+					 slack) ({			\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	u32 __n = 0, __spin = SMP_TIMEWAIT_SPIN_BASE;			\
+	u64 __prev = 0, __end = (time_end);				\
+	u64 __slack = slack;						\
+	bool __wait = false;						\
+									\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		cpu_relax();						\
+		if (++__n < __spin)					\
+			continue;					\
+		if (!(__prev = policy((time_expr), __prev, __end,	\
+					  &__spin, &__wait, __slack)))	\
+			break;						\
+		if (__wait)						\
+			__smp_timewait_store(__PTR, VAL);		\
+		__n = 0;						\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+#endif
+
+#define __check_time_types(type, a, b)			\
+		(__same_type(typeof(a), type) &&	\
+		 __same_type(typeof(b), type))
+
+/**
+ * smp_cond_load_relaxed_timewait() - (Spin) wait for cond with no ordering
+ * guarantees until a timeout expires.
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ * @time_expr: monotonic expression that evaluates to the current time
+ * @time_end: end time, compared against time_expr
+ * @slack: how much timer overshoot can the caller tolerate?
+ * Useful for when we go into wait states. A value of 0 indicates a high
+ * tolerance.
+ *
+ * Note that all times (time_expr, time_end, and slack) are in microseconds,
+ * with no mandated precision.
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ */
+#define smp_cond_load_relaxed_timewait(ptr, cond_expr, time_expr,	\
+				       time_end, slack) ({		\
+	__unqual_scalar_typeof(*ptr) _val;				\
+	BUILD_BUG_ON_MSG(!__check_time_types(u64, time_expr, time_end),	\
+			 "incompatible time units");			\
+	_val = __smp_cond_load_relaxed_timewait(ptr, cond_expr,		\
+						__smp_cond_policy,	\
+						time_expr, time_end,	\
+						slack);			\
+	(typeof(*ptr))_val;						\
+})
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.5


