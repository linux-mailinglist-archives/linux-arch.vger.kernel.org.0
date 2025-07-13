Return-Path: <linux-arch+bounces-12718-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F99B030DF
	for <lists+linux-arch@lfdr.de>; Sun, 13 Jul 2025 13:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD9117BD28
	for <lists+linux-arch@lfdr.de>; Sun, 13 Jul 2025 11:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFE327702C;
	Sun, 13 Jul 2025 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MudCXKlw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DeCrF21a"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9151804A;
	Sun, 13 Jul 2025 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752406920; cv=fail; b=sF4fwGkD+Fm6M9C8a+GEpIkgfZWpwrfIpmuhkU1xP18e15QbneHfO1zm6gJ5GzprpKUabwXKi4xj7jyd56/3cPiI50TlxrIi/ajIjR2chhvRCKLe6VODCTDlevmwqoL9m43s5QkrZJqxcnyFx6PRSpFIxZTXHogSq8FB3sAfjdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752406920; c=relaxed/simple;
	bh=7CWWb/+o4QtrPwUkdSr/K3KvHLaqwuppqys+44RgI68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZwhYBus7ZNp3Mh9woOXD5TLyH73Soi3PTpY+ogiuEifQWtDr0f78vegpEVLBfWJjuPO0ybQswdDsde/C+fsCdfIHsIF8GeLOecQsYajlSjNmeLMKgtsLUFSTWDeG6hDLPZwW0leg9XkqC0hp3pRDx7f5RqXBZ6lwkvMmrw5ZCVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MudCXKlw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DeCrF21a; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56D1siAq014383;
	Sun, 13 Jul 2025 11:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9Tm2uv++yfd4C3xKz6
	Xft6uElzZHR79zxBU1ZE/bBJE=; b=MudCXKlwHttKhmZLYrF5D3/a6MG9CT8C4E
	y8ut6sUyvy3XY/VFg6l4BnsUoRDsgBgQIt1QEmn4xVgZjGEhxioyPlw3sGLSg0Br
	2d7b2VnfTms66XMRFzifVU3w4lHWurPLZuVuaqd30LfExWRo3e9svNBbBmEYlUBM
	rtfojlMJMt8HvkqfWFP+wGFY5rTT8KPNSR4VU/CEsQ3m5PyFCN0vkU1RaIz3q1UP
	HDBftiURH+I1ftSHB/JjOS4CeTRzbz0Gn6BfWUld5uogBWt+ieZj/274YOGMBwW7
	VNFzpM7OehgDns1mSjbJESQsaNOGmrBmTKaTM9KNQ7jANYTAr0eQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1ate9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 13 Jul 2025 11:40:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56DBABds013045;
	Sun, 13 Jul 2025 11:40:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue575mvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 13 Jul 2025 11:40:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTKJwwY9V355Dpvek8Od8dAU+emd4PxqoLx0xkaXBKd1kYUS4YJkr2uQxgPtPjA3LvpmyHdEwmyUUnCSwv5sPpKgW9dQMGAFifQp7IBP215Ka/m/LiUCKvUb8g4ePGj7OVXob93KgQxsjFa/5lbjQH1L+SyaN1SyzyCGY0n0HalbAOfLI1oh+mTjFZdPczRS/NOwE6U5Avb0bptzrCIPDG1s3LxxLw0x+xhjoWxCPDHVYCqdaWrICFOO6PC0vfJEnXqG0T73Hd50SvoCBDZtQi8M/Xvo1e0XoSMOaIsM/h4f32eOwGVi5dbFdj/AN6pnSXE+6WjYNUOB7Nfah0WBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Tm2uv++yfd4C3xKz6Xft6uElzZHR79zxBU1ZE/bBJE=;
 b=d9yIZpPwMYEWubzVdT98KdXgd7qsJZldfS5+lwkz+fclhfFMMGS4AMfyV2TvKiyGS9LdQoSJijc9tP1+a4BaBvf4yEXIIpqzckROZg9HTUPihHAM4uiIOMklOKBgwCtZhbhq0c4aqw5g4ts6A4Wf71aeO9Kck/zaGVRbx82mCByCTD0plEgYHHuIK0cX1vA+MyS5MHsXhlPtRvVdaCJIbVG87AVufsELio9JK27qQOSxU6HocjSEY+1YK33d+OJmpW9WT2swO8FSv1+1Lh+Cvu5MxdJGv6vf20ulZYU2/hLb+nlu8WDbU5MogK4EQ9gQB1X1b3Awf0ym5F6pFR8vdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Tm2uv++yfd4C3xKz6Xft6uElzZHR79zxBU1ZE/bBJE=;
 b=DeCrF21ar0oAOsNNCYqEqnmDN4usR4F7KjUPrcV/Xr06iN62kJcM+CaEvX21hbL2ps7B+xPx9QlI5P653wuxg7VOCRVrBb9/+/KMcY9zpeUksML9KJ8Vtqm5HYcOQyR86hK6gXXq1hKV9H1OGAFCwv/DSYzoTEiLvA8P7GS66/I=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BLAPR10MB4851.namprd10.prod.outlook.com (2603:10b6:208:332::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Sun, 13 Jul
 2025 11:40:32 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8901.028; Sun, 13 Jul 2025
 11:40:25 +0000
Date: Sun, 13 Jul 2025 20:39:53 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@gentwo.org>, "H . Peter Anvin" <hpa@zytor.com>,
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
Subject: Re: [RFC V1 PATCH mm-hotfixes 1/3] mm: introduce and use
 {pgd,p4d}_populate_kernel()
Message-ID: <aHObCemGNrGakq_b@hyeyoo>
References: <20250709131657.5660-1-harry.yoo@oracle.com>
 <20250709131657.5660-2-harry.yoo@oracle.com>
 <02146c79-a4de-430f-8357-0608e796fa60@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02146c79-a4de-430f-8357-0608e796fa60@redhat.com>
X-ClientProxiedBy: SE2P216CA0184.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c5::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BLAPR10MB4851:EE_
X-MS-Office365-Filtering-Correlation-Id: 1141610b-019f-4ba9-3319-08ddc2020e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YQXjCTAu8WgiPFzYTuuUBkoYPsQIkeNObMnhtQ4VGEAXD5aE9vinGiFjZmlI?=
 =?us-ascii?Q?rxX63OH0GSU9n1QuTJUPMLlMTamrGczX3niHVROSxNSmY6cuFxQBYPYRKkmd?=
 =?us-ascii?Q?90OXYT+N0W6YIEk70nhxx8tmluKo9EtZw1gKHi7Cz+XkJi/imWOVgtukOdrl?=
 =?us-ascii?Q?Xq5vfELPHE3lc/I2QV0osuqz5U5U/B881hOIpxd4cENgEuBNhFkR5ghEswCF?=
 =?us-ascii?Q?ZxU0mqhIzxUyM+lA64TORz7Z/9rC/RwU9FuYpDoUNIKkzsAr8ZOS8h2+7TXD?=
 =?us-ascii?Q?wIMOyHKH7bQZ7qRSo5AFT0fo1zw9VL249TDcvKYqwFBwfOstpvL6X7zVXvGU?=
 =?us-ascii?Q?NcwYIWvYUGMzyDQZrxnTDqyEcTHiXYtZOxdgzVvv29vAtjcLSYWAZsSWE59l?=
 =?us-ascii?Q?W6GDV6MrQIxeQUtfHO16jR8zRMXA+PkojQ5ElvXOQaiA5ul/sToG8Z7yeN21?=
 =?us-ascii?Q?6z88gFFGITjawYRVqfin/4PYPE0147X7wUDLywfvIOmwS9ByOLUUoow0puKD?=
 =?us-ascii?Q?yDSMwkPMV2qgtBncVtlhet3+KFSM1zIDOtEWyfAQVLKrd68njWarZ8lBq9Cp?=
 =?us-ascii?Q?tDtS+Me/IVVMUujM7hZiSSbcX3x2Yi0uiaRGdpIhMd6C2OZDXBhokpVhesT3?=
 =?us-ascii?Q?hm4bUQVdUpsLp8umG4KEQekFx2ETU+DAvOuuOBsZk5eoF1L3K82ynuwP+uqn?=
 =?us-ascii?Q?UsIKQ/oaFLbIFiPcuk/WQpZS9Q9BTokO+HSHCnn1pYGbgwhpZAjicVed9P6d?=
 =?us-ascii?Q?V+Mo/hBhP/onHLY+11UMPbVW7WRlYBMNSCW889kY0WqXVlJeo+XcWE3hEJni?=
 =?us-ascii?Q?VWCvUWJ+z71RgJDGLDXjAMklWXAX8zukYofgBtRieL7uAKjPVO7hhth16CEF?=
 =?us-ascii?Q?GnkbpeWPyf9owIsxBp8yC+CIJ2UvuesIjVuOTKN9hfW+EpR6XqTozINNAfKF?=
 =?us-ascii?Q?KRDOn5QB3ZQIfv2SaAaDjO00iqZ8dLJ6PUXvGg2ZOQ3zE+M6nJm3zv2W8h8w?=
 =?us-ascii?Q?3aXEjw2E4/7DjaSrc/51ngjzzWbYysyJvrvneouV1FCOKzUD5vcglNEyvDYv?=
 =?us-ascii?Q?TutA4GBnjkxJKvA+u9briCpN3DmaVRyM68TCLk3FKhdGm7kqXt6O6R60OdmU?=
 =?us-ascii?Q?QUdztO7l+ITrpaguszW06sfNWsgV0Z0PwnlkEberJJwJPopM3TS4fRYf9pCt?=
 =?us-ascii?Q?WSoKMhqq8ZRDhRaTM0eKi6u1jwCsEcjG1cItdsep02ZAGmSUCGe5qadXHzhs?=
 =?us-ascii?Q?X+aBvTdEJAWv3PaXYIiLfR8w5HVS8mG7w6eSA0VplSGASmb9E9Wqc5FeNPF2?=
 =?us-ascii?Q?If33xpTawOJDOFibRURb697Bw/Jazg4zmd93/C1UuHpRbP5DivD3ijKidvTJ?=
 =?us-ascii?Q?X24JDq6ih+SJu6ZQmwaHfOE8uH5Ye6C7Yn45ajiCTsgQO93YES5gNgRWH8pq?=
 =?us-ascii?Q?yxd5hXLEKC0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ECh4f/D95N+s8itp+Ef24ANbhOuLItqL12Zv6SDwkSzM3X4GJ5Y3aScAYoSL?=
 =?us-ascii?Q?c2Xf7YQyu+nisu77X5RfiYcxsJ78TJUgzIngBRDrKZfdQVRjwk70IA+drErp?=
 =?us-ascii?Q?8iDKuzI5P4d1c84RMUoIn+LiYqqw/BcRGAgEdzvbUVzjMT754Odi5JcLbJei?=
 =?us-ascii?Q?r1JOAA6nsspyu6mc2uC/ZWsg/p5eYhQl3C8dHNTSUEi5sHLAAUQVX19B1/u/?=
 =?us-ascii?Q?4dGURcx3EIRz2BsmwYjbnaBUBiczFUE+7oBpACZqFYIzjelGW8KRhyCm+YMf?=
 =?us-ascii?Q?5GB2PhVt4+N/r56Qw/4wZgVrG4AzP+P2nokU7WGcXDghstIqg+PZjShFN5Df?=
 =?us-ascii?Q?s15HUGb2rmVbuFOEAJVZh6R3JuYctVb47G1pyzhuuOJ6wrp4ps70HOcgoZJ9?=
 =?us-ascii?Q?TRpxAfRg347x06cw5yXAZedL66/Ez4BC1t1KY9QIqBWg/5FbpNyj6MhX2GpT?=
 =?us-ascii?Q?7tKEXJxeuFjCSZBY34TbwGHs2MQL6s+F6U7ckWuzZYQjSKCelrkNG91uppD/?=
 =?us-ascii?Q?SoE0QikJTCt8/g4DzBVw+06g9CU2SjfGhXG2OTQH2557yjiNO+u8O147bj5O?=
 =?us-ascii?Q?AB0Eg2WITvLeRO7COC47pilfTyt7KfxNViGGbxy0KSjBal6R1OvIgclDnaIZ?=
 =?us-ascii?Q?kDmwkIBT3j7OCSxLYqujOFuMHjBMMBUgRoPqe+A4BO+3kTsh9s3nc0ZwOJFT?=
 =?us-ascii?Q?RXmbpfNBOO0FmXDvaZN++AWV6atpGee7r+iiKZWU7AIVXLEW1Q3Vp8I07oVx?=
 =?us-ascii?Q?RZYtPsVtiWr6EeYECFOdBGdYi66GML3rz4DtBvSntNOm17VillVaD/2pUqc2?=
 =?us-ascii?Q?lLNkjGFhqZ/rPxYRh+p45UP9kCEp1X5EhwQ/SiZJjdBftnXkoOP5CZewKVHV?=
 =?us-ascii?Q?065+bR5RNTVPaow+3KSgBZMjIKvg0YEKQc7avAynItMLoviG1q2NGfhbZjHu?=
 =?us-ascii?Q?FsiZu/L34uT2ucuW7PtVzHMVxg1dQStV5nFPyvpuDuZ2s2XWaSuM3CF3KBDC?=
 =?us-ascii?Q?GPnj0daemmFZKaZuJ8R50Upb4KobaMlczwpn9jmg8BA8iN4Jni5ExaYqrWdO?=
 =?us-ascii?Q?smWTi7DBBeMEyL9si8hCSpBBBRMkOEdYEkOsdk7hUG6jXZIfd0hW2WDqszCV?=
 =?us-ascii?Q?2aYVlld87lAym8i0Jg2U+WnA5HP8p8rku1/sybQMYJ+vJ7HiXosHfXmA8xZM?=
 =?us-ascii?Q?8tcRaElyusj+z4jNpNHyMHlJjWj1Lsxjm2j2+dR+3Ib/EGT6BuheJQFC8hE0?=
 =?us-ascii?Q?b2XYQ3tkE91fzyUHKB1omRSPBicB/lEsIhXdsJQ6r7TByIa7VUaPY53ohJXg?=
 =?us-ascii?Q?j17v7X4eBHe1aLj4zRDMJiauFpn1AaE4lY+wR2e/cMax/kAeMqO15f8Y5cJL?=
 =?us-ascii?Q?igppsrkLX27sPzjNrLjqk+ukxjOy6gDOVTzjljSSbXA9Bg2bdBIq8gaabEAp?=
 =?us-ascii?Q?BHkY1xH71BTTPfs8CGp2/N6eFUs+oOZesTv8R4z55MSj0r9F6cMY7D7+b72v?=
 =?us-ascii?Q?Ta0rmc/1OKr7QqbBTDjr+5+F+4boi+J64lr0NAoVF8DPPO4W+kLe/BAuwOq6?=
 =?us-ascii?Q?ICOgO2X+P1p0FM+5sjXlQJ5l53wjdag8Ye7dV0ib?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NMoN6jafLRm/r6HJ4dagYjrTT4ofssDP+b4Nz7YWJnS6caiZgpaO/DxT9HyrMbD9poMMFZEAqESMTQhxOCIcVDBOawhFlKeHG47wpYaypR51l69gQ1MakOliSOiUQ3ycU/06ofYqfhJHRTQCqhi8U8SfX4zAztsDZi7pp55YyzGNNq4CejsD5Y8MKlIfNgRUBpppOUcSCr47Ac/mTXl4UDzM8Z1GLo8Af3A84rX8qMbs3+8Xd1MhTMrOmUV8cgdphl5T0wCaFlIWp933J9gkbv6MKL5Zep2OvgYRk+o5WsIXtqjtt8GcF0leZPHU276WS1OKnDxfg/hk9+8CJrJxIypGGciF0AQAsJWSRZ1SNI436wEHb4vk4uqtZFmOe2JgAwlC+aDb7mJ7Ybg+OGaOYve10y7o7XEXe0b7mV14gVIDkay/pfMPDbSQPIURpQB1mwXDW0LGaNaQK3xaAWnz/OC0ms1+CgeyDLxN2OhVGmaF8dRSJQ03iFG9CHra8BUW1T4mALj7cZpyTepWYDN/4TuSwdHYJzMLf12SygrNpvDFtcTrKKRwHcLobNtZxVsGkx9z8thXeNeuIEuHdA+JMXgX+hZrG4FhlRzEVj/CCFE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1141610b-019f-4ba9-3319-08ddc2020e97
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 11:40:25.0523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5a6zwtSDpFDiuPVEvIB926Uv1xvh+ubk2FwipPrCQfjz5N5FqAzAdwXvGA0sVpmoCOyIe6MlqeYyLpLdvMYEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4851
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507130080
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEzMDA4MCBTYWx0ZWRfX+kg+mS80s8nA jX4dySBEI8rd/gvW8u7lb2k8KejaCygHwaE7TQf3F0WXlQpGs8PO92LB4H8eFa8iE8JURcnUv0i X73DjtawwqFMYcgyfyCkzANj17eEcxZ9cXupMYiGBLwo+yhAE2emQH8XCWHKWgxaYKdRAkTlRyX
 FjyrgSz+eGO2ZrB//sGyDyvyIvfyAnAyT3toDfNixU5wLX08XvE83uXrzRgy9iI54boVQ3t7jl2 eRf9AqfMtMJ5dgCfCZo3RpkPrn6YqL0TXenvbvDn0V9T9vBGVBeHeBaFDtviECOkD7C/MDfOqPP mXPjL2OlsLsvG/Fbakpp8XN4HRQ+X8ey8ghlOiVntuZC26FA+jPGxBupNGVI7+FOkhKOp955Yaa
 nsa0SrBCEr7O6b6mf/9vFbs9rHJPQafffukgF/ZcyGukaA69oG/kL+29PmWwSvMKeRFtjAzI
X-Proofpoint-GUID: WS086qedMtJUjWfLpQ7lZyKmLqT0DX1M
X-Proofpoint-ORIG-GUID: WS086qedMtJUjWfLpQ7lZyKmLqT0DX1M
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=68739b35 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=JhMMygH16cIOksiweZkA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061

On Fri, Jul 11, 2025 at 06:18:44PM +0200, David Hildenbrand wrote:
> On 09.07.25 15:16, Harry Yoo wrote:
> > Intrdocue and use {pgd,p4d}_pouplate_kernel() in core MM code when
> > populating PGD and P4D entries corresponding to the kernel address
> > space. The main purpose of these helpers is to ensure synchronization of
> > the kernel portion of the top-level page tables whenever such an entry
> > is populated.
> > 
> > Until now, the kernel has relied on each architecture to handle
> > synchronization of top-level page tables in an ad-hoc manner.
> > For example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for
> > direct mapping and vmemmap mapping changes").
> > 
> > However, this approach has proven fragile, as it's easy to forget to
> > perform the necessary synchronization when introducing new changes.
> > 
> > To address this, introduce _kernel() varients of the page table
> 
> s/varients/variants/

Will fix. Thanks.

> > population helpers that invoke architecture-specific hooks to properly
> > synchronize the page tables.
> 
> I was expecting to see the sync be done in common code -- such that it
> cannot be missed :)

You mean something like an arch-independent implementation of
sync_global_pgds()?

That would be a "much more robust" approach ;)

To do that, the kernel would need to maintain a list of page tables that
have kernel portion mapped and perform the sync in the common code.

But determining which page tables to add to the list would be highly
architecture-specific. For example, I think some architectures use separate
page tables for kernel space, unlike x86 (e.g., arm64 TTBR1, SPARC) and
user page tables should not be affected.

While doing the sync in common code might be a more robust option
in the long term, I'm afraid that making it work correctly across
all architectures would be challenging, due to differences in how each
architecture manages the kernel address space.

> But it's really just rerouting to the arch code where the sync can be done,
> correct?

Yes, that's correct.

Thanks for taking a look!

-- 
Cheers,
Harry / Hyeonggon

