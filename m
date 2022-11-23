Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AE1634E83
	for <lists+linux-arch@lfdr.de>; Wed, 23 Nov 2022 04:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbiKWDwP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Nov 2022 22:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiKWDwO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2022 22:52:14 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF481DB84F;
        Tue, 22 Nov 2022 19:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669175533; x=1700711533;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vJeCuU0PZMiUtuycmN2gWAkeimzciZJYcvOH8AE6Ihc=;
  b=IRmPOAk2yiX5NfPavL2h4gVbJ0sgTyviQZldwN7IgHjMNaHNRIN8xkCA
   d3xKa2utGef/Qy/z+eNfOBuUAhhgsRfb1Vdfs4X3JZDzZu3l6OwG9UnrP
   2quYFfSLrPi9Zd1TL1waot1+DadhiyV4W/htS+sdsI+32nhuuC/vgqxcF
   hZTavDvjkF34bwyLvVc+cA1kHgzQq/BKBzCumVeh3pgZzQV0AGSVUXQ13
   N7cdztcR7QPe051/N0w1AhL06DuZIhuLkvDjlESAYI2lxZEsS3TTnc2p5
   14+tNhpoupcW+Vxbh0CszNogILBbXPI02cWChT7JDWDB3k0KOBhC57DQN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="312673186"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="312673186"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 19:52:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="730636013"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="730636013"
Received: from mjalalif-mobl1.amr.corp.intel.com (HELO [10.255.229.245]) ([10.255.229.245])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 19:52:11 -0800
Message-ID: <08a42493-0ff5-3b29-e6a5-db622e8d4c7f@linux.intel.com>
Date:   Tue, 22 Nov 2022 19:52:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 1/6] x86/tdx: Support hypercalls for TDX guests on Hyper-V
Content-Language: en-US
To:     Dexuan Cui <decui@microsoft.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-2-decui@microsoft.com>
 <18323d11-146f-c418-e8f0-addb2b8adb19@intel.com>
 <SA1PR21MB13353C24B5BF2E7D6E8BCFA5BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <SA1PR21MB13353C24B5BF2E7D6E8BCFA5BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 11/22/22 5:37 PM, Dexuan Cui wrote:
>> From: Dave Hansen <dave.hansen@intel.com>
>> Sent: Monday, November 21, 2022 12:39 PM
>> [...]
>> On 11/21/22 11:51, Dexuan Cui wrote:
>>> __tdx_hypercall() doesn't work for a TDX guest running on Hyper-V,
>>> because Hyper-V uses a different calling convention, so add the
>>> new function __tdx_ms_hv_hypercall().
>>
>> Other than R10 being variable here and fixed for __tdx_hypercall(), this
>> looks *EXACTLY* the same as __tdx_hypercall(), or at least a strict
>> subset of what __tdx_hypercall() can do.
>>
>> Did I miss something?
> 
> The existing asm code for __tdx_hypercall() passes through R10~R15
> (see TDVMCALL_EXPOSE_REGS_MASK) to the (KVM) hypervisor.
> 
> Unluckily, for Hyper-V, we need to pass through RDX, R8, R10 and R11
> to Hyper-V, so I don't think I can use the existing __tdx_hypercall() ?
> >> Another way of saying this:  It seems like you could do this with a new
>> version of _tdx_hypercall() (and all in C) instead of a new
>> __tdx_hypercall().
> 
> I don't think the current TDVMCALL_EXPOSE_REGS_MASK allows me
> to pass through RDX and R8 to Hyper-V.

Because TDVMCALLs defined in the GHCI specification only use registers
R10-R15, only those registers are currently exposed. However, the TDVMCALL
ABI allows the use of input registers such as RBX, RBP, RDI, RSI, R8 or R9.
Instead of creating a new variant of __tdx_hypercall() to handle your use
case, perhaps you can add the registers you require to the
TDVMCALL EXPOSE REGS MASK. You just need to make sure they are zeroed out
for other users of __tdx_hypercall().

> 
> PS, the comment before __tdx_hypercall() contains this line:
> 
> "* RBX, RBP, RDI, RSI  - Used to pass VMCALL sub function specific
> arguments."
> 
> But it looks like currently RBX an RBP are not used at all in 
> arch/x86/coco/tdx/tdcall.S ?
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
