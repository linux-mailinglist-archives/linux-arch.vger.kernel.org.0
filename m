Return-Path: <linux-arch+bounces-12942-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B55B115C6
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 03:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8111C839E9
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 01:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C701DF258;
	Fri, 25 Jul 2025 01:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rZw4QnDP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xpN37f+q"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A91A23A4;
	Fri, 25 Jul 2025 01:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406559; cv=fail; b=romJi5Wi37DZp9rWN4ZlSss/i6bWJDMfyf1CEkX4SGugsxLb2CJxS9CyuiwP1VfcVtKsE60o/26m7Sx/nRLccnudQ0UtpvWN7pqcwg4FhnUHGkfqI+9cRAZEx8SPzgCNp0Z4MY/REBcArKJTN8YBTWC4LDFhMdwHNRp2fLPSeYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406559; c=relaxed/simple;
	bh=VrPquGpwS//P06mbzk6ywA1NLP2ZfDQGERdFsbiGkXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mQ7PnAvaTYubJir/eWbqDrKQKKCMnDbN657FSukLNSrnuDy7oIiUKlxkf0qy6e15Ar6VwaM+hmIQWVwdQUvIpN+l2aaGpCGUmdQbbk4Sk3nRNx3XTpDjTxCiBj+wtVZ69wCDqEpHUZHJGYT1qvGbF7sgPkfQHlv3kvu2fPjBNOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rZw4QnDP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xpN37f+q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLoL8j023743;
	Fri, 25 Jul 2025 01:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jZn6tt94ulA+AhWaDB1YcGUPPDKJfiYDwHsx4VvmK3E=; b=
	rZw4QnDP97sI+P4SH5J2tJ/yEdH92/sHaIOKbY2foO3iBBoFuIXAFgxZa/P6k+IK
	b6X1CY1oNhlq8rd11vycIM5qQY0Cduu+jj80s0sMN3FRZzKovscpqhg/fTeNVgW2
	pASsZnmJY9hFRCNf3/TaTsS3sMQD2rDD+EF4NZgQShiNYYnO4xANWAMMSRCoCrzP
	sxFh5CzsqVrHQt3sYXcea+8AXtqpCaC5emnXVrhqycG7OLqJT4CApyzDtkeQj3Vz
	azr9GHBr4ce7IPx6ab/e1DgamvGv3cxAL34Vvz9FkM7ZF5u19aMEj0Ywf+RDa4rH
	Hob4wxvqLcIBCZe7AZZ9Dw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1k0642-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 01:21:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56P07EiK011509;
	Fri, 25 Jul 2025 01:21:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801tcfpx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 01:21:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8q4WmNCIeVua4kV4Xk6cxIeRLNs0YW07AoR38pb5pcNEBXrMAcaI6iB2sUAxZ0sqA9nKmHZO6nMhI1cTflbfAG3u7yzK2ccjCpgp4szaXxlyFOIgYPmd/fjqIIPiQ0qLnMVs5Bp7+02GwUvF4kOh6Y162ryIq6ZYvPqRPzjiWwK8nixSiLwhmoheDdlQZjwUBFvliZhULA7hAIz6KH+9VsTwgGXSnhMYdhNqrV0vBhtFfJHPRfNuga2KrlFLIHTlSlzrqECnaH7C6e0f2YG8KMUGmf+D6WzVvGAmKog+C13KsPUNwvET0YnTaECGPVqf7Fs+aUnRFJaKk3Wac7ocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZn6tt94ulA+AhWaDB1YcGUPPDKJfiYDwHsx4VvmK3E=;
 b=WQzeQB/FCaS/YWwSygRYc6r6uzHHsI3fD4Nj+qATRAKQVL59zwWx2GSowO8Gyoq7qM12HVNdw503WxYLKNoV07nk7A19AZAYzBvRkCVymAGqdOOZ4QXr7+w9jo9fvfIcNPQ9p9pdMTTPWMrGf2SR0NUs57BDp8CsSYsLczbQdUXzzGcjG4SngH948x41v7TMpRGfYD6jfo5PWzdgtk4QGX6+Xc989o30QmnNk6OZfIDRDkxZkjNaeuKVC0Z7m8xUHQy+IdANO2fw0vGA4M/NMz16Hr2wJWwbrPAtDHnWdgHuvcQOnj/6F0G4uEziMKjIcJzOyo8zwVZy7oyo8tLjcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZn6tt94ulA+AhWaDB1YcGUPPDKJfiYDwHsx4VvmK3E=;
 b=xpN37f+q6bjRIqbOkzMoC8bpIW5uwjO3XC06DfiIgmgfsydvPHKaur7n+QsGkMxn9J5dVasXb+FHUipkQyekpENPwd8J+bZ30cweB8wiwkaVZ7Ec/Enykk4uCRO2zpSiAtSBjwyVb3LyR2tb1+L5D3LPgYcoutc099R+jCk8tq0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA4PR10MB8351.namprd10.prod.outlook.com (2603:10b6:208:56d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Fri, 25 Jul
 2025 01:21:32 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 01:21:32 +0000
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
Subject: [PATCH v3 mm-hotfixes 2/5] mm: introduce and use {pgd,p4d}_populate_kernel()
Date: Fri, 25 Jul 2025 10:21:03 +0900
Message-ID: <20250725012106.5316-3-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725012106.5316-1-harry.yoo@oracle.com>
References: <20250725012106.5316-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0213.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA4PR10MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3018d7-22cc-42a0-db3c-08ddcb1996dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w6GYaCGxwsIpmRrmgtgp2Ib217ZN8R3VLbz+nGSJBzrczdKU6HdwEr5TX0D2?=
 =?us-ascii?Q?Mj76J8xB1s0C1qvJKktEjp59md1CAbtu+NyS80LReugEmNV7tcAmOJdbmII7?=
 =?us-ascii?Q?ezE9diyc50XfOe5qtiSZse4oe/OrkK39D6626C7pfA2x9wxj/AkS5WgrS7Er?=
 =?us-ascii?Q?Myq60C5Xdk7iE9aeR8QgN9Y+SSCUMgdXd8GMbqBkV9K08g4Dh/4TK4QQB3t5?=
 =?us-ascii?Q?tY8OL3C+WbLGfOjZNAWHHLM9FeqC82xONFdITGVng+5XeNHNx570ZHlihpcR?=
 =?us-ascii?Q?cX3EAQIYn7QROKSdXVP2f4RSWOxtypLEyL73exww2IFyzYVSohYeBajxa2mA?=
 =?us-ascii?Q?fPnU0Ps208KPE9fPiWrPZ5+t2DjbUaTYvCidOwsEEycH14+ain5m6Nlk62lS?=
 =?us-ascii?Q?qgpKN84yL6tDqjmvoaX03mBHeVaCMa6G8pnuXAopyxMXnEg8zLTfpNsvqBV6?=
 =?us-ascii?Q?H9Ac/J0GAVuuK9ZH1xDuX61cInDmnIDnqEfVT9zEit7dTl3vO1UoIV9AZrCe?=
 =?us-ascii?Q?GL/XL2ItnJKptIU1jvWbdHYuehMUS5InQE3uoNty78g1XZrxRY2E9NOTixA3?=
 =?us-ascii?Q?xZ7zXv9nic6yppAD1sO/mFVbl4ds271P1WOUKMJ1DKKqUcvfLxKyEpWLZUNx?=
 =?us-ascii?Q?bpzSi7VsFo+VPBdsYdsB8GpJif0WIsoZfjfqHAN2fGiFHbyUBC6FANYARxqh?=
 =?us-ascii?Q?NDEqGl7KVY945Lyk02rEnGpxs2hrK2fQkEv5aHr0YPmR4egIbFG6AdWsP5Rb?=
 =?us-ascii?Q?sHvV5K2rIBftFLChg0Dh0UHpIGdTK0E61xCt8gHdjsHb97oauf4hvS24UICJ?=
 =?us-ascii?Q?k8PWDdE3oup66a36s7Bj2jCm1+LPOMKiHWhzzBYKmgzXSKbpcl5pOheGzaC3?=
 =?us-ascii?Q?pQs6P1kT45V19gS6HzUyabo8cSqtZi1w5PrvvMNbAum4L9NYUyE1WbesOtl6?=
 =?us-ascii?Q?N3266btL290caSDCPVAfPE7/eOQwwDZXaDHWsxed8HQP/OQItZJCCyB6/088?=
 =?us-ascii?Q?hK28roz4A7NpeAIE6DLfm1fC4SvPTg+WU339D/QeiI5X1cyQ81z8Pw79+HDV?=
 =?us-ascii?Q?oVfNmb1pdg6Biq0NsL6jyfnn8FsuYAaEQqCnikiuzBPcPXaaZoB4nJJhr0Zg?=
 =?us-ascii?Q?tU20ud0u11lqi6OpQXjNfxHR3mlg7uc4Usg2b99PJlfwna0DLrpNmNI6fiix?=
 =?us-ascii?Q?AuOFkS92mc6LROHNXFihUTTN+KFKu+Q2JaER97pw/ZDq3O+NWI0kvTPnwkhJ?=
 =?us-ascii?Q?Alc3tbCzzZAcaQZhFL6JN/Om5tjSIt/d89cAa+gJaGIBxxD0ODcPSk7mibws?=
 =?us-ascii?Q?AZBpxfvP0cfJIlsptMD44w7CD6uPPKzWQWSdlxbaefMVbijK29rjCMVfWhf4?=
 =?us-ascii?Q?9rcNyTeFFaGVGCQS7hzp15oaPmQ9QNoohPiySlPygthzN1vIiA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QRn9BJgAAKpLzT/tjsSL3GaURg0g7s/C5WEIbAFk3b14hRVovEKwaLgOfaS8?=
 =?us-ascii?Q?Zw3IASTl4DOBIHoZmPJfUP8P3iXyZTQn6WgZ6M4Q3gBFqpl98/0nH6WzyFnm?=
 =?us-ascii?Q?23D8BueycOcksY2eE5M3RIcrDRjtiI+JSdnOsfSCXje+7IoTf3KASryU6WJ4?=
 =?us-ascii?Q?EIUiEbheEai6eRs9MIqt+qUJR1CGY7uAGoGj+7ImSDL0ufT9dNFau+WUTiEb?=
 =?us-ascii?Q?nSi+pXt4N7mIJCjZU6Ac6DDMR5tSK5aE2zXp7GBCs6Y6p+1BrDcpNWtE2cv7?=
 =?us-ascii?Q?XTEpyBk0/vvvsg+knaFSpjyPn/+FXAtSLW4Y4pSJZTucSsnbZdM1sR0hJbRo?=
 =?us-ascii?Q?BOWlG2R73CCEr/L0ZCKxaJn+gmACRHHny9Z7jrl9u9umRHhH8sBSn2/mBayc?=
 =?us-ascii?Q?cbyoAQ68VwosvxKuEtWRR+1Y+J6aRuvXeoZpc1Upcp2+mgXVIfByjtbZn4MS?=
 =?us-ascii?Q?p5GQP/WQOF8TgPsQjmINOvOxcyEaqdK/2/+bI7xPmPqAhNbwybIFJn9VWTxf?=
 =?us-ascii?Q?KbWib/xkkunWeENGYGoPWr/7G6rnXm8jUudpDZIgxXqQz6/i2QAW+10rHnne?=
 =?us-ascii?Q?h7l0TZcR+cNemesSwG9kmdBUsQLgLkaOWGPU6mJ+agQY3+It/jQ60aod7+ox?=
 =?us-ascii?Q?YCKFpXU4zbinpg5cPkPSIERdyeOnNxRxpg8cykdEeSYdezOR+IMP4ZtG9FC4?=
 =?us-ascii?Q?abbVd6+rlQAcRmswvenntNi6QzYsXC29GKhkfHhxNjeXOwdO7RZykLu0fxLp?=
 =?us-ascii?Q?ON39uYEQ4bBxl1Fw8n36nxw+yAIizvHZoRTwG5gtiOSJVnR1Wyr8qMgXDzRG?=
 =?us-ascii?Q?RvgNAFjfHYD1XXSDpwwtOen/2CqBNKye6Yd/jk1BOW2DBABBOx4wtOfwkLlJ?=
 =?us-ascii?Q?nB4H0UZHo1opXoyfSZwgAkJCNlUBHGIWI+eG36tJEAS1gjl7/0PJnfCJbULs?=
 =?us-ascii?Q?1bdzov7SqXGAeSKVfmvcmDRfLOdOK09Rq9Rt2zbz24ljNSaSwjoaaWPY6PAQ?=
 =?us-ascii?Q?4PTlF9tWpndOmOO/2RIVUX8tFgyfrVCCvfQWA3lQ64Na/VgtLJThXcdy/RIQ?=
 =?us-ascii?Q?JcTggJlr9CgRhEuA2ysQfIrM9VCoZjYVVygpZ8os5vGl6oONWWMWo75q0GF/?=
 =?us-ascii?Q?KLaxMTM42JcuR0FR2sHR4zV5G8rC/NhbEEdfVuOC4SQBR8p5fGsYCh7suA32?=
 =?us-ascii?Q?Y9o+i8GISmPya1vm5jw7n7up2dq+1oVdb4x4ZcjK0IWMlO1iH8f1X2JPexYw?=
 =?us-ascii?Q?08PDekMuPR7sr3LjMKDylCk9DoVfeMW6pEdmPjzlnVtxtIwDJ/K1USpvvQHK?=
 =?us-ascii?Q?Xg+hx3mB96QQmorZ5NSXyJCu+C/RnO8V6N9gSe4ftLayJgvPKLU88bjGlyZZ?=
 =?us-ascii?Q?O54mtaoXIEQKQQ+CiLF8BvGC3DynrLIXfQ4v2bYpSdlC+eaTA2rLa3FMw1wq?=
 =?us-ascii?Q?jB8IlrrbJbKODb1h9LcPzbM/OR0XP06PwLBOxjuOCPD/d9O2UEsCa8dwWSfi?=
 =?us-ascii?Q?KEL24S+xyHm6HZhqF9VAN1A/OxfpElU9B2j4fITR607TMe5FtymM0xqQ9XCr?=
 =?us-ascii?Q?tW6iGHIEILkRe4HtO4Tul41z3WaG6/ut2tZfqrnG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FN3ullFQM3Y4ptRFOUN4iD8R80ihvd5Vy+yyDCTULHagVfc5L0gwK1V4d6gik4PGlBbfYzB3EGpALFF8c/htQHc8L3aI6yQwyR2ULjs+NcwWIKyH87qZ4TmNpBUOZyfz6m3NFXPFoSA+nIDyGfm+up2XpCthIF4gp6Xgx4NxfYlgI9hi6HBIJRGWmN7j/WizO+Dzq9yKutE0wjW9HtXVOMY8Oub7Y/T9tfG7gzcks2awTUZtf0O2YVYUfCxgnOcJfNhiJEsiXfPZ6+bPSe1VsuzPGZf+eEecQzkxpIzrJ4gcw01vYvU5gzQ8IuYNZFDcr6iZ0B/75ibleGbVqr7/9y4SoA/a1m1GH+RqmsgfKH0J2H4NwBMB0TbFjz44e36i6YLR/NjLxntrwVaGs9vHzYsNX5ZqFlgm8d5D6DU4DoSP9Z3m9kzj+TodXkSJq3rIfXem5cWyru8vX3QC6TNy0X834d7WkKtVgUgrU8KYRddv1bDMhSheiHviDsh6cR/dwhp8S2y122SkzLJs9bK+Q32ySIjogyS7UME0C6E6muJx+1n7D34PFA3w0hi7h+3vPDENFByCI9lidwl7xIKXSicKTQ0mr7dob66ttrx5toY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3018d7-22cc-42a0-db3c-08ddcb1996dd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 01:21:32.5584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMMSnxx3Jgp7D59ifqZ2a+tre/5wN2Rz1rMLO3EsaLaP6A2nrlJGRHPycEp+7TV3aFSCe5LjiI5QMia4Z91c2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_06,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507250009
X-Proofpoint-GUID: CMKthJq4iQtmrK9AQj4BDI9x3BB8Sz2K
X-Authority-Analysis: v=2.4 cv=LYE86ifi c=1 sm=1 tr=0 ts=6882dc20 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=_WqdhI7_4vd0nkmDa0QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDAwOSBTYWx0ZWRfX2dwJmTHm/L37
 9DMVterF3w/anH4f0vsyoqKe8bUmLkzpZjLTQn6tebtxXrfCpY3RcmpiN6hfBLpYbTs9iDtVHJU
 9bzIN7zggPkt8D32tQyLM1HlzyrR6EDhgAjOhPZpJqCIrRURThv0llj7KBlYHZ73rIO8/6fmPBh
 f7MTYsF5IlTKjATfL/qWTkbVLsO+5dtj3UEu+A2EEJVvNddZBCzWtraHlie5IW4agI6iO+V+Jm7
 i9eNgQbXHmCGHFmHWBrcX2/F+4MHEldseFQBryEzE247GUc0hjuLyyyH5wGEUuyFDWRQeAFfIQW
 bGqxyiuKDUDClY2Ifnfel8z7XLDhb47NRgQPCJ21KW0d3x2wHabcZ5mde9T1SI5Q04JWMkCNQK1
 gXBXPhXISKB4PF6jpXwUz/EeGHUnx7HBjH1axVOK03Ve/NRYtYZD3je07u7PWFbWRbdt0MH1
X-Proofpoint-ORIG-GUID: CMKthJq4iQtmrK9AQj4BDI9x3BB8Sz2K

Introduce and use {pgd,p4d}_populate_kernel() in core MM code when
populating PGD and P4D entries for the kernel address space.
These helpers ensure proper synchronization of page tables when
updating the kernel portion of top-level page tables.

Until now, the kernel has relied on each architecture to handle
synchronization of top-level page tables in an ad-hoc manner.
For example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for
direct mapping and vmemmap mapping changes").

However, this approach has proven fragile for following reasons:

  1) It is easy to forget to perform the necessary page table
     synchronization when introducing new changes.
     For instance, commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory
     savings for compound devmaps") overlooked the need to synchronize
     page tables for the vmemmap area.

  2) It is also easy to overlook that the vmemmap and direct mapping areas
     must not be accessed before explicit page table synchronization.
     For example, commit 8d400913c231 ("x86/vmemmap: handle unpopulated
     sub-pmd ranges")) caused crashes by accessing the vmemmap area
     before calling sync_global_pgds().

To address this, as suggested by Dave Hansen, introduce _kernel() variants
of the page table population helpers, which invoke architecture-specific
hooks to properly synchronize page tables.

They reuse existing infrastructure for vmalloc and ioremap.
Synchronization requirements are determined by ARCH_PAGE_TABLE_SYNC_MASK,
and the actual synchronization is performed by arch_sync_kernel_mappings().

This change currently targets only x86_64, so only PGD and P4D level
helpers are introduced. In theory, PUD and PMD level helpers can be added
later if needed by other architectures.

Currently this is a no-op, since no architecture sets
PGTBL_{PGD,P4D}_MODIFIED in ARCH_PAGE_TABLE_SYNC_MASK.

Cc: stable@vger.kernel.org
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/asm-generic/pgalloc.h | 16 ++++++++++++++++
 include/linux/pgtable.h       |  4 ++--
 mm/kasan/init.c               | 10 +++++-----
 mm/percpu.c                   |  4 ++--
 mm/sparse-vmemmap.c           |  4 ++--
 5 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 3c8ec3bfea44..fc0ab8eed5a6 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -4,6 +4,8 @@
 
 #ifdef CONFIG_MMU
 
+#include <linux/pgtable.h>
+
 #define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO)
 #define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
 
@@ -296,6 +298,20 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 }
 #endif
 
