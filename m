Return-Path: <linux-arch+bounces-13241-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE70B2F4EF
	for <lists+linux-arch@lfdr.de>; Thu, 21 Aug 2025 12:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594CC3B9580
	for <lists+linux-arch@lfdr.de>; Thu, 21 Aug 2025 10:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC972F4A0E;
	Thu, 21 Aug 2025 10:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oBkG/C74";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZcjR1DiB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95622F3C3A;
	Thu, 21 Aug 2025 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771138; cv=fail; b=FfDyLx6S7bKfjOU1y9xxixq5ShPusXABkkynmDVcBTmM9AgFCYbJGZfXuQAdoUr8BESJseHaPGdBPraU1E76esa9qafGMtQHTGB7ucCQ/KQyHhZOK1pH46DtBMdsE5Zv1EKxg6dFeGraQ0A/VGxMcf4G6qeqxzHb3eZMyLBiYJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771138; c=relaxed/simple;
	bh=kqg0QntLA2rm6kVaWH3FA4ULLkWnAw0x+KRASlx166w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aQBZ4NjmN9EH2UToiYsEl52ROgKe3f65pHecegEzddWXlaIk/0StXIis0nbbTkUDvYn9hQHrBtpiYXNSBApqZXa1myGJmfQWfwPkYas1GE2vSB6k0plZVuujeFjd1UW9LXxuyBr5TjdBDME5xq/MQ3E7fceAYnzUbSNC5Wwgakw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oBkG/C74; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZcjR1DiB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L8VlaR031458;
	Thu, 21 Aug 2025 10:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ltVPbZUqF27tRJTFat
	IuyPYlZy/6JNv0tswp7kIGsZo=; b=oBkG/C74QwZiCjxVl+bhJ/CfTd/FZRT3e7
	IbrjYYsk57d/OnWXUVlpjvRzXkXbyqMc5Wftv4XwhIFCX1Vsw6EVCUNrNkR46DS/
	L+0BC7WOl8YEy4ulHBEoe4f4dvtvlgi/l7VUiuuCA0FeS4awVXZmbqOzOBZuO8uW
	HAZstwoIxk44Wh39Oq8m1S0bXUvrOUOcrVCBhUsjlroxJZ7KzcLdQ2nirxEZzkqV
	63tE0zIPJ41rgkMVdvbr0YUrbxJTqmCsOfV28bEx0H9DS+ThfkEOtPe3n1BNS0TP
	PsUOrZ5yXtko04gV6MEYjR+CfXM4KigVKOevlFQgCkdCBmIS/lvQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tru6gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 10:10:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9HVrx030481;
	Thu, 21 Aug 2025 10:10:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my3v6cs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 10:10:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHaeODQK8z+BKIS2LOijOVLkT45NutcPVgobtRJC9Ur0BiG2MfDiSZpjpyjMugElNrtRI5jc+pcqUck5DVvNq7ezmRASDk56Uye93XCRy0tpt/fgYUX5v6UsRDHzIKstIpkyLh3JNOpPOF18QTvHOtZLlRXructof4DTAtRYw+yl7rVOInBkON9AI0etsnr1mS9zIAlkGSofNu6rsEtjI9VuRooqLeUx5v+JE5ZG9pVFo0wk28QLubq504vuR8Po2F3hQY5phqljUAvgQF6nhOknhRe5OniaToTCkdGemvlrzEQySnYy8jnl56M+q++pHqRO90KJI96Y1ZgocLVKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltVPbZUqF27tRJTFatIuyPYlZy/6JNv0tswp7kIGsZo=;
 b=nxAuIgmWRQYxVauxgJ2c2bvK3lx9aaEd1VH6zlVj8ap+TRB/m5+qiXe8J7HGaXW00Y/We7/ZNIgSYoWi6qXzH7NfkjbSLhZ4GMUrEYs62SdyHyFLKycrz1sPmmNosu5dTZY6bUSirecspdoCr25Nq6ThckdHFkHYpH5fkedPGog/elf0Vkohim3+VhFKJk/D7M8IlfEeZjC78lalKilUROe7WF2pfpjX52DFK6l/Mhq/PwqOrMsL1OuuZ+6URG3OeMAoCXHCwBDekHhvU5FNY/vxPi9JzFLyvBHnjD2JsVOiBqrUsTmUsf5L6ij+tRIVpdnITegXsYw5wwtXyXwMAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltVPbZUqF27tRJTFatIuyPYlZy/6JNv0tswp7kIGsZo=;
 b=ZcjR1DiBGjiqWhIzcmeMeSYAK1WgdOjDTKp58w3sf7MSa0bJwLG/fVDcWHIEDJu4oC3HtsiGmETTpab+DlnWcSKyI0cf2/95mtkHEVvPl2ne+Ep2q526EAq9jJxlnRibe+mXpNO0CfjyuF2FByaWCa3D9WIRzh4R7Ifp7rp4oOI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH8PR10MB6339.namprd10.prod.outlook.com (2603:10b6:510:1ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 10:10:43 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.024; Thu, 21 Aug 2025
 10:10:43 +0000
Date: Thu, 21 Aug 2025 11:10:39 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, andreyknvl@gmail.com,
        aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com,
        apopple@nvidia.com, ardb@kernel.org, arnd@arndb.de, bp@alien8.de,
        cl@gentwo.org, dave.hansen@linux.intel.com, david@redhat.com,
        dennis@kernel.org, dev.jain@arm.com, dvyukov@google.com,
        glider@google.com, gwan-gyeong.mun@intel.com, hpa@zyccr.com,
        jane.chu@oracle.com, jgross@suse.de, jhubbard@nvidia.com,
        joao.m.martins@oracle.com, joro@8bytes.org, kas@kernel.org,
        kevin.brodsky@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        maobibo@loongson.cn, mhocko@suse.com, mingo@redhat.com,
        osalvador@suse.de, peterx@redhat.com, peterz@infradead.org,
        rppt@kernel.org, ryabinin.a.a@gmail.com, ryan.roberts@arm.com,
        stable@vger.kernel.org, surenb@google.com, tglx@linutronix.de,
        thuth@redhat.com, tj@kernel.org, urezki@gmail.com, vbabka@suse.cz,
        vincenzo.frascino@arm.com, x86@kernel.org, zhengqi.arch@bytedance.com
Subject: Re: [PATCH] mm: fix KASAN build error due to p*d_populate_kernel()
Message-ID: <60f006dd-3bdc-4418-b996-e1d31ec0eded@lucifer.local>
References: <20250818020206.4517-3-harry.yoo@oracle.com>
 <20250821093542.37844-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821093542.37844-1-harry.yoo@oracle.com>
X-ClientProxiedBy: MM0P280CA0009.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::24) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH8PR10MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 8116dd69-e966-4245-1b79-08dde09afcec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?COf1ixv7zZ+BHXwoST0irT0A17AeiSf8U4QVlx1Kf8R1qXWBBdN+f+u5GDO+?=
 =?us-ascii?Q?ZqWgWc+1avp81LA1MFLdssWK358Iun7uizeESdQG8x3o6HEXJ0g6gkgclp7C?=
 =?us-ascii?Q?h8uaAKq2Dkz2whf9E0VX1c6pcaUwckCrbKXYJk7Ufz28s5CarD5CdTTFyBj2?=
 =?us-ascii?Q?fKtc2i+qAx+NsMCI30OvK7m6GV8EAMch06NMDBd7PIVndaYP5HMey0dLkU3I?=
 =?us-ascii?Q?/5FkJ7/JUiwhV0vib18UhtCbfP923krqDYeLkQdJxKkf3nW/XZaaxUXTo2je?=
 =?us-ascii?Q?DYftY+0xeNi1IKLLyvYmt1xNqGRDcznn0NHa8Pq2bGWBTPRMh2xuNl/NWLzX?=
 =?us-ascii?Q?uov93q13zoke0fyfV81va5v8eJ3uoD5NxTbv3utisdilQ9Q7/ckC4eH8aoGr?=
 =?us-ascii?Q?qjF1WtPp1VpgEORA6x+ydgZemcB0UG489Y3wpaYR+wxK2LOUCMe+/JBn1VyU?=
 =?us-ascii?Q?vAM+e96n/dKM8ygLCEkzkMDEVNTstk0kYT0sYOygzw7kvZUs/yIYy2MKTBli?=
 =?us-ascii?Q?U3D3M/rwJo12nyJ60xAbFL57MC96TISt6rUk1u7ZtXkPbaIoSf4dVnsJtO7l?=
 =?us-ascii?Q?EdvQL7j8gBw0rwe4ub56yU24TVFMno7Q0OQFihpGbIMfb3oyF2TPucRYPDIk?=
 =?us-ascii?Q?5Og7z7T9xIPNbhIG2a+4XyaP0Xx9jGhN6ylD1uOxQd+zEG9zki49HqfFlQ/E?=
 =?us-ascii?Q?0JrmqOHapdOv+0CB+WrclN5+kVyR/+8g0F3NNhAq4WS+NVlZpBd7PiRcSwTR?=
 =?us-ascii?Q?5wh39dajUfGY4A5cpVc3cgvhdk9tysjpfplnZ3dgKDUq3N+Y/3oZ1BgaKRX9?=
 =?us-ascii?Q?3H2c8pmZm+SKy+BNuNp1M/Psn0nzPOTDeE8kLY8wbYWfY5D4saoPAhBmsysP?=
 =?us-ascii?Q?PbKsPtpt1JFQwehzj8f7xpnF1FDChdAyQBupBqvygNUonarQuEil0O6qGwU9?=
 =?us-ascii?Q?cNesGKuoSbj8eg4VZpB8KjpHntlIs+kW4c8y7CIS4V/ijAWvcdVTcg/s3jyL?=
 =?us-ascii?Q?lYcE7vm3g0bKvOwcwxFazuWFB35/RDSMeRUtXvFWIq9ZZcbjKqbj2R7z1ed3?=
 =?us-ascii?Q?pnHLzAeUao9kiWAXwtqyDduwrGeIbIZJ9aIqCnNqQxS6DDMjfRlKI2gbuGnr?=
 =?us-ascii?Q?8WG0yiss/SxBYq7pl5bi3VQEUE7HqwNRhc4LmKjGzFmD2EOAPLcACSt3Kq6+?=
 =?us-ascii?Q?S+qsaR9tBW2nhJSia9rOdtnaxnU0NdCaiSbhQ2zbE8ERe8fkUqnCUg6SknEO?=
 =?us-ascii?Q?uclExnFRnQdwPdHAb2lj1BBu1H40z7zr5w7/XUHev1iyQJprpBogRch2Vj0/?=
 =?us-ascii?Q?lwLWGT2wmuDtU4T6hq9x32vb5GX484nZUxaXPwF7alscPP8S0uYy3rBGbtl5?=
 =?us-ascii?Q?ydj74MM1aiBfXyIEgVhRyX5DhOF5hFvWqcwtvB4PvUrb2JtqLQAvrXG3hmwz?=
 =?us-ascii?Q?1v94CUXjCSs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b2C6PRphTqRimSAMn+8VI4uGWFmCUfTTiQwtyUn+dSvO9SknjK9MsJJ5cmm0?=
 =?us-ascii?Q?+JdiU26LokBV2phS25Xc5Pds7z//exCuylMT9N9p8mQCFvRo9rvI5JHb9eBt?=
 =?us-ascii?Q?/yH/LeHdmpw4tRFhxAfkzTlT2TibRv6Sl6XP/q1dG4wyJvJM6q8a5kC4scju?=
 =?us-ascii?Q?9a3xZg7b4y0QnHaGm+scQJ0U+d+64/4MCcoGYNfzgEUgu7zykLMfoGB2okhP?=
 =?us-ascii?Q?QVlyHW1LylSvxK5WfxPsQRpavuvwXFdFhCX0rypMmQou7Q3887ZTbinudYqJ?=
 =?us-ascii?Q?2j5IDg1RmBf/FfzussuJAWoo9XvwsY/26a6VxWG+aNUU1N0aS/5KNsp9+ztw?=
 =?us-ascii?Q?AOskrgAKdDbjRrGMoWVUfUInMe5jWSVle/nT2PADb63vqAEruTbJbzv4ih4j?=
 =?us-ascii?Q?MLwAQk5WqcMooxDPHh5V4Kq9zSRBzm71CyGQdgtSw8WwvO3r1EcBVNLdMSP4?=
 =?us-ascii?Q?mnF+gMvK4B+EaEmM2Kpe9M+LN4pVy6vcYLgA3RTRcwZ2ImAFeGdwZPR+BYcs?=
 =?us-ascii?Q?kfhWuXk8WyuNBb1mKsDnQXB8sm3KWz2g7/bA5VBgOMCV7pSu0A2v5J2Fhh4X?=
 =?us-ascii?Q?WawIeaC5TtifD67FFbGODrcCvQLezPa9mhCGpxn410fCx6UmWx4Vw9ZPXKY4?=
 =?us-ascii?Q?jjXWgxSTnuX+SmWgaId5tP4P9EmJTGo54ZxEv6DkTmwxTjZLejKxqRvXdO7g?=
 =?us-ascii?Q?8PwwOSxRouO+UpxL24BLpc4OvuSbF37bA6RYolO2qCG+5ytHUuJF3VIv0CSQ?=
 =?us-ascii?Q?TI6LjvY/6O8blmzKnwd0khFSetXj06L/HITRiU+djgQofTDLVB6Ms8zyview?=
 =?us-ascii?Q?/Q0lkDnA+Z2kn3GedEFvZhpo0j2ncJW7KrXM+PBMrP170BrsvuvjIoSvIq/R?=
 =?us-ascii?Q?eK8xGoAkWGI3SiFn5/GVxZDdkED+0B5nQ5fxoJe9ZSLo7cYrEwkD21l1SmoD?=
 =?us-ascii?Q?DZn2lfuhGLETLpzEp0Ho4cVTCjFjjdKI7yHuCB9RieW2l9rlkSdB9yONl0/0?=
 =?us-ascii?Q?VcVGc3zWcpYdYS27WUkAW5JmpUB2Uqt01mh7diDfORXpt0fTF0qjHSrCBDnB?=
 =?us-ascii?Q?imus6tyVHlXEQT/90whePDkHcUvVlg+RPexB17oDdsDh6au3cBN+jyO0PmGG?=
 =?us-ascii?Q?wupD2P23W/kX+nw/3QYjbQdyxJSeyPqJOMBmsTHi+Wtzknokyl+TqJcOup/I?=
 =?us-ascii?Q?O3v2bGw3NgiOFEFtLNNtAqjNmCIrK2jVdV59I3DQIjs01Ia/Ot8FNMmPvCkO?=
 =?us-ascii?Q?vHkeSWWHcSE2u508ldWqm/9ThKX8XBm2/iY9L/NL33dXhM9clUBvbw3IDcs/?=
 =?us-ascii?Q?YYUjzw7SKrjlKAERRhJrJqNjlT6yXf6nUHo5+I/CBFNG6YUEjIogeWPoaLyp?=
 =?us-ascii?Q?IDairDQqVkaZUXGmia+nAF4nxkrsMdTxZuyjwVlpQLqm+Ngi5tjXroPCB8Vn?=
 =?us-ascii?Q?sF8+q7kOdRsbRnNK3x+LEP9AzND9xOkb7diuO4LWpP/+ZY7z+Yd7QHGHuxeT?=
 =?us-ascii?Q?AK4v5ghi8QhBFSeLTyAzhy2BdD3/5zmv5Y4TKS/qC4mI1l4iSaUd3RiEFvye?=
 =?us-ascii?Q?JSmOzzRlvWWsUANmEUxzDl6oH/65G5SW+fkkrEyD7QfweCz5iF63nvIWo5Ot?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JDiHA9MfoBUdFlEQ03zyFr5RyBIz0yO56K0BH/VxuOfnM7cPHXN8r8Gcjgda8nULaK4MVF54s5HAbgSSzXwj5TrQXuTr1QofJ6dEjCkoY3B1drGwLkcW2lnqXvvbbfFbbs1J2CqBR6BtOF4EHTsBRfSywRFPklixxygog5UU3K6Y9ynLLV2guQKDid/kKe51mUm6LXjoWJVTulFmX29NIzmCh5cNCMFAx/Yd0KCBdjTdf3UoQGn8I4ptyB0klgBlm1D4Zy+6JS6ZNlmSiik+0L3XYAH44zeiTB7Y7deF7nIKHYMJc96pLRYUYgX54+XDb0r8GVG+5dILhWpKC13aQbu/ZzuaolEtrEK1LlhWml8/Nua7aa2vXgrylVDqC+P4fACRM/HomqQZ5aa/LTt6I+gJ2RBDByIeCF0sXQaojmKkjosFco8jdjuiAKZ9adk4V/55WmM8/VYpI95xOjEwJkqZjgXkX1R1YplBTh9K0A0jvrBQHJPrPYamqF0r1fsLQJF6mSaOAvt+WXCS2ewtb/Nkq28DoV9ZGy1EMpgKnkFMmhwDnEFuUBlaZerYJXalRXslINhFYNp5EXzj8D+nEIVvJWrRA5YIutnRq696f/g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8116dd69-e966-4245-1b79-08dde09afcec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 10:10:43.0082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XxZIgZ+f4JzekLPCNI/C9a5Nm3F4jtrwT3HGRL9Fi6Mjn5z6vtudRWvGig6WboTwIOmJEx13QS1ieIMsL/cz8e4ubRzfWndfdRQykyRGH4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6339
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508210080
X-Proofpoint-ORIG-GUID: N6Wdq8V9RGWz-TLLr8I5n7KNxbWDH-EL
X-Proofpoint-GUID: N6Wdq8V9RGWz-TLLr8I5n7KNxbWDH-EL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX+GtFvjQMWrYh
 l9sqPeJlcdbujwVuTqtqzmAboOSonab3CDpHBToDouV4YoVfm6Hl+GvEf7ldVBnoLWYl16I6IX7
 RuNsfhOlAzC743wir/IXlQpJR4FHfy9rug4BQJ05EENcKY2ryJ6xPD9ZTzJJXuL43KdUljrDxeF
 c4GzyxLXMJIkO5fh3K5FyuwfMPTVcyHNXzRif/7AtNJe1d+43xwoFdeKLRGer/6THEZg5rSHtg2
 inMlizt6Ln3nh8H9HfqY8vWr/IvxH2Js/0ovul/c1XD9Y/DmdeHsPMdL3pxcIyFVFlsrmbGoMtF
 U02d9DY6hbOQI+btiWi4h5nzBVKMeoT4rZqtlva+2LIkM9CCmSZjxvONt/QRzesvCefBRJta9vp
 zwSNI+6mpeIkkUA9uyWzLmlIkZwjcoCeUgpCcKUqbfjdTvldXJw=
