Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F266717B84
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 11:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjEaJPf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 05:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjEaJPe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 05:15:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BACBE;
        Wed, 31 May 2023 02:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BDwruifJ4hZC6T+A+Yrq8BWIQU5ks8snAY3EXrTzopM=; b=gtXk9RVrVY8qW8NYf4qE95uoRE
        lDL4pw+2UmyWib16eFgzZulP/qCV0AZch/9qlddGy0xxTYS7xePFDNkHtpq2uXzVHB4cI5IePtO6/
        8Zc3Ay1ScYT+SzNBEZqLLhilisxAHcOjhWOojuvI8IIJ5yxzKLoZNdSNR+X4TsGmlZFao9/mxkKAC
        jWxxS89ihv3L6Nld0jQfdqnsCEyxP79jFYGcBaSOktFjvMEkaqBSX+yJovBn1WzSUWN8x0CzXIOoD
        fz3UOcKB+yZtZ0YcxTYozEfCFDZpWmRqSnN1m/aHAwlLx4XDn6QdfksdOXxY9VjonJWsSMrdpDppU
        L697pnTg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4Huw-00FPuU-1m;
        Wed, 31 May 2023 09:14:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BFA94300338;
        Wed, 31 May 2023 11:14:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 99972241EF418; Wed, 31 May 2023 11:14:52 +0200 (CEST)
Date:   Wed, 31 May 2023 11:14:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>
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
Subject: Re: [RFC PATCH V6 01/14] x86/sev: Add a #HV exception handler
Message-ID: <20230531091452.GG38236@hirez.programming.kicks-ass.net>
References: <20230515165917.1306922-1-ltykernel@gmail.com>
 <20230515165917.1306922-2-ltykernel@gmail.com>
 <20230516093010.GC2587705@hirez.programming.kicks-ass.net>
 <d43c14d9-a149-860c-71d6-e5c62b7c356f@amd.com>
 <20230530143504.GA200197@hirez.programming.kicks-ass.net>
 <0f0ab135-cdd0-0691-e0c1-42645671fe15@amd.com>
 <20230530185232.GA211927@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530185232.GA211927@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 30, 2023 at 08:52:32PM +0200, Peter Zijlstra wrote:

> > That should really say that a nested #HV should never be raised by the
> > hypervisor, but if it is, then the guest should detect that and
> > self-terminate knowing that the hypervisor is possibly being malicious.
> 
> I've yet to see code that can do that reliably.

Tom; could you please investigate if this can be enforced in ucode?

Ideally #HV would have an internal latch such that a recursive #HV will
terminate the guest (much like double #MC and tripple-fault).

But unlike the #MC trainwreck, can we please not leave a glaring hole in
this latch and use a spare bit in the IRET frame please?

So have #HV delivery:
 - check internal latch; if set, terminate machine
 - set latch
 - write IRET frame with magic bit set

have IRET:
 - check magic bit and reset #HV latch

