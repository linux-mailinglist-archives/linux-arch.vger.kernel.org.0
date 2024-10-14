Return-Path: <linux-arch+bounces-8077-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE8199C8BA
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 13:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34EF284DF2
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 11:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4CD15DBBA;
	Mon, 14 Oct 2024 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GMRjU9B1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HvJGB8kR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0014F21D;
	Mon, 14 Oct 2024 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904964; cv=fail; b=F0q4qsNXRO22Nut2aqhrtwHDrVYneYW0ruIAcE4ny/IQJoFiLHdLwunb79/NtD4C2G9zi9ptttzMpqPxJaj5gRs/IJFBebUfa5yLixnb+xBc3pyumfycRQLOZWT0LATHTsjzsNt5//1YSsfp7nQN+RWlv5XE0cthu42WEY2Iphs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904964; c=relaxed/simple;
	bh=ySLEIJfMT4+1dM6VEp2kU5iCqtFoPTlfa/n85SxW8qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wc7ooOh3By27qg9cR31YCOsCDQ8QNIkoDNbavAsupLFdDsay1WFm4pE7BF/0x0ErroWwISPM3SM98jHuP30wFTQ9fF1lo7+bWIe3MvSc9w97HRJucoWgHz+cSDL7Df9eIYZIbPcQMfIQIqswSaXCkiAs8924iGjF8keQTHFrZaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GMRjU9B1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HvJGB8kR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E9tboi011699;
	Mon, 14 Oct 2024 11:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Dw+BGRut7kFRh0bZtd++S76bll/mipzLn+axJhEUFEQ=; b=
	GMRjU9B1DxOz0AqqzKqsrd6tPcjorlww1ud42eWjcLRS4kLJ5RQxriI21cQzaLwT
	86GPcZcAv7pHMOT9vrGdT+phMm3HWEtIYJm1uH94a8esXyVtssXZzob4Oc7Y8ZPf
	KRjW6SwJMV2ciWWDKPRVXx9jC2ZqESIBB4EnxKnIQT7WlaLmHQP0sBrd/S7/OqSp
	jLn5P/L+GcYnlJn3AtidgHptutPejojpz3h46kYcQpm3iLFPBo840ZmjE0KMkPlR
	dyHayNUDrx6skzB7yYkTaX3E2Jccs8Yre2NcdVYZF6GH7O5E6roXUSH5xCPR9rfJ
	Qbg/CcCN0c6l84JItKmgSw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5ce9x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 11:22:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EAXvXK010387;
	Mon, 14 Oct 2024 11:22:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjc7sj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 11:22:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaLAq0wpDvPrjvTkNPGPTISti8dcYdwlAj2ih3XRvrKTtgY7M7zsK/qMeVmKhf0Duf64KbviqNzhU5/2XMsUKh5ioonjgFcyGKcWUjcgebB7Ox6Vl6EGKZtwMQefXp5JxipjRhXElf2zqK4gJbk9mXs/RaTLAzUcqpX/qAZlZA6wfcSlrEakj4UaCnUKMcRqd1DbxYAJOYqVhGwnz/gdmlnWhxPQ2Wo0iQ8FfWR67kZ/OOHAXgT55cN1mG9CSieVTRpvXltfnYaRmStmEH0BblrieDoWMP1zItTdY8GD30fwE5RjJXo2vrJWeHrGV+c2RfTDE6z52F8ZO0LcsE7P0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dw+BGRut7kFRh0bZtd++S76bll/mipzLn+axJhEUFEQ=;
 b=RjfpqFafdS/xif1SlXLk0S6NfKUuqf6Gb5zf2BWLO0k7DzIxvcbv4N6urmfm6sZ3d5aEaUoWyXuGg/Z+wIgYFJHFWg4ZRA26MJfRSj48/Lda6RCV4i9yB3FMbWOlxV6t2VSsxEM82S8jcMiVgn+Nj1xcbO0Tq8LxCOeVXeT2HJxIkVrjT1TvhSGTMFGZgyuVcF0U6GJ652x36uf7Xg3MLqx2uLgz+IeEMcnyS+02UzbdgX694rCWwGUvXWol9LnHfsDfL9OfKJxm3OH7xe5k7ZJFFM2VhGdLBosEIl1IqwJNXn0sXIdmgQobaDMDL2KbqLcRpGp0qKHtCIMNmI2Xhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dw+BGRut7kFRh0bZtd++S76bll/mipzLn+axJhEUFEQ=;
 b=HvJGB8kR7YunsbA+jqyZMBpWeM29r895Ig9hTbH+NK5Mduh5TmVKVyNPJiay8tmNClNzrxJ/GimxjVa8dVVn/kik6LMTqLVQjcZaA+HrWoAZy0sQdKX899PFDn6vW45RxDUdVUu0b4V+KNYNs1FjRf7+hOEX77ixFRGpHV/fLUA=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MW4PR10MB6582.namprd10.prod.outlook.com (2603:10b6:303:229::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 11:22:01 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 11:22:01 +0000
Date: Mon, 14 Oct 2024 12:21:58 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vlastimil Babka <vbabka@suze.cz>
Subject: Re: [RFC PATCH 3/4] mm: madvise: implement lightweight guard page
 mechanism
Message-ID: <bc015d98-8bb5-466d-bcd6-9f9121c7fa03@lucifer.local>
References: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
 <a578ee9bb656234d3a19bf9e97c3012378d31a19.1727440966.git.lorenzo.stoakes@oracle.com>
 <CAG48ez3ursoL-f=mYpV79Do18XPPt+MPPHNUBv6uFE1GhpOwSA@mail.gmail.com>
 <CAJuCfpFaHz-xW1Rh-+rJ8iLyV19JuG9Rm-eJsz3aOm8dUj3Ewg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFaHz-xW1Rh-+rJ8iLyV19JuG9Rm-eJsz3aOm8dUj3Ewg@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0176.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MW4PR10MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b546693-e2d0-45b4-6b09-08dcec426ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUkvK3REZkhieUlxWW5XMDl1WDdxTXh1TUsyQUU3VElLeExXeHBBZHljTG9J?=
 =?utf-8?B?Ym02dEU3K3I2QXVSdlo3Q0xrVy9NbW1scjJPNmxuQXJnaVZMYmRINGdHWS9Q?=
 =?utf-8?B?Q04xWkx1MHZtMGpMc1QvcXBKdDBrNkpHL0xKckVnL015NVgvcWd1SElpUW4x?=
 =?utf-8?B?WkdsN0J0ekU0K3JkSGZGK0NlbkRrL0IwcGg2a2lWWnVmbmRjSS92MnR2VGVt?=
 =?utf-8?B?YUV4UVhTaFErWTVOcldXaExVRWdJSlBJSHVXNlpIN0IrU3kyZ0ZLaUtHT1E4?=
 =?utf-8?B?QnBZSDFKU040VXE4RlFVZXdIdkQ2dUgzY1VUbDJMWTRuWVp3R0swSUsrbU9r?=
 =?utf-8?B?V3pIU2plVndUanJCVjB1bXZSTlMveGhKVEUrekt4ck5KOGNDUVZHbXJnb0NT?=
 =?utf-8?B?aDNsRk9UTVBpN2tHekpuR2FaOXVxTXV3cWM3VzRlUUxsaFZROUN5VlJ1NXZj?=
 =?utf-8?B?d0xRTk9yaUJBR0l0U2Nzbnd4ZXhoV2xobEl0RFc2MUJIMHBRRGR4YnovbFpW?=
 =?utf-8?B?dWM3TkhJLzNhMmVGNiszYzhwb3hiaGJjTWN4azArMFFtRnRBSGFwWDZMVXJ1?=
 =?utf-8?B?ME5uQmNWUnE0Mi84NldIVkErUDBQN05Walh1WFlOa2N0WTN3TjA4d0FuTjVx?=
 =?utf-8?B?V3FmdEJMOWtaMGZtakxOK0VFZXNEZkFYdWNQU0VpMFRFSjJPaFpLTTJJZGYy?=
 =?utf-8?B?RVBBNWI0LytlQm5lb0ZsdmRoamN1Y1M3ZGx5ZTZKN3JDc0toNkEzYzlwd0JK?=
 =?utf-8?B?bmpUcDJrbHV6VWxPeExOSExzWEdyT2Y2azFFTE1nY3owYmZlSnlQZ3pFRHhj?=
 =?utf-8?B?MkwybjNpcldjclZKb0FNdWs0QStGYi9JRnFSUUhTSEwrckV5NFlTam54Kzcz?=
 =?utf-8?B?SFJ1SkxrRkd6Rmp6SXNpaVhBNThDdUtJMHRzekxFOTZ0aG9MOEdKM2hSVjUy?=
 =?utf-8?B?UCtkQ3ZnY2grbHA5OElYNTZYd0VIUU9CaHFnS1JOUHFTN24zcDZSR053dG0w?=
 =?utf-8?B?a3o3cDVuWG1QQVozTW92U0h0d2g2NnZSZ0tWMmVJWGVnWVlRQWwyYmdrSGEw?=
 =?utf-8?B?UHVhZUpSV29BY1ZjYmVUdVEyYkJLa0tMN0pDTEpZSGNYeFBucmxFTXJnMWkv?=
 =?utf-8?B?NEh3cUZxT0xPQ1lZYlk2Z1h0K0FLaXQxNlVPTTk4UzRRaDlkYkpkb3NXZ3Vu?=
 =?utf-8?B?QzhBQnBEYkphTUxTOE1VZkVuOWs5WVRUTktnVWkxelIrM2toaDYzTHlpRlYz?=
 =?utf-8?B?U3VXa25WR093T1RlMjAwQkVXczhMWVN1bnZ1NDcvV3hQeXBCQXNydjFUcEhS?=
 =?utf-8?B?dkZxMkY1K0pkRDNJNHJvMTNPblBrSzZiQ0VoWmdTeHltYUovK2JhVCtIYTBj?=
 =?utf-8?B?MGkvYm8wT282cGZCRTZpS3F5QTVqQ3dUWE1NYkp6NnVLcmExUEZ2UkJ3MjY2?=
 =?utf-8?B?eGNYQ2F5K3llNnVBTXkvTDBIOU8yOXdPdDV6NHNiTFVRT21ZSWJtL0wrWE9X?=
 =?utf-8?B?QnRDait2YXpMWFAwR2hQSjNPT3FCRko2aFVlL1pJYVloODlPaG5xVWFhdEcy?=
 =?utf-8?B?K0ljM1liNjVINzQ2dktpZldFMHhKY2dhR2V3WkZWZGhsb09BejVYTlJJV2wy?=
 =?utf-8?B?Q0tCUFlNazRtV21CdVJmdWFBdGtEMWpvb2czZU52MUsvVWhackhpOURRK3JC?=
 =?utf-8?B?QXA1OWdXQ3NIR1NWK3BEbno4bGhVbmY2UlZVMzlaUUhUbGJWNGVoTlBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFl4bVlRTVNKYjZwSXZTZXQ5OGtyazZZRjhGelNnVmlnbFZOMG5qS3FjaGp1?=
 =?utf-8?B?RkhDSE0yYVFiZWsrR2xEdWZFV2lleFA1eG1VS0cvdVRuZ1BWQ1VrdnhtalFG?=
 =?utf-8?B?WWtLU0xld3dNNmp6clBxWDA4ejJMMVFBTEFhQ3dkV2pYbHNVWWxmU1czOWZi?=
 =?utf-8?B?MnVTYUtNNVpYVjVvem9SUVRIMzYyZEpkYml3bCtLV0l2a0VOY0RLNUtTa1dh?=
 =?utf-8?B?a091eGsyYlVQTDRWNWJUWkE1MGFMZkJsTk4rTWx1TS9SMDRLVEdsYWVNNzZ3?=
 =?utf-8?B?djV5RFlvbnd4bTRQVVUvVTVNajBUMXNWNk9RNE9RbE9DOXVJSHZ2aUwwbzRa?=
 =?utf-8?B?SEtXR1ZvZUhJRU93UFEwMzVtckJGaHo5OTYzZ0tjY1RJUjBsbmZwK0d6MXJw?=
 =?utf-8?B?Y1NRVFFjSW5Pa1UyOFp4S2NsOFlRUWJIOUlGb1NhNUUxYlFWc2llRUFDTUNh?=
 =?utf-8?B?Yk5GL1p4OUoxZzI3d2tYOUdpRzg5YTNWeUJBWjFneXJYWFJXSHppOUpTWGxk?=
 =?utf-8?B?c3dmKzBnVnFOU2xLcTZQQjlHZU1Qa3BWNTdLV0VUZnpueklCTE0wYVJWdHJ2?=
 =?utf-8?B?a3JUR1k2Q3U5b3ZMc1NmVTAvQU1ERjFlcXA5aVcvdzB3TElnNEsyaUZNR0hP?=
 =?utf-8?B?Y0c4V1o4RWFPWTZTUzhZcGJxMmJkdXJhdHVhUXpqZGs0K3hrZm5RQW04R0lG?=
 =?utf-8?B?aW1LVzFMMC9SSi9DejRVaEdoNkVGTU12VzdVY0JYbXFlTU1kTGROVzNXcEp0?=
 =?utf-8?B?bEhrdnQ5dEVpd05EWmtoNGtFZmo3Z3NNVlpldjMzVWF6bHF6TVovcXVFQVEw?=
 =?utf-8?B?clc5aTZVcUd5Vm9IMlJHZFFwNWxjSTlYSE9OSld4TmZhcFBvTWIvbTdweXo2?=
 =?utf-8?B?ME11Ly9UZ1dRTXNoR0syU3hmQXVsS3dwK1kwQ2VDOWdtaGV0aHZEQjkyYm9n?=
 =?utf-8?B?VGF5VVA5L2VHeXR5TDRzQW5IT2NySWs4dlA0a0g4clg1RTZrQWpFVVhwcEtO?=
 =?utf-8?B?cU5CS3UxMk9ycSs0MHNLTVZsYjk5YVhyc0NQQTdwY0dPM2hqVURiMUJ2UWtk?=
 =?utf-8?B?WjdqVEcvSzlDQWkvR2J3UGFyMGtjOHBqempWeVhYVDQySURYeFg3b1JOclIr?=
 =?utf-8?B?T3lraEJITXNEUXhwMkFhTHhoUzExTGM5SzZhRDdUeHhselowbVJpbFZLbndY?=
 =?utf-8?B?ZEZvRGl6VGFHS3psZ1hKcjdTWmFPTkdQbUFJS2Jzc2xwUjVuK2s4MVZIdzFE?=
 =?utf-8?B?U2s4YW5TVERUSTNtZ2I1NTJQYzNnT3hGVStoYVFJNS9vN2lnQmpOcnNONXVX?=
 =?utf-8?B?U3VJZ3hEY2xWUkVIWGJXWW42NndySnFCdEs0VWtocFQ2M2NXdUxmdUpBaFRj?=
 =?utf-8?B?S2ZIZ0hvbit3OWV3VVJCbEUxbWZCNzN4OHYwZnFTTDdSbkJDOE9WT1VIWWk5?=
 =?utf-8?B?QmFmSVcxZFRXSUhuNHVoOGxaSWp6VjdZaHVHUHNUaUpva1QxRlREZnp1RE1N?=
 =?utf-8?B?Y09kZ2ZBR0NYOUgvQTZpYVRsNHRlczdEQytLZnJFdzZ6aGRTWnJiM2YvWEpl?=
 =?utf-8?B?TytTeGozZHlrY0FOb3NrRVNjQ25ieXZhZkdiRmZ0NWlha1N6VHJVUEQwQ2dL?=
 =?utf-8?B?UXVTY2VHenZWeEowcmtsMnU4dVlOWjF5YnEvV0VXSUtGWXd1ZzlJUUtPRUlq?=
 =?utf-8?B?L1R3anpVdm5nYU5rUUhqSmNjaXp4REgzT0ZQam9MU2V0MjRLc3M0QWVXQkN0?=
 =?utf-8?B?aUc5TTBDSTJnQzhoUmJxWTN3NmY1YUtHeThocER0elVGNVFzM3ZobDdYaWMw?=
 =?utf-8?B?NkFiV3pNRUtsemdwcWFsSWFLOG1ZNnNseGxFT1FUMm0remZ4QU5QTGZ0MStu?=
 =?utf-8?B?LzN0TVhuTXZXbjNDeENsUmlLemJJbWh0UERWNXJleG1NdVU3c0I3YTZFNmR0?=
 =?utf-8?B?SVlZRWdFUnY0SEUyckorZU8zbUFneDZmSUwzUFRwdyt4aGlTTmI2RjNHZDRt?=
 =?utf-8?B?MXNqSjEvVzY0YzVHSlhUbWRncGhidGZYckRyL1cveGNvR0xUTjAxYm9yb2Iy?=
 =?utf-8?B?d2RFdy9qbEtiMEVTM1R3VXllVW4xSXJUQlMxRHowbklaRGRXZGYrVzE4Y3NF?=
 =?utf-8?B?WlpDc3o5bzl0U2Z4em5oWnAwZDlqb01NOEZIVGlqNU94ZldXU1cycE5iTFpM?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0NFviY9CtwtTLy7U0zRIN6/HBtXlBEAadpI9BMgakZi39V10VayPpjfuwnIEZCYDzUPPIMapDt04v/m4RuXnvXkHPaNsJYWDQ851VCrQZlE33T4DZanANIzCvVef71ch+FUCqcV80r/8apCPUlN9B3jVF3/cLPCtPax0D40YTOVS53pOMQ/N06EH/ZcDq3noOjQ4ggqqDCwThzBogSkozvDQD8lUYCco3b3YyPDSgKDO1aoHWTpM2PhhB73Mom+go+wwgggkXa5/1bo+QIaZCyKqMPs6FfWAhgbMk58ReFjLOxv8TXnX30JmKlQnjat0UlziBaEGlXJLpkAcKXTx8PodqeioMUuBMjOIdnBj9EZvuYCGtHm47Z+nPxDflaPmJCVcU+vh+RHiZzzF2kaLY274fVyXAji/THX0ihuq3KIcYp1q2+cwJtWVB1gbr6N4wBgBcON06z/frAoWgaPsI7u2V/oj46bEp3KNfeaxeIoDKH3Sl66BY/O26dZSm9dCgYyz4oCuFEwP2mBHdRC908T3rSusNH4ivOkUsUxs26hVNa0OnzTF5Y1SgMjz5Tj2trA744Loc1BPexQIIw561Dyz3K1OxRrHfBbvOhi0xuY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b546693-e2d0-45b4-6b09-08dcec426ca9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 11:22:01.7253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPAysjmtqQxHWNnxFbD/GPivUJBZf55Ec0oE8wafP8cbMa7cmnC22eUFxNySS2ZNPYG2ORJ5r0bXUao+e+j5OzIOdx7+AhwO18iQI2TXtfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_09,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410140078
X-Proofpoint-ORIG-GUID: 5HFN3aLsvau0xBpyUQviaPG83zyVjjyl
X-Proofpoint-GUID: 5HFN3aLsvau0xBpyUQviaPG83zyVjjyl

On Fri, Oct 11, 2024 at 01:55:42PM -0700, Suren Baghdasaryan wrote:
> On Fri, Oct 11, 2024 at 11:12 AM Jann Horn <jannh@google.com> wrote:
> >
> > On Fri, Sep 27, 2024 at 2:51 PM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > Implement a new lightweight guard page feature, that is regions of userland
> > > virtual memory that, when accessed, cause a fatal signal to arise.
> > [...]
> > > ---
> > >  arch/alpha/include/uapi/asm/mman.h     |   3 +
> > >  arch/mips/include/uapi/asm/mman.h      |   3 +
> > >  arch/parisc/include/uapi/asm/mman.h    |   3 +
> > >  arch/xtensa/include/uapi/asm/mman.h    |   3 +
> > >  include/uapi/asm-generic/mman-common.h |   3 +
> >
> > I kinda wonder if we could start moving the parts of those headers
> > that are the same for all architectures to include/uapi/linux/mman.h
> > instead... but that's maybe out of scope for this series.
> >
> > [...]
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index e871a72a6c32..7216e10723ae 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -60,6 +60,7 @@ static int madvise_need_mmap_write(int behavior)
> > >         case MADV_POPULATE_READ:
> > >         case MADV_POPULATE_WRITE:
> > >         case MADV_COLLAPSE:
> > > +       case MADV_GUARD_UNPOISON: /* Only poisoning needs a write lock. */
> >
> > What does poisoning need a write lock for? anon_vma_prepare() doesn't
> > need it (it only needs mmap_lock held for reading),
> > zap_page_range_single() doesn't need it, and pagewalk also doesn't
> > need it as long as the range being walked is covered by a VMA, which
> > it is...
> >
> > I see you set PGWALK_WRLOCK in guard_poison_walk_ops with a comment
> > saying "We might need to install an anon_vma" - is that referring to
> > an older version of the patch where the anon_vma_prepare() call was
> > inside the pagewalk callback or something like that? Either way,
> > anon_vma_prepare() doesn't need write locks (it can't, it has to work
> > from the page fault handling path).
>
> I was wondering about that too and I can't find any reason for
> write-locking the mm for this operation. PGWALK_WRLOCK should also be
> changed to PGWALK_RDLOCK as we are not modifying the VMA.

