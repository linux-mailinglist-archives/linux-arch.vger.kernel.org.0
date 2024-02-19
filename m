Return-Path: <linux-arch+bounces-2486-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5D185A977
	for <lists+linux-arch@lfdr.de>; Mon, 19 Feb 2024 18:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 428BDB21998
	for <lists+linux-arch@lfdr.de>; Mon, 19 Feb 2024 17:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD72B4438C;
	Mon, 19 Feb 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lu2u0tcq"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC026376E1;
	Mon, 19 Feb 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362032; cv=fail; b=HH0mM3to40qptvnUHAat2TxjbaWt2PtjfSnUPs/Eip/nWURrat0hphqzq1FVosFXpGPwrrqNX23UXM/xL5n9Plz4leZPTAsJlNrdyCs40xpCQvSyQnBeBx2zZ7QLekqcbZrC2VxaxbZbIVaYLbyBBbRC/6rgbS02SFusaOM2UJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362032; c=relaxed/simple;
	bh=VOlejjkybGXB7QpjN6VHTxE3unCTKgQ5nZqKLeAyEBQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YnTZYXFIbR7F9wgz/D3C5N3KUIhcotKOyi7zJazFxV66kDiso7W7mktSPYq5S/dKRp2vT4MCGeXM22tpTHABrQmrcAt+mjxN4jut6vY1HXJL5AoGabTKbWRj4ktkUieXKTlwmxS+F79bauoVu8+3aKw5SKMttgpaJIFlZRVFei0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lu2u0tcq; arc=fail smtp.client-ip=40.107.100.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcDZ70XSlf9aJRTLwKoI0BnnZR1DK0xLafwi2W/+iTzO31wpeIjUyb0PY8sBznyD8tkSUGz9jXMo33u6v3Kpba3dLPEGrWfMT1jlo65MKTfBtqgUNmapzFG5VuLVGbEqsNpt0MJD9rY7EVS0NNh9jC/qzgRU821gND1WWnXCRrZNJ+vHOUUpzcLRllwTxNhVVAbjHfqrUVP8QdsAynDPupdecDxS9ftQzPJPxFlnl8oz7+5bOWXhnzubH05ZxtYFEAOs6rP0QhjUsIeQDRTtxXZY1jvd+9pjIEhhfpxfDdmGX4YYW+5I3R0CJp7KXglj6XxAvD9wtZJG9urJJyUA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byhkyDaN3ohJ/x6xSezhIVsReW0tyts98sT4oqOaFAI=;
 b=kGKn4j9edGourVzrnmAQNAwCtGf27+pOKDtRB3Yi1unD353nOQbDM5v1qQMg9MSNUlSx033oY8JHjQzwfSubPLLbotPA6vALEqoUYA68Xuhb5ddxV880WjpSWg7cPS9rZ1O8+Gm3C7czvMIpO+P1YO6/C7ViD1tL/yd7UGv7DYWxJYB55TVIaf/15qGeRkHug1vdKysFa0oylff4RunUxWEjPg3Ngqgb3ME13GAH8B4OoeN+IHdnIqvaUG3P8va3AI/ALGk2JwtKcZxl6fCWAMJYyGMt0Udh89vd6oeqWX2Tr9OX8qT158HguteTBNlChQVR+1H9VqCcpLGWBvE2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byhkyDaN3ohJ/x6xSezhIVsReW0tyts98sT4oqOaFAI=;
 b=lu2u0tcqdZAC3F54LMeglXtyHh2EcLbYDsHyi8hMb44X0ErMh/X+VGjLv5UokOflHmfsPkJ9hKErqtAIKX2LA67nE+OMpK4oJPo0/0vt/7ua+XCZrgPVDdEG4DDex5FkB/YpWo7qM9+LsD+VW8PX//hvOYsypolth7pepXbUNdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH7PR12MB9075.namprd12.prod.outlook.com (2603:10b6:510:2f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 17:00:28 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42%4]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 17:00:27 +0000
Message-ID: <b2e0b647-b5a7-4c66-bb00-7907a2318f58@amd.com>
Date: Mon, 19 Feb 2024 11:00:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] efi/libstub: Add generic support for parsing
 mem_encrypt=
