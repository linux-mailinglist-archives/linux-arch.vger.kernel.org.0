Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BDC3E16BA
	for <lists+linux-arch@lfdr.de>; Thu,  5 Aug 2021 16:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbhHEOOw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Aug 2021 10:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240281AbhHEOOu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Aug 2021 10:14:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A189C061765;
        Thu,  5 Aug 2021 07:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jkC5BHIA+OoNY3RA1kKnhanE39KSJUyRxPOSK5PxKJ4=; b=jS9beBRN33+YE3nLhV0+juwj2m
        M21gswRLRXlj9G7nUL9+UaYZaqldUk6dYat8MK2TEtQx98o7T9VsMJPD7iRU4uGctnpwJmiAENC0S
        d5iBGtcKE/rvu2bDPFEsbbPN5g4HEVxgwrnHKLJHDx6oq4fdfON20zC1m1PYA4MystYDRR/ijf6n+
        yKP6PzPUB8C4KKMetCzyTfsQiIZX9POLtO6DG6sM1OD0l3e9s8v/Kx4GgKgISf9CHEnHVcYWRA4+Q
        LHlKUuStVn3XhYiGoHOGpKfs5vgB5qUCyiEjS8M7ODcJbCa/Q2rQchs+BwAv5uLBsAuE3F/UYuh1M
        DgYQMj1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBe5i-00799u-0r; Thu, 05 Aug 2021 14:11:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 951B130031E;
        Thu,  5 Aug 2021 16:11:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5BFD82028D0D9; Thu,  5 Aug 2021 16:11:19 +0200 (CEST)
Date:   Thu, 5 Aug 2021 16:11:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, joro@8bytes.org,
        will@kernel.org, davem@davemloft.net, kuba@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, arnd@arndb.de,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        Tianyu.Lan@microsoft.com, rppt@kernel.org,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        brijesh.singh@amd.com, thomas.lendacky@amd.com, pgonda@google.com,
        david@redhat.com, krish.sadhukhan@oracle.com, saravanand@fb.com,
        aneesh.kumar@linux.ibm.com, xen-devel@lists.xenproject.org,
        martin.b.radev@gmail.com, ardb@kernel.org, rientjes@google.com,
        tj@kernel.org, keescook@chromium.org,
        michael.h.kelley@microsoft.com, iommu@lists.linux-foundation.org,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        netdev@vger.kernel.org, vkuznets@redhat.com, parri.andrea@gmail.com
Subject: Re: [PATCH V2 03/14] x86/set_memory: Add x86_set_memory_enc static
 call support
Message-ID: <YQvxhyn5O1POQTF/@hirez.programming.kicks-ass.net>
References: <20210804184513.512888-1-ltykernel@gmail.com>
 <20210804184513.512888-4-ltykernel@gmail.com>
 <5823af8a-7dbb-dbb0-5ea2-d9846aa2a36a@intel.com>
 <942e6fcb-3bdf-9294-d3db-ca311db440d3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <942e6fcb-3bdf-9294-d3db-ca311db440d3@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 05, 2021 at 10:05:17PM +0800, Tianyu Lan wrote:
> +static int default_set_memory_enc(unsigned long addr, int numpages, bool
> enc)
> +{
> +	return 0;
> +}
> +
> +DEFINE_STATIC_CALL(x86_set_memory_enc, default_set_memory_enc);

That's spelled:

DEFINE_STATIC_CALL_RET0(x86_set_memory_enc, __set_memory_enc_dec);

And then you can remove the default_set_memory_enc() thing.
