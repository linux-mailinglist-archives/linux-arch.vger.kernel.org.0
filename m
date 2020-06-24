Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D977206E66
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 09:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390184AbgFXH5T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 03:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389965AbgFXH5T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 03:57:19 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4AC72085B;
        Wed, 24 Jun 2020 07:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592985438;
        bh=l3Q0LyzeB2AgJKEMBDOo81ibmsUKTKJ9tglIeoVn5pI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hwS5MOXOPRnpdHOI74XHFaf2FIoxBL8vat/VMF/rsK7OudnwwsqyaUMDA1AwNDq5I
         5MFpl+o0l6bMIGSTBS4TLc5oi5hGBQK8kQGQwgMIkCdavlfrFxZaZtDRJVxoOiu8zg
         tP7o7yRWzq2oR+WUQFOZXEJQrECP14c31Q5KiLQk=
Date:   Wed, 24 Jun 2020 08:57:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] arm64/build: Warn on orphan section placement
Message-ID: <20200624075712.GB5853@willie-the-truck>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-10-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624014940.1204448-10-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 23, 2020 at 06:49:40PM -0700, Kees Cook wrote:
> We don't want to depend on the linker's orphan section placement
> heuristics as these can vary between linkers, and may change between
> versions. All sections need to be explicitly named in the linker
> script.
> 
> Avoid .eh_frame* by making sure both -fno-asychronous-unwind-tables and
> -fno-unwind-tables are present in both CFLAGS and AFLAGS. Remove one
> last instance of .eh_frame by removing the needless Call Frame Information
> annotations from arch/arm64/kernel/smccc-call.S.
> 
> Add .plt, .data.rel.ro, .igot.*, and .iplt to discards as they are not
> actually used. While .got.plt is also not used, it must be included
> otherwise ld.bfd will fail to link with the error:
> 
>     aarch64-linux-gnu-ld: discarded output section: `.got.plt'
> 
> However, as it'd be better to validate that it stays effectively empty,
> add an assert.
> 
> Explicitly include debug sections when they're present.
> 
> Fix a case of needless quotes in __section(), which Clang doesn't like.
> 
> Finally, enable orphan section warnings.
> 
> Thanks to Ard Biesheuvel for many hints on correct ways to handle
> mysterious sections. :)

Sorry to be a pain, but this patch is doing 3 or 4 independent things at
once. Please could you split it up a bit?
e.g.

 - Removal of cfi directives from smccc macro
 - Removal of quotes around section name for clang
 - Avoid generating .eh_frame
 - Ensure all sections are accounted for in linker script and warn on orphans

That way it's a bit easier to manage, we can revert/backport bits later if
necessary and you get more patches in the kernel ;)

You can also add my Ack on all the patches:

Acked-by: Will Deacon <will@kernel.org>

Will
