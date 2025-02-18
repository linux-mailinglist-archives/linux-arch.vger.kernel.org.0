Return-Path: <linux-arch+bounces-10201-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B2FA3AB4E
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 22:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4C43AB564
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 21:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A200749A;
	Tue, 18 Feb 2025 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M8iQBFBU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FQaH84s1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7562286281;
	Tue, 18 Feb 2025 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739915316; cv=fail; b=GCDqiIOUE2brToaZSjtoZwuBY5cyR7YWmufy7YFVD9w0nIS1qHRXeotLAh/raZE/irvvR0kWLkmWdfKT5OqM+OrNOC34KWHFOwCJXOBwm8qWdKPxBSmnCGAbah1o0jCgcnotvGgou1q+mkOv5fF1AAiNIPeMqPIfIAZS+s83YW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739915316; c=relaxed/simple;
	bh=49nwirp1FhIZ1fdRZKS+/SuafswktWx3UJ2cG/kh7pU=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=NUmbIRvaeLCbMM1n5kceMFiJdAZGHjKsqms5GOcXecigBfEhwlK4PpgKEiSMPorWAX1bpS5sDUUz8Qlf8Su0KgiHPJ1rfPEHFJvzaYcDV06QvVia8gFRNTF67f6zfzXIokOUbOtcp4h72evI00xjPxCB+KqdF1prrV/5uljqxlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M8iQBFBU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FQaH84s1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ILMZcC026600;
	Tue, 18 Feb 2025 21:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=xc4XUFk9kAoxDVt8iT
	IMIwUqLIgVZpbp3gr13s6YFJQ=; b=M8iQBFBUrzxw48gklsHAWH264ejxynEom4
	q/UpVrLUcM4IEFPgtsRbno47Fb2tSPNDaBV1aW08sjHt0pkBt2NdypOqQ5gTbAYY
	nuc2NNKEA/8lTs2LacvxPO1/O0VUEO0TWfpoF4SpRaFHugR5mSS+hEq/TkrXJ6Vi
	0Q8OJdTurS18VBFUzGFcxatPc1cSYSl1IJRhcB6BxrKfqbm8TL1t5TL8r/LoPK1a
	5DY0t3a3PMiKk0ATIWxy5qKn6l+8WbSLyGmdyV7i0A9PrcQb9gZLBEv75NpNk5g4
	sXF+xE0310DKQHtZabStFgKyGhjt0Xr7+kSZtBIQPSH42gYkIWQA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00mraun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 21:48:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IJv6AO002113;
	Tue, 18 Feb 2025 21:48:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0tjuy3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 21:48:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJGW//KbmqwCtEGQdEpct42si2M1QGGR53vyHlo5TKGpdJQ3IZLurHH4uS6QLTLR3IE2FXQV4ct/CHCTcstqYUjXCx8fOSMMPWiz3CbYDXMAwLMhFt+YwpZ7YgG6el2s/GVJnqa95Si8GH3TBqbloJL1+P0gjMirMMR+VSjJCfM6HLLyOKSeJ40a2rZN3edCF3N1eaDwdFYa+FszkG+goqccnVd6Gc/9P6JRp/fGuDlh/sMqL8qnANzAaFSxDoN9nlK6mPyjps2sdtGGQJZd0HYcqPlcVEYB6zqMy+oY/yaSUU+r/1/NQMivTF77jMEy9YCGfUErX3qECYUWdhUsiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xc4XUFk9kAoxDVt8iTIMIwUqLIgVZpbp3gr13s6YFJQ=;
 b=ZP8WZfA8k4uv+VsD1ZxuRmsrf/xxzgmQ+48h7GlLq3tIcvycJvWgn4MB97BUsds9rLnTf4a15zqdbcoY+/CyzYAzZgDi53qJgABaHcuv12QbqyxpaGR8tGSaqKaOQpysHxVXnGT2ato9rtA9oWRGOr952rlJwE6JL+XAcaBablrrhhHp34p9XI2X2CHnWFMkOWIb5uMaQCS5iTYzSjHHvr05WbS4OUW6W79RCMyEwvf6aa+dRtbRpblGIU2QCL9SXxwxtWO0g+lGOGUN7pqlbQzmX76J5t4/Qwg8T1rd+fURlxddinuTG3kyYZiMgE4IYnVSCz3JM1ZiD5fU2EtUJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xc4XUFk9kAoxDVt8iTIMIwUqLIgVZpbp3gr13s6YFJQ=;
 b=FQaH84s1nZLyrmG2SCZmDpAbhJW3DcHYp2gM4I/YSHHem/Fs0OwN8NukoiG36iaG9PkMyR2gQGEWV2HNZXP47FiOTo/YH6vug5141GhyXprTWv7mCvO4MNm0UjE95LcQus+yqON7AHXWEoiLipqT6syvFJS89z+jRk1WYA38r8Q=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5111.namprd10.prod.outlook.com (2603:10b6:408:123::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 21:48:15 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%2]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 21:48:15 +0000