X-Authority-Analysis: v=2.4 cv=Qp4HHVyd c=1 sm=1 tr=0 ts=68a6f0a8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=EE_DJVtAWmZg0WeozEIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600

On Thu, Aug 21, 2025 at 06:35:42PM +0900, Harry Yoo wrote:
> KASAN unconditionally references kasan_early_shadow_{p4d,pud}.
> However, these global variables may not exist depending on the number of
> page table levels. For example, if CONFIG_PGTABLE_LEVELS=3, both
> variables do not exist. Although KASAN may refernce non-existent
> variables, it didn't break builds because calls to {pgd,p4d}_populate()
> are optimized away at compile time.
>
> However, {pgd,p4d}_populate_kernel() is defined as a function regardless
> of the number of page table levels, so the compiler may not optimize
> them away. In this case, the following linker error occurs:
>
> ld.lld: error: undefined symbol: kasan_early_shadow_p4d
> >>> referenced by init.c:260 (/home/hyeyoo/mm-new/mm/kasan/init.c:260)
> >>>               mm/kasan/init.o:(kasan_populate_early_shadow) in archive vmlinux.a
> >>> referenced by init.c:260 (/home/hyeyoo/mm-new/mm/kasan/init.c:260)
> >>>               mm/kasan/init.o:(kasan_populate_early_shadow) in archive vmlinux.a
> >>> did you mean: kasan_early_shadow_pmd
> >>> defined in: vmlinux.a(mm/kasan/init.o)
>
> ld.lld: error: undefined symbol: kasan_early_shadow_pud
> >>> referenced by init.c:263 (/home/hyeyoo/mm-new/mm/kasan/init.c:263)
> >>>               mm/kasan/init.o:(kasan_populate_early_shadow) in archive vmlinux.a
> >>> referenced by init.c:263 (/home/hyeyoo/mm-new/mm/kasan/init.c:263)
> >>>               mm/kasan/init.o:(kasan_populate_early_shadow) in archive vmlinux.a
> >>> referenced by init.c:200 (/home/hyeyoo/mm-new/mm/kasan/init.c:200)
> >>>               mm/kasan/init.o:(zero_p4d_populate) in archive vmlinux.a
> >>> referenced 1 more times
>
> Therefore, to allow calls to {pgd,p4d}_populate_kernel() to be optimized
> out at compile time, define {pgd,p4d}_populate_kernel() as macros.
> This way, when pgd_populate() or p4d_populate() are simply empty macros,
> the corresponding *_populate_kernel() functions can also be optimized
> away.
>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>

