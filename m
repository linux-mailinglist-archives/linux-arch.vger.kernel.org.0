Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318CE42EAE7
	for <lists+linux-arch@lfdr.de>; Fri, 15 Oct 2021 10:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbhJOIFr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Oct 2021 04:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbhJOIEP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Oct 2021 04:04:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E7AC061570;
        Fri, 15 Oct 2021 01:02:06 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so8779431pjb.5;
        Fri, 15 Oct 2021 01:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=LcM+UHlFK6Pfd+gEtHbJF09UeSP+pe47XQ11Z5avvEg=;
        b=ZyQ7hsmusqR3lpIB+4jVL1CZJhbUN3wIXVwfcqZRTh7YjNgeRMolohGOMUDgZa5JFk
         5hu4f8+DyFDYQvHUKeaH4iwxqLbjXa6B5jwA0ZS3Q2cK/rTHNtvPRV7STwIhBJ4q0/dS
         gjTxe5u1++xCa1cryzKvYmDjPaNzP4pUAih2/vPPogCIkQd3KvJlMoEVBZJdkkyxFpK1
         m9nlpZVULb3/vrI/ROKVbpfaBzpfcdMEQZCksz+V4o1oVt/iua2ZAVLU7FbsXVVsCRS4
         wtE8V9dIYvn1mj3SwuRsaw8BSYmZJkXtfz0K4JkS/ZlBu5QRVlMHaHMbH8oAoCBhwJZb
         9fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=LcM+UHlFK6Pfd+gEtHbJF09UeSP+pe47XQ11Z5avvEg=;
        b=qAvc3WmWoimO6S2kwa8UD1aKRFVrvlGHfxyMoYOaofyHmbb6/0jKogRGPjLxoJnbvg
         d11XKhXl4kn/OUoyBwNUI03+dLcip++bLexPJj13gFmbwa8eCAR6nEYnRJ/ORLANcxyr
         DmaUjn1yHuq9SI3sf2gfkYgaQvZxZIK8oHQ6RKncwhzzpkRNDguSwU1LMQppz7fVuZEy
         OM8DhNGgJzw/1bWrbWU2VBMHrxsowCI/zWnkFoHHrO6MYpPu++gW2j75bB4D5Uj2YOKl
         fzpWWmWaEFKSKZT4uW/6LItoX8bnj7AqN0Qvimig9dqMmlc/Lof6i698nw9HOJf4YJLU
         1jXQ==
X-Gm-Message-State: AOAM531xNJrdY99IwU86aJmclm4XQT6a06nzNSlqOUISUWscaoPUaxDi
        FPsmc3WkpcdexoqhCOT1hPU=
X-Google-Smtp-Source: ABdhPJzj9O7pqlmGSv6dHaxotuTUhJBqQGbDk2OY1xR8CUwFnQB2mcPNJnY0o5eFmCaqPtRJZKn3BQ==
X-Received: by 2002:a17:90b:1bd2:: with SMTP id oa18mr3158237pjb.164.1634284926242;
        Fri, 15 Oct 2021 01:02:06 -0700 (PDT)
Received: from localhost (14-203-144-177.static.tpgi.com.au. [14.203.144.177])
        by smtp.gmail.com with ESMTPSA id m7sm4142769pgn.32.2021.10.15.01.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 01:02:05 -0700 (PDT)
Date:   Fri, 15 Oct 2021 18:02:00 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 06/13] asm-generic: Use HAVE_FUNCTION_DESCRIPTORS to
 define associated stubs
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
        <4fda65cda906e56aa87806b658e0828c64792403.1634190022.git.christophe.leroy@csgroup.eu>
        <1634278340.5yp7xtm7um.astroid@bobo.none>
        <7523a005-ea69-7c4c-64ad-bc2537921975@csgroup.eu>
In-Reply-To: <7523a005-ea69-7c4c-64ad-bc2537921975@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1634284464.kd8scm0ckz.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Christophe Leroy's message of October 15, 2021 4:24 pm:
>=20
>=20
> Le 15/10/2021 =C3=A0 08:16, Nicholas Piggin a =C3=A9crit=C2=A0:
>> Excerpts from Christophe Leroy's message of October 14, 2021 3:49 pm:
>>> Replace HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR by
>>> HAVE_FUNCTION_DESCRIPTORS and use it instead of
>>> 'dereference_function_descriptor' macro to know
>>> whether an arch has function descriptors.
>>>
>>> To limit churn in one of the following patches, use
>>> an #ifdef/#else construct with empty first part
>>> instead of an #ifndef in asm-generic/sections.h
>>=20
>> Is it worth putting this into Kconfig if you're going to
>> change it? In any case
>=20
> That was what I wanted to do in the begining but how can I do that in=20
> Kconfig ?
>=20
> #ifdef __powerpc64__
> #if defined(_CALL_ELF) && _CALL_ELF =3D=3D 2
> #define PPC64_ELF_ABI_v2
> #else
> #define PPC64_ELF_ABI_v1
> #endif
> #endif /* __powerpc64__ */
>=20
> #ifdef PPC64_ELF_ABI_v1
> #define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1

We have ELFv2 ABI / function descriptors iff big-endian so you could=20
just select based on that.

I have a patch that makes the ABI version configurable which cleans
some of this up a bit, but that can be rebased on your series if we
ever merge it. Maybe just add BUILD_BUG_ONs in the above ifdef block
to ensure CONFIG_HAVE_FUNCTION_DESCRIPTORS was set the right way, so
I don't forget.

Thanks,
Nick
