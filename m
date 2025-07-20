Return-Path: <linux-arch+bounces-12877-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADD1B0B95B
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jul 2025 01:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596141889CB6
	for <lists+linux-arch@lfdr.de>; Sun, 20 Jul 2025 23:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7595239E85;
	Sun, 20 Jul 2025 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZIt5QI5h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k4r5wVxf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4E6238C3C;
	Sun, 20 Jul 2025 23:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753055015; cv=fail; b=DpFK4aTjBZrnexjgc4LwWG8NvVWNTv+Ge1VjPe5vy1ZtUP1IRfe4Pdr60TfwZv2Lv7nFzVtEyUG7PbnWTBxNli/ajFg44VNbFLj6S0d6b+XZLHJce/e2DG4FENo6AmRpl84PYI14BttLdZOlZtxgH8aXB+6ZwDx067pNFk8xNW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753055015; c=relaxed/simple;
	bh=lz0txypQt/YLDGgSOG+falVvqkhqb/wyF3l3xLNCfIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AtZ8V/KeNlFX+vbLfW3diSSUJgQ0XcRsszxv8qYrY9EWiF+kq0oA7XxTScof1WCUNLGYEgHk60GvcCO68JasfJVzNulmJ+ENHi+bsWJb7Bl8TZ1zPrk34Bwy5Oqx6gT5nOznnW9+ANqfn+mOmhJxuMqdzAtta74KiYuG6QFUYQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZIt5QI5h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k4r5wVxf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KLj1qe008439;
	Sun, 20 Jul 2025 23:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=B++X+Q87NBbosVzBiUi/YmCdtCaUsRbGAI3TSckmfAg=; b=
	ZIt5QI5hDbsgCRGczgzWTox5NDV/2wQhqLkE9Cn6ZkPeyS2b4o+f7svtnJJUP6za
	WR288SiBmaL3uwPJ2w9VhvRrwx0DQkcQVgx3g2FOT2fHAMB7cbsO0z7mKUOFwE/S
	IWEI8uqys66lq4b9uSBUu86kgt3ew23pGu3LPKo88/JaMJ1VteFTl+SIpiKW7qZm
	cxg1dKNgYdKL4UdXAOKVf4tKjiCUpP1RTyM6TKrGcx1gCXZPn8B0jyIKs8Kp2iMu
	AmPTNOD72ubKBTkT4fVoVte5Kd26uLBNTLt/Zg7/r9iNto0M0PAmhgCJEL5SV9kK
	Yu6PHfiA+5ooOwkWg2lT6w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e29hnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 23:42:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56KNUGWu038352;
	Sun, 20 Jul 2025 23:42:38 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801t7e8h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 23:42:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHcpgArihNiOTG2m44XZ9fBM77uK+p9yirlx7yVNAf2i2muJ3Ovov63UuoWCHXEmUIbV718yucJQpkFqLI+cfOMbJ8OWgJ3fFc5e2iCYXUc18Si02yL5/qpEQgHgezdME/0wO6mWybgopnddpzA7rwrRwthsZoUXT1/XtdQoUMJi0TTzrlCyggT/nF2gVInbqmnVAz5MGFWe/Q2tuaqB1JnRLlSechF4LoyXZ5ve7SOQXfhRXiNdpVFkMJp6fxCHwBHtiJTLPnktDfpaK3ycumcvIJ1UIOM+TPR//RlZBmd5zuwlgojImWtIwoLbqBWU52dwIlK9wQirbGbV/3ApGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B++X+Q87NBbosVzBiUi/YmCdtCaUsRbGAI3TSckmfAg=;
 b=iFH5pGog/zdeGQunE6IxSRzkfiXz1Fz1b7/A/xif7nyvSC/v5Jlr+s/26omIncdDlzCLWU/ZAjc8xst20qNzyo6jT5zm2dFJ/0uzfINaa+yxQrmJ5V+yR8QdiHZ0+B3BcqS1imRcyTDGeXHBPaqAoQtzZ26gYDQGiqa6Bjz7P8bY4cp5HvRFLz2On93JrmF/ixoeJ4NNjm4eTHAZa4hXy+Rerdk/2t/xtzIOOyVgbPryaYyAbx5a2IU5/AJyW9+5O5VVy9BE3CRBz16RLDETBq7nTKiO30x6pomlMgY88L6NKfZKBJ3woRtMw37CjTL0w7M+WWGdB3NVRrxJPauzPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B++X+Q87NBbosVzBiUi/YmCdtCaUsRbGAI3TSckmfAg=;
 b=k4r5wVxfHpeh3gOVOHthl1qpJOWCbW7y0bhCj78CKdz3gnE8r/rjIazK/0UMPgHWRS1ID5yCFv+7AAO7QHixXTXHCOiWpFHZLCdBuirBRgFcVDyLEdLRmhVBMdnP4Who7ppgaDfsgOSVpJlnIPiwds6Vsesoz2qhibmOjxFn1DM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sun, 20 Jul
 2025 23:42:35 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8943.028; Sun, 20 Jul 2025
 23:42:35 +0000
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
        Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 mm-hotfixes 3/5] x86/mm: define ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings()
