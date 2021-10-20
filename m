Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE996434FD3
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 18:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhJTQNg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 12:13:36 -0400
Received: from mail-dm6nam10on2079.outbound.protection.outlook.com ([40.107.93.79]:44640
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231134AbhJTQNf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Oct 2021 12:13:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zd9YTb6+fDyhSptDrJk5ZHZgl9tb62grkP2Yr7dlGkRDUnXtMIE/AKzByvwEaqUqodLrFesmZN2LC3PIObK8uI64JkynmnABZNlCpyHR+1hrMjNVNGGPzig6tFp2P/MqKJnRPiQkqsH5PWsKiOLv0OKEGNtR/GTyeVht1thycipfysFlNiN8dshGMTg3+FnZeeFV1qEe3xrqp9mm4RwMNbuYK4LNlX6EZGW9ZBNEJRVg7MV7bABBWEuO86TXBUjc/h/s/JTqeTxhO00VLyAAizWqUICjUOddthaQnkaNI/sYCEnEJp9TVAdm85U3ZA16yo5shePOZaY+xJla52QtPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcykHuXPZ/rBLbVCxMkbnrZxw5QCIFezPbxj9aGouCM=;
 b=OMfLzTZmSit1ulaml6TdQpux3hhAHKpc+1MOv3x2Mvb9OoKqMbkbDHMQ7vfvJ6paNq68jJ3ZgYvTXSvowKtQN1BII4ZEet0OwxeUuZXKCmn3LEnZkQKbf2ShU9Gq9KqWjQN2rSp7dCEyZSkQ1R+/FfNLLtIQ8DFJ6zh+vFUvmAO+xMgTxW0rVz5tTMpp/cYKB2sBm/CNDoiqVhI1k1X5tAHEmwdr2S1NvE+mJc5PiV7I0SrTX52M+CkGtKW9KyqiuejoiwhDQ1JjpnH0Obn5faPVNPx0Nw/fSSolQRorQIpuvbM9HGoltN5tDOtzh1fr0EL4IqXD2EVddbTlFt2LGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcykHuXPZ/rBLbVCxMkbnrZxw5QCIFezPbxj9aGouCM=;
 b=m+Tr239RPIRJvmCWV5OXc43kZEqRZLOxSN/rJemub9X6DeKoBztEEyyrEecPQssO9+nxK0u7ZVsRuIMzLzZL8rOY4oKh5H5+XFwkT7QDga6rew7y9hD/V56+qr4DZqf5A6gqMRkp4ufYf/d7LJht1liCgNuD0x1OWtDNnsTj6VA=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 16:11:18 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9%7]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 16:11:17 +0000
Subject: Re: [PATCH v5 01/16] x86/mm: Move force_dma_unencrypted() to common
 code
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-2-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <72b8be39-b4e2-5d77-524c-a2ea0c750ab1@amd.com>
Date:   Wed, 20 Oct 2021 11:11:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211009003711.1390019-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:610:e7::6) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by CH0PR03CA0211.namprd03.prod.outlook.com (2603:10b6:610:e7::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 16:11:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae7ee5c4-4be9-4ffc-0973-08d993e43f4c
X-MS-TrafficTypeDiagnostic: DM6PR12MB5534:
X-Microsoft-Antispam-PRVS: <DM6PR12MB553462D0FDDFC9213F86E0F2ECBE9@DM6PR12MB5534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lV8YVGY5yUCweDYDjjs7Mm7onPyXj9eITHjrOodIX+e5slHtCEgFAgwat0Us7AGyGYsF7DweXXH751PTHulsxn0v+9cDJfKZd1ZKDz2Ql2xteGJTKO3JcaoBcMf3Kn5XYw9+eZ5WhGABbvJTQ3LrerjE/1ZVE4zUZPK2VNiJhjiosLbz8BtMQ1k7Gnci2rOkmpzwmd4EJ6Ma5UP2v5PWJk6P/EHky8k7/ikvLqv5/1uJ1m7M5HxxnjeMaZzVjRODhgt1ydWI8JWPxxXiv3MxrGnW0b+v1gX57+jU5JuxM4jZgxQwL8bwRKdvtx2RqLhcw05EWx3OHJJc2ZNYJKrOOpWWDFBzJ3W02SrhrvoD4/fDWS3DdpgZXwb7bu7ra0O+mNvG2n5WDQrKfoO8lRzUxvgp0ALNimojbj9ZmXsjFodoQJata50BKj2OPQN+fb9W4MbRjydgU4gWfbehlenJ2z6jMQ2z9xN3FQ/NdqD0fa5T+A6PvVt0w5hjHxdlVY8wrDv3WZy4s+c6nTCn4bEwrhVnw7SnwcIcRQivBHcXOWrEioesdqFkmkodmAVsklt78y9ggVFf26V7psZN7W6Gf3iHcaB6UnDKd6mprcOiTGGCayScvqttpBoxGXUR7vVk40VW8r9CZgFMeQTIXbLwFwIE4KWs5F+pii+ii/Zk1ysENj6FrpoVSmPEk7SADXILBrrPiRTQ9DfKc5xiA0TProZE6i/WtjPL5CLR7FNAvkaUPEy7H4CgYMpafqvFdpLFb5n7OuPE0QvK+UZCbCv3m9sIAhVo/ooQkBlJ4wgEqv+3/UyrkE+IpEByiKxyrbhL6RPvQwvbXSb/tZtD9MydNoFkZV2NKruN/tBinoOjyzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(6486002)(2616005)(31696002)(16576012)(316002)(38100700002)(26005)(7406005)(956004)(86362001)(921005)(8936002)(508600001)(966005)(36756003)(5660300002)(54906003)(2906002)(110136005)(31686004)(8676002)(66946007)(66476007)(66556008)(7416002)(186003)(83380400001)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFNCU1ZmWkhzQ3pRdzdPbk9KZktRTU9ic0NRT2p4WHlLVEVBbE1jNXhxaWFs?=
 =?utf-8?B?VUphOVE2Sm9UV3F5YWh2aC9MMERGOTJjMUxwWStyT0hYMjh2WTBKNGJveU0r?=
 =?utf-8?B?TFh2WWVld3BxWHE1LzRoTlBqM2h0K1JGOWdYRVczYVhvT2RQdTdTZ2g5UGNK?=
 =?utf-8?B?L3J2ZGZjUEZValQ4Zk54bEVlZ1picEpXNHdaa2JPc2ZVVTZNRUdMVzVEdnNt?=
 =?utf-8?B?NWRHRi84SHIxVU0yWUJJR1RXeGpKRVBkc0JxeGVEaGNBUnVZSFlWV093QjUw?=
 =?utf-8?B?RjhBZndWUWhzWmRiaVk3Z1BlTnBWdnliRWVqMlllcHNZcmV1aXpNbWFQT2U4?=
 =?utf-8?B?S3lyM2ZvMFdxcEZzTVg1WllwdDgrbXBqZGhkVlNRNWQ3dW9CWkFDeEdiOFkv?=
 =?utf-8?B?TDRWcXB1OFRraFE0RFlVK2s0R1V3dG9TbFo3bmU4dmtLUWZCZVdTYjJ4U2lB?=
 =?utf-8?B?QlY2R0xtSDB5czhMeXN6TzZpMVVuVGlYNkJwRk5NRE1XZnhrdmlzdU5FbXBn?=
 =?utf-8?B?bGRyd05hcVdPekZoMTkveVNpSVluRFRjVExEc2lBeHJTRm8xdHFyUnpad3pn?=
 =?utf-8?B?d2FlYTFEWWF2TCtGRXVSa0JuWjRnT3F2bjV2ekRWWG9RUDdiMVFpVWJDSW8w?=
 =?utf-8?B?TGc3NmM0STNkM2c1THlEbEtFMUVBa3dESVdIbGlzRldKMG9tWno2ZE93bkZP?=
 =?utf-8?B?UFpKbFFyeGlRUlJtV3NNZnk3R2NWaUx3WmVRbE84RjR4TWsrWXFMS3M5TVVK?=
 =?utf-8?B?YXhJdGZ0eGt3NnVIeUhRaHV0UUpxWG03R1ltSmxaUW9ycjlrSFBOeklWS3lC?=
 =?utf-8?B?a2VhR0hja21EaUFBS0xUYU52UWhLUFo3NUFVOW1rUlozdjBoOW5iK21DOTh5?=
 =?utf-8?B?NmFyeEljcE0yRzBTNXlKR00xZXJibkFOUm85dkE5SzcxQUVaNGhveTJYOFZO?=
 =?utf-8?B?dG93QXhPbEswYTgzeGhTbE10d1NvMGdtMWZ1WXFESjhaR3JDU1hPR01XT3dZ?=
 =?utf-8?B?eGJZd2E3a0Raa3c0TWlpVm43T0Fqbk5qeWJYeC9ERDJ2QjhaNlBweDF4STJL?=
 =?utf-8?B?RUhiMWp5V0Y4czNHaUIxakdJT3hBZktjZWNhbElHdjY0a2VlbnM4QTFqQjdh?=
 =?utf-8?B?b3ZRQnVUL09TT29nM0RLcE1pemExVnpUT2pRSmREbnl4VnNmVGlZcGYyZWZs?=
 =?utf-8?B?TDhYQVlpS1liZUtjaVRPZjhNQytMaUY0SmhCU0ZLYUtoQW80RVI3ZlFGbjBH?=
 =?utf-8?B?VnAxMUZEaWtrQ1BWSUw5Rmk3ak5pVldZVlZrMXlESHE2ZFJHVDNsVHlLd3ZC?=
 =?utf-8?B?L3hZK3VqK2Z1c3ZQcGhjQ2pFRlFrQkdWOVdsVm0vakQ0V1l2QTI0clg1SVRp?=
 =?utf-8?B?SDlET3VWQnFXQlBBNURqU2xDc09ZMklVWnVoYkh4MDRmYzg2bzRWM0JHT2dx?=
 =?utf-8?B?UDkrK3RuS2pyVEs4UzVEWmh2aXZZRDE5UE9kSXNWNW4ydFF5ZGNUWUFTT2Q1?=
 =?utf-8?B?Z2xRTUpIT1pLZGF6Y2ZSNTkyMWpRWTI2QW9DRTU3QjhHZnBadTZ3Y2QrVzd4?=
 =?utf-8?B?eDczbjVQT1JodnZNejZ5eVUxSUo2U0h0bVdiL3JwQ1pISjNhU2RtdGVNTDdE?=
 =?utf-8?B?anZJb0I3UFVyNE5WSCtRL0VKWE5UQUZQYkdMbU5VaXE1ZFNlR3NUOVpDMita?=
 =?utf-8?B?TlVCVmhueUQzR01xeVMrU2xBbTd0eEhtSE9xTGtROTUreXk2MHlFMnZweWw5?=
 =?utf-8?Q?10sqkYIiNMSJ1gwl9W3FZ1XoM8eDy4WcghABRDb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7ee5c4-4be9-4ffc-0973-08d993e43f4c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 16:11:17.6038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5534
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/8/21 7:36 PM, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Intel TDX doesn't allow VMM to access guest private memory. Any memory
> that is required for communication with VMM must be shared explicitly
> by setting the bit in page table entry. After setting the shared bit,
> the conversion must be completed with MapGPA hypercall. Details about
> MapGPA hypercall can be found in [1], sec 3.2.
> 
> The call informs VMM about the conversion between private/shared
> mappings. The shared memory is similar to unencrypted memory in AMD
> SME/SEV terminology but the underlying process of sharing/un-sharing
> the memory is different for Intel TDX guest platform.
> 
> SEV assumes that I/O devices can only do DMA to "decrypted" physical
> addresses without the C-bit set. In order for the CPU to interact with
> this memory, the CPU needs a decrypted mapping. To add this support,
> AMD SME code forces force_dma_unencrypted() to return true for
> platforms that support AMD SEV feature. It will be used for DMA memory
> allocation API to trigger set_memory_decrypted() for platforms that
> support AMD SEV feature.
> 
> TDX is similar. So, to communicate with I/O devices, related pages need
> to be marked as shared. As mentioned above, shared memory in TDX
> architecture is similar to decrypted memory in AMD SME/SEV. So similar
> to AMD SEV, force_dma_unencrypted() has to forced to return true. This
> support is added in other patches in this series.
> 
> So move force_dma_unencrypted() out of AMD specific code and call AMD
> specific (amd_force_dma_unencrypted()) initialization function from it.
> force_dma_unencrypted() will be modified by later patches to include
> Intel TDX guest platform specific initialization.
> 
> Also, introduce new config option X86_MEM_ENCRYPT_COMMON that has to be
> selected by all x86 memory encryption features. This will be selected
> by both AMD SEV and Intel TDX guest config options.
> 
> This is preparation for TDX changes in DMA code and it has no
> functional change.

Can force_dma_unencrypted() be moved to arch/x86/kernel/cc_platform.c, 
instead of creating a new file? It might fit better with patch #6.

Thanks,
Tom

> 
> [1] - https://software.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-guest-hypervisor-communication-interface.pdf
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> Changes since v4:
>   * Removed used we/you from commit log.
> 
> Change since v3:
>   * None
> 
> Changes since v1:
>   * Removed sev_active(), sme_active() checks in force_dma_unencrypted().
> 
>   arch/x86/Kconfig                          |  8 ++++++--
>   arch/x86/include/asm/mem_encrypt_common.h | 18 ++++++++++++++++++
>   arch/x86/mm/Makefile                      |  2 ++
>   arch/x86/mm/mem_encrypt.c                 |  3 ++-
>   arch/x86/mm/mem_encrypt_common.c          | 17 +++++++++++++++++
>   5 files changed, 45 insertions(+), 3 deletions(-)
>   create mode 100644 arch/x86/include/asm/mem_encrypt_common.h
>   create mode 100644 arch/x86/mm/mem_encrypt_common.c
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index af49ad084919..37b27412f52e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1519,16 +1519,20 @@ config X86_CPA_STATISTICS
>   	  helps to determine the effectiveness of preserving large and huge
>   	  page mappings when mapping protections are changed.
>   
> +config X86_MEM_ENCRYPT_COMMON
> +	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
> +	select DYNAMIC_PHYSICAL_MASK
> +	def_bool n
> +
>   config AMD_MEM_ENCRYPT
>   	bool "AMD Secure Memory Encryption (SME) support"
>   	depends on X86_64 && CPU_SUP_AMD
>   	select DMA_COHERENT_POOL
> -	select DYNAMIC_PHYSICAL_MASK
>   	select ARCH_USE_MEMREMAP_PROT
> -	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
>   	select INSTRUCTION_DECODER
>   	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>   	select ARCH_HAS_CC_PLATFORM
> +	select X86_MEM_ENCRYPT_COMMON
>   	help
>   	  Say yes to enable support for the encryption of system memory.
>   	  This requires an AMD processor that supports Secure Memory
> diff --git a/arch/x86/include/asm/mem_encrypt_common.h b/arch/x86/include/asm/mem_encrypt_common.h
> new file mode 100644
> index 000000000000..697bc40a4e3d
> --- /dev/null
> +++ b/arch/x86/include/asm/mem_encrypt_common.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2020 Intel Corporation */
> +#ifndef _ASM_X86_MEM_ENCRYPT_COMMON_H
> +#define _ASM_X86_MEM_ENCRYPT_COMMON_H
> +
> +#include <linux/mem_encrypt.h>
> +#include <linux/device.h>
> +
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +bool amd_force_dma_unencrypted(struct device *dev);
> +#else /* CONFIG_AMD_MEM_ENCRYPT */
> +static inline bool amd_force_dma_unencrypted(struct device *dev)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_AMD_MEM_ENCRYPT */
> +
> +#endif
> diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
> index 5864219221ca..b31cb52bf1bd 100644
> --- a/arch/x86/mm/Makefile
> +++ b/arch/x86/mm/Makefile
> @@ -52,6 +52,8 @@ obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)	+= pkeys.o
>   obj-$(CONFIG_RANDOMIZE_MEMORY)			+= kaslr.o
>   obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
>   
> +obj-$(CONFIG_X86_MEM_ENCRYPT_COMMON)	+= mem_encrypt_common.o
> +
>   obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt.o
>   obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
>   obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 23d54b810f08..5d7fbed73949 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -31,6 +31,7 @@
>   #include <asm/processor-flags.h>
>   #include <asm/msr.h>
>   #include <asm/cmdline.h>
> +#include <asm/mem_encrypt_common.h>
>   
>   #include "mm_internal.h"
>   
> @@ -362,7 +363,7 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
>   }
>   
>   /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
> -bool force_dma_unencrypted(struct device *dev)
> +bool amd_force_dma_unencrypted(struct device *dev)
>   {
>   	/*
>   	 * For SEV, all DMA must be to unencrypted addresses.
> diff --git a/arch/x86/mm/mem_encrypt_common.c b/arch/x86/mm/mem_encrypt_common.c
> new file mode 100644
> index 000000000000..f063c885b0a5
> --- /dev/null
> +++ b/arch/x86/mm/mem_encrypt_common.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Memory Encryption Support Common Code
> + *
> + * Copyright (C) 2021 Intel Corporation
> + *
> + * Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> + */
> +
> +#include <asm/mem_encrypt_common.h>
> +#include <linux/dma-mapping.h>
> +
> +/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
> +bool force_dma_unencrypted(struct device *dev)
> +{
> +	return amd_force_dma_unencrypted(dev);
> +}
> 
