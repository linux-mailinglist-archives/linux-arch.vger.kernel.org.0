Return-Path: <linux-arch+bounces-7911-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82281996DAD
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 16:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082D41F21D84
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7305719C569;
	Wed,  9 Oct 2024 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YQT3KI1a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TqMBCTkl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D3199FB4;
	Wed,  9 Oct 2024 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483991; cv=fail; b=eKHlkRN2PJ/W1Sb0e+/KJjndhNRWI2E7NJDGNJYqIJNGwU/tjQg4Q4k2B5Z8CsM53w2hRaEiTPYmIGm+ZXIQq1n1+NDO7LvOpgGlWmXD3NUE5RoXYM6N53pU3mX28YM6XwX7EWdl3FQ+kEE3IflU2jEagaS35drQOgQnuEHAB7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483991; c=relaxed/simple;
	bh=JYvZ/SmQGZ6KfrivLdaeZnSHVc0ime0vHgPcdJFPtJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gxNZoprrePVn4q3+QKGia/qVb9l4/5gVyzQxhf3bp5zI/OOy2f0wli4LCCN0Ee5/nIrh7IcnKoGw36fS0hjMfKhz1A2gjldKI/QoVSQH+HEgIqDXWWppuSNnwm5rJrpz+KFNyKM5J9Lg26cI/ZWtzmy7F6j0KVy45JV95l45tF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YQT3KI1a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TqMBCTkl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499Dfjae004474;
	Wed, 9 Oct 2024 14:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=yxXgFJuEc2NXPdyMHQ
	X1aG86Qb/FZ1pEkCL4qsjkTwQ=; b=YQT3KI1aRWImGNXsh6YgS8fD78l93hMV9j
	JJTSb3iEjHEeNdgK4K7Us64vMHWZi2w5AEZ9uustKlm/wMmP4FhcBI5kRS7/clFx
	jbEfPvNNh7CmnsmtEFV2dnY9sJXPypibvqKZs1u/injGBf/u8N2ggeSLyMcIZ7ac
	DidHHIESyKrtT08zdUg4QcoizDT+mFVo99KXDjJA/zZMStqQlDgS99bSrc3gdc1/
	1/1DMs/aYdcTr85pzSFNu41nuxTEmFvpFuFB97H6sPaqoAn+8tqFBTPiYfTLoa1T
	EX50sRm34T9sE+UHEoVAzDYQqSIDzMXmDWK8mZTekQfPC3c8diPg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyv8f18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 14:25:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499E1r7u015344;
	Wed, 9 Oct 2024 14:25:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw8neyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 14:25:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJ4u3P9Jud89BCAy1O57hrfeUapsjMi8QunXkeblEvKFUDdaQwIVmxMd9wsPewA8Ht2yKImmx075D1a9bILDp8F1CeHs21+W4DOfNy41Xb8GMIP5Sipl2BlJirSWyqpocF/JMMGE9LPkvb6rJNVGjLKCB2cKTXMM/aU2oBI5fIZMhPkx7jlUOWHU+NwEMIU4DvkVZvFELFBB1eyhYgSBsCz45rccqZav4DC+LVX/zDu2QnWO9RojeTY7JGOWCfqYxm6qwAjzb5bW2R+Ljrb07uDkiAWZa3OlIs3S7S7WLvREgQVGmOBi08oI0U4DKH/y1mKvzlPeetOEalOXhCBLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxXgFJuEc2NXPdyMHQX1aG86Qb/FZ1pEkCL4qsjkTwQ=;
 b=RdKGVCwLjXGhdkuf7qRZHZXmciNBv+O1WeRRnSuX5GZnYLowj1ge7CnE8b6zn3kGOlWD/rsq7AmLnwVMmRLGLaaaqkZa7OuKr1bFpPCqgVGm33bM9PUaXk/xeV71tGVe/vXZ7ON2hwplE+NwYxS8GdNMIcgBOyoha/8HR4Q+0RSU73ICrbymN+wbpM/I/zCrbyNr8utc9iSwzsNf57iBP5wVF6y132lblff0O+fyPQSWvvSbyfYpmGMy3jAg+/7pRl+Fj5oso7IT6hIq3NWI7Cuu76wc+9MgC8Gi7R/8ffxBp1k+NLt+3VYyGbu9/Mves9tGib5CoSmJvnOW1jKrDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxXgFJuEc2NXPdyMHQX1aG86Qb/FZ1pEkCL4qsjkTwQ=;
 b=TqMBCTklPSIHZoFr9alWDwPb2AGjiVzVYlT16gEKghbYTvBn/yV0BpCgX4v7aoWo8DWwuEdV/tUBVbFWzb70hURCqXilgJiyDVPzvvcNMUjKP8h2GRcaDwAZcohC30N1DX0cJtIPaq/QWW/+seaxFvWm9X3L4h4/Hd5c3D++nOM=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH7PR10MB5771.namprd10.prod.outlook.com (2603:10b6:510:127::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 14:25:29 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 14:25:29 +0000
Date: Wed, 9 Oct 2024 15:25:25 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andreas Larsson <andreas@gaisler.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Damien Le Moal <dlemoal@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>,
        Kees Cook <kees@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/5] asm-generic: move MAP_* flags from mman-common.h to
 mman.h
