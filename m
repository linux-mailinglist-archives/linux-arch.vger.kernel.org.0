Return-Path: <linux-arch+bounces-12010-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CFCABD472
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 12:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2016B7B2D17
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76B269D0B;
	Tue, 20 May 2025 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E486nAak";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zmAH/KE3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02CF269816;
	Tue, 20 May 2025 10:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747736516; cv=fail; b=gIsxTmiIkfBl/SQylJzd+0Q6YFMRZDNG0XqvYB1YRMqQph80NVDWdN24uaQS+20fEdkmSz7M2o+cSC+j8b432jIZobG2PPatcZI3NzsCSOKo/kDmTUoBl7T5POiF8RIbgUjN3a4PG2MAIwrPW93y4ygHGAH9dK6gNIqCTbxIqSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747736516; c=relaxed/simple;
	bh=I1lCsq34Wq52nnRDyFXJ4p2kT0x+7XkK1w4kI7N+7Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ehlvkruu6T4w8rE7y27a25xaXTXdQ9O7Xps/6s2UmGrW9ecCnDdmOzQuz2PENuAI755UbjRPajh0qx+UqwjFELr7eg+FqMgxprxjdea96lPdJwBz/m6GJsfNQUVg26DEi1PWiusAjIcdluyk1S40k73GrkF0GLf/C/YsIgeML2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E486nAak; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zmAH/KE3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K9MuJC011163;
	Tue, 20 May 2025 10:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=yAU7TNv2ZXTTEGU1vb
	F+QuSAmE6tc8qfbVu+wHZkm2s=; b=E486nAakQenHlYmiJ482wx2Cpx61YG/9ht
	Plbx6N1zC2XDHFqTCn2n2odo5iyDCQPsyk0I55dc9eFEnZfIU7Ya8xwxEf68D89Y
	yr0lxVHHfYJv8sKpbMcub7nAaCO0Pv0oWabkFgf76qB8yC2AESwkkWmhUIb48ZDk
	b8UdqUMyd4eOs+6tRwiMkGOlYH+B+n0FjHgzR5bMXsUH2U52rkmKDuzqdlfQYtxg
	4dXfCxSX8igAOe98eD4TP6XypAqFjbV4TI8wHpBDJdL64LrDXshr9spgSGHA74jA
	m6xuTBrS8TDL49TB7s7R44F4ptzZjyLG8U8iALikUnw0IDTOl7Fw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rdcegxpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 10:21:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KAIpUI000805;
	Tue, 20 May 2025 10:21:38 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012035.outbound.protection.outlook.com [40.93.6.35])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7u1rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 10:21:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2aW0N/HdpMZJjOKNIGYSGK2Lbbyh8A2wmpANX7jDmpAnWtTj0d5KdaPRu3IBJIKfDL0ZDWV46mAh+oXJyCbnDnkkmAoYIqDdsm/vl8bEaburnZRuXXcOXBwEsu43R1rFXelIWrxS8I1BLKjczc7v/eJGb7+JoCxfJm2qhTbznvIGbKqkOBoKNVLdNBnPK76q6XpCB9GPzuxMyea3YGcn9+92W+2p05yZ2rNBpljfEfnA90P++Lw3+//Jo8EtMhfxxdKeKN/KHL7nJZ1DEq143K8PArCNS4p2AVQ2JAR7SF2plIantswu3KikBwuXwufx3/QQqr/R00V34pqnpUyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAU7TNv2ZXTTEGU1vbF+QuSAmE6tc8qfbVu+wHZkm2s=;
 b=EE9wG+TLjSM+OxEqyEhNXkjZl1TlPD9unsQdRt5O1oOlZKyUyjQpnrJ1xjOsSkniECjLDDayREFrOh24ZQaow25nWnm0TksoaL2SgcwGiiGm33EpdksEdQq4S01f/bCpci4uWjWAKgPOonTH/hAY7qoHy4T4WCLoXZ6iRGi+qeyF8IVLsxJNAZzn8Nq3iwX6Rtjn1Wld5k+kYwfABbvc093CtsyKTY7eyRiH1y0vjR1RpTcjYx2G6mEnlQnkHxrjp5+OQBkubXquNPuIZkhPiQtUBF89za8IZvXkeGXY2jyXUC5FdYmA4Qs/xtk+/HNOON+e2O7HMjYGKndsK4c+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAU7TNv2ZXTTEGU1vbF+QuSAmE6tc8qfbVu+wHZkm2s=;
 b=zmAH/KE3+AQjvl+KIwaj7s+Mz/j2mKDdpbxtwIgi4yG1yINvlNr7y8SYj7IJCVkqFIhw+plryxmR5MstAXH0MdVBKR5uGusNqfQigk2EvNKfT7eD+qMrmtWj4aRI5lXPKvu7oHRRvpe9TdmqSMcwyBLNnPnbmUg2N1eVgDC1pAg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB4987.namprd10.prod.outlook.com (2603:10b6:610:c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 10:21:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 10:21:36 +0000
Date: Tue, 20 May 2025 11:21:33 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 4/5] mm/madvise: add PMADV_SET_FORK_EXEC_DEFAULT
 process_madvise() flag
