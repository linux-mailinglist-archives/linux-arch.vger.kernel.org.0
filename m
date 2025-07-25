Return-Path: <linux-arch+bounces-12943-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B948DB115CC
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 03:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD45D3BFD78
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 01:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4121EA7D2;
	Fri, 25 Jul 2025 01:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cFTWf2QS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CDhoYCuN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3681A0BFA;
	Fri, 25 Jul 2025 01:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406562; cv=fail; b=DKu5CiaOxKXlnp/SheBG1kXv4Y4o6XVaR+rFLkJj4B7qIYwG06Vw4QNJ2bhp/Pf4s11WR3wx8ELM4u1f74x7gEk3L/UKDcJDefZeUA0uWtWV1SapBJZ/q55+TALHqfaxCGo23urOH6mg2CxW+UqrdaN7nGvzr4zQf2xdijp1xlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406562; c=relaxed/simple;
	bh=0WgMFR2xeJaRONZOLdrETYlh7XCPzjs+6AQifhJFLkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y9836/fMqEGgIrVIgbclcIQFuok8Yen2v9ZH49N+s/0398petmoydynf+MZf1cbxCosAo/xkqNUup/o3KwhX9gIW8JfvQDKpgYkX70S8EWwJpvbevWqiHFNqHqpEvZxzg42yrZzcaq2LzN9es9i8qMZAJrm1Z0W51oXusvC/xD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cFTWf2QS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CDhoYCuN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLp3Bn008763;
	Fri, 25 Jul 2025 01:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Zkf82jDiAc/bQQLpXr86L153m8k9ndD/B3STV8Xia60=; b=
	cFTWf2QSvpW1hVWskN2X8oqbt6Q+bY1Ab9lNcXkMdu+IDwGkiVuy0qXjV/wcD1RP
	91dzxtxc4K6w5M2T0kDDJMLPO5r+YMNXqlhkpPDw6PvuBu3iBrdU6KmvyS7uYYP8
	u97Qa84nwsjhtyxSD9JphI7UEw5bJquXaEspvyHEnc8uUgWV15nohAHI8hWN/+BY
	n7hoNiH/2ji/lSk2ulE6OW81GEWF43C9C/LDnYtrIAan9iZnm4WQ9Gk9ezgeDuIq
	P2NhAiru24mAy7EBM7FVAbdZTWAsVhkHzgFBy69bvKaK2u8goGKo++7avqOWnQ5s
	YQDSO5NoZgBaODlX1kr+Zw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w3wg5yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 01:21:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56P0ktvm031476;
	Fri, 25 Jul 2025 01:21:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjunsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 01:21:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdB13xcr5feklNOzsHJfvX/niiwTXibgcHlbdP1/q3TII+WykhwJwGbjllrZGlobaAooY43e9LsnE4mSs9liY3KH4C/4UtAo+JaP0PbT9KTEmCgm2fWIq/nVfmbBJ9syQV2JRW3wSKmBK3JH/u/oAjRbr3XhSKQRy+m9gp1uDhGRquRaAPFIrUzLCt+MAM4EyWbaxRPl4IW7eJ7D0Hr+HOjc6I4yG519yL28GPFDkAoIDd5sdttGeBUk6hDaUaJjp/UdtT6jRjmTUi5UUQbSmfNXYDEBO2VJVjEzZ6I3mmlJIU/Hrny0SrBNwRl6l2QSmcTP5/BCFla4xQpv5bIV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zkf82jDiAc/bQQLpXr86L153m8k9ndD/B3STV8Xia60=;
 b=yoQQu/AXQG+mPJqm2/eAUJP6LmFXxQmMcxjzxF5ERaLHiJSNvKLUUUVcfD7a1EmnIfRpJcSMINWKH4rGMRkyw0RHyvvP7w45EraigriA8RbCw23MSsYA+XFy6GVgpiZOsj+l1eFOFeuIQdP9DzoHz9TC2OeWP6rxA0dcSaK/BfSGn5tUPHbJJa7ylPUJ+KoyH2doZnSohFNYDMB4U95E1T8nOl+f+o2WuvVImh3JvgyB3dHsgYetdWkzdPk7SjsdfW7KK2RxHjxQ/z7QkPxXRa1bG4+2EJOWV5ZCRzzGPZlVSqEMC3+w0wFxKxdfP+F6xp6fqbrQ0+d/ZAwxzxoI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zkf82jDiAc/bQQLpXr86L153m8k9ndD/B3STV8Xia60=;
 b=CDhoYCuNepIFZ9a492PCkxNPFEpQbeVl/LZgsEwCE6smdC0xDzDI+9yidZf+4aiC+NPzAdDXZg2RsWkEUCwi1FLD0NYv8Kag6hK+StF1WCzFQ+0LLP7+vFedP+dNQjCZT/ARgGPTHb9GEmkuo1rM3gQYi9nJvZFqh9uDJCttXj4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA4PR10MB8351.namprd10.prod.outlook.com (2603:10b6:208:56d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Fri, 25 Jul
 2025 01:21:36 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 01:21:36 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zyccr.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@gentwo.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.de>, Kevin Brodsky <kevin.brodsky@arm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joao Martins <joao.m.martins@oracle.com>,
        Lorenzo Sccakes <lorenzo.stoakes@oracle.com>,
        Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Ard Biesheuvel <ardb@kernel.org>, Thomas Huth <thuth@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ryan Roberts <ryan.roberts@arm.com>, Peter Xu <peterx@redhat.com>,
        Dev Jain <dev.jain@arm.com>, Bibo Mao <maobibo@loongson.cn>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 mm-hotfixes 3/5] x86/mm/64: define ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings()
