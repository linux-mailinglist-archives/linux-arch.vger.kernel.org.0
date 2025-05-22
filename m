Return-Path: <linux-arch+bounces-12073-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E47AC0C8E
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 15:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB7C3B2B39
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 13:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5278266562;
	Thu, 22 May 2025 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bbdQYBHt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wAU6A9d9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C9228BAAD;
	Thu, 22 May 2025 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747920112; cv=fail; b=RziYeOwvV2kGfwFbUg+d3juO0PHsHTSEuBA9xo4uvkUbnyKuZiIJd9Adk9vrCBWQYEkjX7lrkniP2Tw1BjssWD6zP0bVI0eJX62dQTvi+SQ5/KEq2z6vjxsGSPp/QQbI7zhOHPO65wWS0pLdv+7jkCUYovsmaTSZQl/GjPi1xkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747920112; c=relaxed/simple;
	bh=OjGF4dRKLCs0Di0TCb4t44kLcIim4JePctWrOg2QvW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U3pWpMfhAIFv01mWH5GYNJrwuBd4MEo/LxeWQXKelZkXDbapNgweT0RQzMCGVT1iAEuynHzimEUzbGbD09t/IYFeETMDMT3qmXjUKSbVIC4rMQ7YZw6kGTpk0Ctq+K7I4LnIhphq6cU3c44Ll9e8sP1FMx9fzIecj2ihUHE3/Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bbdQYBHt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wAU6A9d9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MCSGZd015808;
	Thu, 22 May 2025 13:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=rF3P33JVxmKft205oe
	3/W0fVfPMxYLb8reF7gPMHyAs=; b=bbdQYBHteo7sxzFxKgcHRRxjVuDA3VCy7p
	odr+9jILPD7VhKqBmmn5azImW2uPIXndzDu9+T1We9offb5ireFDlnyutuxbukUP
	6jFIod68TubRi80CL2cRX7o0omzJYOCLQBx8rO7ccghU9KrBR8XImsP7USVWd33U
	D2mxhc0ChzEX84JCOIwPj1qa+6xrnOI9tUA5tq682R2I6URYRf4+5+7HlCyAlnqp
	YpMbqeePmBPh7ozhlS61DTkxsSe8EfUFPpUzAlnAigbnIkEwNtmTxwfjxqyBGc+J
	vB8xdaGuL1AUJHL7ELDTG93dSs6XEIOZnLBGT1DH3eNVMzmPns3Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46t3re04nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 13:21:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54MCsxUP032070;
	Thu, 22 May 2025 13:21:29 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwennj6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 13:21:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtOz3HV8zCiVTiHuNVnYbMuj+f1agRgwd0E8kb6bE8ETx6YlJ9t2vBYowbS+AGmmp6YxZNxz9RcW4uho7LyHWG/XnPtpbyvnTmDyLPS0ETqNBNEkmBlvSUjLTDGCIteIOTjlZg5N2hD+HATp9J95fOxEp+mKF3xZQsvBsYKJss48cGxpdYfoVE5S6FNucZVI/qp8UMDQOogLdxHtcpfetVazXVz6e9qmjbBO/Ay9PDxjqHtinM9yX4fAf9+FsMwCW7yBmlmEEPjIOT0L/vLnUv01T6CLtZdLWkDpGDDtekke3TvV1qAYxgZgxzfjmMEQ/1cpKhzHK2doaftVHBYEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rF3P33JVxmKft205oe3/W0fVfPMxYLb8reF7gPMHyAs=;
 b=qAStvf6hcUWVlukokYrLD1ZQA+UMI6bOu7kHn70Lkf81+GUlHDa01yM3ZqIJZ2I9GnsGRhn3OrPpkGCDD4y+Z/U/b3yLlAX/lZNM0XyddYIBlFULRsuETYZ5JkQUVbKmZUJj4l+jsDQ8vuCSPdsOIoyEg411YOaJhZoxiPPTS/xga+LW6YGUCyBHvUBP/eBcEbfbCAWV7Mpacn8HFIFWgifZ+zBWPV91iecEvT5cDTrOUi4k9U5kf8eT+h48wgWv8q1T7Z55m/KkxZLD3lE0iO6Tjja11W8pY8ONzfz+STPAgvay3P6EAab9E9qkzUaTK9LsYFWUzUZ1M6OPyY4U+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rF3P33JVxmKft205oe3/W0fVfPMxYLb8reF7gPMHyAs=;
 b=wAU6A9d9acnFn1zA9yXwcTTETswywRk67Qp3rGCbnlio/fSZM1qwQ9whASJE6TcLE1bQf8Izgs9L/si4jd4FPjOfe1EXNPGms6jDeKnGXC0dsDKdFPBy9RPcEmky3RjikGHCfVtsAJDK8f8Kc7f22KrUDcyKSqNK/DVhy5iym/Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4638.namprd10.prod.outlook.com (2603:10b6:a03:2d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 13:21:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 13:21:26 +0000
Date: Thu, 22 May 2025 14:21:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>,
        Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <dde3a174-e8de-4804-ae5b-a358f0f492dc@lucifer.local>
References: <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
 <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
 <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
 <e8c459cb-c8b8-4c34-8f94-c8918bef582f@lucifer.local>
 <226owobtknee4iirb7sdm3hs26u4nvytdugxgxtz23kcrx6tzg@nryescaj266u>
 <7a214bee-d184-460f-88d6-2249b9d513ba@lucifer.local>
 <djdcvn3flljlbl7pwyurpdplqxikxy6j2obj6cwcjd4znr6hwj@w3lzlvdibi2i>
 <e4d9dd63-5000-4939-b09c-c322d41a9d70@lucifer.local>
 <x6uzxhwrgamet2ftqtgzxcg7osnw62rcv4eym52nr4l6awsqgt@qivrdfpguaop>
 <9433c2d6-200c-4320-80f3-840ca5e66f64@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9433c2d6-200c-4320-80f3-840ca5e66f64@redhat.com>
X-ClientProxiedBy: LO2P265CA0207.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::27) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4638:EE_
X-MS-Office365-Filtering-Correlation-Id: c34f9c4e-9a9f-4c65-8df9-08dd99338e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hGPACbVEWTYMV66okKwzvRCVcvILeAS7CxG1n00pvZn0K0zZyrMSwuILLd+P?=
 =?us-ascii?Q?bzPin5vWvET2vHwci1YoRQLIdjBL0J8NGtLKYLUX9UqDJ+9Oj7Qd9VVWWaAt?=
 =?us-ascii?Q?ayhJOu81tXynEAg+7oSx8e7D7NzD0WvAZ1y5zOJiJLBxmwkFAojO+XKF4Gu4?=
 =?us-ascii?Q?qZkTJqIDdVpai2xNJzHxVu57b/SNJlWEiZBahlLQCX5/lyenUpENwO1A9z/e?=
 =?us-ascii?Q?Pp7pt6a2qV0IMaMm8bzBexsPxO/gEvk18K/7MrX/8QCjj9HlHU9rZ6/pN1Ew?=
 =?us-ascii?Q?TLXr8e8ywonPZq1dABCVdoJof2cHe08bVkw3XrzQmPTm+jy/g5FTPvtG4Cq0?=
 =?us-ascii?Q?dqa0kopVMiKQXUU4JJea16XSPXy7vUSiioR2GEAicSMVwkmQ7Psk55v8d+j2?=
 =?us-ascii?Q?cDYHWmi68E46jMT4dzjo3XRGpMIFglv3+YACY8nlZ72XfU3VudquYl+VPpNp?=
 =?us-ascii?Q?oszyEVxIvQ00DIy7sY/0WjMCLYlkzdAILWqQiWus2gX/FRUmT1YyRioVf+Cu?=
 =?us-ascii?Q?H+qv0PlTIKsJs06ljW9mbhGrlfezmoWGmXNu68g+C+M/3fHNyzmuJzkGBbJP?=
 =?us-ascii?Q?cdLyp1aDd2MhunqkiwhGWkdKkGOpLEajTHl7VYhJhiQV/zTjqpumYElbKDsm?=
 =?us-ascii?Q?Z7Xg6PtN94YTHh2mU7DZLw3GzWU1SKQ1tDznIEWwoUiuWddbz7fBI4wLYvd0?=
 =?us-ascii?Q?aJ0dVxc8qPgtWfsk07JqB96pOfD1OUrF0BszdyEf85FRVO9Px7LVNf5kgb36?=
 =?us-ascii?Q?IKl3GyyTheQoER1M3ByRHOeW0xO0hVVT93qQ9kOeuh898eb7hMsZhGSMZkAd?=
 =?us-ascii?Q?Xx3pyz8P2Va1KCGGu8VWWCSRkJklWLpN+Dua68Dv1KCXry9FXgijlu/LdX5N?=
 =?us-ascii?Q?UR/e7lI+BBNmizfJAWlAwosnTBj4itmr0OT1mjZ7gl+xUqXXJwCwIla4hhXg?=
 =?us-ascii?Q?GcAJoRrrNbcmI1ZNK820ATUpBO2jP6Cf/paTIqkCZt8n7eNEX9Q1y569z+WL?=
 =?us-ascii?Q?mxCn+hfwahFSBuyydtNyiA8hwKL8O5CKUzc5nB42Bklncjt7g9JBaNpQ5iDr?=
 =?us-ascii?Q?PbTn6Juf+2crrGViq+8MVKINJo9+gr9AadT9InlnPG9tocp4UotQmurhlKFi?=
 =?us-ascii?Q?X96VGteNkTsyZnbxxtiMAzpqVVBrTzu2s6ncKA1b30iqkRxZDM5EfGrUxVSe?=
 =?us-ascii?Q?FnJC+80EQehUMZHApSXCD+iqGcq1cil1ml2IWXiFEuFQFlCHPsVummN9hhg2?=
 =?us-ascii?Q?5k3LDiCYJmAVUWhP15IrOJ8tYveZPz64LTpGVu396qjIBC4c5feTCmic265c?=
 =?us-ascii?Q?dSD/B5pYGueiy/97SktdmBzV9sSrd87uAPKEEbUFt9941gbX84Ms0NYLhFa1?=
 =?us-ascii?Q?vFb77WDeohkq80Hy7zbmgJVuEYCI9AjkoCAU6Ck9exSaRlXMkge7p0KpkzQE?=
 =?us-ascii?Q?LlbJeO+pCw8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qZpMGhhwUOG0d7wjAjrJycqNM8r+y/mu4fKs0bJO4mprFBPeqhwbd2OaCBFk?=
 =?us-ascii?Q?b3eQFnuHKcnN+fKeN/WuRRoZkP6Da8L+qc6SXqTn6sZ6Od7iK6K9SoU3uStK?=
 =?us-ascii?Q?9JDvMFnoHyKwu86R27lH27RTS6yHADeVL8owmFtejrWC5o4yLudFX5sxSH86?=
 =?us-ascii?Q?Qy+qh4QKQiEqWSPDWBD6oJqHPgT1J+41bse4SetCD27AzYnoSL8ihEPj1bFU?=
 =?us-ascii?Q?kYNATwQnbqiBS+9fekz6m9goXv5bBofaN5eX/zKJu5xyEAr1tC4n9kBTTL2n?=
 =?us-ascii?Q?kb8JkRrLzQN91t2qUuSS4lw/SPVKy+uc9fqmZCEZWXxI7GILbj19L6B3V3ie?=
 =?us-ascii?Q?LAM5XavMZVP/822qHmMqax2HZHtToq7CresdXJbJW0midbbdkzEeYVjp2J65?=
 =?us-ascii?Q?gtFW5/+3CWYf8Y19iV15/xjVL6bSL06uSGzWBhwTT+gCWhDPS0GvW64PgAnk?=
 =?us-ascii?Q?aXrTRKrYRGsUurAurKN2fCvZtb6JoG2PYdgxD+/+atA8YpHtgljnTzNmAL3t?=
 =?us-ascii?Q?/QuvuE6ZUQcJEi+rVhN+Swrbiwn0Pjlqh0MzYSc3eKE8aY/9Gj5qAz8X+4wN?=
 =?us-ascii?Q?NwZOY+pES6wAcZq8SLtOmQtRTmCMr37DpYScyHwGObTZLxR5XbpnJwhCQeBZ?=
 =?us-ascii?Q?0EbqwPkf1LlrpI59ybMaXjZXdyvAdICk3AiSBn/oGoMFqBQXhphVwO0BTzfT?=
 =?us-ascii?Q?Ccm4BBbsLNq17vFyxmGOW6B0Ufk/zNga7zkn70MIlI3WW55xDj6uVYKd+6gX?=
 =?us-ascii?Q?dc21LGbHMhfhP4fLfN5VlkxUhsjEFZvzro6GPHmZbwzSRAKKJECEgngJdIyv?=
 =?us-ascii?Q?9FjMVMzJrF76NF2LYbx/27ltGH/Iki+N5IB91ssbzx7kzxXPz1ZTNykwUXJ4?=
 =?us-ascii?Q?xpV/dl+rNdK2Xr7hNEkv7kVzrKbQzvG210hRosz25wb3t8Wy43zoRCaLCA+F?=
 =?us-ascii?Q?WSqXNpS2H49OryI3O4/ZdMOCNOZl+DZb3uvnWC5Jxf2rSnsvtR25mtFoQWab?=
 =?us-ascii?Q?PGyk9gU1S+aw1zT5UqirWMT5Y8pnk5Oe6o/fXAiqBGIoelvBr0IWJQPzv/HZ?=
 =?us-ascii?Q?Jk5SEymeoyJkARSffe3r4/x+IOJGvDNYkiTIFwOTcXCMqzzdxqYlUC2DJwjy?=
 =?us-ascii?Q?zHMLbIpH3IjJ+58vLU/g963NaPcb7PVdn9WhJ+QsTtCWPwg3jE0nYgjC5OsK?=
 =?us-ascii?Q?u2bH87LzUB2UxV5GjMDPa5oQyKKk2HVZUrTl2N52sWyawmc+QuzEukBj1HTZ?=
 =?us-ascii?Q?H7z0eepQorl6olw3VQ7WjDKq1c7LCjHGEkiZ+rqb9dSL+T/vN3jKaCm2/CyW?=
 =?us-ascii?Q?62A6Zo3qCZpWd6grHuQ5qiuSHFM8LoFXz7xrcaGpEKRcTwto7DDJYAn1UfpK?=
 =?us-ascii?Q?eYt2wP5M873Ho/PytYDY2F86lppkxGQOY/Lw1TMBYxnRZco7Gw+T9ro4hGWd?=
 =?us-ascii?Q?hKdE/0YU+hKZRhsHaqLDPSQ3xz5C9Ux4a5Wik5r4GWkO1H82jNzftNHzeKiJ?=
 =?us-ascii?Q?gmrTRHIQ651LLNVmh5WN/ETleFTS7LTkJm/q+UoNoxqplXKxZIB6qe5t6nZu?=
 =?us-ascii?Q?2mwDHx2o1SAoY90hER9QGvtleavFfF0ZS4b+N62BTt4t4qcfKPBPhfGIc7u2?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lLqpfQNMlJSsB50b1mYC2Tc2pkqiI+oK0Af2MeO7ltyViTZVW1rHzmagMUS/MHwY+JYbSYdjsUYoIsc11U1wJYSehbztVR0AHgGSW0GwZXPoHojw72g8tge57eOXoaFwc8W24TabezJLoAw+tUZalc1EN9jdR0mqU8muCF3/EIgFGphiUgQwHABiL13ONch0lN3FNEUOtWNOUFfPzp2rV1kx+P5VBEKYPBNCl3euSV+/K5CrbppbEG0Jusga5FstzwlCGUzbDqHdc7395bgc+v0EZdaXkgvfQTEnceNOM2KYNlTNzRUVjOja0ELF60IOZMUrZQaXASIgiNbheTUOrWscHvSO1kF4sGCyTyUTXwg4aF3Xe7pIHc0rC7NgtaKFfmjGuLxM8hWHf0lMnuZhwjlDSmLc4Ugg95ESiGSlRkkCSXoqiqZ9IOVLNAt18IgBSAgHLjMZ7zkxMZJYgmHc8ruRBz1TRL277qZApJHFXQGQX++Ezs4lDU6HdkEhsL92hW8HYmOjmdM20Jcp9ngU/mkyhSOiiRRyC/PacDcGC2U6ur+717ew6g+bCRp/k+Pypj43x1pB13058OxehSHhr+AphZ2kgnw+dlncnPTWcxE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34f9c4e-9a9f-4c65-8df9-08dd99338e3c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 13:21:26.6140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAP5KaDp4wNJQn6/To4Tb98AiOgrxcoJcX1dnIqh1mFp/L7KA1Wmgh4SAg9PuVlbqU5pyYejtFzKdDtIu4BWaJvhXXidv+XhfliEVx1W84M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4638
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505220135
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDEzNiBTYWx0ZWRfXzv1menY1wnk0 7S94uMWqSHi+7mVFqbW+EHimOW9oWSfHy6oeK3wsaolmh1tjXcKL0P8fFB+ntJpg/R2uCR1H/MK cVDfGsUYihS7gviUi/1MfkqzAh2CV63WnxgiqaNpkFglVgiO1XwG3OjxBwqHsK5pHMlSzMzUx7E
 wXgffrwr1qBcvdOzLDL+55aG8z1b3Fo/GD1dTi1TrSFRA+legz+bA1G5X/PPtfg8cPayMUQW6qB YdHYuzozP5sSXKJgvbmAtgP4aodnxUxpA0DuSrfcAFSmSrOXjAE/IEKj8RZ0ctd1NldOgnwblj2 iLx84af5Egkht7b425FfKzraEulm0YVzALMTb2GBJUiVM5ZO4ab4EqNUq45qkhllWOuTwscGYxG
 aKQfTuvL+dHqcibsWU8yJ13U7dS2OKsMJCpfbn3NUwX8XN4kPcZHi1Qs9Jp0on8HQRTfJsuk
