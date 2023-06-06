Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC338723AAC
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jun 2023 09:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbjFFHyf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jun 2023 03:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbjFFHyA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jun 2023 03:54:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBD9B1;
        Tue,  6 Jun 2023 00:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nx4txqD66c1X0oZzcTp+6FZymBThmwnZeIP6QWdOgio=; b=sD99Pp9fnIO40tawhiF8x6JyUE
        tZQyQtKsGsC5Sah5ppe2vJHqxuJxRbe8xplNQRzBvLN3uKWGJveRvJLa4coQyO2nRH2MMuwIM+b7f
        2c1nnLjrTJCjZxW0QmQKrp3nnNjChCEC9aGUEIFwlzGQHnioIbq46kcASwTjvsrK5O9SRDXMOy7Ju
        2YXT18hPFgehW89zHQ9Z4mwkcQTutyGWYHW4QRkhFCShScuzlGFGTXNTjx9esB2Q9/rjzBoDhdrwn
        fx9kTbuv2JsZEIx/LvudW/q6E0ln8lxFkm4vPAsgFDnvGuE/2mBXpU+ptx+B4/rgoXNvdSpW6LgRB
        xkwmnl6Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6RSX-00Cu1T-S8; Tue, 06 Jun 2023 07:50:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 14B2D300129;
        Tue,  6 Jun 2023 09:50:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC07B205EA3F7; Tue,  6 Jun 2023 09:50:26 +0200 (CEST)
Date:   Tue, 6 Jun 2023 09:50:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
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
Message-ID: <20230606075026.GA905437@hirez.programming.kicks-ass.net>
References: <20230515165917.1306922-1-ltykernel@gmail.com>
 <20230515165917.1306922-2-ltykernel@gmail.com>
 <20230516093010.GC2587705@hirez.programming.kicks-ass.net>
 <d43c14d9-a149-860c-71d6-e5c62b7c356f@amd.com>
 <20230530143504.GA200197@hirez.programming.kicks-ass.net>
 <0f0ab135-cdd0-0691-e0c1-42645671fe15@amd.com>
 <20230530185232.GA211927@hirez.programming.kicks-ass.net>
 <54fa0a4f-9b3e-50d7-57cb-e0d2d39b7761@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54fa0a4f-9b3e-50d7-57cb-e0d2d39b7761@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 06, 2023 at 08:00:32AM +0200, Gupta, Pankaj wrote:
> 
> > > That should really say that a nested #HV should never be raised by the
> > > hypervisor, but if it is, then the guest should detect that and
> > > self-terminate knowing that the hypervisor is possibly being malicious.
> > 
> > I've yet to see code that can do that reliably.
> 
> - Currently, we are detecting the direct nested #HV with below check and
>   guest self terminate.
> 
>   <snip>
> 	if (get_stack_info_noinstr(stack, current, &info) &&
> 	    (info.type == (STACK_TYPE_EXCEPTION + ESTACK_HV) ||
> 	     info.type == (STACK_TYPE_EXCEPTION + ESTACK_HV2)))
> 		panic("Nested #HV exception, HV IST corrupted, stack
>                 type = %d\n", info.type);
>   </snip>
> 
> - Thinking about below solution to detect the nested
>   #HV reliably:
> 
>   -- Make reliable IST stack switching for #VC -> #HV -> #VC case
>      (similar to done in __sev_es_ist_enter/__sev_es_ist_exit for NMI
>      IST stack).

I'm not convinced any of that is actually correct; there is a *huge*
window between NMI hitting and calling __sev_es_ist_enter(), idem on the
exit side.

>   -- In addition to this, we can make nested #HV detection (with another
>      exception type) more reliable with refcounting (percpu?).

There is also #DB and the MOVSS shadow.

And no, I don't think any of that is what you'd call 'robust'. This is
what I call a trainwreck :/

And I'm more than willing to say no until the hardware is more sane.

Supervisor Shadow Stack support is in the same boat, that's on hold
until FRED makes things workable.
