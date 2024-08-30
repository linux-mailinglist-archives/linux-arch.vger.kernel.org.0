Return-Path: <linux-arch+bounces-6841-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A318965D9B
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 11:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C690628A54A
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 09:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FE517C215;
	Fri, 30 Aug 2024 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e5Qw2Pp6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FOnk77RF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FE816F0DD;
	Fri, 30 Aug 2024 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725011645; cv=fail; b=d2toyUiqruOQkA5xABJPn++0ddSZKmqe+9QBnyx5rT4RpwyE0cPwzwbiveAVjMMejvTrJCEIKoAQS7Kw19u8rTcmWM2qiXnSDNB79GIFoQoB+IOenD3L5AYxBZZRr+UcKW/jd/qgRBwamCiMOL3XqS0sqzTGYNtRdPGgL4lu6Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725011645; c=relaxed/simple;
	bh=hqNEcd0+gZBmyjQukjB/xbHJhaOmusztk04aOE5/uxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UtRmZTOFSuiJmCdtBE3Ywkun5z8wlVTyzwT1/w0SRuSCKp82fhcMX3iGnV9Whg1VYcKuqg8J7ucNHH75QAdJ76XK4tovRBBBP4UhHvVo7jiQPlOoKYRl0uv/S20HPBow9BckzsbgZ082RTDyd4x742UanjORO8BWRigbQAGcOzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e5Qw2Pp6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FOnk77RF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U996bJ008933;
	Fri, 30 Aug 2024 09:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=ZO/z0VSZTX01uvY
	2vRGWI6PSHLebnvQsYp7WAyj3g5c=; b=e5Qw2Pp6Cz9V0QDQNJ8RORBld9wmNde
	5YzT7X50SkMSvSC2SRew+o1iAOQvH+0RaGMYYNEJdxp0iWSxKZYRnmxqi0fSbqPY
	Ga/+bP9gA5PoUBC8UPGJt2P3GjSIB9S0OfyYTcAE2JK+xEdWv35AzqttYZnTJ2ve
	NozBY+S9pawhbbhjYtcLne2GzAY1s9sXT6qgXsJP5RBcu46FNugcIjO/fYtLPTHh
	L5LxZAo/+MBCO1tZDdAKsHEivqRgtnBDrswW+0KjHnrNbGnTuyvkCgCk0MyBqN7d
	kpmlEUyTT4Zpx3kJafoV7Rx6VGj7pKGEPLRNtSBZnutaA6tOdyUn4zQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bb6dg28q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 09:52:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U8eBxA016846;
	Fri, 30 Aug 2024 09:52:09 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5w8pjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 09:52:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwZlaNuATC7DiTxYwOGr89usuWLhJfj14hn3YMPcvnuPLAoFrYYrWAY30sH6Meavb0X5Ao8SL2jYo1PTozBkxhVa7iDCdKcqndkWZWFXpMqbYb2OI7I4NkPUXTqixL0tu+nEnGrzzT9glHExfu7yiZqCGjH/B/C6Xb2YKQRjVMl3hAW2y1/zeu8jozmG4SF8kc6Szy7i0MP20bdZmJqREcHBp9j05LvrriW1mLmJby3As9XclG+rr1+2y2JjDMuzaQxZAzXv4AQ4tamTpp39Bx0H2rwnRNVz+FWsyH1n9QiVSy8j3yjk7dXFty5Pp+nWsgHV5XWOHy9RjaN1a26iMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZO/z0VSZTX01uvY2vRGWI6PSHLebnvQsYp7WAyj3g5c=;
 b=pVNMPvRukvMzIayJQI9CDkIld3/FiTesrQrh9pI7eGg9vabZ+Qmr/cLfdoJCB6KxZxzmzAFq86GZ3cioZLn/DX9XU2NAcZP9nyYZCK5DJgChp28pMrnKliCqySi/3YrviRxH3vuO3R21ppqHoEAYgUk23cE0VWxtZuYXuF43MIV86ErTgV6i5133m7E24uqyI4+ZRXFIH05iut1Ifb5WNABiXSZh1b4iDU7Diptr9dDKrX8p2KR/b8lovGOUFv3JVpacx/MWI6XYZULRJYI0VeAZ3YLPBKrPI36VG9eUJlLkVu8m105sbD/PU+lCCVugkqxxh7q8mPtviRKVUwCtoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZO/z0VSZTX01uvY2vRGWI6PSHLebnvQsYp7WAyj3g5c=;
 b=FOnk77RFCgXK675hPoWdfPv6M3JH16/rOzZpWRYT1Zvw9zrnHVjIM6XFQwLiRCn0LeUCZIG4QzAy+auv6Mg8A0tQpepvkDSaZIUmcdsgnsQNS3F2/PBGtTGZNQk7BisJVl1KzQwr+ZX2Sxxb4J+uoQ7ubqWXYkIH/HSyk/E7cjw=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB6796.namprd10.prod.outlook.com (2603:10b6:208:438::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 09:52:05 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 09:52:05 +0000
Date: Fri, 30 Aug 2024 10:52:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
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
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/4] mm: Introduce MAP_BELOW_HINT
Message-ID: <b31a2c87-0c90-4062-9feb-6d6b813c0bde@lucifer.local>
References: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
 <ab90ff3b-67dc-4195-89a7-54e394da1aa0@lucifer.local>
 <4e1e9f49-8da4-4832-972b-2024d623a7bb@lucifer.local>
 <ZtDzVZLrcbiKRium@ghost>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtDzVZLrcbiKRium@ghost>
