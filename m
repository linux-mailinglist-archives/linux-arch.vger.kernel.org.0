Return-Path: <linux-arch+bounces-4797-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8269021B3
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 14:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ACEA283303
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 12:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DEA8060A;
	Mon, 10 Jun 2024 12:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q6tRJpwG"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AAA335A7;
	Mon, 10 Jun 2024 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023130; cv=fail; b=TId23wTXjBEcoCnOYOTEVuDIcMsVqTf0LWLsXyLX3dNuqSkLQ6jU1DqmtNukOUR41/SGcWG1WTBoYHt0gGXfi8AtgVN0jt16jTozo8S1b2oPcIMicRknMI6oQg+kHe1YBT0DD/9g0VQ5mdN2e+tWqmlSyttRyz0/Hv3tfItkOXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023130; c=relaxed/simple;
	bh=NUisiJXG8pP1r6Byw4rVQELf3cdmitV1fgSIUrSUBJg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F5cD0ukP7LqbwTgI5iJL/2NbN4OwKR63jQ9PVWWl4ZyZ/Z9QN4G352tRcC2XQ6fLGFWPIPCAC4ysI5zR2IHCRSzkLJOALcKfpxsWi3zQguZMvWVyBdKrlIeO2t4Zn+T+YGj5bqTKey28tAApJC8jV+H3XboIqdZdZvKw3Ja56ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q6tRJpwG; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoH6fhskN1iDVMCPaFkdXOfE9uIuqOQrZD5Jeg6s8mHMZp7zpdOHbQ46V4obCIY/VPAcimwhH4Ph+RB5y7oqRc4E3IpdODOyle21EQkfBI/B9IcEJ4kuSKabQ+SLEgHFFVcPPBBZVQnQRZIOLIzkNkFoJTdwr7C/Y4Fp41xx7uh7gpHHZtsIg5kv5ODqD1tebzmVfYZ/RMIIZHfxukKU+ffigbUyl5vVEda8ip+Ao4smvjQLslA7lppRF5rqwRvaJ5XnGyHe73l7kaI+b9GP7Wff+YBTdAaNbRICM0GHu17EuWfAV3s8KLOC62TYpvVt14XWUfVjzCOAaWHYRCPyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83pYtp4o7iWmYuJWpqxqZ79viZv7tjKzk2Oe3aZTmuY=;
 b=aVlQ+Px4mY4Y3YNkqax3DSKxIIaSfuNNCdyxHmGnYtV3khELaDAl9R+vcas0T5t34fGL9MUWs0uOaerJYUTyx8nb0Hw9ViWy1BvmeDcpcLI2DJr9p5EkhGIJFqRTpnPSA5wHDkHGkcemuY074cENbneIdHHgpqnLOi/II8/NG58Otvun503WXRqxsTrMAGo7oxMBpMzorW6NujaOfWhQsGbyJYmThlBE1QZUSVA9hBzC+KMD4NjbcCPiGpbyvX9Kdq7nKOVAUHkxIsdMERyD739mPdIKnalYAKjvbGQjNNt3vp6SiDffNL3+0EmWIgTeOMybTvBP/YEvhsGmoE6K3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83pYtp4o7iWmYuJWpqxqZ79viZv7tjKzk2Oe3aZTmuY=;
 b=Q6tRJpwGQq31e/m1zSeyZL7vthc0IL2T4a1fIw61wbWu0y+3Yhc6CbARkocZtL3+5mEELpW4hWMfQWfm/8wGQrxUMMOZVJe829FjrPGQuiuCE2uA+uqJekLzq/PVZ1viusaDyMuQOFiALXdJ5MJgS+gLfmBS3KJxshGT0Vh9a1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 12:38:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 12:38:43 +0000
