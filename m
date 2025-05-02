Return-Path: <linux-arch+bounces-11810-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 743FDAA7A8D
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 22:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C267B728F
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 20:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573971F540F;
	Fri,  2 May 2025 20:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BIyeHGDQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="us5WdoF7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4F319049A;
	Fri,  2 May 2025 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216350; cv=fail; b=TVKlPYsCT0NPi+7H5zQdV/OlmCdD9HUI+fDvIMxdp54mntw31v/szd4Z70EQj7b3xzFcD/lOBfPSsnhM0l/KHAVPhLfsjxKdd81HPn9xzzZEif0OmYqYlidC2cYZnDOSXs5dqdxSTgfo2uvwnrf1gIvcx2ED88G2IWEoqvQHU+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216350; c=relaxed/simple;
	bh=oQVZsTX9gxlIWOL/kzppYJKzYDbvRciUiFhyi2rE8IE=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=r/SjXwzEscSayyqAUcrI62h0oZcptRZNDWbTgl3se/Mlq39dw+d3OZxDGvQahdIErnqGrFaOI7XCJm6OST9wk+7qhksBOOO944j03NtamZw997wwtBWxw+wmwT7A7TLApGRSynZqr/tGdI93X32DYSXPbRbEhvG7lJqrVF9zqxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BIyeHGDQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=us5WdoF7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 542JiLAd004313;
	Fri, 2 May 2025 20:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PYe1wCvr1ak5hlLdic
	U34rSaxTeDHs2xCCCLkGA9mh0=; b=BIyeHGDQnx1NMaqFBgZr+cbZawM9ZqL6j+
	ljNOswjXB7Uiqu+V2MAEKiOYuhLnXiTrpwnSuEy+5s7AC9774uxMvF7MYl/Bua2U
	Ha1gjTS15Zbo5OwDNenak5hdFrMvF2Y8otIOvFkdaS8m18KwSj3MiVCtkciKj5Dm
	OcHNEmoRzB8qtbOhORGKcwD/Hkc1/JMlL5pa8HL4awWhVEWW32qLLHM4MmdeZatH
	rqi96bLpGstRrLBnfZxWka9JjDe7vWj+Eyza9jmgbOlMJAxgkitBZqbuaCd8DlSE
	J1tkBOXq9COcaWHqPCilZJWHCKHBS7foYsz3L/wHDasN0uwO3+Tg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6usnwyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 20:05:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 542I24HW001369;
	Fri, 2 May 2025 20:05:18 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012037.outbound.protection.outlook.com [40.93.1.37])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxe5fjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 20:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLWj60gJm21vjJMUqRhTpJpHdaMdwl6dJmcNjkt3CzP4zdo63osEL28Ai5dCzof2dKSTkynpBX7dSSKOcAKhvZtha93bnEBjZuHpqERm5HesF+s2xINoxHrs+b6D4XePXYhKl4FmSIyYOscmtOhl+mT0EiqukhjB6XHqvMQJr80uZx8MSZ4Gki2nlSOj9CpqoSVTxYbDOJlVYhbsRRjf0otdp17tssPyTSsmadROBmQb1+SoA6o4MTaEHOAwA0mRHR1LaWu/OhKEQGloOwSG+AP5rbODPp4udha3uZ7/6rpnaKM+ceZfL0deiE3xawE2DFKjcxor5Nu3WcIXQGtZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYe1wCvr1ak5hlLdicU34rSaxTeDHs2xCCCLkGA9mh0=;
 b=viSfZWZkONsJqylKJJz2Y1f6zSPRNUAB7FkL/O71wSz5mp/RZiinrW9MoklymgjeaaD1sGbastTb0NoHpVZazAZiZ7x9qAHVt9tO+emUldfmJw5IcbmOkFcxzvE0yacFHhZtq+NaX8DUY7pcLhUiWbx3V+Ep8ZMkZJ+WM5pk+G3Bslt6PFAIYb0g1DyfeRJKF/9OdL5IRURdVgQ2rGKwBbH9k2+KDJJJWe3S5Yip2NrF9xHYmTtBiyRzv3D0GmKBRw1IvBGJNwSHYD4qv1kMBcJcdvENY/Gn2KaWOfZ35kujBf/DT0n5OJzmmcAxdnO6uiQaGbojrGoyS9XKx/Ofmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYe1wCvr1ak5hlLdicU34rSaxTeDHs2xCCCLkGA9mh0=;
 b=us5WdoF7crh3lisQy5tBC9L+Pg6w6zzW9uyYZyydfBAVK+OmZQPDzGN1qAUfOR/v8OYEHK5HxnnxrWkCrLXRsTEEJO8xqkl1gYeqcciM+wk6RG1sJB8Rrb+OdWhEIrhUs3LNn8tHPZ8gS7mV3hsjyKpKTS/VYuqlZNT6A+9GQvY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH8PR10MB6550.namprd10.prod.outlook.com (2603:10b6:510:226::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Fri, 2 May
 2025 20:05:15 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%6]) with mapi id 15.20.8678.028; Fri, 2 May 2025
 20:05:15 +0000