References: <20250203214911.898276-1-ankur.a.arora@oracle.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 0/4] barrier: Introduce smp_cond_load_*_timeout()
In-reply-to: <20250203214911.898276-1-ankur.a.arora@oracle.com>
Date: Tue, 18 Feb 2025 13:48:14 -0800
Message-ID: <871pvu3owx.fsf@oracle.com>
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
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: 5886efd8-495c-4146-3ee1-08dd5065f2c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JCscLVs92ZRbFApIaUrm/W8rbNksFRFYFMahhgz6rUtSbsKipGnQTsFdTMvo?=
 =?us-ascii?Q?IrGyQexE9m0H+lR9xQwBPJSr2p2SA0BxJhcu1N8plJ6Lg5tkNQzUBA8DNYlm?=
 =?us-ascii?Q?WTlDuoIFQ7nDdcFRnGTHt7Ri+ZCl50mVIn+oIBxwu0ka3yxg7USUByc7i+bS?=
 =?us-ascii?Q?QsesyTT86A3bqd+RNibMjQVOKmyjc481a+1Mihtz6mzdY58N+BtuIAiBwVVG?=
 =?us-ascii?Q?qTPoUGNQRFxoLmyiZ88fB4k3akDXleehyI+YQ03Hj3dvfObm04S2/czjOvy2?=
 =?us-ascii?Q?l6BpWU0Xm10AI+DdvWdBkJkOOGy15K6rG9wQ7vF7PT1wS6JTdMu1VLmbl3mC?=
 =?us-ascii?Q?hjW1DSPQJh5QXfCVJDn3tszemYnQ6l1JKWL0G4AvvKRmSGIXBdEG5yJxd+CC?=
 =?us-ascii?Q?IueNtA/cjwdrcoU2ZGnYJyttR3TfIRxZZGuXsJmn/n+Zyt8O8t2R+nqmb/4r?=
 =?us-ascii?Q?RkDcq2ttKfgjR8jMlj+649SCiNBLw5q+qsRnbmHjFB3nZvjI33wJZcYix8rK?=
 =?us-ascii?Q?Yt9mMdifOJH1yKrfpXWqtf+npatx3EwNoQ9SI0fhn+p8zDd3B53wYwIFJZBq?=
 =?us-ascii?Q?flSjgCL/3Mteqy1+VAnD/bxhfiIbDbSiCYq58v6p9eitPrPjUObCV20E69FY?=
 =?us-ascii?Q?PzMCvdDawu4Z8h9m6HlIs6Z3kjKYSHE/LmLPbl6z0buSYrcu4jdWLHSy06mm?=
 =?us-ascii?Q?4yS45Al8cJIGHCTY8bSlkd0EPyZk88bFY68BRKpZ9G4F6ZndNqdyUtcZZYtw?=
 =?us-ascii?Q?9Ue+xPt1rEoUSrVONOefdU0KesXzdBdeL1INl6qyb9N9sATTMesZwukH2bvl?=
 =?us-ascii?Q?0Cy3TtyJoIzn75gtDVVK5d2eL832F5ewqpqWtBzyRkDfw+T1FW29sIdE80QB?=
 =?us-ascii?Q?NE5yRPqrlEXzUUDwn/mllHej2p9romXW7IcR695lCWFQCHOUhB8V6EjcQ5jU?=
 =?us-ascii?Q?nuZb/pthysf46N7ZgB4VLmFjHosFlrHXWTnWaUZWxO57g6dgC2tPodfH1/Qb?=
 =?us-ascii?Q?/qjKoHpd4K/MFrpfKsJqOZIq9LixtiKGKYJTDo/CLQJpuHMG9TiehhlIyFtE?=
 =?us-ascii?Q?IdUzirE9+y4B7KeKjmSmWPHW3RYqEg/eDOzTG4s1GIqRKteQk/38WqzGpiMX?=
 =?us-ascii?Q?ouPHCVjC6/e9rVFBBPZgwmdo/6lt4eNmflDzAct8e39VIovjFJB89xJV2KjB?=
 =?us-ascii?Q?a3zFAodmDK/LSoxw3JCnSKRTb7XyRoZijwy648SnoMDi0YySgte8RqhK1XZ6?=
 =?us-ascii?Q?Nk0pABBWpU0ee1Rc0vecc2ncGYI5s7pJk1Ngp3yD2DSK66K029VOgaTgTkac?=
 =?us-ascii?Q?/oNUXZhSie81EZWIjELBEPUrKpQttJ91VgU5e73Dn+LW1hOb0lM86DU/+goh?=
 =?us-ascii?Q?ZXVIs8Sae4jFu4ubDHcPze1ga/3PoLkEwghE5KDd2Yli9d32WQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NiO9BvmvHCYqNRETWg9XY/vonwWJKzRQIM9eVdpyHzBLG4xKXWeekPXr2MU+?=
 =?us-ascii?Q?c80P9i+PnmcOe9nOH6jZlukEMGIfkziV7sFM7MLl12FD1e2uJkGBmHnTbVl4?=
 =?us-ascii?Q?wIk4gt2rU7lFRrmuz6AiS5Zsj2kwgMsUq38O/DGrhrJA1w+zou12uhq8KF/6?=
 =?us-ascii?Q?kZrd8cAwGZhKC/HZiqxusUDb/SzKCrPW98FsqVNrK3IiPPvkKqGwqrVfSWvo?=
 =?us-ascii?Q?kIaSS1uc6pfh8B+CtR1Jw259aA0STSEPh8KkrqsgngvBJ9bD7ALm31Nkty+G?=
 =?us-ascii?Q?TUHQf9CZaygJ7SGT7YydPAB76oy/7PdKsmHz7za6YIQ2lWvTacaNzStA/Nq4?=
 =?us-ascii?Q?XFbdMOOuv34i0TcwCnnwtEA/+amDeE4uYxYbhtEod7aNHSHjlBstJ/neQtO3?=
 =?us-ascii?Q?ANXIxTWEnAfw9IiieLZFBQQ/glVszGuyaV2zx4c6MBHQHQHVMzLyC73VPkXr?=
 =?us-ascii?Q?+qNfESjWWOtvI+qpOvPUR1TFhQwfmUPoG16yqPNtWHaVpnbJsL3Sbh5cGfmH?=
 =?us-ascii?Q?+OMDIhNBoaPjxKjBA6ZpZHuQS6XTd/TEnZymlHpqg2HQ1AUYThaj6k0VFziM?=
 =?us-ascii?Q?vo7ERZUSqBqXihpBIm7ZBI656MKvpCFa38kBpawNOOz7UcdS8R37q24EK1sK?=
 =?us-ascii?Q?6ohA7UtutM/LvlPV13b3/OOhOVD2EBmsRRI9vONkWOMmC/1ynbQGPpl6FmYS?=
 =?us-ascii?Q?tlh/Ofuyml9CNzGlyBE+rYdzg9swvbIVCSvgqyhbdQokdBZmZk5TxegQt2Br?=
 =?us-ascii?Q?zUrAvnq4cr15ryjfKUmETOkCQe4ojS23IVeMOt7JcHragV31ubB1zpOH5wMp?=
 =?us-ascii?Q?zVPWRzjXnlbfZ4I+c9kVgT23qK7dwrj+eIoJu6HhoBPDV+v0tFXhfcq9mX0c?=
 =?us-ascii?Q?lAO8DWjDynnFqEF0M0kdhVokrb89xjVp+mNcBzMbUpWaZRgRNdUHgGSHyYV+?=
 =?us-ascii?Q?6jA8N8Gz/kLo/Y58vlgEg32XPi9eJC13v63YmctEOxDKSjOA4Q+E4dRerE5h?=
 =?us-ascii?Q?lPFxVN+TBw4ZATGv8Mvp7jqbsE6dI1+XYt+0blhO59WfKq0TtBxnSjqTEcnk?=
 =?us-ascii?Q?svN9z4upTn86I9+mmzsZv/TwfcoRB7XRXnvfnUdTj0C7Z+GlgrrLJI+xvkvz?=
 =?us-ascii?Q?hkUMwXJDLqOJZtUf8L4IFJ/T6aC7NdmaODMmI6h4d2LWodobGBc+H/iuyqGD?=
 =?us-ascii?Q?sZzT0uQzT3b7v+LbIOVwhVCFQajRRDkJ2tGRwGM4jkcmgG5B99QmBNjJA7Y/?=
 =?us-ascii?Q?IyW6LCcvf0MCoD0i2xLquYPMoQAbW9kxsoandAc/LjysjQBQyotCYf/T3Mn3?=
 =?us-ascii?Q?Jw+CswytkwEjehN5gbwpokbaT/8ZE0zFK84HSohX13Rfn7qugW/bG3Ard2Zn?=
 =?us-ascii?Q?H+zY/iV2Dcmm/2L3hvBO6bcXAN9cCoLViAoFPSUgLBJo9OfrfjB9mn2GyBhl?=
 =?us-ascii?Q?guaIhs2DOkozjXFd7A5O71k+NwcpKT+fioQtEllmr+fZM55AGE0/w8LgR5pm?=
 =?us-ascii?Q?uJfaXFHUfVazfD/RclJ57UpapwXW/+0CMpRH9ZI+BDtob9oy0QVE9GpVlrwG?=
 =?us-ascii?Q?UEFoCn2he7Jf7u/hA9Fo9E92vGUDhaYbXLZ42L6zyOr5rmVJnGsW2MKU1s7L?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TUjZTEL1A3cF5FLAHbiZGFg19Tv7rLTY1XEc33rcw8Tcimi+BguWWVl+8OrA6VDyo+yTJyI2Wc0Bl8LJngm40uwBOLAnvzQ/lHyaCEqOcI66b3rXkw54M/VbIfMSsp3s1wb/Yt862xaMlae0EI6vH6yu1m7A2VQ4EGrvj6KpIVB4mjdV85lw3SXfJu23ojqkWopa42ATx90mZ2ljX5Zse6gYFvYJVyLDCqVt+fBlTmxZ8wi3ex7Ke1gq1iUyJNWV6/pgR6lxOQBj4dTgNlyTKnkAY4CPUH0zwcDelnxP8Hhrvu+k2sLpCaLUhniTxG5rWUPwC7yoZMA60LNHsEFlsef8ShbbBJfS9G0dTOUIYQr9FueNrvDTsWr/PB17z6V4YzfUqIxUuT+j53QGyEgo3tk6m0l7jAebwbTsk/bSSKRqCd1KR+9A457xQvuxnEugPqzPP9Lt6cxQ6EPHN3LxVw7JED/SPv/HtlZKt7gxxHaGR4Dlf1u7Q5elT6H+uzXpFC99KakL4rQLEPa4XOOHMSwsMZ4sCMfwrTz3CEaimkJ3tICIcjoHp9ZUf0C123Mx0/0CC8MDG3R4yKCX+IVNMx4UFA81JIouh0UOY91cx+s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5886efd8-495c-4146-3ee1-08dd5065f2c8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 21:48:15.2583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hd03N9HD8+y3ZLt9xlW5aJlVNN+53i7FSPEX3o3b0Vp8w3+2tHdMBEAWdPyi0VXQJiofrt6LGKNrsmrw5hU3U+7j9OEev7Lx4LnSUhGsGY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5111
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_10,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=964
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502180140
X-Proofpoint-ORIG-GUID: YN57fdTUFDunf8lceUYdwACekHBvlh7x
X-Proofpoint-GUID: YN57fdTUFDunf8lceUYdwACekHBvlh7x


