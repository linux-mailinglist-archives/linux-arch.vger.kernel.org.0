Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BFA434F9A
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 18:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhJTQFd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 12:05:33 -0400
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com ([40.107.94.55]:51296
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229817AbhJTQFb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Oct 2021 12:05:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pfqx6ns9LbeXBH7ek8M3C2dSZnQLWzaWxS9YymrjUtKpCEB1oHlh//YPewQ4cLDmWaZYduwI0IIc9gp+LYYktx6LUjR6hGbFUgNYVfVVI/FNi0/qtFBF229HKvQmE4LTzSAxG16ldvUyIJfSio9MNwFpfG50S0UfzZ/Srbq1spAXK4bEAXepxSgOhOmAQV6gyyjK98tczdB0kV9bWHa1ZQToRBA5GbSr16h2XrWLHWYBNpfPOI0C6XgORY0q2ibke6VJQt20kOsrpgebPzmBdUS6Tf6EPBwVG8IHCWObkd91HVdv1gZek6xCZVokvY3c6cVSygurCXs37lt8tO1Qbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUtCmAXJnjPw+60UgGY4uROjWBTe4BgjhJ9QXCIV9rE=;
 b=P2kvW+Ie1YcGtdfCQ4lk+8bQJFYpo1TWymAx9K695HBeyQC0B2+ZtSKE3Edhfq7f4iVsrMdpMdM2Dwi1LO0Az2J5A24UR/kTLeD4SIvn29dBuDI2xTm/mwo45NPd3crE28FIfc0iSbnJOnITP56rRlkA9E1q7CwY8kG8A+tshPjWGLexVFkKXau6Sknp7ZFpLTcTQdx7d/a36vPXKVBGTTbQ6wlEuA/Pt5OssuDWPP/Tck2Fh9Ystn3Ny2Fy2+Vi2IK2xN8Yvh1u/HlRCFwVqcnqkXxkxbO6W/1rGzDcJ7B558wvFzrtdwL7PM1A3t52lMYeY0mr1mUHUG7/tiEXXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUtCmAXJnjPw+60UgGY4uROjWBTe4BgjhJ9QXCIV9rE=;
 b=HcntIX1iZOk3VMd85HXB9B+cA54CQNXaf56eZG8gsPfRIKwx5qav4+flJeKSkCujdhwtwetE0IDHNgyHpw+q7YnP5h4/MX+pDQgMskoH9nov0zviSrml6GrtNxbHybJlV7He79QjR33BTctfJQ0VnS9cpDep9P3Ip872DGd2KH8=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5085.namprd12.prod.outlook.com (2603:10b6:5:388::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 16:03:12 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9%7]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 16:03:12 +0000
Subject: Re: [PATCH v5 04/16] x86/tdx: Make pages shared in ioremap()
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
 <20211009003711.1390019-5-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <8c5074f7-5456-e628-5a09-a3a4b4f381fb@amd.com>
Date:   Wed, 20 Oct 2021 11:03:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211009003711.1390019-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::10) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by BL1P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Wed, 20 Oct 2021 16:03:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ea36c98-d478-4428-cb26-08d993e31e12
X-MS-TrafficTypeDiagnostic: DM4PR12MB5085:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5085943AF6162327962A458FECBE9@DM4PR12MB5085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0dy27w33vcRk5GnAGDYv02bwTsUGVHO4YmCd458EbMe+Up5GEDuGSNUw4pWo1X2SQwijgT9xk9z/tO+0qK4p7mNQbbv4hdf+FrNBv6ntDI7SGIqdbn0l3QQkKs6fXUuRuASth+0WlhgR9OfuorvIcOA4hN25+U6Ej/U1TLnEpYiaFTVgYUOKCBWXCPR04K4cPxLH9bSp5xpj6fwur8vEtrdOYVH+BsqH6B15hdymUNUJoknG8GGTLXD6nBN15m/Vt/AcjpQuD6PH5jKwda9XWJtajBKwTMAvFcPjDyjfQzMYwzr4Ize60KHdldx626/YjgNfDexgnh0eG+4QMBHRmFLR8TwbtH6wW+31R9nzmEb/MPWtMxUwHKgJ6gE08Icm/E7QK0jeVwX4RnTkVlPtjMSJiFzoXOTc3C1hFcmNiVAShay6eMma5qSoFWF7klrW1CtoMvuIt8NaNaeRrURbGl9kEXG3xluW7qmVIf0KoCKISujEMAwywo/i+jyupJJ7li6tbN5O06YfoJCktP3cm5vPuhY6bt8ym7srXNHafIBZD+9y0jxDK006Xg2shd8wuR7kAYQQQnnS3Bs1mF8N9V5kr3m8YtugRrTdHZ/PA4Q6Ju6hhnYc2siJXCvRqbqBgF4A98LSWZyzQdyEscVtOxl1b8LoDxLrkCT5dmeWJazhM89+C5q9+v+i/sm7vsA8JEu/uYTMgsANNQiqkYYDwQ7OdS6iNcJ5m107zy4MpaSvnDD/xIoVCxPDPqK6VVW+krhcTiCZhvB6VYuYAY42UaBQviCIBdup0sCwUSszByIrhXfJjrr02pFfrCuWChtVXRkxhdnzShwXvpRPUtBPo1NhcjU7ANFXl04odXKsntY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66946007)(4326008)(921005)(53546011)(7416002)(26005)(7406005)(2906002)(66476007)(36756003)(508600001)(83380400001)(16576012)(5660300002)(316002)(8676002)(2616005)(31686004)(38100700002)(186003)(86362001)(6486002)(110136005)(54906003)(31696002)(8936002)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTMrT24yUGJwb0FDSXI0RjhwVjhMc3JQTm1PaUgyS3Z1bkNzSXREMi8yaUgv?=
 =?utf-8?B?UmZiT0xpNStNUWtSSUZQb0pQTTBvakphWDJqQXRidVl3MWlNdkpFeVo3Rjhy?=
 =?utf-8?B?SjlYQTNOU0FSL0dVN3l4VW5XN3ZNL3NLWVhKUElFL2FSMlR6UnVEME9lb1Vu?=
 =?utf-8?B?enRET2k1MDBDZnU5cml2Mk9SdzFyNVFsbnl6aEw1YWhxVTJ6WnViQmlxOUlY?=
 =?utf-8?B?VmFadU05d3dEYlNNYmljdmxwamdFTHZyTzZVMlV1NGdCeHRPRHNScDNoNlZL?=
 =?utf-8?B?YmN0TEUwZjVyQWRNNEUwSisrMmdpZmVaUWJhditNTGd5dGdiQnFJVEROTmha?=
 =?utf-8?B?dUIvL2IxeGs2cTlISEFMSStZZ2RaWmI2bEZKbWwxTDdPaThLeXlvTnF4ZG5p?=
 =?utf-8?B?RklVa0pCbU5vMk54SmRvU3V2VHJCV2tEYytiNjhmaXFJYm1xMEFsUlVCMmNi?=
 =?utf-8?B?V3RSTUJja2NUSnoyem9aYUJ1bDJoai9pYmlOejQySmRjZ0MvQUdtRmw0anc3?=
 =?utf-8?B?OCtWRVcvWGNFQmcvTFdjdElPSk9ScEhZS0lCOHJLd0d2ZG1Vd0g1bzc4ZGRE?=
 =?utf-8?B?ckxUbFg3TC8vVzlsZnJLdE4wSlZTYXlGVHRDM0Eyb2RVeHFmQitQazJoeFlI?=
 =?utf-8?B?OVh0RFc1Y3ZiM3g1cGg0bDgvMjZJNDdPaEFiWk9uYmV1WkpyakYrTlBxdjlP?=
 =?utf-8?B?THRQd21yOHBZdzhTL1N0dHRubnZQZWhFcFBRZGZROE9IQ2tNNzgzNzJZZzgr?=
 =?utf-8?B?eWdNRTE2bEw0V2VWcnVoeDZHR1BVQWI5am5lcjQyR2FEQzRXeG41cHJQZ1V6?=
 =?utf-8?B?NzlaaERvQTZLWGU5aE5Sc0h3VGY4Q0dQZStaVkl2MVYwS25tR0pGR3NCQnN6?=
 =?utf-8?B?ZlIvRFdyMmRwcFdiZURjVXBFclZPdkVNVUFobmpqNjZ5M2FIN0F4Q2trbUs1?=
 =?utf-8?B?elBwQUJ2dzJYSDdTdnJRZHA0UHcrWGhybGNtOG5ZZ0VPMUFzcy8xcU85YzNY?=
 =?utf-8?B?NEZydXRUMzlUWlhPNStnbC96dDc1T2dwL2p3UFJram53cDlXSXZoUExZNVZM?=
 =?utf-8?B?MENtaTFYelJZOFNiLzErZ2xZbkpnelJYNlVRZkhQNGdkbmRJSUxIVTVKZFRQ?=
 =?utf-8?B?bHQzVGNmZEZnTWNyWHZEZHVwV2NGV3BNYjR5d0hDQlVXQW93Kzl6ZkJRSUxa?=
 =?utf-8?B?UmZMV3RwSDVUaHFJSlBPR1lZY3hEK3ZhUVMybVBMQVJ6T3NpdlhPM2hCelJL?=
 =?utf-8?B?cENDMVhvMERrSk9kQVRmSVU2M1hmeXAyWklOaFVOekFpOHI4VHJzRDdKV2ll?=
 =?utf-8?B?UVcySFhtWnRuWGRTRGFsek9ZZTNGSkZNUG5yV0IyRnBRTWYvVzFtZDhWNElM?=
 =?utf-8?B?WVkxOTR2NUtIVnkzUnVvYW5qZUQ4OTdWN2FZbWNiMm4wZUNhcmlra3ZDbUVQ?=
 =?utf-8?B?eDJOVFgrSmtURmc0bE1UUHdoakt6Q0ZrT0I3TFZHQ0NPaXVBdFFjdXUzbnZB?=
 =?utf-8?B?ZkFQNDFhVmZRN3duY0Y1MWYvbGU3dVRVOVljTFQwRGVHWU9uME9RVUFBL1hu?=
 =?utf-8?B?L08rMFVxdE0yRW9OR09QcExCeWF0V1JQOU9ySjJjeVhxT0NTVmhqcEtJOFNR?=
 =?utf-8?B?K2tvRVd6TUI1UXEzSmNNMWo2cUd2dGJMZHF6TFlBTk5KSnZ1RWpvcHdzdjB2?=
 =?utf-8?B?S2hMb1g4cWZaaVdEeitoSDVoRjFMS0htT2xiUUpEUmYvYTFWZ0lWZnNxdHpj?=
 =?utf-8?Q?NE7R8of7e+QKEoP2ByfT1wNgNMeHHODqzKL5iMv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea36c98-d478-4428-cb26-08d993e31e12
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 16:03:12.7723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5085
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/8/21 7:36 PM, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> All ioremap()ed pages that are not backed by normal memory (NONE or
> RESERVED) have to be mapped as shared.
> 
> Reuse the infrastructure from AMD SEV code.
> 
> Note that DMA code doesn't use ioremap() to convert memory to shared as
> DMA buffers backed by normal memory. DMA code make buffer shared with
> set_memory_decrypted().
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> Changes since v4:
>   * Renamed "protected_guest" to "cc_guest".
>   * Replaced use of prot_guest_has() with cc_guest_has()
>   * Modified the patch to adapt to latest version cc_guest_has()
>     changes.
> 
> Changes since v3:
>   * Rebased on top of Tom Lendacky's protected guest
>     changes (https://lore.kernel.org/patchwork/cover/1468760/)
> 
> Changes since v1:
>   * Fixed format issues in commit log.
> 
>   arch/x86/include/asm/pgtable.h |  4 ++++
>   arch/x86/mm/ioremap.c          |  8 ++++++--
>   include/linux/cc_platform.h    | 13 +++++++++++++
>   3 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 448cd01eb3ec..ecefccbdf2e3 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -21,6 +21,10 @@
>   #define pgprot_encrypted(prot)	__pgprot(__sme_set(pgprot_val(prot)))
>   #define pgprot_decrypted(prot)	__pgprot(__sme_clr(pgprot_val(prot)))
>   
> +/* Make the page accesable by VMM for confidential guests */
> +#define pgprot_cc_guest(prot) __pgprot(pgprot_val(prot) |	\
> +					      tdx_shared_mask())

