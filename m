Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769AD2505D1
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 19:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgHXRWD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 13:22:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728286AbgHXRVY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 13:21:24 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB5A820838;
        Mon, 24 Aug 2020 17:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598289683;
        bh=sH+WiNnMuk0nwT4rp2dCNtqndJKdX3eBBdQnYezdNvU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2r4y2fLlZJIvd7JMQDacHVZMdE3Z4V4tBygC922SM7g2I0e8td2x/Ea1hqTRm66Dg
         Vntlz1vxnVk+en7apoqIZgadbvM/nhhPSlBihbixtytgW6FilsO8AsPp5y2s1+mFJt
         mGQxUtl6hsFQTlrSFfWE7wsiqA+K5zNVMxeXJBRI=
Received: by mail-oo1-f51.google.com with SMTP id k63so2072112oob.1;
        Mon, 24 Aug 2020 10:21:23 -0700 (PDT)
X-Gm-Message-State: AOAM532THL6FY0Y+aHKwszQnJrn/8pJWQ6LMrtB4J7tpyNpQafRYXmYj
        LAziORJRjTZnKuvNW818u274qxX7ZwVdoO2pYfk=
X-Google-Smtp-Source: ABdhPJzyH85xYIGIeBE9sN+bjxkfbXh88DkmjecqfF5cPfX7TgkE1iV7HMq8OKg0j4Fz3naiB4WzW5y7/VR72XNWa/s=
X-Received: by 2002:a4a:da4c:: with SMTP id f12mr4378791oou.41.1598289682952;
 Mon, 24 Aug 2020 10:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com> <1598287583-71762-10-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1598287583-71762-10-git-send-email-mikelley@microsoft.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 24 Aug 2020 19:21:12 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHd2vs+O6N6FeNeJeGPh=RTs++3rGms7tCd0Oy7qt3faQ@mail.gmail.com>
Message-ID: <CAMj1kXHd2vs+O6N6FeNeJeGPh=RTs++3rGms7tCd0Oy7qt3faQ@mail.gmail.com>
Subject: Re: [PATCH v7 09/10] arm64: efi: Export screen_info
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, wei.liu@kernel.org,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 24 Aug 2020 at 18:48, Michael Kelley <mikelley@microsoft.com> wrote:
>
> The Hyper-V frame buffer driver may be built as a module, and
> it needs access to screen_info. So export screen_info.
>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm64/kernel/efi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index d0cf596..8ff557a 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -55,6 +55,7 @@ static __init pteval_t create_mapping_protection(efi_memory_desc_t *md)
>
>  /* we will fill this structure from the stub, so don't put it in .bss */
>  struct screen_info screen_info __section(.data);
> +EXPORT_SYMBOL(screen_info);
>
>  int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
>  {
> --
> 1.8.3.1
>
