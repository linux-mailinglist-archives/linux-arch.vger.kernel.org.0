Return-Path: <linux-arch+bounces-12600-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63E9AFE9EA
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 15:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015D1176E26
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 13:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD402DEA75;
	Wed,  9 Jul 2025 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E2aNvIzw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pt4LJ0ll"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DD82DD61E;
	Wed,  9 Jul 2025 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067116; cv=fail; b=DhDrqNxRAzl91uC/oQDKkzNgF0MD0bFFnCuv4Vh3zDwBPKAQF7lLjkF1NiSQ1ai2IObIiir8j330cDLJ4sQV/gGimdqkpVp3M5Z1jTOz2WAvq6TeZxeKY1IHhPu6OWAVdrdIsXrowuTYeLQkCsyN1e3Fh2Ice2hWu+D7sSKSHpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067116; c=relaxed/simple;
	bh=Xez3db7sxvP0rJjI4ggGR67NBPx9QUKsJZ5DqbuinVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FV7StIxiXrLkNw7Qo3SM2VsosWIwPw7jdEyevMYH/9ZdXDX5vrbL8ZjoCWlpsIOG0oS0LpMH6nA3HasosiwASZ6RVEbXwCw/oe4nTuQyFxAWfDDgTe/bosQW1nQMQ2qbHKwatuo8CUKVCSlz2s//XJwRE4FD/5eTqcoss9Ft5K0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E2aNvIzw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pt4LJ0ll; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5699jLYx027022;
	Wed, 9 Jul 2025 13:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5PCRgJ5w/PyERCe5nZWe7dTn3YyJG3rnKdSAcKx1tFg=; b=
	E2aNvIzwJPm+UhLlQXEY+DgkJxy5vAWA2BSndzzc1A6zuwZn1F7GmtTj/cROD7PG
	mabXfJ5twoy6V4J0auDLHqQLgsqxxwU3j8ctA2FwR9RGeF47uv/YB5bZd8+BV83+
	fKlvWi88sin2TgsseRYPUzsa/2vRButnrdGpPlH2y5YcXo0VFxSgUWjPAB+0jTWM
	3nb7TkTyDE2+m25H4oaOcI8DiJ/m0UshF5eER9vbgeA8s2YkrGm+hZp01C62+rjc
	vdO4woiPHeQXnsahGC9P/Y3Ni99Nxgkgxb1ajpcWSghTitvC6MUz6kz7X7+1yNek
	4nhc4cKIq7GQh7Exo0wxOw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47sp2rgbt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 13:17:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569CV2Ng040464;
	Wed, 9 Jul 2025 13:17:39 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgb74r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 13:17:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfguE0NXpZD5g41TmgXMu8+5XRfaSAgYSmFAPa2t4xGYzwdfuZjCeX5mjzjIfFzRE8wVG0dsk8Z19ckPY1FBpUKDCmV36VD5e0LturXCcg8oG8iU3slqBb1ONZheCnA8yTehK27QHC6MB9lhsQnbfWV1PtI99JYP1gogKtux7VG39RE/frtvPRrVce4u0vvKsi0R3leVVJNuXUD5XrIO1oD+T2dP6dIsO6VVtlR8d4U3ZhejKV12FtmzadfhTEsrBrypDVGNmxPOgta+hB97zHAydXPx9E/EPutCtechJKgvEcLbyOGRe+5zBth793GuRPqXxN5loeEdaLvHNMUsZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PCRgJ5w/PyERCe5nZWe7dTn3YyJG3rnKdSAcKx1tFg=;
 b=a9tyLPtaCvK6qege6n7D+YYDaXziUKG2o7QfGE0S7k9oJwCex8X73LmqGGxux87K4UqOygTxCmDiY1sWIeco2M23OnBM16QcBbpBjkIut1gWmRPyXrCJjK+WeR1/LxugvOV55kFLMk7Q9bklFl2XHsfTsUSEUZX0eO6JjhHsL6caMqM/MlVqN9eP73rHfxtHyIuZQIqVvrG5t9BYVqJ97NId/DksQUkwE/gK5ZJXBPiXmKmbAHEYJggmcsdCEEKfPFrVtmHEmzEBYr+42eBMwU3Z0yNuw71Baw3R4Zp9upiizqGFqbYiLTQeG/CcRMMgD7mIIeiXnrjp89qGKDCEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PCRgJ5w/PyERCe5nZWe7dTn3YyJG3rnKdSAcKx1tFg=;
 b=pt4LJ0llKZcBY+BaKQuSstrwl5OdwphV/XSRF9931I0/iPqrGmbmX2FvI/TJR6AgrNuyN7Qd/cPwxOlf87o3mT8vJtQJcfIYd6teeGivARNduU+ooN7KJaOTMOZr1iLjh1k7C0lmbMOcs/lByadp5d61hnyTgG499kXw/POoJgI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BLAPR10MB4914.namprd10.prod.outlook.com (2603:10b6:208:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Wed, 9 Jul
 2025 13:17:35 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8901.028; Wed, 9 Jul 2025
 13:17:35 +0000
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
Subject: [RFC V1 PATCH mm-hotfixes 3/3] x86/mm: convert {pgd,p4d}_populate{,_init} to _kernel variant
Date: Wed,  9 Jul 2025 22:16:57 +0900
Message-ID: <20250709131657.5660-4-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709131657.5660-1-harry.yoo@oracle.com>
References: <20250709131657.5660-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0143.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::22) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BLAPR10MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: 818da0db-38a1-42b3-3d7f-08ddbeeaf7db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SSPVl2ayioItsEoc3COZlmLo2aCB8kGQoDWQosh0Bc8toB1sdtUsHrP2XUg3?=
 =?us-ascii?Q?CIjEHvjAXlqqOf5nh6+p9TTmoNwi5eO6kSzPe+cqldUONBPzlgy5SFE225g4?=
 =?us-ascii?Q?44+ByL9zMx5Ecc/Ks6F/sAf1QeJ+4ZldePzJd3RaRrYqaJHHtqkZp6zqRtqN?=
 =?us-ascii?Q?4buHMfLpLxJtzAhRSkQSCKIndE4x0CGpgKsG14qbtz/M7000LH/D3yne1khy?=
 =?us-ascii?Q?5mhtLx+KBdYhidF3tKiPON3q1saDeuX0qpfNQRntKkDHx+9U2b/qmuoH16zD?=
 =?us-ascii?Q?b8Tjcts4XKz2vvL65hZ+Kz2m2yBa+JZ1B5I8nvqz22YqbBPaJ2ziMPsIBAg3?=
 =?us-ascii?Q?h+noN1LSOsLlH258XyaQAtSPRxYve1XiLcFBEMI3bCIbIk9EUZePGMFfI3fp?=
 =?us-ascii?Q?UlP5nz4Qy3eau1d+rvSXLGBBbmVtTwZCv8bS3sktF+em6st/53pKD4tzdMOr?=
 =?us-ascii?Q?r8zMJ2UeulwF2Fb5VF20nbGizlt9VutuLXTW944oZ5M7Q3939S+4lRWK/4UN?=
 =?us-ascii?Q?rQiuP21FUxMbjhh3FY8sOxggQ1AhDCdqYiSSudC9VmQ/DuNJCCFcSMINVl/N?=
 =?us-ascii?Q?rHzSmHdh977mBXhpUNCX9P6WNSCG5dnLvQGcj1AuQEXDlxfIrHXTfEqdaAC/?=
 =?us-ascii?Q?8np22z4AsEiRM2I2RXKLHnU6lJpaiUyis0daK2CnUnUvapfuiVmTdDBQ3lZy?=
 =?us-ascii?Q?e+ej3NBj3z6izX3a9mv3AeIc14j2QFmz/mbtsyCjcJqoLFrafeWybMzWtbcc?=
 =?us-ascii?Q?ox04GAU2K5l8ZpCwxkcJ5BrnHLlHCTFuqbUnywdjBnTIw+5CzTg4OKy9Plfu?=
 =?us-ascii?Q?SpFllgTNY82ANtB8O/dXCZVNBTtcBZadldFt1t0De9QMckLko8nym1EVhft1?=
 =?us-ascii?Q?7VpsVNzKcoYNyvhO4Y1SWpho6M/hshc0PVhpgXFqx473lDkyZmA4V0IoeHtF?=
 =?us-ascii?Q?gDwUHtB/bNDJVAKZAbgaz7lsin/CvWj9xrMTRiw2XoePoa8xGrvaALXRu13l?=
 =?us-ascii?Q?pbSMBq1Kjwoo6KuN/HFzOb88iBKEIEkRA57F7dTJz1Obn5h5Krgmkl0IZaWk?=
 =?us-ascii?Q?wem7pNqHMWXoHej5ZcoFAgMVmFSdAzWaUKFlqQcIRGykTXDK6JCrXGbrI3k5?=
 =?us-ascii?Q?+FiZwEftV3Dmw0ZBX5LroQxVV7tVm/47/BwLPeVtnHnLO3hAu4O88Bd0OBs3?=
 =?us-ascii?Q?sbIUx6T5pPOB6Rrzp+zFd40VMdKI2LkfBhyUYXYQBTy7DD9N9Ta7NYwbzz47?=
 =?us-ascii?Q?XNZwoDYRHXEsLqWOVkb4330+AcBT9ayZ1OtpGH3UKkv62uBc8uKYUaH8kX/e?=
 =?us-ascii?Q?eQwKQFgCeS+ih28gWLN1oj2l1XKoxaFHAWEjIHmjqJdqshfqWhVeCAb/QFwk?=
 =?us-ascii?Q?kGR7s24KoyI8E0X4++wdi9S3frRPNUK0xHI82XS5Bf5TVQgr0Y7DSSmq0XuU?=
 =?us-ascii?Q?h45K2DU1nq/l05uOHavXxMsAi2/qTADOqtm/zLViHevkdaqgg/dbZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s5Fr6ZeQNLHSOsIgzzHLWX1qIL+7Te5V74J/kY3uNRqwXC5TTnDx8+FZTIf1?=
 =?us-ascii?Q?9HeK40W3OTcCo4VIWo0qaISeEvIJhp/ApQgZYDgcZ91t3rl8CRYyTiFWEjif?=
 =?us-ascii?Q?NZM5o0Qc6JZFetIX1FVzMykFmJb7w7q7XXUAXREROtE5/IDMhKV12ZxtTqIu?=
 =?us-ascii?Q?O4VzOiUNr5RbR5R4S83vikpcOTNt+1fmkbRV1C0dV/FOC0Z5nz5bK0ZOOVzz?=
 =?us-ascii?Q?Ir2WD3aPPR+FMhXkGk0EC2C0Wy0ZPi0uwkl4BDFjWmb2jFcm3j6B4IB+E4Te?=
 =?us-ascii?Q?pnLpby5qhq26ryDD1E1du7CjDfIHJSuK2x/1t7GP3byvMOcHo5bOmkPuFvWJ?=
 =?us-ascii?Q?IEhWOMnH7ZlBWRFXJmmS+pugA5o6vfZGaAFHEHXHpKOo7CLHjPk/+O1ERxby?=
 =?us-ascii?Q?5Z76ebDiAA7RV3PnJO72s7Iz6YQv0qhErUOSqlQajL2vSyfkoTACaheugfqz?=
 =?us-ascii?Q?jArtwDaapo1U0m9Qsmbt4YAbiQbO42cd3y5xJMmXF6xtq9N6XZ882selno+w?=
 =?us-ascii?Q?gqy16RjR5YV4o7Iw+5BHrv6fcV5Si4mWotN7SP13jRxyb9kXIawjZ3R8bpdA?=
 =?us-ascii?Q?KvdqjwUmLVUKgFrF0jJni2Z/0tgfR4VNGX7gOeBD1fj9HkBJGEO6V2jbfeN7?=
 =?us-ascii?Q?4m5I4BtkL1LIH2yIQD5Y5WxBCrXa16S0zTL2RexeVVtetWIgUgJzwIBXKQfq?=
 =?us-ascii?Q?rEX7GCKB+gUkxkhTEHP9QDwyQTjdmJ7u35JexU2TMN+QHGqGSUq92WfmtiFg?=
 =?us-ascii?Q?Nfqn/Ujz/Vjle/WedquH4Fr337M+4IOKv7Uqb0TwiCQp+gdziDZqnI+py85Y?=
 =?us-ascii?Q?iwzITgPGoGKoUMmjiJesLyHAsU7Y4l0tw9ctEzrcMQANy8SJaT1gl4sxxjHt?=
 =?us-ascii?Q?BnmR8Hvx34FuZN1k0vnITNwV9ThmaKIzQKNHaTPbrYYvxP8arIsuUjtobnO3?=
 =?us-ascii?Q?9H6rlPwn385X/j+PApdsItdp5dZUcfLxJmrtfNt5xEk0ArpAuHgA+EddviGT?=
 =?us-ascii?Q?cG1MUE+8vi+aSvE31s/IFzyy/1qCjpLX3CCuIMgB1iSdCUp2/PN0mRPmRLGz?=
 =?us-ascii?Q?dX2Kkl+YL8jyXKCLtOm+Kxy/yAQ48Qqt4OTgbzCdN/YaxvzTYQUv+A1C2MQt?=
 =?us-ascii?Q?nPHq1rI8D3fTVUvXAlcpr1d4N4LPDqOmxtAvWCboS+5rIoId21WbD1W20xKG?=
 =?us-ascii?Q?9eljdvjA7zg2j3CW7Alc2E2z1hm52gC2PyUD93zNMfv0qQAVjnRCHyCmi+sv?=
 =?us-ascii?Q?8Qn1dPdwZUFZl+dBZQwzz1BkmS2ek7Do3TkI0QfT2qauf/j5rCJRNmgpvttI?=
 =?us-ascii?Q?zVV9kmppmnKyKfHkjcyhHCb5i6DvRfMBvWPNtP3oU6FWCCnJm9HydnqfGnE6?=
 =?us-ascii?Q?uiUj3nPqXuKMUgNgw7CLyKm584Cp8p2omuJXNnsOH1WUDTZ6BEhJc61W6y7S?=
 =?us-ascii?Q?hOqyDftHT/Ys0DySfvYWMwBQ4ITIhB5vYOLtz8VdjBS0b0Fm6J29ebjDYLUq?=
 =?us-ascii?Q?LxzT+gaEfax/BMwxFg61odYXUYqdeHe27BFjq5bxiRAkgeRDYKd/sy0pXPd8?=
 =?us-ascii?Q?IqL5LAk+lp+15jKw3F9sBwbs2pVioeKhTX60FPyU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JBRyhaqKOBtF4bCQobvY/0j/Qcxz87zzmQJsOIR8pqPSnhe4DGDycwSHZy01M9HsXYfmgM2hhfsNX9n/bAi6dCoP6R4ueBBQ+Dgbl0WPmKQNind38TBrJ5OlrzLCkEyV6j5NAHfIHNG9mBrRCVi/rnuqAuA2EAHrgVSxiAZVmq2OJ4Jl6xnF71XO+gMfFyKbN93RDEEITDmUbpYo2ZcqrtRg/2QhbSIzHNK1QMulz2OdYFywfC8gl3YaJKdMm/s/yvXQb3g2Y+vVERVXiNikLGL9fEEZOjuqunuoUld61TiZc/dcM3f0VBkLqw4SsBVlzSlMriWSA07YIGXpZRzpPgMFSAlepBV7ALwfpi4uTDkl28Bg9wfxNiL6k9XdmqoSBeLYFkFFFKX9Bj0AA14xzNezEswQGscaVCWqwipfSFJeFsYRaiykn/2aQj/P+VoI+SJ470H8l8ga4g5tOqEjuU/FIunwQ2T8mmxSz/Tk/pTf/RaoNeXy7Ef2T/OkVo1AkT3KxAlmKWk37cDRkh25KRlCADLUI25QC+hy0E3swjtgMjctrwCK+RrcXPQQjm57gbZpOfOujvLzuvbckF9QxuL1+9WhfR7si/eWpInAPvI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818da0db-38a1-42b3-3d7f-08ddbeeaf7db
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 13:17:34.9296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TTgQVdn/m8nyOy1AH9IFNCUuLRZKEKH11n365jWfM+UaJKGoRLQF7btsQ0aSSefi21vq98jKtIAOPaMLK24og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507090119
X-Authority-Analysis: v=2.4 cv=e4EGSbp/ c=1 sm=1 tr=0 ts=686e6bf4 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=l4nx1uorHdEoQg2_gVUA:9
X-Proofpoint-GUID: K8ySkQdBdLWrAksy_euHSsNTUK5RnThw
X-Proofpoint-ORIG-GUID: K8ySkQdBdLWrAksy_euHSsNTUK5RnThw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDExOSBTYWx0ZWRfXxCHkX6C6SAYt dSgrbY6AATMkTAxUdOgnTYiYfNafupWmRQP0fYpb79Mh3FfpZTYdrlh4+8ZHeLN+/Wyx88yInma 1P/+FT3DgMmey8v4NJcajhCU0NbPXtPVrxYISQjgAgmXs9LkL+jJLO02m0sqDfaSS6NtK1TchUJ
 3EWRlr+aBhSAAWJICUL7HcFPDcEP7D+q3CLsABNoXEJfF2eHcpKjRTwXMTh+XRhnpAdqWqT1YQ+ VeLk1nlAcMGtYSpy5sHONZ5okKJs22XHXDOhj+CFFl9zB9gZvWtk2PGM6MrzpcdrKcfPXltJRyl SQTwuBY6v3lmFqcn47cjPhOD9xQtz00LgvBQ2twH8c+9FzuujV6I4gMan80zgpScSLQL2ZkogPc
 wl6/YgZwU6yraf7jwsGfEB1wM8FukITVKDEK8An9aTSAeRGNPRlsdHklMk7HNGzVGR/IT+Ng

