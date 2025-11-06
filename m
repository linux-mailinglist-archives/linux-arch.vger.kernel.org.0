Return-Path: <linux-arch+bounces-14551-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 744C6C387F6
	for <lists+linux-arch@lfdr.de>; Thu, 06 Nov 2025 01:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4263ACDBD
	for <lists+linux-arch@lfdr.de>; Thu,  6 Nov 2025 00:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497A319F464;
	Thu,  6 Nov 2025 00:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LpR6tdxY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="egjHM+K+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CDD4A32;
	Thu,  6 Nov 2025 00:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389411; cv=fail; b=arjwBN6Dcl0VArrXUUpdFXwjmNuhmTVaXqE7npCxcsq0zv6Z4siL9HCyN7WSzEG5c8O8aCpx7OZEOcW5RUsnK1a/aHL+BtN+5Ueys3J3GszKPNiAQV8/sGKEdKxj7x8PflUxr/vdfkVz2WFtD4ZLKX3k4SwZU5Q+Tga6ab8D7TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389411; c=relaxed/simple;
	bh=VYDzGKwipgSEE4QOHh0LDF2LId5pjeSn9jG3yWiXt+c=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=TXFVZxEPWMjrfN3mL53PMTM3ibdqrCKeVlyFS0nsqwaqE3p8DQtKVhcgDEIWGAI001W/MyvfC+UnHLIWmMI0/RKRw/mKHKYzTQKAPjsOREo0nmTqestIWWgOI+u3dCLd8HpIvBUjVV39ua8/neZ5yKA5KhwUuBm/e2sI3OeLrxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LpR6tdxY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=egjHM+K+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5HEW6N030096;
	Thu, 6 Nov 2025 00:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=LuhW6rBorFnKbFJAfs
	g3CZ0lAoVZRrwWozSST++bSJ0=; b=LpR6tdxYpJl3NxDeT/GRYzK6oFYv7stHxl
	4k/g6lB2Tu+hYbWVgiIiGqrBgKmZZ5dJOE8KKZNmOydXFgb8csbGQfJKyUWCeZEk
	1yLnpNMyy8inLHI6k6wKIhUoWK9baPWfuyRgLWlFTc5CiRBRpz4phiazNNWsxpZC
	xV7YK9sInVvJFgwduHibW00xT1+JdQ03r4hqLbs8Py7WcaPxgF9ce6YC2RU13Xft
	07cLJlnK4U863tgxU7Bo1eeP+kiRVxK0K4JxF7oG0XOJCcEc9DCJJpmo1vVqhEFW
	EIFHv52wAe/koswzt68N/OC7+pecKNVTyr/kop/aGX2iaKNpqriQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8at90v2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 00:36:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5MHsEA010914;
	Thu, 6 Nov 2025 00:36:14 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nbr416-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 00:36:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xT8OAyhGrVvbMUIkthQKhmJwe3vRcCvRLK4V9ukQ3h0rVXbRkAId1FF41XIWDCCqBqSs4XAPPvGu/7RcW9BAIN5hp+ea5PiIGQIXxGRcn/wgolPhlPdsVNx6HW/NL4hfIZB46IR65mOIb2KHdjbiHEfzP5BIU53Np+NzWkJD7Iq/tPy9Cq4wTDMz6DZWWiUt4N7X4Bedt4WFq+k6+8Hy3HLsVYj0xteBXm7VxRuuCdtldZQ/QngoEU2VLDKFPjdbvS2+kJl42QKpJ6TFy/+yaifbdWboHZboPLGzLyr8f9/64p5i4e4Ov94YOtHR+v/b3+TyjbmMw/JIQurGCLxCBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuhW6rBorFnKbFJAfsg3CZ0lAoVZRrwWozSST++bSJ0=;
 b=XAY7TWh5X7A/6jL7deQPZ4L5tmo6px+JWVfFyr9mu2BpsVAQZV+HNfcvoyoU37VKbXP3QhVAtx8wXN2yyDyZ8/kbxvxcumHA0DIV/RCKXzd7dAo3ykpwWV4OggdByEmVl6mQWm0Rz0htMLtjKqosaPZ8Q58eqPiJzUdO+eIaNFSNk5gqmiDA+jUeV94QRzVXD1pgKu17VlSj3b3Gf5CCpRnmtdIDyUd9JWkzlfn+HRlF0ePGrLtatCga7a5gLUD0L9WkdNWlF35N49wSe2ItxM8xqRV3tVWO6Dt1VuykbON18r24r+Jx3BMRtGUWG2HjNeAkwWLo2fF9EmegKITIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuhW6rBorFnKbFJAfsg3CZ0lAoVZRrwWozSST++bSJ0=;
 b=egjHM+K+n8oq0pcxo9meuhT8uFQpqyN8ru4i1asSBxOCncWSKCKgSuwOnmxY4XSk1fKY58Qgs1fFDvGkTYgPlh4cvbY8l+zKrwl2tQ+io3bHIrs6HQtdEBjYBlmhwBobmqmMowvcBunBlHxEm2NIpbHNzJeSEzw67VkraSdaffE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB7361.namprd10.prod.outlook.com (2603:10b6:8:f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 00:36:08 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 00:36:08 +0000
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
 <20251028053136.692462-3-ankur.a.arora@oracle.com>
 <3642cfd1-7da6-4a75-80b7-00c21ab6955f@app.fastmail.com>
 <87qzumq51p.fsf@oracle.com> <aQEy6ObvE0s2Gfbg@arm.com>
 <746c2de4-7613-4f13-911c-c2c4e071ed73@app.fastmail.com>
 <87ikfqesr2.fsf@oracle.com> <aQoF1-uKTgJo89W8@arm.com>
 <87jz04anq1.fsf@oracle.com>
 <d087f250-daf1-429f-8ce0-c4f4332d0469@app.fastmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
        Catalin Marinas
 <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Linux-Arch
 <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org, Will Deacon
 <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Haris
 Okanovic <harisokn@amazon.com>,
        "Christoph Lameter (Ampere)"
 <cl@gentwo.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, Joao Martins <joao.m.martins@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>
Subject: Re: [RESEND PATCH v7 2/7] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
In-reply-to: <d087f250-daf1-429f-8ce0-c4f4332d0469@app.fastmail.com>
Date: Wed, 05 Nov 2025 16:36:06 -0800
Message-ID: <871pmc80ax.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef10578-c543-4b63-e2bf-08de1ccc79cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bBZn0jrCfGyxvRpaXDGEFbqS2oGmSsT8H5jKkIZc5ZvgQx8YLdrv2OnL7zD6?=
 =?us-ascii?Q?4ikz11fnifwTpFir3Qj3pi/PHhiKyFNeUJb7h4HbkPGAnk1xnw2VTSrtY1gO?=
 =?us-ascii?Q?8ayLTqW/i3u5I0NAq2B/BTSwG3B0lxKnZGRYZxmz7qjPUdR25SE81LRhOZmb?=
 =?us-ascii?Q?21gzgCK1OrDVT9BBjNzkFwntO7CjHlbvsxCumkS+N/x7lSWb+XWT0WKGhduT?=
 =?us-ascii?Q?HgOqqSoElnbvnD2AwlOP9IBv+73OFU5S7Y272ViabPfcigfuxN67YsdxpH3M?=
 =?us-ascii?Q?jpp7P4VYwWJ8EaSkh9QqwpARZ3CWx7HDmbljFH7IFpwlHfVUHSw5WlPyFuQy?=
 =?us-ascii?Q?5fk/RvmjciV09iMpEHr2Zs/Gbpd/i64FQkY84n33wO40fu51JhiwDkVMGULc?=
 =?us-ascii?Q?EsbdxJTMs8aYVLW+69Rb29Q7SOz9O9AJf5CztGvnTGxMD3B17nCNVWAn3OyY?=
 =?us-ascii?Q?DkxwQ+muA+G7iJZnL+5n3c475pzWROuMP7+IZQveK4lbc2D0B4s9cGpR11Xc?=
 =?us-ascii?Q?VMvGMdc6StC/TIuD123dltrZp84zha3qVAJnu98+X+INYC529kXkUF3LW2qI?=
 =?us-ascii?Q?tWpA0rexZTfrwxGYq/s/si/hQYmex4q3r342PY9tdrLdO9vKsNq2LyTM4oHh?=
 =?us-ascii?Q?fdQGej5vQG0c0yNsUndEaZ0teZx432Lwz4LaXl/LA/k5NBelde8eJptRcWY1?=
 =?us-ascii?Q?BGaAxD3IeKmK+fncZgoWsscZc5HgFYUIVPGG4h7AgcMeFQhFp4o8/6V0Pv0Q?=
 =?us-ascii?Q?WhgiygI8R5Dl6q6delbeufuQ/mCrxmE+RVzvPO4bdcwRnfc1hisE1jCCMq1N?=
 =?us-ascii?Q?ABdv5m9Qw7/ZjDS+YOwKTHfR7z/7PznOk49Dq1z5QkDpXVHSQOQ/kj3MpHeN?=
 =?us-ascii?Q?jWuZZn87GOQ5Kc/6aNCxAWDQ8BO1f9dsMb4OCnzdApUKYf7m4v9hc3PIgrOE?=
 =?us-ascii?Q?Tk9OhXxp0O5+F5h5Wg6C12Ml4tq0f58GaCBktPfCCsw0EdUBf93ezzs7TYXP?=
 =?us-ascii?Q?mjK62caagQ2fI/hwcV8TcX2ISBXMNk1pSrzPqb6QYm+dYsjw+LyeWxFH3cTs?=
 =?us-ascii?Q?8EurrQ3KjGd1UdlTcOMr1RXsUJwZwRHxkxptyLyY4qmqdzS7ak8zpjUTWC4c?=
 =?us-ascii?Q?dne+hva0gyegQUJUeqLGPJifRWRDDtGeg6uPAdKZ4+w9xZGhrpkLBNeJjBJ6?=
 =?us-ascii?Q?CRyhfQe1unEgpXUXuReMqV/oeYYVwL8K9gEK2HJRYwaf3qRmGerJ+Awj0a+Y?=
 =?us-ascii?Q?U1+a/9j6lj6kfbJtGccKJi2vhOrkdZoqGdswafLz2Gv0gJxvbNbFBIu5Nc9S?=
 =?us-ascii?Q?BF/qX580IstLeBIj2zpqMpyOZjonOYgU7gTdaIBGs6fJ7puyBno+A5+gPAF1?=
 =?us-ascii?Q?iWfP9SwANno0suvOXsYsOm23bjzvKpqEn4QQSOrgsTEdUGPhGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hBcUjwgz1zlIlAoD331TZDMMOJRx9gjQCmhv3xD+OO/V/tcN+i0e8n0K/k+3?=
 =?us-ascii?Q?cNZcW5zeXd7WhaXqsRu3n/eLDdBJ/W5WXMfOGefTM6Hp2CVPD0a3mbxxvk0a?=
 =?us-ascii?Q?8gDvO8I5r0MvqX+YCsVPfHayRrbTQqaCJrPl+x6IS4p6zFlvkWljL4ut0+G4?=
 =?us-ascii?Q?QB1zEt4gRfO0u2SQgrEuEPkWskGIhegpO/LyOdGmusMT5J0rH79YyOHd70fy?=
 =?us-ascii?Q?QI6HXQm6+YtydYRRdkjUrKl2Ui/MMMgBsrTmYxnW+6/ps5pAg4WT/wVaPh2w?=
 =?us-ascii?Q?9xk8CFfHcsAXHZ8/PoozhrOhzN4SRO0x7MxYbPGjoC1NE0gn83y2jIv/N5Qm?=
 =?us-ascii?Q?UwvdEVB4Sk5GAoZvbXJ/yOmgK+9CCu5k+sRHpVZ+sqvcpDJSmdFeNAObL68n?=
 =?us-ascii?Q?y/uw81alUVzSQMyW5C0dIK25wAe4fSr59lsAu1P6OwWjp7nr+rdwfvqZLc/S?=
 =?us-ascii?Q?EgANN/BeM48bEb3/oMEeV0u4iChrNDZ2DgWeKE2w7GdZyqJ3cU4kqqfndlgC?=
 =?us-ascii?Q?pX6qLmRsDKXN0Usxp+aYfG++OXP0X5AASb2eJk2jqyDm7ULgtrPXloWuR6Uk?=
 =?us-ascii?Q?O5pRyOKzbOU/cV+GOE6slW7dphpq6ya0zVMFX0oO44xifFF0UkD8qNpcJK/P?=
 =?us-ascii?Q?Ym7OoPAK7fpbjDgiYiWud26uhNAeqgM4Yk7xpGiLklJtbfubOM1aKl01TOuN?=
 =?us-ascii?Q?J9mAu6pD/iGglDexLKFMA664Kl/Fv/dvrxgd23cO1lEfyhctDW/7AXfvyABQ?=
 =?us-ascii?Q?mkLoF1TIhmscBQmnSjjWlvpV9IxI3RrTK6cvD0kBVQd/JUKu8JFEsib51Wmt?=
 =?us-ascii?Q?MWj/CX4U30EDiFy2vbqs9murlc6mGVCcWW6tFW4u7oUClyM87FQiDXxQwsX3?=
 =?us-ascii?Q?JIHB/nO11EeFZ+wPxcvH7ctXj1K/gEvmdGQtLmr2xP5MQrJjfLZ1syz9t8/m?=
 =?us-ascii?Q?o8qUplQ8BGg7drJ5e0xiuYukylc42znN9+lNp7anvWPvHOWWckhR40k3OW4I?=
 =?us-ascii?Q?azjUbvUkc8sg/WQkEOuJoc8QLsLyL+vIxCBIckSLMeDRSHCQ4zf6olbXO9cU?=
 =?us-ascii?Q?0TYusfQU4OSG2DZckNV0SZOEhyCesMFJ7JG+Oe8SIUTSfwI/Zf3R//gwLd6V?=
 =?us-ascii?Q?ojqBrq4Smc8ZvVdiSdzwDWW6ISiILIdAPf9AXYJdn6QM9LxLO8AoZMTJ5E2j?=
 =?us-ascii?Q?2jmYHO81nfy3PjpgY10ONDWGs4kElC9RxG8nwQl7oVVg2dn3wi5BYhzN5rT3?=
 =?us-ascii?Q?8w4FpSD8CHQoQ3IG3Z64WimjYAuCxS0Z3qYa+fUCSdZqRjuBEXP/GSwDG0kF?=
 =?us-ascii?Q?mxWf7TTcfIBQ/xJdPatpH5S6ODQC0mbvTqINXbBiuwW3h8OW++MC8HqT3DBC?=
 =?us-ascii?Q?+juEHtfHAVKjv/fa7luSJeLIe8S9OkAFpfhuU+4Ec0DyioVWXkgLDgyvvr96?=
 =?us-ascii?Q?E/m7U3y5ytOYOut/iLVdOEw5zw8T2MK46CwZFUktEcKFGsh1XM15vx0Dcrog?=
 =?us-ascii?Q?mQNE3ELCxQXB5v+7icRRP1YHjNGQBXbCcYbSRpgEfqVW8gWXDlKK6IE13Unl?=
 =?us-ascii?Q?KtmGJ7xTU0sA3ZLexwXm++AX9iWlM3x4yP9Z8tkv4qpNheGs6Utq2OgmGPdQ?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ouPjdKB3cAKAWJGun9fsOz9bSa5V7JYAniKyx2pRlm4coTv7fWA666pbuU0mkmUwVpBlriVdgGM2tD8SUPc0z99sdhj6wckUiARkxFNK7xgzxqZ16EbzjLu1I5WFYdxNo6Efb5ZAUBkg3OsXbZ61drkniidaWMcH3N3na2uPamrYOwJFs0+dYe4Tuwb86qrTKmgLbLAXkBEnXOGDCuyJ7zj+hpliYWIRR9yO/dcRClHDi6V1VBtkdZ/hgTqjMr3fbY7l/ThbInLAxMKmI1gxjmgU9Q4JUz5cmlUjfokm+PkaMHGqrSROKeo7QqNLUaipAoYRjtce0675gik/u2CToY8xTsC+1xcFBdfX57sOp7bz0lVdMwOiRVBMLCehB8K4X/GuqYlrJ0XbuCm6/UuGPrqTqCzalob9R8uDSMvCcWFkaPAxExXAEUd8jNYs1DKBlOA7QKekrxpy9h/szql1Z7C4iajZSsEyBcqYrVBBaC/TmMpgye1zUlHM76o+P7hS+jiiZ1xUDMu2a6QfC/vssgODNNv92f8eTeLyAgkREqlqo0ndML3vO3/OZ077EFS+w/9u3+E0f4R6dAjmNWBGK6fcXFxwmrrFvBHEIMyULnY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef10578-c543-4b63-e2bf-08de1ccc79cc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 00:36:08.0392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuN0UgHTDaMfE55r9Y97plLKSZk8ieDlVq1uY9b89LoOAGtxQQyaob4vNZI7v7TzFSUobA8YGTRbLyAxXMGnn0g/WZEKE2ls5KquuG4ae7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=969
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060003
X-Authority-Analysis: v=2.4 cv=HPPO14tv c=1 sm=1 tr=0 ts=690bed7f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=hFSk6rJo8mGD2msrryoA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 1HqfSpdhE3XAiggRiQZ_1PSKK7jV4fz5
X-Proofpoint-ORIG-GUID: 1HqfSpdhE3XAiggRiQZ_1PSKK7jV4fz5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzNCBTYWx0ZWRfX5DGy7myqF14t
 eyoVIUKKbf4qOtrOK9q2Edo1aeNLn04bjL9Abk3ZdQoKdjl+28bdAxBeo8luQXCJFOyWuKpmovH
 ujgqW1lCk3E151b15/VmEHF4588ruebZdF81Y7moHifYhztv6Xn2jnZwqp6128TYTHRnDvQPqbl
 VsdvZxy8a3Y9O8TuahYE0HUTTonZ69H0nJMYshhbCTgcpmJzv8eFU2m+vM8Vp7I7cjOcUAZq3UO
 j50dlvm4DNWjTdUpp/p+Fxt4mYAc57yJbA4jmY4dSAPSIhU+lb5RPAFx381rEP28PE1A81idqRk
 PUep/L3y+RW7dOt8dEDr5/q5z67rXLHTtz1B1oFUYgkKqzo2sYzelU8F+g/z1W+WaXzM7vhTyHa
 T4ri3YpyDmZJMQr4Ias9lMY/yA+fWg==


Arnd Bergmann <arnd@arndb.de> writes:

> On Wed, Nov 5, 2025, at 09:27, Ankur Arora wrote:
>> Catalin Marinas <catalin.marinas@arm.com> writes:
>>> On Mon, Nov 03, 2025 at 01:00:33PM -0800, Ankur Arora wrote:
>>> With time_end_ns being passed to cpu_poll_relax(), we assume that this
>>> is always the absolute time. Do we still need time_expr in this case?
>>> It works for WFET as long as we can map this time_end_ns onto the
>>> hardware CNTVCT.
>>>
>>> Alternatively, we could pass something like remaining_ns, though not
>>> sure how smp_cond_load_relaxed_timeout() can decide to spin before
>>> checking time_expr again (we probably went over this in the past two
>>> years ;)).
>>
>> I'm sure it is in there somewhere :).
>> This one?: https://lore.kernel.org/lkml/aJy414YufthzC1nv@arm.com/.
>> Though the whole wait_policy thing confused the issue somewhat there.
>>
>> Though that problem exists for both remaining_ns and for time_end_ns
>> with WFE. I think we are fine so long as SMP_TIMEOUT_POLL_COUNT is
>> defined to be 1.
>
> We need to be careful with the definition of the time_expr() if
> cpu_poll_relax requires the absolute time in CNTVCT domain.

