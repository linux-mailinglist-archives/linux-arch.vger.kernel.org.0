Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E57A1890E1
	for <lists+linux-arch@lfdr.de>; Tue, 17 Mar 2020 22:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgCQV4V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Mar 2020 17:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgCQV4V (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 17:56:21 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E421420724;
        Tue, 17 Mar 2020 21:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584482180;
        bh=ltu6nAB3cqjUcyzN/b/tv8nLp/YUwPWjD/rDtUy+sgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n+jfY58+O3gxLesJbYsTqizSa2RR6XLi3KOzJTD9QCVRkf2N2Vb/4Egzsdk/L4b5b
         CP91bT2bOG+axRpAPBNen9T7gdpGU4eqbWfc5APbhlKH3xrtmf+fdXJN+ndAQyj+K2
         eWeHzI67pC4vnqYjNGg2gteEqMyW7yXWzsIKxNmc=
Date:   Tue, 17 Mar 2020 21:56:14 +0000
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>, "H.J. Lu" <hjl.tools@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] arm64/build: Warn on orphan section placement
Message-ID: <20200317215614.GB20788@willie-the-truck>
References: <20200228002244.15240-1-keescook@chromium.org>
 <20200228002244.15240-8-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228002244.15240-8-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 27, 2020 at 04:22:42PM -0800, Kees Cook wrote:
> We don't want to depend on the linker's orphan section placement
> heuristics as these can vary between linkers, and may change between
> versions. All sections need to be explicitly named in the linker
> script.
> 
> Explicitly include debug sections when they're present. Add .eh_frame*
> to discard as it seems that these are still generated even though
> -fno-asynchronous-unwind-tables is being specified. Add .plt and
> .data.rel.ro to discards as they are not actually used. Add .got.plt
> to the image as it does appear to be mapped near .data. Finally enable
> orphan section warnings.

Hmm, I don't understand what .got.plt is doing here. Please can you
elaborate?

Will
