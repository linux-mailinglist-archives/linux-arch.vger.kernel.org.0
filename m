Return-Path: <linux-arch+bounces-6385-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D19958B69
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 17:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6901F24021
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 15:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AEB192B6F;
	Tue, 20 Aug 2024 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f2lW8P4y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q2mCnUwf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F225B18FDAB;
	Tue, 20 Aug 2024 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168011; cv=fail; b=OtxL68a5CYdc5UpYUT3UEyq/5dFamqxtLdL2FMcGZLIlvYknnf+RvDAPMAWf587xDC+24s/Hf8rItSiZjZb/PVYhU+NKraxgLHZtOzlM8FTeH8IVVPwDfj+55fh1NPH44/l5ydaEViG3KDiWwyfxl8BSS5zfqKOvOcEuIxfCnzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168011; c=relaxed/simple;
	bh=8RNPxUlCVwVnXEtxvZ03LSZ3VK+Y9rnerIqo4Vos1dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jz2m8ORQSol8FfZbTFiSKXqlQaNDJeMIyq+oLf2/DOltnTnRK+plveZW5yYbFw76Pk+U/NKTviQCEh2a8FUCVhTAysM5m+KGVO6Yztn33XTM2SkWbV15QLaOIqG/FnGeXsvVYLtyYT+ozdTvugDZA55u54V0Ql4+chO2E0B/Gkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f2lW8P4y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q2mCnUwf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KF2Z7C028058;
	Tue, 20 Aug 2024 15:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=AMnFdXK4oLx6A12
	gbpmrFT4U+7FLMu+DaVfoAGeA2D0=; b=f2lW8P4yzBIRorv2wvuIKNXRqMuDFk6
	li28hEBCwTjPydlyDnKzNsJJx8yItCIS83W02UL9mrekDpGJ+EAXNI9KIFGfVwvc
	Mw/SaPwKS1vYTmmzmBluDj8it3QRQ3hjsYi+S0q2zrfqY3M2uxScLvrTi4uQy0Yo
	bqPROs+cE/LgTi7wCeGhQzvGowsYWIQTU0vN+nnuFNL/6E9XL1ZwQzfk2HfLOWGa
	ysHbRK9QChunDNH15JaSEO5uKycaPxQgcQdLsFhJAFzsQpB6KwiKKjAVBVoYDbaS
	sfr4h/Bu66OSk5heDrB1TSfS60MMujjdgMzOBP+EfdtfntGiD1rGxOw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3dng6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 15:31:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KEJWjX033171;
	Tue, 20 Aug 2024 15:31:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 414vtbkcsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 15:31:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tx8g9jqNvR8IvOnXRg4m0loJzWFgI53MOpeQTpXcmOlMnEcKG2bblCQUQtylS34K9Sf4+ziOCRFDdMUTD7LHAh1xhtYK6WLi49mPn13H3OC5s8Gemh9UZLX5MFVX6dKMv2nS10IyIKvaO1LuDBTNQ2PnHynt3XZnW33L/JapB0g6nJpZ84OYevbuagFI3Yaupq31YR3rpevAnjdGEW5gB8qQ58GDK5pqhnOIJsfsVOEpIKEQbLmDK53pvuzjtwGwmPQC8tbh01WrHX5htXteTDv7IzUTL/vSVnJOFvRIsJfwUcSwYRz8BtmyU2NvBQE7zD6DWBbAIv3obQvggEWRQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMnFdXK4oLx6A12gbpmrFT4U+7FLMu+DaVfoAGeA2D0=;
 b=WsY4c7U8DraJBadzaxOF3bsF1Skq08GKO42QKHkl3iPF3HnTVLcTYGnk8ayEvRRXtewRpBKjtnmlkFQAIo9Y4kbA9flks13LH3AUQy020LEqKl8JToYNbeugW7z/KJxjI+bdS3Nz+Sc5lrkuhqw7eCot8ke6Prl/vJ10pQ24w+6EMrvUoyEdc1H58Vjv1szRI1HwnR2qTOk6GwYdOdYDic6DrKobp8Oyy1iG8MQLiL0PzuVJhlRNcv5LLTD6VwfhrUUva1o5tCQ1tal7Oh1lwqapgjD2aoLcI6+k+NzmF9bNwo/GdxCswtYkDnFTtRoiwEAEcHaBB+NwTSrByg2xEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMnFdXK4oLx6A12gbpmrFT4U+7FLMu+DaVfoAGeA2D0=;
 b=q2mCnUwfnqn4qgZqnst/Fm9tlg3DJEI1CQ+32BBSt0z+f0OpyvHYTK48WeoEQjrGzFr7FSpjWtwmqoKK4lHhVXKNhoIBvpNZFISZggNCJaivWvYxQwNRg/3Xs+Y63bk3PRyfdmfB6TLyMfDoulHp+7+lFx102d3FoAZ14WVWEOY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ2PR10MB7672.namprd10.prod.outlook.com (2603:10b6:a03:53e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 15:31:19 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 15:31:19 +0000
Date: Tue, 20 Aug 2024 11:31:15 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net,
        arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org,
        thuth@redhat.com, tglx@linutronix.de, bp@alien8.de,
        xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com,
        vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, dave@stgolabs.net, willy@infradead.org,
        pasha.tatashin@soleen.com, souravpanda@google.com,
        keescook@chromium.org, dennis@kernel.org, jhubbard@nvidia.com,
        yuzhao@google.com, vvvvvv@google.com, rostedt@goodmis.org,
        iamjoonsoo.kim@lge.com, rientjes@google.com, minchan@google.com,
        kaleshsingh@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/5] alloc_tag: load module tags into separate continuous
 memory
Message-ID: <vixjfxqv7mat22rlaco4eyple465hada32ymis73aqiozcszte@claj6dxkgv5k>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	corbet@lwn.net, arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, 
	paulmck@kernel.org, thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, vbabka@suse.cz, 
	mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, pasha.tatashin@soleen.com, souravpanda@google.com, 
	keescook@chromium.org, dennis@kernel.org, jhubbard@nvidia.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
