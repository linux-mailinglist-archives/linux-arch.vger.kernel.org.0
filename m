Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F279251641D
	for <lists+linux-arch@lfdr.de>; Sun,  1 May 2022 13:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346095AbiEALcG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 May 2022 07:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346155AbiEALcB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 May 2022 07:32:01 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEA46D3BD;
        Sun,  1 May 2022 04:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j2MeoyDNnhtCNI4diPE6KeBtDiVOdWvq3i/pv7roOCY=; b=rh8fo1F7nz7o0sWw61t+nRCLI5
        jZ65Mk+l9VOd49fIcfWlmEIDUA2lSnZLqtyWv7QK3OE/Q2H+gpW0K5mvoTwzqkvVI8d478PlhBGJd
        N8Z7YjkL/7UhYNr2/hZR2ATgsy5kQWJurEwA6dvZ5Qk25xMKqGTCbRzWxAsN8IBWaD8gnN4pBQul5
        uaEiMMiXjErxBo5SgMhSAFHCahNYoBkNptOVT0I9aYIs4jNrFpuWBd2vfI0SQCoWP7P5Ie1TLjh6m
        5zgw3JAtOlyXomqSary+dknNeLBB0IQ4dMisBYpRSloi6OCTiCe6TA6NjTqGIVIt5nycfecnzXbHe
        HfmrqEAg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58472)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nl7kV-0006CR-Vh; Sun, 01 May 2022 12:28:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nl7kQ-0003qP-21; Sun, 01 May 2022 12:28:18 +0100
Date:   Sun, 1 May 2022 12:28:18 +0100
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
Message-ID: <Ym5u0jR0PXwziqF8@shell.armlinux.org.uk>
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-22-chenhuacai@loongson.cn>
 <CAK8P3a0LwJ3mMQMFkxGxr+umCMM3dKGRnLF+dMCmD5j43hq2sA@mail.gmail.com>
 <CAAhV-H6vPdLeup38YTj64Xxxk+PTact=DMJTs9efsa1b3t-y2A@mail.gmail.com>
 <Ym4qNILcz+W7dC9i@shell.armlinux.org.uk>
 <CAAhV-H58HXicH7jj88BFUH8P9cGwXFGjgOoLvZubQsBst+zheQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H58HXicH7jj88BFUH8P9cGwXFGjgOoLvZubQsBst+zheQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, May 01, 2022 at 04:46:50PM +0800, Huacai Chen wrote:
> Hi, Russell,
> 
> On Sun, May 1, 2022 at 2:35 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Sun, May 01, 2022 at 01:22:25PM +0800, Huacai Chen wrote:
> > > Hi, Arnd,
> > >
> > > On Sat, Apr 30, 2022 at 7:02 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > On Sat, Apr 30, 2022 at 11:05 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > >
> > > > > This patch adds zboot (self-extracting compressed kernel) support, all
> > > > > existing in-kernel compressing algorithm and efistub are supported.
> > > > >
> > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > >
> > > > I have no objections to adding a decompressor in principle, and
> > > > the implementation seems reasonable. However, I think we should try to
> > > > be consistent between architectures. On both arm64 and riscv, the
> > > > maintainers decided to not include a decompressor and instead leave
> > > > it up to the boot loader to decompress the kernel and enter it from there.
> > > X86, ARM32 and MIPS already support self-extracting kernel, and in
> > > 5.17 we even support self-extracting modules. So I think a
> > > self-extracting kernel is better than a pure compressed kernel.
> >
> > FYI, kernel modules are not self-extracting. They don't contain the code
> > to do the decompression - that is contained within the kernel, and it is
> > the kernel that does the decompression. The userspace tooling tells the
> > kernel that the module is compressed.
> I call "self-extracting" here means we don't need out-of-kernel help:
> kernel decompress doesn't need the bootloader, module decompress
> doesn't need kmod.

As I understand it, it does require out-of-kernel help. The module
loading program needs to pass in to the finit_module syscall a flag
to tell the kernel to decompress it. See the
MODULE_INIT_COMPRESSED_FILE flag.

So it's definitely not "self-extracting" by any sense of "self". My
definition of "self-extracting" is where a program contains the
extractor inside the same image, and when the program is run, it
performs the extraction using code contained within the image itself.

Your definition would mean a gzipped kernel binary would be able to
be called "self-extracting" if the boot loader decompresses it. This
is definitely not "self-extracting" in my book.

Sorry to be such a pedant.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
