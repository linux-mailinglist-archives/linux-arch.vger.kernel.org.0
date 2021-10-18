Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EA9431091
	for <lists+linux-arch@lfdr.de>; Mon, 18 Oct 2021 08:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhJRGcQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Oct 2021 02:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhJRGcP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Oct 2021 02:32:15 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE13CC06161C;
        Sun, 17 Oct 2021 23:30:04 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r2so15034523pgl.10;
        Sun, 17 Oct 2021 23:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=SrZhhuie2LYb+DH8DnKTrW/zbTOuYNfpSWs+Jg+B7ZI=;
        b=EaHY4+nxzBbXnw4re2cGF5gs8wOdjWhvwRQb3eDdLNljCkNp8D3Cdglit6b/DEdvI2
         ey56INCUK8p9wnePBtmhufxokbGfkq/bNQtz2eGE9C1+N1+IZcLiivrjaHi+fbFyw9Sm
         CIG7/CN1JQ+NPRu8XrkCHXO75w/J8IzbZLZsXNgIgGrssc22eKmoEH650zN1aNt6fb/E
         RQyug5mhR8JxjCa8hxG/oKYeTCXUcl0CnsOg/Ox97LP7sL0xsADVjLigIWesCf7KolDZ
         X9a2zF1I9AHYK6mcfZmGIOyZknnbra8wW42jtGvX7ZmhL6HnsRn8jCA4kg5Bq6CKLMz9
         Bq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=SrZhhuie2LYb+DH8DnKTrW/zbTOuYNfpSWs+Jg+B7ZI=;
        b=DjWfjN1MktEs7CpTvZwfgwcn28qR4yI6n+S1VdLBgBnugHl/PtozCE/aNtdzb+oxVx
         Lyv4Z7yjIlZtsrbawEK/RI4a+OcYXvKm2Wt1Sa7zcplikNb6VIRam8w4J0aOytBxefP7
         7SR51Vwh4BY77HkSn8ZU610BjROl3kZ3FLXngnW7XfuhJykza9WHPdqMZnjwxsebTtib
         DbNt6aQZM1aHfY4XYRrFnNnh6/CoFysXXHi7tIoJQhZtLvhO/n6w9IO7w30cCUb3Zo/p
         rqYx/WQsVFRqS7KLjInSkJXfHz9euAvIZcQSoJzZTqUk965tCZhXLvNMTnGdlD3NAcNl
         c2lw==
X-Gm-Message-State: AOAM530pRLBQ1aDHXZlNR4S1BDRD+Png5qPV+bvwIcxMMd63BfPo9uMQ
        ZThxClyxs5GDdlOmYDQaFd0=
X-Google-Smtp-Source: ABdhPJzH86hY+t32jbrJWE1dxVltQNRhTT8NQFAijIbO8sR0zCmyZjDW9Fs93D5vJD/a+7+qImFigg==
X-Received: by 2002:aa7:86d9:0:b0:44d:a354:b803 with SMTP id h25-20020aa786d9000000b0044da354b803mr15773350pfo.21.1634538604529;
        Sun, 17 Oct 2021 23:30:04 -0700 (PDT)
Received: from localhost ([1.128.244.1])
        by smtp.gmail.com with ESMTPSA id a12sm18027761pjq.16.2021.10.17.23.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 23:30:04 -0700 (PDT)
Date:   Mon, 18 Oct 2021 16:29:57 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 07/12] asm-generic: Define 'func_desc_t' to commonly
 describe function descriptors
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
        <a33107c5b82580862510cc20af0d61e33a2b841d.1634457599.git.christophe.leroy@csgroup.eu>
In-Reply-To: <a33107c5b82580862510cc20af0d61e33a2b841d.1634457599.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1634538449.eah9b31bbz.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Christophe Leroy's message of October 17, 2021 10:38 pm:
> We have three architectures using function descriptors, each with its
> own type and name.
>=20
> Add a common typedef that can be used in generic code.
>=20
> Also add a stub typedef for architecture without function descriptors,
> to avoid a forest of #ifdefs.
>=20
> It replaces the similar 'func_desc_t' previously defined in
> arch/powerpc/kernel/module_64.c
>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---

[...]

> diff --git a/include/asm-generic/sections.h b/include/asm-generic/section=
s.h
> index a918388d9bf6..33b51efe3a24 100644
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -63,6 +63,9 @@ extern __visible const void __nosave_begin, __nosave_en=
d;
>  #else
>  #define dereference_function_descriptor(p) ((void *)(p))
>  #define dereference_kernel_function_descriptor(p) ((void *)(p))
> +typedef struct {
> +	unsigned long addr;
> +} func_desc_t;
>  #endif
> =20

I think that deserves a comment. If it's just to allow ifdef to be=20
avoided, I guess that's okay with a comment. Would be nice if you could=20
cause it to generate a link time error if it was ever used like
undefined functions, but I guess you can't. It's not a necessity though.

Thanks,
Nick