Content-Language: en-US
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Kevin Loughlin <kevinloughlin@google.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Justin Stitt <justinstitt@google.com>, Kees Cook <keescook@chromium.org>,
 Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org,
 llvm@lists.linux.dev
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-20-ardb+git@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20240213124143.1484862-20-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0101.namprd07.prod.outlook.com
 (2603:10b6:5:337::34) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH7PR12MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: dba1118b-ec02-4059-3697-08dc316c45d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0bStRpQkrh/0umuOcd/ztkiM46emXIotma3zXc9UNxdgZ0zgR9XiPTibN0xe9iNr9EBQWrXePLK2zmsRFlnJl1vx8guq2volBFMm9ZLs9PDfWqLiEqI85wMij7DhnLwAGUOeDTfYCDSKfJWNszpQqGWE6qrplG4CjzBdR69DbCNC6E/cOK01wOq98BfwnOlDQzCWok0WXF+8ChwbhHjpCWW+E0F509kMbTKo+rXWo6kcK0jNITNIzhJZuSzOK/gro0Kvlx4utf9li1bcsDb/PocLbesQvhk/Xem00kx7hT0dWE0ff91p7iTCF33SVfLw0BUpBBLFILfcBm7PtLBnqTHAYlzvytduTUD+0P92spOpeZpiJGeuSZiXtv2jvsLk5Mfcn3G4vqKWrdMhx1Q/yxStgdkbHzDMYIiWkHlaNRBVjO7YMmrY1jySj8ZjFer4S9JgTXbPbqwQV6RMEI2Y7iH+XUvwHSqMKBAGjbgtvYZCiI3oAKnLvrChSc1sR5VHm9FSb/gubFL3+pwJINcq8CsYLXdsB2wD62wUH+ydYiE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjFoNFZtaHA4ZDQ0aDNMaDV3NFdkUHVHS0s2dDl6alR0UE9QVWw1Wm04bkta?=
 =?utf-8?B?UUJZYkdpdHh5OEhTam5tTGtLNDAyTDlXbldFUWJpL202a1RXR2NLNXkyZVlW?=
 =?utf-8?B?bjZ0aVVEZzM0WTdTS1hlc2sxR3ErR1lxV2tFa1UvUmpjcytMM0hXZm01c0s3?=
 =?utf-8?B?cWp0dlZkRVBUNklQdkZyVWRuRnhjY3JoNjYwejlIZkd6aTlVc0hTUUVmcVo4?=
 =?utf-8?B?S1ErbVgwYlhQc2lCN2FhaTlIVW16Zi91MHlyRllSZ285RkF2M0FESGJUNi9J?=
 =?utf-8?B?RkJVTVlqVS9IMnh2aHpIelJJYWJBdkFFdWNtSWtXOWZmVHNTcDdMS3VSOTZ0?=
 =?utf-8?B?NDNIWWwxK1NHZW9lTHhRWDhvSFhGZnl4QTBLMHJFenNmWmlvZmdKcnlvcnNo?=
 =?utf-8?B?SzFVdE5pVStCNmZCMWdUQjZ3RkJra21KYzA4SW5kVHl3a1BDdHFKS29YWDgw?=
 =?utf-8?B?ZFNqb3V3ZXg3UHZYMXBROW80T3I3QTUyRlhCODlOY3NFZ01tU0h6WGtsdGpI?=
 =?utf-8?B?clgzWTA0czhjcWd2S0NHTW52MlBBcHU1b3FKdTAzdFJqLzkvclcrL1pvbUFP?=
 =?utf-8?B?MGVHakFyMjEvbUFyRGQwMUpvc2g1cG1rajMwano2OTdINmowNTdzRHlkL1o2?=
 =?utf-8?B?dW9IeU4vK2NJZWpSblIrNUdCdlNzNmczTDVld0NGM3VlS1RuenY1UnZlUzY4?=
 =?utf-8?B?OHRibXRQY2lrN29COFdPZ21TbnBVODZWNWlZcEFzTVNwM2syaEhkZDluYi8w?=
 =?utf-8?B?d1dzTEVTT3lORzNlT3JqVEEvUDRLM21lNmdadDhYaHl0TCt1eHFWSmJmV0lK?=
 =?utf-8?B?VzFpeGFVVFBIcm9oYVRxNzBacWhtNFJSd3FnbHpvblNNWU8wcUdhZGNMNU1a?=
 =?utf-8?B?WjBzbkc0LzJSSEVNVTdWVXRSMVpJQmFFVk5CcmtLMm9LdEtCUzBadjZGVUxl?=
 =?utf-8?B?TU0ybUxqNEZHbkYvRWU0bzluUVVCVG9EMkVOUGF3c09La29MU205M09QL0ln?=
 =?utf-8?B?RDJsQnJrUFRSZ3l0UFVpNzI3aEcvUDBJRi9oNE9iWHowUE5EZThwYktLTFdB?=
 =?utf-8?B?aUpIdjZBcEhxZW1NcjhqaGhpZW1VQmNFeURQU0VDMzJtNVgwQm45N280M1dI?=
 =?utf-8?B?RjJOTTNNZFZEWXRxNy9HTUVlRDlVZkxvOC8xcHNVc25lTnVibzlnMFg3UmdI?=
 =?utf-8?B?SG02VXV1K3lmTW1WYmZ5ZXRXRkFrcytHTGYwa2s1d08vMFM0bzJ3TGVYcTBS?=
 =?utf-8?B?UWExampOZnBmbVVmeUlSanpMS3EzOWNpRXJ5WndrSlVvSkZoenFyNkw0Rkhm?=
 =?utf-8?B?MkloWXY0RDBNUUJnWUNWTEMweGtPKzNHM0xpS0ZVZVBtUUN5TWRwUU5XZmdI?=
 =?utf-8?B?aFg5cDlIeXR3TUhtZFZHKzEzcS8wdkxMOEl3VWs1M1hPQVZaQ3ROTDdXWENP?=
 =?utf-8?B?OW8vSjhoTXZHdC8weFFDQWFKaXZ6R3JXZU9mSDVodnNEY0wwSVU5d3hOM1FW?=
 =?utf-8?B?RkJndmlSQS9wbzVFRnFrVEc3bFRIQ2hvMTR2MEJVQ2t1K0FzWldTT09sYkZ1?=
 =?utf-8?B?bnk5RDdTUHUvSDM3NHE1UWFuVkU2U3ZqV1p6Q0RQS2oxZUgxZXRFb0JuSkJ3?=
 =?utf-8?B?T0cxQnFLQlZEeXl2RDlLbW9iQ21wT29TT2YxZ083Y3hMUDRaVVd4VDUwbnNR?=
 =?utf-8?B?QlBzTjl3UnM2cHpObjNiTWl5UVNyWHlUQ2h6dlhzOUs5Sm5LMis4OEViV2Yx?=
 =?utf-8?B?bGpKM0xPQ1Q1ODV0MDduM0RhMWdsZTQ3UldNMXZRREhGb1ZXVGptT1FyZW9G?=
 =?utf-8?B?aExJV3BrYjQ0LzVkV2VRanJLdU14ZUhGSEtkR1p3Q3BzRm1TMURWSFEzR2Fk?=
 =?utf-8?B?bm9PUVU4R3Rid3UwWUtMNm9KbW1NUk5mcGYySFBEUkk1clk3bFFIVkRZUWp0?=
 =?utf-8?B?d0tjUkpqY244TDJtdWV3eWovU1ZKTU9QbFczUmdEYzRuYWc5aWJ4cFd2cGdJ?=
 =?utf-8?B?bHh0c3FqMmRscjlHMkpvV29jTVJ0QklBUU9WK0JxWGZueGU1RS96cjc2cVdz?=
 =?utf-8?B?VEVaamxrVDFIbEIydE9qRkhrQTVSOURxT2lNa1ZtNW9ZaUpubGFrSXRhM0lF?=
 =?utf-8?Q?Ij2fYjbUr8dppJb/rGe7WeN8g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba1118b-ec02-4059-3697-08dc316c45d5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 17:00:27.9009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkYFhXz5OVQuIRMcUIy+FC86594JNNHn/18e5/D+Jz0OlzJAlhntxIq8xlRkcEUDyY3JiWgA8IBqgiQ15LCJbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9075

