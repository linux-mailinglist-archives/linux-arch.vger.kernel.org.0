Return-Path: <linux-arch+bounces-8387-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5D29A9026
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 21:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD1B2814A7
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 19:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAE31CB518;
	Mon, 21 Oct 2024 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HIXDo2HQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CoAtjeqO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F701C9DE5;
	Mon, 21 Oct 2024 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540227; cv=fail; b=rC8b1xaYIIte/0DXFTl3hSzeEre50tl2mFMd11o/sAJoRfsBTadOvHdKfRXSrvhC8G++d38Ckql9Lg3eY2QA9dJBIPeuOqmGjRQ2GxovkIWnxelQMTnEjg3oiHRtk0C7z+MfSqTjZRBr4+SfE5JMSgY9UPJnsudZqzX2Jbzl+7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540227; c=relaxed/simple;
	bh=SKx6Wr9R3nI3ZJvduKwNfuouVkxmQnACDmMjaAKD0c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VYjy8Rc5aawX9GV4yGPybU8YPdFxgrCjfxKT8lUuIYuqnAGKly/qmoriJISiiL5jU9BvRsHRiD9yO7Ca7WDb1y+ikmhnX3cg9IEMNUHHTbmyySpMW71bw50gKr+TtqBb6ztIaCmepwQT1rCJUItt81tF00ph1+notAfWOalMZ24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HIXDo2HQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CoAtjeqO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LJBbYM001339;
	Mon, 21 Oct 2024 19:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=y+9k8KBp68GO/Zp8YM
	U/qq3QRdCcMVlwrezYiyMCtRQ=; b=HIXDo2HQVum3mF0LGr1Vb7DvUxS7ls0w4L
	ZzBlHA/X6D/0IQAtuV3PQHKavy2JxVUfzCrc4x6WOKU56a4WC3ko/2hvr9lmjMXt
	BMJcoy0r6n0JJ6aLPtzxjzEb6KBVMl62uszxWF9HvheiATmVZg8graIKqYnWUU04
	Nj+mS1roJroXzgxFU9G1Do9Icyg1qpH/gCgySZv2SmLUMI3OhfvuadIdztxIBg1A
	kseB1mQBfbHdbyhoxCWb8zZeMx30utwQVn4r2q7ME1EK8iZ+nsElKNp7tJGK2QO9
	du73MneGJ+WljYE70MlyM/UBe6wJYoGLbsiwzqvDwFgpcTnoRoeg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c545417n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 19:48:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LIs3tX019768;
	Mon, 21 Oct 2024 19:48:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c37cxetq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 19:48:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQKWiItybMpyao+dxd5UAoUxI12A3Dqz23ZCwkURiwZmuHuDe9mH2sF0EsKGxIjEruowhg9p4oK7ZO+lpY+WZ7+GJlApPTJ1tIx28mdHolulVBfdSeLjt7KEKbSXwK2YrizaXpZgxs8JIZVzvo837ZgA17ReCshxLSfEea9WQWpWXd9cYVBIwIMaZNmDtD8KmspmdSWfb92ZnmWAW0OWaIP+F2tyyakVKh/kpXf5/rbJt4Uts+CbRNsWmnlqNMfeA2KtqLdDJTh9XMLd3CgCmnXKJqxTq6/u3wcAVuncvNZFw0B2eX4PARchDVSkh83dzsj7qIiQh1JtuD+wm9Y/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+9k8KBp68GO/Zp8YMU/qq3QRdCcMVlwrezYiyMCtRQ=;
 b=f+0mYztFtb+3GnXSuaicAAZWjI/sYx+mTbzEUJAJvvteeU6rMsxEZpjzQZ9i6SkRX4ggOgrrez0jOQEKdK/aAOMNJ/iuJ8qe5lPSX3y1+Jw0t7j59BUk5/yftNf2BUhUc4k0UevJAhrdpvtyoHKfCMOfZQX2va60semTpFzoopXqmrGq0Vlftkbyb7WpRELm1Ky8SEAZteLw+mX1lPlYdgTdTx2+OHqgYwSppAdlzck0uI78tJoaLqNRS2ur9uoyAL5SDW96or/Hjd1Rgq2m4X83nDsvjREF79hG9IRB/Pbn2/7euLJCTRlpo/dJpyeaifl0+AdoE9vAxGS6FarllA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+9k8KBp68GO/Zp8YMU/qq3QRdCcMVlwrezYiyMCtRQ=;
 b=CoAtjeqO+7VL4g73dFxNujgHYTJEN/DRAnVivTMu3/YwVXk0WN1WDW/99dON/NEBRXKO5m5ZE/278+gdLU6BYRNF3iukZDZi0pT5JbQajwnMaiiRH71IFiQhSVCcwGSw6YFEZWeikDMp+DimWMdKUkdo0hDQAP+EMFIt/libi08=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA1PR10MB6784.namprd10.prod.outlook.com (2603:10b6:208:428::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 19:48:53 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 19:48:53 +0000
Date: Mon, 21 Oct 2024 15:48:48 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Steven Price <steven.price@arm.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
        Charlie Jenkins <charlie@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Shuah Khan <shuah@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/4] mm: Introduce MAP_BELOW_HINT
