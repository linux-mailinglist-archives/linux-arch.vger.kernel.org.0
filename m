Return-Path: <linux-arch+bounces-8921-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B5D9C1749
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 08:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616761F23413
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 07:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B2A1D0F6C;
	Fri,  8 Nov 2024 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QTronoNv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wztvq7lY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A02E1CF7CE;
	Fri,  8 Nov 2024 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731052237; cv=fail; b=Gy1UJMcx2V2SrL9f0JpY4Ik2JjwV1aBHg9hWC+iRAcyujO4XFTKCWhl7A6V9B+msL9ZCXqrBYaQEoq6ZE1ini5MW55x/+IZUk17jlDEpnlKhOtjxtNDQ+qgBaGHGV7ZJnchJlywy8Nx/MumNRubvfd1W6Bve6kWahKDIJacsmZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731052237; c=relaxed/simple;
	bh=G68a6wx/HG60xy1vdF9A8ucGG+GohaKsz0NBwoBNwWU=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=RJQprFLb7bDdiBFe7JsSr5AlssBHTehrp4h43EVQZBQkAwJblEteqzCGyPHrYL32XcdOPE53FEXnqbSTn02dK9pkMRpLK9jm+lc+IDtaUjCAnKHZL90fWlIXdufsdXGnY/R1bywNZ0Z5hAB4xNzkJdEHXuUq+jam0Xw7n3h2YFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QTronoNv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wztvq7lY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A81fg0l024083;
	Fri, 8 Nov 2024 07:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=G68a6wx/HG60xy1vdF
	9A8ucGG+GohaKsz0NBwoBNwWU=; b=QTronoNv0zFe/lTxxQYD/sfKPkJfHIIFJs
	S0Gfof7T0KBMfKOe3iD5Asi+fi0fczQBgS6iIcVNt9GuCbRocC6fbDX5o58vdENJ
	1mKi/0ABkIku1XxDti4xk0xa6lJ+e5uhE+8G55GJRXgNUSW34HX/h8Rb3nJoEkXF
	BshGAf1s4FXPyDW30IbHVX7aNQuX7ffoUiGI4joqc2wKUfPVP4UzX5FwLhcX8pgk
	EFma8TQkqF+JeatFG5rocLUBNWsvxcyIBNvztIyVsBSLwcHvD9wnFhBjn85dp3fd
	Jp6ZeQZRBy/Q5114LO79lI12HKVdw+J+Sce8ivSFZMnWzPSVKLAQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42s6ggrn7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 07:49:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A86kHZr036450;
	Fri, 8 Nov 2024 07:49:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahhf8kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 07:49:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXFA6nN/vpzk4X3YRGYcw6LreVP3ZkcHpln3PdjmOEul4visWIGnnfiibhvDNGI4clDxAqzkPPeMJhnN/uRvJhDDoU1gwzEIitXmgX1shxUueNCGleB9mE0S7RUXVdnP2BcW41D3+Demg7iaF5koXqc5+eYPBWRTH7eZaY5QTQvemz0nTb1IJBnboH/l7C+bvPPGb2rv3unp7d0UfXhDV9LNNj10X0zEAyJVHzyhKmWtMfaN578hsHQHK3aqtGF4POf/0Tv/ysZYvrAczsH41uR4N3y95HNujntOl5jh1ey9U6YkN2FSOqWnwSS3CH7H5c59tWS5tbimlmZpa3SADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G68a6wx/HG60xy1vdF9A8ucGG+GohaKsz0NBwoBNwWU=;
 b=OnJOe7AVE4MttgH6RElbjaWdS+v9rXeLic2UA890x5dnLPCO77iT+TbIKmQz1wgjXUbbyo0tVAjw/csdWwEs2iUdHPWOLTRtlWlMUR1JI21Hj3i+FLnUirEsZQZzcScebHE1uYdiKdM//7atXxFgNZe3UZzqtlO+DaQc7VVGRnBmymmgUIQ0D1BkWn585cvzRTLVxFaWUHr/bvCsNQCU5zMp+UxUOv8rsAgu6lpS8oyMBmfsaBo6AmXXFsMVft2NxPCFTM9NZXhjnrkZfvZ/U02zhglI2fPgdkaNagjAGxfMJFR7PJMEuY1PWYNYNWWQZnzAttlwvW5o3pIIhvVaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G68a6wx/HG60xy1vdF9A8ucGG+GohaKsz0NBwoBNwWU=;
 b=wztvq7lY6mNXgzLXSVU4BPguwmhr9qphuvc+R9XVbZ8fez/8iZSXEjUFMOAI4R0gLU3PWZe408VgVbfv9cqlSHIOA/5hqgYzH/e5ha36KQgubbk2fpub50dW4ZVz1nABnUQV5i3Flxj0lOf9cUSKp1nmg9FwIyTvfB30BUtt59U=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB7187.namprd10.prod.outlook.com (2603:10b6:610:120::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 07:49:41 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 07:49:40 +0000
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
 <20241107190818.522639-15-ankur.a.arora@oracle.com>
 <db90518c-a0e4-02cb-87c8-ea2609960dc4@gentwo.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-pm@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, pbonzini@redhat.com,
        vkuznets@redhat.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        peterz@infradead.org, arnd@arndb.de, lenb@kernel.org,
        mark.rutland@arm.com, harisokn@amazon.com, mtosatti@redhat.com,
        sudeep.holla@arm.com, maz@kernel.org, misono.tomohiro@fujitsu.com,
        maobibo@loongson.cn, zhenglifeng1@huawei.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [RFC PATCH v9 14/15] arm64/delay: move some constants out to a
 separate header
In-reply-to: <db90518c-a0e4-02cb-87c8-ea2609960dc4@gentwo.org>
Date: Thu, 07 Nov 2024 23:49:39 -0800
Message-ID: <874j4i412k.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:303:b6::17) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: fb265b47-4c3e-4012-66f5-08dcffc9e6ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YyBM+8ZuhVGsfPApOJCmbn3yz5Suf//RZ61/hVcJwkQ6IFsFPwfaaw36r9Dj?=
 =?us-ascii?Q?cb98Cpt9avRFk/C5nxS7nwYEUrBLmA9rMBGV7VOEj7NakGYI7ox4HAJIpmGM?=
 =?us-ascii?Q?bVKRF9sWb+0l5t42sP6T7EHh5Ph5vdEsDPvwuRVoGQ/ser8h/SOrHuMmBfDM?=
 =?us-ascii?Q?koY1EkQlFqSQinQWLAVsHE3Frs0S64zL7xjVBbEktyJqQIoHW5NbK7yfmthG?=
 =?us-ascii?Q?zP07JXYmJRxUSHlg6tr1hYU0pvmZR6R6+pl1zT1kGvwnyIxQoQ3RTE74roOz?=
 =?us-ascii?Q?ObxelshQDR0hTZSgnl0taf5kzMNAyLDFyCoG1LcWvZkxCj2g/eAw32qgnmym?=
 =?us-ascii?Q?HiW3A2X1RSiEy63V1gbRJPpoyeEC31ND/rmmX3ogvmlfjtDK5jzK6qyVk9y4?=
 =?us-ascii?Q?G4oPRSZ5w7PAPJaNaU1hWKHJO1XpiRAFoAyUgJfyV9UwEGalMiqxd8AWLjuZ?=
 =?us-ascii?Q?rv/Hx4cn+GMGV/OLtHagx6GTFYvt1S70g05ub/ix1GTuU/F9M9MXeu5+NIQb?=
 =?us-ascii?Q?rMCh83bzLRqIDRSM6+D2pS78GNZ+I7GE3apwyUb8kHpBNp0o2+FH4JocHDCs?=
 =?us-ascii?Q?uluttxzcSXD/uXWzk9bAHeRKYrlsuInvpb5eNkMR5+i6j+x0jRA8CO3E+Mld?=
 =?us-ascii?Q?LxkjdKvH7Vh49t0lg94iz/7QPmE4xv16sHW4dDP48adhWct9KpKhXuoYo+G6?=
 =?us-ascii?Q?NtxIhed49ejDEdb7XqNkCAhQWxGxD8dxBWIukhgoyp2QzSNYLckLblpyVWF5?=
 =?us-ascii?Q?Mpfx10XI6rC1lrTUcS2e6PzD/xc47eIWfUNcW7n4593voQlU+ZzZzGROQHag?=
 =?us-ascii?Q?wjFo7INg89YkiKiJNW1LiZMM+RgZVdJGY77z/AqUM2t5yxsF13yE1B8+tJTa?=
 =?us-ascii?Q?bN9lOvp6GhXUNiiTdsbGKfeQbfv9zE/+1zTOecWrGC3FeprQQoqFiFPV2Pzb?=
 =?us-ascii?Q?juFvbby7805pBp36zFH/gIsnWyXfDN3uuNRhneiRA+J7wS+QTOQCEuElTV4G?=
 =?us-ascii?Q?f8SOT+/PnZswjHOOk3v2PJWHXWSGQf8m8+L4PZ3+j++RjHOn3U87HAslffYd?=
 =?us-ascii?Q?U9nKXJqjjb7I+aIPdACVjW5A6orK0dVpUZNGAwWtGKr8EDXlFQkJlIHxT6A/?=
 =?us-ascii?Q?LFJZ3BnV9SP/yHIBMq85HLlRX2IBahH4DhvSDMaz9hkupVeIdHq5/FYy4/Cr?=
 =?us-ascii?Q?z2xkB857DTCHEYKKa0zldyxDgCtLvpQg+KLZItY9JRLA38BFaYnmdAh+UDPF?=
 =?us-ascii?Q?6MpK+aQzxYDis9nXzLi2z9ohfvXB8SKUtl2wVVfROgATo5kk7xuK5+GkJ8ZX?=
 =?us-ascii?Q?MOXvkdTesf4Ddyuuyg5bxITy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fdABrv8B3uCmCg8mroPmJODMAwMB2866+NVwUsd3+Ii0HUDT6OcigghLal8E?=
 =?us-ascii?Q?L8r2QPX3RgW2iGvwCR09bFOwODLitnbUZYZJoWzLNJRpekwFC2BXmu8G9qQv?=
 =?us-ascii?Q?LU6ze7+sb6xRivZHsoDDlKHh9weibNvX5s9XCoeaePawJAnw61RnGxIj0SuD?=
 =?us-ascii?Q?Ytwz/B5W2l6MLKr/Ic9Nl8sscw/g5hYE69A8BCmM3Y2qUd+as7hahzig8YuJ?=
 =?us-ascii?Q?uAEp4d5c1jSmfkqK+5Nc3+jOMrkwce6B3eWiQijlAhIad8q93AQNsjdgJHgf?=
 =?us-ascii?Q?yyJO+bIzwBNvYXgRkkyTrUhhLSnaA3EAJ0wTjKkdVQHA18sBHdZFxJp//Av6?=
 =?us-ascii?Q?bgZx34o2xjIWZjbdnCpubK4yJ6WNdJXKsfmZrhT4NH2/tQqm97rkb9hCKirm?=
 =?us-ascii?Q?oKtyVd6SHJn10RQ4p0TUxaMxb6P7F0wHnIFRGvbMVyv2IDiEfipcGE78i+2W?=
 =?us-ascii?Q?eM1MAdTrvoKdTGwOJyQG6xTI/P2sqwQ2snShBfffBOEe8i2N9Y/uf+Z9veaV?=
 =?us-ascii?Q?/oKxNYINvDbkSB/0uJPpeYgcbminNzBcvpGf7I21kFQermUQpgrjXUHlBrRd?=
 =?us-ascii?Q?0hOehunpyDjAECQixFn4WKwuhyjJvZKinQ1Bgx9mudO7zc1eyIa7SLMJXuOM?=
 =?us-ascii?Q?++6GAkZNX4ahvpMZWSWkqNJa0c8KBUhmM7JeIPi4vYEBhXFY580mpFa38nXx?=
 =?us-ascii?Q?V7JelomGRNMHiqI4ldO9bEsGoZvAAxfhCV21JtuC1qTe/MPwXYrbVswE975y?=
 =?us-ascii?Q?Il1eqWmYxdU6/50EAkyqji6sWPRrnTYRbvsAWErkVf406LyDh8gs3i9VtsKp?=
 =?us-ascii?Q?8nRymU5Ni8F5GDbZKPzRJuH0U1cPR1axtbyqPgAqf2srxeeNv6SIa9MybIEt?=
 =?us-ascii?Q?xSI4Y2pyQWzHWdtJyxfAY3blxdLlJ8ROT+UAIX8EY11oFWvpFI6Lfw10YSBH?=
 =?us-ascii?Q?KXwqPIXF8kcHEmHuf+alm4XxT9hHBOn9F0fSkJDomZRDrctOJC+EyB5Wifen?=
 =?us-ascii?Q?K8qro7kXwB770kyXZP/EYpBq+C17yr+2AI0USVFAfSGKB5OUsPSqMb8xWa8Y?=
 =?us-ascii?Q?d9aV7kNDpWjsfui8iMimw3o5YKGhQev58O3IGg8ArjDcOeVBVSbXHPa/BQwb?=
 =?us-ascii?Q?smvwP9CYawil0t0L7wWZ1+6mxEvQ8No7atRUK1uDBAdjBKW81Lgu1X/DlmG8?=
 =?us-ascii?Q?IpfG14ZYdzDjNyWZ2RpzT0Q5PLk3YHttUdAeWb2sL0e9s6NEsWrQza+mmije?=
 =?us-ascii?Q?aLSzCpfVsG4sKJhLKmOxvZUlcsAcQSl2tzHY+ztLjIc1AjVOcSg9NFIbuZvd?=
 =?us-ascii?Q?KyF3Ai5gjVPjqcQFpW4p71hnqWR1JrfmUBQoOzyVEacna5U+9L3kW0ybKKyo?=
 =?us-ascii?Q?U7Dtf4DNgrmuldR73kFqcnV8yZL8MQbR3iAkbSUprOPz4OvZ7zM/MZp4eg9H?=
 =?us-ascii?Q?MDvfpsI4PVAk9VpdA9xbvp6dfALV1FwfY3kEgRby4WMwoT7Vy/SnBvuaWzew?=
 =?us-ascii?Q?goubVH50/ighrWUx5YlNxaE4GgUA5L/T8oU9K8Sx6ocm9Vzi0mf+oW3h15bc?=
 =?us-ascii?Q?4KPGoHEWbmZw83uRir1NvbQhziwJxvdKIPBHeHWHea7/TnftAH80MJanziOC?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aWehK/zVWjgcEAx9xl7sZUDq+/gkFP9xb7gvYqRu9l7e5E/ptl7Um3K7U22J4xRo8SELYLU2vi9OoN4LBTsqbntTvC13TU07UEKgq+9UY+m584bB2w6iXJFGXIk24z6rqHqs/ghDkYQKu3ZNpthDO2V+9mesf/pejq+XQmKkRzlO8IYHt7DmvHL/k0DY2VI+jev3V9+tTanrJvg0h+JsTQyOied3462bKpk9WwTosor/7/Ru0n4EuPzV7tu2LKl1AdFyUW8lSx8APfF+rtsidjNBBRDvdiZNI/d4/7QzW/GR1hsiIEN3YwJ+zghxwXrkPPJ3fIwx3uJHOIE91fb+yVHWAGcDYQ4plDyXEJ0ZSrz+OusiM3RlupwdZPXqqJbXEYT544WqrahVh1sDH5FYlprBccYA64KqbBHlaw5L0P2ENXilpwib5Ey7QXD46xBWXPBlS9tODNmiN949OtGahDsP64UtAR9jBuzknamIsXifjGK2lTiVAaH8IWTE7bwr0RJp9/QfXPV/0i43GBq59b/UxOa5rGk+/Egfko0dpFg42O8tdUNLPkyMbiHIQCtL4ZoYq1h2Hnpjr7rF8oovg5hmEG8XFpZhSYcREdLpI/8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb265b47-4c3e-4012-66f5-08dcffc9e6ed
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 07:49:40.8875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IX6bXANuJPLhwxB+devTL7XX4qybmarkr1joSwVYbVJhIfdA0vgqB0wbTnWNi52DcGIIWA2rYs/gTYljipncM9a9YV6BvzqKARo5Aj2g/8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_06,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411080064
X-Proofpoint-GUID: jOuq-T1gmDGcTT1hE_IjR7zY3vY7uOBg
X-Proofpoint-ORIG-GUID: jOuq-T1gmDGcTT1hE_IjR7zY3vY7uOBg


Christoph Lameter (Ampere) <cl@gentwo.org> writes:

> On Thu, 7 Nov 2024, Ankur Arora wrote:
>
>> Moves some constants and functions related to xloops, cycles computation
>> out to a new header.
>
> Constants are correct...
>
> Reviewed-by: Christoph Lameter <cl@linux.com>

Thanks!

--
ankur

