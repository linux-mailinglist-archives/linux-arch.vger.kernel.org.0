Return-Path: <linux-arch+bounces-2515-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD75E85C4CA
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 20:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCA71C2119A
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 19:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502FF1350F9;
	Tue, 20 Feb 2024 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E5bWUKlX"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8491112F5BF;
	Tue, 20 Feb 2024 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708457289; cv=fail; b=t+C2iTDdrI95QU0ut0Uzhoy6MyaPQAJXbMq9yt96kNp/LoCPt1mknSYqTlORk4R5w83AX9Xiq2cbL/4V8q97/wHh5BXDY5y8z2/YfHvInNqKFU8+08FSindXOV382Qeju/0VZCbAr/EhyML1Sp2y60rM65KdB1DydfRlnR1V2sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708457289; c=relaxed/simple;
	bh=rPeU+QktqTHq5+dKqL7S5l4zHOJJN0dT5j6ihXSp5l8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dXjTHCCT7C52M/ybWVCN/Ml+ZR///zltms1Y4HY4u32d13fGv1oZwKmwn0pHHfY4deXAPT58vYh1tng6saH0Mi1ImyMZxBlSGKE4mr6tKa4XcIuB2WDKHb0F716CNs1PC6HABA9ZmlzGTIEcaVPo/D1tIMmBzmghuQdQFU0wkpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E5bWUKlX; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0Zy6mEW2u4QhqYGQ4h9p68DJCMpZib2hf6N+z+Ia1G5Maq7/ueFABMhm/zIiROltgfQkBrACRc1kSxNjDrypW8wTQwwxj3xpMsEvhXJkieL+yKavq2QiVLcR65z8enHFXVDphuY7APqcE2vj8Woylk/+c6eOcSMW25L6D/VySjFzZgFBJftOGR17Aio9dayWU1xN9jvYAPXN+f7RqWCI2A8Z0brBnckMrXXWLpYWQjEjNslBfwtVZTFNv5P2fzNnM2Cw1NVFRvb0R4YcWtZ9YO9uI3e5FNu62cRSsJBj7U3MCqr2uuKZZYqh3mpiwprrh0onhW4x0kgzzrp6/O5/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/jrjmftzM4l65hwH8HQ9Md+etuhtoXYIXpWpuqe5ZI=;
 b=S97MZbIvllHslIqOlE/vURCO6j6OKf9wKoSFa69D0lU5t6r7gCkQR+vjQDqtj1Q0S6vXfqL0O4cctybF6wKOh+nyy8sfiOzRg0Uo8Y21ielkXjpncIQ2ra271udDaHHM496Zm8/RzOD1SYgzaYx0LI4B6Wa7Ua7RoE9ReXim3AFn6+K2yW9cw04Z7JyS5kssU3gUrFjZH0rlSD/0feBaoOtuKaFqK8R3Nj0USJjvI+3L2I3Fxq8fQtw1gIJUOFSqIGs9aEZzZU2KD6l7BZ4iu/u+4mB82DcMmnb8Scw2q96EozklkMvghM9UIdDtCJyO+4wBSzoY5FEN76dQ26agNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/jrjmftzM4l65hwH8HQ9Md+etuhtoXYIXpWpuqe5ZI=;
 b=E5bWUKlXEss6oGbOKbaSUoUzYnGdqYF5QY/QivdxZnf1QwKV8vPq0Xp6oa5gRFro3QF/AnAhhDnr566vouzw/SPMctS/37H1T4PLYD16qIjUWEi1XccAYvSYb3NVnvezcAfcLQ7WyGBjpTtZxcoUxrWQHLJ0u0u22vaBfD+2k6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 19:28:03 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 19:28:03 +0000
