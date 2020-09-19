Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B965270CFE
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 12:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgISK0P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 06:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgISK0P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 19 Sep 2020 06:26:15 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEFFF207FF;
        Sat, 19 Sep 2020 10:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600511174;
        bh=QS+/7ck8Ms+3NScVBhWMouEzmGA4XUAFNHh7y81UkaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dhs4E9cCPWR5U6/L6w+Ot0AP6OfHcv183sxqnUkXXz/AnXJDt0AXHHvcqCMVei5i6
         GKnSZS2OKXzMu25vZ30nutYcHd1k1XhpuBjem46GWue0KNcO/LOyTnnK8hzbEj6OMj
         lh64cXJ94R44/ThRRJAbdzF0qE+FcmC0n0GycrxI=
Date:   Sat, 19 Sep 2020 12:26:01 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Will Deacon <will@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jeff Dike <jdike@addtoit.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Marek <michal.lkml@markovi.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] kbuild: preprocess module linker script
Message-ID: <20200919102601.GA22693@linux-8ccs>
References: <20200908042708.2511528-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200908042708.2511528-1-masahiroy@kernel.org>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+++ Masahiro Yamada [08/09/20 13:27 +0900]:
>There was a request to preprocess the module linker script like we
>do for the vmlinux one. (https://lkml.org/lkml/2020/8/21/512)
>
>The difference between vmlinux.lds and module.lds is that the latter
>is needed for external module builds, thus must be cleaned up by
>'make mrproper' instead of 'make clean'. Also, it must be created
>by 'make modules_prepare'.
>
>You cannot put it in arch/$(SRCARCH)/kernel/, which is cleaned up by
>'make clean'. I moved arch/$(SRCARCH)/kernel/module.lds to
>arch/$(SRCARCH)/include/asm/module.lds.h, which is included from
>scripts/module.lds.S.
>
>scripts/module.lds is fine because 'make clean' keeps all the
>build artifacts under scripts/.
>
>You can add arch-specific sections in <asm/module.lds.h>.
>
>Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>Tested-by: Jessica Yu <jeyu@kernel.org>
>Acked-by: Will Deacon <will@kernel.org>

Acked-by: Jessica Yu <jeyu@kernel.org>

Thanks for working on this! 

