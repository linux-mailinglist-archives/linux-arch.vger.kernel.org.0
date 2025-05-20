Return-Path: <linux-arch+bounces-12019-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573F9ABD9BC
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 15:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F13160D66
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 13:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747401C4609;
	Tue, 20 May 2025 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jtV7aRUC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iVn4NKra"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81FF2F37;
	Tue, 20 May 2025 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748375; cv=fail; b=alwgidqipidZRVEurQsbSiMPIgOQ233X0dOoAod2XBlw82xPi7+Q/PDwSKjcCAuyTYSz4k3dV0GukS1dP6PZDNbXEnvYNP99oTIR7DnVwyNNb7T6QZ2ymmluXq0ICfzlpWRRzl5ONvpw1+3LC4utwyryEsUAYlbNWiTsrTvbWr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748375; c=relaxed/simple;
	bh=jTMdOeml27LFvr2PMlEORV91FWwtPsCmiipdXZnLwHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Duc6lcKLfKxM2HPxlH68+mFaIDgANLjkENX26yqjFtxdDD6/2cO11AKFALKQgGu8MpWR1GKv0uFiFYJJaLSI4I8CZZZ0XYc9sKT4LfRvCgKBzaApqm96pg+o8vbO95lJYL84rsAFpWWYjm+baSnL4lKpnAoLekrC5C8AcITR1Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jtV7aRUC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iVn4NKra; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KCtsBu023037;
	Tue, 20 May 2025 13:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=rUGc8g1D3Ivwl+g52y
	ZKF1bIUVjNvDXJD4rdZ5MDKic=; b=jtV7aRUCXxyV1alDlO9uIXXn9WYAAGSw4Q
	gKKdM6VcvX6ekyO/Dx0A3aPduVF4PInClpVQTd7ZHj5dVlgnfpLCVBtStU5ORSGk
	iqufoimIFSiEg3g3vDVrsNFBaUCpjU7DeaSJnl8ZokXH52A5wIibaO30KTN+tzUA
	1ocG89ADzSBggZNixO/D8tk9m8RWkOXzRv0Idx8IgIUxNLr3YMvSEPH0kVfSbVIH
	YR8m7euYgdadopA/4VEVKLN/cSIONGgXP89TEWurJfQHRBoEyMtgbby8um2zLiyW
	+5B3vFWK/6dPgtTTUcsr9nL4QzPSZ774DXxpBn1VoiSUKRTszdMg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rd7v1dtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 13:39:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KD2lK3015946;
	Tue, 20 May 2025 13:39:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7s6js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 13:39:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAdbEsInGWVWWNcEcGmFhrkGsjef8AeMhA8COSwCWi/LFybKOh7Nbu5I3EUamzvHvVN01CKEj75DqQMLaIEZhAmJgQHRvRYq9x60NYUWLNSjolYzivU2vqPmdmBFe2rzwPRLEgML2A+8BE41Q0C4Xfbtbj86vKpgR9TpV14Js7H9wlBiRsaPvCHMiE0aKS5uU8B7ES4KL7UWLqVUrW1Sku0SS1Z6HCFWHWpOKfmJTTXg6ZMskTvkwV4utoMDDMxcNIfvzZuB758MHo/BKl2+xhIqjx6kzqh3JCCFlOQMsF6DwRQWL5EI9hW4ZtpCn1+ZVhPzrR0cBqktnrNLfsP34w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUGc8g1D3Ivwl+g52yZKF1bIUVjNvDXJD4rdZ5MDKic=;
 b=FyX0Ny+SATM0sBPzQ+ASWk4yHAcomye0oTUkR33hgfVuEioALtouU6CxdTjkW0s5m7OxvUj3wtGp1XG/aw6allaKSUbSw7tiwm+UkGrppyemMXkWwiSdjUrFgXjScwqYDd9MJ6uVmjRRa52eQrAxGyoaGXrJNjsaVVqlHlIZpDsseWYz0xgh59tDsCK2r15/rDgzE2o2v5ah0L459Fwe5ITkktNgxwdDYReYAWEQGEm0mZDWE6V/nongTBK7fgUNRixs85dc0n6I35fHb/FVIXwMYLkp9fwLJLuXGEV+DoYQUfGLgAdB/DlIFRUwFz9p9X4uELYDbHUr9ZEM42wuuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUGc8g1D3Ivwl+g52yZKF1bIUVjNvDXJD4rdZ5MDKic=;
 b=iVn4NKrauG1+3lh3RZzrwj5lrAz9QEF46lUqmxdOaADfDRQbzvz3Z3J+VphznNngl+dP4GDIXmGxlwU7wfwcqTcE1Jqxa3xKecEhSDr71ZQ344H+FKUn8Qp+ofBOH8V+4Pz1vg6Bpg4IMIcaNMBziYuD/65gDhA9vVBZZjjfvsU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO1PR10MB4451.namprd10.prod.outlook.com (2603:10b6:303:96::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 13:39:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 13:39:11 +0000
Date: Tue, 20 May 2025 14:39:04 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 4/5] mm/madvise: add PMADV_SET_FORK_EXEC_DEFAULT
 process_madvise() flag
