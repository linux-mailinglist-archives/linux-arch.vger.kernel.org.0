Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB6AE2E73
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 12:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392129AbfJXKNW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Oct 2019 06:13:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35144 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391890AbfJXKNW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Oct 2019 06:13:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id l10so24973848wrb.2
        for <linux-arch@vger.kernel.org>; Thu, 24 Oct 2019 03:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=4e4CMe8f6py1Yt2lWLrn331C7GRW8uLQcBzyGRI9nf4=;
        b=cTWe2LNoVh1mOyCENVn7zpGv3Jprre8rDXIaPx76j+yvm1hAVwpu6ypxuWj/UlDG97
         I2oGLcNkL8BrxO7xHx2/ggo3DF85rMITBcd3ReMP4P9wlSe/Km4gkC2pZ+KiWQRbD1Ub
         oUOBZe7O6NpUfMuls2FITbvA/QIqoL2gGBGoTs3Sn6F5kl9WU1rliddwVhPBlkqkn9m1
         Lphmv7GnryVkgYA2cAn/Us7kHpjQ0Omkljg9UkRBs0ezBVER1StVBdwBnkO4Pzx7gs//
         2BwDWL51kb6jgX/pMfJ4olGJpU45RWhG1faxx4yo1ZoMybOydnuSGIvh54WChKjDxe8h
         lKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=4e4CMe8f6py1Yt2lWLrn331C7GRW8uLQcBzyGRI9nf4=;
        b=mpiLCjMATmiXnDX0Sn8h1ALmTWNDWNTlKOy11riZpksgJx1tAm61ZgcTc4E99T3e5L
         VnLJpfXoNHG/lC+zMqJ46BPx8RHQwZTcRdlH1tXgXL0+0I9YCfmRYA0H5bWRg/sV+FAR
         KSj2FTqBK7H7fV3k4FH7X7alfbyWu3v32pc5iU6tynIQ4W8cg7KVYjTltW60gQk0WxYd
         mnE8ASTKQDfa4yj0sX9Ku11laW2vXh/L7KJpdh4TDCQAIlpdJdI4lOSxiT7ypvW+VKI3
         lDwxavzjC/GfVNPyuS84jrDvGkRRiuDHvsUVhrICURt//cE978xeAjcerDm1cgkwloIm
         PwTw==
X-Gm-Message-State: APjAAAWh9EJU3n1fPN+y7eExxw70hi1+ELa2BIgAxhjfcF1geEj5hcng
        Ygo1rTWHIgxS0J2pzSao3HcWQQ==
X-Google-Smtp-Source: APXvYqwcFnA4ofb/Q4g7Tcra8udIzZaJReC4T76gGILoFLWpLp7LWZeYpE1c6/ZFH9jYdiQyaQs7MQ==
X-Received: by 2002:adf:92a5:: with SMTP id 34mr2881720wrn.337.1571911998458;
        Thu, 24 Oct 2019 03:13:18 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id i3sm20429658wrw.69.2019.10.24.03.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 03:13:17 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, palmer@sifive.com,
        hch@infradead.org, longman@redhat.com, helgaas@kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Wesley Terpstra <wesley@sifive.com>,
        Firoz Khan <firoz.khan@linaro.org>, sparclinux@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        James Hogan <jhogan@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Burton <paul.burton@mips.com>,
        Cornelia Huck <cohuck@redhat.com>,
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
Subject: [PATCH 0/2] Enabling MSI for Microblaze
Date:   Thu, 24 Oct 2019 12:13:10 +0200
Message-Id: <cover.1571911976.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

these two patches come from discussion with Christoph, Bjorn, Palmer and
Waiman. The first patch was suggestion by Christoph here
https://lore.kernel.org/linux-riscv/20191008154604.GA7903@infradead.org/
The second part was discussed
https://lore.kernel.org/linux-pci/mhng-5d9bcb53-225e-441f-86cc-b335624b3e7c@palmer-si-x1e/
and
https://lore.kernel.org/linux-pci/20191017181937.7004-1-palmer@sifive.com/

Thanks,
Michal


Michal Simek (1):
  asm-generic: Make msi.h a mandatory include/asm header

Palmer Dabbelt (1):
  pci: Default to PCI_MSI_IRQ_DOMAIN

 arch/arc/include/asm/Kbuild     | 1 -
 arch/arm/include/asm/Kbuild     | 1 -
 arch/arm64/include/asm/Kbuild   | 1 -
 arch/mips/include/asm/Kbuild    | 1 -
 arch/powerpc/include/asm/Kbuild | 1 -
 arch/riscv/include/asm/Kbuild   | 1 -
 arch/sparc/include/asm/Kbuild   | 1 -
 drivers/pci/Kconfig             | 2 +-
 include/asm-generic/Kbuild      | 1 +
 9 files changed, 2 insertions(+), 8 deletions(-)

-- 
2.17.1

