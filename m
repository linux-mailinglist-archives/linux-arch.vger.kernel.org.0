Return-Path: <linux-arch+bounces-6725-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A36962EF5
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 19:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D38285972
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 17:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3411A76DD;
	Wed, 28 Aug 2024 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O8ONZoXf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yh+sSEPh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7235F1A76A8;
	Wed, 28 Aug 2024 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867444; cv=fail; b=bRPJ5nCRkNMnMa+WIHvCCrnEWakcqSZaT8kpDHJFXmIPTWrCTWVq5X02Ou87udJRpAmyYdrnkLNQACIHJ55zBt0ZjQx8s51s560v/1afHrvquOrL/6QoFv9pDCmjh3v2zQA9VX3OOeAsT9szqs9UAPSlos4l6OmhExv0TixNbAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867444; c=relaxed/simple;
	bh=Q/asNFbMOFHL81zMfD0xTfSBYHF0dKLxyORIwM2xozc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GO7TYN/aBrLJnYdIbblV9YlO2ZaDWTRfApZVHUrm9uDE95pZDP+NNviiMh2Sg4bAgbLiMcEWdriaJaDzZzdF2AA2J8i2kqlWHGfX9vxcCzPnTp7rI8ePe3SfMa9MUhReVtDQb6un1K6lJv0wabELNo8D4e6yXDU1jwmczI1X4yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O8ONZoXf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Yh+sSEPh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SHfYxw031689;
	Wed, 28 Aug 2024 17:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=jPD5ldR86T2j/Wf
	dbSeTg1sO/e6xkTCdjrJDK7zzUfU=; b=O8ONZoXfA5lDXH9fMNwNOdxAlS1sMF+
	kmohtjiDuqlDCqjyEvUf66E3LilPSlzKpvby3f34r+eb4ljbPBZ2AifOERsqGJzw
	hghR2pxev/SqQ5aK2oj4V8+mVUsW6P9rcO1pd/IWNoAsbYboxWKv0GtV56cTiamm
	l0FeqXoPOL7d5DapD0z0EYTHHZn1K6X+26o6BOlnDXIFIRDtWfKPG8A8y0L+ZCL6
	kN2Ts9A4zNr6C0E3WQ2ibdwkBVf4dCByRfQxnn+QGKxW3xEP51tm9p8ugwEYZ4k5
	SwjCOpygArTUFttR9NuOL3QnIZMRmzUPAOS4VEKGjPFdyYtDxCRKZTw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pur9xea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 17:48:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47SG4GM9036474;
	Wed, 28 Aug 2024 17:48:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jm599a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 17:48:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kF9i3ijmNb1rz1BaEASY5QA2puRFaZea+OdOVAluw1rt7ItjRjshtdGauq3QgB0sY2lD7rXnBOgkRmcVfy6lLI4yjj86YAXI+E6Uil4JUjZlp7KJCE8KGqt96SRb4dcmNoxXIo6wHWO1msvu9VvJDX10ZQqgPdGBAQ3jbn0vh9lpg+aYMhE7t0GZph0Pzd0ktGoXX6+StouIfDhSX0bku9leFAoIM9K/4j8ED4Y+wC3dUpmdFq0uEdGwKAJ6Ssyc+oYFUqRUb/yHfn9ORe+lHmpYWEXkvdGE87mc+kYz78XBSGraLu6aJADtzHZzHMKvwIZDZzkWBf7wxnfeYabtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPD5ldR86T2j/WfdbSeTg1sO/e6xkTCdjrJDK7zzUfU=;
 b=AWRkbPeUiFWkJWLW3WyqC5ixcPkUGeqTTq1S0qOiFK9yCHhTvtSX1oyCtt4PnXIT761GvBtgxzS80cZGDvRMNs+TFG2ev7vAuFQqfhY0QnAT4WACQMTcAN5OtUaYJnk9NAZx6wOBnuJCvXTeZ7JmYKAX3ilI8tHZigcmrq3FjwnYP3Ag151ni6mdPPd99+Py3r7ChwC7UmDeDXV3TqBaIA2fKLWchwHk9fi9htSZR7mciZyUv51QGkaAyCm3wpfpgu5u8o36LjYh+t69/W+UQ2mcPrbMLG/XSF7Kr/y1IF8VkUc6gRRxFEFYSs0W/4661SHV8e0gLkxBdP3XZf3Jyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPD5ldR86T2j/WfdbSeTg1sO/e6xkTCdjrJDK7zzUfU=;
 b=Yh+sSEPhUvzaiiJofsQOPOEnC1buZ0KkAaPosiOhUkOPtTDcAlc/NSbDDm54hylZ4JIsttckpqz7HgrJbnaOGb4B0g/m1gVAiL6vQrkUqkXmNh8QqUylGfZn+WxmatwojBy30h4Ux8ZegWsnHPfgMBit+0pfVYncKCRjabDO2WI=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MN6PR10MB7443.namprd10.prod.outlook.com (2603:10b6:208:46f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Wed, 28 Aug
 2024 17:48:38 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.017; Wed, 28 Aug 2024
 17:48:38 +0000
Date: Wed, 28 Aug 2024 18:48:33 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Shuah Khan <shuah@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 16/16] selftests/mm: Create MAP_BELOW_HINT test
Message-ID: <71528354-4884-41e4-a4a9-318e26187f86@lucifer.local>
References: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
 <20240827-patches-below_hint_mmap-v1-16-46ff2eb9022d@rivosinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827-patches-below_hint_mmap-v1-16-46ff2eb9022d@rivosinc.com>
