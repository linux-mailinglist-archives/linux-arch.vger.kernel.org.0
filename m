Return-Path: <linux-arch+bounces-8075-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B1699C858
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 13:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DCA1F2415C
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 11:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBC319E802;
	Mon, 14 Oct 2024 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gY/9P4KK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zbzo4de7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF63319E7F8;
	Mon, 14 Oct 2024 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904200; cv=fail; b=iclD5zNrOzHgK7cR+n4mkZLocQSv12N4TabjiwhyemrAxyqqUQptB/SY2UvRdhifoqy4Jt2mpZkt0OiT+wHnymVZRl/EmQW69pxFXJ5JdVGi8gqQ8W4DzC88d39CoF7H9xWkvECwETESRRSianOHCF6+pC5h7O/xRTP3GhIdTSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904200; c=relaxed/simple;
	bh=NfU9RneuNudcMCZz3LEtkGetthhvl+OwNq5HVP5LgQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eZvEopZdOXVaSRAvq4MFXHQrZAgdoi3uyHqEwXsxctIDnRVGDuWke58qA5dDd2Xjhhom81tBD8zoKaLLo5tXDSHOQ27eAfGDKjf4SIA2FPz4MbOyVXH34oi2QEmJC/7Hyny917QSOukB+vbK8QsgZb0hAZACrMeTA1ddxVKarsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gY/9P4KK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zbzo4de7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E9u0vh032315;
	Mon, 14 Oct 2024 11:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7a4VHPJ433E0gnyPulnJFVrr7+JRwwU7GuRMG3cVkWo=; b=
	gY/9P4KKGEue9D8u89nSO4krOA1tQ0EQmRHVpjFgtrxh1znffy0B7LZzzKTBbqNr
	E3SEkRQXUQugjribOGxzs8zBD+NZkDt3HMpF6vHs3872aCL5oxEVT3BX4MQWlPC/
	CAaSmC1JWfwXW4oHYi8ikE7xi+NPqvewP36nhjFC6hoyT4ERsrzJU3PSCu7TAtwp
	7RRO4bNfvtcV064cqhxcRZ+8k+vhcCSFz9ctV8EcKn5FWacLmC5DmYFo4MR2Ybwr
	CYsPnrwSNh9AaB78agN02Y9gdpiR0oDJ7JSMC32zhP62btEtro9AgUpgwjhjaHkh
	nKulmnkh9Xi020owhX/2LQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1ae09b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 11:09:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49E9HLhw035999;
	Mon, 14 Oct 2024 11:09:03 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjc6x2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 11:09:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAd69jj8d8sIIH7f/0bfnp0bMBgXGt004kc1V7+9IiGBS9TgKsmMMjXjarEKAvmSRMju7qKkjPcYPXmC5jS85zb//r6nON4BaLF+hOj+6Zhh94PeqH9tcwcXzI4Rww2iEjlLK+K4a6eEggM3tfK6gIijqnCSvYpnGumUl7hJZ35GuLO3rmKk5/EH6fimUgANzuXS7A3LLKFpyUASso+G/G7RU9UdAyd0n/eqRvALEvo/BAZFczRSPmX1vPirJDjPAqN5qHsbUjAviMQnyfymz6hZUGIT3nDJicKenqKV1kW0eDyfxccC71VPrMDPbud3cstLbcLxuQAueeyzKzTDdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7a4VHPJ433E0gnyPulnJFVrr7+JRwwU7GuRMG3cVkWo=;
 b=ZsCjTgAFhh21SlWl/xx14i8Z8FvnbOHdW4jljm+pI2SwtebDIb6CJ/ns2e1rGaAdt2hA1eHWntXkRzSVDsQxn9hrBzbwj9Zwz8mfvX9p4FY+cabG64/rR0XUuw6HXdl4belOe336YMt4eyM0qcwWTOspRyhAmDTrHe6Xk9KzmK+JQJziHHRAjLvHV2bLfB0W6xs9Wh3edRhedE8RYeA0Of24sXwgAD6y3ZVXDzErAXovvek8B21PTAKuktL23bo7MdF+0pYLFbgNZ1FyoghWrMLx+1SjkJVOg2j9Y8rljph/NvC/cY6PW9S39osmxnu13Cg6YFazfErXnwQ3DAmRXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7a4VHPJ433E0gnyPulnJFVrr7+JRwwU7GuRMG3cVkWo=;
 b=zbzo4de7D5/UPWSNL5/nItmi9Yh7r1l1qn0hG7hu+rBmj84QL2At+bH+bQzSVozj77u2HkpqeHdA3AuVijfEVFPCr1efSvcYya0f798V+Xc2bibMB8GnxHROgb6B83LFRLV/2Axfq+56qP4B+cGBX0YPCFftecaxrklIetkzhlk=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6257.namprd10.prod.outlook.com (2603:10b6:208:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Mon, 14 Oct
 2024 11:08:59 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 11:08:59 +0000
Date: Mon, 14 Oct 2024 12:08:56 +0100
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
Message-ID: <868739d2-0869-462f-ac86-1a8d1dccb0a4@lucifer.local>
References: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
 <a578ee9bb656234d3a19bf9e97c3012378d31a19.1727440966.git.lorenzo.stoakes@oracle.com>
 <CAG48ez3ursoL-f=mYpV79Do18XPPt+MPPHNUBv6uFE1GhpOwSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3ursoL-f=mYpV79Do18XPPt+MPPHNUBv6uFE1GhpOwSA@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0481.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 848d895f-5eb6-424e-8e0b-08dcec409a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnVwbS9Dd2Q1NS9TV2NFMjF6MEt4TTU5enFobExUdXdqd0J4d0NwVjgyMWNl?=
 =?utf-8?B?MFd1bmxaZ1NqTG5Nc0FkT0VhdWdFOG1EZEo4eElyNUZmMlFOZlN6VU1SNTl0?=
 =?utf-8?B?RE41TVhQaEJiOWhsWDgxM1EzamxBWWFUTTJuR0V4dEg2MHBWZ3FVeWl5L1U5?=
 =?utf-8?B?RzN6S2hMQU9GQjZBYUNydmJ6N0NCK2dTMXVhVER4RFRsSlVQV1VkbE5FTXQr?=
 =?utf-8?B?dm1oU1BlOVFHTE5IY2ZiY2VDa3ByZmI1eDJQNUVmQlB2TXBhemtFT2g3UFNC?=
 =?utf-8?B?YUhkbUJSdWlXYTI4eGEzNXEwU2o4UDJHWnNlb2VzVWNBUFlVWGM2ZTloQlZO?=
 =?utf-8?B?YnpBbWVGaWJ5bmlRa2xFNHFXTUZhNlVkcUkwRE0zN2ZkRURiWmR6WTFHSzc3?=
 =?utf-8?B?MTJyVmFtay9FUUtrNnhOQ3ZpNUhrSEo3bGZ0SDFjR2JUQ1Vvc3hkdlZmem1o?=
 =?utf-8?B?NkRrTE5sWkpvYXRNSGVJc0RYL09yc1BZeFdBeVJUaU80N0pZR2FiTkZJRUxX?=
 =?utf-8?B?bWsrTG9KWjRUbnE0N0FkaW1Sb2w5cDNmb2ZHQ0Q1UENsaC8wc0RIdjRTSE9o?=
 =?utf-8?B?VHNrS0dPU2NMR2NsQzNkUzRKUERPaXVNR0ZsT3FzQjBGN1phRGdDQk9qc1cz?=
 =?utf-8?B?SUE4MTBWOWp5eFo3UDJqaTRhaGR3Z21Iazl4ekhTbldRUytOemR2OUN5QmZ1?=
 =?utf-8?B?UVNLRmVWNjVKdXhVOXBXc2hXSUhlTzhFOENaT2w4RDB2b2h6bTFWK1BHWlFl?=
 =?utf-8?B?ZGFiTGk1VjMxdlF1YmtvTWtNQTZUQ251TjlGck56REdON2NHdWlsbzJBSFlh?=
 =?utf-8?B?M2kycHVITjR3b0hJZmJyVW8ybUY4Wk5jaEhrVHA0TlFNcStuOHFsS3U1RG8v?=
 =?utf-8?B?aHI5SFdjeDlUZHhndEJGZnpjdm5yNVRtQmY4NHcvYzU4SytpK1pLZUpMK2NK?=
 =?utf-8?B?L0VhTVJtaElQQjFPdHlLL3lLcVk0LzRWNmhpMEhhY2FsUk1GcWtOKzNtbGtC?=
 =?utf-8?B?YlFVS1U5VlBJMEkxYUVaR21FdEtVL0Y3d2M0N3E0N29GWXRLZE1Pa3JWMUxl?=
 =?utf-8?B?SkZjUnZCT2t0VEswc1lKQjJNc1EyTFlxdE9uMnNoVWVtZzA0aVdhSjE0ak8z?=
 =?utf-8?B?Y09uaURUUUFaYXhSSDRhL3d1QmNzU0JoM0gvNEJLQXlPVDNkK0NFaVpwNWI2?=
 =?utf-8?B?M2hlZ3NzbTNRbWtQcDlheTB6WE9KNEF0b2xaNCtBSjdYdHp0bGtnK1JTU0pv?=
 =?utf-8?B?R0FyZ0c2MjFyZ3lYTm5LS3FTaEg0eVBmdUFvUURzSDVUcDVZM085L25udEVV?=
 =?utf-8?B?YjJ4NlI4RWRqYVFSV3FMditKZkJNWTJVb1ZPbmxQZjNzYWRvRUpKU0xRMUM5?=
 =?utf-8?B?R1VTNE5XL1l2dlFjM2E5cTJ6NjhTNWFDNThkLy8xM3JGUEhFMXA4ZjQvbER0?=
 =?utf-8?B?ejNIYzJyY3UyZzFham10ZkY2ODZIMVdFSXk0dzlDUUw4UGZ2dTR3dW5zQlB5?=
 =?utf-8?B?OW5hRmMwbVhJRm93L0phRTRhZEFqSE92OVhrdTNkOFc4RjdQKzIvQUxUTDY0?=
 =?utf-8?B?amUvbmQ5aEptYUhxaTNrSG0vZkkrbkM3NHAybGloSHQ3UGlCWVl6dkNXOUpu?=
 =?utf-8?B?QzU5RElEK0RyZml4WFE5aHlXQzdsMXJickY3M1M5bDFTUUJCRFl0NG5ldUl5?=
 =?utf-8?B?VExRazZ0SzFZQk55RTBqRnF6amNqQzlVL2g5S2FiUGw1Qjd5U3FXWmtRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmJTT0txRkF2Uk9qWEcvMk1vNGxvS212ZVozM2g1eVdRVUhqNmx6ektGM3cx?=
 =?utf-8?B?dnpRejB0VENURElkOXduMEVhdS9MVEt2Y3M5OFpKSnMrM2xLMWxBUk5ZZzE0?=
 =?utf-8?B?RWpQdG05S3UyeUxyakRaTjYrSEtmTXlpWXhFMVBWdWdJVlNXNXVocFE2WjJI?=
 =?utf-8?B?QTgxUmowM016OGxEdEFxY0dCZGpCMHIyc2pKMHN3eDdNdUlUOFJ5dWJkbWpC?=
 =?utf-8?B?RFVYcmJaTGtETEp2bll4aXVRT2Q5dlgrRHZ2NXAwWTJlQmwraVMwV0pjeFNo?=
 =?utf-8?B?RExHN2hpb05wVVhKblJHbUJ4ZUtMYmFUT1hxZGJDbFA3SWF2N2trUGUwejFU?=
 =?utf-8?B?VkRHWTNtN0JFTmZaZzBaaDk4WXRwVk1BaFNvRUFYR0NJbE9KL05HUjhBSDlo?=
 =?utf-8?B?eEM2ekpIbll4N05OaWpCVEt6NFZJdDRqNEV2Q2NmS0J1UG9xWTRMSnJMa3lL?=
 =?utf-8?B?WVJYcmMwS2w1cVJGN0lXZk8vVUExQW9yd2dGSDdRamRJbGNOdlVxbE9GVEg2?=
 =?utf-8?B?N3JDMVV2aVNZVkFpOHMzNU16OEVlbTBKa3FkSFVHaVRrZ1BvU2xHckhidHBh?=
 =?utf-8?B?WGg4K1RHWS90OHU2Wi9qTDJDZVh2MjJwVWRXUnhHV3krNVd3Y2IxRU5JckxB?=
 =?utf-8?B?MGlXTFd3aWRsbUlYdDNSWXZ6S0hTK0YzcWtkNkhGZkRPYWJ1NmFmODNLS3Fk?=
 =?utf-8?B?R2lsWEZlQWQ5S2JFNXh3b1JSR3d1SVNVblJjNFY2bU5EamFTMVdSYVRMMDJu?=
 =?utf-8?B?SzhzTStNZ3Jkc3ZFZEZxRUVzMlJJRTJPbHg3a28yMEdwc1FXTmRJdGZxZGxZ?=
 =?utf-8?B?SlkxYlpMWERJNi90Y1hrdWRaNzI3eGl4bngxSmplMWlrYzBjV0JkUjlaUk1i?=
 =?utf-8?B?WEpIMVF2M1lKZ20zUUl2N3hELzhXNHRWWjc3TThVRFE2VDRaZE5ydWNxdWpZ?=
 =?utf-8?B?UWdGT2U4L21lcWpEWUxRdHJGdUd6VWllZWl1d1VtSHRvdFJERnV3SWw5dU9h?=
 =?utf-8?B?TGVtdnBPTXlkR1hVNDBldlNSUStab1RWRWRFM3JoekdUYUZvNUs3WG8zQWp5?=
 =?utf-8?B?M21pdkxUUjBVcHNUd1dUeHlTOHdaZUJDSGFJTnNpaDNVdVUwVkEraG5mR1Ru?=
 =?utf-8?B?WmtMU3dwQUtGc0x1YVhKZTRRSGpzNlgvUzhkRkxLUWdMNGNnK1NQZDV6Unp5?=
 =?utf-8?B?OFkvaXZaVlFYUFoxWEZQdTdodmU4M0svRk5TSU50Mk1ZZWJsMXdQdlJ5aUVK?=
 =?utf-8?B?VXdYZXlzdnBSTDdXTlF4SVFyRSt0a1h5Y005SW41N3liMHpnOSt2Z2NDL2hW?=
 =?utf-8?B?QlBHajFTS0djaVhSMTNrT3VZVjc4ek1ERUZ0Wk9UODZnTkEwNkNhMWY4R1pW?=
 =?utf-8?B?ZzNhbkd3YUZpYUR3YTdBckJjS2F2NXdUL0h1SVBBbUQwSFdHMDl2eGo5dyt6?=
 =?utf-8?B?MVdUM0FIbFg1M25iSXFQbHdtdlVlRmJGaWdjZC96ZjUrOUpIUjNVNk9XK3Jl?=
 =?utf-8?B?eG9rWmJsZW44MzNPa0pJTkd5ejgwS1NuMjQ5YUdrajgyZmlRbHVrbmpXQWE4?=
 =?utf-8?B?eDlFWi82aDBRbkhhV0RGdXRycXdSbmllVk01RU1HZjhib2Z2blBvQzZrRktG?=
 =?utf-8?B?QWRBODJ0Rm1oblBtY1cyUEtMTm5VNXNTNkp5K0hwM3l6K0x4YStyQ1doSWdr?=
 =?utf-8?B?MjZwUTFSbHdkbkJldmErenZCOVJWYWJub1NQclhTV05aU1J2WU84WjBTUWpz?=
 =?utf-8?B?Z1paU25iY1ozOHY1eGdncmhvcDluclRTbDJ1Ymg0N3NrMld4ZGN6NGFKR25S?=
 =?utf-8?B?WFRSZ3Fvd0EwUHZkV2QvOGZ1blVkNGhKeGVtQWIrWmlaeXdtbnFrY2JWU2Ey?=
 =?utf-8?B?VjBhdzVUMHBzMm1sREVPajZhQlRmK3ErQkN6R1doMlozNjh6Zm9GN09IbkY3?=
 =?utf-8?B?WW1EN09JSlBSbVFTWmtYd2hiU29lRHBwUld6bkVTTEwwY0doTGZDbXFMYVR3?=
 =?utf-8?B?SkpUa3ZIbDNtZ1BQRVJ5Q25NbGp2VnZNdlZBRFB5S2dmNEZiblZDWlV1NkhN?=
 =?utf-8?B?L0FQMXg0UUZMUVZUcmpobEJOcUVPbUdLbGFmY09sVDI0L29OalpkcERJNXJ1?=
 =?utf-8?B?Q1c1Qk5iZ29MdHA3bnYrRDNTa1VOSUFHUlRjcmV4MlcrTGZyV2NDeDNOSjdt?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SCz30HniX4fad42zfm5Axd6gZUZO3UHgI3G5JYeXqX35oTBLjurOV1E5NNpz/e3jKO6Fr5bzhJaucK4AQXCXFXVB6RZraiK5CcYy0z2pa8cRFhi2EYzmFQXdLcRSgPX1W0NrrAQWn7EV96kVkaohdEVmb0BtLu7+RFrOAj+QXyQhQwC0N6pjwZtS4Bk42jclpqRT7kBo+qZYYsvX2b6mj73h1pbft6YheU8VHUS3Ds2yT+E6ARzwDcbSGXt/jOoqrbkBwYm+5Pd2HrO3MS3FaWXxfp/HI9jl7tqCAgDM4Tclx7hNXbC8Ms+Dg2ur8/5k4/oe7ybz4y7Q/Vpxr2SAUHFj0kAExSawO8nqfGFEUC3rCkLX77+VmZkC2+yoYsXmF/bUzGb8ot4AI67dcf6UF1OosMk84gPfSHAfYg6blTL5Yijj/TjUlhXQYi5iFhBQm4boyNf4shwrnXGZuRwb/eNo7S8Z+H9Mj07DUK5KAmI5U1T+B7ytR+T/q5ibyalzRA2Fy3cgDtno02wNBw16fzIiBESMYZK4nt24dTpqPoce3pCWNbvuygCHkIIYhdQ4vRdjGdKtU5ustiegnrH6QuqfLts96gFxJg/F20GHNBY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 848d895f-5eb6-424e-8e0b-08dcec409a77
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 11:08:59.5706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIJYhSTsN1rgQBPkH3HTp2DsEVNU19x0pMlrxkuAblT096PkcDdDsdr2CwPQoq6LhAG42pCq4KbgPLHaj7+vS4z+9LSTzZEVP2stie/xMUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6257
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_09,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410140078
X-Proofpoint-GUID: 8j-qzA0AYoM-Fek2mSnp_oXSfcA23_G2
X-Proofpoint-ORIG-GUID: 8j-qzA0AYoM-Fek2mSnp_oXSfcA23_G2

On Fri, Oct 11, 2024 at 08:11:36PM +0200, Jann Horn wrote:
> On Fri, Sep 27, 2024 at 2:51 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > Implement a new lightweight guard page feature, that is regions of userland
> > virtual memory that, when accessed, cause a fatal signal to arise.
> [...]
> > ---
> >  arch/alpha/include/uapi/asm/mman.h     |   3 +
> >  arch/mips/include/uapi/asm/mman.h      |   3 +
> >  arch/parisc/include/uapi/asm/mman.h    |   3 +
> >  arch/xtensa/include/uapi/asm/mman.h    |   3 +
> >  include/uapi/asm-generic/mman-common.h |   3 +
>
> I kinda wonder if we could start moving the parts of those headers
> that are the same for all architectures to include/uapi/linux/mman.h
> instead... but that's maybe out of scope for this series.

Arnd already had a look at this in a recent series. I had the same feeling doing
this...

>
> [...]
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index e871a72a6c32..7216e10723ae 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -60,6 +60,7 @@ static int madvise_need_mmap_write(int behavior)
> >         case MADV_POPULATE_READ:
> >         case MADV_POPULATE_WRITE:
> >         case MADV_COLLAPSE:
> > +       case MADV_GUARD_UNPOISON: /* Only poisoning needs a write lock. */
>
> What does poisoning need a write lock for? anon_vma_prepare() doesn't
> need it (it only needs mmap_lock held for reading),
> zap_page_range_single() doesn't need it, and pagewalk also doesn't
> need it as long as the range being walked is covered by a VMA, which
> it is...
>
> I see you set PGWALK_WRLOCK in guard_poison_walk_ops with a comment
> saying "We might need to install an anon_vma" - is that referring to
> an older version of the patch where the anon_vma_prepare() call was
> inside the pagewalk callback or something like that? Either way,
> anon_vma_prepare() doesn't need write locks (it can't, it has to work
> from the page fault handling path).

