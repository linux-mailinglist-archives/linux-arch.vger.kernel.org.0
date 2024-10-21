Return-Path: <linux-arch+bounces-8395-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F30D9A9143
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 22:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01514281AB6
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 20:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339D61FCC7F;
	Mon, 21 Oct 2024 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XIR8A0+T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y0fwFrUm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757151494DB;
	Mon, 21 Oct 2024 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542695; cv=fail; b=SdjI6za/osLHY4qf7A7Hv19elh36z3yUHNoPJVpLQPraS+UimUPZeNPVXJzlT9L1q6VxiF6fUm3cULiSSsnlet194N9DNB1+W0VjZwSHY04EP92/Cj4sBbxVEV0uEySssmEOBbG8zo+/W1W2l5eVnHlROxOgSbt1OYGo4AhLAtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542695; c=relaxed/simple;
	bh=GwN6Qk1xc2Z8+jfFvTHIwmCOt5b7+AFvrH1HKg1RctA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dH7sZm3Lq90c1EMFUrO36cUO+9DBRvUqJyBEWqxbg8/jEN38PF0Rm5poKPmuataR1BKG0gnpgOxW7zAE7bKbmCWZN0rxcaReHtJBrpPAASgMOqRccCApdweBiNHVnVncXWeqcGORxqRndKGHLT5rsnv6FnP8jUam2KdXbP8HTpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XIR8A0+T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y0fwFrUm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LKBgrG023399;
	Mon, 21 Oct 2024 20:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=cLiM/WEPt1Iivz8csB
	G2vArirZi39e06Mzwqd95+edk=; b=XIR8A0+Tr2cZzX0NlWTxXUpZpX1aMoGilt
	bIi924iWlNXC1cxIx/ibTXfsfgN29gocGZrfJGSPBHwhWMJZn6rMRV56yPg4XsXD
	d+rnNTwzJpaVFFMYasCT0BhVMcUmw3MYst+HM8/ElVuBPoNrI3HKZStgjoLwmLqt
	UO5tuRhothyoBMTu3YBHd8FM+JrrZ8UtdLAWClknrGPwpv4zZZQRtGw5EnPF+3lg
	Etld9QruFzgW1pJjFVYapy2x/ouOVH5P2L3NEWdb8U5GjRnwlSHa/Su4zH1Fc3Tz
	01Ff2lTXgOvk3aHieKDhsorSuPQJ+uDTfubDapEB7PPJdXpZE+Ow==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55ec2c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 20:30:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LJVMJq012005;
	Mon, 21 Oct 2024 20:30:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c376kpgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 20:30:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruy0wMXJzcL0XODsEqNnkuqg18Y1JDrf2BitgA3RS44F2/Rs2e1+0UAVyOGT680tzIPjNI7SS7hzUD2Lqw45gRzb69mlkICxnVE1z+z/lPITCSlUC4IQXbQ/SNqjZToSg0UFSCV7C1E9gwBDk+ibaw76IafWn8a7K076iZpl6kNhDWV0Rn4ZSjn0tpfqY/nJVl7eR5hts9cSDTL5CcNjB0hWZaQJviTa4LlTPMUofeyB6qBV1er9gxQg/DWyma61gD79o65iiiAqHEENehSdUoc52+o5nNL3P9O4zQ313D9LK/lUH6RSJDG4NAWzRi14qImCg5dwwfWyLWRYGZPOHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLiM/WEPt1Iivz8csBG2vArirZi39e06Mzwqd95+edk=;
 b=TGNfV5Zdx0kup9F4kuIA33n3r7ghvRkjKWT+SBCLLv7PNRXHQQR+tT5Q8dLvTHrUklWw4hanfQo07FhNVF3nxw6oBEXuVMnJxzXyGg47PoDfASUXzvFDOfuWlajrygZ0Wl3Q+JoSCG7tEsnSONgjpof3yOVKKSLjV6igVxC/FkvRi/j6WysoVOZy9sNVs7PqohRMdpv12pt0Y+XpSfEEHMQtBbVKVQ67Q5IkNxr9IVK4G44cIXJivrVCYjp7plqdLFzdjtbwciubfO8dsv9zkgQFOIfTou49Rf7OuAy/jlP/baH4upyiVlv0TlkaHJfFthh7Mf+Z1PnchWPdskRNVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLiM/WEPt1Iivz8csBG2vArirZi39e06Mzwqd95+edk=;
 b=y0fwFrUmDJLB4OvULhCzYuXYTBjyeDz0jfUa4SrqbRDuk5bReEEhr2uZ7ed9Zw3AUUX35QaFP4SkHKjgQ7lMqnIqBMFp5NxwSjAshVogh71j2l+tpzbjgR1atLeepTC40y5mnFRgx+ubra6dutxJWpV6cAydaqEkZdnkgqmjAcY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM4PR10MB5918.namprd10.prod.outlook.com (2603:10b6:8:ab::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Mon, 21 Oct 2024 20:30:49 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 20:30:49 +0000
Date: Mon, 21 Oct 2024 21:30:47 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 3/5] mm: madvise: implement lightweight guard page
 mechanism
