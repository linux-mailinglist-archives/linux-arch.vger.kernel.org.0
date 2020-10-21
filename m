Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712882954C2
	for <lists+linux-arch@lfdr.de>; Thu, 22 Oct 2020 00:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506639AbgJUWWY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 18:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506637AbgJUWWX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Oct 2020 18:22:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A22C0613CE;
        Wed, 21 Oct 2020 15:22:23 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c9a000363ca1046998683.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9a00:363:ca10:4699:8683])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 28B271EC01A8;
        Thu, 22 Oct 2020 00:22:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603318941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YsA4LxCD90qsXl9QcJzxXqiwck+t+i7IkKMRItUt+fY=;
        b=d9R7r7CHhhTIDSPOk9wy8nH20il+OQago345ApRaJKTpVeLa1UueCuTxeKvjCW7pwfy2Oz
        ZZEInpMlADQUsgX5LXAI2xJXin3kr8+/O90RBLQqnp3HiUIyUEF//3erjtzY0T8TlrLZvP
        WfjnuYvOHzR9QKTU5PyMd687UyWCcVs=
Date:   Thu, 22 Oct 2020 00:22:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vmlinux.lds.h: Keep .ctors.* with .ctors
Message-ID: <20201021222215.GC4050@zn.tnic>
References: <20201005025720.2599682-1-keescook@chromium.org>
 <202010211303.4F8386F2@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202010211303.4F8386F2@keescook>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 01:04:35PM -0700, Kees Cook wrote:
> [thread ping: x86 maintainers, can someone please take this?]

$ ./scripts/get_maintainer.pl -f include/asm-generic/vmlinux.lds.h
Arnd Bergmann <arnd@arndb.de> (maintainer:GENERIC INCLUDE/ASM HEADER FILES)
...

so that's Arnd's AFAICT.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