Message-ID: <60072e84-8535-460f-86ef-4e6a29286de6@lucifer.local>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <617413860ff194dfb1afedb175b2d84a457e449d.1747686021.git.lorenzo.stoakes@oracle.com>
 <czd62f2vzwv6fow4ikvzlkjdj5odhc3nhtc72onwip52baobg5@yc5pjiqoqnh4>
 <da1281bb-e49a-40f9-ac11-f976358e618e@lucifer.local>
 <mnaqmyzodrrzzaahupzj5djayqpnt7jojqa5yaay2jdpnnwfx3@b2s4twil5cvl>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mnaqmyzodrrzzaahupzj5djayqpnt7jojqa5yaay2jdpnnwfx3@b2s4twil5cvl>
X-ClientProxiedBy: LO4P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO1PR10MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a29d44-b825-496a-2f68-08dd97a3b400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bbbtcEiEhDY93LD5gTg+FncWnPfRwqWxje7PvZ1NQDsp5NqIpWVOF9pxLR/A?=
 =?us-ascii?Q?QWn2d8AI+0Ee6nHKzrTp1I3to7PTRyVF8jpVFYI5WLFxdAHl4xZFY1IJxso+?=
 =?us-ascii?Q?Ey+jRhq1+u91fs65PIFir7wCMxlCFo9FglR5QFSNUj8g40y+Iz2r724Vu9U7?=
 =?us-ascii?Q?faH8CTjT7IA8TJ0+kZscgV1KrOLZES6iOuehLKeNyTXnjWvIjf0Loh8PIrpc?=
 =?us-ascii?Q?OAtkJ3y5cA1FyYkr1k0wwYf9d/1aIBFoy1T7E8y4Kew/unT/dIKgPml3XTO/?=
 =?us-ascii?Q?vZ5skbElSPjmyPByqpPUB9irRjt0GtF45m5rMJjbFTT6g1XoPRvkNvm1NySa?=
 =?us-ascii?Q?lmTn319EfNK0lVIc4/mDX5xDG/cSuGo85Yj8kJjpNEvIevEEGo0QVmDwiGOx?=
 =?us-ascii?Q?JbXjjVRKqYy/du0awC235aiprcsTigPm6QxtYgcl8yqAxHa7C0lvhb5Rzctx?=
 =?us-ascii?Q?3jbcwgelvYYSETayuAfIW/qiR4XAoZJvIFPkfLMXixw4yRoW/amJ7+8PHfnN?=
 =?us-ascii?Q?1znkYqQlvQ/Ph9qaBMB64VVT3dp6I0mPhJjVyLbydCunl6KtYX2HVhB34mCv?=
 =?us-ascii?Q?RdpkhslMbumI5ZHj1SoZa2n3so+luNzommlKbxaJBmPlblvbu74S946144yZ?=
 =?us-ascii?Q?+jcwjIQ6Zc1YocWguHM+6fOHNKOed8Tiw+SII5CZ7MpvrQl2ejl2RAhnke8m?=
 =?us-ascii?Q?tQw2+psyikKzFua5P8P4DhaQQZ/q73qLs/YeGZG5OFre1ZqbPw+DKIbvqkwV?=
 =?us-ascii?Q?9gV/fB6l1945wBZDR2YSNM+lym5q/Ij4rEystvwxfmjIi0DIeuSb9cY883rP?=
 =?us-ascii?Q?XxfUWJVhMg6tQrZO59wsvGqbWjKMeii2wz40SpFtPN6xRuyp35VcVZptPztK?=
 =?us-ascii?Q?0vt/pdkjLXH6DkqJGNX7HEpsAxVwJ7vP1tnWA6ZmwirL1AbxZ75wnhhrRfZ4?=
 =?us-ascii?Q?22U3flrbhpSwNGdWGSKN+vQk2OKdbLcDxzUZ3n7zNvE9rwRWKUVzQ/IQo3o1?=
 =?us-ascii?Q?xBnr4knx83sqnhoYGxdwStOXRDLl/tu+XW5Eu5L/UtsgWMBaZn3AMQWiqDO8?=
 =?us-ascii?Q?LNZS7I3f6WgSaichR91HXCWtmoS1wh24/5V/weT+NPqYI1RA0kAkWmhkwbzx?=
 =?us-ascii?Q?BSK88k+/vSfMa3y8LH7tw+GTLKlHDRDA1mqpoMGHW+rV/I7N2TibFE2lUCco?=
 =?us-ascii?Q?tWJxhiWW1SbyhEp+FzrbOE1HaCoEdpL5Y6cUAwVdorhdrTKH/LoJvbRXO8Hp?=
 =?us-ascii?Q?1wAs9UEyqBeWZ3wYsAcZyloyR4bbaVwg+Djgw8ZKph1Jvu9hxjLdgyIFQPTs?=
 =?us-ascii?Q?3cpl48yHmdchXgXgUx7O3g+SNoYX7u6nui9e/114tAVfHnRRm6Ehno/c0WiG?=
 =?us-ascii?Q?0yPZ9FnMEOcSjwl6V4wo+gfJEYkuZOwJQOSk8aywpiGvjsZCC9j9Gs3+vJx4?=
 =?us-ascii?Q?C3YJzTK12Mc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TwZnif0cxQJ8oIA9T0uTVr2DLtO56NIVc5hJKqJO9sogkxFplqaPEdBpEMDw?=
 =?us-ascii?Q?T8gXGj6+naf08Kek/nfTK8vvqbm8168f6vFBNmqncXposFPscaBYeTHnwCfG?=
 =?us-ascii?Q?YGT/busjhd2o0yTu30KpvD65F/UDfBfBLKO9r0mbwVIB8k4DoHwrv3p3qWkr?=
 =?us-ascii?Q?2ju+C+W3U0t9H/lF/FHHUO3nWnpGsWkoe+OxqNnNHS/lNngipn+TAn03qiWw?=
 =?us-ascii?Q?u8YFDf8cniPLvx949ANnXy2od86VkX6Kyi5fiyUr2i82U0mIDY1/jWWbMVTK?=
 =?us-ascii?Q?PuLGuCfZbol6uWDH1sdQElS2U3uadgd2ZA6Sx4xi85UtKuvZrfZmSx28oHGM?=
 =?us-ascii?Q?j5YfTsKwZd+gXXO9uoLIMIqjNQB62w9sy+4/uZ/P8J+bqSttgohwJ1t8en1C?=
 =?us-ascii?Q?2JAq+VoJ9FFWOnMn5BkijafGdMRYBc5KWpWz+RmCxHsdMoKp//I4Wb/9g5DW?=
 =?us-ascii?Q?I91u5cBokydDJV+ivTGcAbmDK9lAcI5s9YiIEsvL8rE3V1n08Fk+4S4VRBYA?=
 =?us-ascii?Q?iVBuTGyDw5n8eEmQVsQ6v9CVHo8Gq6rhDjQzT5kKqZorkrJhvVPHmBuzWEX6?=
 =?us-ascii?Q?RMGAfNF8W69XMb9abPpSE6AgvHywPPKXwWCY7MK6ghGxvrf3YtDkgjmfBfE9?=
 =?us-ascii?Q?6KfFnYOvWZxdqhhmmRXYSuQ1vbjJiF2kjSXH8xJCAV+FlELsTYtnx+qaBzrr?=
 =?us-ascii?Q?yHXKHaFwF8TTNIIAa7TxkAFvG3uDRe7Q78Jkil/ciUX9VohatLGs9O1aNKab?=
 =?us-ascii?Q?9G/qUSxaI9HR2ZTa1xQbrVdcKnKLxa1b1xUCs660ia45PFWMd1Sbt2gRvYM+?=
 =?us-ascii?Q?IY1Ru22O7MAD8wdSoun7kaTI6tvKpdc4mYvmwk4c8p6F0WuPvb7cfXbCqf6c?=
 =?us-ascii?Q?303b0bNXxP7/9uwvhA8xvSmgWAFHvNXsVt/cLr2eyJWRThonaE2TBxq8UzV1?=
 =?us-ascii?Q?cK6jH+PkaGPhO9UO8wMFtoXwcJ7Ld255KN7HLrUPVNxKTZtaV/VEFvtel6R5?=
 =?us-ascii?Q?kc+/znjOo54kS+ubxAxsoYUWn78Vt89bnefXZETEibk8UkCaM1uE3YfCg7yV?=
 =?us-ascii?Q?5G/Og+XVh882JKClmPB/48dd/ruq9+LYQlxGMgW/SJHaG4KJc0OqyNIhEgPp?=
 =?us-ascii?Q?6PMXe6CNdwiNXsMLR3FatHqAD5u/mGSrHyrjGmPgRtBi1GPh34O21F70/YQP?=
 =?us-ascii?Q?FQn+mqN4fcYWOwfSHAhzc3U1d1lJkZx2yG6IG/nfnW3cj+f78V5NepsKceST?=
 =?us-ascii?Q?DGeMu8aWFhdiJGi5XpXQWDWfILKk808tBxlcU6aCWDSygFJrrpxpzjWZMfEE?=
 =?us-ascii?Q?aQV1wI96odhMelzzXqJJ/UekBzHvAo1Mm4UgrZ5rxQA17OmtEqejwk4kHpxC?=
 =?us-ascii?Q?NhjQYDZZ1KHsJ23rl9w9PkgUqc86NslcML4/tEqem53lxyLi/zmMNnFZC47g?=
 =?us-ascii?Q?tSpjJ4gsUZnJ6IptKVIFsV+MHyVu1eT/40WgdU8AZ6RSnBEu2AdsJtwOgonm?=
 =?us-ascii?Q?/NvXNtUJT8m6Z473JtBJNsTAaASg+V07qtayl0xCJgX0wsKSGu7ZObQKxaRK?=
 =?us-ascii?Q?/5L96Igor+IZcEjyYSYXZLM6lkqp0BJ5TVggy6CwLhasnNdG5gFmar+Syvlc?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OH8cni473EGfCQvkU6oLBiZfH3MBOfPR1A4cUtVDGmeq8i1mZWu+YvGRKeDsSnrb5oLGn4drssB5Nfc+Tg7ZXHfzkULeKQK8+5lt80gwh+YEXhAWH5YtDb42qHgq7MXEzPMGxfKPBE3vF8/GVUlkVw/qv/u6bISrbtOsEWEUtZZpuGxYQ0KrE6035jmJuxCI5byxNvBORAqPfBYlBXBaXKDgL7ff09NxTNuNTHPk2ZJlIBKUjWwI02364fal1ygILkGOjUOhyYpXlM2lWqWoOaUUZ5aOm5Cd3qE4IBCektIxDoPjaCH7shfri2DQmFGdn3kdIiJzDH3fA526waNx46AMq6isZ/nNx9E4x4BCHHzHHAq7yKkTMLDuNfK5+ZBvWR2K4L64W+BYAQSeXIkkNbnemA9sZ//DiSU896p+Xcdu+mTE7Yv21lMWMGW7O6wO8ODlkjCRUmfZhqg343qCmbetRKgq6QGtG5t11LDNvcWcuJrZE4nikF+cqLzGbZkpc2zEarKXeOotKcLzozD7fWS2ijkmCUcUHskauCLSFBSwm/W56SKURkBugQsfrBNGxuZt47KZmZemfP5Wfjvan4ApmSdcgmiIHvaFJe0b26E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a29d44-b825-496a-2f68-08dd97a3b400
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 13:39:11.2981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCCpG//NEjHRVSEmM2iNQmZBujEYYBbzepeEnwz+y3m2BRc5JElQhl4wtXTn0f31RMytffrqT6BMEYfk5cexgTpmRzTNPaBwNBlyX89dr90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4451
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505200109
X-Proofpoint-ORIG-GUID: 9ORHkRFl0WXEnUxo09GdwBfKq3Vfsvp1
X-Authority-Analysis: v=2.4 cv=KcfSsRYD c=1 sm=1 tr=0 ts=682c8602 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=j3hNiaGS3yfY-TIBGyoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEwOSBTYWx0ZWRfX7gQBXRTp2UL0 p2igSszB30b7Ie0ERte3/0Xx7Ruu/PaUdrpcS1ktEgP+VhRFqVjkfcuelXJVeuwrqnDl9ZEOGUO RbmalsUbX2uR36iZ6Xqu+9xgT0666/cnAfiWCZc3g1AiGhP94JflpjgxxJXb/xs49pAPWlUhvTh
 hSBD3WBNkj/h/LqcJWkuCDPBvC4cdZM+E9OwsyaC2rrM/M74uTKOLO0lq40FxQ1nEETtCZvg8tN UcotJW+/sV3BDT9IoXAZxUlKhr/XEq3Js8HArGfMbbvidglWkDrRnDTHcNzjIga2LSGzlqZI4Kq 0Xj6cwk2UzLnz2PgMEXffga8qJKEzCTcPkBX8YH0ebshRd5I4bAxLSA6a0Gzne+u0/j6mtXHSyq
 SCKerHZEcnGxOi9R7sh5DkRrbSykIuN6D6QMHP0WciUWRHqYU+JGpOwayEU11hPkyRlLTUy8