X-Proofpoint-ORIG-GUID: c4ZewOjtZWTbBb2D8B4NrfVzVWtyjG6N
X-Proofpoint-GUID: c4ZewOjtZWTbBb2D8B4NrfVzVWtyjG6N
X-Authority-Analysis: v=2.4 cv=V6F90fni c=1 sm=1 tr=0 ts=682f24da cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=UOCrw4lwvUMf2fuHHG0A:9 a=CjuIK1q_8ugA:10

TL;DR - action item on below is I'll put together a proposed API (without
code) and cc people here when I've done so, so we can take a look at how
mctl() or mmadvise() or whatever we call it might look :)

On Thu, May 22, 2025 at 03:05:30PM +0200, David Hildenbrand wrote:
> On 21.05.25 19:39, Shakeel Butt wrote:
> > On Wed, May 21, 2025 at 05:49:15PM +0100, Lorenzo Stoakes wrote:
> > [...]
> > > >
> > > > Please let's first get consensus on this before starting the work.
> > >
> > > With respect Shakeel, I'll work on whatever I want, whenever I want.
> >
> > I fail to understand why you would respond like that.
>
> Relax guys ... :) Really nothing to be fighting about.

Agreed...!

>
> Lorenzo has a lot of energy to play with things, to see how it would look. I
> wish I would have that much energy, but I have no idea where it went ...
> (well, okay, I have a suspicion) :P