Message-ID: <da1281bb-e49a-40f9-ac11-f976358e618e@lucifer.local>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <617413860ff194dfb1afedb175b2d84a457e449d.1747686021.git.lorenzo.stoakes@oracle.com>
 <czd62f2vzwv6fow4ikvzlkjdj5odhc3nhtc72onwip52baobg5@yc5pjiqoqnh4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <czd62f2vzwv6fow4ikvzlkjdj5odhc3nhtc72onwip52baobg5@yc5pjiqoqnh4>
X-ClientProxiedBy: LO2P265CA0121.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB4987:EE_
X-MS-Office365-Filtering-Correlation-Id: b5144b53-0e45-4438-557f-08dd978819b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A9omveN51zl+LWTA8Qa31yBGXLOikdCv7e2jxa2TkRx56u82NOcb6bBffdl9?=
 =?us-ascii?Q?ru95QoX6zm4vlQF19zJ220kh6JAdfONhTzDAEq7Q91aUsUoB7naz7KlhnQgQ?=
 =?us-ascii?Q?p6v6dW/QyRbGZbr9KY3S17hipYq6rE01cZVJGmBdSEjSHXgxY3w4LitKFzvk?=
 =?us-ascii?Q?GkGdbe5x9XOTy5DLsDD36wKxkeLyQTUO74F2zLrOJNXJg2kjNz3DFXdtsfMh?=
 =?us-ascii?Q?hvI3rYalspERzD/RT116vaLeBV0HeWXS4XRPI95E1LjBZY/ekSdiWe/4j6UU?=
 =?us-ascii?Q?2uFQ3BioCDZNhgoVOW4/lexsNpuiCUu6EL61GlFszvDkIaXwGezqliElmwbe?=
 =?us-ascii?Q?LOKhEKtDAwowvPNOdS7zSPZzm0dDH/Arl6VJFZihDfINo2FbQoxzvMe09ZQX?=
 =?us-ascii?Q?mWCVp+UVqFFMTZOUoI4+Bw72qoJi9tTSNtic8ok3uhgxZabGbL1kk7fhrw8/?=
 =?us-ascii?Q?KtjWngrDJT5UO9yLPl+1n4Hy/vVW/cjTY6uSjIBLYbvJcNoTMx2NY//+Wivf?=
 =?us-ascii?Q?NYInyKNkOPGRMHJ+6wcZininJggJkRjQIS/o1n3Mhr2UhJklyjfPCvj9RHyP?=
 =?us-ascii?Q?yHP36O8wUIY40TkFXxktAcc4kLAj+vlzx7MGxMUthxy3O0O04ZN24buY86yx?=
 =?us-ascii?Q?pJGR3ZOmZhDCPIDdkVvenMBL6sEoHJG5GzKr70bq1UXrvO8RFjGeE59tKtOb?=
 =?us-ascii?Q?uMLoh4TG71gJHvQre35dEEnLDv5kqcUlF1xf/YE/eFoyKIy9/1h5dXBOU1t/?=
 =?us-ascii?Q?7FJ/qDIYnuhoT7QFtPo1Mt/EsXutpVb3gAxxRHB3dtYHip3qbAK5Fc6vpOl2?=
 =?us-ascii?Q?S2lUShYC/CkcnYs72RIb+/WlgSghg+AUnjZMS/5+IPk1QZkrgBILvEyOjoXs?=
 =?us-ascii?Q?nGPrgWRsx5+cT2F68eT/sjmcSWHpynxjeJbZNPUpEXk8+InGG5vQID2gA085?=
 =?us-ascii?Q?ntP3R7c/v8wu2ynxUEB9wqH8uSfpQioqA763p5nojo+K/X1NJkdPq8urE1cP?=
 =?us-ascii?Q?gydF9iwtbkZgPYl7mNdbao1APlZA4/HY5OBVdP8vJ0LHDHwO0mZqBG2eQoRp?=
 =?us-ascii?Q?ggOh/ItmovSlhY8C2vWI5WCdgQELr/W5WTTXgCDxK+pM8rHirGF9S2w2pApH?=
 =?us-ascii?Q?PxQ/TrkY0kw2b+VOT54zGeTskGTm0B6Gn0rMhQTML0nKnX7YI3bofK1MA0Ap?=
 =?us-ascii?Q?zskjhJqlBoO5vOuNnBiwz3/7pSh1sAGqtngjHUC70EFBAj7t6h9w5QRBXBzY?=
 =?us-ascii?Q?V54Do/nevXccNfwlrLf5lBZNVImjhKsdKW2AFlQ6ZHlDHIklkl801CaqxZXP?=
 =?us-ascii?Q?JjET7vxAksAyWR8HUTqPenMCiaYgnnD9/KGG27eLZsLZ7UqCulOdWk3K7lB9?=
 =?us-ascii?Q?YJy0y+0Qi6fKFdkBftbVzSjuiGjVi6Kj5MyAKz9c28ul3VVGQ9l5otx1mqRr?=
 =?us-ascii?Q?3zKskgaiHOA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Op/boiHrj6OR8kurkjeI8tfEm2KJiC18QHaC2UwF0Se2iyoDeF8UXYWiMn+8?=
 =?us-ascii?Q?gD2LLsTISVncl8GDfwnJnZ3T7xCY+Wf0WfwXw2Deo23VI6kODEtqD4yox2Ki?=
 =?us-ascii?Q?gbOgzlUTIYICRdbvna7DG69XXcMsout3clrwnqXKyYboRTxeGqmtFI6n/Kk9?=
 =?us-ascii?Q?380EMbl37l8kync8jFTXM6kzA4cS9CTNBk3rhPmBTEmXuVFd45P5csqfarUa?=
 =?us-ascii?Q?fy1tNtQeNULfaueBoCMgljSz/JV9wdCoH/GZo/PTIVUg/Ar5wcO+WSArv0hj?=
 =?us-ascii?Q?O0+Lih3VROHlUMV0x/pzCbL8GZ+NQ+T7kjPumAN+1eY6saIxKOoHnZFncPQl?=
 =?us-ascii?Q?q3YOGPUhpw1dM133VAmqFEmY/qgBk86Xg5VndBKc7fLSY2tVmyuZtx8+Ko9C?=
 =?us-ascii?Q?IEoB0Re7VZoG/gVYLqtgR2RPgZwuCjTfnzO+25xEtJbzCxeKCo1ac90sB7RY?=
 =?us-ascii?Q?F7UmYp2qE395Yg9U25F7rYTPD+nz3U5uxTKJ/f12I4QnxzUNQSIxmrx3mFYV?=
 =?us-ascii?Q?uxDTyChsovQrcn0zsv+OIGUcvO5EUPYQY/ofdILMVnQXkCHvCp89BbDPctQi?=
 =?us-ascii?Q?RBQdEehPoYSuOliyBt4SYC84n0Li3B/yH2xjBlJw4ydOy3zeUrBUYDBOCwmi?=
 =?us-ascii?Q?Z1P4jOXtnX+O/DLq1TxTE4MbwkJusOuYLQ18PcgaslZLF9/GusLGU2VWD2JW?=
 =?us-ascii?Q?VUkG17UK9DsWJDApF+HnEF9tFjn5Sfhv9/EVWSavXVxqL8H7t/vZ5tz6uf3s?=
 =?us-ascii?Q?jxQ9Sp3fSdCpnvOkil5YZtm2OVKgufyZBd2DrnSPSt7CVP45aaNlj+Qg89fS?=
 =?us-ascii?Q?djQ9+A5mYVGF8HhFLu/0AsqRCFsfgCdHXO0MYV1wMTGDp3q8F7WyKri/zVTs?=
 =?us-ascii?Q?08D39fzFB0tdtyz979IhT84vaRsEQi6CDTYQuiut5UZPEuUJQSbeEsB5OH5x?=
 =?us-ascii?Q?ka49bn85xFtA3ZbDNUQH5mBcBpJuB0pvdL9TlPIW8oHzPMFZNOpJqFOgZn8J?=
 =?us-ascii?Q?Lp6+0f6apRzkMQEhcINbk9Fs/tTKWgE7dTat7d+DO+zkWxlnaBO2dEeZd/0L?=
 =?us-ascii?Q?7ROO/onPFIT4nTyTMR9klvYHkFGD1KivC4o1+/efLcTQIOPvI5rWurVKu4dT?=
 =?us-ascii?Q?+bOp6q+tYzsPr0twQcvV91HKTxn16xWLOaxnphaGwVNy5dLtwUNwFGfsDNaM?=
 =?us-ascii?Q?56qKNu6UzRF253OvahbMvuYZuPKZ0wOFK27DobjI8TGNNCeZdaZ9U6/jkKDo?=
 =?us-ascii?Q?zkuNIeYHmzgNnxjJfNzvL/p6oVvaAlCkr8PYzM/KwuDMn9gNMNESRKP3i7tT?=
 =?us-ascii?Q?YdkAxGsZMdlHcPPpfwFOpnN9ehehwYg96H0KBCAQ0lPgxTSX0wwN6mllamNP?=
 =?us-ascii?Q?KMmOvRq122yPjoOxlahCUORdB2L//0CVA5DCLQjvDcLmj4o6qa1E9w9lzPVU?=
 =?us-ascii?Q?2qKGjRHYhnifo/y2EgOTumL9ixi2lxrMCaXvwvfv3sWs+63vHft+f9HqUKj0?=
 =?us-ascii?Q?w2dLf6UiolQ/yK20imktV1/7ku6uOobMs/gc32GYDkkoA1xfUG2TnhUWujub?=
 =?us-ascii?Q?FoiQmEElt1YOhVvBEbK7EHS3qZwsNLdi53dYmkPcBzXQ3cH1dZOlMKKyw7R2?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GlXPpSGGq2qf7Se5IvByBWF2DbL0L8/UROMf/6TNhhw31adg20ZlVypaXc7NR/7NdO59tqtbk//nUQN9Vcb0ZRbO6Wn5PY5dcV/fp44Wwm937Qe9Zamdjx004tEaArxN8kL89dv37Vw6TMiU55ss0y/BucuAD1b9q2aD8yIiKYlHIYlLL2S/rTHdNZ9M6dg2ETviRbt4OG0KTQsKaPIZ2vIbRHbXjsR27DTppV0eOwyrbOmMU0iFxUH0a2Q6JY0coJkIkIHChI1TtIvYTlmuwzvw5ZNFo+Z1qsEpuMKhf8dPplYs+CVLBa9jrxrAvQ6QoQ3WuGzoNEhn5+EnDwEvieEnDazCtwWjAv67EbqLAaF6M2raQXDa7mRcGLzn0FvU57Cb/5NGbRBDllO5oeWIgTMizWVBMJ1GUIYg0+QUy4R2yUeCzioPP8q0r2FpoAkFlKLLJSsuEaFnLvYqrkLRJ8qaJUPTyNfCoRE3985VYAC/ccTMiMhphl8osOpgjMuGZA+4+HS14d+9SFEFqwkTufrXcKX8THg2fA2HarrCZUA9mwU50siCBuJDbL2RD42cQba7VHic4526vdIOEFkLhjgRKQAuw04+CHSKzbLkYC4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5144b53-0e45-4438-557f-08dd978819b0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 10:21:36.0505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGXsHf9ViFVVtoqc+D2TkZ0FY+xNBRyjWMNeWwqMHYrv91QaFFygQQsHEObZ7Bu/LhjvnASf3LkNHKnm1y66JlLJWo+YoS7a6ROwOALBB0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4987
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505200084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA4NSBTYWx0ZWRfX5WAem/xk7TZW aRH69T7r0tt63htlfZbbuDZNpfE/O5mBeR3KIC5fWYkvDMsXGihltZS8fLDwNzBYicN15W3bN9O EQE9mLe/NT6oQv79iXAXCygbNuNlPJ8woyIqW9y8cV1LQMZ0zseQSNvjDAbhyNijPpkWyl1aVIa
 nQt1Z4Z2cKMpXT727KGfp3mE+2nFK6WSU2dMGJPxQcpzExqbybDv9sugZ6EoGxeeS51QaTgo3nn WNLQsiFbZvt9NKNhw21lTB3BXQSO6XXv46HFJFLWODlRGbz+nSEF3hFA48MhJzKgkrEwVGljDdC +YhzHvgc8VmHAtokuTblc6iu8GT9uoo2TPS+c7qz3pPfEnzSrJi5ZEqic069i2fVyHc2BKICM5y
 pDwcJFZkABEnuxzg38kpy3lecdGcRyotLb+Nb9dW1n6/7t7U5CG3S65X2CLZyczVkikKJzUE
