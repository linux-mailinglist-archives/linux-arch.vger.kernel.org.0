Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060E161666D
	for <lists+linux-arch@lfdr.de>; Wed,  2 Nov 2022 16:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKBPq5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 11:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKBPq4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 11:46:56 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E7D28700;
        Wed,  2 Nov 2022 08:46:42 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id v7so5150944wmn.0;
        Wed, 02 Nov 2022 08:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRJj5yHCtXyXwwd/7M6wnfoyC3OaZHCqR6/Il7KJVw4=;
        b=YZ+z89+UUB1rp/B0QDb2CC8aDRJHtbDyBnqMB9HvZgQB3KHODiQWTpqyvhwUaru2Io
         cy8MzjUxkRhGEaqc/8qN+T1wCOnE4Fm5ZvJbmcbEGGHyJIIL3C4gDdNsoWi4BoTT4V+n
         RNn3x/GkhPlmvFjFjSzD7ncnXvJCF32J63kloQGqU0stUC8Rz1zY3fi6qH2VjJDMY/fl
         +6+rH29wsSblIVZM+cSHDVpWPLMpzzIas2sXkw1qrFVdk/CMR6g/nF25JPpuql7MnU0A
         tK65E4u+QvvLk0mlHtlDac819CJPG5Vbw5j9dLM/hryzp0ba2WHgFq7Lnq6BpslE4nQK
         vFUA==
X-Gm-Message-State: ACrzQf1S8tF3HBaJsBzPop7cDeewN4XchH5lZeyVsPz7sTb124KuspI+
        /9CXpu+FHtn+HKlyhAKfm98=
X-Google-Smtp-Source: AMsMyM6k8mSDHtQtlxZJE5jvhiLoxUfBgoQYyUkqrFd/vlLTmsLRJ1mRFP00tCHGuKxtrcmzp2PZNg==
X-Received: by 2002:a05:600c:2215:b0:3cf:74e9:a9e0 with SMTP id z21-20020a05600c221500b003cf74e9a9e0mr9699211wml.145.1667404000688;
        Wed, 02 Nov 2022 08:46:40 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b003c21ba7d7d6sm2385982wmp.44.2022.11.02.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:46:38 -0700 (PDT)
Date:   Wed, 2 Nov 2022 15:46:31 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jinank Jain <jinankjain@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, seanjc@google.com,
        kirill.shutemov@linux.intel.com, ak@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 6/6] hv, mshv : Change interrupt vector for nested root
 partition
Message-ID: <Y2KQ1w5GOd/PcN61@liuwe-devbox-debian-v2>
References: <cover.1667394408.git.jinankjain@microsoft.com>
 <22b6428cc90efb4ed970d61249c877b373a7002a.1667394408.git.jinankjain@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22b6428cc90efb4ed970d61249c877b373a7002a.1667394408.git.jinankjain@microsoft.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 02, 2022 at 02:00:17PM +0000, Jinank Jain wrote:
> Traditionally we have been using the HYPERVISOR_CALLBACK_VECTOR to relay
> the VMBus interrupt. But this does not work in case of nested
> hypervisor. Microsoft Hypervisor reserves 0x31 to 0x34 as the interrupt
> vector range for VMBus and thus we have to use one of the vectors from
> that range and setup the IDT accordingly.
> 
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> ---
>  arch/x86/include/asm/idtentry.h    |  2 ++
>  arch/x86/include/asm/irq_vectors.h |  6 ++++++
[...]
>  #if IS_ENABLED(CONFIG_ACRN_GUEST)
> diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
> index 43dcb9284208..729d19eab7f5 100644
> --- a/arch/x86/include/asm/irq_vectors.h
> +++ b/arch/x86/include/asm/irq_vectors.h
> @@ -102,6 +102,12 @@
>  #if IS_ENABLED(CONFIG_HYPERV)
>  #define HYPERV_REENLIGHTENMENT_VECTOR	0xee
>  #define HYPERV_STIMER0_VECTOR		0xed
> +/*
> + * FIXME: Change this, once Microsoft Hypervisor changes its assumption
> + * around VMBus interrupt vector allocation for nested root partition.
> + * Or provides a better interface to detect this instead of hardcoding.
> + */
> +#define HYPERV_INTR_NESTED_VMBUS_VECTOR	0x31

I would like to hear x86 maintainers opinion on this.

Thanks,
Wei.
