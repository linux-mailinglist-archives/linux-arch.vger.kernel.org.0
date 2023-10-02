Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5A47B5B5F
	for <lists+linux-arch@lfdr.de>; Mon,  2 Oct 2023 21:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbjJBTfb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Oct 2023 15:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjJBTfb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2023 15:35:31 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1BAA9;
        Mon,  2 Oct 2023 12:35:28 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-49d0ee68dcaso8684e0c.1;
        Mon, 02 Oct 2023 12:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696275327; x=1696880127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/FA2EfCmaMmbb04VxL3iHHe9pNT3SUAkPZRkFN887g=;
        b=V0lkpOigC9Tka+6aTLS8pu29ESAFL7TIUPl5Tap3YS6nCtS4hA6iflJC39x99ASo1D
         I8lYn/dbeoUKOVfryKt7LPTqKD2Wjq/z+GyzYUhiDr2TLOiLuziEfPZej+lC/ozyPvBf
         NbNG4E8PadnlZ/fGhXDwiUsJFquQZaeho3Dd1fBw4jsJlqtTV9zfnnwXYN1nM+HR12Cq
         7ZG6ZXYvjETnJgFDy4sMLvtSnvK1nk1XjDG8LBQvHswJ7EfT0IcxEaIlRZJ8aVy4A9tE
         x0TJhXcuO1n4WxXpUJIV6r2dhGvLbvgq4gV/BzS8/8eKUrpVjROub/EughNQHevYNVrU
         sVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696275327; x=1696880127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/FA2EfCmaMmbb04VxL3iHHe9pNT3SUAkPZRkFN887g=;
        b=HtP8YZ2QmTCtEJ3VCXIvmIfIMPfvpepdBQTD9d87rV76BK26+tbeIgYXnyihqUA+r5
         EuTutvylNG6rqkyRmtYkHSyiDItssV+ZpIwSRLPWxRl//uaHq/QjR5LzYmfbChjiKxTP
         BfYXCRphYJsVRno6pmBAgoaYpK38TBpIQZ02+FBJJWc6v29P5dyrw6WWMeMnF8PRAG2T
         KAdWXlZctN8Xaa3hBqGs8yxjTP42gQORS9mV+iHHWASYLEHRkvJ1gZD7QrGP7SC6/zwy
         CG8++37YjhoTOJ/rfkNZxPSaMslcyR66yD/Zf5vOijk8M97GewVfGjeINRQaXsDcOv1v
         C/ug==
X-Gm-Message-State: AOJu0YxI3YaKzICtyyhvFWy/23lqAElO4lbA4nJrPbzuHOFKnhcxXOJR
        JcEOulhHKmvixdIeTv6SOtahm8FF97uk5FR0Q38=
X-Google-Smtp-Source: AGHT+IEA8aMHsmzo3NYvS8o7lDTbcS0OB4l0msAePGEiSRo8YgRWW26fxOjCvYo4qoUwF1IxuWJu8xCC3TrKG6DIM9M=
X-Received: by 2002:a05:6122:4993:b0:499:7af7:207d with SMTP id
 ex19-20020a056122499300b004997af7207dmr5484408vkb.1.1696275327064; Mon, 02
 Oct 2023 12:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-15-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1696010501-24584-15-git-send-email-nunodasneves@linux.microsoft.com>
From:   Alex Ionescu <aionescu@gmail.com>
Date:   Mon, 2 Oct 2023 15:35:16 -0400
Message-ID: <CAJ-90NKJ=FViuuy2MyA-8S1j9Lsia8bR-ytZuAr=pOPuAiO0VQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/15] asm-generic: hyperv: Use new Hyper-V headers conditionally.
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        gregkh@linuxfoundation.org, haiyangz@microsoft.com,
        decui@microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
        catalin.marinas@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Nuno,

I understand the requirement to have
undocumented/non-standard/non-TLFS-published information in the HDK
headers, however, the current state of this patch is that for any
other code that's not in the kernel today, or in this upcoming driver,
the hyperv-tlfs definitions are incomplete, because some *documented*
TLFS fields are only in HDK headers. Similarly, it is also impossible
to only use the HDK headers for other use cases, because some basic
documented, standard defines only exist in hyperv-tlfs. So there is no
"logical" relationship between the two -- HDK headers are not _just_
undocumented information, but also documented information, but also
not complete documented information.

Would you consider:

1) Updating hyperv-tlfs with all newly documented TLFS fields that are
in the HDK headers?
OR
2) Updating the new HDK headers you're adding here to also include
previously-documented information from hyperv-tlfs? This way, someone
can include the HDK headers and get everything they need
OR
3) Truly making hypertv-tlfs the "documented" header, and then
removing any duplication from HDK so that it remains the
"undocumented" header file. In this manner, one would include
hyperv-tlfs to use the stable ABI, and they would include HDK (which
would include hyperv-tlfs) to use the unstable+stable ABI.

