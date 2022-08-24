Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5FC5A0430
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 00:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiHXWk3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Aug 2022 18:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiHXWkS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Aug 2022 18:40:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9782E9E4;
        Wed, 24 Aug 2022 15:40:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id q2so21750203edb.6;
        Wed, 24 Aug 2022 15:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=W+SwShFa3i3wQlIqmrJCmsnCbHpnmw83ukjZXzLki18=;
        b=Eb4hBAIjsW5NUkq4D9ve+Pz1LiMvwyaGeh0ULrOicTxhMu2Z4dXARXpNRx/f33omxV
         /ZLiFVPFl5A1DWIPcyeQB6kCMLo8rNB+5+5RvTIWLxdzqnEIdqb7iJXa8+npGXGWVyGI
         NCTOnkyKjFPLYdXStu1aioIgzIGEwxSMzmPzF4ZCGCO8sOUQlxPIfZC8kvnsKxMprURJ
         n+qWoosNhh1hclsPBO9hnPeUbfZQC7nsYVPZIbyPDWYM4VN5cMEaAO8We8L0OFQoJIlp
         QBiI0y7B0DcUx6SmzI4Du5rxp21waW57bLp2IOGoUww4ixmSm5jnzfylj9zWfhdl9Kw2
         /2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=W+SwShFa3i3wQlIqmrJCmsnCbHpnmw83ukjZXzLki18=;
        b=jHPONRSFjaAay2oXENZGoVTXCYHCdUnUauKJGKT4kDlma1S8H/cd+cdTn1SJQP4Qfy
         y/mQDsdyT2GcqmTUjaqCPlKFTfsm0Htrvl2uYMnY47k01p5AtuA8275ZAXOkL/IHmIGP
         imaOIRoznqIEvVw/w+MbNg4HbaVkboRfK46CgcLCASfEizvEmmcU5SEVUtaobuw/C4bB
         fM8UNco/9hUXoZ5udezTqKetvMikUnvH/OA9YoSpwPUJrSzoRHcbkpbyod7ybMPbbab+
         Oa3zG8bFUcFJgmK/2UgekNP3HhPIW0MyDsLU5Xu/uiytLdQGlhPfrDfSg6pvoJrTFfrB
         9THg==
X-Gm-Message-State: ACgBeo0WK9cX1WtDsNSiUj1N4QyPdUXjcLNRRzfa0XabWglZxRvTS5Dq
        EC05ScjwUvonnuERQ/MhcTI9/Bqku9pa/G+JnYk=
X-Google-Smtp-Source: AA6agR4FKu0eVIUn8G7XVv/tG0JhfwVi8NKI+LilIiBIFeoG2vrIvge5MX77xF20StzHp9O4/mepkyPBSeZ5xTzvr4Y=
X-Received: by 2002:a05:6402:28cb:b0:43b:c6d7:ef92 with SMTP id
 ef11-20020a05640228cb00b0043bc6d7ef92mr898662edb.333.1661380815411; Wed, 24
 Aug 2022 15:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210423230609.13519-1-alx.manpages@gmail.com> <20220824185505.56382-1-alx.manpages@gmail.com>
In-Reply-To: <20220824185505.56382-1-alx.manpages@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 24 Aug 2022 15:40:04 -0700
Message-ID: <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C naming
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     linux-man <linux-man@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Zack Weinberg <zackw@panix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Florian Weimer <fweimer@redhat.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 24, 2022 at 12:04 PM Alejandro Colomar
<alx.manpages@gmail.com> wrote:
>
> diff --git a/man2/bpf.2 b/man2/bpf.2
> index d05b73ec2..84d1b62e5 100644
> --- a/man2/bpf.2
> +++ b/man2/bpf.2
> @@ -169,34 +169,34 @@ commands:
>  .EX
>  union bpf_attr {
>      struct {    /* Used by BPF_MAP_CREATE */
> -        __u32         map_type;
> -        __u32         key_size;    /* size of key in bytes */
> -        __u32         value_size;  /* size of value in bytes */
> -        __u32         max_entries; /* maximum number of entries
> +        uint32_t      map_type;
> +        uint32_t      key_size;    /* size of key in bytes */
> +        uint32_t      value_size;  /* size of value in bytes */
> +        uint32_t      max_entries; /* maximum number of entries
>                                        in a map */
>      };
>
>      struct {    /* Used by BPF_MAP_*_ELEM and BPF_MAP_GET_NEXT_KEY
>                     commands */
> -        __u32         map_fd;
> +        uint32_t      map_fd;
>          __aligned_u64 key;
>          union {
>              __aligned_u64 value;
>              __aligned_u64 next_key;
>          };
> -        __u64         flags;
> +        uint64_t      flags;
>      };
>
>      struct {    /* Used by BPF_PROG_LOAD */
> -        __u32         prog_type;
> -        __u32         insn_cnt;
> +        uint32_t      prog_type;
> +        uint32_t      insn_cnt;

For the N-th time:
Nacked-by: Alexei Starovoitov <ast@kernel.org>

Please stop sending this patch.
