Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9E75FB4CE
	for <lists+linux-arch@lfdr.de>; Tue, 11 Oct 2022 16:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiJKOnz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Oct 2022 10:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJKOnz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Oct 2022 10:43:55 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601865141C;
        Tue, 11 Oct 2022 07:43:51 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 29BEhQVh028058;
        Tue, 11 Oct 2022 23:43:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 29BEhQVh028058
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1665499407;
        bh=f7cFsivqt5aB8JibP0uT38jXQu/Wbj/dqE/9O7jlMto=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qOGRld0JJhbnaZ4tp5bXCh8X+a3tamoliyOdSOL++AcJ/NyAFRT5sqviP1CMKFnRu
         fPS+ED2Q8niO2KVFkOcs+YhcAMZDfPbwoNYDII+FAamLnWBaBA47uqxdj7UbD73T3S
         THyJCcbvTodfRvi3TnwAeohLJoBtpIyLv3GH2bSoFamML7yuMu1X2bUs84u17+xzGM
         dXiCupNuOYdvKTxmEj0dpWy4ZxvKf10u0YoQSsbDZtUoz5JzB6ILdlaxIX6xnhp0WK
         MhjJRRwPl5wtZlmWCCsbsUZ42Qj2WtQlne0HE/7a6Tk9sBlKOYDx2v1svR5rp8D9EV
         TTnZgyo9ca72Q==
X-Nifty-SrcIP: [209.85.167.41]
Received: by mail-lf1-f41.google.com with SMTP id b2so21451496lfp.6;
        Tue, 11 Oct 2022 07:43:26 -0700 (PDT)
X-Gm-Message-State: ACrzQf1sCJbpYJdVCzOzDuctB8MSBVhPQe6FLVlhxvo4DAOzjLowXwiR
        ZDYjJY1R9+WvbXG1kAnPf+YnkM/2OSIVBMt3pbY=
X-Google-Smtp-Source: AMsMyM6WYbxn4XqdnP3i8B7Mg5ouZcvg+JX5c5rIz8T9AFPEHexE5+sM5jJfYqjyUaDcsRGwDNd1eVbsUFwlrGrxgCk=
X-Received: by 2002:a05:6512:2310:b0:4a2:593e:3443 with SMTP id
 o16-20020a056512231000b004a2593e3443mr8490807lfu.226.1665499405103; Tue, 11
 Oct 2022 07:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220928063947.299333-3-masahiroy@kernel.org> <202210090942.a159fe4-yujie.liu@intel.com>
 <CAK7LNASUhDMo72eNge_GvdfbmOkpBCJA88Xw=_V69jcf+_072Q@mail.gmail.com> <f09f2fb1-ae86-5419-4361-bdd8f8a22e11@intel.com>
In-Reply-To: <f09f2fb1-ae86-5419-4361-bdd8f8a22e11@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 11 Oct 2022 23:42:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNASFi-q-fbMq+3orWnJS6b3Yc7ZQAvRDNvwTSCj2UkP1MQ@mail.gmail.com>
Message-ID: <CAK7LNASFi-q-fbMq+3orWnJS6b3Yc7ZQAvRDNvwTSCj2UkP1MQ@mail.gmail.com>
Subject: Re: [kbuild] b3830bad81: System_halted
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 11, 2022 at 6:37 PM Yujie Liu <yujie.liu@intel.com> wrote:
>
> On 10/11/2022 03:29, Masahiro Yamada wrote:
> > On Sun, Oct 9, 2022 at 10:21 AM kernel test robot <yujie.liu@intel.com> wrote:
> >>
> >> Greeting,
> >>
> >> FYI, we noticed the following commit (built with gcc-11):
> >>
> >> commit: b3830bad81e872632431363853c810c5f652a040 ("[PATCH v3 2/8] kbuild: rebuild .vmlinux.export.o when its prerequisite is updated")
> >> url: https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/Unify-linux-export-h-and-asm-export-h-remove-EXPORT_DATA_SYMBOL-faster-TRIM_UNUSED_KSYMS/20220928-144539
> >> base: https://git.kernel.org/cgit/linux/kernel/git/masahiroy/linux-kbuild.git for-next
> >> patch link: https://lore.kernel.org/linux-kbuild/20220928063947.299333-3-masahiroy@kernel.org
> >>
> >> in testcase: boot
> >>
> >> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> >>
> >> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >
> >
> > I think this is a false-positive alarm.
> >
> > As I replied before [1], I know my patch set is broken.
> > I think 0day bot is testing the patch set I had already retracted.
> >
> > I only picked up low-hanging fruits with fixes to my tree,
> > and did boot tests.
> >
> > Please let me know if linux-next is broken.
> >
> >
> > [1] : https://lore.kernel.org/linux-kbuild/CAK7LNATcD6k+R66YFVg_mhe7-FGNc0nYaTPuORCcd34Qw3ra2g@mail.gmail.com/T/#t
> >
>
> Sorry for this false-positive report.
>
> Thanks for the info, we noticed that this patch has been merged into
> linux-next, so we tested below commits:
>
> b9f85101cad33 (tag: next-20221011, linux-next/master) Add linux-next specific files for 20221011
> 5d4aeffbf7092 kbuild: rebuild .vmlinux.export.o when its prerequisite is updated
>
> They all passed the boot tests.


Thank you for testing them!





-- 
Best Regards
Masahiro Yamada
