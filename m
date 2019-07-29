Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33EEE790FB
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2019 18:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfG2Qe1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jul 2019 12:34:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41081 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbfG2Qe0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 12:34:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id d24so59213134ljg.8
        for <linux-arch@vger.kernel.org>; Mon, 29 Jul 2019 09:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UG3D/SqCJj11xnk2S6pE/fAYr6pWtAvwmUTxug894eQ=;
        b=H7HnhUSVZGnyX/bVSSVdIPy2+iDxVSJ4e8dlo0bijwhktHTLPBxk09q3fnro9i4jws
         CppBIGzdSZBmMRHzt2N7kPQlDulHGrQA7y/t+f9WmoBCn1D9OC0rfJqEHKTsPV+6k+Fb
         F5ZhDAP8w/aGd9HqgkSktBvei5ipu/zKnu3u7Vy/kVMC6A1NPnladQjD1TMlB0vdjkbu
         cK505ALF1gpY7nunM42GdUAzII8oYlw2RyLLhvjbCdTWEhv9b1J4RKbWan5ki9YNmlEv
         J/43JD7D/48FLIcBn+4W8T2FW6VOBihBUFZc+iFaPvWhSpOAPayMnbMohqwV9tpxtEFk
         cdQQ==
X-Gm-Message-State: APjAAAWgforSHWjrXLVZkDpmNihg55fXI7lGC00DcejbsfPzaLz4grn+
        xa3FejO9iClwd8qQl75zKhjnGyF5Ct0twHndEAQN5A==
X-Google-Smtp-Source: APXvYqwaWzM1hn/JYuWG8xIWCCoQc0juPndzV2AWEI2sZ0zbeHQbhgIVf3GM5tGdjfmKdC05eoQItiSu7YXZ4SX7s6Q=
X-Received: by 2002:a2e:2b01:: with SMTP id q1mr57284489lje.27.1564418064609;
 Mon, 29 Jul 2019 09:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnkfhyT=2kPsiUy-V=aCA_s-C4BXgD++hAZ9ii1h0p94mMVQA@mail.gmail.com>
 <20190729125421.32482-1-vincenzo.frascino@arm.com>
In-Reply-To: <20190729125421.32482-1-vincenzo.frascino@arm.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Mon, 29 Jul 2019 18:33:48 +0200
Message-ID: <CAGnkfhw+=+50P=uaWsjZrtt_BuwJjXKZ_DSTjuJ8mzW4_kbu-w@mail.gmail.com>
Subject: Re: [PATCH] arm64: vdso: Fix Makefile regression
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>, salyzyn@android.com,
        pcc@google.com, 0x7f454c46@gmail.com, linux@rasmusvillemoes.dk,
        sthotton@marvell.com, andre.przywara@arm.com,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 29, 2019 at 2:54 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Using an old .config in combination with "make oldconfig" can cause
> an incorrect detection of the compat compiler:
>
> $ grep CROSS_COMPILE_COMPAT .config
> CONFIG_CROSS_COMPILE_COMPAT_VDSO=""
>
> $ make oldconfig && make
> arch/arm64/Makefile:58: gcc not found, check CROSS_COMPILE_COMPAT.
> Stop.
>
> Accordingly to the section 7.2 of the GNU Make manual "Syntax of
> Conditionals", "When the value results from complex expansions of
> variables and functions, expansions you would consider empty may
> actually contain whitespace characters and thus are not seen as
> empty. However, you can use the strip function to avoid interpreting
> whitespace as a non-empty value."
>
> Fix the issue adding strip to the CROSS_COMPILE_COMPAT string
> evaluation.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Matteo Croce <mcroce@redhat.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index bb1f1dbb34e8..61de992bbea3 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -52,7 +52,7 @@ ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
>
>    ifeq ($(CONFIG_CC_IS_CLANG), y)
>      $(warning CROSS_COMPILE_COMPAT is clang, the compat vDSO will not be built)
> -  else ifeq ($(CROSS_COMPILE_COMPAT),)
> +  else ifeq ($(strip $(CROSS_COMPILE_COMPAT)),)
>      $(warning CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built)
>    else ifeq ($(shell which $(CROSS_COMPILE_COMPAT)gcc 2> /dev/null),)
>      $(error $(CROSS_COMPILE_COMPAT)gcc not found, check CROSS_COMPILE_COMPAT)
> --
> 2.22.0
>

Tested-by: Matteo Croce <mcroce@redhat.com>

-- 
Matteo Croce
per aspera ad upstream
