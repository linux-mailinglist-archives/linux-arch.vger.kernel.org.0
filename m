Return-Path: <linux-arch+bounces-8462-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F139AC948
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 13:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B9C1C20CCE
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 11:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FDB1A7270;
	Wed, 23 Oct 2024 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CNecTj67";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J1X5+2ex"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC9019ADAA;
	Wed, 23 Oct 2024 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683704; cv=fail; b=KiSj7pkvl/7MWTcvP9wId4vsCKPW4awZOlSB3djd166gb0YWc8N3X3qJuF3wOVh74SWDdAytJDo7gnrtvM4+AGblql+YbplnNkH4s7+6FQ6KH4mtGdDvdZXVeamscKLilR+8/DiV6wiQUpOm/v+aobp4WJySX4TwAJbqhYnJ174=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683704; c=relaxed/simple;
	bh=Bg5BDELLiAVyvvWp2ydiWXgkptvOrP2LJLHfQTj0vSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tJeo+FV5d6V/QEyKQ0+uAlfp61KIJUoflTk184i1G0hvalEI0rD1qYQLCxystssN1NVNc8sfuqQtUfL5R4v3398q0+Z0FGJZMUVLR/yXQQ/wcRJ340X+xHEH9B1/XBEJ9Z2vIUjeg6aFzNxUh2kmuCNzkxIh2HzSjl2jDCoXV8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CNecTj67; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J1X5+2ex; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBQjcE030913;
	Wed, 23 Oct 2024 11:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Bg5BDELLiAVyvvWp2y
	diWXgkptvOrP2LJLHfQTj0vSw=; b=CNecTj676vnwJXZvElgmyAqJS6LBPYGalQ
	S8p4Deyxb969tcau4q/85PZKz4tK9rrbhl5gFNA9Y5FA/FK7hR6AUWcOAYL2O4B8
	YqjhBU//fgS8EneSIZd1nOjTZ7p+aUsv8WWf55EfcuxnZE5TW/RRDZkAE0lmhiPR
	7/FuU1MlWG8xpFWcBOstpy3M5QkI4SgNJQGM+Jo4KKYjQziEECD/lyZ2jKf+jdKm
	PoF2lKrdBLoTWBosnmzYpEm2smsywk6RAIXzgubfEwqQARFmiAFCWHPJ8KLBUO32
	Z5reQeKTQYt01cMrtH2MkOcgpH37hnRkfFomnPtwg/8D7Gancg5A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55uyv9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 11:40:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NAJ5J8027343;
	Wed, 23 Oct 2024 11:40:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2pxr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 11:40:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1462GNFNcAbkadvji1PFHI+CU7uFxRFHykfLfk/P8++UL6Yu142jR40tAhxRepmhRVxlBYiMUEjiy8jAVkH0oc7VuX5XUx6wZCfKHkFEAaBxv5HGJB0E5iFBE/HDSRgIxGTMPbHkYd7bFAm+yijOLALzWdhrqOwzFH0SbZNzlrFYjtKEC5K85HGdWFVeA/FS6r22I7D3jp9jPSmLOr0jlx2Rlx+4ux9FOVI6nzC9OC2Z+ec69sXbX0VjYiKQCB3sN7U4WMeQtPd+OyLayHYmqW1l2t2VRVqY+W2u7nvdylzzY+qFQ5W22u/w4fDzK5hjusPKvYjUUTmvqWPkmkoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bg5BDELLiAVyvvWp2ydiWXgkptvOrP2LJLHfQTj0vSw=;
 b=qDT0mgdlPK8+AWykSPvnX3OtZzcUiZupDZUa8SFb2PNyJgp4Gi9/fA9ef+N8otOk3XLz96+kSMWW7dznCWBuuYEQ5fNMzWmMG/z/5pJNXXgXCLG4fjs/Fp1laXxuD6d3EFc0jy92S/9/e8zv27o7ErzQLy56lLAiSixTxoyY5R0rQ76Po2IK1sunkFu59rejxFUAryNcKIP993FvzA5ZGwcEJR1mAywvlxFb56HtxPrXlHjb0LbfkSfXCk7HGn4o0Up/kFRBGG9ED8qRU9uOzGb5vHXSqtE6sgyh4FhetxK/fv1YgVtSbsAXPNpWIN/Dj11Okst2lnySPjHxKDn1Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bg5BDELLiAVyvvWp2ydiWXgkptvOrP2LJLHfQTj0vSw=;
 b=J1X5+2ex07SwILS+Uzf3QHNfxmlHg6mix2HrT/KusrePOOU0xRoBfIHH/5ozj1aSXAdaEhXO4Pd1ETtNyJHO9FZGOT5uqhO3/HD9c99+zq3OtrcNgFUjlCFmlzaF02Xgo1q5ArQW1gKGKXFTX1OvoissZNsCh5etN9O/YZVxzXo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 11:40:42 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 11:40:42 +0000
