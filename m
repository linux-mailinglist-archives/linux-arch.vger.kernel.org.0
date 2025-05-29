Return-Path: <linux-arch+bounces-12144-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38974AC838E
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 23:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E716D4A6BAC
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 21:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B7D27A10A;
	Thu, 29 May 2025 21:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XJkS/q5N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hxGPzjSi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675401DEFE8;
	Thu, 29 May 2025 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748553904; cv=fail; b=nHWjkDryHhqCUDe8LxnCxQ++bhn8cWjdRZcQU55UlTaaPHZVuZ2BHIlG+IxXtCgUT7MJ/CCdya8C7hZoRO4tNrsUMNCaqEooS9cl7dMLmWOa7cGLXT1rfGtz9IduEwuzd+0hnhXF1xneA6q2Zzj1U8ZwSCOzC2ybxGYzgmJ8LLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748553904; c=relaxed/simple;
	bh=iC0ZOOjQqLYpQM57B6tnH+S+JNw+26wwyhxqol2MJ38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OmIdrEr6gAVSyZ1ZDatgFGuZrBcexHFOfyuEfr/sMTmScIbgRBWQczOIQXDGRlwUI6p0Lw0cpFMwnAtMWZ0MkwWeqQWMVd3Y9nIhgcUIiw0dtWh8tO7bq5jQbfY4SOm+K7G3jXmVBVKS48P31ixHefWELlWXCyCtUV8GBt3dVmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XJkS/q5N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hxGPzjSi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TLN6gi018872;
	Thu, 29 May 2025 21:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8YnYvHlYkkjNkp/K4p
	9v5KQfU5UhZWP4hCll9NsVoNA=; b=XJkS/q5N9EEkbmTtLzL8IWVEP3I/BPX5wA
	dwUc1UfaaDaMQaJqcHzVYHSYusG9LCuEjl4m9ic9ExWIM0omiAgsxRsQh3G1YabL
	axAfDmb+1zZHZgsaaDd/IRR1uE8sI7nmuKvC9S1nEn4+ngBAsZe3UgrfdAaS8l6Y
	rSmThSeYNl8+DA5Q5wA9AJ2jVA4GDe2See39H+zDm+rGLGjJjcsnsX1VXvtIbhzf
	1FKuJKGXhlyEEoznwWGpzryQLLRYJIW9YIn3aVCc9IxuxWHMywTqiuhNeEcK60ZC
	Up7dOeh8g4jnouUOaIiueBlegxg9Ggg4E3Syp1YKCqr9ac+64R3Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ym198n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 21:24:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54TLKOvI023062;
	Thu, 29 May 2025 21:24:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jc7q4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 21:24:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGZ6vvsmzgtfYqV/Losa6NRv3puFSpOaMdOHFMogAy0M3ijW9fHc3kaBTgBgze7gBDXjDAeIRDZTX3jjmQS6Y9RRAHB3nOoWaryjenyzYjLf/lCJMj+TQRvjtXSj1qWcsHSxTT4mrfFcAD5/gYbNeglyStdIEg5dIpH4iu+rajwFOK3wdDGx9JCj3eKbCx8quneN3JsFXXjnMJq+lznkU/I37+fQ9zDUS5RTSJTM1eIOGA755nJNwsRbCCoz//osSLlV+rahoZ3p43pqJi8yqhBlMQUhPDnLzXiiHcGJz6q5yerI8ZrhcpVZo3ly/WYtGSPZhzLof1xXxcYiJ/cW9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YnYvHlYkkjNkp/K4p9v5KQfU5UhZWP4hCll9NsVoNA=;
 b=zEhw6eKkEFP/Umn/c9kPSr5D/JGfbU9TBCY94A1TlNag+0kNsePccYRuZfOZzqpquS8UrCR7BxQJQiSyM36+AGGXZL7oTBftdfOUshCJlo84sssgyK8AbbPYsrLfGhKis1oJ0M5sn/cguent1loOentqZdT7FWukEGHA8B4KsBP/1VASvXWU1RiC/N9+B1DhXci3BbDDoVBGEueafwNu5auqKPqfRBdN4S5LvtjpSykx45ZhhiQNucOp1BpzbVC4ZmHXD/DJHIg5KZyFeEThLxHY5jgfng+5SyAGz9qThsMWSOS/ZHcFxkYv5YKBtsOTfQiGfUYDgQ74X1fBp5Au1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YnYvHlYkkjNkp/K4p9v5KQfU5UhZWP4hCll9NsVoNA=;
 b=hxGPzjSiJtY3l6KCEL3cyPy3Ta7ANsaz7OcuYFg8sJwcQlJ8mf8blgy2gJ814kSJ/stXpIrpQqmhES3zPfscEbBWE6T9FdPqfb9RIAF6GNlJo8daSt6dmAFFpXAkzCPr/PSQ4c0gw/4pAIyz5A4lbGL3IcOzFaX4Vh35Y05jjYQ=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB5545.namprd10.prod.outlook.com (2603:10b6:510:4b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Thu, 29 May
 2025 21:24:28 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8746.035; Thu, 29 May 2025
 21:24:28 +0000
Date: Thu, 29 May 2025 17:24:23 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, SeongJae Park <sj@kernel.org>,
        Usama Arif <usamaarif642@gmail.com>, Mike Rapoport <rppt@kernel.org>,
        Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [DISCUSSION] proposed mctl() API
Message-ID: <klrw3rjymes6phs5erz7eqkjji5oe3bg4j4jbqpjv3qzuw4vra@k6ei5pssfany>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, SeongJae Park <sj@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>, Mike Rapoport <rppt@kernel.org>, Barry Song <21cnbao@gmail.com>, 
	linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <aDh9LtSLCiTLjg2X@casper.infradead.org>
 <20250529211423.GA1271329@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529211423.GA1271329@cmpxchg.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YQBPR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::30) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB5545:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f01c6a0-a844-4933-f7dd-08dd9ef7316a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?flwnE80Db4nxYJwScDZ6bdM9p0yesjZkpbbvSiSnd/6LAcBrXWhWCjjq8G6x?=
 =?us-ascii?Q?310Br5JUw9aWMvQgr4QQ+KZ1UA0tNxUn9E91fq7KJIb5PJBS8uuEWFdhc1sF?=
 =?us-ascii?Q?5DustHQWJIHxN4YbTsq7A0mwjDaGcI9fq1MzloppxL6WkIJDY0yjt2S1m9o0?=
 =?us-ascii?Q?WhXIEb3i26SkIh+PD2O5ZV/vvLY6bwF/rHYihdpVfSeVFfqKLAOkZzixz2EV?=
 =?us-ascii?Q?nqaeoptdFkMJ+PNCVG0YbsZ2yOKk1RpylrFNJkifqSkNcVBP3ELM/iW8lt1c?=
 =?us-ascii?Q?RYO829vMtJzg0zOtjKb+Sen33vRR9pTfheL5djhal/3n7UKtbDMuuA/wEH/m?=
 =?us-ascii?Q?fMSPCicLmCwMHRFvn0hEwJ1lnUkdmRN/iNkM9OrSOgAMyBv97+W8683oLcHQ?=
 =?us-ascii?Q?47HCj0qSarGZfQxlzyMhFkhm2Olg75s+lsZuPWfjOT84YcXpEymxt/ZZdOSH?=
 =?us-ascii?Q?WBKeJuIm4kBs6xIAtEFyDMwqp4hyy+JL5CZeRegK9yUCmh87RNpvSzv5/WPf?=
 =?us-ascii?Q?Z2AfJCyXDhJiKYLGO2jjl7cmRRIABgAm35m+2xe2ybZwFsBUgjSftgLQzIkw?=
 =?us-ascii?Q?cs2p7OTxCrJGh44ZCtpQ6kmg1sArRt9nlVN75rJAXP7D5jmq9papwPJn1yrf?=
 =?us-ascii?Q?jqhM4EtOIXWxNNroh7PJRJCpUSmDMKjBmQcm4JiFwz0ukQdQUj/MoV1ozVZQ?=
 =?us-ascii?Q?iCHI2bXDqn9tD3I3kE1TPnmnenLNjOkonJIV4/hedewBYYzOLVeifZVlbu/Y?=
 =?us-ascii?Q?stGOVqpJwVg+pxNXhOr36Unf54fjWytmv/CbncsxyEeE9Pf/qmHzWvbWZMeF?=
 =?us-ascii?Q?nc31IMq5sG+a7xuFruqL/O3jONR+4qW2ZjNv+pdfeVYWJhHTgGr/Gf2h3taA?=
 =?us-ascii?Q?73FuULh3N9g4LxbMdLIUbo86LuRdm/hiKK4eyr4z1WyUgp3D6tF+1srFepMr?=
 =?us-ascii?Q?llV+AbMWeGYrLStK6hzyeFplPi/3cMEFIr0+18r+WW2fdwUn88wUv+cwpcQ4?=
 =?us-ascii?Q?J+Ui8KZvmpFZ7SRdhSsWCbCJTIW4rTuiYKoyZdZb9z3R22u+IQYtNOdMUJGb?=
 =?us-ascii?Q?KxQRmuGH4EDaNI2W+xH+hs32K7NopTv23uBRCMZ6T3CieTd+1mJbRx64Cvug?=
 =?us-ascii?Q?1GotR8V7Qn7zheLTs8ELPKuA/VROrYAH5uPWQmsPovMuzxFEe+hFc0Vd4P6W?=
 =?us-ascii?Q?ZNdNgoG+tx/OdrIIDHDhzmNulBt2Hs9Ap/J3VAhPxcJQ1lUHIRz6/+TMNTpZ?=
 =?us-ascii?Q?p+jTNVErXkERdaWo8aZyXeTbKlFGhvq6O7lBIMS8YumisE0QLd8SU0z9auBS?=
 =?us-ascii?Q?kq+bw2pXKPQvAZg6Vwn9UB0ZygdlOlZ6Q1ZovcBVVNL22x98L5YuVW+WVI6A?=
 =?us-ascii?Q?SsWtGNfDgBW41Y2OTZIYkAXl5QHx8fsBbC4O5xOzhQqO+nqgvPPYF5mX8Z92?=
 =?us-ascii?Q?oof/cchX+Co=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hMSXmJ+BJkBH7+yASe1YQJwHBdCR+h+cndIm1gy0LYHRNY9cgGfeV3heLMSl?=
 =?us-ascii?Q?1bHQYBLf7kOq9wKcBImkVJKnVHlKcHh3pnpbUolE158ZGYW/fCMjZoYHNhP6?=
 =?us-ascii?Q?hhG6X3ETkO5ZQCXxWaEyyoCXhcZpKGvEVAEdwWDh5ELbajQJPi29UG/9mw5r?=
 =?us-ascii?Q?JJ1UThDOXMf0n2U8FuE3oLYbhqOk34GSvu+jLFV+ikviiw3A5yvL5cEpwKwB?=
 =?us-ascii?Q?ui4fa0wMZStby2D2tPw7gpuuy4HPlPKL5rUv/6tTwx6gFCxRsmxMMA726AKD?=
 =?us-ascii?Q?mdoHEpHUp0xWuG0ztYA25++7SrFLwEkqq7BZFFGUcNEZzis+M3Hrf6UyZOpP?=
 =?us-ascii?Q?fw9NMQbm8Pl+cskVxJFrQTigxI3+YlacvEoZ3+fogG0R6l/1T8ma+tMoShC5?=
 =?us-ascii?Q?hXrdG4uCd5SP5DvpZG5tvrJYlrFAgsCgS5fQhXuRkP4O0Kent7nOxP0yzexx?=
 =?us-ascii?Q?yf5/0MlUI4fVck3MII+zT0FE+6+mIWq8fw+yY0FJrrr6UXs2GC+wzTD2C8Q/?=
 =?us-ascii?Q?SI6PNoVDLhL31uRP1UZVP6Qxy4ftqyBeiOgz/BHO5/P+EAv2gPDkOsI/dYIy?=
 =?us-ascii?Q?96EkT4zYF0QilZJTLriXJNBuM2n3XBcr7+dSUDY/I6nWfkO41UZHcVgYSiTY?=
 =?us-ascii?Q?OL2uNBlfBU7Ucsedm7qy33Ack3KS/0GrJ7DqWqYktXBEf0gUQeymAz9TdfVN?=
 =?us-ascii?Q?j8RM4XcsvtgvJIUlhi4Oppp5wX9pCcD67cljuA9bMD+ZWBAZOmKyhZygDWLa?=
 =?us-ascii?Q?t+WLQG83oadJyXQPr1dciSg3UA1gt424WLQBGLev6JdqmXGiiInmnouZNfAD?=
 =?us-ascii?Q?JwysAumenEpQD2zCBCBILTuIcNd2x5UibmOVlcogxRFTHRbRJXjsjq/e0Uek?=
 =?us-ascii?Q?y83PqKr83yWEyzis2taUCK104f2JPylCkxYu7CoPKrcFxrNk7aKCV114o8q1?=
 =?us-ascii?Q?ACA2WOjk5YXEBAKXXTlonlCYNOn0//NY7AA3mGduN6uMiRFg4BftzPZSTT/E?=
 =?us-ascii?Q?K3FYvCDIR8tO2qfkNsGJYVZihGEaKmx8ycerRFTFt6VeZTi9cYUx39rFrZ3e?=
 =?us-ascii?Q?Vfl+2Z8KdRZLpBxULOS+i9gSvFU0oYOTV9Nt0lYXOL15iD5CedMRQIgjGeaX?=
 =?us-ascii?Q?je1wK/IcPn8jY3EeI1tXc4ajflA+H3rLsUP8asFwnpqXWqNawFJ/FaTSw91R?=
 =?us-ascii?Q?9u+XtDGjtOdYYY6gaY9TIvn4PJ0HfcLjzCIPIfytlXAp56oeZHG043oqs5NX?=
 =?us-ascii?Q?R8fNLNjG3rnZ01FKC+/zIVqjQXuUcZFHHsiU2+zc9Xr87cwWwFjFoNVkUbVC?=
 =?us-ascii?Q?lSNkqQhjts+kK1a6IHNlM26P3pqzURhQCDhh18KA+4oFFJRj0whg2MRZ1u/G?=
 =?us-ascii?Q?lcKukINca9yOHS9la7v59RMWafOhUUIcD/R8ccka2tbl80Rk/r8Cm4nuLKWg?=
 =?us-ascii?Q?WeEESTj8eXeu/k+td7wZrAqqugLOxkxsNwfJvZHEDtG5e20ne7L90Kjm1YLP?=
 =?us-ascii?Q?zunGTJmlRcj/jPm1bajaLLcLHWG3U1ZekmQistg1hZYYmlm7iZ0A+NZ4ONhj?=
 =?us-ascii?Q?ZiS4lNenO/a3d9v3d5dzLUJLPQw/+HyVhoDz5STf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6cwjlv6BdbpjUGAHMD+N5tq9c8XVlknesQ3SHs4oRgMmhkUI22tIz8BLUFzOLRbkX6mtvqyTxVYABCImx5Vg/un6RPQrDWeWEc4hJwX9EoULLjrSyKqP//lmX72iH+O5/0HtzmxWkBqN9EhRg9KKnqLSGSSgYrTGpAuMkmanhEuJaCE6pQzs/89BO5dwNOZi9BqL9qs2zev8DXGkLIMpK1qTuxUlxR+t79eUAuSVEM95HGTqtDb6dRn7fCaDoGAnDRhlTaLSrHcKoi6CTtmlFduXKt5vzhOjzfDtsnqQK/AAsiK9kltmLDINUAqTp4qnEQmh1kCWzAfFxicwZZ53YvmpeVLUfUBADT3GJUoDEv82+VUYSgzj+zsGVGwmxghtp/1qA7W216mVtT0rRCfE9C6UOGLQo/U+XN0R7sz5+pAgXMIFJ5NuQ7/EeMdpViGunvx3zHGJ+9QtUyMcCzEVn4CGXojneQggiXTNI+Zqr+RNjNBodR4J6Jh3IAUB16/XR2eHyKXEROmq/WMiTF/+6fxHw+WvK1bYBKhzTM86nKyz9fCqnnIzN34vfpu0KlkfCEp1qy9N12OHql5mrWVgLP4hsNcvov2YxHRpBYIs+PU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f01c6a0-a844-4933-f7dd-08dd9ef7316a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 21:24:28.1238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUafDnIOF6pLygHvJ+gR8+09xIel8F9h7seObf6af3k/V0pS2F8QkDZnOdF0YwEiovErGJ3/5HYORkT0JnREHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290209
