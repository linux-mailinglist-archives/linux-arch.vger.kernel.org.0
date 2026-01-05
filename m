Return-Path: <linux-arch+bounces-15656-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BE2CF2EB4
	for <lists+linux-arch@lfdr.de>; Mon, 05 Jan 2026 11:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA7873035253
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jan 2026 10:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5462F5A0C;
	Mon,  5 Jan 2026 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IwpRMzVQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lT++MOVJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FD42F0C76;
	Mon,  5 Jan 2026 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767607646; cv=fail; b=dUKSJIKjfy7lv+5+t/199QK80NS5daoVEhZlN/Et0KcSSn8qUfAzDHRoh92swLctvzoiZ+BbuHcMfCHjdCd4TcHihvogoSZFu4Ea9o9KYGNLkSveVNwfDzLcgaW5xDzhl1cLRH3ZPGdlt8yuiFHb6cgDmYbfvnWGzpS7KkvNG7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767607646; c=relaxed/simple;
	bh=v6o/rBYzmDUFTzn067kgYY4t3ydTDAR6NObNKmPr8q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dNEJ4S765ZodoHcNUHM2vRfgHEWARlnAFBheIjEXCppje0FLiVjyp1E3X57mAOF83FBZgWMyoz3k912+IL6B4XLyen9Ly8STO172I3aMHKIpIVv/Fk4I+6LiQLELDoiIjSBkuCnidvUeIYOPNoPQ/Ipi0xXx1qv3acC82pdhP7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IwpRMzVQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lT++MOVJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6052j2I8231416;
	Mon, 5 Jan 2026 10:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mGA1fVdNidY79+CZwvG+8GAy7O5q9qmSGiHD40yust4=; b=
	IwpRMzVQU5FIfcLXZgECNBVgP3r2PeQFqR0BFpeIdU5iyWniy0nHXeSSecFLWPa9
	i190CvQGJclFRUy9dYY3TlC3IJWmS7QMwD6ClaPGZbiLjDrNUykVbwqLzNV/Eg9l
	kPPPvhOyxFD0Wu5JlUExf3nYBW4nU98FhxqExb0tNTFK2Xhl6lihVBKLpLodLKx3
	zY60s+8Nuu6MuJrK1pGZAQde3r9sed2uh26l6slbyAXR3RNSphNXXg3T7THzmJto
	7LWdQ7Dbjyb1M8L/T5p9NIILYelPDoTPKZQcZ/FyR9cMZuLiyeAm6/rSAP6MX4Fu
	suG3qux/MHFI5nDGg+k8PA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev1t9f9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 10:06:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6057aivl033967;
	Mon, 5 Jan 2026 10:06:39 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011007.outbound.protection.outlook.com [40.93.194.7])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj775m9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 10:06:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3dWzsfClsIMOc1C7p+MnIJjtmXtYi8skeBkyymT8IY4bMUsUfKBluOc7M5CQekfJ6d+CMA0tr4I4BDLf/hkSqMlloo5taEHj6Tf3yr2fFhdR//iTLF6zHk0tf1pdOXIdZ4vjPkccgQEhp2mnC9+1IFcl/06E5PX5jMy8vMMthITIyy2yHtu5m82G/8w46pPB/DIKtQI4iVPJDnwC4AlPM1okZ2j4coLpyRPI91QNLXjM+wR03VmXq8sac34DF9YcBEOasbit6Dj8hsZVeyboC+92MO5ZdTTgZfXyEXB8wzkfR4Df4713S05Lq0DBUZm8AgtmlzF2GSVWXKlhiLS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGA1fVdNidY79+CZwvG+8GAy7O5q9qmSGiHD40yust4=;
 b=dkQNQlDzQBF1Rs7y/NITPkRalAVzRkgFmGzC8ywI8cYYLTXI55Set0MwpKVQua1T1y1DcuzFaW2lbB73jioppLjsNdS34xPIC+dNoKWNzi0CZrEie/3e+yqGI5ki2kMO2fHfbZ8BqlLxqlonGtgcEknkha5Fo58KX0ijLYCFGXCR3vU9aYujP1ivF1gBfGsy6UxkupezU8R/plyGfmsW9QvehhxutemayqPWVL2ndOG0WB9hyUV08bBUDzCD8AsVbwHTQof8YBjz37z6NrDtExYNBA6L15fZvRqTibpHTSStPhv/xz9gRTsY5lkhixvgjXrlYJ3FmfqWLOab1Ym1KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGA1fVdNidY79+CZwvG+8GAy7O5q9qmSGiHD40yust4=;
 b=lT++MOVJBgHXo+l+38Jd+XbL6mkMkjXUnB8zKMXmplhcaGi33KLgOUaw06up/nPf6Hl9mrOpYaCPbsQhsRdSea1l93zhTAV2bydVbZy3FF3Q+CbW7WExb7/EFM/E7L3ZO9jfZcQDWro8RZBLPZOM2bA91oPbParPKYTH5zJJYmo=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CH4PR10MB8076.namprd10.prod.outlook.com
 (2603:10b6:610:247::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 10:06:37 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 10:06:37 +0000
From: John Garry <john.g.garry@oracle.com>
To: chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com,
        tsbogend@alpha.franken.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, arnd@arndb.de, x86@kernel.org
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        vulab@iscas.ac.cn, gregkh@linuxfoundation.org, rafael@kernel.org,
        dakr@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 3/4] MIPS: Loongson: Make cpumask_of_node() robust against NUMA_NO_NODE
