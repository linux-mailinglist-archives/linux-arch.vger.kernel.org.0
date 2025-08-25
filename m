Return-Path: <linux-arch+bounces-13263-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1350B34543
	for <lists+linux-arch@lfdr.de>; Mon, 25 Aug 2025 17:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C88F1A83E28
	for <lists+linux-arch@lfdr.de>; Mon, 25 Aug 2025 15:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B361F4E57;
	Mon, 25 Aug 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="O5gfEw85"
X-Original-To: linux-arch@vger.kernel.org
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2132.outbound.protection.outlook.com [40.107.115.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E594230BD9;
	Mon, 25 Aug 2025 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134617; cv=fail; b=tZkp95fSMYuy9pTn+wQD+tTX2GD4qPyuDQ81aSD/dzXqF17gola94558zk8Kpv/RoVYjMZAvVRghaU2vE7+cFLadVH3i4nVCVEXYpvotvSsOMlWwBS+dKioUe1SmEduqrvzWNQZEOWWERy5qCD68x3zNK8X9V+Wn2hRw4Rpjs+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134617; c=relaxed/simple;
	bh=ol7ns7upJzW31Jj3/M+prTvFFwNlhX56wf9oIEXEtyU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pTZGqVrFPRtANJVvPH/NJOM5McFwI3o2Ir00jqNKcFA7W1Qep2o0IiRJOp7X0IGdOKKph4sPIOjD3iTbXfS7ypr0jmIwqiP4ihu5J5ny9CAhLANCLBbhzEVRSCFWDbRPZPjvwdCZykQvycmOHsUqwt7PXCxDwYVypxfS7ilsVAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=O5gfEw85; arc=fail smtp.client-ip=40.107.115.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rB9sbzLwqcr0ll3/qRnPgpqm8eXPCEJch7C+kkj/Rio8Tsj6+9P7aJZaUNvNvfCQyRYUx9OcvGycMPbMIBw9U3VAJUu1U7bfa3kYCsHrU8pVq8FMwbbnuuXfp9NAv1Lcd4G/BXLAGQjUZ3OsT5DsgXvZI5hOfcjtwpZ6PVfVBIkLLWsaZvOu0p6B6HKEpj8cBRSPvgKklkJYrX7feEgiozTZhd5S3wDVVgyj6ovbtfQbKMETvRkkLrILtYKFqCUJMc5deRA5giX6ryPiZp+uhr4ybBjSd4TuQsXzCz3eaZwjdg8gn8KZfx8CWZ0xXl2hzy8PFrc6JVnmuNEFi03vTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e818OtUbcO1ENstCBv2TtLcxNPp6xq78ayC+1/2U2ho=;
 b=uWjXjne8PjOHRjpBv89Utv5wDDWZV2ZHkxJvgnSru4TvuVNNa2f6ZEy4Z4zqEecxxPR2n3PGI0uDawXQe0BCza4eyjtgRCGRckZo/9DOmJEwHEByFoIe3eH+ul92Jg/CkQDUtmWXv+P0IB0puOV4+jcWzCjIKNwaLqDKotT/OdjHSnRyVqo8E++WD/+lVAm/FRnR+fowXPjOApua2J3x6oK0WJQ9RuqWW5W4eFSyH+bLix+eYMSRATtLW3ol40OiYhhWnW6+C1NT8UYuyO4eZ/p/eJt7tLynERMQ6TG6x9vFwOvxDcvCpFwnl/Ou5mUWM+2uTY3Vo5WDcGTFFdy1Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e818OtUbcO1ENstCBv2TtLcxNPp6xq78ayC+1/2U2ho=;
 b=O5gfEw85hXPtiXtNpXhkbsOMeRxxGGIN4FwMnU72PQtxJ6WmFvVdPRgR2jzqjfWRoZZbtsJejFq3lZCGNrCfjvatA2JILLXGNpa7nC9naq5SebcrujLxS3tCknvR9aUiVOafEXAUFBT7vAxxiErL3ixLiOg2rsmuObGqXIn1SE/+ymhZ256keELu4IBQS8MldUjoCdGgRdH2G3E+orfsJXDnhB9ZDmLrAxdwzWg81rdNNvZqQuNrGnWuznyljFKsVp1A+TNP2Y8n/ldcv8qUGQvEMKv/FdjAvBM7Twth7hl7sNkp2QivekfgMyaXT9hLwfpDCwyxwFTpwy/5zWjMqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5959.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:36::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Mon, 25 Aug
 2025 15:10:05 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 15:10:05 +0000
Message-ID: <51040f12-4f56-465f-b021-2563002307fb@efficios.com>
Date: Mon, 25 Aug 2025 11:10:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 00/37] rseq: Optimize exit to user space
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-arch@vger.kernel.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Michael Ellerman <mpe@ellerman.id.au>, Jonas Bonn <jonas@southpole.se>,
 Florian Weimer <fweimer@redhat.com>
