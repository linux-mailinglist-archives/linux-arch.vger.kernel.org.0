Return-Path: <linux-arch+bounces-15415-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 359BDCBDD89
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 13:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34EC53002900
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 12:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E2A2040B6;
	Mon, 15 Dec 2025 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pvKdlqzo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fwl1FcLY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B228A2135C5;
	Mon, 15 Dec 2025 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765802464; cv=fail; b=Hh1hl5d5ZiAoHJYQbXrFP8a/Bnh+M4ZbO40PYc8MIU8fo0bgmvmiKiQrus2Z58va42ZiayqTck2M+DtUYnRxHkvvANNtd6gNLDwFQGwQEsjhlCLvpf4DW1NNR/9BK8OOH1jfMo5izP+hD7jVy/JHoCp22h9I1zaosmXFdoNTFnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765802464; c=relaxed/simple;
	bh=HM6xcZfM/PmSz3KkNdm5StoVyspcHzXjJ7Exz80UmbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V7IorqVRbI88EBajVG0uyERVBIVXm3fJ2SV5GnhiXxeuasro73UZcWM9+i54mkYP5VK69tU7Ldx3HFihygRQob9heziqrCacLuqYMhiUjeVUNToTt0noNl/9C8gUeRnc3vh2zXxODYGUoaDV63UHbM9GAddbAsW5I2xWJL4NGBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pvKdlqzo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fwl1FcLY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF9una61784937;
	Mon, 15 Dec 2025 12:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Ogx4hepIDhfMxWEGfl
	Nqk/DZpgBOyy8sANs6kNXOCs8=; b=pvKdlqzo31s5qrWuuDbScd+YdcxaIUu3c4
	VXQbNnLWuAwSFoN1YIWQ8uDCkZ9v4FBK73K8B8j/yqWRgUlNe0ew6pfVhNK+KS5X
	M6NXrMGxkxGzQcU2RUD/g+EpJ/EKWiwohspbv4KTDXmnmvuCwWNuAuf2yJVrDGNX
	wk3MPFGc49Lu5FDKmAUJzXLU8ETv2F0LYdU+KriEmUdYmMWPsOyPdG955O2z9Vg4
	XSavmQK/Q9Ay8OBXREKQnbNVbsUQZ6zzF1xVkk3lcHCeQViVeUzA89uvSopJ6a3r
	7uCEEVJbuL4lXpDKe8ePgKW54OXfAlJNbboNSA3PL1WkSs4yU3OQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xqxt026-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 12:40:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFC0bjG024515;
	Mon, 15 Dec 2025 12:40:35 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9593v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 12:40:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDqlkA7d2HZRAr83aaYC/t+15h5aRu41eu7ygP5RWvZCCbU4l7roH6NK5pOPYsQ7Y4SwobWYBY8AY0iXlsTrGcTlIMbYqDvTKI/ffzn1eEzf08X4R4sg3YsyzenQSoZWIuPbUsU+DPtgr6E8Wafifp6t2x3VGorPHifM6KkN59A5r4qTrLuuY9kQpcjA84VZWAVc5iuoPfci3pDl1z5JDGIuF6ehUTEY7XTqloDuvgylZIPP6+kC2yJHVqORFsUOebkvX1wxGfUPrnIcOQncT4FmeXA5bcsjJF6W/QmynahXkziQ7iTvWIicnH/wKJlMCLT/mVBRiuPZtNNGkHy/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ogx4hepIDhfMxWEGflNqk/DZpgBOyy8sANs6kNXOCs8=;
 b=wyi4ResIXe8TbpYKLB1slS+Kb9a8liXKOw3fwEt/9N7KMmjBgG7DCAt/Pf4Hgo111olD3bdP/ijIq6GszHOhDxxS8jQUn5cGfy22tU7dX/NOm+fwKgWHsjOX4k6XXUYLYV+HYG1LsKJ2Su4bZ8TMPTWqZb8QYqP043fmIfT2HVP92bVzmK8BH7DgobFiFs0xWbgJVGSt34jYIkBtcdcr8OAbbfaFXColuGYW4mrYg9r4/kG5QQnQ0wq6THmXi9OunvyiJraZY1H4ELmze9mm0nk/DAtGy6S+nfs8GmDL78j8AeQCN4SfuqzKX7M8dI+K59AHur4EriZBUGMjAJ0XGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ogx4hepIDhfMxWEGflNqk/DZpgBOyy8sANs6kNXOCs8=;
 b=Fwl1FcLYotPmvC2k1jNZ5VwtCxwqaAK0PhbGC4qV1lmH7lMNdApqtIdz9X5BYNyJVQPtE/oynvOO8bs7aduvySZFnlR25fPjOidN/LswcpVKpTZ2J4WjyAKyik3iqKboeYtAMZyAuKW/oX2bXgQ+0FU1Eqr8g3odEXdP5HwcIhU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5102.namprd10.prod.outlook.com (2603:10b6:5:38c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 12:40:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 12:40:30 +0000
Date: Mon, 15 Dec 2025 12:40:29 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        x86@kernel.org, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        David Hildenbrand <david@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: Remove tlb_flush_reason::NR_TLB_FLUSH_REASONS
Message-ID: <a5f3885f-aa32-420b-8d2f-e8ed6bfc6ee3@lucifer.local>
References: <20251212-tlb-trace-fix-v2-0-d322e0ad9b69@columbia.edu>
 <20251212-tlb-trace-fix-v2-2-d322e0ad9b69@columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212-tlb-trace-fix-v2-2-d322e0ad9b69@columbia.edu>
X-ClientProxiedBy: MM0P280CA0071.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::25) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5102:EE_
X-MS-Office365-Filtering-Correlation-Id: 829f3921-703c-4f62-1666-08de3bd721eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Odfz4ki+UXrChPaF6ITdar0o+jVW8yA9/ChUak9KoBvL3HO2MRSSQ9eW5swC?=
 =?us-ascii?Q?zKMM4RWpCNlWV4HpK8+bEhmlO5zu3PTyJB5bfaD7xfAeDuoimcUvSYzXfri7?=
 =?us-ascii?Q?pTvjN9bqJx4gY7K3PPYWoGtBV3X7WP4m6l3Q8P17Fy8UHPUc+n9tYdplKiIN?=
 =?us-ascii?Q?68vRkCBL1YT1qs0b7t0LzSiuI0k/yABWqf+YK37NHDREMAsp5tvhvpQm6Maz?=
 =?us-ascii?Q?gx0esSs/+7esBMBeR9GcryjrdwUg/6QDGGwxHRSKRMSoCoNvkx3P7viYwabk?=
 =?us-ascii?Q?eMy3eONesd9eYUCCLcLsyTdCHyTiOHH3KzxfhC2aEaWDhVCarVwdREbTFmsE?=
 =?us-ascii?Q?/6frjZ61k2O/bUzN7guqITB+v+9zGXcQGHPKeTTiPrd/kq5rs2lqRrXn8/0y?=
 =?us-ascii?Q?SuR/hrL6YgrgOal3WOgrqJ/exQccOZLIjDdZaRiKiu2zfQqYj46fS7gZsTym?=
 =?us-ascii?Q?aO61P1Yy3kmxQ4ZgW53Qj8PKqt8q7eWMKo1IxkLH2a4BzdJ/F7jwuocOzqKw?=
 =?us-ascii?Q?I16x5bv/Ktb06nDLpCnIQOme+JJVV+pNNiIdC2o3flyNTWw7GtGpP0zpRiYz?=
 =?us-ascii?Q?JRHi5bzlqaYVARHxTubKC1fFR4Ei+ijAjS1gsVzuWSCuXzHVJ9sH/bG8zqqy?=
 =?us-ascii?Q?WKobQmv0VCmJuWXVz/wzA/oouhHnyCS7SSLLXrEWewncagX9WvaFk+/Pbc7m?=
 =?us-ascii?Q?yJtCYOOuHXa0qeeyaBgvS8wQnFV+SmCdwFdGSP6TYbnlIoeiQ4cWygmmz3aK?=
 =?us-ascii?Q?A7esBL7qk+n3ySSwg+VLYj2j4VPL+VqugkHIBwMSIPXRmadoOKcWReTZYXVL?=
 =?us-ascii?Q?DNahpJWsdkxbSidulLpjzSAuHVnzqilqY8pO/IqGVyFwFTjcG1EuK8hS4ZiE?=
 =?us-ascii?Q?1k12X6I4vbcKohLrv6JUmL230SGn3j3RMzvbulDXZP798lAlSBej9/bYd3HO?=
 =?us-ascii?Q?DT21Nt+qTIY0mNtti4ugtdnASHNmvSzAS76imWmPyzx8oHlNSj3y6ag+K3y9?=
 =?us-ascii?Q?/Dfyxw6ZBjkGj/SLZO7IoMQ93wnmvuSIO6ZA/GZ/leuynwcaoGrdLI+wedYB?=
 =?us-ascii?Q?e7zElNvqpd+9tsLZASwuRrO1qOgu9ooeJc12lVxSmS0v/F6sPXEsTi+fj/n+?=
 =?us-ascii?Q?b84+3f33WsX9Akg1uKx4agJcjDqD4U3f665xIb3TOWWcq3P7XBXicxrnjiql?=
 =?us-ascii?Q?bo1vv1apizOg0gu2czxrujJwhW69Bw4/VOtDA/p8c/luiMHv9e62VEUdPHhV?=
 =?us-ascii?Q?r2qcJRXCJ+Kiq3xZvEgpWarLu/zlC6+9ai+nLRhlzyN8EP4svWTtG89+EAFY?=
 =?us-ascii?Q?VEwGK40/SjS+Fe0NueJFS44boCDEa+pzWTWTErbYn3a/WyIxrZt/VuTzEvKR?=
 =?us-ascii?Q?QHmhzQW2TFoi5BPnA0/ughYHx+F3JOWCdfMPlcTDMdG5xXxG2k3zpwhHwG8r?=
 =?us-ascii?Q?A5bdpFFiEHNjuwCW7m5m0LhZ7xOE+SN5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gEfGq8iEGV7+ibAIvudSGuTKTSsNS7AY1SYASWAx3rnZvDw9EZVPdOPDTJYv?=
 =?us-ascii?Q?bXwuOcue7DPcQiIweZw8DAG8L+B1urhica11QgNPhq4FpyRgeNrLM2cW7lnM?=
 =?us-ascii?Q?mp8p0YHCGF7r8D7l7sjQ2k4bKKePDqbsr9lM3RLbJvtlt/Q7wZx2ERqwXyYv?=
 =?us-ascii?Q?cTHZdamwz19saDSaB0BFzKqFb3g4IrwFNIRQyOpTh+4PSLhroXuzXX+VnMLE?=
 =?us-ascii?Q?gHFLoMsrRnaLogBsYnB6SsByRjdaEp6PFYt9CPxproJU+NuUEMLcM3RTcCBh?=
 =?us-ascii?Q?RIdVn/wUPpy2+hDEO9xSUM+jQcdSnqSBn7f5hjro+y6tvk3CLlA8Lz+sVqZT?=
 =?us-ascii?Q?P73rjIXitP6vCjGJPudA2DXKOekkHD/ZQLaa9OQxDg4cjLYS2W4Vnt6SiuSH?=
 =?us-ascii?Q?dsabTGkWJbpZoTBn6QsX+wgQq/5gGop6hzNEoHZgPCPtAfwZMpiD6e3mBYym?=
 =?us-ascii?Q?3Wxr0zjp1Cw6JP0KQhpxt3qTboa0QV83IcnTi7WjQQAVsy14ujCCzgdlUk0M?=
 =?us-ascii?Q?x0t3e/vzSIh8y1RKIbzrHc5JDbKpmTmMHgl4OSEyHu84+1o/Y44x06f0bvre?=
 =?us-ascii?Q?fkJUCvZzzxPBxFjpwMxueXVPra8d5Oj5uaj1oUCO/GUJTbHC1YlZzbLuA4Ko?=
 =?us-ascii?Q?p3iyXui3Lh5CVnrNZ4K7C9gFyJdQEdtB05asyplcqI3wQQ4qhE7rgIUfYzbB?=
 =?us-ascii?Q?TSqNTibhQRroeSFUYhyzvXABBs3U+YGKkCc6rqNhaC28gJbIeFJtNsBGqof9?=
 =?us-ascii?Q?zVroz/AFUJTOgeJ/p0kJ4VyrYvPkar7d4b8NsfgYF5QnL6M6biKk7ejDeklN?=
 =?us-ascii?Q?5HZgtrOXSu6bY9YV6HoQrbUIkuGqVhx7amPzw6rZiUDgE1opBfe0L2Ni3hSf?=
 =?us-ascii?Q?0BpkGsyT51Cbr59pWhzh0rQF9Sycryj5OxOhOTsWSdoIDJeyx4SwjkVxOf/h?=
 =?us-ascii?Q?wLJulwBLbO36tU1xwHNuoIJ+KN3035GC27XkqNEGhH8GBSFMH4E8wzGpnEDK?=
 =?us-ascii?Q?m4+yX4lP47GycHqpWmWlrr9d7tmyYzYaFuR3hrnGFcA65FlB5cLnvb2eXavE?=
 =?us-ascii?Q?oljWE8putKVazFSfj1196MxwmYyVAxoT610LZF26kNafApJXEVH5pvo3xT4c?=
 =?us-ascii?Q?lAqBucKrR5B+WTuEM+GS/UF5ztgRRM2r7V0UAB4UPF9DIM8jvmZIgzrTaUl0?=
 =?us-ascii?Q?3pNwbQh4c8gRVEyyKrEg7cvP7lBy9LnAmBxb+gxWPmirGkIxzJLqFlWFUDdy?=
 =?us-ascii?Q?AO8g4/SRAOk+Ghof0hqbw2AVqN4eX1mBcK7Ge6pf6Ntx3tvEm0BOlz+H1jCb?=
 =?us-ascii?Q?e7680OZJGQ/XAc5kTyRUvyFWPfvMEEH+Rcwba6j1fTX0RIRAIqy4p+3MgdTL?=
 =?us-ascii?Q?7rhpf8RWC1Qehl82uncby96vT46gAZxxGlVhO2aKhYsP092gWF2Uon9h6baq?=
 =?us-ascii?Q?nyrtXJJxP30iL0wulRr6qf4DMn8FnAQ4gHxetGz3GEebtCulbdVAeRtwoUcm?=
 =?us-ascii?Q?xLNbQ1/zUUNrMjIVpWhcHhKBBBqeAjabjK3NPL3S0BfqHH2YemwzZsQwQU6P?=
 =?us-ascii?Q?Vg+HbyRJWjFuYgJPzvyqPZBcSdHtTL0UI088Jq39yzlfrV6FPDpE4NXj3cUm?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aNgiDl7lVofuQKr4x5NrO3N/iZnJbZrE3JluRLwzbA47WIKENeuXmEst0OwzUccb3j0DQuv9jwjXVSmKRCDuexwTIIyQAnIrdWQwdgnWmVKfLzfBoQirXdoyhf6bPGh+libunemgC0qd1ou07FfdhtsEDYAFW885rlUv3mIu5/Q8nydugE9NwM7tcvJmovsTqRJloBt2r0mvNVSOfEmgHwSs3YyeBBs/vj6ZBbP201uEuWRjEpsjyP2tJubR6xT/ff2jaJdTRsBC8ZYKbCsO52kKnd3pErEWcBJqYzHTp7ChQ9wxeTsGhdWEuXQrRRWEw2Ekxuk/DyqmL2FaNYKEVBse6IsQeQr4Nt2V1GT7x0tw0N2Frzr30wVtWeFhywB+CMg8Qa0B6kw6L2Gibojr3FDtsqj1rUmPhyi1aCVj9AL3jMlHUWREvam1M2mKgi61CkBm/n/zdFsywvvaXOKBQWy4ERwrm1loQrh9DzlnSbXOppbyi+WSt8VrDjlQqo4/LbGKMJoqzJDTVOKmO3wCdi/g2ZKcdVkE/IK8Z+8sk6AaayOsrDgjS713AOKVI9sL2s7arkl0y7twRsx/rhochHxNNc5j+66h9TxJh8vcPoA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829f3921-703c-4f62-1666-08de3bd721eb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 12:40:30.7033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RobqOQ+GlGeSeFkJV0jCZjiUa0l0g0M7E6d6jk6hadJmhk24dMPfxGhGjqRNokhrPeFMZasJyEBS2z+Z9ussNxipUF5t7JWUtxeiJzwHHwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5102
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_02,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDEwOSBTYWx0ZWRfX2mNtaHfnWVmh
 FJhE6l1MvQf8T5+op50fAXscbHM/p+rlFJD7bsRVs+59qq2ov1SH7STiWl96owAcyKk7qYkBP4m
 R7i0/z2VPPxvNT/ug/hj34DkL8AH009UTRfFPEuJx1MY2nb5D7WI7Qwpj1rzx0lv2iMRkj87hrj
 tspioO+NBHe5kulb3LtRku7eXgX3Ns0N+9NczY/l6lz/CdDhkYaup65F3EOFFE9mXVyZR8C8EtM
 Ylrb7FzdXKnNf73ecxTiGKX8DW0cBfg3PQT5bLfe+ptiWNmz/58sgMusQQbFldl/It1tByxxgzy
 pR7lXiLKa3UlqlnSen/fWDzM+9+pn0ovx7pKcl6Ukn9pj0+ZzWNbH0M6yMcuDfQEwsAgP353A04
 cxnn1NdZP6cj/Ne8Mnhxqc3i01IPTQ==
