Return-Path: <linux-arch+bounces-5371-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F40A92EEF7
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2024 20:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA3FB216E8
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2024 18:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275DB16DEB9;
	Thu, 11 Jul 2024 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aLqSaHR2"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F4554657;
	Thu, 11 Jul 2024 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722935; cv=fail; b=k/8KdOeGmBPWm8TMONUaheeBmR3QqcpbyP1FTlk5TzT1CE3Q2B35V0Pq3OP3C/bCHlJiOAITlx/gJHWplB9du3qCcUSKi9kwLBqaNUwZu1K3M504+YxjXKCZ+OgjVwq8vIMnx9mBYi2lCorlKWtLBL3raeH2BeD8P9P1A1KiFfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722935; c=relaxed/simple;
	bh=xmcNSETvlB6lMnYHfj3R5xKZoxYPzefEjbDtx41k4bM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CsbgIvHp6Ga230nGEOmzSBi3EFN11aG4IbtCYvH8n8zxfZo5x+880kPffl1b5JIu59qtJnVv4sRMpCoV9OWZDIhoTaOgblKRMgqsXryQnr2KrEepdTWWIzymUOOd+1oHg0OVmlyHHgMiyTdZNDx32DsON6w8PXMOU9EqYHLBibE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aLqSaHR2; arc=fail smtp.client-ip=40.107.100.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRRUOAvbTn8BqgGCrXFYPnyXa5uDo/xoijx961R10y4aberRmNIv9Gze9BDpJ4ojOS6ZfwOgZn4SwzY+B6Ki5+91Xox7SzxSG4Onu3VA6zM8AEM+Qtl7kHhZFj0w2Shd2I+31eC0BtjvbnrKBQZgpz5kw+GbGPQPNZD2XsE8HfWCYgpAmogbm+QDALvJtclvuWszMKwsgZe9sy0tO9kvKWTYeVkOqIJcAuULJmoclIgijzAamu5bJHjNSxkUhaeaS2+w/v57R1Ci0EC2OYWGM+h5KQcoKZT0M+7CcIh9jkvATUkOWX40iccJyoS/LGeCJRszRKk/Ce23eqqzf9J++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2aTVP5HqZEYukCPHiP+CDzDDZm8/MsCjqfI9zyspRY=;
 b=zDOie5fllopjwztU8TLzTgYWV+iM0XXJkgUcOL9c29yGzhNyCOI7iW756k3zR+KUou02OomHEdSN2Mule8PZ/JLDJGd8ut3NxKGc0BOGe6rW9EVPTqXYiQ8+S2yMgOuW4RDbm2LqdKlgYyM7Lqar3SN0rqiLX9W4YAT2P5Q4StM5yjVIQADdzte4j722x57Uepp9m0fJsP1YHs+Q8Bxt6XduLH+ZbaLbf9UPW0ux5cTNuFTpWFIY5vPZ3+zZ6peix8BARoQAW4h0gq8/g1Oef7CWMOs2UleqFCG8FneXpidl2zd1lMag4vTQDvhgqEoGhzWlfjKNl7QHxSQGlB9TPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2aTVP5HqZEYukCPHiP+CDzDDZm8/MsCjqfI9zyspRY=;
 b=aLqSaHR2qNzbQMrIJex9xjeVXVoGQl2m2pEstSVkK55C6JYA8XIsPhqyDNYQMLLFmfwc9ThRKD/JaZWf7IR5/AiuWIh2xfVonHYm6aqUJiBVHfxLLhfu2jDhFrETa6jvRk+xOgYTPssmbPFug3hoNIg7X+SaWrcV9A13T7gRbdvC3qsvp7s/h/qTDvzK3tgxgiivD9mUBq5e74zUhx/otic0q32SCTS7ypJgLROz0xhl/PY250RYBoalcnyG4/yhwez5XDuf4EZ9jeQgERgi+A+S87MTFJ+qipEZzdUa4Wj4gYo3+W1OITZ9F3hPbkuUXuyfDM12V+7AzT51j87zug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 18:35:28 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%2]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 18:35:28 +0000
Message-ID: <0be43301-9df7-4b7f-9932-b820841712e3@nvidia.com>
Date: Thu, 11 Jul 2024 11:34:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v16 12/13] selftests: add ncdevmem, netcat for
 devmem TCP
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>,
 Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Stanislav Fomichev <sdf@google.com>
