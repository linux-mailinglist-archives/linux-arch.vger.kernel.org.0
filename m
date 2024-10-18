Return-Path: <linux-arch+bounces-8263-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5FD9A36C6
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 09:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A562B237B8
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 07:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA0D18452C;
	Fri, 18 Oct 2024 07:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lt4ebuZf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y5BtN8d/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8913178389;
	Fri, 18 Oct 2024 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235634; cv=fail; b=b6C6O/Qzz4CFQK0srjc3o/j7kX2VS5HwbvXFssQktTjq19n4SJdnzuex5iwb081aH7jI3N7wskG9GHAEj43MsxEzkz/Jmj4bCWcRcgdjt83LdRn08ule9kPOpIdt3vJ5m7WT1KI0N2xguzjegHF0PBtTQoMglRBAqk4TDNlZ9jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235634; c=relaxed/simple;
	bh=IapYk8BiSE+fzHqoT1g8LMNgY0HHjJOuXRbvy5yb4+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I9KDZMB+NQelzEgf1XC4ZWVgAC6xWc/p64JgwYrI/tUHSfcnbmQVLV59Zw8gAxM3Qfw2fzVIV6neKE2hFo9lrB7DXltUMtshGUX7ZIiU8e43IgjCFgXESkx3rPxyMBDhLUW/uvZovFydoui8QtwcGZhGkA+jpTSsTQJmeAsx8Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lt4ebuZf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y5BtN8d/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HNnP71000495;
	Fri, 18 Oct 2024 07:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=W2vnaBQk3XevzdlfK4
	ezPRRVe8nFOz7xrAxpN47xCxo=; b=Lt4ebuZfqwBojr/sut+y6JLYTqwM6DC+gw
	4FfbNGuQPYMXaAsPPcgstJadar3pQ6VVLyc6jziQHL8lW6Y/y1Ygq6SvF4lSXt60
	iyLyYNg2SvTq02jXfbzVjV+vaVlbgPVf5K486XMCdjKwtTBqoy0eAHFnE6mDin5l
	O/W8+s2/rDCWEopcWnnIEJvKvOr2mU0frGlZQaKy+gYXiGoc3Bv34aT88PD2EFZ5
	AyDAO5HZ4cvg0GVSVFC50ubdsn1pbzje2EKhQzimKH0rni/J4bKzqNOqQUoCCIGO
	dXNicuf+X47QJ6ZFK7whoTwcLWZF8RKlF1a254maM5lYk0ZJ73mQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hntg3wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 07:13:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49I650wx010406;
	Fri, 18 Oct 2024 07:12:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjhkr1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 07:12:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcRPB7L4xsTljqeszP6xf3ZNR9J+TQT+4c5pzbkmnB5gJWtyiRYZ4OJKrWBKnj0Roh1qlgvCBMapiH9MZ7kl/uLxlz0OJAnjXFwJ1B5aJH4OQZDRa29uNbBJcbpa0b0pBZfKTc5NtMsvsB5KEuxlm0TGQUpvGxJqso4jHeN68wD8xsTnmFUU3enUbQtlpWoGdP5nZkzpHMdshkV2MG8NhxnOpGPqvGUBwHhT0uas0ILzAFU0+6x04seS0sfuBty3ZnSH+r9yGL0N+ooVA5zUJwB7aYe2fqtiEMZrLzAByh5hLfiD/8eNGxbNmYubFIirWIukqR75el97h6nRwNZIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2vnaBQk3XevzdlfK4ezPRRVe8nFOz7xrAxpN47xCxo=;
 b=wszw+Ft3Ysn+dJH+diLK6W8vFSFCL0k8Zj9DjkOzEAQ1Tbb5Mx9fHsiUEwOcx6hPiPYxPp4Gqi/qtl1LPcy1FtQPr9j2oIRZGhskwDUsq9YFZ65k6hD+q5jmBzB4FeqxeoNomhtBwyBB43YQoXIKphm675V+Q3XZ2gTSaoMROOhfKjJICyGdqlde0rLn6BL3yqCcpXaJRN5A0a8iozls/zpTbTNRF/TCIYO03ZDBSCaR4l75F9E4e4iIObVBqkbbhUp8ih2joCi4bYFXpS0/uaxDhzBMjAZmBjFuHO7jc5sLb/sWRdApSSC2Cw+pmfz4ci6q88RGVrp3QyXxVP+CrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2vnaBQk3XevzdlfK4ezPRRVe8nFOz7xrAxpN47xCxo=;
 b=Y5BtN8d/EX8VqLzFxz5V9iFbYc9pTd0uvkaacbHTkceLqBMrzQNcxz+hWWrVBD1u39sce26uC0F+EC2Bqa+ml8MJe7wPccKezfIGMWaMdW7y7mmunhf7v+XJc4n5X2yUTsfwTk8QIbTGyXO6ekRaSMKcl+oTC8BKvao++6YAU2I=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA1PR10MB5821.namprd10.prod.outlook.com (2603:10b6:806:232::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Fri, 18 Oct
 2024 07:12:53 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 07:12:53 +0000
Date: Fri, 18 Oct 2024 08:12:49 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
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
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/4] selftests/mm: add self tests for guard page feature
Message-ID: <dfbf9ccb-6834-4181-a382-35c9c9af8064@lucifer.local>
References: <cover.1729196871.git.lorenzo.stoakes@oracle.com>
 <8b1add3c511effb62d68183cae8a954d8339286c.1729196871.git.lorenzo.stoakes@oracle.com>
 <1d0bbc60-fda7-4c14-bf02-948bdbf8f029@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d0bbc60-fda7-4c14-bf02-948bdbf8f029@linuxfoundation.org>
