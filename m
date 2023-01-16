Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9450F66BB3C
	for <lists+linux-arch@lfdr.de>; Mon, 16 Jan 2023 11:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjAPKII (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Jan 2023 05:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjAPKHq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Jan 2023 05:07:46 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4D1193C1;
        Mon, 16 Jan 2023 02:07:27 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id x5so603908qti.3;
        Mon, 16 Jan 2023 02:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26Y1vYmwwq8aWhcVlX6A7aJb6PyVhNqZiaD+Qkg9TZw=;
        b=utP/O9EtDJ3CiawojFExCbSJ6f6u0a/KR375ANkYwCVL0VjZK9tJfTW6H6ufndVzxR
         2urxR2MIIMkKjGdrkuz1802UlIyrlQkP8hIY3ZqdWoXLWKTqbtUesxWtUErr75gekyBn
         U3nuqda5JFS24/EdZ8j4fOPyJsD3ee3M/cQwh29AFGu887ZnLqJJqOSlmpmkJ0KDNVcP
         W7E+gVvqsrVUJU9kOBZ3cuJrRobsEclPW/AuK1gkYIKR55zgJeG1XmZnWlqQ+4jt8aK1
         GSeZmdkSqgJKPhXuAVk/NkosBsZaJfyRfYPcKEbsBVnL1U1SHVrF5blIxWH7Tt+8u8FT
         6+7g==
X-Gm-Message-State: AFqh2kod5mefmyFlQ/a8vQ2xY5tkoaSxwycNltNYJAp3wwdRuQrNPZww
        rHKtJu4AVtyX9K9jtetY9OvliM/WfpFsGA==
X-Google-Smtp-Source: AMrXdXv1rbUEcZM7j1hR3C7o0Sy20KVmvgBwASRf+byMgi7DySoLy0sx5oJXxmwo5yMhIcLqEAFr+A==
X-Received: by 2002:a05:622a:5096:b0:3b6:2f43:8937 with SMTP id fp22-20020a05622a509600b003b62f438937mr5466534qtb.3.1673863646451;
        Mon, 16 Jan 2023 02:07:26 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id bl19-20020a05620a1a9300b006fa9d101775sm16772547qkb.33.2023.01.16.02.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 02:07:26 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-4d4303c9de6so223243147b3.2;
        Mon, 16 Jan 2023 02:07:26 -0800 (PST)
X-Received: by 2002:a81:91cc:0:b0:48d:1334:6e38 with SMTP id
 i195-20020a8191cc000000b0048d13346e38mr1765629ywg.316.1673863645871; Mon, 16
 Jan 2023 02:07:25 -0800 (PST)
MIME-Version: 1.0
References: <20221211061358.28035-1-palmer@rivosinc.com> <20221211061358.28035-6-palmer@rivosinc.com>
In-Reply-To: <20221211061358.28035-6-palmer@rivosinc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Jan 2023 11:07:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXpFBcxPZLcyqP_Zi7sxF1OgKtW1wExUO3xYks-RViVhA@mail.gmail.com>
Message-ID: <CAMuHMdXpFBcxPZLcyqP_Zi7sxF1OgKtW1wExUO3xYks-RViVhA@mail.gmail.com>
Subject: Re: [PATCH v2 05/24] m68k: Remove COMMAND_LINE_SIZE from uapi
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

CC linux-m68k

On Sun, Dec 11, 2022 at 7:19 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> As far as I can tell this is not used by userspace and thus should not
> be part of the user-visible API.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> This leaves an empty <uapi/asm/setup.h>, which will soon be cleaned up.
> ---
>  arch/m68k/include/asm/setup.h      | 3 +--
>  arch/m68k/include/uapi/asm/setup.h | 2 --
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/m68k/include/asm/setup.h b/arch/m68k/include/asm/setup.h
> index 2c99477aaf89..9a256cc3931d 100644
> --- a/arch/m68k/include/asm/setup.h
> +++ b/arch/m68k/include/asm/setup.h
> @@ -23,9 +23,8 @@
>  #define _M68K_SETUP_H
>
>  #include <uapi/asm/bootinfo.h>
> -#include <uapi/asm/setup.h>
> -
>
> +#define COMMAND_LINE_SIZE 256
>  #define CL_SIZE COMMAND_LINE_SIZE
>
>  #ifndef __ASSEMBLY__
> diff --git a/arch/m68k/include/uapi/asm/setup.h b/arch/m68k/include/uapi/asm/setup.h
> index 25fe26d5597c..005593acc7d8 100644
> --- a/arch/m68k/include/uapi/asm/setup.h
> +++ b/arch/m68k/include/uapi/asm/setup.h
> @@ -12,6 +12,4 @@
>  #ifndef _UAPI_M68K_SETUP_H
>  #define _UAPI_M68K_SETUP_H
>
> -#define COMMAND_LINE_SIZE 256
> -
>  #endif /* _UAPI_M68K_SETUP_H */
> --
> 2.38.1
>
