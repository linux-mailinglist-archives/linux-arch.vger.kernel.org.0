Return-Path: <linux-arch+bounces-12047-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8AEABEAEF
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 06:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B934A7082
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 04:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AA422B8A7;
	Wed, 21 May 2025 04:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IcAUEO5b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PhZadbwf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DC2223330;
	Wed, 21 May 2025 04:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747801306; cv=fail; b=dQp1jOLMgRjQ8gbuC3K+W2/MmqdCGucrZtek6Bh6shh5X46faS5jrTwXUm4CHw9ooeNE9CUsRvujPvD0BkfXtvII3DnL0VCk4PIQz9/pSHkipv9Y5xrIblJZvw2FeRJOoHvACdIHD6/643p1OOjDoFkfQmNbkiMLnAXpECiL9D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747801306; c=relaxed/simple;
	bh=vo+4LggsD55U+eSjpapGilWEqGly/E994ffF0GWZP+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QDUYEinlTPA62eB/aU0L/y4oezRXpd8gD8pFXZXUPscZUgz3zN1sJv9Mz7S9CnbOWVeo7tUqgxEO6j55P2V0yJhrWhuuVYjNpHSy7j/qAJ/IJj+i5T4lo9GprF+l3GkZGXYnAHoHOBPAAc//lOuW9Fzja71B0Aa7NKKDQbQ9DO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IcAUEO5b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PhZadbwf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L49qqA025483;
	Wed, 21 May 2025 04:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vo+4LggsD55U+eSjpa
	pGilWEqGly/E994ffF0GWZP+E=; b=IcAUEO5bQi5jVTfWvbxhyQZ1UctBf8Pfif
	oA8AR7svN3Rp7yF+lTgGVMvFmHQwuCPzIGLLKLGZbAdRWRzRUmpgLIskjnlQ89zx
	f0v+pFUTsQLx7SQ+a7TOlCQ6Uh1mtCzsggcTOyO4/SiXS++0WxnGj7+m0cUJqU/c
	zmXTWttFqVknCMhyOwkgf+epmnwyOc4yvwxfzm40QR8t2bLuSxcysa0vKv1Y9FfC
	c1Ayuqmo03CxckkklxnP422znJFkK0WhsEuQflXEpTmlkUIK1SPe9CKrlg4GbvBi
	tnE/kbgoqZS9liGk+QMIg2hueC+lbsVAiUyxo9oip07ROZfDdp9w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46s5yxg2w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 04:21:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54L2DmDA020313;
	Wed, 21 May 2025 04:21:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rwetbjh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 04:21:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GW+ql9eWC6rxveIqoRrPA4QCD1Gl20bfcJ1/Z4IuUzdWJCuyUINosA762TQrbLIcyaEDKzpdh/OGG20dVabu33w4zGdJl7YjTaqeMT3vVCjjmcrWA33jRq0gvUCg4liVNT0dW/Z5ZBEMnzpr/gz/RntYEQysreC3/SsX0nm0EInkwK2s4D6Q16pTDpECPyhKGV3jQe25ai1P4cSZMTOiyCL1/TObyfOXqsag4zirnkz8x02vOcA13vDaBbaTlqVaV0i32Fr5KbmXzX4GibKJnKZPBRYaWD1SPmFF+CR99v9Qag3WmXweT33WRj90f19O1ZVjklRy8iOf4AoZZNFnfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vo+4LggsD55U+eSjpapGilWEqGly/E994ffF0GWZP+E=;
 b=fLf5byJgmHLOV6YnvkXZ9X/zLFmyh6Zvv4dZ9DN68EVMpnZYpjHhgWS4RWdrmBaZuD8FtuWtvu4c/aIuN7GJ/qlznjLvlc/g0gc/aXm7daUuR52JYofiDHIwPAk8EUm7L6K9Oqo+iASHiU5fjCUpeOTR3lVuYJ1L6hmnZiQTCXF/Oan5Hfw8lp7Jc8MzGCjBSGE2Rf//ikoCdKq6wqv0/WFb2Hc2PYrQercM+p/jbArhG6aGC5Kam4yNTDvxSp4lgn/sqexxMPtwqd+BZfLI75LVd6Dw94jvcI5eKmK2EP0+qrOJOCP34jz+/dHIzsx/IT7Ithv37WQiEKK705aShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vo+4LggsD55U+eSjpapGilWEqGly/E994ffF0GWZP+E=;
 b=PhZadbwfjWugO/24MniG5Gqh1yB0M6TgFAwZRhrRZ/kSPQV4StsK79540TWkMVBdmo7VWorT6Kd5m5ErlqGgOI5rHTw5yfenCVQsU3ttfNhZYC+3NTRxKXRYBkMpw+oCGadXumSSz3kPUqsimWa59R0DFZVbE/KhVbNBo4qr5fQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5834.namprd10.prod.outlook.com (2603:10b6:a03:3ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.32; Wed, 21 May
 2025 04:21:24 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 04:21:24 +0000
Date: Wed, 21 May 2025 05:21:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <7a214bee-d184-460f-88d6-2249b9d513ba@lucifer.local>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
 <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
 <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
 <e8c459cb-c8b8-4c34-8f94-c8918bef582f@lucifer.local>
 <226owobtknee4iirb7sdm3hs26u4nvytdugxgxtz23kcrx6tzg@nryescaj266u>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <226owobtknee4iirb7sdm3hs26u4nvytdugxgxtz23kcrx6tzg@nryescaj266u>
X-ClientProxiedBy: LO2P123CA0072.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::36) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b0faca-6d97-49ed-8802-08dd981ef2b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vzOVAvD5bSxZkL+OeNxnj0et7BUTfej+LQe7Ng214Xt1WNI+RlFqn1RE9Bn7?=
 =?us-ascii?Q?cr+KOjWUJPFNi742w6BKNPZ0/ld2IkrqAAB0Mhr7uxTeBQ/P39EuchEYw4WA?=
 =?us-ascii?Q?I492XmY9iOsh2YjaqGbDx0KYTSQ11ZK93lfXSFGTbSmWah/deZUzOmqg4gFE?=
 =?us-ascii?Q?Fc7wLHD1HQGw7c4BqwPurdzfE77Dd82HP7ZYc2wn8LsU16EDvimMFfaKgG29?=
 =?us-ascii?Q?yQwocpuzsGVl8PG5rm8pyHNi6a/3yqfAYiYAYyTqY+9Z6c/DXHt+lnrj6dT8?=
 =?us-ascii?Q?nG48ScP3wcFE2xqmeTrxdN7TEiR4jRaCs3rvB5lLPHaFIAjs37TEvWd8NM3B?=
 =?us-ascii?Q?02NIvHhWqhTQ87PK3M0xeDs0dZYBQgzqsJNsg8IQRWX7KUyc3lOqBhputDfN?=
 =?us-ascii?Q?TC0oS01cs7PIY6ThoQROvaHS91dUZKJG29lHGdM6TmJ8BZZrH/7JQe8DMNiU?=
 =?us-ascii?Q?afe39mmNkLiWbAoOKtHI88n5chfqXHq24Ka8QiY+L7C8nrvU6s3HPrkqPT6e?=
 =?us-ascii?Q?HZkuFk2FbUjlthm4oavujOpd7BWY+QeT/psAie9oTCkOlZV+LiUW++lpq6T2?=
 =?us-ascii?Q?H7Ehaf2xvz3K5XsykVvRRx/aVE5jcALxIkhrnwMbRb0FiBYAeGrWFtQe14aE?=
 =?us-ascii?Q?M191187MJIsx/CDlcPxk1HDNtPTe8Hp/7wMaunqOVRz51nVW8z0TSwpzJsnz?=
 =?us-ascii?Q?SZ4mS31eeRM8yV8i2fo/3VoFIh7QfXe24L3OaIHXjuhjLXNElYxX6zRqIugM?=
 =?us-ascii?Q?H0OJbtfXHUaN87JInEOaDqHWrJnMoWdL5rynqAYo7auaqpfvdMTCD97gUqvM?=
 =?us-ascii?Q?9Wy53By8HQs7elsaW6xySfkdcfaHcC4HUC+53W4ZoPeezM7TVX1rZfok+lFw?=
 =?us-ascii?Q?V/H92lc4lhZRJGaejZBk+xqvuuTYMmo6RlFJqFklUw7n9cdX4FOW0tbiVeGy?=
 =?us-ascii?Q?N7IGu4wbz4YKn1mDG2fKihUJYkXwwdrpbGOgxa53sH3tclsKcKre1ZYKgxAa?=
 =?us-ascii?Q?cdEDJbtyJgHJJnOLnndWUn5P+ap6zgAtkOGpEqLMbMF7+RDPzxfhlsPcCYia?=
 =?us-ascii?Q?Gw9RDFkVwwXLIcT9ijUskKAKnzS8StF5kkH/pQGFoWY2rG4bWXoE3BwY3hkz?=
 =?us-ascii?Q?h+OUPoM/h6UOM2UQLvK1FnxiggMea52WraNJgxoN8T7f2Zm33ogb2rNq2+Eo?=
 =?us-ascii?Q?+RUaxe/40WEjty3xVzAK4TNYTVVFUTnzvCoodtnP5kCCoLjoo/4RJKOkfHHG?=
 =?us-ascii?Q?gYWlDzJKfHLruFIAwagPjVWDJ3B6e3LPUxUb8ceYgKl9XuTwXFls3VM1T0ch?=
 =?us-ascii?Q?M69i5B4wHNykS4o5TjOesXVGDVrZyKtqUTxLom+Ye1FXt4HWU110PISCv/BS?=
 =?us-ascii?Q?xeZKc0YfNfh0xBluwzWoOs9/2U9hQFkXMAqpWQPmi3cAP5AzeLDIvudg4DXz?=
 =?us-ascii?Q?NMhz8ECq7cA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IzaNxukGaltScC7HoAWkOxzCSr0sg9/ibucOOkf59vDKEoZlf7H5as3Zck36?=
 =?us-ascii?Q?NoDFehkKkwH1o5sya7KBJEPlgyvsuLJilYGlS0DD0hDugrVH2ReLBt9POLAh?=
 =?us-ascii?Q?1NwBPrMyPBJ4nFmTxETw7QHub996o4MwmjmSA06TryFg7LDGQYoRhERlJh+9?=
 =?us-ascii?Q?PbjFixY86YzDA8eGgfXuRfU5AZpD1xsL2OGJy6K1r/RJaXTYR/53kG+VFHPm?=
 =?us-ascii?Q?1P7rctIDslJp8s1YyIFvpSnBBDMXIqAVS9sYNv+qILTY3dt+rJvMKSq0gj+A?=
 =?us-ascii?Q?+VYtAUVbvvY3GBqtg2BncbITg4q4YAyT1ifDYO1FxYK+L/aEKRqMUwhwfq3P?=
 =?us-ascii?Q?aF+jltY8ekJ/xuj0FvxAtyRaG5AvaMF2LvGsYc/pbNlX2WI73AIGHZwwys1A?=
 =?us-ascii?Q?QJMZ0YCKV7caidUuV2Gs8R6pECGJPAUs67xYWZXzU233B2D9PPR5Q3KPP8bq?=
 =?us-ascii?Q?20sv2q2iAGVwerNi+Ik5FDrRoUJg4Yjztgsidsqrf5Zw+4x6sWsMU/bjW+HT?=
 =?us-ascii?Q?DiFG5l4ZQL7W3CLTAOgNv0GmSN4+cyrk2MxDiVfimvKddXFCz2KOE5wo4JzJ?=
 =?us-ascii?Q?K3hYZQ4qiYJtPV1wwqksZmtQD4aN3uAoD/Tz+Z9t9tKHXwGiIy7oxdLO2dwk?=
 =?us-ascii?Q?YVbWeVfvwS9wz8i7qf8x3Fdw+fqLQX4QnJJK+hCfldtrJ7fL3wXkx7hDykVs?=
 =?us-ascii?Q?FRbPgi7U7Bk91B1LBVAH3HS778kNxdonddMFwZPqCsx4i6fZHWfVlGbFVRrx?=
 =?us-ascii?Q?MctILDB6U5+liRT9zty2RQdoF1722LxTt4mmY78NrT3oI9WBwXr7M2ztHd9r?=
 =?us-ascii?Q?4ubyctq5izdNnmEGtuFOtcbI5/1RK+8j/59boIdDVDFgvbIiaPAsRsHtjr+G?=
 =?us-ascii?Q?XQlWk4kVC/HzkBsG6LKm4/54uEWV64rI7vK8tQtXtJp+Z+XdkzSTrWNfZc1K?=
 =?us-ascii?Q?Lm4LyPGohuW18UM/P4gsO7OOzBxcP/5z6T1VcJ5O86b6BXmp4BgO5en+wk5i?=
 =?us-ascii?Q?k56foNRlaWJK9l9JW3zdVNgbARTeT2CDBHlCaJbnRbSGSTnUfHzVUu87rvDO?=
 =?us-ascii?Q?toZ8dVqEitXN1P0WBhRuYT4v1Lr+hfAJ6KNNasXoy/R0i0w9jYglKSrvx6lw?=
 =?us-ascii?Q?L2tYVYzMPID81Jme077RUbFf6wbwnaHm9XE9YkdtzTxbumvZq9w/ls/zb712?=
 =?us-ascii?Q?HxvIH72GLOoRuLlbL5AVK7kUwBVhrBzFc11evTGLKVtBGUA9rxpt+N3G1OHq?=
 =?us-ascii?Q?KTR15EGftgCS+Llcs3ZTknaoPl8m+Ep2ihhrzHdPGcvEc+w2GLxgW5IlKpFe?=
 =?us-ascii?Q?Dr/fQr1zwblv+wqUStgY1B1bbcknKSMxjToKUmxQUUMi6NaqN0sUW9zxkR0c?=
 =?us-ascii?Q?uN20btJlfdsjeG84oYKA7vHfIKDYO7FyTPcHOrh6F8pKOV5r2gTiMGdqQfTu?=
 =?us-ascii?Q?z2mBL68V7FAhnv2X5N3CKdMNqh1vM070rLAXhwG/o4FMhaPjP+zO4NkvwD2E?=
 =?us-ascii?Q?HQ3I6I60H68MM2IqUb4BReB/d1YaNhamTBH/7/5jSgaqFVZ03L1biVm8YmRS?=
 =?us-ascii?Q?1a3zh2iOhn9E3NrQIZkFE8NpG0GvyFAa5hwPktxhVQoPdi0zPvc86eA8p1Rv?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XgVJi5AZTA7ZAgE8AJqzF3An7aKlST+xFGcN2Cbk9aRvq7Or4gJbXTgBEx0vVudtEiZZg1dEm1y94UxxN1DD3of/smauobSFYC3E4z2vZK1EfkQHctg4OpbhPhcP0Z3+lz6JJuZLJxiNYRt13pksN+Y5BAYRz0X9V25/2QCABa6C73ABQQ8zQ8GtM8i4xwhM20WlCdxLZN8FmL0mAW8fKKJiTmsLszAjCj7+mpVlBugONJ9IzYEXHmU1SSCxzghmJ3hgAaCMubNxK6gUJr9vLOqbN2rg2iuSZVm7RCumAF/DnXDycTggD+aCLQYEdov7mnsHtsiU/TZicyuHXguoRWMsabvz3ayu8M2Px3Fx+zLnrsYfaQMxYeJLXxyQ45ru9bgvtEqhbsnBYb7VLrsubV4vChvTgw48ZEAJEoIralnXH4QZpW7BGwNx4Av2VMyFHu2Ki94H3gmipd6QuxWK7VPp2Hwyb2PMAY2T6QhidaA5pFz1+q4bDFc4hp2+zswhdaLRlC2dEYUf/p5Kj5OcieEH70Ehql2go3M4PK3fZFKcXWpkMWQ7ExkfqZLzJaATgz79I50N9Pkr6o8vpdgzk7L6GIXX0KY+KSrwHo7NGMg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b0faca-6d97-49ed-8802-08dd981ef2b9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 04:21:24.5992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKl5wUg8R33D3qXrI6Cnu5NhtKcokF/8e3RkpX0ZZXwziyAFzz7OL36lGO2gUfMJAfI4X6KSjk0X5e07CjCRZYiN1YsiGyZmzShW4EKidb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5834
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210039
X-Authority-Analysis: v=2.4 cv=H8Xbw/Yi c=1 sm=1 tr=0 ts=682d54c9 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=qj4OTiu_qPtHdlvaBRQA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13189
X-Proofpoint-ORIG-GUID: toOZvK0ra_zJu-lGLLjTOz0xLg1mhj3K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDAzOSBTYWx0ZWRfXwnFMdXgIKngC EUsz2QmekcKqvUyCXPfbA7ulpJnhNVhOSVfPIW2kn1pLTYO3Qw13yadkcGLDIKtkN9ShkYBWz2o Wd2YTDzFnuBGNkIqhlimGwb3anGuQUSi7laIn5ejvjj+k4DYI16j0kfO0+B1CKmPWY3qi09bZhv
 j+H8Wy/kg/LpKfRLtO3FvqjzXWgaxHFxPiif6s8k+NjPP/5IniDMEhFt6Ull2O1z8MuCvWC1gaq NPRiZwGdHFDytZ6TUhrAOcx0p5LBonctsxi81SWNe84gw8uAtym5ZuolZZtas3Fsmixu4ieT55h 7x0uxS6NcQG796t4s4drAdG43wRQCwKeJD1UJ0CKimvWTz62acfGcB764hp+fedHC31BxpEPxCL
 bsrKW9qkjUOIivkbraCxZIxZCEk73Ovp8B+34wzvtrBfuDvDKgWpX+864aycOs8TFniKJNyF
