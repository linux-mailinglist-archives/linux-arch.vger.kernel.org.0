Return-Path: <linux-arch+bounces-12038-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD39ABE499
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 22:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7919F189F421
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 20:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F3A289351;
	Tue, 20 May 2025 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hA89OtJd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AgFCvbCC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780DF289357;
	Tue, 20 May 2025 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747772191; cv=fail; b=rJk0iz3RDG4c98ecNicQbjeWy4FpWqnGEc0DdFQ51wKSuWOeDunvq+ioWSMjtr+ZOHtyObxOvWDo07cR27RGSFZc/5wD5wbIuA+F1Ljz4j/W0s6piqckVnQhwqqCvHjv+7J6VU//2jnlPE2WbCz074yjbHLVrKZEMPcvy1qP0Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747772191; c=relaxed/simple;
	bh=4ulg03AZiLabnjRlEEIrVmZxe3YLyOE0a7YfkWK7yXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d9qkep+CumhK2EYGzJggudFPO6ICEuNAxgh9rwVI1mTSXpuRgbZSb9uuemCyAw/+JOLo/ztE30RXdgXGEhL8WOs4JuSxXCgzmDxPs5lIMNC/qyW8Ie+sku+1F4OQEx3DJ+/z6E0ALS8DA19UXizeHTUlxlXegxzY4j9fXsSNmOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hA89OtJd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AgFCvbCC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KKDPrB005553;
	Tue, 20 May 2025 20:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=MskeSZzjVcy+yIAyzU
	CPH8jqRLcxNRkIUBepb4c8FCE=; b=hA89OtJddmOusmuayyOzX8O0/ZCESCYk9I
	lflsrXZOB0fIaEXIEqK03XBaPq9CDwz+8u3rOIoyGbpISZrqbb7aQLTS847iHz6Z
	rS6JpLPUK+iOSOsyL6KFJ89nMmICaAP/dpBSIjpf11RE51Xqd6ut3rLbqGoIeD8g
	i36ls4jFpyduP1Cm+7/1rMJW32vz3pkCrtHBJE3EjDMCyfsTa2DbjF+8DB7jo/YS
	lHRj8l04vKUwhI31Wxs7hqH1Jq/z/ty+KGHd5QeVaAEjeGXtzqsBFUcdryiD1VJ0
	yyptKXnSx9jzMceZB94w8sGJ1gFtIlicgY1efqIq+IABA50F63gA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46s0jkg091-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 20:15:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KJkwJD023769;
	Tue, 20 May 2025 20:15:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwekgnhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 20:15:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tePUe5cBlmJi60l+lQXx6xJzPiAEW/bEWIELV2fyDazkaT6xv6bKrhpkTNGQ9a8aKQ3Es7x7Ge5zj4iXyIDkUcF+S8ip9GDJXvu5lsZ2Hupj2RLw6A4Lhx4VO2Xybh5Ee7uRPzsNDDn8x1vI2FvDfGThv9xfrye8yC64nNPn26NQKieaZxuhiKhWZFqRtk50IefhA2Pjr37zOrMA/Vehgmf8KG0/LOWUj40FwV2j8nPbZmVhLs3aR1NvOiADjUvDFDDwkZS8KvO9xUFyJ2CVXRm4jEdEl3FcV7Ox74m5Bryr4f5KbkPngtSUsJB/jlpZmHoJt5rAckxIFAhq9wUSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MskeSZzjVcy+yIAyzUCPH8jqRLcxNRkIUBepb4c8FCE=;
 b=byi20M90M84H6fS925L1KiDsWYP36l+k/qbAd1U+Oqm/2HX1kbqUbFTTRj7+1mES8FgWQ4hk8I0nVb52QZGo/z2W+0IqiBBIznael51RUSjiTKPHn8tPqWpCeZNq1rCYnIXo4+YtBjwH4aBLtC3As6jG7nflBKO683l7ONpKmeVivrPiKuNCkV2Abyq2iz11ngngGWS/5nA2vfVuazlFlrLexbp040D7FqAZ1Re6gPQrWSAC92kDnPvIyBtrdxUEPezgWHy1B7vcwH8l5P4DWp+eZDB92XXwRsT7stznYxDBz7T09Ljp+qnCdLcjbQ8FiFnZrw1yIRMUal2mWumY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MskeSZzjVcy+yIAyzUCPH8jqRLcxNRkIUBepb4c8FCE=;
 b=AgFCvbCCaECfT0WpzXbPkrWujpn0e6L782ONh74g9KEZ096t2ZIytjqY+LfDW6q+08lXcJkzLlBTAzO8JCZaH5ccwtKokn6z8+ligVCy9utjxcFfOyFpnRZlUd0vW+P2WSGo+z1g6BvfieJzk/md67bjeF/IHkVfNDHJxIXhPYA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4234.namprd10.prod.outlook.com (2603:10b6:5:21f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 20:15:53 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 20:15:53 +0000
Date: Tue, 20 May 2025 21:15:50 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <7d5a9a80-454c-4200-a718-45be78ec94f7@lucifer.local>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <dd062c92-faa9-46a6-99a8-bcc46209e102@redhat.com>
 <c54d2c5b-e061-4e77-ac10-3c29d5ccf419@lucifer.local>
 <ae53fa82-d8de-4c02-95f7-7650a03ea8e7@gmail.com>
 <8417a42c-102c-4f35-8461-842343d7df23@lucifer.local>
 <b45657a7-27e2-45a1-8f4d-0941216482cf@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b45657a7-27e2-45a1-8f4d-0941216482cf@gmail.com>
X-ClientProxiedBy: LO2P265CA0420.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::24) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: ea42f963-892c-42e7-5ac0-08dd97db1f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?etodrfEwClRr3Tbv6+VEob3frGAfl3ONyhZXRbSMc322oirFIL28ZLoaXaNT?=
 =?us-ascii?Q?C9pGHjhlTZ3FsFiB9XKNj9qli+j2htLELjwmKFIKPDlyC2VhiQ8QNDQAtGpY?=
 =?us-ascii?Q?oUAb6BaG8+WwbTr1hH2ojEn4dowRDf5Lah4MJXuajXfr3tmANtNTqpR0Mn6i?=
 =?us-ascii?Q?pSTaSawc71R55vLFp9ChSokh3U9P9ICyCP8MlcxRX/qNE4GOCBUSe063zbOY?=
 =?us-ascii?Q?ns00pjKRvJxJSw2h2qeb0XHVp4iZs4QQzBp6uv73tIn20c+XFMxBE5L9sdjz?=
 =?us-ascii?Q?TzEHa+VLU8ZUVISKXatlDhL/66HYU4dzPaIeCRfitxm0h0Qa/yalVobdaovU?=
 =?us-ascii?Q?s61c/DgcNudArUgLLaGkltcjk5f+Uu/Uqz/RFmNgMIPOEjyi/C/Qzj3Ig7Fy?=
 =?us-ascii?Q?nJ4uYgnZE9/C2ZpOyC4z25Z7aIKNLHOMOkO0dwKVMrwnxWNsbtqrltUqFcu7?=
 =?us-ascii?Q?8ycHDkULxoiv3I6a8s2c7WV/1D13JfF8p6kw6GJztIT/r65u9nwsPGyuiWGF?=
 =?us-ascii?Q?sqS0xdwZWf0PdC+qmSjbW5d5biZtvJerpJNp1oGUEhbv34lA9YmiKCUpggTx?=
 =?us-ascii?Q?rslR/Q7pkz7MNCIDG1TDsY3rBfqrwE+yFlstdpB8A8wzU4XtX7dwjqz/0MKM?=
 =?us-ascii?Q?ajoXkT9jhsirU7edfNbRbWMRP8yM5BRyJ3X/XG1HW5L+CgUYdm+8O9W81Svw?=
 =?us-ascii?Q?+1MieJSWUXYxjM8nMLXE6EdJvpyQ+HBBKc4XlQUuyzWrjw0lBrEyIW3HfESp?=
 =?us-ascii?Q?XdwPtJFp2bwvEVTd/GkNHBxpCdzwRgqn4n3tWT0R8ToXs+fRZCnRSXUfOujD?=
 =?us-ascii?Q?uIMnostHUIfq/6xIPN9blhclI3IQCm00+x3Dvup/hYgUpLmS7xu0XX+UZh4P?=
 =?us-ascii?Q?Zdoh7opxELv0nDe0W26BgaEpsc9d4K1C9mQMZo4dyuXvU6GIEd0d5bMgM1TY?=
 =?us-ascii?Q?g2teXH13lvgaUJNuH5UZFwm+hTF1rWaPskoZdsOoUcvsVcsNavUbiCSAxmWl?=
 =?us-ascii?Q?aKQQZgfeSrgbWbk01FVkDIl8g5GjZrg3UTWffh68hwHk0i1l+9ImaHe+bTWM?=
 =?us-ascii?Q?6LP3Ww7BWMq2vsUoVabF+eKvDaatObK7OKMKhlv9fxKxpxVZRLsvP+j7MicD?=
 =?us-ascii?Q?Oy/Wn47Nvdntu+llnG2rOARi5iqJIGs1KuxflVnL1X6FPvfL4TeCl3go2RNe?=
 =?us-ascii?Q?6eMBOiZiaEVrBWBCOA5IJUTHjo6fCBSyO4ZszoBJbb051DPD2LhGJHljI81O?=
 =?us-ascii?Q?Cmo3qbtQW9avTYiq5acQf4styBCbNWj4hXXG06+ZPJQkZt1eO4tfQcXERU5m?=
 =?us-ascii?Q?otNDjZ60Jvt1ecA8b5qdVCl7atCbhhtY3Tgl0Ee1eNR447Atzhno33U6MzJr?=
 =?us-ascii?Q?WZBBIDQ0GWmNjXWPQwB6M+0try3S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9rGDGt5hAfC3ODffE1pLSkk9tkqrUInubyzQLV5RnFFtzluOOwXlY4fiY9Ur?=
 =?us-ascii?Q?JX2NTE6ft/6Cc2eFjl2+b7EeD6vIDK08/KmcmHvfpcwA2xxc3mef3wfLp7Cn?=
 =?us-ascii?Q?LqF/M4eRsiawUgDn770MgCKWsBpzThalZ5nzARHRAk45LTSa5ljEi19JWDPs?=
 =?us-ascii?Q?2Ixtwx4Tfx8Y1QAPyWOLJwJ5DGm9WPOcXg7G/hzR4MmbhvPAZsEEa7x8RhHy?=
 =?us-ascii?Q?sIN/dVFfjQ4RYrG0MVpetx305PtSUKGAFqwnvV8WpSczG8qCUmBxSatGGAEG?=
 =?us-ascii?Q?9aQghUSBfM4yV2IIHD/7XI0LTQRA6+y0hjEEjY5CeFlJVMqeHNv5vZwbCRQR?=
 =?us-ascii?Q?I+Tn4ijNuPNSuo6hPGSYOYqUq793KK6Vyp1h55MJc+wg0hxxx6Y9nNPsHP+H?=
 =?us-ascii?Q?Ny6EXpzrucxKBgJDQLBYV8I5i9Cc0qInsUKyod/ryqy9QPIXb+uq2S8mxMb+?=
 =?us-ascii?Q?DdtHkk9a2tUiMm+T4jnPQBk95b0wgHQB3s7MHm5BgwFZrn5c+r8qykaS5qE/?=
 =?us-ascii?Q?NuoKLYeoKv5wUDRuatTeDe0TcAuLHPABflFUmvPLq3Bfxgb+ZeQtR2hpyi1r?=
 =?us-ascii?Q?sxKAajb+WQ8Dt0zOc+HecFl1J7Z1XVRmJrPsceGTHmS/J02vOddOCpyl9p6t?=
 =?us-ascii?Q?OV9O2FHPDb8AviyCiP7sEwjVYOY63fBTjbtyg4iuT3kpBhDA9/ztNY61Ntxl?=
 =?us-ascii?Q?DWzsPePoIEEmRwJW9KfdGAp5lP0SBL4b5A0gIhCCOZyWkcc8/bkWmCw1NtKZ?=
 =?us-ascii?Q?s1i8pxjso4eOxPC3sbiD1U5ugMc5Xm/iN/2iSIX1XvUuAT2NITSqbrNxV88D?=
 =?us-ascii?Q?lMq3wn4hXgS0wp0nZzu2C5pGqJqDmBiJFNmR4YivpYXGMAsW774Lhj6RnkYI?=
 =?us-ascii?Q?i4ReGnC06zDa7mi1KmYbiPWXyAO723/rc0XDwnrkb2+o85oonkSU+zkDWrWr?=
 =?us-ascii?Q?AdCTGL6CR5PuAFnrHB83xkyzWUMhW1xkanBUVZMQYu8/kZ66z1Lv4fJ+4TnP?=
 =?us-ascii?Q?+Bm3XyeDjyIkJKc4RrZTsh2lUzb4AYbnXcrSj/jYAamv19AWDXCzvZITnzTY?=
 =?us-ascii?Q?bcYaA9c+YBeWUjGiu7+wEa/FStroZopsweddQVMjP+F0DzXS/BLruotTnucA?=
 =?us-ascii?Q?lnLiHswjueo6DUuU6xSfiRgCX0/w3cwZreJVGwdCGJR+Xs0zESeQoMOIdRUB?=
 =?us-ascii?Q?RnR2gos4E1LIBPWt1ZB1m1eFVZNmNAnUTl+DwqKDXIKqrwR3mNiizsO5JUQT?=
 =?us-ascii?Q?iTtUOZOp320LEd+/6geP3U0BH+JDkD7g7ZFcKwFb0gNZOUtP7mOL6JfSwRXj?=
 =?us-ascii?Q?Gj2yHmNxA+Sgv5JZF/VSKXspGZWoH/0xvvFHeG5lYtFWU853SnFuEIBoRO1F?=
 =?us-ascii?Q?xbrgSAcEAfNdF5FH60XUwnKymorSwtKv6+Q1iyiGQS1jyiQfkOizXmzriFOd?=
 =?us-ascii?Q?eBnXHR42fYpYxMlF3yFvYRYEIdxXHdlSafbZO3/sHpd6fNEfDKCDbViJIInw?=
 =?us-ascii?Q?3eCVubzCdBadlVRkwehZcymgSbngLe7W4pBGoka4c/GheXMDpuZgcV5hno0W?=
 =?us-ascii?Q?DOabntnymcBvyXsc6Lsw2+92YFzmOHctt76QAmwvfaZ6VMo3ucxxoDr4OiwK?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rCfcVsEqAGXtVCDo0zY638U1VTl/MBtFTaAzfINknAJCP2Z0Htq3n3pBU+1kYZPwZ2XCD266TFbaeiH4uHYwAVfyyab3vQn8xX9A5A8KmhwBVjXLx+zuLn2RXBv2zX1wHGG+oN0CZpX1u/sGXhDcVETG92pA7hDYxwamZhPO/n6KOf9M8WKd2hgpwRNjMn9bOvJSUNUZuBs/bcn37rOkfqo3fmYwa96+lfI9pctJa2Hbu/gOp6KgcsglLu1qY64FBrCqTZNdzOhS3BqCGeqgEgbfmIpgh92qCg+7w3QCzr7n3PIpbQGYA6qNMZvgnv9x5W34yRTosXNxatwdV5XOpiip28OWKpe1tnxcSpAysT62ZpxHfT386gMRZ+FDTMDOdTy6DhtFYepTd+Tw1XBAgowwsjJ/GJafoe5U5CknP9Ti39DTOt8y0Nef6F1/eG/+TLlzPAqmdhnSwm3YVOvKuN2VkJFuPLZnlclcHxxbXoT0lcZIKVFhgbz/ilo9PoyMVseCt9k5gVoWm2lC5ueH6VCvXxTG9F73YJERzom6lpCI44wUMKf1PqUq3vwRk+awbAWEf1JXb1LixU1jUS+cYxVbtkWBSXD58ZdPdBSfjNk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea42f963-892c-42e7-5ac0-08dd97db1f2b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 20:15:53.4910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyippY2aWhn6kWxlVsIDsN0mCILiGA02TwzWjrKIExNFVm67Ik5ZM38uqy6CGqPQxMpuBK+c8lg4NNgbazK+wAskmHe4ZIo+c7jgSpogEyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4234
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_09,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505200163
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDE2MyBTYWx0ZWRfX/Cfgo6SLd91k oSm864TRvYqsp0ZdV4x3CZa/yzafCE3Wde1uZMzLcZTiijRw3S0RcgFyr7qObvb1druA7JpPE5y KTEMH1kmjv1JhA+I0TeGr9yfQFZC+ml538XL5Z+fq2UTpq2xpmHC+UtE90gqmjX4VsN6KXjO/3i
 Sdu/SmVTmovEntYwjYZ/xzqScN2qCSIJI2ai5e0aBYLHqfcdzqTqY/4XtSDZH4npWspFUmS0+tK LL/UR5hOi8PJQsq1RXmI8mz3rrbHMWz6GQmK9gNJp5O9Lte6JoEKPujUmYoVHQ/ibk/9OhgXV0Y 7/kbQ2zZB8jQn/+Z+ADHXm4gab9Bmub2ZBLcOmOy0NoqAyeizPFpmkk5dFU+WiH6/TOAUoJrtWO
 vGDbYb5ayNLPATH4hkD7HRKAIjeMDKQkOXX1IQlrqqIeqr2+rMzrk1nnKyZ+7qAHNZcHaWRl
