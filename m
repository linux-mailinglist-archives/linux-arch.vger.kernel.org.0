Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE55357B75E
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jul 2022 15:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiGTNYG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jul 2022 09:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGTNYF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jul 2022 09:24:05 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB674C61F;
        Wed, 20 Jul 2022 06:24:04 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c139so10187823pfc.2;
        Wed, 20 Jul 2022 06:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qoHI37+zVu7Qu074WZ6GrbYXTMMNTsp7PXDFTwcZApQ=;
        b=jkM4/VWCQKNXt88rlV4yLzjzVpZ+BxaEQxOTjHLxnMBf2F9hAAZVGP4bKTmw6kzeOK
         8Cyl1AfrpG6hcI+aVH5qnXjIxtIyyA+xNJ3s32sC5cYdNK1CgzQ/MxEv8mEi9xX+j7HP
         YwEOneXyP3+K8VHIha8VQnBbTl9TERdXgtXVSpJf1RjT/YXyCTyxfSKbpztOv422F6m7
         e4QPTSafxtGn8cok66RYZQLtTuI7JgfK4w/XpiM2K8hn2Scf0yaayaXkLIUXjtAXo/87
         iN7nt65xBQek8y08NkCpEtaGg68iEYDek68eZzh2P/1RqII9orvyXNymLrWg2R3u8CV/
         SyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qoHI37+zVu7Qu074WZ6GrbYXTMMNTsp7PXDFTwcZApQ=;
        b=NKWsMKFo9C0HsZdVZ4OHAV6DUqBXHvQK6QkQnWCPY2srn5gnqtBxUKw8PbULNi2ftQ
         0UB5KuogzqJ0aYBJAreSXLZEGUx3ojN5cldkbKZDRFmOsBFTS99u2I6zO8DGJdwU4nCf
         PK/EwHwiTJvbPl4d9jDXpJSqok6Jt1e9UKCYMZN7cGwponz8LVdLfAaE3Ta9mGlpZ5uT
         Pw/0I/RbJGR+GT317+0/3zXyvsKuVGW1o95XoH2JtYNW8PnDFgOgwWZQPCCJhMlSK8pH
         SCvGZN61Si7OTaThCkCfIDUVdAirXZwpfGT6OyTZTe52yQuGLlHUTlg3zX1AQNVV4FKS
         HbUA==
X-Gm-Message-State: AJIora97N3cd4TAjcafeTif3NdEs3/QlCENL+XDhk0rej497m9gRl76F
        cbDLjBg5HDPOZgXB1t+Oy4Q=
X-Google-Smtp-Source: AGRyM1sMVPCqO1HB0VzUyhf95qtf0daAcPdgM7eDHGhO9cf71JB8i8DeEBqMYiJ6/usOYcxxnT8BCQ==
X-Received: by 2002:a63:464b:0:b0:419:78b4:dcf1 with SMTP id v11-20020a63464b000000b0041978b4dcf1mr32196171pgk.500.1658323444156;
        Wed, 20 Jul 2022 06:24:04 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id h3-20020a63c003000000b00416018b5bbbsm11870969pgg.76.2022.07.20.06.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:24:03 -0700 (PDT)
Date:   Wed, 20 Jul 2022 22:24:01 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] asm-generic: Add new pci.h and use it
Message-ID: <YtgB8SDLB4d0adfB@antec>
References: <20220717033453.2896843-1-shorne@gmail.com>
 <20220717033453.2896843-3-shorne@gmail.com>
 <YtTjeEnKr8f8z4JS@infradead.org>
 <CAK8P3a1KJe4K5g1z-Faoxc9NhXqjCUWxnvk2HPxsj2wzG_iDbg@mail.gmail.com>
 <CAAfxs740yz1vJmtFHOPTXT6fqi0+37SR_OhoGsONe4mx_21+_g@mail.gmail.com>
 <CAK8P3a1Mo9+-t21rkP8SDnPrmbj3-uuVPtmHbeUerAevxN3TNw@mail.gmail.com>
 <YtaNvpE7AA/4eV1I@antec>
 <CAK8P3a2UTND+F83k2uQ+f=o1GWV=oa5coshy8Hy+cKHUGuNzEg@mail.gmail.com>
 <YtaiSEAnMhVqR4HS@antec>
 <874af766883a4c0da6759eff433ec6d6@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874af766883a4c0da6759eff433ec6d6@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 19, 2022 at 03:09:35PM +0000, David Laight wrote:
> From: Stafford Horne
> > Sent: 19 July 2022 13:24
> > 
> > On Tue, Jul 19, 2022 at 01:55:03PM +0200, Arnd Bergmann wrote:
> > > On Tue, Jul 19, 2022 at 12:55 PM Stafford Horne <shorne@gmail.com> wrote:

> > Option 3:
> > 
> > > Or we could try to keep the generic definition in a global header
> > > like linux/isa-dma.h.
> > 
> > Perhaps option 3 makes the whole patch the most clean.
> 
> Isn't there a define that can be used inside an if?
> So you could do:
> 		if (!IS_CONFIG_X86_32 || !isa_dma_bridge_buggy)
> 			disable_dma();
> (but I can't remember the name!)

I think you probably mean:

  if (IS_ENABLED(CONFIG_X86_32) ... )

That could work too, but we still want to move the definition of
isa_dma_bridge_buggy out of architectures and into the global header.  I have
gone with option 3 for now.

-Stafford
