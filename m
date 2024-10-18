Return-Path: <linux-arch+bounces-8272-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E501E9A4393
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 18:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711541F24AA0
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 16:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43F6202F91;
	Fri, 18 Oct 2024 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MI8kY/VU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CLIYt5fm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DC6202F6B;
	Fri, 18 Oct 2024 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268320; cv=fail; b=bUFkNsSVxpanlFOGgiIahcjhc5wtDor9G3TD+Qw7uBDhN3MoxJVvZAjW+/BMs7jji/NJba2CGYKDo5BbEiKxco4sg1DeWQ4k6gWKcjVeMwG1Zp7NCLmAP/ODkq/TL3it2BW/R7PTXZ2POdCw3Ai8fbJQ2UnA1sl3CfD5LuWOnq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268320; c=relaxed/simple;
	bh=pQyuVBqnw5UKUXwzNpMb4+60eWGZ6/i0U7ef7tZDZmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rNXpYhNTwqTLYiv7N/SiGlAS8TQ97c7FY1QEWKfKMQhIySA/MXTrZAqzTA/xpzYW3rNxcI7bPpKnPJYTw+6J1iyyYSgl0vk37miBRh4cwSaeZUXhBjv/fPAPoAP3xEiDbUjMtYSBmGT9mLlyela2HGpuABdRTy+vf6PIE8/JTZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MI8kY/VU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CLIYt5fm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBggq019370;
	Fri, 18 Oct 2024 16:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=RcEz8PXC4wRAg4GbNH
	NdkMfIhFeBaYGb4VDKEdC1/0c=; b=MI8kY/VUWvtEOpPOESvrW4foG3XNQNABMi
	uvXWoS0sR3L6izyDrIWJcmOYMhlazMbQbsza6rQrHV4hDau2e+NjVeB/of4mE6ct
	BjoMEMePHB824TmZ6/12LOOifomKGHBfHjOsRHG8YcB3lP6Dw2tB+avW0s4LqCvK
	q6bCaV8hWhKa05zEbAL+Ygu70/G+GB3+r6X3Iq5MMg9giQzwGT6CockWvUjbESt6
	kfDe4/iANj3WFza9h/6bW7roBeycaWnVqgubzltKizbbL3nNXpctS8WMmcQTTr55
	ur2YHp+R5E7hknmIcHstfnyRCUVq2ZZPr0VsVWBAAtoJMrGY6PhA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcrtw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 16:18:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IFn2wm026287;
	Fri, 18 Oct 2024 16:18:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjbsqb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 16:18:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWtexNB7S1hjW7WTUxJ3wk7KP9CPjLml/dkA+UjL3Z8NRjrKI4z8v6v+Cpuk3CrWX9qQNa6L3vEQV6R8jGPFAvCjKcH2x6P1XuMpEQItg1B2o5NCImkPfR5yF1So7oQQDOLLmRnp1268fnC/9QR6RvVs2vqntc4ykGM9LiGzmjd6C8YT/u+vntk4TIuKrJEuEVkhsxux7tQEeoaw7xHWRpPZRB5gm4Qpklj0eOnArDDNzVMn8jda5xnIvpaK24TxHGFiW57fBJrNQzKHigkUVNmVpc9XES2CsQxyfKV9QmaXQpTRsvHZawymAtGCdWl7/ZZxPNouZwJLcIqZc4AbRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcEz8PXC4wRAg4GbNHNdkMfIhFeBaYGb4VDKEdC1/0c=;
 b=M1RPyKX9y6tx9P4/FhhwjypGRavaQhyIdmMxvr58xQdr7QOQfSkebNasROL+eAgbsOS+Yn0MuEuABmAL7A1qiH+q2r8cMUlt47eHZBBmMZvA6z2wx6rrmypWCPV/eUfKfGCPmWaSRz8MyBh0d6lu+V/bzgCD9KnLRFmR4aernMpDCpxalkXwv1JzBySa2xDsmtYlf/9tmvHcng6RUIWQJsCzBUkQA1aBFH8o5czGyF1P0/HW6ICDhYmr5zMs8jr0sz7egacIdgMzUjTd51Z006jDRSuhN7rLCl11NsyRKCCrjZlUN0kaXhFNy3iIfuAHgILDEG0HhEMo9FxldIHwTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcEz8PXC4wRAg4GbNHNdkMfIhFeBaYGb4VDKEdC1/0c=;
 b=CLIYt5fmomsjJENmIO5GsfilsNOyzV/fmotKGBOQx6xIKO8tFG8Y1ztzGN945rQ38V8z0AgGYNto3u1NxxdXvfx6pdiw4VeukeJo0Qy5cnGhvr7R+l/XOVs1Yd5BAaFyXWdnmPLoMvMVD/H8w+h+wBuhQ6vVSu/7r7QP6j3jYSo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB5895.namprd10.prod.outlook.com (2603:10b6:510:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 16:18:00 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 16:18:00 +0000
Date: Fri, 18 Oct 2024 17:17:56 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
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
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 0/4] implement lightweight guard pages
Message-ID: <4b5382fd-e553-4fef-a7c7-a2d3130b948d@lucifer.local>
References: <cover.1729196871.git.lorenzo.stoakes@oracle.com>
 <e4985328-dbfa-4c47-9cf9-12aa89ba9798@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4985328-dbfa-4c47-9cf9-12aa89ba9798@suse.cz>
