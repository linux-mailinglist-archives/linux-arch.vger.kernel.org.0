Return-Path: <linux-arch+bounces-8258-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A25E9A2EF8
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 22:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961F51C21EE9
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 20:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F3F2296E0;
	Thu, 17 Oct 2024 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TNfhDw5c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kzExMkDu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B01229134;
	Thu, 17 Oct 2024 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729197814; cv=fail; b=EGrYLFhgdxGvQqgGjD0oTge6tWavxDDDDYqCNKeqT4rea4pQBQgWxYgaXS5HFwDjH5MO4GccMAfo38XmbqcvNOW6W+kq13dt7SpKVHLfXfwOdQmMtPJYi4jTqOvSsOXgwIFnMdVwmOuW6Qxb3jAoUtLWDMSD4cTV3gmaUCpUPwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729197814; c=relaxed/simple;
	bh=weJnfCo8iCo0onxne+DIwlybazXwHadMOFndAz3D9YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kuSNrWtA6c2YaapoozKBhR4kIf5BILpKXIYjIfiP18v5vk8xHApQ+yyVHqJih2x3/jyqwPr+4HbtR/9awTKibecdY60KvQZoQ+EGiF/ls6v/dBhluehoUAHOyEKGU+I4xQDuN2YtqPFPfOCYvXh1x/JgGoerpYkGI+LN+YUlUII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TNfhDw5c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kzExMkDu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBems000334;
	Thu, 17 Oct 2024 20:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5MFnXUdslOqsT6J/eW5S/+20CDpOLupPW1WBkk3fQsA=; b=
	TNfhDw5cHMWroI1NEZSqe24Rb+N7pcAwxDBrd10Ys7LMV934viVlH7PVByvwxWRu
	BX5B+DKCTwY9PAyJPUqPQtKATXU7+bwdPNABYPyTiTK2QAn3BpIgZvFtGLw/2SLB
	DCnvUYqffZBF3q5QPjvWu8jowop9Hc08BzvjMmWRV7yAr8mAySf0/ZhhC8IDL+gV
	Mk2q4nMDuFZTVMWuBys0BtvrFiLUOoMoEnDMwwZvRPu0XvP6eiP5+NjqjCOiVYFu
	Je76HbaQ4BNtfKdGvWNOPPkRycUaWWxERkBLIj7pH1qOt7/UEhdaHCFh9OX7uXse
	TUY6q3yBqlVJ8HSfKQP/OQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09ptq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 20:42:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HJNIiF013980;
	Thu, 17 Oct 2024 20:42:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjarenb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 20:42:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2bXZKytxnfXrluUFupx8e3HwlZ10KzhSSqjU5X1kjyFQISKyxYaJ+qnJOoXIHP962TQqPFixvTfsbGItQJ5WxjR62otbv0+5X8qgz3iaGZR0ukhEhf80iC4moNJFcQ2BW3E3eNz5tRfG6+K2GcBgO+H1jwKG5Zzq+JL5qf78zw7QUMnMPaUR/EuSrIosukXWgp1+uqG/rputxHpfdneo2YVnkh42V8g447Iazq/gLLYOcd7R3EEEY9AHhrPkwkrB6GypwCbsvqdYGPJb4BMT/Rddvm2shSu7Ilo0XNsaepCJCE7/5INmh5syG6QUGscYTg0JSnxPkY+yIEYEtWz1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MFnXUdslOqsT6J/eW5S/+20CDpOLupPW1WBkk3fQsA=;
 b=TRVokPCeZ6Y2uiCRlqPb+YAyH8F+sGQz2VnxS7GX6q/jMlLTDvsiHmPUwpXXyxk1eKYnOaWJykHcmyBsFX3VduigzTJndQ9aKr8EtTu7LNLA/DVXnz1PJ6A/1Dg0PhIKWtAKVx2d0o4ToAjiQwQAuTJIIghR1GvFpm1KNvyAM+wl8kh2ksaLHESL8PKSnK3ifz1tgVuLVi8aiku1bQuNrZHdB7wQ355L2p62xlNHAIou8HJu2TDEqaEg88rud9FjkvhNB8H8a4jBWpBjvO6Cd65i4yotI3Q9ttncoReH6yic8eOL9NJAyBZJOBVFwl2RA0X05zgqHhCafaZECtpnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MFnXUdslOqsT6J/eW5S/+20CDpOLupPW1WBkk3fQsA=;
 b=kzExMkDuoRD8CmKAXj2dX2Pg8cE9HVJayAbJxt6lPLyFOjOTO4xsbF2qZJt9p98dKDDX1jFbbRopUTQa1Np5gtY7YznNIV2RxLNQAuJjvdmRMLK+cdGi21egtQb1ookbvPXSGahlyd0q0Ch6U5Fw6X51Dw0PyRXhAjNvboerF3Y=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB5974.namprd10.prod.outlook.com (2603:10b6:8:9e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 20:42:49 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 20:42:48 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 2/4] mm: add PTE_MARKER_GUARD PTE marker