References: <20240710001749.1388631-1-almasrymina@google.com>
 <20240710001749.1388631-13-almasrymina@google.com>
 <4b0479b0-1e0f-43db-8333-26b7a1fd791c@nvidia.com>
 <CAHS8izOc4gZUP-aS747OVf3uyn8KAyfeBcYDx2CQc-L9RnvrXA@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAHS8izOc4gZUP-aS747OVf3uyn8KAyfeBcYDx2CQc-L9RnvrXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:a03:338::30) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e110b21-7099-4809-57c6-08dca1d83c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTdoWE9Qdmo2ZWxoZWcrdkxMd1VIWVkwV2JGNnZ0UTVxTFBlR3ZCcnFNMWps?=
 =?utf-8?B?Mk9XNnZuWCtTRksyUzFuUUJWT0F2bDI0ZTNud2JEa1dNdjN1UENNSlpEL0VJ?=
 =?utf-8?B?a0sxZ0RucVFIMmtUTFhQekNQSHNTckZtUFNWSjYwN1IySGV1UnVXYkY5NXF4?=
 =?utf-8?B?eis2Q1J5WStxVDFzQXRJRmNFTHR5M1kwL1owYnIzK095ZUx3SEJrekxJTUpL?=
 =?utf-8?B?cStTMExqY0RnTnZCQnlySnp2QUdYUVltUHY4WnMrSlRjN25YYW0xanpuOE00?=
 =?utf-8?B?Ym5tWFFJZUJQbmZIdzZJd2x3TVgxWVJoNGtpeVA0WXFKcU9CYVlnWCtxY1Ay?=
 =?utf-8?B?c0kxMTBBQ2ErTDZ3UVFkcDFXWVQyRjdjRE9kT0lWUldCd3VyUGx5LzZueTdu?=
 =?utf-8?B?VHNaaExCU0VleVE3WGtIUkNrSHA2MzNrNWk5NnMzc1l3blowQ212SHpjVE1X?=
 =?utf-8?B?Q0FkNGZscGlSZXVaT3FPak1wSjZKWnYzNm03dkRjOHA5Yno4MGt6c3VQWGdI?=
 =?utf-8?B?dkg5bWhzKzVzdkkyMFRleGFEOHVoS2xCN2JlR2VNUEE2YWNvM1JsWXlHdEFG?=
 =?utf-8?B?UkRYdEltNnM2eE9VR0crYWJObkRIWHNhRjdCQXNGRUJZTGJmd0lWbU1XK3N3?=
 =?utf-8?B?M2NwSnd2dHlqWThSaGFGMUhkMnd6MlVvb1Y1czZ5UTZOOGk3dE50YjQxTmxa?=
 =?utf-8?B?SkFJNndicXhoUS8zeDNCVDRGdENMa2dGYkFqUGY1SUpaM2hRTk10S2djNjZy?=
 =?utf-8?B?ZkdJc3hxT0d3L0hWRHl6a0dtNjdhejNGRVNFMTE4aGFvZ3Q3OW1SOEJPaTRU?=
 =?utf-8?B?UlR3RE85N3U3Ump1Ui96dERLM2VBam9CNjBwS2pVWVZqMnpJYjdsWUFvVUxD?=
 =?utf-8?B?TFJaeURPb3ZMUTdUZU1YUnVBZGptT0tJdW1kdE9rTUJPajdEK2t0THVrRjJq?=
 =?utf-8?B?WDRrbVhZSW1ka2N1cUtDQWw4L2c5ak9pK1A1WFRwZVJRc2xYUVpqcU9aSDMz?=
 =?utf-8?B?K0Y3ZjVSK3V2ZjBNcXUxa2IxcFRpNVI0bVFNR1hYS0lTZWlmb0ttTkRPakFj?=
 =?utf-8?B?L0N5Uzl1ZVhDaEJPcHNrT3JFRm1nRmJFS1lPbmE4OEY5aXBuZFZQQzROY3M5?=
 =?utf-8?B?STAwSW5pT0NtZjRRamJwS2QzUjhCcHI5MnBmS0d0cUNnMi9kOFZlZ3F4akFN?=
 =?utf-8?B?OGpnMkFJKzdaWmxISkF5dXllTVFNWUtLU3doSUFCalU2bkpPZXRSMDVjbUFp?=
 =?utf-8?B?YkJkTWF0Q3EvNk9ma1JVQm5jdnluTkFCNGc5SFdLb2k5OEcwb2tYT01FaHZC?=
 =?utf-8?B?a0NyVVkwR3MycEw0YTNDdzhnTDhxaGJLR0wvSUQwUHY5bUROd2JubjgxU093?=
 =?utf-8?B?ODVaYnhEOVdhZjRjY3lqSDdQaUVsM1I1M1F2UjgwaGMzZ0NuU0l1VlBKeG02?=
 =?utf-8?B?TUF4QmJvTi9GQmxzOFFnVXdVbmpFU1lZOXY4Q0VCU1UxVXllZTNkT2FSeTQz?=
 =?utf-8?B?ZTBNa0Q5bFV6MEpyaFhRaEgzdzFlZ0VFNmd0WVpiUm82RFlQYXM5QTQrV1VS?=
 =?utf-8?B?SmRDVmc5dFNXbG1xOU9xdlJOYmF6M2tHVHlJdlFGUk1NeTBLM3JkLzhhRWZ4?=
 =?utf-8?B?Qm0xZUVIaUE1QXlLcFU3RGdqTjFuUjBGMmJoclFzSTBmOE9jNzFxQmpiMGxG?=
 =?utf-8?B?ZElTUUg1Z0ErK3MyWUkxUnJLcDl6N3N3aDMzR01SZjFkQnoyZ1dMdFdYaVVP?=
 =?utf-8?B?YXVJcWYvUlVWeG1kcXQwaXVrV3BhMlIvUlRvbXN2OThNKzB0SERGWXp0WWhS?=
 =?utf-8?Q?6SukEokheH7eSmtNehzvPrabUKcxEPaQlF0dc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZW8zVUppOWkrM0JvQXNvR0xFMG9NRkZZa29hT21oanRRMDJNenBuR1ptcCtD?=
 =?utf-8?B?TzcxeWhSZGFMeG54aCt4Z1Z3MWd4c1l3ckFSRS95cTRrK1RBYVB0UGRQaGdD?=
 =?utf-8?B?UlRCZHMyYXJnV3VuVmk2Z0NpN2I0MEtpa1Buak5QeVRnNEU5eURvM3dLYmV6?=
 =?utf-8?B?Q1VHVExkYmZEb1VEblJLSXlUVzBDMjJYQ25zUWNvaUlwTWRHOXd6WlFzazRk?=
 =?utf-8?B?VnJtTTJSRkpncGhWOHZjbDM3MHR6VWRkOTJPNkhIYkZ3QlJKeHVCdDJDUlV3?=
 =?utf-8?B?RVU2Y0M3Tjg1SzNnMmsvT3NodDFEakdBL2lOdkFiQXRzYjRnT1MrcnpjN1kr?=
 =?utf-8?B?bncxY3VEN0RHaFc0Vm11NnJpdWZ5djQzZnRuMHN6TTZpQ214YjJid3EzR0NQ?=
 =?utf-8?B?cXY4bjFlS2pVdVdLRURVcmFQNWcwRnk1bUJJTWtPcEFoTVNpZVBsQTZhQ01L?=
 =?utf-8?B?SjVWbC9iRDNDYW41dEFpMG9DTEFlOUJHK2t3M1hOd0NvWHYxMEhiWDd1WXls?=
 =?utf-8?B?NjNnWTUyRFd4QldsSjRERStOZHFmVDhScWo5a1Z4cTFzSm1ZZUh3L3krSFNj?=
 =?utf-8?B?RElETlBQUVRaNDFBanovcmsrTXJUUlBwSU5tZzBSYjZDOUVNSTlDUUh6SHJT?=
 =?utf-8?B?Ujd0ZUNnazQycERhZ1lHL1QvUmJWQWlpVGhaU1FUclNLbGlkVjFIQTQxZkpl?=
 =?utf-8?B?UEFQbU1wSkVwRHdNbmJGWk9qMUpsRFdYUE1zTld2K1hNZWdxMExpN0wzOXpK?=
 =?utf-8?B?QUtJb0FITkw1cmIwRklvVTdhN294Z1I0RnVWYTJOcVdZZmxWeGI3WldFUXFk?=
 =?utf-8?B?dmlTRFlvbUFZZFI4eGl4bHByclBCdkZ2Q0RabUR3dTR6clpHblBUWFFlb0Fl?=
 =?utf-8?B?SEhBK2YvTGkyTS9OVS9tVzA0MzJ4amlUMUlVR3lIclA5cWs4WlRhKzlPcGV4?=
 =?utf-8?B?U1NjbVVRc0tCWUdPcjlldVV3V09wNG9NT05EaTFmeEsxTGFMbjBkZjFpaU91?=
 =?utf-8?B?bjZXTjJSK3FWUCs1Ny8xcVR2N2NXeFlzUUdPUHNYZm0xcDVYZSt2MG9scUZ2?=
 =?utf-8?B?dDdYeEp1TXZjNVpoTk0zeVFtbmx2V09yNnoxMDZHeml5cDllNGlTTmFDalR6?=
 =?utf-8?B?SStBTEtia1VORVROTk43Y1pSSFhPM2ZJaDNNdUpOSUs2TmFZMVJDSGRIdmZB?=
 =?utf-8?B?OHlOTzZXZEFMMWs5TWJhb3ZwOUtDdHRIN3JxaXZYUmh6RHNDRGZWNU9LdGxF?=
 =?utf-8?B?U1B4dUpxL2EvdUEzWDVGY3FSM00vanZLNEczM2creTY5U1IvMFdaeGcwMERs?=
 =?utf-8?B?ZHZQRTVIblNGOHRhbjQ3VmVVNHZNa1FzY0dSVWs2dklWZTJIbFRZZ0RCbDh5?=
 =?utf-8?B?Wmw4QWxvSEZkM1ZuQ0xjeHNidmZEdXJ4VUdPYVIxN3U3NXNqai9pTUtkRTFr?=
 =?utf-8?B?bHZaZlVHSTRna3lRMWFxb3FIRUdIRFZZYWYvWU1qRUZnbGRTdlRwaUcwRFYz?=
 =?utf-8?B?Vno1RklBcmhPSDVOSDViVDJveXI3YWJxVlhCcFdGa1gwemhrK2Ryb1pYR1gy?=
 =?utf-8?B?dHNEa1F0Yzk2eVNSOFJFK3NqcnYycDliQlAzZ1N1a21YdWY1UjRJK1Rwc0xo?=
 =?utf-8?B?U21SMmh2VzJUOHY5NDdSWElCUVpCRFN0NG02cUlZR2VOZGpFN0NBMHNyTUF4?=
 =?utf-8?B?bDhWaTBsYjVzY2dVbGFNNjd0Y0NzWmFXc3dEZG53OWdTMlhjMVY1UW5IbWp6?=
 =?utf-8?B?TnJPdHM5U0lzTTh3ckRCNFlCZ0RDVE5wR2pGWDBwUnBZMG1VNUxtcWNjcVRn?=
 =?utf-8?B?NWlhUUxNOHdBR2Z2c016bGoxd0xrTmdERmxtY0RBNVhISFhUNm1WcTcwOFZy?=
 =?utf-8?B?MFBDamE2L1h3YVA0VnY5UU5lN2lFc3hyYjVKMkMrV3ZWQkhtS0JGdVJ5d2tU?=
 =?utf-8?B?Q1hZVXlNanAzcDlrTm9PSVhBaFE1WStHS29yNmgvMWduYnZUYWxKK1FsKzVZ?=
 =?utf-8?B?OXY0MzNWRDlMRGRwZlk4aGhMLzJtR0dOMFpDZytvM295V1I4eHBQcVVKUmlq?=
 =?utf-8?B?TVJXQjQwWTJwRWJFVFV0Z2QyMUtFK1ZEaGIvN1RJVStvSlNCakl2Y0pNVGxw?=
 =?utf-8?B?TkU3R1l5NUxScTRaWXBVTEtiTUp2VEFYOWNKV1gwRUpWMGdiMUcyMGNWeTRI?=
 =?utf-8?B?SkE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e110b21-7099-4809-57c6-08dca1d83c9b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 18:35:28.2807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JS5zr7wGl/ysgVSy/CiOlTb7Eh7xhql/9CYf3kYn11Kb7lF0YjuEZyCoAVA/yghpzJ6u/V34ovDSe41lB/5ijg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997