X-ClientProxiedBy: LO2P265CA0303.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::27) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f0ae9a-7d9f-4662-59e6-08dcef906f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NI+o16iFJvdlcdujYcMC3pAo+/pYfdBGab8u67C097Q01hXwuR2Ac68pdSt3?=
 =?us-ascii?Q?n/LlPte30u3PqztHYSK+lfPjzEykzGCkdQhJKN6FOLCD8xA4lgt3+cRfwrZl?=
 =?us-ascii?Q?1mBLqMMu1epKwGEmNkQ2Ye3de3QGt6Zcnq2wBmntbm8gQ/KJ95HYCu+8Wxi2?=
 =?us-ascii?Q?QgYpYvrZ6EtVheZjMRRbPIxKJwTKu/LJZ6WObDcjT3dfK2iNzSA/LDJmUM2i?=
 =?us-ascii?Q?Q+n1v+BlfhICvAlYzcIOvSolSMFVL15AKL9IJCziJ+UfU83w55fzWZfh1TaQ?=
 =?us-ascii?Q?CNAhMQqiPzDo2g+e1Hd9c08LEp22jyrwpUjRB8RLzFJcIXwl6gxZdwr36cdu?=
 =?us-ascii?Q?xhpxmV33Z7ErhOZPZeHekgKTAe0miBc21rYlLxAkeIzrgtNcc759AgH8eyfD?=
 =?us-ascii?Q?AuB48yWmbixfrNdepnJ7aKZLXI4UpXu5HAI1w85uR5kViquqVO/WRbeQmMHW?=
 =?us-ascii?Q?KNcGrhqxn8VpiXc5S0KlIgTfgpNFPWbfbLdbJf0taIZI3A0d1YokhXaqv88z?=
 =?us-ascii?Q?rRIDQLLfTCbuRa/2s/rtVz7CU1KRNcoaQGCs9BnOdTWIJmQvVKHtRK5UNmvW?=
 =?us-ascii?Q?x0jTQMd9MNHyl+s4keMu3QY7dTIh35jp2R745OkODVYbnXsM/zfExCVOemeG?=
 =?us-ascii?Q?ChrTmc0ZeyzC3GmQGTN2QMUPFGBr4KODb1X2gndvH6QXvuKbgxZK+9KWQp0H?=
 =?us-ascii?Q?bPu9Ri0DemMm8+VromzYpYG++15UShVy9Q0d99lv6PnnLeExnfYbBYbuHorq?=
 =?us-ascii?Q?nimayNFOS97Cu4AxM/YiFeIAHrxszwodW0Efcws8ETuNVCN8zkd41yY2hujR?=
 =?us-ascii?Q?6gdBmgZ3hRiE5GNabtDourFNNE7aTvRzjKetLfyBruUN8hNOr3qtgIwu/1n1?=
 =?us-ascii?Q?kLEG6F8HHd97AKcCC5vVcH+6gQJQu5S7JGtyxXr0OAoHQHHYZ2NPJb/4lLBs?=
 =?us-ascii?Q?gdG6HDx5GkT0w2WGUdSZfnDPDRZFoFKbCtgrXoqhKLgtyxs4sPz7MVJmdUn3?=
 =?us-ascii?Q?N1bKi9NjEMcNL/4g2WFbkKQ+j4ClzUQwr6cEvd6JtyRUwPZj5/3z6NSJ3v6q?=
 =?us-ascii?Q?yBXhome2N5GRR/8vlUDy/Qp/yAq5UJb5wRnqN+5WuTJ4P8RHzjzKoFOXT4hn?=
 =?us-ascii?Q?6meaJAYauOpTpzC8255VRWMtN5OBUQ0mlNa+tJ5GriUe0iIoxsoBvJN4O69M?=
 =?us-ascii?Q?VzyQBYqZ24x2Zqa79L9e4nbhkv7S6t42PoT60jruKMtvtPqIQlVTcaIVVvwk?=
 =?us-ascii?Q?V6sKnpP6CYT4GUxw/FQHVLHssm5qDuLvYqFjwOLQJ4gN9oBNuwNi5/6jA/sm?=
 =?us-ascii?Q?H98dpORyQk3RbYp+qZWUKRa4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tsKWWQD3RNfJ0JMbxTsL3/kEmTgGbRPZTRRvn0n8D1f3ixjP1k2iOlVw/+IG?=
 =?us-ascii?Q?FXw9eYAWA0+EiPyfD73MwmUy6itvt6X/u2G2jpkQbQ7z8uIcxMbBiFoqYiLw?=
 =?us-ascii?Q?XmvYQU/4/GfIEiYKwQ/gQFB0mnBlHESGtRSgUsaia8XUjOtWflpYOS80VUlZ?=
 =?us-ascii?Q?ASqIJSE1pf9rKzQkDFEbQLiBqP6WqBJUyQmUC+NEHJnR3+SoGjTaYc5w++2x?=
 =?us-ascii?Q?3F8MEDJRjs+M+VB7Z74flcxyl0+TAsIrEAu6EjXN9l4x8fzqIQbIJhueymzD?=
 =?us-ascii?Q?+BRxxYgsJFB0c5vN3V440zp1ZipFlDMo0Ds7kqn/UZeOq+Fu1D6gHD5ZQzeL?=
 =?us-ascii?Q?4YymbXaZcHSRRvn1kcwwu/VkcvNbZ7z3tQ8wXmqBU2EaaHfpRMSa9ADDX31R?=
 =?us-ascii?Q?QlZGIwzbMf753aGJqiTelnSz3Ktu+p+6K11SErIJgZJfLaLpAuJw6/SJit+Q?=
 =?us-ascii?Q?2xS6NSh2o21hyR53JCcXi2zcUemd0LogC2SI0WU+JvNCaTDnabESSBJX50ZN?=
 =?us-ascii?Q?QLxkFxBPvbWTr2wK3Kmzw5fZ4vjK4nZzyHL2+6unDnN5ANCU27tSO1A47Iey?=
 =?us-ascii?Q?METM/FxtflhOU3UbnPdJtW6OojLszde6oecTWzVjJSCyXhtR9sFnmkL7B9d8?=
 =?us-ascii?Q?MgrHQrtmFV/aIgWFr26obzZ/i9jd+dklMwOC36VrnNVkzRzP8aag4+pCzqMa?=
 =?us-ascii?Q?OcZ2Z2zf+MmOTe49Otk7Ke5PT+R1eirnympTOtCDtuBm7EPffVzIlJlU2fkq?=
 =?us-ascii?Q?nCXbeAXHOVtJesjmV2EYftbf1bhws6c8ytPVw9Wt8SIDezLMA7nBzq1jhaWF?=
 =?us-ascii?Q?AWT8nQW0Kmo4fzeFRWCIhDDIm1RmVPg1O3dZScTBGeszqH4V8LHZqIO4Puz0?=
 =?us-ascii?Q?VhZdAhRYZh/RLh6qvp7SCb52N8g0n8FaHU78EjYFYWPRoAVTmUk0LHk+zgxU?=
 =?us-ascii?Q?6n6nHHvq5mTyqCP9QRrD0mzCfZ9HirdVOc1FtPFrLnay4ELdJlmn4h2Ef0rp?=
 =?us-ascii?Q?DfJHjx2jNy4e+gb1Tr83rkuid6l+igWMUXBSMOhytqUJk5XJXMTCd5NBRn4K?=
 =?us-ascii?Q?flvX1JHMzag7ahrR2RDxUEYr1ljMqhPyw7OnE5vDLpQZfL3+4bZQEydiHPZ9?=
 =?us-ascii?Q?qQ084t369Uk8qFkmClw1HmYTcLbsCA8UI4vGi9N1diABo4r1sk9COJwB2e7j?=
 =?us-ascii?Q?mXlAnBuROGnH7AZuMC0tWteZ7xP1ugx6J2JQiqCpcvm4VAROo4H3K5p0xw6H?=
 =?us-ascii?Q?4yLAXGtzijI+6pUvp9BSWZwpKYwA50i0y6uBbh7X1y/9M029WxmF2KQTmUFA?=
 =?us-ascii?Q?eUEB7Gdm2b4drjEagZW4X1PadlAAbmj1hcR/JvW5dpvQlTZfD0lroXsecvB2?=
 =?us-ascii?Q?Mka5fc6cZn1mDPBz/KeTwLWmBPfQkdLDZYf2PoUbi2LYzgAUXkguKQUnhGZE?=
 =?us-ascii?Q?OfLpKEPfXsRn0+LAO9uwhalwwGvLPyXJKMSg7/sD5WdOwoCwZ6BGZ5IJU3oy?=
 =?us-ascii?Q?0FlsksYwS5GPIIQfwcOjzCxAC/mLq0D/93F6GGu26WJ43N1KFl/wNR82/U5p?=
 =?us-ascii?Q?5YjDFvHw/ATG70INhpPSWLLqc/uUqR13QGFAila1l2YCYW1Biq4v8AWiNvHN?=
 =?us-ascii?Q?+1RO5kQp+jmc+9OnlU78Q1W/s47UBYcDy38p8hvJhMOUrcPBtQacSyC/49Ld?=
 =?us-ascii?Q?73UdMw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ciHQi2Jl41bwu9Ott5qsw1iadcjLtKvJJQ2hsaodB1NFJSb6vABJzSJkEgo14YeulrzAeeyOERmSDtp7eUzGGpsYBAdMkNxSBSKs0NF0G44MGf2AtJYkuQOg+/Elw9HjaSbV95KlRKtUNDBgYpUb7vIBkhKpaHxxwU3AL6q8AsKoQL89jW9U5CZB0oIqXxbT7O6Eq0C5WIc3AhraS0WAO82eyOK+pecgf179vqAUQIf9JFejLmxh2IxVqRZXinirC9CUwvBwp5Ik4fLRNF/HIPfnkUEtCfrPEu5FDW5p22AtRHoBPPHDVJc0z7hurxSAryBnXig99El8t3bxnnbWQ/cv7SpOJ53tN5X3rChfFXeChHDwU/MUBkLryXleuWtWUVYCzbTqviUfeozn1cNTZ/XNbdvmAufgLrVhiKDtAl9QiHNrShEVxkueKT/Tp44J5hCS+qa8YkrVu9MfMEP51GfH9HrochZdmqlfJBgv5LhU1j5lULuWuib2H/v31IbWqWjEDFcD0h3fgCzYFsQiWGi2ShPFHgjtnvjkolbvz2ITJ8cmPxHhPVGZa10pb8FGyFSScyd0U6nYjBQGH5qI/46PNEI86GmLCPodfqoPLU4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f0ae9a-7d9f-4662-59e6-08dcef906f1b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 16:18:00.1302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/Nid4AoRKjx094r/7sM/GSxu3uX13GrohRi7Eqq1HHl0bTT1IJGSUsfeQhxui7qLKHxoPOM0BlR34fOKJoz5S4QDdXuQsqSfAdUZw0c0Yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_11,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=868 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180104
