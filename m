Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDEC658EF8
	for <lists+linux-arch@lfdr.de>; Thu, 29 Dec 2022 17:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbiL2QWz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Dec 2022 11:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbiL2QWa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Dec 2022 11:22:30 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071B214017
        for <linux-arch@vger.kernel.org>; Thu, 29 Dec 2022 08:22:29 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9so2614185pll.9
        for <linux-arch@vger.kernel.org>; Thu, 29 Dec 2022 08:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJWl3hQjQi1Q2dj4b8EWt43Qd/L5DvONqc85eLA2p84=;
        b=4zYH9voiUehp/MZKaq6EtNACAh0H6KL+NcDR1+JWFT9el9nBtDDy5s/Grp35vcGLTn
         mC4yxUvNQT9ZHM/fnM3ClqhCBAi/pKFY7/Qcu/cmUds0jUkq+e/XBfn4BWaXWCqY8mV0
         SJi5SWKcJyTnLbjM9Coh6TiX5jV0jGo7LzJ8aCPVGuaxSKC5AEbZE9P5wGvOIEplpmyQ
         /B+8dZfJYMOKYTZX0K2rz9JP3kktm/MRb4BQdxtt9nWP/c6GeDq0vU4lcn/xhf45s6Kd
         3BfqoRQirN2XyS81sZAEXUkf0HbsZruvKJkP4Nh6YrifVS51/U4OZ6ZA39eqwDvVSK9n
         qsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJWl3hQjQi1Q2dj4b8EWt43Qd/L5DvONqc85eLA2p84=;
        b=tPg5VDwRAKVQkHv799Y6E2Frv8UbJ21xrof1npZx21X2VrtfyeTL0PYMseMpeWjVJr
         jbV7sND8acQ39zE88q2EqtL3VuLeEyCsLm2vtffwaXp92/v2OIs3k4yLWOnphV1O53ah
         EEYKPDqWQrGKkl0nXwfugqlP6fBCRBibK/CpYl+og1n1ndXeodT7bt8TeZIlaNVKSIvd
         kNX27UwXi6/UcvVqFRCDLaXvjUt5gICypHuTUF8it4BIZps5nxZddP6MCZ7/JstNFbuW
         8YkE9i8j5EQ4rhR4zKhPFjxN8yVOpFwsd0KjKTwfMhj73uWE7W1rKerkkaBu/YeS+4r1
         Uj4g==
X-Gm-Message-State: AFqh2krU6uIu9x1St+UPDLs780HzXDwMv7ZJmPDT2O++xlCtIcMAyvMT
        MIGx1B4QuNO9SKI7GYbTrVkz9OrRuC37TPJ74h8=
X-Google-Smtp-Source: AMrXdXusHRJt1gPOTWh0ukRoRRYv3CsTOwvtO5tJuONXzHi84yKZLmsYPBOK0toLmCX+j9QDQYJoeQ==
X-Received: by 2002:a17:902:e2d1:b0:191:cd3:aa6c with SMTP id l17-20020a170902e2d100b001910cd3aa6cmr39371632plc.34.1672330947985;
        Thu, 29 Dec 2022 08:22:27 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id o9-20020a170903210900b001782398648dsm13165941ple.8.2022.12.29.08.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 08:22:27 -0800 (PST)
Date:   Thu, 29 Dec 2022 08:22:27 -0800 (PST)
X-Google-Original-Date: Thu, 29 Dec 2022 07:54:30 PST (-0800)
Subject:     Re: [PATCH v2] arch: fix broken BuildID for arm64 and riscv
In-Reply-To: <20221226184537.744960-1-masahiroy@kernel.org>
CC:     linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, ardb@kernel.org,
        regressions@leemhuis.info, catalin.marinas@arm.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, dennis@ausil.us,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        jszhang@kernel.org, nicolas@fjasle.eu,
        Paul Walmsley <paul.walmsley@sifive.com>, masahiroy@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     masahiroy@kernel.org
Message-ID: <mhng-7ae63e3d-9a40-42ed-94c3-72fc9217ac20@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 26 Dec 2022 10:45:37 PST (-0800), masahiroy@kernel.org wrote:
> Dennis Gilmore reports that the BuildID is missing in the arm64 vmlinux
> since commit 994b7ac1697b ("arm64: remove special treatment for the
> link order of head.o").
>
> The issue is that the type of .notes section, which contains the BuildID,
> changed from NOTES to PROGBITS.
>
> Ard Biesheuvel figured out that whichever object gets linked first gets
> to decide the type of a section. The PROGBITS type is the result of the
> compiler emitting .note.GNU-stack as PROGBITS rather than NOTE.
>
> While Ard provided a fix for arm64, I want to fix this globally because
> the same issue is happening on riscv since commit 2348e6bf4421 ("riscv:
> remove special treatment for the link order of head.o"). This problem
> will happen in general for other architectures if they start to drop
> unneeded entries from scripts/head-object-list.txt.
>
> Discard .note.GNU-stack in include/asm-generic/vmlinux.lds.h.
>
> Link: https://lore.kernel.org/lkml/CAABkxwuQoz1CTbyb57n0ZX65eSYiTonFCU8-LCQc=74D=xE=rA@mail.gmail.com/
> Fixes: 994b7ac1697b ("arm64: remove special treatment for the link order of head.o")
> Fixes: 2348e6bf4421 ("riscv: remove special treatment for the link order of head.o")
> Reported-by: Dennis Gilmore <dennis@ausil.us>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v2:
>   - discard .note.GNU-stack before .notes because many architectures
>     call DISCARDS at the end of their linker scripts
>
>  include/asm-generic/vmlinux.lds.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index a94219e9916f..659bf3b31c91 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -891,7 +891,12 @@
>  #define PRINTK_INDEX
>  #endif
>
> +/*
> + * Discard .note.GNU-stack, which is emitted as PROGBITS by the compiler.
> + * Otherwise, the type of .notes section would become PROGBITS instead of NOTES.
> + */
>  #define NOTES								\
> +	/DISCARD/ : { *(.note.GNU-stack) }				\
>  	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
>  		BOUNDED_SECTION_BY(.note.*, _notes)			\
>  	} NOTES_HEADERS							\

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks!
