Return-Path: <linux-arch+bounces-4823-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA9F9035EB
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 10:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15973B27C64
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 08:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59A8174EC1;
	Tue, 11 Jun 2024 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NJ6Wa7Kd"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6793F8C7;
	Tue, 11 Jun 2024 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094130; cv=fail; b=jz4vwCkDYtcVx0E2JaTA42PXt+r7JVj79V1fPDlBZ0xhkMlb1XLDiDxuoME14AOHsnVX2ZCcc4OHQR9DU7eIG9Pwl7ylgrEtxS7IDcd0YvYR5tWL6zIILAgv1uHeSzqJy6PJPmy3sOUsqC7FjH0DpfI7rNSngImZ2dUWVWRaTCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094130; c=relaxed/simple;
	bh=gy60NaaVG1/0qGqt0kd/IceD54v/F6zCNeM0ZNP6wCE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jWODaxFfI+FDaajUeAu1zMktZzqyfSI7s8tC4g+eSDBy0XlycQmHfJkOMco+8SSYH2iXK/5KeTBIsIY2oy7Iu3TjxNV3zRUmGGOLtoVfeYsvvF9I+5AF7/Uulbs6oBN1JYAe8kc+EL8rzCSTeoC8+1bzw2dr0I4hOqp9S7SRFxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NJ6Wa7Kd; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkONW8mDSCESugbLhj2+gNV2Sln4Lx/OADVDJdGVMcYptqhw24jYN0tm3zPZkU4s+5CGwUSXNbE1VxGSpna5wdSXOHpQIVlju3HdW9u0EAB3IUCkUTqoKocWRqRgoh+jC4EMbG3upSILltfr5/lBhN/fSXEeVvWGGmlXijpv0vmirhCS58rzDPGzcZ9SeMogEH8sDcLaX6mmQoDVMkX4hQ1hvTgb+tsiD82AISWuh3362q3bZpoc0H7bjwiGxIDU03S+sxMaQrWlJJfJAomTeJq2UgEeMixcVtTli80sumeti/aWWfAai/g4gRXR2rfvIr+ehyqXeIfn809KcjkalA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvFHmIGW1KpXlyOSazoiV2vM5iNV5SniU/nP/6yBx74=;
 b=KJykgneE3BrZvbqd/pB3OUlkTnYigLSBZSPD5IYYzOjPtULFyf1bliM+H10nA8BZc4VaINhF8XcpREET3diUSzWG09yLlmf/JQaeXpwZSgS4+NhUXic6OYBORY18nwr4gKtye/CLjS/GZcE+/MWPxelydpe1OxRnHBzbRJGDz2tNRNjVlhrr+D7vrQsCnhCcdKrT2z0C7NXqzGc/8usbWqcfqYuR5H8SVo7B3xHFg5CVAEHB8KWhwPA1jbqo49j/T9nANsA6ybPIp3HBXUH7YT4Db3jkN6MslbfqeGTdssvjGCnpRrtWaaO1svPR3LLvIc19eXf3QHGPMzzJsFlYbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvFHmIGW1KpXlyOSazoiV2vM5iNV5SniU/nP/6yBx74=;
 b=NJ6Wa7KdutnYA7jo2yJYI+j6mYWg0Bocqcdq8wT4PzIqz9Ns/V67Vmq3bxR5NITw9iYDQaumC8xFcApgINc9N2V/5SN+F86WHeaFMm14qzbu0Yk0JGqZ/1tMAZhQZXr+pdtX3+/CsZr6AWhJw9s7l8Dlb3DWsxVDetWgoPECXZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 08:22:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 08:22:05 +0000