True. The absolute time assumes that CPU time and CNTVCT domain
times are freely translatable, and won't drift.

> We're probably fine here, but it feels like a bit of a layering
> violation. I think passing relative time into it would be cleaner
> because it avoids the ambiguity it

I'll play around a little; see if we can pass the relative time and
yet not depend on the conjoined value of SMP_TIMEOUT_POLL_COUNT.

> but probably requires an extra
> access to the timer register that is hopefully fast on arm64.
>
> I'm ok with either way.

I'll keep the caller parameter to be remaining_ns. This way we
can internally switch over to relative/absolute time if needed.

>> For now, I think it makes sense to always pass the absolute deadline
>> even if the caller uses remaining_ns. So:
>>
>> #define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, remaining_ns)	\
>> ({									\
>> 	typeof(ptr) __PTR = (ptr);					\
>> 	__unqual_scalar_typeof(*ptr) VAL;				\
>> 	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
>> 	u64 __time_start_ns = (time_expr);				\
>> 	s64 __time_end_ns = __time_start_ns + (remaining_ns);		\
>> 									\
>> 	for (;;) {							\
>> 		VAL = READ_ONCE(*__PTR);				\
>> 		if (cond_expr)						\
>> 			break;						\
>> 		cpu_poll_relax(__PTR, VAL, __time_end_ns);		\
>
> This looks perfectly fine to me, thanks for the update!

Thanks for the review comments!

--
ankur

