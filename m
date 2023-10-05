Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7207BAAB7
	for <lists+linux-arch@lfdr.de>; Thu,  5 Oct 2023 21:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjJETwT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Oct 2023 15:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJETwT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Oct 2023 15:52:19 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB33DB;
        Thu,  5 Oct 2023 12:52:17 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-49059c3e32aso206331e0c.0;
        Thu, 05 Oct 2023 12:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696535536; x=1697140336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFv1W8J14AD3Ise4CiUdt+LAXc2O9NgBdpnS7CF0MOw=;
        b=ATi9jXWw4xMpA9KLclMZTnzSXJsAT5LBJ1AqsWdfvjA/Z4S7uzuhmdr6wkjVXBfdLF
         6Gq8dQCiM4h89mzpYjLAuq+/ro0/njtwgWj4oN4AGSi7igzQ/QX1Hm2NCqmg87K91ml+
         cgJJXmAMZ4gsbeVX5DWqYc4pOJ2wbNlvaBdi2WICbEWcosho2fN8Dg+8kLTPWz6HnS7u
         zA3iFJKEqjB0sB3F+PgfPVk6hRDzG+x6hjb7hSaUMHntKOLKssiXyL5Tleqp/dvrje4M
         rNpV1vHl+Or7g1ti+sjZmgpfVY0pJAjI5FJlc1K369MWGuCOe+R9EtXeQxpsfCmtikSV
         F0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696535536; x=1697140336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFv1W8J14AD3Ise4CiUdt+LAXc2O9NgBdpnS7CF0MOw=;
        b=oz72OTcPtyJD0j1Kuqe5uM89G5xpjycfYBZc5FuBg0IYjHSZTDrwt41ikUwKLY2HRC
         WJBlALrsjd0b3Umk590O+vBKk4wRMWQ1hVFAORvbogkxJGmdPks5oEccJa1xO9kpi6ex
         wqrBMyiazXnApa0EJMMYIoBEcetqsfIFaqXZYx1rbrDrnV6m+0Bi+a8x3oW5+tqQ4hpD
         sCeUDfB4KfT0sHmwoGVXVSRKLtvCiTZdmSRjKkujM/JBDkOTMYTf1fOvfpfzeJpaGBzT
         hTxdyMi1qcJNFCZdCthAe01cKMkJlvPxmGxp7T9Ads2Aq2pO4E2bkoZBTpPkFM5brA7L
         98wg==
X-Gm-Message-State: AOJu0Ywy6irDCc6W0zitdcQrdNmtzI5Bhdf+5NQ2fbbakqu9oZa9vX1G
        iScgNaQt7zir4LUr+4CI1g9pHG615PxuyLFqfUg=
X-Google-Smtp-Source: AGHT+IGuTEUd8dTcZeTkWYWW1mW8fz4C0ldWo8Lj3yVO2SdMwh2H3DKmTh7Vq/QEWb3sKS/10VY7YdkhsNuEyc3Q0n4=
X-Received: by 2002:a1f:6e85:0:b0:49b:9510:1f94 with SMTP id
 j127-20020a1f6e85000000b0049b95101f94mr4097701vkc.1.1696535536308; Thu, 05
 Oct 2023 12:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-15-git-send-email-nunodasneves@linux.microsoft.com>
 <CAJ-90NKJ=FViuuy2MyA-8S1j9Lsia8bR-ytZuAr=pOPuAiO0VQ@mail.gmail.com> <749f477a-1e7a-495e-bea1-e3abe8da7fb9@linux.microsoft.com>
In-Reply-To: <749f477a-1e7a-495e-bea1-e3abe8da7fb9@linux.microsoft.com>
From:   Alex Ionescu <aionescu@gmail.com>
Date:   Thu, 5 Oct 2023 15:52:04 -0400
Message-ID: <CAJ-90NL8S5xnJbiwCHAGs4QeiJ3DHUL0Obi1snqsTDJEpQRnsg@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Nuno,

Best regards,
Alex Ionescu

On Mon, Oct 2, 2023 at 8:41=E2=80=AFPM Nuno Das Neves
<nunodasneves@linux.microsoft.com> wrote:
>
> Hi Alex,
>
> On 10/2/2023 12:35 PM, Alex Ionescu wrote:
> > Hi Nuno,
> >
> > I understand the requirement to have
> > undocumented/non-standard/non-TLFS-published information in the HDK
> > headers, however, the current state of this patch is that for any
> > other code that's not in the kernel today, or in this upcoming driver,
> > the hyperv-tlfs definitions are incomplete, because some *documented*
> > TLFS fields are only in HDK headers. Similarly, it is also impossible
>
> If I understand correctly, you are saying there are documented
> definitions (in the TLFS document), which are NOT in hyperv-tlfs.h, but
> ARE in these new HDK headers, correct?

