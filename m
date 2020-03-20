Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA9218C57B
	for <lists+linux-arch@lfdr.de>; Fri, 20 Mar 2020 03:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgCTCuE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Mar 2020 22:50:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38350 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgCTCuD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Mar 2020 22:50:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so2488594pfn.5;
        Thu, 19 Mar 2020 19:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=fgot+Xsy3J7zXuUTY5kkaEeqV+yRF2impnvgtPmEfao=;
        b=L0kBrlLMBI3+WhEsLPiGtQAxqrzmC8iOxCrJsjIkK55dysLaJ/w45dlBCRoHGC5XFg
         vOBR1IRoPy2cWk8OsdmUAY6/hWy6xhUiUVyQZuIrSVtk7sf32MEH6Q7n0chFyYSipV/g
         Hu0q846438T8JIcnyX1QNBz/Yj7ovQAOWb+OzO8li3A/KsW+FSldUVmj165g5ScvgEla
         Sw4h2jTL9xKIXNdY3/UIVh8hPWWJAZV0VkETl6hZkkkMEPlHtGsYaTFZkBx74ayLyjk8
         n8nJ6XCrMB0Ji3S6oke0pykuUqOsbpd4eB7rYRxME/5dx0JJyF1ty/T3N5YUJZDULm3O
         90PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=fgot+Xsy3J7zXuUTY5kkaEeqV+yRF2impnvgtPmEfao=;
        b=qP5I/2GGFcJNueZqy/OzMPh4QVDEAVVYe41+Ag1dJ1iuh+hyunV6UYSQcApOAgi21y
         Vz+FG9aq3pONBJw1Pf0pCLtBeM4UGTTQsxYh9genDHnP/ghiNfoonWFuTNMGf6sp0IEU
         elWth9Y4zJzL27rl/x1SYZQh8L8+rqBTtORNv+Yzkr7IY5UCvZe1MUJpiplsdw1H5m8q
         aPAkeRBGJ641Fco2JMkxBiFSLJizMLC64UcO2byRI1BulcfV6a0UOezbGlI0NK5ODUTG
         AiN2wwNnzfM4RToX4tbRS6e1sF6+c836x3OAFNEIVBwdFIqcZW14VrvUTzuifhR9OZp1
         Gq5w==
X-Gm-Message-State: ANhLgQ0O/uMo/48NdejyYg/o4rTzLIpceFfBFF9gbAa6Vf3iZppFW5wP
        m1wRL8B1tXpNJXg/h4wNEcY=
X-Google-Smtp-Source: ADFU+vum6TzPT6urcNH4toGY+Kyyf57jb8jZNQwrspD0BQ2cxvYAfKe+zDymuuQbk/BHxNj9gy/19Q==
X-Received: by 2002:aa7:9244:: with SMTP id 4mr7135748pfp.228.1584672602583;
        Thu, 19 Mar 2020 19:50:02 -0700 (PDT)
Received: from localhost (14-202-190-183.tpgi.com.au. [14.202.190.183])
        by smtp.gmail.com with ESMTPSA id y3sm3733215pfy.158.2020.03.19.19.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 19:50:01 -0700 (PDT)
Date:   Fri, 20 Mar 2020 12:47:54 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/9] scripts/link-vmlinux.sh: Delay orphan handling
 warnings until final link
To:     Borislav Petkov <bp@suse.de>, Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux@googlegroups.com,
        "H.J. Lu" <hjl.tools@gmail.com>, James Morse <james.morse@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20200228002244.15240-1-keescook@chromium.org>
        <20200228002244.15240-2-keescook@chromium.org>
In-Reply-To: <20200228002244.15240-2-keescook@chromium.org>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1584672297.mudnpz3ir9.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook's on February 28, 2020 10:22 am:
> Right now, powerpc adds "--orphan-handling=3Dwarn" to LD_FLAGS_vmlinux
> to detect when there are unexpected sections getting added to the kernel
> image. There is no need to report these warnings more than once, so it
> can be removed until the final link stage.
>=20
> This helps pave the way for other architectures to enable this, with the
> end goal of enabling this warning by default for vmlinux for all
> architectures.
>=20
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  scripts/link-vmlinux.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 1919c311c149..416968fea685 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -255,6 +255,11 @@ info GEN modules.builtin
>  tr '\0' '\n' < modules.builtin.modinfo | sed -n 's/^[[:alnum:]:_]*\.file=
=3D//p' |
>  	tr ' ' '\n' | uniq | sed -e 's:^:kernel/:' -e 's/$/.ko/' > modules.buil=
tin
> =20
> +
> +# Do not warn about orphan sections until the final link stage.
> +saved_LDFLAGS_vmlinux=3D"${LDFLAGS_vmlinux}"
> +LDFLAGS_vmlinux=3D"$(echo "${LDFLAGS_vmlinux}" | sed -E 's/ --orphan-han=
dling=3Dwarn( |$)/ /g')"
> +
>  btf_vmlinux_bin_o=3D""
>  if [ -n "${CONFIG_DEBUG_INFO_BTF}" ]; then
>  	if gen_btf .tmp_vmlinux.btf .btf.vmlinux.bin.o ; then
> @@ -306,6 +311,7 @@ if [ -n "${CONFIG_KALLSYMS}" ]; then
>  	fi
>  fi
> =20
> +LDFLAGS_vmlinux=3D"${saved_LDFLAGS_vmlinux}"
>  vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o}
> =20
>  if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then

That's ugly. Why not just enable it for all archs?

Thanks,
Nick
=