Message-ID: <84f626ba-6abf-42f0-b520-8b622c21bb73@lucifer.local>
References: <20240925210615.2572360-1-arnd@kernel.org>
 <20240925210615.2572360-3-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925210615.2572360-3-arnd@kernel.org>
X-ClientProxiedBy: LO4P265CA0234.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::11) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH7PR10MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ed22de-99c8-4c71-872f-08dce86e39f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aCx9w7Q8z45WH6HcSi9CbYKJNM8qbyLFT6O8FAnHj9hrtFk0Ogr0Q6yRob2v?=
 =?us-ascii?Q?ei9O+Q6fOkOEF6r5Q8P7bZx3v/2MsWVWJMjsiS0J+jexi13vbph3wsBLnmO4?=
 =?us-ascii?Q?0vfN36rPWahenH5o5jg0V7sAOPmXQHUiuPDNgDwOSayxW049MgsnkgsMlvn7?=
 =?us-ascii?Q?u2BK9Yv+kQ1XttIQwm/9eHi/mhAvGW1huefomyIqodkcQUDlYlJquhzpgcW1?=
 =?us-ascii?Q?25x+y0CKNrM6/GIbuETi4km3i+zyTy+roB0HCSXbwlOaE8LxqplFrur5PC+u?=
 =?us-ascii?Q?AWH2CF9RpnW8sCq8G3s2actutEplAdbbJFxCe3mnNOflUEw33RhSi9FB0osq?=
 =?us-ascii?Q?oOvwfLVo2B99hzPVCU5cgtl48ftp1otXIjmZJj2++rwz46u2bcNlyFitQKSZ?=
 =?us-ascii?Q?Pg4BYRjG389oaNMdH6UEcWMFrBlO8cM+rrGFa8aWpfxuQ1QAlFmIKMrNoTsm?=
 =?us-ascii?Q?N5a2eCgMrgOa3uMtAAnyTLX3XtQvBBoeY+Pm4ddUDszqaGrszq4IySxjd37t?=
 =?us-ascii?Q?XHXjZEQe4Z326vaZ+0BzXbj6mjBtRrYhURpUUMvgb8ihatLFqGdobvcjDz6C?=
 =?us-ascii?Q?9sjAH7DDJQDwBiF3OlfRSEZ4iNolX6vbv8pH01C8q2M4FiMH8oenAdqrcOi5?=
 =?us-ascii?Q?L2agE1baE+gyvXL1fXkBpt1+8bHdLtmYFv6lfhuWz5hU9utgT+96A6CJkz/G?=
 =?us-ascii?Q?/9dsUL34yroEZWBR5MENyCCrqWiLcrKYHQ3Zffy2Ty9Yz2nvQNw/JwOW8Cuj?=
 =?us-ascii?Q?VwQqcBUc4tfU5D5Sgablg/Agg0/mGFpcG6ECoEFc/FxpJsaIHLAbePGSSD0E?=
 =?us-ascii?Q?CHjTPPOtjlzIFAE4xyCMumwNASG86zhnimN4STCckbupKyXflM5zLdGsFBsS?=
 =?us-ascii?Q?6XstO7Kmzsf4xgUHkZ+HfSTcGfnpSgTrURX24Bsjn6N2/TmQQ+4Sq0AlRplH?=
 =?us-ascii?Q?9v/HxVkkUrFaNmi36N8u+/91R0lwv0zFn4AhT05u6S2fuzY7SF/8qSLSW6VM?=
 =?us-ascii?Q?sdyiTe3O1t0czCMzY9vKFQKS23sX0t8MQkm9fkbjJGzeM8r/qOqF4ukjKSaq?=
 =?us-ascii?Q?xc+nRgJoD9oj7mYV3eI5R3X0wGCDzqoRigyBzFdoUtJr1OkEn7rxcy6Kcv+A?=
 =?us-ascii?Q?eRDtO2O5+HTIcsVjpA/g7S1OY/anWs5y+n25WMs44m3lZxBgwm49OmtiOU14?=
 =?us-ascii?Q?PH6F6nZUD3fZhnkdJzT6nlEpeGYcT2DluAELaKtv4Q1RetIKd0S+WS5HTHj/?=
 =?us-ascii?Q?vU4NZnUJ/pp3AGNME08pm5KEt92qyZ7rkVJjy2QOHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nlcDoBxO9kXz41J1gARLgFraSgxHRnp5YY9WEnM+IpQK8iFtnkwh41P1DveF?=
 =?us-ascii?Q?8CVLeobzIJHtPKmL06objKXiuSA6eEEtPFOF/3+53IybTmlmtJBXSQ5yrUf3?=
 =?us-ascii?Q?613DbzAukADn2QagQJrjTZccilRS1E3LFPKsX1le16uUYphWWDC2G2PqNAVB?=
 =?us-ascii?Q?hI558hvnbseDYk1nTDytY8NuenpwpTFK+RNrDTapVYIOdCZjJb81hyg91bWR?=
 =?us-ascii?Q?+IMbtvF0jQ6Y2/27BpZustZFYLC+h1KD2J2SVfl8NZGZshPe6Q3e33YnZAaV?=
 =?us-ascii?Q?A96xbmDYSfzD50bOmBDA3i3maQu9/hY/A6E1hish6COfjoRg8OiKWPaGI0o2?=
 =?us-ascii?Q?M2X1WqJVVSZMSg+LTVR7XGmmrh/EpS/jTxM2IeQLkTfYtoXGnKLoCngC8+Y3?=
 =?us-ascii?Q?PxRxXrGQAi6Cvgj+tCmsN9hya+PoZhze94Vx8r6ITCPrunAI9R/O5rXuTVJ9?=
 =?us-ascii?Q?TBe8WSoyYMrE8VTNzJIzH+JoODHAqtFxSfvD8ZLWhS16R/aMtIwFlo4l6AON?=
 =?us-ascii?Q?spHZBJfzSF6mvQfM5EHYG20G3m7tNPcSDFGeRa42Zvl/YWKUiWM4CBbc/IwV?=
 =?us-ascii?Q?SdnOG6DC3TgbODsCsy0pJwoCiRoKNJGPOE7Q34rM5QXaB/0L1gOpKjNk7kTx?=
 =?us-ascii?Q?TX+CRs/QuKbcBALfaa7L1gkDA2D23+C23l05N4tyq3aqHJOEJBI8mbOvG9Lw?=
 =?us-ascii?Q?y52Z5jAV+Fqj0zWUm0zx7ETysXipDsavtPAjxgvTPAHGzKMdXIywXt6/O943?=
 =?us-ascii?Q?jdChPSuGR/fy4jGCC4YiF9VnuJq9cMu5nvXw97XSbR26XHdYrTHHhgNUAijo?=
 =?us-ascii?Q?hsYq9B99cZcSwrlKDH87NXWCZv7VQky6OnuqhgZNjPF/uGEZXTeDXVyvu8xp?=
 =?us-ascii?Q?ULuQT7gvYDeTBfmTXZ8Z53HoNSzkZaYgf8IebkuhTdOMBhoco6qQQrBf9j5T?=
 =?us-ascii?Q?wRuwlTtxOEpH8TvknLVW7pSvoXj1HmxX+D/6L0cRCTn3FntMDXY5mV+N4zYT?=
 =?us-ascii?Q?bjh2EYH66NA0kxt9neSmpiFnh19BRxyEqc5W5JhTEQEeVli0neGY4X69nInC?=
 =?us-ascii?Q?Pr1raZQse3jDnY5/5v7xPd3sPfkKpyR6fbjJ8VXbxVaNIDIwxQPkdeS8de5i?=
 =?us-ascii?Q?NLw/9iCZ+vjDOCsSJHhVgxDAfuELjOham4fkiL5fE57GSIifRwASmWuP2dDn?=
 =?us-ascii?Q?TrtCrOBh4vcBgSqF2hE2VSGX5Wo4+cUdkxmkl8nOcNtOoko+aEITGDkRc4Zw?=
 =?us-ascii?Q?RkFgRtYXV6UXVvnIkOPFV/QA7mzCuQOyiz/CktzQCJGgcOrInel6P9I8i9Sn?=
 =?us-ascii?Q?uUOiu2IzfHEruQDOGXKcoVLn+qcfIBUQSxIuYCY6JZR6+vcRdLuua9+wSumC?=
 =?us-ascii?Q?ulokSm6u9KbkjkDY2Bym4fLlhFIOiGwuPepKyminlcSB/sOjnl/XdC3l3ide?=
 =?us-ascii?Q?ECbHxo9AjW0aLxWopxsUbkwXz0ZV/pqWkI0ygP/CO5DLdwRRuxquYZECJGyV?=
 =?us-ascii?Q?NZylN8XBHlckvX8RfI2Bz/rqIvKEg6W/2FL4CO0PyG4OGHVySkMBbFVb0dX+?=
 =?us-ascii?Q?V7O2hPD6TcYJvwJ9+jbcqtztP86WaGiJZ516WZMlfj0KFl1ADfEOOvbX2ba5?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L19mtXHRqh2yDerAu5rwfzPoI6Kgc5e+vDeXlo3atxZYkUViVV6q5Qi4QevbxbT1VcuC9kY8uhy+o78CkSKP6V7B4xmzecOZfc/09bMKGTIIMHhhZRPID4jpgv6iCGe75XLkPwECwz4U9HRTK9I2DoquYJtPiyWn0OV2TPAy7vB/W6uW3jLvKMmGgX2ZtvBVpC56GQiad7qT8RwbleYk1cwELFwPDXjE0Kn1aS3lBA35gA4q/dKkz2/1mydv/oBWj6OyGUh8b6HU9wg4IaVLipPAL+cCSFBHYIAqrVvhGR98qf47tzuaB9OGPJ4gBT+XFpGUYaWIH6B5cP9WYjpA+azE8wNJhmipQ2iXia9WSW95PAAaLTmlbJbp7h0WGpkU0kZ66N4ZhwXQwEcEVYU7V9dXbVQe9dw/lmkz7r3fP6bFZGM6nMnJnR0PDzDklme7eyHy04UfQltDERmm3cZLj683zNkZm2CcEhCxnYognBrPTcXeFAUrN8LgKGHY1J2xiQOAiuMplKTNmJCm3aJJ8Q/eEaGziRHX6QybSfndBGEHX4IZTprRu0Ld9/684+uC+VstjLDd+q+EwXfKE/f7tvH/HEeJJ/eFLX+cRXgzXW4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ed22de-99c8-4c71-872f-08dce86e39f0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 14:25:29.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JxlGYP4ZDCSMb2ieVFxVQpUEn3AikVQaJun8ihoVhpt8mCPXy3/DQ+peC9XELW6jxkS4sWUlqI18HMZ/DZO2gd5wTAL75R1t46z6aYT5hQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5771
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_12,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=879 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090089
X-Proofpoint-GUID: SPts1QMBDMdtQDY2bSWqV8rDgY3cl6a_
X-Proofpoint-ORIG-GUID: SPts1QMBDMdtQDY2bSWqV8rDgY3cl6a_

