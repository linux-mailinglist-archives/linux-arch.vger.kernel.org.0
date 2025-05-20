Return-Path: <linux-arch+bounces-12035-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 981C0ABE390
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 21:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282471BA4D78
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 19:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B54281362;
	Tue, 20 May 2025 19:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LR3e6LfK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sXMe5G68"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455EB280CFB;
	Tue, 20 May 2025 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747768920; cv=fail; b=T0uX0ot5Ci6AipN6AoZOp0LNiPXBYRJ7EN2RLIvsQWvUM3V0BrOXIhWTK5sPYDUewcfYy7WoByKbTVZZ+0YlBy7/HcYJNZywnCSuGGqxNdDEm22VVtwCvO/k/zKF6VmariEZBG8v4NLMeoBRgwc68o3Dx3AtqGq7dkrU65s8Uio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747768920; c=relaxed/simple;
	bh=0Hru64PGW9feQu8YWRiKj9Rtlrv3kTm+gZ5G6COzpGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=masz7mmxBjA6AybZWGLrPRsYzPZoS47PfwxFDRUQf5K2a87sfSZ4Cy0sXHOIMmm/+YMwifv4UGwd+NIL8leaDqPBz8NyMOJkJoL2ocPQdUpYp4s37AELQouXmFayGjooK2MgcWhuERfE3EZAOVzfPAXmIG6mcVdwIHRCyAliIaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LR3e6LfK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sXMe5G68; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KJJReT021788;
	Tue, 20 May 2025 19:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=obqntZdGrPeXJCfZZ4
	lOZIfkB/RKVTwLDBLJKwWd9qw=; b=LR3e6LfKa7d1i/sD8e3n8F4n8ap1fh0v8T
	y426IaXX4XvSKWIJkRQvbKWBoJtOGx8yoRq4VT55R1yX+4e1lDSvzi5jPkraASFH
	AbsUmRrc4y9SuhC0gVKBZN4Fbx7S1NXQQvcV1Cm4H6PUCeVdEixKmubt3BO9PAOg
	Q5srujchnd9ovClwqxj8I3qJm/on2QdDePJ09pDNjmp5TpZTmU5hAKhq+c4pFoqP
	8dT0bX+K2ClIyRFHeYmOyEeIzWP84hkZeYNOYP4qGE7IsBMWA1jfot1wVRK6KHSA
	9QHme8vRapR5eL9GMDlxw2bl1s5FzOl+27VVRISnfCzyk/3QmNpA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rykyr171-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 19:21:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KI5URo032944;
	Tue, 20 May 2025 19:21:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwemeru4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 19:21:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBVJldVEXdwRw9bACahwuExQl2qa+ka5ufhuQq9hQ76up866ID5Qti5QXqzhLKQhf8WJcIJlhSzuMBQN0N8Q1yE46TDNAcM2tugqujvPKEfBxxy33NaMTxFReJDrVCDQ+JHCrtzHkyzwudE690DuYJ6J6s8nrmpHsulkKds/mphe2xPH9yRt5SeE+rapOnPPmLfoOAzLXdNQpRcAry5saM5cCwQ86lMGxqcO4bHPfVdD1L515Ye7G6ax0Tr7ZOe01TAHr8vzoc5jBNAMyHzg+LdG/XRdd0fmXdTbVuMPX5MaBYlfWSWak3IcgvvSLkLmevL+FkRd3h0o10YB+gslSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obqntZdGrPeXJCfZZ4lOZIfkB/RKVTwLDBLJKwWd9qw=;
 b=Kyl2mT4QK1V7kjssExNrdFMxLyywQosSsmOzPW1NfKIWqgOQ8dxOPGnVNeh/njH9VGi4GhSnEiJrxBfV8tkGYWFKas54HzUt+OZMnhlR9V1QkuO7wW11iQF0OgtjLzcD1LtHHn4BWAbyuc6r6bc0K9q6dYXax2Sv2kKcWrNAdQUMxTkWxYpipHK9mh8yNs0B9Kqa9tThEqkhW8+TCeG+E+oPG9HODb5KuUBs5i4OUfB74QfxoyXcdR/hkiWTeQOEczhdw8sl35i3Ei8RAh6AG98hWyRqm8gpNieBTzcKZTchPxSIvgm/MW2dkBKNWnNBtSRHl2np0x0K+K0RKtjOWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obqntZdGrPeXJCfZZ4lOZIfkB/RKVTwLDBLJKwWd9qw=;
 b=sXMe5G68b/x1gy5ZXgKep7+8fRpwHrUF94CvsJKpbK7bG/ICp6wqmyzuVBAadlvGrokfuTel9ts6R+CtTbgD3qkBQ6JMd1XQRx1edu2c57Zuv66vGaYUhcX/yMFfDiaHQlte2s5mGdWUrYJ6OTQXV3D48+Oe4zK4ndofIwRB7Ck=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6039.namprd10.prod.outlook.com (2603:10b6:8:b7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Tue, 20 May 2025 19:21:24 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 19:21:24 +0000
Date: Tue, 20 May 2025 20:21:21 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <8417a42c-102c-4f35-8461-842343d7df23@lucifer.local>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <dd062c92-faa9-46a6-99a8-bcc46209e102@redhat.com>
 <c54d2c5b-e061-4e77-ac10-3c29d5ccf419@lucifer.local>
 <ae53fa82-d8de-4c02-95f7-7650a03ea8e7@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae53fa82-d8de-4c02-95f7-7650a03ea8e7@gmail.com>
X-ClientProxiedBy: LO4P123CA0044.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c371fd-fe77-431b-5bab-08dd97d38282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x9E9+d63ulYtbhyB0XWs8xrm0Vwpo81X5IHKs+jY6JPjdvU5/GbWjpoU5fcN?=
 =?us-ascii?Q?8J/7ORJukdqwieYGXzsuPdOwGp7moni+IG0V2ytPv3/jOm/c7LScTKDjIee/?=
 =?us-ascii?Q?qvWHcnruXzudU43kNYLjJI6Dte6SLuHIJDxrGScGUQc4uWZRH32uoCon/lqQ?=
 =?us-ascii?Q?lOAzsak+KuNAN+jgIE67pOPFBkM1el5TudPnkKSGEQt1UnznrRZsESGQnGZQ?=
 =?us-ascii?Q?FlKmx8P4ggOfefHE5oAGRGoWNHdqyzucwBSa5FTBWgzNipXTnCTFueezbFOa?=
 =?us-ascii?Q?5M2MfkccTUWou78pl77z3/tUcY0+/8Vg4CSwmKoPr63x5j83H4fuUTuZ7V6Y?=
 =?us-ascii?Q?Qzur+MNd4Z7TXgPHVb9s27iRIPXpkGALUT3MHltgBhn/KA6e5K8ip6iELIhr?=
 =?us-ascii?Q?8PdP0eD3Eq3DL7pLJkxQ8ND6Qfwr7nbs3fRhkVNnRJwyJoiCbRyHYZMA4tzA?=
 =?us-ascii?Q?9rT9lMcbuXzDCYv1+NiMmH8eXUcOWvedGSpBy4kMHH+h38QwHJgTiyEpIcOX?=
 =?us-ascii?Q?0ljNLz0GmYRSbTYKVDHx3P2BzxCUGP6kofMdNDFeiYBrKqSLHFAiF/JMUoNk?=
 =?us-ascii?Q?oFq5xqfceN/ZdcL7w40sknn5ttghoog4GUhhnb3x2Gyx8FiAUhvg6++6idJ9?=
 =?us-ascii?Q?Lewz6NsBq4WgeimQu173W0/4GZ9frnit7Q2awcYk568zgwxUaTy0p5Wb0Rno?=
 =?us-ascii?Q?BC9E2uRGQg/fUwLjzuld0tUn8OCapHvrmUCc/QXyT4bYnumw30V2SDLYLpw2?=
 =?us-ascii?Q?DmOnX7aJKWo5q0Re6+kHIJT24i1G3WGbB1hb8WnLjUSO3YQ73DsEFUdQlDq6?=
 =?us-ascii?Q?TNu85m3TWE28Y0Ch389wUENCr+jmiBwGabuDpWT/AEC6rV1+KEh5Nq8VyZS7?=
 =?us-ascii?Q?2L/KDcDP184AX0HuuVnlJo+uluik4oSdjb88VJx0wzllXotHVSXSPy0BxZDW?=
 =?us-ascii?Q?jjQyD9E9EbDK4ij6UlQGZOjeaF/wb74WELAkClwx31nyT4gWuhgw0eTAa2Rp?=
 =?us-ascii?Q?vfX7GGpRYBvtYaDc/NY5T5Yd4D/I3x650zqiZguwrYC/2BHYjxY66JotdRed?=
 =?us-ascii?Q?3z7UmD86sK4yyijtemom9lWbARxvhDDUI5Jlle8o60nuoBnFO25WQs+ciUxZ?=
 =?us-ascii?Q?oH7Q/hI5LDCbiY9yhEpY8GSRu5qGq5ZhER+5DVPQQyCiVZ6enJ4aXNTzd78L?=
 =?us-ascii?Q?Wp07Yt1khoiqGSgUtQn6uWjt9gBiW+oHkwU7oE84Rt3CRJ9SqiPW+2qxfKfX?=
 =?us-ascii?Q?avxntX4IxoNN4642p5XkCHGL0YtLHeNaLgY0GNCDx0a4xKEhCCdnFcI05Oes?=
 =?us-ascii?Q?jPrPz3KaM5mowgpc5aL0Qe9dtFKzYJcTio7B9lIOZj8d6f52oNJSXFILlbZm?=
 =?us-ascii?Q?IG/r52Viz9ZiuMjuEzo3KZ7Aic4+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lXsvzWyXJK2L93rvLM90nZ9ZHx7V3HHgpaa28Xnt3qnHfhEF0XuZjoDGy/NU?=
 =?us-ascii?Q?x+o84nCy9xZ2Xh1w6RwDLdhQRqL76qyE2+/bLIbGwbKIhq9Kllwc+H7ZR/nG?=
 =?us-ascii?Q?w7MjHL69FGr4YhX9ErpsAsowm8DsYX6GhkQcMpt7y/xshEJhQkzj8B2i3MT9?=
 =?us-ascii?Q?p4mbqnp7zIvcyDjuwePphf70RsYhrLip5wQXkUz2bZZ9XOk/Vk5coMc9dhb/?=
 =?us-ascii?Q?VywAGYMElxjHFdXfR4c00LS9yXKK7fYRqIl54/aiPv8PQ4V9p2+VUHbZMCoH?=
 =?us-ascii?Q?9Cnr5tzvQLoTXHtiJLD9CfpnWhmD7gW4DTnfyl/fWWXn4/mCfRZTqK1lyueG?=
 =?us-ascii?Q?FSgYhPlWayzjGdX/YO0XEoXm8fB6ZXhc2urren22pey+DrqvYwhwZXM/ercw?=
 =?us-ascii?Q?LqF3KGBIZaz73VLs54V2BbQet625PcqBh0esRfE26o2cFD/eIR4sVk5piMBq?=
 =?us-ascii?Q?hLc59RwDK1gn0CNxZfwbtQIOnhpSz9j7vtqS4rU/vCg9kb+k61T4GGuYAZ6Y?=
 =?us-ascii?Q?fhhWX/dVT6XovReMlriUIf+nS5aUbTlrxAHQEn6glzpcm2QeYOil3oRMeA6O?=
 =?us-ascii?Q?GQjkk/i2dEUHE2TrDyeIXxdHG5Kkx/dhRp8QF+ziGtFstGtJAnGM4r5u17sb?=
 =?us-ascii?Q?OxOxlEScBiXXJvNKI1s5MO+/Z2XmgB0T7ZO/RrkZQ+ic9R8VQyydBRabVUt8?=
 =?us-ascii?Q?h6AQXgVNw2T5idXlY+SFXTyHP9MFOPZPqKGzQpc9pLaMDf5WQAuoRcE+jd3A?=
 =?us-ascii?Q?sUAI6AlOrO6d8RAmJC2Yi0zVUi7i3PP0Ki1VTsVVDcTosbG6VZMqZzYEIR1y?=
 =?us-ascii?Q?aLArszmBUOMqpDAyqBJ5VtKl8vHl1T9mB96D8ct7LJtPeD71um01c3dwuP3+?=
 =?us-ascii?Q?5SHO/sEbNWqUsDCTGpT7crrhSnFBLD8UMA8sJyl2Pbw0MzWIfdhz04zBw7PP?=
 =?us-ascii?Q?vuGYiFQg/Z3+LorhnEnTV9053e0pYT3Hhp3YI9JxrxTy6n2I+uxDWJ4u3uKg?=
 =?us-ascii?Q?hZAbdnQAQmiSOuvU4AT8hDYXneMnn7OXbdSDv+31cuncHqOVgcqZ4iM/ek9d?=
 =?us-ascii?Q?stKQzyUC2ncjiCdUe2vxZ2ndk30In8uIjgUxMBEngmXb+ZdGSwqdu8gzzmy1?=
 =?us-ascii?Q?A4n/y2wUWUtENFweK/zxuCDwnzH7xrpWb1FUD3yw0AmykvTE67TvnS5krU+8?=
 =?us-ascii?Q?d2lD35SOcGBvE65Q9NLafx0dLSoIXhxJ4l/eJaWbpELvwrhn4onO6Hm8NQjD?=
 =?us-ascii?Q?Jiv+ddevjhNbIVN/WmWPoog82co14hPwlxEzwxmBUDtXaN1MpTR/nb8+yc3h?=
 =?us-ascii?Q?DalNvtruruwIYrxYFFEDldWZo92rKzZZBLjU3W+vrZj5teVCcP19CST3O0u7?=
 =?us-ascii?Q?+k04XE8w7FZJzAp8Fk1u743IYTyE1GCsV7/M3pWwVFgbCZWpe3yQbS/IsgnY?=
 =?us-ascii?Q?DskVyPZZWst3u97NSpnrNHwNe0tsiEX2uHGk3w+pX6o5Eh8UchwupVeJzCNb?=
 =?us-ascii?Q?3gQj2FjInvCwoFxGqqVPlNbCFjXI1lCcZKZIz8KsuArShQKdHxFmF3K2imyz?=
 =?us-ascii?Q?Gfet0h44MWldHFqPAp0kICuojuh8e7IaSnDb4NaxIEnpf5PCiUfX7SMGXOgH?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0JRRpZWatFe1Nr0MJOpb65G+1jkozSKlAEKmbVnczLAWBfWznJVIqx2QYIsUyiSc2Ccjw92zynu6uXmLLTkrvjuWWYsYUcg6UKt1j/TekGPfSWA/ds4wuI9kNbc24cDG0eNfMta8BeoCy5CxNJVk59ih1dE5n9PVPzqQVrsU1FvuDbfMLcBQt70jicjG+wlyggxM5y/H8x9I5MrVCDufOTgKZqU8sPdZKVcavkzMHlR2nS0T4Xm+0t1mcTHosSIDlV3cfoMrqDvPCNKNammBWzNbxMHZJGWiABb33yTxm4ONnMeEe1W/aJ5jtXpeuZH5PpFkhqO6LJrVKg4g/n47v+3RNbk4n8aMTdfcYLvVIoko3y429nL9qkWpnrFQxe1ia2Q7MXtm2w0DVMuc4zVBI5gWLNhjJ5c3IqdSLWmbjX+y7DjUgQAzK7HpKdVFf/P+9AZxEV54ZYnRymWShMha215Ezq+Hr/OlMvYw56z/kylSgEQL8QQ4x5rXPrU5M8xxH1nD7eBIRJIqKEmCVHfKW7Eud6kpz5ADwMzuY6CtSR0ppyY8rQ3eUQ6ZM4o2NWiJ5HxvJkqfLfIF+dkEQt1IeT+a7f3xdvO5WRcxOe+U1DU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c371fd-fe77-431b-5bab-08dd97d38282
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 19:21:24.0901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x36YIWrQJw7BWLSBQ3sQ0ZmfWLpHkKlgunCICbT8EUP2dlAWSuuHoonfQ8ujkblTtb+FRCEM1xsVqhRFLZT4DAznay8I37akq58L5nPv2L0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_08,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505200158
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDE1OCBTYWx0ZWRfX+9Gz7o6xdL6G aeS8mB0M72L7lJeM1Ry2L9R4D+KRF5QSyAkybUI0l1++miF+C8Ii52kVgeeauqPpmeffbPa4QEA WHF9THFk/+w4v748tkd32fFg8oa/M1TKNqID52YP1Loan3V7jFV96Wj6keXHKoMPLdi8Y5OYZKk
 /hrYnDldyjDtELHCrhGLoGusNZ7qMSe21CQUXyj5mzUlTMO1ElL1Ro07hFjBv8KZ/5iftNrPa0j khmJw+0+J6QD+PFBb8gXDeonjXFZv7JbaP0O72obRKTLYho1Klj4zdjy1TSLrAanMOKi1TUzuFr rPDNXH0SnabUf8KkfoVYeypdtHC9e9jjcdVyqvr8qqDb6NOUkM0E0SP0ge7enEv1XhCS6JqE4/e
 XVPMLk6927IPwgBYDYbFxSj8hKivpmZB7BqoR3b28zMmB2nTQ3SWRad/UDC+XpFybwrkJc1m
X-Proofpoint-GUID: -c7J3yGlSnTXOdg6fFskpRyAvCPTEYvp
X-Proofpoint-ORIG-GUID: -c7J3yGlSnTXOdg6fFskpRyAvCPTEYvp
X-Authority-Analysis: v=2.4 cv=DesXqutW c=1 sm=1 tr=0 ts=682cd637 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=DxAtKQwOWOs-ifPvyiAA:9 a=CjuIK1q_8ugA:10

On Tue, May 20, 2025 at 07:24:04PM +0100, Usama Arif wrote:
>
>
> On 20/05/2025 18:47, Lorenzo Stoakes wrote:
> > On Tue, May 20, 2025 at 05:28:35PM +0200, David Hildenbrand wrote:
> >> On 19.05.25 22:52, Lorenzo Stoakes wrote:
> >>> REVIEWERS NOTES:
> >>> ================
> >>>
> >>> This is a VERY EARLY version of the idea, it's relatively untested, and I'm
> >>> 'putting it out there' for feedback. Any serious version of this will add a
> >>> bunch of self-tests to assert correct behaviour and I will more carefully
> >>> confirm everything's working.
> >>>
> >>> This is based on discussion arising from Usama's series [0], SJ's input on
> >>> the thread around process_madvise() behaviour [1] (and a subsequent
> >>> response by me [2]) and prior discussion about a new madvise() interface
> >>> [3].
> >>>
> >>> [0]: https://lore.kernel.org/linux-mm/20250515133519.2779639-1-usamaarif642@gmail.com/
> >>> [1]: https://lore.kernel.org/linux-mm/20250517162048.36347-1-sj@kernel.org/
> >>> [2]: https://lore.kernel.org/linux-mm/e3ba284c-3cb1-42c1-a0ba-9c59374d0541@lucifer.local/
> >>> [3]: https://lore.kernel.org/linux-mm/c390dd7e-0770-4d29-bb0e-f410ff6678e3@lucifer.local/
> >>>
> >>> ================
> >>>
> >>> Currently, we are rather restricted in how madvise() operations
> >>> proceed. While effort has been put in to expanding what process_madvise()
> >>> can do (that is - unrestricted application of advice to the local process
> >>> alongside recent improvements on the efficiency of TLB operations over
> >>> these batvches), we are still constrained by existing madvise() limitations
> >>> and default behaviours.
> >>>
> >>> This series makes use of the currently unused flags field in
> >>> process_madvise() to provide more flexiblity.
> >>>
> >>
> >> In general, sounds like an interesting approach.
> >
> > Thanks!
> >
> > If you agree this is workable, then I'll go ahead and put some more effort
> > into writing tests etc. on the next respin.
> >
>
> So the prctl and process_madvise patches both are trying to accomplish a
> similar end goal.
>
> Would it make sense to discuss what would be the best way forward before we
> continue developing the solutions? If we are not at that stage and a clear
> picture has not formed yet, happy to continue refining the solutions.
> But just thought I would check.

As stated in the thread (I went out of my way to link everything above),
and stated with you cc'd in every discussion (I think!), this idea arose as
a concept that came out of my brainstorming whether we could better align
this concept with madvise().

This arose because of discussions had in-thread where we agreed it made
most sense to have this feature in effect perform a 'default madvise()'.

At this point, we are essentially _duplicating what madvise does_ in the
prctl() with your approach, only now all of the code that does that is
bitrotting in kernel/sys.c.

This approach was an attempt to avoid that.

It started as a 'crazy idea' I was throwing out there, as an RFC. The idea
was we could compare and contrast with the prctl() RFC.

Obviously this is gaining some traction now as a concept and your respin
was a little rushed out so needs rework.

So, apologies if it seems this is an attempt to supercede your series or
such, it truly wasn't intended that way, rather I have been working 12 hour
days trying to find the best way possible to _make what you want happen_
while also doing what's best for mm and madvise (among many other tasks of
course :)

