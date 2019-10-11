Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7345D3F56
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 14:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfJKMTy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 08:19:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42354 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfJKMTy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Oct 2019 08:19:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so9582838lje.9
        for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2019 05:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n9TW/HRe8d6mz4MQKhjPNO1PuLOYHluTJjNubX7sfzE=;
        b=dcXZ61tRqDpeGyGapLhTvELR9pMmEjlU53H4BbUz/JaJ3WO3hx84ErbKazu7xtKoKW
         gvfMB/6EjJI8i+G890KgefdzxLr6S1o9w430ETPzkjAgdOP3l6l7ixOEThpqumgeBE79
         yFf5+SbM3GAjhnHfb/2lFglO+G1/u+qEVoh+6kFuwnvZMHgvU9mHqq45wrT4hVF2CZ/V
         nOEak8d7761PnYr0dhcs16wc/cnH3Dsw+uB2anDBfGq2iKT2kjiQ3OI2EAOBkr7y0GrI
         Zjo4zkuTZyH8+5GZzq4yNm64xgg5q+9qrdsHcivByH0oX+mhqy2KnAzFo6Brv2OiVRvb
         8aWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n9TW/HRe8d6mz4MQKhjPNO1PuLOYHluTJjNubX7sfzE=;
        b=uh8wBomPjr1MKzF5W2b1EZa6AuUvhGNOMm5iWmIFeruz4OvMbewbAtSw2cXtLt8kbR
         eBR5qYS9O4/8qOxSUhnHM8Tu0g7/5eu+V0EC2cdzBhpkDQJ5/KZ7aeUygmWcjhYLznyr
         17879mUe4NtYw5IWB/Er4/OuiOOmSh4a/AeiVUgwHljIQ3DUqikXtk8rPjtyY7szrRZr
         wjXDmLHhvtS9CH9liiDkCTmUqGzRiVfxmhLr9Y7wVhH+5E1UmcBh7NLCsz9iEMqJ3Wqb
         o5FSuzhU3rt2PQx04fBN+YXHJQ2+KS9+pgXGpD0bv5etdv+i2qh9DaUUJJFy0UPPhzVa
         bobg==
X-Gm-Message-State: APjAAAW7pLhYOTR7trzq2NEcEpWRtztD9tbrKvUD2YWpbxq6xzGe1ycT
        v86j79lsMKWJZGFiM7hwILlxLQ==
X-Google-Smtp-Source: APXvYqwZoc4fM1naaPJ7w+PtjiadfJ4JzznLHAw4a73DhoKiP8rjYFSUvqrrjtzyxw6vnYfFdWEnyA==
X-Received: by 2002:a2e:9913:: with SMTP id v19mr8829129lji.234.1570796392539;
        Fri, 11 Oct 2019 05:19:52 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v22sm1868024ljh.56.2019.10.11.05.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 05:19:51 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 93D6C102DC1; Fri, 11 Oct 2019 15:19:51 +0300 (+03)
Date:   Fri, 11 Oct 2019 15:19:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vineet Gupta <vineetg76@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Nick Piggin <npiggin@gmail.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-snps-arc@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 0/3] eldie generated code for folded p4d/pud
Message-ID: <20191011121951.nxna6hruuskvdxod@box>
References: <20191009222658.961-1-vgupta@synopsys.com>
 <20191010085609.xgwkrbzea253wmfg@black.fi.intel.com>
 <8ba067a6-8b6a-2414-0f04-b251cd6bb47c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ba067a6-8b6a-2414-0f04-b251cd6bb47c@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 10, 2019 at 01:05:56PM -0700, Vineet Gupta wrote:
> 
> Hi Kirill,
> 
> On 10/10/19 1:56 AM, Kirill A. Shutemov wrote:
> > On Wed, Oct 09, 2019 at 10:26:55PM +0000, Vineet Gupta wrote:
> >>
> >> This series elides extraneous generate code for folded p4d/pud.
> >> This came up when trying to remove __ARCH_USE_5LEVEL_HACK from ARC port.
> >> The code saving are not a while lot, but still worthwhile IMHO.
> > 
> > Agreed.
> 
> Thx.
> 
> So given we are folding pmd too, it seemed we could do the following as well.
> 
> +#ifndef __PAGETABLE_PMD_FOLDED
>  void pmd_clear_bad(pmd_t *);
> +#else
> +#define pmd_clear_bad(pmd)        do { } while (0)
> +#endif
> 
> +#ifndef __PAGETABLE_PMD_FOLDED
>  void pmd_clear_bad(pmd_t *pmd)
>  {
>         pmd_ERROR(*pmd);
>         pmd_clear(pmd);
>  }
> +#endif
> 
> I stared at generated code and it seems a bit wrong.
> free_pgd_range() -> pgd_none_or_clear_bad() is no longer checking for unmapped pgd
> entries as pgd_none/pgd_bad are all stubs returning 0.
> 
> This whole pmd folding is a bit confusing considering I only revisit it every few
> years :-) Abstraction wise, __PAGETABLE_PMD_FOLDED only has pgd, pte but even in
> this regime bunch of pmd macros are still valid
> 
>     pmd_set(pmdp, ptep) {
>         *pmdp.pud.p4d.pgd = (unsigned long)ptep
>     }
> 
> Is there a better way to make a mental model of this code folding.

I don't have any. PMD folding predates me and have never looked at it
closely. Quick look brings more confusion than clarity. :P

> In an ideal world pmd folded would have meant pmd_* routines just vanish - poof.
> So in that sense I like your implementation under #[45]LEVEL_HACK where the level
> simply vanishes by code like #define p4d_t pgd_t. Perhaps there is lot of historic
> baggage, proliferated into arch code so hard to untangle.

In ideal world all these pgd/p4d/pud/pmd/pte should die and we have
something more flexible to begin with.

I played with this before:

https://lore.kernel.org/lkml/20180424154355.mfjgkf47kdp2by4e@black.fi.intel.com/

-- 
 Kirill A. Shutemov
