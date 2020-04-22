Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7EE1B4993
	for <lists+linux-arch@lfdr.de>; Wed, 22 Apr 2020 18:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgDVQHR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Apr 2020 12:07:17 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:52481 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDVQHR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Apr 2020 12:07:17 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 03MG748e015897;
        Thu, 23 Apr 2020 01:07:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 03MG748e015897
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587571624;
        bh=4+b4NFpou9AA8YnP7/zLI0QcCDlnCJGmg71suxeIPFk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yMcRgYbGGnxJSIejoGRjkixdgrF+qbOIx/rtFBzQfvEjhv29U7GH19YM2uMlZ2mIX
         N8naMi4tlVtwnYxt0EmoHi3woIhj4ac4LIr14YpOHStnAiyj0ICjifW1mwgd8HuNN0
         STL60Fzwj7Ss7HP3yXEhvx51Pqa8dSLZ0dkGIpQ2lHNiNm5mOeYU7lwZ4XC2UeRR2l
         /F9VsZD/0yQQrvWda7a660utYl0kGW7BXHLrE/hKvzqQRStjrFNkmSDEv5gbZGzsAj
         HB49ykix0neVfF/XMB5HJhR93Kk66TAaxCUF2G3HaTVlf6MX4nxTIHA/y8dHuG3KQh
         +MUN+qG0jJQjg==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id f59so2194524uaf.9;
        Wed, 22 Apr 2020 09:07:04 -0700 (PDT)
X-Gm-Message-State: AGi0PuZQYCoua6X4j7tnhexMpJ4cILmwdi687vkyhZVyt0/eYS5ZYLFm
        tnw6WO5Fh1WjxCWa5scAy+3KOrtl32U66qAYwrM=
X-Google-Smtp-Source: APiQypIVGw2eaYqMU5Dw663QxfANI+6dEFgzsuroVXj18lqpc/GgU+vPtcf9hSVnxv32CYZ9wJ0TWAa1qEuwZ3CA7QQ=
X-Received: by 2002:ab0:2e84:: with SMTP id f4mr2977785uaa.121.1587571623320;
 Wed, 22 Apr 2020 09:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200421161355.1357112-1-masahiroy@kernel.org> <20200422131729.GB20103@linux-8ccs>
In-Reply-To: <20200422131729.GB20103@linux-8ccs>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 23 Apr 2020 01:06:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ-WcKf1QDOnefjkzg7Cq1fKNuEPDvH9TYU8tLwbUhtmg@mail.gmail.com>
Message-ID: <CAK7LNAQ-WcKf1QDOnefjkzg7Cq1fKNuEPDvH9TYU8tLwbUhtmg@mail.gmail.com>
Subject: Re: [PATCH v2] arch: split MODULE_ARCH_VERMAGIC definitions out to <asm/vermagic.h>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 22, 2020 at 10:17 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Masahiro Yamada [22/04/20 01:13 +0900]:
> [snip]
> >diff --git a/arch/xtensa/include/asm/module.h b/arch/xtensa/include/asm/vermagic.h
> >similarity index 72%
> >rename from arch/xtensa/include/asm/module.h
> >rename to arch/xtensa/include/asm/vermagic.h
> >index 488b40c6f9b9..6f9e359a54ac 100644
> >--- a/arch/xtensa/include/asm/module.h
> >+++ b/arch/xtensa/include/asm/vermagic.h
> >@@ -1,6 +1,4 @@
> > /*
> >- * include/asm-xtensa/module.h
> >- *
> >  * This file contains the module code specific to the Xtensa architecture.
>
> Maybe we can remove this comment too? Since it's now asm/vermagic.h and
> not asm/module.h anymore.

OK, I will delete it.

Thanks for checking it closely.




>
> Thanks for the cleanup. I agree that <linux/vermagic.h> shouldn't have
> any ordering dependency on <linux/module.h>.
>
> I just double checked to see if there were any other users of
> MODULE_ARCH_VERMAGIC that needed it through module.h, and there are
> none. It was literally just being defined in asm/module.h to be used
> in linux/vermagic.h. So there was no reason really to confine the
> MODULE_ARCH_VERMAGIC definition to asm/module.h.
>
> Acked-by: Jessica Yu <jeyu@kernel.org>



-- 
Best Regards
Masahiro Yamada