Message-ID: <fccd8544-76ab-4723-9616-ff4bc783b692@amd.com>
Date: Tue, 20 Feb 2024 13:28:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] efi/libstub: Add generic support for parsing
 mem_encrypt=
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
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
 <b2e0b647-b5a7-4c66-bb00-7907a2318f58@amd.com>
 <CAMj1kXG_sQ-+ULtvE7SqD0DYe3p9=tP8K9VPgfiR-0Z55A9vVw@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <CAMj1kXG_sQ-+ULtvE7SqD0DYe3p9=tP8K9VPgfiR-0Z55A9vVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:8:2f::21) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|LV8PR12MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: 001e488e-43ca-4a55-fb7f-08dc324a0e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3go9Fl9FKl41Gg0dI31NUT87fGnv9iKi+MbxCWT5DXminfqio0XoKBMGx+m7FQ/EtqgnqNbfHnkMpcfK15VmkLOSqfGieJvisqGBNFZ3UP3yHfyQls9r9vFoEWmWXdKQr1fgfXbxAYGfZYIrqFpJWvJf+4vWj/tD2KSYuQjbaY/FyKQQT9kv85nj6V1n1xOpD2X72sBvd7oZorEiTH1tWGNdhLEFP59GwaQCIpZ3l9t6xsAS6mOYPjUbP2fxGH9crh/RD4iC1wlqxMcnzyOTIEsbVUgaFV5HtOKwag1SOUqErfB5h+hoNs3lM1EMPPt0HXyH4QrJyYSeFdc4WapG3JLnW+15DowzAoskkcXcc7q5kr/CXt3bUOXbaYQRXfkv31dMEgIhaEr/LHs32Z3Y/cvDozfXtKPp8QL4h+9k00/mtDdC0uGjBdp4t0wQCIYOwqUHPMVygY8JEv4mz22w75n/NqvbZWw5e4/9VP43orCHkX0za3TeBodUDij1VhfC1wkJxdnv4c5J2o2/0emiX45wLfM5kWajCMdllwKjw1g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE1vVmtmUlBnS2NNZEtVSldZWGpHV2tUam84c3FiWmxacDA0b2lLRFJWdTZt?=
 =?utf-8?B?WjJ2ZTduUDh1NGF1ZjBMeXVaMC9wL1RNYTBSWHc1bGFNeWZGcjFYT000eUNU?=
 =?utf-8?B?Qkw0blZBTVE0aENyUWpEWWtJRGRiU01nTVRzKzFqaldQRmltNEFTcmUwMU1Z?=
 =?utf-8?B?YzdTd3BvMEszSWdKLytVbXRURVVPenVqQ1ZieUVXcmttYkNwWlBCTVI1WWpX?=
 =?utf-8?B?VDI3Y1NHWUlVZlpYYlBvSG1qbGhCUE1sTTgzWUs4YVZtQUVUeFkyd1RENDg4?=
 =?utf-8?B?MFJuSVRnMlpSTWVwSy9yZm53WUtQVnBWcnRFTngwT0JLRjJoRVIxcWhDbXhy?=
 =?utf-8?B?aUNMenFwQ0wyYUlOR2pXQWtJeXE0VGk2UWdZQ0wyOGpZWWIwVXZOUHlnWUgw?=
 =?utf-8?B?MFJVZ0U2UDBYRTc0b2Z2VEN6b2R4NDh2dGJucHREYjl6OE1GYVI4ZTJNd2Jk?=
 =?utf-8?B?a2pab3ZobXpibUc3SUVuRHZMckFUOWdKT0xsR2xZVzN6OTZsMHBvd0VPVity?=
 =?utf-8?B?OEFhNlhJb3dSUCtWZEN6Ym05V3ZBeHhoZ2pXTkgxS1hBRklpK3pmYlI5UnBJ?=
 =?utf-8?B?U01PWXY1OUozVWhDbkRZUWNVanlpRC9ibmxxbzJyalE0QlhGVmxlZmk3NVZ3?=
 =?utf-8?B?bnJIRWpVTE5XN2U1ZXFDU2c4ZGQwelZ4b09iTU45VVMzWmlWTVdCN21leE84?=
 =?utf-8?B?Y3ZyVUZTSTNjczBBUHNMY2ZDOE8zTWE3S2hpTWovZ21tYUdxWm96dWYxeUx6?=
 =?utf-8?B?azlvcUsweW16RWlpakI1MGVRUFFzbFNWRXQ1cjFXbTUvMEtlTjdNOElFRit1?=
 =?utf-8?B?SFhYejFlK3N5a1Ntc0JoSGFrZ1piZzd0QlhjMFU3TWlmVklIeDdhU0ttbmRX?=
 =?utf-8?B?eSswbTBMTnZGRUxlS1VGSEppaHpIa1lRVzA3ajFBL2FQbFhxT1NaOWkwWkla?=
 =?utf-8?B?T1BUTmp4Yk5RelYwakQrVFNISGxxc1lVL3l6L3RaZzVDbnJhb3pGNllVenRt?=
 =?utf-8?B?T1dFWXNOY0lKYU96WXU2MDZKeG41aHdLQzRZY0plbFdHczIvdVlhU2NrNURa?=
 =?utf-8?B?OER1Slk2YnFkMWt5WmtwdElQNG56MGdjR3R1OWo2dm9mYzdZR1J1d3NlT3NG?=
 =?utf-8?B?T2pXNHNMRTZoODNLc20yNjMray9aVEZQNGxaTERpQlZ6b04wNTV2eHBQaEJo?=
 =?utf-8?B?UFZ4NEx0Y3Ixcy96R2NTbnNQNDNqS284VWVKTUpPTlp1ckhINmZ2ckQvTzBx?=
 =?utf-8?B?d09DWHkycjNDcW44VWV2VVBwZEo0cFp1UmtYelZUaTIwRmdqeExGNzNqSnpX?=
 =?utf-8?B?MXdZMzBPOUU4bnVYbklSalNTdkFwY0oyRzlpYk92L1YrdGVpVlJhdFV0R1ZV?=
 =?utf-8?B?WllBVDBJNlErVDVjZG5IY0pmUmJMQXpMQjJBa3Rub2dyTEdTUElwelJCZEcy?=
 =?utf-8?B?SmtIR0JNWmsyM0Z6bmRRbG5ZR2lLKzk5MVVydVR6bW9wL1pHU0FlNzVMREVM?=
 =?utf-8?B?T2RnUkt3ZHN1WjJUM0RTZjN6bjVFSm5IRDFXMml6MHFKMlVxQ2IxM2oycDFi?=
 =?utf-8?B?emxWb0hrQlRtUjM2ZVQ1S2dueUZUZWxQdFgwK0RsTDk5eXQxRHJWTUdCcVpa?=
 =?utf-8?B?dzJHQU1zSGtwNVBSVVhHeEJnRU1WQWFSQ0FIbks1eG1FTEZNeVNQV2FZWUlw?=
 =?utf-8?B?a0Q1ZlpscDFQa1d6WWxnUHBnbUZRMkNhSURSOHljWDd4QWI2M1Z1d0xiTE1I?=
 =?utf-8?B?bGVMK3hpaWh2a1ljSUxOSk53NktVL3dOblNNZDlkREY3TFIyRjBobHl3Q1pJ?=
 =?utf-8?B?UE0xd0x4U0ZKa1ZRS1lhL01kbUFnc3gvOUxORTlWeWN2Wkgxa3JjK2lGblEv?=
 =?utf-8?B?VkQ3eGIwdFMzUkxrSzYxN3piRWFiVHlBUVk2c0hyd0t5bm81dGg2cFNhM1VJ?=
 =?utf-8?B?SVJVb1ltb3NRK2hJUGlRMFlOTDBXSDQ3Skt6Wkc2a2dvL2xEQXBoc05DYlNj?=
 =?utf-8?B?c1Y1WmFpc2sra1JNZVd3eEJQVytRVXQvYmNmcTRhbHlDVDIyTWJOclZKSmVO?=
 =?utf-8?B?WXduWVplMzBOR0V2R0FkMWl0MGRNaDY3U0VUd0t0ZCtXVmh6S2IxM2c2bWJo?=
 =?utf-8?Q?bFNgCyVIuE/qrVuA9oIlaQBPq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001e488e-43ca-4a55-fb7f-08dc324a0e83
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 19:28:03.4160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeGhO8gExKyq/+n6SRDuY+rJ/oUf/M9wsjDGeY9xGdtifKfNz7f5zrMQvchmquvLM7g70qY+DTR2YCEXIANcZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231

