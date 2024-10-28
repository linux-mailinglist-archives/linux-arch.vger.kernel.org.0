Return-Path: <linux-arch+bounces-8655-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 623AB9B330C
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 15:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84DEC1C21634
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 14:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CB51DE3A9;
	Mon, 28 Oct 2024 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lCaRxita";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aLgRz3MN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54881DE2C1;
	Mon, 28 Oct 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124888; cv=fail; b=Si20xdxLop12WmoANml5pGBQ7bIIIAmDA7H6LYqfQbMYF7pvHlxof837xodDOYtHMM7XouZIeJPmaqiw0c48HEdADv5BIxMVGrHzBrH1cfe1/6rPCmscInwzHw+qxJCnE+hIMgTfXGETBbNrWX5P0a7x8X+sFKRW5bU5jUkoZOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124888; c=relaxed/simple;
	bh=t31k4CLIPWkgxC4Oty2G27J6kezWgmbx0s/baj82864=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NIi/pP6VqM0T5Ej0ACGuJLd4mMdI5psbZ5mf4q4MWZpRV3jwVYhPYrTBsUv2yUu5Dp2nQzzvioYtbc16ymrUqXl3biD5UW8GIhZeFGOvFZTBa+/RdR0a1LELulhXgjNJE+ujXRebCSocNmXk4b9V8xU8R5BHcfpte9+1k28i1Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lCaRxita; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aLgRz3MN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SBStOc030440;
	Mon, 28 Oct 2024 14:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=IuCkv98ioR8T1DsE
	9PcLGhzdZ8U6gfZuTlPOIj4E/BA=; b=lCaRxitaa5dQ0+7MLpzOoJMMd0m2aPi7
	K07Srd6s+vCUfwuCPle3To7CK2taV0YEUoSuEsb0C66X7Zvb9ciSgeNYteSu1wE7
	4zuwjze+T+NvtOpGmcy95pzxPvIrQhKYh2pFaHoy9SSVVStE+XWIYkQx+5BnQOnV
	eM9vwvxjNl5WWJUAt0wzxma+rzmU/mU5Dql7DHIJGE0GAV1WA3a44Qpc/2ZI8hIy
	tb82uySnQ/vhqXZgGO4K2F7NN3ofOhNVuf2RZ5j54E2cqdQ98PyYOe1vJH9nLVF/
	paUcyX/JzT1loPsL0Q5N7AppF2sIDLlzjqrJ5isT07MgGdmGsFaWpw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grys2xwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 14:13:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SDnQuF034776;
	Mon, 28 Oct 2024 14:13:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnd5xy45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 14:13:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRyz513q4Sau47oi5cNIelBHh3/1Hn8GsUrXnDjo6tZticdXNma11fl9WCa5wpai4mwPN7iSCoct+i70VRkrIkrAU3rVtkfgLQMj29l4n4yuGqcwAqSNviIrOJ46dNXkuJHrII13u8ADx/n191P+KsOpats8KN9UsCytrBmdBKGqspcEQt38L5TL934gH9ZggQaBjSHYnkZbckr5b+I0riFDDYcqc3UxCcYWWcHa+IbUjg7ytpYcqcLU3VNzcGD4aK0HyEpdiKMWOumNBj2YTGxAzc1w3lpK0F/vUHcy/aONdi8n+5qyQfF5HpyiEq0U42VFzqSPapKH+nNJyNGZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuCkv98ioR8T1DsE9PcLGhzdZ8U6gfZuTlPOIj4E/BA=;
 b=clMbOmdVGVZyo9tY9lTSmqLq8pe4oji+emwynkiJsJtLIgHFsXUovmmSoAbi+wpYoygQbAJZP2gJLRcR+TzfoCMmbAEkKPk32qbLGlWpJHCP4RKyWYsGkWIKQ9fM/ohEtZu5MZTq9bqogbrARi+ogi63z6R0ISV12iQUYPI5KSkHNbUEtzp1kywpSO/C+YpNNF8fYgxpUhgV94C/kxvMOMcZsWZzl2Buf8S2i1gAZij9VjCDyzsp/wSV3JJ2XgUFv4lBi3qg/CWbiQNOTwCis0DQ3k2EVk0v2UGY3SDmks4pAyebCoUqAc/UQBzWCIRC5AohDZWPPo20j2Kb7klzeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuCkv98ioR8T1DsE9PcLGhzdZ8U6gfZuTlPOIj4E/BA=;
 b=aLgRz3MN/mX0cEcJgrXGgNp2CqZpHsLArLRadtmZ9VBg2gQgwSqp7F8JpLe+PBsdZ6HzPvQbLuE7eFhU1tMO2ERuQx/xqUiEhDJ6CqvrllfG20i+ufqDE7pHwSOifjNkoLzs8CWEtliBf+PMKfb+Xulug1fmyL+IUZMc7Fxq0uI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ2PR10MB7598.namprd10.prod.outlook.com (2603:10b6:a03:540::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 14:13:36 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 14:13:36 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@kernel.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v4 0/5] implement lightweight guard pages
