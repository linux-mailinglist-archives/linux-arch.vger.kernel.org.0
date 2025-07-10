Return-Path: <linux-arch+bounces-12627-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C99AFFC39
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 10:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB68179D4B
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 08:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB2028C5D9;
	Thu, 10 Jul 2025 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g91nB1My";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a1c0pXvV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC097235079;
	Thu, 10 Jul 2025 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136108; cv=fail; b=MP2f4rmrqKUsnkRLmbCyRFp9OYK24lSRJJm2RLDcf6O4twuiAqIsQ2ZyzjQ6PXKnq6g8NDJ3qMCT19SGH9CFAHmgzSSnwyOJLpxNnxPhCrYZI3PH0wUs3sE9k3rPBPZV4T3xRvtwPAAlP4cv52Fm8Nk1VFDTH18wm+RIn030KwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136108; c=relaxed/simple;
	bh=XdftOkStdltWtaiwJ7beTzFycgbIC2dcZ3DtWsOiC0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T+FX3FC5rWH7CmrDVHyFcIYIyQr9sXfNHE2nP7gqCBpcWbD9fDfQguSpTMkKjXvdkIcolmeWMk5wr+qsmge5d+hnBIBUPqVB8vFc5BekOxKtQweKPoXUSVwfEmeWicWnxYjeUGz3vFXLU4RGSd+6kSAAIGeMJANmLV8rKuAx4fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g91nB1My; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a1c0pXvV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A76TSx020425;
	Thu, 10 Jul 2025 08:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=FYmtJbDs0hEQx+IGnJ
	IrUnTxKxNWAyGdzMFPkskUPQQ=; b=g91nB1MyXI5ARsYwpm4jUW127xmticbAbi
	+lL7/JblvqqZWM6/lcw7AJzc6HJAsd2c3WIDSCGosPIgg5AmenEzIeTUJmbV48f/
	QxVoVytA2BNOkiBpBMYDaeLfE0Ls0RDT2wrSFzEZraxdjfmd9Zv2MWJBuAKGTh6d
	clE+iXXGAEuTt6vw1tdPsorxvHtgzIn5FlDCb715qKO2mhy3oy97GMzUweuZpQBW
	qkiV8Q8lCxU6+MF3NFDxe8JOo6vJ+STsEvDzbd+0gDX7fPG+Yxely/hVyfDwgPMi
	z/OJWyyobQ/e6vb/YrOx4hQzyp0BeZovPDE9CEPRJiUEPQfpjSrQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47t8u504yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 08:27:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56A86NDZ014319;
	Thu, 10 Jul 2025 08:27:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcrpwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 08:27:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3NnEi5XMhwjPDZ4n4YnPz/6o+e5jxdMiaGQ7+0JUX4FiJKZukxEYod15SE7/ic+NL+7gfGIc4cjyU/KWvOazEyfSlinME+kDSRlpn/tC2qybTa1MqGhRu9/tWolbKYpNEPfRFtC38BYRTweIBOAApMN30MbgCsm92XZDf1Hexddw4tCcuXG19nl7Dd+lluzjHEBZ/h1Koxcqf6cFvKqhT4jpgRuqqhkgacCq68Z4ozg4RnybLFq0AuInfgsgxiLW3jwiFS1LS4fJzU6dAJcHFQUIAnYVxwhO2LirPNLzCCnqdr44r2N688Z7NB1A9Lql4g48dE/tKF1ca4aMZkKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYmtJbDs0hEQx+IGnJIrUnTxKxNWAyGdzMFPkskUPQQ=;
 b=BztfRWr71NWGTJWa4mrBcY5FpistFydW1P78/Ai2SmUtQ5Tji7tupj0Blp3SRqm8VWB+Ui0mQPdolN1aI48lBT1Ijb4gGe5CT5FUwdeoDYxsDG22B+/ZEV7EG/g70bS5LTDyrDvZE/8ZU5FY0ahMEJGe+r2GYewX8/TfQ2v6M67pgNOrD32d/azzZAsquf11p5FXFgam++hpiUVQFev8hU0kJY9HwhmMNdtT64+BaMdHTVq4+AvURVZ5dyzDkzTh1iA2jCMY6sc7xJPfKUOYstpM7MRjhEQd+tau0lmUpWk93oyZYYweTZX0njqOuLdp/iTBfE6gnNd5ZvXiZuly9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYmtJbDs0hEQx+IGnJIrUnTxKxNWAyGdzMFPkskUPQQ=;
 b=a1c0pXvVIavk3VFDqiLojyL24MVQBpVFFePYv16Uc+CemgCH4w/6hFoRmhqKBf7cjTGnGqscV1YR1qz+NzgOkwr2+ZRU8MlDcCf4wc/AdTRyPebTk1894sJjcBqg5JZbw5hRxrmzB+o97BAoM9qNjYzvvtyo+JYPj4Medz47a/A=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SN7PR10MB7074.namprd10.prod.outlook.com (2603:10b6:806:34c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 08:27:47 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:27:47 +0000
Date: Thu, 10 Jul 2025 17:27:36 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
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
        linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [RFC V1 PATCH mm-hotfixes 2/3] x86/mm: define
 p*d_populate_kernel() and top-level page table sync
Message-ID: <aG95eBlgTIDUKX7e@hyeyoo>
References: <20250709131657.5660-1-harry.yoo@oracle.com>
 <20250709131657.5660-3-harry.yoo@oracle.com>
 <20250709141359.dc03e32a2319d85a25faaf32@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709141359.dc03e32a2319d85a25faaf32@linux-foundation.org>
X-ClientProxiedBy: SEWP216CA0111.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bb::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SN7PR10MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: dd16c6ba-ca2a-4a73-e6a8-08ddbf8ba62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v6vrWl/BVQT2boLusrXhITZ3g2WoQsx9gW9A2YWEYpVlZ8/rTFQqcwiRYzVQ?=
 =?us-ascii?Q?SD0kGbz9QQxQTl2XT6//k47Ja6ZiM6RZRrPnPJmrGb81uDKSyHsgsZIaRgd5?=
 =?us-ascii?Q?3o/Jpuxo3EcJWBwwTJonGHaNCRWk4sU9zaiJzyl9K4I77f+9uczig1StJXte?=
 =?us-ascii?Q?NednRZJyfOVBTVcFCdCeOM26XeWgMG9yU022/Da0xObt4KiGAl9V8Ex9zXmy?=
 =?us-ascii?Q?P8bAZsuOod5W6aFxooPwHRnrAOjktPsQW8Q8UzBOWhUXEOTIKM87zDSRzdGv?=
 =?us-ascii?Q?xseoSThfdxydT58Khf8idvAYjeOtGILejPq0wcKix+i90pRtDOPcGamLCkON?=
 =?us-ascii?Q?kmD1gMxAkgIsHBUF1euKpfY0Xb5rk7FeH2mP30kagCFYEfJTXywtWIz3qlzl?=
 =?us-ascii?Q?mnWpKF+I/KI1q5FrWbMI098X2+4efYyc3j1mTFzjXO3TB3d2EI2c1VbiQrh5?=
 =?us-ascii?Q?Sh6Zge0CJJ/cNfN49Cx2YdEXBYjR5eMs1clb4X3UG8wKW986NW7fYRnsQic6?=
 =?us-ascii?Q?Ui6p4XhP3szkCISP50Fi7bN6Zloxg7HrqdJmf804n0b2ldTGXJXABk2Kgpt9?=
 =?us-ascii?Q?WE4AqV3vglv9yYtmrY/W0okYHNva7nYpwf+xfb3aVVw5hWEkvr6rbuqsKUOJ?=
 =?us-ascii?Q?7H+T8wE9+vQHzb58rq0/NwgxoQMZnvTqJKSRp4didC+G8SY909NmhFu5Waoy?=
 =?us-ascii?Q?WDyc1XTWrBRUeTu0rRuQpiTidOjYeKmzpuDYcKFJIKiZY1/GVtfwxd/bezJ5?=
 =?us-ascii?Q?lyL2YUa6+QchRPzP019wvEbzU1Y26xeLQW0U6h5pRgKyUHpoPqozO/zXg1cS?=
 =?us-ascii?Q?CFPzRK0Cb0BTaSmznMeRPnsLrfHcZCIJIXOGqOxvNODNi1uHK0dlQJc0LV/J?=
 =?us-ascii?Q?8uumQgevfHDGOIs64g7GqZdMkCGg1xAB1opBhISazub5WorSsyFsQRakQMMk?=
 =?us-ascii?Q?9DdhZVkZTeVFZzl0G6wkcU+YfaCx+75EizHA4ch1c5Ue66et1WiHUsTdvRTc?=
 =?us-ascii?Q?TKBIgyb70isBzK7f2ir9Fqu+UPdyxPAygp9xYwLqh5PeDyIYQIENOsS6fvsN?=
 =?us-ascii?Q?slVjPu7Yy2cqXeD/zRVjW5u3VXGJ0irSBkqbFRQK8uNoF0i+A2bAqhCCN6tY?=
 =?us-ascii?Q?uqpOeZlBAYiwIq8MV5IErlz5+umBiw7bBhdk9/d7JAQc8Xr/wAbE000BEPTo?=
 =?us-ascii?Q?Twa8OzylVeK0EjlLA2a7eUUX44bxZTtBMFfJqWgXW29rErzlPwRxn/mn+fbE?=
 =?us-ascii?Q?6QanmCZZ6gXbAT3aXuSPA51rTZVvmP3lor92ujNDYjqZrjxppKJcXLzsB7kY?=
 =?us-ascii?Q?/PT5ePnvluG8v2NRQJYw6XoleL1qWPai62bu/u+ZnTKdmEZscniUTT8Sm9N/?=
 =?us-ascii?Q?7SKne9GSKdCglRN8CE+zN+JCJPa0I66sPPFwtFDIUC8yImDDCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5atIGlOtIsnsCdhoGbOjq6qywqUzDU7gEiVlEBU1vTVKUwG3LRzKjVuP+WuN?=
 =?us-ascii?Q?R30ZNKHXSVphngvLTyyb8Q525FQSFoE0D7Gst+2dMFafn8KkRvdniqg9d3A/?=
 =?us-ascii?Q?kgiF+1wAvs4MfxuzF2gi5LQ6i/giwAdwyP7aVF9g2e340w2jgscybu3EdaL1?=
 =?us-ascii?Q?d6NfXGKL+WPoIGyEN4Am5nIZ4lwhvnH8696pHPe8AHF/tlPuOMGoanivr2Od?=
 =?us-ascii?Q?XY7XUk1ZghOFRNSXQFCQLctdcFDd5Dc9a+8rHaoO+5NR214VGAiOoy/GUOO0?=
 =?us-ascii?Q?Zivikv3kddU9/PUmSKDT/H+on1FI2Sj/3Ke+OVlIqcCUWz4TGVnkn7xW5Cfv?=
 =?us-ascii?Q?5FJa9oX0/KtY6ruvotp7k+YxhquBmCFjmAPODKGWrYXxYWmpRxaLOjAGOYYo?=
 =?us-ascii?Q?DOF4OXlT+WjuJOAoIQw26zwaeXh3gWZ0mzmuvb6Y5/Cv8oXGnWhH0drZfbYF?=
 =?us-ascii?Q?x7mLlSh1r/4KU1DTcXVuQdp0SV6m6g2N01xR29RvhG7SAgq31yP+wwvYc+mL?=
 =?us-ascii?Q?LvXbBWZ52hXGZzxEbI+9nfpjvO61jfzyACjlf9kB7lwKGNur9eR7T0eeOgIm?=
 =?us-ascii?Q?5vf1zL1qMTQfLl1tFDzBoS86Er4e3gSzFoII6vM3BJriwjq5O3YQvYaq2M/3?=
 =?us-ascii?Q?uRrzTeZIQg9UDwfjSus16bdXzXWlnYQuYGEC+CvMyoyGch/q/pa/zFpo602E?=
 =?us-ascii?Q?FGsGEm3iI4VIWgyZdoa8b/Ztk/9gxnmC93E7sl4PfIyDv+CWx76NDxAbRRcS?=
 =?us-ascii?Q?bm5lJg5Gu4ee4/CAn1GOXjr4eBxRQKDvX/R499xzFH75Cpv6bCE2fGrWvKVb?=
 =?us-ascii?Q?+H2AXCourS7kcxlrYQ2EDiFa5FMhr7BgoMeanCqpo64RsN54pV2BIRl5AtpL?=
 =?us-ascii?Q?YvSfFhhckXOVgkfwx7tzhTkY4la6iArN61WiBXU3prtPq4KUv3HsPjf7JtX5?=
 =?us-ascii?Q?QJjQNaoDBAPEt6h0URTgXGqRyohBX3qjRWsSvjmbsUUivhq1a/ZZNMlArqZz?=
 =?us-ascii?Q?i5p+trsWNE2uPzqnPH7REIzqP34A/p8OCnCLAlSofwVBNHqE2c6yUSKMYPht?=
 =?us-ascii?Q?TOXX+VIGJtvalVH4/1Igom3p5p0NYRWdwnMAuYD9UIZnufj+lbXsNWQpXCCr?=
 =?us-ascii?Q?VzQXLc/BSppbHoPRNpjt56foFkf3ja1bMHwg8Mo2Q2mZYo+OSmAfu3Fub2Rs?=
 =?us-ascii?Q?a3oVXV0m1p5kiaPfSdWMj4u1W1j9FHnD+Fbmxh728/W68FUTKTX5oVBk/bnK?=
 =?us-ascii?Q?703mV2L/OFGWJ1J3ydafzAtZ6N/bFskNEkuNY0Hfz+PWwsiFYu68MsvKFwW2?=
 =?us-ascii?Q?5X07s1zCUzQKzxyqkLwQ38huZq2GvvBLpB57OEi7E5+UiDK2XUkgDzIyxuE3?=
 =?us-ascii?Q?gFfIDBotmOEkPVgMiuD8RyYsX2P5Ib0G0ZR+Ykf76sDWKg4woCmw6DjsghHN?=
 =?us-ascii?Q?PF6JN7ok79eJNgATUDmN7mnHpSKZWgOmvLhr9ccj0D6RBPsbqj2izqAjTRzq?=
 =?us-ascii?Q?WBslwYBieEYPM412SDDANDlAxX+CyW7wajlFb0HfFeYnnmxW5AZV0Rl75pMS?=
 =?us-ascii?Q?qZ/JIXO+NaBn8AvTz2eSgleR9m+kZb5bgAkTLVpF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6hEgpwvK5G5c+3UdNZnIV+Th5WoG4wnAPDfPjFoPn21rGBmNlR4N2jT1Y42GdKvnlfmgidz4p3FGZAiFiwM8/X6/XY+z/tZHA/CyU1efGc1Uk6r/yKoNqIBn4iy9u4M3YhRFi205p8YXGi2d6iYZC6C3v1GBhYSlC/B1jCuIEaRpGA4cDnDAa+tsqZcoOkROGELj5ba4uClPn03ZxSJE479k/XQGzmV7AWdiioOcL1yHznZ/7klSTIbGOmcCBhpfcbPYj2SoXmModyhi+9zYe34wKMvW28kwu9MeBp7USTguCoC3pSm6CJCno09fvHka3ZglhaO0X+GOH5PXR7lrC46QP5lIdar6OnEKipIUJlZ5HJ82nWz0UJmWqjF3IdvdEfwQfgxdp1aIcMmoPYJzCbIF5u5kbo+J0BoajNKZHUp6paBBnE2so9F4AjsOQR3wUm6Obr0ZG/EmxgpTtAqb0qBM0CfzuHtyWoiHM30gwccO/bJu2JXOqo9PItscgkq20jsiAlvRXtRJKOca0dFVundtEf9gHi8Oe6JslNV4utonNNvuvtNyYDCbdu3+4aG429EkJuEGcIxAYDIxYgxBHYczJ4R8SR72P7cY8MeXIJM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd16c6ba-ca2a-4a73-e6a8-08ddbf8ba62f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:27:46.9073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjtHXjW+o+auHN2v+Ev+oxq5m+pMwKW+iA3w0dAbBtCg47NAU8Yy1FR1c9zqOWD9hQFkY4VJPZvG4m5unGDo3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100071
X-Proofpoint-GUID: oKx9vZZ-izaWTGxRf7sNSchShreJXIVW
X-Authority-Analysis: v=2.4 cv=bK4WIO+Z c=1 sm=1 tr=0 ts=686f7987 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=0lDbGB91uY4eF4RusoQA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10 cc=ntf awl=host:13565
X-Proofpoint-ORIG-GUID: oKx9vZZ-izaWTGxRf7sNSchShreJXIVW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3MiBTYWx0ZWRfX2gXpzzDnLSqh BW7ntdq4f/IFTnZN9ArhrfBJKNpWPhSs4PVL/XzK1b0OwDA7EJDYJ8Ai4Hdw/eP68y0BLTMyGXe Jglu8zmlp880dyKycf9g8HN9otKIfyW/bMIKFZknWztDV6VS+0Fp1uq6I0sgL7i1cYnIpE37aVg
 RWcy+V3ra0H9k8s2jvZ8iwLO6sH4yFZoC76HqVWwZigRkNYyeneSUfULmjNMVY0QdYuQ9LgAW1z pdrTIq8/LFml3aa54sUmsqy93atUi27kKnsgIpbKGuzSmHjFgErwHeSTI8Xjf3JlsGh1uUfOEtG Y/E//rSW36yXWmanGcB1vQqBZ2AjEkzMDwHtX9XCeQ0WaDco8ZIJ7KJRHvAnC5pF64i/RLIZrXE
 tfkBIBzoDgdmas9S/RuxlOJjTcKL4nfvzOVr+SMbJQYEmW5Hkpd/q3f9iLDMGyRUqvaEn5UA

On Wed, Jul 09, 2025 at 02:13:59PM -0700, Andrew Morton wrote:
> On Wed,  9 Jul 2025 22:16:56 +0900 Harry Yoo <harry.yoo@oracle.com> wrote:
> 
> > Fixes: 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory savings for compound devmaps")
> > Fixes: faf1c0008a33 ("x86/vmemmap: optimize for consecutive sections in partial populated PMDs")
> 
> Fortunately both of these appeared in 6.9-rc7, which minimizes the
> problem with having more than one Fixes:.
> 
> But still, the Fixes: is a pointer telling -stable maintainers where in
> the kernel history we want them to insert the patch(es).  Giving them
> multiple insertions points is confusing!  Can we narrow this down
> to a single Fixes:?

If I had to choose only one I think it should be 4917f55b4ef9,
since faf1c0008a33 is not yet known to be triggered without enlarging
struct page (and once it's backported it fixes both of them).

Will update in the next version.

-- 
Cheers,
Harry / Hyeonggon

