Return-Path: <linux-arch+bounces-8376-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936899A70D2
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 19:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31D37B23928
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 17:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B427A1E3780;
	Mon, 21 Oct 2024 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dWn6mpN3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DyNTKAMj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E5E1C460D;
	Mon, 21 Oct 2024 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530986; cv=fail; b=KrZ14j1CB6FLLvrecT6Mx04OCAHvpbbevBVfGc2B3wOJ/Nk4iv6I0TF6+lKQMPuR9YRIPPQxCK5WyJ/6+6O7lQmgx5iE6a8zPzhm0GzgdXFK4az/nnyrZQGYpAPIjzL7xIOcBdT8rNkU8sGsUhPDaVIDPEYg8zUnM9hq5XhRJdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530986; c=relaxed/simple;
	bh=bkqVTkl2ScvjeGf2pIwDsix3MSWhbREopNbrhV4vWxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fsFwyThDlqZs56B45uVJ9HHV8r0t9AMIvZ4PoilsROh12dBr283Gj+qjIBrRv4tmiEv9OOjb0ERT3EqTQML1E85T+By4jZ3/TRz0xoCsoF4e9vub95EcWiXWmCj452xVyDij7ypmdaKe92p9cJc7G8ME5qV7kgm7waVAi4P9yRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dWn6mpN3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DyNTKAMj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LFtdNF006327;
	Mon, 21 Oct 2024 17:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=jIIx2Mnl0e+O/kbalM
	TwpR/wAIGSpEs2MaCq1no5hCk=; b=dWn6mpN30hD/BMVMQFI6OWfFqUWgKnn4+d
	18S2fepqKTYdzswzVPfvVKWupw8NS8Azin5Zvu7naytfIEX9Lp1I0OQBhCSbi0HZ
	+QinOzVK+iYE1yxA3lxAdk36b51R1z1/lBC0ovTvh41yk5jAIV2qLKuVmfiA1ITa
	wFST9OjLl7gZmksG+qw970c1MMH1jkEQgZMapRgOuPJSmq/LvPVLBMB6rKZaXnwl
	WAbny6LeTb/45xSlJCXia3zxTwEacj3wSkOcPn+uYIPjJ+JUA+hQV12LMNxTGETQ
	VHNetdmvmPVAlX57hQQ/YYKfIynxU1SuZElrIpzoHggqiyLXjz7Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qbndt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 17:14:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LGSqS7035313;
	Mon, 21 Oct 2024 17:14:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c377c7ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 17:14:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FehyfKBTtyQcLEwr+oEGNoESiN0lPfTGOFaVp48psu5lBiiK3R4lYKNtaemVHTsxUHNJ4PEdIEOx7FEoQIChFcl0M2tM5Ql08wXUy0jIskO2BE7FPv00BjA9rRlhbstLjPKayUp9wRnZpGpY7JyVP0z2iXfIww1h1ep8Ub1aEc6EeRlnfZ6nFTadqnE9WoP3Fmld2bYpnnnTss5Emx/n833Bj1JA2MjtnKjUOkzrGSKfaMMTVvJybEgspvHhss7cCYnHFCzQ0onxknJzjTZPmptPe7I92g2vnOYbD9g9YZVcJPscKclrDVwdCv19vcd7xy3iab7ME8hcMbrxaMFt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIIx2Mnl0e+O/kbalMTwpR/wAIGSpEs2MaCq1no5hCk=;
 b=MoRfsgWqkTpzx83faIla6YC9HfiyAK5k8y93g+vsYBEk6jNGJAgNYN585RLfI5wmos21JkTvtw3KsU5W2IcLspFkhhVIQ2dweQR/7PM1w4quLkqg1q/JdOQc0wixI7wV/1vp3NXHQInoTaPVQA4zUhp03G+1zJw5Cley3ZlNK3CnLJKhhM5DbHIXtDgsxUxqL0oJYHv6srRsGsbtN1I6gIHyM6uKDJJ0zOfztzDBdqVWM+zebzMRxwIEywpc9/br8WiXfyO1ci3MEciaVahqTMMEfQo4e7NlYiO4atI/7tS0xXwlyvk56d2mdN2o+vc1sg3WuzSHT5zfHXJNSI8L0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIIx2Mnl0e+O/kbalMTwpR/wAIGSpEs2MaCq1no5hCk=;
 b=DyNTKAMjoNJqItcifaOP4BG1iDp66mjeFEWBAuP4rizgpcNj+IY6t3aC2Vtna2IEc9G7C2IWck4eB+1sm7NjloLsw9gKosINlnrc3sB+R4Utd8rRo8VtKtO3lnIJFgRt+0N0CrSBdVk1qQohXivHTeGzVSntIf3WDxxdobcRPOY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA6PR10MB8182.namprd10.prod.outlook.com (2603:10b6:806:43d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 17:14:46 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 17:14:46 +0000
Date: Mon, 21 Oct 2024 18:14:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
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
Subject: Re: [PATCH v2 2/5] mm: add PTE_MARKER_GUARD PTE marker
Message-ID: <acf358a4-c503-4347-8156-9269c43bf796@lucifer.local>
References: <081837b697a98c7fa5832542b20f603d49e0b557.1729440856.git.lorenzo.stoakes@oracle.com>
 <470886d2-9f6f-4486-a935-daea4c5bea09@suse.cz>
 <434a440a-d6a4-4144-b4fb-8e0d8535f03f@lucifer.local>
 <caf95a99-e975-4f3d-a94b-298a5fc88b5a@suse.cz>
 <4f4e41f1-531c-4686-b44d-dacdf034c241@lucifer.local>
 <cb0e49be-7b4e-4760-884c-8f4bf74ec1e1@redhat.com>
 <ea771edf-0e38-440f-b264-3cbe285a628b@lucifer.local>
 <49afa956-21e1-4b3d-9dde-82a6891f2902@redhat.com>
 <cbf17dc3-01eb-4416-8ec5-cac05e50d663@lucifer.local>
 <ef0e11c5-13cf-4d47-a277-41da317be165@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef0e11c5-13cf-4d47-a277-41da317be165@redhat.com>
X-ClientProxiedBy: LO2P265CA0174.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA6PR10MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: f611b90e-4f9f-4db7-a7c7-08dcf1f3dccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XgL8nvyRmVx7EQuD6IcfwsDNe5zT0bz7D9MFQj79mjlefhCi69DaFvHLrDYg?=
 =?us-ascii?Q?eufY6AnshPWaTGMl9tQCKJG+W7bNlgl7lDULpMR7uXSAV6EK6FSnDq3UojeH?=
 =?us-ascii?Q?BUiOZaAjWbarMg+9P4K2Rc2b+teVSu7iYMCoVLXZxiKCD+TbWHyljwJ30ykz?=
 =?us-ascii?Q?UNxq2Y8nd8GNjUpPkNwA/ddH1Po2436QWGFjCIl9ZqSTJB74vLZiWtBkYx7q?=
 =?us-ascii?Q?zCy8Mnod6qkjYSWT2YnTiFkAkklj7SzA+c85DsTurBM3v0y/b9Sy2njTMCKU?=
 =?us-ascii?Q?Xl4j1i1ZuKKx62vrMqt2aPzSZ1SgaHoYCBWhrHhM7YOQCm+BzlM9oVH8IPqL?=
 =?us-ascii?Q?hIOKt9N/ZHbLdZKfnCarUSEb+TyXujFqRcFmCZ2zjFhta97SDSgj9OUTn7qN?=
 =?us-ascii?Q?HROpNB+uRIKs7yopyZGRLfryE700Kyo7iAaCihy2AEY4aUZdXhC9HeLES6X3?=
 =?us-ascii?Q?w6vMf00/dikT1n9cP772oXgwG5qbsjkQhqTyq+YA/lQ9nIGkpa+oXo7PaCAf?=
 =?us-ascii?Q?z9GHkLfVeC3Y/mx2woTXWy49dMffcOq892zMgBfZri51AUp0SA4mxE4dWw0q?=
 =?us-ascii?Q?AjkFL+AiT2J5cFaqlIUkTuOaxc6MZ/zcR0GkS4u3CAtFIHI/USNnHZob24+m?=
 =?us-ascii?Q?qklZs422Ix1O4BKQ46UD8VetdG/poKwRqcYh1yoxZ5Y5gmX8f8uEMOnXtkhj?=
 =?us-ascii?Q?dMDot+iPQgnFLrnzAHRCMrdEKDsiSofMgp9PsvDAkUcBP4/nMzT2oF0AdSYX?=
 =?us-ascii?Q?hm5ACMzV3KEbZbzjXZcfTLdEcwdyqPYel2iQSf3ZJGUUzQDxlwXVHfwdxypR?=
 =?us-ascii?Q?3fe9y6ku95vr1eV6zCkHkGkKJA888H/s78iMPp/m3+NSj8J8YdmRoakPFxNl?=
 =?us-ascii?Q?hHBAeP5M7TF/k+nQe+HTdX3Jo/61R/pKTNtCMVFpxQVsh/Z+Oz4cTl6cLjQ4?=
 =?us-ascii?Q?g6NC3dGxuOc5PgpOMf5JpJ4V1XEe22dSnpwYCYl5FOLCWAy7ItOqpjq/Tt6S?=
 =?us-ascii?Q?Bks+s88aMUYuxvmKIqt8TQjFYu5TYdMQHVUV2o3zfb3eZlsSXKXHmEDgiy4x?=
 =?us-ascii?Q?tshlcDhxxZ7nEzejpPULqgowS3N0zGXIO2ea4M8e6J5TO49LXxLmMUoW0GFZ?=
 =?us-ascii?Q?eHTW8hy5MruJ2caoUhf1E4OY5A2/BdPWZ4bGFlU002tTp+NrKCqsK3FdS0aV?=
 =?us-ascii?Q?GPJJmo36iUTwV074FNSAlq5z6bZlHwGk4UPlJKva46SP55O/cV16pleySKy5?=
 =?us-ascii?Q?CxVyJHq/1i5Ifot1QoGr4AubccuRA0Ohr9/XCV88eOc3pUWtC80Hpqguqeqp?=
 =?us-ascii?Q?usA37yTEwR7ldbzFAD5LP9eC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4h592kr6DzpB5gYRm8w3lzPIWx/Em1NHwhI06iOnJGLh2t063BOUk3DYGpE5?=
 =?us-ascii?Q?675p9tTMMCspdd8hMZYQFVeG1H2D6/7Ubj9r9xou+bp2Co0EhqbX2RCH7ZbA?=
 =?us-ascii?Q?vk1CFosPAuwET2WYrJmtM998A0RcfoZJ3w0ayKOmmiU9Rb5an6uhiKv+IkHK?=
 =?us-ascii?Q?OSHuIiwFNySUrIMcIZ+myRNno626iOvSldZJIpFjX5hVNJSrfXuq7cwPYPMo?=
 =?us-ascii?Q?HZbQsq2/yg5q6NL94L7V0LR1ueVTHeILfzj0OvVEN7dtzFM2/bqhh5HSRgux?=
 =?us-ascii?Q?V+V8tf3lQJq4Ja8xaIHMfp00SAe4Yz0AGXa0Q4HBYxHGmCgRExwUN0VKol0B?=
 =?us-ascii?Q?2cNCSb9HV1nrZ+8mhhRp6WcxiJ+AZlsXtN830HO8791iCay6YRNXADtA0N2R?=
 =?us-ascii?Q?OkUZrePSOLxyVjXCTth2gy7CVommjKwZQjFi0vVyfK220R6crC9Dbqa+gtQ+?=
 =?us-ascii?Q?g5Rx06BOe/KF7SJzwQdR83XoLF33mxNKgKA9W2o74M3LvsmGtXCGSpKCEHGT?=
 =?us-ascii?Q?vBfoTw0AVyhQrebtP678sdPE5PmaxkXw3dsD40JKly0kaJTQpLLQW/Xsywv3?=
 =?us-ascii?Q?hsY1cUTqitM43B5N5/6M8oKcHb8prIvzGH9N121hbDdQjcl/6lPJmSrt0BoU?=
 =?us-ascii?Q?hY/5pt/UM4LVOab1cGTrE4oZW23ny2FME28xUUf38EmIDpZEGmspfO/9P5UA?=
 =?us-ascii?Q?FCPSkG47OO+qqi4Zo3UIMOGFo3mYQzGT0M3myaZxPSAMfcP1g9+CL+C79Qgf?=
 =?us-ascii?Q?Je4grIVMG8jbYkpLwNm1GAs4tpUHKy1u+PtwB3gvYjZH+ieWJI3wknt+j82A?=
 =?us-ascii?Q?glJs8bJOCwLYsIQYU0oJHmktuzcNwY9yTFIf5lQAvKty8cXJIA06+Z2D/8BC?=
 =?us-ascii?Q?WWdJfyUTB0vHJTpobs3iNF8XmNq4ALhdstthEpNP1tJSgVm81uWR6mceX37A?=
 =?us-ascii?Q?9ZudDGYJ3JqDdntdSL40JJM8vqzbRGXWfuT9qsLyMaoZj9bs5O/bojToe3n2?=
 =?us-ascii?Q?Wk+6qiKGKJHLUCDjROn+SleUnIHtPKUUKoD3fQhOGznu0cJ27j6OQWCuUS/c?=
 =?us-ascii?Q?tuTlv/lrVOAchpH9iRKMYq/yC3o6Y6UULwR6TubtL/Fc2c663avW7s0psf+j?=
 =?us-ascii?Q?mQvq+khZ63jIeUM2mQrZQXM2viQO/aH13VLQeCUc4WC1B1ZOuhTRRT+FpnIM?=
 =?us-ascii?Q?hVKRMLFlgwAPYzrLJ6kLzKLWRfC6DIheVk02RJSKWbpwtC11BmwRjGSOGflP?=
 =?us-ascii?Q?DiypQiBzxCzEh991x5Xqd1b8QHy58bj0XO8GGOAAtgaYrbg13Jj224Z3VZXF?=
 =?us-ascii?Q?IYeatg+aIyvvnvr1i82P5WXK6xr5+3xv9Xp0nMqVcc16E6R1fAp2zG+IvcJk?=
 =?us-ascii?Q?XodVJoAJtczIwPtsnUGpSrJElTrKuRb8kXrEaavDlLb+4UvM7gIe1uvHod+t?=
 =?us-ascii?Q?meUzZdly5mlAdq3tXi4ZcQU/RjXPPwnlrVXPoicPvhml9sE3ZvikzXnmtWSu?=
 =?us-ascii?Q?fMcIqPmsajsAQ9RubDTM2Tc6q0j721OKT4TEx+SfGMv0XDVsu9PysAT3OnXz?=
 =?us-ascii?Q?TPafqIAeLmcXwzWR9556p4oYAKmQOFwEtbuvsO07N/TSYKf5oecR24Z8mzLl?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RNCd6VAA+Lp/NMwcABvCHG2t7UvCer34Wbs2RoyJS7Mrg3drKNHqCV+CM4tC6mE1chKsxwosYNCNiTodjChDdoJZp5lZ8mId5YlOhKjbMNi0967/cwF7cfypULsMapMFvaNyDF4+6D/7AoD4Fn+0++rSUDnpUtPfazw2MCJkD5bVGRTC9ySOKj8Igz7RZTzJqvdjITzRgEpHlwBZooA4ojKDQ63BR0pyqICMJuOEnyHnqV9x6vdjMy5xRYX1/ghGlfZQGKZssde/nodFqArYnP3Ck9br4Rz6vYhC4qHVWxs/f1V+ptZLMD1G39E+rcmULffjKL8B6aBbMtcqtbKghUHnNdV7jDA3jbr+Pnmi+WJ0/Xy67ojIozDcv7N7FvA+4aiMzYL35dJ2MU06vyMYydZqA46tAbOODtDd3Th4XodDM1xNwvkm/hIOUuT2s9xD4td1Xnn44GaaIlWxrq5UpkKgI8YVEu0jWvf4HR/iJJgjmfFQ5sMxtq63vtKIvoz0hx6spA5dMnyfo9sh0yePKcEGkROyiSeyxFiwufZ8G7LNJv5qmHEhtkSQzmELQvb2Vo2zC6AvD5wYZSct2ojp0u9OZgGF8Vj/8RSBPGXk4wc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f611b90e-4f9f-4db7-a7c7-08dcf1f3dccf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:14:46.6948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJy7qfD2y+UOCtZn9tReGogc6GtRceeGQLiqIVUHkEZTv5FsX/qTdxnArD11yHXZMy9O0riHw9RruyxrWaQ44aXULFLAV32AbyfNr2v3YWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_16,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210123
X-Proofpoint-ORIG-GUID: YcueN6QnCgQi9hG-jyWhMaEHmxF0cOaR
X-Proofpoint-GUID: YcueN6QnCgQi9hG-jyWhMaEHmxF0cOaR

On Mon, Oct 21, 2024 at 07:00:53PM +0200, David Hildenbrand wrote:
> On 21.10.24 18:51, Lorenzo Stoakes wrote:
> > On Mon, Oct 21, 2024 at 06:44:04PM +0200, David Hildenbrand wrote:
> > > On 21.10.24 18:23, Lorenzo Stoakes wrote:
> > > > On Mon, Oct 21, 2024 at 06:00:20PM +0200, David Hildenbrand wrote:
> > > > [snip]
> > > > > >
> > > > > > To summarise for on-list:
> > > > > >
> > > > > > * MADV_FREE, while ostensibly being a 'lazy free' mechanism, has the
> > > > > >      ability to be 'cancelled' if you write to the memory. Also, after the
> > > > > >      freeing is complete, you can write to the memory to reuse it, the mapping
> > > > > >      is still there.
> > > > > >
> > > > > > * For hardware poison markers it makes sense to drop them as you're
> > > > > >      effectively saying 'I am done with this range that is now unbacked and
> > > > > >      expect to get an empty page should I use it now'. UFFD WP I am not sure
> > > > > >      about but presumably also fine.
> > > > > >
> > > > > > * However, guard pages are different - if you 'cancel' and you are left
> > > > > >      with a block of memory allocated to you by a pthread or userland
> > > > > >      allocator implementation, you don't want to then no longer be protected
> > > > > >      from overrunning into other thread memory.
> > > > >
> > > > > Agreed. What happens on MADV_DONTNEED/MADV_FREE on guard pages? Ignored or
> > > > > error? It sounds like a usage "error" to me (in contrast to munmap()).
> > > >
> > > > It's ignored, no errror. On MADV_DONTNEED we already left the guard pages in
> > > > place, from v3 we will do the same for MADV_FREE.
> > > >
> > > > I'm not sure I'd say it's an error per se, as somebody might have a use case
> > > > where they want to zap over a range but keep guard pages, perhaps an allocator
> > > > or something?
> > >
> > > Hm, not sure I see use for that.
> > >
> > > Staring at madvise_walk_vmas(), we return ENOMEM on VMA holes, but would
> > > process PROT_NONE. So current behavior is at least consistent with PROT_NONE
> > > handling (where something could be mapped, though).
> >
> > Err, the handling of holes is terrible, yes we return ENOMEM, but we _carry out
> > the whole procedure_ then return an error, an error _indistinguishable from an
> > error arising from any of the individual parts_.
> >
> > Which is just, awful.
>
> Yes, absolutely. I don't know why we decided to continue. And why we return
> ENOMEM ...

Anyway UAPI so no turning back now :)