Date: Thu, 17 Oct 2024 21:42:36 +0100
Message-ID: <4dcba8f8e3b6624c45eedc96345395002b052126.1729196871.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729196871.git.lorenzo.stoakes@oracle.com>
References: <cover.1729196871.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0424.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::28) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e92e92c-56cf-4de2-1032-08dceeec432f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2z4ynNtYO50I4pb5/7AUa9GP0zEXrlNhCrOe1mA/8lu9ih6Uu1vW+faL0E5V?=
 =?us-ascii?Q?QWJeZuHmRmkvo5/BeVMFI0kG8z+QpCNeNBJYNLmxkhXliz0pTapywJjSUGGm?=
 =?us-ascii?Q?bekoN1/FO0YaMsgWV0i49HsT9uIMRg04hpRAgjU8TczBffWPqrWA17aZxQB5?=
 =?us-ascii?Q?E1YbPWJnPTaoxaLos8AETAnIUB/iBqbOo2ltuzXq6+n+3L3pQ+lJX1T847kd?=
 =?us-ascii?Q?FNXFb9yXBOcncTc8G7KIDNry3caETRAqfqitnQIsOqmkbxmFKpF7U3d47TVf?=
 =?us-ascii?Q?RKuiWMuFZSGLDZ4nr3oBhfic5LA7wjHSEPrgxA9Nk4t4co+zDY0Oi1oKOu5Z?=
 =?us-ascii?Q?Z3gy+XsaORrkohOVhj5Rvf/G/C4JNp1nOktYretwLS4/7X49VsrEFF3mREI1?=
 =?us-ascii?Q?JL82J2pLTwnaMCWpkTB/FWa42IHckcujiWS8bakTTi0uEviLDahCp1J9ysP0?=
 =?us-ascii?Q?jdZjXTvlaQIjEUQhH1KLiR68W+AeBo1kfIkaA8iCHck382zyg/JX9wpwDR8f?=
 =?us-ascii?Q?ToGNyv2gK+6sEz3BOC0alsWZSwFs1/msDjW8z/MOcCJgteLKUjXzaDNAXE79?=
 =?us-ascii?Q?0yHPMx5Rlm7JdAfWIxTm8+9QKO5iNSQCDv6FcuV++FL4br1vhdMMUHS9kSXG?=
 =?us-ascii?Q?mvROVx7+/AzksGNtHtjz9cGAj9LNy/E7dXFuM4NAaHhZbCcNMtVoADkgvSwW?=
 =?us-ascii?Q?SKA+CqXqHvmHDKhMgOm/XZYgAgP3HDLtxY75zRs1BQiwzHMGKzDN9WWrVc//?=
 =?us-ascii?Q?efGioxOidaG7k7cGVjGaPkFJp9bQPOYi4pm0LA+CfAs03jTTPj6icV4xXqDL?=
 =?us-ascii?Q?3UK9e8PWmJB9BfNr+OUGMK+COxi0ukei1BsPLE4k632y2ZgXCUFhWLXlmPFW?=
 =?us-ascii?Q?aOCDUggWftiSj5oRuGH1UGujfetBNdv5RpFqm6MRptwJmbHo5AeEtFByQgKj?=
 =?us-ascii?Q?t7eo5meO8iouThF5nolKgPBMnYmvI/lUJk+IXV2weB6wwC78galBPkEHLYcz?=
 =?us-ascii?Q?v/A1NgeJduWbz8pB8QduG+pYP1CPtx9Ldd9HaDa8X5W9VEQzxruAWZHghoSJ?=
 =?us-ascii?Q?YesLAXXuEs5J8stvE7FvBnfu8dAp+rEwVdR2rG6EmRZKgGsiSylkP0cHzT7T?=
 =?us-ascii?Q?8SLlEEZNdIqp0VSpPPv1J3IdnSnXAaY18fx1oVOjDQXmNYVzk/pzFTBMpF2Z?=
 =?us-ascii?Q?vCBA2+cDH9JcE6d612J/TcR7yXf4gm12/lwrFogTH2MhUrP8XS52JtNfz0Kj?=
 =?us-ascii?Q?AHJ7prQEivyOGbGw+cf4HjL131hk5UPG/FwalTnWx9iBrtQBL3uXWAyHtm/b?=
 =?us-ascii?Q?YnA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R6i2khowzCHSfqb+tBqqVLvGlAdu0wceJOwRFrytQGhyxPgtXmxWVs9r31Ob?=
 =?us-ascii?Q?Ht7EoLdvS/vY9d4+Ixeueikt2b8J6qXbvqjiC7K3riJbDOY1s7VGON8PvA2T?=
 =?us-ascii?Q?pINL97+kmsfvSziyB97/mVvR6zjozkAkm58JTfGlDX5g4otv9L5mzOqA5sbW?=
 =?us-ascii?Q?z5vFSiXQH/2ALuGDuJ6nhVbUF9ntO7N6kF+jd6dJSPBLqvyjoDy5qO3QmdmU?=
 =?us-ascii?Q?gLJq8PDonRRlLe/vUL09Iu4rrVeGsvvpw9DzP8PvGyPVbuL7oXMfMM8HYyev?=
 =?us-ascii?Q?mK7Cb3ecUp2O3Oh+Bx7sPpSvOSYyIer7no83izvi2B7/UvubZwuz2S+LHwZe?=
 =?us-ascii?Q?YgbCtLicVdtPpvsw2sk12RhSJe8ODRpyWNMCA86y3GCKmDHZqa0D9VEUJpiE?=
 =?us-ascii?Q?LsM1AjwhhxZ2OxmWGHvBvSjkIu1rBE9VW3u+WjZ3eGSkuA1EnZPjpYLKbFK5?=
 =?us-ascii?Q?oTghVxnXYB8DMrpjAdvsWkTt+fmoNoZJZXkP+DAm8HbSR4iF4WEm3sq456NG?=
 =?us-ascii?Q?o9lWt1J1a4DVxwA+27mG9x5MZvLnTKu4C6yXTbxxv6osvd5yx3KgIQigyVYq?=
 =?us-ascii?Q?v8Eiw2eWcHlUmTDk/5wPVstj9guCIEC2U0M9YWbHqe1am8hTihmE9oMHUXPN?=
 =?us-ascii?Q?94N851W6kNrFxXzi41myQopIasCZ4ooykzFQIih/xdZ8shPy204z8VQbNJQQ?=
 =?us-ascii?Q?XpHWgRY+7cPTHIvGJjX/5MWf2zGIRuSXd+Gug9tFO4OFz0Ez8Jx6SVarLsvl?=
 =?us-ascii?Q?9tvCbJhtO5cuYNaNPAhDqY8ZfaZ7grDiuzAZvyt4KQNDvH2ipZgYz8OPKgPn?=
 =?us-ascii?Q?3DKctgll147YeiLsw7GTNIY6e2C09dBGp0H/6HRv7WLeRfUGvN6xJ3CCuydy?=
 =?us-ascii?Q?cXI4uXN2zmeHtOOHEV5ZKV7uWEn+iS/IceGQf4Lm8mDi/9u9OZQq8aYXYolB?=
 =?us-ascii?Q?thr1c30Dl7V20Rfli68K76xn3sQGvMy3x+frF5maElRjcZINhxruRpG7xzTW?=
 =?us-ascii?Q?WkuwTdgTgmZTEu49o429h5EwZQJYPLAFYoICItZawocGbdzJxOe149WNUXAs?=
 =?us-ascii?Q?wumm5mq/1+quaazA2/BsYrMAEonkdL45SPsGLxzKjxgbRIDtr8SXJaECsGFf?=
 =?us-ascii?Q?bFCuscLE8d8WlA0mxYdxWRCn8eV9aqUllEtQrByILYKmXh984cnGQ2Nr16Yi?=
 =?us-ascii?Q?rpjutP3wdPA8zSCKYhr4Koxc2Dt18h8bGcemYQ4/apC8xGVrQZGz+rDjui3V?=
 =?us-ascii?Q?C5iyTDy03ApGlN/EIi4TRTC6hqihRFoXSxx3mVPNxvWOFeA8CSQ2oJEgJxU6?=
 =?us-ascii?Q?kZ3/dCjyh8Lxs6KYjtOyxTuzxA5gzUkEtC19QayY8gRe28rXT9x8nXYjXOw4?=
 =?us-ascii?Q?0kr2HZmRNmxEpFmETOP17kBlaXBmgifd1n+J1oGEYbkxU2cYvuKRDPDq38BP?=
 =?us-ascii?Q?iqm46lZzy3OvocwlgfmQ/q7Jc4R3jnlLvUkKYsZhG7QSDI/mRt4NYN5kv+rF?=
 =?us-ascii?Q?q1lMmSxeDUdwLrW5szjKXi9D9MK5Gk+Fu0pozYTx6XoFGaGskB81MmaqFw/C?=
 =?us-ascii?Q?T9FJ5ahXMUjerf6Tpxl/s0VEKP21vtK5ueeMv6NXOcqgPPaix6r7ZPifnJZE?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0DLXAEGk6vW+JzF6GXJCbzKEJVG32ekdGh4nyCHA2TDh1mdd7I8Y3kFX5qT28DP4iMDI+zV0WxCplhtePzjKK4KKgnIjiGZln2i45j4yriaWojbmzXdjyFOjAD/W6rFv87uNNt9Drz51mk7jFj0qn7DDr9InOMK9QDGtZf+jyxe3UHPtBzDorEVAzeejpI9xh337Ht16D9y8CS4VjxrDML7GgC5baq4q5c0VEXC8dCCTtKsCjp+Y9cOoGpNqADjljyaRVNfEd2cISCp81C07xoX07Zr6c5HrZba+fMLnaMlwFc4Msw7Qu7D0I6UXoaacAh3VkaGEeHVJkgtfsuY9VeIE7btyCzN7EqsChA8g6fP/GO0SwIN6aKrtMs7QrS/EVuGTPiN3AuYLNvARPw+1WCpL1LFpW8YL2II883u1C82bw6GySe1HHhXOimf9bBI/rNsP3iqHPbsAvOpmwo9pwued6/RNg8K5ScQZh0yZFMEn24keG14X5fFlLaA8PDyoYAk2ofVwiEAsQv7agzdk1LDhNDvK0uKj7GenTOgkpHEbe98pRLg4seNrzXthFSOn692QUzMkbLA1KyejBG7UWkX285dncFfl+xwI1b3vd+w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e92e92c-56cf-4de2-1032-08dceeec432f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 20:42:48.8848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGZoLiN38AfyZVTCXrOFoI+2nkjXh/CfnlG7LlNHXqM15YpqISWUw3lYCfYxdG0k18m/pm8fbKBr77mQ84OseJrbOhDxDBS89nG0rj27J4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_23,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170139