X-ClientProxiedBy: LO2P265CA0494.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: f703d2ea-c962-4b51-520f-08dcc8d96753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+AIg5RFZ2SL+O9QVZMB/FJKKtdwiVTQQjWCnzCtC+m3Yrafy24eFu5fNCS3J?=
 =?us-ascii?Q?uUo1veKZIpWiHLA7gI0uDJmEktzztKRehFl90ILfTjNkV3rCqPMtIulzjNJ1?=
 =?us-ascii?Q?gUTcyd7KgNW/0yfb9q4nIhuNtCHMmXCSiL9U5MY9vYWhC0Hh/BIbdkGbsh59?=
 =?us-ascii?Q?lkt/Rz8ud71HAdcyXmyhdohD+UOOAkI2zJkBDacbuPTFxgovrJxQA6T3CliN?=
 =?us-ascii?Q?nOwMx9v//r4eNjwOxBHhOiKHjQpJYARKyzCQYxWoVeu0CuMW2g1dBUOwuPRA?=
 =?us-ascii?Q?fWw2BFMsadMBH/Rd+BmVqUbCTGr4FlACZJ87qAz5JSlsYfUULFG0ksVmo7nT?=
 =?us-ascii?Q?qTFA5coShJFpGB+b60mDeLGGUVt57N0BB7U7diMu172pbhhLGRsSIU6gm5YV?=
 =?us-ascii?Q?GKTPGFWBeZOTmb+KVCQYoqkrCA/wLTgrss3WI1VJPwE8YLjfyQWNTzsrhwdS?=
 =?us-ascii?Q?/BlfS/SDTWZJLJqLRqMlzbcYmL5E0eD1Rj1rNia1H62cct/6dleDutl4h4zI?=
 =?us-ascii?Q?AED2JJSyO3iCAZlKZv+HEA2yd2qb1u62pxoVujd8Zc6NVNOHTDojxVE6t/ij?=
 =?us-ascii?Q?rlPvFmbO4pQcsrwguCMjhK82uJBSnlTqh+ZoxQ3lv3e/cXO2rABwnvSiPKuA?=
 =?us-ascii?Q?V7jHdSu3pUdvv77m8kbyCtIlM0ChFIhC+5qecyG2FEShHrWsgFsan5F5RGss?=
 =?us-ascii?Q?lTq+P+So0kTzDLr5A7BK/4RIH1KBrWXodKat8lIDiL0jPfy0yJm/ui0nWYN9?=
 =?us-ascii?Q?qsBEgXB4/+uIJ+TJNZms8eOzSYijTTU7B0Ce9aMEFdiobbQkB50332KZ65Ij?=
 =?us-ascii?Q?OkKrTTohXg4FRm3BmoOVV669AyHJgd68Y5mey5C2g8MdB/z41Obw1go1k6Xz?=
 =?us-ascii?Q?6CpDVWMw1VDb/MFn96epjklP1iZ3zid2IePfMOozTRTfc4gkxQUs1DHb5BSd?=
 =?us-ascii?Q?i5ZlfAR0fx8JpWrFpyTrXQEGsg8wt5/4aN1AJzFZqSUf/49rSWbdYO6CDJN0?=
 =?us-ascii?Q?D5UiMPrE9Ui6FXRVqSf7DfAbCg4mJfUyAVOPESeB/EKTEfuEfFsliK6AK1pM?=
 =?us-ascii?Q?zHu+NXvJS/Z64XwnBYAtydmjSFF8y+H96iuj7us4xNR/CrZ6oigNQhq89Nzu?=
 =?us-ascii?Q?HzxFLzueb7QBAXoc6is0y+6PSxL4cGgj1/fbY5WJQEMQwsJRpVfHY8toIG0U?=
 =?us-ascii?Q?G1rL6Oa0iey/K0DpHgXeZ5EUyQso/qtroVgSktl55SwR0Rq8GhRQ7sONZasA?=
 =?us-ascii?Q?BCz/IMVxIPeMgLCW4fLm/wrPoYt3NqAZlCv2kQhE3CFie3pfjGZZ2YzT2FZH?=
 =?us-ascii?Q?J3QCDX/+tw5+HWgdNSReOil6EFevgREBAT/nu/Kmc81b+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F3jAJO10bfpAGWMwANAiMlWB50sSiIr91zWtvvYUdCgTzfSpeyFd8iSftFzt?=
 =?us-ascii?Q?g7EhTODFppK9VQrGO2NR2j/AvFVP8GZe1oztMjkGC+vQmwQge+aLcqe4TA36?=
 =?us-ascii?Q?XLidSUoh28hBnaG1qtmKEknJDqNqcxUdLUgR0xWs4H/ezHpgHwoqNhjZFoSl?=
 =?us-ascii?Q?IkSWf9/r8ZF6jo/0s3OJWR5YQd++hDhZue9TkE1NupOOBZL2dDt6QT2zXKtu?=
 =?us-ascii?Q?KvPLvZW0Rdc1fTT1PI1AHQwyVe+Q7QPjjv8SVP08U6b7Lh+Rsp0Ltaezgtzv?=
 =?us-ascii?Q?Zf98eKI6H/WsHTh6t0Y61aWqnoZlPyYN4muiNtopzKIvw3kM2EbZmn6gMVOW?=
 =?us-ascii?Q?3PLSBArQGIaEAIxfLM9PPO2IG8sOJMMFl6o/5B88840Btyb+0O1JqLPaw/jX?=
 =?us-ascii?Q?yJHhfaj9tHMuHowDyQZhfPlFGeniwuTodkfn/SgIw9jELLwMEe3ERKvIbyhi?=
 =?us-ascii?Q?3X4nVXft1hGWWrt1ISN6zOURsGi5Q/MxfCLmljbMGu3zUZcH7sOeD/+qGWPi?=
 =?us-ascii?Q?6De+lKHu1UC7RtEz1uBiTDgejRBygLECmJeFP2wxDCwiRa7lGlgbFJJWjjMx?=
 =?us-ascii?Q?uHLkUcwCb8mliWb7Dexx+KAkaFwe736dje5AvgF277aatb5mU6C6f0AltasC?=
 =?us-ascii?Q?yFzIS4Lk+Tu/O9Nua5vbUTjyWv/DZtGN41Rng1uqwv03IcqVLasa6AcMafD0?=
 =?us-ascii?Q?iUPdD4wVbv3Htg4gFHkC+av/3KA5rht/kzk3qAfPPowzJrAy6UWhjE0tlgAe?=
 =?us-ascii?Q?Y/EDJX1Q5eAlg2xiMYuSSWocd9+Z0kLen2togVQimO5Vn1qJmB5qwd2+auGt?=
 =?us-ascii?Q?jf77X3+DM66dIzyNb/e5ZXOxbdxkeyHeqMYudZDqQezBz/XhFDh3+MEI4hLZ?=
 =?us-ascii?Q?ZGuH0HeUVEtvd/bQJ8KheHNr3rh03vPhUD9hS33bTYFhDhhP9OyZHglquVR+?=
 =?us-ascii?Q?Q2IDZApwsTwZq5feMP7KGp5Qg8fiBWRBOK8uOIPfRcCDx6zvK6CFo1nsu7Hd?=
 =?us-ascii?Q?pzi8761J+tmKYlLuzhAVDalYfgM60zppscuNDVs0wfpWoEHaAxBvwMFu0/zy?=
 =?us-ascii?Q?cPSTuSOb97Ghpt29eli0QyqjmoyBVGLvpfz9/GGnQb28pjmJHyFuN3JZGqUw?=
 =?us-ascii?Q?toqvF19VLv4XrfcgOF5yphrMO+3QUanW5pE1sl5xfmGwicLIaOkRMSYtW7/N?=
 =?us-ascii?Q?LDoHERMYymRx+2YdOb/jKiOmEG/aznNzW4SOcVVr6RjWsevjxiC3TAb2Pw/d?=
 =?us-ascii?Q?Nb65bnpy/gYcUEXjNQKrYarweHS8xd2wyXYVF/DELB76wB8Tvy8luq7Li92X?=
 =?us-ascii?Q?8412sf92TNocPw80FT9x43xcu1ytZpLopnkjIkSMDO0PSo8BbdD9SmJJbqIu?=
 =?us-ascii?Q?X43eStPGMriDprAcm1RRnXQh7Kw4+evZ6wgNrqDZBRzQx14qEfL9v2uUs7+a?=
 =?us-ascii?Q?ZIIhBRBKziAU3HV+6kQH8QpmEDtRR/uGmBJWtrHwpdTpK4Z245fCDCmt22tg?=
 =?us-ascii?Q?XDCuf8VoQnkxageuGWy8RVCX6eRH++T1E+yF0ITIJBMt9jPzwYoDYMh8Y3ug?=
 =?us-ascii?Q?ZNNJCW2l7sEpDTNgjubgCuDRiM31Kt1Iu1c9IAqd70rPkiO06jTOf/eBAWmJ?=
 =?us-ascii?Q?EZCJ4Xq4V0lQtBrktRJHXm2xlFuvjk740JDk7MZZL4BLXcT4K6ICw5x40KTH?=
 =?us-ascii?Q?xfoEqw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0qU9QtNKAdMSQI11Q+cpef20P56HG5UYPfcpT3UWozxmwRu3XPTpY3uR5TB9h/IMoCzPjEyVyknYrIP+8eV+PeZwvMft0uZgg23oMAPrxtcN2Mu5nFe8EYbcE+zTNFNYZHh6nfPymyEZwZb/YqFz/DjTal+NI/I9OA9d+OGmnJbbd1ErZci1GakkvxbuKDbn9OjCnYkf5SE4PJ5yZO4gezeDGTswUg/oio+64VvJCqO3WnDh9Fzi3E7UCXjW1tzopmWeJiAwzwkEX671F56otA73Ae9uUz7noidRVliJLk28KjmjcjW4zysRs8aLJSfSKIV9h1jOgj+G84TpatZJVJoEl2yQevAdTrIlgRzZtAKE8lmljRSmzWFCFCn9HRLh2rjqj1aVpbIi9Sx0O1QPONLBwTRvHlucqRUyr9OJjlocF4nzXPFeYDUgOgiwlql6Il+HfiNXlqhxWSzDWDx3pLH+b+eDGuGjhUFoz5OPZL8yjz/6vBFBIcE5B02JrbT151O9c8pi0xUgfhangfb5q4NhXVN3IO2osoZ5QyepuOAQ+t5EpJddkyP2HIxkEJWJBdh+ddX4Y+tjJC4lpX+QAX/KiWa133uIVyHQJd26VEQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f703d2ea-c962-4b51-520f-08dcc8d96753
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 09:52:04.9478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNiqPdqm2MJsKp5Cluu6BOFKOwSzocGWe5+YSwJrHLpo434GWkdoVZgwB8ScyStYBEduAARPZSqAtnCljmeOCSpKKfucgX0MKHi24aRhhSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_04,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300073
X-Proofpoint-GUID: 2qHYM9UYSx-jLkIcGYiHdSUQ4okdPQCb
X-Proofpoint-ORIG-GUID: 2qHYM9UYSx-jLkIcGYiHdSUQ4okdPQCb

