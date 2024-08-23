Return-Path: <linux-arch+bounces-6557-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFF695D25F
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2024 18:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924EB1F220FD
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2024 16:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2331898F8;
	Fri, 23 Aug 2024 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="WGptGS8Y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="oLZnHrfF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout43.security-mail.net (smtpout43.security-mail.net [85.31.212.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A371F18A6A9
	for <linux-arch@vger.kernel.org>; Fri, 23 Aug 2024 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429105; cv=fail; b=JhySQ8UOIvIp/+xNZDXMtZrXT7IluxPUTB7cACqjcfCqlpiSsgvu79PQ/YJqmVvDak7jLcBZTCsbd2QZM5gBjU3x3xx9k1dSwdGSrWydPaQUL0YZ9Rou9bOD0KgDMTkIuX0VX21bMkxVh6xi5E9GA0J6an9DEtX0Rcx/x+tpXQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429105; c=relaxed/simple;
	bh=89ZKYoLYk+p8wqGKURVAViPbto+cwGj+j2OJMj3CqnY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bbJc7vHW91rr06GdVvE0pFhXZYKBXWaREnZ/BKtl1GZ8edhDtWjuYCaaSC+lphKpV3+OlZ8tGhkqSEi6FEwA1qSxlXgaNSigoI9BKCuUnCqgK8XQd9JQS693lGv7FjdqPsrL8e5G4526bhqrS4lRMfyqUR9NgIgnevztG0crqMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=WGptGS8Y; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=oLZnHrfF reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx303.security-mail.net [127.0.0.1])
	by fx303.security-mail.net (Postfix) with ESMTP id 708DC30EDFC
	for <linux-arch@vger.kernel.org>; Fri, 23 Aug 2024 18:02:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1724428940;
	bh=89ZKYoLYk+p8wqGKURVAViPbto+cwGj+j2OJMj3CqnY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WGptGS8Y7gAguiAybdQsa114sj062hYUC+D7fCOYAZU57rv/aynPFc89HPGd0kUGZ
	 iQvB/sg8xEdJ6fRJwLaNKNOo4emxOs5Nz5whoJq8FkhFzzOBvuqeslmFwQbj3d/Kg3
	 ZM+mEB4BEijoLPji+ZD2dMFWB/nCx1K+aD0DKzdQ=
Received: from fx303 (fx303.security-mail.net [127.0.0.1]) by
 fx303.security-mail.net (Postfix) with ESMTP id BA94530EBE9; Fri, 23 Aug
 2024 18:02:19 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17010002.outbound.protection.outlook.com
 [40.93.76.2]) by fx303.security-mail.net (Postfix) with ESMTPS id
 CAC8A30EB15; Fri, 23 Aug 2024 18:02:18 +0200 (CEST)
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::6)
 by PATP264MB4620.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:42b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 16:02:17 +0000
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39]) by PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39%4]) with mapi id 15.20.7897.014; Fri, 23 Aug
 2024 16:02:17 +0000