References: <20240819151512.2363698-1-surenb@google.com>
 <20240819151512.2363698-2-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819151512.2363698-2-surenb@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0036.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ2PR10MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 3023f451-43c0-4a4a-d770-08dcc12d236b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cuutRWunBOFFD1DP/bWj50AqK0/KjPc5nSxHHEGbCzq/kQB+ZMI4plYZCyzr?=
 =?us-ascii?Q?WU0uHLMw+OEbk123jhy9QGlSyYjrE7RJgf3AP3psSwbJjrLhW9VMXt5mnZuf?=
 =?us-ascii?Q?TDJHFhxEv2BGDhM+/Ux44yhLY5kgAAv5Qi168x3KTLOeerCMK5kpEHKpaJyz?=
 =?us-ascii?Q?vkJqbCShfTDy4ugcjZUviVYATPRu8Qal62+yazpfSE7gi/7+zoiZFKFCtFj/?=
 =?us-ascii?Q?qt9TgZsif1IC8VJVT9SHL6MruNzDNXnj3qcM+1S7sRQfBpaqSADQ9UoexB4Y?=
 =?us-ascii?Q?L4/5r60IiP1kd9gF086B8pxSwwoZ2BlFFb1UpYQY/mqy2EZk5zPGOBWGWjyv?=
 =?us-ascii?Q?6c5dirz2Ed4MP5vSTVIWENEDjXO3+Hlar4ZlhfkFB8Buh0WnAKfSPIHwRROo?=
 =?us-ascii?Q?8TCK1tkEOJWHCRwS5wsHDLi8UhuII3blt1iOogdZ9y06FMDDZEKumqVmlQui?=
 =?us-ascii?Q?PkgXHSaRei4hv6zcDxj2kUTsWEDAnUK9xmw1eEW0vk+JcrEhRSAP9RhylZhV?=
 =?us-ascii?Q?oDSFc+jbIwK5NAsEMh1S1BFDrT7Q9XRRuFKLPcQnk0j2knZR9+jLuMN5Lf1L?=
 =?us-ascii?Q?K0PyQdikMDPkv1qwN4A6nKP5xanXMZ/ZXkFO5q7ATTUnPXQ3RmGAYrOu4V5Q?=
 =?us-ascii?Q?dr9XRO3JLeUV44RfWyb2c80Ru2bcVglvstfFnL4dWel4vdADnOCR1uTNKkC6?=
 =?us-ascii?Q?AbFugoejFoDHID6MUn//aA/hiq6jt+uw/Lz8OCe32CCcKDSlJwRzwXPnKomh?=
 =?us-ascii?Q?5pYL2tmHgMGY3vBo90LPkhfg+bh0bKMlUTBQj8vi7q9k+0PnESHBmun0ZMuz?=
 =?us-ascii?Q?dI3mb3XsI741zt7f1rgb4sDWhJz+mK88oFukgX8Jd1ESZt5yxTGzR4D9WNhm?=
 =?us-ascii?Q?a+xXIaIY0MRQ0JVaRSdtS/0L95G34eRWvYyaNgRgIvQ2jm1vpJv3Ac48RZ7s?=
 =?us-ascii?Q?UDSAWfocVVEEHMKDAa+kqx5JxjSC1ChJBxaroRcTE9LaJJthWAxf9jX+s75t?=
 =?us-ascii?Q?IT+ORJ8Aoj2j4tJOUzwSKscsIKBBxzOZd2hGL+1bGaesCi7rWKzHwuGY8o7T?=
 =?us-ascii?Q?IR4wltTEGChDBS0UfrcH5ETSI4LpmcbVJVJw5DipPmFIvLQQH4M7sEvW2XJg?=
 =?us-ascii?Q?Me1hMfQOWVUX9uddDAbvvYb2vVNMHwgeTj4wGEYRFYzqeG0EQ1D7KmM1giCk?=
 =?us-ascii?Q?PoN8uVrgjqyKBw1/Td8r+OO1Vd3pw1DGI57vKVFifO4Z1ux6AhtTEDNcD12Z?=
 =?us-ascii?Q?bBw1HCk8qrUXZXR3NTV7g8OCtdZPpQf3c7KxEbpidpnhf2UkL+rTDuJsyjwR?=
 =?us-ascii?Q?sVuPYiNRjqftC22hrQrhoNHAs1BBMMwC9Xp0DULmWzencA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Pzi34LjTTjn9vAxnQ1TFOy7TjJZmHbozLZct4tPXDOEqtcun6yNVWSWeugb?=
 =?us-ascii?Q?UNJOeTVF5oY1WXh7zXcOS47qNyVbafKA7XwrQGpxXE/1WeTxIILyZiH2NL3w?=
 =?us-ascii?Q?CYk2gM/LEppX7bTB70/bBaWrudXpnCw9RiY5BFMyfYV31QPu1QV7TJ/PFrRY?=
 =?us-ascii?Q?/JETyAi+tZSTYMw4E49+sw4njY1XHvCoEUe8Bos5lD9ocBEU7LxM+ny8hmkj?=
 =?us-ascii?Q?fRjuftWDvtBQwFJlHvR7do4ZVAHZXF4A/7dLiSqDbDdb8S/8HtvYxVWOEJju?=
 =?us-ascii?Q?aNhLAy7/Ro06qshVQFy+E2oB4+eGruZzU5kTiz67vN/PdUyQKYpjQc4Bh5BQ?=
 =?us-ascii?Q?WJUyELoliwu0+C1W3KtdjAJQRbX7hxEisj/1f60WxVCUNx8ox0tjUaPTUrWe?=
 =?us-ascii?Q?SU9cGjJftDGOSW6og1yEI2nvb7jshAiF87icpcClzKI1VqgoRD2S13QImkKH?=
 =?us-ascii?Q?QGA3t488EsjFotqDgRWBAn0pzhoe/Z2fU4892Tv6lHP+r/noSeC/JuBCiiBV?=
 =?us-ascii?Q?9AZQJDhxg3ILEJudzO1GzRX5K2YeZMHyOZy5PiaKulwx1AzZVhTFt/qAE/zf?=
 =?us-ascii?Q?Vb5rsVWt13ubZrOPvOOvHJrY6r5vvgw2tOCh4mA2JiEIN1UbpzorE/VQ+vpW?=
 =?us-ascii?Q?toUAfI7Ulw9fzokV5Rxu/mg6udWqWHqdNwQL/XgTxgVjYpoYhltZarodFnqi?=
 =?us-ascii?Q?ZIlTpcdDaQLypI8lnUKSkEX4c59kfX1blOkdF5G+9zl37p89k+RcX4gI29uL?=
 =?us-ascii?Q?pwoqoHNMPBfvmbDa9fPJQpjVvXR+419z8svi0XkfglGpTtha6G/Gp9Snz3ro?=
 =?us-ascii?Q?N1haUizl3bW1XhjyIFtp10Xo2u9dq7lPi0V0aHCxOvwn5/+RdSermjT3Mtkc?=
 =?us-ascii?Q?acmxXl0UXWWn4oDILmLTwtWqUdE0xgv1ubwhTpyJzLjAlbN4915ROJpav7VT?=
 =?us-ascii?Q?3RAhWDJoeXxuwLrhA+SElUaJ4e3ePL9mBaM7nxh8/c6XEqR1d6xsP/HtkFMF?=
 =?us-ascii?Q?WJfzKCwxYMt5efSVnoAg9Wfw5fnrGCyVtTO1pR17zNNExonY9L3h8FVaasgB?=
 =?us-ascii?Q?HQcwugY1yTdaTVlKyDnJWm2pAANIqyRABCA3I2TkHOTiRY+C6/RTrwbMIERn?=
 =?us-ascii?Q?61dD0wSqPYH/cPKP1T3dAflyFo3IJzR5gcLkPwBSOzSntsJxwf2HR0SzmciF?=
 =?us-ascii?Q?tjTbY+D/rFTRYdlab8vgb/g/KFnRP98/JN45lme2sdjK3Ab+TgcruxnPyrw8?=
 =?us-ascii?Q?WIjhuuSmafqX7fO1dYNMK0eOXsmvtzcll7bvZFiZeGXR2Am/ZZFSZAeylecs?=
 =?us-ascii?Q?jv909Sjk0cCHHV3S4lSU3WpqpvCUfzjL2PKCfeaN3QcWToeHiPpoODUM3cH4?=
 =?us-ascii?Q?r64HeZ3vAYxAcfN0eTu5S8Tz0CCUUPppf+M6nQscFYs0pzT7I+vrIVHJ9eux?=
 =?us-ascii?Q?qXpjrcAiDAEGvDd8F0mTWmATfzwC7MvR4Oh6WodFtzI3EF56WmUzG3A5In65?=
 =?us-ascii?Q?j8KIrr42bJmUUgTJYCnTR9DceooKbm+9ZsNtS8WSXL6qyWHzCRFzFcaj+w0z?=
 =?us-ascii?Q?0rbvdnuHtX0vntdpu822kLirMKmYgv7hCiySeV5z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d1KlBeoaQ0T2qsYN9/otugvpPBaLXdaDmcehJ0xISwjLo2cJmp/wCShwAeVsV7k2tFF9ck4WmZCGeDwIX4S/dzkkkEt9WN8VhZB8LfwQYRQ263pcJfOtdRywOkluFduHeWZT6uaNKNWjMbYV2izVNl85RhzgL1bdEq/OYXqnM9OKLEx1BkCY+5TNTEMhvu1kkKoikwv4FM3egf/pHUc/I4MPBuS6g127f4Wcr/TbHK9rty64SwQMUTKefD3WctMAE43wPrNfsKs9M8wPT75QeQgBu+JP0m8awK1oM5a3MbSEmmMVleTTAPoZ6VYrz6ZQV/UP63MUsNuekAzZVnj+0v6Lm5flg+iZYMKu3H8L9cahLg1QZkzBQAdoproOKAbkBgd7W9+yJbWgC1dt5A9P0zsP2R/9FA6T1S2gQpw++bSdGKGNTMa0+VHM+CDJuLJ/hI2VRrLgWtqp431hHc2apBU6YVsY27zD92tmyZXpw0N8mXfOE7z2gtuqZMrHnlGllEqWINqA4Ao9lJQABE6JmNXCR+e1KK7WjIHeWPqSSYxim8RKXPKmuzdkhv1qFC11TdTqOS1jCZtCxujsQKlT1phQL6v/53CIpuvrbAm78Bc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3023f451-43c0-4a4a-d770-08dcc12d236b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 15:31:19.5057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JzgLHoRTJv4cmGJNzCnQ5rUAC90B7Iz5htgpexnLwQVAPw4Ln3dyVYT6emA0oUtNymG/aWLaE5OQuT7z3y9PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408200115
