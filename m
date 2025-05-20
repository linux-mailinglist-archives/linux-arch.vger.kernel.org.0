Return-Path: <linux-arch+bounces-12039-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D405ABE4ED
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 22:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C81AF7ACE15
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 20:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5140426D4E3;
	Tue, 20 May 2025 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dIOxByiT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PbPpFgRM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD8182BC;
	Tue, 20 May 2025 20:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747773602; cv=fail; b=hVs7SdFEfRhdZ8E8HODy8J4MRgmGq3IFGHlHCNtLqQ+To9L1cdQzt9w+etXIGa0khTtDAmRqHD2+2JDtd9x2BwmZCMLJzVkR0dea3U6w/qtSPVtIlemttZJSLya0Ion89m6MZzkAjER84x1AIAiXkZi1K2VfyXxiTxrgDsrRfeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747773602; c=relaxed/simple;
	bh=aWh/b5zvlFApWzw6mX4xc4qYcb4c2wZHmZa4pTOYKyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lBx3iexsOcMwFfb+Gg3NKFVZgQ1xqGOkv9/J8LB1SQ0mHlfcNCMunKmv+YBEJr2XC+zuaEDUBwiaaaiy+Si2CsGBXFOhh7y93Gkuv96BpRIAgOEVAK4admwYyEL0q5U/AbN0zCzTF36drBnipOHh4kwnAF4gIhRd5wy2+Q5Q3cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dIOxByiT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PbPpFgRM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KJmEu4002222;
	Tue, 20 May 2025 20:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KSxDJHvuPIJbJQv6mE
	6sx1bv08E+rp5cw4pVumRjX6E=; b=dIOxByiT97pwv5p8oYlcrkgfE/li6piEOe
	TNApZZ9lq2TuaHlRvXNY2jVX2n13FAqhrsvH2z2wo0vJTacpULHe4ZWBI0yHsM10
	EQP8Otb4f0ZChUNFEgPpj7wR17eIJXBh3fuYyW47P3EsI38eDXKgn7dauAgFnh9Z
	VTm4aNHnUlrpC4YMHnhFEGdCYO7zmYYKnjEnsEqXBR2PQ01a8/luL0Pn58FiK6/q
	k+OQKWVKAOE+84zNse5GzP0odADOoUcxphDyt+IkIKvUxmefE2ANmirPisLkEPiX
	PQrKVHMRSx1udcW4VJPWPy/RM5SvEkMPJaMYr0lBJzRQPr4Uf3gg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46s06sg3ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 20:39:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KJqg94033016;
	Tue, 20 May 2025 20:39:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwemhf0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 20:39:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPcIILEmkH/5aP6i38mcQEVWK3pCPk8HsGItRIEDPOG7yZvntsCSDojYul/g5R1IElTgdkQDcPogL/IbAVc+jaqOqcIdxaDDQNopbRoz8o7lIF+vmXRHzmGVLe9yHsCTthagr9Ty1W8O2Smff6q7nY/BOTrc+wA+hnmHWJ1h0IBBy+Zh2WGedQj1LlgPaSRJyG3Rb9j4MN9+kZ0fY4lrj6rtRapnU7X7SdXhnaKIoYyQwH1LstnEIryrgD7uvpuUESyyntcxmPLJBq4d/oEaAmDQbdxoFGvH/WD+qWNmEpkFN/dfcCMus5S51NCtZJhGEANXRZOqORDhUyFi8PvSOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSxDJHvuPIJbJQv6mE6sx1bv08E+rp5cw4pVumRjX6E=;
 b=MZUBdUQSkve7ejl1OwIW3vsNA563cA8wbhavBTum/2lrXx9/7SoVHFa5a9hTHnner4ALndEudoarhNtd2Ql++5ZPbkm2ZEN7z0Y8v+pS4j6KBks0bG3DcZbBJkX2T/IiBdhyT/x0SmPyUlNpPODtTl32pcESPL57MrY72GzjMsLDk0KBbGm2WI25wvuJXko0Ke2eMvxClrTPBZUzSOMN8PqEVgFODQPop2LnEZr4ss9pMNyLTuwJifsdfWP/hPUrebnvsEPKkk4II/kqX7k4WNWKla+9xQHVCiH5RCkV4lkP87ao0HeMSUIaUhlwkObzQCmQJiKBvXXoVCMPZJun4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSxDJHvuPIJbJQv6mE6sx1bv08E+rp5cw4pVumRjX6E=;
 b=PbPpFgRMs519zsZQKR5vuy0lHzhBCHEsQhNPp3Mn9HnWLdx47gTx3sGKUlQE4kVT1478Cma4mXDWf3IVM10oRJRyvFBmviuufZDiV1zhhOkh+MObYPzuKuFQe98dF19igH020cdEhefb+USeluYCkEdSrD102H7y8SzXcD38jNQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN6PR10MB8000.namprd10.prod.outlook.com (2603:10b6:208:4f5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 20:39:39 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 20:39:39 +0000
Date: Tue, 20 May 2025 21:39:37 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <e8c459cb-c8b8-4c34-8f94-c8918bef582f@lucifer.local>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
 <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
 <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
X-ClientProxiedBy: LO4P265CA0188.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN6PR10MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d85d4b7-3b2c-4900-4ade-08dd97de713f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+AILJ3DZF6ndPaqbxXJqI6poHGq4asF6MWF7dUHg9suBJmVVWgFnfAsWbvP3?=
 =?us-ascii?Q?rLTsguy3yne24IrSpjECIBdUN1117ju4FHLA8drpL+O0gIEu+hRb0PID6xw9?=
 =?us-ascii?Q?IzcCCOcLsCbXGvNDipwOYz3uiCf2NDSAXurUjB11bLJFvkV9DsyMd0WrloBK?=
 =?us-ascii?Q?tZCGGFpSXxh61cj/a0EvUrPq5+GRPwCyx6ZvHg49MKrou/aqXgzkkqTPgJBi?=
 =?us-ascii?Q?jwdr4PWkokTLr4IBhmcqZy2IVyEEo1kPdXjFAQEvVamFTzVloWl5RVtBMxjP?=
 =?us-ascii?Q?d5WuXasbqk+PYA5jnIl6/rik5YfhJBDNn8Vsza2LysYxJxqsNKTebim6uSL1?=
 =?us-ascii?Q?Evuqxy4ZMPcVfb3RmB2PcBdHFSluR6v13NufMgAcRIGy5ZYTTqpSfIlePQOZ?=
 =?us-ascii?Q?ElU0IK8hbf3z7pF8qddWsFucchKRA8JQmmx7hpW9xn7E9o2JOXkotzHQA0d3?=
 =?us-ascii?Q?G058PQ2Z+k8CY8ucdAGh04nrckYEYVYCKAZ8499vphRzOdP1TYKSxSi9coTn?=
 =?us-ascii?Q?95nvxflZ4oA0hHCh5ycaYZLQNqM0Gz9Rv8M+ILPlcJzbVJfFdaZmNcLVEjOa?=
 =?us-ascii?Q?3eGfopbV1j7bY1XlxYPWfh0Vr5cbR8JSNH0257yU0oCnEfu86B/btrEo6DST?=
 =?us-ascii?Q?B8d8sQAuheyg3/xmanAru09wNzMRT98sX2ldY0VwBLwirnHXqAl2BwQwXTSW?=
 =?us-ascii?Q?AfJpvDYKK1IJGcwHJhcaQwYOwwLmMJRNDUwWha6Q3ZPaBycPfRtqZRiF0thq?=
 =?us-ascii?Q?9BLveoW/sSOhayX/Kj+2fBbkLCqVSF3BadV5cCDyFvwrzRyJc655HAizJR5V?=
 =?us-ascii?Q?tc66SEcNQrPE4jCG03qb4HzTsUR/VSU9iaJ//4vYcfbDJe4uewshw0/cloSm?=
 =?us-ascii?Q?U2E4XTgLI2WAKvCgdYdhrQAEmhVH6YTReiIgLGZRBRRmIhSSg8T79JZpNKOE?=
 =?us-ascii?Q?mzT57VuXRe58bUIhS1BCKMLXZvnjLi9m4+DbEHhqxxCRGzKzWFPnBDAduLjI?=
 =?us-ascii?Q?qjGtpYk8Lny4DHbRnQYrl5zneK5JVZqRbNPbJVE6yawa2tbjOypuFxkXSRXI?=
 =?us-ascii?Q?azk/fIFeyMxSkBkxjDFI/9hYgktPf9iPmkpoH0vgGqZmrsTIJRUxLxjjbYg3?=
 =?us-ascii?Q?xL+GCUZDpb1SOgLOz/C+WO7TyfE/Gq1JaWvtREJRQ4IFZ4nRtpBDTRxE4IRj?=
 =?us-ascii?Q?fI3R1zsaAbmau0oOS4ZTe9EEnVBE9I021e8SsXloxtUjDtBBTnraXr9j3gQN?=
 =?us-ascii?Q?vVR59M/hv9xU+qy/Gwzly2LyxVks/JDH1EsMHj5EARonKX4IR/vGhgSHYXGn?=
 =?us-ascii?Q?a1kdlEoxrj4pznM5zh1jwuh3veEQYTxEMmWCEY5dhSYrF31UP01UuqxYSIzv?=
 =?us-ascii?Q?PPRXGHLTMxVlu1hSZh/WOEn0Z3UD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QnRxWHKk/RjzJDtbTlm6rW843TOmKR+A4vlI+2EMItJ4JbBJ29lvG8IToXe1?=
 =?us-ascii?Q?uMXLsVwnRBbnNIAtWcaa2sK3mqGtO69DA2Y5kwB4OsZQqa8wTaJ9XlCxKGUC?=
 =?us-ascii?Q?O+yGGMjECa1W/cQQXUv5J+AFkMhvZIWzAixrv/EHOXy4gNe516emNDlr4owm?=
 =?us-ascii?Q?i/ltIXCJrdiAKDJf6a26pswTTHwe/nyyZnZt5/Z9sHNi6gzWkev5jX1bmP/R?=
 =?us-ascii?Q?ChXaYwPUVIrXQiImnO69a6YCt4uKcLyIbmXJcpLuaJUyYJZYdOz2fhJWRaHP?=
 =?us-ascii?Q?k67sEb1Fo3yIy8z02FFNTTOjkyBk2yo58G0/A2jT/ZGDqg3uJNszFsPa6W+6?=
 =?us-ascii?Q?72qZPxuIdr/c6TF5yj0hLzkDwCzjCQat/my/1on4WV1rNPjqb5D50sOgZTV8?=
 =?us-ascii?Q?kom0i5eqUwP1puSxmlIWQPf56hX8WeN1Is2w0pjpQz16Efaq/fuu2lqblfGx?=
 =?us-ascii?Q?ZceKaxEVICj1Fx3McRcETEzXNlfpdXNxIH64RkJSz+0EBcvnKHbygojZ0A9C?=
 =?us-ascii?Q?iBoubpS0eAtXmw44EWz14OPILmgwjF+HHvQdC9PDUHWmE7fr9FXiW1+1BTtw?=
 =?us-ascii?Q?u7x/x4zxHqL9SfUTMbH3viGLBx5Af4oyEeEaBjB///k7qCTgQqi+Zv6IY8B1?=
 =?us-ascii?Q?wfnpEMJo/WLpxPUWGVsLHzM+fOIcLkg7aSMg5rn9aiuR/9IQ1pZ17bRVzgcP?=
 =?us-ascii?Q?WopROXO0olw9gyS77D6H+xK6RhQd5dEFGoNjqkzwJaMTATEMvBUt9P4xQOZJ?=
 =?us-ascii?Q?wsNjpQUldf1DUpQbwn/iy6yCSB5ohxlAj00+t0uJhRKkDDyGApeX6lMufZ2Y?=
 =?us-ascii?Q?dz7UI+PJtD7jvi80/68D7rol5/0KwUUsEB3zl9Q4kAUYd7lMtGTqZw92U4D9?=
 =?us-ascii?Q?k3LoVYd22C52GbXnuT7txnKDj1+tARCfcHdCVFS66PWmzKk8+iQLWB9ZfuPF?=
 =?us-ascii?Q?hJFX5UozPuZkIo1aM5AQ8cTPLdKzc535SZye3RsEkbotaim3ZvT+7Q123B2N?=
 =?us-ascii?Q?i/ZBOqf5M47rjmZNlK2DZpTJM8ChMddZswNm+MNgITDUt43nzTLVWWERQ7aw?=
 =?us-ascii?Q?wiY9BuyXpe2lQScIVO3b+bitZb4bgfPTNI6mo75aGkKwb0OqkWMyLOuoAd3c?=
 =?us-ascii?Q?JYW3OeKj50JlMuUIbAqK8D9jH1QZzMFYlQOsXKH92llMBuZfWyrtRGXn+nDK?=
 =?us-ascii?Q?JDp4/ufv1jimXei77Zf0XN6seWK4O7adfsSZKrEQ4O6nOh2RwiO+3YsiBg5R?=
 =?us-ascii?Q?I6AiNTfkxGWAShYZapRtQLDNVL2iy/Y/iUsd5lEs4n9LmzNGE/2BBoCxupek?=
 =?us-ascii?Q?WaoA8T4AdwvF/aa+Eget9nhgaJxX5xBCqxG5Ok3Y2kB1VMRfFr2iVp4uLy9/?=
 =?us-ascii?Q?zfNlJE8ONdivVjXR49XJ+CxJpwKrXTbfmgKXyVBfxYYRUsXB00PX75pUEdck?=
 =?us-ascii?Q?Ara/3YjFWZ1ULhcue8yG6L+hGVNI7sNDX1Wy0BQQ+cIHZ4YMxPLpn7N5AR2c?=
 =?us-ascii?Q?yjIJHpJ++PklUHUhQXa0GAgLqIfK8AlHMGhOjpevu7P9rAT1ZarGowS6etcU?=
 =?us-ascii?Q?+dWtRorRZ4fb9u1vfU2yOJvc4Wt29pEOxdXBd0hL5QNxrWtvAG31CDpkmOVO?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AjKwV0DZgtYQBw55QDESJAGbT2GgrHrIVC2CmIIpQYxVBkQ49eOa5SEaE4JQQfGO0RGXqI4v1G1os76W+v9bAgaci4W7S/j2HiGnwjmI+I0FBKNHnjTG1F62gMPMouA/+v3F510/vl5xC2MkSE48C5FhC2coRgRifl+VICGHxlacW3SeFRG5NhghH26JjJKHNVX3BiL7A1kO1RHRv5kLDKXpQNLV6S8V3s1aJgdzw3kOjDsuTL2tMfWgihybJ7DPo1ArcIbQQ1a3EgoggSLIeJ5nJIbTgeuf3idP0zErFJVQbIlJskUUnPGL5zH8lleHmz5QALQvgF3iA3UH+V7xPB9D46oKSzKVqWHrx4cwzGpj65pfInHq1SzVhJuuXiYpgixVKGg8goe6TAx0ca5wHGxzineYj7GwU8Il+Dh4e7EHKc+ORONQSwlM0bP9nAYgfJ4Y2BfHVpgk4TSU7nPusgkwKsbVV63mjlm8MQEaOQRj46DcjR3ld6P3XWhjz2bTrxl40qxSAQ9q9PcEBBgKaJw83uz+nUD8axPHVBRwivMT/4j4m46aTFAbN/lACblntzM3G+aX4FgnEvaom2TdiF3PtGU9U5ALBeoafHImxtU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d85d4b7-3b2c-4900-4ade-08dd97de713f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 20:39:39.7076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28iehB9+4MrghQxVX7eTvGVSsIKOTch6LaJwz6QZE5K9tlEZKxVVmSatcI7L4woqHtRtKWZw2g9UvyWw7bcfbi4+/Ogb9yfpqHw/rNxo8nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_09,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505200167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDE2NyBTYWx0ZWRfXw8kYseYo01lq lo5Tt77nta76Av5Yf6CvGwv9h2q2wZI764+9PjN/enhFIIT7QCvVJIFLDyGr9X1itfVBFJxcDTQ 7FFgV/u9mOrsHki8Z6Jwp31zlP0H1zuHw1vFtsJHsJA5wKrLpr5pdcEoVwJqGjYIcJFb/Pbf+70
 v/4uFZqvm+3g+WztV2M4V/rUafA/U5V1rXAhgY0uP/75tAc1RJYpM04hOACaxxXOgLI0hTegIrU Vl/WgabylLLa/qE9WbKTX9lGOQ+Zi7hnSEZkgD9iK1/jdirRBMpWh0Nr6DkdEmHyoh0BNLRHmXJ 7UCj0lgs8hT+suu7QeuWA5tj+Zmnqyl+Rd40eROSY8AnM/vsZbenDtk6EtRNGXHe/4if4kZValo
 Zp24r6EtVvbxmE+1UuDK7/xAYN/NJqUyBjNyPbsTIvd/pf7z5nMLVHxpmHHtO6Hs2WnIvE7V
X-Proofpoint-GUID: dc33TiXoZmv4lOZl9TdzgRUwHfU0-Nmj
X-Proofpoint-ORIG-GUID: dc33TiXoZmv4lOZl9TdzgRUwHfU0-Nmj
X-Authority-Analysis: v=2.4 cv=dLOmmPZb c=1 sm=1 tr=0 ts=682ce88f b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ARcYTqTRiNuWtwEJA3wA:9 a=CjuIK1q_8ugA:10

On Tue, May 20, 2025 at 12:49:24PM -0700, Shakeel Butt wrote:
> On Tue, May 20, 2025 at 07:45:43PM +0100, Lorenzo Stoakes wrote:
> > On Tue, May 20, 2025 at 11:25:05AM -0700, Shakeel Butt wrote:
> > > On Mon, May 19, 2025 at 09:52:37PM +0100, Lorenzo Stoakes wrote:
> > > > REVIEWERS NOTES:
> > > > ================
> > > >
> > > > This is a VERY EARLY version of the idea, it's relatively untested, and I'm
> > > > 'putting it out there' for feedback. Any serious version of this will add a
> > > > bunch of self-tests to assert correct behaviour and I will more carefully
> > > > confirm everything's working.
> > > >
> > > > This is based on discussion arising from Usama's series [0], SJ's input on
> > > > the thread around process_madvise() behaviour [1] (and a subsequent
> > > > response by me [2]) and prior discussion about a new madvise() interface
> > > > [3].
> > > >
> > > > [0]: https://lore.kernel.org/linux-mm/20250515133519.2779639-1-usamaarif642@gmail.com/
> > > > [1]: https://lore.kernel.org/linux-mm/20250517162048.36347-1-sj@kernel.org/
> > > > [2]: https://lore.kernel.org/linux-mm/e3ba284c-3cb1-42c1-a0ba-9c59374d0541@lucifer.local/
> > > > [3]: https://lore.kernel.org/linux-mm/c390dd7e-0770-4d29-bb0e-f410ff6678e3@lucifer.local/
> > > >
> > > > ================
> > > >
> > > > Currently, we are rather restricted in how madvise() operations
> > > > proceed. While effort has been put in to expanding what process_madvise()
> > > > can do (that is - unrestricted application of advice to the local process
> > > > alongside recent improvements on the efficiency of TLB operations over
> > > > these batvches), we are still constrained by existing madvise() limitations
> > > > and default behaviours.
> > > >
> > > > This series makes use of the currently unused flags field in
> > > > process_madvise() to provide more flexiblity.
> > > >
> > > > It introduces four flags:
> > > >
> > > > 1. PMADV_SKIP_ERRORS
> > > >
> > > > Currently, when an error arises applying advice in any individual VMA
> > > > (keeping in mind that a range specified to madvise() or as part of the
> > > > iovec passed to process_madvise()), the operation stops where it is and
> > > > returns an error.
> > > >
> > > > This might not be the desired behaviour of the user, who may wish instead
> > > > for the operation to be 'best effort'. By setting this flag, that behaviour
> > > > is obtained.
> > > >
> > > > Since process_madvise() would trivially, if skipping errors, simply return
> > > > the input vector size, we instead return the number of entries in the
> > > > vector which completed successfully without error.
> > > >
> > > > The PMADV_SKIP_ERRORS flag implicitly implies PMADV_NO_ERROR_ON_UNMAPPED.
> > > >
> > > > 2. PMADV_NO_ERROR_ON_UNMAPPED
> > > >
> > > > Currently madvise() has the peculiar behaviour of, if the range specified
> > > > to it contains unmapped range(s), completing the full operation, but
> > > > ultimately returning -ENOMEM.
> > > >
> > > > In the case of process_madvise(), this is fatal, as the operation will stop
> > > > immediately upon this occurring.
> > > >
> > > > By setting PMADV_NO_ERROR_ON_UNMAPPED, the user can indicate that it wishes
> > > > unmapped areas to simply be entirely ignored.
> > >
> > > Why do we need PMADV_NO_ERROR_ON_UNMAPPED explicitly and why
> > > PMADV_SKIP_ERRORS is not enough? I don't see a need for
> > > PMADV_NO_ERROR_ON_UNMAPPED. Do you envision a use-case where
> > > PMADV_NO_ERROR_ON_UNMAPPED makes more sense than PMADV_SKIP_ERRORS?
> >
> > I thought I already explained this above:
> >
> > 	"In the case of process_madvise(), this is fatal, as the operation
> > 	 will stop immediately upon this occurring."
> >
> > This is somewhat bizarre behaviour. You specify multiple vector entries
> > spanning different ranges, but one spans some unmapped space and now the
> > whole process_madvise() operation grinds to a halt, except the vector entry
> > containing ranges including unmapped space is completed.
> >
> > This is strange behaviour, and it makes sense to me to optionally disable
> > this.
> >
> > If you were looping around doing an madvise(), this would _not_ occur, you
> > could filter out the -ENOMEM's. It's a really weird peculiarity in
> > process_madvise().
> >
> > Moreover, you might not want an error reported, that possibly duplicates
> > _real_ -ENOMEM errors, when you simply encounter unmapped addresses.
> >
> > Finally, if you perform an operation across the entire address space as
> > proposed you may wish to stop on actual error but not on the (inevitable at
> > least in 64-bit space) gaps you'll encounter.
>
> So, we *may* wish to stop on actual error, do you have a more concrete
> example? We should not add an API on a case which may be needed. We can
> always add stuff later when the actual concrete use-cases come up.

I feel like I just gave a concrete example?

It's useful to not have to be absolutely sure that the range specified
includes no unmapped ranges.

It's required for the MADV_[NO]HUGEPAGE use case proposed, specifically
applying the operation to the entire address space.

But I think it might make this a lot more concrete when I write tests - as
these will 'concretise' the interface and provide examples.

We can also choose to 'hide' this from users and add it back in as you say.

Perhaps worth just waiting for a respin with tests to see this in action.

>
> >
> > >
> > > >
> > > > 3. PMADV_SET_FORK_EXEC_DEFAULT
> > > >
> > > > It may be desirable for a user to specify that all VMAs mapped in a process
> > > > address space default to having an madvise() behaviour established by
> > > > default, in such a fashion as that this persists across fork/exec.
> > > >
> > > > Since this is a very powerful option that would make no sense for many
> > > > advice modes, we explicitly only permit known-safe flags here (currently
> > > > MADV_HUGEPAGE and MADV_NOHUGEPAGE only).
> > >
> > > Other flags seems general enough but this one is just weird. This is
> > > exactly the scenario for prctl() like interface. You are trying to make
> > > process_madvise() like prctl() and I can see process_madvise() would be
> > > included in all the hate that prctl() receives.
> >
> > I'm really not sure what you mean. prctl() has no rhyme nor reason, so not
> > sure what a 'prctl() like interface' means here, and you're not explaining
> > what you mean by that.
>
> I meant it applies a property at the task or process level and has
> examples where those properties are inherited to children.

But de-facto several prctl() interfaces do not do this, and mm interfaces
like mlockall() for instance do do this?

_In practice_ prctl() is a random hodge-podge of stuff, subject to bitrot.

>
> >
> > Presumably you mean you find this odd as you feel it sits outside the realm
> > of madvise() behaviour.
>
> The persistence across exec seems weird.

OK I'm not quite sure how to quantify 'weird'?

As I argue below, the idea here is we're doing 'madvise by default'. So you
can either have prctl() invoke madvise() for some stuff, and then establish
some 'madvise by default' logic, or we can do it the other way, by doing
_as much as possible_ madvise() stuff in madvise, and add the
default-across-exec there as a highly controlled, very clear flag.

I continue to believe the latter is cleaner, more maintainable, and less
subject to bitrot.

And I would argue invoking madvise() from prctl() is similarly odd (though
pretty much everything that happens in prctl() is, by de-facto definition,
sort of odd :)

>
> >
> > But I'd suggest it does not - the idea is to align _everything_ with
> > madvise(). Rather than adding an entirely arbitrary function in prctl(), we
> > are going the other way - keeping everything relating to madvise()-like
> > modification of memory _in mm_ and _in madvise()_, rather than bitrotting
> > away in kernel/sys.c.
>
> The above para seems like you are talking about code which can be moved
> to mm.
>
> >
> > So we get alignment in the fact that we're saying 'we establish a _default_
> > madvise flag for a process'.
>
> I think this is an important point. So, we want to introduce a way to
> set a process level property which can be inherited through fork/exec.
> With that in mind, is process_madvise() (or even madvise()) really a
> good interface for it? There is no need for address ranges for such
> use-case.
>
> >
> > We restrict initially to VM_HUGEPAGE and VM_NOHUGEPAGE to a. achieve what
> > you guys at meta want while also opening the door to doing so in future if
> > it makes sense to.
>
> Please drop the "you guys at meta". We should be aiming for what is good
> for all (or most) linux users. Whatever is done here will be
> incorporated in systemd which will be used very widely.

...!

I've spent several hours doing review of Usama's series and proposing this
idea precisely to serve the community. I would ask you to please respect
that.

The point I'm making here re: you guys, is that we can both serve the
community and solve your problem - because aiming at both is _the only way
this change will get merged_.

I am doing my absolute best to try to reach this end.

Re: systemd, I'm not sure what you mean - has there been an indication that
they will using this? I'm not sure they make use of every prctl() interface
do they?

>
> >
> > This couldn't be more different than putting some arbitrary code relating
> > to mm in the 'netherrealm' of prctl().
> >
> >
> > >
> > > Let me ask in a different way. Eventually we want to be in a state where
> > > hugepages works out of the box for all workloads. In that state what
> > > would the need for this flag unless you have use-cases other than
> > > hugepages. To me, there is a general consensus that prctl is a hacky
> > > interface, so having some intermediate solution through prctl until
> > > hugepages are good out of the box seems more reasonable.
> >
> > No, fundamentally disagree. We already have MADV_[NO]HUGEPAGE. This will
> > have to be supported. In a future where things are automatic, these may be
> > no-ops in 'auto' mode.
> >
> > But the requirement to have these flags will still exist, the requirement
> > to do madvise() operations will still exist, we're simply expanding this
> > functionality.
> >
> > The problem arises the other way around when we shovel mm stuff in
> > kernel/sys.c.
>
> I think you mixing the location of the code and the interface which will
> remain relevant long term. I don't see process_madvise (or madvise) good
> interface for this specific functionality (i.e. process level property
> that gets inherited through fork/exec). Now we can add a new syscall for
> this but to me, particularly for hugepage, this functionality is needed
> temporarily until hugepages are good out of the box. However if there is
> a use-case other than hugepages then yes, why not a new syscall.
>

I disagree on several levels. Firstly of course 'process' is a vague term
here, you mean address space, rather mm_struct.

And really you're saying 'it's ok to associate mm_strut and madvise
specific stuff with prctl() but not ok to associate mm_struct stuff with
madvise code' which not quite compelling to me.

Overall you can view this approach as - 'we are making an madvise() flag a
default, optionally'.

And this justifies us therefore doing this via an madvise() API call.

It also further allows us to expand the capabilities of madvise() for free
- we can address long-standing issues around what is possible with these
system calls while also providing this interface. The idea is it's win/win.

Otherwise we're simply doing a bunch of madvise() stuff from prctl() in the
same way that PR_SET_VMA_ANON_NAME for instance (hey - that's a VMA-level
feature! What's that doing in prctl() :) - where we have a bunch of mm code
living over there, and we have to export mm-internal stuff to kernel/sys.c
and it's a mess.

As to the temporary nature of this stuff, you seem to have disregarded what
I've said here rather in relation to the persistence of the
MADV_[NO]HUGEPAGE flags which are required as uAPI. They therefore must
remain, and thus I don't find the argument compelling re: prctl() being
better suited. It seems more likely things will bitrot there?

