Return-Path: <linux-arch+bounces-8386-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EB19A9005
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 21:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC0A1C21F9F
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 19:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683C11FCC47;
	Mon, 21 Oct 2024 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FwbT6Vzo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JLBUahTC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7B1FB3CD;
	Mon, 21 Oct 2024 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539635; cv=fail; b=YzYSnPD3SqGYVeAaVYWsmK85afTBKDjQT9PJ24+bGseUrx5KxDB+4AbTAM4u09w0srZXlytggydJtiMxO2fYoKVePvlcT6njRj5Yj7HWSktT9d/u8j940daN05OFFuLfagN8DfhKTYCoZKxelx+cbt0nyA8rEBIwBD6xa3qlNZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539635; c=relaxed/simple;
	bh=TnKCTjkFsSwh3jhPzlwRpCyR+pZIBUuTbW1h28T8YGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S3oHFriRR7qJt0S1rU09+fyk3D4pOuzQwiwXuCZs37mi97kiEkvnnkGGY6F7ob1Ht+nxKLTzLT18I1GoBgICI+E9HmAWcRQHi32SS70B1PEfYtyuuxRhwgzGoHrRGTH9a59bHkRqDGjVBDSrqsFBpdIayEQQAXyWICG5oTVIsJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FwbT6Vzo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JLBUahTC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LJBZGS002496;
	Mon, 21 Oct 2024 19:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=TnKCTjkFsSwh3jhPzl
	wRpCyR+pZIBUuTbW1h28T8YGk=; b=FwbT6Vzo2dxybr3JfWuGXNp4dL+8ilWjX3
	/zzYrb15gDTeVkV5m4DNmVUD7+g9NSsg9wGIM5JWHRBkTLpxjUzNp433JH5juQ+Y
	epIzBidBc9NP8gYMvOGJgzMjidXcX03KNWbkQ70GF3Sark3VibNqKSNHwGGd4bVh
	xswORc3Ncm/fHYXcZ1c4x9lwExLu79HT2nxwJaSZ+EfHs/zhU0CLnDJeWHEOoIn9
	qbvLO2QuHvFyixmKKrCpC5t5A50lfuUPzB0WRZKRgmlL7bM5+fUcdSwEaYFumDzp
	cv1+1vxdexGtcybVfq5sdcJEcVv+TX53q/1t4KKpyQ3Z/KAMZ0sA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qbya1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 19:39:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LIxmMs022733;
	Mon, 21 Oct 2024 19:39:49 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c8eumb3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 19:39:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBFN/e+1SvY3zSjWEGziJitWtvfVNNRt7IEmlyjdwIGfthHCzX7fesILLfRu6GNz7tgbuFVfuJs2390YPVL6f5S/QJVKl72LYxaFfk8An318TPO145p3c78Rj0gpnKkkkOrEHeoSF9/SYjBzfyDNBkzH3bh5PvqFaMNbRxF7omSoQmi+/Jzd86Ctj9KGNe8qx0AHSUpRA1Rez7mGrs0APxrwjbtekX1eZgrZzXXO2DzcM7BI8uLP4piThbI13okfFw9Es+5VHtA29R+kPgst8QYBBJdIgOooTh7AdCeJJMt/TjiXotX75rB1kjBrJRbE1jBg1EeL5BAU5MeET87mvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnKCTjkFsSwh3jhPzlwRpCyR+pZIBUuTbW1h28T8YGk=;
 b=D+XCPNa5bXAgEksQh2N2NyHq5JgnGRj6UltNfR6qJE1SzfaxTiTI5bpF0HX+I9Kv+rlmaDuyZi8svKHsjuSiPDmEwkBPLvIufQm6xiEJnxDQ5Y8SLAdZyv8OPLd9wncERbygAwwG2x7PGthBuiypbFyYHD/C59+/C+3LNg5BrH9+mw37/EKDP7FVRT99tHBZ+9J0H28apHBm+8gvrCnDZHzNYDvuYIf52HS+Q5D+HQtCaBSHczM9dJeO4nda5zdKTi0Oqq21a2CESb+WOYwN5mVGGYvQ0T2H9gp8brInA5WX9Xx0iHy72F9yCPDbPUitYksmT/RUwwpcov7ICsL/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnKCTjkFsSwh3jhPzlwRpCyR+pZIBUuTbW1h28T8YGk=;
 b=JLBUahTCNuID9/R3HXUgxPVNXZKojYS1fmV2ft0RrZu09KEi6+1Qeai9scxixL38zvazNivIAiulrtNQ38Op2ylIidRg65wH/saRJrbkn9e7CgdGjanYETWZ/TfiX/YwcQTyPGr2yfJoac8QDpNN2kMcAdtdqEKVrOHlrJTODFg=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN2PR10MB4335.namprd10.prod.outlook.com (2603:10b6:208:19a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 19:39:46 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 19:39:45 +0000
Date: Mon, 21 Oct 2024 20:39:42 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
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
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2 3/5] mm: madvise: implement lightweight guard page
 mechanism
