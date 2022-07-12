Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBC557196D
	for <lists+linux-arch@lfdr.de>; Tue, 12 Jul 2022 14:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiGLMHO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Jul 2022 08:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiGLMHM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jul 2022 08:07:12 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264F363B0
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2022 05:07:12 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id n74so13560227yba.3
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2022 05:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NcaZoHxkoPLNKyXoHKEwHY+W+ThXitk+W0hG8LqbLf0=;
        b=ZDVWr+p3NhVr1CUq8shddxuGCK2UkbwMmLU0MPPLLcgV1gyFhjFy/LuAMbhGdLBK9U
         gVa5CY2dbm8U1I1Cb0lasNhq0ds1T8i2glhK90L5AI66WbjXmmZ/yLGLqsdIwPuCGeUH
         /cZFTo86BWYirH/iv0tZwJuU3Z3hk0FJBVFgNv1L38JnsJHjDNYiixpofuqmhNFdEXnb
         n+KwomL2Zc8MaFo6/ELYjK8Xn6nP0ADAVFrtmgXNrky56/z97dv/4PXW2ywGCbjPxrBz
         p/5K+XZYvOKrWRPgJtSmEoTUWVjgylIyUBlEYXJu0kBJJLxLQvyJZs/ITliIQ/ue4SQR
         iwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NcaZoHxkoPLNKyXoHKEwHY+W+ThXitk+W0hG8LqbLf0=;
        b=Ao7+LBiMwtoh9qVfV+0L8M1x2cQXXN1aL+z+O4jw7t53dZv1GRnSK9tlgLxWlky200
         0gAxVAJP4DWMycm+EBv2jnYdc+EPsMCY9/njmCzToDvUC+2W2qj6E0AL1niRt/6z/vnG
         7oB36Jv7UrW+6aVX17F9P+Du+cJ3pBLcjmw2CgoNsc9vbUuMTWZ9xm6EHnoDO8giYt7x
         viKyx0gON3zcdAZvuGZaqC6i8rqZz/x2HSdhIyafd5fB/NoflxKI/u1nmwICd1VISGkf
         MdvBY3CK0dJC+xexl0FTMhfufzXkoIKh71TY6Y9Hzd9qKvD5EMqFzBq6A72XNyeUnSW8
         Az2g==
X-Gm-Message-State: AJIora/+ttEuIcA6oUrHVO5LDkw/eIOLinSCFpx8hBCcjPJ7vF1bzLzJ
        HEBYD5/X/COHnlGR6f9M1HVq/+/o06ntszTDDeMZGw==
X-Google-Smtp-Source: AGRyM1vgnu0W2fiEJKnjwlHfY7wgi70C1jHvVG/0VbfE1gkD/ENEshXQc1CpSzd8c7XRHei1mrUiEPVDQ0lSLshBiY8=
X-Received: by 2002:a5b:10a:0:b0:66d:d8e3:9da2 with SMTP id
 10-20020a5b010a000000b0066dd8e39da2mr22329810ybx.87.1657627631236; Tue, 12
 Jul 2022 05:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-14-glider@google.com>
In-Reply-To: <20220701142310.2188015-14-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Jul 2022 14:06:35 +0200
Message-ID: <CANpmjNN1KVteEi4HPTqa_V78iQ1e2iNZ=rguLSE6aqyca7w_zA@mail.gmail.com>
Subject: Re: [PATCH v4 13/45] MAINTAINERS: add entry for KMSAN
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 1 Jul 2022 at 16:23, 'Alexander Potapenko' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Add entry for KMSAN maintainers/reviewers.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> Link: https://linux-review.googlesource.com/id/Ic5836c2bceb6b63f71a60d3327d18af3aa3dab77
> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe5daf1415013..f56281df30284 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11106,6 +11106,18 @@ F:     kernel/kmod.c
>  F:     lib/test_kmod.c
>  F:     tools/testing/selftests/kmod/
>
> +KMSAN
> +M:     Alexander Potapenko <glider@google.com>
> +R:     Marco Elver <elver@google.com>
> +R:     Dmitry Vyukov <dvyukov@google.com>
> +L:     kasan-dev@googlegroups.com
> +S:     Maintained
> +F:     Documentation/dev-tools/kmsan.rst
> +F:     include/linux/kmsan*.h
> +F:     lib/Kconfig.kmsan
> +F:     mm/kmsan/
> +F:     scripts/Makefile.kmsan
> +

It's missing:

  arch/*/include/asm/kmsan.h
