Return-Path: <linux-arch+bounces-12062-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C661ABFCA3
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 20:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069E04E832D
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 18:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4638326462A;
	Wed, 21 May 2025 18:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DhKxj5RX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VDR4nCxd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C11A22F77A;
	Wed, 21 May 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747851095; cv=fail; b=tI6rJOgMe6Nte5azrrMQgw1yEVCdsnp7BBi0wbzf1SKSUAjJk0qEb2z3WljXdjhSYstQTed9swdt5oA4tQzX0mU194QS9RFPs5miECOAOFBF7ayi/NEsYlPa0TupNJL6vi5boMoPDQ+jr6jvOgIheaVjLIV5WAJoqY4bsWJdC+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747851095; c=relaxed/simple;
	bh=A2hWu5DJ7hURi5reu7k3S7aHOy8TaF8SVSmhEy7KU4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ixKzNDlxTrbX1PYKQN4sWbrByLMaRbuAFg6WOsgIJGiwfFyndSd0PZ3whye3ezQu1MZJ/6bzlVig2neWNR2u1dUZV4XhjLn+np9qaY45+QMZg5A6yMma0jtjNi3Z7c3gnRXniHcix/2W+jqF0Dra+ttBlbtfNZVwf5hirwB0+zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DhKxj5RX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VDR4nCxd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LI5Ihm005297;
	Wed, 21 May 2025 18:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=A2hWu5DJ7hURi5reu7
	k3S7aHOy8TaF8SVSmhEy7KU4Q=; b=DhKxj5RX/QrN4id8yj8zW/ylfuP1XmkKkg
	pxoeu4FhmMgRooA75HgGBtA6qLjee5KAdB+HlaR8qLS4jg6m0lR7Hi+5PJuCEB0j
	AnuTULeV0X+1/XNyOEI2fnDGq717igJETDF27hZBLUKvKM//sDBi3wR73Fn8PiQg
	WOoLy+AVQM+Br7n0Zi80+PNdApMC6DyFJOOr6CONTdxrnLlX4+Wjtgy4IOUb87Oy
	CI62T4cb9vle+5nL/DILuEzFeIYfm1DRPYrLXGsLb/ccODdOR29MiJx7ytoXu/XB
	7PVxYcicZqwZuBErr/3BhgbVJMmzcZ1BRvxtAdeC7wzW04GOizvA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46skm6g0kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 18:11:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LGw0tj020337;
	Wed, 21 May 2025 18:11:10 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rweu6y05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 18:11:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfyhgY5t42WoDE8P5T/1DMBB/WTaGQevKGiZBb3i5El6Bltdi0ftYOmtDMHBrcanBUntQrs+oM6afbSZkxOJ5SIKjzDzz/TB32FHiIlXPE81nuCkcapfghc7dLRHqkcVm+eLl6CQW/eyRYp/R4DbxoLXAszACLWMj5jG2fB84OVdebB5VZibTIaWlXETouePnHiJxSSt2PXjcVS6Sa1v5F0kXD3rCr2H8tkEvVcFIIntdub2ZCDieGxDD2eYJKmdUT5hcKGYmclB/vjcWoC2jP845VSn0q7CLUT0pvPHduVbZc509caUi1VUh+TVCWvTPnHLMCyNExXmTjjWPNM2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2hWu5DJ7hURi5reu7k3S7aHOy8TaF8SVSmhEy7KU4Q=;
 b=AXoxXpmkFQH4icsY7xJXUNvDskQgDkKOH1fz/w2aatOjsCQcTr+ADrNyywUPDpiAqsTCyXKBy82Dct3Ge0ZtqLirmJGb+B6M4AIuWklEtBYZqrPAz8Fzefl13GQsbwl/yHFDzlOOIFf4oTSp1bteny8hNxiQPSnfNXhDTdk8ZuvcUzbPWlMWMj26sBivs2q9AhFviRhDXaljBStrBzh6O4+mxc8Tkn9HfLOOK/4OHPwfPd6XAxX6cY0iMDQMv+c+lqZkU/+HPWnFxdts+JTPoZZXOAdDG5w3d/5vuVnq65SUNWOa0txJwBkjFmQI75q380Gfreaf7iQzJ9HH2XXb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2hWu5DJ7hURi5reu7k3S7aHOy8TaF8SVSmhEy7KU4Q=;
 b=VDR4nCxdv1tTtYTiqPt8JisX0t9XpL04GcRa76VgKSn7Jd/HTGDS98xPfVjTh11RHOxE8kVbfzYrIplic3g+cIbIjKZhkEe/6SufRUmOHNfm+Jhm8c1kPGImZiRPvedFeT9h7OiLb8KIqVOY1lLN+kjS7IW7SD7NxFy6TcVazcY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6681.namprd10.prod.outlook.com (2603:10b6:930:90::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 18:11:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 18:11:07 +0000
Date: Wed, 21 May 2025 19:11:03 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <c1320e28-62c4-4e80-96bf-25c890f32b21@lucifer.local>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
 <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
 <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
 <e8c459cb-c8b8-4c34-8f94-c8918bef582f@lucifer.local>
 <226owobtknee4iirb7sdm3hs26u4nvytdugxgxtz23kcrx6tzg@nryescaj266u>
 <7a214bee-d184-460f-88d6-2249b9d513ba@lucifer.local>
 <20250521173200.GA1065351@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521173200.GA1065351@cmpxchg.org>
X-ClientProxiedBy: LO4P123CA0123.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d70c09-ff25-44de-3a90-08dd9892db57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vubC+EUjqXto73v2uxXFVvb6OwhVAwINVn5GZJvRfOMxhdvHhFmG+FCrMzrk?=
 =?us-ascii?Q?AWwJwp0HAy0UnuU6ZATph9KZEoyLWtOoYj6CFkT+qUjpT7t8XT/8i/nww5E3?=
 =?us-ascii?Q?21Rgw7dyYDLRHr+ZNuH9EE/SUKfcEeZeuIfpyIsedNBvkcu/enpYyoVcrn7m?=
 =?us-ascii?Q?ynQwGsuezETX91Mv/mvlAciEnbuNeNnEJiX9pfdq782keNNGHZWB5O9bcrHo?=
 =?us-ascii?Q?Hb9jiWUfvJam33xPBRbE0O07bTaD7Py9ny3V2aW+qDxuCZ5z9tq7d4Rx7YCL?=
 =?us-ascii?Q?J4pbXOp7Yah7SkQg4bppZyPyYFxeMnsmGpLD+/KnymavXJv/TpYTAI/9Zw7I?=
 =?us-ascii?Q?NK9tEJMrsXhZHm1aR99PHKe2JO6FIBUrXyoBRnZINB4a5k7Lex1NCpjh+88F?=
 =?us-ascii?Q?MQ1b2JmwKkKuO7xPBHVXqdo06qHOLPRg+jYYTfPGtz6b1Yi9KoFtnyYfDO5a?=
 =?us-ascii?Q?fXnIdB9iOgtSSEz1IM3eNn2ZZ3zGueyC819zBr3VD+A1hfjvjhWeEhOzkzX/?=
 =?us-ascii?Q?nTl0bDJMeTK8ygwZqq1embY2XPdjUoRUdhX/AI883valHB+h2BtE/y4sagcW?=
 =?us-ascii?Q?rgMAJLkzybylPUMuFb52PvTHCx/d/ZNab8jAkNK1u/hfFP1RsaMrPMJn9mN5?=
 =?us-ascii?Q?iDFaMMcmX7gVPHwQ4JKjTbG1DPr1iA4mgL4BaoHQiDxJ2Xc5H4c17nyFCWSY?=
 =?us-ascii?Q?btBzWz+8WL7BHgrlh/zeWZtJ2RPkEjMLvGS6rrUNEu/CPQ2fZcrAmdU9Us+e?=
 =?us-ascii?Q?pCix8iENtNLouHA58/KU0uqdVxxsDlIOrjpsA1n2l/MgNhCiXD+uhFjKwmMd?=
 =?us-ascii?Q?NXe0XxtwEoRuSEJRCL2/1jnb4d3xApgdzE6WcjMWZDbHO0dZqJB7COqFYIls?=
 =?us-ascii?Q?q+bq/Jrq9tFzmZyvg7leeB8ekbFVHiNXsgoM6nX05/Fk2OuLCwVi7BtjWSsF?=
 =?us-ascii?Q?KDxJPkkr5YiaOV4vAhkpkWaERbZ1i07mRdgFLnXsEs+XjzdD+11DBWQY6ylW?=
 =?us-ascii?Q?bfTwXarli32SkXaE2UMb4VRi/6lEpZVEwGvE9JUcVBrPBrrsF32WCASU/RSq?=
 =?us-ascii?Q?wYkl8Nxd7j13fZSJaHoBZUQB/XkGaYY9wmApEbFS0cZZy6Ke60Sc90Jwn19d?=
 =?us-ascii?Q?mPBMbwuaMpN+qbe6iIeM88pTiCGG7a7XMb6DVEXTq0272Z7ryyJYRiMbkZbW?=
 =?us-ascii?Q?gRqKmtaqXSXYj2uPu5edFgEYq+qGonBy/zLlga1NwCLLCAT6oThPqIUETHVS?=
 =?us-ascii?Q?YfwOhRWU4znu1LLKXnmvmEsnIvvk600CB3IzbR1eDwMrNhmvTSw2eYMYJF5m?=
 =?us-ascii?Q?hdmr7wxiDs8bcCjvw+geHa/oD8ohB2+Up1do80OvvhaNL7M759m4Pz2dR2r3?=
 =?us-ascii?Q?iS1i/FonvaoLBY86E/iLaPvyy/hxFngF2EnuE8aAs+dWg2PmQ8RIgIJxa7mj?=
 =?us-ascii?Q?SSUzkpYwlGo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L0LR2jTH8AZfXjilh/JJ+K98Ipc5afgi6VHEaSc6T4kzCXhmXxpyequzsWM3?=
 =?us-ascii?Q?KeyqP9GNS7hAKlEqG5U4DpTEaokjhV8WMkxuMVuGJH7agwDfCljb4qF/+oDJ?=
 =?us-ascii?Q?4nAOJcGPgwaAAKMISmSDh+/9Im+PFUEewkY7da1CGu2aDUmfCKGN7syAxp44?=
 =?us-ascii?Q?8CyF2SIbXxpCRGBabGrnEaG6XrNyeyTIq1x+ZD0bE/Hn3Q6tCznZOaghFJV8?=
 =?us-ascii?Q?AjR7G2TMlyuvufbvWm6evg8yuzQA5/0MbW6qN5y396CjM0xIxEmwnLjcRKmX?=
 =?us-ascii?Q?FNZM8KvDnj/zjaJjWPYzkchfk2sZSa2Iuu94q9Oe60Df5JWRaKPsb5/5HO9B?=
 =?us-ascii?Q?nzjna6UkyDVe6PhNm6lS9NrF4vCtXZmF/DkZCln7UYWVHHeOgh32xim94rzE?=
 =?us-ascii?Q?dLG4zwQ/LEQCBY6CixTh0daJhbL0ArbDW6wDpBseGXCR0z5G3NYIVuDObDYJ?=
 =?us-ascii?Q?Dx6f2RJ3o25DYbppEZJjD1+2asg/Vqt4dadbTAp/aCnwMipfJSocKucvGejp?=
 =?us-ascii?Q?JOya4HvQLeoeo1M9mL6hjkXqZMcsBLfqhGddqTCLL0qnqEURnph5W6wf9aOQ?=
 =?us-ascii?Q?n0F5SThF0ibYT5Wf5t6NdCc9E9obWPKUsk0K5hVOOg1nzd/Z1BSzga6N0Wrf?=
 =?us-ascii?Q?sxOtQO7s6hPuHOg1CvScfqaKWFSCGGqm0jUpuE8pEOgGNupHekJM9Z0xuQF0?=
 =?us-ascii?Q?ujZ8/0eqyEOXY/BEp0b4UqAIUkC9EzRZweJNueJiVcWh382tshAWbywmqLA4?=
 =?us-ascii?Q?Fkjc5DYTstV+xp0Rjj1l5fnBTZNR0impAhxkhOW063OeFI2zwWWCu+E4k0SM?=
 =?us-ascii?Q?3YXvQ8Sw4oGDgTYC1tVlra1KqGiNNTDFxS4kLX7oKCKAKv4PcxK06fSXvxCf?=
 =?us-ascii?Q?1Le2WQ/g7qAj9WZ7kNgFgdiv+rAA+MMN4q4puMbddkqF5An6w4ULtLvtE+j3?=
 =?us-ascii?Q?TatDh7xpiOQIPoIFJaVFVF7aN+H7iYA1kr+dLxqwQvbX+vmlW8vCYaXKMsTZ?=
 =?us-ascii?Q?pn5WJlzOE0U4nSTwIm2nA5JK9hvkw4eXGb4wcv++5laP0gemKKK2WneD0II3?=
 =?us-ascii?Q?y9PpINPkvNjEnhLizTH4xFHNaSeqXovDN2Yc0jYp6YQKEwcutaXFutSLiohv?=
 =?us-ascii?Q?1j/ed1Hzd8VBG1KUTNB2qeDRyNgm30bpCO7Y4hO8S0sKGTj4Q6LmQzt0tYz4?=
 =?us-ascii?Q?5+AQdti2bH+g4sVvY1b/G0MulR25y0NpHk6wrrhVpwn9ItpEPiqvp0l2p1Cm?=
 =?us-ascii?Q?MU0YT1KU2juLxRKBeS2nebFvKiBhGcOwYAZcQfz/8rEkE/OlzcgWfjJ1Xopk?=
 =?us-ascii?Q?qSfuKWF+xlyAsilo8XquI/69NX+RlX6XeficQBEN2l4wQIxPxXfXINzjQQTW?=
 =?us-ascii?Q?nq7RQ3HDOclqLLI5Cr1AbAGxfxoFy3U54oS88VXOAdf2D6lZJrMS4M7vFZpw?=
 =?us-ascii?Q?B3w4dUdVrGjwKT83xFtI/gel9kfTA+l90s4Y4ZHrCJpmNQMS0YKOTOqzAaTA?=
 =?us-ascii?Q?KMCcS6iQ0W4ZMWuKI66aSGRRl/khBxrtssf+evRxwG0UWRO7ksR+Hr7Q1efR?=
 =?us-ascii?Q?ItxNmfHqqWCNBOVY+eQgvlGss47lou4ue/mhoJdn9Ls6THBcaaZgqf/MVbbz?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eC/yLt9/j46c3eogK7G2bzwEpB0tV1P/sIfFp1j4Do5eSf7SZCrJkcIg7tEeYJ12jbeRXCkLzqqi1EbM1Ap+r9ZClDvIXID7EZSeFV4eNA4PUXKLjNbCi1ixNl2Dm3vnBRCRpsI2u5+0kb570QPt3A0imoZEZgRdYgs9XLbzH0nU3vfATp/XxOnWCVW4ZP2L0/cZtEg+RZtPgBw9mCLe2W3Vt26pBLPlH194aG5J9au4AXjqdQEj0/oKPYnVWMjiK9KZbwpZKQf32ToEteHFtZsprEDTw4Yl5oBH0jkKM9abhFpUgGjqKfZDoyPuyd9WAO1xRd8G80YYR1Qjne1mZ9GoEmXSFH23+4rRtmn00m7KmJpjft/Sb4llT0Gc1PJ2yxp5GDh7AEiTVMEAe65+x9Qn+0PqENoxWj9MbPm80wiTQgRxr4F8aAkhxr0gsU79DuWoSDM/UuG9B9XRQGHD5ock9B4NPyZXMPcUSN704sga/xXd4tqUjebjvH1ZuWJiGGTP1EKj1Ix/O5vx7TxVgERezRmu1bgktLE05ejZj4WWKiz91NBy1zBV7kubl1pjkKBAcVMXBrHnM0+hssVuaGzlQKkOZJWFEwxZ0t725lc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d70c09-ff25-44de-3a90-08dd9892db57
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 18:11:07.0927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EKslP8r6TTgvfbTR/F970Q90CRQ94yWl1SJt2R6QqbZ65+A0FJWKnIBc+dh5jnYdj9SYyxMQIORbUubvLvKUXqfSXGyT3HQBwIwahEBFOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6681
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_06,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210179
X-Authority-Analysis: v=2.4 cv=Ls2Symdc c=1 sm=1 tr=0 ts=682e1740 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=aRPmWqyAXd8fDzxTc18A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13207
X-Proofpoint-GUID: K9Ie6WB_qx0NRqswPxgIRkeOWdj4lCws
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE3OSBTYWx0ZWRfX/8qHOAe+5xZY gqYRyOnsSdYSXf385Lm1PRmHJ//OwBeQAeMpvzkQY1BkXeiuQGrWJ2s8oTmGCZuyccH2Ql+IEEA RiHXR9ZRQ6XFI8gINZcHbNHCJyRTKYnH6j01pFQieopnWcH96v/5U6RDg0yqIePKwTF47TafqN3
 qIc58j/egnkokbRdjLrP52emRskWguYeLCOlq5C6aFiXzVMAEnfEnSgsMkJ1cfYsPhwc6Z4jokK TS1ai3xOKunoftAlKPtBmazinLpqhZFRb1/WoYVg4vFCiiVkIrnGulp74RtsYe5koELs/smpzoV WARuF7zXQPqLuVoBfTXC0IB9Uq5a+7JiZUmZ5BntYzslcj4X6Q3cS8ZOrG/ENVm7oevfZj0e2Tq
 Sr1hCdDH4nlXhDFbROINEFskFinkV+hXjNeQXgXrytxpbjXzKW85I7Kuj0KhZ+tJK8sUM4jb
X-Proofpoint-ORIG-GUID: K9Ie6WB_qx0NRqswPxgIRkeOWdj4lCws

On Wed, May 21, 2025 at 01:32:00PM -0400, Johannes Weiner wrote:
> On Wed, May 21, 2025 at 05:21:19AM +0100, Lorenzo Stoakes wrote:
> > So, something Liam mentioned off-list was the beautifully named
> > 'mmadvise()'. Idea being that we have a system call _explicitly for_
> > mm-wide modifications.
> >
> > With Barry's series doing a prctl() for something similar, and a whole host
> > of mm->flags existing for modifying behaviour, it would seem a natural fit.
>
> That's an interesting idea.

Thanks!

>
> So we'd have THP policies and Barry's FADE_ON_DEATH to start; and it
> might also be a good fit for the coredump stuff and ksm if we wanted
> to incorporate them into that (although it would duplicate the
> existing proc/prctl knobs). The other MMF_s are internal AFAICS.
>
> I think my main concern would be making something very generic and
> versatile without having sufficiently broad/popular usecases for it.

Ack, the main argument here is to keep mm stuff together without bitrot.

The process_madvise() proposal advocated for the addition of flags that
would be useful in other circumstances such as eliminating the broken
behaviour around gaps etc which fulfilled this requirement naturally.

However it's a fair point that the fork/exec mm-scope stuff is awkwardly
placed (but equally so in prctl()).

It's an absolutely fair point as to specificity - but I would argue that
it's a _general_ thing to want to have mm-level state changes, and while
this might be specific _now_, in future the next specific thing can go
here, and the next etc.

Things that would each have been their own sort of special case in prctl()
can now live somewhere maintained by mm people, using core mm code and
avoiding bitrot.

I realise I (ugh mea culpa) missed a fairly eventful THP meeting, I think
David suggested 'mcontrol()' as a name for this? :)

In any event absolutely love to hear input from there from anybody on that
also!

>
> But no strong feelings either way. Like I said, I don't have a strong
> dislike for prctl(), but this idea would obviously be cleaner if we
> think there is enough of a demand for a new syscall.

I won't belabour the point by repeating the arguments in this area :)
generally I worry about seeing mm code proliferate in non-mm places.

>
> > I guess let me work that up so we can see how that looks?
>
> I think it's worth exploring!

Thanks!

If time permits and there isn't too much push back I"ll try spinning up an
RFC.

Cheers, Lorenzo

