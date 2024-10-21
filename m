Return-Path: <linux-arch+bounces-8399-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C27E9A9197
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 22:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6CC1C24C8E
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 20:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206281FB3EE;
	Mon, 21 Oct 2024 20:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fUyTT+yf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xUGnMYKb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8AD1C9EDD;
	Mon, 21 Oct 2024 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543799; cv=fail; b=jO7PmCw1VKiSVw51Q7ptUjiW0W4WxUWtS/4xyhtbOaCbtuoGuiR9HNzimdDSJ1qB2Fpkwqk7Fl+MwJQRljQeFD+aYVl8p3AHJjrSWAjbZzij3RYZl0i5cq2215rEFeScAAsn3b24bgvvp4kNopQHuVWWahLJTNZQtzUFrCYouIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543799; c=relaxed/simple;
	bh=6Kt5dCtdLz8htfiFdVUvJxJ6PNrCOz/MXP3jIxIbduo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aZa3Vpc8143F8ZEdCubhF4ht0XqTpb7Y9Z/iXKsLCBvF0r0Avrp0kl4fjMkgM8VLhsrXXnzOoDdrS0D/w4nIHIbFvmJHS9RZrTdNApVZb/ORz/Y0Cix8vA7s1b/nxjVJC8oci7MbyMbZk61o+stiF/iTmSp5NJQR9+GQLmUDVCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fUyTT+yf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xUGnMYKb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LKff5t009913;
	Mon, 21 Oct 2024 20:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=SxfE/Esf9yRKtnbs8Q
	hVe2uNEzpHT8+XjIWnM6hbxWU=; b=fUyTT+yfgiISIw+PSbeyDXMydw++xzj0xP
	llRGjv70p5oqJraiP1qyVb/a3/SZQ7GSgFmPqGllLTlswzaitKS8Pt0N0riLh5ko
	pwiYjztQzxL+soq4hobcAhJ9BBIqIyjcFTSQl6bQJsmiFvhTji10PVZriu8BOTiS
	p0TV4fxqlg+6KdN62Y08ecbsBhVWeHsQ7UumSKh19+Hy96eUbbgVfFUfJ1uhIwTX
	a4DMRMIs1v7VFlQRWNA7AUm/+AJXobyLz7UNxt+tpEj3pdEw3MAIsuORWoi1tMbT
	TH3BD/ZlBkpR+FEI07tlamR8x/rF3JuOxHdkNF1UKh5J1fZvgrhQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3b8x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 20:49:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LKNMHW026940;
	Mon, 21 Oct 2024 20:49:21 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c376uct8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 20:49:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9fo6I1LLZXAsP1ZOtAZuN457/n5MiCWUyifXXR0zhQrJgy7TPV/XY0mws2RZEZoUvNdpm85fgzWIVbegGILM3nyooQNyKLV6QEIINuMoiGLph7RwpK8aRX5nWCgvaljBArJYAngp6mjWt1MxOrL0Bk6eI8C1JZwOeaVoXtasoLC/gJGeB3lNL1LisSUvn3JK065/X71DHgGu3Ltsy2sE2LG2VmyrtWlV/kTd4CWprzqvALs310Jz3WpR9NZXkuWVxV0jjgosEH9CcGUwtS9bpbTx4wyr5JcUMIwmknDCM1d+4pJcRKEysvfnMZr9kfaB0ys9xzQhaIvufAkUN85zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxfE/Esf9yRKtnbs8QhVe2uNEzpHT8+XjIWnM6hbxWU=;
 b=vmEZpN4COIzrk59wMcdNFxTyWnN1Kz2VglmkphwqSvIdImGhP8Wd0ND38zdwwtWhr2c5QhxlXtoHZQnhYtT7csrRM7ZQsVyGnNK17icRpt673y5WqT0+lkM6qqa01vBcQFTemtnSmBzffEV+kKzREhLITcUnzyyxM7ghf1C0b/ITE3uCCZmUu4Jftmrx7QIZZhhv68ncwgIcdRVHMVQk0wU9+6jMrJ/YwFqASSNqjCGq+aSHiJ7rXCPT7F2AV3jH4xa4tYXSwW1cIeMmjwD14zAy7Ed10eDK/Cs82VWZccHo4PIth7i290fdp3MOa47OVYQQpbySRs1dvvd8FA086g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxfE/Esf9yRKtnbs8QhVe2uNEzpHT8+XjIWnM6hbxWU=;
 b=xUGnMYKbq7rEfKMobRoDotuzWVzLhpxGgdyaKg3qerl4jbt2yOSaiGgwqEwaPjS2JyMXXNaRueHiRFJ46DDVTYM+Ua+So6m0+Tc7Ux3M3vkSLvFciy2+l4xbi03Yx/VIOqUmipJU+Mr1bvNRQt9hzp/EsfP0VeFCJg5vKHeUxxg=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BY5PR10MB4337.namprd10.prod.outlook.com (2603:10b6:a03:201::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 20:49:18 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 20:49:18 +0000
Date: Mon, 21 Oct 2024 21:49:15 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <muchun.song@linux.dev>,
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
Subject: Re: [PATCH v2 3/5] mm: madvise: implement lightweight guard page
 mechanism
Message-ID: <73134e10-19eb-4e52-b87f-5fbfd322b575@lucifer.local>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
 <c37ada68-5bf5-4ca5-9de8-c0838160c443@suse.cz>
 <6c282299-506f-45c9-9ddc-9ef4de582394@redhat.com>
 <fedd19ce-ea15-4ded-a1b5-ff050de15bba@suse.cz>
 <9727ada4-0048-499b-a43f-ac0a625bae5d@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9727ada4-0048-499b-a43f-ac0a625bae5d@redhat.com>
X-ClientProxiedBy: LO4P123CA0538.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BY5PR10MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: b452537f-d121-494e-a59e-08dcf211d4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y3bMnPNI6aWO05FSEuNYffIcYfhsOMcgt6A8h9kDGCokqP2vvr3LXGI2bBp6?=
 =?us-ascii?Q?82TZnxUXox0l5YPBymcvd0ifq3QRhQPw1G4R2el434ce/8E8Pq/CglHZpv+Z?=
 =?us-ascii?Q?iV8xLrrTGsoLTWYtPUzfX59a15zeUINaruinPdoFnx8O0oC/kvEteRBfUADt?=
 =?us-ascii?Q?znreKn9hL94k6zvXzDOmxHT3iQD5khCEzxbVROQkvLQ3M1hng87XziOmWdLH?=
 =?us-ascii?Q?qzX2u4fbq5XbExrLogeTJr7bdGB61uTS4H/LqxHq94wLdoDI0PcwSLClQchv?=
 =?us-ascii?Q?ZZQA6OYvO72mZrcVUteJi2O/zRPmRB8gKnOSFYfHl/272iQisdLF9G4Md4Wr?=
 =?us-ascii?Q?G+EnBu1GWoXzeOpwZkbgyhHicOjxgJcpYQ5c6kD8d7l8UN5p0fcbB5sUsmon?=
 =?us-ascii?Q?a/BCm5G0J8e4kPyEmnbhtILYK9jUr3a6YnTGF/u9SO5Dr6l0fbRO3ChPQRDh?=
 =?us-ascii?Q?oQBIaOM7ViUA82zOE5OWGuFs9yIRKwbcB1O3fjZOl+u8B0PzDAF+T6iBzNZd?=
 =?us-ascii?Q?ax1fqMxLtOSZ2Qtuw5XbQMsAW4c6pp1OUp1L2SGl0JqhocyYI9o+VQlQXQ+L?=
 =?us-ascii?Q?2VfAEfvbazGxk5Ml4JCmWAj47df/xeB82Ga/XScgc69sHvjxG/4ggnERMyWW?=
 =?us-ascii?Q?CVEcO543ZNgHArHtaDjFYvhgC+C+7EmzBe6y4k6Ogc/dzpKtUEPK6Ho68Hqa?=
 =?us-ascii?Q?mVDGn+eW78sGvI5g01v/cT/wPLBX6/qKxuaFPUbpjuTrF1yJHqeiZ7XTzKmb?=
 =?us-ascii?Q?40S9xvA7g+TacVthj4NtO90g+h0dfHgpB1N1EKOrJbLK/K7LBw/rxj9lHlC6?=
 =?us-ascii?Q?0ctYmePA0vRinB/jIfdcknoFrDuJcwcMZgb1EdLP4RHzBdth9lTSspbOmhdS?=
 =?us-ascii?Q?p0eA1fSKKZAPoB29NfoF02k7CSo481FJ5qFB4E4dGu4mBmSNLmYJJEO5NpQd?=
 =?us-ascii?Q?aMBStEWKADKDZXt81W2qn5wIniIgOaltU4LLWNJAU2geg6+K5o/bQhVqHAIA?=
 =?us-ascii?Q?CvwiN3GCjHoUWjJRgC/RKYs6SBHfzrG/a50jU1auNtAPJodr9kwcoINygqtS?=
 =?us-ascii?Q?BaFAPeCSBaj8xCs2IraZ/M3f3mycNYr2625Af4QdTJpqnfqJSOSEERMQ3cFw?=
 =?us-ascii?Q?Bpgo6iZwGO/mkVPSImJvNpe2qMsN8HYgh4+Ss32jbjjAklaLnNh4W2tE7TnJ?=
 =?us-ascii?Q?+cq17UVWlkGvjiDGEYMzF0A+qsRZyWSy6n3y/M5jhojplPukRZvWmDcrn0A0?=
 =?us-ascii?Q?q3bzzA21dGC+n7GGYyNHvwtbmT7bw/TMe0NiXhCewwHTwq7SQ6PMga0uaPud?=
 =?us-ascii?Q?B9c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G6q3E3+APuZqIA5GGuBkN6/JZZ0NyDjduCe+9ej1crHmqWOhHQN4QxpNX4l8?=
 =?us-ascii?Q?YiBagXr/rlRbBNNI7UCbhGpPb8SvpqZhTJ9iDhS94KbngZ+JmNIrvwID6qvo?=
 =?us-ascii?Q?wZ2OZeV2+6/R9q+A4/X9O5jwIO372bJc1OEhs+itYxZm+AaD2PahIyYGIly4?=
 =?us-ascii?Q?u+NS8CvIGA/Gyr0k5wNDOpt/F5YIks9/cx75QkVbXFVxjjOD7gfbMfWsln3i?=
 =?us-ascii?Q?T/TBVR5wkVW+berw9RcjhV1MCqMWdWECD+obfqJ12o+j7EtmJqqBcpEJtYC0?=
 =?us-ascii?Q?EOh+w7uVE3sG0/z1CFHMDbFJUiauNdf4W6KtWAIYtVLn24jigIlHbBkRUSYy?=
 =?us-ascii?Q?Jcb9G8yIoh9j0qXpQ2fxbVOFKiIkOIJ7P9mJ48nX4KPYvzlg0jnT+q2TZAo7?=
 =?us-ascii?Q?76dM/2T81GrFWV4FXhFOGakKa1p3oOEM+SD10wpFnwwMxR1cpwtImMCIqxpS?=
 =?us-ascii?Q?/6kEIMBnkGXJ7rBdGf8MqpnCDfpWRV20i4rCUUIr/FbCMjMleqr7h8Jhs/Qp?=
 =?us-ascii?Q?5i5zTDoQ5NGe2AVxw883t+rPfGh5nnhfkC9bwYgKRCP3c/7pRmFWNqibg6Ox?=
 =?us-ascii?Q?jocisgHNyns8SwcEjAWUdfe4+E98CXiguVvO+BgmoofMbNpFI2ROLiTEGPBK?=
 =?us-ascii?Q?1s7/nMOQBgZJZtD1FN0+Ha4ePZlA9sbcEEuHx5JVvRpJkkAuYyK1f8piGm+h?=
 =?us-ascii?Q?BN35v8qxaFELdrqdo4jXve7j9/AQghuz7U0IyNclRFKC4tdc2wNzIS6/l3wg?=
 =?us-ascii?Q?9r6PgXxVY5HGk7JGuGBwknx6LrtCYr/1oOvOb6YjzoIr4P5DXLVlqzv27TBf?=
 =?us-ascii?Q?qdPbX61rLSnyq9QwQLEiXiDagA33krEW9MZdJfiZylJpo0tCFjvmBbvIFDs7?=
 =?us-ascii?Q?c2h5QonqjZl/8W8d9WC05Xpu3OSOg65k5egDQ3ZrOVxgsej7kY4Obp9y67KD?=
 =?us-ascii?Q?Zkdk65b6wumwRYSQv+GyOeC6QD62Ave5tSQ/HvfG4sg0VLTHqYOQwc6uqwqb?=
 =?us-ascii?Q?Ze2Au6hzvWQ8A3bj7Ps1p73jn35EF4vpLg0sppd7yQ6oIFNk/1e987xZ+Bv9?=
 =?us-ascii?Q?xTUIT5umCMCzvcjk1ofRvDjouXrNL8hhEbdCo4YGUejih6Xjxmc8953TbYCm?=
 =?us-ascii?Q?8A07vO1mOPgSFRAisfiMHubfBXuK8vEEJXKlUGjARVip08T9J0+C3OYcBSAi?=
 =?us-ascii?Q?/e1/7HaUy0ug5wswGoyEYsSQeG/4lgH479VhPt6pvo/SB1su2AurW5dze9F5?=
 =?us-ascii?Q?nWnToNI4M3IEacF023cpSh6p5GSXfsxmV6HizAtaagjQoWpGCuh3folRNZh5?=
 =?us-ascii?Q?CTqZ6xkzgWNlJQTWPLBhRyK3LaMy3YBjk74k5THtGG4V3DKDb+R3pZpwzVL1?=
 =?us-ascii?Q?1DVMGHkVX1OqqZ2zu+zBbnRbMkWioJc0rMPFwTAkcbTxzgW7ICFTyp7+0tC6?=
 =?us-ascii?Q?hUuQNvLrdqN6M5V9m5qhnB0hd0l/c34+mjNWLjrcX3egnj3Zeubxrwrz2rmj?=
 =?us-ascii?Q?jhqLjYA92gUwq8P7jaoMQx07WM0FfVraVBTQrh8VwfTMhTbSN4xTgQu9Xkz2?=
 =?us-ascii?Q?iPRMVJYcxWjVVhEOdQx4ukpWzTRTu8/L81TFDTpc3uSgrXpz1PTLeDiv3KH6?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MyF0IfyvMVxrO9YgPvTCrsRDTY+3nSx4/uRCodxjXq+AHlqIQFs57aH5OphNAh3B4VUf9oUwPXDAi4iULtRUt+QQxkDcdwuLuIIgBMOYjY0VCtQJNhQJPAmwvMokr5FV6B5qJsDvTiXSgaVShFPTov+WCeJ4HDvloqjqGH4fen6W8qWSRbwA5HIPNGrx/TG7cGQ8o0xD7H8mlh1MBn2QGgjTBTWV6iCtqcgDu4wKENC5aMyty5HLrOnDNWnZ7f7CwYOhkzDu08BuUorYZNjabduQdQWWzVxhU5pQzsOegs/HAx9/qHoFnIAratQGXK4ARf1ujOiECwbCiWKHcpP5hgF5UBjTS8A73f6sNFpp8amv10XmGsHjg6YL4ZEk0s2XkYhVB+ReMe3pQJHt75m0dKr0Fn/qOZCEv9U36QEPkmpcepOcUf+Hc0RgcrinFhF0Khr086P+2By/INkD6CA1ARGZvLbVSO1znDeX/RzLgtlp+TSVsEO/o5ybi7Zs+YfH+WBfYc1jdPJ1sjV2MWpODPbNHd3oiKJgjpS8/zRC1T/qFpP8zPsWBS5Nte/sBf7PDM1pUHYF66C0PHx8Kw1UQnIqU++mwV5eGMS54LggTcY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b452537f-d121-494e-a59e-08dcf211d4e3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 20:49:18.2481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sKmejoPGxRf0D9JBKlx4bbzYJPWsd1tPxAeIteWa34bcHPI/QW7i/WtDwPYEfIqoDqVQmCHzlOnHtEd8tV5pAUW8FTrg5l8A8yGqxV6OSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4337
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_19,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210149
X-Proofpoint-ORIG-GUID: RxJoxZ1KIBzWBfskZx4hHAt6jLyDos4z
X-Proofpoint-GUID: RxJoxZ1KIBzWBfskZx4hHAt6jLyDos4z

On Mon, Oct 21, 2024 at 10:37:39PM +0200, David Hildenbrand wrote:
> On 21.10.24 22:25, Vlastimil Babka wrote:
> > On 10/21/24 22:17, David Hildenbrand wrote:
> > > On 21.10.24 22:11, Vlastimil Babka wrote:
> > > > On 10/20/24 18:20, Lorenzo Stoakes wrote:
> > > >
> > > > <snip>
> > > >
> > > > > +static long madvise_guard_poison(struct vm_area_struct *vma,
> > > > > +				 struct vm_area_struct **prev,
> > > > > +				 unsigned long start, unsigned long end)
> > > > > +{
> > > > > +	long err;
> > > > > +
> > > > > +	*prev = vma;
> > > > > +	if (!is_valid_guard_vma(vma, /* allow_locked = */false))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	/*
> > > > > +	 * If we install poison markers, then the range is no longer
> > > > > +	 * empty from a page table perspective and therefore it's
> > > > > +	 * appropriate to have an anon_vma.
> > > > > +	 *
> > > > > +	 * This ensures that on fork, we copy page tables correctly.
> > > > > +	 */
> > > > > +	err = anon_vma_prepare(vma);
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > > +	/*
> > > > > +	 * Optimistically try to install the guard poison pages first. If any
> > > > > +	 * non-guard pages are encountered, give up and zap the range before
> > > > > +	 * trying again.
> > > > > +	 */
> > > >
> > > > Should the page walker become powerful enough to handle this in one go? :)
> > > > But sure, if it's too big a task to teach it to zap ptes with all the tlb
> > > > flushing etc (I assume it's something page walkers don't do today), it makes
> > > > sense to do it this way.
> > > > Or we could require userspace to zap first (MADV_DONTNEED), but that would
> > > > unnecessarily mean extra syscalls for the use case of an allocator debug
> > > > mode that wants to turn freed memory to guards to catch use after free.
> > > > So this seems like a good compromise...
> > >
> > > Yes please, KIS.
> >
> > You mean "require userspace to zap first (MADV_DONTNEED)" ?
>
> Yes, I see from Lorenzo's reply that there is apparently some history to
> this (maybe it's all nicely summarized in the cover letter / this patch,
> have to dig further).
>
> Not sure yet what the problem is, I would have thought it's all protected by
> the PTL, and concurrent faults are user space doing something stupid and
> we'd detect it.

The looping mechanism is fine for dealing with concurrent faults. There's
no actual _race_ due to PTL, it's just that a user could repeatedly
populate stuff stupidly in a range that is meant to have poison markers put
in.

It's not likely and would be kind of an abusive of the interface, and it'd
really be a process just hurting itself.

In nearly all cases you won't zap at all. The whole point is it's
optimistic. In 99.99% of others you zap once...

>
> Have to do some more reading on this.

May I suggest a book on the history of the prodigy?

>
> >
> > I'd normally agree with the KIS principle, but..
> >
> > > We can always implement support for that later if
> >
> > it would either mean later we change behavior (installing guards on
> > non-zapped PTEs would have to be an error now but maybe start working later,
> > which is user observable change thus can break somebody)
> >
> > > really required (leave behavior open when documenting).
> >
> > and leaving it open when documenting doesn't really mean anything for the
> > "we don't break userspace" promise vs what the implementation actually does.
>
> Not quite I think. You could start return -EEXIST or -EOPNOTSUPP and
> document that this can change in the future to succeed if there is
> something. User space can sense support.

Yeah I mean originally I had a -EAGAIN which was sort of equivalent of this
but Jann pointed out you're just shifting work to userland who would loop
and repeat.

I just don't see why we'd do this.

In fact I was looking at the series and thinking 'wow it's actually a
really small delta' and being proud but... still not KIS enough apparently
;)

>
> Something failing that at one point starts working is not really breaking
> user space, unless someone really *wants* to fail if there is already
> something (e.g., concurrent fault -> bail out instead of hiding it).
>
> Of course, a more elegant solution would be GUARD_INSTALL vs.
> GUARD_FORCE_INSTALL.
>
> .. but again, there seems to be more history to this.

I don't think there's really any value in that. There's just no sensible
situation in which a user would care about this I don't think.

And if you're saying 'hey do MADV_DONTNEED if this fails and keep trying!'
then why not just do that in the kernel?

Trying to explain to a user 'hey this is for installing guard pages but if
there's a facing fault it'll fail and that could keep happening and then
you'll have to zap and maybe in a loop' just... seems like a bloody awful
interface?

I prefer 'here's an interface for installing and removing guard pages,
enjoy!' :)

>
> --
> Cheers,
>
> David / dhildenb
>