Date: Wed, 23 Oct 2024 12:40:38 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Marco Elver <elver@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>, fw@deneb.enyo.de,
        James.Bottomley@hansenpartnership.com, Liam.Howlett@oracle.com,
        akpm@linux-foundation.org, arnd@arndb.de, brauner@kernel.org,
        chris@zankel.net, deller@gmx.de, hch@infradead.org,
        ink@jurassic.park.msu.ru, jannh@google.com, jcmvbkbc@gmail.com,
        jeffxu@chromium.org, jhubbard@nvidia.com, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, mattst88@gmail.com,
        muchun.song@linux.dev, paulmck@kernel.org,
        richard.henderson@linaro.org, shuah@kernel.org,
        sidhartha.kumar@oracle.com, surenb@google.com,
        tsbogend@alpha.franken.de, willy@infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 0/5] implement lightweight guard pages
Message-ID: <dd544ed4-aaa9-43c2-a1e9-d0ad9af1614f@lucifer.local>
References: <20241023062417.3862170-1-dvyukov@google.com>
 <8471d7b1-576b-41a6-91fb-1c9baae8c540@redhat.com>
 <5a3d3bc8-60db-46d0-b689-9aeabcdb8eab@lucifer.local>
 <CACT4Y+ZE9Zco7KaQoT50aooXCHxhz2N_psTAFtT+ZrH14Si7aw@mail.gmail.com>
 <b1df934e-7012-4523-a513-d3d1536b7f72@suse.cz>
 <f000d21f-dd04-462a-9d34-d0e7f0f7dc2e@redhat.com>
 <b5792b5f-298b-499f-abc2-db773ceeed36@lucifer.local>
 <1768ef5d-7289-4d2b-ae02-f5d2a20d5320@redhat.com>
 <CANpmjNM_q-+FH4S8UxRqnomfT7oneN5kcFf_Sxn6cStCCqoKeQ@mail.gmail.com>
 <2c674241-7e40-46a0-9506-85ef37e3578a@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c674241-7e40-46a0-9506-85ef37e3578a@redhat.com>
