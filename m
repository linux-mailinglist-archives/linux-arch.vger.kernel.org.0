Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207EA40F3D8
	for <lists+linux-arch@lfdr.de>; Fri, 17 Sep 2021 10:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbhIQING (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Sep 2021 04:13:06 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:40981 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbhIQINE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Sep 2021 04:13:04 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MAtoX-1mcRUr2ycL-00BLqu; Fri, 17 Sep 2021 10:11:40 +0200
Received: by mail-wm1-f46.google.com with SMTP id f62-20020a1c1f41000000b0030b42643f72so1282753wmf.3;
        Fri, 17 Sep 2021 01:11:40 -0700 (PDT)
X-Gm-Message-State: AOAM531drqy4BbYmcUK2E/pc2+hOJO9tQCwdg32h/aWDgC+Qojuh1RSU
        UfC/Wm2K5+iwHVU5jBQ12a93HBlP49QMQ7ubulQ=
X-Google-Smtp-Source: ABdhPJzdLqnRgI4cH6Nyy5LXIDujO3LJsA9YmMdPik3wbbxv6tFICqff3PNBsHdiQf1eaKsTtL5RdxVWXX/UgvbQIM8=
X-Received: by 2002:a1c:23cb:: with SMTP id j194mr13725733wmj.1.1631866300248;
 Fri, 17 Sep 2021 01:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn> <20210917035736.3934017-10-chenhuacai@loongson.cn>
In-Reply-To: <20210917035736.3934017-10-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Sep 2021 10:11:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0BkYBoBh37YyZ1HU4f1thL6ckJR0MZhbkhpKanVK1WcQ@mail.gmail.com>
Message-ID: <CAK8P3a0BkYBoBh37YyZ1HU4f1thL6ckJR0MZhbkhpKanVK1WcQ@mail.gmail.com>
Subject: Re: [PATCH V3 09/22] LoongArch: Add boot and setup routines
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
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xX3+od/obibddeM4KisBEcIfw3ae01neA0i41oKlXY7PmDRQkbV
 gd7xnoQncgU5oZo1atrpKQOyYCS8qqp6pFdOmBVaY32r8RyizwNteLpzETqJFBM7+PhbJ8z
 +bJ81FyRd4cjY+DMiF/SmYD1lvNlKcQJ5YcIS559iQ8SE+VehBRYvNPcjudGHp01wcSJR1u
 ri5pDfW4OZHCcGCXkvGKA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xjcg/tARvE4=:KCXqULx1p511re317mZ7tf
 mfRWXwKw3ufYl8Q+AnV5f8x47mRIxkbUVolojz+TVRvY8xsbrb3T75uoO5lIJyfKRjORBXEXS
 9sjT4djIa9adZjCeDE6zGwfOKbASK74uaSGfBphqOF9SQwjQ2/JoeUYAWVG7a72oMGTnykIsd
 QxoPca5+LuX+fR241YLQmIjYtIp5MNauvE9Y/G7Kt5eWv+e0I25DmSKteod4wULy2YZeBMWz2
 NKd3vDFXtpyfh5fmxoWJ8oHNGUKsBymswi+5qfbVNremY5kQClIJQD1rizx4EU/Mf1Fg09pxc
 vFGG+VcagIyq1s6SxRcujVzwxEK6w7siFrRiLIiLxoiJwe04PUtE+YffLpwruzwJMilPJgW+2
 +q7L/dLqDF+dzZ1zDmnrvATCJTZrIwZiSKArubg+1l9jO52gaXNR8xaa9a/BUdWQxN1bdaAXP
 3tV4F8zcoS3wGqF7oEdK/+5yeAXpGy9WeZ5CcRko5ReBVIqzlHTPq/eqbBlTQKVbEgechP2Yo
 d6LgrzaPoLhnrNVRQ6pr7W/99ViGq7WdipQTWbvdvz4GdAEaMdilrdMN8gOuYgGPWEaGZkxXo
 PZTUjh5/UOLjofNpKJXnW0sP+1uo0whlOfQxF/kCij1kYaeDLYZN3npTYb6V51Ul8DqnQ5HCy
 USujMVq/JyADIWmH5hePb9jxs07n8xHiauzL4eWAlQY9E9sS0UPBLoDZE1yI4Z1jRg5X1uRzP
 3F7+oOv2Lp8STlt+d50spCdAhUdffET5vW8ZkLMzmqcwNW0S5tVsl96GH2/rspmZQaoIz2p03
 qCoGhVsmRuAGYmtk3iVsaTLjxgDFWkeEPKZr+NKEjgpKRZiYxJKjVXKGJFIcO1GRFImnmHzMF
 BdcEC22ZLyxVHGYNOrYQ==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 17, 2021 at 5:57 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> This patch adds basic boot, setup and reset routines for LoongArch.
> LoongArch uses UEFI-based firmware and uses ACPI as the boot protocol.

This needs to be reviewed by the maintainers for the EFI and ACPI subsystems,
I added them to Cc here. If you add lines like

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org

in the patch description before your Signed-off-by, then git-send-email will
Cc them automatically without you having to spam them with the entire series.

In particular, I know that Ard previously complained that you did not use the
EFI boot protocol correctly, and I want to make sure that he's happy with the
final version.

> +static ssize_t boardinfo_show(struct kobject *kobj,
> +                             struct kobj_attribute *attr, char *buf)
> +{
> +       return sprintf(buf,
> +               "BIOS Information\n"
> +               "Vendor\t\t\t: %s\n"
> +               "Version\t\t\t: %s\n"
> +               "ROM Size\t\t: %d KB\n"
> +               "Release Date\t\t: %s\n\n"
> +               "Board Information\n"
> +               "Manufacturer\t\t: %s\n"
> +               "Board Name\t\t: %s\n"
> +               "Family\t\t\t: LOONGSON64\n\n",
> +               b_info.bios_vendor, b_info.bios_version,
> +               b_info.bios_size, b_info.bios_release_date,
> +               b_info.board_vendor, b_info.board_name);
> +}
> +
> +static struct kobj_attribute boardinfo_attr = __ATTR(boardinfo, 0444,
> +                                                    boardinfo_show, NULL);
> +
> +static int __init boardinfo_init(void)
> +{
> +       if (!efi_kobj)
> +               return -EINVAL;
> +
> +       return sysfs_create_file(efi_kobj, &boardinfo_attr.attr);
> +}
> +late_initcall(boardinfo_init);

I see you have documented this interface for your mips machines,
but nothing else uses it.

I think some of this information should be part of the soc_device,
either in addition to, or in place of this sysfs file.

Isn't there an existing method to do this on x86/arm/ia64 machines?

> +static int constant_set_state_periodic(struct clock_event_device *evt)
> +{
> +       unsigned long period;
> +       unsigned long timer_config;
> +
> +       raw_spin_lock(&state_lock);
> +
> +       period = const_clock_freq / HZ;
> +       timer_config = period & CSR_TCFG_VAL;
> +       timer_config |= (CSR_TCFG_PERIOD | CSR_TCFG_EN);
> +       csr_writeq(timer_config, LOONGARCH_CSR_TCFG);
> +
> +       raw_spin_unlock(&state_lock);

I see this pattern in a couple of places, using a spinlock or raw_spinlock
to guard MMIO access, but on many architectures a register write is
not serialized by the following spin_unlock, unless you insert another
read from the same address in there. E.g. on PCIe, writes are always
posted and it would not work.

Can you confirm that it works correctly on CSR registers in loongarch?

         Arnd