Message-ID: <9dbf378f-5f5c-429c-bdb1-813ef3091881@lucifer.local>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
 <c37ada68-5bf5-4ca5-9de8-c0838160c443@suse.cz>
 <6c282299-506f-45c9-9ddc-9ef4de582394@redhat.com>
 <fedd19ce-ea15-4ded-a1b5-ff050de15bba@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fedd19ce-ea15-4ded-a1b5-ff050de15bba@suse.cz>
X-ClientProxiedBy: LO2P265CA0281.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::29) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM4PR10MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa4e5da-92b8-483e-9d5e-08dcf20f4016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hAmz0dIwwRRHKRrmIEuDirQEuPnPYxjs9vlpOl/ab1BWQ5nEvvNaELiRAf0P?=
 =?us-ascii?Q?k6hdkaCJQXYzSPAOSV5mJTpEww7wu9EO58AiW/aLaVP/0G9/hrPfCATRKjwC?=
 =?us-ascii?Q?yrO6TUwZp0FDVhfwrU76FZNkuVVN9YkQX11bFbdEnG6jVIp9qXRqNsZ3N9Nn?=
 =?us-ascii?Q?hw9Pqi7C33XyO0u6RKyUd1Lev2NhH8Yn0HiVxIxBj3d73L3vKZdQmkjrBsUn?=
 =?us-ascii?Q?iwFxKHRX1+b5UMw5NXr7TPXhEIwqHlFFo49/jpZVMbeQPAnvr8ZZ4bTD2ffl?=
 =?us-ascii?Q?JrUUr9m751g7OPs0RPxk29IN5KMKEHM74xPDIPH+8RchUfdpqL0lYrOfXp1u?=
 =?us-ascii?Q?bKZNzR8llNPPmpQzFInn7C0piXUaV7mPLRfJiE5WMZhqXrsVnfFByPgWPlvt?=
 =?us-ascii?Q?w6CiEJpnVKQ3QDzJrvQ4KV8+KV+CJ1AVuE4+sOEXZnC0tN4SubMXWYxdCm/6?=
 =?us-ascii?Q?rB7rflDIokWb95sJTlExfJT7W8L7R7ClqysMV7XFtsRMUHNX9Ag/qX3ddnad?=
 =?us-ascii?Q?FbGzKh8IRI4fK+uOfdo5EDUHEcsW/Ko5+2WF7aVndC4zhfIQ4ujJMJ79SDv6?=
 =?us-ascii?Q?W+0JJMeam80DJnIG3ptEcQgUFBC4bg4D6Su/FGHwKObJgGHItaZKJj3RE7fT?=
 =?us-ascii?Q?SU7LXCt9Dxr+uyIn1wcyLsB8+6QP4JYq2a8ixbf/VBJ4aQ7t8aJCIulhmZwT?=
 =?us-ascii?Q?6hYxPwF8dEWDUQP5MsAU9s4TQeJSzfmGszpVvGFdh+V8jxx+kBlVQ5t7BL3i?=
 =?us-ascii?Q?XuYmKBC30c8RgjHLeOoJ5dnyJQJI+q1ZHiBy7e0mPgfuR+92NNC5O6YczJ9N?=
 =?us-ascii?Q?Ju3mFUgDq8bT1fxecuaN+tn3cLcMH0WfvAWgK+OwTeu5xvUGp9CMEguxYrLV?=
 =?us-ascii?Q?pfbOVsBIUHAPUYpTXKGa2ltsa0CC+CDaOJq5n8MUNJaQUwa1nJTWu4fs1TAY?=
 =?us-ascii?Q?R9UYVC+WeBrNIouTZZryltdPhXCI7s+cvUic1g4dP9nqYEv9f0wjrua1DHgJ?=
 =?us-ascii?Q?FZ/q5aXc/OgHlYQFzGnmYxoQB7cyXt5FrhntAJwmhrBxf3m6XcKUUqERJ1bz?=
 =?us-ascii?Q?ofGdu4jvWVF8Qj1BXe8kCdhNnh2V0Oz/id5BWnW1oA1oItUsDcKVoEN7LaEf?=
 =?us-ascii?Q?huCXdhajyV3s2u84ciD2R/1RuUlrwLr5tF6Ds5X9LtQJqUmR/bM48+m4aq3d?=
 =?us-ascii?Q?SBVeMnGzNXccrH/DJPOcjKNcudgSnNbK8ysNE8s4DQmejlI3zb/U3v1PswMn?=
 =?us-ascii?Q?4YbmWGkY7UpGM7adTQ5N1s2/qsefSfp+OuCF1eBJ9E0RFNpxtae7riuyn9Qo?=
 =?us-ascii?Q?Id4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vQMn1i9l+IoAmIQ0vnPOOU2f/pGVl6QT0o5saCMg/5s57Jj1XXxgKrZI01cy?=
 =?us-ascii?Q?ih5OgAg1AiYbzCfZJTgPBRtOJ4ztozK5VG/XQxGtwYJXVLp5pAg2v9ukY4UC?=
 =?us-ascii?Q?ZoKFm7SvjfLI0SIuitjmFj8yxZYUrjo6Nbl/YcEJ+vWJcLJrJExPXeekMm4m?=
 =?us-ascii?Q?ahsBVUAo/TW0vAG5oe9cniegk9z8BfgGgEq0V+bWg1xW40b2AXYaME3oMHyY?=
 =?us-ascii?Q?ZO0XzGu6V3DhEyGAN+RwbqD2KDGxnO8ECdePODRK1iBGWFh4/GuCSYCgAjTl?=
 =?us-ascii?Q?Pw//m2KLabFQ810M0ilZ8XEq23UASiAIFuf41M5N+LjrqRfuylr5Ud6G8bX0?=
 =?us-ascii?Q?+5NfA8xuIdsYVRvXc0j37HBCRnDnVPah9ejcaLR7R0YhEt+qqhXVrxjIZjAs?=
 =?us-ascii?Q?aOSH05nA+wFNxlwH5nIPUN7Jn4ETf1H89XvAD8N3dyKeUK0nOkwjRtWaGoDZ?=
 =?us-ascii?Q?h32sklaRFQanYd2C6fr+vcK6i30qE3CxUzDpDZ3Afq3EOR3EjxqHDGtCrC1+?=
 =?us-ascii?Q?ByfTi94ozXl3W7WlGeoPNQ4Ljt8ZC/XuFh8dWGIAN8Qqx64s0VqKSlMSj4DE?=
 =?us-ascii?Q?SxZCA/VJ7lvgkUAkuFvkgOUYjk5Y74vL4qF2y7KUwikIcHD3AAG/mXl51qA3?=
 =?us-ascii?Q?SrUkYiBLzPPGTBoofHamiJlohEio+DRItZXiJNVRuRsIWR6NkaOR2CC8g+Ev?=
 =?us-ascii?Q?YH1pfGVBQJF0qJdnvSnRUlcvSA+3BPXfOT9rv10ojMGTJ9qQt9QkBWz8bbzw?=
 =?us-ascii?Q?hFYUmeiFlyCtwcFrHeuAdpjkIw6Rjhs/UxY8nUGp4RIJ0dpLrl3BZ/y/Uehk?=
 =?us-ascii?Q?uvS7wa+lcQqoahAGqXMYOJeKvTU6+kvSut3JT1EAqPAaHMpNHKGbkB22av16?=
 =?us-ascii?Q?uH9M4NIQIAsaIJO5nmqbQ3l+Vst68AbnepW7wlijr/rV+pcbqaxjKdpiNSBt?=
 =?us-ascii?Q?j3n6l/9YcUIm6oDF9cAsyvbJqasDo3vnrqNbOQpRtmFS209bB6VcRJsJh8Zi?=
 =?us-ascii?Q?CGDM3w42ktZKJrXK0QRJB7zTBvQXvt1LUWtxsOR1VqXe5fCUo1zQU9joLl3x?=
 =?us-ascii?Q?ZwhFWclvEtb+IgTpUWG5szWMpKtgtMcRTJEGlT3O5DfisIstVaUfcZDOui55?=
 =?us-ascii?Q?IzgRUTwkjD+7cdPP3ynciv8DrSWlThdfpKTtimAS0o7gt/vRsEy11x+DDFOx?=
 =?us-ascii?Q?+7xHegrhTsh2O5K/WA8uIgQBFOEZ4LsWgT9QG2c8pqmVPR8ZPtoGb0yDbUwO?=
 =?us-ascii?Q?FUFGkWYrT48deIXSP7gddwzVPytKPjBemintGl6HoTq96H9BTizM2vb41aQv?=
 =?us-ascii?Q?xs1A10UmmU9PIdcR6N91IEg6ArRbVyRjSdeTzcxraJ5wiR1HXjqwlhA+GDjL?=
 =?us-ascii?Q?ans8vLaYyGT0lf/CRGCcYNeOJqRbSzgFwLqJqa3zM1tkGEogqkythzSVSVwz?=
 =?us-ascii?Q?t5bzt0Zf3j1sokMJPxa0uTPlKFsgRk2i/AYLV9Fqo3kthXL5TykFRwzvf4vt?=
 =?us-ascii?Q?V9JiWIaKecjiwmVc9tXEKV3cJRI+90mskvRReKRLj7Hs7xSOFKCBeXkRQD88?=
 =?us-ascii?Q?5wfEzgsfjn7r7dog3/v9MQdZT9i1FiUlv1YVcJUcVkBj2ZTeu5lGPTZv7lni?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XCmerjsgl4NaQh3FNDNlM7SqgKJLZwPnfYps72jqqvJ+OIAU6d6JcHYjgg6q9PujCNPNR/SrG55pkWpP+H0aqaG4OiixaW753VMmZY/2bqHOxwHkgChqPcdgkRcuGodnzTRcZqoHYw8n8AXp/txyd4vzNVinzPk9hI1BB10HHbSRpKJCYZlj2tbqvHo5aJUJR4TkGZQk/ECFtdWB94MnD1bK/9GYJU7u4PKw08g3/KfN8yTWUgB3EVNk6tirdlnYDlgNko1r2CRqb060s7xfqJP3bBBCbmYrhBSdtNRJJDzhnwFAWT40CxzsCRz33VTQsqpqvVdOhoddAOxdPPxzDnM6tB0CalkPW7+aJsjUg1L17DB2DY6tgqxWwSNioaye9+IhwNONleYUii5e1LEDJiXed9QtgFQFWbFMLAomarj8cPIo/2lx/w379zCdKajyRGlpa+895mvLu3p4/cahA4Q4CC42jZ7DzvzlWe4Crvt/8cdtqNkpkBS+DlaaQPwNZ/OYsJDvzpjBioljVoTg0I7R5a071qPWghQ7IySu+WaJkRET9cbQpa0bSeWrzC6q9Nef5dEEs4wd62WHm4yr09zJ0ytFTpCZkwX5zqtFwqk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa4e5da-92b8-483e-9d5e-08dcf20f4016
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 20:30:49.6298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Lay9C0GaD/FcxtlIxeEo+nv6r6S1GvJLAcR5ac2S8piWVkrD8JMQt1/Y6Ar9FA+q7eG5D3RwkzhWDhWhjUdcR4qSyT2civ8q3GeMY43g90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_19,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=985
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410210147
X-Proofpoint-ORIG-GUID: WGixXZE48RIA2hwgOOSGIQpBosKQV99T
X-Proofpoint-GUID: WGixXZE48RIA2hwgOOSGIQpBosKQV99T