Date: Fri, 25 Jul 2025 10:21:04 +0900
Message-ID: <20250725012106.5316-4-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725012106.5316-1-harry.yoo@oracle.com>
References: <20250725012106.5316-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0173.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ca::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA4PR10MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: e003d9e1-7a1c-4e0c-c0eb-08ddcb1998ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c9XXLMRSCa4ZpEqGsjAtmnEmRCsKeOb6sbCj8MoMxvK8rXevk2f0HJ5x8rkq?=
 =?us-ascii?Q?AnsNB4CA5bST62L/Zt1ivBIMAJ2ZYUTBFop0oAipGLWrO1utuzklpGUO6422?=
 =?us-ascii?Q?dcO9fg4uo0g63rzNVD3PrE3FXkx7tJGrTzpFyTGoAW9bQY7Bf3cUANNeIuFA?=
 =?us-ascii?Q?hoSarfAKI/PHrlpmQ2g9yn1yID/U9HTLZIIME4VkYBBR6K9VhtTol4Ng5Eib?=
 =?us-ascii?Q?SiHB5uKzgoVlYHRb+G8OleiycbZwTSmdaDI9X73a4TXkYX1eGU+MKJ8+9kd4?=
 =?us-ascii?Q?MOM0qdAYA7pZGjjrMo5MYfsBLqWbH2HfbkSq6sd+MPDRiL9wVZTFJil/rr+p?=
 =?us-ascii?Q?7GTzE4vm1vec59mygd7Jk/d4z73RSfPOHFvUKWhWPwEMUi0Da03cIzILjwvH?=
 =?us-ascii?Q?pd36LsPYnzfvfNFYsRRWKXyOOI6q7iTSgGNcN6+mNoVfHipqTpGNwHhs0bUk?=
 =?us-ascii?Q?dJXb5BTkC7o6C/WTa9SD/8sfTW4Ng3FDSal2jsMxt+3Hc0SQc0xodLyv2UFH?=
 =?us-ascii?Q?fCmDXxMZGsmAuMnDUaujJ7XNLWBAVgYO+P/q4fGoNLe0DztwLk+EuBP3rvYA?=
 =?us-ascii?Q?gUn+BP99Sg/c5NSJsLfXnWxm3c4qqecb0gGblbSatoIB5s27+536c59diimS?=
 =?us-ascii?Q?N//vqglGAK1t1hJ/x6s+XsfW9pshuhkZVavHtD37SOV8dThyKmErKg78szZu?=
 =?us-ascii?Q?8bmjGk+p0PkthlBN0OQzycb/b8dwxib8DPhBc+EGNM0NXkTNdRqqaQuBpb7R?=
 =?us-ascii?Q?JQtsDP4+wl2ng5YtEsFZIK22SNCfNi3f7bpedsuGjo+PyG8PaDhlcpKm436a?=
 =?us-ascii?Q?7n+703AB+U/D25jmCdYnz4IOJhuVVayAYyCGLaxRUcXHcUSqAxmZkKMXRB0m?=
 =?us-ascii?Q?dXrtUKJ44Dhr4prEqYpcUPojpXDX7KPLhNZqMQH9NjvfNtLxb564w8m7b556?=
 =?us-ascii?Q?sa6s4vGZXQyP45BvjJxDqRrkW/q+FIYqZOuNYu8Wn3DKCh8Hy5gU2qk/xEFS?=
 =?us-ascii?Q?sz6n4uTPCQtD9WlqAg4NwHkCjNXcslHkXl9sQVhLM5JjzqEIQ1PE8QtQk6Xx?=
 =?us-ascii?Q?T/A5+tg594ky6vMgrwKuKzElkkXKrMm6hu6AgbqFoW7Afg7oCfnrn3uuokXx?=
 =?us-ascii?Q?4+g8OEhakn+vi8Tnc9pNWbZIxbvXM79mmEiRjKdQkSsnFdyDDoqE9E0gFr9l?=
 =?us-ascii?Q?aapMatVriwp/Bldfumy1BVHXtxoCRw0cq747zQoHmuDyTGf2lbJGBW7y1xCx?=
 =?us-ascii?Q?m0sZ119N+v1W10RnTceOJngZXi7njE5TpLAe4go3PWvgPJtZoxY0lsyC74Xe?=
 =?us-ascii?Q?L0dVc9glVAscvJXrZjHXiXT8esHk5WESdvaNol9+Fw2ZQWh9YzuECNR5wah7?=
 =?us-ascii?Q?IweIq58Xo0vGoHuKfvD7l2frWTEjWT0lrNhNvfTwP0pH9rWkSgb1nPYeQ/Ct?=
 =?us-ascii?Q?AzUkbBtoW/U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?prjXrfdCg33B8dIBGu25IT2MI18UYqtWAbHtxihQzGoEkkm1t8sPNvCHqDfl?=
 =?us-ascii?Q?XnAooEt6s55nUa3oI+4B4wIfMn4WgDjArTzpjWw2xAB9rAsAMNm+c02b/cYQ?=
 =?us-ascii?Q?mpBZ0lrYqIc3HiPpg2kIUOhgpLXqmi/HJNwyC9c50vq0Gk4Kye35Ud1CQ439?=
 =?us-ascii?Q?yEdgjL/LK15fb5PIlwf/ezu+rrI5D2ehZKGlRmJJ3yvQoUwnptOg1CuqLwmr?=
 =?us-ascii?Q?77Kdz8xqPMD/R1moV0D1UIzF1fI0ZItWeYWbRAksMP5WTF05mYpfaLjCHIzX?=
 =?us-ascii?Q?7fj1D4+uDlIIl3Bh5foHQKhrI5+44vQEXjrrooiB3zNqiyxMrDZtbA2wnoIy?=
 =?us-ascii?Q?dwFAt+2LKq/55r5aTb2AHNBPwj/86NSsSay3TUFD8XG2lP0WM4Ci6wFr9+HA?=
 =?us-ascii?Q?h2qK5mVimX+ZKiBfXcGNAxLV/etVYwxwEt20yd1Oil+T+5eNW/CWTXIvLIRV?=
 =?us-ascii?Q?w2vHOp3g8mDr1IjX/X4YLtMG1uumKp+44eijXuK39nS3ZB3Y3gGk0VL28bjd?=
 =?us-ascii?Q?XDF3Sj4vb2nr8KH2/ANUF1aiySzOsygUjbSY1fBuKKorVqWI+fTC93NYU0fX?=
 =?us-ascii?Q?1xzNPc/dci+p59ZJOLO1WCoBfesVrLopY8c6dmhGL7PQZk5Rl3MBeNAWBmC9?=
 =?us-ascii?Q?/bEIzoEcJhnaoqxKpKnS6/Cw3bcpgKiZ2V3l4Kr1hN8YalPD2WUW2t81eUMb?=
 =?us-ascii?Q?EAAkau6WZ1xlNdDT9m/Kd/M8XKbAv7Yn3coF4l28YYACOzy62ivknOmeH4le?=
 =?us-ascii?Q?VX4FhqILchTdf1ok6NChyZ8WkXOe8KP0FP/p81steybT8Pta7gB4bp4mpra9?=
 =?us-ascii?Q?DWZM8FfIm69vmoApBWa7GSyHO4jRB+bf1tE0MZIZfGw8YGyraNjmAocnocqB?=
 =?us-ascii?Q?ku3jYblad7vwkGM43AMx2VVH0Sow2Omv35fqBOXqOQgsTFpCNhCRC+Wyi8RN?=
 =?us-ascii?Q?AfnCHZ1v4Vu2xj7MazEiZiTly6CTOfx3W7lbq+5/3Ubu7JAPLObZ9Q78+D4A?=
 =?us-ascii?Q?gEVh+tiIAShzhll4zUWqmJqt20LHC5IS9d6TDzfpexXbeO9q0TMWegIxLm05?=
 =?us-ascii?Q?R2yqk5/CIihVjRIAKpRIGMB1h1wshRj1b1SVq4mFeagn1BzVFZUspBrheEn/?=
 =?us-ascii?Q?Gf0zyNkJ7DGZlfm0uSFsS/ZMOg9N5eFYv6alD/7rGHQ/r7LbSRER5SLNgnnu?=
 =?us-ascii?Q?9dbJFrsNnty8e0XYwq92+uDmG4RvERmq838ZebXqT7MDgsyrCpqB7VcJhqQa?=
 =?us-ascii?Q?H1k6ExYkSJ14c9o3Flp98j9xh4DE6N46WHwK61i+2BHrHcDSzLqykecSUs+j?=
 =?us-ascii?Q?9lGNeR+fszX8c8MXfVp4qpIqydlEEMyq2ReW8XcdAJLhdlLwU1UvpzUZ0/AG?=
 =?us-ascii?Q?dopnylMt8cStWJ7ZkrST5TmFV9+aI+N5KiTfTUTZX9NHy3saPSqrUsAEYFqT?=
 =?us-ascii?Q?AvyYmEhnHVtigVCh7dmCc3vCf/yio3bl0Ah46Pc8K+zBZgQVRNlcP1GO5Urk?=
 =?us-ascii?Q?zr7OETr/OyEqIQBNTcmN2rMcFyZxuW1O+OpeemD9BiHjnXFL7UnoIrQ7/9W6?=
 =?us-ascii?Q?IqqfQV/gdJEHJ4HvoC7lPt2mktB3JrXf6ButaLyu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8cocVY1x3vUVQNN6ifTyB3dq0Grx0p5OWKLJhidnNGdDwzS/pcsGMPhfmc1insyqGJvCrV2AABN2MyEMerHYozi3lCz3wnFO65LeANfsG39zh8o0a5UUmfk/K12s3aN3lvtDPaFLYENUTJZV2/aCvgbNZ09XoNhT6diOQ1/zPJ/XeK4ph+vaClzrqDPCmd2lV9LFqMIM0fIA3M5o8R2N0hPDjiCHAI0fkUeOlKeBxaTX0E7F5j7k5LwxUGq71PPSQbpPOtyts990nVfZYSzsg8xtGVlCRYhl2rNyVODqBstq44cydxeB0va1kogFnY63e40gAGLT7mBjhYYhaaIqQPTeAT+PtXa5pdhOK2h4VpWF2pbfmthbTwE9a38mhLrIJCGUm6uvFtiVWo/FLSlbilK+Vyi2SiVkYcIyhUPhK4Znnu58U9IHS1J/zT8ahnI8YPrQVKPx4GewKQvTOopCSg0XVp2zv1W6BOumMLecU605JBvLmgPY8+mNrpSmkBU53BmeGoz7f8ab7QR3mfmJEWTcoy18aznP0yaS63qIUr7Wgzq57Vjp33vcqqegPa/Bw8ag1DrFIiRrINto9VxjM7lNgkFJBAp5BnF2gbdFd9w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e003d9e1-7a1c-4e0c-c0eb-08ddcb1998ff
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 01:21:36.1771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4j8pKWNVYR5DCl17aqHhLeZAi2fUle8dcttEDacwVw0+XXaZ3uG8pVwLGftoqJ/91ru90vfM/i+2rWg7/RpQHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_06,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250009
X-Proofpoint-ORIG-GUID: GAkEVqIxZQhVcQOgVU0Jkn92TY0hKb3H
X-Proofpoint-GUID: GAkEVqIxZQhVcQOgVU0Jkn92TY0hKb3H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDAwOSBTYWx0ZWRfX6WyjtcTInATJ
 X9gQwqXEsUA2QHluc9zlg4RHMtVIor6w0lfInFck+iMcw/CbtIPtMo6Jns76DRgSWZ+YMhj7M72
 RcLZ7IRar3JW8BvF7jAFRXHQneB9gt8YbSlz2fN8fgfEqDzA/DKBQQzXxOpHsWf2snWxsNr76mi
 uJgnKFdlywFR5YRgVJEA7AmkuFJzIUjALh2eaxQ9HmjIMm9Pd9p08V2/0r2Ec++XydpMcSzEBi+
 esJg1Wqau8k7rPRpkpWFG0o72VIPgZoJf7OJhftnjUKNcivSUzm0vImcAVnSSBlwYJdwig0NqbY
 ktSGyHsj8TawJsGfoutCIr0GwLfU4PEA2YMFnQCVHBLYnVhIF3ZlkR7FSuxLoiZh9iL3l8/aqbs
 ch7xCwiX8qF+zH7AfGYcf3Y6OVQ6x7VEIkaOKbPTnrmz8YgqOx5lJGBWnVh5G8eitDfTeGf9
