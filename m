Return-Path: <linux-arch+bounces-12131-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6CDAC7FDB
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 16:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A839E51CE
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 14:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4844F1DE4E5;
	Thu, 29 May 2025 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CtB+/FDw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a9KJNS7q"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A2A33E4;
	Thu, 29 May 2025 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748530018; cv=fail; b=qBiE1Y8eDyXiv++gzvR+pLf0gksy5ls7AZNO2hlAK4ABe4KT0zFQ0GfLYmdsd95FviRGstPcl1idyFEgr2vfd3g0QdX32DeWDGpoTr+aPKrzLnrCpa6bGfvpbUbIW4w4K0zQ2vraIrxk0xUqcaXbUqza6oxMWXTo4Kz/5sb0k3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748530018; c=relaxed/simple;
	bh=8pzzLPc+2YCHzp1LBMDU6mGqaGAZQdWtTBwtugL1Cuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hOD78ApXApl8az/tp2JyDIEep7HK5jjEmsULKvug8yvLLYVLLtG5gvk2C/VactgaIcyqvhWH6nO3N9vY6AkG9Bf1ZOWWq6fCxzT72DtOMwfGYZi9vA5neMO2EoA6Tgfw/2ypGRVMULbaQQG8D9HHCzkGNhS2x8XGa7RKPvkRN2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CtB+/FDw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a9KJNS7q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T7twHf018216;
	Thu, 29 May 2025 14:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ypCJQh3te1z/JoEzuQ
	SNiB3TzZmzzAEQfrBMsr5n6uw=; b=CtB+/FDwXCzlsUFv90cDcHX5KQAvDbsHgs
	uNelYfk4p6In/RQbYBPUPCKas3bY/A22RhmbOGHg2dCcAXNfa2WM51v4sTMX5RnJ
	+wy16BqHpL0E7Rt7wGLYdC1nmdVkGC4D3Ww+QMUl6aTT0jtM3X/J4TXlTW8jB9uI
	vv2hYpQayItyH7XXGfs2tKB62z+E/QJe/mJ+eds0xuhBDu8Bwh/vNIdrLSHRHMp1
	pxGu+EbvWEtDuDeunZ40wqFO5BzUUYJZS+bgYZK+h1BfbKG2mh/aaBpoyCdhucDV
	1ro7ueT3nHFqTzoDx7gyNP2mSkGA7nWX4ZKMFDHQUjUQMhIhh34g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ym0gxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 14:46:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54TEGN6H020382;
	Thu, 29 May 2025 14:46:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jbtht7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 14:46:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jk8h+a/dwOerOQwSHz3Emc3UWnQ4ihyyqbSzC/U7lLk2WmoOxlMjeOQ2sdkxCpl4uiqecgdUej2TZ8bnHcWw+c/FO8AFaU9oTJKdPS7/Gz3A1lLhfBA7nINZ4siCtOzqfMiP3sW/Q+U4Ogv9r9FqRunsbTBeY5V5U/9a+bVxlZenK+fhX0BwPtNXpSJ4lwafFJc6UmF1DdZGOdvvj6L22N9tSpfkPee7V6Vgq/xaJMamdb3q5HRSOmI6MzNmCdOvfCoTEvHqSJRSeBA34WaJ6ERdpGK9/lXkKxNAx3b9mv8tcezA1StyGU+dHk2tUsKGcuNAs7Fo3fm1lFR1TqP53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypCJQh3te1z/JoEzuQSNiB3TzZmzzAEQfrBMsr5n6uw=;
 b=Lsdjq4mMZq816N6NgcJzUaJ4+T/MOY1aA0PrlOXQ7nzM2KW7efmxlx/jzctv2iN2sBvGJSJs6u5QjXH7EJtD+WRXR4eBO57SBbiDoJO+u5cTPOavyo+giFDl0FiFfGes+cmyTxTKSqkDlWc+lupLA8Bp5OKio+tVi5EMh4KRfejBAcLqHH5lf7OVtum5q3ejB3FHf1qeg7NmYeQ9jufzSx14Rl613Xf9yP+plgarEDCrFlnJVVcwedZPHZrOPsCagFZlnlUVrafMaWZL0o99t4F5P6HFV+zCfJ/Rw6ar/LfNMrX2l8fgj+YttgvEFnlUVlcQHpzr0Oe1/BHo91YJ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypCJQh3te1z/JoEzuQSNiB3TzZmzzAEQfrBMsr5n6uw=;
 b=a9KJNS7qCrnSyoRuZaufAftDz/dOGFPOmcIUbiWOfxxmzu7lOZ/wVwWcsKIafsIixMy8TzS3xYGp9nFxnm778/itLo7RpFpBX1E90XM6db7NRcGiep7gXiBs8/Ldt1C/MDdCskhoTNLsBshJ+iMTERKEWygtMKEaDkWfOaYmCjc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7399.namprd10.prod.outlook.com (2603:10b6:8:11c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Thu, 29 May
 2025 14:46:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Thu, 29 May 2025
 14:46:31 +0000
Date: Thu, 29 May 2025 15:46:28 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 4/5] mm/madvise: add PMADV_SET_FORK_EXEC_DEFAULT
 process_madvise() flag