On 7/11/24 8:28 AM, Mina Almasry wrote:
> On Wed, Jul 10, 2024 at 5:44 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> On 7/9/24 5:17 PM, Mina Almasry wrote:
>> ...
>>> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
>>> index bc3925200637c..39420a6e86b7f 100644
>>> --- a/tools/testing/selftests/net/Makefile
>>> +++ b/tools/testing/selftests/net/Makefile
>>> @@ -95,6 +95,11 @@ TEST_PROGS += fq_band_pktlimit.sh
>>>    TEST_PROGS += vlan_hw_filter.sh
>>>    TEST_PROGS += bpf_offload.py
>>>
>>> +# YNL files, must be before "include ..lib.mk"
>>> +EXTRA_CLEAN += $(OUTPUT)/libynl.a
>>> +YNL_GEN_FILES := ncdevmem
>>> +TEST_GEN_FILES += $(YNL_GEN_FILES)
>>> +
>>>    TEST_FILES := settings
>>>    TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
>>>
>>> @@ -104,6 +109,10 @@ TEST_INCLUDES := forwarding/lib.sh
>>>
>>>    include ../lib.mk
>>>
>>> +# YNL build
>>> +YNL_GENS := netdev
>>> +include ynl.mk
>>
>> This seems to be missing a rule to generate ynl.mk, right?
>>
> 
> Hi John,
> 
> tools/testing/selftests/net/ynl.mk was merged as part of this patch a
> few days ago:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20240628003253.1694510-14-almasrymina@google.com/
> 
> Is it not working for you by any chance?
> 

Aha, I'm just not using the right tree, then. Thanks for clearing that up.

I was attempting this against mainline Linux, just for a quick look at the
selftests part, and that Doesn't Work. :)

thanks,
-- 
John Hubbard
NVIDIA


