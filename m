Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CBF526A69
	for <lists+linux-arch@lfdr.de>; Fri, 13 May 2022 21:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiEMTdE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 May 2022 15:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380583AbiEMTdE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 May 2022 15:33:04 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2805BE7B;
        Fri, 13 May 2022 12:33:01 -0700 (PDT)
Received: from mail-yw1-f170.google.com ([209.85.128.170]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MV6G0-1nNaHd3SGk-00S9SR; Fri, 13 May 2022 21:33:00 +0200
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2ebf4b91212so100487807b3.8;
        Fri, 13 May 2022 12:32:59 -0700 (PDT)
X-Gm-Message-State: AOAM533EJnvtWJNshrUMN/cMhiHTKD+qmQW0y38xtp7AymAdmJyKwRUF
        BChQ3yLjkZro08kZmNILqrvfUXCBv3IGlbPmdmo=
X-Google-Smtp-Source: ABdhPJwCL00R0GBeDe7JbP4gBwr+dNH6R9L3x9Kf4PexSUlAVHRfICUM51HKbOE6+snkPmIgf0vzFiRTTaBIYyJk+Eo=
X-Received: by 2002:a0d:fc83:0:b0:2e5:b0f4:c125 with SMTP id
 m125-20020a0dfc83000000b002e5b0f4c125mr7612521ywf.347.1652470378438; Fri, 13
 May 2022 12:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-21-chenhuacai@loongson.cn> <CAK8P3a2SPTLLrZtSz0LT0LqMpq4SKCScD4vLvr+DJn+u5W_CdA@mail.gmail.com>
 <CAMj1kXEDpJwLDD4ZGLwzdo1KcJG_90iD9MnBVamCK06YKF7BdA@mail.gmail.com>
 <CAAhV-H4eR5YvhABp9L4FBmofWwH+XM3V_nOjatQTV_M7Gihs7g@mail.gmail.com>
 <CAMj1kXFD8_CuijJFgQbrxvY4MVBLmKQKFKmYhD1NBFLn3v=+FQ@mail.gmail.com>
 <a6afaa3f-cb9f-2086-0e02-5ec21ba535d4@xen0n.name> <CAK8P3a0xuh1aAM7iwE-jiBbR-OOF5YVfhmU0Nygbpviso3tmbQ@mail.gmail.com>
 <CAAhV-H5FbA5DJvPwygiUyBrzq9M5R=Fr06rHAHLR31uu6ZLmkQ@mail.gmail.com>
In-Reply-To: <CAAhV-H5FbA5DJvPwygiUyBrzq9M5R=Fr06rHAHLR31uu6ZLmkQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 May 2022 21:32:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1_2DJVjZtk9XGYvH0TSbNQwST0YXD4A+rfFELBOxpDEA@mail.gmail.com>
Message-ID: <CAK8P3a1_2DJVjZtk9XGYvH0TSbNQwST0YXD4A+rfFELBOxpDEA@mail.gmail.com>
Subject: Re: [PATCH V9 20/24] LoongArch: Add efistub booting support
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, WANG Xuerui <kernel@xen0n.name>,
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:sxjlWFQFhZs3joRNaNiPtLzwBQaw3DZiNtMZyNdZL4N9Nkjw+mE
 iy6k/NWrt1xZ9nSdoWCB1AIT/KW91SjYpgFeR6Lj7a9RXZnQZx/sAeR/BDUMHzX28hvOOHN
 l7m5VNIxPjWs5OKoNGqOw27BIBGQd1EHic9ZskKZGppT8OZW7B1VdUPQxMOkQzrXQjm+ZGg
 NorQQ2fUOehivtcs9Q85A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IhdJcJuUJZY=:DKZDFjsDhyzTTZ4MolSQwL
 NP6YkDnm9jyTegRc22QX6EXUJO1De+OD3AHVRJrJRUbsbfb9Gr8QKRsiVN980aMCaQ+Gf4nY8
 TmG/AqKTGtO0RumJaO+/Hz7bOizpP+cxJuPTSCpdkErMFoBcEOFe0bMtABYA+RWPZY053Rzm1
 fRcSTPhUgSqZXpSDhGdwJBJo0frncIREpsmQAz92igcHQlHiR+ggHeDMepLi5Iz1RffiQdm99
 TlOEYoP0APl2FxYsRkVGsVrVwrauth5RFl9pgJlmO8vwH95tmPkrkNsoHX4GCCUfBd87Gh5Cd
 96x6KCowIHrTVv/PWkYRr5XK2z0iEq48Kz51lv5I90NfxP/yx7pgssHtgCpRRigqEPQuofT3a
 utfOCV75CzBwhBnhluz40PMrqIEaWFYGurBnp/wk8mi2MQk8rk3FYDSrOc/LmGwa5NSJ/Qhaj
 g9uKAS2ShijASCArBk436/0lEIuqO+i+dWhv2Bup5IbGiPQSIYMof6HiS+hkD5UUhcUSRDNh3
 FS4OV4GROLbRf0P+tDlKtrbQ9j5/nOoJ/VCB5ub6oYgn1LOXZz2i3RBatdiSdTQLZQHQFOIbN
 3XxnU0Sb9zezkrwwFuh2OlVoJipprS7YFrGpBZlRg91Tdvf1sxniblOURmL4KQt5lORs0Robh
 M0TMOHvH2rYsVwEOnxs3gJLnCBZuyPbJW0kbSeqD1Y9Qx/kYztgewv/O8HwB/ULxgrBI=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 6, 2022 at 3:20 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Fri, May 6, 2022 at 7:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Agreed. I think there can be limited compatibility support for old
> > firmware though, at least to help with the migration: As long as
> > the interface between grub and linux has a proper definition following
> > the normal UEFI standard, there can be both a modern grub
> > that is booted using the same protocol and a backwards-compatible
> > grub that can be booted from existing firmware and that is able
> > to boot the kernel.
> >
> > The compatibility version of grub can be retired after the firmware
> > itself is able to speak the normal boot protocol.
> After an internal discussion, we decide to use the generic stub, and
> we have a draft version of generic stub now[1]. I hope V10 can solve
> all problems. :)
> [1] https://github.com/loongson/linux/tree/loongarch-next-generic-stub

Can you post v19 to the list? As we have resolved the question on clone()
now (I hope), and you have a prototype for the boot protocol, it sounds
like this can make it into v5.19 after all, but we need to be sure that the
remaining points that Xuerui Wang and Ard Biesheuvel raised are
all addressed, and there is not much time before the merge window.

I have built a gcc-12.1 based toochain at
https://mirrors.edge.kernel.org/pub/tools/crosstool/ that now includes
loongarch64 suport, please point to that in the cover letter for v10
in case someone wants to start test building.

I will be travelling next week, and won't be able to pull your tree
into the asm-generic tree during that time, as I had originally planned.

However, you can ask Stephen Rothwell (added to Cc) to add your
git tree to linux-next once you think that you have addressed all of the
remaining review comments, and posted the same version to the
list. This will allow others to more easily test your tree in combination
with the other work that has been queued for the 5.19 release.

If there are no new show-stoppers, I can help you coordinate
the pull request during the merge window.

         Arnd
