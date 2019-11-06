Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 699C0F1A39
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2019 16:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfKFPmT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Nov 2019 10:42:19 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:30369 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfKFPmT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 10:42:19 -0500
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id xA6Fg2es007430;
        Thu, 7 Nov 2019 00:42:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com xA6Fg2es007430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573054923;
        bh=RxMn3f0/d5NahhDyspoF9+9+D7Y+JC9cLu0o3W25/nQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gfvT/fLJp1LpDr8mZOQAWADFGF5N68hUU27eKsdJG2yHDp8P5KAS8Y6u2nzrzbdQ1
         UoerufW73gIwj/EuNg/6vcjauGMg8sJbfQzmlHUgsx4IHBch0VA3id7OG5oIWxnIA7
         Y3jl7k6OdqF8W3r7WM0ZjafEM8EiwrLwb30CyaGYRPpo7ruEjZbpeOBv3jXlk+rT1q
         FvkbzZeLptNTkZMuO8cY5Z5Fo3iOsmtKedKsdYISnqnh8EL3hLiiKoX3BnuvZmJKiu
         Q8YBfi1vWQV6mk/IJbzKz2aCofj7nH1QR/72a1bdqLpHqckH1c23FqIRKOhaBMtbS8
         bsiTPdTwKh6Jg==
X-Nifty-SrcIP: [209.85.221.178]
Received: by mail-vk1-f178.google.com with SMTP id o198so5712362vko.11;
        Wed, 06 Nov 2019 07:42:03 -0800 (PST)
X-Gm-Message-State: APjAAAWnNlffQCcKJMCSsUZS9gPGcTIyMh5nsIY6oICP1B1sI570d1hd
        4PWhYEvQZ3MAjcguUmiihpebU3XEkJKMrSRQHaQ=
X-Google-Smtp-Source: APXvYqyc930opN0jwCWBQenKwYN6vOwN5L54Pm5rKHBo2DMjbaiv+uF7/PiotSKwxV/fK7oXangAm80NOjyOHmUTTpM=
X-Received: by 2002:a1f:4b05:: with SMTP id y5mr1558124vka.12.1573054921774;
 Wed, 06 Nov 2019 07:42:01 -0800 (PST)
MIME-Version: 1.0
References: <20191018043148.6285-1-yamada.masahiro@socionext.com>
In-Reply-To: <20191018043148.6285-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 7 Nov 2019 00:41:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNATeTR=hZ9Ebh=R7_KTxeB0tfLCeRPOMqwZj9XUdZHTAkw@mail.gmail.com>
Message-ID: <CAK7LNATeTR=hZ9Ebh=R7_KTxeB0tfLCeRPOMqwZj9XUdZHTAkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] asm-generic/export.h: make __ksymtab_* local symbols
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 18, 2019 at 2:03 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> For EXPORT_SYMBOL from C files, <linux/export.h> defines __ksymtab_*
> as local symbols.
>
> For EXPORT_SYMBOL from assembly, in contrast, <asm-generic/export.h>
> produces globally-visible __ksymtab_* symbols due to this .globl
> directive.
>
> I do not understand why this must be global.  It still works without
> this .globl directive.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

I did not get objection, at least.

Applied to linux-kbuild.



>
>  include/asm-generic/export.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
> index fa577978fbbd..80ef2dc0c8be 100644
> --- a/include/asm-generic/export.h
> +++ b/include/asm-generic/export.h
> @@ -31,7 +31,6 @@
>   */
>  .macro ___EXPORT_SYMBOL name,val,sec
>  #ifdef CONFIG_MODULES
> -       .globl __ksymtab_\name
>         .section ___ksymtab\sec+\name,"a"
>         .balign KSYM_ALIGN
>  __ksymtab_\name:
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
