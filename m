Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCE524D94B
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 18:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgHUQCt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 12:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgHUQCo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Aug 2020 12:02:44 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1045207BB;
        Fri, 21 Aug 2020 16:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598025764;
        bh=bVxlYauOODt5UvuiL4qlg3/4fXBWfUekdVF6gpHL2NA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtiOLcTNtgV8t5B/UrNYZ67LjVkjtj+tvsE9RImkxtdHUkBLASZC84M+1nS5+sgV8
         12FhkH4Yc2r9MBR7hEzYmWd/5CxFkvZFFSXaR1E+wKWERtuGzDJFGqL94UTpIKmSud
         HqMJEU+DetpWiJgA/zKbNbLhRsa4BmgcgcDUJ6xU=
Date:   Fri, 21 Aug 2020 17:02:38 +0100
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
Subject: Re: [PATCH v4 00/17] Warn on orphan section placement
Message-ID: <20200821160237.GB21517@willie-the-truck>
References: <20200629061840.4065483-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Kees,

On Sun, Jun 28, 2020 at 11:18:23PM -0700, Kees Cook wrote:
> v4:
> - explicitly add .ARM.attributes
> - split up arm64 changes into separate patches
> - split up arm changes into separate patches
> - work around Clang section generation bug in -mbranch-protection
> - work around Clang section generation bug in KASAN and KCSAN
> - split "common" ELF sections out of STABS_DEBUG
> - changed relative position of .comment
> - add reviews/acks

What's the plan with this series? I thought it might have landed during the
merge window, but I can't even seem to find it in next. Anything else you
need on the arm64 side?

Will
