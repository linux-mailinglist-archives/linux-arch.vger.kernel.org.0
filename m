Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355AF6C0C83
	for <lists+linux-arch@lfdr.de>; Mon, 20 Mar 2023 09:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjCTItu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 04:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjCTItm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 04:49:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B0BDBE7;
        Mon, 20 Mar 2023 01:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XiB3x9LYyNFRNq8LCKvOIAldHQmBve44qL67iI3THCc=; b=GwZx2zyJvzxlGQSxomJ78ma3vu
        8PTRVPbqwuxw5KRR9qoFZH/9BIssKpXXSvM7e6dyKqx8BxvrXcFmfi0Q/84EZHQmEPJhc0W9OTiGd
        T1oak955zhY6FTvo4Un7iRcuVljJb/7y+5yhj+p6JODLwcWopY/X1zon6DzcRXxriQxQyVUFqiqUT
        2nMP1djKwRrVp+w3IoD1gFL52pxfeeIDOwmTr2MO8xQ1TDpAdAJwtq6x7B06aBVN/ZdBbYpZnwdNM
        IOEjmsk8Xa5C5+Y16lzqtRbOW4LTztSf0fwxV/rGQL3KR1xIyRcFEEboo21HIlr+15VHjL4S3e0qi
        aFZgOv/g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1peBCS-003s0L-0z;
        Mon, 20 Mar 2023 08:49:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7B41300137;
        Mon, 20 Mar 2023 09:49:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88319202F7F65; Mon, 20 Mar 2023 09:49:02 +0100 (CET)
Date:   Mon, 20 Mar 2023 09:49:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yair Podemsky <ypodemsk@redhat.com>
Cc:     will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mtosatti@redhat.com,
        ppandit@redhat.com, alougovs@redhat.com,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/mmu_gather: send tlb_remove_table_smp_sync IPI only
 to MM CPUs
Message-ID: <20230320084902.GE2194297@hirez.programming.kicks-ass.net>
References: <20230312080945.14171-1-ypodemsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312080945.14171-1-ypodemsk@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Mar 12, 2023 at 10:09:45AM +0200, Yair Podemsky wrote:
> Currently the tlb_remove_table_smp_sync IPI is sent to all CPUs
> indiscriminately, this causes unnecessary work and delays notable in
> real-time use-cases and isolated cpus, this patch will limit this IPI to
> only be sent to cpus referencing the effected mm and are currently in
> kernel space.

Did you validate that all architectures for which this is relevant
actually set bits in mm_cpumask() ?