Correct.

>
> If these are needed elsewhere in the kernel, they can just be added to
> hyperv-tlfs.h.

OK, great, As the need arises I will submit patches here to do so (and
source the TLFS page/paragraph as needed to help provide they're in
there). Thank you!

>
> > to only use the HDK headers for other use cases, because some basic
> > documented, standard defines only exist in hyperv-tlfs. So there is no
> > "logical" relationship between the two -- HDK headers are not _just_
> > undocumented information, but also documented information, but also
> > not complete documented information.
>
> That is correct - they are meant to be independently compileable.
> The new HDK headers only serve as a replacement *in our driver* when we
> need some definitions like do_hypercall() etc in mshyperv.h.

Understood.

>
> >
> > Would you consider:
> >
> > 1) Updating hyperv-tlfs with all newly documented TLFS fields that are
> > in the HDK headers?
>
> I think this can be done on an as-needed basis, as I outlined above.

Sounds good.

>
> > OR
> > 2) Updating the new HDK headers you're adding here to also include
> > previously-documented information from hyperv-tlfs? This way, someone
> > can include the HDK headers and get everything they need
>
> The new HDK headers are only intended for the new mshv driver.
>
> > OR
> > 3) Truly making hypertv-tlfs the "documented" header, and then > removi=
ng any duplication from HDK so that it remains the
> > "undocumented" header file. In this manner, one would include
> > hyperv-tlfs to use the stable ABI, and they would include HDK (which
> > would include hyperv-tlfs) to use the unstable+stable ABI.
>
> hyperv-tlfs.h is remaining the "documented" header.
>
> But, we can't make the HDK header depend on hyperv-tlfs.h, for 2 primary
> reasons:
> 1. We need to put the new HDK headers in uapi so that we can use them in
> our IOCTL interface. As a result, we can't include hyperv-tlfs.h (unless
> we put it in uapi as well).
> 2. The HDK headers not only duplicate, but also MODIFY some structures
> in hyperv-tlfs.h. e.g., The struct is in hyperv-tlfs.h, but a particular
> field or bitfield is not.

#2 was something I was worried about. Do you know if the
standards/docs team is planning on updating the TLFS at some point
with updates on their end? At which point I'd assume you'd be OK with
patches to add them to hyperv-tlfs.h

Thanks a lot!

--
Best regards,
Alex Ionescu

