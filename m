Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1572979FD9F
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 09:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjINH6D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 03:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjINH6C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 03:58:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDE71BF6;
        Thu, 14 Sep 2023 00:57:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AC2C433CA;
        Thu, 14 Sep 2023 07:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694678278;
        bh=w97jgCxmnIaSV+4bbnSk1R7YKOaENxmwU85CS3tNcPo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZhVxi3ng0SyBcUTeBMQePKCqcaLd8ethtP02v1fL+sfnyUaoKqHkq9ju2Mb2DzGmx
         12cPbr6KS37U3XQdfYDg39fefRxRGPkNAt0JcrqNuLoRrMOChzJNI4I+30xyF/Z+DO
         9uUgJtnDdJgF7nEXzChIzKYS5cn58Peg6JMWClVEEmyT8kN2TvcDY5+cWznkmtlWEO
         c1HUPT6VfSprEw7p42m6MzIVjlX2UkH0Kd4+Pu+jggh68f29rTsOMA5jm7wh31KLCT
         cO/FDvorrtEl5TBHSc2NBxToKVfMI9e/jz1tApeqdW/ft0iWrkGBooY5qJ9zwbp4IC
         8ehDh8M7Vy3CQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so9531961fa.3;
        Thu, 14 Sep 2023 00:57:58 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw+9qrEMoTR7t0idesOR0RbpI5kPq+T/PRgyFtG8hVW4gMz6vls
        x+xt8doxzKfnZHFOYXYHfc2Y77LOzwa0321qE9s=
X-Google-Smtp-Source: AGHT+IFuQtEiIDjo1DdCQY9KR6JQVDNyxLjSiMxhcLunotHqZWQic/fNmbjkP5sAIxtK7RWx3KWbiGw4//GC4psRyfI=
X-Received: by 2002:a2e:a172:0:b0:2bc:db70:b563 with SMTP id
 u18-20020a2ea172000000b002bcdb70b563mr4235801ljl.32.1694678276384; Thu, 14
 Sep 2023 00:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230913163823.7880-1-james.morse@arm.com> <20230913163823.7880-28-james.morse@arm.com>
In-Reply-To: <20230913163823.7880-28-james.morse@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 14 Sep 2023 09:57:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHRAt7ecB9p_dm3MjDL5wZkAsVh30hMY2SV_XUe=bm6Vg@mail.gmail.com>
Message-ID: <CAMj1kXHRAt7ecB9p_dm3MjDL5wZkAsVh30hMY2SV_XUe=bm6Vg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 27/35] ACPICA: Add new MADT GICC flags fields [code first?]
To:     James Morse <james.morse@arm.com>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello James,

On Wed, 13 Sept 2023 at 18:41, James Morse <james.morse@arm.com> wrote:
>
> Add the new flag field to the MADT's GICC structure.
>
> 'Online Capable' indicates a disabled CPU can be enabled later.
>

Why do we need a bit for this? What would be the point of describing
disabled CPUs that cannot be enabled (and are you are aware of
firmware doing this?).

So why are we not able to assume that this new bit can always be treated as '1'?


> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> This patch probably needs to go via the upstream acpica project,
> but is included here so the feature can be testd.
> ---
>  include/acpi/actbl2.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 3751ae69432f..c433a079d8e1 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -1046,6 +1046,7 @@ struct acpi_madt_generic_interrupt {
>  /* ACPI_MADT_ENABLED                    (1)      Processor is usable if set */
>  #define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1) /* 01: Performance Interrupt Mode */
>  #define ACPI_MADT_VGIC_IRQ_MODE         (1<<2) /* 02: VGIC Maintenance Interrupt mode */
> +#define ACPI_MADT_GICC_CPU_CAPABLE      (1<<3) /* 03: CPU is online capable */
>
>  /* 12: Generic Distributor (ACPI 5.0 + ACPI 6.0 changes) */
>
> --
> 2.39.2
>