X-ClientProxiedBy: LO4P123CA0079.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MN6PR10MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c91bd3-3436-44b7-d731-08dcc789a569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5qB7dXrGtOohFAs2PmlYdYsCVZUNPzS3ePN53jPnSYcXSaHy5vHWrPl7tlBU?=
 =?us-ascii?Q?RPkNsfIq1uU7KFWHj+htbdWLx/67oWaBE6Ep225sM/AQzxWUmQ/lLQsNnSkA?=
 =?us-ascii?Q?m/26s1Kqwi8AWaePI+5cLzH0tocRH4nFCh1jKa7JBo5hUeCFn/TdtXoSx9Yk?=
 =?us-ascii?Q?CdLHR8glV9UZ20XEZq0Ipv4WfgenO9A5ko5x54o3cOIGqgxwiaHb/8oCFEX0?=
 =?us-ascii?Q?hmUlxovV3l6uRHLsvj/gTyRT4OXpe1ULjwesQW1Oe35cOe0wBgNsX/Ghfqik?=
 =?us-ascii?Q?R+aU1EDolRfH28SoH5fJlXjHmrWKb1npaeAQGrB2uTuByTjpYjO6jlesSoJu?=
 =?us-ascii?Q?6FCggzJJWG0PBg5o4osPdqyxG2nLyihwJz3VOkvE/bsPdfUDAXDmyQGKicLI?=
 =?us-ascii?Q?xfgimxnIkktuXqHVfWcACtJ91kYeUg5PMIhpVO91ltkmvxtnqeIEwvaglMXg?=
 =?us-ascii?Q?09yKlqlze5dPjiobVIrEVfMFmu9VpgZYK8XO5g6OIpDbVD4Cx9Y4WRc+M2SH?=
 =?us-ascii?Q?USM4j0eFrDlvcCw1Z9TEuBjCyqXQvRKZ1JeyUEDCSkBxRfMhy1rlYuZ7gv2f?=
 =?us-ascii?Q?9uU/jDqSCh/s++hG04N+fI1TjKNemZQbU4M4H31O6zb9n3b5zvd1hlMVMp3I?=
 =?us-ascii?Q?ViZeqCVH1W4wCVbUOaGz++hh7/jT8sc9jsj4+bv9BjWxiTw9pGp8SCGfRlhL?=
 =?us-ascii?Q?2/XEnJm3yaFt9m8umxH3LlojBNsXGmbrClrYQWW2q8Bl2HU2HVQFeT2eNos0?=
 =?us-ascii?Q?9y9BBQ7v9pEvBy5w163lTXfdbqm46AZKA3+JSKJExvDzMzn8VoK2ieCTmpRy?=
 =?us-ascii?Q?Jx20xss9/WbX2DyoerDpfdkvjWOpJUKPsckOnjpQqQopAZviW0+ZsM4s0R1p?=
 =?us-ascii?Q?GLNTgTbdOx2j3fEDFJh0EQR80LKZLZuO7OBH572+t2U0dTqm3TTVWsXi6ebA?=
 =?us-ascii?Q?YBsddRZPU9w2poJ0wP8HjZ1ajEHD3AqxMORREYVbBw3rruhCo8VnUsiXrDr3?=
 =?us-ascii?Q?b4vCOGOLnklfDzzkcaWV9aegbcJJLdWK28OmAWen9ZBzE2pCElWBmdVgm0sA?=
 =?us-ascii?Q?YN8liSeUNeuS0OehrshtEPK5FH2rMYQI6T66uEr3x2Eg6lHIDgUbH535Q8iY?=
 =?us-ascii?Q?OpPggKrRZchbUm7WDas3Ddl6RI63D51MfZNohxBxQWwOsYhIrsrphUhcW6Sb?=
 =?us-ascii?Q?Yg/KY/30X6qHDAmRhBXow5pFGQXFcpyIRvcEhN3TUxM1NdrU3qr0xKjwmfoO?=
 =?us-ascii?Q?aJxwNbATEhLzsiaVXPeJh8MVi8j2PnUQ6XkjZJf4Lb/2M/JGVBuHxehc7tI5?=
 =?us-ascii?Q?apCwofi5oguCjuCn0CvwTQUgVXcrczxrhzCj4TywYyYHAQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dEtmyiRAHwMdmP2cPtID2M9+0VQVuVLn+Su8rvLgYEbNAoS0EJa2qPROu8Mc?=
 =?us-ascii?Q?uGck05u4K0j1Kipi38/3LgQYgdVp+6Z5vLivYh4x4+EYZC167SNVh4O5yr19?=
 =?us-ascii?Q?fJRBvSYsj/hfD/SSug4pCSFoWB1LZJk2L9qQqbjbST+Xm1zJuZQSLqhuHaaZ?=
 =?us-ascii?Q?Nz3YZ9IqwsSQBRYQdBgnNCrwpTvSkm+VzdaPobhBf7fh+czebWQsQVABrIch?=
 =?us-ascii?Q?gdcR/GcUTiuGZFNb/sfzbwVvZrsk2k4NhVL2pDu4MZ80x/mDTLh7X32SaETD?=
 =?us-ascii?Q?2lmwUV+9dRWAnpLYvH5oeYSlhCzDibtOZP6X9Et/pUEgY10kbVpgGNA+wUZT?=
 =?us-ascii?Q?nKZSSQY5yxE0+O3ZWT8vNJ+OKXCtAQGHZ+ITtCn1sWQ8KftRwRztb1BjxOou?=
 =?us-ascii?Q?llL90leHNGjVnI4JRtPczeZxP3ikP1vsrnB72DE+X1n2sy30IomSGVIXUDBg?=
 =?us-ascii?Q?NzMR7VZtVcn1S3wyIwe7FiDIOOwZRcP38Ocyhq2m1z2ktSWXZ0CJvvT5+lsZ?=
 =?us-ascii?Q?G/GU6bdgtsuEKo2zlwjb4GhnDmguiCGHVQzv3TBFJyoyOYL8gIgkOwM0G+tu?=
 =?us-ascii?Q?2DBlmca7HPgmXYL2xi9HIPmb/xl30ud8ZF5WVZTpvGiW8d6tr2R59PjKg07d?=
 =?us-ascii?Q?Lh13/2a62DuO71lJhaoBA1AqwUT2h9FN045FykPGjPdjoHScRKI4P95T2QK9?=
 =?us-ascii?Q?7pdaCaD0JoGYxaDNQg7kj5hiVxGelonZqaiQvyuysL+jB+14BAp+4tHBSdUJ?=
 =?us-ascii?Q?LIfLSwicDRd+6QajTJTV7uqYDZ4F/8QLYnp5FauhAtCOBRuq/QsmP+BIPOGY?=
 =?us-ascii?Q?7kq24HgcyHOdljxLqovw8n09nbWZG8EwzsLV/pPw8eKEmBgEpZLG3H62Avqg?=
 =?us-ascii?Q?790ctjxUs0AV+Qoi7Lr+HoweWxMyXmsugMQLYOyYEgYT5vI9u9EhWxfAhmjn?=
 =?us-ascii?Q?dqD85EXUMguE2okC1Je8OKdPe4v5TbfbqV8/yzazklD+zBzfsc95VeZxGAvD?=
 =?us-ascii?Q?hUZUjYFowPj60xI3MCli73AFcNi15bjTtPwyro03b9Gp+LqxOEzqEwXfpOzb?=
 =?us-ascii?Q?Rb5my+CouQbNjukhw2Qa1eUUIRyFvCBa159ZlWm2QQUXeD7CymQro7IjXM+8?=
 =?us-ascii?Q?ApK53BtR/607alu+GW8cVtGtWVzW6ABCJeFJRbF1K5w5rHWqUd6XbnioSMYB?=
 =?us-ascii?Q?faoRzVqR0uhxTndriHpBrDi5FYoNYFNoGQfJktSPIU+3fdPnDzinKV1oHPGV?=
 =?us-ascii?Q?jvUUd5Lef/TWL/KKYtWRFaN7LDI+oMkpAEFgRjDuyPNaVqeMbGiN464Qg0Nc?=
 =?us-ascii?Q?fHBOCwPTX+1JF1/rQQRwUyhLlylxMaDN9cQtQ/eyfK/zTdwiiLfa0+/yxfPD?=
 =?us-ascii?Q?LJWp2qOIX6bHL7EppC/m0lA7W5HxadQWXMOJ9sqgR2XIN467SkQ2KtawJz0I?=
 =?us-ascii?Q?2kQUhYioVaUXpIWYbfgFROivKkTHsQPRO+j1TsjmZdNnNv6HiufzuSLFtySu?=
 =?us-ascii?Q?BH8uBExybN3Ty+xi2G2P2Ojqr4Dd6SUPtlJpIUXYmBmFBUyMOJROR5Qe8gOU?=
 =?us-ascii?Q?HIQZ0T4ed0ncj9c4SToZBlM8QMacblWqFVUZye+OKOb4vFHKO8338GMHhxZr?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zzfimRHknnoXHJjUfQ4B39vRUPV5SDgXkpKJjYvlH8kSVxSOTTbO+bWFT/8cTl6YUx3I3FWipFFM1JgT3FtpvxD83YVQg3VjF5aZRtVfsE2v+4D9bbXHz/6c8nyv+bKy77MQqbSRUxZvJ1zA2A6LqWyB6PFLTiI/AhWNIG4H0a5v7uiZw0r78e0sQshve+3IepeIwZYHdNa57BvPOj4V317rmC0/k4oMjA2poTlPFKbmjLZsu2PALn28Pa4xkVpLs3Dmuy8Fkpm1l+qY4tCY34CwG0dwXCR/w36l0wAf6jBNvbLD3zXVTdDrlA5LSRN8QiGonB9xlbZ8idlCkrel8Ush2cLCExU0T8Nv7RW+80JnvPkyXq/I7XfGb4Wr/7ATN81ESTVLVjkaJflV2CEwS6rsyCBTEh1smKucRhZ6vOh8zC/N2fF+0KYNaI9Ar6RwBM4Tvb0ULhV5TtQ0DwIACrWRm8NYEhjmb2T9VA2y6MfpXLzjWL76v9Em165mtTHcWcgH3hyoxCkEcRQDLzZ/U4HjMKNnptAmXljLrU0voar5ky0K79lKQb2X2jXnUnT2NAFMByX8208CahK3dHny6mahZ6C+uaZlNacUzXaZIHE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c91bd3-3436-44b7-d731-08dcc789a569
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 17:48:38.1127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SubI1FC1LlPy7yx1J3Jz8QmSV9Jxs7tC6sBaXloQFHq4+ogjbZjENIYXEPo4v2/YLR0tEkRjMhvL9cfrOYNIQVX7mErGIFsoJmk1F6LKtms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7443
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_08,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408280129
X-Proofpoint-ORIG-GUID: 3JUvpC-_E5lWYtJJaCVys7J802EE5rAv
X-Proofpoint-GUID: 3JUvpC-_E5lWYtJJaCVys7J802EE5rAv

