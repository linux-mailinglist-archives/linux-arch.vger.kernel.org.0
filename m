Return-Path: <linux-arch+bounces-7703-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F17A4990DC6
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 21:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D733B27701
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 19:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA5520CCF0;
	Fri,  4 Oct 2024 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ROgLKSYA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n8QhaFeT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7EC20CCEB;
	Fri,  4 Oct 2024 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066440; cv=fail; b=H1JzT5lj9CWC8w2vZjqlVuFgcOAp6wTJllcilkKvYvNFfUvHllC/fFCB4mhqcPGKP00ZBlY6S5iF0nOwsE2R1w7Ot4q+NTSYWN8NXvHTzm0ESyCNyvT4nfIEyRBD9va0DZZM8I+3eUEr4VAcQVvPJKJGHFT8ZRyRXP9QR/KodB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066440; c=relaxed/simple;
	bh=4kqJGOjLdEVmAMY21KSVxMyGmy1ddDDomOda2GyIS00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lq3XM4l6vcpdxVOm6DvJtDyLmOPwOIo0j7AKlBzitc5dE4KfxYNL/kp9RCJtyG7TzITRNA3kRJI8uBYXz32jgfDi8Xew+bQ1fseOOL+Cap9+a6vIi5BgHcjTOiCgKUT/v/Z5DZc83pGdZdJHhE+jlJKjtx2mYZpWDtS8OG9H3O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ROgLKSYA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n8QhaFeT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494HfbdM030368;
	Fri, 4 Oct 2024 18:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=U9vmB37D9Hd/Lv+zC4/YN4nXoCA6AsI20AgPX5SJa10=; b=
	ROgLKSYANPX3Y9e7lfpiS15eSwhUtRDbXOQDjoMjTyOkEUrohkV0PthmVWc7BKWm
	WoG5UkwURz6vtdshBZ/7hDygoD7GnWu+DHcseQkkbXZ85EkfCsKb/F1YP9csAxlA
	0lQ+e0nyu3rBi60uUv3soTaJNhSzgfrkUMge6ywBe6CCap7wCnxfU49m7R7i4Thq
	eNEswZAgvEIP7lt852ScMJIrFqxpd110S0Y5bjmIjA29qfaRoo6wrF4lqyjnA0yg
	yFFhyrgZ3lerOEZaWJGLBZu8Ci2PWHYqxiGFjzLpXXfjAedLV6lXza9yz1LIRIKn
	Au1mE349YAR5r9R5ty26Fg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204b289q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 18:26:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494H5ePs038083;
	Fri, 4 Oct 2024 18:26:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422057negs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 18:26:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpoY4AdQws9KtPznZ0iIsDJAWJj111KuJ5feCu9qweEywIL0WDrLSmQl4yDKDmDu8CUehoDMLNtvYVgzsfPTRPGytQgGf9+4BpbQsbSiMYtC2j8P2Cfwz2+ce+aW2p9UIa6AoW8IjuqZuSU677BwgqajXmNoUJTO06tNvIo51JeUnD/V71Gpw5flkGHvkrNPsoGxw93UTcQ7wb82Dv4uNCY0I5mxoy0OFDBd+reuJqxvwcEun+c9A07ch7zC0N9GLq9QF5ebAdCEP/lyBZU52v3IAn2E/DbAiir5ZTKuoDg9ixd8mgjwdyTBS/Tv3ha54bvyDmwI/LYVzM5Ppttx1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9vmB37D9Hd/Lv+zC4/YN4nXoCA6AsI20AgPX5SJa10=;
 b=YzvXg5Rp+dxfEr8rJ+vWBT72QXxS+FBrLgY/VUOc1f3nlhE52DY7KksE981I4KaF8nSBJcrfl9L+i5lf3T/j304E//KZugOG5K14UmSmPCpCbn2bpD79JkQecb54m8Sb88/i4DcZoeP55Hvb/kcEMGy4ES+cdN5pvZrEqKJBfurBqnY49Ed4ZXIFE+KrEvi0fcGHm6bMYg1Zehi0FSzvKM3PjbTVOq2J9igczXx++3+fsyQyIdFKwv1Yfj8sNXjatV2NQz6pyBVjAUPl0UtgX6fgQhDF9PY8D4bEo3gn1v8JvzizZkxgwpPCqqwXczUgiq+vdXJA3t8OHAebogL5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9vmB37D9Hd/Lv+zC4/YN4nXoCA6AsI20AgPX5SJa10=;
 b=n8QhaFeTvs1ecFAG48KNfErHO3Bx9A9xr4ZjaEFveukUCS18P4vyghP3LF80Q+BYWJvxc89xTVk7tiC8QZ8g9uDDAUcia5eVSRaqan9jkxjPkXQrdKwQfDyt3XfNyIGCaf5lEiNPSdYessnM3JpInezWAGrvILrY8RFwxkXnLdI=
