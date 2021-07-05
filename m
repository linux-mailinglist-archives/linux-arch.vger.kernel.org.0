Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFA23BBD9B
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jul 2021 15:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhGENnN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Jul 2021 09:43:13 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:39139 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhGENnM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Jul 2021 09:43:12 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N3K9E-1l0UWe1aM6-010IjX; Mon, 05 Jul 2021 15:40:34 +0200
Received: by mail-wr1-f53.google.com with SMTP id a8so10464501wrp.5;
        Mon, 05 Jul 2021 06:40:34 -0700 (PDT)
X-Gm-Message-State: AOAM5312NSuiTRLaXwtWGn3ouRkovfw5RGiLfxR7t1USIXWU7nIa8lMO
        37VMDtuuzEb/AUW+7a4OvYLxygpymMkUG5hCX0g=
X-Google-Smtp-Source: ABdhPJyNk0E58GdhdijG+SWnLfymVKXZ/4Aj/5fDKjXY6B+nWTKh9KhTnS5biw+IyDgpCND/EK/0PkvZ8uhiQ+fkLjc=
X-Received: by 2002:adf:fd8e:: with SMTP id d14mr16484625wrr.361.1625492433851;
 Mon, 05 Jul 2021 06:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <linux-audit/audit-kernel/issues/131@github.com>
 <linux-audit/audit-kernel/issues/131/872191450@github.com> <YN9V/qM0mxIYXt3h@yury-ThinkPad>