So the idea is we can:

a. solve long-standing problems with madvise() that prevent it being used
   for certain things (e.g. the error on gaps which breaks
   process_madvise() and hides real errors)

b. Also provide this functionality in a way that the absolute most minimal
   delta from existing logic...

c. ...While keeping all this logic in mm and avoiding bitrot in
   kernel/sys.c.

So obviously my view is that this approach is superior to the prctl() one.

However the intent was that you would probably take a little longer in
spinning up an RFC, and then we could compare the two approaches, if people
didn't reject my 'crazy idea' :)

Obviously you respan your (kinda ;) RFC way quicker than expected, and then
there were a ton of bugs, which added workload and made it perhaps a little
more pressing as to deciding which should be pursued.

I would suggest holding off on your series until we see whether this one
works on this basis. But obviously this is simply my point of view.

To be clear however, this was not a planned series of events...

I mean equally, we are seeing several other series from Yafang, Nico and
Dev in relation to [m]THP and even a obliquely-related series from Barry,
so it seems we are in contention across many planes here :)

>
> I feel like changing process_madvise which was designed to work on an array
> of iovec structures to have flags to skip errors and ignore the iovec
> makes it function similar to a prctl call is not the right approach.
> IMHO, prctl is a more direct solution to this.

I don't know what you mean by 'function similar to a prctl call', or what
you mean by it being a more direct solution.