Received: from PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16)
 by IA1PR10MB6757.namprd10.prod.outlook.com (2603:10b6:208:42f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.12; Fri, 4 Oct
 2024 18:26:18 +0000
Received: from PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2]) by PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2%7]) with mapi id 15.20.8026.019; Fri, 4 Oct 2024
 18:26:18 +0000
Date: Fri, 4 Oct 2024 19:26:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
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
Message-ID: <dd62c167-f8d5-4c48-b92e-9efde6a61d7e@lucifer.local>
References: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
 <a578ee9bb656234d3a19bf9e97c3012378d31a19.1727440966.git.lorenzo.stoakes@oracle.com>
 <CABi2SkWzjTVjEwED_QjNz385m4aGo8OfAS2RkRjuZdpSviNkJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkWzjTVjEwED_QjNz385m4aGo8OfAS2RkRjuZdpSviNkJQ@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::18) To PH0PR10MB5611.namprd10.prod.outlook.com
 (2603:10b6:510:f9::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5611:EE_|IA1PR10MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fced220-bd68-4c91-a307-08dce4a209a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aE5UQ1BqWlhDZ1BZVmw2MytlRy9sSG55aWxYdHA3MDRJeS9BeUU3WXVnZWpW?=
 =?utf-8?B?M3pIbGJuRHNvTlFYNWtkaGI4MGFoUFZsZTBHY3BGZ1dzSldObllXcFNzeFhB?=
 =?utf-8?B?TU5wTEsxRTRoV1dkYmoySTI4VjJubW42R0dyZjZrMEJVZnRnU1BBMVdGdzhZ?=
 =?utf-8?B?eVI2OGdPeTZXM0tUM1V3U1ZmOVhQQmlHK1owT0VJSW5heVVwQmlSWHlwdlRa?=
 =?utf-8?B?V3RpSWt4QWplcUVDY0ZKbXg5SlNxeXA2NldXSnQ4cmVRT3hsYVowKzc1WmNJ?=
 =?utf-8?B?MVB1ZHY5RlJuUExia3MyS2dwc0t5MjVIS3pHRjN2U1dXYlhxTGQ5SStoYTVh?=
 =?utf-8?B?T05NMHIrNmZDNFZvT0Zvc2Fyc2xwby9pazIrMmlOMDBhZEViWFJiUkkvQjRD?=
 =?utf-8?B?WUNVR1dMWi81K3VxQlNDZ0xlTkpuRmFrc1BHQW54RDRuVXpDd09ObFEzZk9M?=
 =?utf-8?B?VXhTQjRIS1MvU2VmZXN6L2JOSnZET1JxZ0FZSWJCVVBJRmczckpOa3dzOVBr?=
 =?utf-8?B?SnZSdWVzQWpwbUd5eTZpQ2hGa0N5M0U5UFhNZkQyL01FVUY1OUhFVzJWUFEx?=
 =?utf-8?B?ZjVNeGc0TzdDKzVJNjNQb01MMkJhZTNFYXJDWktEK1JwVFM1d3VyUDNsTFZI?=
 =?utf-8?B?S2FtdE5GaXdJUnpQMDQ5QWR3dkhGUUlTQnVrMWRBYTRzSTY0MnVMWHJNT3Vj?=
 =?utf-8?B?ZUNkU2svNE5uQkthcklTOTJ0RjA4cGMvbmY1RVNjSFBMbktTTzd5elllVU80?=
 =?utf-8?B?RkJ4WktUREk2djBYbHJIZWE1OUY3dzZ6U3I2ZmplWFgrcXZSbEdWM0FwWW5I?=
 =?utf-8?B?amFSaE54LzJiMVgxdVkxYTV3cGl1ckhHd0dwZWdJZ1FiOTZSWElwbTRoV280?=
 =?utf-8?B?eXJkYW5JYkRCWDVQcWpZdjd2cC9RSVBvOUsyZHZvVVZ4RHBEYWJNWmhqU2Rm?=
 =?utf-8?B?Uy9vUkVLUXl0OWUvMUtmUWI1Y213VjQ1ZzVzV1JOWUZ4TjdWRkVMRC95Kzl0?=
 =?utf-8?B?TnhRWVRCNE12U0J3VmJIL3EyellxZlpJdEV1Q3V5MHUyZENwcjR3T2xjQ2JF?=
 =?utf-8?B?T3FGU2J1RmJQMEowRzVCelV6ajdUUk1pb0ZQV0hSUHBlekVibHhLd0hxa1R5?=
 =?utf-8?B?angyQzZaSEVVVG9mNXdRakdqUUM1K25KWjduWkJodDgrRGJSWVNsMWliYlA2?=
 =?utf-8?B?QUJ0N2I5UUdsMVlsb1djbWNNQXRMU1g0cHJmYXJEbnorNHc1YlAranFWNW9G?=
 =?utf-8?B?WjVRT1RVRFNSVGh0a1lXNUlPc3BRQ1JiVU5tQXM5bXU1aC9hUEp1cW92bC8v?=
 =?utf-8?B?WGcraUYyZk8vVTBVZ0FHZGZxd0R2YUJGYURGWGZJWEpPeE8wRE5lczU5NTA4?=
 =?utf-8?B?RGYrTDFYL3Q2WTgvckV5YzZYcmxmSmhyWWZDS3ZNUVpyN1hxSElscDArcFlN?=
 =?utf-8?B?Wm16ZFEvRmRJQ2E1OTNBQ1lYYzV2UWR1Y1crREFMK0ZKS1NpbGxRUENDSHAy?=
 =?utf-8?B?VzV0OTZTOTZtcWFlSXVNeEl0bUpFOVVKbXlEb290RWlTdjVkWGV4QkR2bXhm?=
 =?utf-8?B?K3FzMy9xZDZIUkRoMjZmTkxvZXdIbVc1eTJkMFZVRFpCRnZ3cll5bVNWb2Nv?=
 =?utf-8?B?NXhHbjNvbUU5SFRrZDZhSkdMdHREWU8rUUJ1RU9VWGJKOE1ITzdPM0xhV2V6?=
 =?utf-8?B?SE5yNmFzRldMSVlJZHJ4cWZieWFnSDVDeFVQdzAzc0xGVXNFNmI5U1dnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5611.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWpXK21mQ3F5T3phT250ZnlmVVhzL256djVBNFd2WDJGU2tvMWR4bnM1aTBV?=
 =?utf-8?B?WGYwNkwrQy8rV3RKS1prQjc2dWZUWDdxUnM3YUxhTmZQQVM1dWNjTEROdFIw?=
 =?utf-8?B?Nnl0dUR1dndNZ0RjMU9CdEVXL2NSelQwVjc4bVIyY2ZZZ01zcE9HVWEwKzZ1?=
 =?utf-8?B?V0pNTGViNEFKR044T25lVUR0QXlXTU1JZ0FzN2NkbWQvS2x4T2JleDBqUzdk?=
 =?utf-8?B?ME4vMWF3cE1qNHk1TTJranFIUUJOYVJ3Tm9yM1BRZXk4eldFcVBxUEhVZEFF?=
 =?utf-8?B?eVp5dkhlOEszaHcxRTBDUVpsVmZoeUszcDZBSGdYcVhGcm1pUm9aR1lUTlYv?=
 =?utf-8?B?OUQ3MnIrOW95eWRVNGd4bm82T2ZFR1ZvYWlZYnV0OUlUV3ZJa3VPYkdUb2M1?=
 =?utf-8?B?YlFkZ3lBV0lVMkVVODFIMVI0RlhESk84S3JkNnJEWGMxbGpLMy9RRDdkblNQ?=
 =?utf-8?B?MEJZNkptVU96YVdBM2dpRFhDeHpHU0p5cmViUTJGYVhhNGN0UlpYemtBWUFl?=
 =?utf-8?B?WnNWZ2twK25iT1NWNUwyUHZMNjA0T3FYeW04TVhac1lLT2JHbkVKcVFGNjJP?=
 =?utf-8?B?V1RuRG9aeVJSbHMwUUNYQXM4SjRsSTVrd3ZoaCtXU09wVnYyWHl4cG9Ea3JP?=
 =?utf-8?B?amdNb1YvMmFaSUxEc0dubytudTNYOUE5azlHTWZzZjgraStBNUdqaUIxRHJp?=
 =?utf-8?B?QkUrT0lJRGdTTmlHRmFFZUJQRlhhZWtRZlU4dkphVVppRndPYVNpUkxiU0sz?=
 =?utf-8?B?cjJ6UStLQ1V6UHlIVjhZM3RuWklGTU0xSkljSkJiZStKMUE2aStuVUpQRjR4?=
 =?utf-8?B?WkdKajhlRk1kdEZhNTNnSjRxeFdvUm1RNHl2V0ZWZHZkMDRCYTQ0ZGVsN3FG?=
 =?utf-8?B?SmZhVDkrTDd1QWdBK2JQQUpndkNJQ0xmT2ZJS0hJL3lvREJHQlA3UFBSSDJo?=
 =?utf-8?B?TWkzUnY0bE9lVnBCS3NGejhJVTdtZi8wNnpvYmVZU3dTUUpvdVpRR2VDOGJy?=
 =?utf-8?B?bUNFQzUrY08zdGNkNXR3WFo0YWRzZlZhSzNOODUxWFQwZHdSNTM0RnpIQXdJ?=
 =?utf-8?B?Vnc1aGFWWTlhUlpOUDVnZDdvdzVRQjRZcytEdnQyZDBSRWVpTkQ5d0JKcldx?=
 =?utf-8?B?RUZ1cDBwbW8yck9oejBST095ZXJDcmRWTjZYR0wzS2VLcjQySGFsK3dpeVk4?=
 =?utf-8?B?NDNVZ00yZWRqbFJKbXNQamsreHNsRTFnUjBPYXdpajFxUTV1WDMvV0tTcFA1?=
 =?utf-8?B?NVVWVjZkcTViU0FlU0czdkRHWWZFZEdJc3l6Vk1iRUxIbmVsUlViK09SWm5Z?=
 =?utf-8?B?OXRqUCtrd2s5STBJY0xtNnV1OE4zYVZLTFpzZnVzOTNhUzZlVy80cEk3OGtO?=
 =?utf-8?B?YWE5eUZPYmppZVhWNVFYNHBjcmhwa1RDYm95Y3VDTkkwWm9RcWJSUWlDdFRs?=
 =?utf-8?B?VnhhWlZENHljaktNNEcrdDlBRlNRQ1FmOXRTZmg5WVhGdzFLbnBsbmN6ZzFZ?=
 =?utf-8?B?Z1pPTmtXdkhaUEE2QWZWTm95dWVySUl3N3Q3YkVSVGVhZUI0RThOODJHWm0v?=
 =?utf-8?B?UXovS29WNy9VYW82cWttYkVoT0RuL1BIb0dPcTFmY2x5b3VzZGZQdE4wTnRO?=
 =?utf-8?B?YmwvUCtFSkNRM1BRRmxDcmY2d3hOK2pwc09BeUpaSjlUN09OZzRoblkvT0tE?=
 =?utf-8?B?ejMydW5CM2g1T0plb1RUdkFxOCtpUktEYmh3SVhNQ09RZUdCdkpsdTJuMmRl?=
 =?utf-8?B?SnR5bUVieitGVStnaUtnazBkdmhmeTFEbE8wR050Ui9iRmtiZFVLN1NUeVEx?=
 =?utf-8?B?UHFoQSs2S2NLMlNCaC9ZaW9keWFVL2EwMnU3aUE2NysrRlVReVNwTVFOV1V0?=
 =?utf-8?B?UXhjZENYcVdmUmJQZVpwMzJ3U1IwZUprZ0k1T3R6TGlmNXdJNkZSYllUbE85?=
 =?utf-8?B?cWxPcUJrNUx2N2pjWjBXcWpvT1AwTjZaNHVXUDIwZ3NZbDNQbzVWSHpDQ0d2?=
 =?utf-8?B?VDVoYXRTNVVLV2x5TjZ2L3ZCd3FuaVRSU04wdTFsUE1xalRYUlhORGU2aDJy?=
 =?utf-8?B?NnNROExWSjhsVkdiS3A3VU12OEtnQytZRTlnYWVRbi9aajZLdDBRd2Vub2NK?=
 =?utf-8?B?TTJqRGhZcDl4MEs1ZmE4TStORkpLSHY0WUF2VTd0dFZIQ3BSL2ZwV3ZnYTRR?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ppgbbqVTLTcC2IpVf1uNxNhFMYxIsdgeOLNCBz1M4obYlLTxFAvBo/HS1kXTrpRSL+HjufSxnwFsWeNNtIwwOQtKG7Xomty31fFAMKEvG1FKHO/i+lZkpvdEfpDIrvnTEqxdav6RCWas6m/zgrqgcb7q8j9osCNg2Ph0QOsws0cRyFU10tC8qkTA/LJQAUNGY4mm5A3WSCXx/4I4JOxxNd2767Oswz7ZXr49TS513ziJDE0rOg+e/+nJSkC/LNMeRRak5G/TpdBPAo5qBZEfccPZuQPwZo3Hg1cpn1BRbd2b6EXKIP34UCN7TLcz84GitNXOoUDTOMLwLf+abJ1vRjCPgSuOX4PHrGKAAcAxJtRAC6kcJjCyGFjs3HUlhb9sqd2YS7/IPUr000RmTwiiNhyp+aYqBeMebKhL9Blqrsu2DzxXkBWGxAkonho7ZIw/l9z6klm/yPE6kG8XWHIanh7rR5V3VXLmBrap/JxsR4CHYDk94FsCbH4L0q6dYxWk00CMYMLp0WDBY46BDIewNMngpiDQUqv0QAgHvRyHeom0XEJ00pWWmwY9EX14f8aUvUCY2CZJtSMiIRwOR/iqIsWB9z3nzmjn4xnmsQKEzbM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fced220-bd68-4c91-a307-08dce4a209a6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5611.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:26:18.0166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wg521SPbi9/Lq/Ox6ADNCWg2Aih6PQA+hojFMzmAuax4LH8ocI4dTxOYLdmgx7uQ0p6sU/6BIFmeMNrrrsnYcmesDO6GoOgpikAEQKZC6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_15,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040127
X-Proofpoint-ORIG-GUID: DfmkKZe4y09iAQJZ10LqAoZ4HWqZyBj8
X-Proofpoint-GUID: DfmkKZe4y09iAQJZ10LqAoZ4HWqZyBj8

On Fri, Oct 04, 2024 at 11:17:13AM -0700, Jeff Xu wrote:
> Hi Lorenzo,
>
> Please add me to this series, I 'm interested in everything related to
> mseal :-), thanks.

