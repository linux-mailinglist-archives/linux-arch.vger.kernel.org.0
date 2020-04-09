Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 264151A34DC
	for <lists+linux-arch@lfdr.de>; Thu,  9 Apr 2020 15:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgDIN0l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Apr 2020 09:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbgDIN0l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Apr 2020 09:26:41 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62E882072F;
        Thu,  9 Apr 2020 13:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586438801;
        bh=cV6hSehyX6lw4Tv9+IglB58tggNYFJ6BalVHwJs8cI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H9uzvWqkZoza1WwcQy6lLYj+vDp8hvrlgELwPMjzCUzfYJ5JZZHkeINQiHfngaRFe
         7WOLZlaXP9ZxF2dUO/OHweSokzXySPzG3A+GzKiIDeTCRFX6R5SSdhlywofkdfwzLU
         IdwaSKjwyHFZtTWRiPWDOJOI9+eAPT6vkZvZF0Jk=
Date:   Thu, 9 Apr 2020 14:26:34 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [PATCH v3 21/26] arm64: Introduce asm/vdso/arch_timer.h
Message-ID: <20200409132633.GD13078@willie-the-truck>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
 <20200313154345.56760-22-vincenzo.frascino@arm.com>
 <20200315183151.GE32205@mbp>
 <4914ad9c-3eaf-b328-f31b-5d3077ef272f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4914ad9c-3eaf-b328-f31b-5d3077ef272f@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Vincenzo,

Sorry, I was on holiday when you posted this and it slipped through the
cracks.

On Mon, Mar 16, 2020 at 03:37:23PM +0000, Vincenzo Frascino wrote:
> > On Fri, Mar 13, 2020 at 03:43:40PM +0000, Vincenzo Frascino wrote:
> >> The vDSO library should only include the necessary headers required for
> >> a userspace library (UAPI and a minimal set of kernel headers). To make
> >> this possible it is necessary to isolate from the kernel headers the
> >> common parts that are strictly necessary to build the library.
> >>
> >> Introduce asm/vdso/arch_timer.h to contain all the arm64 specific
> >> code. This allows to replace the second isb() in __arch_get_hw_counter()
> >> with a fake dependent stack read of the counter which improves the vdso
> >> library peformances of ~4.5%. Below the results of vdsotest [1] ran for
> >> 100 iterations.
> > 
> > The subject seems to imply a non-functional change but as you read, it
> > gets a lot more complicated. Could you keep the functional change
> > separate from the header clean-up, maybe submit it as an independent
> > patch? And it shouldn't go in without Will's ack ;).
> > 
> 
> It is fine by me. I will repost the series with the required fixes and without
> this patch. This will give to me enough time to address Mark's comments as well
> and to Will to have a proper look.

Please can you post whatever is left at -rc1? I'll have a look then, but
let's stick to just moving code around rather than randomly changing it
at the same time, ok?

Thanks,

Will
