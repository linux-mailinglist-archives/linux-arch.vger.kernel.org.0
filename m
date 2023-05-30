Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CE87166DF
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 17:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjE3PUx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 11:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjE3PUw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 11:20:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB88B0;
        Tue, 30 May 2023 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685460050; x=1716996050;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TnWTFu+jLGRbnuZ0/49P9Urrda2KeInMOwSZ8u74prA=;
  b=VBynsX/Zp/NqBZ/oXAy1eXx92hSyynjvoorubtJ5nRnt6JNPRXBm0k+B
   MAXNeyW7CBFYJR4d1iHa4pngeQS+0Pv3P7q4hBz6FwCKkcCFevbeHpLBI
   PG2EkmRDN/WfVv/sUQw32IKNHYyKQO6LMgR9K5knDZ3BOQaLpaM26ZGCv
   RIKDWqTWQTGDc0etsnPhO0duP01HiDKJ0h8/BZNjF+TXH24E5u1iRYqTY
   gu9GpHfUARPhWNYC+vvoC9vBl67xYbsr8L/sf1ezKvWePP0mnmtIgl/nS
   4vOzkX1xcU9acl0tokPbQQiT0V7CY2zRAil1tkDUG1UmciHsmlKKeJh6g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="441306296"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="441306296"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 08:18:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="818863043"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="818863043"
Received: from jswalken-mobl.amr.corp.intel.com (HELO [10.212.134.46]) ([10.212.134.46])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 08:18:11 -0700
Message-ID: <82591d71-4176-db31-3ec1-fd070b29373c@intel.com>
Date:   Tue, 30 May 2023 08:18:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH V6 01/14] x86/sev: Add a #HV exception handler
Content-Language: en-US
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tianyu Lan <ltykernel@gmail.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, ashish.kalra@amd.com,
        srutherford@google.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, pawan.kumar.gupta@linux.intel.com,
        adrian.hunter@intel.com, daniel.sneddon@linux.intel.com,
        alexander.shishkin@linux.intel.com, sandipan.das@amd.com,
        ray.huang@amd.com, brijesh.singh@amd.com, michael.roth@amd.com,
        thomas.lendacky@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com, pangupta@amd.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20230515165917.1306922-1-ltykernel@gmail.com>
 <20230515165917.1306922-2-ltykernel@gmail.com>
 <20230516093010.GC2587705@hirez.programming.kicks-ass.net>
 <d43c14d9-a149-860c-71d6-e5c62b7c356f@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <d43c14d9-a149-860c-71d6-e5c62b7c356f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/30/23 05:16, Gupta, Pankaj wrote:
> #HV handler handles both #NMI & #MCE in the guest and nested #HV is
> never raised by the hypervisor. Next #HV exception is only raised by the
> hypervisor when Guest acknowledges the pending #HV exception by clearing
> "NoFurtherSignal” bit in the doorbell page.

There's a big difference between "is never raised by" and "cannot be
raised by".

Either way, this series (and this patch in particular) needs some much
better changelogs so that this behavior is clear.  It would also be nice
to reference the relevant parts of the hardware specs if the "hardware"*
is helping to provide these guarantees.

* I say "hardware" in quotes because on TDX a big chunk of this behavior
  is implemented in software in the TDX module.  SEV probably does it in
  microcode (or maybe in the secure processor), but I kinda doubt it's
  purely silicon.