Message-ID: <924d9411-ce3d-4cf3-889c-379927167d60@amd.com>
Date: Tue, 11 Jun 2024 10:21:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
To: Christoph Hellwig <hch@infradead.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Pavel Begunkov <asml.silence@gmail.com>,
 David Wei <dw@davidwei.uk>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
 <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
 <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
 <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com>
 <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
 <20240607145247.GG791043@ziepe.ca>
 <45803740-442c-4298-b47e-2d87ae5a6012@davidwei.uk>
 <54975459-7a5a-46ff-a9ae-dc16ceffbab4@gmail.com>
 <20240610121625.GI791043@ziepe.ca>
 <cdbc0d5f-bfbc-4f58-a6dd-c13b0bb5ff1c@amd.com>
 <ZmftwZDXYk53fKzm@infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ZmftwZDXYk53fKzm@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 5070c975-b29e-40e0-bb7a-08dc89ef93d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm9oWnQ2TkZDLzZvTFh6aDRhTnZzT3VpS1lqM2szNGdCQUR3SVBocUU2NVRJ?=
 =?utf-8?B?MzBTNlBONGx1cDlESFNOeFo4SDVPYkZoYjdlZitzUW9zdy82OWk0cE1UUXor?=
 =?utf-8?B?K2VQSTdZbno0ZXk0WVdKTjlBZ2F6MVh6MW52UzNkZUdtbjJkRmdXQndUaE9n?=
 =?utf-8?B?MzlTa0hqNnVEVSt5WjgvZFBiMkl3T1l0YWM3UTM5dVJjQ2NLUFFaMEpaaXdv?=
 =?utf-8?B?b0N1TVIzMUtRZXIyMU40bjUzL2lxckY1bGNuL0NjZUplUzJHVmVUVG0xanlO?=
 =?utf-8?B?eW0vaXlPQnhFNGs0c2ZOZHNwNnpDZTRVYjZ1SXJCRUNoOUF4QkxjOVpmN05a?=
 =?utf-8?B?VjM1bkVwM2REdVRiam1DRkp3Z0dYc1JhWjhnKzFzblRpTE8zZmVtNUNkTDVm?=
 =?utf-8?B?MEYvSlRnZ0JCVk41SEN4V3NwZFpKam5ZZEFHcVVuQW92ckRhUS9BZFJ3NFhp?=
 =?utf-8?B?TWhFWithS25tRWpSb3FpQ0VubTM3YVo1TlNrUnpWYXZZZFpHQkRZcml0OEFT?=
 =?utf-8?B?MzVJV3ludWlJTEQvOHRaVVpINGhDYUx1clVTdmcrQnh3NVlGV2dYK1cybVJa?=
 =?utf-8?B?YVFITDVodVVlcU9OZWNJNHVaTjViNTUzVmJoSjVIZTBBazZqbWQ5YTcyM0dU?=
 =?utf-8?B?V0lEU2NnNENJYW5vKzRhMGNqaE9QUU5pS002aHZsTy9EOTFvUmkrRWhGUlFH?=
 =?utf-8?B?Vmlnb0d2OHplOEtHandHZDY0NHJtL2FvMHdpNFg5bHlzR1lBUUJ6b0t5K2pp?=
 =?utf-8?B?RGRSRzlnQ0hDT3JvaW9HbE05Qi9hMTNJbG80R2NVOXpaWndjc1BCMnFuM3ZX?=
 =?utf-8?B?TkNJN09XaUlqcW91QmhOS0lEZUJQTWJkTngwbFJiandNZEJyTWRHYkgydGNV?=
 =?utf-8?B?MUxjS1JSU3ZXaXdNZ3F4OGdVcTFGUGNOM2RVTnY5OTAxUFZMVGVTbjY0VENX?=
 =?utf-8?B?VkVlSXJEWGlhSXdGRGk5K0VaRGszWFNxRkdicGRZVmhNT3RzWG5PcTdYQm9X?=
 =?utf-8?B?ZXRBam05b2RlUEtWZUt0RzJPazZ3YmNHMjV2NlM5QVJkdVk2WUlDS0tiL2lP?=
 =?utf-8?B?RFZ1dzBVSXgrMjFqbllmWHJWVFJRN01ISFllKzJ4Mjlxd1BtTHFUUkNrQnlv?=
 =?utf-8?B?dlh1OStoZ2NqT2k2TjRjaU9jc3pmTThHVjZmaUo0K3FJdU82emRPUTkzRmRl?=
 =?utf-8?B?RW9vS2kyY2xvOGd5TVlnVVNINWtqUGJpU2xpcmkxanRaTjFrT0VRN1VNb00z?=
 =?utf-8?B?ZjZWTHlQb3ZldVNMUU1KdHhCN3dyTE9oUHFGL1hDMmVoYStTRHpQRUZlNGZJ?=
 =?utf-8?B?ZFJERkQrNlVNejJnWE4wWGJVamVXNkV3cSs0RzdiVDljL2xUMEcxMDNTMUJW?=
 =?utf-8?B?Y3dqS1ZWcTVsbkJyMmJZQWx0Q29yME50WnAwdUlJSFZKSmFmSW81RTRKSzYz?=
 =?utf-8?B?T3lMZDNLRnJOaHZkQWtNdmRadHl5aVJhU3RCMzV2cCszWEtrb1lFS3JvK0VY?=
 =?utf-8?B?elZtZkVISVprZGUvdE1YQlpCd3dxZTYyby80Q1p2SWhVQzdhamEyVkdZSXVJ?=
 =?utf-8?B?UUdtNUZ6TitBdVdqOHFJQ3prVWtiWldxdk0yQTZ3a1JXNGFNN1VEcXkzR213?=
 =?utf-8?B?ZGlzTVlFZ1RBeXQxVThDNmRFazFRTm42M0VLRUI5Mkw2UHNvbXNxYVNYRUN6?=
 =?utf-8?Q?D2rP6ClXFdVU9Sqx1HBj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmwwcWNvanZyV0ZFQUhHYzNOMXAzYWFwcTBwN1lHclNDVjRVeVNqRDJwOVdJ?=
 =?utf-8?B?aE55MTBGckdwVk54UzQvbXlhV1lkbHdPbVJaM1NQSnVrdDlwNlN3TSt4dStX?=
 =?utf-8?B?eUlKMXhhR3c2TDMzdk16czlnZGRmRytKOHh2Yk9qa3VZS0pHRlRsdkRRWVV4?=
 =?utf-8?B?VU8yME9jcjlrYk00SURrVVNmWUV5bjJQdzloNE5tZ0hsYzFZUDRFanhxYXo5?=
 =?utf-8?B?THFRSm9VRTJzbmhzUmNmSElhTFlxUWhxaXRENE9lZUhDd3JNZnE2cU9KcFJO?=
 =?utf-8?B?dHlqVkR5bGlwKysyM1hHMnFYNUQxWmNzQlkvSlM3bHRVUkI4cEpsdUVFZHRH?=
 =?utf-8?B?VTk1T0FaUzlEd2pNR3k3VlV6SS9JZkxIZE41Ukw4TFpJaEdmNnRtV3IzRVY5?=
 =?utf-8?B?dFZNSkN5ZkRBaXNDUGJOR3NXNDNvNEYwQmxkRXlWdXhBWWNMb3F6TkJVcG1z?=
 =?utf-8?B?SmVuMVNud1FJM2x6UkpmeFJySUtDOTl1d3VRRHpQNnIyZ2x5ODc1bVYyV2ty?=
 =?utf-8?B?dWJhYTFsdzFhV0JWSU9CSWlwYWZZOWJLOWJJOUVmd09wVzc4WjRPZW15U1li?=
 =?utf-8?B?by9QbmFsNHJ1Z3lrTEdqaUYzT1dKQThNZ0p4LzdvaGVIOEpUeStqYWNibW1i?=
 =?utf-8?B?OHhoWGQzcWM3cmpjaEVvQzdmRnZnN3JTZmltZXErMFV0Z2xvUURIUW01cWg0?=
 =?utf-8?B?eW5Ka0VwclAvNlg2bDVtMVJZbjBZeDR5KzhJbVJ4K1pCKzU4WnR0NXZkNU5l?=
 =?utf-8?B?QUZVTGV0VnY4Wis3NUViSlpWUUJMUW9XWGM3S205NXNrQjNHZ25EYXJxOE9s?=
 =?utf-8?B?QVlGQVRENHJZdGp0QXVsMHRTYnJMWWJrMGJMaDBDbjNRRk5HOUMvUHI5a0xN?=
 =?utf-8?B?aUMvb3BiT0x2N0VSZk5xSFppdzFhM00zY1FOTHQ4TjdyRk82NmdHUlU4anNp?=
 =?utf-8?B?YkhkTmlaenRZWFFsQlNoeG4vSlByaTNKcXFlL05idndzMjVnRUFISWNSNDE1?=
 =?utf-8?B?YVFzMFF2ait4S0tNZkd3S3RPZWlmZWlHeDREZCtKMURkbVF0eUhyK2JQSmFj?=
 =?utf-8?B?OWZnOUQzaEVlSkpJaU40QzIwMWJTYmJwNXd4bGNjRDZ5U1JqVzV3Ym41d0FG?=
 =?utf-8?B?eXBTdk4yZkEwcUU5SmlPUExYZCt1Ry9pSjhNT29nWGMvWnZDUUcwTVY2SWJs?=
 =?utf-8?B?Z0p5MVp2QWRmQ1ZWQTRlQ3pWS010T1JxTXhieUtsdjVLQXBVZjlYUktPdVl3?=
 =?utf-8?B?MjJYRStiWi93ME9vM2toNlJ2RHFhY09xUkNMMkVCOHBRMWd0S0VKOEJTbmo1?=
 =?utf-8?B?cnhmVzZNNFlaYXEwYkdscE0wdVdzSkNkZ2tKaWhlMHpYam9zYTRXVlFoVTl1?=
 =?utf-8?B?elI4Lzg4ZjlJUmpCQUxldXhFK1NmV21zZlJCT2k0a1JqYWhKWkg4L2plb1JR?=
 =?utf-8?B?L1B3SDJHSVdtVmxHUUg3SXNoVUgydld6V1pUaHFIM2huajEzbis0Zyt3NFF1?=
 =?utf-8?B?UGdqc2ZHWmVmM2wxazllTk45d2l1RW1MWERSaU9qK05WejJWQXJvYUFuY3By?=
 =?utf-8?B?aFAyZnVrdmRBWUl4TEFTT0dVZ085dmdhakxHWVB6N2Jid3hlTFZmSytiUVhv?=
 =?utf-8?B?bWUyUDdDcjByZEtoMWNKZGNIVitIVk4zMW40emFuZlgxN0Nob0ljcm5tWjhl?=
 =?utf-8?B?QUkxck40M1JESU9Sd05mbzRwaldUSm9sREhZR2dWbWVUSUJncGU2ZEVGYUtL?=
 =?utf-8?B?WVlJeUlrL1k5WGl3dmFFUFcvSUFLWlJkL0t6YVVVSUZrcVFtZmFOQkRaenFK?=
 =?utf-8?B?WTVpSzhZd2RLazlXZ1hyL3JmQ1c0NHpsaUw1enVydVM4Q1FjaVVIeUF0NGdY?=
 =?utf-8?B?WUZOTUd0bHVyNUNnakdrMUkxcVk3QURHRHZlVUpiK04wRjdNdjY3RElXL3Vq?=
 =?utf-8?B?dk9NRTE4MXd3WjE3UkJhRlYxRStHV0U0SFhtaGl1V1RvVnU0VWtFVUtaWExX?=
 =?utf-8?B?cXczRWtodWd1amhoMFNGWG14LzFpdTRmK0dMU2MwVzlPQXY0TFk4QVRzbUR4?=
 =?utf-8?B?VHQwTGFLQ0NGWldiRmsraXJvUWR0MEJMcVB5U05IOFk0ZktMaHhtRXV1QWFs?=
 =?utf-8?Q?gpSXD7G//KHyYgOpKNKZD+Mh2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5070c975-b29e-40e0-bb7a-08dc89ef93d3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 08:22:05.1595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZqB4iJCWRBGUb7teav5N98KhXkwIHhZLaGCODkFbyTo//w+n8KBXDDHbXawcwXH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701

Am 11.06.24 um 08:25 schrieb Christoph Hellwig:
> On Mon, Jun 10, 2024 at 02:38:18PM +0200, Christian König wrote:
>> Well there is the fundamental problem that you can't use io_uring to
>> implement the semantics necessary for a dma_fence.
> What is the exact problem there?

It's an intentional design decision that dma_fences can be waited on 
with quite a bunch of locks held. Including the DMA-buf reservation 
lock, mmap lock, anything page fault related, shrinker etc...

When you give userspace control over the signaling of a dma_fence then 
that has the same effect as returning to userspace with those locks held 
- you can basically trivially deadlock the system.

I think nearly a dozen implementations fell into that trap: 
https://www.kernel.org/doc/html/v5.9/driver-api/dma-buf.html#indefinite-dma-fences

It's well understood and documented by now why this approach doesn't 
work. So not much of an issue any more, we just have to reject 
implementations from time to time which try doing the same thing again.

Regards,
Christian.