References: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
 <a85fbebe-aa44-5ca0-f8ad-f997ea7e6622@gentwo.org>
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
In-reply-to: <a85fbebe-aa44-5ca0-f8ad-f997ea7e6622@gentwo.org>
Message-ID: <87selmok1y.fsf@oracle.com>
Date: Fri, 02 May 2025 13:05:13 -0700
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:303:dc::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH8PR10MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c46f40-162b-46d2-d15d-08dd89b4a740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CnZtuX3po133/Qmz321Nit8V/6hPWrhCHDffqepZmAUiEvV1E5ow8WAxgrRA?=
 =?us-ascii?Q?Z/w0XjnhACgRLQzMaoh1NN1Wu2/20BDs8W97IbqkP67+x3w97p0AXUDKir0F?=
 =?us-ascii?Q?QVmRb4wWQ/BvK8wWg2rkdUPGckoMu/Lv61wonLSSWHmcDEMpfa9yRVF5pduv?=
 =?us-ascii?Q?2KqPqE+nF01omVuUVZaGQnBrc9DpuGwV7zN3P6Jw0299igm7WRnP5W42vuMw?=
 =?us-ascii?Q?NV6S86EciYCor0mBW6JURsTRy9x0B/XTP28t70CQKWEvQmDOoKrSI++kOZEd?=
 =?us-ascii?Q?6G3JKEwRW0L6a4LRBgTs2AiZv9Qpd01w4EbRCEGEkzne1H8IXQF91Kxr+ZIm?=
 =?us-ascii?Q?xMuDc3X0Xi0YhAgAxAG5GyMSSWbiJ0F+9FNh+Te8MIBMW81YKRNwb48nPhdL?=
 =?us-ascii?Q?pbhvUdtg9ypRqNxS6cAXtJK+xE63R2VPO63fLcAQDGv2IjhuwDB6x7XFqeTp?=
 =?us-ascii?Q?xOQHmXtneVoze47xUFfoLqwFokdpoA6D9VzL3cJX+CnWl7ePGrtDKMIhhZ9n?=
 =?us-ascii?Q?7JOsWLQ3/+z/e+Uc5VJZsTZk8qioYWk+4vW5BXKrln6tTcVpsNcIWYz7byj1?=
 =?us-ascii?Q?1xWwmxMuxrlZAwcS7lfYnumkCKFuU8A99s0f8ljyaOTJUR896nRtxjme9Zxp?=
 =?us-ascii?Q?/Li8xgvZSy9MJQew6DFyvLG3QSG89Nhc3NcGPLLieAv/v8EF/lR6URgJWbbG?=
 =?us-ascii?Q?aQGkFLUvtlY26oRJ6+7Q4Nn1seY7bQ4pZQSttljkQ7V1LcykBV8nPIE4zpAS?=
 =?us-ascii?Q?z+A5iZbV3afaVCvBEnDkMYGRY+Fl7yZX3qzvYcXFnij3qp+n3vNdg64Br46y?=
 =?us-ascii?Q?QKHOsH8mPKp0Kbhghe8JeaRCnu5qfrp4NqwqDvIOdhBrtGA/BBmKrvJWvdnY?=
 =?us-ascii?Q?yP4ud8d/ha801XKCH8X4PCo6fXPL2ZtX8arrc6BK2w3CVys7USLsHJxHFXWI?=
 =?us-ascii?Q?9inRrNetq25/B/HBh6K6MjHvUnO8bN07jcvBqhKs8fpR0Tm7JiDQk7uPRILn?=
 =?us-ascii?Q?BpWTaiJedq8yRjhrs7EahohS17HZGROADVg6vHt2u1JJll5ybniO/7fbT8Bw?=
 =?us-ascii?Q?24ET+dyt8N+RakWOPDeCLPQ5zBZYUSCIqe/q6Ye+lQdDYplINVBl26cqclkr?=
 =?us-ascii?Q?LGVZvT54xktuYGHoCYmEddj+SxjKYUrbwVg3HZ26NzmqQ8xJExwbcYry1x0e?=
 =?us-ascii?Q?8Cbhe3hHbLueWSxpDs8pjZfOYMvr0nLhkP5lR0aLDKRE5SvWSdsjM3WSaRBV?=
 =?us-ascii?Q?NwjNGvvga17n4WIhoXTc/oe+JDYwdRh8Tr4vFjxvnzqdDvEcqh1gR7k5KwnK?=
 =?us-ascii?Q?n/tdyIjnDq5INKFo4qZghqq4OBPc+wdVqpl6zoUyj00M/PyS+U6LDTtLvaWk?=
 =?us-ascii?Q?MrAV+ZEHHQ1oE77OcNNKVB0IxfCmCGkrwBjEv8u7FHqTfotlA1ghhS8ysZ4t?=
 =?us-ascii?Q?mFVFLUAwZbc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7cDKMO7q9BD72AMB/RUm864efOMGp+tj2cAGkt/oTDks4eUbBZx7RvKtxtG8?=
 =?us-ascii?Q?RU0pnGeGOoST4mLBokz5jWcU8of1KjXioEBf7TRYhUnSsZWNuiHR7LMXQjFO?=
 =?us-ascii?Q?Xq0KUlfQ9QYXifkCi/X94nzeAkpo/wUfC7B0hjjlyNa6+z11TDo9Dt75ovtV?=
 =?us-ascii?Q?I9fiZVPFc6cK0EOQiFhBub6hJ0oPMsoXapslMrKmooj1h8bgS0SAXr8NucKV?=
 =?us-ascii?Q?OCgBgR0fOeXMJnUc/XzO5PxIbe6mQuq4Ca/jxbkRhs5Wwlbh2IH+eumfDLrt?=
 =?us-ascii?Q?YQ+V1EZw+nPCbR1vV0qroMpeUd6y+MBDD1jQYDsH4Fb71LMkXdsulDB+Kcyc?=
 =?us-ascii?Q?XkeUcwGXOC3BLZnsCuJ39rys7t9gWRJ/egFvcDSJWo9KSPviFTboawKcRoqD?=
 =?us-ascii?Q?JzVS2C1AFBatEFXYsXkeLIatqrn+UuKo4FJOsbFTTf6SEzSW9A5HqwY3ldDy?=
 =?us-ascii?Q?0/YIg6YlLKnsYiq7FAofeepgtGxu2XQXtmbwstRmIr8aOaRQujlS1EbE4xCR?=
 =?us-ascii?Q?u1iorVblN1Snp3QDyerbfgFHFUm9ohCW6AUloBsNlahEqQp7nsKPGHPo/718?=
 =?us-ascii?Q?rw3p10cKj+5OvXWRMYULyV9xaLaq+3uO+kZMMbqr0pJQyT1Al/P1EyRs8voL?=
 =?us-ascii?Q?wlntdMXIZ3mrj9gQi67CfW5yX+3wyKVBm2zI7C6UzdJEDUgy1B715erQx//X?=
 =?us-ascii?Q?87E7LhjTDFI8+GabhKVm5B1iHL7Of1AhL6un22QSLg11Dc3g26Ke88MK/6K6?=
 =?us-ascii?Q?J9kvMlngf1QXymphJkwMHSygHyxrdyDbuiw3pgeyHgBL8T2wVilO5vgnLrGN?=
 =?us-ascii?Q?0o18BDpgI9XC5uI5+DBRjHF99ess0f0zd2yyw7fJtzfoLAaK6b5JWuolHLSA?=
 =?us-ascii?Q?yL8p1/LU0py4zN3WETL6W9ZHb2bm7m4AVXD2cYczDhmQYIeE/oDUAxG58I+H?=
 =?us-ascii?Q?F3B4Ik6Ug7TNm+GG2u3zxLuIXcNrSfUMjZDnD2N+6j/4udxyQIUsqyL5sOgF?=
 =?us-ascii?Q?7xYtQMH6Sz+2RGCKOrpFK4X7nL8B+tZJWLK1GKinrNL6tcLY/qLPBzyAzHHf?=
 =?us-ascii?Q?hCMyQvLZr0VP0tq55FzM1kQxt+2K25KjpFm+tu28NNX6PTwQ/xIrGSqU0rYF?=
 =?us-ascii?Q?TFk5/PIF00yDtsuntr923ABBCLxwOxAsdA/TCubCnpFvMAWIJ2LUS5LByN4L?=
 =?us-ascii?Q?nDRXIif3frXNcX2bguaQmCpP+A35KLFEL/HvSYy++EGMNpW/hU6JGiDqhYAq?=
 =?us-ascii?Q?s0+XidF2uY2MwLwsZqPzC7tCx9B2eYfJwaFU3oXrGmSdkOcKODMPQmhztcK0?=
 =?us-ascii?Q?fFETa7nEW4aUo3UGkje/S2qMCKL0WA6YETAf46V1/pYiw3YiCpMP5w13a/Po?=
 =?us-ascii?Q?qBNyFbtCLUoHURKrEX0hZSoFyqTXzoHh7oIaFJG18NlZHfcP8Ust55ymOuc+?=
 =?us-ascii?Q?y5xyJrl2I0HitKFYpsVLXRgV81HxXdV/d4oA3OfYOnlEnI0Pw9heKBEA0s0/?=
 =?us-ascii?Q?2AVhJbjJtty6XAOy23ihuSqzRDeNoOM/xyhlJCv/Y86K7X77J0IL4wEm2u4F?=
 =?us-ascii?Q?WvxT4Qypi4TnSOaAMlq+U2aS2UwnFnA9oyDlGYIFwAj1k1i4sGVNKzq8dv3Z?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rK/BlSpbckSUbMzTTOaW11sx2OmZgSXqlNjX1HPPdODlOyQRjdQdFPhlFXkmfhiMsF23JQ899sGWd+Ar9hPs58RH6+xlmOM2kUcSm1rzVeLcke7hTxKaqbms1xkcrqC+zNG4S7exwzw1AsH7o89Tn2nPhxGab4NaTZwEr+tdHxLGIX6lJyVhxAStwT3FXEVr0TAmWoI5RNS5L/TQ2hJgMlOPRHwdOHtEye1TdXVIH24iBIiU+ZKoaP7Oe2FMzWE1LmG4ZEKIxqnsN7YMV2Hq7rWq/EE/ul9XyiHsEyzHu7kzrAsnryvoSow5JiAAxv7hSuxJPHOPJKiQrfnVrxD4ZnK528deiSARZtv3MFgGAXmc3GZNaaNmU/hSSYdXEAVpcqdMhXz7stSEFMg6pLOsuRcfWO1lXQW8lxuMKx46POeY7aqglmFoi2M1QeAHDPHTbslytJETD25RuDf8DNu3uBmB6mAao/iLv4qFYRXCWt2MjdCXAFDbCzbr7sWRtVPc1SIkgAwSyQFtEzVNtVsCdI4+B3ATutvdrohG+v5YN53lLwS2N1MYA21MbzFq5Q/grAh6uFQOANEYn+Z9U5OZly0lFZMfZs1EnRy/UNGuHFs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c46f40-162b-46d2-d15d-08dd89b4a740
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 20:05:15.1597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ///S3YS7nbMADK3TSBPGQgAzWPXckan781rAkfxAmobjeTNARRZwJMnCw4UB2xXSSAq/g1hGTcIyiIhx3E2aMPuPObP9RfF+VJ0Xgo048QM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6550
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_04,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505020162
X-Proofpoint-ORIG-GUID: 1dFBiNQ3Aa4G4rXahsWKoVE7QtL02HnS
X-Proofpoint-GUID: 1dFBiNQ3Aa4G4rXahsWKoVE7QtL02HnS
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=68152580 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=PuvxfXWCAAAA:8 a=QyXUC8HyAAAA:8 a=UyxOJh03wdAKLtM8-FUA:9 a=uAr15Ul7AJ1q7o2wzYQp:22 cc=ntf awl=host:13129
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDE2MiBTYWx0ZWRfXyJH1RBOMfBgb xh2T+yOa2VpkMKHNhOOjM6iD9qZai1sqMeTfCpZ4pdqvC0QejqWEbwqjGd0f4aKc28xACLdE5hZ rSQYvS7GwN3VGmRV8LuAXrUzmHvQoYPQCfsZMLQbLT2lKDYpJX4kFaZwAqH9/0010PhfSr37OnQ
 yBrgHbxAWe3XgQ5Tw+3pbP5HU2MOl/y8FrFIRFpC/Ikdk+bqtWp3dP/1E/jV77aSG7h0yFjxJgJ Bz5mOYoefmm3h53ZeMk0Mj2n5QwRhXZAbh390FSw/cD/AlusL8eylFdT21uiBSEcerqrwY0XxE6 IB9cacdCghHHgxKKDYYJ75Sipy65pwG3w3sxKgN8Ld5bO++mqMjpcX5l9d+5gxsafsFjBm0gCdf
 6aHytiOyy4qrHZdfrGCUksW4tGjeL7jFs9GlXLuSSBBoFefg13kNxwtCkyl9MTbCcf74dVNK


