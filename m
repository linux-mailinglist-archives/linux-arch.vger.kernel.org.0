Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 246BDD690A
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2019 20:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388681AbfJNSCo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Oct 2019 14:02:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36927 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731877AbfJNSCn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Oct 2019 14:02:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id p1so10531465pgi.4;
        Mon, 14 Oct 2019 11:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hc7ghuc+3ekx1ATFhRMzexaqjgYhAAp5Cpu89h0fpKE=;
        b=GhPw/VHL6m/jwIGK7ECBr1SuEjCCiwTfDiUGzPwL6KwtCeGFk14d+hAt8TC5AFNUFe
         PCmpbcDXxYsoch1LjouiPlPM7urzYM13qifMO/RUt4j5rbu6Cr9p/oNGF8JztItTyOJo
         0PbiLPh9yOPY+7zXgOTxVz/HNM7Z7unX8spgTdZmBojCYYefdMPzwZ9gJ1NF/8raHnf6
         3gnhzZ0OFP+zQZcyZf+fJ9jNzNqGTtU43HMZoFPhEDpc4vH/w8XRPjkgchTOqFDv9r2P
         tL9PZh9uQxW3TbMqnZRZLo5qBHv0ymiM5GBLLK44gkLspzCgDbSQyLoiZukaNqQ/FGbS
         sTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Hc7ghuc+3ekx1ATFhRMzexaqjgYhAAp5Cpu89h0fpKE=;
        b=mMcpPLu02PITVt3ya1FM9c1icwjGy6ntCvuGcH/GsVAkq+2MCC9nuN8xP9Jy7hTNni
         62za5ImLicFT8kULlSMSlkiKW1RNO3hn3I6ipKjepS2W2PN8CjbYOtUCjauVofPUxt93
         xZO/cizEJ7BN7klnbvAY5TBG4oiT95ggHgGxtax0TuFCZt9AFS8XOFAJ6xrgJoqovbqm
         CgTMG2jK7C2MULQkbd59KhsaKTLbcwEWgghcjGOWrWVpbp2mXp4BUl0sRBZBkUbwNyQ/
         abwMoMQgHOcfxgNxgH6jS4xkuHVKlVdUeEoZHGMwG/gweUvL1tEfCod6phjDW1jmJN5V
         oBXg==
X-Gm-Message-State: APjAAAU3CA7zGXCgOVTKp921MQGZk+U6WYU5PcNqGa6/KzPSOrFgRWVl
        df3Amg8JTsfbhErnaXgaYsA=
X-Google-Smtp-Source: APXvYqz6IKOKeTeSRnlWwPg/qD63GVF1rmIrNTp6bWFKehR/c5xHzlcpfI3RYVeX53j1di5dz6RzVQ==
X-Received: by 2002:a63:ba05:: with SMTP id k5mr14433657pgf.195.1571076162378;
        Mon, 14 Oct 2019 11:02:42 -0700 (PDT)
Received: from [192.168.110.119] ([198.182.47.47])
        by smtp.gmail.com with ESMTPSA id t125sm22717154pfc.80.2019.10.14.11.02.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 11:02:40 -0700 (PDT)
Subject: Re: [RFC] asm-generic/tlb: stub out pmd_free_tlb() if
 __PAGETABLE_PMD_FOLDED
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Piggin <npiggin@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-snps-arc@lists.infradead.org, Will Deacon <will@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20191011121951.nxna6hruuskvdxod@box>
 <20191011223818.7238-1-vgupta@synopsys.com>
 <CAHk-=whLs=TrRzmB9KRLxcPERq0QXPUUkbD8vzKzaDszBcUspg@mail.gmail.com>
From:   Vineet Gupta <vineetg76@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vineetg76@gmail.com; prefer-encrypt=mutual; keydata=
 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
 deE0Dvw98SWmZSNtdOPnJZ0D
Message-ID: <c0979d98-7236-b7c8-bd40-173ee2e87385@gmail.com>
Date:   Mon, 14 Oct 2019 11:02:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whLs=TrRzmB9KRLxcPERq0QXPUUkbD8vzKzaDszBcUspg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/14/19 10:41 AM, Linus Torvalds wrote:
> On Fri, Oct 11, 2019 at 3:38 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>>
>> This is inine with similar patches for nopud [1] and nop4d [2] cases.
> 
> I don't think your patch is wrong, but wouldn't it be easier and
> cleaner to just do this instead
> 
>     --- a/include/asm-generic/pgtable-nopmd.h
>     +++ b/include/asm-generic/pgtable-nopmd.h
>     @@ -60,7 +60,7 @@ static inline pmd_t * pmd_offset(pud_t * pud,
> unsigned long address)
>      static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
>      {
>      }
>     -#define __pmd_free_tlb(tlb, x, a)          do { } while (0)
>     +#define pmd_free_tlb(tlb, x, a)            do { } while (0)
> 
>      #undef  pmd_addr_end
>      #define pmd_addr_end(addr, end)                    (end)

I suppose we could but

(a) It would be asymmetric with the __p{u,4}d_free_tlb() changes in [1] and [2].
Do you  prefer [1] and [2] be repun along the same lines as you propose above ?

(b) IMHO p?d_free_tlb() under corresponding #ifndef *P?D_FOLDED is much clearer to
read as being stubbed out. But this is minor point.

Also would you care to shed light on my other question about not being able to
fold away pmd_clear_bad() despite PMD_FOLDED given the pmd macros actually
checking for pgd. Of all the people you are likely to have most insight on how the
pmd folding actually evolved and works :-)

Thx,
-Vineet

[1] http://lists.infradead.org/pipermail/linux-snps-arc/2019-October/006266.html
[2] http://lists.infradead.org/pipermail/linux-snps-arc/2019-October/006265.html