X-Proofpoint-GUID: toOZvK0ra_zJu-lGLLjTOz0xLg1mhj3K

On Tue, May 20, 2025 at 03:02:09PM -0700, Shakeel Butt wrote:

[snip for clarity]

> I think we are talking past each other (and I blame myself for that). Let
> me try again. (Please keep aside prctl or process_madvise). We need a
> way to change the policy of a process (job) and at the moment we are
> aligned that the job loader (like systemd) will set that policy and load
> the target (fork/exec), so the policy persist across fork/exec. (If
> someone has a better way to set the policy without race, please let us
> know).

Ack, totally agree the kernel currently lacks a cohesive story for this
'adjust POLICY of a process and descendents', we have cgroups, but they're
more general than a process, we have namespaces, but that's for restricting
resources...

I think we all want the same thing here, ultimately.

>
> My argument is that process_madvise() is not a good interface to set
> that policy because of its address range like interface. So, if not
> process_madvise() then what? Should we add a new syscall? (BTW we had
> very similar discussion on process_madvise(DONTNEED) on a remote process
> vs a new syscall i.e. process_mrelease()).

Sure, and generally both proposed interfaces are at least _awkward_, for me
prctl() is a no-go unless we have no other choice, I won't go over my
objections to it yet again (and Liam has also raised his of course).