On Wed, Sep 25, 2024 at 09:06:12PM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> powerpc and sparc include asm-generic/mman-common.h to get the MAP_* flags
> 0x008000 through 0x4000000, but those flags are all different on alpha,
> mips, parisc and xtensa.
>
> Add duplicate definitions for these along with the MAP_* flags for 0x100
> through 0x4000 that are already different on powerpc and sparc, as a
> preparation for actually sharing mman-common.h with all architectures.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/powerpc/include/uapi/asm/mman.h   | 16 ++++++++++++++++
>  arch/sparc/include/uapi/asm/mman.h     | 15 +++++++++++++++
>  include/uapi/asm-generic/mman-common.h | 16 ----------------
>  include/uapi/asm-generic/mman.h        | 21 +++++++++++++++++++++
>  include/uapi/linux/mman.h              |  5 +++++
>  5 files changed, 57 insertions(+), 16 deletions(-)
>
> diff --git a/arch/powerpc/include/uapi/asm/mman.h b/arch/powerpc/include/uapi/asm/mman.h
> index c0c737215b00..d57b347c37fe 100644
> --- a/arch/powerpc/include/uapi/asm/mman.h
> +++ b/arch/powerpc/include/uapi/asm/mman.h
> @@ -13,6 +13,11 @@
>
>  #define PROT_SAO	0x10		/* Strong Access Ordering */
>
> +/* 0x01 - 0x03 are defined in linux/mman.h */
> +#define MAP_TYPE	0x0f		/* Mask for type of mapping */
> +#define MAP_FIXED	0x10		/* Interpret addr exactly */
> +#define MAP_ANONYMOUS	0x20		/* don't use a file */
> +
>  #define MAP_RENAME      MAP_ANONYMOUS   /* In SunOS terminology */
>  #define MAP_NORESERVE   0x40            /* don't reserve swap pages */
>  #define MAP_LOCKED	0x80
> @@ -21,6 +26,17 @@
>  #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
>  #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
>
> +#define MAP_POPULATE		0x008000	/* populate (prefault) pagetables */
> +#define MAP_NONBLOCK		0x010000	/* do not block on IO */
> +#define MAP_STACK		0x020000	/* give out an address that is best suited for process/thread stacks */
> +#define MAP_HUGETLB		0x040000	/* create a huge page mapping */
> +#define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
> +#define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
> +
> +#define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
> +					 * uninitialized */
> +
> +
>
>  #define MCL_CURRENT     0x2000          /* lock all currently mapped pages */
>  #define MCL_FUTURE      0x4000          /* lock all additions to address space */
> diff --git a/arch/sparc/include/uapi/asm/mman.h b/arch/sparc/include/uapi/asm/mman.h
> index cec9f4109687..afb86698cdb1 100644
> --- a/arch/sparc/include/uapi/asm/mman.h
> +++ b/arch/sparc/include/uapi/asm/mman.h
> @@ -8,6 +8,11 @@
>
>  #define PROT_ADI	0x10		/* ADI enabled */
>
> +/* 0x01 - 0x03 are defined in linux/mman.h */
> +#define MAP_TYPE	0x0f		/* Mask for type of mapping */
> +#define MAP_FIXED	0x10		/* Interpret addr exactly */
> +#define MAP_ANONYMOUS	0x20		/* don't use a file */
> +
>  #define MAP_RENAME      MAP_ANONYMOUS   /* In SunOS terminology */
>  #define MAP_NORESERVE   0x40            /* don't reserve swap pages */
>  #define MAP_INHERIT     0x80            /* SunOS doesn't do this, but... */
> @@ -18,6 +23,16 @@
>  #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
>  #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
>
> +#define MAP_POPULATE		0x008000	/* populate (prefault) pagetables */
> +#define MAP_NONBLOCK		0x010000	/* do not block on IO */
> +#define MAP_STACK		0x020000	/* give out an address that is best suited for process/thread stacks */
> +#define MAP_HUGETLB		0x040000	/* create a huge page mapping */
> +#define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
> +#define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
> +
> +#define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
> +					 * uninitialized */
> +
>  #define MCL_CURRENT     0x2000          /* lock all currently mapped pages */
>  #define MCL_FUTURE      0x4000          /* lock all additions to address space */
>  #define MCL_ONFAULT	0x8000		/* lock all pages that are faulted in */
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index 792ad5599d9c..8d66d2dabaa8 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -17,22 +17,6 @@
>  #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
>  #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
>
> -/* 0x01 - 0x03 are defined in linux/mman.h */
> -#define MAP_TYPE	0x0f		/* Mask for type of mapping */
> -#define MAP_FIXED	0x10		/* Interpret addr exactly */
> -#define MAP_ANONYMOUS	0x20		/* don't use a file */
> -