Message-ID: <e48b0293-5ccd-4205-910c-302b61b12b55@lucifer.local>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <617413860ff194dfb1afedb175b2d84a457e449d.1747686021.git.lorenzo.stoakes@oracle.com>
 <20250520222609.GD773385@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520222609.GD773385@cmpxchg.org>
X-ClientProxiedBy: LO2P265CA0435.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd8a56c-7dc0-49ba-57a7-08dd9ebf99ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1KIAZD/9rzR/Ik5sikFEm1dTw64JEngcW9kWT+FOIhBTZLouBctVzRHn7MXK?=
 =?us-ascii?Q?WH7lMRxqjIuHPAYnsEL4t9C4/p8yuJvaTTdcPA0zV47BNhtpF/mYnSbi81MJ?=
 =?us-ascii?Q?/dnuASKEIuQDHPSvqvn4hjZqjvuVJzsUkh7M2Yx/NxSmJgVBD85kePH06jdG?=
 =?us-ascii?Q?I7hbeQVQFWzVE/x4nZ1gYemhd1ikatzf5FUw/9w9+tXy4SP1yAq/H0zb5mQa?=
 =?us-ascii?Q?eP//12KAwx/qbBOYptWbZaxVKrZkFDNLCL5rFx+OvH7ayKI1/9Uyx2Ck8YqA?=
 =?us-ascii?Q?yaYjNwNnCuWc7RWc3wSwbEPLtAesR/LREstScmZmeHt3e+DX8tkyaq7XQAXW?=
 =?us-ascii?Q?3Pw9BCDJQHstCX4/p7D9Iv8N1XqkESA+NJdZhFwNLSQ1lZdpYMNp6EhVXNUH?=
 =?us-ascii?Q?qxsNFkjega0H94HcjKfkqgjdco9esssorxcLLJZgYO4t2sByZ6e62m098KUj?=
 =?us-ascii?Q?fROGm+6t291ZnVNqEIfTskajI3Q3WkxlnqEMENM1YPxqPzScNoZ/TFBAne2m?=
 =?us-ascii?Q?2BATbgbQRSLFRnNdSH6+9E7CfkQGXYJo2RpdB0KCulpjtX1PR3d+nk0kDxWK?=
 =?us-ascii?Q?THo7XpRa9pHSM8KXcI9paYMuiDGzdeLo2j6qfCh1ws0tj3hU6DgUN33NyPoV?=
 =?us-ascii?Q?8m2cRlTGOW8cKo+YPFzYIvpAydIOI/bAl9Mw/rsvB3bFeP+Dn4CbiHeZ9ka0?=
 =?us-ascii?Q?FNuCR66nOJAw1PfVjXehErUhJHKwr+Df6RkszGwAj6LNLInsYUT4uNbWaO9L?=
 =?us-ascii?Q?XFltmNbtItV6lLqLy+TS8WOuUKPNmBfS7nQEJUownDEmsmT/zQzh2k7lGw7b?=
 =?us-ascii?Q?5oIAdx0B64HSNmBMLz1LiBfXnL4hUJC+XFEjZxn44zc/Gysu+/3la+7mEm5S?=
 =?us-ascii?Q?yZfWiw9JvrK+nymdWCKdYL9eTgkhdBFvhr70NF2y668a24MjRVfLLpd3s5ug?=
 =?us-ascii?Q?HnPPWE615xPPPMTVJnr2TxB1jduJEnpCRuzcbGFz5vzJTTzJtAlnC1FRi80U?=
 =?us-ascii?Q?It3U7BQ6G+VnIyyuG5tNDhvtA/XA25VgryxyQpLIpEqkOCHxc9W4Sj5f/jCx?=
 =?us-ascii?Q?Q2hKL80/ouN0O8K1GAbtq1OU5r3WHGq+RNCeF3UujpZlWdJEB2dnUnUJO3k6?=
 =?us-ascii?Q?veDZEatGO2peNyUtcCranpuq7nRYvK89pY0lgYAnxkJKGo+y65b2aUvHh/Hl?=
 =?us-ascii?Q?hAIk43pbHFuZII/ieokXTeK4oUYeGYXB5s7MzB2e++dnb5idTKzl+kG04NAx?=
 =?us-ascii?Q?WYpueRu734z7vVdXx0ubAtKXGi8k2Z9nUlEL+/EFjRJcLiu8WJ0FqxWX7Y00?=
 =?us-ascii?Q?zF0FBvEai9WC/tXSrtd77ds1JTYCRxBd4VwhmyaJXUlTciV98dAI0K6c0KbO?=
 =?us-ascii?Q?A7BrkY6sA9+YkOvH3I3cBRys2kxvjwQzdhkj/eYzu1Cj/YXuDc5rAoMfp5LF?=
 =?us-ascii?Q?4bWoIYHOeOw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7F91oHbGlsI+oHpWU7WuFq7Macx/F7azzbuP2Gh1RtOJ4LUTF8tDWFy7GCGU?=
 =?us-ascii?Q?MYQYGQTPOnBgJg2lbb2ssTt8pg9zWuSgCaZcn7Icqh9ypoD3rWz3JP6NPSgu?=
 =?us-ascii?Q?weOHQbg6VUmpAJONWBmNZ/xpwRr40c9Vg+QlasBz3i0Q2d/mgV1hvl+09rkv?=
 =?us-ascii?Q?UcXTSX5BXRV4s6RfKWPVwZ7Xn7msgI0hpiaKaFGBCzfKv302WfjVEYHSRNqi?=
 =?us-ascii?Q?DqiPBByNRSwKBAXxwhCe6m9jWVAmYTaeOLsEvquPA+o/AXvA0h4yyZtcEtIp?=
 =?us-ascii?Q?Swlqlwi7Fz14TMjwXiv7vVQsxL3G3Iu0dYxrBehIOdcq4CEt80C+YKi468xO?=
 =?us-ascii?Q?EgrE2s8N9YOFWv3RPUPd0ox1nUMTlBYr7xgSipTHEhZJrCUPasHJnVWvVXBC?=
 =?us-ascii?Q?29Fmx/AevdGcA7cPSI7h8yffGtGU//CSvBaTKK6ynaqKUwyk+48UwXtz8x5F?=
 =?us-ascii?Q?Rmkvi2o9QkhOHc5ejQgX1/XlAo2Kbxvq3Mq6ieqh1zRHvRbh8HQBr1IRD9Wm?=
 =?us-ascii?Q?xxPPArwcZ5aW2FeG2oHM2cnCc4e0VGPVbye4sVJ7vWrhfURQ3sx/pl9MXn8c?=
 =?us-ascii?Q?j+uyWS+9xIhKCqOj3QXG390gkIiTOGC72nnpUbe45deoQdoRTmi2eIUsVpZ8?=
 =?us-ascii?Q?Nik1cCPZQgs6C4rZlgf6xvdICdxE4Qf7oo+OscPLEuAuhD484XqwLoZzhYa8?=
 =?us-ascii?Q?q5bPpcdn7FAzfhu5oRmeWuqrv/oKy0387kRK9+pFLMkkMevlMvFh5mHuisAT?=
 =?us-ascii?Q?xw9zKUZ1CYgAvZLpRfwT850ukbbQEo2Pbq7Bj6S2+xWYBaBK9QF+Oitmj/uV?=
 =?us-ascii?Q?4SoYgtVb9O4s4TZntlbyZ0FvQUJJ7BXBniLBoWdFcPAW6xd3YD4qo2XolMtD?=
 =?us-ascii?Q?eUpawVwoduo152fIW4ga7O/FNbfdf90kL3yQDNf3iwDCqhpybWAOYiW7yb6v?=
 =?us-ascii?Q?zCzO+i19lZHw95ljK4bK7KuMTfJ5YJonurtQA1NiuBfiQmO98OUiOFujyhjZ?=
 =?us-ascii?Q?7QDoQa+g1Agyro+VK9RA2mfWiIN9BcmJSpEI/IjWuxndEneIp+LfK0yx6KQC?=
 =?us-ascii?Q?7rzzTvStzjPliFyNckHi5A3g3KOIOfEmYrj4EoMvaKWHB+GrHmJJWO+045rc?=
 =?us-ascii?Q?+WYoPPo7Va+JwsOjtOGNchmX4K7WgIJuHwqLZXza2hU/iKcWBQ74vMGW/R6X?=
 =?us-ascii?Q?PVs0uz8P2sBd8UCj7XlGLhdoTnW6OUTu3okG/CoTghqYUPC8r1Nmz/pSLG+6?=
 =?us-ascii?Q?dZJT8qgAGPTPr9IU9fyedMmYx3ikz+mKIxzBCzui8tW1toy9eq7kSpjw5Xr4?=
 =?us-ascii?Q?wrbg0lVYNejGbCK1rWXR40gTDtZSXrVo7JSBbex7zX1kjm1DH6HGw532Z+db?=
 =?us-ascii?Q?cKSpxctKYpaEttZIWdkYDxMTPRXzmosgtCWrMyPcngXnSYkG0mEAv51VicWh?=
 =?us-ascii?Q?fn/5qwfPhvXF69oHindSlgN9m9JS8GeARkdP4URMKfhuZi8wkzltcDyZ6is/?=
 =?us-ascii?Q?b7auOsOzEBQILFcV2A9unLjV+eQs/MxyEptpe5oiYLdr6Uyhpq0O2f/9w5r7?=
 =?us-ascii?Q?fpZU7t36AVE8GxpWGBKhST1OOKT0g4OGsmRvmsBqkEaPeVTcRD9J+KbeO5yv?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z7a6MTDcIgIg15d0hqVDWZwru10po+1QEmM6e6RP5CD/hfuXur51bCC+Akqsd/zcto8Bij6OFhASnDqVxQyLzNk9Zu2TqYPNlkx+lwdDsc+e8xNmXTNi0yPyqYQUgas37VhvuYqmcIKnBNoPL1sszjCH+nQ5NruQm3xauKrYGfhPeBXiC+jVRDs7NzH1w/bkSd3jpake0LuXXXtmH+211aS0l+HkYBdEJWwQjd9qB/dzy38U1bGyoeq1SIHVK7qBE0pox4Lqlltl+HcszAVSEgGRoppHckwxHZ/LU7vGVyPTio4VJIazHau60vQ6kQeYBY+o/VC8/j993VqB5b+ACRKM5rskc0+2ryzeKVMNVQzwjkYIu5d5IpUbkve2ypPylt39uwX5YMJ6l3N7nCWyZu26AFD4iOOaoHbr7EPxMEyALxKd2sWHjvt7CK2WhUYsMxPxqenf719PHwVk6vfdt+3ffm+6NmN0aoB+N/Gex17pjF0Zv/gTIFPYaW0z8G5fMF86N9c/FlrVScolr3wQRhfdVFkZK52tA5rTmEpC9VKxf8DOQOxjazUeMcNuRYrqfbyLpa1JjCU8IzFOnJVik+7xjyVdM37xxNCik+EvOjc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd8a56c-7dc0-49ba-57a7-08dd9ebf99ab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 14:46:31.1578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dx1Cih0jJsl4/cajqnh2srgpGoi7/7ZjEX/H3Sgrr22pkrzaVo5P/G1FIV3ksW4bqrf/JZORwXLAW3I/HIaNe5STubFoRs/w0M8I8Tzsp6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290143