X-Proofpoint-GUID: oPw0X9r32Qb23mJZ2Psg130M6B9khBKy
X-Proofpoint-ORIG-GUID: oPw0X9r32Qb23mJZ2Psg130M6B9khBKy

On Fri, Oct 18, 2024 at 06:10:37PM +0200, Vlastimil Babka wrote:
> +CC linux-api (also should on future revisions)
>

They're cc'd :) assuming Linux API <linux-api@vger.kernel.org> is correct
right?

> On 10/17/24 22:42, Lorenzo Stoakes wrote:
> > Userland library functions such as allocators and threading implementations
> > often require regions of memory to act as 'guard pages' - mappings which,
> > when accessed, result in a fatal signal being sent to the accessing
> > process.
> >
> > The current means by which these are implemented is via a PROT_NONE mmap()
> > mapping, which provides the required semantics however incur an overhead of
> > a VMA for each such region.
> >
> > With a great many processes and threads, this can rapidly add up and incur
> > a significant memory penalty. It also has the added problem of preventing
> > merges that might otherwise be permitted.
> >
> > This series takes a different approach - an idea suggested by Vlasimil
> > Babka (and before him David Hildenbrand and Jann Horn - perhaps more - the
> > provenance becomes a little tricky to ascertain after this - please forgive
> > any omissions!)  - rather than locating the guard pages at the VMA layer,
> > instead placing them in page tables mapping the required ranges.
> >
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
> >
> > This mechanism in effect poisons memory ranges similar to hardware memory
> > poisoning, only it is an entirely software-controlled form of poisoning.
> >
> > Any poisoned region of memory is also able to 'unpoisoned', that is, to
> > have its poison markers removed.
> >
> > The mechanism is implemented via madvise() behaviour - MADV_GUARD_POISON
> > which simply poisons ranges - and MADV_GUARD_UNPOISON - which clears this
> > poisoning.
> >
> > Poisoning can be performed across multiple VMAs and any existing mappings
> > will be cleared, that is zapped, before installing the poisoned page table
> > mappings.
> >
> > There is no concept of 'nested' poisoning, multiple attempts to poison a
> > range will, after the first poisoning, have no effect.
> >
> > Importantly, unpoisoning of poisoned ranges has no effect on non-poisoned
> > memory, so a user can safely unpoison a range of memory and clear only
> > poison page table mappings leaving the rest intact.
> >
> > The actual mechanism by which the page table entries are specified makes
> > use of existing logic - PTE markers, which are used for the userfaultfd
> > UFFDIO_POISON mechanism.
> >
> > Unfortunately PTE_MARKER_POISONED is not suited for the guard page
> > mechanism as it results in VM_FAULT_HWPOISON semantics in the fault
> > handler, so we add our own specific PTE_MARKER_GUARD and adapt existing
> > logic to handle it.
> >
> > We also extend the generic page walk mechanism to allow for installation of
> > PTEs (carefully restricted to memory management logic only to prevent
> > unwanted abuse).
> >
> > We ensure that zapping performed by, for instance, MADV_DONTNEED, does not
> > remove guard poison markers, nor does forking (except when VM_WIPEONFORK is
> > specified for a VMA which implies a total removal of memory
> > characteristics).
> >
> > It's important to note that the guard page implementation is emphatically
> > NOT a security feature, so a user can remove the poisoning if they wish. We
> > simply implement it in such a way as to provide the least surprising
> > behaviour.
> >
> > An extensive set of self-tests are provided which ensure behaviour is as
> > expected and additionally self-documents expected behaviour of poisoned
> > ranges.
> >
> > Suggested-by: Vlastimil Babka <vbabka@suze.cz>
>
> Please fix the domain typo (also in patch 3 :)
>