X-Proofpoint-ORIG-GUID: -FPLZL37HNY5vVrSIJK2zzPGYWvhoV6h
X-Authority-Analysis: v=2.4 cv=IKkCChvG c=1 sm=1 tr=0 ts=682ce2fd cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=TysKlWw3zA9PA3QlssEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: -FPLZL37HNY5vVrSIJK2zzPGYWvhoV6h

On Tue, May 20, 2025 at 08:42:50PM +0100, Usama Arif wrote:
>
>
> On 20/05/2025 20:21, Lorenzo Stoakes wrote:
> > On Tue, May 20, 2025 at 07:24:04PM +0100, Usama Arif wrote:
> >>
> >>
> >> On 20/05/2025 18:47, Lorenzo Stoakes wrote:
> >>> On Tue, May 20, 2025 at 05:28:35PM +0200, David Hildenbrand wrote:
> >>>> On 19.05.25 22:52, Lorenzo Stoakes wrote:
> >>>>> REVIEWERS NOTES:
> >>>>> ================
> >>>>>
> >>>>> This is a VERY EARLY version of the idea, it's relatively untested, and I'm
> >>>>> 'putting it out there' for feedback. Any serious version of this will add a
> >>>>> bunch of self-tests to assert correct behaviour and I will more carefully
> >>>>> confirm everything's working.
> >>>>>
> >>>>> This is based on discussion arising from Usama's series [0], SJ's input on
> >>>>> the thread around process_madvise() behaviour [1] (and a subsequent
> >>>>> response by me [2]) and prior discussion about a new madvise() interface
> >>>>> [3].
> >>>>>
> >>>>> [0]: https://lore.kernel.org/linux-mm/20250515133519.2779639-1-usamaarif642@gmail.com/
> >>>>> [1]: https://lore.kernel.org/linux-mm/20250517162048.36347-1-sj@kernel.org/
> >>>>> [2]: https://lore.kernel.org/linux-mm/e3ba284c-3cb1-42c1-a0ba-9c59374d0541@lucifer.local/
> >>>>> [3]: https://lore.kernel.org/linux-mm/c390dd7e-0770-4d29-bb0e-f410ff6678e3@lucifer.local/
> >>>>>
> >>>>> ================
> >>>>>
> >>>>> Currently, we are rather restricted in how madvise() operations
> >>>>> proceed. While effort has been put in to expanding what process_madvise()
> >>>>> can do (that is - unrestricted application of advice to the local process
> >>>>> alongside recent improvements on the efficiency of TLB operations over
> >>>>> these batvches), we are still constrained by existing madvise() limitations
> >>>>> and default behaviours.
> >>>>>
> >>>>> This series makes use of the currently unused flags field in
> >>>>> process_madvise() to provide more flexiblity.
> >>>>>
> >>>>
> >>>> In general, sounds like an interesting approach.
> >>>
> >>> Thanks!
> >>>
> >>> If you agree this is workable, then I'll go ahead and put some more effort
> >>> into writing tests etc. on the next respin.
> >>>
> >>
> >> So the prctl and process_madvise patches both are trying to accomplish a
> >> similar end goal.
> >>
> >> Would it make sense to discuss what would be the best way forward before we
> >> continue developing the solutions? If we are not at that stage and a clear
> >> picture has not formed yet, happy to continue refining the solutions.
> >> But just thought I would check.
> >
> > As stated in the thread (I went out of my way to link everything above),
> > and stated with you cc'd in every discussion (I think!), this idea arose as
> > a concept that came out of my brainstorming whether we could better align
> > this concept with madvise().
> >
> > This arose because of discussions had in-thread where we agreed it made
> > most sense to have this feature in effect perform a 'default madvise()'.
> >
> > At this point, we are essentially _duplicating what madvise does_ in the
> > prctl() with your approach, only now all of the code that does that is
> > bitrotting in kernel/sys.c.
> >
> > This approach was an attempt to avoid that.
> >
> > It started as a 'crazy idea' I was throwing out there, as an RFC. The idea
> > was we could compare and contrast with the prctl() RFC.
> >
> > Obviously this is gaining some traction now as a concept and your respin
> > was a little rushed out so needs rework.
> >
> > So, apologies if it seems this is an attempt to supercede your series or
> > such, it truly wasn't intended that way, rather I have been working 12 hour
> > days trying to find the best way possible to _make what you want happen_
> > while also doing what's best for mm and madvise (among many other tasks of
> > course :)
>
> Please don't burn out spending 12 hour days on this! Your feedback is very
> amazing! (Thanks again!) It will take time to come up with a solution right
> for the kernel!