X-ClientProxiedBy: LO4P265CA0259.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::9) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA1PR10MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 987472fe-f827-456b-6c21-08dcef444827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FHWHPQGr5jh+UuElKKyhkzA3wY9I/vt3Alu97dvHl4rQwA4I/fUg5UwUFXLP?=
 =?us-ascii?Q?DXafM7llevwE9tHvcKDgOTQmS0S02uskTutN172JIgzerFkkgevhyiq+ljsl?=
 =?us-ascii?Q?KgV7QW9TmhsUGyRTWL4v1uUnY2RI23TDBD6mtKgcLfuxHHB6Nrokf9JBv3On?=
 =?us-ascii?Q?FDEpR9WV7s3bFy03Nt2fcrg25j0IzWM8yecJQr+luezqzgIXlcYq1CR/zY+S?=
 =?us-ascii?Q?B3K/3sWZceXBzq/pOvNv0242O1TRVLNxjMEgJU5wuRqy88wAXP4QVW5SxuAT?=
 =?us-ascii?Q?DnSTnGkzgQYY/8KhDezn54Xc3ELmw2UWwvbp0lJBdZwFpKeMnFKdecgHSR9O?=
 =?us-ascii?Q?moRPIGv18m+g13LPvmLHdVixoLyNcwL3QgVl2H94nJpkumPSNrYMrDTlkIB+?=
 =?us-ascii?Q?eyCZYjcHExByCGM3CXDsmbnaOVyhZ53O12VfcSaE9sqArbejPBplSng39NfB?=
 =?us-ascii?Q?+BS8vamnycI92nPqMJbjTGIMz4hXKEo5s+Llampx3+CA8R70foLUSc1arjLQ?=
 =?us-ascii?Q?6K767ujXCbZqO/fhWzIDIHIYtjVYdZEso/TSf2eUZ2za7LkRrSbLa1D98Mak?=
 =?us-ascii?Q?XKLyfL9BbJvnRRRwLrGBswMHaLx4rJLb/gtJWvzx/XTHNnlyYrKET45je4gf?=
 =?us-ascii?Q?Qm4tNmeN/ASGfwb3NfxZbvgB4xHGNIC35+l4m5C1+xvEVTHDGD0F1nLUvBdY?=
 =?us-ascii?Q?I6mgFLwkLk350Qb7wO31WtZ34C7YloNOtmR/MNiEeBL2A1XwigoRTOQ5D1an?=
 =?us-ascii?Q?YGF5u/OhxshRGF7gR9M53V+AmCkaugFc94W0wcdAedjxKUq+k4tpOoR+3XVK?=
 =?us-ascii?Q?v9R320MKWaszeL+OmkBEBpRkM+2Iatu77uXkbGSKsy6YhTEw9e8P9q89SjSv?=
 =?us-ascii?Q?cZPzK6UJnk6vxOo08tQFSgK+p7S6bt44WwAvj1z2XF9326y52xNfl0gCCD2E?=
 =?us-ascii?Q?hDOd0VntXPskqapqLYsQfajD4xA/k8Ht9ayajSdq5/hGREMkvjtzsOS5fhLK?=
 =?us-ascii?Q?XwX6VGP/obLsOcuHBVjKeL735pjcdakRN+FulQU+27c7mt6oMpGz+3EJ7ss3?=
 =?us-ascii?Q?KoN47A2aH4TKlHZswLLx4hKviY9HU4G6HECMsvZqk4aSJkshw9Q0nSzwwcnK?=
 =?us-ascii?Q?sE852kGESmGmsKlN0P3LVOfnapsr3nqkg3IgCSNKb+W05vPkZf4gFTVlv6kq?=
 =?us-ascii?Q?w9AtSKafwx6dKiaWW9zesIGleBpONXyCye0aUAWkyW57gF0kVykKx6vNfL5a?=
 =?us-ascii?Q?IBS+fuvDXSowMuX1pG2iXS04RU9TKj5ykdYMt+NIJVf5R90udz8xv8sXkGQ8?=
 =?us-ascii?Q?hg+KmLPnWiFtwn+ePwElzsXz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RSEzTeMNDDX0r4UlPWLIX0D72e69i++rDagJi4yAjUNXiK1P9QCMyiRupFKw?=
 =?us-ascii?Q?6Tvz08b5Qz2+AGhr4tOYNYphA32LenErahi5PCNgDetft+lZbUNI/1t/S0lI?=
 =?us-ascii?Q?ZkW2vElOZzmoZ6LIiqpT4dd4OZdmV23ILWwNAOVIVRinHDegHb0WeQL1xVNh?=
 =?us-ascii?Q?InOUeRYR/PFGJPhkOwEyJYMDSBANacNmnJ/9lee+FkUTwYX4Wb8a4Deedr7x?=
 =?us-ascii?Q?g0kSojgIi2gb43NXiqrpe+4zRQ8KDtjX5TKH51j12UNgFgyibho/JRnf7Eh+?=
 =?us-ascii?Q?GCFQ6kTR2r61LX417xmxs0M+5gA3cA6Flf1qiidh056kGCT3CFLg7aatjkrY?=
 =?us-ascii?Q?kKXhDfIF1xalFrZMy4ZcvO9H9AAX3JGctxb9SAtk2A+GSuNeKfonZz4c0nkt?=
 =?us-ascii?Q?f6qabYyIyHU4zrCeFdVAsuOwFKRpMCHhz/zmb2mJWjRqvnPq+R7T8R6YriRf?=
 =?us-ascii?Q?n2kLWKR82HpoQ/dz1KNCxuj/SvygwYeBt05BkDLHVtw6ODjz2Fu32RcftJdR?=
 =?us-ascii?Q?wRGQJMIQTG2NniQqjHIW2ZbqBoT05zW7l7PwUCLFXeL3scnAkrqL4yDP3Wx2?=
 =?us-ascii?Q?xRMT9IRaenauvKUHbnMKn9EN6rY6G6qYfPQqi8Q2PjE1Dea2RdJqIWvDXF3e?=
 =?us-ascii?Q?LTMNs85+5opg/EbizFqbDeESuSA4hWn926L/xfYlS/g/4oI0SrqchFwhjVBB?=
 =?us-ascii?Q?zhJ7UtIZQuQQu+E/4Qk0HCMPkljSnR5RVEfNDuclpbsMmDHcqPM66GD6b9WB?=
 =?us-ascii?Q?XbveiFZkm/k4Ke84ajWMRJxw+PorrvXXjqejOpiZEKXCzRFK5N/0xazie8Hm?=
 =?us-ascii?Q?1oibUKxYe2q9B0U6Lo67V6I7yW+02yqWVDCBzOShgfR7eEnAd57K4lRKQfCm?=
 =?us-ascii?Q?vZf+W0YWTq5n1a7EqcMQYxOBEeFvCJs66+5Pzdj97qyRFKExen8IKzFy3cdC?=
 =?us-ascii?Q?muaHkqw2XGjGLqQGuVP6RfOPS+bFNa7zzfXOYkMRr7NDyptE8rN52zw07OHK?=
 =?us-ascii?Q?gCfDyXo08ClD0EyRBn7vGivsk0YMQlsAwjPSQE33WasCBCBfjRB41DWAxwwD?=
 =?us-ascii?Q?nvGuipClkAM06Vx9k9SO4m6PtXcEDprKFESJ6EUYiySyr3XiUWCwPRTDCgS1?=
 =?us-ascii?Q?5/MgRh8bIC2GnkGaLSakJQ+rbWLUDC6rXwOwEKGHY65R15GL4BUDYannj8wq?=
 =?us-ascii?Q?KM31QxVfHrNR88N4oKmCzKuq/SJJkGc872sbDsS9PPHTjG7yZjrr/leOOGdR?=
 =?us-ascii?Q?Jy1lBZDCYxWXzSL67x0fp8Mc1bot6QMNJMx+EJiNobT8p4dEK4570T4OMftD?=
 =?us-ascii?Q?Raag2hSC+XmiVsiBWcMtZHKAdXixtMTge/pCCIzpr89BCyk+bt0s4xzbpAAG?=
 =?us-ascii?Q?mnVSTJnb441NeyYTQa4jDD6gYS9q+2lHvnchYWdMmGMz9fY37FR1EBfbHHny?=
 =?us-ascii?Q?YLFkPXFHFMLccUhxndNBiHnTD06olldKO+kGtExkeHZEIjx089P8DbA7eL6w?=
 =?us-ascii?Q?a2Q0epe+xMUQBiccbqkHrUaXBDjGSv6KBqdcu2lFQNvMJLIO0Qj49MZSWzNE?=
 =?us-ascii?Q?PQ0hY1kCZg/ncaF1FPVdTxpMRUQKY0gWhNaFejtbfeTfKm1L0lUJVS1jJ33P?=
 =?us-ascii?Q?8+Vv4o74CTbrSgYutZgEb6720a9MoDWQv0PJxBRP/pp2+GTHfEtDSLyn9qfn?=
 =?us-ascii?Q?MNpvWw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s5Nbja+GYBpbfedDaRs8rx11tdh4FBMS6ZTEOeK5FSH5T6mxG6LuP959aBSGvmvG9e+ErYnIiOrEVU5zFVLhYpfybcrFSoMkLadzHTd+K64KP1FvG1DcieOC/knr43tpsXzWELlQ4xhay9nXyjA6szCkYLxrNk7vrVhMKjf+4T8Fj7Oi+sUhlo5nz1cuRHbk5ICT5Mrpq5VpNL99j+4vyQMSqCefPVjQqTcaAba/rz+WL1C/NDPxg213c5yJ6zMjTvaQHGSuCyr5IZRDRBy045yiy8fb5A9yhJLyt+2+hn/T3vEfNMZovntLWs/Dlt2MIQ2TYr1TZVND6zvUAuMJ8ZKMfs5O2jrNkBW5RLdWuOTy6boBxxvQYfaymNFI9mKmGALLxRRJpUWNvftgqIS8SK8X0CDUXpHnN0Roe8FWc2oHHs5ZMplbp696o7zyWtxRm1rtoCAdmRcjuPbtgPNjpXgir2QA8R/GApXmjxT4SRYzOQ6fiL6Q9YS3EMo6cp8vcbunLl1bZqFJuKPOJ2YI2i+mQPmCoYoTgvgRKD7A6ccRfVu7kAzYjvai0DDowUG1qIwamH8tofYu6sZdgs9CoHQi34x/QLYTtrWvg/NdLFU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987472fe-f827-456b-6c21-08dcef444827
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 07:12:53.0047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0Hx0HuBBVtfNLRMMarsd3pO7p/UQka1N7dWli906jKBPtj9y2OKv3DXLKAFdsBWFy/eT/RR5lhPk+Wv1Cq6/61yHBoYFzbbnYbmi6aLVTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5821
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_02,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180044
X-Proofpoint-ORIG-GUID: mPtsHFRUJLAp8_Nt_y7NvWlhKBIIeug6
X-Proofpoint-GUID: mPtsHFRUJLAp8_Nt_y7NvWlhKBIIeug6

