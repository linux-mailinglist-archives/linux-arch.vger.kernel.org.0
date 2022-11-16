Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3CC62B73A
	for <lists+linux-arch@lfdr.de>; Wed, 16 Nov 2022 11:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiKPKK2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Nov 2022 05:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiKPKK1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Nov 2022 05:10:27 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B7D1A825;
        Wed, 16 Nov 2022 02:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IP43t3hJu1Ut6R9gno8nfJ5M4E7h1wkQRd32HTSGUjo=; b=cwGxlcmqkrn87V+pOU9TIN5gsZ
        k8k+ZoTpU4HiUzsqFp0EdEccYC9aLsFjSnFJKHVZkUssN+8m1CajV6ccnmwTQLTzAvE3fh0Eg9UWj
        8Vjq2DE8gsMlpoe3bNrOPKMnoimSk4Hy4A1AembykPKeRTvnNsVwJrqZ5S5Rq1xy2QrGvR0VQpvzR
        aqBiXKrgeyXbwJA2FSEv5araqwycTv9CHOUplwwq23PBbX+jaY3gKF6bBpvmm1ZwIvXGV37I2R7kL
        9eUIxURMM9d6ZtfgZRR07+9oQGfYZUe+x5IjIJAFy3DxvvCkM9Tm7pQyMPG0BKjuL9SeQ5YQCqn1Q
        srVTO45w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovFMY-001GVE-G6; Wed, 16 Nov 2022 10:09:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E8DE730002E;
        Wed, 16 Nov 2022 11:09:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B0392B5E08EB; Wed, 16 Nov 2022 11:09:43 +0100 (CET)
Date:   Wed, 16 Nov 2022 11:09:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 15/37] x86/mm: Check Shadow Stack page fault errors
Message-ID: <Y3S258Vtj63/fBsI@hirez.programming.kicks-ass.net>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-16-rick.p.edgecombe@intel.com>
 <Y3N8Sn65TzyD6jwL@hirez.programming.kicks-ass.net>
 <b89565c96a0330c27ae179d96be05d2fc006121c.camel@intel.com>
 <Y3P/qltUOcCYsXoD@hirez.programming.kicks-ass.net>
 <2766aedef0780f03b81ea7dfea42dffb328e21f1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2766aedef0780f03b81ea7dfea42dffb328e21f1.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 15, 2022 at 11:13:34PM +0000, Edgecombe, Rick P wrote:

> When a page becomes COW it changes from a shadow stack permissioned
> page (Write=0,Dirty=1) to (Write=0,Dirty=0,CoW=1), which is simply
> read-only to the CPU. When shadow stack is enabled, a RET would
> normally pop the shadow stack by reading it with a "shadow stack read"
> access. However, in the COW case the shadow stack memory does not have
> shadow stack permissions, it is read-only. So it will generate a fault.
> 
> For conventionally writable pages, a read can be serviced with a read
> only PTE, and COW would not have to happen. But for shadow stack, there
> isn't the concept of read-only shadow stack memory. If it is shadow
> stack permissioned, it can be modified via CALL and RET instructions.
> So COW needs to happen before any memory can be mapped with shadow
> stack permissions.
> 
> Shadow stack accesses (read or write) need to be serviced with shadow
> stack permissioned memory, so in the case of a shadow stack read
> access, treat it as a WRITE fault so both COW will happen and the write
> fault path will tickle maybe_mkwrite() and map the memory shadow stack.

ACK.