Damnnn it! I can't believe I left that in. Sorry about that! Will fix on
respin.

Hopefully not to suse.cs ;)

> Thanks for implementing this,
> Vlastimil

Thanks!

>
> > Suggested-by: Jann Horn <jannh@google.com>
> > Suggested-by: David Hildenbrand <david@redhat.com>
> >
> > v1
> > * Un-RFC'd as appears no major objections to approach but rather debate on
> >   implementation.
> > * Fixed issue with arches which need mmu_context.h and
> >   tlbfush.h. header imports in pagewalker logic to be able to use
> >   update_mmu_cache() as reported by the kernel test bot.
> > * Added comments in page walker logic to clarify who can use
> >   ops->install_pte and why as well as adding a check_ops_valid() helper
> >   function, as suggested by Christoph.
> > * Pass false in full parameter in pte_clear_not_present_full() as suggested
> >   by Jann.
> > * Stopped erroneously requiring a write lock for the poison operation as
> >   suggested by Jann and Suren.
> > * Moved anon_vma_prepare() to the start of madvise_guard_poison() to be
> >   consistent with how this is used elsewhere in the kernel as suggested by
> >   Jann.
> > * Avoid returning -EAGAIN if we are raced on page faults, just keep looping
> >   and duck out if a fatal signal is pending or a conditional reschedule is
> >   needed, as suggested by Jann.
> > * Avoid needlessly splitting huge PUDs and PMDs by specifying
> >   ACTION_CONTINUE, as suggested by Jann.
> >
> > RFC
> > https://lore.kernel.org/all/cover.1727440966.git.lorenzo.stoakes@oracle.com/
> >
> > Lorenzo Stoakes (4):
> >   mm: pagewalk: add the ability to install PTEs
> >   mm: add PTE_MARKER_GUARD PTE marker
> >   mm: madvise: implement lightweight guard page mechanism
> >   selftests/mm: add self tests for guard page feature
> >
> >  arch/alpha/include/uapi/asm/mman.h       |    3 +
> >  arch/mips/include/uapi/asm/mman.h        |    3 +
> >  arch/parisc/include/uapi/asm/mman.h      |    3 +
> >  arch/xtensa/include/uapi/asm/mman.h      |    3 +
> >  include/linux/mm_inline.h                |    2 +-
> >  include/linux/pagewalk.h                 |   18 +-
> >  include/linux/swapops.h                  |   26 +-
> >  include/uapi/asm-generic/mman-common.h   |    3 +
> >  mm/hugetlb.c                             |    3 +
> >  mm/internal.h                            |    6 +
> >  mm/madvise.c                             |  168 ++++
> >  mm/memory.c                              |   18 +-
> >  mm/mprotect.c                            |    3 +-
> >  mm/mseal.c                               |    1 +
> >  mm/pagewalk.c                            |  200 ++--
> >  tools/testing/selftests/mm/.gitignore    |    1 +
> >  tools/testing/selftests/mm/Makefile      |    1 +
> >  tools/testing/selftests/mm/guard-pages.c | 1168 ++++++++++++++++++++++
> >  18 files changed, 1564 insertions(+), 66 deletions(-)
> >  create mode 100644 tools/testing/selftests/mm/guard-pages.c
> >
> > --
> > 2.46.2
>

