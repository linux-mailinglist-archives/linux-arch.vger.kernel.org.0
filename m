Return-Path: <linux-arch+bounces-8105-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C9F99D772
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 21:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4614C1C229CE
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 19:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3901CCB23;
	Mon, 14 Oct 2024 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OE1+mQ26";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aMDXs/2l"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F55C1CC893;
	Mon, 14 Oct 2024 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934078; cv=fail; b=JEXCTLvVsZc5CYOXMmsKJ45GmtKxwI8d9qmiTy/vBf5yiFx+Fy/QpuMbLt+H4EkgUeaLDJiwBe9XyAYChiUD9FNr5/UVc2YXpIKPMeKOnL7i/wl8+mUaU6RVisvLiUKlcw24DYk32FYytf2L6K55adnkKBOIOye6RT6Q8wXexHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934078; c=relaxed/simple;
	bh=5/YmWLDO240PXQe6wN2u12mccRtG22SApHl7GoiXUnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PScQikT3YhxqqdQ1UjHbhRH4lRW6YU1uA7ITfNPgqQhgyxBCEAXQY64ZZFoL52VDD3KGd56JWuN9CJLPcnP/N+id+yAqvDzIy7zg3nmJSmpruoJm71KVIU8dT2TdwSx733eCykGSzul+X8YFTgZ610yJHbc6qVdKSmgcCkctUTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OE1+mQ26; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aMDXs/2l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EEfdO3021139;
	Mon, 14 Oct 2024 19:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0li3HtLffaAQBVxTERLQffB9N5szOYJOEa7zPXeDdh4=; b=
	OE1+mQ26dx/LTk+t2RoPD4/YVBc+WC37f4d6fy5Nrv3+3ExDhI16d3xxi98S68Bz
	gFgLmf6eDupAgDHk9dAxxzDjJ0gd1rkdsvza+zunbP+wHp0z+EBJi43kmjO2Hofc
	LpeKsg1VwluplepEEIWsKFOOLVMJsTzYDjEwOxrqoBcJjs3mUVYalgjof79IqOkB
	ByIBNIjQ9xMgzgxgorSy6k/at0Yo9176hEtEICx6A7NK7lyoJ1fZQzg3RI+Sa1+M
	knYLC21GbaT5Z/MBCJZgKi94Vzf+689/45nPMSfOpC+VuHfD/EX1JEb2uJoS99aE
	DbYiIsc03Alhf3hSWtvgFA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cfcbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 19:27:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EHls9Z014021;
	Mon, 14 Oct 2024 19:27:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj6fyxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 19:27:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQusbnOmo29NW7PP9nRuK6rhT8w2Ce9zlGJja9mTSqDw1nqanGZ+VqvI+n93S61ijSaRpRNh1kPqEMJgsAE79+pWExJX5prlDEK30FjKlrptuw/XD+vJ6mp+Q2e9pEyx8APIGpr/o5gFUjDXyTT1aUYafEil5GaWuqHUx0Xhcovzhtqvi6hs8q56MlTpC1G6RWqgHLBjMDR0Gc4GyEOq378f4MvbYDFia7YDba+E1hJDo04VppYl8BzDGyq/N7QzK3Xlq6+DTkJx8Yu0cAcCIxqIP5aTJqpTZeVdJOgymIHgFwtrzfrdyDLp+9TgnbGLZ9LyQ+Rkr28IicYqbKgXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0li3HtLffaAQBVxTERLQffB9N5szOYJOEa7zPXeDdh4=;
 b=yxFua4SHr/8ZAwB0nMtVdge8rVn1NJUiJdUV4PDY+Qd9F8KCcXdYk5tE2HJCz1GiVLLAmLf2R8PD6vM6HXnXLSVtpUCcmQbjre4z3uYj6bnNvhFD396fk5QwMn+YUSCAXI85KyU5eEkQjrH8G+IsDblrLAp5wDYPiuB6v6EMEhKMzXYZqb7hVxGXd7Kv0z85jJFfC2hUwEySFvIQD33wTZJ6s1R/STg/cr4/dO24gtgTRF68eWgbwYGode1Jl/CcQy41rsJzsIbmFeDmOZdkWAGNkI284D6g64GgnZ1sJvBVSR6H4NUPdTnwZjtBFwA8v8BGAVWBwBQ03iApY2n1lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0li3HtLffaAQBVxTERLQffB9N5szOYJOEa7zPXeDdh4=;
 b=aMDXs/2lKkn1lOfMGfian3exmq9zgw/ietNht05q0VlFXoiqI8AbeDmDBuNPeM2P68d/8WYj4I03PTp7QEaKKMVUSofPm4rKVdmHAIj9ZHiOE/hK7ivjueX/P1c5FnJaR+BQnUmmhE1HfB1dZzvqrZ8KV5zPSrjNjtYrIZN/Dvw=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM4PR10MB6695.namprd10.prod.outlook.com (2603:10b6:8:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Mon, 14 Oct
 2024 19:27:10 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 19:27:10 +0000
Date: Mon, 14 Oct 2024 20:27:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vlastimil Babka <vbabka@suze.cz>
Subject: Re: [RFC PATCH 3/4] mm: madvise: implement lightweight guard page
 mechanism
Message-ID: <87ef1f6b-1da9-4a84-9419-5aa8cf9de1dd@lucifer.local>
References: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
 <a578ee9bb656234d3a19bf9e97c3012378d31a19.1727440966.git.lorenzo.stoakes@oracle.com>
 <CAG48ez3ursoL-f=mYpV79Do18XPPt+MPPHNUBv6uFE1GhpOwSA@mail.gmail.com>
 <868739d2-0869-462f-ac86-1a8d1dccb0a4@lucifer.local>
 <CAG48ez3vqbqyWb4bLdpqSUnhwqGo2OQetecNhEGPdCGDr94nbQ@mail.gmail.com>
 <b483187b-5caa-4581-86b1-895184301cbb@lucifer.local>
 <CAG48ez0pCasCQ_=ALog7nseKnGci0o0LyQehV42J==gNAiXBVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0pCasCQ_=ALog7nseKnGci0o0LyQehV42J==gNAiXBVg@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0323.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::22) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM4PR10MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: 97cb87e3-186d-49a3-634a-08dcec8632ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGdlL1J2cGNsOGlmVyt2NEFHMGc2ODNVVWplR2pJUnZTd09MeG5BN0h2OW8z?=
 =?utf-8?B?UTh0RHNNZ293VHNwaEx0K0RDaUJBUUpLdW5hMGVzUFhJb2ZnYXp2dmlCeEUz?=
 =?utf-8?B?bzhkSm9BaEdDVG9aZVZuazU0anhEZVMxL1k3SFdwcFJoL3pmcDg2MlZTVkdU?=
 =?utf-8?B?MXJwdUtIQ1BINFA5bTBUY05YaHFLaDdrY3c0dkUrKzBtTHZqMzF0Y05tc2JS?=
 =?utf-8?B?UFJlTUFqaWt5YUtVbzFvRUNlNnJLVFM0dkVNQ1lFdEdpRWFLQVZaR3hpbWV6?=
 =?utf-8?B?Sis0TTJleUR5M2FuTnpJcWVsZ3E5ckhKYTA3UHIrVzlWVkh3ZUVwUkdCQTBk?=
 =?utf-8?B?OXF4dVVpcHZOZTFETzIxVVRqZVczVUhQRSt4SFFmL3E2ZEt1SVBYcjF5djRZ?=
 =?utf-8?B?QVdtb0owaUJIaHpoUDJ5YlV3TW1RRWN5d2tORlhCS2Rrd2YyU2dkUFhBLy9X?=
 =?utf-8?B?dUdmNkV2ZmZVendzVDJXbUcvTHJwN3hLNkJZUGxwR1N0NkMyN3gwbTdRRlVy?=
 =?utf-8?B?NXM4UmpGU0lrMDB1SDkvcnZzL1ZBY0JHNmI3U01vc2tOV3pJTkRzRXFYYy9P?=
 =?utf-8?B?Z0c0RlgycnpLVmVwa1dDM2drbTEwWEdOc0x3MjRoa2FiQUVQeVUxejVtRFhr?=
 =?utf-8?B?Q2pPNS94VGRRb3BRd1ZHNFlYS1Vsb2l1UWNGT2NjQ0FVT25YY2VYWGFrMnBH?=
 =?utf-8?B?RlI0Y0pQVFVsOWcxRWdBUlcyQy9xMVZ3RmZldWx6MUQ0bldIZnQwNDd4WHJu?=
 =?utf-8?B?YlJ0c1kzM1BsMVZtQ0JyMVNFWVZxRXVvK3Q5dmxGQlM1Rno5T1FkRUdBb0g5?=
 =?utf-8?B?MC9jOVRzcnVlNjY0NmZNZ0VkUi9oVjcyNmsvOGtNTk5lRUpSSFFkb2w2aFdG?=
 =?utf-8?B?VWxISXBGeHhFczcwNmVha3VBUVBTcGJjRnhBQllQTUltd1VPOWVpbzRkZ3BQ?=
 =?utf-8?B?d2x5OUJGVU1qaEFxbG1ueVBndkRMcUduSnNXbGpxSlp0eDhxU053RUpRQ01P?=
 =?utf-8?B?ZHVwZFE0U0QzN2ZDRU1uSW14SWRFYXRqT0ZURXhkbzNHWnQ0d2tVTHdWb0k0?=
 =?utf-8?B?Z2t1NDNsVHdjZWowN0dSZ0plb0cwZnBPK2lKZVNOZHF4UEVHMVduWU1NSnJq?=
 =?utf-8?B?R3krcS9MRW1Ib0NZMUlrczBwMDJ4QXRiWFphWlA0Z3NHaVVSa3BLdzlsWnM1?=
 =?utf-8?B?OXhaZ0Z2bmw0SUJLZ2lCUVZjNnRScXBqMlJVNDVtY243aFpaRVZLclI1T09m?=
 =?utf-8?B?aE85ZFRzdUZqT0NLMitmYThPR1AwVUQ4NGFvWWdXVDgrTjFBVWJQM2ovclpV?=
 =?utf-8?B?U2dvTlJ0NTlob3ZHdXdzeDVLc0xYbjF0YVQrMFJwRHhuQ0p1RXY5SUNueFlx?=
 =?utf-8?B?b3o0bWlJcHNLQjc5blQxS2NUTzZpMTAzVS9md2hPQVphckI3K1lZT25SaWt2?=
 =?utf-8?B?Q094UHZEbkRXUUpSS0k1Y0RtVWM1aFZLbzNOYm1HTXFJbzRWNm1sNU40RWR1?=
 =?utf-8?B?RFF2NUlaL2dKMnJ4NGVIYklUUUVFaHZLSWhYMHBtR3JZNW14UzhaT3J5cHBQ?=
 =?utf-8?B?SW9ucDd0Nkc2dFFnSS9oUkZqMlFPdEtMT0hwRGF6Q3RNK05JWFpGWmlsQ05J?=
 =?utf-8?B?LzlNSDBtN2NuaFNxbWF3aEpzWWVCcmMzQkFGWk1GK3l2eU1VRzh5bWloYkRT?=
 =?utf-8?B?eWhyR1dpWTdwb0JkNUQ0YWsvaThQUTZvelhSTUU0MlJsM3Z0RFZTUGxRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjJ3ejVCaS93aW1jQ2oxb01uQ0VTeGtBNUNMaWR5b1NsMnhsdklLdVZEaFFK?=
 =?utf-8?B?RWg4cnAwTTNhMEZ1UlFEQm1QdG1BcWZOVjJZcksrWmpucDR6Y2dMWnMvSTNZ?=
 =?utf-8?B?U05TcGVUamNybnZrSWVGa0d5V015eG0rNkhYcjlhMElaK1B2VnRWeGxKNk1E?=
 =?utf-8?B?NW1FUnhpWmgyeHV3R0RBYlVoeWprbTZjZUl0MFZiQlFyUm5CLzhDTXJVWnpr?=
 =?utf-8?B?UENwMHhvWnoxYlM0WDJWdVp0dXp5TkNxdE1Fd2h4NS9LRHZkdy8vb3FHVUU5?=
 =?utf-8?B?K21aRWM2Vm5jTzQ3bTJ2U3BDNWpVWHd4a01nVTNiY2JudmRidGc3Zm9mZGlD?=
 =?utf-8?B?bFJFRFdNbjdqZmZTUDhuWlZaTlN4Ti9CeWo5RlJzeWlZZEJOOUJ2L25ISXE1?=
 =?utf-8?B?RGt3ZkROK1NPQzM1Tm15MVlSR3p6ZUgzYVFRRW1YckFZSkcvdXQvMWV5RTRT?=
 =?utf-8?B?WE5Uam9lWDgvSDNQeW5KWUVOZEQ5LzNkRVFLZE1lblFNVFZVMGR1UU51Ti80?=
 =?utf-8?B?c2IyY2JMRy9JWDNTbEtvMzErbzNXbk9CNE5sc01HemdBcmFqQmhyMUFmcmxp?=
 =?utf-8?B?SVEyRHprRVIrVjJVK1dyYzRFNFB5NXJzUlhCNk0zbm9uWVBQNm40WlVBNm1G?=
 =?utf-8?B?c3ZQcEdGeHJLZFVHSk5iZHZ6TWVMYmZPdXA2eUIxVGtBalNPWTRmWkJTTWsr?=
 =?utf-8?B?bGRVQ0Zva2wwdmZZNXVMY2YwbkRyeXFqekVnQ3lnQWVQb3BibVF5K2hGVWxO?=
 =?utf-8?B?YUtlUm4zSWtySXhSanlHeU1sTzJjL25QelBkbmRmclk5Z1g1L0lMcC9yT0I5?=
 =?utf-8?B?ZjBFUm1iM2VlYzI5S3BVay8zM1AwMjNJNjF3aUo5WXMxaVdER2pjRVVURFV1?=
 =?utf-8?B?V0JLNVRuOWRVZnp3WWRRd3VXbVhCK3lkMHhlaHMrUnVtbjdLczQ2ZU5kbElp?=
 =?utf-8?B?M2NxRG40blNkSWJWUlByVHVNYld1eFVWVGRJbTJOTkpBWGYvRkx4bVRRdEV5?=
 =?utf-8?B?c0daSHJlcG1uenYrbHdPS2srZDNWRmVZNnEya1VpYWk0TFBwTEROTjNIVitH?=
 =?utf-8?B?WjkrZUFqV01ZeGRGdkVtekU5MWlLUHNDdWJxTDZRcGxMTkp6TG9wQytUWWtJ?=
 =?utf-8?B?Y0dmVGZzUTJmdGsxUGtFVkpFeVkwY1pxNUV0NkZRazcxcUVEQjFjVW1hNXM1?=
 =?utf-8?B?Rmo1QnQ5VlpzVnlIQ1hReWRQc3hRQ1kyblM1bHg3THdsczBtdEo5L21VZWRG?=
 =?utf-8?B?WHl0Z3F6YUNjWFF2Vm9SdXRpdjdabTQ1R092YzZSM1R4RDVmY25IODk5SzEx?=
 =?utf-8?B?Q3ZNeksweWVmTitpemRJaEFpNEd1YXdZUGJnZW5HRWZSZUNHTFJzTU9ucUV3?=
 =?utf-8?B?UmNVU1VUWS9oTHI1blRxZzJjQ0hZYVh0bHFWczVFVE5NWUhzWk9rclAzSks1?=
 =?utf-8?B?SStUanVKKys4QjBhQTQwS0hmVTY5ajRyN2YrSGc3bFZ6SFErSm1XOW5UT3oy?=
 =?utf-8?B?WGw5WDNnUUZUUlkrZ1hyTzQ4NG5ySnhZc0tld0ozcDNvRjZNQmpGTGhEU2lP?=
 =?utf-8?B?T0dOc2pwSWloTFVxTnNzTndkTDBTNWpSc1MyelJncVVJZ203TGVmQnpwQ3lW?=
 =?utf-8?B?MHpXUU1XblEvMy8welJTM0pRZHpIc051cmVSeGV6c2ZicHNIODQ0WmRqbjVT?=
 =?utf-8?B?bGhiSHBYWGhqVEJQYjhDMFErWjBncWVGZ3dzUGRhRmx4OGU3K1JqR1lhTkxy?=
 =?utf-8?B?cUNNekRmNVQrS29vNkJ0ZWVQcUkvSHR0blpWRmRTU1NabHIzOGJKcDEvWTJo?=
 =?utf-8?B?TlJkS2I0bXJDcW9nSU44T2NtTUJmc1I4a1kySXJDR1dMaWxtTzAxdy8zT1Nq?=
 =?utf-8?B?bHpmQ2lXQjRLYlFkVHJSbkJnaXZkZGtNWDRHRWtEUEdrZHBDbDhOcGN0VFhk?=
 =?utf-8?B?VWd2bW0ycmlKTE83d0d5bklpWUkyRzNVNG5DVkNYZGdRMXR3eWpINFdsWHpI?=
 =?utf-8?B?VlRmeldGRlN6WTl2bzErdFlJaWxtWHVyTkpqejdTSDI1Q0dWV2U0VnJtZ3NH?=
 =?utf-8?B?bGdzb2J3V1NNOGo2VzdBaTcrYWpOeGQwZi9yK0hDNmxaeUh6emVBdlJIL1Vx?=
 =?utf-8?B?S0N3Z0J6dk94VG9RemRYL2xDaUxxWHAyTG02ZjJtREVvSUNxL3lBeURLbXZ0?=
 =?utf-8?B?TGJ6V09hekpyenhLbllIMzc1a1dvR05CaHdzZ1N0ZTBUV3kwbW9OWUZyT0Ex?=
 =?utf-8?B?enJMN1ptZElvdkN3TC9VSkVQUCtRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2KNnudLdJNfvApPXF5hA32Ah9khQStTm4UlNFQ8KA60PQy5kIpelY+rtJdpJxfXIgAYtS64Vghk7KI4doImPZ3oSUyH7AjFdE9XajJtVffhh2r567YFrjtXNEj9GBBmxMjIPau86qnA7VtHqyrHPLu/qw/uFOnvYljxCO3lcfz8b2ioWRsjsgDrmdMY3+DVb5clSZy3iH+WRvD6DXcL2XfpbCwH7H687n9GpwEutMnUROSZxIsHCaScKOmX7yzuXI30HjJYxP5QHTJOGaus/HvJ/lWIfPYjRDm2Pc2BVuwhNagHoDz4dtv1E4erP93bFN10vmWKGNhjR4irzgsXKzKJUMvXllWUu/a2V5XIMyr4wdCdVEsuzARUiTCNk/Z+YQVQI2sTR6Bi+mx7Smk1fiSC74kkD2Xf294UR5dpoMynDMg40IWpHoP9hAk0xL6SlLuSAmCNmCW9/tdQQ6fwZQQW59dzVae1v/t+RDFdaEkp0ZL3+knPmFIqo8Da8USOba3OcwLMxaOfYLOaLr0+YnUq0FqPHntUPr/Nrhx1O8WUVpP0Ocs+KtPAk5MaDplHOE+RbMUrdJgq8ns7G4Gq+/SmEGeybAWxRgRIZaamq79A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cb87e3-186d-49a3-634a-08dcec8632ca
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 19:27:10.2522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0paCkaihX2N+XTOCzRzNCddTvytWnqZVKXxZvs9i4s1CI7u0XiTuQ/ce5z2LwfU9Rygsa5oZD4Nwk8ynvqo0KCjvlSrG5cP9Kf8MDuTH8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6695
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_13,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410140137
X-Proofpoint-ORIG-GUID: lSe9niA0pJI8cvLB_DulVSWzLmVulLDl
X-Proofpoint-GUID: lSe9niA0pJI8cvLB_DulVSWzLmVulLDl