X-Authority-Analysis: v=2.4 cv=WO5/XmsR c=1 sm=1 tr=0 ts=682c57b3 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=tSmjGfC_nN-isSk_9UoA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14694
X-Proofpoint-GUID: zFOQ3OGt9OX3z6gxYuq5ad8rVO3pB46x
X-Proofpoint-ORIG-GUID: zFOQ3OGt9OX3z6gxYuq5ad8rVO3pB46x

On Tue, May 20, 2025 at 09:38:50AM +0100, Pedro Falcato wrote:
> On Mon, May 19, 2025 at 09:52:41PM +0100, Lorenzo Stoakes wrote:
> > It's useful in certain cases to be able to default-enable an madvise() flag
> > for all newly mapped VMAs, and for that to survive fork/exec.
> >
> > The natural place to specify something like this is in an madvise()
> > invocation, and thus providing this functionality as a flag to
> > process_madvise() makes sense.
> >
> > We intentionally limit this only to flags that we know should function
> > correctly without issue, and to be conservative about this, so we initially
> > limit ourselves only to MADV_HUGEPAGE, MADV_NOHUGEPAGE, that is - setting
> > the VM_HUGEPAGE, VM_NOHUGEPAGE VMA flags.
> >
> > We implement this functionality by using the mm_struct->def_flags field.
>
> This seems super specific. How about this:
>
> - PMADV_FUTURE (mirrors MCL_FUTURE). This only applies the flag to future VMAs in the current process.
> - PMADV_INHERIT_FORK. This makes it so the flag is propagated to child processes (does not imply PMADV_FUTURE)
> - PMADV_INHERIT_EXEC. This makes it so the flag is propagated through the execve boundary
>   (and this is where we'd filter for 'safe' flags, at least through the secureexec boundary). Does not imply
>   FUTURE nor INHERIT_FORK.

I don't know how we could implement separate current process, fork, exec, fork/exec.
mm->def_flags is propagated this way automatically.

And again on the security stuff, I think the correct answer is to require sys
admin capability to be able to use this option _at all_. This simplifies
everything.

To have this kind of thing we'd have to add a whole new mechanism, literally
just for this, and I'd really rather not generate brand new mm_struct flags for
every possible mode (in fact that would probably makes the whole thing
intractible), or add a new field there for this.

The idea is that we get the advantages of an improved madvise interface, while
also providing the interface Usama wants without having to add some hideous
prctl() whose logic is disconnected from the rest of madvise(), while being, in
effect, a 'default madvise() for new mappings'.

So while specific to the case, nothing prevents us in future adding more
functionality if we want.

We could also potentially:

- add PMADV_SET_DEFAULT (I'm iffy about PMADV_FUTURE... but whichever we go with)
- add PMADV_INHERIT_FORK
- add PMADV_INHERIT_EXEC

And only support PMADV_SET_DEFAULT | PMADV_INHERIT_FORK | PMADV_INHERIT_EXEC for
now.

THen we could have the security semantics you specify (require cap sys admin on
PMADV_INHERIT_EXEC) but have that propagate to the only supported case.

What do you think?

>
> and, while we're at it, rename PMADV_ENTIRE_ADDRESS_SPACE to PMADV_CURRENT, to align it with MCL_CURRENT.

I'm not sure making the mlock()/madvise() stuff analagous is a good idea, as
they have different semantics. I'd rather keep these flags descriptive. Though
I'm open to alternative naming of course...

Also keep in mind these flags are for mlockall(), whose name already tells you
you're locking everything :)

>
> Thoughts?
>
> --
> Pedro