Date: Mon, 28 Oct 2024 14:13:26 +0000
Message-ID: <cover.1730123433.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0179.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::7) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ2PR10MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f9b5a6-7e9b-47d3-bbe9-08dcf75ab660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r2v/Ate/x+VONa6Zq31fIouUu9HCoV3uRYBkCLqeyo9LJ75ciaRD4PrMLjzJ?=
 =?us-ascii?Q?ufybwqDKe/k3aBZuTuxQx/1YCUaboRJfRuVEJr4I+nsb116z7UzE7m6U/PWH?=
 =?us-ascii?Q?2wyYBsyQUuIDTJ2DGlfo3SRIFWk740jev7ISbomvB0VUnC8HrS1AGgqJbQEu?=
 =?us-ascii?Q?Yr4CzFOxGGKFDIj2phvi/o0sTtCUIEQ3BcJDx0y7EqD+417eL+5+11NXlWSK?=
 =?us-ascii?Q?oMgyBq/hDkgV80l+i7U6SIs7/DYpFCbKT8afTazRbodtG9pmp3z/cYs4WaVj?=
 =?us-ascii?Q?6Xnsc5/za6PHRWcmcl7yW4Zp677FHhXO04ca0MmTabxEA8O5mEH9yEAqzLrn?=
 =?us-ascii?Q?xcW9eo6cYCfaJrhE8o7zKQjAq8CkzaZ6D5nM+lZDeNRrtfURQBQ9nDGH/9vp?=
 =?us-ascii?Q?ePB7lSwajnkd0mznENEbY3DC6MLfQzSQlVBebHsGQQc7wAZmuY42LVIB9Aiq?=
 =?us-ascii?Q?41S0P6mLu8NdPQUCYPEB0NRa6i+XyonFHf+NGw5+rUsxUmOXYlbj3f6l0FuZ?=
 =?us-ascii?Q?P+wCrZ/OokSDTJbv/ID10yGN/HoDdE0K6joIVyz1M6y0imUhX15qpBQBkCrh?=
 =?us-ascii?Q?JpKgsdhrtps9Kn9quFtECmfagYuQXNSYm5kJ7MB3gTz44KaunTwsffb1/+AM?=
 =?us-ascii?Q?0kc1KYq7N2fd2H3D4MUD1Os2cND5VUKjaRAMtSAopYP8A394UqCj353+9lZL?=
 =?us-ascii?Q?631d5zN+Yn8ETYq+ai1qQEwNfsooHa+sv/YS7DOfKE26wNYlKan3aDpJAw6q?=
 =?us-ascii?Q?nS7rLrPuY7PrdDJHXTnq7oufeV0fNQKXL3AHls3jnULnSs7DFkuDNFk7LpBP?=
 =?us-ascii?Q?AcQKhUj4xWxbhmn2bl+MuzLyQKzZO/FOZtKhDWTJ0oO0xjtdrzoqPfGBfaIh?=
 =?us-ascii?Q?9TaD13uvGPH6vJIyvAs/yvlGrUb/m9nLAtgNEoZEE5GwJGas4Deza3YvhdDm?=
 =?us-ascii?Q?kZJzss5+giiThuvxK0ex7ys7QWXorYU9jF95IJX2fKSWwiEYWmH9GM86+edb?=
 =?us-ascii?Q?LqiXcs8+Pn1k6fR+L2IoRGCSDdsHAjNAZKfL0wRfM5zzkq5LeK1OT0LWSGRx?=
 =?us-ascii?Q?JSSBelSOuOmdalATBsMgBZzcvrGMvRbG47e9hkjkUxEdQ+jGbi8cFoCORpVj?=
 =?us-ascii?Q?ymx3ZbfW5mkyfNaj7ZT3ag6vvrs0H4OQNwKkjHLMnIWqzb3gyAlngc37VhJZ?=
 =?us-ascii?Q?IFkSiGmtRz0LFUJf87aVftBGA3OaRGz3+t53g12O/EMDxy641vjwVTF9YZxf?=
 =?us-ascii?Q?PAXFTZbBa0LKK5qhatRMahAourVQ4piy6vQnUyYX8rmzg1aPgZkzrC22NwGQ?=
 =?us-ascii?Q?s4Hol4sonRldTps7r7PS8szz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bXDO5glg/WUMtyY+/MLNTeO5S2UmSJGtTNx6v09LoM+VNgmUfoHWMdvMFBsk?=
 =?us-ascii?Q?0O7p0KA49QzxofzKA/thfGlG1P7qNXB+y5c94SCq+DF6tLr8SgFMVMGtwkjM?=
 =?us-ascii?Q?RmI3gXZS/4cgK+Aehx9xC/r7AUbGi1lQqG2iG8cTuBAVDN0v2drjhClrBp4l?=
 =?us-ascii?Q?b7btmrJmOMyIxvhciaIClfD+Z+yisnJrsYzU/iFCJU0f3l6TPimY7QjIBIKH?=
 =?us-ascii?Q?fkztO/lZPZj1F9AxQpqIex1kUyvItfHi5FFH/lhGOn75zz1tzB5Wys9IQTjO?=
 =?us-ascii?Q?A5tSpCviHD74ZXDm97ssyzKvYygvcNkSl8hjlgk8yyD+O65V4hTjcLy3/NwZ?=
 =?us-ascii?Q?c/kVBHUOZRqyjRq73nARFYxC8+e1KTWYbY1PeTN0OeMNKWtOUV0QAgsPo+QI?=
 =?us-ascii?Q?8zTFBzMXdctxZ7y5eFyEoKypYYngsu+A3yodRh2b/5QPPN4owCxpejowOrT3?=
 =?us-ascii?Q?hupVAkOyNjgnjNTJI7CVxAur/pnrji4eiauVqMwcKAFa4NEeXB5NBUMNisLw?=
 =?us-ascii?Q?DqILavj9Cz3h6VFEcNv+DqNw1RR97bs1f8s3J/lEPY5llHivxEDQgXzA35Jb?=
 =?us-ascii?Q?tSSPpS/GrNAuvD4b87pkk2H74q6AYkgHslW22O89UaW/AiGkyQglOlha4d0o?=
 =?us-ascii?Q?EinVLaHxF3k3DmC8CtkNkSXm9Wcb5hB77hBvXx9FQhkgFHYV/HPA2sWuWkdD?=
 =?us-ascii?Q?O4Hpn2RoQecxvPshdoU905sUHBKGhCGtdAfO976EVmIKUl3c2SjOwts2ztWJ?=
 =?us-ascii?Q?hrno0eAtCETI44LJiyTLkprJ4HyCo82bzgCXh3iNiP609oOnMe6cJ9fhq68X?=
 =?us-ascii?Q?cmMBZDCa+6rUHXWVnECW4EQzpbeaP463+7TEX8QnRKmL536oxBkntZVrwY7V?=
 =?us-ascii?Q?wSyvnToBmuyhPtV9RJ/TkX7fp+46VfRBifyTBvyPJZgN74z/9PwfS0LEylq8?=
 =?us-ascii?Q?X0EjyXJ2bb5mUox7F/aoVCcwrV4UidgYU35nOm36LqRumTOdkYQdeScLpf2W?=
 =?us-ascii?Q?6V2zhOHxY67KUiVpS6VsHg51NoMMhaGiKH5vLUAhWoFRzOw/hPuJxVZ8E3H3?=
 =?us-ascii?Q?auGmBQ0joi8OZ7GfkLyoV7tI0qq+F7uhFjzUmNWOAtyEfX+j+pKNT+bt8li9?=
 =?us-ascii?Q?L3APM9gurTimHC46JHEflU/QSE+5SCuye4/rWmc7FwCJfFN0r2ts9RixNdbF?=
 =?us-ascii?Q?EmlZrrrIYdvyNhuJz0dGWsmt1j6vJHYdy9eLgPxYL/qzzjlmTQ7pzCHvOGM+?=
 =?us-ascii?Q?VuDmsAGUwUDH0q70j0eNxLg2dfE4lOKSybd6jlkMGKFjJCHIwGLp1Lijmjl8?=
 =?us-ascii?Q?8jQi8UD9mK5/2Mrl41VtBDMxtpGlsQZbvPJyV7TXPIVRp869U+YlOVDdVw4w?=
 =?us-ascii?Q?7swbwFaPpqDmhDuVf/5k1+Uh1/HWlVA8evOrP3SsRdrkYpSgATd8D+IAitdf?=
 =?us-ascii?Q?7EkyDl6joEb2Yu6Tq9VX444qCVocnEc2fa0sDOfbpX2z9MCcyB3cnj3LnDs+?=
 =?us-ascii?Q?66D3y/RTOA3dJ5UTw9znDPeJI5/L8lu6F2NdNeWnJnRF0O6uf3X1pOQom11p?=
 =?us-ascii?Q?L0IcPnxiNzWmzO+rN5nCaOSz8Smiq1QtXFpU9W4BQyna/wmaC/AEfwgb7NCu?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9uBIBuIFP60pxUa+vIWso9PcM9JevJXnOqYW6G/UAVbgM6l094Qrudt1oETGdnwohPUFmRyYmEr/sB5IVz4oCLcbShhn/u7aQg+7UWBODrUO89ZMbCH+dKA9KvRu9G0fDpiVf7qlhdsSV15yoTE+l/NSZV+QjA2fKnka8+yIw5RCO2Vg5eVZOALVRAwQKInxThTlLJi+7AMQnmwlrazQFx2blsUCwcteSBeOXrntk04/GFNBBf7EDeZarov/mI/cafsgxSybmrZoVKU6TvidH1mt10/6BvaNJIyJbRPhYZovVvc4TqmYVq+sDxSTLWYVWE221UOmdZnZYkjVkbAw3KObb1mhStRXHuqc9+NqrKgaN+ThTNXDL3YEvRboQjnR0dg1BJvecLPrL4EOqfEFJBRTHgegJu6cFQ6WuiDrpLICS/gig+K8IVTWtaDSeof0Qzleu8alSxjK6ymZ71X0RmXMl70xqudJJHqrV46+337xw40ivf94UrObVYLDPaIuv8XkL90Shb2CYbkRQ8fKAvgsxapm9ZX499HVkrzRD2Jm+TR9sdA6ku3MH+KQy6i5IrBoivpBpRs57XOehLEI2NqhiravdFL1LhNx7yUYdEk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f9b5a6-7e9b-47d3-bbe9-08dcf75ab660
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:13:36.1902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+uv/syuEVkmLQd0+Q6XGj32+sOHr6k//lHZQlwqV80xHDLZzmg+t6hI2iBNV3vU/5jXaTSStIsHA66jVQuIrCyl9tiuKQ2wSEdr6rTGOnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_04,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280114
X-Proofpoint-ORIG-GUID: uo4wIQ4Tu_rz-c6A29lbrFqroF-CQrvI
X-Proofpoint-GUID: uo4wIQ4Tu_rz-c6A29lbrFqroF-CQrvI

