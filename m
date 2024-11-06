Return-Path: <linux-arch+bounces-8877-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6429BEF43
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 14:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66C5CB238CD
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 13:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE18F1F9EA7;
	Wed,  6 Nov 2024 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hKqznDMK"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F4138F82;
	Wed,  6 Nov 2024 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730900440; cv=fail; b=BeoqZaawn/ZeTSylF/8gTGBlKA842L9NW2vma+a78+zHyhetWqEgCXQuLnBHg6LpTP8Len5TDCEVaCWvUwqt71J/ugv9uIyO763DP7oLqBhQWNnxXpM0cd5MnS4nK+PRMsRDx7KkH5fVJ+o7mQO2nn+xaItdth0E66TlLDfGSnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730900440; c=relaxed/simple;
	bh=sGtqxflkmtAodDk+k/2a4ooOuLoA8CV74V0WIJPx+14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hfc3ulCUuTemGYK1+mKaEwv3CD1ZxnhoHW2iFETfsj7Hhu4iffEHfqrIwU7VzUQwxeCH88wmzFVrJT4O/Lu2bUi/3apA79LNyn1TRBkqzoJlm3U5f8ivv7Q3iv7ODuOxWUCK8dixLM9kg8hIS4dx7qSTUBa20xCPK3yOtc0lwOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hKqznDMK; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6TMTvZYY4pDfuTH6ktdfdoKlVBXs+J59AMdpI+lFvvOmPeUlChPM2bAO1cx2Ly+YY9p53HeMAdYtzGpg+g58o6mfyBoxuHRVVW7rcolrPLbBBrj/3+Y1uk0k0NKdstCrDxXU49fGeP9peLa9I4A/6zSN+VSsy7yDGfmIrdZthguU78mAVfXwalna1lHYYYj1c7yR5TF9BWM1jfe4phg9OQAw5NvvjM+oVAh9Cm9j0jdvcm3v6QZZJi544wN97o6/GhF4eQ81ug/shgnBb3Do07D+5dLDBBD7/GPyP3Gzel9yzCCyQJDUstGDPFnQCuX67rJ1ZByoI8idafUBWbX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/ecE0SC4iJj/H9jKRFF/DU2SwgiHBcMZC/pBHob6m8=;
 b=H0e4Elcnus4ostbc7PoHU+aKF7ETr+qt/109t3HWr0NwRhAGXzQcUa3fyasJToO4pKD7nUU79CVxDJGRxPHANEF1oWaPivMDySFdagXy3hY3leOTgzfMNJISIT3QCjmk8pmrxVzCdp4hbBzBXrxHkOal1kebmrqc2dhctq7k6YDKUQNPRzgcllsL5mDCinOEXzbcFl0p1AYn/IZls4JOj1a9+X+jvQrT+VYYrxoLpF1+u3vU1XTzqtWf/kGv9ozyxYnwp12VtVnEY7nJ4b/W2vV8zRSmmio1YEwIjgXfuqHO50d6TGqaG0oMF0ztvnCTmN/9g3ocAHLPF2dYNtOicQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/ecE0SC4iJj/H9jKRFF/DU2SwgiHBcMZC/pBHob6m8=;
 b=hKqznDMKlf2h1m1ia+3dRSF5Qif7v6vojqj6d6K1aebqWq9UNKSiulGPIpVigfYpYfNwW7W4Suk1j4tyEcaf+UfljeQIZtBhqUvIkB7PzpWtH6bOD1x1Xb4FlUAP2zYYe3Q3/NaHgWWB1UOHfZ67JKAyPd5apPjtaShqelR6UNwgZ+fl63NmbtgemaDa7/w4fPu4qG0YeufTVtY9fdVydNNwS0HULDZ+8wjMpqsThZAuztUdonqvtIgFcMFxxuoWtagQal2PuuVCy8klEiWJ3efJOcYtryzk4U6gJldOYiwAxAXcv9htyIOjbmn41+X06Wgbx5WN4VFViSHezTLFww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6645.namprd12.prod.outlook.com (2603:10b6:930:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 13:40:35 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 13:40:35 +0000
Date: Wed, 6 Nov 2024 09:40:34 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>, vasant.hegde@amd.com,
	Kevin Tian <kevin.tian@intel.com>, jon.grimm@amd.com,
	santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com,
	Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v9 03/10] asm/rwonce: Introduce [READ|WRITE]_ONCE()
 support for __int128
