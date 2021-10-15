Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F4E42E88D
	for <lists+linux-arch@lfdr.de>; Fri, 15 Oct 2021 07:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhJOGAI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Oct 2021 02:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhJOGAH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Oct 2021 02:00:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3D7C061570;
        Thu, 14 Oct 2021 22:58:02 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id oa4so6510117pjb.2;
        Thu, 14 Oct 2021 22:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=S0rBIBfnndl4sO0SZD30iqTuRSBoy5r+zNmXEO729ec=;
        b=BvkezB9DzKzErquz1XZOTKqoL0XOL3U6Eb5odSJ6flnnPgmmGEa3vMoyopsdwVJpIo
         +kJ9msCSx7YGPh77U30LXnNLubl1IugeDdeSuYmeI37nvbmhSm5CsYs8iAoSKXMNhzxO
         6i912LlK4afHQGJIc4S85mDVOKR5UpDhCrBkxj6ietrjMxi2fywEBEuiLIZgu19q/I1g
         +8t1vHWN0EHqjETvz4uZZN6EvLLpsZtZkFFYte3N8uN6vsiAuv/ZnqxmivZw24+wB8Ud
         WkPTCZYNe4CFVIiv/WGJwu9SWhmgRP+wcQq7L1rL9ZDmaijfZRGwseytUWA+JVHD4hhp
         bQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=S0rBIBfnndl4sO0SZD30iqTuRSBoy5r+zNmXEO729ec=;
        b=2p8HxqnQZJYWN/YwizFmmui3XGO26KQT1H11Qcllsa35lpn8ugqmnBSGPWdDdUu4+T
         bBs4/vK7BUcxyRJhy2OveF0t4oKWrH0NcPRc8k8+RxeicoZS6f8xb3SeZaVc8AQ+aKRA
         tTqdpZJ0Eww3XgBNzy93k8s3glA0kNqvnuKrp4k9aHS30MOxtwG/WsqtVhmemW9kdwzu
         S3Sq1yTxpsi3IL3DfyW4rmzhJ9LBd2ZYmjxAf979c/bs02GmNoYBGSab5nGtaNu6FkIj
         HpIrHtNpVvEJr6qNqHAJoON14W1SEYKDIaPMDuHsA94TQy1zDlf9539wDcswXwEcYvGU
         FEZQ==
X-Gm-Message-State: AOAM530/G26Rho+vXu+ES6b2iN9otU3d8TAP66BWFtLsR4MSeJL6a6U+
        qCTtVUPWvNp0WK8XlAEBPDY=
X-Google-Smtp-Source: ABdhPJyXz4rN56bUpmFK5R707chQeiJbYyyVjPcMsN6ywtX2cPlh5ALJb3tBLebih8BJB0NaHGRlvg==
X-Received: by 2002:a17:902:d488:b0:13f:165e:f491 with SMTP id c8-20020a170902d48800b0013f165ef491mr9412847plg.12.1634277481786;
        Thu, 14 Oct 2021 22:58:01 -0700 (PDT)
Received: from localhost (14-203-144-177.static.tpgi.com.au. [14.203.144.177])
        by smtp.gmail.com with ESMTPSA id t126sm4092988pfc.80.2021.10.14.22.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 22:58:01 -0700 (PDT)
Date:   Fri, 15 Oct 2021 15:57:56 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 01/13] powerpc: Move 'struct ppc64_opd_entry' back into
 asm/elf.h
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
        <42d2a571677e60082c0a5b3e52e855aa58c0b1fc.1634190022.git.christophe.leroy@csgroup.eu>
In-Reply-To: <42d2a571677e60082c0a5b3e52e855aa58c0b1fc.1634190022.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1634277306.r82aohhn4e.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Christophe Leroy's message of October 14, 2021 3:49 pm:
> 'struct ppc64_opd_entry' doesn't belong to uapi/asm/elf.h
>=20
> It was initially in module_64.c and commit 2d291e902791 ("Fix compile
> failure with non modular builds") moved it into asm/elf.h
>=20
> But it was by mistake added outside of __KERNEL__ section,
> therefore commit c3617f72036c ("UAPI: (Scripted) Disintegrate
> arch/powerpc/include/asm") moved it to uapi/asm/elf.h
>=20
> Move it back into asm/elf.h, this brings it back in line with
> IA64 and PARISC architectures.
>=20
> Fixes: 2d291e902791 ("Fix compile failure with non modular builds")
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/elf.h      | 6 ++++++
>  arch/powerpc/include/uapi/asm/elf.h | 8 --------
>  2 files changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/el=
f.h
> index b8425e3cfd81..a4406714c060 100644
> --- a/arch/powerpc/include/asm/elf.h
> +++ b/arch/powerpc/include/asm/elf.h
> @@ -176,4 +176,10 @@ do {									\
>  /* Relocate the kernel image to @final_address */
>  void relocate(unsigned long final_address);
> =20
> +/* There's actually a third entry here, but it's unused */
> +struct ppc64_opd_entry {
> +	unsigned long funcaddr;
> +	unsigned long r2;
> +};

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

I wonder if we should add that third entry, just for completeness. And=20
'r2' isn't a good name should probably be toc. And should it be packed?=20
At any rate that's not for your series, a cleanup I might think about
for later.

Thanks,
Nick
