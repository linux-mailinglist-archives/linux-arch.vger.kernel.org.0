Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706F74C1570
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 15:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiBWOdG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 09:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiBWOdG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 09:33:06 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532E666AF3;
        Wed, 23 Feb 2022 06:32:38 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id w3so44527795edu.8;
        Wed, 23 Feb 2022 06:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5yDwvnVvF3Ri8hbsgcn8ZzyDXWcvBThDKwOkxiO5izg=;
        b=Bd0wbX1sJXYNwqD8ZBR8S8GKG+Porv7ZpszLDmq8iCZA/y5nNzAJ1ZQ9Gvybu7b/OX
         XkNfVjmc3DxZx5Xl2+W/OIgVlMxL8i1XSovUlEsBLKPc+MHOXQdwqA2AjHuZS2hdw1wz
         VSx9m/K3lru41coqVY61rXlQv2H+GBnNaHOg8nWTOKrZcrrI5fB6A+AYHk0Q/szUfWDU
         s3oZj8H0/XWgNF1msPg7Zp42Fca1KkvUR3M6eoIxui+s2gtO5wVS9zLJu+7LJfA+FdbF
         LHKHRw7ooJRWN/Bef6N0NaIgZODDG6FLvX3ODHQmz0uQLUE0xqe6d73XCip8Bw4u+ANm
         /93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5yDwvnVvF3Ri8hbsgcn8ZzyDXWcvBThDKwOkxiO5izg=;
        b=SSDnyaJhKVQUHZpMQEnEeDy0kF7OLMeSQmEQaWbzPLOfUhFkvr2ELLgk9T4EkhtvIu
         Ltyx9ltulktdxMPEWWYBpV20be8+n5Vs8G0ts2O7P5++03y9Rj2npsr1e0xjzCa0wp+K
         9O8RpV4KOCMNo76lCxqEHwA8ujGhQMUrlTr4VbqSyGvR23x2H72b6MUP7QXid69IwmY2
         g5c3XY5quZfphvKrEKm8Ii/Fu8CG96pa7SMFmWubSAyoPA1tos6UL24rH35HSqbwtgWN
         m3Vj/jkefHqEa2gV8NOAEnDRBt0RpmrsD1HSw7bg7JANoRQw5/Q70KorTF3g1wRtX4bR
         CH0Q==
X-Gm-Message-State: AOAM530ybcvbHkkxsrcAosyz1CLEzUR051z+lXW3WNcqjqoavdIs+Lyw
        M5dykHZ/D4TKyd+eqsMlK3c=
X-Google-Smtp-Source: ABdhPJx/J6zOmuSf1yT4tLIo4Ajv+BCdAEd5UeYqt4gszujEqXuWff7qUTFTRkC4hc/d8qlPjRwUXw==
X-Received: by 2002:aa7:d2d5:0:b0:410:8765:d2de with SMTP id k21-20020aa7d2d5000000b004108765d2demr12797244edr.148.1645626756630;
        Wed, 23 Feb 2022 06:32:36 -0800 (PST)
