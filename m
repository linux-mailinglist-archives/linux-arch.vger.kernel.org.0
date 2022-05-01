Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDB151623E
	for <lists+linux-arch@lfdr.de>; Sun,  1 May 2022 08:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242020AbiEAGjc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 May 2022 02:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiEAGjc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 May 2022 02:39:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E6E101F9;
        Sat, 30 Apr 2022 23:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zMD4l/5Yp5noATOxsomtn9uqwj1ijFkZXxY4PadNJEc=; b=DiBgExZ2aFk1+wh8QtkKwZo18+
        RILXrbmHMSW20x90e8CQKMMcK950wv7VWUDausJJR3sIyNzeuYfaT6NBhDS6NeduoWG6F+AzvDicO
        R1GD5P5bEe2zf4x0paq0m4WyzGB+efA6zUIx3WXoKQXj50r5svCBeNq1Sctg3PDzQF9HYS7QRc8x3
        3RcbAeFOOOybNT5og/ZfN2hDEghLVDRryTrjdPhn9UXDJipkaSa9TxQ8Xj/7L6ertd1a3Wao1xd3x
        PnnhEDUs07YOwTmQKOgql7SpyA/BNv2ObJs58rDZnghi59En/6A29x/linm2u4pcrU1GhQhRLbAjg
        edmDqv2g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58470)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nl3BG-0005zM-7z; Sun, 01 May 2022 07:35:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nl3B6-0003fQ-IU; Sun, 01 May 2022 07:35:32 +0100
Date:   Sun, 1 May 2022 07:35:32 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH V9 21/24] LoongArch: Add zboot (compressed kernel) support
Message-ID: <Ym4qNILcz+W7dC9i@shell.armlinux.org.uk>
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-22-chenhuacai@loongson.cn>
 <CAK8P3a0LwJ3mMQMFkxGxr+umCMM3dKGRnLF+dMCmD5j43hq2sA@mail.gmail.com>
 <CAAhV-H6vPdLeup38YTj64Xxxk+PTact=DMJTs9efsa1b3t-y2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H6vPdLeup38YTj64Xxxk+PTact=DMJTs9efsa1b3t-y2A@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, May 01, 2022 at 01:22:25PM +0800, Huacai Chen wrote:
> Hi, Arnd,
> 
> On Sat, Apr 30, 2022 at 7:02 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Sat, Apr 30, 2022 at 11:05 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > >
> > > This patch adds zboot (self-extracting compressed kernel) support, all
> > > existing in-kernel compressing algorithm and efistub are supported.
> > >
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >
> > I have no objections to adding a decompressor in principle, and
> > the implementation seems reasonable. However, I think we should try to
> > be consistent between architectures. On both arm64 and riscv, the
> > maintainers decided to not include a decompressor and instead leave
> > it up to the boot loader to decompress the kernel and enter it from there.
> X86, ARM32 and MIPS already support self-extracting kernel, and in
> 5.17 we even support self-extracting modules. So I think a
> self-extracting kernel is better than a pure compressed kernel.

FYI, kernel modules are not self-extracting. They don't contain the code
to do the decompression - that is contained within the kernel, and it is
the kernel that does the decompression. The userspace tooling tells the
kernel that the module is compressed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
