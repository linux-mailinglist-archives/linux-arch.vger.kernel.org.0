Return-Path: <linux-arch+bounces-12601-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38757AFE9EC
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 15:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11AE1896AB5
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 13:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18AE2C324C;
	Wed,  9 Jul 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IpB86N8o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AM+1gRtX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBDA21CC74;
	Wed,  9 Jul 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067171; cv=fail; b=jMPEaNsowqR2YVobBonweVAC2ViZmy7qSPTqmdA1FE9lKGEqFgd5/FO1maKDlvyw2cEgpwxw9PLYz647kyexxi38Z+F4yjkNxgpNICnfDT0vlvkIBuNB/0oIOj9KHpMWYeYJsovdtd9pmgHFv+MrR4u4L3cRUSQSf450jA5eA/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067171; c=relaxed/simple;
	bh=ARKXm1ZD5lpudMuRjx1n4PolP9KJxI3y36f/UDwYlZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HwXfv4vCJ0D0QpK/3fREbf+qEXNUpsF/ZzwF5RvIRMH6AIu/+5G+W+eMBmI1WPKdMoiQfWRTvIZFlrjSqZzBgy74u2OcVoXXsgx9Ge5ajJP26eMqBCing0/eImrwlYV6wojFz31zN43zhW7GrNYCDgT9AIfxJmkTVa13jmLYOyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IpB86N8o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AM+1gRtX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569CKpsi009622;
	Wed, 9 Jul 2025 13:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Qp0D0xzoPP3uN2AoFRYwBMBgyM5Bz8pwxCc9dk0b2dE=; b=
	IpB86N8ogFkeHy7GtaJoCujvyUJCZ3YPxHSpUeEKO7ygEQGjf8hXbXRo6Ch4da8l
	NczgEvrJf5NI896PT3NNk6Bg5n/bw9pAC5bH8RCGKRirj2SdmLU1+L9bVx7Uw4wu
	l2MXEsSYkhBPYc/cPxg59Ul0mh43wjt/iN3DUTQ6H3KvyIpDveRP+w6xyDVVzedx
	+a8gnWX/jyJNk85Ts+82PNlxDEArqVYPt+LcN+2tu0EDAhsCJMu9flGsDMhGX+vz
	3He0mL6PXJIfnZ9M1gxBHiuFV8okHhNZ6GjiZmayuYhMNDLHGx7GP2GB3fn+NSKj
	f74S7eutA99pF8tMaWCnmQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47srbqg3sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 13:17:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569D4Reo021505;
	Wed, 9 Jul 2025 13:17:30 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11010036.outbound.protection.outlook.com [40.93.198.36])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgaxtar-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 13:17:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqmsirPXTYse8DKC5ZZOlJ7ggclth9Gfpr2TgO0929MdmCEB61FBr737BKV1aSNcDoVhCKSyWhQCMh8IPUyt5nrrcjX9W2m9xDHLNDyngZLeMyVYqVnAMcMoklYEi2l/ajBQ20PDBMWRa1/6OpHH0TtyWEElfIY0cWSeW6nUPuko8N0doheLUJHyXsrwSAZlfXvlPmg1UAMabuGZy4VZTCnJz7PPy7oRdH7nJl6LuDeANlwkLRB+J2kN5W+ZsIj3UjqUcTVOsxBCqQzzx8iuYKFR55dMXRMlkzBVvYJE5KsRPIzFGWxL1ElgxX+HkrK084bbwAGgOxbGLBvk8CDSmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qp0D0xzoPP3uN2AoFRYwBMBgyM5Bz8pwxCc9dk0b2dE=;
 b=kzriFfrYU67qk1o7xN8C5C5nCdwphZHK1eUQbgn1wvMCRvog9ksBzQQz1RP+0U85e6cykiFoUaJ/+NlvyXcLAleqxJ3ijBxFK6vts2PHKP8Mup61i4qBbq5Xo6dA41P6dEnEJOjzlmZ1CQH9t0uDMIyAHofiKELNZ/3zSHpX14PpfwfOipQeqf15fdQjni7y781K0VWcEPUQIe69i4eqxaVzZpoJLZvP13oyVFnEaxCSfN7ab224i+Asz8F1wbq8U236JWQ1I56jJQlo2WQFjxy23cUSPAtUnPkMGERm+qZk+neitaVseleHd9zTT9V6CmB16qyKoxargBrQdCu6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp0D0xzoPP3uN2AoFRYwBMBgyM5Bz8pwxCc9dk0b2dE=;
 b=AM+1gRtX1zLCwuev5kChs+Ws1bOM6AiOp5NNOF+KH1UJbI0VDf/jkiBiN5q944fTybOhrQFb2wJIwb5YcgEM8z06pKPb99GP/oCmwbHLHp0D6+gIc4+glM8ibj+8vpHCl4cRE6PkTf0ZB++ptGQxQdZcF171gWHx8lN6lkEA1Bo=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BLAPR10MB4914.namprd10.prod.outlook.com (2603:10b6:208:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Wed, 9 Jul
 2025 13:17:27 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8901.028; Wed, 9 Jul 2025
 13:17:27 +0000
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
Subject: [RFC V1 PATCH mm-hotfixes 1/3] mm: introduce and use {pgd,p4d}_populate_kernel()
Date: Wed,  9 Jul 2025 22:16:55 +0900
Message-ID: <20250709131657.5660-2-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709131657.5660-1-harry.yoo@oracle.com>
References: <20250709131657.5660-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BLAPR10MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c3f308-9ef7-4b1d-33e8-08ddbeeaf392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?byXlBAILZ6A7ilHUWkishmkO7a067ILSODa3ENaeBM8oNdX1f7zUKhXHZsqv?=
 =?us-ascii?Q?Livbe+FLXGxmbr3DvIy7mLs/6kzxRMURrtIZuyLSSnOUUgnawR4HEkTY5xgc?=
 =?us-ascii?Q?UIPV7pU4w7eNuqi68GjUPlHn3IE2LsnfdDCM6EgOo1r9RKPgIZcPkFm23Hc4?=
 =?us-ascii?Q?MGHX8hgTnrR9tU30isDd/FT4b7klRF1B3DiunBt3Ll5Ae/QCm39Ia1+t3o1N?=
 =?us-ascii?Q?O03JWsaPiwdiZzi5Lj/I04GExiTYfHhl7NET40nSAtbFKD7xKJMQpKX9xzkY?=
 =?us-ascii?Q?EbyGZmx3dMCU95lFXzy8aDqyj/YhTMJ0Bs/VvsvEX36MTVxoJ9/M8W7k+xqa?=
 =?us-ascii?Q?J9xXHxd6+9NHFElmvUcyUkHKaLpi/Y5+iqjMV4IkqF2wJxH5EpzZ/5jHMbux?=
 =?us-ascii?Q?kMeBLandPSnyd0bYyCvdXzwceyyX01ZXuSKDb+pr6yXd21jrrpE0iaQsaFeX?=
 =?us-ascii?Q?KtQLkcBYkxka7iHwuId4y/51/7G+Et/PvizcSoZf58if4ZCkP0jHAmXdXnce?=
 =?us-ascii?Q?aLskV+Bbkj68cslMeFBKZzxaDtbgoFcZcLiKk+xOHyFXNFVNMI+DhiW7ZhdW?=
 =?us-ascii?Q?w/pt6XzMBLUZoM4PCTJ0ZchirxAhEX3rQr9z3GZyftm9ekfnjM0exdbA8N9S?=
 =?us-ascii?Q?02TxfhSagSgz64QBh14lQDTCYEsrlK/c+WeD184LpQ+Z+3bULYtgPDLVwS7U?=
 =?us-ascii?Q?vJ/m4NhsTKPJPlhhF8ePW8v3gNhvBrXd5YZBImsSIg29naOKYwJrlo6mnlGt?=
 =?us-ascii?Q?/KTDMuvIa9QsISjQ5W5CfUxj9D5X3hRCUQ4y0xiWRDSWYiosISuIvOOAxWwM?=
 =?us-ascii?Q?pD2Jk1nEE0cdDC3WJNKBIIMlYVcDUt1XNqBi2qalY8UURCyntnW80XDA5dnK?=
 =?us-ascii?Q?pzUKfM59vWe2xhOQo7/rY6HaDDc02akai54SsbNH35USqxEjuksm2A7jyvmO?=
 =?us-ascii?Q?rnQaVo6LEGBkxy3IeQqjdPo0kvXh4LEMTuLLBpM+whM9oQxCqbcGVvzuT/zl?=
 =?us-ascii?Q?8Shrk2GuQGBtKJVCiaDsZVlSDB5RNNBJSAQ6gO2NcFvY9ce64nTiQF40Sra0?=
 =?us-ascii?Q?TvkTMu5IKKL8Qgn8uDXTZLSccGxOBAhfc7vGv4pf4UHULhJ+cmpN5uXnHrrB?=
 =?us-ascii?Q?/LJHLZxTtEbi3Qmy9UiGuNk/Fg6SVkwfoBhEA2Qom8RAgXlKug77r5+kPVXA?=
 =?us-ascii?Q?OlCgVMaAQBY55pv7oTorpILkKGvUkdSvmz2/i9CPXzJ+tzTn9Pb6Svxfxy1S?=
 =?us-ascii?Q?fLTTdTRLzezqt8uhPa/0LfBCVbatgbYHDP7rzXBLA+ie3W5C6kjZn/23rgQG?=
 =?us-ascii?Q?hTNMdlMQpSY8cbfnshdtwAAMWLba7U8AaR0Z2AE6ybc5WIea31hv25sqF9h0?=
 =?us-ascii?Q?jwJfnIpAC4/Zgl73HNmd7jZDyAVIGVJHkCpUrMSaoIxmKkwYAoWifDZadWm9?=
 =?us-ascii?Q?+WeUtO40C8kZmCvHh0NeBoV9ieId5XWdBX4S1xQcQwv3vH5g685dFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jsy8WWu3A+ufjyowUqIqxGWWd0TPGAEyS998KlrynzfLQUyuq0Pxx4OM0XQ6?=
 =?us-ascii?Q?v4zFzBFq/wZdG3X7vnISasXRJdeXnAmfD0YsdJr6eUOEl1VjCNLWUnwhBpxe?=
 =?us-ascii?Q?ydOVY/amBogxq/Dt9v9iOfWORRS1r3i9LV/JAUGaYUQqxYRE3s97HLMCBUqS?=
 =?us-ascii?Q?/XuSklZVI+WVKgVGTzcoXyXsPU9uS6n+2QXeWgC/Bkb4m9boe6iTaPBueDfr?=
 =?us-ascii?Q?SKfXBZEHbx2IjLBlM0ZUY98qbjKr/JOCeit+6GeXeLI5NdE19QjF731uAYgt?=
 =?us-ascii?Q?xzvSudX7GosOlUQB65UrSLv10zHDQKE4dLYapv/TBooD3+0mc4vYHG/ivbT+?=
 =?us-ascii?Q?TRUfVwImU18EaCRRjvmZ1jnVKx/5PAjZH2R24MzBY7QkTp5wHDuJByo9F0gm?=
 =?us-ascii?Q?s8GT0PglJUrJD914cBSQXgvqyociqAGuYpQhEeue7qB9m5dyJFs7SWJtXMRx?=
 =?us-ascii?Q?Aw2AL2hUIlXWglWoZ57Ytr5OVcXkKAI9Hd5i6nVpfBiLmaNpzSy+apmklVMc?=
 =?us-ascii?Q?VRYiWHtQ4YXustlgr6cnbR76dXjL6oQfST53/O4gfGAUj6Ee9ExJSZ12hK34?=
 =?us-ascii?Q?FgrBDoBNaFx3+R10mf0ZWc+pAoy7UzJDAqqGNC4PMfrSNlktdUPoKYqAO6VM?=
 =?us-ascii?Q?tiJSqdJzWGIF5SMZA57m1WIhvkyrnrU83OwZD+Y82qL//nRZkTgrIJ9n4K8M?=
 =?us-ascii?Q?4vMFXqHssabsBQ0TFWKpCta8SOIzff/E9367mtAbMES1ryLb55IWos2GLD8t?=
 =?us-ascii?Q?InnAkoPyl6LjLk6GwNUKl+gDnOMU9MV0IlrN0p2wNGsaaNXeNtTuewkg5uN3?=
 =?us-ascii?Q?4xI4/ugTrq5ZB2C/A5tk5aNbh5YZgbpwIYfqqZDCbroBZWZxmGvZlFy9dsqw?=
 =?us-ascii?Q?jwQ6IkoE9pbyiktaS+wO6kJnSWprPSZoTp8yeaELrltHQVs4j1KsZIA5ksm/?=
 =?us-ascii?Q?0lG46zVRfzPDYn8d/QMQPrxoT0ya7DyrCK9RuelshSGDons80z8SS/VGjTdy?=
 =?us-ascii?Q?onl9oH6WmQmxMEYwgNMTmeKC1x5Dd5IBB9icA7BBGHzCcK2Aicu+VS3TZS9D?=
 =?us-ascii?Q?1zXs5fDUO2zV7oEKRDYj0ntunDSPsljeBXEtopBG47vcavG26v0bW2I5/a4j?=
 =?us-ascii?Q?5B6QD/nsxFbruszOysiIeNCdOC0CejsTV2foHtPKjsY6F2ZMPydl3hEn4T+g?=
 =?us-ascii?Q?2IynJcwjfM1ZvKqbwSgXy/Qf8b8/FaCFJGperT1t25Xzye0ZBxN+100+4vmk?=
 =?us-ascii?Q?iDYA6FdmLvLR7c8IOcgoT+cklvB6flA8h5s6aKbOVnexhrxEeroQtpk8sVna?=
 =?us-ascii?Q?Fg99m5axWhN4DMEgaKFGLBJzqmhHj0yDiJ8xSLFK9xjZSrP14GbLTZUvKoSK?=
 =?us-ascii?Q?HuD3wBi1nF6fV65S/rW13RW/NfyY4WrrMEIdtylq3kxBPKm/S5kY1Bd4TRpO?=
 =?us-ascii?Q?MPSlUB5PRjXWXMhuQKLKSPuCgfr6SoQxpfVVWxpqKPEORi+tDCfXzfmHUI8x?=
 =?us-ascii?Q?2rHXiwkSVpMJJLZGCk9bHWWjiI+3eiyre1wLzakOnw5EAgNc8aeVUPU2mkJw?=
 =?us-ascii?Q?KpgXnOKPyi8AwrVKXs/VPyfl2ftCXexNLmwhwnoh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gb+OIVWLQAPgplV5w2NdHyx0cEvLDMhubkTWtm6rNCKpJxgThTyZ+qSr6LYuxvNaezh2FLjLUrr2t6mkP7mmNfqNX3Ltq71GGNETvGj5X/MjqrfzjA3qLqnNDiPnCjsni29C5VNcyWSVP0eCoztkat5zHITJtgPkULUVVZoVNSdWxeyBf8vngSK7rzsFfTESPyjxF7Q6MdIm85XvN9iJDfZR5rlTFS8LEnQiF/OtEc9D18VUYjSY8Zi1P6x50onCYtJO0nC4ec7VqLgSV0u2BGJm/BtukLCA0jqYRj+yEPBkeZCXSZW1bnyws/ZQZcHP6xfk5gieK5FK3T/c819cWWSt2a9pNKRS5sawTad7cL0rtLMMmSlVHMlaKSrEFYetFxR8CZ+gvvu8HONvBCsr23NG2MOFmjwjlV7oELDRCycj70bPlWmgUZG6WQxLgGb1bgm6SO008T1471NAklVtIJnKeZoKAxIr8FNM9VRMN9YfsIBU5X3WTu/kwia15FnCn2PgfY/iM1mulQ4JPPTQPUOizQYYgoqAdsq0R5N1TNfCpKSL3VZPjlH3cO694ROuyMYPRcraKJ3KCJ9QdOnQ5/9luvOC2uPCeJpVcXnFVBI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c3f308-9ef7-4b1d-33e8-08ddbeeaf392
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 13:17:27.6249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXHoYYSMRRB/XKP73dn3gQnWRmqO2u5ckAOCI4fxFCC94RG+fiGveEWCTYHdfGXkpvUFn46V6vw/Q7Uu95B11w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507090119
X-Proofpoint-ORIG-GUID: v5I45VHu9d3CI6rKOgBiYPvMdFMjw-6u
X-Proofpoint-GUID: v5I45VHu9d3CI6rKOgBiYPvMdFMjw-6u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDExOSBTYWx0ZWRfX3YQUqRpE3Za4 QLhwG5Z2sZA+Bu+uF0mUkMTiR36AV1bS1iIwWxMpYPGqRbSjTWLayPNPHu3H2VsUvwkPSMOSxP0 UELLWI6cQJcxvFB7Xa0CLQVTO/lQlpBJzvp4AU/9azhz42XBADsplkN6caMuTvHnvZ0QKajP5iY
 m3fXQZkaVSTu95HmJZkGC0QMXWbK0V2eazFZA4CkNePj+3vbH5Wc7Y0XR/gRWkp0cyo9XPk5YhC 6xouSkYHZ4O17zOl6ld5MXzIzGv0FNlMiPsf0wmm1Y0gSYQvxhrsisA+NsT7Jhti/X2uDsME5kO e8NagF5gt27OTtWi9hv7Ii9nFInPnANznyPhd0F9DtXSb0XKEvGQYxStH9gp89lx6p5A6hxoAuI
 n6NTiTOjMw+RhuFCJcARVGNRWOx2/EerLIjJtbyEb2MIHu0j+WxlB7+1DieU9OsP1W00RoEv
X-Authority-Analysis: v=2.4 cv=A+dsP7WG c=1 sm=1 tr=0 ts=686e6bec cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=uSgV5WbZM76ynSUC4S8A:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19

Intrdocue and use {pgd,p4d}_pouplate_kernel() in core MM code when
populating PGD and P4D entries corresponding to the kernel address
space. The main purpose of these helpers is to ensure synchronization of
the kernel portion of the top-level page tables whenever such an entry
is populated.

Until now, the kernel has relied on each architecture to handle
synchronization of top-level page tables in an ad-hoc manner.
For example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for
direct mapping and vmemmap mapping changes").

However, this approach has proven fragile, as it's easy to forget to
perform the necessary synchronization when introducing new changes.

To address this, introduce _kernel() varients of the page table
population helpers that invoke architecture-specific hooks to properly
synchronize the page tables.

For now, it only targets x86_64, so only PGD and P4D level helpers are
introduced. In theory, PUD and PMD level helpers can be added later if
needed by other architectures.

Currently it is no-op as no arch defines __HAVE_ARCH_SYNC_KERNEL_PGTABLES.

Cc: <stable@vger.kernel.org>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/asm-generic/pgalloc.h |  4 ++++
 include/linux/pgalloc.h       |  0
 mm/kasan/init.c               | 10 +++++-----
 mm/percpu.c                   |  4 ++--
 mm/sparse-vmemmap.c           |  4 ++--
 5 files changed, 13 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/pgalloc.h

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 3c8ec3bfea44..6cac1ce64e01 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -295,6 +295,10 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	__pgd_free(mm, pgd);
 }
 #endif
