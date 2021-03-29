Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE93934CCFF
	for <lists+linux-arch@lfdr.de>; Mon, 29 Mar 2021 11:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhC2J02 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Mar 2021 05:26:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231659AbhC2J0T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Mar 2021 05:26:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B45876193C;
        Mon, 29 Mar 2021 09:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617009979;
        bh=2m63iLs4WAe9lYjvi0CAGkdEF4a/0HxPdd40RsaZgHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YDnyZC5YOgX7yXRUjz9IGEO0C6G0nFmFS/eHflmgry96kPs8l5LfKHOfjeOx1269E
         9AKlzXbO73/J3hgxgOJ3WYU8xLgMtAhEyA/YTdmezdrEGiYR1Fre1yP8TTftBagrNC
         wv3RmU15M+bgWdIZUnlXbkpLQVt1BkWh1L3AI4zr5NW//9NVSaS2METzlmPoClL74i
         AehOpRfLKdbxWuSRWc036zO/qqoOyDZ9y25rnaJCDrzPrUmzQzv1Kko/WdUBeMJZgk
         Cci7SrTHk1S6Jj+IJPSSAgN+6ISiauwjudqnn+snE9Psh1UV2z4bwsdwYP57+VxxFj
         sjSV9H1gLbeMQ==
Date:   Mon, 29 Mar 2021 11:26:12 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/17] module: ensure __cfi_check alignment
Message-ID: <YGGdNAygysK8MfnZ@gunter>
References: <20210323203946.2159693-1-samitolvanen@google.com>
 <20210323203946.2159693-5-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210323203946.2159693-5-samitolvanen@google.com>
X-OS:   Linux gunter 5.11.6-1-default x86_64
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+++ Sami Tolvanen [23/03/21 13:39 -0700]:
>CONFIG_CFI_CLANG_SHADOW assumes the __cfi_check() function is page
>aligned and at the beginning of the .text section. While Clang would
>normally align the function correctly, it fails to do so for modules
>with no executable code.
>
>This change ensures the correct __cfi_check() location and
>alignment. It also discards the .eh_frame section, which Clang can
>generate with certain sanitizers, such as CFI.
>
>Link: https://bugs.llvm.org/show_bug.cgi?id=46293
>Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Jessica Yu <jeyu@kernel.org>

Thanks!