Date: Mon,  5 Jan 2026 10:05:46 +0000
Message-ID: <20260105100547.287332-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260105100547.287332-1-john.g.garry@oracle.com>
References: <20260105100547.287332-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0087.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::23) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CH4PR10MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c00f4d-96fa-452c-7926-08de4c421cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9MtusUsgXHC2HDgW0jb2ap6MpNGm3GqRlWQpVEFD5uTUgA369WSf4IaNRUFa?=
 =?us-ascii?Q?f9tGCA+HmRqtNjluDmqQ0x0nVcfr9MO/pEbUlTzTFzCUeWOHd3AtR4VbmzDw?=
 =?us-ascii?Q?OB3Pcvq2v7dNHhk2hKGeCdZwG2f+BuChuD1fDWcveP7z1VYmJpGvllRug4H1?=
 =?us-ascii?Q?O14lVDHrqebxE/BSHQzpckhsyfi6FFE+esgfqb4FOLyYOcfaR9TwDc/5ln+M?=
 =?us-ascii?Q?ssa2zaCi+UlNOF8ihVwpeWXE0RWj8CMdelNqFqwxEWXUXa478CnO1Snte8Ev?=
 =?us-ascii?Q?1p3v+NmfJ0w+WSirVqyFmaViBSMGVHYY2eu3BKW88vbRX9SWtXB367dien7l?=
 =?us-ascii?Q?D8StRqlza0h7wOyOlSt7WGt3fF2+VPUYGWSseHJ1P6UleNNetADacrKjL+j8?=
 =?us-ascii?Q?1VYajprDN6w/QZ8TooevHE3faXWEFoTmGb3daP2W/IZXkef2m4nwYWmLWK/7?=
 =?us-ascii?Q?xC2aHvjhJF9ofz8GuRv7wQe639vx21UmcZXzIzZoEa0LNnWbCZphRHIz7vcC?=
 =?us-ascii?Q?/+lVrKA+JieGZOfuYbLwkjuxoGKH5/WXsqTpLsWNtg2y6y1FThoL0Mem91hK?=
 =?us-ascii?Q?kKAPmFxMrXfY7xid/zIMM2BrYnh1fSz3+P+QsqjuZtwablVqVZ+uH1XpcEDM?=
 =?us-ascii?Q?m/4vDRZ3hqq/y0KYVdDSyOClrduXw9PVWQiso9mZRgyOc8gMrxLt5I1Qo/zq?=
 =?us-ascii?Q?LFsXGA805qrI+ty5sL1RFw5kyqQOAM9D4JAQgypUuz1V9FOBgAl/bamc9LVs?=
 =?us-ascii?Q?gvaY7B7Hqf3OReilddg8ZmDN7WZkhluT3WoUMmnchLZBxV5EjuKRsC/kTuUA?=
 =?us-ascii?Q?duzgYmarFgwT/WApRcnASsQ0hb4ug8ZbFXD8kY5GWM7byk80E8EMMrLHgfIu?=
 =?us-ascii?Q?T8rim1Z7k/y5LgRrpdyuxw5xPS3FLlZjh3Cb5NbPPqtESieGYlyJzVdsvoPI?=
 =?us-ascii?Q?Lep0mS+bDeC19hOEvMDdQEe3K6XU6eYEzUDBxqoeesDN2jCMbTONrtTB3CJq?=
 =?us-ascii?Q?8pR112zQ3NZ192VF8sanrb8drTlfXcqfS4kqto6bxGiillJJy6VvdUg01pZM?=
 =?us-ascii?Q?c0MG2WSRvTVhvNS9/zoYDugQuA/MbrY+wmjIstS2EqrT9Mmiht7DEW7X3xi8?=
 =?us-ascii?Q?gblIruKRXVQ9Zj8CQU6QmOpT183JnZSZDnmYON/sV7vLUYCb2mua7fqG3ye5?=
 =?us-ascii?Q?ZsUUeceG0wn7zXblrRwJox0s5OWFiq+M+VlMaJLh3RuBw0YSZr1LzvCfbBZa?=
 =?us-ascii?Q?xWYK4zGME2LWovUAOfKnuvp3JULU2QUCKmmMKtmJnJ6kHKfKwOos6c8TEPCR?=
 =?us-ascii?Q?wmPbVllhUad2jPgTFixp3GPioHpPnxQ9QclquOEW4rF57IQ/QvU3lQDs+bv9?=
 =?us-ascii?Q?3Is1UVC0wOxx362j3cccBRU2X/xPCpcM+jCd4AHAM5Wqbfer9spiVaDzLV0m?=
 =?us-ascii?Q?O1sy2nSdqCE8Mp4WPf5jfdlK+CygK+aKMQR9f73AuqAJNx2vlZIHO3h6lT9s?=
 =?us-ascii?Q?BepuAAvDUAD3swM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L8Ns4uO0exhYiF6XaQBek/7HbdTqWjuas7xsfLnsX7T20y3oOOMxQq+NAClf?=
 =?us-ascii?Q?g0/fFKUiEU80Ce45UErWiMTmXldiDucG94diFauCnns1EYbRuP8rBCC3+Ahu?=
 =?us-ascii?Q?EA5bbp5VG7Hmv9t0aLrDYO0hMx2sByXdOmJCa5a2YF4duUSIjs8rtNe7SmGt?=
 =?us-ascii?Q?gGeeTty7TIsYJP6yg0LcU50GR64L5UqAifU4Pmnqs5V6J3SHKfqliJspx3l1?=
 =?us-ascii?Q?p6woLJs937PkE+0+oL2nS4HGMrxY9lTRJGqShPr6/KAm3lKDBH7/ZzdT2Y4A?=
 =?us-ascii?Q?5+tfPwBlXRrfbtqHinmYmQJSgoAhyDN17pdouC7vlVOCrTA+NL0bXrTp7Ldk?=
 =?us-ascii?Q?3bpcBzYGbdQaZ/1rX2USmJ2bvIFZw8jqn635Ryx7JcxuKHvb9dZd51GEMSpA?=
 =?us-ascii?Q?XoAcUUK7fYVzGkoMrMxvoGtaVhRY13awhzu3vVLWTKQrJ/I0JG1pEttWHCs1?=
 =?us-ascii?Q?0yJLr4/9kwOYjQzA5U0SIjYRL1JvXIv+X3mI/cEsNNl0V0w1fF9C6qHF8U1O?=
 =?us-ascii?Q?VDhASrt5ue0CY5Ak97wrmFFy+U5ZGWs2FaCyzXKLFuRMZabgtUhWSuLMA5kf?=
 =?us-ascii?Q?sZvZ9agS9R6AVg1Vjy3MHRMGSokLXd/DsUedUkfyv92rDB7e3s9HZZxOSiGm?=
 =?us-ascii?Q?cIMGfQLrhcrStShIpzTz10vLEQPXBuNnJezh38p3D/eljAu1eHREl3P9C6uO?=
 =?us-ascii?Q?uMQvUruttAKxvv/AwYvM/n8UaNe/IqZTXG76TCX9pnkGN/9G2NfL4ymy9dy3?=
 =?us-ascii?Q?locCPxV9CB544Ul0QZZTxitdC9Jra477ntsmeFWkI7jmQ6GeYEWiwDktl0HV?=
 =?us-ascii?Q?yKheYVLJ5OP50ZB10UiJjOVBlKmbBHf4GbNHMUj20XpxAalHX5Eh1YzEAALG?=
 =?us-ascii?Q?ix/1Jrd4sur1N9E1fK82tAxf2uA7xRwcvSPdLazrbd51w366mFcFJNYp+AnH?=
 =?us-ascii?Q?4r7F+7/DeXYj9GgD410jqBSxrNkGW6pi/gi0l53HDAw9JLmvQ8//9U4vDeov?=
 =?us-ascii?Q?aKDI9tsd5aAs7z0bkTtdZBIYbt+4NHnC9KiJntMyyKtPAl6Dkt1I5VxsXoFx?=
 =?us-ascii?Q?UOaH7znCIGL0nJuos6JMIX1cOt2lzB55E5RBC4It2vkf7q1KEA7vvpN34hcx?=
 =?us-ascii?Q?REWl4lzgOmmM3thhez1aIy06hcKGOAQqQiKrkAU9v9ubfhrFEe74C3cn86DJ?=
 =?us-ascii?Q?jrMyv28Nh9Qor+Opc5PM0mI4Sh0xeO2xf8487G0vrYNec5sCsUQrwsv6Isbu?=
 =?us-ascii?Q?hWNOEdu6Ku9eJ6OcXAZqGHmwOQemdq/H+iCOy+r0Ej2N7HttC16blQatGflS?=
 =?us-ascii?Q?nYcWg2ev7YWYqC46NM7G4Vh3hkOSyM2huhyYGQ5F+fVbH7GOFvVmCv6sxvyg?=
 =?us-ascii?Q?tmqsrfOJ1b98TCeJeiGCe/BimwptIWR18aCcBbiH7rHKL3VPV6O6kCVM2req?=
 =?us-ascii?Q?TbrCX/MqqQMVR6SW7YV8CBnNXHOpad7l/LWgnFzDhAf5Zv29lUVhOK5xbbUT?=
 =?us-ascii?Q?yO6HAfCwbQ23fJknIBn7h1GJveGOJTD5Yk7VmPhSFGYwa3idwRM4zShDU61t?=
 =?us-ascii?Q?ZVnr+1by4nhAwzxWL/BkujATYtQousGj+TLdDBvJyu4U/cyuxkWUDbPs9uEI?=
 =?us-ascii?Q?SBNfA/WgwSZb90X2dgnWj/2ruUIkbkR/q28wTYNYCV9gIBN+d68EZPO6BYIP?=
 =?us-ascii?Q?wVfuXX+e44qBqa6F2U6fOGBh+P86g0O54KDcb/KAyLHueeqWz1SoV5MBQE4Z?=
 =?us-ascii?Q?jPfOujcfAA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qvuHFnGvYQITJ+0CGKMlI31g+dCqZ5Jfa1KwsGmWTKq9BD8se5/Xvqa206ZiUlSn4a4nnu43jeYKIEuAwPGCfTc1+Pq9D7ZqmqADBI8ac1OEyMPpw2pnkREeHVqIrqoc3HYp22snBZTtjhif4aHP3MPEc2nz5kqj+L13wNfTysikxJ+unu/sH+Vi8J1yhO0NsGDWhTIa1eUq9BLidMvT6vhPlzWzf2/8vovTcETkKdSt+I4KaJEUt4FCYgSSxIALyYYlq4O82MCcatZQQvkxqR3BtE/zaNrzlARoaQOmdAmD6Olj45jf61nDcEusYUF+VG7SLDGvYBo2Yf9r4Vgs4QrMwwE7XhcB2vMZJRmrAKu4zGvQsJC3A3QlWSOTt/dEzspVuuHPQ/tqyNEhkzbrz5KRkydX8l2MOHJIfOTV3WjR5ARtP/nX2738dLsywc9bdPSzVzEjezNdKLPpCozEJ53k+hXmOyrUNKAVq2ILJkvybE7x8zcKFBvodWui245KnPfLMJtkF6CMexj/AmUtA5+ObUYSsbzngA0ZJR/+qLH4wznocdaPJ7ygxehhkzVF1Jkch13BIu1jeGU7bViZbOKvOtEybkyC0WFuUpB7/rM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c00f4d-96fa-452c-7926-08de4c421cdd
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 10:06:37.0550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCHnDMkPdOAsh2Xjz7pJpzLLoDvUtXDi/PwIn5deLF7aEu9X4qL1zkDYfuF+baCfEGwl8lve9Imij+pZTp5EJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601050089
X-Proofpoint-ORIG-GUID: bpd1lUDHQxDavD_E56QdettKgzA2SKbA
X-Authority-Analysis: v=2.4 cv=CKknnBrD c=1 sm=1 tr=0 ts=695b8d2f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=03khOLM81ZsWC1gh8zQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA4OSBTYWx0ZWRfX5dF1J2nuCrgq
 gqrP2XOdFMY2WED52fYxLs+pGfvjG3n1nQL/Q1Ou43JseySDEfhec1FcE4/TBeOc9nezBFcv6f4
 xIZzDqUp875EFohNJDHHbIjrzwLZQ26fg06Lim0eoDephuVkEGbev2Naasa2mQNrq+JcBCmtGGg
 z3CsKkmfW+sLIv+/cD3qfqSkntYqYNqvckBEn3D5DT3v/WHy7yDxYx89TZODC83soU8riEunWLJ
 kOq001shM75XzppvC1azv851OC4eV4/kr/SW8cxvUUfpidfD1WSeYWz1kVb+P2u27ygLU0IUgDC
 4Lk4pJbGSW9NBHgKUTeI3UGnRdzirTuch5U9AH9OVIaZOYC+4gD5OvxbUc0M/yTXhUuG4ewenAA
 BfUIjWK0lsIUW+vOsMQKQLtsnCCCG9Wi0r4pPC+ByBxkeiSF8uU4gn92uMcp4ugNQVlMmQzDaRb
 if49Fff5LeTW9B+TH1w==
X-Proofpoint-GUID: bpd1lUDHQxDavD_E56QdettKgzA2SKbA

The arch definition of cpumask_of_node() cannot handle NUMA_NO_NODE - which
is a valid index - so add a check for this.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 arch/mips/include/asm/mach-loongson64/topology.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-loongson64/topology.h b/arch/mips/include/asm/mach-loongson64/topology.h
index 3414a1fd17835..e897dddc1366e 100644
--- a/arch/mips/include/asm/mach-loongson64/topology.h
+++ b/arch/mips/include/asm/mach-loongson64/topology.h
@@ -7,7 +7,9 @@
 #define cpu_to_node(cpu)	(cpu_logical_map(cpu) >> 2)
 
 extern cpumask_t __node_cpumask[];
-#define cpumask_of_node(node)	(&__node_cpumask[node])
+#define cpumask_of_node(node)	  ((node) == NUMA_NO_NODE ?	\
+				cpu_all_mask :			\
+				&__node_cpumask[node])
 
 struct pci_bus;
 extern int pcibus_to_node(struct pci_bus *);
-- 
2.43.5