+#define pgd_populate_kernel(addr, pgd, p4d)			\
+do {								\
+	pgd_populate(&init_mm, pgd, p4d);			\
+	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)	\
+		arch_sync_kernel_mappings(addr, addr);		\
+} while (0)
+
+#define p4d_populate_kernel(addr, p4d, pud)			\
+do {								\
+	p4d_populate(&init_mm, p4d, pud);			\
+	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)	\
+		arch_sync_kernel_mappings(addr, addr);		\
+} while (0)
+
 #endif /* CONFIG_MMU */
 
 #endif /* __ASM_GENERIC_PGALLOC_H */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e564f338c758..2e24514ab6d0 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1332,8 +1332,8 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
 
 /*
  * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
- * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
- * needs to be called.
+ * and let generic vmalloc, ioremap and page table update code know when
+ * arch_sync_kernel_mappings() needs to be called.
  */
 #ifndef ARCH_PAGE_TABLE_SYNC_MASK
 #define ARCH_PAGE_TABLE_SYNC_MASK 0
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index ced6b29fcf76..43de820ee282 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -191,7 +191,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			pud_t *pud;
 			pmd_t *pmd;
 
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -212,7 +212,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			} else {
 				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
 				pud_init(p);
-				p4d_populate(&init_mm, p4d, p);
+				p4d_populate_kernel(addr, p4d, p);
 			}
 		}
 		zero_pud_populate(p4d, addr, next);