X-Proofpoint-GUID: 8Co8IQmzMGXxhwnt2P1ol4M5YimcX6vs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDIwOSBTYWx0ZWRfX6Ni7QoiTXLkS +kISlQOzYZ3uGv5fcIlHp0W9SQDfsghss9MZdt/DYdnBVnakybAHrBwuw74JlAMIbnIrN/mmsPl qqiKMnFkRsaaocaG/F1sTco9qM279JMu1dFkhv3Zw3puxwhy4vNzB7DEaIxiHX28bNb/umFx8vQ
 IjDxAVazix4/GGVMxTT1c97U0HKkE/TUSue/A5nbgXVzEhoUS0gMaRdJWE1blWKEONOu/s/wEpJ ZJdXht/XoL0TvuIYJgOsJM2RYhvumW5SXsdMXfKI7JZFTr7Dc8nqgxmsA756poUoKuY49BBj+vi zaQgLUBVeTmd28qRzeteKYA9XSlPB1CjuXAGlfK4nkhvT8290PSDRX1+pQCopmAZiTB6M8z0F1V
 pcBorclkUkXD3aIXV610rPA5cHtldGz/hJiJDIUDm3GXc+9ka6A7/Gw8uiLPbX7hSACsm+Hz
X-Proofpoint-ORIG-GUID: 8Co8IQmzMGXxhwnt2P1ol4M5YimcX6vs
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=6838d090 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=ufHFDILaAAAA:8 a=UxKnjRbc-qq4Z7Ko0EQA:9 a=CjuIK1q_8ugA:10 a=ZmIg1sZ3JBWsdXgziEIF:22 cc=ntf awl=host:14714