On Thu, Aug 29, 2024 at 03:16:53PM GMT, Charlie Jenkins wrote:
> On Thu, Aug 29, 2024 at 10:54:25AM +0100, Lorenzo Stoakes wrote:
> > On Thu, Aug 29, 2024 at 09:42:22AM GMT, Lorenzo Stoakes wrote:
> > > On Thu, Aug 29, 2024 at 12:15:57AM GMT, Charlie Jenkins wrote:
> > > > Some applications rely on placing data in free bits addresses allocated
> > > > by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
> > > > address returned by mmap to be less than the 48-bit address space,
> > > > unless the hint address uses more than 47 bits (the 48th bit is reserved
> > > > for the kernel address space).
> > >
> > > I'm still confused as to why, if an mmap flag is desired, and thus programs
> > > are having to be heavily modified and controlled to be able to do this, why
> > > you can't just do an mmap() with PROT_NONE early, around a hinted address
> > > that, sits below the required limit, and then mprotect() or mmap() over it?
> > >
> > > Your feature is a major adjustment to mmap(), it needs to be pretty
> > > significantly justified, especially if taking up a new flag.
> > >
> > > >
> > > > The riscv architecture needs a way to similarly restrict the virtual
> > > > address space. On the riscv port of OpenJDK an error is thrown if
> > > > attempted to run on the 57-bit address space, called sv57 [1].  golang
> > > > has a comment that sv57 support is not complete, but there are some
> > > > workarounds to get it to mostly work [2].
> > > >
> > > > These applications work on x86 because x86 does an implicit 47-bit
> > > > restriction of mmap() address that contain a hint address that is less
> > > > than 48 bits.
> > >
> > > You mean x86 _has_ to limit to physically available bits in a canonical
> > > format :) this will not be the case for 5-page table levels though...
>
> I might be misunderstanding but I am not talking about pointer masking
> or canonical addresses here. I am referring to the pattern of:
>
> 1. Getting an address from mmap()
> 2. Writing data into bits assumed to be unused in the address
> 3. Using the data stored in the address
> 4. Clearing the data from the address and sign extending
> 5. Dereferencing the now sign-extended address to conform to canonical
>    addresses
>
> I am just talking about step 1 and 2 here -- getting an address from
> mmap() that only uses bits that will allow your application to not
> break. How canonicalization happens is a a separate conversation, that
> can be handled by LAM for x86, TBI for arm64, or Ssnpm for riscv.
> While LAM for x86 is only capable of masking addresses to 48 or 57 bits,
> Ssnpm for riscv allow an arbitrary number of bits to be masked out.
> A design goal here is to be able to support all of the pointer masking
> flavors, and not just x86.

