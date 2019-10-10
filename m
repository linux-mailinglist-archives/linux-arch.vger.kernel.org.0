Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE65D31CD
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 22:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfJJUGC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 16:06:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41804 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJUGB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 16:06:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id t3so4341182pga.8;
        Thu, 10 Oct 2019 13:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=br9hyO7JC3RSUTqbjhJbUfqMlwXApKkFxnX4w1MXGCQ=;
        b=K9a96MVjtsfhN/5/PSh9815fkbwuUhBF24bQLz9szxD5g2p0w0NZhm4HWjamqOYwjG
         S9G4M5z//7QfhaRRsGVziP09/yTLaJUvOCFQWmsL/ysexyuFlAmtBWUixfs881Qxt0Q1
         Bbt298OQ6nXnT46qo4Fg80lz/PO8ifbkdzit6mDcUieNTREzg5tsMzXU+hXZIMWaXQSa
         Wb7chnXQ0jJxReJ+tIkeqGMJZnZuL/6YIc8+pAx5r9hNBZuagzZ0RmP+wNCjonLBAeBX
         HdVghMcgctQST0rW3EPM+h/bSC4XN50OTEiKH56QdJMjf9aRxORy4DYFpuyxptAXAncv
         90Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=br9hyO7JC3RSUTqbjhJbUfqMlwXApKkFxnX4w1MXGCQ=;
        b=VwVPW6tLAaLXVm42myl1vsbY01RwVSqxCb0RanKAVV59D3DYgbYLokATpwHaJ3PMcy
         7kMC1zbRkAOP3O68ZYdA3Mmj2BGsp++55KnsPO5S53/4aBdLxHsFuyvC/PjN0r1tvj05
         Q3ayUT9tPI5NIuv6dgVA8srdSGagBNx5ouWviFbxu5HDkDDkdvtnoA2jipdDadiZPJOS
         w1AiIytZm48ZmLdOYNIV06WkIZLiad/LHMFTZYlbrCDFnNh1sFnEkdRH++cx+0VGmPcF
         sB3DiHkeFr7HI1VVhWrNHhZZk5vgmLMkV9t0J/W5Sr2uCGoUbEv3gt8/J/yZpA+6CnSu
         lDhA==
X-Gm-Message-State: APjAAAVibnGO6VPG3TX5DCET7R3OUzsuzTYfWweT4f3PZyY+J0zZGnk6
        sMfe4D6vWNcmNNOlA1FkD2o=
X-Google-Smtp-Source: APXvYqyVU1Vm9EDwG+OZHYYBBR6Tbgz+4AtT9Ka2aCz7uhvoY1VbvLnRYoYtNmBwnQX5YGVYv59rYA==
X-Received: by 2002:a63:4e10:: with SMTP id c16mr12745671pgb.136.1570737959330;
        Thu, 10 Oct 2019 13:05:59 -0700 (PDT)
Received: from ?IPv6:2601:641:c100:83a0:7d35:e452:d420:a5d1? ([2601:641:c100:83a0:7d35:e452:d420:a5d1])
        by smtp.gmail.com with ESMTPSA id i74sm7230784pfe.28.2019.10.10.13.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 13:05:57 -0700 (PDT)
Subject: Re: [PATCH 0/3] eldie generated code for folded p4d/pud
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Nick Piggin <npiggin@gmail.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-snps-arc@lists.infradead.org, Will Deacon <will@kernel.org>
References: <20191009222658.961-1-vgupta@synopsys.com>
 <20191010085609.xgwkrbzea253wmfg@black.fi.intel.com>
From:   Vineet Gupta <vineetg76@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vineetg76@gmail.com; prefer-encrypt=mutual; keydata=
 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
 deE0Dvw98SWmZSNtdOPnJZ0D
Message-ID: <8ba067a6-8b6a-2414-0f04-b251cd6bb47c@gmail.com>
Date:   Thu, 10 Oct 2019 13:05:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010085609.xgwkrbzea253wmfg@black.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Hi Kirill,

On 10/10/19 1:56 AM, Kirill A. Shutemov wrote:
> On Wed, Oct 09, 2019 at 10:26:55PM +0000, Vineet Gupta wrote:
>>
>> This series elides extraneous generate code for folded p4d/pud.
>> This came up when trying to remove __ARCH_USE_5LEVEL_HACK from ARC port.
>> The code saving are not a while lot, but still worthwhile IMHO.
> 
> Agreed.

Thx.

So given we are folding pmd too, it seemed we could do the following as well.

+#ifndef __PAGETABLE_PMD_FOLDED
 void pmd_clear_bad(pmd_t *);
+#else
+#define pmd_clear_bad(pmd)        do { } while (0)
+#endif

+#ifndef __PAGETABLE_PMD_FOLDED
 void pmd_clear_bad(pmd_t *pmd)
 {
        pmd_ERROR(*pmd);
        pmd_clear(pmd);
 }
+#endif

I stared at generated code and it seems a bit wrong.
free_pgd_range() -> pgd_none_or_clear_bad() is no longer checking for unmapped pgd
entries as pgd_none/pgd_bad are all stubs returning 0.

This whole pmd folding is a bit confusing considering I only revisit it every few
years :-) Abstraction wise, __PAGETABLE_PMD_FOLDED only has pgd, pte but even in
this regime bunch of pmd macros are still valid

    pmd_set(pmdp, ptep) {
        *pmdp.pud.p4d.pgd = (unsigned long)ptep
    }

Is there a better way to make a mental model of this code folding.

In an ideal world pmd folded would have meant pmd_* routines just vanish - poof.
So in that sense I like your implementation under #[45]LEVEL_HACK where the level
simply vanishes by code like #define p4d_t pgd_t. Perhaps there is lot of historic
baggage, proliferated into arch code so hard to untangle.

Thx,
-Vineet
