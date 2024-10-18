Return-Path: <linux-arch+bounces-8281-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4809A48F0
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 23:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDCC1C23650
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 21:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6487E18FDD0;
	Fri, 18 Oct 2024 21:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ai9e9OEy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wt9si8GS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5E918FC9F;
	Fri, 18 Oct 2024 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287062; cv=fail; b=Qc/RTKEAbhhWeVne9X9EFMlf7nxIWlhFGyzQTDdBhuibfyAnVW67PAGsmn7zW1UI61T/qdXERuJRnc/gMNoSA4SVBxlUPLFlLx09Ubqg2DyNH3GLLHNBxkUaZIrKGQ4KxQx2BrDM/Q3Y1TdeXIZ6QYLLsDay6aR9mJ1HR/B6TgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287062; c=relaxed/simple;
	bh=ETf1qhFkgQcWXk72sH7NchXTZ5yG3drpo9nZZ7qQt5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gEKJ19AiEwafDcEYooDHgUp1ci5YGJOZBW6lF6o9BekyifD9rQ5tEhKnXYDweQ0eet1GTrxfkfmE1Adm319xqxtZozLVsE7kCajGZi+dyohaFicQVa5lpaxzhCTlqsZ9MpgekfEG8tCm6wtIaU8GRZnWn/ApVuZUBJnAxLc07n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ai9e9OEy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wt9si8GS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IKBeku015487;
	Fri, 18 Oct 2024 21:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=A3CVk/SL1nEOsfS+r5
	XjuTiJCOw61ZLpA8l83nGfMs0=; b=Ai9e9OEyTmFUSvt6KLFLrJ9kCxKkLuNFoh
	jMcp9mEocWidmqLT0mNei20bsdtd91OWptRUcsGKXMZzZajwpzViixnen4egR4+R
	cieeg0qQx2+171DLEBdG9EevFL6NWJfejPGMmNYrheUAhJILRKsrFQyRMLU/m2h5
	hkbsZ779Nx3pyI6RP8/RBIk9gkBbih0pIX1K4xJ/8jjUlNWpFzgKMcgN6ld2tObs
	QkEmBUS0dHMFlQYHIb+KrshA+QYpH0JlOUSZwwbzfEeENpQrAUq1adDPh26jtYwN
	q9Xnq9DWpHKaC8tYCEazrkOcSZksb0AqQw7T0l6BK3mSdNsgEuIg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7stbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 21:30:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IKnvlI013978;
	Fri, 18 Oct 2024 21:30:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjc2qvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 21:30:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1YmRcX50/BVg6Iyig3BeV5XMA5uKgJgUgK1rJJFiUyVPbYFfta/uvbtaW/98L3c6yk3LrgdF3wCDD4g4TUwbUAxfCjuo3vIYJM351ILe8MgpsdTkV2GYHtTlRnDjurA4nOEdZb9iP4NvK4UjVEcp+CvU3IcZInYz1VrjCRyz4WyTepQ504c9NHTwG2+z5g9mLbB2IlAQcXGT4nbO7NqO53TlHfnzFB4k/KfwdE/acZoErxXoJywZaz69AHB4RG02aMlUtabJtdCLcQz9lE1tx2HhM2K55K9gS9xKSxkpWPAcyKYCY1y4lJM/DsSVx4X2vamJ0eAJGmC5RfsDJwmyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3CVk/SL1nEOsfS+r5XjuTiJCOw61ZLpA8l83nGfMs0=;
 b=w+PLjJLPiyp2Uw0wh+w02QQkErcbgAeHZjY9V4VP+O8arBjGYX/GdIBixL3SBntmG5y+WwOuuSERxpYBhTsVG+8PaqpJeAfGCFiyfBvVD9r3P9ZM6xaZ5dcwL4kysErwQlzLAsjxvfpVhJ35gH9HgzJgbcvN7Wnd3K/Ka5vK3sjjq+se1sOXxGKesx8jiDj5c2hBGNxjNbLVwgvCwtiYwmmZQEprUh9di5VRkIi7N0GiXpgNzJi6UDfhUj9xiiR+wHF1Vt+X/szOjCxmmSvv9ZUJR3uc5XoQKKNw97zLTAMTd+Hpo57V8kdruL7LPRNPRNTfy2S99cJwKxjOJ2LE2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3CVk/SL1nEOsfS+r5XjuTiJCOw61ZLpA8l83nGfMs0=;
 b=Wt9si8GSGFKtN9LRaT1U/nItQKPlmXgbDrCpeR/jP9q5Kw+9b3aEP3m7Q/tJvXB15Fz+Pwq0mNhfhevAhuWld5h022AlrhFBvenNQGpO/vZXUJiSEtOML16tgKsfYz5A6AHq9VZfgxtuzqqmHfb/SDNSZz1tHcpMZiq/0OjGHz8=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA1PR10MB5759.namprd10.prod.outlook.com (2603:10b6:806:23d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 21:30:06 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 21:30:06 +0000
Date: Fri, 18 Oct 2024 22:30:02 +0100
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
Message-ID: <bddba849-b8ff-4a5c-acd1-51fa761e0402@lucifer.local>
References: <cover.1729196871.git.lorenzo.stoakes@oracle.com>
 <e4985328-dbfa-4c47-9cf9-12aa89ba9798@suse.cz>
 <4b5382fd-e553-4fef-a7c7-a2d3130b948d@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b5382fd-e553-4fef-a7c7-a2d3130b948d@lucifer.local>
X-ClientProxiedBy: LO4P265CA0111.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::11) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA1PR10MB5759:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f53542-6c22-4cf5-7d3a-08dcefbc08da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U+wIqh2wc99BKomF7i9fHGNWGA6IGPGaSHYUOemcEceY4fMq4+b5tXNyThZI?=
 =?us-ascii?Q?xjZclPBCviwNqI3d/1lEkvqVDOkRsKvfcgmqlMsXUvnOs3Aj5U4M3zJ5fL/9?=
 =?us-ascii?Q?cnj/8UwveviWoU6+3Epkjhgx4wo5zhYUrXrUpWO3l/Gs8KHYRFbbCCgwsdBI?=
 =?us-ascii?Q?x228LuoX7PpzbUrloybZWHpY+qBDkrauDiUn89S/Lr+nz6x/f3csokBwh3GB?=
 =?us-ascii?Q?SNIwx4/45tJ7Tp78LMtVjyy3QzhptUH/o3QIModt/Lrj9TNJHfTVZ02Ty/2W?=
 =?us-ascii?Q?/NxRNbhZ3p3bhU6b06CvlXnjPegZ0ld1O6c5Ea9OMExsyUefipsvh/TxEjZ1?=
 =?us-ascii?Q?myZ9KKAHTPwixrm30PVDsWgbh+HLpwweZ3smj9sum90Z6lgDLKNn1V5ZMKgP?=
 =?us-ascii?Q?g7H0vxnuFRBc4DNU+XY8yD0avGNGCbQG4eZmeSAMlxxS9AUaJ4072XRrCuvR?=
 =?us-ascii?Q?N5SxO24/vRsxjSmX7FTbkLFmn2R6s/T08wKNEnEtHKTxqgb3qIZeUVvvut5a?=
 =?us-ascii?Q?dJTlMqjyhlui6Jb3zCASpxNWRsCYSdVl94TG6Rqvc6tX4gRl+3aryU0Oc7WV?=
 =?us-ascii?Q?O3/xehGrHTxmueOU0dIbtCZjmbmTVpGl2T/ocRME/1AihV2p96gcAHalWvjq?=
 =?us-ascii?Q?/mhfUaZbsB5qAIk3DFBUn+K0rKW2Y6ONP5AtyAQOoavSTuEUVLHaYHPghn7D?=
 =?us-ascii?Q?G/FJg3xi2sWn44lQiSqg8iX24gyH28VWss0NXZlAZvyfzPDp7awZd4a5Kzlk?=
 =?us-ascii?Q?bpw7f+SmWMI/kuzJtPPaEkXwanvL2QxY6q/116NDFK+BA8z/VoA52L1c9qiC?=
 =?us-ascii?Q?9zlCTGQQZeTOmTKyJdOiokLLTO5gaxp5bfrF9ntWHQPdbAtB3yP92X5usE3Y?=
 =?us-ascii?Q?jkIy+iFq/dF7/kminpnlhgmQCMBh/jvoSKdLs2QLMCHf52525wpNqD4pEvKQ?=
 =?us-ascii?Q?pnu1Enh1e+rDBM1br2Oen750ELkcwaMBBR4AwPVuLdp8DWGKyh9KpvJPk+DW?=
 =?us-ascii?Q?oIjvhS8oNC1H90TbLFG80ONwzWC1bBE0+8rne3Dp+leXQp4JapcLWPRVaQQu?=
 =?us-ascii?Q?Vr34+wd4zsIqRfv3guBhvhIwffk4tGIADFRdJdUYQYK136U+OckQ5Q1vpmVp?=
 =?us-ascii?Q?Npb9PE6BgeroAo/y/9WKlLpffq7mp7yUjyw1JxLVNiuLIXqWcWRw+uIg28/K?=
 =?us-ascii?Q?ERXuxOf6hK2SSJWA2RjmBf+0gCz+6pVvmNxIk02UEAQA0iS28DNTF1Avte8v?=
 =?us-ascii?Q?GJlU5bw1CdWdKLh/KOx5HxW9PgvevbAgoI8Y99Gbg2meEQAcVNB/ivE/uNpM?=
 =?us-ascii?Q?D3NUK/f6VHU6CbdIMKlzcHh5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r8qlu9Ey058HrfpjnfE5ma6qDcJzJzgkK49ojKgc8TURCn19aamXdm9U0XQt?=
 =?us-ascii?Q?LEQMPurWrYAhdWFqIgdeHIBMugOgArWVfdGtv6e9OnO7lVm4QUs23o9GtU9x?=
 =?us-ascii?Q?9Gta6pAaZDMtRuyH+BNNI20lls5eC41qRk3YOqa7hpg1smXzq5is1GfYUxwg?=
 =?us-ascii?Q?S6OJD5CMyp2B9O6wqGMM72tMpdG4kcMGHzWXgeBTW9dOHbjI9OvTv35cEOO8?=
 =?us-ascii?Q?wnL9KS8XLjniYYW8zpVWDLhPdUBkws0cqUb4N3hJgSqCOoJO6trI3ta9Qcv7?=
 =?us-ascii?Q?01c9iy1h403K3FKKpzakQD/lN7Ud85B8pq80G8jvyS3cm8TxeWcau7UmBAaX?=
 =?us-ascii?Q?ur0uymQkB1sY8ip0hiGjrqLkAhHb9krRhaJsVX6xqcJ4aMqmJT1z9SKanaBo?=
 =?us-ascii?Q?wMSB0ohZBwOCnjwgUjI4VQmjTbIcfvOXrt3CPeWOjg0Mg4RZbEhFY+GKCz+T?=
 =?us-ascii?Q?nQMZ8+q7+BM6qBdmC7GKqXVqYektXz4tXsv8HT6XThdbZ7/NxPV+0FcsNW6j?=
 =?us-ascii?Q?ERk3es+FOV+2SZ07KhHZyeVcllUQRSdVxDkLQFpN4J3o3tVjGuP35y7QRcwF?=
 =?us-ascii?Q?U71OoUteeBM1O3vuzZ1enH/kl110gFam5Rklw+obKlUA1/QwDaygiKqPiAVX?=
 =?us-ascii?Q?T9i28CYIlG8HH51suyC0USORrHS5jb3I3IioFfqBlDxQ6eVN+2oEBUDhYmec?=
 =?us-ascii?Q?OmNlE+HgyleJi6OPsPlsrsVGs8bALGb/DX62iFWEP7GYtjB8WAgQZ5pgscxg?=
 =?us-ascii?Q?sgf/EHiItQS9Mx40GNZ2UR4v2Qsoc3wsx9BBgssxXYtcpaWkYGbK900L13B7?=
 =?us-ascii?Q?juW57kgtBIdtT71J6E8/HNMqQRKxM+BmeG6Vpeh0iZnYovFbkrFNRzxQvSiy?=
 =?us-ascii?Q?GzmWc5BIgQBDIKlAOJ5nmJ6i9skeTY9syPMZnTOKTGlporE2TtNQ6Rvq7/uw?=
 =?us-ascii?Q?dYpSSUQQzK6K4w/6V3Uc62qzZAMxxrmQOjo5+YL+3HFTDWmAkXCxlJGAnQxP?=
 =?us-ascii?Q?fjARHipS11z7hKoqLUfztVj6if8SBqtn0DWoNaMxnLd6jssiuqWAyI7l1okC?=
 =?us-ascii?Q?w3HaC7jkLXPwbD4x2WNv8GFvR0tZ8dTJLIAICd0ASA3gnYWHPPFe4JBfMbK6?=
 =?us-ascii?Q?i3JtdVfF1ajpCZWoalA5k7PLlThosKFbbHcQ01CLRdqrF489qbyndZXl+U9V?=
 =?us-ascii?Q?ygRaArjNNYW1LYVq+8NhNYxbgPfP1+EnjsqS80+0dXUEaRYRERq5/x2XhwNa?=
 =?us-ascii?Q?W46EOhqreWvl5CFarXtJhIWkKFtDMe3Q3FjLz9mPJVoXVj2WYelaXpFGccwM?=
 =?us-ascii?Q?XryyvBatBTnxSVrAAAL9R7ZzVtEAV01zXoHU97ErmjV8WuijhGEkMzMjZVOh?=
 =?us-ascii?Q?X75T0Dln1BmR/MGGqUd/ODxp865twmUK93T8Ufl0Y5+6oNQiKY60Ywa5kUBE?=
 =?us-ascii?Q?QM7I/CJ1/uP+sWL0dSWvQgxQW03O9qP68R/2XptHCas8ZZKNvBWZ6uQ/8UmC?=
 =?us-ascii?Q?/OjZM5tew1D9IUXoR8IBEiGMeVby2awe/X5HizpEsk4pD5ySNp+BFyliJTDv?=
 =?us-ascii?Q?6EEU+BZxF4Qr67RJpncdkddxDL/xXQ4XU/qYQ+xPWAClsEpF3aOCwHrPOSNw?=
 =?us-ascii?Q?RbdwzetHZMCtSuIppoFfZVeIvWCWyf7lUBhCI8PqT8/SHYtU0P1sBmNQBuRi?=
 =?us-ascii?Q?hG3C+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AnJirIciKmTLXEsAwMt1GhBXdepy/9EU58z6gKcP4drQRMUNBsoiQFZupcnCE/AMBNj4fANTX4a2aasAdJiS0jlzDWmZUqJ54hLT48fB3OM1l1dGioQrVXo9gy2biWw11dCMw2vQ6eJbqb938loaPXiecMSMLPjixKLvFXnPoOYDTKEFWrYkcNepjEloEq5TAeWDRK6IokH/YAglC8s4aJdzwDbIwxpRW/sMfjypWOGHF6l2C/BGzczL1JEVv7e3RBmYoXnmmR7mtPXhCLG2X99m83PXuDNuGLEh2NUK/8Z/kU6N7/QwAVQAiPBwH7+2COJ4qiMFO9JkpycbUIudo5txzDrD1/9QERskf9R9x/ODO62uhxvb9T0Lv9iBBr7GI/pAJSqdT2DzJfpnLtoNVjWwdsm2KUvRKLg0GLdAaO1mHwGACW6BUMQN770+vzQpoZJoFMYZ18oeJL93DGahL2UenMGLaRdfMMAlQ5PAeWs0OjxD9DyuDsDwUrGGGsaImBuBgPpB1y+FLy86UVQT4o+uJAf8/U7RxUAij7q4OSCa7JdE/oYnLuoDfikIgQAGRdp8bj1kbUCbWakseFshFThbC4H6yqeu6+z33sNNkVs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f53542-6c22-4cf5-7d3a-08dcefbc08da
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 21:30:06.2492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /L0AKrrE5SizRBQ1kA4cT16UUEvRiF8IJg1/faqUirWHT59Q4ijQFlHIAptwHCjajq8aH/9v8oKkwjRz4p+xzcUjRIzHWnaVIZ8dtyGz604=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5759
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_16,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=962 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180137
X-Proofpoint-ORIG-GUID: 2TGVGO2ZTDgs_-rivij18f3oVEX_0u5A
X-Proofpoint-GUID: 2TGVGO2ZTDgs_-rivij18f3oVEX_0u5A