X-Secumail-id: <be95.66c8b28a.c6bbc.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6MCOX6IDLFJY6jQ3THusWxsGegZwmQgOkvy5xCjwr6oxTvdn+Z/EnIB+CPVpHEc0ACDCceUT50s1lRGZPKAjxdgTdodpf16QblaFlyt6rddxZXoOxrDR+jZAm5tgAPT+6BQHMYBJFHpdLVA48XxF3Oj4iNaCEdjND+AjfdQB95AqYERJpD854qUeAMtwumIDIIV7joEiBm6lq6sC65JdLd68uMhimjDOX+UOZFLUocEW3RyslQKvPQRjfYE2sEBDTvW/rlpR4Z5aaDzFwXQUF/c7Ugr9PedzQ9JtTuyEvKnkyeN6CZLE+IAmE8DJYEo02fs25Dtw5k1Y9EEz10IZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ii6HvnpCfEwV1o2++1pTTIxXtcWapRhDPTwVa5cRMWY=;
 b=E/H61CP2vHJHUJ3G9t3K1L7xo4iE2c9IR+4tnOAU/iit1E5Y986+Zl89SCa+5lA+MBjFMwnQfgbhtc0NNEv0khmdS9GVXGwlyzcSC1RbbRFUj3lY/44BH9G9XrE0deFgf2poIbF9Y/LZR8yy7fXTsrTeqZ/YTLB0FvVjPgDs/yYBG4BIqp4Pm0t1rEwtj72CXdeDZgcCSE4OJgHtXFXqzToB6fpJ+OrxCWKkNB5iMy1jIG/iP6EmPE0p9X3t8krFxyHXuZADHEIzwS1kxnbTBPJ2+8M8C/whZV4iA4PEVQesl6eWN8nYfJjgPuOZi/XmDKcqdU02jsYbL12zUfpJ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ii6HvnpCfEwV1o2++1pTTIxXtcWapRhDPTwVa5cRMWY=;
 b=oLZnHrfFm73Mj9/fh4PVfnxSZxtMkktYUpvM58EV2NaBNqWpZrbuuE9KQeDMh+VpSMKz5/vKOGX5Ir5MFehX/bCpRMArqNCBMDr0sa/ked4gGzeFcFbPNUggK6nuO87KmZ59FsnABySkyS7NSKOb4nMPWP3FBS7e1oQ+l6di9c91J5PgdLzi1m99DYaoH8LeUwbexcZWb3C3wdWQdzWlTBuuNRPkbtpgZ2y+/40kNPWwE3458DULrtd9vXf2qyqX2c1bIHvL4vSw65yV1YaI81jhcnkcE4qGsBOvokeEaBJpSMiz10tgt2M6yekBJBZ+/ctmOI3cRlWrMcrYwqmQtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <be04b692-d4ef-4e59-896c-085d92e3d193@kalrayinc.com>
Date: Fri, 23 Aug 2024 18:02:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 24/37] kvx: Add memory management
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jonathan
 Borne <jborne@kalrayinc.com>, Julian Vetter <jvetter@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Guillaume Thouvenin <thouveng@gmail.com>,
 Jean-Christophe Pince <jcpince@gmail.com>, Jules Maselbas
 <jmaselbas@zdiv.net>, Julien Hascoet <jhascoet@kalrayinc.com>, Louis Morhet
 <lmorhet@kalrayinc.com>, Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
 Marius Gligor <mgligor@kalrayinc.com>, Vincent Chardon
 <vincent.chardon@elsys-design.com>, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, Robin Murphy
 <robin.murphy@arm.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-25-ysionneau@kalrayinc.com>
 <Zp5zrkwyagnkoY7F@infradead.org>