Userland library functions such as allocators and threading implementations
often require regions of memory to act as 'guard pages' - mappings which,
when accessed, result in a fatal signal being sent to the accessing
process.

The current means by which these are implemented is via a PROT_NONE mmap()
mapping, which provides the required semantics however incur an overhead of
a VMA for each such region.

With a great many processes and threads, this can rapidly add up and incur
a significant memory penalty. It also has the added problem of preventing
merges that might otherwise be permitted.

This series takes a different approach - an idea suggested by Vlasimil
Babka (and before him David Hildenbrand and Jann Horn - perhaps more - the
provenance becomes a little tricky to ascertain after this - please forgive
any omissions!)  - rather than locating the guard pages at the VMA layer,
instead placing them in page tables mapping the required ranges.

Early testing of the prototype version of this code suggests a 5 times
speed up in memory mapping invocations (in conjunction with use of
process_madvise()) and a 13% reduction in VMAs on an entirely idle android
system and unoptimised code.

We expect with optimisation and a loaded system with a larger number of
guard pages this could significantly increase, but in any case these
numbers are encouraging.

This way, rather than having separate VMAs specifying which parts of a
range are guard pages, instead we have a VMA spanning the entire range of
memory a user is permitted to access and including ranges which are to be
'guarded'.

After mapping this, a user can specify which parts of the range should
result in a fatal signal when accessed.

