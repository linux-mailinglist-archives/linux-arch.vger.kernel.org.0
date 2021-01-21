Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F99F2FF4C0
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 20:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbhAUTil (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jan 2021 14:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbhAUTiK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jan 2021 14:38:10 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A39C06174A
        for <linux-arch@vger.kernel.org>; Thu, 21 Jan 2021 11:37:30 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m5so2316434pjv.5
        for <linux-arch@vger.kernel.org>; Thu, 21 Jan 2021 11:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dnk9Enykj65w83ubv86uEi6KNf5yYzMFREtVI9281dI=;
        b=JWH4tYHbk26CJuY27Dmp0A+zBeE20cqoYeOXBA+lG9CS33vCchR0H9GY3AJPMiQh6b
         xcIKigTqdsUpwDtrgRiP7W8ZkrU65NwK+EGX/Ocw7kGBuQQ/D5bN6L7iQWT3vdan7lIM
         /SbynjcuxJf9KmeIrh5SIfXHk7D6lqzOFzNCa6y/Dco1DIuwY1vNsE06WVaXCJDhcloG
         LZOc9QIK8Vsy3OFNeR62Fav/CvPwmov2OyL+ia/eJs6SFntOcO+PmbCpvcvpCVq/gGyZ
         G8I99rZfcmHeU32y/zulLUhxGYAUY3tyOn0k2bVBrIJX7NOmP3xI54CK7dyOEkBaYblD
         kYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dnk9Enykj65w83ubv86uEi6KNf5yYzMFREtVI9281dI=;
        b=WIXu9LI/aIwZlGkibImiYnQNQDDIgxyQ8ZiVhJbmsj7u1q9lB64kR4NNswlQCW3otQ
         sikuADLX41CftlZxU7UfYLjsz/EkLlGesCyqsMJPpMJ8QY36RLa7ZDe5FmVVmkJh5yCt
         0JpCKdxmRFHxYBo1DBTF/RjLkaVlR9HEK73YkGH2MuGKbkDBxXkO8Tf/Cv/Mf4zm9ri1
         jK1xAgACn9etcjgV2zX60Q8DiqE5+/8BZft2stTrrqHf+jjSusRd+Xc+ZU223Tysqd52
         41fVWQBerCDA+Dya6jZFxnbs2RNVcZifgLZOu/A+DW3QhHela8PMDX+UYxs6pzXiFG93
         6hlA==
X-Gm-Message-State: AOAM5335YVVaGNWyfbQYs/1ha69k2cwYJhWJ1GeTLoHbiqPehxWUD5fY
        y4QiCEqvi7aBtzWIy4117JQLO+NWuC5OzaBnqncui9gYaTk=
X-Google-Smtp-Source: ABdhPJz7qmwzdWABn6nile0A/tLl94zngWGEj4NQpAKrGDxcZmKeyLD1jLxvmvYbq5hgTI5PecRXT4LKsNlm2LjQLew=
X-Received: by 2002:a17:90b:30d4:: with SMTP id hi20mr1019865pjb.41.1611257849733;
 Thu, 21 Jan 2021 11:37:29 -0800 (PST)
MIME-Version: 1.0
References: <20200515171612.1020-1-catalin.marinas@arm.com> <20200515171612.1020-25-catalin.marinas@arm.com>
In-Reply-To: <20200515171612.1020-25-catalin.marinas@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 21 Jan 2021 20:37:18 +0100
Message-ID: <CAAeHK+y=8iD_nvXFFerXcZbH=pjLFQbUP_+Ftayj-t9r9h8Ghg@mail.gmail.com>
Subject: Re: [PATCH v4 24/26] arm64: mte: Introduce early param to disable MTE support
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 15, 2020 at 7:17 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> For performance analysis it may be desirable to disable MTE altogether
> via an early param. Introduce arm64.mte_disable and, if true, filter out
> the sanitised ID_AA64PFR1_EL1.MTE field to avoid exposing the HWCAP to
> user.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>
> Notes:
>     New in v4.
>
>  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>  arch/arm64/kernel/cpufeature.c                  | 11 +++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f2a93c8679e8..7436e7462b85 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -373,6 +373,10 @@
>         arcrimi=        [HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
>                         Format: <io>,<irq>,<nodeID>
>
> +       arm64.mte_disable=
> +                       [ARM64] Disable Linux support for the Memory
> +                       Tagging Extension (both user and in-kernel).
> +
>         ataflop=        [HW,M68k]
>
>         atarimouse=     [HW,MOUSE] Atari Mouse
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index aaadc1cbc006..f7596830694f 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -126,12 +126,23 @@ static void cpu_enable_cnp(struct arm64_cpu_capabilities const *cap);
>  static bool __system_matches_cap(unsigned int n);
>
>  #ifdef CONFIG_ARM64_MTE
> +static bool mte_disable;
> +
> +static int __init arm64_mte_disable(char *buf)
> +{
> +       return strtobool(buf, &mte_disable);
> +}
> +early_param("arm64.mte_disable", arm64_mte_disable);
> +
>  s64 mte_ftr_filter(const struct arm64_ftr_bits *ftrp, s64 val)
>  {
>         struct device_node *np;
>         static bool memory_checked = false;
>         static bool mte_capable = true;
>
> +       if (mte_disable)
> +               return ID_AA64PFR1_MTE_NI;
> +
>         /* EL0-only MTE is not supported by Linux, don't expose it */
>         if (val < ID_AA64PFR1_MTE)
>                 return ID_AA64PFR1_MTE_NI;

Hi Calatin,

While this patch didn't land upstream, we need an MTE kill-switch for
Android GKI. Is this patch OK to take as is? Is it still valid?

Thanks!
