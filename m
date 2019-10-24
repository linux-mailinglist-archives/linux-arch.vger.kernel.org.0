Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8ABE3657
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 17:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503030AbfJXPSK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Oct 2019 11:18:10 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:45842 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503021AbfJXPSJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Oct 2019 11:18:09 -0400
Received: by mail-il1-f195.google.com with SMTP id u1so22732425ilq.12
        for <linux-arch@vger.kernel.org>; Thu, 24 Oct 2019 08:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Ounxj9cfL6O+QVspuA41qPrL+dtHlnd6zlmABTsVbws=;
        b=biNiyBsUq1oC7u5yogZy8N29MX7ATTQIXUIPIqqI6g2N8EA9QhwEC0gQemO8Cy5L6a
         UCFg3RDAYG9lnvohF8+tXuDf+IXq7fLq3dVHXnLyE5vPEUz/DrCR7X3R288BYePyqXg3
         oYLT/wTPksWncWN9bXdK0yZ0nbFI3oEoJl84Ht2i67n/365THu308Y+OSHFJ18vXXUqR
         ENefMt09zBo4nBburoq/NmiNK2bRI59OT7KW1kTA/yDrLysLajr6fUNNc1LVC2TMXMzE
         JIj7P2KKqLbrHsjaQFkGpARY6E99HHxeUwRHMbgsRgF/uSl1vSWl2lvW9K349Ga0HXcy
         1zXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Ounxj9cfL6O+QVspuA41qPrL+dtHlnd6zlmABTsVbws=;
        b=lDWgeo/pORxKvDQzSET8/ARxkCT2CNHWpxTcebKm+6kYIIeVdhu4QMM1oHLcymb5HK
         VMHNGVb7CcS7rBD+/XTvtwk/mFelYdVLORz35XBNH8IDgOqZmhvyI2YZWPZEo3PmKUcv
         CrvBAR8NQDxK5QOVFuq5Wf2tPmVUh7XWqf8MUYbQk53n5Wblv8QhdIX6sNojdXCi6jLJ
         cfd/p/6f6Kkbv6+QQY0lQypun9btCtKqg4KW+EvUz116Th8e9PK1Ixdrdau2CIf787a/
         dlYjetXPelaciWwFER1Y3CzSjRlK7FGLJikJFI67+USByrnWZ1XQoH3tSS9U64KSL7lo
         T8qg==
X-Gm-Message-State: APjAAAXoY4saVm+gvVdKa37BFd2thc8vGL8slZFYZ300IIrzocBEahUs
        5pBltYu0xB/0m6p/0HpMWfSS2g==
X-Google-Smtp-Source: APXvYqxQ1LtEDnMpoN971luqOI7TbH4CJsi6LuiXRaB4c6bbMVkSBP/cjpjqc6MBqdQnstOla4Sq8g==
X-Received: by 2002:a92:8fc6:: with SMTP id r67mr43423606ilk.5.1571930288560;
        Thu, 24 Oct 2019 08:18:08 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id y5sm7755183ilm.63.2019.10.24.08.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:18:07 -0700 (PDT)
Date:   Thu, 24 Oct 2019 08:17:59 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Michal Simek <michal.simek@xilinx.com>
cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        palmer@sifive.com, hch@infradead.org, longman@redhat.com,
        helgaas@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Wesley Terpstra <wesley@sifive.com>,
        Firoz Khan <firoz.khan@linaro.org>, sparclinux@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        James Hogan <jhogan@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
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
Subject: Re: [PATCH 1/2] asm-generic: Make msi.h a mandatory include/asm
 header
In-Reply-To: <a021f232968cfffe3f2d838da47214c6bbdeeedb.1571911976.git.michal.simek@xilinx.com>
Message-ID: <alpine.DEB.2.21.9999.1910240810420.20010@viisi.sifive.com>
References: <cover.1571911976.git.michal.simek@xilinx.com> <a021f232968cfffe3f2d838da47214c6bbdeeedb.1571911976.git.michal.simek@xilinx.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-165076562-1571930279=:20010"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-165076562-1571930279=:20010
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 24 Oct 2019, Michal Simek wrote:

> msi.h is generic for all architectures expect of x86 which has own versio=
n.
> Enabling MSI by including msi.h to architecture Kbuild is just additional
> step which doesn't need to be done.
> The patch was created based on request to enable MSI for Microblaze.
>=20
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>=20
> https://lore.kernel.org/linux-riscv/20191008154604.GA7903@infradead.org/

[ ... ]

> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuil=
d
> index 16970f246860..1efaeddf1e4b 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -22,7 +22,6 @@ generic-y +=3D kvm_para.h
>  generic-y +=3D local.h
>  generic-y +=3D local64.h
>  generic-y +=3D mm-arch-hooks.h
> -generic-y +=3D msi.h
>  generic-y +=3D percpu.h
>  generic-y +=3D preempt.h
>  generic-y +=3D sections.h

Acked-by: Paul Walmsley <paul.walmsley@sifive.com> # arch/riscv
Tested-by: Paul Walmsley <paul.walmsley@sifive.com> # build only, rv32/rv64

Thanks Micha=B3,


- Paul
--8323329-165076562-1571930279=:20010--
