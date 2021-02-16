Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE60231D19B
	for <lists+linux-arch@lfdr.de>; Tue, 16 Feb 2021 21:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBPUds (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Feb 2021 15:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhBPUdo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Feb 2021 15:33:44 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49170C061574;
        Tue, 16 Feb 2021 12:33:04 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id k4so11702481ybp.6;
        Tue, 16 Feb 2021 12:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HA9QSj7wELOZ8H9SPS6eF8YoQdQ/Co16H+hfPWgYYHA=;
        b=kfO2wiLPPT0I075ZfZkBaNACrvHTgJW+6BRlQYiUESKASVQzhQ+c+706HUpeDEl8PQ
         z2SIVS6nXkCaTuZ1+jPd/p0G0rT2Bnc6MiksGTibA8TJNo3yyBjBbtdAUH7TwQ8cQEhZ
         btmEXmUN1MBlhKZW6NOVLMVoDw5z8HeKKEKsS2Uzn3bEao5ByJ567HnRB+R96eDFOLNB
         aYJIJDP584gGfBecZNEmdH1qEsn65bU1A/gNBR5CxDhEmNi/AiIfjtd99E00B2ghVegb
         F6WQru3WLQzuaLwgxnpXxUANL5c7u7eCG/HgGdA/XPEgglnBMSIOKQzY+66qdxyU2Nkb
         Xi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HA9QSj7wELOZ8H9SPS6eF8YoQdQ/Co16H+hfPWgYYHA=;
        b=mdDlQmwCkxlXTKPJ3ISLEKmqp4Q5Upuyh9VVY36n/LCJ4qu+RWBSuvHuKhmlvN94aq
         T1dEQZPnztIYwSjsnddHmU/yZIk4kQHjPORLpzTfT+kuyswJGBmSx88JhURSXpXm4cLo
         oojKVqEPZWamfyDc5+TEO7znVaYtpXDTkelk6Y3DmoJmEzC1jgJee6CV+kfvJdrQiRSk
         x8dX3u+1TDGgFEdHlunbTWYEK/XwIaCAZf1jOVmDiaLQqJM5I2Dmm5T/u5MRzhTiLYq2
         D+Yz9ow1GdJO5urQSC3mEvi69orqvA+Wob6kvi3BYoI977wq9yW3Fa0aoLGCYAy1DX4P
         b1PQ==
X-Gm-Message-State: AOAM531H3fE1fDIgV7894OTA/Xkp+MIMpWrMNVfX4/dM9HTN3on2eytR
        OVj4kY6FzK6DkQnd2G2yxmyt4FmkTFTqCbwG6Fc=
X-Google-Smtp-Source: ABdhPJzkl/xVQdW9SvNUFBc3lshpirOTB/lCIkK1c9kIsdtxFWmtg9EbLB+ps+I/o79J6YKcVYiuSXJ4KicfCU0rzoo=
X-Received: by 2002:a25:d296:: with SMTP id j144mr32685000ybg.33.1613507583595;
 Tue, 16 Feb 2021 12:33:03 -0800 (PST)
MIME-Version: 1.0
References: <1613470672-3069-1-git-send-email-pnagar@codeaurora.org>
In-Reply-To: <1613470672-3069-1-git-send-email-pnagar@codeaurora.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 16 Feb 2021 21:32:52 +0100
Message-ID: <CANiq72=O0RaHVRcKFF_YDDO4xDFdxaGdH94PgvuibK-ZzHvOxA@mail.gmail.com>
Subject: Re: [PATCH] RTIC: selinux: ARM64: Move selinux_state to a separate page
To:     Preeti Nagar <pnagar@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, jmorris@namei.org, serge@hallyn.com,
        Paul Moore <paul@paul-moore.com>,
        stephen.smalley.work@gmail.com, Eric Paris <eparis@parisplace.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>,
        casey@schaufler-ca.com, Nick Desaulniers <ndesaulniers@google.com>,
        David Howells <dhowells@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>, psodagud@codeaurora.org,
        nmardana@codeaurora.org, rkavati@codeaurora.org,
        vsekhar@codeaurora.org, mreichar@codeaurora.org,
        Johan Hovold <johan@kernel.org>, Joe Perches <joe@perches.com>,
        Jessica Yu <jeyu@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 16, 2021 at 11:22 AM Preeti Nagar <pnagar@codeaurora.org> wrote:
>
> The changes introduce a new security feature, RunTime Integrity Check
> (RTIC), designed to protect Linux Kernel at runtime. The motivation
> behind these changes is:
> 1. The system protection offered by Security Enhancements(SE) for
> Android relies on the assumption of kernel integrity. If the kernel
> itself is compromised (by a perhaps as yet unknown future vulnerability),
> SE for Android security mechanisms could potentially be disabled and
> rendered ineffective.
> 2. Qualcomm Snapdragon devices use Secure Boot, which adds cryptographic
> checks to each stage of the boot-up process, to assert the authenticity
> of all secure software images that the device executes.  However, due to
> various vulnerabilities in SW modules, the integrity of the system can be
> compromised at any time after device boot-up, leading to un-authorized
> SW executing.
>
> The feature's idea is to move some sensitive kernel structures to a
> separate page and monitor further any unauthorized changes to these,
> from higher Exception Levels using stage 2 MMU. Moving these to a
> different page will help avoid getting page faults from un-related data.
> The mechanism we have been working on removes the write permissions for
> HLOS in the stage 2 page tables for the regions to be monitored, such
> that any modification attempts to these will lead to faults being
> generated and handled by handlers. If the protected assets are moved to
> a separate page, faults will be generated corresponding to change attempts
> to these assets only. If not moved to a separate page, write attempts to
> un-related data present on the monitored pages will also be generated.
>
> Using this feature, some sensitive variables of the kernel which are
> initialized after init or are updated rarely can also be protected from
> simple overwrites and attacks trying to modify these.
>
> Currently, the change moves selinux_state structure to a separate page.
> The page is 2MB aligned not 4K to avoid TLB related performance impact as,
> for some CPU core designs, the TLB does not cache 4K stage 2 (IPA to PA)
> mappings if the IPA comes from a stage 1 mapping. In future, we plan to
> move more security-related kernel assets to this page to enhance
> protection.

Part of this commit message should likely be added as a new file under
Documentation/ somewhere.

> diff --git a/security/Kconfig b/security/Kconfig
> index 7561f6f..1af913a 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -291,5 +291,16 @@ config LSM
>
>  source "security/Kconfig.hardening"
>
> +config SECURITY_RTIC
> +       bool "RunTime Integrity Check feature"
> +       depends on ARM64
> +       help
> +         RTIC(RunTime Integrity Check) feature is to protect Linux kernel
> +         at runtime. This relocates some of the security sensitive kernel
> +         structures to a separate RTIC specific page.
> +
> +         This is to enable monitoring and protection of these kernel assets
> +         from a higher exception level(EL) against any unauthorized changes.

Rewording suggestion:

         The RTIC (RunTime Integrity Check) feature protects the kernel
         at runtime by relocating some of its security-sensitive structures
         to a separate RTIC-specific page. This enables monitoring and
         and protecting them from a higher exception level against
         unauthorized changes.

Cheers,
Miguel