X-Proofpoint-GUID: Q9aNuMREy-BI4-O9DxqUUx8Gly0R-lXD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE0MyBTYWx0ZWRfXxx/Tzef1byaQ kNIqhlPaivJZ2phoEOdq3DhnkDCjzXhDa8Jc7KfjD/3VT1WHWfSUH412DAf5G1L1jZZldhImdmX 6rU2QgGuyypR3SDedHszHtz53gxnTnWkMeu0vqcudYcXX+5KfxIyi9CS8J5reDdw9QiqGA393Gw
 P2eMV6WZfigdvZc9JgfYMWinjVRBCXeD8lbknK5muqsfIQwglLyXIVEHW+sTTK0NUSwGuapoqsM zY251Dtg48s/WEbKtT9NzNMo2yBkQDGmzLn6J0Lxn3MPV0iet9UaPzHJai2hEnotrrEEr4iX2uP fxmFmH0VnvYahZL7Kg/nzlRNSo5HCxol995alMEfX0x0IeHc8DZm7YmfN/4b4WocwtgMOtuPdFG
 /HMS45kpKZpdnhLWEVjvG2A+RWaRhsRPSyCGDz6e2Sq2xRMCN5LFbLrzD9a+WxXyodXZVkp0
X-Proofpoint-ORIG-GUID: Q9aNuMREy-BI4-O9DxqUUx8Gly0R-lXD
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=6838734a cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=lj4QIKvEzyil2nNL0GQA:9 a=CjuIK1q_8ugA:10