References: <20250823161326.635281786@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161326.635281786@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::27) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e18dc0-267c-4437-03be-08dde3e978f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mm9aT0RzeTdDeFdEL1dVdWtGS04zeDhhSjY5MG9naU9HYlJEQjRXVGdFNlBy?=
 =?utf-8?B?c2FUck95dEtPdnY1TGk4OS96M0w5bnZ1b08wRVNNYXRHT2pVV1o0VnhQa0E2?=
 =?utf-8?B?aEZTQXpHUTRqZzN4QnNwY2VEWER2ejdtUEpReUU4ZXBFUHBuRzFDNUh2cFVq?=
 =?utf-8?B?SjdRTmkwWW1oYzNrclVSS01pQkF1UEorVXJzYWV1MTVEeldvb3FJb2h3TWRB?=
 =?utf-8?B?SHR6ZHRwTEFFMmVwdGQ0VFN0V2JHbnBYUjlmaFpxT3QvQ0crSmZnNGp1UjFq?=
 =?utf-8?B?NCtwWGFlTlI1NWVIYWdZcDBBa0N3a3JjNDVQNU55S3hxbDdjZ29KSEFVZjFL?=
 =?utf-8?B?aVVFUnY3T1lUTThKNXo5Tkp6eFlVMkgwM09KQXY4Y1QyTU1sb1V0TDFpMDZQ?=
 =?utf-8?B?WE9CTWFiYk9VQ1dydC9KUGEyQUNPSUVXTHdLOFV2a3NFTXh3WTFOcEpPZGZ3?=
 =?utf-8?B?S0l0ZFBZczlmU1lTRE1UeVR3TW9ZZjA1N0lBb3Q5ZnNzZDBnQThSVk16Tlhp?=
 =?utf-8?B?cDMySWFkYUxQVFhKZ3A5bmpNTkdZMnczRjNaT3NUQmtiUldmTklhNVdEa01Z?=
 =?utf-8?B?bEtmRUl2UktpU3IxQ2VTVXBsNWRvUzA3WWFqbXZ2Z2ZWcUFWSHBwcjZTaXQ3?=
 =?utf-8?B?SVBGeGg2aThBTkQ1bkt2R21BamlaYU5YU2xPaFBBZWtxNEdlS1pwWUFKcDhU?=
 =?utf-8?B?YklpdkVuSzFTRU5QaWIvRk13TDRGNlRFZDlvZWFlNnpiNmVZcUc5a0lwblJJ?=
 =?utf-8?B?Q0puRGc0ZzRjKzhWMlBrejFmWGd6U25QQktLQmZ6c2pVaWlVajhNQW10UVBy?=
 =?utf-8?B?d1VMem1wYzlHUWtwSERyZlJMT1kvSzlwMDNtY2QzejZiUmU2QWsvZmU4bDJC?=
 =?utf-8?B?Vnl1cFNWakF1MlN5aW1TZ3RyenF1NUxpOXhRWGVUWnBmNjFNQ1NKaUR5VXpY?=
 =?utf-8?B?TWZEVURmUGVpRGpNcFBuOFkvaXJoZndGUHJJWVM5WkFOTXo2VDZ1cGJReTRx?=
 =?utf-8?B?ZlNrV09Lc3E3aEc2OWJIRVdrRnc4NTR2elBWV2diL0dWMFhuVUtUVkQxSWhC?=
 =?utf-8?B?NklCeGJtVzIyYXZSVDN2SW1hbmxXMGE4bXA0QlVzWEt2bWV6OXZJMGZ5U21R?=
 =?utf-8?B?K3VxazdDUFo5dzdmRnpocGRwTW9reE9KR2dCM0FTNEJVRXl0T2ZiUkppMFd5?=
 =?utf-8?B?bUt6YmpJdHBiVElvMnpqWXRBU256dmxaL291YzZqWGFNbW90VG9RTjVCdjB3?=
 =?utf-8?B?OXZOcndTTzdxTU91SzBiRy9nSjQyYnJCbUhlTFNSdHJlRlZuM1BweEhqdGtu?=
 =?utf-8?B?dVZFSmRydktjN0FGb2dwbm9iYlJpSXk3cDlxSWhoTmpyZXZNQk5ZM0UwaHZZ?=
 =?utf-8?B?R3F6QUczMVB1ejIzMnFBekI1ZjdlRm5ORVdSM2hsd0R4dTBRL2FBbFFRNFp6?=
 =?utf-8?B?R2JSS1A4SEVNVWk1STBzZWQ2cjJSQmRtNUNXYTFIdjU5NFZzcGhna283T1Nn?=
 =?utf-8?B?TDdnTW5IWHZGK1FGNVhtVjNYcWMyUTBkeEY2cWFRRFlxcExHajc2N2lrdUtY?=
 =?utf-8?B?SmV4OFNQeDl0VUZXWDlFVC96Y2JKZjg5OWpiTzJhN3NOZDFmdk5hbXZXNSt0?=
 =?utf-8?B?Y3ZsbHVQSXNFc3FZUFovb0VXZ2ovUDhQemhacVE2ZHh5VTJITDNJajFnUUFI?=
 =?utf-8?B?VTVhUTM4eTJza1I1T01ickxVZkVwOThDV2FqWU5CeWNPOStXVER2UGs2Zzd6?=
 =?utf-8?B?SEtocUVjUGh3R1BQZCtNSHhZc1FxN2FYdG9vRlhFZ0pFbHRjNmN4Y1c5OGxH?=
 =?utf-8?Q?5Fr46PAfrFR5e0O3uE3gV449CC/01j54PIa6I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R25LWjdFMXNUb3RqcTBTSGI0S3JvMk41QjYyc2V3NjZFS0I1U0JkRDRaMmxj?=
 =?utf-8?B?bU8rZThFcDZleGxpNDk0bGNoS2JvUlA4d0RGeGFOQVFhbHNWcGgwZ3Bvc1VJ?=
 =?utf-8?B?MUJhQ252citmYUptTkJPbmVqcTk0L1V2bEVLVDhJTVN6NUFOaVB5ck1RcHQz?=
 =?utf-8?B?TjVoSWt4a2paRCtZdTlaU2N6TEZEZWl6STNYK1NpRGdSdHdVYjFDU2NLMThy?=
 =?utf-8?B?VGtEYTIzVlQrN2pYNWZVYlZsUW5aSjM0U05sd3NFK1VTeVhKTkRwcVpqblpK?=
 =?utf-8?B?eXdJU013dC9MNjA1ZnlJSERQU0pDZnhDT1B4MmlLRkxRUXF1SnV0OW1VVGxx?=
 =?utf-8?B?YURBMld6c0hXZE9QTy96S3V5bGs2NUlkakdCSmhtaFNwalZ1WmlscWNjcEZ5?=
 =?utf-8?B?TXo4dTJKRDhKcDYwR3NTaHh1NDZBNjFsWGtCMHpSMTlsanpsd0hDRlNNR3Np?=
 =?utf-8?B?RVFFWGFTU1pjSkdDazdGQnlLbEdsTENqS1pTMk04MEFRR3JXUjhiZXd5ZCtY?=
 =?utf-8?B?T1JtdFE1UVk0OUlzYUtmYmlIelNDamZ4SldpWWxpR0J2WU1wM2w3WXZvRmM3?=
 =?utf-8?B?KzV1Sno1QjRFdk9KVU5IM3M2N1JaMEUybEx2ZFh1WU83Q2ZpVmRYQkdxaDZk?=
 =?utf-8?B?azlGQU8wejhVMzN1SjdCZ0NsV0hBcXA5b28xTXBOdi9aTnh2eXJnTGNNZnUw?=
 =?utf-8?B?WmtmWHRyaDNEQXdUeXNBTTUxT0tGQW1JbDZrTHNxZm5OdzVsbG4yb2V0Z3ZV?=
 =?utf-8?B?bGpCTlZGNXFIOWlxRnJvK2QwcWtCK2FRWW92THRXL1dhOU54MkZtM2R3K1Iy?=
 =?utf-8?B?L1RSVncyMjRneXh2Wm5jWTF4YUVkbEVrMDlBRXQ1NVZzZ241ZGVFNWtTNHNw?=
 =?utf-8?B?a0hkMGl2QVdNVDd1bUkrbnpRUUNxMzl0cERxSjlBSXVjdHJYakN2QzRoaGpz?=
 =?utf-8?B?TUR5VHBBV1lZTHRZNHRDZEtmRlF5cmpSckdVdFVXRTR6eU9qRWRuWXlaSGh5?=
 =?utf-8?B?cFd5a0hJS1Z1MkY2dVBqSjQwTGFIQmIxQVMzS0Qydnd3L202bjNoQUVEL2VO?=
 =?utf-8?B?SkZTd2hkUUlTTzE3MWVFNWgweW8xcDBsWW9PMlhRcDJKNWJSR3Nxbks3RUdp?=
 =?utf-8?B?cVBvOEFKMXZWOExDMDAxUndxVllqY0I0RHlSdGFUZ0IyS1FlNkIyMGI1ckk5?=
 =?utf-8?B?NmFPbStNS0o4a3F4alUyVVhlZVJWakhaSVZXYnVxMGZHUVBGb2luTis4MGo0?=
 =?utf-8?B?YnU2N1d3SGR5RWhML3JpaUgyNjIveTFLTUh6Wm1mU2NZaHRvSHNnQTRVdmpB?=
 =?utf-8?B?Tk1MdEh5dFF0bWpmeGtHODQ4YkVLUVowQ0o3WldkSmdEU3lqeGF1NC9tc2FW?=
 =?utf-8?B?L05yTmdDVExad0RrdDFVSDMyaG1aUkUzMVdhS3B0U1VRdFowaWVObUl4d1Ux?=
 =?utf-8?B?Ky9Kakovc2oyNUw2alN6aDVaQmdFWnVHSlErNmppdFNxVHBwcEhCSDRLbVFN?=
 =?utf-8?B?eVR5U05WRVltem9sQjBSMVFkbXd2UnJ0b0FrKzF2U2dmWFkxSnhOVzZKZ3d5?=
 =?utf-8?B?d2VMbFB4RjB2TGJLT3dxWjJCL3craDdWajA0SnhKM1FuRVRFdzhtZFBJMWFx?=
 =?utf-8?B?RFdINHBBeUpYUHNxQzErWG5reHBlWEk5WW55U3VTTVNGaEhKMXp1S0FjMmdq?=
 =?utf-8?B?QjhML0NtRm1GMnkyNlAxZW9kMnlaSUJTRWl2VU9UZ0I0cE0rNWkrYnZ0OFh6?=
 =?utf-8?B?UUN6azF2YlNHVnRWQmhyWU5OYmNKNUNlN0hUcFl6N1pUd3N4WDlQeUFLUGlj?=
 =?utf-8?B?K2NFMWpPNW5JVEVianIzRHNpOGlnS1RxSDF0NXZYQ1hLYkszcEUyZEc1NE1K?=
 =?utf-8?B?S1hBTDFXRVVaVTBwRVZGZnYrRHB4TlVWS1lnalBGb1VJcE5XQy9FcTVVZ3A4?=
 =?utf-8?B?bUUyTEtPOWNvc3JjS3pwRTdBaFdjZHJ6U0ZXdytiVzdGcHRHajR6Z3puYkVj?=
 =?utf-8?B?L1A3aHVnTGpTOFE1MXBVWHJ3Qk9kNlVxK3NNc1dRR1lEVm1zL1hPM0tIeWZ2?=
 =?utf-8?B?YVlXbXFRVHBuQVM0c1UvNUNDZFhEUVl4NXJka2RUNHYwQlp4bWFkaERjbmo3?=
 =?utf-8?B?QXZoa2tDRDVhaENZOHIveTNybFcxMjRGN2YrRWFOVVBxVkhHUjk4eTdIeDh5?=
 =?utf-8?Q?obZG7VLT2HRQW+2JRpLn0Kg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e18dc0-267c-4437-03be-08dde3e978f2
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:10:05.3797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAv8yjz6N0T1eEXL9EkEd1KoENUKcW7RHzxj8cjdSUZVphnpYan1CyK+exTtWRvvaaDmpZChbJ69IxdmUhirIZlFCS7Z5xDWKsB0lHLDkVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5959

