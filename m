Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118614103C2
	for <lists+linux-arch@lfdr.de>; Sat, 18 Sep 2021 06:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhIRE43 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Sep 2021 00:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhIRE43 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Sep 2021 00:56:29 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4E9C061574;
        Fri, 17 Sep 2021 21:55:06 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id u8so11404488vsp.1;
        Fri, 17 Sep 2021 21:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFq/Z2GV9Lte0l9PEYIOTE7ktsuCGI9xVGKYiyEv7l8=;
        b=UC2B66ry2LUE00zPMcM3CXIEdwW/tHE1hVu8rJoRKlYTruoN83kYI63GI8AY9wczVF
         kZu+ACY+nxBjHZWXVAJ85FWxfQoBdFX7pRdgXotnUbCyz9ddwyBsAFaHaRIQ8yEP0eGl
         Iw3R1QY2bpA+rocRZm7DHKHXzfKCmWNOqjBtp8v+/n8MDipyt5Rns8JjBo0PH3GQm9Hn
         aBvIz5Ik3aq1e5qEuSfPcjqXl2WF+hY7pb9djr/+wxPhBfkbBDQnHFVlOSlzgZbcFyNV
         iJhr/BlxosQlkV2n037lOO2mzBing+p1CWWBZ3Mi1/13pJOYnUCYElj7NXb19FzyhzuF
         YuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFq/Z2GV9Lte0l9PEYIOTE7ktsuCGI9xVGKYiyEv7l8=;
        b=H6VXNndOXtUr0Gxpz+OEX4IqI2WtB6SFnCRgt1W7oiHT357qpobjhdBsZx3Upnycny
         t24a6hIJ84g4GE9IJT+cuTdIez5Mu+FoicBmDxT56cUsKxOm7mHZeRPvnj1jXQ8IhoMI
         yxCRWD3DUsgAtUyKj0iZPowGbOImo//j4m1IYiXTy/vZ5vNy5+4ft8tbDUw9HCqAZh8i
         UF3L2XcHdn64W90PZ9b2JUlo2waM4RiQc8Tssmo0eiEQTRP9F+HpOfXzEc0FkHp9gf1X
         8J79nuwHSJbyuuvkEgFMcicdbpFIhogfYgEx9vIoYRP7B7s2wuw1QZLJxyA/94+aD7Q1
         XVTw==
X-Gm-Message-State: AOAM530G/c1NqBCHjUsiCm3yolpZX6XbzhqvrQCHaUxbkfN3+EIHPFXw
        KJEcGgLHT4FG+BMBc5awBvCb2W+GpULA1F6R0VM=
X-Google-Smtp-Source: ABdhPJyjzk8nTR/0NNGwA+jemoYxppUNyNdjEAV59jalNmpZ2wJbdG2sqA4lE0rkjT6gL7f2q5ToMVu4g26p1B+9K20=
X-Received: by 2002:a05:6102:e55:: with SMTP id p21mr135274vst.18.1631940904578;
 Fri, 17 Sep 2021 21:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
 <20210917035736.3934017-10-chenhuacai@loongson.cn> <CAK8P3a0BkYBoBh37YyZ1HU4f1thL6ckJR0MZhbkhpKanVK1WcQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0BkYBoBh37YyZ1HU4f1thL6ckJR0MZhbkhpKanVK1WcQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 18 Sep 2021 12:54:52 +0800
Message-ID: <CAAhV-H60MKs_gCf4ug3ACkXcDg4cGoYEQ=HchJz8+muFkrsJQA@mail.gmail.com>
Subject: Re: [PATCH V3 09/22] LoongArch: Add boot and setup routines
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
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
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Fri, Sep 17, 2021 at 4:11 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Sep 17, 2021 at 5:57 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > This patch adds basic boot, setup and reset routines for LoongArch.
> > LoongArch uses UEFI-based firmware and uses ACPI as the boot protocol.
>
> This needs to be reviewed by the maintainers for the EFI and ACPI subsystems,
> I added them to Cc here. If you add lines like
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org
>
> in the patch description before your Signed-off-by, then git-send-email will
> Cc them automatically without you having to spam them with the entire series.
OK, I will add them.

>
> In particular, I know that Ard previously complained that you did not use the
> EFI boot protocol correctly, and I want to make sure that he's happy with the
> final version.
The Correct way means efistub?  We have investigated for some time and
found that it is very difficult. E.g., our BIOS team said that they
cannot get GOP drivers for graphics cards.

>
> > +static ssize_t boardinfo_show(struct kobject *kobj,
> > +                             struct kobj_attribute *attr, char *buf)
> > +{
> > +       return sprintf(buf,
> > +               "BIOS Information\n"
> > +               "Vendor\t\t\t: %s\n"
> > +               "Version\t\t\t: %s\n"
> > +               "ROM Size\t\t: %d KB\n"
> > +               "Release Date\t\t: %s\n\n"
> > +               "Board Information\n"
> > +               "Manufacturer\t\t: %s\n"
> > +               "Board Name\t\t: %s\n"
> > +               "Family\t\t\t: LOONGSON64\n\n",
> > +               b_info.bios_vendor, b_info.bios_version,
> > +               b_info.bios_size, b_info.bios_release_date,
> > +               b_info.board_vendor, b_info.board_name);
> > +}
> > +
> > +static struct kobj_attribute boardinfo_attr = __ATTR(boardinfo, 0444,
> > +                                                    boardinfo_show, NULL);
> > +
> > +static int __init boardinfo_init(void)
> > +{
> > +       if (!efi_kobj)
> > +               return -EINVAL;
> > +
> > +       return sysfs_create_file(efi_kobj, &boardinfo_attr.attr);
> > +}
> > +late_initcall(boardinfo_init);
>
> I see you have documented this interface for your mips machines,
> but nothing else uses it.
>
> I think some of this information should be part of the soc_device,
> either in addition to, or in place of this sysfs file.
This file list something describe the motherboard, which is different
from SOC. These information are used by some user programs.

>
> Isn't there an existing method to do this on x86/arm/ia64 machines?
>
> > +static int constant_set_state_periodic(struct clock_event_device *evt)
> > +{
> > +       unsigned long period;
> > +       unsigned long timer_config;
> > +
> > +       raw_spin_lock(&state_lock);
> > +
> > +       period = const_clock_freq / HZ;
> > +       timer_config = period & CSR_TCFG_VAL;
> > +       timer_config |= (CSR_TCFG_PERIOD | CSR_TCFG_EN);
> > +       csr_writeq(timer_config, LOONGARCH_CSR_TCFG);
> > +
> > +       raw_spin_unlock(&state_lock);
>
> I see this pattern in a couple of places, using a spinlock or raw_spinlock
> to guard MMIO access, but on many architectures a register write is
> not serialized by the following spin_unlock, unless you insert another
> read from the same address in there. E.g. on PCIe, writes are always
> posted and it would not work.
>
> Can you confirm that it works correctly on CSR registers in loongarch?
CSR on LoongArch doesn't need any barrier or flush operations,
spinlock here is used to protect the whole "read, modify and write".

Huacai
>
>          Arnd