* Johannes Weiner <hannes@cmpxchg.org> [250529 17:14]:
> On Thu, May 29, 2025 at 04:28:46PM +0100, Matthew Wilcox wrote:
> > Barry's problem is that we're all nervous about possibly regressing
> > performance on some unknown workloads.  Just try Barry's proposal, see
> > if anyone actually compains or if we're just afraid of our own shadows.
> 
> I actually explained why I think this is a terrible idea. But okay, I
> tried the patch anyway.
> 
> This is 'git log' on a hot kernel repo after a large IO stream:

Can you clarify this benchmark please?

Is this running 'git log', then stream IO, then running 'git log' again?

> 
>                                      VANILLA                      BARRY
> Real time                 49.93 (    +0.00%)         60.36 (   +20.48%)
> User time                 32.10 (    +0.00%)         32.09 (    -0.04%)
> System time               14.41 (    +0.00%)         14.64 (    +1.50%)
> pgmajfault              9227.00 (    +0.00%)      18390.00 (   +99.30%)
> workingset_refault_file  184.00 (    +0.00%)    236899.00 (+127954.05%)
> 
> Clearly we can't generally ignore page cache hits just because the
> mmaps() are intermittent.
> 
> The whole point is to cache across processes and their various
> apertures into a common, long-lived filesystem space.
> 
> Barry knows something about the relationship between certain processes
> and certain files that he could exploit with MADV_COLD-on-exit
> semantics. But that's not something the kernel can safely assume. Not
> without defeating the page cache for an entire class of file accesses.

