Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C0A5BD909
	for <lists+linux-arch@lfdr.de>; Tue, 20 Sep 2022 03:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiITBGJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 21:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiITBGI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 21:06:08 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF124DB2D
        for <linux-arch@vger.kernel.org>; Mon, 19 Sep 2022 18:06:07 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r23so993246pgr.6
        for <linux-arch@vger.kernel.org>; Mon, 19 Sep 2022 18:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date;
        bh=msMZhqNq61If7HcCA+NfR7MMdzuuCIJw+aWLcbkpcnU=;
        b=YasyySfQ8sOb6nLt8cM/Il/HdiCy/WfOKqas6cOonnzFfk0kpKTJGITZkbTj2shRVu
         G/p4E8ttB4PFWRunzEjLWaA0EWIjnymGuN968eIGeTSXttIrkm0uSjSGVeNBtVaG38uh
         uJNxOnCrHA8ZKUdB/ramvlu3rHB5PGA6B4hezDABzQEC3PWHfrAC7mJnQGcHUFzrQSYg
         Hsw/k4NYc8eZcyDGBtDDCYhayLQjOlr3da+AnsLjbf1lkJs/ACOYeOH3qKHDLQCJf1a6
         4nTgTSNN9+5g7Nn0GdlECHu2LEnxzQxVWbvUg8n50OVvYOcXudmM5xMNQ/6oxiNb4TXa
         3FDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date;
        bh=msMZhqNq61If7HcCA+NfR7MMdzuuCIJw+aWLcbkpcnU=;
        b=i+0KMXG73gZhr6ja3jNd7JsZ7go26Lwerh1SLtPjY7lhYJ++19h8F6IHPDmnZcTKX/
         zank97Jlapj84L8AEg5+FwKX5U2NvP/tgF6v0+ELOSMxXNjmKnne1d5PpEDybIX8wiQh
         5bgRo9ljI/GLj2ioboLNg8FzvvmGoN5Kz+Yxth8pGpkZpgBzmwAA/byLy1XlUXSa2xkS
         JVBLFF8qah44TD5dR1Lv2TMUqAOhrhrQaNLVGlNQ+I1oCQj5lUFk70vYjrqlC1S8vC6s
         Rdrdrord1FfF66DacnH7uloCPFRT+5gmH8T6eHpfwpsSKz69aiwr7JBTwHh+QFbFY7t0
         nbfA==
X-Gm-Message-State: ACrzQf1K1GDBSio39jv4UW9qCJCYnft2ThvT+aY2ozSCn6njJzUKpJRR
        Koor3p9jAYMiR2onFxII8SU=
X-Google-Smtp-Source: AMsMyM4Rua4knZuDnYF83oyPImT7Kh2TAxhd7BZf5JJ1sXZ8RxoSK6AqShZNDvCJ59DBPzt3GFfaTw==
X-Received: by 2002:a63:77c4:0:b0:435:4224:98b6 with SMTP id s187-20020a6377c4000000b00435422498b6mr18113764pgc.94.1663635967096;
        Mon, 19 Sep 2022 18:06:07 -0700 (PDT)
Received: from localhost (118-208-203-28.tpgi.com.au. [118.208.203.28])
        by smtp.gmail.com with ESMTPSA id w184-20020a627bc1000000b00540ad46bc1dsm14580pfc.157.2022.09.19.18.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 18:06:06 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 20 Sep 2022 11:06:01 +1000
Message-Id: <CN0TQ9Y2OA8T.1EEPB63P94PKY@bobo>
Cc:     <linux-arch@vger.kernel.org>, "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 09/23] asm-generic: compat: Support BE for long long
 args in 32-bit ABIs
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Rohan McLure" <rmclure@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.11.0
References: <20220916053300.786330-1-rmclure@linux.ibm.com>
 <20220916053300.786330-10-rmclure@linux.ibm.com>
In-Reply-To: <20220916053300.786330-10-rmclure@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri Sep 16, 2022 at 3:32 PM AEST, Rohan McLure wrote:
> 32-bit ABIs support passing 64-bit integers by registers via argument
> translation. Commit 59c10c52f573 ("riscv: compat: syscall: Add
> compat_sys_call_table implementation") implements the compat_arg_u64
> macro for efficiently defining little endian compatibility syscalls.
>
> Architectures supporting big endianness may benefit from reciprocal
> argument translation, but are welcome also to implement their own.
>
> Signed-off-by: Rohan McLure <rmclure@linux.ibm.com>

Better put Arnd and linux-arch on cc...

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
> V4 -> V5: New patch.
> ---
>  include/asm-generic/compat.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/compat.h b/include/asm-generic/compat.h
> index d06308a2a7a8..aeb257ad3d1a 100644
> --- a/include/asm-generic/compat.h
> +++ b/include/asm-generic/compat.h
> @@ -14,12 +14,17 @@
>  #define COMPAT_OFF_T_MAX	0x7fffffff
>  #endif
> =20
> -#if !defined(compat_arg_u64) && !defined(CONFIG_CPU_BIG_ENDIAN)
> +#ifndef compat_arg_u64
> +#ifdef CONFIG_CPU_BIG_ENDIAN
>  #define compat_arg_u64(name)		u32  name##_lo, u32  name##_hi
>  #define compat_arg_u64_dual(name)	u32, name##_lo, u32, name##_hi
> +#else
> +#define compat_arg_u64(name)		u32  name##_hi, u32  name##_lo
> +#define compat_arg_u64_dual(name)	u32, name##_hi, u32, name##_lo
> +#endif
>  #define compat_arg_u64_glue(name)	(((u64)name##_lo & 0xffffffffUL) | \
>  					 ((u64)name##_hi << 32))
> -#endif
> +#endif /* compat_arg_u64 */
> =20
>  /* These types are common across all compat ABIs */
>  typedef u32 compat_size_t;
> --=20
> 2.34.1

