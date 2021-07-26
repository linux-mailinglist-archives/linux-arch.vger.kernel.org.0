Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EF83D62F7
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 18:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbhGZPmt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 11:42:49 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:57273 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237511AbhGZPmA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jul 2021 11:42:00 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N9MlI-1l2jt831jY-015EtT; Mon, 26 Jul 2021 18:22:18 +0200
Received: by mail-wr1-f50.google.com with SMTP id p5so6681919wro.7;
        Mon, 26 Jul 2021 09:22:18 -0700 (PDT)
X-Gm-Message-State: AOAM533VQV99cc+dxxLIjJxZGXNngbz3hCJjNiuXNSOrkmHkz5bTC4gJ
        4DCqCyJ5F6ho0TLxzQQUzh3DNN+3SGrtNWwSFK0=
X-Google-Smtp-Source: ABdhPJye/ed6/FsM5yNUWTWtPJo/Xm2xrm3gGSltDPBIF+Kg8Q/ZjELHmN1WQSWO+r1dLUQThBaEPvfiDXicJHijpKc=
X-Received: by 2002:adf:e107:: with SMTP id t7mr20157064wrz.165.1627316538300;
 Mon, 26 Jul 2021 09:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210724162429.394792-1-sven@narfation.org> <YPxHYW/HPI/LLMXx@zeniv-ca.linux.org.uk>
 <CAK8P3a2MVQMFFBUzudy+yrcp4Md8mm=NcvX7YzGVz4C8W61sgQ@mail.gmail.com> <3234493.RMHOAZ7QyG@ripper>
In-Reply-To: <3234493.RMHOAZ7QyG@ripper>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 26 Jul 2021 18:22:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a35PNhsMQNU11RCaKm-o3-oG8pOXG836aoubxQMpTyVNQ@mail.gmail.com>
Message-ID: <CAK8P3a35PNhsMQNU11RCaKm-o3-oG8pOXG836aoubxQMpTyVNQ@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: avoid sparse {get,put}_unaligned warning
To:     Sven Eckelmann <sven@narfation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        b.a.t.m.a.n@lists.open-mesh.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:VvZ46d4HcbQ9Yh9Wr5KJMJAA4QGmLQUzmw70t+kcPBYI7iDts0y
 JcuvTpoimJpWvw1X2jgnk/cJlJnK/oj8KBFj/fEohjsDbmt7BBFPFuK9K0D+3Hs47W4f9Ut
 1goQ3FsZhIEbYaicnKjucgcLS/Z5yvmluJP6Yz44n+1pylkq151u36+7Wojy4ekcS+6ein2
 N4hg6Maf5n3XQbkC6pqQg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UKpcsJUq4AU=:euwYip+Am0oMSvCjo6DqXU
 Igr9R25Zgk7EqGMu/+p7xf/Q29Ks7ZAthvrJhLt9uQ3Rt76Gt6IPRE/3YbptYeP5+vkaAYkVH
 nhAD6fKFUQ/vuxZZhXw2OHC3y2aQaEgTigXUzoPm5whAtNe57pMwT1BYF6DsPi/+82osTklkM
 oaLIg7fG2U70nv7c3cSWYi2pAKlkEWmGQp0x+/hv9tIkt7hqr0XL8lTgrGbrMJfkXPIhlk6sy
 C3OSMxx2QwohU7hEnTb+mfAXGoXDZ/cjrKplAg5JBf0m/UzAoaKg1QdwDITnNjcPnI9bhS4HY
 KP5i+uE3E0jL0mpFKZD/tT1FvfhMdb3RQ13mbqwU6NRtQ6R5ohotwnN8UWx/o/Zv3yNCU4QV4
 s7CnjkO3b/P3SOCXczn1hV2/fgiXneN3JO1CRgroA+xKkQhQ31HsOcH1viqeS4y6j1jqdLdHy
 1qJ0Z4Me+a4M97/t+wtRnGkCvMneeuIwABAz9l+/zPbLlyK3GpUdZMvGlL+Y1IuHWds9NpPnP
 oFDfJNdKxL40ew1O0AIV5/RkIgGY4ayjLoCfzL4Hn/Z/fGfhL7nKSgc2zFcwuOvwjBKsBsnk0
 A08lCrlKWGemysbqWTPBSOt+CLFJgUIQXrlqAgHTrrRWTplTPoHKUsfo2xV5HfTMkvYKKTDEO
 Vm+boK7/E5jODDubIqGst1IpgUEiF3NZSjTGEciYo3kE8WV2WFYFzMvmmPeIIrKwvD9PlWAVp
 utyFjS5YSBGYWjYNppy3bdRfhDpNekJu7aF1MKZPyBtTx/Y2d76cnN5DsmAdI8G46cKU2D8f7
 mWiFg3o92haUB+8oaiYYynAk6jqH834cjO3sldD0PmEd3jjM/OV/txfDCv0batLOejDIFZz
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 26, 2021 at 5:04 PM Sven Eckelmann <sven@narfation.org> wrote:
>
> On Monday, 26 July 2021 14:57:31 CEST Arnd Bergmann wrote:
> > >
> > > > The special attribute force must be used in such statements when the cast
> > > > is known to be safe to avoid these warnings.
> >
> > I can see why this would warn, but I'm having trouble reproducing the
> > warning on linux-next.
>
> I have sparse 0.6.3 on an Debian bullseye amd64 system. Sources are from
> linux-next next-20210723
>
>     make allnoconfig
>     cat >> .config << "EOF"
>     CONFIG_NET=y
>     CONFIG_INET=y
>     CONFIG_BATMAN_ADV=y
>     CONFIG_BATMAN_ADV_DAT=y
>     EOF
>     make olddefconfig
>     make CHECK="sparse -Wbitwise-pointer" C=1
>
> I should maybe have made this clearer in the last sentence of the first
> paragraph: "This is also true for pointers to variables with this type when
> -Wbitwise-pointer is activated."