In-Reply-To: <YN9V/qM0mxIYXt3h@yury-ThinkPad>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 5 Jul 2021 15:40:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0L4YU2q6WCZviNJGzAuQniwrZDKc7w1nHMB276hZzG6Q@mail.gmail.com>
Message-ID: <CAK8P3a0L4YU2q6WCZviNJGzAuQniwrZDKc7w1nHMB276hZzG6Q@mail.gmail.com>
Subject: Re: [linux-audit/audit-kernel] BUG: audit_classify_syscall() fails to
 properly handle 64-bit syscalls when executing as 32-bit application on ARM (#131)
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        "linux-audit/audit-kernel" 
        <reply+ADSN7RXLQ62LNLD2MK5HFHF65GIU3EVBNHHDPMBXHU@reply.github.com>,
        "linux-audit/audit-kernel" <audit-kernel@noreply.github.com>,
        Mention <mention@noreply.github.com>,
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
        Florian Weimer <fweimer@redhat.com>,
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
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:4neMM1Yflvb8OYyphwzh3kNyrS00gfy3pXY+JOvgQOo2HdCol4T
 OoSWKtp+/a6zVxNFHFIlN7DKcHI4ypXElXuRdPACfRqxUnN2rR7/yOaZ/i+af3vYULyskau
 tlFH1A2oVc9mOGCnLTYa9cjuylhsGPmplEUqJDhYACYGEzCveILkTtMe2wzLnw20XPCq45t
 +UMqMDdjNldhgWu9Hm6sA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vwfYswzw0Fc=:IZluxWwcJlLRV+zd98tvzP
 dYsBLW5fOMQ9eSu59bQQtsUccti8o3+Dbwu0RkNUnTICiW4WNv+WjLnKZNwKS+McN1W1g26H5
 EyTSvmsSuzhSR4FckbRT6our87By9Y6ukU5W0gfqU/y8/FSqxESuu/Oe81Y0nOH1D1Jgu95uR
 RmSfMZyfi6oOSEvWBrPqXrSw6OrwZS9s4lQYTjL/dA54n/YC8esPwZ86LfCl/qtExSADszUrT
 8lLcyzWdD9/kDMxEpxZKNITKg1JbVwaJstQTA/fqXI4MPae1r0eYC+0Znir4Uva0vJ8fhkK+r
 G7abCiUvwt/mx5nzuUNqxKISHJ9nQT2T/O6M1ZDZbgzxSlJQw4HTyBfwW7UknA9CB95rflbi0
 F1ZgX1ujXl70R1Fgg6aacJjgNdfHXvDDxFBAI2O1sWCaBFrTebEIfxdsPyXg9AKIFLmZq1owD
 WwIUsM9TdADVu/vBEmBmxigVK297HDhy21CWDor4Ctrj7oKcmJjQM/ugEo2thN4EBHV2sIRNH
 Ol2b5/F+bf2QRnEtYn4vLeCkFCz73SUz5LWzrv391IBF+EZEcTNWsk69/d6P4y999G6p8Y6JS
 eDU8Fh8FCc0iEadTpnHumeisPMDV1bsxLKCGJtTXVqlqzMAtLVztKuSlo0njZOxPL2TwLQvlQ
 g8C9x7AX0NehAiZjRQgWLYB0JdzyARnMnRHyPiKuNl/UgfqTMsR6Z8KVXhtkL2h4SoI3Pgk1Y
 GFY0nb3VDm69OtdZwpCOhBxK7eGggHAtqbVN2R62lTVe1AlzFdj23AtfnOKqCwsHL6vQkIZ1G
 uEZRMAZIrxROd0nAccYD/SJs5uDRn80ttvBOWu05VQx2EciasQwhwdkL6AOwH9oa94xhp1bqi
 y1/mahy1bG0LuzwoOILYzB0zsdEPdJI0+UZMf7BBgnKy4w1Uqy96E03IFUtJMorZXctrsqsg1
 Q7NPpC8Z+V7gzGEUI8GsmG/InCBK6cZiUaNJ5R79xCkJMhgjY4h8p
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 2, 2021 at 8:07 PM Yury Norov <yury.norov@gmail.com> wrote:
> On Thu, Jul 01, 2021 at 05:08:45AM -0700, Paul Moore wrote:
>
> To Catalin, Arnd:
>
> At least Marvell, Samsung, Huawei, Cisco and Weiyuchen's employer
> actively use and develop arm64/ilp32. I receive feedback / bugrepotrs
> on ilp32 every 4-6 month. Is that enough for you to reconsider
> including the project into the mainline?
>
> For me, having different versions of ILP32 is more dangerous in this
> situation, than upstreaming the project and fixing 2-3 bugs a year.

I think the overall tradeoff is not that different from what it was in the
past. Keeping it out of the tree clearly creates extra work both for you
and the users, but reduces the overhead for everyone else, who
can ignore that corner case. We have tried removing both x86-x32
support and arm64 big-endian support from the kernel not that long
ago. Both have considerably more impact on kernel maintenance than
your aarch64-ilp32 work, and they probably even have fewer users,
but we always ended up keeping the status quo.

However, there are clearly some changes that happened over the
past few years that may be relevant here:

- The expectation in the past was that ilp32 support would eventually
   go away as users move on to full 64-bit support. It has survived a
   lot longer than I would have guessed, but I still find it hard to tell
   whether this would continue. What's more important than the current
   number of users is how many of those you expect to run linux-6.x
   or linux-7.x with aarch64-ilp32 in the future.

- Another thing that has changed is that we now have a rough timeline
  for aarch32 support to be removed from future Arm processors. If
  no Armv9 processors after 2022 support Aarch32 mode, we may see
  interest in ilp32 mode go up between 2025 and 2030 when those
  processors make it into more markets.

- On the other hand, interest in not just 32-bit hardware running Linux
  but also in 32-bit user space is already declining overall. We'll
  probably still see some 10 to 20 years of 32-bit user space
  deployments on (mostly) memory constrained systems, but this
  is getting increasingly obscure as more applications run into
  virtual memory space restrictions (3GB or 4GB typically) before
  they exceed the available RAM. On RV64 and ARCv3, there is
  already a conclusion that they will not support 32-bit user space,
  neither ilp32 style on 64-bit instructions nor with hardware support
  for RV32/ARC32 binaries. I expect the same for Loongarch.

          Arnd