We have cats rather than kids which might explain a bit ;)

>
> At the same time, I hope (and assume :) ) that Lorenzo will get Usama
> involved in the development once we know what we want.
>
>
> To summarize my current view:
>
> 1) ebpf: most people are are not a fan of that, and I agree, at least
>    for this purpose. If we were talking about making better *placement*
>    decisions using epbf, it would be a different story.

Yeah, I think overall we have a situation that is _bad_ in terms of
interface. We need something more fine-grained, but it's chicken and egg, and
there are genuine needs users have _now_.

So the whole discussion is about this.

>
> 2) prctl(): the unloved child, and I can understand why. Maybe now is
>    the right time to stop adding new MM things that feel weird in there.
>    Maybe we should already have done that with the KSM toggle (guess who
>    was involved in that ;) ).

I won't belabour this point, at this point I might get a reputation as
prctl()'s biggest hater otherwise :P

But one thing I will say is - systemd makes these things permanent (hey
that KSM thing that breaks VMA merging is literally an option in systemd,
wasn't aware :)

>
> 3) process_madvise(): I think it's an interesting extension, but
>    probably we should just have something that applies to the whole
>    address space naturally. At least my take for now.

Yeah that's the point of view I've come to, I mean the point was to try to
make this more generic in a way that _also_ got us improved control over
madvise() - sort of win/win.