Christoph Lameter (Ampere) <cl@gentwo.org> writes:

> On Fri, 2 May 2025, Ankur Arora wrote:
>
>> smp_cond_load_relaxed_spinwait(ptr, cond_expr, time_expr_ns, time_limit_ns)
>> took four arguments, with ptr and cond_expr doing the usual smp_cond_load()
>> things and time_expr_ns and time_limit_ns being used to decide the
>> terminating condition.
>>
>> There were some problems in the timekeeping:
>>
>> 1. How often do we do the (relatively expensive) time-check?
>
> Is this really important? We have instructions that wait on an event and
> terminate at cycle counter values like WFET on arm64
>
> The case were we need to perform time checks is only needed if the
> processor does not support WFET but must use a event stream or does not
> even have that available.

AFAICT the vast majority of arm64 processors in the wild don't yet
support WFET. For instance I haven't been able to find a single one
to test my WFET changes with ;).

The other part is that this needs to be in common code and x86 primarily
uses PAUSE.

So, supporting both configurations: WFE + spin on arm64 and PAUSE on x86
needs a way of rate-limiting the time-check. Otherwise you run into
issues like this one:

  commit 4dc2375c1a4e88ed2701f6961e0e4f9a7696ad3c
  Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  Date:   Tue Mar 27 23:58:45 2018 +0200

      cpuidle: poll_state: Avoid invoking local_clock() too often

      Rik reports that he sees an increase in CPU use in one benchmark
      due to commit 612f1a22f067 "cpuidle: poll_state: Add time limit to
      poll_idle()" that caused poll_idle() to call local_clock() in every
      iteration of the loop.  Utilization increase generally means more
      non-idle time with respect to total CPU time (on the average) which
      implies reduced CPU frequency.

      Doug reports that limiting the rate of local_clock() invocations
      in there causes much less power to be drawn during a CPU-intensive
      parallel workload (with idle states 1 and 2 disabled to enforce more
      state 0 residency).

      These two reports together suggest that executing local_clock() on
      multiple CPUs in parallel at a high rate may cause chips to get hot
      and trigger thermal/power limits on them to kick in, so reduce the
      rate of local_clock() invocations in poll_idle() to avoid that issue.