X-ClientProxiedBy: LO4P123CA0073.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 94270656-c4e8-4b5f-d0a6-08dcf3578613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rZMM43pCwxsgjJzEe9JEbucyy7nz3RYKIsHGP7STS18/Ysl/hLJvbfg/iF/p?=
 =?us-ascii?Q?c9Rahiw9jZa3D3rrDxs+U4tObqhT+HPfmSiSIMXL3sa+YawBVrDmwSfzaldC?=
 =?us-ascii?Q?eIc3XRGc63rNjgf5Av/OWMg3VUos80NWqXr4Up6IfErzF4Y8/id6np9fht9J?=
 =?us-ascii?Q?6VY/WhHmaWUkTMVeie+g9MWr1twaIunyUBGHH26Yc1E1kRHvWddQfL0jj57c?=
 =?us-ascii?Q?l0YVVRt8No+sMF0T6TQh9sVVF4MZFjsGhUpm06lWqK7pifVhzQoSAvLO7aPF?=
 =?us-ascii?Q?vLMKznDS6LGKZRy6/o1eBzzOWkiM9gPZ0Lei1CQnREEuVl0TnL7LCc2PR2TX?=
 =?us-ascii?Q?gs5ap1zJy25JfgTiHU2oSBOQxRxNPx8s8Cn3bcN6zt169iN1NdxOcm/Q8f+g?=
 =?us-ascii?Q?eRDxyi1qEgDEWsB+aq0Ke0TOvNTCH+fRv5n3p+mCTHvdIcTu8agHPS+F6sqz?=
 =?us-ascii?Q?atsJo707GTizbvN+54nAzQVsCkF4540VAI+5eKIzVSAefsK5yQYMY9flm/Ar?=
 =?us-ascii?Q?1fojMshFOwlp+wYGizTVNduYG7KTNLkhuqfInLcIaAVlBPbDZsmiIeuGm39P?=
 =?us-ascii?Q?HpH9+lRUa8LypCT7rmoTYLhf4tQthOgw51WONl3X6+alyLVExJLGo0yJ7v0c?=
 =?us-ascii?Q?B7zCFYiQVCRVeFwJ9PNH/Bv9eo+GoHhg/AsspALG28hMRBWVX1+0DcMJ1RaG?=
 =?us-ascii?Q?ozr9iUl7oCMPvzTm2fBDC8JCqrcZlMXBTm2ER7WCK2Iu7fyd0WFLvVMwukJZ?=
 =?us-ascii?Q?xeKh43XQJNRxgf4yxZh2AGyagNc7s/sDdDm/Zp1z2Yk2nF9Czg9TXUkxOq9D?=
 =?us-ascii?Q?HuT9VdfaNFQLpPssDLcYR6XOYuxAtTJxFGBA/ckppImbMFVAzicyKPKmzQSU?=
 =?us-ascii?Q?bOuQAtzGc5TubOvK3ZyMak221P2SsujqD4H8Fl1xHlD7DEGdpkCbHNVhlewB?=
 =?us-ascii?Q?ggygJIYjqaUCmvRtjgQpwSLCJ0P5qhKMFAP5QmwPUvJtFAg72AkLHsKksvps?=
 =?us-ascii?Q?rkhNu6O0zGcOinB7G9VuRGPBb1OmY+MmwVJkH/kZ+pZoAI4UCGahCKbS0NoQ?=
 =?us-ascii?Q?d9tKGJN6x86VvVQXIHsGCWzXh5aJCCZQHauxNIW49e3MrjJT2JJ1ZTvle2+T?=
 =?us-ascii?Q?BndpobugCu/wqyKD08UkdlAVjnTpeFEIHQLi69k6Fd8YUpcoy9IqYTAQXZO3?=
 =?us-ascii?Q?+wU+blH9LGumCvfkMOzNHwndOcC938lMkJB5x8meYmhikj8vdrwjlv2mME17?=
 =?us-ascii?Q?KFf7qkvcJPDdftwSwqaC6gwnIXcfyqPWMRM7Hpj+ha3IPLs+F/DM9cqMLPaU?=
 =?us-ascii?Q?z5A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GvYOfJh6yS+OPPEZ5U4UP0W3dRTT6k7ElWuHdaYs3RxkbuQ+5S1IOH16LY5K?=
 =?us-ascii?Q?OyvAbIArSQHkIWYGCmpLKBqPlG0iOtOFwJ+ekJ2OrCzHiztmwrtySLSF9pQP?=
 =?us-ascii?Q?bi01HVx1b6+tKi2dr4j9ioKL8fIO0jaR1nAvsYiEuNNRp306BxY0WnAOgnoo?=
 =?us-ascii?Q?Sh3CUmC/uqIiEfkEvb/XB9AnE630N9Ks9vGAZbLWMpdwZ3eGaK3r6dPoH+T1?=
 =?us-ascii?Q?XEcaO2cRmKy1ZqL8hdqUawK+cJTUTQpBwQoBYYlgvfCB91VnbTWYBDAc3pfM?=
 =?us-ascii?Q?e5MkikQox4lJbAnRfU4Cu0UiaTNad4jPSuW4h+qR7/lQvrCuR9wJsW3ArAM1?=
 =?us-ascii?Q?DkMdBb0Z3Dj/yfusMtV+Z7FurhP872MC7vg4HrkZlqHo5iPaL/W70uHrnzd3?=
 =?us-ascii?Q?UoRhhWDv84hRzAFfkBwG8wiXDjZZWsS6CU8ihfl8mgiwpLEb+r5+QEaBF4XH?=
 =?us-ascii?Q?+D+wQYmWkg/j/RuVn1cwk0RruOLKaoUd2pwITy1Npy+z//MmtG9EQCqOLQ71?=
 =?us-ascii?Q?JxqlKd2VAKQVUUn9qki5vXBsWvgEm7UlXndi0MXL6OTsEaVmcscrx9pCUCwb?=
 =?us-ascii?Q?Z+FJOs4GSaEs57zjkhw3tOyOHSkQZRZ7uymKCDatt10bBzMYkYnH7uA/Fiiw?=
 =?us-ascii?Q?oyjFAcXKFfhMLgs0pfzIN2/GnGuUl1G1aVA06NSOfU7wiIH3bJ17wrrE1zrD?=
 =?us-ascii?Q?VX5+uI5kq/m1TCUe3Cdb4INMBVEElTCns9UCSWMcr2yxmxisaVVxfCimsmvW?=
 =?us-ascii?Q?8Cf30qhjyMWOldLbyS4v1dv251NTkSLaCOA+mO0Z0Gl5yiQRvxtW2+wo5Q2k?=
 =?us-ascii?Q?40yh2JeaUobKfXPY3h66NLIbzu574ddzr6TXmik/AouMRgGcrWZfwGkuHob5?=
 =?us-ascii?Q?Q17Iep3LnOdOKGy0IS7jy4CS3zCD7mAbq2Vk946EuFyyQftBsT0wTMGEhCuZ?=
 =?us-ascii?Q?NhX+mLKCl6c2e54qmbMHYjUdV1eZJdRQrJfR+28DS8ewkBSaCcPCzVjEzbgZ?=
 =?us-ascii?Q?LwaWNgc7G5seiJ/CLrpFV9DpqZ/TlbaLLYMBxt/4jnhZjQeXYz3gHb3FeG7w?=
 =?us-ascii?Q?WUbWM7/AMX++GI3cw/Rm3AVmiRG9N3TYdEb7nXWAqqKjwT9b1FBlns64zzo2?=
 =?us-ascii?Q?andUr4KGehfGSrFxKAvCzhWFJ9DOh5h8+rP6jI5eBMxzRRyl9KB51bnYlWE6?=
 =?us-ascii?Q?UdhkTDC9ZF8CRoO/s3kobe2J6jry1Pkf8ZsMvmzqv8eUQwVjgTgdXLwhI9Ui?=
 =?us-ascii?Q?Tj/GEO8TU0t8ReBnOtQOrCVb6j5eP5HtUwFNWQE4bZlSyoxqra81PGQNAH9q?=
 =?us-ascii?Q?RjHnA1VKzZT+l4BqLyeVv/M6f2TfgDKkb5Wd2BXOGiSshRhLxFswbYY5wzvG?=
 =?us-ascii?Q?59DCnIhKlY1P6vPcva2g7/koDwYFkuWxYlWZbp63AWgQzvO8xqlEVHINqMXx?=
 =?us-ascii?Q?UzMrr3RAOHLsIbdt95UzSu5HSWyJ3jq+Kbs5A/h3IeJlqTf/NZX8BAU503Ng?=
 =?us-ascii?Q?kG9W1N1qs7JAZe/tjm1PmafCKAxrKFdocj3wsdlveQOo0VqVD+u5xFZwTYN4?=
 =?us-ascii?Q?johiqV9VND6iuC1SPZ4pDfpBRhN2x9t5d00AOgGdYqQaPGoXzP5/YHxkrr7b?=
 =?us-ascii?Q?hpezVmZLKn96KKQyivx2tBhfMPc3VscL142Ig1MfotbrpFfzct63IEFQt4p1?=
 =?us-ascii?Q?VP1fOg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oVBXuT6D01DDM3fzjuDfusSr6hjmxm+F+UNDsw//ucHanpwctPZ8vWxOvxCYMaWPmHzRWZfHhH8/3+JGfcYj2Yw1ceVHAif1OChpVree+8TY+rbcMh1qp9+zRn6Wn8W0SCLvpLZXwrKokYq+RlWEHM+LL7HpX3IysyrWUGrkpNXVk5gQZCEeOpgqaaBqn7K2o0qU6I9HCCYYoqvoiKiYfhSypLqj173+8L1fpes9ADx8pUbSu1F0vGo3rA4eRNge5j9+SBPUXGdlfNd/Fy8wtgoYd2APoyrFAGzFDnOGuXsy2s/+uo01fjb7zMXgMbFi6jW3AoqSFdmHNTXcsWMyOxbFTlRDSZua0eeXWrSP+m88lU9wYX54HEpkv6XiQInjEvV0MGUoN1xFcb+wXczKepvSGPnYJAJusLXlOv5bVLb5itFtfL48QprOAsFAMoEq/Y0h60Bu8p8GfeK27HMumOtkfcnh3ZPOX7a1UhglkV92EcFy6fLPXu1hcooax06e545cU0vm1fTud6n8Byri6B5B1FxlKq5V/ysMLPYEWR9N4TrdlfkifVUvm1kuYradoa6qjpbV5rtYASbBUrFeozKhzUhWsDLRNhSAWyleAZI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94270656-c4e8-4b5f-d0a6-08dcf3578613
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 11:40:41.9476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoVyf7MTWNagDbBMIlUI8EsXBVyh2hIyWgLIsCdQGNMxmEyUmQsn7nCkwkmfTKRV4lewdmYxV9BGOJzxFBXH+T/7tnXZ6xz4DXyoMm/lr3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_09,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=734 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230068
X-Proofpoint-GUID: H6dGC_sI1GudsmTv-erpvY4a3hYY46ag
X-Proofpoint-ORIG-GUID: H6dGC_sI1GudsmTv-erpvY4a3hYY46ag