On Tue, Aug 27, 2024 at 10:49:22PM GMT, Charlie Jenkins wrote:
> Add a selftest for MAP_BELOW_HINT that maps until it runs out of space
> below the hint address.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  tools/testing/selftests/mm/Makefile         |  1 +
>  tools/testing/selftests/mm/map_below_hint.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index cfad627e8d94..4e2de85267b5 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -50,6 +50,7 @@ TEST_GEN_FILES += hugepage-shm
>  TEST_GEN_FILES += hugepage-vmemmap
>  TEST_GEN_FILES += khugepaged
>  TEST_GEN_FILES += madv_populate
> +TEST_GEN_FILES += map_below_hint
>  TEST_GEN_FILES += map_fixed_noreplace
>  TEST_GEN_FILES += map_hugetlb
>  TEST_GEN_FILES += map_populate
> diff --git a/tools/testing/selftests/mm/map_below_hint.c b/tools/testing/selftests/mm/map_below_hint.c
> new file mode 100644
> index 000000000000..305274c5af49
> --- /dev/null
> +++ b/tools/testing/selftests/mm/map_below_hint.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test the MAP_BELOW_HINT mmap flag.
> + */
> +#include <sys/mman.h>
> +#include "../kselftest.h"
> +
> +#define ADDR 0x1000000UL
> +#define LENGTH (ADDR / 100)
> +
> +#define MAP_BELOW_HINT	  0x8000000	/* Not defined in all libc */
> +
> +/*
> + * Map memory with MAP_BELOW_HINT until no memory left. Ensure that all returned
> + * addresses are below the hint.
> + */
> +int main(int argc, char **argv)
> +{
> +	void *addr;
> +
> +	do {
> +		addr = mmap((void *)ADDR, LENGTH, MAP_ANONYMOUS, MAP_BELOW_HINT, -1, 0);

How can this be correct? mmap() has parameters:

       void *mmap(void addr[.length], size_t length, int prot, int flags,
                  int fd, off_t offset);

You'r setting prot = MAP_ANONYMOUS, flags = MAP_BELOW_HINT...

This surely should be:

mmap(..., PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE | MAP_BELOW_HINT, -1, 0);

> +	} while (addr == MAP_FAILED && (unsigned long)addr <= ADDR);

How can addr == MAP_FAILED (i.e. ~0) and addr <= ADDR? This will just loop
through once...

If you want to make sure you're getting mappings only below the hint until
you start getting MAP_FAILED's you'll need to handle this more robustly.

> +
> +	if (addr != MAP_FAILED && (unsigned long)addr > ADDR)
> +		ksft_exit_fail_msg("mmap returned address above hint with MAP_BELOW_HINT\n");

This is just going to fail because your flags are wrong then wrongly claim
to have passed...

> +
> +	ksft_test_result_pass("MAP_BELOW_HINT works\n");
> +}
>
> --
> 2.45.0
>