On Mon, Oct 14, 2024 at 08:14:26PM +0200, Jann Horn wrote:
> On Mon, Oct 14, 2024 at 7:02 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Mon, Oct 14, 2024 at 05:56:50PM +0200, Jann Horn wrote:
> > > On Mon, Oct 14, 2024 at 1:09 PM Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > > > On Fri, Oct 11, 2024 at 08:11:36PM +0200, Jann Horn wrote:
> > > > > On Fri, Sep 27, 2024 at 2:51 PM Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > > > By being optimistic and simply having the user having to handle looping
> > > > which seems reasonable (again, it's weird if you're installing poison
> > > > markers and another thread could be racing you) we avoid all of that.
> > >
> > > I guess one case in which that could happen legitimately is if you
> > > race a MADV_POISON on the area 0x1ff000-0x200100 (first page is
> > > populated, second page is not, pmd entry corresponding to 0x200000 is
> > > clear) with a page fault at 0x200200? So you could have a scenario
> > > like:
> > >
> > > 1. MADV_POISON starts walk_page_range()
> > > 2. MADV_POISON sees non-zero, non-poison PTE at 0x1ff000, stops the walk
> > > 3. MADV_POISON does zap_page_range_single()
> > > 4. pagefault at 0x200200 happens and populates with a hugepage
> > > 5. MADV_POISON enters walk_page_range()
> > > 6. MADV_POISON splits the THP
> > > 7. MADV_POISON sees a populated PTE
> >
> > You really shouldn't be seeing page faults in the range you are setting up
> > poison markers for _at all_ :) it's something you'd do ahead of time.
>
> But that's not what happens in my example - the address where the
> fault happens (0x200200) *is not* in the address range that
> MADV_POISON is called on (0x1ff000-0x200100). The fault and the
> MADV_POISON are in different 4KiB pages. What causes the conflict is
> that the fault and the MADV_POISON overlap the same *2MiB region*
> (both are in the region 0x200000-0x400000), and so THP stuff can
> effectively cause "page faults in the range you are setting up poison
> markers for".