Introduce {pgd,p4d}_populate_kernel_safe() and convert
{pgd,p4d}_populate{,_init}() to {pgd,p4d}_populate_kernel{,_init}().

By converting them, we no longer need to worry about forgetting to
synchronize top level page tables.

With all {pgd,p4d}_populate{,_init}() converted to
{pgd,p4d}_populate_kernel{,_init}(), it is now safe to drop
sync_global_pgds(). Let's remove it.

Cc: <stable@vger.kernel.org>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 arch/x86/include/asm/pgalloc.h |  19 +++++
 arch/x86/mm/init_64.c          | 129 ++++++---------------------------
 arch/x86/mm/kasan_init_64.c    |   8 +-
 3 files changed, 46 insertions(+), 110 deletions(-)

diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index d66f2db54b16..98439b9ca293 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -132,6 +132,15 @@ static inline void p4d_populate_safe(struct mm_struct *mm, p4d_t *p4d, pud_t *pu
 	set_p4d_safe(p4d, __p4d(_PAGE_TABLE | __pa(pud)));
 }
 
+static inline void p4d_populate_kernel_safe(unsigned long addr,
+					    p4d_t *p4d, pud_t *pud)
+{
+	paravirt_alloc_pud(&init_mm, __pa(pud) >> PAGE_SHIFT);
+	set_p4d_safe(p4d, __p4d(_PAGE_TABLE | __pa(pud)));
+	if (!pgtable_l5_enabled())
+		arch_sync_kernel_pagetables(addr);
+}
+
 extern void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud);
 
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
@@ -167,6 +176,16 @@ static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4
 	set_pgd_safe(pgd, __pgd(_PAGE_TABLE | __pa(p4d)));
 }
 