On 2025-08-23 12:39, Thomas Gleixner wrote:
> OA
> This is a follow up on the initial series, which did a very basic attempt
> to sanitize the RSEQ handling in the kernel:
> 
>     https://lore.kernel.org/all/20250813155941.014821755@linutronix.de
> 
> Further analysis turned up more than these initial problems:

Thanks Thomas for looking into this. Sorry for the delayed reply,
I was on vacation.

> 
>    1) task::rseq_event_mask is a pointless bit-field despite the fact that
>       the ABI flags it was meant to support have been deprecated and
>       functionally disabled three years ago.

Yes, this should be converted to a simple boolean now.

> 
>    2) task::rseq_event_mask is accumulating bits unless there is a critical
>       section discovered in the user space rseq memory. This results in
>       pointless invocations of the rseq user space exit handler even if
>       there had nothing changed. As a matter of correctness these bits have
>       to be clear when exiting to user space and therefore pristine when
>       coming back into the kernel. Aside of correctness, this also avoids
>       pointless evaluation of the user space memory, which is a performance
>       benefit.

Thanks for catching this, that's indeed not the intended behavior.

> 
>    3) The evaluation of critical sections does not differentiate between
>       syscall and interrupt/exception exits. The current implementation
>       silently tolerates and fixes up critical sections which invoked a
>       syscall unless CONFIG_DEBUG_RSEQ is enabled.
> 
>       That's just wrong. If user space does that on a production kernel it
>       can keep the pieces. The kernel is not there to proliferate mindless
>       user space programming and letting everyone pay the performance
>       penalty.