The problem with prctl() is there is no pattern, it's a dumping ground for
arbitrary stuff and a prime place for bitrot. It also means we give up
maintainership of mm-specific code.

It encourages misalignment with other interfaces and APIs.

What is being discussed here is an effort to _better align what you want
with an existing interface_ - if we treat this as a 'default madvise()'
plus having additional madvise functionality (apply to all, ignoring errors
e.g.) - and put all this code _alongside existing madvise code_ - this
makes this vastly more maintainable, futureproof and robust.

And keep in mind the proposed flags are _flags_ not default behaviours,
ones which we will carefully restrict to known flags, starting with the
flags you guys need.

>
> I know that Lonenzo doesn't like prctl and wants to unify this in process_madvise.
> But if in the end, we want to have a THP auto way which is truly transparent,
> would it not be better to just have this as prctl and not change the madvise
> structure? Maybe in a few years we wont need any of this, and it will be lost
> in prctl and madvise wouldn't have changed for this?

This really sounds a lot like your colleague Shakeel's objection, so I
don't want to duplicate my response too much, but as I said to him, at this
stage we would set THP mode to 'auto', but still have to support
MADV_[NO]HUGEPAGE.

We may then wish to set these as no-ops in auto mode right? But they'd
still have to exist for uAPI reasons.

