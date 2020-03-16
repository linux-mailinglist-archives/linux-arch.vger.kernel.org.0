Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 281651866E0
	for <lists+linux-arch@lfdr.de>; Mon, 16 Mar 2020 09:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgCPIsR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Mar 2020 04:48:17 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:57731 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730075AbgCPIsR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Mar 2020 04:48:17 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MC2o9-1j1LE32CGj-00CP7u; Mon, 16 Mar 2020 09:48:14 +0100
Received: by mail-qk1-f179.google.com with SMTP id q17so53282qki.0;
        Mon, 16 Mar 2020 01:48:14 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2sQq79nLvQREcZiQTvcnVO0Jdy3o0UnsCRASSgMAj0l/BtrS10
        YJOGfusQrr3a4H8nIf+9BZC/D/iNBAYkARzkl1Y=
X-Google-Smtp-Source: ADFU+vvOY/BGxo7kSvcD97t4Z1vQUfkOL22qs/tI6hULqTssDTO2tyghsLEAxf/j8ykiL2awuFtXPZNlBwPgv73H9fE=
X-Received: by 2002:a37:b984:: with SMTP id j126mr23783692qkf.3.1584348493133;
 Mon, 16 Mar 2020 01:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com> <1584200119-18594-2-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1584200119-18594-2-git-send-email-mikelley@microsoft.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 16 Mar 2020 09:47:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1GFDUY4mXzst4Ds+S-4SGXso6-jfpsYyy-eHyceAC1Zg@mail.gmail.com>
Message-ID: <CAK8P3a1GFDUY4mXzst4Ds+S-4SGXso6-jfpsYyy-eHyceAC1Zg@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] arm64: hyperv: Add core Hyper-V include files
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, olaf@aepfle.de,
        Andy Whitcroft <apw@canonical.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jason Wang <jasowang@redhat.com>, marcelo.cerri@canonical.com,
        "K. Y. Srinivasan" <kys@microsoft.com>, sunilmut@microsoft.com,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:vJNFxqx7xMrPQ5nbEdJ3fk0xh0usEdIXP0e2LvvLfoJAW0tqWmy
 lm27DXlP2eYMLTCYlsu5IPgelnN34aLGlK9m+GD7ASAHIL1oP6nhS56y5EUD87OKQirRtQE
 uU8pitB/HueuQ2H+J0HD8SdedXOVlXnVB3XC594ySF+Ol+GJEreY6U0+3YsUGZPHtLuoJGF
 pVTbI/M9wb0YV8Jbx8ZGg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:78s2dhzdfOA=:cQdWSYSu57O9iLoiyga1fQ
 v2AZBQtOdlFxN9nndNnuFTP/oVl0pHX5OYFHV9WmQS94V17OQ6alBWTl5CDRBZUhNKaEOw5MC
 F9rj23uQtjXUQ0Fbr5AbPIGZr1wKZi3p5IOr0mcJlEJt3RQ52mjuo/+Eou52HITgvaFnlee0b
 PwWJZbDFS6DHhdSSfBuUq/it5B+VgSquMGGgWnVDjfRKrxdXZ9Rr588a0RDKV7DfouJN9rfwa
 xhT14QgochMqD3/E6eLQaSDkK3pGuCjnNbqxFeJ+580nEbNrF8nFL4JWAAo6w1SKU4q+2nwR+
 7fovTKMCtxTdSnkq5uV0M9Gf8qiWjmkXL3NJFYRd9U30clKb8c+M0fQLaRSt/C9kN1DvrwGI8
 wG4hdVSW95j6H/IVaFhdagoLxinO2q6OM+zgowCxrAgklC2bBSYZxFsxnKfMlJjgUxkzEVOj4
 BLpVdAR85jlo9oNt5fXnr3tDUddC43/kfYYpRH8eSRYHTUy5CydufiC5coo70wkUq+jH28RsL
 DJRhDAxlulfbiiWPeJkxVVxId7GU6PVUg3AfPjo7yacxa+kWAoGXlP0U6s2WNT46OsB3OyI0s
 qiL+NrzIYz2qcLDMAdYC4b2r1gA7lB+qk7CjUOgFEAjDIkzjcJ0KGdn0TsSE67oBCJSAifXSw
 fKPEbZmGUOx1zEka2xw8ICszwV4oEVRi19tXXuiW9EcDNswL5TxbRTLtH0G27zynI20ZMBioI
 y5+KgGkf11ktXaroHqqC/Lp9R5ryHpU9P5b4bjHl8DLhetv86e0mBt6XwVw78LqMGliuoi7/k
 TkOtekCf2mpPjLLRdO3zs/cwTVAc3zh5OETRy+OuGi1AuYMwOo=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 14, 2020 at 4:36 PM Michael Kelley <mikelley@microsoft.com> wrote:

> +
> +/* Define input and output layout for Get VP Register hypercall */
> +struct hv_get_vp_register_input {
> +       u64 partitionid;
> +       u32 vpindex;
> +       u8  inputvtl;
> +       u8  padding[3];
> +       u32 name0;
> +       u32 name1;
> +} __packed;

Are you sure these need to be made byte-aligned according to the
specification? If the structure itself is aligned to 64 bit, better mark only
the individual fields that are misaligned as __packed.

If the structure is aligned to only 32-bit addresses instead of
64-bit, mark it as "__packed __aligned(4)" to let the compiler
generate better code for accessing it.

Also, in order to write portable code, it would be helpful to mark
all the fields as explicitly little-endian, and use __le32_to_cpu()
etc for accessing them.

> +/* Define synthetic interrupt controller message flags. */
> +union hv_message_flags {
> +       __u8 asu8;
> +       struct {
> +               __u8 msg_pending:1;
> +               __u8 reserved:7;
> +       } __packed;
> +};

For similar reasons, please avoid bit fields and just use a
bit mask on the first member of the union.

The __packed annotation here is not meaningful,
as the total size is already only a single byte.

> +/* Define port identifier type. */
> +union hv_port_id {
> +       __u32 asu32;
> +       struct {
> +               __u32 id:24;
> +               __u32 reserved:8;
> +       }  __packed u;
> +};

Here, the __packed annotation is inconsistent with the use
in the rest of the file: marking only one member of the union
as __packed means that the union itself is still expected to
be 4 byte aligned. I would expect that either all of these
structures have a sensible alignment, or they are all
completely unaligned.

> + * Use the Hyper-V provided stimer0 as the timer that is made
> + * available to the architecture independent Hyper-V drivers.
> + */
> +#define hv_init_timer(timer, tick) \
> +               hv_set_vpreg(HV_REGISTER_STIMER0_COUNT + (2*timer), tick)
> +#define hv_init_timer_config(timer, val) \
> +               hv_set_vpreg(HV_REGISTER_STIMER0_CONFIG + (2*timer), val)
> +#define hv_get_current_tick(tick) \
> +               (tick = hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT))

In general, we prefer inline functions over macros in header files.

> +#if IS_ENABLED(CONFIG_HYPERV)
> +#define hv_enable_stimer0_percpu_irq(irq)      enable_percpu_irq(irq, 0)
> +#define hv_disable_stimer0_percpu_irq(irq)     disable_percpu_irq(irq)
> +#endif

Should there be an #else definition here? It helps readability
to have the two versions (with and without hyperv support) close
together rather than in different files. If there is no other
definition, just drop the #if.

     Arnd
