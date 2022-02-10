Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A2F4B0A9C
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 11:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbiBJKat (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Feb 2022 05:30:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239658AbiBJKas (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 05:30:48 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F08B92;
        Thu, 10 Feb 2022 02:30:49 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JvY1J0XpGz4xdh;
        Thu, 10 Feb 2022 21:30:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1644489045;
        bh=/j80aUQlKa/S6QbooAK3y3Gg9NwGU+PKEkWBN3ktOAM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TCawh+Udct1RMjVH8ZU19XAOaHAEWi8UE1gSqYxtxWKCdRgozgSyMUWR+VA7h+4A3
         Y2Gyi5C40KuLmrAQqF/6A+MsFAN+YhOqhEfvn2Y+2ycFiYtPbcbTshYBObJyP8KJpD
         tNOxEYpjJyuyllbretPziOS745L4qVaZMOpvP4gCycccURrg7tABnvGHCU0WMDfdnc
         pPjeHrx9ubrYDqQVG9HhvZVJg0KptHYyoMC5QExkKEF4mRtdrzhg24JzeaTF3mQcwc
         2uscyDi9MUqhI1cZoTyihNTNMY8RpFcVwAawyAl3q5b1LQ+bP6NK6OGjQFoPNiLAgA
         c4imi8H1U2f+A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 08/12] asm-generic: Refactor
 dereference_[kernel]_function_descriptor()
In-Reply-To: <93a2006a5d90292baf69cb1c34af5785da53efde.1634457599.git.christophe.leroy@csgroup.eu>
References: <cover.1634457599.git.christophe.leroy@csgroup.eu>
 <93a2006a5d90292baf69cb1c34af5785da53efde.1634457599.git.christophe.leroy@csgroup.eu>
Date:   Thu, 10 Feb 2022 21:30:43 +1100
Message-ID: <8735kr814c.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> diff --git a/kernel/extable.c b/kernel/extable.c
> index b0ea5eb0c3b4..1ef13789bea9 100644
> --- a/kernel/extable.c
> +++ b/kernel/extable.c
> @@ -159,12 +160,32 @@ int kernel_text_address(unsigned long addr)
>  }
>  
>  /*
> - * On some architectures (PPC64, IA64) function pointers
> + * On some architectures (PPC64, IA64, PARISC) function pointers
>   * are actually only tokens to some data that then holds the
>   * real function address. As a result, to find if a function
>   * pointer is part of the kernel text, we need to do some
>   * special dereferencing first.
>   */
> +#ifdef CONFIG_HAVE_FUNCTION_DESCRIPTORS
> +void *dereference_function_descriptor(void *ptr)
> +{
> +	func_desc_t *desc = ptr;
> +	void *p;
> +
> +	if (!get_kernel_nofault(p, (void *)&desc->addr))
> +		ptr = p;
> +	return ptr;
> +}

This needs an EXPORT_SYMBOL_GPL(), otherwise the build breaks after
patch 10 with CONFIG_LKDTM=m.

cheers
