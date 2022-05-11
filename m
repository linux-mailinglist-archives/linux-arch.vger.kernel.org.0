Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A7E522CE6
	for <lists+linux-arch@lfdr.de>; Wed, 11 May 2022 09:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242671AbiEKHMU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 May 2022 03:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241146AbiEKHMT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 May 2022 03:12:19 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1A937BF4;
        Wed, 11 May 2022 00:12:16 -0700 (PDT)
Received: from mail-yw1-f173.google.com ([209.85.128.173]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQ5nE-1nSdOY4ADY-00M1t3; Wed, 11 May 2022 09:12:15 +0200
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2ec42eae76bso10110447b3.10;
        Wed, 11 May 2022 00:12:14 -0700 (PDT)
X-Gm-Message-State: AOAM531Yn5XBTNE76A/FAw858em/l1XxmWfE5s7uVKGn+RmOjT0HQ1iQ
        3Pj/Ok9Yspvw1GvHCwtCfUJzPtUgKpAvDf54JM0=
X-Google-Smtp-Source: ABdhPJwX01FoB2ZgXBUIcOIxtA7Ea99HJs3NHFXbjQPgP93qP8mFm4KZw803sVc8TjQKsX7r+vkKlUYg6sohAwed5NE=
X-Received: by 2002:a81:1697:0:b0:2fa:32f9:78c8 with SMTP id
 145-20020a811697000000b002fa32f978c8mr23526553yww.135.1652253133436; Wed, 11
 May 2022 00:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-14-chenhuacai@loongson.cn> <CAK8P3a0A9dW4mwJ6JHDiJxizL7vWfr4r4c5KhbjtAY0sWbZJVA@mail.gmail.com>
 <CAAhV-H4te_+AS69viO4eBz=abBUm5oQ6AfoY1Cb+nOCZyyeMdA@mail.gmail.com>
 <CAK8P3a0DqQcApv8aa2dgBS5At=tEkN7cnaskoUeXDi2-Bu9Rnw@mail.gmail.com>
 <20220507121104.7soocpgoqkvwv3gc@wittgenstein> <20220509100058.vmrgn5fkk3ayt63v@wittgenstein>
In-Reply-To: <20220509100058.vmrgn5fkk3ayt63v@wittgenstein>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 May 2022 09:11:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0zmPbMNsS11aUGiAADyjOEueNUXQ8QZtVxr48M3pwAkQ@mail.gmail.com>
Message-ID: <CAK8P3a0zmPbMNsS11aUGiAADyjOEueNUXQ8QZtVxr48M3pwAkQ@mail.gmail.com>
Subject: Re: [PATCH V9 13/24] LoongArch: Add system call support
To:     Christian Brauner <brauner@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Linux API <linux-api@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        musl@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:yxwXvBeurszM3x+5iTkoGSd4Qxz4mpEWhesN486kJBN+frXxvrQ
 mO+187/GlEbR/dArx11jPA06OyFudERdbWlPkc80hs3Rc9nTNKdl/dmhxceP57YKY9k7bA8
 rQbUDhxIsA1SIB+q0iGzpuQC9TNxNlkaELdcCZJu9W+hKSpLNFU/qbm4tErTlEswh8mpSO6
 3MrqZbgc6/PYFGOYWaGgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sHKp8A96in0=:tGBsVkUkcIot84lHAsJyee
 K3a1+e7tgwdaZR7rYmO9kvpvfzui14t9Bi/37YDUGMHR1JnGQqEYkTlT12ZYZ+etwb2ufrmnD
 wTRyVkJtD4Ff1dvrj24M21W6huvEyn7zrVG1qOtKbdsz6Bb3iI1oEu03LMr6dUDd6Uj1P/UVR
 7CWmS5SvJUB4eF39OvgNITThNuCZ8r5V1FSBhqBmD5S5BQJ4jrCDX0QBah6xxtMoR0LtouCln
 Uz6vXON60kQn/MY18EChsZzEd1J8ApnFKhaz3PTSXHoaI45TSaVDLUvLObzPmt+bMkQ1EAlaq
 kvSkMoWgpTIngZsNOYsgBlrunIjsf39uDpH8FFtWCODPGJAfnRZSadc4U1R5N2xCyQ+4ZZZMf
 UjsO7yXWsQcIIVSfalYAXTwsjF8glIONDlTX2C6ZF6aYT+cWW7v/CzPyx/FnJbyjbMawGpAVA
 v4cJvZg+wmNJlvQw5RG/n9PfK9gCMdrwLcT7OKvXuwGAQbP3Nbb6pTsLhFu6o4heNbtPXCIlF
 +h1dkrMqEx0WxuVzgjhhEHSlVKspPbiHhVD9TNvHwDfiT3sb2Vmev6viQ1pkVPfPxg79/KX7u
 JQ3poUxYPRzYBR3fjqg7f49EQ+HOJ22+kelBT2fTJZl1f6kXreud2iexbtwTqG6Zrzwe2JRHX
 JuE2eVNTvHvx8/q3GAXGFyThcXmFOx37m00IolpiuURHeSVEqCn0UOgh7FABeIt+TO4WMBzgL
 abLWrs4OJQOo6Nqglhb83F+Wof371VbWMryjaIbuff4Uck1FuOTmoFCqdWCXaCCz0lMQ+A0Da
 u87erz+MObZcLjfIwTIKXn+q+fAO5jiQ4s1qgNWJKUxpiFhCyirT0bYNPkf8tGezETgN1ahfd
 VjWAdQomAmy98W14T4yg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_ZBI,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 9, 2022 at 12:00 PM Christian Brauner <brauner@kernel.org> wrote:
....
> I can try and move a poc for this up the todo list.
>
> Without an approach like this certain sandboxes will fallback to
> ENOSYSing system calls they can't filter. This is a generic problem
> though with clone3() being one promiment example.

Thank you for the detailed reply. It sounds to me like this will eventually have
to get solved anyway, so we could move ahead without clone() on loongarch,
and just not have support for Chrome until this is fully solved.

As both the glibc and musl ports are being proposed for inclusion right
now, we should try to come to a decision so the libc ports can adjust if
necessary. Adding both mailing lists to Cc here, the discussion is archived
at [1].

         Arnd

[1] https://lore.kernel.org/linux-arch/20220509100058.vmrgn5fkk3ayt63v@wittgenstein/
