Return-Path: <linux-arch+bounces-7910-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4032E996D78
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 16:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1496285AF7
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 14:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64CF198E96;
	Wed,  9 Oct 2024 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nzpqeRC9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d49mpuXt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA85224DC;
	Wed,  9 Oct 2024 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483513; cv=fail; b=m2geUN7/C3hyUmYF8Ws4DN26vYoL7I4ow+VkwlTlyNJ1bjS5YkRpjyLJcK4gTteGskZGxhZlSjtM+vcrS/vSLTozPxm2KKi4BFwdiK6Q1+JhXMO8m6kDUz2o7zUkWnghdvhfa7WzwvjhyMFdb1EV5FFlR1u023k2EOXAgyfLTjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483513; c=relaxed/simple;
	bh=LAb1sw6pEutunwmYOw3tFB2p+HFfGPKP6jtvltTIiCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m7h9FYBLYxlfuaxnqAos2ZeeXgpDJpmh0/pQldvJKaOvoZ3EoPvG9L5z/Q0B3xQtWDGqmHjuB9aOwikUfUqzio+1xLn2CdQKaiWkjgplcQ9N6Zdmp11BFMhTat8Tf43LGvnleXCDnSr1cQA2sIil7VMelIm42lnc64u5xbb71IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nzpqeRC9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d49mpuXt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499Dfd6A029985;
	Wed, 9 Oct 2024 14:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=KTmOUboFPTFO9lERt5
	nsEuRXwwX3Yzdtzq9Ij64Xk30=; b=nzpqeRC9hGiJJrHeNT9QIrECc8K0PuHtXL
	fzu0iAfwA76Egum34Kz8xW7j/7322+aHWbcZbWxscmmKCVBBAu6RECIWCGFP4r+d
	3RV0EGkjmP4CpWG3p8JoS1epLJKZPiEcZP4jDjfXfZ7JUKJOSr8ywo/gye9/lU7F
	m9qAjU4rDO9JRWVvLFfdBkwcfsTBOIIoX2vn4k/eBQP8O99AQnDHcp5Dw7E40nLc
	zggkpP69tFRfyebJYVo6HK4QFlxR+f1z8Vh+qzPb8P+TOBWGuHc6zMrzYoEHCRWG
	MH/58I75IMjgdT8/wMea9magll5YKUSKv3UpkjlZeruQ+0wSFKXw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063rc3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 14:16:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499E6sVB015343;
	Wed, 9 Oct 2024 14:16:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw8n2e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 14:16:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFlISMIYouRNcVeYXISFwryjdzaknShlk1l6zSVAFV4Jewt1qi6DMjbpL7GRbh3l9WSRfPgLZIRGBsxRomTb+7aibIXlSwqnm/zYSl/I2gstQrt95PtEHv17Gjy2j2c7OuYPSRIpp2yasp5iEWx16sVAoUavulJbGXDXN1kZyxy8AOiOpMZ7T6xodJ6BvGVXvJTNkAy3+jTXt4aP7N9zO/t8WcIJnXAX/G1Y4uDxCYSyo8QkzMLVu3p8bH/Iu/CA19HPWkAADr4Feazx3y/FU707hqGySGuJb+7pjkJ7mTcVaGLV4YhmujWgQ312nC7XY7u0kqCRrvaxxCFGFy+HbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTmOUboFPTFO9lERt5nsEuRXwwX3Yzdtzq9Ij64Xk30=;
 b=ysMpsd8DqeUFi7GtjaS4353RnJtGDFc9mDhOAhrWlDv7G83ggh2FRBjiFOxRBGcI1DK8rQu70EX8sPo8VdnG2+698v8P40D02woiExDhFSESE36TgS4LzgSvdlPSfAHjINWQaqNQjxYYb9xt/LtiUxkV633DUDpq23AHEO6tUdBB/9Y8hiVi0PGvnCwtaKeM4HUmCk42aVRb04rvDQ0qG8uzf4+l6hhRfp4AryBa/auQE0TkEOAYFEd4m5PQNS6iG6RXF3Divl/nfYUghKWnVThG/cQ4+wTSBGm85Tm1wQEPCvrH5iCyIdaa7RG1faxm4z2xsNsnO0exCCGbKBKduA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTmOUboFPTFO9lERt5nsEuRXwwX3Yzdtzq9Ij64Xk30=;
 b=d49mpuXtSBUmiyNwTX4KKuvjUUEXur/4PgtJKUTggoMA8KdkgGg8/KVXYzOCkEjHi2iEZLErbfkoYVf7H+SYVS4f0o2tqfdrtqf9K4lyDGggYVH5EQ4I9XVfmEfekciLwAkhj6lwXO9QI8FVZeruaGsDT5BjfhtL8ziiqjKkyZQ=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SN7PR10MB6569.namprd10.prod.outlook.com (2603:10b6:806:2a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 14:16:36 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 14:16:36 +0000
Date: Wed, 9 Oct 2024 15:16:32 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andreas Larsson <andreas@gaisler.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Damien Le Moal <dlemoal@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>,
        Kees Cook <kees@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/5] asm-generic: cosmetic updates to uapi/asm/mman.h
