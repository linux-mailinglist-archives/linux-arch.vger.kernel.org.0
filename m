Return-Path: <linux-arch+bounces-7099-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F5596ED74
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 10:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0105B25E67
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 08:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC6E155A4E;
	Fri,  6 Sep 2024 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iZlHeQlo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hC8OneTK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B91156641;
	Fri,  6 Sep 2024 08:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610522; cv=fail; b=Tpudk8sa/AyCeG2Sr+DNn6dkkPgiclXSIzBAbNecaZECyFoFuK/7FULbOQM8AGAgoFppDQRpt0C/JtYA1B2eOT2jzEaWFVv6NnDSzBeN+j/hKqoFkGMJHxHuvqgBZR5J+hrg1xj5b8I/pw4ZtpJSDLc6feISPU6pYjzC20hBHho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610522; c=relaxed/simple;
	bh=KUQUYROvCQ/clJ5eQ9nJYD0sMyupJGSIFTgAXDvjupg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LXSsqKWVToAGB/NiXV8tECMX++yizxfXDkDBIEMKakUPmnYMWgQwE86HEgZYVITpJUgAU7G3FK/CALUr0AA5c3cHkGfWSCVgvad5tDtfxdmfNlsfp4Uf9JWTp8B9OLK/HrlCoeClXf2WJAvQbyQG7z3kd7efExHymO4ftHTWoxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iZlHeQlo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hC8OneTK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4863gZQs020261;
	Fri, 6 Sep 2024 08:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Cm7G4jufxBoV2AP
	fjQF1n7UETR0tQ2fV1g4gKiS/ZeM=; b=iZlHeQlooJyXvgiERL8Cqxb5O+6j1H+
	GlRUtsLNMXQmw89GufHmXUCgpbSJylbEuCXWcdyCT7n/Pu8IvcQkI9GRSHHM/Xun
	/nI9GIOlqKTnAcRdBnLN8spzaPGNZ6m81GBc0V8hYWjrUgQTMjnpU5b5dXk9PqrV
	thBrVZRFVcEo+FOAohhSVN/g+kNuldCzNFUaj0f0QS9XwCxAXAgBDj4NIN6/koBq
	2CtuJQcAyIbPhBjvnTM8ddoIOaSZa7RA48AzDw+acjjkMnUEkLf2O9DobcNrQvOC
	/SRhRpXHJw40c7e2pou6303hjTYHPMTCaTZhh3mKEJ+uQw0D0kTCeCw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41fhwns2u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 08:14:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4867IRUr016297;
	Fri, 6 Sep 2024 08:14:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41fhyhp7tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 08:14:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1T/lgDrWfb8JcBiHq9xPQw5mMgyWTl4JJ9asgfN4fMJ3qy1jrdhtT8zg+1SXWOzqlVUofEtYddHNaQB9ODWblYG8HQyMybsJwZk6Rw2bP2Y7PfqFw8UaVJH+TeFCjgpLQ9cOu/ggkby9rKSNOfcZ+2WuumEO8zORruzAZq/LdG5leLzcLmgl+AAX7lQhGvI8mgep/1ibhDyJKPsA0PQSNgJcudEOkmSQrDvA0cIu6E7fh3PYmhjtoY0C6c04Z2guJMV8Q1WgifBM284RzkakwxSIXQDG9BBFBhCVfBI0sMdGUL9zhXrBUPG06XAwvtw7ztVPbHP3wBccR0giaWAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cm7G4jufxBoV2APfjQF1n7UETR0tQ2fV1g4gKiS/ZeM=;
 b=VYy2JdfGy5SbGUQaBf7dYsRqAUpWO4Q84UscSPH3Zgc2vcfEjA0iQnqlUuBaMLuiSIujudVaLeFQsLAxDFQ00F/WYxBDGcQGEbn3Zo99884uH3rdlxrdYWjCnZ3iSQ09lfNWNg5x01dFxr1g3rXuw+Dam/IaddDX39nkkgorKPwewIdyyoV3tSbES9wCd4dSOFaX8gMrgS3yOvz1UgqxHXx5j/b6qEZk9CUeSS4El4wCEwUZGKk25w3B9aatpv5oq2NO+wO1UZ26jfOouTZwWQnbSa2V606cL3n+lOypjGrCwfFvnQIdjKVWr6AkWpoUwVPbh3jtZi34ZXoGe5S1PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm7G4jufxBoV2APfjQF1n7UETR0tQ2fV1g4gKiS/ZeM=;
 b=hC8OneTKSAqak3YF/7jMZLqFZdFlfxkk8TrXjpsLQxLOGJEgLCJvcMIzhMIE++tbjwX8TxXFDYkDIY+ve5Y0RliiczGllQ01kOyffNkVk74IY+T1PKD+2mnR/sMwJUGkSm8kgO4U8b5SvZS7c8+rTkRwlz+NktbQsa/hZJs9guM=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ0PR10MB5647.namprd10.prod.outlook.com (2603:10b6:a03:3da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Fri, 6 Sep
 2024 08:14:20 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7939.016; Fri, 6 Sep 2024
 08:14:20 +0000
Date: Fri, 6 Sep 2024 09:14:17 +0100
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
Message-ID: <58f39d58-579e-4dd3-8084-baebf86f1ae0@lucifer.local>
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
 <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
 <9fc4746b-8e9d-4a75-b966-e0906187e6b7@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fc4746b-8e9d-4a75-b966-e0906187e6b7@app.fastmail.com>
X-ClientProxiedBy: LO0P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::6) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ0PR10MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f683e53-a5ea-4b1d-bd88-08dcce4be8f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OFKpRZsOQe00/DDmUB9+czKvauw05M5edroC2Mav2UyKckL+bCVc4s+qOUsM?=
 =?us-ascii?Q?kKCAteX+x/f4tAaLXnBgUPHzc8XZ391eqoSZK2DEhF1mo9ckTBciIqjMr2QE?=
 =?us-ascii?Q?FmVFzhRF2MXhotjgD/O3KpmitshUKojEr5PUmDjEH0FSDfvMoRLFOdtbby9I?=
 =?us-ascii?Q?Wpb2vf7Zuf7tLxOvbKWn5BXlo7+YorYrchPzj+5wIWMPivs6uBqY+luOOYZU?=
 =?us-ascii?Q?y62KySvGEuXbfDy4uyrqdhmgdV9QFzeZXU67zuRQGPXbjyEmZrm6t88QM5LK?=
 =?us-ascii?Q?dQagNQd2hVK0PgjBt3Sld101QFbH6Gcuj5HtPdiKDLK0M4P8Ujlq7lpSRf8/?=
 =?us-ascii?Q?NvmDqNXcx46PYdyMGWphDzvCz/w077giHt4Y+EnOMpojs8cz05WevrtZbS+2?=
 =?us-ascii?Q?9ppb35jay4/VHuPHqj4JJduH9XGmc48RJN0CbogCYm7cquRAxgbdq8PT/Vuh?=
 =?us-ascii?Q?Bi3t0r4knrntY4JfJ8bMKKRy16TYzIDa8OkBTKMJv5+Su4gP3ZPvTaQuudd7?=
 =?us-ascii?Q?YdiYXOFjlvrEblyjsVMJBUF/T2KrgPfJP7VqdjugYzdacxyUE7wk7E+vt7en?=
 =?us-ascii?Q?S+8DBSoBl69MkvjM/8eACpvHjuqmPJMw3Yv5FA9DC7IUbJbbXZoEp/KZDi/D?=
 =?us-ascii?Q?ewuECxlLXPbIaXxC5RWizSqwUi1MHEws0TTjanHQCnJzhaPAG+mbOSQcTRhK?=
 =?us-ascii?Q?PkebrpOXLx0mVSvqfrLVpHBykRZHjOfFRs/aLOy6HaaswaSv9am/fHu6rRYh?=
 =?us-ascii?Q?PVlZi6nN/6+34l+2e134+G2R7k9taEf331uCrTrz/4l6dZj703NuyRgHR1dM?=
 =?us-ascii?Q?ZvIRs6poWfLlV+Q4L5WJyhYREoobPIgu/fUjrG4Il8kfk1k1kwzlBTTmKgLa?=
 =?us-ascii?Q?38fCcmw6GPEbqosUbZIoZWWTqTH8b+roqd0CrAuWcJGiDCQx6QVgyY4pF/XV?=
 =?us-ascii?Q?ybh5Q6kASsuMlJDxweQyqwJokcuxeYFQeGtEmhLF1lu2pEr+S069vVomyCdY?=
 =?us-ascii?Q?MOUHruuIrIgJSMeyJ6Mm3SVu2Wliqqk7ztheXblREOaha8YZiLR7r2wfgzwV?=
 =?us-ascii?Q?nQdEEE+T9Pj03vLAnCeOPH2RwdrZMjrIlgcYmrXqUu+Easv5sLhHZZv0Gnp6?=
 =?us-ascii?Q?z/74u8fD3RR4AKb6DrjQWKaX2EDO18ZFcGyRshN8QecXNrmJhe7TrN5Hchoy?=
 =?us-ascii?Q?SUYsuTrW97j4qDuJ+jjnNgbRk874lTzLfx2QlqQkWj0r/oUnb2i2oDfkKTlx?=
 =?us-ascii?Q?5B0ds58+te/Km1Nwu5SlIFEcMmv08Uk2eTszfeyXShlb8998cXpIgRVjeUP6?=
 =?us-ascii?Q?CEqvAsrGtFojOKRfSsshSPIZw9wbYfJ5eSTvNH3S6GoRRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IdOCpjR20zDEzKQBpKtuIUWGfRX33CjpYb6wnUZ1QPOUzG9NMK67tbX4N73n?=
 =?us-ascii?Q?s0+Uu1mh2cKu0cKdMWvRbWXsxK/e1SwUA4VNJpuh4Wo1rZoUN1D0iIE+5wTF?=
 =?us-ascii?Q?2Yk7rWueUBYsfQwovUY3AHHp9uly+uV4PVwATcJdm5rRLG+ewMuPmWodY1sN?=
 =?us-ascii?Q?o10f6/IQygqzICnvix/ZRt97qX3Hr/S6Sd+b5HkNIwC5hC6dwJPZdvD2hlL2?=
 =?us-ascii?Q?xJGSq0jJYeG7bDU7n1TuLGNd0D3G1tsOEcIm9TXUMyrHFgNRFiIZvbMbnLsJ?=
 =?us-ascii?Q?So1Bib1ORx5RxqBbFP9k0xHVcDpzbtPaywDWtgApQF6x4rizfJfZZu4PsdI/?=
 =?us-ascii?Q?VFALBhMEhzm87oRAm5oM07caatlDGG4vlMcK1vcrePLUJw1jPwR7kbt5DUA0?=
 =?us-ascii?Q?UMrqDCk6UxaSDV+oxqZRMRgoUWaNj0uSzXmj0SH5w3mzUJMoB70wme4Tvt6b?=
 =?us-ascii?Q?NVpfNGX5GiLoXYl4ipDMvJE6GrVOTYV8Ykw3bHfCV5yE4YLngOJHSP0ApyJd?=
 =?us-ascii?Q?Mz2OfMTTNJekdfr+o22YG966omrUeycgKJkX4CHdvf+pUhLv2/gzXGr87fTK?=
 =?us-ascii?Q?XRsx7qZiIYm0MnBvrLKo/KTHEUEXsa1gAXa/5uvdNMdxCaZiwGYZet70mZsd?=
 =?us-ascii?Q?XugCN3vHPFEEjXgKuzSHrGNRqLt6ZhWBZP7weCxejcyubWf8lPZnWxu2lCEp?=
 =?us-ascii?Q?K77jTIscgZNb9SixNqO09WPXDooxb2sAePNllXUaOZMEns+3gtGU9ntM2hNd?=
 =?us-ascii?Q?bxmg/PscyX8m0BC98sylva0H7tgQhCSX/FFHAywvgeF1Imhd9gsJu7Z5G/b4?=
 =?us-ascii?Q?o+lFhFNnPKaJ31BxyN7/nZLDBgg5cOhv0XrQhZQ3TiBLGRpzVs+eeRAO14Ub?=
 =?us-ascii?Q?JaUuRiT3Iy8dLsFTmwjbxrtSHS5rI/9iR0QsTxfXkH09JAd7niIt3AkD/5X5?=
 =?us-ascii?Q?7qFAY2GdiUYvs/l5CCP9D0F1drMaUiC6SRD/jGaTd3BatXCfiGOI1H6rE0Mf?=
 =?us-ascii?Q?u+nlXbkcSZEpW8/lAMGgx6gXmtM/xwkWSvGN1vLjm9riykhZ9Sm8UNT8ap9b?=
 =?us-ascii?Q?bRxF6KZk7aRREFeaAcyvJsUjzeDhJzq3JSfGqGMpswnl3ymk6gIX52dFdg5Q?=
 =?us-ascii?Q?iCBoJNL74dMLkx+b/VgoR7LP02dOgzkY7o3iK8tgexewq4Tr/u5d11ybUGKi?=
 =?us-ascii?Q?eUvpJIN2opZotkrw+e/aSVgkRQq1MCo8nqzaRO+7GRcHB/BI81V8DCcNBZeP?=
 =?us-ascii?Q?3f9e2JC5p2s8P0q/QHu9QqCshmv2dnd0QMYpLWPcwGL+G0lqZ2zLAxMr3YCy?=
 =?us-ascii?Q?pGEF5O1oj5Q2nQh2PYvip65BKe+5RYO6UOfVL1WIvKgDiCRw4mNobrOHeXMu?=
 =?us-ascii?Q?7IPioMRURi+gkEm2wiXaE+TCOpHqEjww8FveUeNA8xlVLUYfb57VqlrovhV/?=
 =?us-ascii?Q?aFbTWmvxxoCLGbbRSrIl08mNGWbNAG4/hwGxyBXdRjxjG6oEGOiPhqkqyjJj?=
 =?us-ascii?Q?JptZoTlYZ6yStaE/+kpTPfha4JiejbegULCr+BGpvfPhX6jYkwwJ9XOrYEEK?=
 =?us-ascii?Q?PmXQUrWHBG62IFiZ9se8h9kWE3FFjXXhfj+wdbnbagDqDCuJtg4nOaCytHhA?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EBbwVpEScvpyPKwCWSGt14EUSIWFtoBL908tBd3ogUCZxpCsHk+mOsDwBEIb3B3x9rsbrbtp6+E6yUDR5tGAfouMwFtjwGkuUM0RJBPoChSBte/wIb6mt3UV5pufmYcQN884lLz4NKjamTPBHVJfj232UW3o1qfi3xZSRMtoHQay9Es9ATHv/OF3ylE9EptOZtvkrw9XJW7ByM27/D4Mw59mAW652ZrqhRc41YBg6HbI7A1BqJklfgz7/Q5V73sLN/KRi7xQYKvkhq/I0oy0/0XHOVEth5nHsumXORE/0EiAl5c3oQqsA+obp14/wqTQ3y5k+ytTu/8Linv1KOEksn0CEg1y73ER4bR+OKm90KCqj6Y6NW33qa3LfBcmYiazC+/ISKEEMEhg0VkCd9i3hN9zkRy+Wupi7nI8oXu93BMqtVhKEJ0wAg9q3FtXFt/eMoVX2VHrSM0mCxkA2m00/Ftz7sFgenxISNJUvk8RxGNs/f4eQYX3vXtqaEQ0OzfWoe49yjAe7eesugXaBt5/RHWgHxQCrwWugVbzLlOBFc3TdHqT7JKuOUYmHdMTQCmCNfg8gavT+7+D1IEck9rL9iZyjnwZ5UOQAyHlq+fmGBk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f683e53-a5ea-4b1d-bd88-08dcce4be8f7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 08:14:20.7186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HWTrm2E73/l11GPgo9Tphl/nbslGqzjjdUELCPYUPklmLUYydcun/EjOOXPkqKIqpj9D0nmnH5KBlaB5dLi50m+jGsUr6k9d9yZ/lSMEXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=883 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409060057
