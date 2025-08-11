Return-Path: <linux-arch+bounces-13118-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF56B20805
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 13:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A7F18C44A9
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 11:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF64D2D239F;
	Mon, 11 Aug 2025 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BSz/Bpj5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F/7OqLxy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F882BEC32;
	Mon, 11 Aug 2025 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754912368; cv=fail; b=ooWd8FK0cnItUiq5tcyuZAfpxt+dEF2ZHe8lfBLTBBVDL8be4G6SqofG1MWVYgr0tWMQ4YnsixTiCyiVe2FLbi5urbr1EL3sf8r7Ci61HHOn6AodXQBfShijrXEflL1niAeh+KhSXtS0Lz9bSEY2WsZXEYCaEXKZT7m+3OTGEoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754912368; c=relaxed/simple;
	bh=iN7wN/QVUhdhv1FZEc2o2v9hBiXM0T5ZPltOx0TptVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QfqJ1EWViVRSV4unIZb4//sVclJgVBOBLG7Ntsclay+TAZ69rdRvUEz8JUpBNjkihLwccT4vx7uF2jBlDFNboLia3VCn2+WGO6+WKWOvTVK7cPvMaleGAjJrfUVPwavPcF+GYla/v7RE4uzaW3GxVMsXQO5f8bXDNpnwYurDb7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BSz/Bpj5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F/7OqLxy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B5uG60028696;
	Mon, 11 Aug 2025 11:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PtTgcNRFCMCs9ANeZx
	wX2O3aTW4t5SALMHS/X27xFjU=; b=BSz/Bpj594eH78EK6dseznbSZ0wYvTdqY/
	5L+Qz+3Ev91C7I2T5ihNd19AFHnwoYBZ9yKBgWfqseJr/nrXDw/qGAKcNmYb+G5/
	PaNvmpC22VyB7S3q94Dqz/b3Fgd3Yfi41BMxkwr+tCIlydRqz46wooOHJba4WwvS
	U2YyZ+ajDypielKWw3MFOaZ1ffs/7ZIcUxWe6uczdgedFjueYWYPN39LVfMdKX4w
	0yLj+i9x1uspKHheHwwxL2oaJqpC4Rz7TPYSwaJ44ZI0ovq/VFK0suwZomSaZ7s8
	X7Sm+Wk5Nv2ndGofkVCpCS+bsds4/+g99buqMXKHr9aro8Am3YiQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dwxv28gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 11:38:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BB0hTW030099;
	Mon, 11 Aug 2025 11:38:42 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs8h82d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 11:38:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3ZPmLdhalX4haUCdXmQffiOO6cSMyw+BRk77EbN0UAaZZpvTEXYf5BxiQPeW+c8TwpFNiuIAj+Fyd1YDZpQ3cnlMhmnxJUaOj4YvMduT7UUlhFOMmc6qe65UaFWyGlfZchlod5pjf5MMDGJNsRvl2HkVXQA7jybt1oP1LvSX0sv+2CBaJwRQKUZXBxtHmTZdwy/IJ0BTRUyVqwhHwYGBNV+uZ/HAjpGCIlVTN/1htaL1BA9egR+uDPzwHY/VUjIR6gOq5tDJK0YIT8iFU5jab8DUuGyhAnS4MvKFEoaVh//bSWbkz8IgYjd/nAnVd/a91VKAVC/gC0l/nAiUoxgAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtTgcNRFCMCs9ANeZxwX2O3aTW4t5SALMHS/X27xFjU=;
 b=qaTSMuDvvYQGBEi1AVCnJjiV1a218/oMRGr2Cao4Xh+d2Sa6cBZu9viwmuxDgk8qdJYF33N9PRMu7aWOouIRZlmf8XpewA2otmzaZe9bRUrFe6su+2GIz9uz3LcOj/6sXk9hvH+VvV5aIVG3fGUvLYTnoT352KrhnE0b/50putHfcSMraWjRihyEga+9X2fsNVacdwKA1UtgUTZY9K9yTPEg7bH5AlXO4sNHZ63XNEwC2BttSxwN7gGzvVUwGLSgzvDsDIBEvAdss+Ayv6rWJJF3MyB9Vd10bn0g0DV7hcP/vwlKg5oZnOY2SuOcSjHxDqfZVlAHjbMvuLO9HAufMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtTgcNRFCMCs9ANeZxwX2O3aTW4t5SALMHS/X27xFjU=;
 b=F/7OqLxyPKugsvDilQeSTib0+nwvnuOMWoLRD76fMvcyWIHq8I2ipZFFRyL0Bny7G3U19GLsexzdpCDgdWypH+QrDsRObGduexzmac4o+RXnciG60Ixj8vGhcym8o6ELXbx0fBXGI4pHwsKRW8AWuNumJdBQ6+Fsnzn9a978e1g=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7477.namprd10.prod.outlook.com (2603:10b6:8:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 11:38:40 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 11:38:40 +0000
Date: Mon, 11 Aug 2025 12:38:37 +0100
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
Message-ID: <8c8c6895-53fa-4762-98a4-886a53903341@lucifer.local>
References: <20250811053420.10721-1-harry.yoo@oracle.com>
 <20250811053420.10721-3-harry.yoo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811053420.10721-3-harry.yoo@oracle.com>
X-ClientProxiedBy: MM0P280CA0063.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::27) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: da1f5252-d839-43be-e516-08ddd8cb9e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HAhfix5OV8RV/b4/0k5n9OZzgUq1rNyWLuIrJKnACOqbWXEQgbFBci/7dOsD?=
 =?us-ascii?Q?gfgeGG3nBTs5F5wJ3TfdipOYHpPtbkFb8aDI8moYKPTJqJ2JmiwW1DmZg83C?=
 =?us-ascii?Q?5xfNzDGF6kMD2maml2nh0V9IXrzbFk0uWUtuprYCwdVzhid/vXyj0UyRKe5r?=
 =?us-ascii?Q?xowB0QuSRMcwqRbjUKupcVN0Y/MQEcMDDAVUEAHqILr+6V6tfGycJa2cvt9V?=
 =?us-ascii?Q?kK43y+hOKRYrV0ojcfEnEQFxOun0Hb7zOswxkECBXMVrjcH0gAnaHPlKaK7D?=
 =?us-ascii?Q?bQ/ZD+lpEkg2N9rPLIsaFoDSF5JPQH08GW77lg+m+zb5FaykbbTrv1aa7EdG?=
 =?us-ascii?Q?P1nW9dd6JMXY05m5Kkau5GZSKwBtrGMt6/stRuyycYoN9/i7b8iAjWGt5flK?=
 =?us-ascii?Q?XWIuIYuzYNBMdO/FMBeiPRpl4iIhFwc/h9JCVT+Tf48Jzsv21BX9zXPdzE0h?=
 =?us-ascii?Q?Kp4kxRogcMcTvTgLpWsW9V6s9gd4Uz427e5JcBz6aif1Trwn6RL3jDablFCl?=
 =?us-ascii?Q?NHG5Ndzyj0NJz3oFJJ1LRZTwQb/Qjf5hiswOKDJrmsArX/CV7/Ud8D+uUxAD?=
 =?us-ascii?Q?GT1tUMtyzv+88yxwjCOh9bu3q7STAP1KuLvZRJiCODAZ9840OT1ABNAfXLYW?=
 =?us-ascii?Q?ik4lYkG1lWy9P7dDOyxRJ4aN2WQjhEAKgCjmG44r+kL6Pye1YgaQ+RHHL7kd?=
 =?us-ascii?Q?uVtjhzf7LSwYhkS6iYVB/Tbg5mWtBs99oO2vAAAhkl/lgJQBCA37A5/vErM8?=
 =?us-ascii?Q?mJOSprkKgXLCMSfErMd/S6swuxG9iE+VYjnEouYvqy2/+vpvcwJqMbNkIlsO?=
 =?us-ascii?Q?4gjeqQxhej7pacQ4Bn2eV2zL+EP+VqgbYo0xXyEYNxG0QIav8oGQrhCtt+HS?=
 =?us-ascii?Q?qH4k89GamyJb5zqF8h5Ic9/wlt8VFKyB3jxQOoYTMGjJtm3Z2V9sG159J99+?=
 =?us-ascii?Q?wjw7Jc1eKS8Z6YAVgqjyClkvUBHq4Qm/e5Um7yyuivmI939Ew6gcNszIP7ti?=
 =?us-ascii?Q?cAEWe17JalV7RhLRm+lbHI4QC5JfyCIdJvJyF5YbKJz7Bg1Ia0APOAANjMhI?=
 =?us-ascii?Q?snGNLZVadmYAbBIo9tV5r+EYBmKO2k0EH/0oLFpBRc4/JbX7o+6c5ZIpc9cw?=
 =?us-ascii?Q?Ps6hXCJCAMXN95kxgU5TjCtdPppqehNBc+54KVSg6ncnYtRYMk8x8Rqu2LOW?=
 =?us-ascii?Q?mNYA+iW4nk4AC7g/kIsylbCG2WDXT9JU8wJsCGaerjskiqSQ040p2DnyJ89n?=
 =?us-ascii?Q?XAnRY6HkfPe+gWATb/AUCU/AVMlcfKsrzeJkcKg6glLWtaxJS5BhELg2gG/p?=
 =?us-ascii?Q?lGGKVR5Gwp68XvcCSxbpsrq61JpCofGEbbO0SAJWRH5KQYCHCwAGEafMARa8?=
 =?us-ascii?Q?HpS1rRMW6EhLrYmxLLrJcOjqYH6vfF04LUQZekeRtzDAyQszC5CQc+/qxUwH?=
 =?us-ascii?Q?UOaLnK//2D0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PNNBdlxKpgW//MfutyxSObquuExNknD8jFzU7E0jL8uQqfputZNNQExYxoHu?=
 =?us-ascii?Q?eCF615ss2+totTiDv+YpRkbEe2iupTDodSY9ttvNmp7Y7/ehTF1AdUGekL6I?=
 =?us-ascii?Q?9AhmLiq/knxrJ86Dv9MDpTA6BLUDggcrFWHHjimVUi+lUDnWVLofGso9qALp?=
 =?us-ascii?Q?b3HUqvT12DEY1BhaHeFIypBSMf9mFppfo44Scz6XFQuLCmJahORZj/lvkQxj?=
 =?us-ascii?Q?JkPQCBL5Om+RmK8uvYib2iqq2mV+aq6beHFG5Tecbga/+YtwjTyrmnlzGHyB?=
 =?us-ascii?Q?p5aCSoJKn4bk2FEEWjfSrkeR7ZU+YRb+Zi+msiuagvbziEHzvPcOPqudXp/y?=
 =?us-ascii?Q?vY4xVjsIENo0TOHMDFneregBWtSRMBab4v2zkNzfmzskel8cHHeh+hn3aohS?=
 =?us-ascii?Q?93QbHRel9BCl3qu1XMrWaEeT201SpAebCcFI84h+20B13MWqsSphJQVh/OeQ?=
 =?us-ascii?Q?EVfnUkbN6Cf2fGOUFnxvZZ5R9lxdqudkGmRzjpiJVE2hrwGJchaZF1XkKqa8?=
 =?us-ascii?Q?VMhr+HAZIdxFakqmXLXjmKrbN95hCeSjzQmJX90HlD6iA9+kqVuG83BikKuA?=
 =?us-ascii?Q?9BGBeLS4VMPdxVBWI5F4LHPpEmK2yteJs2ci9NxmrCkmycHaoXmiTz4E4Ae5?=
 =?us-ascii?Q?bcGg5iQyCiN9ZH+f86iixzNJaAJRnXouSR2x4wxvj0XhFOMQ24SxGmBi0rTF?=
 =?us-ascii?Q?/ZxZnN+AWF2L8x6RzqXSkhOq+biuV9a7NWvwtzD7oDnW8JuYaDsjJu2eH6+P?=
 =?us-ascii?Q?Z/BoyNSKOrXDY0EiMJYfYICv3s2+t3LnYN1ZW+QYxnqTd8aSX+5ENLwu37S/?=
 =?us-ascii?Q?lS6c3daEyn3QnZInUZmjNXneR4darnlnv5nuoQ1PL0cln7tXx1q/dyFpdvhr?=
 =?us-ascii?Q?8iEBrYpfuyCV/75u8MosNIu+0t27PvbSsZeWoeJSZKPORf18QGKLXW06DqAz?=
 =?us-ascii?Q?STd0PZ0erPpPDAseKzTRaSKqMBUoVFtl6PsTcck0WkGJcuysreY+cEP2G0Q7?=
 =?us-ascii?Q?TntTLmBxJLfuo93cliEtTxKlg4xBR9YKnwwpKjluIHfUETi6SEutY6hw+9m+?=
 =?us-ascii?Q?lb+/+IWlT2l5Yp4VR06ZPayabEo6S9bR0cpSR2uwMG1gb8izUjFCRkTywosD?=
 =?us-ascii?Q?ddjAkPHd7F7z7WHPW8brfl2GpKI9lvguVe2AErjcWjbowlUeOXI+Km/jaMxi?=
 =?us-ascii?Q?2RhnlwLzIpYGffm20RX9RIEtO45ms6GatHFh5ej7Sy1OubUgYorxo5Q8bI9N?=
 =?us-ascii?Q?20IriTALlnw+y1O/2KcUiEpikdyWg9+IINgdH5SGIAMwNZRpnr1mNFoApvNt?=
 =?us-ascii?Q?T7n4TVk5LyuSjpaNlWPEHMwS/ts/sgBQ4/TEz/wePJEEdDOAFjKr7ZOpzvom?=
 =?us-ascii?Q?8znl1FkneSkfck00EeXkG3vluTqUuIyw50rDPaIdsU+USvBGKkFz/Au4m2OT?=
 =?us-ascii?Q?ZLhU9vpt/zYnm9LDd38rh7lTxHOsJcdb9Sz/bD5GPpOX24t0wVutK8EPPAve?=
 =?us-ascii?Q?+y5W/xRlqLZ4L/uqJoWN5prCZ7H4Mss26ay9X/RsMDeKwS6ifa57pHdeHP2q?=
 =?us-ascii?Q?DxJc9OdYN57dKsySnrqjbJKTNmsOkR1GK7VoO45A+XMY/axP7d99NTSAaBSz?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zJM6IC01PbC98mGlreJS5V4JNkw93SzzPApXwrGTaFonzxPM5qho92h7qv7Ekc8kL0SBOLBpw1Iy+9045Ov8Kr7YxQ9zQ/xJ0HnX5vUcvtBXAp4ZWGEwtBB/18jjtXb7QW11vNqiJBt0z7eSeMgKUbFwJI51bQ4QKQ86NwZGFGlYNHLhXcd1ysycTCKv3p3WspSTUosiWJUxtMUAMbhCkhWihmu7iPR6q4CYDV7nKXqN9bblKrDvfuDB9oHWABhDjmNU+DuderMWw9oI0gPRxW/eEd6CYAow9a0tANacKm01uq0QNo8aeYMD2COHBsBynTY+z7WPcXPvbba96r2c00LeZd1ondtfbQ4Yhduas/diAyiVZz2ZMtYbulSiFERMnwEoxQ88mgeN5hxRLHv6wipazzTzhtodCOnxqm0sZcW4AZvGh280a+6TeenNaktcUQiht5ZBCt/DikSSdDk8h4VvCp+JMaOhnffq8gFM2jdZfE8gpRAwTYudZpUwH93OCBPnxC325g6ys3HXbx4JzPLUpg0i6vuxKd6Pu7+c18hvjs2gVgV7R+K6iiGwFio5XjY3I47GRRTMgyuhtLadVpG9ye1dhFU3TpsBLQIHK5k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1f5252-d839-43be-e516-08ddd8cb9e28
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 11:38:40.1821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQZpERCt5GKJrX1PYhbg0/OS5Klu8dds9UOGfYf7p3UxicP/gnudq42a7YluxdZTd0UYrKxVS4m4EUiC3UsG8RyENZIXHYdXcUueq5hlckk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7477
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110077
X-Proofpoint-GUID: B06mUZsdT3g28g_fZUuqIl2Z-80C-j5H
X-Proofpoint-ORIG-GUID: B06mUZsdT3g28g_fZUuqIl2Z-80C-j5H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NyBTYWx0ZWRfX8GGDAyjds0dP
 42nenZX0PkpxQlUdyNPb+DP9keMTU25SG/+4x15Ex5YPlSPbTvFx70LKst914tVpm9i9whYNhC1
 K4b3baABLl2p6D3203t96Mn5kfWikukks9Z7V3Vst9uGepqIRE8iBo4hF3kg+NyWT+B0g60I6oo
 CbNVfnzQAAm/a23KB4iThO7LfasrPOAmLmHtmr7cSQahuhN+FXY37zZArcG1+pyv7ktr4XifChw
 CBNhcNNNuZWSSI7O+DI0z1CtPYII15uxvsGZJpsKODEb/Heajn6TnPu40xIG4zM1WAj1c3Tpgk+
 h1FoJSfF44MMtLcRGQzLPC3e+mZg/escJbmF2PX3SeaLHsuyZM42cmrj16WFVwfY0P2FwV1939b
 WYNEHMHo9yffl7i6Nb7WmPswXpO5XH33N5hvCyvHfiKrjsu4nu0sb2yA1/NXtkPM94cf0cvy
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=6899d643 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=yPCof4ZbAAAA:8 a=MWBBqDcO4zrCKASfZYUA:9 a=CjuIK1q_8ugA:10