Content-Language: en-us, fr
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <Zp5zrkwyagnkoY7F@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0107.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fb::17) To PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:14b::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB3481:EE_|PATP264MB4620:EE_
X-MS-Office365-Filtering-Correlation-Id: d079561b-727b-4847-f625-08dcc38cf642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: Sf58UtvvB1FquwvBdQdShGjBdKqcoG1diwnRUT+JBno368TB3YyfpAUpeBb2spC5aKu3n74V5LrfePYcqeZfrFvIL30jiYp5fO9xXBnCjZs0FVpdxTA1gzBX3ok5njo7qvvoUpVVgWEkdj7sz5lWJKI2hmSLla838+EgOpKnQd9oPkQn4rf6pn8lC4976fmRojZ6aY0z68Bm3rNWDHqjdmuXGPXbDKUNEop7uTg7aEn6L+/4zS47qs7mT14t9FklBjqHiWvjsoh6XBd/xVZtKMaDP06AUW00kAjF1c0pVTTL2NNgtkux9CQgoQOY5rLyCU0DjW1j8DNwfHtXUZnhsTsIjZZk1uFBuAJCrjD0ExILwuGNa4gR1W9Ho8RnH/MbZind+AFzmfG9/83q4O/ATT4AT4jZGLPh2lal2jzaRxO/HdEwkux1sgv9Zp08VmoyatK78sOYeBYrwZ6EFC1CXkZJ5WDvkHo+iCqI8irlraQOvLBmfkxr6VUW93of2CZNYg0Uez30Q8N1RW7YdhP6n9A5vnit37Szhnla9CF8S4pSnU+zW6lJT8Z5lQpVFIDhGeMrKA4t1xS66C6wRGST/78LGBFPByA8z+GIUNxE6PGiVxyEvEsnB3Pg7V0zxRtoR483lYli0IS8OHbyGkhA4k1wKwnhfvMW1qdKJremYFFy3IFErA42QFmiBcejPKqdo7OnvxkJOEh5ZJQOEbqXIEwVz+A+HxIXwSPCadRepis7gJiD7LQ4NtlZw3qSg9NTTv8d3L5koM9mqRBM+Ijp5kxLXa5X2HniOFz5MuJzZZRZWeN+FFGVwEbkDmntYBVfeeamQpUGS/hnPUVNyW3k9skoEHG1axmhU/l6HjvsplQiNjWMUiPj+i6LQ2SGNoEKyXqRvwrdEEgxCMdHsoQpIGMi1DnGuBah2d0nFgDU/boE2UJ7CB+cH3nk7z8ZzSwzLF6
 JjiR9NfdygQgTvJ9v7vQJaAXRqufIzciZFU2ih+Xa1/ZvZt5d5pwv8z1VYGUsjyYZ6iZV0wps+4Qb5VVo73eXV3D21JD+mnagQCn9XClBjP3+qpe8MTP3kAPD2vKioeZfSnQZODyIB7wxYdQghNcKGoWd5XZ4Iez6nUNpUB4kWYzlhWwH+LSvuI4bIwf0A0o8lAAp0NE6A1sJShL2s+KGJmf/06jHmt32hPDkjpKQaBBxiU0qJWGA2WnNNgMfC1GyDWzfdPvWAgsNV3KX/NzMTyB82GdJSgVmpkmw3eQTSHf/OFoR0HQapU4VfEdrWR2FwHPMnc7tEMM6DJ8sfLMEIoDNwLQzLAzPYZxWhzU2K3UrTRmJ2i8RC/u95ZYucQYKyCawrCqiO9Y4hCQTQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9ZNJggNrIvUd3Z6ySpkysuoJGsS3Ll3ttEWhzRBl+8a3jDRZpTJ0gvzAsJ/2rdVjalLoAfOufxzFgMREMHwMi+tMOvLDKF0lvhah/U2j18PTuvaQzP4XDf8USIL7kYBalaPAvWpONg5ojfmx52Y5WWRTEpU99fOnCnNcSslwD6jPtfojGnebKki30BZhZZnbNlfUWTyD6PDul4CzrwiRzGeL20ovqOqF9bgzd8tmDP7ZNQnPdhXgvZRbWSgGEDJNn2cwDTDRG4lMFHHDbuglBUZXO0aPfwj2JfJb5TV5bKKnTehm4t/fzvC5ZXI2vnxni0hPqTJb7gsCaRg6/WFX8tQPHR+uSPzwZW3MAIzU5gAbKUbbFs/1+FBZBS9MfxbqNIfEmG9tGmtFWHs61cHt1ts1RcRqQYz1WInK5f605CmKRpcSjtazca6Yo+eWG8BwqenGZDfwqzkUAmUJJZM7qmtDk/w1pKHxSn7AtO8lLPZ0cNVXemOW/syK+fqj01V4bTooyMfL/ruc0y/m2STf0DuTzAIuGKdKva8Zu6bE6CSrU1d3IxmEPpLDA17YfXxFb6JABDDyclrjxmL49/3jTvyHcJ1VBC93mvS/1szDTtwfMgjbFhkOb9duteXrSKB+hD6IcyGo68ZO2WYG4DkurNBa2Qp2psONJXML5a8AMjOO2WZD2ruTqqZslzkNvKXkrC1NkGd2tuwdJ/KaUsM9DL6lEFZDkzCwpvUi2NQEO+/3UIxdsqKYq0vksYLVAjor7Uw/+3nJkZo38ZS1agWT7YX/M4ncchwoLogPC/p8n16GCNzOBYLWGMAzwYAE0CXGQ0kbJoaIrrSjbmPuBO4VLkV1P8/VSkoaekyD+Hs3MiIC2r4MTxOedVznrh/hakWVU/8uOOu6RriNrZEtt9NT148rAW/hwIniOoA24V8c9NkXe4ha0VrPFeBe7r3u4UUh
 JfPscBBYaneIQlEa1gEvWhFyMhP1ZWr3BHBgKBBMgwoS1IaXHF8vc62Dui+9u4B4IYW05n/abR4bt1smi4rcV40/sn1ZyVXjMHTIc35fDdAxMXFzsBIRHAQKq3Gr9NNxtTsBG23uY9cQpmcYUuIu5EKrVIqcwjJWBoQS520yWT3kIztccvatMOCZ8lehtEDVUauifXiMn5JP8KEEHWm+unFXaIlJWdBK5jW6bxqstU+etZJOrKGebg1pRFbaz0k+71hvv31Tg2eABWu9eGpgdDqA+LkgvoxON6HqCmz6+gu7vZAKWJjZPCXnSgdmTrMmbUr5Co7Tmk2pmfPW615kMW4JO78sPHag13DWBGZ+hwhgJHOCboBjMMiaDy9fvuOadN2ZwFmc0Z2QmWhhG1Jq6OGEVzd1+THcOxGZ6B0JxdblbY7LkZi0HZH2HMexXieGERKpSpImS9pwHXQ17XDGI+WCZO/Oe0yXJRirfAFWMUxniMStqG8Uby58x4EF5giW7AkSlJ2J4QcjIg9YYgxkuai8gdzD24v2FEIny/jFc1hdEPCHUtM+niVxLq/Ua6ZdKwiey3mp1kvxhA55hKscOESnRMTJhbS934VsjZmQkTRHEWXSRw3OAivLgwTG+UKaXrMsbrwKDSyLLIgbtGlY6PckeTEkcTeQsS6iH+y7vtF6syhKtKlnTX/iKJHy53+F1N6KP9lbWVNPTaswrh9RWw==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d079561b-727b-4847-f625-08dcc38cf642
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 16:02:17.5419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1TQ/BYE4gqhzUYpnhZXdiQsb1n6BALEjkRnzHh2LNtiKOOFreumPftIkAe4nsDKgGB6fXes3v98N3L1n5SIVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB4620
X-ALTERMIMEV2_out: done

