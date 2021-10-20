Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD3743502E
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 18:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhJTQfi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 12:35:38 -0400
Received: from mail-co1nam11on2061.outbound.protection.outlook.com ([40.107.220.61]:33312
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229817AbhJTQff (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Oct 2021 12:35:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbVoSV0r8GDgdInozEEEMh76pEfAZ6yXQIFL43B9i7IgSIxyHWsCw+7bzbeIA11TB/wy1QLGefptoUNDAhb/ipaflZJTkIoubfScQGdLMKIM2kG5cbZnZFmmAUj6+dewJe22oY9aQo3Hp1oMuDKAUnV0lcs28om3OipjLEM2aynn9u3Wg5rySbucszVhxbVKHplX2pdTIaaCSFSO8dLJwHfoGgRufWh3v8TjAuPhqYKuaWUeP2+zQjap4Ix242SmT8PIFmwIYIpzKu8KFrsh6uL98fD6qr+kwF185LZIgjQOULG7e1f/xv2Shzee0/D8cfR4Xtbz5fVAcl5w8H8H1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=le6PRjWVcNiZAv9Pe+YpzbK8xwwzgS0gBiPn3/Norso=;
 b=jqm66lEcG3tZcPs0TX6nf8pgJOjFBxg32KrlUhCGcUTxO9BjjgWgw7+4gXaaiGpfxdE9pnEjAIwe6ycjBUBhs+7FOJhty9PWB/mlqHtyVlstay08jG/AhFE98wgH+luQkddrB4Bqn7IkiMhiIGO5SQ4TjNl2MUHS75bD1831Ohal6UZ88N/9iETNjSpzvrpkOJCp5IGPNDFqKZaiAmAJnpNWtPAL8jP1pfTEkeSzj9SkjMP5jVBNqh7STBbs/F3sL2hMKBeocLBlfP2I3gcPwPPorUxB9WA9ztldbVhNrW2aEUQGFuS7jABVjR74udu+O0oGHVuqq/hv/KEM7COvFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=le6PRjWVcNiZAv9Pe+YpzbK8xwwzgS0gBiPn3/Norso=;
 b=0Rhiw6/1NIcZi2e+wprcsE2gSatZNrHjh0j2ZnQmV877dL8kgEEDViIdtNKKg9B7vRlPCPS3U1qx6r/emBIDNMMUDtTSJWJu7wtKKEj5wwzb+fI7VjQFA6fDJyKkkaGHt8NydP9hwKNIylWtaCq7DiBouz1EfGF1hOMIsS1dVAA=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 16:33:16 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9%7]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 16:33:16 +0000
Subject: Re: [PATCH v5 06/16] x86/tdx: Make DMA pages shared
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
 <20211009003711.1390019-7-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <654455db-a605-5069-d652-fe822ae066b0@amd.com>
Date:   Wed, 20 Oct 2021 11:33:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211009003711.1390019-7-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:610:77::24) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by CH0PR04CA0049.namprd04.prod.outlook.com (2603:10b6:610:77::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Wed, 20 Oct 2021 16:33:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01b379fa-a0f5-41db-c9b6-08d993e75144
X-MS-TrafficTypeDiagnostic: DM4PR12MB5391:
X-Microsoft-Antispam-PRVS: <DM4PR12MB539102C1498A742989959C0DECBE9@DM4PR12MB5391.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /gMnQeN560BInQlUElAMbGPjgxuk3S6Ir8HDe22dyly5TXuQ1pn9S9RnXdOMWq3oVuTOvsaTTyA/T/Y+lB+SSq6ozlwafUMMoj6IEBWT+yex5GV8vmV285DPdlN2Z1aGxIIVzrnSaxtISkMio3yXkNBMprgigi+JaQipURaPNSlZDvgrf5s2JTM3cT+bG4MoO4RBUKpL4cWt/krmWfVHjdcu4dHIjh8UohXeGi9wLqHdeCuHg3wgEam+bJvD34Bw9KGMY7TTxxbJdxVIy8Q9ikBbnNWrlyNWwWDOJ8n5kB/W+lrQPXiFzmXzN09D+357PyS12vvHm9P+o1mGTpuAosTfFImWxiSzMdspGY1qDP/ADgkWlZX7NNurD8x7VdMqIxAyZrmeaWMdIOtcS5pcZS7xYhXH77heCj3MCC7lEwNDaafoyPHwXFtWgXTMAeNcPnHQSa/6bJnBSl4Tu4LjGUNMY14MQhaSsKwKCQjQGXCdvX+lXQN35mnI5pfruWFCAIbdZvP+FVoKEUM8ZahCBLAdfNn+jYVl0j+3pZKcIxbjphYxDeqUpHTPKgWK1vxLdaokUibEkChiSNrD5pu1Rdbn1Zbyan9k5Cik7hGG2ZgazP4cBjXrnZY5owgCQbk4OoXck6UdABZqOrfM+Yabe3gRD4T5ZYLape9X1PhjjY2+tldA0qUIeemd3jhA8pRs8VOirk+ldxxNKDTrDVMckc0UCLfoJ/75VIy9/k5UMmC1AEF/KugcsGrQexbJuLcRLg8AcHdQ3HNl5aaCkvi4x4RubollOHoZWbiLJUETnEBvOnSL/hguFtEomazqjR19Pt0HWFewU/SNXpArnnMRHwRlBn1xXFB0L1C3PGF4Ot4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(45080400002)(66476007)(86362001)(110136005)(53546011)(7406005)(26005)(316002)(2906002)(7416002)(16576012)(36756003)(31696002)(66946007)(921005)(186003)(54906003)(83380400001)(4326008)(508600001)(8936002)(8676002)(966005)(6486002)(31686004)(5660300002)(38100700002)(2616005)(956004)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Njd5eXIwME5tenhxaTlTNUlDRVI4ckw5Mmkvakwrb2pZUFFTV29tR3cyMUp6?=
 =?utf-8?B?SlFlOHpvOW9XN1JMcGhrLytJODQvQ2ZPalBzU3ptTnRYL3VOaXRQL1gvcEsx?=
 =?utf-8?B?YUlETjJLZ1ZHRWhhNTVxTWdMMWc2MURVdUVEWi9MbGNQMjY2bFIyVXBpVVJU?=
 =?utf-8?B?b0pEK1NnNnNMR3RmaEFqdmRwK0dsNVI5dHBNWGpIWVFTcDVacUpDcjhMRDg0?=
 =?utf-8?B?L0ROY1ZvSUpzbHlwRlhYZytsOC9wdHY3MFFIL2d6SS90MzgzZ3MrMUhBOTUz?=
 =?utf-8?B?Zkp6ZE9IakI5c2g3M0pyTENHTzhrb0V6bjNWU2h4MmU5QmFnQUQydFVZamNu?=
 =?utf-8?B?bVQ2ckpvTlI5aGxWYUVQb3pZL2d3NXg2YTZwRnMzaGJJNUJldlFrZFVHYkZ0?=
 =?utf-8?B?YVZwWGUyTTNEV0RlV3VFV3E5V2JBWDNmWUtHY3FleTcvSDBWczJESWNjVW5X?=
 =?utf-8?B?S1oycDZCcjZ0MElRWXMxSGE0czVuRFFSZFZDaVh2clFrZDZyN3FCRmRmWUUr?=
 =?utf-8?B?dm5TQUVEUUMrVlRhcWFKSW1HbDZxM05yNyszV25FZUk4SytqQmo0NTNDejNU?=
 =?utf-8?B?VEpxenFlVUgxZG11VlFwclVKblZMZEZRTTZ6YkNYa3N2aTNoMnZxd2hmbHB6?=
 =?utf-8?B?UDJPREFoRzNtRFRiTTFNZkF5SFJPYnIxQ2REQ3p5cjNWRSszN3BJV2hLZHp6?=
 =?utf-8?B?ZTYxTm1IbUNqNEJBSzg5eGM5akU2MW1LNkZPZ1ZmY3dHOFZuQ21jMEdURGdS?=
 =?utf-8?B?c2c2OGlIbFdvcDdpSXlUUmxPOFNKaUU1cDJBeFJVVzFDMWF6Nk9wUlJuY3M2?=
 =?utf-8?B?STZRUVVMdU9BZ0FNdlQ4QzFMQ3RHSWJKaENKR25JK05WM09kTVNyWU5CVnVW?=
 =?utf-8?B?M0hHUHZwdHUrNkRzZWFsNDhOUERJTnRSRzZSMFJVMnZ0VGR0VXgwRndmNm5Y?=
 =?utf-8?B?eTNYUTVVWmFQcUVhaERCTHdWVWFkMm1OeVJtZnNrMkFMRDZJUWFwNEsxZkwr?=
 =?utf-8?B?djNhYU9MTWRzMU9KNFYxdUFOV0FLUXdxTm0zbVRsTFFFN2s0K0lpNWtTNEFy?=
 =?utf-8?B?TTU2aEc1YUFYUTlCUXE3RW1pVFBOTWRxZ2FwS0t6UXNyNmdRYUpFcWFHaENZ?=
 =?utf-8?B?cmk2eGpDbk9mTjlvRGNLN054NUJDck9OMHh5S0VCQnZYSFdkQ0dmWmlqWWxp?=
 =?utf-8?B?STFjRXhLYTlXTHhiWlBoTnI4WFlVSkpvYWpubWFhUkwvODREcVh0V21nK2dM?=
 =?utf-8?B?STN1Q1NpVlBUa2lHSWR6Vnhza1grSGRvbjd0WlA0WEpwQTFhZU5uWEdBcXBm?=
 =?utf-8?B?cVBQUTE2TWp5NWM4M3lRNDZxbjlWRUNQWTU1a0JGZ1RyZTA1bXhYbzZZSS93?=
 =?utf-8?B?QlRvczkydG50VTJxQ0Z3cUtibFFtT2tRWitVakJUaVBmbkRjdnFzbGhvQWJD?=
 =?utf-8?B?bDZ2eFh4OS9HdWFmSzBxQ0syb1ROODU4US9tdTI5SkxuWUxrOVRWbGRCekJV?=
 =?utf-8?B?U2RKY2V0U29uMi9yRGI3NEZHdlFnTnBKcXB3NXV3c2xBVmE5VHpuWFA1Q2FQ?=
 =?utf-8?B?dW14MXRYc2NSdW52ZHlZTXdRWVQ3VHNJcDhiSW44aERteUhVUnFKbUovSmlk?=
 =?utf-8?B?T0lyTjVqdUU2MFZlVUkwZzFZZXV3Qm9CbHhpeEszNWhRRk1GOHZ5MmhEempv?=
 =?utf-8?B?VEZEYi9NY2xHVkFpalM4ZlQvWlRuUE51a2hGNW9NbGNZVXI2RlZaNWlSTmtK?=
 =?utf-8?B?SDJOeGNlN1RkVk5zcDRIeHV5MEtPNDZkaytsUEJGSlJZcnJ0QmZXbjA1Q1hF?=
 =?utf-8?B?eXA0R1ZrT0tnMUZ4MzV1QnZ3dmsvQzlpNXRnL21sWUcwREtuNWg0NjJGZ0lu?=
 =?utf-8?B?akovQUVRWTE3V2QybFoxNkJSN1R6QjFXa0YyWEZQTWowaGNDdTRXSzlnOFB0?=
 =?utf-8?Q?7n8cs8ypMao=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b379fa-a0f5-41db-c9b6-08d993e75144
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 16:33:16.3879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5391
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/8/21 7:37 PM, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Just like MKTME, TDX reassigns bits of the physical address for
> metadata.  MKTME used several bits for an encryption KeyID. TDX
> uses a single bit in guests to communicate whether a physical page
> should be protected by TDX as private memory (bit set to 0) or
> unprotected and shared with the VMM (bit set to 1).
> 
> __set_memory_enc_dec() is now aware about TDX and sets Shared bit
> accordingly following with relevant TDX hypercall.
> 
> Also, Do TDX_ACCEPT_PAGE on every 4k page after mapping the GPA range
> when converting memory to private. Using 4k page size limit is due
> to current TDX spec restriction. Also, If the GPA (range) was
> already mapped as an active, private page, the host VMM may remove
> the private page from the TD by following the “Removing TD Private
> Pages” sequence in the Intel TDX-module specification [1] to safely
> block the mapping(s), flush the TLB and cache, and remove the
> mapping(s).
> 
> BUG() if TDX_ACCEPT_PAGE fails (except "previously accepted page" case)
> , as the guest is completely hosed if it can't access memory.
> 
> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsoftware.intel.com%2Fcontent%2Fdam%2Fdevelop%2Fexternal%2Fus%2Fen%2Fdocuments%2Ftdx-module-1eas-v0.85.039.pdf&amp;data=04%7C01%7Cthomas.lendacky%40amd.com%7C0e667adf5a4042abce3908d98abd07a8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637693367201703893%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=UGxQ9xBjWsmev7PetX%2BuS0RChkAXyaH7q6JHO9ZiUtY%3D&amp;reserved=0
> 
> Tested-by: Kai Huang <kai.huang@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

...

> diff --git a/arch/x86/mm/mem_encrypt_common.c b/arch/x86/mm/mem_encrypt_common.c
> index f063c885b0a5..119a9056efbb 100644
> --- a/arch/x86/mm/mem_encrypt_common.c
> +++ b/arch/x86/mm/mem_encrypt_common.c
> @@ -9,9 +9,18 @@
>   
>   #include <asm/mem_encrypt_common.h>
>   #include <linux/dma-mapping.h>
> +#include <linux/cc_platform.h>
>   
>   /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>   bool force_dma_unencrypted(struct device *dev)
>   {
> -	return amd_force_dma_unencrypted(dev);
> +	if (cc_platform_has(CC_ATTR_GUEST_TDX) &&
> +	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +		return true;
> +
> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) ||
> +	    cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
> +		return amd_force_dma_unencrypted(dev);
> +
> +	return false;

Assuming the original force_dma_unencrypted() function was moved here or 
cc_platform.c, then you shouldn't need any changes. Both SEV and TDX 
require true be returned if CC_ATTR_GUEST_MEM_ENCRYPT returns true. And 
then TDX should never return true for CC_ATTR_HOST_MEM_ENCRYPT.

>   }
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 527957586f3c..6c531d5cb5fd 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -30,6 +30,7 @@
>   #include <asm/proto.h>
>   #include <asm/memtype.h>
>   #include <asm/set_memory.h>
> +#include <asm/tdx.h>
>   
>   #include "../mm_internal.h"
>   
> @@ -1981,8 +1982,10 @@ int set_memory_global(unsigned long addr, int numpages)
>   				    __pgprot(_PAGE_GLOBAL), 0);
>   }
>   
> -static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
> +static int __set_memory_protect(unsigned long addr, int numpages, bool protect)
>   {
> +	pgprot_t mem_protected_bits, mem_plain_bits;
> +	enum tdx_map_type map_type;
>   	struct cpa_data cpa;
>   	int ret;
>   
> @@ -1997,8 +2000,25 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
>   	memset(&cpa, 0, sizeof(cpa));
>   	cpa.vaddr = &addr;
>   	cpa.numpages = numpages;
> -	cpa.mask_set = enc ? __pgprot(_PAGE_ENC) : __pgprot(0);
> -	cpa.mask_clr = enc ? __pgprot(0) : __pgprot(_PAGE_ENC);
> +
> +	if (cc_platform_has(CC_ATTR_GUEST_SHARED_MAPPING_INIT)) {
> +		mem_protected_bits = __pgprot(0);
> +		mem_plain_bits = pgprot_cc_shared_mask();

How about having generic versions for both shared and private that return 
the proper value for SEV or TDX. Then this remains looking similar to as 
it does now, just replacing the __pgprot() calls with the appropriate 
pgprot_cc_{shared,private}_mask().

Thanks,
Tom

> +	} else {
> +		mem_protected_bits = __pgprot(_PAGE_ENC);
> +		mem_plain_bits = __pgprot(0);
> +	}
> +
> +	if (protect) {
> +		cpa.mask_set = mem_protected_bits;
> +		cpa.mask_clr = mem_plain_bits;
> +		map_type = TDX_MAP_PRIVATE;
> +	} else {
> +		cpa.mask_set = mem_plain_bits;
> +		cpa.mask_clr = mem_protected_bits;
> +		map_type = TDX_MAP_SHARED;
> +	}
> +
>   	cpa.pgd = init_mm.pgd;
>   
>   	/* Must avoid aliasing mappings in the highmem code */
> @@ -2006,9 +2026,17 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
>   	vm_unmap_aliases();
>   
>   	/*
> -	 * Before changing the encryption attribute, we need to flush caches.
> +	 * Before changing the encryption attribute, flush caches.
> +	 *
> +	 * For TDX, guest is responsible for flushing caches on private->shared
> +	 * transition. VMM is responsible for flushing on shared->private.
>   	 */
> -	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
> +	if (cc_platform_has(CC_ATTR_GUEST_TDX)) {
> +		if (map_type == TDX_MAP_SHARED)
> +			cpa_flush(&cpa, 1);
> +	} else {
> +		cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
> +	}
>   
>   	ret = __change_page_attr_set_clr(&cpa, 1);
>   
> @@ -2021,18 +2049,21 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
>   	 */
>   	cpa_flush(&cpa, 0);
>   
> +	if (!ret && cc_platform_has(CC_ATTR_GUEST_SHARED_MAPPING_INIT))
> +		ret = tdx_hcall_gpa_intent(__pa(addr), numpages, map_type);
> +
>   	return ret;
>   }
>   
>   int set_memory_encrypted(unsigned long addr, int numpages)
>   {
> -	return __set_memory_enc_dec(addr, numpages, true);
> +	return __set_memory_protect(addr, numpages, true);
>   }
>   EXPORT_SYMBOL_GPL(set_memory_encrypted);
>   
>   int set_memory_decrypted(unsigned long addr, int numpages)
>   {
> -	return __set_memory_enc_dec(addr, numpages, false);
> +	return __set_memory_protect(addr, numpages, false);
>   }
>   EXPORT_SYMBOL_GPL(set_memory_decrypted);
>   
> 
