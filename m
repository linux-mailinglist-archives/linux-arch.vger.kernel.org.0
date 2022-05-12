Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D289F5246CC
	for <lists+linux-arch@lfdr.de>; Thu, 12 May 2022 09:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350905AbiELHVn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 May 2022 03:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350972AbiELHVg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 May 2022 03:21:36 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030E42C10C;
        Thu, 12 May 2022 00:21:33 -0700 (PDT)
Received: from mail-yb1-f173.google.com ([209.85.219.173]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M2fDr-1nma1s3mxT-004CAf; Thu, 12 May 2022 09:21:32 +0200
Received: by mail-yb1-f173.google.com with SMTP id v59so8108983ybi.12;
        Thu, 12 May 2022 00:21:31 -0700 (PDT)
X-Gm-Message-State: AOAM532m7bhsqYseq6xznso3H2LCu9NoI7jZNTium6OFgIlUc1uKAlzh
        8EBUuGE/I+ym1RYNT6C2OEeWGFGN9qQIBgmT950=
X-Google-Smtp-Source: ABdhPJx4WfEOUWv2L6bCmWT0mJB6dEDWkNIHboRAE66MHFC+PuQA7c4QPgkOpP2BhGDSQSBJfhNNN89Hg26ByytWHec=
X-Received: by 2002:a25:cdc7:0:b0:648:f57d:c0ed with SMTP id
 d190-20020a25cdc7000000b00648f57dc0edmr26571261ybf.480.1652340090303; Thu, 12
 May 2022 00:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-14-chenhuacai@loongson.cn> <CAK8P3a0A9dW4mwJ6JHDiJxizL7vWfr4r4c5KhbjtAY0sWbZJVA@mail.gmail.com>
 <CAAhV-H4te_+AS69viO4eBz=abBUm5oQ6AfoY1Cb+nOCZyyeMdA@mail.gmail.com>
 <CAK8P3a0DqQcApv8aa2dgBS5At=tEkN7cnaskoUeXDi2-Bu9Rnw@mail.gmail.com>
 <20220507121104.7soocpgoqkvwv3gc@wittgenstein> <20220509100058.vmrgn5fkk3ayt63v@wittgenstein>
 <CAK8P3a0zmPbMNsS11aUGiAADyjOEueNUXQ8QZtVxr48M3pwAkQ@mail.gmail.com> <20220511211231.GG7074@brightrain.aerifal.cx>
In-Reply-To: <20220511211231.GG7074@brightrain.aerifal.cx>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 May 2022 09:21:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a05wSVu7M9kVMw5cSqx84YUCk1394Yfd_5tweEOc2P69g@mail.gmail.com>
Message-ID: <CAK8P3a05wSVu7M9kVMw5cSqx84YUCk1394Yfd_5tweEOc2P69g@mail.gmail.com>
Subject: Re: [musl] Re: [PATCH V9 13/24] LoongArch: Add system call support
To:     musl@lists.openwall.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>,
        Huacai Chen <chenhuacai@gmail.com>,
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
        GNU C Library <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:i280+8Sy6Wd4KatTn+RAGMJYY6bd4l+X6Q9g41wB0EzV5X30OO5
 4F/E9HIw9rH3XsYfsgDXkv8wVRdhceF7dTDTOWUf+b6zI7JZrCl1L2eHs24DhecUt0pCEbQ
 ukUdWPXSgzAJX9qnvbH+D6DTGPfESuYxFs9qVcsdWMUjMnxleuzfZaG3jSfOI80dHooHwRL
 ANBM/AtA2m0eggx/7I5iA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YhzFAH8uXKs=:InJy6ZucBe+dh6L7ckj11f
 WzhmjMZMraPlGFvP/YSsCywqfrtchUusNsSgyCdGxFrItN0vcro3UmkaEC68tugzAoBJBv9SV
 buDkGAGUv9mHuod3qaSDHjtBNWOHkg32FiZshWt71YhZMHkZqs6t3tFddTUMo6GvkjHCa3B3p
 1NdQRyuHfL8sytpzGoni1yWoKkKf5AVF51+qQIwDrQuv/9KCTfIpChFshB19HptGnTNrt7gXc
 qRF6RA3EItn8/4dxLLYOZYUss6273Io/sWYp+akYxRkpENMtboT26fZwZsIX1JgXVESnkCdE6
 mZDiejsgESRTx/P8lVkMf3x1eLvVSTiHLidh1IDaH8FDauWiJIrGB3mqe7wP+BKQM+D1DcJ5m
 aCcaTS88zzIQqnaX78s3QEA3IEozae65oXP0k882cEc4nyQPYaWEna6T6f0gbvEEMpN7LFO41
 mhR43WsPBpVYS2G89k8l1Moq1+VJMvHOtVDCj6HG0hni8YSxoFkZfQzNfYUcagppRtFlDXfmj
 o8eomH+CvzOpFhB21d13cNvMmcf/3E0XtK6ipRbWZgRfQ0b9HvBl+r4z3mp/gzUT7vd2Pmbmq
 pjciDZRJlzngfCvuEXrfJVp6ojFbLOqaG91GZWqADrw4BKEoM2tOAsPBwVPV0fsovGHR9Gtjq
 9FTVn1vErqylEXHGPNKTlEvuxZRmJK4Z93J0KVZiVb/6hUQO794P0IyfuvnobVUnd7FBgDbW1
 a0v5Ca15cWEg8+Fpvq2OwqZMtNa1rl5IgoSyRNW7EBH81aQdyXDET2v4IPGxsSfOg+/x/LQI8
 tctzVxDP3o0Imqw+j6YmjuZmYAJ/t0FceQ03cxuBiBRK2MyNvuPobmlgwVE/uAxrqEmoNsgM8
 Mp21AeuMcp/vIrPJm6QQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 11, 2022 at 11:12 PM Rich Felker <dalias@libc.org> wrote:
> On Wed, May 11, 2022 at 09:11:56AM +0200, Arnd Bergmann wrote:
> > On Mon, May 9, 2022 at 12:00 PM Christian Brauner <brauner@kernel.org> wrote:
> > .....
> > > I can try and move a poc for this up the todo list.
> > >
> > > Without an approach like this certain sandboxes will fallback to
> > > ENOSYSing system calls they can't filter. This is a generic problem
> > > though with clone3() being one promiment example.
> >
> > Thank you for the detailed reply. It sounds to me like this will eventually have
> > to get solved anyway, so we could move ahead without clone() on loongarch,
> > and just not have support for Chrome until this is fully solved.
> >
> > As both the glibc and musl ports are being proposed for inclusion right
> > now, we should try to come to a decision so the libc ports can adjust if
> > necessary. Adding both mailing lists to Cc here, the discussion is archived
> > at [1].
> >
> >          Arnd
> >
> > [1] https://lore.kernel.org/linux-arch/20220509100058.vmrgn5fkk3ayt63v@wittgenstein/
>
> Having read about the seccomp issue, I think it's a very strong
> argument that __NR_clone should be kept permanently for all future
> archs.

Ok, let's keep clone() around for all architectures then. We should probably
just remove the __ARCH_WANT_SYS_CLONE macro and build the
code into the kernel unconditionally, but at the moment there
are still private versions for ia64 and sparc with the same name as
the generic version. Both are also still lacking support for clone3() and
don't have anyone actively working on them.

In this case, we probably don't need to change clone3() to allow the
zero-length stack after all, and the wrapper that was added to the
musl port should get removed again.

For the other syscalls, I think the latest musl patches already dropped
the old-style stat() implementation, but the glibc patches still have those
and need to drop them as well to match what the kernel will get.

       Arnd