OK this was a misunderstanding. Actually there have been more than one, at first
I thought a write lock would protect us against racing faults (nope, due to RCU
vma locking now :) and then I had assumed literally changing a vma field
_surely_ must require a write lock, also it appears no as __anon_vma_prepare(),
amusingly, uses the mm->page_table_lock to protect against accesses to
vma->anon_vma.

And yes you're right it is triggered on the fault path so has to work that way.

TL;DR will change to read lock.

>
> >                 return 0;
> >         default:
> >                 /* be safe, default to 1. list exceptions explicitly */
> [...]
> > +static long madvise_guard_poison(struct vm_area_struct *vma,
> > +                                struct vm_area_struct **prev,
> > +                                unsigned long start, unsigned long end)
> > +{
> > +       long err;
> > +       bool retried = false;
> > +
> > +       *prev = vma;
> > +       if (!is_valid_guard_vma(vma, /* allow_locked = */false))
> > +               return -EINVAL;
> > +
> > +       /*
> > +        * Optimistically try to install the guard poison pages first. If any
> > +        * non-guard pages are encountered, give up and zap the range before
> > +        * trying again.
> > +        */
> > +       while (true) {
> > +               unsigned long num_installed = 0;
> > +
> > +               /* Returns < 0 on error, == 0 if success, > 0 if zap needed. */
> > +               err = walk_page_range_mm(vma->vm_mm, start, end,
> > +                                        &guard_poison_walk_ops,
> > +                                        &num_installed);
> > +               /*
> > +                * If we install poison markers, then the range is no longer
> > +                * empty from a page table perspective and therefore it's
> > +                * appropriate to have an anon_vma.
> > +                *
> > +                * This ensures that on fork, we copy page tables correctly.
> > +                */
> > +               if (err >= 0 && num_installed > 0) {
> > +                       int err_anon = anon_vma_prepare(vma);
>
> I'd move this up, to before we create poison PTEs. There's no harm in
> attaching an anon_vma to the VMA even if the rest of the operation
> fails; and I think it would be weird to have error paths that don't
> attach an anon_vma even though they .

I think you didn't finish this sentence :)

I disagree, we might have absolutely no need to do it, and I'd rather only
do so _if_ we have to.

It feels like the logical spot to do it and, while the cases where it
wouldn't happen are ones where pages are already poisoned (the
vma->anon_vma == NULL test will fail so basically a no-op) or error on page
walk.

>
> > +                       if (err_anon)
> > +                               err = err_anon;
> > +               }
> > +
> > +               if (err <= 0)
> > +                       return err;
> > +
> > +               if (!retried)
> > +                       /*
> > +                        * OK some of the range have non-guard pages mapped, zap
> > +                        * them. This leaves existing guard pages in place.
> > +                        */
> > +                       zap_page_range_single(vma, start, end - start, NULL);
> > +               else
> > +                       /*
> > +                        * If we reach here, then there is a racing fault that
> > +                        * has populated the PTE after we zapped. Give up and
> > +                        * let the user know to try again.
> > +                        */
> > +                       return -EAGAIN;
>
> Hmm, yeah, it would be nice if we could avoid telling userspace to
> loop on -EAGAIN but I guess we don't have any particularly good
> options here? Well, we could bail out with -EINTR if a (fatal?) signal
> is pending and otherwise keep looping... if we'd tell userspace "try
> again on -EAGAIN", we might as well do that in the kernel...

The problem is you could conceivably go on for quite some time, while
holding and contending a HIGHLY contended lock (mm->mmap_lock) so I'd
really rather let userspace take care of it.

You could avoid this by having the walker be a _replace_ operation, that is
- if we encounter an existing mapping, replace in-place with a poison
marker rather than install marker/zap.

However doing that would involve either completely abstracting such logic
from scratch (a significant task in itself) to avoid duplication which be
hugely off-topic for the patch set or worse, duplicating a whole bunch of
page walking logic once again.

By being optimistic and simply having the user having to handle looping
which seems reasonable (again, it's weird if you're installing poison
markers and another thread could be racing you) we avoid all of that.


>
> (Personally I would put curly braces around these branches because
> they occupy multiple lines, though the coding style doesn't explicitly
> say that, so I guess maybe it's a matter of personal preference...
> adding curly braces here would match what is done, for example, in
> relocate_vma_down().)

Hey I wrote that too! ;) Sure I can change that.

