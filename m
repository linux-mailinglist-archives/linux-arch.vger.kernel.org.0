Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1494040593C
	for <lists+linux-arch@lfdr.de>; Thu,  9 Sep 2021 16:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbhIIOkQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Sep 2021 10:40:16 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:36725 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345868AbhIIOkM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Sep 2021 10:40:12 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MwQKp-1nGiPJ417l-00sMtQ; Thu, 09 Sep 2021 16:39:01 +0200
Received: by mail-wr1-f48.google.com with SMTP id n5so2890226wro.12;
        Thu, 09 Sep 2021 07:39:00 -0700 (PDT)
X-Gm-Message-State: AOAM532HtoxK1XpA+mTMgj665ydCxWcued8HQi65X6IhdunYFTg6jUXm
        mj5KYquY9stAAqq3Qk+TpUazDfmjJn/iIWO3jjU=
X-Google-Smtp-Source: ABdhPJzH5FTm4Ahmznq9ht5nhkowj4Zn4u5BlABEuGXnJNNsamOP9/btoCFXPbNmcqykva7+mI6cbFrg6KQkTPzWsbQ=
X-Received: by 2002:adf:c10b:: with SMTP id r11mr3986816wre.336.1631198340414;
 Thu, 09 Sep 2021 07:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210903095213.797973-1-chenhuacai@loongson.cn>
 <20210903095213.797973-19-chenhuacai@loongson.cn> <YTjbaz7iea1kwGYb@robh.at.kernel.org>
 <CAK8P3a3sY63WN6Mn6_xNqDYmdhv1PN6CFRfQGNDRO4dHtSjE7Q@mail.gmail.com> <CAL_JsqJh3b9BxRU3ye=Qtmip+XE9gJxUKvPKuKNpxfOvmq08pg@mail.gmail.com>
In-Reply-To: <CAL_JsqJh3b9BxRU3ye=Qtmip+XE9gJxUKvPKuKNpxfOvmq08pg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 9 Sep 2021 16:38:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0=D3XCqn5bGZOWYfM1WH355VgmoVevfwtz=ex4g6yj5Q@mail.gmail.com>
Message-ID: <CAK8P3a0=D3XCqn5bGZOWYfM1WH355VgmoVevfwtz=ex4g6yj5Q@mail.gmail.com>
Subject: Re: [PATCH V2 18/22] LoongArch: Add PCI controller support
To:     Rob Herring <robh@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:svpU8AQp5Rd7CMD4hqLYblNGNirVWo0vDiZGy/XTBdaFQnEWAdg
 Gl8PDjtchE9W850Bev9rFP7PXEv5PrBHx8UCCIEzM3sbZZ7JRNswhdWOZBv82PeSeNnqnGI
 TYlpMTmqXqI0002RGiuPrjA4GddDvhsRbaYLnour4T+HMIrYfW547GCvq/kBrsS/DCfj853
 YF05cjPfcIiLnRB4CpmTg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8JEk7UuEk94=:qZVGbdCz5qGV/ZqeIbj893
 Ah6sbVLWhriE2BFPydbMdT3ox4eo0Xda7kd+SQ4m3slqz4I8pwj8E5p/asFTw9zzrjh5jsq58
 ffRKXvtxNyBj8tB1t2+dLFabxezgw2jrtyE1QsgAosobWPD1OWWgpGOa08BiX/JkaILiLzFuC
 zH4PtaLIw7LnEPxGMY3SsvACLZ1mk67NV0qb/62+ptPaa6WaM9lRpkHsIt0lLJ3eensBiCxV+
 UaCRd3CNLt90NVhvZzN6+zjGs1Osi8gJBMIglo5CkNjLofoRy5uNnnH0eXAj6ks6kz3+jp4dC
 6v3UuQk8BCn1/b6iZ09Oveou/2ScdovVDudnpSMHGTlC6EqiTc0OJv86lmj/dL1nKXfI/kw1Q
 zD7jVMgMN6AU98/h/CJTn+erq+Rjcmoj/1Fo4ASfjkttTFGZlaOtElxeNKR6W+4kTJqpweQ+2
 ph2jJ1VNVKynItBOPYilPNq9ZZEvWPzv87RKvNxGxaWcDxawGTE/GKJMwK+QUK08WKqBhNItZ
 8nTqcX3Xlg8U5sRL2ciEOIdatt2Twjop6/xVK6n+BNMzFi4A6mCNBF8IGKT2eVhQm3lHWx/Cm
 WMK6Wb2EKKnWWDklHnXW7weJeei6U+9aMB6e0vo2VB7iIOoMu28SNW8Ub+cz8lWDt0repg4Va
 lDtrm0ClYCJMtZbpD7NQbKD1SaBMJOoAZFCun3NUZKuQucRZHaic0lCp9/S+37rNvJvl37ZOy
 IlS+KxiXHKDflaAHSmAPtcrHt9v5hUPrnAnOU3np0pTTbB7unmLq+HQ+LQsDlNPMmklxH07mI
 59rSnf72jIVkYgNl5vpHLsokQFYDwjjGX1h3AeWhDu2qKPu9CW1bzuLGDv5WM5GFqGI3lEiNV
 mkaDdbTQBodijznyb3sQ==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 9, 2021 at 4:10 PM Rob Herring <robh@kernel.org> wrote:
> On Wed, Sep 8, 2021 at 11:39 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > > It might be time for default implementations here that can be shared
> > > with arm64. The functions look the same or similar to the arm64
> > > version in many cases and why they are different isn't that clear to me
> > > not being all that familar with the ACPI code.
> >
> > I think it can be simplified quite a bit if we restructure the acpi pci
> > code to behave like a normal pci host bridge driver.
>
> That is exactly what I want to see happen! I'm not that familiar with
> the ACPI device probing piece of it or I probably would have done that
> by now. I gather there's not a normal acpi_device (or platform_device
> with ACPI matching?) so we'd have to create the device(s) based on the
> MCFG table.

I have a patch that I did as part of a longer series to modernize
some of the more unusual pci host bridges, it's only a small step
but should help follow up for the rest:

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?h=pci-probe-rework-20210320&id=7346fbf1938e547833726ebdf25dfe0ef185cbff

What I noticed is that there are a couple of data structures that each
exist for every acpi host bridge:

struct acpi_pci_root
struct acpi_pci_root_ops
struct acpi_pci_root_info
struct acpi_pci_generic_root_info
struct pci_sysdata (arch specific, but includes data used by acpi)
struct pci_host_bridge

I think we can pretty much move all the struct members from those
into the generic pci_host_bridge, removing the duplicates and
adding #ifdef CONFIG_ACPI for some of them.

Similarly, for the global functions from arch/arm64/kernel/pci.c etc,
I think they should mostly get turned into callback handlers that
get set by the probe function, replacing the __weak defaults.

       Arnd
