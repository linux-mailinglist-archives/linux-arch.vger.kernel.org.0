Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3AD18A060
	for <lists+linux-arch@lfdr.de>; Wed, 18 Mar 2020 17:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCRQVX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Mar 2020 12:21:23 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:45257 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRQVX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Mar 2020 12:21:23 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MmU9X-1jfRsu23qD-00iV8g; Wed, 18 Mar 2020 17:21:21 +0100
Received: by mail-qk1-f171.google.com with SMTP id j2so26819658qkl.7;
        Wed, 18 Mar 2020 09:21:21 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0s+QS+hpzySak5HhKcmpJ9V5yn2Z+UAFYWeg1z7UyYpGTkVNpj
        HDG60IyDol0lhwLt0YojHIkHoWNW9ObXEMXg5TQ=
X-Google-Smtp-Source: ADFU+vu8uNi3sW2bIHM5SJUX03S5Rg7I2QD/U+Jz3NTgam8OOAlxurtc5VkYhSV2QoEZDq8Ol/sJDXj90P9WjcZD+04=
X-Received: by 2002:a37:6455:: with SMTP id y82mr4978448qkb.286.1584548480309;
 Wed, 18 Mar 2020 09:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <1584546935-75393-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1584546935-75393-1-git-send-email-john.garry@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Mar 2020 17:21:04 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0uxCyOZS0jkWM9DcAeQaKBEjovMC0QudLbu-1WK2i3Yw@mail.gmail.com>
Message-ID: <CAK8P3a0uxCyOZS0jkWM9DcAeQaKBEjovMC0QudLbu-1WK2i3Yw@mail.gmail.com>
Subject: Re: [PATCH 0/3] io.h, logic_pio: Allow barriers for inX() and outX()
 be overridden
To:     John Garry <john.garry@huawei.com>
Cc:     "xuwei (O)" <xuwei5@huawei.com>, Sinan Kaya <okaya@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>, Olof Johansson <olof@lixom.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6MiCCLa/tETG1sXfZDIkkgi7gxuZM3DuVjnISE4bjz7fAURne6O
 urcG914oGkvCOZJwW9vEFzko76b6LToxiZLjMV5zlL6k68lDwfRn/kN46msS/ibQIpVIkhc
 OrffRQEJt0JzQVF3jBuaLYj82IkVltc8fMCqtnlisZHkSkJRiT0MpfbQF+GOWVF4Mg079uT
 7BxC2D/idCvBX5Q5OR7NQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4JhK3tL9zH8=:M6g6lRoksmzR9VTsbynTMT
 Kyw3f+KxsR3XeSBZsI2um7xQWxC9PJbGEkTkFlC4KdfvBCdgUKj/h962ptPzL52k4i5JqhGjc
 e7TjJbGELcJG3kLQxBN61+j1wQ8J8ZeIUATFTupN3ALxzcOaQeNLWjF8G+2uU4ak6RBziWOIh
 NnrA+5M7uTSulCEXmTktz6Ab5rIIO7blO5efTfoodp//o8KLuVdQpL6WgZaJjoim2Cah4VzPd
 Q8UX8M0hqbACcMTAguG/w/cMVO+2i5YynnZO8NOABWeM56NFC4IyXCKc2YyXeRRpNiN+T6Otg
 8Ng2c86T1ErCU6E7Drtjx8tJvIzbEIejZVyhPaYA1Sl06ghnZJfW06ZbVuRPMIUiaPXggmbBc
 Mfnm+xWObd4QexDEaXy3zheYkeMg8kbKeAUb337i7gBMfxU2MYXE/WHbHk7PpOy98nuwZevBZ
 eF4NR9h5v04XxQj7xvfTt3VUseKgRE4tJH66cJmMB3NkABdNuqJ9gDW4h6kexOtETr2nGgUuz
 xZ+OsaFXXWhEuCVRKCovHfzanzu+8Mq2wVkvGfNUG+q1DnMvrDQIldL/3lG0MSTcqt0XKawXa
 639cf3mlazRdTYFHsGgkj6s5W5xQJgtUPDbkbyIZP+NvlWPn0R9/m5/lXY/Md/EYITYqeqWxQ
 mkvUe7SwREAnUAh50py7ddJ6g5BQgVteF91KuvZ76Ep6ef+krreNGQJLlmUJPYCPBcTL69q4W
 tfV7PWTopfy8J+gKgWTpP8MYqWqAeKNU25YK8cBhc1k9imP7HuvHfzUJCSTsvUiRcJUT2bdib
 je6lCnfvH2je29fJ3L9KVvgVvlnUIfmfVFWa+vDsB2/oERSwN0=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 18, 2020 at 4:59 PM John Garry <john.garry@huawei.com> wrote:
>
> Since commits a7851aa54c0c ("io: change outX() to have their own IO
> barrier overrides") and 87fe2d543f81 ("io: change inX() to have their own
> IO barrier overrides"), the outX() and inX() functions have memory
> barriers which can be overridden per-arch.
>
> However, under CONFIG_INDIRECT_PIO, logic_pio defines its own version of
> inX() and outX(), which still use readb et al. For these, the barrier
> after a raw read is weaker than it otherwise would be.
>
> This series generates consistent behaviour for logic_pio, by defining
> generic _inX() and _outX() in asm-generic/io.h, and using those in
> logic_pio. Generic _inX() and _outX() have per-arch overrideable
> barriers.
>
> The topic was discussed there originally:
> https://lore.kernel.org/lkml/2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com/
>
> A small tidy-up patch is included.
>
> I hope that series can go through the arm-soc tree, as with other recent
> logic_pio changes.

Looks good to me, thanks for the cleanup!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
