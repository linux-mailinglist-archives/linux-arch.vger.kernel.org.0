Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF6757C033
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jul 2022 00:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiGTWmm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jul 2022 18:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiGTWmm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jul 2022 18:42:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83753491C6;
        Wed, 20 Jul 2022 15:42:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A50761D93;
        Wed, 20 Jul 2022 22:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2933FC341C7;
        Wed, 20 Jul 2022 22:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658356960;
        bh=1V98A2z1F38fHHvrHBoo3HaWj6yGKB/FnX3vGN/AvvA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=m79q/3nOeKxO56yGLe38LNngUjS5YlwsOdqK12cNE9FC0rQpA5M2cKg/8rHwh60Z5
         BPAAVPRoJ5JJmqHBUcAX4ttH61aNg6RrVZ65eqZElDOUIG3z1nT5nL8QdLrXM/RAi5
         y0YlLlcHVolcpqBmOq/O70j4oT9+v54KkULa09nMFF0etcuRk2rnIcjvozDv+tp+OV
         rqo9SjfsM4FuruB28UMpLNS7Oru40GeOfbHjKn3kYTXRQo98BK6Z3F6sfIuqGEW7Ik
         eCHm/TKEeRLSeVUFF5Bf/qzKi+i6Dt2/JQShBjFekRlJOmVNQaQUA+aekpY3hRDynf
         2QFzdbfgbYpxg==
Date:   Wed, 20 Jul 2022 17:42:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 3/3] asm-generic: Add new pci.h and use it
Message-ID: <20220720224238.GA1666095@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720131934.373932-4-shorne@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 20, 2022 at 10:19:34PM +0900, Stafford Horne wrote:
> The asm/pci.h used for many newer architectures share similar
> definitions.  Move the common parts to asm-generic/pci.h to allow for
> sharing code.
> 
> One thing to note:
> 
>  - ARCH_GENERIC_PCI_MMAP_RESOURCE, csky does not define this so we
>    undefine it after including asm-generic/pci.h.  Why doesn't csky
>    define it?
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/
> Acked-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> index 0aebc3488c32..016eb6b46dc0 100644
> --- a/arch/arm64/include/asm/pci.h
> +++ b/arch/arm64/include/asm/pci.h

> -extern int isa_dma_bridge_buggy;

Shouldn't this go in the previous patch?  The only definition of a
isa_dma_bridge_buggy variable is in drivers/pci/pci.c, and it's under
#ifdef CONFIG_X86_32.

Same for csky, riscv, um?
