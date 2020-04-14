Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB5A1A7008
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 02:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390446AbgDNA2B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Apr 2020 20:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390443AbgDNA2A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Apr 2020 20:28:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7951CC0A3BE2
        for <linux-arch@vger.kernel.org>; Mon, 13 Apr 2020 17:28:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b72so5277783pfb.11
        for <linux-arch@vger.kernel.org>; Mon, 13 Apr 2020 17:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Iab8a1FKfuOAzK+EtN5ksWX3Ch8SBZHLkolYH18vMow=;
        b=lct5lXl+IscuWLrw6XCAopB0jz61pOOckI0TmsidUgK4aX5mFUXIL+srhSrr7xsXiI
         R858On8eqIKqa3BXB4MJdWnfFhKywElGKTmO4z+5bqMcrhqViWsYCBSTHeu5VymTDvXy
         vzDM5SQexLRHSqiZTMW5uVEwHz6m0ToMk5ffxuaUr7dFrUjGIrbFJSlBk8RtMkG1HFta
         e9YzM1vFQZlEpZx+IwYLnAg7oi80UtsWCGSGE9hdWjS2nYrQr6DSDyUzhadbwcYpuzTu
         tfVONL2lwfWuYRw4uqk4mrPTFWRAPc4c1PM/LJ8V399ICf9ZbS1MhBB39wQOxCgx1dGp
         +4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Iab8a1FKfuOAzK+EtN5ksWX3Ch8SBZHLkolYH18vMow=;
        b=YyrtvCn5bwznSyB7M8/g/eRC1Z4c87UQcaVxXiqzSOhjo28TjKrUVXmWjPXKiXPDcL
         9PFY3UpP7sWtM9ri/Ayu6UnvopzrGBW1hTiiB/s7PmeXeQKA7oPDMQ65mPS6fQVpUZdK
         OX/qhNu9UmZWXQZHcoeGhdkYjkrJ5qNn27FnxfqGNuRCbVn39zRE+Qvzj4pDyJgCCZcm
         m16YzieEyAw3EP5u8EcCFg+kVvCdwK7gsaX+RtSfUV6dJ1ulV6DxnApTspcwJp4hIwrV
         cX64zJc4NK9ElyCW0e9UC9L2Er4tewALydl8Rr4qKFCr1noEosxtRu3FU9hthn+H1X6W
         19CQ==
X-Gm-Message-State: AGi0PuYa+oGPHh+NKgcSNhi/4nQ4ClaQWgErOy3xiMFI6M/nxTPSIonc
        Bsky4GnxMyTgx2OMxjtPOs1WhA==
X-Google-Smtp-Source: APiQypLZpjmT/ThpynRDdIZHTO4aZH7CnvngDUK8vlIGwZhBDCAfCPTuSg0ilh9qJ0MLoF72azaR+A==
X-Received: by 2002:a63:5724:: with SMTP id l36mr15697582pgb.366.1586824079677;
        Mon, 13 Apr 2020 17:27:59 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 132sm9849909pfc.183.2020.04.13.17.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 17:27:59 -0700 (PDT)
Date:   Mon, 13 Apr 2020 17:27:58 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Nicholas Piggin <npiggin@gmail.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 0/4] huge vmalloc mappings
In-Reply-To: <20200413125303.423864-1-npiggin@gmail.com>
Message-ID: <alpine.DEB.2.21.2004131727150.260270@chino.kir.corp.google.com>
References: <20200413125303.423864-1-npiggin@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 13 Apr 2020, Nicholas Piggin wrote:

> We can get a significant win with larger mappings for some of the big
> global hashes.
> 
> Since RFC, relevant architectures have added p?d_leaf accessors so no
> real arch changes required, and I changed it not to allocate huge
> mappings for modules and a bunch of other fixes.
> 

Hi Nicholas,

Any performance numbers to share besides the git diff in the last patch in 
the series?  I'm wondering if anything from mmtests or lkp-tests makes 
sense to try?

> Nicholas Piggin (4):
>   mm/vmalloc: fix vmalloc_to_page for huge vmap mappings
>   mm: Move ioremap page table mapping function to mm/
>   mm: HUGE_VMAP arch query functions cleanup
>   mm/vmalloc: Hugepage vmalloc mappings
> 
>  arch/arm64/mm/mmu.c                      |   8 +-
>  arch/powerpc/mm/book3s64/radix_pgtable.c |   6 +-
>  arch/x86/mm/ioremap.c                    |   6 +-
>  include/linux/io.h                       |   3 -
>  include/linux/vmalloc.h                  |  15 +
>  lib/ioremap.c                            | 203 +----------
>  mm/vmalloc.c                             | 413 +++++++++++++++++++----
>  7 files changed, 380 insertions(+), 274 deletions(-)
> 
> -- 
> 2.23.0
> 
> 
> 