Right I get that, I was just saying that the implicit limitation in x86 is
due to virtual addresses _having_ to be less than 48 bits. So that's why
that is right? I mean perhaps I'm mistaken?

Or is it such that x86 can provide a space for tagging for CPU technology
that supports it (UAI perhaps?).

I agree with what Michal and others said about the decision to default to
the reduced address space size and opt-in for higher bits. Your series
doesn't do this...

>
> > >
> > > >
> > > > Instead of implicitly restricting the address space on riscv (or any
> > > > current/future architecture), a flag would allow users to opt-in to this
> > > > behavior rather than opt-out as is done on other architectures. This is
> > > > desirable because it is a small class of applications that do pointer
> > > > masking.
> > >
> > > I raised this last time and you didn't seem to address it so to be more
> > > blunt:
> > >
> > > I don't understand why this needs to be an mmap() flag. From this it seems
> > > the whole process needs allocations to be below a certain limit.
>
> Yeah making it per-process does seem logical, as it would help with
> pointer masking.

To me it's the only feasible way forward, you can't control all libraries,
a map flag continues to seem a strange way to implement this, and I
understand that your justification is that it is the _least invasive_ way
of doing this, but as I've said below, it's actually pretty invasive if you
think about it, the current implementation seems to me to be insufficient
without having VMA flags etc.

