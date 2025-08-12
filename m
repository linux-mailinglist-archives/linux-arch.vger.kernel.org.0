Return-Path: <linux-arch+bounces-13137-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B8AB22CF7
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 18:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53BE662203B
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 16:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50AE305E3B;
	Tue, 12 Aug 2025 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cBMgcNHy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p+pXfjf8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCE9305E04;
	Tue, 12 Aug 2025 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014970; cv=fail; b=BO8Ce8K/epepKhltOa4YNTNV4R2Udb9Xoa/l5pgekCHtO4rVZJRVSg3TdB+GHUudhSd0xdo1l6ZXnY7AnkxpXUDtnfcP3WJtn8p3XucK6xGW0sSOonlwND8hMSmgO/OcL24OJ30EdaGdZxvTFO07bAJDFqdkF83j0HBsdPvN58Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014970; c=relaxed/simple;
	bh=YXZE/APVgrlrODhxasvSjawa7WQ+W5EQS8qOT9sfG7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KwCHHRISIfwzstpLUAMB25Hl/hDFA7mjO8Ze6zJpB6XGVtbd+jj0JuyLjuNDkTSFOu902blgCFwQxWybPNsEjg3NLl///lhRyOZamLx1agrN4NLtzGIIRMxgXpAloTCdqK/6OyYR3Twj30qkG2/nLcSF7SdcciCNVbpaPB79Tz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cBMgcNHy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p+pXfjf8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDC79h006416;
	Tue, 12 Aug 2025 16:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=YXZE/APVgrlrODhxas
	vSjawa7WQ+W5EQS8qOT9sfG7U=; b=cBMgcNHyHI5nY1FLStDNJJGarXBjrADUiQ
	p5I7Tachl9Ja4M26/zRjyW6/1pPP+FlDOg4LNs1NjbGjd3suLZtt2VyYz3FCC74W
	96/N9ft+u0HA8rx+sN1i7zSy9jlzWQlJBNwx60hW3Nk+Z/hL/SdP3oSr1jdCSA2k
	MfRTs9ZqhRUsvXDe7zTmu0+zwXy9KRXzJDanO17mmixeBbhwOGdYTwrFBLvOw08k
	2ktmie/Oo9Ga6MIOWfa3VrSfWO93nhZJ24rAPDkghi6mkstH9DBDexRVt513FHHW
	OpoEXPbK83hC/eKlPwUVpGVh4vXgrE7lt4andvcoty7RjvdH+U6A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dx7dmyke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 16:08:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CG5vL1038569;
	Tue, 12 Aug 2025 16:08:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsgq684-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 16:08:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q++A+U7ALFibCLhT0CFz+IZSP7c+G59ML2A4HpOQ2h3Rjv6rgY/aLY+Lz14R+FgAJXz82Sldolfc34PPgH5j3f76h5i68pgCq2WPvKuKQGqEnN+VMfOki0sRMBu7FMLdmH3H5+QSuRp42p/uVjQMO9DvRyedU5gedvjZtYPAKlxx5reZxF8NbSsRPDF8zpf4nBD3Dwx0oGlyd63BhSQx9L3K3LkxGd4eJV0BJ0J+OP5SJ2zbkdRz/eK8lGBbuoLl8GD744vR6p8B3fPVtuL+fPQOBeauzzDSeq7e5quJZim8XSftGx3w+pIkGq3h4KFBlQGwvx4MQ7IpB42vA2R5Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXZE/APVgrlrODhxasvSjawa7WQ+W5EQS8qOT9sfG7U=;
 b=aOIfZjrqLRDuyyb1mfhI+MVJcp+Vrr+1EyFEZTjyCOUU9W0p46eK/IRPRYDE2qPEv4XS701NIykBwigIzdDdKfh6BugNmcNQnhaBN/JJMEEx3l5llcU9kE1+tT5cU2YM3hOUVP9ImHASjiswhZy2e221aYBGrwcEncGBYVTc8RvcuiPxIMmYIROffQbJE0669c2TyUuP057TMkxgWEASJ1SfGfrLBuv4yu37zSpotXHlqiF00w7UkSqdkhbcPyPYYrnHIx97IDlO++M9L/iRw/S3KuCDQUybCvzWY6Gh4Y0mfRmMX1HZNRX7f9bIRC43d5qvWPtONzCfUfW4H60mjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXZE/APVgrlrODhxasvSjawa7WQ+W5EQS8qOT9sfG7U=;
 b=p+pXfjf8DY1ww6TFD9xnZLTUQhb7Mf4jOyosr6gVoTjyoFg57wC4UdBa6dpWNqR1fDp3yH6x4fGd42WxJLmjcugGLQlypbJL4CJep7J7kgsLqw6JAFuv2UU6O7NWQj+2vhzBmpllNvwhyQ+slRNeQIyRMtGszgJX51nTbrLSnM8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4736.namprd10.prod.outlook.com (2603:10b6:a03:2d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 16:08:32 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 16:08:32 +0000
Date: Tue, 12 Aug 2025 17:08:29 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Dennis Zhou <dennis@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com,
        Mike Rapoport <rppt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Thomas Huth <thuth@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kas@kernel.org>,
        Oscar Salvador <osalvador@suse.de>, Jane Chu <jane.chu@oracle.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Alistair Popple <apopple@nvidia.com>,
        Joao Martins <joao.m.martins@oracle.com>, linux-arch@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V4 mm-hotfixes 2/3] mm: introduce and use
 {pgd,p4d}_populate_kernel()