Agreed. There is no point in supporting a userspace behavior on
production kernels that is prevented on debug kernels, especially
if this adds overhead to production kernels.

> 
> Additional findings:
> 
>    4) The decision to raise the work for exit is more than suboptimal.

Terminology-wise, just making sure we are on the same page: here
you are talking about "exit to usermode", and *not* the exit(2) system
call. I'm clarifying because I know mm people care about fork/clone/exit
syscall overhead as well.

>       Basically every context switch does so if the task has rseq, which is
>       nowadays likely as glibc makes use of it if available.

Correct.

> 
>       The consequence is that a lot of exits have to process RSEQ just for
>       nothing. The only reasons to do so are:
> 
>         the task was interrupted in user space and schedules

interrupted or takes a trap/exception (I will assume you consider traps and
exceptions as an interrupt classes within this discussion).

> 
>       or
> 
>         the CPU or MM CID changes in schedule() independent of the entry
>         mode

or the numa node id, which is typically tied to the CPU number, except
on powerpc AFAIR where numa node id to cpu mapping can be reconfigured
dynamically.

> 
>       That reduces the invocation space obviously significantly.

Yes.

> 
>    5) Signal handling does the RSEQ update unconditionally.
> 
>       That's wrong as the only reason to do so is when the task was
>       interrupted in user space independent of a schedule event.
> 
>       The only important task in that case is to handle the critical section
>       because after switching to the signal frame the original return IP is
>       not longer available.
> 
>       The CPU/MM CID values do not need to be updated at that point as they
>       can change again before the signal delivery goes out to user space.
> 
>       Again, if the task was in a critical section and issued a syscall then
>       it can keep the pieces as that's a violation of the ABI contract.

