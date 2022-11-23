Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF9A636541
	for <lists+linux-arch@lfdr.de>; Wed, 23 Nov 2022 17:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbiKWQEs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Nov 2022 11:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237748AbiKWQEr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Nov 2022 11:04:47 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E175CD3D;
        Wed, 23 Nov 2022 08:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669219486; x=1700755486;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d55MEzSITgAIwoLWl00J4QxRdqUnar9DyNE6a8QVJQ0=;
  b=Znm53c6MWiPwzYHOy1TpIp8EjH1JKaOxL556w0UdtP89P+qeneVclkTd
   58sBTKvP7CQfW6R/LEdedNlt4x4k7B6DgM+TL2CpJLAcrjUEeRLamk1Zj
   gWzGfIDyZVjWYvIT/g2+79Uf97ipWXdzq+vDvLub3BmRY7G8o/fCLClDs
   ky8jx7YxzR1mTmgVKMR0h8OZJlpNuBWv5AbkaSM6KE4T6OZOc3L6hETZg
   9Jtnt7YAxwmJtQYvDvHojawuSMHxoabAroDyHe3hJva+Q3E+mZG+tXLI5
   WSRLnAruqbaDSwgGvEDu4j2YkHVdwNy/gEh4xxVzGHfbQ/w+ysLxx7ZAL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="297458549"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="297458549"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 08:04:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="619665323"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="619665323"
Received: from vcbudden-mobl3.amr.corp.intel.com (HELO [10.212.129.67]) ([10.212.129.67])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 08:04:44 -0800
Message-ID: <7601f686-ed35-5329-a54d-0c5c38dbd518@intel.com>
Date:   Wed, 23 Nov 2022 08:04:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/6] x86/tdx: Support hypercalls for TDX guests on Hyper-V
Content-Language: en-US
To:     Dexuan Cui <decui@microsoft.com>,
        "'ak@linux.intel.com'" <ak@linux.intel.com>,
        "'arnd@arndb.de'" <arnd@arndb.de>, "'bp@alien8.de'" <bp@alien8.de>,
        "'brijesh.singh@amd.com'" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "'dave.hansen@linux.intel.com'" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'hpa@zytor.com'" <hpa@zytor.com>,
        "'jane.chu@oracle.com'" <jane.chu@oracle.com>,
        "'kirill.shutemov@linux.intel.com'" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>,
        "'linux-hyperv@vger.kernel.org'" <linux-hyperv@vger.kernel.org>,
        "'luto@kernel.org'" <luto@kernel.org>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'peterz@infradead.org'" <peterz@infradead.org>,
        "'rostedt@goodmis.org'" <rostedt@goodmis.org>,
        "'sathyanarayanan.kuppuswamy@linux.intel.com'" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "'seanjc@google.com'" <seanjc@google.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'tony.luck@intel.com'" <tony.luck@intel.com>,
        "'wei.liu@kernel.org'" <wei.liu@kernel.org>,
        "'x86@kernel.org'" <x86@kernel.org>
Cc:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-2-decui@microsoft.com>
 <18323d11-146f-c418-e8f0-addb2b8adb19@intel.com>
 <SA1PR21MB13353C24B5BF2E7D6E8BCFA5BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
 <SA1PR21MB13350DB14A0D6EC943FEF78BBF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <SA1PR21MB13350DB14A0D6EC943FEF78BBF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/22/22 17:56, Dexuan Cui wrote:
>> From: Dexuan Cui
>> [...]
>> The existing asm code for __tdx_hypercall() passes through R10~R15
>> (see TDVMCALL_EXPOSE_REGS_MASK) to the (KVM) hypervisor.
>>
>> Unluckily, for Hyper-V, we need to pass through RDX, R8, R10 and R11
>> to Hyper-V, so I don't think I can use the existing __tdx_hypercall() ?
> I'm checking with the Hyper-V team to see if it's possible for them
> to not use RDX and R8, and use R12 and R13 instead. Will keep the
> thread updated.

That would be nice.  But, to be honest, I don't expect them to change
the ABI for one OS.  It's not a big deal to just make the function a bit
more flexible.