Message-ID: <ef82f65a-f443-4341-9ae3-5d4e5cc9cee1@lucifer.local>
References: <20250811053420.10721-1-harry.yoo@oracle.com>
 <20250811053420.10721-3-harry.yoo@oracle.com>
 <8c8c6895-53fa-4762-98a4-886a53903341@lucifer.local>
 <aJneGJSJcltEIT41@hyeyoo>
 <c3ec3012-4ba0-4b7b-bf0a-88f39ef029d8@lucifer.local>
 <aJsPLRDhan9KvPmW@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJsPLRDhan9KvPmW@hyeyoo>
X-ClientProxiedBy: GV3PEPF00002BB1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:1f) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4736:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f53d4a-7fc2-405a-b5e5-08ddd9ba7bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wvrZy5X+c+J+Pwzpe8pmrULjy+kwFEtBs5lAk/edeZ3Bh/zO0RIzsmyH3D6D?=
 =?us-ascii?Q?kwYSCP47Ib7MaXMVMXWV4NozV9ff5nMO61VLtTadXwT9CgRSQQdjiTn5tEl0?=
 =?us-ascii?Q?Lu05489eP9oJxJcUjh2YJtDClS961eAjppEjXnrh9C+uVkKvtOutY7iYjRKx?=
 =?us-ascii?Q?42NmT6JtaTZHVYrFPXYrVHbcBi8BNynsK1g4EoPauKG/IAP2Bx9jEFiW8I3Z?=
 =?us-ascii?Q?tKpksrxp01VRInae8dfh8jzoqqEolZY62PAxRnCgMbFyiXJenjE9DYlxlZl/?=
 =?us-ascii?Q?uWNDncwXfvTLalUGEDLBQwSrVN4T/4X6XehWdiqugPY3RhfDCy2e/mhfclCz?=
 =?us-ascii?Q?LZaMzZGhkI4bMt47Ztcvd6XUYNHbu4jPbmqQDAYNb3I3mHZFOYiQOzqYNj66?=
 =?us-ascii?Q?tRMQHhNFXqHS3KFUeGxqyCBZGwtJEYzhHYrcvYpbKZhNdX1Szwz0WwkeTUHy?=
 =?us-ascii?Q?IlAgxFTJ8UZuwcgjjOeCunmZgttnEAOtnC85nvuLfMVLTpvlYGQUxHc0BBjb?=
 =?us-ascii?Q?hEtXzH0vS9zZ1EPLnfErFIU2StrA3/npdiW5Omn73blqCg7QVKtJGSIJLN/f?=
 =?us-ascii?Q?JcAjRo4hdPfLd0O0oNYfiR6XQzfzix0NsN36n+3jNikQS/mLGMFt2yY283ap?=
 =?us-ascii?Q?agViZ4blHft5HZQY9BErabmDLsOO0MGN2UmeqW36tRNBzvVspnOK3Aj/llER?=
 =?us-ascii?Q?h66dzzXvb2TRjAwU4ojLBd3nCQF7FZ1vIZMquGE8ndkeE68KdS63OF84OQcc?=
 =?us-ascii?Q?1DRc2anCFr8eJ562PoPjWOTxGKwLSkQsJSxVSMCsWKmanQ5SvLdEpBiilO7S?=
 =?us-ascii?Q?wzCKRDsfR7aytsDRXF2HW5J6xMxVDC35cC0BsSldvah+dBPkcSar9l7fHm/J?=
 =?us-ascii?Q?+YrpG/+SXpBoV2nwgQPMCNUKn6dapgdD1LDFA5TSXUApnJ27pwnQB4ERnxVr?=
 =?us-ascii?Q?J3LBmxSRtns3YiOQ9c+grdN+xkpxnPTvfrLMOQf0RC5/CRgzASKxXKuNEQeq?=
 =?us-ascii?Q?2G/kTkm3CcF4FaVhUxmMUXtH4BrBxCACsUP57GCKD0UhwiSIy8we2FiQjPkp?=
 =?us-ascii?Q?AFmP3uw4e/PCyRFl17IMZkUU1smVuwgk6KdMAMuDfOYnNFoEVYGsoW5Hqch7?=
 =?us-ascii?Q?8ofYnCnws5OQOUlhi8MMr8Olc001Oa/0YBjghWNOV/pA5BnBuO0MscRt6qmb?=
 =?us-ascii?Q?/188LHxLXlwEdU9UcmrdIvzmTCqFpvl4YfFyOmeF7FulDE+4HI2gk+5Xq7ps?=
 =?us-ascii?Q?55AKjPQW8O9n+hOkkWpTIVj8VK0jz0oZ7nnTTQBcbVdrLBoeqtKZhzOfy0fO?=
 =?us-ascii?Q?XYUkPPUtlIB/ZqapFcTjGGiFeBSe01S7SfNqHpz/4r7kPdcfJ6dyESQXl8jE?=
 =?us-ascii?Q?BVxH6izefda2bJZ+Xf9Xwn3TkXmlPMCv8Y5h0020lvCVgXSjrzi7Vy1+5ijd?=
 =?us-ascii?Q?nWv70tfDq44=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rxA6Hh9yiY/bMiPRkEvd3WWijzlIGhWnZC/uqdlk9WXR5GHGinhmHMrdMqGh?=
 =?us-ascii?Q?QHQnmuABKP4U1Bp88pI+2XmY8vvifWqqagqq7NPYWOFl54wA+vihVgd+UpDM?=
 =?us-ascii?Q?WzC21W7qjG5uty/+GHnrSayOLh6n2eOkdOFAWBxiVHHgMElq1GGj1cAlWRQK?=
 =?us-ascii?Q?b6uihJ9WD01QvQNUEPLJfA55SDSI9mT9KX4zk49x2M7bGg5cM5qVo79hOVaR?=
 =?us-ascii?Q?SPcxRuQZqEfbdkjyLhiDMqVEHsiJEs4jXLK3WuEbUlx+LaQqaKcAgTPtTsvo?=
 =?us-ascii?Q?zBrjJ2Rl3l0bpA26PXU9mg/ppaheX02F0DEf42L/IA9c/kpWoDJPqQOyFjx2?=
 =?us-ascii?Q?EmqtlEMBDCCoFvkaDPkO9BLpvsZr5VAuhW77PCuFU3C26AIejXIMf368WiAD?=
 =?us-ascii?Q?r3qNyqwMGSi4X348ySdPH8IDa3AllvKP6bmO3WbZhaD9O7tncsmFA+6yMiSK?=
 =?us-ascii?Q?JJwIQRZNwAGLHwYNUnjR80pjg6XJFoShoRCdGo6Cn6HnEFEQ9ZwGVuBAOMNJ?=
 =?us-ascii?Q?7kzMQCQ21K+rlcOIFh3H4eotrLRUXvID7Q0y39YbBsMIRVypu5UR/SaCxMrJ?=
 =?us-ascii?Q?bL4GjcFuLMAEs+oAAXbSeMOwedevI18BmUz9jMxY2T+rT/7hnxCxoUYeBSg3?=
 =?us-ascii?Q?/TgAK8ARB//Bocb5hVQTWuzl96C9MnczVSEYorq/zXzX3tfkRZ9rrxAhfD/6?=
 =?us-ascii?Q?Y4h6+DiD3pmGRYntLpgyD1B5cQ0obhlVZMIOvOYegi1D3HZEoPgf08F7OLMC?=
 =?us-ascii?Q?3IKxiMrQCuuBc9bV9R9lm6LQejyzvLWIC1jP/3h2O7jlqSrgiasR8/OA87No?=
 =?us-ascii?Q?MWIYsBQ0WsPH0hV5OSDDk7g1wGqikckn/E4xz4WqGwjy/xA4sx0JTOxxm+VF?=
 =?us-ascii?Q?7iZKvqfE7cOmh7ZPELMv+MiYx6WOF3Vr3+YvSanB0DC70Uzjbzjogw0P+A3S?=
 =?us-ascii?Q?hpCNx+DOspORBt4ev+1JJBPZDiLXqVvT6sq96fNw0HekGZ0urFCDuf0c1W87?=
 =?us-ascii?Q?Gteq3pjtT3yXNzQhJppR90k6p8+ikv60Fzy9wtzXbaVuYb6u2FCjRdqzrwpb?=
 =?us-ascii?Q?F5ccRIFycLF0UF1ykzV6DOzmh2Zj4qGnxfkLGCKyNt6+LNuAQtnCkbLVMPq7?=
 =?us-ascii?Q?Gd99JriVLlMytuM2mfUvLhQoyIeWpUVF1v6nKW0vEYNFVP3wqbFW7PFmEDds?=
 =?us-ascii?Q?AC+rLZY+pJwfCqFD6LnZQCNuXXCLwluzqhhJxhmSpbL73Y/fTt4jOcgWDDdP?=
 =?us-ascii?Q?Aznjq9cma6eftwFt7P9xXm+5tGmNkEprwFQX6v7lDfwsHZTEtCfTWIEdNKP8?=
 =?us-ascii?Q?07WNlYBnCh+8MaMcE2NBOBoKWhmX2wiTKF6KSRkrorji5TeC/E73S01uy4xx?=
 =?us-ascii?Q?kfmVphJouXuE0xvZ0tkOiC4gZxG8vtbJPHEyFAo0CnMdIesUTEaUUL/HHx6R?=
 =?us-ascii?Q?PQrpbCwBvFm9wtvHCY51S42I1t1G9cpJ/gHE3hHAFap5FTY1RDMQPQRYkRk0?=
 =?us-ascii?Q?JjKoc5U48Gupsg399/GnGat1TuyOJ4aBYZzFL2UfuLHriIkZZjOyunHPWqW2?=
 =?us-ascii?Q?rBWvaTlL/pYUgqVjEkbmcO62yjWsyB6ccxI6qN5wQjvVeZLcwOKgrrOhJNG3?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MdMlDHFa+ySsEtdx+ic4nUnSlcdi9vOzYW/kC/01haK3dwvqQchh33aqmUDzkfbhTV+/h/Tt1h+CZ4g+Lz3dyHZrsvazGCxCDdugzsCQ19y8Ur09n9X6Csv4sxDe629FSRg0+xCl+8mmtiRRm8OpnrF/8niRn7XpzVjBNQyC/esFHPRr2NsVSpOmBe5WC7B4on22VjU/L2y6MIAr5IxSva5LMDqKtR52+oyzTiKxlE4/R8vJhIznuo5hvi6H+uzYpwJG/nuEq1iAZ9a4KMYKMA8iHmGOGtfhf05e049yll857kKs/pH4DwH2RdUqpR4tLU9QC+JGw15epmFP8GMTkLRTzet43OXyZMh7vyYeh1ObJ8Mowqhuzi3x6KaFUPGRzd59EzW88YTEi7uh91rdOqD29KK6TvyEKXT4K5qjb7AN3d1HdH59M00TD0dU//kcRUzpVfgjDKgfiKiDWFORhyieqkpiudi9XVN/EsDyKdvl1cj0bsmR0mQmViFKM4p+R/pb0EJNXb5QZYFbps6Y41m9kafPvWaZiT0juVHm/zEjuiXKMWT214S3svVjFbvYqHS2GYe5W6ntqYlIIaNdC+E9/IRkW/aNHwEj9NeCeRE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f53d4a-7fc2-405a-b5e5-08ddd9ba7bf4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 16:08:32.4430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oySMVdhj2BlpDsXoEYsHDomEMsWJ2z1VgydZb9TWYUE3I93OYM9TQva1Ga6sfJfKMBBLaEA/lggoC9hbEHS4lykuI1mAD9GQhbgsfnYUVeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=935 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120154
