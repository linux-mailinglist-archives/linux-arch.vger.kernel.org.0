Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A381140F28C
	for <lists+linux-arch@lfdr.de>; Fri, 17 Sep 2021 08:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbhIQGmP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Sep 2021 02:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbhIQGmM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Sep 2021 02:42:12 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17DDC061768;
        Thu, 16 Sep 2021 23:40:50 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id t186so3334512vkd.3;
        Thu, 16 Sep 2021 23:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVx8Txip/StjPOD2jLvVsMLUrbAlebmeTfy3904j/s8=;
        b=B42cV+Vk58LaOagsuwBpCCU3JGFLZwsVCvetR0q+GuE7Lnj8xEjm5RzGjvEBUayfUS
         NGi1QlcFSUz2uUph9PEzQKAcKrve1w2DzP6k0rLOradZHoW5nquakeCNJuGchVfvf0jv
         exFivBYcVLsfPn6WYja8UMBY2h0x2dppbEcygJi9WiYjryuOMuJCIFp5JphkrwOfc1x9
         XfHVpIgP7HarQXSCXDiwxG55RaPpqR0HxxWM3Sgr/6vF0K6GxzxeYmpHM3XfqVEjUJSA
         PoGtDi2jSkUTeQE2w9cmxU1eDZ7mRCRFo50Wi2xXXGiYulMYckrGJZNLPk78nyUNCXoa
         s+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVx8Txip/StjPOD2jLvVsMLUrbAlebmeTfy3904j/s8=;
        b=QxgppivCfXdeXY+T6XscK58Ki6oLYH/PZMR8qj6k7Au+XTIUyUCCqJ3vNMJInoDgGk
         4RJs6Jz3M0d5FvPFo7KX5HZtO22VUxIOFUYKunkQSt27YHakDulwmEmx6yZGu+ft/PTl
         fvh/NF12OJQ9in8cIKhEmBgkEniN+X+6HJ5L57LaM5NZF0AlntIbEH0sOw+9QyjGOD7k
         /mGVoZB5RtdQBRvTuA5nmhHtoklbN4w6peYy7Fss6Nit06BALVDotNbdXVU3rbtxjLz7
         SZsHFT8bpe8sQ/tLVEkb9xB7DQ53qEcjaLzx7q1TH5z3etcMvyi1GIYGNgR7JRzCqdFB
         Q/Ew==
X-Gm-Message-State: AOAM530KgTMSw+xh+WNJCQpfCYYJv4HjjNO5xeFT+EaPylgEcvEHXzlA
        Kx8U2KJOlp7PTSWOu/VOmE2Jw4ImnTYWRx+3FIc=
X-Google-Smtp-Source: ABdhPJzeGQdx5dWHBR/QJXA8phHTkedA7J8VvFqobRsX6FKRjPGacfs5+m7SRv2fq0cIfre7YagPqkvzkaYGJaD7+LI=
X-Received: by 2002:a1f:9781:: with SMTP id z123mr6691649vkd.25.1631860849907;
 Thu, 16 Sep 2021 23:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
 <20210917035736.3934017-22-chenhuacai@loongson.cn> <YUQygKWFMU8zrkFi@infradead.org>
In-Reply-To: <YUQygKWFMU8zrkFi@infradead.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 17 Sep 2021 14:40:38 +0800
Message-ID: <CAAhV-H65YPaDYTb4EyzezSHOXtdiVmhz6qMhc1HwSYHqjV6w6g@mail.gmail.com>
Subject: Re: [PATCH V3 21/22] LoongArch: Add Non-Uniform Memory Access (NUMA) support
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Christoph,

On Fri, Sep 17, 2021 at 2:17 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +/*
> > + * We extract 4bit node id (bit 44~47) from Loongson-3's
> > + * 48bit physical address space and embed it into 40bit.
> > + */
> > +
> > +static int node_id_offset;
> > +
> > +static dma_addr_t loongson_phys_to_dma(struct device *dev, phys_addr_t paddr)
> > +{
> > +     long nid = (paddr >> 44) & 0xf;
> > +
> > +     return ((nid << 44) ^ paddr) | (nid << node_id_offset);
> > +}
> > +
> > +static phys_addr_t loongson_dma_to_phys(struct device *dev, dma_addr_t daddr)
> > +{
> > +     long nid = (daddr >> node_id_offset) & 0xf;
> > +
> > +     return ((nid << node_id_offset) ^ daddr) | (nid << 44);
> > +}
> > +
> > +static struct loongson_addr_xlate_ops {
> > +     dma_addr_t (*phys_to_dma)(struct device *dev, phys_addr_t paddr);
> > +     phys_addr_t (*dma_to_phys)(struct device *dev, dma_addr_t daddr);
> > +} xlate_ops;
> > +
> > +dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
> > +{
> > +     return xlate_ops.phys_to_dma(dev, paddr);
> > +}
> > +
> > +phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
> > +{
> > +     return xlate_ops.dma_to_phys(dev, daddr);
> > +}
>
> Please don't add unused indirections.  Also please just use the generic
> translations
OK, I will simplify thi by removing indirections.

Huacai
>