X-Proofpoint-GUID: UsIgplPV-RHVGEUIoA90T3DkqzfWm98u
X-Proofpoint-ORIG-GUID: UsIgplPV-RHVGEUIoA90T3DkqzfWm98u

On Fri, Sep 06, 2024 at 07:17:44AM GMT, Arnd Bergmann wrote:
> On Thu, Sep 5, 2024, at 21:15, Charlie Jenkins wrote:
> > Create a personality flag ADDR_LIMIT_47BIT to support applications
> > that wish to transition from running in environments that support at
> > most 47-bit VAs to environments that support larger VAs. This
> > personality can be set to cause all allocations to be below the 47-bit
> > boundary. Using MAP_FIXED with mmap() will bypass this restriction.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>
> I think having an architecture-independent mechanism to limit the size
> of the 64-bit address space is useful in general, and we've discussed
> the same thing for arm64 in the past, though we have not actually
> reached an agreement on the ABI previously.

The thread on the original proposals attests to this being rather a fraught
topic, and I think the weight of opinion was more so in favour of opt-in
rather than opt-out.

>
> > @@ -22,6 +22,7 @@ enum {
> >  	WHOLE_SECONDS =		0x2000000,
> >  	STICKY_TIMEOUTS	=	0x4000000,
> >  	ADDR_LIMIT_3GB = 	0x8000000,
> > +	ADDR_LIMIT_47BIT = 	0x10000000,
> > };
>
> I'm a bit worried about having this done specifically in the
> personality flag bits, as they are rather limited. We obviously
> don't want to add many more such flags when there could be
> a way to just set the default limit.

Since I'm the one who suggested it, I feel I should offer some kind of
vague defence here :)

We shouldn't let perfect be the enemy of the good. This is a relatively
straightforward means of achieving the aim (assuming your concern about
arch_get_mmap_end() below isn't a blocker) which has the least impact on
existing code.

Of course we can end up in absurdities where we start doing
ADDR_LIMIT_xxBIT... but again - it's simple, shouldn't represent an
egregious maintenance burden and is entirely opt-in so has things going for
it.

>
> It's also unclear to me how we want this flag to interact with
> the existing logic in arch_get_mmap_end(), which attempts to
> limit the default mapping to a 47-bit address space already.

How does ADDR_LIMIT_3GB presently interact with that?

>
> For some reason, it appears that the arch_get_mmap_end()
> logic on RISC-V defaults to the maximum address
> space for the 'addr==0' case which is inconsistentn with
> the other architectures, so we should probably fix that
> part first, possibly moving more of that logic into a
> shared implementation.
>
>       Arnd

