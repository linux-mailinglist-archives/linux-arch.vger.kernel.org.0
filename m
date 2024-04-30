Return-Path: <linux-arch+bounces-4094-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F89D8B7E74
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 19:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B0D1F221FC
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 17:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D91617BB20;
	Tue, 30 Apr 2024 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A09Kl0Jq"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4064B17F385;
	Tue, 30 Apr 2024 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498155; cv=fail; b=kQ3idD1kcRWc4WZ51gqmJeHSCpMDTrP5SYTWvH2XGHID2tRp2Em64uyovaCL07s4b6RGz+PLvPQxURstLK3B9+bAopzxtSQvwrXJspd8fxBzW4Y/CpRHDyH9ObRK3fwLJq5SuaDVAKJzpsTwa6cfMW/JxFoCmVXQuAdhpCYNbEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498155; c=relaxed/simple;
	bh=OFy2A6pHyPiQxZok3YHJaknCVyMWeS/BulArIvHiiEQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NsEtaDO/O0x7EBUFbZX2lG2mVmiELBlkX/RULnQHoP4AwumttibP9xBJaM/CNP/uKou8wzrCxPUtWfVcHXDE/TSVdTyn5WyqiSpjljuU62HQL+GPo8M43TwUfdiIWb/IMQuxQmc/WpIvQwI61kdu7lqvTWe/+tZOez+Ymz9yI6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A09Kl0Jq; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1D+1nvuKplO+7I8/qyuRfELbGv07kAsPqlhBuv6AFAoqFLR7Y3Xkz98buM1Vaiwxnq7A5RdqleQSoW9SdN/YXQcdNspu7JeEE7B94q9PPQ9qXzIRstTkWzTddIQTiPfEvEReUuERSjNmMPRBaaefygtf+KpD4/XrzQfp3lO66F4ZIaTLJQ2Ds07YCoaa3LGqtINBvYnSHEg+7C4BahTyLXJfFqv16xY56ZRB7R8FT3aiCq9D9fXwxnJgYqTstUrzVvkqd867914JaT8ZMQfowPAPFyCPH4+m6aRX8oltVLzIshpVH5yMC60yJQFeDZegok+QikIVaR2bTxAlvnLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJ6wii3vJy1kTKIRi0sW8j/C9kcEAgYyokI3G+YyLpA=;
 b=TopBk7EmLl4col+pQ9YrRvLwzvrzWliuVKKyRSLAz6R6Tr8DUQ3LGthXfVQetqVjiA41x46hWF5wdN7Oj3+j8ciEYaQqWdvBCTCvd90xyqFWj0OD8CAYHlKpC7yT8klQZ0/rdEG0xgykfzWbPWLEXIWq5AMj2d87/7WChBUb55sFvlIVECEqpthnIIhRMSkaouEGAmJi+Q2uWPYx6coK82uW72DiQrabyNu45BtV2RculwyKHyya5svI+12AIpU/McqiBtk5kwgtaZ9tx/RSOmE3xj+GnkEX+u4RqnlLjLQqzMjfH6ZbH8rUdMv5wjUm542BlhTj3Ug9MjBxTxrPYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ6wii3vJy1kTKIRi0sW8j/C9kcEAgYyokI3G+YyLpA=;
 b=A09Kl0JqlS2ThS1Nu4ncGKb02lTffvokUVEVzIwzAaHsb9Q0RgxRks+oDosg2UKNP2mEgNMpkrUKwU/2JyQDOEgTJDFp+PYPi1534oV3L19OvjGR00f+HjsTTz/1qiU8NQt0T1pzM24/9jouK2KuOeq9Cz56pxVlerNjqhT5qps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 17:29:10 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 17:29:10 +0000
