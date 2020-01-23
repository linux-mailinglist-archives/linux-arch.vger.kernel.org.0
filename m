Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86C95147170
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 20:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgAWTIL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 14:08:11 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35137 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgAWTIL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 14:08:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id i23so1978879pfo.2
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 11:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LXXh4Z7Ys4UonyudB0qYzr3yB1ZLKukDbIA0KFF43hk=;
        b=AaYrW19Ss69F9E1/H3AHuUOsXUSL1pMRLiv4/8/2feYyQMaur+/l+RTK515Q6+w1HB
         OdbzJBYMq9JygXFkBEU9OsWn6j5Em5CQvkwytpc/3Bc9V3cDllMLMHITXX0wJ/UKO0OA
         +C5D3mq/goGsiHmMH8RbG9wbxEQRZHAWmhRJpwM6Ir64dS8twmemFTkIEuQV2aCh0UuJ
         bkuLnldRhXxrZ9HqFuALtL7uoZLX4ps+X2LMqS1whdbUZudjGwDYtKUHnvIXMTYdGSeQ
         0XgPDrZzs0Y13/BYmpTUJMen8HEv28n3DooMRIZRF0vS5w2haz3PXi1oPcXEkdRKJEEM
         vBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LXXh4Z7Ys4UonyudB0qYzr3yB1ZLKukDbIA0KFF43hk=;
        b=rEqunVMN8qHy0eHC/XhsyA65UIOIxL2aa1nDoj9Jh1+BKLHHA1X613f6dlTJ88WTXH
         5AiF8X2DpdPVlFYBus/ZHAwfGjGzYWdVft5RNo/ymBwXhiNcOOOSS2mgmOC1ZXTVC/ah
         5Q9ZKCRlMUId03l3HWcPUq8A+WwWNzzUZTh7oh/YpxOd5S3zLJeAmspKpCUdvpgkZTeK
         05bEW8NFRarAdKFcHU68rKyRhPvQUGrg7PhAGbExDk0p63Zk7EvMYCXtPynOo/4oJycf
         WGOzMn1OT0BQ4FdNOjgxjFJQlS1g8ETKbi4MBCUZCQY7fg4SCGh72A+n8mcx9htq1WGc
         cBfg==
X-Gm-Message-State: APjAAAVEBRhXBKZBhzUBkzbzKXySaHmaK4ukU7hxuZ9P0JTWeTv7/V+5
        jft+31RJPzv4HjrhJy4jkAamxppweC9HF+kI7qAmQg==
X-Google-Smtp-Source: APXvYqz8KLcolmk/IP6V5UclMlJHiLMP87nUmm4I4ijn01gQ/jYgQFAoiKDyYTcvXiv35zPHbqyKQyESA9/VD8VA5vM=
X-Received: by 2002:aa7:946a:: with SMTP id t10mr8713703pfq.165.1579806490507;
 Thu, 23 Jan 2020 11:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20200123153341.19947-1-will@kernel.org> <20200123153341.19947-3-will@kernel.org>
In-Reply-To: <20200123153341.19947-3-will@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 23 Jan 2020 11:07:59 -0800
Message-ID: <CAKwvOdm2snorniFunMF=0nDH8-RFwm7wtjYK_Tcwkd+JZinYPg@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] netfilter: Avoid assigning 'const' pointer to
 non-const pointer
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 23, 2020 at 7:33 AM Will Deacon <will@kernel.org> wrote:
>
> nf_remove_net_hook() uses WRITE_ONCE() to assign a 'const pointer to a
> 'non-const' pointer. Cleanups to the implementation of WRITE_ONCE() mean
> that this will give rise to a compiler warning, just like a plain old
> assignment would do:
>
>   | In file included from ./include/linux/export.h:43,
>   |                  from ./include/linux/linkage.h:7,
>   |                  from ./include/linux/kernel.h:8,
>   |                  from net/netfilter/core.c:9:
>   | net/netfilter/core.c: In function =E2=80=98nf_remove_net_hook=E2=80=
=99:
>   | ./include/linux/compiler.h:216:30: warning: assignment discards =E2=
=80=98const=E2=80=99 qualifier from pointer target type [-Wdiscarded-qualif=
iers]
>   |   *(volatile typeof(x) *)&(x) =3D (val);  \
>   |                               ^
>   | net/netfilter/core.c:379:3: note: in expansion of macro =E2=80=98WRIT=
E_ONCE=E2=80=99
>   |    WRITE_ONCE(orig_ops[i], &dummy_ops);
>   |    ^~~~~~~~~~
>
> Follow the pattern used elsewhere in this file and add a cast to 'void *'
> to squash the warning.
>
> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
> Cc: Florian Westphal <fw@strlen.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  net/netfilter/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/netfilter/core.c b/net/netfilter/core.c
> index 78f046ec506f..3ac7c8c1548d 100644
> --- a/net/netfilter/core.c
> +++ b/net/netfilter/core.c
> @@ -376,7 +376,7 @@ static bool nf_remove_net_hook(struct nf_hook_entries=
 *old,
>                 if (orig_ops[i] !=3D unreg)
>                         continue;
>                 WRITE_ONCE(old->hooks[i].hook, accept_all);
> -               WRITE_ONCE(orig_ops[i], &dummy_ops);
> +               WRITE_ONCE(orig_ops[i], (void *)&dummy_ops);

Good thing it's the variable being modified was not declared const; I
get spooked when I see -Wdiscarded-qualifiers because of Section
6.7.3.6 of the ISO C11 draft spec:

```
If an attempt is made to modify an object defined with a
const-qualified type through use
of an lvalue with non-const-qualified type, the behavior is undefined.
If an attempt is
made to refer to an object defined with a volatile-qualified type
through use of an lvalue
with non-volatile-qualified type, the behavior is undefined.133)

133) This applies to those objects that behave as if they were defined
with qualified types, even if they are
never actually defined as objects in the program (such as an object at
a memory-mapped input/output
address).
```

Which is about the modification of a const-declared variable (explicit
UB which Clang actively exploits), and doesn't apply in this case.  I
agree that this is the best way to fix this due to the use of typeof()
and it's semantics of dropping qualifiers; declaring `dummy_ops` as
non-const would be another, but that is worse IMO.  Thanks for the
patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>                 return true;
>         }
>
> --
> 2.25.0.341.g760bfbb309-goog
>


--=20
Thanks,
~Nick Desaulniers