Right sorry maybe I wasn't clear in what I said - there should not be
faults in the 'vicinity' of the poison pages, that is the range which you
potentially intend to protect with the poison markers.

HOWEVER this is problematic clearly for something like a userspace
allocator where you might be allocating small ranges that might fit within
a huge page.

At the same time, I think you'd have to get pretty unlucky - you'd need to
have faulted in enough for a huge page to be collapsed by THP, immediately
adjacent to where you are installing this poison range, which spans
multiple adjacent pages for some reason over the 2 MiB boundary (I assume
you mean 0x201000 not 0x200100 btw :P).

Anyway I think this is moot as I am warming to the idea of us just looping
to be honest.

There's a limit to how much can be faulted in (i.e. everything), and we
hold the lock.

The user is _choosing_ to call this function and if there happens to be
enormously huge amounts of faulting going on then so be it.

>
> > But of course it's possible some scenario could arise like that, that's
> > what the EAGAIN is for.
> >
> > I just really don't want to get into a realm of trying to prove absolutely
> > under all circumstances that we can't go on forever in a loop like that.
>
> We can have a bailout on signal_pending() or something like that, and
> a cond_resched(). Then as far as I know, it won't really make a
> difference in behavior whether the loop is in the kernel or in
> userspace code that's following what the manpage tells it to do -
> either way, the program will loop until it either finishes its work or
> is interrupted by a signal, and either way it can get preempted.
> (Well, except under PREEMPT_NONE, but that is basically asking for
> long scheduling delays.)
>
> And we do have other codepaths that have to loop endlessly if they
> keep racing with page table updates the wrong way, though I guess
> those loops are not going to always scan over a large address range
> over and over again...
>
> Maybe something like this would be good enough, and mirror what you'd
> otherwise tell userspace to do?
>
>
> @@ -1598,6 +1598,7 @@ int do_madvise(struct mm_struct *mm, unsigned
> long start, size_t len_in, int beh
>                 return madvise_inject_error(behavior, start, start + len_in);
>  #endif
>
> +retry:
>         write = madvise_need_mmap_write(behavior);
>         if (write) {
>                 if (mmap_write_lock_killable(mm))
> @@ -1627,6 +1628,12 @@ int do_madvise(struct mm_struct *mm, unsigned
> long start, size_t len_in, int beh
>         else
>                 mmap_read_unlock(mm);
>
> +       if (error == <<<some special value>>>) {
> +               if (!signal_pending(current))
> +                       goto retry;
> +               error = -ERESTARTNOINTR;
> +       }
> +
>         return error;
>  }
>
> Buuut, heh, actually, I just realized: You could even omit this and
> simply replace -EINTR with -ERESTARTNOINTR in your code as the error

Interesting that that exists had no idea :)

I think I'd rather avoid it as it looks so specific and a lot more like
asking for trouble than simply looping.

> value, and then the kernel would automatically go back into the
> syscall for you after going through signal handing and such, without
> userspace noticing.
> https://lore.kernel.org/all/20121206220955.GZ4939@ZenIV.linux.org.uk/
> has some explanation on how this works. Basically it tells the
> architecture's syscall entry code to move the userspace instruction
> pointer back to the syscall instruction, so as soon as execution
> returns to userspace, the first userspace instruction that executes
> will immediately re-do the syscall. That might be the easiest way,
> even if it is maybe a *little* bit of an API abuse to use this thing
> without having a pending signal...
>
>
> > If you drop the lock for contention then you up the risk of that, it just
> > feels dangerous.
> >
> > A userland program can however live with a 'if EAGAIN try again' situation.
> >
> > An alternative approach to this might be to try to take the VMA lock, but
> > given the fraught situation with locking elsewhere I wonder if we should.
> >
> > Also, you have to be realy unlucky with timing for this to happen, even in
> > the scenario you mention (where you'd have to be unlucky with alignment
> > too), unless you're _heavily_ page faulting in the range, either way a
> > userland loop checking EAGAIN doesn't seem unreasonable.
>
> Yes, we could do -EINTR and document that for userspace, and as long
> as everyone using this properly reads the documentation, it will be
> fine. Though I imagine that from the userspace programmer perspective
> that's a weird API design - as in, if this error code always means I
> have to try again, why can't the kernel do that internally. It's kind
> of leaking an implementation detail into the UAPI.

Overall I am warming to us just looping.

I mean it's hard to argue against this being 'surprising' behaviour - the
user expects to be able to install poison markers and for that to just be
applied regardless of faulting.

And it's not exactly a huge amount more effort for us to simply loop, I
just wanted to avoid it to avoid having to think about whether there's
cases that could result in an eternal loop...

We'd need a write lock to VMA lock the VMAs and prevent racing faults (or
in the case of non-VMA lock kernels to simplly prevent them) which adds to
contention issues arguably a lot more than simply looping under the read
lock.

Let me think about this but I think I will go ahead and try to add
something simple that loops + checks for pending fatal signals for the next
iteration of this series.

