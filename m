Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC347356B01
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 13:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhDGLVV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 07:21:21 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:24719 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbhDGLVS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 07:21:18 -0400
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 137BKhnJ013110;
        Wed, 7 Apr 2021 20:20:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 137BKhnJ013110
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617794444;
        bh=G0PsxuTCRYleITrpebh/KQqBucXErq8mDiRTnqj+jRc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PwkJd5c/1UdO+tO0105H0IMxV6siXPbzVxpZcPHGP+Xj2f0+vcOZuL4dfEcmQ9kZd
         Ys56fhrEKzv49PIPH0iSD2kttOcVsAIEi2BJbkXz4tJgdTffiwkMKcQPM9c8FLumKe
         9Celozv/kMVa/uUGsLtxIdqs4IwyuDbRdOgJyzf1F7pRA1CGN4arQ8dzusla+CAoh/
         4XdQxNUTHYdi9OOlpXazeqaeDqvR3k0oUy4wrlejdTDSyAMHckfMMaXCv1UxWWO4xY
         uUyxiXm/9CdFAGVNPTqz1QwAXKKJ4rzJHAlnU9169EXbndf7aq/2t/pVolVKdzx6X/
         oHmCGuClOR9qg==
X-Nifty-SrcIP: [209.85.215.171]
Received: by mail-pg1-f171.google.com with SMTP id w10so7313338pgh.5;
        Wed, 07 Apr 2021 04:20:43 -0700 (PDT)
X-Gm-Message-State: AOAM532Ti1H2HRzcph8hSLmI094clMkOBpOcU8CLWiI3ZqzJWGtV3apm
        SFFj68XOosdmw0mMzX2uy7N8RxgbkK4Y/3Kf3Jw=
X-Google-Smtp-Source: ABdhPJyuM3zDq/S6RN/whrMH7XalHhmfB+0ulZ1eAQqznKjj8bFo2KHgbUd1Ts7rlqf/94Rk50eG6Rnra8P8P/PhzlE=
X-Received: by 2002:a63:181c:: with SMTP id y28mr2918030pgl.175.1617794443128;
 Wed, 07 Apr 2021 04:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210407053419.449796-1-gregkh@linuxfoundation.org> <20210407053419.449796-14-gregkh@linuxfoundation.org>
In-Reply-To: <20210407053419.449796-14-gregkh@linuxfoundation.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 7 Apr 2021 20:20:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQPizm-VmMDF5FP516OofcwXHRyGWkb6qy9VNFTGP3u4A@mail.gmail.com>
Message-ID: <CAK7LNAQPizm-VmMDF5FP516OofcwXHRyGWkb6qy9VNFTGP3u4A@mail.gmail.com>
Subject: Re: [PATCH 13/20] kbuild: nds32: convert to use the common install scripts
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 7, 2021 at 2:35 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> It seems that no one ever checked in the nds32 install script so trying
> to build a nds32 kernel would never quite work properly as 'make
> install' would fail to run.
>
> Fix that up by having nds32 call the common install.sh script.
>
> Cc: Nick Hu <nickhu@andestech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Vincent Chen <deanbo422@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/nds32/boot/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/nds32/boot/Makefile b/arch/nds32/boot/Makefile
> index c4cc0c2689f7..8371e02f6091 100644
> --- a/arch/nds32/boot/Makefile
> +++ b/arch/nds32/boot/Makefile
> @@ -8,9 +8,9 @@ $(obj)/Image.gz: $(obj)/Image FORCE
>         $(call if_changed,gzip)
>
>  install: $(obj)/Image
> -       $(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
> +       $(CONFIG_SHELL) $(srctree)/scripts/install.sh $(KERNELRELEASE) \
>         $(obj)/Image System.map "$(INSTALL_PATH)"
>
>  zinstall: $(obj)/Image.gz
> -       $(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
> +       $(CONFIG_SHELL) $(srctree)/scripts/install.sh $(KERNELRELEASE) \
>         $(obj)/Image.gz System.map "$(INSTALL_PATH)"
> --
> 2.31.1
>


Even with this patch, the 'install' target does not work.

$ make ARCH=nds32 install
make: *** No rule to make target 'install'.  Stop.




If you really want to fix it, you need
to add something like follows:





diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
index ccdca7142020..3486b78da9ca 100644
--- a/arch/nds32/Makefile
+++ b/arch/nds32/Makefile
@@ -53,6 +53,9 @@ core-y += $(boot)/dts/
 Image: vmlinux
        $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@

+PHONY += install zinstall
+install zinstall:
+       $(Q)$(MAKE) $(build)=$(boot) $@

 PHONY += vdso_install
 vdso_install:





Anyway, I agree that nds32 installation targets are
terribly broken.


--
Best Regards
Masahiro Yamada
