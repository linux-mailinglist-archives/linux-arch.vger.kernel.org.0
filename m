Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AE7532559
	for <lists+linux-arch@lfdr.de>; Tue, 24 May 2022 10:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiEXIfV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 May 2022 04:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiEXIfT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 May 2022 04:35:19 -0400
X-Greylist: delayed 477 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 May 2022 01:35:17 PDT
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F3E633AE;
        Tue, 24 May 2022 01:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1653380839;
        bh=f86+du3NLa/SaLRfDIDrohJYCgyKaooMgS3GQURiRxE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kruEWImlOIAaMsrf6ecSXnkopnnhQNB9Fygb9CS2ZNnu1BJdO2oY6yKbCPMkRJjwI
         BTm8Ib0ZuDPkEm+g2a8xdV2cYTO0a7KRZrw108aTxMheezVj/dx+986hrEkb682nvD
         SlqDR5UaOvmxS7cZJCXDzuxLJYHWF/SPGaJlEcA8=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id CE237668FE;
        Tue, 24 May 2022 04:27:14 -0400 (EDT)
Message-ID: <14f922495a09898017e4db3baed5b434acadac12.camel@xry111.site>
Subject: Re: [PATCH V11 09/22] LoongArch: Add boot and setup routines
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 24 May 2022 16:27:13 +0800
In-Reply-To: <20220518092619.1269111-10-chenhuacai@loongson.cn>
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
         <20220518092619.1269111-10-chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2022-05-18 at 17:26 +0800, Huacai Chen wrote:
> Currently an existing interface between the kernel and the bootloader
> is=C2=A0 implemented. Kernel gets 2 values from the bootloader, passed in
> registers a0 and a1; a0 is an "EFI boot flag" distinguishing UEFI and
> non-UEFI firmware, while a1 is a pointer to an FDT with systable,
> memmap, cmdline and initrd information.

If I understand this correctly, we can:

- set a0 to 0
- set a1 a pointer (virtual address or physical address?) to the FDT
with these information

in the bootloader before invoking the kernel, then it will be possible
to boot this kernel w/o firmware update?

I'd prefer to receive a firmware update anyway, but we need an
alternative if some vendor just say "no way, our customized distro works
fine and you should use it".  (I'm not accusing LoongArch: such annoying
behavior is common among vendors of all architectures, and even worse
with x86 because they often say "just use Windoge".)
--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