On Mon, Aug 11, 2025 at 02:34:19PM +0900, Harry Yoo wrote:
> Introduce and use {pgd,p4d}_populate_kernel() in core MM code when
> populating PGD and P4D entries for the kernel address space.
> These helpers ensure proper synchronization of page tables when
> updating the kernel portion of top-level page tables.
>
> Until now, the kernel has relied on each architecture to handle
> synchronization of top-level page tables in an ad-hoc manner.
> For example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for
> direct mapping and vmemmap mapping changes").
>
> However, this approach has proven fragile for following reasons:
>
>   1) It is easy to forget to perform the necessary page table
>      synchronization when introducing new changes.
>      For instance, commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory
>      savings for compound devmaps") overlooked the need to synchronize
>      page tables for the vmemmap area.
>
>   2) It is also easy to overlook that the vmemmap and direct mapping areas
>      must not be accessed before explicit page table synchronization.
>      For example, commit 8d400913c231 ("x86/vmemmap: handle unpopulated
>      sub-pmd ranges")) caused crashes by accessing the vmemmap area
>      before calling sync_global_pgds().
>
> To address this, as suggested by Dave Hansen, introduce _kernel() variants
> of the page table population helpers, which invoke architecture-specific
> hooks to properly synchronize page tables. These are introduced in a new
> header file, include/linux/pgalloc.h, so they can be called from common code.
>
> They reuse existing infrastructure for vmalloc and ioremap.
> Synchronization requirements are determined by ARCH_PAGE_TABLE_SYNC_MASK,
> and the actual synchronization is performed by arch_sync_kernel_mappings().
>
> This change currently targets only x86_64, so only PGD and P4D level

Well, arm defines ARCH_PAGE_TABLE_SYNC_MASK in arch/arm/include/asm/page.h. But
it aliases this to PGTBL_PMD_MODIFIED so will remain unaffected :)

