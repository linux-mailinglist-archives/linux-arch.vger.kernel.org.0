Return-Path: <linux-arch+bounces-8309-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF0E9A566A
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 21:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A3F1F221DF
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 19:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4080197A99;
	Sun, 20 Oct 2024 19:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kdZRrCJL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v/QnMfcW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD44191F6D;
	Sun, 20 Oct 2024 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453579; cv=fail; b=O2HF0smGntj9ZGGOZ3qt1uT1w1xOc/SeaQVzdYOA2ji/2GXwCjI9i/ABbO6SFuUg/QU7WVQDTzKEzI94dwGe3Gy8WTjHWlgxbc11LJ8PGpP7SGyGzFBUP3+zXvBE3pHDA1kqLCxtHI8jRw5s1Oi21YB2gkkc95Cf+Nff0HA+CYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453579; c=relaxed/simple;
	bh=utL9u2F2VG1y8K2MaDygzOsE6/+/1kch00d1I29SuzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iWiHMpW/R1fdNG6XvauSeJ+IX81VgjqZuNPCijhlWmmcj7OVK2N6Ye+BJhkYELpNkGABz8fm1jZ5o7QioX6QK0xAD207fARJiIEeD+KXn3xm2o+66js8/XhQ8n6AAS08+oRjeB1nTUss4RsyaFCCPP0AiaTDlQTYKCLt9ME21/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kdZRrCJL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v/QnMfcW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49KDBjaF032077;
	Sun, 20 Oct 2024 19:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=yXr8LZNvBd/C2+u/Dx
	T1HI7/TnWtBeWrE61AdAGAkjQ=; b=kdZRrCJLsyF+QI2uh2HGhhV3dwHr+4l3lK
	OnE/3SPb0iuaU1v/WH4LDKLbe/5IUbUuoG08p5EJ/kQmUjDXG3Haq2HnBY3sAPkp
	79pmQPkSJcEOvbxChVeyy7MyZSlASZvt252UgUNFMuhdJQP5tc2s+4acl32uHzE2
	Jku4pjnvaxURYylT5eSXoVwWrEh7ul7NGvBiqC9OlUUOjOJDnfB8atdQNHJV5zkZ
	jRZnOTgaI+hJqMFt3EhMsgubAh1zUZBMYhyMf2nkErzAXkBlXGmmGKHRMzN29aif
	zWw9QGTj8NQji1ipKfTmSUibMQofJsc3doheMM1xW4KLtqo71aPA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5as9wpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Oct 2024 19:45:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49KHqnA7008250;
	Sun, 20 Oct 2024 19:45:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c375kmms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Oct 2024 19:45:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hF10Ja2/xIJSvGTqmIdOS3A/W8oucpcmMsxB6CO6uBI3R+dzMUPVPmFMsMTbrZywxgX5WEV5ZBPkiufF0T29qlHsmAcspAMMxZ38rWeMZPrNFinYsN7OJcpT8tSACPYyS5BPXSknpx3E6pDONxQoe3U6cIGhMI7GLpCgNzuFufmylITwic3huFJcNwA2YOBKTe8JK5sFkt4m04yQijprRorl99P1FoFk3f/SuelC8H88HY5mwAGNKcPVEZVu/d+jXaHJW/FIIT/RRKnn6kMdSJ6QT9xk60fjwOWLf0um46OWgccUSv0IK5nzkHcPycCLGj5qr0KJyXOePu7fqdNuvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXr8LZNvBd/C2+u/DxT1HI7/TnWtBeWrE61AdAGAkjQ=;
 b=rozowNqcvtbgPa2912BLoZOKrcmV7XmGVa0wbC7QdXqp2UVVOZjjxq72o6wYH3e41yW1dpth/fq4qp7cjrSVLz7XXucokp/20NfHP7A9JNmIR+PTjgeD6sSg9JPr0V9pTyaCTQ/eLb2Nf8t06c3l9xFpR5t9hvphHFJHsqsAHjSB+0M8DaiSFbm2JiiU1LW5KCLCpifWB7QGFYMm113LNXuH/J52OVY4QUMASZW8YFsnNwsGhdcZoBSNcZOf7CrArjbct1aca4GBiROHzr/t39afrtDgfOf5oExcPE+Y7FNGZTIGBUQ06/wdeItsbOf0Ge0bj7lTy0zG16ZoVd/p9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXr8LZNvBd/C2+u/DxT1HI7/TnWtBeWrE61AdAGAkjQ=;
 b=v/QnMfcWiQHRmXdoblbV2oURscZrN1f1X3bhG2I+ZaiNnjal1+YoMohGgrYZXnP/CphlJ9Hm6fierKiBTQBWmn+DMMb2nSj//Im4NSiy/m90ionu+eQIoBNTIF4wbgWDObSFAnPQxLnGVVE4aVQBxuz+r0ZwLzsba+zw45JZP9Y=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CY8PR10MB6850.namprd10.prod.outlook.com (2603:10b6:930:9e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Sun, 20 Oct
 2024 19:45:11 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Sun, 20 Oct 2024
 19:45:11 +0000
