Return-Path: <linux-arch+bounces-7468-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2857598858F
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 14:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD9C1F2196E
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 12:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD8118D620;
	Fri, 27 Sep 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LZ3to4+g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Oj953Xn3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E9418CC07;
	Fri, 27 Sep 2024 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727441545; cv=fail; b=IcSaYvoQiKt+kpsrHJreQf8L1Fq/whxjacpwSlme8liaUHGEoQl4tQCEJLgij0d3mJMWztlkgLBk44q8blJiaZ4xqdLG875qzB20/cdXVjRajpmzLV9zLwxtamqoOaOb4glqeaIlL+GAf2Olx1ySj4ULq9iv3zWzZK+yBEJ3b8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727441545; c=relaxed/simple;
	bh=SVzQ/jw9CIfHRzr0oHzQTM92QqRc9K4nxy6m5UxfVPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MyI6hmZ/htNYTbZxXAPmxFWwUhj03KvYDRbEWZEpMdrSij+DTQU0LVc1pXNLmEjiiz4CyJwvE3P6CLDrcNLSt/DqK2DtQJhPIwk6QqA+pNJ+shzFwK/qUVC1Mj1Ufix6TeJcCICFPZ60abqFSPNaPhvR4Z69Hgda1kLhA6bf8Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LZ3to4+g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Oj953Xn3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R5gdRs016189;
	Fri, 27 Sep 2024 12:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=5j3+3riJngw5WIz7efPctdC6x/cHnhLERvDk6GlnerQ=; b=
	LZ3to4+gQc2ZZJnrNcO2V57W+DR9fSxSpJniFm6isSTwHODN3tJIYtsU/gu7sG/S
	daKwH0UNFrOW4gX7QloJ2SQZo0P6qMCBEVs/vJZiQQrlDFlGPY/RQ23dkm0SgFCk
	0qxEl/D/+ol+UPN+ZVH7Tjd2xCluN/H68WgtxgcaM3kcaFXcMCGGooHtwT2B2+hz
	5biN9YcH/tP2J0DZA+2zXK3DO7Q2lDbnSq3VoiVaRuBiF4erBWbnA8auWanwmWTq
	cnM3+zp4AZOYF9gRXY9FG2/JEeqYuSxyGPMPSgvXCbViwlwIgn3gDNWEggw/A40l
	XLUXXZErkVSm0FtNtGYctg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp1aqejw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 12:51:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48RBg16V032720;
	Fri, 27 Sep 2024 12:51:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkktqm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 12:51:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVWXMmvTEn3nu9uyLr74BZtXZllZpkadwc7I2mYpUVRivwY0GclfHcRzwPlTvR4X7ov5+cA6/h3xcOOsz7A1IloDWahy13r263I/pDaxNtcUgj26mxn5n0sMmTladMWd8M/2IIL0Tx1YIey1SEb7pxooHuf5gqR0H/62A/pbMWoYArV2AoWsnKKsAJWw3V0uJ7auOUb0PmzsTdZD+UpxWijMMsLw0YwabOMFdDu1uKnM4x80r2Mm8rzhgDmsZuY3IuL5j88jnH3yOy68vhQmCVUv7dZcAOKUF/3iUNLqwZbBwxgoWl6vgHdglzWJSZmPDrGeQfw1FY1dCayrx/Hrkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5j3+3riJngw5WIz7efPctdC6x/cHnhLERvDk6GlnerQ=;
 b=JWOk6A8qxQlioVT1/9dyE4B8/kupnWTVn8tRC+uwyJez4910ezVQf716KPVpMRqhCSqhg6Gq77EECuUlt5Tc6m6rRNPwZrlMqknp7+oFsa6C9lBnzrOWKeYlURK/75czx9gitpZ+FaQcH9dKA2t23TplCwTgvOEMDPeKrJ6spAkg35IfLq2CCHow4SnFlD8ojGnzL3cJF76DWsAd/4FuwgN23+vKKdkpRRyGSl89HP2oBm/2NmQiIBqIwDYmvE9Ay86GE7b9oTzEI+ERB76CWYOamDZsli1VYEzAPYKdlCG0GuGBYVk7cePTaiiwbGnG6z3HqO28oLZZnuDEDXCY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5j3+3riJngw5WIz7efPctdC6x/cHnhLERvDk6GlnerQ=;
 b=Oj953Xn3nkBrCkd4ax2TytO9MZfGdOq/XCpXdkqm1viuNCrxShyH8+fs5cLPq/usJiHptP9wyBVhbtYAMY0V2SphmXho4wrTFdKw0OGhnn4CcLHOVjQZIJK7Tb31oUm3UsmsEHMZUSAFN1f1Xul6VpmRmfGHPKmsjdUt182JBfQ=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB6820.namprd10.prod.outlook.com (2603:10b6:208:437::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.10; Fri, 27 Sep
 2024 12:51:35 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.009; Fri, 27 Sep 2024
 12:51:35 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vlastimil Babka <vbabka@suze.cz>
Subject: [RFC PATCH 3/4] mm: madvise: implement lightweight guard page mechanism
Date: Fri, 27 Sep 2024 13:51:13 +0100
Message-ID: <a578ee9bb656234d3a19bf9e97c3012378d31a19.1727440966.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
References: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0259.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 44dd7404-ecc0-4899-0ba4-08dcdef31e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bbFDIbFgf/fM1TyZd7zjQIzZXKVisAUxr3J9MRR4USjL/+PQ+nurHzT8Gj2r?=
 =?us-ascii?Q?S40bEbyyLTPOk46FpahshGkhl3XaRh7if2SLrg6Yatswy3np67kALLCwWVp2?=
 =?us-ascii?Q?BP4EvMCikZvz1IaxN3SpQozlSc89fEa+tvhDURk9ZMlmWtRWhVl25VSI+7vf?=
 =?us-ascii?Q?RI26ae+dVJxte0T4ka5iWiXa5HGsr1IPJ340NruZbAQXEhXgrVlVycRj4Rs1?=
 =?us-ascii?Q?V+/s9uWyxOh+EdjLfjzgKZ4SmWQTUL9hsWeP1gVovtqjTqGl0ina2hPghRSN?=
 =?us-ascii?Q?oUyqZ2fd8yaq2VO6UtZk3qDLmcwWr+ARPjzSzltVK9XbWsy/E2hWs6qQFAqT?=
 =?us-ascii?Q?AvcoPfkQ3t1LyBQlVPTnWMvok7IcdGP4RTGYa/yr5RkX7shMVhy+dn7Oo+k8?=
 =?us-ascii?Q?6LCUEPQhczf7NCeQwZZ4/63o9P9l//kD9WLLCgQls/Oqy86nmIR1/apas9uO?=
 =?us-ascii?Q?pJEx/4NDEAJwLxwNHTwKPn9WhmJjzcgYx4IxRwcQkl34TR5LlkiLkELnEHRB?=
 =?us-ascii?Q?zKZYfDhj+b2jsx9LAUA8HKez8Lz6zouQyW0HqB9A/p06IYzIFcdvQ6SCScYw?=
 =?us-ascii?Q?GZe8q2IpXvTM2R1jDNO121SLqe+p7RhJHmu4fx21xLWZtln/Z9LW9h1oM5eU?=
 =?us-ascii?Q?Q8GTLGSZIOVuWqFMIXx6Wkte8qEISOi1Hfwga+sjtZZp9INs9b7mbvrNrjLw?=
 =?us-ascii?Q?BlenLM3leQJvKDTFxDZ315Cluw82Aj7FkLFORc+zXh2Buaw6g9i1KmT5fd4t?=
 =?us-ascii?Q?wIrK42kiQ5Axh5AnFMIE+K0W013b42Micj+fPJV6WDRxJt5W9U0OAa52DBiy?=
 =?us-ascii?Q?TEZWVseNrdOK0LkNbcksy4FQZ9yzXOR+/tLdA0mVxaU9QbZA4mFh7MLFh1fX?=
 =?us-ascii?Q?W9k4hqEzJOlulqqKqE0uwWklRTFKsJytngQiARw7keT42D6ATgI5lk6nHsT0?=
 =?us-ascii?Q?etQOLqWHRzAU013ZcMP4uJ1RFalHpq0bh6Dku8oLUIf4jQqK8V0MzGhk/3X6?=
 =?us-ascii?Q?1UkXgIljRMr0NTXzaLsP7oOpuWRo+Oh9XRwb4vyK2GEEXTSoKBGop2546Ozc?=
 =?us-ascii?Q?bHvLhnOp8JEZdVM6hIuCB2IHmpHejve1B1nH01qqex3rwHQjHXLaeYoqSrZh?=
 =?us-ascii?Q?22YrGuYk+5TDOgdLVWmdhUdiozSGFXFPpOgfmNVGjdISkN5+5HoTlJHbcsI3?=
 =?us-ascii?Q?A158p7aDdm1reZ/06kc+D52dMFeh/h7V2dos8rqUVzWXQ56NiiemZZoIlv1s?=
 =?us-ascii?Q?xIOsDna/tS/6dvK64ZltcVBybVT6OIDUTYmt2I3LwXBP71zu4+BFYttrW6vD?=
 =?us-ascii?Q?Uy7QdYS5nBYfQidtCoqN3G/iDLsIRANNvKRR1+gySCfirA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RgmrMQHGEGHnZqWyYxaNt3NHn6takjYluE+aDCyKjhb3oONOeSVO1KECWPgG?=
 =?us-ascii?Q?coDjmAoAeTiqH2LXi2DgpC8UxBVvlq/abCH6qE+PPJlSuXKsBsXUjvxOH+n2?=
 =?us-ascii?Q?JUpwhkDN1MCK90Y3BnAHfm8rU+ckvkFwtOE5kCpyVVtwj5vZ6uS0YBkP1v73?=
 =?us-ascii?Q?0LfVBvq8U3N3+QiKxWsUP7+YunMVxEcUaNoLs7jiEE36NwHL4h1QrMFhR5Y2?=
 =?us-ascii?Q?+dkUT9khnT1qhYql13CGUVmuX9pAFslKQcxts3wzI7A0+ygaTSRtmCpIUkH+?=
 =?us-ascii?Q?ls3GJOliDnvRkr2K6WbQMbff6aLjGYNjLRQ6MK5KacgP66Rl/4v4is1WEMN4?=
 =?us-ascii?Q?LDUKemZsq55pML+uGZQaf+Rba91gAbP3JB92eDGk3lzJpq7t7JhbK/MSKOim?=
 =?us-ascii?Q?9F8EJG3MV0ed7DTDGlp7xqNl84gP/CJ5cCQcR8Sf/cprLFzVjSWe8woB6XLM?=
 =?us-ascii?Q?XVMPAJQ6sI3vJKJ6+XF8qYLWUsiIuoy/cvh0u+zPlBLRyFsZUWSu/Xi/yi94?=
 =?us-ascii?Q?sEI2OazaAVBlbnHeGSCo5ESQR8Tx794PxKtEIrZk47pDpOhswlVvlgvELoe3?=
 =?us-ascii?Q?TuG8EBCnS7GSr9iWrUJxvOzVelBGX8HoJA3u3vbHKQZta6K32O5MQhwW8uIF?=
 =?us-ascii?Q?qEGyilDCw9m11VfNlLD+d6zZbWftYAdijcnD9ipgUIXc9BMdVVsInnnSdWAw?=
 =?us-ascii?Q?Txldrk64OOLvGyHpnWfyVjkXTfe7T0r53LSzRkK5lDqNyDTJecXfudJX1E1E?=
 =?us-ascii?Q?IaULchU6Mvj4enS8dJZpMUE1xkk4YKn93GvoPg3upvMAWCRbBya/wXvOQQOv?=
 =?us-ascii?Q?XIrgvy8I2fO2h/0qzRPulmim98uikpWOHAezS30AzlMMrKCXWhtH49o7CkOA?=
 =?us-ascii?Q?6aOJ/nvr4/GZG1xm0kuYAnhSzp3KvSadl8gNwt0D531T0zAQc8CIdvy0jHXW?=
 =?us-ascii?Q?5JdKEKZcavs71ARozdPlWBBpMaFPsFe64xanHBSwmYmAQkWThIl0WNGQB9JS?=
 =?us-ascii?Q?v6vzz+yaX3U0O6cbEIC/L0khHp2E6VecvQ5mPDjMdoTTxQqD/scdQNgnz4No?=
 =?us-ascii?Q?ZL2avaPmTKAFPsnfVImKLg7zhLY2MLJJndG/kBhimwrm1vQACJpUBJRrRZK/?=
 =?us-ascii?Q?IS++2+6Lv8e+he5IazK/Gf6AxULJhAUsAvBXAgGjuVL8C2IP/uWwJDBXML1B?=
 =?us-ascii?Q?TJBrukzniIsWYlYsxUUJIPGDr6FrK3mEDi3t3vc9LVn5B+GRdV+wX4e2e9gm?=
 =?us-ascii?Q?TK/ovmfxiPEfBXcmN79QmDNhzyc9uXFHop9ylpghkBckRdnEQirffyZiDpKa?=
 =?us-ascii?Q?0brwZ1O8aBLEr0ZipFZMnFePJ9a17JnjOqWYyq13MDHwzTw3aQIVm08p3Mwy?=
 =?us-ascii?Q?6l6KVBS0bEMKyNwVdLIrpnk7evUjgZSP3llNu77p9ysdg/Sr+V8Qho1eyyYb?=
 =?us-ascii?Q?NAiPAGVGRFxDYhRc3GXoJPkia6/ZvxVreo6C7QDVGXQOrKbRcAZIA/6hHX2u?=
 =?us-ascii?Q?rjVglptUP43UTk+gvEQ2eb/MEhSSpgzuJip0i0c4//ZxQ8Wqe6pkYWe0eds2?=
 =?us-ascii?Q?Va5VL31f9bQ3MIBPcipm7+83TWldJUinxu2GbuTQ7hZk4PYOHRcB543cF+X0?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DA/jRXNy8u/shzw5B9xmjJl+mVobXSRtW7+b3F52Ebef+2DmHYUsfe54v3xNhpjF+Zd+B7H5qtyWs7kznx3KZI4IomBwUXrGZb5t46YJGkMKiCUdHVKfho3y6hIDrBU+1Psn9PNcr9EdRydYXFpzzQNkTBViJUQI6NMCkZTO/42Q0hHW6BD0cvitfJIQvfiqzkL3maQ2UzveAGzeJlbWwXA3+aW78rlAGtlwNmDdMOBXKTN6A52B9f3s3iyDl/IWbKMwS/LL+Jl52+XbQpB2hODIEPUQbv5iTCVll9obsea5eiYWgCSI/ehmJyWDBxBhcEN6UatlQM4K/6XcnNjT0PmS9imUNQdfBZlj5FoMcLzkqEcdxCVN6ewWIIKteD7pLPONCbww3/yuqC5bn+4t+g5XczCMAgE5yzEiRvyynPrpDaqGIQnQIVYl0DfxLsWT7jcnkgCFLMkHPjaB/YHymlunWLO2lGQwo9vVZr83J5iFPmTUO338h6tuNSDAPa7ML/BUCSWqHafhMxYiilafhs7NduZRTYKnnEKHPV5RYbNbwwx9sW+PeJR0WgEMEOLyab21d8xjdnE6uHgw5UX2tpgZgolgs57tEjEg5/nx6w4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44dd7404-ecc0-4899-0ba4-08dcdef31e5d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 12:51:34.9853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Kw/51VP4lYgxv8I1CtTQJe9pzRiPvJx08f62Xc9tu6IFHQmSEXdR+kcMzNb3QPVdohXKsRCCqnKpttds+A9PURhq6Dm7VSty1cfKBfpVMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=692 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409270092
X-Proofpoint-ORIG-GUID: dsWwBxDP45H2ezrUpQVRpWK4b2LEun2u
X-Proofpoint-GUID: dsWwBxDP45H2ezrUpQVRpWK4b2LEun2u

Implement a new lightweight guard page feature, that is regions of userland
virtual memory that, when accessed, cause a fatal signal to arise.

Currently users must establish PROT_NONE ranges to achieve this.

However this is very costly memory-wise - we need a VMA for each and every
one of these regions AND they become unmergeable with surrounding VMAs.

In addition repeated mmap() calls require repeated kernel context switches
and contention of the mmap lock to install these ranges, potentially also
having to unmap memory if installed over existing ranges.

The lightweight guard approach eliminates the VMA cost altogether - rather
than establishing a PROT_NONE VMA, it operates at the level of page table
entries - poisoning PTEs such that accesses to them cause a fault followed
by a SIGSGEV signal being raised.

This is achieved through the PTE marker mechanism, which a previous commit
in this series extended to permit this to be done, installed via the
generic page walking logic, also extended by a prior commit for this
purpose.

These poison ranges are established with MADV_GUARD_POISON, and if the
range in which they are installed contain any existing mappings, they will
be zapped, i.e. free the range and unmap memory (thus mimicking the
behaviour of MADV_DONTNEED in this respect).

Any existing poison entries will be left untouched. There is no nesting of
poisoned pages.

Poisoned ranges are NOT cleared by MADV_DONTNEED, as this would be rather
unexpected behaviour, but are cleared on process teardown or unmapping of
memory ranges.

Ranges can have the poison property removed by MADV_GUARD_UNPOISON -
'remedying' the poisoning. The ranges over which this is applied, should
they contain non-poison entries, will be untouched, only poison entries
will be cleared.

We permit this operation on anonymous memory only, and only VMAs which are
non-special, non-huge and not mlock()'d (if we permitted this we'd have to
drop locked pages which would be rather counterintuitive).