> helpers are introduced. In theory, PUD and PMD level helpers can be added
> later if needed by other architectures.
>
> Currently this is a no-op, since no architecture sets
> PGTBL_{PGD,P4D}_MODIFIED in ARCH_PAGE_TABLE_SYNC_MASK.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  include/linux/pgalloc.h | 24 ++++++++++++++++++++++++
>  include/linux/pgtable.h |  4 ++--
>  mm/kasan/init.c         | 12 ++++++------
>  mm/percpu.c             |  6 +++---
>  mm/sparse-vmemmap.c     |  6 +++---
>  5 files changed, 38 insertions(+), 14 deletions(-)
>  create mode 100644 include/linux/pgalloc.h
>
> diff --git a/include/linux/pgalloc.h b/include/linux/pgalloc.h
> new file mode 100644
> index 000000000000..290ab864320f
> --- /dev/null
> +++ b/include/linux/pgalloc.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_PGALLOC_H
> +#define _LINUX_PGALLOC_H
> +
> +#include <linux/pgtable.h>
> +#include <asm/pgalloc.h>
> +
> +static inline void pgd_populate_kernel(unsigned long addr, pgd_t *pgd,
> +				       p4d_t *p4d)
> +{
> +	pgd_populate(&init_mm, pgd, p4d);
> +	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)

