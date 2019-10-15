Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B189FD833C
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 00:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfJOWGs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Oct 2019 18:06:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39606 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfJOWGs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Oct 2019 18:06:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id p12so3640641pgn.6;
        Tue, 15 Oct 2019 15:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dYO7GjWloOND6hSPOAQvEuLC+MRq67dhIYtSI7PDZqA=;
        b=I5mFqjgmw/+rduOfSa7mdjY2+pVAum2a1hPeqtC+2baLDKGIK0Y9kG+jislEeUPrN0
         6DV9KDhYW84DcD4ZOgqof0Ysz/9vf2FbIiivaqgAiZKAxe4MoAamj0nEb47//Jfba8aq
         Lv550R4tE71yNe5+A0HCes9R/NvNAVKkr0bv6F18kU8HdY/9zGDiBSVqe+pQREv5OeAR
         Hx6KWY8JqRZYxAStOvrG9CLt1mzoDHyE7/LFTW786gem9sk42Q+p9sHczjGy/HxahiX7
         E3rpGfWcGXunrav4zcN4dI9ocfCE9TdunrQ2eKXi2VIbtDOfiP4G92GMIPPcraaI04S8
         sXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dYO7GjWloOND6hSPOAQvEuLC+MRq67dhIYtSI7PDZqA=;
        b=k0j/zvRl10UFN9OESvKw94Z4pqOdUCg/+mMGJFf75bRfnTpxeH8xhESA7hUP1Pjh+w
         XhIM6oMeSRcCJYZkvB4hmLu98vxmDs0MXiTjNEOoS4Ov1IkaPRb2K04RMgjICzg3KgLN
         9G3Oc3EPj24r+YNlt/OumNwrRMiV6L9VvA0Ugd7ViLKGaEAyloXDP69N6n7VecTGRmnF
         0P2ZcUfsO70dtcAeNl/ro7ra5gVGfi7hOe32WSec4HGG8ghzalTA06C9vpIhYTQuDq7s
         z1NJuOl5yGtBoJvdZ51fiJLzC2WSSRS1NRxPEFBz5/2JFYYH2lp4Ag7q0Wh7v/ccnfMb
         6L7A==
X-Gm-Message-State: APjAAAWjlkvnF9kVWXOyNEprkC4NlukoaIa15q1GZbVcAvdfIVRba+5z
        JxHo6KCSQU8jN3NyoT4WTyoA4GXPokgAkw==
X-Google-Smtp-Source: APXvYqxrxRkxDS61JrACgr6FX1z8oQ+rjZqY8ssnNx1gZukRLOwK/xG0kqhV2cKTvjvrk7K9ZLC6NQ==
X-Received: by 2002:a17:90a:6302:: with SMTP id e2mr878823pjj.20.1571177206148;
        Tue, 15 Oct 2019 15:06:46 -0700 (PDT)
Received: from [192.168.110.119] ([198.182.47.47])
        by smtp.gmail.com with ESMTPSA id o60sm292236pje.21.2019.10.15.15.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 15:06:44 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] ARC: mm: remove __ARCH_USE_5LEVEL_HACK
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
References: <20191015191926.9281-1-vgupta@synopsys.com>
 <20191015191926.9281-2-vgupta@synopsys.com>
 <CAHk-=wi3QC7tj3rmTPg5RmK_ugVKYs-jKqX=TaASWfd73Owaig@mail.gmail.com>
From:   Vineet Gupta <vineetg76@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vineetg76@gmail.com; prefer-encrypt=mutual; keydata=
 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
 deE0Dvw98SWmZSNtdOPnJZ0D
Message-ID: <a1aee16f-cde7-0bed-e1ab-f94b6268e4ff@gmail.com>
Date:   Tue, 15 Oct 2019 15:06:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wi3QC7tj3rmTPg5RmK_ugVKYs-jKqX=TaASWfd73Owaig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/15/19 2:48 PM, Linus Torvalds wrote:
> On Tue, Oct 15, 2019 at 12:19 PM Vineet Gupta
> <Vineet.Gupta1@synopsys.com> wrote:
>> This is a non-functional change anyways since ARC has software page walker
>> with 2 lookup levels (pgd -> pte)
>
> Could we encourage other architectures to do the same, and get rid of
> all uses of __ARCH_USE_5LEVEL_HACK?

IMHO this should have been done at the onset. The actual changes don't seem that
difficult, just need to add the missing p4d calls although I can sympathize with
hassles of coordinating/building/testing/yadi yada cross arch.

OTOH, the [45]LEVEL_HACK seem like a nice way to "fold" the levels: the
skipped/folded level vanishes completely. Among others it does things like

     #define p4d_t	pgd_t	

On ARC 2-level code:

   free_pte_range
	pmd_pgtable(*pmd);

	    ((((((*pmd).pud).pgd))) & PAGE_MASK));	     <-- 5LEVEL_HACK
			vs.
	    ((((((((*pmd).pud).p4d).pgd)))) & PAGE_MASK ));  <-- w/o 5LEVEL_HACK
	
	pmd_clear(pmd);

	    *(pmd)).pud).pgd)))) = 0
			vs.
	    *(pmd)).pud).p4d).pgd)))) = 0


So we may not be able to fix all he historical misgivigs, but this might alleviate
the pain a bit. I'll try to dabble a bit.

Thx for taking a look and te ACKs.
-Vineet