Message-ID: <958149a4-f5f5-4963-9af8-12e2a672733d@amd.com>
Date: Tue, 30 Apr 2024 13:29:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
To: Samuel Holland <samuel.holland@sifive.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240329072441.591471-14-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::16) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: ba75e1a5-5398-4f19-4a93-08dc693b0bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2ZWcGxUbGhNWEtuaHk1K0pyWUo0OXdobDJLMitkMnVBV3VXdUVFOUQ3dURh?=
 =?utf-8?B?RHB4QTdwc1lZc2d3OFloMzNOVUdaS1pzdTZ4MlU5U1QydnlmZVNyVEgwYk5R?=
 =?utf-8?B?UDJOZWtUNVVNRHd0ekVSZUJzU3B3Vnc4RWswTjRxSGo1STUwankyQ2kxdmYy?=
 =?utf-8?B?K0Yxc3IyQWZERVlQcXl1dFA0M1VTLzU4UGFqNzc1V0hOdnAvV1ZUNXhNU2cz?=
 =?utf-8?B?cUdqQnVwWGs0TW5tell1LytRK09iekt1WjZkVERwWTlhcG44K1JBMis0V2pZ?=
 =?utf-8?B?aUtQYzlUcFhsR2oybnhpcTZVb21jYUVjVE41M3ZZMnBsMTJlWmVMQUFKbDVi?=
 =?utf-8?B?SzhrQ1JoMEdCMVNZbjZ5WXpFWE1RbjYya0Nqa0ZzeUdGUFNQU09RMjhBcGg0?=
 =?utf-8?B?blp6V2FFN2k4SS96cERxNkVyZkpERkZ2VVE4Z1A2V2c2WUQ0ZmpnOVFjWFpN?=
 =?utf-8?B?L1d2ckNCMFJHRFQyb0VDN1JSZkhaZHRZV3VhWTFtS00xc2NRWXZPQlBXQk1s?=
 =?utf-8?B?VHZZOEw4ZGdJa0w3UnNIaUQ5NTdGQVB1L3JaMExIM3RqNXg5MUZlMTRZdllV?=
 =?utf-8?B?eGFWNm91OFVXS0xSTXJqSHpQU0ZGYmhIMHNIVW45RTU4YUJ2L2xwZ1YzL3p1?=
 =?utf-8?B?RHJBTWduM1dpUUFSWGcxODB3STMzSFlMWDFScHNDNnBkdE1sbjZqZGdBd1BR?=
 =?utf-8?B?cWtZN3RVZGE5Lyt6SUdtN3RIT2EvcHE1VzJlcmNWOGd4U0V6ZEs0eUNBVSt2?=
 =?utf-8?B?eS83MXhhWTdnZVpiSTdXTU9ZNDJoOTByVGhQYmkxR2EyUWJtZFBBMnF5K2lE?=
 =?utf-8?B?cWNtQVl5d0FLUXY2STdkY3laOHlvQkhPbEJYMHlFeXRwTmoxTmRtSFU1aVVM?=
 =?utf-8?B?TzVqVUN4NVM1Mlc2dmNnYjVJZFBzYkQrOW1ZeEo5Q2hGUE8yOWVHK1ZtL2xw?=
 =?utf-8?B?NHB6a2M0emZKVnVXRFZsa1FRNjZOMWhBWEhvSjhDUFNSNDhrUHg2SzlLQ2U5?=
 =?utf-8?B?NzU4azkxKzVUb2tGMDRTTUNTSDB3L2h5UXA3a3IxUUF0aC80RmxWRVNqVi9j?=
 =?utf-8?B?eGo5R2dvcUdsdnhTMFBpSzVoaFFCMWlRbWJrQytUSFpBY2lhS2gycE55RXox?=
 =?utf-8?B?aTNtbUV1dzk0SnQvT1Y2R1dWRE42Y2U0ODJNM240QmcwK0gzMzJkcnBQUHJr?=
 =?utf-8?B?di8xWWlGRzNHM1VtSGQybWN3eVN3R2IvRFJkdlo3QWtCbnFmb0M5WTdrT0lG?=
 =?utf-8?B?U3dSbHNGMHhNRXhiaFZsMWNlZnE3N1JteTNMZnJvUkRwRUk2dHVpY2Q0REdS?=
 =?utf-8?B?a0JlMHg2YzI4SUwra3A0OWJDNEx0OFZZb052Yy92aXN6eEVFcGNObFdINGRj?=
 =?utf-8?B?M3cwU2t0L1l5ZkhRYTBVYThGY2NpOGF2ZlBEMXQvQ1RhampMRWJmTVZsTzhJ?=
 =?utf-8?B?T1l6TDE3WHlYOTUvWjVSdG55UDRqb3pGY0RZVWxOdWRUemxYbytwbmVndFph?=
 =?utf-8?B?eU5XN29zSHBZWWJFd2htVmVpdGcvTUFMb1RqVWU1UFUycnN1R3RDQ1pJdE1H?=
 =?utf-8?B?RU1DUjA2eDZFcTFZaHhVUEVjenM3YTFRYWRGVjFRdjhVNHJuZVpUclRWbXl0?=
 =?utf-8?B?bmZZLzkzZEpSNllLR1VwYmxXVFhZSnREQlQ3dHBMTmFvUUlRcVFXWVZ5WjN4?=
 =?utf-8?B?ZzVGWjhXTGlITXRnODNNVXgzRFUwK1VmUk5wRGdWcGQxc1JjZlhOM3RRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDRlMGdWMENCOW9UektET2xIVEdTeHpCaXBNbzJyNEFOc0ZrVXc2Qzk3ZFZQ?=
 =?utf-8?B?anQwVDRDbzlXZ0RHajQzV2JJVDJUYjVJeHZhYjZCcndaV0dIV1hmdlB0SE94?=
 =?utf-8?B?eVBHdUZhUDJGbGxlYVF1dWUzYnhQamw2K2l1ai9lL0ZhZlo5ZmhtamQ5eklV?=
 =?utf-8?B?cDl5M0xsZzFmMGhMbnZ3UU9Ubko1eW5mWFk3N0tHNnZMMW1LRnpic0kyL01r?=
 =?utf-8?B?RGZLbUNHOGo0TVdwNWl5dHF6TG9uOEJPYjdhTFAvbFVoSXlYS3hVVzdKY2JB?=
 =?utf-8?B?cFJoWHRkM0UyWEoyZGJwcG9CUTRtZlArV0ZWV0xQN29sbnV6Q3Z6UGVGQzFp?=
 =?utf-8?B?eVM3MVNmTkt6K0FvT2xscmtCRmlMSUVVcmNBN0Q0QXFGSFdtU0gyMXFtcFZ0?=
 =?utf-8?B?ejR4NWdQYzFEeGxqRFo5NlZ3MGhFc0RqZG1CMmswOTBZaEZBZXJzbXBYMTIz?=
 =?utf-8?B?VmRtKzA1aUdkQzdLaXJnSVJ4NUxzVW93U3ZpL25XeDlaeko4Y2w5eXBDZ2ZW?=
 =?utf-8?B?MjlmdE1LMnYvampQd0FRZGFwRTNibHVRaTBOWXovTUpXOXY3WjNWRWkrZ2RS?=
 =?utf-8?B?RVlUdFQ5UHgyYll0TmcvK2ZZN240L2NVVTJIaVRpTmJaeFBVbUEvOFUrdURN?=
 =?utf-8?B?d0VVd3R4OGdUZGVWTUlhN0tjaW1kTFY2alF6OHhZMmtBaHJvdG54anZpTzdB?=
 =?utf-8?B?ZXN1WlBTRWorSk55bnY5R3NVWkhIdDRZbmVGWmkvL09oUVJJV2FyQ1AyTnBk?=
 =?utf-8?B?aTNOSThiY01OT2VnOG4vc3V4ai9UZVdXcjloREZ1Z2FDOHQwOURZalNZd3pI?=
 =?utf-8?B?M0lBWGx3N3Z3cXlESmZDNS9UTWlaK0ZmNXdyU2kvZnlQKzBsR3Q4MTZNOEhT?=
 =?utf-8?B?c2xCdHZSY0pNZXJRd2wwWFNQaTVKSFRnWkNGa0owbUdPbVQvZHRRdThEVUVP?=
 =?utf-8?B?L1prZTl6QzBtV0V1L2N2TTQ2am50c1Q0TFZ3UGJ4V0NSRmhQT00vUG5rWDFy?=
 =?utf-8?B?K1ZMTkswOGVQNmZLTSs3Z3gyMHJYSkVjdjBVOGRDSk0zZUhMdk9yQ2ZMR3ZZ?=
 =?utf-8?B?Vlh5K3hSblJvQ1l6WStBYXlFYzFiMVFIYkFqN1NLNXZPcXhsSTFDK2pBYmdE?=
 =?utf-8?B?d3RrNm96Z2JBUUQyUHdzTjFoUE5pZk9lb0x3dlhDQTJBeHVpNjBJNk5IYVNh?=
 =?utf-8?B?SzdYSTRxNnFPdHcvS3B2V296ZU1Tcmg1MDREOGFFcC9IcEpidE93VDVlekRn?=
 =?utf-8?B?MEhSNWNsVXM0YUtsREtqU1pZSERjRFZ6TnJHeGVFQnl6dTcrQlVGL2Vic1By?=
 =?utf-8?B?VTJuUXhjU1lzdThrblYwT25uVDhLbXBoUDRqKzVoQkJUOFREQVdtc2lzY3l5?=
 =?utf-8?B?UklGbEtDSUZOeVdBaTN6c2d0VGV0ckJtcE1uTXl5R3F3eDNrYjhmQmZyYWQ0?=
 =?utf-8?B?RXBtWGV5enQ1TkFCaTVVUjFXS0NlSzdWTStpY010NjVpQmdjeVRudkFhYjFT?=
 =?utf-8?B?eTZTNmRVRkM4bVFhV0cwNjN4bFYvR0lncW4wUGhVbGI4Y09YUS82ZlBwTDJn?=
 =?utf-8?B?SVVVUVNQdTkrcEovRGt4WDhJNnRMRm5OSlZUeDJVUk5iT3VuZWpvN2NyUmJ4?=
 =?utf-8?B?MFU4ckVCVGgrcG5UQlhrRmZieUZSaFpLN1VuaUcyTmZpazFHQTZYamZKNHVX?=
 =?utf-8?B?V01nZzdYVmpTZTBMWGswQ0hYL2hHdCt5c3UzSm9RZXVDTEdtdG15aVo2RnZW?=
 =?utf-8?B?cDNNaTRJcEx0OFp4dmRrMFVEUmM0SXA4UmE4RjdrMXEraTJoSVZ4NnRHS01y?=
 =?utf-8?B?bHBsTEtGRGM3TUhFY3VkckNXaUpWVTVNZkxIdWpPbzB0MndONkVMb2xLK0to?=
 =?utf-8?B?QkhGMERic21HZnF4cUUveVpCUjY0YVlVRTQ1UUlKY256Q01ZNTJLOVVES3RR?=
 =?utf-8?B?MDBBVzR2WFFoTTIwOWdYTjdTckgvWUNIU0tMWUFHZitySUJYNmIybnFqaFBw?=
 =?utf-8?B?cTlEdG0vdER3eEFIOFdwb25ZVVcxdkMzRS9JNFJZV3JVNEFkSnB5RlVhdTdI?=
 =?utf-8?B?MjgvdVd5S1lJQjdqalY1SmJjbzRYUm8wcXBmVzRYSEJyaUZ1NXcwR2s0WlBB?=
 =?utf-8?Q?FEJHJ7Z2+vnFlBWuU3Ovi0DfD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba75e1a5-5398-4f19-4a93-08dc693b0bfe
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 17:29:10.6547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8tsnWW0OQ/9NiZj4MF2NyY5ENkv7omndeXcVPwrtSZoaixhEowGfsGNUZ5JZ49aojTe8aQK8ymeVqwpN6JcUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322