On Thu, Oct 17, 2024 at 03:24:49PM -0600, Shuah Khan wrote:
> On 10/17/24 14:42, Lorenzo Stoakes wrote:
> > Utilise the kselftest harmness to implement tests for the guard page
>
> Splleing NIT - harmness -> harness
>
> > implementation.
> >
> > We start by implement basic tests asserting that guard pages can be
>
> implmenting? By the way checkpatch will catch spelling stuuf.
> Please see comments about warnings below.

Thanks. The majority of the checkpatch warnings are invalid so I missed
this. Will fix on respin.

>
> > established (poisoned), cleared (remedied) and that touching poisoned pages
> > result in SIGSEGV. We also assert that, in remedying a range, non-poison
> > pages remain intact.
> >
> > We then examine different operations on regions containing poison markers
> > behave to ensure correct behaviour:
> >
> > * Operations over multiple VMAs operate as expected.
> > * Invoking MADV_GUARD_POISION / MADV_GUARD_REMEDY via process_madvise() in
> >    batches works correctly.
> > * Ensuring that munmap() correctly tears down poison markers.
> > * Using mprotect() to adjust protection bits does not in any way override
> >    or cause issues with poison markers.
> > * Ensuring that splitting and merging VMAs around poison markers causes no
> >    issue - i.e. that a marker which 'belongs' to one VMA can function just
> >    as well 'belonging' to another.
> > * Ensuring that madvise(..., MADV_DONTNEED) does not remove poison markers.
> > * Ensuring that mlock()'ing a range containing poison markers does not
> >    cause issues.
> > * Ensuring that mremap() can move a poisoned range and retain poison
> >    markers.
> > * Ensuring that mremap() can expand a poisoned range and retain poison
> >    markers (perhaps moving the range).
> > * Ensuring that mremap() can shrink a poisoned range and retain poison
> >    markers.
> > * Ensuring that forking a process correctly retains poison markers.
> > * Ensuring that forking a VMA with VM_WIPEONFORK set behaves sanely.
> > * Ensuring that lazyfree simply clears poison markers.
> > * Ensuring that userfaultfd can co-exist with guard pages.
> > * Ensuring that madvise(..., MADV_POPULATE_READ) and
> >    madvise(..., MADV_POPULATE_WRITE) error out when encountering
> >    poison markers.
> > * Ensuring that madvise(..., MADV_COLD) and madvise(..., MADV_PAGEOUT) do
> >    not remove poison markers.
>
> Good summary of test. Does the test require root access?
> If so does it check and skip appropriately?

Thanks and some do, in those cases we skip.

>
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >   tools/testing/selftests/mm/.gitignore    |    1 +
> >   tools/testing/selftests/mm/Makefile      |    1 +
> >   tools/testing/selftests/mm/guard-pages.c | 1168 ++++++++++++++++++++++
> >   3 files changed, 1170 insertions(+)
> >   create mode 100644 tools/testing/selftests/mm/guard-pages.c
> >
> > diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> > index 689bbd520296..8f01f4da1c0d 100644
> > --- a/tools/testing/selftests/mm/.gitignore
> > +++ b/tools/testing/selftests/mm/.gitignore
> > @@ -54,3 +54,4 @@ droppable
> >   hugetlb_dio
> >   pkey_sighandler_tests_32
> >   pkey_sighandler_tests_64
> > +guard-pages
> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> > index 02e1204971b0..15c734d6cfec 100644
> > --- a/tools/testing/selftests/mm/Makefile
> > +++ b/tools/testing/selftests/mm/Makefile
> > @@ -79,6 +79,7 @@ TEST_GEN_FILES += hugetlb_fault_after_madv
> >   TEST_GEN_FILES += hugetlb_madv_vs_map
> >   TEST_GEN_FILES += hugetlb_dio
> >   TEST_GEN_FILES += droppable
> > +TEST_GEN_FILES += guard-pages
> >   ifneq ($(ARCH),arm64)
> >   TEST_GEN_FILES += soft-dirty
> > diff --git a/tools/testing/selftests/mm/guard-pages.c b/tools/testing/selftests/mm/guard-pages.c
> > new file mode 100644
> > index 000000000000..2ab0ff3ba5a0
> > --- /dev/null
> > +++ b/tools/testing/selftests/mm/guard-pages.c
> > @@ -0,0 +1,1168 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +#define _GNU_SOURCE
> > +#include "../kselftest_harness.h"
> > +#include <assert.h>
> > +#include <fcntl.h>
> > +#include <setjmp.h>
> > +#include <errno.h>
> > +#include <linux/userfaultfd.h>
> > +#include <signal.h>
> > +#include <stdbool.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <sys/ioctl.h>
> > +#include <sys/mman.h>
> > +#include <sys/syscall.h>
> > +#include <sys/uio.h>
> > +#include <unistd.h>
> > +
> > +/* These may not yet be available in the uAPI so define if not. */
> > +
> > +#ifndef MADV_GUARD_POISON
> > +#define MADV_GUARD_POISON	102
> > +#endif
> > +
> > +#ifndef MADV_GUARD_UNPOISON
> > +#define MADV_GUARD_UNPOISON	103
> > +#endif
> > +
> > +volatile bool signal_jump_set;
>
> Can you add a comment about why volatile is needed.

I'm not sure it's really necessary, it's completely standard to do this
with signal handling and is one of the exceptions to the 'volatile
considered harmful' rule.

> By the way did you happen to run checkpatck on this. There are
> several instances where single statement blocks with braces {}
>
> I noticed a few and ran checkpatch on your patch. There are
> 45 warnings regarding codeing style.
>
> Please run checkpatch and clean them up so we can avoid followup
> checkpatch cleanup patches.

No sorry I won't, checkpatch isn't infallible and series trying to 'clean
up' things that aren't issues will be a waste of everybody's time.

There are cases where removing the braces results in compilation error so
obviously we can't remove them, in others it seriously hurts readability.