By restricting the ability to specify guard pages to memory mapped by
existing VMAs, we can rely on the mappings being torn down when the
mappings are ultimately unmapped and everything works simply as if the
memory were not faulted in, from the point of view of the containing VMAs.

This mechanism in effect poisons memory ranges similar to hardware memory
poisoning, only it is an entirely software-controlled form of poisoning.

The mechanism is implemented via madvise() behaviour - MADV_GUARD_INSTALL
which installs page table-level guard page markers - and
MADV_GUARD_REMOVE - which clears them.

Guard markers can be installed across multiple VMAs and any existing
mappings will be cleared, that is zapped, before installing the guard page
markers in the page tables.

There is no concept of 'nested' guard markers, multiple attempts to install
guard markers in a range will, after the first attempt, have no effect.

Importantly, removing guard markers over a range that contains both guard
markers and ordinary backed memory has no effect on anything but the guard
markers (including leaving huge pages un-split), so a user can safely
remove guard markers over a range of memory leaving the rest intact.

The actual mechanism by which the page table entries are specified makes
use of existing logic - PTE markers, which are used for the userfaultfd
UFFDIO_POISON mechanism.

Unfortunately PTE_MARKER_POISONED is not suited for the guard page
mechanism as it results in VM_FAULT_HWPOISON semantics in the fault
handler, so we add our own specific PTE_MARKER_GUARD and adapt existing
logic to handle it.

