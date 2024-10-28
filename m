Return-Path: <linux-arch+bounces-8669-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDB69B3DA9
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 23:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7679280EC2
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 22:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B991EE00D;
	Mon, 28 Oct 2024 22:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U3poT4r2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wsfbg/G1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD24A2E414;
	Mon, 28 Oct 2024 22:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730154164; cv=fail; b=Uujrvxl2Qocs3eZVMZTIKtei46wSHFcBKV+7Wsc0U42WDQkHd4S/6MS3pEANKVCHkDS/36CBKdVau8gWR6WseCEBw0MmGkL2k8tgRCLUi3Zu8vT3spmZVbfHI2z7DgkzIHIVI3Xjz+JAOxTNTcmCx+8kzTEAMyTp11kfbSpCrXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730154164; c=relaxed/simple;
	bh=Wk6bq8JkGB7GPfXtvt57DYu76nZLtpeo37nvOiFQ7WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VwSYPl4LDoqV0FUQOT0zaqpZ8lcqPs29Ai7lVdEyXvp5KaFdmRroXTuMGBKvPpGAViCipc7hsXxBNpHSjm02Sa9Yfo83NI0FsXlHhqU+3eisynvmIrMkAIL17y0EvAjg46MMq8TSEtzWyPnXVzY5XWbPajPugRPGiTOb/ww0V6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U3poT4r2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wsfbg/G1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SKtaqR024333;
	Mon, 28 Oct 2024 22:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=cBF5TGeKKuIIS1jRZw
	xQv8r99f4XGNrlTUQb8CpUUtI=; b=U3poT4r2aWze1UhpctdQUUkF0StRWjoupf
	yH/NH0mtaMFYYvumjiVn715QNeLB2C3MXGOutUQxuK1VCCrryqNOd6gvvEObjntq
	wXBalY92wxKBeuk/fEhw/QlPp9qgLcR9Yi65zxXUoeJlgSsrMRla+bQo7leHEPwZ
	CiSksHVu1G852wSJZpdUSbSZKDZXj01o1wWdqJYu/SO9nEK/1DEAn09878LNkXj2
	9+tJVoV+2Mj+vWMLDDuvF7SVurIgjf2mkcv1pbplPsALBNVCTDgQWgzv/aop7JRW
	iQiTDJZkAmKJGzvzRztQ1rPQDrpExfEBW89HL2R9wNmv7fWjm4Ag==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqc21x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 22:22:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SKiTDu040616;
	Mon, 28 Oct 2024 22:22:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hnan5jem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 22:22:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YY+Sw4mU8pNDINDUwyGMCW12QVRLAJVf8goo3f9Blsq22MKJzAFz1sKOUuKT+GIG3hKx3Um7nNsCdHEion5nGlKgDPFMfWxa1hDZ2G8oorZaOu63iEdKYHgUsbrZl0NqcZgJ7PXPgzYGOoNIoqPW1fSriE4N2umspaSGXvajoOckCjBG3d6Nithn2/m1BC9ySkFq3Bqo3ITPJ+GYcDQguS6TfRf63Mdi6dTfXSt1z2D8Y6vxJRQ3w9LjbEY+JSgM0xkWczN6oevsOusYVwsz/JtwmVFN66VVmFXYVRXwuZUMsOcpYQm5wm1rY2iW3JO0MDYp1RN7zKC5itJpo0TBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBF5TGeKKuIIS1jRZwxQv8r99f4XGNrlTUQb8CpUUtI=;
 b=Ny4HWDzJgzEW1zz4a2xFjZZp3g8BooUrndUOqOj54o1O/NCw/08IkM1RVcBh9nMDaPNkpY1Tq9UeOr6krPIKewr/US52irIQqcdCH3tczhw92X8zdJgkbxxXxVVT6ak1Bk4b9rq1u4RGWl83NfLxmejXYkyNZQdZnGgKAwYo1YzvMTCvJ25cpskAmOkhR8NspoYSr9jXyKCAFpCg/xoT1bE+McocXnyGOOzwEuUzBNoR6eykxNoGvC6aQ8pAu9S/bVySOl2G+yRLk0i5hGofRmA8xbuSNB9+68ouQob79DUGf8jY9QF7DaV3i3zGs2VzLOnmffRTm77IzPv9k6n8wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBF5TGeKKuIIS1jRZwxQv8r99f4XGNrlTUQb8CpUUtI=;
 b=wsfbg/G1r2dxJg4L5KMDzWBmmp0i0ZRiEn5ym8OfyojgBDGFpvE+n3ObCI+FTo4I+G8lALHvYPz88lssiRJ2kvffUfCRCCm1hycKLo8Q9jfb77PQ4C5e/fNq/vpo2a3EpyXQbUzhB5nwRcji15N+dDgMlckK3nGcOYsWeewn7DM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB7270.namprd10.prod.outlook.com (2603:10b6:8:f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 22:22:07 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 22:22:07 +0000
Date: Mon, 28 Oct 2024 22:22:05 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@kernel.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 0/5] implement lightweight guard pages
Message-ID: <114723fd-131c-44f4-be0a-3387dcc540f1@lucifer.local>
References: <cover.1730123433.git.lorenzo.stoakes@oracle.com>
 <20241028182413.277218-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028182413.277218-1-sj@kernel.org>