Received: from smtpclient.apple (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.gmail.com with ESMTPSA id c22sm7661637ejp.146.2022.02.23.06.32.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Feb 2022 06:32:36 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [RFC PATCH 01/13] list: introduce speculative safe
 list_for_each_entry()
From:   Jakob <jakobkoschel@gmail.com>
In-Reply-To: <CAG48ez0m6V12dPVwZMQ9gi0ig7ELf_+KbLArE02SD5cYrZvH-w@mail.gmail.com>
Date:   Wed, 23 Feb 2022 15:32:34 +0100
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B50C7C66-0D24-48E7-9F04-F5BAD277DF7A@gmail.com>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-2-jakobkoschel@gmail.com>
 <CAG48ez0m6V12dPVwZMQ9gi0ig7ELf_+KbLArE02SD5cYrZvH-w@mail.gmail.com>
To:     Jann Horn <jannh@google.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On 18. Feb 2022, at 17:29, Jann Horn <jannh@google.com> wrote:
>=20
> On Thu, Feb 17, 2022 at 7:48 PM Jakob Koschel <jakobkoschel@gmail.com> =
wrote:
>> list_for_each_entry() selects either the correct value (pos) or a =
safe
>> value for the additional mispredicted iteration (NULL) for the list
>> iterator.
>> list_for_each_entry() calls select_nospec(), which performs
>> a branch-less select.
>>=20
>> On x86, this select is performed via a cmov. Otherwise, it's =
performed
>> via various shift/mask/etc. operations.
>>=20
>> Kasper Acknowledgements: Jakob Koschel, Brian Johannesmeyer, Kaveh
>> Razavi, Herbert Bos, Cristiano Giuffrida from the VUSec group at VU
>> Amsterdam.
>>=20
>> Co-developed-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
>> Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
>> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
>=20
> Yeah, I think this is the best way to do this without deeply intrusive
> changes to how lists are represented in memory.
>=20
> Some notes on the specific implementation:
>=20
>> arch/x86/include/asm/barrier.h | 12 ++++++++++++
>> include/linux/list.h           |  3 ++-
>> include/linux/nospec.h         | 16 ++++++++++++++++
>> 3 files changed, 30 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/x86/include/asm/barrier.h =
b/arch/x86/include/asm/barrier.h
>> index 35389b2af88e..722797ad74e2 100644
>> --- a/arch/x86/include/asm/barrier.h
>> +++ b/arch/x86/include/asm/barrier.h
>> @@ -48,6 +48,18 @@ static inline unsigned long =
array_index_mask_nospec(unsigned long index,
>> /* Override the default implementation from linux/nospec.h. */
>> #define array_index_mask_nospec array_index_mask_nospec
>>=20
>> +/* Override the default implementation from linux/nospec.h. */
>> +#define select_nospec(cond, exptrue, expfalse)                       =
  \
>> +({                                                                   =
  \
>> +       typeof(exptrue) _out =3D (exptrue);                           =
    \
>> +                                                                     =
  \
>> +       asm volatile("test %1, %1\n\t"                                =
  \
>=20
> This shouldn't need "volatile", because it is only necessary if _out
> is actually used. Using "volatile" here could prevent optimizing out
> useless code. OPTIMIZER_HIDE_VAR() also doesn't use "volatile".
>=20
>> +           "cmove %2, %0"                                            =
  \
>> +           : "+r" (_out)                                             =
  \
>> +           : "r" (cond), "r" (expfalse));                            =
  \
>> +       _out;                                                         =
  \
>> +})
>=20
> I guess the idea is probably to also add code like this for other
> important architectures, in particular arm64?

yes indeed, with a fallback of using the shifting/masking mechanism for
other archs.

>=20
>=20
> It might also be a good idea to rename the arch-overridable macro to
> something like "arch_select_nospec" and then have a wrapper macro in
> include/linux/nospec.h that takes care of type safety issues.
>=20
> The current definition of the macro doesn't warn if you pass in
> incompatible pointer types, like this:
>=20
> int *bogus_pointer_mix(int cond, int *a, long *b) {
>  return select_nospec(cond, a, b);
> }
>=20
> and if you pass in integers of different sizes, it may silently
> truncate to the size of the smaller one - this C code:
>=20
> long wrong_int_conversion(int cond, int a, long b) {
>  return select_nospec(cond, a, b);
> }
>=20
> generates this assembly:
>=20
> wrong_int_conversion:
>  test %edi, %edi
>  cmove %rdx, %esi
>  movslq %esi, %rax
>  ret
>=20
> It might be a good idea to add something like a
> static_assert(__same_type(...), ...) to protect against that.

These are good points, thank you for your input. Will be good to =
incorporate.
>=20
>> /* Prevent speculative execution past this barrier. */
>> #define barrier_nospec() alternative("", "lfence", =
X86_FEATURE_LFENCE_RDTSC)
>>=20
>> diff --git a/include/linux/list.h b/include/linux/list.h
>> index dd6c2041d09c..1a1b39fdd122 100644
>> --- a/include/linux/list.h
>> +++ b/include/linux/list.h
>> @@ -636,7 +636,8 @@ static inline void list_splice_tail_init(struct =
list_head *list,
>>  */
>> #define list_for_each_entry(pos, head, member)                        =
 \
>>        for (pos =3D list_first_entry(head, typeof(*pos), member);     =
   \
>> -            !list_entry_is_head(pos, head, member);                  =
  \
>> +           ({ bool _cond =3D !list_entry_is_head(pos, head, member); =
    \
>> +            pos =3D select_nospec(_cond, pos, NULL); _cond; }); \
>>             pos =3D list_next_entry(pos, member))
>=20
> I wonder if it'd look nicer to write it roughly like this:
>=20
> #define NOSPEC_TYPE_CHECK(_guarded_var, _cond)                  \
> ({                                                              \
>  bool __cond =3D (_cond);                                        \
>  typeof(_guarded_var) *__guarded_var =3D &(_guarded_var);        \
>  *__guarded_var =3D select_nospec(__cond, *__guarded_var, NULL); \
>  __cond;                                                       \
> })
>=20
> #define list_for_each_entry(pos, head, member)                         =
       \
>        for (pos =3D list_first_entry(head, typeof(*pos), member);      =
        \
>             NOSPEC_TYPE_CHECK(head, !list_entry_is_head(pos, head, =
member)); \
>             pos =3D list_next_entry(pos, member))
>=20
> I think having a NOSPEC_TYPE_CHECK() like this makes it semantically
> clearer, and easier to add in other places? But I don't know if the
> others agree...

That sounds like a good idea. I wonder if the pointer and dereference in=20=

NOSPEC_TYPE_CHECK() simply get optimized away. Or why you can't simply
use _guarded_var directly instead of a pointer to it.

>=20
>> /**
>> diff --git a/include/linux/nospec.h b/include/linux/nospec.h
>> index c1e79f72cd89..ca8ed81e4f9e 100644
>> --- a/include/linux/nospec.h
>> +++ b/include/linux/nospec.h
>> @@ -67,4 +67,20 @@ int arch_prctl_spec_ctrl_set(struct task_struct =
*task, unsigned long which,
>> /* Speculation control for seccomp enforced mitigation */
>> void arch_seccomp_spec_mitigate(struct task_struct *task);
>>=20
>> +/**
>> + * select_nospec - select a value without using a branch; equivalent =
to:
>> + * cond ? exptrue : expfalse;
>> + */
>> +#ifndef select_nospec
>> +#define select_nospec(cond, exptrue, expfalse)                       =
  \
>> +({                                                                   =
  \
>> +       unsigned long _t =3D (unsigned long) (exptrue);               =
    \
>> +       unsigned long _f =3D (unsigned long) (expfalse);              =
    \
>> +       unsigned long _c =3D (unsigned long) (cond);                  =
    \
>> +       OPTIMIZER_HIDE_VAR(_c);                                       =
  \
>> +       unsigned long _m =3D -((_c | -_c) >> (BITS_PER_LONG - 1));    =
    \
>> +       (typeof(exptrue)) ((_t & _m) | (_f & ~_m));                   =
  \
>> +})
>> +#endif
>=20
> (As a sidenote, it might be easier to implement a conditional zeroing
> primitive than a generic conditional select primitive if that's all
> you need, something like:
>=20
> #define cond_nullptr_nospec(_cond, _exp)          \
> ({                                             \
>  unsigned long __exp =3D (unsigned long)(_exp); \
>  unsigned long _mask =3D 0UL - !(_cond);       \
>  OPTIMIZER_HIDE_VAR(_mask);                   \
>  (typeof(_exp)) (_mask & __exp);              \
> })
>=20
> )

Ah yes, if NULL is actually the value to choose, this might be good =
enough.

