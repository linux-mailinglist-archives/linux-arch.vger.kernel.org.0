Return-Path: <linux-arch+bounces-7103-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3BD96F078
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 11:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9F21C23D6D
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF06C1C8FD5;
	Fri,  6 Sep 2024 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b0D4qWIP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k7RBur8N"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36881C8FAE;
	Fri,  6 Sep 2024 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616486; cv=fail; b=Ou4UWWjWrCbUfm+7L3LxrOnyXewzkJ3obIo7Zn5SKnRf6bpkeeEgN9lSbcqSj+LkA8qFuOPtMGVADSN4zyT4z6SzYLje5Cy/RKJsw6C0CP/7k56N7nUWNMOg2HzhqlwGGQc6k8zER9rRMio3lE2YqQNYX4Y3kM6ibUVl4l7vfUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616486; c=relaxed/simple;
	bh=FiQ9Jd2tb1n/i5c0vr1ZFx4liLPLzujW5w48CXg3VFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ssghauK37XGcC5MobwS7m8xqoal3qePrp0pJxbqtSO58QVChR25Hk0a58BSBcEn4AuWZ/I6LTfErvxNOGd7vvO2BmQ4MGCfD2u48+bjOijC1BM0ThEmbSP+fws5kGjVTeSaGg3eoU6WjWzojrRZlL34fGJdSyS/Cgyeq6kmYmm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b0D4qWIP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k7RBur8N; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4863gvWr020435;
	Fri, 6 Sep 2024 09:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=8asnURoOe5mWCvP
	rD/TD9zKWj9BUDIvl219Wb72wVXA=; b=b0D4qWIPjjBmXwmXg3JCVs1PRd9FGBn
	6OiWa29KT2hwC/GgS/BOnoHAvEJ+WV0zsITFZXpgt6cnQn0zhIJOzsSPOLjRkq/7
	OanckemqoDgw7XxSsE9GCaG7MovEOHMrojffjkb2OQSC8JkP+DJ4r+H+Ts2t2Hsp
	r0DniKJDyxM1iV5fxmetg07B1UA67sDsdYWPXxWWV3PuLo4DRPlM0WIzop/OEXhH
	jXKCH3HbQAi5JUitc047zph3Z9uVy9sSce9yexQpaWSTAfobNTkKLD5ugLDnep+s
	KX92zprHZj61JUHhEFuq9jEitGDmh9ZttjpADB7HNWjEDqA6QUITlzA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41fhwns8gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 09:53:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4868kBA9003330;
	Fri, 6 Sep 2024 09:53:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41fhyb1xwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 09:53:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHP0WBEnpnmOJhKrgs161MHCcuyF2/YYNPBSXUnhIPwedlLwtW5NGtGlPSxy4GaU/WnvOt9IS4BsSnwVVXgXFov0nhG5F51wTXz+OlV88SdgB0TYfVGm/3S5GiOwkg86SJG+QjROlJ7vhbF3rfnQU1CMCtIOB8ZSvIdyXDj84obbVm6l+w/kPU3CmsJhXbZ8nMPgwDNhNjbJnKFxOUteDdlXC1PJLydXY8gORJuhdKlaR17RsGXHMRE9WpstnHU29P823j+2mSsxq2gPmpX3lHCvucbiDS6q8UCf8stThY7CqjG5J5Gu2T6gcROODkwEhhCN7tVX/gAEyuEsQv2FEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8asnURoOe5mWCvPrD/TD9zKWj9BUDIvl219Wb72wVXA=;
 b=klTl13TNdafgNojkj57CDYQtwisylCAOJyEQa7F2l/Dc7QSHCAohvHi/gSp/gqzFdtDKthW0Q52GwVcmmcjI12/+VAAfH66WWnYn83tQqAwJsL1W/yg3PpCaXIVgnPnGTrSTyGDXx9apVIUEQK7ISWwl6B/DrLMULmPc3Q/XnaItEaBMHzjFmZhhgvdUvrBFDGTssozfQJfn8arrLsGOg61n6otT0bUHvq9ltgw/+a9g8xRcF2j5PeKzskxc3005G9jFgTr7VnGP5Gf5dPx53qaVxyegWtH9GOon3YD8EI6M6Z8KW22i8y0bwOZRNOyBY+milcjOjgpfXYwe0iSU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8asnURoOe5mWCvPrD/TD9zKWj9BUDIvl219Wb72wVXA=;
 b=k7RBur8NR9Ww0kX/FZaJUPS3za3Y68/i1mw5LqOZXr4gW/CZmll0XUWVMT47DlGV6E7ZvIEi/kfMkNE61NnyaO71qJRfyPUnCtd82SPPYMigqU/srv7x848LyLB3q5vVSJBOuT59Wd8gWR2/bFd7j6H5zRa1baeOVadRUiioE4k=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB4517.namprd10.prod.outlook.com (2603:10b6:510:36::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Fri, 6 Sep
 2024 09:52:46 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7939.016; Fri, 6 Sep 2024
 09:52:45 +0000
Date: Fri, 6 Sep 2024 10:52:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Charlie Jenkins <charlie@rivosinc.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>, guoren <guoren@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, shuah <shuah@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Chris Torek <chris.torek@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-abi-devel@lists.sourceforge.net
Subject: Re: [PATCH RFC v3 1/2] mm: Add personality flag to limit address to
 47 bits
Message-ID: <016c7857-9ea8-4333-96e6-3ae3870f375f@lucifer.local>
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
 <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
 <9fc4746b-8e9d-4a75-b966-e0906187e6b7@app.fastmail.com>
 <58f39d58-579e-4dd3-8084-baebf86f1ae0@lucifer.local>
 <7be08ea9-f343-42da-805f-e5f0d61bde26@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7be08ea9-f343-42da-805f-e5f0d61bde26@app.fastmail.com>
X-ClientProxiedBy: LO4P265CA0041.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: 82321389-cec8-40ee-0c25-08dcce59a895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bei3MAGeSMRSyc5RvP9J7vdmXL/czzsnT6OmpQTZlVgAkdE9AV7UXqg/d0yQ?=
 =?us-ascii?Q?IPampe43D60Xtt2ucdRluu3GVq/Y6cEkisLQosslVD5ikXimAT0g0smGHwLp?=
 =?us-ascii?Q?jx5dxkMgM1geJnPjy6FWiSE3qW+ObI6HV9dwcZL/0B9YmAMqAwaQbGiO3dRM?=
 =?us-ascii?Q?JlpEi7nvAE5QGA7+7AE8byMJqY0wT7//wS/cDd11G+oaMaNS7wOW0W1Yl7ia?=
 =?us-ascii?Q?6lcgqyKZJAAfHSuwbK3QxljUv14FnqPWUYgmElDVlKRUoyJ5ieJ2Fffm1ajG?=
 =?us-ascii?Q?xxRbhqWkRyvs2SwHXX0TtuWpkpMpt4l7oex1ln4Z6Ke0c9u7se42Wrv1s1JH?=
 =?us-ascii?Q?dKagwmQCKddHOLH02tE7cE2jrGDH9Fx5Vx+B5ufGSzEdK68KeGuGXeRAXXJ+?=
 =?us-ascii?Q?Y9At9S7g65XYhs1rOl+Bc3e2Mf4lUp04+4tKUYUFMdhHwSyQCmpbMzQcv+S8?=
 =?us-ascii?Q?IRQfJ4W+nVinUIHL3sSIN5kZvNXwCTBIQqYawf+/CYpAF9EZ8oGsBbEdk131?=
 =?us-ascii?Q?9KulFOYXCiQ4oN4yoAQO61iKeXwG9qs6EdJbdj7WatAa9yyuMdS4tHiEsrAD?=
 =?us-ascii?Q?WyHEZ8C2rNTdLJG0sfLQc2QMLGc/a1ZJIvMfj+I0W3oTAzav7JYdZxFgoTW9?=
 =?us-ascii?Q?MVxmJVAU8GDH+8P0GdHpw/gFQAHLGP6nOh4l3XK6q9x58YeZhMfEEVitOjPu?=
 =?us-ascii?Q?OfF7nmco7bBXhSVH9VEm7/fj07wMPITSo+8XBSaZF61ZZyUUGIOe9IaNqHXv?=
 =?us-ascii?Q?NBL8UQ6CqpMN+aOSK/1hAv4GU+ojSR/m285wDbfEeLxk5txsc9L0Btf9siGn?=
 =?us-ascii?Q?HAy2OxRyz/kXRRLz/OPGmULk8sXj3x05K+oJ7EkHIV2yS04jJqIWNudeOPey?=
 =?us-ascii?Q?+Q9ujkDErf99j8duqRasg8hMHquJyT0yAqyFZ7vxXbYSHkltuDlF/RrPHjdC?=
 =?us-ascii?Q?Si3XK8aqm1+oyzaYF5o97jVXG4lM+q3rbNfqAkTD7srCQwnkZq5q9x9sckqt?=
 =?us-ascii?Q?G23Oi4zOIOEF7P1RPb/4ZoarOGN5H7KBT83wZuvO4j8L4lT5YM9njOtiYoGu?=
 =?us-ascii?Q?FVxCNKZNNnT4gVuGNwpruCcu6r178Tqx+TS1M/M1dPNX19Z7/qnkWxXb8Rkl?=
 =?us-ascii?Q?Ia9sGQTXynO50mlq25eV0BEifL17+IHHKgUIF1+QHwzvYvBSCuzCbYuMQyuG?=
 =?us-ascii?Q?WkA0wtIDcczhzo3e2MiaRsTBz3bviAjSI0pODMVr/QGVhyVJjlGYE1xtN9Xl?=
 =?us-ascii?Q?VkbiqA7Ae4E+diFQPNbv7WM83p5T1BFTRPos/smvbJ1CQHn/wN5zxqSAn4oS?=
 =?us-ascii?Q?af71nzqRWL83bRWj/ygTaodpb0aAIMbIyKkbnopQegCqEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8EYi4x36jkEgEoUSF8qDA8Nxpg0PegCAfwlWFFAxbkIF5pYGqhD1g6W2nQUD?=
 =?us-ascii?Q?ZsEc9MNkxrpU3C3MBETIfs0iqaaVr31nAwBLIn+BbVi3+LQbm9Xxk6w9YA+C?=
 =?us-ascii?Q?13SoML9bZQ0PkHMbfKMl/RRAik2vG8pfCCySe9tCCfEzS5ZsQLNubcRWSX6u?=
 =?us-ascii?Q?9iNS0bpQjn7C1o2wzNdh77A3x2You+48NHIGHz0ycnH37nMw/eP4GoS0c4px?=
 =?us-ascii?Q?4Ijz18wDELEi8+h7WR8szhdm+yrFGMrzYw4rgYK5TRmHRFKjUUxF6rVpGRsR?=
 =?us-ascii?Q?yvive7r29OZu0Oj1E2u2BtVI79DqQJOBpnHrnP3/ACtyiyL8ceQKA5/qzDrx?=
 =?us-ascii?Q?a/DI/IlwKoF9WKcsxn2HGQN5Bn2P5/lA8aqshNyIbrImJOOYGCZCBB7FFLtA?=
 =?us-ascii?Q?z8qjc7cxZxuHzuAIVotSTcM7QFBAgWhgtiMcDr3xCwGjj/XEHAOFr8E6SkLo?=
 =?us-ascii?Q?56eDUKmKMqZ6FdjaXUBYm+YRPXyDIcxF5L2T/i21EyUjgEk0LMshePcVLUrJ?=
 =?us-ascii?Q?OkebVZ/0CYWl7CDYaGqhyWoHA+pm4X5s61tF+GH/WquurDl4pB++W9JIgVrJ?=
 =?us-ascii?Q?vc/bZrf1GC6q0pZneiirbB33CBlqX43ZfRfJ+Pejx69sWyaibJ/w53cZTdql?=
 =?us-ascii?Q?q+jbFou++lL0hKB2o+tND9dp1zmwOPwXS8ChkknG8JzBhWNjdr99UmErk0oH?=
 =?us-ascii?Q?afyTWouLfPlSm6jgb29tYwAmREaZyiaE7+n1MWfTXx14Ut3g9eK1/G4g3kSw?=
 =?us-ascii?Q?HgQyBodjPAMKVkh2V61lbbuxfz4V8b2Yu9/kLFi1FB/cXL/R3fDMEFagRDB5?=
 =?us-ascii?Q?SKFdQiJOUbWJ4bx2kgnPTS7YxcsXdwXCGhJ2wcR9I4gkyrt3lu4ZhNREa83j?=
 =?us-ascii?Q?jyHpYbc42T8LkM6vGTfahIm7iyN9NK+WRPsThbarn0lBLS49aoo7IGhsliHh?=
 =?us-ascii?Q?Pjk9MKtIYqLfqcji+s5IqlahYfjVSD7asXouGehp3vVvEqDvCOOpyntp5uHd?=
 =?us-ascii?Q?AkR0BTRkug1V57DPXEmTfR87nsWsGqUeJ6q5Uyh96GlRcvQLCe0TUr5JIllb?=
 =?us-ascii?Q?1hLEdo53zZ7J9PVPJcNRhmIstksUmhH9gZOrKts92dRGSXdki2vDAXSDS11y?=
 =?us-ascii?Q?4PuEw0cZT26hZAqLcC/+TyNSb6yWbTV/yY1VNOoCvABlK72Uz/5bEjIDqGxF?=
 =?us-ascii?Q?IG1ayS6vHv72FLcOPnRnnXo5ysHhXCJ+j33qUS9sQJ3pGajgmReGtOlzitjw?=
 =?us-ascii?Q?55vvZiVnEhNPixdNadFHxHnPWPr5XJvd6jKkWj2/dBKO1y+ANVgMUrw9177b?=
 =?us-ascii?Q?lJEpRfImoHXMB5qt3DBwZYyvvk0sfZqlPYIOLNbNy9PK7/Ay5I72CQftbGmh?=
 =?us-ascii?Q?o+C3Szrpc3N6kXCt7rh4RgXmML5WwX4Rn1HFA7u67wXwlnKGIODGHds0Wtvz?=
 =?us-ascii?Q?LE9Kmd4cmavtCitwbnzKTPGVEn39UeNy+K8C+d3x5XMTQvw+sNSbCmON9raj?=
 =?us-ascii?Q?KwdQ9YqpPtVmybIkin/OAF74tO1O2sZQMUZdB+srrebGXbreSHkBYwEonsW+?=
 =?us-ascii?Q?AJr9vRYXfbS/J6aZVi3Rrpgu4pas34cBLaPaB6Ff4amTizi33VJ+XE5Oz5z9?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	me2oqoHllAxliIXcxH2CR624szHDMjdn0iakZu0/y/+V5/EbcE8/hDyYPHuxEU5R3s0qY7wyVDzRMLUH76cQheaE1DncPwJfRL1Bh3+SeHC5844aUYOR6JyoBqEVgjVl28RXYbz75r6s+O3SqhrOrNLzp0qDvoU/+RbzF/3G/YPwNFPjpo0C2TnxMTD/FAeVQGaz3FOj0RqkeCtfvaCBaB0EpTYoOBkeN4IehGSWUvNtagZ0DJjOSvwJ6EQ6byO3ioqRxYKphufdAQYy0+O8a96MbpPAZCM3XkT8CK/TnBzR2+EaF1zWPEPuQAPX9Da7LVk6krI0DUJRLfuixmGavDbMzkua9tneBCIQuk1y7iCdw4wu3xNZJ/662yth349z1mGdV1PGdmxRZmlW04tT/imUP2zHNbZtu5s/kCG44WEcRYULOCFDGZ8bsgjb2qCXrFaXNm/zTWKTIp8Xc3z6JTCKCmmzkLWlselSeD//nl2XtigV4nrulXEYpPzpVVKYtM3rniGyUt4pFcbLrXXNRIBiAOJmdPik/0Sr213Mvs/JP5dpS9AuYC4WO48Kthov/ZA1WgkD5H8NKu3c/CDkXNoQhGlHykxVupK+KdrZ9Sw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82321389-cec8-40ee-0c25-08dcce59a895
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 09:52:45.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: az+RD7NGkFpQn69KvmgSbN+8GAijh9IOjHlqDG7CwP+TJnTm50Rc0MMg95VbBaAILbz2mXPOwkEX8AbLWdMnUkiiGkPXD2BFL3lWyvRr3ZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4517
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409060071
X-Proofpoint-GUID: Tibj2D11PgcrpHApJkAUJmNvl_YTQxUH
X-Proofpoint-ORIG-GUID: Tibj2D11PgcrpHApJkAUJmNvl_YTQxUH

(Sorry having issues with my IPv6 setup that duplicated the original email...

On Fri, Sep 06, 2024 at 09:14:08AM GMT, Arnd Bergmann wrote:
> On Fri, Sep 6, 2024, at 08:14, Lorenzo Stoakes wrote:
> > On Fri, Sep 06, 2024 at 07:17:44AM GMT, Arnd Bergmann wrote:
> >> On Thu, Sep 5, 2024, at 21:15, Charlie Jenkins wrote:
> >> > Create a personality flag ADDR_LIMIT_47BIT to support applications
> >> > that wish to transition from running in environments that support at
> >> > most 47-bit VAs to environments that support larger VAs. This
> >> > personality can be set to cause all allocations to be below the 47-bit
> >> > boundary. Using MAP_FIXED with mmap() will bypass this restriction.
> >> >
> >> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> >>
> >> I think having an architecture-independent mechanism to limit the size
> >> of the 64-bit address space is useful in general, and we've discussed
> >> the same thing for arm64 in the past, though we have not actually
> >> reached an agreement on the ABI previously.
> >
> > The thread on the original proposals attests to this being rather a fraught
> > topic, and I think the weight of opinion was more so in favour of opt-in
> > rather than opt-out.
>
> You mean opt-in to using the larger addresses like we do on arm64 and
> powerpc, while "opt-out" means a limit as Charlie suggested?

I guess I'm not using brilliant terminology here haha!

To clarify - the weight of opinion was for a situation where the address
space is limited, except if you set a hint above that (you could call that
opt-out or opt-in depending which way you look at it, so yeah ok very
unclear sorry!).

It was against the MAP_ flag and also I think a _flexible_ per-process
limit is also questionable as you might end up setting a limit which breaks
something else, and this starts getting messy quick.

To be clear, the ADDR_LIMIT_47BIT suggestion is absolutely a compromise and
practical suggestion.

>
> >> > @@ -22,6 +22,7 @@ enum {
> >> >  	WHOLE_SECONDS =		0x2000000,
> >> >  	STICKY_TIMEOUTS	=	0x4000000,
> >> >  	ADDR_LIMIT_3GB = 	0x8000000,
> >> > +	ADDR_LIMIT_47BIT = 	0x10000000,
> >> > };
> >>
> >> I'm a bit worried about having this done specifically in the
> >> personality flag bits, as they are rather limited. We obviously
> >> don't want to add many more such flags when there could be
> >> a way to just set the default limit.
> >
> > Since I'm the one who suggested it, I feel I should offer some kind of
> > vague defence here :)
> >
> > We shouldn't let perfect be the enemy of the good. This is a relatively
> > straightforward means of achieving the aim (assuming your concern about
> > arch_get_mmap_end() below isn't a blocker) which has the least impact on
> > existing code.
> >
> > Of course we can end up in absurdities where we start doing
> > ADDR_LIMIT_xxBIT... but again - it's simple, shouldn't represent an
> > egregious maintenance burden and is entirely opt-in so has things going for
> > it.
>
> I'm more confused now, I think most importantly we should try to
> handle this consistently across all architectures. The proposed
> implementation seems to completely block addresses above BIT(47)
> even for applications that opt in by calling mmap(BIT(47), ...),
> which seems to break the existing applications.

Hm, I thought the commit message suggested the hint overrides it still?

The intent is to optionally be able to run a process that keeps higher bits
free for tagging and to be sure no memory mapping in the process will
clobber these (correct me if I'm wrong Charlie! :)

So you really wouldn't want this if you are using tagged pointers, you'd
want to be sure literally nothing touches the higher bits.

>
> If we want this flag for RISC-V and also keep the behavior of
> defaulting to >BIT(47) addresses for mmap(0, ...) how about
> changing arch_get_mmap_end() to return the limit based on
> ADDR_LIMIT_47BIT and then make this default to enabled on
> arm64 and powerpc but disabled on riscv?

But you wouldn't necessarily want all processes to be so restricted, I
think this is what Charlie's trying to avoid :)

On the ohter hand - I'm not sure there are many processes on any arch
that'd want the higher mappings.

So that'd push us again towards risc v just limiting to 48-bits and only
mapping above this if a hint is provided like x86-64 does (and as you
mentioned via irc - it seems risc v is an outlier in that
DEFAULT_MAP_WINDOW == TASK_SIZE).

This would be more consistent vs. other arches.

>
> >> It's also unclear to me how we want this flag to interact with
> >> the existing logic in arch_get_mmap_end(), which attempts to
> >> limit the default mapping to a 47-bit address space already.
> >
> > How does ADDR_LIMIT_3GB presently interact with that?
>
> That is x86 specific and only relevant to compat tasks, limiting
> them to 3 instead of 4 GB. There is also ADDR_LIMIT_32BIT, which
> on arm32 is always set in practice to allow 32-bit addressing
> as opposed to ARMv2 style 26-bit addressing (IIRC ARMv3 supported
> both 26-bit and 32-bit addressing, while ARMv4 through ARMv7 are
> 32-bit only.

OK, I understand what it's for, I missed it was arch-specific bit, urgh.

I'd say this limit should be min of the arch-specific limit vs. the 48-bit
limit. If you have a 36-bit address space obviously it'd be rather unwise
to try to provide 48 bit addresses..

>
>       Arnd