So this is only for TDX guests, so maybe a name that is less generic.

Alternatively, you could create pgprot_private()/pgprot_shared() functions 
that check for SME/SEV or TDX and do the proper thing.

Then you can redefine pgprot_encrypted()/pgprot_decrypted() to the new 
functions?

> +
>   #ifndef __ASSEMBLY__
>   #include <asm/x86_init.h>
>   #include <asm/pkru.h>
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 026031b3b782..83daa3f8f39c 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -17,6 +17,7 @@
>   #include <linux/cc_platform.h>
>   #include <linux/efi.h>
>   #include <linux/pgtable.h>
> +#include <linux/cc_platform.h>
>   
>   #include <asm/set_memory.h>
>   #include <asm/e820/api.h>
> @@ -26,6 +27,7 @@
>   #include <asm/pgalloc.h>
>   #include <asm/memtype.h>
>   #include <asm/setup.h>
> +#include <asm/tdx.h>
>   
>   #include "physaddr.h"
>   
> @@ -87,8 +89,8 @@ static unsigned int __ioremap_check_ram(struct resource *res)
>   }
>   
>   /*
> - * In a SEV guest, NONE and RESERVED should not be mapped encrypted because
> - * there the whole memory is already encrypted.
> + * In a SEV or TDX guest, NONE and RESERVED should not be mapped encrypted (or
> + * private in TDX case) because there the whole memory is already encrypted.
>    */
>   static unsigned int __ioremap_check_encrypted(struct resource *res)
>   {
> @@ -246,6 +248,8 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
>   	prot = PAGE_KERNEL_IO;
>   	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
>   		prot = pgprot_encrypted(prot);
> +	else if (cc_platform_has(CC_ATTR_GUEST_SHARED_MAPPING_INIT))
> +		prot = pgprot_cc_guest(prot);

And if you do the new functions this could be:

	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
		prot = pgprot_private(prot);
	else
		prot = pgprot_shared(prot);

Thanks,
Tom

>   
>   	switch (pcm) {
>   	case _PAGE_CACHE_MODE_UC:
> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
> index 7728574d7783..edb1d7a2f6af 100644
> --- a/include/linux/cc_platform.h
> +++ b/include/linux/cc_platform.h
> @@ -81,6 +81,19 @@ enum cc_attr {
>   	 * Examples include TDX Guest.
>   	 */
>   	CC_ATTR_GUEST_UNROLL_STRING_IO,
> +
> +	/**
> +	 * @CC_ATTR_GUEST_SHARED_MAPPING_INIT: IO Remapped memory is marked
> +	 *				       as shared.
> +	 *
> +	 * The platform/OS is running as a guest/virtual machine and
> +	 * initializes all IO remapped memory as shared.
> +	 *
> +	 * Examples include TDX Guest (SEV marks all pages as shared by default
> +	 * so this feature cannot be enabled for it).
> +	 */
> +	CC_ATTR_GUEST_SHARED_MAPPING_INIT,
> +
>   };
>   
>   #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
> 