Hm, ARCH_PAGE_TABLE_SYNC_MASK is only defined for x86 2, 3 page level and arm. I see:

#ifndef ARCH_PAGE_TABLE_SYNC_MASK
#define ARCH_PAGE_TABLE_SYNC_MASK 0
#endif

In linux/vmalloc.h, but you're not importing that?

It sucks that that there is there, but maybe you need to #include
<linux/vmalloc.h> for this otherwise this could be broken on other arches?

You may be getting lucky with nested header includes that causes this to be
picked up somewhere for you, or having it only declared for arches that define
it, but we should probably make this explicit.

Also arch_sync_kernel_mappings() is defined in linux/vmalloc.h so seems
sensible.


> +		arch_sync_kernel_mappings(addr, addr);
> +}
> +
> +static inline void p4d_populate_kernel(unsigned long addr, p4d_t *p4d,
> +				       pud_t *pud)
> +{
> +	p4d_populate(&init_mm, p4d, pud);
> +	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)
> +		arch_sync_kernel_mappings(addr, addr);

It's kind of weird we don't have this defined as a function for many arches,
(weird as well that we declare it in... vmalloc.h but I guess one for follow up
cleanups that).

But I see from the comment:

/*
 * There is no default implementation for arch_sync_kernel_mappings(). It is
 * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
 * is 0.
 */

