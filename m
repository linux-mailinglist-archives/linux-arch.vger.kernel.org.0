Return-Path: <linux-arch+bounces-7198-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10F2974329
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 21:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE0D288E94
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 19:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEBA1A4F25;
	Tue, 10 Sep 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mLePeWy8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ll24WDh3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DBE194C77;
	Tue, 10 Sep 2024 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995430; cv=fail; b=gOtvydKvuALRBdnTFkuqBYWGf60nAnPct3ZmEL0ggcUixH7WO8kYm1+Oe6CZ48MCsxkDv4kJ0VygPKrBA6fBs6v+qoqCjHRIrq1TkdpGuiou7T6vQ8aUPjZgJsXaAKsOQ7bLuRkm5yYWgG+XT3IaBC8zJ5oBBswif0CJf7TRKnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995430; c=relaxed/simple;
	bh=0zE6XJ5G2HgDbbO/6LEP2jT/Wnk+NLyP4kee7tyO03A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Npqla3iGb5j71vEeT+ijFDPl3/pCTKl/mkn+BWqHeodtb1CQRcQdUrjn4DD0+CzAcgT5qNJLySFeEeswPY9czv8nobfMKoCjnlkPMCi9rlfPKeSmozo7qVZrJuNTboHcDsaH11k3keGisDXbM6pTKZdETMoD3uhgxWOri87HCs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mLePeWy8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ll24WDh3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AHNY5H005825;
	Tue, 10 Sep 2024 19:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=0zE6XJ5G2HgDbbO/6LEP2jT/Wnk+NLyP4kee7tyO03A=; b=
	mLePeWy82gl86cVB0blfoFTXLpH7l1xGCkeRf4niBb7+bpL2f/qJvmr7RVtLAI7B
	kMnNNNOjxv7dMkCu9ruzrLGOpWnb2gSv/sfrh5S8MdhGV1vVR+UshdKWCFNP11aw
	Vgv7J7oGPFqmUqx3sbr/pHMT5zOfxiRvOqkNp3ZeiuJQxQpnH0cMtbRxgAhvyJXC
	3mzYExdjrCl6S89dZpMKP2FtnvlCZpBBWbF5YDwn1GHP2V0AwzObslhXNdHvdVwd
	MP00stCLvbU23mNGyjmHjT4yMFG2cBO1rkAkTQD7IUE/yzdweKe44b1SJzKabHdp
	Xlkq5Hdu6NCHRqrwYZYIUA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gjbup7fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 19:08:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48AHa6OE033545;
	Tue, 10 Sep 2024 19:08:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd991kb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 19:08:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVbc7uSxhmpWPgY7hh0IVhHXfUlifRjgGbR5ijVASPyfHscEms5IoQxWr96q8t5mNeBgtHDrz55KAvQ9Rzp8LdrsBBYgGIOTdb1gj5pG7nuoiCS9S9EPpv2Zaa7KATLqCMjf5iPs3bIa1CE5hFUvXeB7Nbcbb+4diybUcIU/7G3rSn5Co3Fj6Hxkvzo9cyDLkKA6pv56nFmlzKVubQbwvAmF2JQCdGiWsXn7GGxxB4z7Rf3VnNk4KOn/op4v+tExjDbJNtusxM6yto1+djinIc1Q7m7pNmnh0eTnrqjFsh9jLc325h4wmG0fZMDj0U5UQ8pF1046GzVhBRQwxN20bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zE6XJ5G2HgDbbO/6LEP2jT/Wnk+NLyP4kee7tyO03A=;
 b=W+8LpRvB1a1dsWinU+ScUliK4cqfMFJDfwhsWnNlEaCc17Tmx753/23I9uRYRGaL4Nx2hJoJzL73fTCcMpC1+QksYYPzHnCk+rB2r4mCJMWo8QyB2NaHqPLRaBdbvHuF3UkWE73QXR6PA6yW+mMdQK49apMUmH/K60Y84HVq6LJkPvIdjdsmUKWgehrTavfNecEmM1htTKlHC8s6ktuer+xwFmmlu93JfK6z54tEGuvDcbANLDeuv+YXb85Jdtw0uD8LyG+6YhLGYWzSZbFbsRLUE8wE0Bw5f8wMXEcBt9C/yHkKaPRC10JFeXcqwxiIYgr3AWj9kpP/Gw8LJkbiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zE6XJ5G2HgDbbO/6LEP2jT/Wnk+NLyP4kee7tyO03A=;
 b=ll24WDh30IWFb+Q8udpja3FLfixaLjlhp/M1AT65Kg9raItAopjBrm+ICfNDnl1mx8ju4w4Xt/2qJfo9w1iCSVhDn1q/qcwvQImwZZBTxnlXwfHfX7/+rxzOutswxEdvLPDFYos9geu09K/SY4FfYCqlGS++/D5zkVTcJVCcEJ0=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by CY8PR10MB6706.namprd10.prod.outlook.com (2603:10b6:930:92::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Tue, 10 Sep
 2024 19:08:18 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d%7]) with mapi id 15.20.7918.020; Tue, 10 Sep 2024
 19:08:18 +0000