X-ClientProxiedBy: LO4P302CA0019.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: aea4ad01-f248-4ddb-a8da-08dcf79ef595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A9vH3nX3/bbvGaCoeSnzuqITf0nnNNX92hxaiSBhuXbCVvpBFogtIYtYkInO?=
 =?us-ascii?Q?V97ENUTW/tg7F3c41WG5FQZJqC3gCCBvFdsBZUOu9qiMpAcsPWon+6tyVRTB?=
 =?us-ascii?Q?pXPsbtLSoh6mpl9nwFurVoR7jGjwUWqpOq9qoLGgJbbxpn9Dg9pLuJcOVaD7?=
 =?us-ascii?Q?epmXICBeni4Bf4JMAd3kuiU8f/Dm0C0l4ft5iEzmUWFKOT6DGj7ab8U/goVu?=
 =?us-ascii?Q?zYH+3sueAWmCiIwBKTyOY+vLwfwK+CrZ8QawbCkTrI6bYB5/TShyQUxcITeh?=
 =?us-ascii?Q?3t7LGEhk2kQ99Q3+s3rOybww34/w8ppPEKpQw9WOH5COaqt+TkuyKIbjNDT8?=
 =?us-ascii?Q?x1XQfnoiaa0bcmdbkueVM/nK2H3A88zMP4Y3JglOa6iOPUVRjtSCx3dR9SKa?=
 =?us-ascii?Q?bCTsgJxnmzwZj63F5tUXwM7a3wjsUYX9rJPcEtozjVsDLHw29ch9G+ONQOeP?=
 =?us-ascii?Q?OG/FhB1X+yt3zD/6aelObVg+5+0RsVW2soykT7NWiCk535zmXV/Cq/qPVIls?=
 =?us-ascii?Q?5kXp3ev6WvWYquJFpxAwEFVUOXNldg7VWjSXpgNAWp3E4EzHA999Y25RGqsr?=
 =?us-ascii?Q?4HoaWOEoL1IRT+CGyTwdBRI8xPNWXg1OmlC7MSIgHnlVwFbDdF2xBUytHCoa?=
 =?us-ascii?Q?Z5srjCtkgadi2KS1RqCp+oQngvikbsO0XuqgjqrSyvZldqyt1CDg1dAp6NGT?=
 =?us-ascii?Q?Dx9Ei7yYphwCN/06fR9eYOPmghKohz++39/OT4ogD2QZG+0sBuKyH5x3CS2j?=
 =?us-ascii?Q?FqcQWyHVOzp2TGE5m8ylqjT3jbp+4ityGBrouol8ppyGtOtVOJDThocp+1+5?=
 =?us-ascii?Q?bZV1IkRuyWdcG4j0a1YTL9hAGxzDIeKiN9h+m+KcGaeoKqFYXl5u+oPEgpEs?=
 =?us-ascii?Q?ZWNj2PSAl4x11X6+gLeEVROq1f39DB3upkx20OBZwmihGJxE6/LeQctLCHUP?=
 =?us-ascii?Q?pwtYVbktV6u+3muNd4hCvDoKRJGAL83yBYooKkSMkG9fNB2Mxv/3n4y/7wrn?=
 =?us-ascii?Q?wo1arY6mtgU+XEvmwElcHCSToFjcR90vYm/MgiPadIbU/fWoQsT2SA4SsegJ?=
 =?us-ascii?Q?8mLxmQ/xYntmDHrc1nsmfzVo+Me07MtneZF6M691LLk0S2VPAb+/ApAJQMvR?=
 =?us-ascii?Q?g10QBE9f5WR2/jhuAckzsE00Z3gFw+5wsDA+cAgbSNybAK3NAJz5Qirp7cKD?=
 =?us-ascii?Q?/ubaB2Jf/f/6h6oZXlCICNbSlmpD2B0RUyQEhoxCyVvEYhlUWw0th5ccA6dD?=
 =?us-ascii?Q?nW/w42MzrEh0XvKURmZMIWLzQ+baUqFqS1mCiXYIwJLToJqATXNRT2wMy6ci?=
 =?us-ascii?Q?bN46zf2zSIIfGs2mGtI8AT6M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?taKQBo27OaPYq8HZcSb3wWLjGavIbNj/3SJq+MHYssb64dCyY2tOGBSMbXt6?=
 =?us-ascii?Q?VEv4vGWxeTLD3HdyPlxLg4xwhupWQGUJi+Qq8CdYFbJHPM32T+WzrrMO8/Y8?=
 =?us-ascii?Q?G/TPOUswOtR7zL8QF6RitrTPuykMJ3lvv26aT9W4lrKxNFsrWmJjI4wNlgDn?=
 =?us-ascii?Q?qq974OmyyOKP6XrPPimAANtuwAh1GEWnNbF8dfTlH9TTgIda98zf2la0S6Z3?=
 =?us-ascii?Q?2zy+HpVBF+405ob10BGIzByZxSgBAdqawEJGr543TT+lUxqanEHG7TX+jC8H?=
 =?us-ascii?Q?ZitYkzyyUzkF8N4HWUNWytYIIcd+uzYMhIS9bH4rBEcBmNbyufeFevdDsH2Z?=
 =?us-ascii?Q?sMo8G5auzBQKR94lqcfodQjwjNx0YtvU5MHsqhIZ1gJR9haMCpARglVUJzp2?=
 =?us-ascii?Q?485k9ZuLg1veT40HjCbU3TgQRDahUKEpXH9coxrxra36C2A52KMHp2+Hlqav?=
 =?us-ascii?Q?vXwLBvjKNbjZtYWbF8HNW6MJC5H3Yu07XoZC9cbsIxLIXHJEEaVwX6jPPXW9?=
 =?us-ascii?Q?mh3NfmD3QkYLvCx5RX5k1biWJc5E6ZukT3OMkJ5uOnQjcFz6BASqwYBY9zUI?=
 =?us-ascii?Q?bVNCvKVEwWwu1MGS4btOXd2Po9yiazOUUo7CaRfZ6MyE8D6YfcudBQOt221P?=
 =?us-ascii?Q?Qz9wIDUdwGsgHbczGZiXxIHq4UeCqVOAVsDzEf/DC1LT7/q9n+2CLRgL8MZg?=
 =?us-ascii?Q?IHLc7Y29uGTSxeNF4dpU5wWl7Cp7ZIUkHAzWkzAhCpUJqZ1y3pIEWDy2tnpC?=
 =?us-ascii?Q?QHLQxb6GsT24HOCN0DLk3BdrFp9mIx3ItIlIB5PkNVpTJdRoP9dIp4vyREfY?=
 =?us-ascii?Q?6KstpQE3hZAy8hQlXuBFYCLEzev1rOgflZlzWfYqR6TmXbqZ3n3SV59gYJfT?=
 =?us-ascii?Q?+mxCZ8yKOnviaB4XX3dhS2R9nwXh4agP6vdn3bYzpNk+lC+C50O08q9Pv+Ha?=
 =?us-ascii?Q?04mu310lpDLHPT9WOW1psttBRPc66D+Ah3pArWDT0sqmz+uBZXBXtFlXiOjm?=
 =?us-ascii?Q?8VDG9ydLtDwIb/pAK6MAS2L3OwqSBltjXih96kF3Pav3/1wiBwIER6tDANf2?=
 =?us-ascii?Q?Rw3/g7PBTe+PIu9c7ZMDsgs6q4zfFVmEUhfva4BM/Io4f0TNKBCyqU+/oV52?=
 =?us-ascii?Q?0ABoswUFkZ2gYGyZ8ylwYLboylO2xrEg0nSdboUlyEHjhbN5wH7hbp5KJEz/?=
 =?us-ascii?Q?CyxHDQuucAwnhHWc2gv4gl0x6eDzpSnlJY1lY24IFI7/5WqKNcAQD82f7IDP?=
 =?us-ascii?Q?OSoafZcAggDL3/ncztoezAVoJViEFAmH1qos65c+2tkYhwCWFwKrwq8XbvEt?=
 =?us-ascii?Q?x0BOpbijUdkTdoaHn8T5dVh92+3TpuMdi+LFWEZkV2itEE0yuMc65XKiw8EQ?=
 =?us-ascii?Q?RqQU4U1X4Qg/y2a68wnkDDVfQSDD5GzLLtH2sBBY1M3GMWGjYLbk+u+GehB7?=
 =?us-ascii?Q?UWAkxbhxcjK87YBx+CX2bkwPfUUsbnMFTifrkLgg3mdqI3hNBnp4yCDjI2cu?=
 =?us-ascii?Q?UY1RG9WNv3zS0KpbRxQJYdhwJ1k8NnAjnrNbBJUyqgTkqhK6B5tfRY/mGmLn?=
 =?us-ascii?Q?AUeq6X5SoiSa2gSacm6AWsj1Qh4dLqFYQERIqGWaHAWl9ctS+TmD8WlTTpob?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RHAe5JaV3URBIL9Xe6IvuOvfN5TrHXYVKMYpHn9EewcRNtYauOEd7mUBaI5eDE+nmyLtVlnywpx5yj8W0wy+Ipk0S2NPmLjKpaR1C56lqkSBzbDJMw6R/mj5EpsJgcH3UeT0OTt4eTrmasv1z8+FjPRXkeOH8IWA5Wqwd5R28C0+l95Nz47XYqSwKqDxSuDPpQhvfCisWGVgcQKYtoatpNmFMuyO8DDGN+1WsQ7dYQSX/44OIpkJ+0YlPNxJUuto3TV2RXS0+wBEZgYukJtS8CUuqQvSxGKo6vpGzxycVmHm+pD2WCpCWyBQDRzJNiGvJ+8QiAUkXHt1KG/IIG8AM05PJLDLKLMKgepWQYcuu3sIoEVHqshyY3iHIxHtr7lnkmPI2MNu0cL6+3e5qKQdSKAMiRSM5DXLr9jnBi2ht4N02fn1nkSe7kEmOS9p30kS6dk6dyv+uNuoI+RK2pEyKZHsfNQOPKFfTzE5fjtXYxNr8V2vCFkB3XOebFaiG6D2/CiG2Jvr9KFmWHcpkLwwDiQHUdTbvrw/LHssB4ZjixcbuCjIjUWGLyIH9yyNaQGkfF1ABu7qz8AaCozH5v+rbt2mTJQ4No3LXoNLsOsrLgs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea4ad01-f248-4ddb-a8da-08dcf79ef595
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 22:22:07.8200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d25rup79holdA9h7gdQpRJD2lNqA2ERRYtllMwBXv+yZdwHFqZ/7OecNuzEY29ec6V4D9KZflnke3ylGl9/LyV13PBHUo2ra59Mpt7sakTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7270
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_10,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=610 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280174
X-Proofpoint-GUID: VJcjYJQQH_3H8YKHfhpGR1PfrdkQnIzf
X-Proofpoint-ORIG-GUID: VJcjYJQQH_3H8YKHfhpGR1PfrdkQnIzf

On Mon, Oct 28, 2024 at 11:24:13AM -0700, SeongJae Park wrote:
> On Mon, 28 Oct 2024 14:13:26 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > Userland library functions such as allocators and threading implementations
> > often require regions of memory to act as 'guard pages' - mappings which,
> > when accessed, result in a fatal signal being sent to the accessing
> > process.
> >
> > The current means by which these are implemented is via a PROT_NONE mmap()
> > mapping, which provides the required semantics however incur an overhead of
> > a VMA for each such region.
> >
> > With a great many processes and threads, this can rapidly add up and incur
> > a significant memory penalty. It also has the added problem of preventing
> > merges that might otherwise be permitted.
> >
> > This series takes a different approach - an idea suggested by Vlasimil
> > Babka (and before him David Hildenbrand and Jann Horn - perhaps more - the
>
> Nit.  s/Vlasimil/Vlastimil/ ;)

Ugh oops sorry Vlastimil! This was a silly typo... Andrew would you mind fixing
this up? I'll edit my local file for this so if I respin this will be corrected.

Thanks!

>
>
> Thanks,
> SJ
>
> [...]