On Fri, Oct 18, 2024 at 05:17:56PM +0100, Lorenzo Stoakes wrote:
> On Fri, Oct 18, 2024 at 06:10:37PM +0200, Vlastimil Babka wrote:
> > +CC linux-api (also should on future revisions)
> >
>
> They're cc'd :) assuming Linux API <linux-api@vger.kernel.org> is correct
> right?

As discussed on IRC, no I was being a little slow here and hadn't realised
you'd added them, apologies!

Will add them on future respins, sorry guys :)

>
> > On 10/17/24 22:42, Lorenzo Stoakes wrote:
> > > Userland library functions such as allocators and threading implementations
> > > often require regions of memory to act as 'guard pages' - mappings which,
> > > when accessed, result in a fatal signal being sent to the accessing
> > > process.
> > >
> > > The current means by which these are implemented is via a PROT_NONE mmap()
> > > mapping, which provides the required semantics however incur an overhead of
> > > a VMA for each such region.
> > >
> > > With a great many processes and threads, this can rapidly add up and incur
> > > a significant memory penalty. It also has the added problem of preventing
> > > merges that might otherwise be permitted.
> > >
> > > This series takes a different approach - an idea suggested by Vlasimil
> > > Babka (and before him David Hildenbrand and Jann Horn - perhaps more - the
> > > provenance becomes a little tricky to ascertain after this - please forgive
> > > any omissions!)  - rather than locating the guard pages at the VMA layer,
> > > instead placing them in page tables mapping the required ranges.
> > >
> > > Early testing of the prototype version of this code suggests a 5 times
> > > speed up in memory mapping invocations (in conjunction with use of
> > > process_madvise()) and a 13% reduction in VMAs on an entirely idle android
> > > system and unoptimised code.
> > >
> > > We expect with optimisation and a loaded system with a larger number of
> > > guard pages this could significantly increase, but in any case these
> > > numbers are encouraging.
> > >
> > > This way, rather than having separate VMAs specifying which parts of a
> > > range are guard pages, instead we have a VMA spanning the entire range of
> > > memory a user is permitted to access and including ranges which are to be
> > > 'guarded'.
> > >
> > > After mapping this, a user can specify which parts of the range should
> > > result in a fatal signal when accessed.
> > >
> > > By restricting the ability to specify guard pages to memory mapped by
> > > existing VMAs, we can rely on the mappings being torn down when the
> > > mappings are ultimately unmapped and everything works simply as if the
> > > memory were not faulted in, from the point of view of the containing VMAs.
> > >
> > > This mechanism in effect poisons memory ranges similar to hardware memory
> > > poisoning, only it is an entirely software-controlled form of poisoning.
> > >
> > > Any poisoned region of memory is also able to 'unpoisoned', that is, to
> > > have its poison markers removed.
> > >
> > > The mechanism is implemented via madvise() behaviour - MADV_GUARD_POISON
> > > which simply poisons ranges - and MADV_GUARD_UNPOISON - which clears this
> > > poisoning.
> > >
> > > Poisoning can be performed across multiple VMAs and any existing mappings
> > > will be cleared, that is zapped, before installing the poisoned page table
> > > mappings.
> > >
> > > There is no concept of 'nested' poisoning, multiple attempts to poison a
> > > range will, after the first poisoning, have no effect.
> > >
> > > Importantly, unpoisoning of poisoned ranges has no effect on non-poisoned
> > > memory, so a user can safely unpoison a range of memory and clear only
> > > poison page table mappings leaving the rest intact.
> > >
> > > The actual mechanism by which the page table entries are specified makes
> > > use of existing logic - PTE markers, which are used for the userfaultfd
> > > UFFDIO_POISON mechanism.
> > >
> > > Unfortunately PTE_MARKER_POISONED is not suited for the guard page
> > > mechanism as it results in VM_FAULT_HWPOISON semantics in the fault
> > > handler, so we add our own specific PTE_MARKER_GUARD and adapt existing
> > > logic to handle it.
> > >
> > > We also extend the generic page walk mechanism to allow for installation of
> > > PTEs (carefully restricted to memory management logic only to prevent
> > > unwanted abuse).
> > >
> > > We ensure that zapping performed by, for instance, MADV_DONTNEED, does not
> > > remove guard poison markers, nor does forking (except when VM_WIPEONFORK is
> > > specified for a VMA which implies a total removal of memory
> > > characteristics).
> > >
> > > It's important to note that the guard page implementation is emphatically
> > > NOT a security feature, so a user can remove the poisoning if they wish. We
> > > simply implement it in such a way as to provide the least surprising
> > > behaviour.
> > >
> > > An extensive set of self-tests are provided which ensure behaviour is as
> > > expected and additionally self-documents expected behaviour of poisoned
> > > ranges.
> > >
> > > Suggested-by: Vlastimil Babka <vbabka@suze.cz>
> >
> > Please fix the domain typo (also in patch 3 :)
> >
>
> Damnnn it! I can't believe I left that in. Sorry about that! Will fix on
> respin.
>
> Hopefully not to suse.cs ;)
>
> > Thanks for implementing this,
> > Vlastimil
>
> Thanks!
>
> >
> > > Suggested-by: Jann Horn <jannh@google.com>
> > > Suggested-by: David Hildenbrand <david@redhat.com>
> > >
> > > v1
> > > * Un-RFC'd as appears no major objections to approach but rather debate on
> > >   implementation.
> > > * Fixed issue with arches which need mmu_context.h and
> > >   tlbfush.h. header imports in pagewalker logic to be able to use
> > >   update_mmu_cache() as reported by the kernel test bot.
> > > * Added comments in page walker logic to clarify who can use
> > >   ops->install_pte and why as well as adding a check_ops_valid() helper
> > >   function, as suggested by Christoph.
> > > * Pass false in full parameter in pte_clear_not_present_full() as suggested
> > >   by Jann.
> > > * Stopped erroneously requiring a write lock for the poison operation as
> > >   suggested by Jann and Suren.
> > > * Moved anon_vma_prepare() to the start of madvise_guard_poison() to be
> > >   consistent with how this is used elsewhere in the kernel as suggested by
> > >   Jann.
> > > * Avoid returning -EAGAIN if we are raced on page faults, just keep looping
> > >   and duck out if a fatal signal is pending or a conditional reschedule is
> > >   needed, as suggested by Jann.
> > > * Avoid needlessly splitting huge PUDs and PMDs by specifying
> > >   ACTION_CONTINUE, as suggested by Jann.
> > >
> > > RFC
> > > https://lore.kernel.org/all/cover.1727440966.git.lorenzo.stoakes@oracle.com/
> > >
> > > Lorenzo Stoakes (4):
> > >   mm: pagewalk: add the ability to install PTEs
> > >   mm: add PTE_MARKER_GUARD PTE marker
> > >   mm: madvise: implement lightweight guard page mechanism
> > >   selftests/mm: add self tests for guard page feature
> > >
> > >  arch/alpha/include/uapi/asm/mman.h       |    3 +
> > >  arch/mips/include/uapi/asm/mman.h        |    3 +
> > >  arch/parisc/include/uapi/asm/mman.h      |    3 +
> > >  arch/xtensa/include/uapi/asm/mman.h      |    3 +
> > >  include/linux/mm_inline.h                |    2 +-
> > >  include/linux/pagewalk.h                 |   18 +-
> > >  include/linux/swapops.h                  |   26 +-
> > >  include/uapi/asm-generic/mman-common.h   |    3 +
> > >  mm/hugetlb.c                             |    3 +
> > >  mm/internal.h                            |    6 +
> > >  mm/madvise.c                             |  168 ++++
> > >  mm/memory.c                              |   18 +-
> > >  mm/mprotect.c                            |    3 +-
> > >  mm/mseal.c                               |    1 +
> > >  mm/pagewalk.c                            |  200 ++--
> > >  tools/testing/selftests/mm/.gitignore    |    1 +
> > >  tools/testing/selftests/mm/Makefile      |    1 +
> > >  tools/testing/selftests/mm/guard-pages.c | 1168 ++++++++++++++++++++++
> > >  18 files changed, 1564 insertions(+), 66 deletions(-)
> > >  create mode 100644 tools/testing/selftests/mm/guard-pages.c
> > >
> > > --
> > > 2.46.2
> >