>
> > >
> > > That _could_ be achieved through a 'personality' or similar (though a
> > > personality is on/off, rather than allowing configuration so maybe
> > > something else would be needed).
> > >
> > > From what you're saying 57-bit is all you really need right? So maybe
> > > ADDR_LIMIT_57BIT?
>
> Addresses will always be limited to 57 bits on riscv and x86 (but not
> necessarily on other architectures). A flag like that would have no
> impact, I do not understand what you are suggesting. This patch is to
> have a configurable number of bits be restricted.

I get that, but as I say below, I don't think a customisable limit is
workable.

So I was trying to find a compromise that _might_ be more workable.

>
> If anything, a personality that was ADDR_LIMIT_48BIT would be the
> closest to what I am trying to achieve. Since the issue is that
> applications fail to work when the address space is greater than 48
> bits.

OK so this is at least some possible road forward given there is quite a
bit of push-back to alternatives.

>
> > >
> > > I don't see how you're going to actually enforce this in a process either
> > > via an mmap flag, as a library might decide not to use it, so you'd need to
> > > control the allocator, the thread library implementation, and everything
> > > that might allocate.
>
> It is reasonable to change the implementation to be per-process but that
> is not the current proposal.

I mean maybe I wasn't direct enough - I oppose the current proposal as-is.

