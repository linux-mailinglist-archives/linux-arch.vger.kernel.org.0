Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C29E948F4
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2019 17:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfHSPr0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 11:47:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39468 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfHSPr0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 11:47:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so1388154pfn.6
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GVKhbnPbpjWbhz5xDYatb5Jf0xezOaFTSU5iPuDRTeo=;
        b=hb156RXeMFMq/ZFBxV79hUwsJ33TBPwNChB7tz9IM49HqYq3bFTECBQ0jWs93GlT2G
         SEOQohdK8Qpvg992CDM37AZOCtspic82CV7MxeJ16y4n+GAIARuDtkAqM0Vpcs5ugO59
         3sRkxC82ZNpPiJFiSjHCE8xFRcNyFvlrnKXcUERASk/OU7gh9oUuKntlcF8+9VOgRdQO
         XwzHDLp8GeaF9DmG79eL+xmRZIDuOI163umv7VF+AUJ3CNUJ8QSO3555UzdSqQRzm98/
         M6E4uyzHKgmn+l3ROAiDQuvOoBKPpaBx3AvAN7T4WwNWZXw8eHWQZ7MH/qOuEtyRVpnD
         8p+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVKhbnPbpjWbhz5xDYatb5Jf0xezOaFTSU5iPuDRTeo=;
        b=mztSnEN40pJ3xeR4j2BHFBt0zoxQW8paKaQqLhzZCKQt1Sa87r5Zi70+XM+qCVTMRG
         r5xpcLXZqCKq0TKXT+G7Hrezy20a1IWQEN3wDseHdGGt6VVn+54vkBfi94inVyXJHAVS
         7f9ouZzVjrgAEl5Lq8TKpnjd091HW9ifh0O9IuYo1fKl6cmyEvUxBIjYTYUR2II8RnC+
         yL0X7o2xSaE3xYzKAO0EPml2/dm/mWTB81JRCXuuzji/CW0GBUrlQi6qX3ccSP3XnxvV
         NBAHun1xgjZp/fZrRUUw5jZ9muw8j7FwnXAHK5uHRUL7CJV3RZFV1L6HRVi7qW5JVeL2
         6CxA==
X-Gm-Message-State: APjAAAV0KKk4atffYfmpUNjjY2RNgsuRZm9lM9aNdmUgiCbi86OX6yqi
        lqWNeLsgTk3kYc7ATYXPYo/cttUaux7v3VLotQfxdQ==
X-Google-Smtp-Source: APXvYqxLTHM5LEFPfn7KCCEc2GvHDBYCQbwS1b0CfA10FVE2b1wMY/bojyivxbvU4UFTnmGkD/DFGafc0BRQouvpbVg=
X-Received: by 2002:a17:90a:858c:: with SMTP id m12mr21540803pjn.129.1566229645488;
 Mon, 19 Aug 2019 08:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190815154403.16473-1-catalin.marinas@arm.com> <20190815154403.16473-4-catalin.marinas@arm.com>
In-Reply-To: <20190815154403.16473-4-catalin.marinas@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 19 Aug 2019 17:47:14 +0200
Message-ID: <CAAeHK+wSw6x8EpPc5-7tBnxEjKfYGfH6mUEh013YjKBCy40AZA@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] arm64: Change the tagged_addr sysctl control
 semantics to only prevent the opt-in
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 15, 2019 at 5:44 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> First rename the sysctl control to abi.tagged_addr_disabled and make it
> default off (zero). When abi.tagged_addr_disabled == 1, only block the
> enabling of the TBI ABI via prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE).
> Getting the status of the ABI or disabling it is still allowed.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Andrey Konovalov <andreyknvl@google.com>

> ---
>  arch/arm64/kernel/process.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 76b7c55026aa..03689c0beb34 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -579,17 +579,22 @@ void arch_setup_new_exec(void)
>  /*
>   * Control the relaxed ABI allowing tagged user addresses into the kernel.
>   */
> -static unsigned int tagged_addr_prctl_allowed = 1;
> +static unsigned int tagged_addr_disabled;
>
>  long set_tagged_addr_ctrl(unsigned long arg)
>  {
> -       if (!tagged_addr_prctl_allowed)
> -               return -EINVAL;
>         if (is_compat_task())
>                 return -EINVAL;
>         if (arg & ~PR_TAGGED_ADDR_ENABLE)
>                 return -EINVAL;
>
> +       /*
> +        * Do not allow the enabling of the tagged address ABI if globally
> +        * disabled via sysctl abi.tagged_addr_disabled.
> +        */
> +       if (arg & PR_TAGGED_ADDR_ENABLE && tagged_addr_disabled)
> +               return -EINVAL;
> +
>         update_thread_flag(TIF_TAGGED_ADDR, arg & PR_TAGGED_ADDR_ENABLE);
>
>         return 0;
> @@ -597,8 +602,6 @@ long set_tagged_addr_ctrl(unsigned long arg)
>
>  long get_tagged_addr_ctrl(void)
>  {
> -       if (!tagged_addr_prctl_allowed)
> -               return -EINVAL;
>         if (is_compat_task())
>                 return -EINVAL;
>
> @@ -618,9 +621,9 @@ static int one = 1;
>
>  static struct ctl_table tagged_addr_sysctl_table[] = {
>         {
> -               .procname       = "tagged_addr",
> +               .procname       = "tagged_addr_disabled",
>                 .mode           = 0644,
> -               .data           = &tagged_addr_prctl_allowed,
> +               .data           = &tagged_addr_disabled,
>                 .maxlen         = sizeof(int),
>                 .proc_handler   = proc_dointvec_minmax,
>                 .extra1         = &zero,
