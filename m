Return-Path: <linux-arch+bounces-15517-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AFECCFD80
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 13:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D117300760E
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 12:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C3432548C;
	Fri, 19 Dec 2025 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PWUOdr94";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ACcL9MIk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53418320385;
	Fri, 19 Dec 2025 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766147922; cv=fail; b=jzTX+vBCSuTe6DBKdwTG8qe8A5zEvRAVwPcqSytmT2dbMW4rmkG84mzv+qfDrBEcQaUH/4C8Xn1XoCjuYcKgRE9qIFAm1+7j+IpJAlZedcHDZpWd/+6jKNhFrg819EuNgO5qypdDBuecq3U9UDFwpR1CiCpWRA9hQ7IfJLJJ6J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766147922; c=relaxed/simple;
	bh=TfHOKWNA3YsZL3njTdWvL1BU59+TTuouvRXwKlLoAno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QIdTgTpWmNrUZCYf5yAOn1Ce19a+/qkRUCu0EzSIGFA+tInDhJpjv31KjQL0qcku8XjkRFSeUHhxMLrB9e79uHz/k7Lc6A7Oge1IWBonq74nVUwgRJ85+QrQ1a+B8bCgtrz6evojdCooZYZtMNTO0AZJZvQD7JSASJgRHDyI4D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PWUOdr94; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ACcL9MIk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ3ECYS2849505;
	Fri, 19 Dec 2025 12:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=a7seG4Mx/FQpepvs3x
	4ApoCq4XThElEwUq0LAPZiZJw=; b=PWUOdr94ADK01kGBDkejlJBeuuscfZ0EZ8
	+bs72dsFzcE7XMafq6rftHpySeVKU+C0YB9n9nMmW966svRGMy0BlzTbPDE2atGO
	WV3KtaKxfNzVIq42F1GfWUQ080a2IOsdQSoELRttguRDJToWU7xl+tcdD90XKj7a
	0WRo4tQwW3dE2x/iSIh1PF5ACePS2IqyvYsAaWh3aIVD6ihEjoepCiax1rIdXDlA
	j53YRr8eceGCR6MGUcqN+dBpOwQ/5kKMwy/jPMWpMoD2gpmKdzmc2GtwHpN2Cgp0
	1ZWEEEIMvAz9p8VyOko6UfnsTnWqtOlHIf4YfdfOW31N4X6BIp1g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b4r2911w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 12:37:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJBj8vl034968;
	Fri, 19 Dec 2025 12:37:37 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012028.outbound.protection.outlook.com [40.107.200.28])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b4qtdcvq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 12:37:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLuFjlx3U5NqQV2CfY0vk8AirhGoYlYg/hVXFSpG93SMBHaP2QUz5dnqN9Wx/tt9+llFVzwLgOWi7emqLsfgmdNbv4+Zp6UW9mTfN9uBaTtTwEf+Dr9MkPvfhNAcvXVwmhAamh69+L4YNkhyfwrsqcvB4SmH/tm8h5qpHGqMums6y1FpSSK88IDr+LjbDsKZzyGozYEWNlT6EpQ00bMWqW/rn92dcisOZYkyfZPoLt+Eg9lVHZRh8TAp/ah49bZj8Iumdsluj3iT5Z1ZEHJrmswc21Xx9Dt6p4ehYEhrTTRbMKv/5nlOv41tMjaSb2tMEevSQvWL2Yl+u/D78ttjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7seG4Mx/FQpepvs3x4ApoCq4XThElEwUq0LAPZiZJw=;
 b=Qs6UBpHAeTyIgVCg9FdZjPj4sm2UOetReyG4gk+9VqgNIp2nbrvhLvUOp7K/hiZmniTnVHKHtAPvOvFS3Xm/N77M0f1ipgq8in262xadI6yg544XNe8d9EymeKUnlaahxOhYQN7kguzYL7tqeADVqy0gVsUauVnk5fmA4l2HFAaXqVMn00X0BIqL6cdjwn7LfHVGO9AZh3PCIoW1Nac6fAkwEpEANYrJ8FX+ivOliv/bRYKdKCCcwUQB4VMBAZFE3GE2xWBtM4HS0ftrA0ml5mnqSMq4k6bD/TIUaKgVGXi9Oxf4glKAWAK93YIUc/EyyReln1FZH8FnMUWnAMZBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7seG4Mx/FQpepvs3x4ApoCq4XThElEwUq0LAPZiZJw=;
 b=ACcL9MIkOBwkwgNyays5BMrAZ0DogtifHrfbU+tQ80q1N3posBlnkUlWMC8POmWXvrNvwJ286CAjBGO4Fkf+ordMna+FPgB/vXtqasDplbXM3Cai1iTnhzH3O1E1HX3A5F28A9B7GuhjWde5Oi9hwtjIuob85JVaTAm51aqcAmg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH7PR10MB7849.namprd10.prod.outlook.com (2603:10b6:510:308::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 12:37:33 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 12:37:32 +0000
Date: Fri, 19 Dec 2025 21:37:20 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        Laurence Oberman <loberman@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm/hugetlb: fix excessive IPI broadcasts when
 unsharing PMD tables using mmu_gather
Message-ID: <aUVHAD9G5_HKlYsR@hyeyoo>
References: <20251212071019.471146-1-david@kernel.org>
 <20251212071019.471146-5-david@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212071019.471146-5-david@kernel.org>
X-ClientProxiedBy: SL2P216CA0133.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH7PR10MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf61a40-e376-470b-1fb5-08de3efb6111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DJf1DWUXxdsAMEn8iIiR+TrQRglbKa0wTwk75OaKo0nPvzdH5Oy7dDlmLt2V?=
 =?us-ascii?Q?2DZGXHziLa5X0DkRDRjcftp6jjBumhMqaqKKVXt8CDr34DHlRvHCBvXAWoj8?=
 =?us-ascii?Q?8IYDY8SlCr5ks65eZPZKE0mZGRl2UpopqJHrVrUSnSUE5mB1DM1SayM4cJ3j?=
 =?us-ascii?Q?2xHJ1nHuYiBs54D18002HPj/MQsp4XP0ZMJLKjuvLeVeJpbM2dD3CftQsXY0?=
 =?us-ascii?Q?auJKrjNYGKH9UUUeHYDVvu5oDV63nRjwNrojD4DgdItxU9vOtd8Jz80nz9K7?=
 =?us-ascii?Q?fpW/UKXUqrWwNDUFlNGvmtc+KtRXbIe6usd/wUC4oYKl7jcaJjGBE3O1jNkX?=
 =?us-ascii?Q?lvI9/b7L7CKCVSPCVKUeGwI9wbTpIpRdrhdJSIYBIAhq+5Vx9nnSCuwKOAMi?=
 =?us-ascii?Q?EFOJYPNs1HbQGNnZ4TNAljYf+4N+5xVdu757nJWonutG5Zl2qA4VvktJtsqz?=
 =?us-ascii?Q?WW3pv0Hds6HUzng2zcyTxyNjQOsA4m6TrmiLw6iPUCX/Q9Jxngh/mWdktqAa?=
 =?us-ascii?Q?s4OkpA2jK0SiAGgzZY13L6YM+MtpYUHbvDMmC85cgYgpWCN2G4hlA8LpkrcN?=
 =?us-ascii?Q?L9JXJN6fWD81H1kHyyopPwBsUAdUnWC468U/Gtn9pugENRB3oXokIZpupTpI?=
 =?us-ascii?Q?h7taaPWrGDzAekVUsW1xPL5mGDTYdrDSQYvNazI/E20VhaUOH2Q5CdURyFQO?=
 =?us-ascii?Q?rVJSQ19cZoo08DohwhmgujC0EPKmYQ9lzXJdfpCfQmduwR2sbrxE0Vkd95MY?=
 =?us-ascii?Q?srZUohvd/066y0/zEcLNXOrIqA4Rq5DoHqPBEeRHXKBI3cwYWnht8I3Igy5w?=
 =?us-ascii?Q?oyipf7q6H/N78siMarypK2scVR1S26ETeEu5au1NIs7qprE47IrHpS8S8G+T?=
 =?us-ascii?Q?2xT01+82P9xlM+Z5JP2qrrbISJXbu+7mTzofNxyl3mV4eYU8G6O88JIZuyEl?=
 =?us-ascii?Q?gGlp4SqYNqITqyMyxZAHnt3Vhrpm1ciUahpgJHvIAn7tPDObJQj4u2YycDf5?=
 =?us-ascii?Q?xMGl6qfEAo8nJ7OutN7SerCpoBH4xSV59/N8w9DnkfNsXy8K39vf2CcgiUT+?=
 =?us-ascii?Q?cS42b8pt1IYt6zYkk2zmIEKPepOeqXvu6HHaBbv7evhnvpwhEtEk3KaPXE8s?=
 =?us-ascii?Q?soRAIU2Foa7cjE7tdecPmsVKDah3Itc2Xm56f/Sn68PWr32G95r6E4zrkuYI?=
 =?us-ascii?Q?WLVZ/GeP3EamClxLAYSNndffHR2KY7lRnASe6BL4sbL5Gh0mgAQYMtWBHhHP?=
 =?us-ascii?Q?82umAyFY6QZ1wLUK/qRPw8SrQLA/nvtAM94X2yzlDxQmo5L0Jo2TlfEtIJjE?=
 =?us-ascii?Q?3LRAnGr3FNQNFlNBZcDc3pR7bzjUeQWJDtH6ni3z1f0Nel6R4t3+YMNIbqxp?=
 =?us-ascii?Q?jBhSwISspjVQkG76kHF/Kt7NWWJpl1mKrxoytqamHkj/zEpijWv4AGeb4I3r?=
 =?us-ascii?Q?RVtfk+otAKyu42295S8VJeHXqkNlIwJG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UYmzcxeJiZ1rvoYuXNBuhxCpNndaVUn4dpWRiwGUX3DyBWFxhZHtxHfbaSF4?=
 =?us-ascii?Q?BEQreAg/dBE7hBTiIBncHL0vOHFBtpnkOxGu/c9qTqrnzBnjMSIeTvLVzAPB?=
 =?us-ascii?Q?jGYrLZ5VMhqg5/KAIGhRxJOj0zykXuHP3CSihLRVmSy7J36vc4VB9rcHhGbX?=
 =?us-ascii?Q?OApbLfKYNMTpskhNQX+UV+ZmETp9uCDwcqP2SoJqMyoByDdY6K3m42ufao0b?=
 =?us-ascii?Q?/IZSbmUiPecDKdlsLhes04aBHPYT2j18n7S2du+pS44EqMNLWendJ3ec0B7O?=
 =?us-ascii?Q?GXIpjNAmrKZ+eoWf2XtOpnZMcbCRRZvKUAJ5mi1JI9Sq04n6cflmCpkYbFdL?=
 =?us-ascii?Q?YpHGjCibBFcc8lmcVBpsYmVOGXuaEO0qHLwydavEjTiBNRaBMuJVqi3Dg926?=
 =?us-ascii?Q?lx8OaYtG4uP0PoAleOkrYFIcApZS7KaNkTdoMP454172Nni+mVNO64XaMih6?=
 =?us-ascii?Q?qq7//KdgQfyAFS3PsonVdiVdzC1EsUCmhZ/X+sDq2FOnq08t4jNDjRfUQSmQ?=
 =?us-ascii?Q?lNk5Y23Z1cUDXt8pdFvxCxT0AJ5NyaoTcazLmUpM7jl/hyquvO0072ubRx2W?=
 =?us-ascii?Q?z1AF9Nn+/i3OmE3t7Q4JcIOj2QMBv6iLWSzYxTSTz1ul/qpk+GG4yOALZtUG?=
 =?us-ascii?Q?TgAKLugcbAhGcAbpcy5N8pKuK5pde5HU+bQEzMDfkCpcvivV6ldN4wRSGiLV?=
 =?us-ascii?Q?M5iC2KfJG42WSnA8p3/8Sn9qMPl4KEsltANINMNZxBv57RIa2c6rBOr9FhST?=
 =?us-ascii?Q?68iJEfnGuHpFmIrOiWuISJh71VjtZNGahsoNMeKkpsVuPPyVpeqtF183MrjX?=
 =?us-ascii?Q?Bu/T/Qv7+a74kVBeybK0Xj6A76Liy4A7mh6+Ge0Mp0HVAkFy6ktSID3oijT/?=
 =?us-ascii?Q?qyJgu/b43Q8j/kFxkC7MeGjXbkRYMqRiP0B8boh5ub8uk2Jtnr45lT7Wp2YD?=
 =?us-ascii?Q?XuudPpbXrNMcU2JCBbQ/VfLZUuyRdEcjKJMAs7SbU7FMP39D8ZWa4uFn7jkI?=
 =?us-ascii?Q?hCBBl63deTiIx/H2USx1fAxwbulI/farSoyz4oReGpwVhmBALP0KxFEqxO/x?=
 =?us-ascii?Q?/LncT6jnqQOynKTz+7G+RF0g3lKaSsd/g7qX1FKPA5iA6Q8m7wNy5NK4Ve6B?=
 =?us-ascii?Q?0ynBMvNFSlRRdP47itbDhDo5AvDzD7oueKX5DpkozBNWu7eH2kDKCDGvqRGn?=
 =?us-ascii?Q?uD9cXLKHpbJ3m5qAA0zWCa1P+l5BWxe1E62StKHBTUnZK9uaClPkzU4rhIzd?=
 =?us-ascii?Q?10WnbHCC+AHghhsDPl1TMYZMdBqwwaiODN/mlScAVNx+cJmQogEjdQ00/jqj?=
 =?us-ascii?Q?21yT4JBG7L/cBHWJS7a410NTCMSCeVNxOvDnB34TWY8Bhe/YMpvtZRwVm+yV?=
 =?us-ascii?Q?nYV+qVJXyOYgrGk5dwm/+aWwthYYANFaCwgPkVagVQN0i+3qvwP8tSP6+hwp?=
 =?us-ascii?Q?d4ie0+NZ7caLZjTSZruI/lZ1+k/9POxBlcjWWmCRlgVRguSflHkr67BTeYLi?=
 =?us-ascii?Q?zkhw0bmS//+c0CMX/F2PzbvNdP6ok8nqfn9G46r7eK1wKYq92ADaawwpzig8?=
 =?us-ascii?Q?9T+Klj7TTqeF5+GqcdMCpe/kuyayx5eusR156WN0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0ERilaTYrIEpMQjSHlSudyXLGDZDirPn+waryeslCxEpmX8yHcia5YFzYTMN0npK4aXzMOwbzcANOsn5L3BMa7AiSHN6k0st9brkHVynS0fG5B0qujGKJiJHd+cMSTYnJ92wKU3m39qV06Pivl6PLejhbsr3Xopk9UyxVhiEMZ4ddAA6OH24IPDVBD/yacP16JE7LhPQTPs34+6TDBjJRe2DSoHD60j/Nd0l3VCNeL0lOBiirSHC1f7yUA8jsJr/bV2BqfO9h45WRY29Mumg+7QyLFShUnqNJC2K60nikN9dXkP+IUz8EBi1qzPjQVhrF/NLQomeXB4Ven6NHhsKcjs5OZ9Vs/QsqHaQH2EegF2Jzlui78j48bQbsbz52jZUQf5WzEpxsdJQNhY00a9sS+LncmFYfmD4ApTP8e93vLOJWqIg8/7fqo2INkGZ4ZjH2IGam0EuxVge/5Tye0eOg6hGeS/EwKJOwtl11R0k9UQg98/iRA8TElWcE6xwLY5HScoeq4gbFkY/p4N56WpzS4Fn92pygnU2no42GGruKLNMPSfjMeTEFV47m2tlPcwvg77dOqzXW4s6HcyMxD6HClze97k3CXyhpDzuhLfRAPo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf61a40-e376-470b-1fb5-08de3efb6111
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 12:37:32.7037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7f3JHSUMgNuY86YqT/Mp409gY8eFOvZm7HR7+KsUvEY3XBF4lwtuMkJoxUXk6sCd2TVKoLOaG0NiX04dMz6CgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7849
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=574 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512190104
X-Authority-Analysis: v=2.4 cv=WZgBqkhX c=1 sm=1 tr=0 ts=69454712 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=R-GeryFALSzeIBm9N1cA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QIpNNl1hjvqjTASHFDpoQY0E2zKm-_kr
X-Proofpoint-GUID: QIpNNl1hjvqjTASHFDpoQY0E2zKm-_kr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEwNSBTYWx0ZWRfX4y8Q5/nvCpEY
 wnVfqHrjZtbS6ttuUYMPV7KP4yG4KU+FVfQy5v+AIqKnMXCmJHP9PJi6Ib8/rrBTk1SsfiwOSem
 RNjR77i0BZ2xtkl8qPqC0CPm4hpil5PcBtZxDMooFAW3fB+2wHG6NlXFfVYDprDWUBGKAQIjRKB
 p9hQG1HxW81+Dqj/GfZuonExqOLUxXTD1lOnucXe3d1cpAvfif0k7PQOtfi6Aaia5iypJGCClan
 ghz9WV/lACpPT8DlunRPCViVcLfefPIgEb6vD8/k2hdnbB2ZWHBrduxPhcNEJ+KgdbLRipufEHn
 K64HBKOc39LW7OSSFiNAXs/mlvzoMcMoqtJix4zLoSrZL7sUFcpj07fOB2dmCPz/O82PYzesO2L
 6BXyG15FYGm1Sqtoz3OYvUQ9kR9wiXcho9i5GGClfbKf8urq5DFuZXz0sIlxGiN+itsd5t4RYya
 w5pHdDi80lXxcchPVtg==

On Fri, Dec 12, 2025 at 08:10:19AM +0100, David Hildenbrand (Red Hat) wrote:
> As reported, ever since commit 1013af4f585f ("mm/hugetlb: fix
> huge_pmd_unshare() vs GUP-fast race") we can end up in some situations
> where we perform so many IPI broadcasts when unsharing hugetlb PMD page
> tables that it severely regresses some workloads.
> 
> In particular, when we fork()+exit(), or when we munmap() a large
> area backed by many shared PMD tables, we perform one IPI broadcast per
> unshared PMD table.
>

[...snip...]

> Fixes: 1013af4f585f ("mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race")
> Reported-by: Uschakow, Stanislav" <suschako@amazon.de>
> Closes: https://lore.kernel.org/all/4d3878531c76479d9f8ca9789dc6485d@amazon.de/
> Tested-by: Laurence Oberman <loberman@redhat.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
> ---
>  include/asm-generic/tlb.h |  74 ++++++++++++++++++++++-
>  include/linux/hugetlb.h   |  19 +++---
>  mm/hugetlb.c              | 121 ++++++++++++++++++++++----------------
>  mm/mmu_gather.c           |   7 +++
>  mm/mprotect.c             |   2 +-
>  mm/rmap.c                 |  25 +++++---
>  6 files changed, 179 insertions(+), 69 deletions(-)
> 
> @@ -6522,22 +6511,16 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  				pte = huge_pte_clear_uffd_wp(pte);
>  			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
>  			pages++;
> +			tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
>  		}
>  
>  next:
>  		spin_unlock(ptl);
>  		cond_resched();
>  	}
> -	/*
> -	 * There is nothing protecting a previously-shared page table that we
> -	 * unshared through huge_pmd_unshare() from getting freed after we
> -	 * release i_mmap_rwsem, so flush the TLB now. If huge_pmd_unshare()
> -	 * succeeded, flush the range corresponding to the pud.
> -	 */
> -	if (shared_pmd)
> -		flush_hugetlb_tlb_range(vma, range.start, range.end);
> -	else
> -		flush_hugetlb_tlb_range(vma, start, end);
> +
> +	tlb_flush_mmu_tlbonly(tlb);
> +	huge_pmd_unshare_flush(tlb, vma);

Shouldn't we teach mmu_gather that it has to call
flush_hugetlb_tlb_range() instead of ordinary TLB flush routine,
otherwise it will break ARCHes that has "special requirements"
for evicting hugetlb backing TLB entries?

>  	/*
>  	 * No need to call mmu_notifier_arch_invalidate_secondary_tlbs() we are
>  	 * downgrading page table protection not changing it to point to a new

-- 
Cheers,
Harry / Hyeonggon