This looks good, other than the nit below re: a comment, I think when we
are doing this kind of thing it's necessary to spell out plainly why
exactly we're doing it because it's not obvious at first glance.

Anyway have checked locally and all good and LGTM code-wise so aside from
above:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>
> While the description is quite verbose, it is intended to be fold-merged
> into patch [1] of the page table sync series V5.
>
> [1] https://lore.kernel.org/linux-mm/20250818020206.4517-3-harry.yoo@oracle.com/
>
>  include/linux/pgalloc.h | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/pgalloc.h b/include/linux/pgalloc.h
> index 290ab864320f..8812f842978f 100644
> --- a/include/linux/pgalloc.h
> +++ b/include/linux/pgalloc.h
> @@ -5,20 +5,18 @@
>  #include <linux/pgtable.h>
>  #include <asm/pgalloc.h>
>
> -static inline void pgd_populate_kernel(unsigned long addr, pgd_t *pgd,
> -				       p4d_t *p4d)
> -{
> -	pgd_populate(&init_mm, pgd, p4d);
> -	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)
> -		arch_sync_kernel_mappings(addr, addr);
> -}
> +#define pgd_populate_kernel(addr, pgd, p4d)				\
> +	do {								\
> +		pgd_populate(&init_mm, pgd, p4d);			\
> +		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)	\
> +			arch_sync_kernel_mappings(addr, addr);		\
> +	} while (0)
>
> -static inline void p4d_populate_kernel(unsigned long addr, p4d_t *p4d,
> -				       pud_t *pud)
> -{
> -	p4d_populate(&init_mm, p4d, pud);
> -	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)
> -		arch_sync_kernel_mappings(addr, addr);
> -}
> +#define p4d_populate_kernel(addr, p4d, pud)				\
> +	do {								\
> +		p4d_populate(&init_mm, p4d, pud);			\
> +		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)	\
> +			arch_sync_kernel_mappings(addr, addr);		\
> +	} while (0)
>

Can we have a quick comment above these explaining why they have to be
macros? Thanks!

>  #endif /* _LINUX_PGALLOC_H */
> --
> 2.43.0
>

