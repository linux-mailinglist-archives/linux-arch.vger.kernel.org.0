Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7694E6E7A8B
	for <lists+linux-arch@lfdr.de>; Wed, 19 Apr 2023 15:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjDSNWQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Apr 2023 09:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjDSNWI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Apr 2023 09:22:08 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54FD146E4;
        Wed, 19 Apr 2023 06:22:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9308D49B;
        Wed, 19 Apr 2023 13:22:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9308D49B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1681910524; bh=0YAeHqcAGKFFwl537VM1/ZYo97kzIezojAETvuLrjxY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UQVukszqGFqFNk95ux1EedlIXN8MuCVbj+wr2FUNA3R5EZJ6OGQihVknAtGXt1S65
         McGtXn7++lAnkPdiPtwilFT0GyXMDT2dtWpSxjHH0ynZl7fJPF3lTa/XHqiYBWgAAl
         ruu2FBIbNtyzcTyiSciJf59cILYn4jDLj/8bAIQomR9quoRoPxIm0gLwgCgIze9wmp
         w7yJpqnoktH5fLc2OJ2TRNFzxnXgkOeTzIFcHVy9DHNbrIZiPPkGSZsLBq/y6wTyfl
         yeTV8Xfca5Og0b/YuUVD7Ju2Cevf7t5LOluOu9yXf463WDtJ9YXRglcXenFU+4QFFE
         Yku5unaSSjI+w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux x86 <x86@kernel.org>,
        Linux Architectures <linux-arch@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: Semantic conflict between x86 doc cleanup and CET shadow stack doc
In-Reply-To: <ZD+1XVjMvm8EvCzN@debian.me>
References: <ZD+1XVjMvm8EvCzN@debian.me>
Date:   Wed, 19 Apr 2023 07:22:03 -0600
Message-ID: <87mt34atxg.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Hi,
>
> I see semantic conflict on next-20230418 between commit ff61f0791ce969 ("docs:
> move x86 documentation into Documentation/arch/") and 54759b257eadb0
> ("Documentation/x86: Add CET shadow stack description"), which isn't noticed
> when both jc_docs and tip trees were merged. The conflict triggers Sphinx table
> of contents warnings:
>
> Documentation/arch/x86/index.rst:7: WARNING: toctree contains reference to nonexisting document 'arch/x86/shstk'
> Documentation/x86/shstk.rst: WARNING: document isn't included in any toctree
>
> The fixup for the next merge window (when Linus pull both trees) should be
> moving also CET shadow stack doc to Documentation/arch/x86/ (in line with
> ff61f0791ce969).

https://lore.kernel.org/lkml/20230331142016.0a6f8f6b%40canb.auug.org.au/

jon