> So the best approach is to have a simple interface were we specify the
> cycle count when the wait is to be terminated and where we can cover that
> with one WFET instruction.
>
> The other cases then are degenerate forms of that. If only WFE is
> available then only use that if the timeout is larger than the event
> stream granularity. Or if both are not available them do the relax /
> loop thing.

That's what I had proposed for v1. But as Catalin pointed out, that's
not very useful when the caller wants to limit the overshoot.

This version tries to optimistically use WFE where possible while
minimizing the spin time.

> So the interface could be much simpler:
>
>    __smp_cond_load_relaxed_wait(ptr, timeout_cycle_count)
>
> with a wrapper
>
>    smp_cond_relaxed_wait_expr(ptr, expr, timeout cycle count)

Oh, I would have absolutely liked to keep the interface simple, but
couldn't see a way to do that while managing the other constraints.

For instance, different users want different clocks: poll_idle() can do
with an imprecise clock but rqspinlock needs ktime_get_mono().

I think using standard clock types is also better instead of using
arm64 specific cycles or tsc or whatever.

> where we check the expression too and retry if the expression is not true.
>
> The fallbacks with the spins and relax logic would be architecture
> specific.

Even if they were all architecture specific, I suspect there's quite a
lot of variation between cpu_relax() across microarchitectures. For
instance YIELD is a nop on non-SMT arm64, but probably heavier on
SMT arm64.

Thanks for the quick review!
Ankur