Hi Jeff, more than happy to cc you on this going forward :)

The only change to mseal is a trivial change because the poison operation
discards, wasn't intentional, but apologies, I should have cc'd you
regardless! Will do so on any such interaction with mseal moving forward.

>
> I also added Kees into the cc, since mseal is a security feature.

Sure no problem happy to keep Kees cc-d too (Kees - ping me if you'd prefer
not :>), however a note on this - guard pages _themselves_ are emphatically
NOT a security feature, and make no guarantees on this front, but rather
are a convenience/effiency thing.

Obviously however I am adding madvise() functionality here, and all such
functionality must take into account whether or not they are discard
operations as to ensure mseal semantics are obeyed - see below for my
argument as to why I feel the poison operation falls under this.

>
>
> On Fri, Sep 27, 2024 at 5:52 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > Implement a new lightweight guard page feature, that is regions of userland
> > virtual memory that, when accessed, cause a fatal signal to arise.
> >
> > Currently users must establish PROT_NONE ranges to achieve this.
> >
> > However this is very costly memory-wise - we need a VMA for each and every
> > one of these regions AND they become unmergeable with surrounding VMAs.
> >
> > In addition repeated mmap() calls require repeated kernel context switches
> > and contention of the mmap lock to install these ranges, potentially also
> > having to unmap memory if installed over existing ranges.
> >
> > The lightweight guard approach eliminates the VMA cost altogether - rather
> > than establishing a PROT_NONE VMA, it operates at the level of page table
> > entries - poisoning PTEs such that accesses to them cause a fault followed
> > by a SIGSGEV signal being raised.
> >
> > This is achieved through the PTE marker mechanism, which a previous commit
> > in this series extended to permit this to be done, installed via the
> > generic page walking logic, also extended by a prior commit for this
> > purpose.
> >
> > These poison ranges are established with MADV_GUARD_POISON, and if the
> > range in which they are installed contain any existing mappings, they will
> > be zapped, i.e. free the range and unmap memory (thus mimicking the
> > behaviour of MADV_DONTNEED in this respect).
> >
> > Any existing poison entries will be left untouched. There is no nesting of
> > poisoned pages.
> >
> > Poisoned ranges are NOT cleared by MADV_DONTNEED, as this would be rather
> > unexpected behaviour, but are cleared on process teardown or unmapping of
> > memory ranges.
> >
> > Ranges can have the poison property removed by MADV_GUARD_UNPOISON -
> > 'remedying' the poisoning. The ranges over which this is applied, should
> > they contain non-poison entries, will be untouched, only poison entries
> > will be cleared.
> >
> > We permit this operation on anonymous memory only, and only VMAs which are
> > non-special, non-huge and not mlock()'d (if we permitted this we'd have to
> > drop locked pages which would be rather counterintuitive).
> >
> > The poisoning of the range must be performed under mmap write lock as we
> > have to install an anon_vma to ensure correct behaviour on fork.
> >
> > Suggested-by: Vlastimil Babka <vbabka@suze.cz>
> > Suggested-by: Jann Horn <jannh@google.com>
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  arch/alpha/include/uapi/asm/mman.h     |   3 +
> >  arch/mips/include/uapi/asm/mman.h      |   3 +
> >  arch/parisc/include/uapi/asm/mman.h    |   3 +
> >  arch/xtensa/include/uapi/asm/mman.h    |   3 +
> >  include/uapi/asm-generic/mman-common.h |   3 +
> >  mm/madvise.c                           | 158 +++++++++++++++++++++++++
> >  mm/mprotect.c                          |   3 +-
> >  mm/mseal.c                             |   1 +
> >  8 files changed, 176 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
> > index 763929e814e9..71e13f27742d 100644
> > --- a/arch/alpha/include/uapi/asm/mman.h
> > +++ b/arch/alpha/include/uapi/asm/mman.h
> > @@ -78,6 +78,9 @@
> >
> >  #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse */
> >
> > +#define MADV_GUARD_POISON 102          /* fatal signal on access to range */
> > +#define MADV_GUARD_UNPOISON 103                /* revoke guard poisoning */
> > +
> >  /* compatibility flags */
> >  #define MAP_FILE       0
> >
> > diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
> > index 9c48d9a21aa0..1a2222322f77 100644
> > --- a/arch/mips/include/uapi/asm/mman.h
> > +++ b/arch/mips/include/uapi/asm/mman.h
> > @@ -105,6 +105,9 @@
> >
> >  #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse */
> >
> > +#define MADV_GUARD_POISON 102          /* fatal signal on access to range */
> > +#define MADV_GUARD_UNPOISON 103                /* revoke guard poisoning */
> > +
> >  /* compatibility flags */
> >  #define MAP_FILE       0
> >
> > diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
> > index 68c44f99bc93..380905522397 100644
> > --- a/arch/parisc/include/uapi/asm/mman.h
> > +++ b/arch/parisc/include/uapi/asm/mman.h
> > @@ -75,6 +75,9 @@
> >  #define MADV_HWPOISON     100          /* poison a page for testing */
> >  #define MADV_SOFT_OFFLINE 101          /* soft offline page for testing */
> >
> > +#define MADV_GUARD_POISON 102          /* fatal signal on access to range */
> > +#define MADV_GUARD_UNPOISON 103                /* revoke guard poisoning */
> > +
> >  /* compatibility flags */
> >  #define MAP_FILE       0
> >
> > diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
> > index 1ff0c858544f..e8d5affceb28 100644
> > --- a/arch/xtensa/include/uapi/asm/mman.h
> > +++ b/arch/xtensa/include/uapi/asm/mman.h
> > @@ -113,6 +113,9 @@
> >
> >  #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse */
> >
> > +#define MADV_GUARD_POISON 102          /* fatal signal on access to range */
> > +#define MADV_GUARD_UNPOISON 103                /* revoke guard poisoning */
> > +
> >  /* compatibility flags */
> >  #define MAP_FILE       0
> >
> > diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> > index 6ce1f1ceb432..5dfd3d442de4 100644
> > --- a/include/uapi/asm-generic/mman-common.h
> > +++ b/include/uapi/asm-generic/mman-common.h
> > @@ -79,6 +79,9 @@
> >
> >  #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse */
> >
> > +#define MADV_GUARD_POISON 102          /* fatal signal on access to range */
> > +#define MADV_GUARD_UNPOISON 103                /* revoke guard poisoning */
> > +
> >  /* compatibility flags */
> >  #define MAP_FILE       0
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index e871a72a6c32..7216e10723ae 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -60,6 +60,7 @@ static int madvise_need_mmap_write(int behavior)
> >         case MADV_POPULATE_READ:
> >         case MADV_POPULATE_WRITE:
> >         case MADV_COLLAPSE:
> > +       case MADV_GUARD_UNPOISON: /* Only poisoning needs a write lock. */
> >                 return 0;
> >         default:
> >                 /* be safe, default to 1. list exceptions explicitly */
> > @@ -1017,6 +1018,157 @@ static long madvise_remove(struct vm_area_struct *vma,
> >         return error;
> >  }
> >
> > +static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
> > +{
> > +       vm_flags_t disallowed = VM_SPECIAL | VM_HUGETLB;
> > +
> > +       /*
> > +        * A user could lock after poisoning but that's fine, as they'd not be
> > +        * able to fault in. The issue arises when we try to zap existing locked
> > +        * VMAs. We don't want to do that.
> > +        */
> > +       if (!allow_locked)
> > +               disallowed |= VM_LOCKED;
> > +
> > +       if (!vma_is_anonymous(vma))
> > +               return false;
> > +
> > +       if ((vma->vm_flags & (VM_MAYWRITE | disallowed)) != VM_MAYWRITE)
> > +               return false;
> > +
> > +       return true;
> > +}
> > +
> > +static int guard_poison_install_pte(unsigned long addr, unsigned long next,
> > +                                   pte_t *ptep, struct mm_walk *walk)
> > +{
> > +       unsigned long *num_installed = (unsigned long *)walk->private;
> > +
> > +       (*num_installed)++;
> > +       /* Simply install a PTE marker, this causes segfault on access. */
> > +       *ptep = make_pte_marker(PTE_MARKER_GUARD);
> > +
> > +       return 0;
> > +}
> > +
> > +static bool is_guard_pte_marker(pte_t ptent)
> > +{
> > +       return is_pte_marker(ptent) &&
> > +               is_guard_swp_entry(pte_to_swp_entry(ptent));
> > +}
> > +
> > +static int guard_poison_pte_entry(pte_t *pte, unsigned long addr,
> > +                                 unsigned long next, struct mm_walk *walk)
> > +{
> > +       pte_t ptent = ptep_get(pte);
> > +
> > +       /*
> > +        * If not a guard marker, simply abort the operation. We return a value
> > +        * > 0 indicating a non-error abort.
> > +        */
> > +       return !is_guard_pte_marker(ptent);
> > +}
> > +
> > +static const struct mm_walk_ops guard_poison_walk_ops = {
> > +       .install_pte            = guard_poison_install_pte,
> > +       .pte_entry              = guard_poison_pte_entry,
> > +       /* We might need to install an anon_vma. */
> > +       .walk_lock              = PGWALK_WRLOCK,
> > +};
> > +
> > +static long madvise_guard_poison(struct vm_area_struct *vma,
> > +                                struct vm_area_struct **prev,
> > +                                unsigned long start, unsigned long end)
> > +{
> > +       long err;
> > +       bool retried = false;
> > +
> > +       *prev = vma;
> > +       if (!is_valid_guard_vma(vma, /* allow_locked = */false))
> > +               return -EINVAL;
> > +
> > +       /*
> > +        * Optimistically try to install the guard poison pages first. If any
> > +        * non-guard pages are encountered, give up and zap the range before
> > +        * trying again.
> > +        */
> > +       while (true) {
> > +               unsigned long num_installed = 0;
> > +
> > +               /* Returns < 0 on error, == 0 if success, > 0 if zap needed. */
> > +               err = walk_page_range_mm(vma->vm_mm, start, end,
> > +                                        &guard_poison_walk_ops,
> > +                                        &num_installed);
> > +               /*
> > +                * If we install poison markers, then the range is no longer
> > +                * empty from a page table perspective and therefore it's
> > +                * appropriate to have an anon_vma.
> > +                *
> > +                * This ensures that on fork, we copy page tables correctly.
> > +                */
> > +               if (err >= 0 && num_installed > 0) {
> > +                       int err_anon = anon_vma_prepare(vma);
> > +
> > +                       if (err_anon)
> > +                               err = err_anon;
> > +               }
> > +
> > +               if (err <= 0)
> > +                       return err;
> > +
> > +               if (!retried)
> > +                       /*
> > +                        * OK some of the range have non-guard pages mapped, zap
> > +                        * them. This leaves existing guard pages in place.
> > +                        */
> > +                       zap_page_range_single(vma, start, end - start, NULL);
> > +               else
> > +                       /*
> > +                        * If we reach here, then there is a racing fault that
> > +                        * has populated the PTE after we zapped. Give up and
> > +                        * let the user know to try again.
> > +                        */
> > +                       return -EAGAIN;
> > +
> > +               retried = true;
> > +       }
> > +}
> > +
> > +static int guard_unpoison_pte_entry(pte_t *pte, unsigned long addr,
> > +                                   unsigned long next, struct mm_walk *walk)
> > +{
> > +       pte_t ptent = ptep_get(pte);
> > +
> > +       if (is_guard_pte_marker(ptent)) {
> > +               /* Simply clear the PTE marker. */
> > +               pte_clear_not_present_full(walk->mm, addr, pte, true);
> > +               update_mmu_cache(walk->vma, addr, pte);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct mm_walk_ops guard_unpoison_walk_ops = {
> > +       .pte_entry              = guard_unpoison_pte_entry,
> > +       .walk_lock              = PGWALK_RDLOCK,
> > +};
> > +
> > +static long madvise_guard_unpoison(struct vm_area_struct *vma,
> > +                                  struct vm_area_struct **prev,
> > +                                  unsigned long start, unsigned long end)
> > +{
> > +       *prev = vma;
> > +       /*
> > +        * We're ok with unpoisoning mlock()'d ranges, as this is a
> > +        * non-destructive action.
> > +        */
> > +       if (!is_valid_guard_vma(vma, /* allow_locked = */true))
> > +               return -EINVAL;
> > +
> > +       return walk_page_range(vma->vm_mm, start, end,
> > +                              &guard_unpoison_walk_ops, NULL);
> > +}
> > +
> >  /*
> >   * Apply an madvise behavior to a region of a vma.  madvise_update_vma
> >   * will handle splitting a vm area into separate areas, each area with its own
> > @@ -1098,6 +1250,10 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
> >                 break;
> >         case MADV_COLLAPSE:
> >                 return madvise_collapse(vma, prev, start, end);
> > +       case MADV_GUARD_POISON:
> > +               return madvise_guard_poison(vma, prev, start, end);
> > +       case MADV_GUARD_UNPOISON:
> > +               return madvise_guard_unpoison(vma, prev, start, end);
> >         }
> >
> >         anon_name = anon_vma_name(vma);
> > @@ -1197,6 +1353,8 @@ madvise_behavior_valid(int behavior)
> >         case MADV_DODUMP:
> >         case MADV_WIPEONFORK:
> >         case MADV_KEEPONFORK:
> > +       case MADV_GUARD_POISON:
> > +       case MADV_GUARD_UNPOISON:
> >  #ifdef CONFIG_MEMORY_FAILURE
> >         case MADV_SOFT_OFFLINE:
> >         case MADV_HWPOISON:
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index 0c5d6d06107d..d0e3ebfadef8 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -236,7 +236,8 @@ static long change_pte_range(struct mmu_gather *tlb,
> >                         } else if (is_pte_marker_entry(entry)) {
> >                                 /*
> >                                  * Ignore error swap entries unconditionally,
> > -                                * because any access should sigbus anyway.
> > +                                * because any access should sigbus/sigsegv
> > +                                * anyway.
> >                                  */
> >                                 if (is_poisoned_swp_entry(entry))
> >                                         continue;
> > diff --git a/mm/mseal.c b/mm/mseal.c
> > index ece977bd21e1..21bf5534bcf5 100644
> > --- a/mm/mseal.c
> > +++ b/mm/mseal.c
> > @@ -30,6 +30,7 @@ static bool is_madv_discard(int behavior)
> >         case MADV_REMOVE:
> >         case MADV_DONTFORK:
> >         case MADV_WIPEONFORK:
> > +       case MADV_GUARD_POISON:
>
> Can you please describe the rationale to add this to the existing
> mseal's semantic ?
>
> I didn't not find any description from the cover letter or this
> patch's description, hence asking.

Sure, this is because when you guard-poison ranges that have existing
mappings, it zaps them, which performs basically the exact same operation
as MADV_DONTNEED, and obviously discards any underlying data in doing so.

As a result, I felt it was correct to add this operation to the list of
discard operations from the perspective of mseal.

>
> Thanks
> -Jeff
>
> >                 return true;
> >         }
> >
> > --
> > 2.46.2
> >
> >

