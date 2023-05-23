Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4636E70E765
	for <lists+linux-arch@lfdr.de>; Tue, 23 May 2023 23:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbjEWVdG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 17:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjEWVdF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 17:33:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ECE119;
        Tue, 23 May 2023 14:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684877585; x=1716413585;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=erRzVOCGdMgsoDcayD8raaTvBwRGaZfeDXdMjszFzQw=;
  b=O0gKXkRYq07YVG0itCtiFvQgxGqedLvFMhCAmQyG90AKmfUo7jIINwKS
   VrnuOdnzr4pJzEd4TOQIpQIXPurVfRsyY1OgIKCi/6sYm7dhWIyWmL/IJ
   uKJuk7bMW5xcgbvoEhR2nr3Xc6rCpLMLbrdnN0Qhc/tOcCm4Ou2jYLuGz
   RLEtHu78EiUpicinkTtpcugfpUomJovkAezLd3Sl4kWMbtIh5TLrxkDpy
   1lJU1z4QApEhz5bVQTIY6sOm18psFOxKkOHyJBKJJnxdPfUH1ZGzk+DWV
   OH+b30/Xxbj8wpuJzBOX52oNTxsfUfuI42hwMx1fa5sVuhsZc5qJY8HHu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="419079811"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="419079811"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 14:33:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="769153243"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="769153243"
Received: from kroconn-mobl2.amr.corp.intel.com (HELO [10.251.1.84]) ([10.251.1.84])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 14:33:03 -0700
Message-ID: <9a772a17-6038-a73e-eb2c-c3a28fa3b85f@intel.com>
Date:   Tue, 23 May 2023 14:33:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dexuan Cui <decui@microsoft.com>, ak@linux.intel.com,
        arnd@arndb.de, bp@alien8.de, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        x86@kernel.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
References: <20230504225351.10765-1-decui@microsoft.com>
 <20230504225351.10765-3-decui@microsoft.com>
 <9e466079-ff27-f928-b470-eb5ef157f048@intel.com>
 <ZG0vXlQpXgll+YJ1@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZG0vXlQpXgll+YJ1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/23/23 14:25, Sean Christopherson wrote:
>> There are consequences for converting pages between shared and private.
>> Doing it on a vmalloc() mapping is guaranteed to fracture the underlying
>> EPT/SEPT mappings.
>>
>> How does this work with load_unaligned_zeropad()?  Couldn't it be
>> running around poking at one of these vmalloc()'d pages via the direct
>> map during a shared->private conversion before the page has been accepted?
> Would it be feasible and sensible to add a GFP_SHARED or whatever, to communicate
> to the core allocators that the page is destined to be converted to a shared page?
> I assume that would provide a common place (or two) for initiating conversions,
> and would hopefully allow for future optimizations, e.g. to keep shared allocation
> in the same pool or whatever.  Sharing memory without any intelligence as to what
> memory is converted is going to make both the guest and host sad.

I don't think we want a GFP flag.  This is still way too specialized to
warrant one of those.

It sounds like a similar problem to what folks want for modules or BPF.
There are a bunch of allocations that are related and can have some of
their setup/teardown costs amortized if they can be clumped together.

For BPF, the costs are from doing RW=>RO in the kernel direct map, and
fracturing it in the process.

Here, the costs are from the private->shared conversions and fracturing
both the direct map and the EPT/SEPT.

I just don't know if there's anything that we can reuse from the BPF effort.
