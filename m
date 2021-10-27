Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7B243C363
	for <lists+linux-arch@lfdr.de>; Wed, 27 Oct 2021 08:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240143AbhJ0HAe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Oct 2021 03:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhJ0HAe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Oct 2021 03:00:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568CCC061570;
        Tue, 26 Oct 2021 23:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z7/2qUaV91Qyzvddr7HjK6pwrCY2x3jtBDB6z6rCMxE=; b=LJmlOv5apJrlQaOwWtgq3Af+3w
        NW1vAkiztkLdB3NKV2+X7oCi7M2+vJuqc8K4kF/Wotsk+gIn0SFmdneX1F1CJYzy5+aUZiSBkKIuX
        W4lcf/4IWGbfFtNBCq6dB4dlO3avaxs9dHrDQBIhmoucBNtLjrPX/xh5O9narKPD/FOxOzLPdWroO
        XXoyMAwGxU7clnuZ47IQOjsiw5SWXVLbMissjJKbguZUMt3xoFlo/tIjFnYvQzMDPpunLYcUJ9wJT
        4UxQrBSbO8wr2s8XsS76KbjsP0XyRqNOB5NIr0W6+6ASZJhUZ5aMlpYlULE4IXb4QKrFf5bFCIMNb
        UYz9eVEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfcsP-00CVYp-Dr; Wed, 27 Oct 2021 06:57:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1FC6930031C;
        Wed, 27 Oct 2021 08:57:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04998200F77C3; Wed, 27 Oct 2021 08:57:29 +0200 (CEST)
Date:   Wed, 27 Oct 2021 08:57:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Miroslav Benes <mbenes@suse.cz>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/4] x86: Various clean-ups in support of FGKASLR
Message-ID: <YXj4WbzoPfdOgBtQ@hirez.programming.kicks-ass.net>
References: <20211013175742.1197608-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013175742.1197608-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 13, 2021 at 10:57:38AM -0700, Kees Cook wrote:
> Kees Cook (2):
>   x86/boot: Allow a "silent" kaslr random byte fetch
>   x86/boot/compressed: Avoid duplicate malloc() implementations
> 
> Kristen Carlson Accardi (2):
>   x86/tools/relocs: Support >64K section headers
>   vmlinux.lds.h: Have ORC lookup cover entire _etext - _stext
> 
>  arch/x86/boot/compressed/kaslr.c  |   4 --
>  arch/x86/boot/compressed/misc.c   |   3 +
>  arch/x86/boot/compressed/misc.h   |   2 +
>  arch/x86/lib/kaslr.c              |  18 ++++--
>  arch/x86/tools/relocs.c           | 103 ++++++++++++++++++++++--------
>  include/asm-generic/vmlinux.lds.h |   3 +-
>  include/linux/decompress/mm.h     |  12 +++-
>  7 files changed, 107 insertions(+), 38 deletions(-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Boris, these are indeed all improvements to the status quo, irrespective
of future FGKASLR work. Do you want to take them, or should I stick them
in x86/core ?
