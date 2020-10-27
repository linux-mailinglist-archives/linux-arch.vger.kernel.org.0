Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AD329AB3B
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 12:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899625AbgJ0Lx3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 07:53:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36744 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899620AbgJ0Lx3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Oct 2020 07:53:29 -0400
Received: by mail-io1-f65.google.com with SMTP id u19so1190093ion.3
        for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2020 04:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s+UBJg6LO9Rf1v1keW2mwB44PjQMVZlghePfQtTq54M=;
        b=iqYh9kcc313LqLNQ1u4THo/DppeQEGGrWD4aOGxMar3Y2DW1ZASEPI1TZCajzyWbQ6
         b3CrL66dJSqwP/YWR2lmAnp1wMHm9kQQL4ut04qtHRuAlsyqNt1/VrX5prOagxLSjBDV
         NL9l0nm97nL0V22EvKatUVRHCfiiwfrfSTBdxnKXmbkqn1ESdtWKtbWnBVFHj5UISPUJ
         IyEiVjg6EOSfRB4EHcgmXN30WxDSUzM4nv1wcaHIrWdBup/7owLVh51sLUksKQeKrLF0
         xUbBrOOpUlxxVHFZNsO7YdJ2ECy2kwRJ1hJqDjDdTSRiagBlFn0ecRg03JUEYoAkA27h
         3Mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s+UBJg6LO9Rf1v1keW2mwB44PjQMVZlghePfQtTq54M=;
        b=TlOc+vYkq/wkeZAg1XAH2gjFdZF72sXr+OoyVlhKBZVZKH9e9IuOkR/YqyBmQB4Mm7
         6QPQNGNhk0+PnHwPabJ6PFaHkrRRvPctDJCTLroho0dx+kIDlCVXUSVJ/ylqpiPj8t+K
         zGkxdH2R2R0C2NCCEVyd9KJlWJt5nI5iId8jjm8OahelfIjH7OC/uoFgOfYvZU6bl+iH
         dArCNYl8y9x+Vh4+QsCrkD0SkFmo2r58/539bkDqyHhr4SfYwM8KJURztIjL7I2Ut47t
         RU9znlbb4DfFbrE1BJTOvPjgwE1v7A6Skl84sgKApdxOXy2ME/iPnfYrJWIMoj94dxOE
         4qpw==
X-Gm-Message-State: AOAM530v+cxujKeSW3xYdD7RdATNm7UTaSHlAgsn7AswkfUoDGdrV58K
        XayuFWyI+H6fGbjObttl90LwRRxAzHkCiiq1q/QlsA==
X-Google-Smtp-Source: ABdhPJyvSct9JJTg273eAAF5FKtW1ItmWMUxF+cbtvl+7ovbBPYn79lxWvcnBziQwfg/eNxTx6jWn9QkHK0mkwDGp34=
X-Received: by 2002:a02:234a:: with SMTP id u71mr1925579jau.3.1603799607846;
 Tue, 27 Oct 2020 04:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200821194310.3089815-1-keescook@chromium.org>
 <20200821194310.3089815-14-keescook@chromium.org> <CAMuHMdUg0WJHEcq6to0-eODpXPOywLot6UD2=GFHpzoj_hCoBQ@mail.gmail.com>
 <CAMuHMdUw9KwC=EVB60yjg7mA7Fg-efOiKE7577p+uEdGJVS2OQ@mail.gmail.com>
 <CAMuHMdUJFEt3LxWHk73AsLDGhjzBvJGAML76UAxeGzb4zOf96w@mail.gmail.com>
 <CAMj1kXHXk3BX6mz6X_03sj_pSLj9Ck-=1S57tV3__N9JQOcDEw@mail.gmail.com>
 <20201027100844.GA1514990@myrica> <CAMuHMdVkLXmJEiV-uwOqKnfGQZX65tMFMTjs0O8q5BJsAhCGzg@mail.gmail.com>
 <CAMj1kXEdgOkH6VFa5_J6yqaJheToHUSM8jYXyGfA9JS5xwyLGQ@mail.gmail.com>
