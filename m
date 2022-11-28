Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC7063B27B
	for <lists+linux-arch@lfdr.de>; Mon, 28 Nov 2022 20:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiK1TsS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Nov 2022 14:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbiK1TsN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Nov 2022 14:48:13 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CB15FFE;
        Mon, 28 Nov 2022 11:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669664890; x=1701200890;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n5VWOENDCBf3VgP2aur8apgqIJZll5eA5gIBPGE6z40=;
  b=b/FVgSPsPLNsXQ0J+SULD8Hl1N/3yN6B/qRO2NSpLDz8VkEhPcDR/nBU
   pvt0gl1pPqL+nTzPrZukXAzLywCgykiirFHqUtL/SA8LuVLB1SVdpRbaF
   5h9fTfkg38C/PIw5ByTVSKQfpT+yMNbxxUMdzC2xr4fJ7qUWToc9aj4vK
   Huy+bw1TPW+5bevqJhXiQ8PHs0dH8Fi9+kw0cO5GqZs8Vn6IGCM44Rc7P
   5beicNFh7S49IOe6CTUdLTRRUWmzGB9w/SCnDvwnWooxGw6iAp9xg7295
   Eqam9KWfi7XaLH6sEqv/pkoZh/qNE2yYvy6lB03RXRAHWRrXgpD2WkFPK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="379194790"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="379194790"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 11:48:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="621178600"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="621178600"
Received: from nroy-mobl1.amr.corp.intel.com (HELO [10.212.209.4]) ([10.212.209.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 11:48:08 -0800
Message-ID: <f6d27366-e083-b362-b44c-eaf4d3365b53@intel.com>
Date:   Mon, 28 Nov 2022 11:48:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Content-Language: en-US
To:     Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-6-decui@microsoft.com>
 <BYAPR21MB16886270B7899F35E8A826A4D70C9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <SA1PR21MB133528B2B3637D61368FF5FFBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
 <b692c4da-4365-196d-9d12-33e2679c01de@intel.com>
 <SA1PR21MB1335BA9D27891F6B1BA3A988BF139@SA1PR21MB1335.namprd21.prod.outlook.com>
 <54871aec-823b-1ff5-8362-688d10e97263@intel.com>
 <SA1PR21MB13357B3CC486514D2DF50A4DBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <SA1PR21MB13357B3CC486514D2DF50A4DBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/28/22 11:37, Dexuan Cui wrote:
>> From: Dave Hansen <dave.hansen@intel.com>
...
>> How do we know, for instance, that no hypercall using this interface
>> will *ever* take the 0x0 physical address as an argument?
> 
> A 0x0 physical address as an argument still works: the 0 is passed
> to the hypervisor using GHCI. I believe Hyper-V interprets the 0 as
> an error (if the param is needed), and returns an "invalid parameter"
> error code to the guest.

I don't see any data in the public documentation to support the claim
that 0x0 is a special argument for either the input or output GPA
parameters.

This is despite some actual discussion on things like their alignment
requirements[1] and interactions with overlay pages.

So, either you are mistaken about that behavior, or it looks like the
documentation needs updating.

1.
https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface


