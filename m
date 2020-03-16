Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F11CC186679
	for <lists+linux-arch@lfdr.de>; Mon, 16 Mar 2020 09:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgCPIaK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Mar 2020 04:30:10 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:46351 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbgCPIaK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Mar 2020 04:30:10 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N4eOd-1jKoPH0csx-011n5K; Mon, 16 Mar 2020 09:30:08 +0100
Received: by mail-qk1-f177.google.com with SMTP id t17so2907974qkm.6;
        Mon, 16 Mar 2020 01:30:07 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3QpKGCIcMzyeaL7RnhRRnNKtxxiKrZnYZNUvK69wP6QtbIkzP/
        mMC2R8sc6xAMdQ8/4V/AqWl0Yw+7+lUzrF7Obp4=
X-Google-Smtp-Source: ADFU+vvyPJOD7NA64Sv+/yqiF+NJlwZx8uue2CLxsFnH5N5ZzWWHWlodsVSd2XAZyQm3iAyvUigtWyzxiB7iRdaN1HM=
X-Received: by 2002:a37:b984:: with SMTP id j126mr23740630qkf.3.1584347406786;
 Mon, 16 Mar 2020 01:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com> <1584200119-18594-8-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1584200119-18594-8-git-send-email-mikelley@microsoft.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 16 Mar 2020 09:29:50 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0+uBsurfQ4smjPDGkJQSkMe-TxJ4cWR_EZXgDR4-bAWQ@mail.gmail.com>
Message-ID: <CAK8P3a0+uBsurfQ4smjPDGkJQSkMe-TxJ4cWR_EZXgDR4-bAWQ@mail.gmail.com>
Subject: Re: [PATCH v6 07/10] arm64: hyperv: Initialize hypervisor on boot
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, olaf@aepfle.de,
        Andy Whitcroft <apw@canonical.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jason Wang <jasowang@redhat.com>, marcelo.cerri@canonical.com,
        "K. Y. Srinivasan" <kys@microsoft.com>, sunilmut@microsoft.com,
        Boqun Feng <boqun.feng@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:pqTnCUA7h/Lh54lLYAt+WirJyeDQzTABrl3Qn+pavTDJZArOtO1
 I5dsRDwq2YJDavQ4glmsON4CbJ4lIxFcF3fnueaZQCH2hzD+/bF0Lv0Dxpvee0Fbo+VqlNN
 zdjwzsrw2IvnnpM4EI9cP4tACmkMOIPbj0viMMpV551r5H6tYTLwUQQ73nsbYjwffFwCitm
 X0Qk6NJXSTGP5i+cOWctA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0GrxuZwKe8Q=:b6Bcx7+PggkJp6Ii84As64
 xoKb5U6zfXsxt8HKqugdeQ9gY4VE0NfiSTzMCwqV0TtXPhVtw7PWraekLAhxHMmcWQgb8WcW0
 VcpKimB4U5qiUiDoeuQ+nsa51aYXCOX+uGD4aN+sb8HpafHrwz8BsNs4aozeBsoGHMAE1mYUF
 LnWMBFyCDNI50BwjJj9plr6w6iKuQcgTSscKfhzuwQMZ7IgB/qwxRfaMsn8WaNClUqzvBuUQB
 r+JnRug1Nlrjd4Kd0mIwZukX+ZSTaWnUQ/ef8MS41oClxAvSwlYQ5txuZw8u6An+UVu/It6Yo
 uKKMGbFcD4gHBb7ooYkg27NPR9fgEP+vLRvGSZTMFKfLKej+7n6jkyvMIz0zSNoJLyZMUeP39
 QEXhhkbv/t/I45bD37DvuoKXqjAdGUlkAF9XMcCJcBAVAy32oHqmmTpFZuBcLKFEVsp4Ab+Jg
 3gIBqHi+eoLoCEsorxUkJ1w9tZfe2tOAruH2BUcc4jqw/1IH2eGFHucb9IFdopgDKOio38akh
 7EkaBYWdQje4zF8RcGT6vmVUw2+E1OT2EgJiYOR0zxPD9jUI8XpR6XYFVhrjJvjlbSAo8sw4p
 OxKVEC+jcjyB8ShI+XY74dkZwIS9InqG5yTyGFnvi1XJEp9wNYhFl2hbXwNpRz3Sl86HmF9pE
 vvRTMQ118Bkc+gf1X75UWSOzDZ7ufLdK+Hj2cLCCl9lKXz9Nbe9RDGZ2YDqeTxLLzCwp75wT5
 mX0zZJJIGlqth7fAPS98zDOeta+bb8z1FUQ4+aeBTfOfnL5Zh2/0oo39qiwMcFJjMz991TaTE
 p5Do7sqp9qj+BfoKl+SrQqn2hsxmIgC9NsAceovsLKz5BNGNwg=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 14, 2020 at 4:36 PM Michael Kelley <mikelley@microsoft.com> wrote:
>
> Add ARM64-specific code to initialize the Hyper-V
> hypervisor when booting as a guest VM. Provide functions
> and data structures indicating hypervisor status that
> are needed by VMbus driver.
>
> This code is built only when CONFIG_HYPERV is enabled.
>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/arm64/hyperv/hv_core.c | 156 ++++++++++++++++++++++++++++++++++++++++++++

As you are effectively adding a new clocksource driver here, please move the
code to drivers/clocksource and send the patch to the respective maintainers
(added to Cc here), splitting it out from the rest of the patch.

You should also describe why your platform doesn't just use the normal
architected timer interface.

> +TIMER_ACPI_DECLARE(hyperv, ACPI_SIG_GTDT, hyperv_init);

This looks like it registers a driver for the same device as the normal
arch timer. Won't that clash?

     Arnd