But the 'default the process' thing is, as Shakeel and Liam rightly say,
just really out of band or doesn't quite fit this interface.

I may still put forward a patch to add flags for e.g. not breaking on gaps
but as a separate thing I think, I still think that'd be valuable (but I'll
provide solid at least self tests to make the point).

>
> 4) new syscall: worth exploring how it would look. I'm especially
>    interested in flag options (e.g., SET_DEFAULT_EXEC) and how we could
>    make them only apply to selected controls.

Yeah, this is exactly what I want to play with.

>
>
> An API prototype of 4), not necessarily with the code yet, might be
> valuable.

ACK, though I really find it valuable to code things up because so often
you figure out what works by trying to make it work in practice.

This is how guard regions happened for instance, we had a ton of
conversation like this, loads of back and forth, nobody quite knew, then I
wrote some prototype code and it became apparent that this thing was
doable.

I never intend the RFC to be _the work_ rather it's a 'proof of concept'
for discussion.

However, as we're still fairly vague on the API bit, I think in this case
it'll be valuable to do exactly what you suggest and simply prototype an
API around this without code.

So I'll do that and come up with something as a separate mail, cc'ing
people here.

>
> In general, the "always/madvise/never" policies are really horrible. We
> should instead be prioritizing who gets THPs -- and only disable them for
> selected workloads.

