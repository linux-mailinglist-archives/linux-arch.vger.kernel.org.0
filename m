Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C414A40F47C
	for <lists+linux-arch@lfdr.de>; Fri, 17 Sep 2021 11:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhIQJDm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Sep 2021 05:03:42 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:55873 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhIQJDl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Sep 2021 05:03:41 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N7iT4-1mwame1YQc-014lwc; Fri, 17 Sep 2021 11:02:18 +0200
Received: by mail-wr1-f42.google.com with SMTP id i23so13992945wrb.2;
        Fri, 17 Sep 2021 02:02:17 -0700 (PDT)
X-Gm-Message-State: AOAM5306GrV7jZASVG5H+MQwNDDzY7hEGkrmz95rOTwGmaSRy148iRdL
        oytmqDUKnsri7NvbO95wUSrNCbwgBXrIIy3f3bo=
X-Google-Smtp-Source: ABdhPJw6r624crPzbfz4Nvr2pbJ9ZO+UiBgdv+k/OBM2TFktBVkhBtLpOU/mmzSq/jJnWFToRK6mw+fTR3mUw8aBqoc=
X-Received: by 2002:adf:c10b:: with SMTP id r11mr10884040wre.336.1631869336873;
 Fri, 17 Sep 2021 02:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn> <20210917035736.3934017-19-chenhuacai@loongson.cn>
In-Reply-To: <20210917035736.3934017-19-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Sep 2021 11:02:00 +0200
X-Gmail-Original-Message-ID: <CAK8P3a26CGyiZ9y7KxHGu6eHXZJ08X4mospr+3CL8g_qi=ACpg@mail.gmail.com>
Message-ID: <CAK8P3a26CGyiZ9y7KxHGu6eHXZJ08X4mospr+3CL8g_qi=ACpg@mail.gmail.com>
Subject: Re: [PATCH V3 18/22] LoongArch: Add PCI controller support
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
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
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ZPJ3unZ38iZq/NHPz6ZHLheWP8t8LYOCiD4YHHdb47yBqGycgoJ
 7wtvDv4j1NCPuCR3WVqDY72Yi/kU77+z2h2XTngsC9WvTSxmIqWB29129+pgHBKZAc6kgk/
 mi0Nfm6H8KTWMB0n/5O1csvAnxb97ZymhX/fSMjh5zN00FqHxM9YaZndxqlI23qg9Qnx5Nb
 l2rrDs9GmaE957UCgQYJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F8kJQlhz+VQ=:S4a9vWlo0mnu2sA42Kt7vI
 fbUWwXBkhzXYZiN4oVgYeSZ9L9m6qypr9Qd8PyTjhHHA5vrGBOlHdNY+L1+v2apPq1GOdd/N3
 AK6GdV/ydwq1R50APsARTmtDK7yxuAYg+qYWQWbTbVTagh7ZpAfN1zmaARR9EQT4XzN517gdp
 F+EbzgjT/oIHLTgcga8d2lELoMXeQlzVO6KPCoW4dRtKPkK1cB2Kx7orMO5F7WWdBAjTWA6Jx
 poifHkrK6pXY9kOQporWjq1vXBJ1/CVub+WwX+p+5lgEHPUtn+NueUaHsypq0pnjgHXCXm6r/
 ZLzNkEP33D5U+jw8fErUu18pkeFNCpy57K+ZlYLuF54L5xsDpUGDja4nc1NIFAGPl6jv1umoG
 yHBJyyH8ao1RFOxg0eDNOaXuMeV8zbO7+nM6IXE0/A9CyUM0RO7Z6y6cWhMjTuWE30LTEBCYG
 ZkuwCrebDIM7EGlNrj3EaWlxbfEbntyu0+TEVsbSepjLnG74yynpsYXTJWBr2oNdUSwPcA9r3
 q8aV/G6Q/ilJ5xd5NMbCd8w30wy4Tv8uf8n9tJ3+YocTIcPHZKpq1uG98ro7BeLxjZwRei324
 Jst6/L7XFe8c2BmBOM5IE9ddiYPV+yQ70bKvIoTP1/y6gQRfjDOEKp7XRgpmhK0P+YNTJeB8d
 j2dn9zmOC6HxoIbKGFcBZ/ZQQoBl/AGkEwg7QnL/W4g2KAb9whOrGkSVrnw0di/gwauMVdkLx
 bcOCteQsxFLQJiH012utf8oV2r8Q+Z3IC5vxpPIUw3622MqxRdnA2MHIc0MBPRWZ3dAVYH2J3
 oESZibmOwJml875FbEtFW05CDjatoy3U6RrfMJBsv2kmaOZLhmnyzUWonm1ls1Ghno7PmpHCx
 n9hlKkzAW8T8Do6WF8lg==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 17, 2021 at 5:57 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> Loongson64 based systems are PC-like systems which use PCI/PCIe as its
> I/O bus, This patch adds the PCI host controller support for LoongArch.
>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

As discussed before, I think the PCI support should not be part of the
architecture code or this patch series. The headers are ok, but the pci.c
and acpi.c files have nothing loongarch specific in them, and you clearly
just copied most of this from arm64 or x86.

What I would suggest you do instead is:

- start a separate patch series, addressed to the ACPI, PCI host driver
  and ARM64 maintainers.

- Move all the bits you need from arch/{arm64,ia64,x86} into
  drivers/acpi/pci/pci_root.c, duplicating them with #if/#elif/#else
  where they are too different, making the #else path the
  default that can be shared with loongarch.

- Move the bits from pci_root_info/acpi_pci_root_info that are
  always needed into struct pci_host_bridge, with an
  #ifdef CONFIG_ACPI where appropriate.

- Simplify as much as you can easily do.

        Arnd
