Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351EC7B5B55
	for <lists+linux-arch@lfdr.de>; Mon,  2 Oct 2023 21:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbjJBT31 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Oct 2023 15:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbjJBT30 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2023 15:29:26 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1FCBF;
        Mon,  2 Oct 2023 12:29:23 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-49d428d89cdso23778e0c.1;
        Mon, 02 Oct 2023 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696274963; x=1696879763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajjlmKdebxZk7OHm+SN7lonVxoqhP21tLhFjdE+XoAg=;
        b=QIJIOUN8IQ91tt4FjAlwaWiuT90azTbgJWXT/blrZ4QRHAY4O79mYOXrK71wadPG3B
         42OqOwwHolB+wQSXQLyNx33LcE3SY6s+8geEHw3IceP7eSIdoNpFFJy2LwQnyBNdpHg5
         KtsgvAX5hOfHgpywsbeMn66GsnJb9N+Qq6PaYSK9WeWtB5S58JhKcpKttwk5SHCJjN1C
         64JNBFnZUIP7GCR0uX/0u19rHqT2xtVmNu9SHIHakyh7CSYGkWarrzZFcBl3nlfi8shW
         f67g2CLcXRto0dk8F8jT8NyGMijjIbsYcUX3ghOJENzTS+DLpR16CVw0m1KumBp+fn5z
         bKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696274963; x=1696879763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajjlmKdebxZk7OHm+SN7lonVxoqhP21tLhFjdE+XoAg=;
        b=PlTYwH8sPF/ufW5dqTp8quud2X7QgN3toz26QS5EDX4+kICfh8dCAGM/9ambQOzdj3
         qwULHrz2k5gPWPhduuRhSA+wbYdEZwvJqo/mamQWEJvGwBKQvTKc8y5viS76K2re7N1k
         hYt87t+fgNW2u0PCfCU5Bqe/U2nf8JENKlN5xNj6cvVG6E0qBrnNVYF5FM/MC3IrBecY
         voZc4XYXfErvHtjKYCs6optXfFiA+VUvn82yqmzeoMVkVBh3JcQjrabk1GYtBHL2OU5C
         CH5QjwAPzrm6Y9cLjkKZPahXWxvWk1QgKT1TqijEwB6FMVtdVUy2V9uGc1ROQIeyFL3N
         5g9Q==
X-Gm-Message-State: AOJu0YxvvPBXYMhuLGsS2ITMt95OofeNjMLctCdwiwfi90YyslfuKZLD
        PxBEWiTRFUblZBLOZoIp/WGYncxHTFi0ByK7gJE=
X-Google-Smtp-Source: AGHT+IE49qL31bZrwQMJ0Xfes4Ezx8noj0Ajc/E7xZWoRNGoaK3gWcipOZQfm9J+6RsfmrXvjcIxKo9Ikw11UYOzsZY=
X-Received: by 2002:a05:6122:60c:b0:49b:9510:1f94 with SMTP id
 u12-20020a056122060c00b0049b95101f94mr5413861vkp.1.1696274962518; Mon, 02 Oct
 2023 12:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-10-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1696010501-24584-10-git-send-email-nunodasneves@linux.microsoft.com>
From:   Alex Ionescu <aionescu@gmail.com>
Date:   Mon, 2 Oct 2023 15:29:11 -0400
Message-ID: <CAJ-90N+A-wS-Uwrs_2WVL86Uo3qzQ1czxm-u9vDj3UuOwjhLdQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/15] Drivers: hv: Introduce hv_output_arg_exists in hv_common.c
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

Is it possible to simply change to always allocating the output page?
For example, the output page could be needed in scenarios where Linux
is not running as the root partition, since certain hypercalls that a
guest can make will still require one (I realize that's not the case
_today_, but I don't believe this optimization buys much).

Best regards,
Alex Ionescu

Best regards,
Alex Ionescu


On Fri, Sep 29, 2023 at 2:02=E2=80=AFPM Nuno Das Neves
<nunodasneves@linux.microsoft.com> wrote:
>
> This is a more flexible approach for determining whether to allocate the
> output page.
>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Acked-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/hv/hv_common.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 39077841d518..3f6f23e4c579 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -58,6 +58,14 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
>  void * __percpu *hyperv_pcpu_output_arg;
>  EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
>
> +/*
> + * Determine whether output arg is needed
> + */
> +static inline bool hv_output_arg_exists(void)
> +{
> +       return hv_root_partition ? true : false;
> +}
> +
>  static void hv_kmsg_dump_unregister(void);
>
>  static struct ctl_table_header *hv_ctl_table_hdr;
> @@ -342,10 +350,12 @@ int __init hv_common_init(void)
>         hyperv_pcpu_input_arg =3D alloc_percpu(void  *);
>         BUG_ON(!hyperv_pcpu_input_arg);
>
> -       /* Allocate the per-CPU state for output arg for root */
> -       if (hv_root_partition) {
> +       if (hv_output_arg_exists()) {
>                 hyperv_pcpu_output_arg =3D alloc_percpu(void *);
>                 BUG_ON(!hyperv_pcpu_output_arg);
> +       }
> +
> +       if (hv_root_partition) {
>                 hv_synic_eventring_tail =3D alloc_percpu(u8 *);
>                 BUG_ON(hv_synic_eventring_tail =3D=3D NULL);
>         }
> @@ -375,7 +385,7 @@ int hv_common_cpu_init(unsigned int cpu)
>         u8 **synic_eventring_tail;
>         u64 msr_vp_index;
>         gfp_t flags;
> -       int pgcount =3D hv_root_partition ? 2 : 1;
> +       int pgcount =3D hv_output_arg_exists() ? 2 : 1;
>         void *mem;
>         int ret;
>
> @@ -393,9 +403,12 @@ int hv_common_cpu_init(unsigned int cpu)
>                 if (!mem)
>                         return -ENOMEM;
>
> -               if (hv_root_partition) {
> +               if (hv_output_arg_exists()) {
>                         outputarg =3D (void **)this_cpu_ptr(hyperv_pcpu_o=
utput_arg);
>                         *outputarg =3D (char *)mem + HV_HYP_PAGE_SIZE;
> +               }
> +
> +               if (hv_root_partition) {
>                         synic_eventring_tail =3D (u8 **)this_cpu_ptr(hv_s=
ynic_eventring_tail);
>                         *synic_eventring_tail =3D kcalloc(HV_SYNIC_SINT_C=
OUNT, sizeof(u8),
>                                                         flags);
> --
> 2.25.1
>
>