We also extend the generic page walk mechanism to allow for installation of
PTEs (carefully restricted to memory management logic only to prevent
unwanted abuse).

We ensure that zapping performed by MADV_DONTNEED and MADV_FREE do not
remove guard markers, nor does forking (except when VM_WIPEONFORK is
specified for a VMA which implies a total removal of memory
characteristics).

It's important to note that the guard page implementation is emphatically
NOT a security feature, so a user can remove the markers if they wish. We
simply implement it in such a way as to provide the least surprising
behaviour.

An extensive set of self-tests are provided which ensure behaviour is as
expected and additionally self-documents expected behaviour of guard
ranges.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Suggested-by: Jann Horn <jannh@google.com>
Suggested-by: David Hildenbrand <david@redhat.com>

v4
* Use restart_syscall() to implement -ERESTARTNOINTR to ensure correctly
  handled by kernel - tested this code path and confirmed it works
  correctly. Thanks to Vlastimil for pointing this issue out!
* Updated the vector_madvise() handler to not unnecessarily invoke
  cond_resched() as suggested by Vlastimil.
* Updated guard page tests to add a test for a vector operation which
  overwrites existing mappings. Tested this against the -ERESTARTNOINTR
  case and confirmed working.
* Improved page walk logic further, refactoring handling logic as suggested
  by Vlastimil.
* Moved MAX_MADVISE_GUARD_RETRIES to mm/madvise.c as suggested by Vlastimil.

v3
* Cleaned up mm/pagewalk.c logic a bit to make things clearer, as suggested
  by Vlastiml.
* Explicitly avoid splitting THP on PTE installation, as suggested by
  Vlastimil. Note this has no impact on the guard pages logic, which has
  page table entry handlers at PUD, PMD and PTE level.
* Added WARN_ON_ONCE() to mm/hugetlb.c path where we don't expect a guard
  marker, as suggested by Vlastimil.
* Reverted change to is_poisoned_swp_entry() to exclude guard pages which
  has the effect of MADV_FREE _not_ clearing guard pages. After discussion
  with Vlastimil, it became apparent that the ability to 'cancel' the
  freeing operation by writing to the mapping after having issued an
  MADV_FREE would mean that we would risk unexpected behaviour should the
  guard pages be removed, so we now do not remove markers here at all.
* Added comment to PTE_MARKER_GUARD to highlight that memory tagged with
  the marker behaves as if it were a region mapped PROT_NONE, as
  highlighted by David.
* Rename poison -> install, unpoison -> remove (i.e. MADV_GUARD_INSTALL /
  MADV_GUARD_REMOVE over MADV_GUARD_POISON / MADV_GUARD_REMOVE) at the
  request of David and John who both find the poison analogy
  confusing/overloaded.
* After a lot of discussion, replace the looping behaviour should page
  faults race with guard page installation with a modest reattempt followed
  by returning -ERESTARTNOINTR to have the operation abort and re-enter,
  relieving lock contention and avoiding the possibility of allowing a
  malicious sandboxed process to impact the mmap lock or stall the overall
  process more than necessary, as suggested by Jann and Vlastimil having
  raised the issue.
* Adjusted the page table walker so a populated huge PUD or PMD is
  correctly treated as being populated, necessitating a zap. In v2 we
  incorrectly skipped over these, which would cause the logic to wrongly
  proceed as if nothing were populated and the install succeeded.
  Instead, explicitly check to see if a huge page - if so, do not split but
  rather abort the operation and let zap take care of things.
* Updated the guard remove logic to not unnecessarily split huge pages
  either.