>
> Thanks,
> Nuno
>
> >
> > Thank you for your consideration.
> >
> > Best regards,
> > Alex Ionescu
> >
> > On Fri, Sep 29, 2023 at 2:02=E2=80=AFPM Nuno Das Neves
> > <nunodasneves@linux.microsoft.com> wrote:
> >>
> >> Add asm-generic/hyperv-defs.h. It includes hyperv-tlfs.h or hvhdk.h
> >> depending on compile-time constant HV_HYPERV_DEFS which will be define=
d in
> >> the mshv driver.
> >>
> >> This is needed to keep unstable Hyper-V interfaces independent of
> >> hyperv-tlfs.h. This ensures hvhdk.h replaces hyperv-tlfs.h in the mshv
> >> driver, even via indirect includes.
> >>
> >> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> >> Acked-by: Wei Liu <wei.liu@kernel.org>
> >> ---
> >>   arch/arm64/include/asm/mshyperv.h |  2 +-
> >>   arch/x86/include/asm/mshyperv.h   |  3 +--
> >>   drivers/hv/hyperv_vmbus.h         |  1 -
> >>   include/asm-generic/hyperv-defs.h | 26 ++++++++++++++++++++++++++
> >>   include/asm-generic/mshyperv.h    |  2 +-
> >>   include/linux/hyperv.h            |  2 +-
> >>   6 files changed, 30 insertions(+), 6 deletions(-)
> >>   create mode 100644 include/asm-generic/hyperv-defs.h
> >>
> >> diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/as=
m/mshyperv.h
> >> index 20070a847304..8ec14caf3d4f 100644
> >> --- a/arch/arm64/include/asm/mshyperv.h
> >> +++ b/arch/arm64/include/asm/mshyperv.h
> >> @@ -20,7 +20,7 @@
> >>
> >>   #include <linux/types.h>
> >>   #include <linux/arm-smccc.h>
> >> -#include <asm/hyperv-tlfs.h>
> >> +#include <asm-generic/hyperv-defs.h>
> >>
> >>   /*
> >>    * Declare calls to get and set Hyper-V VP register values on ARM64,=
 which
> >> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/ms=
hyperv.h
> >> index e3768d787065..bb1b97106cd3 100644
> >> --- a/arch/x86/include/asm/mshyperv.h
> >> +++ b/arch/x86/include/asm/mshyperv.h
> >> @@ -6,10 +6,9 @@
> >>   #include <linux/nmi.h>
> >>   #include <linux/msi.h>
> >>   #include <linux/io.h>
> >> -#include <asm/hyperv-tlfs.h>
> >>   #include <asm/nospec-branch.h>
> >>   #include <asm/paravirt.h>
> >> -#include <asm/mshyperv.h>
> >> +#include <asm-generic/hyperv-defs.h>
> >>
> >>   /*
> >>    * Hyper-V always provides a single IO-APIC at this MMIO address.
> >> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> >> index 09792eb4ffed..0e4bc18a13fa 100644
> >> --- a/drivers/hv/hyperv_vmbus.h
> >> +++ b/drivers/hv/hyperv_vmbus.h
> >> @@ -15,7 +15,6 @@
> >>   #include <linux/list.h>
> >>   #include <linux/bitops.h>
> >>   #include <asm/sync_bitops.h>
> >> -#include <asm/hyperv-tlfs.h>
> >>   #include <linux/atomic.h>
> >>   #include <linux/hyperv.h>
> >>   #include <linux/interrupt.h>
> >> diff --git a/include/asm-generic/hyperv-defs.h b/include/asm-generic/h=
yperv-defs.h
> >> new file mode 100644
> >> index 000000000000..ac6fcba35c8c
> >> --- /dev/null
> >> +++ b/include/asm-generic/hyperv-defs.h
> >> @@ -0,0 +1,26 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +#ifndef _ASM_GENERIC_HYPERV_DEFS_H
> >> +#define _ASM_GENERIC_HYPERV_DEFS_H
> >> +
> >> +/*
> >> + * There are cases where Microsoft Hypervisor ABIs are needed which m=
ay not be
> >> + * stable or present in the Hyper-V TLFS document. E.g. the mshv_root=
 driver.
> >> + *
> >> + * As these interfaces are unstable and may differ from hyperv-tlfs.h=
, they
> >> + * must be kept separate and independent.
> >> + *
> >> + * However, code from files that depend on hyperv-tlfs.h (such as msh=
yperv.h)
> >> + * is still needed, so work around the issue by conditionally includi=
ng the
> >> + * correct definitions.
> >> + *
> >> + * Note: Since they are independent of each other, there are many def=
initions
> >> + * duplicated in both hyperv-tlfs.h and uapi/hyperv/hv*.h files.
> >> + */
> >> +#ifdef HV_HYPERV_DEFS
> >> +#include <uapi/hyperv/hvhdk.h>
> >> +#else
> >> +#include <asm/hyperv-tlfs.h>
> >> +#endif
> >> +
> >> +#endif /* _ASM_GENERIC_HYPERV_DEFS_H */
> >> +
> >> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshy=
perv.h
> >> index d832852d0ee7..6bef0d59d1b7 100644
> >> --- a/include/asm-generic/mshyperv.h
> >> +++ b/include/asm-generic/mshyperv.h
> >> @@ -25,7 +25,7 @@
> >>   #include <linux/cpumask.h>
> >>   #include <linux/nmi.h>
> >>   #include <asm/ptrace.h>
> >> -#include <asm/hyperv-tlfs.h>
> >> +#include <asm-generic/hyperv-defs.h>
> >>
> >>   #define VTPM_BASE_ADDRESS 0xfed40000
> >>
> >> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> >> index 4d5a5e39d76c..722a8cf23d87 100644
> >> --- a/include/linux/hyperv.h
> >> +++ b/include/linux/hyperv.h
> >> @@ -24,7 +24,7 @@
> >>   #include <linux/mod_devicetable.h>
> >>   #include <linux/interrupt.h>
> >>   #include <linux/reciprocal_div.h>
> >> -#include <asm/hyperv-tlfs.h>
> >> +#include <asm-generic/hyperv-defs.h>
> >>
> >>   #define MAX_PAGE_BUFFER_COUNT                          32
> >>   #define MAX_MULTIPAGE_BUFFER_COUNT                     32 /* 128K */
> >> --
> >> 2.25.1
> >>
> >>
>