+static inline void pgd_populate_kernel_safe(unsigned long addr,
+				       pgd_t *pgd, p4d_t *p4d)
+{
+	if (!pgtable_l5_enabled())
+		return;
+	paravirt_alloc_p4d(&init_mm, __pa(p4d) >> PAGE_SHIFT);
+	set_pgd_safe(pgd, __pgd(_PAGE_TABLE | __pa(p4d)));
+	arch_sync_kernel_pagetables(addr);
+}
+
 extern void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d);
 
 static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index cbddbef434d5..00608ab36936 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -75,6 +75,19 @@ DEFINE_POPULATE(pgd_populate, pgd, p4d, init)
 DEFINE_POPULATE(pud_populate, pud, pmd, init)
 DEFINE_POPULATE(pmd_populate_kernel, pmd, pte, init)
 
+#define DEFINE_POPULATE_KERNEL(fname, type1, type2, init)		\
+static inline void fname##_init(unsigned long addr,		\
+		type1##_t *arg1, type2##_t *arg2, bool init)	\
+{								\
+	if (init)						\
+		fname##_safe(addr, arg1, arg2);			\
+	else							\
+		fname(addr, arg1, arg2);			\
+}
+
+DEFINE_POPULATE_KERNEL(pgd_populate_kernel, pgd, p4d, init)
+DEFINE_POPULATE_KERNEL(p4d_populate_kernel, p4d, pud, init)
+
 #define DEFINE_ENTRY(type1, type2, init)			\
 static inline void set_##type1##_init(type1##_t *arg1,		\
 			type2##_t arg2, bool init)		\
