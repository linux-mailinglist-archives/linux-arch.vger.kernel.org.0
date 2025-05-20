Return-Path: <linux-arch+bounces-12034-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63582ABE339
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 20:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06A63A8102
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 18:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1825926C3AD;
	Tue, 20 May 2025 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c2jjnNey";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qDo3+dYw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E061B7F4;
	Tue, 20 May 2025 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747767353; cv=fail; b=rjlGRZrJFklrK73Et1NuaPkqYcyGcDwUG27MfuZOZzWJC9zTKJe/k+YempfMkfgMn6D+g8m7kmoS9waj1pNY0Ih/d0E1Q5Ay63wwv6nw6t+VTMsFNDxdz/OPLUXd1ewkO900oxOBlQqm2u6wu9WrPYdT7fICDdox8jOlyPvA8EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747767353; c=relaxed/simple;
	bh=35LukkM2IjVf44JLd7fBSeQJNb153MqKsABf9ZQ41dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lxjslycEGp8GtR2tVAfhjlYxPtgCPxi302URc4k7MwKEobiHYxkwzI8Ww0DW63G5e2g0dIAt2rFe1jXYIF+b3hO0nSW7BeaWOQNxz7cA8p8s73ITLm0ajGyHYGwxhYUlbKy0bo0hc3K4VrquQyUDJowNfKrYpzN77zlvO17QE7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c2jjnNey; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qDo3+dYw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KIMsEv018472;
	Tue, 20 May 2025 18:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ApfEiVSQbkzK2IMypJ
	3PXSqWf/N0LlaZmzMk+jSTGYQ=; b=c2jjnNeyOR8OpFyk7iH58Do+cRH+6mOFnu
	KTJxPJxOVO7D8vqfNJrUpFkVakBLDBC9DNQtLeCb11tc+rk9OCF8naVBo7L6b+Zm
	usz56NdGbFlp8fg86HdBRjTkF8FZXTbvphtcVVcPBJK09Tfqax8PzJ56r/KSsExz
	Pt4RXtzYgrhkeXzgZsNhzrVwUJbCp9DNWM8VKl5I46VvCxew3kZusrL645Xrv5Rw
	cmk4tyPukUoBJfjZMnLAfhIIc62/apeMago9J/5qVGUVYfBPx9VHrGa1lV00Lpjz
	Rqm8WqHK6qRfYmIl5aScHYas1fB2QQAhLBYyYh2ul2siqWSGuWMg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rxgu05r7-23
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 18:55:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KI7XDq033035;
	Tue, 20 May 2025 18:45:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwemdgwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 18:45:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0Mcto1fTctRO5eFHY0njsdxHXfwfQlh2F0iucLyUSeAcO0UEAGYdlgh+XJuwJgMN4Cv9FiVtXq7e8SPyaS9GJmz0Ne/7eQdrqZN2B268SPdRP34yHYHL/dkeaJe+lqx5CED0Zvkz01KtvMiT1Upqt92SwdtjhD3K1ECRg/UfUjNsHE/Xv3OAdbK1SjCqYMVGh1eDpq4ymC7J2ik213YMOVfxk06dFuyrgi1bVoHQTpCaOWy8EUJR3GHbe5GYqEjtA3jDxKphiQERZJN8U8J41a9MuE3dNg3ZXiK9BiW01/okAIY6xheV0Xq+twTN8twUTIF/ArdU+CIpehqHlrijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApfEiVSQbkzK2IMypJ3PXSqWf/N0LlaZmzMk+jSTGYQ=;
 b=gtZUdvHqvOyu69zWvvsdTjeG+AqEb5IN/pTIon48qNol0u5dPI71mJksSj/kYf6wHuN84RbH98A36cjq596zj9Wh10B3q3T84gK0q/IF/fojfIC+otYzHBWCoHK1WADfrslIJEqj7kqcGSKYTrA+KtbYZfotd7Xg3w5NlPZ7uLBIe5oZGlLsq+FTNjtTCfHGGwONwFLHfvprEVRaNlVWJYctAnV+4K8CBVfcuWrEoA23RC6KQd+7FqTP1oIZoUCHoWr+jAhcRpjMzuqC/H1jiLIfpsfPmSXWCaku9W4ge9JBf45mPbv/EDTGj0STlAnU2XSJhYB2xmN5jMpI/K0kJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApfEiVSQbkzK2IMypJ3PXSqWf/N0LlaZmzMk+jSTGYQ=;
 b=qDo3+dYw4OHV3Z0khrwM0I01fZsPcK792PMuEKMK7BSouwRrzI+8kFW7kNlW04viI7NX1ImCqIdr+GDVq+NF2GFKh/F+Sto7BuApzudWknOY/4fgCHORqQql7S7W02QX3ioenlep+f6bCZzlkGaqNFm5YbFWl4IXHQD2Z+EVKM8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5187.namprd10.prod.outlook.com (2603:10b6:208:334::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 18:45:45 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 18:45:45 +0000
Date: Tue, 20 May 2025 19:45:43 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
X-ClientProxiedBy: LO4P123CA0464.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5187:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d53b4fd-3b34-42e8-8389-08dd97ce87e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7ZR/uHDKa7/PJAJMGqTbs7odO4uth/nxmBCN840kanqtETXH9Zybc4WxfAPa?=
 =?us-ascii?Q?0Gm/2yMz0jN/rnBz2L2Aw+py2L0+mz9UuWpbfT5oWA70yZBaW43SSJJjCigr?=
 =?us-ascii?Q?z333zFCe3Uv1P588RxsGVn+5JTJ/G3rEKplnswPMwGFfYDiy+3252NErHnd5?=
 =?us-ascii?Q?lzg3C1E/IhE6EvpIsoJr6T1nQJ1OGfJbgqO2fZ1fjBH9DuY/2e8LVboeA9dC?=
 =?us-ascii?Q?z89Rbve/ifTD/tG13pZq/ndGBhyELxKVX17rSkQBJ/Sq008hnizDB6RBn5jy?=
 =?us-ascii?Q?gRQTJuLe5oyTPqRgOXBIdeN9vtcbPzJydS85aZ/KANW+xy3XuK8mbkNvsYS3?=
 =?us-ascii?Q?wuHMFt1hsHV6ZMsLkES6buya5DwNDeiR7L7EAsL2qK8yivSiMjcBt/imCZs2?=
 =?us-ascii?Q?9ZzFSltvU77seXTsg8kvddhNpovDS40z7rtUUsFinihLgQhEpOPgi9BzrGXQ?=
 =?us-ascii?Q?SmMLx59rKqAH0Hcz5xIOCAfjwGteHds2VhBiGh5Jlgcf9xIxTRFwe7pQ2pk0?=
 =?us-ascii?Q?uhY1SrURYLGq2R5dN4QHG3t/Hrxqwg7wrSTA/4JVZS+w9M03Jfr/S61mvLyO?=
 =?us-ascii?Q?U7cPx6VZaVEsDl5kcJCuTX6v+RcFfAwnBOLaO4TdwlsYjPUzx8DXGmXcsM92?=
 =?us-ascii?Q?W1r89VaZ/r9qkfQG4XsGPwqEl596Xm41GSRtX1CbJUQhv4fCMsPpo6/FSGM/?=
 =?us-ascii?Q?LeCW6ci8kD3liHLVnDosFhCXNHeg9jgi9lgdJZh7yVkShTfV/EQHtecyyold?=
 =?us-ascii?Q?MD4nzwGEtdOqeLd4v9Uxt/ZTeeZ7AJ0MopQnuNzTPkRmMrrpbsD7iLU6AWsR?=
 =?us-ascii?Q?CJhAkOjvTkesX8lfYTNqq5VQ/ksbsA6tEy0PI8RuIWy1Udv3Ot1YhqNymT3K?=
 =?us-ascii?Q?U7Ol8nEED2plIt4exrjLIioEPZFDdZAsSsBrtzR5tdFUCfOwPsQnF6R0Pwsz?=
 =?us-ascii?Q?bcfdcXEUk5uHS5jReZcjPV1+rPxT5ViryUu6AbJDZqjlRmHp5r8fJVNoLjej?=
 =?us-ascii?Q?2zLNur5pbzOGIqtMhHBPmRmGFgH718zY3rLv6MtPWJZw1ztv8+h8Pkwd0azw?=
 =?us-ascii?Q?k6Sb48oKAkV8iER/6LRm9RTbU4i3xfCiVqbKH/QuRioRc3+nt8QFXcy76rQh?=
 =?us-ascii?Q?mfSluKSt+F0SqaCYJSD0hez6FblviNGh3OcCEloccN6i53CMrFgd0g8jtRrV?=
 =?us-ascii?Q?mtXSeGYQMTOF50J6yJyELTF+tSBDBtG+tBeZ5HQJMAg6Si8dEbiO6IpHvMYC?=
 =?us-ascii?Q?cOZHL21VkaIyP1oY4DhWjmMgrj0fcHrmnxdakTZu8ScEv9CN/ctkBLto+2EH?=
 =?us-ascii?Q?gS+2QzueAAp9v8gG/z8QXSEq41gk6Y50bb6oaqYWhBpARGzFydSBBgpo3vTt?=
 =?us-ascii?Q?oGMOIKqi8xcRrzoV94rV+AYod8xD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MvvITPTx9MkdQ2if8XsV1rXGmOasnAeydZ8dn47hYkltnQyEXY173jCvkLQd?=
 =?us-ascii?Q?9UZcjZR9/FQAdNq89KRIEAM8S0mvAmnbQTzKVjh2tqvASAHlInpuImdF7zT2?=
 =?us-ascii?Q?fd7oOpd2g790Slhm3J4vEwJJbbbXi7CUSWdrxq93lK5NwD06g0ct1zzRhb4Q?=
 =?us-ascii?Q?mtUbMc6D+QcK5elKLatRJGryeNIPKwRdv1dsW23m6mE5osQNNe9BCc9awkvj?=
 =?us-ascii?Q?gEjAzu1sEi5Ehw9KtxwzvB5j4sr9d5x+rnkCnsMF3DuYtyCZZZ70dRdZJV1P?=
 =?us-ascii?Q?ym9m2uQiY03MsVMy1BRssJ+mPFSCW9Kp+BBR83ed3TSSsA2ej2rzWF7HfijH?=
 =?us-ascii?Q?xWvjWSxf7C2xuDp2AZwF9qAVl6wacW2kweIgZxCod9sqD6czh855W69i5X6g?=
 =?us-ascii?Q?daw/GQMGOxJ7Pgr4EOveaeksy6mYBDXiLwaCJ6R4W5TI5DGedRIpPYxxd3NV?=
 =?us-ascii?Q?ouTYjZLnM9lFBZGGc+jc02WMA3DqJI8oysnvdsHI0xk0YT1kAuXlhwMGlOsn?=
 =?us-ascii?Q?zZJeMz8vkP6bMhKfWCmW5zWKz/IAWjGR40vy0tZLV75EbZXPh62Tm3yWBR4M?=
 =?us-ascii?Q?oK6Rlqp593bRqwM0sIp60injZ3ZrnYGlWRU2vF1hskZRCiknr9nk2ADllYDW?=
 =?us-ascii?Q?Tkj+vbHZc84KhQ3IjWA0fv5AY2xIYC1EQkWO03F17bTUtIlRcCJHf7MWNy25?=
 =?us-ascii?Q?DB7ibcxSRVcGDW/8LQa7ThjNplXRMyzEwsHhspBOWvB7C2bI32E19292A1ws?=
 =?us-ascii?Q?sAGesaC3tjXcslpmPbcXOeUjIuDsjqRrJNyeStZzKlruLwLixohXP7ZsJSWU?=
 =?us-ascii?Q?9JIm8BXWMbmmdE9wM35bzMbldCvKFFh/LXGSvZxqOKLAsUwwgGm2the1ojHn?=
 =?us-ascii?Q?Qko/QYuEaVB6UyUbTbDV/L0PI/nCesRwsTprE/G58u+D2zCEsme7Gx192IJt?=
 =?us-ascii?Q?1+YpnumENwmkCUZKHVEDxozLXsrHaTGIBgBd9WCA74N2t3EgPXfw1gIILAdu?=
 =?us-ascii?Q?t+e6oPACBObrzFtp5DVITVczgnvi1iQ3a9O7PPtRiV8N5Rz1qu57wNro3MpD?=
 =?us-ascii?Q?pyAZ5+QahDOZChlKLDEBLR9USkJ5xRa102ynN4jR+Cu+YC+mCTzYT2U9eK4S?=
 =?us-ascii?Q?0hraB/tEWDbG4gyfUnBbLFy4SR4iIs2ZnrthFRD82GXS8h9CXoa1RtTmamD2?=
 =?us-ascii?Q?OKzmhbUKKVeZuhEWlUEDuJ3PegIa38hIEQpwHwU6p6/9pRhxCrPK8SPDRQCx?=
 =?us-ascii?Q?lq/9cpep4ivnrGdFnpdfZ8ts6VuKljEoVK5fXtAul4V9nsRR95ryu/cQGYXf?=
 =?us-ascii?Q?vShH6t04E5DwsyPymhKopY+64iL9uXIl2W1W8Oms35eGzQqQvexx0f8imKz5?=
 =?us-ascii?Q?yNbd8MBhvkc7TILxMURX+h/qrh1VuSSQig82gi+7V5/Vr/Batb4bquwDiAtD?=
 =?us-ascii?Q?mZNpLtb0EtpPJoNZ0IVR+gwbbw3cBC1wMg+pqslnUk9ztlA3sZRURwwjZdJ8?=
 =?us-ascii?Q?V5GUdXqgJ1zdZVQqjmxZlfo4fndaHMFHqmUwOMrzdCicSF7c6gmuTkELaQBZ?=
 =?us-ascii?Q?lhreF6FGccHDkH6Ogc8fSV08Dp4A3PJimLYnCY7CNYhwGR2EGBVU+SZY/mkF?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c+Piu8n0Tuv16wxnY5s/fbBSKmocPrEuC17zi59meg00QeM5iXSVqFRkzBeCZc+gokg9IOtwnkP9NXF4DeVVdpolu6xFgdU/lubIn6RewP+IgqnURNlWNpHCbjH3RyclExycnrNbdKZDLFR3DDbl0ou6JWGFaKBGrxB3yqo2Kv5J2hdMoVJbD3E3jgnspuB6EV23IuEUcTA7GyIaBx7Cpvo74iDgtRdjMwxj6zN1TkhTQEPk1/W1QXZkiIhK25eWv0lpwmkXeKXHLdAKgc+NMhJWXtSZG6cO3oNQ+Bp0xUQxtQy5aYHlBbZFSDvBhuF1CpKMKHC1eXX9nRLasGw+WbF69PAKGaThYfSg8lVL+iqHABAovM0tTOSBYxVe2DWpjGBCPFzSx91M8GTlTaQvi30Rfm7EyfbIPS6nCVMNZUhxLhVMZ4XngUZcA1AgK9EMlaX1TG7sQ3Rax4vkokCx6Cwhfc28GgfAcP5SgQqwnSQGrSrqGtawNtcHV5p93XA1pUddAjRKDcbnf0Svs5pTiTy08X0jnmEKyByHLfQ0wCs59UOoFMjktZWrSPJ36W8nfWKFEcb6exPCvjnLc/I1GaP2p1X1unlQnKoFdxSqrlA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d53b4fd-3b34-42e8-8389-08dd97ce87e2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 18:45:45.6409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZJ/aC1H1ox8I93awXuqVjplkQ2J5CxI4VSCg9RcNhg0MhH5Mtaz454oIRaPcZ4g+gRQmhsj0MyeHPcRiKtY6/KFRbbjfFksk04QSy0SMLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_08,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505200156
X-Proofpoint-ORIG-GUID: uw45DAiFFbSBM2xjRfkRodEMC1WL4Zw1
X-Authority-Analysis: v=2.4 cv=LdA86ifi c=1 sm=1 tr=0 ts=682cd022 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=q70Xe31STs0wUQaFgKQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDE1NyBTYWx0ZWRfX/2K2Nhb6YmKy LEC8DFI1ehuq7HSUrRZa2CdojqT08q/+PMH7QZIrgHqFHpAbsI/9ON3H2R2iJTirDg6DFNKwN1c Pr7DKNmpNN0725T36mV5TktNHR42A5jRazQSVnbUG4EDJXf7sS4fG3HgD8mrQTm7OIboWKivh9Q
 xOtZ8K4WZz2FpCrIYFqtWc8dSkmePuffO6BGt/n/JBOtAhXmEUxmb7hfK4nfMJn/8BHuUiEiFn7 gF37+o6OmnXniw6GH9dNx6oln846AJH+/15e+E91D1tWosFXQ0gPleC7fta8dygtDQxHk0VG0j7 qYfn+ikY88UjnE5SFnOPUi+x3DAyU1+MYp0a+4T/KoD7QlgilQARFyk6OZG/3dsdoARVH7aAT3f
 Z3PUdx8ol3lJheRGzoCAdJMIteCmvkqpzmXFGy/SByPPhgtWxGiTtbKoetp8cR3vDaZixjpM
X-Proofpoint-GUID: uw45DAiFFbSBM2xjRfkRodEMC1WL4Zw1

On Tue, May 20, 2025 at 11:25:05AM -0700, Shakeel Butt wrote:
> On Mon, May 19, 2025 at 09:52:37PM +0100, Lorenzo Stoakes wrote:
> > REVIEWERS NOTES:
> > ================
> >
> > This is a VERY EARLY version of the idea, it's relatively untested, and I'm
> > 'putting it out there' for feedback. Any serious version of this will add a
> > bunch of self-tests to assert correct behaviour and I will more carefully
> > confirm everything's working.
> >
> > This is based on discussion arising from Usama's series [0], SJ's input on
> > the thread around process_madvise() behaviour [1] (and a subsequent
> > response by me [2]) and prior discussion about a new madvise() interface
> > [3].
> >
> > [0]: https://lore.kernel.org/linux-mm/20250515133519.2779639-1-usamaarif642@gmail.com/
> > [1]: https://lore.kernel.org/linux-mm/20250517162048.36347-1-sj@kernel.org/
> > [2]: https://lore.kernel.org/linux-mm/e3ba284c-3cb1-42c1-a0ba-9c59374d0541@lucifer.local/
> > [3]: https://lore.kernel.org/linux-mm/c390dd7e-0770-4d29-bb0e-f410ff6678e3@lucifer.local/
> >
> > ================
> >
> > Currently, we are rather restricted in how madvise() operations
> > proceed. While effort has been put in to expanding what process_madvise()
> > can do (that is - unrestricted application of advice to the local process
> > alongside recent improvements on the efficiency of TLB operations over
> > these batvches), we are still constrained by existing madvise() limitations
> > and default behaviours.
> >
> > This series makes use of the currently unused flags field in
> > process_madvise() to provide more flexiblity.
> >
> > It introduces four flags:
> >
> > 1. PMADV_SKIP_ERRORS
> >
> > Currently, when an error arises applying advice in any individual VMA
> > (keeping in mind that a range specified to madvise() or as part of the
> > iovec passed to process_madvise()), the operation stops where it is and
> > returns an error.
> >
> > This might not be the desired behaviour of the user, who may wish instead
> > for the operation to be 'best effort'. By setting this flag, that behaviour
> > is obtained.
> >
> > Since process_madvise() would trivially, if skipping errors, simply return
> > the input vector size, we instead return the number of entries in the
> > vector which completed successfully without error.
> >
> > The PMADV_SKIP_ERRORS flag implicitly implies PMADV_NO_ERROR_ON_UNMAPPED.
> >
> > 2. PMADV_NO_ERROR_ON_UNMAPPED
> >
> > Currently madvise() has the peculiar behaviour of, if the range specified
> > to it contains unmapped range(s), completing the full operation, but
> > ultimately returning -ENOMEM.
> >
> > In the case of process_madvise(), this is fatal, as the operation will stop
> > immediately upon this occurring.
> >
> > By setting PMADV_NO_ERROR_ON_UNMAPPED, the user can indicate that it wishes
> > unmapped areas to simply be entirely ignored.
>
> Why do we need PMADV_NO_ERROR_ON_UNMAPPED explicitly and why
> PMADV_SKIP_ERRORS is not enough? I don't see a need for
> PMADV_NO_ERROR_ON_UNMAPPED. Do you envision a use-case where
> PMADV_NO_ERROR_ON_UNMAPPED makes more sense than PMADV_SKIP_ERRORS?

I thought I already explained this above:

	"In the case of process_madvise(), this is fatal, as the operation
	 will stop immediately upon this occurring."

This is somewhat bizarre behaviour. You specify multiple vector entries
spanning different ranges, but one spans some unmapped space and now the
whole process_madvise() operation grinds to a halt, except the vector entry
containing ranges including unmapped space is completed.

This is strange behaviour, and it makes sense to me to optionally disable
this.

If you were looping around doing an madvise(), this would _not_ occur, you
could filter out the -ENOMEM's. It's a really weird peculiarity in
process_madvise().

Moreover, you might not want an error reported, that possibly duplicates
_real_ -ENOMEM errors, when you simply encounter unmapped addresses.

Finally, if you perform an operation across the entire address space as
proposed you may wish to stop on actual error but not on the (inevitable at
least in 64-bit space) gaps you'll encounter.

>
> >
> > 3. PMADV_SET_FORK_EXEC_DEFAULT
> >
> > It may be desirable for a user to specify that all VMAs mapped in a process
> > address space default to having an madvise() behaviour established by
> > default, in such a fashion as that this persists across fork/exec.
> >
> > Since this is a very powerful option that would make no sense for many
> > advice modes, we explicitly only permit known-safe flags here (currently
> > MADV_HUGEPAGE and MADV_NOHUGEPAGE only).
>
> Other flags seems general enough but this one is just weird. This is
> exactly the scenario for prctl() like interface. You are trying to make
> process_madvise() like prctl() and I can see process_madvise() would be
> included in all the hate that prctl() receives.

I'm really not sure what you mean. prctl() has no rhyme nor reason, so not
sure what a 'prctl() like interface' means here, and you're not explaining
what you mean by that.

Presumably you mean you find this odd as you feel it sits outside the realm
of madvise() behaviour.

But I'd suggest it does not - the idea is to align _everything_ with
madvise(). Rather than adding an entirely arbitrary function in prctl(), we
are going the other way - keeping everything relating to madvise()-like
modification of memory _in mm_ and _in madvise()_, rather than bitrotting
away in kernel/sys.c.

So we get alignment in the fact that we're saying 'we establish a _default_
madvise flag for a process'.

We restrict initially to VM_HUGEPAGE and VM_NOHUGEPAGE to a. achieve what
you guys at meta want while also opening the door to doing so in future if
it makes sense to.

This couldn't be more different than putting some arbitrary code relating
to mm in the 'netherrealm' of prctl().


>
> Let me ask in a different way. Eventually we want to be in a state where
> hugepages works out of the box for all workloads. In that state what
> would the need for this flag unless you have use-cases other than
> hugepages. To me, there is a general consensus that prctl is a hacky
> interface, so having some intermediate solution through prctl until
> hugepages are good out of the box seems more reasonable.

No, fundamentally disagree. We already have MADV_[NO]HUGEPAGE. This will
have to be supported. In a future where things are automatic, these may be
no-ops in 'auto' mode.

But the requirement to have these flags will still exist, the requirement
to do madvise() operations will still exist, we're simply expanding this
functionality.

The problem arises the other way around when we shovel mm stuff in
kernel/sys.c.

>
> >
> > 4. PMADV_ENTIRE_ADDRESS_SPACE
> >
> > It can be annoying, should a user wish to apply madvise() to all VMAs in an
> > address space, to have to add a singular large entry to the input iovec.
> >
> > So provide sugar to permit this - PMADV_ENTIRE_ADDRESS_SPACE. If specified,
> > we expect the user to pass NULL and -1 to the vec and vlen parameters
> > respectively so they explicitly acknowledge that these will be ignored,
> > e.g.:
> >
> > 	process_madvise(PIDFD_SELF, NULL, -1, MADV_HUGEPAGE,
> > 			PMADV_ENTIRE_ADDRESS_SPACE | PMADV_SKIP_ERRORS);
> >
>
> I still don't see a need for this flag. Why not the following?
>
> process_madvise(PIDFD_SELF, NULL, -1, advise, PMADV_SKIP_ERRORS)?

I don't think iovec=NULL, vlen=-1 means 'everything' in any other interface
anywhere else in the kernel? Why would we reasonably expect anybody to
know/assume that here?

It's surely far better to very explicitly say as much? The idea with NULL,
-1 is that you're making sure the user knows any provided iovec, vlen will
be ignored, and better to just disallow the user providing those at all
(similar to mmap requiring -1 for fd for anon mappings).

