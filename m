Return-Path: <linux-arch+bounces-12602-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87D3AFE9EE
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 15:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB174E0627
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 13:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83902DEA82;
	Wed,  9 Jul 2025 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="inVKq1GY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XjxvQvYa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1999149C4D;
	Wed,  9 Jul 2025 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067172; cv=fail; b=iKc6wdwsI3uCI2wKmvLTtvOscWZPwpPBR4mkSFKasmNafSoe0AjXw5qTvpIbElt8lRwH6nYkrypzveojBNz1kSmkyT/a11EI+Qmr8NR7hXtkuRrR4niEcc58rG5XnY/9SdJ+ANRpg4KUONPl1NUJCv2o7OZcUGA3YeSictjraf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067172; c=relaxed/simple;
	bh=WdPPO95AFm9tpMCGK7tig/hN6n5XCVIwW4Nua/ruwu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TrN9Oybu6ZXi8bA9gPU0gMbHaLIO5O0zfl+a3BLCgGJpWzKcuOCAvG5I+fzmBZTNDHY/nPHVXTB7Nto43/SvTHajJrQrN1pecoNTT6S6gMXd3BpvXGDJ+pa2HrPzXFjK1xImCMqlMJfcZ3YINsLqr1zEETtUU6y/RK8a60yNPEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=inVKq1GY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XjxvQvYa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569DCbN3001372;
	Wed, 9 Jul 2025 13:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=v7Fkcv4P0SPFMGAaTT0gpfI5qXrqV4SemTo3AzVDX10=; b=
	inVKq1GYI16v9wwulPLCKeMDqqYY3XhdAAOxFt1pa3DkcPqSGkfMGwnDsYpN3lzY
	Wgx17PhiHXlIJ5LkTvIM1v62YZ9kNxmpICOv7EArahgqJgOQNlOa6BmgJZ5HULpZ
	8IHQUjO/xCL5Zs+5GORg8zkZLNqGoEmKcBIjhfHr1skmw9pK0pmbzwruVM/z6ZbS
	EWwWA3LREMjxMRo2ny+pQ/sQWeEZCtJCI4EsvZlk6whM/TyiK7a7wpsXUZUoznn+
	k/X/OKY7QAMgnQZFsdrphPlSPRxO5HAQuQdJ15SJAUG+RlYMOFFtvsQ+vWycFVBh
	grOwpZvFkrXZGGkD1oe95w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ss3hr0fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 13:17:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569CuMxP027228;
	Wed, 9 Jul 2025 13:17:36 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgay4v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 13:17:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJKBo0jOBVd7sE8bsm0ppSGpYkgR62gmoEoagcelt422oAvW+v1CCNfdprB3uJFUHUKzyYH43/Cd6r5tv9A69m67U9pFwu6UK3TMpV60HfkSWTbMMQZpIrLG/ijqueQAWvsrSsnool6EjjDl6gCn9GgSEE8o5x6OaB9NiS7plAIdkzSQzewMghqmjFs83XinRdBqG7YRHOof8DeSfOvPfnxpctGJK2GOzDCrZq8K5f5eWN1UaSYAsfhcCoQQ4kEHgT5mksB+lMlcR4SyDpPLP28CSI9qxlnYvjJBFJdfGHSQUY/kTRGXCzTTJ3gd5ja6Xiff8ka/anTi5Uhlf3n3JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7Fkcv4P0SPFMGAaTT0gpfI5qXrqV4SemTo3AzVDX10=;
 b=iAbRoXRrZ18hgD90vyG8b21IjaX2ZqYmz8wZlIksDtecWYcQhtw9+mssfhi4J4jmpM+TkcFXlQgLWPAJyQ2Y+BO2KEbbbqfQeyu7MOz9isojwvoNgmhbT1h9G4SmAyEuPbo1U3eNNnrjpEywaj1mw7hbO/LJBOqq8jwMVRHiiuIYlZHznDwPjMqVbgdEaB0xEYw0SG6835AJIMFrkxiJWqE/oxpN42Ase8fO9m5FjdXYt4uta6GfxOFG++HzCXnFKncTfXO4ekAVsx3bk77Gt/hHnvrR5f+ZbU1fNu2GA+lDFYhLB0xKddbzPLJAJUu5ttyt1d6FmQIe83ez6+/dgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7Fkcv4P0SPFMGAaTT0gpfI5qXrqV4SemTo3AzVDX10=;
 b=XjxvQvYaBxvtGIFUvgRoLRJdikGSLJ5D3d9pToCH/+nkCj+l4eKZC6VOM2m6FLWSIu6Agrbj5+wYlc7eNYLQBYuODkknWXYsOHz2pwu2Vw4gSwjXJD7mUTijySzEon7YpnQZyn6GaYjCqBuvvn+yHdHRc6ZoqT94UtfBi9t4zE0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BLAPR10MB4914.namprd10.prod.outlook.com (2603:10b6:208:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Wed, 9 Jul
 2025 13:17:31 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8901.028; Wed, 9 Jul 2025
 13:17:31 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@gentwo.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Joao Martins <joao.m.martins@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
        stable@vger.kernel.org
Subject: [RFC V1 PATCH mm-hotfixes 2/3] x86/mm: define p*d_populate_kernel() and top-level page table sync
Date: Wed,  9 Jul 2025 22:16:56 +0900
Message-ID: <20250709131657.5660-3-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709131657.5660-1-harry.yoo@oracle.com>
References: <20250709131657.5660-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0055.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bd::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BLAPR10MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: 6791509a-2599-402a-f25e-08ddbeeaf5a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S6l+fIcjH01Tt0q5ZTy4OuEG3D5Io7y2QYlRC/VQMyzEqyer3J2FKrb6HOoA?=
 =?us-ascii?Q?bN8kj/yk25DhpB/fHxiY4Pk3G6qyBfZFCTbUkROdl9sVS0Om3PYuydmBwNdG?=
 =?us-ascii?Q?x/66XrKe4HJoERERueuBH0Z5gjra9Q10qcK/YCqRR4Pf9XlLpHudWDedJp7H?=
 =?us-ascii?Q?kFVyvitzexG61cNlSlhTeCmW739/aHrwwYHdSvs6mWb1Slkn4C2hceEUwYlz?=
 =?us-ascii?Q?QsRyD46IRYXbbWJ0JZcmrZdKfl+SkKZDeriMXpUMG23L9sByLe0thHGts9Yg?=
 =?us-ascii?Q?FqdhAIN7IHuzrJYlUfEZmykn9hZurGJJmvQbj7Z58aUUE1JRPng3LKr0tiYA?=
 =?us-ascii?Q?oqpCJbqOXYfpDxNRS7rLogb4dEZgtHy7eMzbAuiwCkJ8OMx4xDXpnpaNBECl?=
 =?us-ascii?Q?uL4djgA0JOYfUb++nKHDCYNdaQ2MLM4tnB45o2ygq65DNgMTIA2bW3/uupIH?=
 =?us-ascii?Q?Mqj4dOrUYotWsWcvPFIULx2QFuhUkkx+hJz4k7wP74aE/cEXOGHSHDzmBChZ?=
 =?us-ascii?Q?Pk1ayA+Qt6N+3NbjxMBQyF3kXCc+8lp0R0WXR7iK7qQdtlkOE5V/7TfCFQl9?=
 =?us-ascii?Q?6rxK/XzOxPmQBtj33du1lIAnmez3/9nNy1grBDNbCorvREpU/hggyZhX6DPc?=
 =?us-ascii?Q?o6rJCtWJeZKeVNIz3m5acxFT+oGvDRCKwsUNI3BBc8z2Ne13CmNdK9Mxxs8N?=
 =?us-ascii?Q?C/EQB8CUQcKLXuI/yvgcbB3dikqsrkyNJrMjJdUJbZz6xdaqUTqjeMIbD87q?=
 =?us-ascii?Q?/kfltE0YYr+uo7SGKFIsBh4UaCD1ZDihIqu6DabMhUKAXcWhPnFiVtUmLKfc?=
 =?us-ascii?Q?X3dePkD++x/T9T09PT+6Hqy7qVefVkV32rOwkeorkKT3oJjLdKJpdXLXQ9bB?=
 =?us-ascii?Q?kus4EeN2S699Fzn2+mO1EMU8hQ/sziUNM7mFD2UZiLDQjB6GQxLBItU6dRNZ?=
 =?us-ascii?Q?3K6/4wQXUGp4SODuJt4V/A7U5JPfxEGeWhlKC1wGCSWAlfQIizG6TcqiCsEv?=
 =?us-ascii?Q?OgAvGRe9bGd4bEjGQNjbFSs+NQX/4XkqQsl3CLs6qMPquJIAX62C8FfBC927?=
 =?us-ascii?Q?esvdBPKi9+LWUx4VyVtbTNp8sGpF5UPjzc8YCO6EzgrpQe4I4do90jQQNUmw?=
 =?us-ascii?Q?B0VCCfwHfzvR8NO5qXE1MAQIuma9SA34vFrLyqh2wNmCWw14ZFEcFy7QfVF2?=
 =?us-ascii?Q?iGmiegK98b+aMapz94jvxMVyFHZbb+n9O4cnY6USeiA97QSt+/gQ+y0yZFSf?=
 =?us-ascii?Q?37iSNfu/6ViMjUth1ZcElfiyO5L5YXDP9W9c0jhmIzpZTt3IBjRsjjwhXE/W?=
 =?us-ascii?Q?FUfC6a/ZjfPU1wlnAx/dtasAFSx8oQJKxmoYwOk0hdMReBmw+3vO2zAcI6VB?=
 =?us-ascii?Q?Z6Sz8nRgaQUX/lrkFmfhUhvMpL4Ap2S8UeFyhopFDw6IHa7bnD+O6FxLY7NP?=
 =?us-ascii?Q?iO8l4NbD+KyL+GyKkYAioT1JsOwmjP5nEGAo9OJILhU+pBecRctTTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ZgI31QDvmy2KSyly7Fgj3YHMPCXlzePbp2+8XclaY7yTzmx5MX+t66unkZb?=
 =?us-ascii?Q?sHV8UTGJpwDscJEt/m3F7cYCqY4ym1Jd7aQLq8EFUzHPYtoR+abAGrYTDKyI?=
 =?us-ascii?Q?ZZgnWyhOJs7zZIyz+/zQsMBVmx/ZvWfBP9clekQaTEV8c1zwjNCbU6SO8yf5?=
 =?us-ascii?Q?+x1ZtOWy/MWpnFOL/PDtGYG32pUu1LFn2fp/pcmS3WgTCOrYi8pj+c0qfcrV?=
 =?us-ascii?Q?a4nDKBKXd6RXqklvh+PXiktmBbjjphp5KzvxaAI12PcrbXWj+RUUqfO3vsyh?=
 =?us-ascii?Q?aVTzKCiyWY51q9gQK23ZrgjjhDAv61TfbtDVGxvdxOwxI9gm13XB4wVSeP7w?=
 =?us-ascii?Q?8BBigX8W8lOOokb+/fNN1SkDeqlRdpLMi9xqe9Q+2oZvplnCpttIRiB5vLsx?=
 =?us-ascii?Q?8zWqsDcALgzs5ynsAWTT9ElVJvIqdJ6PmRwtbj3P8rbkMJLZmKS6ePAOcYQj?=
 =?us-ascii?Q?2eN9ZC7lBFXsKgsFlldtMyJ7cTaH5XxnjgohQM1FEr6lWrm9jQ3DLCsVrxyG?=
 =?us-ascii?Q?+LWZtA/lLyr5RQsT0XNlL+cr9caX/i7qjVnQACQFbyo2QCLSsbzJWbHrxGjM?=
 =?us-ascii?Q?9rWu/RSmddUvdgEwu5o19kzt0MUN5UR82mjo6Vzt9ZQPYa5I8QECqX/AFfTr?=
 =?us-ascii?Q?o8QF07XqAj3uVNmuAf3x+O9JNmnhnlPtwIoSPg4ao/YqacixgoRd+8koKy6i?=
 =?us-ascii?Q?3+VGznmIO2lRl6QTO1shWEMNI9J19MMcQZz7Oh0a3PnqOztSyE3OJto+9pen?=
 =?us-ascii?Q?xE7LlDHrXI2N4JCuX+VFk1WmGvtvZ5wcou920PTQrKXvqY+9aYm19VAp19ff?=
 =?us-ascii?Q?EImZLPAWnmQD3D21bBjKQPtMR2PRZ5Lsg/qu9+XHnCKr6qgsYFGlmhXVWzVU?=
 =?us-ascii?Q?SWhPzmjZkDwZAq/4P+D9jvkkRm3ziPk4bbhq/0Yy5gDuGuqrhukJ7Li+lhRq?=
 =?us-ascii?Q?ecoEvBl23GMUCvxUJ3dYc/sf2JcRSHDb2qGZBwvi03i8niYsb0ZsQvleG20A?=
 =?us-ascii?Q?lRZ9EatGjBOGeifDbVec3bRZ1Zzc8zAXHyIhKQKtgLy7dqybz1qUOJKfJqf8?=
 =?us-ascii?Q?Wq2pvdPBueCn9ngR0dcI+VMsLIvJZVXFTI4Qo+ESFxEyqm63fS7ANPBLA2qG?=
 =?us-ascii?Q?An9ktWCMqyHZTb5yletLwCE6H1KAMBxMvWByciLa117IwWdJS2fbFI5saz5e?=
 =?us-ascii?Q?ohtUWv+QvB/emb0QY9OoggaEdOuwcYV25o03/qfRhle4r4x77a6o5my+Yd40?=
 =?us-ascii?Q?OB2pzn7IzQols21cMLCoTnUE6+hfYbT6q/jX3KzmrM3F+XNfdjCv55n7Wdz3?=
 =?us-ascii?Q?CCxEhbM0wjZOwqvmx8dEe0p5VNAIjkYzxHqXbhygSN7eByE3INBeHvJgGnYi?=
 =?us-ascii?Q?WKHkCC1hIFT+HO6VRIrJhg8mo+S8PPlK1ICF75i+D66WSg/hR+Qm2ITbUnfR?=
 =?us-ascii?Q?luFlItqF2sMvr77QdZg76wkoJD02aLzz90jNg9Iiq4D/lw3katHDG5yqZNFM?=
 =?us-ascii?Q?CqIiIxyyIGDr8+ZofSiGHPxIRgDobp+AEpkGuPbIWeoZ92NbnGW7jnhfyH0f?=
 =?us-ascii?Q?4TqNgLe6W4v3iSqTxOKF6eaFDRc4BTRLIw/F/p1C?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GneiWcm6E3kEA5sP14DsrbDISy0HCcpLABtOzbJYpOTOHaFJbFVh+KyVTBX3k0ZkWtd8hOOP2lrf+Yfe2RqG/w1Xq3UUeqLh/eE4819rgmVkr7IuzM5u4L5nTDhoeGtilJtzT4lJc2BMiUFoE5tqBRUxstJ6ci4Nq5uo3l12uhMm7WiEyKGNpSl+N2h0ul0S3De/kb3xm74BSoIKC6uOzZd0KarZDEDgLQTUPXwwUBOo9G+88tEnPcrAuzi+5fwH9wrOVOhmTGBOUJyfyBaOWIiSrikfRZHov0Qh5vgr19XdxFfF5qNK4GdQEzmQSHa6ziOrk+fbymWMdIxXEDQFQvm2fZEAYIjjpZI1jYgHHCwuULqiFQ5Vb4NImvqeap0NEB2NAuTFJtNsiv6BegIDmvXxeja13dAtC1o5GHeT8D7ZjMLUcarp4h0S8AiPfJsez6KF5CYK3uspr7OFxitR7r0wKXvRJ2Poflztm0oReYO9/bKNPKCLHlK/pwnu9Hel57e1altU/LBaHAOTUuUWNBQsVyFlVDeTU0bFi8bvUDAg7Bj0aqR93GiHsOKqLzkDjS4xy1rpB+HMsHCAkO9cUGNEJ6AbfHmH18SMcEFtYS4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6791509a-2599-402a-f25e-08ddbeeaf5a2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 13:17:31.1407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bO6DFAvOPnbHI5n1yIwp+vZRxMF2suSkflGHWbqVmWSCiIRZq9ZZOadp4hrUDKV07gZ90PuVfJHbNXOIm0djag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507090119
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDExOSBTYWx0ZWRfX54xbhmAKMOKT GgMYL8W4anTRsg6qaAoMIPd5uS+bJIf7H9rTCHGXSo2Jgu26aDbdWhSRyIGAIgy1Lc5aKdfYyyM g142lM6jkSzgRVnRru41ueaI1/kiOS7i2OwVu3ko03SSUVUdHn47yCD5J3gvfC9ONDVEnbitkbc
 UrZiTDOzX+ztuU3TKiXZSdqz/zAGssj/VAa53McyTW1bBH8afRHpTN/40OzRzN3cYFhNs3PhinL aFIlydprMIU9q/gSeWuk5EyYt+GYLvRsZa8nbvqtWUnp007UkbFVevjrwr5wj8+JwQOYpbFkuOQ MyQS3X8+wq2xiQwm/U6v3uRs1WDZcQZhStpuWjlB4I+okwrNBhiXo7/dmpQivGUJPUskvP4UQib
 iNxX5D65i/IZFXl8ar6Epb6oEuxRhbVGktLEG7zyIAyuwC0BJRSbMJ/nmYhL9M2O7wvqKKvY
X-Authority-Analysis: v=2.4 cv=Vt8jA/2n c=1 sm=1 tr=0 ts=686e6bf1 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=9gk2oKirEVN5O5Criv0A:9 cc=ntf awl=host:12057
X-Proofpoint-GUID: z8muAUcg87FBxdY7Tx56Fyzn_yTK3sls
X-Proofpoint-ORIG-GUID: z8muAUcg87FBxdY7Tx56Fyzn_yTK3sls

During our internal testing, we started observing intermittent boot
failures when the machine uses 4-level paging and has a large amount
of persistent memory:

  BUG: unable to handle page fault for address: ffffe70000000034
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 0 P4D 0 
  Oops: 0002 [#1] SMP NOPTI
  RIP: 0010:__init_single_page+0x9/0x6d
  Call Trace:
   <TASK>
   __init_zone_device_page+0x17/0x5d
   memmap_init_zone_device+0x154/0x1bb
   pagemap_range+0x2e0/0x40f
   memremap_pages+0x10b/0x2f0
   devm_memremap_pages+0x1e/0x60
   dev_dax_probe+0xce/0x2ec [device_dax]
   dax_bus_probe+0x6d/0xc9
   [... snip ...]
   </TASK>

It turns out that the kernel panics while initializing vmemmap
(struct page array) when the vmemmap region spans two PGD entries,
because the new PGD entry is only installed in init_mm.pgd,
but not in the page tables of other tasks.

And looking at __populate_section_memmap():
  if (vmemmap_can_optimize(altmap, pgmap))                                
          // does not sync top level page tables
          r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
  else                                                                    
          // sync top level page tables in x86
          r = vmemmap_populate(start, end, nid, altmap);

In the normal path, vmemmap_populate() in arch/x86/mm/init_64.c
synchronizes the top level page table (See commit 9b861528a801
("x86-64, mem: Update all PGDs for direct mapping and vmemmap mapping
changes")) so that all tasks in the system can see the new vmemmap area.

However, when vmemmap_can_optimize() returns true, the optimized path
skips synchronization of top-level page tables. This is because
vmemmap_populate_compound_pages() is implemented in core MM code, which
does not handle synchronization of the top-level page tables. Instead,
the core MM has historically relied on each architecture to perform this
synchronization manually.

It turns out that current approach of relying on each arch to handle
the page table sync manually is fragile because 1) it's easy to forget
to sync the top level page table, and 2) it's also easy to overlook that
the kernel should not access vmemmap / direct mapping area before the sync.

As suggested by Dave Hansen, define x86_64 versions of
{pgd,p4d}_populate_kernel() and arch_sync_kernel_pagetables(), and
explicitly perform top-level page table synchronization in
{pgd,p4d}_populate_kernel(). Top level page tables are synchronized in
pgd_pouplate_kernel() for 5-level paging and in p4d_populate_kernel()
for 4-level paging.

arch_sync_kernel_pagetables(addr) synchronizes the top level page table
entry for address. It calls sync_kernel_pagetables_{l4,l5} depending on
the page table levels and installs the page entry in all page tables
in the system to make it visible to all tasks.

Note that sync_kernel_pagetables_{l4,l5} are simply versions of
sync_global_pgds_{l4,l5} that synchronizes only a single page table entry
for specified address, instead of for all page table entries corresponding
to a range. No functional difference intended between sync_global_pgds_*
and sync_kernel_pagetables_* other than that.

This also fixes a crash in vmemmap_set_pmd() caused by accessing vmemmap
before sync_global_pgds() [1]:

  BUG: unable to handle page fault for address: ffffeb3ff1200000
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 0 P4D 0
  Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
  Tainted: [W]=WARN
  RIP: 0010:vmemmap_set_pmd+0xff/0x230
   <TASK>
   vmemmap_populate_hugepages+0x176/0x180
   vmemmap_populate+0x34/0x80
   __populate_section_memmap+0x41/0x90
   sparse_add_section+0x121/0x3e0
   __add_pages+0xba/0x150
   add_pages+0x1d/0x70
   memremap_pages+0x3dc/0x810
   devm_memremap_pages+0x1c/0x60
   xe_devm_add+0x8b/0x100 [xe]
   xe_tile_init_noalloc+0x6a/0x70 [xe]
   xe_device_probe+0x48c/0x740 [xe]
   [... snip ...]

Cc: <stable@vger.kernel.org>
Fixes: 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory savings for compound devmaps")
Fixes: faf1c0008a33 ("x86/vmemmap: optimize for consecutive sections in partial populated PMDs")
Closes: https://lore.kernel.org/linux-mm/20250311114420.240341-1-gwan-gyeong.mun@intel.com [1]
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 arch/x86/include/asm/pgalloc.h | 22 ++++++++++
 arch/x86/mm/init_64.c          | 80 ++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index c88691b15f3c..d66f2db54b16 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -10,6 +10,7 @@
 
 #define __HAVE_ARCH_PTE_ALLOC_ONE
 #define __HAVE_ARCH_PGD_FREE
+#define __HAVE_ARCH_SYNC_KERNEL_PGTABLE
 #include <asm-generic/pgalloc.h>
 
 static inline int  __paravirt_pgd_alloc(struct mm_struct *mm) { return 0; }
@@ -114,6 +115,17 @@ static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
 	set_p4d(p4d, __p4d(_PAGE_TABLE | __pa(pud)));
 }
 
+void arch_sync_kernel_pagetables(unsigned long addr);
+
+static inline void p4d_populate_kernel(unsigned long addr,
+				       p4d_t *p4d, pud_t *pud)
+{
+	paravirt_alloc_pud(&init_mm, __pa(pud) >> PAGE_SHIFT);
+	set_p4d(p4d, __p4d(_PAGE_TABLE | __pa(pud)));
+	if (!pgtable_l5_enabled())
+		arch_sync_kernel_pagetables(addr);
+}
+
 static inline void p4d_populate_safe(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
 {
 	paravirt_alloc_pud(mm, __pa(pud) >> PAGE_SHIFT);
@@ -137,6 +149,16 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4d)
 	set_pgd(pgd, __pgd(_PAGE_TABLE | __pa(p4d)));
 }
 
+static inline void pgd_populate_kernel(unsigned long addr,
+				       pgd_t *pgd, p4d_t *p4d)
+{
+	if (!pgtable_l5_enabled())
+		return;
+	paravirt_alloc_p4d(&init_mm, __pa(p4d) >> PAGE_SHIFT);
+	set_pgd(pgd, __pgd(_PAGE_TABLE | __pa(p4d)));
+	arch_sync_kernel_pagetables(addr);
+}
+
 static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4d)
 {
 	if (!pgtable_l5_enabled())
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index fdb6cab524f0..cbddbef434d5 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -223,6 +223,86 @@ static void sync_global_pgds(unsigned long start, unsigned long end)
 		sync_global_pgds_l4(start, end);
 }
 