Message-ID: <5u7xntjdye5ejjmkgpp7m3ogpzblxcztrwngulejdft63fzuwf@xcxfcbaccqtw>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Steven Price <steven.price@arm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, 
	Charlie Jenkins <charlie@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Shuah Khan <shuah@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
 <yu7um2tcxg2apoz372rmzpkrfgbb42ndvabvrsp4usb2e3bkrf@huaucjsp5vlj>
 <Ztnp3OAIRz/daj7s@ghost>
 <pbotlphw77fkfacldtpxfjcs2w5nhb2uvxszv5rmlrhjm42akd@4pvcqb7ojq4v>
 <b6ca55b7-4de2-4085-97bd-619f91d9fcb8@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6ca55b7-4de2-4085-97bd-619f91d9fcb8@arm.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0499.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::12) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA1PR10MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: d7573188-9cfa-49c4-ea2c-08dcf2096459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bBJX3O83yfTKVlIRLShv+/qybkfGhyu1ytQ6M9thX4cSntxfsrP73YcS2TNq?=
 =?us-ascii?Q?bShtRTjjTEZsQTM7WQiKPj84bWwGHjdUkH/XFofKgV5I6EsGqPmR/exWeFVj?=
 =?us-ascii?Q?geKpfRT/891yxHrk0g0ofsdSw8VgayccTyRTTbrl6bBMLnk7Yu4JbYh+9LIV?=
 =?us-ascii?Q?EcmOMMSw1S5QPHAiya3N2n7G1gFOSxmzZh9ciqkl49tNOBkMQUXi7MnrNhlj?=
 =?us-ascii?Q?D1fuNokTo/H474QEv3lubtKwxVPDr/6VyflV2EDZKiA47oAUJlCOj9ot7THf?=
 =?us-ascii?Q?yr+I5iuBdKF2VPkWHzc7viA/BvOptZ9eh3mhUB9A7IVirS7UhVuevOR5Qw+M?=
 =?us-ascii?Q?m+ZAYFCFnGTED8dAWFKgn/im0Uyt7bsQyCnvSqEaBcHvG4V9WNMNrn5duGyZ?=
 =?us-ascii?Q?4Wpjlg/+6Mj1GyEo3p5bW5ZYxuCTM8m7nAzQuPhTeNwzYXGRR/TQMOHsiEjL?=
 =?us-ascii?Q?LRy2eP3YEsrxBqLtawVEkJq3MIwgqbySphMLPO4tGNDV4+CR6rXD9lta0v5d?=
 =?us-ascii?Q?6QN+X5I9F8pGpAqrtlz97hCp2wLgXAQIhiY018b9kQ+LltzHeUnQwEqS4mMn?=
 =?us-ascii?Q?uxkz8LwuwyyaA0y39nZx1sMHjsR+g/zlFQboSl3TYLWd4sYBRshWVeOvoXBk?=
 =?us-ascii?Q?arDDC7cGGd/O1PzsZoch1L5PKCXgs9EEmPwFQkR8vJi90pSVZLj2NwAXWLez?=
 =?us-ascii?Q?KgWBMW4IDPqmfUO6MTD9Ziu5N0eQT9NQHEgOzz0cqyJAS+4AD1ukO8GIkmlB?=
 =?us-ascii?Q?2IkDB2OGEBLS5nAR++fRx/V8PABLaTMg1t+Kq3WYNf4NrJ5fDB0XqIE/e2Fk?=
 =?us-ascii?Q?1/0HEMYs3mhox0JRq+ufRXq/dOMh9LyXNsMPxJ4J2qlKDcfyKzyvEYvvOy0v?=
 =?us-ascii?Q?1BKMGpfm9pOrOmXN49y8VtrBnsUXJ7jmc3Jp4KYcupsarFHsFPCSLPz7ZdmU?=
 =?us-ascii?Q?ELYUkqzFUA3XrBNRiFhaiXwsyH15pKr3pop/sfGgdJ7tGwJHyIXS5RqneIL7?=
 =?us-ascii?Q?dUraptDpf/aM6gU2b+9v3uerBitIAwCx9pbY35TAbUh55n1zzCxetjvzK7Kx?=
 =?us-ascii?Q?CT+vZvBeGgX9ufNfpa7K73alNZ/WGA99OwLEWJG06cAKo+Aop6rVSu6lsnhU?=
 =?us-ascii?Q?YENTkmc0kAYzvHr5m+qY+Byh1BA3ST/agQu5q82jnKheoPYUOcGHosHCPSdQ?=
 =?us-ascii?Q?eXfOxJkX16cuOpKxdn8Oo/b9tVBYZPpNKAaIs4BP9P66/GKZcA2RlAcnATTR?=
 =?us-ascii?Q?xQ/rFfUJM4cB0aZAVc1UZljOIXxRb2AH3vKwKGqjrw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eJSYJmj67fMJognDz1w0YhevPtDDzK7N8Nd7VpZYlaDM7x9PSfKe05XbnbhF?=
 =?us-ascii?Q?6XCHnEj1cpEpt/uHWV2/MneOXBXTFoQAyuRMTtnpupZsx913mvIH4gRVZ4DU?=
 =?us-ascii?Q?msNzAs/G7D5bgnc64dvpwr0fI1/yt0xrbIv79nvwn6nSjsD7SgzFZ3NCN7Na?=
 =?us-ascii?Q?K92hrx7sVKiRzUgq77DwvbfbqU607sBTRONRkZRao0o3sJT/OTa9H+wAPDHW?=
 =?us-ascii?Q?7tBa6hW1TWp0JMSNk2kdJQSbUXLqURfKjD/49T5BpNcEgM9bgMpy7dzIRjH0?=
 =?us-ascii?Q?NVcV5StbErz3jfytPdMZCAsV7EaBlNEzNZ31WEIF5o2Y+OvmUO96lTSGirUp?=
 =?us-ascii?Q?pMdGaDzp2l5ZVjp2dk/tcouY6uW0BqcEebi3Xdy61sLQgJ1UeDOYkMURXMkg?=
 =?us-ascii?Q?yiDwwINm4Toz1N/G/ro40CYuf1c2EDiu5N1P4ZpP6gYp0OactKxMAVnMBeOT?=
 =?us-ascii?Q?dfeiuBEnIqxf7eVfH8GjpmSZGgSPAxye6m7DLuvxUIYZpsVbQmtUUfIKKTwt?=
 =?us-ascii?Q?NDj/WuGyKwipVLxP8ZD/V0WCTFs8Ki3d5P2B4TfOvJ/d8SoeRW/eyMgr21fR?=
 =?us-ascii?Q?qa4sxXCg3I6wTXfn6Wt8HWIjp/sGLRtm3nDeEna27EMqdtcamwEDus7Mu7ot?=
 =?us-ascii?Q?X8I8/+SX7kuNm238nOZctPQ2IqScrRbXZRCwb3/ytJGHoZlV0+xwvI2NYVwv?=
 =?us-ascii?Q?J0F6U/C64qK+fR4IJXKuaXI+FKg2Gg8IzESEOWekkHBCDb36rRRiEUMflJO+?=
 =?us-ascii?Q?GEI6yVaQJ+LUmV1rQWtATVUw4xyPPv6ZIQ4vNWDnsDvxkz2sIdYR1Up96QjH?=
 =?us-ascii?Q?Sb6NYWApIj9RC1HkKekdgPk1FfRaiHqCgOQwIl5uNVYqYTd9xP/dudcMtufE?=
 =?us-ascii?Q?PxYde/STpKyuFvqsdZtw6v0BEr8ucFONTvCYVICLAEBtcxMQdipJtL2omgGP?=
 =?us-ascii?Q?+84vBY1Mtr/7crw2srWnzLzBb4GVNvQoihT+39n/MyXUFxDWtp0WMxyDD0bq?=
 =?us-ascii?Q?7QSCxemyhsV8/NsmjtCVTXg7wcSG9X601YqNFVGzYVwgfRiMKEwB9QVQgFlM?=
 =?us-ascii?Q?vDAEwm9HzC7VDRbwNdSpJwhI7rooVEVuWAPq9wTDS+qmw9wjNBlqainrwYAJ?=
 =?us-ascii?Q?58qIWTVMvTKT+NOiLf5d9s9uEXMd/iEuxYWa0u/+MIPF/KPOBebpZlwG04yT?=
 =?us-ascii?Q?z3oZo2rTteonSemO2N1huoZUJBj4vrAcPHCuMHyeAh9S5HkKLSkFJzRxtgIe?=
 =?us-ascii?Q?gJFEVtjiMSGljSFSeh6nISlTI/6z3v6BPTmkBJbRda5R259Uhc1+WPnbDMak?=
 =?us-ascii?Q?FAe0terPEVLzarDIZD0NvFv6ERjDS/xxU+W1PqhqOKFNFOKC+6R6sK+tKVIA?=
 =?us-ascii?Q?RqYEjeM5Xb988dRyoNlYEBTQ09OHqml331hFsfwFUtkSyz5gqzBKhQ6wJZKK?=
 =?us-ascii?Q?vsID1jH43EBF3Sai3UpuObw3ZU2j3EqJe7FyyISLywdyuplby/gSFdma+Gtq?=
 =?us-ascii?Q?1xUMt7ai9GYPXwjt32a3bfV0H8XguPWAZbMhVg3Zl/r6asIQEr4j2cbmuxAi?=
 =?us-ascii?Q?ElHsniS31dIdTvnSzMxRvrrOWzQBDdIUeGraTQz8ZHV2nHA3LUC0mdJcQ0db?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nVVjn1rzQfjl63RD708q44/gPW6cndDkJr2NcP1Djvtk0AUCExmjmAyZb3MN0qUcl+04D/DtuLcIdOH4AUEGPtczdO/iyaCgmv53QIf5kQSKI3lC4UQZTwtBdFc5kaPexOCWbj5qeO62rmuhc5U52rukw+7LFbIGAth/BmUkj5u/rK/dhJe5kjWgcf2aK9yYzMVrMWeH3X+TuCiDHi8WSximf+agKK9lwxl46oFBlvsBePn1KY50T8arEqZbUTgPO3FnLcWBSi4Dg0eypWfqJkreOllyHn6V+r0XlCk5IRXw/X1DMElqr0EE2+U07w15yWKGkD76HzEeeZhF+gfZEZqPhm3afshmE8ZyBL5U/MrT6tTiZfe3dZenIXVZ30IMqRXWTwqZzasa36rs6rg7WeryDwmzuBpcDIIWpS30A9kvoFfDT20lTUInZi779U1uaof7hXm7Z4UtSGequ8501r99Ib9k0CXO8tVYtaSUhsnAxGIoLqfXVy4HKTtc9xJq3QFPnSxD6POiOJTu6hDpuRfsoEtl3RJcWkSon/kwYLGQNt3C5P2DQXdV9ldZ3I47vN2J5dnEMDVQW+dUvJIFhn6kBBYEc8gfTxifeUgsGMk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7573188-9cfa-49c4-ea2c-08dcf2096459
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:48:53.4582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: larPSMRO2YcYGSqz3KRg+6dehzaXRj10Mbxty2dWpE/Y5W55k3Tm9aKmW+MJRoIGTJVjVzvT++WPX75dDre0rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6784
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_18,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410210142
X-Proofpoint-ORIG-GUID: 23o6x68UfvssW20Sjgfs19ta02z80H7a
X-Proofpoint-GUID: 23o6x68UfvssW20Sjgfs19ta02z80H7a

