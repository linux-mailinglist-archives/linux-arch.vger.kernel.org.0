Return-Path: <linux-arch+bounces-8581-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDB59B11F4
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 23:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2304282DF5
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 21:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B0A2161F8;
	Fri, 25 Oct 2024 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ii+/bVFk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WWfqUV5v"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5548215C70;
	Fri, 25 Oct 2024 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729893100; cv=fail; b=F7Z2idxpmp87jB8opgKlZpfKBDjRsPPPrXlN5IlvvBfnzCjxY47wSxEKHJj5MqnNEnt1P18wup+/DFGMabK7jm1GDlJSf7BPzzuKvwrZk5VcmOfXV8vpPhPi/7zEbi+ZTiqRX6hK6XZoOQChIRvs4psGiWVk483oUAcAd/CX9qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729893100; c=relaxed/simple;
	bh=uT3ixlcHwR/pJsPzzCSOMNg35xqLe4g1cbNUJvpNF8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TEu/tEdBIV8TsMJX5smEwhc47a727P1pacfixyaQC7CzbTlaN0Bg8YFn97qNUJcEat49rzchtyvXDBWwZIbXset7dfeyk/w+uPmbnmr6FHJWF6enCdesdWgfH61OvpADUaZ44Ds/pdp5SaFpPNlvqas/ibgCfm2Sng39MOH04Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ii+/bVFk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WWfqUV5v; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PJdXbA031745;
	Fri, 25 Oct 2024 21:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=dtWNaN5tJihAHbDTno
	DLbaY1T2Ddo7PDhnHpwQvq5lE=; b=ii+/bVFk+o2uPEqoJZ3xBoyDJGIcQKBzju
	6BycQqu47WJH/3j2sHysDCy7G5yul+pFT+eyc9reNlg1gHs3vqpkLI2NdbkFjGtE
	60RGvforP6Qpb07mChrEFUFovjwcRAzznCSgMvrAYtCGweUMHqKDYAqxfI86Kxmp
	mV4NFXj4IqQNBnrTfwldUIoUk/U3YsosbpYo6B7ZjgVXtj/jovE9CGGucGvaiByi
	Xfi11N4Q/UiF++6IH1BHWAUThmS2nMxBCLWqs33xUd7cfK9mWypewM+6sGtvFEO+
	SS8u6cfQUGX//lVmNLMnmYQO6QD53bv4R1W3+LTTpbqDnVJ0D3lA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3n1d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 21:49:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PLUJ00016400;
	Fri, 25 Oct 2024 21:49:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhed3s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 21:49:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vl3ckuIt26muPpZzcCdJ7hUsJOZTIbG0OQR12BQL+PMjmmdb558/1IThw1sfrdonhj754z81Cqjpc/pizAwDHpMoUtgnYIKDYmCrTM5ATOFC/abNbHxd1CaAT/1CgOiHGkNjYiJxb/G8nhbKut+Iv6uwJ0Hs1XwIqIxKAEuPLIKcNG8/M4GHpzZBgE9E9nFxIOGOBT7FyKG9s2O0WKmoO2CaDzI0kj7bH+Y/a1RE1nGQgcJLnO7cVkTm4AvURphIOZ/MMob6TGwMgPWE23CCUgpAm5mZumpYuCzquGKeLnMaaodRg/WNsFPjU0B1KvnSrEpPjXasNu5Q15L4FKW92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtWNaN5tJihAHbDTnoDLbaY1T2Ddo7PDhnHpwQvq5lE=;
 b=JpvNRbyFWhDcVgfRcto5LOhsG2Qd+JnWvYmB55eDYKaaNrRRHlc7GYu+KW1lLa3516iwzOJXdg5xuo4K9uweEXbcfVRFBB9qmZKg55YQ5xRqFilkHJkv+J4Ytdmp3VmdO1m1lMRkWZ4rFyEyYQDaf/hGryun9qUvDvHPzbtVYKEUtR7laoFk4gMNs0TO/LfCrUwwFRZNrT/X/+kKmRCd+RlXsCrystUM5dqgMDqoSah/EAIj342Y35yK1ctULyPturWdSgIRs4/Och81uHelVnDy6hzCT5NAS68up8U/1EWxtM4Lj5l+/L2iy9CkHb6Yh3D7ko9z9nAJPFgyjr5KDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtWNaN5tJihAHbDTnoDLbaY1T2Ddo7PDhnHpwQvq5lE=;
 b=WWfqUV5vtBTWNK2sga9w+21jwXLbEI2DvniyenSm5qlgznsfVsy82eJVINpJl+8aaNlDgH3b+dfPZC8n//BuTaPhYRrbdbZM9c/HXbBkFqt2oCAAJRxLzMGb+SrlkLbMpMSeNk7XpRkPz5BP93MwR0Os4Aw3vXOYZWgYssM3yFY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5552.namprd10.prod.outlook.com (2603:10b6:a03:3da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 21:49:34 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 21:49:33 +0000
