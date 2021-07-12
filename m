Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E419A3C6294
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jul 2021 20:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbhGLS0x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jul 2021 14:26:53 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:43794 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhGLS0x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jul 2021 14:26:53 -0400
Received: by mail-wr1-f52.google.com with SMTP id a13so26874148wrf.10;
        Mon, 12 Jul 2021 11:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bh+Pa3oXCjpgXW78zCJeL/+8I2owFHmqqcZPnmGZmAQ=;
        b=N8WvpLyXlLSXAucM3LmUf2peH5b7z3vKs8MsPFRdB1rzcXWayrLcejby+/MFtXNgK3
         CNxw8XBvLMOFRayXhkjnigCHAE+zqtmQ1BZlgL5IOTtPY2m+mtJq9LVj5WrHrhaoCUFw
         ZsOf4/zKT5cMZmKwl3/7s9wEEUBScH7AkUq72WsCIJFC5a8xIQ5kat4aeDr01unt0M1J
         Ag996mqKyEv1G/u05gm4U0y8VbVYvSNRxYtL+e4NwnKgwB3OBZxZSM/HisoDZ6Y1dQ6u
         C6rs1xKGG53/BNjbwwAY1QvusVd5wQn/eRalass6aK7V9M7ZABUweWIBCmo4q5scwd7I
         iojw==
X-Gm-Message-State: AOAM533rPt7DMcYxWCtncFW4xncgG0dk2cMOS4Gzoy3Y93NAmedNgPB2
        pfjIXUPKWtyBUm6GTGnB8YM=
X-Google-Smtp-Source: ABdhPJynsgbOLnextiu8xWZLVxZ8wvY0+7Twq5M9RxxKfotQJyxvGq6PakKXQrL34zS3R14oIYs6Xw==
X-Received: by 2002:adf:f848:: with SMTP id d8mr392950wrq.308.1626114242934;
        Mon, 12 Jul 2021 11:24:02 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id w22sm202821wmc.4.2021.07.12.11.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 11:24:02 -0700 (PDT)
Date:   Mon, 12 Jul 2021 18:24:00 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/3] Drivers: hv: Make portions of Hyper-V init code be
 arch neutral
Message-ID: <20210712182400.yze3wochnyccaflw@liuwe-devbox-debian-v2>
References: <1626060316-2398-1-git-send-email-mikelley@microsoft.com>
 <1626060316-2398-2-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626060316-2398-2-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 11, 2021 at 08:25:14PM -0700, Michael Kelley wrote:
[...]
> +int hv_common_cpu_init(unsigned int cpu)
> +{
> +	void **inputarg, **outputarg;
> +	u64 msr_vp_index;
> +	gfp_t flags;
> +	int pgcount = hv_root_partition ? 2 : 1;
> +
> +	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
> +	flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
> +
> +	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> +	*inputarg = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);

This is changed from alloc_pages to kmalloc. Does it ensure the
alignment is still correct? 

Wei.
