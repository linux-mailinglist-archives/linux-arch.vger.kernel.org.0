Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB27D279BE0
	for <lists+linux-arch@lfdr.de>; Sat, 26 Sep 2020 20:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgIZSaW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Sep 2020 14:30:22 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:54531 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIZSaW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Sep 2020 14:30:22 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MwfrG-1kfQla49WM-00y9N4; Sat, 26 Sep 2020 20:30:21 +0200
Received: by mail-qk1-f170.google.com with SMTP id c2so6392128qkf.10;
        Sat, 26 Sep 2020 11:30:20 -0700 (PDT)
X-Gm-Message-State: AOAM532Qsl4VE9mUjz0EAjEdFAbTz+qSWXpK9rjmhKmA5kFJaQ66dGiK
        +2m6QXJB9IqPqR7XylfT3YoeAgSm7jUrw5FeD+8=
X-Google-Smtp-Source: ABdhPJwCDr8g+GQISXGwNaC9OvKKW7eMeA3fyHA5nqFJbGySKsf2kM84dVn3Zi7lVXofFxzjg00nZbrxbqxgBaA40NE=
X-Received: by 2002:a37:a495:: with SMTP id n143mr5509549qke.394.1601145019643;
 Sat, 26 Sep 2020 11:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200918124624.1469673-1-arnd@arndb.de> <20200918124624.1469673-6-arnd@arndb.de>
 <20200919053233.GH30063@infradead.org>
In-Reply-To: <20200919053233.GH30063@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 26 Sep 2020 20:30:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2nZ_Uzq0ivB7vnR620kHb-onYdqMnWnf6KQjZq8gEdpQ@mail.gmail.com>
Message-ID: <CAK8P3a2nZ_Uzq0ivB7vnR620kHb-onYdqMnWnf6KQjZq8gEdpQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] ARM: oabi-compat: rework epoll_wait/epoll_pwait emulation
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:itz1Z/+zneyK/vzKeHy3vawQiKcxzQYzshytX3qgS5jgK2MyA9Z
 UbiupdvXBQXXBQOuZub17rBpAyxUdoFzSbqpLWrpfA6re3lvEovD9SA3az+fW/UY/UEhws3
 VfONz4A2tSksvkBD7X3vqdA64VbihP1AvoT0I9Z3moGdzfTCVJR++FJCelUj5VDRS85sC97
 s2wi4KbAyPygIdkzmX2Og==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ton0hDNBsuk=:NlQ19Fis5wi/rczH3Yu2eq
 ogrIfu8ShtfkQJUDkaj9yIKfQYq79qBbKFkkbg0d/JbMpOkE8lEaLFtfwAOudWMjR6NwhpgOX
 1WzQNM6lGHBSXIrUzXTCBzKGXS/KtDoeim/h9bq2djcCY55WgPGmal4oNDpmCIuZiKWzpgeoC
 eR71WPuuLELBgDUpe40aOtOuws5tUn/KLqYXEGYVl2VXoRBXGKEsyriipDUNTZkwVGs7UrOhU
 HUgkEdrUTmhtDEKUxBIC43KsVjHkRJx9t91LoPc2yo0a8BOyKWRHVTBM32/1yYqVWUVFyYQru
 u2OZDCmF8K3O8ZyjeCQrHNFwJB/L9gxSQIyV5gyxmVQAF89sxT0DbFYgBaUyMnXD500u1k6Li
 Gxg4qE7Y1s1+j54wAcO+5JNNt3Q++MOeQ0s9kg8zFwC6gY1Lz4xJdnaIUPkibCVEdcQ1MdiN8
 eONwb4SdLa2h2r3xGj2z+zPkcvzZWtHp3tD3a+euhAZweV4Ab1583uQ8quhDMmFxE5B4YEOpV
 7jM6rNBQK9X+yc2oUrehqPjOAUTlisIH6S/RX1rG7minj6y2Av5fQwL3laBlCTlo185nzDAu7
 wHo1Wb9nIfAwpqkPldlq3ggz6YHX4j+X7DHpGPJF5e1S3fRP+Gx0zLqBIAJGNqWInppxf+2bS
 jng4kaSbrgy3uOH0+ecAmmuK3cTBAgBNgP9KlfC2O5WL9KmfyxIpy/Ii3DCPWu/SOOUxInkOm
 D+9UAInrAn3d2SmhPz12ydKfDLhiDe0IPl0fMqlvn7a5ww2r1XQ0plE+cuiMbwEpA1y/pISQu
 Gvpj28uLMy74HklBaEVVDLUBxsYDiKaU2m9y9gl/+S+WIT/F9Jms81GAliDjD24uHVJEGMQ
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 19, 2020 at 7:32 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> > index 855aa7cc9b8e..156880943c16 100644
> > --- a/arch/arm/include/asm/syscall.h
> > +++ b/arch/arm/include/asm/syscall.h
> > @@ -28,6 +28,17 @@ static inline int syscall_get_nr(struct task_struct *task,
> >       return task_thread_info(task)->syscall & ~__NR_OABI_SYSCALL_BASE;
> >  }
> >
> > +static inline bool __in_oabi_syscall(struct task_struct *task)
> > +{
> > +     return IS_ENABLED(CONFIG_OABI_COMPAT) &&
> > +             (task_thread_info(task)->syscall & __NR_OABI_SYSCALL_BASE);
> > +}
> > +
> > +static inline bool in_oabi_syscall(void)
> > +{
> > +     return __in_oabi_syscall(current);
> > +}
> > +
>
> Maybe split these infrastructure additions into a separate helper?

Sorry, I'm not following what you mean by this. Both of the above
are pretty minimal helpers already, in what way could they be split
further?

> So after you argued for this variant I still have minor nitpicks:
>
> I alway find positive ifdefs better where possible, e.g.
>
> #if defined(CONFIG_ARM) && defined(CONFIG_OABI_COMPAT)
> external declaration here
> #else
> the real thing
> #endif

Ok.

> but I still find the fact that the native case goes into the arch
> helper a little weird.

Would you prefer something like this:

static inline struct epoll_event __user *
epoll_put_uevent(__poll_t revents, __u64 data,
                 struct epoll_event __user *uevent)
{
#if defined(CONFIG_ARM) && defined(CONFIG_OABI_COMPAT)
        /* ARM OABI has an incompatible struct layout and needs a
special handler */
        extern struct epoll_event __user *
        epoll_oabi_put_uevent(__poll_t revents, __u64 data,
                              struct epoll_event __user *uevent);

        if (in_oabi_syscall())
                return epoll_oabi_put_uevent(revents, data, uevent);
#endif
        if (__put_user(revents, &uevent->events) ||
            __put_user(data, &uevent->data))
                return NULL;

        return uevent+1;
}

That would keep the native case in one place, but also mix in
more architecture specific stuff into the common source location,
which again seems worse to me.

     Arnd