Date: Fri, 25 Oct 2024 22:49:28 +0100
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
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@kernel.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 3/5] mm: madvise: implement lightweight guard page
 mechanism
Message-ID: <afc2c70c-de3a-44e7-828d-8c3f0396d9ef@lucifer.local>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
 <415da1e6c5828d96db3af480d243a7f68ccabf6d.1729699916.git.lorenzo.stoakes@oracle.com>
 <0ed7b766-1e7d-4f77-bf5a-bfa52d36ca8e@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ed7b766-1e7d-4f77-bf5a-bfa52d36ca8e@suse.cz>
X-ClientProxiedBy: LO2P265CA0110.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::26) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5552:EE_
X-MS-Office365-Filtering-Correlation-Id: a87553ae-c3ef-4611-066a-08dcf53ee927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?94noIFChaHT/LB7mFbKVD7FTjOfRBTTc1cX7wZ6hcy2Ngbqx7AGbUd4m2CXz?=
 =?us-ascii?Q?kufCexBV7J8l+km/nsOvEY1EXxgW5d815fO1TxAl+aloTRNZR5FrWvPeAN0M?=
 =?us-ascii?Q?Yqisk7YcMrqRdfjGJWZVijof3V9xavH5cWOncacPaBpUNQRY0irbXPPQFuW/?=
 =?us-ascii?Q?UzhYQlxYGu7AaoshENfwdXurehYp4pWfdkLTZl27naiabnWqknI31VqhCwXe?=
 =?us-ascii?Q?LtqgWil+cvgc0bQUSrUXNgWwDV2QU2wUs/MXvWfbJc9Kpx3ChwDtLoixV+xu?=
 =?us-ascii?Q?JOxJ9Jf6fwKEefy2wFUew2QvIBvdgwQpq5lOJJfarV+1l+FPfGqZqNMoyRjE?=
 =?us-ascii?Q?lLqCCuO334yuUM6okuMuaQ7R9D20jFCHZdD/pEKC2z2msM73M5NFM40toaiL?=
 =?us-ascii?Q?3C5WUvBuMCwXqreJV1C876jWUOxqAi8crIh5uD2EphDU7XF+qljseRrKM9Kk?=
 =?us-ascii?Q?+MsbLDjk8f2JNrowWl7CofDUSGftd1FKrwxb087wHDn1ZNIhV/tPhiN4uP0m?=
 =?us-ascii?Q?UvaQMV4WgxHKeSxhj0xgUysbChuo8VqfcEa2o9m9+SjUV1vmT8ZWjG/traZ8?=
 =?us-ascii?Q?96JQSlntMm6C5cfqacz0WZDkAaZC+PtNGiQzKCPgUjICspWYkuTQMZpwgX1V?=
 =?us-ascii?Q?vxQ0OKoKxDqGrbpm5WrRbN3AumbQPGE5vSacJ3FZ9DE4PeiOzYhOBmSvQEad?=
 =?us-ascii?Q?DTe9gnscp1jEew2sf6ptTWpRlFWnaUCkJESGRdaGiw4Sfz3im/V6GlJi7PAD?=
 =?us-ascii?Q?/TUYWzZXUa6uMc0GoeMJXy3k6+Y2NtEa8lG/uarKi6BuM0tjmEI9S0uix+Cy?=
 =?us-ascii?Q?zyqSV5m6KmtCQWnr99t8UgOxLu91p99CvLDPHXlHYZSRY/T+YwpTIJoYLSAo?=
 =?us-ascii?Q?YkbGegCKTfDzFucbhgc6dJtSD/dhWR1khmMkhpjkG7Tye7GYejoCTMbgl8de?=
 =?us-ascii?Q?sRgrYEw45QmvhVPbzFNcWfng5Y5Jhlm6dXXJhf5R+rHJsxgey6ynxGa48xgp?=
 =?us-ascii?Q?v+ki+4O8J6HH2/WiY2i9rxMnyQ1KmfIrXeyTUuyt7axBNXZVAcRdsADQrDUv?=
 =?us-ascii?Q?cL3a0oDyP/vAZC6JyYwWtuIHXI31ttF0AnHlqu+tiIgoEWv6q+zYPbDn0w0I?=
 =?us-ascii?Q?CrA6Txv9XpQiXC0K8ghADXFfTiPqFYDuZKBKgXTijpsAE3IaSWV2JnID9HBF?=
 =?us-ascii?Q?vrdUR60p4kMq0F+G06yKWf36sD04erD1Vc8WluApdDMFh3AFVUl/p2LVufgU?=
 =?us-ascii?Q?mdSskNm1Gcuq1bFyXa3l5yShl6KnwOaszawCyT4vh7NVDBncp2/gRQ5CkreK?=
 =?us-ascii?Q?IiqWdsVM1eIYF3RvYof3lcQ/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UPPYHmxnyIO08ZtziG6D4EQaaQtcRSczqpJkacXSmkfQK2vS1U6DkZeGlXXt?=
 =?us-ascii?Q?ff99ybQtPzLDLGCDmwP53GynQZkuEAcPt7QRQ7oK/SdP+PPavQPZvWrnCJgS?=
 =?us-ascii?Q?moeGUZDh/QHVpq3AmlBXTMjrBlAabHkH4YJ4lEPL8OLguVBfjnIon4FAldm3?=
 =?us-ascii?Q?xc8VPhmokfrnw7gxNInlMf4Lm6R6YiUxxQdbOeh/jZVG6cHDO6Syo9xVtjF0?=
 =?us-ascii?Q?yDbFxxFKzMAygoAtYjANYi9C+1do2v5n2/41FCuA+m1nm49gjOca9vZMiA23?=
 =?us-ascii?Q?n8SIZQPulbE706lEybrIVoQswr3+a2M5jQI5idKMBH+Ecgi9/O2ouGS1Z4Lr?=
 =?us-ascii?Q?4p53CpkW0nM6eiHddDpwfXpwTMlmltdHlouu4W2AssKWCnjktKQvJ9HL33kA?=
 =?us-ascii?Q?GaAShSoiuDw7oiKmoP/XXEkwqB7qionEnqyDqZx3ZBuHV4HLxBrZqaZcjRtK?=
 =?us-ascii?Q?BSYN+Q1WcAUI84iuP7ILxySSgl7BhAselvh/DS3Kbnn1WF8ZphjRmZd6Lp9r?=
 =?us-ascii?Q?1nNE8WJeZ/UE9hkL6NwCFbmjtalitOqQBV2fTnLoBpodptj+X1spdA5NdkX0?=
 =?us-ascii?Q?xNsjJBT2W5/V2h7SpQC9J18ET6PRWdDaYnJIWt7WhetEi+U1iilU9qp+eQlh?=
 =?us-ascii?Q?UUOf0edZ8ugRt7weD86HPimGuI27haQuS810slXpXKsBkNoIm1flfiVNYLZv?=
 =?us-ascii?Q?sw3RR2SJSbVXtqscTZ5AOJxiPEO8QtN5394HtQgRR1tEYZFYMB54EKnX/YQX?=
 =?us-ascii?Q?5vSQrXlyU89RJduyOXftSWM8t5c+QvjZ6LoiSwe81QCw0tfeIf54ZBtAHW4A?=
 =?us-ascii?Q?68bR0BbEq9DHW4j+BFEqo+y7tN4AqOiYzVBkePXQcBsTEK6H+CDmG+7aRmWy?=
 =?us-ascii?Q?KGXhvMus+2qtH6JsUWoNL2XUsVfsTr2gtEyEywZ8AjG1FsKNMr/Y+3Km2rGC?=
 =?us-ascii?Q?eWJHrgqVkEobGQze1tQpo3qd8V/IcVWJ1DN3LURsstEBZxmfQuqVZMAcbjSz?=
 =?us-ascii?Q?07lZeyFqKJfdmiKbadWPCKKibCHdkEcKQh6x8gavv5bV7Bbec6qqC31UaTqL?=
 =?us-ascii?Q?2RYhzth99703Ec9FJKYYwKej/1LOwNROZAtFl0SYv9LfTdW/hkrYqhvAHlf4?=
 =?us-ascii?Q?ZJNYNFNRAmEErc2h3ybp5UHdCltPIaCV76xIDKVbQ70COPIDPRTICRc5rURK?=
 =?us-ascii?Q?UzwTAHon5bjmFCb9A//IrQ0ueU+7Fg+vBUeRXDIr6hTPkfx9zJGu6UwQdTH5?=
 =?us-ascii?Q?Cq/EPJdLWX/OfQyT6s3+ERS2pcRroQI4kcHgaZOYYXVY0uGlq9pqDHAs21Ud?=
 =?us-ascii?Q?el4/79IxBNo+k+OKQKAc9uPMZ/+X+7fQIjibgrDcIw23fYF9riF0k27VRYXc?=
 =?us-ascii?Q?mMzxiMj3jWtzwIM0k2wtyVHnCuuJl+SohZceiy2yALuOFnokEILITwr8tGiw?=
 =?us-ascii?Q?OhAPKQ84yz2PWVGsTvj27aV7gv+omYL7ZWwLDFrVVZqNplcchhCKsfwMj1QQ?=
 =?us-ascii?Q?YXF/K8LKDpjtGmfPZl4hHkcjgcf97fwozBUaviq9T8/HlVF/pFeSX/kSwJI5?=
 =?us-ascii?Q?xLG92pkgWfF1tYEIrI06I06+9hxHkaCnDmcfX0Csx9Nxt+81psHq+uWAjhwX?=
 =?us-ascii?Q?ixzM5Q1O2IqnFfU70wPNf29xCgz7V2sDCNbO+HpdBJKp8jVFYXcrgWil50Yc?=
 =?us-ascii?Q?t63RoA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j/74W5pQT6wDt40+QYsM5IsjpJLaBC2AvFiS3hlqGMlEdd6o082dO7ANVBXbFMu0kmGeWOeSK5jmS9oKRP1skXo34Fj1SMglfV2zbf7hVabycYE3Qp+OczTWPQrk9ou3WHsJWHtxkZSThH3n7fyrPwlEC/MtRpMJvfXnG46GhQMnCZg2JDBVH157Jv5wnra1NI6pIwqh+B8vUW26LMO8CLFCCQPzYVIRlRc6DcSW749VLUNu9sizDQkLmBlKp+XFK3DwUZefz8yXWMZkMZQ+c7wFhKWdW3MJZcoN7G6pIvfTpGFCdPOi5CX6QFvc0eQ5G0ggmVRjeXYYnO612zo3QlJWfQHPIwaTvVMu5HBaXsJRRLvpqvqwEnV2jY9ONIBkLKV+Behd+134W8VcZKJFAr4Sns+jnt3ybvWKl1k8RvoNSrBwSFUK/DLaY180xS+xMIja8wKr2eJnoM+YnoUneLeL5nAgzftgLPWTWLiYmJYPDejR3cH7iuQvJLEE3dSqtxnu1rPv3O+oGc9Moa9nGSaUI3oUk/u211TZgA6sXdC9fPw6efLHVVwTRdQ6lZNU2j1QwtQfgmkWT8/hvt1MGsuuaVoVr6bR4c70DpB745E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87553ae-c3ef-4611-066a-08dcf53ee927
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:49:33.0871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tz8iaEA2qulmSeiwkCUR4mdKXWo77WmBxV/VY0ZeMi8cL2c5XQ+2E5Wd+ku2sQRWNeyqAoqmSWsupdfYVDZl8QjQaokPvRFsU33ZnMyTIVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=638
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250169
X-Proofpoint-ORIG-GUID: Z_3TEHGoPN5yqNbE1yNWi2Uz-qlPmuJd
X-Proofpoint-GUID: Z_3TEHGoPN5yqNbE1yNWi2Uz-qlPmuJd