Date: Mon, 21 Jul 2025 08:42:01 +0900
Message-ID: <20250720234203.9126-4-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250720234203.9126-1-harry.yoo@oracle.com>
References: <20250720234203.9126-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0125.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: e5aee08b-05b5-45c9-027f-08ddc7e71a6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AAWv/1ChBhH65ddXFCUlf5fCrv3WCBeR/6B6bLBo85ztzOwMk6gUE7cbDZoS?=
 =?us-ascii?Q?mRSJbs6UdHI86ii4yfguhuqLOu9O6QBHBP+2y8a0AQwi9TBlJKnqez55C/Ma?=
 =?us-ascii?Q?6t97/zhMtLcr8dpZGj3vKE2vczY2YI7kTl6jJHb5uJe4jj2i6kcl++MkqbHs?=
 =?us-ascii?Q?orseWz5gs/hnlv2j2N9aAghf6hVJgpOFGTJm6ebvpvnMmIFCZrtX4AtFwS4e?=
 =?us-ascii?Q?SpMcFvwML73nGSJHqarnAeZDkzFfCtIWOGfPPXpcWWIIZ/fkgBrnayaSztgt?=
 =?us-ascii?Q?fcbzewTsb1vxgzVA3PQLxYaYhlE47KNpeBZZDsa5A1kMaP9ydYdc+SKpTOzC?=
 =?us-ascii?Q?+uSBbIOusM6QlPrRmNT4Np+sTsWKJY8ulekJF3XjHHUzqehLtaRpGQ/wIWhx?=
 =?us-ascii?Q?WnigluLbEyvsVwTtNLYO0FIYxeLkztxXAXIbpMiNtmuzpmieeU4xyMtB+5Jk?=
 =?us-ascii?Q?ZpYHOxjZ3djnby35gd1kei6cTi/D42XmilCHUNem9Ar7ypWBxHmchZtXvyix?=
 =?us-ascii?Q?9MswjW32ChnmVmSDAXjQWVJOe+760coHHvRFq9GPrX6zKLRo/085b/TTBu4r?=
 =?us-ascii?Q?tAO3TmrpkUC27cgBkUYAcXOM40utEo7ZqTNI6pCJr4S66DZZaT6CxP0YVAyD?=
 =?us-ascii?Q?C0eDdw77tdFRPzwnmup8576pb0llUJhvgzqFHlLxPO6TfrzvuNb2bdthvMqY?=
 =?us-ascii?Q?GqZzFhGfe9fcEL1JiYh2+msbeH4sMNKwYrahpdzsQmzfxrhNKifu+bRzbfSr?=
 =?us-ascii?Q?s7CvCIgmeCfAFS25OqwpIaeILXVYyYw8R6mV5hJhizfaS3/XhNPChfuldaSM?=
 =?us-ascii?Q?wx4BJhZpws+Gxr5jU7MVlU7w8fY5ie9L0SqjD8UALvapP+FyPHDgEDB8uE6f?=
 =?us-ascii?Q?0uTgINpLAf5jWTypTBgsoLVEu8PfTM+TI+AGPDoKscYhHWOuN3UsqH2lEYF9?=
 =?us-ascii?Q?E43OKAb+IdYvCc2xlvMPlcTGzfuxaS09Gt1vGBkWtmJIsqnRyNA9qiRVntWB?=
 =?us-ascii?Q?rXSbC45Eo0fmCOby0oJ1x01YW5Fc/pVB1K7Q3RN5VfDNswcHslWqr3Zlhwqr?=
 =?us-ascii?Q?FVHZ/Rso0PnDfCl9/KE9HUC+Vl30u/Erwz0Mq8FMBTNIbnG9uKbryKYuEnaP?=
 =?us-ascii?Q?ec02nF0OAowbpgMCeXY2c55liYk4AXR+pWb7XdbTSOR0HP910F86NHHMUvQ/?=
 =?us-ascii?Q?z22qpjPvN/4ToqJtEAyt7KcZ1Kg1uDmaWWYEwFDQh34Fki3NlRgCDMbam7D5?=
 =?us-ascii?Q?hc+RfLoOasIhiNZ7LRloqlKM0brPrj/T7L8UyfMg9VTleHQGK/GP0Y8za/cj?=
 =?us-ascii?Q?4+UPIcOV10mpPALTaxsOLQvqmFs1sXUOWPgpMrM1J9ct8Uf/J+TaGUlLPa3E?=
 =?us-ascii?Q?nfQYIS96q5XMZswdzwvZt7cFjdVDn5UhSOEWzVLMqdVCJg7cj2s4wyTeAZCK?=
 =?us-ascii?Q?1yRHoZPMA4Mnw+m2A1ExFl24NbD9Ws55mt5XJH9HcVR+nqxRl1aMEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LKx2HP6df/TP+Hu2YFGOkSK7awb2yEk18dPQYCupl1M2bJ0CRRiVxMyZC2TA?=
 =?us-ascii?Q?zXAUThFSu363F4ktKYDlozj4hGLQXmXySol0dx9QB+9k4PAUBYUpNSFCicAL?=
 =?us-ascii?Q?ti6SBYGBAnGUuaXqhj1lQNtB2A+u0x/97Nr42mrxhO5OUPPcA/v+DxxUomhf?=
 =?us-ascii?Q?oIIq3IgZCpdeKusDhR/QXyeshXEgnc+bPjzs1sv+SuCVVjA8ZbHj5Gi+jExi?=
 =?us-ascii?Q?dnrws6sCCsr2RvOsWTAAiv8ixeIGKaFVPTARVcQx4Z6w5tpVany4jY2y21KN?=
 =?us-ascii?Q?+0D4tfTurqKHnU/WiUweC/ansaXSFMSXqq28pxmzp1QX28887zlpsExR7wEw?=
 =?us-ascii?Q?9qHXHYc5tMxTKlE7dgNbolttMdbObGRnHhhAHSzxx+KxFTUDNu1GcSdfixLO?=
 =?us-ascii?Q?hamjFrfvREFj8C6GX4jmWUufLUtXaz8fn4yDN4BmUQ9oy4DOigHcU+wXhAUC?=
 =?us-ascii?Q?dl/UJy2GjJwU9bCLHkumi4weXwfXnRUgs51WckNiP9fe91kc8BjHaeFKbM/F?=
 =?us-ascii?Q?K/8cPpPCdxAZTbJDEkx42DveddOHwrjCI4cWkyv9ww/SzV4fdjw3QToEHK8g?=
 =?us-ascii?Q?RvTmFE6eDHRhB2SwAZkrjzJ6eTj/Fc4tmjB7JGSItoOuTLvvIm/GItjB/dD2?=
 =?us-ascii?Q?RA6E0puONv0NZf0d+Sx+VxZpTL6LCiCeE8QRkF4ni6mg9naxaDy5dI8skKnC?=
 =?us-ascii?Q?QSzGaAHpq8SLZgBgjIgIjMyWiCd3mxMo/hvJU5O7HRjszWdVtvAzzFO8RndU?=
 =?us-ascii?Q?DbdpzaFJayRCHyZKf8H/AqKbX0p37SicT8IMnHqYDzVY1LQdF82RvAqOG5Vr?=
 =?us-ascii?Q?VB/Igxf73DQQE5iGDsjRfYp4949vxKpkvQHX+98siXRy+eT4Gpce9CKafytY?=
 =?us-ascii?Q?ydX7uTq+h3P1ldkalxZ+KNql6Glnq+uWMDJQffUZoCz52ul3DNXOvkluRaYz?=
 =?us-ascii?Q?9mzurpYnVS65Z2h6f4Kop8EPodwh2Zj5k+C7lyaGbS9+2dOvQh4TPEwBaZxR?=
 =?us-ascii?Q?FNuVF6Ny4712WgsfCsKpUOXCYi3rEKppt6+aN7KZ9mxmVuFar0fF1vvEim7Q?=
 =?us-ascii?Q?ePANNpNhZaJllTXKQ0uAMvmJqgHQvskhwTZTnrj0EIFSaCKdKAEegnfpnw0q?=
 =?us-ascii?Q?5fyV9LkPCXab9Ve513DanE9IyIlohrYaeOhjbXIyhcFYBYIQbNBLAbn4UjEO?=
 =?us-ascii?Q?l0fqvAQWT9vT+2OICEfiwEOerpl0kre7sUsDhDbblW5oQT6CxEGeKHlRBAGW?=
 =?us-ascii?Q?Dn5uRP0SM0PSvKuZ8HNHGqnBV8Uzaor0zs5WdYl5ouJNd7PTuhvgXCkTNq4F?=
 =?us-ascii?Q?RiqL6PmQobqqVjP+KnmhDY6nCrVunh7luvV0s62DkyhIHKCd8mfJ25zUoRIl?=
 =?us-ascii?Q?GGpFCdxo+yO+hGATzsD+Pz0CN/OQqZg6jN5yTZ4xtBfYUzZFUWC0xL5W5o33?=
 =?us-ascii?Q?HK3+otd4fFd/9LrAD17fhgtXsk2YqMp1wl6I1nqb9QB21gebbvJw5mXQpOlY?=
 =?us-ascii?Q?e7TjllqgSywheWGjC95vuc2dOrYncdJCIVKViqDYPOY/cDDcdxWWovEg3QN+?=
 =?us-ascii?Q?lzj69+ok5kAjd5r7Prg/YuulV61DWfbMw6e8TvYa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aCAAhHbwOHOiSGD7Bnk5E7dYtLhUhLEzKOW0lCl7mPRqc2A/zsWCLeK+YhD2Xla7X3uNICBkbZM6LlM60Yebo5wz05PsmjOEU8ZIMv+I84lHNxvmQfsvC91yR4Rx7IyirsKJeT6/mQ4yTux3WcQajx3uiWulRiYCn2slj57RdWGRh1WEznlaYYV/pmUnxKo7MGnhsC9Ul31UX0fdqxcpjyG6+Hcj9Z9Oihpfrp7i0PvS6FCcjcPFNdeYgUIkDwOiLQIfREYzU2HcA3R57x11IuOILdSlcH9ZA1y1JtZipsI3EFCM2buF65WDExQ9LIKpEHRtYnIZvE0fSYUEvRcwsl2jXl+tBkbyMW/anZh/qWGi52EWhRB8GXrJPW/JHDRI5fivNk0qhw/thG2+zIkXM/aTO1HHoanqdZmni/THIFN1L+qBO30GWZiCRFXibFUEXLtBUDNtsh7ZG/OXavTVLfXvqdOVgp0vRaHWiuKfAOoiCMv5qKVhKrXfcdC+G154lJP3qzy/EkwbnHAVV5zzWe7x0ADge8xtGBdLbjh2FeBAXWe25FF7vWTuMQoIALTucyTJRnRos0bMitnUxvIAJegkdqEy/tO5FMp8+XQqlOE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5aee08b-05b5-45c9-027f-08ddc7e71a6f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 23:42:35.3140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Pd0XHYzqKg2XM/m8mz+rRGaKMQpSWDWXHpizOwMUgURjUrboRAq1dQRGzxBps69iy223RQjaxQLKvWlJd7e8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507200228
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=687d7eef b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=andX2sbcIq9QJGdYwqsA:9 cc=ntf
 awl=host:12062