Thanks I do try, the point is that everything is in good faith here... I'm just
trying to do what's right for the kernel.

>
> >
> > So the idea is we can:
> >
> > a. solve long-standing problems with madvise() that prevent it being used
> >    for certain things (e.g. the error on gaps which breaks
> >    process_madvise() and hides real errors)
> >
> > b. Also provide this functionality in a way that the absolute most minimal
> >    delta from existing logic...
> >
> > c. ...While keeping all this logic in mm and avoiding bitrot in
> >    kernel/sys.c.
> >
> > So obviously my view is that this approach is superior to the prctl() one.
> >
> > However the intent was that you would probably take a little longer in
> > spinning up an RFC, and then we could compare the two approaches, if people
> > didn't reject my 'crazy idea' :)
> >
> > Obviously you respan your (kinda ;) RFC way quicker than expected, and then
> > there were a ton of bugs, which added workload and made it perhaps a little
> > more pressing as to deciding which should be pursued.
> >
>
> I feel like a ton (i.e. a thousand) sounds like a lot, there are a couple of bugs
> in a series I meant to send as an RFC (mistakes happen :)). I will wait a couple
> of days to see how things develop and send a prctl RFC (will remember the tag this
> time) and we can have a better comparison of what this would look like.

Figure of speech ;) I didn't mean to disparage it, rather it felt rushed. Sorry
maybe should have more carefully phrased that. Text is a bad medium etc.