On Tue, May 20, 2025 at 06:26:09PM -0400, Johannes Weiner wrote:
> On Mon, May 19, 2025 at 09:52:41PM +0100, Lorenzo Stoakes wrote:
> > We intentionally limit this only to flags that we know should function
> > correctly without issue, and to be conservative about this, so we initially
> > limit ourselves only to MADV_HUGEPAGE, MADV_NOHUGEPAGE, that is - setting
> > the VM_HUGEPAGE, VM_NOHUGEPAGE VMA flags.
>
> Hm, but do we actually expect more to show up? Looking at the current
> list of advisories, we have the conventional ones:
>
>        MADV_NORMAL
>               No special treatment.  This is the default.
>
>        MADV_RANDOM
>               Expect page references in random order.  (Hence, read ahead may be less useful than normally.)
>
>        MADV_SEQUENTIAL
>               Expect page references in sequential order.  (Hence, pages in the given range can be aggressively read ahead, and may be freed soon after they are accessed.)
>
>        MADV_WILLNEED
>               Expect access in the near future.  (Hence, it might be a good idea to read some pages ahead.)
>
>        MADV_DONTNEED
>               Do not expect access in the near future.  (For the time being, the application is finished with the given range, so the kernel can free resources associated with it.)
>
> where only RANDOM and SEQUENTIAL are actual policies. But since those
> apply to file mappings only, they don't seem to make much sense for a
> process-wide setting.
>
> For Linux-specific advisories we have
>
> 	MADV_REMOVE		- action
> 	MADV_DONTFORK		- policy, but not sure how this could work as a process-wide thing
> 	MADV_HWPOISON		- action
> 	MADV_MERGEABLE		- policy, but we have a prctl() for process-wide settings
> 	MADV_SOFTOFFLINE	- action
> 	MADV_HUGEPAGE		- policy, but we have a prctl() for process-wide disabling
> 	MADV_COLLAPSE		- action
> 	MADV_DONTDUMP		- policy, but there is /proc/<pid>/coredump_filter for process-wide settings
> 	MADV_FREE		- action
> 	MADV_WIPEONFORK		- policy, but similar to DONTFORK, not sure how this would work process-wide
> 	MADV_COLD		- action
> 	MADV_PAGEOUT		- action
> 	MADV_POPULATE_READ	- action
> 	MADV_POPULATE_WRITE	- action
> 	MADV_GUARD_INSTALL	- action
>
> So the vast majority of advisories are either one-off actions, or they
> are policies that naturally only make sense for very specific ranges.
>
> KSM and THP really seem like the notable exception[1], rather than a
> rule. And we already *have* prctl() ops to modify per-process policies
> for these. So I'm reluctant to agree we should drill open and expand
> madvise() to cover them - especially with the goal or the expectation
> that THP per-process policies shouldn't matter that much down the line.
>
> I will admit, I don't hate prctl() as much as you do. It *is* a fairly
> broad interface - setting per-process policies. So it's bound to pick
> odds and ends of various subsystems that don't quite fit elsewhere.
>
> Is it the right choice everywhere? Of course not. And can its
> broadness be abused to avoid real interface design? Absolutely.
>
> I don't think that makes it inherently bad, though. As long as we make
> an honest effort to find the best home for new knobs.
>
> But IMO, in this case it is. The inheritance-along-the-process-tree
> behavior that we want here is an established pattern in prctl().
>
> And *because* that propagation is a security-sensitive pattern
> (although I don't think the THP policy specifically *is* a security
> issue), to me it makes more sense to keep this behavior confined to
> prctl() at least, and not add it to madvise too.
>
> [1] Maybe we should have added sys_andrea() to cover those, as well as
>     the SECCOMP prctl()s ;)

So sorry to have missed you really excellent and well thought-out reply
here Johannes (grr mail etc.).

You make a really good point, and I think this does overall, sadly, suggest
the concept of a 'general' madvise() call while, in a sense, 'neat',
doesn't quite fit.

I do think it aligns well with a dedicated mctl() API call, have sent out
an RFC discussion thread about this so we can determine if this makes
sense.

Thanks, Lorenzo

