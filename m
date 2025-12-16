Return-Path: <linux-arch+bounces-15462-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B36CBCC203A
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 11:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A11F301E1B9
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 10:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920AA1A08AF;
	Tue, 16 Dec 2025 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WfSSdUbq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pBYy8dLN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62AB749C;
	Tue, 16 Dec 2025 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765881998; cv=fail; b=PsT5G3ca/UX99bleK338+cWpIoinfQVJgsvoG/mn5DAWguqlHb3olB3SQ3P5haUVhMJqoMmr7LPjdYJdwGbM/63clijEeouamI/XC4ANWRDYcd4cSmuRGc6lj+6pLI9xtO+w1G37AarhrRUGEI0ovnHFPNEsc05YdthzYIqD7gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765881998; c=relaxed/simple;
	bh=dCLCQcwNs5Amz9lBPQPlaSxZex9B05Fzr38TpT1wjKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XsFRz5AaCV2HNW6fhqmWj6s12vGcM56E2XnPkVtIDMzIkOXKhb2tEz7YxWVXNoTBID3V6Z7vwYq7mWXnK8HGNS2bEAgQD0b6/fcd9Eo+xm2aiIPHqSoXW2iVP/zzHUq6lnNHqVi+DsCXe6PduGtDCB4SG10fobz3F9vxRB7vuA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WfSSdUbq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pBYy8dLN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGACA24108082;
	Tue, 16 Dec 2025 10:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=J1HY5EcemfN+J2Tmzf
	XNbvk0W43/9YDNt9cKu95++nw=; b=WfSSdUbqHZOE2TS7j3tufBOKOUvB1q9Syv
	NGBpdpB53+CoNoJvGoiiw6tkzLOLTQVG9XKPp01dIm/SSYJywv7yWqRXXlpdJtqd
	G1sov6g1ast8D27Go1xrKOq/TgIztvY5WiVOR9dvNoaDVjNH63Tb2hGxo+xZwCIB
	sk4+/23dl64BaqENnCmsATmltEE3xVI8p3jYMn2tNj+j7THAc4vYG1b/zt9ULahh
	Lg8Ah8duoO+IFInOInM4Lx/Cm+4mEF7bVOMeTGcOBakxeQoQ8/SS3yoKb6Cm3keY
	mkGKmXdbGoB0IDpIqCgXhxYdhqq748LKY7iMsnxAAYICHIBpS8mg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xx2bpxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 10:46:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGA1irG024872;
	Tue, 16 Dec 2025 10:46:02 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xka2nds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 10:46:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9vXRvlt5zMxIGFrTkyK9sEMPyBGM3kk3Z4QcrHfnqCnMG3XqSUtYeiwh7k9/DMe/ieyrq8Td+jVQSE3T6z5Xn7YOMdXm+Ffb5dW8Q4jspY0HFxi4rUpdQUmFkKrvy+uWN+UzvNqkbKYSVs/QeEhsrtcEAs3BmFLHjbFb3K+He1EfE9KRTEo5JT6rXi0zzZJgsdUg64MsBx776jBh78UaXHTXn6QRUIR87bca0FEYmTiY185zCbZBO+h6fkNn0dfw+fRviMFFWs52pjGgbz/DeaAmyaSS15iuxAfvRLTkL0KwCSI7Af+1uK/geh2EiVaVls5Oj4JNGKriaLVBkPfow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1HY5EcemfN+J2TmzfXNbvk0W43/9YDNt9cKu95++nw=;
 b=gG4npWJjuKnvq7x38OybXm+Bu80irpIAalH927RHw5zqukaWBTWVNVhh3EKxsbEhuAXx9ipS0DOeANWUKEoP7pVkZKkbkatLcuTzgmNeyVlHAqe0qg6kwPks5bDYIk/R2495VNH+XxVSJG7Hm7Fpfa7kYcoMb2MD1K+Jed1DrSc/2diwWoBi5LfvgLXgLan3xV+SQU/b7uhRjmMcF49VXVDvAMyd49CUhk/jmVR7CHpSyPIL6ZhoRJfs3xfCtvD9cV3DPUHEJz1k62Hiu9YQBJ+zTBubAzA6q78SJN7bEo50mkk+H7B/7m/XEfLVoWNsSiq8PvPH87HDoThFt/tQQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1HY5EcemfN+J2TmzfXNbvk0W43/9YDNt9cKu95++nw=;
 b=pBYy8dLNz+Tbl8WpljHVwwS3139UG3RJDa+Tqreq31PZK38DP4daegh+kL0JIFsX4kyjLtD3N5+XhnU3m1DX9W26cAfb+jDqdGEi2cgVsoY1pg/iILV61e//HQxsD+eIrwh/txJ2CMCdWTUWNTGgmfBOrcK7CKXd5qeuXa0/WBk=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM4PR10MB6838.namprd10.prod.outlook.com (2603:10b6:8:106::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 10:45:44 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 10:45:44 +0000