X-Proofpoint-GUID: YMsQOtJjLOBjYwyIJcXcyy4ZWW7gcLEO
X-Proofpoint-ORIG-GUID: YMsQOtJjLOBjYwyIJcXcyy4ZWW7gcLEO

Add a new PTE marker that results in any access causing the accessing
process to segfault.

This is preferable to PTE_MARKER_POISONED, which results in the same
handling as hardware poisoned memory, and is thus undesirable for cases
where we simply wish to 'soft' poison a range.

This is in preparation for implementing the ability to specify guard pages
at the page table level, i.e. ranges that, when accessed, should cause
process termination.

Additionally, rename zap_drop_file_uffd_wp() to zap_drop_markers() - the
function checks the ZAP_FLAG_DROP_MARKER flag so naming it for this single
purpose was simply incorrect.

We then reuse the same logic to determine whether a zap should clear a
guard entry - this should only be performed on teardown and never on
MADV_DONTNEED or the like.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm_inline.h |  2 +-
 include/linux/swapops.h   | 26 ++++++++++++++++++++++++--
 mm/hugetlb.c              |  3 +++
 mm/memory.c               | 18 +++++++++++++++---
 4 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 6f801c7b36e2..0d97a14bf051 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -531,7 +531,7 @@ static inline pte_marker copy_pte_marker(
 {
 	pte_marker srcm = pte_marker_get(entry);
 	/* Always copy error entries. */
-	pte_marker dstm = srcm & PTE_MARKER_POISONED;
+	pte_marker dstm = srcm & (PTE_MARKER_POISONED | PTE_MARKER_GUARD);
 
 	/* Only copy PTE markers if UFFD register matches. */
 	if ((srcm & PTE_MARKER_UFFD_WP) && userfaultfd_wp(dst_vma))
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index cb468e418ea1..4d0606df0791 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -426,9 +426,15 @@ typedef unsigned long pte_marker;
  * "Poisoned" here is meant in the very general sense of "future accesses are
  * invalid", instead of referring very specifically to hardware memory errors.
  * This marker is meant to represent any of various different causes of this.
+ *
+ * Note that, when encountered by the faulting logic, PTEs with this marker will
+ * result in VM_FAULT_HWPOISON and thus regardless trigger hardware memory error
+ * logic.
  */
 #define  PTE_MARKER_POISONED			BIT(1)
-#define  PTE_MARKER_MASK			(BIT(2) - 1)
+/* Indicates that, on fault, this PTE will case a SIGSEGV signal to be sent. */
+#define  PTE_MARKER_GUARD			BIT(2)
+#define  PTE_MARKER_MASK			(BIT(3) - 1)
 
 static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
 {
@@ -461,9 +467,25 @@ static inline swp_entry_t make_poisoned_swp_entry(void)
 }
 
 static inline int is_poisoned_swp_entry(swp_entry_t entry)
+{
+	/*
+	 * We treat guard pages as poisoned too as these have the same semantics
+	 * as poisoned ranges, only with different fault handling.
+	 */
+	return is_pte_marker_entry(entry) &&
+		(pte_marker_get(entry) &
+		 (PTE_MARKER_POISONED | PTE_MARKER_GUARD));
+}
+
+static inline swp_entry_t make_guard_swp_entry(void)
+{
+	return make_pte_marker_entry(PTE_MARKER_GUARD);
+}
+
+static inline int is_guard_swp_entry(swp_entry_t entry)
 {
 	return is_pte_marker_entry(entry) &&
-	    (pte_marker_get(entry) & PTE_MARKER_POISONED);
+		(pte_marker_get(entry) & PTE_MARKER_GUARD);
 }
 
 /*
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 906294ac85dc..50e3f6ed73ac 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6353,6 +6353,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 				ret = VM_FAULT_HWPOISON_LARGE |
 				      VM_FAULT_SET_HINDEX(hstate_index(h));
 				goto out_mutex;
+			} else if (marker & PTE_MARKER_GUARD) {
+				ret = VM_FAULT_SIGSEGV;
+				goto out_mutex;
 			}
 		}
 
diff --git a/mm/memory.c b/mm/memory.c
index 0f614523b9f4..551455cd453f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1455,7 +1455,7 @@ static inline bool should_zap_folio(struct zap_details *details,
 	return !folio_test_anon(folio);
 }
 
-static inline bool zap_drop_file_uffd_wp(struct zap_details *details)
+static inline bool zap_drop_markers(struct zap_details *details)
 {
 	if (!details)
 		return false;
@@ -1476,7 +1476,7 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 	if (vma_is_anonymous(vma))
 		return;
 
-	if (zap_drop_file_uffd_wp(details))
+	if (zap_drop_markers(details))
 		return;
 
 	for (;;) {
@@ -1671,7 +1671,15 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			 * drop the marker if explicitly requested.
 			 */
 			if (!vma_is_anonymous(vma) &&
-			    !zap_drop_file_uffd_wp(details))
+			    !zap_drop_markers(details))
+				continue;
+		} else if (is_guard_swp_entry(entry)) {
+			/*
+			 * Ordinary zapping should not remove guard PTE
+			 * markers. Only do so if we should remove PTE markers
+			 * in general.
+			 */
+			if (!zap_drop_markers(details))
 				continue;
 		} else if (is_hwpoison_entry(entry) ||
 			   is_poisoned_swp_entry(entry)) {
@@ -4003,6 +4011,10 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 	if (marker & PTE_MARKER_POISONED)
 		return VM_FAULT_HWPOISON;
 
+	/* Hitting a guard page is always a fatal condition. */
+	if (marker & PTE_MARKER_GUARD)
+		return VM_FAULT_SIGSEGV;
+
 	if (pte_marker_entry_uffd_wp(entry))
 		return pte_marker_handle_uffd_wp(vmf);
 
-- 
2.46.2