+static void sync_kernel_pagetables_l4(unsigned long addr)
+{
+	pgd_t *pgd_ref = pgd_offset_k(addr);
+	const p4d_t *p4d_ref;
+	struct page *page;
+
+	VM_WARN_ON_ONCE(pgtable_l5_enabled());
+	/*
+	 * With folded p4d, pgd_none() is always false, we need to
+	 * handle synchronization on p4d level.
+	 */
+	MAYBE_BUILD_BUG_ON(pgd_none(*pgd_ref));
+	p4d_ref = p4d_offset(pgd_ref, addr);
+
+	if (p4d_none(*p4d_ref))
+		return;
+
+	spin_lock(&pgd_lock);
+	list_for_each_entry(page, &pgd_list, lru) {
+		pgd_t *pgd;
+		p4d_t *p4d;
+		spinlock_t *pgt_lock;
+
+		pgd = (pgd_t *)page_address(page) + pgd_index(addr);
+		p4d = p4d_offset(pgd, addr);
+		/* the pgt_lock only for Xen */
+		pgt_lock = &pgd_page_get_mm(page)->page_table_lock;
+		spin_lock(pgt_lock);
+
+		if (!p4d_none(*p4d_ref) && !p4d_none(*p4d))
+			BUG_ON(p4d_pgtable(*p4d)
+			       != p4d_pgtable(*p4d_ref));
+
+		if (p4d_none(*p4d))
+			set_p4d(p4d, *p4d_ref);
+
+		spin_unlock(pgt_lock);
+	}
+	spin_unlock(&pgd_lock);
+}
+
+static void sync_kernel_pagetables_l5(unsigned long addr)
+{
+	const pgd_t *pgd_ref = pgd_offset_k(addr);
+	struct page *page;
+
+	VM_WARN_ON_ONCE(!pgtable_l5_enabled());
+
+	if (pgd_none(*pgd_ref))
+		return;
+
+	spin_lock(&pgd_lock);
+	list_for_each_entry(page, &pgd_list, lru) {
+		pgd_t *pgd;
+		spinlock_t *pgt_lock;
+
+		pgd = (pgd_t *)page_address(page) + pgd_index(addr);
+		/* the pgt_lock only for Xen */
+		pgt_lock = &pgd_page_get_mm(page)->page_table_lock;
+		spin_lock(pgt_lock);
+
+		if (!pgd_none(*pgd_ref) && !pgd_none(*pgd))
+			BUG_ON(pgd_page_vaddr(*pgd) != pgd_page_vaddr(*pgd_ref));
+
+		if (pgd_none(*pgd))
+			set_pgd(pgd, *pgd_ref);
+
+		spin_unlock(pgt_lock);
+	}
+	spin_unlock(&pgd_lock);
+}
+
+void arch_sync_kernel_pagetables(unsigned long addr)
+{
+	if (pgtable_l5_enabled())
+		sync_kernel_pagetables_l5(addr);
+	else
+		sync_kernel_pagetables_l4(addr);
+}
+
 /*
  * NOTE: This function is marked __ref because it calls __init function
  * (alloc_bootmem_pages). It's safe to do it ONLY when after_bootmem == 0.
-- 
2.43.0