Date: Tue, 16 Dec 2025 10:45:43 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Laurence Oberman <loberman@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v1 4/4] mm/hugetlb: fix excessive IPI broadcasts when
 unsharing PMD tables using mmu_gather
Message-ID: <4037214b-d1c6-4e0b-ad9d-6722aea7aba9@lucifer.local>
References: <20251205213558.2980480-1-david@kernel.org>
 <20251205213558.2980480-5-david@kernel.org>
 <c641335e-39aa-490a-b587-4a2586917bc9@lucifer.local>
 <9ac7c53e-04ae-49f3-976d-44d1e29587d1@kernel.org>
 <07e8b94e-b4a1-4541-84ed-a5d57058d5a1@lucifer.local>
 <937a4525-910d-4596-a9c4-29e47ca53667@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <937a4525-910d-4596-a9c4-29e47ca53667@kernel.org>
X-ClientProxiedBy: LO4P123CA0640.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM4PR10MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: e47432b1-b934-4843-5da2-08de3c90434a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EIi5XR8i7GS59FwYZffVJBSbSYtSLQT1kUXnO+Y+gARmAL4R8Qlg0ZUz63Ve?=
 =?us-ascii?Q?XQFVTE+THZ/TgaxQkhMWB3X+eF4bOxKcWMjjAjhNC34Sv7YomHb/5KI5e+Jg?=
 =?us-ascii?Q?M2EZThvyznJYROcBP0xIq/KSDfLLHrnjwjhaq6Vt+q0AwduCMYdxCYlMOpS1?=
 =?us-ascii?Q?zQ1nyh0iSVCgEInYqBr0soOrSJnqz+lyU4cXGuHZc0s4KBkSj65NRVIKNFv4?=
 =?us-ascii?Q?w3jsMf/LWgEoA/EE3RsBePP3g/O3cPZtz2r2tap8FEvxrX3Q3od3UNFBZqd5?=
 =?us-ascii?Q?fyaBb3DrOepiAts9sR92qF1cWhn/BTg+ohLRBsQCnLeWeOm4Jvbq2Ym2oSU4?=
 =?us-ascii?Q?nGL9A56jPonCXyQhrrRern+9Ccs1kB/MaoSMg3niGALtdqlGvg530xsUkCcz?=
 =?us-ascii?Q?A4kVVL4fHQEGSNoVb2mEsVii/gODBnu0AZR3MUL9MW8AqBtcwLB6uhmoekJL?=
 =?us-ascii?Q?Xs7MPP5/LwVAZZ0X8ivwMsxd4W53JW8ocP9C6Uf5xTdvHI50uS0CLxoh/rVM?=
 =?us-ascii?Q?uGtkvs0pUhHGX9E/e1x22APaNaYwCr0B4M39jgl3qMnSmoxQGsNHeGqZic+2?=
 =?us-ascii?Q?bqdPz9bC8fOCssQWtmTVmUIeq180bf3gN0hwU92SCCc2y3YTeJGq/4Kc/CSC?=
 =?us-ascii?Q?0SZGu/9wv8r+kZoc2i09NjEyLmXYSCYXSUMD5WSp0q1+cuuBw4yZPAP6QB4V?=
 =?us-ascii?Q?zCl09QgoIEHhPJD5MC/ORNnQhJ5gUUDwg46kGOUi4QWl4xLhG6TsUWWa3DsN?=
 =?us-ascii?Q?1SxQEj2jti9AqZzEzKrlaZxLfNiv4cVUsrbRKUGEEw53EwIyrAwVRq/sWM+K?=
 =?us-ascii?Q?kia3LdPB1mOmADJakt3sxRrM2KJpp6Nz1Xo3NdPh6932HiJ+VWOqb+yljZ1W?=
 =?us-ascii?Q?3gSy0otkqKyjNWw72IYUUFhO0YO9jRAm3Dio8TH8vYJ3d+nx4wfzYL07Xc7J?=
 =?us-ascii?Q?9o3JXyfscpq6baCeK/gFhkUmxSnz3LmNnXaI3R/x4G/PxTFfIh41viKd21XT?=
 =?us-ascii?Q?UrBjYMBQ/vccsgoo7kOvbA/331Bfah3j4qClVPR88/YDbKhsvQI2bFa3zAZB?=
 =?us-ascii?Q?pEyZNfB9h0QkhwfBrQOt9JvxCzE9mdsq9oDiZiQlktd1ufs0GkKPi3F6mLkg?=
 =?us-ascii?Q?QJeC3doLRWfmCHM6P0EbYaE9EKczAsPPI4ssPe4ib27vlA3y/0GY2XBX4xj8?=
 =?us-ascii?Q?07TEoYopB0RhrZJstio7BworvvsKoFWe9BMu66VOCVY/9gRt0WyyxQJFP9gg?=
 =?us-ascii?Q?XnAswP4QATCRLIwC8AxIDi5MiqP2KhodrSVVozsAdmb5UUghRpeMcaVyOsBi?=
 =?us-ascii?Q?C415O8RX9bw4xS//ofNA7fePYNuDHccujkaPEH25fpsEm2hlenwvCCfporzp?=
 =?us-ascii?Q?OHCPRgektSl6wEFCrYbqL8GEIhquCViSSmPdgVDXi7zwF0pEoE+S71GJBJma?=
 =?us-ascii?Q?9VfktjhNn4X13QFgzm3ttdzEn0fYMOcc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nvWcNxf9b1WiijSs5ilBQlrNwa/mwFlvJhz6CJX3K5VM0g0yKcBl7fTd7Ofd?=
 =?us-ascii?Q?wwNxqqJDIcRQw/dEU/B2sI8LGMjK1d59Mkub/EGH6B8XD1IX9cRPo1ZQhdms?=
 =?us-ascii?Q?0XI2Tca1ili4Dv4irQFfOB2kqG4RCX7ShfqdKfD4xKZP43FHa6uat9oYZHcN?=
 =?us-ascii?Q?y7TUz7KimJ5BVfbKzvFIH75O5BKRhvp1v+JCvgVrASExVGhbcLmZ3/nUP9yk?=
 =?us-ascii?Q?CAEtqn+WsIM/Uehh0bQTsNif8EFn6Qta+rYYqr99K+GqIjtaoV+Xlh0UcRCc?=
 =?us-ascii?Q?xaj440dxslHjyh8QHiv3TuN0p6/C+cOIPq6oUcYDzWCuly7jWe1GiNQgs5GJ?=
 =?us-ascii?Q?FPKQUlUXX6q6VtQlStpt0udb6yNcVPLjoSFjEpiNFkiOtf5uDnrTZ+1hLqrm?=
 =?us-ascii?Q?MVwBoLj+BYPSIXQgcCM6fZt0jRapNIqsJZTN7m7kq0HZOxH/BI3SpXEqd3U+?=
 =?us-ascii?Q?1E729taNB4PMBK8i+6V3X+4damT4tHdEMwMIiibEIiKzrfHskmBoGhKuObOA?=
 =?us-ascii?Q?FSeKOjSTAknBUVy+BjpzsmqKLwuGNzpWCoHP1Ai2B1CTgy33ONHVIOyPfTqU?=
 =?us-ascii?Q?PKX10okrVJpyYxKZzPItfzsynJGBn95XKX/FTYIieJpCaGFJLZQMGeoindWB?=
 =?us-ascii?Q?AkE/hZquG1p7sqt7UFVeCs5mJCfC8R7wro+ltpn6PEHYCbcLmZlskYWnqqSR?=
 =?us-ascii?Q?cD5Bs5bAoiRE+hNn+NTaAgenPO6XKY7R7EGxK63sLN2v6lVb8q7J6aiuePJs?=
 =?us-ascii?Q?785qPhKCftTRnX6M8EZzgKEgZaN8HKkzfCKg0WD3jwTwyPZ4mmy4gr6VBALJ?=
 =?us-ascii?Q?it8NaDbWwrSI3skL1clox5ct8ublM/OSBuiqb3kTbKSq6N0GGfAwp6N8pn0A?=
 =?us-ascii?Q?1tgk2SUB8Odmd7V16hUzvFzzPrExTIvmL+DaDiPFGD6pSLfpNs4R657jMeg4?=
 =?us-ascii?Q?Ixy9m+seq3CbG3qKvh8ggW0XpSC2fUH0k4onqTsoD7TDRPdHDQT+7SFWwoIm?=
 =?us-ascii?Q?fHveHEGt51d6Ap0XSPXap0nA0jr9rTnDT8I388tIYsnWBm1RCF+zPjh6Lc/B?=
 =?us-ascii?Q?4LkuqwUThSVWgOG5Wr9lxkIQSWSyqoKrmz7D8ZOhwwQohPzZXAUqsG+NMXT6?=
 =?us-ascii?Q?Y5fBDx7DbHSo9qKHXCj9qM5LrrtWDB2x8WFoz2U5BpXhhNvmiSdAVcB/9WJ4?=
 =?us-ascii?Q?1CF5ai644nc93lhvRqfKbL9WqQvkh+/aFsaWg+zPgCEXt00nKoG3+BDeB+FH?=
 =?us-ascii?Q?9qiCq/584uS3X3h0kF7v+YXutaGF9bZD+zzRWHCjcjSfGXI2WhvKg/F6ME4O?=
 =?us-ascii?Q?ItLh0s+5ViR+SXeR1djhgPvzthJ1dHIxPkVL73RiGEwJ40cpGqloszJ3ivAv?=
 =?us-ascii?Q?fxMmqD0XnfUsZc5thKBFOO9ukoCtFME6TvJs4koEaAUlQJDoFTLqxlyRT2NC?=
 =?us-ascii?Q?I8/qFZ1I2WmpEsjuP1EG5x3w0zvhH0UCLdYBc+LC0Pe0avAK3lg+MRzPRa0C?=
 =?us-ascii?Q?HdDRekEN0IIHez48tzLZzB80BRakRX4yia1cDMVud8EXbavH+T2MRTOwLpK6?=
 =?us-ascii?Q?ul+gJBOK3BxquI98L1KbZCRb3a9IVAtcDJDfYN4LAEoKz3dR9lA2CTsHzq+9?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	trENxDgaCJUf2mJ1rmY1LL33pc+Hg69dTS0VLZlJYdVSyeHOnyEbjQMnZ3l6/RmlQgnL0m6MZz/BFFyLISWt17/ur+X9pSWlenCPttpUU2o0yfI7nVYsSucbiuddl9ntpCYotw7p95d/dbc57XD3A/MjU8AAsc8jQFBpDQ3yHQEAfxmjMkfyDr2KfoUOzYOCKiFo7BWk8N804fEFuG8bWO49smSsk29+w9edTUn/Ey2p5PWQzXf00RLjK8+XFMEKXTNGb53feIPBaLv1vYBXUX3XxvJCIooGLhqqMacvzXMpEwQkZnv1CJXX6FAK1ZPBiFGT5uYgIjwqnTvGdILDb0X5BC7C7DiL23YEnuCpLGmWKj+eEfSmX7NZbjzNr/UchsqFXtlfR4AS7zRRIEdW/CaO5/xOV8Zmx9DjrJ4c+Zk8JlqNuQdkiXJsh1kZ8dU6H8CDXF328JqgZJr89p1D5ujp37NHReRpMQHAJPx/NUmq9H+Zua/nPRon9cNbRfL2d+KLdO4GO6NTaBZi/v82xMOJfndaKvb4PeWfzq7c80T5fotnmEDJQk/53fSt3Y7P0p63sC/ZgbJ7+vSLdK5wyWe7rtdm3ZK5u/71dNN8pd8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47432b1-b934-4843-5da2-08de3c90434a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 10:45:44.4920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4NNN9fYjGnmll63LElj23GjOQHgp26LWBMs0ZMh0MkN0zQwE9vEt7UxV3Iwhi01nWi7BVeZli0fP2eZgLqO/z42jG8gBnVNuHKrk9zhu2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6838
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512160090
X-Authority-Analysis: v=2.4 cv=B8W0EetM c=1 sm=1 tr=0 ts=6941386b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=j3iRA4cEd2JMxDDAQSwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: vp3msmy7id0Ud03A-YHSQgWn_uMfYD5j
X-Proofpoint-GUID: vp3msmy7id0Ud03A-YHSQgWn_uMfYD5j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA5MCBTYWx0ZWRfX51YeqHUGebJW
 eWPRA7PQTxT2U+3LY4ykkdFbQbBUVtonWjScdR+vmPHM0drMe08MjoQ88+iPC/Q2cOt2aLXXQ3P
 qoT8Iu6z5b/tQFC64FfRi4JC+7aAWZwe821TSyKWwrP4ncxZMsvdJyHim/C0G40SwigeM0UfVSU
 wV2uuY+AvjUg8MCRefcGrqrOgBkBf9KubUGy0a7T5hkK21sR76fE/2/AkAJYIJKG7rAUegOn/FI
 7hiUvRJumqL/1e5V3fuVdAQSO+4VnZGLwEeXwUS9ctD5BTpGizjZ5p8T8wshfFnmg8Edv904Q3T
 ogx22L7aMA6SdU5I58SOG9yR0fCBH5SmOr9Lq4n5RfO5f51usSqRsMxxkTTPTSgV3XoEzsHXmEO
 eEig4HtqTjgoOQOwrjyHLpSiNNxXrA==

