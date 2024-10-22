Return-Path: <linux-arch+bounces-8431-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A1D9AB7E1
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 22:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12242842AA
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 20:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDD01CB315;
	Tue, 22 Oct 2024 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jxlyGc8H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eXV6ivvW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BA512B93;
	Tue, 22 Oct 2024 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629996; cv=fail; b=RHbtrFM6Ls4HjLkNn/YZrcLV2QvQ8fSip6jpM9Ylrx8ipOEnFuilT1kEQk55bykEERVYwDcEBFla3VypSWEsfGwMl+2IsC0ubR9xnnLfALPvVUcW+ctEYYmHTWkgoxiu1+SNx6REh1GisSig78mQJ4vIw/7GcBYp7IqxK4fpd1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629996; c=relaxed/simple;
	bh=QtjUbMh2r0fBnCNNEQ+FZNWCfivh+La+JIJNY3vdTUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KaUXE1/qEeWArA7QnCaGTve88Tb64VjQI+MytV5/RErqip/0TrYsk5zPRJMXruHwYQvFsykYVOt4eH3Pe5g+Snehp+01ik5Exiw471qGuwqkWdbxraj6RQkGX5QVczUgwerFma3tnKT0wVmJTILTle8ZGwiO+u+eqy80UGW9gPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jxlyGc8H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eXV6ivvW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MK3YO6004902;
	Tue, 22 Oct 2024 20:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+nus8Xrp8j5XotQ3pGgSzwK1AZHKD0WT78VBFXRPAX4=; b=
	jxlyGc8H2PLGg1ndFR4+Qa1gFv17jumkX4SyE7c+xhdYbYmCdbpMk7T8DtIWSICS
	q+H+pG0gcNFw3tllblV4KFGozV/s7AQuIsqibyCe4rIlM64LmkRKPEukiIVy31Db
	S+WQWEUaADi0L89S/zcKjH9KcdS+zkn4Reu5kZfhtU+/nUFZZhxYPVZza7BqvRrr
	1NBcHwjEjEWAbD5siWVtK/lzMSOtWaWveCy7ZNVKNwEJ/Db2Wz2rFXwyeheNoX/o
	eP66h4Zz6IapCJrfvGZ5Z2Z1o84dZZDK+dU6S/LDPBiHsVfdhJk1o4vnjZPhf8GG
	hKbP7Vx2n8PnGhHNsBZkUw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55uxn9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:45:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MK8tcI023392;
	Tue, 22 Oct 2024 20:45:38 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c8ew38w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:45:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Brb9HOSnuH/OyhvZxyc/wXpXUzsuKy6VedD7BR3pPYli0xIsFjMG2Cd2OfjLwlGvse01lcZe+fvBTIqUYiFpSQNLDEicZsPIjViERsbIXZkxtol/U7zJjIjqsQTuvbBemdFe+3lLld8MMR/w8lRsOX2+8xLbzJy5stcvMDph5z3DJzhHeeW8ZSFUk3wa87NdqdBFj2dPFyRlY5fjeKNiPY51+8B88oV9hZSBSl7n4QYtfjjm82HVQU3tSrkI9yn82r2YhBftXXN2FboLfFVJGDWFwUZPmTv9qsYYy+1voIr47Oezb4Y8/Px09ItHYgyMEvW+FkPlaTrJLZ1xLDAykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nus8Xrp8j5XotQ3pGgSzwK1AZHKD0WT78VBFXRPAX4=;
 b=Ux50Nm7Bv1TKBLqFSurA+HJ2xVP/ff5W8b3gRbxMesKyRsWuAat3PeTkvSvnPSSdH3bs4kzwY5zXlWrsp1Npy9duaFPIyBOs30Hc2UpGtP+VI/jIE9LqRyHSjNyyjEuaw0flpY35g/1lB+0WSglKBQn3mO36bFxg417ryeMZpWrQ5kkHrrE/WbAZ+o1wBDLvG1+sv7L+r9VeDeQUIu/MBNwB1LCRUm/+UD0f0ASyAxUMmsgGRE0DsCGJ9HrVRoAvAREk/4m9x1d03YcZqYEKfRD0SoOarPtgcndNSr6YTas6L+shVW52DQt6aYROiQDl0PIZ5/cE9FiAFURyEGkhnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nus8Xrp8j5XotQ3pGgSzwK1AZHKD0WT78VBFXRPAX4=;
 b=eXV6ivvW9pfnkb79IuKqQLW9w65dXu0Ph3WFFw1DQ+vtVDV/rYFUbEK3fFbOIYokn5Maw+sLPQOqfhYGXSkc+Wt0xBVzNd1J1PjCL5JfSz7ghW80NuYUh8MpC9mSxqdwYgnouEDJwVXmO39H+gmna+xYqcbhS9lk3Y6FmiVmOJo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB6054.namprd10.prod.outlook.com (2603:10b6:8:cd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.26; Tue, 22 Oct 2024 20:45:33 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 20:45:33 +0000
Date: Tue, 22 Oct 2024 21:45:30 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
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
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 3/5] mm: madvise: implement lightweight guard page
 mechanism