>
> > I would suggest holding off on your series until we see whether this one
> > works on this basis. But obviously this is simply my point of view.
> >
> > To be clear however, this was not a planned series of events...
> >
> > I mean equally, we are seeing several other series from Yafang, Nico and
> > Dev in relation to [m]THP and even a obliquely-related series from Barry,
> > so it seems we are in contention across many planes here :)
> >
> >>
> >> I feel like changing process_madvise which was designed to work on an array
> >> of iovec structures to have flags to skip errors and ignore the iovec
> >> makes it function similar to a prctl call is not the right approach.
> >> IMHO, prctl is a more direct solution to this.
> >
> > I don't know what you mean by 'function similar to a prctl call', or what
> > you mean by it being a more direct solution.
>
> So I thought I was going a bit crazy, but I am glad someone else raised this as well.
>
> If we look at the man page for prctl it says it manipulates various aspects
> of the behavior of the calling thread or process.
>
> If we look at the man page for prcocess_madvise, it was for providing advice for the
> address ranges described by iovec and n

And your proposal is to do precisely the same only also setting the default.

>
> What I mean (and I assume Shakeel meant as well) is this is changing what
> process_madvise was designed for into changing  the behaviour of a process (i.e. prctl).
> This is what I mean by 'function similar to a prctl call'.

