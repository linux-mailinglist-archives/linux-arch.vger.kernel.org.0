Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03E6F18E7C8
	for <lists+linux-arch@lfdr.de>; Sun, 22 Mar 2020 10:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgCVJTh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 22 Mar 2020 05:19:37 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40183 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgCVJTh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Mar 2020 05:19:37 -0400
Received: by mail-pj1-f66.google.com with SMTP id bo3so4562233pjb.5;
        Sun, 22 Mar 2020 02:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=RcD8qCKrPNyWahymG+XggFywpYlZflG+yOoi1VKPcZM=;
        b=StLgn8PbrwJUm7PSm4ZmiUUFOZu5relJteRb0w2rOHU3ZbLHU2J1ymZ7llG0UkTnVz
         0QOKG27kbiHAv3LEJMwGjELp7f6ExNG0iB/+ioSz5/++rhSlLfDtpzeQg2Jmd+KKFcik
         ZTzzc795Ico0pVtHbhCjmOOXqYVNFrRYlCB5HFyF5ZR8CPoFqJilS5wewFeaMkaXh/IX
         hoSV/F0EnxnIpokg14WI6ejSYSdOR/dkZPbgxlDt3FV777EyA5Ac+yxpLCLvHpRBKL3R
         QkWTocxO3YBvXJsMjV5KSE25kW6t6KwTp+2mW5Dj2qFj+airVbQaPTFRrg/MKH2ohuSA
         AgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=RcD8qCKrPNyWahymG+XggFywpYlZflG+yOoi1VKPcZM=;
        b=QGyi6rv1wlMlG1QHOhm8vABpfY/gcs5j2KLbBZoftFnKX+pK3ndkzU8VukO1ge7boR
         D59oG6GwCsifLDuX0k2OnTxgnekaeLprUP8mvZFDtxk9kO6ebojkLRZkL8XxDoiARbB8
         D0ENSeqy2YTSq4ig2GCrWLAI7NeXHRN0QkSHWl9S7hJB6ii/m4qZCvTnLwRNdBVtkdTl
         XijSsTxdxAq0SVM5W+5TWk8PUF5R+dhiLSshFkP9PcibWHEVOLEfg8ZvarmZWGUmn1Pf
         7zByW9oNZw4K/p6PoVMKNxZc9IJGWm7thDPbs5uFMpKRPXfx0psCSOmBGnY3Bj3IWke/
         Jd7A==
X-Gm-Message-State: ANhLgQ1PkimG1nrIydueKzCmozaZEoihUyyly9xyOgwAk5Qo9h4o7kKu
        tJb+BIFoHHLabnxo4uvPuQU=
X-Google-Smtp-Source: ADFU+vtSQWcRQXBqFkI6+6wD9KgSitqZbOhf0f5r0lePNLY7dXEhFsjp8mRszfo1EE5B+fQ+MhbwMA==
X-Received: by 2002:a17:902:169:: with SMTP id 96mr16385732plb.140.1584868776275;
        Sun, 22 Mar 2020 02:19:36 -0700 (PDT)
Received: from localhost (14-202-190-183.tpgi.com.au. [14.202.190.183])
        by smtp.gmail.com with ESMTPSA id 6sm10061621pfx.69.2020.03.22.02.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 02:19:35 -0700 (PDT)
Date:   Sun, 22 Mar 2020 19:16:29 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/9] scripts/link-vmlinux.sh: Delay orphan handling
 warnings until final link
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
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
        <1584672297.mudnpz3ir9.astroid@bobo.none> <202003201121.8CBD96451B@keescook>
In-Reply-To: <202003201121.8CBD96451B@keescook>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1584868418.o62lxee8k1.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook's on March 21, 2020 4:24 am:
> On Fri, Mar 20, 2020 at 12:47:54PM +1000, Nicholas Piggin wrote:
>> Kees Cook's on February 28, 2020 10:22 am:
>> > Right now, powerpc adds "--orphan-handling=3Dwarn" to LD_FLAGS_vmlinux
>> > to detect when there are unexpected sections getting added to the kern=
el
>> > image. There is no need to report these warnings more than once, so it
>> > can be removed until the final link stage.
>> >=20
>> > This helps pave the way for other architectures to enable this, with t=
he
>> > end goal of enabling this warning by default for vmlinux for all
>> > architectures.
>> >=20
>> > Signed-off-by: Kees Cook <keescook@chromium.org>
>> > ---
>> >  scripts/link-vmlinux.sh | 6 ++++++
>> >  1 file changed, 6 insertions(+)
>> >=20
>> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
>> > index 1919c311c149..416968fea685 100755
>> > --- a/scripts/link-vmlinux.sh
>> > +++ b/scripts/link-vmlinux.sh
>> > @@ -255,6 +255,11 @@ info GEN modules.builtin
>> >  tr '\0' '\n' < modules.builtin.modinfo | sed -n 's/^[[:alnum:]:_]*\.f=
ile=3D//p' |
>> >  	tr ' ' '\n' | uniq | sed -e 's:^:kernel/:' -e 's/$/.ko/' > modules.b=
uiltin
>> > =20
>> > +
>> > +# Do not warn about orphan sections until the final link stage.
>> > +saved_LDFLAGS_vmlinux=3D"${LDFLAGS_vmlinux}"
>> > +LDFLAGS_vmlinux=3D"$(echo "${LDFLAGS_vmlinux}" | sed -E 's/ --orphan-=
handling=3Dwarn( |$)/ /g')"
>> > +
>> >  btf_vmlinux_bin_o=3D""
>> >  if [ -n "${CONFIG_DEBUG_INFO_BTF}" ]; then
>> >  	if gen_btf .tmp_vmlinux.btf .btf.vmlinux.bin.o ; then
>> > @@ -306,6 +311,7 @@ if [ -n "${CONFIG_KALLSYMS}" ]; then
>> >  	fi
>> >  fi
>> > =20
>> > +LDFLAGS_vmlinux=3D"${saved_LDFLAGS_vmlinux}"
>> >  vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o}
>> > =20
>> >  if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
>>=20
>> That's ugly. Why not just enable it for all archs?
>=20
> It is ugly; I agree.
>=20
> I can try to do this for all architectures, but I worry there are a
> bunch I can't test. But I guess it would stand out. ;)

It's only warn, so it doesn't break their builds (unless there's a=20
linker error on warn option I don't know about?). We had a powerpc bug=20
that would have been caught with it as well, so it's not a bad idea to
get everyone using it.

I would just do it. Doesn't take much to fix.

Thanks,
Nick
=
