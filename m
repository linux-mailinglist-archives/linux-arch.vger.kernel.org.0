Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221CD53C42F
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 07:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240413AbiFCF1P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 01:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbiFCF1N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 01:27:13 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DBF17E02;
        Thu,  2 Jun 2022 22:27:11 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id f7so5022571ilr.5;
        Thu, 02 Jun 2022 22:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oGb27Ak0z2Rkt5N/UACfnN99nvmSQ69B5OG+/UGAQLM=;
        b=qjUHwWtDO6aI7Fmssc++fi3v4jwxDc0kJYEk1vDRyhGSso7W1ZkZFSkqajhql3wNEA
         M5hmNYlaxDWWcrdcotJ+aZvuYIgBgoNZnbJqss8yvTjzrr5UHsYCVWIbgQjNyjKS9yN6
         XSKnbUokIFEYVUfpi3gmuc6AO5GGBQNmpL6wcya0hBiCkvePk92MFbN9gnDfCn2W3k4f
         vq1rvXMWPW0B7BL7G933m6hgdw0D7VNfTLmJlN4fW75Y10i/xYRMQNCu97jekuzCDAqs
         cca8vUxo3bCj1ChZ5wzKSgv4o3wQ5IImVCu8YJHpNeNh9fhcVjXcEIZZgSfmXv42OxgH
         Ya/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oGb27Ak0z2Rkt5N/UACfnN99nvmSQ69B5OG+/UGAQLM=;
        b=dTclK/5SghxYRy4NUYOCYrqjwD6uMqX03rOGiV/knH9pbP6Yvpyl/T37LaNJ0GXEgR
         cGr4KgLSvfKhAinDYdFyFDoLnV2d932BaPpHDuYvwK+OpHwUl1m0nFTZcs/hwp7/9wSK
         MOE2r0caDKICCda8u+NoNrkE43TpdbGVzE17nlsJc/A4YaRKSykeMlixhkfskXUIFz6O
         HguW8Wvl5oLiyl0iNvX0TruGLH7dDGb9Rpi4wP+q9XGxK7YSbPLBlXyuio10TNjFkxF6
         BiNk1jqmL6ZIG2h/UG2P++u3xDoTkLg6HIzBU6enB64rB2VcxejymuP9HIJQnRm1ePWr
         wNig==
X-Gm-Message-State: AOAM532yI0k6vOVh1bV6dlaXV6jYbxqmLsOU+OeEIVjn/RuDOf2QcN2G
        G7MiKlgA4dssPWdYqigs4FUyV1w71RxCJdELujM=
X-Google-Smtp-Source: ABdhPJxTxG2jY7cybAXHG6BSEzYABkT93h++rypNIN3GXMjB+z1lq7/A/l4005ZP15S5fZveJqS40vrOm/RZYuEXguM=
X-Received: by 2002:a05:6638:4407:b0:331:692c:1d5f with SMTP id
 bp7-20020a056638440700b00331692c1d5fmr3236731jab.208.1654234030909; Thu, 02
 Jun 2022 22:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220602115141.3962749-1-chenhuacai@loongson.cn>
 <20220602115141.3962749-4-chenhuacai@loongson.cn> <YplnruNz++gABlU0@debian.me>
In-Reply-To: <YplnruNz++gABlU0@debian.me>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 3 Jun 2022 13:27:00 +0800
Message-ID: <CAAhV-H5Hi_gYvrO6DAGGA=OVExunCubNpDBdkRBxFxiP1APAKw@mail.gmail.com>
Subject: Re: [PATCH V14 03/24] Documentation: LoongArch: Add basic documentations
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Bagas,