@@ -130,99 +143,6 @@ static int __init nonx32_setup(char *str)
 }
 __setup("noexec32=", nonx32_setup);
 
-static void sync_global_pgds_l5(unsigned long start, unsigned long end)
-{
-	unsigned long addr;
-
-	for (addr = start; addr <= end; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
-		const pgd_t *pgd_ref = pgd_offset_k(addr);
-		struct page *page;
-
-		/* Check for overflow */
-		if (addr < start)
-			break;
-
-		if (pgd_none(*pgd_ref))
-			continue;
-
-		spin_lock(&pgd_lock);
-		list_for_each_entry(page, &pgd_list, lru) {
-			pgd_t *pgd;
-			spinlock_t *pgt_lock;
-
-			pgd = (pgd_t *)page_address(page) + pgd_index(addr);
-			/* the pgt_lock only for Xen */
-			pgt_lock = &pgd_page_get_mm(page)->page_table_lock;
-			spin_lock(pgt_lock);
-
-			if (!pgd_none(*pgd_ref) && !pgd_none(*pgd))
-				BUG_ON(pgd_page_vaddr(*pgd) != pgd_page_vaddr(*pgd_ref));
-
-			if (pgd_none(*pgd))
-				set_pgd(pgd, *pgd_ref);
-
-			spin_unlock(pgt_lock);
-		}
-		spin_unlock(&pgd_lock);
-	}
-}
-
-static void sync_global_pgds_l4(unsigned long start, unsigned long end)
-{
-	unsigned long addr;
-
-	for (addr = start; addr <= end; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
-		pgd_t *pgd_ref = pgd_offset_k(addr);
-		const p4d_t *p4d_ref;
-		struct page *page;
-
-		/*
-		 * With folded p4d, pgd_none() is always false, we need to
-		 * handle synchronization on p4d level.
-		 */
-		MAYBE_BUILD_BUG_ON(pgd_none(*pgd_ref));
-		p4d_ref = p4d_offset(pgd_ref, addr);
-
-		if (p4d_none(*p4d_ref))
-			continue;
-
-		spin_lock(&pgd_lock);
-		list_for_each_entry(page, &pgd_list, lru) {
-			pgd_t *pgd;
-			p4d_t *p4d;
-			spinlock_t *pgt_lock;
-
-			pgd = (pgd_t *)page_address(page) + pgd_index(addr);
-			p4d = p4d_offset(pgd, addr);
-			/* the pgt_lock only for Xen */
-			pgt_lock = &pgd_page_get_mm(page)->page_table_lock;
-			spin_lock(pgt_lock);
-
-			if (!p4d_none(*p4d_ref) && !p4d_none(*p4d))
-				BUG_ON(p4d_pgtable(*p4d)
-				       != p4d_pgtable(*p4d_ref));
-
-			if (p4d_none(*p4d))
-				set_p4d(p4d, *p4d_ref);
-
-			spin_unlock(pgt_lock);
-		}
-		spin_unlock(&pgd_lock);
-	}
-}
-
-/*
- * When memory was added make sure all the processes MM have
- * suitable PGD entries in the local PGD level page.
- */
-static void sync_global_pgds(unsigned long start, unsigned long end)
-{
-	if (pgtable_l5_enabled())
-		sync_global_pgds_l5(start, end);
-	else
-		sync_global_pgds_l4(start, end);
-}
-
 static void sync_kernel_pagetables_l4(unsigned long addr)
 {
 	pgd_t *pgd_ref = pgd_offset_k(addr);
@@ -295,6 +215,10 @@ static void sync_kernel_pagetables_l5(unsigned long addr)
 	spin_unlock(&pgd_lock);
 }
 