>
> >
> > >
> > > No strong opinion.
> >
> > Well you used up your strong opinion on the naming ;)
>
> He, and I am out of energy for this year ;)

Haha understandable...

>
> In retrospective, "install or remove a guard PTE" is just much better than
> anything else ...
>
> So I should never have been mislead to suggest poison/unpoison as a
> replacement for poison/remedy :P

You know the reason ;)

>
> >
> > >
> > > >
> > > > Also the existing logic is that existing markers (HW poison, uffd-simulated HW
> > > > poison, uffd wp marker) are retained and no error raised on MADV_DONTNEED, and
> > > > no error on MADV_FREE either, so it'd be consistent with existing behaviour.
> > >
> > >
> > > HW poison / uffd-simulated HW poison are expected to be zapped: it's just
> > > like a mapped page with HWPOISON. So that is correct.
> >
> > Well, poison is _not_ zapped on MADV_DONTNEED but _is_ on MADV_FREE :) anyway, I
>
> Huh?
>
> madvise_dontneed_single_vma()->zap_page_range_single(details=NULL)->unmap_single_vma(details=NULL)
> ... zap_pte_range()
>
> } else if (is_hwpoison_entry(entry) ||
> 	   is_poisoned_swp_entry(entry)) {
> 	if (!should_zap_cows(details))
> 		continue;
> 	...
>
> Should just zap them.
>
> What am I missing?

Yeah ok it's me who's missing something here, I hadn't noticed details == NULL
so should_zap_cows() is true, my mistake!

In any case we explicitly add code here to prevent guard pages from going. I
will correct everything where I wrongly say otherwise, doh!

>
> > mean the MADV flags are a confusing mess generally, as per Vlasta's comments
> > which to begin with I strongly disagreed with then, discussing further, realsed
> > that no this is just a bit insane and had driven _me_ insane.
> >
> > >
> > > UFFD-WP behavior is ... weird. Would not expect MADV_DONTNEED to zap uffd-wp
> > > entries.
> > >
> > > >
> > > > Also semantically you are achieving what the calls expect you are freeing the
> > > > ranges since the guard page regions are unbacked so are already freed... so yeah
> > > > I don't think an error really makes sense here.
> > >
> > > I you compare it to a VMA hole, it make sense to fail. If we treat it like
> > > PROT_NONE, it make sense to skip them.
> > >
> > > >
> > > > We might also be limiting use cases by assuming they might _only_ be used for
> > > > allocators and such.
> > >
> > > I don't buy that as an argument, sorry :)
> > >
> > > "Let's map the kernel writable into all user space because otherwise we
> > > might be limiting use cases"
> >
> > That's a great idea! Patch series incoming, 1st April 2025... :>)
>
> :) Just flip the bit on x86 and we're done!

;)

>
> > >
> > >
> > > :P
> > >
> > > --
> > > Cheers,
> > >
> > > David / dhildenb
> > >
> >
> > Overall I think just always leaving in place except on remedy err sorry sorry
> > unpoison and munmap and not returning an error if encountered elsewhere (other
> > than, of course, GUP) is the right way forward and most in line with user
> > expectation and practical usage.
>
>
> Fine with me, make sure to document that is behaves like a PROT_NONE VMA,
> not like a memory hole, except when something would trigger a fault (GUP
> etc).

Ack will make sure to document.

>
>
> --
> Cheers,
>
> David / dhildenb
>