So this seems intended... :)

The rest of this seems sensible, nice cleanup!

> +}
> +
> +#endif /* _LINUX_PGALLOC_H */
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index ba699df6ef69..0cf5c6c3e483 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1469,8 +1469,8 @@ static inline void modify_prot_commit_ptes(struct vm_area_struct *vma, unsigned
>
>  /*
>   * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
> - * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
> - * needs to be called.
> + * and let generic vmalloc, ioremap and page table update code know when
> + * arch_sync_kernel_mappings() needs to be called.
>   */
>  #ifndef ARCH_PAGE_TABLE_SYNC_MASK
>  #define ARCH_PAGE_TABLE_SYNC_MASK 0
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index ced6b29fcf76..8fce3370c84e 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -13,9 +13,9 @@
>  #include <linux/mm.h>
>  #include <linux/pfn.h>
>  #include <linux/slab.h>
> +#include <linux/pgalloc.h>
>
>  #include <asm/page.h>
> -#include <asm/pgalloc.h>
>
>  #include "kasan.h"
>
> @@ -191,7 +191,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
>  			pud_t *pud;
>  			pmd_t *pmd;
>
> -			p4d_populate(&init_mm, p4d,
> +			p4d_populate_kernel(addr, p4d,
>  					lm_alias(kasan_early_shadow_pud));
>  			pud = pud_offset(p4d, addr);
>  			pud_populate(&init_mm, pud,
> @@ -212,7 +212,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
>  			} else {
>  				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
>  				pud_init(p);
> -				p4d_populate(&init_mm, p4d, p);
> +				p4d_populate_kernel(addr, p4d, p);
>  			}
>  		}
>  		zero_pud_populate(p4d, addr, next);
> @@ -251,10 +251,10 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
>  			 * puds,pmds, so pgd_populate(), pud_populate()
>  			 * is noops.
>  			 */
> -			pgd_populate(&init_mm, pgd,
> +			pgd_populate_kernel(addr, pgd,
>  					lm_alias(kasan_early_shadow_p4d));
>  			p4d = p4d_offset(pgd, addr);
> -			p4d_populate(&init_mm, p4d,
> +			p4d_populate_kernel(addr, p4d,
>  					lm_alias(kasan_early_shadow_pud));
>  			pud = pud_offset(p4d, addr);
>  			pud_populate(&init_mm, pud,
> @@ -273,7 +273,7 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
>  				if (!p)
>  					return -ENOMEM;
>  			} else {
> -				pgd_populate(&init_mm, pgd,
> +				pgd_populate_kernel(addr, pgd,
>  					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
>  			}
>  		}
> diff --git a/mm/percpu.c b/mm/percpu.c
> index d9cbaee92b60..a56f35dcc417 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -3108,7 +3108,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
>  #endif /* BUILD_EMBED_FIRST_CHUNK */
>
>  #ifdef BUILD_PAGE_FIRST_CHUNK
> -#include <asm/pgalloc.h>
> +#include <linux/pgalloc.h>
>
>  #ifndef P4D_TABLE_SIZE
>  #define P4D_TABLE_SIZE PAGE_SIZE
> @@ -3134,13 +3134,13 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
>
>  	if (pgd_none(*pgd)) {
>  		p4d = memblock_alloc_or_panic(P4D_TABLE_SIZE, P4D_TABLE_SIZE);
> -		pgd_populate(&init_mm, pgd, p4d);
> +		pgd_populate_kernel(addr, pgd, p4d);
>  	}
>
>  	p4d = p4d_offset(pgd, addr);
>  	if (p4d_none(*p4d)) {
>  		pud = memblock_alloc_or_panic(PUD_TABLE_SIZE, PUD_TABLE_SIZE);
> -		p4d_populate(&init_mm, p4d, pud);
> +		p4d_populate_kernel(addr, p4d, pud);
>  	}
>
>  	pud = pud_offset(p4d, addr);
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 41aa0493eb03..dbd8daccade2 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -27,9 +27,9 @@
>  #include <linux/spinlock.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched.h>
> +#include <linux/pgalloc.h>
>
>  #include <asm/dma.h>
> -#include <asm/pgalloc.h>
>  #include <asm/tlbflush.h>
>
>  #include "hugetlb_vmemmap.h"
> @@ -229,7 +229,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
>  		if (!p)
>  			return NULL;
>  		pud_init(p);
> -		p4d_populate(&init_mm, p4d, p);
> +		p4d_populate_kernel(addr, p4d, p);
>  	}
>  	return p4d;
>  }
> @@ -241,7 +241,7 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
>  		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
>  		if (!p)
>  			return NULL;
> -		pgd_populate(&init_mm, pgd, p);
> +		pgd_populate_kernel(addr, pgd, p);
>  	}
>  	return pgd;
>  }
> --
> 2.43.0
>