On Wed, Oct 23, 2024 at 01:36:10PM +0200, David Hildenbrand wrote:
> On 23.10.24 13:31, Marco Elver wrote:
> > On Wed, 23 Oct 2024 at 11:29, David Hildenbrand <david@redhat.com> wrote:
> > >
> > > On 23.10.24 11:18, Lorenzo Stoakes wrote:
> > > > On Wed, Oct 23, 2024 at 11:13:47AM +0200, David Hildenbrand wrote:
> > > > > On 23.10.24 11:06, Vlastimil Babka wrote:
> > > > > > On 10/23/24 10:56, Dmitry Vyukov wrote:
> > > > > > > >
> > > > > > > > Overall while I sympathise with this, it feels dangerous and a pretty major
> > > > > > > > change, because there'll be something somewhere that will break because it
> > > > > > > > expects faults to be swallowed that we no longer do swallow.
> > > > > > > >
> > > > > > > > So I'd say it'd be something we should defer, but of course it's a highly
> > > > > > > > user-facing change so how easy that would be I don't know.
> > > > > > > >
> > > > > > > > But I definitely don't think a 'introduce the ability to do cheap PROT_NONE
> > > > > > > > guards' series is the place to also fundmentally change how user access
> > > > > > > > page faults are handled within the kernel :)
> > > > > > >
> > > > > > > Will delivering signals on kernel access be a backwards compatible
> > > > > > > change? Or will we need a different API? MADV_GUARD_POISON_KERNEL?
> > > > > > > It's just somewhat painful to detect/update all userspace if we add
> > > > > > > this feature in future. Can we say signal delivery on kernel accesses
> > > > > > > is unspecified?
> > > > > >
> > > > > > Would adding signal delivery to guard PTEs only help enough the ASAN etc
> > > > > > usecase? Wouldn't it be instead possible to add some prctl to opt-in the
> > > > > > whole ASANized process to deliver all existing segfaults as signals instead
> > > > > > of -EFAULT ?
> > > > >
> > > > > Not sure if it is an "instead", you might have to deliver the signal in
> > > > > addition to letting the syscall fail (not that I would be an expert on
> > > > > signal delivery :D ).
> > > > >
> > > > > prctl sounds better, or some way to configure the behavior on VMA ranges;
> > > > > otherwise we would need yet another marker, which is not the end of the
> > > > > world but would make it slightly more confusing.
> > > > >
> > > >
> > > > Yeah prctl() sounds sensible, and since we are explicitly adding a marker
> > > > for guard pages here we can do this as a follow up too without breaking any
> > > > userland expectations, i.e. 'new feature to make guard pages signal' is not
> > > > going to contradict the default behaviour.
> > > >
> > > > So all makes sense to me, but I do think best as a follow up! :)
> > >
> > > Yeah, fully agreed. And my gut feeling is that it might not be that easy
> > > ... :)
> > >
> > > In the end, what we want is *some* notification that a guard PTE was
> > > accessed. Likely the notification must not necessarily completely
> > > synchronous (although it would be ideal) and it must not be a signal.
> > >
> > > Maybe having a different way to obtain that information from user space
> > > would work.
> >
> > For bug detection tools (like GWP-ASan [1]) it's essential to have
> > useful stack traces. As such, having this signal be synchronous would
> > be more useful. I don't see how one could get a useful stack trace (or
> > other information like what's stashed away in ucontext like CPU
> > registers) if this were asynchronous.
>
> Yes, I know. But it would be better than not getting *any* notification
> except of some syscalls simply failing with -EFAULT, and not having an idea
> which address was even accessed.
>
> Maybe the signal injection is easier than I think, but I somehow doubt it
> ...

Yeah I'm afraid I don't think this series is a place where I can
fundamentally change how something so sensitive works in the kernel.

It's espeically super sensitive because this is a uAPI change and a wrong
decision here could result in guard pages being broken out the gate and I
really don't want to risk that.

>
> --
> Cheers,
>
> David / dhildenb
>