On Fri, Oct 25, 2024 at 11:44:56PM +0200, Vlastimil Babka wrote:
> On 10/23/24 18:24, Lorenzo Stoakes wrote:
> > Implement a new lightweight guard page feature, that is regions of userland
> > virtual memory that, when accessed, cause a fatal signal to arise.
> >
> > Currently users must establish PROT_NONE ranges to achieve this.
> >
> > However this is very costly memory-wise - we need a VMA for each and every
> > one of these regions AND they become unmergeable with surrounding VMAs.
> >
> > In addition repeated mmap() calls require repeated kernel context switches
> > and contention of the mmap lock to install these ranges, potentially also
> > having to unmap memory if installed over existing ranges.
> >
> > The lightweight guard approach eliminates the VMA cost altogether - rather
> > than establishing a PROT_NONE VMA, it operates at the level of page table
> > entries - establishing PTE markers such that accesses to them cause a fault
> > followed by a SIGSGEV signal being raised.
> >
> > This is achieved through the PTE marker mechanism, which we have already
> > extended to provide PTE_MARKER_GUARD, which we installed via the generic
> > page walking logic which we have extended for this purpose.
> >
> > These guard ranges are established with MADV_GUARD_INSTALL. If the range in
> > which they are installed contain any existing mappings, they will be
> > zapped, i.e. free the range and unmap memory (thus mimicking the behaviour
> > of MADV_DONTNEED in this respect).
> >
> > Any existing guard entries will be left untouched. There is therefore no
> > nesting of guarded pages.
> >
> > Guarded ranges are NOT cleared by MADV_DONTNEED nor MADV_FREE (in both
> > instances the memory range may be reused at which point a user would expect
> > guards to still be in place), but they are cleared via MADV_GUARD_REMOVE,
> > process teardown or unmapping of memory ranges.
> >
> > The guard property can be removed from ranges via MADV_GUARD_REMOVE. The
> > ranges over which this is applied, should they contain non-guard entries,
> > will be untouched, with only guard entries being cleared.
> >
> > We permit this operation on anonymous memory only, and only VMAs which are
> > non-special, non-huge and not mlock()'d (if we permitted this we'd have to
> > drop locked pages which would be rather counterintuitive).
> >
> > Racing page faults can cause repeated attempts to install guard pages that
> > are interrupted, result in a zap, and this process can end up being
> > repeated. If this happens more than would be expected in normal operation,
> > we rescind locks and retry the whole thing, which avoids lock contention in
> > this scenario.
> >
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Suggested-by: Jann Horn <jannh@google.com>
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>

Thanks!

> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -423,6 +423,12 @@ extern unsigned long highest_memmap_pfn;
> >   */
> >  #define MAX_RECLAIM_RETRIES 16
> >
> > +/*
> > + * Maximum number of attempts we make to install guard pages before we give up
> > + * and return -ERESTARTNOINTR to have userspace try again.
> > + */
> > +#define MAX_MADVISE_GUARD_RETRIES 3
>
> Can't we simply put this in mm/madvise.c ? Didn't find usage elsewhere.
>
>

Sure, will move if respin/can send a quick fixpatch next week if otherwise
settled. Just felt vaguely 'neater' here for... spurious subjective squishy
brained reasons :)