Date: Sun, 20 Oct 2024 20:45:08 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Florian Weimer <fw@deneb.enyo.de>
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
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 0/5] implement lightweight guard pages
Message-ID: <57e6c8d9-5893-4221-966d-065f98189eb7@lucifer.local>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <87a5eysmj1.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5eysmj1.fsf@mid.deneb.enyo.de>
X-ClientProxiedBy: LO4P123CA0251.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::22) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CY8PR10MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: fedef79c-96a7-4848-cc6f-08dcf13fb5a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UwtIPrb3vu11670VrfrUbTeumIyz68vq99qf9J2LM7nP5BfXxWV3YUlgWRHy?=
 =?us-ascii?Q?db2RcArKmq5pO7Qukr+VQ7mrXENTnV5Dw8HsBS01mvXkKE5KqfHPJ6flEBna?=
 =?us-ascii?Q?idXQ9I6JWDIwpQgnvygKlATl0DIeLYIk/UUlfgXKyAcyZJyCFzNC1TBMh44+?=
 =?us-ascii?Q?+e91u3gvl0GGKauNV9vhz/a2s1rx9DeAuC+6aq6nr/FtPaEq9KsoJzYV1lfW?=
 =?us-ascii?Q?ojIZn2KJPUGugI/UT06VmLvzYx3IOtihT1AqpoJhq6SuFXfEYGLfAVGi/vOf?=
 =?us-ascii?Q?rj3gbzi8zJQoAw3wL9hKtV9JXyZx/oEKV18GGjrWYVhyHwzqgkNAj9Tl2QmB?=
 =?us-ascii?Q?Cvxc5ukK3XuLPe6560hDq0JJek5l/FOxq8b07BgKEYpJ2zjNu3+eynmrBUvq?=
 =?us-ascii?Q?0c1z40F4/l7q9ZVq9CC3f3b6JoW/tNjyyD16EyDGUFPN1aQ2JKPtMyOzfq2G?=
 =?us-ascii?Q?6n1MawT1gIoHTF/fOAlDV0oxgvTTEjJ02ZkJe6iB54086BgiXmh/agrl4LNZ?=
 =?us-ascii?Q?x0Bk6fdBYQ7KSDN/9dRKw2eLqM26GnpRjhjkFGKtx3z86r/FrsXpVPhMGMsG?=
 =?us-ascii?Q?UAJmxV1Zmx8JcQmGuj/tRyzkOl6cu22mRZI8GWS67sH4Hk4HHx4TkJUjlwuP?=
 =?us-ascii?Q?rfif4Eq/vWIzkSTrvhRf7j47JoDutq0Yr85/L3l8eEIyGo+B4MLQHTXu4oMy?=
 =?us-ascii?Q?nDFWSGKVIzmWSpQwnZLg0udrGwzsbfNY38yW/2ElJcj3AimoRGakmo2+56IT?=
 =?us-ascii?Q?uG4DVgc5Vk3+d9qPoUdXAXr1sStAoRCMuO8G5lJwtpBvzIZ3VhV+8z/s92Un?=
 =?us-ascii?Q?wVKnZsuBYsV+MAvNNkTfEPtj83OPzmEstqGGZB8Va0b3Sl8Tput9VtNuvewF?=
 =?us-ascii?Q?DUTJbGlO8vJfnFh6Ag3PUpClbONceuaBj1EKzBzwM5Z0t+OI+u1V1Hea4X2m?=
 =?us-ascii?Q?OcnEuguBf7r7KkeUJ4NPLqR2665azGz2D1YZtYNCW7u0s5Lx0AAyWjdQQSAW?=
 =?us-ascii?Q?r5vM9l78aSLHmcFW/nEbd9hJg3ZZ5xJcMgxYeRjyB0GXxmYH+OzjEkJtV38G?=
 =?us-ascii?Q?/MU9e3Y1M5zLYLhjPTCbDjsSqDHmwCcxHGoEJutUnmZ4hvQ3YSjB6pjwfwBA?=
 =?us-ascii?Q?CmyG4zp1YdWeNRN0GWGVktTs2x03ts0c+phI9XjMj0Q5+hcmJIQoXJwYdu8x?=
 =?us-ascii?Q?AGLGKw06CJY4k056gAUV9c3VQS987wyJskbrGtjplVGwrhWrVvevydERncZD?=
 =?us-ascii?Q?1Z+MTnG/FSmB4euLilOiX+f0trzXmTXgFemGDHHa25F/8VpXyR4vEiLy7U4x?=
 =?us-ascii?Q?PHqSwDPxw2UMKYy4LKHcvv5O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KMGy83HiZdiMFExZb+09l9AjjzZzzXsXWPZiBTfXjoOX7kEMSJNZpB2McxU3?=
 =?us-ascii?Q?l0AuuMIiSfYZcF7KZLANF9V28AULG4zSgHu/nRQKA7evYFKD5YNZvq5CShdO?=
 =?us-ascii?Q?lUrSVw22oOKgDS0PUAlcrXoHraeNoryFjwwSVtWZZ95YWBWoynOw/wWCyayY?=
 =?us-ascii?Q?zGpwWREeUUrez0gTHWVFxNJlBZfNqCueykluX2vhpHFLXfXbg23XEnDzOZ6V?=
 =?us-ascii?Q?8Vj6YQXwgNoJwpTitu0y/yddOION4eqY1PEYOCHzalqTwl5CVFWWaDwNjM0E?=
 =?us-ascii?Q?SjK2FnxiQA8/TLsTyYcA9d3pTe2dI7j5aM+h2g1NiAFiIJNrkaKzeAzvXzEZ?=
 =?us-ascii?Q?4HL6Kgc7R5TWK4Axf2J8fzbbyGv4QKEZ1abRe1uNxF22HvnOyWRUJ+tCMFZH?=
 =?us-ascii?Q?ltHcdKZYY40eYlArn/4ArN6mAYCaN15e1Rc4jHec05SllCTpVwiORtv89DBy?=
 =?us-ascii?Q?Joq/QswE3w8KFIlgmDtp1cr66SISRdhjP6svBiNwz8sasCReo1vI3ShVT7a/?=
 =?us-ascii?Q?jvl0TnWpfishRDR0YYYdLlCbabr0ymM5fUFR2GAJ6vyp3LcN2EgNysY3/MmB?=
 =?us-ascii?Q?ioy9JNb/Lmi5K9uhOuvRfstIqomR/xmhVHKDtARdycjmcztx1xHAGTYEK6bY?=
 =?us-ascii?Q?BHcqV+bda3f4A3uoc38CVWladZYWFxpcYVkX5CFkgvCqfp77P1qkh7ezK7Pe?=
 =?us-ascii?Q?EQzZXT3MxJwBecOg7IsI/99X/+KTDzjmuyDjMBkD2J6edsJ345Yf9FbES1VM?=
 =?us-ascii?Q?XIWwbv/Z0paemvRSnnDgJBuGOAtPJ686zc3AFopYTswHJd5ezFTMR/vQ1BqV?=
 =?us-ascii?Q?1x/wj4+6PN6qUcBGCKa/7wdxAp3vN1Du0K8E3C+4WvTDKpUS7XHeTRKd+8yW?=
 =?us-ascii?Q?wHQD0kD0g8EqyfKc3nCCNeIUUXeMkZB95wAJMc7d77hUe6123pkDDpZTa9In?=
 =?us-ascii?Q?+EiL2nGGdohem5BzP+d5Io5pyffEbNnHWAt53OoCmY4uBAZ4uEoqNZds2fmu?=
 =?us-ascii?Q?KeVLtXwcETZcghnHuLtn5EJ5ZZiksK/20IKCeYEfBCsxUQR6FpXxTkdjF6+o?=
 =?us-ascii?Q?wI91SAicN0ZUruQmYuWaPKSjgSQICbOnFTvY7FdS5hJjPa9P4XO4MMev7izi?=
 =?us-ascii?Q?IjoLiNWtz7kQSQzY2dmkDritTL9udN9SnjFZ/lsiZNqCSqWbGjb/kbcDNOlq?=
 =?us-ascii?Q?pyxOclhUl/Jan/+KhGaAmsT/2Xv95A7com6bR/8xq2gblRe+EtbCbMHOHKgM?=
 =?us-ascii?Q?nScwEi82uD55BtAuUtOYSugah7tFmsfQio1I2xRN+LUMQ8KXRm1m8rQzs5GO?=
 =?us-ascii?Q?laN1BcSPeOf+3CVRlqz6KgMR6LK7ebbH2w4WN9axvy7NDZPKhCAgejl4UoFD?=
 =?us-ascii?Q?I2kHXggHgVnrjpJ2Tm3k+6Wh4D7BzbGmdXyVekiOpysapGt9+t0iJiwqWGWd?=
 =?us-ascii?Q?cGs9DX8hG80nkTYb+OVjhpFBjO/Bk9UuXMlXaOsZqzlkIea/2EDlNp/MYmHU?=
 =?us-ascii?Q?TdD77RBW24WWCRvvk+Il41m6leJ1NUEeFUE7pv8Hi9qSuGQCKYkN9QiitHhC?=
 =?us-ascii?Q?8AxRRreuAP7UtYEoDMLw0nqMFYC9Ltm/q7f5UmD74izvuWeTaCwLT3yv1SHw?=
 =?us-ascii?Q?UVdtqHQyxniXYwB47h9BqCCY/pvbFMekigamd7T1Yx/s1CL5Vs3RR2+PutqC?=
 =?us-ascii?Q?Vh47QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XrRVI/nbTljVyvvV3tCl5LZ0TsfTAQgHJkDtVszrsFCDflF/J7ayLE7G75ygd8nOAu4UhX7c8p9tVJqdFi5ITAOvVkkPM8ieQO8ffpjNzFDMJjZN5f7eQrnGo8D0kvu7SrdoE7zYaCWjCxt6V/bNj9s+yV+pWUUOYQo1Gj/qnTWEiJpwvzWS3nkiwxzIPeJcW1A01rFS8ENGrrd6kBDqHxRJVHDNijwxVIkMhQKjaHb9sexPcyAMjuhC67PAD295zSy8AvjjYkPBiMmlvtoPt3iHh9IXDAZil80f3Etcpz7U7WXxhLzDLr+k5oHMKQrQEf3McY5ehWbagWFcMyhNIwCQVk5oE5xphWtt5XRY/XoLJX7rQ9AVTzGT6YB4TNV5aCS8ozqsWFaLkpbKOqWV5Ql8wnmcpyB+ai9Rvp28pHpeJmMT/SuqZV1cUyVzW16UmPjHZuKv5y/cHQUmwpo7gO25FB/VvZ0u1l7OteJJ6RZQOPII4+DIaUkq+Of8IMX8iwFHiVRp8ufuAamcp4R8fMQuqeBFHVm6d1F0fxHgpG3Bc8l+nE1fY7CAs7Kw/corEnivy/xq2459NGsQ+GC+yRGDOj6oIC6EWNytUIho9KI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fedef79c-96a7-4848-cc6f-08dcf13fb5a3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2024 19:45:11.3340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZGRhP/lS9BE0SKJJNSg6jqJ1pEYH2Su+eqe+VJi8vMjpcdp/b1aaFMR5dqXrm1/zMf0nUzmB4glqQt2jCj72Wf2gnI+WwB8+ohAhbHAjao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6850
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-20_17,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=774 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410200140
X-Proofpoint-GUID: oDbFHu4eveWIq_xy_WqxrhcO5eqMYzPK
X-Proofpoint-ORIG-GUID: oDbFHu4eveWIq_xy_WqxrhcO5eqMYzPK

