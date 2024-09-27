Return-Path: <linux-arch+bounces-7471-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A0A9885A2
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 14:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D0E1C213E5
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 12:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A0F18E345;
	Fri, 27 Sep 2024 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eWKL0qzL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Tz8C3HZB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDE518CC05;
	Fri, 27 Sep 2024 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727441560; cv=fail; b=HPOhSMleEoIJV1RzTklvfzDZ3OiYEXrocDzVGaITnC7075N20GEI7ZGCKsmF4+soIfQTvGFXFDrVG0g45c5BLIVbbaeucULFEO4XIBU8heZZtQCzhCTdruDCIMDYyMGA7dzQepTz5IIs7P0TOZtUREl8AGQCRSiojDWUZIRqUPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727441560; c=relaxed/simple;
	bh=i2BWEZvg5N6ekd6YZfDt4VKQbhuivxhjme7fb8k90S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vt5xNwqXKp/XtQiL1yugshFx6x2N5dtdJa3+rsqEqiCrLGqp1RNHkVnOHcaPUKf7w5bOc1MH9FTlGyCx/b3WYLYX1A3q0jIrTF7O9uE4hU1ZorT1MC/aTTutVwFy3bCnG5AgzkXkQkWq4MFgKs09cRXw3zNas+9gXIY2zFx1JwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eWKL0qzL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Tz8C3HZB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R5hIi6021683;
	Fri, 27 Sep 2024 12:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=mjxjOr5wbvhvGFQe1h5NBiR5xNC7dPyxjLQzSwUhIwM=; b=
	eWKL0qzL0EHQ3oS3TCTS9K8jzqNKixgT+qZHICXszJauYfdzm/nYgWTwIutgbcf/
	pD06f3JQZo5CJV4lFA1go5BnAy8CHDEmnkp5X/61R/d63suztrOGGMpNQRcmGzAr
	Q6HlIaAl6TM0Q/AaC4V7Kvec+oFzDTJgUl9QlSdUL1gJJFMRouwcoZPmyVnJzt51
	aD0DQxom1dYS+Aq8v91baWQLDeZI4EVRNuLcKbWznA14aaFkdRLhbqh5DvEyqUDO
	pbIxs+baBzlUWhaZUjT/2SeN7ODoDJbOzy0V8gCY8KLabyYr2eh/4A/ZQETB3GQV
	LjAb5MBgTPikpBp7iswOag==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sppufk41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 12:51:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48RBxrhZ009692;
	Fri, 27 Sep 2024 12:51:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smkd6pb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 12:51:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnzrdxUnoMfKLyx71fmZqV1ve6wdeb9kbCazKt/qFiG3anhAOF0l8qV7TAFKexZrFusWQs5IGJj8Z6kv0B+ZVzk/xmeRomNkscaD/xvE3FaVC328yFMg7j1cNZfVAXiyyci9hY1KucGaPcRrPPA19382Dy4MyXDHAP+llZc7fQoq6ykKRwfj2Qbz1rE/S2QjfWCAi+IOHet2yxn7u0l9KpYGDdCOOyncmrtdK5JKXHWqa0GnyRiqH65IYZbPaRNbaA7Bt1AChVm0zW0dA5K8xIeXKrtViGUYBjQJ5POxbojMoZLDbZeBeE5LkKTYPXlGPUUiZY6qN8PZGI3jfh2Pkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjxjOr5wbvhvGFQe1h5NBiR5xNC7dPyxjLQzSwUhIwM=;
 b=Lpcfu4+SjVBiVqy3sS9a6jvxgS0HQm8kM83b3zaCsq4HyGVYjhoK6hIZQZUBnW0cempjfIta4a1JlRfCQAsiT5ItHTTWlPUibJ6axFUaWyL5LCYX5kt/D6lEQn+TbcINP5o5scgUOoWK1zO5oSFA9jW/u08FDi2ImBcnXaOC+xsFlakE5rz0IVIAk5QxK5XN+c8IeSIkbvQmU4Mgzg1EuB7bV8tjN+zgSx8Ch/cb2WJOrUvD6LUZVUQTk+tnB2OfPk1XjYLuHKGR2X5tykIIEscrMBPLuUaGWeu8YMEyD2kSHWTh+r3wCMVVRLQJDRVS4PIB1/Kac3GRiwRUKqW6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjxjOr5wbvhvGFQe1h5NBiR5xNC7dPyxjLQzSwUhIwM=;
 b=Tz8C3HZBDdHav2NC+UUQFxqVwXqq1RLMxu2GWAY+zygqShMY3D/9bDEyog2U4UwQasfeVqGoIqgtxMdZYzES8HWWfw5N/vZzCM1emKB0moseX/IbL6IEExZ5evWead89L9qw4fZ6+E6H8pgc5kuoL1y1Vp40iEh3X0Fh4r+fAYg=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB6820.namprd10.prod.outlook.com (2603:10b6:208:437::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.10; Fri, 27 Sep
 2024 12:51:38 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.009; Fri, 27 Sep 2024
 12:51:38 +0000
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
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [RFC PATCH 4/4] selftests/mm: add self tests for guard page feature
Date: Fri, 27 Sep 2024 13:51:14 +0100
Message-ID: <7906f1f50cf6e2d734965627625c3a1df8c3e3e9.1727440966.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
References: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0067.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ea31e9-0d1c-4e4e-c431-08dcdef3201b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/peCwN6W2y4GThXw3Mmn6f03cFJO4vaBD8tu4dXYLUacHvZuIToT//8Vvg/2?=
 =?us-ascii?Q?I1YzRX+MAPIl/TAF1DN+uor+hJhBRx6zrUXGtSccmItk4rUMDrmTHt+fSe05?=
 =?us-ascii?Q?E5FEksATNjH9icaRZ5x0gk9IuQcNC1TNi5afm/rFwOLZFYdPFqqIOKStqe9B?=
 =?us-ascii?Q?V3afuBWwnGG4Nx1tvmftpmMbGSzGvzISdksYfMggHrg58tznAoUgHa7GtVr1?=
 =?us-ascii?Q?HiH+3Kt+kI71c8NC0SHhEwfsE4g07MbQKeQ0/POj+GNuteJLr43VuhLW7q48?=
 =?us-ascii?Q?gL+cor9fbuHpxXmoPo8VUjNpb1l//fyCC89+qOLAjeI8etEbgQ9HkQ3RTLqS?=
 =?us-ascii?Q?ejlwJwcc1Skdc0frE4vxvziW7j/+VJOlRUbRJa/DIx7Fx6zOvumYDMdFHCEC?=
 =?us-ascii?Q?29Y9ukl/TaYz+DrR52Sl8oeEf1ElYQ4byNrDAWwq8Dl/yEvl/gLGFFalPFWl?=
 =?us-ascii?Q?bsdbWqLLBZWJElniCtGoQ8CvBZDtS05MQUQdBspyhIJN5daA3dnGfLO0hX+n?=
 =?us-ascii?Q?3oa4Yt+RTIQS3Z60g9q+PupTxJmHehqjLF2YRzHMKbV1M8nN330/r/rWuNku?=
 =?us-ascii?Q?LXI/hDXoII+K7XLlkT1XodOZy34Gd3T8TZZ8uF1jI09xy0oyptLCvHwjQ5J0?=
 =?us-ascii?Q?S+rStoCFDrj7sGEvzllVSSbWH3fOn7K/GOk+7+euMHvGIfES19xXbgL5f5BH?=
 =?us-ascii?Q?/j8Mwvwyl799+VC6UBbmIhtpT1+bteeIoXS9eHHax/znpHML1U2z8QP3q0Yj?=
 =?us-ascii?Q?7w6gRTefbGwTNyXsfA1/ifNl8w1MvDw9Qj03WFZPW+k2Vh3v5D1WsUsSrApg?=
 =?us-ascii?Q?cs7qKl76rvJLPrjwYqnPfEQ9M55NkmKxLfhUcQMsWzNQyOLstkHfnYMYWWs7?=
 =?us-ascii?Q?nQPiOFwFrZqv4LDtau3zzQpwlbeKclb354nAakih2VlfHij8xPRPJsvfw1rQ?=
 =?us-ascii?Q?VAJSObpOIOhl+RhOtZGVt4fgk9bzlUPoWqLw5LKMfI13s88i6G7vAdwpPa1m?=
 =?us-ascii?Q?HJQgjxrOg6BIoU4l+vbMo07RnoqNUP85e6tsL3JUl2Uw10+ryqmX+KyrjnJn?=
 =?us-ascii?Q?xzB1vv9EqbhMBmc5iTRyYp2PZMk9Tk2IO5Dx3FBelgJB1GfIxRFPrr9VYt5V?=
 =?us-ascii?Q?YxKXlLMYY4+bpnCpsvKcbgzc8g74NVbBcpj5Tscgdf8sJcsns+7fY9sVwi4R?=
 =?us-ascii?Q?LH4MiFIT7VkFoyNHG/RkqwS1p8itkJAt/ejMiK4tpjvMbC3rnGljYZR8dhB5?=
 =?us-ascii?Q?idQs2bUZeduNJx0aM77t5atiwCttGtQDvlNJixXV+u7TPSNT4L4NfVamGczE?=
 =?us-ascii?Q?EXpchElb3sc1PMQAx/ygm0khTLr7erfxnQLgNhJPAjZ2+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AIEwkbPTKnQ/qCA7w1c6PPAxoDpSmTU1KxLdrjezqmxSc6NfpGyBWZPJAm3T?=
 =?us-ascii?Q?M8fG3V6xhRwZUdFAJsD+tldZ9JWntwaSo64arYNeW8Q5SrwHsRnQUt+JNyk5?=
 =?us-ascii?Q?ctmDe4+SvB5fhnj5O+/1lV7ZvmTxO9YgvQgLsEJl0qo/lHJva/eJl+HYg1xK?=
 =?us-ascii?Q?3yX/VDo9eLEzDzWL1OW75AmYa046eiie9DQ2j2ASy6HLCjKZPWX5ru3MoIt6?=
 =?us-ascii?Q?2s9JWuntQzEuaJ14cj3aCRrPxWoxOqhIn7eVY8t1LuP5g49VQ3GuEk+ZGoKp?=
 =?us-ascii?Q?S6eeGeMdiXu6x1VX+WADfZMhc4TFZB4OzSyFr05kvdnwruT9JozcjvbXsg3P?=
 =?us-ascii?Q?JVeCn8EfBEaefDCKecuuGMeD0qL7nB6uuyK6bfiE3SzOJWcpE7M7cAlpNkS2?=
 =?us-ascii?Q?RNvye5QS23aVkn1tjsJk27N8Hr0UwEXLLWkm/0i/zw0UFCat2wYvq3xYiujt?=
 =?us-ascii?Q?tYVzDawzkjMQkdh8+nKYx8Ihugv9wSCPfoHLpcR1qA6+AgeMjGB9KtktQpko?=
 =?us-ascii?Q?n0/6TPD6Sk6KVxqkHLSezG5PWSzOpPdv9XXTPRi6hhKzHdiW04yba9Qiz9By?=
 =?us-ascii?Q?cb8f06HutyeAZY3OkCUjmrW90DNg5cj/jg+peWWYQg842L56r0KCirMw617s?=
 =?us-ascii?Q?76zEle/TytG+ErM5ETxs8TTCNsd/mhhEpVXKaK7fCRFpl5i974SXHrmJmL7b?=
 =?us-ascii?Q?vc4t8OCtRrIaeTXc32LiKzJqqKr30Dving7dyiaY9k5nNPQabQZHcGY/peTM?=
 =?us-ascii?Q?mF6lu0SxG5bWWPgUK0pA0J74XuWJGteBHJLjtNYVTUo1eaESrjOUtLpx1S+J?=
 =?us-ascii?Q?W3TXNZmHQo7GFbDCJBzFDPIeHxCvRYWXiA9hDkWQgNuj6ltZepw0RhTnbi/7?=
 =?us-ascii?Q?FqadBQyFTHNB5KKeeDGjvcFb+Dr73ouiUexHSnLVazKt2Wv7/c2yW9BfCns0?=
 =?us-ascii?Q?F9BO0XXgIPjIEa78Xx3fgrz+T9f2tHQCSQMp8GpiuP4L7fEx9eCNAWviprR4?=
 =?us-ascii?Q?Ca8OO8Sxpb/PNLGCboVWSdCN0N1SFBzPK9CZpwrLXKn9qNz92gJW5/xqQeHb?=
 =?us-ascii?Q?nt+VVXAiXjTLl7NbwZg1A+xWtW4CPhmdShtDxkHHEmHA+FJtzfTqyd8U82J7?=
 =?us-ascii?Q?0SSHJcC6Ysj8ohaoV1bvJM8uF9XiYa0K/PhDvXQWecQELQNFs4ruMt8tuAVK?=
 =?us-ascii?Q?Dq588FayBjTIZcGM2xa+erFtCwx0qF/WM9AhaF/SAsCTYD1u9ZWTIdLN6Mni?=
 =?us-ascii?Q?U2d8SdMTqIG0NsZofzM8nPOQ5Y3M+jSrl7m24N1J9Burj/VVmw7WYm5DR+tv?=
 =?us-ascii?Q?SPGpe49yzHVgHhzmVHIyM4wAqeG63tPEE7tLadAK71VYr+BvGNYhe/rywFeF?=
 =?us-ascii?Q?aNvmDmKuUUfW1MonBFg68yFkAlF4yYsVHBBUe9dTJO1Kh52RfB7RU5jZGBaL?=
 =?us-ascii?Q?rgPYZNz7eC2ba2L2w1JGwGcC9Tv9h3Pl1Ryr99oeO9WUcx4oZ8LRV0ieIiuJ?=
 =?us-ascii?Q?wV/PztcMBWYfyGJX3+mQ7vBEJu3pn+7GONfbC8QpkGUzDY1cEkCtcCsACPTo?=
 =?us-ascii?Q?DLAkcwH4l8vu1A1aEIJpupPQt6gR5VuarelEXF3laThkuW6IIUgp1PQnBr+Z?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ngi/7HI+B8+evvkydTv7htxa9pIASx0ybFmVkd4ulYiDxMoheLktiaDMJnEX0xsgX/7kvKFHpjUeMBkdWrv+nmlZXBtvu7c/lecWoaGiQKmdcOz8l140stRupHCX833vhU/6Y8ZynXYA10/vzlEw1vsmynsrxU2EB4KGZi0ohZzqjsPtDEi1yqLb9O33Iej9s+Q+ww+BiDGvGJ9lc7CKY8eBKR6p/Rv8pcVLpu9KlTbN42+7VLFz6OJyVKEWq6UOQvAgaSZIOfOVBMrtQqdRklMJtdEwkljf/GthE4v5q7QtbwDCPcK5Mi48c5PKXTb34gKIwoj6Q3LpWBEuYzQ/6WFgIX+ymNuL5SQObd1y84CogN+XW8lNhN3Gs5hFyGeX86N03+l3HkVjvrFD/BTGBFErkjHEXJob1e65FUwNS0Pirp5tCfByJ5S1pWcgTPMREcUl8pdInKuRX4z8BFgksij7n4Hvmq1QjZnIkYyYGEZYgcBus13hNLCXGfAKUDdS+lfvlZe/VWJ11Al1bC8e6v7iDcXeJaO8nN5hbLCF6VJDwAfVyEYI4vpcJixMwaQH/aC9I7b0oCG3nLdJMgxtJ6IhNT3o+erLOjy5PsEAJKk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ea31e9-0d1c-4e4e-c431-08dcdef3201b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 12:51:37.9454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QWo5aTzSRrrJqZ5m7iUpl/2MtApA3ZRU5Yquw8CcCkwVwdtBnB0TGy8WmlXlt0KVRdr0asJIbeb1hCUGFL2uWCp74TF1PnWZRL4ASlDbFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409270092
X-Proofpoint-GUID: lelYYH77LUddKAfTrPF4n4tVvz9aRmlp
X-Proofpoint-ORIG-GUID: lelYYH77LUddKAfTrPF4n4tVvz9aRmlp

Utilise the kselftest harmness to implement tests for the guard page
implementation.

We start by implement basic tests asserting that guard pages can be
established (poisoned), cleared (remedied) and that touching poisoned pages
result in SIGSEGV. We also assert that, in remedying a range, non-poison
pages remain intact.

We then examine different operations on regions containing poison markers
behave to ensure correct behaviour:

* Operations over multiple VMAs operate as expected.
* Invoking MADV_GUARD_POISION / MADV_GUARD_REMEDY via process_madvise() in
  batches works correctly.
* Ensuring that munmap() correctly tears down poison markers.
* Using mprotect() to adjust protection bits does not in any way override
  or cause issues with poison markers.
* Ensuring that splitting and merging VMAs around poison markers causes no
  issue - i.e. that a marker which 'belongs' to one VMA can function just
  as well 'belonging' to another.
* Ensuring that madvise(..., MADV_DONTNEED) does not remove poison markers.
* Ensuring that mlock()'ing a range containing poison markers does not
  cause issues.
* Ensuring that mremap() can move a poisoned range and retain poison
  markers.
* Ensuring that mremap() can expand a poisoned range and retain poison
  markers (perhaps moving the range).
* Ensuring that mremap() can shrink a poisoned range and retain poison
  markers.
* Ensuring that forking a process correctly retains poison markers.
* Ensuring that forking a VMA with VM_WIPEONFORK set behaves sanely.
* Ensuring that lazyfree simply clears poison markers.
* Ensuring that userfaultfd can co-exist with guard pages.
* Ensuring that madvise(..., MADV_POPULATE_READ) and
  madvise(..., MADV_POPULATE_WRITE) error out when encountering
  poison markers.
* Ensuring that madvise(..., MADV_COLD) and madvise(..., MADV_PAGEOUT) do
  not remove poison markers.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/.gitignore    |    1 +
 tools/testing/selftests/mm/Makefile      |    1 +
 tools/testing/selftests/mm/guard-pages.c | 1168 ++++++++++++++++++++++
 3 files changed, 1170 insertions(+)
 create mode 100644 tools/testing/selftests/mm/guard-pages.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 689bbd520296..8f01f4da1c0d 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -54,3 +54,4 @@ droppable
 hugetlb_dio
 pkey_sighandler_tests_32
 pkey_sighandler_tests_64
+guard-pages
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 02e1204971b0..15c734d6cfec 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -79,6 +79,7 @@ TEST_GEN_FILES += hugetlb_fault_after_madv
 TEST_GEN_FILES += hugetlb_madv_vs_map
 TEST_GEN_FILES += hugetlb_dio
 TEST_GEN_FILES += droppable
+TEST_GEN_FILES += guard-pages
 
 ifneq ($(ARCH),arm64)
 TEST_GEN_FILES += soft-dirty
diff --git a/tools/testing/selftests/mm/guard-pages.c b/tools/testing/selftests/mm/guard-pages.c
new file mode 100644
index 000000000000..2ab0ff3ba5a0
--- /dev/null
+++ b/tools/testing/selftests/mm/guard-pages.c
@@ -0,0 +1,1168 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define _GNU_SOURCE
+#include "../kselftest_harness.h"
+#include <assert.h>
+#include <fcntl.h>
+#include <setjmp.h>
+#include <errno.h>
+#include <linux/userfaultfd.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <sys/uio.h>
+#include <unistd.h>
+
+/* These may not yet be available in the uAPI so define if not. */
+
+#ifndef MADV_GUARD_POISON
+#define MADV_GUARD_POISON	102
+#endif
+
+#ifndef MADV_GUARD_UNPOISON
+#define MADV_GUARD_UNPOISON	103
+#endif
+
+volatile bool signal_jump_set;
+sigjmp_buf signal_jmp_buf;
+
+static int userfaultfd(int flags)
+{
+	return syscall(SYS_userfaultfd, flags);
+}
+
+static void handle_fatal(int c)
+{
+	if (!signal_jump_set)
+		return;
+
+	siglongjmp(signal_jmp_buf, c);
+}
+
+static int pidfd_open(pid_t pid, unsigned int flags)
+{
+	return syscall(SYS_pidfd_open, pid, flags);
+}
+
+/*
+ * Enable our signal catcher and try to read/write the specified buffer. The
+ * return value indicates whether the read/write succeeds without a fatal
+ * signal.
+ */
+static bool try_access_buf(char *ptr, bool write)
+{
+	bool failed;
+
+	/* Tell signal handler to jump back here on fatal signal. */
+	signal_jump_set = true;
+	/* If a fatal signal arose, we will jump back here and failed is set. */
+	failed = sigsetjmp(signal_jmp_buf, 0) != 0;
+
+	if (!failed) {
+		if (write) {
+			*ptr = 'x';
+		} else {
+			const volatile char *chr = ptr;
+
+			/* Force read. */
+			(void)*chr;
+		}
+	}
+
+	signal_jump_set = false;
+	return !failed;
+}
+
+/* Try and read from a buffer, return true if no fatal signal. */
+static bool try_read_buf(char *ptr)
+{
+	return try_access_buf(ptr, false);
+}
+
+/* Try and write to a buffer, return true if no fatal signal. */
+static bool try_write_buf(char *ptr)
+{
+	return try_access_buf(ptr, true);
+}
+
+/*
+ * Try and BOTH read from AND write to a buffer, return true if BOTH operations
+ * succeed.
+ */
+static bool try_read_write_buf(char *ptr)
+{
+	return try_read_buf(ptr) && try_write_buf(ptr);
+}
+
+FIXTURE(guard_pages)
+{
+	unsigned long page_size;
+};
+
+FIXTURE_SETUP(guard_pages)
+{
+	struct sigaction act = {
+		.sa_handler = &handle_fatal,
+		.sa_flags = SA_NODEFER,
+	};
+
+	sigemptyset(&act.sa_mask);
+	if (sigaction(SIGSEGV, &act, NULL)) {
+		perror("sigaction");
+		ksft_exit_fail();
+	}
+
+	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
+};
+
+FIXTURE_TEARDOWN(guard_pages)
+{
+	struct sigaction act = {
+		.sa_handler = SIG_DFL,
+		.sa_flags = SA_NODEFER,
+	};
+
+	sigemptyset(&act.sa_mask);
+	sigaction(SIGSEGV, &act, NULL);
+}
+
+TEST_F(guard_pages, basic)
+{
+	const unsigned long NUM_PAGES = 10;
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	ptr = mmap(NULL, NUM_PAGES * page_size, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANON, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Trivially assert we can touch the first page. */
+	ASSERT_TRUE(try_read_write_buf(ptr));
+
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
+
+	/* Establish that 1st page SIGSEGV's. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+
+	/* Ensure we can touch everything else.*/
+	for (i = 1; i < NUM_PAGES; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Establish a guard page at the end of the mapping. */
+	ASSERT_EQ(madvise(&ptr[(NUM_PAGES - 1) * page_size], page_size,
+			  MADV_GUARD_POISON), 0);
+
+	/* Check that both guard pages result in SIGSEGV. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[(NUM_PAGES - 1) * page_size]));
+
+	/* Unpoison the first. */
+	ASSERT_FALSE(madvise(ptr, page_size, MADV_GUARD_UNPOISON));
+
+	/* Make sure we can touch it. */
+	ASSERT_TRUE(try_read_write_buf(ptr));
+
+	/* Unpoison the last. */
+	ASSERT_FALSE(madvise(&ptr[(NUM_PAGES - 1) * page_size], page_size,
+			     MADV_GUARD_UNPOISON));
+
+	/* Make sure we can touch it. */
+	ASSERT_TRUE(try_read_write_buf(&ptr[(NUM_PAGES - 1) * page_size]));
+
+	/*
+	 *  Test setting a _range_ of pages, namely the first 3. The first of
+	 *  these be faulted in, so this also tests that we can poison backed
+	 *  pages.
+	 */
+	ASSERT_EQ(madvise(ptr, 3 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure they are all poisoned. */
+	for (i = 0; i < 3; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Make sure the rest are not. */
+	for (i = 3; i < NUM_PAGES; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Unpoison them. */
+	ASSERT_EQ(madvise(ptr, NUM_PAGES * page_size, MADV_GUARD_UNPOISON), 0);
+
+	/* Now make sure we can touch everything. */
+	for (i = 0; i < NUM_PAGES; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Now unpoison everything, make sure we don't remove existing entries */
+	ASSERT_EQ(madvise(ptr, NUM_PAGES * page_size, MADV_GUARD_UNPOISON), 0);
+
+	for (i = 0; i < NUM_PAGES * page_size; i += page_size) {
+		ASSERT_EQ(ptr[i], 'x');
+	}
+
+	ASSERT_EQ(munmap(ptr, NUM_PAGES * page_size), 0);
+}
+
+/* Assert that operations applied across multiple VMAs work as expected. */
+TEST_F(guard_pages, multi_vma)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr_region, *ptr, *ptr1, *ptr2, *ptr3;
+	int i;
+
+	/* Reserve a 100 page region over which we can install VMAs. */
+	ptr_region = mmap(NULL, 100 * page_size, PROT_NONE,
+			  MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_region, MAP_FAILED);
+
+	/* Place a VMA of 10 pages size at the start of the region. */
+	ptr1 = mmap(ptr_region, 10 * page_size, PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr1, MAP_FAILED);
+
+	/* Place a VMA of 5 pages size 50 pages into the region. */
+	ptr2 = mmap(&ptr_region[50 * page_size], 5 * page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/* Place a VMA of 20 pages size at the end of the region. */
+	ptr3 = mmap(&ptr_region[80 * page_size], 20 * page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr3, MAP_FAILED);
+
+	/* Unmap gaps. */
+	ASSERT_EQ(munmap(&ptr_region[10 * page_size], 40 * page_size), 0);
+	ASSERT_EQ(munmap(&ptr_region[55 * page_size], 25 * page_size), 0);
+
+	/*
+	 * We end up with VMAs like this:
+	 *
+	 * 0    10 .. 50   55 .. 80   100
+	 * [---]      [---]      [---]
+	 */
+
+	/* Now poison the whole range and make sure all VMAs are poisoned. */
+
+	/*
+	 * madvise() is certifiable and lets you perform operations over gaps,
+	 * everything works, but it indicates an error and errno is set to
+	 * -ENOMEM. Also if anything runs out of memory it is set to
+	 * -ENOMEM. You are meant to guess which is which.
+	 */
+	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_POISON), -1);
+	ASSERT_EQ(errno, ENOMEM);
+
+	for (i = 0; i < 10; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr1[i * page_size]));
+	}
+
+	for (i = 0; i < 5; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr2[i * page_size]));
+	}
+
+	for (i = 0; i < 20; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr3[i * page_size]));
+	}
+
+	/* Now unpoison the range and assert the opposite. */
+
+	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_UNPOISON), -1);
+	ASSERT_EQ(errno, ENOMEM);
+
+	for (i = 0; i < 10; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr1[i * page_size]));
+	}
+
+	for (i = 0; i < 5; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr2[i * page_size]));
+	}
+
+	for (i = 0; i < 20; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr3[i * page_size]));
+	}
+
+	/* Now map incompatible VMAs in the gaps. */
+	ptr = mmap(&ptr_region[10 * page_size], 40 * page_size,
+		   PROT_READ | PROT_WRITE | PROT_EXEC,
+		   MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr = mmap(&ptr_region[55 * page_size], 25 * page_size,
+		   PROT_READ | PROT_WRITE | PROT_EXEC,
+		   MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/*
+	 * We end up with VMAs like this:
+	 *
+	 * 0    10 .. 50   55 .. 80   100
+	 * [---][xxxx][---][xxxx][---]
+	 *
+	 * Where 'x' signifies VMAs that cannot be merged with those adjacent to
+	 * them.
+	 */
+
+	/* Multiple VMAs adjacent to one another should result in no error. */
+	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_POISON), 0);
+	for (i = 0; i < 100; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr_region[i * page_size]));
+	}
+	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_UNPOISON), 0);
+	for (i = 0; i < 100; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr_region[i * page_size]));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr_region, 100 * page_size), 0);
+}
+
+/*
+ * Assert that batched operations performed using process_madvise() work as
+ * expected.
+ */
+TEST_F(guard_pages, process_madvise)
+{
+	const unsigned long page_size = self->page_size;
+	pid_t pid = getpid();
+	int pidfd = pidfd_open(pid, 0);
+	char *ptr_region, *ptr1, *ptr2, *ptr3;
+	ssize_t count;
+	struct iovec vec[6];
+
+	ASSERT_NE(pidfd, -1);
+
+	/* Reserve region to map over. */
+	ptr_region = mmap(NULL, 100 * page_size, PROT_NONE,
+			  MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_region, MAP_FAILED);
+
+	/* 10 pages offset 1 page into reserve region. */
+	ptr1 = mmap(&ptr_region[page_size], 10 * page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr1, MAP_FAILED);
+	/* We want poison markers at start/end of each VMA. */
+	vec[0].iov_base = ptr1;
+	vec[0].iov_len = page_size;
+	vec[1].iov_base = &ptr1[9 * page_size];
+	vec[1].iov_len = page_size;
+
+	/* 5 pages offset 50 pages into reserve region. */
+	ptr2 = mmap(&ptr_region[50 * page_size], 5 * page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	vec[2].iov_base = ptr2;
+	vec[2].iov_len = page_size;
+	vec[3].iov_base = &ptr2[4 * page_size];
+	vec[3].iov_len = page_size;
+
+	/* 20 pages offset 79 pages into reserve region. */
+	ptr3 = mmap(&ptr_region[79 * page_size], 20 * page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr3, MAP_FAILED);
+	vec[4].iov_base = ptr3;
+	vec[4].iov_len = page_size;
+	vec[5].iov_base = &ptr3[19 * page_size];
+	vec[5].iov_len = page_size;
+
+	/* Free surrounding VMAs. */
+	ASSERT_EQ(munmap(ptr_region, page_size), 0);
+	ASSERT_EQ(munmap(&ptr_region[11 * page_size], 39 * page_size), 0);
+	ASSERT_EQ(munmap(&ptr_region[55 * page_size], 24 * page_size), 0);
+	ASSERT_EQ(munmap(&ptr_region[99 * page_size], page_size), 0);
+
+	/* Now poison in one step. */
+	count = process_madvise(pidfd, vec, 6, MADV_GUARD_POISON, 0);
+
+	/* OK we don't have permission to do this, skip. */
+	if (count == -1 && errno == EPERM)
+		ksft_exit_skip("No process_madvise() permissions\n");
+
+	/* Returns the number of bytes advised. */
+	ASSERT_EQ(count, 6 * page_size);
+
+	/* Now make sure the poisoning was applied. */
+
+	ASSERT_FALSE(try_read_write_buf(ptr1));
+	ASSERT_FALSE(try_read_write_buf(&ptr1[9 * page_size]));
+
+	ASSERT_FALSE(try_read_write_buf(ptr2));
+	ASSERT_FALSE(try_read_write_buf(&ptr2[4 * page_size]));
+
+	ASSERT_FALSE(try_read_write_buf(ptr3));
+	ASSERT_FALSE(try_read_write_buf(&ptr3[19 * page_size]));
+
+	/* Now do the same with unpoison... */
+	count = process_madvise(pidfd, vec, 6, MADV_GUARD_UNPOISON, 0);
+
+	/* ...and everything should now succeed. */
+
+	ASSERT_TRUE(try_read_write_buf(ptr1));
+	ASSERT_TRUE(try_read_write_buf(&ptr1[9 * page_size]));
+
+	ASSERT_TRUE(try_read_write_buf(ptr2));
+	ASSERT_TRUE(try_read_write_buf(&ptr2[4 * page_size]));
+
+	ASSERT_TRUE(try_read_write_buf(ptr3));
+	ASSERT_TRUE(try_read_write_buf(&ptr3[19 * page_size]));
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr1, 10 * page_size), 0);
+	ASSERT_EQ(munmap(ptr2, 5 * page_size), 0);
+	ASSERT_EQ(munmap(ptr3, 20 * page_size), 0);
+	close(pidfd);
+}
+
+/* Assert that unmapping ranges does not leave poison behind. */
+TEST_F(guard_pages, munmap)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr, *ptr_new1, *ptr_new2;
+
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison first and last pages. */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
+	ASSERT_EQ(madvise(&ptr[9 * page_size], page_size, MADV_GUARD_POISON), 0);
+
+	/* Assert that they are poisoned. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[9 * page_size]));
+
+	/* Unmap them. */
+	ASSERT_EQ(munmap(ptr, page_size), 0);
+	ASSERT_EQ(munmap(&ptr[9 * page_size], page_size), 0);
+
+	/* Map over them.*/
+	ptr_new1 = mmap(ptr, page_size, PROT_READ | PROT_WRITE,
+			MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_new1, MAP_FAILED);
+	ptr_new2 = mmap(&ptr[9 * page_size], page_size, PROT_READ | PROT_WRITE,
+			MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_new2, MAP_FAILED);
+
+	/* Assert that they are now not poisoned. */
+	ASSERT_TRUE(try_read_write_buf(ptr_new1));
+	ASSERT_TRUE(try_read_write_buf(ptr_new2));
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Assert that mprotect() operations have no bearing on guard poison markers. */
+TEST_F(guard_pages, mprotect)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison the middle of the range. */
+	ASSERT_EQ(madvise(&ptr[5 * page_size], 2 * page_size,
+			  MADV_GUARD_POISON), 0);
+
+	/* Assert that it is indeed poisoned. */
+	ASSERT_FALSE(try_read_write_buf(&ptr[5 * page_size]));
+	ASSERT_FALSE(try_read_write_buf(&ptr[6 * page_size]));
+
+	/* Now make these pages read-only. */
+	ASSERT_EQ(mprotect(&ptr[5 * page_size], 2 * page_size, PROT_READ), 0);
+
+	/* Make sure the range is still poisoned. */
+	ASSERT_FALSE(try_read_buf(&ptr[5 * page_size]));
+	ASSERT_FALSE(try_read_buf(&ptr[6 * page_size]));
+
+	/* Make sure we can poison again without issue.*/
+	ASSERT_EQ(madvise(&ptr[5 * page_size], 2 * page_size,
+			  MADV_GUARD_POISON), 0);
+
+	/* Make sure the range is, yet again, still poisoned. */
+	ASSERT_FALSE(try_read_buf(&ptr[5 * page_size]));
+	ASSERT_FALSE(try_read_buf(&ptr[6 * page_size]));
+
+	/* Now unpoison the whole range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_UNPOISON), 0);
+
+	/* Make sure the whole range is readable. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_TRUE(try_read_buf(&ptr[i * page_size]));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Split and merge VMAs and make sure guard pages still behave. */
+TEST_F(guard_pages, split_merge)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr, *ptr_new;
+	int i;
+
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison the whole range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure the whole range is poisoned. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Now unmap some pages in the range so we split. */
+	ASSERT_EQ(munmap(&ptr[2 * page_size], page_size), 0);
+	ASSERT_EQ(munmap(&ptr[5 * page_size], page_size), 0);
+	ASSERT_EQ(munmap(&ptr[8 * page_size], page_size), 0);
+
+	/* Make sure the remaining ranges are poisoned post-split. */
+	for (i = 0; i < 2; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+	for (i = 2; i < 5; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+	for (i = 6; i < 8; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+	for (i = 9; i < 10; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Now map them again - the unmap will have cleared the poison. */
+	ptr_new = mmap(&ptr[2 * page_size], page_size, PROT_READ | PROT_WRITE,
+		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_new, MAP_FAILED);
+	ptr_new = mmap(&ptr[5 * page_size], page_size, PROT_READ | PROT_WRITE,
+		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_new, MAP_FAILED);
+	ptr_new = mmap(&ptr[8 * page_size], page_size, PROT_READ | PROT_WRITE,
+		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_new, MAP_FAILED);
+
+	/* Now make sure poisoning is as expected. */
+	for (i = 0; i < 10; i++) {
+		bool result = try_read_write_buf(&ptr[i * page_size]);
+
+		if (i == 2 || i == 5 || i == 8) {
+			ASSERT_TRUE(result);
+		} else {
+			ASSERT_FALSE(result);
+		}
+	}
+
+	/* Now poison everything again. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure the whole range is poisoned. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Now split the range into three. */
+	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ), 0);
+	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size, PROT_READ), 0);
+
+	/* Make sure the whole range is poisoned for read. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_FALSE(try_read_buf(&ptr[i * page_size]));
+	}
+
+	/* Now reset protection bits so we merge the whole thing. */
+	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ | PROT_WRITE), 0);
+	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size,
+			   PROT_READ | PROT_WRITE), 0);
+
+	/* Make sure the whole range is still poisoned. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Split range into 3 again... */
+	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ), 0);
+	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size, PROT_READ), 0);
+
+	/* ...and unpoison the whole range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_UNPOISON), 0);
+
+	/* Make sure the whole range is remedied for read. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_TRUE(try_read_buf(&ptr[i * page_size]));
+	}
+
+	/* Merge them again. */
+	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ | PROT_WRITE), 0);
+	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size,
+			   PROT_READ | PROT_WRITE), 0);
+
+	/* Now ensure the merged range is remedied for read/write. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Assert that MADV_DONTNEED does not remove guard poison markers. */
+TEST_F(guard_pages, dontneed)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Back the whole range. */
+	for (i = 0; i < 10; i++) {
+		ptr[i * page_size] = 'y';
+	}
+
+	/* Poison every other page. */
+	for (i = 0; i < 10; i += 2) {
+		ASSERT_EQ(madvise(&ptr[i * page_size],
+				  page_size, MADV_GUARD_POISON), 0);
+	}
+
+	/* Indicate that we don't need any of the range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_DONTNEED), 0);
+
+	/* Check to ensure poison markers are still in place. */
+	for (i = 0; i < 10; i++) {
+		bool result = try_read_buf(&ptr[i * page_size]);
+
+		if (i % 2 == 0) {
+			ASSERT_FALSE(result);
+		} else {
+			ASSERT_TRUE(result);
+			/* Make sure we really did get reset to zero page. */
+			ASSERT_EQ(ptr[i * page_size], '\0');
+		}
+
+		/* Now write... */
+		result = try_write_buf(&ptr[i * page_size]);
+
+		/* ...and make sure same result. */
+		if (i % 2 == 0) {
+			ASSERT_FALSE(result);
+		} else {
+			ASSERT_TRUE(result);
+		}
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Assert that mlock()'ed pages work correctly with poison markers. */
+TEST_F(guard_pages, mlock)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Populate. */
+	for (i = 0; i < 10; i++) {
+		ptr[i * page_size] = 'y';
+	}
+
+	/* Lock. */
+	ASSERT_EQ(mlock(ptr, 10 * page_size), 0);
+
+	/* Now try to poison, should fail with EINVAL. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	/* OK unlock. */
+	ASSERT_EQ(munlock(ptr, 10 * page_size), 0);
+
+	/* Poison first half of range, should now succeed. */
+	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure poison works. */
+	for (i = 0; i < 10; i++) {
+		bool result = try_read_write_buf(&ptr[i * page_size]);
+
+		if (i < 5) {
+			ASSERT_FALSE(result);
+		} else {
+			ASSERT_TRUE(result);
+			ASSERT_EQ(ptr[i * page_size], 'x');
+		}
+	}
+
+	/*
+	 * Now lock the latter part of the range. We can't lock the poisoned
+	 * pages, as this would result in the pages being populated and the
+	 * poisoning would cause this to error out.
+	 */
+	ASSERT_EQ(mlock(&ptr[5 * page_size], 5 * page_size), 0);
+
+	/*
+	 * Now unpoison, we do not permit mlock()'d ranges to be remedied as it is
+	 * a non-destructive operation.
+	 */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_UNPOISON), 0);
+
+	/* Now check that everything is remedied. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/*
+ * Assert that moving, extending and shrinking memory via mremap() retains
+ * poison markers where possible.
+ *
+ * - Moving a mapping alone should retain markers as they are.
+ */
+TEST_F(guard_pages, mremap_move)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr, *ptr_new;
+
+	/* Map 5 pages. */
+	ptr = mmap(NULL, 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Place poison markers at both ends of the 5 page span. */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
+	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure the poison is in effect. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
+
+	/* Map a new region we will move this range into. Doing this ensures
+	 * that we have reserved a range to map into.
+	 */
+	ptr_new = mmap(NULL, 5 * page_size, PROT_NONE, MAP_ANON | MAP_PRIVATE,
+		       -1, 0);
+	ASSERT_NE(ptr_new, MAP_FAILED);
+
+	ASSERT_EQ(mremap(ptr, 5 * page_size, 5 * page_size,
+			 MREMAP_MAYMOVE | MREMAP_FIXED, ptr_new), ptr_new);
+
+	/* Make sure the poison is retained. */
+	ASSERT_FALSE(try_read_write_buf(ptr_new));
+	ASSERT_FALSE(try_read_write_buf(&ptr_new[4 * page_size]));
+
+	/*
+	 * Clean up - we only need reference the new pointer as we overwrote the
+	 * PROT_NONE range and moved the existing one.
+	 */
+	munmap(ptr_new, 5 * page_size);
+}
+
+/*
+ * Assert that moving, extending and shrinking memory via mremap() retains
+ * poison markers where possible.
+ *
+ * - Expanding should retain, only now in different position. The user will have
+ *   to unpoison manually to fix up (they'd have to do the same if it were a
+ *   PROT_NONE mapping)
+ */
+TEST_F(guard_pages, mremap_expand)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr, *ptr_new;
+
+	/* Map 10 pages... */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	/* ...But unmap the last 5 so we can ensure we can expand into them. */
+	ASSERT_EQ(munmap(&ptr[5 * page_size], 5 * page_size), 0);
+
+	/* Place poison markers at both ends of the 5 page span. */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
+	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure the poison is in effect. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
+
+	/* Now expand to 10 pages. */
+	ptr = mremap(ptr, 5 * page_size, 10 * page_size, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Make sure the poison is retained in its original positions. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
+
+	/* Reserve a region which we can move to and expand into. */
+	ptr_new = mmap(NULL, 20 * page_size, PROT_NONE,
+		       MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr_new, MAP_FAILED);
+
+	/* Now move and expand into it. */
+	ptr = mremap(ptr, 10 * page_size, 20 * page_size,
+		     MREMAP_MAYMOVE | MREMAP_FIXED, ptr_new);
+	ASSERT_EQ(ptr, ptr_new);
+
+	/* Again, make sure the poison is retained in its original
+	 * positions. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
+
+	/*
+	 * A real user would have to unpoison, but would reasonably expect all
+	 * characteristics of the mapping to be retained, including poison
+	 * markers.
+	 */
+
+	/* Cleanup. */
+	munmap(ptr, 20 * page_size);
+}
+/*
+ * Assert that moving, extending and shrinking memory via mremap() retains
+ * poison markers where possible.
+ *
+ * - Shrinking will result in markers that are shrunk over being removed. Again,
+ *   if the user were using a PROT_NONE mapping they'd have to manually fix this
+ *   up also so this is OK.
+ */
+TEST_F(guard_pages, mremap_shrink)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	/* Map 5 pages. */
+	ptr = mmap(NULL, 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Place poison markers at both ends of the 5 page span. */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
+	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_POISON), 0);
+
+	/* Make sure the poison is in effect. */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
+
+	/* Now shrink to 3 pages. */
+	ptr = mremap(ptr, 5 * page_size, 3 * page_size, MREMAP_MAYMOVE);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* We expect the poison marker at the start to be retained... */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+
+	/* ...But remaining pages will not have poison markers. */
+	for (i = 1; i < 3; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr[i + page_size]));
+	}
+
+	/*
+	 * As with expansion, a real user would have to unpoison and fixup. But
+	 * you'd have to do similar manual things with PROT_NONE mappings too.
+	 */
+
+	/*
+	 * If we expand back to the original size, the end marker will, of
+	 * course, no longer be present.
+	 */
+	ptr = mremap(ptr, 3 * page_size, 5 * page_size, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Again, we expect the poison marker at the start to be retained... */
+	ASSERT_FALSE(try_read_write_buf(ptr));
+
+	/* ...But remaining pages will not have poison markers. */
+	for (i = 1; i < 5; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr[i + page_size]));
+	}
+
+	/* Cleanup. */
+	munmap(ptr, 5 * page_size);
+}
+
+/*
+ * Assert that forking a process with VMAs that do not have VM_WIPEONFORK set
+ * retain guard pages.
+ */
+TEST_F(guard_pages, fork)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	pid_t pid;
+	int i;
+
+	/* Map 10 pages. */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison the first 5 pages. */
+	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_POISON), 0);
+
+	pid = fork();
+	ASSERT_NE(pid, -1);
+	if (!pid) {
+		/* This is the child process now. */
+
+		/* Assert that the poisoning is in effect. */
+		for (i = 0; i < 10; i++) {
+			bool result = try_read_write_buf(&ptr[i * page_size]);
+
+			if (i < 5) {
+				ASSERT_FALSE(result);
+			} else {
+				ASSERT_TRUE(result);
+			}
+		}
+
+		/* Now unpoison the range.*/
+		ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_UNPOISON), 0);
+
+		exit(0);
+	}
+
+	/* Parent process. */
+
+	/* Parent simply waits on child. */
+	waitpid(pid, NULL, 0);
+
+	/* Child unpoison does not impact parent page table state. */
+	for (i = 0; i < 10; i++) {
+		bool result = try_read_write_buf(&ptr[i * page_size]);
+
+		if (i < 5) {
+			ASSERT_FALSE(result);
+		} else {
+			ASSERT_TRUE(result);
+		}
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/*
+ * Assert that forking a process with VMAs that do have VM_WIPEONFORK set
+ * behave as expected.
+ */
+TEST_F(guard_pages, fork_wipeonfork)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	pid_t pid;
+	int i;
+
+	/* Map 10 pages. */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Mark wipe on fork. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_WIPEONFORK), 0);
+
+	/* Poison the first 5 pages. */
+	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_POISON), 0);
+
+	pid = fork();
+	ASSERT_NE(pid, -1);
+	if (!pid) {
+		/* This is the child process now. */
+
+		/* Poison will have been wiped. */
+		for (i = 0; i < 10; i++) {
+			ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
+		}
+
+		exit(0);
+	}
+
+	/* Parent process. */
+
+	waitpid(pid, NULL, 0);
+
+	/* Poison should be in effect.*/
+	for (i = 0; i < 10; i++) {
+		bool result = try_read_write_buf(&ptr[i * page_size]);
+
+		if (i < 5) {
+			ASSERT_FALSE(result);
+		} else {
+			ASSERT_TRUE(result);
+		}
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Ensure that MADV_FREE frees poison entries as expected. */
+TEST_F(guard_pages, lazyfree)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	/* Map 10 pages. */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Ensure poisoned. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Lazyfree range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_FREE), 0);
+
+	/* This should simply clear the poison markers. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Ensure that MADV_POPULATE_READ, MADV_POPULATE_WRITE behave as expected. */
+TEST_F(guard_pages, populate)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+
+	/* Map 10 pages. */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Populate read should error out... */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_POPULATE_READ), -1);
+	ASSERT_EQ(errno, EFAULT);
+
+	/* ...as should populate write. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_POPULATE_WRITE), -1);
+	ASSERT_EQ(errno, EFAULT);
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Ensure that MADV_COLD, MADV_PAGEOUT do not remove poison markers. */
+TEST_F(guard_pages, cold_pageout)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	/* Map 10 pages. */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Poison range. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
+
+	/* Ensured poisoned. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Now mark cold. This should have no impact on poison markers. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_COLD), 0);
+
+	/* Should remain poisoned. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* OK, now page out. This should equally, have no effect on markers. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_PAGEOUT), 0);
+
+	/* Should remain poisoned. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/* Ensure that guard pages do not break userfaultd. */
+TEST_F(guard_pages, uffd)
+{
+	const unsigned long page_size = self->page_size;
+	int uffd;
+	char *ptr;
+	int i;
+	struct uffdio_api api = {
+		.api = UFFD_API,
+		.features = 0,
+	};
+	struct uffdio_register reg;
+	struct uffdio_range range;
+
+	/* Set up uffd. */
+	uffd = userfaultfd(0);
+	if (uffd == -1 && errno == EPERM)
+		ksft_exit_skip("No uffd permissions\n");
+	ASSERT_NE(uffd, -1);
+
+	ASSERT_EQ(ioctl(uffd, UFFDIO_API, &api), 0);
+
+	/* Map 10 pages. */
+	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Register the range with uffd. */
+	range.start = (unsigned long)ptr;
+	range.len = 10 * page_size;
+	reg.range = range;
+	reg.mode = UFFDIO_REGISTER_MODE_MISSING;
+	ASSERT_EQ(ioctl(uffd, UFFDIO_REGISTER, &reg), 0);
+
+	/* Poison the range. This should not trigger the uffd. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
+
+	/* The poisoning should behave as usual with no uffd intervention. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
+	}
+
+	/* Cleanup. */
+	ASSERT_EQ(ioctl(uffd, UFFDIO_UNREGISTER, &range), 0);
+	close(uffd);
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.46.2


