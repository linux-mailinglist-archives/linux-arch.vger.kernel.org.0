Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32BE716447
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 16:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjE3Ofm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 10:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjE3Ofl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 10:35:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E40F8F;
        Tue, 30 May 2023 07:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hh6nfYGRw8Xo4sZYsBcKGggpg8AsAPYo0Fmyp3Zb2C8=; b=b7ZWeglVxXPgUC2IalnxW8QZFN
        CJfyT1adD2qvortXSb64Dq95xjOfW+CqIcHD2hwXLUJgjM2Jcm0aCVkNEl+4D0d7kFi9tOPkvwR77
        Q03x4AZfKAqK5Ex1sI8wMOmMNkdcJcJhl4cvNwxhtFGzTP86T5Ywi8TkmQumPO43FnAxmAXpVh8jL
        owdx7z3MUDt0GBULgwunRwE/VKqfvaPMlGOjv+kvuj6RvfMdFLcd/k/dsM83oJvJK/bRwGDK1rO88
        bxWkHdsOhI/x3kRHmUEkR6s92NeliMjQ1NcuYHcX4oDz9kVrTxXGNYdIQvBq8b8LERzqK1vDsiZ2p
        ybOuykig==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q40RG-00Dqv4-1c;
        Tue, 30 May 2023 14:35:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A59E7300194;
        Tue, 30 May 2023 16:35:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90029214873C1; Tue, 30 May 2023 16:35:04 +0200 (CEST)
Date:   Tue, 30 May 2023 16:35:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     Tianyu Lan <ltykernel@gmail.com>, luto@kernel.org,
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
        thomas.lendacky@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com, pangupta@amd.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH V6 01/14] x86/sev: Add a #HV exception handler
Message-ID: <20230530143504.GA200197@hirez.programming.kicks-ass.net>
References: <20230515165917.1306922-1-ltykernel@gmail.com>
 <20230515165917.1306922-2-ltykernel@gmail.com>
 <20230516093010.GC2587705@hirez.programming.kicks-ass.net>
 <d43c14d9-a149-860c-71d6-e5c62b7c356f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d43c14d9-a149-860c-71d6-e5c62b7c356f@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 30, 2023 at 02:16:55PM +0200, Gupta, Pankaj wrote:
> 
> > > Add a #HV exception handler that uses IST stack.
> > > 
> > 
> > Urgh.. that is entirely insufficient. Like it doesn't even begin to
> > start to cover things.
> > 
> > The whole existing VC IST stack abuse is already a nightmare and you're
> > duplicating that.. without any explanation for why this would be needed
> > and how it is correct.
> > 
> > Please try again.
> 
> #HV handler handles both #NMI & #MCE in the guest and nested #HV is never
> raised by the hypervisor. 

I thought all this confidental computing nonsense was about not trusting
the hypervisor, so how come we're now relying on the hypervisor being
sane?