Thank you for your consideration.

Best regards,
Alex Ionescu

On Fri, Sep 29, 2023 at 2:02=E2=80=AFPM Nuno Das Neves
<nunodasneves@linux.microsoft.com> wrote:
>
> Add asm-generic/hyperv-defs.h. It includes hyperv-tlfs.h or hvhdk.h
> depending on compile-time constant HV_HYPERV_DEFS which will be defined i=
n
> the mshv driver.
>
> This is needed to keep unstable Hyper-V interfaces independent of
> hyperv-tlfs.h. This ensures hvhdk.h replaces hyperv-tlfs.h in the mshv
> driver, even via indirect includes.
>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Acked-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/arm64/include/asm/mshyperv.h |  2 +-
>  arch/x86/include/asm/mshyperv.h   |  3 +--
>  drivers/hv/hyperv_vmbus.h         |  1 -
>  include/asm-generic/hyperv-defs.h | 26 ++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h    |  2 +-
>  include/linux/hyperv.h            |  2 +-
>  6 files changed, 30 insertions(+), 6 deletions(-)
>  create mode 100644 include/asm-generic/hyperv-defs.h
>
> diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/m=
shyperv.h
> index 20070a847304..8ec14caf3d4f 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -20,7 +20,7 @@
>
>  #include <linux/types.h>
>  #include <linux/arm-smccc.h>
> -#include <asm/hyperv-tlfs.h>
> +#include <asm-generic/hyperv-defs.h>
>
>  /*
>   * Declare calls to get and set Hyper-V VP register values on ARM64, whi=
ch
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index e3768d787065..bb1b97106cd3 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -6,10 +6,9 @@
>  #include <linux/nmi.h>
>  #include <linux/msi.h>
>  #include <linux/io.h>
> -#include <asm/hyperv-tlfs.h>
>  #include <asm/nospec-branch.h>
>  #include <asm/paravirt.h>
> -#include <asm/mshyperv.h>
> +#include <asm-generic/hyperv-defs.h>
>
>  /*
>   * Hyper-V always provides a single IO-APIC at this MMIO address.
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 09792eb4ffed..0e4bc18a13fa 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -15,7 +15,6 @@
>  #include <linux/list.h>
>  #include <linux/bitops.h>
>  #include <asm/sync_bitops.h>
> -#include <asm/hyperv-tlfs.h>
>  #include <linux/atomic.h>
>  #include <linux/hyperv.h>
>  #include <linux/interrupt.h>
> diff --git a/include/asm-generic/hyperv-defs.h b/include/asm-generic/hype=
rv-defs.h
> new file mode 100644
> index 000000000000..ac6fcba35c8c
> --- /dev/null
> +++ b/include/asm-generic/hyperv-defs.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_GENERIC_HYPERV_DEFS_H
> +#define _ASM_GENERIC_HYPERV_DEFS_H
> +
> +/*
> + * There are cases where Microsoft Hypervisor ABIs are needed which may =
not be
> + * stable or present in the Hyper-V TLFS document. E.g. the mshv_root dr=
iver.
> + *
> + * As these interfaces are unstable and may differ from hyperv-tlfs.h, t=
hey
> + * must be kept separate and independent.
> + *
> + * However, code from files that depend on hyperv-tlfs.h (such as mshype=
rv.h)
> + * is still needed, so work around the issue by conditionally including =
the
> + * correct definitions.
> + *
> + * Note: Since they are independent of each other, there are many defini=
tions
> + * duplicated in both hyperv-tlfs.h and uapi/hyperv/hv*.h files.
> + */
> +#ifdef HV_HYPERV_DEFS
> +#include <uapi/hyperv/hvhdk.h>
> +#else
> +#include <asm/hyperv-tlfs.h>
> +#endif
> +
> +#endif /* _ASM_GENERIC_HYPERV_DEFS_H */
> +
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index d832852d0ee7..6bef0d59d1b7 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -25,7 +25,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/nmi.h>
>  #include <asm/ptrace.h>
> -#include <asm/hyperv-tlfs.h>
> +#include <asm-generic/hyperv-defs.h>
>
>  #define VTPM_BASE_ADDRESS 0xfed40000
>
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 4d5a5e39d76c..722a8cf23d87 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -24,7 +24,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/interrupt.h>
>  #include <linux/reciprocal_div.h>
> -#include <asm/hyperv-tlfs.h>
> +#include <asm-generic/hyperv-defs.h>
>
>  #define MAX_PAGE_BUFFER_COUNT                          32
>  #define MAX_MULTIPAGE_BUFFER_COUNT                     32 /* 128K */
> --
> 2.25.1
>
>
