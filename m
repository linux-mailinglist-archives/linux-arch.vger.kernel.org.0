Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA59C73F3A8
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 06:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjF0EqY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 00:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjF0Epu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 00:45:50 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153F72109
        for <linux-arch@vger.kernel.org>; Mon, 26 Jun 2023 21:44:21 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-573491c4deeso42692897b3.0
        for <linux-arch@vger.kernel.org>; Mon, 26 Jun 2023 21:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687841060; x=1690433060;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dVtrcXbE5qXWKdJhq2ArhetT4KPRpQBwbjTOuMnTdxE=;
        b=501HLYHctmk8sIJeTmzxhRx3/mgKpv1jRi1zyxe6IKd5PzvxEUvUlafEKoDqL6yZVr
         8LPzltfzYfOsnNGE3T6BklB22lAMitCgdhFuhtcXDNR8cn90bt0hxS6/rFyMCnKABSjm
         /oRswCkgkHFa78/d8yQxqLAP7w+UcywLgaNVEk0kQUj/E5gzTgG4U1Ib/QTJ68K6B1lq
         DHiArvPKR0yaKTV4AcdaFGyA0a3QVzlRHTqcAyQmjJhyBDsZIisDj9Axezm4VTj3plhb
         Dus4mDTAcMi1b8nttzH3dDwb6//iZcVcKmqu+MryYnw/GG09jfr1xcEP4Qfwx6utRJkj
         zVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687841060; x=1690433060;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVtrcXbE5qXWKdJhq2ArhetT4KPRpQBwbjTOuMnTdxE=;
        b=RW/W/JPSq0Yf6ySGD4/6Oz86QyKJtsMLSuSU0lTacHMCUqISTBiAphg6UytYnM5NGt
         HfdpEQU/PwfDRbdx6Q29urRe9YjNp6SH/2YocGsYBcQv6Sk6IoI1YQP93djRv4kvkBsh
         kebXLM3Ma2CcAOodt+FryZGJHradCQ09TRnT/V84IUYUuGp+xfHngvLQdaQDuJc5jhjk
         Dr7ExcckNuHPFz7TqvHufyM+chjBM24xsQO6H3eGFmPiIiZV1+4A6eGoRtIO52Bl5Yyh
         VPoH1v3f0WuRqSeFB7yuTGBEJdLUYL0XpRn3Xz2GUkvV1TXxAcydedA0V6e3lVcX8nDX
         fzAA==
X-Gm-Message-State: AC+VfDx/eK3lsX6heygZ1bkAgjGT04W5UzOPIxOzEQS/61zGkIbFugtP
        oT97dKqtlrjimBDNDvniWuiJNw==
X-Google-Smtp-Source: ACHHUZ4LBcIHJ/ynOcwzWzKYI9Mk2cjEWGfgZGpKdMoBZ7/XKupPMOzNiMbSCmgeKveyN334gs70/g==
X-Received: by 2002:a81:7bc2:0:b0:56d:43cb:da98 with SMTP id w185-20020a817bc2000000b0056d43cbda98mr29864359ywc.29.1687841059932;
        Mon, 26 Jun 2023 21:44:19 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j8-20020a252308000000b00bf44703efd3sm1487805ybj.6.2023.06.26.21.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 21:44:19 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:44:08 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "David S. Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v6 00/33] Split ptdesc from struct page
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
Message-ID: <e8992eee-4140-427e-bacb-9449f346318@google.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
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

On Mon, 26 Jun 2023, Vishal Moola (Oracle) wrote:

> The MM subsystem is trying to shrink struct page. This patchset
> introduces a memory descriptor for page table tracking - struct ptdesc.
...
>  39 files changed, 686 insertions(+), 455 deletions(-)

I don't see the point of this patchset: to me it is just obfuscation of
the present-day tight relationship between page table and struct page.

Matthew already explained:

> The intent is to get ptdescs to be dynamically allocated at some point
> in the ~2-3 years out future when we have finished the folio project ...

So in a kindly mood, I'd say that this patchset is ahead of its time.
But I can certainly adapt to it, if everyone else sees some point to it.

Hugh