On Mon, Dec 15, 2025 at 03:47:57PM +0100, David Hildenbrand (Red Hat) wrote:
>
> > > >
> > > > As Nadav points out, should also initialise fully_unshared_tables.
> > >
> > > Right, but on an earlier init path, not on the range reset path here.
> >
> > Shouldn't we reset it also?
> >
> > I mean __tlb_reset_range() is also called by __tlb_gather_mmu() (invoked by
> > tlb_gather_mmu[_fullmm]()).
> >
>
> __tlb_reset_range() is all about flushing the TLB.
>
> In v2 I have:

(Was waiting for reply here before looking there of course :)

>
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index 247e3f9db6c7a..030a162a263ba 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -426,6 +426,7 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
>  #endif
>         tlb->vma_pfn = 0;
> +       tlb->fully_unshared_tables = 0;
>         __tlb_reset_range(tlb);
>         inc_tlb_flush_pending(tlb->mm);
>  }
>

OK so I guess since this isn't tied to flushing the TLB, but rather only to the
IPI we're good.

>
> > >
> > > >
> > > > >    	/*
> > > > >    	 * Do not reset mmu_gather::vma_* fields here, we do not
> > > > >    	 * call into tlb_start_vma() again to set them if there is an
> > > > > @@ -484,7 +496,7 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
> > > > >    	 * these bits.
> > > > >    	 */
> > > > >    	if (!(tlb->freed_tables || tlb->cleared_ptes || tlb->cleared_pmds ||
> > > > > -	      tlb->cleared_puds || tlb->cleared_p4ds))
> > > > > +	      tlb->cleared_puds || tlb->cleared_p4ds || tlb->unshared_tables))
> > > >
> > > > What about fully_unshared_tables? I guess though unshared_tables implies
> > > > fully_unshared_tables.
> > >
> > > fully_unshared_tables is only for triggering IPIs and consequently not about
> > > flushing TLBs.
> > >
> > > The TLB part is taken care of by unshared_tables, and we will always set
> > > unshared_tables when unsharing any page tables (incl. fully unshared ones).
> >
> > OK, so is there ever a situation where fully_unshared_tables would be set
> > without unshared_tables? Presumably not.
>
> tlb_unshare_pmd_ptdesc() will always set "unshared_tables" but only conditionally
> sets "fully_unshared_tables".

