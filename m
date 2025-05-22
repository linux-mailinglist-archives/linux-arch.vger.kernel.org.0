Return-Path: <linux-arch+bounces-12078-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E91AC105A
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 17:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74A937A307F
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 15:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056E7299ABB;
	Thu, 22 May 2025 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RSYrmWtj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="alkjX0uT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE89299AB9;
	Thu, 22 May 2025 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929217; cv=fail; b=uNg09C0ymdZWXL4CheFrXN1tapexREumeg30uFoZRHp4gjTSeqFrS1Yei/t59YA+mXs48SwFvV8khz31cI0Y45wy0lVY8P0mF//GLjoPkxLdoAt1C0ut0yhmlTH3ysUd/E87kTl8cxF0+xAsiDRL6NctADUqHFy9NRoG54HIrcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929217; c=relaxed/simple;
	bh=F6mEbMmv5B+STEA2BqvcRj+ChhkcVrrwmUQZrTteN8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AuF9kesWdm28F2Iz1qe/d3zOUA+PMhITNOF8w2ljtzpKwqlGyfHEIysmljSevEoM05zow5PHI/QEoR/dWgsDUlkRCROBhUElGZlnDRk8yvTD4C6fO9M7KJXo0K7udhMtpG5KZCkwZwc74r5yRlVbxYOr7n//CB/gKLrEO4wist8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RSYrmWtj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=alkjX0uT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MEtsdt008007;
	Thu, 22 May 2025 15:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=F6mEbMmv5B+STEA2Bq
	vcRj+ChhkcVrrwmUQZrTteN8I=; b=RSYrmWtjFu8//6RZh/s4Q6vAYwyzTrLJAx
	Z52G1rO4TvgWWRRkl03k/0IhzWNAqov5AHP4FISGzVQ8Pgeg3z9rup1ySi2qYAdi
	ryDnTD3skNGx9o9/gvtgJE5BS2FkCNKUoQASh2OxI81hF97e5BZZWEysX3azuXZ4
	ZALvUYAmywGnDuv2wJbSpBdaBMGApEEiHtgKfwLwlDupeydRW1tViB2kk7Tx6AtO
	uEz+FQaDOkPIURJmVj5pQVJWHewgHrennV8fJasmyOF18kCZ5GeWzPtYe+AsbGSy
	s/oyBuoqKJhoyMsDz268+ziotQdL4BS6Mxz6flx6jtvBSPi9nS3Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46t5fugbuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 15:47:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54MFXXkW020407;
	Thu, 22 May 2025 15:47:14 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rwevb7je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 15:47:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azGpuyem13GI16nrh/e0m5GAQ1JAu/nYtTQVcK7tJ3Q/+HbTZUzuhOTLCke+LhfkAjWA21vpFbG0eMj8t7t5VywNnJoFiskXFW9cieD1UDrJjPalftqoHhSQ8BWplAAm6/znTyC0h/+tn339GpIXh9bop8lsovQrbsTnNHYfGh8+8SLi831dUCmfVIA5NFcCFTBOxLrfsPvFdq5SnYOW8RDQjoLhnDNR3L4gjzbj4XmEntOeZ/oXs924QWyS0Yi0kk2ri2DMsWUXxOkuaNgVSDwg1jaJoy38KMMlBihqryqrV4D8z8vcftOX5YrmCbAFpmyWDXKL+0cm5xVGMDtFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6mEbMmv5B+STEA2BqvcRj+ChhkcVrrwmUQZrTteN8I=;
 b=WaLwUMeHLL6Oy+segQPWP31wyRodWqNfwJuXIgnQ53vVVnky+A6EyWfP56Nt6KOXvliYNW4cZbWE3ndRUTEh+fQP8DCEmZBjiLp7Hs+0IsOmhzsotYFW6/jRU7zH9RUgrgW9NeQtv/zVQYO+Tj+3iZG4Tzl0Nb50ApJDh1I91ImCVHVn5AJk2JeQF4+IwtLHhgO7B03ttCdBgfsDhp2MCG8wazdXUYwdRToe/kzNnmeRD9TDphr/ZSqY7URE430Wj+ftCqEUMjrWSRBwisEpTuLx2Wg7r14arhh4lrCSWzTmcjOmTtAvOkIh+IFN0LlrEv5Kjl5nY/4eACSU1XGlvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6mEbMmv5B+STEA2BqvcRj+ChhkcVrrwmUQZrTteN8I=;
 b=alkjX0uT4yKoiPKeTzTvr5VLpV3NgAF22o03695YiYsh+/hIV6xe/Hp9FRwT2fPE6Xri77h8i/TnjJ7Ek98mMbLQdeAbW9FaDIMix4u8d4SmVIBruIfQ4KgoppMP3s8i7Uxr6giVNM8bv3jWvJhhFnAR0dyeuDUVmcxLtW3oQys=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4248.namprd10.prod.outlook.com (2603:10b6:610:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 15:47:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 15:47:10 +0000
Date: Thu, 22 May 2025 16:47:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <ad20b26a-be45-454c-9f5d-4c488d108734@lucifer.local>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
 <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
 <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
 <e8c459cb-c8b8-4c34-8f94-c8918bef582f@lucifer.local>
 <226owobtknee4iirb7sdm3hs26u4nvytdugxgxtz23kcrx6tzg@nryescaj266u>
 <7a214bee-d184-460f-88d6-2249b9d513ba@lucifer.local>
 <20250521173200.GA1065351@cmpxchg.org>
 <aC9Dez8CftbNPcbg@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC9Dez8CftbNPcbg@kernel.org>
X-ClientProxiedBy: LNXP265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::32) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a69ffa6-cfe5-466a-3a49-08dd9947e9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tOH8Sj2r1+WSt3hPGsvvcwRmW1xRlt55+Zpn8fz7GEA7ZIr15ZfT5exwvEjJ?=
 =?us-ascii?Q?oi9AHVGu3gEg6hdcVMPDs5XEiFMBtY6kaTWQ0iTdQoogRU/LWZeKy8ydEdfJ?=
 =?us-ascii?Q?BL+1wdcASQWY9cGh0jqBIKgkzOKjZ3rEgh3/g5lBQvjIAri/YPsQmJ2j51gV?=
 =?us-ascii?Q?5T7q+JAGj47PjXPqdQ2XAzlSR+H94cuqO122oil40QKNE+JmgOJsfdhzEpsm?=
 =?us-ascii?Q?3y6VqEiXmu+u+V2pt2f7ATAw1X6AL6a0MhJlB5nzxoYtEhIZfyNBz8U+PHVH?=
 =?us-ascii?Q?3WpZcOdLw+fHiVH4SZnFnkotL7KHrEBymKUPrilPi3jPQfsvvpvLr/FdnIen?=
 =?us-ascii?Q?oId5BrJt1YeWvpoiIt7RLPqbOez9A0HyCuSkPSZToL9s70g6t+sh7dtKeAMU?=
 =?us-ascii?Q?GGYPWEkLtjZpx5R/dDs+Gp2U2xYsJmlYbYuGb4FDdwlWSG0zLByIxpCRHizT?=
 =?us-ascii?Q?qu8cThZis1ffN5U1c5rpNVYjpwo9j+Nht96jHf2GWABbJjCRKcfRR9DdfAz1?=
 =?us-ascii?Q?2nj5G2mipi7xOLVpuEs7c6506cJcM57IWEQ0ZmoINDFDxco+agOcyPQV4FrI?=
 =?us-ascii?Q?xW5g6lbdN7AWFR1DcQ+cNUAHAnzLZmrMCDrn+r9vi1HRg506CDamo2jkPy4M?=
 =?us-ascii?Q?+/ngbDI3HpziSSVobHLWgpcJ6XUdOeM/dC0LH+pks4JxR169CTgtm7eFS9Aw?=
 =?us-ascii?Q?8NRPwW5dgV5qlfV2D1ep/RFt9R4XgXTDL7ODGkq8Wfubu4LTqLblu5hkS6f2?=
 =?us-ascii?Q?HLlIu8tpxufhjhPVioQL0RbkCxFDNYIWGbB1ft3bavjWBU9OwjY9jIlH4+kE?=
 =?us-ascii?Q?Slk2BaJlCdfbHUeFSS9NZuQBshJv5zLWyzISS5sI18iy6uqH95jyPMhRPJNu?=
 =?us-ascii?Q?B60Gfcz52gyqCCLKMbBVRTkIBQSpKX8ds4LzW2+lVhlDqwnXy30mAPP7XHRQ?=
 =?us-ascii?Q?0I84+FcxIp/1wJAIgM125qT6hMyXwijz9hfA4U4oA4yt1hm9rLdJWeVbI0UY?=
 =?us-ascii?Q?TMBWmzDVQm/0bhlgmVRUoC2TT4qJncVyf6er6vvMCzkgYniTk9AABxeNIk42?=
 =?us-ascii?Q?X3M3PzskGZSPhvTCike/oCAxZ/ZCJINktrNjkPvhcPXU3CcRB7Npi5m5+um4?=
 =?us-ascii?Q?D05ZxMYiIlBC9kI7II6AniScI28H0A9X60uM9UD/c5sBq4RGlmAMcF4l79gr?=
 =?us-ascii?Q?ZJCdK1AyesakPZFCEZZWHqoL4dSeLsA/SQT7n6n4KjXtKtXtzWVSyDA11Bas?=
 =?us-ascii?Q?vTyDZFFWEypannxRpvZmXJ4/56PgfeIJ8NOn8YfR024ehEL7gB8i9T7n1hkd?=
 =?us-ascii?Q?5OmzZG4W1/MfnFIg6POWSz4RXGodM1oqctNdnz8TQy8f0wi6k84m4eq+9FhO?=
 =?us-ascii?Q?qxGpGt3ZPv0y69zKR9yj0Os51ZBQ27SrLb5Lo6ThaRbjPsSRL7mbxbe0Phsz?=
 =?us-ascii?Q?1W0q1hao0ks=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KhZKFCXdpHKURpOQnBzpMTM8BOi0GHvO1YkB3yfLuLfjLSb6pmYvr20pCyx2?=
 =?us-ascii?Q?kuFHbpSl0NIuMunDy97t/stugsDuz26v+E9aCqKvEU9/+AVpPwPpMYKKpSem?=
 =?us-ascii?Q?bZLjQH8XAnjGGIla3VbN08sJ+Dyur1pKvIo8Tsdwou5WjtE0daGqb2CzJYgQ?=
 =?us-ascii?Q?WvMBXVYAACDhNRJpb9Nr04lMKblwT1DCtYfdgL33spDDP4FRw7PZPpg3Fvhv?=
 =?us-ascii?Q?iXNzL92HevF0Zo5EJSp3jD892xqYCh4J/0L88+EmpneeSvucvQ37ZCbny2zU?=
 =?us-ascii?Q?pqsWTtYNNgqwCZzbSM33pVhw7QoNxspCqgnOYssVC66aFkCsDkBUu1GtpdiY?=
 =?us-ascii?Q?4F7xYKp1gWN/CHnBcxGCQSJ6pCcclbTJ7zhHVYTkakM+fon6cHR47YsY8XI1?=
 =?us-ascii?Q?bRPenqwoT117S7nvcbwZ1nZT0zryu6R3+TAAdtla5/uAcnzr7yjOIdUveiAn?=
 =?us-ascii?Q?pxQhmhzZxwArEWlOaponYlYhwaOWgK7xcU5V02/ilcaRTD4uZffXzXKZGYvY?=
 =?us-ascii?Q?GR2Lz1vPZcmXjvQf2Wz7dYuh1D9SE+TaoN5NU/NtWtJtVcLBDnvSXuzjfM2C?=
 =?us-ascii?Q?LBPd9ckrny56k6MpfOxzA6pOPJZVAJmqVhA6hv6Pv/byjHrzcBpsfOkdyeNh?=
 =?us-ascii?Q?s9lTVUFgoQAh1LJjIcib2xnCRo1Wcn2CUjEWel+9h4wNM49WrMXPofQMi47W?=
 =?us-ascii?Q?Hc/7QmUlCsdINOjWT9jVoN2vAFaJiD+49//jGTiC4MudqXCSv32b1tUSbUdT?=
 =?us-ascii?Q?va3Mzi1xBX0oI7hIadTWbtqqhgOivPPDE+20AzE4K1LhODIpwNw4NawDGi6Q?=
 =?us-ascii?Q?aqUAOM5iHjo1edUN81Wq2e8/aZGuyrK2/BavjO1K8z+vLUb8oZ1q4QIFKLqH?=
 =?us-ascii?Q?AsuK8F0TpnsxOH+9ZKI6ZjtLV4gnompOnFeTcaZtOFKM257ELIdHg7qw1Z0c?=
 =?us-ascii?Q?NsQE5wLdbLmliWAaoXDScHS5KbAKQjCbGHbIVjtqWILehtwqcjDufaHTctR8?=
 =?us-ascii?Q?zXb4YEDiTir3K/4QSNG+r9I5RwnVHRK6roHuiBjcprbJJQs0ea4wuJeM8vWJ?=
 =?us-ascii?Q?NOPQou7w9CzQAV+OuRGytVF3ndrPMDL/W+YMAcRWwiR8zEGmyTyF1ZFE/kl3?=
 =?us-ascii?Q?0xvNFxUp7QtdQqJJIQJXfRi8In3QPBF8neLUjCjsQF8rdLfm27joBxuWkpep?=
 =?us-ascii?Q?D9+Fgzk5qYSl8N0JXT63GLNzsZqSQQVb1VN9kDh4sHi+PUwvXXl1mqB72el7?=
 =?us-ascii?Q?1GCz7k6dtgK/JZ7K+YVSgfd76caHtCoM/C0afbEGmbmVuafCIQYahrP5Pp05?=
 =?us-ascii?Q?mMyNkB6oyqY3bb9PjgSpJ2BeUa/nAKrR5npzrZx+Baz92HcpRmuAHapdm0In?=
 =?us-ascii?Q?iiGob5tAY8u3KdRRSxpyTEbIfWoc9MqHytFpKO5kTmPZOTjImJ1t036Go+DP?=
 =?us-ascii?Q?3/73qMdLJZ51yA5t159WhZeIuB42oDLK/ld6ea35vRRWVfEDaEiKo2Lif/9d?=
 =?us-ascii?Q?y33H4FfCEsXna0KJkCweLl5em955r28Eg9hw/t+EWW+hXSOdnEf2iC3HtHsP?=
 =?us-ascii?Q?Z7/x8rXbvUcdElCHffnpyRhlFXGEtM3Jra1u7H7ngopsRes1Fyew5oxOtMiA?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	69jCYVb6o71nug9hDLpO0fUuWG+yx6mASt7KdKiIb6LnLkwuKFt6BMczMtgYTfV56yImsa+01lSVNcUJPESj7ZbpxreKjTyGeyHTXLEgKlEDGO9NB+MyhT28tWy4iDZMjXEFFq2/A1v231rJq/J1oapXYNDf7jWMxFwwavS5dAszIy27UqAMfO3n5+Qk+p0U3n9ZDgg9b3viCh5sbQcfOK8hOmyqS8r9b0vLp0r/JiBqC1QWondgwcDAfazCFYnyBsRNZe9iO1Xoa6nXSYz6usfgk3fG5NuM5/erz8tx3NaQg/f6ZTK8L6f1ly0LhMm3StqoPOxfIQoMj0/y9XUxqtPgl9UDDOpfGYuknx6mYD8QwNjIxBFXjlh94bRHw2Nj8hO7auZ23LbgpJFaWc/SMnXLukYaPpr5I26r3qA7LFp6/M1tzBR9lt6zT52habwEUrP1zRO49ERjvG3O2JdD2JyarEc39G5PdIneug+u+wQUgHcZ695fn/4zw1s0AaZiQgyX5EjQH5Q3pEiS+L/ZX1sXkzitLvI8GYVNlOstviL6dgXZUN45eykTdrAGrwpBtjnsTIFDUbeYC4Tiw3YWxExtYCsQpD2TGpMfzwRAcIQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a69ffa6-cfe5-466a-3a49-08dd9947e9e1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 15:47:10.3153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyZ1370ocmyDzNpCMSjW2BxQRbXIwm2yFe3OsB3C31JwQsCIYjG6VT3szcfnb9rqvTw2MDKZCFXQ1reizsfPdV3DILmL8umHbz9YwDoQfqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4248
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_07,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=734 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505220160
X-Proofpoint-GUID: 0OOO0uM63ktkr7omaH4FBzb5UapeXb4K
X-Proofpoint-ORIG-GUID: 0OOO0uM63ktkr7omaH4FBzb5UapeXb4K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE2MSBTYWx0ZWRfX9VvxvQzaCinu HiBNmxmKDKUz8G7kd7BhHNWzxIkGuUrpuNlN7lHWDBu3CwqgWoGj3wwcXQc+lxA13x0i2SAlMdS eY6lbAu7fmQyA+yi1Be4jr19MeSAMFlf/lqBPyqsv2zuMGV2we9BuK/Ao73cAHDc/RHkTA/s1Ak
 X/XcHvZjVnqOXa9BPr+PPdik1NFfuiSe4bl84uKf3c0hGeIGCQZkP8lMZzCYpG6VOvoDgV4LmLo tdqph2J+n4SduADDfvILiuwcnIernwGfCDtXoXkV7XAtyP6DMOX9DjQhYJI0s0JuL2enIjkNCsv IKsgRz08rG/XReLEUfa5XRrAIffFGrsQQO1zzS8dkBYorel2UoRoq5jymrFBWfL3DaQWk6T2Fk/
 f0mNJjNIPQrdShmwU7JkYgD9F5H+lcP34eplc75/VQK/izR1Jg1R0QIn8C6ZeUxoNAoXfAcm