On 2/13/24 06:41, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Parse the mem_encrypt= command line parameter from the EFI stub if
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y, so that it can be passed to the early
> boot code by the arch code in the stub.
> 
> This avoids the need for the core kernel to do any string parsing very
> early in the boot.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>   drivers/firmware/efi/libstub/efi-stub-helper.c | 8 ++++++++
>   drivers/firmware/efi/libstub/efistub.h         | 2 +-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index bfa30625f5d0..3dc2f9aaf08d 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -24,6 +24,8 @@ static bool efi_noinitrd;
>   static bool efi_nosoftreserve;
>   static bool efi_disable_pci_dma = IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
>   
> +int efi_mem_encrypt;
> +
>   bool __pure __efi_soft_reserve_enabled(void)
>   {
>   	return !efi_nosoftreserve;
> @@ -75,6 +77,12 @@ efi_status_t efi_parse_options(char const *cmdline)
>   			efi_noinitrd = true;
>   		} else if (IS_ENABLED(CONFIG_X86_64) && !strcmp(param, "no5lvl")) {
>   			efi_no5lvl = true;
> +		} else if (IS_ENABLED(CONFIG_ARCH_HAS_MEM_ENCRYPT) &&
> +			   !strcmp(param, "mem_encrypt") && val) {
> +			if (parse_option_str(val, "on"))
> +				efi_mem_encrypt = 1;
> +			else if (parse_option_str(val, "off"))
> +				efi_mem_encrypt = -1;

With CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT having recently been 
removed, I'm not sure what parsing for mem_encrypt=off does.

(Same thing in the next patch.)

Thanks,
Tom

>   		} else if (!strcmp(param, "efi") && val) {
>   			efi_nochunk = parse_option_str(val, "nochunk");
>   			efi_novamap |= parse_option_str(val, "novamap");
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 212687c30d79..a1c6ab24cd99 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -37,8 +37,8 @@ extern bool efi_no5lvl;
>   extern bool efi_nochunk;
>   extern bool efi_nokaslr;
>   extern int efi_loglevel;
> +extern int efi_mem_encrypt;
>   extern bool efi_novamap;
> -
>   extern const efi_system_table_t *efi_system_table;
>   
>   typedef union efi_dxe_services_table efi_dxe_services_table_t;

