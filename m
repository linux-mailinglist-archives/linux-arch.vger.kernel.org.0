Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601E9740463
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 22:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjF0UOE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 16:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjF0UOD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 16:14:03 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F371B2
        for <linux-arch@vger.kernel.org>; Tue, 27 Jun 2023 13:14:00 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-39ecf031271so4404128b6e.1
        for <linux-arch@vger.kernel.org>; Tue, 27 Jun 2023 13:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687896840; x=1690488840;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Omz0x3K5VJ2j7KfDH2649X9QbCItdU3t+DCvtH+dE30=;
        b=qLT/FXnF9fYy8bz41ZGqzPs/xLiMCCfewgfWuzZzcLVjcItB7JcMRZfi6IZL1dCSx3
         OsWOmERj0hyOKFLw3jnnNfW5CTsqZqse181Md9/KF69O7aJpxHwXe5KyY7KekYXV4G1r
         zVWUAFUddyly86sbQfglXGlLJ+Dw6fbYNcanLL/4qX6MAv9NG432kDe3kyebDDkyTfob
         goI5J8lS8Nlzpf0h6eGjsC3OSSCP5RIprmv8BuvIbtDrufzgn/Q2le4t+ExH2qGopi70
         i11eeGh9ltkwfbMdr3qGqDnVah9352dUuKEVj6Z46bgWdO+OozUTmUPxCUjV8K1vxlvi
         swng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687896840; x=1690488840;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Omz0x3K5VJ2j7KfDH2649X9QbCItdU3t+DCvtH+dE30=;
        b=grETJtZMuFrybvqCQVZ3Y7TWy9S5ZGk/raqFInvtY/bJemRUokkquIe63tnQAENrQd
         v9VURFiM3+TnSk0bVlmQYbaMxl0PiANF7/ZpX91IFpRohI3eADNEZB9P5el+2p2X6/bf
         YK8jCMr0P59+NBzJ8ZaXIPXtjDYybccudHNSU0qIvPlnQriJZQznvzRkYR6S1dQBM1TH
         k2W7ZwXtOQ6mbbb4J+jasyaEBmACCTpHxcf9p5kGftqlZlhEO/VyokL0TDT+ooPv0CRZ
         mdaC9glsfCYZz6kK4uZRqygUAGM7wlR0dQxVrVee2RpwE0IfCQox+3X2Rw92b29C6EAr
         o1nw==
X-Gm-Message-State: AC+VfDxqljti/1n36mVZAiYC5j9zUAeVB1NgPXuGS/wvz3CAxGfMi6s9
        JExlVvPvAPkp0AG3u1yFZ6KglA==
X-Google-Smtp-Source: ACHHUZ7e3joAt7KSpSbDLhKkkEe6hRd92o1ATH/0oO6vi+mlTpkmMRcA4IUypqa5SFzU0uL+mRFuMQ==
X-Received: by 2002:a05:6359:2af:b0:133:9da:8d9f with SMTP id ek47-20020a05635902af00b0013309da8d9fmr5361549rwb.14.1687896839740;
        Tue, 27 Jun 2023 13:13:59 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q131-20020a817589000000b00565eb8af1fesm1991442ywc.132.2023.06.27.13.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 13:13:59 -0700 (PDT)
Date:   Tue, 27 Jun 2023 13:13:49 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     David Hildenbrand <david@redhat.com>
cc:     Hugh Dickins <hughd@google.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "David S. Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v6 00/33] Split ptdesc from struct page
In-Reply-To: <ac1c162c-07d8-6084-44ca-a2c1a4183df2@redhat.com>
Message-ID: <90e643ca-de72-2f4c-f4fe-35e06e1a9277@google.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com> <e8992eee-4140-427e-bacb-9449f346318@google.com> <ac1c162c-07d8-6084-44ca-a2c1a4183df2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 27 Jun 2023, David Hildenbrand wrote:
> On 27.06.23 06:44, Hugh Dickins wrote:
> > On Mon, 26 Jun 2023, Vishal Moola (Oracle) wrote:
> > 
> >> The MM subsystem is trying to shrink struct page. This patchset
> >> introduces a memory descriptor for page table tracking - struct ptdesc.
> > ...
> >>   39 files changed, 686 insertions(+), 455 deletions(-)
> > 
> > I don't see the point of this patchset: to me it is just obfuscation of
> > the present-day tight relationship between page table and struct page.
> > 
> > Matthew already explained:
> > 
> >> The intent is to get ptdescs to be dynamically allocated at some point
> >> in the ~2-3 years out future when we have finished the folio project ...
> > 
> > So in a kindly mood, I'd say that this patchset is ahead of its time.
> > But I can certainly adapt to it, if everyone else sees some point to it.
> 
> I share your thoughts, that code churn which will help eventually in the far,
> far future (not wanting to sound too pessimistic, but it's not going to be
> there tomorrow ;) ).
> 
> However, if it's just the same as the other conversions we already did (e.g.,
> struct slab), then I guess there is no reason to stop now -- the obfuscation
> already happened.
> 
> ... or is there a difference regarding this conversion and the previous ones?

I was aware of the struct slab thing, didn't see much point there myself
either; but it was welcomed by Vlastimil, and barely affected outside of
slab allocators, so I had no reason to object.

You think that if a little unnecessary churn (a *lot* of churn if you
include folios, which did save some repeated calls to compound_head())
has already occurred, that's a good precedent for allowing more and more?
My opinion happens to differ on that.

Hugh