The key thing here is that the state of the cpu/mm cid/numa node id
fields are updated before returning to the userspace signal handler,
and that a rseq critical section within a signal handler works.
 From your description here we can indeed do less work on signal
delivery and still meet those requirements. That's good.

> 
>    6) CPU and MM CID are updated unconditionally
> 
>       That's again a pointless exercise when they didn't change. Then the
>       only action required is to check the critical section if and only if
>       the entry came via an interrupt.
> 
>       That can obviously be avoided by caching the values written to user
>       space and avoiding that path if they haven't changed

This is a good performance improvement, I agree. Note that this
will likely break Google's tcmalloc hack of re-using the cpu_id_start
field as a way to get notified about preemption. But they were warned
not to do that, and it breaks the documented userspace ABI contract,
so they will need to adapt. This situation is documented here:

commit 7d5265ffcd8b
     rseq: Validate read-only fields under DEBUG_RSEQ config

> 
>    7) The TIF_NOTIFY_RESUME mechanism is a horrorshow
> 
>       TIF_NOTIFY_RESUME is a multiplexing TIF bit and needs to invoke the
>       world and some more. Depending on workloads this can be set by
>       task_work, security, block and memory management. All unrelated to
>       RSEQ and quite some of them are likely to cause a reschedule.
>       But most of them are low frequency.
> 
>       So doing this work in the loop unconditionally is just waste. The
>       correct point to do this is at the end of that loop once all other bits
>       have been processed, because that's the point where the task is
>       actually going out to user space.