On Sun, Oct 20, 2024 at 07:37:54PM +0200, Florian Weimer wrote:
> * Lorenzo Stoakes:
>
> > Early testing of the prototype version of this code suggests a 5 times
> > speed up in memory mapping invocations (in conjunction with use of
> > process_madvise()) and a 13% reduction in VMAs on an entirely idle android
> > system and unoptimised code.
> >
> > We expect with optimisation and a loaded system with a larger number of
> > guard pages this could significantly increase, but in any case these
> > numbers are encouraging.
> >
> > This way, rather than having separate VMAs specifying which parts of a
> > range are guard pages, instead we have a VMA spanning the entire range of
> > memory a user is permitted to access and including ranges which are to be
> > 'guarded'.
> >
> > After mapping this, a user can specify which parts of the range should
> > result in a fatal signal when accessed.
> >
> > By restricting the ability to specify guard pages to memory mapped by
> > existing VMAs, we can rely on the mappings being torn down when the
> > mappings are ultimately unmapped and everything works simply as if the
> > memory were not faulted in, from the point of view of the containing VMAs.
>
> We have a glibc (so not Android) dynamic linker bug that asks us to
> remove PROT_NONE mappings in mapped shared objects:
>
>   Extra struct vm_area_struct with ---p created when PAGE_SIZE < max-page-size
>   <https://sourceware.org/bugzilla/show_bug.cgi?id=31076>
>
> It's slightly different from a guard page because our main goal is to
> avoid other mappings to end up in those gaps, which has been shown to
> cause odd application behavior in cases where it happens.  If I
> understand the series correctly, the kernel would not automatically
> attribute those PROT_NONE gaps to the previous or subsequent mapping.
> We would have to extend one of the surrounding mapps and apply
> MADV_POISON to that over-mapped part.  That doesn't seem too onerous.
>
> Could the ELF loader in the kernel do the same thing for the main
> executable and the program loader?

Currently this implementation is only available for private anonymous
memory. We may look at extending it to shmem and file-backed memory in the
future but there are a whole host of things to overcome to make that work
so it's one step at a time! :)