X-Authority-Analysis: v=2.4 cv=Jt7xrN4C c=1 sm=1 tr=0 ts=6882dc24 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=andX2sbcIq9QJGdYwqsA:9 cc=ntf
 awl=host:13600

Define ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings() to ensure
page tables are properly synchronized when calling p*d_populate_kernel().
It is inteneded to synchronize page tables via pgd_pouplate_kernel() when
5-level paging is in use and via p4d_pouplate_kernel() when 4-level paging
is used.

This fixes intermittent boot failures on systems using 4-level paging
and a large amount of persistent memory:

  BUG: unable to handle page fault for address: ffffe70000000034
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 0 P4D 0
  Oops: 0002 [#1] SMP NOPTI
  RIP: 0010:__init_single_page+0x9/0x6d
  Call Trace:
   <TASK>
   __init_zone_device_page+0x17/0x5d
   memmap_init_zone_device+0x154/0x1bb
   pagemap_range+0x2e0/0x40f
   memremap_pages+0x10b/0x2f0
   devm_memremap_pages+0x1e/0x60
   dev_dax_probe+0xce/0x2ec [device_dax]
   dax_bus_probe+0x6d/0xc9
   [... snip ...]
   </TASK>

It also fixes a crash in vmemmap_set_pmd() caused by accessing vmemmap
before sync_global_pgds() [1]:

  BUG: unable to handle page fault for address: ffffeb3ff1200000
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 0 P4D 0
  Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
  Tainted: [W]=WARN
  RIP: 0010:vmemmap_set_pmd+0xff/0x230
   <TASK>
   vmemmap_populate_hugepages+0x176/0x180
   vmemmap_populate+0x34/0x80
   __populate_section_memmap+0x41/0x90
   sparse_add_section+0x121/0x3e0
   __add_pages+0xba/0x150
   add_pages+0x1d/0x70
   memremap_pages+0x3dc/0x810
   devm_memremap_pages+0x1c/0x60
   xe_devm_add+0x8b/0x100 [xe]
   xe_tile_init_noalloc+0x6a/0x70 [xe]
   xe_device_probe+0x48c/0x740 [xe]
   [... snip ...]

Cc: stable@vger.kernel.org
Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
Closes: https://lore.kernel.org/linux-mm/20250311114420.240341-1-gwan-gyeong.mun@intel.com [1]
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 arch/x86/include/asm/pgtable_64_types.h | 3 +++
 arch/x86/mm/init_64.c                   | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 4604f924d8b8..7eb61ef6a185 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -36,6 +36,9 @@ static inline bool pgtable_l5_enabled(void)
 #define pgtable_l5_enabled() cpu_feature_enabled(X86_FEATURE_LA57)
 #endif /* USE_EARLY_PGTABLE_L5 */
 
+#define ARCH_PAGE_TABLE_SYNC_MASK \
+	(pgtable_l5_enabled() ? PGTBL_PGD_MODIFIED : PGTBL_P4D_MODIFIED)
+
 extern unsigned int pgdir_shift;
 extern unsigned int ptrs_per_p4d;
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index fdb6cab524f0..3800479022e4 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -223,6 +223,11 @@ static void sync_global_pgds(unsigned long start, unsigned long end)
 		sync_global_pgds_l4(start, end);
 }
 
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
+{
+	sync_global_pgds(start, end);
+}
+
 /*
  * NOTE: This function is marked __ref because it calls __init function
  * (alloc_bootmem_pages). It's safe to do it ONLY when after_bootmem == 0.
-- 
2.43.0


