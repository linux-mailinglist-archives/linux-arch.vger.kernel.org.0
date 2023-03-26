Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0436C92FE
	for <lists+linux-arch@lfdr.de>; Sun, 26 Mar 2023 09:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjCZHlH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Mar 2023 03:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZHlF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Mar 2023 03:41:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BF4868B
        for <linux-arch@vger.kernel.org>; Sun, 26 Mar 2023 00:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679816417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=51I4tYLSmoNnjzd854BdOPa0P0UjuvWyL9QlaGHcgJs=;
        b=A7TBBCbKqqqe7GCgCyiVkZ54pHQ3vfGqfGLUApUBr0w889hWlTT0O8TODkY9JPyIcUdixG
        Y0LDb0wS6W4atnG2oRnncGgAyHZN0F3GCFp5YKIIfrFmP4MP6BoVkBOItrwd2o6D9Ebbki
        Orxs5xW3Jy4zQms9Fn+ROVrM2b4nZF4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-Chlg0ZodPmmIkY_6mUH0WA-1; Sun, 26 Mar 2023 03:40:15 -0400
X-MC-Unique: Chlg0ZodPmmIkY_6mUH0WA-1
Received: by mail-qk1-f197.google.com with SMTP id 198-20020a370bcf000000b007468cffa4e2so2606191qkl.10
        for <linux-arch@vger.kernel.org>; Sun, 26 Mar 2023 00:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679816413;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=51I4tYLSmoNnjzd854BdOPa0P0UjuvWyL9QlaGHcgJs=;
        b=TmGN0JVrPyt7MjLxTV+E4Te+Ey7hwyjTnnw8S4nHHQUbMqCwkihz3EYOG8Cz0Rkfbo
         1LIAQmVqGi3aB/hdAA6dKk9PbRVXK0xR+i5G1WNzJiQVDVUVQz6KXRiTKuD1LGGLO/2S
         60BA7akpx+zTrMHAisOoqx0n4GCCBIm6s4l6hgcMrD1bmmq4dsbmC4vREBN2LiYAD6Wf
         gnNjNqcGDkwYbcPTQx8U0z8kXQ8lPbqflYTe050vDenA4fB2Ed9EkXJaR15I6GTYcQI2
         KasEYV+hKGR55WAWhjlXrrQUPF8km5n7fLrOQBhKK7kUk8BfuD7Rn8QdwAoC7zYGZx3w
         MSVw==
X-Gm-Message-State: AO0yUKWn21PeZu/PCkk99hlTxgTJkecxRwkwCh4EdsEByAo7Fkd8OATS
        ja5J2O+ZTHLTyngQXAeYjwtFPyrvzMppndrWgL8Ctu0rZcIa/iPxRkphAjHzetzDe1tCK7O1y2f
        wcKyal1bvlgU+FRRsWolDJA==
X-Received: by 2002:ac8:5702:0:b0:3e0:8c58:1dd with SMTP id 2-20020ac85702000000b003e08c5801ddmr14893678qtw.55.1679816413598;
        Sun, 26 Mar 2023 00:40:13 -0700 (PDT)
X-Google-Smtp-Source: AK7set/Tp4HbzbNknw4GmE88t4aB2nhlJ6hhgfENJoY/McVDZZctF2I+8vP2b95SwLcpq5wNnBRwcQ==
X-Received: by 2002:ac8:5702:0:b0:3e0:8c58:1dd with SMTP id 2-20020ac85702000000b003e08c5801ddmr14893667qtw.55.1679816413373;
        Sun, 26 Mar 2023 00:40:13 -0700 (PDT)
Received: from ypodemsk.tlv.csb (IGLD-84-229-251-248.inter.net.il. [84.229.251.248])
        by smtp.gmail.com with ESMTPSA id u17-20020ac87511000000b003e38f8d564fsm581391qtq.66.2023.03.26.00.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 00:40:12 -0700 (PDT)
Message-ID: <b88b37de44222a67bc5cf22798e84fb178b58725.camel@redhat.com>
Subject: Re: [PATCH] mm/mmu_gather: send tlb_remove_table_smp_sync IPI only
 to MM CPUs
From:   ypodemsk@redhat.com
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mtosatti@redhat.com,
        ppandit@redhat.com, alougovs@redhat.com,
        David Hildenbrand <david@redhat.com>
Date:   Sun, 26 Mar 2023 10:40:08 +0300
In-Reply-To: <20230324151259.GC27199@willie-the-truck>
References: <20230312080945.14171-1-ypodemsk@redhat.com>
         <20230320084902.GE2194297@hirez.programming.kicks-ass.net>
         <a6ee41b39f3f516aab0f7fb327620cb2a43eeaca.camel@redhat.com>
         <20230324151259.GC27199@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2023-03-24 at 15:13 +0000, Will Deacon wrote:
> On Wed, Mar 22, 2023 at 04:11:44PM +0200, ypodemsk@redhat.com wrote:
> > On Mon, 2023-03-20 at 09:49 +0100, Peter Zijlstra wrote:
> > > On Sun, Mar 12, 2023 at 10:09:45AM +0200, Yair Podemsky wrote:
> > > > Currently the tlb_remove_table_smp_sync IPI is sent to all CPUs
> > > > indiscriminately, this causes unnecessary work and delays
> > > > notable
> > > > in
> > > > real-time use-cases and isolated cpus, this patch will limit
> > > > this
> > > > IPI to
> > > > only be sent to cpus referencing the effected mm and are
> > > > currently
> > > > in
> > > > kernel space.
> > > 
> > > Did you validate that all architectures for which this is
> > > relevant
> > > actually set bits in mm_cpumask() ?
> > > 
> > Hi Peter,
> > Thank you for bringing this to my attention.
> > I reviewed the architectures using the MMU_GATHER_RCU_TABLE_FREE:
> > arm, powerpc, s390, sparc and x86 set the bit when switching
> > process
> > in.
> > for arm64 removed set/clear bit in 38d96287504a ("arm64: mm: kill
> > mm_cpumask usage")
> > The reason given was that mm_cpumask was not used.
> > Given that we now have a use for it, I will add a patch to revert.
> 
> Maintaining the mask is also not free, so I'm not keen on adding it
> back
> unless there's a net win.
> 
> Will
> 
How about adding a Kconfig to mark which architectures set/use the
mm_cpumask?
This will allow us to use the mm_cpumask on architectures that support
it, and use acpu_online_mask on those that don't.
Also make it clear which architectures set the bit for the future.
Yair