X-Proofpoint-GUID: 9ORHkRFl0WXEnUxo09GdwBfKq3Vfsvp1

On Tue, May 20, 2025 at 12:41:00PM +0100, Pedro Falcato wrote:
> On Tue, May 20, 2025 at 11:21:33AM +0100, Lorenzo Stoakes wrote:
> > On Tue, May 20, 2025 at 09:38:50AM +0100, Pedro Falcato wrote:
> > > On Mon, May 19, 2025 at 09:52:41PM +0100, Lorenzo Stoakes wrote:
> > > > It's useful in certain cases to be able to default-enable an madvise() flag
> > > > for all newly mapped VMAs, and for that to survive fork/exec.
> > > >
> > > > The natural place to specify something like this is in an madvise()
> > > > invocation, and thus providing this functionality as a flag to
> > > > process_madvise() makes sense.
> > > >
> > > > We intentionally limit this only to flags that we know should function
> > > > correctly without issue, and to be conservative about this, so we initially
> > > > limit ourselves only to MADV_HUGEPAGE, MADV_NOHUGEPAGE, that is - setting
> > > > the VM_HUGEPAGE, VM_NOHUGEPAGE VMA flags.
> > > >
> > > > We implement this functionality by using the mm_struct->def_flags field.
> > >
> > > This seems super specific. How about this:
> > >
> > > - PMADV_FUTURE (mirrors MCL_FUTURE). This only applies the flag to future VMAs in the current process.
> > > - PMADV_INHERIT_FORK. This makes it so the flag is propagated to child processes (does not imply PMADV_FUTURE)
> > > - PMADV_INHERIT_EXEC. This makes it so the flag is propagated through the execve boundary
> > >   (and this is where we'd filter for 'safe' flags, at least through the secureexec boundary). Does not imply
> > >   FUTURE nor INHERIT_FORK.
> >
> > I don't know how we could implement separate current process, fork, exec, fork/exec.
> > mm->def_flags is propagated this way automatically.
> >
> > And again on the security stuff, I think the correct answer is to require sys
> > admin capability to be able to use this option _at all_. This simplifies
> > everything.
> >
> > To have this kind of thing we'd have to add a whole new mechanism, literally
> > just for this, and I'd really rather not generate brand new mm_struct flags for
> > every possible mode (in fact that would probably makes the whole thing
> > intractible), or add a new field there for this.
> >
> > The idea is that we get the advantages of an improved madvise interface, while
> > also providing the interface Usama wants without having to add some hideous
> > prctl() whose logic is disconnected from the rest of madvise(), while being, in
> > effect, a 'default madvise() for new mappings'.
> >
> > So while specific to the case, nothing prevents us in future adding more
> > functionality if we want.
> >
> > We could also potentially:
> >
> > - add PMADV_SET_DEFAULT (I'm iffy about PMADV_FUTURE... but whichever we go with)
> > - add PMADV_INHERIT_FORK
> > - add PMADV_INHERIT_EXEC
> >
> > And only support PMADV_SET_DEFAULT | PMADV_INHERIT_FORK | PMADV_INHERIT_EXEC for
> > now.
> >
> > THen we could have the security semantics you specify (require cap sys admin on
> > PMADV_INHERIT_EXEC) but have that propagate to the only supported case.
> >
> > What do you think?
> >
>
> If you don't want to add new fields, this option seems fine.
> And then if any other usecase pops up, we're ready.

Yeah sounds fair, will do on respin!

>
> > >
> > > and, while we're at it, rename PMADV_ENTIRE_ADDRESS_SPACE to PMADV_CURRENT, to align it with MCL_CURRENT.
> >
> > I'm not sure making the mlock()/madvise() stuff analagous is a good idea, as
> > they have different semantics. I'd rather keep these flags descriptive. Though
> > I'm open to alternative naming of course...
>
> Semantics are similar I think? And I do think getting shorter names is a good
> idea, however I won't insist too hard on this.

Yeah perhaps with _ALL_ thrown in to make this clear... :) warming to it... ;)

>
> --
> Pedro