On 2024-03-29 03:18, Samuel Holland wrote:
> Now that all previously-supported architectures select
> ARCH_HAS_KERNEL_FPU_SUPPORT, this code can depend on that symbol instead
> of the existing list of architectures. It can also take advantage of the
> common kernel-mode FPU API and method of adjusting CFLAGS.
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Really nice set of changes.

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
>  - Split altivec removal to a separate patch
>  - Use linux/fpu.h instead of asm/fpu.h in consumers
> 
>  drivers/gpu/drm/amd/display/Kconfig           |  2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    | 27 ++------------
>  drivers/gpu/drm/amd/display/dc/dml/Makefile   | 36 ++-----------------
>  drivers/gpu/drm/amd/display/dc/dml2/Makefile  | 36 ++-----------------
>  4 files changed, 7 insertions(+), 94 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 901d1961b739..5fcd4f778dc3 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -8,7 +8,7 @@ config DRM_AMD_DC
>  	depends on BROKEN || !CC_IS_CLANG || ARM64 || RISCV || SPARC64 || X86_64
>  	select SND_HDA_COMPONENT if SND_HDA_CORE
>  	# !CC_IS_CLANG: https://github.com/ClangBuiltLinux/linux/issues/1752
> -	select DRM_AMD_DC_FP if (X86 || LOONGARCH || (PPC64 && ALTIVEC) || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
> +	select DRM_AMD_DC_FP if ARCH_HAS_KERNEL_FPU_SUPPORT && (!ARM64 || !CC_IS_CLANG)
>  	help
>  	  Choose this option if you want to use the new display engine
>  	  support for AMDGPU. This adds required support for Vega and
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> index 0de16796466b..e46f8ce41d87 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> @@ -26,16 +26,7 @@
>  
>  #include "dc_trace.h"
>  
> -#if defined(CONFIG_X86)
> -#include <asm/fpu/api.h>
> -#elif defined(CONFIG_PPC64)
> -#include <asm/switch_to.h>
> -#include <asm/cputable.h>
> -#elif defined(CONFIG_ARM64)
> -#include <asm/neon.h>
> -#elif defined(CONFIG_LOONGARCH)
> -#include <asm/fpu.h>
> -#endif
> +#include <linux/fpu.h>
>  
>  /**
>   * DOC: DC FPU manipulation overview
> @@ -87,16 +78,9 @@ void dc_fpu_begin(const char *function_name, const int line)
>  	WARN_ON_ONCE(!in_task());
>  	preempt_disable();
>  	depth = __this_cpu_inc_return(fpu_recursion_depth);
> -
>  	if (depth == 1) {
> -#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
> +		BUG_ON(!kernel_fpu_available());
>  		kernel_fpu_begin();
> -#elif defined(CONFIG_PPC64)
> -		if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
> -			enable_kernel_fp();
> -#elif defined(CONFIG_ARM64)
> -		kernel_neon_begin();
> -#endif
>  	}
>  
>  	TRACE_DCN_FPU(true, function_name, line, depth);
> @@ -118,14 +102,7 @@ void dc_fpu_end(const char *function_name, const int line)
>  
>  	depth = __this_cpu_dec_return(fpu_recursion_depth);
>  	if (depth == 0) {
> -#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
>  		kernel_fpu_end();
> -#elif defined(CONFIG_PPC64)
> -		if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
> -			disable_kernel_fp();
> -#elif defined(CONFIG_ARM64)
> -		kernel_neon_end();
> -#endif
>  	} else {
>  		WARN_ON_ONCE(depth < 0);
>  	}
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index 59d3972341d2..a94b6d546cd1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -25,40 +25,8 @@
>  # It provides the general basic services required by other DAL
>  # subcomponents.
>  
> -ifdef CONFIG_X86
> -dml_ccflags-$(CONFIG_CC_IS_GCC) := -mhard-float
> -dml_ccflags := $(dml_ccflags-y) -msse
> -endif
> -
> -ifdef CONFIG_PPC64
> -dml_ccflags := -mhard-float
> -endif
> -
> -ifdef CONFIG_ARM64
> -dml_rcflags := -mgeneral-regs-only
> -endif
> -
> -ifdef CONFIG_LOONGARCH
> -dml_ccflags := -mfpu=64
> -dml_rcflags := -msoft-float
> -endif
> -
> -ifdef CONFIG_CC_IS_GCC
> -ifneq ($(call gcc-min-version, 70100),y)
> -IS_OLD_GCC = 1
> -endif
> -endif
> -
> -ifdef CONFIG_X86
> -ifdef IS_OLD_GCC
> -# Stack alignment mismatch, proceed with caution.
> -# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> -# (8B stack alignment).
> -dml_ccflags += -mpreferred-stack-boundary=4
> -else
> -dml_ccflags += -msse2
> -endif
> -endif
> +dml_ccflags := $(CC_FLAGS_FPU)
> +dml_rcflags := $(CC_FLAGS_NO_FPU)
>  
>  ifneq ($(CONFIG_FRAME_WARN),0)
>  ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/Makefile b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
> index 7b51364084b5..4f6c804a26ad 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
> @@ -24,40 +24,8 @@
>  #
>  # Makefile for dml2.
>  
> -ifdef CONFIG_X86
> -dml2_ccflags-$(CONFIG_CC_IS_GCC) := -mhard-float
> -dml2_ccflags := $(dml2_ccflags-y) -msse
> -endif
> -
> -ifdef CONFIG_PPC64
> -dml2_ccflags := -mhard-float
> -endif
> -
> -ifdef CONFIG_ARM64
> -dml2_rcflags := -mgeneral-regs-only
> -endif
> -
> -ifdef CONFIG_LOONGARCH
> -dml2_ccflags := -mfpu=64
> -dml2_rcflags := -msoft-float
> -endif
> -
> -ifdef CONFIG_CC_IS_GCC
> -ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> -IS_OLD_GCC = 1
> -endif
> -endif
> -
> -ifdef CONFIG_X86
> -ifdef IS_OLD_GCC
> -# Stack alignment mismatch, proceed with caution.
> -# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> -# (8B stack alignment).
> -dml2_ccflags += -mpreferred-stack-boundary=4
> -else
> -dml2_ccflags += -msse2
> -endif
> -endif
> +dml2_ccflags := $(CC_FLAGS_FPU)
> +dml2_rcflags := $(CC_FLAGS_NO_FPU)
>  
>  ifneq ($(CONFIG_FRAME_WARN),0)
>  ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)


