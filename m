Return-Path: <linux-arch+bounces-10679-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4D7A5D65E
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 07:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1743B69CC
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 06:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863FF1E51FF;
	Wed, 12 Mar 2025 06:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="knoAsyul";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FIiB0yta"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29731E501C;
	Wed, 12 Mar 2025 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741761331; cv=fail; b=cwB1yTNhAyxhv4CVC0HrljdQ3hj+p3VebIMgA9uQWrKVH/HoXeSd5+WvccaOPcYuBITtJJx2RcUgrj74VV4Fvsgn427ynrNWPXcGkyTspH5ot0xWC9NkIGykH3dM79zOAoJD2m1dlBQUTD+QwT40DEpEP3VVCHkYSj917L18XSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741761331; c=relaxed/simple;
	bh=qFYyO6gohywBrHSEWi9X9NtyznBiaqIdemmsGoTT/J4=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=Yy2uv9HjnLsHxSufmf8NBtW01ggblt1C/b7TXmKnR/TzFSXnsC+Ev7Yut1W+5MsLGVWMZsHa30+Bs2qJE2Fg+TfNjXOPBFt7m6HzeplhHgRR/53mb3ETv0nAOOeaXKQY5tRrXb56QVIiLow17WDT/BzxyEcj8D9h1XwE8yMsyjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=knoAsyul; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FIiB0yta; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C1fq07000635;
	Wed, 12 Mar 2025 06:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=o8RU7khQpriDEPwyCz
	jLTCSs5nhFFyFaI5zx7Zouarg=; b=knoAsyulSXSIJL0JxmUv+J0mYqitffJ+f5
	D8XpYl0TD3Vj7K0toGF+X3FC3tlrzKC7TJtA3h+z1V3GjzmbPJnDqkBGRa+mCQDH
	Jrw3q0xcwbEYAgVjhcNkYd5EINShJmC64n28uRCwwTZQ2EyfKm+XO1EsU2Uk66yk
	UtX7ToFt9AhH7tk68xCbUyL7S+VXX3ULAr4qRaltYd9bTrltLfDsZwb0NbZp5dkk
	I8Pobo5UAKBSRXF/QPFh1bsNEOIYr5A+ZK8uHczyX7ImsuvVapia9nIAWFjXxmCL
	5+mr6/Y2xIQnW8pjXnui7yDJdM9dU2R3nmMDgE+Flkf1GSF8VH3A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au6vgxcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 06:35:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52C4SdoV008618;
	Wed, 12 Mar 2025 06:35:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn2uq9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 06:35:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0gmQkA36OW+++J8H86gKZnEvuye9eT6RugN9y2M1a7Uz/RpcjtItvEId5wMlyldqaXP+e7Z8uU/q6KQfC5nR3URw1cwjvl+7fPrgfWXbRN3hXHYqjk7RSoAma+4dJhM5NJPKVyH8hl0WmJV6WVDHOAb7/OLJWPdeH1vjdkNI+3l9EQpieSt6FtDLhgMWFc1V4+dOqMsQc6wE7iy3oiZWf2ds9ri+cS4xWZ4RbrHmzNKvbQ6oRsbLWcvXvzdObM07ziTm/8EcUUr3BWRDBsbKZOoQNCqPCc5hllEya7M0uJ/OK/le0tdx1c4vI9Gw37kenSSZRG51HI/QT/ibMw8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8RU7khQpriDEPwyCzjLTCSs5nhFFyFaI5zx7Zouarg=;
 b=CbY/NTn/LGkexZ2gAAOEYu8bpYf39OSzZjsRxnDk5+4n/+xRZ8QamkNVPyT5GGHHwAbo4oRK0+rfNPAks5EozYeUiTcxr0Fz1sqgVeJxWWgUCfx21FAD0aQ+XRrpkRPr+SrQnSsxTbiHj2gi68Xxzbv25rRxNfJUm1BZNmpqVJdozx5k9nxf6WN5SiPd8LM0/HuvkUmSZjO9IHZQ7hJXxFa9S7qA+EqOAXRAAQUd4A1UW3SYBlphps2qysYIlEIRlkN7+aAM6TpvvTNxvqB5alcjPKtsbLaeoEpMz/1nq8u3CMAMJ4/ooJIXmeBmf4LVOS+L1UlnH1iiCD3D95xRcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8RU7khQpriDEPwyCzjLTCSs5nhFFyFaI5zx7Zouarg=;
 b=FIiB0ytaTKY13mirvGnWRRgszlW976ALHNLFPGSHUU6u3wjMqqXmLy7R3vow50mcbh0nzZiB21wBn04E555Bic/JHx2LLtCUE0X70eQMsB+Ljk9232n4x0f2lfcuVj/0yL8qJ6xdMVCbT0jOV+aLf8uO2B5KTaW8RQCI+4/hyCY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6760.namprd10.prod.outlook.com (2603:10b6:208:42c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 06:34:57 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%2]) with mapi id 15.20.8466.028; Wed, 12 Mar 2025
 06:34:57 +0000