Date: Tue, 10 Sep 2024 15:08:14 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, guoren <guoren@kernel.org>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, shuah <shuah@kernel.org>,
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
Message-ID: <oshwto46wbbgneiayj63umllyozm3c4267rvpszqzaopwnt2l7@6mxl5vydtons>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, guoren <guoren@kernel.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	shuah <shuah@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Michal Hocko <mhocko@suse.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, 
	Chris Torek <chris.torek@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-abi-devel@lists.sourceforge.net
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
 <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
 <9fc4746b-8e9d-4a75-b966-e0906187e6b7@app.fastmail.com>
 <CAJF2gTTVX9CFM3oRZZP3hGExwVwA_=n1Lrq_0DQKWA+-ZbOekg@mail.gmail.com>
 <f23b18c6-1856-4b59-9ba3-59809b425c81@app.fastmail.com>
 <Ztrq8PBLJ3QuFJz7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Ztrq8PBLJ3QuFJz7@arm.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0046.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::28) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|CY8PR10MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: 5714aaf5-8cc6-44ba-0e75-08dcd1cbee1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzMyR2x5Z1NiSmI1aVJWRGhsUThDWkszZW10NW5tc080ejQ1eHQrUDQ5KzNH?=
 =?utf-8?B?bnA3bFkrSmJCMjFGRTliUmE0Q2sxaEh0QmR3dXBBYkdSczM3Mm0rYk1OT1ZG?=
 =?utf-8?B?YlIvWjNJeFlOakhidUpXL1d3cTQrUFNBVTZBSFVxY2hhZDEzNVhHRHpqaW00?=
 =?utf-8?B?eHJLN3hzNTdBa1RhOUYwV0EvSS9nWjBNNkhGZUp5NjZLdWVIQ0NHRkVEOEVu?=
 =?utf-8?B?OE1hQ1BSV3dHa1ZLNExCQUFFRGR6aGZ0TDFhQ25RWk5JS0VIWkFscUYvaWhv?=
 =?utf-8?B?WEEwYlBXTHl0a3ZYK2ljallxdnphTHdNYTZwZEpmTzRlQ2s0YlpSUnZzdytM?=
 =?utf-8?B?b1c2bGplSVFCSE05RnZaYzdUYlVCZnk5YnZSZHFVeFVob0pXUkRTcjBRMDBz?=
 =?utf-8?B?Y1Iydk5EMUg4QWMrNTF1RU55UGVHT1MxcUpQTExGOUptYk9EaGdjZzZGTzlU?=
 =?utf-8?B?R0NDbzdNRWFpMjBXZmU1bW1oZHg0YVdQeDNKTEdhaEp2N0IrTzZyalczWDUy?=
 =?utf-8?B?RkpBbkxHZ3BPckFnS0lrdFhhcmdyUEJXTXhzNGNaVHRhckovalZjcGd5MEho?=
 =?utf-8?B?NnRBV2xyVFlNbUVreW1JenpEanRCeVY5b2hQSGNCS2F1cHpXTVNDQXg0dy93?=
 =?utf-8?B?cUsvZENLS2poVmdaZTJzYWNUdXVlaG0yNWMrR3JrZVAyZnRPdFhxT1BscGtG?=
 =?utf-8?B?Z2M1VEZHWXVLcXREb3pjMFovVSs2LzJUc1lmemlEVVF3WXNXdEpCNzZRdkJo?=
 =?utf-8?B?QlVVSVNzYkFJYnN5SFVsWlN5LzZQVmFJRktBSU9ROWtOSzBaNkVwVC9vZU9z?=
 =?utf-8?B?SlVTQ0NGcEJUdHlWWGltM0o5cmxrcGFkc3V5ZHR3K3VHUmJCc09mSE5oa1RK?=
 =?utf-8?B?RjFhOXdZUmZlbmJJZ3NkWHdISzFPbUh0ODlsdGFvK0V3dTUzSnE3VzlpMy9w?=
 =?utf-8?B?TVorY2JTcEtpTHRhdjV1dGl2QWhxN2RYcjk2Tzcvd3N4MVhadi9lT0ZkQXlD?=
 =?utf-8?B?ZER6bzNldS9Rdjg1dXlzMHdIM0FSK1dQaGZmSEx0RXFuWHNDeFlzME5lV3Ri?=
 =?utf-8?B?WnRpYWpxeldoWWhzSERxOEd3d1FsYUVkUmpRbnlRSmU0RzN4bEdweVBSOFBW?=
 =?utf-8?B?blhncEpERmFWQ0JEMkVhVytyQXlmRXdzQVpLU1JJWnFSckQyMTVEazJZZGRl?=
 =?utf-8?B?eGdGa2NSblVzMEdZUThLY01lSmQyNzlpeTdpeHZtbHdaQkVTN3ZNZzNyTnBp?=
 =?utf-8?B?anRQQTd3bUhvVTJTUnlybFF4WFB3ZUY1R2ZNNHhzQ2NnZXJpakZhWkszcFdF?=
 =?utf-8?B?SW0ydWwzNDJnbkNvR2JDUUR5UHgrK0VKeVJMSFpySnBiRlk4REZxbDlNWVdm?=
 =?utf-8?B?alZJcjdEKzZCR3JvT2xZSFdqbUNsczVkSlUyM25GelNVbit0UElGN1UxNE9o?=
 =?utf-8?B?b2JuemNqYzZJcVBIbVNObEhaWUJ2Rk5lRUthUW5zdnlGVDVMTXUvNmxxOWtM?=
 =?utf-8?B?eGZVU015ZFpCMTZLdFoxdzBTenZQK2VReVAxVkRRNVU2R2dTVEFiaHFKYUQ2?=
 =?utf-8?B?Zm1Ub0lkdUZZcjJoL2lPWklCRHNGZmNOcWpDZk1BUXhkNlladmR5dFozUnVQ?=
 =?utf-8?B?YVk1MHNhT21IRTdtbnhCOHErTUQ3QThqUXRGbmViemNoVm5PUVBzTnNadTA1?=
 =?utf-8?B?dW1BUFRGNDF1ZnE4Rk9DSEtYRVU5QkE5WHprYS90T1A4Q3ZYSlZxeGV6TDFu?=
 =?utf-8?B?WlVTS3Y1alovU09PQ3hqMEtTdUpjaHovVk9HTEtKWWR5U2dIVHFvL3VQRTgw?=
 =?utf-8?B?R0dpQVp5LzRhVG5ZOWlIZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M28wUFU4TU5ndzlxS0ttUFVzTjU0QXU3N3ZEMzN4YWc3WHZkVWorR3ZoYitK?=
 =?utf-8?B?a1Y3dUYrVzZVYlpKL0h3ak9udVN1SUh6NmhyYkYvWEJ2QlNOZUlKcE9VZmFH?=
 =?utf-8?B?MnhRL0FVUDVWS096S3BZSmZRc1lCSUpoOFVkd0txcTVBTVBweEFUQlpMRkcx?=
 =?utf-8?B?Rkd6TDJUeUI4S1ZVS251RUQxWWFkNkI2d1FiSnVLelhrTzdBYXZDbEc4UkF0?=
 =?utf-8?B?eUdCRlhwdTFSQVYwS055MVBzcWZWQjByNDZrS2FKdlkramN5ZjlCUHQrOUhX?=
 =?utf-8?B?eVR6Q3Z5NllLRm8yNjBDUlEyMFNlQ3dDYmZzOVFzMU9NbnF2K2xGN09MUmQr?=
 =?utf-8?B?aUlya1BtRVNlQ1lkalFzTmpRTXg5aWRMMmZlMTlWT3RpcENuaTFZMWt3aDl3?=
 =?utf-8?B?L1FSYkVQbjZHeTB6eEh0YlFFQ2NkVTJkeUFhYU1zaVhOeFUrbzhnVXExNmtQ?=
 =?utf-8?B?Rm4vcG9TcWZ1VUt5MnJ4alg4VUZQaTZlTForWlppZjdqNVlnMUNjYXJlWEx5?=
 =?utf-8?B?OEFmaWZkRUFIajV1UlZxbjB0aE5IUkVQY2JwbWgyQlJ4d0ZzQkJ5STFJbFBZ?=
 =?utf-8?B?bXRuQmlTS3ZJNjczU2IxQnFxU0J2UlJGOUt0ZVFQNDRPS3preHJsWjZHOEtD?=
 =?utf-8?B?RnRHK1dXT21RWlY4dGlKeXUzR1YyZ2pYOWRHNXJzOWUwSU9EYkxMdWUvNml4?=
 =?utf-8?B?RHlJL1FsdE0xa09aMXYxTzBwb0t0SWZ1TDdBMmZaamsyUENRSExDeDJzeDN0?=
 =?utf-8?B?ZUkySGo4R0E2QUkzOG82U2t4M0ZaRGJzUTBidXZGQ21wc01hMm84NUd4MjNS?=
 =?utf-8?B?OFpBaUhPTE5xVVhmcFBLbUloejJYTkxKK2FIdU9DUXBSV3J4R1NHSkFtaGcx?=
 =?utf-8?B?MmVRZXUzcVBhb3VPS0daVThRcmx6MDBCbjdKS3NMU0poMWIxSFBJOHhMc3JI?=
 =?utf-8?B?K2RpRm9tU3M4UDNoekpNcjFMWEJ5MnhZSG5iSWRlRENQNGJhMnNsdFA1b2c3?=
 =?utf-8?B?L3pJbHRLQ1M2d1VzKzNodUJ4UmFBSWhoVk9YZXBxT0cvMnpHRUEzVENQbzhQ?=
 =?utf-8?B?WlpxdWNFU1ZMZnNqM3pjVWsyU3IzZTNhNUROc3ZCcWtkUE84ZmhMWC9ZYjhO?=
 =?utf-8?B?cGppdHlTcHUwc1pwUnpQaVBzZ3IzaGp5N0NmRkJ5Z2tzQjVzbmx6dXVIKzd3?=
 =?utf-8?B?T3U0NCtFbVhMUTd4dDEzbzVhMmE3STJodGFORCs0cGFzeFB3NVQxUW1qazgr?=
 =?utf-8?B?ak9rdkNMNWZ4RFpDaE1VQ0wvUG50Yi9GNDU1cDRZczgyVnl6QndTRFpLUXph?=
 =?utf-8?B?TFUwSGRFR1lrTDJPcmtHaHFYTHJ3SXEvSUNmUzREa0l6Y0RnZVI0N3pjVllN?=
 =?utf-8?B?R1pPSFAwRkZEa3VJS1kxbTdXVzJ6b1FNS1gyVUFVMzgrZE1Qd3JmQXE1cEYz?=
 =?utf-8?B?S1ZYSHk3aWpuU3FFZkFNK3R3aWpzNExrQ3ZpYzhNcmhaSlFSY2VMWFZOaFNz?=
 =?utf-8?B?Z3plaFhXaWx3T0JpMDJib1dsdzNpaklpZmIwS25YRysvVE00Wlhxa1pUVzRJ?=
 =?utf-8?B?WGJhZ1ZiSkYvRXN5ZWp0WXZ6MU51eXNRZmVMRmFpQmlpd2pFeUFTY0ZyUGQ0?=
 =?utf-8?B?d2xEQXR6V0FlVXJETTc5T1FLZzN0WWdZK1Byc0tmemw0TUxaYllZOS9OZlIr?=
 =?utf-8?B?NEVnUXMxSWJ4bXJIYW8xcy9naFFDaUJnOXU2YnViUHA0UGMwOTV1aUN6K3pH?=
 =?utf-8?B?U09XM1BwOFNKbVN6SmN0T0plck1NWi9jajdLRStzNytxaXlvWGRFOGk2MVYr?=
 =?utf-8?B?Ny8xZElnRndTbWwrVGgxMkZlVVhxYkZ3UWlldWcyNGJ5aENPZnpMNmhkeFBt?=
 =?utf-8?B?cjQvczZqc0FCei9nNjU2amVkUmQvOGxVNi80VEUvWk40VWhSWmdOa1FZTkFD?=
 =?utf-8?B?aU5uSnRrNFd1ZkVSSmlTKzRXZWkzSDVKcWRMYmdMUXpJZDd1aUd2UHZrRlMw?=
 =?utf-8?B?UmFMYjVvQzJQS2phbnFlMGd0QlF6RmJTZHJuc1FOU0wzRURNZTZ3UmtSaWlH?=
 =?utf-8?B?S0hOaGlpU3dBVjBwM251RlRqYVBiQmsxVnFlRjhMZW1Pb3VKQ3ZCNm9zOXE5?=
 =?utf-8?Q?0oEKy1t8y7Fd+TlTDFn+YrqpM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oxwMGhdRZVKdybHTaNCBD8LRDhy/rI0aYNVJF9PRSldPWnU5rwA7kZMx+WAz/8humzhM5JvfFyKc4JPCs4BRMCJe1yfUsQYQbI6vv5AGhXfpXDD1RttRNzPKSGssVID1Cx/rR+T/al3Qt5XVBVnmCgfmcDnz9I/6cPAngC5bp5O22EL8aqenv7G9+nCH3qBNIYgOxI1VtWRLhe8WEfxrEJOX3sF2lNzOaGyqhfojdoUB/qrAqp9yv8HM2yVu/e/NJPlMiYdB2Leumk/V7i+XJFvgWxXgS3O8C8TssMoQclTMZwS1Yn8DiCntQdaC7ABzmTkBnuWV97i/x052t4U8jfznxuuOg5QZFcwYGw0+3vSIZRJ7hCPYNObkFeszfGHJ23vDw7JEyIdSbX1LYLnNMOwA2fbuyUp5wa4lb5JY1/aPkYIdr0O8QvfH68QVLC8HhH4Hv7fFjfqH6IXysPrMdY04lwzUJ4Pb/mdtV8gzES7qtyZGepDra7gDynpLsDk5JPMQ47kixZ34IZ22DWaUEK8+5lyr2XjaQ6arSwc+dUDEJ14meNZ5L12xC8iisz8HMkBneZTQpp3LX80zMN5eXxAOiB2jBvz5oMJ0V1NbiPY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5714aaf5-8cc6-44ba-0e75-08dcd1cbee1b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 19:08:18.5124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5flw2MUoYRqDWRlg8rzfX4pv5JCRY/drXo7k+IM0bEbGSgkplXGPaim57i+6JqJiDxvUYFuxeYUHwo1zRkKOcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_06,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=897
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409100142
X-Proofpoint-GUID: hyb9fM_VkBAwT7pgXbXBzXO-kOv_X7to
X-Proofpoint-ORIG-GUID: hyb9fM_VkBAwT7pgXbXBzXO-kOv_X7to

