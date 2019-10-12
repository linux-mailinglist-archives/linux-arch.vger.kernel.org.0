Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABE23D5077
	for <lists+linux-arch@lfdr.de>; Sat, 12 Oct 2019 16:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfJLOqS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Oct 2019 10:46:18 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49620 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfJLOqS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Oct 2019 10:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5KGWmmYHnCKl7o8+6yr6YzfTu0KvC6adovwOl9kif4s=; b=aafBCt00CsUTIkxLb7c2Apav3
        L3uQYbJrdQH0MGbHKVilFEPZBonq1Empf3WlY3MVogccuBNqaDAIzYuwXdb2PExolamxyGzgZCmK/
        qoaoMiujFUf5HCoNSgNsG+/mApe/T6ypW+pkthxu3UUBu+ZXzjHqggUgB8d7gb5eDUQnd3UyfRz4n
        4l5xoXLNrceWAI1LKwmZyCcFphMoov5gMIs8+THAhe+mz4sLVWB8gipqZErs5uMg8NsFtN2Hjf88b
        ORX6pRDkr30YV5CNgsPyLEqey4NU86mOBFGdnLKrvxl+jZMpTFuyC6jaVmkaJMHDzEPWmfBGRzPwG
        bmSEv3MVw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:50706)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iJIea-0003Fk-2Y; Sat, 12 Oct 2019 15:45:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iJIeU-0002DF-JS; Sat, 12 Oct 2019 15:45:50 +0100
Date:   Sat, 12 Oct 2019 15:45:50 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@google.com>, Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Message-ID: <20191012144550.GN25745@shell.armlinux.org.uk>
References: <20191001170142.x66orounxuln7zs3@willie-the-truck>
 <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk>
 <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk>
 <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <CAMuHMdWPhE1nNkmL1nj3vpQhB7fP3uDs2i_ZVi0Gf9qij4W2CA@mail.gmail.com>
 <CAHk-=wgFODvdFBHzgVf3JjoBz0z6LZhOm8xvMntsvOr66ASmZQ@mail.gmail.com>
 <20191003163606.iqzcxvghaw7hdqb5@willie-the-truck>
 <35643c7e-94e9-e410-543b-a7de17b59a32@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35643c7e-94e9-e410-543b-a7de17b59a32@gmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 12, 2019 at 12:15:42PM +0200, Stefan Wahren wrote:
> Hi,
> 
> Am 03.10.19 um 18:36 schrieb Will Deacon:
> > On Wed, Oct 02, 2019 at 01:39:40PM -0700, Linus Torvalds wrote:
> >> On Wed, Oct 2, 2019 at 5:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >>>> Then use the C preprocessor to force the inlining.  I'm sorry it's not
> >>>> as pretty as static inline functions.
> >>> Which makes us lose the baby^H^H^H^Htype checking performed
> >>> on function parameters, requiring to add more ugly checks.
> >> I'm 100% agreed on this.
> >>
> >> If the inline change is being pushed by people who say "you should
> >> have used macros instead if you wanted inlining", then I will just
> >> revert that stupid commit that is causing problems.
> >>
> >> No, the preprocessor is not the answer.
> >>
> >> That said, code that relies on inlining for _correctness_ should use
> >> "__always_inline" and possibly even have a comment about why.
> >>
> >> But I am considering just undoing commit 9012d011660e ("compiler:
> >> allow all arches to enable CONFIG_OPTIMIZE_INLINING") entirely. The
> >> advantages are questionable, and when the advantages are balanced
> >> against actual regressions and the arguments are "use macros", that
> >> just shows how badly thought out this was.
> > It's clear that opinions are divided on this issue, but you can add
> > an enthusiastic:
> >
> > Acked-by: Will Deacon <will@kernel.org>
> >
> > if you go ahead with the revert. I'm all for allowing the compiler to
> > make its own inlining decisions, but not when the potential for
> > miscompilation isn't fully understood and the proposed alternatives turn
> > the source into an unreadable mess. Perhaps we can do something different
> > for 5.5 (arch opt-in? clang only? invert the logic? work to move functions
> > over to __always_inline /before/ flipping the CONFIG option? ...?)
> 
> what's the status on this?
> 
> In need to prepare my pull requests for 5.5 and all recent kernelci
> targets (including linux-next) with bcm2835_defconfig are still broken.

I merged the patches late on Thursday, it may have been too late for
linux-next to pick them up - and because of the time difference between
UK and Australia, it means they won't be in linux-next until next week
(basically, tomorrow).  linux-next is basically a Sunday to Thursday
operation from my point of view.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