Ankur Arora <ankur.a.arora@oracle.com> writes:

> Hi,
>
> This series adds waited variants of the smp_cond_load() primitives:
> smp_cond_load_relaxed_timewait(), and smp_cond_load_acquire_timewait().
>
> There are two known users for these interfaces:
>
>  - poll_idle() [1]

The next version of the poll_idle() series (goes on top of this one):
 https://lore.kernel.org/lkml/20250218213337.377987-1-ankur.a.arora@oracle.com/

Ankur

>  - resilient queued spinlocks [2]
>
> For both of these cases we want to wait on a condition but also want
> to terminate the wait at some point.
>
> Now, in theory, that can be worked around by making the time check a
> part of the conditional expression provided to smp_cond_load_*():
>
>    smp_cond_load_relaxed(&cvar, !VAL || time_check());
>
> That approach, however, runs into two problems:
>
>   - smp_cond_load_*() only allow waiting on a condition: this might
>     be okay when we are synchronously spin-waiting on the condition,
>     but not on architectures where are actually waiting for a store
>     to a cacheline.
>
>   - this semantic problem becomes a real problem on arm64 if the
>     event-stream is disabled. That means that there will be no
>     asynchronous event (the event-stream) that periodically wakes
>     the waiter, which might lead to an interminable wait if VAL is
>     never written to.
>
> This series extends the smp_cond_load_*() interfaces by adding two
> arguments: a time-check expression and its associated time limit.
> This is sufficient to allow for both a synchronously waited
> implementation (like the generic cpu_relax() based loop), or one
> where the CPU waits for a store to a cacheline with an out-of-band
> timer.
>
> Any comments appreciated!
>
>
> Ankur
>
> [1] https://lore.kernel.org/lkml/20241107190818.522639-3-ankur.a.arora@oracle.com/
> [2] https://lore.kernel.org/lkml/20250107140004.2732830-9-memxor@gmail.com/
>
> --
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: linux-arch@vger.kernel.org
>
> Ankur Arora (4):
>   asm-generic: barrier: Add smp_cond_load_relaxed_timewait()
>   asm-generic: barrier: Add smp_cond_load_acquire_timewait()
>   arm64: barrier: Add smp_cond_load_relaxed_timewait()
>   arm64: barrier: Add smp_cond_load_acquire_timewait()
>
>  arch/arm64/include/asm/barrier.h | 74 ++++++++++++++++++++++++++++++++
>  include/asm-generic/barrier.h    | 71 ++++++++++++++++++++++++++++++
>  2 files changed, 145 insertions(+)


--
ankur