X-Proofpoint-ORIG-GUID: q3ADUE63tJtd1dtxsXjVdKK9b0nXbLpM
X-Proofpoint-GUID: q3ADUE63tJtd1dtxsXjVdKK9b0nXbLpM

* Suren Baghdasaryan <surenb@google.com> [240819 11:15]:
> When a module gets unloaded there is a possibility that some of the
> allocations it made are still used and therefore the allocation tags
> corresponding to these allocations are still referenced. As such, the
> memory for these tags can't be freed. This is currently handled as an
> abnormal situation and module's data section is not being unloaded.
> To handle this situation without keeping module's data in memory,
> allow codetags with longer lifespan than the module to be loaded into
> their own separate memory. The in-use memory areas and gaps after
> module unloading in this separate memory are tracked using maple trees.
> Allocation tags arrange their separate memory so that it is virtually
> contiguous and that will allow simple allocation tag indexing later on
> in this patchset. The size of this virtually contiguous memory is set
> to store up to 100000 allocation tags and max_module_alloc_tags kernel
> parameter is introduced to change this size.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |   4 +
>  include/asm-generic/codetag.lds.h             |  19 ++
>  include/linux/alloc_tag.h                     |  13 +-
>  include/linux/codetag.h                       |  35 ++-
>  kernel/module/main.c                          |  67 +++--
>  lib/alloc_tag.c                               | 245 ++++++++++++++++--
>  lib/codetag.c                                 | 101 +++++++-
>  scripts/module.lds.S                          |   5 +-
>  8 files changed, 429 insertions(+), 60 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index d0d141d50638..17f9f811a9c0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3205,6 +3205,10 @@
>  			devices can be requested on-demand with the
>  			/dev/loop-control interface.
>  
> +
> +	max_module_alloc_tags=	[KNL] Max supported number of allocation tags
> +			in modules.
> +
>  	mce		[X86-32] Machine Check Exception
>  
>  	mce=option	[X86-64] See Documentation/arch/x86/x86_64/boot-options.rst
> diff --git a/include/asm-generic/codetag.lds.h b/include/asm-generic/codetag.lds.h
> index 64f536b80380..372c320c5043 100644
> --- a/include/asm-generic/codetag.lds.h
> +++ b/include/asm-generic/codetag.lds.h
> @@ -11,4 +11,23 @@
>  #define CODETAG_SECTIONS()		\
>  	SECTION_WITH_BOUNDARIES(alloc_tags)
>  
> +/*
> + * Module codetags which aren't used after module unload, therefore have the
> + * same lifespan as the module and can be safely unloaded with the module.
> + */
> +#define MOD_CODETAG_SECTIONS()
> +
> +#define MOD_SEPARATE_CODETAG_SECTION(_name)	\
> +	.codetag.##_name : {			\
> +		SECTION_WITH_BOUNDARIES(_name)	\
> +	}
> +
> +/*
> + * For codetags which might be used after module unload, therefore might stay
> + * longer in memory. Each such codetag type has its own section so that we can
> + * unload them individually once unused.
> + */
> +#define MOD_SEPARATE_CODETAG_SECTIONS()		\
> +	MOD_SEPARATE_CODETAG_SECTION(alloc_tags)
> +
>  #endif /* __ASM_GENERIC_CODETAG_LDS_H */
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 8c61ccd161ba..99cbc7f086ad 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -30,6 +30,13 @@ struct alloc_tag {
>  	struct alloc_tag_counters __percpu	*counters;
>  } __aligned(8);
>  
> +struct alloc_tag_module_section {
> +	unsigned long start_addr;
> +	unsigned long end_addr;
> +	/* used size */
> +	unsigned long size;
> +};
> +
>  #ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
>  
>  #define CODETAG_EMPTY	((void *)1)
> @@ -54,6 +61,8 @@ static inline void set_codetag_empty(union codetag_ref *ref) {}
>  
>  #ifdef CONFIG_MEM_ALLOC_PROFILING
>  
> +#define ALLOC_TAG_SECTION_NAME	"alloc_tags"
> +
>  struct codetag_bytes {
>  	struct codetag *ct;
>  	s64 bytes;
> @@ -76,7 +85,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
>  
>  #define DEFINE_ALLOC_TAG(_alloc_tag)						\
>  	static struct alloc_tag _alloc_tag __used __aligned(8)			\
> -	__section("alloc_tags") = {						\
> +	__section(ALLOC_TAG_SECTION_NAME) = {					\
>  		.ct = CODE_TAG_INIT,						\
>  		.counters = &_shared_alloc_tag };
>  
> @@ -85,7 +94,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
>  #define DEFINE_ALLOC_TAG(_alloc_tag)						\
>  	static DEFINE_PER_CPU(struct alloc_tag_counters, _alloc_tag_cntr);	\
>  	static struct alloc_tag _alloc_tag __used __aligned(8)			\
> -	__section("alloc_tags") = {						\
> +	__section(ALLOC_TAG_SECTION_NAME) = {					\
>  		.ct = CODE_TAG_INIT,						\
>  		.counters = &_alloc_tag_cntr };
>  
> diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> index c2a579ccd455..c4a3dd60205e 100644
> --- a/include/linux/codetag.h
> +++ b/include/linux/codetag.h
> @@ -35,8 +35,13 @@ struct codetag_type_desc {
>  	size_t tag_size;
>  	void (*module_load)(struct codetag_type *cttype,
>  			    struct codetag_module *cmod);
> -	bool (*module_unload)(struct codetag_type *cttype,
> +	void (*module_unload)(struct codetag_type *cttype,
>  			      struct codetag_module *cmod);
> +	void (*module_replaced)(struct module *mod, struct module *new_mod);
> +	bool (*needs_section_mem)(struct module *mod, unsigned long size);
> +	void *(*alloc_section_mem)(struct module *mod, unsigned long size,
> +				   unsigned int prepend, unsigned long align);
> +	void (*free_section_mem)(struct module *mod, bool unused);
>  };
>  
>  struct codetag_iterator {
> @@ -71,11 +76,31 @@ struct codetag_type *
>  codetag_register_type(const struct codetag_type_desc *desc);
>  
>  #if defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES)
> +
> +bool codetag_needs_module_section(struct module *mod, const char *name,
> +				  unsigned long size);
> +void *codetag_alloc_module_section(struct module *mod, const char *name,
> +				   unsigned long size, unsigned int prepend,
> +				   unsigned long align);
> +void codetag_free_module_sections(struct module *mod);
> +void codetag_module_replaced(struct module *mod, struct module *new_mod);
>  void codetag_load_module(struct module *mod);
> -bool codetag_unload_module(struct module *mod);
> -#else
> +void codetag_unload_module(struct module *mod);
> +
> +#else /* defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES) */
> +
> +static inline bool
> +codetag_needs_module_section(struct module *mod, const char *name,
> +			     unsigned long size) { return false; }
> +static inline void *
> +codetag_alloc_module_section(struct module *mod, const char *name,
> +			     unsigned long size, unsigned int prepend,
> +			     unsigned long align) { return NULL; }
> +static inline void codetag_free_module_sections(struct module *mod) {}
> +static inline void codetag_module_replaced(struct module *mod, struct module *new_mod) {}
>  static inline void codetag_load_module(struct module *mod) {}
> -static inline bool codetag_unload_module(struct module *mod) { return true; }
> -#endif
> +static inline void codetag_unload_module(struct module *mod) {}
> +
> +#endif /* defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES) */
>  
>  #endif /* _LINUX_CODETAG_H */
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 71396e297499..d195d788835c 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1225,18 +1225,12 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
>  	return 0;
>  }
>  
> -static void module_memory_free(struct module *mod, enum mod_mem_type type,
> -			       bool unload_codetags)
> +static void module_memory_free(struct module *mod, enum mod_mem_type type)
>  {
> -	void *ptr = mod->mem[type].base;
> -
> -	if (!unload_codetags && mod_mem_type_is_core_data(type))
> -		return;
> -
> -	execmem_free(ptr);
> +	execmem_free(mod->mem[type].base);
>  }
>  
> -static void free_mod_mem(struct module *mod, bool unload_codetags)
> +static void free_mod_mem(struct module *mod)
>  {
>  	for_each_mod_mem_type(type) {
>  		struct module_memory *mod_mem = &mod->mem[type];
> @@ -1247,25 +1241,20 @@ static void free_mod_mem(struct module *mod, bool unload_codetags)
>  		/* Free lock-classes; relies on the preceding sync_rcu(). */
>  		lockdep_free_key_range(mod_mem->base, mod_mem->size);
>  		if (mod_mem->size)
> -			module_memory_free(mod, type, unload_codetags);
> +			module_memory_free(mod, type);
>  	}
>  
>  	/* MOD_DATA hosts mod, so free it at last */
>  	lockdep_free_key_range(mod->mem[MOD_DATA].base, mod->mem[MOD_DATA].size);
> -	module_memory_free(mod, MOD_DATA, unload_codetags);
> +	module_memory_free(mod, MOD_DATA);
>  }
>  
>  /* Free a module, remove from lists, etc. */
>  static void free_module(struct module *mod)
>  {
> -	bool unload_codetags;
> -
>  	trace_module_free(mod);
>  
> -	unload_codetags = codetag_unload_module(mod);
> -	if (!unload_codetags)
> -		pr_warn("%s: memory allocation(s) from the module still alive, cannot unload cleanly\n",
> -			mod->name);
> +	codetag_unload_module(mod);
>  
>  	mod_sysfs_teardown(mod);
>  
> @@ -1308,7 +1297,7 @@ static void free_module(struct module *mod)
>  	kfree(mod->args);
>  	percpu_modfree(mod);
>  
> -	free_mod_mem(mod, unload_codetags);
> +	free_mod_mem(mod);
>  }
>  
>  void *__symbol_get(const char *symbol)
> @@ -1573,6 +1562,14 @@ static void __layout_sections(struct module *mod, struct load_info *info, bool i
>  			if (WARN_ON_ONCE(type == MOD_INVALID))
>  				continue;
>  
> +			/*
> +			 * Do not allocate codetag memory as we load it into
> +			 * preallocated contiguous memory. s->sh_entsize will
> +			 * not be used for this section, so leave it as is.
> +			 */
> +			if (codetag_needs_module_section(mod, sname, s->sh_size))
> +				continue;
> +
>  			s->sh_entsize = module_get_offset_and_type(mod, type, s, i);
>  			pr_debug("\t%s\n", sname);
>  		}
> @@ -2247,6 +2244,7 @@ static int move_module(struct module *mod, struct load_info *info)
>  	int i;
>  	enum mod_mem_type t = 0;
>  	int ret = -ENOMEM;
> +	bool codetag_section_found = false;
>  
>  	for_each_mod_mem_type(type) {
>  		if (!mod->mem[type].size) {
> @@ -2257,7 +2255,7 @@ static int move_module(struct module *mod, struct load_info *info)
>  		ret = module_memory_alloc(mod, type);
>  		if (ret) {
>  			t = type;
> -			goto out_enomem;
> +			goto out_err;
>  		}
>  	}
>  
> @@ -2267,11 +2265,27 @@ static int move_module(struct module *mod, struct load_info *info)
>  		void *dest;
>  		Elf_Shdr *shdr = &info->sechdrs[i];
>  		enum mod_mem_type type = shdr->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
> +		const char *sname;
>  
>  		if (!(shdr->sh_flags & SHF_ALLOC))
>  			continue;
>  
> -		dest = mod->mem[type].base + (shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK);
> +		sname = info->secstrings + shdr->sh_name;
> +		/*
> +		 * Load codetag sections separately as they might still be used
> +		 * after module unload.
> +		 */
> +		if (codetag_needs_module_section(mod, sname, shdr->sh_size)) {
> +			dest = codetag_alloc_module_section(mod, sname, shdr->sh_size,
> +					arch_mod_section_prepend(mod, i), shdr->sh_addralign);
> +			if (IS_ERR(dest)) {
> +				ret = PTR_ERR(dest);
> +				goto out_err;
> +			}
> +			codetag_section_found = true;
> +		} else {
> +			dest = mod->mem[type].base + (shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK);
> +		}
>  
>  		if (shdr->sh_type != SHT_NOBITS) {
>  			/*
> @@ -2283,7 +2297,7 @@ static int move_module(struct module *mod, struct load_info *info)
>  			if (i == info->index.mod &&
>  			   (WARN_ON_ONCE(shdr->sh_size != sizeof(struct module)))) {
>  				ret = -ENOEXEC;
> -				goto out_enomem;
> +				goto out_err;
>  			}
>  			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
>  		}
> @@ -2299,9 +2313,12 @@ static int move_module(struct module *mod, struct load_info *info)
>  	}
>  
>  	return 0;
> -out_enomem:
> +out_err:
>  	for (t--; t >= 0; t--)
> -		module_memory_free(mod, t, true);
> +		module_memory_free(mod, t);
> +	if (codetag_section_found)
> +		codetag_free_module_sections(mod);
> +
>  	return ret;
>  }
>  
> @@ -2422,6 +2439,8 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>  	/* Module has been copied to its final place now: return it. */
>  	mod = (void *)info->sechdrs[info->index.mod].sh_addr;
>  	kmemleak_load_module(mod, info);
> +	codetag_module_replaced(info->mod, mod);
> +
>  	return mod;
>  }
>  
> @@ -2431,7 +2450,7 @@ static void module_deallocate(struct module *mod, struct load_info *info)
>  	percpu_modfree(mod);
>  	module_arch_freeing_init(mod);
>  
> -	free_mod_mem(mod, true);
> +	free_mod_mem(mod);
>  }
>  
>  int __weak module_finalize(const Elf_Ehdr *hdr,
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 81e5f9a70f22..f33784f48dd2 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include <linux/alloc_tag.h>
> +#include <linux/execmem.h>
>  #include <linux/fs.h>
>  #include <linux/gfp.h>
>  #include <linux/module.h>
> @@ -9,6 +10,12 @@
>  #include <linux/seq_file.h>
>  
>  static struct codetag_type *alloc_tag_cttype;
> +static struct alloc_tag_module_section module_tags;
> +static struct maple_tree mod_area_mt = MTREE_INIT(mod_area_mt, MT_FLAGS_ALLOC_RANGE);
> +/* A dummy object used to indicate an unloaded module */
> +static struct module unloaded_mod;
> +/* A dummy object used to indicate a module prepended area */
> +static struct module prepend_mod;
>  
>  DEFINE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
>  EXPORT_SYMBOL(_shared_alloc_tag);
> @@ -149,29 +156,198 @@ static void __init procfs_init(void)
>  	proc_create_seq("allocinfo", 0400, NULL, &allocinfo_seq_op);
>  }
>  
> -static bool alloc_tag_module_unload(struct codetag_type *cttype,
> -				    struct codetag_module *cmod)
> +static bool needs_section_mem(struct module *mod, unsigned long size)
>  {
> -	struct codetag_iterator iter = codetag_get_ct_iter(cttype);
> -	struct alloc_tag_counters counter;
> -	bool module_unused = true;
> -	struct alloc_tag *tag;
> -	struct codetag *ct;
> +	return size >= sizeof(struct alloc_tag);
> +}
> +
> +/* Called under RCU read lock */
> +static void clean_unused_module_areas(void)
> +{
> +	MA_STATE(mas, &mod_area_mt, 0, module_tags.size);
> +	struct module *val;
> +
> +	mas_for_each(&mas, val, module_tags.size) {
> +		if (val == &unloaded_mod) {
> +			struct alloc_tag *tag;
> +			struct alloc_tag *last;
> +			bool unused = true;
> +
> +			tag = (struct alloc_tag *)(module_tags.start_addr + mas.index);
> +			last = (struct alloc_tag *)(module_tags.start_addr + mas.last);
> +			while (tag <= last) {
> +				struct alloc_tag_counters counter;
> +
> +				counter = alloc_tag_read(tag);
> +				if (counter.bytes) {
> +					unused = false;
> +					break;
> +				}
> +				tag++;
> +			}
> +			if (unused) {
> +				mtree_store_range(&mod_area_mt, mas.index,
> +						  mas.last, NULL, GFP_KERNEL);

There is an mtree_erase() or mas_erase() function as well, no problem
doing it this way.

> +			}
> +		}
> +	}
> +}
> +
> +static void *reserve_module_tags(struct module *mod, unsigned long size,
> +				 unsigned int prepend, unsigned long align)
> +{
> +	unsigned long section_size = module_tags.end_addr - module_tags.start_addr;
> +	MA_STATE(mas, &mod_area_mt, 0, section_size - 1);
> +	bool cleanup_done = false;
> +	unsigned long offset;
> +	void *ret;
> +
> +	/* If no tags return NULL */
> +	if (size < sizeof(struct alloc_tag))
> +		return NULL;
> +
> +	/*
> +	 * align is always power of 2, so we can use IS_ALIGNED and ALIGN.
> +	 * align 0 or 1 means no alignment, to simplify set to 1.
> +	 */
> +	if (!align)
> +		align = 1;
> +
> +	rcu_read_lock();
> +repeat:
> +	/* Try finding exact size and hope the start is aligned */
> +	if (mas_empty_area(&mas, 0, section_size - 1, prepend + size))
> +		goto cleanup;
> +
> +	if (IS_ALIGNED(mas.index + prepend, align))
> +		goto found;
> +
> +	/* Try finding larger area to align later */
> +	mas_reset(&mas);
> +	if (!mas_empty_area(&mas, 0, section_size - 1,
> +			    size + prepend + align - 1))
> +		goto found;
> +
> +cleanup:
> +	/* No free area, try cleanup stale data and repeat the search once */
> +	if (!cleanup_done) {
> +		clean_unused_module_areas();
> +		cleanup_done = true;
> +		mas_reset(&mas);
> +		goto repeat;
> +	} else {
> +		ret = ERR_PTR(-ENOMEM);
> +		goto out;
> +	}
> +
> +found:
> +	offset = mas.index;
> +	offset += prepend;
> +	offset = ALIGN(offset, align);
> +
> +	if (mtree_insert_range(&mod_area_mt, offset, offset + size - 1, mod,
> +			       GFP_KERNEL)) {
> +		ret = ERR_PTR(-ENOMEM);
> +		goto out;
> +	}
> +
> +	if (offset != mas.index) {
> +		if (mtree_insert_range(&mod_area_mt, mas.index, offset - 1,
> +				       &prepend_mod, GFP_KERNEL)) {
> +			mtree_store_range(&mod_area_mt, offset, offset + size - 1,
> +					  NULL, GFP_KERNEL);

Aren't you negating the security of knowing you haven't raced to store
in the same location as another reader if you use mtree_store_range()
on the failure of mtree_insert_range()?

> +			ret = ERR_PTR(-ENOMEM);
> +			goto out;
> +		}
> +	}

mtree_insert and mtree_store do the locking for you, but will re-walk
the tree to the location for the store.  If you use the advanced mas_
operations, you can store without a re-walk but need to take the
spinlock and check mas_is_err(&mas) yourself.

mas.last =  offset - 1;
mas_lock(&mas)
mas_insert(&mas, prepend_mod)
mas_unlock(&mas);
if (mas_is_err(&mas))
	ret = xa_err(mas->node);

What you have works though.


> +
> +	if (module_tags.size < offset + size)
> +		module_tags.size = offset + size;
> +
> +	ret = (struct alloc_tag *)(module_tags.start_addr + offset);
> +out:
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
> +static void release_module_tags(struct module *mod, bool unused)
> +{
> +	MA_STATE(mas, &mod_area_mt, 0, module_tags.size);
> +	unsigned long padding_start;
> +	bool padding_found = false;
> +	struct module *val;
> +
> +	if (unused)
> +		return;
> +
> +	unused = true;
> +	rcu_read_lock();
> +	mas_for_each(&mas, val, module_tags.size) {
> +		struct alloc_tag *tag;
> +		struct alloc_tag *last;
> +
> +		if (val == &prepend_mod) {
> +			padding_start = mas.index;
> +			padding_found = true;
> +			continue;
> +		}
>  
> -	for (ct = codetag_next_ct(&iter); ct; ct = codetag_next_ct(&iter)) {
> -		if (iter.cmod != cmod)
> +		if (val != mod) {
> +			padding_found = false;
>  			continue;
> +		}
> +
> +		tag = (struct alloc_tag *)(module_tags.start_addr + mas.index);
> +		last = (struct alloc_tag *)(module_tags.start_addr + mas.last);
> +		while (tag <= last) {
> +			struct alloc_tag_counters counter;
> +
> +			counter = alloc_tag_read(tag);
> +			if (counter.bytes) {
> +				struct codetag *ct = &tag->ct;
>  
> -		tag = ct_to_alloc_tag(ct);
> -		counter = alloc_tag_read(tag);
> +				pr_info("%s:%u module %s func:%s has %llu allocated at module unload\n",
> +					ct->filename, ct->lineno, ct->modname,
> +					ct->function, counter.bytes);
> +				unused = false;
> +				break;
> +			}
> +			tag++;
> +		}
> +		if (unused) {
> +			mtree_store_range(&mod_area_mt,
> +					  padding_found ? padding_start : mas.index,
> +					  mas.last, NULL, GFP_KERNEL);
> +		} else {
> +			/* Release the padding and mark the module unloaded */
> +			if (padding_found)
> +				mtree_store_range(&mod_area_mt, padding_start,
> +						  mas.index - 1, NULL, GFP_KERNEL);
> +			mtree_store_range(&mod_area_mt, mas.index, mas.last,
> +					  &unloaded_mod, GFP_KERNEL);
> +		}
>  
> -		if (WARN(counter.bytes,
> -			 "%s:%u module %s func:%s has %llu allocated at module unload",
> -			 ct->filename, ct->lineno, ct->modname, ct->function, counter.bytes))
> -			module_unused = false;
> +		break;
>  	}
> +	rcu_read_unlock();

You may want to use a reverse iterator here, I don't think we have had a
use for one yet..

#define mas_for_each_rev(__mas, __entry, __min) \                                                                           
        while (((__entry) = mas_find_rev((__mas), (__min))) != NULL)

===================================

MA_STATE(mas, &mod_area_mt, module_tags.size, module_tags.size);

...

rcu_read_lock();
mas_for_each_rev(&mas, val, 0)
	if (val == mod)
		break;

if (!val) /* no module found */
	goto out;

..unused check loop here..

mas_lock(&mas) /* spinlock */
mas_store(&mas, unused ? NULL : &unloaded_mod);
val = mas_prev_range(&mas, 0);
if (val == &prepend_mod)
	mas_store(&mas, NULL);
mas_unlock(&mas);

out:
rcu_read_unlock();


> +}
> +
> +static void replace_module(struct module *mod, struct module *new_mod)
> +{
> +	MA_STATE(mas, &mod_area_mt, 0, module_tags.size);
> +	struct module *val;
>  
> -	return module_unused;
> +	rcu_read_lock();
> +	mas_for_each(&mas, val, module_tags.size) {
> +		if (val != mod)
> +			continue;
> +
> +		mtree_store_range(&mod_area_mt, mas.index, mas.last,
> +				  new_mod, GFP_KERNEL);
> +		break;
> +	}
> +	rcu_read_unlock();
>  }
>  
>  #ifdef CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
> @@ -252,17 +428,46 @@ static void __init sysctl_init(void)
>  static inline void sysctl_init(void) {}
>  #endif /* CONFIG_SYSCTL */
>  
> +static unsigned long max_module_alloc_tags __initdata = 100000;
> +
> +static int __init set_max_module_alloc_tags(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	return kstrtoul(arg, 0, &max_module_alloc_tags);
> +}
> +early_param("max_module_alloc_tags", set_max_module_alloc_tags);
> +
>  static int __init alloc_tag_init(void)
>  {
>  	const struct codetag_type_desc desc = {
> -		.section	= "alloc_tags",
> -		.tag_size	= sizeof(struct alloc_tag),
> -		.module_unload	= alloc_tag_module_unload,
> +		.section		= ALLOC_TAG_SECTION_NAME,
> +		.tag_size		= sizeof(struct alloc_tag),
> +		.needs_section_mem	= needs_section_mem,
> +		.alloc_section_mem	= reserve_module_tags,
> +		.free_section_mem	= release_module_tags,
> +		.module_replaced	= replace_module,
>  	};
> +	unsigned long module_tags_mem_sz;
>  
> +	module_tags_mem_sz = max_module_alloc_tags * sizeof(struct alloc_tag);
> +	pr_info("%lu bytes reserved for module allocation tags\n", module_tags_mem_sz);
> +
> +	/* Allocate space to copy allocation tags */
> +	module_tags.start_addr = (unsigned long)execmem_alloc(EXECMEM_MODULE_DATA,
> +							      module_tags_mem_sz);
> +	if (!module_tags.start_addr)
> +		return -ENOMEM;
> +
> +	module_tags.end_addr = module_tags.start_addr + module_tags_mem_sz;
> +	mt_set_in_rcu(&mod_area_mt);

If you are not toggling rcu-safe, then you can use the init of the tree
to set rcu on by setting MT_FLAGS_USE_RCU.

>  	alloc_tag_cttype = codetag_register_type(&desc);
> -	if (IS_ERR(alloc_tag_cttype))
> +	if (IS_ERR(alloc_tag_cttype)) {
> +		execmem_free((void *)module_tags.start_addr);
> +		module_tags.start_addr = 0;
>  		return PTR_ERR(alloc_tag_cttype);
> +	}
>  
>  	sysctl_init();
>  	procfs_init();
> diff --git a/lib/codetag.c b/lib/codetag.c
> index 5ace625f2328..d602a81bdc03 100644
> --- a/lib/codetag.c
> +++ b/lib/codetag.c
> @@ -126,6 +126,7 @@ static inline size_t range_size(const struct codetag_type *cttype,
>  }
>  
>  #ifdef CONFIG_MODULES
> +
>  static void *get_symbol(struct module *mod, const char *prefix, const char *name)
>  {
>  	DECLARE_SEQ_BUF(sb, KSYM_NAME_LEN);
> @@ -155,6 +156,94 @@ static struct codetag_range get_section_range(struct module *mod,
>  	};
>  }
>  
> +#define CODETAG_SECTION_PREFIX	".codetag."
> +
> +/* Some codetag types need a separate module section */
> +bool codetag_needs_module_section(struct module *mod, const char *name,
> +				  unsigned long size)
> +{
> +	const char *type_name;
> +	struct codetag_type *cttype;
> +	bool ret = false;
> +
> +	if (strncmp(name, CODETAG_SECTION_PREFIX, strlen(CODETAG_SECTION_PREFIX)))
> +		return false;
> +
> +	type_name = name + strlen(CODETAG_SECTION_PREFIX);
> +	mutex_lock(&codetag_lock);
> +	list_for_each_entry(cttype, &codetag_types, link) {
> +		if (strcmp(type_name, cttype->desc.section) == 0) {
> +			if (!cttype->desc.needs_section_mem)
> +				break;
> +
> +			down_write(&cttype->mod_lock);
> +			ret = cttype->desc.needs_section_mem(mod, size);
> +			up_write(&cttype->mod_lock);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&codetag_lock);
> +
> +	return ret;
> +}
> +
> +void *codetag_alloc_module_section(struct module *mod, const char *name,
> +				   unsigned long size, unsigned int prepend,
> +				   unsigned long align)
> +{
> +	const char *type_name = name + strlen(CODETAG_SECTION_PREFIX);
> +	struct codetag_type *cttype;
> +	void *ret = NULL;
> +
> +	mutex_lock(&codetag_lock);
> +	list_for_each_entry(cttype, &codetag_types, link) {
> +		if (strcmp(type_name, cttype->desc.section) == 0) {
> +			if (WARN_ON(!cttype->desc.alloc_section_mem))
> +				break;
> +
> +			down_write(&cttype->mod_lock);
> +			ret = cttype->desc.alloc_section_mem(mod, size, prepend, align);
> +			up_write(&cttype->mod_lock);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&codetag_lock);
> +
> +	return ret;
> +}
> +
> +void codetag_free_module_sections(struct module *mod)
> +{
> +	struct codetag_type *cttype;
> +
> +	mutex_lock(&codetag_lock);
> +	list_for_each_entry(cttype, &codetag_types, link) {
> +		if (!cttype->desc.free_section_mem)
> +			continue;
> +
> +		down_write(&cttype->mod_lock);
> +		cttype->desc.free_section_mem(mod, true);
> +		up_write(&cttype->mod_lock);
> +	}
> +	mutex_unlock(&codetag_lock);
> +}
> +
> +void codetag_module_replaced(struct module *mod, struct module *new_mod)
> +{
> +	struct codetag_type *cttype;
> +
> +	mutex_lock(&codetag_lock);
> +	list_for_each_entry(cttype, &codetag_types, link) {
> +		if (!cttype->desc.module_replaced)
> +			continue;
> +
> +		down_write(&cttype->mod_lock);
> +		cttype->desc.module_replaced(mod, new_mod);
> +		up_write(&cttype->mod_lock);
> +	}
> +	mutex_unlock(&codetag_lock);
> +}
> +
>  static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
>  {
>  	struct codetag_range range;
> @@ -212,13 +301,12 @@ void codetag_load_module(struct module *mod)
>  	mutex_unlock(&codetag_lock);
>  }
>  
> -bool codetag_unload_module(struct module *mod)
> +void codetag_unload_module(struct module *mod)
>  {
>  	struct codetag_type *cttype;
> -	bool unload_ok = true;
>  
>  	if (!mod)
> -		return true;
> +		return;
>  
>  	mutex_lock(&codetag_lock);
>  	list_for_each_entry(cttype, &codetag_types, link) {
> @@ -235,18 +323,17 @@ bool codetag_unload_module(struct module *mod)
>  		}
>  		if (found) {
>  			if (cttype->desc.module_unload)
> -				if (!cttype->desc.module_unload(cttype, cmod))
> -					unload_ok = false;
> +				cttype->desc.module_unload(cttype, cmod);
>  
>  			cttype->count -= range_size(cttype, &cmod->range);
>  			idr_remove(&cttype->mod_idr, mod_id);
>  			kfree(cmod);
>  		}
>  		up_write(&cttype->mod_lock);
> +		if (found && cttype->desc.free_section_mem)
> +			cttype->desc.free_section_mem(mod, false);
>  	}
>  	mutex_unlock(&codetag_lock);
> -
> -	return unload_ok;
>  }
>  
>  #else /* CONFIG_MODULES */
> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index 3f43edef813c..711c6e029936 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -50,7 +50,7 @@ SECTIONS {
>  	.data : {
>  		*(.data .data.[0-9a-zA-Z_]*)
>  		*(.data..L*)
> -		CODETAG_SECTIONS()
> +		MOD_CODETAG_SECTIONS()
>  	}
>  
>  	.rodata : {
> @@ -59,9 +59,10 @@ SECTIONS {
>  	}
>  #else
>  	.data : {
> -		CODETAG_SECTIONS()
> +		MOD_CODETAG_SECTIONS()
>  	}
>  #endif
> +	MOD_SEPARATE_CODETAG_SECTIONS()
>  }
>  
>  /* bring in arch-specific sections */
> -- 
> 2.46.0.184.g6999bdac58-goog
> 