@@ -251,10 +251,10 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 			 * puds,pmds, so pgd_populate(), pud_populate()
 			 * is noops.
 			 */
-			pgd_populate(&init_mm, pgd,
+			pgd_populate_kernel(addr, pgd,
 					lm_alias(kasan_early_shadow_p4d));
 			p4d = p4d_offset(pgd, addr);
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -273,7 +273,7 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 				if (!p)
 					return -ENOMEM;
 			} else {
-				pgd_populate(&init_mm, pgd,
+				pgd_populate_kernel(addr, pgd,
 					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
 			}
 		}
diff --git a/mm/percpu.c b/mm/percpu.c
index b35494c8ede2..1615dc3b3af5 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3134,13 +3134,13 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 
 	if (pgd_none(*pgd)) {
 		p4d = memblock_alloc_or_panic(P4D_TABLE_SIZE, P4D_TABLE_SIZE);
-		pgd_populate(&init_mm, pgd, p4d);
+		pgd_populate_kernel(addr, pgd, p4d);
 	}
 
 	p4d = p4d_offset(pgd, addr);
 	if (p4d_none(*p4d)) {
 		pud = memblock_alloc_or_panic(PUD_TABLE_SIZE, PUD_TABLE_SIZE);
-		p4d_populate(&init_mm, p4d, pud);
+		p4d_populate_kernel(addr, p4d, pud);
 	}
 
 	pud = pud_offset(p4d, addr);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index fd2ab5118e13..e275310ac708 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -229,7 +229,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 		if (!p)
 			return NULL;
 		pud_init(p);
-		p4d_populate(&init_mm, p4d, p);
+		p4d_populate_kernel(addr, p4d, p);
 	}
 	return p4d;
 }
@@ -241,7 +241,7 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
-		pgd_populate(&init_mm, pgd, p);
+		pgd_populate_kernel(addr, pgd, p);
 	}
 	return pgd;
 }
-- 
2.43.0