>
> > +               retried = true;
> > +       }
> > +}
> > +
> > +static int guard_unpoison_pte_entry(pte_t *pte, unsigned long addr,
> > +                                   unsigned long next, struct mm_walk *walk)
> > +{
> > +       pte_t ptent = ptep_get(pte);
> > +
> > +       if (is_guard_pte_marker(ptent)) {
> > +               /* Simply clear the PTE marker. */
> > +               pte_clear_not_present_full(walk->mm, addr, pte, true);
>
> I think that last parameter probably should be "false"? The sparc code
> calls it "fullmm", which is a term the MM code uses when talking about
> operations that remove all mappings in the entire mm_struct because
> the process has died, which allows using some faster special-case
> version of TLB shootdown or something along those lines.

Yeah I think you're right. Will change.

>
> > +               update_mmu_cache(walk->vma, addr, pte);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct mm_walk_ops guard_unpoison_walk_ops = {
> > +       .pte_entry              = guard_unpoison_pte_entry,
> > +       .walk_lock              = PGWALK_RDLOCK,
> > +};
>
> It is a _little_ weird that unpoisoning creates page tables when they
> don't already exist, which will also prevent creating THP entries on
> fault in such areas afterwards... but I guess it doesn't really matter
> given that poisoning has that effect, too, and you probably usually
> won't call MADV_GUARD_UNPOISON on an area that hasn't been poisoned
> before... so I guess this is not an actionable comment.

It doesn't? There's no .install_pte so if an entries are non-present we
ignore.

HOWEVER, we do split THP. I don't think there's any way around it unless we
extended the page walker to handle this more gracefully (pmd level being
able to hint that we shouldn't do that or something), but that's really out
of scope here.

The idea is that a caller can lazily call MADV_GUARD_UNPOISON on a range
knowing things stay as they were, I guess we can add to the manpage a note
that this will split THP?