* Catalin Marinas <catalin.marinas@arm.com> [240906 07:44]:
> On Fri, Sep 06, 2024 at 09:55:42AM +0000, Arnd Bergmann wrote:
> > On Fri, Sep 6, 2024, at 09:14, Guo Ren wrote:
> > > On Fri, Sep 6, 2024 at 3:18=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
> > >> It's also unclear to me how we want this flag to interact with
> > >> the existing logic in arch_get_mmap_end(), which attempts to
> > >> limit the default mapping to a 47-bit address space already.
> > >
> > > To optimize RISC-V progress, I recommend:
> > >
> > > Step 1: Approve the patch.
> > > Step 2: Update Go and OpenJDK's RISC-V backend to utilize it.
> > > Step 3: Wait approximately several iterations for Go & OpenJDK
> > > Step 4: Remove the 47-bit constraint in arch_get_mmap_end()
> >=20
> > I really want to first see a plausible explanation about why
> > RISC-V can't just implement this using a 47-bit DEFAULT_MAP_WINDOW
> > like all the other major architectures (x86, arm64, powerpc64),
>=20
> FWIW arm64 actually limits DEFAULT_MAP_WINDOW to 48-bit in the default
> configuration. We end up with a 47-bit with 16K pages but for a
> different reason that has to do with LPA2 support (I doubt we need this
> for the user mapping but we need to untangle some of the macros there;
> that's for a separate discussion).
>=20
> That said, we haven't encountered any user space problems with a 48-bit
> DEFAULT_MAP_WINDOW. So I also think RISC-V should follow a similar
> approach (47 or 48 bit default limit). Better to have some ABI
> consistency between architectures. One can still ask for addresses above
> this default limit via mmap().

I think that is best as well.

Can we please just do what x86 and arm64 does?

Thanks,
Liam

