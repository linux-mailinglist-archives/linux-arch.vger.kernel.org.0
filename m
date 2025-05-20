Return-Path: <linux-arch+bounces-12029-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B9DABE223
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 19:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F1C1BA5DE6
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 17:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3470280018;
	Tue, 20 May 2025 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SKCbGaIn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0FvOHr0X"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21372594BD;
	Tue, 20 May 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763296; cv=fail; b=KZAmCMuF4PJl9YwZ2uMhZ1fqBY8cv0kBDw5XDGXo3ky0yrnCguv0M2pWgMOXPSQEDLRXmH/0yRCTyx01XDCfIqts/lnO+YppEMfIGMTJkDigMqceePL2rWt+DrKPblNpf7nzfyO1fV73hX1/gflkg4W+W8E0SpRuriSMyBsjC9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763296; c=relaxed/simple;
	bh=FM0+57RTjueRn6bASikc1wzOjU++Q/MDo2s4+QAuwZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JkEkcU482VehkfYgbj+m33Dz5GvPz0p9v7xn2Az0j2Q+Ti7TPpcsmuIxgefN5Lq5V9em9D+eUY8DcjpOiGEizYMfT3Ihoeri16qZTQXZTtAZDZdy0ftT5dV32c2BHFqlKrltpy4Cn2zngfwUniV0xKQH2Mm6wQmDKgfblkGMeKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SKCbGaIn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0FvOHr0X; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KHfnpZ008538;
	Tue, 20 May 2025 17:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=FM0+57RTjueRn6bASi
	kc1wzOjU++Q/MDo2s4+QAuwZk=; b=SKCbGaInsQEOck44T5TgCssjv+GjSx3q72
	98kmC9FKhXmudZczYzUypT11S8r/5nf1LnuCJMZ22K7V47ATWMdIKs5YAzMk3y+G
	sy4hReEvAKGDy0dnNfehYL1AuZu9rbS+vet/j+hHjdW8DAYuveIKgquSZ9+r7FiA
	BKGp/bQ7128i0orpBDThVZuQo8Ya7szxxuODxjlgsr6CWLJKsMQIRpRcpMvcx+Ka
	X4Lm/5xBcrMxOsnWWAPd542ZZr8vLln11p5uNhHekXwBxq3oUOxNoYV/hdjN09UI
	aXyBC2dC48C3CVNBbzO0wah2NcduCEhZ5UjTwq3zeNG0VczCjEjg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rwg5875k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 17:47:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KGcn1t015452;
	Tue, 20 May 2025 17:47:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rwenu404-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 17:47:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2Wp48SG8YhtJdpZEaheqEe7tx8XM2QNpiVXglWixEl35p4w6FiXAJGB/PTa5Y3Fhla1ytTklEPsRjBlFAXh0WfnzSvkSftbQVfeHXFpBIlOYm+HFwHYJ/RfI6PJjNSgEdC7GknSQKk3rP78oErrH5SbyLuZrVDFi3IbH9se2B441Qg88GV4XzDkb2UH115wNNMX2RchGC0XSQTOVAtVfGN+tmprcTZZGyzu3uztJWDChkrB1TVZ4Mz6scZKtvTur8dBNda5yu070qj4RYjKJPGwE18skf/DRt3FwQRo3JBCTvmD1nT6nYoLdlWUyMIE3U+7htz/UFOU+LQzf1n+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FM0+57RTjueRn6bASikc1wzOjU++Q/MDo2s4+QAuwZk=;
 b=Te8e/1EpwkRfL6BBSB68o9fSfXYpJkmiVskmlA1QqicxOBjqA6m3T9blmiTIgnBiU/4RPYYpzfsaixUHSblUPIKHnhQ3UEzHehU6473Cik+hsC/YXz9DwNThNZP1pQVbISIWTYg/MwGMQBZFgFpdZwh7lMxN4FcLQh9RRE4VYrMLtfoC2oRj3PE6fJTFISr/Z9NV0q0ucsz46eMLQf5xxNfbvrYaTgSJZl9NPHNTznNNsfH0t8c68aCxgB8qtk29A7NygeY+Uvb0I7LjggczXzm+xGbPhzDx1Nd+A6ySyuuJML/FV1oPtw3w7EsFZENXSJbLCKvHNkGaVkXlyH7u6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM0+57RTjueRn6bASikc1wzOjU++Q/MDo2s4+QAuwZk=;
 b=0FvOHr0XQ32q0T8WFqDlCdqplU0l4f9SB3tnLEig582e0KznRxJ7EfcYRVB0rde8i/JEIGAx5/yBtoiQNtRh4yq15TJjZlufYPOnqq0Fj3BP7+a5K/sMUrgABCNPPkYdUKr5Rfl3LjjPx8/qkX8YcitL8s5fyoqaInkeF7y0Pa4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6582.namprd10.prod.outlook.com (2603:10b6:303:229::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 20 May
 2025 17:47:51 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 17:47:50 +0000
Date: Tue, 20 May 2025 18:47:48 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>,
        Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <c54d2c5b-e061-4e77-ac10-3c29d5ccf419@lucifer.local>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <dd062c92-faa9-46a6-99a8-bcc46209e102@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd062c92-faa9-46a6-99a8-bcc46209e102@redhat.com>
X-ClientProxiedBy: LO4P123CA0366.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: b1942ee2-ea47-48bf-9a16-08dd97c670a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uftj544ga5HT/erSmtaT4OLycNc8CHs23d11Oi0Gmh5uo+DYa8OCfr6++Xg7?=
 =?us-ascii?Q?FhPdNNqgJYg55KU3YmP2tTh9KrsueyZ2SOETyd61HF36xUJObU/AOh+jdc2R?=
 =?us-ascii?Q?PE3Tv05vKsDonEclH3xP4OxHyLJWNYnvz5tsCWP0BS6+8jEbHZ4SJaXwQSYD?=
 =?us-ascii?Q?yM3SHA0kmIihmcsTIE5t1q+1wQR9WAG8/QMuyd38PKPWSEts1D0lPC5IYOfL?=
 =?us-ascii?Q?Bg68i95d37DS7F++A+SpxYtRh+V6+ksDS76RUWpso+I079PQ0MA0cwBg9xtS?=
 =?us-ascii?Q?Fpi6b/QvsH+qztp9bV7mFE4o8Y/fSnDy7j+JQX7zrpeLA6fKJHsq2GNvW6H7?=
 =?us-ascii?Q?cjdPW3S0QQ57bg1rsD+GaRwfI5nxCEfVfBBzSv6tGjGALE7F85vMYJY7Gnv6?=
 =?us-ascii?Q?CpGcLezIEcMOfFWLFgDgo59p+GWDhESWK2pq0rK3r+d7S6BThYM2yxF0p+Su?=
 =?us-ascii?Q?471izt6OlicKWAIum3c4SZLGC2ZedAUEGNyouMZXUIVJV22G7wF/mQP6IiQU?=
 =?us-ascii?Q?KlpRVAe1jiGoqrfOjXxMpg1VyPJNKNt2zOn8FsOPAGvPqfINDH5+UO4IVjxy?=
 =?us-ascii?Q?jN/PpoqpVPEif7EPJ0Wpyxil8kfcZ247eSwytZ7/DRPR2qXeWWTrukheXHar?=
 =?us-ascii?Q?B8sB7hJhJQudySoFbHx5xpVtBHwHTlIea+F1nKF5idn3I6eTZOLZJ3SV6iLO?=
 =?us-ascii?Q?tmYoHm3FTlovI8g/l84PsgQK+4+JRBJYPlbNpvFJT9qPwqPZooSWFh7Esk3x?=
 =?us-ascii?Q?ZY1vB+C+ddaINVDJZS+xi0hLDNz2USQjAKUXukOpWMMTfMjr1oQZj1zzOnQF?=
 =?us-ascii?Q?JWEnbTtBAR9LsrdKhl52j3GltxF2dmP7OUWeNKqRfdveDwIC9KwIn27JxJGe?=
 =?us-ascii?Q?WRP6MfWaNk+hY6qOJz27vpqenkRMVYXpD4XTfC1K+xeMhevBMDKHpsCDjVDx?=
 =?us-ascii?Q?JJ2pYKcvy1la8vKOtdUtBWn0nlT5h5OGFAHuRIbcKNbFHtpwFsGeZQr+Hw/N?=
 =?us-ascii?Q?nogAjrepA3bXnZMBiBMP+ugItSZkxwch1L4g2JUDKHge5GZ958MS3G/yGaX0?=
 =?us-ascii?Q?oNpeIUA/mkZ7OexXiK1D6meHk+u3yKo9oWFt3MO8xQ/kJ75jd8GAlT2zcRZX?=
 =?us-ascii?Q?e9LWRiEIxNKZDykWg4nRe9sFuADN9qzvFurjy05pH2Bkn2IYZhcq6eUSQqwM?=
 =?us-ascii?Q?1pKqfzND7ZAIkMygkOCInBXvsXIjlTGj4KXZ4wX5j+blg5YDQG0VTt+9AbeT?=
 =?us-ascii?Q?FuxF2D4DVlLwmD9+tyqspYNqU11tBcBgzmzH1qUb+Tnbo1K3mP2PxGVMKGDa?=
 =?us-ascii?Q?iA1mAz461m36w0yvXhm1jLfB/2qVavdfU8WUGGmCkC6pHu5wtqfwfk5Cr5BW?=
 =?us-ascii?Q?XUzPHVoEd2FyuIaHKLD3AVWkNwVl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?280ueh41t2O1JMHpHbuG0pgoAUDaucgm5IyUOgy91KQyCGTZbvN/pllUfY2G?=
 =?us-ascii?Q?C7uhOza123DW/W0BgHbxKkqldu3KKxb86siC7UOhi3qzQwfAgyomFIeXz6AX?=
 =?us-ascii?Q?TX0AvCAQdUF+CppBAJmJ1WLJdnZ/KXAhX5ULErrO+I5RafsS7XmybhsrMseI?=
 =?us-ascii?Q?Q7Fcs6cpvIPOm2IWgQUlphER19l8WddbtjwO6pmtY8EDNZA9SKqwfA0+JmAs?=
 =?us-ascii?Q?Z9B3qp10rI5ZFSNAxJwfdMYXr+bVWFPA1rslXBf+QGomqu6dcaMlfWns69vO?=
 =?us-ascii?Q?I5zq3ZKTuuJ3/2j+WtDyzgjMApfk5lZHfw1SiXFuuW5NT6rseGKci6Pm0CQh?=
 =?us-ascii?Q?AD0ApHfBD/6eqCL/V8WrivaTOdDs77wNy/D7RzRCyFV1+fueH2k/bvTdOt+W?=
 =?us-ascii?Q?BVvBrKme6/pf3cGY1JkteEGRzK1eS4PMiZiCSoQXuFGs/GmBC6u9RDlf5ub3?=
 =?us-ascii?Q?UVXxxpxnM5a7Y0gquBjanRT0Ppgsqtv6tBS/urnNUIkBaxFlEDA7ibi3XWDB?=
 =?us-ascii?Q?dQmMbV5GL9HgP2iRpPw2/5JV3wKk1GJogQmfu8HMZ2+gQtCp2F7j0K1cd+hL?=
 =?us-ascii?Q?8Tg0HmWIutpRHDIzQMP5hR80tN6REIiTVLPqd1OBcFcLW3u6v93GTCcfCs9m?=
 =?us-ascii?Q?FZLRY/FGCiwpTe1FifD/ieExXNfPnQ2Y7UVTyz+MsIZ20ryqvJZY2WIEuYC7?=
 =?us-ascii?Q?clkSsJC5hLCok7QeU0UKct7BomiIQDpPOl4vnSvnVM+w0x/Hkdk/zigHes7+?=
 =?us-ascii?Q?wg8biIG/+SlzENJK1wOfdnGlgPEVVy762D4LSg5ylp0XYiEfEfnEMiIrDGYc?=
 =?us-ascii?Q?/UOXjcE4zoaXfdXhEqq13q/Sa8WfU6DncjzKwcCToIy/OYU2+VWlhxaxnq0k?=
 =?us-ascii?Q?K9dCBTq2h+763mtSRLGej8zlYal2NyVPtpJYoqo2/tqdZqWUyDksoOmQIjZ0?=
 =?us-ascii?Q?J4z3MSH7tBiTr0YzJrfLPDaqFRdc30PZWNqOyXcmHFkPHr8hgnfg1JxrqnaG?=
 =?us-ascii?Q?6o8xtzVjDdFvKxfG/azEcW/Sa6kmhmgWxNBab6yVLiVyH8kD+1JJ9QP9Bsbh?=
 =?us-ascii?Q?ASXapNP0pw3q+syS1vAuVRNL2xvUQCVg3RGoiv4clRYy3Isp7xSFrNzD4i4Y?=
 =?us-ascii?Q?nuDpEMhzWp3CttkOUyYntPl6zfqfjGM9qQORgCpvGO7wgRSrLLzjiQ72EnXD?=
 =?us-ascii?Q?NPVAcnfdRBuwXNMDHYAWo9R+NgEEL32dH+vYvjqd0rmW+INCGPxojacfVyg/?=
 =?us-ascii?Q?tbDYZEQ0Iyiey1ruBI0Ng1ehUqkeif4NESz8CE90JNYHwHbDd46VUOS79CuW?=
 =?us-ascii?Q?B7TXTSWZdMV4rzS99Xqb8XeesmlFf4XK1/5yi0Yed7e3zFcsJ4zYOYyL9jZp?=
 =?us-ascii?Q?CT08ZKP281bxGkdR9H1S4PWW9pTzPjgqV2JhW19yl9fPpmUaZTVxSr4BER5P?=
 =?us-ascii?Q?MMAfllFPzlj9684F3jS9ZHOix0B894NHUtgJprOE1ERASU184qaavkniKwaH?=
 =?us-ascii?Q?uG6fQM3atrXFLm1Ccju9vYSZg7HM/MjVM74Lghf8NmvlwLHF3SZvOlRCh0Ym?=
 =?us-ascii?Q?+ZVNuPtHDb+eBGv7hsqIhd22Lom5bls30Wa51f25IenxIcMyMJ9Bz2FjvItY?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Edk0giMWakt7TGyDRmFb/08h8P6eZbMtFNIB5hhguDH2YqKx8KAydfW+1D9v0T7Wdo/E9ubTPVonOdgG6hkhCtHVXe+bkdsMq94VpKCENRM5wXuzvXcwjzFaz29k8ZyAMgEdiC++H5bXdsdu7p3tIR1zC7+Lz77pVu9ve8nvl5Ecq0m1uFdJgXv7k0Kta/oCtNAbNlHlpNqLZeQ9X5L30PvM0unHi4Vc8Iq3eLIs1ro/J11Hq/OB7W8qG1WhlRgmd6ev0WA1Zafi2u010No+WvlPFa+/w+Euzj0X6CnieZX+StKycLt1sEl9BBRa7e1Oydw/bddC6M/Fk1YF+Q+3KUkITOWIRn31VfLwhR9vjsDI7kTsNsdYU8EvMWKNCtH2ChI+5wdtqXu5jmLbsE3rqt7IWkq/Yr4ZKFOOQ73s1ye/WVgRD6JBr/tLntoY/ceiARtqT6HNb4L/cZKy0VYdjWuw8H01wv1c/ySq56NMm0bIJGBWZIFV4e8rQlbXwiH9fM+4Ni9ienf6ma6NlPJXX5uJBT74NGlnm4m4qHr2HXWdRhQ6Id8M4O4iMvs+p8lxYjl160dnkquECXpMCL9jsKXzFi6097B9By6d4Vn5vpw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1942ee2-ea47-48bf-9a16-08dd97c670a6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 17:47:50.6651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pt9jiSaWUGFTtM509ADZnRZplR1sXDeBAn+WuNKtmuag7UbGsy52R9Uhx7mVCGQvDTu7/k47iQlk2yOn+PlDkU4LdB9Sd/x1xsAl8NOJUDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_08,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=858
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505200148
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDE0OSBTYWx0ZWRfX1upM8fgWplqF AFh7zrJRDZ7+owWRT1+xtQZP1nIj3iawQ4SFArunVkLVTC4962YeBcNjyguNmtwjLWP7yYA750G 1YFv7/5BhONs9cQ9wOucs+YLZfbSjKvWr12q/HAnV76kzgrebi2Nf5mHw5sqF/uVKuTF6EhqVqU
 dsjL4zLZUssWUPej38ZGmEiQBv706cXduLirCr7Umpb0g9ksP3yBFjk4aiKsTIEAyFoU9a09lbw UXxP8L38GFyw+zIQYbD2znTc+b1wZzm+pUWug+g4LokZQF86+zK2P19vcbf/ZeGSwVsaMzDuhzx Qw1YCkTNgoIiUx4zAsyVXS1XHtx6XX0/vR3OUiFg2bzmInWWesQT0NP52RF8gTn95GuuW2/45Ll
 iIra07i/6v9FvTHoQ8kCq6mrWSsGh2wBXbMm4UhrUhDBDELdDVvtVz6HPn/aWVdMwzxY/0Qn
X-Proofpoint-ORIG-GUID: r4HgbkV8KR2j2o3yvQHxRxWGVjdN0ao-
X-Proofpoint-GUID: r4HgbkV8KR2j2o3yvQHxRxWGVjdN0ao-
X-Authority-Analysis: v=2.4 cv=Wd4Ma1hX c=1 sm=1 tr=0 ts=682cc04d b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=xAcSGHj9iH46hvZ-hMUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13188

On Tue, May 20, 2025 at 05:28:35PM +0200, David Hildenbrand wrote:
> On 19.05.25 22:52, Lorenzo Stoakes wrote:
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
>
> In general, sounds like an interesting approach.

Thanks!

If you agree this is workable, then I'll go ahead and put some more effort
into writing tests etc. on the next respin.

>
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
>
> I would focus only on adding flags that we absolutely need to make the use
> case we have in mind work. We can always add other flags as we see fit for
> them (IOW, when really required ;) ).
>
> Regarding MADV_HUGEPAGE / MADV_NOHUGEPAGE, this would not be required,
> right?