Of course.

>
> "unshared_tables" might get handled by a prior TLB flush,
> leaving only fully_unshared_tables set to perform the IPI in tlb_flush_unshared_tables().

I see, right, so we can in fact have one set without the other.

But this logic pertains to the TLB flush so we're ok.

>
> So the important part is that whenever we unshare, we set "unshared_tables".

Yes.

>
> [...]
>
> > > > > +{
> > > > > +	/*
> > > > > +	 * As soon as the caller drops locks to allow for reuse of
> > > > > +	 * previously-shared tables, these tables could get modified and
> > > > > +	 * even reused outside of hugetlb context. So flush the TLB now.
> > > >
> > > > Hmm but you're doing this in both the case of unshare and fully unsharing, so is
> > > > this the right place to make this comment?
> > >
> > > That's why I start the comment below with "Similarly", to make it clear that
> > > the comments build up on each other.
> > >
> > > But I'm afraid I might not be getting your point fully here :/
> >
> > what I mean is, if we are not at the point of the table being fully unshared,
> > nobody else can come in and reuse it right? Because we're still using it, just
> > dropped a ref + flushed tlb?
>
> After we drop the lock, someone else could fully unshare it. And that other (MM) would
> not be able to flush the TLB for us -- in contrast to the IPI that would affect all
> CPUs.

Ah so it's about TLB flushing for _us_ whereas the other user who fully unshares
will flush for _them_ which may not affect the CPUs we're using.

Yeah what fun this is :)

>
> >
> > Isn't really the correct comment here that ranges that previously mapped the
> > shared pages might no longer, so we must clear the TLB? I may be missing
> > something :)
>
> There are cases where we defer flushing the TLB until we dropped all (exclusive) locks.
> In particular, MADV_DONTNEED does that in some cases, essentially deferring the flush
> to the tlb_finish_mmu().
>
> free_pgtables() will also defer the flush, performing the TLB flush during tlb_finish_mmu(),
> before
>
> The point is (as I tried to make clear in the comment), for unsharing we have no control
> whenn the page table gets freed after we drop the lock.
>
> So we must flush the TLB now and cannot defer it like we do in the other cases.

Yeah I guess because of the above - that is - other users may unshare for their
CPUs but not unshare for ours?

>
> >
> > Or maybe the right thing is 'we must always flush the TLB because <blahdyblah>,
> > and if we are fully unsharing tables we must avoid reuse of previously-shared
> > tables when the caller drops the locks' or something?
>
> I hope the description above made it clearer why I spell out that the TLB must be flushed
> now.

Yeah I think so thanks :)

>
> >
> > >
> > > >
> > > > Surely here this is about flushing TLBs for the unsharer only as it no longer
> > > > uses it?
> > > >
> > > > > +	 *
> > > > > +	 * Note that we cannot defer the flush to a later point even if we are
> > > > > +	 * not the last sharer of the page table.
> > > > > +	 */
> > > >
> > > > Not hugely clear, some double negative here. Maybe worth saying something like:
> > > >
> > > > 'Even if we are not fully unsharing a PMD table, we must flush the TLB for the
> > > > unsharer who no longer has access to this memory'
> > > >
> > > > Or something? Assuming this is accurate :)
> > >
> > > I'll adjust it to "Not that even if we are not fully unsharing a PMD table,
> > > we must flush the TLB for the unsharer now.".
> >
> > I guess you mean Note or that's even more confusing :P
>
> :) Yeah, I did that in v2.

Thanks :)

>
> --
> Cheers
>
> David

Cheers, Lorenzo