In-Reply-To: <CAMj1kXEdgOkH6VFa5_J6yqaJheToHUSM8jYXyGfA9JS5xwyLGQ@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 27 Oct 2020 17:23:16 +0530
Message-ID: <CA+G9fYsvr-Yjh4mxuVD8ZD+XpUSkh0475zpgHcf4LhV=b+P5Pg@mail.gmail.com>
Subject: Re: [PATCH v6 13/29] arm64/build: Assert for unwanted sections
To:     Ard Biesheuvel <ardb@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Collingbourne <pcc@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 27 Oct 2020 at 17:00, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 27 Oct 2020 at 11:20, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> >
> > Hi Jean-Philippe,
> >
> > On Tue, Oct 27, 2020 at 11:09 AM Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> > > On Mon, Oct 26, 2020 at 06:38:46PM +0100, Ard Biesheuvel wrote:
> > > > > > > Note that even on plain be2881824ae9eb92, I get:
> > > > > > >
> > > > > > >     aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected=
!
> > > > > > >     aarch64-linux-gnu-ld: Unexpected run-time procedure linka=
ges detected!
> > > > > > >
> > > > > > > The parent commit obviously doesn't show that (but probably s=
till has
> > > > > > > the problem).
> > > > >
> > > > > Reverting both
> > > > > b3e5d80d0c48c0cc ("arm64/build: Warn on orphan section placement"=
)
> > > > > be2881824ae9eb92 ("arm64/build: Assert for unwanted sections")
> > > > > seems to solve my problems, without any ill effects?
> > > > >
> > > >
> > > > I cannot reproduce the issue here with my distro GCC+binutils (Debi=
an 8.3.0)
> > >
> > > I have the same problem with one of my debug configs and Linux v5.10-=
rc1,
> > > and can reproduce with the Debian 8.3.0 toolchain, by using the arm64
> > > defconfig and disabling CONFIG_MODULES:
> > >
> > > ld -EL -maarch64elf --no-undefined -X -z norelro -shared -Bsymbolic -=
z notext --no-apply-dynamic-relocs --fix-cortex-a53-843419 --orphan-handlin=
g=3Dwarn --build-id=3Dsha1 --strip-debug -o .tmp_vmlinux.kallsyms1 -T ./arc=
h/arm64/kernel/vmlinux.lds --whole-archive arch/arm64/kernel/head.o init/bu=
ilt-in.a usr/built-in.a arch/arm64/built-in.a kernel/built-in.a certs/built=
-in.a mm/built-in.a fs/built-in.a ipc/built-in.a security/built-in.a crypto=
/built-in.a block/built-in.a arch/arm64/lib/built-in.a lib/built-in.a drive=
rs/built-in.a sound/built-in.a net/built-in.a virt/built-in.a --no-whole-ar=
chive --start-group arch/arm64/lib/lib.a lib/lib.a ./drivers/firmware/efi/l=
ibstub/lib.a --end-group
> > > ld: Unexpected GOT/PLT entries detected!
> > > ld: Unexpected run-time procedure linkages detected!

 ld: Unexpected GOT/PLT entries detected!
 ld: Unexpected run-time procedure linkages detected!

The arm64 build error fixed by (I have tested defconfig)

[PATCH] soc: qcom: QCOM_RPMH fix build with modular QCOM_RPMH
https://lore.kernel.org/linux-arm-msm/20201027111422.4008114-1-anders.roxel=
l@linaro.org/
---

When building allmodconfig leading to the following link error with
CONFIG_QCOM_RPMH=3Dy and CONFIG_QCOM_COMMAND_DB=3Dm:

aarch64-linux-gnu-ld: drivers/clk/qcom/clk-rpmh.o: in function `clk_rpmh_pr=
obe':
  drivers/clk/qcom/clk-rpmh.c:474: undefined reference to `cmd_db_read_addr=
'
  drivers/clk/qcom/clk-rpmh.c:474:(.text+0x254): relocation truncated
to fit: R_AARCH64_CALL26 against undefined symbol `cmd_db_read_addr'

Fix this by adding a Kconfig depenency and forcing QCOM_RPMH to be a
module when QCOM_COMMAND_DB is a module. Also removing the dependency on
'ARCH_QCOM || COMPILE_TEST' since that is already a dependency for
QCOM_COMMAND_DB.

Fixes: 778279f4f5e4 ("soc: qcom: cmd-db: allow loading as a module")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 9b4ae9c16ba7..3bdd1604f78f 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -109,7 +109,7 @@ config QCOM_RMTFS_MEM

 config QCOM_RPMH
  tristate "Qualcomm RPM-Hardened (RPMH) Communication"
- depends on ARCH_QCOM || COMPILE_TEST
+ depends on QCOM_COMMAND_DB
  help
   Support for communication with the hardened-RPM blocks in
   Qualcomm Technologies Inc (QTI) SoCs. RPMH communication uses an
--=20
2.28.0


- Naresh