Ok, got it. I assumed this would be turned on by an 'allmodconfig' build.

> > If both work equally well, I'd prefer Sven's patch since that only
> > expands 'type' once, while container_of() expands it three more times

Not sure what I was thinking here, as it's not 'type' that gets expanded
here but 'ptr'. We could do Al's suggestion to avoid the __force without
multiple expansions, using

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 1c4242416c9f..d138dc5fd8e3 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -10,17 +10,25 @@
 #include <asm/byteorder.h>

 #define __get_unaligned_t(type, ptr) ({
                 \
-       const struct { type x; } __packed *__pptr =
(typeof(__pptr))(ptr);      \
+       const struct { type x; } __packed *__pptr =
         \
+                               container_of(ptr, typeof(*__pptr), x);
         \
        __pptr->x;
         \
 })

 #define __put_unaligned_t(type, val, ptr) do {
         \
-       struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);
         \
+       struct { type x; } __packed *__pptr =
         \
+                               container_of(ptr, typeof(*__pptr), x);
         \
        __pptr->x = (val);
         \
 } while (0)

-#define get_unaligned(ptr)     __get_unaligned_t(typeof(*(ptr)), (ptr))
-#define put_unaligned(val, ptr) __put_unaligned_t(typeof(*(ptr)), (val), (ptr))
+#define get_unaligned(ptr)     ({
         \
+       __auto_type _ptr = (ptr);
         \
+       __get_unaligned_t(typeof(*(_ptr)), (_ptr));
         \
+})
+#define put_unaligned(val, ptr)        ({
                 \
+       __auto_type _ptr = (ptr);
         \
+       __put_unaligned_t(typeof(*(_ptr)), (val), (_ptr));
         \
+})

 static inline u16 get_unaligned_le16(const void *p)
 {

Not sure if this is any better.

        Arnd