Message-ID: <5afafb29-85d8-4d51-8a7f-be2186224e7d@lucifer.local>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
 <c37ada68-5bf5-4ca5-9de8-c0838160c443@suse.cz>
 <393b0932-1c52-4d59-9466-e5e6184a7daf@lucifer.local>
 <f2448c59-0456-49e8-9676-609629227808@suse.cz>
 <CAG48ez3WS3EH9DuhE1b+7AX3+1=dVtd1M7y_5Ev4Shp2YxiYWg@mail.gmail.com>
 <2647d37b-3482-4fc9-8da2-1158ebdc919e@lucifer.local>
 <CAG48ez2rrHeq5aNPA9pB-1T6n1WjCh+g+8Hp4QrZemqVb6UsYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2rrHeq5aNPA9pB-1T6n1WjCh+g+8Hp4QrZemqVb6UsYg@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0234.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::23) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4aa590-4612-49d0-bf26-08dcf2da7964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVRLVWJRMWdHWFZRL3VDOTdLaElNZWYrQXc0dWFQVGV2Nk84Tk14N3lTbU1l?=
 =?utf-8?B?WUxMWFhVSFkrMVZ6ZTVPTmRZV1JoTFpKQXdFTlZldHJaRWxPbURucWFFaE5C?=
 =?utf-8?B?UG90aFhsRlB6OUgvaHk2dlo1WlFHYjI5WDZKd2pXMVZlemNWdWxRZXl4MzJ5?=
 =?utf-8?B?cjlJVmZrZkhvYVlFYUhHejdDZU56L3MrWE1TNzVtd002Qm5qcWxBVE5LTmF3?=
 =?utf-8?B?ZFg5N2lIN1NpQUlOZWpMdWc1RHU4ZlFnSHVZRnoxa3BvdFJneXBVbzJhOUE5?=
 =?utf-8?B?YVYyM2NuaFdWVVBCQnQ0VHpoaVhLRkVOMm9JQWk4VG1reGF5ZnR4b2hhUGFI?=
 =?utf-8?B?ZmNGY2hxODd5YUZVSEdIUUhrb1JiWVEyQkVKZkVJYlIwYlZZUFFSVGx1WWRY?=
 =?utf-8?B?cWZlTjRRMWY1NENmNXNZbURJSFlGUkxTZVEyd0x3R2VhY2V3cDk1eThlbkta?=
 =?utf-8?B?cHpBSkp5WUh4OHRWWnp2QVdxOUhBOHFMRW9UV3d0dUZnU0FsWitsdXJVa0JV?=
 =?utf-8?B?SGl2bDZTazlPdWtTMHpXakpqMkVYWHI5cTN1aEM0b3B2RzVWelI1bzJWdXF5?=
 =?utf-8?B?OHZSN044TmlQb2IrVUc4OVVPcXhUbmV3aVdjdllLcjFmYVVVbElnNG05QWl5?=
 =?utf-8?B?UmVMa2VUR0dZRVUzeFRxMGl4SUMyRVh4emdubkhpSW9KNSt1VGxKZGorQStm?=
 =?utf-8?B?eldvb2dna0FEMTBhckxGMEJlUnlSM3ZnbncwaU9CbVRjenNUOUVNak8zOEJu?=
 =?utf-8?B?ZEVZQnNRUUhPdGVlSFEvMVZyU0trdm5pd2twY29ZRDJoKzF2ZmU2bDVRbHRu?=
 =?utf-8?B?L3lPNHpxRE81cjErUWE3YXJEZ3crT085RmswMGFtR1N4bzRJY1hQZkhpV0R2?=
 =?utf-8?B?UlZkbndCVU5tWmN2MTlOeS8vWitlL3dBZWhJdDhCWllnb0YrbWlISTlKdHh3?=
 =?utf-8?B?aW9yMzRBUXR5UnllOGlYMUREODB4UUlvVWJxRG4yTlRWbko2RGlvajRNMFo4?=
 =?utf-8?B?RXV2R0hFVWFLcHByQm9PWTZuNUZVZi9HTGN5L3FoNkJQU1lNUHVobFlLRnlV?=
 =?utf-8?B?b29BWVB4T3BGTzQ5a3ovLzRoQkp5UXREK3pjazVEcURoRE4zamdmcnlldit4?=
 =?utf-8?B?ekdxMEZxU2VkeHRwcW0vWERndlBZUkxOcWNSVUUwcTM4UVcyMlNZTkw3elhQ?=
 =?utf-8?B?L1VKMzlzRVJQMGRtdkZxQWl3WWdrMWFjSlVQM2tCSWo1RFBYeTZKK0dVaGNB?=
 =?utf-8?B?L1JxSFdNQ1pBRlM5Vk81UC8vMjkvQ29Wd0NmR3VVQUd0UkFDdWF2RVBSRGVk?=
 =?utf-8?B?Q0crcGtIaGt2ZW9BOGdFbS9CWGNldzk5YU1EQmV6R3R3RCtTU1ViNUJzSE1M?=
 =?utf-8?B?dy82WTlTRE5jY3VoTFJBUjZxbXFkUkY1bHlqYjBGSDY1NE85THhzUFlheUZS?=
 =?utf-8?B?U2ZpdUZ4eExiam9qdE80MmRWWlpWaU95VFcrdklBemczSDVZV3ZyRkdqdXJm?=
 =?utf-8?B?dEI3OXdiRE9XNjZzT0FMQ2tORERNMlZDelJjMEwyaHY3VS9TNHhyZjlJTDFO?=
 =?utf-8?B?RERtY1RCVUYzR0UwL2JLMkVRczNLcllQdnFvUS9EcHRBcjl1eE42TmdMZ1ND?=
 =?utf-8?B?TG96M1N3OE9ER2sxRmsrSTZha1piVE1oeWc3OWMrWmQ3UnFHVmhYYVBPRE5C?=
 =?utf-8?B?aklxRmRaMUgzZW1kK0YxS0kyMWVLSTQwcjBORHE0Y1JMVmtlZXRjRmNwWDNl?=
 =?utf-8?Q?FvL5dmVXsAPukxQ9vtCSJnV5R9K9z1QC6OiCCOd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDBhb2FlRXdVTnZpemRESVdqMjU0QVpIWnpMK1RvWW0xKzBhQUlTU0xMMFo4?=
 =?utf-8?B?LzR6SkhOSkZ4bTBCd1ljOStPUlVSMFJuU0RTaEVzdDlkdVN2S1lJZ3R1Mzdv?=
 =?utf-8?B?Wk1WZm1lWmdEZmFHYk15Q3NONENpc01sWERhWUQ4aGQzWkc3K1Z5dHNWU1B4?=
 =?utf-8?B?dGoyMFdmeXg3aDQ5d3lUb00zNkR1dzc2SXdwWlg1OWdVTjJ5UlV6alErbmRI?=
 =?utf-8?B?bGFNdFU0T2RvVXFLQkhDVjZWRUhCeWFHc2JIY1Fza1FEZWNnM0xRTWEzOGd1?=
 =?utf-8?B?dVNyRDZ4a3ZSMlhGb1VrWHgvZkN6NUJQRDByNTd0dGxXNTlHbkFtWkZPaUp1?=
 =?utf-8?B?Mnl1QjlmbnpON3J2UXN0THB3K01jaDZEOTZVdHROQnpwOXR3aXhZYUxvNFFq?=
 =?utf-8?B?Q1pXQ0FRdm40U2RQZDRVQkRSRjBiWTZ5MXZnQldLQkVFTE5CTW9Pa1YzK2Nn?=
 =?utf-8?B?ZnhsWWs3SjZQOVNYZjNGSU1DUzNuRDlYakd2WXVXNGFVeGlNMGtMZWo3eUI4?=
 =?utf-8?B?c0YrdDhqREVRaFZzcDlsdnpUZE9VdC9rbEtGUEVja0pzdkF2SHp4SUVXYkF3?=
 =?utf-8?B?ZVE0NVk1Zkl4QnZialFXTmdSM1YrR1ZaTXd3dEpWYlhTa1IyUXkxN1Q5OUdq?=
 =?utf-8?B?bXJYSlY3UTc2L21XSEJHTWJLOHNrUkJ1WHJEUG5GWmVldmxlK1NDTzFFczFZ?=
 =?utf-8?B?QzhGNnUwaElTdnNpdHhrWFk1eDFKWFBMWGtWaHZQeFRLNjRGZ2lxc0d3dTRN?=
 =?utf-8?B?RCtqVWk2bEpsbC9pK09oTXNKdThzeVJnME5PdStseUVJR0lZTmVwekI1MG1N?=
 =?utf-8?B?RmNBMU04WEdGK1FuK3QwbkZKU3l4Z1M3SXE5TC9RR1JXZWZOeWVOK2xLM0xp?=
 =?utf-8?B?VzFncFZ1dGZkQW5mWkM2QnlzRFA5dVZ5S0VhdlA5UVI2NmIxc1ZDL0VDSngw?=
 =?utf-8?B?SEpiOUFvOFlXek1BZHFUNXk3YXVBOFYwMWtqckV0aUU4T1FFbkV1VXhjNUk3?=
 =?utf-8?B?b2FGdHFVTUw4a2RGS0V6MDY1QVZvRy9MazlrSmM1S3UrWDJhMWdDd2pPSlcv?=
 =?utf-8?B?RFplK2t1d21lR1ZEV1YzcjgwcFBMWk80VTdJQmE4Qk5BTUZnNllUZkVQdUt2?=
 =?utf-8?B?bVE5bFhmeUIzNjNiQUQrUE9KVXB0VE1YcEdzZ1l3WlBWOEphN3ZBVWQ1Q2o0?=
 =?utf-8?B?ZzdQTytsTDBiRkdDZmpiQmk1cWloSWl3Z29lMksxWVI5UU4rbzA3aS9ma3Fm?=
 =?utf-8?B?Q0VIajBZNG5rcnJVZGNZYTNCNGpPZVQ5WDRjS3h5M1gzYkh4N0RkRWxkRE96?=
 =?utf-8?B?OE9vaWYvcW5naG1YdFRiOFhlQzFDaFJPMWlKTzlWaEY5bXIveUo2K1hSYUtQ?=
 =?utf-8?B?aDNGeXBGbm0rV1RTUHNUVmo0RDRSVVhzRXpkQklsSTdkUjVMQmhlTUNzUUky?=
 =?utf-8?B?SE9jUWdMZjFkc0JnZU42bENwRFZ1UmU2aEhkeFFGeXk1cDQ3UTVNMU5hZjZl?=
 =?utf-8?B?QnAraWduLzZleHFJdS9iNzJTSFl0bmhPcjIyTytTdEMvc01xYlJ2dFdJRml5?=
 =?utf-8?B?RnNsOTZRbmx6MlhqdUwyRzdpRDRUbGtIbUlBSzE5TlBJaWs5cEZqQjJma2k1?=
 =?utf-8?B?L0pHVVBkZmhZY2pJSkhkenN2MVhvajdRQll1V3hNSXdaalNKTmgxbkg2QkhN?=
 =?utf-8?B?Ulp5OEtJL1I1aTArdVIwdnVSTjJudUQvWURnZmQ2Sy96aDE5ZGg2cWFJVGlX?=
 =?utf-8?B?aUh1dGZ3UnQrS2pqU1l0V3RKS2VTUEk0VjUzQStaVXFKSzk5L2JmNUdrVkJr?=
 =?utf-8?B?UVhPcGtocitGenZSeGdORzJvWUM1Mlo1MkZnUXRHZTlWQ05nN0gvbjd0UHEv?=
 =?utf-8?B?b1NNTTE1OTYyalhEZWExcEdKdUlTK0cyRnRZWTVibTVIYklkWENPVFJFdnow?=
 =?utf-8?B?cGhBbmFoSlZLeWtJTlJOV2wvNGN1YzhkcWh6c0J0ZkhaNXdwREJuT1puWTdi?=
 =?utf-8?B?ODA0ZkFQTlpidnV3QWd4cTh0UnV5MTltck41Nk5OMTV5aDV4REdTWkQ1cmRv?=
 =?utf-8?B?azljQk5aRUpOSEVaQ3AyS2VhM0xXS05kaHR2NnJKRnppRjAwejZmOEplcEZR?=
 =?utf-8?B?TDRUcEtVaXJWR0RuTThoUVNDaDltaWdPRW9JU3ZkZFMvOFZERlRjWUdERUVv?=
 =?utf-8?B?bjFTeWsvRGdPd2pLWURiT0lTRldYdEsvMStVSi9DOWdRZThYa1RmWFlsdXRF?=
 =?utf-8?B?WDFlczNrcUVQM2dta2hjZWU2a25BPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ymNqwnu0nNwbBJtWh/HQSR+w4ZVY5pUA2Hc+5rUPhLj21cKLgNS9BLTB5v/w2I/6DIDaoKnJADyFP0TshspzdxQvVDQDjNf5jMGRMoB2kjkNZ42MU/uRWNnh5qUsnx2stDG/rIQrUjJqsUXJQ9x018gSna82XE029m+sgSjUc/PZ26Vvv/G00qjCuQHEKTJZrTo5b7wkSSxw2eiDFe2n4Kbnn+868CcwPY4zMZCGNd+KPNlNqA6wjiLWbMWl0IYwtXmchxXcoGn7QNRaCHlKIrMVN+9C5oIae/4u6f4nbEHc5KnwaycerKoINDcEc3eguSJy6qweVpS+UTcmeG1nKQl5JYrzlEGy1ONqvMv9CO3HQILdp3WdS0dYUJOMxktPUF742fjpSMqYBi5HyVwykx32Wzjpejf4xuoNJ5m2TzUQbRP6j9fnVOb+mcinScLvx0L2bNa4HBZ9P1VtCWI3Ys/OT4V+fOvd4bxKwDNAUgYXuC4A7Swesgb7/r7HBsNBXit63/K5w8QLDX0gQCsBi9qqZsFSkd8WxWzUpegme3G/2pvTV+J2d/S89r/HXz37VsoAQUWAtFQ0SAOfQCNZmer2gbFnP16sGd2Mf47LEmU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4aa590-4612-49d0-bf26-08dcf2da7964
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 20:45:33.6058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhwCx/lInlPWUkxni1Q3FAfBnmEfByt2rpqzCMRSr6+gM8SAwE9Au0uCgrsoCUqmPx7eBNARtkKm6fhh07inCypS82ZMODwqqKCaAz+rrw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_21,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=851 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410220135
X-Proofpoint-GUID: 499eZyXLxVLNYra2VEX3SMLxpoO10bzC
X-Proofpoint-ORIG-GUID: 499eZyXLxVLNYra2VEX3SMLxpoO10bzC