Message-ID: <cdbc0d5f-bfbc-4f58-a6dd-c13b0bb5ff1c@amd.com>
Date: Mon, 10 Jun 2024 14:38:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
To: Jason Gunthorpe <jgg@ziepe.ca>, Pavel Begunkov <asml.silence@gmail.com>
Cc: David Wei <dw@davidwei.uk>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>, Christoph Hellwig
 <hch@infradead.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
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
References: <20240530201616.1316526-3-almasrymina@google.com>
 <ZlqzER_ufrhlB28v@infradead.org>
 <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
 <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
 <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
 <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com>
 <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
 <20240607145247.GG791043@ziepe.ca>
 <45803740-442c-4298-b47e-2d87ae5a6012@davidwei.uk>
 <54975459-7a5a-46ff-a9ae-dc16ceffbab4@gmail.com>
 <20240610121625.GI791043@ziepe.ca>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240610121625.GI791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbc91c4-f26e-4452-d52b-08dc894a438d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3FGVGNvOS9nUUpteFZzaEJzVnlDQWRrM0k2VEwyWmcxMzFxaGoveFNYSXRE?=
 =?utf-8?B?TVpDY1NhRCtJaDB4MWNVVHdmcU5mVkNKUzgxeWxyTXNzOHNvVkhTTngvbnlq?=
 =?utf-8?B?NGRxaHNhTjNaTzdyWnViOEYvckdPUzZ2S1hWVXlMWWd1bGZjNEFZc2YxSmp0?=
 =?utf-8?B?RlFmNzZkd1MrMzRQRktVdGJ2Sm1pWlZFblRVV0FhRmtOeVdONTNGWklQbkZj?=
 =?utf-8?B?N2pybUFuZnFDWVVNSklzRXcwSGZlU2g0ckZ0Wkkwb0hYNjVhdWlWdVJzMDdC?=
 =?utf-8?B?a1laWVovSnl4SWJCZENaUVkrYmRKbW9IaWNKSEFhRWtUNlBjMzFVV2o2UmVo?=
 =?utf-8?B?bktEMUR1OVd5SkxnOVJzTWF5NElBWWNNaWpxNUttbEhKRWFWM01Pb1VRRDBC?=
 =?utf-8?B?S2Z2UDB3dUpHdVFIOXZ1c0Zzb1lDa2FqaWhoazdhQ2hOV3NYeVVxbHNIeSta?=
 =?utf-8?B?UEZrZmI5cys0Y3d5azE4WHJSN1ZQajJGMXd3MW5ac1FQTFExUGlDdlZwN2lY?=
 =?utf-8?B?Y1Q0ZXpta1ZldTlLMHk2V3p2ZStaaU5EVmJHVHVrWE11UjNNWDNzSEhvZ0JZ?=
 =?utf-8?B?UlZiMFNYOVpFVWM0L2JJTXRVUVdKOElGU1JQOWxBVlJadmdLcldnTnE0YlZu?=
 =?utf-8?B?K1AzaWVseVZheElQWVRCeDRjTWl4L0l5ZmtyWnhUL0NYVFBJaUdkc3VjcjdR?=
 =?utf-8?B?d3hMSkJUOVdQS0VPN3VHT3Y1VDhaYWRXY0hWc2IxV0lRcVRxYlVDVTZuaTBx?=
 =?utf-8?B?WmZGUEZmWUdMM0t4WmZZMk9WRkVPMWRiY1lqQjk3dHU3VlMrRGR6ejg2emhp?=
 =?utf-8?B?a2JRT3laSUZCU3BjNFZubk9VMHhtSFNWWk9pNzlEMkY5S1F3bnZzRUZnclVP?=
 =?utf-8?B?Z0VtbG1BL1J6THoxY2NhWFgxa3pLVldXYTlsbHlxWG5xMlhDcnR5R24yYWxq?=
 =?utf-8?B?TUJaOVhPVkVqRzVELzFZVi93VFByTHUxVk91OFZrRkVkSysxaFFNWDB3WFU1?=
 =?utf-8?B?MnV1emNTRHdsNWp3YzBaS01jaWtqaThiSkNpSHY5REdObHVWNEtzVWYyUzZy?=
 =?utf-8?B?TWg2MTJSYS95Y3B2bStSNGpPVTBBOXZORjhMaHRVTmk5bkhjMC9YWTM2QmtK?=
 =?utf-8?B?dEhMeHNDT080OE1qYTM4WGtsYnBxSld0N3JoMVpwWUVyWmhCdy8wQW1kMnZ5?=
 =?utf-8?B?L0w3aktLYmFaWDVuUlU5UnhGOVVNWVF6QzExSDZxZGk2OW5zUmVxRTBCQlBV?=
 =?utf-8?B?eG1PaHBuWDFWY09OQ3pMaXRNZG1lRjU5WDIzYU52WkNrVWIrbHBwYlNicjAy?=
 =?utf-8?B?K1NiSEdXUXhEODI4ZEZqeVJtQUg2bEU0SmRBRHhKNVk5dkl2RnNmd2ZDZFE2?=
 =?utf-8?B?OWF6L1JMdTJXd3dDczkvL2NoSEZmMjdzZXFyQXA1dTRDOE16ZFJlNDNMMWlt?=
 =?utf-8?B?Ri9sQm8wbjBRNEFFT1JQTG5TYzlyTURwQ2RFWnhsNWxEdXZMUU1uZXJjaUcx?=
 =?utf-8?B?SVNXKzZZYkVidkV4K2h0ZHVpd2RvVWJMVEE0R0ZScTd4Qkh0cXhiWlpLRTJm?=
 =?utf-8?B?SGY0aHRhYW9tb0dOU3ZOdWpuUmVhYVA0ZXc0YytpYTVkS1JMYUhabWttckFp?=
 =?utf-8?B?NkNiaExrd1c0UTMxS3B2aUZhSlVib2ZzZGdqN0Q4eC9qTkRwRUdtRURWK0xX?=
 =?utf-8?B?eHpxZCtraTdKbFNVWm11QkwycVI3aGlxUHhxL2JRc0FZNW95OHQzWnR1T0Zs?=
 =?utf-8?Q?zTEGcvyo1MERfriR58=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHJOM2R0SGxvKyt2Vm5sS29oSElvaWM0a2NtSEl0L2IxQ0lSN05UVHo5WjNw?=
 =?utf-8?B?Z25xYXgzQjczTHBPbWt0TVYwYkFFdzA4R2JSZTVwME0xTFdWb2RNcERTU0RT?=
 =?utf-8?B?ZG1SZHAwdHdabG5OcUgrUmkrbGZZWkpHU2xvcWUwZzhtem5pamg3ZWE4UCt6?=
 =?utf-8?B?ZHNnYmszcEw0aG5sYVdTczE5SHVPdHZiYlRldFFHcEZIU1dESEhWL1cxaWlK?=
 =?utf-8?B?RURVajU1aFIyektuVmhKQXQ3aUpzUzVIZ1pjZ2NMOVo2UWRIVE93Y0pLb2hB?=
 =?utf-8?B?SUV2TGxtSElXZGlVN0EwK2NOcG1LY2t3RjRHNkUvd0M1RlNtUzNHVkQwNWtY?=
 =?utf-8?B?TmlmeU5GWXZ2QU9kb1BDZTRBanlYRythczluN0lqTktiYmZyTE9jRUVPczc0?=
 =?utf-8?B?Ym1lUGM1a1ZtaDM3K2x4Vmt5NTlSRkZtSDlaUVI5eW5JQm83MVJhenAreHl6?=
 =?utf-8?B?aFl4MnZHcE5LSGhsTFdnUThyVHJTL1ZoQXF0MllhYmVoVTZCb1g4bXV6RXFl?=
 =?utf-8?B?dzFpTWx1M3NObWFCclRYSHV0MzdSa2pzVm9IMTdkRVhwMVZlankzZ2VYYS8x?=
 =?utf-8?B?Wlh4OWxkc1RIUytVdjMzL3NMYkJGY1JYdEkrbDY5UFFkbndVeGk3OHo2Q3B2?=
 =?utf-8?B?dzZLdzdrd2Fidlc1WUVYTUxla3YralQ3SEJtYXhBcnBMV0oyNEE0b2c5YVgz?=
 =?utf-8?B?NVVleTFHMGtRMi9Bd2dHUysvaEswclYrbkcrTUVOTTM4eTZKWlk1MDIveksw?=
 =?utf-8?B?VkZuSEFoeHJzMHZXNDc5MmY1RmlXZTFIeU9hRjNTTERma3FnOUJKYWQ1MVh4?=
 =?utf-8?B?S1YydzM1UDVtQndOemdBUFdFL2o0eU9IazVyWEVUTkU1eU4rd2JWVS9Sbk93?=
 =?utf-8?B?b3E2bFJxS00rQTNGSExsU2s2NHBSSjgwN2lxdTEvUEJvTEplWjdKcHNvQmZj?=
 =?utf-8?B?UzU1UXZYWVVkdzdZemxQaHBLK01hajVqeDdiSEZTQTQ5ZVBuay9QNkdva2Zv?=
 =?utf-8?B?dWt5NTVDY01BSGEvNkN3WUlmZlpHb084dGVwV2k2enNwcUV3QXc5RjIwbG03?=
 =?utf-8?B?c3puSy9RR3YyZGhPN0J2bVlycldHQ3Q5VTYwNEE1K25ybjRkR2NyVDZ4U0Q1?=
 =?utf-8?B?cTJ4YWlXUHdKOW9iTVEveEltWGpjcytHNUxjMkx2ZnZmWkcrVlF1RGVUSmpk?=
 =?utf-8?B?N2ZDOHpZOHJNdm1JdDJSZ010akg0SUNSR2VremQ2TzloY0l0dy80VFVyUFFo?=
 =?utf-8?B?T3VlQ0o2V3EzTVpkR2JNWXZTQWJTZGdJeHUwRUJKNmRWcHBEODZHaDBCZ21V?=
 =?utf-8?B?eFhyY2NBbGhIRWhkNHZOWmltdXVzUmlvbEVrSXp5L2hlQ1Zpd2FvVEFMRlhG?=
 =?utf-8?B?OE9pc3VQK1Jqb0ZPbmNwQitkOGRkMUdNZlE3b3dmSWJ2YkFZMnNGWFh3UWxB?=
 =?utf-8?B?UDJVUXlnMFpaRVAwNEhna2RxalhoMHZBSVpMSlNqdW1iV2JpRXE4RFFYcmVa?=
 =?utf-8?B?REp2eGRtTXVTLzZnSm5jRHp0WVA3UGRHWVlFTmptamFubjVwWnhmZU9VN1Aw?=
 =?utf-8?B?SjZNOG9CMFFqUlNCbWk0OG5GcVltSVYzMTdMa3pkVHJ6WUgxZW5SVXRRR0hs?=
 =?utf-8?B?VnkyeW13SllKa3pqM3NjSHhKWjlnbUdUZW4wdGltTm1DN2dud2dZZXRyZ3Bw?=
 =?utf-8?B?TXRaT0dqK0hvRXFTR1QvTGdPWDZPY25lRlVsR2JSdVlTVVl6eUtNaUpZbmV3?=
 =?utf-8?B?Q01tQ2E1eXNsU0VJalk4UTcwUDcwR0lBSzhEQ2FENTJ4bDJOUVJNb0FMWEI0?=
 =?utf-8?B?MUZoTU0zK01VQlc4VnRzUXIxL3pjYmN3MTAwOHFsM3ZmN1hRZGMzNDlZOEJZ?=
 =?utf-8?B?MGxRS2t6NnlaVEp6Kzk3bHJnajZnMWVzSFN3UmsxVStGdW1Gb3dnb2xiN1RZ?=
 =?utf-8?B?dWFVN0w5WWxNM0lZaHUzVWtCa1V1VWMvSURFVVZ2bW5udXhCblM3RnQ3dTQr?=
 =?utf-8?B?bDBXUGZWYk9HY2xIQTY1MkIwb2hmeTFXbk9EWE1EOTJPMGdxOWRTaHZaMjQ5?=
 =?utf-8?B?SkdvRnlNUUJkZWRKa1JPM1REbGVYcXJwSTlSR09mTkQ3c1l6YnRxNGtBamNx?=
 =?utf-8?Q?uaAE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbc91c4-f26e-4452-d52b-08dc894a438d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 12:38:43.6579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzw4QCvv66Zuhl5K+3EVBz6jTNuMy2yFyxAzCgrtEAhFbVKVvp7mG3/KuvQSqFAM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175