>
> This flag was designed for applications which already directly manage
> all of their addresses like OpenJDK and Go.
>
> This flag implementation was an attempt to make this feature as least
> invasive as possible to reduce maintainence burden and implementation
> complexity.

I realise, and as I said below, I don't think your implementation is
correct in this form.

Also if you can control everything + for whatever reason can _absolutely
know_ no program will use a FFI or a 3rd party library or whatever that
mremap()'s, I don't see why you can't use mmap() in a creative way to solve
this rather than adding maintenance burden.

A couple ideas:

1. mmap(high_address - domain_size - buffer, ..., PROT_NONE, MAP_FIXED,
   ...) a vast domain. You will almost certainly get the hint you
   want. Then mprotect() regions to PROT_READ | PROT_WRITE as you use (or
   even mmap() with MAP_FIXED_REPLACE over them), all will have high bits
   clear.

2. (suggested by Liam separately) mmap() with PROT_NONE addresses in the
   higher range, which prevents mmap() or any other means of allocating
   memory from allocating there. Acting as a 'huge guard page'.

Neither require any changes.

You kinda can't have it both ways - if you are absolutely controlling all
allocations with no risk of a 3rd party library doing an allocation outside
of this - then you can just use existing mechanics.

If you don't, then MAP_BELOW_HINT is insufficient.

>
> > >
> > > Liam also raised various points about VMA particulars that I'm not sure are
> > > addressed either.
> > >
> > > I just find it hard to believe that everything will fit together.
> > >
> > > I'd _really_ need to be convinced that this MAP_ flag is justified, and I"m
> > > just not.
> > >
> > > >
> > > > This flag will also allow seemless compatibility between all
> > > > architectures, so applications like Go and OpenJDK that use bits in a
> > > > virtual address can request the exact number of bits they need in a
> > > > generic way. The flag can be checked inside of vm_unmapped_area() so
> > > > that this flag does not have to be handled individually by each
> > > > architecture.
> > >
> > > I'm still very unconvinced and feel the bar needs to be high for making
> > > changes like this that carry maintainership burden.
> > >
>
> I may be naive but what is the burden here? It's two lines of code to
> check MAP_BELOW_HINT and restrict the address. There are the additional
> flags for hint and mmap_addr but those are also trivial to implement.

You're taking up a MAP_ flag (in short supply) which we have to maintain
forever across all arches and have to respect a limited map range.

And everything in this realm has edge cases. I don't see how you can
implement this correctly or usefully without a VMA flag, and see below for
my concerns on that.

This is UAPI (and really UABI) so this is _forever_. The bar is high. To me
this proposal does not hit that, and as you keep saying this isn't even
what you want.

You want something per-process so I think the correct proposal is
per-process.

