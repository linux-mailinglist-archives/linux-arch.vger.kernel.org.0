Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF07781BA2
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 02:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjHTATf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sat, 19 Aug 2023 20:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjHTATQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Aug 2023 20:19:16 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B343ACFE22;
        Sat, 19 Aug 2023 14:17:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6015C63DB7E5;
        Sat, 19 Aug 2023 23:17:48 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4g8WFByNW1hB; Sat, 19 Aug 2023 23:17:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DB93163DB801;
        Sat, 19 Aug 2023 23:17:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V-A1eIJKOCYu; Sat, 19 Aug 2023 23:17:47 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id ABF7E63DB7E5;
        Sat, 19 Aug 2023 23:17:47 +0200 (CEST)
Date:   Sat, 19 Aug 2023 23:17:47 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     davidgow <davidgow@google.com>
Cc:     anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        tglx <tglx@linutronix.de>, mingo <mingo@redhat.com>,
        bp <bp@alien8.de>, dave hansen <dave.hansen@linux.intel.com>,
        hpa <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        linux-um <linux-um@lists.infradead.org>, x86 <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1999963356.6490608.1692479867613.JavaMail.zimbra@nod.at>
In-Reply-To: <20230704083022.692368-1-davidgow@google.com>
References: <20230704083022.692368-1-davidgow@google.com>
Subject: Re: [PATCH 1/2] asm-generic: current: Don't include thread-info.h
 if building asm
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: asm-generic: current: Don't include thread-info.h if building asm
Thread-Index: nVjiU4WyfVH2A7QVxS/nlClMU8OkNw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "davidgow" <davidgow@google.com>
> asm/current.h is included by some assembly files (either directly, or
> indirectly). This works on some architectures (such as x86), as their
> implementation of current.h is careful to not include any C, but the
> asm-generic version includes linux/thread-info.h unconditionally, which
> leads to errors when either C code or non-asm-compatible preprocessor
> directives are included.
> 
> Just wrap the contents behind an #ifndef __ASSEMBLY__ to avoid any C
> code making its way in.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> This is requrired for patch #2 here, as UML uses this asm-generic
> header, but works with x86 assembly files which are expecting the x86
> current.h, which is assembly-friendly.
> 
> ---
> include/asm-generic/current.h | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/include/asm-generic/current.h b/include/asm-generic/current.h
> index 3a2e224b9fa0..9c2aeecbd05a 100644
> --- a/include/asm-generic/current.h
> +++ b/include/asm-generic/current.h
> @@ -2,9 +2,11 @@
> #ifndef __ASM_GENERIC_CURRENT_H
> #define __ASM_GENERIC_CURRENT_H
> 
> +#ifndef __ASSEMBLY__
> #include <linux/thread_info.h>
> 
> #define get_current() (current_thread_info()->task)
> #define current get_current()
> +#endif
> 
> #endif /* __ASM_GENERIC_CURRENT_H */

I'm fine with the UML side of this change but the generic part needs Arnd's ACK.

Thanks,
//richard