I couldn't agree more.

>
> Because splitting THPs up because a process is not allowed to use them,
> thereby increasing memory fragmentation, is really absolutely suboptimal.

Yes, there's a disconnect here between - a global resource (-ish :P) - and
process requirements.

>
> But we don't have anything better right now.

I feel like all this turmoil brings us closer to longer term solutions, if
perhaps via pain-inspired development (a new programming philosophy I
intend to trademark ;)

>
> So I would hope that we can at least turn the "always/VM_HUGEPAGE" into a
> "prioritize for largest (m)THPs possible" in a distant future.

I suspect we might still require some legacy settings so people don't
panic. Aren't uAPIs fun?

>
> If only changing the semantics of VM_NOHUGEPAGE to mean "deprioritize for
> THPs" couldn't break userfaultfd ... :( But maybe that can be worked around
> in the future somehow (e.g., when we detect userfaultfd usage, not sure,
> ...).

I hate how uffd is implemented (I like the concept of what it provides
though!) on multiple levels. It's crept into so much and the idea it's
putting restrictions on core stuff is just horrid.

I do feel though we may want to introduce something new for this though, as
'never' or 'no' suddenly not being no but 'deprioritise' could be pretty
concerning for people.

But on the other hand, this is a resource for the kernel to determine how
to manage as it sees fit so, perhaps we shouldn't care...

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks!