Message-ID: <71b8817f-c779-4612-be65-c665a42c44b1@lucifer.local>
References: <20240925210615.2572360-1-arnd@kernel.org>
 <20240925210615.2572360-2-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925210615.2572360-2-arnd@kernel.org>
X-ClientProxiedBy: LO4P123CA0381.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SN7PR10MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6d164a-173f-41fa-ea94-08dce86cfbb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4iQh+1Em4bUF4tmdg3epcPUs6a/C29GibIYRdQxx3s/KJ2eyNSocP6/QgBJx?=
 =?us-ascii?Q?9MOV+aQ1v+Dv5nFrc6W3i0MIJmk/TFAIagV+BkPFabVvWwIzDFXppNZDfpZ5?=
 =?us-ascii?Q?ZQcNNxB6gJi0In6tKSuttb5eS+mbAXUsmQyjnb9cPW+HwVsTNVFI/3Zjms8e?=
 =?us-ascii?Q?uJH8DXe1sLyJYjAWusVx2FLJ/MRC3YY30UWO4nJrLx8A/bQ47ImXQ0/GkRHQ?=
 =?us-ascii?Q?EGZPkNjqCk/Dc0yqml8rf9empp1DHBgbAL67iEdrHLhmESlUl1wE1VbXLwJD?=
 =?us-ascii?Q?nQARKSbcKeLWlPRiR3CJI5oE0fiIwDC/IXnRW1A5xkOZedwixE9NtSiA8YJM?=
 =?us-ascii?Q?d9pwvxoujBiy8zNR8Iv9gKrOi4PlwuuMAOpSVLpc/5xVb3GOBK785vlrxvcU?=
 =?us-ascii?Q?TfTUzpXqnT3Irw5qJKSD2eZdEKGWG23bU/o+N+JkB0jkLoftSfdVSVZZer8Q?=
 =?us-ascii?Q?5ccfw0wpYZ7bccZsI0Ye8ppDJm5FWg7pKKjPJAugXxFNSIndYriu6YvzUiBv?=
 =?us-ascii?Q?v/Tv9Olo2E5d+wP7NNhXwblM4p6VTI35iITVqeF4S1EgzhHrCR66QgWUvVjy?=
 =?us-ascii?Q?vLCAY3Cp8iQtpWQGkNeyVGEMKiklMuonZ8hkbIrBVsoafBBVuGJl+r8pRDCN?=
 =?us-ascii?Q?6MIy6tmQbkoZb7jWclwnOzmlU+7S6kNN8j2Thko4Nzd0s7C8P2kQ0sGlW8Rv?=
 =?us-ascii?Q?wdeoxlpkn8ocTnfjMw8Uft4HnVdF3Ji/OFSBCKJ/fxH+6ogOYLEjg3v9lay3?=
 =?us-ascii?Q?j/CvPDVO9PLKl25pTP/7m5wmYnunB1iSnU3Rihwh4jloC620caCTROPWEJiF?=
 =?us-ascii?Q?ekeJISaJn7ygn8HGBzKNKzA+Tnre2bl/5U1AM6i/VmN90EAJWfIA3JGMBZqm?=
 =?us-ascii?Q?GvB10FNgrh9zramLe3rhFo4vgA0BNRABMWj5jZ7pzMSFENRHaR5HWEYUJ/J6?=
 =?us-ascii?Q?wNbPS5fgX6o62sb5ebCmtw6ycfQlmXzEtEGSEkkLPLVIOuzOLwKwsK72eyhB?=
 =?us-ascii?Q?k+fl5kOY3XTKO0PbVUvZZfK1jtJzZgH+vlYLa3fC6p43dRiRA5UoPyju0mE/?=
 =?us-ascii?Q?rwFptrM6EeglJCWwVEPHZomSFx6lh5ByZYNN7sjthK69zf3fhq1vavBRr+w4?=
 =?us-ascii?Q?/pAEBMV/GnGVhVPqghaRoErct/ezDALvN1jOu1H2XbqsMQ7Oy4ZvcOFtghtk?=
 =?us-ascii?Q?jCoIGIQlbTKNGYG4rija8OPsOF1HjYWnL9BkOrY9gyj4juUko45gQVeIalQK?=
 =?us-ascii?Q?Q3L2HdQ9qbSSfTVQl/OqC+4uClUeB7dKZhvqxPlyKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gy0V71JScLxcSwwiUZJbf/vZ/OmR5XXFNrI+rr6OkAUjdgTktIOwEXBFC/ce?=
 =?us-ascii?Q?FY7LFPY72U42CZ4xD/DYiT2H0SDptfCrpxa4IhVAHu3y6y3OuWAWutPqkEkp?=
 =?us-ascii?Q?abSAoev+wAhFSwyAygQZ62LWwFSePWsJc37nNug0yORcBFhO2RGXNc28jSjf?=
 =?us-ascii?Q?UsovEsM6z5w/GLv8Sv5KXHvazYjwK8oSKoMXeWj7FTEQEjBwjNJE4g3tkorS?=
 =?us-ascii?Q?1idBQhZ8hecLkQmB72yT1vP8EHbsSKZqyvAIeL1kwa3I7OzhuXIxJ+ChlifR?=
 =?us-ascii?Q?aJZX+K/wV+8opImbb2zPHJJLuYBF4it2G6GK5ViQuJMoAbCsjAopxZ+1A7Rs?=
 =?us-ascii?Q?YiaNS5NApTuzJklZ/nBDRBEU8EvHzc6MEYlP2rHRgF6LwnzSmJ0hL1hP84UG?=
 =?us-ascii?Q?hCTTeeFT+55MNqSYhM7Q2W5+7w+G+0JI10euDf1npODhurVLzPu4J3Be+6kf?=
 =?us-ascii?Q?fuXwVrrf5CH9jzL1Nb8Ebojteo8bNNd7LXRwYCCflYCOxXSnxMJBkYRsHHWC?=
 =?us-ascii?Q?Irt97sMAm2dsDAvFjDyvEjAztuMWfaQS9UAIKGBrRYnZmLLmr1BTsN/LihE3?=
 =?us-ascii?Q?OAYrdLmpttBU41ZC+1ytEDa0n39GTRx7UAA9uaemgPl57BVLVdUBpF45E4Lk?=
 =?us-ascii?Q?REk3cfhYwzz6JPmHojwA/24+9kcuJKLZPKC2wNSTV8R6eK9snbPyxkTj4HN2?=
 =?us-ascii?Q?4MySjpKI/hsVnHHinQHM/f+bfIv2CHEVm4Cvfe62I2mgXhMlntB7FNmcjwL7?=
 =?us-ascii?Q?78Hcl2rxy7BeqrTJ8PQ1hroTxCz4411qoEj7Am/TrFAiS/lHXVjnDR3YDlwB?=
 =?us-ascii?Q?+Mwf32ZO13U6DJEYppV0iQGd30j03lPDjy9J3GO8GckRFpfIETHfSvWeyIP9?=
 =?us-ascii?Q?/IJxxKB1d/HR2lZ6BlwCCZ17a8RE/A86DUF7jJ2xQmC+umbJZw+NVkxkOI38?=
 =?us-ascii?Q?0EsiV/46snn2lT7/OlJ3KFg4Xvv+ziuPUbGm1hW/WG5j0WMu1uSYfd6BZXfb?=
 =?us-ascii?Q?Dev5U5cOTxqb646Q35dSIFjK0WFz7LsOD9ElcgyHVkVRjraA1KME7XNrWpiq?=
 =?us-ascii?Q?r8LFLwLimTlPnORHrFHqd83zGlJyzLOwNrvoeknVh2xNp7vmDYVUtTvL3DJf?=
 =?us-ascii?Q?nxw7CVzEOYTQdQOhDez9UcHi/5REa4BnDhr2APEbC/Y+3a+HyNP5+cKvPPJA?=
 =?us-ascii?Q?/HXHfYmwjlmx9H1FL59rDMTSli/juujV+uNEve57qMHK3RgZnbEYljA3lOME?=
 =?us-ascii?Q?NltJUvUCnmiGqqt/7xKXZIxDiweg0IRuSmKwigXi8CbszelCy8TAWurGZktD?=
 =?us-ascii?Q?NY37jquiIqv9+3EvLf98d8KINHaGxoSVlQ3i4xPB2LyIqNwfqn3/3riDf1sv?=
 =?us-ascii?Q?vgYJHEBVCJ4Z3W1ZckSjAhNL3t6Js4Gh2ihggukH6Qr1KPyZyHhGyWzmSmtO?=
 =?us-ascii?Q?DPgOOxkIkNJmpoQZSnyDi7cg3Dhp2yOzg6AXdc9ROfg4x2Fd/g/4rhz7VJLz?=
 =?us-ascii?Q?Ey5t8851N9UpO6LbB0qSuFbTeFVTOkdUyNct25e8g6SL9+wLEi/Ciy9UQBxK?=
 =?us-ascii?Q?/P94SwrsfeEe1f6sN9pbdZS/ZgEAdhbMRl9IUm0B8Qm8DCcDK7WUoZbG65WU?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1Hfd+0yfgywExEjvjXP978LbXjNu7kkEI7zhkOzmChEff4rRrBawNhcEH69R1fRl3GIrXeq0mN1rEuTYVhkdPhLu67eO01gsFnEnR6YCf/Useu+ORCm8DxR2zzk4JTYKPGRCVtvIuvh1Sk9BYre+s4WmZW/zzqBdyezs3m3xZwFxNZlVpw3f26a2iII0c21GA4DLJISrAlwVBMYi79xRhvVqlsvg6VYxDq9y7AWMKET35b5JYwvjcwAq3LBKuiVZAvf/IwxZeKMlLcQhkSVg5VcGgSmSPUaHn4ebFitJm7x5jeLNF5dCzbrMQIVF8rwpQy8smKlf9Rz6ADF6LDltF6GVzELcbsdpOePm8wTejEILyo7EFZ2H6rRJiUe8nGqgzKLkeWei9p3aLR0BLfNpPF8uGbGOoX5dyx1D6EZcmhR4vXSyAfMAiGMG2Bl1+rF3VooKAMYkfdMKmDfm3eUZqSq4NFJEMKRZA/mHwmAAdF/iP7uvHfx8vkJkBzf/9fL4BYOw6t8kimsbt1CD04IRtkPwRJoeIlHISDybaYQssdcXnWvmuD2SAJILr9/sI4z+QCa6itS5fLsN+ALdisA3wkQ85TXamT27T0qFELuxcY4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6d164a-173f-41fa-ea94-08dce86cfbb7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 14:16:36.0397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLj5dLruFWUJfhAVKzvWjeMEx4L2w07io3+LDs61C49F1qV1L3UrKD1G1qQNilbn3FmkW0fQljm/SH7PTxJaZIUjddR4mSx3TSU1Os+DoFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6569
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_12,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090088
X-Proofpoint-ORIG-GUID: sdo_sOfipP00xAQBtSu0xtYAjyl8PlMU
X-Proofpoint-GUID: sdo_sOfipP00xAQBtSu0xtYAjyl8PlMU

