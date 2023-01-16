Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8347666BB40
	for <lists+linux-arch@lfdr.de>; Mon, 16 Jan 2023 11:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjAPKI7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Jan 2023 05:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjAPKIa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Jan 2023 05:08:30 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9782A4481;
        Mon, 16 Jan 2023 02:07:58 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id e8so3296648qts.1;
        Mon, 16 Jan 2023 02:07:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZWxErGsgw8qIQZ7WuVMBNjdTSNqeBsJeagSLrPY12c=;
        b=waTAjMumA51JmQP2ulFk4vlqfX4UGBYifycBQ7D1J854wd0onBqjNmYrmc0hqU2eQZ
         IE/g71uCDXuojnShyqjWd/10C/ppB+xkxwDjE1tUJ9ZvdqL3JHJXrMQwpfr+H8+BpRwf
         O1Rm0ywe9Jt9ATToXWhvEELNdtxTQNHxw7XCeqp+Pd+erXGIS42NAnX9dOTzq6N6Rc1N
         Qcxe2v6Hggao6dcApp8dcOQNGd1qdepEoRGG6UwBMyBG0elRN7X1YZBb4BQ4zsgTrRbr
         9L/HXil+FFiazIRhPEOXyxuhKtG3ArgtkVOpAX05aY0NfMkr1B0TAiDE6dxXGLtydF31
         gIdA==
X-Gm-Message-State: AFqh2kroMcAk7n8SpdkRoLYQzHk9QMnRAQdL5/26orBSVkaDCUntKzMi
        x/FQ5r78KfRtoFHzxrjE6mH8g3af233bVA==
X-Google-Smtp-Source: AMrXdXv8nQf63Xum57AahIsqYyiVtt5DtO0uM2WieQXj/OcHSuGD6e1Kb0MyEaZjN7rcPQDOtMPmFQ==
X-Received: by 2002:ac8:534c:0:b0:3b6:2cae:8b7b with SMTP id d12-20020ac8534c000000b003b62cae8b7bmr6671876qto.36.1673863677547;
        Mon, 16 Jan 2023 02:07:57 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id bs15-20020a05620a470f00b006b61b2cb1d2sm18073044qkb.46.2023.01.16.02.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 02:07:57 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 9so12224285ybn.6;
        Mon, 16 Jan 2023 02:07:57 -0800 (PST)
X-Received: by 2002:a5b:541:0:b0:7d5:620e:b60f with SMTP id
 r1-20020a5b0541000000b007d5620eb60fmr793487ybp.89.1673863676798; Mon, 16 Jan
 2023 02:07:56 -0800 (PST)
MIME-Version: 1.0
References: <20221211061358.28035-1-palmer@rivosinc.com> <20221211061358.28035-17-palmer@rivosinc.com>
In-Reply-To: <20221211061358.28035-17-palmer@rivosinc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Jan 2023 11:07:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUwsf8P4HDPfPmtB1F7Xbbb-i_H=ZCKVkMsiG8WzJ8=oA@mail.gmail.com>
Message-ID: <CAMuHMdUwsf8P4HDPfPmtB1F7Xbbb-i_H=ZCKVkMsiG8WzJ8=oA@mail.gmail.com>
Subject: Re: [PATCH v2 16/24] m68k: Remove empty <uapi/asm/setup.h>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

CC linux-m68k

On Sun, Dec 11, 2022 at 7:20 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  arch/m68k/include/uapi/asm/setup.h | 15 ---------------
>  1 file changed, 15 deletions(-)
>  delete mode 100644 arch/m68k/include/uapi/asm/setup.h
>
> diff --git a/arch/m68k/include/uapi/asm/setup.h b/arch/m68k/include/uapi/asm/setup.h
> deleted file mode 100644
> index 005593acc7d8..000000000000
> --- a/arch/m68k/include/uapi/asm/setup.h
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -/*
> -** asm/setup.h -- Definition of the Linux/m68k setup information
> -**
> -** Copyright 1992 by Greg Harp
> -**
> -** This file is subject to the terms and conditions of the GNU General Public
> -** License.  See the file COPYING in the main directory of this archive
> -** for more details.
> -*/
> -
> -#ifndef _UAPI_M68K_SETUP_H
> -#define _UAPI_M68K_SETUP_H
> -
> -#endif /* _UAPI_M68K_SETUP_H */
> --
> 2.38.1