+/*
+ * When memory was added make sure all the processes MM have
+ * suitable PGD entries in the local PGD level page.
+ */
 void arch_sync_kernel_pagetables(unsigned long addr)
 {
 	if (pgtable_l5_enabled())
@@ -330,7 +254,7 @@ static p4d_t *fill_p4d(pgd_t *pgd, unsigned long vaddr)
 {
 	if (pgd_none(*pgd)) {
 		p4d_t *p4d = (p4d_t *)spp_getpage();
-		pgd_populate(&init_mm, pgd, p4d);
+		pgd_populate_kernel(vaddr, pgd, p4d);
 		if (p4d != p4d_offset(pgd, 0))
 			printk(KERN_ERR "PAGETABLE BUG #00! %p <-> %p\n",
 			       p4d, p4d_offset(pgd, 0));
@@ -342,7 +266,7 @@ static pud_t *fill_pud(p4d_t *p4d, unsigned long vaddr)
 {
 	if (p4d_none(*p4d)) {
 		pud_t *pud = (pud_t *)spp_getpage();
-		p4d_populate(&init_mm, p4d, pud);
+		p4d_populate_kernel(vaddr, p4d, pud);
 		if (pud != pud_offset(p4d, 0))
 			printk(KERN_ERR "PAGETABLE BUG #01! %p <-> %p\n",
 			       pud, pud_offset(p4d, 0));
@@ -795,7 +719,7 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 					   page_size_mask, prot, init);
 
 		spin_lock(&init_mm.page_table_lock);
-		p4d_populate_init(&init_mm, p4d, pud, init);
+		p4d_populate_kernel_init(vaddr, p4d, pud, init);
 		spin_unlock(&init_mm.page_table_lock);
 	}
 
@@ -808,7 +732,6 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
 			       unsigned long page_size_mask,
 			       pgprot_t prot, bool init)
 {
-	bool pgd_changed = false;
 	unsigned long vaddr, vaddr_start, vaddr_end, vaddr_next, paddr_last;
 
 	paddr_last = paddr_end;
@@ -837,18 +760,14 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
 
 		spin_lock(&init_mm.page_table_lock);
 		if (pgtable_l5_enabled())
-			pgd_populate_init(&init_mm, pgd, p4d, init);
+			pgd_populate_kernel_init(vaddr, pgd, p4d, init);
 		else
-			p4d_populate_init(&init_mm, p4d_offset(pgd, vaddr),
-					  (pud_t *) p4d, init);
+			p4d_populate_kernel_init(vaddr, p4d_offset(pgd, vaddr),
+						 (pud_t *) p4d, init);
 
 		spin_unlock(&init_mm.page_table_lock);
-		pgd_changed = true;
 	}
 
-	if (pgd_changed)
-		sync_global_pgds(vaddr_start, vaddr_end - 1);
-
 	return paddr_last;
 }
 
@@ -1642,8 +1561,6 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		err = -ENOMEM;
 	} else
 		err = vmemmap_populate_basepages(start, end, node, NULL);