+#ifndef __HAVE_ARCH_SYNC_KERNEL_PGTABLE
+#define pgd_populate_kernel(addr, pgd, p4d) pgd_populate(&init_mm, pgd, p4d)
+#define p4d_populate_kernel(addr, p4d, pud) p4d_populate(&init_mm, p4d, pud)
+#endif
 
 #endif /* CONFIG_MMU */
 
diff --git a/include/linux/pgalloc.h b/include/linux/pgalloc.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index ced6b29fcf76..43de820ee282 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -191,7 +191,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			pud_t *pud;
 			pmd_t *pmd;
 
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -212,7 +212,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			} else {
 				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
 				pud_init(p);
-				p4d_populate(&init_mm, p4d, p);
+				p4d_populate_kernel(addr, p4d, p);
 			}
 		}
 		zero_pud_populate(p4d, addr, next);
@@ -251,10 +251,10 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 			 * puds,pmds, so pgd_populate(), pud_populate()
 			 * is noops.
 			 */
-			pgd_populate(&init_mm, pgd,
+			pgd_populate_kernel(addr, pgd,
 					lm_alias(kasan_early_shadow_p4d));
 			p4d = p4d_offset(pgd, addr);
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -273,7 +273,7 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 				if (!p)
 					return -ENOMEM;
 			} else {
-				pgd_populate(&init_mm, pgd,
+				pgd_populate_kernel(addr, pgd,
 					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
 			}
 		}
diff --git a/mm/percpu.c b/mm/percpu.c
index 782cc148b39c..57450a03c432 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3134,13 +3134,13 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 
 	if (pgd_none(*pgd)) {
 		p4d = memblock_alloc_or_panic(P4D_TABLE_SIZE, P4D_TABLE_SIZE);
-		pgd_populate(&init_mm, pgd, p4d);
+		pgd_populate_kernel(addr, pgd, p4d);
 	}
 
 	p4d = p4d_offset(pgd, addr);
 	if (p4d_none(*p4d)) {
 		pud = memblock_alloc_or_panic(PUD_TABLE_SIZE, PUD_TABLE_SIZE);
-		p4d_populate(&init_mm, p4d, pud);
+		p4d_populate_kernel(addr, p4d, pud);
 	}
 
 	pud = pud_offset(p4d, addr);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index fd2ab5118e13..e275310ac708 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -229,7 +229,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 		if (!p)
 			return NULL;
 		pud_init(p);
-		p4d_populate(&init_mm, p4d, p);
+		p4d_populate_kernel(addr, p4d, p);
 	}
 	return p4d;
 }
@@ -241,7 +241,7 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
-		pgd_populate(&init_mm, pgd, p);
+		pgd_populate_kernel(addr, pgd, p);
 	}
 	return pgd;
 }
-- 
2.43.0