A configurable per-process thing is horrible in itself, so I think the only
workable proposal is a fixed personality.

>
> > > So for me, it's a no really as an overall concept.
> > >
> > > Happy to be convinced otherwise, however... (I may be missing details or
> > > context that provide more justification).
> > >
> >
> > Some more thoughts:
> >
> > * If you absolutely must keep allocations below a certain limit, you'd
> >   probably need to actually associate this information with the VMA so the
> >   memory can't be mremap()'d somewhere invalid (you might not control all
> >   code so you can't guarantee this won't happen).
> > * Keeping a map limit associated with a VMA would be horrid and keeping
> >   VMAs as small as possible is a key aim, so that'd be a no go. VMA flags
> >   are in limited supply also.
>
> Yes that does seem like it would be challenging.

Right so to me this rules out the MAP_BELOW_HINT. And makes this
implementation invalid.

>
> > * If we did implement a per-process thing, but it were arbitrary, we'd then
> >   have to handle all kinds of corner cases forever (this is UAPI, can't
> >   break it etc.) with crazy-low values, or determine a minimum that might
> >   vary by arch...
>
> Throwing an error if the value is determined to be "too low" seems
> reasonable.

What's "too low"? This will vary by arch too right? Keep in mind this is
'forever'...

>
> > * If we did this we'd absolutely have to implement a check in the brk()
> >   implementation, which is a very very sensitive bit of code. And of
> >   course, in mmap() and mremap()... and any arch-specific code that might
> >   interface with this stuff (these functions are hooked).
> > * A fixed address limit would make more sense, but it seems difficult to
> >   know what would work for everybody, and again we'd have to deal with edge
> >   cases and having a permanent maintenance burden.
>
> A fixed value is not ideal, since a single size probably would not be
> suffiecient for every application. However if necessary we could fix it
> to 48-bits since arm64 and x86 already do that, and that would still
> allow a generic way of defining this behavior.

This is more acceptable. It avoids pretty much all of the rest of the
issues.

>
> > * If you did have a map flag what about merging between VMAs above the
> >   limit and below it? To avoid that you'd need to implement some kind of a
> >   'VMA flag that has an arbitrary characteristic' or a 'limit' field,
> >   adjust all the 'can VMA merge' functions and write extensive testing and
> >   none of that is frankly acceptable.
> > * We have some 'weird' arches that might have problem with certain virtual
> >   address ranges or require arbitrary mappings at a certain address range
> >   that a limit might not be able to account for.
> >
> > I'm absolutely opposed to a new MAP_ flag for this, but even if you
> > implemented that, it implies a lot of complexity.
> >
> > It implies even more complexity if you implement something per-process
> > except if it were a fixed limit.
> >
> > And if you implement a fixed limit, it's hard to see that it'll be
> > acceptable to everybody, and I suspect we'd still run into some possible
> > weirdness.

> >
> > So again, I'm struggling to see how this concept can be justified in any
> > form.
>
> The piece I am missing here is that this idea is already being used by
> x86 and arm64. They implicitly force all allocations to be below the
> 47-bit boundary if the hint address is below 47 bits. This flag is much
> less invasive because it is opt-in and will not impact any existing
> code. I am not familiar enough with all of the interactions spread
> throughout mm to know how these architectures have managed to ensure
> that this 48-bit limit is enforced across things like mremap() as well.
>

I just wrote a bunch above about this and did in the original email.

The 48-bit limit is much more workable and is across-the-board so it's easy
to implement. It's the variable thing or map flag thing that's the problem.

> Are you against the idea that there should be a standard way for
> applications to consistently obtain address that have free bits, or are
> you just against this implementation? From your statement I assume you
> mean that every architecture should continue to have varying behavior
> and separate implementations for supporting larger address spaces.
>

I'm against this implementation, or one with a variable limit.

An ADDR_LIMIT_48BIT personality I think is the most workable form of
this. Others may have opinions on this also, but it avoids pretty much all
of the aforementioned issues and is the least invasive.

> - Charlie
>

Sorry to push back so much on your series, your efforts are appreciated, I
am simply trying to head off issues in the future especially those that end
up exposed to userland! :)