X-Authority-Analysis: v=2.4 cv=CMQqXQrD c=1 sm=1 tr=0 ts=682f4703 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=HNfeVaOBmXcFhlHGW0sA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13207

On Thu, May 22, 2025 at 06:32:11PM +0300, Mike Rapoport wrote:
> On Wed, May 21, 2025 at 01:32:00PM -0400, Johannes Weiner wrote:
> > On Wed, May 21, 2025 at 05:21:19AM +0100, Lorenzo Stoakes wrote:
> > > So, something Liam mentioned off-list was the beautifully named
> > > 'mmadvise()'. Idea being that we have a system call _explicitly for_
> > > mm-wide modifications.
> > >
> > > With Barry's series doing a prctl() for something similar, and a whole host
> > > of mm->flags existing for modifying behaviour, it would seem a natural fit.
> >
> > That's an interesting idea.
> >
> > So we'd have THP policies and Barry's FADE_ON_DEATH to start; and it
> > might also be a good fit for the coredump stuff and ksm if we wanted
> > to incorporate them into that (although it would duplicate the
> > existing proc/prctl knobs). The other MMF_s are internal AFAICS.
> >
> > I think my main concern would be making something very generic and
> > versatile without having sufficiently broad/popular usecases for it.
> >
> > But no strong feelings either way. Like I said, I don't have a strong
> > dislike for prctl(), but this idea would obviously be cleaner if we
> > think there is enough of a demand for a new syscall.
>
> To me it seems like having a "global mm control" system call makes much
> more sense that adding more arms to prctl or overloading process_madvise().

Agreed yeah.

>
> With a dedicated syscall it's much clearer that the operation targets an mm
> and it works for the entire mm.
> And two usescase seem enough to me to justify a new syscall.

Yes I think so!

>
> And it's easier to reason about a dedicated syscall designed for a certain
> operation that for multiplexed ioctl() style controls.

Yes!

>
> > > I guess let me work that up so we can see how that looks?
> >
> > I think it's worth exploring!
> >
>
> --
> Sincerely yours,
> Mike.

Thanks, I will distribute a proposed mctl() prototype API to people here (+ cc
you + linux-api also) so we can use that as a basis to assess this approach.

Thanks!

