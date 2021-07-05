Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712653BBC76
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jul 2021 13:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhGEL6C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Jul 2021 07:58:02 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:41509 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhGEL6C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Jul 2021 07:58:02 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MzQTm-1lDkmx1MlU-00vLN6; Mon, 05 Jul 2021 13:55:23 +0200
Received: by mail-wr1-f46.google.com with SMTP id a8so10082241wrp.5;
        Mon, 05 Jul 2021 04:55:23 -0700 (PDT)
X-Gm-Message-State: AOAM533DoJ3k5//oLMDdosliMiWm28gBaTae+3+SzjhVZZnHRsQXJDRJ
        CY7mMMGxYbmPxHSG3JO0AFCPvObiEu9UsXvfvX8=
X-Google-Smtp-Source: ABdhPJxhCFK1xZGxnW+/y3QiBf/eE9gPROL0Gg3Kf/pqB3DdVNd8R5s6QK1EFCPNARtCYpet1/e6uxBKc31OislpVx4=
X-Received: by 2002:adf:ee10:: with SMTP id y16mr15288976wrn.99.1625486122912;
 Mon, 05 Jul 2021 04:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <linux-audit/audit-kernel/issues/131@github.com>
 <linux-audit/audit-kernel/issues/131/872191450@github.com>
 <YN9V/qM0mxIYXt3h@yury-ThinkPad> <87zgv4y3wd.fsf@oldenburg.str.redhat.com> <20210705093656.GJ14854@arm.com>
In-Reply-To: <20210705093656.GJ14854@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 5 Jul 2021 13:55:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1D-NvZ2Z8r3RnxKVoT7yPnnqN-ZLrMa9UM13y8==OK6A@mail.gmail.com>
Message-ID: <CAK8P3a1D-NvZ2Z8r3RnxKVoT7yPnnqN-ZLrMa9UM13y8==OK6A@mail.gmail.com>
Subject: Re: [linux-audit/audit-kernel] BUG: audit_classify_syscall() fails to
 properly handle 64-bit syscalls when executing as 32-bit application on ARM (#131)
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-audit/audit-kernel" 
        <reply+ADSN7RXLQ62LNLD2MK5HFHF65GIU3EVBNHHDPMBXHU@reply.github.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Alexander Graf <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:irPqV3H5S9rsMtdd45zffH7Pz09R6aCqMBa1mvCyRYsiW0NqwBM
 0ffWBwSP+4PcRRqmidDnYlpn5EkDMdUzO0NTeF+sZJXPpZ+pKckvKeAGhzn2QOtSQmQN46C
 h4gYiTHMj49j5IVptTFerJTHnV9x8EPzRTT+V6MqJFpByk0hTFqfIG8vOCZkl1y1JFTYXkV
 Dmu+aCklN7ExC4SFtlv2A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:G83A7wPXIs0=:eZUyXrcgiZVyYsDAJuwMhJ
 AJmJ+RFJWrMW2KHx8+jHR+O7m6Ytro8iH53xZtW1DjdvoA4jt/mVzxo0u6Vct91n3H7NkCXzT
 8fcCt+vJq3k/0lE97oh41DIli3HzKbV0pVa8j8XU6GSuWUFd1TMUrRE188DEqN8UNfcIqoqZY
 G3tR0nJDz+vJdTLm1tZMHI+Ae2vNHnNOkwuU7zu6UcITzOTSzMOat0xLkplPL47H9lcgzSryA
 jm/EJBNZoP6dq2523rTYX4Cow5yiuSAWW/jDGk53FVc2j5yO2Uch1xg6ZsXNe1TkmsbUmLRqG
 ytIUymr+Zr16Nex/DaV6WjlCXo5kSLIXZbIwrLFFGluEuP8a16OkdFt3DTpxdVrhLtHK84ZIc
 dRX/7QFVF1CZpJbwC5/78S1O6uQNk0E0ppZvYw2csZZs6hIDbYTF0hMzfdlByo23zpSsaE9aR
 2golIwkLrUweTyFeibUdN1ZWdTvx2HlQyIlrru/CMW433WF39KN7TJEJXou3ox8gE+pTgkJ2S
 1JoZKeGsawqxdDY6K++RMRHJTI7ix7OzyQkqtztRiBQdNoTI8ZqDrXI2W5DF92BiQThHgP64O
 VkRDoLeVwN6as0xgWFqkU+0nC82pj0B1rFPWzqjp7BSxJxSwgS/+rAKwpL/+Vy1T2EZSxJPVH
 EQx4qKn1nH8kgYw1FX7DitDfZzSbNdGHQnpiUHoJltjaQExbLMdZYwVMeL15gSufbv/Jv/enQ
 vwq+cy8FVs56KvqagK673FzgklidjijpfFwpYrAXVJR+uZj4gG7VHpr8ySWr6KmKgbjfbt0YS
 qEhTBecr6IV+7Nu/JwAIiKgYKZjZOMcMsqNWPFSvQMu4+YfW8bobPzmbxVWGOFq/aFfb7COIH
 Q5qfPMirmrongGnq+PID3Ey50LwJWMWNEoNxkwRxdjY3itpe2l3ch7ZanrWc6AJLY9+m40vP6
 X+ksVlVsghkiXoH7q109tLl2kFXwJcJ22GWAuMhkTOOI4gzsGL4Rb
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 5, 2021 at 11:36 AM Szabolcs Nagy <szabolcs.nagy@arm.com> wrote:
> The 07/02/2021 20:19, Florian Weimer wrote:
> > * Yury Norov:
> > > At least Marvell, Samsung, Huawei, Cisco and Weiyuchen's employer
> > > actively use and develop arm64/ilp32. I receive feedback / bugrepotrs
> > > on ilp32 every 4-6 month. Is that enough for you to reconsider
> > > including the project into the mainline?
> >
> > I believe that glibc has the infrastructure now to integrate an ILP32
> > port fairly cleanly, although given that it would be first
> > post-libpthread work, it would have to absorb some of the cleanup work
> > for such a configuration.
>
> time64 would require syscall abi design changes.
> (that's likely an abi break compared to what the
> listed users do)

The kernel port uses the generic syscall ABI, and has done so from the start,
so both time32 and time64 syscalls are supported in principle, as they are
on any other 32-bit architecture these days (except rv32, which dropped
the time32 variant, and x32, which uses the time64 calling conventions but
the time32 syscall names).

       Arnd