Note that the rseq work can trigger a page fault and a reschedule, which
makes me whether moving this work out of the work loop can be OK ?
I'll need to have a closer look at the relevant patches to understand
this better.

I suspect that the underlying problem here is not that the notify resume
adds too much overhead, but rather that we're setting the
TIF_NOTIFY_RESUME bit way more often than is good for us.

Initially I focused on minimizing the scheduler overhead, at the
expense of doing more work than strictly needed on exit to usermode.
But of course reality is not as simple, and we need to fine the right
balance.

If your goal is to have fewer calls to the resume notifier triggered
by rseq, we could perhaps change the way rseq_set_notify_resume()
is implemented to make it conditional on either:

- migration,
- preemption AND
     current->rseq->rseq_cs userspace value is set OR
     would require a page fault to be read.
- preemption AND mm_cid changes.

I'm not sure what to do about the powerpc numa node id reconfiguration
fringe use-case though.

> 
>    8) #7 caused another subtle work for nothing issue
> 
>       IO/URING and hypervisors invoke resume_user_mode_work() with a NULL
>       pointer for pt_regs, which causes the RSEQ code to ignore the critical
>       section check, but updating the CPU ID/ MM CID values unconditionally.
> 
>       For IO/URING this invocation is irrelevant because the IO workers can
>       never go out to user space and therefore do not have RSEQ memory in
>       the first place. So it's a non problem in the existing code as
>       task::rseq is NULL in that case.

OK

> 
>       Hypervisors are a different story. They need to drain task_work and
>       other pending items, which are multiplexed by TIF_NOTIFY_RESUME,
>       before entering guest mode.
> 
>       The invocation of resume_user_mode_work() clears TIF_NOTIFY_RESUME,
>       which means if rseq would ignore that case then it could miss a CPU
>       or MM CID update on the way back to user space.
> 
>       The handling of that is just a horrible and mindless hack as the event
>       might be re-raised between the time the ioctl() enters guest mode and
>       the actual exit to user space.
> 
>       So the obvious thing is to ignore the regs=NULL call and let the
>       offending hypervisor calls check when returning from the ioctl()
>       whether the event bit is set and re-raise the notification again.

Is this a useless work issue or a correctness issue ?

Also, AFAIU, your proposed approach will ensure that the rseq fields
are up to date when returning to userspace from the ioctl in the host
process, but there are no guarantees about having up to date fields
when running the guest VM. I'm fine with this, but I think it needs to
be clearly spelled out.