X-Proofpoint-ORIG-GUID: JevguOx3Q8WRoNlcy43cZ0yfZmZ9jFKP
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=689b6706 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=6DVgpimsu-rMQy6nj8wA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12070
X-Proofpoint-GUID: JevguOx3Q8WRoNlcy43cZ0yfZmZ9jFKP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE1NCBTYWx0ZWRfXyIFqEeloM90p
 kLNvNIxSUW6v1xP2edOjHdE1i1aBaeelkSafXmNalstrtYVYfXJXavg/ALPqs09cr/owAM8Qz5J
 emwxsOpY/pGBkfjL3fGUkWHAz27fr7bTFyVtnzQM3n9ffZbXPR7g6proW2D6cOEI9hGkEiKpJvN
 rns3QRUddOenhs6QL6eotPGKooGKmrBY64R1XimzIJZyyrXPLwRCrFWJ9AAcz+YyPP7QSiKTtOM
 Hk3Ie6b1+uBaQaJKiGpElIedYr6EPchAt7diX0X2JWdNAjn33yLMFd5/IjAXDHPunlSXeKi8AZK
 hyx9kH2A3d0vgLR5kashI11Ud8xYU70rlxxY2ITONbSqXjJW23BvPeUsQkZY2Mr6ledW/kR/dph
 deaiPo99XSc42b3G0uZ3NT6Yl4hdXNAQ4MJPgVgnYvQ08bGMUbu9hfxyWg6vDhBhbAzFtfZQ

On Tue, Aug 12, 2025 at 06:53:49PM +0900, Harry Yoo wrote:
> > I'd add that arm handles PGTBL_PMD_MODIFIED and therefore remains unaffected
> > just to be super clear.
>
> Will do:
>
> This change currently targets only x86_64, so only PGD and P4D level
> helpers are introduced. Currently, these helpers are no-ops since no
> architecture sets PGTBL_{PGD,P4D}_MODIFIED in ARCH_PAGE_TABLE_SYNC_MASK.
>
> In theory, PUD and PMD level helpers can be added later if needed by
> other architectures. For now, 32-bit architectures (x86-32 and arm)
> only handle PGTBL_PMD_MODIFIED, so p*d_populate_kernel() will never
> affect them unless we introduce a PMD level helper.

Sounds good!

Cheers, Lorenzo