On Fri, Jun 3, 2022 at 9:45 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Thu, Jun 02, 2022 at 07:51:20PM +0800, Huacai Chen wrote:
> > +Legacy IRQ model
> > +================
> > +
> > +In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer interrupt go
> > +to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, while all other devices
> > +interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and gathered by HTVECINTC, and then go
> > +to LIOINTC, and then CPUINTC.
> > +
> > + +---------------------------------------------+
> > + |::                                           |
> > + |                                             |
> > + |    +-----+     +---------+     +-------+    |
> > + |    | IPI | --> | CPUINTC | <-- | Timer |    |
> > + |    +-----+     +---------+     +-------+    |
> > + |                     ^                       |
> > + |                     |                       |
> > + |                +---------+     +-------+    |
> > + |                | LIOINTC | <-- | UARTs |    |
> > + |                +---------+     +-------+    |
> > + |                     ^                       |
> > + |                     |                       |
> > + |               +-----------+                 |
> > + |               | HTVECINTC |                 |
> > + |               +-----------+                 |
> > + |                ^         ^                  |
> > + |                |         |                  |
> > + |          +---------+ +---------+            |
> > + |          | PCH-PIC | | PCH-MSI |            |
> > + |          +---------+ +---------+            |
> > + |            ^     ^           ^              |
> > + |            |     |           |              |
> > + |    +---------+ +---------+ +---------+      |
> > + |    | PCH-LPC | | Devices | | Devices |      |
> > + |    +---------+ +---------+ +---------+      |
> > + |         ^                                   |
> > + |         |                                   |
> > + |    +---------+                              |
> > + |    | Devices |                              |
> > + |    +---------+                              |
> > + |                                             |
> > + |                                             |
> > + +---------------------------------------------+
> > +
> > +Extended IRQ model
> > +==================
> > +
> > +In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer interrupt go
> > +to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, while all other devices
> > +interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and gathered by EIOINTC, and then go to
> > +to CPUINTC directly.
> > +
> > + +--------------------------------------------------------+
> > + |::                                                      |
> > + |                                                        |
> > + |         +-----+     +---------+     +-------+          |
> > + |         | IPI | --> | CPUINTC | <-- | Timer |          |
> > + |         +-----+     +---------+     +-------+          |
> > + |                      ^       ^                         |
> > + |                      |       |                         |
> > + |               +---------+ +---------+     +-------+    |
> > + |               | EIOINTC | | LIOINTC | <-- | UARTs |    |
> > + |               +---------+ +---------+     +-------+    |
> > + |                ^       ^                               |
> > + |                |       |                               |
> > + |         +---------+ +---------+                        |
> > + |         | PCH-PIC | | PCH-MSI |                        |
> > + |         +---------+ +---------+                        |
> > + |           ^     ^           ^                          |
> > + |           |     |           |                          |
> > + |   +---------+ +---------+ +---------+                  |
> > + |   | PCH-LPC | | Devices | | Devices |                  |
> > + |   +---------+ +---------+ +---------+                  |
> > + |        ^                                               |
> > + |        |                                               |
> > + |   +---------+                                          |
> > + |   | Devices |                                          |
> > + |   +---------+                                          |
> > + |                                                        |
> > + |                                                        |
> > + +--------------------------------------------------------+
> > +
>
> I think for consistency with other diagrams in Documentation/, just use
> literal code block, like:
>
> diff --git a/Documentation/loongarch/irq-chip-model.rst b/Documentation/loongarch/irq-chip-model.rst
> index 35c962991283ff..3cfd528021de05 100644
> --- a/Documentation/loongarch/irq-chip-model.rst
> +++ b/Documentation/loongarch/irq-chip-model.rst
> @@ -24,40 +24,38 @@ to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, while all other devices
>  interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and gathered by HTVECINTC, and then go
>  to LIOINTC, and then CPUINTC.
>
> - +---------------------------------------------+
> - |::                                           |
> - |                                             |
> - |    +-----+     +---------+     +-------+    |
> - |    | IPI | --> | CPUINTC | <-- | Timer |    |
> - |    +-----+     +---------+     +-------+    |
> - |                     ^                       |
> - |                     |                       |
> - |                +---------+     +-------+    |
> - |                | LIOINTC | <-- | UARTs |    |
> - |                +---------+     +-------+    |
> - |                     ^                       |
> - |                     |                       |
> - |               +-----------+                 |
> - |               | HTVECINTC |                 |
> - |               +-----------+                 |
> - |                ^         ^                  |
> - |                |         |                  |
> - |          +---------+ +---------+            |
> - |          | PCH-PIC | | PCH-MSI |            |
> - |          +---------+ +---------+            |
> - |            ^     ^           ^              |
> - |            |     |           |              |
> - |    +---------+ +---------+ +---------+      |
> - |    | PCH-LPC | | Devices | | Devices |      |
> - |    +---------+ +---------+ +---------+      |
> - |         ^                                   |
> - |         |                                   |
> - |    +---------+                              |
> - |    | Devices |                              |
> - |    +---------+                              |
> - |                                             |
> - |                                             |
> - +---------------------------------------------+
> + ::
> +
> +     +-----+     +---------+     +-------+
> +     | IPI | --> | CPUINTC | <-- | Timer |
> +     +-----+     +---------+     +-------+
> +                      ^
> +                      |
> +                 +---------+     +-------+
> +                 | LIOINTC | <-- | UARTs |
> +                 +---------+     +-------+
> +                      ^
> +                      |
> +                +-----------+
> +                | HTVECINTC |
> +                +-----------+
> +                 ^         ^
> +                 |         |
> +           +---------+ +---------+
> +           | PCH-PIC | | PCH-MSI |
> +           +---------+ +---------+
> +             ^     ^           ^
> +             |     |           |
> +     +---------+ +---------+ +---------+
> +     | PCH-LPC | | Devices | | Devices |
> +     +---------+ +---------+ +---------+
> +          ^
> +          |
> +     +---------+
> +     | Devices |
> +     +---------+
> +
> +
>
>  Extended IRQ model
>  ==================
> @@ -67,35 +65,33 @@ to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, while all other devices
>  interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and gathered by EIOINTC, and then go to
>  to CPUINTC directly.
>
> - +--------------------------------------------------------+
> - |::                                                      |
> - |                                                        |
> - |         +-----+     +---------+     +-------+          |
> - |         | IPI | --> | CPUINTC | <-- | Timer |          |
> - |         +-----+     +---------+     +-------+          |
> - |                      ^       ^                         |
> - |                      |       |                         |
> - |               +---------+ +---------+     +-------+    |
> - |               | EIOINTC | | LIOINTC | <-- | UARTs |    |
> - |               +---------+ +---------+     +-------+    |
> - |                ^       ^                               |
> - |                |       |                               |
> - |         +---------+ +---------+                        |
> - |         | PCH-PIC | | PCH-MSI |                        |
> - |         +---------+ +---------+                        |
> - |           ^     ^           ^                          |
> - |           |     |           |                          |
> - |   +---------+ +---------+ +---------+                  |
> - |   | PCH-LPC | | Devices | | Devices |                  |
> - |   +---------+ +---------+ +---------+                  |
> - |        ^                                               |
> - |        |                                               |
> - |   +---------+                                          |
> - |   | Devices |                                          |
> - |   +---------+                                          |
> - |                                                        |
> - |                                                        |
> - +--------------------------------------------------------+
> + ::
> +
> +          +-----+     +---------+     +-------+
> +          | IPI | --> | CPUINTC | <-- | Timer |
> +          +-----+     +---------+     +-------+
> +                       ^       ^
> +                       |       |
> +                +---------+ +---------+     +-------+
> +                | EIOINTC | | LIOINTC | <-- | UARTs |
> +                +---------+ +---------+     +-------+
> +                 ^       ^
> +                 |       |
> +          +---------+ +---------+
> +          | PCH-PIC | | PCH-MSI |
> +          +---------+ +---------+
> +            ^     ^           ^
> +            |     |           |
> +    +---------+ +---------+ +---------+
> +    | PCH-LPC | | Devices | | Devices |
> +    +---------+ +---------+ +---------+
> +         ^
> +         |
> +    +---------+
> +    | Devices |
> +    +---------+
> +
> +
>
>  ACPI-related definitions
>  ========================
>
> Otherwise, htmldocs builds successfully without any new warnings related
> to this patch series.
Thank you for your testing. In my environment (sphinx_2.4.4), with or
without the border both have no warnings. :)
And I think these are more pretty if we keep the border, especially
when formatted into PDF. How do you think?

Huacai
>
> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
>
> --
> An old man doll... just what I always wanted! - Clara