> 
>    9) Code efficiency
> 
>       RSEQ aims to improve performance for user space, but it completely
>       ignores the fact, that this needs to be implemented in a way which
>       does not impact the performance of the kernel significantly.
> 
>       So far this did not pop up as just a few people used it, but that has
>       changed because glibc started to use it widely.

The history of incremental rseq upstreaming into the kernel and then glibc can
help understand how this situation came to be:

Linux commit d7822b1e24f2 ("rseq: Introduce restartable sequences system call")

(2018)

     This includes microbenchmarks of specific use-cases, which clearly
     do not stress neither the scheduler nor exit to usermode.

     It includes jemalloc memory allocator (Facebook) latency benchmarks,
     which depend heavily on the userspace fast-paths.

     It includes hackbench results, cover the scheduling and return
     to usermode overhead. Given that there was no libc integration
     back then, the hackbench results do not include any rseq-triggered
     resume notifier work.

     Based on the rseq use at that point in time, the overhead of
     rseq was acceptable for it to be merged.

glibc commit 95e114a0919d ("nptl: Add rseq registration")

(2021)

     Florian Weimer added this feature to glibc. At this point
     the overhead you observe now should have become visible.
     This integration and performance testing was done by the
     glibc maintainers and distribution vendors who packaged this
     libc.

[...]

> That said, this series addresses the overall problems by:
> 
>    1) Limiting the RSEQ work to the actual conditions where it is
>       required. The full benefit is only available for architectures using
>       the generic entry infrastructure. All others get at least the basic
>       improvements.
> 
>    2) Re-implementing the whole user space handling based on proper data
>       structures and by actually looking at the impact it creates in the
>       fast path.
> 
>    3) Moving the actual handling of RSEQ out to the latest point in the exit
>       path, where possible. This is fully inlined into the fast path to keep
>       the impact confined.
> 
>       The initial attempt to make it completely independent of TIF bits and
>       just handle it with a quick check unconditionally on exit to user
>       space turned out to be not feasible. On workloads which are doing a
>       lot of quick syscalls the extra four instructions add up
>       significantly.
> 
>       So instead I ended up doing it at the end of the exit to user TIF
>       work loop once when all other TIF bits have been processed. At this
>       point interrupts are disabled and there is no way that the state
>       can change before the task goes out to user space for real.

I'll need to review what happens in case rseq needs to take a page fault
after your proposed changes. More discussion to come around the specific
patch in the series.

> 
>    Versus the limitations of #1 and #3:
> 
>     I wasted several days of my so copious time to figure out how to not
>     break all the architectures, which still insist on benefiting from core
>     code improvements by pulling everything and the world into their
>     architecture specific hackery.
> 
>     It's more than five years now that the generic entry code infrastructure
>     has been introduced for the very reason to lower the burden for core
>     code developers and maintainers and to share the common functionality
>     across the architecture zoo.
> 
>     Aside of the initial x86 move, which started this effort, there are only
>     three architectures who actually made the effort to utilize this. Two of
>     them were new ones, which were asked to use it right away.
> 
>     The only existing one, which converted over since then is S390 and I'm
>     truly grateful that they improved the generic infrastructure in that
>     process significantly.
> 
>     On ARM[64] there are at least serious efforts underway to move their
>     code over.
> 
>     Does everybody else think that core code improvements come for free and
>     the architecture specific hackery does not put any burden on others?
> 
>     Here is the hall of fame as far as RSEQ goes:
> 
>     	arch/mips/Kconfig:      select HAVE_RSEQ
> 	arch/openrisc/Kconfig:  select HAVE_RSEQ
> 	arch/powerpc/Kconfig:   select HAVE_RSEQ
> 
>     Two of them are barely maintained and shouldn't have RSEQ in the first
>     place....
> 
>     While I was very forthcoming in the past to accomodate for that and went
>     out of my way to enable stuff for everyone, but I'm drawing a line now.
> 
>     All extra improvements which are enabled by #1/#3 depend hard on the
>     generic infrastructure.
> 
>     I know that it's quite some effort to move an architecture over, but
>     it's a one time effort and investment into the future. This 'my
>     architecture is special for no reason' mindset is not sustainable and
>     just pushes the burden on others. There is zero justification for this.
> 
>     Not converging on common infrastructure is not only a burden for the
>     core people, it's also a missed opportunity for the architectures to
>     lower their own burden of chasing core improvements and implementing
>     them each with a different set of bugs.
> 
>     This is not the first time this happens. There are enough other examples
>     where it took ages to consolidate on common code. This just accumulates
>     technical debt and needless complexity, which everyone suffers from.
> 
>     I have happily converted the four architectures, which use the generic
>     entry code over, to utilize a shared generic TIF bit header so that
>     adding the TIF_RSEQ bit becomes a two line change and all four get the
>     benefit immediately. That was more consequent than just adding the bits
>     for each of them and it makes further maintainence of core
>     infrastructure simpler for all sides. See?