On Wed, Sep 25, 2024 at 09:06:11PM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> All but four architectures use asm-generic/mman-common.h, and the
> differences between these are mostly accidental. Rearrange them
> slightly to make it possible to 'vimdiff' them to see the actual
> relevant differences:
>
>  - Move MADV_HWPOISON/MADV_SOFT_OFFLINE to the end of the list
>    and ensure that all architectures include definitions
>
>  - Use the exact same amount of whitespace and leading digits
>    in each architecture
>
>  - Synchronize comments, replacing historic defines that were
>    never used with appropriate comments
>
>  - explicitly point out MAP_SYNC and MAP_UNINITIALIZED as
>    unsupported
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

(Apologies for delay in response!)

Notwithstanding Helge's comments, this looks good to me - thanks very much
for taking a look at this!)

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  arch/alpha/include/uapi/asm/mman.h     | 53 ++++++++++++-------
>  arch/mips/include/uapi/asm/mman.h      | 72 ++++++++++++--------------
>  arch/parisc/include/uapi/asm/mman.h    | 50 +++++++++++-------
>  arch/xtensa/include/uapi/asm/mman.h    | 61 ++++++++++------------
>  include/uapi/asm-generic/mman-common.h |  8 ++-
>  5 files changed, 129 insertions(+), 115 deletions(-)
>
> diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
> index 763929e814e9..8946a13ce858 100644
> --- a/arch/alpha/include/uapi/asm/mman.h
> +++ b/arch/alpha/include/uapi/asm/mman.h
> @@ -6,6 +6,8 @@
>  #define PROT_WRITE	0x2		/* page can be written */
>  #define PROT_EXEC	0x4		/* page can be executed */
>  #define PROT_SEM	0x8		/* page may be used for atomic ops */
> +/*			0x10		   reserved for arch-specific use */
> +/*			0x20		   reserved for arch-specific use */
>  #define PROT_NONE	0x0		/* page can not be accessed */
>  #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
>  #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
> @@ -15,41 +17,49 @@
>  #define MAP_FIXED	0x100		/* Interpret addr exactly */
>  #define MAP_ANONYMOUS	0x10		/* don't use a file */
>
> -/* not used by linux, but here to make sure we don't clash with OSF/1 defines */
> -#define _MAP_HASSEMAPHORE 0x0200
> -#define _MAP_INHERIT	0x0400
> -#define _MAP_UNALIGNED	0x0800
> -
> -/* These are linux-specific */
> -#define MAP_GROWSDOWN	0x01000		/* stack-like segment */
> -#define MAP_DENYWRITE	0x02000		/* ETXTBSY */
> -#define MAP_EXECUTABLE	0x04000		/* mark it as an executable */
> -#define MAP_LOCKED	0x08000		/* lock the mapping */
> +/* 0x200 through 0x800 originally for OSF-1 compat */
> +#define MAP_GROWSDOWN	0x1000		/* stack-like segment */
> +#define MAP_DENYWRITE	0x2000		/* ETXTBSY */
> +#define MAP_EXECUTABLE	0x4000		/* mark it as an executable */
> +#define MAP_LOCKED	0x8000		/* pages are locked */
>  #define MAP_NORESERVE	0x10000		/* don't check for reservations */
> -#define MAP_POPULATE	0x20000		/* populate (prefault) pagetables */
> -#define MAP_NONBLOCK	0x40000		/* do not block on IO */
> -#define MAP_STACK	0x80000		/* give out an address that is best suited for process/thread stacks */
> -#define MAP_HUGETLB	0x100000	/* create a huge page mapping */
> +
> +#define MAP_POPULATE		0x020000	/* populate (prefault) pagetables */
> +#define MAP_NONBLOCK		0x040000	/* do not block on IO */
> +#define MAP_STACK		0x080000	/* give out an address that is best suited for process/thread stacks */
> +#define MAP_HUGETLB		0x100000	/* create a huge page mapping */
> +/* MAP_SYNC not supported */
>  #define MAP_FIXED_NOREPLACE	0x200000/* MAP_FIXED which doesn't unmap underlying mapping */
>
> -#define MS_ASYNC	1		/* sync memory asynchronously */
> -#define MS_SYNC		2		/* synchronous memory sync */
> -#define MS_INVALIDATE	4		/* invalidate the caches */
> +/* MAP_UNINITIALIZED not supported */
>
> +/*
> + * Flags for mlockall
> + */
>  #define MCL_CURRENT	 8192		/* lock all currently mapped pages */
>  #define MCL_FUTURE	16384		/* lock all additions to address space */
>  #define MCL_ONFAULT	32768		/* lock all pages that are faulted in */
>
> +/*
> + * Flags for mlock
> + */
>  #define MLOCK_ONFAULT	0x01		/* Lock pages in range after they are faulted in, do not prefault */
>
> +/*
> + * Flags for msync
> + */
> +#define MS_ASYNC	1		/* sync memory asynchronously */
> +#define MS_SYNC		2		/* synchronous memory sync */
> +#define MS_INVALIDATE	4		/* invalidate the caches */
> +
>  #define MADV_NORMAL	0		/* no further special treatment */
>  #define MADV_RANDOM	1		/* expect random page references */
>  #define MADV_SEQUENTIAL	2		/* expect sequential page references */
>  #define MADV_WILLNEED	3		/* will need these pages */
> -#define	MADV_SPACEAVAIL	5		/* ensure resources are available */
>  #define MADV_DONTNEED	6		/* don't need these pages */
> +/* originally MADV_SPACEAVAIL 5 */
>
> -/* common/generic parameters */
> +/* common parameters: try to keep these consistent across architectures */
>  #define MADV_FREE	8		/* free pages only if memory pressure */
>  #define MADV_REMOVE	9		/* remove these pages & resources */
>  #define MADV_DONTFORK	10		/* don't inherit across fork */
> @@ -63,7 +73,7 @@
>
>  #define MADV_DONTDUMP   16		/* Explicity exclude from the core dump,
>  					   overrides the coredump filter bits */
> -#define MADV_DODUMP	17		/* Clear the MADV_NODUMP flag */
> +#define MADV_DODUMP	17		/* Clear the MADV_DONTDUMP flag */
>
>  #define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
>  #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
> @@ -78,6 +88,9 @@
>
>  #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
>
> +#define MADV_HWPOISON	100		/* poison a page for testing */
> +#define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
> +
>  /* compatibility flags */
>  #define MAP_FILE	0
>
> diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
> index 9c48d9a21aa0..399937cefaa6 100644
> --- a/arch/mips/include/uapi/asm/mman.h
> +++ b/arch/mips/include/uapi/asm/mman.h
> @@ -9,53 +9,36 @@
>  #ifndef _ASM_MMAN_H
>  #define _ASM_MMAN_H
>
> -/*
> - * Protections are chosen from these bits, OR'd together.  The
> - * implementation does not necessarily support PROT_EXEC or PROT_WRITE
> - * without PROT_READ.  The only guarantees are that no writing will be
> - * allowed without PROT_WRITE and no access will be allowed for PROT_NONE.
> - */
> -#define PROT_NONE	0x00		/* page can not be accessed */
> -#define PROT_READ	0x01		/* page can be read */
> -#define PROT_WRITE	0x02		/* page can be written */
> -#define PROT_EXEC	0x04		/* page can be executed */
> -/*			0x08		   reserved for PROT_EXEC_NOFLUSH */
> +#define PROT_READ	0x1		/* page can be read */
> +#define PROT_WRITE	0x2		/* page can be written */
> +#define PROT_EXEC	0x4		/* page can be executed */
> +/*			0x8		   reserved for PROT_EXEC_NOFLUSH */
>  #define PROT_SEM	0x10		/* page may be used for atomic ops */
> +/*			0x20		   reserved for arch-specific use */
> +#define PROT_NONE	0x0		/* page can not be accessed */
>  #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
>  #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
>
> -/*
> - * Flags for mmap
> - */
>  /* 0x01 - 0x03 are defined in linux/mman.h */
> -#define MAP_TYPE	0x00f		/* Mask for type of mapping */
> -#define MAP_FIXED	0x010		/* Interpret addr exactly */
> +#define MAP_TYPE	0x0f		/* Mask for type of mapping */
> +#define MAP_FIXED	0x10		/* Interpret addr exactly */
>
> -/* not used by linux, but here to make sure we don't clash with ABI defines */
> -#define MAP_RENAME	0x020		/* Assign page to file */
> -#define MAP_AUTOGROW	0x040		/* File may grow by writing */
> -#define MAP_LOCAL	0x080		/* Copy on fork/sproc */
> -#define MAP_AUTORSRV	0x100		/* Logical swap reserved on demand */
> -
> -/* These are linux-specific */
> +/* 0x20 through 0x100 originally reserved for other unix compat */
>  #define MAP_NORESERVE	0x0400		/* don't check for reservations */
>  #define MAP_ANONYMOUS	0x0800		/* don't use a file */
>  #define MAP_GROWSDOWN	0x1000		/* stack-like segment */
>  #define MAP_DENYWRITE	0x2000		/* ETXTBSY */
>  #define MAP_EXECUTABLE	0x4000		/* mark it as an executable */
>  #define MAP_LOCKED	0x8000		/* pages are locked */
> -#define MAP_POPULATE	0x10000		/* populate (prefault) pagetables */
> -#define MAP_NONBLOCK	0x20000		/* do not block on IO */
> -#define MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
> -#define MAP_HUGETLB	0x80000		/* create a huge page mapping */
> -#define MAP_FIXED_NOREPLACE 0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
>
> -/*
> - * Flags for msync
> - */
> -#define MS_ASYNC	0x0001		/* sync memory asynchronously */
> -#define MS_INVALIDATE	0x0002		/* invalidate mappings & caches */
> -#define MS_SYNC		0x0004		/* synchronous memory sync */
> +#define MAP_POPULATE		0x010000	/* populate (prefault) pagetables */
> +#define MAP_NONBLOCK		0x020000	/* do not block on IO */
> +#define MAP_STACK		0x040000	/* give out an address that is best suited for process/thread stacks */
> +#define MAP_HUGETLB		0x080000	/* create a huge page mapping */
> +/* MAP_SYNC not supported */
> +#define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
> +
> +/* MAP_UNINITIALIZED not supported */
>
>  /*
>   * Flags for mlockall
> @@ -69,9 +52,16 @@
>   */
>  #define MLOCK_ONFAULT	0x01		/* Lock pages in range after they are faulted in, do not prefault */
>
> +/*
> + * Flags for msync
> + */
> +#define MS_ASYNC	1		/* sync memory asynchronously */
> +#define MS_INVALIDATE	2		/* invalidate the caches */
> +#define MS_SYNC		4		/* synchronous memory sync */
> +
>  #define MADV_NORMAL	0		/* no further special treatment */
>  #define MADV_RANDOM	1		/* expect random page references */
> -#define MADV_SEQUENTIAL 2		/* expect sequential page references */
> +#define MADV_SEQUENTIAL	2		/* expect sequential page references */
>  #define MADV_WILLNEED	3		/* will need these pages */
>  #define MADV_DONTNEED	4		/* don't need these pages */
>
> @@ -81,16 +71,15 @@
>  #define MADV_DONTFORK	10		/* don't inherit across fork */
>  #define MADV_DOFORK	11		/* do inherit across fork */
>
> -#define MADV_MERGEABLE	 12		/* KSM may merge identical pages */
> +#define MADV_MERGEABLE   12		/* KSM may merge identical pages */
>  #define MADV_UNMERGEABLE 13		/* KSM may not merge identical pages */
> -#define MADV_HWPOISON	 100		/* poison a page for testing */
>
>  #define MADV_HUGEPAGE	14		/* Worth backing with hugepages */
> -#define MADV_NOHUGEPAGE 15		/* Not worth backing with hugepages */
> +#define MADV_NOHUGEPAGE	15		/* Not worth backing with hugepages */
>
> -#define MADV_DONTDUMP	16		/* Explicitly exclude from core dump,
> +#define MADV_DONTDUMP   16		/* Explicity exclude from the core dump,
>  					   overrides the coredump filter bits */
> -#define MADV_DODUMP	17		/* Clear the MADV_NODUMP flag */
> +#define MADV_DODUMP	17		/* Clear the MADV_DONTDUMP flag */
>
>  #define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
>  #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
> @@ -105,6 +94,9 @@
>
>  #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
>
> +#define MADV_HWPOISON	100		/* poison a page for testing */
> +#define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
> +
>  /* compatibility flags */
>  #define MAP_FILE	0
>
> diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
> index 68c44f99bc93..80f4a55763a0 100644
> --- a/arch/parisc/include/uapi/asm/mman.h
> +++ b/arch/parisc/include/uapi/asm/mman.h
> @@ -6,6 +6,8 @@
>  #define PROT_WRITE	0x2		/* page can be written */
>  #define PROT_EXEC	0x4		/* page can be executed */
>  #define PROT_SEM	0x8		/* page may be used for atomic ops */
> +/*			0x10		   reserved for arch-specific use */
> +/*			0x20		   reserved for arch-specific use */
>  #define PROT_NONE	0x0		/* page can not be accessed */
>  #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
>  #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
> @@ -20,30 +22,42 @@
>  #define MAP_LOCKED	0x2000		/* pages are locked */
>  #define MAP_NORESERVE	0x4000		/* don't check for reservations */
>  #define MAP_GROWSDOWN	0x8000		/* stack-like segment */
> -#define MAP_POPULATE	0x10000		/* populate (prefault) pagetables */
> -#define MAP_NONBLOCK	0x20000		/* do not block on IO */
> -#define MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
> -#define MAP_HUGETLB	0x80000		/* create a huge page mapping */
> -#define MAP_FIXED_NOREPLACE 0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
> -#define MAP_UNINITIALIZED 0		/* uninitialized anonymous mmap */
>
> -#define MS_SYNC		1		/* synchronous memory sync */
> -#define MS_ASYNC	2		/* sync memory asynchronously */
> -#define MS_INVALIDATE	4		/* invalidate the caches */
> +#define MAP_POPULATE		0x010000	/* populate (prefault) pagetables */
> +#define MAP_NONBLOCK		0x020000	/* do not block on IO */
> +#define MAP_STACK		0x040000	/* give out an address that is best suited for process/thread stacks */
> +#define MAP_HUGETLB		0x080000	/* create a huge page mapping */
> +/* MAP_SYNC not supported */
> +#define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
> +
> +/* MAP_UNINITIALIZED not supported */
>
> +/*
> + * Flags for mlockall
> + */
>  #define MCL_CURRENT	1		/* lock all current mappings */
>  #define MCL_FUTURE	2		/* lock all future mappings */
>  #define MCL_ONFAULT	4		/* lock all pages that are faulted in */
>
> +/*
> + * Flags for mlock
> + */
>  #define MLOCK_ONFAULT	0x01		/* Lock pages in range after they are faulted in, do not prefault */
>
> -#define MADV_NORMAL     0               /* no further special treatment */
> -#define MADV_RANDOM     1               /* expect random page references */
> -#define MADV_SEQUENTIAL 2               /* expect sequential page references */
> -#define MADV_WILLNEED   3               /* will need these pages */
> -#define MADV_DONTNEED   4               /* don't need these pages */
> +/*
> + * Flags for msync
> + */
> +#define MS_SYNC		1		/* synchronous memory sync */
> +#define MS_ASYNC	2		/* sync memory asynchronously */
> +#define MS_INVALIDATE	4		/* invalidate the caches */
> +
> +#define MADV_NORMAL	0		/* no further special treatment */
> +#define MADV_RANDOM	1		/* expect random page references */
> +#define MADV_SEQUENTIAL	2		/* expect sequential page references */
> +#define MADV_WILLNEED	3		/* will need these pages */
> +#define MADV_DONTNEED	4		/* don't need these pages */
>
> -/* common/generic parameters */
> +/* common parameters: try to keep these consistent across architectures */
>  #define MADV_FREE	8		/* free pages only if memory pressure */
>  #define MADV_REMOVE	9		/* remove these pages & resources */
>  #define MADV_DONTFORK	10		/* don't inherit across fork */
> @@ -53,11 +67,11 @@
>  #define MADV_UNMERGEABLE 13		/* KSM may not merge identical pages */
>
>  #define MADV_HUGEPAGE	14		/* Worth backing with hugepages */
> -#define MADV_NOHUGEPAGE 15		/* Not worth backing with hugepages */
> +#define MADV_NOHUGEPAGE	15		/* Not worth backing with hugepages */
>
>  #define MADV_DONTDUMP   16		/* Explicity exclude from the core dump,
>  					   overrides the coredump filter bits */
> -#define MADV_DODUMP	17		/* Clear the MADV_NODUMP flag */
> +#define MADV_DODUMP	17		/* Clear the MADV_DONTDUMP flag */
>
>  #define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
>  #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
> @@ -72,7 +86,7 @@
>
>  #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
>
> -#define MADV_HWPOISON     100		/* poison a page for testing */
> +#define MADV_HWPOISON	100		/* poison a page for testing */
>  #define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
>
>  /* compatibility flags */
> diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
> index 1ff0c858544f..ad6bc56a7aef 100644
> --- a/arch/xtensa/include/uapi/asm/mman.h
> +++ b/arch/xtensa/include/uapi/asm/mman.h
> @@ -15,57 +15,38 @@
>  #ifndef _XTENSA_MMAN_H
>  #define _XTENSA_MMAN_H
>
> -/*
> - * Protections are chosen from these bits, OR'd together.  The
> - * implementation does not necessarily support PROT_EXEC or PROT_WRITE
> - * without PROT_READ.  The only guarantees are that no writing will be
> - * allowed without PROT_WRITE and no access will be allowed for PROT_NONE.
> - */
> -
> -#define PROT_NONE	0x0		/* page can not be accessed */
>  #define PROT_READ	0x1		/* page can be read */
>  #define PROT_WRITE	0x2		/* page can be written */
>  #define PROT_EXEC	0x4		/* page can be executed */
> -
> +/*			0x8		   reserved for arch-specific use */
>  #define PROT_SEM	0x10		/* page may be used for atomic ops */
> +/*			0x20		   reserved for arch-specific use */
> +#define PROT_NONE	0x0		/* page can not be accessed */
>  #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
> -#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end fo growsup vma */
> +#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
>
> -/*
> - * Flags for mmap
> - */
>  /* 0x01 - 0x03 are defined in linux/mman.h */
> -#define MAP_TYPE	0x00f		/* Mask for type of mapping */
> -#define MAP_FIXED	0x010		/* Interpret addr exactly */
> +#define MAP_TYPE	0x0f		/* Mask for type of mapping */
> +#define MAP_FIXED	0x10		/* Interpret addr exactly */
>
> -/* not used by linux, but here to make sure we don't clash with ABI defines */
> -#define MAP_RENAME	0x020		/* Assign page to file */
> -#define MAP_AUTOGROW	0x040		/* File may grow by writing */
> -#define MAP_LOCAL	0x080		/* Copy on fork/sproc */
> -#define MAP_AUTORSRV	0x100		/* Logical swap reserved on demand */
> -
> -/* These are linux-specific */
> +/* 0x20 through 0x100 originally reserved for other unix compat */
>  #define MAP_NORESERVE	0x0400		/* don't check for reservations */
>  #define MAP_ANONYMOUS	0x0800		/* don't use a file */
>  #define MAP_GROWSDOWN	0x1000		/* stack-like segment */
>  #define MAP_DENYWRITE	0x2000		/* ETXTBSY */
>  #define MAP_EXECUTABLE	0x4000		/* mark it as an executable */
>  #define MAP_LOCKED	0x8000		/* pages are locked */
> -#define MAP_POPULATE	0x10000		/* populate (prefault) pagetables */
> -#define MAP_NONBLOCK	0x20000		/* do not block on IO */
> -#define MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
> -#define MAP_HUGETLB	0x80000		/* create a huge page mapping */
> -#define MAP_FIXED_NOREPLACE 0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
> +
> +#define MAP_POPULATE		0x010000	/* populate (prefault) pagetables */
> +#define MAP_NONBLOCK		0x020000	/* do not block on IO */
> +#define MAP_STACK		0x040000	/* give out an address that is best suited for process/thread stacks */
> +#define MAP_HUGETLB		0x080000	/* create a huge page mapping */
> +/* MAP_SYNC not supported */
> +#define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
> +
>  #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
>  					 * uninitialized */
>
> -/*
> - * Flags for msync
> - */
> -#define MS_ASYNC	0x0001		/* sync memory asynchronously */
> -#define MS_INVALIDATE	0x0002		/* invalidate mappings & caches */
> -#define MS_SYNC		0x0004		/* synchronous memory sync */
> -
>  /*
>   * Flags for mlockall
>   */
> @@ -78,6 +59,13 @@
>   */
>  #define MLOCK_ONFAULT	0x01		/* Lock pages in range after they are faulted in, do not prefault */
>
> +/*
> + * Flags for msync
> + */
> +#define MS_ASYNC	1		/* sync memory asynchronously */
> +#define MS_INVALIDATE	2		/* invalidate the caches */
> +#define MS_SYNC		4		/* synchronous memory sync */
> +
>  #define MADV_NORMAL	0		/* no further special treatment */
>  #define MADV_RANDOM	1		/* expect random page references */
>  #define MADV_SEQUENTIAL	2		/* expect sequential page references */
> @@ -98,7 +86,7 @@
>
>  #define MADV_DONTDUMP   16		/* Explicity exclude from the core dump,
>  					   overrides the coredump filter bits */
> -#define MADV_DODUMP	17		/* Clear the MADV_NODUMP flag */
> +#define MADV_DODUMP	17		/* Clear the MADV_DONTDUMP flag */
>
>  #define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
>  #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
> @@ -113,6 +101,9 @@
>
>  #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
>
> +#define MADV_HWPOISON	100		/* poison a page for testing */
> +#define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
> +
>  /* compatibility flags */
>  #define MAP_FILE	0
>
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index 6ce1f1ceb432..792ad5599d9c 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -38,6 +38,9 @@
>   */
>  #define MLOCK_ONFAULT	0x01		/* Lock pages in range after they are faulted in, do not prefault */
>
> +/*
> + * Flags for msync
> + */
>  #define MS_ASYNC	1		/* sync memory asynchronously */
>  #define MS_INVALIDATE	2		/* invalidate the caches */
>  #define MS_SYNC		4		/* synchronous memory sync */
> @@ -53,8 +56,6 @@
>  #define MADV_REMOVE	9		/* remove these pages & resources */
>  #define MADV_DONTFORK	10		/* don't inherit across fork */
>  #define MADV_DOFORK	11		/* do inherit across fork */
> -#define MADV_HWPOISON	100		/* poison a page for testing */
> -#define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
>
>  #define MADV_MERGEABLE   12		/* KSM may merge identical pages */
>  #define MADV_UNMERGEABLE 13		/* KSM may not merge identical pages */
> @@ -79,6 +80,9 @@
>
>  #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
>
> +#define MADV_HWPOISON	100		/* poison a page for testing */
> +#define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
> +
>  /* compatibility flags */
>  #define MAP_FILE	0
>
> --
> 2.39.2
>