Message-ID: <a4b7ed07-3b14-4443-aa76-77d720912cd0@lucifer.local>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
 <b13a83f4-c31c-441d-b18e-d63d78c4b2fb@redhat.com>
 <b2bca752-77f3-4b63-abe9-348a5fc2a5cc@lucifer.local>
 <c8272b9d-5c33-4b44-9d6d-1d25c7ac23dd@redhat.com>
 <3baf8814-0a9a-4de0-b568-62d241dbba0e@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3baf8814-0a9a-4de0-b568-62d241dbba0e@nvidia.com>
X-ClientProxiedBy: LO4P123CA0325.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN2PR10MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: 76dac857-5e55-4f03-f256-08dcf2081dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kiwhLnub2rbFp9qitLU4dCY3FjtXZqygBozD8YuGikqM6149Zpwwv95dKE7y?=
 =?us-ascii?Q?G/lyJUnsEr97vhpCz1gyXFOxYXBJ50qY9C5IWxc0J5lkc7vuuGC+9u27jnzZ?=
 =?us-ascii?Q?Z9G01p1lFhihX8UIYrBkqTziISXLyt5k8vpHZMy4c8WgaI0C6D2g1XDeGYEz?=
 =?us-ascii?Q?gYnFOB0vCYX00TXAvVVzi39E7v5vuXmzkZ+yUBlxo12rj/7MvP6VPoWHW0Kp?=
 =?us-ascii?Q?cgBr6a8xQww6S5x+yEfGNf3dIi5X+DhD+PolL//8LbcjY0J0aZ8bA0DA6JdA?=
 =?us-ascii?Q?DjIPxzPvr4exFbcHccwGSiKNeSM6IKl3KsezuZ6No4OJQVPKO435aZ0m0+uq?=
 =?us-ascii?Q?5YV5SbODgloYFAQtB9YIruFdSJcVm8DaYN+faU+RsYpriJWENY3FxIBN5kG2?=
 =?us-ascii?Q?tS1ZV7oJfIGbulNX03CEDgk4cQsdMS/1lj92gGofHbIs6NqtzumjjsdTBtIG?=
 =?us-ascii?Q?/Pw6A7gCkszuQfU3301t8rBimeRyOr220SLx/Nx9s3A3Kk3CouoY8YCpjq5s?=
 =?us-ascii?Q?8FmhwZNdzx5Sm0QrQzo4IIks3zR72RnCgY8rP9DXMo3sgXnG+QIEsID/owSa?=
 =?us-ascii?Q?bLpSrpadH915dAks9nmLJRPTmpoXF/7EKPBasTZyynKDJWUkvuUaAqHRiSaB?=
 =?us-ascii?Q?OPXqvFt4NuhZtPPnzgfrqCLKrKykrKuVaSiT5RyiPiKR2xKovdfzW9u15JJU?=
 =?us-ascii?Q?7Osdk4hRkQeGmQBbCnsClQ+iDpjJefRiTIPjr2CG9G8FvrVJr4o83Zy66k5t?=
 =?us-ascii?Q?G5MNRCpvFQWnb9nnaDgP0XRgeN09nam0jiyWu5qPTITE9tBKTuikCw7/rz/b?=
 =?us-ascii?Q?hLhxpyuSFSCaMOkz0slnd4WkZyW3o9iE9yrx3Nm9cRTNRhlxdk23rgPRKxEo?=
 =?us-ascii?Q?pPJSeCoa+NanEjYk+XFK96pUfcWFuyZJM3kg7i6OIj1YukN2ZSjO2L06LV0h?=
 =?us-ascii?Q?/nPn2tYUZYYz7Y8DP9rE5iVkm4mi064TByJLFXjqQ9QgyWgz9I7zKmmGKMOf?=
 =?us-ascii?Q?j4SzOV0HDJEbwesyp4m7n9QTcTC/87/k6ofPGXrm/zdnfzdu4E91azmZsPuY?=
 =?us-ascii?Q?FKCvtKibG2VGTzFCg2UgkUWXau7lqGn8jfVrRhJ1+MoQXZBt/xHEG6mSE3x6?=
 =?us-ascii?Q?P2EyJ0VuWrl16FlcY2QiKuo8EtdosTCDZLWm3ya5z7TE03D3UGeTvpq7raa/?=
 =?us-ascii?Q?wFtGXKmDz2rNMCIqpVSkLtS7lWB5R2SanVUKQ0EqozVR2UWvsgHJJ7kynFB/?=
 =?us-ascii?Q?wiALeVYoFR88j2VuUQ8r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gyyab2TLJDX6hOkEgqdECuGtPy2y7lOsjhnwtlcXGdw9jKjJkFWcp0pWhvbg?=
 =?us-ascii?Q?rjc1dr19kh1Nj86ca5OleHnQyEBF+LdKb/QjECQ4UR6s636Kj7reUOp1mysv?=
 =?us-ascii?Q?50FIGryP+70+TKXAPeU7j+hqjV+dug2Dt9vhiTv5cIKE3rZ4jGWNAQAumR1T?=
 =?us-ascii?Q?0WHrfMPFU7qglREFO8z+E14C84aQTmYJWxkcPlZJpu3wZlSGPJZ6VHpvwmWO?=
 =?us-ascii?Q?MA0Zg/OSy47o0FMlbbTz8EV7MNaRcNsOxYgO/1FKjB8cK7CeZYVcEyexXkAa?=
 =?us-ascii?Q?ZVUsJYrYUpW6DQckL3nWGqtmOohFRH0588SxhvDgl1uS75tQNhMBQQ0hTH34?=
 =?us-ascii?Q?oS7ZyPdH23zMMxm9xB1Z5w66sk1bYyoAREJ8Wpi/RjkSdVJ7AI8ANq+0mmAv?=
 =?us-ascii?Q?prx2WRktf2Y+QrI5Kmu8ajrNwbcWSvpfA6brHC6Fd5uZWcx+ILBCUlSyh/8l?=
 =?us-ascii?Q?LUU8kpEIb4QBwV48HoG8EN0dVVY09/5R4Q0so0YZN34ledUHW7qUN5bFP7dw?=
 =?us-ascii?Q?S7zXTWtqeBFgbsHGvxPth20rcfp/bs1Kw2KTvEcWgk/HUO2mKXkscvYsvGI4?=
 =?us-ascii?Q?qlmM5B3al2cXmEWIOrNDUCGx6vhnq2ghyVsn2vwdEOrnvhf8TvfO4T9ZC9OM?=
 =?us-ascii?Q?nfE6rM6NWnl+EENtLO21fRcGDc9vwhqib/zwCZFYGAn4GTX+7LiDXGtqP3PC?=
 =?us-ascii?Q?D+Nh2pw4UeIddPsOEXYThtx+wXcpHhauljXuXpyr43lHW/w0TRtljPtSO2Hm?=
 =?us-ascii?Q?dp/YkMnGpJMGsk7LUUeRUAOe89lrrlb6Hnai5uT22FU8VZ4F5htMDdsf0GeA?=
 =?us-ascii?Q?92estiNwgBNJWl3hnIpi8zuRSTJlyAb0V64yQZl0pTxLpGVaVdWw26AR6PVQ?=
 =?us-ascii?Q?z06rN57mlUl+2Hn4htiyVZJVxQM+8EBZO+CgxYRSrX2rBdBLjIdNcqfyiSjN?=
 =?us-ascii?Q?LqL6BZV6Dgb5cFpjltPf2GMzq0evpsw6GbA56M3+8dCVu/f+0I9cCCxWh70J?=
 =?us-ascii?Q?y9EXcFc/NDaGrDQFrcMOxODCV4uz7BKRiIsT3tOo4SHJ/lGLSdS/T8wYOxHQ?=
 =?us-ascii?Q?k3h7CRhGynyf3SziO9oHwpoGDXDwQynvzghi0gdygtke1Ef7vUufoxfaTC7W?=
 =?us-ascii?Q?biTRB8tT8g2WRBThVtVZ5xj7NRWQt6Xjdlz0lw+q6m9GJS8JUeZehf2AszRF?=
 =?us-ascii?Q?UojPLSoIP/qSta+Z1/Md3L4m9M4ScVpzyEPxLYD7tfU7SZ74AnJhTYF9Ix1d?=
 =?us-ascii?Q?C6osUfQO3I5o7cMMUNseknazmptW+UeUgQb+osVd5LBiYXdHUvWtq3A124/I?=
 =?us-ascii?Q?XuwN9FpjGmjru2X3jWMXipZd4ucmNdnQw4yHeVbmjNpEIJb7W8dSHQ0CLxkL?=
 =?us-ascii?Q?3YSDZk/yd83rYfPsK6epHkNjNxbFy/taV+cV7hFSeHS0Dcrmq1cLnIyoSXBN?=
 =?us-ascii?Q?utYWxaCmLlFCOjGzFrZ+/qNm6r8Y7Lx+2lF8roWxvaWF3e9OZdiRXx+dWbH5?=
 =?us-ascii?Q?rUD/0BUD5Fu+TLitMaaFYV/DWg0uxkEYzLERWpI0jwYNpSxcWuDcNmYQOJl1?=
 =?us-ascii?Q?VR0zb8a8lyDalW5+35E/WmGUC9TVOBLaqaKy2MsXiYP7mnMwwkE1Vd6TfJ+O?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1iQub9JwmowDPubbSY4n0NJ3qFJHI7cev8L7ZM6Ze10rei0CT2xx51Qe8+0AoUpBjBpd5OKPD48iH1MtmOm0LA0CKJ4HxkIV/aHyOr33bJWjM+YzpvxPYmBrdaKtMd31xTgs17XRFGf2diIrJAhfGOD8QyHnpYKXGrvUhLfTYqYLqJPm3WJsG6CH9LiedXyR8lT4E9XExi7+MrSZ2HlIC89p7P007TT/LwmBWM/YhWdEtqejseJekmarbXw+u93JqKOZKGw+ZluCEV7ELyL8D6mDBG7/8y7sDnviZdXj7EVp4gqPTMtYjcBzT96HqmFhgUBzBNmb7I0X2vKqsVPGItTHnvQCIUW6xNsYYXd/P0k5NrSt1IKtNENLgf2J9xr75A69LfOY1AH6o52F0w3nn/222edOrfQfu0YvLLwvU6yeEepQRIGMAAu0ib3HXcdVlHcqNhyirW1ef727KmlZCBprbPK8b1q22+bgzaBijgt/GJ4a8ePfLL9Zm7PWfpqlMy4Sd98zd0hQsHjRNftgQ41d8mt1Dvr27dB6MMgNgNzgP65Cb1wEF+N52wnr6H3TDaZcdFAO8SC1aV57J5KJXDVxXlke+arxelCqsTiPma4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76dac857-5e55-4f03-f256-08dcf2081dfd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:39:45.8470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6kHxPr1zzEn/+a3NLEKcGZRmC7AJhpMTL+g0UB1crjk4k3Z6fEnw+Yr44019eRtkiLLsyqtTF9Xbvx1x06Xzkm+Qs7HbRz/W0qNeIESU7Js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4335
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_18,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=425 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210142
X-Proofpoint-ORIG-GUID: -mMLn2TZnqTxbRTqreSXHHct4RhuEzRq
X-Proofpoint-GUID: -mMLn2TZnqTxbRTqreSXHHct4RhuEzRq