Can we make RSEQ depend on CONFIG_GENERIC_ENTRY (if that is the correct
option) ?

This would force additional architectures to move to the generic entry
infrastructure if they want to benefit from rseq.

I'll start looking into the series now.

Thanks,

Mathieu

> 
> 
> That said, as for the first version these patches have a pile of dependencies:
> 
> The series depends on the separately posted rseq bugfix:
> 
>     https://lore.kernel.org/lkml/87o6sj6z95.ffs@tglx/
> 
> and the uaccess generic helper series:
> 
>     https://lore.kernel.org/lkml/20250813150610.521355442@linutronix.de/
> 
> and a related futex fix in
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
> 
> The combination of all of them and some other related fixes (rseq
> selftests) are available here:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/base
> 
> For your convenience all of it is also available as a conglomerate from
> git:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/perf
> 
> The diffstat looks large, but a lot of that is due to extensive comments
> and the extra hackery to accommodate for random architecture code.
> 
> I did not yet come around to test this on anything else than x86. Help with
> that would be truly appreciated.
> 
> Thanks,
> 
> 	tglx
> 
>    "Additional problems are the offspring of poor solutions." - Mark Twain
> 	
> ---
>   Documentation/admin-guide/kernel-parameters.txt |    4
>   arch/Kconfig                                    |    4
>   arch/loongarch/Kconfig                          |    1
>   arch/loongarch/include/asm/thread_info.h        |   76 +-
>   arch/riscv/Kconfig                              |    1
>   arch/riscv/include/asm/thread_info.h            |   29 -
>   arch/s390/Kconfig                               |    1
>   arch/s390/include/asm/thread_info.h             |   44 -
>   arch/x86/Kconfig                                |    1
>   arch/x86/entry/syscall_32.c                     |    3
>   arch/x86/include/asm/thread_info.h              |   74 +-
>   b/include/asm-generic/thread_info_tif.h         |   51 ++
>   b/include/linux/rseq_entry.h                    |  601 +++++++++++++++++++++++
>   b/include/linux/rseq_types.h                    |   72 ++
>   drivers/hv/mshv_root_main.c                     |    2
>   fs/binfmt_elf.c                                 |    2
>   fs/exec.c                                       |    2
>   include/linux/entry-common.h                    |   38 -
>   include/linux/irq-entry-common.h                |   68 ++
>   include/linux/mm.h                              |   25
>   include/linux/resume_user_mode.h                |    2
>   include/linux/rseq.h                            |  216 +++++---
>   include/linux/sched.h                           |   50 +
>   include/linux/thread_info.h                     |    5
>   include/trace/events/rseq.h                     |    4
>   include/uapi/linux/rseq.h                       |   21
>   init/Kconfig                                    |   28 +
>   kernel/entry/common.c                           |   37 -
>   kernel/entry/syscall-common.c                   |    8
>   kernel/rseq.c                                   |  610 ++++++++++--------------
>   kernel/sched/core.c                             |   10
>   kernel/sched/membarrier.c                       |    8
>   kernel/sched/sched.h                            |    5
>   virt/kvm/kvm_main.c                             |    3
>   34 files changed, 1406 insertions(+), 700 deletions(-)


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