On Mon, Oct 21, 2024 at 10:25:06PM +0200, Vlastimil Babka wrote:
> On 10/21/24 22:17, David Hildenbrand wrote:
> > On 21.10.24 22:11, Vlastimil Babka wrote:
> >> On 10/20/24 18:20, Lorenzo Stoakes wrote:
> >>
> >> <snip>
> >>
> >>> +static long madvise_guard_poison(struct vm_area_struct *vma,
> >>> +				 struct vm_area_struct **prev,
> >>> +				 unsigned long start, unsigned long end)
> >>> +{
> >>> +	long err;
> >>> +
> >>> +	*prev = vma;
> >>> +	if (!is_valid_guard_vma(vma, /* allow_locked = */false))
> >>> +		return -EINVAL;
> >>> +
> >>> +	/*
> >>> +	 * If we install poison markers, then the range is no longer
> >>> +	 * empty from a page table perspective and therefore it's
> >>> +	 * appropriate to have an anon_vma.
> >>> +	 *
> >>> +	 * This ensures that on fork, we copy page tables correctly.
> >>> +	 */
> >>> +	err = anon_vma_prepare(vma);
> >>> +	if (err)
> >>> +		return err;
> >>> +
> >>> +	/*
> >>> +	 * Optimistically try to install the guard poison pages first. If any
> >>> +	 * non-guard pages are encountered, give up and zap the range before
> >>> +	 * trying again.
> >>> +	 */
> >>
> >> Should the page walker become powerful enough to handle this in one go? :)
> >> But sure, if it's too big a task to teach it to zap ptes with all the tlb
> >> flushing etc (I assume it's something page walkers don't do today), it makes
> >> sense to do it this way.
> >> Or we could require userspace to zap first (MADV_DONTNEED), but that would
> >> unnecessarily mean extra syscalls for the use case of an allocator debug
> >> mode that wants to turn freed memory to guards to catch use after free.
> >> So this seems like a good compromise...
> >
> > Yes please, KIS.
>
> You mean "require userspace to zap first (MADV_DONTNEED)" ?

What on earth are you talking about? This is crazy, we can detect if we need to
zap with the page walker then just zap? Why would we do this?

The solution as is is perfectly simple... What is the justification for
this on any level?

Again, if you think there's a _genuine_ security/DoS issue here you're
going to really need to demonstrate it rather than hand wave?

>
> I'd normally agree with the KIS principle, but..
>
> > We can always implement support for that later if
>
> it would either mean later we change behavior (installing guards on
> non-zapped PTEs would have to be an error now but maybe start working later,
> which is user observable change thus can break somebody)
>
> > really required (leave behavior open when documenting).
>
> and leaving it open when documenting doesn't really mean anything for the
> "we don't break userspace" promise vs what the implementation actually does.
>
> Or the changed behavior would need to come with a new MADVISE mode. Not
> appealing as it's a mess already.
>
> So since its uapi we should aim for the best from the start.
>
>

Best is 'call the madvise(), guard pages installed' which is what it is
now.