Indeed, as I said to Jann you're right and I was in error to use this, will
change!

>
> BTW, I'm testing your patchset on Android and so far it is stable!

Thanks!

As there is no significant conceptual pushback to this series, I will
un-RFC and post a version with fixes for the issues Jann raised, as well as
a fix for some xtensa et al. issues with header includes.

>
> >
> > >                 return 0;
> > >         default:
> > >                 /* be safe, default to 1. list exceptions explicitly */
> > [...]
> > > +static long madvise_guard_poison(struct vm_area_struct *vma,
> > > +                                struct vm_area_struct **prev,
> > > +                                unsigned long start, unsigned long end)
> > > +{
> > > +       long err;
> > > +       bool retried = false;
> > > +
> > > +       *prev = vma;
> > > +       if (!is_valid_guard_vma(vma, /* allow_locked = */false))
> > > +               return -EINVAL;
> > > +
> > > +       /*
> > > +        * Optimistically try to install the guard poison pages first. If any
> > > +        * non-guard pages are encountered, give up and zap the range before
> > > +        * trying again.
> > > +        */
> > > +       while (true) {
> > > +               unsigned long num_installed = 0;
> > > +
> > > +               /* Returns < 0 on error, == 0 if success, > 0 if zap needed. */
> > > +               err = walk_page_range_mm(vma->vm_mm, start, end,
> > > +                                        &guard_poison_walk_ops,
> > > +                                        &num_installed);
> > > +               /*
> > > +                * If we install poison markers, then the range is no longer
> > > +                * empty from a page table perspective and therefore it's
> > > +                * appropriate to have an anon_vma.
> > > +                *
> > > +                * This ensures that on fork, we copy page tables correctly.
> > > +                */
> > > +               if (err >= 0 && num_installed > 0) {
> > > +                       int err_anon = anon_vma_prepare(vma);
> >
> > I'd move this up, to before we create poison PTEs. There's no harm in
> > attaching an anon_vma to the VMA even if the rest of the operation
> > fails; and I think it would be weird to have error paths that don't
> > attach an anon_vma even though they .
> >
> > > +                       if (err_anon)
> > > +                               err = err_anon;
> > > +               }
> > > +
> > > +               if (err <= 0)
> > > +                       return err;
> > > +
> > > +               if (!retried)
> > > +                       /*
> > > +                        * OK some of the range have non-guard pages mapped, zap
> > > +                        * them. This leaves existing guard pages in place.
> > > +                        */
> > > +                       zap_page_range_single(vma, start, end - start, NULL);
> > > +               else
> > > +                       /*
> > > +                        * If we reach here, then there is a racing fault that
> > > +                        * has populated the PTE after we zapped. Give up and
> > > +                        * let the user know to try again.
> > > +                        */
> > > +                       return -EAGAIN;
> >
> > Hmm, yeah, it would be nice if we could avoid telling userspace to
> > loop on -EAGAIN but I guess we don't have any particularly good
> > options here? Well, we could bail out with -EINTR if a (fatal?) signal
> > is pending and otherwise keep looping... if we'd tell userspace "try
> > again on -EAGAIN", we might as well do that in the kernel...
> >
> > (Personally I would put curly braces around these branches because
> > they occupy multiple lines, though the coding style doesn't explicitly
> > say that, so I guess maybe it's a matter of personal preference...
> > adding curly braces here would match what is done, for example, in
> > relocate_vma_down().)
> >
> > > +               retried = true;
> > > +       }
> > > +}
> > > +
> > > +static int guard_unpoison_pte_entry(pte_t *pte, unsigned long addr,
> > > +                                   unsigned long next, struct mm_walk *walk)
> > > +{
> > > +       pte_t ptent = ptep_get(pte);
> > > +
> > > +       if (is_guard_pte_marker(ptent)) {
> > > +               /* Simply clear the PTE marker. */
> > > +               pte_clear_not_present_full(walk->mm, addr, pte, true);
> >
> > I think that last parameter probably should be "false"? The sparc code
> > calls it "fullmm", which is a term the MM code uses when talking about
> > operations that remove all mappings in the entire mm_struct because
> > the process has died, which allows using some faster special-case
> > version of TLB shootdown or something along those lines.
> >
> > > +               update_mmu_cache(walk->vma, addr, pte);
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static const struct mm_walk_ops guard_unpoison_walk_ops = {
> > > +       .pte_entry              = guard_unpoison_pte_entry,
> > > +       .walk_lock              = PGWALK_RDLOCK,
> > > +};
> >
> > It is a _little_ weird that unpoisoning creates page tables when they
> > don't already exist, which will also prevent creating THP entries on
> > fault in such areas afterwards... but I guess it doesn't really matter
> > given that poisoning has that effect, too, and you probably usually
> > won't call MADV_GUARD_UNPOISON on an area that hasn't been poisoned
> > before... so I guess this is not an actionable comment.