* Steven Price <steven.price@arm.com> [241021 09:23]:
> On 09/09/2024 10:46, Kirill A. Shutemov wrote:
> > On Thu, Sep 05, 2024 at 10:26:52AM -0700, Charlie Jenkins wrote:
> >> On Thu, Sep 05, 2024 at 09:47:47AM +0300, Kirill A. Shutemov wrote:
> >>> On Thu, Aug 29, 2024 at 12:15:57AM -0700, Charlie Jenkins wrote:
> >>>> Some applications rely on placing data in free bits addresses allocated
> >>>> by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
> >>>> address returned by mmap to be less than the 48-bit address space,
> >>>> unless the hint address uses more than 47 bits (the 48th bit is reserved
> >>>> for the kernel address space).
> >>>>
> >>>> The riscv architecture needs a way to similarly restrict the virtual
> >>>> address space. On the riscv port of OpenJDK an error is thrown if
> >>>> attempted to run on the 57-bit address space, called sv57 [1].  golang
> >>>> has a comment that sv57 support is not complete, but there are some
> >>>> workarounds to get it to mostly work [2].
> > 
> > I also saw libmozjs crashing with 57-bit address space on x86.
> > 
> >>>> These applications work on x86 because x86 does an implicit 47-bit
> >>>> restriction of mmap() address that contain a hint address that is less
> >>>> than 48 bits.
> >>>>
> >>>> Instead of implicitly restricting the address space on riscv (or any
> >>>> current/future architecture), a flag would allow users to opt-in to this
> >>>> behavior rather than opt-out as is done on other architectures. This is
> >>>> desirable because it is a small class of applications that do pointer
> >>>> masking.
> > 
> > You reiterate the argument about "small class of applications". But it
> > makes no sense to me.
> 
> Sorry to chime in late on this - I had been considering implementing
> something like MAP_BELOW_HINT and found this thread.
> 
> While the examples of applications that want to use high VA bits and get
> bitten by future upgrades is not very persuasive. It's worth pointing
> out that there are a variety of somewhat horrid hacks out there to work
> around this feature not existing.
> 
> E.g. from my brief research into other code:
> 
>   * Box64 seems to have a custom allocator based on reading 
>     /proc/self/maps to allocate a block of VA space with a low enough 
>     address [1]
> 
>   * PHP has code reading /proc/self/maps - I think this is to find a 
>     segment which is close enough to the text segment [2]
> 
>   * FEX-Emu mmap()s the upper 128TB of VA on Arm to avoid full 48 bit
>     addresses [3][4]