>
> Adding a new syscall requires that it should be generally useful and
> hopefully have more use-cases. Now going back to the current specific
> use-case where we want to override the hugepage related policy of a job,
> do we expect to use this override forever? I believe this is temporary
> because the only reason we need this is because hugepages are not yet
> ready for prime time (many applications do not handle them well). In
> future when hugepages will be awesome, do we still need this "override
> the hugepage policy" syscall?

As argued previously, I am not so sure it'll be temporary, given the
proposed future 'auto' mode will be a _mode_ and we will need to support
VM_[NO]HUGEPAGE scenarios forever (deep, deep sigh).

Also if you add it into systemd it definitely won't be right? There's no
'throwaway' here, and scouring through prctl() (what is actually documented
:), I am not sure anything ever is, frankly.

So the idea is to try to make this as generic as possible and to have it
sit with code it makes sense to sit with.

>
> Now if we can show that this specific functionality is useful more than
> hugepages then I think new syscall seems like the best way forward.
> However if we think this functionality is only needed temporarily then
> shoving it in prctl() seems reasonable to me. If we really don't want
> prctl() based solution, I would recommend to discuss the new syscall
> approach and see if we can comeup with a more general solution.
>

So, something Liam mentioned off-list was the beautifully named
'mmadvise()'. Idea being that we have a system call _explicitly for_
mm-wide modifications.

With Barry's series doing a prctl() for something similar, and a whole host
of mm->flags existing for modifying behaviour, it would seem a natural fit.

I could do a respin that does something like this instead.

What's a pity to me re: going away from process_madvise() is losing the
opportunity to be able to modify the, frankly broken, gaps handling and
also being able to do 'best effort' madvise ranges.

But I suppose those can always be separate series... :)

I guess let me work that up so we can see how that looks?

Cheers, Lorenzo