So would it be better to do this in mm/madvise.c alongside literally all
other madvise() code and the existing handling for MADV_[NO]HUGEPAGE, or
would it be better to throw it in kernel/sys.c and hope people remember to
update it?

I think it's pretty clear what the answer to that is.

>
> Again, this is just to have a discussion (and not an aggressive argument :)),
> and would love to get feedback from everyone in the community.
> If its too early to have this discussion, its completely fine and we can
> still keep developing the RFCs :)

I try hard never to be aggressive, I am firm when I feel it is appropriate
to be so (it's important to push back when necessarily I feel), but I
always try to maintain civility as well as I can.

Of course I am imperfect, so apologies if it comes across any other way, I
really do try very hard to maintain a high standard of professionalism
on-list.

Again as I said, I really did not intend to supercede or interfere with
your series, this was just unfortunate timing and throwing out ideas to
reach the best solution.

My objection to prctl() is due to bit-rot, mm code in inappropriate places,
the fact it by nature lends itself to violating conventions and practices
that exist in other mm APIs, not some subjective sense of evil.

It is historically a place where 'things that people don't really care
about but don't quite want to NACK' go also, and to me suggests that the
problem hasn't necessarily been thought through to see how it might be
implemented by extending existing APIs or finding ways to achieve the same
thing that better align with existing intefaces.

To be clear - this concept is _all_ ultimately a product of your series and
your ideas leading the discussion within the community to this point where
a potential alternative has arisen - without which this would not have
occurred.

So the idea here is to simply explore what the best solution is that aligns
with what best serves the community.

>
> Thanks!
> Usama

Thanks, Lorenzo