The poisoning of the range must be performed under mmap write lock as we
have to install an anon_vma to ensure correct behaviour on fork.

Suggested-by: Vlastimil Babka <vbabka@suze.cz>
Suggested-by: Jann Horn <jannh@google.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/alpha/include/uapi/asm/mman.h     |   3 +
 arch/mips/include/uapi/asm/mman.h      |   3 +
 arch/parisc/include/uapi/asm/mman.h    |   3 +
 arch/xtensa/include/uapi/asm/mman.h    |   3 +
 include/uapi/asm-generic/mman-common.h |   3 +
 mm/madvise.c                           | 158 +++++++++++++++++++++++++
 mm/mprotect.c                          |   3 +-
 mm/mseal.c                             |   1 +
 8 files changed, 176 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index 763929e814e9..71e13f27742d 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -78,6 +78,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_POISON 102		/* fatal signal on access to range */
+#define MADV_GUARD_UNPOISON 103		/* revoke guard poisoning */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index 9c48d9a21aa0..1a2222322f77 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -105,6 +105,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_POISON 102		/* fatal signal on access to range */
+#define MADV_GUARD_UNPOISON 103		/* revoke guard poisoning */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index 68c44f99bc93..380905522397 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -75,6 +75,9 @@
 #define MADV_HWPOISON     100		/* poison a page for testing */
 #define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
 