Sure, we can restrict this to only supported flags to be conservative.

The idea was though that somebody might want to simply do a 'best effort'
change.

However at the same time it's possibly a wee bit dangerous...

>
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
> Again, is this really required? Couldn't we glue that to
> PMADV_ENTIRE_ADDRESS_SPACE for our use case? After all, I don't expect
> anybody to have something mapped into *the entire address space*.

Well, I think it's an ongoing issue that unmapped entries cause the whole thing
to break, I do think it makes sense to make this _generally_ available, actually.

Obviously we should probably make PMADV_ENTIRE_MAPPING imply
PMADV_NO_ERROR_ON_UNMAPPED in the same way that PMADV_SKIP_ERRORS implies
PMADV_NO_ERROR_ON_UNMAPPED.

And yes I don't think any sane person would map the entirety of the 64-bit
address space :P

>
> Well, okay, maybe on 32bit, but still ... :)

32 what? :P I deny its existence... (ugh ok I guess I have to ack it, but
even in that case it's not very likely either :)

>
> >
> > 3. PMADV_SET_FORK_EXEC_DEFAULT
> >
> > It may be desirable for a user to specify that all VMAs mapped in a process
> > address space default to having an madvise() behaviour established by
> > default, in such a fashion as that this persists across fork/exec.
>
> This is very specific for MADV_HUGEPAGE only, so I wonder how we could
> either avoid that flag or just make it clear that it shall stick around ...
>
> Having that sad, PMADV_SET_FORK_EXEC_DEFAULT is rather a suboptimal name :(

Yeah it's horrid, see Pedro's suggestions, e.g. PMADV_SET_DEFAULT |
PMADV_INHERIT_EXEC.

I even wonder about PMADV_, but that's probably fine. PRMADV sucks, PADV
sort of loses the mm bit, PMADV is probably best we can do!

>
> --
> Cheers,
>
> David / dhildenb
>