On 2/19/24 11:06, Ard Biesheuvel wrote:
> On Mon, 19 Feb 2024 at 18:00, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 2/13/24 06:41, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> Parse the mem_encrypt= command line parameter from the EFI stub if
>>> CONFIG_ARCH_HAS_MEM_ENCRYPT=y, so that it can be passed to the early
>>> boot code by the arch code in the stub.
>>>
>>> This avoids the need for the core kernel to do any string parsing very
>>> early in the boot.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> ---
>>>    drivers/firmware/efi/libstub/efi-stub-helper.c | 8 ++++++++
>>>    drivers/firmware/efi/libstub/efistub.h         | 2 +-
>>>    2 files changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
>>> index bfa30625f5d0..3dc2f9aaf08d 100644
>>> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
>>> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
>>> @@ -24,6 +24,8 @@ static bool efi_noinitrd;
>>>    static bool efi_nosoftreserve;
>>>    static bool efi_disable_pci_dma = IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
>>>
>>> +int efi_mem_encrypt;
>>> +
>>>    bool __pure __efi_soft_reserve_enabled(void)
>>>    {
>>>        return !efi_nosoftreserve;
>>> @@ -75,6 +77,12 @@ efi_status_t efi_parse_options(char const *cmdline)
>>>                        efi_noinitrd = true;
>>>                } else if (IS_ENABLED(CONFIG_X86_64) && !strcmp(param, "no5lvl")) {
>>>                        efi_no5lvl = true;
>>> +             } else if (IS_ENABLED(CONFIG_ARCH_HAS_MEM_ENCRYPT) &&
>>> +                        !strcmp(param, "mem_encrypt") && val) {
>>> +                     if (parse_option_str(val, "on"))
>>> +                             efi_mem_encrypt = 1;
>>> +                     else if (parse_option_str(val, "off"))
>>> +                             efi_mem_encrypt = -1;
>>
>> With CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT having recently been
>> removed, I'm not sure what parsing for mem_encrypt=off does.
>>
>> (Same thing in the next patch.)
>>
> 
> We have to deal with both mem_encrypt=on and mem_encrypt=off occurring
> on the command line. efi_parse_options() may be called more than once,
> i.e., when there is a default command line baked into the image that
> can be overridden at runtime. So if the baked in one has
> mem_encrypt=on, mem_encrypt=off appearing later should counter that.
> 
> The same applies to the next patch, although the decompressor appears
> to ignore the built-in command line entirely (I made a note of that in
> the commit log)

Ah, makes sense.

Thanks,
Tom


