Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2953D9B5D
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 03:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhG2B6S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 21:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhG2B6R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2021 21:58:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BBBC061757
        for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021 18:58:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id x11so6833866ejj.8
        for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021 18:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YoFaztgpbmZsS3GQD7IoQdYipQyUJlb6TRPn3VaCAkQ=;
        b=tf51QCg3DkWVk3o2f3zC0EjJSPV0XeuT6a2JkOmJYSHFPz07qTE+syGCcgkdn6qo2n
         TMrp1CnIyw2Y7rZqxf1AlxcJaRNWEaKI7l3BA1SUcOtvcjQDflhQACspH+JNYikH/EFA
         Cef8rrYJKBgjTD3oazq/kZRd4OJInwrdH++Wk/pODiV6yHCDs7eFwz7cPBHB31KboO/k
         E/akdgVxBNhXvUNhZBDajzY217D31GmBwjqH4zHxTh6af6yMF2Ft81Pl723oSpOD1hQ0
         8+QSUgLajA6D/+oFK6AD1GiNz6aZ6TSSdvNEhae47sGcXuW2NXTUBzwL6rVKQa5slc9R
         wDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YoFaztgpbmZsS3GQD7IoQdYipQyUJlb6TRPn3VaCAkQ=;
        b=ccpi7Nuspl9XBdM6/ikr745j+K72TsTrBnJcyKMhQK/3//Opyc3MiCsLk9f6UTVFhp
         ZO49bBVDwf3XN+v5O66Za/moBx5AYKIcjOcMBNKsQYv7NlyImFJ3VFkBPQhX7eN+nGIS
         jF8F55xvWd1fROcdemRy4GzkfXwsSajsDCb5a9GghsHUbFDFZMPBnmFqKuut520+I/Yc
         7kSlKOwLwInjCOHWA6n3HELTI550bjVgWWU8h9Tqa67D+rV0tqxPX9HIAFuOHWxd+vXp
         9naRbD3HnM8wy93625r2ThY/TsnemYZx0acoZTV32VcSiJLzeVXN0WJjGPeCgf/A2+k1
         9xtg==
X-Gm-Message-State: AOAM532pvdWd3w/BmdAdlcY5MQb0/fIToxUT1zFHso2+SiceJ+R4N3vK
        0G//SfgdBLbjUrIEmQMYnaB4ituFTOHuSSqLKWsFRg==
X-Google-Smtp-Source: ABdhPJwUsVqLVuag/TjecyGq8/VZGoy5Ce28+4nKiTNPxtrO7+ML2QfL+nvUBfcxYip+hX8NkydxhZLUS6/gt2of2og=
X-Received: by 2002:a17:906:c0d1:: with SMTP id bn17mr2197333ejb.511.1627523893118;
 Wed, 28 Jul 2021 18:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210728114822.1243-1-wangrui@loongson.cn> <YQFUe+QsHfBIgQev@hirez.programming.kicks-ass.net>
 <YQFYxr/2Zr7UclaN@hirez.programming.kicks-ass.net> <YQFZxuwQGiuWHxJL@hirez.programming.kicks-ass.net>
In-Reply-To: <YQFZxuwQGiuWHxJL@hirez.programming.kicks-ass.net>
From:   hev <r@hev.cc>
Date:   Thu, 29 Jul 2021 09:58:02 +0800
Message-ID: <CAHirt9hBeLq8jejZZDLQkbc1rb6hDRD9w0QpFGJastrOsYe5vg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/5] locking/atomic: Implement atomic_fetch_and_or
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rui Wang <wangrui@loongson.cn>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Peter,

On Wed, Jul 28, 2021 at 9:21 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jul 28, 2021 at 03:16:54PM +0200, Peter Zijlstra wrote:
> > On Wed, Jul 28, 2021 at 02:58:35PM +0200, Peter Zijlstra wrote:
> > > The below isn't quite right, because it'll use try_cmpxchg() for
> > > atomic_andnot_or(), which by being a void atomic should be _relaxed. I'm
> > > not entirely sure how to make that happen in a hurry.
> > >
> > > ---
> >
> > This seems to do the trick.
> >
>
> Mark suggested this, which is probably nicer still.
Wow, Amazing! so the architecture dependent can be implemented one by one.

Regards
Rui

>
> ---
> diff --git a/scripts/atomic/atomics.tbl b/scripts/atomic/atomics.tbl
> index fbee2f6190d9..3aaa0caa6b2d 100755
> --- a/scripts/atomic/atomics.tbl
> +++ b/scripts/atomic/atomics.tbl
> @@ -39,3 +39,4 @@ inc_not_zero          b       v
>  inc_unless_negative    b       v
>  dec_unless_positive    b       v
>  dec_if_positive                i       v
> +andnot_or              vF      v       i:m     i:o
> diff --git a/scripts/atomic/fallbacks/andnot_or b/scripts/atomic/fallbacks/andnot_or
> new file mode 100644
> index 000000000000..0fb3a728c0ff
> --- /dev/null
> +++ b/scripts/atomic/fallbacks/andnot_or
> @@ -0,0 +1,24 @@
> +local try_order=${order}
> +
> +#
> +# non-value returning atomics are implicity relaxed
> +#
> +if [ -z "${retstmt}" ]; then
> +       try_order="_relaxed"
> +fi
> +
> +cat <<EOF
> +static __always_inline ${ret}
> +arch_${atomic}_${pfx}andnot_or${sfx}${order}(${atomic}_t *v, ${int} m, ${int} o)
> +{
> +       ${retstmt}({
> +               ${int} N, O = atomic_read(v);
> +               do {
> +                       N = O;
> +                       N &= ~m;
> +                       N |= o;
> +               } while (!arch_${atomic}_try_cmpxchg${try_order}(v, &O, N));
> +               O;
> +       });
> +}
> +EOF
> diff --git a/scripts/atomic/fallbacks/fetch_andnot_or b/scripts/atomic/fallbacks/fetch_andnot_or
> deleted file mode 100644
> index e69de29bb2d1..000000000000