On Mon, Oct 21, 2024 at 12:25:08PM -0700, John Hubbard wrote:
> On 10/21/24 10:23 AM, David Hildenbrand wrote:
[snip]
> > > > Just to raise it here: MADV_GUARD_INSTALL / MADV_GUARD_REMOVE or sth. like
> > > > that would have been even clearer, at least to me.
>
> Yes, I think so.
>
> > >
> > > :)
> > >
> > > It still feels like poisoning to me because we're explicitly putting
> > > something in the page tables to make a range have different fault behaviour
> > > like a HW poisoning, and 'installing' suggests backing or something like
> > > this, I think that's more confusing.
> >
> > I connect "poison" to "SIGBUS" and "corrupt memory state", not to "there is nothing and there must not be anything". Thus my thinking. But again, not the end of the world, just wanted to raise it ...
>
> "Poison" is used so far for fairly distinct things, and I'd very much like
> to avoid extending its meaning to guard pages. It makes the other things
> less unique, and it misses a naming and classification opportunity.
>
> "Guard" and "guard page" are fairly unique names. That's valuable.
>
>
> thanks,
> --
> John Hubbard
>

Guys you're breaking my heart... Will you not leave me with even a remnant
of a cultural reference?? [0]

[0]:https://www.youtube.com/watch?v=_mej5wS7viw