Hello Christoph,

On 22/07/2024 16:58, Christoph Hellwig wrote:
>> +#include "../../../drivers/iommu/dma-iommu.h"
> This is not a public header as you can guess from the file path.

Yes indeed this is not "correct" however I didn't know how to do it properly so I am sending this as "RFC" to get some help to clean this up properly :)

If I understood correctly the remaining part of your review: including this header is not needed anymore since we don't need to call `iommu_setup_dma_ops()` anymore.

So let's remove both the incorrect non-public header include and the call to iommu_setup_dma_ops().

>
>> +	switch (dir) {
>> +	case DMA_TO_DEVICE:
>> +		break;
>> +	case DMA_FROM_DEVICE:
>> +		break;
>> +
>> +	case DMA_BIDIRECTIONAL:
>> +		inval_dcache_range(paddr, size);
> Doing this just for bidirectional is weird unless your architecture
> never does any speculative prefetching.  Other architectures
> include DMA_FROM_DEVICE here.
Indeed our arch never does any speculative prefetching on data.
>
>> +#ifdef CONFIG_IOMMU_DMA
>> +void arch_teardown_dma_ops(struct device *dev)
>> +{
>> +	dev->dma_ops = NULL;
>> +}
>> +#endif /* CONFIG_IOMMU_DMA*/
> This should not be needed right now.  And will be completley
> useless once we do the direct calls to dma-iommu which we plan
> to do for Linux 6.12.
Alright, let's remove this.
>
>> +void arch_setup_dma_ops(struct device *dev, bool coherent)
>> +{
>> +	dev->dma_coherent = coherent;
>> +	if (device_iommu_mapped(dev))
>> +		iommu_setup_dma_ops(dev);
>> +}
> And this seems odd, as iommu_setup_dma_ops is called from the iommu
> code and you shouldn't need it here.
Let's remove the `if device_iommu_mapped(dev)) iommu_setup_dma_ops(dev);` then.
>
> I also wonder if we can come up with a way to do the ->dma_coherent
> setup in common code and remove a few of these arch hooks entirely.

Thanks!

Regards,

-- 

Yann






