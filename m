Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3C9E5558
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2019 22:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfJYUpF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Oct 2019 16:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfJYUpF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 25 Oct 2019 16:45:05 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDF862084C;
        Fri, 25 Oct 2019 20:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572036304;
        bh=NJ+WKmfKRhR8+SGv+N61qy5UYgwj40QkXtak7NdAe0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hAO/+ldMyc2wFvU1rB2jr0qbCqMxryeZV9hwR22nNQXYS8Yoc7HbfACHC2As3i6Vc
         mkFJYj1DrtmY9EnT1zuXju84hh/PR6Qga5KZ/9gScxEENzgefDYJE/RDM8zXrzUvMC
         M/ey0st6s4jumET4Gmw9cUl3goRr2Rat24VbPRnk=
Date:   Fri, 25 Oct 2019 15:45:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        palmer@sifive.com, hch@infradead.org, longman@redhat.com,
        Arnd Bergmann <arnd@arndb.de>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Wesley Terpstra <wesley@sifive.com>,
        Firoz Khan <firoz.khan@linaro.org>, sparclinux@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        James Hogan <jhogan@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Paul Burton <paul.burton@mips.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-snps-arc@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mips@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 0/2] Enabling MSI for Microblaze
Message-ID: <20191025204502.GA170580@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571983829.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 25, 2019 at 08:10:36AM +0200, Michal Simek wrote:
> Hi,
> 
> these two patches come from discussion with Christoph, Bjorn, Palmer and
> Waiman. The first patch was suggestion by Christoph here
> https://lore.kernel.org/linux-riscv/20191008154604.GA7903@infradead.org/
> The second part was discussed
> https://lore.kernel.org/linux-pci/mhng-5d9bcb53-225e-441f-86cc-b335624b3e7c@palmer-si-x1e/
> and
> https://lore.kernel.org/linux-pci/20191017181937.7004-1-palmer@sifive.com/
> 
> Thanks,
> Michal
> 
> Changes in v2:
> - Fix typo in commit message s/expect/except/ - Reported-by: Masahiro
> 
> Michal Simek (1):
>   asm-generic: Make msi.h a mandatory include/asm header
> 
> Palmer Dabbelt (1):
>   pci: Default to PCI_MSI_IRQ_DOMAIN
> 
>  arch/arc/include/asm/Kbuild     | 1 -
>  arch/arm/include/asm/Kbuild     | 1 -
>  arch/arm64/include/asm/Kbuild   | 1 -
>  arch/mips/include/asm/Kbuild    | 1 -
>  arch/powerpc/include/asm/Kbuild | 1 -
>  arch/riscv/include/asm/Kbuild   | 1 -
>  arch/sparc/include/asm/Kbuild   | 1 -
>  drivers/pci/Kconfig             | 2 +-
>  include/asm-generic/Kbuild      | 1 +
>  9 files changed, 2 insertions(+), 8 deletions(-)

I applied these to pci/msi for v5.5, thanks!
