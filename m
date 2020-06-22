Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915D820432C
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 00:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbgFVWAs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 18:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730731AbgFVWAs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 18:00:48 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141A1C061573
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:00:48 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id m2so550769pjv.2
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ibN7k/GXiEaOSwLAh6eIG551wxCB5ccPWNe8L96H7k=;
        b=rKyi28V8bhsI6UdHiPApRpohgn8p9zbUYrz2P0iYhKTjCcEJ0SOmXPvMi9V0vqatco
         3zGbkaHV1kl3gjnsYSypuWOI+JtV9XpVsv3Jeu0SnNN+SeL0YE0KynN2aVt1nh04yijm
         G/C/99Dy4+IUjMHHYJ8lWES1GjdSu8WOBoyF3D+RYqCj3m4myhdwFBquvPI2hsmIKrmL
         33wQPAhshvvESXgStFXk9rxa2pjnZaUkd+Q9aIz9ygCq46QtquvxTGU/990uwrOkfAER
         0cwAeoV+9N8KJqc7YQRvBKbadq3s7A4/URqpvXSyDalxch6c40Ae3ataIYbj3r3H0OcS
         0uYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ibN7k/GXiEaOSwLAh6eIG551wxCB5ccPWNe8L96H7k=;
        b=Pg1E2Qp4/DIGz8RxwCpJ3KTIp0/QBAbksc2HF4JDCeaXEEkpLT//iYQYxT4M4uDVZu
         f+WhKZU+/Y7uPeK9Y7YMoChSxnsSoq0YSNGJtc2d/Kr8/2BHsHiLP83/YyJXEY+Zejt8
         Smk7KQF7re/xzv5yUgKQyPJY/MWjXoGqnbHs7sPBa1xmdQ+hNoUfQM2++czRfyTyf0MC
         z3ccWQacEmwLDJ3e131nWUXvmIiUNz1mEMUg51pxckifplsfvJUcbBerl5sfCxBIGuvE
         fmEujspYbMv+KUDB0l4UYrxd90OUftMTogm9BlSgypsAXoi8SzkPSmDW2M0ZHET7d3G4
         SYAw==
X-Gm-Message-State: AOAM530wEfD/UH3r6veRbpBAozdpILc3j4xovFDJdsMNUG2rSwSrJONb
        liMbWEvdq3n65/stPpOHZHfLnQ==
X-Google-Smtp-Source: ABdhPJymp3j075dghUf8mE+rb8FWDpg5HB71a1UeOscamGOdT4UZapUDia7WzmBwV1WReNldwXQ4fw==
X-Received: by 2002:a17:902:ee15:: with SMTP id z21mr21435821plb.233.1592863247373;
        Mon, 22 Jun 2020 15:00:47 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id 130sm14647760pfw.176.2020.06.22.15.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:00:46 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:00:43 -0700
From:   Fangrui Song <maskray@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Message-ID: <20200622220043.6j3vl6v7udmk2ppp@google.com>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200622205341.2987797-2-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-06-22, Kees Cook wrote:
>For vmlinux linking, no architecture uses the .gnu.version* section,
>so remove it via the common DISCARDS macro in preparation for adding
>--orphan-handling=warn more widely.
>
>Signed-off-by: Kees Cook <keescook@chromium.org>
>---
> include/asm-generic/vmlinux.lds.h | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>index db600ef218d7..6fbe9ed10cdb 100644
>--- a/include/asm-generic/vmlinux.lds.h
>+++ b/include/asm-generic/vmlinux.lds.h
>@@ -934,6 +934,7 @@
> 	*(.discard)							\
> 	*(.discard.*)							\
> 	*(.modinfo)							\
>+	*(.gnu.version*)						\
> 	}
>
> /**
>-- 
>2.25.1

I wonder what lead to .gnu.version{,_d,_r} sections in the kernel.

tools/lib/bpf/libbpf_internal.h uses `.symver` directive and
-Wl,--version-script, which may lead to .gnu.version{,_d}, but this only
applies to the userspace libbpf.so

libperf.so has a similar -Wl,--version-script.

Linking vmlinux does not appear to use any symbol versioning.