Yeah I'm aware of the definition in the man page, it's really nebulous. I mean
even 'process' is unclear, do you mean task, do you mean thread leader? Do you
mean the shared virtual address space?

prctl() already does VMA-specific stuff. The overlap is enormous, and in
practice this is not a distinction that is in any real sense maintained.

prctl() is, de facto, a 'place where random stuff is put'.

And unavoidably you'll end up with mm-specific code (which now _must be
exported_) in kernel/sys.c.

At any rate, clearly there is still debate to be had here, so let's work on
both these series and see where things end up.

Obviously I'm open to feedback from ohers, but clearly I have a fairly
strong view on this :)

>
>
> >
> > The problem with prctl() is there is no pattern, it's a dumping ground for
> > arbitrary stuff and a prime place for bitrot. It also means we give up
> > maintainership of mm-specific code.
> >
> > It encourages misalignment with other interfaces and APIs.
> >
> > What is being discussed here is an effort to _better align what you want
> > with an existing interface_ - if we treat this as a 'default madvise()'
> > plus having additional madvise functionality (apply to all, ignoring errors
> > e.g.) - and put all this code _alongside existing madvise code_ - this
> > makes this vastly more maintainable, futureproof and robust.
> >
> > And keep in mind the proposed flags are _flags_ not default behaviours,
> > ones which we will carefully restrict to known flags, starting with the
> > flags you guys need.
> >
> >>
> >> I know that Lonenzo doesn't like prctl and wants to unify this in process_madvise.
> >> But if in the end, we want to have a THP auto way which is truly transparent,
> >> would it not be better to just have this as prctl and not change the madvise
> >> structure? Maybe in a few years we wont need any of this, and it will be lost
> >> in prctl and madvise wouldn't have changed for this?
> >
> > This really sounds a lot like your colleague Shakeel's objection, so I
> > don't want to duplicate my response too much, but as I said to him, at this
> > stage we would set THP mode to 'auto', but still have to support
> > MADV_[NO]HUGEPAGE.
> >
> > We may then wish to set these as no-ops in auto mode right? But they'd
> > still have to exist for uAPI reasons.
> >
> > So would it be better to do this in mm/madvise.c alongside literally all
> > other madvise() code and the existing handling for MADV_[NO]HUGEPAGE, or
> > would it be better to throw it in kernel/sys.c and hope people remember to
> > update it?
> >
> > I think it's pretty clear what the answer to that is.
> >
> >>
> >> Again, this is just to have a discussion (and not an aggressive argument :)),
> >> and would love to get feedback from everyone in the community.
> >> If its too early to have this discussion, its completely fine and we can
> >> still keep developing the RFCs :)
> >
> > I try hard never to be aggressive, I am firm when I feel it is appropriate
> > to be so (it's important to push back when necessarily I feel), but I
> > always try to maintain civility as well as I can.
> >
> > Of course I am imperfect, so apologies if it comes across any other way, I
> > really do try very hard to maintain a high standard of professionalism
> > on-list.
> >
> > Again as I said, I really did not intend to supercede or interfere with
> > your series, this was just unfortunate timing and throwing out ideas to
> > reach the best solution.
> >
> > My objection to prctl() is due to bit-rot, mm code in inappropriate places,
> > the fact it by nature lends itself to violating conventions and practices
> > that exist in other mm APIs, not some subjective sense of evil.
> >
> > It is historically a place where 'things that people don't really care
> > about but don't quite want to NACK' go also, and to me suggests that the
> > problem hasn't necessarily been thought through to see how it might be
> > implemented by extending existing APIs or finding ways to achieve the same
> > thing that better align with existing intefaces.
> >
> > To be clear - this concept is _all_ ultimately a product of your series and
> > your ideas leading the discussion within the community to this point where
> > a potential alternative has arisen - without which this would not have
> > occurred.
> >
> > So the idea here is to simply explore what the best solution is that aligns
> > with what best serves the community.
> >
> >>
> >> Thanks!
> >> Usama
> >
> > Thanks, Lorenzo
>

