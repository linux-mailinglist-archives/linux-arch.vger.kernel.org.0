Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA6F42EFF9
	for <lists+linux-arch@lfdr.de>; Fri, 15 Oct 2021 13:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238550AbhJOLy5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Oct 2021 07:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbhJOLy5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Oct 2021 07:54:57 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2CDC061570;
        Fri, 15 Oct 2021 04:52:50 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so9176087pjw.0;
        Fri, 15 Oct 2021 04:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=JxOm4PejsflLixA5I77T/u/EeNwxcWFLBvedgG7X3g0=;
        b=RnbWBgff8R8VzvKZ7Ek8H2JjAGpnn0fYqUT20UYWFA1Evqdl9wbX2+SrmYs0VyUeof
         My+8NauijiAKQ1ELcOViTyu+YwKGpuVjGnDI/Y+s8zKBoD4CkdLl+3utOKqPrAi2ZvJa
         xco3Sdw7p4I0EprZLeBSKrXfq9dwLjRsRYR9egfDkYeulFpk8Eox9oQj1DskkBEoPdde
         DzFRCrsOV/c4XR1D5jF506cVi3Ja28oWzgZ8FGVSYlbrurACLwhG2aYSmIHMafvGUv1w
         KuiavOiwdgS7s9dl0tePyrXU6nuWqLUPQQGiQ0kpUPmXAeNoCjcP3qLfZBdChw5Qws0Q
         81Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=JxOm4PejsflLixA5I77T/u/EeNwxcWFLBvedgG7X3g0=;
        b=yOfqNFYwAF4u+ZB0NfUQpu4M8jg8ammd9u4R6UD9Vsu/wgAF8GDURZKkJMFQTgzsK5
         FbNQZWks5QX7gsI65Jv3oSVZkljwvlFvFM24vyq7mFIwIZOxEbznsd6TrRbAc0OEBKrw
         g/aeTx/gjCXkDE7TjMfGObvtjevZMVogjjJJJLJr0yMnSo4GqaUa14idKEeomff8JHOX
         c4+czh6auR10tq1nsU9LkoHDOmmN/dNAo5m5PHFEIsFtjYlyfaeZz2o4zdx9v8qKS5gi
         HJh2xNrVvRzXw5Ajz8FSJRfimGeHWt+i+y2bnfCweHzVbZ+OEiMct+wFZIVJ9eGCJNpj
         0cmA==
X-Gm-Message-State: AOAM530gvlp34n7dXBz/UxZCazYEzwMo321HNwXnA5zmuHPYCo0QboN+
        dg+8E6fYq/fSPJIUwkXUuC0=
X-Google-Smtp-Source: ABdhPJziSb3RPlkgHBIcLy/GsNYHt7p9eqtN/IAdFB/eXr3Vs5LS6nSBulwrip6mVfmFdqJELfYQfQ==
X-Received: by 2002:a17:902:a40a:b0:13e:6de3:76d2 with SMTP id p10-20020a170902a40a00b0013e6de376d2mr10599880plq.71.1634298770474;
        Fri, 15 Oct 2021 04:52:50 -0700 (PDT)
Received: from localhost (14-203-144-177.static.tpgi.com.au. [14.203.144.177])
        by smtp.gmail.com with ESMTPSA id d138sm4955442pfd.74.2021.10.15.04.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 04:52:50 -0700 (PDT)
Date:   Fri, 15 Oct 2021 21:52:44 +1000
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
        <1634284464.kd8scm0ckz.astroid@bobo.none>
In-Reply-To: <1634284464.kd8scm0ckz.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1634298613.bp91trt1cz.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Nicholas Piggin's message of October 15, 2021 6:02 pm:
> Excerpts from Christophe Leroy's message of October 15, 2021 4:24 pm:
>>=20
>>=20
>> Le 15/10/2021 =C3=A0 08:16, Nicholas Piggin a =C3=A9crit=C2=A0:
>>> Excerpts from Christophe Leroy's message of October 14, 2021 3:49 pm:
>>>> Replace HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR by
>>>> HAVE_FUNCTION_DESCRIPTORS and use it instead of
>>>> 'dereference_function_descriptor' macro to know
>>>> whether an arch has function descriptors.
>>>>
>>>> To limit churn in one of the following patches, use
>>>> an #ifdef/#else construct with empty first part
>>>> instead of an #ifndef in asm-generic/sections.h
>>>=20
>>> Is it worth putting this into Kconfig if you're going to
>>> change it? In any case
>>=20
>> That was what I wanted to do in the begining but how can I do that in=20
>> Kconfig ?
>>=20
>> #ifdef __powerpc64__
>> #if defined(_CALL_ELF) && _CALL_ELF =3D=3D 2
>> #define PPC64_ELF_ABI_v2
>> #else
>> #define PPC64_ELF_ABI_v1
>> #endif
>> #endif /* __powerpc64__ */
>>=20
>> #ifdef PPC64_ELF_ABI_v1
>> #define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
>=20
> We have ELFv2 ABI / function descriptors iff big-endian so you could=20
> just select based on that.

Of course that should read ELFv1. To be clearer: BE is ELFv1 ABI and
LE is ELFv2 ABI.

Thanks,
Nick