* Added a debug check to assert that the number of installed PTEs matches
  expectation, accounting for any existing guard pages.
* Adapted vector_madvise() used by the process_madvise() system call to
  handle -ERESTARTNOINTR correctly.
https://lore.kernel.org/all/cover.1729699916.git.lorenzo.stoakes@oracle.com/

v2
* The macros in kselftest_harness.h seem to be broken - __EXPECT() is
  terminated by '} while (0); OPTIONAL_HANDLER(_assert)' meaning it is not
  safe in single line if / else or for /which blocks, however working
  around this results in checkpatch producing invalid warnings, as reported
  by Shuah.
* Fixing these macros is out of scope for this series, so compromise and
  instead rewrite test blocks so as to use multiple lines by separating out
  a decl in most cases. This has the side effect of, for the most part,
  making things more readable.
* Heavily document the use of the volatile keyword - we can't avoid
  checkpatch complaining about this, so we explain it, as reported by
  Shuah.
* Updated commit message to highlight that we skip tests we lack
  permissions for, as reported by Shuah.
* Replaced a perror() with ksft_exit_fail_perror(), as reported by Shuah.
* Added user friendly messages to cases where tests are skipped due to lack
  of permissions, as reported by Shuah.
* Update the tool header to include the new MADV_GUARD_POISON/UNPOISON
  defines and directly include asm-generic/mman.h to get the
  platform-neutral versions to ensure we import them.
* Finally fixed Vlastimil's email address in Suggested-by tags from suze to
  suse, as reported by Vlastimil.
* Added linux-api to cc list, as reported by Vlastimil.
https://lore.kernel.org/all/cover.1729440856.git.lorenzo.stoakes@oracle.com/

v1
* Un-RFC'd as appears no major objections to approach but rather debate on
  implementation.
* Fixed issue with arches which need mmu_context.h and
  tlbfush.h. header imports in pagewalker logic to be able to use
  update_mmu_cache() as reported by the kernel test bot.
* Added comments in page walker logic to clarify who can use
  ops->install_pte and why as well as adding a check_ops_valid() helper
  function, as suggested by Christoph.
* Pass false in full parameter in pte_clear_not_present_full() as suggested
  by Jann.
* Stopped erroneously requiring a write lock for the poison operation as
  suggested by Jann and Suren.
* Moved anon_vma_prepare() to the start of madvise_guard_poison() to be
  consistent with how this is used elsewhere in the kernel as suggested by
  Jann.
* Avoid returning -EAGAIN if we are raced on page faults, just keep looping
  and duck out if a fatal signal is pending or a conditional reschedule is
  needed, as suggested by Jann.
* Avoid needlessly splitting huge PUDs and PMDs by specifying
  ACTION_CONTINUE, as suggested by Jann.
https://lore.kernel.org/all/cover.1729196871.git.lorenzo.stoakes@oracle.com/

RFC
https://lore.kernel.org/all/cover.1727440966.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (5):
  mm: pagewalk: add the ability to install PTEs
  mm: add PTE_MARKER_GUARD PTE marker
  mm: madvise: implement lightweight guard page mechanism
  tools: testing: update tools UAPI header for mman-common.h
  selftests/mm: add self tests for guard page feature

 arch/alpha/include/uapi/asm/mman.h           |    3 +
 arch/mips/include/uapi/asm/mman.h            |    3 +
 arch/parisc/include/uapi/asm/mman.h          |    3 +
 arch/xtensa/include/uapi/asm/mman.h          |    3 +
 include/linux/mm_inline.h                    |    2 +-
 include/linux/pagewalk.h                     |   18 +-
 include/linux/swapops.h                      |   24 +-
 include/uapi/asm-generic/mman-common.h       |    3 +
 mm/hugetlb.c                                 |    4 +
 mm/internal.h                                |    6 +
 mm/madvise.c                                 |  239 ++++
 mm/memory.c                                  |   18 +-
 mm/mprotect.c                                |    6 +-
 mm/mseal.c                                   |    1 +
 mm/pagewalk.c                                |  246 +++-
 tools/include/uapi/asm-generic/mman-common.h |    3 +
 tools/testing/selftests/mm/.gitignore        |    1 +
 tools/testing/selftests/mm/Makefile          |    1 +
 tools/testing/selftests/mm/guard-pages.c     | 1243 ++++++++++++++++++
 19 files changed, 1751 insertions(+), 76 deletions(-)
 create mode 100644 tools/testing/selftests/mm/guard-pages.c

--
2.47.0