Hm, maybe I'm missing something, but why are we duplicating these?

> -/* 0x0100 - 0x4000 flags are defined in asm-generic/mman.h */
> -#define MAP_POPULATE		0x008000	/* populate (prefault) pagetables */
> -#define MAP_NONBLOCK		0x010000	/* do not block on IO */
> -#define MAP_STACK		0x020000	/* give out an address that is best suited for process/thread stacks */
> -#define MAP_HUGETLB		0x040000	/* create a huge page mapping */
> -#define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
> -#define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
> -
> -#define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
> -					 * uninitialized */
> -
>  /*
>   * Flags for mlock
>   */
> diff --git a/include/uapi/asm-generic/mman.h b/include/uapi/asm-generic/mman.h
> index 57e8195d0b53..f26f9b4c03e1 100644
> --- a/include/uapi/asm-generic/mman.h
> +++ b/include/uapi/asm-generic/mman.h
> @@ -4,12 +4,33 @@
>
>  #include <asm-generic/mman-common.h>
>
> +/*
> + * 0x01 - 0x03 are defined in linux/mman.h
> + * 0x04 - 0x200000 are architecture specific
> + * 0x200000 - 0x2000000 are available for common assignments in linux/mman.h
> + * 0x4000000 - 0x80000000 are used for hugepage encodings
> + */
> +#define MAP_TYPE	0x0f		/* Mask for type of mapping */
> +#define MAP_FIXED	0x10		/* Interpret addr exactly */
> +#define MAP_ANONYMOUS	0x20		/* don't use a file */
> +
>  #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
>  #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
>  #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
>  #define MAP_LOCKED	0x2000		/* pages are locked */
>  #define MAP_NORESERVE	0x4000		/* don't check for reservations */
>
> +#define MAP_POPULATE		0x008000	/* populate (prefault) pagetables */
> +#define MAP_NONBLOCK		0x010000	/* do not block on IO */
> +#define MAP_STACK		0x020000	/* give out an address that is best suited for process/thread stacks */
> +#define MAP_HUGETLB		0x040000	/* create a huge page mapping */
> +#define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
> +#define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
> +
> +#define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
> +					 * uninitialized */
> +
> +
>  /*
>   * Bits [26:31] are reserved, see asm-generic/hugetlb_encode.h
>   * for MAP_HUGETLB usage
> diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
> index e89d00528f2f..b70cb06dd7ef 100644
> --- a/include/uapi/linux/mman.h
> +++ b/include/uapi/linux/mman.h
> @@ -18,6 +18,11 @@
>  #define MAP_PRIVATE	0x02		/* Changes are private */
>  #define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
>  #define MAP_DROPPABLE	0x08		/* Zero memory under memory pressure. */
> +/*
> + * 0x10 through 0x200000 are used for architecture specific definitions
> + * in asm/mman.h, numbers 0x400000 through 0x2000000 are currently
> + * available on all architectures.
> + */

Nice to add this documentation!

>
>  /*
>   * Huge page size encoding when MAP_HUGETLB is specified, and a huge page
> --
> 2.39.2
>

