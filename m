Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88227186B0
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 17:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjEaPtP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 11:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjEaPtP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 11:49:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E63E8E;
        Wed, 31 May 2023 08:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8oJ7XQjQQvPTBsFSzE7OAaziM4q+gdTbG0V6lcVctM8=; b=NwCLHsXKkQrP2W6vUDYbEtg+Ot
        rxSrurOqvx3cYriiqxS1kFmmdVm6FYxAOdzb5v+XlxVXtmHHdRaZQwUGRaZhBDCQ1YRwRQfakQsJI
        yfPuMM3MvdrLuQ4VRtVfRAmnloeQWodAC7XYLTnvtYDU8zPGJjn0wy4rCpv9KRWiWpBhK7tlHj8Wk
        y5Leq2hXV136MifEnzPFEARHtWM+eN4pn5EEyrQj4FiB0SwSStKMstI5T6xEzXr3XEKia4SmwByKg
        fpMVZ8B+9OtwtxRoOzwa06XBUKUsc1J8lRks2BEBrENxP0ZLOF3avAAvw04fj775SW0/Oc5jKQEf3
        Fc3yfDsg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4O3x-00FVGr-2s;
        Wed, 31 May 2023 15:48:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D8E33002A9;
        Wed, 31 May 2023 17:48:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D069243D244B; Wed, 31 May 2023 17:48:32 +0200 (CEST)
Date:   Wed, 31 May 2023 17:48:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Tianyu Lan <ltykernel@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "jiangshan.ljs@antgroup.com" <jiangshan.ljs@antgroup.com>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "srutherford@google.com" <srutherford@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "venu.busireddy@oracle.com" <venu.busireddy@oracle.com>,
        "sterritt@google.com" <sterritt@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "pangupta@amd.com" <pangupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [RFC PATCH V6 02/14] x86/sev: Add Check of #HV event in path
Message-ID: <20230531154832.GA428966@hirez.programming.kicks-ass.net>
References: <20230515165917.1306922-1-ltykernel@gmail.com>
 <20230515165917.1306922-3-ltykernel@gmail.com>
 <20230516093225.GD2587705@hirez.programming.kicks-ass.net>
 <851f6305-2145-d756-91e3-55ab89bfcd42@gmail.com>
 <20230517130943.GE2665450@hirez.programming.kicks-ass.net>
 <BYAPR21MB16887196D3DFFCB52EAC546AD748A@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB16887196D3DFFCB52EAC546AD748A@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 31, 2023 at 02:50:50PM +0000, Michael Kelley (LINUX) wrote:

> I'm jumping in to answer some of the basic questions here.  Yesterday,
> there was a discussion about nested #HV exceptions, so maybe some of
> this is already understood, but let me recap at a higher level, provide some
> references, and suggest the path forward.

> 2) For the Restricted Interrupt Injection code, Tianyu will look at
> how to absolutely minimize the impact in the hot code paths,
> particularly when SEV-SNP is not active.  Hopefully the impact can
> be a couple of instructions at most, or even less with the use of
> other existing kernel techniques.  He'll look at the other things you've
> commented on and get the code into a better state.  I'll work with
> him on writing commit messages and comments that explain what's
> going on.

So from what I understand of all this SEV-SNP/#HV muck is that it is
near impossible to get right without ucode/hw changes. Hence my request
to Tom to look into that.

The feature as specified in the AMD documentation seems fundamentally
buggered.

Specifically #HV needs to be IST because hypervisor can inject at any
moment, irrespective of IF or anything else -- even #HV itself. This
means also in the syscall gap.

Since it is IST, a nested #HV is instant stack corruption -- #HV can
attempt to play stack games as per the copied #VC crap (which I'm not at
all convinced about being correct itself), but this doesn't actually fix
anything, all you need is a single instruction window to wreck things.

Because as stated, the whole premise is that the hypervisor is out to
get you, you must not leave it room to wiggle. As is, this is security
through prayer, and we don't do that.

In short; I really want a solid proof that what you propose to implement
is correct and not wishful thinking.