Message-ID: <20241106134034.GN458827@nvidia.com>
References: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
 <20241101162304.4688-4-suravee.suthikulpanit@amd.com>
 <ZyoP0IKVmxfesRU8@8bytes.org>
 <323dcff2-6135-4b8a-85db-bccc315ddfdf@app.fastmail.com>
 <CAFULd4Za4BQL+h9Xmra1TjB2oGGzPwru_y1xOrrAFSg==bfvgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4Za4BQL+h9Xmra1TjB2oGGzPwru_y1xOrrAFSg==bfvgg@mail.gmail.com>
X-ClientProxiedBy: BN9PR03CA0886.namprd03.prod.outlook.com
 (2603:10b6:408:13c::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: 6108b97f-c446-4141-09d7-08dcfe6897a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K01UMGtqdWJpZHpvTUJGZkRVbU1RTGNXd09ZMzN0alJHV1M3U1IydjNITkZz?=
 =?utf-8?B?RHRQcDJpeE5xV1Q2WTdWelYrNUxuV1pyeGxDYjJURE9zUUE1T0NQSnNVYlZj?=
 =?utf-8?B?OU12SzN6ZGtVYTRLVC8xRlI1RjJyWjdoL3VNOXY0d2pvVk8vNndKTU5Gb0RZ?=
 =?utf-8?B?VHU0K0NDYXRiYlpDU0ZvS1hkZ21GTTdEcGRIRmlUSXIwMVNia2ZGbWx0cGxj?=
 =?utf-8?B?cDRxc25wY1hOU3l5MWZNczQzS3Z5NTlDLzNQbFlMbFN4cUpsYThxL1BKdXVJ?=
 =?utf-8?B?ajczd25jOHc1a05HQkVMcTFabVVYd0VEMFpBeWVsSHRmYjdndkQ1S2JpeUVH?=
 =?utf-8?B?ZUxkakYzb0E4UDA1SVFUSGlOcEYyYWVTalZPTkErejREYzVROCtLeE1FTDEw?=
 =?utf-8?B?RjdrM1JKSGhWRWtmTm9qemlsSElVK0pva2V0dUZoUDY4bWFRNWdEMG9HT3h3?=
 =?utf-8?B?c1VOdWZFaVhjQ1RxQXluOXFIMEd6UnU1QlR2b2pNT0hGQ1kzbGdYNDFFL3ds?=
 =?utf-8?B?Vk5ONklZNC93bFl2WFAzSHExMldiM2xmdExKdDZWN2tNeHVYWXk0QlVqWUJV?=
 =?utf-8?B?QjhMR0tLeEliancxcGFnYUw2NVlsb2RHb2FodWpHZGdDTHFjcnJMQ0VtRHlM?=
 =?utf-8?B?dWNsdUhuNUFQQ2VXeUw5M3JZRE5XMU45c2VUVzBUZWdiNmMwbXJhd1d1ZEJy?=
 =?utf-8?B?QVUvKzZFSDFJcUFDY1RVUUU3N0tqNGtsM3VXZGZDeVVaejVRRDJJeHYxT1Zo?=
 =?utf-8?B?WkhkdHpEUmpQeG9hZ09MSTRFMnF2SGZod0pGR0dqeTVqOHBHdkFjVGtVV2d6?=
 =?utf-8?B?b3U1bVVPenJpcUVnR2JPZEFGQ2VaUzhkQjJXVmJwbUpmQVhrOGVWR0VtWVBr?=
 =?utf-8?B?NUhKWFhzTTQvWWRFVUpkclNmYk9aMzhtbWVWaElnT0s1UnlXMnRjOTk0SEZx?=
 =?utf-8?B?eWxkaFNPSUkwUUNQazk3RHVkbVBzbEREV1hPcGtSTThXMGM0cmt5ZEEzQ0lD?=
 =?utf-8?B?eTFoNUJ0K0RieSsxR25Wa25sMng2akdpZ0k3MXo0NGc5WGc5ZjZHL3lPZTZW?=
 =?utf-8?B?N0N2cUlsdFBaNEt1SndtL3RDWVY3UTV3OWZOMHkxT0hOSWs0VCsxV2xjU1NU?=
 =?utf-8?B?THVJRWNMdjJMcHd3TXEzVkJla2tvaTJhU2RYSjVsdS9IYzFtSS9DTXZVeEhH?=
 =?utf-8?B?VVhUNzYvcGRydmJNbmVjMjJCMHVaWmlJVUJFTTBtYURkQ1Z3L25paW0raXor?=
 =?utf-8?B?VUN4ZlEvYWI3WWw3VkFmVHNhT2NvVFlqb3hOaWt6SDRuYm4vSkljZTlhMzhT?=
 =?utf-8?B?dDNmZjhKVGlINlVOOU10T0hwSVNjTXpZaTZkKzVhV0x0MmxhRkRlTFVjR2Nj?=
 =?utf-8?B?SkFVaFpBN0xSL3pRUVpiai9BcFNRSzY2WUhsVWkyN2t2T08wZGMzeDdpTnJs?=
 =?utf-8?B?YWhkT0MvMG9XNHh0d3ZWdmN6dXk1NmxFWEYzQ3ptcWdJNDRwTzZUSkN2NkRQ?=
 =?utf-8?B?ckUwaXo0bkpFSE5rVkN3dXc5NU1MSU9kRHlzTTZ0djYyUlRkb2JTTVJFVHpx?=
 =?utf-8?B?a0txSjdjT240UUNkdmo1MmJiT0JxUXFHU2lRbE13N1BmVGZpbmtQQUFNaldi?=
 =?utf-8?B?S0RJTmNlNmtzYW9DQU13aGxndGVLWnlwOU4wMzlUQUc3Yjk4QmNEdXE2WlVU?=
 =?utf-8?B?L2RlWmhlNG9nOENuTEFxRUE1bWx4VEZ1OW9YMUI3VC9KTjV0Z0RmK09naE5X?=
 =?utf-8?Q?38iJAZNSeJxzk6HLcb4QUAQf+4PfvmZIKsUj4t4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekZxWnNLM04waTJpYTB0clBYNnNoMnkxZ2lyTTZEVnhDOUc1WjU0N0szMHNs?=
 =?utf-8?B?bis5OEtKMldlRmVUR2Mzd2U3MGpmZ2xucFZUdEhMVWp5YmI0SUtJWVhLU2xK?=
 =?utf-8?B?QVNaeit3TkJhVTFwMGtCYVd4VHhia2lsV0FEYmpwVjVNWkVDRWh4Y01TbUk3?=
 =?utf-8?B?V0RBN3VyL0E0UERWZEpXL3djV2RXWVpuQ2lmam9jNEpTcldETDlMYVNkN2tn?=
 =?utf-8?B?WWxocklSRzRNVjNWUEdQdC9scEYwQTNoQ1lhakpNbktPZFZGS0U2d1hnalhH?=
 =?utf-8?B?cGNheGhnUkhjOHZWTGNHUG9nR0d6SjZXZGszeXYvMnI0b1VZQjdaNkkwd3Bi?=
 =?utf-8?B?Z0FUU3VJenFsME1Dak5tUXVRUUN6eE9zdWgzSUx1TG40Y0xhWHFPTjgrcXpa?=
 =?utf-8?B?ZjFZSWZZMkhvTnRlT1pUbDBYRXNaS1FqaHMyVGtMSVdvLzlMQUc2ZlRzNVV6?=
 =?utf-8?B?bVdtUHdMVnZoYk9IODUvdmwzdm9rZlRqTStPQ3BiZm9JcHZWOXo4SStEOGY4?=
 =?utf-8?B?UTViOVZjdVUzWVVNQnVJb2swRFR6MlJpUk1rbHh2b0l6ay9GN1VVNlc0cnBL?=
 =?utf-8?B?a1dKZEZBbUdtVHY0YVZEdjYvb09NNEFuVk94eEVJTVdRYzJUOEYwdStmVzJm?=
 =?utf-8?B?WnRUWmNhd1ZkamQwK1A2elVtSXp4N2ZqbkE1cUNZcXdmVHJjcGpHQmpVUWE5?=
 =?utf-8?B?Q2YxOVZRN2RqRlB3ZHZvaDYvd0Q0cnVDQldjRjhoV3p1YldxclluK0ZoOFF2?=
 =?utf-8?B?U0NkaXZzTnpUY2NobHNSam92dHZEczlBaGF2N29ldUIwZWo5dFYyaFY3eE1D?=
 =?utf-8?B?elE5d2ZPaE1GcTQ2eDZFbWJndVBUbndtK1drUDJPQ0FvWjRQUG9JUXppT0J2?=
 =?utf-8?B?TlZ3UWdWQkpXWDMxd0dYRjFHYzd0M1ozNFVRRlRvU1R0ZDdFRWVBSlVsKzZm?=
 =?utf-8?B?SFRvUlhNbDJLNmthd0hsS3VFeVIxTWNkWkxmS1dRRHFEQ1dHbjY4QVdISFRW?=
 =?utf-8?B?NkZqajYyaEtyNnNmK1pDQllaNER1S1VjVTg2VjhwdFVXdm5WM2tPT2ZPN0xq?=
 =?utf-8?B?TC91Q0JjWHhMUXpMaDdSYnpOMTlLQzM4RlpNRElLQmt4N2M3M2xWTWw4bldZ?=
 =?utf-8?B?QmVud1lZNldSZUpMRCsrWnAvV3dhTWxSLzdTWXg4VDRUWk1kN0pxNE5yTjYv?=
 =?utf-8?B?NGZWUGp5bzR4K0xZWitMTFFjVHpyZlpESDB4RkhIemhDRnA5cGQvU0FqWjRz?=
 =?utf-8?B?ZzMwaGxPZTBmdmJiM1RjMVlQU2VQZElUUHRCSmpIVytjOEZkS0NDR216L2dF?=
 =?utf-8?B?eWFraEVLdFZ3aVNvOHV0VEhxWlVYWFNQUS9uY3pNWkw3UXJ6QzRqZnQyOWRr?=
 =?utf-8?B?K3A5QzB1ekE1LytWWjkrZ0JZN2Z5NUlGUFN2dEZOaUxQazU1bmdQSkltcXpF?=
 =?utf-8?B?VHNMQTJNNlovWHVlVStBb3lTVHEwdGFPL1NUSEFZZ3B2KytkcG5ENHU2cVk5?=
 =?utf-8?B?dVZaUnFLWWpndHBzVVVWVUJaVDBVaEFvckFrcDN6RVlKeGNJK3VhanZMQmFl?=
 =?utf-8?B?QXpCUlRMTHZUZmtoSW5VazZxckxDcm1KdlQxemlGTUhIT01lTEZZdkNuVVQz?=
 =?utf-8?B?TFlCVXZ2NkFRcVRlWStyZFpUY0Y0Z3FtTEpJSy9uZ1RIeXdEeWJGMTAyWmRU?=
 =?utf-8?B?WjNXdEFZaFNCSGxjbGV2Qjh4SFV4dEpuK1VIYWFTYmdBQTE3Z0ZTaVJ2UUpn?=
 =?utf-8?B?WTJaa0FrVVB3eVlWZUJvY0pkeWhSOU9kZnlqRm9YeCtXMlFPbTQ0enlMSll4?=
 =?utf-8?B?NURYSDBOYlFxQ1VFbkYra0JodmRiTEZoZVRxajlwZTRJaUQ5Z3FXTmJEd3VU?=
 =?utf-8?B?djI4T3ZpNHV6ZkhYb054NlBrZWdON0FhUmFrR0xXOERhZ3ozbDVTUjkxVnRC?=
 =?utf-8?B?S2RIVnZtRWgxU2lBMnhVN2Y5Si9WOXkraUdTNnBWUGkzTGVDaGhYdjRPQzF6?=
 =?utf-8?B?dGp0YzIzZ0YrVFJwYnRYVnNkUFY2R2s0dmdjM1Zlb2FGSUZFR25HQkdYNm55?=
 =?utf-8?B?dFBtMkhhSXVXcEFLUXdER3VTbEdCY0lERSs0eVFBMFhNV1ZrRURhZVZwaXZW?=
 =?utf-8?Q?k0tPyNy450KnAYHzJQznbtSKm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6108b97f-c446-4141-09d7-08dcfe6897a8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 13:40:35.5561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUT90im2PDt9nHoxvgMCCzxLTG9/Oc01Iu70Y9mQZb5v/S10uWhdHG287+OJRZ8l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645

On Wed, Nov 06, 2024 at 11:01:20AM +0100, Uros Bizjak wrote:
> On Wed, Nov 6, 2024 at 9:55 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Nov 5, 2024, at 13:30, Joerg Roedel wrote:
> > > On Fri, Nov 01, 2024 at 04:22:57PM +0000, Suravee Suthikulpanit wrote:
> > >>  include/asm-generic/rwonce.h   | 2 +-
> > >>  include/linux/compiler_types.h | 8 +++++++-
> > >>  2 files changed, 8 insertions(+), 2 deletions(-)
> > >
> > > This patch needs Cc:
> > >
> > >       Arnd Bergmann <arnd@arndb.de>
> > >       linux-arch@vger.kernel.org
> > >
> >
> > It also needs an update to the comment about why this is safe:
> >
> > >> +++ b/include/asm-generic/rwonce.h
> > >> @@ -33,7 +33,7 @@
> > >>   * (e.g. a virtual address) and a strong prevailing wind.
> > >>   */
> > >>  #define compiletime_assert_rwonce_type(t)                                   \
> > >> -    compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
> > >> +    compiletime_assert(__native_word(t) || sizeof(t) == sizeof(__dword_type), \
> > >>              "Unsupported access size for {READ,WRITE}_ONCE().")
> >
> > As far as I can tell, 128-but words don't get stored atomically on
> > any architecture, so this seems wrong, because it would remove
> > the assertion on someone incorrectly using WRITE_ONCE() on a
> > 128-bit variable.
> 
> READ_ONCE() and WRITE_ONCE() do not guarantee atomicity for double
> word types. They only guarantee (c.f. include/asm/generic/rwonce.h):
> 
>  * Prevent the compiler from merging or refetching reads or writes. The
>  * compiler is also forbidden from reordering successive instances of
>  * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of some
>  * particular ordering. ...
> 
> and later:
> 
>  * Yes, this permits 64-bit accesses on 32-bit architectures. These will
>  * actually be atomic in some cases (namely Armv7 + LPAE), but for others we
>  * rely on the access being split into 2x32-bit accesses for a 32-bit quantity
>  * (e.g. a virtual address) and a strong prevailing wind.
> 
> This is the "strong prevailing wind", mentioned in the patch review at [1].
> 
> [1] https://lore.kernel.org/lkml/20241016130819.GJ3559746@nvidia.com/

Yes, there are two common uses for READ_ONCE, actually "read once" and
prevent compiler double read "optimizations". It doesn't matter if
things tear in this case because it would be used with cmpxchg or
something like that.

The other is an atomic relaxed memory order read, which would
have to guarentee non-tearing.

It is unfortunate the kernel has combined these two things, and we
probably have exciting bugs on 32 bit from places using the atomic
read variation on a u64..

Jason