>
> > +sigjmp_buf signal_jmp_buf;
> > +
> > +static int userfaultfd(int flags)
> > +{
> > +	return syscall(SYS_userfaultfd, flags);
> > +}
> > +
> > +static void handle_fatal(int c)
> > +{
> > +	if (!signal_jump_set)
> > +		return;
> > +
> > +	siglongjmp(signal_jmp_buf, c);
> > +}
> > +
> > +static int pidfd_open(pid_t pid, unsigned int flags)
> > +{
> > +	return syscall(SYS_pidfd_open, pid, flags);
> > +}
> > +
> > +/*
> > + * Enable our signal catcher and try to read/write the specified buffer. The
> > + * return value indicates whether the read/write succeeds without a fatal
> > + * signal.
> > + */
> > +static bool try_access_buf(char *ptr, bool write)
> > +{
> > +	bool failed;
> > +
> > +	/* Tell signal handler to jump back here on fatal signal. */
> > +	signal_jump_set = true;
> > +	/* If a fatal signal arose, we will jump back here and failed is set. */
> > +	failed = sigsetjmp(signal_jmp_buf, 0) != 0;
> > +
> > +	if (!failed) {
> > +		if (write) {
> > +			*ptr = 'x';
> > +		} else {
> > +			const volatile char *chr = ptr;
> > +
> > +			/* Force read. */
> > +			(void)*chr;
> > +		}
> > +	}
> > +
> > +	signal_jump_set = false;
> > +	return !failed;
> > +}
> > +
> > +/* Try and read from a buffer, return true if no fatal signal. */
> > +static bool try_read_buf(char *ptr)
> > +{
> > +	return try_access_buf(ptr, false);
> > +}
> > +
> > +/* Try and write to a buffer, return true if no fatal signal. */
> > +static bool try_write_buf(char *ptr)
> > +{
> > +	return try_access_buf(ptr, true);
> > +}
> > +
> > +/*
> > + * Try and BOTH read from AND write to a buffer, return true if BOTH operations
> > + * succeed.
> > + */
> > +static bool try_read_write_buf(char *ptr)
> > +{
> > +	return try_read_buf(ptr) && try_write_buf(ptr);
> > +}
> > +
> > +FIXTURE(guard_pages)
> > +{
> > +	unsigned long page_size;
> > +};
> > +
> > +FIXTURE_SETUP(guard_pages)
> > +{
> > +	struct sigaction act = {
> > +		.sa_handler = &handle_fatal,
> > +		.sa_flags = SA_NODEFER,
> > +	};
> > +
> > +	sigemptyset(&act.sa_mask);
> > +	if (sigaction(SIGSEGV, &act, NULL)) {
> > +		perror("sigaction");
> > +		ksft_exit_fail();
>
> Replase the above two with ksft_exit_fail_perror()
> There is no need for perror("sigaction"); followed by
> ksft_exit_fail();

Ack will do on respin. Thanks for the tip! Wasn't aware of that.

>
> > +	}
> > +
> > +	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
> > +};
> > +
> > +FIXTURE_TEARDOWN(guard_pages)
> > +{
> > +	struct sigaction act = {
> > +		.sa_handler = SIG_DFL,
> > +		.sa_flags = SA_NODEFER,
> > +	};
> > +
> > +	sigemptyset(&act.sa_mask);
> > +	sigaction(SIGSEGV, &act, NULL);
> > +}
> > +
> > +TEST_F(guard_pages, basic)
> > +{
> > +	const unsigned long NUM_PAGES = 10;
> > +	const unsigned long page_size = self->page_size;
> > +	char *ptr;
> > +	int i;
> > +
> > +	ptr = mmap(NULL, NUM_PAGES * page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_PRIVATE | MAP_ANON, -1, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +
> > +	/* Trivially assert we can touch the first page. */
> > +	ASSERT_TRUE(try_read_write_buf(ptr));
> > +
> > +	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
> > +
> > +	/* Establish that 1st page SIGSEGV's. */
> > +	ASSERT_FALSE(try_read_write_buf(ptr));
> > +
> > +	/* Ensure we can touch everything else.*/
> > +	for (i = 1; i < NUM_PAGES; i++) {
> > +		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
> > +	}
> > +
> > +	/* Establish a guard page at the end of the mapping. */
> > +	ASSERT_EQ(madvise(&ptr[(NUM_PAGES - 1) * page_size], page_size,
> > +			  MADV_GUARD_POISON), 0);
> > +
> > +	/* Check that both guard pages result in SIGSEGV. */
> > +	ASSERT_FALSE(try_read_write_buf(ptr));
> > +	ASSERT_FALSE(try_read_write_buf(&ptr[(NUM_PAGES - 1) * page_size]));
> > +
> > +	/* Unpoison the first. */
> > +	ASSERT_FALSE(madvise(ptr, page_size, MADV_GUARD_UNPOISON));
> > +
> > +	/* Make sure we can touch it. */
> > +	ASSERT_TRUE(try_read_write_buf(ptr));
> > +
> > +	/* Unpoison the last. */
> > +	ASSERT_FALSE(madvise(&ptr[(NUM_PAGES - 1) * page_size], page_size,
> > +			     MADV_GUARD_UNPOISON));
> > +
> > +	/* Make sure we can touch it. */
> > +	ASSERT_TRUE(try_read_write_buf(&ptr[(NUM_PAGES - 1) * page_size]));
> > +
> > +	/*
> > +	 *  Test setting a _range_ of pages, namely the first 3. The first of
> > +	 *  these be faulted in, so this also tests that we can poison backed
> > +	 *  pages.
> > +	 */
> > +	ASSERT_EQ(madvise(ptr, 3 * page_size, MADV_GUARD_POISON), 0);
> > +
> > +	/* Make sure they are all poisoned. */
> > +	for (i = 0; i < 3; i++) {
> > +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> > +	}
> > +
>
> This one here and

Refer you to other comments around this, it hurts readability to do that.

> > +	/* Make sure the rest are not. */
> > +	for (i = 3; i < NUM_PAGES; i++) {
> > +		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
> > +	}
> > +
> > +	/* Unpoison them. */
> > +	ASSERT_EQ(madvise(ptr, NUM_PAGES * page_size, MADV_GUARD_UNPOISON), 0);
> > +
> > +	/* Now make sure we can touch everything. */
> > +	for (i = 0; i < NUM_PAGES; i++) {
> > +		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
> > +	}
> > +
> > +	/* Now unpoison everything, make sure we don't remove existing entries */
> > +	ASSERT_EQ(madvise(ptr, NUM_PAGES * page_size, MADV_GUARD_UNPOISON), 0);
> > +
> > +	for (i = 0; i < NUM_PAGES * page_size; i += page_size) {
> > +		ASSERT_EQ(ptr[i], 'x');
> > +	}
> > +
> > +	ASSERT_EQ(munmap(ptr, NUM_PAGES * page_size), 0);
> > +}
> > +
> > +/* Assert that operations applied across multiple VMAs work as expected. */
> > +TEST_F(guard_pages, multi_vma)
> > +{
> > +	const unsigned long page_size = self->page_size;
> > +	char *ptr_region, *ptr, *ptr1, *ptr2, *ptr3;
> > +	int i;
> > +
> > +	/* Reserve a 100 page region over which we can install VMAs. */
> > +	ptr_region = mmap(NULL, 100 * page_size, PROT_NONE,
> > +			  MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr_region, MAP_FAILED);
> > +
> > +	/* Place a VMA of 10 pages size at the start of the region. */
> > +	ptr1 = mmap(ptr_region, 10 * page_size, PROT_READ | PROT_WRITE,
> > +		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr1, MAP_FAILED);
> > +
> > +	/* Place a VMA of 5 pages size 50 pages into the region. */
> > +	ptr2 = mmap(&ptr_region[50 * page_size], 5 * page_size,
> > +		    PROT_READ | PROT_WRITE,
> > +		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr2, MAP_FAILED);
> > +
> > +	/* Place a VMA of 20 pages size at the end of the region. */
> > +	ptr3 = mmap(&ptr_region[80 * page_size], 20 * page_size,
> > +		    PROT_READ | PROT_WRITE,
> > +		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr3, MAP_FAILED);
> > +
> > +	/* Unmap gaps. */
> > +	ASSERT_EQ(munmap(&ptr_region[10 * page_size], 40 * page_size), 0);
> > +	ASSERT_EQ(munmap(&ptr_region[55 * page_size], 25 * page_size), 0);
> > +
> > +	/*
> > +	 * We end up with VMAs like this:
> > +	 *
> > +	 * 0    10 .. 50   55 .. 80   100
> > +	 * [---]      [---]      [---]
> > +	 */
> > +
> > +	/* Now poison the whole range and make sure all VMAs are poisoned. */
> > +
> > +	/*
> > +	 * madvise() is certifiable and lets you perform operations over gaps,
> > +	 * everything works, but it indicates an error and errno is set to
> > +	 * -ENOMEM. Also if anything runs out of memory it is set to
> > +	 * -ENOMEM. You are meant to guess which is which.
> > +	 */
> > +	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_POISON), -1);
> > +	ASSERT_EQ(errno, ENOMEM);
> > +
> > +	for (i = 0; i < 10; i++) {
> > +		ASSERT_FALSE(try_read_write_buf(&ptr1[i * page_size]));
> > +	}
> > +
> > +	for (i = 0; i < 5; i++) {
> > +		ASSERT_FALSE(try_read_write_buf(&ptr2[i * page_size]));
> > +	}
> > +
> > +	for (i = 0; i < 20; i++) {
> > +		ASSERT_FALSE(try_read_write_buf(&ptr3[i * page_size]));
> > +	}
> > +
> > +	/* Now unpoison the range and assert the opposite. */
> > +
> > +	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_UNPOISON), -1);
> > +	ASSERT_EQ(errno, ENOMEM);
> > +
> > +	for (i = 0; i < 10; i++) {
> > +		ASSERT_TRUE(try_read_write_buf(&ptr1[i * page_size]));
> > +	}
> > +
> > +	for (i = 0; i < 5; i++) {
> > +		ASSERT_TRUE(try_read_write_buf(&ptr2[i * page_size]));
> > +	}
> > +
> > +	for (i = 0; i < 20; i++) {
> > +		ASSERT_TRUE(try_read_write_buf(&ptr3[i * page_size]));
> > +	}
> > +
> > +	/* Now map incompatible VMAs in the gaps. */
> > +	ptr = mmap(&ptr_region[10 * page_size], 40 * page_size,
> > +		   PROT_READ | PROT_WRITE | PROT_EXEC,
> > +		   MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +	ptr = mmap(&ptr_region[55 * page_size], 25 * page_size,
> > +		   PROT_READ | PROT_WRITE | PROT_EXEC,
> > +		   MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +
> > +	/*
> > +	 * We end up with VMAs like this:
> > +	 *
> > +	 * 0    10 .. 50   55 .. 80   100
> > +	 * [---][xxxx][---][xxxx][---]
> > +	 *
> > +	 * Where 'x' signifies VMAs that cannot be merged with those adjacent to
> > +	 * them.
> > +	 */
> > +
> > +	/* Multiple VMAs adjacent to one another should result in no error. */
> > +	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_POISON), 0);
> > +	for (i = 0; i < 100; i++) {
> > +		ASSERT_FALSE(try_read_write_buf(&ptr_region[i * page_size]));
> > +	}
> > +	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_UNPOISON), 0);
> > +	for (i = 0; i < 100; i++) {
> > +		ASSERT_TRUE(try_read_write_buf(&ptr_region[i * page_size]));
> > +	}
> > +
> > +	/* Cleanup. */
> > +	ASSERT_EQ(munmap(ptr_region, 100 * page_size), 0);
> > +}
> > +
> > +/*
> > + * Assert that batched operations performed using process_madvise() work as
> > + * expected.
> > + */
> > +TEST_F(guard_pages, process_madvise)
> > +{
> > +	const unsigned long page_size = self->page_size;
> > +	pid_t pid = getpid();
> > +	int pidfd = pidfd_open(pid, 0);
> > +	char *ptr_region, *ptr1, *ptr2, *ptr3;
> > +	ssize_t count;
> > +	struct iovec vec[6];
> > +
> > +	ASSERT_NE(pidfd, -1);
> > +
> > +	/* Reserve region to map over. */
> > +	ptr_region = mmap(NULL, 100 * page_size, PROT_NONE,
> > +			  MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr_region, MAP_FAILED);
> > +
> > +	/* 10 pages offset 1 page into reserve region. */
> > +	ptr1 = mmap(&ptr_region[page_size], 10 * page_size,
> > +		    PROT_READ | PROT_WRITE,
> > +		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr1, MAP_FAILED);
> > +	/* We want poison markers at start/end of each VMA. */
> > +	vec[0].iov_base = ptr1;
> > +	vec[0].iov_len = page_size;
> > +	vec[1].iov_base = &ptr1[9 * page_size];
> > +	vec[1].iov_len = page_size;
> > +
> > +	/* 5 pages offset 50 pages into reserve region. */
> > +	ptr2 = mmap(&ptr_region[50 * page_size], 5 * page_size,
> > +		    PROT_READ | PROT_WRITE,
> > +		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr2, MAP_FAILED);
> > +	vec[2].iov_base = ptr2;
> > +	vec[2].iov_len = page_size;
> > +	vec[3].iov_base = &ptr2[4 * page_size];
> > +	vec[3].iov_len = page_size;
> > +
> > +	/* 20 pages offset 79 pages into reserve region. */
> > +	ptr3 = mmap(&ptr_region[79 * page_size], 20 * page_size,
> > +		    PROT_READ | PROT_WRITE,
> > +		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr3, MAP_FAILED);
> > +	vec[4].iov_base = ptr3;
> > +	vec[4].iov_len = page_size;
> > +	vec[5].iov_base = &ptr3[19 * page_size];
> > +	vec[5].iov_len = page_size;
> > +
> > +	/* Free surrounding VMAs. */
> > +	ASSERT_EQ(munmap(ptr_region, page_size), 0);
> > +	ASSERT_EQ(munmap(&ptr_region[11 * page_size], 39 * page_size), 0);
> > +	ASSERT_EQ(munmap(&ptr_region[55 * page_size], 24 * page_size), 0);
> > +	ASSERT_EQ(munmap(&ptr_region[99 * page_size], page_size), 0);
> > +
> > +	/* Now poison in one step. */
> > +	count = process_madvise(pidfd, vec, 6, MADV_GUARD_POISON, 0);
> > +
> > +	/* OK we don't have permission to do this, skip. */
> > +	if (count == -1 && errno == EPERM)
> > +		ksft_exit_skip("No process_madvise() permissions\n");
>
> Can you make this a bit more informative? What would user do
> if they see this message? Are they supposed to run the test
> as root?

OK can update on respin.

>
> > +
> > +	/* Returns the number of bytes advised. */
> > +	ASSERT_EQ(count, 6 * page_size);
> > +
> > +	/* Now make sure the poisoning was applied. */
> > +
> > +	ASSERT_FALSE(try_read_write_buf(ptr1));
> > +	ASSERT_FALSE(try_read_write_buf(&ptr1[9 * page_size]));
> > +
> > +	ASSERT_FALSE(try_read_write_buf(ptr2));
> > +	ASSERT_FALSE(try_read_write_buf(&ptr2[4 * page_size]));
> > +
> > +	ASSERT_FALSE(try_read_write_buf(ptr3));
> > +	ASSERT_FALSE(try_read_write_buf(&ptr3[19 * page_size]));
> > +
> > +	/* Now do the same with unpoison... */
> > +	count = process_madvise(pidfd, vec, 6, MADV_GUARD_UNPOISON, 0);
> > +
> > +	/* ...and everything should now succeed. */
> > +
> > +	ASSERT_TRUE(try_read_write_buf(ptr1));
> > +	ASSERT_TRUE(try_read_write_buf(&ptr1[9 * page_size]));
> > +
> > +	ASSERT_TRUE(try_read_write_buf(ptr2));
> > +	ASSERT_TRUE(try_read_write_buf(&ptr2[4 * page_size]));
> > +
> > +	ASSERT_TRUE(try_read_write_buf(ptr3));
> > +	ASSERT_TRUE(try_read_write_buf(&ptr3[19 * page_size]));
> > +
> > +	/* Cleanup. */
> > +	ASSERT_EQ(munmap(ptr1, 10 * page_size), 0);
> > +	ASSERT_EQ(munmap(ptr2, 5 * page_size), 0);
> > +	ASSERT_EQ(munmap(ptr3, 20 * page_size), 0);
> > +	close(pidfd);
> > +}
> > +
> > +/* Assert that unmapping ranges does not leave poison behind. */
> > +TEST_F(guard_pages, munmap)
> > +{
> > +	const unsigned long page_size = self->page_size;
> > +	char *ptr, *ptr_new1, *ptr_new2;
> > +
> > +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +
> > +	/* Poison first and last pages. */
> > +	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
> > +	ASSERT_EQ(madvise(&ptr[9 * page_size], page_size, MADV_GUARD_POISON), 0);
> > +
> > +	/* Assert that they are poisoned. */
> > +	ASSERT_FALSE(try_read_write_buf(ptr));
> > +	ASSERT_FALSE(try_read_write_buf(&ptr[9 * page_size]));
> > +
> > +	/* Unmap them. */
> > +	ASSERT_EQ(munmap(ptr, page_size), 0);
> > +	ASSERT_EQ(munmap(&ptr[9 * page_size], page_size), 0);
> > +
> > +	/* Map over them.*/
> > +	ptr_new1 = mmap(ptr, page_size, PROT_READ | PROT_WRITE,
> > +			MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr_new1, MAP_FAILED);
> > +	ptr_new2 = mmap(&ptr[9 * page_size], page_size, PROT_READ | PROT_WRITE,
> > +			MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr_new2, MAP_FAILED);
> > +
> > +	/* Assert that they are now not poisoned. */
> > +	ASSERT_TRUE(try_read_write_buf(ptr_new1));
> > +	ASSERT_TRUE(try_read_write_buf(ptr_new2));
> > +
> > +	/* Cleanup. */
> > +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> > +}
> > +
> > +/* Assert that mprotect() operations have no bearing on guard poison markers. */
> > +TEST_F(guard_pages, mprotect)
> > +{
> > +	const unsigned long page_size = self->page_size;
> > +	char *ptr;
> > +	int i;
> > +
> > +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +
> > +	/* Poison the middle of the range. */
> > +	ASSERT_EQ(madvise(&ptr[5 * page_size], 2 * page_size,
> > +			  MADV_GUARD_POISON), 0);
> > +
> > +	/* Assert that it is indeed poisoned. */
> > +	ASSERT_FALSE(try_read_write_buf(&ptr[5 * page_size]));
> > +	ASSERT_FALSE(try_read_write_buf(&ptr[6 * page_size]));
> > +
> > +	/* Now make these pages read-only. */
> > +	ASSERT_EQ(mprotect(&ptr[5 * page_size], 2 * page_size, PROT_READ), 0);
> > +
> > +	/* Make sure the range is still poisoned. */
> > +	ASSERT_FALSE(try_read_buf(&ptr[5 * page_size]));
> > +	ASSERT_FALSE(try_read_buf(&ptr[6 * page_size]));
> > +
> > +	/* Make sure we can poison again without issue.*/
> > +	ASSERT_EQ(madvise(&ptr[5 * page_size], 2 * page_size,
> > +			  MADV_GUARD_POISON), 0);
> > +
> > +	/* Make sure the range is, yet again, still poisoned. */
> > +	ASSERT_FALSE(try_read_buf(&ptr[5 * page_size]));
> > +	ASSERT_FALSE(try_read_buf(&ptr[6 * page_size]));
> > +
> > +	/* Now unpoison the whole range. */
> > +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_UNPOISON), 0);
> > +
> > +	/* Make sure the whole range is readable. */
> > +	for (i = 0; i < 10; i++) {
> > +		ASSERT_TRUE(try_read_buf(&ptr[i * page_size]));
> > +	}
> > +
> > +	/* Cleanup. */
> > +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> > +}
> > +
> > +/* Split and merge VMAs and make sure guard pages still behave. */
> > +TEST_F(guard_pages, split_merge)
> > +{
> > +	const unsigned long page_size = self->page_size;
> > +	char *ptr, *ptr_new;
> > +	int i;
> > +
> > +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +
> > +	/* Poison the whole range. */
> > +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
> > +
> > +	/* Make sure the whole range is poisoned. */
> > +	for (i = 0; i < 10; i++) {
> > +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> > +	}
> > +
> > +	/* Now unmap some pages in the range so we split. */
> > +	ASSERT_EQ(munmap(&ptr[2 * page_size], page_size), 0);
> > +	ASSERT_EQ(munmap(&ptr[5 * page_size], page_size), 0);
> > +	ASSERT_EQ(munmap(&ptr[8 * page_size], page_size), 0);
> > +
> > +	/* Make sure the remaining ranges are poisoned post-split. */
> > +	for (i = 0; i < 2; i++) {
> > +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> > +	}
> > +	for (i = 2; i < 5; i++) {
> > +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> > +	}
> > +	for (i = 6; i < 8; i++) {
> > +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> > +	}
> > +	for (i = 9; i < 10; i++) {
> > +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> > +	}
> > +
> > +	/* Now map them again - the unmap will have cleared the poison. */
> > +	ptr_new = mmap(&ptr[2 * page_size], page_size, PROT_READ | PROT_WRITE,
> > +		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr_new, MAP_FAILED);
> > +	ptr_new = mmap(&ptr[5 * page_size], page_size, PROT_READ | PROT_WRITE,
> > +		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr_new, MAP_FAILED);
> > +	ptr_new = mmap(&ptr[8 * page_size], page_size, PROT_READ | PROT_WRITE,
> > +		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr_new, MAP_FAILED);
> > +
> > +	/* Now make sure poisoning is as expected. */
> > +	for (i = 0; i < 10; i++) {
> > +		bool result = try_read_write_buf(&ptr[i * page_size]);
> > +
> > +		if (i == 2 || i == 5 || i == 8) {
> > +			ASSERT_TRUE(result);
> > +		} else {
> > +			ASSERT_FALSE(result);
> > +		}
> > +	}
> > +
> > +	/* Now poison everything again. */
> > +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
> > +
> > +	/* Make sure the whole range is poisoned. */
> > +	for (i = 0; i < 10; i++) {
> > +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> > +	}
> > +
> > +	/* Now split the range into three. */
> > +	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ), 0);
> > +	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size, PROT_READ), 0);
> > +
> > +	/* Make sure the whole range is poisoned for read. */
> > +	for (i = 0; i < 10; i++) {
> > +		ASSERT_FALSE(try_read_buf(&ptr[i * page_size]));
> > +	}
> > +
> > +	/* Now reset protection bits so we merge the whole thing. */
> > +	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ | PROT_WRITE), 0);
> > +	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size,
> > +			   PROT_READ | PROT_WRITE), 0);
> > +
> > +	/* Make sure the whole range is still poisoned. */
> > +	for (i = 0; i < 10; i++) {
> > +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> > +	}
> > +
> > +	/* Split range into 3 again... */
> > +	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ), 0);
> > +	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size, PROT_READ), 0);
> > +
> > +	/* ...and unpoison the whole range. */
> > +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_UNPOISON), 0);
> > +
> > +	/* Make sure the whole range is remedied for read. */
> > +	for (i = 0; i < 10; i++) {
> > +		ASSERT_TRUE(try_read_buf(&ptr[i * page_size]));
> > +	}
> > +
> > +	/* Merge them again. */
> > +	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ | PROT_WRITE), 0);
> > +	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size,
> > +			   PROT_READ | PROT_WRITE), 0);
> > +
> > +	/* Now ensure the merged range is remedied for read/write. */
> > +	for (i = 0; i < 10; i++) {
> > +		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
> > +	}
> > +
> > +	/* Cleanup. */
> > +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> > +}
> > +
> > +/* Assert that MADV_DONTNEED does not remove guard poison markers. */
> > +TEST_F(guard_pages, dontneed)
> > +{
> > +	const unsigned long page_size = self->page_size;
> > +	char *ptr;
> > +	int i;
> > +
> > +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +
> > +	/* Back the whole range. */
> > +	for (i = 0; i < 10; i++) {
> > +		ptr[i * page_size] = 'y';
> > +	}
> > +
> > +	/* Poison every other page. */
> > +	for (i = 0; i < 10; i += 2) {
> > +		ASSERT_EQ(madvise(&ptr[i * page_size],
> > +				  page_size, MADV_GUARD_POISON), 0);
> > +	}
> > +
> > +	/* Indicate that we don't need any of the range. */
> > +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_DONTNEED), 0);
> > +
> > +	/* Check to ensure poison markers are still in place. */
> > +	for (i = 0; i < 10; i++) {
> > +		bool result = try_read_buf(&ptr[i * page_size]);
> > +
> > +		if (i % 2 == 0) {
> > +			ASSERT_FALSE(result);
> > +		} else {
> > +			ASSERT_TRUE(result);
> > +			/* Make sure we really did get reset to zero page. */
> > +			ASSERT_EQ(ptr[i * page_size], '\0');
> > +		}
> > +
> > +		/* Now write... */
> > +		result = try_write_buf(&ptr[i * page_size]);
> > +
> > +		/* ...and make sure same result. */
> > +		if (i % 2 == 0) {
>
> You don't need  { here
> > +			ASSERT_FALSE(result);
> > +		} else {
> > +			ASSERT_TRUE(result);
> > +		}
>
> Same here.

Removing these results in compilation failure so we can't :) this is
probably/possibly a bug in how the assert macros work but fixing that is
out of scope for this series.

> > +	}
> > +
> > +	/* Cleanup. */
> > +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> > +}
> > +
> > +/* Assert that mlock()'ed pages work correctly with poison markers. */
> > +TEST_F(guard_pages, mlock)
> > +{
> > +	const unsigned long page_size = self->page_size;
> > +	char *ptr;
> > +	int i;
> > +
> > +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +
> > +	/* Populate. */
> > +	for (i = 0; i < 10; i++) {
> > +		ptr[i * page_size] = 'y';
> > +	}
> > +
> > +	/* Lock. */
> > +	ASSERT_EQ(mlock(ptr, 10 * page_size), 0);
> > +
> > +	/* Now try to poison, should fail with EINVAL. */
> > +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), -1);
> > +	ASSERT_EQ(errno, EINVAL);
> > +
> > +	/* OK unlock. */
> > +	ASSERT_EQ(munlock(ptr, 10 * page_size), 0);
> > +
> > +	/* Poison first half of range, should now succeed. */
> > +	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_POISON), 0);
> > +
> > +	/* Make sure poison works. */
> > +	for (i = 0; i < 10; i++) {
> > +		bool result = try_read_write_buf(&ptr[i * page_size]);
> > +
> > +		if (i < 5) {
> > +			ASSERT_FALSE(result);
> > +		} else {
> > +			ASSERT_TRUE(result);
> > +			ASSERT_EQ(ptr[i * page_size], 'x');
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * Now lock the latter part of the range. We can't lock the poisoned
> > +	 * pages, as this would result in the pages being populated and the
> > +	 * poisoning would cause this to error out.
> > +	 */
> > +	ASSERT_EQ(mlock(&ptr[5 * page_size], 5 * page_size), 0);
> > +
> > +	/*
> > +	 * Now unpoison, we do not permit mlock()'d ranges to be remedied as it is
> > +	 * a non-destructive operation.
> > +	 */
> > +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_UNPOISON), 0);
> > +
> > +	/* Now check that everything is remedied. */
> > +	for (i = 0; i < 10; i++) {
> > +		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
> > +	}
> > +
> > +	/* Cleanup. */
> > +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> > +}
> > +
> > +/*
> > + * Assert that moving, extending and shrinking memory via mremap() retains
> > + * poison markers where possible.
> > + *
> > + * - Moving a mapping alone should retain markers as they are.
> > + */
> > +TEST_F(guard_pages, mremap_move)
> > +{
> > +	const unsigned long page_size = self->page_size;
> > +	char *ptr, *ptr_new;
> > +
> > +	/* Map 5 pages. */
> > +	ptr = mmap(NULL, 5 * page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +
> > +	/* Place poison markers at both ends of the 5 page span. */
> > +	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
> > +	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_POISON), 0);
> > +
> > +	/* Make sure the poison is in effect. */
> > +	ASSERT_FALSE(try_read_write_buf(ptr));
> > +	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
> > +
> > +	/* Map a new region we will move this range into. Doing this ensures
> > +	 * that we have reserved a range to map into.
> > +	 */
> > +	ptr_new = mmap(NULL, 5 * page_size, PROT_NONE, MAP_ANON | MAP_PRIVATE,
> > +		       -1, 0);
> > +	ASSERT_NE(ptr_new, MAP_FAILED);
> > +
> > +	ASSERT_EQ(mremap(ptr, 5 * page_size, 5 * page_size,
> > +			 MREMAP_MAYMOVE | MREMAP_FIXED, ptr_new), ptr_new);
> > +
> > +	/* Make sure the poison is retained. */
> > +	ASSERT_FALSE(try_read_write_buf(ptr_new));
> > +	ASSERT_FALSE(try_read_write_buf(&ptr_new[4 * page_size]));
> > +
> > +	/*
> > +	 * Clean up - we only need reference the new pointer as we overwrote the
> > +	 * PROT_NONE range and moved the existing one.
> > +	 */
> > +	munmap(ptr_new, 5 * page_size);
> > +}
> > +
> > +/*
> > + * Assert that moving, extending and shrinking memory via mremap() retains
> > + * poison markers where possible.
> > + *
> > + * - Expanding should retain, only now in different position. The user will have
> > + *   to unpoison manually to fix up (they'd have to do the same if it were a
> > + *   PROT_NONE mapping)
> > + */
> > +TEST_F(guard_pages, mremap_expand)
> > +{
> > +	const unsigned long page_size = self->page_size;
> > +	char *ptr, *ptr_new;
> > +
> > +	/* Map 10 pages... */
> > +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +	/* ...But unmap the last 5 so we can ensure we can expand into them. */
> > +	ASSERT_EQ(munmap(&ptr[5 * page_size], 5 * page_size), 0);
> > +
> > +	/* Place poison markers at both ends of the 5 page span. */
> > +	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
> > +	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_POISON), 0);
> > +
> > +	/* Make sure the poison is in effect. */
> > +	ASSERT_FALSE(try_read_write_buf(ptr));
> > +	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
> > +
> > +	/* Now expand to 10 pages. */
> > +	ptr = mremap(ptr, 5 * page_size, 10 * page_size, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +
> > +	/* Make sure the poison is retained in its original positions. */
> > +	ASSERT_FALSE(try_read_write_buf(ptr));
> > +	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
> > +
> > +	/* Reserve a region which we can move to and expand into. */
> > +	ptr_new = mmap(NULL, 20 * page_size, PROT_NONE,
> > +		       MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr_new, MAP_FAILED);
> > +
> > +	/* Now move and expand into it. */
> > +	ptr = mremap(ptr, 10 * page_size, 20 * page_size,
> > +		     MREMAP_MAYMOVE | MREMAP_FIXED, ptr_new);
> > +	ASSERT_EQ(ptr, ptr_new);
> > +
> > +	/* Again, make sure the poison is retained in its original
> > +	 * positions. */
> > +	ASSERT_FALSE(try_read_write_buf(ptr));
> > +	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
> > +
> > +	/*
> > +	 * A real user would have to unpoison, but would reasonably expect all
> > +	 * characteristics of the mapping to be retained, including poison
> > +	 * markers.
> > +	 */
> > +
> > +	/* Cleanup. */
> > +	munmap(ptr, 20 * page_size);
> > +}
> > +/*
> > + * Assert that moving, extending and shrinking memory via mremap() retains
> > + * poison markers where possible.
> > + *
> > + * - Shrinking will result in markers that are shrunk over being removed. Again,
> > + *   if the user were using a PROT_NONE mapping they'd have to manually fix this
> > + *   up also so this is OK.
> > + */
> > +TEST_F(guard_pages, mremap_shrink)
> > +{
> > +	const unsigned long page_size = self->page_size;
> > +	char *ptr;
> > +	int i;
> > +
> > +	/* Map 5 pages. */
> > +	ptr = mmap(NULL, 5 * page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +
> > +	/* Place poison markers at both ends of the 5 page span. */
> > +	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
> > +	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_POISON), 0);
> > +
> > +	/* Make sure the poison is in effect. */
> > +	ASSERT_FALSE(try_read_write_buf(ptr));
> > +	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
> > +
> > +	/* Now shrink to 3 pages. */
> > +	ptr = mremap(ptr, 5 * page_size, 3 * page_size, MREMAP_MAYMOVE);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +
> > +	/* We expect the poison marker at the start to be retained... */
> > +	ASSERT_FALSE(try_read_write_buf(ptr));
> > +
> > +	/* ...But remaining pages will not have poison markers. */
> > +	for (i = 1; i < 3; i++) {
> > +		ASSERT_TRUE(try_read_write_buf(&ptr[i + page_size]));
> > +	}
> > +
> > +	/*
> > +	 * As with expansion, a real user would have to unpoison and fixup. But
> > +	 * you'd have to do similar manual things with PROT_NONE mappings too.
> > +	 */
> > +
> > +	/*
> > +	 * If we expand back to the original size, the end marker will, of
> > +	 * course, no longer be present.
> > +	 */
> > +	ptr = mremap(ptr, 3 * page_size, 5 * page_size, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +
> > +	/* Again, we expect the poison marker at the start to be retained... */
> > +	ASSERT_FALSE(try_read_write_buf(ptr));
> > +
> > +	/* ...But remaining pages will not have poison markers. */
> > +	for (i = 1; i < 5; i++) {
> > +		ASSERT_TRUE(try_read_write_buf(&ptr[i + page_size]));
> > +	}
> > +
> > +	/* Cleanup. */
> > +	munmap(ptr, 5 * page_size);
> > +}
> > +
> > +/*
> > + * Assert that forking a process with VMAs that do not have VM_WIPEONFORK set
> > + * retain guard pages.
> > + */
> > +TEST_F(guard_pages, fork)
> > +{
> > +	const unsigned long page_size = self->page_size;
> > +	char *ptr;
> > +	pid_t pid;
> > +	int i;
> > +
> > +	/* Map 10 pages. */
> > +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +
> > +	/* Poison the first 5 pages. */
> > +	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_POISON), 0);
> > +
> > +	pid = fork();
> > +	ASSERT_NE(pid, -1);
> > +	if (!pid) {
> > +		/* This is the child process now. */
> > +
> > +		/* Assert that the poisoning is in effect. */
> > +		for (i = 0; i < 10; i++) {
> > +			bool result = try_read_write_buf(&ptr[i * page_size]);
> > +
> > +			if (i < 5) {
> > +				ASSERT_FALSE(result);
> > +			} else {
> > +				ASSERT_TRUE(result);
> > +			}
> > +		}
> > +
> > +		/* Now unpoison the range.*/
> > +		ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_UNPOISON), 0);
> > +
> > +		exit(0);
> > +	}
> > +
> > +	/* Parent process. */
> > +
> > +	/* Parent simply waits on child. */
> > +	waitpid(pid, NULL, 0);
> > +
> > +	/* Child unpoison does not impact parent page table state. */
> > +	for (i = 0; i < 10; i++) {
> > +		bool result = try_read_write_buf(&ptr[i * page_size]);
> > +
> > +		if (i < 5) {
> > +			ASSERT_FALSE(result);
> > +		} else {
> > +			ASSERT_TRUE(result);
> > +		}
> > +	}
> > +
> > +	/* Cleanup. */
> > +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> > +}
> > +
> > +/*
> > + * Assert that forking a process with VMAs that do have VM_WIPEONFORK set
> > + * behave as expected.
> > + */
> > +TEST_F(guard_pages, fork_wipeonfork)
> > +{
> > +	const unsigned long page_size = self->page_size;
> > +	char *ptr;
> > +	pid_t pid;
> > +	int i;
> > +
> > +	/* Map 10 pages. */
> > +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +
> > +	/* Mark wipe on fork. */
> > +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_WIPEONFORK), 0);
> > +
> > +	/* Poison the first 5 pages. */
> > +	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_POISON), 0);
> > +
> > +	pid = fork();
> > +	ASSERT_NE(pid, -1);
> > +	if (!pid) {
> > +		/* This is the child process now. */
> > +
> > +		/* Poison will have been wiped. */
> > +		for (i = 0; i < 10; i++) {
> > +			ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
> > +		}
> > +
> > +		exit(0);
> > +	}
> > +
> > +	/* Parent process. */
> > +
> > +	waitpid(pid, NULL, 0);
> > +
> > +	/* Poison should be in effect.*/
> > +	for (i = 0; i < 10; i++) {
> > +		bool result = try_read_write_buf(&ptr[i * page_size]);
> > +
> > +		if (i < 5) {
> > +			ASSERT_FALSE(result);
> > +		} else {
> > +			ASSERT_TRUE(result);
> > +		}
> > +	}
> > +
> > +	/* Cleanup. */
> > +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> > +}
> > +
> > +/* Ensure that MADV_FREE frees poison entries as expected. */
> > +TEST_F(guard_pages, lazyfree)
> > +{
> > +	const unsigned long page_size = self->page_size;
> > +	char *ptr;
> > +	int i;
> > +
> > +	/* Map 10 pages. */
> > +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +
> > +	/* Poison range. */
> > +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
> > +
> > +	/* Ensure poisoned. */
> > +	for (i = 0; i < 10; i++) {
> > +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> > +	}
> > +
> > +	/* Lazyfree range. */
> > +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_FREE), 0);
> > +
> > +	/* This should simply clear the poison markers. */
> > +	for (i = 0; i < 10; i++) {
> > +		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
> > +	}
> > +
> > +	/* Cleanup. */
> > +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> > +}
> > +
> > +/* Ensure that MADV_POPULATE_READ, MADV_POPULATE_WRITE behave as expected. */
> > +TEST_F(guard_pages, populate)
> > +{
> > +	const unsigned long page_size = self->page_size;
> > +	char *ptr;
> > +
> > +	/* Map 10 pages. */
> > +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +
> > +	/* Poison range. */
> > +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
> > +
> > +	/* Populate read should error out... */
> > +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_POPULATE_READ), -1);
> > +	ASSERT_EQ(errno, EFAULT);
> > +
> > +	/* ...as should populate write. */
> > +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_POPULATE_WRITE), -1);
> > +	ASSERT_EQ(errno, EFAULT);
> > +
> > +	/* Cleanup. */
> > +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> > +}
> > +
> > +/* Ensure that MADV_COLD, MADV_PAGEOUT do not remove poison markers. */
> > +TEST_F(guard_pages, cold_pageout)
> > +{
> > +	const unsigned long page_size = self->page_size;
> > +	char *ptr;
> > +	int i;
> > +
> > +	/* Map 10 pages. */
> > +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +
> > +	/* Poison range. */
> > +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
> > +
> > +	/* Ensured poisoned. */
> > +	for (i = 0; i < 10; i++) {
> > +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> > +	}
> > +
> > +	/* Now mark cold. This should have no impact on poison markers. */
> > +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_COLD), 0);
> > +
> > +	/* Should remain poisoned. */
> > +	for (i = 0; i < 10; i++) {
> > +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> > +	}
> > +
> > +	/* OK, now page out. This should equally, have no effect on markers. */
> > +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_PAGEOUT), 0);
> > +
> > +	/* Should remain poisoned. */
> > +	for (i = 0; i < 10; i++) {
> > +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> > +	}
> > +
> > +	/* Cleanup. */
> > +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> > +}
> > +
> > +/* Ensure that guard pages do not break userfaultd. */
> > +TEST_F(guard_pages, uffd)
> > +{
> > +	const unsigned long page_size = self->page_size;
> > +	int uffd;
> > +	char *ptr;
> > +	int i;
> > +	struct uffdio_api api = {
> > +		.api = UFFD_API,
> > +		.features = 0,
> > +	};
> > +	struct uffdio_register reg;
> > +	struct uffdio_range range;
> > +
> > +	/* Set up uffd. */
> > +	uffd = userfaultfd(0);
> > +	if (uffd == -1 && errno == EPERM)
> > +		ksft_exit_skip("No uffd permissions\n");
>
> Same comment here about a user friendly message that say what
> user shoul do

Ack will update on respin.

>
> > +	ASSERT_NE(uffd, -1);
> > +
> > +	ASSERT_EQ(ioctl(uffd, UFFDIO_API, &api), 0);
> > +
> > +	/* Map 10 pages. */
> > +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +
> > +	/* Register the range with uffd. */
> > +	range.start = (unsigned long)ptr;
> > +	range.len = 10 * page_size;
> > +	reg.range = range;
> > +	reg.mode = UFFDIO_REGISTER_MODE_MISSING;
> > +	ASSERT_EQ(ioctl(uffd, UFFDIO_REGISTER, &reg), 0);
> > +
> > +	/* Poison the range. This should not trigger the uffd. */
> > +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
> > +
> > +	/* The poisoning should behave as usual with no uffd intervention. */
> > +	for (i = 0; i < 10; i++) {
> > +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> > +	}
> > +
> > +	/* Cleanup. */
> > +	ASSERT_EQ(ioctl(uffd, UFFDIO_UNREGISTER, &range), 0);
> > +	close(uffd);
> > +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> > +}
> > +
> > +TEST_HARNESS_MAIN
>
> thanks,
> -- Shuah
>

