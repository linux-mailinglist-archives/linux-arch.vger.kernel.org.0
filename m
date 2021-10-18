Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94206431085
	for <lists+linux-arch@lfdr.de>; Mon, 18 Oct 2021 08:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhJRG3f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Oct 2021 02:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhJRG3f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Oct 2021 02:29:35 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1DEC06161C;
        Sun, 17 Oct 2021 23:27:24 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f21so10510022plb.3;
        Sun, 17 Oct 2021 23:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=xax6w8vdDeorgOHfukYruV4crW1zSmA0Yn4dKXojVlM=;
        b=Yk6LSNqkisKS10pGs8UquN9x1ScpNWbbgjoL8+BGGKLSgbjdOJ3dp2g4efx3BdfCeO
         cpsPii0dvmpI5i4at1AfbwppVJhgOZ26idOW0GLdOQeVwmefcEItygifPo86mrnha+x4
         NIWZpYpHR6kFun2FQLxF27U9o+qV07b0vK5G5WgPn0ZpzX17VLkkiSKRVCgpZqXAf1zx
         dde5W/U0tdvOvf4D4gu07I1Mu1xeQafVvUZkcLv7n3kFF4kmbn3gONaEYyunqyFktKGo
         6DMc6sMtkN+zto4NUMtwLpDv/oq52HG/WZSSVvcUNKEUfVlsnVRXiyWwOzDYjZsSlcBw
         1jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=xax6w8vdDeorgOHfukYruV4crW1zSmA0Yn4dKXojVlM=;
        b=rZElkmZOz302i+uWOBrMOT0cOUfVn7Eh2a+A26IPRRfExVUe3EBiI4i2imAtil7Gia
         srPVwxKGGJqDy/H6odbPXBT62ii1yrPdTu2Swz18MNlUXlY82LYJjy64lCuQK7cTVrTx
         4LXsGUiHoSf1pBiRsD1i/+HYdIqhXEZ4hiI94levK4SGy0JY5yfC/46xrlWgRKNXwBWv
         fCJ/9yjYPq+7DVqt5wtnmohiPC49lcDmg5reK5XqComPV6/251mRRbfj3Cs2WeZTdEaR
         dRtfGoHLUVRM1gVtVh4rL4JTraN7oytm42A7/Fbd3BYUbOXIsya4+9kWopDc9ZvkMm7S
         FPJw==
X-Gm-Message-State: AOAM532Cfp4TWuCzjMBbupIGyYvrdV+k3FEBsni0cGc9U/F0DNrtyQDw
        h2K6HcNcCYswzmt7KbwYaFI=
X-Google-Smtp-Source: ABdhPJw0GP7RprUuWC+8YWTOwY32i9+w+LmnM+jhtULZlF66OhLA6thzoj0Ge0GcMhEsc7ZGu2Pfgw==
X-Received: by 2002:a17:90a:1a43:: with SMTP id 3mr46829314pjl.242.1634538444308;
        Sun, 17 Oct 2021 23:27:24 -0700 (PDT)
Received: from localhost ([1.128.241.185])
        by smtp.gmail.com with ESMTPSA id t125sm11910863pfc.119.2021.10.17.23.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 23:27:24 -0700 (PDT)
Date:   Mon, 18 Oct 2021 16:27:17 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 04/12] powerpc: Prepare func_desc_t for refactorisation
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
References: <cover.1634457599.git.christophe.leroy@csgroup.eu>
        <86c393ce0a6f603f94e6d2ceca08d535f654bb23.1634457599.git.christophe.leroy@csgroup.eu>
In-Reply-To: <86c393ce0a6f603f94e6d2ceca08d535f654bb23.1634457599.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1634536863.oq0s171f8c.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Christophe Leroy's message of October 17, 2021 10:38 pm:
> In preparation of making func_desc_t generic, change the ELFv2
> version to a struct containing 'addr' element.
>=20
> This allows using single helpers common to ELFv1 and ELFv2.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>  arch/powerpc/kernel/module_64.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module=
_64.c
> index a89da0ee25e2..b687ef88c4c4 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -33,19 +33,13 @@
>  #ifdef PPC64_ELF_ABI_v2
> =20
>  /* An address is simply the address of the function. */
> -typedef unsigned long func_desc_t;
> +typedef struct {
> +	unsigned long addr;
> +} func_desc_t;

I'm not quite following why this change is done. I guess it is so you=20
can move this func_desc_t type into core code, but why do that? Is it
just to avoid using the preprocessor?

On its own this patch looks okay.

Acked-by: Nicholas Piggin <npiggin@gmail.com>