References: <20250203214911.898276-1-ankur.a.arora@oracle.com>
 <20250203214911.898276-2-ankur.a.arora@oracle.com>
 <Z8dRalfxYcJIcLGj@arm.com> <87pliusihc.fsf@oracle.com>
 <CAP01T76TWAPz4fXh6EoqHLCAxtgbzyvZib72QeFoTSx-0WKPtQ@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
        Catalin Marinas
 <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, will@kernel.org,
        peterz@infradead.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Alexei Starovoitov
 <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 1/4] asm-generic: barrier: Add
 smp_cond_load_relaxed_timewait()
In-reply-to: <CAP01T76TWAPz4fXh6EoqHLCAxtgbzyvZib72QeFoTSx-0WKPtQ@mail.gmail.com>
Date: Tue, 11 Mar 2025 23:34:55 -0700
Message-ID: <87o6y6kb8w.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:303:2a::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6cca85-025c-428f-9e88-08dd61300171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tFN3apugsOzSiP/PUybS5rTgYLYTKS9GRsq2SRCOkxmTULHTl/1w28UzUDMr?=
 =?us-ascii?Q?FFb9+EdRIj1xrtLML2n5fkmeigrNDH/ywdM6w6D2wjdYUlwVBBzQjkTxhf1P?=
 =?us-ascii?Q?MtWcXvabtFfBDHUgmtDbACDYhwWeTwadbF5T2FfSgPUa4g2PKLySqVws1naY?=
 =?us-ascii?Q?c2Crxxez/gqiQQl30CdfSI4dz0qXhxpFoT3Twh7PXC56cCdQ9T8/9cPdU68q?=
 =?us-ascii?Q?j3gEZz4TrwfIc8qqvaAqVHp8f9ZbTGAYaYAP/OtRchVHlD8OT65alYvDBLbu?=
 =?us-ascii?Q?YB2WxZ8dEQnfRo5CInOv06YgFmkXA0rjLzNs6tvnS53RzFWqO3MFQkbSMMX2?=
 =?us-ascii?Q?jLOQ3+bisKTP8MgnqIqp0xYBeP4bm5E2OsX15VI40y9kqOzLxpuFPFd8uaLI?=
 =?us-ascii?Q?ZzYSkYXJ9X9fMVyhcVv42Q+pmvADEU+lgsDWeIwamZRF4qC+zzlLbyYx4arG?=
 =?us-ascii?Q?X8OsBSotcPpnhqDc4kAhM1U6Nyrx9S0TmX83gM65wPnjRHaih0aA9JtkNkiJ?=
 =?us-ascii?Q?ebJ7PQ1Y28I7vnFbwV3R/a92/Wnk1BTBP8iGp3OyYNFZxoeHJNPS48/4vov1?=
 =?us-ascii?Q?XxHAX/jSBDD4XUVZDxWmveXo4UDnw4WMiQvu3XMAKa3i4X2fyPu6fAD3soAR?=
 =?us-ascii?Q?ru+BW3NNETZbq2jx89hJN7xdlci8lG+WeznspC5wl5dI/mdRXg168697Wnzz?=
 =?us-ascii?Q?Ye/XP1AZCfweuF40YTiY+SFoHEf5OjWljSiuiQiO+AVeWkdFpdQrwyqStqD5?=
 =?us-ascii?Q?+A0LHOolYwIuMQ2ojxP2Hww0k3837Qkgq8Zhv80cAeCSuznjAq7QzVL0X3aK?=
 =?us-ascii?Q?MpsGBPcHimGO1rJvAd9OvAZgDk+nsJnCOkOt/fEZqFEh71OSJxYy354EAk7k?=
 =?us-ascii?Q?FRQ4Rs9OiH1lFDW/B3F6qvdXSjCXvgzcuZW7G2JeInkeNahiWL9gxOElVz1s?=
 =?us-ascii?Q?81f2aIxUAeoX2m9HUQkloCDkBS8eAIMgetdKyELQEVMyj6JIKlPeCDLm+Rys?=
 =?us-ascii?Q?4NEAfdD/DKrKI+QlFKaEeTppUexpCDEJ7L51cx1J0a/zDKfYvT/bcTMpk4hZ?=
 =?us-ascii?Q?oqBKCBoQZxYUbGDlOUM0zpbMU79j0WPGf8JyENbe03YYolHrWPBxXLX7rIwM?=
 =?us-ascii?Q?UAgN5c8Ccw0k4UhB+0lYDG1uMe2yWEfz3WOQbeo9QQeHY1NIRMntpOVXsU5m?=
 =?us-ascii?Q?XqDlAXr0ARzxcKToLpLLcIlFsacJdkkVQeJDCUwHkTK+oZvDmbQOA56XS3yh?=
 =?us-ascii?Q?+mwyNDQB6bSYgdIG99M2RG77JIG8P3hX28fygOurWzbWA2UaX73FYjpR8AGA?=
 =?us-ascii?Q?SJom0BylcYOp9pdC1svoT7knuA7oI/TV7mUZhP9axb/wgNTAZKpzjJYrmFIT?=
 =?us-ascii?Q?cI1DjMDBPPbx1BQ9j5cVGg1jxdNY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e+QOC/BzwchsMIM96TaoU1GgIzoPgwjELUKPhrOdQ7xsczeOCmWH7xQr2pEk?=
 =?us-ascii?Q?r7RW0Eabo6eW/TSFnzdgBkvVoJu1E34CgXVAjAx/gxHgXPtSmqHMZFeQhaSj?=
 =?us-ascii?Q?qkWsSsksF/q9a27iVMMnkZry3aTh2TP4TTs7fgkFcYgH6Y/ZLoYzgp/JEDTL?=
 =?us-ascii?Q?1oN+DPMPoG3QjA6EHcEinB87akE+9xaUfWYkRK8wi0uBVQpkWN9M3N+F4ilh?=
 =?us-ascii?Q?9muSVtPYIr7OLcC6us6tQDurTZI3tCHOVDsl4S3+0wl9HGJsYFcPBEcl/nIV?=
 =?us-ascii?Q?gG5FQ4q7dw7aKykNevz6Kj9vqGfw3uKmAAVSs1xN4ymPZOsrtIPlIGVPxaa+?=
 =?us-ascii?Q?1k9wda8nAGrMGA+uSHzMmwsPUcUfSespsj5DYp/iE+M9yHbT197PC8bCRmMZ?=
 =?us-ascii?Q?F+PjAZGUKqmL3VHVRwVoISa19T3mpNEyNJfB3fvHe64stWQRLAvNfGw1zLEg?=
 =?us-ascii?Q?SzgcRCzsi8l+gaVmmWoJrgx90fcjKQAjo7KK894Wt45o4OS9cYVFUFqJiHHE?=
 =?us-ascii?Q?E3YkoS+PmCfJjbI1Fve/C8MJNud0E9rKP7Hs3cvMDlsWFpr6THFUvBRfDPHM?=
 =?us-ascii?Q?0tkIBpuX6xIe76tpGq+nA6pODjmLK1BLh9vh2f41tfsWypXSAdefWspmhk5Y?=
 =?us-ascii?Q?I1wUxT4C7FiccYmJgwqw83MXjjTkKGcDoCGtUUmUClp2aNPCKtTSQfwavSb2?=
 =?us-ascii?Q?ybbvWRizJ35ccxA3bmQQyW8AqYkN7ronPrEl0vYffr6WNtbBOHgXJPJdYnlN?=
 =?us-ascii?Q?DXpP6mMdAO0tsU7XSWY4Wt7XW1v13CG9VaRqx+t/YHEwM0fBTaxsnjTesS+p?=
 =?us-ascii?Q?NuNIsrWyGAvOBuT7OLQ9GQHkilA+O4HUA79yj4AGWciI6AgZJgnkLr7dI3D8?=
 =?us-ascii?Q?EEqTolSH3iKVeUfm6hyZ3rItrNJ1Sr+9K0LZLnEgUZ71+/7BSuR8dI4rqweN?=
 =?us-ascii?Q?7MMpXs5D1kcFWnB/TN3OVBfe+R/xvtzEyDf+KZyHXBjmJ5gYDOHECZ9pKfnf?=
 =?us-ascii?Q?l4oBfLX/MDOsXcTs5lgJ3AwPGthTqVIZM6joXfA7wo1WEnXNNqJYvrbDnESf?=
 =?us-ascii?Q?fxs4rrSg5n8ny3Cs+BmwTjYleMws7udXFex6qhepGk36sURAuUwbUrcafHjg?=
 =?us-ascii?Q?Ht3gnwJWBCHO2336CWxPUBMWdTmWeL4WJcZPrMdQFUNg2I8DM89FrYehLCFi?=
 =?us-ascii?Q?XOb6cHhQYn5o7MGMSIZf5gCTJPcbU9E/5HARE8kYO2M8pR1bhgBgqVU4xt1J?=
 =?us-ascii?Q?C7dAU/4MeGYB+/8qeU//2vl+UgKMPwtRoiIQy0W1ShxEybk7zig2i+dJLlt+?=
 =?us-ascii?Q?xZ2c6Z7NOvZo22uEZZaC2BFSN5wTx39ui4iCRhDf9215kZEpCh5RcEGqxf3R?=
 =?us-ascii?Q?tKTmpVs5+YiKPu/QE0PgB3uz1AmHSLd65Zp39zGDQ6++mCaoHhRp+7+4CWDB?=
 =?us-ascii?Q?uzlY1zUwrzbvBOBS5qa3R5fwvHWhtcEGPLtRv8/AGJdMiflNvYtXLoEkULXA?=
 =?us-ascii?Q?2Nt5L66tnIVbQkXspwTo7NM5JXfq+Byst5cJL2bD+0/qlyF0pX0HV/Y+lufA?=
 =?us-ascii?Q?WQwr0BxVRfsraSwMNIt2bjF7Or6wpzuXWftInHeOFwEK/aFkjcuF1gnMmqb+?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aqE67DsrRo7Hbcq7Mn3rNTf7mWdakCTbedIcPz5ajBXsxcO6a0ftrtWrUtSVkjaoEBfKL5Jucr0XiZHOBGFAZZPgXfdJWR7W5B8U6mEmYXtHURaqPWZtQxfkj581ZgrkEIXHJXOHGXZCia1T91GueU2GaP2Sndn2Au0vRLpMGZqIsufSLNMY7paRUu6JlY2NaXUxEatJ1qMPL1WvjGizFGaJ/+v1GTlqXUZzH3HH1kAY0F/PnWy1MxCzy7OTG7nB30OZDTb200SoEiRYyeQyoqBZsJUM3zU20NNkF30Jn0syBi1XXIXpL9X42OsYk/Jz6vsKu2n0yXL+uvV5Oe6ZOHVRQcj/xs0oCaXbm0AaD0TlyaY2/X1gZW96lT4vD67Z0fLXQbtDghSG5ShI9cUQ5i0Dlz5wHavTpwl1BEHC2FFrnL4OeJyYxADkkzGKaqubvmsEizp7i77WYrVU8RGdGuEgpiRqyayMx3yH7JLak4yPPw+PMOfy032rlgcoaTwyLxPN9Ng/VIN0AtHsQaU1Oyl0f3ppidwF1JaPMwJ6K1+y84PiqX5OOfXrl7S0/sGABhaMiMlDGlZ4wnyKYgKedCqiOW+FAOE8RZ+PgrWlMyU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6cca85-025c-428f-9e88-08dd61300171
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 06:34:56.9729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHvKt04N8/Zg/YzHaMTmGs0nODuMFLQLWBwds3j9m1qIAJgnm8D94nOUmYNhJ4/Ax2+QmptOCQidTITQhu1gqjD3WUjyIwf1f0tUmLV1Yro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120042
X-Proofpoint-GUID: 6n-EgxlC78-6uULsI9Vb9ZqAwZchQX-t
X-Proofpoint-ORIG-GUID: 6n-EgxlC78-6uULsI9Vb9ZqAwZchQX-t


Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Thu, 6 Mar 2025 at 08:53, Ankur Arora <ankur.a.arora@oracle.com> wrote:
>>
>>
>> Catalin Marinas <catalin.marinas@arm.com> writes:
>>
>> > On Mon, Feb 03, 2025 at 01:49:08PM -0800, Ankur Arora wrote:
>> >> Add smp_cond_load_relaxed_timewait(), a timed variant of
>> >> smp_cond_load_relaxed(). This is useful for cases where we want to
>> >> wait on a conditional variable but don't want to wait indefinitely.
>> >
>> > Bikeshedding: why not "timeout" rather than "timewait"?
>>
>> Well my reasons, such as they are, also involved a fair amount of bikeshedding:
>>
>>  - timewait and spinwait have same length names which just minimized all
>>    the indentation issues.
>>  - timeout seems to suggest a timing mechanism of some kind.
>
> I would also be in favor of timewait naming, since this is not a
> generic timeout primitive, the alternative naming is useful to
> distinguish it.
> The wait can be off by 100us or so for arm64 when we need to break out
> but that's tolerable for some cases.
> I've also taken a copy of the thing in [0] so it can begin using the
> in-tree implementation once it's merged.

Sounds good. I'll keep the timewait naming for the next version.
I'm on vacation until the 23rd so will send it out the week after.

Current plan is to address Catalin's comments and make sure that
any fuzziness around the timeout is visible to the caller.

Ankur

>   [0]: https://lore.kernel.org/bpf/20250303152305.3195648-9-memxor@gmail.com
>
>>
>> [...]


--
ankur