Am 10.06.24 um 14:16 schrieb Jason Gunthorpe:
> On Mon, Jun 10, 2024 at 02:07:01AM +0100, Pavel Begunkov wrote:
>> On 6/10/24 01:37, David Wei wrote:
>>> On 2024-06-07 17:52, Jason Gunthorpe wrote:
>>>> IMHO it seems to compose poorly if you can only use the io_uring
>>>> lifecycle model with io_uring registered memory, and not with DMABUF
>>>> memory registered through Mina's mechanism.
>>> By this, do you mean io_uring must be exclusively used to use this
>>> feature?
>>>
>>> And you'd rather see the two decoupled, so userspace can register w/ say
>>> dmabuf then pass it to io_uring?
>> Personally, I have no clue what Jason means. You can just as
>> well say that it's poorly composable that write(2) to a disk
>> cannot post a completion into a XDP ring, or a netlink socket,
>> or io_uring's main completion queue, or name any other API.
> There is no reason you shouldn't be able to use your fast io_uring
> completion and lifecycle flow with DMABUF backed memory. Those are not
> widly different things and there is good reason they should work
> together.

Well there is the fundamental problem that you can't use io_uring to 
implement the semantics necessary for a dma_fence.

That's why we had to reject the io_uring work on DMA-buf sharing from 
Google a few years ago.

But this only affects the dma_fence synchronization part of DMA-buf, but 
*not* the general buffer sharing.

Regards,
Christian.

>
> Pretending they are totally different just because two different
> people wrote them is a very siloed view.
>
>> The devmem TCP callback can implement it in a way feasible to
>> the project, but it cannot directly post events to an unrelated
>> API like io_uring. And devmem attaches buffers to a socket,
>> for which a ring for returning buffers might even be a nuisance.
> If you can't compose your io_uring completion mechanism with a DMABUF
> provided backing store then I think it needs more work.
>
> Jason