-	if (!err)
-		sync_global_pgds(start, end - 1);
 	return err;
 }
 
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 0539efd0d216..e825952d25b2 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -108,7 +108,7 @@ static void __init kasan_populate_p4d(p4d_t *p4d, unsigned long addr,
 	if (p4d_none(*p4d)) {
 		void *p = early_alloc(PAGE_SIZE, nid, true);
 
-		p4d_populate(&init_mm, p4d, p);
+		p4d_populate_kernel(addr, p4d, p);
 	}
 
 	pud = pud_offset(p4d, addr);
@@ -128,7 +128,7 @@ static void __init kasan_populate_pgd(pgd_t *pgd, unsigned long addr,
 
 	if (pgd_none(*pgd)) {
 		p = early_alloc(PAGE_SIZE, nid, true);
-		pgd_populate(&init_mm, pgd, p);
+		pgd_populate_kernel(addr, pgd, p);
 	}
 
 	p4d = p4d_offset(pgd, addr);
@@ -255,7 +255,7 @@ static void __init kasan_shallow_populate_p4ds(pgd_t *pgd,
 
 		if (p4d_none(*p4d)) {
 			p = early_alloc(PAGE_SIZE, NUMA_NO_NODE, true);
-			p4d_populate(&init_mm, p4d, p);
+			p4d_populate_kernel(addr, p4d, p);
 		}
 	} while (p4d++, addr = next, addr != end);
 }
@@ -273,7 +273,7 @@ static void __init kasan_shallow_populate_pgds(void *start, void *end)
 
 		if (pgd_none(*pgd)) {
 			p = early_alloc(PAGE_SIZE, NUMA_NO_NODE, true);
-			pgd_populate(&init_mm, pgd, p);
+			pgd_populate_kernel(addr, pgd, p);
 		}
 
 		/*
-- 
2.43.0