X-Proofpoint-GUID: Z26ixhOI4rVKv99SdenxZ5rL3hpvYRwr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDIyOCBTYWx0ZWRfXzi2Z2ZSUzCem
 OjRiYlT/7IRpYFVoB9B1K6ZeLUwei215++8P+dKCVbkvxJkELqNwBzQUxgKv3HMj85X+xj7DHKZ
 6QMr9AGIsZY8uyfy3nVm6uyX5vxZYo4CEAaR4zLKICLtMBNCgG2jeMhTiBLnXFlpsb++PNVBGIX
 IE6RkiDuW122onO2rakN/XxRVNGexrsrHPBZEyRurBgpgdNGLBv9EJLuyLQTzOUovr3srkUVvvW
 L9/PixFx8BI9yDxlJBSmnHyvMxn/2CMnlWai7r5cRSzlDz7wS0RR6ctdinW+g/HMZJHhuR0G1ex
 W+lbcpAPLjnOiT15qxKL/X3YV8lZzHHB88fntxbXqpuEAX7ncQoCwR6avYxlmcbsk1yZiJbEyCo
 OJ5FQoyB0+dhBEMvg7NKBLN9MbWVYcQFw+8mLFUbeVUgtRe0g69QHqZEZnB4vDFSM1CSyJNY
