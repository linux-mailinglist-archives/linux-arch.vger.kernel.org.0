Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D00434ABAC
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 16:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhCZPm7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 11:42:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230273AbhCZPmu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Mar 2021 11:42:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5666961A2A;
        Fri, 26 Mar 2021 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616773369;
        bh=vsTZ/vYOkJZ+dX5RIeYP0sX4VHZ0dMLJGNZeZ1Bm2LQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DUfi5ugO3VGJM2909lBb9UInMPNrDa6EKQqVta1cIaa0jmi9PW3AK/KjrURwAztbo
         i8x5fBqV0zqtki7tKp5qsvRSp+6JN+/eJ6Ieou5FWpav1oVdXzMR9PQmnDp1YWOfOs
         rjJ3avEH5azOsGiVuuyxYhIiIBwrj4oZjmpnUvQIneHge5J52ma4iOUznrC66JY4V8
         tPmhAAColcWAlYEXk93IiPpU/VFt/H+KOGM/w6qxjuUILfYJP2A9DdngmKH0rgvYm1
         Dqclqe/hpH6HH+86ckSN06JT8aWetb7V0wJymW/nFAsU2yRrYVduN9qA2/Ow3crzZ9
         +c/utZ5v2WmJQ==
Received: by mail-ej1-f49.google.com with SMTP id hq27so9062961ejc.9;
        Fri, 26 Mar 2021 08:42:49 -0700 (PDT)
X-Gm-Message-State: AOAM531frzlW8TnrAMkRBdmfmHr7h8VVjAPjKk9Q5WOpOTuQY9bKZkG7
        Mvogmp9jPl4pU3ajbS+P35xe7o1ZvbA5AxrVwA==
X-Google-Smtp-Source: ABdhPJw290YYi5Bn9eJbiCdu+yLMROaG22thNNy/WhodM/XBcUW19HUG6/I3aYcxY0qwZKx/hSfuN8oDM18cKkgl6sQ=
X-Received: by 2002:a17:906:7d48:: with SMTP id l8mr15784305ejp.108.1616773367877;
 Fri, 26 Mar 2021 08:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616765869.git.christophe.leroy@csgroup.eu> <878228ad88df38f8914c7aa25dede3ed05c50f48.1616765869.git.christophe.leroy@csgroup.eu>
In-Reply-To: <878228ad88df38f8914c7aa25dede3ed05c50f48.1616765869.git.christophe.leroy@csgroup.eu>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 26 Mar 2021 09:42:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKr3xekKSo3DtQvOOw_VoGC=FUTagZGY5g=CGGGdUZSMQ@mail.gmail.com>
Message-ID: <CAL_JsqKr3xekKSo3DtQvOOw_VoGC=FUTagZGY5g=CGGGdUZSMQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] cmdline: Add generic function to build command line.
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Will Deacon <will@kernel.org>, Daniel Walker <danielwa@cisco.com>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>, devicetree@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        microblaze <monstr@monstr.eu>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        nios2 <ley.foon.tan@intel.com>,
        Openrisc <openrisc@lists.librecores.org>,
        linux-hexagon@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org,
        SH-Linux <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 26, 2021 at 7:44 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> This code provides architectures with a way to build command line
> based on what is built in the kernel and what is handed over by the
> bootloader, based on selected compile-time options.

Note that I have this patch pending:

https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210316193820.3137-1-alex@ghiti.fr/

It's going to need to be adapted for this. I've held off applying to
see if this gets settled.

>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v3:
> - Addressed comments from Will
> - Added capability to have src == dst
> ---
>  include/linux/cmdline.h | 57 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 include/linux/cmdline.h
>
> diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
> new file mode 100644
> index 000000000000..dea87edd41be
> --- /dev/null
> +++ b/include/linux/cmdline.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_CMDLINE_H
> +#define _LINUX_CMDLINE_H
> +
> +#include <linux/string.h>
> +
> +/* Allow architectures to override strlcat, powerpc can't use strings so early */
> +#ifndef cmdline_strlcat
> +#define cmdline_strlcat strlcat
> +#endif
> +
> +/*
> + * This function will append or prepend a builtin command line to the command
> + * line provided by the bootloader. Kconfig options can be used to alter
> + * the behavior of this builtin command line.
> + * @dst: The destination of the final appended/prepended string.
> + * @src: The starting string or NULL if there isn't one.
> + * @len: the length of dest buffer.
> + */
> +static __always_inline void __cmdline_build(char *dst, const char *src, size_t len)
> +{
> +       if (!len || src == dst)
> +               return;
> +
> +       if (IS_ENABLED(CONFIG_CMDLINE_FORCE) || !src) {
> +               dst[0] = 0;
> +               cmdline_strlcat(dst, CONFIG_CMDLINE, len);
> +               return;
> +       }
> +
> +       if (dst != src)
> +               dst[0] = 0;
> +
> +       if (IS_ENABLED(CONFIG_CMDLINE_PREPEND))
> +               cmdline_strlcat(dst, CONFIG_CMDLINE " ", len);
> +
> +       cmdline_strlcat(dst, src, len);
> +
> +       if (IS_ENABLED(CONFIG_CMDLINE_EXTEND))

Should be APPEND.

> +               cmdline_strlcat(dst, " " CONFIG_CMDLINE, len);
> +}
> +
> +#define cmdline_build(dst, src, len) do {                              \

Perhaps a comment why we need this to be a define.

> +       char *__c_dst = (dst);                                          \
> +       const char *__c_src = (src);                                    \
> +                                                                       \
> +       if (__c_src == __c_dst) {                                       \
> +               static char __c_tmp[COMMAND_LINE_SIZE] __initdata = ""; \
> +                                                                       \
> +               cmdline_strlcat(__c_tmp, __c_src, COMMAND_LINE_SIZE);   \
> +               __cmdline_build(__c_dst, __c_tmp, (len));               \
> +       } else {                                                        \
> +               __cmdline_build(__c_dst, __c_src, (len));               \
> +       }                                                               \
> +} while (0)
> +
> +#endif /* _LINUX_CMDLINE_H */
> --
> 2.25.0
>