X-Proofpoint-GUID: glj99y3XIE4m0gMEzyg4hh7D4v13Et8N
X-Proofpoint-ORIG-GUID: glj99y3XIE4m0gMEzyg4hh7D4v13Et8N
X-Authority-Analysis: v=2.4 cv=BYDVE7t2 c=1 sm=1 tr=0 ts=694001c4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=fwyzoN0nAAAA:8 a=yPCof4ZbAAAA:8 a=PZletmz-3c9jAj60V6MA:9
 a=CjuIK1q_8ugA:10 a=Sc3RvPAMVtkGz6dGeUiH:22

On Fri, Dec 12, 2025 at 04:08:08AM -0500, Tal Zussman wrote:
> This has been unused since it was added 11 years ago in commit
> d17d8f9dedb9 ("x86/mm: Add tracepoints for TLB flushes").
>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Hmm, guess just a way of counting the number of reasons, but if nobody's using
it that's silly. So:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/mm_types.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 9f6de068295d..42af2292951d 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1631,7 +1631,6 @@ enum tlb_flush_reason {
>  	TLB_LOCAL_MM_SHOOTDOWN,
>  	TLB_REMOTE_SEND_IPI,
>  	TLB_REMOTE_WRONG_CPU,
> -	NR_TLB_FLUSH_REASONS,
>  };
>
>  /**
>
> --
> 2.39.5
>