X-Proofpoint-ORIG-GUID: Z26ixhOI4rVKv99SdenxZ5rL3hpvYRwr

Define ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings() to ensure
page tables are properly synchronized when calling p*d_populate_kernel().
It is inteneded to synchronize page tables via pgd_pouplate_kernel() when
5-level paging is in use and via p4d_pouplate_kernel() when 4-level paging
is used.

This fixes intermittent boot failures on systems using 4-level paging
and a large amount of persistent memory:

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

It also fixes a crash in vmemmap_set_pmd() caused by accessing vmemmap
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

Cc: stable@vger.kernel.org
Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
Closes: https://lore.kernel.org/linux-mm/20250311114420.240341-1-gwan-gyeong.mun@intel.com [1]
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 arch/x86/include/asm/pgalloc.h | 2 ++
 arch/x86/mm/init_64.c          | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index c88691b15f3c..ead834e8141a 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -10,6 +10,8 @@
 
 #define __HAVE_ARCH_PTE_ALLOC_ONE
 #define __HAVE_ARCH_PGD_FREE
+#define ARCH_PAGE_TABLE_SYNC_MASK \
+	(pgtable_l5_enabled() ? PGTBL_PGD_MODIFIED : PGTBL_P4D_MODIFIED)
 #include <asm-generic/pgalloc.h>
 
 static inline int  __paravirt_pgd_alloc(struct mm_struct *mm) { return 0; }
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index fdb6cab524f0..3800479022e4 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -223,6 +223,11 @@ static void sync_global_pgds(unsigned long start, unsigned long end)
 		sync_global_pgds_l4(start, end);
 }
 
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
+{
+	sync_global_pgds(start, end);
+}
+
 /*
  * NOTE: This function is marked __ref because it calls __init function
  * (alloc_bootmem_pages). It's safe to do it ONLY when after_bootmem == 0.
-- 
2.43.0