+#define MADV_GUARD_POISON 102		/* fatal signal on access to range */
+#define MADV_GUARD_UNPOISON 103		/* revoke guard poisoning */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index 1ff0c858544f..e8d5affceb28 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -113,6 +113,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_POISON 102		/* fatal signal on access to range */
+#define MADV_GUARD_UNPOISON 103		/* revoke guard poisoning */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..5dfd3d442de4 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -79,6 +79,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_POISON 102		/* fatal signal on access to range */
+#define MADV_GUARD_UNPOISON 103		/* revoke guard poisoning */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/mm/madvise.c b/mm/madvise.c
index e871a72a6c32..7216e10723ae 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -60,6 +60,7 @@ static int madvise_need_mmap_write(int behavior)
 	case MADV_POPULATE_READ:
 	case MADV_POPULATE_WRITE:
 	case MADV_COLLAPSE:
+	case MADV_GUARD_UNPOISON: /* Only poisoning needs a write lock. */
 		return 0;
 	default:
 		/* be safe, default to 1. list exceptions explicitly */
@@ -1017,6 +1018,157 @@ static long madvise_remove(struct vm_area_struct *vma,
 	return error;
 }
 
+static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
+{
+	vm_flags_t disallowed = VM_SPECIAL | VM_HUGETLB;
+
+	/*
+	 * A user could lock after poisoning but that's fine, as they'd not be
+	 * able to fault in. The issue arises when we try to zap existing locked
+	 * VMAs. We don't want to do that.
+	 */
+	if (!allow_locked)
+		disallowed |= VM_LOCKED;
+
+	if (!vma_is_anonymous(vma))
+		return false;
+
+	if ((vma->vm_flags & (VM_MAYWRITE | disallowed)) != VM_MAYWRITE)
+		return false;
+
+	return true;
+}
+
+static int guard_poison_install_pte(unsigned long addr, unsigned long next,
+				    pte_t *ptep, struct mm_walk *walk)
+{
+	unsigned long *num_installed = (unsigned long *)walk->private;
+
+	(*num_installed)++;
+	/* Simply install a PTE marker, this causes segfault on access. */
+	*ptep = make_pte_marker(PTE_MARKER_GUARD);
+
+	return 0;
+}
+
+static bool is_guard_pte_marker(pte_t ptent)
+{
+	return is_pte_marker(ptent) &&
+		is_guard_swp_entry(pte_to_swp_entry(ptent));
+}
+
+static int guard_poison_pte_entry(pte_t *pte, unsigned long addr,
+				  unsigned long next, struct mm_walk *walk)
+{
+	pte_t ptent = ptep_get(pte);
+
+	/*
+	 * If not a guard marker, simply abort the operation. We return a value
+	 * > 0 indicating a non-error abort.
+	 */
+	return !is_guard_pte_marker(ptent);
+}
+
+static const struct mm_walk_ops guard_poison_walk_ops = {
+	.install_pte		= guard_poison_install_pte,
+	.pte_entry		= guard_poison_pte_entry,
+	/* We might need to install an anon_vma. */
+	.walk_lock		= PGWALK_WRLOCK,
+};
+
+static long madvise_guard_poison(struct vm_area_struct *vma,
+				 struct vm_area_struct **prev,
+				 unsigned long start, unsigned long end)
+{
+	long err;
+	bool retried = false;
+
+	*prev = vma;
+	if (!is_valid_guard_vma(vma, /* allow_locked = */false))
+		return -EINVAL;
+
+	/*
+	 * Optimistically try to install the guard poison pages first. If any
+	 * non-guard pages are encountered, give up and zap the range before
+	 * trying again.
+	 */
+	while (true) {
+		unsigned long num_installed = 0;
+
+		/* Returns < 0 on error, == 0 if success, > 0 if zap needed. */
+		err = walk_page_range_mm(vma->vm_mm, start, end,
+					 &guard_poison_walk_ops,
+					 &num_installed);
+		/*
+		 * If we install poison markers, then the range is no longer
+		 * empty from a page table perspective and therefore it's
+		 * appropriate to have an anon_vma.
+		 *
+		 * This ensures that on fork, we copy page tables correctly.
+		 */
+		if (err >= 0 && num_installed > 0) {
+			int err_anon = anon_vma_prepare(vma);
+
+			if (err_anon)
+				err = err_anon;
+		}
+
+		if (err <= 0)
+			return err;
+
+		if (!retried)
+			/*
+			 * OK some of the range have non-guard pages mapped, zap
+			 * them. This leaves existing guard pages in place.
+			 */
+			zap_page_range_single(vma, start, end - start, NULL);
+		else
+			/*
+			 * If we reach here, then there is a racing fault that
+			 * has populated the PTE after we zapped. Give up and
+			 * let the user know to try again.
+			 */
+			return -EAGAIN;
+
+		retried = true;
+	}
+}
+
+static int guard_unpoison_pte_entry(pte_t *pte, unsigned long addr,
+				    unsigned long next, struct mm_walk *walk)
+{
+	pte_t ptent = ptep_get(pte);
+
+	if (is_guard_pte_marker(ptent)) {
+		/* Simply clear the PTE marker. */
+		pte_clear_not_present_full(walk->mm, addr, pte, true);
+		update_mmu_cache(walk->vma, addr, pte);
+	}
+
+	return 0;
+}
+
+static const struct mm_walk_ops guard_unpoison_walk_ops = {
+	.pte_entry		= guard_unpoison_pte_entry,
+	.walk_lock		= PGWALK_RDLOCK,
+};
+
+static long madvise_guard_unpoison(struct vm_area_struct *vma,
+				   struct vm_area_struct **prev,
+				   unsigned long start, unsigned long end)
+{
+	*prev = vma;
+	/*
+	 * We're ok with unpoisoning mlock()'d ranges, as this is a
+	 * non-destructive action.
+	 */
+	if (!is_valid_guard_vma(vma, /* allow_locked = */true))
+		return -EINVAL;
+
+	return walk_page_range(vma->vm_mm, start, end,
+			       &guard_unpoison_walk_ops, NULL);
+}
+
 /*
  * Apply an madvise behavior to a region of a vma.  madvise_update_vma
  * will handle splitting a vm area into separate areas, each area with its own
@@ -1098,6 +1250,10 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 		break;
 	case MADV_COLLAPSE:
 		return madvise_collapse(vma, prev, start, end);
+	case MADV_GUARD_POISON:
+		return madvise_guard_poison(vma, prev, start, end);
+	case MADV_GUARD_UNPOISON:
+		return madvise_guard_unpoison(vma, prev, start, end);
 	}
 
 	anon_name = anon_vma_name(vma);
@@ -1197,6 +1353,8 @@ madvise_behavior_valid(int behavior)
 	case MADV_DODUMP:
 	case MADV_WIPEONFORK:
 	case MADV_KEEPONFORK:
+	case MADV_GUARD_POISON:
+	case MADV_GUARD_UNPOISON:
 #ifdef CONFIG_MEMORY_FAILURE
 	case MADV_SOFT_OFFLINE:
 	case MADV_HWPOISON:
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0c5d6d06107d..d0e3ebfadef8 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -236,7 +236,8 @@ static long change_pte_range(struct mmu_gather *tlb,
 			} else if (is_pte_marker_entry(entry)) {
 				/*
 				 * Ignore error swap entries unconditionally,
-				 * because any access should sigbus anyway.
+				 * because any access should sigbus/sigsegv
+				 * anyway.
 				 */
 				if (is_poisoned_swp_entry(entry))
 					continue;
diff --git a/mm/mseal.c b/mm/mseal.c
index ece977bd21e1..21bf5534bcf5 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -30,6 +30,7 @@ static bool is_madv_discard(int behavior)
 	case MADV_REMOVE:
 	case MADV_DONTFORK:
 	case MADV_WIPEONFORK:
+	case MADV_GUARD_POISON:
 		return true;
 	}
 
-- 
2.46.2


