Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1F4577C00
	for <lists+linux-arch@lfdr.de>; Mon, 18 Jul 2022 08:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiGRG4n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Jul 2022 02:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbiGRG4m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Jul 2022 02:56:42 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72B4167ED;
        Sun, 17 Jul 2022 23:56:41 -0700 (PDT)
Received: from mail-yb1-f181.google.com ([209.85.219.181]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MJVU0-1ny0kx1c2y-00JtPU; Mon, 18 Jul 2022 08:56:39 +0200
Received: by mail-yb1-f181.google.com with SMTP id 64so19199713ybt.12;
        Sun, 17 Jul 2022 23:56:38 -0700 (PDT)
X-Gm-Message-State: AJIora9HVQWJxMWMQxYurz08T/RZee33V+Rzik4Y3m4GWR097cREk59G
        q2DzhZtA576lUzZDJxcesy+WwJnxcFjRvjkCDpQ=
X-Google-Smtp-Source: AGRyM1vU8FO4VvXqJJe8h9tVAzt2Xq6mwcu486wLt3r26bRZC2xoaFetO/g9AVKDxyN/6vE3AHk71rISOL1hLEeUK6E=
X-Received: by 2002:a25:8b8b:0:b0:669:b37d:f9cd with SMTP id
 j11-20020a258b8b000000b00669b37df9cdmr25660893ybl.394.1658127396964; Sun, 17
 Jul 2022 23:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220717033453.2896843-1-shorne@gmail.com> <20220717033453.2896843-3-shorne@gmail.com>
 <YtTjeEnKr8f8z4JS@infradead.org>
In-Reply-To: <YtTjeEnKr8f8z4JS@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Jul 2022 08:56:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1KJe4K5g1z-Faoxc9NhXqjCUWxnvk2HPxsj2wzG_iDbg@mail.gmail.com>
Message-ID: <CAK8P3a1KJe4K5g1z-Faoxc9NhXqjCUWxnvk2HPxsj2wzG_iDbg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] asm-generic: Add new pci.h and use it
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:yqxuXYN5hsqI4Jrcm3MxCIxnyETp/QVuLD+vjesiAIS0qH/8hQz
 5wDiRSw4jI5IIsbK4+C/ZkbLYBdtFYzU6gGPaS2swuSkkoKXxLv5VlIBN67KobtL7RQU7b2
 neJvGjrHOx4o4e7t6PsF477MNh8zLG9Xv309BWwIMxGbJqKAbEtB0wz4wimtP+5AY/YiKJi
 Iocz/maKXRSIfMcy46jMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:554zXko6Moo=:W8M9bXbKy1v1ICCR4iz8jo
 08fbRJNHG7vMU69bXST/L+XMwknWa3JYFUomCfUMbs94on9CpMPplRMw9EFOzJDXFQEPdXGgA
 u1ooO0dlwb4LG/jk7T3eJRd0XWA4jtIRQjIL8smzVn8L2vcj9aYkMRYYWV5GHavH4/EDxZHr1
 PkiZTxML9la/7IcZCiO2zfTzr1VRV3IInOj9Lzcslc+aFtcll3kbL1d7z2f++FBNcYl6yUsCr
 vsULRpiswI/MuJnliOmmI5zXc6mOC6TaBb+Qywhxx2QjDBkkVTy9cAYeEAD32nh8VQ2BZPPkP
 2ngHuUut0rPXNzH6lO6NrqGuiDzi9iL4G4TJnnwY37YPbh1PdtR8UFkgM160uI6Wk52oFfgCV
 p8xVOU044fVLAU0XpTNUkVFia8tty2NHuEmwS3jgpBW0oD7jETzSCvR+FKn9Y4n3jwlWv/Ej3
 tnnYOpcFVRm//Wzf27bBqlzBGiFVGZr1afy9mSZo9wn1a83VUB/g+qu2DHLMw1MGJxtkt4o2j
 hVBba7pUrxNfwIiL5ihqNEVzp6pHhWrDLF9ra5grRYSN+fxmGCJ1CN1b5VjEaGP4olh9syqZ4
 P79cc+Wtkt55+waqLpMw5d0RacE7a9mKKxzdM+7oIHASznsDJqDnfM48P5LrBaEG80TCk46RB
 Ci7lCXHxPOPJUywDPRK8J88AdK5/xeAISGKTl1Pxoe7LG+pERr4aXOJo/214Ihr9MrJyp/PkS
 8cDXOy0/JnF4Mz1C+YS+ZvfnlzEJ2PJNIVckfg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 18, 2022 at 6:37 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sun, Jul 17, 2022 at 12:34:53PM +0900, Stafford Horne wrote:
> > Two things to note are:
> >
> >  - isa_dma_bridge_buggy, traditionally this is defined in asm/dma.h but
> >    these architectures avoid creating that file and add the definition
> >    to asm/pci.h.
>
> This doesn't have anyting to do with PCI support.  I think adding a
> separate header just for this that always stubs it out unless a config
> option is set (which x86 then selects) is the besy idea here.  I also
> think the isa_dma_bridge_buggy needs to move out of the PCI code as
> well.

Most architectures have it in asm/dma.h, which is probably the right place
(if we end up keeping it), since this is for the ISA DMA API.

I would copy this declaration from x86

#ifdef CONFIG_PCI
extern int isa_dma_bridge_buggy;
#else
#define isa_dma_bridge_buggy (0)
#endif

to asm-generic/dma.h and remove it from arch/sh to avoid the
one duplicate definition. The architectures that have the declaration
in asm/pci.h (arm64, csky, riscv) already get the asm-generic version
of asm/dma.h.

As mentioned before, it would be even better to just remove it
entirely from everything except x86, and enclose the four
references in an explicit "#ifdef X86_32". The variable declaration
only exists because drivers/pci/quirks.c is compiled on all
architecture, but the individual quirk is only active  based on
the PCI device ID of certain early PCI-ISA bridges.

      Arnd
