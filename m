Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5074716D0F
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 21:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjE3TD5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 15:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjE3TDz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 15:03:55 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EFE10B;
        Tue, 30 May 2023 12:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685473434; x=1717009434;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ika8e14NpDMZ31UCCm9s1zywptH3s2pb25BGFbNMfm8=;
  b=WT1NX9lfXrdJyewuT4jv2cLWjzQSVPaEwjE5q9iCx2WEeqQR0oewOx05
   RuShPvN/G85jcSFsZw/YQVYMuiMw4SHmO4SxjDqlQCVdNHKDkg1VFq806
   vKrm76GZNC3dgSA3GYXus8GleAcj6ivey6jVtosYq6vCHqihb92BZcwh/
   8dkw9IVERGSt0DTKGgW3P2slPkTC4vQX/FgemiqvXZmFf5hoLKvn74VW4
   isCibxi1RrSuLjl5uW2i31P13rWrTBnyduriXDg35VhuVNoEpHCWKjivr
   MQRE6DN0Ly0gaLU0a8Jka5aGWllpJpOzm0dt6ihJ46F33FGhsFAXznliQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="353860981"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="353860981"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 12:03:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="656987249"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="656987249"
Received: from jswalken-mobl.amr.corp.intel.com (HELO [10.212.134.46]) ([10.212.134.46])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 12:03:52 -0700
Message-ID: <9af7a84d-929c-0d1b-bd91-f8493d549be0@intel.com>
Date:   Tue, 30 May 2023 12:03:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH V6 01/14] x86/sev: Add a #HV exception handler
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     "Gupta, Pankaj" <pankaj.gupta@amd.com>,
        Tianyu Lan <ltykernel@gmail.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, pbonzini@redhat.com, jgross@suse.com,
        tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, ashish.kalra@amd.com,
        srutherford@google.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, pawan.kumar.gupta@linux.intel.com,
        adrian.hunter@intel.com, daniel.sneddon@linux.intel.com,
        alexander.shishkin@linux.intel.com, sandipan.das@amd.com,
        ray.huang@amd.com, brijesh.singh@amd.com, michael.roth@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com,
        pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230515165917.1306922-1-ltykernel@gmail.com>
 <20230515165917.1306922-2-ltykernel@gmail.com>
 <20230516093010.GC2587705@hirez.programming.kicks-ass.net>
 <d43c14d9-a149-860c-71d6-e5c62b7c356f@amd.com>
 <20230530143504.GA200197@hirez.programming.kicks-ass.net>
 <0f0ab135-cdd0-0691-e0c1-42645671fe15@amd.com>
 <20230530185232.GA211927@hirez.programming.kicks-ass.net>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230530185232.GA211927@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/30/23 11:52, Peter Zijlstra wrote:
>> That should really say that a nested #HV should never be raised by the
>> hypervisor, but if it is, then the guest should detect that and
>> self-terminate knowing that the hypervisor is possibly being malicious.
> I've yet to see code that can do that reliably.

By "#HV should never be raised by the hypervisor", I think Tom means:

	#HV can and will be raised by malicious hypervisors and the
	guest must be able to unambiguously handle it in a way that
	will not result in the guest getting rooted.

Right? ;)
