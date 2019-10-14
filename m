Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2CB5D68BD
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2019 19:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbfJNRlj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Oct 2019 13:41:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37546 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731313AbfJNRlj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Oct 2019 13:41:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id w67so12403110lff.4
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2019 10:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P799DeurAv7knAP/9jFPDE4m8m+46TvvpHN93XfkDjE=;
        b=HWWymbYdZnWtJmHwFOmPF1ZzJDaTOeayFZ5PwgDvPf6UmwnVngK8F0WL6ftDpUBt65
         6CA7fbK/RfBrDC+lGkPSzKjf3Py8iCvGuqPRh2kQkkDM55QsR1au+xiI2Z52IW4rOkCn
         s1q1W19Sc+umQVIDvAwB4blHAjaZuSeemBQjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P799DeurAv7knAP/9jFPDE4m8m+46TvvpHN93XfkDjE=;
        b=iSyNcY1DMcc6jdtWZ9CxGQkwDESgCOR/gR/dWz6IZNYuMsG8btkV9g/8Tw3jt5nKbA
         OGO7cJ8iqwTrvEh5DSOrnLz5OdIt7uTSfeYx/xk9/sv382CahhIXEaz6i+C3oH6O9GcQ
         W+rTfk3Hn1Q93LxwBIWnw/zOKOF3LkVcv9Eynz/YBS9Hzgt/m7mMgNy25I7fTt5JHEyJ
         /gMSrDFy9+636MbKcjEajBLiN0Mv3z6Ho04BbMOLaG57/rMXJF1z/JOKZ0SF6zOGc1lp
         SmG2Z4OlETcJ0+zocF+yzvZgnyC0XVT1gQ5imDxfYXrpySbYZ2aeyBER7TAsXpIc9Wcx
         BXKQ==
X-Gm-Message-State: APjAAAW0pKbrhq5fFWcVwu8pBjqrbAcD4cERw/jBrPDxgK2VkR03rk0a
        06BZOzG0K1K4i4Jj88thkb6Ljc/fEyU=
X-Google-Smtp-Source: APXvYqzG8tyNaS5Sohb5Bik8hUNowVNc/h6DwhFGq3p4RQeago1uJ0AFJM8iZ7xH8wixeIWmfsedcw==
X-Received: by 2002:a19:ac01:: with SMTP id g1mr18218183lfc.141.1571074897349;
        Mon, 14 Oct 2019 10:41:37 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 25sm4559481lje.58.2019.10.14.10.41.35
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 10:41:35 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 7so17474343ljw.7
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2019 10:41:35 -0700 (PDT)
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr19334971ljc.97.1571074895188;
 Mon, 14 Oct 2019 10:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191011121951.nxna6hruuskvdxod@box> <20191011223818.7238-1-vgupta@synopsys.com>
In-Reply-To: <20191011223818.7238-1-vgupta@synopsys.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Oct 2019 10:41:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLs=TrRzmB9KRLxcPERq0QXPUUkbD8vzKzaDszBcUspg@mail.gmail.com>
Message-ID: <CAHk-=whLs=TrRzmB9KRLxcPERq0QXPUUkbD8vzKzaDszBcUspg@mail.gmail.com>
Subject: Re: [RFC] asm-generic/tlb: stub out pmd_free_tlb() if __PAGETABLE_PMD_FOLDED
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-snps-arc@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 11, 2019 at 3:38 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
> This is inine with similar patches for nopud [1] and nop4d [2] cases.

I don't think your patch is wrong, but wouldn't it be easier and
cleaner to just do this instead

    --- a/include/asm-generic/pgtable-nopmd.h
    +++ b/include/asm-generic/pgtable-nopmd.h
    @@ -60,7 +60,7 @@ static inline pmd_t * pmd_offset(pud_t * pud,
unsigned long address)
     static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
     {
     }
    -#define __pmd_free_tlb(tlb, x, a)          do { } while (0)
    +#define pmd_free_tlb(tlb, x, a)            do { } while (0)

     #undef  pmd_addr_end
     #define pmd_addr_end(addr, end)                    (end)

and just rely on the regular "#ifndef pmd_free_tlb" in
include/asm-generic/tlb.h?

Completely untested.

              Linus