Can't the limited number of applications that need to restrict the upper
bound use an LD_PRELOAD compatible library to do this?

> 
>   * pmdk has some funky code to find the lowest address that meets 
>     certain requirements - this does look like an ALSR alternative and 
>     probably couldn't directly use MAP_BELOW_HINT, although maybe this 
>     suggests we need a mechanism to map without a VA-range? [5]
> 
>   * MIT-Scheme parses /proc/self/maps to find the lowest mapping within 
>     a range [6]
> 
>   * LuaJIT uses an approach to 'probe' to find a suitable low address 
>     for allocation [7]
> 

Although I did not take a deep dive into each example above, there are
some very odd things being done, we will never cover all the use cases
with an exact API match.  What we have today can be made to work for
these users as they have figured ways to do it.

Are they pretty? no.  Are they common? no.  I'm not sure it's worth
plumbing in new MM code in for these users.

> The biggest benefit I see of MAP_BELOW_HINT is that it would allow a
> library to get low addresses without causing any problems for the rest
> of the application. The use case I'm looking at is in a library and 
> therefore a personality mode wouldn't be appropriate (because I don't 
> want to affect the rest of the application). Reading /proc/self/maps
> is also problematic because other threads could be allocating/freeing
> at the same time.

As long as you don't exhaust the lower limit you are trying to allocate
within - which is exactly the issue riscv is hitting.

I understand that you are providing examples to prove that this is
needed, but I feel like you are better demonstrating the flexibility
exists to implement solutions in different ways using todays API.

I think it would be best to use the existing methods and work around the
issue that was created in riscv while future changes could mirror amd64
and arm64.

...
> 
> 
> [1] https://sources.debian.org/src/box64/0.3.0+dfsg-1/src/custommem.c/
> [2] https://sources.debian.org/src/php8.2/8.2.24-1/ext/opcache/shared_alloc_mmap.c/#L62
> [3] https://github.com/FEX-Emu/FEX/blob/main/FEXCore/Source/Utils/Allocator.cpp
> [4] https://github.com/FEX-Emu/FEX/commit/df2f1ad074e5cdfb19a0bd4639b7604f777fb05c
> [5] https://sources.debian.org/src/pmdk/1.13.1-1.1/src/common/mmap_posix.c/?hl=29#L29
> [6] https://sources.debian.org/src/mit-scheme/12.1-3/src/microcode/ux.c/#L826
> [7] https://sources.debian.org/src/luajit/2.1.0+openresty20240815-1/src/lj_alloc.c/
> 
...

Thanks,
Liam