On Tue, Oct 22, 2024 at 09:57:39PM +0200, Jann Horn wrote:
> On Tue, Oct 22, 2024 at 9:35 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Tue, Oct 22, 2024 at 09:08:53PM +0200, Jann Horn wrote:
> > > On Mon, Oct 21, 2024 at 10:46 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> > > > On 10/21/24 22:27, Lorenzo Stoakes wrote:
> > > > > On Mon, Oct 21, 2024 at 10:11:29PM +0200, Vlastimil Babka wrote:
> > > > >> On 10/20/24 18:20, Lorenzo Stoakes wrote:
> > > > >> > +  while (true) {
> > > > >> > +          /* Returns < 0 on error, == 0 if success, > 0 if zap needed. */
> > > > >> > +          err = walk_page_range_mm(vma->vm_mm, start, end,
> > > > >> > +                                   &guard_poison_walk_ops, NULL);
> > > > >> > +          if (err <= 0)
> > > > >> > +                  return err;
> > > > >> > +
> > > > >> > +          /*
> > > > >> > +           * OK some of the range have non-guard pages mapped, zap
> > > > >> > +           * them. This leaves existing guard pages in place.
> > > > >> > +           */
> > > > >> > +          zap_page_range_single(vma, start, end - start, NULL);
> > > > >>
> > > > >> ... however the potentially endless loop doesn't seem great. Could a
> > > > >> malicious program keep refaulting the range (ignoring any segfaults if it
> > > > >> loses a race) with one thread while failing to make progress here with
> > > > >> another thread? Is that ok because it would only punish itself?
> > > > >
> > > > > Sigh. Again, I don't think you've read the previous series have you? Or
> > > > > even the changelog... I added this as Jann asked for it. Originally we'd
> > > > > -EAGAIN if we got raced. See the discussion over in v1 for details.
> > > > >
> > > > > I did it that way specifically to avoid such things, but Jann didn't appear
> > > > > to think it was a problem.
> > > >
> > > > If Jann is fine with this then it must be secure enough.
> > >
> > > My thinking there was:
> > >
> > > We can legitimately race with adjacent faults populating the area
> > > we're operating on with THP pages; as long as the zapping and
> > > poison-marker-setting are separate, *someone* will have to do the
> > > retry. Either we do it in the kernel, or we tell userspace to handle
> > > it, but having the kernel take care of it is preferable because it
> > > makes the stable UAPI less messy.
> > >
> > > One easy way to do it in the kernel would be to return -ERESTARTNOINTR
> > > after the zap_page_range_single() instead of jumping back up, which in
> > > terms of locking and signal handling and such would be equivalent to
> > > looping in userspace (because really that's what -ERESTARTNOINTR does
> > > - it returns out to userspace and moves the instruction pointer back
> > > to restart the syscall). Though if we do that immediately, it might
> > > make MADV_POISON unnecessarily slow, so we should probably retry once
> > > before doing that. The other easy way is to just loop here.
> >
> > Yes we should definitely retry probably a few times to cover the rare
> > situation of a THP race as you describe under non-abusive circumstances.
> >
> > >
> > > The cond_resched() and pending fatal signal check mean that (except on
> > > CONFIG_PREEMPT_NONE) the only differences between the current
> > > implementation and looping in userspace are that we don't handle
> > > non-fatal signals in between iterations and that we keep hogging the
> > > mmap_lock in read mode. We do already have a bunch of codepaths that
> > > retry on concurrent page table changes, like when zap_pte_range()
> > > encounters a pte_offset_map_lock() failure; though I guess the
> > > difference is that the retry on those is just a couple instructions,
> > > which would be harder to race consistently, while here we redo walks
> > > across the entire range, which should be fairly easy to race
> > > repeatedly.
> > >
> > > So I guess you have a point that this might be the easiest way to
> > > stall other tasks that are trying to take mmap_lock for an extended
> > > amount of time, I did not fully consider that... and then I guess you
> > > could use that to slow down usercopy fault handling (once the lock
> > > switches to handoff mode because of a stalled writer?) or slow down
> > > other processes trying to read /proc/$pid/cmdline?
> >
> > Hm does that need a write lock?
>
> No, but if you have one reader that is hogging the rwsem, and then a
> writer is queued up on the rwsem afterwards, I think new readers will
> sometimes be queued up behind the writer. So even though the rwsem is
> only actually held by a reader, new readers can't immediately take the
> rwsem because the rwsem code thinks that would be unfair to a pending
> writer who just wants to make some quick change. I'm not super
> familiar with this code, but basically I think it works roughly like
> this:
>
> If the rwsem code notices that a bunch of readers are preventing a
> writer from taking the lock, the rwsem code will start queuing new
> readers behind the queued writer. You can see in rwsem_read_trylock()
> that the trylock fastpath is skipped if anyone is waiting on the rwsem
> or the handoff flag is set, and in rwsem_down_read_slowpath() the
> "reader optimistic lock stealing" path is skipped if the lock is
> currently held by multiple readers or if the handoff bit is set.
>
> The handoff bit can be set in rwsem_try_write_lock() by a writer "if
> it is an RT task or wait in the wait queue for too long". Basically I
> think it means something like "I think other users of the lock are
> hogging it more than they should, stop stealing the lock from me".
> And the RWSEM_WAIT_TIMEOUT for triggering handoff mode is pretty
> short, RWSEM_WAIT_TIMEOUT is defined to something like 4ms, so I think
> that's how long writers tolerate the lock being hogged by readers
> before they prevent new readers from stealing the lock.

Ack makes sense! -ERESTARTNOINTR should help resolve this so definitely
unless anybody has any objection to that I'll go ahead and do a respin
taking that approach (+ all otehr fixes) for v2.

Thanks for your input!

