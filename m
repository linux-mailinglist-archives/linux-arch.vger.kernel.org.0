Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC1D57B74C
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jul 2022 15:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiGTNVW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jul 2022 09:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiGTNVV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jul 2022 09:21:21 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB9B3FA3F;
        Wed, 20 Jul 2022 06:21:20 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r186so16379967pgr.2;
        Wed, 20 Jul 2022 06:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kkXoj+qRduj7qTMK4wk6bSavIb9EMzMuh8HC0Q0nrLk=;
        b=jQ6dX9nCD5D/DxdQW23LRNMfGlUAuEwuaP/RNO4rJfNhep1BaxhgsLIM1CqTfUp6uZ
         o0POAHKQW9W+z0rrbNRFWZNsJBLEOz8EBbaw73ers5GPX9FAQAu+r5jn/UvInipkgs4a
         3gw7hNdLdwAd4/+g0ByAir2ePNPNzvMLKu/WJzP6ta+74Qd//pA3R1UKVJb31QoBs13c
         zQLttdc00sMa8sioPAXa+3AdnSntToir+4Vk27yBf2oTxpEaDNwSPk9Eiz/cDDtcFbB0
         Wh8mg3Q9xNCMNal8hXslUMwO51OwFniWdUCX9oBF8FMgv2A942cpcCpxF2ll7GaxW6nH
         DLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kkXoj+qRduj7qTMK4wk6bSavIb9EMzMuh8HC0Q0nrLk=;
        b=xvuF3IJbx1rPscfC2C6N1l+R8WA87DOUz8VA++Prox5CbgJWm/hhGSwlDSEIhU4sqj
         xBy1A1aWZ5Q0pO07jNdY71d4E+yMP0R5+6bmCRgw1/VGLNZJrvQyar+/W2KKUxeavUK9
         Lh/qANnaxvAWg2LmoTBVXSo11EMjSab20pfR0mK5gZoinluKAVpWmmd88/XxpEOvblCi
         MzNatTZSYF2tn2DNZtvO2FIxM1CzD5ngOaQcC7BxgzL8yFF0tn7+0ddV27e0Futiq5YO
         cUXKYAf+A5Ne9HRxZwbcFNEtuhiUImwgWw7ChenKtJeBaPHhhwA243dXdkxBqhgipPk1
         18iw==
X-Gm-Message-State: AJIora+OzDSHLhTLpA45ekGiCbnrzg4hYZwKVDLwV8+gFkihx/s3p4Hb
        dVqN79xv/NAnB7nq12Ae8ss=
X-Google-Smtp-Source: AGRyM1voG/cBkqWxwFzO1B88vQuX5jEvcrxTRuhs985ZhRpdZRNiAoO7QgcQORY/zAroDGgcuEz/0g==
X-Received: by 2002:a63:1f4b:0:b0:41a:daa:3068 with SMTP id q11-20020a631f4b000000b0041a0daa3068mr16866885pgm.330.1658323280131;
        Wed, 20 Jul 2022 06:21:20 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b0016cf195eb16sm6815532plh.185.2022.07.20.06.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:21:19 -0700 (PDT)
Date:   Wed, 20 Jul 2022 22:21:17 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] asm-generic: Add new pci.h and use it
Message-ID: <YtgBTaP/O32ANOHU@antec>
References: <20220717033453.2896843-3-shorne@gmail.com>
 <YtTjeEnKr8f8z4JS@infradead.org>
 <CAK8P3a1KJe4K5g1z-Faoxc9NhXqjCUWxnvk2HPxsj2wzG_iDbg@mail.gmail.com>
 <CAAfxs740yz1vJmtFHOPTXT6fqi0+37SR_OhoGsONe4mx_21+_g@mail.gmail.com>
 <CAK8P3a1Mo9+-t21rkP8SDnPrmbj3-uuVPtmHbeUerAevxN3TNw@mail.gmail.com>
 <YtaNvpE7AA/4eV1I@antec>
 <CAK8P3a2UTND+F83k2uQ+f=o1GWV=oa5coshy8Hy+cKHUGuNzEg@mail.gmail.com>
 <YtaiSEAnMhVqR4HS@antec>
 <YtasKiPrkFlBXZvh@antec>
 <YtbAjsDkVt1a6c08@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtbAjsDkVt1a6c08@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 19, 2022 at 07:32:46AM -0700, Christoph Hellwig wrote:
> On Tue, Jul 19, 2022 at 10:05:46PM +0900, Stafford Horne wrote:
> > > > Or we could try to keep the generic definition in a global header
> > > > like linux/isa-dma.h.
> > > 
> > > Perhaps option 3 makes the whole patch the most clean.
> > 
> > And this is the result, I will get this into the series and create a v4 tomorrow
> > if no issues.
> 
> Yes, this is what I tried to suggest earlier and it looks fine to me.
> If we want to overengineer it we could add a ISA_DMA_BRIDGE_BUGGY
> Kconfig symbol and select it from x86.

I left it as X86_32, I feel it it would be more confusing/hard to maintain to
add the extra level of indirection.

-Stafford
