Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E8C376D21
	for <lists+linux-arch@lfdr.de>; Sat,  8 May 2021 01:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhEGXEE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 May 2021 19:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhEGXED (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 May 2021 19:04:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82E2C061761;
        Fri,  7 May 2021 16:03:02 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620428579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JXeejtHvaU6r57y+H/6chLv35n+4kHh0i98g2fKiDNw=;
        b=NMCn50OEXmZMXO1y0zSZPZZ4MNARh9iWOxZdHWrMJG33LMs1FpmwE/uPVIpUMWelm8CmI0
        odd57jzBXu4UHu9iRz6T/mlp/B0UlYj9VCyjBQ9tJOvmQHzRdrlmAoMz4sJOPPnb2sURMj
        ytNVSqB23rMh5LNA4NZTD9Sq4G/xKGkhkDsGRFRdZEA9MzYWqgECm4NCP841J/ucBornf2
        fZebDTGty+qll147dzlRwlOtAZFCpV/TkO9lbNJK2llbmH/BOVvdkJsXjlFv1QU/bLxfb5
        WDSQVv7+TQQVxk+5jZKTB7oEiShDGDeHxy+4gIRkBCgXy73KTAipr+yXCbsDQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620428579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JXeejtHvaU6r57y+H/6chLv35n+4kHh0i98g2fKiDNw=;
        b=UBHeGQNGG8YqoYmzhKFeRKHRDdsveMvcVQsyLASezu+G4x4bhChlxv8y71fdr/GYNTLdlB
        mKTyuWFloMRIPiDA==
To:     Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
Subject: Re: [RFC 01/12] asm-generic: use asm-generic/unaligned.h for most architectures
In-Reply-To: <20210507220813.365382-2-arnd@kernel.org>
References: <20210507220813.365382-1-arnd@kernel.org> <20210507220813.365382-2-arnd@kernel.org>
Date:   Sat, 08 May 2021 01:02:59 +0200
Message-ID: <87czu2m9jw.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 08 2021 at 00:07, Arnd Bergmann wrote:
> diff --git a/arch/x86/include/asm/unaligned.h b/arch/x86/include/asm/unaligned.h
> deleted file mode 100644
> index 9c754a7447aa..000000000000
> --- a/arch/x86/include/asm/unaligned.h
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_X86_UNALIGNED_H
> -#define _ASM_X86_UNALIGNED_H
> -
> -/*
> - * The x86 can do unaligned accesses itself.
> - */
> -
> -#include <linux/unaligned/access_ok.h>
> -#include <linux/unaligned/generic.h>
> -
> -#define get_unaligned __get_unaligned_le
> -#define put_unaligned __put_unaligned_le
> -
> -#endif /* _ASM_X86_UNALIGNED_H */

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks for cleaning that up!

       tglx
