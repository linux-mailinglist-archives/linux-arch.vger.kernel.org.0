Return-Path: <linux-arch+bounces-12733-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE6FB038CD
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 10:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1870189A486
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 08:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FB71F0994;
	Mon, 14 Jul 2025 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sHUEU4JI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jx2x1I1i"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7A92E370A;
	Mon, 14 Jul 2025 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480727; cv=fail; b=nXD8khPPsUixwgHIx1Kzd0ohcvRly0yJbFp4z9ysL+alv6h0l+lTef/6xPrl07a/gYagPYt6Fu4Z6030/DAr/izSDmXR7Za7g9GQmf3JAUZ471K8FUQ9aPJXDPN2KzsOZ70xNE5CWk2+xfDeb5WE8A/ElKUunAV5gCEjTKv/vyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480727; c=relaxed/simple;
	bh=BxnVd5C7EVU+7WiB9Azfc4C61hZYmibCOSk/EDh8AVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V7HZv5Ef1aPKyVAhMwU/9dVFkB24iPprhhLuZ5txOTc/ysHMt0VjWoQRcH0aVcyisBYgM7+QpDX52H2Aso1yBcy85tSYwzfyBgmHvZiBTNc0IM3nva7C7+SPKC891yW8g+wpMP5k1CnXo+sTb6a3gA8ioJ06nlP/7uGRkt3gWfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sHUEU4JI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jx2x1I1i; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E5ZULr005896;
	Mon, 14 Jul 2025 08:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=lVBWKQSjTjuLYef8ZG
	xwHPzeqEdGyf9L84FV0gDpujI=; b=sHUEU4JItEJjQ+z54hFK/D+f0x4FS4ODAW
	aG8tfzDGrG80qEN7SZ8y4J98/SMjtQ2D/lxNrIvuQr04Fq9sz6sLJN1xACgFyKhW
	2U+thh1G8vGi431ANSIv/oU2DcQuZ7KJ+Ucy5suTVSX5Q8ceVNeRBXgIoZeL5t64
	lD1KMivQQgBLv8eeaz3+pavkz8DnUbIekLpHL6v9WANZtfEM6WuRsn8jMNGBiCOo
	pfmGaln/QONVb80PJowiyMsnmh6jvp8+HdXNGQKFQ69heceFiLhw6Ow53yWTR9+Y
	4lKU8T8/6kr2B5I1xF8WP7nbYILyf7aD+uk3hjFaLvXZE71nRxPw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4kmm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 08:11:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56E5ucvl028968;
	Mon, 14 Jul 2025 08:10:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5814av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 08:10:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVHomVSxCLI8RZAhe5JxqsBJMYexGet+PfFginDvzvBjsKsQzfnxtmV/qkFQWDa11VExqKR0UHyNuy5vX3E5izIUAbH3DDKEBO8SBQDBKO2WGp/w1Sa+4ZYgMBCi40IWeIBJ+yCEMvz5YC3l/yzS0rmQU7o+yWN+UEM1iRE+uWi76kIwdF2EDhJYUwEEWqFi4FbkZn5lE4cZlIJ1bAghnA1uF6sgc85WozefSuEg0dLRlZ/EeD1D0FEIcEWxx9NxP9ktllDGd+lGA48YMeIgaqzf6vTe7ffJjqakBGj3pS1tiDX8dAeX2fqMclZGQK51qcC48cJYeyn2FIOfgQirxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVBWKQSjTjuLYef8ZGxwHPzeqEdGyf9L84FV0gDpujI=;
 b=to4ZtZDwh3qjgAo/TCYGrjLHFPlotgrfOF+G1JQFtEj7Y7687wcYbpdZ3X98+aSqtEF5P/SNUWR+pQf2Ug135fdnBo3Q5ERRLXlz7CzMTUAs3B9y08GK0CztvyaIxjOiVRDSMce//vHfrKDp6xalU0f35lR6BENglF/BnjRWBXzXNzkkYan4YdD8JmLImvHOJYrl40G1/taOoCteuS+74kgFgQJv4Dn6SRryNG0EufKp1MhGw2/FBH+5tJ0zZ59vWg6idoTRw+ObAoMnvSI5bqk/aHQQZ41KUxb394UjJ544At0PnEa1cmRQ9hcqkdl8W6wvBEJYRvj4OyCkIm7P2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVBWKQSjTjuLYef8ZGxwHPzeqEdGyf9L84FV0gDpujI=;
 b=jx2x1I1iFz3QTfKjlvLHkyC7GsjszVWOq5P6pM7XVWfbq/shoiNa3yKEmpbexJf7WBYfMuvcRrZxuZgJ1JtOd7BMtekGLWKice7VTY0virwH73E7r7SeofhqDGagnf7QEc+fViOmsmUZBT8Mbda5LiEfLFqGWu9IJjMCuhv/0+c=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV8PR10MB7847.namprd10.prod.outlook.com (2603:10b6:408:1ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 08:10:55 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 08:10:55 +0000
Date: Mon, 14 Jul 2025 17:10:44 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@gentwo.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Joao Martins <joao.m.martins@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [RFC V1 PATCH mm-hotfixes 1/3] mm: introduce and use
 {pgd,p4d}_populate_kernel()
Message-ID: <aHS7hK-BDC3miisN@hyeyoo>
References: <20250709131657.5660-1-harry.yoo@oracle.com>
 <20250709131657.5660-2-harry.yoo@oracle.com>
 <02146c79-a4de-430f-8357-0608e796fa60@redhat.com>
 <aHObCemGNrGakq_b@hyeyoo>
 <aHPzOrS7ZfO-3Wf6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHPzOrS7ZfO-3Wf6@kernel.org>
X-ClientProxiedBy: SE2P216CA0143.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c8::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV8PR10MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 86065618-8e1e-48d7-4694-08ddc2adf463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pA/r9gUAiY1OjHM0x6gpWLjV9DiAc9V6OF+XBP1D9nNft6sJ13+BinzxzTZi?=
 =?us-ascii?Q?hdlicT39gABn5ZvioIHhP80bwfo0CKvumtoHPCounv4WQBtxN77gQ9x4fQqi?=
 =?us-ascii?Q?IGrO/6gREc+8CH0P/+pWDTPoHSCSBnzGYKhTUn0TI78QYlBRftusxRvE0ONF?=
 =?us-ascii?Q?ZgLl6oAFtb7BOktBYNJuszyzYHxqflcsYaLagO1stbGywAzjL69rnO2qR/R/?=
 =?us-ascii?Q?Qm7jxsONrIscaDAKt0VGJT+obK9r1C4FCB3MfiT7BM9KcS8e3vSWCpE7MDY8?=
 =?us-ascii?Q?2RdUPjf7bYUYnlal5jaCAsM2Og2ZuqnRT+Wt8+d2YIBenQACZY+0DfSjhc9n?=
 =?us-ascii?Q?wW0T4JlPhDyE5XBtj4DwKBCd8oCCD1q2o30S7QK61hQGLzIZt6jLl1cGQW06?=
 =?us-ascii?Q?aWxFHisPd4VuIqZ0abZnvwFVL73fTU8Jw5qStcVJymGWwuPzSNF9a0QR2jzv?=
 =?us-ascii?Q?yLhcNcWd6Phm0wl7WGVg+MrPBwSkykHrDBxhHot+AI73AQP1AnhtX22fS9lt?=
 =?us-ascii?Q?Qd5l38ZYSNyK+VzpCtvRZOB2A04cXVF5KQr5xC+uvncX6XoAw6pXEpeqYH9h?=
 =?us-ascii?Q?/P8cNHEFLQqYOZ2s3J0DQaIgRW3F+OqHHrlcbZdvPlnG1SWoHtmZ0Mj6p5K+?=
 =?us-ascii?Q?DkROJvBs/Q949FLPL8N0GWcPlSgrLIX9a4J1JUBRTLMnsAjPt6pUlExgZvFA?=
 =?us-ascii?Q?QkwkB7PkZw6CMHTWH/7i6+r/W3yZxGZ/uGh0LPLe9FSoq4VteC/A3zdPJwTj?=
 =?us-ascii?Q?fjd2ykBYt3BlEEQe1+coaFukLUmOpiZi8DEYm+Md/oKodQiTKXKbcSZxz0R5?=
 =?us-ascii?Q?aSJsJMgF4VtpQG3AKzRYygB/ANphkpb7CXWosPZmHPeMO1zGXlCiNosMUYwN?=
 =?us-ascii?Q?aSZhTEMqiBmXPi7+wXC0gzBK2H24Pz3XgxEwekoFPCYfm3hNrnt9MTsnQz9G?=
 =?us-ascii?Q?YuNllT0FUUQwW3pVuGWr58Tg2KuiK1cm4n63XhmtHol4RKxkmaXgHUZ0x9dd?=
 =?us-ascii?Q?CaSGKkO+nBRpiVA8AyqHhCqfiw3OF9wvkKJXdW2ddUcOStmBvmL8h4r2hgkt?=
 =?us-ascii?Q?DyvNN2h/GStYuLxSdxFdt3QAE6lQUDr7DlWfx/2rQd9FZkfv8SusDC8nIUES?=
 =?us-ascii?Q?XZcLCJoJCjk96Ic6fmXOzCY0InzQGpQGVa+XyWbPBrh/ALIr3CcXvcrXf1F+?=
 =?us-ascii?Q?1PC4WhcrjvGuSSfRp+kuJVVI7SxmyPcuSCDS5PFK1VVTM2Dfl3IGTFQxX6eK?=
 =?us-ascii?Q?z1sXtnu929S7dXKFA8KdRK/XM3+CGxsCoYs2pIl6sjnuedvcLDzn5ewR06CR?=
 =?us-ascii?Q?9ZT3qkDebk99kcPHSBMz5BPQb4d9UZUZ2De9Fpu9+74Cz5cppenYyx5SBYY+?=
 =?us-ascii?Q?JCSefCQaUGw3BIzkNtUn5jJp7HkkkCPRxGWZpI6C6ZXe3jF1Pse0CfaCY0KS?=
 =?us-ascii?Q?RERM0zGfdMU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0pa/bulFE5lL/ZDEdqG/mStK7ny/EzgkiPg8X05R1M/W5++k2yOWJoisHS+E?=
 =?us-ascii?Q?T6I+CEKNYz2v6i+L+gUlmlW/1PJmNRG44ZYBBvOSsIfcDgsJrN+KgntVJHgs?=
 =?us-ascii?Q?9HpsQDKHVwwAlltC+DGQKp1Dy2TMAXp74G6KK4c2YIHpn531yDonmBLQHLtZ?=
 =?us-ascii?Q?A+aHagyzksh50D/zTAClepuG49n7PP5UnDHY7fsFJUewT66cdjsXZq35CwvO?=
 =?us-ascii?Q?C6qjwKfNxsW6f5Eb56lgKqgQuBltORLvJw/UVAthOM4Xa+Ltmh58bnA/SgzP?=
 =?us-ascii?Q?T8kQRh/eT3Fogdc2YJT3vZUY0E78jtYYwOOxTPfI9V6zOzaw7wK56rbBqFX4?=
 =?us-ascii?Q?HqdiLHw2ZO6MuaOBz3VnZX2gSITrLMmtFjBc3IL/394Mr7yVsydff9XQ3boA?=
 =?us-ascii?Q?VQ2vdYHxXsdLFrh3phB9lRuR1A4zXhWj4OnzFdQ5vVuLY8b3UIitQ2/1hTkP?=
 =?us-ascii?Q?fiR88VWkTJLfA94BJ+IRRCJfXuN/crQZ+1c29u1SACxiRMXQWm6EkZYjCicb?=
 =?us-ascii?Q?TySvGEYSrWlrERbzRSOBlLY1Lg7sW4tWQ8Wb+sXeFLOUxFIAMVNyK+YIhYEs?=
 =?us-ascii?Q?OTvakGsVTMrnKGYT04hqcNw4WSIKo2bc0BMiLRoYgZkLI9q/LFAt40WkZl/N?=
 =?us-ascii?Q?y/m31G12ssdwNT3gpTVgZB2OjvV4sAC8w9RlomZrfByP8MguAXvIttyaS847?=
 =?us-ascii?Q?1BiLMNF19LIVZhh01KBtIw5OZ3h4s9ZRMQVuqS2WFgb4Omhbk0rWxo3sDGiC?=
 =?us-ascii?Q?7VhHt+sIvSVxh2ZYLugUQrcGUcT/q4wJDlQNHQOJdieVpKwibP+hNM473kUA?=
 =?us-ascii?Q?PjHUC/KMIuSpw66j5IscdoOPUjH/Dni2H7AfzzGDU5zXodVp/hWxotJ2rjZV?=
 =?us-ascii?Q?tl5zRminQJKAIF6BzzPFl+ONOA9jECrRKMkqus6iE1BlkpWgvJb/dM6hZSL6?=
 =?us-ascii?Q?/wz3othGygSjnWhHl8xgs4BUlCab8RgDc0gOEjpY+wrp8FGDLyv/CQZfmXm2?=
 =?us-ascii?Q?48qW0Wp5bOiRain+Fv993kbxN51lrfCLv15uQuFNhf4jFWgEzPzqUq9S3Tha?=
 =?us-ascii?Q?PEdhwM1ruCYd83TuA7hbBr3LaB29sJPx2XtugNdu+W6rU4DerJIVs7T2du1f?=
 =?us-ascii?Q?U7x2nCs8fnmQEMsrgFrlWMoSOrKipow+UH56hUnqcfXT+3Vrh2kcjCxGP205?=
 =?us-ascii?Q?Yo+qC+0i046pbN+WphRpbBLIE+5sWSe5Fe/zwQhSJ45eQM4z4Kn9bP2ZMdMu?=
 =?us-ascii?Q?XT5o/mjBRPSTrRbBbxWUHhoUzs/W6vhkfAo4z8HUDif6JOfaXZPQ8lbzptM5?=
 =?us-ascii?Q?jimjoKn6ckwjB3kJS7/XXBaOF9iRdkmHB3+7GC5NMC8riOmR0MrJmDA3Lrgi?=
 =?us-ascii?Q?4XQYQ/Jn6G/TmKxgviTdb2c+Ubv9UyJZp8EotsPiPV9iVhst3cOgEnlerwUj?=
 =?us-ascii?Q?E/j7D4pmtqT4GRWQrL+iJWLHMcxsLc814BQhoVE15lkbIKgPj1GoeS/r5n5j?=
 =?us-ascii?Q?qnB2fh9n8T94GERZBfyWQhM2+NJuRDiAR9o4NzGe/W1eJ4xqjIbdYg5y5euK?=
 =?us-ascii?Q?T/oBr5uqrR2yAsjFzgD63DtJELUYJacPr7jiz2PK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	umP7K9QPTflntHz0B1aY4sNs0PV+bb6W0Hi1TP1zOosr0EA8kEXgGxkd4QBoYzXaOckgRDDkIy5J/JXQCKC8MPIE+26ejva394Zqzq9kRVPfG8hEfZk6G0I7I/H8AxqQAu/2n+m0KJEUMHfjfzDb6aeiUaknaJJQJgTqVccuWnC6MJVg4yOfUmDe7YMpKOhztmvODtWbFg1VgSrrSHzqYuBBssscB0rnJduVeCC6Aye9Y8ndwgnCUhHk2cInVpEalNku+daz8OUgaimnIunztOyLg0h3G8/TPmyXCBcMLa4eu+RgybT8x3L//cpUXTQ+DX1eVlBUvSskAMcDCMYcfgNkXrg6q8bRByi9okBY+VmScL4o/+iKP78VKrI3b/QNQmRO2MDEJohUFCYpE1fLdzCZdHwWCqOn7bLBKt7tbK4lvX2GzLFqOM9gPqdMGyh27zutu94zkf2/34AWxKdlqMwTvl2cqqqApGGzNDeHH583I2jXslTk0LfC4THsT+1kSQA6fqVmSdnkHz0M46IHa9UtwpMz+UJodcLJEKtnyQTDuqUmZkPqAPzSsCXURvrmZVMkXOnOrEvS6c+8P8jEz6Yi6H3BCkW3LEFI+1zY6jQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86065618-8e1e-48d7-4694-08ddc2adf463
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 08:10:54.7640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FUdkXdOttqxqOdV7GcPm4Wmz2tMqjrK6x5unE7Wdg/7xZpFdtV02gGtk/k6GZNRka47KwL0+A+fnn6zNWYDIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140047
X-Proofpoint-ORIG-GUID: 8BnbRrjyGxtmZlKTbIB9IRGKSYO677N7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA0NyBTYWx0ZWRfX7o8byMsD4q0x pox4iknzjHliljPpc136K/yb/PCje0vwmMdfvCPzdgxGmpDE52D2AqMjLYIV1EjgP5+rwxCuC9Y Z+5FpyxwsO6tv8UJD5Gc84W71PomqJnEBbTd/YM3TtWYZ4VZno8u71YUdC4L0m07afRmJRRTY44
 9yHoBo8eoq2BpQsfQS9cJyUy5Iznft5B+mz9RSqwg/zsgvN+Pt9j3NqwarFBHGjQg5tQqO9CITH adbGYdY6YtB2uBapsUeyscf/GFCk/utrs0+qx1X7ntxHxPoNSowlGZwiBbX3K7oJ24oMW+3bhQ1 ijZx3A8FAHJOMmKxb/r/wmgJs4m5Gj3gsXWp9lK0apysDqUI0FSQiquiQuD11ntrEV6fucfCpFO
 +MZMialM+5aABh/YVWg8HPo52VJh4CcuesYKKgLUrD+pI9MkracRVzPt/VZXuWz3jNidCEHN
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=6874bb94 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=8np6a-8WF4OtHRTcoGcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 8BnbRrjyGxtmZlKTbIB9IRGKSYO677N7

On Sun, Jul 13, 2025 at 08:56:10PM +0300, Mike Rapoport wrote:
> On Sun, Jul 13, 2025 at 08:39:53PM +0900, Harry Yoo wrote:
> > On Fri, Jul 11, 2025 at 06:18:44PM +0200, David Hildenbrand wrote:
> > > > population helpers that invoke architecture-specific hooks to properly
> > > > synchronize the page tables.
> > > 
> > > I was expecting to see the sync be done in common code -- such that it
> > > cannot be missed :)
> > 
> > You mean something like an arch-independent implementation of
> > sync_global_pgds()?
> >
> > That would be a "much more robust" approach ;)
> > 
> > To do that, the kernel would need to maintain a list of page tables that
> > have kernel portion mapped and perform the sync in the common code.
> > 
> > But determining which page tables to add to the list would be highly
> > architecture-specific. For example, I think some architectures use separate
> > page tables for kernel space, unlike x86 (e.g., arm64 TTBR1, SPARC) and
> > user page tables should not be affected.
> 
> sync_global_pgds() can be still implemented per architecture, but it can be
> called from the common code.

A good point, and that can be done!

Actually, that was the initial plan and I somehow thought that
you can't determine if the architecture is using 5-level or 4-level paging
and decide whether to call arch_sync_kernel_pagetables(). But looking at
how it's done in vmalloc, I think it can be done in a similar way.

> We already have something like that for vmalloc that calls
> arch_sync_kernel_mappings(). It's implemented only by x86-32 and arm, other
> architectures do not define it.

It is indeed a good example and was helpful.
Thank you for the comment, Mike!

> -- 
> Sincerely yours,
> Mike.

-- 
Cheers,
Harry / Hyeonggon

